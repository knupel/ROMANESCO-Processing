/**
KOFOSPHERE 
2013-2018
v 1.1.1
*/
class Kofosphere extends Romanesco {
  public Kofosphere() {
    item_name = "Kofosphere" ;
    item_author  = "Kof";
    item_version = "Version 1.1.1";
    item_pack = "Base 2013-2018" ;
    item_costume = "point/ellipse/triangle/rect/cross/pentagon/Star 5/Star 7/Super Star 8/Super Star 12";
    item_mode = "monochrome/polychrome" ;
    /*
    item_costume = "";
    item_mode = "Point color/Point mono/Box color/Box mono" ;
    */
    // item_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Stroke hue,Stroke sat,Stroke bright,Stroke alpha,Thickness,Size X,Size Y,Size Z,Canvas X,Quantity,Speed X" ;
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
    // canvas_y_is = true;
    // canvas_z_is = true;

    frequence_is = true;
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
    // jit_z_is = true;
    // swing_x_is = true;
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
    // align_is  = true;
    // repulsion_is = true;
    // attraction_is = true;
    // density_is = true;
    // influence_is = true;
    // calm_is = true;
    // spectrum_is = true;
  }
  //GLOBAL

  Sphere sphere;
  
  //SETUP
  void setup() {
   setting_start_position(ID_item, width/2, height/2, 0) ;
   float startingRadius = width ;
   sphere = new Sphere(Vec2(item_setting_position[0][ID_item].x,item_setting_position[0][ID_item].y),startingRadius);
 }
  
  
  
  
  //DRAW
  void draw() {
    float beatFactor = map(all_transient(ID_item), 1,12, 1., 3.5);
    float radius = map(canvas_x_item[ID_item], width/10, width, .01, 1.1);
    if(sound[ID_item]) radius = sq(radius) *beatFactor ; 
    
    // quantity of particules
    float ratio_num = quantity_item[ID_item] *quantity_item[ID_item];
    int max = 300;
    int quantity = (int)map(ratio_num,0,1,10,max); 
    if(get_costume() == POINT_ROPE && FULL_RENDERING) {
      quantity *= 10;
    }
    
    // speed
    float ratio_speed = .1 ;
    float norm_speed = map(speed_x_item[ID_item],0,1,0,1.5) ;
    norm_speed *= norm_speed ;
    if(reverse[ID_item]) norm_speed *= ratio_speed ; else norm_speed *= -ratio_speed;
    Vec2 speed = Vec2(norm_speed) ;
    speed.mult(.5 +left[ID_item], .5 +right[ID_item]) ;

    // size for the box
    Vec3 size = Vec3(size_x_item[ID_item],size_y_item[ID_item],size_z_item[ID_item]); 
    size.mult(2);
    sphere.drawSpheres(size,speed,radius,quantity,get_costume(),ID_item);

    
    // INFO
    item_info[ID_item] = ("Quantity " + quantity +  " - Speed ") ;

  }
}




//
private class Sphere{
  
  Vec2 pos;
  float radius;
  float density = 6.;
  float speedRotateX  ;
  float speedRotateY ;

  // CONSTRUCTOR
  Sphere(Vec2 pos, float radius){
    this.pos = pos.copy();
    this.radius = radius;
    // as always
    noiseSeed(19);
  }

  
  float newRadius ;
  void drawSpheres(Vec3 size, Vec2 speed, float radiusFactor, float quantity, int which_costume, int ID) {
    boolean kofosphereInColor ;
    //color mode
    if(mode[ID]==0) {
      kofosphereInColor = false; 
    } else {
      kofosphereInColor = true;
    }
    
    float number_quantity = 1500.;
    quantity = (float)quantity *(1/number_quantity) ;
    // param
    speedRotateX += speed.x ;
    speedRotateY += speed.y ;
    //
    newRadius = radius *radiusFactor ;
    /// color
    float hueIn = hue(fill_item[ID]) ;
    float saturationIn = saturation(fill_item[ID]) ;
    float brightnessIn = brightness(fill_item[ID]) ;
    float opacityIn = alpha(fill_item[ID]) ;
    
    float hueOut = hue( stroke_item[ID]) ;
    float saturationOut = saturation(stroke_item[ID]) ;
    float brightnessOut = brightness(stroke_item[ID]) ;
    float opacityOut = alpha(stroke_item[ID]) ;

    
    pushMatrix();
    translate(pos);
    //speed rotation
    rotateX(speedRotateX);
    rotateY(speedRotateY);
    

    // int frequence = 100 ; KOF value
    float frequence = map(frequence_item[ID],1,0,1,200);
    if(frequence < 1) frequence = 1;
    float d = noise(frameCount/frequence)*(number_quantity +(number_quantity *quantity));
    density = 2.9 +(20*(1 -quantity));
    

    
    for(float f = -180 ; f < d; f += density){
      // we put this calcul here, because we don't need this calcul in the next loop.
      // it's more lighty for the computation
      if(kofosphereInColor) {
        hueIn = map(f,0,d,0,360) ;
        hueOut = map(f,0,d,0,360) ;
      }
      int c_fill = color(hueIn,saturationIn,brightnessIn,opacityIn);
      int c_stroke = color(hueOut,saturationOut,brightnessOut,opacityOut);
        
      for(float ff = -90 ; ff < 90; ff += density){
        
        // apparence
        // float max_factor = 250.; // KOF value
        float max_factor = width;
        float x = cos(radians(f)) *max_factor *cos(radians(ff));
        float y = sin(radians(f)) *max_factor *cos(radians(ff));
        float z = sin(radians(ff)) *max_factor;
        float ratio_size = modelZ(x,y,z);
        float factor_size = map(abs(ratio_size),0,max_factor,.005,1);

        float thickness = thickness_item[ID];
        Vec3 def_size = size.copy();
        boolean use_factor_is = true;
        if(use_factor_is) {
          thickness *= factor_size;
          def_size.mult(factor_size);
        }
        
        // position
        float pos_x = cos(radians(f)) *newRadius *cos(radians(ff));
        float pos_y = sin(radians(f)) *newRadius *cos(radians(ff));
        float pos_z = sin(radians(ff)) *newRadius;
        float deform = noise((frameCount +lerp(f,ff,noise((frameCount+ff)/222.0))) *.003) *1.33;
        
        // display
        aspect_rope(c_fill,c_stroke,thickness);
        aspect_is(fill_is[ID],stroke_is[ID]);
        set_ratio_costume_size(map(area_item[ID],width*.1, width*TAU,0,1));
        Vec3 pos = Vec3(pos_x *deform, pos_y *deform, pos_z *deform);
        costume_rope(pos,def_size,which_costume);
        
      }
    }

    // axis();
    popMatrix();

  }

  void axis(){
    stroke(255,20);
    strokeWeight(3);
    line(-200,0,0,200,0,0);
    line(0,-200,0,0,200,0);
    line(0,0,-200,0,0,200);

  }

}