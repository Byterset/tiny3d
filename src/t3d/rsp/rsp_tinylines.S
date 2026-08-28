## Auto-generated file, transpiled with RSPL
#define RSPQ_PROFILE_MANUAL_SLOT 1
#define VERT_BUFFER_COUNT 70
#define LIGHT_COUNT 7
#define LIGHT_SIZE 16
#define VTX_ATTR_XY 0x00
#define VTX_ATTR_Z 0x04
#define VTX_ATTR_CLIPFLAGS 0x06
#define VTX_ATTR_REJFLAGS 0x07
#define VTX_ATTR_RGBA 0x08
#define VTX_ATTR_ST 0x0C
#define VTX_ATTR_CLIPPOSi 0x10
#define VTX_ATTR_Wi 0x16
#define VTX_ATTR_CLIPPOSf 0x18
#define VTX_ATTR_Wf 0x1E
#define VTX_ATTR_INVWi 0x20
#define VTX_ATTR_INVWf 0x22
#define TRI_SIZE 36
#define TRI_SIZE_2 72
#define TRI_SIZE_3 108
#define LINE_CMD_SIZE 112
#define LINE_CMD_SIZE_2 224
#define LINE_CMD_SIZE_3 336
#define RDP_CMD_LINE 0x0D80'0000
#define RDP_SYNC_PIPE 0x2700'0000
#define RDP_SET_COMB_HI 0x3C88'7F10
#define RDP_SET_COMB_LO 0x88FE'793C
#define LINE_HDR_SIZE 16
#define MATRIX_TEMP_MUL RDP_BUFF
#define MATRIX_SIZE 0x40
#include <rsp_queue.inc>
#include <rsp_rdpq.inc>
#include <rdpq_macros.h>

.set noreorder
.set noat
.set nomacro

#undef zero
#undef at
#undef v0
#undef v1
#undef a0
#undef a1
#undef a2
#undef a3
#undef t0
#undef t1
#undef t2
#undef t3
#undef t4
#undef t5
#undef t6
#undef t7
#undef s0
#undef s1
#undef s2
#undef s3
#undef s4
#undef s5
#undef s6
#undef s7
#undef t8
#undef t9
#undef k0
#undef k1
#undef gp
#undef sp
#undef fp
#undef ra
.equ hex.$zero, 0
.equ hex.$at, 1
.equ hex.$v0, 2
.equ hex.$v1, 3
.equ hex.$a0, 4
.equ hex.$a1, 5
.equ hex.$a2, 6
.equ hex.$a3, 7
.equ hex.$t0, 8
.equ hex.$t1, 9
.equ hex.$t2, 10
.equ hex.$t3, 11
.equ hex.$t4, 12
.equ hex.$t5, 13
.equ hex.$t6, 14
.equ hex.$t7, 15
.equ hex.$s0, 16
.equ hex.$s1, 17
.equ hex.$s2, 18
.equ hex.$s3, 19
.equ hex.$s4, 20
.equ hex.$s5, 21
.equ hex.$s6, 22
.equ hex.$s7, 23
.equ hex.$t8, 24
.equ hex.$t9, 25
.equ hex.$k0, 26
.equ hex.$k1, 27
.equ hex.$gp, 28
.equ hex.$sp, 29
.equ hex.$fp, 30
.equ hex.$ra, 31
#define vco 0
#define vcc 1
#define vce 2

.data
  RSPQ_BeginOverlayHeader
    RSPQ_DefineCommand T3DCmd_TriDraw, 8
    RSPQ_DefineCommand T3DCmd_SetScreenSize, 16
    RSPQ_DefineCommand T3DCmd_MatrixStack, 8
    RSPQ_DefineCommand T3DCmd_SetWord, 8
    RSPQ_DefineCommand T3DCmd_VertLoad, 12
    RSPQ_DefineCommand T3DCmd_LightSet, 16
    RSPQ_DefineCommand T3DCmd_RenderMode, 8
    RSPQ_DefineCommand T3DCmd_MatProjectionSet, 4
    RSPQ_DefineCommand T3DCmd_Patch, 12
    RSPQ_DefineCommand T3DCmd_SetFogState, 4
    RSPQ_DefineCommand DMAWaitIdle, 4
    RSPQ_DefineCommand T3DCmd_TriDraw_Strip, 8
    RSPQ_DefineCommand T3DCmd_TriDraw_Seq, 8
  RSPQ_EndOverlayHeader

  RSPQ_BeginSavedState
    STATE_MEM_START:
    .align 3
    MATRIX_PROJ: .ds.b 64
    .align 3
    MATRIX_MVP: .ds.b 64
    .align 3
    MATRIX_MV: .ds.b 64
    .align 3
    LINE_COLOR_KEEP: .half 65535, 65535, 65535, 65535
    .align 1
    LINE_COLOR_SET: .half 0, 0, 0, 0
    .align 1
    LINE_WIDTH: .half 6
    .align 1
    LINE_COMB_FORCE: .half 0
    .align 1
    LINE_COMB_DIRTY: .half 0
    .align 1
    LINE_SKIP_EDGE: .half 0
    .align 1
    FOG_SCALE_OFFSET: .half 0, 0, 32767, 0
    .align 4
    SCREEN_SCALE_OFFSET: .half 0, 0, 0, 0, 0, 0, 16383, 255
    .align 4
    NORMAL_MASK_SHIFT: .half 63488, 2016, 31, 0, 1, 32, 2048, 0
    .align 3
    CLIPPING_PLANES: .byte 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 1, 1, 0, 0, -1, 0, 1, 0, -1
    .align 1
    RDPQ_TRI_BUFF_OFFSET: .half 0
    .align 1
    SCREEN_UVGEN_SCALE: .half 0
    .align 3
    NORM_SCALE_W: .half 65535, 65535, 65535, 0
    .align 1
    CLIP_RA: .half 0
    .align 1
    UV_GEN_PARAMS: .half 0, 0
    .align 1
    COLOR_EXPOSURE: .half 128
    .align 2
    SEGMENT_TABLE: .word 0, 0, 0, 0, 0, 0, 0, 0
    .align 2
    COLOR_AMBIENT: .ds.b 8
    .align 2
    LIGHT_DIR_COLOR: .ds.b 112
    .align 2
    TRI_COMMAND: .word 0
    .align 2
    MATRIX_STACK_PTR: .word 0
    FACE_CULLING: .byte 0
    FOG_STORE_OFFSET: .byte 72
    ACTIVE_LIGHT_SIZE: .byte 0
    _UNUSED_: .byte 0
    .align 1
    VERTEX_FX_FUNC: .half 0
    .align 1
    CLIP_CODE_SIZE: .half 0
    .align 2
    CLIP_CODE_ADDR: .word 0
    .align 2
    CLIP_CODE_ORG_ADDR: .word 0
    .align 3
    VERT_BUFFER: .ds.b 2520
    STATE_MEM_END:
  RSPQ_EndSavedState

.bss
  TEMP_STATE_MEM_START:
    .align 4
    RDP_BUFF: .ds.b 544
  TEMP_STATE_MEM_END:

.text
OVERLAY_CODE_START:

