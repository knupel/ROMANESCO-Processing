/**
FILTER
* 2018-2019
* v 0.1.1
* here is calling classic FX ROPE + FX FORCE FIELD
*/


void init_filter() {
  if(FULL_RENDERING) {
    // FORCE FIELD FX
    type_field = r.FLUID;
    pattern_field = r.BLANK;
    set_type_force_field(type_field);
    init_force_field();
    // set_different_force_field();
    println("init filter FORCE FIELD");
    // warp force
    init_warp_force();
    println("init filter FORCE WARP FX");


    // FX CLASSIC
    // set path fx shader;
    set_fx_path(preference_path+"shader/fx/");
    get_fx_path();
    if(fx_rope_path_exists) {
      println("FX CLASSIC shader loaded");
    } else {
      printErr("fx path filter",fx_rope_path,"don't exists");
    }

    setting_fx_classic();


    // CLASSIC FX + FORCE FIELD FX
    write_filter_index();
  }
}


boolean move_filter_fx;
boolean extra_filter_fx;
ArrayList<Integer>active_fx;
int fx_classic_num;
void filter() {
  move_filter_fx = fx_button_is(1);
  extra_filter_fx = fx_button_is(2);

  // add fx
  if(extra_filter_fx) {
    if(active_fx == null) active_fx = new ArrayList<Integer>();
    boolean add_fx = true;
    if(active_fx.size() > 0) {  
      for(Integer i : active_fx) {
        if(i == which_fx) {
          add_fx = false;
          break;
        }
      }
    }
    if(add_fx) {
      active_fx.add(which_fx);
    }
  }

  if(active_fx != null) {
    if(reset_fx_button_alert_is()) {
      active_fx.clear();
    }
  }



  if(FULL_RENDERING && fx_button_is(0)) {
    update_fx_classic();

    if(extra_filter_fx && active_fx != null && active_fx.size() > 0) {
      // println("active fx size",active_fx.size());
      for(int i : active_fx) {
        // println(i);
        draw_fx(i);
      }
    } else {
      draw_fx(which_fx);
    }
  } 
}

void draw_fx(int which) {
  // select fx 
  int num_of_special_fx = 1 ;
  
   if(which < num_of_special_fx) {
      warp_force();
   } else {
    int target = which- num_of_special_fx; // min 1 cause the first one is a special one;
    for(int i = 0 ; i < fx_classic_num ; i++) {
      if(target == i) {
        select_fx(g,null,null,get_fx(target));
      }
    }
  }
}


void write_filter_index() {
  Table index_fx = new Table();
  index_fx.addColumn("Name");
  index_fx.addColumn("Author");
  index_fx.addColumn("Version");
  index_fx.addColumn("Pack");
  

  int num = fx_classic_num+1; // +1 cause of the special force field fx
  TableRow [] info_fx = new TableRow [num];

  for(int i = 0 ; i < info_fx.length ; i++) {
    info_fx[i] = index_fx.addRow();
  }

  info_fx[0].setString("Name","Force");
  info_fx[0].setString("Author","Stan le Punk");
  info_fx[0].setString("Version","0.1.0");
  info_fx[0].setString("Pack","Base 2014");


  for(int i = 0 ; i < fx_classic_num ; i++) {
    FX fx = get_fx(i); 
    int target = i+1;
    info_fx[target].setString("Name",fx.get_name());
    info_fx[target].setString("Author",fx.get_author());
    info_fx[target].setString("Version",fx.get_version());
    info_fx[target].setString("Pack",fx.get_pack());
  }


  saveTable(index_fx, preference_path+"index_fx.csv"); 

}














/**
FX ROMANESCO
* classic FX class
* v 0.0.1
* 2019-2019
*/

void setting_fx_classic() {
  setting_fx_blur_circular();
  setting_fx_blur_gaussian();
  setting_fx_blur_radial();

  setting_fx_haltone_line();
  setting_fx_pixel();
  setting_fx_split_rgb();
}

