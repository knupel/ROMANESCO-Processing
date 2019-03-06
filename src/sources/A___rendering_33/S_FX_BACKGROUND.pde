/**
* FX BACKGROUND
* v 1.2.2
* 2019-2019
*/
ArrayList<FX> fx_background_manager;
void init_fx_background() {
  if(FULL_RENDERING) {
    fx_background_manager = new ArrayList<FX>();
    get_fx_bg_path();
    if(fx_bg_path_exist()) {
      println("FX BACKGROUND shader loaded");
    } else {
      printErr("fx background path filter",get_fx_bg_path(),"don't exists");
    }
    setting_fx_background(fx_background_manager);
    write_fx_backgound_index(fx_background_manager);
  }
}


void fx_background(int which_shader) {
  if(FULL_RENDERING) {
    update_fx_background_slider();
    update_fx_background(fx_background_manager);

    for(FX fx : fx_background_manager) {
      if(which_shader == fx.get_id()) {
        select_fx_background(fx);
        break;
      }
    } 
  }
}




vec4 fx_bg_col = vec4();
vec2 fx_bg_pos = vec2();
float fx_bg_size;
float fx_bg_strength;
float fx_bg_num;
float fx_bg_quality; 
vec2 fx_bg_speed = vec2();
float fx_bg_angle;
float fx_bg_threshold;
void update_fx_background_slider() {
  fx_bg_col.x(map(value_slider_background[0],0,MAX_VALUE_SLIDER,0,1));
  fx_bg_col.y(map(value_slider_background[1],0,MAX_VALUE_SLIDER,0,1));
  fx_bg_col.z(map(value_slider_background[2],0,MAX_VALUE_SLIDER,0,1));
  fx_bg_col.w(map(value_slider_background[3],0,MAX_VALUE_SLIDER,0,1));

  fx_bg_pos.x(map(value_slider_background[4],0,MAX_VALUE_SLIDER,0,1));
  fx_bg_pos.y(map(value_slider_background[5],0,MAX_VALUE_SLIDER,0,1));

  fx_bg_size = map(value_slider_background[6],0,MAX_VALUE_SLIDER,0,1);

  fx_bg_strength = map(value_slider_background[7],0,MAX_VALUE_SLIDER,0,1);

  fx_bg_num = map(value_slider_background[8],0,MAX_VALUE_SLIDER,0,1);

  fx_bg_quality = map(value_slider_background[9],0,MAX_VALUE_SLIDER,0,1);
  
  fx_bg_speed.x(map(value_slider_background[10],0,MAX_VALUE_SLIDER,0,1));
  fx_bg_speed.y(map(value_slider_background[11],0,MAX_VALUE_SLIDER,0,1));

  fx_bg_angle = map(value_slider_background[12],0,MAX_VALUE_SLIDER,0,1);

  fx_bg_threshold = map(value_slider_background[13],0,MAX_VALUE_SLIDER,0,1);
}























/**
* BACKGROUND SHADER
* v 0.4.0
* 2013-2019
*/

int fx_background_num;
void setting_fx_background(ArrayList<FX> fx_list) {
  setting_fx_bg_classic(fx_list);
  setting_fx_bg_cellular(fx_list);
  setting_fx_bg_heart(fx_list);
  setting_fx_bg_necklace(fx_list);
  // setting_fx_bg_neon(fx_list);
  setting_fx_bg_psy(fx_list);
  setting_fx_bg_snow(fx_list);
  setting_fx_bg_voronoi_hex(fx_list);
}

void update_fx_background(ArrayList<FX> fx_list) {
  boolean move_fx_bg_is = true;
  update_fx_bg_classic(fx_list,move_fx_bg_is,fx_bg_col);
  update_fx_bg_cellular(fx_list,move_fx_bg_is,fx_bg_col,fx_bg_quality,fx_bg_num,fx_bg_speed);
  update_fx_bg_heart(fx_list,move_fx_bg_is,vec3(fx_bg_col),fx_bg_quality,fx_bg_num,fx_bg_angle,fx_bg_strength,fx_bg_speed.x);  
  update_fx_bg_necklace(fx_list,move_fx_bg_is,fx_bg_pos,fx_bg_col.w,fx_bg_num,fx_bg_size,fx_bg_speed.x);
  // update_fx_bg_neon(fx_list,move_fx_bg_is,fx_bg_pos,fx_bg_speed.x);
  update_fx_bg_psy(fx_list,move_fx_bg_is,fx_bg_num,fx_bg_speed.x);
  update_fx_bg_snow(fx_list,move_fx_bg_is,fx_bg_pos,vec3(fx_bg_col),fx_bg_speed.x,fx_bg_quality);
  update_fx_bg_voronoi_hex(fx_list,move_fx_bg_is,vec3(fx_bg_col),fx_bg_size,fx_bg_speed,fx_bg_strength,fx_bg_threshold);
}



