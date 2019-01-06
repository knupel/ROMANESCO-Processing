/**
GALAXIE
2012-2018
V 1.5.2
*/

class Galaxie extends Romanesco {
  int POINT_M, ELLIPSE_M, TRIANGLE_M, SQUARE_M, RECT_M = MAX_INT ;
  int STAR_4_M, STAR_5_M, STAR_7_M, STAR_9_M = MAX_INT ;
  int SUPER_STAR_8_M, SUPER_STAR_12_M = MAX_INT ;
  int TETRAHEDRON_M, BOX_M = MAX_INT ;
  int CROSS_2_M, CROSS_3_M = MAX_INT ; 
  int SPHERE_LOW_M, SPHERE_MEDIUM_M, SPHERE_HIGH_M = MAX_INT ;

  public Galaxie() {
    //from the index_objects.csv
    item_name = "Galaxie" ;
    item_author  = "Stan le Punk";
    item_version = "Version 1.5.2";
    item_pack = "Base 2012-2018" ;
    // item_mode ="Point/Ellipse/Rectangle/Box" ;
    item_costume = "Point/Ellipse/Triangle/Rectangle/Cross/Star 5/Star 7/Super Star 8/Super Star 12" ;
    item_mode = "" ;
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

    //item_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Stroke hue,Stroke sat,Stroke bright,Stroke alpha,Thickness,Size X,Size Y,Size Z,Canvas X,Canvas Y,Quantity,Speed X,Influence" ;
    hue_fill_is = true;
    sat_fill_is = true;
    bright_fill_is = true;
    alpha_fill_is = true;
    hue_stroke_is = true;
    sat_stroke_is  = true;
    bright_stroke_is = true;
    alpha_stroke_is = true;
    thickness_is = true;
    size_x_is = true;
    size_y_is = true;
    size_z_is = true;
    //diameter_is = true;
    canvas_x_is = true;
    canvas_y_is = true;
    //canvas_z_is = true;

    // frequence_is = true;
    speed_x_is = true;
    // speed_y_is = true;
    // speed_z_is = true;
    // spurt_x_is = true;
    // spurt_y_is = true;
    // spurt_z_is = true;
    // dir_x_is = true;
    // dir_y_is = true;
    // dir_z_is = true;
    // jit_x_is = true;
    // jit_y_is = true;
    // jit_z_is = true;
    // swing_x_is = true;
    // swing_y_is = true;
    // swing_z_is = true;

    quantity_is = true;
    // variety_is = true;
    // life_is = true;
    // flow_is = true;
    // quality_is = true;
    area_is = true;
    // angle_is = true;
    // scope_is = true;
    // scan_is = true;
    // align_is = true;
    // repulsion_is = true;
    // attraction_is = true;
    // density_is = true;
    influence_is = true;
    // calm_is = true;
    // spectrum_is = true;
  }
  //GLOBAL
  boolean makeSand = true ;
  boolean shiftGrain = false ;
  boolean gravityGrain = true ;
  Vec3 posCenterGrain = Vec3();

  PVector orientationStyletGrain ;

  int numGrains ;
  int numFromController ;
  PVector [] grain ;
  float vitesseGrainA = 0.0;
  float vitesseGrainB = 0.0 ;
  PVector vitesseGrain = new PVector (0,0) ;
  float speedDust ;
  //vibration
  float vibrationGrain = 0.1 ;
  //the stream of sand
  PVector deformationGrain = new PVector () ;

