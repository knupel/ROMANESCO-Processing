//GLOBAL
RomanescoTwentyFive romanescoTwentyFive ;
////////////////////////////////////////////////////////////////////
// Just in case you use a class must use an ArrayList in your object, 
// if it's not call the class in the class RomanescoTwentyFive just bellow
/*
ArrayList<YourClass> yourList ;
*/



//SETUP
void romanescoTwentyFiveSetup() {
  // YOU MUST CHANGE THE ID
  //Example : If it's RomanestoThirtySetup int ID = 30 ;
  int ID = 25 ; // 0 is Ref you must use a number in the order of apparition in the controleur, start from top left and follow the horizontal line
  
  int IDfamilly = 2 ; // 1 is single object // 2 is trame // 3 is typo    ....... // 0 is global don't use this one it's for specific stuff
  romanescoTwentyFive = new RomanescoTwentyFive (ID, IDfamilly) ;

  romanescoTwentyFive.setting() ;
}

//DRAW
void romanescoTwentyFiveDraw(String [] dataControleur, String [] dataMinim) {
  romanescoTwentyFive.getID() ;
  romanescoTwentyFive.data(dataControleur, dataMinim) ;
  romanescoTwentyFive.display() ;
}

//MOUSEPRESSED
void romanescoTwentyFiveMousepressed() { romanescoTwentyFive.mousepressed() ; }
//MOUSERELEASED
void romanescoTwentyFiveMousereleased() { romanescoTwentyFive.mousereleased() ; }
//MOUSE DRAGGED
void romanescoTwentyFiveMousedragged() { romanescoTwentyFive.mousedragged() ; }
//KEYPRESSED
void romanescoTwentyFiveKeypressed() { romanescoTwentyFive.keypressed() ; }
//KEY RELEASED
void romanescoTwentyFiveKeyreleased() { romanescoTwentyFive.keyreleased() ; }

//Return the ID familly to choice the data must be send to the class // 0 is global // 1 is Object // 2 is trame // 3 is typo
int getFamillyRomanescoTwentyFive() { return romanescoTwentyFive.getIDfamilly() ; }

////////////
//CLASS////
//GLOBAL
//////////////////////////////////////////
class RomanescoTwentyFive extends SuperRomanesco 
{
  //FORBIDEN TO TOUCH
  int IDfamilly ;
  //END OF FORBIDEN ZONE
  ////////VARIABLE
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

  
  
  //CONSTRUCTOR
  RomanescoTwentyFive(int ID, int IDfamilly) {
    super(ID) ;
    this.IDfamilly = IDfamilly ;
    ///////IMPORTANT////////////////////////////////////
    //to call external class or library in class, now we must use "callingClass" like "this"
    /*
    name = new LibraryOrClass(callingClass);
    */
  }
  //END CONSTRUCTOR
  
  ////SETUP
  //the setting that's stuff that you'r put usually in the void setup() 
  void setting() {
    cam = new GSCapture(callingClass, sizeCam [whichSizeCam][0], sizeCam [whichSizeCam][1], whichCam);
    
    //Logitech / 640x480 / 160x120 / 176x144 / 320x240 / 352x288
    // Imac 640x480 / 160x120 / 176x144 / 320x240 / 352x288
  }
  ///////////
  //END SETUP
  
  
  
