/**
* @copyright 2023 - Max Bebök
* @license MIT
*/
#include <t3d/t3d.h>
#include "rsp/rsp_tiny3d.h"
#include "rsp/rsp_t3d_material.h"
#include "rsp/t3d_page.h"
#include <rspq_profile.h>
#include <rspq_constants.h>
#include <rdpq_constants.h>

#ifndef RDPQ_WRITE_COUNT_UNKNOWN
  #define RDPQ_WRITE_COUNT_UNKNOWN -1
  #define RDPQ_WRITE_READS_OTHER_MODES -1
  #define T3D_RDPQ_NO_FROZEN_BLOCKS 1
#endif

// @TODO: temporary hack until libdragon exposes an official API
extern void __rdpq_autosync_use(uint32_t res);

static_assert((RSP_T3D_RSPQ_SCRATCH_MEM & 0xFFFF) == 0x80, "Scratch-Memory location changed!");
static_assert(RSP_T3D_BSS_TEMP_STATE_MEM_END == RSP_T3D_CLIP_BSS_TEMP_STATE_MEM_END, "Overlay data doesn't match!");
static_assert(RSP_T3D_CODE_RDPQ_Triangle_Send_Async == RSP_T3D_CODE_CLIP_RDPQ_Triangle_Send_Async, "Overlay code doesn't match!");
static_assert(RSP_T3D_CODE_RDPQ_Triangle_Send_End == RSP_T3D_CODE_CLIP_RDPQ_Triangle_Send_End, "Overlay code doesn't match!");
static_assert(RSP_T3D_CODE_RSPQCmd_RdpAppendBuffer == RSP_T3D_CODE_CLIP_RSPQCmd_RdpAppendBuffer, "Overlay code doesn't match!");

static_assert(RSP_T3D_CODE_RDPQ_Triangle_Send_Async < RSP_T3D_CODE_CLIPPING_CODE_TARGET, "Triangle functions must come before the clipping code!");
static_assert(RSP_T3D_CODE_RDPQ_Triangle_Send_End < RSP_T3D_CODE_CLIPPING_CODE_TARGET, "Triangle functions must come before the clipping code!");
static_assert(RSP_T3D_CODE_RSPQCmd_RdpAppendBuffer < RSP_T3D_CODE_CLIPPING_CODE_TARGET, "Triangle functions must come before the clipping code!");

static_assert(RSP_T3D_CODE_CLIPPING_CODE_TARGET % 8 == 0, "Clipping code must be aligned to 8 bytes!");
static_assert(RSP_T3D_CODE_CLIPPING_CODE_TARGET == RSP_T3D_CODE_CLIP_clipTriangle, "Clipping code and target must have the same address");

static_assert((RSP_T3D_BSS_CLIP_BUFFER_TMP ^ RSP_T3D_BSS_CLIP_BUFFER_RESULT) == 0x100, "Clip buffers must differ only in bit 8 (CLIP_BUFFER_XOR)");
static_assert(RSP_T3D_BSS_CLIP_BUFFER_TMP + 2 * 176 <= RSP_T3D_BSS_CLIP_BUFFER_RESULT + 7 * 36 - 4 * 36, "Second RDP slot must not reach a 4-vertex clip polygon");

// @TODO: this could be handled to allow either alignment, but it is simpler to force this for now

// the cull-flip patches sit inside the triangle code, which must never be swapped out by the clipping overlay
static_assert(RSP_T3D_CODE_TAG_CullFlipA < RSP_T3D_CODE_CLIPPING_CODE_TARGET, "Cull-Flip-A must come before the clipping code!");
static_assert(RSP_T3D_CODE_TAG_CullFlipB < RSP_T3D_CODE_CLIPPING_CODE_TARGET, "Cull-Flip-B must come before the clipping code!");

// paged IMEM window (see t3d_page.h)
static_assert(RSP_T3D_CODE_T3D_WINDOW_END % 8 == 0, "Paged window must end at an 8-byte boundary!");
static_assert(RSP_T3D_CODE_T3D_WINDOW_END - RSP_T3D_CODE_CLIPPING_CODE_TARGET == T3D_WINDOW_SIZE, "T3D_WINDOW_SIZE (t3d_page.h) must match the size of the paged window (vertex loading code)!");
static_assert(T3D_WINDOW_SIZE <= T3D_WINDOW_MAX_SIZE, "Paged window exceeds the slot size of the ucode buffer!");
static_assert(RSP_T3D_CODE_CLIP_clipTriangle == RSP_T3D_CODE_CLIPPING_CODE_TARGET, "Clipping code must start at the paged window!");
static_assert(RSP_T3D_CODE_CLIP_OVERLAY_CODE_END <= RSP_T3D_CODE_T3D_WINDOW_END, "Clipping code must fit in the paged window!");
static_assert(RSP_T3D_MAT_CODE_T3D_PAGE_CODE_START == RSP_T3D_CODE_CLIPPING_CODE_TARGET, "Material page must start at the paged window!");
static_assert(RSP_T3D_MAT_CODE__text_end <= RSP_T3D_CODE_T3D_WINDOW_END, "Material page code must fit in the paged window!");
static_assert(RSP_T3D_MAT_RDPQ_CMD_PTR == RSP_T3D_BSS_CLIP_BUFFER_TMP, "Material page data must start at the temp area of the main overlay!");
static_assert(RSP_T3D_MAT__data_end - RSP_T3D_BSS_CLIP_BUFFER_TMP <= T3D_PAGE_DATA_SIZE, "Material page data exceeds T3D_PAGE_DATA_SIZE!");
static_assert(RSP_T3D_MAT_BSS_RDPQ_CMD_STAGING + 0xB0 <= 0xA4001000, "Material page scratch data exceeds DMEM!");
static_assert(RSP_T3D_MAT_BSS_RDPQ_MODE_COMBINER_2CYC + 8 <= 0xA4001000, "Material page scratch data exceeds DMEM!");
// swapped command table entries (T3D_TABLES_DMEM): must cover all paged commands (index >= 2)
static_assert((RSP_T3D__RSPQ_OVERLAY_COMMAND_TABLE & 0xFFF) == 0x200 + RSPQ_OVERLAY_HEADER_SIZE, "Unexpected overlay command table address!");
static_assert((RSP_T3D__RSPQ_OVERLAY_COMMAND_TABLE & 0xFFF) + 2*2 >= T3D_TABLES_DMEM, "T3D_TABLES_DMEM must not cover the first two commands!");
static_assert((RSP_T3D__RSPQ_OVERLAY_COMMAND_TABLE & 0xFFF) + 2*2 < T3D_TABLES_DMEM + 8, "T3D_TABLES_DMEM must start at the 3rd command (rounded down to 8 bytes)!");
static_assert((RSP_T3D__RSPQ_OVERLAY_COMMAND_TABLE & 0xFFF) + 2*T3D_CMD_COUNT <= T3D_TABLES_DMEM + T3D_TABLES_SIZE, "The command table must end within the swapped tables!");
static_assert((RSP_T3D_STATE_MEM_START & 0xFFF) >= T3D_TABLES_DMEM + T3D_TABLES_SIZE, "The swapped tables must not overlap the saved state!");

