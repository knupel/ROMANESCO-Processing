/**
FORCE
2018-2018
v 0.0.5
*/
// FORCE
int ref_cell_size =20;
int type_field;
int pattern_field;
Force_field force_romanesco;
void init_force_field() {
  int num_spot_minimum = 2;
  init_force_field(num_spot_minimum);
}
void init_force_field(int num_spot) {
  int type = get_type_force_field();
  if(type == r.FLUID) {
    force_romanesco = new Force_field(ref_cell_size,r.FLUID,r.BLANK);
    force_romanesco.add_spot();
  } else if(type == r.MAGNETIC) {
    force_romanesco = new Force_field(ref_cell_size,r.MAGNETIC,r.BLANK);
    force_romanesco.add_spot(num_spot);
    force_romanesco.set_spot_detection(5);
  } else if(type == r.GRAVITY){
    force_romanesco = new Force_field(ref_cell_size,r.GRAVITY,r.BLANK);
    force_romanesco.add_spot(num_spot);
    force_romanesco.set_spot_detection(5);
  }
}

// detection
void set_spot_detection_force_field(int detection) {
  force_romanesco.set_spot_detection(detection);
  println(detection);
}

// type
int type_force_field;
int get_type_force_field() {
  return type_force_field;
}

void set_type_force_field(int type) {
  type_force_field = type;
}

// set pattern
int pattern_force_field;
int get_pattern_force_field() {
  return pattern_force_field;
}

void set_pattern_force_field(int pattern) {
  pattern_force_field = pattern;
}


int get_cell_force_field() {
  return ref_cell_size;
}

void set_cell_force_field(int size) {
  ref_cell_size = size;
}




void update_force_field() {

  // update spot position
  if(force_romanesco.get_spot_num() == 1 ) {
    force_romanesco.set_spot_pos(mouse[0].x,mouse[0].y);
  } else if(force_romanesco.get_spot_num() == 2) {
    force_romanesco.set_spot_pos(mouse[0].x,mouse[0].y,0);
    force_romanesco.set_spot_pos(width -mouse[0].x,height -mouse[0].y,1);
    // case where it's item Ballet manage the spot
  }

  if(force_romanesco.get_type() == r.MAGNETIC || force_romanesco.get_type() == r.GRAVITY) {
    force_romanesco.refresh();
  }

  force_romanesco.update();
}














// SET DIFFERENT FORCE FIELD


// USE only at the itit setup :(



void set_different_force_field() {
  if(force_romanesco.get_type() == r.FLUID) {
    set_force_fluid_frequence(2/frameRate);
    set_force_fluid_viscosity(.001);
    set_force_fluid_diffusion(1.);
  } else if(force_romanesco.get_type() == r.MAGNETIC) {
    set_force_magnetic_tesla(20,-20);
    set_force_magnetic_diam(50);
  }
}
// set force field fluid
void set_force_fluid_frequence(float frequence) {
  force_romanesco.set_frequence(frequence);
}

void set_force_fluid_viscosity(float viscosity) {
  force_romanesco.set_viscosity(viscosity); // back to normal
}

void set_force_fluid_diffusion(float diffusion) {
  force_romanesco.set_diffusion(diffusion);
}

// set force field magnetic
void set_force_magnetic_tesla(int... tesla) {
  if(tesla.length <= force_romanesco.get_spot_num()) {
    int index =0;
    for(int i = 0 ; i < force_romanesco.get_spot_num() ;i++) {
      force_romanesco.set_spot_tesla(tesla[index],i);
      index++;
      if(index >= tesla.length) index = 0;
    }   
  } 
}

void set_force_magnetic_diam(int... diam) {
  if(diam.length <= force_romanesco.get_spot_num()) {
    int index =0;
    for(int i = 0 ; i < force_romanesco.get_spot_num() ;i++) {
      force_romanesco.set_spot_diam(Vec2(diam[index]),i);
      index++;
      if(index >= diam.length) index = 0;
    }   
  }
}


void set_force_gravity_mass(int... mass) {
  if(mass.length <= force_romanesco.get_spot_num()) {
    int index =0;
    for(int i = 0 ; i < force_romanesco.get_spot_num() ;i++) {
      force_romanesco.set_spot_mass(mass[index],i);
      index++;
      if(index >= mass.length) index = 0;
    }   
  }
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






