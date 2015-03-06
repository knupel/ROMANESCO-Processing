class Boids extends SuperRomanesco {
  public Boids() {
    //Send to the index_objects.csv. This file is used by the controller
    romanescoName = "Boids" ;
    IDobj = 8 ; // depend where your want your object in Romanesco controller
    IDgroup = 1 ;  // choice a Romanesco Group 1 to 3
    romanescoAuthor  = "Too much people";
    romanescoVersion = "Version 1.0";
    romanescoPack = "Base" ;
    romanescoMode = "" ; // separate each name by "/"
    
    /* Choice which slider can influence your object, see the file in the FOLDER "...HELP/Romanesco Code/GLOBAL CODE OBJECT.txt"
    below an example.
    Becareful you must seprate the name slider by a coma without space*/
    romanescoSlider = "Hue fill,Saturation fill,Brightness fill,Alpha fill,Canvas X,Canvas Y,Canvas Z,Quantity,Attraction,Repulsion,Influence,Alignment,Width,Speed" ;
    /*
    Hue fill,Saturation fill,Brightness fill,Alpha fill,
           Hue stroke,Saturation stroke,Brightness stroke, Alpha stroke,
           Thickness,
           Width,Height,Depth,
           Canvas X,Canvas Y,Canvas Z,
           Family,Quantity,Life,
           Speed,Direction,Angle,
           Amplitude,Attraction, Repulsion,
           Influence,Analyze" ;

    */
  }
  Flock flock;
  Canvas myCanvas ;
  PVector birthPlace ;
  int maxColorRef = 360 ; // here we are in HSB 360
  int rangeAroundYourColor = 70 ;
  int numOfBoid ;
  
  
  
  //SETUP
  void setting() {
   startPosition(IDobj, width/2, height/2, 0) ;
   // build the canvas where the boid can move
   PVector pos = new PVector (width/2, height/2, 0) ;
   PVector size = new PVector(width,width,width) ;
   // PVector size = new PVector(canvasXObj[IDobj],canvasYObj[IDobj],canvasZObj[IDobj]) ;
   myCanvas = new Canvas(pos, size) ;
   // color colorBoid = color(80,100,100) ;
   birthPlace = pos.copy() ;
   flock = new Flock() ;
  
  

  
  
  // flock.flockSetup() ;
 }
 
 //DRAW
  void display() {
    // MAIN method
  PVector size = new PVector(sizeXObj[IDobj] ,sizeXObj[IDobj],sizeXObj[IDobj]) ;
  size.mult(.1) ;
  float alignment = map(alignmentObj[IDobj],0,1,0,10) ;
  float cohesion = map(attractionObj[IDobj],0,1,0,10) ;
  float separation = map(repulsionObj[IDobj],0,1,0,10) ;
  PVector unity = new PVector(cohesion, separation) ;
  if(flock.listBoid.size() > 0 )flock.run(size, alignment, unity);
  
  // ANNEXE methods
  
  // GOAL of the boids
  //float depthGoal =sin(frameCount *.001) *300 ;
  // flock.goal(mouseX,mouseY, depthGoal);
  
  // INFLUENCE of the boid around him
  float ratioInfluence = influenceObj[IDobj] *400 +1 ;
  float influenceArea =  abs(sin(frameCount *.001) *ratioInfluence) ;
  flock.influence(influenceArea);
  
  // SPEED
  float speed = map(speedObj[IDobj],0,1,.1,10) ;
  flock.speed(speed) ;
  
  // cage size
  myCanvas.size.x = canvasXObj[IDobj] *10 ;
  myCanvas.size.y = canvasYObj[IDobj] *10 ;
  myCanvas.size.z = canvasZObj[IDobj] *10 ;
  myCanvas.update() ;

  flock.canvasSetting(myCanvas.left, myCanvas.right, myCanvas.top, myCanvas.bottom, myCanvas.front, myCanvas.back) ;
  
  // quantity of boids
  numOfBoid = int(quantityObj[IDobj] *1500 +20); //amount of boids to start the program with
  // if(!fullRendering) numOfBoid /= 15 ;
  
  // change saturation, brightness an alpha layer
  for(Boid b : flock.listBoid) {
    b.colorBoid = color(hue(b.colorBoid), saturation(fillObj[IDobj]), brightness(fillObj[IDobj]), alpha(fillObj[IDobj])) ;
  }
  
  
  if(flock.listBoid.size() < 1 ) {
    flock.rebirth(birthPlace, numOfBoid, fillObj[IDobj],maxColorRef, rangeAroundYourColor) ;
  }
  
  // clear the boids list
  // flock.clear() ;
  
  if(nTouch && action[IDobj]) {
   flock.rebirth(birthPlace, numOfBoid, fillObj[IDobj],maxColorRef, rangeAroundYourColor) ;
  }
    // INFO
    objectInfo[IDobj] = ("There is " + numOfBoid + " boids") ;
    if(displayInfo) {
      strokeWeight(1) ;
      stroke(255) ;
      myCanvas.canvasLine() ;
    }
  }
}
