T3DCmd_VertLoad:
  ## hot-path cycles: 109
  srl $s6, $a1, 24                                   ## L:227  |      ^ | u32 segment = addrIn >> 24;
  andi $t0, $a0, 65535                               ## L:241  |      2 | u32<$t0> copySize = bufferSize & 0xFFFF;
  srl $s4, $a2, 16                                   ## L:239  |      3 | u32<$s4> prt3d = addressInOut >> 16;
  lw $s6, %lo(SEGMENT_TABLE)($s6)                    ## L:228  |      4 | segment = load(segment, SEGMENT_TABLE);
  or $t2, $zero, $zero                               ## L:246  |      5 | dma_in_async(prt3d, dmaAddrRDRAM, copySize);
  addu $s7, $s4, $t0                                 ## L:242  |      6 | u32 ptr3dEnd = prt3d + copySize;
  addiu $t0, $t0, -1                                 ## L:246  |      7 | dma_in_async(prt3d, dmaAddrRDRAM, copySize);
  jal DMAExec                                        ## L:246  |      8 | dma_in_async(prt3d, dmaAddrRDRAM, copySize); ## Args: $t0, $t1, $s0, $s4, $t2
  addu $s0, $a1, $s6                                 ## L:229  |    *10 | addrOut = addrIn + segment;
  ori $at, $zero, %lo(MATRIX_MVP)                    ## L:220  |     11 | mat0 = load(MATRIX_MVP, 0x00).xyzwxyzw;
  ldv $v25, 0, 16, $at                               ## L:221  |     12 | mat1 = load(MATRIX_MVP, 0x10).xyzwxyzw;
  ldv $v24, 0, 40, $at                               ## L:222  |     13 | mat2 = load(MATRIX_MVP, 0x20).xyzwxyzw;
  ldv $v28, 8, 8, $at                                ## L:220  |     14 | mat0 = load(MATRIX_MVP, 0x00).xyzwxyzw;
  lhu $s3, %lo(LINE_COMB_FORCE + 0)                  ## L:276  |     15 | u16 combDirty = load(LINE_COMB_FORCE);
  ldv $v25, 8, 16, $at                               ## L:221  |     16 | mat1 = load(MATRIX_MVP, 0x10).xyzwxyzw;
  ldv $v24, 8, 40, $at                               ## L:222  |     17 | mat2 = load(MATRIX_MVP, 0x20).xyzwxyzw;
  andi $s6, $a2, 65535                               ## L:268  |     18 | u32 ptrBuffA = addressInOut & 0xFFFF;
  ldv $v23, 0, 32, $at                               ## L:222  |     19 | mat2 = load(MATRIX_MVP, 0x20).xyzwxyzw;
  ldv $v22, 0, 56, $at                               ## L:223  |     20 | mat3 = load(MATRIX_MVP, 0x30).xyzwxyzw;
  ldv $v27, 0, 0, $at                                ## L:220  |     21 | mat0 = load(MATRIX_MVP, 0x00).xyzwxyzw;
  ldv $v23, 8, 32, $at                               ## L:222  |     22 | mat2 = load(MATRIX_MVP, 0x20).xyzwxyzw;
  ldv $v28, 0, 8, $at                                ## L:220  |     23 | mat0 = load(MATRIX_MVP, 0x00).xyzwxyzw;
  ldv $v26, 0, 24, $at                               ## L:221  |     24 | mat1 = load(MATRIX_MVP, 0x10).xyzwxyzw;
  ldv $v22, 8, 56, $at                               ## L:223  |     25 | mat3 = load(MATRIX_MVP, 0x30).xyzwxyzw;
  ldv $v21, 0, 48, $at                               ## L:223  |     26 | mat3 = load(MATRIX_MVP, 0x30).xyzwxyzw;
  ldv $v21, 8, 48, $at                               ## L:223  |     27 | mat3 = load(MATRIX_MVP, 0x30).xyzwxyzw;
  addiu $s5, $s6, 65500                              ## L:269  |     28 | u32 ptrBuffB = ptrBuffA - 36;
  addiu $s6, $s6, 65464                              ## L:270  |     29 | ptrBuffA -= 72;
  ldv $v27, 8, 0, $at                                ## L:220  |     30 | mat0 = load(MATRIX_MVP, 0x00).xyzwxyzw;
  ldv $v26, 8, 24, $at                               ## L:221  |     31 | mat1 = load(MATRIX_MVP, 0x10).xyzwxyzw;
  ori $at, $zero, %lo(CLIPPING_PLANES)               ## L:255  |     32 | vec16 guardBandScale = load(CLIPPING_PLANES).xy;
  llv $v20, 0, 0, $at                                ## L:255  |     33 | vec16 guardBandScale = load(CLIPPING_PLANES).xy;
  sh $s3, %lo(LINE_COMB_DIRTY)($zero)                ## L:277  |     34 | store(combDirty, LINE_COMB_DIRTY);
  ori $at, $zero, %lo(SCREEN_SCALE_OFFSET)           ## L:258  |     35 | vec32 screenSize:sint = load(SCREEN_SCALE_OFFSET).xyzwxyzw;
  ldv $v17, 8, 8, $at                                ## L:262  |     36 | vec16 screenOffset = load(SCREEN_SCALE_OFFSET, 0x08).xyzwxyzw;
  ldv $v18, 8, 0, $at                                ## L:258  |     37 | vec32 screenSize:sint = load(SCREEN_SCALE_OFFSET).xyzwxyzw;
  ldv $v18, 0, 0, $at                                ## L:258  |     38 | vec32 screenSize:sint = load(SCREEN_SCALE_OFFSET).xyzwxyzw;
  ldv $v17, 0, 8, $at                                ## L:262  |     39 | vec16 screenOffset = load(SCREEN_SCALE_OFFSET, 0x08).xyzwxyzw;
  ori $at, $zero, %lo(NORM_SCALE_W)                  ## L:263  |     40 | vec16 normScaleW = load(NORM_SCALE_W).xyzwxyzw;
  vor $v20, $v00, $v20.e1                            ## L:256  |      ^ | guardBandScale = guardBandScale.y;
  vmudl $v19, $v00, $v31.e7                          ## L:260  |     41 | screenSize >>= 8;
  ldv $v16, 8, 0, $at                                ## L:263  |      ^ | vec16 normScaleW = load(NORM_SCALE_W).xyzwxyzw;
  ldv $v16, 0, 0, $at                                ## L:263  |     42 | vec16 normScaleW = load(NORM_SCALE_W).xyzwxyzw;
  vmadm $v18, $v18, $v31.e7                          ## L:260  |      ^ | screenSize >>= 8;
  ori $at, $zero, %lo(LINE_COLOR_KEEP)               ## L:265  |     43 | vec16 colorKeep = load(LINE_COLOR_KEEP).xyzwxyzw;
  ldv $v15, 0, 0, $at                                ## L:265  |     44 | vec16 colorKeep = load(LINE_COLOR_KEEP).xyzwxyzw;
  ldv $v15, 8, 0, $at                                ## L:265  |     45 | vec16 colorKeep = load(LINE_COLOR_KEEP).xyzwxyzw;
  ori $at, $zero, %lo(LINE_COLOR_SET)                ## L:266  |     46 | vec16 colorSet = load(LINE_COLOR_SET).xyzwxyzw;
  vmadn $v19, $v00, $v00                             ## L:260  |      ^ | screenSize >>= 8;
  ldv $v14, 0, 0, $at                                ## L:266  |     47 | vec16 colorSet = load(LINE_COLOR_SET).xyzwxyzw;
  jal DMAWaitIdle                                    ## L:280  |     48 | dma_await();
  ldv $v14, 8, 0, $at                                ## L:266  |    *50 | vec16 colorSet = load(LINE_COLOR_SET).xyzwxyzw;
  LABEL_T3DCmd_VertLoad_0001:
  lqv $v13, 0, 0, $s4                                ## L:286  |     51 | vec16 pos = load(prt3d, 0x00);
  vmudn $v12, $v28, $v13.h0                          ## L:192  |  ***55 | out = mat0  * vec.xxxxXXXX;
  luv $v10, 0, 16, $s4                               ## L:290  |      ^ | vec16 color = load_vec_u8(prt3d, 0x10);
  addiu $s5, $s5, 72                                 ## L:284  |     56 | ptrBuffB += 72;
  vmadh $v11, $v27, $v13.h0                          ## L:192  |      ^ | out = mat0  * vec.xxxxXXXX;
  vmadn $v12, $v26, $v13.h1                          ## L:193  |     57 | out = mat1 +* vec.yyyyYYYY;
  addiu $s6, $s6, 72                                 ## L:283  |      ^ | ptrBuffA += 72;
  vmadh $v11, $v25, $v13.h1                          ## L:193  |     58 | out = mat1 +* vec.yyyyYYYY;
  vmadn $v12, $v24, $v13.h2                          ## L:194  |     59 | out = mat2 +* vec.zzzzZZZZ;
  vmadh $v11, $v23, $v13.h2                          ## L:194  |     60 | out = mat2 +* vec.zzzzZZZZ;
  vmadn $v12, $v22, $v30.e7                          ## L:195  |     61 | out = mat3 +* 1;
  vmadh $v11, $v21, $v30.e7                          ## L:195  |     62 | out = mat3 +* 1;
  vand $v10, $v10, $v15.v                            ## L:291  |     63 | color &= colorKeep;
  vor $v10, $v10, $v14.v                             ## L:292  |  ***67 | color |= colorSet;
  vmudm $v09, $v20, $v12.h3                          ## L:294  |     68 | vec32 clipPlaneW = guardBandScale * posClip.wwwwWWWW;
  vmadh $v08, $v20, $v11.h3                          ## L:294  |     69 | vec32 clipPlaneW = guardBandScale * posClip.wwwwWWWW;
  vmadn $v09, $v00, $v00                             ## L:294  |     70 | vec32 clipPlaneW = guardBandScale * posClip.wwwwWWWW;
  vch $v29, $v11, $v08                               ## L:298  |   **73 | u32 clipCodes = clip(posClip, clipPlaneW);
  vcl $v29, $v12, $v09                               ## L:298  |     74 | u32 clipCodes = clip(posClip, clipPlaneW);
  cfc2 $s1, $vcc                                     ## L:298  |     75 | u32 clipCodes = clip(posClip, clipPlaneW);
  vmudl $v12, $v12, $v16.v                           ## L:305  |      ^ | posClip *= normScaleW:ufract;
  vmadm $v11, $v11, $v16.v                           ## L:305  |     76 | posClip *= normScaleW:ufract;
  vmadn $v12, $v00, $v00                             ## L:305  |     77 | posClip *= normScaleW:ufract;
  addiu $s4, $s4, 32                                 ## L:320  |      ^ | prt3d += 0x20;
  srl $s2, $s1, 4                                    ## L:299  |   **80 | clipCodeB = clipCodes >> 4;
  vrcph $v18.e3, $v11.e3                             ## L:313  |      ^ | screenSize.w = invert_half(posClip).w;
  sdv $v11, 0, 16, $s6                               ## L:310  |     81 | store(posClip.xyzw, ptrBuffA, 0x10);
  vrcpl $v19.e3, $v12.e3                             ## L:313  |      ^ | screenSize.w = invert_half(posClip).w;
  andi $s3, $s1, 775                                 ## L:213  |     82 | res = clipCode & 0b0000'0011'0000'0111;
  vrcph $v18.e3, $v11.e7                             ## L:314  |      ^ | screenSize.W = invert_half(posClip).W;
  vrcpl $v19.e7, $v12.e7                             ## L:314  |     83 | screenSize.W = invert_half(posClip).W;
  sdv $v11, 8, 16, $s5                               ## L:311  |      ^ | store(posClip.XYZW, ptrBuffB, 0x10);
  sdv $v12, 0, 24, $s6                               ## L:310  |     84 | store(posClip.xyzw, ptrBuffA, 0x10);
  vrcph $v18.e7, $v00.e7                             ## L:314  |      ^ | screenSize.W = invert_half(posClip).W;
  vmudl $v29, $v12, $v19.h3                          ## L:316  |   **87 | posClip *= screenSize.wwwwWWWW;
  sdv $v12, 8, 24, $s5                               ## L:311  |      ^ | store(posClip.XYZW, ptrBuffB, 0x10);
  vmadm $v29, $v11, $v19.h3                          ## L:316  |     88 | posClip *= screenSize.wwwwWWWW;
  srl $s0, $s3, 5                                    ## L:214  |      ^ | u32 tmp = res >> 5;
  or $s3, $s3, $s0                                   ## L:215  |     89 | res |= tmp;
  vmadn $v12, $v12, $v18.h3                          ## L:316  |      ^ | posClip *= screenSize.wwwwWWWW;
  vmadh $v11, $v11, $v18.h3                          ## L:316  |     90 | posClip *= screenSize.wwwwWWWW;
  vmudl $v29, $v12, $v19.v                           ## L:317  |   **93 | posClip *= screenSize;
  andi $s2, $s2, 775                                 ## L:213  |      ^ | res = clipCode & 0b0000'0011'0000'0111;
  vmadm $v29, $v11, $v19.v                           ## L:317  |     94 | posClip *= screenSize;
  vmadn $v12, $v12, $v18.v                           ## L:317  |     95 | posClip *= screenSize;
  srl $s0, $s2, 5                                    ## L:214  |      ^ | u32 tmp = res >> 5;
  suv $v10, 0, 8, $s6                                ## L:307  |     96 | @Barrier("color") store_vec_u8(color.x, ptrBuffA, 0x08); ## Barrier: 0x1
  vmadh $v11, $v11, $v18.v                           ## L:317  |      ^ | posClip *= screenSize;
  or $s2, $s2, $s0                                   ## L:215  |     97 | res |= tmp;
  vmadh $v11, $v17, $v30.e7                          ## L:318  |      ^ | posClip:sint = screenOffset:sint +* 1;
  suv $v10, 4, 8, $s5                                ## L:308  |     98 | @Barrier("color") store_vec_u8(color.X, ptrBuffB, 0x08); ## Barrier: 0x1
  sdv $v11, 0, 0, $s6                                ## L:322  |  **101 | @Barrier("pos-cc") store(posClip:sint.xyzw, ptrBuffA, 0x00); ## Barrier: 0x2
  sdv $v11, 8, 0, $s5                                ## L:323  |    102 | @Barrier("pos-cc") store(posClip:sint.XYZW, ptrBuffB, 0x00); ## Barrier: 0x2
  sb $s3, 6($s6)                                     ## L:324  |    103 | @Barrier("pos-cc") store(clipCodeA:u8, ptrBuffA, 0x06); ## Barrier: 0x2
  bne $s4, $s7, LABEL_T3DCmd_VertLoad_0001           ## L:325  |    104 | @Barrier("pos-cc") store(clipCodeB:u8, ptrBuffB, 0x06);
  sb $s2, 6($s5)                                     ## L:325  |   *106 | @Barrier("pos-cc") store(clipCodeB:u8, ptrBuffB, 0x06); ## Barrier: 0x2
  LABEL_T3DCmd_VertLoad_0002:
  j RSPQ_Loop                                        ## L:326  |    107 | 
  nop                                                ## L:326  |   *109 | 
