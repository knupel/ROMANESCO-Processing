// Tab: Z_LIGHT and SHADER
// version 1.3.2 //////////
//////////////////////////
// LIGHT POSITION
PVector var_light_pos  ;
PVector var_light_dir  ;
/**
In this time we just use the var_light_pos with the pos light, may be in the future it's possible to use the couple
*/
void light_position_setup() {
  var_light_pos = new PVector(width/2, height/2, -width *2) ;
  var_light_dir = new PVector(width/2, height/2, width *2) ;
}

void light_position_draw(PVector mouse, int wheel) {
  if(lLongTouch && !shiftLongTouch ) {
    var_light_pos.x = mouse.x ;
    var_light_pos.y = mouse.y ;
    var_light_pos.z += wheel ;
  }
  if(lLongTouch && shiftLongTouch) {
    var_light_dir.x = mouse.x ;
    var_light_dir.y = mouse.y ;
    var_light_dir.z += wheel ;
  }
}


// INTERNAL VAR
PShader pixShader;
// PVector speedColorLight = new PVector() ;

Vec4 [] color_light ;
Vec4 [] color_light_ref ;
Vec3 [] color_setting ;

Vec3 [] dir_light ;
Vec3 [] dir_light_ref ;

Vec3 [] pos_light ;
Vec3 [] pos_light_ref ;

boolean [] on_off_light, on_off_light_action ;






void shader_setup() {
  String path = (preferencesPath +"shader/shader_light/") ;
  pixShader = loadShader(path+"light_pix_frag_romanesco.glsl", path+"light_pix_vert_romanesco.glsl");
  shader(pixShader);
}
// END SETUP
////////////













void light_setup() {
  /*
  float min =.001 ;
  float max = 0.3 ;
  speedColorLight = new PVector(random(min,max),random(min,max),random(min,max)) ;
  */
  int num_light = 3 ;
  color_light = new Vec4[num_light] ;
  color_light_ref = new Vec4[num_light] ;
  color_setting = new Vec3[num_light] ;
  dir_light = new Vec3[num_light] ;
  dir_light_ref = new Vec3[num_light] ;
  pos_light = new Vec3[num_light] ;
  pos_light_ref = new Vec3[num_light] ;
  on_off_light = new boolean[num_light] ;
  on_off_light_action  = new boolean[num_light] ;
  

  for (int i = 0 ; i < num_light ; i++ ) {
    color_light[i] = Vec4(0,100,100,100); 
    color_light_ref[i] = Vec4() ;
    dir_light[i] = Vec3(0,0,-1); 
    dir_light_ref[i] = dir_light[i].copy();
    pos_light[i] = Vec3(width/2,height/2, width *2); 
    pos_light_ref[i] = Vec3() ;
  }
}


// END SETUP
////////////




//DRAW
void light_call_shader() {
  shader(pixShader);
}



void light_update_position_direction() {
  // update value from the controller
   // shader_value_dev() ; // method to test valmue without controller etc.
  shader_value_romanesco(valueSlider, onOffLightAmbient, onOffDirLightOne, onOffDirLightTwo, onOffDirLightOneAction, onOffDirLightTwoAction) ;
    // DIRECTIONAL and  SPOT LIGHT UPDATE
  // Vec6 range_input_direction_3D = new Vec6(-1,1,   -1,1,  -1,1) ;
  Vec6 range_input_direction_3D = new Vec6(0,width,   0,height,  -width, width) ;
  
  Vec6 range_input_position_3D = new Vec6(0,width,   0,height,  -width, width) ;
  Vec6 range_output_position_3D = new Vec6(0,width,   0,height,  -width, width) ;


    // Position and direction of the directional light
  if(onOffDirLightOneAction) {
    dir_light[1] = light_direction(var_light_dir, range_input_direction_3D, on_off_light_action[1], dir_light[1],  dir_light_ref[1]).copy() ;
    pos_light[1] = light_position(var_light_pos, range_input_position_3D, range_output_position_3D, on_off_light_action[1], pos_light[1],  pos_light_ref[1]).copy() ;
    color_light[1] = light_color(color_setting [1], MAX_VALUE_SLIDER, HSBmode, color_light[1], color_light_ref[1]).copy() ;
  }
  if(onOffDirLightTwoAction) {
    dir_light[2] = light_direction(var_light_dir, range_input_direction_3D, on_off_light_action[2], dir_light[2],  dir_light_ref[2]).copy() ;
    PVector reverse_var_pos = new PVector(map(var_light_pos.x,0,width,width,0), map(var_light_pos.y,0,height,height,0),var_light_pos.z) ;
    pos_light[2] = light_position(reverse_var_pos, range_input_position_3D, range_output_position_3D, on_off_light_action[2], pos_light[2],  pos_light_ref[2]).copy() ;
    color_light[2] = light_color(color_setting [2], MAX_VALUE_SLIDER, HSBmode, color_light[2], color_light_ref[2]).copy() ;
  }
}


