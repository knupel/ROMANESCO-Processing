
/**
ARBRE 2012-2017 
v 1.3.4
*/
Arbre arbre ;

class ArbreRomanesco extends Romanesco {
  
  public ArbreRomanesco() {
    //from the index_objects.csv
    RPE_name = "Arbre" ;
    ID_item = 10 ;
    ID_group = 1 ;
    RPE_author  = "Stan le Punk";
    RPE_version = "Version 1.3.4";
    RPE_pack = "Base" ;
    RPE_mode = "Point/Ellipse/Triangle/Rectangle/Cross/Star 5/Star 7/Super Star 8/Super Star 12" ;
    RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Stroke hue,Stroke sat,Stroke bright,Stroke alpha,Thickness,Size X,Size Y,Size Z,Quantity,Speed X,Direction X,Canvas X,Alignment" ;
  }
  //GLOBAL
  float speed ;
  PVector posArbre = new PVector () ;
  //SETUP
  void setup() {
    setting_start_position(ID_item, width/2, height/3, 0) ;
    arbre = new Arbre () ;
  }
  
  //DRAW
  void draw() {
    int maxFork ;
    if(FULL_RENDERING) maxFork = 8 ; else maxFork = 4 ; // we can go beyond but by after the calcul slowing too much the computer... 14 is a good limit
    // int maxNode = 32 ; // 
    // num fork for the tree
    int forkA = maxFork ; 
    int forkB = maxFork ;
    
    int n = int(map(quantity_item[ID_item],0,1,2,maxFork*2)) ;
    
    float epaisseur = thickness_item[ID_item] ;
    float ratioLeft = map(left[ID_item], 0, 1, .5, 2) ;
    float ratioRight = map(right[ID_item], 0, 1, .5, 2) ;
    if(!FULL_RENDERING) {
      ratioLeft = .75 ;
      ratioRight = .75 ;
    }
    float ratioMix = ratioLeft + ratioRight ;

    // quantity of the shape

    //size of the shape
    float divA = .66 ;
    float divB = .66 ;
    if(sound[ID_item]) {
      divA = ratioLeft ;
      divB = ratioRight  ;
    } else {
      divA = .66 ;
      divB = .66 ;
    }
      
    
    //size
    int div_size = 20 ;
    float x = map(size_x_item[ID_item],.1,width,.1,width /div_size) ;
    float y = map(size_y_item[ID_item],.1,width,.1,width /div_size) ;
    float z = map(size_z_item[ID_item],.1,width,.1,width /div_size) ;
    x = x *x *ratioMix ;
    y = y *y *ratioMix ;
    z = z *z *ratioMix ;

    Vec3 size  = Vec3(x,y,z) ;
    //orientation
    float direction = dir_x_item[ID_item] ;
    //amplitude
    float amplitude = canvas_x_item[ID_item] *.5 ;
    if(FULL_RENDERING) amplitude = amplitude *allBeats(ID_item) ;
    



    // angle
    // float angle = map(angle_item[ID_item],0,360,0,180);
    float angle = 90 ; // but this function must be remove because it give no effect
    // speed
    if(motion[ID_item] && FULL_RENDERING) {
      float s = map(speed_x_item[ID_item],0,1,0,2) ;
      s *= s ;
      speed = s *tempo[ID_item] ; 
    } else if (!motion[ID_item] && FULL_RENDERING){ 
      speed = 0.0 ;
    } else {
      speed = 1.0 ;

    }
    
    
    boolean bool_link = false ;
    if(wire[ID_item]) bool_link = true ; else bool_link = false ;
    

    select_costume(ID_item, RPE_name) ;

    arbre.show(direction) ;
    arbre.update(posArbre, epaisseur, size, divA, divB, forkA, forkB, amplitude, n, costume[ID_item], bool_link, angle, speed, fill_is[ID_item], stroke_is[ID_item], ID_item) ;
    if(horizon[ID_item]) {
      arbre.set_horizon(0) ; 
    } else {
      arbre.set_horizon(map(alignment_item[ID_item], 0,1, 0, height /100)) ;
    }
    
    //info
    objectInfo[ID_item] = ("Nodes " +(n-1) + " - Amplitude " + (int)amplitude + " - Orientation " +direction +  " - Speed " + (int)map(speed,0,4,0,100) );
    
  } 
}
//end object two



