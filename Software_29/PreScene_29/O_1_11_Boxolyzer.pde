/**
BOXOLYZER || 2012|| 1.0.3
*/
ArrayList<BOITEaMUSIQUE> boiteList ;
  
class Boxolyzer extends Romanesco {
  public Boxolyzer() {
    //from the index_objects.csv
    romanescoName = "Boxolyzer" ;
    IDobj = 11 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Version 1.0.3";
    romanescoPack = "Base" ;
    romanescoRender = "P3D" ;
    romanescoMode ="Classic/Circle" ;
    romanescoSlider = "Hue fill,Saturation fill,Brightness fill,Alpha fill,Hue stroke,Saturation stroke,Brightness stroke,Alpha stroke,Thickness,Size X,Size Y,Size Z,Canvas X,Quantity,Direction" ;
  }
  //GLOBAL
  boolean newDistribution ;
  int numBoxRef ;

  //SETUP
  void setting() {
    startPosition(IDobj, 0, height/4, 0) ;
    
    boitesSetting() ;
  }
  //DRAW
  void display() {
    //CLASSIC DISPLAY
    int numBox = int(map(quantityObj[IDobj],0, 1, 1, 16)) ;
    if (numBox != numBoxRef ) newDistribution = true ;
    numBoxRef = numBox ;
    Vec3 size = Vec3(sizeXObj[IDobj],sizeYObj[IDobj],sizeZObj[IDobj]) ;
    size.mult(2) ;

    // color and thickness
    aspect(IDobj) ; 
    //
    distribution(numBox, newDistribution) ;
    
    // MODE DISPLAY with the dropdown menu of controler
    /////////////////////
    if        (mode[IDobj] ==0) { boxolyzerClassic(size, horizon[IDobj] , directionObj[IDobj]) ;
    } else if (mode[IDobj] ==1) { boxolyzerCircle(size, (int)canvasXObj[IDobj], horizon[IDobj], directionObj[IDobj]) ;
    } 


    // INFO
    objectInfo[IDobj] = ("There is " +numBox + " bands analyzed");
    
  }
  
  //ANNEXE VOID
  void distribution(int n, boolean newOne) {
     if (newOne) newDistributionBoite(n) ;
     newDistribution = false ;
   }
  
  boolean orientation ;
  // BOXLIZER CIRCLE
  void boxolyzerCircle(Vec3 size, int diam, boolean groundPosition, float dir) {
    if( action[IDobj] && rTouch ) orientation = !orientation ;
    int surface = diam*diam ; // surface is equale of square surface where is the cirlcke...make sens ?
    int radius = ceil(radius_from_circle_surface(surface)) ;
    
    int n = boiteList.size() ;
    float factorSpectrum = 0 ;
    PVector pos = new PVector() ;
    
    for(int i=0; i < n; i++) {
      if(  i < band.length) factorSpectrum = band [IDobj][i] ;
      float stepAngle = map(i, 0, n, 0, 2*PI) ; 
      float angle =  2*PI - stepAngle;
      if(orientation) pos = new PVector(projection(angle, radius).x + pos.x, projection(angle, radius).y + pos.y ) ;
      else  pos = new PVector(projection(angle, radius).x + pos.x, 0, projection(angle, radius).y + pos.z) ;

      BOITEaMUSIQUE boiteAmusique = (BOITEaMUSIQUE) boiteList.get(i) ;
      boiteAmusique.showTheBoite(pos, size, factorSpectrum, groundPosition, dir) ;
    }
  }



  // EQUALIZER CLASSIC
  void boxolyzerClassic(Vec3 size, boolean groundPosition, float dir) {
    PVector pos = new PVector(0,height *.5 ,0) ;
    float factorSpectrum = 0 ;
    int n = boiteList.size() ;
    // int canvasFinal = width ;
    int canvasFinal = (int)map(canvasXObj[IDobj], width/10, width, width/2,width*3)  ;
    int displacement_symetric = int(width *.5 -canvasFinal *.5) ;
    for( int i = 0 ; i < n ; i++) {
      pos.x = (i *canvasFinal/n) + (canvasFinal /(n *2)) +displacement_symetric ;
      if( i < band.length) factorSpectrum = band [IDobj][i] ;
      BOITEaMUSIQUE boiteAmusique = (BOITEaMUSIQUE) boiteList.get(i) ;
      if(!fullRendering) factorSpectrum = .5 ;
      boiteAmusique.showTheBoite(pos, size, factorSpectrum, groundPosition, dir) ;
    }
  }
  // END EQUALIZER
  
  
  
  
  
  
  // GLOBAL VOID
  void boitesSetting() {
    boiteList = new ArrayList<BOITEaMUSIQUE>();
  }
  //
  void newDistributionBoite(int n) {
    boiteList.clear() ;
    for (int i = 0 ; i < n ; i++ ) addBoite(i) ;
  }
  //
  void addBoite(int ID) {
    Vec3 size = Vec3(1,1,1) ;
    BOITEaMUSIQUE boiteAmusique = new BOITEaMUSIQUE(size, ID) ; 
    boiteList.add(boiteAmusique) ;
  }
  // END GLOBAL VOID
}
//END







///////
//CLASS
class BOITEaMUSIQUE {
  PVector pos = new PVector(0,0,0) ;
  Vec3 size ;
  int ID ;
  
  BOITEaMUSIQUE(Vec3 size, int ID) {
    this.ID = ID ;
    this.size = size ;
  }
  
  
  
  void showTheBoite(PVector pos, Vec3 size, float factor, boolean groundLine, float dir) {
    Vec3 newSize = Vec3(size.x, size.y *factor,size.z *factor ) ;
    //put the box on the ground !

    pushMatrix() ;
    if (!groundLine) {
      translate(pos.x, pos.y, pos.z) ; 
    } else {
      float horizon = pos.y -(newSize.z *.5) ;  
      translate(pos.x, horizon, pos.z) ;
    }
    rotateX(radians(dir)) ;
    box(newSize.x,newSize.y,newSize.z) ;
    popMatrix() ;
  }
}
