class Galaxie extends SuperRomanesco {
  public Galaxie() {
    //from the index_objects.csv
    romanescoName = "Galaxie" ;
    IDobj = 15 ;
    IDgroup = 2 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Version 1.2";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
    romanescoMode ="Point/Ellipse/Rectangle" ;
    romanescoSlider = "Hue fill,Saturation fill,Brightness fill,Alpha fill,Hue stroke,Saturation stroke,Brightness stroke,Alpha stroke,Thickness,Width,Height,Canvas X,Canvas Y,Quantity,Speed,Force" ;
  }
  //GLOBAL
    boolean makeSand = true ;
  boolean shiftGrain = false ;
  boolean gravityGrain = true ;
  PVector posCenterGrain = new PVector(0,0,0) ;

  PVector orientationStyletGrain ;

  int numGrains ;
  int numFromControler ;
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
  void setting() {
    startPosition(IDobj, 0, 0, 0) ;
  }
  //DRAW
  void display() {
    
    //surface
    PVector marge = new PVector(map(canvasXObj[IDobj],width/10, width, width/20, width*10), map(canvasYObj[IDobj],width/10, width, height/20, height*10), map(canvasZObj[IDobj], width/10, width, width/10, width *10))  ;
    PVector surface = new PVector(marge.x *2 +width, marge.y *2 +height) ;
    
    //quantity of star
    if (mode[IDobj] == 0 ) numFromControler = int(9*(sq(quantityObj[IDobj])) ) ; else numFromControler = 30 + int(25 *quantityObj[IDobj]) ;
    if(fullRendering ) {
      if (mode[IDobj] == 0 ) numFromControler = int(9*(sq(quantityObj[IDobj])) ) ; else numFromControler = 30 + int(25 *quantityObj[IDobj]) ;
    } else {
      if (mode[IDobj] == 0 ) numFromControler = int(9*quantityObj[IDobj]) ; else numFromControler = 30 + int(quantityObj[IDobj]) ;
    }
    
    if ((numGrains != numFromControler && parameterButton[IDobj] == 1) || resetAction(IDobj) ) makeSand = true ;
    
    if (makeSand) {
      numGrains = numFromControler ;
      grainSetup(numGrains, marge) ;
      makeSand = false ;
    }
 
    //give back the pen info
    float pressionGrain = sq(1 + pen[IDobj].z) ;
    orientationStyletGrain = new PVector ( pen[IDobj].x *10.0 , pen[IDobj].y *10.0 ) ;
    deformationGrain = orientationStyletGrain.copy() ; ;
    
    // speed / vitesse
    vitesseGrainA = map(left[IDobj],0,1, 1, 17) ;
    vitesseGrainB = map(right[IDobj],0,1, 1, 17) ;
    
    if(motion[IDobj]) speedDust = map(speedObj[IDobj],0,1, 0.00005 ,0.5) ; else speedDust = 0.00001 ;
    
    vitesseGrain.x = vitesseGrainA *speedDust *tempo[IDobj] *pressionGrain  ;
    vitesseGrain.y = vitesseGrainB *speedDust *tempo[IDobj] *pressionGrain  ;
    if(reverse[IDobj]) {
      vitesseGrain.x = vitesseGrain.x *1 ; 
      vitesseGrain.y = vitesseGrain.y *1 ; 
    } else {
      vitesseGrain.x = vitesseGrain.x *-1 ;
      vitesseGrain.y = vitesseGrain.y *-1 ;
    }
    
    //force
    float amplitude = 11 ;
    variableRayonGrain = map(forceObj[IDobj], 0,1, 0, amplitude ) ; //<>// //<>//
    


    
    

    
    //size
    float objWidth =  .1 +sizeXObj[IDobj] *mix[IDobj] ;
    float objHeight = .1 +sizeYObj[IDobj] *mix[IDobj] ;
    PVector size = new PVector(objWidth, objHeight) ;
    
    //thickness / épaisseur
    float e = thicknessObj[IDobj] ;

    color colorIn = fillObj[IDobj] ;
    color colorOut = strokeObj[IDobj] ;
    

    
    // Axe rotation
    posCenterGrain = mouse[IDobj].copy() ;
    //ratio transformation du canvas
    float ratioX = surface.x / float(width) ;
    float ratioY = surface.y / float(height) ;
    
    PVector newPosCenterGrain = new PVector() ;
    newPosCenterGrain.x = posCenterGrain.x *ratioX -marge.x ;
    newPosCenterGrain.y = posCenterGrain.y *ratioY -marge.y ;
    // copy the final result
    posCenterGrain = newPosCenterGrain.copy() ;
    
    /////////
    //UPDATE
    updateGrain(upTouch, downTouch, leftTouch, rightTouch, clickLongLeft[IDobj], marge);
    
    //////////////
    //DISPLAY MODE
    if (mode[IDobj] == 0) {
      pointSable(e, colorIn) ;
    } else if (mode[IDobj] == 1 ) {
      ellipseSable(size,e , colorIn, colorOut) ;
    } else if (mode[IDobj] == 2 ) {
      rectSable(size,e , colorIn, colorOut) ;
    } else {
      pointSable(objWidth, colorIn) ;
    }
    
   
    
    
    // INFO DISPLAY
    objectInfo[IDobj] =("Quantity " +numGrains + " - Canvas " + (int)surface.x + "x" + (int)surface.y + " - Center Galaxy " + int(posCenterGrain.x +marge.x) + "x" + int(posCenterGrain.y +marge.y) + " - speed" +int(speedDust *200.)) ;
    // objectInfo[IDobj] =("Quantity " +numGrains + " - Canvas " + (int)surface.x + "x" + (int)surface.y + " - Center Galaxy " + int(posCenterGrain.x +(posCenterGrain.x *.5)) + "x" + int(posCenterGrain.y +(posCenterGrain.y *.5)) ) ;
    if (objectInfoDisplay[IDobj] && prescene) {
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
  void pointSable(float diam, color c) {
    for(int j = 0; j < grain.length; j++) {
      strokeWeight(diam) ;
      stroke(c) ;
      point(grain[j].x, grain[j].y);
      //set(int(grain[j].x), int(grain[j].y), colorIn);
    }
  }
  //
  void ellipseSable(PVector size, float e, color cIn, color cOut) {
    for(int j = 0; j < grain.length; j++) {
      strokeWeight(e) ;
      stroke(cOut) ;
      fill(cIn) ;
      ellipse(grain[j].x, grain[j].y, size.x, size.y);
      //set(int(grain[j].x), int(grain[j].y), colorIn);
    }
  }
  //
  void rectSable(PVector size, float e, color cIn, color cOut) {
    for(int j = 0; j < grain.length; j++) {
      strokeWeight(e) ;
      stroke(cOut) ;
      fill(cIn) ;
      rect(grain[j].x, grain[j].y, size.x, size.y);
      //set(int(grain[j].x), int(grain[j].y), colorIn);
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
      
      motionGrain.x = grain[i].x -posCenterGrain.x -(deformationGrain.x +right[IDobj]) +variableRayonGrain ;
      motionGrain.y = grain[i].y -posCenterGrain.y -(deformationGrain.y +left[IDobj] ) +variableRayonGrain ;
  
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
