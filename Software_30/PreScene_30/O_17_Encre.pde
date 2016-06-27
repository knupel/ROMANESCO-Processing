/**
ENCRE  || 2012 || 1.1.2
*/
ArrayList<Pixel_motion> encreList = new ArrayList<Pixel_motion>(); ;
ArrayList<Pixel_motion> starList = new ArrayList<Pixel_motion>();

//object one
class Spray extends Romanesco {
  public Spray() {
    //from the index_objects.csv
    RPE_name = "Stars Spray" ;
    ID_item = 17 ;
    ID_group = 1 ;
    RPE_author  = "Stan le Punk";
    RPE_version = "version 1.1.2";
    RPE_pack = "Base" ;
    RPE_mode = "Star/Spray Pen/Spray Mouse" ;
    RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Thickness,Size X,Size Y,Canvas X,Canvas Y,Quantity,Reactivity,Angle,Life,Spurt X,Flow,Direction X,Direction Y" ;
  }
  //GLOBAL
  // INK

  // float  inkDiffusion = 0.5 ; // size of spray 1 to 8 is good
  int ink_flux ;
  float ink_diffusion ;
  int ink_dry ; 
  int spray_power ; 
  float spray_angle ;
  PVector spray_direction ;
  float factor_pressure ;
  
  // float factorPressure ;
  // PVector sprayDirection ;
  boolean changeColor ;
  
  //GALAXIE
  
  //SETUP
  void setup() {
    setting_start_position(ID_item, 0, 0, 0) ;
  }
  //DRAW
  void draw() {
    // change color pallete
    if(xTouch) changeColor = !changeColor ;

    // thickness
    float thickness = thickness_item[ID_item] ;



    // spray
    int max_flux = 5 ;
    if(!FULL_RENDERING) max_flux = 5 ; else max_flux = 100 ;// limitation for the prescene rendering
    if(mode[ID_item] == 1 || mode[ID_item] == 2) {
      ink_flux = (int)map (quantity_item[ID_item], 0, 1, 1, max_flux) ; ; // flux is quantity ink for the pen or number of particules create each frame
      ink_diffusion = map (reactivity_item[ID_item], 0, 1, 0, 20) ; // speed / vitesse
      ink_dry = (int)map(life_item[ID_item], 0, 1, frameRate , 100000) ; // time to dry the ink, and pixel stop to move
      spray_power = (int)map(flow_item[ID_item], 0, 1, 1, width) ;  // power of the spray
      spray_angle = map (angle_item[ID_item], 0, 360, 0, 180) ;
    }

    if(mode[ID_item] == 1) {
      // PEN MODE
      spray_direction = new PVector (pen[0].x,pen[0].y) ;
      factor_pressure = map(pen[0].z, 0, 1, 1, 50 ) ;
    } else if(mode[ID_item] == 2 ) {
      // MOUSE MODE
      spray_direction = new PVector (map(dir_x_item[ID_item],0,360, -1, 1),map(dir_y_item[ID_item],0,360, -1, 1)) ;
      float factor_spurt = spurt_x_item[ID_item] *spurt_x_item[ID_item] ;
      factor_pressure = map(factor_spurt, 0, 1, 1, 50 ) ;
    }

    
    
    if(mode[ID_item] == 0 ) {
      if(clickLongLeft[ID_item] && nLongTouch || starList.size()<1 ) starProduction() ;
      displayStar() ;
    }
    else if(mode[ID_item] == 1 ) encre(ink_flux, ink_diffusion, ink_dry, spray_power, spray_angle, spray_direction, factor_pressure, thickness, fill_item[ID_item]) ;
    else if(mode[ID_item] == 2 ) encre(ink_flux, ink_diffusion, ink_dry, spray_power, spray_angle, spray_direction, factor_pressure, thickness, fill_item[ID_item]) ;
    
    // info display
    String whichColor = ("") ;
    if(changeColor) whichColor =("Original Color") ; else whichColor =("Colsor from Controller") ;
    objectInfo[ID_item] = ("Quantity ink " +encreList.size() +" Quantity stars " + starList.size() + " / " + whichColor ) ;
    
    
  }
 
  
  //ANNEXE VOID
  
