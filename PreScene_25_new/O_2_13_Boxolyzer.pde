  ArrayList<BOITEaMUSIQUE> boiteList ;
  
class Boxolyzer extends SuperRomanesco {
  public Boxolyzer() {
    //from the index_objects.csv
    romanescoName = "Boxolyzer" ;
    IDobj = 13 ;
    IDgroup = 2 ;
    romanescoAuthor  = "My name is Nobody";
    romanescoVersion = "Alpha 1.0";
    romanescoPack = "Base" ;
    romanescoRender = "P3D" ;
  }
  //GLOBAL
  boolean newDistribution ;
  int numBoxRef ;

  //SETUP
  void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
    
    boitesSetting() ;
  }
  //DRAW
  void display() {
    color colorIn = fillObj[IDobj] ;
    color colorOut = strokeObj[IDobj] ;
    float thickness = thicknessObj[IDobj] ;
    //CLASSIC DISPLAY
    int numBox = int(map(quantityObj[IDobj],1,100,1,16)) ;
    if (numBox != numBoxRef ) newDistribution = true ;
    numBoxRef = numBox ;
    PVector size = new PVector(sizeXObj[IDobj],sizeYObj[IDobj],sizeZObj[IDobj]) ;
    boitesDraw(size, horizon[IDobj], newDistribution, numBox, colorIn, colorOut, thickness) ;
    
    //END YOUR WORK
    
    // MODE DISPLAY with the dropdown menu of controler
    /////////////////////
    if (mode[IDobj] == 0 || mode[IDobj] == 255 ) {
      //// just for information we use 0 to display the mode 1...same for the next mode +1...
    } else if (mode[IDobj] == 1 ) {
    } else if (mode[IDobj] == 2 ) {
    // and same for the next
    }
  }
  
  //ANNEXE VOID
  void boitesSetting() {
    boiteList = new ArrayList<BOITEaMUSIQUE>();
  }



  void boitesDraw(PVector size, boolean ground, boolean distribution, int n, color cIn, color cOut, float thicknessLocal) {
     if (distribution) newDistributionBoite(n) ;
     newDistribution = false ;
     displayBoite(size, ground, cIn, cOut, thicknessLocal) ;
  
  }
    
  void displayBoite(PVector size, boolean groundPosition, color cIn, color cOut, float thicknessLocal) {
    PVector pos = new PVector(0,height /2 ,0) ;
    float factorSpectrum = 0 ;
    int n = boiteList.size() ;
    for( int i = 0 ; i < n ; i++) {
      pos.x = (i *width/n) + (width/(n*2)) ;
      if(  i < band.length) factorSpectrum = band [IDobj][i] ;
      BOITEaMUSIQUE boiteAmusique = (BOITEaMUSIQUE) boiteList.get(i) ;
      boiteAmusique.showTheBoite(pos, size, factorSpectrum, groundPosition, cIn, cOut, thicknessLocal) ;
    }
  }
  
  
  void newDistributionBoite(int n) {
    boiteList.clear() ;
    for (int i = 0 ; i < n ; i++ ) addBoite(i) ;
  }
  
  void addBoite(int ID) {
    PVector size = new PVector (1,1,1) ;
    BOITEaMUSIQUE boiteAmusique = new BOITEaMUSIQUE(size, ID) ; 
    boiteList.add(boiteAmusique) ;
  }
}
//end object one







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
  
  void showTheBoite(PVector pos, PVector size, float factor, boolean groundLine, color cIn, color cOut, float thicknessLocal) {
    PVector newSize = new PVector (size.x, size.y *factor,size.z *factor ) ;
    //put the box on the ground !
    float horizon = pos.y - ( newSize.y *.5 ) ;
    fill(cIn ) ;
    stroke(cOut) ;
    strokeWeight(thicknessLocal) ;   
    pushMatrix() ;
    if (!groundLine) translate(pos.x, pos.y, pos.z) ; else translate(pos.x, horizon, pos.z) ;
    box(newSize.x,newSize.y,newSize.z) ;
    popMatrix() ;
  }
}
