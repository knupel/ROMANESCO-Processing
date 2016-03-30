/**
KOFOSPHERE || 2013 || 1.0.1
*/
class Kofosphere extends Romanesco {
  public Kofosphere() {
    //from the index_objects.csv
    romanescoName = "Kofosphere" ;
    IDobj = 15 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Kof";
    romanescoVersion = "Version 1.0.1";
    romanescoPack = "Base" ;
    romanescoRender = "P3D" ;
    romanescoMode = "Point color/Point mono/Box color/Box mono" ;
    romanescoSlider = "Fill hue,Fill sat,Fill bright,Fill alpha,Stroke hue,Stroke sat,Stroke bright,Stroke alpha,Thickness,Size X,Size Y,Size Z,Canvas X,Quantity,Speed X" ;
  }
  //GLOBAL

  Sphere sphere;
  
  //SETUP
  void setting() {
   // very strange start position to be in the middle of the Scene
   startPosition(IDobj, width/2 -(width/4), height/2 -(height/4), 0) ;
    // startPosition(IDobj, 0, width/2, -(height *2)) ;
    
    float startingRadius = width ;
    
    sphere = new Sphere(startingPosition[IDobj],startingRadius);
  }
  
  
  
  
  //DRAW
  void display() {
    float beatFactor = map(allBeats(IDobj), 1,12, 1., 3.5) ;
    float radius = map(canvas_x_item[IDobj], width/10, width, .01, 1.1) ;
    if(sound[IDobj]) radius = sq(radius) *beatFactor ; 
    
    // quantity of particules
    float quantity = map(quantity_item[IDobj],0 ,1, 10,200);
    // methode to limit the number of particules for the prescene
    if(!fullRendering) quantity /= 10. ;
    // methode to limit the number of particules for the complexe shape, in this case for the boxes
    if(fullRendering && (mode[IDobj] > 1 && mode[IDobj] < 4)) quantity /= 2.5 ;  
    
    // speed
    float ratio_speed = .1 ;
    float norm_speed = map(speed_x_item[IDobj],0,1,0,1.5) ;
    norm_speed *= norm_speed ;
    if(reverse[IDobj]) norm_speed *= ratio_speed ; else norm_speed *= -ratio_speed ;
    Vec2 speed = Vec2(norm_speed) ;
    speed.mult(.5 +left[IDobj], .5 +right[IDobj]) ;

    // size for the box
    float factorSizeDivide = .025 ;
    float newSizeX = size_x_item[IDobj] *factorSizeDivide ;
    float newSizeY = size_y_item[IDobj] *factorSizeDivide ;
    float newSizeZ = size_z_item[IDobj] *factorSizeDivide ;
    // we make a square size to smooth the growth
    PVector size = new PVector(newSizeX *newSizeX, newSizeY *newSizeY,newSizeZ *newSizeZ) ; 
    
    sphere.drawSpheres(size, speed, radius, quantity, thickness_item[IDobj], fill_item[IDobj], stroke_item[IDobj],mode[IDobj]);
    

    
    // INFO
    objectInfo[IDobj] = ("Quantity " + (int)quantity +  " - Speed ") ;

  }
  
  
  // ANNEXE VOID
  
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
          strokeWeight(factorSize *3);
          stroke(colorIn);
          point(posX *deform,posY *deform,posZ *deform);
        } else if ( mode > 1 && mode < 4 ) {
          pushMatrix() ;
          strokeWeight(thickness);
          stroke(colorOut);
          fill(colorIn);
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
