/**
BALISE || 2011 || 1.3.0
*/
Balise balise ;
//object three
class BaliseRomanesco extends Romanesco {
  int POINT_M, ELLIPSE_M, TRIANGLE_M, SQUARE_M, RECT_M = MAX_INT ;
  int STAR_4_M, STAR_5_M, STAR_7_M, STAR_9_M = MAX_INT ;
  int SUPER_STAR_8_M, SUPER_STAR_12_M = MAX_INT ;
  int TETRAHEDRON_M, BOX_M = MAX_INT ;
  int CROSS_2_M, CROSS_3_M = MAX_INT ; 
  int SPHERE_LOW_M, SPHERE_MEDIUM_M, SPHERE_HIGH_M = MAX_INT ;

  public BaliseRomanesco() {
    //from the index_objects.csv
    RPE_name = "Balise" ;
    ID_item = 14 ;
    ID_group = 1 ;
    RPE_author  = "Stan le Punk";
    RPE_version = "Version 1.3.0";
    RPE_pack = "Base" ;
    // RPE_mode = "Disc/Rectangle/Box/Box Snake" ;
    RPE_mode = "Ellipse/Triangle/Rectangle/Star 5/Super Star 12/Tetra/Box/Cross 3/Sphere low/Sphere medium" ;
    ELLIPSE_M = 0 ;
    TRIANGLE_M = 1 ;
    RECT_M = 2 ;
    STAR_5_M = 3 ;
    SUPER_STAR_12_M = 4 ;
    TETRAHEDRON_M = 5 ;
    BOX_M = 6 ;
    CROSS_3_M = 7 ;
    SPHERE_LOW_M = 8 ;
    SPHERE_MEDIUM_M = 9 ;
    RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Stroke hue,Stroke sat,Stroke bright,Stroke alpha,Thickness,Size X,Size Y,Size Z,Quantity,Speed X,Canvas X,Repulsion" ;
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
    // color and thickness
    int which_costume = which_costume(mode[ID_item]) ;
    aspect_rope(ID_item, which_costume) ;

    //amplitude
    float amp = map(swing_x_item[ID_item], 0,1, 0, width *9) ;
    
    //factor size
    float factor = map(repulsion_item[ID_item],0,1,1,100) *(allBeats(ID_item) *.2) ;
    if(factor < 1.0 ) factor = 1.0 ;

    // snake mode
    boolean snake_mode = false ;
    if(special[ID_item]) snake_mode = true ; else snake_mode = false ;

    
    

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
    balise.display(amp, var, sizeBalise, factor, int(radiusBalise), authorization, which_costume, snake_mode) ;
    
    
    objectInfo[ID_item] = ("Size "+(int)sizeBalise.x + " / " + (int)sizeBalise.y + " / " + (int)sizeBalise.z  + " Radius " + int(radiusBalise) ) ;
  }

  int which_costume(int mode) {
    int which_costume = POINT_ROPE ;
    //
    if(mode == POINT_M) {
      which_costume = POINT_ROPE ;
    } else if(mode == ELLIPSE_M) {
      which_costume = ELLIPSE_ROPE ;
    } else if(mode == TRIANGLE_M) {
      which_costume = TRIANGLE_ROPE ;
    } else if(mode == SQUARE_M) {
      which_costume = SQUARE_ROPE ;
    } else if(mode == RECT_M) {
      which_costume = RECT_ROPE ;
    } else if(mode == STAR_4_M) {
      which_costume = STAR_4_ROPE ;
    } else if(mode == STAR_5_M) {
      which_costume = STAR_5_ROPE ;
    } else if(mode == STAR_7_M) {
      which_costume = STAR_7_ROPE ;
    } else if(mode == STAR_9_M) {
      which_costume = STAR_9_ROPE ;
    } else if(mode == SUPER_STAR_8_M) {
      which_costume = SUPER_STAR_8_ROPE ;
    } else if(mode == SUPER_STAR_12_M) {
      which_costume = SUPER_STAR_12_ROPE ;
    } else if(mode == TETRAHEDRON_M) {
      which_costume = TETRAHEDRON_ROPE ;
    } else if(mode == BOX_M) {
      which_costume = BOX_ROPE ;
    } else if(mode == CROSS_2_M) {
      which_costume = CROSS_2_ROPE ;
    } else if(mode == CROSS_3_M) {
      which_costume = CROSS_3_ROPE ;
    } else if(mode == SPHERE_LOW_M) {
      which_costume = SPHERE_LOW_ROPE ;
    } else if(mode == SPHERE_MEDIUM_M) {
      which_costume = SPHERE_MEDIUM_ROPE ;
    } else if(mode == SPHERE_HIGH_M) {
      which_costume = SPHERE_HIGH_ROPE ;
    }
    //
    return which_costume ;
  }

}
//end object two







// CLASS BALISE
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