/**
SHADER filter
v 0.6.0
few method manipulate image with the shader to don't slower Processing
part
*/
PShader rope_shader_level, rope_shader_mix, rope_shader_blend, rope_shader_overlay, rope_shader_multiply;
PShader rope_shader_gaussian_blur ;
PShader rope_shader_resize ;

String shader_folder_path = null;
void shader_folder_filter(String path) {
  shader_folder_path = path;
}

/**
Gaussian blur
pass x2 vertical and horizontal

*/
void blur(PImage tex, float intensity) {
  blur(tex, intensity);
}

void blur(PGraphics p, PImage tex, float intensity) {
  set_blur(intensity) ;
  // temp
  if(temp_gaussian_blur == null) {
    temp_gaussian_blur = createImage(tex.width, tex.height, ARGB);
    tex.loadPixels() ;
    temp_gaussian_blur.pixels = tex.pixels;
    temp_gaussian_blur.updatePixels();
  }
  if(temp_gaussian_blur.width != tex.width || temp_gaussian_blur.height != tex.height) {
    temp_gaussian_blur.resize(tex.width, tex.height);
    tex.loadPixels() ;
    temp_gaussian_blur.pixels = tex.pixels;
    temp_gaussian_blur.updatePixels();
  }

  reset_blur(tex);

  if(rope_shader_gaussian_blur == null) {
    if(shader_folder_path != null) {
      rope_shader_gaussian_blur = loadShader(shader_folder_path+"rope_filter_gaussian_blur.glsl");
    } else {
      rope_shader_gaussian_blur = loadShader("shader/filter/rope_filter_gaussian_blur.glsl");
    }  
  }
  
  if(pass_rope_1 == null) {
    if(p == null) pass_rope_1 = createGraphics(tex.width,tex.height,P2D);
    else pass_rope_1 = createGraphics(p.width,p.height,P2D);
  }
  if(pass_rope_2 == null) {
    if(p == null) pass_rope_2 = createGraphics(tex.width,tex.height,P2D);
    else pass_rope_2 = createGraphics(p.width,p.height,P2D);
  }


  if(p != null) {
    rope_shader_gaussian_blur.set("PGraphics_renderer_is",true);
    float ratio_x = (float)p.width / (float)tex.width ;
    float ratio_y = (float)p.height / (float)tex.height ;
    rope_shader_gaussian_blur.set("wh_renderer_ratio",ratio_x, ratio_y);
  }

  rope_shader_gaussian_blur.set("blurSize", size_gaussian_blur_rope);
  rope_shader_gaussian_blur.set("sigma", sigma_gaussian_blur_rope);


  
  // Applying the blur shader along the vertical direction   
  rope_shader_gaussian_blur.set("horizontalPass", true);
  pass_rope_1.beginDraw();            
  pass_rope_1.shader(rope_shader_gaussian_blur);
  pass_rope_1.image(tex, 0, 0); 
  pass_rope_1.endDraw();

  // Applying the blur shader along the horizontal direction        
  rope_shader_gaussian_blur.set("horizontalPass", false);
   pass_rope_2.beginDraw();            
   pass_rope_2.shader(rope_shader_gaussian_blur);  
   pass_rope_2.image(pass_rope_1, 0, 0);
   pass_rope_2.endDraw(); 

  if(p == null) {
     pass_rope_2.loadPixels() ;
    tex.pixels =  pass_rope_2.pixels ;
    tex.updatePixels() ;
  } else {
     pass_rope_2.loadPixels();
    p.pixels =  pass_rope_2.pixels;
    p.updatePixels();

  }
}

/*
util blur
*/
PGraphics pass_rope_1, pass_rope_2;
PImage temp_gaussian_blur ;
void reset_blur(PImage tex) {
  if(temp_gaussian_blur != null) {
    temp_gaussian_blur.loadPixels() ;
    tex.pixels = temp_gaussian_blur.pixels;
    tex.updatePixels();
  }
}

