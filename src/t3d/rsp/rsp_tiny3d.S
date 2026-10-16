## Auto-generated file, transpiled with RSPL
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
#define HAS_NORMAL_MATRIX 1
#define MATRIX_TEMP_MUL CLIP_BUFFER_RESULT
#define MATRIX_SIZE 0x40
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
    RSPQ_DefineCommand T3DCmd_TriDraw, 8
    RSPQ_DefineCommand T3DCmd_MatrixStack, 8
    RSPQ_DefineCommand T3DCmd_SetScreenSize, 24
    RSPQ_DefineCommand T3DCmd_SetWord, 8
    RSPQ_DefineCommand T3DCmd_VertLoad, 12
    RSPQ_DefineCommand T3DCmd_LightSet, 16
    RSPQ_DefineCommand T3D_PageLoad, 8
    RSPQ_DefineCommand T3DCmd_MatProjectionSet, 4
    RSPQ_DefineCommand T3D_PageLoad, 16
    RSPQ_DefineCommand T3DCmd_SetFogState, 4
    RSPQ_DefineCommand T3DCmd_TriSync, 4
    RSPQ_DefineCommand T3DCmd_TriDraw_Strip, 8
    RSPQ_DefineCommand T3DCmd_TriDraw_Seq, 8
    RSPQ_DefineCommand T3D_PageLoad, 16
    RSPQ_DefineCommand T3D_PageLoad, 8
    RSPQ_DefineCommand T3D_PageLoad, 8
    RSPQ_DefineCommand T3D_PageLoad, 8
    RSPQ_DefineCommand T3D_PageLoad, 12
    RSPQ_DefineCommand T3D_PageLoad, 8
    RSPQ_DefineCommand T3D_PageLoad, 8
    RSPQ_DefineCommand T3DCmd_VertLoad_Impl, 12
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
CLIPPING_CODE_TARGET:
  ## hot-path cycles: 8
  lw $s0, %lo(UCODE_BUF_ADDR + 0)                    ## L:409  |      ^ | u32<$s0> codeAddr = load(UCODE_BUF_ADDR);
  addiu $t0, $zero, 1311                             ## L:410  |      2 | u16<$t0> codeSize = 0x0520 - 1;
  addiu $t1, $zero, 1                                ## L:413  |      3 | u8 pageState = 1;
  sb $t1, %lo(PAGE_STATE)($zero)                     ## L:414  |      4 | store(pageState, PAGE_STATE);
  ori $ra, $zero, %lo(CLIPPING_CODE_TARGET)          ## L:416  |      5 | RA = CLIPPING_CODE_TARGET;
  j DMAIn                                            ## L:417  |      6 | goto DMAIn;
  addiu $s0, $s0, 4096                               ## L:411  |     *8 | codeAddr += 0x1000;
