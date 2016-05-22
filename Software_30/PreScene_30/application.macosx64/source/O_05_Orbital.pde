
/**
ORBITAL || 2015 || 0.0.2
*/
class Orbital extends Romanesco {
 
  // Diameter max
  float r_min;
  float r_max;
 
  // Shape spreaded dimensions
  float spreadL;
  float spreadW;
 
  // Process
  PVector rfactors = new PVector();
  PVector rotation = new PVector();
  PVector rotationToReach = new PVector();
 
  // attributes
  int iterations;
  float offset;
  float rad;
  float vel;
  int dir;
  float smoothf;
  float initialForce;
 
  Flock_Orbital flock;
 
  public Orbital() {
    RPE_name = "Orbital" ;
    ID_item = 5 ;
    ID_group = 1 ;
    RPE_author  = "Alexandre Petit";
    RPE_version = "Version 0.0.2";
    RPE_pack = "Workshop" ;
    RPE_mode = "" ; // separate the differentes mode by "/"
    /** 
    List of the available sliders
    "Hue fill,Saturation fill,Brightness fill,Alpha fill,Hue stroke,Saturation stroke,Brightness stroke,Alpha stroke,Thickness,
    Size X,Size Y,Size Z,Canvas X,Canvas Y,Canvas Z,Quantity,
    Speed,Direction,Angle,Amplitude,Analyze,Family,Life,Force" ; 
    */
    RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Stroke hue,Stroke sat,Stroke bright,Stroke alpha,Quantity,Speed X" ;
  }
 
  // Main method
  // setup
  void setup() {
    startPosition(ID_item, width/2, height/2, 0);
  
    flock = new Flock_Orbital();
  
    dir = 0;
    vel = radians(2);//radians(8);
    rad = 100;
    offset = 20;
    iterations = 16; // [!] iterations is binded to band. Do not go over 16 (band count) !!
    smoothf = .05;
    initialForce = 10;
  
    r_max = max(width, height) * .8;
    r_min = max(width, height) * .2;
    resetOrbit();
  
  
  }
 
  // draw
  void draw() {
    // it's nice to code the variable from the sliders or from sound... here to see easily what's happen in your object.
    float quantity = quantity_item[ID_item] *2. ;

    // display
    orbital_1(quantity) ;

    objectInfo[ID_item] = ("There is " + flock.size() + " orbital shape") ;
    

  }
 
  void orbital_1(float quantity) {
    update(quantity);
    render();
  }
 
 
  void update(float quantity) {
  
    checkControls();
  
    rotationToReach.x += rfactors.x * vel * speed_x_item[ID_item];
    rotationToReach.y += rfactors.y * vel * speed_x_item[ID_item];
    rotationToReach.z += rfactors.z * vel * speed_x_item[ID_item];
    rotation.x += (rotationToReach.x - rotation.x) * smoothf;
    rotation.y += (rotationToReach.y - rotation.y) * smoothf;
    rotation.z += (rotationToReach.z - rotation.z) * smoothf;
    normaliseRotation(); // keep values between 0 and 2PI // FIXME
  
  
    Boid_Orbital b;
    PVector force = new PVector(initialForce *kick[ID_item], 0, 0);
    int it = ceil(iterations *quantity);
    if(!FULL_RENDERING) it /= 10 ;
    float lSpreadL = 1 ;
    float lSpreadW = 1 ;
    for(int i = 0; i < it; i++) {
        if (sound[ID_item] && i < NUM_BANDS) {
            lSpreadL = spreadL * band[ID_item][i];
            lSpreadW = spreadW * band[ID_item][i];
        }
        b = new Boid_Orbital(offset + (float)i/iterations * (rad * mix[ID_item]), 0, 0, rotation, spreadW, lSpreadL);
        b.applyForce(force);
        flock.addBoid(b);
      
       
        rotation.mult(-1);
        b = new Boid_Orbital(offset + (float)i/iterations * (rad * mix[ID_item]), 0, 0, rotation, spreadW, lSpreadW);
        b.applyForce(force);
        flock.addBoid(b);
        rotation.mult(-1);
    }
  
    flock.update();
  }
 
  void checkControls() {
     if      (rTouch && action[ID_item]) changeDir();
     else if (xTouch && action[ID_item]) randomDir();
     else if (nTouch && action[ID_item]) randomPos();
     // else if (jTouch) ;//randomiserad = D_MIN + random(D_MAX - D_MIN);
     else if (kTouch && action[ID_item]) resetOrbit();
     else if (jTouch && action[ID_item]) jump();
  }
 
  void render() {
      //flock.render();
      flock.render(hue(fill_item[ID_item]),
                   saturation(fill_item[ID_item]),
                   brightness(fill_item[ID_item]),
                   alpha(fill_item[ID_item]),
                  
                   hue(stroke_item[ID_item]),
                   saturation(stroke_item[ID_item]),
                   brightness(stroke_item[ID_item]),
                   alpha(stroke_item[ID_item])
               );
                 
  }
 
