/**
SPIRALE
2011-2019
v 1.4.3
*/

Spirale spirale ; 

class Spirale_romanesco extends Romanesco {
  public Spirale_romanesco() {
    //from the index_objects.csv
    item_name = "Spirale" ;
    item_author  = "Stan le Punk";
    item_version = "Version 1.4.3";
    item_pack = "Base 2011-2019" ;
    item_costume = "ellipse/triangle/rect/cross/pentagon/flower/Star 5/Star 7/Super Star 8/Super Star 12/point" ;
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
    // diameter_is = true;
    canvas_x_is = true;
    canvas_y_is = true;
    canvas_z_is = true;

    // frequence_is = true;
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
    set_item_pos(width/2, height/2, 0) ;
    set_item_dir(PI*0.75,QUARTER_PI) ;
    spirale = new Spirale() ;
  }
  
  //DRAW
  void draw() {

    //quantity
    int n ;
    int nMax = 1 ;
     nMax = 1 + int(get_quantity().value() *300) ; 
    if(!FULL_RENDERING) nMax *= .1 ;
    n = nMax ;

    float max = map(width,100,3000,1.0,1.1)  ;
    float z = max ;
    //speed
    
    // if(reverse_is()) reverseSpeed = !reverseSpeed ;
    
    if(motion_is()) {
      float s = map(get_speed_x().value(),get_speed_x().min(),get_speed_x().max(),0,8) ;
      s *= s ;
      if(reverse_is()) speed = s *tempo_rom[ID_item] ; else speed = s *tempo_rom[ID_item] *-1. ;
    } else { 
      speed = 0.0 ;
    }
    //sound volume
    float minValueVol = .8 ;
    float maxValueVol = 5.5 ;
    if(!sound_is()) maxValueVol = 1 ;
    float volumeLeft = map (left[ID_item], 0,1, minValueVol, maxValueVol ) ;
    float volumeRight = map (right[ID_item], 0,1, minValueVol, maxValueVol ) ;
    float volumeMix = map (mix[ID_item], 0,1, minValueVol, maxValueVol ) ;
    
    
    //SIZE
    float transient_map = map(transient_value[1][ID_item] +transient_value[3][ID_item] +transient_value[4][ID_item],1,9,1,50) ;
    float minValueSize = .5 ;
    float maxValueSize = width *.003 ;
    
    // float sx = map(get_size_x(), .1, width, minValueSize, maxValueSize) ;
    // float sy = map(get_size_y(), .1, width, minValueSize, maxValueSize) ;
    // float sz  = map(get_size_z(), .1, width, minValueSize, maxValueSize) ; 
    // sx *= sx ;
    // sy *= sy ;
    // sz *= sz ;

    vec3 s = map(get_size(),get_size_x().min, get_size_x().max(),minValueSize,maxValueSize);
    s.pow(4);
    float temp_size_x = s.x() *volumeLeft *transient_map;
    float temp_size_y = s.y() *volumeRight *transient_map;
    float temp_size_z = s.z() *volumeMix *transient_map;  
    vec3 size = vec3(temp_size_x,temp_size_y,temp_size_z);
    
    //amplitude of the translate
    float minValueCanvas = .01 ;
    float maxValueCanvas = 3 *(transient_value[2][ID_item] *.7);
    // float canvasXtemp = map(get_canvas_x().value(), width *.1, width,minValueCanvas,maxValueCanvas);
    // float canvasYtemp = map(get_canvas_y().value(), width *.1, width,minValueCanvas,maxValueCanvas);
    // float canvasZtemp = map(get_canvas_z().value(), width *.1, width,minValueCanvas,maxValueCanvas);
    // vec3 canvas = vec3(canvasXtemp,canvasYtemp,canvasZtemp);
    vec3 canvas = map(get_canvas(),get_canvas_x().min(),get_canvas_y().max(),minValueCanvas,maxValueCanvas);

    // alignement
    float max_align = get_alignment().value() *(height/10) ;
    if(get_swing_x().value() > 0 && motion_is() && horizon_is()) {
      float align ;
      float speed_swing = get_swing_x().value() *get_swing_x().value();
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
    aspect(get_fill(), get_stroke(), get_thickness().value());

    // mode    
    vec3 pos = vec3() ; // we write that because the first part of the void is not available any more.
    spirale.update(pos, speed);
    float ratio_size = map(get_area().value(),get_area().min(),get_area().max(),0,1);
    spirale.show(n, nMax, size, z, canvas, get_costume(), horizon_is(), pos_swing,ratio_size) ;
    
    // info display
    item_info[ID_item] = ("Speed "+speed+ " - Amplitude " + map(z, 1.01, 1.27, 1,100) + " - Quantity " + nMax) ;
  }

}










//CLASS
class Spirale {  
  float rotation ;
  float angle  ;

  Spirale () { }






  void update(vec pos_temp, float speed) {
    vec3 pos = vec3() ;
    if(pos_temp instanceof vec2) {
      vec2 p = (vec2) pos_temp ;
      pos.set(p.x, p.y, 0) ;
    } else if(pos_temp instanceof vec3) {
      vec3 p = (vec3) pos_temp ;
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

  void show (int n, int nMax, vec3 size, float z, vec3 canvas, Costume costume, boolean horizon, float alignment, float ratio_size) {
    n = n-1 ;
    
    translate += z ;
    ratioSize += .1 ;
    
    float ratioRendering = 1. ;
    if(FULL_RENDERING) {
      ratioRendering = 1. ; 
    } else {
      ratioRendering = 6. ;
    }
    
    
    vec3 size_final = vec3(size.x *ratioSize *ratioRendering, size.y *ratioSize *ratioRendering, size.z *ratioSize *ratioRendering) ;



    //display Mode
    vec3 pos = vec3();
    set_ratio_costume_size(ratio_size);
    costume(pos, size_final,costume);
    //
    vec3 canvas_temp = canvas.copy();
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
      show(n,nMax,size,z,canvas,costume,horizon,alignment,ratio_size); 
    } else{
      translate = 1.;
      ratioSize = 1.;
    }
  }
}