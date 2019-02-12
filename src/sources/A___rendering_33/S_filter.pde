/**
FILTER
* 2018-2019
* v 0.1.0
* here is calling classic FX ROPE + FX FORCE FIELD
*/


Force warp_force_romanesco;
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


void filter() {
  if(FULL_RENDERING && fx_button_is(0)) {
    int target = which_fx-1; // min 1 cause the first one is a special one;
    if(which_fx == 0) {
      warp_force();
    } else if(which_fx == 1) {
      select_fx(g,null,null,get_fx(target)); 
    } else if(which_fx == 2) {
      select_fx(g,null,null,get_fx(target)); 
    }
  } 
}


void write_filter_index() {
  Table index_fx = new Table();
  index_fx.addColumn("Name");
  index_fx.addColumn("Author");
  index_fx.addColumn("Version");
  index_fx.addColumn("Pack");
  

  int num = fx_classic_nun+1; // +1 cause of the special force field fx
  TableRow [] info_fx = new TableRow [num];

  for(int i = 0 ; i < info_fx.length ; i++) {
    info_fx[i] = index_fx.addRow();
  }

  info_fx[0].setString("Name","Force");
  info_fx[0].setString("Author","Stan le Punk");
  info_fx[0].setString("Version","0.1.0");
  info_fx[0].setString("Pack","Base 2014");


  for(int i = 0 ; i < fx_classic_nun ; i++) {
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
int fx_classic_nun;
void setting_fx_classic() {
  setting_blur_gaussian();
  setting_haltone_line();


}



// blur gaussian
String set_blur_gaussian = "blur gaussian";
void setting_blur_gaussian() {
  String version = "0.0.1";
  int revision = 1;
  String author = "Stan le Punk";
  String pack = "Base 2019";
  int id = fx_classic_nun;
  init_fx(set_blur_gaussian,FX_BLUR_GAUSSIAN,id,author,pack,version,revision);
  fx_classic_nun++;

  float x = mouseX -(width/2);
  float y = mouseY -(height/2);
  int max_blur = 40;
  vec2 size = vec2(map(abs(x),0,width/2,0,max_blur),map(abs(y),0,height/2,0,max_blur));
  fx_set_size(set_blur_gaussian,size.x,size.y);
}





// halftone line
String set_halftone_line = "halftone line";
void setting_haltone_line() {
  String version = "0.0.1";
  int revision = 1;
  String author = "Stan le Punk";
  String pack = "Base 2019";
  int id = fx_classic_nun;
  init_fx(set_halftone_line,FX_HALFTONE_LINE,id,author,pack,version,revision);
  fx_classic_nun++;

  if(mousePressed) {
    fx_set_mode(set_halftone_line,0); 
    int num_line = (int)map(mouseY,0,height,20,100); 
    fx_set_num(set_halftone_line,num_line);  
    fx_set_quality(set_halftone_line,.2);

    float threshold = map(mouseY,0,height,0,1);
    fx_set_threshold(set_halftone_line,threshold);
    // float angle = sin(frameCount *.001) * PI;

    float angle = map(mouseX,0,width,-TAU,TAU);
    fx_set_angle(set_halftone_line,angle);

    float px = map(width/2,0,width,0,1); // normal position
    float py = map(height/2,0,height,0,1); // normal position
    fx_set_pos(set_halftone_line,px,py);
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
void init_warp_force() {
  if(force_romanesco == null) {
    warp_force_romanesco = new Force(preference_path+"/shader/");
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
  boolean filter_fx = fx_button_is(1);
  warp_force_romanesco.shader_filter(filter_fx);
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
































