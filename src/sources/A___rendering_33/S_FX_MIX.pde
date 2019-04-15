/**
* MIX the main rendering
* 2019-2019
* v 0.0.1
*/
// INCRUSTATION
// mix
/*
* 1 multiply
* 2 screen
* 3 exclusion
* 4 overlay
* 5 hard_light
* 6 soft_light
* 7 color_dodge
* 8 color_burn
* 9 linear_dodge
* 10 linear_burn
* 11 vivid_light
* 12 linear_light
* 13 pin_light
* 14 hard_mix
* 15 subtract
* 16 divide
* 17 addition
* 18 difference
* 19 darken
* 20 lighten
* 21 invert
* 22 invert_rgb
* 23 main
* 24 layer
*/

void post_mix_before() {
  if(FULL_RENDERING) {
    println("before");
    if(incrust_is()) {
      println("before in");
      fx_mix_inc_copy(g);
    }
    set_mix_inc();
    if(fx_mix_button_is(0)) {
      update_fx_mix_slider();
    }
  }
}


void post_mix_after() {
  if(FULL_RENDERING) {
     println("after");
    if(incrust_is()) {
      println("after in");
      fx_mix_inc(g);
    }
  }
}

vec3 fx_mix_colour_source;
vec3 fx_mix_colour_layer;
void update_fx_mix_slider() {
  if(fx_mix_colour_source == null) {
    fx_mix_colour_source = vec3();
  }
  fx_mix_colour_source.x(map(value_slider_fx_mix[0],0,MAX_VALUE_SLIDER,0,1));
  fx_mix_colour_source.y(map(value_slider_fx_mix[1],0,MAX_VALUE_SLIDER,0,1));
  fx_mix_colour_source.z(map(value_slider_fx_mix[2],0,MAX_VALUE_SLIDER,0,1));
  
  if(fx_mix_colour_layer == null) {
    fx_mix_colour_layer = vec3();
  }
  fx_mix_colour_layer.x(map(value_slider_fx_mix[3],0,MAX_VALUE_SLIDER,0,1));
  fx_mix_colour_layer.z(map(value_slider_fx_mix[4],0,MAX_VALUE_SLIDER,0,1));
  fx_mix_colour_layer.z(map(value_slider_fx_mix[5],0,MAX_VALUE_SLIDER,0,1));
}


void fx_mix_inc(PImage src) {
  boolean on_g = true;
  if(inc_fx != null && src.width == inc_fx.width && src.height == inc_fx.height) {
    fx_mix(src,inc_fx,on_g,which_mix,fx_mix_colour_source,fx_mix_colour_layer);
  }
}




PImage inc_fx;
void fx_mix_inc_copy(PImage src) {
  if(inc_fx == null || inc_fx.width != src.width || inc_fx.height != src.height) {
    inc_fx = createImage(src.width,src.height,RGB);
  }
  inc_fx.copy(src,0,0,src.width,src.height, 0,0,src.width,src.height);
}


void set_mix_inc() {
  if(which_mix != 0) {
    incrust_is(true);
  } else {
    incrust_is(false);
  }
}


boolean incrust_is = false;
void incrust_is(boolean is) {
  incrust_is = is;
}

boolean incrust_is() {
  return incrust_is;
}