void light_display() {

  // spotLightPixList() ;
  
  // ambient light
  if(on_off_light[0]){ 
    Vec4 newRef = Vec4(map(color_setting [0].r,0,MAX_VALUE_SLIDER,0,HSBmode.r), map(color_setting [0].g,0,MAX_VALUE_SLIDER,0,HSBmode.g), map(color_setting [0].b,0,MAX_VALUE_SLIDER,0,HSBmode.b),HSBmode.a) ;
    if(!compare(newRef, color_light_ref[0])) color_light[0] = newRef.copy() ;
    color_light_ref[0] = newRef.copy() ;
    ambientLightPix(color_light[0]) ;
  }
  // Spot light one
 
  float angle = TAU /2 ;
  float concentration = 10 ;
  // Vec6 range_input_direction_3D = new Vec6(0,width,   0,height,  -width, width) ;





  // display light
  if(on_off_light[1]) {
    light_spot_display(color_light[1], pos_light[1], dir_light[1], angle, concentration) ;
  }
  if(on_off_light[2]) {
    light_spot_display(color_light[2], pos_light[2], dir_light[2], angle, concentration) ;
  }
}



void shader_draw() {
  // Color value fro the global vertex
  Vec4 RGBa = new Vec4(1, 1, 1, .5) ; // it's OPENGL data between 0 to 1, the range is between -1 to 1, you can go beyond but take care at your life !
  PVector RGB = new PVector(RGBa.r, RGBa.g, RGBa.b);

  pixShader.set("colorVertex", RGB);
  pixShader.set("alphaVertex", RGBa.a);
  // pixlightShader.set("contrast", 1.);
  
  // vertex position
  //////////////////
  // float canvasZ = cos(frameCount *.01) ;
  PVector canvasXYZ = new PVector (1,1,1) ;
  pixShader.set("canvas", canvasXYZ);
  pixShader.set("zoom", 1.);
}
// END DRAW
///////////



















// ANNEXE
//////////

//DIRECTIONAL LIGHT
///////////////////




/**
open a list of lights with a max of height lights
@param Vec4 [] colour RGBa float component value 0-255
@param Vec4 [] dir xyz float component value -1 to 1
*/

// Display light
/**
Here we use a direction of light
*/
void light_directional_display(Vec4 rgba, Vec3 dir) {
  rgba = check_colorMode_for_alpha(rgba).copy() ;
  directionalLight(rgba.r, rgba.g, rgba.b, dir.x, dir.y, dir.z);
}
// END DIRECTIONAL LIGHT
////////////////////////







// AMBIENT LIGHT
/////////////////
void ambientLightPix(Vec4 rgba) {
  rgba = check_colorMode_for_alpha(rgba).copy() ;
  ambientLight(rgba.r, rgba.g, rgba.b);
}

void ambientLightPix(Vec4 rgba, Vec3 pos) {
  rgba = check_colorMode_for_alpha(rgba).copy() ;
  ambientLight(rgba.r, rgba.g, rgba.b, pos.x, pos.y, pos.z);
}
// END AMBIENT LIGHT
////////////////////








// POINT LIGTH
//////////////


// Display light
/**
Here we use a position of light
*/
void light_point_display(Vec4 rgba, Vec3 pos) {
  rgba = check_colorMode_for_alpha(rgba).copy() ;
  pointLight(rgba.r, rgba.g, rgba.b, pos.x, pos.y, pos.z);
}
// END POINT LIGHT
/////////////////




//SPOT LIGHT
/////////////
void light_spot_display(Vec4 rgba, Vec3 pos, Vec3 dir, float angle, float concentration) {
  rgba = check_colorMode_for_alpha(rgba).copy() ;
  spotLight(rgba.r, rgba.g, rgba.b, pos.x, pos.y, pos.z, dir.x, dir.y, dir.z, angle, concentration) ;
}
// END SHADER PIX LIGTH
//////////////////////

// END LIGHT
////////////








// GLOBAL SHADER
////////////////