emitLine:
  ## hot-path cycles: 87
  lh $t1, 2($a1)                                     ## L:360  |      ^ | s16 yB = load(ptrB, 0x02);
  lh $t0, 2($a0)                                     ## L:359  |      2 | s16 yA = load(ptrA, 0x02);
  slt $at, $t1, $t0                                  ## L:361  |    **5 | if(yA > yB) {
  beq $at, $zero, LABEL_emitLine_0003                ## L:361  |      6 | if(yA > yB) {
  nop                                                ## L:361  |     *8 | if(yA > yB) {
  xor $a0, $a0, $a1                                  ## L:362  |      9 | swap(ptrA, ptrB);
  xor $a1, $a0, $a1                                  ## L:362  |     10 | swap(ptrA, ptrB);
  xor $a0, $a0, $a1                                  ## L:362  |     11 | swap(ptrA, ptrB);
  LABEL_emitLine_0003:
  addiu $k0, $t6, 2                                  ## L:400  |     12 | s16 minRows = minWidth + 2;
  lh $t2, 2($a0)                                     ## L:372  |     13 | s16 y0 = load(ptrA, 0x02);
  luv $v04, 0, 8, $a1                                ## L:368  |     14 | vec16 colB = load_vec_u8(ptrB, 0x08);
  sra $k0, $k0, 2                                    ## L:401  |     15 | minRows >>= 2;
  lh $t3, 2($a1)                                     ## L:373  |     16 | s16 y1 = load(ptrB, 0x02);
  luv $v03, 0, 8, $a0                                ## L:367  |     17 | vec16 colA = load_vec_u8(ptrA, 0x08);
  ldv $v01, 0, 0, $a0                                ## L:365  |     18 | vec16 posA = load(ptrA, 0x00).xyzw;
  addiu $t5, $t3, 3                                  ## L:380  |     19 | s16 rowEnd = y1 + 3;
  sra $t5, $t5, 2                                    ## L:381  |     20 | rowEnd >>= 2;
  sra $t4, $t2, 2                                    ## L:379  |     21 | s16 rowStart = y0 >> 2;
  subu $t7, $t5, $t4                                 ## L:382  |     22 | s16 rowCount = rowEnd - rowStart;
  ldv $v02, 0, 0, $a1                                ## L:366  |     23 | vec16 posB = load(ptrB, 0x00).xyzw;
  slt $at, $t7, $k0                                  ## L:402  |     24 | if(rowCount < minRows) {
  vmudm $v03, $v03, $v31.e6                          ## L:369  |      ^ | colA >>= 7;
  beq $at, $zero, LABEL_emitLine_0004                ## L:402  |     25 | if(rowCount < minRows) {
  vmudm $v04, $v04, $v31.e6                          ## L:370  |    *27 | colB >>= 7;
  or $t7, $zero, $k0                                 ## L:403  |     28 | rowCount = minRows;
  LABEL_emitLine_0004:
  vsubc $v08, $v02, $v01.v                           ## L:424  |      ^ | vec16 dPosRaw = posB - posA;
  mtc2 $t7, $v05.e0                                  ## L:413  |     29 | rowVec.x = rowCount;
  ssv $v01, 4, 96, $s3                               ## L:549  |     30 | store(posA.z,         buff, 0x60);
  or $fp, $zero, $t6                                 ## L:482  |     31 | u32 halfWidth = minWidth;
  vsubc $v09, $v04, $v03.v                           ## L:425  |      ^ | vec16 dColRaw = colB - colA;
  vor $v11, $v00, $v08                               ## L:430  |     32 | dPos:sfract = dPosRaw:sfract;
  addu $sp, $t4, $t7                                 ## L:407  |      ^ | s16 yBot = rowStart + rowCount;
  sll $k1, $t4, 2                                    ## L:406  |     33 | s16 yTop = rowStart << 2;
  vmudm $v10, $v08, $v30.e6                          ## L:431  |      ^ | dPos:sint = dPosRaw >> 15;
  vrcp $v07.e0, $v05.e0                              ## L:415  |     34 | recip.x = invert_half(rowVec).x;
  sll $fp, $fp, 13                                   ## L:483  |      ^ | halfWidth <<= 13;
  sdv $v00, 0, 48, $s3                               ## L:541  |     35 | store(VZERO:sint.xyzw,   buff, 0x30);
  vmudm $v12, $v09, $v30.e6                          ## L:436  |      ^ | dCol:sint = dColRaw >> 15;
  vrcph $v06.e0, $v05.e0                             ## L:415  |     36 | recip.x = invert_half(rowVec).x;
  sll $sp, $sp, 2                                    ## L:408  |      ^ | yBot <<= 2;
  sdv $v00, 0, 40, $s3                               ## L:540  |     37 | store(VZERO:sint.xyzw,   buff, 0x28);
  vor $v13, $v00, $v09                               ## L:435  |      ^ | dCol:sfract = dColRaw:sfract;
  sdv $v00, 0, 56, $s3                               ## L:542  |     38 | store(VZERO:sint.xyzw,   buff, 0x38);
  vmudl $v29, $v11, $v07.e0                          ## L:439  |      ^ | vec32 sPos = dPos * recip.x;
  addiu $s3, $s3, 112                                ## L:557  |     39 | buff += 112;
  vmadm $v29, $v10, $v07.e0                          ## L:439  |      ^ | vec32 sPos = dPos * recip.x;
  vmadn $v09, $v11, $v06.e0                          ## L:439  |     40 | vec32 sPos = dPos * recip.x;
  andi $s0, $sp, 16383                               ## L:512  |      ^ | u32 cmdYL = yBot & 0x3FFF;
  vmadh $v08, $v10, $v06.e0                          ## L:439  |     41 | vec32 sPos = dPos * recip.x;
  vmudl $v29, $v13, $v07.e0                          ## L:441  |     42 | vec32 sCol = dCol * recip.x;
  sh $zero, -14($s3)                                 ## L:550  |      ^ | store(ZERO:u16,       buff, 0x62);
  vmadm $v29, $v12, $v07.e0                          ## L:441  |     43 | vec32 sCol = dCol * recip.x;
  vmadn $v11, $v13, $v06.e0                          ## L:441  |     44 | vec32 sCol = dCol * recip.x;
  vmadh $v10, $v12, $v06.e0                          ## L:441  |     45 | vec32 sCol = dCol * recip.x;
  vmudl $v07, $v09, $v31.e0                          ## L:445  |     46 | vec32 slope = sPos >> 1;
  vmadm $v06, $v08, $v31.e0                          ## L:445  |     47 | vec32 slope = sPos >> 1;
  vmadn $v07, $v00, $v00                             ## L:445  |     48 | vec32 slope = sPos >> 1;
  srl $at, $fp, 16                                   ## L:484  |      ^ | halfW.x = halfWidth;
  sw $zero, -12($s3)                                 ## L:551  |     49 | store(ZERO,           buff, 0x64);
  vmudl $v12, $v09, $v30.e6                          ## L:447  |      ^ | vec32 dZdy  = sPos << 1;
  vmadn $v12, $v08, $v30.e6                          ## L:447  |     50 | vec32 dZdy  = sPos << 1;
  vmudn $v13, $v09, $v30.e6                          ## L:447  |     51 | vec32 dZdy  = sPos << 1;
  ssv $v06, 0, -92, $s3                              ## L:528  |      ^ | store(slope:sint.x,   buff, 0x14);
  vmudl $v08, $v11, $v30.e6                          ## L:449  |     52 | vec32 dCdy  = sCol << 1;
  ssv $v07, 0, -82, $s3                              ## L:534  |      ^ | store(slope:ufract.x, buff, 0x1E);
  ssv $v06, 0, -84, $s3                              ## L:533  |     53 | store(slope:sint.x,   buff, 0x1C);
  vmadn $v08, $v10, $v30.e6                          ## L:449  |      ^ | vec32 dCdy  = sCol << 1;
  vmudn $v09, $v11, $v30.e6                          ## L:449  |     54 | vec32 dCdy  = sCol << 1;
  ssv $v07, 0, -90, $s3                              ## L:529  |      ^ | store(slope:ufract.x, buff, 0x16);
  vmudl $v17, $v07, $v31.e1                          ## L:471  |     55 | vec32 step = slope >> 2;
  vmadm $v16, $v06, $v31.e1                          ## L:471  |     56 | vec32 step = slope >> 2;
  ssv $v06, 0, -100, $s3                             ## L:523  |      ^ | store(slope:sint.x,   buff, 0x0C);
  vmadn $v17, $v00, $v00                             ## L:471  |     57 | vec32 step = slope >> 2;
  sdv $v08, 0, -40, $s3                              ## L:544  |      ^ | store(dCdy:sint.xyzw,    buff, 0x48);
  sdv $v03, 0, -80, $s3                              ## L:539  |     58 | store(colA.xyzw,         buff, 0x20);
  vmudm $v02, $v06, $v30.e6                          ## L:475  |      ^ | vec16 signMask = slope:sint >> 15;
  vmudm $v22, $v01, $v31.e1                          ## L:494  |     59 | xPx:sint = posA >> 2;
  ssv $v12, 4, -8, $s3                               ## L:552  |      ^ | store(dZdy:sint.z,    buff, 0x68);
  sdv $v08, 0, -48, $s3                              ## L:543  |     60 | store(dCdy:sint.xyzw,    buff, 0x40);
  vmudn $v23, $v01, $v31.e1                          ## L:495  |      ^ | xPx:sfract = posA << 14;
  ssv $v07, 0, -98, $s3                              ## L:524  |    *62 | store(slope:ufract.x, buff, 0x0E);
  vand $v11, $v17, $v02.v                            ## L:477  |      ^ | spanLo:sfract = step:sfract & signMask;
  vand $v10, $v16, $v02.v                            ## L:476  |     63 | spanLo:sint   = step:sint   & signMask;
  ssv $v12, 4, -4, $s3                               ## L:554  |      ^ | store(dZdy:sint.z,    buff, 0x6C);
  sdv $v09, 0, -32, $s3                              ## L:545  |     64 | store(dCdy:ufract.xyzw,  buff, 0x50);
  ssv $v13, 4, -2, $s3                               ## L:555  |    *66 | store(dZdy:ufract.z,  buff, 0x6E);
  vsubc $v15, $v17, $v11.v                           ## L:478  |      ^ | spanHi = step - spanLo;
  vsub $v14, $v16, $v10.v                            ## L:478  |     67 | spanHi = step - spanLo;
  ssv $v13, 4, -6, $s3                               ## L:553  |      ^ | store(dZdy:ufract.z,  buff, 0x6A);
  mtc2 $fp, $v17.e0                                  ## L:484  |     68 | halfW.x = halfWidth;
  vaddc $v19, $v23, $v11.e0                          ## L:497  |      ^ | xH = xPx + spanLo.x;
  vadd $v18, $v22, $v10.e0                           ## L:497  |     69 | xH = xPx + spanLo.x;
  mtc2 $at, $v16.e0                                  ## L:484  |      ^ | halfW.x = halfWidth;
  vsubc $v19, $v19, $v17.e0                          ## L:498  |   **72 | xH -= halfW.x;
  lui $at, 0xD80                                     ## L:513  |      ^ | cmdYL |= 0x0D80'0000;
  vsub $v18, $v18, $v16.e0                           ## L:498  |     73 | xH -= halfW.x;
  sdv $v09, 0, -24, $s3                              ## L:546  |      ^ | store(dCdy:ufract.xyzw,  buff, 0x58);
  andi $fp, $k1, 16383                               ## L:511  |     74 | u32 yTopMasked = yTop & 0x3FFF;
  vaddc $v21, $v23, $v15.e0                          ## L:499  |      ^ | xM = xPx + spanHi.x;
  vadd $v20, $v22, $v14.e0                           ## L:499  |     75 | xM = xPx + spanHi.x;
  sll $s4, $fp, 16                                   ## L:514  |      ^ | u32 cmdYM = yTopMasked << 16;
  ssv $v19, 0, -94, $s3                              ## L:527  |     76 | store(xH:ufract.x,    buff, 0x12);
  or $s4, $s4, $fp                                   ## L:515  |     77 | cmdYM |= yTopMasked;
  ssv $v18, 0, -96, $s3                              ## L:526  |     78 | store(xH:sint.x,      buff, 0x10);
  vaddc $v21, $v21, $v17.e0                          ## L:500  |      ^ | xM += halfW.x;
  or $s0, $s0, $at                                   ## L:513  |     79 | cmdYL |= 0x0D80'0000;
  vadd $v20, $v20, $v16.e0                           ## L:500  |      ^ | xM += halfW.x;
  sw $s0, -112($s3)                                  ## L:517  |     80 | store(cmdYL, buff, 0x00);
  sw $s4, -108($s3)                                  ## L:518  |     81 | store(cmdYM, buff, 0x04);
  ssv $v21, 0, -86, $s3                              ## L:532  |     82 | store(xM:ufract.x,    buff, 0x1A);
  ssv $v21, 0, -102, $s3                             ## L:522  |     83 | store(xM:ufract.x,    buff, 0x0A);
  ssv $v20, 0, -104, $s3                             ## L:521  |     84 | store(xM:sint.x,      buff, 0x08);
  jr $ra                                             ## L:558  |     85 | }
  ssv $v20, 0, -88, $s3                              ## L:531  |    *87 | store(xM:sint.x,      buff, 0x18);
