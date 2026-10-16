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
.set noat

T3D_PAGE_CODE_START:
  lw $s0, %lo(UCODE_BUF_ADDR + 0)                    ## L:114  |      ^ | u32<$s0> rdram = load(UCODE_BUF_ADDR);
  addiu $t0, $zero, 39                               ## L:116  |      2 | u16<$t0> size = 40 - 1;
  addiu $s0, $s0, 8192                               ## L:117  |     *4 | rdram += 0x2000;
  jal DMAInAsync                                     ## L:118  |      5 | DMAInAsync(size, rdram, dmem); ## Args: $t0, $s0, $s4
  addiu $s4, $zero, 544                              ## L:115  |     *7 | s16<$s4> dmem = 0x220;
  lw $s0, %lo(UCODE_BUF_ADDR + 0)                    ## L:120  |      8 | rdram = load(UCODE_BUF_ADDR);
  ori $s4, $zero, %lo(CLIPPING_CODE_TARGET)          ## L:122  |      9 | dmem = CLIPPING_CODE_TARGET;
  addiu $t0, $zero, 1311                             ## L:123  |     10 | size = 0x0520 - 1;
  addiu $t1, $zero, 1                                ## L:125  |     11 | u8 pageState = 1;
  sb $t1, %lo(PAGE_STATE)($zero)                     ## L:126  |     12 | store(pageState, PAGE_STATE);
  ori $ra, $zero, %lo(CLIPPING_CODE_TARGET)          ## L:128  |     13 | RA = CLIPPING_CODE_TARGET;
  j DMAIn                                            ## L:129  |     14 | goto DMAIn;
  addiu $s0, $s0, 4096                               ## L:121  |    *16 | rdram += 0x1000;
T3DCmd_SetScreenSize:
  lw $t4, %lo(RSPQ_DMEM_BUFFER  -8)($gp)             
  lw $t5, %lo(RSPQ_DMEM_BUFFER  -4)($gp)             
  srl $s7, $a3, 16                                   ## L:146  |      3 | u32 zScaleInt = depthAndWScale >> 16;
  sw $a2, %lo(0 + SCREEN_SCALE)($zero)               ## L:148  |     *5 | store(screenScaleXY, SCREEN_SCALE, 0x00);
  sw $a1, %lo(0 + SCREEN_OFFSET)($zero)              ## L:149  |      6 | store(screenOffsetXY, SCREEN_OFFSET, 0x00);
  sw $t4, %lo(8 + SCREEN_SCALE)($zero)               ## L:150  |      7 | store(screenScaleXYFrac, SCREEN_SCALE, 0x08);
  srl $s6, $t5, 16                                   ## L:151  |      8 | u32 zScaleFrac = depthScaleFrac >> 16;
  sh $s6, %lo(12 + SCREEN_SCALE)($zero)              ## L:152  |      9 | store(zScaleFrac:u16, SCREEN_SCALE, 0x0C);
  sh $a3, %lo(6 + NORM_SCALE_W)($zero)               ## L:154  |     10 | store(depthAndWScale:s16, NORM_SCALE_W, 6);
  srl $s5, $a0, 8                                    ## L:156  |     11 | u16 uvgenScaleFactor = guardBandFactor >> 8;
  sh $s5, %lo(SCREEN_UVGEN_SCALE)($zero)             ## L:157  |     12 | store(uvgenScaleFactor, SCREEN_UVGEN_SCALE);
  j RSPQ_Loop                                        ## L:158  |     13 | }
  sh $s7, %lo(4 + SCREEN_SCALE)($zero)               ## L:147  |    *15 | store(zScaleInt:u16, SCREEN_SCALE, 0x04);
T3DCmd_Patch:
  or $s0, $zero, $a0                                 ## L:175  |      ^ | u32<$s0> rdramAddr = rdramAddr_;
  ori $s4, $zero, %lo(RSPQ_SCRATCH_MEM)              ## L:176  |      2 | s16<$s4> dmemAddr = RSPQ_SCRATCH_MEM;
  sw $a1, 0($s4)                                     ## L:178  |      3 | store(opcode0, dmemAddr, 0);
  sw $a2, 4($s4)                                     ## L:179  |      4 | store(opcode1, dmemAddr, 4);
  jal DMAOut                                         ## L:181  |      5 | DMAOut(size, rdramAddr, dmemAddr); ## Args: $t0, $s0, $s4
  addiu $t0, $zero, 7                                ## L:174  |     *7 | u16<$t0> size = 8 - 1;
  ori $s7, $zero, %lo(CLIPPING_CODE_TARGET)          ## L:183  |      8 | u32 windowOffset = CLIPPING_CODE_TARGET;
  subu $s7, $a3, $s7                                 ## L:184  |      9 | windowOffset = imemAddr - windowOffset;
  sltiu $at, $s7, 1312                               ## L:185  |     10 | if(windowOffset < 0x0520)goto RSPQ_Loop;
  bne $at, $zero, RSPQ_Loop                          ## L:185  |     11 | if(windowOffset < 0x0520)goto RSPQ_Loop;
  nop                                                ## L:185  |    *13 | if(windowOffset < 0x0520)goto RSPQ_Loop;
  or $s0, $zero, $a0                                 ## L:188  |     14 | rdramAddr = rdramAddr_;
  or $s4, $zero, $a3                                 ## L:189  |     15 | dmemAddr = imemAddr;
  ori $ra, $zero, %lo(RSPQ_Loop)                     ## L:190  |     16 | RA = RSPQ_Loop;
  j DMAIn                                            ## L:191  |     17 | goto DMAIn;
  addiu $t0, $zero, 7                                ## L:187  |    *19 | size = 8 - 1;
T3DCmd_RenderMode:
  lbu $s7, %lo(RDPQ_OTHER_MODES + 0)                 ## L:203  |      ^ | u8 mipmap = load(RDPQ_OTHER_MODES);
  andi $s7, $s7, 56                                  ## L:204  |    **4 | mipmap &= 0x38;
  or $a1, $a1, $s7                                   ## L:205  |      5 | triCommand |= mipmap;
  sw $a1, %lo(TRI_COMMAND)($zero)                    ## L:207  |      6 | store(triCommand, TRI_COMMAND);
  j RSPQ_Loop                                        ## L:208  |      7 | }
  sb $a0, %lo(FACE_CULLING)($zero)                   ## L:200  |     *9 | store(culling, FACE_CULLING);

.set at
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