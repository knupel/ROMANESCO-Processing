
class Webcam extends SuperRomanesco {
  public Webcam() {
    //from the index_objects.csv
    romanescoName = "Webcam" ;
    IDobj = 14 ;
    IDgroup = 2 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Alpha 1.2";
    romanescoPack = "Base" ;
    romanescoRender = "P3D" ;
    romanescoMode = "1 Rectangle color/2 Rectangle mono/3 Point color/4 Point mono/3 Box color/4 Box mono" ;
    romanescoSlider = "Hue fill,Saturation fill,Brightness fill,Alpha fill,Width,Height,Depth,Canvas X,Canvas Y" ;
  }
  //GLOBAL
  int cameraStatut = 0 ;
  //class
  GSCapture cam;
  //Cameras
  int [] [] sizeCam = { {640,480}, {160,120}, {176,144}, {320,240}, {352,288} } ;
  int whichSizeCam = 4 ; // choice the resolution size of camera
  String whichCam = "1" ; // "1" to search an external webcam, the device "0" is the native webcam on mac
  boolean nativeWebCam ;
  int testDeviceCam ;
  
  PVector factorDisplayCam = new PVector (0,0) ;
  PVector factorDisplayPixel = new PVector (0,0) ;
  PVector factorCalcul = new PVector (0,0) ;
  
  color colorPixelCam ;
  
  int cellSizeX, cellSizeY, posPixelX, posPixelY   ;
  int cols ;
  int rows ; 
  
  
  //SETUP
  void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
    cam = new GSCapture(callingClass, sizeCam [whichSizeCam][0], sizeCam [whichSizeCam][1], whichCam);
    
    //Logitech / 640x480 / 160x120 / 176x144 / 320x240 / 352x288
    // Imac 640x480 / 160x120 / 176x144 / 320x240 / 352x288
  }
  //DRAW
  void display() {
    //PART ONE
    factorCalcul.x = sizeCam [whichSizeCam][0] ;
    factorCalcul.y = sizeCam [whichSizeCam][1] ;
    //calcul the ration between the size of camera and the size of the scene
    factorDisplayCam.x = width / factorCalcul.x ; 
    factorDisplayCam.y = height / factorCalcul.y ;
    
    float minVal = 0.1 ;
    float maxVal = height / 50 ;
    PVector factorSizePix = new PVector(map(sizeXObj[IDobj],0.1,width, minVal, maxVal), map(sizeYObj[IDobj],0.1,width, minVal, maxVal), map(sizeZObj[IDobj],0.1,width, minVal, maxVal)) ; 
    factorDisplayPixel = new PVector(factorDisplayCam.x *factorSizePix.x , factorDisplayCam.y *factorSizePix.y, factorSizePix.z) ;//PARAMETER THAT YOU CAN USE
    
    //PART TWO
    cam.start();
    cellSizeX = int(map(canvasYObj[IDobj],width/10, width, 50, 1))  ; 
    cellSizeY = int(map(canvasXObj[IDobj],width/10, width, 50, 1))  ;
    if(cellSizeX < 1 ) cellSizeX = 1 ;
    if(cellSizeY < 1 ) cellSizeY = 1 ;
    
    cols = sizeCam [whichSizeCam][0] / cellSizeX; // before the resizing
    rows = sizeCam [whichSizeCam][1] / cellSizeY;
    if (testCam()) {
      cam.read();
      for (int i = 0; i < cols ; i++) {
        for (int j = 0; j < rows  ; j++) {
          // Where are we, pixel-wise?
          posPixelX = i *cellSizeX  ;
          posPixelY = j *cellSizeY  ;
          //// display pixel 
          int  loc = posPixelX  + posPixelY *cam.width; // classic
          //  int loc = (cam.width - x - 1) + y*cam.width; // mirror
          //make pixel
          PVector hsb = new PVector (hue(cam.pixels[loc]), saturation(cam.pixels[loc]), brightness(cam.pixels[loc]) ) ;

          
          // Make a new color with an alpha component
          displayPix(mode[IDobj],hsb) ; 
        }
      } 
    } else if (!testCam() && testDeviceCam < 180 )  {
      fill(0) ;
      testDeviceCam += 1 ;
      text("No external video signal, Romanesco try on the native Camera", 10 , 20 ) ;
    } 
    
    //TEST CAM
    // testDeviceCam += 1 ;
    if(!testCam() && nativeWebCam && testDeviceCam > 90  ) {
      cam = new GSCapture(callingClass, sizeCam [whichSizeCam][0], sizeCam [whichSizeCam][1], ("0")); 
     // if(testCam() )  nativeWebCam = true ; 
    } else {
      nativeWebCam = true ;
    }
    if(!testCam() && testDeviceCam == 180 ) {
      fill(0) ;
      text("No camera available on your stuff my Friend !", mouse[0].x , mouse[0].y ) ;
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
    float factorSizeZ = map(sizeZObj[IDobj], .1, width, .5, 10) ;
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
    size = checkSize(size).get() ;
    translate(pos.x, pos.y, pos.z);
    monochrome(hsb) ;
    fill(colorPixelCam) ;
    noStroke() ;
    antiBugFillBlack(colorPixelCam) ;
    rect (0,0, size.x, size.y) ;
  }
  //
  void rectangleColour(PVector pos, PVector size, PVector hsb) {
    size = checkSize(size).get() ;
    translate(pos.x, pos.y, pos.z);
    colour(hsb) ;
    fill(colorPixelCam) ;
    noStroke() ;
    antiBugFillBlack(colorPixelCam) ;
    rect (0,0, size.x, size.y) ;
  }
  //
  void pointMonochrome(PVector pos, PVector size, PVector hsb) {
    size = checkSize(size).get() ;
    translate(pos.x, pos.y, pos.z);
    monochrome(hsb) ;
    stroke(colorPixelCam) ;
    strokeWeight(size.x) ;
    antiBugFillBlack(colorPixelCam) ;
    point(0,0,0) ;
  }
  //
  void pointColour(PVector pos, PVector size, PVector hsb) {
    size = checkSize(size).get() ;
    translate(pos.x, pos.y, pos.z);
    colour(hsb) ;
    stroke(colorPixelCam) ;
    strokeWeight(size.x) ;
    antiBugFillBlack(colorPixelCam) ;
    point(0,0,0)  ;
  }
  //
  void boxMonochrome(PVector pos, PVector size, PVector hsb) {
    size = checkSize(size).get() ;
    float depth = (hsb.z +1) *size.z ;
    if(horizon[IDobj]) translate(pos.x, pos.y, depth *.5); else translate(pos.x, pos.y, pos.z);
    monochrome(hsb) ;
    fill(colorPixelCam) ;
    antiBugFillBlack(colorPixelCam) ;
    noStroke() ;
    box(size.x, size.y, depth) ;
  }
  //
  void boxColour(PVector pos, PVector size, PVector hsb) {
    size = checkSize(size).get() ;
    float depth = (hsb.z +1) *size.z ;
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
    float minSize = 2.0 ;
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
  
  
  
  
  
  
  
  
  // test camera
  int testCam ;
  boolean testCam() {
    if (cam.available()) testCam =+ 30 ; else testCam -= 1 ;
    if ( testCam < 1 ) testCam = 0 ;
    
    if ( testCam > 2 ) videoSignal = true ; else videoSignal = false ;
    // boolean returned
    if ( testCam > 2 ) return true ;  else return false ;
  }
}