DEFINE_RSP_UCODE(rsp_tiny3d);
DEFINE_RSP_UCODE(rsp_tiny3d_clipping);
DEFINE_RSP_UCODE(rsp_t3d_material);
uint32_t T3D_RSP_ID = 0;
uint32_t T3D_RDPQ_REDIRECT[RDPQ_FIXUP_REDIRECT_COUNT] = {0};

// RDRAM buffer with everything the ucode pages (layout in t3d_page.h)
static uint8_t *ucodeBuf = NULL;
static uint8_t *ucodeOrgCode = NULL; // original rsp_tiny3d.code / code_end, restored by t3d_destroy
static void *ucodeOrgCodeEnd = NULL;

#define MAX(a,b) (a) > (b) ? (a) : (b)
#define MIN(a,b) (a) < (b) ? (a) : (b)
#define CLAMP(x, min, max) MIN(MAX((x), (min)), (max))

#define VERT_INPUT_SIZE  16
#define VERT_OUTPUT_SIZE 36

static T3DViewport *currentViewport = NULL;
static T3DMat4FP *matrixStack = NULL;
static uint32_t ucodeBufAddr = 0; // 'UCODE_BUF_ADDR' in ucode (physical address of ucodeBuf)

static uint64_t orgInstrLightMul = 0; // backup of the 8-byte pair containing the lighting mul. instruction
static uint64_t orgInstrCullFlipA = 0; // backup
static uint64_t orgInstrCullFlipB = 0; // backup

/**
 * Points an entry of the "loaded" command table to a handler of the material page.
 * @param tables     copy of the DMEM range [T3D_TABLES_DMEM, +T3D_TABLES_SIZE)
 * @param entryDmem  DMEM address of the table entry
 * @param handler    IMEM address of the handler (from rsp_t3d_material.h)
 * @param size       size of the command in bytes (must match the resident entry)
 */
static void t3d_page_set_entry(uint16_t *tables, uint32_t entryDmem, uint32_t handler, uint32_t size)
{
  assertf(entryDmem >= T3D_TABLES_DMEM && entryDmem + 2 <= T3D_TABLES_DMEM + T3D_TABLES_SIZE,
    "paged command entry %04lX outside of the swapped tables", entryDmem);
  // same format as RSPQ_DefineCommand in rsp_queue.inc
  uint16_t desc = (uint16_t)(((handler & 0xFFF) >> 2) | ((size & 0xFC) << 8));
  uint16_t *entry = &tables[(entryDmem - T3D_TABLES_DMEM) / 2];
  assertf(*entry != 0 && (*entry & 0xFC00) == (desc & 0xFC00),
    "paged command entry %04lX: size mismatch with the resident table (%04X vs %04X)", entryDmem, *entry, desc);
  *entry = desc;
}