  PVector motionGrain = new PVector () ;
  //float newRayonGrain = 1 ;
  float variableRayonGrain = -0.001 ;
  //float variableRayonGrain = -0.1 ;
  
  
  //SETUP
  void setup() {
    setting_start_position(ID_item, 0, 0, 0) ;
  }
  //DRAW
  void draw() {
    
    //surface
    PVector marge = new PVector(map(get_canvas_x(),width/10, width, width/20, width*10), map(get_canvas_y(),width/10, width, height/20, height*10), map(get_canvas_z(), width/10, width, width/10, width *10))  ;
    PVector surface = new PVector(marge.x *2 +width, marge.y *2 +height) ;
    
    //quantity of star
    float max = 1500 ;
    float min = 300 ;
    if(!FULL_RENDERING ) {
      min = 30 ;
      max = 150 ;
    }
    float quantity = map(get_quantity(),0,1,min,max) ;
    if (get_costume().get_type() == POINT_ROPE) {
      numFromController = int(quantity *10); 
    } else {
      numFromController = int(quantity);
    }
    

    if ((numGrains != numFromController && parameter_is()) || reset(this) ) {
      makeSand = true;
    }
    
    if (makeSand) {
      numGrains = numFromController ;
      grainSetup(numGrains, marge) ;
      makeSand = false ;
    }
 
    //give back the pen info
    float pressionGrain = sq(1 + pen[ID_item].z) ;
    orientationStyletGrain = new PVector ( pen[ID_item].x *10.0 , pen[ID_item].y *10.0 ) ;
    deformationGrain = orientationStyletGrain.copy() ; ;
    
    // speed / vitesse
     speedDust = map(get_speed_x(),0,1, 0.00005 ,.5) ; 
     if(sound_is()) speedDust *= 3 ;
        
    vitesseGrainA = map(left[ID_item],0,1, 1, 17) ;
    vitesseGrainB = map(right[ID_item],0,1, 1, 17) ;
    

    
    vitesseGrain.x = vitesseGrainA *speedDust *tempo[ID_item] *pressionGrain  ;
    vitesseGrain.y = vitesseGrainB *speedDust *tempo[ID_item] *pressionGrain  ;
    if(reverse_is()) {
      vitesseGrain.x = vitesseGrain.x *1 ; 
      vitesseGrain.y = vitesseGrain.y *1 ; 
    } else {
      vitesseGrain.x = vitesseGrain.x *-1 ;
      vitesseGrain.y = vitesseGrain.y *-1 ;
    }
    
    // force
    int maxInfluence = 11 ;
    variableRayonGrain = map(get_influence(), 0,1, 0, maxInfluence ) ;
    
    //size
    float objWidth =  .1 +get_size_x() *mix[ID_item] ;
    float objHeight = .1 +get_size_y() *mix[ID_item] ;
    float objDepth = .1 +get_size_z() *mix[ID_item] ;
    Vec3 size = Vec3(objWidth, objHeight,objDepth) ;
    
    //thickness / épaisseur
    float thickness = get_thickness() ;

    int colorIn = get_fill() ;
    int colorOut = get_stroke() ;
    

    
    // Axe rotation
    posCenterGrain.set(mouse[ID_item]) ;
    //ratio transformation du canvas
    float ratioX = surface.x / float(width) ;
    float ratioY = surface.y / float(height) ;
    
    Vec3 newPosCenterGrain = Vec3() ;
    newPosCenterGrain.x = posCenterGrain.x *ratioX -marge.x ;
    newPosCenterGrain.y = posCenterGrain.y *ratioY -marge.y ;
    // copy the final result
    posCenterGrain.set(newPosCenterGrain) ;
    
    /////////
    //UPDATE
    if(motion_is()) if (get_speed_x() >= 0.01) updateGrain(key_up, key_down, key_left, key_right, clickLongLeft[ID_item], marge);
    
    //////////////
    //DISPLAY MODE
    // select_costume();

    
    // aspect(get_fill(), get_stroke(), get_thickness(), get_costume()) ;
    show(size, thickness,ID_item);
    
   
    
    
    // INFO DISPLAY
    item_info[ID_item] =("Quantity " +numGrains + " - Canvas " + (int)surface.x + "x" + (int)surface.y + " - Center Galaxy " + int(posCenterGrain.x +marge.x) + "x" + int(posCenterGrain.y +marge.y) + " - speed" +int(speedDust *200.)) ;
    if (item_info_display[ID_item]) {
      strokeWeight(1) ;
      stroke(blanc) ;
      noFill() ;
      text("Galaxy center", posCenterGrain.x +5, posCenterGrain.y -5) ; 
      line(-marge.x,       posCenterGrain.y, width +marge.x, posCenterGrain.y ) ;
      line(posCenterGrain.x, -marge.y,       posCenterGrain.x, marge.y +height ) ;
      
      rect(-marge.x, -marge.y, marge.x *2 + width, marge.y *2 + height) ;
    }   

  }
  // END DISPLAY


  
  
  
    
    
  
  
  
  
  
  
  //ANNEXE VOID
  //DISPLAY MODE