int size_gaussian_blur_rope = 7 ;
float sigma_gaussian_blur_rope = 3f ;

void set_blur(float intensity) {
  size_gaussian_blur_rope = floor(intensity) ;
  sigma_gaussian_blur_rope = intensity *.5 ;
}







  
/**
multiply

*/
/**
* size
*/
/**
void multiply_size(int w1, int h1, int w2, int h2) {
  if(rope_shader_multiply == null) rope_shader_multiply = loadShader("shader/filter/rope_filter_multiply.glsl");
  rope_shader_multiply.set("wh_renderer_ratio",(float)w2 / (float)w1, (float)h2 / (float)h1);
}

void multiply_size(int w, int h) {
  if(rope_shader_multiply == null) rope_shader_multiply = loadShader("shader/filter/rope_filter_multiply.glsl");
  rope_shader_multiply.set("wh_renderer_ratio",1f/w, 1f/h);
}
*/

void set_multiply_shader() {
  if(rope_shader_multiply == null) {
    if(shader_folder_path != null) {
      rope_shader_multiply = loadShader(shader_folder_path+"rope_filter_multiply.glsl");
    } else {
      rope_shader_multiply = loadShader("shader/filter/rope_filter_multiply.glsl");
    }  
  }
}
/**
* flip 
*/
void multiply_flip_tex(boolean bx_tex, boolean by_tex) {
  multiply_flip(bx_tex,by_tex,false,false);
}

void multiply_flip_inc(boolean bx_inc, boolean by_inc) {
  multiply_flip(false,false,bx_inc,by_inc);
}

void multiply_flip(boolean bx, boolean by) {
  multiply_flip(bx,by,bx,by);
}

void multiply_flip(boolean bx_tex, boolean by_tex, boolean bx_inc, boolean by_inc) {
  set_multiply_shader();
  rope_shader_multiply.set("flip_tex",bx_tex,by_tex);
  rope_shader_multiply.set("flip_inc",bx_inc,by_inc);
}

/**
* follower method
*/
void multiply(PImage tex, PImage inc) {
  multiply(tex, inc, 1);
}

void multiply(PImage tex, PImage inc, vec2 ratio) {
  multiply(tex, inc, ratio.x, ratio.y);
}

void multiply(PImage tex, PImage inc, vec3 ratio) {
  multiply(tex, inc, ratio.x, ratio.y, ratio.z);
}

void multiply(PImage tex, PImage inc, vec4 ratio) {
  multiply(tex, inc, ratio.x, ratio.y, ratio.z, ratio.w);
}

void multiply(PImage tex, PImage inc, float... ratio) {
  if(ratio.length == 1) {
    multiply(null, tex, inc, ratio[0]);
  } else if(ratio.length == 2) {
    multiply(null, tex, inc, ratio[0], ratio[1]);
  } else if(ratio.length == 3) {
    multiply(null, tex, inc, ratio[0], ratio[1], ratio[2]);
  } else {
    multiply(null, tex, inc, ratio[0], ratio[1], ratio[2], ratio[3]);
  }
}


/**
* with PGraphics work
*/
void multiply(PGraphics p, PImage tex, PImage inc) {
  multiply(p, tex, inc, 1);
}

void multiply(PGraphics p, PImage tex, PImage inc, vec2 ratio) {
  multiply(p, tex, inc, ratio.x, ratio.y);
}

void multiply(PGraphics p, PImage tex, PImage inc, vec3 ratio) {
  multiply(p, tex, inc, ratio.x, ratio.y, ratio.z);
}

