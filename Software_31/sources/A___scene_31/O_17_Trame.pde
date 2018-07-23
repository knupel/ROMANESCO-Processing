/**
TRAME
2012-2018
V 1.1.4
*/

Trame trame ;
//object three
class Damier extends Romanesco {
  public Damier() {
    //from the index_objects.csv
    item_name = "Damier" ;
    ID_item = 17 ;
    ID_group = 1 ;
    item_author  = "Stan le Punk";
    item_version = "Version 1.1.3";
    item_pack = "Base";
    item_costume = "";
    item_mode = "Rectangle/Ellipse/Box";

 
    hue_fill_is = true;
    sat_fill_is = true;
    bright_fill_is = true;
    alpha_fill_is = true;
    hue_stroke_is = true;
    sat_stroke_is = true;
    bright_stroke_is = true;
    alpha_stroke_is = true;
    thickness_is = true;
    size_x_is = true;
    size_y_is = true;
    size_z_is = true;
    font_size_is = false;
    canvas_x_is = false;
    canvas_y_is = false;
    canvas_z_is = false;

    reactivity_is = false;
    speed_x_is = true;
    speed_y_is = false;
    speed_z_is = false;
    spurt_x_is = false;
    spurt_y_is = false;
    spurt_z_is = false;
    dir_x_is = false;
    dir_y_is = false;
    dir_z_is = false;
    jit_x_is = false;
    jit_y_is = false;
    jit_z_is  = false;
    swing_x_is = true;
    swing_y_is = false;
    swing_z_is = false;

    quantity_is = true;
    variety_is = false;
    life_is = false;
    flow_is = false;
    quality_is = false;
    area_is = false;
    angle_is = true;
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
  float d, g, m ;
  PVector size = new PVector(0,0,0) ;
  float angleTrame = 0 ;
  float angle = 0 ;
  float speed = 0 ;

  Vec3 lattice = Vec3(0) ;

  //SETUP
  void setup() {
    setting_start_position(ID_item, width/2, height/2, 0) ;
    setting_start_direction(ID_item, 45,45) ;
    trame = new Trame() ;
    lattice = Vec3(0) ;
  }
  
  //DRAW
  void draw() {
    // color and thickness
    aspect_rope(fill_item[ID_item], stroke_item[ID_item], thickness_item[ID_item]) ;
    
    if ( sound[ID_item]) {
      g = map(left[ID_item],0,1,1,5) ; 
      d = map(right[ID_item],0,1,1,5) ; 
      m = map(mix[ID_item],0,1,1,5) ;
    } else {  
      g = 1.0 ;
      d = 1.0 ;
      m = 1.0 ;
    }
    float penPressure = map(pen[ID_item].z,0,1,1,width/100) ;
    float sizeXtemp = map(size_x_item[ID_item],.1,width,.1,width/33) ;
    float sizeYtemp = map(size_y_item[ID_item],.1,width,.1,width/33) ;
    float sizeZtemp = map(size_z_item[ID_item],.1,width,.1,width/33) ;
    size.x = ((sizeXtemp *sizeXtemp) *penPressure *all_transient(ID_item) ) *g ;
    size.y = ((sizeYtemp *sizeYtemp) *penPressure *all_transient(ID_item)) *d ;
    size.z = ((sizeZtemp *sizeZtemp) *penPressure *all_transient(ID_item)) *m  ;
    //size

    //orientation / deg
    //speed
    speed = map(speed_x_item[ID_item], 0,1,0, 0.5 );
    if(reverse[ID_item]) speed = speed *1 ; else speed = speed * -1 ;
    if (speed != 0 && motion[ID_item]) angleTrame += speed *tempo[ID_item] ;
    
    
    //rotation of the single shape
    if (action[ID_item]) angle = map(angle_item[ID_item], 0,360, 0, TAU) ; 
    
    //quantity
    float ratio_num = quantity_item[ID_item] *quantity_item[ID_item] ;
    int q = int(map(ratio_num, 0, 1, 2, 9)) ;
    if(FULL_RENDERING) q *= q ;

    //amp
    float amp = map(swing_x_item[ID_item],0,1, .3, width *.007) ;
    amp *= amp ;

    // axe de rotation
    // if(key_space_long) lattice = Vec3(mouse[ID_item].x +width/2,mouse[ID_item].y +height/2, mouse[ID_item].z) ;
    if(key_space_long) lattice = Vec3(mouse[ID_item]) ;
    //MODE DISPLAY
    if(mode[ID_item] == 0 || mode[ID_item] == 255) trame.drawTrameRect(lattice, angleTrame, angle, size , q, g, d, amp) ;
    else if (mode[ID_item] == 1) trame.drawTrameDisc(lattice, angleTrame, angle, size , q, g, d, amp) ;
    else if (mode[ID_item] == 2) trame.drawTrameBox(lattice, angleTrame, angle, size , q, g, d, amp) ;
    
    //INFO
    item_info[ID_item] =("Quantity " + q + " shapes / Angle " + (int)angle + " Speed " + int(speed *100) + " Amplitude " + int(amp *100)) ;
    
  }
  
}
//end object two





/////////////
//CLASS TRAME
class Trame {
  Trame(){}
  