// FLOCK
class Flock {
  ArrayList<Boid> listBoid = new ArrayList<Boid>(); //will hold the boids in this BoidList
  // float h; //for color
 //  color colorBoid ;
  // Univers
  float left, right, top, bottom, front, back ;
  // 
  PVector birthPlace ;
  
  // Constructor just to init
  Flock() {}
  
  
  // CONSTRUCTOR
  Flock(int n,color colorBoid) {
   birthPlace = new PVector(width/2,height/2,0) ;
    for(int i = 0; i < n ; i++) {
      listBoid.add(new Boid(birthPlace,colorBoid));
    }
  }
  
  
  // 
  Flock(PVector birthPlace, int n, color colorBoid) {
    this.birthPlace = birthPlace.copy() ;
    for(int i = 0; i < n ; i++) {
      listBoid.add(new Boid(birthPlace,colorBoid));
    }
  }
  
  
  // Boids Camaieu constructor
  Flock(PVector birthPlace, int n, color colorBoid, int max, int range) {
    float refColor = hue(colorBoid) ;
    this.birthPlace = birthPlace.copy() ;
    for(int i = 0; i < n ; i++) {
      float newHue = camaieu(max, refColor, range) ;
      colorBoid = color (newHue, saturation(colorBoid), brightness(colorBoid)) ;
      listBoid.add(new Boid(birthPlace,colorBoid));
    }
  }
  
  

  
  
  // SETUP
  void canvasSetting() {
    right = width ;
    left = 0 ;
    bottom = height ;
    top = 0 ;
    back = -300 ; 
    front = 300 ;
  }
  
  void canvasSetting(float left, float right, float top, float bottom, float front, float back) {
    this.left = left ;
    this.right = right ;
    this.top = top ;
    this.bottom = bottom ;
    this.front = front ;
    this.back = back ;
  }
  
  
  // DRAW
  void run(PVector size, float ratioAlignment, PVector unity) {
    //iterate through the list of boids 
    for(Boid b : listBoid) {
     // Boid tempBoid = (Boid)listBoid.get(i); //create a temporary boid to process and make it the current boid in the list
    //  b.colorBoid = colorBoid;
      b.settingBounds (left, right, top, bottom, front, back);
      b.run (listBoid, size, ratioAlignment, unity); //tell the temporary boid to execute its run method
    }
  }
  
  // ANNEXE and EXTERNAL
  
   void goal(float x, float y, float z) {
     for(Boid b : listBoid) b.goal(x,y,z);
   }
   
   void influence(float neighborhoodRadius) {
     for(Boid b : listBoid) b.influence(neighborhoodRadius);
   }
   
   
 void speed(float maxSpeed) {
    for(Boid b : listBoid) b.speed(maxSpeed);
  }
  
  // ADD and REMOVE boids
  
  // different rebirth
  void rebirth(int n) {
    listBoid.clear() ;
    for(int i = 0; i < n ; i++) listBoid.add(new Boid(birthPlace));
  }
  
  void rebirth(int n, color colorBoid) {
    listBoid.clear() ;
    for(int i = 0; i < n ; i++) listBoid.add(new Boid(birthPlace, colorBoid));
  }
  
 void rebirth(PVector birthPlace, int n, color colorBoid, int max, int range) {
   listBoid.clear() ;
    float refColor = hue(colorBoid) ;
    for(int i = 0; i < n ; i++) {
      float newHue = camaieu(max, refColor, range) ;
      colorBoid = color (newHue, saturation(colorBoid), brightness(colorBoid)) ;
      listBoid.add(new Boid(birthPlace,colorBoid));
    }
  }
  
  
  
  
  void clear(){
    listBoid.clear() ;
  }
  
