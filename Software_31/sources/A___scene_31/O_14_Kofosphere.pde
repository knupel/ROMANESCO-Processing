/**
KOFOSPHERE 
2013-2018
v 1.0.3
*/
class Kofosphere extends Romanesco {
  public Kofosphere() {
    item_name = "Kofosphere" ;
    ID_item = 14 ;
    ID_group = 1 ;
    item_author  = "Kof";
    item_version = "Version 1.0.3";
    item_pack = "Base 2013" ;
    item_costume = "";
    item_mode = "Point color/Point mono/Box color/Box mono" ;
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
    font_size_is = false;
    canvas_x_is = true;
    canvas_y_is = false;
    canvas_z_is = false;

    reactivity_is = false;
    speed_x_is = true;
    speed_y_is = false;
    speed_z_is = false;
    spurt_x_is = false;
    spurt_y_is = false;
    spurt_z_is = false;
    dir_x_is = false;
    dir_y_is = false;
    dir_z_is = false;
    jit_x_is = false;
    jit_y_is = false;
    jit_z_is  = false;
    swing_x_is = false;
    swing_y_is = false;
    swing_z_is = false;

    quantity_is = true;
    variety_is = false;
    life_is = false;
    flow_is = false;
    quality_is = false;
    area_is = false;
    angle_is = false;
    scope_is = false;
    scan_is = false;
    align_is = false;
    repulsion_is = false;
    attraction_is = false;
    density_is = false;
    influence_is = false;
    calm_is = false;
    spectrum_is = false;
  }
  //GLOBAL

  Sphere sphere;
  
  //SETUP
  void setup() {
   setting_start_position(ID_item, width/2, height/2, 0) ;
   float startingRadius = width ;
   sphere = new Sphere( new PVector(item_setting_position[0][ID_item].x,item_setting_position[0][ID_item].y),startingRadius);
 }
  
  
  
  
  //DRAW
  void draw() {
    float beatFactor = map(all_transient(ID_item), 1,12, 1., 3.5) ;
    float radius = map(canvas_x_item[ID_item], width/10, width, .01, 1.1) ;
    if(sound[ID_item]) radius = sq(radius) *beatFactor ; 
    
    // quantity of particules
    float quantity = map(quantity_item[ID_item],0 ,1, 10,200);
    // methode to limit the number of particules for the prescene
    if(!FULL_RENDERING) quantity /= 10. ;
    // methode to limit the number of particules for the complexe shape, in this case for the boxes
    if(FULL_RENDERING && (mode[ID_item] > 1 && mode[ID_item] < 4)) quantity /= 2.5 ;  
    
    // speed
    float ratio_speed = .1 ;
    float norm_speed = map(speed_x_item[ID_item],0,1,0,1.5) ;
    norm_speed *= norm_speed ;
    if(reverse[ID_item]) norm_speed *= ratio_speed ; else norm_speed *= -ratio_speed ;
    Vec2 speed = Vec2(norm_speed) ;
    speed.mult(.5 +left[ID_item], .5 +right[ID_item]) ;

    // size for the box
    float factorSizeDivide = .025 ;
    float newSizeX = size_x_item[ID_item] *factorSizeDivide ;
    float newSizeY = size_y_item[ID_item] *factorSizeDivide ;
    float newSizeZ = size_z_item[ID_item] *factorSizeDivide ;
    // we make a square size to smooth the growth
    PVector size = new PVector(newSizeX *newSizeX, newSizeY *newSizeY,newSizeZ *newSizeZ) ; 
    
    sphere.drawSpheres(size, speed, radius, quantity, thickness_item[ID_item], fill_item[ID_item], stroke_item[ID_item],mode[ID_item]);
    

    
    // INFO
    item_info[ID_item] = ("Quantity " + (int)quantity +  " - Speed ") ;

  }
}




////////////////////////////////////////////////
class Sphere{
  boolean kofosphereInColor ;
  PVector pos = new PVector();
  float radius;
  float density = 6.;
  // color colorIn, colorOut;
  float speedRotateX  ;
  float speedRotateY ;

  
  // CONSTRUCTOR
  Sphere(PVector pos, float radius){
    this.pos = pos.copy();
    this.radius = radius;
    // as always
    noiseSeed(19);
  }

  
  float newRadius ;
  void drawSpheres(PVector size, Vec2 speed, float radiusFactor, float quantity, float thickness, color colorIn, color colorOut, int mode) {
    //color mode
    if(mode%2==0) kofosphereInColor = true ; else kofosphereInColor = false ;
    
    quantity *=.01 ;
    // param
    speedRotateX += speed.x ;
    speedRotateY += speed.y ;
    //
    newRadius =  radius *radiusFactor ;
    /// color
    float hueIn = hue(colorIn) ;
    float saturationIn = saturation(colorIn) ;
    float brightnessIn = brightness(colorIn) ;
    float opacityIn = alpha(colorIn) ;
    
    float hueOut = hue(colorOut) ;
    float saturationOut = saturation(colorOut) ;
    float brightnessOut = brightness(colorOut) ;
    float opacityOut = alpha(colorOut) ;

   

    
    pushMatrix();
    translate(pos.x,pos.y,pos.z);
    //speed rotation
    rotateX(speedRotateX);
    rotateY(speedRotateY);
    
    float d = noise(frameCount/100)*(1500.0 +(1500 *quantity));
    density = 2.9 +(20*(1 -quantity)) ;
    

    
    for(float f = -180 ; f < d; f += density){
      // we put this calcul here, because we don't need this calcul in the next loop.
      // it's more lighty for the computation
      if(kofosphereInColor) {
        hueIn = map(f,0,d,0,360) ;
        hueOut = map(f,0,d,0,360) ;
      }
      colorIn = color(hueIn,saturationIn,brightnessIn,opacityIn);
      colorOut = color(hueOut,saturationOut,brightnessOut,opacityOut);
      

        
      for(float ff = -90 ; ff < 90; ff += density){
        
        // apparence
        float factor = 250. ;
        float x = cos(radians(f)) *factor  *cos(radians(ff));
        float y = sin(radians(f)) *factor *cos(radians(ff));
        float z = sin(radians(ff)) *factor;
        

        int maxThickness = height/3 ; // it's the max from Romanesco Thickness.
        float factorSize = map(abs(modelZ(x,y,z)),(maxThickness -thickness),0,.005,1) ;
        
        // position
        float posX = cos(radians(f)) *newRadius *cos(radians(ff));
        float posY = sin(radians(f)) *newRadius *cos(radians(ff));
        float posZ = sin(radians(ff)) *newRadius;
        float deform = noise((frameCount +lerp(f,ff,noise((frameCount+ff)/222.0))) *.003) *1.33;
        
        
        // DISPLAY MODE
        if(mode < 2 ) {
          /*
          strokeWeight(factorSize *3);
          stroke(colorIn);
          */
          aspect_rope(colorIn, colorIn, factorSize *3) ;
          point(posX *deform,posY *deform,posZ *deform);
        } else if ( mode > 1 && mode < 4 ) {
          pushMatrix() ;
          aspect_rope(colorIn, colorOut, thickness) ;
          translate(posX *deform,posY *deform,posZ *deform) ;
          // box(size.x, size.y, size.z) ;
          box(size.x *factorSize, size.y *factorSize, size.z *factorSize) ;
          popMatrix() ;
        }
        
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