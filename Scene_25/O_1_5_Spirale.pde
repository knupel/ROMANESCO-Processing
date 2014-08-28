Spirale spirale ; 
//object three
class SpiraleRomanesco extends SuperRomanesco {
  public SpiraleRomanesco() {
    //from the index_objects.csv
    romanescoName = "Spirale" ;
    IDobj = 5 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Version 1.2";
    romanescoPack = "Base" ;
    romanescoRender = "P3D" ;
    romanescoMode = "Rectangle/Ellipse/Box" ;
    romanescoSlider = "Hue fill,Saturation fill,Brightness fill,Alpha fill,Hue stroke,Saturation stroke,Brightness stroke,Alpha stroke,Thickness,Width,Height,Depth,Quantity,Speed,Amplitude" ;
  }
  //GLOBAL
     
    float speed ; ;
  //SETUP
  void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
    spirale = new Spirale() ;
  }
  //DRAW
  void display() {
    aspect(IDobj) ;
    strokeWeight(thicknessObj[IDobj]*.02) ;
    //quantity
    int n ;
    int nMax = 1 + (int)quantityObj[IDobj] *3 ;
    n = nMax ;
    //amplitude
    float ratioScreen = height*.1 ;
    if (ratioScreen < 1 ) ratioScreen = 1 ;
    float ratio = 1.25 + (ratioScreen *.0005) ; 
    float z = map(amplitudeObj[IDobj], 0,1,1.01, ratio)  ;
    //speed
    
    if(motion[IDobj]) {
      float s = map(speedObj[IDobj],0,1,0,8) ;
      s *= s ;
      speed = s *tempo[IDobj] ; 
    } else { 
      speed = 0.0 ;
    }
    //sound volume
    float volumeG = map (left[IDobj], 0,1, 0.5, 1.5 ) ;
    float volumeD = map (right[IDobj], 0,1, 0.5, 1.5 ) ;

    float heightObj = width    *sizeYObj[IDobj] *volumeG *(.01 /width) *kick[IDobj] ;
    float widthObj = height   *sizeXObj[IDobj]  *volumeD *(.01 /height) *hat[IDobj] ;
    float depthObj = height   *sizeZObj[IDobj]  *volumeD *(.01 /width) *hat[IDobj] ;
    PVector size = new PVector(widthObj, heightObj, depthObj) ;
    
    PVector pos = new PVector() ; // we write that because the first part of the void is not available any more.
    spirale.actualisation (pos, speed) ;
    spirale.affichage (n, nMax, size, z, mode[IDobj]) ;
    
    // info display
    objectInfo[IDobj] = ("Speed "+speed+ " / Amplitude " + map(z, 1.01, 1.27, 1,100) + " Quantity " + nMax) ;
  }
}





//CLASS
class Spirale extends Rotation {  
  Spirale () { 
    super () ;
  }
  void affichage (int n, int nMax, PVector size, float z, int mode) {
    n = n-1 ;
    /*
    int puissance = nMax-n ;
    float ap = pow (z,puissance) ;
    */

    //display Mode
    if (mode == 0 )      rect (0,0, size.x, size.y ) ;
    else if (mode == 1 ) ellipse (0,0,size.x,size.y) ;
    else if (mode == 2 ) box (size.x,size.y,size.z) ;
    //
    
    translate (2,0 ) ;
    rotate ( PI/6 ) ;
    scale(z) ; 

    if ( n > 0) { affichage (n, nMax, size, z,  mode ) ; }
  }
}