T3DCmd_VertLoad_Impl:
  ## hot-path cycles: 141
  srl $s6, $a1, 24                                   ## L:377  |      ^ | u32 segment = addrIn >> 24;
  srl $s4, $a2, 16                                   ## L:441  |      2 | u32<$s4> prt3d = addressInOut >> 16;
  lw $s6, %lo(SEGMENT_TABLE)($s6)                    ## L:378  |      3 | segment = load(segment, SEGMENT_TABLE);
  andi $t0, $a0, 65535                               ## L:443  |      4 | u32<$t0> copySize = bufferSize & 0xFFFF;
  or $t2, $zero, $zero                               ## L:448  |      5 | dma_in_async(prt3d, dmaAddrRDRAM, copySize);
  addu $s7, $s4, $t0                                 ## L:444  |      6 | u32 ptr3dEnd = prt3d + copySize;
  addiu $t0, $t0, -1                                 ## L:448  |      7 | dma_in_async(prt3d, dmaAddrRDRAM, copySize);
  jal DMAExec                                        ## L:448  |      8 | dma_in_async(prt3d, dmaAddrRDRAM, copySize); ## Args: $t0, $t1, $s0, $s4, $t2
  addu $s0, $a1, $s6                                 ## L:379  |      9 | addrOut = addrIn + segment;
  ori $s6, $zero, %lo(MATRIX_NORMAL)                 ## L:369  |     10 | u16 address = MATRIX_NORMAL;
  ldv $v19, 8, 8, $s6                                ## L:371  |     11 | mat1 = load(address, 0x08).xyzwxyzw;
  ldv $v20, 0, 0, $s6                                ## L:370  |     12 | mat0 = load(address, 0x00).xyzwxyzw;
  ldv $v18, 8, 16, $s6                               ## L:372  |     13 | mat2 = load(address, 0x10).xyzwxyzw;
  ldv $v19, 0, 8, $s6                                ## L:371  |     14 | mat1 = load(address, 0x08).xyzwxyzw;
  ldv $v20, 8, 0, $s6                                ## L:370  |     15 | mat0 = load(address, 0x00).xyzwxyzw;
  jal loadCurrentMVPMat                              ## L:456  |     16 | loadCurrentMVPMat(mat0, mat1, mat2, mat3); ## Args: $v27, $v25, $v23, $v21
  ldv $v18, 0, 16, $s6                               ## L:372  |     17 | mat2 = load(address, 0x10).xyzwxyzw;
  vsubc $v29, $v00, $v30.e7                          ## L:501  |     18 | VTEMP = VZERO - 1;
  lbu $k0, %lo(TRI_COMMAND + 0)                      ## L:498  |      ^ | u8 isUnlit = load(TRI_COMMAND);
  ori $at, $zero, %lo(NORMAL_MASK_SHIFT)             ## L:458  |     19 | vec16 normMask = load(NORMAL_MASK_SHIFT, 0x00).xyzwxyzw;
  ldv $v17, 8, 0, $at                                ## L:458  |     20 | vec16 normMask = load(NORMAL_MASK_SHIFT, 0x00).xyzwxyzw;
  andi $s6, $a2, 65535                               ## L:475  |     21 | u32 ptrBuffA = addressInOut & 0xFFFF;
  ldv $v16, 0, 8, $at                                ## L:459  |     22 | vec16 normShift = load(NORMAL_MASK_SHIFT, 0x08).xyzwxyzw;
  ldv $v16, 8, 8, $at                                ## L:459  |     23 | vec16 normShift = load(NORMAL_MASK_SHIFT, 0x08).xyzwxyzw;
  ldv $v17, 0, 0, $at                                ## L:458  |     24 | vec16 normMask = load(NORMAL_MASK_SHIFT, 0x00).xyzwxyzw;
  ori $at, $zero, %lo(SCREEN_SCALE)                  ## L:462  |     25 | normMask.w = load(SCREEN_SCALE, 6).x;
  lsv $v17, 14, 6, $at                               ## L:463  |     26 | normMask.W = load(SCREEN_SCALE, 6).x;
  lsv $v17, 6, 6, $at                                ## L:462  |     27 | normMask.w = load(SCREEN_SCALE, 6).x;
  ori $sp, $zero, %lo(SCREEN_SCALE)                  ## L:494  |     28 | u16 ptrScreenScale = SCREEN_SCALE;
  addiu $s5, $s6, 65500                              ## L:476  |     29 | u32 ptrBuffB = ptrBuffA - 36;
  ori $at, $zero, %lo(VERT_CONSTS)                   ## L:466  |     30 | fogClampSlope.x = load(VERT_CONSTS, 0x08).x;
  lbu $s1, %lo(FOG_STORE_OFFSET + 0)                 ## L:490  |     31 | u8 fogStoreOffset = load(FOG_STORE_OFFSET);
  ori $t8, $zero, %lo(COLOR_AMBIENT)                 ## L:499  |     32 | u32 ptrAmbient = COLOR_AMBIENT;
  lsv $v15, 0, 8, $at                                ## L:466  |     33 | fogClampSlope.x = load(VERT_CONSTS, 0x08).x;
  sdv $v29, 0, 0, $s7                                ## L:502  |     34 | store(VTEMP.xyzw, ptr3dEnd, 0);
  ori $at, $zero, %lo(SCREEN_SCALE)                  ## L:467  |     35 | fogClampSlope.w = load(SCREEN_SCALE, 14).x;
  lsv $v15, 6, 14, $at                               ## L:467  |     36 | fogClampSlope.w = load(SCREEN_SCALE, 14).x;
  lsv $v15, 14, 14, $at                              ## L:468  |     37 | fogClampSlope.W = load(SCREEN_SCALE, 14).x;
  lbu $s2, %lo(ACTIVE_LIGHT_SIZE + 0)                ## L:480  |     38 | u8 ptrLightEnd = load(ACTIVE_LIGHT_SIZE);
  ori $at, $zero, %lo(SCREEN_OFFSET)                 ## L:472  |     39 | vec16<$v12> screenOffset = load(SCREEN_OFFSET).xyzwxyzw;
  ldv $v12, 8, 0, $at                                ## L:472  |     40 | vec16<$v12> screenOffset = load(SCREEN_OFFSET).xyzwxyzw;
  ldv $v12, 0, 0, $at                                ## L:472  |     41 | vec16<$v12> screenOffset = load(SCREEN_OFFSET).xyzwxyzw;
  ori $at, $zero, %lo(NORM_SCALE_W)                  ## L:473  |     42 | vec16<$v10> normScaleW = load(NORM_SCALE_W).xyzwxyzw;
  ldv $v10, 8, 0, $at                                ## L:473  |     43 | vec16<$v10> normScaleW = load(NORM_SCALE_W).xyzwxyzw;
  ldv $v10, 0, 0, $at                                ## L:473  |     44 | vec16<$v10> normScaleW = load(NORM_SCALE_W).xyzwxyzw;
  addiu $s2, $s2, %lo(LIGHT_DIR_COLOR)               ## L:481  |     45 | ptrLightEnd += LIGHT_DIR_COLOR;
  ori $at, $zero, %lo(UV_GEN_PARAMS)                 ## L:485  |     46 | uvGenArgs.XYZW = load(UV_GEN_PARAMS).xyzw;
  addiu $s6, $s6, 65464                              ## L:491  |     47 | ptrBuffA -= 72;
  ldv $v09, 8, 0, $at                                ## L:485  |     48 | uvGenArgs.XYZW = load(UV_GEN_PARAMS).xyzw;
  ori $at, $zero, %lo(SCREEN_UVGEN_SCALE)            ## L:486  |     49 | uvGenArgs.W = load(SCREEN_UVGEN_SCALE).x;
  lsv $v09, 14, 0, $at                               ## L:486  |     50 | uvGenArgs.W = load(SCREEN_UVGEN_SCALE).x;
  ori $at, $zero, %lo(UV_GEN_PARAMS)                 ## L:487  |     51 | uvGenArgs.xy = load(UV_GEN_PARAMS).xy;
  llv $v09, 0, 0, $at                                ## L:487  |     52 | uvGenArgs.xy = load(UV_GEN_PARAMS).xy;
  beq $k0, $zero, LABEL_T3DCmd_VertLoad_Impl_0001    ## L:505  |     53 | if(isUnlit) {
  llv $v09, 4, 0, $at                                ## L:488  |     54 | uvGenArgs.zw = load(UV_GEN_PARAMS).xy;
  ori $s2, $zero, %lo(LIGHT_DIR_COLOR)               ## L:506  |     55 | ptrLightEnd = LIGHT_DIR_COLOR;
  or $t8, $zero, $s7                                 ## L:507  |     56 | ptrAmbient = ptr3dEnd;
  LABEL_T3DCmd_VertLoad_Impl_0001:
  jal DMAWaitIdle                                    ## L:518  |     57 | dma_await();
  lbu $s0, %lo(UCODE_BUF_ADDR + 0)                   ## L:514  |     58 | u8<$s0> baseTileMask = load(UCODE_BUF_ADDR);
  lqv $v08, 0, 0, $s4                                ## L:521  |     59 | vec16<$v08> pos = load(prt3d, 0x00);
  vand $v07, $v17, $v08.h3                           ## L:523  |  ***63 | vec16<$v07> norm = normMask & pos.wwwwWWWW;
  j LOOP_START                                       ## L:530  |      ^ | goto LOOP_START;
  vmudn $v07, $v07, $v16.v                           ## L:524  | ****68 | norm *= normShift;
  LOOP_TRAIL:
  slv $v03, 0, 12, $s6                               ## L:534  |      1 | store(uv.xy, ptrBuffA, 0x0C);
  beq $s4, $s7, RSPQ_Loop                            ## L:536  |      2 | if(prt3d == ptr3dEnd)goto RSPQ_Loop;
  slv $v03, 4, 12, $s5                               ## L:535  |     *4 | store(uv.zw, ptrBuffB, 0x0C);
  LOOP_START:
  vmudn $v14, $v28, $v08.h0                          ## L:306  | ****************************************************************69 | out = mat0  * vec.xxxxXXXX;
  vmadh $v13, $v27, $v08.h0                          ## L:306  |     70 | out = mat0  * vec.xxxxXXXX;
  ori $s3, $zero, %lo(LIGHT_DIR_COLOR)               ## L:566  |      ^ | ptrLight = LIGHT_DIR_COLOR;
  lhu $k1, %lo(VERTEX_FX_FUNC + 0)                   ## L:554  |     71 | vertexFxFunc = load(VERTEX_FX_FUNC);
  vmadn $v14, $v26, $v08.h1                          ## L:307  |      ^ | out = mat1 +* vec.yyyyYYYY;
  vmadh $v13, $v25, $v08.h1                          ## L:307  |     72 | out = mat1 +* vec.yyyyYYYY;
  lpv $v02, 0, 8, $s3                                ## L:569  |      ^ | vec16<$v02> lightDirVec  = load_vec_s8(ptrLight, 8);
  lbu $a2, 19($s4)                                   ## L:547  |     73 | baseTile = load(prt3d, 0x13);
  vmadn $v14, $v24, $v08.h2                          ## L:308  |      ^ | out = mat2 +* vec.zzzzZZZZ;
  vmadh $v13, $v23, $v08.h2                          ## L:308  |     74 | out = mat2 +* vec.zzzzZZZZ;
  addiu $s6, $s6, 72                                 ## L:552  |      ^ | ptrBuffA += 72;
  vmadn $v14, $v22, $v30.e7                          ## L:309  |     75 | out = mat3 +* 1;
  addu $fp, $s6, $s1                                 ## L:555  |      ^ | fogA = ptrBuffA + fogStoreOffset;
  lbu $k0, 15($s3)                                   ## L:570  |     76 | u8 isPointLight = load(ptrLight, 15);
  vmadh $v13, $v21, $v30.e7                          ## L:309  |      ^ | out = mat3 +* 1;
  vmulf $v29, $v20, $v07.h0                          ## L:559  |     77 | VTEMP:sfract = matN0:sfract  * norm.xxxxXXXX;
  addiu $s5, $s5, 72                                 ## L:553  |      ^ | ptrBuffB += 72;
  or $t9, $zero, $zero                               ## L:550  |     78 | u8<$t9> mvMatrixLoaded = 0;
  vmacf $v29, $v19, $v07.h1                          ## L:560  |      ^ | VTEMP:sfract = matN1:sfract +* norm.yyyyYYYY;
  vmacf $v07, $v18, $v07.h2                          ## L:561  |     79 | norm         = matN2:sfract +* norm.zzzzZZZZ;
  luv $v11, 0, 0, $t8                                ## L:575  |      ^ | lightColor = load_vec_u8(ptrAmbient, 0);
  and $a2, $a2, $s0                                  ## L:548  |     80 | baseTile &= baseTileMask;
  vmudl $v06, $v14, $v10.v                           ## L:577  |      ^ | posClip = orgPosClip * normScaleW:ufract;
  vmadm $v05, $v13, $v10.v                           ## L:577  |     81 | posClip = orgPosClip * normScaleW:ufract;
  beq $s3, $s2, LABEL_T3DCmd_VertLoad_Impl_0003      ## L:579  |      ^ | if(ptrLight != ptrLightEnd)
  vmadn $v06, $v00, $v00                             ## L:577  |     82 | posClip = orgPosClip * normScaleW:ufract;
  LABEL_T3DCmd_VertLoad_Impl_0004:
  vmulf $v01, $v07, $v02.v                           ## L:583  |     83 | vec16<$v01> lightDirScale = norm:sfract * lightDirVec:sfract;
  luv $v04, 0, 0, $s3                                ## L:584  |      ^ | color = load_vec_u8(ptrLight);
  bne $k0, $zero, pointLight                         ## L:586  |     84 | if(isPointLight) {
  ori $ra, $zero, LABEL_T3DCmd_VertLoad_Impl_0006    ## L:1028 |     85 | s32 stackPtr = load(MATRIX_STACK_PTR);
  LABEL_T3DCmd_VertLoad_Impl_0006:
  lbu $k0, 31($s3)                                   ## L:600  |     86 | isPointLight =  load(ptrLight, 15);
  addiu $s3, $s3, 16                                 ## L:598  |     87 | ptrLight += 16;
  vmulu $v29, $v04, $v01.h0                          ## L:594  |      ^ | VTEMP = color:ufract  * lightDirScale:ufract.xxxxXXXX;
  vmacu $v29, $v04, $v01.h1                          ## L:595  |     88 | VTEMP = color:ufract +* lightDirScale:ufract.yyyyYYYY;
  ori $ra, $zero, LABEL_T3DCmd_VertLoad_Impl_0007    ## L:1028 |      ^ | s32 stackPtr = load(MATRIX_STACK_PTR);
  vmacu $v29, $v04, $v01.h2                          ## L:596  |     89 | VTEMP = color:ufract +* lightDirScale:ufract.zzzzZZZZ;
  beq $t9, $s3, loadCurrentMVPMat                    ## L:602  |      ^ | if(mvMatrixLoaded == ptrLight) {
  lpv $v02, 0, 8, $s3                                ## L:599  |     90 | lightDirVec = load_vec_s8(ptrLight, 8);
  LABEL_T3DCmd_VertLoad_Impl_0007:
  bne $s3, $s2, LABEL_T3DCmd_VertLoad_Impl_0004      ## L:606  |     91 | lightColor:sint += VTEMP;
  vadd $v11, $v11, $v29.v                            ## L:606  |    *93 | lightColor:sint += VTEMP;
  LABEL_T3DCmd_VertLoad_Impl_0003:
  vch $v29, $v13, $v13.h3                            ## L:619  |     94 | u32 rejCodes = clip(orgPosClip, orgPosClip.wwwwWWWW);
  sdv $v06, 0, 24, $s6                               ## L:648  |      ^ | store(posClip.xyzw, ptrBuffA, 0x10);
  ldv $v03, 0, 24, $s4                               ## L:685  |     95 | uv = load(prt3d, 0x18).xyzw;
  vcl $v29, $v14, $v14.h3                            ## L:619  |      ^ | u32 rejCodes = clip(orgPosClip, orgPosClip.wwwwWWWW);
  cfc2 $t4, $vcc                                     ## L:619  |     96 | u32 rejCodes = clip(orgPosClip, orgPosClip.wwwwWWWW);
  vrcph $v16.e3, $v05.e3                             ## L:653  |      ^ | invWRaw.w = invert_half(posClip).w;
  vrcpl $v08.e3, $v06.e3                             ## L:653  |     97 | invWRaw.w = invert_half(posClip).w;
  luv $v04, 0, 16, $s4                               ## L:612  |      ^ | color = load_vec_u8(prt3d, 0x10);
  vch $v29, $v05, $v13.h3                            ## L:620  |     98 | u32 clipCodes = clip(posClip, orgPosClip.wwwwWWWW);
  vcl $v29, $v06, $v14.h3                            ## L:620  |     99 | u32 clipCodes = clip(posClip, orgPosClip.wwwwWWWW);
  andi $t6, $t4, 1803                                ## L:352  |      ^ | res = clipCode & 0b0000'0111'0000'1011;
  vrcph $v16.e3, $v05.e7                             ## L:654  |    100 | invWRaw.W = invert_half(posClip).W;
  cfc2 $t3, $vcc                                     ## L:620  |      ^ | u32 clipCodes = clip(posClip, orgPosClip.wwwwWWWW);
  srl $t5, $t4, 4                                    ## L:629  |    101 | rejCodesB = rejCodes >> 4;
  vrcpl $v08.e7, $v06.e7                             ## L:654  |      ^ | invWRaw.W = invert_half(posClip).W;
  andi $t5, $t5, 1803                                ## L:352  |    102 | res = clipCode & 0b0000'0111'0000'1011;
  vrcph $v16.e7, $v00.e7                             ## L:654  |      ^ | invWRaw.W = invert_half(posClip).W;
  vmudh $v29, $v12, $v30.e7                          ## L:636  |    103 | VTEMP:sint = screenOffset:sint * 1;
  andi $k0, $t3, 771                                 ## L:342  |      ^ | res = clipCode & 0b0000'0011'0000'0011;
  vmadn $v29, $v15, $v05.h2                          ## L:637  |    104 | VTEMP:sint = fogClampSlope:ufract +* posClip:sint.zzzzZZZZ;
  srl $t2, $k0, 5                                    ## L:343  |      ^ | u32 tmp = res >> 5;
  srl $t7, $t3, 4                                    ## L:622  |    105 | clipCodeB = clipCodes >> 4;
  vmadh $v01, $v17, $v05.h2                          ## L:638  |      ^ | vec16<$v01> fogV = normMask:sint +* posClip:sint.zzzzZZZZ;
  vmudl $v02, $v06, $v08.h3                          ## L:658  |    106 | invW:sfract = posClip * invWRaw.wwwwWWWW;
  or $k0, $k0, $t2                                   ## L:344  |      ^ | res |= tmp;
  vmadm $v02, $v05, $v08.h3                          ## L:658  |    107 | invW:sfract = posClip * invWRaw.wwwwWWWW;
  andi $t7, $t7, 771                                 ## L:342  |      ^ | res = clipCode & 0b0000'0011'0000'0011;
  srl $t2, $t7, 5                                    ## L:343  |    108 | u32 tmp = res >> 5;
  vmadn $v02, $v06, $v16.h3                          ## L:658  |      ^ | invW:sfract = posClip * invWRaw.wwwwWWWW;
  vlt $v01, $v01, $v15.e0                            ## L:639  |    109 | fogV = min(fogV, fogClampSlope.xxxxxxxx);
  or $t7, $t7, $t2                                   ## L:344  |      ^ | res |= tmp;
  srl $t2, $t6, 4                                    ## L:353  |    110 | u32 tmp = res >> 4;
  TAG_LightMul: vmulf $v04, $v04, $v11.v                           ## L:644  |      ^ | color:sfract *= lightColor:ufract;
  nor $t6, $t6, $t2                                  ## L:354  |    111 | res = res ~| tmp;
  srl $t2, $t5, 4                                    ## L:353  |    112 | u32 tmp = res >> 4;
  vsubc $v29, $v10, $v02.h3                          ## L:662  |      ^ | VTEMP = normScaleW:ufract - invW:ufract.wwwwWWWW;
  vaddc $v02, $v08, $v08.v                           ## L:663  |    113 | invW = invWRaw + invWRaw;
  nor $t5, $t5, $t2                                  ## L:354  |      ^ | res = res ~| tmp;
  vadd $v11, $v16, $v16.v                            ## L:663  |    114 | invW = invWRaw + invWRaw;
  sb $t5, 7($s5)                                     ## L:699  |      ^ | store(rejCodesB:u8, ptrBuffB, 0x07);
  vaddc $v03, $v03, $v09.v                           ## L:701  |    115 | uv += uvGenArgs;
  ldv $v14, 0, 8, $sp                                ## L:672  |      ^ | orgPosClip = load(ptrScreenScale).xyzwxyzw;
  vmudm $v04, $v04, $v31.e6                          ## L:645  |    116 | color >>= 7;
  sdv $v05, 8, 16, $s5                               ## L:649  |      ^ | store(posClip.XYZW, ptrBuffB, 0x10);
  lqv $v08, 0, 32, $s4                               ## L:703  |    117 | pos = load(prt3d, 0x20);
  vmudl $v02, $v02, $v29.h2                          ## L:664  |      ^ | invW *= VTEMP:ufract.zzzzZZZZ;
  ldv $v13, 8, 0, $sp                                ## L:672  |    118 | orgPosClip = load(ptrScreenScale).xyzwxyzw;
  vmadm $v11, $v11, $v29.h2                          ## L:664  |      ^ | invW *= VTEMP:ufract.zzzzZZZZ;
  ldv $v13, 0, 0, $sp                                ## L:672  |    119 | orgPosClip = load(ptrScreenScale).xyzwxyzw;
  vmadn $v02, $v00, $v00                             ## L:664  |      ^ | invW *= VTEMP:ufract.zzzzZZZZ;
  vmudh $v04, $v04, $v09.e6                          ## L:646  |    120 | color:sint *= uvGenArgs:sint.Z;
  ldv $v14, 8, 8, $sp                                ## L:672  |      ^ | orgPosClip = load(ptrScreenScale).xyzwxyzw;
  or $t7, $t7, $a2                                   ## L:627  |    121 | clipCodeB |= baseTile;
  addiu $s4, $s4, 32                                 ## L:708  |    122 | prt3d += 0x20;
  ssv $v11, 14, 32, $s5                              ## L:667  |    123 | store(invW.W, ptrBuffB, 0x20);
  vmudl $v29, $v06, $v02.h3                          ## L:670  |      ^ | invW = posClip * invW.wwwwWWWW;
  vmadm $v29, $v05, $v02.h3                          ## L:670  |    124 | invW = posClip * invW.wwwwWWWW;
  ssv $v02, 6, 34, $s6                               ## L:666  |      ^ | store(invW.w, ptrBuffA, 0x20);
  ssv $v02, 14, 34, $s5                              ## L:667  |    125 | store(invW.W, ptrBuffB, 0x20);
  vmadn $v02, $v06, $v11.h3                          ## L:670  |      ^ | invW = posClip * invW.wwwwWWWW;
  ssv $v11, 6, 32, $s6                               ## L:666  |    126 | store(invW.w, ptrBuffA, 0x20);
  vmadh $v11, $v05, $v11.h3                          ## L:670  |      ^ | invW = posClip * invW.wwwwWWWW;
  sdv $v06, 8, 24, $s5                               ## L:649  |    127 | store(posClip.XYZW, ptrBuffB, 0x10);
  sb $t6, 7($s6)                                     ## L:696  |    128 | store(rejCodesA:u8, ptrBuffA, 0x07);
  sdv $v05, 0, 16, $s6                               ## L:648  |    129 | store(posClip.xyzw, ptrBuffA, 0x10);
  vmudl $v05, $v02, $v14.v                           ## L:673  |      ^ | posClip = invW * orgPosClip;
  or $k0, $k0, $a2                                   ## L:626  |    130 | clipCodeA |= baseTile;
  vmadm $v05, $v11, $v14.v                           ## L:673  |      ^ | posClip = invW * orgPosClip;
  suv $v04, 0, 8, $s6                                ## L:678  |    131 | @Barrier("color-fog-a") store_vec_u8(color.x, ptrBuffA, 0x08); ## Barrier: 0x1
  vmadn $v06, $v02, $v13.v                           ## L:673  |      ^ | posClip = invW * orgPosClip;
  vmadh $v05, $v11, $v13.v                           ## L:673  |    132 | posClip = invW * orgPosClip;
  sbv $v01, 7, 0, $fp                                ## L:681  |      ^ | @Barrier("color-fog-a") store_byte_lo(fogV.w, fogA); ## Barrier: 0x1
  vmadh $v05, $v12, $v30.e7                          ## L:674  |    133 | posClip:sint = screenOffset:sint +* 1;
  suv $v04, 4, 8, $s5                                ## L:679  |      ^ | @Barrier("color-fog-b") store_vec_u8(color.X, ptrBuffB, 0x08); ## Barrier: 0x2
  vor $v11, $v00, $v07                               ## L:704  |    134 | vec16<$v11> oldNorm = norm;
  sb $k0, 6($s6)                                     ## L:695  |      ^ | store(clipCodeA:u8, ptrBuffA, 0x06);
  sbv $v01, 15, 36, $fp                              ## L:682  |    135 | @Barrier("color-fog-b") store_byte_lo(fogV.W, fogA, 36); ## Barrier: 0x2
  vand $v07, $v17, $v08.h3                           ## L:705  |      ^ | norm = normMask & pos.wwwwWWWW;
  sb $t7, 6($s5)                                     ## L:698  |    136 | store(clipCodeB:u8, ptrBuffB, 0x06);
  slv $v05, 8, 0, $s5                                ## L:692  |    137 | store(posClip:sint.XY, ptrBuffB, 0x00);
  ssv $v05, 12, 4, $s5                               ## L:693  |    138 | store(posClip:sint.Z, ptrBuffB, 0x04);
  ssv $v05, 4, 4, $s6                                ## L:690  |    139 | store(posClip:sint.z, ptrBuffA, 0x04);
  vmudn $v07, $v07, $v16.v                           ## L:706  |      ^ | norm *= normShift;
  jal $k1                                            ## L:710  |    140 | vertexFxFunc();
  slv $v05, 0, 0, $s6                                ## L:689  |    141 | store(posClip:sint.xy, ptrBuffA, 0x00);
