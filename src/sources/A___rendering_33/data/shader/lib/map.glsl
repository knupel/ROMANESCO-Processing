
// map
float map(float value, float min_0, float max_0, float min_1, float max_1) {
  return min_1 + (max_1 - min_1) * (value - min_0) / (max_0 - min_0);
}

vec2 map(vec2 value, vec2 min_0, vec2 max_0, vec2 min_1, vec2 max_1) {
  return min_1 + (max_1 - min_1) * (value - min_0) / (max_0 - min_0);
}

vec3 map(vec3 value, vec3 min_0, vec3 max_0, vec3 min_1, vec3 max_1) {
  return min_1 + (max_1 - min_1) * (value - min_0) / (max_0 - min_0);
}

vec4 map(vec4 value, vec4 inMin, vec4 max_0, vec4 min_1, vec4 max_1) {
  return min_1 + (max_1 - min_1) * (value - min_0) / (max_0 - min_0);
}