// COMMON LIGHT METHODE
//////////////////////
// update color
Vec4 light_color(Vec3 value, int max, Vec4 color_univers, Vec4 color_light, Vec4 color_light_ref) {
  Vec4 newRefColor = Vec4(map(value.x, 0, max, 0, color_univers.x), map(value.y,0, max, 0, color_univers.y), map(value.z, 0, max, 0, color_univers.z),color_univers.w) ;
  if(!compare(newRefColor, color_light_ref)) color_light = newRefColor.copy() ;
  return newRefColor ;
}

// update direction
Vec3 light_direction(PVector var, Vec6 range3D, boolean authorization, Vec3 dir, Vec3 dir_ref) {
  if(authorization) {
    
    Vec3 newRefDir = Vec3(map(var.x,range3D.a,range3D.b, -1,1),map(var.y,range3D.c,range3D.d, -1,1),map(var.z,range3D.e,range3D.f, -1,1)) ;
    if(!compare(newRefDir, dir_ref)) dir = newRefDir.copy() ;
    dir_ref = newRefDir.copy() ; 
  }
  return dir_ref  ;
}


// update position
Vec3 light_position(PVector var, Vec6 range3D, Vec6 range3D_target,boolean authorization, Vec3 pos, Vec3 pos_ref) {
  if(authorization) {
    Vec3 newRefPos = Vec3(map(var.x,range3D.a,range3D.b, range3D_target.a,range3D_target.b),map(var.y,range3D.c,range3D.d, range3D_target.c,range3D_target.d),map(var.z,range3D.e,range3D.f, range3D_target.e,range3D_target.f)) ;
    if(!compare(newRefPos, pos_ref)) pos = newRefPos.copy() ;
    pos_ref = newRefPos.copy() ; 
  }
  return pos_ref  ;
}

/**
check the color mode of your skecth, if this one is on RGB, you must apply the alpha on RGB component, else in HSB you must apply only on SB components 
*/
Vec4 check_colorMode_for_alpha(Vec4 rgba) {
  float alphaNormal = map(rgba.a,0,g.colorModeA,0,1) ;

  if(g.colorMode == 1 ) {
    rgba.r *= alphaNormal ;
    rgba.g *= alphaNormal ;
    rgba.b *= alphaNormal; 
  } else {
    rgba.g *= alphaNormal ; 
    rgba.b *= alphaNormal  ;
  }
  return rgba ;
}



// METHODE to manage external var
/////////////////////////////////
void shader_value_romanesco(float [][]value, boolean onOffLightAmbient,  boolean onOffDirLightOne, boolean onOffDirLightTwo, boolean onOffDirLightOneAction, boolean onOffDirLightTwoAction) {
  color_setting [0] = Vec3(value[0][12],value[0][13],value[0][14]) ;
  color_setting [1] = Vec3(value[0][6],value[0][7],value[0][8]) ;
  color_setting [2] = Vec3(value[0][9],value[0][10],value[0][11]) ;

  on_off_light[0] = onOffLightAmbient ;
  on_off_light[1] = onOffDirLightOne ;
  on_off_light[2] = onOffDirLightTwo ;
  // on_off_light_action[0] = true ;
  on_off_light_action[1] = onOffDirLightOneAction ;
  on_off_light_action[2] = onOffDirLightTwoAction ;

//  var_light_dir = new PVector(0,0,1) ;
}

// VARIABLE TO TEST METHODE without Romanesco
void shader_value_dev() {
    // color_setting [0] = Vec3(abs(cos(frameCount*.001)) *360,abs(cos(frameCount*.01) *360),abs(sin(frameCount*.1) *360))
  // float hue = abs(cos(frameCount*.001)) *360 ;
  //float saturation = map(mouseX, 0, width, 0,360) ;
  // float brightness = map(mouseY, 0, height, 0,360) ;
  float hue = sin(frameCount *.005) *360 ;
  float saturation = 360 ;
  float brightness = sin(frameCount *.002) *360 ;

  color_setting [0] = Vec3(hue,saturation,brightness); // (360,360,360) not (360,100,100) it's a reason why we must map the value
  color_setting [1] = Vec3(280,360,360) ;
  color_setting [2] = Vec3(0,360,360) ;
  
  var_light_pos = new PVector(mouseX,mouseY,200)  ; 
  var_light_dir = new PVector(0,0,1) ;
   // var_light_pos = new PVector(mouseX,mouseY,sin(frameCount *.1) *500)  ;
  
 //  var_light_dir = new PVector(mouseX,mouseY,sin(frameCount *.1) *500)  ;


  // on_off_light[0] = true ;
  on_off_light[1] = true ;
  on_off_light[2] = true ;
  on_off_light_action[0] = true ;
  on_off_light_action[1] = true ;
  on_off_light_action[2] = true ;
}