
/**
FILTER
2018-2018
v 0.0.3
*/
Force warp_force_romanesco;
void init_filter() {
  if(FULL_RENDERING) {
    // force
    type_field = r.FLUID;
    pattern_field = r.BLANK;
    set_type_force_field(type_field);
    init_force_field();
    // set_different_force_field();
    println("init filter Force Field part");
    // warp
    init_force();
    println("init filter warp part");
    // set path fx shader;
    set_fx_path(preference_path+"/shader/fx/");
    get_fx_path();
    if(fx_rope_path_exists) {
      println("fx path filter",fx_rope_path,"exists");
    } else {
      printErr("fx path filter",fx_rope_path,"don't exists");
    }

    write_fx_index();
  }
}


void filter() {
  if(FULL_RENDERING && fx_button_is(0)) {
    println(which_fx);
    if(which_fx == 0) {
      warp_force();
    } else if(which_fx == 1) {

    }
  } 
}


void write_fx_index() {
  Table index_fx = new Table();
  index_fx.addColumn("Name");
  index_fx.addColumn("Author");
  index_fx.addColumn("Version");
  index_fx.addColumn("Pack");
  

  int num = 2;
  TableRow [] info_fx = new TableRow [num];

  for(int i = 0 ; i < info_fx.length ; i++) {
    info_fx[i] = index_fx.addRow();
  }

  info_fx[0].setString("Name","Force");
  info_fx[0].setString("Author","Stan le Punk");
  info_fx[0].setString("Version","0.1.0");
  info_fx[0].setString("Pack","Base 2014");

  info_fx[1].setString("Name","Dither");
  info_fx[1].setString("Author","Stan le Punk");
  info_fx[1].setString("Version","0.1.0");
  info_fx[1].setString("Pack","Base 2019");



  saveTable(index_fx, preference_path+"index_fx.csv"); 

}





/**
WARP
2018-2018
v 0.0.3
this chapter is the place where the pixel is filtering
*/
void init_force() {
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
































