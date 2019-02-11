/**
Mix by Stan le punk 
@see https://github.com/StanLepunK
v 0.0.3
2019-2019
*/
// Processing implementation
#ifdef GL_ES
precision highp float;
#endif
#define PROCESSING_TEXTURE_SHADER
varying vec4 vertColor;
varying vec4 vertTexCoord;

// sketch implementation template, uniform use by most of filter Romanesco shader
uniform sampler2D texture_source;
uniform vec2 resolution_source;
uniform bvec2 flip_source;
uniform vec3 level_source;

uniform sampler2D texture_layer;
uniform vec3 level_layer;
uniform bvec2 flip_layer;

uniform int mode;


/**
UTIL TEMPLATE
*/
vec2 set_uv(bool flip_vertical, bool flip_horizontal, vec2 res) {
  vec2 uv;
  if(all(equal(vec2(0),res))) {
    uv = vertTexCoord.st;
  } else if(all(greaterThan(res,vertTexCoord.st))) {
    uv = vertTexCoord.st;
  } else {
    uv = res;
  }
  // flip 
  if(!flip_vertical && !flip_horizontal) {
    return uv;
  } else if(flip_vertical && !flip_horizontal) {
    uv.y = 1 -uv.y;
    return uv;
  } else if(!flip_vertical && flip_horizontal) {
    uv.x = 1 -uv.x;
    return uv;
  } else if(flip_vertical && flip_horizontal) {
    return vec2(1) -uv;
  } return uv;
}

vec2 set_uv(bvec2 flip, vec2 res) {
  return set_uv(flip.x,flip.y,res);
}




vec4 set_color(vec4 color, vec4 mix) {
	vec4 ratio = mix;
  if(ratio.x < 0) ratio.x = 0;
  if(ratio.y < 0) ratio.y = 0;
  if(ratio.z < 0) ratio.z = 0;
  if(ratio.w < 0) ratio.w = 0;
  bvec4 state = equal(ratio,vec4(0));
  bool use_ratio_is = true;
  if(all(state)) {
  	ratio = vec4(1);
    use_ratio_is = false;
  }
  
  if(use_ratio_is) {
    return mix(vec4(0),color,ratio);;
  } else return color;
}



vec3 multiply(vec3 src, vec3 dst) {
  return src * dst;
}

vec3 screen(vec3 src, vec3 dst) {
  return src + dst - src * dst;
}

vec3 exclusion(vec3 src, vec3 dst) {
  return dst + src - (2.0*dst*src);;
}

vec3 overlay(vec3 src, vec3 dst) {
	return mix(2.0 * src * dst, 1.0 - 2.0 * (1.0 - src) * (1.0-dst), step(0.5, dst));
}

vec3 hard_light(vec3 src, vec3 dst) {
  return mix(2.0 * src * dst,  1.0 - 2.0 * (1.0 - src) * (1.0-dst), step(0.5, src));
}

vec3 soft_light(vec3 src, vec3 dst) {
  return mix(dst - (1.0 - 2.0 * src) * dst * (1.0 - dst), 
             mix(dst + ( 2.0 * src - 1.0 ) * (sqrt(dst) - dst),
                 dst + (2.0 * src - 1.0) * dst * ((16.0 * dst - 12.0) * dst + 3.0),
                 step(0.5, src) * (1.0 - step(0.25, dst))),
             step(0.5, src));
}


vec3 color_dodge(vec3 src, vec3 dst) {
  return step(0.0, dst) * mix(min(vec3(1.0), dst/ (1.0 - src)), vec3(1.0), step(1.0, src)); 
}

vec3 color_burn(vec3 src, vec3 dst) {
  return mix(step(0.0, src) * (1.0 - min(vec3(1.0), (1.0 - dst) / src)),
        vec3(1.0), step(1.0, dst));
}

vec3 linear_dodge(vec3 src, vec3 dst) {
  return clamp(src.xyz + dst.xyz, 0.0, 1.0);
}

vec3 linear_burn(vec3 src, vec3 dst) {
  return clamp(src.xyz + dst.xyz - 1.0, 0.0, 1.0);
}

vec3 vivid_light(vec3 src, vec3 dst) {
  return mix(max(vec3(0.0), 1.0 - min(vec3(1.0), (1.0 - dst) / (2.0 * src))),
               min(vec3(1.0), dst / (2.0 * (1.0 - src))),
               step(0.5, src));
}

vec3 linear_light(vec3 src, vec3 dst) {
  return clamp(2.0 * src + dst - 1.0, 0.0, 1.0);;
}

vec3 pin_light(vec3 src, vec3 dst) {
  return mix(mix(2.0 * src, dst, step(0.5 * dst, src)),
        max(vec3(0.0), 2.0 * src - 1.0), 
        step(dst, (2.0 * src - 1.0))
    );
}

