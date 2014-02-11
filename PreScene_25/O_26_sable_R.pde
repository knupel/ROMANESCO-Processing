//GLOBAL
RomanescoTwentySix romanescoTwentySix ;
////////////////////////////////////////////////////////////////////
// Just in case you use a class must use an ArrayList in your object, 
// if it's not call the class in the class RomanescoTwentySix just bellow
/*
ArrayList<YourClass> yourList ;
*/



//SETUP
void romanescoTwentySixSetup() {
    //MUST CHANGE THE ID
  //Example : If it's RomanestoThirtySetup int ID = 30 ;
  int ID = 26 ; // 0 is Ref you must use a number is the order of apparition in the controleur, start from top left and follow the horizontal line
  
  int IDfamilly = 2 ; // 1 is single object // 2 is trame // 3 is typo    ....... // 0 is global don't use this one it's for specific stuff
  romanescoTwentySix = new RomanescoTwentySix (ID, IDfamilly) ;

  romanescoTwentySix.setting() ;
}

//DRAW
void romanescoTwentySixDraw(String [] dataControleur, String [] dataMinim) {
  romanescoTwentySix.getID() ;
  romanescoTwentySix.data(dataControleur, dataMinim) ;
  romanescoTwentySix.display() ;
}

//MOUSEPRESSED
void romanescoTwentySixMousepressed() { romanescoTwentySix.mousepressed() ; }
//MOUSERELEASED
void romanescoTwentySixMousereleased() { romanescoTwentySix.mousereleased() ; }
//MOUSE DRAGGED
void romanescoTwentySixMousedragged() { romanescoTwentySix.mousedragged() ; }
//KEYPRESSED
void romanescoTwentySixKeypressed() { romanescoTwentySix.keypressed() ; }
//KEY RELEASED
void romanescoTwentySixKeyreleased() { romanescoTwentySix.keyreleased() ; }

//Return the ID familly to choice the data must be send to the class // 0 is global // 1 is Object // 2 is trame // 3 is typo
int getFamillyRomanescoTwentySix() { return romanescoTwentySix.getIDfamilly() ; }

////////////
//CLASS////
//GLOBAL
//////////////////////////////////////////
class RomanescoTwentySix extends SuperRomanesco 
{
  //FORBIDEN TO TOUCH
  int IDfamilly ;
  //END OF FORBIDEN ZONE
  
  ////////////////////////////////////////////////
  // YOUR VARIABLE OBJECT and CALL YOUR OWN CLASS HERE if it's not class that use an ArrayList
  /*
  int var ; float var ; // etc
  YourClass yourClass ;
  */
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
  PVector deformationGrain = new PVector (0.0, 0.0 ) ;

  PVector motionGrain = new PVector (0.0 , 0.0) ;
  float newRayonGrain = 1 ;
  float variableRayonGrain = -0.001 ;
  
  
  // CLASS_WITHOUT_ARRAYLIST class_without_arraylist
   /*
  ///////IMPORTANT////////////////////////////////////
  //to call external class or library in class
  //we have write this line at the top of code : 
  PApplet callingClass = this ;
  //and here you call call your class
  LibraryOrClass name ; 
  */
  
  
  // END YOUR VARIABLE OBJECT
  ///////////////////////////
  
  
  //CONSTRUCTOR
  RomanescoTwentySix(int ID, int IDfamilly) {
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
    //motion
    motion[IDobj] = true ;
  }
  ///////////
  //END SETUP
  
  
  