VertexFX_Spherical:
  ## hot-path cycles: 34
  vge $v05, $v05, $v00.e0                            ## L:730  |      ^ | posClipInt = posClipInt >= 0;
  vsubc $v04, $v05, $v12.v                           ## L:731  |   ***5 | uvOffsetFactor = posClipInt - screenOffset;
  vlt $v04, $v04, $v12                               ## L:732  |   ***9 | uvOffsetFactor = uvOffsetFactor < screenOffset;
  vmulf $v03, $v11, $v09.v                           ## L:733  |     10 | uv:sfract = normal * uvGenArgs;
  vmudn $v04, $v04, $v09.e7                          ## L:735  |   **13 | uvOffsetFactor *= uvGenArgs.W;
  vaddc $v03, $v03, $v09.e0                          ## L:739  |     14 | uv += uvGenArgs.x;
  vmulf $v04, $v04, $v11.h2                          ## L:736  |   **17 | uvOffsetFactor:sfract *= normal.zzzzZZZZ;
  vmulf $v04, $v04, $v09.e0                          ## L:737  |  ***21 | uvOffsetFactor:sfract *= uvGenArgs.x;
  vaddc $v03, $v03, $v04.v                           ## L:740  |  ***25 | uv += uvOffsetFactor;
  slv $v03, 8, 12, $s5                               ## L:743  |  ***29 | store(uv.XY, ptrBuffB, 0x0C);
  bne $s4, $s7, LOOP_START                           ## L:719  |     30 | if(prt3d == ptr3dEnd)goto RSPQ_Loop;
  slv $v03, 0, 12, $s6                               ## L:742  |     31 | store(uv.xy, ptrBuffA, 0x0C);
  j RSPQ_Loop                                        ## L:719  |     32 | if(prt3d == ptr3dEnd)goto RSPQ_Loop;
  nop                                                ## L:719  |    *34 | if(prt3d == ptr3dEnd)goto RSPQ_Loop;