  void add() {
    listBoid.add(new Boid(new PVector(birthPlace.x,birthPlace.y,birthPlace.z)));
  }
  
  void addBoid(Boid b) {
    listBoid.add(b);
  }
  
  // remove specific boid
  void remove(int n) {
    if(n < listBoid.size())
      listBoid.remove(n);
  }
  
  // remove the last boid
  void remove() {
    if(listBoid.size() > 0)
      listBoid.remove(listBoid.size()-1);
  }
}
// END FLOCK
///////////









// BOID
////////
class Boid {
  //fields
  PVector pos = new PVector() ;
  PVector acc = new PVector() ;
  PVector velNorm = new PVector() ;
  PVector ali = new PVector() ;
  PVector coh = new PVector() ;
  PVector sep = new PVector() ; 
  
  float neighborhoodRadius = 100 ; //radius in which it looks for fellow boids, we give 100 for default value
  float maxSpeed = 4; //maximum magnitude for the velocity vector
  float maxSteerForce = .1; //maximum magnitude of the steering vector
  color colorBoid = color(255) ;
  
  
  
  // Canvas where the boids can move
  float left, right, top, bottom, front, back ;
  
  //constructors
    Boid(PVector pos) {
    this.pos = pos.copy() ;
    velNorm = new PVector(random(-1,1),random(-1,1),random(1,-1));
  }
  
  Boid(PVector pos, color colorBoid) {
    this.colorBoid = colorBoid ;
    this.pos = pos.copy() ;
    velNorm = new PVector(random(-1,1),random(-1,1),random(1,-1));
  }
  
  Boid(PVector pos,PVector velNorm, float neighborhoodRadius) {
    this.pos = pos.copy() ;
    this.velNorm = velNorm.copy() ;
    this.neighborhoodRadius =neighborhoodRadius;
  }
  
  
  // DRAW
  void run(ArrayList boidList, PVector size, float ratioAlignment, PVector unity) {

    
    //acc.add(new PVector(0,.05,0));

    flock(boidList, ratioAlignment, unity);
    move();
    checkBounds();
    
    //display
    display(size);
  }
  
  
  // ANNEXE EXTERNAL METHOD
  void goal(float x, float y, float z) {
    acc.add(steer(new PVector(x,y,z),true));
  }
  
  
  void influence(float neighborhoodRadius) {
    this.neighborhoodRadius = neighborhoodRadius;
  }
  
  void speed(float maxSpeed) {
    this.maxSpeed = maxSpeed ;
  }
  
  
  
  
  
  
  
  
  // ANNEXE INTERNAL METHOD
  // BEHAVIOR
  void flock(ArrayList listBoids, float ratioAlignment, PVector unity) {
    ali = alignment(listBoids);
    coh = cohesion(listBoids);
    sep = seperation(listBoids);
   //  float ratioAlignment = 1 ; // original 1
    float ratioCohesion = unity.x ; // original 3
    float ratioSeparation = unity.y ; // original 1
    acc.add(PVector.mult(ali,ratioAlignment));
    acc.add(PVector.mult(coh,ratioCohesion));
    acc.add(PVector.mult(sep,ratioSeparation));
  }
  
  void move() {
    velNorm.add(acc); // add acceleration to velocity
    velNorm.limit(maxSpeed); // make sure the velocity vector magnitude does not exceed maxSpeed
    pos.add(velNorm); // add velocity to position
    acc.mult(0); // reset acceleration
  }
  
  
  
  // UNIVERS
  // seeting in the Flock Class
  void settingBounds(float left, float right, float top, float bottom, float front, float back) {
    this.left = left ;
    this.right = right ;
    this.top = top ;
    this.bottom = bottom ;
    this.front = front ;
    this.back = back ;
  }

  // check bound
  void checkBounds() {
    // width
    if(pos.x > right) pos.x = left ;
    if(pos.x < left) pos.x = right ;
    //height
    if(pos.y > bottom) pos.y = top ;
    if(pos.y < top) pos.y = bottom ;
    // depth
    if(pos.z > front) pos.z = back ;
    if(pos.z < back) pos.z = front ;
  }
  
  
  
  
  
  
  // ENGINE
  