  //////DRAW
  //display
  void display()
  {
    // starting position
    //if (startingPosition[IDobj]) startPosition(IDobj, 0, 0, 0) ;
    //DON'T TOUCH
    pushMatrix() ;
    //P3D Give the position and the orientation of your object in the 3 dimensionals space
    P3Dmanipulation(IDobj) ;
    //END OF DON'T TOUCH
    
    //////////////////////
    //HERE IT'S FOR YOU
    
    //quantity of sand / quantité de sable
    if (modeButton[IDobj] == 0 || modeButton[IDobj] == 255 ) numFromControler = int(3*(sq(valueObj[IDobj][14])) ) ; else numFromControler = 30 + int(10 *valueObj[IDobj][14]) ;
    if (numGrains != numFromControler && parameterButton[IDobj] == 1 ) makeSand = true ;
    if (makeSand) {
      numGrains = numFromControler ;
      grainSetup(numGrains) ;
      makeSand = false ;
    }
 
    //give back the pen info
    float pressionGrain = sq(1 + pen[IDobj].z) ;
    orientationStyletGrain = new PVector ( 4* pen[IDobj].x , pen[IDobj].y ) ;
    
    //float vitesse = vitesseGrainA ;
   // float vitesseSound = gaucheDroite ;
    // speed / vitesse
    vitesseGrainA = map(gauche[IDobj],0,1, 1, 2) ;
    vitesseGrainB = map(droite[IDobj],0,1, 1, 2) ;
    
    if(motion[IDobj]) speedDust = map(valueObj[IDobj][16],0,100, 0.0001 ,2) ; else speedDust = 0.0001 ;
    
    vitesseGrain.x = vitesseGrainA *speedDust *tempo[IDobj] *pressionGrain  ;
    vitesseGrain.y = vitesseGrainB *speedDust *tempo[IDobj] *pressionGrain  ;

    posCenterGrain.x = mouse[IDobj].x ;
    posCenterGrain.y = mouse[IDobj].y ;
    
    //size
    float objWidth =  map(valueObj[IDobj][21],0,100,0.5, height *.2 *mix[IDobj]) ;
    float objHeight =  map(valueObj[IDobj][22],0,100,0.5, height *.1 *mix[IDobj]) ;
    PVector size = new PVector(objWidth *10, objHeight *10) ;
    
    //thickness / épaisseur
    float e = map(valueObj[IDobj][13],0,100,0.5, height *.1 *mix[IDobj]) ;

    color colorIn = color ( map(valueObj[IDobj][1],0,100,0,360), valueObj[IDobj][2], valueObj[IDobj][3],valueObj[IDobj][4] ) ;
    color colorOut = color ( map(valueObj[IDobj][5],0,100,0,360), valueObj[IDobj][6], valueObj[IDobj][7],valueObj[IDobj][8] ) ;
    
    //surface
    float surface = map(valueObj[IDobj][17],0,100,0,10) ;
    
    /////////
    //UPDATE
    updateGrain(upTouch, downTouch, leftTouch, rightTouch, clickLongLeft[IDobj], surface);
    
    //////////////
    //DISPLAY MODE
    if (modeButton[IDobj] == 0 || modeButton[IDobj] == 255 ) {
      pointSable(objWidth, colorIn) ;
    } else if (modeButton[IDobj] == 1 ) {
      ellipseSable(size,e , colorIn, colorOut) ;
    } else if (modeButton[IDobj] == 2 ) {
      rectSable(size,e , colorIn, colorOut) ;
    } else {
      pointSable(objWidth, colorIn) ;
    }

    
    

    
    ////////////////////////////////////////////////
    //add object from keyboard, press "N" for new one
    if(actionButton[IDobj] == 1 && nTouch ) {}
    /////////////////////////////
    //CLEAR THE LIST IF NECESSARY 
    if (romanescoEmptyList(IDobj)) {}
    
    
    
    
    
    //IT'S THE END FOR YOU
    //////////////////////

    
    //DON'T TOUCH
    popMatrix() ;
    //END OF DON'T TOUCH
  }
  //END DRAW
  ///////////
  
  
  
  
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
  void grainSetup( int num) {
    grain = new PVector [num] ;
    for(int i = 0; i < num ; i++) {
      grain[i] = new PVector (random(width), random(height)) ;
    }
    makeSand = true ;
  }
    
    
  //void update  
  void updateGrain(boolean up, boolean down, boolean left, boolean right, boolean mouseClic, float area) {
    
    for(int i = 0; i < grain.length; i++) {
      newRayonGrain = newRayonGrain -variableRayonGrain ;
      
      motionGrain.x = grain[i].x -posCenterGrain.x -(deformationGrain.x +droite[IDobj])  ;
      motionGrain.y = grain[i].y -posCenterGrain.y -(deformationGrain.y +gauche[IDobj] ) ;
  
      PVector posGrain = new PVector ( 0,0, 0) ;
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
      if (right || left  ) {
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
      float margeWidth = width *area ;
      float margeHeight = height *area ;
      if(grain[i].x > width +margeWidth) grain[i].x = -margeWidth;
      if(grain[i].x < -margeWidth)     grain[i].x = width +margeWidth;
      if(grain[i].y > height + margeHeight) grain[i].y = -margeHeight;
      if(grain[i].y < -margeHeight)     grain[i].y = height +margeHeight;
    }
  }
 
  
  
  
  
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
