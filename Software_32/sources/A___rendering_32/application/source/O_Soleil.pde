/**
SOLEIL
2012-2018
1.1.5
*/

class Soleil extends Romanesco {
  public Soleil() {
    //from the index_objects.csv
    item_name = "Soleil" ;
    item_author  = "Stan le Punk";
    item_version = "Version 1.1.5";
    item_pack = "Base 2013-2018" ;
    item_costume = "" ;
    item_mode = "Beam/Lie'Bro'One/Lie'Bro'Two/Lie'Bro Noisy" ;
    hue_fill_is = true;
    sat_fill_is = true;
    bright_fill_is = true;
    alpha_fill_is = true;
    hue_stroke_is = true;
    sat_stroke_is = true;
    bright_stroke_is = true;
    alpha_stroke_is = true;
    thickness_is = true;
    size_x_is = false;
    size_y_is = false;
    size_z_is = false;
    diameter_is = false;
    canvas_x_is = true;
    canvas_y_is = false;
    canvas_z_is = false;

    // frequence_is = true;
    speed_x_is = true;
    speed_y_is = false;
    speed_z_is = false;
    spurt_x_is = true;
    spurt_y_is = false;
    spurt_z_is = false;
    dir_x_is = false;
    dir_y_is = false;
    dir_z_is = false;
    jit_x_is = false;
    jit_y_is = false;
    jit_z_is = true;
    swing_x_is = false;
    swing_y_is = false;
    swing_z_is = false;

    quantity_is = true;
    variety_is = false;
    life_is = false;
    flow_is = false;
    quality_is = false;
    area_is = false;
    angle_is = false;
    scope_is = false;
    scan_is = false;
    align_is = false;
    repulsion_is = false;
    attraction_is = false;
    density_is = false;
    influence_is = false;
    calm_is = false;
    spectrum_is = false;
  }
  //GLOBAL
  float jitter, spurt ;
  float angleRotation ;
  //SETUP
  void setup() {
    setting_start_position(ID_item, width/2, height/2, 0) ;
  }
  
  PVector pos = new PVector() ;
  //DRAW
  void draw() {
    aspect_rope(fill_item[ID_item], stroke_item[ID_item], thickness_item[ID_item]) ;
    // orbital revolution
    if((key_space_long && action[ID_item]) || orbit[ID_item]) pos.set(mouse[ID_item].x -width/2, mouse[ID_item].y -height/2,0) ; else pos.set(0,0,0) ;
    // diam
    int diam = int(canvas_x_item[ID_item] *all_transient(ID_item)) ;
    // num beam
    float num_temp = quantity_item[ID_item] *quantity_item[ID_item] ;
    int numBeam = (int)(num_temp *87 +1) ;
    if(!FULL_RENDERING) numBeam /= 20 ;
    if(numBeam < 2 ) numBeam = 2 ;
    
    // spurt
    float ratio_spurt = (spurt_x_item[ID_item] *spurt_x_item[ID_item]) +.005 ;
    spurt += (ratio_spurt *.33)  ;
    float spurting = cos(spurt) *tempo[ID_item] ;

    // jitter
    PVector jitter = new PVector() ;
    float ratio_jitter = jitter_z_item[ID_item] *jitter_z_item[ID_item] ;
    float amp = sq(ratio_jitter *(height /10)) ;
    float right_jit =  ((right[ID_item] *right[ID_item] *5) *amp) ;
    float left_jit = ((left[ID_item] *left[ID_item] *5) *amp) ;
    if (sound[ID_item]) jitter = new PVector(right_jit, left_jit) ; else jitter = new PVector(amp,amp) ;

    // rotation direction
    int direction = 1 ;
    if(reverse[ID_item]) direction = 1 ; else direction = -1 ;
    if(!motion[ID_item]) direction = 0 ;
    
    // rotation speed
    float speedRotation = 0 ;
    float ratio_speed = (speed_x_item[ID_item] *speed_x_item[ID_item]) +.05 ;
    if(speed_x_item[ID_item] <= 0) ratio_speed = 0 ;
    speedRotation = sq(ratio_speed *8.0 *tempo[ID_item]) *direction ;
    angleRotation += speedRotation ;
    rotate (radians(angleRotation)) ;

    // mode
    if(mode[ID_item] == 0) soleil(pos, diam, numBeam) ;
    if(mode[ID_item] == 1) soleil(pos, diam, numBeam, spurting) ;
    if(mode[ID_item] == 2) soleil(pos, diam, numBeam, spurt) ;
    if(mode[ID_item] == 3) soleil(pos, diam, numBeam, spurt, jitter) ;
    
    // info display
    String revolution = ("") ;
    if((key_space_long && action[ID_item]) || orbit[ID_item]) revolution =("false") ; else revolution = ("true") ;
    item_info[ID_item] = ("The sun have " + numBeam + " beams - Motion "+revolution ) ;
    
    
  }
  
  // ANNEXE
  // soleil with jitter
  void soleil(PVector pos, int diam, int numBeam, float spurt, PVector jitter) {
    int numPoints = numBeam *2 ;
    for (int i = 0 ; i < numPoints -1 ; i = i +2) {
      float vibration = random(-jitter.x, jitter.y) ;
      PVector p1 = new PVector() ;
      PVector p2 = new PVector() ;
      p1 = circle(pos, diam, numPoints, spurt)[i].copy() ;
      p2 = circle(pos, diam, numPoints, spurt)[i +1].copy() ;
  
      beginShape() ;
      vertex(pos.x, pos.y, pos.z) ;
      vertex(p1.x +vibration, p1.y +vibration, p1.z +vibration) ;
      vertex(p2.x +vibration, p2.y +vibration, p2.z +vibration) ;
      endShape(CLOSE) ;
    }
  }
  
  
  // soleil with jitter
  void soleil(PVector pos, int diam, int numBeam, float jitter) {
    int numPoints = numBeam *2 ;
    for (int i = 0 ; i < numPoints -1 ; i = i +2) {
      PVector p1 = new PVector() ;
      PVector p2 = new PVector() ;
      p1 = circle(pos, diam, numPoints, jitter)[i].copy() ;
      p2 = circle(pos, diam, numPoints, jitter)[i +1].copy() ;
  
      beginShape() ;
      vertex(pos.x, pos.y, pos.z) ;
      vertex(p1.x, p1.y, p1.z) ;
      vertex(p2.x, p2.y, p2.z) ;
      endShape(CLOSE) ;
    }
  }
  
  // classic soleil
  void soleil(PVector pos, int diam, int numBeam) {
    int numPoints = numBeam *2 ;
    for (int i = 0 ; i < numPoints -1 ; i = i +2) {
      PVector p1 = new PVector() ;
      PVector p2 = new PVector() ;
      p1 = circle(pos, diam, numPoints)[i].copy() ;
      p2 = circle(pos, diam, numPoints)[i +1].copy() ;
      beginShape() ;
      vertex(pos.x, pos.y, pos.z) ;
      vertex(p1.x, p1.y, p1.z) ;
      vertex(p2.x, p2.y, p2.z) ;
      endShape(CLOSE) ;
    }
  }
}