  //STAR PRODUCTION
  float jitterOne, jitterTwo, jitterThree, jitterFour ;
  float thicknessSoundEffect ;
  // display
  void displayStar() {
    if(sound[ID_item]) {
      jitterOne = 5* random(-beat[ID_item],beat[ID_item]) ;
      jitterTwo = 5* random(-kick[ID_item],kick[ID_item]) ;
      jitterThree = 5* random(-snare[ID_item],snare[ID_item]) ;
      jitterFour = 5* random(-hat[ID_item],hat[ID_item]) ; 
    } else {
      jitterOne = 0 ; 
      jitterTwo = 0 ;
      jitterThree = 0 ;
      jitterFour = 0 ;
    }
    thicknessSoundEffect = 1 + jitterOne ;
      
      
    for (Pixel_motion p : starList) {
      strokeWeight(thickness_item[ID_item] *thicknessSoundEffect) ;  
      // if(changeColor) stroke(hue(p.colour), saturation(p.colour), brightness(p.colour), alpha(fill_item[ID_item])); else stroke(fill_item[ID_item]) ;
      if(changeColor) stroke(p.colour.r, p.colour.g, p.colour.b, alpha(fill_item[ID_item])); else stroke(fill_item[ID_item]) ;
      point(p.pos.x +jitterOne, p.pos.y +jitterTwo, p.pos.z +jitterThree) ;
    }
    if (reset(ID_item)) starList.clear() ;
  }
  
  // the orderer
  void starProduction() {
    float depth = map(canvas_z_item[ID_item], width/10, width, 0, width *3) ;
    // PVector pos = new PVector(mouse[0].x - item_setting_position[0][ID_item].x, mouse[0].y - item_setting_position[0][ID_item].y, depth ) ;
    PVector pos = new PVector(mouse[0].x, mouse[0].y, depth ) ;
    //tha first value must be smaller than second
    
    int sizeMin = (int)map(size_x_item[ID_item],0.1,width,1,20) ;
    int sizeMax = (int)map(size_y_item[ID_item],0.1,width,20, width *2) ;
    PVector size = new PVector(sizeMin,sizeMax) ;
    
    int numP = (int)map(quantity_item[ID_item],0,1,10,width) ;
    // limitation for the prescene rendering
    if(!FULL_RENDERING) {
      numP *= .001 ;
      if(numP < 5 ) numP = 5 ;
    }
    
    PVector numPoints = new PVector(numP/10,numP) ;
    
    int branchMin = (int)map(canvas_x_item[ID_item], width/10, width,1,30) ;
    int branchMax = (int)map(canvas_y_item[ID_item], width/10, width, 1, 30) ;
    PVector numBranchs = new PVector(branchMin,branchMax) ;

    color colour = fill_item[ID_item] ;
    int varAngle = (int)map(angle_item[ID_item], 0,360,0,180) ;
    PVector angle = new PVector(0,varAngle) ; // 0-360 degree
    starProducer(pos, size, numPoints, numBranchs, angle, colour) ;
  }
  
  // the factory
  void starProducer(PVector pos, PVector size, PVector points, PVector branch,  PVector angle, color c) {
    if(points.x > points.y) points.x = points.y ;
    if(branch.x > branch.y) branch.x = branch.y ;
    if(angle.x > angle.y) angle.x = angle.y ;
    if(size.x > size.y) size.x = size.y ;
    
    int num = (int)round(random(branch.x , branch.y )) ;
    int startDirection = (int)random(angle.x,angle.y) ;
    int sizeStar = (int)random(size.x,size.y) ;
    star(pos, sizeStar, startDirection, (int)points.x, (int)points.y, num, c) ;
  }
  
