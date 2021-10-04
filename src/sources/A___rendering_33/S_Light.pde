/**
* LIGHT SHADER 
* 1.4.4
* 2015-2019
*/
vec3 var_light_pos  ;
vec3 var_light_dir  ;
/**
In this time we just use the var_light_pos with the pos light, may be in the future it's possible to use the couple
*/
void light_position_setup() {
  var_light_pos = vec3(width/2, height/2, -width *2) ;
  var_light_dir = vec3(width/2, height/2, width *2) ;
}

void light_position_draw(vec3 mouse, int wheel) {
  if(l_long_is() && !shift_long_is()) {
    var_light_pos.x = mouse.x ;
    var_light_pos.y = mouse.y ;
    var_light_pos.z += wheel ;
  }
  if(l_long_is() && shift_long_is()) {
    var_light_dir.x = mouse.x ;
    var_light_dir.y = mouse.y ;
    var_light_dir.z += wheel ;
  }
}


// INTERNAL VAR
PShader light_shader;

vec4 [] color_light ;
vec4 [] color_light_ref ;
vec3 [] color_setting ;

vec3 [] dir_light ;
vec3 [] dir_light_ref ;

vec3 [] pos_light ;
vec3 [] pos_light_ref ;

boolean [] on_off_light, on_off_light_action ;


void shader_setup() {
  String path = ("shader/fx_light/") ;
  light_shader = loadShader(path+"light_pix_frag_romanesco.glsl", path+"light_pix_vert_romanesco.glsl");
  shader(light_shader);
}

void light_setup() {
  int num_light = 3 ;
  color_light = new vec4[num_light] ;
  color_light_ref = new vec4[num_light] ;
  color_setting = new vec3[num_light] ;
  dir_light = new vec3[num_light] ;
  dir_light_ref = new vec3[num_light] ;
  pos_light = new vec3[num_light] ;
  pos_light_ref = new vec3[num_light] ;
  on_off_light = new boolean[num_light] ;
  on_off_light_action  = new boolean[num_light] ;

  for (int i = 0 ; i < num_light ; i++ ) {
    color_light[i] = vec4(0,100,100,100); 
    color_light_ref[i] = vec4() ;
    dir_light[i] = vec3(0,0,-1); 
    dir_light_ref[i] = dir_light[i].copy();
    pos_light[i] = vec3(width/2,height/2, width *2); 
    pos_light_ref[i] = vec3() ;
  }
}


















//DRAW
void light_call_shader() {
  shader(light_shader);
}



void light_update_position_direction() {
  light_value_romanesco(value_slider_light, ambient_button_is(), light_1_button_is(), light_2_button_is(), light_1_action_button_is(), light_2_action_button_is()) ;
  // DIRECTIONAL and  SPOT LIGHT UPDATE
  vec6 range_input_direction_3D = new vec6(0,width,   0,height,  -width, width) ;
  vec6 range_input_position_3D = new vec6(0,width,   0,height,  -width, width) ;
  vec6 range_output_position_3D = new vec6(0,width,   0,height,  -width, width) ;

  // Position and direction of the directional light
  if(light_1_action_button_is()) {
    dir_light[1] = light_direction(var_light_dir, range_input_direction_3D, on_off_light_action[1], dir_light[1],  dir_light_ref[1]).copy() ;
    pos_light[1] = light_position(var_light_pos, range_input_position_3D, range_output_position_3D, on_off_light_action[1], pos_light[1],  pos_light_ref[1]).copy() ;
    color_light[1] = light_color(color_setting [1], MAX_VALUE_SLIDER, HSBmode, color_light[1], color_light_ref[1]).copy() ;
  }
  if(light_2_action_button_is()) {
    dir_light[2] = light_direction(var_light_dir, range_input_direction_3D, on_off_light_action[2], dir_light[2],  dir_light_ref[2]).copy() ;
    vec3 reverse_var_pos = vec3(map(var_light_pos.x,0,width,width,0), map(var_light_pos.y,0,height,height,0),var_light_pos.z) ;
    pos_light[2] = light_position(reverse_var_pos, range_input_position_3D, range_output_position_3D, on_off_light_action[2], pos_light[2],  pos_light_ref[2]).copy() ;
    color_light[2] = light_color(color_setting [2], MAX_VALUE_SLIDER, HSBmode, color_light[2], color_light_ref[2]).copy() ;
  }
}


