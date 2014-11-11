class Kofosphere extends SuperRomanesco {
  public Kofosphere() {
    //from the index_objects.csv
    romanescoName = "Kofosphere" ;
    IDobj = 18 ;
    IDgroup = 2 ;
    romanescoAuthor  = "Kof";
    romanescoVersion = "Version 1.0";
    romanescoPack = "Base" ;
    romanescoRender = "P3D" ;
    romanescoMode = "Point" ;
    romanescoSlider = "Hue fill,Saturation fill,Brightness fill,Alpha fill,Thickness,Canvas X,Quantity,Speed" ;
  }
  //GLOBAL

  Sphere sphere;
  
  //SETUP
  void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
    
    float startingRadius = width ;
    
    sphere = new Sphere(startingPosition[IDobj],startingRadius);
  }
  
  
  
  
  //DRAW
  void display() {
    canvasXObj[IDobj] = map(canvasXObj[IDobj], width/10, width, .01, 3.) ;
    sphere.drawSpheres(speedObj[IDobj], canvasXObj[IDobj], quantityObj[IDobj], thicknessObj[IDobj], fillObj[IDobj]);
    

    
    // INFO
    objectInfo[IDobj] = ("Quantity of particules " + " - Speed ") ;

  }
  
  
  // ANNEXE VOID
  
}




////////////////////////////////////////////////
class Sphere{
  PVector pos = new PVector();
  float radius;
  float density = 6.;
  color c;

  
  // CONSTRUCTOR
  Sphere(PVector pos, float radius){
    this.pos = pos.copy();
    this.radius = radius;
    // as always
    noiseSeed(19);
  }

  
  
  void drawSpheres(float speed, float sizeFactor, float quantity, float thickness, color c) {
    speed *= 100 ;
    quantity *=.01 ;
    // param
    speed = .00001 +(100 -speed)  ;
    float speedRotateX = 3. *speed ;
    float speedRotateY = 90. *speed ;
    //
    float newRadius =  radius *sizeFactor ;
    /// color
    float hue = hue(c) ;
    float saturation = saturation(c) ;
    float brightness = brightness(c) ;
    float opacity = alpha(c) ;

   

    
    pushMatrix();
    translate(pos.x,pos.y,pos.z);
    
    float d = noise(frameCount/100)*(1500.0 +(1500 *quantity));
    // density = noise(frameCount/200)*quantity +3.0;
    
    density = 2.9 +(20*(1 -quantity)) ;


    rotateX(frameCount/speedRotateX);
    rotateY(frameCount/speedRotateY);
    
    
    for(float f = -180 ; f < d; f += density){
      // we put this calcul here, because we don't need this calcul in the next loop.
      // it's more lighty for the computation
      c = color(map(f,0,d,0,360),saturation,brightness,opacity);
      stroke(c);
        
      for(float ff = -90 ; ff < 90; ff += density){
        
        // apparence
        
        float x = cos(radians(f)) *newRadius *cos(radians(ff));
        float y = sin(radians(f)) *newRadius *cos(radians(ff));
        float z = sin(radians(ff)) *newRadius;
        
        int maxThickness = height/3 ; // it's the max from Romanesco Thickness.
        strokeWeight(map(abs(modelZ(x,y,z)),(maxThickness -thickness),0,.005,1));
        
        // position
        float deform = noise((frameCount +lerp(f,ff,noise((frameCount+ff)/222.0))) *.003) *1.33;
        point(x *deform,y *deform,z *deform);
        
      }
    }
    println("je suis là", frameCount, frameRate) ;

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