void multiply(PGraphics p, PImage tex, PImage inc, vec4 ratio) {
  multiply(p, tex, inc, ratio.x, ratio.y, ratio.z, ratio.w);
}
/**
* Master method multiply
* this method have a purpose to blend the four channel color.
* @param Pimage tex, is the image must be back
* @param Pimage inc, is the image must be incrusted on the background picture
* @param float [], vec2, vec3 or vec4 is the normal ratio overlaying
*/
void multiply(PGraphics p, PImage tex, PImage inc, float... ratio) {
  set_multiply_shader();
  
  vec4 r = array_to_vec4_rgba(ratio);

  rope_shader_multiply.set("incrustation",inc);
  rope_shader_multiply.set("ratio",r.x,r.z,r.w,r.z);

  if(p == null) {
    rope_shader_multiply.set("texture",tex);
    shader(rope_shader_multiply);
    //g.filter(rope_shader_multiply);
  } else {
    rope_shader_multiply.set("texture_PGraphics",tex);
    rope_shader_multiply.set("PGraphics_renderer_is",true);
    p.filter(rope_shader_multiply);
  }
}
/**
overlay

*/
/**
* size
*/
/**
void overlay_size(int w1, int h1, int w2, int h2) {
  if(rope_shader_overlay == null) rope_shader_overlay = loadShader("shader/filter/rope_filter_overlay.glsl");
  rope_shader_overlay.set("wh_renderer_ratio",(float)w2 / (float)w1, (float)h2 / (float)h1);
}
*/
void set_overlay_shader() {
  if(rope_shader_overlay == null) {
    if(shader_folder_path != null) {
      rope_shader_overlay = loadShader(shader_folder_path+"rope_filter_overlay.glsl");
    } else {
      rope_shader_overlay = loadShader("shader/filter/rope_filter_overlay.glsl");
    }  
  }
}
/**
* flip 
*/
void overlay_flip_tex(boolean bx_tex, boolean by_tex) {
  overlay_flip(bx_tex,by_tex,false,false);
}

void overlay_flip_inc(boolean bx_inc, boolean by_inc) {
  overlay_flip(false,false,bx_inc,by_inc);
}

void overlay_flip(boolean bx, boolean by) {
  overlay_flip(bx,by,bx,by);
}

void overlay_flip(boolean bx_tex, boolean by_tex, boolean bx_inc, boolean by_inc) {
  set_overlay_shader();
  rope_shader_overlay.set("flip_tex",bx_tex,by_tex);
  rope_shader_overlay.set("flip_inc",bx_inc,by_inc);
}
/**
* follower method
*/
void overlay(PImage tex, PImage inc) {
  overlay(tex, inc, 1);
}

void overlay(PImage tex, PImage inc, vec2 ratio) {
  overlay(tex, inc, ratio.x, ratio.y);
}

void overlay(PImage tex, PImage inc, vec3 ratio) {
  overlay(tex, inc, ratio.x, ratio.y, ratio.z);
}

void overlay(PImage tex, PImage inc, vec4 ratio) {
  overlay(tex, inc, ratio.x, ratio.y, ratio.z, ratio.w);
}

void overlay(PImage tex, PImage inc, float... ratio) {
  if(ratio.length == 1) {
    overlay(null, tex, inc, ratio[0]);
  } else if(ratio.length == 2) {
    overlay(null, tex, inc, ratio[0], ratio[1]);
  } else if(ratio.length == 3) {
    overlay(null, tex, inc, ratio[0], ratio[1], ratio[2]);
  } else {
    overlay(null, tex, inc, ratio[0], ratio[1], ratio[2], ratio[3]);
  }
}


/**
* with PGraphics work
*/
void overlay(PGraphics p, PImage tex, PImage inc) {
  overlay(p, tex, inc, 1);
}

void overlay(PGraphics p, PImage tex, PImage inc, vec2 ratio) {
  overlay(p, tex, inc, ratio.x, ratio.y);
}

void overlay(PGraphics p, PImage tex, PImage inc, vec3 ratio) {
  overlay(p, tex, inc, ratio.x, ratio.y, ratio.z);
}