void light_display() {
  // ambient light
  if(on_off_light[0]){ 
    vec4 newRef = vec4( map(color_setting [0].hue(),0,MAX_VALUE_SLIDER,0,HSBmode.hue()), 
                        map(color_setting[0].sat(),0,MAX_VALUE_SLIDER,0,HSBmode.sat()), 
                        map(color_setting [0].bri(),0,MAX_VALUE_SLIDER,0,HSBmode.bri()),
                        HSBmode.alp()) ;
    if(!compare(newRef, color_light_ref[0])) color_light[0] = newRef.copy() ;
    color_light_ref[0] = newRef.copy() ;
    ambientLightPix(color_light[0]) ;
  }
  // Spot light one
 
  float angle = TAU /2 ;
  float concentration = 10 ;
  // vec6 range_input_direction_3D = new vec6(0,width,   0,height,  -width, width) ;

  // display light
  if(on_off_light[1]) {
    light_spot_display(color_light[1], pos_light[1], dir_light[1], angle, concentration);
  }
  if(on_off_light[2]) {
    light_spot_display(color_light[2], pos_light[2], dir_light[2], angle, concentration);
  }
}



void shader_draw() {
  // Color value fro the global vertex
  vec4 rgba = new vec4(1,1,1,.5) ; // it's OPENGL data between 0 to 1, the range is between -1 to 1, you can go beyond but take care at your life !

  light_shader.set("colorVertex",rgba.red(),rgba.gre(),rgba.blu());
  light_shader.set("alphaVertex",rgba.alp());
  
  // vertex position
  vec3 canvas = vec3(1,1,1) ;
  light_shader.set("canvas",canvas.x,canvas.y,canvas.z);
  light_shader.set("zoom", 1.);
}



















/**
DIRECTIONAL LIGHT
*/
/**
open a list of lights with a max of height lights
@param vec4 [] colour RGBa float component value 0-255
@param vec4 [] dir xyz float component value -1 to 1
*/

// Display light
/**
Here we use a direction of light
*/
void light_directional_display(vec4 rgba, vec3 dir) {
  rgba = check_colorMode_for_alpha(rgba).copy();
  directionalLight(rgba.red(),rgba.gre(),rgba.blu(),dir.x,dir.y,dir.z);
}
// END DIRECTIONAL LIGHT







// AMBIENT LIGHT
void ambientLightPix(vec4 rgba) {
  rgba = check_colorMode_for_alpha(rgba).copy();
  ambientLight(rgba.red(),rgba.gre(),rgba.blu());
}

void ambientLightPix(vec4 rgba, vec3 pos) {
  rgba = check_colorMode_for_alpha(rgba).copy();
  ambientLight(rgba.red(),rgba.gre(),rgba.blu(),pos.x,pos.y,pos.z);
}









// POINT LIGTH
//////////////
/**
Here we use a position of light
*/
void light_point_display(vec4 rgba, vec3 pos) {
  rgba = check_colorMode_for_alpha(rgba).copy();
  pointLight(rgba.red(),rgba.gre(),rgba.blu(), pos.x,pos.y,pos.z);
}


/**
SPOT LIGHT
*/
void light_spot_display(vec4 rgba, vec3 pos, vec3 dir, float angle, float concentration) {
  rgba = check_colorMode_for_alpha(rgba).copy() ;
  spotLight(rgba.red(),rgba.gre(),rgba.blu(), pos.x,pos.y,pos.z, dir.x,dir.y,dir.z, angle, concentration) ;
}




/**
GLOBAL SHADER
*/
// update color
vec4 light_color(vec3 value, int max, vec4 color_univers, vec4 color_light, vec4 color_light_ref) {
  vec4 newRefColor = vec4(map(value.x, 0, max, 0, color_univers.x), map(value.y,0, max, 0, color_univers.y), map(value.z, 0, max, 0, color_univers.z),color_univers.w) ;
  if(!compare(newRefColor, color_light_ref)) color_light = newRefColor.copy() ;
  return newRefColor ;
}

// update direction
vec3 light_direction(vec3 val, vec6 range3D, boolean authorization, vec3 dir, vec3 dir_ref) {
  if(authorization) {
    
    vec3 newRefDir = vec3(map(val.x,range3D.a(),range3D.b(), -1,1),
                          map(val.y,range3D.c(),range3D.d(), -1,1),
                          map(val.z,range3D.e(),range3D.f(), -1,1)) ;
    if(!compare(newRefDir, dir_ref)) dir = newRefDir.copy() ;
    dir_ref = newRefDir.copy() ; 
  }
  return dir_ref  ;
}