emitLine2:
  ## hot-path cycles: 161
  lh $t0, 2($a0)                                     ## L:582  |      ^ | s16 yA0 = load(ptr0, 0x02);
  or $a3, $zero, $a1                                 ## L:581  |      2 | u32<$a3> pB0 = ptr1;
  lh $t1, 2($a3)                                     ## L:583  |      3 | s16 yB0 = load(pB0, 0x02);
  slt $at, $t1, $t0                                  ## L:584  |    **6 | if(yA0 > yB0) {
  beq $at, $zero, LABEL_emitLine2_0005               ## L:584  |      7 | if(yA0 > yB0) {
  nop                                                ## L:584  |     *9 | if(yA0 > yB0) {
  xor $t0, $t0, $t1                                  ## L:586  |     10 | swap(yA0, yB0);
  xor $a0, $a0, $a3                                  ## L:585  |     11 | swap(ptr0, pB0);
  xor $t1, $t0, $t1                                  ## L:586  |     12 | swap(yA0, yB0);
  xor $a3, $a0, $a3                                  ## L:585  |     13 | swap(ptr0, pB0);
  xor $a0, $a0, $a3                                  ## L:585  |     14 | swap(ptr0, pB0);
  xor $t0, $t0, $t1                                  ## L:586  |     15 | swap(yA0, yB0);
  LABEL_emitLine2_0005:
  lh $t2, 2($a1)                                     ## L:589  |     16 | s16 yA1 = load(ptr1, 0x02);
  lh $t3, 2($a2)                                     ## L:590  |     17 | s16 yB1 = load(ptr2, 0x02);
  slt $at, $t3, $t2                                  ## L:591  |   **20 | if(yA1 > yB1) {
  beq $at, $zero, LABEL_emitLine2_0006               ## L:591  |     21 | if(yA1 > yB1) {
  nop                                                ## L:591  |    *23 | if(yA1 > yB1) {
  xor $t2, $t2, $t3                                  ## L:593  |     24 | swap(yA1, yB1);
  xor $t3, $t2, $t3                                  ## L:593  |     25 | swap(yA1, yB1);
  xor $a1, $a1, $a2                                  ## L:592  |     26 | swap(ptr1, ptr2);
  xor $a2, $a1, $a2                                  ## L:592  |     27 | swap(ptr1, ptr2);
  xor $a1, $a1, $a2                                  ## L:592  |     28 | swap(ptr1, ptr2);
  xor $t2, $t2, $t3                                  ## L:593  |     29 | swap(yA1, yB1);
  LABEL_emitLine2_0006:
  luv $v03, 0, 8, $a0                                ## L:606  |     30 | vec16 colA0 = load_vec_u8(ptr0, 0x08);
  addiu $t5, $t6, 2                                  ## L:626  |     31 | s16 minRows = minWidth + 2;
  addiu $k0, $t1, 3                                  ## L:632  |     32 | s16 rowCount = yB0 + 3;
  sra $t7, $t0, 2                                    ## L:631  |     33 | s16 rowStart = yA0 >> 2;
  ldv $v02, 0, 0, $a3                                ## L:601  |     34 | posB.xyzw = load(pB0,  0x00).xyzw;
  sra $t5, $t5, 2                                    ## L:627  |     35 | minRows >>= 2;
  luv $v05, 0, 8, $a1                                ## L:608  |     36 | vec16 colA1 = load_vec_u8(ptr1, 0x08);
  ldv $v01, 0, 0, $a0                                ## L:598  |     37 | posA.xyzw = load(ptr0, 0x00).xyzw;
  luv $v04, 0, 8, $a3                                ## L:607  |     38 | vec16 colB0 = load_vec_u8(pB0,  0x08);
  luv $v06, 0, 8, $a2                                ## L:609  |     39 | vec16 colB1 = load_vec_u8(ptr2, 0x08);
  or $t4, $zero, $s3                                 ## L:620  |     40 | u16 buff2 = buff;
  ldv $v01, 8, 0, $a1                                ## L:599  |     41 | posA.XYZW = load(ptr1, 0x00).xyzw;
  vmudm $v05, $v05, $v31.e6                          ## L:612  |      ^ | colA1 >>= 7;
  vmudm $v04, $v04, $v31.e6                          ## L:611  |     42 | colB0 >>= 7;
  sra $k0, $k0, 2                                    ## L:633  |      ^ | rowCount >>= 2;
  vmudm $v03, $v03, $v31.e6                          ## L:610  |     43 | colA0 >>= 7;
  subu $k0, $k0, $t7                                 ## L:634  |      ^ | rowCount -= rowStart;
  slt $at, $k0, $t5                                  ## L:635  |     44 | if(rowCount < minRows) {
  vmudm $v06, $v06, $v31.e6                          ## L:613  |      ^ | colB1 >>= 7;
  addiu $t4, $t4, 112                                ## L:621  |     45 | buff2 += 112;
  beq $at, $zero, LABEL_emitLine2_0007               ## L:635  |     46 | if(rowCount < minRows) {
  ldv $v02, 8, 0, $a2                                ## L:602  |    *48 | posB.XYZW = load(ptr2, 0x00).xyzw;
  or $k0, $zero, $t5                                 ## L:636  |     49 | rowCount = minRows;
  LABEL_emitLine2_0007:
  addu $sp, $t7, $k0                                 ## L:641  |     50 | s16 yBot = rowStart + rowCount;
  addiu $t1, $t3, 3                                  ## L:656  |     51 | s16 rowCount = yB1 + 3;
  lui $at, 0xD80                                     ## L:645  |     52 | cmdYL |= 0x0D80'0000;
  sll $sp, $sp, 2                                    ## L:642  |     53 | yBot <<= 2;
  sll $k1, $t7, 2                                    ## L:640  |     54 | s16 yTop = rowStart << 2;
  andi $s0, $sp, 16383                               ## L:644  |     55 | u32 cmdYL = yBot & 0x3FFF;
  andi $fp, $k1, 16383                               ## L:643  |     56 | u32 yTopMasked = yTop & 0x3FFF;
  sll $s4, $fp, 16                                   ## L:646  |     57 | u32 cmdYM = yTopMasked << 16;
  sra $t1, $t1, 2                                    ## L:657  |     58 | rowCount >>= 2;
  or $s0, $s0, $at                                   ## L:645  |     59 | cmdYL |= 0x0D80'0000;
  mtc2 $k0, $v07.e0                                  ## L:638  |     60 | rowVec.x = rowCount;
  sw $s0, 0($s3)                                     ## L:648  |     61 | store(cmdYL, buff, 0x00);
  sra $t0, $t2, 2                                    ## L:655  |     62 | s16 rowStart = yA1 >> 2;
  subu $t1, $t1, $t0                                 ## L:658  |     63 | rowCount -= rowStart;
  or $s4, $s4, $fp                                   ## L:647  |     64 | cmdYM |= yTopMasked;
  slt $at, $t1, $t5                                  ## L:659  |     65 | if(rowCount < minRows) {
  beq $at, $zero, LABEL_emitLine2_0008               ## L:659  |     66 | if(rowCount < minRows) {
  sw $s4, 4($s3)                                     ## L:649  |    *68 | store(cmdYM, buff, 0x04);
  or $t1, $zero, $t5                                 ## L:660  |     69 | rowCount = minRows;
  LABEL_emitLine2_0008:
  vrcp $v09.e0, $v07.e0                              ## L:683  |      ^ | recip.x = invert_half(rowVec).x;
  vrcph $v08.e0, $v07.e0                             ## L:683  |     70 | recip.x = invert_half(rowVec).x;
  mtc2 $t1, $v07.e4                                  ## L:662  |      ^ | rowVec.X = rowCount;
  sdv $v00, 0, 48, $s3                               ## L:779  |     71 | store(VZERO:sint.xyzw,   buff, 0x30);
  sdv $v00, 0, 56, $s3                               ## L:780  |   **74 | store(VZERO:sint.xyzw,   buff, 0x38);
  vrcp $v09.e4, $v07.e4                              ## L:684  |      ^ | recip.X = invert_half(rowVec).X;
  vrcph $v08.e4, $v07.e4                             ## L:684  |     75 | recip.X = invert_half(rowVec).X;
  sll $t7, $t0, 2                                    ## L:664  |      ^ | s16 yTop = rowStart << 2;
  vsubc $v07, $v02, $v01.v                           ## L:688  |     76 | vec16 dPosRaw = posB - posA;
  addu $k0, $t0, $t1                                 ## L:665  |      ^ | s16 yBot = rowStart + rowCount;
  vor $v11, $v00, $v07                               ## L:692  |  ***80 | dPos:sfract = dPosRaw:sfract;
  andi $k1, $t7, 16383                               ## L:667  |      ^ | u32 yTopMasked = yTop & 0x3FFF;
  vmudm $v10, $v07, $v30.e6                          ## L:693  |     81 | dPos:sint = dPosRaw >> 15;
  sdv $v00, 0, 48, $t4                               ## L:801  |      ^ | store(VZERO:sint.xyzw,   buff2, 0x30);
  vmudl $v29, $v11, $v09.h0                          ## L:696  |   **84 | vec32 sPos = dPos * recip.xxxxXXXX;
  sll $k0, $k0, 2                                    ## L:666  |      ^ | yBot <<= 2;
  or $t0, $zero, $t6                                 ## L:714  |     85 | u32 halfWidth = minWidth;
  vmadm $v29, $v10, $v09.h0                          ## L:696  |      ^ | vec32 sPos = dPos * recip.xxxxXXXX;
  sh $zero, 98($t4)                                  ## L:820  |     86 | store(ZERO:u16,       buff2, 0x62);
  vmadn $v13, $v11, $v08.h0                          ## L:696  |      ^ | vec32 sPos = dPos * recip.xxxxXXXX;
  vmadh $v12, $v10, $v08.h0                          ## L:696  |     87 | vec32 sPos = dPos * recip.xxxxXXXX;
  sll $fp, $k1, 16                                   ## L:670  |      ^ | u32 cmdYM = yTopMasked << 16;
  sdv $v05, 0, 32, $t4                               ## L:799  |     88 | store(colA1.xyzw,        buff2, 0x20);
  sh $zero, 98($s3)                                  ## L:812  |     89 | store(ZERO:u16,       buff, 0x62);
  andi $sp, $k0, 16383                               ## L:668  |     90 | u32 cmdYL = yBot & 0x3FFF;
  vmudl $v11, $v13, $v31.e0                          ## L:699  |      ^ | vec32 slope = sPos >> 1;
  vmadm $v10, $v12, $v31.e0                          ## L:699  |     91 | vec32 slope = sPos >> 1;
  sll $t0, $t0, 13                                   ## L:715  |      ^ | halfWidth <<= 13;
  ssv $v01, 12, 96, $t4                              ## L:819  |     92 | store(posA.Z,         buff2, 0x60);
  vmadn $v11, $v00, $v00                             ## L:699  |      ^ | vec32 slope = sPos >> 1;
  sdv $v00, 0, 40, $t4                               ## L:800  |     93 | store(VZERO:sint.xyzw,   buff2, 0x28);
  vmudl $v14, $v13, $v30.e6                          ## L:700  |      ^ | vec32 dZdy  = sPos << 1;
  lui $at, 0xD80                                     ## L:669  |     94 | cmdYL |= 0x0D80'0000;
  vmadn $v14, $v12, $v30.e6                          ## L:700  |      ^ | vec32 dZdy  = sPos << 1;
  vmudn $v15, $v13, $v30.e6                          ## L:700  |     95 | vec32 dZdy  = sPos << 1;
  ssv $v10, 8, 20, $t4                               ## L:755  |      ^ | store(slope:sint.X,   buff2, 0x14);
  vmudl $v19, $v11, $v31.e1                          ## L:706  |     96 | vec32 step = slope >> 2;
  ssv $v10, 0, 20, $s3                               ## L:742  |      ^ | store(slope:sint.x,   buff, 0x14);
  vmadm $v18, $v10, $v31.e1                          ## L:706  |     97 | vec32 step = slope >> 2;
  or $fp, $fp, $k1                                   ## L:671  |      ^ | cmdYM |= yTopMasked;
  vmadn $v19, $v00, $v00                             ## L:706  |     98 | vec32 step = slope >> 2;
  ssv $v11, 0, 14, $s3                               ## L:739  |      ^ | store(slope:ufract.x, buff, 0x0E);
  or $sp, $sp, $at                                   ## L:669  |     99 | cmdYL |= 0x0D80'0000;
  vmudm $v02, $v10, $v30.e6                          ## L:707  |      ^ | vec16 signMask = slope:sint >> 15;
  sw $fp, 4($t4)                                     ## L:673  |    100 | store(cmdYM, buff2, 0x04);
  srl $at, $t0, 16                                   ## L:716  |    101 | halfW.x = halfWidth;
  vmudm $v24, $v01, $v31.e1                          ## L:723  |      ^ | xPx:sint = posA >> 2;
  vmudn $v25, $v01, $v31.e1                          ## L:724  |    102 | xPx:sfract = posA << 14;
  ssv $v10, 8, 12, $t4                               ## L:751  |      ^ | store(slope:sint.X,   buff2, 0x0C);
  ssv $v14, 12, 104, $t4                             ## L:822  |    103 | store(dZdy:sint.Z,    buff2, 0x68);
  vand $v13, $v19, $v02.v                            ## L:709  |      ^ | spanLo:sfract = step:sfract & signMask;
  vand $v12, $v18, $v02.v                            ## L:708  |    104 | spanLo:sint   = step:sint   & signMask;
  ssv $v11, 8, 30, $t4                               ## L:760  |      ^ | store(slope:ufract.X, buff2, 0x1E);
  vsubc $v17, $v19, $v13.v                           ## L:710  |  **107 | spanHi = step - spanLo;
  ssv $v10, 8, 28, $t4                               ## L:759  |      ^ | store(slope:sint.X,   buff2, 0x1C);
  vsub $v16, $v18, $v12.v                            ## L:710  |    108 | spanHi = step - spanLo;
  ssv $v11, 0, 30, $s3                               ## L:747  |      ^ | store(slope:ufract.x, buff, 0x1E);
  vaddc $v21, $v25, $v13.h0                          ## L:726  |    109 | xH = xPx + spanLo.xxxxXXXX;
  mtc2 $t0, $v19.e0                                  ## L:716  |      ^ | halfW.x = halfWidth;
  vadd $v20, $v24, $v12.h0                           ## L:726  |    110 | xH = xPx + spanLo.xxxxXXXX;
  mtc2 $at, $v18.e0                                  ## L:716  |      ^ | halfW.x = halfWidth;
  ssv $v15, 12, 106, $t4                             ## L:823  |  **113 | store(dZdy:ufract.Z,  buff2, 0x6A);
  vsubc $v21, $v21, $v19.e0                          ## L:727  |      ^ | xH -= halfW.xxxxxxxx;
  vsub $v20, $v20, $v18.e0                           ## L:727  |    114 | xH -= halfW.xxxxxxxx;
  ssv $v11, 8, 14, $t4                               ## L:752  |      ^ | store(slope:ufract.X, buff2, 0x0E);
  vaddc $v23, $v25, $v17.h0                          ## L:728  |    115 | xM = xPx + spanHi.xxxxXXXX;
  sw $zero, 100($s3)                                 ## L:813  |      ^ | store(ZERO,           buff, 0x64);
  vadd $v22, $v24, $v16.h0                           ## L:728  |    116 | xM = xPx + spanHi.xxxxXXXX;
  ssv $v11, 0, 22, $s3                               ## L:743  |      ^ | store(slope:ufract.x, buff, 0x16);
  vaddc $v23, $v23, $v19.e0                          ## L:729  |  **119 | xM += halfW.xxxxxxxx;
  ssv $v15, 12, 110, $t4                             ## L:825  |      ^ | store(dZdy:ufract.Z,  buff2, 0x6E);
  vadd $v22, $v22, $v18.e0                           ## L:729  |    120 | xM += halfW.xxxxxxxx;
  ssv $v20, 8, 16, $t4                               ## L:753  |      ^ | store(xH:sint.X,      buff2, 0x10);
  ssv $v10, 0, 12, $s3                               ## L:738  |    121 | store(slope:sint.x,   buff, 0x0C);
  vsubc $v02, $v04, $v03.v                           ## L:767  |      ^ | vec16 dColRaw = colB0 - colA0;
  ssv $v11, 8, 22, $t4                               ## L:756  |    122 | store(slope:ufract.X, buff2, 0x16);
  ssv $v23, 0, 26, $s3                               ## L:745  |    123 | store(xM:ufract.x,    buff, 0x1A);
  ssv $v22, 0, 8, $s3                                ## L:736  |    124 | store(xM:sint.x,      buff, 0x08);
  ssv $v10, 0, 28, $s3                               ## L:746  |    125 | store(slope:sint.x,   buff, 0x1C);
  vor $v11, $v00, $v02                               ## L:770  |      ^ | dCol:sfract = dColRaw:sfract;
  ssv $v22, 0, 24, $s3                               ## L:744  |    126 | store(xM:sint.x,      buff, 0x18);
  vmudm $v10, $v02, $v30.e6                          ## L:771  |      ^ | dCol:sint = dColRaw >> 15;
  ssv $v20, 0, 16, $s3                               ## L:740  |    127 | store(xH:sint.x,      buff, 0x10);
  ssv $v23, 0, 10, $s3                               ## L:737  |    128 | store(xM:ufract.x,    buff, 0x0A);
  ssv $v21, 0, 18, $s3                               ## L:741  |    129 | store(xH:ufract.x,    buff, 0x12);
  vmudl $v29, $v11, $v09.e0                          ## L:773  |      ^ | vec32 dCdy = dCol * recip.xxxxxxxx;
  vmadm $v29, $v10, $v09.e0                          ## L:773  |    130 | vec32 dCdy = dCol * recip.xxxxxxxx;
  sdv $v03, 0, 32, $s3                               ## L:777  |      ^ | store(colA0.xyzw,        buff, 0x20);
  vmadn $v13, $v11, $v08.e0                          ## L:773  |    131 | vec32 dCdy = dCol * recip.xxxxxxxx;
  ssv $v14, 12, 108, $t4                             ## L:824  |      ^ | store(dZdy:sint.Z,    buff2, 0x6C);
  addiu $s3, $s3, 224                                ## L:827  |    132 | buff += 224;
  vmadh $v12, $v10, $v08.e0                          ## L:773  |      ^ | vec32 dCdy = dCol * recip.xxxxxxxx;
  ssv $v22, 8, 8, $t4                                ## L:749  |    133 | store(xM:sint.X,      buff2, 0x08);
  ssv $v14, 4, -116, $s3                             ## L:816  |   *135 | store(dZdy:sint.z,    buff, 0x6C);
  vmudl $v29, $v13, $v30.e6                          ## L:775  |      ^ | dCdy <<= 1;
  sw $zero, 100($t4)                                 ## L:821  |    136 | store(ZERO,           buff2, 0x64);
  vmadn $v12, $v12, $v30.e6                          ## L:775  |      ^ | dCdy <<= 1;
  ssv $v23, 8, 10, $t4                               ## L:750  |    137 | store(xM:ufract.X,    buff2, 0x0A);
  vsubc $v02, $v06, $v05.v                           ## L:789  |      ^ | vec16 dColRaw = colB1 - colA1;
  ssv $v01, 4, -128, $s3                             ## L:811  |    138 | store(posA.z,         buff, 0x60);
  vmudn $v13, $v13, $v30.e6                          ## L:775  |      ^ | dCdy <<= 1;
  ssv $v22, 8, 24, $t4                               ## L:757  |    139 | store(xM:sint.X,      buff2, 0x18);
  ssv $v15, 4, -114, $s3                             ## L:817  |   *141 | store(dZdy:ufract.z,  buff, 0x6E);
  vor $v07, $v00, $v02                               ## L:792  |      ^ | dCol:sfract = dColRaw:sfract;
  ssv $v23, 8, 26, $t4                               ## L:758  |    142 | store(xM:ufract.X,    buff2, 0x1A);
  vmudm $v06, $v02, $v30.e6                          ## L:793  |      ^ | dCol:sint = dColRaw >> 15;
  sdv $v13, 0, -136, $s3                             ## L:784  |    143 | store(dCdy:ufract.xyzw,  buff, 0x58);
  ssv $v14, 4, -120, $s3                             ## L:814  |    144 | store(dZdy:sint.z,    buff, 0x68);
  sdv $v00, 0, -184, $s3                             ## L:778  |    145 | store(VZERO:sint.xyzw,   buff, 0x28);
  vmudl $v29, $v07, $v09.e4                          ## L:795  |      ^ | vec32 dCdy = dCol * recip.XXXXXXXX;
  vmadm $v29, $v06, $v09.e4                          ## L:795  |    146 | vec32 dCdy = dCol * recip.XXXXXXXX;
  sw $sp, 0($t4)                                     ## L:672  |      ^ | store(cmdYL, buff2, 0x00);
  vmadn $v03, $v07, $v08.e4                          ## L:795  |    147 | vec32 dCdy = dCol * recip.XXXXXXXX;
  sdv $v00, 0, 56, $t4                               ## L:802  |      ^ | store(VZERO:sint.xyzw,   buff2, 0x38);
  vmadh $v02, $v06, $v08.e4                          ## L:795  |    148 | vec32 dCdy = dCol * recip.XXXXXXXX;
  ssv $v21, 8, 18, $t4                               ## L:754  |      ^ | store(xH:ufract.X,    buff2, 0x12);
  vmudl $v29, $v03, $v30.e6                          ## L:797  |  **151 | dCdy <<= 1;
  sdv $v12, 0, -160, $s3                             ## L:781  |      ^ | store(dCdy:sint.xyzw,    buff, 0x40);
  sdv $v12, 0, -152, $s3                             ## L:782  |    152 | store(dCdy:sint.xyzw,    buff, 0x48);
  vmadn $v02, $v02, $v30.e6                          ## L:797  |      ^ | dCdy <<= 1;
  vmudn $v03, $v03, $v30.e6                          ## L:797  |    153 | dCdy <<= 1;
  ssv $v15, 4, -118, $s3                             ## L:815  |      ^ | store(dZdy:ufract.z,  buff, 0x6A);
  sdv $v13, 0, -144, $s3                             ## L:783  |    154 | store(dCdy:ufract.xyzw,  buff, 0x50);
  sdv $v02, 0, 64, $t4                               ## L:803  |   *156 | store(dCdy:sint.xyzw,    buff2, 0x40);
  sdv $v03, 0, 88, $t4                               ## L:806  |    157 | store(dCdy:ufract.xyzw,  buff2, 0x58);
  sdv $v02, 0, 72, $t4                               ## L:804  |    158 | store(dCdy:sint.xyzw,    buff2, 0x48);
  jr $ra                                             ## L:828  |    159 | }
  sdv $v03, 0, 80, $t4                               ## L:805  |   *161 | store(dCdy:ufract.xyzw,  buff2, 0x50);
