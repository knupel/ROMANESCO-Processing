//GLOBAL
RomanescoFour romanescoFour ;
ArrayList<Encre> encreList ;

//SETUP
void romanescoFourSetup() {
  int ID = 4 ;
  int IDfamilly = 1 ; // 0 is global // 1 is Object // 2 is trame // 3 is typo
  romanescoFour = new RomanescoFour (ID, IDfamilly) ;
//  listRone = new ArrayList() ;
  romanescoFour.setting() ;
}
//DRAW
void romanescoFourDraw(String [] dataControleur, String [] dataMinim) {
  romanescoFour.getID() ;
  romanescoFour.data(dataControleur, dataMinim) ; // data from controleur
  romanescoFour.display() ;
}

//MOUSEPRESSED
void romanescoFourMousepressed() { romanescoFour.mousepressed() ; }
//MOUSERELEASED
void romanescoFourMousereleased() { romanescoFour.mousereleased() ; }
//MOUSE DRAGGED
void romanescoFourMousedragged() { romanescoFour.mousedragged() ; }
//KEYPRESSED
void romanescoFourKeypressed() { romanescoFour.keypressed() ; }
//KEY RELEASED
void romanescoFourKeyreleased() { romanescoFour.keyreleased() ; }

//Return the ID familly to choice the data must be send to the class // 0 is global // 1 is Object // 2 is trame // 3 is typo
int getFamillyRomanescoFour() { return romanescoFour.getIDfamilly() ; }


//CLASS
//GLOBAL

ArrayList<Encre> listE ;
//////////////////////////////////////////
class RomanescoFour extends SuperRomanesco 
{
  //FORBIDEN TO TOUCH
  int IDfamilly ;
  //END OF FORBIDEN ZONE

  float inkDry = 0.0001 ; // time to dry the ink, and pixel stop to move
  float  inkDiffusion = 4.0 ; // size of spray 1 to 8 is good
  int  spray = 10 ; // power of the spray
  int inkFlux = 10 ; // flux is quantity ink for the pen or number of particules create each frame
  float angleSpray = 10.0 ; // like is write

  float factorPressure ;
  PVector sprayDirection ;
  
  
  //CONSTRUCTOR
  RomanescoFour(int ID, int IDfamilly) {
    super(ID) ;
    this.IDfamilly = IDfamilly ;
  }
  

  //SETUP
  void setting() {
    encreList = new ArrayList<Encre>();
  }
  
  
  //DRAW
  void display() {
    pushMatrix() ;
    //P3D Give the position and the orientation of your object in the 3 dimensionals space
    P3Dmanipulation(IDobj) ;
    //////////////////
    //Your object here
    
    color c = color(map(valueObj[IDobj][1],0,100,0,360), valueObj[IDobj][2],valueObj[IDobj][3], valueObj[IDobj][4]) ;
    
    factorPressure = map(pen[0].z, 0, 1, 1, 50 ) ;
    sprayDirection = new PVector (pen[0].x,pen[0].y) ;
    inkDiffusion = map (valueObj[IDobj][17] , 0,100, 0, 100 *tempo[IDobj]  ) ; // speed / vitesse
    float flux = map (valueObj[IDobj][14], 0,100, 1,1000  ) ; // ink quantity
    float thicknessPoint = map(valueObj[IDobj][13],0,100,0.1, height *.1) ;
    inkFlux = int(flux) ;
    angleSpray   = map (valueObj[IDobj][28], 0,100, 0,180 ) ; // angle
    inkDry = map (valueObj[IDobj][15], 0,100, 1.0 , .0000000001) ; // durée
    float spr ;
    spr = map (valueObj[IDobj][26], 0,100 , 1, 100) ; // force de diffusion
    spray = int(spr) ;
  
   // add encre 
   if (actionButton[IDobj] == 1 && nLongTouch && clickLongLeft[IDobj]) addEncre(factorPressure, sprayDirection, angleSpray, spray, inkDiffusion, inkDry, inkFlux) ; 
  
    //display
    for ( Encre e :  encreList ) {
      if (actionButton[IDobj] == 1) e.jitter(tempo[IDobj]) ;
      strokeWeight(thicknessPoint) ;
      noFill() ;
      stroke(c) ;
      point(e.x, e.y) ;
    }
    
    /////////////////////////////
    //CLEAR THE LIST IF NECESSARY 
    if (romanescoEmptyList(IDobj)) encreList.clear() ;

    
    //DON'T TOUCH
    popMatrix() ;
    //END OF DON'T TOUCH
  }
  //END DRAW
  //////////
  


  

  
  //ANNEXE
  void addEncre(float fp, PVector d, float a, int spray, float dif, float dry, int flux)
  {
    
    for ( int i = 0 ; i < flux *fp ; i++ ) {
      
      //to make a good Spray, use a good distribution
      float distribution = random(1) * random(1) ;
      //distribution pixel on the axe, before splash on the angle distribution
      // also we use to the strong push of the pen to the spray longer 
      float distance = spray * fp * distribution  ;
      //angle projection spray
      float angleDeg = random(-a, a);
      float angle = radians(angleDeg) ;
      // calcul of the absolute position of each pixel
      PVector tilt = new PVector ( pen[0].x * distance, pen[0].y * distance ) ;
      //position the pixel around the laticce, pivot...
      PVector posTilt = new PVector ( mouse[0].x - tilt.x , mouse[0].y - tilt.y  ) ;
      
      //calcul the final position to display
      mouse[IDobj].x = rotation(posTilt, mouse[0], angle).x ;
      mouse[IDobj].y = rotation(posTilt, mouse[0], angle).y ;

      
      //put the pixel in the list to use peacefully
      encreList.add( new Encre( mouse[IDobj].x, mouse[IDobj].y, dry, dif)) ;
    }
  }
  
  void resetEncre() {
    resetEasing(mouse[0] ) ; 
    /*
    if ( c == c ) listE.clear() ; // clear the list if the ink is different
    c = ( c + 1 ) % numColor; // to change the ink after new press on the mmouse
    */
  }
  
  
  
  
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


//Super Class
class Encre
{
  float x, y ;
  float dry ;
  float radius ;
  
  Encre (float x, float y, float dry, float radius )
  {
    this.x = x ;
    this.y = y ;
    this.dry = dry ;
    this.radius = radius ;
  }

  void jitter(float var)
  {
    if (radius > 0 ) radius -= dry ;
    float rad;
    float angle;
    {
      // rad = prng.random() * radius;
      //angle = prng.random() * ( 2 * PI );
      rad = random(-1,1) * radius *var;
      angle = random(-1,1) * ( 2 * PI );
      x += rad * cos(angle);
      y += rad * sin(angle);
    }
  }
  
}
