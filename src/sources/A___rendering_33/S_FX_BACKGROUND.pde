/**
* FX BACKGROUND
* v 1.2.1
* 2015-2019
*/
void init_fx_background() {

}


void fx_background() {

}


void select_fx_background_rope(int which_shader) {

}

/*
float fx_cx;
float fx_cy;
float fx_cz;
float fx_px;
float fx_py;
float fx_sx;
float fx_sy;
float fx_str_x;
float fx_str_y;
float fx_quantity;
float fx_quality;
float fx_speed;
float fx_angle;
float fx_threshold;
void update_fx_background_slider() {
  fx_cx = map(value_slider_fx[0],0,MAX_VALUE_SLIDER,0,1);
  fx_cy = map(value_slider_fx[1],0,MAX_VALUE_SLIDER,0,1);
  fx_cz = map(value_slider_fx[2],0,MAX_VALUE_SLIDER,0,1);

  fx_px = map(value_slider_fx[3],0,MAX_VALUE_SLIDER,0,1);
  fx_py = map(value_slider_fx[4],0,MAX_VALUE_SLIDER,0,1);

  fx_sx = map(value_slider_fx[5],0,MAX_VALUE_SLIDER,0,1);
  fx_sy = map(value_slider_fx[6],0,MAX_VALUE_SLIDER,0,1);

  fx_str_x = map(value_slider_fx[7],0,MAX_VALUE_SLIDER,0,1);
  fx_str_y = map(value_slider_fx[8],0,MAX_VALUE_SLIDER,0,1);

  fx_quantity = map(value_slider_fx[9],0,MAX_VALUE_SLIDER,0,1);

  fx_quality = map(value_slider_fx[10],0,MAX_VALUE_SLIDER,0,1);

  fx_speed = map(value_slider_fx[11],0,MAX_VALUE_SLIDER,0,1);

  fx_angle = map(value_slider_fx[12],0,MAX_VALUE_SLIDER,0,1);

  fx_threshold = map(value_slider_fx[13],0,MAX_VALUE_SLIDER,0,1);
}
*/






















/**
* BACKGROUND SHADER
* v 0.4.0
* 2013-2019
*/
ArrayList<FX> fx_background_manager;


void background_shader_setup() {
  if(FULL_RENDERING) {
    fx_background_manager = new ArrayList<FX>();
    String path = preference_path +"shader/fx_bg/";
    setting_fx_background(fx_background_manager,path);
    write_fx_backgound_index(fx_background_manager);
    
  }
}

/*
void select_fx_background(int which_one) {
  if(FULL_RENDERING) {
    vec2 pos_shader = vec2();
    vec3 size_shader = vec3(width,height,height) ; 
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
*/




int fx_background_num;
void setting_fx_background(ArrayList<FX> fx_list, String path) {
  setting_fx_bg_classic(fx_list,path);
  setting_fx_bg_cellular(fx_list,path);
  setting_fx_bg_heart(fx_list,path);
  setting_fx_bg_necklace(fx_list,path);
  setting_fx_bg_neon(fx_list,path);
  setting_fx_bg_psy(fx_list,path);
  setting_fx_bg_snow(fx_list,path);
}

String fx_bg_classic = "Classic";
void setting_fx_bg_classic(ArrayList<FX> fx_list, String path) {
  // no shader to download at this time !!!
  String version = "0.0.1";
  int revision = 1;
  String author = "Stan le Punk";
  String pack = "Base 2013-2019";
  String [] slider = {"hue","saturation","brightness","refresh"};
  int id = fx_background_num;
  init_fx(fx_list,fx_bg_classic,NO_FX,id,author,pack,version,revision,slider,null);
  fx_background_num++;
}




String setting_fx_bg_cellular = "Cellular";
void setting_fx_bg_cellular(ArrayList<FX> fx_list, String path) {
  String version = "0.0.1";
  int revision = 1;
  String author = "Josh P";
  String pack = "Base 2016-2019";
  String [] slider = {"hue","saturation","brightness","refresh","quality","quantity","speed"};
  int id = fx_background_num;
  init_fx(fx_list,setting_fx_bg_cellular,FX_BG_CELLULAR,id,author,pack,version,revision,slider,null);
  fx_background_num++;
}



