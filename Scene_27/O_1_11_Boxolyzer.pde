  ArrayList<BOITEaMUSIQUE> boiteList ;
  
class Boxolyzer extends Romanesco {
  public Boxolyzer() {
    //from the index_objects.csv
    romanescoName = "Boxolyzer" ;
    IDobj = 11 ;
    IDgroup = 1 ;
    romanescoAuthor  = "My name is Nobody";
    romanescoVersion = "Version 1.0";
    romanescoPack = "Base" ;
    romanescoRender = "P3D" ;
    romanescoMode ="Classic/Circle" ;
    romanescoSlider = "Hue fill,Saturation fill,Brightness fill,Alpha fill,Hue stroke,Saturation stroke,Brightness stroke,Alpha stroke,Thickness,Width,Height,Depth,Canvas X,Quantity,Direction" ;
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
    PVector size = new PVector(sizeXObj[IDobj],sizeYObj[IDobj],sizeZObj[IDobj]) ;
    // color and thickness
    aspect(IDobj) ; 
    //
    distribution(numBox, newDistribution) ;
    
    // MODE DISPLAY with the dropdown menu of controler
    /////////////////////
    if        (mode[IDobj] ==0) { boxolyzerClassic(size, horizon[IDobj] , directionObj[IDobj]) ;
    } else if (mode[IDobj] ==1) { boxolyzerCircle(size, (int)canvasXObj[IDobj], horizon[IDobj], directionObj[IDobj]) ;
    } 
    
  }
  
  //ANNEXE VOID
  void distribution(int n, boolean newOne) {
     if (newOne) newDistributionBoite(n) ;
     newDistribution = false ;
   }
  
  boolean orientation ;
  // BOXLIZER CIRCLE
  void boxolyzerCircle(PVector size, int diam, boolean groundPosition, float dir) {
    if( action[IDobj] && rTouch ) orientation = !orientation ;
    int surface = diam*diam ; // surface is equale of square surface where is the cirlcke...make sens ?
    int radius = ceil(radiusSurface(surface)) ;
    
    int n = boiteList.size() ;
    float factorSpectrum = 0 ;
    PVector pos = new PVector(0,0,0) ;
    
    for(int i=0; i < n; i++) {
      if(  i < band.length) factorSpectrum = band [IDobj][i] ;
      float stepAngle = map(i, 0, n, 0, 2*PI) ; 
      float angle =  2*PI - stepAngle;
      if(orientation) pos = new PVector(pointOnCirlcle(radius, angle).x + pos.x, pointOnCirlcle(radius, angle).y + pos.y ) ;
      else  pos = new PVector(pointOnCirlcle(radius, angle).x + pos.x, 0, pointOnCirlcle(radius, angle).y + pos.z) ;

      BOITEaMUSIQUE boiteAmusique = (BOITEaMUSIQUE) boiteList.get(i) ;
      boiteAmusique.showTheBoite(pos, size, factorSpectrum, groundPosition, dir) ;
    }
  }



  // EQUALIZER CLASSIC
  void boxolyzerClassic(PVector size, boolean groundPosition, float dir) {
    PVector pos = new PVector(0,height /2 ,0) ;
    float factorSpectrum = 0 ;
    int n = boiteList.size() ;
    for( int i = 0 ; i < n ; i++) {
      pos.x = (i *width/n) + (width/(n*2)) ;
      if(  i < band.length) factorSpectrum = band [IDobj][i] ;
      BOITEaMUSIQUE boiteAmusique = (BOITEaMUSIQUE) boiteList.get(i) ;
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
    PVector size = new PVector (1,1,1) ;
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
  PVector size = new PVector (0,0,0) ;
  int ID ;
  
  BOITEaMUSIQUE(PVector size, int ID) {
    this.ID = ID ;
    this.size = size ;
  }
  
  
  
  void showTheBoite(PVector pos, PVector size, float factor, boolean groundLine, float dir) {
    PVector newSize = new PVector (size.x, size.y *factor,size.z *factor ) ;
    //put the box on the ground !
    float horizon = pos.y - ( newSize.y *.5 ) ;  
    pushMatrix() ;
    if (!groundLine) translate(pos.x, pos.y, pos.z) ; else translate(pos.x, horizon, pos.z) ;
    rotateX(radians(dir)) ;
    box(newSize.x,newSize.y,newSize.z) ;
    popMatrix() ;
  }
}