void overlay(PGraphics p, PImage tex, PImage inc, vec4 ratio) {
  overlay(p, tex, inc, ratio.x, ratio.y, ratio.z, ratio.w);
}
/**
* Master method overlay
* this method have a purpose to blend the four channel color.
* @param Pimage tex, is the image must be back
* @param Pimage inc, is the image must be incrusted on the background picture
* @param float [], vec2, vec3 or vec4 is the normal ratio overlaying
*/
void overlay(PGraphics p, PImage tex, PImage inc, float... ratio) { 
  set_overlay_shader();

  vec4 r = array_to_vec4_rgba(ratio);
  
  rope_shader_overlay.set("incrustation",inc);
  rope_shader_overlay.set("ratio",r.x,r.z,r.w,r.z);
  
  if(p == null) {
    rope_shader_overlay.set("texture",tex);
    shader(rope_shader_overlay);
  } else {
    rope_shader_overlay.set("texture_PGraphics",tex);
    rope_shader_overlay.set("PGraphics_renderer_is",true);
    p.filter(rope_shader_overlay);
  }
}






/**
blend

*/
/**
* size
*/
/**
void blend_size(int w1, int h1, int w2, int h2) {
  if(rope_shader_blend == null) rope_shader_blend = loadShader("shader/filter/rope_filter_blend.glsl");
  rope_shader_blend.set("wh_renderer_ratio",(float)w2 / (float)w1, (float)h2 / (float)h1);
}
*/
void set_blend_shader() {
  if(rope_shader_blend == null) {
    if(shader_folder_path != null) {
      rope_shader_blend = loadShader(shader_folder_path+"rope_filter_blend.glsl");
    } else {
      rope_shader_blend = loadShader("shader/filter/rope_filter_blend.glsl");
    }  
  }
}
/**
* flip 
*/
void blend_flip_tex(boolean bx_tex, boolean by_tex) {
  blend_flip(bx_tex,by_tex,false,false);
}

void blend_flip_inc(boolean bx_inc, boolean by_inc) {
  blend_flip(false,false,bx_inc,by_inc);
}

void blend_flip(boolean bx, boolean by) {
  blend_flip(bx,by,bx,by);
}

void blend_flip(boolean bx_tex, boolean by_tex, boolean bx_inc, boolean by_inc) {
  set_blend_shader();
  rope_shader_overlay.set("flip_tex",bx_tex,by_tex);
  rope_shader_overlay.set("flip_inc",bx_inc,by_inc);
}
/**
* follower method
*/
void blend(PImage tex, PImage inc, float blend, vec2 ratio) {
  blend(null, tex, inc, blend, ratio.x, ratio.y);
}

void blend(PImage tex, PImage inc, float blend, vec3 ratio) {
  blend(null, tex, inc, blend, ratio.x, ratio.y, ratio.z);
}

void blend(PImage tex, PImage inc, float blend, vec4 ratio) {
  blend(null, tex, inc, blend, ratio.x, ratio.y, ratio.z, ratio.w);
}

void blend(PImage tex, PImage inc, float blend, float... ratio) {
  if(ratio.length == 1) {
    blend(null, tex, inc, blend, ratio[0]);
  } else if(ratio.length == 2) {
    blend(null, tex, inc, blend, ratio[0], ratio[1]);
  } else if(ratio.length == 3) {
    blend(null, tex, inc, blend, ratio[0], ratio[1], ratio[2]);
  } else {
    blend(null, tex, inc, blend, ratio[0], ratio[1], ratio[2], ratio[3]);
  }
}


/**
* with PGraphics work
*/
void blend(PGraphics p, PImage tex, float blend, PImage inc) {
  blend(p, tex, inc, blend, 1);
}

void blend(PGraphics p, PImage tex, PImage inc, float blend, vec2 ratio) {
  blend(p, tex, inc, blend, ratio.x, ratio.y);
}

void blend(PGraphics p, PImage tex, PImage inc, float blend, vec3 ratio) {
  blend(p, tex, inc, blend, ratio.x, ratio.y, ratio.z);
}

void blend(PGraphics p, PImage tex, PImage inc, float blend, vec4 ratio) {
  blend(p, tex, inc, blend, ratio.x, ratio.y, ratio.z, ratio.w);
}




