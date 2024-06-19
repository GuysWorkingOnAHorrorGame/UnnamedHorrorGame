shader_type sky;
render_mode use_half_res_pass;

uniform sampler2D grid_tex;

vec3 generateGrid(float gridSize, vec2 uv) {
   vec2 gridUV = fract(uv * gridSize);
   float distToLineX = abs(gridUV.x - 0.5) * 2.0;
   float distToLineY = abs(gridUV.y - 0.5) * 2.0;
   float gridX = smoothstep(-4.5, 5.5, distToLineX);
   float gridY = smoothstep(-4.5, 5.5, distToLineY);
   float grid = min(gridX, gridY);
   grid = clamp(grid * 2.2, 0.0, 1.0);
   return vec3(0.0,1.0-grid,0.0);
}

void sky() {
   float depth = abs(EYEDIR.y);
   vec2 sky_uv_y = EYEDIR.xz / sqrt(EYEDIR.y);
   if (EYEDIR.y > 0.0) {
      COLOR = mix(vec3(0.0), generateGrid(10, sky_uv_y + (POSITION.xz/10.0))*10.0, depth*0.1);
      ALPHA = -depth*100.0;
   }
} 