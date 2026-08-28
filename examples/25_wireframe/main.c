#include <libdragon.h>
#include <t3d/t3d.h>
#include <t3d/t3dmodel.h>

#define FB_COUNT 3

/**
 * Wireframe rendering.
 *
 * 't3d_wireframe_set(true)' swaps in a second ucode that draws every triangle as
 * three depth-tested lines instead of a filled surface. It answers to the same
 * commands as tiny3d, so the display-lists below are recorded once, the normal
 * way, and simply render as wireframes while the mode is on.
 *
 * Lines carry no UVs and can only be shaded, so what a line ends up looking like
 * still depends on the material the recorded block installed. In vertex-color
 * mode that is left alone, so the model's materials keep tinting the wireframe.
 * Switching to a flat color (B) also makes the ucode install its own shade-only
 * combiner ahead of each batch of lines, so the color always wins.
 */

typedef struct {
  T3DModel *model;
  const char *name;
  float scale;
  rspq_block_t *dpl;
} Model;

[[noreturn]]
int main()
{
  debug_init_isviewer();
  debug_init_usblog();
  asset_init_compression(2);

  dfs_init(DFS_DEFAULT_LOCATION);
  display_init(RESOLUTION_640x480, DEPTH_16_BPP, FB_COUNT, GAMMA_NONE, FILTERS_RESAMPLE_ANTIALIAS);

  rdpq_init();
  joypad_init();
  t3d_init((T3DInitParams){});

  rdpq_text_register_font(FONT_BUILTIN_DEBUG_MONO, rdpq_font_load_builtin(FONT_BUILTIN_DEBUG_MONO));

  T3DMat4FP* modelMatFP = malloc_uncached(sizeof(T3DMat4FP) * FB_COUNT);
  T3DViewport viewport = t3d_viewport_create_buffered(FB_COUNT);

  const fm_vec3_t camPos = {{0, 12.0f, 45.0f}};
  const fm_vec3_t camTarget = {{0, 0, 0}};

  uint8_t colorAmbient[4] = {80, 50, 50, 0xFF};
  fm_vec3_t lightDirVec = {{1.0f, 1.0f, 0.0f}};
  uint8_t lightDirColor[4] = {120, 120, 120, 0xFF};
  fm_vec3_norm(&lightDirVec, &lightDirVec);

  Model models[] = {
    (Model){.model = t3d_model_load("rom:/box.t3dm"),   .name = "Box",   .scale = 0.14f},
    (Model){.model = t3d_model_load("rom:/model.t3dm"), .name = "Gear",  .scale = 0.09f},
    (Model){.model = t3d_model_load("rom:/food.t3dm"),  .name = "Donut",  .scale = 0.14f},
  };
  const int modelCount = sizeof(models) / sizeof(models[0]);

  for(int i = 0; i < modelCount; ++i)
  {
    // The normal draw, materials and all, recorded once.
    rspq_block_begin();
      t3d_model_draw(models[i].model);
    models[i].dpl = rspq_block_end();
  }

  float rotAngle = 0.0f;
  int frameIdx = 0;
  int currModelIdx = 0;
  bool wireframe = false;
  bool flatColor = false;
  float lineWidth = 1.0f;

  for(;;)
  {
    // ======== Update ======== //
    joypad_poll();
    joypad_buttons_t btn = joypad_get_buttons_pressed(JOYPAD_PORT_1);

    if(btn.l || btn.d_left)--currModelIdx;
    if(btn.r || btn.d_right)++currModelIdx;
    if(currModelIdx < 0)currModelIdx += modelCount;
    currModelIdx %= modelCount;

    if(btn.a) {
      wireframe = !wireframe;
      t3d_wireframe_set(wireframe);
    }
    if(btn.b) {
      flatColor = !flatColor;
      if(flatColor) t3d_wireframe_set_color(RGBA32(0x00, 0xFF, 0x80, 0xFF));
      else          t3d_wireframe_use_vertex_color();
    }
    if(btn.c_up) {
      lineWidth += 0.5f;
      if(lineWidth > 8.0f)lineWidth = 8.0f;
      t3d_wireframe_set_width(lineWidth);
    }
    if(btn.c_down) {
      lineWidth -= 0.5f;
      if(lineWidth < 0.5f)lineWidth = 0.5f;
      t3d_wireframe_set_width(lineWidth);
    }

    Model* model = &models[currModelIdx];

    frameIdx = (frameIdx + 1) % FB_COUNT;
    rotAngle += 0.01f;

    t3d_viewport_set_projection(&viewport, T3D_DEG_TO_RAD(70.0f), 10.0f, 150.0f);
    t3d_viewport_look_at(&viewport, &camPos, &camTarget, &(fm_vec3_t){{0, 1, 0}});

    t3d_mat4fp_from_srt_euler(&modelMatFP[frameIdx],
      (float[3]){model->scale, model->scale, model->scale},
      (float[3]){rotAngle * 0.4f, rotAngle, rotAngle * 0.7f},
      (float[3]){0, 0, 0}
    );

    // ======== Draw (3D) ======== //
    rdpq_attach(display_get(), display_get_zbuf());
    t3d_frame_start();
    t3d_viewport_attach(&viewport);

    rdpq_set_prim_color(RGBA32(0, 0, 0, 0xFF));

    t3d_screen_clear_color(RGBA32(20, 20, 30, 0xFF));
    t3d_screen_clear_depth();

    t3d_light_set_ambient(colorAmbient);
    t3d_light_set_directional(0, lightDirColor, &lightDirVec);
    t3d_light_set_count(1);

    t3d_matrix_push(&modelMatFP[frameIdx]);
    rspq_block_run(model->dpl);
    t3d_matrix_pop(1);

    // ======== Draw (2D) ======== //
    rdpq_text_printf(NULL, FONT_BUILTIN_DEBUG_MONO, 12, 168, "[L/R] Model   : %s", model->name);
    rdpq_text_printf(NULL, FONT_BUILTIN_DEBUG_MONO, 12, 180, "[A] Wireframe : %s", wireframe ? "ON" : "OFF");
    rdpq_text_printf(NULL, FONT_BUILTIN_DEBUG_MONO, 12, 192, "[B] Color     : %s", flatColor ? "flat (forced)" : "material");
    rdpq_text_printf(NULL, FONT_BUILTIN_DEBUG_MONO, 12, 204, "[C] Width     : %.1f px", (double)lineWidth);
    rdpq_text_printf(NULL, FONT_BUILTIN_DEBUG_MONO, 12, 216, "    FPS       : %.1f", (double)display_get_fps());

    rdpq_detach_show();
  }
}