/**
* Master method blend
* this method have a purpose to blend the four channel color.
* @param Pimage tex, is the image must be back
* @param Pimage inc, is the image must be incrusted on the background picture
* @param float [], vec2, vec3 or vec4 is the normal ratio overlaying
*/
void blend(PGraphics p, PImage tex, PImage inc, float blend, float... ratio) { 
  set_blend_shader();

  vec4 r = array_to_vec4_rgba(ratio);
  
  rope_shader_blend.set("incrustation",inc);
  rope_shader_blend.set("blend", blend);
  rope_shader_blend.set("ratio",r.x,r.z,r.w,r.z);
  
  if(p == null) {
    rope_shader_blend.set("texture",tex);
    shader(rope_shader_blend);
  } else {
    rope_shader_blend.set("texture_PGraphics",tex);
    rope_shader_blend.set("PGraphics_renderer_is",true);
    p.filter(rope_shader_blend);
  }
}

/**
mix

*/
/**
* size
*/
/**
void mix_size(int w1, int h1, int w2, int h2) {
  if(rope_shader_mix == null) rope_shader_mix = loadShader("shader/filter/rope_filter_mix.glsl");
  rope_shader_mix.set("wh_renderer_ratio",(float)w2 / (float)w1, (float)h2 / (float)h1);
}
*/
void set_mix_shader() {
  if(rope_shader_mix == null) {
    if(shader_folder_path != null) {
      rope_shader_mix = loadShader(shader_folder_path+"rope_filter_mix.glsl");
    } else {
      rope_shader_mix = loadShader("shader/filter/rope_filter_mix.glsl");
    }  
  }
}
/**
* flip 
*/
void mix_flip_tex(boolean bx_tex, boolean by_tex) {
  mix_flip(bx_tex,by_tex,false,false);
}

void mix_flip_inc(boolean bx_inc, boolean by_inc) {
  mix_flip(false,false,bx_inc,by_inc);
}

void mix_flip(boolean bx, boolean by) {
  mix_flip(bx,by,bx,by);
}

void mix_flip(boolean bx_tex, boolean by_tex, boolean bx_inc, boolean by_inc) {
  set_mix_shader();
  rope_shader_mix.set("flip_tex",bx_tex,by_tex);
  rope_shader_mix.set("flip_inc",bx_inc,by_inc);
}

/**
* without PGraphics work
*/
void mix(PImage tex, PImage inc) {
  mix(null, tex, inc, 1);
}

void mix(PImage tex, PImage inc, vec2 ratio) {
  mix(null, tex, inc, ratio.x, ratio.y);
}

void mix(PImage tex, PImage inc, vec3 ratio) {
  mix(null, tex, inc, ratio.x, ratio.y, ratio.z);
}

void mix(PImage tex, PImage inc, vec4 ratio) {
  mix(null, tex, inc, ratio.x, ratio.y, ratio.z, ratio.w);
}

void mix(PImage tex, PImage inc, float... ratio) {
  if(ratio.length == 1) {
    mix(null, tex, inc, ratio[0]);
  } else if(ratio.length == 2) {
    mix(null, tex, inc, ratio[0], ratio[1]);
  } else if(ratio.length == 3) {
    mix(null, tex, inc, ratio[0], ratio[1], ratio[2]);
  } else {
    mix(null, tex, inc, ratio[0], ratio[1], ratio[2], ratio[3]);
  }
}

/**
* with PGraphics work
*/
void mix(PGraphics p, PImage tex, PImage inc) {
  mix(p, tex, inc, 1);
}

void mix(PGraphics p, PImage tex, PImage inc, vec2 ratio) {
  mix(p, tex, inc, ratio.x, ratio.y);
}

void mix(PGraphics p, PImage tex, PImage inc, vec3 ratio) {
  mix(p, tex, inc, ratio.x, ratio.y, ratio.z);
}

void mix(PGraphics p, PImage tex, PImage inc, vec4 ratio) {
  mix(p, tex, inc, ratio.x, ratio.y, ratio.z, ratio.w);
}

