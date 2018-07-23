/**
SPIRALE 
2011-2018
v 1.1.3
*/
Line line ;
//object three
class Lignes extends Romanesco {
  public Lignes() {
    //from the index_objects.csv
    item_name = "Lignes" ;
    ID_item = 15 ;
    ID_group = 1 ;
    item_author  = "Stan le Punk";
    item_version = "Version 1.1.3";
    item_pack = "Base 2011" ;
    item_costume = "" ;
    item_mode = "Lines 1/Lines 2/Lines 3/Lines 4/Lines 5/Lines 6" ;

    hue_fill_is = true;
    sat_fill_is = true;
    bright_fill_is = true;
    alpha_fill_is = true;
    hue_stroke_is = false;
    sat_stroke_is = false;
    bright_stroke_is = false;
    alpha_stroke_is = false;
    thickness_is = true;
    size_x_is = false;
    size_y_is = false;
    size_z_is = false;
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
    dir_x_is = true;
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
    angle_is = true;
    scope_is = false;
    scan_is = false;
    align_is = true;
    repulsion_is = false;
    attraction_is = false;
    density_is = false;
    influence_is = false;
    calm_is = false;
    spectrum_is = false;
  }
  //GLOBAL
  float ampLine  =1.0 ;
  float speed ;
  float thicknessLine ;
  //SETUP
  void setup() {
    setting_start_position(ID_item, 0, 0, -width) ;
    line = new Line() ;
  }
  
  //DRAW
  void draw() {
    if( transient_value[0][ID_item] > 1 ) {
      ampLine = transient_value[0][ID_item] *(map(swing_x_item[ID_item], 0,1, 0, 3)) ;
      thicknessLine = (thickness_item[ID_item] *ampLine ) ;
    } else {
      thicknessLine = thickness_item[ID_item] ;
    }

    //speed
    if(motion[ID_item]) speed = map(speed_x_item[ID_item], 0,1, 0, height/20 ) * tempo[ID_item]  ; else speed = 0.0 ;
    
    if(reverse[ID_item]) speed = speed *1 ; else speed = speed * -1 ;

    
    // size canvas
    PVector canvas = new PVector (map(canvas_x_item[ID_item],width/10, width, height, height *5),map(canvas_x_item[ID_item],width/10, width, width, width *5)) ; 
    //quantity
    int num = (int)map(quantity_item[ID_item], 0, 1, canvas.x *.5, canvas.y *.05) ;

    int step_angle = (int)angle_item[ID_item] ;
    float step_rotate = map(alignment_item[ID_item],0,1,0,TAU)  ;
    
    for(int i = 0 ; i < 6 ; i++) {
      int num_grid = i +1 ;
      if(mode[ID_item] == i) loop_display_line(num_grid, step_angle, step_rotate /num_grid, canvas, num, speed, thicknessLine) ;

    }
  }

  void loop_display_line(int num_grid, int step, float step_rotate, PVector canvas, int num, float speed, float thickness) {
    for(int i = 0 ; i < num_grid ; i++) {
      int angle = step *i ;
      float rotation_grid = step_rotate *i ;
      pushMatrix() ;
      rotateX(rotation_grid) ;
      display_line(canvas, num, speed / (i +1), thicknessLine,angle) ;
      popMatrix() ;
    }
  }

  

  void display_line(PVector canvas, int num, float speed, float thickness, int start_angle_deg) {
    float direction = dir_x_item[ID_item] +start_angle_deg ;
    //rotation
    // rotation(direction, canvas.x *.5, canvas.y *.5 ) ;
    rotation(direction, 0, 0) ;
    //display
    line.drawLine (speed, num, fill_item[ID_item], thickness, canvas) ;

  }
}
//end 





//CLASS TRAME
class Line {
  Line()  { }
  
  float nbrlgn ; 
  int vitesse ;
  float vd, vg ;
  
  void drawLine ( float v, float q, color c, float e, PVector canvas) {
    if( e < 0.1 ) e = 0.1 ; //security for the negative value
     strokeWeight(e) ;
    // security against the black brightness bug opacity
    if (alpha(c) == 0 ) noStroke() ; else stroke (c) ;
    
    float quantite = q*q *.001 ;
    //nbrlgn = quantite ;
   nbrlgn = (canvas.x + canvas.y) / quantite  ;
    vitesse += (v) ;
    if ( abs(vitesse) > quantite ) {
      vitesse = 0 ; 
    }
    for (int i=0 ; i < nbrlgn +1 ; i++) {
      float x1 = ( -(canvas.y) +i*( (canvas.x+ canvas.y ) /nbrlgn) ) +vitesse -e ;
      float y1 = -e ;
      float x2 =  ( 0 +i*( (canvas.x + canvas.y )  /nbrlgn) ) +vitesse +e ;
      float y2 = canvas.x+canvas.y +e ;
      
      line ( x1 , y1 , x2 , y2);
 
      /*
      PVector a = new PVector(x1, y1 ) ;
      PVector b = new PVector(x2, y2 ) ;

      //PVector lattice = new PVector(canvas.x *.5, canvas.y *.5 ) ;
      PVector lattice = new PVector(width/2, height/2 ) ;
      //pushMatrix() ;
      //rotation(angle, canvas.x / nbrlgn , canvas.y / nbrlgn) ;
      rotation(a, lattice, radians(angle)) ;
      //rotation(b, lattice, radians(-angle)) ;
      line(a.x, a.y, b.x, b.y) ;
      //popMatrix() ;
      */
      
      
    }
  }
}