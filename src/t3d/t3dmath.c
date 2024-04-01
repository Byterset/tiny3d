/**
* @copyright 2023 - Max Bebök
* @license MIT
*/

#include <t3d/t3dmath.h>

void t3d_mat4_look_at(T3DMat4 *mat, const T3DVec3 *eye, const T3DVec3 *target, const T3DVec3 *up)
{
  T3DVec3 forward, side, upCalc;

  t3d_vec3_diff(&forward, target, eye);
  t3d_vec3_norm(&forward);

  t3d_vec3_cross(&side, &forward, up);
  t3d_vec3_norm(&side);

  t3d_vec3_cross(&upCalc, &side, &forward);

  float dotSide = -t3d_vec3_dot(&side, eye);
  float dotUp   = -t3d_vec3_dot(&upCalc, eye);
  float dotFwd  = t3d_vec3_dot(&forward, eye);

  *mat = (T3DMat4){{
    {side.v[0], upCalc.v[0], -forward.v[0], 0.0f},
    {side.v[1], upCalc.v[1], -forward.v[1], 0.0f},
    {side.v[2], upCalc.v[2], -forward.v[2], 0.0f},
    {dotSide,   dotUp,        dotFwd,       1.0f}
  }};
}

void t3d_mat4_perspective(T3DMat4 *mat, float fov, float aspect, float near, float far) {
  float tanHalfFov = tanf(fov * 0.5f);
  *mat = (T3DMat4){0};
  mat->m[0][0] = 1.0f / (aspect * tanHalfFov);
  mat->m[1][1] = 1.0f / tanHalfFov;
  mat->m[2][2] = far / (near - far);
  mat->m[2][3] = -1.0f;
  mat->m[3][2] = -2.0f * (far * near) / (far - near);
}

void t3d_mat4_from_srt(T3DMat4 *mat, float scale[3], float quat[4], float translate[3])
{
  *mat = (T3DMat4){{
    {(1.0f - 2.0f * quat[2] * quat[2] - 2.0f * quat[0] * quat[0]) * scale[0],        (2.0f * quat[1] * quat[2] - 2.0f * quat[3] * quat[0]) * scale[0],        (2.0f * quat[1] * quat[0] + 2.0f * quat[3] * quat[2]) * scale[0], 0.0f},
    {       (2.0f * quat[1] * quat[2] + 2.0f * quat[3] * quat[0]) * scale[1], (1.0f - 2.0f * quat[1] * quat[1] - 2.0f * quat[0] * quat[0]) * scale[1],        (2.0f * quat[2] * quat[0] - 2.0f * quat[3] * quat[1]) * scale[1], 0.0f},
    {       (2.0f * quat[1] * quat[0] - 2.0f * quat[3] * quat[2]) * scale[2],        (2.0f * quat[2] * quat[0] + 2.0f * quat[3] * quat[1]) * scale[2], (1.0f - 2.0f * quat[1] * quat[1] - 2.0f * quat[2] * quat[2]) * scale[2], 0.0f},
    {translate[0], translate[1], translate[2], 1.0f}
  }};
}

void t3d_mat4_from_srt_euler(T3DMat4 *mat, float scale[3], float rot[3], float translate[3])
{
  float cosR0 = fm_cosf(rot[0]);
  float cosR2 = fm_cosf(rot[2]);
  float cosR1 = fm_cosf(rot[1]);

  float sinR0 = fm_sinf(rot[0]);
  float sinR1 = fm_sinf(rot[1]);
  float sinR2 = fm_sinf(rot[2]);

  *mat = (T3DMat4){{
    {scale[0] * cosR2 * cosR1, scale[0] * (cosR2 * sinR1 * sinR0 - sinR2 * cosR0), scale[0] * (cosR2 * sinR1 * cosR0 + sinR2 * sinR0), 0.0f},
    {scale[1] * sinR2 * cosR1, scale[1] * (sinR2 * sinR1 * sinR0 + cosR2 * cosR0), scale[1] * (sinR2 * sinR1 * cosR0 - cosR2 * sinR0), 0.0f},
    {-scale[2] * sinR1, scale[2] * cosR1 * sinR0, scale[2] * cosR1 * cosR0, 0.0f},
    {translate[0], translate[1], translate[2], 1.0f}
  }};
}

void t3d_mat4fp_from_srt_euler(T3DMat4FP *mat, float scale[3], float rot[3], float translate[3]) {
  T3DMat4 matF; // @TODO: avoid temp matrix
  t3d_mat4_from_srt_euler(&matF, scale, rot, translate);
  t3d_mat4_to_fixed(mat, &matF);
}

void t3d_mat4fp_from_srt(T3DMat4FP *mat, float scale[3], float rotQuat[4], float translate[3]) {
  T3DMat4 matF; // @TODO: avoid temp matrix
  t3d_mat4_from_srt(&matF, scale, rotQuat, translate);
  t3d_mat4_to_fixed(mat, &matF);
}

void t3d_mat4_rotate(T3DMat4 *mat, const T3DVec3* axis, float angleRad)
{
  float s, c;
  // @TODO: currently buggy in libdragon, use once fixed
  // fm_sincosf(angleRad, &s, &c);
  s = fm_sinf(angleRad);
  c = fm_cosf(angleRad);

  float t = 1.0f - c;

  float x = axis->v[0];
  float y = axis->v[1];
  float z = axis->v[2];

  mat->m[0][0] = t * x * x + c;
  mat->m[0][1] = t * x * y - s * z;
  mat->m[0][2] = t * x * z + s * y;
  mat->m[0][3] = 0.0f;

  mat->m[1][0] = t * x * y + s * z;
  mat->m[1][1] = t * y * y + c;
  mat->m[1][2] = t * y * z - s * x;
  mat->m[1][3] = 0.0f;

  mat->m[2][0] = t * x * z - s * y;
  mat->m[2][1] = t * y * z + s * x;
  mat->m[2][2] = t * z * z + c;
  mat->m[2][3] = 0.0f;

  mat->m[3][0] = 0.0f;
  mat->m[3][1] = 0.0f;
  mat->m[3][2] = 0.0f;
  mat->m[3][3] = 1.0f;
}