/////////////////
//CLASS ARBRE
class Arbre {
  Arbre() {}
  // int vR = 1 ;  ;
  float theta, angleDirection ;
  float rotation = 90.0  ;
  float direction   ;
  float deep = 0 ;
 
//::::::::::::::::::::  
  void show(float d) {
    direction = d ;
  }

  void set_horizon(float deep) {
    this.deep = deep ;
  }
//::::::::::::::::::::::::::::  
  void update(PVector posArbre, float e, Vec3 size, float divA, float divB, int forkA, int forkB, float amplitude, int n, int which_costume, boolean bool_line, float angle, float speed, boolean fill_is, boolean stroke_is, int ID) {
    rotation += speed ;
    if (rotation > angle +90) speed*=-1 ; else if ( rotation < angle ) speed*=-1 ; 
    angle = rotation ; // de 0 à 180
    // Convert it to radians
    theta = radians(angle);
    angleDirection = radians (direction) ;
    pushMatrix () ;
    translate(posArbre.x,posArbre.y, 0) ;
    // Start the recursive branching
    rotate (angleDirection) ;
    branch(e, size, divA, divB, forkA, forkB, amplitude, n, which_costume, bool_line, fill_is, stroke_is,ID);
    popMatrix () ;

    
  }
  
  
  //float fourche = 10.0 ; 
  void branch(float t, Vec3 proportion, float divA, float divB, int forkA, int forkB, float amplitude, int n, int which_costume, boolean bool_line, boolean fill_is, boolean stroke_is, int ID) {
    Vec3 newSize = proportion.copy() ;
    newSize.x = proportion.x *divA ;
    newSize.y = proportion.y *divB;
    newSize.z = proportion.z *((divA +divB) *.5) ;
    if(newSize.x < 0.1 ) {
      newSize.x = 0.1 ;
    }
    
    float newThickness = t ;
    newThickness = t *.66 ;
    
    // recursice need a end  !
    n = n-1 ;
    if (n >0) {
     displayBranch(newThickness, newSize, divA, divB, forkA, forkB, amplitude, n, -theta, which_costume, bool_line, fill_is, stroke_is, ID) ; 
     displayBranch(newThickness, newSize, divA, divB, forkA, forkB, amplitude, n, theta, which_costume, bool_line, fill_is, stroke_is, ID) ;
    }
  }
  
  //annexe branch
  void displayBranch(float e, Vec3 size, float propA, float propB, int fourcheA, int fourcheB, float amplitude, int n, float t, int which_costume, boolean bool_line, boolean fill_is, boolean stroke_is, int ID) {
    float factor = 0.0 ;
    if(vLongTouch && pen[0].z != 0) {
      println("pen Z", pen[0].z) ;
      factor = deep * map(pen[0].z,0.01,1, 1.2,-1.2) ; 
    } else {
      factor = deep ;
    }

    start_matrix();    // Save the current state of transformation (i.e. where are we now)
    rotate(t);   // Rotate by theta

    // strokeWeight (e) ;
    aspect_is(fill_is, stroke_is) ;
    aspect_rope(fill_item[ID], stroke_item[ID], e, which_costume) ;
    Vec3 pos_a = Vec3(0) ;
    Vec3 pos_b = Vec3(0, -amplitude, -size.z *factor) ;
    
    if (bool_line && n > 1) {
       line(pos_a, pos_b) ;
    } 

    // Draw the branch
    costume_rope(Vec3(), size, which_costume) ;
    // horizon
    
    translate(pos_b) ;
   // translate(0,0, -size.z *factor) ;
     
  //  translate(0, -amplitude); // Move to the end of the branch
    branch(e, size, propA, propB, fourcheA, fourcheB, amplitude, n, which_costume, bool_line, fill_is, stroke_is, ID);       // Ok, now call myself to draw two new branches!!
    stop_matrix();     // Whenever we get back here, we "pop" in order to restore the previous matrix state
  }
}