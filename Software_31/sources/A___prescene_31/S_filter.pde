
/**
FILTER
2018-2018
v 0.0.1
*/
int ref_cell_size =20;
int type_field;
int pattern_field;
Force_field force_romanesco;
Warp warp_romanesco;
void init_filter() {
  type_field = r.FLUID;
  pattern_field = r.BLANK;
  if(FULL_RENDERING) {
    set_type_force_field(type_field);
    init_force_field();
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
  warp_romanesco.show(force_romanesco,intensity_warp);
}









/**
FILTER FORCE
2018-2018
v 0.0.3
*/
void init_force_field() {
  int type = get_type_force_field();
  if(type == r.FLUID) {
    force_romanesco = new Force_field(ref_cell_size,r.FLUID,r.BLANK);
  } else if(type == r.GRAVITY){
    force_romanesco = new Force_field(ref_cell_size,r.GRAVITY,r.BLANK);
  } else if(type == r.MAGNETIC) {
    force_romanesco = new Force_field(ref_cell_size,r.MAGNETIC,r.BLANK);
  }
  force_romanesco.add_spot();
}

int type_force_field;
int get_type_force_field() {
  return type_force_field;
}

void set_type_force_field(int type) {
  type_force_field = type;
}


int get_cell_force_field() {
  return ref_cell_size;
}

void set_cell_force_field(int size) {
  ref_cell_size = size;
}


void update_force_field() {
  if(force_romanesco.get_type() == r.FLUID) {
    update_force_fluid();
  }
  // update spot position
  if(force_romanesco.get_spot_num() == 1 ) {
    force_romanesco.set_spot_pos(mouse[0].x,mouse[0].y);
  } else if(force_romanesco.get_spot_num() > 1) {
    // case where it's item Ballet manage the spot
  }

  force_romanesco.update();
}









// fluid force filter
void update_force_fluid() {
  float freq_ff = 2/frameRate;
  float visc_ff = .001;;
  float diff_ff = 1.;  
  force_romanesco.set_frequence(freq_ff);
  force_romanesco.set_viscosity(visc_ff); // back to normal
  force_romanesco.set_diffusion(diff_ff);
}






/**
FORCE FIELD MANAGER
*/
Force_field get_force_field() {
  return force_romanesco;
}

boolean update_force_romanesco_is ;
void update_force_field_is(boolean is) {
  update_force_romanesco_is = true;
}

boolean update_force_field_is() {
  return update_force_romanesco_is;
}


/**
SPOT ROMANESCO MANAGER
v 0.0.1
*/
int get_spot_num() {
  return force_romanesco.get_spot_num();
}

void add_spot(int num) {
  for(int i = 0 ; i < num ; i++) {
    force_romanesco.add_spot();
  }
}

void clear_spot() {
  force_romanesco.clear_spot();
}


void set_spot_pos(Vec pos, int index) {
  force_romanesco.set_spot_pos(pos,index);

}

void set_spot_pos(float x, float y, int index) {
  force_romanesco.set_spot_pos(Vec2(x,y),index);  
}

Vec3 get_spot_pos(int index) {
  if(index < force_romanesco.get_spot_num()) {
    return force_romanesco.get_spot_pos(index);
  } else return null;
}

























