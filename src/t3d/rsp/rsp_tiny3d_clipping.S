## Auto-generated file, transpiled with RSPL
#define OVERLAY_CLIPPING 1
#define VERT_BUFFER_COUNT 69
#define LIGHT_COUNT 7
#define T3D_PAGE_H
#define T3D_PAGE_ORIGINAL 0
#define T3D_PAGE_CLIP 1
#define T3D_PAGE_MATERIAL 2
#define T3D_BUF_TEXT_OFF 0x0000
#define T3D_BUF_CLIP_OFF 0x1000
#define T3D_BUF_PAGE_OFF 0x1800
#define T3D_BUF_TABLES_OFF 0x2000
#define T3D_BUF_TABLES_PAGE_OFF 0x2040
#define T3D_BUF_CONSTS_OFF 0x2080
#define T3D_BUF_SIZE 0x2100
#define T3D_WINDOW_SIZE 0x0520
#define T3D_WINDOW_MAX_SIZE 0x0800
#define T3D_TABLES_DMEM 0x220
#define T3D_TABLES_SIZE 40
#define T3D_PAGE_DATA_SIZE 96
#define RSPQ_PROFILE_MANUAL_SLOT 1
#define RDPQ_TRIANGLE_CUSTOM_VTX 1
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
#define RDPQ_TRIANGLE_VTX1 a0
#define RDPQ_TRIANGLE_VTX2 a1
#define RDPQ_TRIANGLE_VTX3 a2
#define RDPQ_TRIANGLE_VTX1_DMEM 0,v1
#define RDPQ_TRIANGLE_VTX2_DMEM 4,v1
#define RDPQ_TRIANGLE_VTX3_DMEM 2,v1
#define TRI_SIZE 36
#define TRI_SIZE_2 72
#define TRI_SIZE_3 108
#define RDP_CMD_MAX_SIZE 176
#define LIGHT_SIZE 16
#define DRAW_TRIS 1
#define DP_STATUS_END_VALID 512
#define RDPQ_DYNAMIC_BUFFER_SIZE 65536
#define CLIP_BUFFER_XOR 0x100
#define CLIP_BUFFER_SIZE 252
#define CLIP_FAN_ASYNC_MAX_SIZE 145
#include <rsp_queue.inc>
#include <rdpq_macros.h>
#include "./rspq_triangle.inc"

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
    RSPQ_DefineCommand RSPQ_Loop, 8
    RSPQ_DefineCommand RSPQ_Loop, 4
    RSPQ_DefineCommand RSPQ_Loop, 4
    RSPQ_DefineCommand RSPQ_Loop, 4
    RSPQ_DefineCommand RSPQ_Loop, 4
    RSPQ_DefineCommand RSPQ_Loop, 4
    RSPQ_DefineCommand RSPQ_Loop, 4
    RSPQ_DefineCommand RSPQ_Loop, 4
    RSPQ_DefineCommand RSPQ_Loop, 4
    RSPQ_DefineCommand RSPQ_Loop, 4
    RSPQ_DefineCommand RSPQ_Loop, 4
    RSPQ_DefineCommand RSPQ_Loop, 4
    RSPQ_DefineCommand RSPQ_Loop, 4
    RSPQ_DefineCommand RSPQ_Loop, 4
    RSPQ_DefineCommand RSPQ_Loop, 4
    RSPQ_DefineCommand RSPQ_Loop, 4
    RSPQ_DefineCommand RSPQ_Loop, 4
    RSPQ_DefineCommand RSPQ_Loop, 4
    RSPQ_DefineCommand RSPQ_Loop, 4
    RSPQ_DefineCommand RSPQ_Loop, 4
    RSPQ_DefineCommand RSPQ_Loop, 4
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
    MATRIX_NORMAL: .ds.b 24
    .align 1
    VERT_CONSTS: .half 32768, 32768, 0, 32768, 33023, 32767, 0, 0
    .align 4
    NORMAL_MASK_SHIFT: .half 63488, 2016, 31, 0, 1, 32, 2048, 0
    .align 3
    CLIPPING_PLANES: .byte 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 1, 0, 0, -1, 0, 1, 0, -1
    .align 3
    SCREEN_SCALE: .half 0, 0, 0, 0, 0, 0, 0, 0
    .align 1
    SCREEN_OFFSET: .half 0, 0, 16383, 33023
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
    COLOR_AMBIENT: .word 4294967295, 4294967295
    .align 2
    #if RSPQ_PROFILE
    LIGHT_DIR_COLOR: .ds.b 32
    _RSPQ_OVL_PROFILESLOT: .long 0, 0
    #else
    LIGHT_DIR_COLOR: .ds.b 112
    #endif
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
    PAGE_STATE: .half 0
    .align 2
    UCODE_BUF_ADDR: .word 0
    .align 3
    VERT_BUFFER: .ds.b 2484
    STATE_MEM_END:
  RSPQ_EndSavedState

.bss
  TEMP_STATE_MEM_START:
    .align 4
    CLIP_BUFFER_TMP: .ds.b 252
    .align 4
    #if RSPQ_PROFILE
    CLIP_BUFFER_RESULT: .ds.b 236
    #else
    CLIP_BUFFER_RESULT: .ds.b 252
    #endif
  TEMP_STATE_MEM_END:

.text
OVERLAY_CODE_START:

.align 3
clipTriangle:
  ## hot-path cycles: 265
  ldv $v01, 0, 0, $a0                                ## L:731  |      ^ | vec16 tmp1 = load(ptrSrc, 0x00).xyzw;
  addiu $t6, $zero, 1                                ## L:525  |      2 | s32 planeIdx = 1;
  lui $t1, 0x9669                                    ## L:508  |      3 | u32 parity = 0x96696996;
  srl $t4, $t4, 8                                    ## L:504  |      4 | clipMask >>= 8;
  ori $t1, $t1, 0x6996                               ## L:508  |      5 | u32 parity = 0x96696996;
  srlv $t1, $t1, $t4                                 ## L:509  |      6 | parity >>= clipMask;
  ori $t2, $zero, %lo(CLIP_BUFFER_RESULT)            ## L:512  |      7 | u32 ptrBuff1 = CLIP_BUFFER_RESULT;
  ldv $v03, 0, 16, $a0                               ## L:733  |      8 | vec16 tmp3 = load(ptrSrc, 0x10).xyzw;
  andi $t1, $t1, 1                                   ## L:510  |      9 | parity &= 1;
  sll $t1, $t1, 8                                    ## L:511  |     10 | parity <<= 8;
  ldv $v02, 0, 8, $a0                                ## L:732  |     11 | vec16 tmp2 = load(ptrSrc, 0x08).xyzw;
  ldv $v04, 0, 24, $a0                               ## L:734  |     12 | vec16 tmp4 = load(ptrSrc, 0x18).xyzw;
  lbu $t7, 6($a0)                                    ## L:529  |     13 | u8 oldClip = load(ptrVertA, 0x06);
  addiu $t2, $t2, 252                                ## L:513  |     14 | ptrBuff1 += 252;
  subu $t2, $t2, $t1                                 ## L:514  |     15 | ptrBuff1 -= parity;
  or $t3, $zero, $t2                                 ## L:515  |     16 | u32 ptrWrite = ptrBuff1;
  addiu $t3, $t3, 65500                              ## L:730  |     17 | ptrDst -= 36;
  sdv $v01, 0, 0, $t3                                ## L:736  |     18 | store(tmp1.xyzw, ptrDst, 0x00);
  ldv $v01, 0, 0, $a1                                ## L:731  |     19 | vec16 tmp1 = load(ptrSrc, 0x00).xyzw;
  sdv $v02, 0, 8, $t3                                ## L:737  |     20 | store(tmp2.xyzw, ptrDst, 0x08);
  ldv $v02, 0, 8, $a1                                ## L:732  |     21 | vec16 tmp2 = load(ptrSrc, 0x08).xyzw;
  sdv $v04, 0, 24, $t3                               ## L:739  |     22 | store(tmp4.xyzw, ptrDst, 0x18);
  ldv $v04, 0, 24, $a1                               ## L:734  |     23 | vec16 tmp4 = load(ptrSrc, 0x18).xyzw;
  sdv $v03, 0, 16, $t3                               ## L:738  |     24 | store(tmp3.xyzw, ptrDst, 0x10);
  addiu $t3, $t3, 65500                              ## L:730  |     25 | ptrDst -= 36;
  ori $at, $zero, %lo(NORM_SCALE_W)                  ## L:534  |     26 | normScaleWInv.x = load(NORM_SCALE_W).w;
  sdv $v02, 0, 8, $t3                                ## L:737  |     27 | store(tmp2.xyzw, ptrDst, 0x08);
  ldv $v03, 0, 16, $a1                               ## L:733  |     28 | vec16 tmp3 = load(ptrSrc, 0x10).xyzw;
  sdv $v04, 0, 24, $t3                               ## L:739  |     29 | store(tmp4.xyzw, ptrDst, 0x18);
  ldv $v04, 0, 24, $a2                               ## L:734  |     30 | vec16 tmp4 = load(ptrSrc, 0x18).xyzw;
  sdv $v01, 0, 0, $t3                                ## L:736  |     31 | store(tmp1.xyzw, ptrDst, 0x00);
  ldv $v01, 0, 0, $a2                                ## L:731  |     32 | vec16 tmp1 = load(ptrSrc, 0x00).xyzw;
  sdv $v03, 0, 16, $t3                               ## L:738  |     33 | store(tmp3.xyzw, ptrDst, 0x10);
  addiu $t3, $t3, 65500                              ## L:730  |     34 | ptrDst -= 36;
  ldv $v03, 0, 16, $a2                               ## L:733  |     35 | vec16 tmp3 = load(ptrSrc, 0x10).xyzw;
  sdv $v01, 0, 0, $t3                                ## L:736  |     36 | store(tmp1.xyzw, ptrDst, 0x00);
  lsv $v01, 0, 6, $at                                ## L:534  |     37 | normScaleWInv.x = load(NORM_SCALE_W).w;
  sb $t7, %lo(20 + RSPQ_SCRATCH_MEM)($zero)          ## L:530  |     38 | store(oldClip, RSPQ_SCRATCH_MEM, 20);
  ori $at, $zero, 0xFFFF                             ## L:536  |     39 | normScaleWInv.w = 0xFFFF;
  sdv $v03, 0, 16, $t3                               ## L:738  |     40 | store(tmp3.xyzw, ptrDst, 0x10);
  ldv $v02, 0, 8, $a2                                ## L:732  |     41 | vec16 tmp2 = load(ptrSrc, 0x08).xyzw;
  vor $v01, $v00, $v01.e0                            ## L:535  |      ^ | normScaleWInv = normScaleWInv.x;
  mtc2 $at, $v01.e3                                  ## L:536  |     42 | normScaleWInv.w = 0xFFFF;
  addiu $t0, $zero, 108                              ## L:498  |     43 | arraySize = 108;
  ori $at, $zero, 0xFFFF                             ## L:537  |     44 | normScaleWInv.W = 0xFFFF;
  sdv $v04, 0, 24, $t3                               ## L:739  |     45 | store(tmp4.xyzw, ptrDst, 0x18);
  sdv $v02, 0, 8, $t3                                ## L:737  |     46 | store(tmp2.xyzw, ptrDst, 0x08);
  mtc2 $at, $v01.e7                                  ## L:537  |     47 | normScaleWInv.W = 0xFFFF;
  ori $at, $zero, %lo(RSPQ_SCRATCH_MEM)              ## L:543  |     48 | uvIntMask.XYZW = VZERO.xyzw; ## Barrier: 0x1
  vor $v03, $v00, $v00                               ## L:544  |      ^ | vec16 uvBias = VZERO;
  ori $t5, $zero, %lo(CLIPPING_PLANES)               ## L:524  |     49 | u32 planePtr = CLIPPING_PLANES;
  sdv $v00, 0, 0, $at                                ## L:543  |     50 | uvIntMask.XYZW = VZERO.xyzw; ## Barrier: 0x1
  vsubc $v02, $v00, $v30.e7                          ## L:542  |      ^ | vec16 uvIntMask = VZERO - 1;
  ldv $v02, 8, 0, $at                                ## L:543  |     51 | uvIntMask.XYZW = VZERO.xyzw; ## Barrier: 0x1
  vmov $v03.e5, $v31.e0                              ## L:546  |      ^ | uvBias.Y = 0x8000;
  vmov $v03.e4, $v31.e0                              ## L:545  |     52 | uvBias.X = 0x8000;
  LABEL_clipTriangle_0001:
  and $t7, $t4, $t6                                  ## L:552  |      ^ | u32 planeActive = clipMask & planeIdx;
  beq $t7, $zero, LABEL_clipTriangle_0003            ## L:553  |     53 | if(planeActive)
  nop                                                ## L:553  |     54 | if(planeActive)
  vmudl $v05, $v00, $v31.e7                          ## L:561  |     55 | planeNorm >>= 8;
  lpv $v04, 0, 0, $t5                                ## L:558  |      ^ | vec32 planeNorm:sint = load_vec_s8(planePtr);
  xori $t2, $t2, 256                                 ## L:575  |     56 | ptrBuff1 ^= 0x100;
  ori $at, $zero, %lo(RSPQ_SCRATCH_MEM)              ## L:559  |     57 | planeNorm:sint.XYZW = planeNorm:sint.xyzw; ## Barrier: 0x1
  sdv $v04, 0, 0, $at                                ## L:559  |    *59 | planeNorm:sint.XYZW = planeNorm:sint.xyzw; ## Barrier: 0x1
  ldv $v04, 8, 0, $at                                ## L:559  |     60 | planeNorm:sint.XYZW = planeNorm:sint.xyzw; ## Barrier: 0x1
  or $t8, $zero, $t3                                 ## L:564  |     61 | u32 ptrLast = ptrWrite;
  ldv $v07, 0, 16, $t8                               ## L:567  |     62 | vec32 lastPosUV   = load(ptrLast, 0x10).xyzw;
  ldv $v08, 0, 24, $t8                               ## L:567  |     63 | vec32 lastPosUV   = load(ptrLast, 0x10).xyzw;
  llv $v08, 8, 12, $t8                               ## L:568  |     64 | lastPosUV:sfract.XY = load(ptrLast, 0x0C).xy;
  vmadm $v04, $v04, $v31.e7                          ## L:561  |      ^ | planeNorm >>= 8;
  vmadn $v05, $v00, $v00                             ## L:561  |     65 | planeNorm >>= 8;
  lbu $t9, 6($t8)                                    ## L:571  |      ^ | u8 lastClipCode   = load(ptrLast, 0x06);
  vand $v07, $v07, $v02.v                            ## L:569  |     66 | lastPosUV:sint &= uvIntMask;
  luv $v06, 0, 8, $t8                                ## L:566  |      ^ | vec16 lastColor   = load_vec_u8(ptrLast, 0x08);
  xori $t8, $t2, 256                                 ## L:578  |     67 | u32 ptrRead = ptrBuff1 ^ 0x100;
  subu $k0, $t8, $t0                                 ## L:579  |     68 | u32 ptrReadEnd = ptrRead - arraySize;
  vxor $v08, $v08, $v03.v                            ## L:570  |      ^ | lastPosUV:sfract ^= uvBias;
  vmudl $v05, $v05, $v01.v                           ## L:562  |     69 | planeNorm *= normScaleWInv:ufract;
  xor $t4, $t4, $t6                                  ## L:555  |      ^ | clipMask ^= planeIdx;
  or $t3, $zero, $t2                                 ## L:577  |     70 | ptrWrite = ptrBuff1;
  vmadm $v04, $v04, $v01.v                           ## L:562  |      ^ | planeNorm *= normScaleWInv:ufract;
  vmadn $v05, $v00, $v00                             ## L:562  |     71 | planeNorm *= normScaleWInv:ufract;
  LABEL_clipTriangle_0004:
  addiu $t8, $t8, 65500                              ## L:584  |      ^ | ptrRead -= 36;
  lbu $k1, 6($t8)                                    ## L:591  |     72 | u8 clipCode = load(ptrRead, 0x06);
  ldv $v10, 0, 24, $t8                               ## L:585  |     73 | vec32 currentPosUV   = load(ptrRead, 0x10).xyzw;
  ldv $v09, 0, 16, $t8                               ## L:585  |     74 | vec32 currentPosUV   = load(ptrRead, 0x10).xyzw;
  llv $v10, 8, 12, $t8                               ## L:586  |     75 | currentPosUV:sfract.XY = load(ptrRead, 0x0C).xy;
  nor $fp, $zero, $k1                                ## L:595  |     76 | u8 isInsideCurr = ~clipCode;
  and $fp, $fp, $t6                                  ## L:597  |     77 | isInsideCurr &= planeIdx;
  xor $sp, $k1, $t9                                  ## L:594  |     78 | u8 exclIntersect = clipCode ^ lastClipCode;
  and $sp, $sp, $t6                                  ## L:596  |     79 | exclIntersect &= planeIdx;
  vxor $v10, $v10, $v03.v                            ## L:588  |      ^ | currentPosUV:sfract ^= uvBias;
  vand $v09, $v09, $v02.v                            ## L:587  |     80 | currentPosUV:sint &= uvIntMask;
  beq $sp, $zero, LABEL_clipTriangle_0006            ## L:599  |      ^ | if(exclIntersect)
  luv $v11, 0, 8, $t8                                ## L:589  |     81 | vec16 currentColor   = load_vec_u8(ptrRead, 0x08);
  and $t9, $t9, $t6                                  ## L:601  |     82 | lastClipCode &= planeIdx;
  beq $t9, $zero, LABEL_clipTriangle_0007            ## L:426  |     83 | if(newClipCode)
  nop                                                ## L:426  |     84 | if(newClipCode)
  ori $at, $zero, %lo(RSPQ_SCRATCH_MEM)              ## L:430  |     85 | vpos.XYZW = posBase.xyzw; ## Barrier: 0x1
  vsubc $v13, $v08, $v10.v                           ## L:428  |      ^ | posUVDiff = posBase - pos;
  vor $v15, $v00, $v10                               ## L:429  |     86 | vpos = pos;
  sdv $v07, 0, 0, $at                                ## L:430  |      ^ | vpos.XYZW = posBase.xyzw; ## Barrier: 0x1
  vor $v14, $v00, $v09                               ## L:429  |     87 | vpos = pos;
  sdv $v08, 0, 8, $at                                ## L:430  |      ^ | vpos.XYZW = posBase.xyzw; ## Barrier: 0x1
  ldv $v14, 8, 0, $at                                ## L:430  |     88 | vpos.XYZW = posBase.xyzw; ## Barrier: 0x1
  vsub $v12, $v07, $v09.v                            ## L:428  |      ^ | posUVDiff = posBase - pos;
  ldv $v15, 8, 8, $at                                ## L:430  |     89 | vpos.XYZW = posBase.xyzw; ## Barrier: 0x1
  beq $zero, $zero, LABEL_clipTriangle_0008          ## L:431  |     90 | colorDiff = colorBase - color;
  vsubc $v16, $v06, $v11.v                           ## L:431  |    *92 | colorDiff = colorBase - color;
  LABEL_clipTriangle_0007:
  vor $v15, $v00, $v08                               ## L:434  |      1 | vpos = posBase;
  ori $at, $zero, %lo(RSPQ_SCRATCH_MEM)              ## L:435  |      ^ | vpos.XYZW = pos.xyzw; ## Barrier: 0x1
  sdv $v09, 0, 0, $at                                ## L:435  |      2 | vpos.XYZW = pos.xyzw; ## Barrier: 0x1
  vsubc $v13, $v10, $v08.v                           ## L:433  |      ^ | posUVDiff = pos - posBase;
  vor $v14, $v00, $v07                               ## L:434  |      3 | vpos = posBase;
  sdv $v10, 0, 8, $at                                ## L:435  |      ^ | vpos.XYZW = pos.xyzw; ## Barrier: 0x1
  vsub $v12, $v09, $v07.v                            ## L:433  |      4 | posUVDiff = pos - posBase;
  ldv $v14, 8, 0, $at                                ## L:435  |      ^ | vpos.XYZW = pos.xyzw; ## Barrier: 0x1
  vsubc $v16, $v11, $v06.v                           ## L:436  |      5 | colorDiff = color - colorBase;
  ldv $v15, 8, 8, $at                                ## L:435  |      ^ | vpos.XYZW = pos.xyzw; ## Barrier: 0x1
  LABEL_clipTriangle_0008:
  vmudl $v17, $v15, $v05.v                           ## L:316  | ***************************************************************************************93 | res = a * b;
  vmadm $v17, $v14, $v05.v                           ## L:316  |     94 | res = a * b;
  vmadn $v18, $v15, $v04.v                           ## L:316  |     95 | res = a * b;
  vmadh $v17, $v14, $v04.v                           ## L:316  |     96 | res = a * b;
  vaddc $v18, $v18, $v18.q1                          ## L:317  |   **99 | res += res.yywwYYWW;
  vadd $v17, $v17, $v17.q1                           ## L:317  |    100 | res += res.yywwYYWW;
  vaddc $v18, $v18, $v18.h2                          ## L:318  |  **103 | res += res.zzzzZZZZ;
  vadd $v17, $v17, $v17.h2                           ## L:318  |    104 | res += res.zzzzZZZZ;
  vsubc $v20, $v18, $v18.e4                          ## L:440  |  **107 | vec32 fac = dot - dot.X;
  vsub $v19, $v17, $v17.e4                           ## L:440  |    108 | vec32 fac = dot - dot.X;
  vrcph $v19.e0, $v19.e0                             ## L:442  | ***112 | fac.x = invert_half(fac).x;
  vrcpl $v20.e0, $v20.e0                             ## L:442  |    113 | fac.x = invert_half(fac).x;
  vrcph $v19.e0, $v00.e0                             ## L:442  |    114 | fac.x = invert_half(fac).x;
  vaddc $v20, $v20, $v20.v                           ## L:443  |  **117 | fac += fac;
  vadd $v19, $v19, $v19.v                            ## L:443  |    118 | fac += fac;
  vmudl $v29, $v20, $v18.e0                          ## L:444  |  **121 | fac *= dot.x;
  vmadm $v29, $v19, $v18.e0                          ## L:444  |    122 | fac *= dot.x;
  vmadn $v20, $v20, $v17.e0                          ## L:444  |    123 | fac *= dot.x;
  vmadh $v19, $v19, $v17.e0                          ## L:444  |    124 | fac *= dot.x;
  mfc2 $s0, $v19.e0                                  ## L:446  | ***128 | s16 facX = fac:sint.x;
  beq $s0, $zero, LABEL_clipTriangle_0009            ## L:447  |  **131 | if(facX != 0) {
  nop                                                ## L:447  |    132 | if(facX != 0) {
  vlt $v29, $v19, $v30.e7                            ## L:451  |    133 | fac:ufract = fac:sint < 1 ? fac:ufract : normScaleWInv:ufract.w;
  vmrg $v20, $v20, $v01.e3                           ## L:451  |    134 | fac:ufract = fac:sint < 1 ? fac:ufract : normScaleWInv:ufract.w;
  vge $v29, $v19, $v00.e0                            ## L:452  |    135 | fac:ufract = fac:sint >= 0 ? fac:ufract : VZERO;
  vmrg $v20, $v20, $v00                              ## L:452  |  **138 | fac:ufract = fac:sint >= 0 ? fac:ufract : VZERO;
  LABEL_clipTriangle_0009:
  beq $t9, $zero, LABEL_clipTriangle_000A            ## L:457  |      ^ | if(newClipCode) {
  vmudm $v16, $v16, $v20.e0                          ## L:455  | ***142 | colorDiff:sfract *= fac:sfract.x;
  vmudl $v18, $v13, $v20.e0                          ## L:459  |    143 | dot = posUVDiff * fac:ufract.x;
  vmadm $v17, $v12, $v20.e0                          ## L:459  |    144 | dot = posUVDiff * fac:ufract.x;
  vmadn $v18, $v00, $v00                             ## L:459  |    145 | dot = posUVDiff * fac:ufract.x;
  vmadn $v08, $v10, $v30.e7                          ## L:460  |    146 | resPosUV = pos +* 1;
  vmadh $v07, $v09, $v30.e7                          ## L:460  |    147 | resPosUV = pos +* 1;
  beq $zero, $zero, LABEL_clipTriangle_000B          ## L:461  |      ^ | resColor:uint = color + colorDiff;
  vaddc $v06, $v11, $v16.v                           ## L:461  |   *149 | resColor:uint = color + colorDiff;
  LABEL_clipTriangle_000A:
  vmudl $v18, $v13, $v20.e0                          ## L:463  |      1 | dot = posUVDiff * fac:ufract.x;
  vmadm $v17, $v12, $v20.e0                          ## L:463  |      2 | dot = posUVDiff * fac:ufract.x;
  vmadn $v18, $v00, $v00                             ## L:463  |      3 | dot = posUVDiff * fac:ufract.x;
  vmadn $v08, $v08, $v30.e7                          ## L:464  |      4 | resPosUV = posBase +* 1;
  vmadh $v07, $v07, $v30.e7                          ## L:464  |      5 | resPosUV = posBase +* 1;
  vaddc $v06, $v06, $v16.v                           ## L:465  |      6 | resColor:uint = colorBase + colorDiff;
  LABEL_clipTriangle_000B:
  beq $t4, $zero, LABEL_clipTriangle_000C            ## L:470  | ***********************************************************************************************************************************************150 | if(remainingPlanes)
  nop                                                ## L:470  |    151 | if(remainingPlanes)
  vmudl $v13, $v08, $v01.v                           ## L:473  |    152 | vec32 clipBase = resPosUV * normScaleWInv:ufract;
  vmadm $v12, $v07, $v01.v                           ## L:473  |    153 | vec32 clipBase = resPosUV * normScaleWInv:ufract;
  vmadn $v13, $v00, $v00                             ## L:473  |    154 | vec32 clipBase = resPosUV * normScaleWInv:ufract;
  vmov $v12.e2, $v12.e3                              ## L:475  |  **157 | clipBase.z = clipBase.w;
  vmov $v13.e2, $v13.e3                              ## L:475  |    158 | clipBase.z = clipBase.w;
  vch $v29, $v12, $v07.e3                            ## L:476  |  **161 | newClipCode = clip(clipBase, resPosUV.w);
  vcl $v29, $v13, $v08.e3                            ## L:476  |    162 | newClipCode = clip(clipBase, resPosUV.w);
  cfc2 $t9, $vcc                                     ## L:476  |    163 | newClipCode = clip(clipBase, resPosUV.w);
  andi $t9, $t9, 771                                 ## L:343  |  **166 | res = clipCode & 0b0000'0011'0000'0011;
  srl $s0, $t9, 5                                    ## L:344  |    167 | u32 tmp = res >> 5;
  or $t9, $t9, $s0                                   ## L:345  |    168 | res |= tmp;
  LABEL_clipTriangle_000C:
  vxor $v12, $v08, $v03.v                            ## L:755  |      ^ | vec16 stOut = lastPosUV:sfract ^ uvBias;
  addiu $t3, $t3, 65500                              ## L:753  |    169 | ptrWrite -= 36;
  suv $v06, 0, 8, $t3                                ## L:754  |    170 | @Barrier("uv") store_vec_u8(lastColor,  ptrWrite, 0x08); ## Barrier: 0x2
  sb $t9, 6($t3)                                     ## L:758  |    171 | store(lastClipCode:u8,   ptrWrite, 0x06);
  slv $v12, 8, 12, $t3                               ## L:756  |    172 | @Barrier("uv") store(stOut.XY, ptrWrite, 0x0C); ## Barrier: 0x2
  sdv $v08, 0, 24, $t3                               ## L:759  |    173 | store(lastPosUV.xyzw,    ptrWrite, 0x10);
  sdv $v07, 0, 16, $t3                               ## L:759  |    174 | store(lastPosUV.xyzw,    ptrWrite, 0x10);
  LABEL_clipTriangle_0006:
  vor $v08, $v00, $v10                               ## L:610  |      ^ | lastPosUV = currentPosUV;
  vor $v07, $v00, $v09                               ## L:610  |    175 | lastPosUV = currentPosUV;
  or $t9, $zero, $k1                                 ## L:611  |      ^ | lastClipCode = clipCode;
  beq $fp, $zero, LABEL_clipTriangle_000D            ## L:614  |    176 | if(isInsideCurr) {
  vor $v06, $v00, $v11                               ## L:612  |    177 | lastColor = currentColor;
  vxor $v12, $v08, $v03.v                            ## L:755  |    178 | vec16 stOut = lastPosUV:sfract ^ uvBias;
  addiu $t3, $t3, 65500                              ## L:753  |      ^ | ptrWrite -= 36;
  sdv $v07, 0, 16, $t3                               ## L:759  |    179 | store(lastPosUV.xyzw,    ptrWrite, 0x10);
  sdv $v08, 0, 24, $t3                               ## L:759  |    180 | store(lastPosUV.xyzw,    ptrWrite, 0x10);
  suv $v06, 0, 8, $t3                                ## L:754  |    181 | @Barrier("uv") store_vec_u8(lastColor,  ptrWrite, 0x08); ## Barrier: 0x2
  slv $v12, 8, 12, $t3                               ## L:756  |    182 | @Barrier("uv") store(stOut.XY, ptrWrite, 0x0C); ## Barrier: 0x2
  sb $t9, 6($t3)                                     ## L:758  |    183 | store(lastClipCode:u8,   ptrWrite, 0x06);
  LABEL_clipTriangle_000D:
  bne $t8, $k0, LABEL_clipTriangle_0004              ## L:759  |    184 | store(lastPosUV.xyzw,    ptrWrite, 0x10);
  nop                                                ## L:759  |    185 | store(lastPosUV.xyzw,    ptrWrite, 0x10);
  LABEL_clipTriangle_0005:
  subu $t0, $t2, $t3                                 ## L:620  |    186 | arraySize = ptrBuff1 - ptrWrite;
  beq $t0, $zero, CLIP_RETURN                        ## L:621  |    187 | if(arraySize == 0)goto CLIP_RETURN;
  nop                                                ## L:621  |    188 | if(arraySize == 0)goto CLIP_RETURN;
  LABEL_clipTriangle_0003:
  addiu $at, $zero, 32                               ## L:625  |    189 | planePtr += 0x04;
  sll $t6, $t6, 1                                    ## L:624  |    190 | planeIdx <<= 1;
  bne $t6, $at, LABEL_clipTriangle_0001              ## L:625  |    191 | planePtr += 0x04;
  addiu $t5, $t5, 4                                  ## L:625  |    192 | planePtr += 0x04;
  CLIP_END:
  or $t7, $zero, $t3                                 ## L:633  |    193 | u32 ptrConvA = ptrWrite;
  LABEL_clipTriangle_000F:
  addiu $t9, $t7, 36                                 ## L:638  |    194 | u32 ptrConvB = ptrConvA + 36;
  bne $t9, $t2, LABEL_clipTriangle_0011              ## L:639  |    195 | if(ptrConvB == ptrBuff1) {
  lhu $t8, %lo(RSPQ_SCRATCH_MEM + 20)                ## L:637  |    196 | u16 oldClipFlag = load(RSPQ_SCRATCH_MEM, 20);
  or $t9, $zero, $t7                                 ## L:640  |    197 | ptrConvB = ptrConvA;
  LABEL_clipTriangle_0011:
  ldv $v08, 8, 16, $t9                               ## L:654  |    198 | posClip.XYZW = load(ptrConvB, 0x10).xyzw;
  ldv $v08, 0, 16, $t7                               ## L:653  |    199 | vec32 posClip = load(ptrConvA, 0x10).xyzw;
  ldv $v09, 8, 24, $t9                               ## L:654  |    200 | posClip.XYZW = load(ptrConvB, 0x10).xyzw;
  ldv $v09, 0, 24, $t7                               ## L:653  |    201 | vec32 posClip = load(ptrConvA, 0x10).xyzw;
  ori $at, $zero, %lo(SCREEN_SCALE)                  ## L:643  |    202 | vec32 screenSize = load(SCREEN_SCALE).xyzwxyzw;
  ldv $v05, 8, 8, $at                                ## L:643  |    203 | vec32 screenSize = load(SCREEN_SCALE).xyzwxyzw;
  vrcph $v10.e3, $v08.e3                             ## L:657  |      ^ | invWRaw.w = invert_half(posClip).w;
  ldv $v05, 0, 8, $at                                ## L:643  |    204 | vec32 screenSize = load(SCREEN_SCALE).xyzwxyzw;
  ldv $v04, 0, 0, $at                                ## L:643  |    205 | vec32 screenSize = load(SCREEN_SCALE).xyzwxyzw;
  vrcpl $v11.e3, $v09.e3                             ## L:657  |      ^ | invWRaw.w = invert_half(posClip).w;
  ldv $v04, 8, 0, $at                                ## L:643  |    206 | vec32 screenSize = load(SCREEN_SCALE).xyzwxyzw;
  vrcph $v10.e3, $v08.e7                             ## L:658  |      ^ | invWRaw.W = invert_half(posClip).W;
  vrcpl $v11.e7, $v09.e7                             ## L:658  |    207 | invWRaw.W = invert_half(posClip).W;
  ori $at, $zero, %lo(SCREEN_OFFSET)                 ## L:644  |      ^ | vec16 screenOffset = load(SCREEN_OFFSET).xyzwxyzw;
  ldv $v06, 8, 0, $at                                ## L:644  |    208 | vec16 screenOffset = load(SCREEN_OFFSET).xyzwxyzw;
  ldv $v06, 0, 0, $at                                ## L:644  |    209 | vec16 screenOffset = load(SCREEN_OFFSET).xyzwxyzw;
  vrcph $v10.e7, $v00.e7                             ## L:658  |      ^ | invWRaw.W = invert_half(posClip).W;
  ori $at, $zero, %lo(NORM_SCALE_W)                  ## L:645  |    210 | vec16 normScaleW = load(NORM_SCALE_W).xyzwxyzw;
  ldv $v07, 8, 0, $at                                ## L:645  |    211 | vec16 normScaleW = load(NORM_SCALE_W).xyzwxyzw;
  vmudl $v13, $v09, $v11.h3                          ## L:662  |      ^ | invW:sfract = posClip * invWRaw.wwwwWWWW;
  vmadm $v13, $v08, $v11.h3                          ## L:662  |    212 | invW:sfract = posClip * invWRaw.wwwwWWWW;
  ldv $v07, 0, 0, $at                                ## L:645  |      ^ | vec16 normScaleW = load(NORM_SCALE_W).xyzwxyzw;
  andi $t8, $t8, 57344                               ## L:650  |    213 | oldClipFlag = oldClipFlag & ((0b111'00000) << 8);
  vmadn $v13, $v09, $v10.h3                          ## L:662  |      ^ | invW:sfract = posClip * invWRaw.wwwwWWWW;
  vsubc $v14, $v07, $v13.h3                          ## L:663  | ***217 | vec16 nrD = normScaleW:ufract - invW:ufract.wwwwWWWW;
  vaddc $v13, $v11, $v11.v                           ## L:664  |    218 | invW = invWRaw + invWRaw;
  vadd $v12, $v10, $v10.v                            ## L:664  |    219 | invW = invWRaw + invWRaw;
  vmudl $v13, $v13, $v14.h2                          ## L:665  |  **222 | invW *= nrD:ufract.zzzzZZZZ;
  ori $t8, $t8, 255                                  ## L:651  |      ^ | oldClipFlag |= 0xFF;
  sh $t8, 6($t7)                                     ## L:679  |    223 | store(oldClipFlag, ptrConvA, 0x06);
  vmadm $v12, $v12, $v14.h2                          ## L:665  |      ^ | invW *= nrD:ufract.zzzzZZZZ;
  vmadn $v13, $v00, $v00                             ## L:665  |    224 | invW *= nrD:ufract.zzzzZZZZ;
  vmudl $v29, $v09, $v13.h3                          ## L:672  | ***228 | invW = posClip * invW.wwwwWWWW;
  ssv $v13, 6, 34, $t7                               ## L:668  |      ^ | store(invW.w, ptrConvA, 0x20);
  vmadm $v29, $v08, $v13.h3                          ## L:672  |    229 | invW = posClip * invW.wwwwWWWW;
  ssv $v12, 14, 32, $t9                              ## L:669  |      ^ | store(invW.W, ptrConvB, 0x20);
  ssv $v13, 14, 34, $t9                              ## L:669  |    230 | store(invW.W, ptrConvB, 0x20);
  vmadn $v13, $v09, $v12.h3                          ## L:672  |      ^ | invW = posClip * invW.wwwwWWWW;
  ssv $v12, 6, 32, $t7                               ## L:668  |    231 | store(invW.w, ptrConvA, 0x20);
  vmadh $v12, $v08, $v12.h3                          ## L:672  |      ^ | invW = posClip * invW.wwwwWWWW;
  addiu $t7, $t7, 72                                 ## L:685  |  **234 | ptrConvA += 72;
  vmudl $v08, $v13, $v05.v                           ## L:673  |      ^ | posClip = invW * screenSize;
  vmadm $v08, $v12, $v05.v                           ## L:673  |    235 | posClip = invW * screenSize;
  vmadn $v09, $v13, $v04.v                           ## L:673  |    236 | posClip = invW * screenSize;
  vmadh $v08, $v12, $v04.v                           ## L:673  |    237 | posClip = invW * screenSize;
  sltu $at, $t7, $t2                                 ## L:685  |      ^ | ptrConvA += 72;
  sh $t8, 6($t9)                                     ## L:683  |    238 | store(oldClipFlag, ptrConvB, 0x06);
  vmadh $v08, $v06, $v30.e7                          ## L:674  |      ^ | posClip:sint = screenOffset:sint +* 1;
  slv $v08, 0, -72, $t7                              ## L:677  | ***242 | store(posClip:sint.xy, ptrConvA, 0x00);
  slv $v08, 8, 0, $t9                                ## L:681  |    243 | store(posClip:sint.XY, ptrConvB, 0x00);
  ssv $v08, 4, -68, $t7                              ## L:678  |    244 | store(posClip:sint.z, ptrConvA, 0x04);
  bne $at, $zero, LABEL_clipTriangle_000F            ## L:685  |    245 | ptrConvA += 72;
  ssv $v08, 12, 4, $t9                               ## L:682  |    246 | store(posClip:sint.Z, ptrConvB, 0x04);
  LABEL_clipTriangle_0010:
  addiu $s0, $t0, 65391                              ## L:694  |    247 | s32<$s0> fanWait = arraySize - 145;
  addiu $s4, $t2, 65500                              ## L:691  |    248 | u32<$s4> ptrVert0 = ptrBuff1 - 36;
  addiu $s5, $t3, 36                                 ## L:693  |    249 | u32<$s5> ptrVertInEnd = ptrWrite + 36;
  or $s6, $zero, $s4                                 ## L:692  |    250 | u32<$s6> ptrVertIn = ptrVert0;
  LABEL_clipTriangle_0012:
  or $a0, $zero, $s4                                 ## L:700  |    251 | ptrVertA = ptrVert0;
  addiu $s6, $s6, 65500                              ## L:698  |    252 | ptrVertIn -= 36;
  addiu $a2, $s6, 65500                              ## L:702  |    253 | ptrVertC = ptrVertIn - 36;
  jal RDPQ_Triangle_Send_Async                       ## L:705  |    254 | RDPQ_Triangle_Send_Async(ptrVertA, ptrVertB, ptrVertC, faceCull); ## Args: $a0, $a1, $a2, $v0
  or $a1, $zero, $s6                                 ## L:701  |    255 | ptrVertB = ptrVertIn;
  bgez $s0, RDPQ_Triangle_Send_End                   ## L:706  |    256 | if(fanWait >= 0) {
  ori $ra, $zero, RDPQ_Triangle_Clip                 ## L:581  |    257 | 
  RDPQ_Triangle_Clip:
  bne $s6, $s5, LABEL_clipTriangle_0012              ## L:709  |    258 | RDPQ_Triangle_Clip:
  nop                                                ## L:709  |    259 | RDPQ_Triangle_Clip:
  CLIP_RETURN:
  lhu $t7, %lo(CLIP_RA + 0)                          ## L:717  |    260 | u16 tmp = load(CLIP_RA);
  j $t7                                              ## L:720  |  **263 | goto tmp;
  lh $s4, %lo(RSPQ_SCRATCH_MEM + 18)                 ## L:719  |   *265 | s16<$s4> oldDMEM = load(RSPQ_SCRATCH_MEM, 18);

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