  void show(Vec3 size, float thickness, int ID) {
    float z_pos = 0 ;
    float ratio = .001 ;
    
    for(int i = 0; i < grain.length; i++) {
      // ratio is used to don't have "moirage" problem
      z_pos += ratio ;
      Vec3 pos = Vec3(grain[i].x, grain[i].y, z_pos) ;
      aspect(get_fill(),get_stroke(), get_thickness());
      set_ratio_costume_size(map(get_area(),width*.1, width*TAU*4,0,1));
      costume(pos,size,get_costume()) ;

    }
  }

  //SETUP
  void grainSetup(int num, PVector marge) {
    grain = new PVector [num] ;
    for(int i = 0; i < num ; i++) {
      grain[i] = new PVector (random(-marge.x, width +marge.x), random(-marge.y, height +marge.y)) ;
    }
    makeSand = true ;
  }
    
    
  //void update  
  void updateGrain(boolean up, boolean down, boolean leftSide, boolean rightSide, boolean mouseClic, PVector area) {
    
    for(int i = 0; i < grain.length; i++) {
      // newRayonGrain = newRayonGrain -variableRayonGrain ;
      
      motionGrain.x = grain[i].x -posCenterGrain.x -(deformationGrain.x +right[ID_item]) +variableRayonGrain ;
      motionGrain.y = grain[i].y -posCenterGrain.y -(deformationGrain.y +left[ID_item] ) +variableRayonGrain ;
  
      PVector posGrain = new PVector () ;
      float r = dist(grain[i].x/vitesseGrain.x, grain[i].y /vitesseGrain.x, int(posCenterGrain.x) /vitesseGrain.x, int(posCenterGrain.y) /vitesseGrain.x);
      
      //spiral rotation
      if (mouseClic) {
        posGrain.x = cos(-1/r*vitesseGrain.y)*motionGrain.x - ( sin(-1/r*vitesseGrain.y)*motionGrain.y );
        posGrain.y = sin(-1/r*vitesseGrain.y)*motionGrain.x + ( cos(-1/r*vitesseGrain.y)*motionGrain.y );
      } else {
        posGrain.x = cos(1/r*vitesseGrain.y)*motionGrain.x - ( sin(1/r*vitesseGrain.y)*motionGrain.y );
        posGrain.y = sin(1/r*vitesseGrain.y)*motionGrain.x + ( cos(1/r*vitesseGrain.y)*motionGrain.y );
      }
      
      // to make line veticale or horizontal
      if (rightSide || leftSide  ) {
        posGrain.x = cos(1/r*vitesseGrain.y)*motionGrain.x ;
        posGrain.y = sin(1/r*vitesseGrain.y)*motionGrain.x ;
      } else if (down || up) {
        posGrain.x = sin(-1/r*vitesseGrain.y)*motionGrain.y ;
        posGrain.y = cos(-1/r*vitesseGrain.y)*motionGrain.y ;
      }

      
      //the dot follow the mouse  
      posGrain.x += posCenterGrain.x;
      posGrain.y += posCenterGrain.y;
      
      PVector vibGrain = new PVector(random(-vibrationGrain,vibrationGrain), random(-vibrationGrain,vibrationGrain), random(-vibrationGrain,vibrationGrain) ) ; 
      //return pos of the pixel
      grain[i].x = posGrain.x + vibGrain.x;
      grain[i].y = posGrain.y + vibGrain.y;
      
      // wall to move the pos to one border to other
      //marge around the scene
      float margeWidth = area.x ;
      float margeHeight = area.y ;
      if(grain[i].x > width +margeWidth) grain[i].x = -margeWidth;
      if(grain[i].x < -margeWidth)     grain[i].x = width +margeWidth;
      if(grain[i].y > height + margeHeight) grain[i].y = -margeHeight;
      if(grain[i].y < -margeHeight)     grain[i].y = height +margeHeight;
    }
  }
}