void t3d_init(T3DInitParams params)
{
  if(params.matrixStackSize <= 0)params.matrixStackSize = 8;

  rspq_init();
  char* state = (char*)UncachedAddr(rspq_overlay_get_state(&rsp_tiny3d));

  // Allocate matrix stack and let the ucode know where it is
  matrixStack = malloc_uncached(sizeof(T3DMat4FP) * params.matrixStackSize);

  uint32_t *stackPtr = (uint32_t*)((char*)state + ((RSP_T3D_MATRIX_STACK_PTR - RSP_T3D_STATE_MEM_START) & 0xFFFF));
  *stackPtr = (uint32_t)UncachedAddr(matrixStack);

  uint16_t *uvGenFunc = (uint16_t*)((char*)state + ((RSP_T3D_VERTEX_FX_FUNC - RSP_T3D_STATE_MEM_START) & 0xFFFF));
  *uvGenFunc = RSP_T3D_CODE_LOOP_TRAIL & 0xFFF;

  orgInstrLightMul = *(uint64_t*)(rsp_tiny3d.code + (RSP_T3D_CODE_TAG_LightMul & 0x0FF8));

  orgInstrCullFlipA = *(uint64_t*)(rsp_tiny3d.code + (RSP_T3D_CODE_TAG_CullFlipA & 0x0FF8));
  orgInstrCullFlipB = *(uint64_t*)(rsp_tiny3d.code + (RSP_T3D_CODE_TAG_CullFlipB & 0x0FF8));

  // Build the ucode buffer (see t3d_page.h). The overlay runs from the text copy in it,
  // so that T3DCmd_Patch and the window restore use the same bytes.
  const uint32_t windowOffset = RSP_T3D_CODE_CLIPPING_CODE_TARGET & 0xFFF;
  const uint32_t windowSize = RSP_T3D_CODE_T3D_WINDOW_END - RSP_T3D_CODE_CLIPPING_CODE_TARGET;
  const uint32_t codeSize = (uint8_t*)rsp_tiny3d.code_end - rsp_tiny3d.code;
  assertf(codeSize <= T3D_BUF_CLIP_OFF - T3D_BUF_TEXT_OFF, "tiny3d ucode text too large for the ucode buffer (%lu)", codeSize);

  ucodeOrgCode = rsp_tiny3d.code;
  ucodeOrgCodeEnd = rsp_tiny3d.code_end;
  ucodeBuf = malloc_uncached(T3D_BUF_SIZE);
  memset(ucodeBuf, 0, T3D_BUF_SIZE);
  memcpy(ucodeBuf + T3D_BUF_TEXT_OFF, rsp_tiny3d.code, codeSize);
  // clip / page slots are pre-filled with the window code, as they are loaded as a whole window
  memcpy(ucodeBuf + T3D_BUF_CLIP_OFF, rsp_tiny3d.code + windowOffset, windowSize);
  memcpy(ucodeBuf + T3D_BUF_CLIP_OFF, rsp_tiny3d_clipping.code + windowOffset,
    RSP_T3D_CODE_CLIP_OVERLAY_CODE_END - RSP_T3D_CODE_CLIP_clipTriangle);
  memcpy(ucodeBuf + T3D_BUF_PAGE_OFF, rsp_tiny3d.code + windowOffset, windowSize);
  memcpy(ucodeBuf + T3D_BUF_PAGE_OFF, rsp_t3d_material.code + windowOffset,
    (RSP_T3D_MAT_CODE__text_end & 0xFFF) - windowOffset);
  memcpy(ucodeBuf + T3D_BUF_CONSTS_OFF, rsp_t3d_material.data + (RSP_T3D_BSS_CLIP_BUFFER_TMP & 0xFFF),
    RSP_T3D_MAT__data_end - RSP_T3D_BSS_CLIP_BUFFER_TMP);

  // command tables: as assembled, and with the paged commands pointing into the material page
  memcpy(ucodeBuf + T3D_BUF_TABLES_OFF, rsp_tiny3d.data + T3D_TABLES_DMEM, T3D_TABLES_SIZE);
  memcpy(ucodeBuf + T3D_BUF_TABLES_PAGE_OFF, rsp_tiny3d.data + T3D_TABLES_DMEM, T3D_TABLES_SIZE);
  uint16_t *tablesPage = (uint16_t*)(ucodeBuf + T3D_BUF_TABLES_PAGE_OFF);
  const uint32_t cmdTable = RSP_T3D__RSPQ_OVERLAY_COMMAND_TABLE & 0xFFF;
  t3d_page_set_entry(tablesPage, cmdTable + T3D_CMD_SCREEN_SIZE*2, RSP_T3D_MAT_CODE_T3DCmd_SetScreenSize, 24);
  t3d_page_set_entry(tablesPage, cmdTable + T3D_CMD_DRAWFLAGS*2, RSP_T3D_MAT_CODE_T3DCmd_RenderMode, 8);
  t3d_page_set_entry(tablesPage, cmdTable + T3D_CMD_PATCH*2, RSP_T3D_MAT_CODE_T3DCmd_Patch, 16);
  // rdpq fixups (handlers of rsp_rdpq.inc, sizes as in rsp_rdpq.S)
  t3d_page_set_entry(tablesPage, cmdTable + T3D_CMD_RDPQ_COMBINE_1PASS*2, RSP_T3D_MAT_CODE_RDPQ_SetCombineMode_1Pass, 16);
  t3d_page_set_entry(tablesPage, cmdTable + T3D_CMD_RDPQ_COMBINE_2PASS*2, RSP_T3D_MAT_CODE_RDPQ_SetCombineMode_2Pass, 8);
  t3d_page_set_entry(tablesPage, cmdTable + T3D_CMD_RDPQ_BLENDING*2, RSP_T3D_MAT_CODE_RDPQ_SetBlendingMode, 8);
  t3d_page_set_entry(tablesPage, cmdTable + T3D_CMD_RDPQ_FOG*2, RSP_T3D_MAT_CODE_RDPQ_SetFogMode, 8);
  t3d_page_set_entry(tablesPage, cmdTable + T3D_CMD_RDPQ_MODIFY_SOM*2, RSP_T3D_MAT_CODE_RDPQCmd_ModifyOtherModes, 12);
  t3d_page_set_entry(tablesPage, cmdTable + T3D_CMD_RDPQ_PRIM_COLOR*2, RSP_T3D_MAT_CODE_RDPQCmd_SetPrimColorComponent, 8);
  t3d_page_set_entry(tablesPage, cmdTable + T3D_CMD_RDPQ_SCISSOR*2, RSP_T3D_MAT_CODE_RDPQCmd_SetScissorEx, 8);

  // register the overlay with the text copy in the buffer
  rsp_tiny3d.code = ucodeBuf + T3D_BUF_TEXT_OFF;
  rsp_tiny3d.code_end = ucodeBuf + T3D_BUF_TEXT_OFF + codeSize;
  ucodeBufAddr = (uint32_t)PhysicalAddr(ucodeBuf);
  uint32_t *bufAddrPtr = (uint32_t*)((char*)state + ((RSP_T3D_UCODE_BUF_ADDR - RSP_T3D_STATE_MEM_START) & 0xFFFF));
  *bufAddrPtr = ucodeBufAddr;

  T3D_RSP_ID = rspq_overlay_register(&rsp_tiny3d);

  // rdpq fixups emitted as tiny3d commands while redirected (see t3d_rdpq_redirect_begin)
  T3D_RDPQ_REDIRECT[RDPQ_CMD_SET_COMBINE_MODE_1PASS]   = RDPQ_FIXUP_REDIRECT(T3D_RSP_ID, T3D_CMD_RDPQ_COMBINE_1PASS);
  T3D_RDPQ_REDIRECT[RDPQ_CMD_SET_COMBINE_MODE_2PASS]   = RDPQ_FIXUP_REDIRECT(T3D_RSP_ID, T3D_CMD_RDPQ_COMBINE_2PASS);
  T3D_RDPQ_REDIRECT[RDPQ_CMD_SET_BLENDING_MODE]        = RDPQ_FIXUP_REDIRECT(T3D_RSP_ID, T3D_CMD_RDPQ_BLENDING);
  T3D_RDPQ_REDIRECT[RDPQ_CMD_SET_FOG_MODE]             = RDPQ_FIXUP_REDIRECT(T3D_RSP_ID, T3D_CMD_RDPQ_FOG);
  T3D_RDPQ_REDIRECT[RDPQ_CMD_MODIFY_OTHER_MODES]       = RDPQ_FIXUP_REDIRECT(T3D_RSP_ID, T3D_CMD_RDPQ_MODIFY_SOM);
  T3D_RDPQ_REDIRECT[RDPQ_CMD_SET_PRIM_COLOR_COMPONENT] = RDPQ_FIXUP_REDIRECT(T3D_RSP_ID, T3D_CMD_RDPQ_PRIM_COLOR);
  T3D_RDPQ_REDIRECT[RDPQ_CMD_SET_SCISSOR_EX]           = RDPQ_FIXUP_REDIRECT(T3D_RSP_ID, T3D_CMD_RDPQ_SCISSOR);
}

void t3d_destroy(void)
{
  rspq_overlay_unregister(T3D_RSP_ID);
  T3D_RSP_ID = 0;

  if(matrixStack)
  {
    free_uncached(matrixStack);
    matrixStack = NULL;
  }

  if(ucodeBuf)
  {
    free_uncached(ucodeBuf);
    ucodeBuf = NULL;
    rsp_tiny3d.code = ucodeOrgCode;
    rsp_tiny3d.code_end = ucodeOrgCodeEnd;
  }

  currentViewport = NULL;
}