VertexFX_CelShadeColor:
  ## hot-path cycles: 11
  vge $v04, $v04, $v04.h1                            ## L:754  |      ^ | color = max(color, color.yyyyYYYY);
  vge $v04, $v04, $v04.h2                            ## L:755  |   ***5 | color = max(color, color.zzzzZZZZ);
  vmov $v03.e2, $v04.e4                              ## L:757  |   ***9 | uv.z = color.X;
  j LOOP_TRAIL                                       ## L:758  |      ^ | goto LOOP_TRAIL;
  vmov $v03.e0, $v04.e0                              ## L:756  |    *11 | uv.x = color.x;
VertexFX_CelShadeAlpha:
  ## hot-path cycles: 3
  vmov $v03.e2, $v04.e7                              ## L:768  |      ^ | uv.z = color.W;
  j LOOP_TRAIL                                       ## L:770  |      ^ | goto LOOP_TRAIL;
  vmov $v03.e0, $v04.e3                              ## L:767  |     *3 | uv.x = color.w;
VertexFX_Outline:
  ## hot-path cycles: 11
  vmulf $v29, $v11, $v09.v                           ## L:780  |      ^ | VTEMP = normal:sfract * uvGenArgs;
  vmadh $v05, $v05, $v30.e7                          ## L:781  |      2 | posClipInt:sint = posClipInt:sint +* 1;
  slv $v05, 0, 0, $s6                                ## L:786  |   ***6 | store(posClipInt.xy, ptrBuffA, 0x00);
  bne $s4, $s7, LOOP_START                           ## L:719  |      7 | if(prt3d == ptr3dEnd)goto RSPQ_Loop;
  slv $v05, 8, 0, $s5                                ## L:787  |      8 | store(posClipInt.XY, ptrBuffB, 0x00);
  j RSPQ_Loop                                        ## L:719  |      9 | if(prt3d == ptr3dEnd)goto RSPQ_Loop;
  nop                                                ## L:719  |    *11 | if(prt3d == ptr3dEnd)goto RSPQ_Loop;
pointLight:
  ## hot-path cycles: 89
  bne $t9, $zero, LABEL_pointLight_000A              ## L:803  |      ^ | if(!mvMatrixLoaded) {
  lhu $t7, 14($s3)                                   ## L:802  |      2 | lightSize:u16 = load(ptrLight, 14);
  ori $at, $zero, %lo(MATRIX_MV)                     ## L:359  |      3 | mat0 = load(MATRIX_MV, 0x00).xyzwxyzw;
  ldv $v27, 0, 0, $at                                ## L:359  |      4 | mat0 = load(MATRIX_MV, 0x00).xyzwxyzw;
  ldv $v27, 8, 0, $at                                ## L:359  |      5 | mat0 = load(MATRIX_MV, 0x00).xyzwxyzw;
  ldv $v28, 0, 8, $at                                ## L:359  |      6 | mat0 = load(MATRIX_MV, 0x00).xyzwxyzw;
  ldv $v28, 8, 8, $at                                ## L:359  |      7 | mat0 = load(MATRIX_MV, 0x00).xyzwxyzw;
  ldv $v25, 0, 16, $at                               ## L:360  |      8 | mat1 = load(MATRIX_MV, 0x10).xyzwxyzw;
  ldv $v25, 8, 16, $at                               ## L:360  |      9 | mat1 = load(MATRIX_MV, 0x10).xyzwxyzw;
  ldv $v26, 0, 24, $at                               ## L:360  |     10 | mat1 = load(MATRIX_MV, 0x10).xyzwxyzw;
  ldv $v26, 8, 24, $at                               ## L:360  |     11 | mat1 = load(MATRIX_MV, 0x10).xyzwxyzw;
  ldv $v23, 0, 32, $at                               ## L:361  |     12 | mat2 = load(MATRIX_MV, 0x20).xyzwxyzw;
  ldv $v23, 8, 32, $at                               ## L:361  |     13 | mat2 = load(MATRIX_MV, 0x20).xyzwxyzw;
  ldv $v24, 0, 40, $at                               ## L:361  |     14 | mat2 = load(MATRIX_MV, 0x20).xyzwxyzw;
  ldv $v24, 8, 40, $at                               ## L:361  |     15 | mat2 = load(MATRIX_MV, 0x20).xyzwxyzw;
  ldv $v22, 8, 56, $at                               ## L:362  |     16 | mat3 = load(MATRIX_MV, 0x30).xyzwxyzw;
  vmudn $v28, $v28, $v08.h0                          ## L:306  |      ^ | out = mat0  * vec.xxxxXXXX;
  vmadh $v27, $v27, $v08.h0                          ## L:306  |     17 | out = mat0  * vec.xxxxXXXX;
  ldv $v22, 0, 56, $at                               ## L:362  |      ^ | mat3 = load(MATRIX_MV, 0x30).xyzwxyzw;
  ldv $v21, 8, 48, $at                               ## L:362  |     18 | mat3 = load(MATRIX_MV, 0x30).xyzwxyzw;
  vmadn $v28, $v26, $v08.h1                          ## L:307  |      ^ | out = mat1 +* vec.yyyyYYYY;
  ldv $v21, 0, 48, $at                               ## L:362  |     19 | mat3 = load(MATRIX_MV, 0x30).xyzwxyzw;
  vmadh $v27, $v25, $v08.h1                          ## L:307  |      ^ | out = mat1 +* vec.yyyyYYYY;
  vmadn $v28, $v24, $v08.h2                          ## L:308  |     20 | out = mat2 +* vec.zzzzZZZZ;
  vmadh $v27, $v23, $v08.h2                          ## L:308  |     21 | out = mat2 +* vec.zzzzZZZZ;
  vmadn $v28, $v22, $v30.e7                          ## L:309  |     22 | out = mat3 +* 1;
  vmadh $v27, $v21, $v30.e7                          ## L:309  |     23 | out = mat3 +* 1;
  vmudl $v28, $v28, $v31.e3                          ## L:809  |   **26 | vertPos >>= 4;
  or $t9, $zero, $s2                                 ## L:810  |      ^ | mvMatrixLoaded = ptrLightEnd;
  vmadm $v27, $v27, $v31.e3                          ## L:809  |     27 | vertPos >>= 4;
  vmadn $v28, $v00, $v00                             ## L:809  |     28 | vertPos >>= 4;
  LABEL_pointLight_000A:
  ldv $v23, 0, 8, $s3                                ## L:817  |      ^ | ptPos:sint.xyzw = load(ptrLight, 8).xyzw;
  ldv $v23, 8, 8, $s3                                ## L:818  |     29 | ptPos:sint.XYZW = load(ptrLight, 8).xyzw;
  vmudm $v23, $v23, $v31.e5                          ## L:820  |  ***33 | ptPos = ptPos:sint >> 6;
  vmadn $v24, $v00, $v00                             ## L:820  |     34 | ptPos = ptPos:sint >> 6;
  vsubc $v24, $v24, $v28.v                           ## L:821  |  ***38 | ptPos = ptPos - vertPos;
  vsub $v23, $v23, $v27.v                            ## L:821  |     39 | ptPos = ptPos - vertPos;
  vmudl $v21, $v24, $v24.v                           ## L:824  |   **42 | lightVertDot = ptPos * ptPos;
  vmadm $v21, $v23, $v24.v                           ## L:824  |     43 | lightVertDot = ptPos * ptPos;
  vmadn $v22, $v24, $v23.v                           ## L:824  |     44 | lightVertDot = ptPos * ptPos;
  vmadh $v21, $v23, $v23.v                           ## L:824  |     45 | lightVertDot = ptPos * ptPos;
  andi $t7, $t7, 32767                               ## L:813  |      ^ | lightSize &= 0x7FFF;
  vaddc $v26, $v22, $v22.h1                          ## L:825  |   **48 | mat1         = lightVertDot + lightVertDot.yyyyYYYY;
  vadd $v25, $v21, $v21.h1                           ## L:825  |     49 | mat1         = lightVertDot + lightVertDot.yyyyYYYY;
  sll $t7, $t7, 16                                   ## L:814  |      ^ | lightSize <<= 16;
  vaddc $v22, $v22, $v26.h2                          ## L:826  |   **52 | lightVertDot = lightVertDot + mat1.zzzzZZZZ;
  vadd $v21, $v21, $v25.h2                           ## L:826  |     53 | lightVertDot = lightVertDot + mat1.zzzzZZZZ;
  mtc2 $t7, $v26.e3                                  ## L:828  |      ^ | mat1.w = lightSize;
  srl $at, $t7, 16                                   ## L:828  |     54 | mat1.w = lightSize;
  lbu $t7, 14($s3)                                   ## L:830  |   **57 | lightSize:u8 = load(ptrLight, 14);
  vrsqh $v21.e0, $v21.e0                             ## L:834  |      ^ | lightVertDot.x = invert_half_sqrt(lightVertDot).x;
  vrsql $v22.e0, $v22.e0                             ## L:834  |     58 | lightVertDot.x = invert_half_sqrt(lightVertDot).x;
  mtc2 $at, $v25.e3                                  ## L:828  |      ^ | mat1.w = lightSize;
  vrsqh $v21.e0, $v21.e4                             ## L:835  |   **61 | lightVertDot.X = invert_half_sqrt(lightVertDot).X;
  vrsql $v22.e4, $v22.e4                             ## L:835  |     62 | lightVertDot.X = invert_half_sqrt(lightVertDot).X;
  vrsqh $v21.e4, $v00.e0                             ## L:835  |     63 | lightVertDot.X = invert_half_sqrt(lightVertDot).X;
  vmudl $v01, $v22, $v26.e3                          ## L:836  |   **66 | lightRes = lightVertDot * mat1.w;
  vmadm $v01, $v21, $v26.e3                          ## L:836  |     67 | lightRes = lightVertDot * mat1.w;
  sra $t7, $t7, 7                                    ## L:831  |      ^ | lightSize >>= 7;
  vmadn $v01, $v22, $v25.e3                          ## L:836  |     68 | lightRes = lightVertDot * mat1.w;
  bne $t7, $zero, LABEL_pointLight_000B              ## L:838  |      ^ | if(!lightSize) {
  vmadh $v01, $v21, $v25.e3                          ## L:836  |     69 | lightRes = lightVertDot * mat1.w;
  vmudn $v22, $v22, $v31.e7                          ## L:841  |     70 | lightVertDot *= 256;
  vmadh $v21, $v21, $v31.e7                          ## L:841  |     71 | lightVertDot *= 256;
  vmulf $v01, $v01, $v01.v                           ## L:843  |    *73 | lightRes:sfract *= lightRes:sfract;
  vmudl $v08, $v24, $v22.h0                          ## L:845  |     74 | pos:sint = ptPos * lightVertDot.xxxxXXXX;
  vmadm $v08, $v23, $v22.h0                          ## L:845  |     75 | pos:sint = ptPos * lightVertDot.xxxxXXXX;
  vmadn $v08, $v24, $v21.h0                          ## L:845  |     76 | pos:sint = ptPos * lightVertDot.xxxxXXXX;
  vmadh $v08, $v23, $v21.h0                          ## L:845  |     77 | pos:sint = ptPos * lightVertDot.xxxxXXXX;
  vmulf $v08, $v08, $v01.h0                          ## L:846  |  ***81 | pos:sfract *= lightRes:sfract.xxxxXXXX;
  beq $zero, $zero, LABEL_pointLight_000C            ## L:849  |      ^ | lightRes = pos:sfract * norm:sfract;
  vmulf $v01, $v08, $v07.v                           ## L:849  | ****86 | lightRes = pos:sfract * norm:sfract;
  LABEL_pointLight_000B:
  vmulf $v01, $v01, $v01.v                           ## L:852  |      1 | lightRes:sfract *= lightRes:sfract;
  vmov $v01.e1, $v00.e0                              ## L:853  |      2 | lightRes.y = 0; lightRes.z = 0;
  vmov $v01.e2, $v00.e0                              ## L:853  |      3 | lightRes.y = 0; lightRes.z = 0;
  vmov $v01.e5, $v00.e0                              ## L:854  |      4 | lightRes.Y = 0; lightRes.Z = 0;
  vmov $v01.e6, $v00.e0                              ## L:854  |      5 | lightRes.Y = 0; lightRes.Z = 0;
  LABEL_pointLight_000C:
  jr $ra                                             ## L:855  | *********************************************************************************87 | }
  nop                                                ## L:855  |    *89 | }