void update_fx_classic() {
  // catch value slider
  float cx = map(value_slider_fx[0],0,MAX_VALUE_SLIDER,0,1);
  float cy = map(value_slider_fx[1],0,MAX_VALUE_SLIDER,0,1);
  float cz = map(value_slider_fx[2],0,MAX_VALUE_SLIDER,0,1);

  float px = map(value_slider_fx[3],0,MAX_VALUE_SLIDER,0,1);
  float py = map(value_slider_fx[4],0,MAX_VALUE_SLIDER,0,1);

  float sx = map(value_slider_fx[5],0,MAX_VALUE_SLIDER,0,1);
  float sy = map(value_slider_fx[6],0,MAX_VALUE_SLIDER,0,1);

  float str_x = map(value_slider_fx[7],0,MAX_VALUE_SLIDER,0,1);
  float str_y = map(value_slider_fx[8],0,MAX_VALUE_SLIDER,0,1);

  float quantity = map(value_slider_fx[9],0,MAX_VALUE_SLIDER,0,1);

  float quality = map(value_slider_fx[10],0,MAX_VALUE_SLIDER,0,1);

  float speed = map(value_slider_fx[11],0,MAX_VALUE_SLIDER,0,1);

  float angle = map(value_slider_fx[12],0,MAX_VALUE_SLIDER,0,1);

  float threshold = map(value_slider_fx[13],0,MAX_VALUE_SLIDER,0,1);
  

  update_fx_blur_circular(move_filter_fx,quantity,str_x);
  update_fx_blur_gaussian(move_filter_fx,str_x);
  update_fx_blur_radial(move_filter_fx,vec2(px,py),str_x);

  update_fx_haltone_line(move_filter_fx,vec2(px,py),quantity,angle);
  update_fx_pixel(move_filter_fx,quantity,vec2(sx,sy),vec3(cx,cy,cz));
  update_fx_split_rgb(move_filter_fx,vec2(str_x,str_y),speed);


}


/**
* blur circular
*/
String set_blur_circular = "blur circular";
void setting_fx_blur_circular() {
  String version = "0.0.1";
  int revision = 1;
  String author = "Stan le Punk";
  String pack = "Base 2019";
  int id = fx_classic_num;
  init_fx(set_blur_circular,FX_BLUR_CIRCULAR,id,author,pack,version,revision);
  fx_classic_num++;
}

void update_fx_blur_circular(boolean move_is, float num, float strength_x) {
  if(move_is) {
    int iteration = (int)map(num,0,1,2,64);
    fx_set_num(set_blur_circular,iteration);

    int max_blur = width;
    float str = strength_x*max_blur;
    fx_set_strength(set_blur_circular,str);
  }
}



/**
* gaussian blur
*/
String set_blur_gaussian = "blur gaussian";
void setting_fx_blur_gaussian() {
  String version = "0.0.3";
  int revision = 3;
  String author = "Stan le Punk";
  String pack = "Base 2019";
  int id = fx_classic_num;
  init_fx(set_blur_gaussian,FX_BLUR_GAUSSIAN,id,author,pack,version,revision);
  fx_classic_num++;
}

void update_fx_blur_gaussian(boolean move_is, float strength_x) {
  if(move_is) {
    int max_blur = height/10;
    float str = strength_x*max_blur;
    fx_set_strength(set_blur_gaussian,str);
  }
}




/**
* blur radial
*/
String set_blur_radial = "blur radial";
void setting_fx_blur_radial() {
  String version = "0.0.1";
  int revision = 1;
  String author = "Stan le Punk";
  String pack = "Base 2019";
  int id = fx_classic_num;
  init_fx(set_blur_radial,FX_BLUR_RADIAL,id,author,pack,version,revision);
  fx_classic_num++;
}

void update_fx_blur_radial(boolean move_is, vec2 pos,float strength) {
  if(move_is) {
    fx_set_pos(set_blur_radial,pos.x,pos.y);
    
    // scale change nothing
    // float scale = size*width;
    // fx_set_scale(set_blur_radial,scale);
    
    float str = strength*20;
    fx_set_strength(set_blur_radial,str);
  }
}





/**
* halftone line
*/
String set_halftone_line = "halftone line";
void setting_fx_haltone_line() {
  String version = "0.0.2";
  int revision = 1;
  String author = "Stan le Punk";
  String pack = "Base 2019";
  int id = fx_classic_num;
  init_fx(set_halftone_line,FX_HALFTONE_LINE,id,author,pack,version,revision);
  fx_classic_num++; 
}

void update_fx_haltone_line(boolean move_is, vec2 pos, float num, float angle) {
  if(move_is) {
    fx_set_mode(set_halftone_line,0); 

    int num_line = (int)map(num,0,1,20,100); 
    fx_set_num(set_halftone_line,num_line);  

    // pass nothing with this two parameter
    // fx_set_quality(set_halftone_line,quality);
    // fx_set_threshold(set_halftone_line,threshold);

    angle = map(angle,0,1,-TAU,TAU);
    fx_set_angle(set_halftone_line,angle);

    fx_set_pos(set_halftone_line,pos.array());
  }
}






