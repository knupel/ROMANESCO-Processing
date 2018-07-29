
/**
FILTER
2018-2018
v 0.0.1
*/
Warp warp_romanesco;
void init_filter() {
  if(FULL_RENDERING) {
    // force
    type_field = r.FLUID;
    pattern_field = r.BLANK;
    set_type_force_field(type_field);
    init_force_field();
    set_different_force_field();
    // warp
    init_warp();
    println("init filter is done");
  }
}


void filter() {
  // force field
  if(FULL_RENDERING && (fx_button_is(0) || update_force_field_is())) {
    update_force_field();
  }
  update_force_field_is(false);
  
  // warp
  if(FULL_RENDERING && fx_button_is(0)) {
    warp();
  } 
}



/**
WARP
2018-2018
v 0.0.1
this chapter is the place where the pixel is filtering
*/
void init_warp() {
  warp_romanesco = new Warp(preference_path+"/shader/");
  warp_romanesco.add(g);
}


void warp() {
  float intensity_warp = map(value_slider_fx[0],0,360,0,1);
  intensity_warp *=intensity_warp;
  intensity_warp = map(intensity_warp,0,1,0,10);
  
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
  Vec4 refresh_warp = Vec4(cx,cy,cz,ca);
  if(ratio > 0) {
    refresh_warp.mult(cycling);
  }

  warp_romanesco.refresh(refresh_warp);
  warp_romanesco.shader_init();
  // here Force_field is pass
  warp_romanesco.show(force_romanesco,intensity_warp);
}



































