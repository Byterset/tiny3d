##########################################################################
## tiny3d material page
##
## Not a rspq overlay: code and data that the main overlay (rsp_tiny3d.S)
## pages into its IMEM window (see t3d_page.h) when a paged command runs:
## the rdpq fixups tiny3d executes in place (T3D_CMD_RDPQ_*, handlers from
## rsp_rdpq.inc) and the t3d commands that do not fit in the resident code
## (screen size, patch, render mode).
##
## While the page is loaded, the command table entries of the paged commands
## point straight into this code; otherwise they point to T3D_PageLoad, which
## loads the page and re-runs the command. t3d_init builds that table from
## the handler addresses in rsp_t3d_material.h.
##
## This file only places the generated code (rsp_t3d_material_rspl.inc) at
## the window address and the data at the temporary DMEM area of the main
## overlay, both taken from rsp_tiny3d.h.
##########################################################################

#include <rsp_queue.inc>
#include "rsp_tiny3d.h"
#include "t3d_page.h"

#define RDPQ_INC_COMMANDS 1
#define RDPQ_INC_COMMANDS_GC 1

## DMEM state and code addresses of the main overlay
.set UCODE_BUF_ADDR,         RSP_T3D_UCODE_BUF_ADDR & 0xFFF
.set PAGE_STATE,             RSP_T3D_PAGE_STATE & 0xFFF
.set SCREEN_SCALE,           RSP_T3D_SCREEN_SCALE & 0xFFF
.set SCREEN_OFFSET,          RSP_T3D_SCREEN_OFFSET & 0xFFF
.set NORM_SCALE_W,           RSP_T3D_NORM_SCALE_W & 0xFFF
.set SCREEN_UVGEN_SCALE,     RSP_T3D_SCREEN_UVGEN_SCALE & 0xFFF
.set MATRIX_PROJ,            RSP_T3D_MATRIX_PROJ & 0xFFF
.set FACE_CULLING,           RSP_T3D_FACE_CULLING & 0xFFF
.set TRI_COMMAND,            RSP_T3D_TRI_COMMAND & 0xFFF
.set CLIPPING_CODE_TARGET,   (RSP_T3D_CODE_CLIPPING_CODE_TARGET & 0xFFF) | 0x1000
.set CLIP_BUFFER_TMP,        RSP_T3D_BSS_CLIP_BUFFER_TMP & 0xFFF

.set T3D_PAGE_IMEM,          RSP_T3D_CODE_CLIPPING_CODE_TARGET & 0xFFF
.set T3D_PAGE_DMEM,          RSP_T3D_BSS_CLIP_BUFFER_TMP & 0xFFF

##########################################################################
## Page data
##########################################################################
    .data

## References to the handlers, so that --gc-sections keeps them (never loaded in DMEM)
T3D_PAGE_KEEP:
    .word T3DCmd_SetScreenSize, T3DCmd_RenderMode, T3DCmd_Patch
    .word RDPQCmd_SetScissorEx, RDPQCmd_SetPrimColorComponent, RDPQCmd_ModifyOtherModes
    .word RDPQ_SetCombineMode_2Pass, RDPQ_SetBlendingMode, RDPQ_SetFogMode, RDPQ_SetCombineMode_1Pass

## The page data (constants of rsp_rdpq.inc) lands in the temporary DMEM area of
## the main overlay: t3d_init copies [T3D_PAGE_DMEM, _data_end) to the ucode buffer.
    .org T3D_PAGE_DMEM

##########################################################################
## Page code (loaded at the IMEM window of the main overlay)
##########################################################################

    .text
    .org T3D_PAGE_IMEM
## Page code generated from rsp_t3d_material.rspl
#include "rsp_t3d_material_rspl.inc"

## rdpq command handlers and render mode code
#include <rsp_rdpq.inc>
