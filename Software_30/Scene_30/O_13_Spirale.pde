/**
SPIRALE  || 2011 || 1.3.1
*/
Spirale spirale ; 
//object three
class SpiraleRomanesco extends Romanesco {
  public SpiraleRomanesco() {
    //from the index_objects.csv
    RPE_name = "Spirale" ;
    ID_item = 13 ;
    ID_group = 1 ;
    RPE_author  = "Stan le Punk";
    RPE_version = "Version 1.3.1";
    RPE_pack = "Base" ;
    RPE_mode = "Rectangle/Ellipse/Box" ;
    RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Stroke hue,Stroke sat,Stroke bright,Stroke alpha,Thickness,Size X,Size Y,Size Z,Quantity,Speed X,Canvas X,Canvas Y,Alignment" ;
  }
  //GLOBAL
     
    float speed ; 
    boolean reverseSpeed;
  //SETUP
  void setting() {
    startPosition(ID_item, width/2, height/2, 0) ;
    spirale = new Spirale() ;
  }
  //DRAW
  void display() {
    aspect_rpe(ID_item) ;
    strokeWeight(thickness_item[ID_item]*.02) ;
    //quantity
    int n ;
    int nMax = 1 ;
     nMax = 1 + int(quantity_item[ID_item] *300) ; 
    if(!FULL_RENDERING) nMax *= .1 ;
    n = nMax ;

    float max = map(width,100,3000,1.0,1.1)  ;
    float z = max ;
    //speed
    
    // if(reverse[ID_item]) reverseSpeed = !reverseSpeed ;
    
    if(motion[ID_item]) {
      float s = map(speed_x_item[ID_item],0,1,0,8) ;
      s *= s ;
      if(reverse[ID_item]) speed = s *tempo[ID_item] ; else speed = s *tempo[ID_item] *-1. ;
    } else { 
      speed = 0.0 ;
    }
    //sound volume
    float minValueVol = .8 ;
    float maxValueVol = 5.5 ;
    if(!sound[ID_item]) maxValueVol = 1 ;
    float volumeLeft = map (left[ID_item], 0,1, minValueVol, maxValueVol ) ;
    float volumeRight = map (right[ID_item], 0,1, minValueVol, maxValueVol ) ;
    float volumeMix = map (mix[ID_item], 0,1, minValueVol, maxValueVol ) ;
    
    
    //SIZE
    float beatMap = map(beat[ID_item] +snare[ID_item] +hat[ID_item],1,9,1,50) ;
    float minValueSize = .5 ;
    float maxValueSize = width *.003 ;
    
    float widthTemp = map(size_x_item[ID_item], .1, width, minValueSize, maxValueSize) ;
    float heightTemp = map(size_y_item[ID_item], .1, width, minValueSize, maxValueSize) ;
    float depthTemp  = map(size_z_item[ID_item], .1, width, minValueSize, maxValueSize) ;
    
    widthTemp *= widthTemp ;
    heightTemp *= heightTemp ;
    depthTemp *= depthTemp ;

    
    float widthObj = pow(widthTemp, 3) *volumeLeft *beatMap ;
    float heightObj = pow(heightTemp, 3) *volumeRight *beatMap ;
    float depthObj = pow(depthTemp, 3) *volumeMix *beatMap ;
    
    PVector size = new PVector(widthObj, heightObj, depthObj) ;
    
    //amplitude of the translate
    float minValueCanvas = .01 ;
    float maxValueCanvas = 3 *(kick[ID_item] *.7) ;
    float canvasXtemp = map(canvas_x_item[ID_item], width *.1, width,minValueCanvas,maxValueCanvas) ;
    float canvasYtemp = map(canvas_y_item[ID_item], width *.1, width,minValueCanvas,maxValueCanvas) ;
    // float canvasZtemp = map(canvas_z_item[ID_item], width *.1, width,minValueCanvas,maxValueCanvas) ;
    PVector canvas = new PVector(canvasXtemp, canvasYtemp)  ;
    
    PVector pos = new PVector() ; // we write that because the first part of the void is not available any more.
    spirale.actualisation (pos, speed) ;
    spirale.affichage (n, nMax, size, z, canvas, mode[ID_item], horizon[ID_item], alignment_item[ID_item]) ;
    
    // info display
    objectInfo[ID_item] = ("Speed "+speed+ " - Amplitude " + map(z, 1.01, 1.27, 1,100) + " - Quantity " + nMax) ;
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
    if(FULL_RENDERING) ratioRendering = 1. ; else ratioRendering = 6. ;
    
    
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