  // the object
  void star(PVector pos, int size,int direction, int min, int max, int numBranch, color colour) {
    pos.z = random(-pos.z, pos.z) ;
    float floatDirection = float(direction) ;
    for (int i = 0 ; i < numBranch ; i++ ) {
      // give the direction of each branch
      float addDegree = 360.0 / float(numBranch) ;
      floatDirection += addDegree ;
      // distribution points on the branch
      int n = (int)random(min,max) ;
      for ( int j = 0 ; j < n ; j++ ) {
        PVector posAroundTheStar = new PVector(0,0) ;
        PVector posFinal = new PVector(0,0) ;
        
        PVector dir = new PVector (0,0) ;
        dir = normal_direction((int)floatDirection) ;
        //distrubution in each branch
        float factor = random(0,1) ;
        float newDistance = 0 ;
        newDistance = pow(factor,2) *size ;
        posAroundTheStar = new PVector(dir.x *newDistance, dir.y *newDistance) ;
        
        posFinal.add(posAroundTheStar) ;
        posFinal.add(pos) ;
        starList.add(new Pixel_motion(Vec3(posFinal), colour)) ;
        posAroundTheStar = new PVector(0,0) ;
      }
    }
  }
  // END STAR PROD
  ////////////////

  
  
  /////
  //INK
  void encre(int inkFlux, float inkDiffusion, int dry, int spray, float angleSpray, PVector sprayDirection, float factorPressure, float thicknessPoint, int new_colour) {
    // INK DRY
    int size_field = (int)tempo[ID_item] ;
    float timeDry = 1.0 / float(dry) ;
  
   // add encre
   int security ;
   if (FULL_RENDERING) security = 500000 ; else security = 5000 ;
   if (action[ID_item] && nLongTouch && clickLongLeft[0] && encreList.size() < security) {
    addEncre(factorPressure, sprayDirection, angleSpray, spray, inkDiffusion, inkFlux, new_colour) ; 
  }
  
    //display
    for ( Pixel_motion e :  encreList ) {
      if (action[ID_item]) {
        e.motion_ink_3D(size_field, timeDry) ;
      }
      strokeWeight(thicknessPoint) ;
      noFill() ;
      if(changeColor) stroke(e.colour.r, e.colour.g, e.colour.b, alpha(fill_item[ID_item])); else stroke(fill_item[ID_item]) ;
      point(e.pos) ;
    }
    
    /////////////////////////////
    //CLEAR THE LIST IF NECESSARY 
    if (reset(ID_item)) encreList.clear() ;
  }
  void addEncre(float fp, PVector d, float a, int spray, float diffusion, int flux, int colorInk) {
    for ( int i = 0 ; i < flux *fp ; i++ ) {
      
      //to make a good Spray, use a good distribution
      float distribution = random(1) *random(1) ;
      //distribution pixel on the axe, before splash on the angle distribution
      // also we use to the strong push of the pen to the spray longer 
      float distance = spray *fp * distribution  ;
      //angle projection spray
      float angleDeg = random(-a, a);
      float angle = radians(angleDeg) ;
      // calcul of the absolute position of each pixel
      Vec2 tilt = Vec2 (pen[0].x *distance, pen[0].y *distance) ;
      //position the pixel around the laticce, pivot...
      Vec2 posTilt = Vec2( mouse[0].x - tilt.x , mouse[0].y - tilt.y  ) ;
      
      //calcul the final position to display
      mouse[ID_item].x = rotation(posTilt, Vec2(mouse[0].x, mouse[0].y), angle).x ;
      mouse[ID_item].y = rotation(posTilt, Vec2(mouse[0].x, mouse[0].y), angle).y ;
      // mouse[ID_item].sub(Vec3(item_setting_position[0][ID_item])) ;

      
      //put the pixel in the list to use peacefully
      encreList.add( new Pixel_motion(mouse[ID_item], diffusion, colorInk)) ;
    }
  }
  
  void resetEncre() {
    encreList.clear() ;
  }
  //END INK
  /////////
}
//end object one




  