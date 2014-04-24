
class Webcam extends SuperRomanesco {
  public Webcam() {
    //from the index_objects.csv
    romanescoName = "Webcam" ;
    IDobj = 14 ;
    IDgroup = 2 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Alpha 2.0";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
    romanescoMode = "1 classic/2 monochrome" ;
  }
  //GLOBAL
  int cameraStatut = 0 ;
  //class
  GSCapture cam;
  //Cameras
  int [] [] sizeCam = { {640,480}, {160,120}, {176,144}, {320,240}, {352,288} } ;
  int whichSizeCam = 4 ; // choice the resolution size of camera
  String whichCam = "2" ; // choice the camera
  boolean nativeWebCam ;
  int testDeviceCam ;
  
  PVector factorDisplayCam = new PVector ( 0,0) ;
  PVector factorDisplayPixel = new PVector ( 0,0) ;
  PVector factorCalcul = new PVector (0,0) ;
  // PVector posMovie = new PVector(0,0 ) ; // position x & y for the camera
  
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
    
    factorDisplayPixel = factorDisplayCam ;//PARAMETER THAT YOU CAN USE
    
    //PART TWO
    cam.start();
    cellSizeX = 2 + int(sizeYObj[IDobj])  ; 
    cellSizeY = 2 + int(sizeXObj[IDobj])  ;
    // factorDisplayPixel.x = factorDisplayCam.x / (20 -TD123/10 ) ; 
   //  factorDisplayPixel.y = factorDisplayCam.y / (20 -TD123/10 ) ; 
    
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
          float h = hue(cam.pixels[loc]);
          float s = saturation(cam.pixels[loc]);
          float b = brightness(cam.pixels[loc]);
          // Make a new color with an alpha component
         // color c = color(h, s, b);
          
          
          //mode of display
          if (mode[IDobj] == 0 || mode[IDobj] == 255 ) {
            //color mode
            colorPixelCam = color(h, s, b, alpha(fillObj[IDobj]));
          } else if (mode[IDobj] == 1 ) {
            //monochrome mode, change param from the cam with the slider influence
            float newHue = hue(fillObj[IDobj]) ;
            float newSat = s * map(saturation(fillObj[IDobj]),0,100,0,1) ;
            float newBrigth = b * map(brightness(fillObj[IDobj]),0,100,0,1) ;
            //display the result
            colorPixelCam = color(newHue, newSat, newBrigth, alpha(fillObj[IDobj]));
          }
   
          //DISPLAY
          pushMatrix() ;
          //P3D Give the position and the orientation of your object in the 3 dimensionals space
          PVector newDisplay = new PVector  (cellSizeX *factorDisplayCam.x,   cellSizeY *factorDisplayCam.y) ;
          PVector newCellSize = new PVector (cellSizeX *factorDisplayPixel.x *left[IDobj], cellSizeY *factorDisplayPixel.y *right[IDobj]) ;
          //init the position of image on the middle of the screen
          PVector posMouseCam = new PVector ( width / 2, height /2) ;
          if (mouse[IDobj].x >= -startingPos[IDobj].x && mouse[IDobj].y >= -startingPos[IDobj].y) posMouseCam = mouse[IDobj] ;
          //create the ratio for the translate position in functiun of the size of the Scene, not really good algorythm
          float ratioDisplay = (float)width / (float)height ;
          float factorDisplacementRatioSizeOfTheDisplay = map(width, 0, 2000, .6, .2 ) ;
          float factorTranslateX = factorDisplacementRatioSizeOfTheDisplay / ratioDisplay ;
          float factorTranslateY = factorDisplacementRatioSizeOfTheDisplay ;

          //finalization of the position
          translate( ( (posPixelX +newDisplay.x *factorTranslateX) *factorDisplayCam.x) + posMouseCam.x - width *0.5 , 
                     ( (posPixelY +newDisplay.y *factorTranslateY) *factorDisplayCam.y) + posMouseCam.y - height*0.5  );
                     
          rectMode(CENTER) ;
          fill(colorPixelCam) ;
          noStroke() ;
          rect (0,0, newCellSize.x, newCellSize.y) ;
          //DON'T TOUCH
          popMatrix() ;
          //END OF DON'T TOUCH
        }
      } 
    } else if (!testCam() && testDeviceCam < 180 )  {
      fill(0) ;
      testDeviceCam += 1 ;
      text("No extarnal video signal, Romanesco try on the native Camera", mouse[0].x , mouse[0].y ) ;
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
  int testCam ;
  boolean testCam() {
    if (cam.available() ) testCam =+ 30 ; else testCam -= 1 ;
    if ( testCam < 1 ) testCam = 0 ;
    
    if ( testCam > 2 ) {
      videoSignal = true ;
    } else {
      videoSignal = false ;
    }
    
    if ( testCam > 2 ) return true ;  else return false ;
  }
}
//end object one







// END OBJECT ROMANESCO
///////////////////////