void t3d_screen_clear_color(color_t color) {
  rdpq_clear(color);
}

void t3d_screen_clear_depth() {
  rdpq_clear_z(0xFFFC);
}

inline static void t3d_matrix_stack(void *mat, int32_t stackAdvance, bool doMultiply, bool onlyStackMove) {
  uint32_t advanceMask = (uint32_t)(stackAdvance << 8) & 0x00FFFF00;
  rspq_write(T3D_RSP_ID, T3D_CMD_MATRIX_STACK,
    advanceMask | (onlyStackMove ? 2 : 0) | (doMultiply ? 1 : 0),
    PhysicalAddr(mat)
  );
}

inline static void t3d_dmem_set_u32(uint32_t addr, uint32_t value) {
  rspq_write(T3D_RSP_ID, T3D_CMD_SET_WORD, addr, value);
}

inline static void t3d_dmem_set_u16(uint32_t addr, uint32_t value) {
  rspq_write(T3D_RSP_ID, T3D_CMD_SET_WORD, addr | 0x8000, value);
}

inline static void t3d_imem_patch(void* rdram, uint32_t opcode0, uint32_t opcode1, uint32_t imemAddr) {
  rspq_write(T3D_RSP_ID, T3D_CMD_PATCH, PhysicalAddr(rdram), opcode0, opcode1, imemAddr);
}

/// @brief Fetches the original instruction at a tag out of its backed up 8-byte pair
inline static uint32_t t3d_imem_org_instr(uint32_t tagAddr, uint64_t orgPair) {
  return (tagAddr & 4) ? (uint32_t)orgPair : (uint32_t)(orgPair >> 32);
}

/**
 * Patches a single instruction in the ucode
 */