drawTriLines:
  ## hot-path cycles: 25
  jal DMAWaitIdle                                    ## L:843  |      ^ | dma_await();
  nop                                                ## L:843  |     *3 | dma_await();
  lhu $t0, 6($s1)                                    ## L:857  |      4 | u16 ccA = load(gV0, 0x06);
  lhu $t1, 6($s6)                                    ## L:858  |      5 | u16 ccB = load(gV1, 0x06);
  addiu $at, $zero, 255                              ## L:865  |      6 | if(rejCode != 0xFF)goto TRI_LINES_SKIP;
  lhu $t2, 6($s7)                                    ## L:859  |      7 | u16 ccC = load(gV2, 0x06);
  ori $s3, $zero, %lo(RDP_BUFF)                      ## L:849  |      8 | u16<$s3> buff = RDP_BUFF;
  or $t0, $t0, $t1                                   ## L:860  |      9 | ccA |= ccB;
  addiu $s3, $s3, 16                                 ## L:850  |     10 | buff += 16;
  or $t0, $t0, $t2                                   ## L:861  |     11 | ccA |= ccC;
  andi $t3, $t0, 255                                 ## L:863  |     12 | u32 rejCode = ccA & 0xFF;
  bne $t3, $at, TRI_LINES_SKIP                       ## L:865  |     13 | if(rejCode != 0xFF)goto TRI_LINES_SKIP;
  lhu $t6, %lo(LINE_WIDTH + 0)                       ## L:851  |    *15 | u16<$t6> minWidth = load(LINE_WIDTH);
  andi $t0, $t0, 7936                                ## L:869  |     16 | ccA &= 0x1F00;
  bne $t0, $zero, TRI_LINES_SKIP                     ## L:870  |     17 | if(ccA)goto TRI_LINES_SKIP;
  nop                                                ## L:870  |    *19 | if(ccA)goto TRI_LINES_SKIP;
  ori $ra, $zero, %lo(TRI_LINES_2)                   ## L:880  |     20 | RA = TRI_LINES_2;
  or $a1, $zero, $s6                                 ## L:878  |     21 | u32<$a1> edgeV1 = gV1;
  or $a0, $zero, $s1                                 ## L:877  |     22 | u32<$a0> edgeV0 = gV0;
  j emitLine2                                        ## L:881  |     23 | goto emitLine2;
  or $a2, $zero, $s7                                 ## L:879  |    *25 | u32<$a2> edgeV2 = gV2;
  TRI_LINES_2:
  lhu $t0, %lo(LINE_SKIP_EDGE + 0)                   ## L:890  |      1 | u16 skipEdge = load(LINE_SKIP_EDGE);
  bne $t0, $zero, TRI_LINES_3                        ## L:891  |    **4 | if(skipEdge != 0)goto TRI_LINES_3;
  nop                                                ## L:891  |     *6 | if(skipEdge != 0)goto TRI_LINES_3;
  or $a1, $zero, $s1                                 ## L:894  |      7 | u32<$a1> lineB = gV0;
  or $a0, $zero, $s7                                 ## L:893  |      8 | u32<$a0> lineA = gV2;
  j emitLine                                         ## L:896  |      9 | goto emitLine;
  ori $ra, $zero, %lo(TRI_LINES_3)                   ## L:895  |    *11 | RA = TRI_LINES_3;
  TRI_LINES_3:
  addiu $t0, $zero, 1                                ## L:900  |     12 | u16 didDraw = 1;
  sh $t0, %lo(LINE_SKIP_EDGE)($zero)                 ## L:901  |     13 | store(didDraw, LINE_SKIP_EDGE);
  lhu $t0, %lo(LINE_COMB_DIRTY + 0)                  ## L:910  |     14 | u16 combDirty = load(LINE_COMB_DIRTY);
  bne $t0, $zero, LABEL_drawTriLines_000C            ## L:911  |   **17 | if(combDirty == 0) {
  ori $s4, $zero, %lo(RDP_BUFF)                      ## L:908  |    *19 | u16<$s4> sendStart = RDP_BUFF;
  beq $zero, $zero, LABEL_drawTriLines_000D          ## L:912  |     20 | sendStart += 16;
  addiu $s4, $s4, 16                                 ## L:912  |    *22 | sendStart += 16;
  LABEL_drawTriLines_000C:
  lui $t2, 0x3C88                                    ## L:915  |     23 | u32 combHi = 0x3C88'7F10;
  sh $zero, %lo(LINE_COMB_DIRTY)($zero)              ## L:921  |     24 | store(ZERO:u16, LINE_COMB_DIRTY);
  lui $t3, 0x88FE                                    ## L:916  |     25 | u32 combLo = 0x88FE'793C;
  ori $t3, $t3, 0x793C                               ## L:916  |     26 | u32 combLo = 0x88FE'793C;
  sw $zero, 4($s4)                                   ## L:918  |     27 | store(ZERO,     sendStart, 0x04);
  lui $t1, 0x2700                                    ## L:914  |     28 | u32 syncPipe = 0x2700'0000;
  sw $t3, 12($s4)                                    ## L:920  |     29 | store(combLo,   sendStart, 0x0C);
  sw $t1, 0($s4)                                     ## L:917  |     30 | store(syncPipe, sendStart, 0x00);
  ori $t2, $t2, 0x7F10                               ## L:915  |     31 | u32 combHi = 0x3C88'7F10;
  sw $t2, 8($s4)                                     ## L:919  |     32 | store(combHi,   sendStart, 0x08);
  LABEL_drawTriLines_000D:
  j RDPQ_Send                                        ## L:927  |     33 | goto RDPQ_Send;
  or $ra, $zero, $v1                                 ## L:926  |    *35 | RA = gRetTri;
  TRI_LINES_SKIP:
  or $ra, $zero, $v1                                 ## L:932  |     36 | RA = gRetTri;
  j $ra                                              ## L:933  |     37 | goto RA;
  sh $zero, %lo(LINE_SKIP_EDGE)($zero)               ## L:931  |    *39 | store(ZERO:u16, LINE_SKIP_EDGE);
