/**
SPIRALE  || 2011 || 1.3.5
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
    RPE_version = "Version 1.3.5";
    RPE_pack = "Base" ;
    /*
    RPE_mode = "Point/Ellipse/Triangle/Rectangle/Star 4/Star 5/Star 9/Super Star 8/Super Star 12/Tetra/Box/Cross 2/Cross 3/Sphere low/Sphere medium/Sphere high" ;
    */
    RPE_mode = "Point/Ellipse/Triangle/Rectangle/Cross/Simple Star/Star/Super Star" ;

    RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Stroke hue,Stroke sat,Stroke bright,Stroke alpha,Thickness,Size X,Size Y,Size Z,Quantity,Speed X,Canvas X,Canvas Y,Swing X,Alignment" ;
  }
  //GLOBAL
     
    float speed ; 
    boolean reverseSpeed;
    float pos_swing ;
    int dir_swing = 1 ;
  //SETUP
  void setup() {
    setting_start_position(ID_item, width/2, height/2, 0) ;
    setting_start_direction(ID_item, 135,45) ;
    spirale = new Spirale() ;
  }
  
  //DRAW
  void draw() {

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

    // alignement
    float max_align = alignment_item[ID_item] *(height/10) ;
    if(swing_x_item[ID_item] > 0 && motion[ID_item] && horizon[ID_item]) {
      float align ;
      float speed_swing = swing_x_item[ID_item] *swing_x_item[ID_item] ;
      if(pos_swing > max_align || pos_swing < -max_align || allBeats(ID_item) > 8) {
        dir_swing *= -1 ;
      }
      if(pos_swing > max_align +1) pos_swing = max_align ;
      if(pos_swing < -max_align -1) pos_swing = -max_align ;
      speed_swing *= dir_swing ;
      pos_swing += speed_swing ;


    } else {
      pos_swing = max_align ;
    }

    // aspect
    thickness_item[ID_item] = thickness_item[ID_item] *.02 ;
    aspect_rope(fill_item[ID_item], stroke_item[ID_item], thickness_item[ID_item], costume[ID_item]) ;


    
    // mode
    select_costume_via_mode(ID_item, 8) ;
    
    Vec3 pos = Vec3() ; // we write that because the first part of the void is not available any more.
    spirale.update(pos, speed) ;
    spirale.show(n, nMax, size, z, canvas, costume[ID_item], horizon[ID_item], pos_swing) ;
    
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

  void show (int n, int nMax, PVector size, float z, PVector canvas, int which_costume, boolean horizon, float alignment) {
    n = n-1 ;
    
    translate += z ;
    ratioSize += .1 ;
    
    float ratioRendering = 1. ;
    if(FULL_RENDERING) ratioRendering = 1. ; else ratioRendering = 6. ;
    
    
    Vec3 size_final = Vec3(size.x *ratioSize *ratioRendering, size.y *ratioSize *ratioRendering, size.z *ratioSize *ratioRendering) ;



    //display Mode
    Vec3 pos = Vec3() ;
    costume_rope(pos, size_final, which_costume) ;
    //
    
    float new_pos_x = translate *canvas.x *ratioRendering ;
    float new_pos_y = translate *canvas.y *ratioRendering ;
    float new_pos_z = 0 ;
    if(horizon) new_pos_z = size.z *.5 *alignment ;

    translate (new_pos_x,new_pos_y,new_pos_z) ;
    rotate ( PI/6 ) ;

    if ( n > 0) { 
      show(n, nMax, size, z, canvas, which_costume, horizon, alignment) ; 
    } else{
      translate = 1. ;
      ratioSize = 1. ;
    }
  }
}