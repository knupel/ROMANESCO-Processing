/**
GALAXIE – 2012-2016 – 1.4.1
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
    RPE_name = "Galaxie" ;
    ID_item = 19 ;
    ID_group = 1 ;
    RPE_author  = "Stan le Punk";
    RPE_version = "Version 1.4.1";
    RPE_pack = "Base" ;
    // RPE_mode ="Point/Ellipse/Rectangle/Box" ;
    RPE_mode = "Point/Ellipse/Triangle/Rectangle/Cross/Star 5/Star 7/Super Star 8/Super Star 12" ;
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

    RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Stroke hue,Stroke sat,Stroke bright,Stroke alpha,Thickness,Size X,Size Y,Size Z,Canvas X,Canvas Y,Quantity,Speed X,Influence" ;
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
    PVector marge = new PVector(map(canvas_x_item[ID_item],width/10, width, width/20, width*10), map(canvas_y_item[ID_item],width/10, width, height/20, height*10), map(canvas_z_item[ID_item], width/10, width, width/10, width *10))  ;
    PVector surface = new PVector(marge.x *2 +width, marge.y *2 +height) ;
    
    //quantity of star
    float max = 1500 ;
    float min = 300 ;
    if(!FULL_RENDERING ) {
      min = 30 ;
      max = 150 ;
    }
    float quantity = map(quantity_item[ID_item],0,1,min,max) ;
    if (mode[ID_item] == 0 ) numFromController = int(quantity *10) ; else numFromController = int(quantity) ;
    

    if ((numGrains != numFromController && parameterButton[ID_item] == 1) || reset(ID_item) ) makeSand = true ;
    
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
     speedDust = map(speed_x_item[ID_item],0,1, 0.00005 ,.5) ; 
     if(sound[ID_item]) speedDust *= 3 ;
        
    vitesseGrainA = map(left[ID_item],0,1, 1, 17) ;
    vitesseGrainB = map(right[ID_item],0,1, 1, 17) ;
    

    
    vitesseGrain.x = vitesseGrainA *speedDust *tempo[ID_item] *pressionGrain  ;
    vitesseGrain.y = vitesseGrainB *speedDust *tempo[ID_item] *pressionGrain  ;
    if(reverse[ID_item]) {
      vitesseGrain.x = vitesseGrain.x *1 ; 
      vitesseGrain.y = vitesseGrain.y *1 ; 
    } else {
      vitesseGrain.x = vitesseGrain.x *-1 ;
      vitesseGrain.y = vitesseGrain.y *-1 ;
    }
    
    // force
    int maxInfluence = 11 ;
    variableRayonGrain = map(influence_item[ID_item], 0,1, 0, maxInfluence ) ;
    
    //size
    float objWidth =  .1 +size_x_item[ID_item] *mix[ID_item] ;
    float objHeight = .1 +size_y_item[ID_item] *mix[ID_item] ;
    float objDepth = .1 +size_z_item[ID_item] *mix[ID_item] ;
    Vec3 size = Vec3(objWidth, objHeight,objDepth) ;
    
    //thickness / épaisseur
    float thickness = thickness_item[ID_item] ;

    int colorIn = fill_item[ID_item] ;
    int colorOut = stroke_item[ID_item] ;
    

    
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
    if(motion[ID_item]) if (speed_x_item[ID_item] >= 0.01) updateGrain(upTouch, downTouch, leftTouch, rightTouch, clickLongLeft[ID_item], marge);
    
    //////////////
    //DISPLAY MODE
    // int which_costume = which_costume(mode[ID_item]) ;
    select_costume(ID_item, RPE_name) ;
    aspect_rope(fill_item[ID_item], stroke_item[ID_item], thickness_item[ID_item], costume[ID_item]) ;
    show(size, thickness, costume[ID_item]) ;
    
   
    
    
    // INFO DISPLAY
    objectInfo[ID_item] =("Quantity " +numGrains + " - Canvas " + (int)surface.x + "x" + (int)surface.y + " - Center Galaxy " + int(posCenterGrain.x +marge.x) + "x" + int(posCenterGrain.y +marge.y) + " - speed" +int(speedDust *200.)) ;
    if (objectInfoDisplay[ID_item]) {
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
  
  
  
    
    
  
  
  
  
  
  
  //ANNEXE VOID
  //DISPLAY MODE

  void show(Vec3 size, float thickness, int which_costume) {
    float z_pos = 0 ;
    float ratio = .001 ;
    for(int i = 0; i < grain.length; i++) {
      // ratio is used to don't have "moirage" problem
      z_pos += ratio ;
      Vec3 pos = Vec3(grain[i].x, grain[i].y, z_pos) ;
      costume_rope(pos, size, which_costume) ;

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