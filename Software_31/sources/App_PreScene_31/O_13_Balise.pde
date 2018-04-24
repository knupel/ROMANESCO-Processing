/**
BALISE || 2011 || 1.3.1
*/
Balise balise ;
//object three
class BaliseRomanesco extends Romanesco {
  public BaliseRomanesco() {
    //from the index_objects.csv
    item_name = "Balise" ;
    ID_item = 13 ;
    ID_group = 1 ;
    item_author  = "Stan le Punk";
    item_version = "Version 1.3.1";
    item_pack = "Base" ;
    // item_mode = "Disc/Rectangle/Box/Box Snake" ;
    item_mode = "Point/Ellipse/Triangle/Rectangle/Cross/Star 5/Star 7/Super Star 8/Super Star 12" ;

    // item_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Stroke hue,Stroke sat,Stroke bright,Stroke alpha,Thickness,Size X,Size Y,Size Z,Quantity,Speed X,Canvas X,Repulsion" ;
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
    canvas_x_is = true;
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
    swing_x_is = false;
    swing_y_is = false;
    swing_z_is = false;

    num_is = true;
    variety_is = false;
    life_is = false;
    flow_is = false;
    quality_is = false;
    area_is = false;
    angle_is = false;
    scope_is = false;
    scan_is = false;
    align_is = false;
    repulsion_is = true;
    attraction_is = false;
    density_is = false;
    influence_is = false;
    calm_is = false;
    spectrum_is = false;
  }
  //GLOBAL
  float speed ;
  boolean change_rotation_direction ;
  //SETUP
  void setup() {
    setting_start_position(ID_item, width/2, height/2, 0) ;
    balise = new Balise() ;
  }
  //DRAW
  void draw() {
    // authorization to make something with the sound in Prescene mode
    boolean authorization = false ;
    float tempo_balise = 1 ;
    if(sound[ID_item] && FULL_RENDERING) {
      authorization = true ;
      tempo_balise = tempo[ID_item] ;
    } else {
      tempo_balise = 1. ;
    }

    //reverse
    int rotation_direction = 1 ;
    if(reverse[ID_item]) rotation_direction = 1 ; else rotation_direction = -1 ;



    if (motion[ID_item]) speed = (map(speed_x_item[ID_item], 0,1, 0,20)) *tempo_balise *rotation_direction ; else speed = 0.0 ;

    // costume
    select_costume(ID_item, item_name) ;
    // aspect
    //aspect_rope(fill_item[ID_item], stroke_item[ID_item], thickness_item[ID_item], costume[ID_item]) ;

    //amplitude
    float amp = map(swing_x_item[ID_item], 0,1, 0, width *9) ;
    
    //factor size
    float factor = map(repulsion_item[ID_item],0,1,1,100) *(allBeats(ID_item) *.2) ;
    if(factor < 1.0 ) factor = 1.0 ;

    // snake mode
    boolean snake_mode = false ;
    if(special[ID_item]) snake_mode = true ; else snake_mode = false ;

    // aspect
    aspect_rope(fill_item[ID_item], stroke_item[ID_item], thickness_item[ID_item], costume[ID_item]) ;

    
    

    // SIZE
    float factorBeat = .5 ;
    float tempoEffect = 1 + ((beat[ID_item] *factorBeat) + (kick[ID_item] *factorBeat) + (snare[ID_item] *factorBeat) + (hat[ID_item] *factorBeat));
    PVector sizeBalise = new PVector(size_x_item[ID_item],size_y_item[ID_item],size_z_item[ID_item]) ;
    PVector var = new PVector(1,1) ;
    if(authorization) {
      sizeBalise  = new PVector (size_x_item[ID_item] *tempoEffect, size_y_item[ID_item] *tempoEffect, size_z_item[ID_item] ) ;
      // variable position
      var = new PVector(left[ID_item] *5,right[ID_item] *5) ;
    }
    
    if(var.x <= 0 ) var.x = .1 ; 
    if(var.y <= 0 ) var.y = .1 ; 
    //quantity
    int maxBalise = 511 ;
    if(!FULL_RENDERING) maxBalise = 64 ;
    float radiusBalise = map(quantity_item[ID_item], 0,1, 2, maxBalise); // here the value max is 511 because we work with buffersize with 512 field
    
    Vec3 pos = Vec3() ;
    balise.update(pos, speed) ;
    balise.display(amp, var, sizeBalise, factor, int(radiusBalise), authorization, costume[ID_item], snake_mode) ;
    
    
    objectInfo[ID_item] = ("Size "+(int)sizeBalise.x + " / " + (int)sizeBalise.y + " / " + (int)sizeBalise.z  + " Radius " + int(radiusBalise) ) ;
  }
}
//end object two






/**
CLASS BALISE
*/
class Balise extends Rotation {  
  
  Balise () { 
    super () ; 
  }
  
  void display (float amp, PVector var, PVector sizeBalise, float factor, int max, boolean authorization, int which_costume, boolean snake_mode) {
    pushMatrix() ;
    rectMode(CENTER) ;
    
    if ( max > 512 ) max = 512 ;

    for(int i = 0 ; i < max ; i++) {
      PVector v = new PVector(input(i,max,var,authorization).x, input(i,max,var,authorization).y) ;
      Vec2 pos = Vec2(amp *v.x, amp *v.y) ;
      // v = new PVector (abs(v.x *factor), abs(v.y *factor) ) ;
      v.set(abs(v.x *factor), abs(v.y *factor) ) ;

      Vec3 size = Vec3(sizeBalise.x *v.x, sizeBalise.y *v.y, sizeBalise.z *((v.x +v.y)*.5))   ;
      if(snake_mode) {
        start_matrix() ;
        translate(pos) ;
      }
      costume_rope(pos, size, which_costume) ;
      if(snake_mode) {
        stop_matrix() ;
      }
       /*
      }
      if (mode == 0 ) ellipse(posBalise.x, posBalise.y, newSize.x, newSize.y) ;
      if (mode == 1 ) rect   (posBalise.x, posBalise.y, newSize.x, newSize.y) ;
      */
      /*
      if (mode == 2 ) snake_mode(posBalise, newSize, true) ;
      if (mode == 3 ) snake_mode(posBalise, newSize, false) ;
      */
    }
    rectMode(CORNER) ;
    popMatrix() ;
    noStroke() ;
  }
  
  /*
  void snake_mode(PVector pos, PVector size, boolean snake) {
    if(snake) pushMatrix() ;
    translate(pos.x, pos.y, pos.z) ;
    box(size.x, size.y, size.z) ;
    if(snake) popMatrix() ;
  }
  */
  
  //calculate and return the position for each brick of the balise
  PVector input( int whichOne, int max, PVector var, boolean authorization) {
    PVector value = new PVector(1,1,1) ;
    if(authorization) {
      value = new PVector ((input.left.get(whichOne)*var.x), (input.right.get(whichOne)*var.y) ) ; 
    } else {
      float n = (float)whichOne ;
      n = n - (max/2) ;
      value = new PVector ( n*var.x *.01, n*var.y *.01 ) ; 
    } 
    return value ;
  }
}