  float nbrlgn ; 
  int vitesse ;
  
  //TRAME RECTANGLEe multiple
  void drawTrameRect (Vec3 axe, float angleTrame, float angle_item, PVector size, int nbrlgn, float gauche, float droite, float amp ) {
    pushMatrix() ;
    translate(axe.x, axe.y) ;
    // calcul the position of each object
    for (int i=1 ; i < nbrlgn ; i++) {
      for (int j=1 ; j < nbrlgn ; j++) { 
        Vec2 new_pos = pos_rotation(axe, angleTrame, i, j, nbrlgn, amp) ;      
        rectangleTrame (new_pos, size.x, size.y, gauche, droite, angle_item ) ;      
      }
    }
    popMatrix() ;  
  }
  
  
  
  
  //TRAME DISC multiple
  void drawTrameDisc (Vec3 axe, float angleTrame, float angle_item, PVector size, int nbrlgn, float gauche, float droite, float amp   ) {
    pushMatrix() ;
    translate(axe.x, axe.y) ;
    // calcul the position of each object
    for (int i=1 ; i < nbrlgn ; i++) {
      for (int j=1 ; j < nbrlgn ; j++) {
        Vec2 new_pos = pos_rotation(axe, angleTrame, i, j, nbrlgn, amp) ;
        disqueTrame (new_pos, size.x, size.y, gauche, droite, angle_item ) ;      
      }
    }
    popMatrix() ;  
  }


  
  
  //TRAME BOX
  void drawTrameBox (Vec3 axe, float angleTrame, float angle_item, PVector size, int nbrlgn, float gauche, float droite, float amp   ) {
    pushMatrix() ;
    translate(axe.x, axe.y) ;
    //calcul the position of each object
    for (int i=1 ; i < nbrlgn ; i++) {
      for (int j=1 ; j < nbrlgn ; j++) {
        Vec2 new_pos = pos_rotation(axe, angleTrame, i, j, nbrlgn, amp) ;      
        boxTrame (new_pos, size, gauche, droite, angle_item ) ;      
      }
    }
    popMatrix() ;  
  }
  
  void rectangleTrame(Vec2 pos, float h, float l, float gauche, float droite, float aObj) {
    pushMatrix() ;
    rectMode(CENTER) ;
    translate(pos.x, pos.y) ;
    rotate(aObj) ;
    rect (0, 0, pow(l,1.4), pow(h,1.4)) ;
    rectMode(CORNER) ;
    popMatrix() ;
  }
  
  void disqueTrame(Vec2 pos, float h, float l, float gauche, float droite, float aObj) {
    pushMatrix() ;
    ellipseMode(CENTER) ;
    translate(pos.x, pos.y) ;
    rotate(aObj) ;
    ellipse (0, 0, pow(l,1.4), pow(h,1.4)) ;
    ellipseMode(CORNER) ;
    popMatrix() ;
  }
  
  void boxTrame(Vec2 pos, PVector size, float gauche, float droite, float aObj) {
    pushMatrix() ;
    translate(pos.x, pos.y) ;
    rotate(aObj) ;
    box (pow(size.x,1.4), pow(size.y,1.4), pow(size.z,1.4)) ;
    popMatrix() ;
  }


  Vec2 pos_rotation(Vec3 lattice, float angle_trame, int row, int col, int num, float amp) {
    Vec2 pos = Vec2(row *width, col *height) ;
    pos.mult(amp) ;
    pos.div(num) ;
    Vec2 displacement = mult(pos, .5) ;
    pos.sub(displacement) ;

    Vec2 lattice_2D = Vec2(lattice.x, lattice.y) ;
    lattice_2D.x = map(lattice_2D.x, 0, width, -displacement.x, displacement.x) ;
    lattice_2D.y = map(lattice_2D.y, 0, height, -displacement.y, displacement.y) ;
    
    Vec2 final_pos = rotation(pos, lattice_2D, angle_trame) ;  
    return final_pos ;
  }
}