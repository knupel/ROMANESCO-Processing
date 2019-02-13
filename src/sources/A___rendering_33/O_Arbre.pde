
/**
ARBRE 2012-2018
v 1.4.3
*/
class ArbreRomanesco extends Romanesco {
  Arbre arbre ;
  public ArbreRomanesco() {
    //from the index_objects.csv
    item_name = "Arbre" ;
    item_author  = "Stan le Punk";
    item_references = "";
    item_version = "Version 1.4.3";
    item_pack = "Base 2012-2018" ;
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
    ivec2 fork = ivec2(maxFork);
  
    int n = int(map(get_quantity(),0,1,2,maxFork*2)) ;
    
    float epaisseur = get_thickness() ;
    float ratioLeft = map(left[ID_item], 0, 1, .5, 2) ;
    float ratioRight = map(right[ID_item], 0, 1, .5, 2) ;
    if(!FULL_RENDERING) {
      ratioLeft = .75 ;
      ratioRight = .75 ;
    }
    float ratioMix = ratioLeft + ratioRight ;

    //size of the shape
    vec2 div = vec2(.66);
    if(sound_is()) {
      div.set(ratioLeft,ratioRight);
    } 

      
    //size
    int div_size = 20 ;
    float x = map(get_size_x(),.1,width,.1,width /div_size) ;
    float y = map(get_size_y(),.1,width,.1,width /div_size) ;
    float z = map(get_size_z(),.1,width,.1,width /div_size) ;
    x = x *x *ratioMix ;
    y = y *y *ratioMix ;
    z = z *z *ratioMix ;

    vec3 size  = vec3(x,y,z) ;
    //orientation
    float direction = get_dir_x() ;
    //amplitude
    vec2 amplitude = vec2(get_canvas_x() *.5,get_canvas_y() *.5) ;
    if(FULL_RENDERING) {
      amplitude.mult(all_transient(ID_item));
    }
    



    // angle
    float angle = 90 ; // but this function must be remove because it give no effect
    // speed
    if(motion_is() && FULL_RENDERING) {
      float s = map(get_speed_x(),0,1,0,2) ;
      s *= s;
      speed = s *tempo[ID_item]; 
    } else if (!motion_is() && FULL_RENDERING){ 
      speed = 0.;
    } else {
      speed = 1.;
    }
    
    
    boolean bool_link = false ;
    if(wire_is()) bool_link = true ; else bool_link = false ;
    arbre.show(direction);
    arbre.update(epaisseur,size,div,fork,amplitude,n,get_costume(),bool_link,angle,speed,ID_item) ;
    if(horizon_is()) {
      arbre.set_horizon(0) ; 
    } else {
      arbre.set_horizon(map(get_alignment(),0,1,-1,1));
    }
    
    //info
    info("Nodes ",(n-1),"- Amplitude ",amplitude.x,",",amplitude.y,"- Orientation ",direction," - Speed ",(int)map(speed,0,4,0,100) );
    
  }

  // CLASS ARBRE
  private class Arbre {
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
    void update(float e, vec3 size, vec2 div, ivec2 fork, vec2 amplitude, int n, Costume costume, boolean bool_line, float angle, float speed, int ID) {
      rotation += speed ;
      if (rotation > angle +90) speed*=-1 ; else if ( rotation < angle ) speed*=-1 ; 
      angle = rotation ; // de 0 à 180
      // Convert it to radians
      theta = radians(angle);
      angleDirection = radians (direction) ;
      pushMatrix () ;
      // Start the recursive branching
      rotate (angleDirection) ;
      branch(e,size,div,fork,amplitude,n,costume,bool_line,ID);
      popMatrix () ;

      
    }
    
    
    //float fourche = 10.0 ; 
    void branch(float thickness, vec3 size, vec2 div, ivec2 fork, vec2 amplitude, int n, Costume costume, boolean bool_line,int ID) {
      vec3 newSize = size.copy();
      newSize.x = size.x *div.x;
      newSize.y = size.y *div.y;
      newSize.z = size.z *(div.sum() *.5);
      if(newSize.x < 0.1 ) {
        newSize.x = 0.1 ;
      }
      
      thickness *= .66 ;
      
      // recursive need an happy end!
      n = n-1 ;
      if (n >0) {
       int branch_ID = 0;
       displayBranch(thickness,newSize,div,fork,amplitude,n,-theta,costume,bool_line,ID,branch_ID); 
       branch_ID = 1;
       displayBranch(thickness,newSize,div,fork,amplitude,n,theta,costume,bool_line,ID,branch_ID);
      }
    }
    
    //annexe branch
    void displayBranch(float thickness, vec3 size, vec2 div, ivec2 fork, vec2 amplitude, int n, float t, Costume costume, boolean bool_line, int ID, int branch_ID) {
      float factor = 0.0 ;
      if(key_v_long && pen[0].z != 0) {
        factor = deep * map(pen[0].z,0.01,1, 1.2,-1.2); 
      } else {
        factor = deep ;
      }

      start_matrix();    // Save the current state of transformation (i.e. where are we now)
      rotate(t);   // Rotate by theta

      aspect_is(fill_is(),stroke_is());
      aspect(get_fill(),get_stroke(),thickness);
      vec3 pos_a = vec3();
      vec3 pos_b = vec3(0, -amplitude.x, -amplitude.y *factor);
      
      if (bool_line && n > 1) {
         line(pos_a, pos_b) ;
      } 

      // Draw the branch
      set_ratio_costume_size(map(get_area(),width*.1, width*TAU,0,1));
      int offset_z = branch_ID;
      costume(vec3(0,0,offset_z),size,costume);
      
      // horizon   
      translate(pos_b) ;
       
      branch(thickness,size,div,fork,amplitude,n,costume,bool_line,ID); // Ok, now call myself to draw two new branches!!
      stop_matrix();     // Whenever we get back here, we "pop" in order to restore the previous matrix state
    }
  }
}
//end object two