/**
* Master method mix
* this method have a purpose to mix the four channel color.
*/
void mix(PGraphics p, PImage tex, PImage inc, float... ratio) {
  set_mix_shader();

  vec4 r = array_to_vec4_rgba(ratio); 
  
  rope_shader_mix.set("incrustation",inc);
  rope_shader_mix.set("ratio",r.r,r.g,r.b,r.a);

  if(p == null) {
    rope_shader_mix.set("texture",tex);
    shader(rope_shader_mix);
  } else {
    rope_shader_mix.set("texture_PGraphics",tex);
    rope_shader_mix.set("PGraphics_renderer_is",true);
    // Problem with MacBook Pro 2018 Grapichs 560X OSX Mojave
    p.filter(rope_shader_mix);
    /*
    try {
      p.filter(rope_shader_mix);
    } catch(java.lang.RuntimeException ArrayIndexOutBoundsException) { 
      printErrTempo(60,"void mix(PGraphics p, PImage tex, PImage inc, float... ratio): ArrayIndexOutBoundsException",frameCount);
    }
    */
  }
}

/**
level colour

*/
/**
* size
*/
/**
void level_size(int w1, int h1, int w2, int h2) {
  if(rope_shader_level == null) rope_shader_level = loadShader("shader/filter/rope_filter_level.glsl");
  rope_shader_level.set("wh_renderer_ratio",(float)w2 / (float)w1, (float)h2 / (float)h1);
}
*/
/**
* flip 
 */
void level_flip(boolean bx, boolean by) {
  if(rope_shader_level == null) {
    if(shader_folder_path != null) {
      rope_shader_level = loadShader(shader_folder_path+"rope_filter_level.glsl");
    } else {
      rope_shader_level = loadShader("shader/filter/rope_filter_level.glsl");
    }  
  }  
  rope_shader_level.set("flip",bx,by);
}
/**
* follower method
*/
void level(PImage tex, vec2 level) {
  level(tex,level.x,level.y);
}

void level(PImage tex, vec3 level) {
  level(tex,level.x,level.y,level.z);
}

void level(PImage tex, vec4 level) {
  level(tex,level.r,level.g,level.b,level.a);
}

void level(PImage tex, float... ratio) {
  if(ratio.length == 1) {
    level(null, tex, ratio[0]);
  } else if(ratio.length == 2) {
    level(null, tex, ratio[0], ratio[1]);
  } else if(ratio.length == 3) {
    level(null, tex, ratio[0], ratio[1], ratio[2]);
  } else {
    level(null, tex, ratio[0], ratio[1], ratio[2], ratio[3]);
  }
}

/**
* with PGraphics work
*/
void level(PGraphics p, PImage tex, PImage inc) {
  level(p, tex, 1);
}

void level(PGraphics p, PImage tex, vec2 ratio) {
  level(p, tex, ratio.x, ratio.y);
}

void level(PGraphics p, PImage tex, vec3 ratio) {
  level(p, tex, ratio.x, ratio.y, ratio.z);
}

void level(PGraphics p, PImage tex, vec4 ratio) {
  level(p, tex, ratio.x, ratio.y, ratio.z, ratio.w);
}
/**
* Master method level
* this method have a purpose to mix the four channel color.
*/
void level(PGraphics p, PImage tex, float... ratio) {
  if(rope_shader_level == null) {
    if(shader_folder_path != null) {
      rope_shader_level = loadShader(shader_folder_path+"rope_filter_level.glsl");
    } else {
      rope_shader_level = loadShader("shader/filter/rope_filter_level.glsl");
    }  
  } 

  vec4 r = array_to_vec4_rgba(ratio);
 
  rope_shader_level.set("level",r.r,r.g,r.b,r.a);

  if( p == null ) {
    rope_shader_level.set("texture",tex);
    shader(rope_shader_level);
  } else {
    rope_shader_level.set("texture_PGraphics",tex);
    rope_shader_level.set("PGraphics_renderer_is",true);
    p.filter(rope_shader_level);
  }
}