String setting_fx_bg_heart = "Heart";
void setting_fx_bg_heart(ArrayList<FX> fx_list, String path) {
  String version = "0.0.1";
  int revision = 1;
  String author = "Josh P";
  String pack = "Base 2016-2019";
  String [] slider = {"hue","saturation","brightness","refresh"};
  int id = fx_background_num;
  init_fx(fx_list,setting_fx_bg_heart,FX_BG_HEART,id,author,pack,version,revision,slider,null);
  fx_background_num++;
}



String setting_fx_bg_necklace = "Necklace";
void setting_fx_bg_necklace(ArrayList<FX> fx_list, String path) {
  String version = "0.0.1";
  int revision = 1;
  String author = "Sandbox";
  String pack = "Base 2016-2019";
  String [] slider = {"refresh","quantity","size X","size Y"};
  int id = fx_background_num;
  init_fx(fx_list,setting_fx_bg_necklace,FX_BG_NECKLACE,id,author,pack,version,revision,slider,null);
  fx_background_num++;
}


String setting_fx_bg_neon = "Neon";
void setting_fx_bg_neon(ArrayList<FX> fx_list, String path) {
  String version = "0.0.1";
  int revision = 1;
  String author = "Sandbox";
  String pack = "Base 2016-2019";
  String [] slider = {""};
  int id = fx_background_num;
  init_fx(fx_list,setting_fx_bg_neon,FX_BG_NEON,id,author,pack,version,revision,slider,null);
  fx_background_num++;
}

String setting_fx_bg_psy = "Psy";
void setting_fx_bg_psy(ArrayList<FX> fx_list, String path) {
  String version = "0.0.1";
  int revision = 1;
  String author = "Sandbox";
  String pack = "Base 2016-2019";
  String [] slider = {""};
  int id = fx_background_num;
  init_fx(fx_list,setting_fx_bg_psy,FX_BG_PSY,id,author,pack,version,revision,slider,null);
  fx_background_num++;
}

String setting_fx_bg_snow = "Snow";
void setting_fx_bg_snow(ArrayList<FX> fx_list, String path) {
  String version = "0.0.1";
  int revision = 1;
  String author = "Sandbox";
  String pack = "Base 2016-2019";
  String [] slider = {"hue","saturation","brightness","refresh","speed X"};
  int id = fx_background_num;
  init_fx(fx_list,setting_fx_bg_snow,FX_BG_SNOW,id,author,pack,version,revision,slider,null);
  fx_background_num++;
}










// info to gui
void write_fx_backgound_index(ArrayList<FX> fx_list) {
  Table index_fx_bg = new Table();
  index_fx_bg.addColumn("Name");
  index_fx_bg.addColumn("Author");
  index_fx_bg.addColumn("Version");
  index_fx_bg.addColumn("Pack");
  index_fx_bg.addColumn("Slider");
  

  int num = fx_background_num; // +1 cause of the special force field fx
  TableRow [] info_fx_bg = new TableRow [num];

  for(int i = 0 ; i < info_fx_bg.length ; i++) {
    info_fx_bg[i] = index_fx_bg.addRow();
  }


  for(int i = 0 ; i < fx_background_num ; i++) {
    FX fx = get_fx(fx_list,i); 
    info_fx_bg[i].setString("Name",fx.get_name());
    info_fx_bg[i].setString("Author",fx.get_author());
    info_fx_bg[i].setString("Version",fx.get_version());
    info_fx_bg[i].setString("Pack",fx.get_pack());
    String s = "";
    int max =  fx.get_name_slider().length;
    for(int k = 0 ; k < max ; k++) {
      if(k < max - 1) {
        s += (fx.get_name_slider()[k]+"/");
      } else {
        s += (fx.get_name_slider()[k]);
      }
    }
    info_fx_bg[i].setString("Slider",s);
  }

  saveTable(index_fx_bg, preference_path+"index_fx_bg.csv"); 
}







