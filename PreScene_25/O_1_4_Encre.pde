ArrayList<Pixel> encreList = new ArrayList<Pixel>(); ;
ArrayList<Pixel> starList = new ArrayList<Pixel>();

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
    romanescoRender = "P3D" ;
    romanescoMode = "1 Spray/2 Star" ;
  }
  //GLOBAL
  // INK
  int dry = 100; // time to dry the ink, and pixel stop to move
  float  inkDiffusion = 0.5 ; // size of spray 1 to 8 is good
  int  spray = 10 ; // power of the spray
  int inkFlux = 10 ; // flux is quantity ink for the pen or number of particules create each frame
  float angleSpray = 10.0 ; // like is write
  float factorPressure ;
  PVector sprayDirection ;
  
  //GALAXIE
  
  //SETUP
  void setting() {
    startPosition(IDobj, 0, 0, 0) ;
  }
  //DRAW
  void display() {
    if(mode[IDobj] == 1 && clickLongLeft[IDobj] && nLongTouch ) starProduction() ;
    
    if(mode[IDobj] == 0 ) encre() ;
    if(mode[IDobj] == 1 ) displayStar() ;
  }
  
  
  //ANNEXE VOID
  
  //STAR PRODUCTION
  float jitterOne, jitterTwo, jitterThree, jitterFour ;
  float thicknessSoundEffect ;
  // display
  void displayStar() {
    if(sound[IDobj]) {
      jitterOne = 5* random(-beat[IDobj],beat[IDobj]) ;
      jitterTwo = 5* random(-kick[IDobj],kick[IDobj]) ;
      jitterThree = 5* random(-snare[IDobj],snare[IDobj]) ;
      jitterFour = 5* random(-hat[IDobj],hat[IDobj]) ; 
    } else {
      jitterOne = 0 ; 
      jitterTwo = 0 ;
      jitterThree = 0 ;
      jitterFour = 0 ;
    }
    thicknessSoundEffect = 1 + jitterOne ;
      
      
    for ( Pixel p : starList ) {
      strokeWeight(thicknessObj[IDobj] *thicknessSoundEffect) ;  
      stroke(hue(p.colour), saturation(p.colour), brightness(p.colour), alpha(fillObj[IDobj]) );
      point(p.pos.x +jitterOne, p.pos.y +jitterTwo, p.pos.z +jitterThree) ;
    }
    if (emptyList(IDobj)) starList.clear() ;
  }
  
  // the orderer
  void starProduction() {
    float depth = map(canvasZObj[IDobj],width/10,width *5,0,width *3) ;
    PVector pos = new PVector(mouse[IDobj].x, mouse[IDobj].y, depth ) ;
    //tha first value must be smaller than second
    
    int sizeMin = (int)map(sizeXObj[IDobj],0.1,width,1,20) ;
    int sizeMax = (int)map(sizeYObj[IDobj],0.1,width,20, width *2) ;
    PVector size = new PVector(sizeMin,sizeMax) ;
    
    int numP = (int)map(quantityObj[IDobj],1,100,20,width) ;
    PVector numPoints = new PVector(numP/10,numP) ;
    
    int branchMin = (int)map(canvasXObj[IDobj],width/10,width *5,1,30) ;
    int branchMax = (int)map(canvasYObj[IDobj],height/10,height *5,1,30) ;
    PVector numBranchs = new PVector(branchMin,branchMax) ;
    // println(canvasXRaw[1],canvasXObj[IDobj],numBranchs.x) ;
    /*
    PVector size = new PVector(20,60) ;
  PVector numPoints = new PVector(10,50) ;
  int test = 30 ;
  PVector numBranchs = new PVector(test,test) ;
  */
    color colour = fillObj[IDobj] ;
    int varAngle = (int)map(angleObj[IDobj], 0,360,0,180) ;
    PVector angle = new PVector(0,varAngle) ; // 0-360 degree
    starProducer(pos, size, numPoints, numBranchs, angle, colour) ;
  }
  
  // the factory
  void starProducer(PVector pos, PVector size, PVector points, PVector branch,  PVector angle, color c) {
    if(points.x > points.y) points.x = points.y ;
    if(branch.x > branch.y) branch.x = branch.y ;
    if(angle.x > angle.y) angle.x = angle.y ;
    if(size.x > size.y) size.x = size.y ;
    
    int num = (int)round(random(branch.x , branch.y )) ;
    int startDirection = (int)random(angle.x,angle.y) ;
    int sizeStar = (int)random(size.x,size.y) ;
    star(pos, sizeStar, startDirection, (int)points.x, (int)points.y, num, c) ;
  }
  
  // the object
  void star(PVector pos, int size,int direction, int min, int max, int numBranch, color colour) {
    pos.z = random(-pos.z, pos.z) ;
    float floatDirection = float(direction) ;
    for (int i = 0 ; i < numBranch ; i++ ) {
      // give the direction of each branch
      float addDegree = 360.0 / float(numBranch) ;
      floatDirection += addDegree ;
      // distribution points on the branch
      int n = (int)random(min,max) ;
      for ( int j = 0 ; j < n ; j++ ) {
        PVector posAroundTheStar = new PVector(0,0) ;
        PVector posFinal = new PVector(0,0) ;
        
        PVector dir = new PVector (0,0) ;
        dir = normalDir((int)floatDirection) ;
        //distrubution in each branch
        float factor = random(0,1) ;
        float newDistance = 0 ;
        newDistance = pow(factor,2) *size ;
        posAroundTheStar = new PVector(dir.x *newDistance, dir.y *newDistance) ;
        
        posFinal.add(posAroundTheStar) ;
        posFinal.add(pos) ;
        starList.add(new Pixel(posFinal, colour)) ;
        posAroundTheStar = new PVector(0,0) ;
      }
    }
  }
  // END STAR PROD
  ////////////////

  
  
  /////
  //INK
  void encre() {
    factorPressure = map(pen[0].z, 0, 1, 1, 50 ) ;
    sprayDirection = new PVector (pen[0].x,pen[0].y) ;
    inkDiffusion = map (speedObj[IDobj] , 0,100, 0, 100 *tempo[IDobj]  ) ; // speed / vitesse
    float flux = map (quantityObj[IDobj], 0,100, 1,1000  ) ; // ink quantity
    float thicknessPoint = thicknessObj[IDobj]*.1 ;
    inkFlux = int(flux) ;
    angleSpray   = map (angleObj[IDobj], 0,360, 0,180 ) ; // angle
    dry = (int)map(lifeObj[IDobj], 1,100, frameRate , 100000) ; // durée
    float spr ;
    spr = map(forceObj[IDobj], 1,100 , 1, width) ; // force de diffusion
    spray = int(spr) ;
    
    // INK DRY
    float var = tempo[IDobj] ;
    float timeDry = 1.0 / float(dry) ;
  
   // add encre
   int security = levelSecurity *1000 ;
   if (action[IDobj] && nLongTouch && clickLongLeft[0] && encreList.size() < security) addEncre(factorPressure, sprayDirection, angleSpray, spray, inkDiffusion, inkFlux) ; 
  
    //display
    for ( Pixel e :  encreList ) {
      if (action[IDobj]) e.drying(var, timeDry) ;
      strokeWeight(thicknessPoint) ;
      noFill() ;
      stroke(fillObj[IDobj]) ;
      point(e.pos.x, e.pos.y) ;
    }
    
    /////////////////////////////
    //CLEAR THE LIST IF NECESSARY 
    if (emptyList(IDobj)) encreList.clear() ;
  }
  void addEncre(float fp, PVector d, float a, int spray, float dif, int flux) {
    for ( int i = 0 ; i < flux *fp ; i++ ) {
      
      //to make a good Spray, use a good distribution
      float distribution = random(1) *random(1) ;
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
      encreList.add( new Pixel( mouse[IDobj], dif)) ;
    }
  }
  
  void resetEncre() {
    encreList.clear() ;
  }
  //END INK
  /////////
}
//end object one




  