inline static void t3d_imem_patch_instr(uint32_t tagAddr, uint64_t orgPair, uint32_t newInstr) {
  uint64_t pair = (tagAddr & 4)
    ? ((orgPair & 0xFFFF'FFFF'0000'0000ull) | newInstr)
    : (((uint64_t)newInstr << 32) | (uint32_t)orgPair);

  t3d_imem_patch(
    rsp_tiny3d.code + (tagAddr & 0x0FF8),
    (uint32_t)(pair >> 32), (uint32_t)pair,
    (tagAddr & 0x0FF8) | 0x1000
  );
}

void t3d_metrics_fetch(T3DMetrics* data)
{
  t3d_dmem_set_u32((RSP_T3D_SEGMENT_TABLE & 0xFFF) + 0, 0); // force ucode switch
  rspq_dma_to_rdram(data, (RSP_T3D_SEGMENT_TABLE & 0xFFFF) + 8, sizeof(T3DMetrics), false);
  t3d_dmem_set_u32((RSP_T3D_SEGMENT_TABLE & 0xFFF) + 8, 0); // reset counter
  t3d_dmem_set_u32((RSP_T3D_SEGMENT_TABLE & 0xFFF) + 8+4, 0); // reset counter
}

void t3d_matrix_set(const T3DMat4FP *mat, bool doMultiply) {
  t3d_matrix_stack((void*)mat, 0, doMultiply, false);
}

void t3d_matrix_push(const T3DMat4FP *mat) {
  t3d_matrix_stack((void*)mat, sizeof(T3DMat4FP), true, false);
}

void t3d_matrix_pop(int count) {
  int32_t stackAdvance = -((int)sizeof(T3DMat4FP) * count);
  t3d_matrix_stack(NULL, stackAdvance, false, false);
}

void t3d_matrix_push_pos(int count) {
  int32_t stackAdvance = sizeof(T3DMat4FP) * count;
  t3d_matrix_stack(NULL, stackAdvance, false, true);
}

void t3d_matrix_set_proj(const T3DMat4FP *mat) {
  rspq_write(T3D_RSP_ID, T3D_CMD_PROJ_SET, PhysicalAddr(mat));
}

void t3d_vert_load(const T3DVertPacked *vertices, uint32_t offset, uint32_t count) {
  uint32_t inputSize = ((count+1) & ~1) * VERT_INPUT_SIZE; // always load in pairs of 2

  // calculate where to start the DMA, this may overlap the buffer of transformed vertices
  // we have to place it so that racing the input data is possible
  constexpr uint32_t tmpBufferEnd = (
    ((RSP_T3D_BSS_TEMP_STATE_MEM_END & 0xFFFF) & ~0xF) // align to 16 bytes
    - 32 // leave space for temp data usage
  );

  static_assert((RSP_T3D_STATE_MEM_END & 0xFFFF) <= tmpBufferEnd, "Vertex buffer overlaps temporary buffer!");

  uint16_t offsetDest = tmpBufferEnd - inputSize;
  offsetDest = (offsetDest & ~0xF); // make sure it's aligned to 16 bytes, must be aligned backwards

  // DMEM address where the transformed vertices are stored
  // must be within RSP_T3D_VERT_BUFFER, alignment is not required
  uint16_t offsetInput = RSP_T3D_VERT_BUFFER & 0xFFFF;
  offsetInput += offset * VERT_OUTPUT_SIZE;

  rspq_write(T3D_RSP_ID, T3D_CMD_VERT_LOAD,
    inputSize,
    PhysicalAddr(vertices),
    (offsetDest << 16) | offsetInput
  );
}

void t3d_frame_start(void) {
  // Reset render state
  rdpq_mode_begin();
    rdpq_set_mode_standard();
    rdpq_mode_antialias(AA_STANDARD);
    rdpq_mode_zbuf(true, true);
    rdpq_mode_persp(true);

    rdpq_mode_filter(FILTER_BILINEAR);
    rdpq_mode_dithering(DITHER_SQUARE_SQUARE);

    //rdpq_mode_blender(0);
    rdpq_mode_fog(0);
  rdpq_mode_end();
}

void t3d_light_set_count(int count)
{
  #if RSPQ_PROFILE
    if(count > 2)count = 2;
  #endif
  t3d_dmem_set_u16((RSP_T3D_ACTIVE_LIGHT_SIZE & 0xFFF), (count * 16) << 8);
}

void t3d_light_set_exposure(float exposure)
{
  int16_t exp = (int16_t)(exposure * 0x80);
  t3d_dmem_set_u16((RSP_T3D_COLOR_EXPOSURE & 0xFFF), (uint32_t)exp);
}

void t3d_light_set_ambient(const uint8_t *color)
{
  rspq_write(T3D_RSP_ID, T3D_CMD_LIGHT_SET,
    (RSP_T3D_COLOR_AMBIENT & 0xFFFF), // address
    (color[0] << 24) | (color[1] << 16) | (color[2] << 8) | color[3],
    0, 0 // dir
  );
}

void t3d_light_set_directional(int index, const uint8_t *color, const T3DVec3 *dir)
{
  #if RSPQ_PROFILE
    if(index >= 2)return;
  #endif

  assertf(currentViewport, "t3d_light_set_directional needs a viewport to be attached!");
  T3DVec3 lightDirView;
  t3d_mat3_mul_vec3(&lightDirView, &currentViewport->matCamera, dir);
  t3d_vec3_norm(&lightDirView);

  uint8_t dirFP[3] = {
    (uint8_t)(int8_t)(lightDirView.v[0] * 127.0f),
    (uint8_t)(int8_t)(lightDirView.v[1] * 127.0f),
    (uint8_t)(int8_t)(lightDirView.v[2] * 127.0f),
  };

  index = (index*16) + RSP_T3D_LIGHT_DIR_COLOR;
  index &= 0xFFFF;
  uint32_t dirInt = (dirFP[0] << 24) | (dirFP[1] << 16) | (dirFP[2] << 8);

  rspq_write(T3D_RSP_ID, T3D_CMD_LIGHT_SET,
    index, // address
    (color[0] << 24) | (color[1] << 16) | (color[2] << 8) | color[3],
    dirInt, dirInt
  );
}

void t3d_light_set_point(int index, const uint8_t *color, const T3DVec3 *pos, float size, bool ignoreNormals)
{
  #if RSPQ_PROFILE
    if(index >= 2)return;
  #endif

  assertf(currentViewport, "t3d_light_set_point needs a viewport to be attached!");
  T3DVec4 posView;
  t3d_mat4_mul_vec3(&posView, &currentViewport->matCamera, pos);

  size = size * (1.0f / 0x2000);
  size = fmaxf(size, 0.0f);
  size = fminf(size, 0.5f);

  int32_t posFP[4] = {
    (int32_t)(posView.v[0] * 4.0f),
    (int32_t)(posView.v[1] * 4.0f),
    (int32_t)(posView.v[2] * 4.0f),
    (int32_t)(size * 0xFFFF)
  };

  for(int i=0; i<4; ++i) {
    posFP[i] = CLAMP(posFP[i], -0x8000, 0x7FFF);
    posFP[i] &= 0xFFFF;
  }

  if((posFP[3] & 0xFF) == 0)posFP[3] |= 1; // non-zero size is used as point-light detection
  if(ignoreNormals)posFP[3] |= 0x8000; // ignore normals

  index = (index*16) + RSP_T3D_LIGHT_DIR_COLOR;
  index &= 0xFFFF;

  rspq_write(T3D_RSP_ID, T3D_CMD_LIGHT_SET,
    index, // address
    (color[0] << 24) | (color[1] << 16) | (color[2] << 8) | color[3],
    (posFP[0] << 16) | posFP[1],
    (posFP[2] << 16) | posFP[3]
  );
}

uint16_t t3d_vert_pack_normal(const T3DVec3 *normal)
{
  T3DVec3 norm = *normal;
  t3d_vec3_norm(&norm);

  int32_t xInt = (int32_t)roundf(norm.v[0] * 15.5f);
  int32_t yInt = (int32_t)roundf(norm.v[1] * 31.5f);
  int32_t zInt = (int32_t)roundf(norm.v[2] * 15.5f);
  xInt = CLAMP(xInt, -16, 15);
  yInt = CLAMP(yInt, -32, 31);
  zInt = CLAMP(zInt, -16, 15);

  return ((uint16_t)(xInt) & 0b11111) << 11
       | ((uint16_t)(yInt) & 0b111111) << 5
       | ((uint16_t)(zInt) & 0b11111) <<  0;
}

void t3d_state_set_drawflags(enum T3DDrawFlags drawFlags)
{
  bool cullFront = drawFlags & T3D_FLAG_CULL_FRONT;
  bool cullBack = drawFlags & T3D_FLAG_CULL_BACK;

  // filter out T3D specific flags since RSPQ doesn't support them
  drawFlags &= ~(T3D_FLAG_CULL_FRONT | T3D_FLAG_CULL_BACK);

  assert(!(cullFront && cullBack));

  uint32_t cullMask;
  if(!cullFront && !cullBack) {
    cullMask = 2;
  } else if(cullFront) {
    cullMask = 1;
  } else {
    cullMask = 0;
  }

  uint32_t cmd = drawFlags | RDPQ_CMD_TRI;
  cmd = 0xC000 | (cmd << 8);

  #ifdef T3D_RDPQ_NO_FROZEN_BLOCKS
    rspq_write(T3D_RSP_ID, T3D_CMD_DRAWFLAGS, cullMask, cmd);
  #else
    rdpq_write(
      RDPQ_WRITE_READS_OTHER_MODES,
      T3D_RSP_ID, T3D_CMD_DRAWFLAGS, cullMask, cmd
    );
  #endif
}

void t3d_state_set_depth_offset(int16_t offset) {
  t3d_dmem_set_u16((RSP_T3D_SCREEN_OFFSET & 0xFFF) + 4, 0x3FFF + offset);
}

void t3d_state_set_alpha_to_tile(bool enable) {
  t3d_dmem_set_u32((RSP_T3D_UCODE_BUF_ADDR & 0xFFF),
      // store mask that will select or discard the 3 MSBs of the vertex alpha
     ucodeBufAddr | (enable ? (0b111 << (32-3)) : 0)
  );
}

void t3d_state_set_vertex_fx(enum T3DVertexFX func, int16_t arg0, int16_t arg1)
{
  uint16_t rspFunc = RSP_T3D_CODE_LOOP_TRAIL & 0xFFF;
  switch (func) {
    case T3D_VERTEX_FX_NONE:
      arg0 = 0;
      arg1 = 0;
    break;
    case T3D_VERTEX_FX_SPHERICAL_UV:
      arg0 *= 16;
      arg1 *= -16;
      rspFunc = RSP_T3D_CODE_VertexFX_Spherical & 0xFFF;
    break;
    case T3D_VERTEX_FX_CELSHADE_COLOR:
      arg0 = 0;
      arg1 = 0;
      rspFunc = RSP_T3D_CODE_VertexFX_CelShadeColor & 0xFFF;
    break;
    case T3D_VERTEX_FX_CELSHADE_ALPHA:
      arg0 = 0;
      arg1 = 0;
      rspFunc = RSP_T3D_CODE_VertexFX_CelShadeAlpha & 0xFFF;
    break;
    case T3D_VERTEX_FX_OUTLINE:
      arg1 = -arg1;
      rspFunc = RSP_T3D_CODE_VertexFX_Outline & 0xFFF;
    case T3D_VERTEX_FX_UV_OFFSET:
      // same as T3D_VERTEX_FX_NONE internally
      // for legacy reasons keep the old one
      break;

    break;
    default: break;
  }

  uint32_t args = (uint16_t)arg1;
  args |= (uint16_t)arg0 << 16;

  t3d_dmem_set_u16((RSP_T3D_VERTEX_FX_FUNC & 0xFFF), rspFunc);
  t3d_dmem_set_u32((RSP_T3D_UV_GEN_PARAMS & 0xFFF), args);
}

void t3d_state_set_vertex_fx_scale(uint16_t scale)
{
  t3d_dmem_set_u16((RSP_T3D_SCREEN_UVGEN_SCALE & 0xFFF), scale);
}

void t3d_state_set_lighting_mode(enum T3DLightingMode mode)
{
  const uint32_t OPCODE_VMULF = 0b000'000;
  const uint32_t OPCODE_VADD  = 0b010'000;
  const uint32_t OPCODE_VOR   = 0b101'010;
  uint32_t instruction = t3d_imem_org_instr(RSP_T3D_CODE_TAG_LightMul, orgInstrLightMul);
  instruction &= ~0x3F;
  switch(mode) {
    case T3D_LIGHTING_MODE_MUL:
      instruction |= OPCODE_VMULF;
      break;
    case T3D_LIGHTING_MODE_ADD:
      instruction |= OPCODE_VADD;
      break;
    case T3D_LIGHTING_MODE_REPLACE:
      // `vor color, ZERO, lightColor`; VS is bits 15..11.
      instruction = (instruction & ~(0x1F << 11)) | OPCODE_VOR;
      break;
  }

  // Now enqueue a DMA back to RDRAM to patch the ucode, one the next ucode switch this would be used.
  // Note that we can't patch it CPU side, as the RSP runs in parallel and we would patch too early.
  // This also handles the case where this is embedded in a block or queue.
  t3d_imem_patch_instr(RSP_T3D_CODE_TAG_LightMul, orgInstrLightMul, instruction);
}

void t3d_state_set_cull_invert(bool invert)
{
  // This needs two patches in 'RDPQ_Triangle_Send_Async':
  //  A: the winding test "slt   t0, t0, zero" (nz < 0) becomes the complement:
  //                      "sltiu t0, t0, 0x8000" (nz >= 0)
  //  B: the same t0 is later re-used for the left-major flag, 
  // where it gets negated with: "xori t0, 1". 
  // Since A already flipped it, this has to become a no-op.
  
  const uint32_t OPCODE_SLTIU = 0x2D08'8000; // sltiu t0, t0, 0x8000

  uint32_t orgA = t3d_imem_org_instr(RSP_T3D_CODE_TAG_CullFlipA, orgInstrCullFlipA);
  uint32_t orgB = t3d_imem_org_instr(RSP_T3D_CODE_TAG_CullFlipB, orgInstrCullFlipB);

  t3d_imem_patch_instr(RSP_T3D_CODE_TAG_CullFlipA, orgInstrCullFlipA,
    invert ? OPCODE_SLTIU : orgA
  );
  t3d_imem_patch_instr(RSP_T3D_CODE_TAG_CullFlipB, orgInstrCullFlipB,
    invert ? (orgB & ~1u) : orgB // clears the immediate, turning the `xori` into a no-op
  );
}

void t3d_segment_set(uint8_t segmentId, void *address) {
  assert(segmentId >= 1 && segmentId <= 7);
  t3d_dmem_set_u32(
    (RSP_T3D_SEGMENT_TABLE & 0xFFF) + segmentId*sizeof(uint32_t),
    (uint32_t)PhysicalAddr(address)
  );
}

void t3d_tri_draw(uint32_t v0, uint32_t v1, uint32_t v2)
{
  v0 *= VERT_OUTPUT_SIZE;
  v1 *= VERT_OUTPUT_SIZE;
  v2 *= VERT_OUTPUT_SIZE;

  v0 += RSP_T3D_VERT_BUFFER & 0xFFFF;
  v1 += RSP_T3D_VERT_BUFFER & 0xFFFF;
  v2 += RSP_T3D_VERT_BUFFER & 0xFFFF;

  __rdpq_autosync_use(AUTOSYNC_PIPE | AUTOSYNC_TILES | AUTOSYNC_TMEM(0));

  uint32_t v12 = (v1 << 16) | v2;
  rdpq_write(RDPQ_WRITE_COUNT_UNKNOWN,
    T3D_RSP_ID, T3D_CMD_TRI_DRAW,
    v0, v12
  );
}

static void t3d_tri_draw_sequence(uint32_t baseVertex, uint8_t polyCount, bool isQuad)
{
  baseVertex *= VERT_OUTPUT_SIZE;
  baseVertex += RSP_T3D_VERT_BUFFER & 0xFFFF;

  uint32_t primIndices = isQuad ? 4 : 3;

  // vertex DMEM address one past the last polygon
  uint32_t baseVertexEnd = primIndices * polyCount * VERT_OUTPUT_SIZE;
  baseVertexEnd += baseVertex;
  // increment per step (+ 3*VERT_OUTPUT_SIZE), also serves as a flag for tri vs. quad
  baseVertexEnd |= (VERT_OUTPUT_SIZE * (isQuad ? 1 : 0)) << 16;

  __rdpq_autosync_use(AUTOSYNC_PIPE | AUTOSYNC_TILES | AUTOSYNC_TMEM(0));
  rdpq_write(RDPQ_WRITE_COUNT_UNKNOWN,
    T3D_RSP_ID, T3D_CMD_TRI_SEQ, baseVertex, baseVertexEnd);
}

void t3d_tri_draw_unindexed(uint32_t baseIndex, uint32_t triCount) {
  t3d_tri_draw_sequence(baseIndex, triCount, false);
}

void t3d_quad_draw_unindexed(uint32_t baseIndex, uint32_t quadCount) {
  t3d_tri_draw_sequence(baseIndex, quadCount, true);
}

inline static void t3d_tri_draw_strip_generic(int16_t* indexBuff, int count, bool doSync)
{
  uint32_t loadAddr = (uint32_t)PhysicalAddr(indexBuff);

  uint32_t dmemAddr = (RSP_T3D_BSS_CLIP_BUFFER_TMP & 0xFFFF);
  dmemAddr -= count * 2; // 16bit indices
  dmemAddr &= ~7; // align start to 8 bytes
  dmemAddr |= (doSync ? 0x8000 : 0); // make negative if we want to sync

  __rdpq_autosync_use(AUTOSYNC_PIPE | AUTOSYNC_TILES | AUTOSYNC_TMEM(0));
  rdpq_write(RDPQ_WRITE_COUNT_UNKNOWN,
    T3D_RSP_ID, T3D_CMD_TRI_STRIP,
    loadAddr, (dmemAddr << 16) | ((count*2-1) & 0xFFFF)
  );
}

void t3d_tri_draw_strip(int16_t* indexBuff, int count)
{
  t3d_tri_draw_strip_generic(indexBuff, count, false);
}

void t3d_tri_draw_strip_and_sync(int16_t* indexBuff, int count)
{
  t3d_tri_draw_strip_generic(indexBuff, count, true);
}

void t3d_fog_set_range(float near, float far) {
  uint32_t addrScale  = RSP_T3D_SCREEN_SCALE & 0xFFF;
  uint32_t addrOffset = RSP_T3D_SCREEN_OFFSET & 0xFFF;
  if(near == 0.0f && far == 0.0f) {
    t3d_dmem_set_u16(addrScale + 6, 0);       // slope int
    t3d_dmem_set_u16(addrScale + 14, 0);      // slope fract
    t3d_dmem_set_u16(addrOffset + 6, 0x80FF); // offset: alpha 255 everywhere
    return;
  }
  assertf(currentViewport, "t3d_fog_set_range needs a viewport to be attached!");

  const T3DMat4 *proj = &currentViewport->matProj;
  float a = -proj->m[2][2];
  float b =  proj->m[3][2];
  float zNear = a * near + b;
  float zFar  = a * far  + b;

  // prevent div by zero and weird values
  float diff = zFar - zNear;
  if(fabsf(diff) < 1.5f) {
    diff = diff < 0 ? -1.5f : 1.5f;
  }
  // the offset must fit s16: it grows with zNear/(zFar-zNear), so bands that start far away
  // and are very thin get widened to the smallest representable width (keeps 'near' in place)
  float minDiff = (255.0f * fabsf(zNear) + 127.5f) / 65280.0f;
  if(fabsf(diff) < minDiff) {
    diff = diff < 0 ? -minDiff : minDiff;
  }

  float slope = -255.0f / diff;                                    // per clip-z unit
  // the ucode multiplies the integer part of the clip-space Z by the slope directly
  // (SCREEN_SCALE + 6/14), so there is no half-unit fraction left to compensate for
  float offset = -32513.0f + zNear * 255.0f / diff;
  offset = CLAMP(offset, -32768.0f, 32767.0f);

  int32_t slopeFx = (int32_t)roundf(slope * 0x10000);
  t3d_dmem_set_u16(addrScale + 6,  ((uint32_t)slopeFx >> 16) & 0xFFFF); // slope int
  t3d_dmem_set_u16(addrScale + 14, (uint32_t)slopeFx & 0xFFFF);         // slope fract
  t3d_dmem_set_u16(addrOffset + 6, (uint32_t)(int16_t)roundf(offset) & 0xFFFF);
}

void t3d_viewport_attach(T3DViewport *viewport) {
  assertf(viewport != NULL, "Viewport is NULL!");
  currentViewport = viewport;

  if(currentViewport->_normScaleW <= 0.0f) {
    currentViewport->_normScaleW = 1.0f;
  }

  // Limit draw region
  t3d_rdpq_redirect_begin();
  rdpq_set_scissor(
    viewport->offset[0], viewport->offset[1],
    viewport->offset[0] + viewport->size[0],
    viewport->offset[1] + viewport->size[1]
  );
  t3d_rdpq_redirect_end();

  uint16_t normWScale = (uint16_t)roundf(0xFFFF * fminf(currentViewport->_normScaleW, 1.0f));
  float normWScaleFloat = (float)normWScale * (1.0f / 0xFFFF);

  
  // clip-space x/y are divided by the guard-band factor in the ucode (NORM_SCALE_W lanes x/y)
  // so the clip-code test can use W as its bound, undo it here.
  int32_t guardBand = viewport->guardBandScale & 0xF;
  if(guardBand < 1)guardBand = 1;
  // the screen scale absorbs the factor and its integer part must stay in s16
  int32_t guardMax = 32767 / (4 * (viewport->size[0] > viewport->size[1] ? viewport->size[0] : viewport->size[1]));
  if(guardBand > guardMax)guardBand = guardMax < 1 ? 1 : guardMax;
  uint16_t invGuard = (guardBand == 1) ? 0xFFFF : (uint16_t)(0x10000 / guardBand);
  t3d_dmem_set_u32((RSP_T3D_NORM_SCALE_W & 0xFFF), ((uint32_t)invGuard << 16) | invGuard);

  // halved (2 instead of 4): the ucode's NR-refined 1/W is the full reciprocal,
  // twice the raw vrcp half-reciprocal
  float guardF = (float)guardBand;
  float screenFactorX = (float)viewport->size[0] * normWScaleFloat *  4.0f * guardF;
  float screenFactorY = (float)viewport->size[1] * normWScaleFloat * -4.0f * guardF;

  int32_t screenScaleX = (int32_t)roundf(screenFactorX * 0x10000);
  int32_t screenScaleY = (int32_t)roundf(screenFactorY * 0x10000);

  // Set screen size, internally the 3D-scene renders to the correct size, but at [0,0]
  // calc. both scale and offset to move/scale it into our scissor region
  int32_t screenOffsetX = (int32_t)(viewport->offset[0]*2) + viewport->size[0];
  int32_t screenOffsetY = (int32_t)(viewport->offset[1]*2) + viewport->size[1];

  int32_t screenOffset = (screenOffsetX << 17) | (screenOffsetY << 1);
  int32_t screenScale = (screenScaleX & 0xFFFF0000) | (((uint32_t)screenScaleY >> 16) & 0xFFFF); // int parts
  uint32_t screenScaleFrac = ((uint32_t)(screenScaleX & 0xFFFF) << 16) | (uint32_t)(screenScaleY & 0xFFFF);

  // normWScaleFloat <= 1, so this always fits u15.16
  // normWScaleFloat <= 1, so this always fits u15.16
  // (0.25: halved like the x/y scales for the NR full reciprocal)
  uint32_t depthScaleFx = (uint32_t)roundf(0xFFFF * normWScaleFloat * 0.5f * 0x10000);

  uint32_t depthAndWScale = (depthScaleFx & 0xFFFF0000) | normWScale; // z int + w-normalize

  /*debugf("Screen: %04X %04X | Depth: %08X W-scale: %04X\n",
    (screenScaleX & 0xFFFF), (screenScaleY & 0xFFFF),
    depthScale, normWScale
  );*/

  int32_t guardBandScale = guardBand;

  // uv-gen offset, used to skew normals based on distance to the screen center.
  // This can fake uvgen shifting based on the viewing angle.
  // The factor chosen here is arbitrary, and just needs to look good.
  uint32_t invScreenSize = (uint32_t)(1.0f / viewport->size[0] * 0x2A00) << 8;
  guardBandScale |= invScreenSize;

  rspq_write(T3D_RSP_ID, T3D_CMD_SCREEN_SIZE,
    guardBandScale, screenOffset, screenScale, depthAndWScale,
    screenScaleFrac, (depthScaleFx & 0xFFFF) << 16 // fraction words of the s16.16 scales
  );

  if(viewport->_matFP)
  {
    viewport->_bufferIdx = (viewport->_bufferIdx + 1) % viewport->_bufferCount;
    T3DMat4FP *matCam = &viewport->_matFP[viewport->_bufferIdx];
    T3DMat4FP *matProj = &viewport->_matFP[viewport->_bufferIdx + viewport->_bufferCount];

    t3d_mat4_to_fixed(matCam, &viewport->matProj);
    t3d_matrix_set_proj(matCam);

    t3d_mat4_to_fixed(matProj, &viewport->matCamera);
    t3d_matrix_set(matProj, false);
  } else
  {
    // DEPRECATED PATH, this is kept for backwards compatibility
    // since some may set the matrices directly on the viewport struct

    #pragma GCC diagnostic push
    #pragma GCC diagnostic ignored "-Wdeprecated-declarations"

    // update projection matrix
      t3d_mat4_to_fixed(&viewport->_matProjFP, &viewport->matProj);
      data_cache_hit_writeback(&viewport->_matProjFP, sizeof(T3DMat4FP));
      t3d_matrix_set_proj(&viewport->_matProjFP);

      // update camera matrix
      t3d_mat4_to_fixed(&viewport->_matCameraFP, &viewport->matCamera);
      data_cache_hit_writeback(&viewport->_matCameraFP, sizeof(T3DMat4FP));
      t3d_matrix_set(&viewport->_matCameraFP, false);

    #pragma GCC diagnostic pop
  }
}

T3DViewport *t3d_viewport_get() {
  return currentViewport;
}

void t3d_viewport_set_perspective(T3DViewport *viewport, float fov, float aspectRatio, float near, float far) {
  t3d_viewport_set_w_normalize(viewport, near, far);
  t3d_mat4_perspective(&viewport->matProj, fov, aspectRatio, near, far);
  viewport->_isCamProjDirty = true;
}

void t3d_viewport_set_projection(T3DViewport *viewport, float fov, float near, float far) {
  float aspectRatio = (float)viewport->size[0] / (float)viewport->size[1];
  t3d_viewport_set_perspective(viewport, fov, aspectRatio, near, far);
}

void t3d_viewport_set_ortho(T3DViewport *viewport, float left, float right, float bottom, float top, float near, float far) {
  t3d_viewport_set_w_normalize(viewport, near, far);
  t3d_mat4_ortho(&viewport->matProj, left, right, bottom, top, near, far);
  viewport->_isCamProjDirty = true;
}

void t3d_viewport_look_at(T3DViewport *viewport, const T3DVec3 *eye, const T3DVec3 *target, const T3DVec3 *up) {
  t3d_mat4_look_at(&viewport->matCamera, eye, target, up);

  t3d_mat4_mul(&viewport->matCamProj, &viewport->matProj, &viewport->matCamera);
  t3d_mat4_to_frustum(&viewport->viewFrustum, &viewport->matCamProj);
  viewport->_isCamProjDirty = false;
}

void t3d_viewport_set_view_matrix(T3DViewport *viewport, const T3DMat4 *mat) {
  viewport->matCamera = *mat;

  t3d_mat4_mul(&viewport->matCamProj, &viewport->matProj, &viewport->matCamera);
  t3d_mat4_to_frustum(&viewport->viewFrustum, &viewport->matCamProj);
  viewport->_isCamProjDirty = false;
}

void t3d_viewport_set_projection_matrix(T3DViewport *viewport, const T3DMat4 *mat) {
  viewport->matProj = *mat;

  t3d_mat4_mul(&viewport->matCamProj, &viewport->matProj, &viewport->matCamera);
  t3d_mat4_to_frustum(&viewport->viewFrustum, &viewport->matCamProj);
  viewport->_isCamProjDirty = false;
}

void t3d_viewport_calc_viewspace_pos(T3DViewport *viewport, T3DVec3 *out, const T3DVec3 *pos)
{
  T3DVec4 posScreen;

  viewport = viewport ? viewport : currentViewport;
  if(viewport->_isCamProjDirty) {
    t3d_mat4_mul(&viewport->matCamProj, &viewport->matProj, &viewport->matCamera);
    viewport->_isCamProjDirty = false;
  }

  t3d_mat4_mul_vec3(&posScreen, &viewport->matCamProj, pos);

  if(posScreen.v[3] == 0) {
    return; // invalid matrix, just ignore for now
  }

  out->v[0] = posScreen.v[0] / posScreen.v[3];
  out->v[1] = posScreen.v[1] / posScreen.v[3];
  out->v[2] = posScreen.v[2] / posScreen.v[3];

  out->v[0] *= viewport->size[0] / 2;
  out->v[1] *= -viewport->size[1] / 2;

  out->v[0] += viewport->size[0] / 2;
  out->v[1] += viewport->size[1] / 2;

  out->v[0] += viewport->offset[0];
  out->v[1] += viewport->offset[1];
}

void t3d_indexbuffer_convert(int16_t indices[], int count) {
  for(int i = 0; i < count; ++i) {
    int16_t idx = indices[i];
    uint16_t restartFlag = 0;
    if(idx & (1 << 15)) { // restarts a new strip
      idx = (int16_t)(idx & ~(1 << 15));
      restartFlag = 1 << 15;
    }
    if(i == count - 1) { // end of buffer marker
      restartFlag |= 1 << 14;
    }
    indices[i] = (int16_t)(
      ((idx * VERT_OUTPUT_SIZE) + (RSP_T3D_VERT_BUFFER & 0xFFFF)) | restartFlag
    );
  }
}