T3DCmd_TriDraw:
  ## hot-path cycles: 7
  ori $v1, $zero, %lo(RSPQ_Loop)                     ## L:949  |      ^ | gRetTri = RSPQ_Loop;
  sh $zero, %lo(LINE_SKIP_EDGE)($zero)               ## L:950  |      2 | store(ZERO:u16, LINE_SKIP_EDGE);
  andi $s6, $a1, 65535                               ## L:947  |      3 | gV1 = vert1 & 0xFFFF;
  andi $s1, $a0, 65535                               ## L:948  |      4 | gV0 = vert0 & 0xFFFF;
  j drawTriLines                                     ## L:951  |      5 | goto drawTriLines;
  srl $s7, $a1, 16                                   ## L:946  |     *7 | gV2 = vert1 >> 16;
T3DCmd_TriDraw_Strip:
  ## hot-path cycles: 38
  andi $t0, $a1, 65535                               ## L:962  |      ^ | u16<$t0> copySize = countDmem & 0xFFFF;
  or $s0, $zero, $a0                                 ## L:961  |      2 | u32<$s0> dmaAddrRDRAM = rdramAddr;
  sra $s4, $a1, 16                                   ## L:963  |      3 | s16<$s4> prtDmem = countDmem >> 16;
  LABEL_T3DCmd_TriDraw_Strip_000E:
  mfc0 $ra, COP0_DMA_BUSY                            ## L:966  |      4 | RA = get_dma_busy();
  bne $ra, $zero, LABEL_T3DCmd_TriDraw_Strip_000E    ## L:966  |    **7 | RA = get_dma_busy();
  nop                                                ## L:966  |     *9 | RA = get_dma_busy();
  LABEL_T3DCmd_TriDraw_Strip_000F:
  addu $t8, $s4, $t0                                 ## L:969  |     10 | gLoopEnd = prtDmem + copySize;
  or $t2, $zero, $zero                               ## L:970  |     11 | dma_in_async(prtDmem, dmaAddrRDRAM, copySize);
  jal DMAExec                                        ## L:970  |     12 | dma_in_async(prtDmem, dmaAddrRDRAM, copySize); ## Args: $t0, $t1, $s0, $s4, $t2
  addiu $t0, $t0, -1                                 ## L:970  |    *14 | dma_in_async(prtDmem, dmaAddrRDRAM, copySize);
  or $s5, $zero, $s4                                 ## L:978  |     15 | gLoopPtr = prtDmem;
  addiu $s5, $s5, 65534                              ## L:979  |     16 | gLoopPtr -= 2;
  addiu $t8, $t8, 65533                              ## L:977  |     17 | gLoopEnd -= 3;
  LABEL_T3DCmd_TriDraw_Strip_0010:
  mfc0 $ra, COP0_DMA_BUSY                            ## L:983  |     18 | RA = get_dma_busy();
  bne $ra, $zero, LABEL_T3DCmd_TriDraw_Strip_0010    ## L:983  |   **21 | RA = get_dma_busy();
  nop                                                ## L:983  |    *23 | RA = get_dma_busy();
  STRIP_LOOP_NEW:
  addiu $s5, $s5, 2                                  ## L:989  |     24 | gLoopPtr += 2;
  sh $zero, %lo(LINE_SKIP_EDGE)($zero)               ## L:988  |     25 | store(ZERO:u16, LINE_SKIP_EDGE);
  STRIP_LOOP_NEXT:
  beq $s5, $t8, RSPQ_Loop                            ## L:991  |     26 | if(gLoopPtr == gLoopEnd)goto STRIP_LOOP_END;
  nop                                                ## L:991  |    *28 | if(gLoopPtr == gLoopEnd)goto STRIP_LOOP_END;
  lh $s4, 4($s5)                                     ## L:995  |     29 | s16 idx1 = load(gLoopPtr, 4);
  addiu $s5, $s5, 2                                  ## L:998  |     30 | gLoopPtr += 2;
  lhu $s1, 0($s5)                                    ## L:993  |     31 | gV0:u16  = load(gLoopPtr, 2);
  lhu $s7, -2($s5)                                   ## L:994  |     32 | gV2:u16  = load(gLoopPtr, 0);
  bltz $s4, STRIP_LOOP_NEW                           ## L:999  |     33 | if(idx1 < 0)goto STRIP_LOOP_NEW;
  andi $s6, $s4, 65535                               ## L:996  |    *35 | gV1 = idx1 & 0xFFFF;
  j drawTriLines                                     ## L:1002 |     36 | goto drawTriLines;
  ori $v1, $zero, %lo(STRIP_LOOP_NEXT)               ## L:1001 |    *38 | gRetTri = STRIP_LOOP_NEXT;