loadCurrentMVPMat:
  ## hot-path cycles: 19
  ori $at, $zero, %lo(MATRIX_MVP)                    ## L:862  |      ^ | mat0 = load(MATRIX_MVP, 0x00).xyzwxyzw;
  ldv $v27, 0, 0, $at                                ## L:862  |      2 | mat0 = load(MATRIX_MVP, 0x00).xyzwxyzw;
  ldv $v27, 8, 0, $at                                ## L:862  |      3 | mat0 = load(MATRIX_MVP, 0x00).xyzwxyzw;
  ldv $v25, 0, 16, $at                               ## L:863  |      4 | mat1 = load(MATRIX_MVP, 0x10).xyzwxyzw;
  ldv $v28, 0, 8, $at                                ## L:862  |      5 | mat0 = load(MATRIX_MVP, 0x00).xyzwxyzw;
  ldv $v25, 8, 16, $at                               ## L:863  |      6 | mat1 = load(MATRIX_MVP, 0x10).xyzwxyzw;
  ldv $v23, 8, 32, $at                               ## L:864  |      7 | mat2 = load(MATRIX_MVP, 0x20).xyzwxyzw;
  ldv $v26, 0, 24, $at                               ## L:863  |      8 | mat1 = load(MATRIX_MVP, 0x10).xyzwxyzw;
  ldv $v26, 8, 24, $at                               ## L:863  |      9 | mat1 = load(MATRIX_MVP, 0x10).xyzwxyzw;
  ldv $v23, 0, 32, $at                               ## L:864  |     10 | mat2 = load(MATRIX_MVP, 0x20).xyzwxyzw;
  ldv $v24, 0, 40, $at                               ## L:864  |     11 | mat2 = load(MATRIX_MVP, 0x20).xyzwxyzw;
  ldv $v24, 8, 40, $at                               ## L:864  |     12 | mat2 = load(MATRIX_MVP, 0x20).xyzwxyzw;
  ldv $v21, 0, 48, $at                               ## L:865  |     13 | mat3 = load(MATRIX_MVP, 0x30).xyzwxyzw;
  ldv $v21, 8, 48, $at                               ## L:865  |     14 | mat3 = load(MATRIX_MVP, 0x30).xyzwxyzw;
  ldv $v22, 0, 56, $at                               ## L:865  |     15 | mat3 = load(MATRIX_MVP, 0x30).xyzwxyzw;
  ldv $v22, 8, 56, $at                               ## L:865  |     16 | mat3 = load(MATRIX_MVP, 0x30).xyzwxyzw;
  jr $ra                                             ## L:866  |     17 | }
  ldv $v28, 8, 8, $at                                ## L:862  |    *19 | mat0 = load(MATRIX_MVP, 0x00).xyzwxyzw;
T3DCmd_SetScreenSize:
  ## hot-path cycles: 4
  lw $t4, %lo(RSPQ_DMEM_BUFFER  -8)($gp)             
  j T3D_PageLoad                                     ## L:881  |      2 | goto T3D_PageLoad;
  lw $t5, %lo(RSPQ_DMEM_BUFFER  -4)($gp)             
.align 3
T3DCmd_SetFogState:
  ## hot-path cycles: 3
  T3D_WINDOW_END: # inline-ASM                       ## L:896  |      ^ | asm("T3D_WINDOW_END:");
  j RSPQ_Loop                                        ## L:898  |      1 | }
  sb $a0, %lo(FOG_STORE_OFFSET)($zero)               ## L:897  |     *3 | store(enabled, FOG_STORE_OFFSET);
T3DCmd_LightSet:
  ## hot-path cycles: 7
  beq $a2, $zero, LABEL_T3DCmd_LightSet_000D         ## L:911  |      ^ | if(dirXYZ0) {
  sw $a1, 0($a0)                                     ## L:909  |      2 | store(rgba8, addr, 0);
  sw $a2, 8($a0)                                     ## L:912  |      3 | store(dirXYZ0, addr, 8);
  sw $a3, 12($a0)                                    ## L:913  |      4 | store(dirXYZ1, addr, 12);
  LABEL_T3DCmd_LightSet_000D:
  j RSPQ_Loop                                        ## L:917  |      5 | }
  sw $a1, 4($a0)                                     ## L:916  |     *7 | store(rgba8, addr, 4);
