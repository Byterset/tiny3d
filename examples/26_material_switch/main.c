#include <libdragon.h>
#include <t3d/t3d.h>
#include <t3d/t3dmodel.h>

/**
 * Stress test for material switches: draws a grid of tiny objects alternating between
 * two models, so that the frame is dominated by material changes instead of geometry.
 * This exercises the rdpq mode commands executed in place by the tiny3d ucode
 * (see t3d_rdpq_redirect_begin), both inside rspq blocks and with direct draws.
 *
 *   C-Up/C-Down : more / fewer objects
 *   A           : toggle between rspq blocks and direct drawing
 */
#define FB_COUNT 3
#define MODEL_COUNT 2
#define OBJ_MAX 256
#define GRID_COLS 12

static int count_materials(const T3DModel *model) {
  int count = 0;
  T3DModelIter it = t3d_model_iter_create(model, T3D_CHUNK_TYPE_MATERIAL);
  while(t3d_model_iter_next(&it))++count;
  return count;
}

[[noreturn]]
int main()
{
  debug_init_isviewer();
  debug_init_usblog();
  asset_init_compression(2);
  dfs_init(DFS_DEFAULT_LOCATION);

  display_init(RESOLUTION_320x240, DEPTH_16_BPP, FB_COUNT, GAMMA_NONE, FILTERS_RESAMPLE_ANTIALIAS);
  rdpq_init();
  joypad_init();

  t3d_init((T3DInitParams){});
  T3DViewport viewport = t3d_viewport_create_buffered(FB_COUNT);
  rdpq_text_register_font(FONT_BUILTIN_DEBUG_MONO, rdpq_font_load_builtin(FONT_BUILTIN_DEBUG_MONO));

  const char *modelPaths[MODEL_COUNT] = {"rom:/box.t3dm", "rom:/food.t3dm"};
  const float modelScale[MODEL_COUNT] = {0.05f, 0.05f};
  T3DModel *models[MODEL_COUNT];
  rspq_block_t *dpls[MODEL_COUNT];
  int materialCount[MODEL_COUNT];
  for(int i=0; i<MODEL_COUNT; ++i) {
    models[i] = t3d_model_load(modelPaths[i]);
    materialCount[i] = count_materials(models[i]);
    rspq_block_begin();
      t3d_model_draw(models[i]);
    dpls[i] = rspq_block_end();
  }

  T3DMat4FP *modelMat = malloc_uncached(sizeof(T3DMat4FP) * OBJ_MAX * FB_COUNT);

  const fm_vec3_t camPos = {{0, 90.0f, 110.0f}};
  const fm_vec3_t camTarget = {{0, 0, 0}};
  uint8_t colorAmbient[4] = {80, 80, 80, 0xFF};
  uint8_t lightDirColor[4] = {160, 160, 160, 0xFF};
  fm_vec3_t lightDirVec = {{1.0f, 1.0f, 0.5f}};
  fm_vec3_norm(&lightDirVec, &lightDirVec);

  int objCount = 60;
  bool useBlocks = true;
  int frameIdx = 0;
  float rotation = 0.0f;

  for(;;)
  {
    joypad_poll();
    joypad_buttons_t pressed = joypad_get_buttons_pressed(JOYPAD_PORT_1);
    if(pressed.c_up)objCount += 10;
    if(pressed.c_down)objCount -= 10;
    if(pressed.a)useBlocks = !useBlocks;
    if(objCount < 1)objCount = 1;
    if(objCount > OBJ_MAX)objCount = OBJ_MAX;

    frameIdx = (frameIdx + 1) % FB_COUNT;
    rotation += 0.02f;

    int materialSwitches = 0;
    for(int i=0; i<objCount; ++i) {
      int m = i % MODEL_COUNT;
      materialSwitches += materialCount[m];
      float s = modelScale[m];
      float pos[3] = {
        ((i % GRID_COLS) - (GRID_COLS-1) * 0.5f) * 14.0f, 0,
        ((i / GRID_COLS) - (OBJ_MAX / GRID_COLS) * 0.5f) * 14.0f + 60.0f
      };
      t3d_mat4fp_from_srt_euler(&modelMat[frameIdx * OBJ_MAX + i],
        (float[3]){s, s, s}, (float[3]){0, rotation + i * 0.3f, 0}, pos);
    }

    t3d_viewport_set_projection(&viewport, T3D_DEG_TO_RAD(65.0f), 10.0f, 300.0f);
    t3d_viewport_look_at(&viewport, &camPos, &camTarget, &(fm_vec3_t){{0,1,0}});

    rdpq_attach(display_get(), display_get_zbuf());
    t3d_frame_start();
    t3d_viewport_attach(&viewport);

    t3d_screen_clear_color(RGBA32(30, 30, 40, 0xFF));
    t3d_screen_clear_depth();

    t3d_light_set_ambient(colorAmbient);
    t3d_light_set_directional(0, lightDirColor, &lightDirVec);
    t3d_light_set_count(1);

    t3d_matrix_push_pos(1);
    for(int i=0; i<objCount; ++i) {
      t3d_matrix_set(&modelMat[frameIdx * OBJ_MAX + i], true);
      if(useBlocks) {
        rspq_block_run(dpls[i % MODEL_COUNT]);
      } else {
        t3d_model_draw(models[i % MODEL_COUNT]);
      }
    }
    t3d_matrix_pop(1);

    rdpq_sync_pipe();
    rdpq_text_printf(NULL, FONT_BUILTIN_DEBUG_MONO, 16, 200, "[C] Objects  : %d", objCount);
    rdpq_text_printf(NULL, FONT_BUILTIN_DEBUG_MONO, 16, 210, "[A] Draw mode: %s", useBlocks ? "blocks" : "direct");
    rdpq_text_printf(NULL, FONT_BUILTIN_DEBUG_MONO, 16, 220, "Materials/frame: %d  FPS: %.2f", materialSwitches, display_get_fps());

    rdpq_detach_show();
  }
}