float shaderMouseX, shaderMouseY ;
void rectangle(vec2 pos, vec3 resolution, PShader s) {
  // weird algorithm to have a nice display
  int ratio = 10;
  vec3 temp_size = mult(resolution, ratio);
  pushMatrix() ;
  translate(mult(temp_size,-.5));
  shader(s);
  vec3 rgb_background = hsb_to_rgb( map(value_slider_background[0],0,MAX_VALUE_SLIDER,0,g.colorModeX), 
                                    map(value_slider_background[1],0,MAX_VALUE_SLIDER,0,g.colorModeY), 
                                    map(value_slider_background[2],0,MAX_VALUE_SLIDER,0,g.colorModeZ));
/*
  vec4 RGBbackground = hsb_to_rgb(map(value_slider_background[0],0,MAX_VALUE_SLIDER,0,g.colorModeX), 
                                map(value_slider_background[1],0,MAX_VALUE_SLIDER,0,g.colorModeY), 
                                map(value_slider_background[2],0,MAX_VALUE_SLIDER,0,g.colorModeZ),
                                map(value_slider_background[3],0,MAX_VALUE_SLIDER,0,g.colorModeA)  ) ;
                                */
  float alpha_background = map(value_slider_background[3],0,MAX_VALUE_SLIDER,0,g.colorModeA);
  float r = map(rgb_background.x,0,255,0,1);
  float g = map(rgb_background.y,0,255,0,1);
  float b = map(rgb_background.z,0,255,0,1);
  float a = map(alpha_background,0,255,0,1);
  float f_time = (float)frameCount *.1;
  // quantity
  float quantity = map(value_slider_background[4],0,MAX_VALUE_SLIDER,0,1);
  // variety
  float quality = map(value_slider_background[5],0,MAX_VALUE_SLIDER,0,1);
  quality *= quality;
  // size / canvas
  float size_x = map(value_slider_background[6],0,MAX_VALUE_SLIDER,0,1);
  float size_y = map(value_slider_background[7],0,MAX_VALUE_SLIDER,0,1);
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
  
  s.set("timeTrack",get_time_track());
  s.set("mixSound",mix[0]) ;
  s.set("tempo",tempo[0]) ;
  s.set("beat",all_transient(0));
  s.set("mouse",shaderMouseX, shaderMouseY);
  s.set("resolution",resolution.x,resolution.y);
    s.set("time", f_time);

  // external param
  s.set("rgba",r,g,b,a); 
  s.set("quantity",quantity);
  s.set("quality",quality);
  s.set("direction",dir_x,dir_y,dir_z);
  s.set("speed",speed_x,speed_y,speed_z);
  s.set("size",size_x,size_y);
  
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
* BACKGROUND
* 2013-2016
* v 1.0.0
*/
vec4 colorBackground, colorBackgroundRef, colorBackgroundPrescene;
void background_setup() {
  colorBackgroundRef = vec4();
  colorBackground = vec4();
  colorBackgroundPrescene = vec4(0,0,20,g.colorModeA) ;
}

void background_romanesco() {
  // in preview mode the background is always on, to remove the trace effect
  if(!FULL_RENDERING) { 
    background_button_is(false) ;
    colorBackground = colorBackgroundPrescene.copy() ;
    background_rope(0,0,get_layer().colorModeZ *.2,get_layer().colorModeA) ;
  } else if(FULL_RENDERING) {
    if(background_button_is()) {
      if(which_shader == 0) {
        // check if the color model is changed after the shader used
        if(get_layer().colorMode != 3 || get_layer().colorModeX != 360 || get_layer().colorModeY != 100 || get_layer().colorModeZ !=100 || get_layer().colorModeA !=100) {
          colorMode(HSB,360,100,100,100);
        }
        // choice the rendering color palette for the classic background
        if(FULL_RENDERING) {
          // check if the slider background are move, if it's true update the color background
          if(!compare(colorBackgroundRef,update_background())) {
            colorBackground.set(update_background()) ;
          } else {
            colorBackgroundRef.set(update_background()) ;
          }
          background_rope(colorBackground) ;
        }
        background_rope(colorBackground) ;
      } else {
        select_fx_background_rope(which_shader);
      }
    }
  }
}

// ANNEXE VOID BACKGROUND
vec4 update_background() {
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
  return vec4(hue_bg,saturation_bg,brigthness_bg,alpha) ;
}




