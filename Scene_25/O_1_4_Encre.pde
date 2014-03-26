ArrayList<Encre> encreList ;

//object one
class Spray extends SuperRomanesco {
  public Spray() {
    //from the index_objects.csv
    romanescoName = "Spray" ;
    IDobj = 4 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Stan le Punk";
        romanescoVersion = "Alpha 2.0";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
  }
  //GLOBAL
  float inkDry = 0.0001 ; // time to dry the ink, and pixel stop to move
  float  inkDiffusion = 4.0 ; // size of spray 1 to 8 is good
  int  spray = 10 ; // power of the spray
  int inkFlux = 10 ; // flux is quantity ink for the pen or number of particules create each frame
  float angleSpray = 10.0 ; // like is write

  float factorPressure ;
  PVector sprayDirection ;
  
  //SETUP
  void setting() {
    startPosition(IDobj, 0, 0, 0) ;
    
    encreList = new ArrayList<Encre>();
  }
  //DRAW
  void display() {
    factorPressure = map(pen[0].z, 0, 1, 1, 50 ) ;
    sprayDirection = new PVector (pen[0].x,pen[0].y) ;
    inkDiffusion = map (speedObj[IDobj] , 0,100, 0, 100 *tempo[IDobj]  ) ; // speed / vitesse
    float flux = map (quantityObj[IDobj], 0,100, 1,1000  ) ; // ink quantity
    float thicknessPoint = thicknessObj[IDobj]*.1 ;
    inkFlux = int(flux) ;
    angleSpray   = map (angleObj[IDobj], 0,360, 0,180 ) ; // angle
    inkDry = map (lifeObj[IDobj], 1,100, 1.0 , .0000000001) ; // durée
    float spr ;
    spr = map(forceObj[IDobj], 1,100 , 1, width) ; // force de diffusion
    spray = int(spr) ;
  
   // add encre 
   if (action[IDobj] && nLongTouch && clickLongLeft[0]) addEncre(factorPressure, sprayDirection, angleSpray, spray, inkDiffusion, inkDry, inkFlux) ; 
  
    //display
    for ( Encre e :  encreList ) {
      if (actionButton[IDobj] == 1) e.jitter(tempo[IDobj]) ;
      strokeWeight(thicknessPoint) ;
      noFill() ;
      stroke(fillObj[IDobj]) ;
      point(e.x, e.y) ;
    }
    
    /////////////////////////////
    //CLEAR THE LIST IF NECESSARY 
    if (emptyList(IDobj)) encreList.clear() ;
  }
  
  
  
  //ANNEXE VOID
  void addEncre(float fp, PVector d, float a, int spray, float dif, float dry, int flux) {
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
}
//end object one




//Super Class
class Encre {
  float x, y ;
  float dry ;
  float radius ;
  
  Encre (float x, float y, float dry, float radius ) {
    this.x = x ;
    this.y = y ;
    this.dry = dry ;
    this.radius = radius ;
  }

  void jitter(float var) {
    if (radius > 0 ) radius -= dry ;
    float rad;
    float angle;
    rad = random(-1,1) * radius *var;
    angle = random(-1,1) * ( 2 * PI );
    x += rad * cos(angle);
    y += rad * sin(angle);

  }
}
  