  /* STEERING, If arrival==true, the boid slows to meet the target. Credit to Craig Reynolds */
  PVector steer(PVector target,boolean arrival) {
    PVector steer = new PVector(); //creates vector for steering
    if(!arrival) {
      steer.set(PVector.sub(target,pos)); //steering vector points towards target (switch target and pos for avoiding)
      steer.limit(maxSteerForce); //limits the steering force to maxSteerForce
    } else {
      PVector targetOffset = PVector.sub(target, pos);
      float distance=targetOffset.mag();
      float rampedSpeed = maxSpeed *(distance *.01);
      float clippedSpeed = min(rampedSpeed,maxSpeed);
      PVector desiredVelocity = PVector.mult(targetOffset, (clippedSpeed /distance));
      steer.set(PVector.sub(desiredVelocity, velNorm));
    }
    return steer;
  }
  
  // DODGE. If weight == true avoidance vector is larger the closer the boid is to the target
  PVector dodge(PVector target,boolean weight) {
    PVector steer = new PVector(); //creates vector for steering
    steer.set(PVector.sub(pos, target)); //steering vector points away from target
    if(weight)
      steer.mult(1/sq(PVector.dist(pos, target)));
    //steer.limit(maxSteerForce); //limits the steering force to maxSteerForce
    return steer;
  }
  
  
  // SEPARATION
  PVector seperation(ArrayList <Boid> list) {
    PVector posSum = new PVector();
    PVector repulse;
    for(Boid b : list) {
      float d = PVector.dist(pos,b.pos);
      if(d > 0 && d <= neighborhoodRadius) {
        repulse = PVector.sub(pos,b.pos);
        repulse.normalize();
        repulse.div(d);
        posSum.add(repulse);
      }
    }
    return posSum;
  }
  
  
  // ALIGNMENT
  PVector alignment(ArrayList <Boid> list) {
    PVector velSum = new PVector();
    int count = 0;
    for(Boid b : list) {
      float d = PVector.dist(pos,b.pos);
      if(d > 0 && d<= neighborhoodRadius) {
        velSum.add(b.velNorm);
        count++;
      }
    }
    if(count>0) {
      velSum.div((float)count);
      velSum.limit(maxSteerForce);
    }
    return velSum;
  }
  
  
  // COHESION
  PVector cohesion(ArrayList <Boid> list) {
    PVector posSum = new PVector();
    PVector steer = new PVector();
    int count = 0;
    for(Boid b : list) {
      float d = dist(pos.x,pos.y,b.pos.x,b.pos.y);
      if(d > 0 && d <= neighborhoodRadius) {
        posSum.add(b.pos);
        count++;
      }
    }
    if(count>0) posSum.div((float)count);

    steer = PVector.sub(posSum,pos);
    steer.limit(maxSteerForce); 
    return steer;
  }
  // END ENGINE
  
  
  
  
  
  
  
  
  // DISPLAY
  
  // bird
  float t=0;
  float flap = 0;
  
  void display(PVector size) {
    t+=.1;
    flap = 10*sin(t);
    
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    rotateY(atan2(-velNorm.z, velNorm.x));
    rotateZ(asin(velNorm.y /velNorm.mag()));
    stroke(colorBoid);
    noFill();
    noStroke();
    fill(colorBoid);
    bird(size.x, flap) ;
    
    endShape();
    //box(10);
    popMatrix();
  }
  
  
  void bird(float size, float flap) {
    //draw bird
    beginShape(TRIANGLES);
    vertex(3 *size, 0, 0);
    vertex(-3 *size, 2 *size, 0);
    vertex(-3 *size, -2 *size, 0);
    
    vertex(3 *size, 0, 0);
    vertex(-3 *size, 2 *size, 0);
    vertex(-3 *size, 0, 2 *size);
    
    vertex(3 *size, 0, 0);
    vertex(-3 *size, 0, 2 *size);
    vertex(-3 *size, -2 *size, 0);
    
    vertex(-3 *size, 0, 2 *size);
    vertex(-3 *size, 2 *size, 0);
    vertex(-3 *size, -2 *size, 0);
    
    //  wings
    vertex(2 *size, 0, 0);
    vertex(-1 *size, 0, 0);
    vertex(-1 *size, -8 *size, flap);
    
    vertex(2 *size, 0, 0);
    vertex(-1 *size, 0, 0);
    vertex(-1 *size, 8 *size, flap);
  }
  
  
}