T3DCmd_TriDraw_Seq:
  ## hot-path cycles: 15
  srl $t9, $a1, 16                                   ## L:1018 |      ^ | gLoopFlag = endIndex >> 16;
  andi $t8, $a1, 65535                               ## L:1015 |      2 | gLoopEnd = endIndex & 0xFFFF;
  andi $s5, $a0, 65535                               ## L:1016 |      3 | gLoopPtr = sizeAndIndex & 0xFFFF;
  addiu $s2, $t9, 108                                ## L:1019 |      4 | gLoopIncr = gLoopFlag + 108;
  SEQ_LOOP_NEXT:
  beq $s5, $t8, SEQ_LOOP_END                         ## L:1025 |      5 | if(gLoopPtr == gLoopEnd)goto SEQ_LOOP_END;
  nop                                                ## L:1025 |     *7 | if(gLoopPtr == gLoopEnd)goto SEQ_LOOP_END;
  sh $zero, %lo(LINE_SKIP_EDGE)($zero)               ## L:1031 |      8 | store(ZERO:u16, LINE_SKIP_EDGE);
  addiu $s6, $s5, 36                                 ## L:1027 |      9 | gV1 = gLoopPtr + 36;
  ori $v1, $zero, %lo(SEQ_LOOP_NEXT)                 ## L:1032 |     10 | gRetTri = SEQ_LOOP_NEXT;
  or $s7, $zero, $s5                                 ## L:1028 |     11 | gV2 = gLoopPtr;
  addiu $s1, $s5, 72                                 ## L:1026 |     12 | gV0 = gLoopPtr + 72;
  j drawTriLines                                     ## L:1033 |     13 | goto drawTriLines;
  addu $s5, $s5, $s2                                 ## L:1029 |    *15 | gLoopPtr += gLoopIncr;
  SEQ_LOOP_END:
  beq $t9, $zero, RSPQ_Loop                          ## L:1036 |      1 | if(gLoopFlag) {
  nop                                                ## L:1036 |     *3 | if(gLoopFlag) {
  lhu $s5, %lo(RSPQ_DMEM_BUFFER  -6)($gp)            ## L:1038 |      4 | gLoopPtr:u16 = load_arg(2);
  addiu $t8, $t8, 36                                 ## L:1040 |      5 | gLoopEnd += 36;
  or $t9, $zero, $zero                               ## L:1037 |      6 | gLoopFlag = 0;
  j SEQ_LOOP_NEXT                                    ## L:1041 |      7 | goto SEQ_LOOP_NEXT;
  addiu $s5, $s5, 36                                 ## L:1039 |     *9 | gLoopPtr += 36;
T3DCmd_SetScreenSize:
  ## hot-path cycles: 14
  srl $s7, $a0, 8                                    ## L:1061 |      ^ | u16 uvgenScaleFactor = guardBandFactor >> 8;
  sh $a3, %lo(6 + NORM_SCALE_W)($zero)               ## L:1059 |      2 | store(depthAndWScale:s16, NORM_SCALE_W, 6);
  sw $a2, %lo(0 + SCREEN_SCALE_OFFSET)($zero)        ## L:1056 |      3 | store(screenScaleXY, SCREEN_SCALE_OFFSET, 0x00);
  andi $a0, $a0, 15                                  ## L:1064 |      4 | guardBandFactor &= 0xF;
  sh $s7, %lo(SCREEN_UVGEN_SCALE)($zero)             ## L:1062 |      5 | store(uvgenScaleFactor, SCREEN_UVGEN_SCALE);
  subu $s6, $zero, $a0                               ## L:1065 |      6 | s8 guardBandFactorNeg = ZERO - guardBandFactor;
  sw $a3, %lo(4 + SCREEN_SCALE_OFFSET)($zero)        ## L:1055 |      7 | store(depthAndWScale:u32, SCREEN_SCALE_OFFSET, 0x04);
  sb $a0, %lo(7 + CLIPPING_PLANES)($zero)            ## L:1068 |      8 | store(guardBandFactor,    CLIPPING_PLANES, 7);
  sb $a0, %lo(3 + CLIPPING_PLANES)($zero)            ## L:1067 |      9 | store(guardBandFactor,    CLIPPING_PLANES, 3);
  sb $s6, %lo(15 + CLIPPING_PLANES)($zero)           ## L:1069 |     10 | store(guardBandFactorNeg, CLIPPING_PLANES, 15);
  sw $a1, %lo(8 + SCREEN_SCALE_OFFSET)($zero)        ## L:1057 |     11 | store(screenOffsetXY, SCREEN_SCALE_OFFSET, 0x08);
  j RSPQ_Loop                                        ## L:1071 |     12 | }
  sb $s6, %lo(19 + CLIPPING_PLANES)($zero)           ## L:1070 |    *14 | store(guardBandFactorNeg, CLIPPING_PLANES, 19);
mulMat4Mat4:
  ## hot-path cycles: 50
  ldv $v02, 0, 8, $s3                                ## L:1092 |      ^ | vec32 matL0 = load(addrMatL, 0x00).xyzwxyzw;
  ldv $v10, 0, 8, $s4                                ## L:1099 |      2 | matR01.xyzw = load(addrMatR, 0x00).xyzw;
  ldv $v01, 8, 0, $s3                                ## L:1092 |      3 | vec32 matL0 = load(addrMatL, 0x00).xyzwxyzw;
  ldv $v02, 8, 8, $s3                                ## L:1092 |      4 | vec32 matL0 = load(addrMatL, 0x00).xyzwxyzw;
  ldv $v09, 8, 16, $s4                               ## L:1100 |      5 | matR01.XYZW = load(addrMatR, 0x10).xyzw;
  ldv $v10, 8, 24, $s4                               ## L:1100 |      6 | matR01.XYZW = load(addrMatR, 0x10).xyzw;
  ldv $v01, 0, 0, $s3                                ## L:1092 |      7 | vec32 matL0 = load(addrMatL, 0x00).xyzwxyzw;
  ldv $v09, 0, 0, $s4                                ## L:1099 |      8 | matR01.xyzw = load(addrMatR, 0x00).xyzw;
  ldv $v03, 8, 16, $s3                               ## L:1093 |      9 | vec32 matL1 = load(addrMatL, 0x10).xyzwxyzw;
  ldv $v04, 0, 24, $s3                               ## L:1093 |     10 | vec32 matL1 = load(addrMatL, 0x10).xyzwxyzw;
  ldv $v04, 8, 24, $s3                               ## L:1093 |     11 | vec32 matL1 = load(addrMatL, 0x10).xyzwxyzw;
  vmudl $v29, $v02, $v10.h0                          ## L:1105 |      ^ | tmp    = matL0  * matR01.xxxxXXXX;
  vmadm $v29, $v01, $v10.h0                          ## L:1105 |     12 | tmp    = matL0  * matR01.xxxxXXXX;
  ldv $v03, 0, 16, $s3                               ## L:1093 |      ^ | vec32 matL1 = load(addrMatL, 0x10).xyzwxyzw;
  ldv $v06, 0, 40, $s3                               ## L:1094 |     13 | vec32 matL2 = load(addrMatL, 0x20).xyzwxyzw;
  vmadn $v14, $v02, $v09.h0                          ## L:1105 |      ^ | tmp    = matL0  * matR01.xxxxXXXX;
  ldv $v05, 8, 32, $s3                               ## L:1094 |     14 | vec32 matL2 = load(addrMatL, 0x20).xyzwxyzw;
  vmadh $v13, $v01, $v09.h0                          ## L:1105 |      ^ | tmp    = matL0  * matR01.xxxxXXXX;
  vmadl $v29, $v04, $v10.h1                          ## L:1106 |     15 | tmp    = matL1 +* matR01.yyyyYYYY;
  ldv $v06, 8, 40, $s3                               ## L:1094 |      ^ | vec32 matL2 = load(addrMatL, 0x20).xyzwxyzw;
  ldv $v05, 0, 32, $s3                               ## L:1094 |     16 | vec32 matL2 = load(addrMatL, 0x20).xyzwxyzw;
  vmadm $v29, $v03, $v10.h1                          ## L:1106 |      ^ | tmp    = matL1 +* matR01.yyyyYYYY;
  vmadn $v14, $v04, $v09.h1                          ## L:1106 |     17 | tmp    = matL1 +* matR01.yyyyYYYY;
  ldv $v07, 8, 48, $s3                               ## L:1095 |      ^ | vec32 matL3 = load(addrMatL, 0x30).xyzwxyzw;
  ldv $v08, 8, 56, $s3                               ## L:1095 |     18 | vec32 matL3 = load(addrMatL, 0x30).xyzwxyzw;
  vmadh $v13, $v03, $v09.h1                          ## L:1106 |      ^ | tmp    = matL1 +* matR01.yyyyYYYY;
  ldv $v08, 0, 56, $s3                               ## L:1095 |     19 | vec32 matL3 = load(addrMatL, 0x30).xyzwxyzw;
  vmadl $v29, $v06, $v10.h2                          ## L:1107 |      ^ | tmp    = matL2 +* matR01.zzzzZZZZ;
  vmadm $v29, $v05, $v10.h2                          ## L:1107 |     20 | tmp    = matL2 +* matR01.zzzzZZZZ;
  ldv $v07, 0, 48, $s3                               ## L:1095 |      ^ | vec32 matL3 = load(addrMatL, 0x30).xyzwxyzw;
  ldv $v12, 0, 40, $s4                               ## L:1101 |     21 | matR23.xyzw = load(addrMatR, 0x20).xyzw;
  vmadn $v14, $v06, $v09.h2                          ## L:1107 |      ^ | tmp    = matL2 +* matR01.zzzzZZZZ;
  vmadh $v13, $v05, $v09.h2                          ## L:1107 |     22 | tmp    = matL2 +* matR01.zzzzZZZZ;
  ldv $v11, 0, 32, $s4                               ## L:1101 |      ^ | matR23.xyzw = load(addrMatR, 0x20).xyzw;
  ldv $v12, 8, 56, $s4                               ## L:1102 |     23 | matR23.XYZW = load(addrMatR, 0x30).xyzw;
  vmadl $v29, $v08, $v10.h3                          ## L:1108 |      ^ | matR01 = matL3 +* matR01.wwwwWWWW;
  ldv $v11, 8, 48, $s4                               ## L:1102 |     24 | matR23.XYZW = load(addrMatR, 0x30).xyzw;
  vmadm $v29, $v07, $v10.h3                          ## L:1108 |      ^ | matR01 = matL3 +* matR01.wwwwWWWW;
  vmadn $v10, $v08, $v09.h3                          ## L:1108 |     25 | matR01 = matL3 +* matR01.wwwwWWWW;
  vmadh $v09, $v07, $v09.h3                          ## L:1108 |     26 | matR01 = matL3 +* matR01.wwwwWWWW;
  vmudl $v29, $v02, $v12.h0                          ## L:1110 |     27 | tmp    = matL0  * matR23.xxxxXXXX;
  vmadm $v29, $v01, $v12.h0                          ## L:1110 |     28 | tmp    = matL0  * matR23.xxxxXXXX;
  vmadn $v14, $v02, $v11.h0                          ## L:1110 |     29 | tmp    = matL0  * matR23.xxxxXXXX;
  vmadh $v13, $v01, $v11.h0                          ## L:1110 |     30 | tmp    = matL0  * matR23.xxxxXXXX;
  vmadl $v29, $v04, $v12.h1                          ## L:1111 |     31 | tmp    = matL1 +* matR23.yyyyYYYY;
  vmadm $v29, $v03, $v12.h1                          ## L:1111 |     32 | tmp    = matL1 +* matR23.yyyyYYYY;
  vmadn $v14, $v04, $v11.h1                          ## L:1111 |     33 | tmp    = matL1 +* matR23.yyyyYYYY;
  vmadh $v13, $v03, $v11.h1                          ## L:1111 |     34 | tmp    = matL1 +* matR23.yyyyYYYY;
  vmadl $v29, $v06, $v12.h2                          ## L:1112 |     35 | tmp    = matL2 +* matR23.zzzzZZZZ;
  vmadm $v29, $v05, $v12.h2                          ## L:1112 |     36 | tmp    = matL2 +* matR23.zzzzZZZZ;
  vmadn $v14, $v06, $v11.h2                          ## L:1112 |     37 | tmp    = matL2 +* matR23.zzzzZZZZ;
  sdv $v09, 8, 16, $s2                               ## L:1116 |      ^ | store(matR01.XYZW, addrOut, 0x10);
  vmadh $v13, $v05, $v11.h2                          ## L:1112 |     38 | tmp    = matL2 +* matR23.zzzzZZZZ;
  sdv $v09, 0, 0, $s2                                ## L:1115 |      ^ | store(matR01.xyzw, addrOut, 0x00);
  vmadl $v29, $v08, $v12.h3                          ## L:1113 |     39 | matR23 = matL3 +* matR23.wwwwWWWW;
  vmadm $v29, $v07, $v12.h3                          ## L:1113 |     40 | matR23 = matL3 +* matR23.wwwwWWWW;
  vmadn $v12, $v08, $v11.h3                          ## L:1113 |     41 | matR23 = matL3 +* matR23.wwwwWWWW;
  sdv $v10, 8, 24, $s2                               ## L:1116 |      ^ | store(matR01.XYZW, addrOut, 0x10);
  sdv $v10, 0, 8, $s2                                ## L:1115 |     42 | store(matR01.xyzw, addrOut, 0x00);
  vmadh $v11, $v07, $v11.h3                          ## L:1113 |      ^ | matR23 = matL3 +* matR23.wwwwWWWW;
  sdv $v12, 0, 40, $s2                               ## L:1117 |   **45 | store(matR23.xyzw, addrOut, 0x20);
  sdv $v12, 8, 56, $s2                               ## L:1118 |     46 | store(matR23.XYZW, addrOut, 0x30);
  sdv $v11, 0, 32, $s2                               ## L:1117 |     47 | store(matR23.xyzw, addrOut, 0x20);
  jr $ra                                             ## L:1119 |     48 | }
  sdv $v11, 8, 48, $s2                               ## L:1118 |    *50 | store(matR23.XYZW, addrOut, 0x30);
