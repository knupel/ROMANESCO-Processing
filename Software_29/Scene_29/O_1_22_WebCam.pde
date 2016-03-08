/**
WEBCAM 1.2.2
*/
class Webcam extends Romanesco {
  public Webcam() {
    //from the index_objects.csv
    romanescoName = "Webcam" ;
    IDobj = 22 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Version 1.2.2";
    romanescoPack = "Base" ;
    romanescoMode = "Rectangle color/Rectangle mono/Point color/Point mono/Box color/Box mono" ;
    romanescoSlider = "Hue fill,Saturation fill,Brightness fill,Alpha fill,Size X,Size Y,Size Z,Canvas X,Canvas Y" ;
  }
  //GLOBAL
  int cameraStatut = 0 ;



  
  PVector factorDisplayCam = new PVector (0,0) ;
  PVector factorDisplayPixel = new PVector (0,0) ;
  // PVector factorCalcul = new PVector (0,0) ;
  
  color colorPixelCam ;
  
  int cellSizeX, cellSizeY, posPixelX, posPixelY   ;
  int cols ;
  int rows ; 
  
  
  //SETUP
  void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
  }
  //DRAW
  void display() {
    //PART ONE
    //calcul the ration between the size of camera and the size of the scene
    factorDisplayCam.x = width / CAM_SIZE.x ; 
    factorDisplayCam.y = height / CAM_SIZE.y ;
    
    // size
    float minVal = 0.1 ;
    float maxVal = height / 50 ;
    float size_x = map(sizeXObj[IDobj],0.1,width, minVal, maxVal) *snare[IDobj] ;
    float size_y = map(sizeYObj[IDobj],0.1,width, minVal, maxVal) *kick[IDobj] ;
    float size_z = map(sizeZObj[IDobj],0.1,width, minVal, maxVal) *hat[IDobj] ;
    PVector factorSizePix = new PVector(size_x, size_y, size_z) ; 
    factorDisplayPixel = new PVector(factorDisplayCam.x *factorSizePix.x , factorDisplayCam.y *factorSizePix.y, factorSizePix.z) ;//PARAMETER THAT YOU CAN USE
    
    //PART TWO

    if(fullRendering) {
      cellSizeX = int(map(canvasYObj[IDobj],width/10, width, 50, 1))  ; 
      cellSizeY = int(map(canvasXObj[IDobj],width/10, width, 50, 1))  ;
    } else {
      cellSizeX = int(map(canvasYObj[IDobj],width/10, width, 50, 20))  ; 
      cellSizeY = int(map(canvasXObj[IDobj],width/10, width, 50, 20))  ;
    }
    if(cellSizeX < 1 ) cellSizeX = 1 ;
    if(cellSizeY < 1 ) cellSizeY = 1 ;
    
    cols = (int)CAM_SIZE.x / cellSizeX; // before the resizing
    rows = (int)CAM_SIZE.y / cellSizeY;
    if (cam.available()) {
      cam.loadPixels();
      for (int i = 0; i < cols ; i++) {
        for (int j = 0; j < rows  ; j++) {
          // Where are we, pixel-wise?
          posPixelX = i *cellSizeX  ;
          posPixelY = j *cellSizeY  ;
          //// display pixel 
          int  loc = posPixelX  +posPixelY *cam.width; // classic
          //  int loc = (cam.width - x - 1) + y*cam.width; // mirror
          //make pixel
          PVector hsb = new PVector (hue(cam.pixels[loc]), saturation(cam.pixels[loc]), brightness(cam.pixels[loc]) ) ;

          
          // Make a new color with an alpha component
          displayPix(mode[IDobj],hsb) ; 
        }
      } 
    } else {
      fill(fillObj[IDobj]) ;
      textSize(sizeXObj[IDobj]/10) ;
      text("Big Brother stops watching you, you're so boring !",0,0) ;
    }
    

    
    rectMode (CORNER) ; 
    ////////////////////

  }
  
  
  
  
  
  
  //annexe

  
  
  void displayPix(int mode, PVector hsb) {
    //DISPLAY
    pushMatrix() ;
    //P3D Give the position and the orientation of your object in the 3 dimensionals space
    PVector newDisplay = new PVector  (cellSizeX *factorDisplayCam.x,   cellSizeY *factorDisplayCam.y) ;
    
    float newCellSizeX = cellSizeX *factorDisplayPixel.x *left[IDobj] ;
    float newCellSizeY = cellSizeY *factorDisplayPixel.y *right[IDobj] ;
    float factorSizeZ = map(sizeZObj[IDobj], .1, width, .01, height/100) ;
    PVector newCellSize = new PVector (newCellSizeX, newCellSizeY, factorSizeZ ) ;
    //init the position of image on the middle of the screen
    PVector posMouseCam = new PVector ( width / 2, height /2) ;
    if (mouse[IDobj].x >= -startingPosition[IDobj].x && mouse[IDobj].y >= -startingPosition[IDobj].y) posMouseCam = mouse[IDobj] ;
    //create the ratio for the translate position in functiun of the size of the Scene, not really good algorythm
    float ratioDisplay = (float)width / (float)height ;
    float factorDisplacementRatioSizeOfTheDisplay = map(width, 0, 2000, .6, .2 ) ;
    float factorTranslateX = factorDisplacementRatioSizeOfTheDisplay / ratioDisplay ;
    float factorTranslateY = factorDisplacementRatioSizeOfTheDisplay ;

    //finalization of the position
    float finalPosPixelX = ( (posPixelX +newDisplay.x *factorTranslateX) *factorDisplayCam.x) + posMouseCam.x - width *0.5 ;
    float finalPosPixelY = ( (posPixelY +newDisplay.y *factorTranslateY) *factorDisplayCam.y) + posMouseCam.y - height*0.5 ;
    PVector pos = new PVector (finalPosPixelX, finalPosPixelY, 0);
    //translate(finalPosPixelX, finalPosPixelY, finalPosPixelZ);
               
    rectMode(CENTER) ;
    
    if(mode == 0 ) rectangleColour(pos, newCellSize, hsb) ;
    if(mode == 1 ) rectangleMonochrome(pos, newCellSize, hsb) ;
    if(mode == 2 ) pointColour(pos, newCellSize, hsb) ;
    if(mode == 3 ) pointMonochrome(pos, newCellSize, hsb) ;
    if(mode == 4 ) boxColour(pos, newCellSize, hsb) ;
    if(mode == 5 ) boxMonochrome(pos, newCellSize, hsb) ;
    //
    popMatrix() ;
  }
  
  
  
  
  
  
  // different mode
  void rectangleMonochrome(PVector pos, PVector size, PVector hsb) {
    size = checkSize(size).copy() ;
    translate(pos.x, pos.y, pos.z);
    monochrome(hsb) ;
    fill(colorPixelCam) ;
    noStroke() ;
    antiBugFillBlack(colorPixelCam) ;
    rect (0,0, size.x, size.y) ;
  }
  //
  void rectangleColour(PVector pos, PVector size, PVector hsb) {
    size = checkSize(size).copy() ;
    translate(pos.x, pos.y, pos.z);
    colour(hsb) ;
    fill(colorPixelCam) ;
    noStroke() ;
    antiBugFillBlack(colorPixelCam) ;
    rect (0,0, size.x, size.y) ;
  }
  //
  void pointMonochrome(PVector pos, PVector size, PVector hsb) {
    size = checkSize(size).copy() ;
    translate(pos.x, pos.y, pos.z);
    monochrome(hsb) ;
    stroke(colorPixelCam) ;
    strokeWeight(size.x) ;
    antiBugFillBlack(colorPixelCam) ;
    point(0,0,0) ;
  }
  //
  void pointColour(PVector pos, PVector size, PVector hsb) {
    size = checkSize(size).copy() ;
    translate(pos.x, pos.y, pos.z);
    colour(hsb) ;
    stroke(colorPixelCam) ;
    strokeWeight(size.x) ;
    antiBugFillBlack(colorPixelCam) ;
    point(0,0,0)  ;
  }
  //
  void boxMonochrome(PVector pos, PVector size, PVector hsb) {
    float depth = (hsb.z +.05) *size.z ;
    if(horizon[IDobj]) translate(pos.x, pos.y, depth *.5); else translate(pos.x, pos.y, pos.z);
    monochrome(hsb) ;
    fill(colorPixelCam) ;
    antiBugFillBlack(colorPixelCam) ;
    noStroke() ;
    box(size.x, size.y, depth) ;
  }
  //
  void boxColour(PVector pos, PVector size, PVector hsb) {
    float depth = (hsb.z +.05) *size.z ;
    if(horizon[IDobj]) translate(pos.x, pos.y, depth *.5); else translate(pos.x, pos.y, pos.z);
    colour(hsb) ;
    fill(colorPixelCam) ;
    antiBugFillBlack(colorPixelCam) ;
    noStroke() ;
    box(size.x, size.y, depth) ;
  }
  
  
  //Annexe
  
  // security size 
  PVector checkSize(PVector size) {
    float minSize = .5 ;
    if (size.x < minSize ) size.x = minSize ;
    if (size.y < minSize ) size.y = minSize ;
    if (size.z < minSize ) size.z = minSize ;
    return size ;
  }
  
  void colour(PVector hsb) {
    float newSat = hsb.y *map(saturation(fillObj[IDobj]),0,100,0,1) ;
    float newBrigth = hsb.z *map(brightness(fillObj[IDobj]),0,100,0,1) ;
    colorPixelCam = color(hsb.x, newSat, newBrigth, alpha(fillObj[IDobj]));
  }
  
  void monochrome(PVector hsb) {
    float newHue = hue(fillObj[IDobj]) ;
    float newSat = hsb.y *map(saturation(fillObj[IDobj]),0,100,0,1) ;
    float newBrigth = hsb.z *map(brightness(fillObj[IDobj]),0,100,0,1) ;
    //display the result
    colorPixelCam = color(newHue, newSat, newBrigth, alpha(fillObj[IDobj]));
  }
}