mulMat4Mat4:
  ## hot-path cycles: 50
  ldv $v01, 8, 0, $s3                                ## L:950  |      ^ | vec32 matL0 = load(addrMatL, 0x00).xyzwxyzw;
  ldv $v10, 0, 8, $s4                                ## L:957  |      2 | matR01.xyzw = load(addrMatR, 0x00).xyzw;
  ldv $v10, 8, 24, $s4                               ## L:958  |      3 | matR01.XYZW = load(addrMatR, 0x10).xyzw;
  ldv $v01, 0, 0, $s3                                ## L:950  |      4 | vec32 matL0 = load(addrMatL, 0x00).xyzwxyzw;
  ldv $v02, 0, 8, $s3                                ## L:950  |      5 | vec32 matL0 = load(addrMatL, 0x00).xyzwxyzw;
  ldv $v02, 8, 8, $s3                                ## L:950  |      6 | vec32 matL0 = load(addrMatL, 0x00).xyzwxyzw;
  ldv $v09, 0, 0, $s4                                ## L:957  |      7 | matR01.xyzw = load(addrMatR, 0x00).xyzw;
  ldv $v09, 8, 16, $s4                               ## L:958  |      8 | matR01.XYZW = load(addrMatR, 0x10).xyzw;
  ldv $v04, 0, 24, $s3                               ## L:951  |      9 | vec32 matL1 = load(addrMatL, 0x10).xyzwxyzw;
  ldv $v03, 8, 16, $s3                               ## L:951  |     10 | vec32 matL1 = load(addrMatL, 0x10).xyzwxyzw;
  vmudl $v13, $v02, $v10.h0                          ## L:963  |      ^ | tmp    = matL0  * matR01.xxxxXXXX;
  ldv $v04, 8, 24, $s3                               ## L:951  |     11 | vec32 matL1 = load(addrMatL, 0x10).xyzwxyzw;
  vmadm $v13, $v01, $v10.h0                          ## L:963  |      ^ | tmp    = matL0  * matR01.xxxxXXXX;
  ldv $v03, 0, 16, $s3                               ## L:951  |     12 | vec32 matL1 = load(addrMatL, 0x10).xyzwxyzw;
  vmadn $v14, $v02, $v09.h0                          ## L:963  |      ^ | tmp    = matL0  * matR01.xxxxXXXX;
  ldv $v06, 0, 40, $s3                               ## L:952  |     13 | vec32 matL2 = load(addrMatL, 0x20).xyzwxyzw;
  vmadh $v13, $v01, $v09.h0                          ## L:963  |      ^ | tmp    = matL0  * matR01.xxxxXXXX;
  ldv $v06, 8, 40, $s3                               ## L:952  |     14 | vec32 matL2 = load(addrMatL, 0x20).xyzwxyzw;
  ldv $v05, 0, 32, $s3                               ## L:952  |     15 | vec32 matL2 = load(addrMatL, 0x20).xyzwxyzw;
  vmadl $v13, $v04, $v10.h1                          ## L:964  |      ^ | tmp    = matL1 +* matR01.yyyyYYYY;
  vmadm $v13, $v03, $v10.h1                          ## L:964  |     16 | tmp    = matL1 +* matR01.yyyyYYYY;
  ldv $v05, 8, 32, $s3                               ## L:952  |      ^ | vec32 matL2 = load(addrMatL, 0x20).xyzwxyzw;
  vmadn $v14, $v04, $v09.h1                          ## L:964  |     17 | tmp    = matL1 +* matR01.yyyyYYYY;
  ldv $v08, 0, 56, $s3                               ## L:953  |      ^ | vec32 matL3 = load(addrMatL, 0x30).xyzwxyzw;
  vmadh $v13, $v03, $v09.h1                          ## L:964  |     18 | tmp    = matL1 +* matR01.yyyyYYYY;
  ldv $v07, 8, 48, $s3                               ## L:953  |      ^ | vec32 matL3 = load(addrMatL, 0x30).xyzwxyzw;
  ldv $v08, 8, 56, $s3                               ## L:953  |     19 | vec32 matL3 = load(addrMatL, 0x30).xyzwxyzw;
  vmadl $v13, $v06, $v10.h2                          ## L:965  |      ^ | tmp    = matL2 +* matR01.zzzzZZZZ;
  vmadm $v13, $v05, $v10.h2                          ## L:965  |     20 | tmp    = matL2 +* matR01.zzzzZZZZ;
  ldv $v07, 0, 48, $s3                               ## L:953  |      ^ | vec32 matL3 = load(addrMatL, 0x30).xyzwxyzw;
  vmadn $v14, $v06, $v09.h2                          ## L:965  |     21 | tmp    = matL2 +* matR01.zzzzZZZZ;
  vmadh $v13, $v05, $v09.h2                          ## L:965  |     22 | tmp    = matL2 +* matR01.zzzzZZZZ;
  ldv $v12, 8, 56, $s4                               ## L:960  |      ^ | matR23.XYZW = load(addrMatR, 0x30).xyzw;
  vmadl $v29, $v08, $v10.h3                          ## L:966  |     23 | matR01 = matL3 +* matR01.wwwwWWWW;
  ldv $v12, 0, 40, $s4                               ## L:959  |      ^ | matR23.xyzw = load(addrMatR, 0x20).xyzw;
  ldv $v11, 0, 32, $s4                               ## L:959  |     24 | matR23.xyzw = load(addrMatR, 0x20).xyzw;
  vmadm $v29, $v07, $v10.h3                          ## L:966  |      ^ | matR01 = matL3 +* matR01.wwwwWWWW;
  ldv $v11, 8, 48, $s4                               ## L:960  |     25 | matR23.XYZW = load(addrMatR, 0x30).xyzw;
  vmadn $v10, $v08, $v09.h3                          ## L:966  |      ^ | matR01 = matL3 +* matR01.wwwwWWWW;
  vmadh $v09, $v07, $v09.h3                          ## L:966  |     26 | matR01 = matL3 +* matR01.wwwwWWWW;
  vmudl $v13, $v02, $v12.h0                          ## L:968  |     27 | tmp    = matL0  * matR23.xxxxXXXX;
  vmadm $v13, $v01, $v12.h0                          ## L:968  |     28 | tmp    = matL0  * matR23.xxxxXXXX;
  vmadn $v14, $v02, $v11.h0                          ## L:968  |     29 | tmp    = matL0  * matR23.xxxxXXXX;
  vmadh $v13, $v01, $v11.h0                          ## L:968  |     30 | tmp    = matL0  * matR23.xxxxXXXX;
  vmadl $v13, $v04, $v12.h1                          ## L:969  |     31 | tmp    = matL1 +* matR23.yyyyYYYY;
  vmadm $v13, $v03, $v12.h1                          ## L:969  |     32 | tmp    = matL1 +* matR23.yyyyYYYY;
  vmadn $v14, $v04, $v11.h1                          ## L:969  |     33 | tmp    = matL1 +* matR23.yyyyYYYY;
  vmadh $v13, $v03, $v11.h1                          ## L:969  |     34 | tmp    = matL1 +* matR23.yyyyYYYY;
  vmadl $v13, $v06, $v12.h2                          ## L:970  |     35 | tmp    = matL2 +* matR23.zzzzZZZZ;
  vmadm $v13, $v05, $v12.h2                          ## L:970  |     36 | tmp    = matL2 +* matR23.zzzzZZZZ;
  sdv $v09, 8, 16, $s2                               ## L:974  |      ^ | store(matR01.XYZW, addrOut, 0x10);
  vmadn $v14, $v06, $v11.h2                          ## L:970  |     37 | tmp    = matL2 +* matR23.zzzzZZZZ;
  vmadh $v13, $v05, $v11.h2                          ## L:970  |     38 | tmp    = matL2 +* matR23.zzzzZZZZ;
  vmadl $v29, $v08, $v12.h3                          ## L:971  |     39 | matR23 = matL3 +* matR23.wwwwWWWW;
  vmadm $v29, $v07, $v12.h3                          ## L:971  |     40 | matR23 = matL3 +* matR23.wwwwWWWW;
  sdv $v09, 0, 0, $s2                                ## L:973  |      ^ | store(matR01.xyzw, addrOut, 0x00);
  sdv $v10, 8, 24, $s2                               ## L:974  |     41 | store(matR01.XYZW, addrOut, 0x10);
  vmadn $v12, $v08, $v11.h3                          ## L:971  |      ^ | matR23 = matL3 +* matR23.wwwwWWWW;
  vmadh $v11, $v07, $v11.h3                          ## L:971  |     42 | matR23 = matL3 +* matR23.wwwwWWWW;
  sdv $v10, 0, 8, $s2                                ## L:973  |      ^ | store(matR01.xyzw, addrOut, 0x00);
  sdv $v12, 8, 56, $s2                               ## L:976  |   **45 | store(matR23.XYZW, addrOut, 0x30);
  sdv $v11, 0, 32, $s2                               ## L:975  |     46 | store(matR23.xyzw, addrOut, 0x20);
  sdv $v11, 8, 48, $s2                               ## L:976  |     47 | store(matR23.XYZW, addrOut, 0x30);
  jr $ra                                             ## L:977  |     48 | }
  sdv $v12, 0, 40, $s2                               ## L:975  |    *50 | store(matR23.xyzw, addrOut, 0x20);
normalizeMatrixVector:
  ## hot-path cycles: 44
  ldv $v02, 0, 8, $s4                                ## L:989  |      ^ | vec32 v = load(addrIn, 0x00).xyzw;
  ldv $v01, 0, 0, $s4                                ## L:989  |      2 | vec32 v = load(addrIn, 0x00).xyzw;
  addiu $s4, $s4, 16                                 ## L:1005 |    **5 | addrIn += 0x10;
  vmudl $v03, $v02, $v02.v                           ## L:992  |      ^ | vec32 vLenInv = v * v;
  vmadm $v03, $v01, $v02.v                           ## L:992  |      6 | vec32 vLenInv = v * v;
  vmadn $v04, $v02, $v01.v                           ## L:992  |      7 | vec32 vLenInv = v * v;
  vmadh $v03, $v01, $v01.v                           ## L:992  |      8 | vec32 vLenInv = v * v;
  vaddc $v06, $v04, $v04.h1                          ## L:993  |   **11 | vec32 tmp = vLenInv + vLenInv.yyyyYYYY;
  vadd $v05, $v03, $v03.h1                           ## L:993  |     12 | vec32 tmp = vLenInv + vLenInv.yyyyYYYY;
  vaddc $v04, $v04, $v06.h2                          ## L:994  |   **15 | vLenInv   = vLenInv + tmp.zzzzZZZZ;
  vadd $v03, $v03, $v05.h2                           ## L:994  |     16 | vLenInv   = vLenInv + tmp.zzzzZZZZ;
  vrsqh $v03.e3, $v03.e0                             ## L:997  |  ***20 | vLenInv.w = invert_half_sqrt(vLenInv).x;
  vrsql $v04.e3, $v04.e0                             ## L:997  |     21 | vLenInv.w = invert_half_sqrt(vLenInv).x;
  vrsqh $v03.e3, $v00.e0                             ## L:997  |     22 | vLenInv.w = invert_half_sqrt(vLenInv).x;
  vmudl $v04, $v04, $v30.e0                          ## L:998  |   **25 | vLenInv >>= 9;
  vmadm $v03, $v03, $v30.e0                          ## L:998  |     26 | vLenInv >>= 9;
  vmadn $v04, $v00, $v00                             ## L:998  |     27 | vLenInv >>= 9;
  vmudl $v29, $v02, $v04.h3                          ## L:1000 |  ***31 | v *= vLenInv.wwwwWWWW;
  vmadm $v29, $v01, $v04.h3                          ## L:1000 |     32 | v *= vLenInv.wwwwWWWW;
  vmadn $v02, $v02, $v03.h3                          ## L:1000 |     33 | v *= vLenInv.wwwwWWWW;
  vmadh $v01, $v01, $v03.h3                          ## L:1000 |     34 | v *= vLenInv.wwwwWWWW;
  vadd $v02, $v02, $v02.v                            ## L:1001 |   **37 | v:sfract += v:sfract;
  sdv $v02, 0, 0, $t1                                ## L:1003 |  ***41 | store(v:sfract.xyzw, addrOut, 0x00);
  jr $ra                                             ## L:1007 |     42 | }
  addiu $t1, $t1, 8                                  ## L:1006 |    *44 | addrOut += 0x8;