/**
* pixel
* v 0.0.1
*/
String set_pixel = "pixel";
// boolean effect_pixel_is;
void setting_fx_pixel() {
  String version = "0.0.1";
  int revision = 1;
  String author = "Stan le Punk";
  String pack = "Base 2019";
  int id = fx_classic_num;
  init_fx(set_pixel,FX_PIXEL,id,author,pack,version,revision);
  fx_classic_num++;
}

void update_fx_pixel(boolean move_is, float num, vec2 size, vec3 hsb) {

  if(move_is) {
    float sx = map(size.x,0,1,1,width);
    float sy = map(size.y,0,1,1,height);
    fx_set_size(set_pixel,sx,sy);

    int palette_num = (int)map(num,0,1,2,16);
    fx_set_num(set_pixel,palette_num);
    
    float h = hsb.x; // from 0 to 1 where
    float s = hsb.y; // from 0 to 1 where
    float b = hsb.z; // from 0 to 1 where
    if(s < 0) s = 0; else if (s > 1) s = 1;
    if(b < 0) b = 0; else if (b > 1) s = 1;
    fx_set_level_source(set_pixel,h,s,b); // not used ????

    fx_set_event(set_pixel,0,false);
  }
}




/**
* split
* v 0.0.1
*/
String set_split_rgb = "split rgb";
void setting_fx_split_rgb() {
  String version = "0.0.1";
  int revision = 1;
  String author = "Stan le Punk";
  String pack = "Base 2019";
  int id = fx_classic_num;
  init_fx(set_split_rgb,FX_SPLIT_RGB,id,author,pack,version,revision);
  fx_classic_num++; 
}


void update_fx_split_rgb(boolean move_is, vec2 str, float speed) {
  if(move_is) {
    vec2 strength = map(str,0,1,1,4);
    vec2 offset_red = vec2().wave_cos(frameCount,speed*.2,speed *.5).mult(strength);
    vec2 offset_green = vec2().wave_sin(frameCount,speed *.2,speed *.1).mult(strength);
    vec2 offset_blue = vec2().wave_cos(frameCount,speed*.1,speed *.2).mult(strength);
    fx_set_pair(set_split_rgb,0,offset_red.array());
    fx_set_pair(set_split_rgb,1,offset_green.array());
    fx_set_pair(set_split_rgb,2,offset_blue.array());
  }
}





























/**
* FORCE WARP
* X SPECIAL
* this FX is linked with item and call a huge method and 
* class Force Field and class Force
* 2018-2018
* v 0.0.3
*/
Warp_Force warp_force_romanesco;
void init_warp_force() {
  if(warp_force_romanesco == null) {
    warp_force_romanesco = new Warp_Force(preference_path+"/shader/");
    warp_force_romanesco.add(g);
  }
}


void warp_force() {
  float intensity_warp_force = map(value_slider_fx[0],0,360,0,1);
  intensity_warp_force *= intensity_warp_force;
  intensity_warp_force = map(intensity_warp_force,0,1,0,10);
  
  // cycling
  float cycling = 1;
  float ratio = map(value_slider_fx[1],0,360,0,.8);
  if(ratio > 0) {
    ratio = (ratio*ratio*ratio);
    cycling = abs(sin(frameCount *ratio));
  }

  float cx = map(value_slider_fx[2],0,360,0,1);
  float cy = map(value_slider_fx[3],0,360,0,1);
  float cz = map(value_slider_fx[4],0,360,0,1);
  float ca = 1; // change nothing at this time
  vec4 refresh_warp_force = vec4(cx,cy,cz,ca);
  if(ratio > 0) {
    refresh_warp_force.mult(cycling);
  }

  warp_force_romanesco.refresh(refresh_warp_force);
  warp_force_romanesco.shader_init();
  warp_force_romanesco.shader_filter(extra_filter_fx);
  warp_force_romanesco.shader_mode(0);
  // here Force_field is pass
  warp_force_romanesco.show(force_romanesco,intensity_warp_force);

  if(warp_force_reset) {
    warp_force_romanesco.reset();
    warp_force_reset = false;
  }
}




boolean warp_force_reset;
void warp_force_keyPressed(char c_1) {
  if(key == c_1) {
    println("Reset Warp Force",frameCount);
    warp_force_reset = true;
  }
}
































