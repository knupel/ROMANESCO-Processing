/**
SOLEIL
2012-2019
1.2.1
*/
class Soleil extends Romanesco {
  public Soleil() {
    item_name = "Soleil" ;
    item_author  = "Stan le Punk";
    item_version = "Version 1.2.1";
    item_pack = "Base 2013-2019";
    item_costume = "" ;
    item_mode = "Beam/Lie'Bro'One/Lie'Bro'Two/Lie'Bro Noisy";
    hue_fill_is = true;
    sat_fill_is = true;
    bright_fill_is = true;
    alpha_fill_is = true;
    hue_stroke_is = true;
    sat_stroke_is = true;
    bright_stroke_is = true;
    alpha_stroke_is = true;
    thickness_is = true;
    // size_x_is = true;
    // size_y_is = true;
    // size_z_is = true;
    diameter_is = false;
    canvas_x_is = true;
    // canvas_y_is = true;
    // canvas_z_is = true;

    // frequence_is = true;
    speed_x_is = true;
    // speed_y_is = true;
    // speed_z_is = true;
    spurt_x_is = true;
    // spurt_y_is = true;
    //spurt_z_is = true;
    // dir_x_is = true;
    // dir_y_is = true;
    // dir_z_is = true;
    // jit_x_is = true;
    // jit_y_is = true;
    jit_z_is = true;
    // swing_x_is = true;
    // swing_y_is = true;
    //swing_z_is = true;

    quantity_is = true;
    //variety_is = true;
    // life_is = true;
    // flow_is = true;
    // quality_is = true;
    // area_is = true;
    // angle_is = true;
    // scope_is = true;
    // scan_is = true;
    // align_is = true;
    // repulsion_is = true;
    // attraction_is = true;
    // density_is = true;
    // influence_is = true;
    // calm_is = true;
    // spectrum_is = true;
    // COL 4
        // grid_is = true;
    // viscosity_is = true;
    // diffusion_is = true;
    // power_is = true;
    // mass_is = true;
    coord_x_is = true;
    coord_y_is = true;
    // coord_z_is = true;
  }
  //GLOBAL
  float jitter, spurt;
  float angleRotation;
  //SETUP
  void setup() {
    set_item_pos(width/2,height/2,0);
  }
  
  vec3 pos;
  //DRAW
  void draw() {
    aspect(get_fill(),get_stroke(),get_thickness());
    // orbital revolution
    boolean revolution = false;
    if(action_is() && special_is()) {
      revolution = true;
    }
    
    if(pos == null) pos = vec3(0);
    if(revolution) {
      pos.set(get_coord_x()*width,get_coord_y()*height,0); 
    } else {
      pos.set(0);
    }
    // diam
    float diam = get_canvas_x();
    if(sound_is()) diam *= all_transient(ID_item);
    // num beam
    float num_temp = get_quantity() *get_quantity();
    int numBeam = (int)(num_temp *87 +1);
    if(!FULL_RENDERING) numBeam /= 20;
    if(numBeam < 2 ) numBeam = 2;
    
    // spurt
    float ratio_spurt = (get_spurt_x() *get_spurt_x()) +.005;
    spurt += (ratio_spurt *.33)  ;
    float spurting = cos(spurt) *tempo[ID_item] ;

    // jitter
    PVector jitter = new PVector() ;
    float ratio_jitter = get_jitter_z() *get_jitter_z() ;
    float amp = sq(ratio_jitter *(height /10)) ;
    float right_jit =  ((right[ID_item] *right[ID_item] *5) *amp) ;
    float left_jit = ((left[ID_item] *left[ID_item] *5) *amp) ;
    if(sound_is()) jitter = new PVector(right_jit, left_jit) ; else jitter = new PVector(amp,amp);

    // rotation direction
    int direction = 1 ;
    if(reverse_is()) direction = 1 ; else direction = -1 ;
    if(!motion_is()) direction = 0 ;
    
    // rotation speed
    float speedRotation = 0 ;
    float ratio_speed = (get_speed_x() *get_speed_x()) +.05 ;
    if(get_speed_x() <= 0) ratio_speed = 0 ;
    speedRotation = sq(ratio_speed *8.0 *tempo[ID_item]) *direction ;
    angleRotation += speedRotation ;
    rotate (radians(angleRotation)) ;

    // mode
    if(get_mode_id() == 0) soleil(pos,diam,numBeam);
    if(get_mode_id() == 1) soleil(pos,diam,numBeam,spurting);
    if(get_mode_id() == 2) soleil(pos,diam,numBeam,spurt);
    if(get_mode_id() == 3) soleil(pos,diam,numBeam,spurt,jitter);
    
    // info display
    info("The sun have "+numBeam + " beams"," Special motion revolution is "+revolution);
    
    
  }
  
  // ANNEXE
  // soleil with jitter
  void soleil(vec3 pos, float diam, int numBeam, float spurt, PVector jitter) {
    int numPoints = numBeam *2 ;
    for (int i = 0 ; i < numPoints -1 ; i = i +2) {
      float vibration = random(-jitter.x, jitter.y) ;
      PVector p1 = new PVector() ;
      PVector p2 = new PVector() ;
      p1 = circle(to_PVector(pos), (int)diam, numPoints, spurt)[i].copy() ;
      p2 = circle(to_PVector(pos), (int)diam, numPoints, spurt)[i +1].copy() ;
  
      beginShape();
      vertex(pos);
      vertex(p1.x +vibration, p1.y +vibration, p1.z +vibration);
      vertex(p2.x +vibration, p2.y +vibration, p2.z +vibration);
      endShape(CLOSE);
    }
  }
  
  
  // soleil with jitter
  void soleil(vec3 pos, float diam, int numBeam, float jitter) {
    int numPoints = numBeam *2 ;
    for (int i = 0 ; i < numPoints -1 ; i = i +2) {
      PVector p1 = new PVector();
      PVector p2 = new PVector();
      p1 = circle(to_PVector(pos), (int)diam, numPoints, jitter)[i].copy();
      p2 = circle(to_PVector(pos), (int)diam, numPoints, jitter)[i +1].copy();
  
      beginShape() ;
      vertex(pos) ;
      vertex(p1.x, p1.y, p1.z) ;
      vertex(p2.x, p2.y, p2.z) ;
      endShape(CLOSE) ;
    }
  }
  
  // classic soleil
  void soleil(vec3 pos, float diam, int numBeam) {
    int numPoints = numBeam *2 ;
    for (int i = 0 ; i < numPoints -1 ; i = i +2) {
      PVector p1 = new PVector() ;
      PVector p2 = new PVector() ;
      p1 = circle(to_PVector(pos), (int)diam, numPoints)[i].copy() ;
      p2 = circle(to_PVector(pos), (int)diam, numPoints)[i +1].copy() ;
      beginShape() ;
      vertex(pos) ;
      vertex(p1.x, p1.y, p1.z) ;
      vertex(p2.x, p2.y, p2.z) ;
      endShape(CLOSE) ;
    }
  }

  PVector to_PVector(vec v) {
    return new PVector(v.x,v.y,v.z);
  }
}