T3DCmd_MatrixStack:
  ## hot-path cycles: 47
  andi $s7, $a0, 1                                   ## L:1023 |      ^ | u16 doMultiply = stackAdvance & 0b01;
  andi $s6, $a0, 2                                   ## L:1024 |      2 | u16 onlyStackMove = stackAdvance & 0b10;
  lh $a0, %lo(RSPQ_DMEM_BUFFER  -7)($gp)             ## L:1026 |      3 | stackAdvance:s16 = load_arg(1);
  lw $s5, %lo(MATRIX_STACK_PTR + 0)                  ## L:1028 |      4 | s32 stackPtr = load(MATRIX_STACK_PTR);
  addu $s5, $s5, $a0                                 ## L:1029 |    **7 | stackPtr += stackAdvance;
  bne $s6, $zero, RSPQ_Loop                          ## L:1033 |      8 | if(onlyStackMove)exit;
  sw $s5, %lo(MATRIX_STACK_PTR)($zero)               ## L:1030 |      9 | store(stackPtr, MATRIX_STACK_PTR);
  srl $s3, $a1, 24                                   ## L:377  |     10 | u32 segment = addrIn >> 24;
  lw $s3, %lo(SEGMENT_TABLE)($s3)                    ## L:378  |     11 | segment = load(segment, SEGMENT_TABLE);
  ori $s4, $zero, %lo(MATRIX_MV)                     ## L:1034 |     12 | dmaDest = MATRIX_MV;
  bgez $a0, LABEL_T3DCmd_MatrixStack_000F            ## L:1038 |     13 | if(stackAdvance < 0)addressMat = stackPtr;
  addu $a1, $a1, $s3                                 ## L:379  |     14 | addrOut = addrIn + segment;
  or $a1, $zero, $s5                                 ## L:1038 |     15 | if(stackAdvance < 0)addressMat = stackPtr;
  LABEL_T3DCmd_MatrixStack_000F:
  lui $at, 0xFF                                      ## L:1039 |     16 | u32<$s0> addrRDRAM = addressMat & 0xFFFFFF;
  ori $at, $at, 0xFFFF                               ## L:1039 |     17 | u32<$s0> addrRDRAM = addressMat & 0xFFFFFF;
  ori $t0, $zero, 63                                 ## L:1041 |     18 | dma_in(dmaDest, addrRDRAM, 0x40);
  addiu $t2, $zero, 12                               ## L:1041 |     19 | dma_in(dmaDest, addrRDRAM, 0x40);
  jal DMAExec                                        ## L:1041 |     20 | dma_in(dmaDest, addrRDRAM, 0x40); ## Args: $t0, $t1, $s0, $s4, $t2
  and $s0, $a1, $at                                  ## L:1039 |     21 | u32<$s0> addrRDRAM = addressMat & 0xFFFFFF;
  beq $s7, $zero, LABEL_T3DCmd_MatrixStack_0010      ## L:1048 |     22 | if(doMultiply) {
  ori $t1, $zero, %lo(MATRIX_NORMAL)                 ## L:1044 |     23 | u32<$t1> normOut = MATRIX_NORMAL;
  ori $s4, $zero, %lo(CLIP_BUFFER_RESULT)            ## L:1050 |     24 | dmaDest = CLIP_BUFFER_RESULT;
  addiu $s0, $s5, 65472                              ## L:1051 |     25 | addrRDRAM = stackPtr -  0x40;
  addiu $t2, $zero, 12                               ## L:1052 |     26 | dma_in(dmaDest, addrRDRAM, 0x40);
  jal DMAExec                                        ## L:1052 |     27 | dma_in(dmaDest, addrRDRAM, 0x40); ## Args: $t0, $t1, $s0, $s4, $t2
  ori $t0, $zero, 63                                 ## L:1052 |     28 | dma_in(dmaDest, addrRDRAM, 0x40);
  ori $s3, $zero, %lo(CLIP_BUFFER_RESULT)            ## L:1056 |     29 | u32<$s3> mulLeft = CLIP_BUFFER_RESULT;
  ori $s2, $zero, %lo(MATRIX_MV)                     ## L:1055 |     30 | u32<$s2> mulDest = MATRIX_MV;
  jal mulMat4Mat4                                    ## L:1058 |     31 | mulMat4Mat4(mulDest, mulLeft, dmaDest); ## Args: $s2, $s3, $s4
  ori $s4, $zero, %lo(MATRIX_MV)                     ## L:1057 |     32 | dmaDest = MATRIX_MV;
  LABEL_T3DCmd_MatrixStack_0010:
  ori $t0, $zero, 63                                 ## L:1063 |     33 | dma_out(dmaDest, addrRDRAM, 0x40);
  addiu $t2, $zero, -32756                           ## L:1063 |     34 | dma_out(dmaDest, addrRDRAM, 0x40);
  jal DMAExec                                        ## L:1063 |     35 | dma_out(dmaDest, addrRDRAM, 0x40); ## Args: $t0, $t1, $s0, $s4, $t2
  or $s0, $zero, $s5                                 ## L:1062 |     36 | addrRDRAM = stackPtr;
  jal normalizeMatrixVector                          ## L:1069 |     37 | normalizeMatrixVector(dmaDest, normOut); ## Args: $s4, $t1
  ori $s2, $zero, %lo(MATRIX_MVP)                    ## L:1067 |     38 | u32<$s2> mulDest = MATRIX_MVP;
  jal normalizeMatrixVector                          ## L:1073 |     39 | normalizeMatrixVector(dmaDest, normOut); ## Args: $s4, $t1
  ori $s3, $zero, %lo(MATRIX_PROJ)                   ## L:1071 |     40 | u32<$s3> mulLeft = MATRIX_PROJ;
  jal normalizeMatrixVector                          ## L:1074 |     41 | normalizeMatrixVector(dmaDest, normOut); ## Args: $s4, $t1
  nop                                                ## L:1074 |     42 | normalizeMatrixVector(dmaDest, normOut);
  jal mulMat4Mat4                                    ## L:1081 |     43 | mulMat4Mat4(mulDest, mulLeft, mulRight); ## Args: $s2, $s3, $s4
  ori $s4, $zero, %lo(MATRIX_MV)                     ## L:1080 |     44 | u32<$s4> mulRight = MATRIX_MV;
  j RSPQ_Loop                                        ## L:1082 |     45 | }
  nop                                                ## L:1082 |    *47 | }
T3DCmd_MatProjectionSet:
  ## hot-path cycles: 6
  addiu $t2, $zero, 12                               ## L:1091 |      ^ | dma_in(MATRIX_PROJ, addrRDRAM, 0x40);
  or $s0, $zero, $a0                                 ## L:1090 |      2 | u32<$s0> addrRDRAM = addressMat;
  ori $s4, $zero, %lo(MATRIX_PROJ)                   ## L:1091 |      3 | dma_in(MATRIX_PROJ, addrRDRAM, 0x40);
  j DMAExec                                          ## L:1091 |      4 | dma_in(MATRIX_PROJ, addrRDRAM, 0x40); ## Args: $t0, $t1, $s0, $s4, $t2
  ori $t0, $zero, 63                                 ## L:1091 |     *6 | dma_in(MATRIX_PROJ, addrRDRAM, 0x40);
T3DCmd_SetWord:
  ## hot-path cycles: 6
  andi $s7, $a0, 32768                               ## L:1101 |      ^ | u32 is16bit = addrDMEM & 0x8000;
  bne $s7, $zero, RSPQ_Loop                          ## L:1104 |      2 | if(is16bit)goto RSPQ_Loop;
  sh $a1, ($a0)                                      ## L:1102 |      3 | store(value:u16, addrDMEM);
  j RSPQ_Loop                                        ## L:1107 |      4 | }
  sw $a1, ($a0)                                      ## L:1106 |     *6 | store(value:u32, addrDMEM);
T3D_WindowRestore:
  ## hot-path cycles: 13
  or $t3, $zero, $ra                                 ## L:1137 |      ^ | u32<$t3> savedRA = RA;
  lw $s0, %lo(UCODE_BUF_ADDR + 0)                    ## L:1138 |      2 | u32<$s0> rdram = load(UCODE_BUF_ADDR);
  ori $s4, $zero, %lo(CLIPPING_CODE_TARGET)          ## L:1139 |      3 | s16<$s4> dmem = CLIPPING_CODE_TARGET;
  addiu $t0, $zero, 1311                             ## L:1140 |      4 | u16<$t0> size = 0x0520 - 1;
  addiu $s0, $s0, %lo(CLIPPING_CODE_TARGET - 0x1000 + 0x0000) # inline-ASM## L:1143 |      0 | asm("addiu $s0, $s0, %lo(CLIPPING_CODE_TARGET - 0x1000 + 0x0000)");
  jal DMAInAsync                                     ## L:1144 |      5 | DMAInAsync(size, rdram, dmem); ## Args: $t0, $s0, $s4
  nop                                                ## L:1144 |      6 | DMAInAsync(size, rdram, dmem);
  lw $s0, %lo(UCODE_BUF_ADDR + 0)                    ## L:1146 |      7 | rdram = load(UCODE_BUF_ADDR);
  addiu $s4, $zero, 544                              ## L:1148 |      8 | dmem = 0x220;
  addiu $t0, $zero, 39                               ## L:1149 |      9 | size = 40 - 1;
  or $ra, $zero, $t3                                 ## L:1150 |     10 | RA = savedRA;
  j DMAIn                                            ## L:1151 |     11 | goto DMAIn;
  addiu $s0, $s0, 8192                               ## L:1147 |    *13 | rdram += 0x2000;
T3DCmd_VertLoad:
  ## hot-path cycles: 11
  lbu $s7, %lo(PAGE_STATE + 0)                       ## L:1162 |      ^ | u8 pageState = load(PAGE_STATE);
  beq $s7, $zero, T3DCmd_VertLoad_Impl               ## L:1164 |    **4 | if(pageState) {
  sb $zero, %lo(PAGE_STATE)($zero)                   ## L:1163 |      5 | store(ZERO:u8, PAGE_STATE);
  jal T3D_WindowRestore                              ## L:1165 |      6 | T3D_WindowRestore();
  nop                                                ## L:1165 |      7 | T3D_WindowRestore();
  ori $ra, $zero, %lo(RSPQ_Loop)                     ## L:1166 |      8 | RA = RSPQ_Loop;
  LABEL_T3DCmd_VertLoad_0012:
  j T3DCmd_VertLoad_Impl                             ## L:1168 |      9 | goto T3DCmd_VertLoad_Impl;
  nop                                                ## L:1168 |    *11 | goto T3DCmd_VertLoad_Impl;