  void changeDir() {
    int aux;
    do aux = (int)random(3);
    while(aux == dir);
    dir = aux;
  
    rfactors.set(0,0,0);
  
    switch(dir) {
      case 0 : rfactors.x = 1; break;
      case 1 : rfactors.y = 1; break;
      case 2 : rfactors.z = 1; break;
    }
  }
 
  void randomDir() {
    rfactors.x = random(1);
    rfactors.y = random(1);
    rfactors.z = random(1);
  }
 
  void randomPos() {
    rotationToReach.x = random(TWO_PI);
    rotationToReach.y = random(TWO_PI);
    rotationToReach.z = random(TWO_PI);
  }
 
  void resetOrbit() {
     rotationToReach.set(0,0,0);
     rfactors.set(0,radians(90),0);
  }
 
  void jump() {
    int amp = 30 ;
    rotationToReach.x = rotation.x;
    rotationToReach.y = rotation.y;
    rotationToReach.z = radians(random(-amp,amp));
  }
 
  // Normalise interpolation before value interpolation
  void normaliseRotation() {
     rotation.x = radians(degrees(rotation.x));
     rotation.y = radians(degrees(rotation.y));
     rotation.z = radians(degrees(rotation.z));
  }
 
 
}


// ----------------------------------------------------------------------------------------------------------------------------------------
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Flock class
// Does very little, simply manages the ArrayList of all the boids

class Flock_Orbital {
  ArrayList<Boid_Orbital> list_boids_orbital; // An ArrayList for all the boids

  Flock_Orbital() {
      list_boids_orbital = new ArrayList<Boid_Orbital>(); // Initialize the ArrayList
  }

  void update() {
  
      Boid_Orbital b;
      int size = list_boids_orbital.size();
      for(int i = size-1; i>=0; i--) {
          b = list_boids_orbital.get(i);
          if (b.isDead()) {
              list_boids_orbital.remove(i);
          } else {
              b.update();
          }
      }
  }
 
  void render() {
     render(360,0,100,100, 360,0,100,100);
  }
 
  void render(float fillH, float fillS, float fillB, float fillA, float strokeH, float strokeS, float strokeB, float strokeA) {
     for(Boid_Orbital b : list_boids_orbital) {
         pushMatrix();
         rotate(b.rotation.x, 1, 0, 0);
         rotate(b.rotation.y, 0, 1, 0);
         rotate(b.rotation.z, 0, 0, 1);
  
         b.render(fillH, fillS, fillB, fillA, strokeH, strokeS, strokeB, strokeA);  // Passing the entire list of boids to each boid individually
         popMatrix();
      }
  }

  void addBoid(Boid_Orbital b) {
      list_boids_orbital.add(b);
  }


  int size() {
    return list_boids_orbital.size();
  }
 
  void clear() {
      list_boids_orbital.clear();
  }
}


// ---------------------------------------------------------------------------------------------------------------------------
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Boid class
// Methods for Separation, Cohesion, Alignment added

class Boid_Orbital {

  PVector location;
  PVector velocity;
  PVector acceleration;
 
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  float friction;    // Friction
 
  PVector rotation;
  PVector source;
 
  int lifetime;
  int life;
 
  
  float L = 20;
  float W = 1;
 
  Boid_Orbital(float x, float y, float z, PVector _rotation, float _w, float _l) {
    acceleration = new PVector(0,0,0);
    velocity = new PVector(0,0,0);
    location = new PVector(x,y,z);
    lifetime = 300;
    life = lifetime;
    rotation = _rotation.get();
    source = location.get();
    maxspeed = 30;
    maxforce = 4;
    friction = .97;
  }

  // Method to update location
  void update() {
  // Update velocity
    velocity.mult(friction);
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    location.add(velocity);
    // Reset accelertion to 0 each cycle
    acceleration.mult(0);
  
    --life;
  }
 
  void render(float fillH, float fillS, float fillB, float fillA, float strokeH, float strokeS, float strokeB, float strokeA) {
  
    float theta = velocity.heading2D() + radians(90);
    float alphaAmt = processAlpha();
  
    if (fillA > 0) {
        fill(fillH, fillS, fillB, fillA * alphaAmt);
    } else {
        noFill();
    }
  
    if (strokeA > 0) {
        stroke(strokeH, strokeS, strokeB, strokeA * alphaAmt);
    } else {
        noStroke();
    }
  
    pushMatrix();
    translate(location.x,location.y, location.z);
    rotate(theta);
  
    //box(r);
    //sphere(r);
    if (W == L) {
        box(W);
    } else {
        beginShape(TRIANGLE_STRIP);
        vertex(-W, -L);
        vertex(-W,  L);
        vertex( W,  L);
        vertex( W, -L);
        endShape();
    }
  
    popMatrix();
  }

  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }
 
  boolean isDead() {
     return life <= 0 || (acceleration.mag() + velocity.mag()) < 1;
  }
 
  float processAlpha() {
     return (float)life/lifetime;
  }
}