// classic
String setting_fx_bg_classic = "Classic";
void setting_fx_bg_classic(ArrayList<FX> fx_list) {
  // no shader to download at this time !!!
  String version = "0.0.1";
  int revision = 1;
  String author = "Stan le Punk";
  String pack = "Base 2013-2019";
  String [] slider = {"hue","saturation","brightness","refresh"};
  int id = fx_background_num;
  init_fx(fx_list,setting_fx_bg_classic,NO_FX,id,author,pack,version,revision,slider,null);
  fx_background_num++;
}

void update_fx_bg_classic(ArrayList<FX> fx_list, boolean move_is, vec4 colour) {
  if(move_is) {
    fx_set_colour(fx_list,setting_fx_bg_classic,colour.array());
  }
}



// cellular
String setting_fx_bg_cellular = "Cellular";
void setting_fx_bg_cellular(ArrayList<FX> fx_list) {
  String version = "0.0.1";
  int revision = 1;
  String author = "Josh P";
  String pack = "Base 2016-2019";
  String [] slider = {"hue","saturation","brightness","refresh","quality","quantity","speed X","speed Y"};
  int id = fx_background_num;
  init_fx(fx_list,setting_fx_bg_cellular,FX_BG_CELLULAR,id,author,pack,version,revision,slider,null);
  fx_background_num++;
}

void update_fx_bg_cellular(ArrayList<FX> fx_list, boolean move_is, vec4 colour, float quality, float num, vec2 speed) {
  if(move_is) {
    fx_set_colour(fx_list,setting_fx_bg_cellular,colour.array());
    int final_num = (int)map(num*num*num,0,1,0,20);
    fx_set_num(fx_list,setting_fx_bg_cellular,final_num);
    float sx = map(speed.x*speed.x,0,1,0,.2);
    float sy = map(speed.y*speed.y,0,1,0,.2);
    fx_set_speed(fx_list,setting_fx_bg_cellular,sx,sy);
    quality = map(quality,0,1,0,.2);
    fx_set_quality(fx_list,setting_fx_bg_cellular,quality);
  }
}


// heart
String setting_fx_bg_heart = "Heart";
void setting_fx_bg_heart(ArrayList<FX> fx_list) {
  String version = "0.0.1";
  int revision = 1;
  String author = "Josh P";
  String pack = "Base 2016-2019";
  String [] slider = {"hue","saturation","brightness","refresh","quality","quantity","angle","strength","speed X"};
  int id = fx_background_num;
  init_fx(fx_list,setting_fx_bg_heart,FX_BG_HEART,id,author,pack,version,revision,slider,null);
  fx_background_num++;
}

void update_fx_bg_heart(ArrayList<FX> fx_list, boolean move_is, vec3 colour, float quality, float num, float angle, float strength, float speed) {
  if(move_is) {
    fx_set_colour(fx_list,setting_fx_bg_heart,colour.array());
    fx_set_quality(fx_list,setting_fx_bg_heart,quality);
    int final_num = ceil(map(num,0,1,1,10));
    fx_set_num(fx_list,setting_fx_bg_heart,final_num);

    angle = map(angle,0,1,0,TAU);
    fx_set_angle(fx_list,setting_fx_bg_heart,angle);
    strength = map(strength,0,1,1,5);
    fx_set_strength(fx_list,setting_fx_bg_heart,strength);

    fx_set_speed(fx_list,setting_fx_bg_heart,speed*speed*speed);
  }
}


// necklace
String setting_fx_bg_necklace = "Necklace";
void setting_fx_bg_necklace(ArrayList<FX> fx_list) {
  String version = "0.0.1";
  int revision = 1;
  String author = "Sandbox";
  String pack = "Base 2016-2019";
  String [] slider = {"refresh","quantity","size","speed X","position X","position Y"};
  int id = fx_background_num;
  init_fx(fx_list,setting_fx_bg_necklace,FX_BG_NECKLACE,id,author,pack,version,revision,slider,null);
  fx_background_num++;
}

void update_fx_bg_necklace(ArrayList<FX> fx_list, boolean move_is, vec2 pos, float alpha, float num, float size, float speed) {
  if(move_is) {
    fx_set_alpha(fx_list,setting_fx_bg_necklace,alpha);
    float px = map(pos.x,0,1,0,2);
    float py = map(pos.y,0,1,-1,1);
    fx_set_pos(fx_list,setting_fx_bg_necklace,px,py);
    int final_num = ceil(map(num*num,0,1,10,100));
    fx_set_num(fx_list,setting_fx_bg_necklace,final_num);
    fx_set_speed(fx_list,setting_fx_bg_necklace,speed*speed);
    fx_set_size(fx_list,setting_fx_bg_necklace,size);
  }
}