T3D_PageLoad:
  ## hot-path cycles: 15
  lw $s0, %lo(UCODE_BUF_ADDR + 0)                    ## L:1180 |      ^ | u32<$s0> rdram = load(UCODE_BUF_ADDR);
  ori $s4, $zero, %lo(CLIPPING_CODE_TARGET)          ## L:1181 |      2 | s16<$s4> dmem = CLIPPING_CODE_TARGET;
  addiu $t0, $zero, 1311                             ## L:1182 |      3 | u16<$t0> size = 0x0520 - 1;
  jal DMAInAsync                                     ## L:1184 |      4 | DMAInAsync(size, rdram, dmem); ## Args: $t0, $s0, $s4
  addiu $s0, $s0, 6144                               ## L:1183 |      5 | rdram += 0x1800;
  addiu $t0, $zero, 39                               ## L:1189 |      6 | size = 40 - 1;
  addiu $s0, $s0, 2112                               ## L:1187 |      7 | rdram += 0x2040 - 0x1800;
  jal DMAInAsync                                     ## L:1190 |      8 | DMAInAsync(size, rdram, dmem); ## Args: $t0, $s0, $s4
  addiu $s4, $zero, 544                              ## L:1188 |      9 | dmem = 0x220;
  addiu $s0, $s0, 64                                 ## L:1192 |     10 | rdram += 0x2080 - 0x2040;
  addiu $t0, $zero, 95                               ## L:1194 |     11 | size = 96 - 1;
  jal DMAIn                                          ## L:1195 |     12 | DMAIn(size, rdram, dmem); ## Args: $t0, $s0, $s4
  ori $s4, $zero, %lo(CLIP_BUFFER_TMP)               ## L:1193 |     13 | dmem = CLIP_BUFFER_TMP;
  addiu $t1, $zero, 2                                ## L:1197 |     14 | u8 pageState = 2;
  sb $t1, %lo(PAGE_STATE)($zero)                     ## L:1198 |     15 | store(pageState, PAGE_STATE);
  j RSPQ_Loop # inline-ASM                           ## L:1201 |      0 | asm("j RSPQ_Loop");
  subu $gp, $gp, $t7 # inline-ASM                    ## L:1202 |      0 | asm("subu $gp, $gp, $t7");
RDPQ_Triangle_Clip:
  ## hot-path cycles: 6
  sh $ra, %lo(CLIP_RA)($zero)                        ## L:1231 |      ^ | store(RA:u16, CLIP_RA);
  jal RDPQ_Triangle_Send_End                         ## L:1232 |      2 | RDPQ_Triangle_Send_End();
  sh $s4, %lo(18 + RSPQ_SCRATCH_MEM)($zero)          ## L:1230 |      3 | store(targetImem:u16, RSPQ_SCRATCH_MEM, 18);
  j CLIPPING_CODE_TARGET                             ## L:1237 |      4 | goto CLIPPING_CODE_TARGET;
  ori $s4, $zero, %lo(CLIPPING_CODE_TARGET)          ## L:1236 |     *6 | targetImem = CLIPPING_CODE_TARGET;
T3DCmd_TriDraw_Strip:
  ## hot-path cycles: 29
  LABEL_T3DCmd_TriDraw_Strip_0013:
  mfc0 $ra, COP0_DMA_BUSY                            ## L:1252 |      1 | RA = get_dma_busy();
  andi $t0, $a1, 65535                               ## L:1253 |      2 | copySize = countDmem & 0xFFFF;
  sra $s4, $a1, 16                                   ## L:1254 |      3 | prtDmem = countDmem >> 16;
  bne $ra, $zero, LABEL_T3DCmd_TriDraw_Strip_0013    ## L:1255 |      4 | prtDmemEnd = prtDmem + copySize;
  addu $s2, $s4, $t0                                 ## L:1255 |      5 | prtDmemEnd = prtDmem + copySize;
  LABEL_T3DCmd_TriDraw_Strip_0014:
  mtc0 $s4, COP0_DMA_SPADDR                          ## L:332  |      6 | @Barrier("DMA") set_dma_addr_rsp(addrDMEM); ## Barrier: 0x4
  mtc0 $a0, COP0_DMA_RAMADDR                         ## L:333  |      7 | @Barrier("DMA") set_dma_addr_rdram(addrRDRAM); ## Barrier: 0x4
  mtc0 $t0, COP0_DMA_READ                            ## L:334  |   **10 | @Barrier("DMA") set_dma_read(size); ## Barrier: 0x4
  T3DCmd_TriDraw_Strip_PostDMA:
  addiu $s2, $s2, 65533                              ## L:1270 |     11 | prtDmemEnd -= 3;
  addiu $s4, $s4, 65534                              ## L:1276 |     12 | prtDmem -= 2;
  LABEL_T3DCmd_TriDraw_Strip_0015:
  mfc0 $v1, COP0_DMA_BUSY                            ## L:1279 |     13 | vertAddr = get_dma_busy();
  bne $v1, $zero, LABEL_T3DCmd_TriDraw_Strip_0015    ## L:1279 |   **16 | vertAddr = get_dma_busy();
  nop                                                ## L:1279 |     17 | vertAddr = get_dma_busy();
  STRIP_LOOP_NEW:
  lbu $v0, %lo(FACE_CULLING + 0)                     ## L:1283 |     18 | faceCull = load(FACE_CULLING);
  addiu $s4, $s4, 2                                  ## L:1284 |     19 | prtDmem += 2;
  STRIP_LOOP_NEXT:
  beq $s4, $s2, STRIP_LOOP_END                       ## L:1287 |     20 | if(prtDmem == prtDmemEnd)goto STRIP_LOOP_END;
  xori $v0, $v0, 1                                   ## L:1286 |     21 | faceCull ^= 1;
  lh $a1, 4($s4)                                     ## L:1290 |     22 | idx1:s16 = load(prtDmem, 4);
  lhu $a2, 0($s4)                                    ## L:1291 |     23 | idx2     = load(prtDmem, 0);
  lhu $a0, 2($s4)                                    ## L:1289 |     24 | idx0     = load(prtDmem, 2);
  bltz $a1, STRIP_LOOP_NEW                           ## L:1294 |     25 | if(idx1:s16 < 0)goto STRIP_LOOP_NEW;
  addiu $s4, $s4, 2                                  ## L:1293 |     26 | prtDmem += 2;
  j RDPQ_Triangle_Send_Async                         ## L:1298 |     27 | goto RDPQ_Triangle_Send_Async;
  ori $ra, $zero, %lo(STRIP_LOOP_NEXT)               ## L:1297 |    *29 | RA = STRIP_LOOP_NEXT;
  STRIP_LOOP_END:
  bgez $s2, RSPQ_Loop                                ## L:1306 |      1 | if(prtDmemEnd >= 0)goto RSPQ_Loop;
  ori $ra, $zero, %lo(RSPQ_Loop)                     ## L:1303 |     *3 | RA = RSPQ_Loop;
T3DCmd_TriSync:
  ## hot-path cycles: 10
  lbu $s7, %lo(PAGE_STATE + 0)                       ## L:1317 |      ^ | u8 pageState = load(PAGE_STATE);
  beq $s7, $zero, RDPQ_Triangle_Send_End             ## L:1321 |    **4 | if(!pageState)goto RDPQ_Triangle_Send_End;
  sb $zero, %lo(PAGE_STATE)($zero)                   ## L:1318 |      5 | store(ZERO:u8, PAGE_STATE);
  jal T3D_WindowRestore                              ## L:1324 |      6 | T3D_WindowRestore();
  nop                                                ## L:1324 |      7 | T3D_WindowRestore();
  j RDPQ_Triangle_Send_End                           ## L:1326 |      8 | goto RDPQ_Triangle_Send_End;
  ori $ra, $zero, %lo(RSPQ_Loop)                     ## L:1325 |    *10 | RA = RSPQ_Loop;
T3DCmd_TriDraw_Seq:
  ## hot-path cycles: 13
  andi $s4, $a1, 65535                               ## L:1334 |      ^ | u8<$s4> baseVtxEnd = endIndex & 0xFFFF;
  andi $s2, $a0, 65535                               ## L:1335 |      2 | u16<$s2> baseVtx = sizeAndIndex & 0xFFFF;
  srl $s1, $a1, 16                                   ## L:1338 |      3 | u16<$s1> isQuad = endIndex >> 16;
  lbu $v0, %lo(FACE_CULLING + 0)                     ## L:1337 |      4 | u8<$v0> faceCull = load(FACE_CULLING);
  addiu $v1, $s1, 108                                ## L:1339 |      5 | u16<$v1> vtxIncr = isQuad + (36 * 3);
  SEQ_LOOP_NEXT:
  beq $s2, $s4, SEQ_LOOP_END                         ## L:1347 |      6 | if(baseVtx == baseVtxEnd)goto SEQ_LOOP_END;
  addiu $a0, $s2, 72                                 ## L:1346 |      7 | idx0 = baseVtx + (36 * 2);
  addiu $a1, $s2, 36                                 ## L:1348 |      8 | idx1 = baseVtx + (36 * 1);
  or $a2, $zero, $s2                                 ## L:1349 |      9 | idx2 = baseVtx;
  ori $ra, $zero, %lo(SEQ_LOOP_NEXT)                 ## L:1352 |     10 | RA = SEQ_LOOP_NEXT;
  j RDPQ_Triangle_Send_Async                         ## L:1353 |     11 | goto RDPQ_Triangle_Send_Async;
  addu $s2, $s2, $v1                                 ## L:1350 |    *13 | baseVtx += vtxIncr;
  SEQ_LOOP_END:
  beq $s1, $zero, T3DCmd_TriSync                     ## L:1358 |      1 | if(isQuad) {
  ori $ra, $zero, %lo(RSPQ_Loop)                     ## L:1357 |     *3 | RA = RSPQ_Loop;
  lhu $s2, %lo(RSPQ_DMEM_BUFFER  -6)($gp)            ## L:1361 |      4 | baseVtx:u16 = load_arg(2);
  addiu $s4, $s4, 36                                 ## L:1363 |      5 | baseVtxEnd += 36;
  or $s1, $zero, $zero                               ## L:1359 |      6 | isQuad = 0;
  xori $v0, $v0, 1                                   ## L:1360 |      7 | faceCull ^= 1;
  j SEQ_LOOP_NEXT                                    ## L:1364 |      8 | goto SEQ_LOOP_NEXT;
  addiu $s2, $s2, 36                                 ## L:1362 |    *10 | baseVtx += 36;

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