vec3 hard_mix(vec3 src, vec3 dst) {
  return step(1.0, src + dst);
}

vec3 subtract(vec3 src, vec3 dst) {
  return dst - src;
}

vec3 divide(vec3 src, vec3 dst) {
  return dst / src;
}

vec3 addition(vec3 src, vec3 dst) {
  return src + dst;
}

vec3 difference(vec3 src, vec3 dst) {
  return abs(dst - src);   
}

vec3 darken(vec3 src, vec3 dst) {
  return min(src,dst);
}

vec3 lighten(vec3 src, vec3 dst) {
  return max(src,dst);
}

vec3 invert(vec3 src, vec3 dst) {
  return 1.0 - dst;
}

vec3 invert_rgb(vec3 src, vec3 dst) {
  return src * (1.0 - dst);
}

vec3 source(vec3 src, vec3 dst) {
  return src;
}

vec3 dest(vec3 src, vec3 dst) {
  return dst;
}





void main() {
  vec2 uv_source = set_uv(flip_source,resolution_source);
  vec2 uv_layer = set_uv(flip_layer,resolution_source);

	vec4 source = set_color(texture(texture_source,uv_source),vec4(level_source,1));
	vec4 layer = set_color(texture(texture_layer,uv_layer),vec4(level_layer,1));
  float alpha = 1.;
  if(mode == -2) {
    gl_FragColor = vec4(source(source.xyz,layer.xyz),alpha);
  } else if(mode == -1) {
    gl_FragColor = vec4(dest(source.xyz,layer.xyz),alpha);

  } else if(mode == 1) {
    gl_FragColor = vec4(multiply(source.xyz,layer.xyz),alpha);
  } else if(mode == 2) {
    gl_FragColor = vec4(screen(source.xyz,layer.xyz),alpha);
  } else if(mode == 3) {
    gl_FragColor = vec4(exclusion(source.xyz,layer.xyz),alpha);
  } else if(mode == 4) {
    gl_FragColor = vec4(overlay(source.xyz,layer.xyz),alpha);
  } else if(mode == 5) {
    gl_FragColor = vec4(hard_light(source.xyz,layer.xyz),alpha);
  } else if(mode == 6) {
    gl_FragColor = vec4(soft_light(source.xyz,layer.xyz),alpha);
  } else if(mode == 7) {
    gl_FragColor = vec4(color_dodge(source.xyz,layer.xyz),alpha);
  } else if(mode == 8) {
    gl_FragColor = vec4(color_burn(source.xyz,layer.xyz),alpha);
  } else if(mode == 9) {
    gl_FragColor = vec4(linear_dodge(source.xyz,layer.xyz),alpha);
  } else if(mode == 10) {
    gl_FragColor = vec4(linear_burn(source.xyz,layer.xyz),alpha);
  } else if(mode == 11) {
    gl_FragColor = vec4(vivid_light(source.xyz,layer.xyz),alpha);
  } else if(mode == 12) {
    gl_FragColor = vec4(linear_light(source.xyz,layer.xyz),alpha);
  } else if(mode == 13) {
    gl_FragColor = vec4(pin_light(source.xyz,layer.xyz),alpha);
  } else if(mode == 14) {
    gl_FragColor = vec4(hard_mix(source.xyz,layer.xyz),alpha);
  } else if(mode == 15) {
    gl_FragColor = vec4(subtract(source.xyz,layer.xyz),alpha);
  } else if(mode == 16) {
    gl_FragColor = vec4(divide(source.xyz,layer.xyz),alpha);
  } else if(mode == 17) {
    gl_FragColor = vec4(addition(source.xyz,layer.xyz),alpha);
  } else if(mode == 18) {
    gl_FragColor = vec4(difference(source.xyz,layer.xyz),alpha);
  } else if(mode == 19) {
    gl_FragColor = vec4(darken(source.xyz,layer.xyz),alpha);
  } else if(mode == 20) {
    gl_FragColor = vec4(lighten(source.xyz,layer.xyz),alpha);
  } else if(mode == 21) {
    gl_FragColor = vec4(invert(source.xyz,layer.xyz),alpha);
  } else if(mode == 22) {
    gl_FragColor = vec4(invert_rgb(source.xyz,layer.xyz),alpha);
  } else if(mode == 23) {
    gl_FragColor = vec4(source(source.xyz,layer.xyz),alpha);
  } else if(mode == 24) {
    gl_FragColor = vec4(dest(source.xyz,layer.xyz),alpha);
  } else {
    gl_FragColor = vec4(source(source.xyz,layer.xyz),alpha); 	
  }
}






