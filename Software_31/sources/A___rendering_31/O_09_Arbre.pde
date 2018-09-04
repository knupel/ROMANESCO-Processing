
/**
ARBRE 2012-2018
v 1.3.7
*/
Arbre arbre ;

class ArbreRomanesco extends Romanesco {
  
  public ArbreRomanesco() {
    //from the index_objects.csv
    item_name = "Arbre" ;
    ID_item = 9 ;
    ID_group = 1 ;
    item_author  = "Stan le Punk";
    item_version = "Version 1.3.7";
    item_pack = "Base 2012" ;
    item_costume = "point/ellipse/triangle/rect/cross/pentagon/Star 5/Star 7/Super Star 8/Super Star 12";
    item_mode = "";
    // define slider
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
    // canvas_z_is = true;

    // frequence_is = true;
    speed_x_is = true;
    // speed_y_is = true;
    // speed_z_is = true;
    // spurt_x_is = true;
    // spurt_y_is = true;
    // spurt_z_is = true;
    dir_x_is = true;
    // dir_y_is = true;
    // dir_z_is = true;
    // jit_x_is = true;
    // jit_y_is = true;
    // jit_z_is  = true;
    // swing_x_is = true;
    // swing_y_is = true;
    // swing_z_is = true;

    quantity_is = true;
    // variety_is =true;
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
    //influence_is = true;
    // calm_is = true;
    // spectrum_is = true;
  }
  //GLOBAL
  float speed;
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
    Vec2 amplitude = Vec2(canvas_x_item[ID_item] *.5,canvas_y_item[ID_item] *.5) ;
    if(FULL_RENDERING) {
      amplitude.mult(all_transient(ID_item));
    }
    



    // angle
    // float angle = map(angle_item[ID_item],0,360,0,180);
    float angle = 90 ; // but this function must be remove because it give no effect
    // speed
    if(motion[ID_item] && FULL_RENDERING) {
      float s = map(speed_x_item[ID_item],0,1,0,2) ;
      s *= s;
      speed = s *tempo[ID_item]; 
    } else if (!motion[ID_item] && FULL_RENDERING){ 
      speed = 0.0 ;
    } else {
      speed = 1.0 ;
    }
    
    
    boolean bool_link = false ;
    if(wire[ID_item]) bool_link = true ; else bool_link = false ;
    

    // get_costume();

    arbre.show(direction);
    arbre.update(epaisseur, size, divA, divB, forkA, forkB, amplitude, n, get_costume(), bool_link, angle, speed, fill_is[ID_item], stroke_is[ID_item], ID_item) ;
    if(horizon[ID_item]) {
      arbre.set_horizon(0) ; 
    } else {
      arbre.set_horizon(map(alignment_item[ID_item],0,1,-1,1));
    }
    
    //info
    item_info[ID_item] = ("Nodes " +(n-1) + " - Amplitude " + amplitude.x +","+ amplitude.y + " - Orientation " +direction +  " - Speed " + (int)map(speed,0,4,0,100) );
    
  } 
}
//end object two




// CLASS ARBRE
class Arbre {
  float theta, angleDirection;
  float rotation = 90.;
  float direction = 0;
  float deep = 0;

  Arbre() {}

 
//::::::::::::::::::::  
  void show(float d) {
    direction = d ;
  }

  void set_horizon(float deep) {
    this.deep = deep ;
  }
//::::::::::::::::::::::::::::  
  void update(float e, Vec3 size, float divA, float divB, int forkA, int forkB, Vec2 amplitude, int n, int which_costume, boolean bool_line, float angle, float speed, boolean fill_is, boolean stroke_is, int ID) {
    rotation += speed ;
    if (rotation > angle +90) speed*=-1 ; else if ( rotation < angle ) speed*=-1 ; 
    angle = rotation ; // de 0 à 180
    // Convert it to radians
    theta = radians(angle);
    angleDirection = radians (direction) ;
    pushMatrix () ;
    // Start the recursive branching
    rotate (angleDirection) ;
    branch(e, size, divA, divB, forkA, forkB, amplitude, n, which_costume, bool_line, fill_is, stroke_is,ID);
    popMatrix () ;

    
  }
  
  
  //float fourche = 10.0 ; 
  void branch(float thickness, Vec3 size, float divA, float divB, int forkA, int forkB, Vec2 amplitude, int n, int which_costume, boolean bool_line, boolean fill_is, boolean stroke_is, int ID) {
    Vec3 newSize = size.copy();
    newSize.x = size.x *divA;
    newSize.y = size.y *divB;
    newSize.z = size.z *((divA +divB) *.5);
    if(newSize.x < 0.1 ) {
      newSize.x = 0.1 ;
    }
    
    // float newThickness = t ;
    thickness *= .66 ;
    
    // recursice need a end  !
    n = n-1 ;
    if (n >0) {
     displayBranch(thickness, newSize, divA, divB, forkA, forkB, amplitude, n, -theta, which_costume, bool_line, fill_is, stroke_is, ID) ; 
     displayBranch(thickness, newSize, divA, divB, forkA, forkB, amplitude, n, theta, which_costume, bool_line, fill_is, stroke_is, ID) ;
    }
  }
  
  //annexe branch
  void displayBranch(float thickness, Vec3 size, float propA, float propB, int fourcheA, int fourcheB, Vec2 amplitude, int n, float t, int which_costume, boolean bool_line, boolean fill_is, boolean stroke_is, int ID) {
    float factor = 0.0 ;
    if(key_v_long && pen[0].z != 0) {
      factor = deep * map(pen[0].z,0.01,1, 1.2,-1.2) ; 
    } else {
      factor = deep ;
    }

    start_matrix();    // Save the current state of transformation (i.e. where are we now)
    rotate(t);   // Rotate by theta

    // strokeWeight (e) ;
    aspect_is(fill_is, stroke_is);
    aspect_rope(fill_item[ID], stroke_item[ID],thickness);
    // aspect_rope(fill_item[ID], stroke_item[ID], e, which_costume);
    Vec3 pos_a = Vec3() ;
    Vec3 pos_b = Vec3(0, -amplitude.x, -amplitude.y *factor) ;
    
    if (bool_line && n > 1) {
       line(pos_a, pos_b) ;
    } 

    // Draw the branch
    set_ratio_costume_size(map(area_item[ID],width*.1, width*TAU,0,1));
    costume_rope(Vec3(),size,which_costume);
    // horizon
    
    translate(pos_b) ;
   // translate(0,0, -size.z *factor) ;
     
  //  translate(0, -amplitude); // Move to the end of the branch
    branch(thickness, size, propA, propB, fourcheA, fourcheB, amplitude, n, which_costume, bool_line, fill_is, stroke_is, ID);       // Ok, now call myself to draw two new branches!!
    stop_matrix();     // Whenever we get back here, we "pop" in order to restore the previous matrix state
  }
}