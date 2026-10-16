#!/bin/sh
# Regenerates the ucode sources from RSPL (https://github.com/HailToDodongo/rspl, C++ version).
# Run from this directory, set RSPL to the transpiler binary (default: 'rspl' in PATH).
#
#  rsp_tiny3d.S              main overlay
#  rsp_tiny3d_clipping.S     clipping overlay (same source with OVERLAY_CLIPPING)
#  rsp_t3d_material_rspl.inc material page (code only, included by rsp_t3d_material.S)
#  rspq_triangle_rspl.inc    triangle code (see buid_tri.sh)
#
# If the size of the vertex loading code changes, update T3D_WINDOW_SIZE in t3d_page.h.
set -e

RSPL=${RSPL:-rspl}
# the seed makes the optimizer output reproducible
OPTS="--reorder --opt-anneal --opt-time=${RSPL_OPT_TIME:-10} --opt-seed=1"

$RSPL rsp_tiny3d.rspl          $OPTS -o rsp_tiny3d.S
$RSPL rsp_tiny3d_clipping.rspl $OPTS -o rsp_tiny3d_clipping.S
$RSPL rsp_t3d_material.rspl    --no-rspq=include -o rsp_t3d_material_rspl.inc

# RSPQ_PROFILE needs a profile slot in the saved state, taken from the light and clip
# buffers. RSPL cannot emit assembly-time conditionals in the state, so patch them in.
for f in rsp_tiny3d.S rsp_tiny3d_clipping.S; do
  sed -i \
    -e 's/^\(\s*\)LIGHT_DIR_COLOR: \.ds\.b 112$/\1#if RSPQ_PROFILE\n\1LIGHT_DIR_COLOR: .ds.b 32\n\1_RSPQ_OVL_PROFILESLOT: .long 0, 0\n\1#else\n\1LIGHT_DIR_COLOR: .ds.b 112\n\1#endif/' \
    -e 's/^\(\s*\)CLIP_BUFFER_RESULT: \.ds\.b 252$/\1#if RSPQ_PROFILE\n\1CLIP_BUFFER_RESULT: .ds.b 236\n\1#else\n\1CLIP_BUFFER_RESULT: .ds.b 252\n\1#endif/' \
    "$f"
done
