/**
FORCE
2018-2018
v 0.0.7
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
  int range_detection = 5;
  int type = get_type_force_field();
  int pattern = get_pattern_force_field();
  if(num_spot < 2) num_spot = 2;
  if(type == r.FLUID) {
    force_romanesco = new Force_field(ref_cell_size,r.FLUID,r.BLANK);
    force_romanesco.add_spot(num_spot);
  } else if(type == r.MAGNETIC) {
    force_romanesco = new Force_field(ref_cell_size,r.MAGNETIC,r.BLANK);
    force_romanesco.add_spot(num_spot);
    force_romanesco.set_spot_detection(range_detection);
  } else if(type == r.GRAVITY){
    // println("init_force_field();",ref_cell_size,r.GRAVITY,r.BLANK);
    force_romanesco = new Force_field(ref_cell_size,r.GRAVITY,r.BLANK);
    force_romanesco.add_spot(num_spot);
    force_romanesco.set_spot_detection(range_detection);
  }

  

  if(pattern == r.PERLIN) {
    force_romanesco = new Force_field(ref_cell_size,r.STATIC,r.PERLIN);
  } else if(pattern == r.CHAOS) {
    force_romanesco = new Force_field(ref_cell_size,r.STATIC,r.CHAOS);
  } else if(pattern == r.EQUATION) {
    force_romanesco = new Force_field(ref_cell_size,r.STATIC,r.EQUATION);
  }

  init_dynamic_force_field();
}




// USE only at the itit setup :(
void init_dynamic_force_field() {
  for(int i = 0 ; i < force_romanesco.get_spot_num() ; i++) {
    float x = random(width);
    float y = random(height);
    force_romanesco.set_spot_pos(x,y,i);
  }

  // fluid setting
  set_force_fluid_frequence(2/frameRate);
  set_force_fluid_viscosity(.001);
  set_force_fluid_diffusion(1.);
  // magnetic setting
  set_force_magnetic_tesla(20,-20);
  set_force_magnetic_diam(50);
  // gravity setting
  set_force_gravity_mass(25);

}





void force() {
  // force field
  if(FULL_RENDERING && (fx_button_is(0) || update_force_field_is())) {
    update_force_field();
  }
  update_force_field_is(false);
}






// type
int type_force_field;
int get_type_force_field() {
  return type_force_field;
}



// set pattern
int pattern_force_field;
int get_pattern_force_field() {
  return pattern_force_field;
}




int get_cell_force_field() {
  return ref_cell_size;
}




boolean puppet_master_force_field_is = false ;
boolean puppet_master_is() {
  return puppet_master_force_field_is;
}

void puppet_master(boolean is) {
  puppet_master_force_field_is = is;
}




void update_force_field() {
  if(force_romanesco.get_type() == r.MAGNETIC || force_romanesco.get_type() == r.GRAVITY) {
    force_romanesco.refresh();
  }
  force_romanesco.update();
}











// SET
void set_type_force_field(int type) {
  type_force_field = type;
}


void set_cell_force_field(int size) {
  ref_cell_size = size;
}


void set_pattern_force_field(int pattern) {
  pattern_force_field = pattern;
}
// detection
void set_spot_detection_force_field(int detection) {
  force_romanesco.set_spot_detection(detection);
}

// SET DIFFERENT FORCE FIELD





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
      force_romanesco.set_spot_diam(vec2(diam[index]),i);
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

boolean update_force_romanesco_is;
void update_force_field_is(boolean is) {
  update_force_romanesco_is = true;
}

boolean update_force_field_is() {
  return update_force_romanesco_is;
}









/**
SPOT ROMANESCO MANAGER
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


void set_spot_pos(vec pos, int index) {
  force_romanesco.set_spot_pos(pos,index);
}

void set_spot_pos(float x, float y, int index) {
  force_romanesco.set_spot_pos(vec2(x,y),index);  
}


vec3 [] get_spot_pos() {
  vec3 [] pos = new vec3[force_romanesco.get_spot_num()];
  for(int i = 0 ; i < pos.length ; i++) {
    pos[i] = force_romanesco.get_spot_pos(i);
  }
  return pos;
}

float [] get_spot_mass() {
  float [] mass = new float[force_romanesco.get_spot_num()];
  for(int i = 0 ; i < mass.length ; i++) {
    mass[i] = force_romanesco.get_spot_mass(i);
  }
  return mass;
}


int [] get_spot_tesla() {
  int [] tesla = new int[force_romanesco.get_spot_num()];
  for(int i = 0 ; i < tesla.length ; i++) {
    tesla[i] = force_romanesco.get_spot_tesla(i);
  }
  return tesla;
}



vec3 get_spot_pos(int index) {
  if(index < force_romanesco.get_spot_num()) {
    return force_romanesco.get_spot_pos(index);
  } else {
    return null;
  }
}






