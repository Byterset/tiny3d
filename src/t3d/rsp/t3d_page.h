/**
* @copyright 2026 - Max Bebök
* @license MIT
*
* Constants of the paged IMEM window, shared between the ucode and t3d.c.
*
* The window [CLIPPING_CODE_TARGET, T3D_WINDOW_END) normally holds the vertex loading
* code, and can be overwritten by the clipping code or the material page
* (rsp_t3d_material.S). Everything that is paged lives in one RDRAM buffer allocated
* by t3d_init (UCODE_BUF_ADDR in DMEM, MSB used for the alpha-to-tile mask):
*
*   T3D_BUF_TEXT_OFF         overlay text, the overlay is registered with this copy
*   T3D_BUF_CLIP_OFF         clipping code, padded to the window size
*   T3D_BUF_PAGE_OFF         material page code, padded to the window size
*   T3D_BUF_TABLES_OFF       command table with the paged commands pointing to T3D_PageLoad
*   T3D_BUF_TABLES_PAGE_OFF  command table with the paged commands pointing into the page
*   T3D_BUF_CONSTS_OFF       data of the material page, loaded at CLIP_BUFFER_TMP
*/
#ifndef T3D_PAGE_H
#define T3D_PAGE_H

// What is loaded in the IMEM window (PAGE_STATE in DMEM). Only zero / non-zero matters:
// a stale non-zero value (eg: after an overlay reload) only causes one extra restore.
#define T3D_PAGE_ORIGINAL   0
#define T3D_PAGE_CLIP       1
#define T3D_PAGE_MATERIAL   2

// Layout of the RDRAM buffer, all offsets must be multiples of 8
#define T3D_BUF_TEXT_OFF        0x0000
#define T3D_BUF_CLIP_OFF        0x1000
#define T3D_BUF_PAGE_OFF        0x1800
#define T3D_BUF_TABLES_OFF      0x2000
#define T3D_BUF_TABLES_PAGE_OFF 0x2040
#define T3D_BUF_CONSTS_OFF      0x2080
#define T3D_BUF_SIZE            0x2100
// Size of the window in bytes (multiple of 8). RSPL cannot use label differences, so this
// must match the size of the vertex loading code, checked by a static assert in t3d.c.
#define T3D_WINDOW_SIZE         0x0520
// Size of the clip / page slots in the buffer
#define T3D_WINDOW_MAX_SIZE     0x0800

// DMEM range of the command table entries swapped when the page is (un)loaded: from the
// 3rd entry (the first two commands must be resident) to the end of the table, rounded
// to the DMA alignment of 8 bytes (checked by static asserts in t3d.c).
#define T3D_TABLES_DMEM         0x220
#define T3D_TABLES_SIZE         40

// Bytes of page data loaded at CLIP_BUFFER_TMP along with the page code (multiple of 8)
#define T3D_PAGE_DATA_SIZE      96

#endif