T3DCmd_MatrixStack:
  ## hot-path cycles: 51
  andi $s7, $a0, 1                                   ## L:1165 |      ^ | u16 doMultiply = stackAdvance & 0b01;
  lw $s5, %lo(MATRIX_STACK_PTR + 0)                  ## L:1170 |      2 | s32 stackPtr = load(MATRIX_STACK_PTR);
  andi $s6, $a0, 2                                   ## L:1166 |      3 | u16 onlyStackMove = stackAdvance & 0b10;
  lh $a0, %lo(RSPQ_DMEM_BUFFER  -7)($gp)             ## L:1168 |      4 | stackAdvance:s16 = load_arg(1);
  addu $s5, $s5, $a0                                 ## L:1171 |    **7 | stackPtr += stackAdvance;
  bne $s6, $zero, RSPQ_Loop                          ## L:1175 |      8 | if(onlyStackMove)exit;
  sw $s5, %lo(MATRIX_STACK_PTR)($zero)               ## L:1172 |    *10 | store(stackPtr, MATRIX_STACK_PTR);
  srl $s3, $a1, 24                                   ## L:227  |     11 | u32 segment = addrIn >> 24;
  lw $s3, %lo(SEGMENT_TABLE)($s3)                    ## L:228  |     12 | segment = load(segment, SEGMENT_TABLE);
  ori $s4, $zero, %lo(MATRIX_MV)                     ## L:1176 |     13 | dmaDest = MATRIX_MV;
  bgez $a0, LABEL_T3DCmd_MatrixStack_0017            ## L:1180 |     14 | if(stackAdvance < 0)addressMat = stackPtr;
  addu $a1, $a1, $s3                                 ## L:229  |    *16 | addrOut = addrIn + segment;
  or $a1, $zero, $s5                                 ## L:1180 |     17 | if(stackAdvance < 0)addressMat = stackPtr;
  LABEL_T3DCmd_MatrixStack_0017:
  addiu $t2, $zero, 12                               ## L:1183 |     18 | dma_in(dmaDest, addrRDRAM, 0x40);
  lui $at, 0xFF                                      ## L:1181 |     19 | u32<$s0> addrRDRAM = addressMat & 0xFFFFFF;
  ori $at, $at, 0xFFFF                               ## L:1181 |     20 | u32<$s0> addrRDRAM = addressMat & 0xFFFFFF;
  and $s0, $a1, $at                                  ## L:1181 |     21 | u32<$s0> addrRDRAM = addressMat & 0xFFFFFF;
  jal DMAExec                                        ## L:1183 |     22 | dma_in(dmaDest, addrRDRAM, 0x40); ## Args: $t0, $t1, $s0, $s4, $t2
  ori $t0, $zero, 63                                 ## L:1183 |    *24 | dma_in(dmaDest, addrRDRAM, 0x40);
  beq $s7, $zero, LABEL_T3DCmd_MatrixStack_0018      ## L:1190 |     25 | if(doMultiply) {
  nop                                                ## L:1190 |    *27 | if(doMultiply) {
  ori $t0, $zero, 63                                 ## L:1194 |     28 | dma_in(dmaDest, addrRDRAM, 0x40);
  ori $s4, $zero, %lo(RDP_BUFF)                      ## L:1192 |     29 | dmaDest = RDP_BUFF;
  addiu $s0, $s5, 65472                              ## L:1193 |     30 | addrRDRAM = stackPtr -  0x40;
  jal DMAExec                                        ## L:1194 |     31 | dma_in(dmaDest, addrRDRAM, 0x40); ## Args: $t0, $t1, $s0, $s4, $t2
  addiu $t2, $zero, 12                               ## L:1194 |    *33 | dma_in(dmaDest, addrRDRAM, 0x40);
  ori $s2, $zero, %lo(MATRIX_MV)                     ## L:1197 |     34 | u32<$s2> mulDest = MATRIX_MV;
  ori $s4, $zero, %lo(MATRIX_MV)                     ## L:1199 |     35 | dmaDest = MATRIX_MV;
  jal mulMat4Mat4                                    ## L:1200 |     36 | mulMat4Mat4(mulDest, mulLeft, dmaDest); ## Args: $s2, $s3, $s4
  ori $s3, $zero, %lo(RDP_BUFF)                      ## L:1198 |    *38 | u32<$s3> mulLeft = RDP_BUFF;
  LABEL_T3DCmd_MatrixStack_0018:
  or $s0, $zero, $s5                                 ## L:1204 |     39 | addrRDRAM = stackPtr;
  addiu $t2, $zero, -32756                           ## L:1205 |     40 | dma_out(dmaDest, addrRDRAM, 0x40);
  jal DMAExec                                        ## L:1205 |     41 | dma_out(dmaDest, addrRDRAM, 0x40); ## Args: $t0, $t1, $s0, $s4, $t2
  ori $t0, $zero, 63                                 ## L:1205 |    *43 | dma_out(dmaDest, addrRDRAM, 0x40);
  ori $s2, $zero, %lo(MATRIX_MVP)                    ## L:1209 |     44 | u32<$s2> mulDest = MATRIX_MVP;
  ori $s3, $zero, %lo(MATRIX_PROJ)                   ## L:1213 |     45 | u32<$s3> mulLeft = MATRIX_PROJ;
  jal mulMat4Mat4                                    ## L:1223 |     46 | mulMat4Mat4(mulDest, mulLeft, mulRight); ## Args: $s2, $s3, $s4
  ori $s4, $zero, %lo(MATRIX_MV)                     ## L:1222 |    *48 | u32<$s4> mulRight = MATRIX_MV;
  j RSPQ_Loop                                        ## L:1224 |     49 | }
  nop                                                ## L:1224 |    *51 | }
T3DCmd_SetWord:
  ## hot-path cycles: 7
  andi $s7, $a0, 32768                               ## L:1229 |      ^ | u32 is16bit = addrDMEM & 0x8000;
  bne $s7, $zero, RSPQ_Loop                          ## L:1232 |      2 | if(is16bit)goto RSPQ_Loop;
  sh $a1, ($a0)                                      ## L:1230 |     *4 | store(value:u16, addrDMEM);
  j RSPQ_Loop                                        ## L:1235 |      5 | }
  sw $a1, ($a0)                                      ## L:1234 |     *7 | store(value:u32, addrDMEM);
T3DCmd_LightSet:
  ## hot-path cycles: 8
  beq $a2, $zero, LABEL_T3DCmd_LightSet_001A         ## L:1242 |      ^ | if(dirXYZ0) {
  sw $a1, 0($a0)                                     ## L:1240 |     *3 | store(rgba8, addr, 0);
  sw $a3, 12($a0)                                    ## L:1244 |      4 | store(dirXYZ1, addr, 12);
  sw $a2, 8($a0)                                     ## L:1243 |      5 | store(dirXYZ0, addr, 8);
  LABEL_T3DCmd_LightSet_001A:
  j RSPQ_Loop                                        ## L:1248 |      6 | }
  sw $a1, 4($a0)                                     ## L:1247 |     *8 | store(rgba8, addr, 4);
T3DCmd_RenderMode:
  ## hot-path cycles: 6
  sw $a1, %lo(TRI_COMMAND)($zero)                    ## L:1252 |      ^ | store(triCommand, TRI_COMMAND);
  lhu $s7, %lo(LINE_COMB_FORCE + 0)                  ## L:1254 |      2 | u16 combDirty = load(LINE_COMB_FORCE);
  sb $a0, %lo(FACE_CULLING)($zero)                   ## L:1251 |      3 | store(culling, FACE_CULLING);
  j RSPQ_Loop                                        ## L:1256 |      4 | }
  sh $s7, %lo(LINE_COMB_DIRTY)($zero)                ## L:1255 |     *6 | store(combDirty, LINE_COMB_DIRTY);
T3DCmd_MatProjectionSet:
  ## hot-path cycles: 6
  ori $s4, $zero, %lo(MATRIX_PROJ)                   ## L:1260 |      ^ | dma_in(MATRIX_PROJ, addrRDRAM, 0x40);
  or $s0, $zero, $a0                                 ## L:1259 |      2 | u32<$s0> addrRDRAM = addressMat;
  addiu $t2, $zero, 12                               ## L:1260 |      3 | dma_in(MATRIX_PROJ, addrRDRAM, 0x40);
  j DMAExec                                          ## L:1260 |      4 | dma_in(MATRIX_PROJ, addrRDRAM, 0x40); ## Args: $t0, $t1, $s0, $s4, $t2
  ori $t0, $zero, 63                                 ## L:1260 |     *6 | dma_in(MATRIX_PROJ, addrRDRAM, 0x40);
T3DCmd_Patch:
  ## hot-path cycles: 7
  ori $s4, $zero, %lo(RSPQ_SCRATCH_MEM)              ## L:1267 |      ^ | s16<$s4> dmemAddr = RSPQ_SCRATCH_MEM;
  sw $a2, 4($s4)                                     ## L:1270 |      2 | store(opcode1, dmemAddr, 4);
  addiu $t0, $zero, 7                                ## L:1265 |      3 | u16<$t0> size = 8 - 1;
  sw $a1, 0($s4)                                     ## L:1269 |      4 | store(opcode0, dmemAddr, 0);
  j DMAOut                                           ## L:1272 |      5 | DMAOut(size, rdramAddr, dmemAddr); ## Args: $t0, $s0, $s4
  or $s0, $zero, $a0                                 ## L:1266 |     *7 | u32<$s0> rdramAddr = rdramAddr_;
T3DCmd_SetFogState:
  ## hot-path cycles: 3
  j RSPQ_Loop                                        ## L:1278 |      ^ | }
  sb $a0, %lo(FOG_STORE_OFFSET)($zero)               ## L:1277 |     *3 | store(enabled, FOG_STORE_OFFSET);

OVERLAY_CODE_END:

#define zero $0
#define v0 $2
#define v1 $3
#define a0 $4
#define a1 $5
#define a2 $6
#define a3 $7
#define t0 $8
#define t1 $9
#define t2 $10
#define t3 $11
#define t4 $12
#define t5 $13
#define t6 $14
#define t7 $15
#define s0 $16
#define s1 $17
#define s2 $18
#define s3 $19
#define s4 $20
#define s5 $21
#define s6 $22
#define s7 $23
#define t8 $24
#define t9 $25
#define k0 $26
#define k1 $27
#define gp $28
#define sp $29
#define fp $30
#define ra $31

.set at
.set macro