/**
ROMANESCO BACKGROUND 
v 1.1.2
*/
Vec4 colorBackground, colorBackgroundRef, colorBackgroundPrescene;
void background_setup() {
  colorBackgroundRef = Vec4() ;
  colorBackground = Vec4() ;
  colorBackgroundPrescene = Vec4(0,0,20,g.colorModeA) ;
}


void background_romanesco() {
  // in preview mode the background is always on, to remove the trace effect
  if(!FULL_RENDERING) { 
    background_button_is(false) ;
    colorBackground = colorBackgroundPrescene.copy() ;
    background_rope(0,0,g.colorModeZ *.2,g.colorModeA) ;
  } else if(FULL_RENDERING) {
    if(background_button_is()) {
      if(which_shader == 0) {
        // check if the color model is changed after the shader used
        if(g.colorMode != 3 || g.colorModeX != 360 || g.colorModeY != 100 || g.colorModeZ !=100 || g.colorModeA !=100) {
          colorMode(HSB,360,100,100,100);
        }
        // choice the rendering color palette for the classic background
        if(FULL_RENDERING) {
          // check if the slider background are move, if it's true update the color background
          if(!equals(colorBackgroundRef,update_background())) {
            colorBackground.set(update_background()) ;
          } else {
            colorBackgroundRef.set(update_background()) ;
          }
          background_rope(colorBackground) ;
        }
        background_rope(colorBackground) ;
      } else {
        background_shader_draw(which_shader) ;
      }
    }
  }
}

// ANNEXE VOID BACKGROUND
Vec4 update_background() {
  //to smooth the curve of transparency background
  // HSB
  float hue_bg = map(value_slider_background[0],0,MAX_VALUE_SLIDER,0,HSBmode.r);
  float saturation_bg = map(value_slider_background[1],0,MAX_VALUE_SLIDER,0,HSBmode.g);
  float brigthness_bg = map(value_slider_background[2],0,MAX_VALUE_SLIDER,0,HSBmode.b);
  // ALPHA
  float factorSmooth = 2.5;
  float nx = norm(value_slider_background[3],.0,MAX_VALUE_SLIDER);
  float alpha = pow (nx, factorSmooth);
  alpha = map(alpha,0,1,.8,HSBmode.a);
  return Vec4(hue_bg,saturation_bg,brigthness_bg,alpha) ;
}

// BACKGROUND SHADER
PShader cellular, heart, necklace, neon, psy, snow;

void background_shader_setup() {
  String pathShaderBG = preference_path +"shader/shader_bg/" ;

  cellular = loadShader(pathShaderBG+"cellular.glsl") ;
  heart = loadShader(pathShaderBG+"heart.glsl") ;
  necklace = loadShader(pathShaderBG+"necklace.glsl") ;
  neon = loadShader(pathShaderBG+"neon.glsl") ;
  psy = loadShader(pathShaderBG+"psy.glsl") ;
  snow = loadShader(pathShaderBG+"snow.glsl") ;
}

void background_shader_draw(int which_one) {
  if(FULL_RENDERING) {
    Vec2 pos_shader = Vec2();
    Vec3 size_shader = Vec3(width,height,height) ; 
    fill(0); 
    noStroke();

    if(which_one == 1) rectangle(pos_shader, size_shader, cellular);
    else if(which_one == 2) rectangle(pos_shader, size_shader, heart);
    else if(which_one == 3) rectangle(pos_shader, size_shader, necklace);
    else if(which_one == 4) rectangle(pos_shader, size_shader, neon);
    else if(which_one == 5) rectangle(pos_shader, size_shader, psy);
    else if(which_one == 6) rectangle(pos_shader, size_shader, snow);

  } else if (which_one != 0  ) {
    background_norm(1) ;
    int sizeText = 14 ;
    textSize(sizeText) ;
    fill(orange) ; 
    noStroke() ;
    text("Shader is ON", sizeText, height/3) ;
  } 
}

float shaderMouseX, shaderMouseY ;
void rectangle(Vec2 pos, Vec3 size, PShader s) {
  // weird algorithm to have a nice display
  int ratio = 10;
  Vec3 temp_size = mult(size, ratio);
  pushMatrix() ;
  translate(mult(temp_size,-.5));
  shader(s);

  Vec4 RGBbackground = HSB_to_RGB( map(value_slider_background[0],0,MAX_VALUE_SLIDER,0,g.colorModeX), 
                                map(value_slider_background[1],0,MAX_VALUE_SLIDER,0,g.colorModeY), 
                                map(value_slider_background[2],0,MAX_VALUE_SLIDER,0,g.colorModeZ),
                                map(value_slider_background[3],0,MAX_VALUE_SLIDER,0,g.colorModeA)  ) ;
  float r = map(RGBbackground.x,0,255,0,1);
  float g = map(RGBbackground.y,0,255,0,1);
  float b = map(RGBbackground.z,0,255,0,1);
  float a = map(RGBbackground.w,0,255,0,1);
  float f_time = (float)frameCount *.1;
  // quantity
  float quantity = map(value_slider_background[4],0,MAX_VALUE_SLIDER,0,1);
  // variety
  float var = map(value_slider_background[5],0,MAX_VALUE_SLIDER,0,1);
  var *= var;
  // size / canvas
  float size_slider_x = map(value_slider_background[6],0,MAX_VALUE_SLIDER,0,1);
  float size_slider_y = map(value_slider_background[7],0,MAX_VALUE_SLIDER,0,1);
  // speed
  float speed_x = map(value_slider_background[8],0,MAX_VALUE_SLIDER,0,1);
  speed_x *= speed_x;
  float speed_y = map(value_slider_background[9],0,MAX_VALUE_SLIDER,0,1);
  speed_y *= speed_y;
  float speed_z = map(value_slider_background[10],0,MAX_VALUE_SLIDER,0,1);
  speed_z *= speed_z;
  // direction
  float dir_x = map(value_slider_background[11],0,MAX_VALUE_SLIDER,-PI,PI);
  float dir_y = map(value_slider_background[12],0,MAX_VALUE_SLIDER,-PI,PI);
  float dir_z = map(value_slider_background[13],0,MAX_VALUE_SLIDER,-PI,PI);

  if(key_space_long) {
    shaderMouseX = map(mouse[0].x,0,width,0,1) ;
    shaderMouseY = map(mouse[0].y,0,height,0,1) ;
  }
  
  s.set("rgba",r,g,b,a); 
  s.set("mixSound", mix[0]) ;
  s.set("timeTrack", get_time_track()) ;
  s.set("tempo", tempo[0]) ;
  s.set("beat", all_transient(0));
  s.set("quantity", quantity);
  s.set("variety", var);
  s.set("mouse",shaderMouseX, shaderMouseY);
  s.set("resolution",size.x,size.y);
  s.set("direction",dir_x,dir_y,dir_z);
  s.set("time", f_time);
  s.set("speed", speed_x,speed_y,speed_z);
  s.set("size", size_slider_x,size_slider_y);
  
  beginShape(QUADS) ;
  vertex(pos.x,pos.y) ;
  vertex(pos.x +temp_size.x,pos.y) ;
  vertex(pos.x +temp_size.x,pos.y +temp_size.y) ;
  vertex(pos.x,pos.y +temp_size.y) ;
  endShape() ;
  resetShader() ;
  popMatrix() ;
}










/**
curtain
*/
void curtain() {
  if(!curtain_button_is()) {
    rectMode(CORNER) ;
    fill (0) ; 
    noStroke() ;
    rect(-1,-1, width+2, height+2);
  }
}
