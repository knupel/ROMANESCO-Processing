Spirale spirale ; 
//object three
class SpiraleRomanesco extends Romanesco {
  public SpiraleRomanesco() {
    //from the index_objects.csv
    romanescoName = "Spirale" ;
    IDobj = 13 ;
    IDgroup = 2 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Version 1.3.1";
    romanescoPack = "Base" ;
    romanescoRender = "P3D" ;
    romanescoMode = "Rectangle/Ellipse/Box" ;
    romanescoSlider = "Hue fill,Saturation fill,Brightness fill,Alpha fill,Hue stroke,Saturation stroke,Brightness stroke,Alpha stroke,Thickness,Size X,Size Y,Size Z,Quantity,Speed,Canvas X,Canvas Y,Alignment" ;
  }
  //GLOBAL
     
    float speed ; 
    boolean reverseSpeed;
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
    int nMax = 1 ;
     nMax = 1 + int(quantityObj[IDobj] *300) ; 
    if(!fullRendering) nMax *= .1 ;
    n = nMax ;

    float max = map(width,100,3000,1.0,1.1)  ;
    float z = max ;
    //speed
    
    // if(reverse[IDobj]) reverseSpeed = !reverseSpeed ;
    
    if(motion[IDobj]) {
      float s = map(speedObj[IDobj],0,1,0,8) ;
      s *= s ;
      if(reverse[IDobj]) speed = s *tempo[IDobj] ; else speed = s *tempo[IDobj] *-1. ;
    } else { 
      speed = 0.0 ;
    }
    //sound volume
    float minValueVol = .8 ;
    float maxValueVol = 5.5 ;
    if(!sound[IDobj]) maxValueVol = 1 ;
    float volumeLeft = map (left[IDobj], 0,1, minValueVol, maxValueVol ) ;
    float volumeRight = map (right[IDobj], 0,1, minValueVol, maxValueVol ) ;
    float volumeMix = map (mix[IDobj], 0,1, minValueVol, maxValueVol ) ;
    
    
    //SIZE
    float beatMap = map(beat[IDobj] +snare[IDobj] +hat[IDobj],1,9,1,50) ;
    float minValueSize = .5 ;
    float maxValueSize = width *.003 ;
    
    float widthTemp = map(sizeXObj[IDobj], .1, width, minValueSize, maxValueSize) ;
    float heightTemp = map(sizeYObj[IDobj], .1, width, minValueSize, maxValueSize) ;
    float depthTemp  = map(sizeZObj[IDobj], .1, width, minValueSize, maxValueSize) ;
    
    widthTemp *= widthTemp ;
    heightTemp *= heightTemp ;
    depthTemp *= depthTemp ;

    
    float widthObj = pow(widthTemp, 3) *volumeLeft *beatMap ;
    float heightObj = pow(heightTemp, 3) *volumeRight *beatMap ;
    float depthObj = pow(depthTemp, 3) *volumeMix *beatMap ;
    
    PVector size = new PVector(widthObj, heightObj, depthObj) ;
    
    //amplitude of the translate
    float minValueCanvas = .01 ;
    float maxValueCanvas = 3 *(kick[IDobj] *.7) ;
    float canvasXtemp = map(canvasXObj[IDobj], width *.1, width,minValueCanvas,maxValueCanvas) ;
    float canvasYtemp = map(canvasYObj[IDobj], width *.1, width,minValueCanvas,maxValueCanvas) ;
    // float canvasZtemp = map(canvasZObj[IDobj], width *.1, width,minValueCanvas,maxValueCanvas) ;
    PVector canvas = new PVector(canvasXtemp, canvasYtemp)  ;
    
    PVector pos = new PVector() ; // we write that because the first part of the void is not available any more.
    spirale.actualisation (pos, speed) ;
    spirale.affichage (n, nMax, size, z, canvas, mode[IDobj], horizon[IDobj], alignmentObj[IDobj]) ;
    
    // info display
    objectInfo[IDobj] = ("Speed "+speed+ " - Amplitude " + map(z, 1.01, 1.27, 1,100) + " - Quantity " + nMax) ;
  }
}





//CLASS
class Spirale extends Rotation {  
  Spirale () { 
    super () ;
  }
  float translate = 1. ;
  float ratioSize = 1. ;

  void affichage (int n, int nMax, PVector size, float z, PVector canvas, int mode, boolean horizon, float alignment) {
    n = n-1 ;
    
    translate += z ;
    ratioSize += .1 ;
    
    float ratioRendering = 1. ;
    if(fullRendering) ratioRendering = 1. ; else ratioRendering = 6. ;
    
    
    PVector newSize = new PVector (size.x *ratioSize *ratioRendering, size.y *ratioSize *ratioRendering, size.z *ratioSize *ratioRendering) ;

    //display Mode
    if (mode == 0 )      rect (0,0, newSize.x, newSize.y ) ;
    else if (mode == 1 ) ellipse (0,0,newSize.x,newSize.y) ;
    else if (mode == 2 ) box (newSize.x,newSize.y,newSize.z) ;
    //
    
    float new_pos_x = translate *canvas.x *ratioRendering ;
    float new_pos_y = translate *canvas.y *ratioRendering ;
    float new_pos_z = 0 ;
    if(horizon) new_pos_z = size.z *.5 *alignment ;

    translate (new_pos_x,new_pos_y,new_pos_z) ;
    rotate ( PI/6 ) ;

    if ( n > 0) { 
      affichage (n, nMax, size, z, canvas, mode, horizon, alignment) ; 
    } else{
      translate = 1. ;
      ratioSize = 1. ;
    }
  }
}