// neon
String setting_fx_bg_neon = "Neon";
void setting_fx_bg_neon(ArrayList<FX> fx_list) {
  String version = "0.0.1";
  int revision = 1;
  String author = "Sandbox";
  String pack = "Base 2016-2019";
  String [] slider = {"position X","position Y","speed X"};
  int id = fx_background_num;
  init_fx(fx_list,setting_fx_bg_neon,FX_BG_NEON,id,author,pack,version,revision,slider,null);
  fx_background_num++;
}


void update_fx_bg_neon(ArrayList<FX> fx_list, boolean move_is, vec2 pos, float speed) {
  if(move_is) {
    fx_set_pos(fx_list,setting_fx_bg_neon,pos.array());
    fx_set_speed(fx_list,setting_fx_bg_neon,speed);
  }
}







// psy
String setting_fx_bg_psy = "Psy";
void setting_fx_bg_psy(ArrayList<FX> fx_list) {
  String version = "0.0.1";
  int revision = 1;
  String author = "Sandbox";
  String pack = "Base 2016-2019";
  String [] slider = {"quantity","speed X"};
  int id = fx_background_num;
  init_fx(fx_list,setting_fx_bg_psy,FX_BG_PSY,id,author,pack,version,revision,slider,null);
  fx_background_num++;
}


void update_fx_bg_psy(ArrayList<FX> fx_list, boolean move_is, float num, float speed) {
  if(move_is) {
    int final_num = num < .5 ? 2 : 3;
    fx_set_num(fx_list,setting_fx_bg_psy,final_num);
    float final_speed = map(speed*speed*speed,0,1,.005,.3);
    fx_set_speed(fx_list,setting_fx_bg_psy,final_speed);
  }
}

















// snow
String setting_fx_bg_snow = "Snow";
void setting_fx_bg_snow(ArrayList<FX> fx_list) {
  String version = "0.0.1";
  int revision = 1;
  String author = "Sandbox";
  String pack = "Base 2016-2019";
  String [] slider = {"hue","saturation","brightness","speed X","quality"};
  int id = fx_background_num;
  init_fx(fx_list,setting_fx_bg_snow,FX_BG_SNOW,id,author,pack,version,revision,slider,null);
  fx_background_num++;
}

void update_fx_bg_snow(ArrayList<FX> fx_list, boolean move_is, vec2 pos, vec3 colour, float speed, float quality) {
  if(move_is) {
    fx_set_pos(fx_list,setting_fx_bg_snow,pos.array());
    fx_set_colour(fx_list,setting_fx_bg_snow,colour.array());
    float final_speed = map(speed*speed*speed,0,1,.01,.7);
    fx_set_speed(fx_list,setting_fx_bg_snow,final_speed);
    quality = map(quality*quality,0,1,0,.85);
    fx_set_quality(fx_list,setting_fx_bg_snow,quality);
  }
}








// voronoi hex
String setting_fx_bg_voronoi_hex = "Voronoi Hex";
void setting_fx_bg_voronoi_hex(ArrayList<FX> fx_list) {
  String version = "0.0.1";
  int revision = 1;
  String author = "MOJO from ISF";
  String pack = "Base 2019-2019";
  String [] slider = {"hue","saturation","brightness","size","speed X","speed Y","threshold","strength"};
  int id = fx_background_num;
  init_fx(fx_list,setting_fx_bg_voronoi_hex,FX_BG_VORONOI_HEX,id,author,pack,version,revision,slider,null);
  fx_background_num++;
}



void update_fx_bg_voronoi_hex(ArrayList<FX> fx_list, boolean move_is, vec3 colour, float size, vec2 speed, float strength, float threshold) {
  if(move_is) {
    fx_set_colour(fx_list,setting_fx_bg_voronoi_hex,colour.array());
    size = map(size*size,0,1,1,11.2);
    fx_set_size(fx_list,setting_fx_bg_voronoi_hex,size);
    speed.pow(2);
    fx_set_speed(fx_list,setting_fx_bg_voronoi_hex,speed.array());
    fx_set_strength(fx_list,setting_fx_bg_voronoi_hex,map(strength,0,1,-0.05,0.05));
    fx_set_threshold(fx_list,setting_fx_bg_voronoi_hex,map(threshold,0,1,.01,.4));
    fx_set_mode(fx_list,setting_fx_bg_voronoi_hex,0);
  }
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







































/** 
* BACKGROUND
* 2013-2016
* v 1.0.0
*/
vec4 colorBackground, colorBackgroundRef, colorBackgroundPrescene;
void init_background() {
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
        fx_background(which_shader); 
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




