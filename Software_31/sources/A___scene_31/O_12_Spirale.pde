/**
SPIRALE
2011-2018
v 1.3.8
*/

Spirale spirale ; 
//object three
class SpiraleRomanesco extends Romanesco {
  public SpiraleRomanesco() {
    //from the index_objects.csv
    item_name = "Spirale" ;
    ID_item = 12 ;
    ID_group = 1 ;
    item_author  = "Stan le Punk";
    item_version = "Version 1.3.8";
    item_pack = "Base 2011" ;
    item_costume = "point/ellipse/triangle/rect/cross/pentagon/Star 5/Star 7/Super Star 8/Super Star 12" ;
    item_mode = "" ;

    // item_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Stroke hue,Stroke sat,Stroke bright,Stroke alpha,Thickness,Size X,Size Y,Size Z,Quantity,Speed X,Canvas X,Canvas Y,Swing X,Alignment" ;
    hue_fill_is = true;
    sat_fill_is = true;
    bright_fill_is = true;
    alpha_fill_is = true;
    hue_stroke_is = true;
    sat_stroke_is = true;
    bright_stroke_is = true;
    alpha_stroke_is = true;
    thickness_is = true;
    size_x_is = true;
    size_y_is = true;
    size_z_is = true;
    // font_size_is = true;
    canvas_x_is = true;
    canvas_y_is = true;
    canvas_z_is = true;

    // reactivity_is = true;
    speed_x_is = true;
    // speed_y_is = true;
    // speed_z_is = true;
    // spurt_x_is = true;
    // spurt_y_is = true;
    // spurt_z_is = true;
    // dir_x_is = true;
    // dir_y_is = true;
    // dir_z_is = true;
    // jit_x_is = true;
    // jit_y_is = true;
    // jit_z_is  = true;
    swing_x_is = true;
    // swing_y_is = true;
    // swing_z_is = true;

    quantity_is = true;
    // variety_is = true;
    // life_is = true;
    // flow_is = true;
    // quality_is = true;
    area_is = true;
    // angle_is = true;
    // scope_is = true;
    // scan_is = true;
    align_is = true;
    // repulsion_is = true;
    // attraction_is = true;
    // density_is = true;
    // influence_is = true;
    // calm_is = true;
    // spectrum_is = true;
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
    float transient_map = map(transient_value[1][ID_item] +transient_value[3][ID_item] +transient_value[4][ID_item],1,9,1,50) ;
    float minValueSize = .5 ;
    float maxValueSize = width *.003 ;
    
    float sx = map(size_x_item[ID_item], .1, width, minValueSize, maxValueSize) ;
    float sy = map(size_y_item[ID_item], .1, width, minValueSize, maxValueSize) ;
    float sz  = map(size_z_item[ID_item], .1, width, minValueSize, maxValueSize) ; 
    sx *= sx ;
    sy *= sy ;
    sz *= sz ;

    
    float temp_size_x = pow(sx, 3) *volumeLeft *transient_map;
    float temp_size_y = pow(sy, 3) *volumeRight *transient_map;
    float temp_size_z = pow(sz, 3) *volumeMix *transient_map;  
    Vec3 size = Vec3(temp_size_x,temp_size_y,temp_size_z);
    
    //amplitude of the translate
    float minValueCanvas = .01 ;
    float maxValueCanvas = 3 *(transient_value[2][ID_item] *.7);
    float canvasXtemp = map(canvas_x_item[ID_item], width *.1, width,minValueCanvas,maxValueCanvas);
    float canvasYtemp = map(canvas_y_item[ID_item], width *.1, width,minValueCanvas,maxValueCanvas);
    float canvasZtemp = map(canvas_z_item[ID_item], width *.1, width,minValueCanvas,maxValueCanvas);
    Vec3 canvas = Vec3(canvasXtemp,canvasYtemp,canvasZtemp);

    // alignement
    float max_align = alignment_item[ID_item] *(height/10) ;
    if(swing_x_item[ID_item] > 0 && motion[ID_item] && horizon[ID_item]) {
      float align ;
      float speed_swing = swing_x_item[ID_item] *swing_x_item[ID_item] ;
      if(pos_swing > max_align || pos_swing < -max_align || all_transient(ID_item) > 8) {
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
    aspect_rope(fill_item[ID_item], stroke_item[ID_item], thickness_item[ID_item], get_costume()) ;

    // mode    
    Vec3 pos = Vec3() ; // we write that because the first part of the void is not available any more.
    spirale.update(pos, speed);
    float ratio_size = map(area_item[ID_item],width*.1, width*r.PHI,0,1);
    spirale.show(n, nMax, size, z, canvas, get_costume(), horizon[ID_item], pos_swing,ratio_size) ;
    
    // info display
    item_info[ID_item] = ("Speed "+speed+ " - Amplitude " + map(z, 1.01, 1.27, 1,100) + " - Quantity " + nMax) ;
  }

}










//CLASS
class Spirale {  
  float rotation ;
  float angle  ;

  Spirale () { 
  }






  void update(Vec pos_temp, float speed) {
    Vec3 pos = Vec3() ;
    if(pos_temp instanceof Vec2) {
      Vec2 p = (Vec2) pos_temp ;
      pos.set(p.x, p.y, 0) ;
    } else if(pos_temp instanceof Vec3) {
      Vec3 p = (Vec3) pos_temp ;
      pos.set(p) ;
    }
    Float s = speed ;
    if(!s.isNaN()) rotation += speed;
    
    if (rotation > 360) {
      rotation = 0 ; 
    } else if (rotation < 0 ) {
      rotation = 360 ;
    }
    float angle = rotation ;
    //translate (pos) ;
    rotate(radians(angle) ) ;
  }


  float translate = 1. ;
  float ratioSize = 1. ;

  void show (int n, int nMax, Vec3 size, float z, Vec3 canvas, int which_costume, boolean horizon, float alignment, float ratio_size) {
    n = n-1 ;
    
    translate += z ;
    ratioSize += .1 ;
    
    float ratioRendering = 1. ;
    if(FULL_RENDERING) {
      ratioRendering = 1. ; 
    } else {
      ratioRendering = 6. ;
    }
    
    
    Vec3 size_final = Vec3(size.x *ratioSize *ratioRendering, size.y *ratioSize *ratioRendering, size.z *ratioSize *ratioRendering) ;



    //display Mode
    Vec3 pos = Vec3();
    set_ratio_costume_size(ratio_size);
    costume_rope(pos, size_final, which_costume) ;
    //
    Vec3 canvas_temp = canvas.copy();
    canvas_temp = mult(canvas,translate);
    canvas_temp.mult(ratioRendering);
    if(horizon) canvas_temp.z = canvas.z *.5 *alignment;
    translate(canvas_temp);
    /*
    float new_pos_x = translate *canvas.x *ratioRendering ;
    float new_pos_y = translate *canvas.y *ratioRendering ;
    float new_pos_z = 0 ;
    if(horizon) new_pos_z = size.z *.5 *alignment ;
    translate (new_pos_x,new_pos_y,new_pos_z) ;
    */

    
    rotate ( PI/6 ) ;

    if ( n > 0) { 
      show(n,nMax,size,z,canvas,which_costume,horizon,alignment,ratio_size); 
    } else{
      translate = 1.;
      ratioSize = 1.;
    }
  }
}