  //////DRAW
  //display
  void display() {    
    // starting position
    if (startingPosition[IDobj]) startPosition(IDobj, width/2, height/2, 0) ;
    
    //PART ONE
    factorCalcul.x = sizeCam [whichSizeCam][0] ;
    factorCalcul.y = sizeCam [whichSizeCam][1] ;
    //calcul the ration between the size of camera and the size of the scene
    factorDisplayCam.x = width / factorCalcul.x ; 
    factorDisplayCam.y = height / factorCalcul.y ;
    
    factorDisplayPixel = factorDisplayCam ;//PARAMETER THAT YOU CAN USE
    
    //PART TWO
    cam.start();
    cellSizeX = 2 + int(valueObj[IDobj][12])  ; 
    cellSizeY = 2 + int(valueObj[IDobj][11])  ;
    // factorDisplayPixel.x = factorDisplayCam.x / (20 -TD123/10 ) ; 
   //  factorDisplayPixel.y = factorDisplayCam.y / (20 -TD123/10 ) ; 
    
    cols = sizeCam [whichSizeCam][0] / cellSizeX; // before the resizing
    rows = sizeCam [whichSizeCam][1] / cellSizeY; 
    if (testCam()) {
      cam.read();
      cam.loadPixels() ;
      for (int i = 0; i < cols ; i++) {
        for (int j = 0; j < rows  ; j++) {
          // Where are we, pixel-wise?
          posPixelX = i *cellSizeX  ;
          posPixelY = j *cellSizeY  ;
          //// display pixel 
          int  loc = posPixelX  + posPixelY *cam.width; // classic
          //  int loc = (cam.width - x - 1) + y*cam.width; // mirror
          // FUN
          /*
          int loc = x + y; 
          int loc = x *y;
          int loc = cam.width  + y*cam.width;
          */
          
          //make pixel
          float h = hue(cam.pixels[loc]);
          float s = saturation(cam.pixels[loc]);
          float b = brightness(cam.pixels[loc]);
          // Make a new color with an alpha component
         // color c = color(h, s, b);
          
          
          //mode of display
          if (modeButton[IDobj] == 0 || modeButton[IDobj] == 255 ) {
            //color mode
            colorPixelCam = color(h, s, b, valueObj[IDobj][4]);
          } else if (modeButton[IDobj] == 1 ) {
            //monochrome mode, change param from the cam with the slider influence
            float newHue = map(valueObj[IDobj][1],0,100,0,360) ;
            float newSat = s * map(valueObj[IDobj][2],0,100,0,1) ;
            float newBrigth = b * map(valueObj[IDobj][3],0,100,0,1) ;
            //display the result
            colorPixelCam = color(newHue, newSat, newBrigth, valueObj[IDobj][4]);
          }
          ////////////
          
          //DISPLAY
          //DON'T TOUCH
          pushMatrix() ;
          //P3D Give the position and the orientation of your object in the 3 dimensionals space
          P3Dmanipulation(IDobj) ;
          //END OF DON'T TOUCH 
          PVector newDisplay = new PVector  (cellSizeX *factorDisplayCam.x,   cellSizeY *factorDisplayCam.y) ;
          PVector newCellSize = new PVector (cellSizeX *factorDisplayPixel.x *gauche[IDobj], cellSizeY *factorDisplayPixel.y *droite[IDobj]) ;

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
    ////////////////////////////////////////////////
    //add object from keyboard, press "N" for new one
    if(actionButton[IDobj] == 1 && nTouch ) {
      /*
      yourList.add( new YourClass ());
      newObj[IDobj] = false ;
      */
    }
    /////////////////////////////
    //CLEAR THE LIST IF NECESSARY 
    if (romanescoEmptyList(IDobj)) {}
    
    
    
    
    
    //IT'S THE END FOR YOU
    //////////////////////
    

  }
  //END DRAW
  //////////
  
  
  
    //ANNEXE VOID
  void annexe() {}
  //TEST CAMERA
  /////////////
  int testCam ;

  boolean testCam()
  {
    if (cam.available() ) testCam =+ 30 ; else testCam -= 1 ;
    if ( testCam < 1 ) testCam = 0 ;
    
    if ( testCam > 2 ) {
      videoSignal = true ;
    } else {
      videoSignal = false ;
    }
    
    if ( testCam > 2 ) return true ;  else return false ;
  }
  //END ANNEXE
  
  
  
  
  //KEYPRESSED
  void keypressed() {}
  //KEY RELEASED
  void keyreleased() {}
  //MOUSEPRESSED
  void mousepressed() {}
  //MOUSE RELEASED
  void mousereleased() {}
  //MOUSE DRAGGED
  void mousedragged() {}
  
  

  
  
  
  
  
  /////////////////////////////
  //FORDIDEN TO TOUCH THIS VOID
  /////////////////////////////
  //DATA VOID
  void data( String [] dataControler, String [] dataMinin) {
    super.data(dataControler, dataMinin) ;
  }
  ////////////
  //Return ID
  int getID() {
    return IDobj ;
  }
  int getIDfamilly() {
    return IDfamilly ;
  }
  ///////////////////////////
  //////////////////////////
}