// update position
vec3 light_position(vec3 val, vec6 range3D, vec6 range3D_target,boolean authorization, vec3 pos, vec3 pos_ref) {
  if(authorization) {
    vec3 newRefPos = vec3(map(val.x,range3D.a(),range3D.b(), range3D_target.a(),range3D_target.b()),
                          map(val.y,range3D.c(),range3D.d(), range3D_target.c(),range3D_target.d()),
                          map(val.z,range3D.e(),range3D.f(), range3D_target.e(),range3D_target.f())) ;
    if(!compare(newRefPos, pos_ref)) pos = newRefPos.copy() ;
    pos_ref = newRefPos.copy() ; 
  }
  return pos_ref  ;
}

/**
check the color mode of your skecth, if this one is on RGB, you must apply the alpha on RGB component, else in HSB you must apply only on SB components 
*/
vec4 check_colorMode_for_alpha(vec4 rgba) {
  float alpha_norm = map(rgba.alp(),0,g.colorModeA,0,1);

  if(g.colorMode == 1) {
    // rgba.x *= alpha_norm;
    // rgba.y *= alpha_norm;
    // rgba.z *= alpha_norm; 

    // rgba.r *= alphaNormal; // before earthquake ROPE 0.3.0
    // rgba.g *= alphaNormal; // before earthquake ROPE 0.3.0
    // rgba.b *= alphaNormal; // before earthquake ROPE 0.3.0
    rgba.red(rgba.x *alpha_norm);
    rgba.gre(rgba.y *alpha_norm);
    rgba.blu(rgba.z *alpha_norm);
  } else {
    rgba.sat(rgba.y *alpha_norm);
    rgba.bri(rgba.z *alpha_norm);
    // rgba.y *= alpha_norm; 
    // rgba.z *= alpha_norm;

    // rgba.g *= alphaNormal; // before earthquake ROPE 0.3.0
    // rgba.b *= alphaNormal; // before earthquake ROPE 0.3.0
  }
  return rgba ;
}



void light_value_romanesco(float [] value, boolean onOffLightAmbient,  boolean onOffDirLightOne, boolean onOffDirLightTwo, boolean onOffDirLightOneAction, boolean onOffDirLightTwoAction) {
  color_setting [0] = vec3(value[0],value[1],value[2]);
  color_setting [1] = vec3(value[3],value[4],value[5]);
  color_setting [2] = vec3(value[6],value[7],value[8]);

  on_off_light[0] = onOffLightAmbient ;
  on_off_light[1] = onOffDirLightOne ;
  on_off_light[2] = onOffDirLightTwo ;
  // on_off_light_action[0] = true ;
  on_off_light_action[1] = onOffDirLightOneAction ;
  on_off_light_action[2] = onOffDirLightTwoAction ;
}

/**

MEthod to test without Romanesco system
This method is not use in the software

*/
void light_value_dev() {
    // color_setting [0] = vec3(abs(cos(frameCount*.001)) *360,abs(cos(frameCount*.01) *360),abs(sin(frameCount*.1) *360))
  // float hue = abs(cos(frameCount*.001)) *360 ;
  //float saturation = map(mouseX, 0, width, 0,360) ;
  // float brightness = map(mouseY, 0, height, 0,360) ;
  float hue = sin(frameCount *.005) *360 ;
  float saturation = 360 ;
  float brightness = sin(frameCount *.002) *360 ;

  color_setting [0] = vec3(hue,saturation,brightness); // (360,360,360) not (360,100,100) it's a reason why we must map the value
  color_setting [1] = vec3(280,360,360) ;
  color_setting [2] = vec3(0,360,360) ;
  
  var_light_pos = vec3(mouseX,mouseY,200)  ; 
  var_light_dir = vec3(0,0,1) ;
   // var_light_pos = new PVector(mouseX,mouseY,sin(frameCount *.1) *500)  ;
  
 //  var_light_dir = new PVector(mouseX,mouseY,sin(frameCount *.1) *500)  ;
  // on_off_light[0] = true ;
  on_off_light[1] = true ;
  on_off_light[2] = true ;
  on_off_light_action[0] = true ;
  on_off_light_action[1] = true ;
  on_off_light_action[2] = true ;
}
