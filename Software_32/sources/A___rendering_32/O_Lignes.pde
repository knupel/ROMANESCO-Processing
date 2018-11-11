/**
LIGNES
2011-2018
v 1.2.1
*/
Line line ;
//object three
class Lignes extends Romanesco {
  public Lignes() {
    item_name = "Lignes" ;
    item_author  = "Stan le Punk";
    item_version = "Version 1.2.1";
    item_pack = "Base 2011-2018" ;
    item_costume = "" ;
    item_mode = "Lines 1/Lines 2/Lines 3/Lines 4/Lines 5/Lines 6" ;

    hue_fill_is = true;
    sat_fill_is = true;
    bright_fill_is = true;
    alpha_fill_is = true;
    // hue_stroke_is = true;
    // sat_stroke_is = true;
    // bright_stroke_is = true;
    // alpha_stroke_is = true;
    thickness_is = true;
    // size_x_is = true;
    // size_y_is = true;
    // size_z_is = true;
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
    // jit_z_is = true;
    // swing_x_is = true;
    // swing_y_is = true;
    // swing_z_is = true;

    quantity_is = true;
    // variety_is = true;
    // life_is = true;
    // flow_is = true;
    // quality_is = true;
    // area_is = true;
    angle_is = true;
    // scope_is = true;
    // scan_is = true;
    align_is = true;
    // repulsion_is = true;
    // attraction_is = true;
    // density_is = true;
    // influence_is = true;
    // calm_is = true;
    // spectrum_is = true;
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
    if(transient_value[0][ID_item] > 1 ) {
      ampLine = transient_value[0][ID_item] *(map(swing_x_item[ID_item], 0,1, 0, 3)) ;
      thicknessLine = (thickness_item[ID_item] *ampLine ) ;
    } else {
      thicknessLine = thickness_item[ID_item] ;
    }

    //speed
    if(motion[ID_item]) {
      speed = map(speed_x_item[ID_item]*speed_x_item[ID_item],0,1,0,height/20) * tempo[ID_item]; 
    } else {
      speed = 0;
    }
    
    if(reverse[ID_item]) speed = speed *1 ; else speed = speed * -1 ;

    // size canvas
    float canvas_x = map(canvas_x_item[ID_item],canvas_x_min_max.x,canvas_x_min_max.y, width/2, width *4);
    float canvas_y = map(canvas_y_item[ID_item],canvas_y_min_max.x,canvas_y_min_max.y, height/2, height *4);
    Vec2 canvas = Vec2(canvas_x,canvas_y);

    //quantity
    float ratio_num = map(quantity_item[ID_item]*quantity_item[ID_item],0,1,1,100);

    int step_angle = (int)angle_item[ID_item] ;
    float step_rotate = map(alignment_item[ID_item],0,1,0,TAU);
    

    // this loop is a bullshit must be refactor, 
    // because mode[ID_item] have allways a same value after the mode is selected from controller
    for(int i = 0 ; i < 6 ; i++) {
      int num_grid = i +1 ;
      if(mode[ID_item] == i) {
        loop_display_line(num_grid, step_angle, step_rotate /num_grid, canvas, ratio_num, speed, thicknessLine);
      }
    }
  }

  void loop_display_line(int num_grid, int step, float step_rotate, Vec2 canvas, float ratio_num, float speed, float thickness) {
    for(int i = 0 ; i < num_grid ; i++) {
      int angle = step *i ;
      float rotation_grid = step_rotate *i ;
      pushMatrix() ;
      rotateX(rotation_grid) ;
      display_line(canvas, ratio_num, speed / (i +1), thicknessLine,angle) ;
      popMatrix() ;
    }
  }

  

  void display_line(Vec2 canvas, float ratio_num, float speed, float thickness, int start_angle_deg) {
    float direction = dir_x_item[ID_item] +start_angle_deg ;
    rotation(direction, 0, 0) ;
    //display
    line.drawLine (speed,ratio_num,fill_item[ID_item],thickness, canvas) ;

  }
}
//end 





//CLASS TRAME
class Line {
  Line()  { }
  
  // float nbrlgn ; 
  float speed;
  float vd, vg ;
  
  void drawLine (float v, float ratio_num, color c, float e, Vec2 canvas) {
    if( e < 0.1 ) e = .1; //security for the negative value
     strokeWeight(e);
    // security against the black brightness bug opacity
    if (alpha(c) == 0) {
      noStroke(); 
    } else {
      stroke(c);
    }

    float num = ratio_num;
    float reset_speed = (canvas.x + canvas.y) /num;
    speed += (v);
    
    if ( abs(speed) > reset_speed) {
      speed = 0 ; 
    }
    
    for (int i=0 ; i < num +1 ; i++) {
      float x1 = ( -(canvas.y) +i*((canvas.x+ canvas.y) /num)) +speed -e;
      float y1 = -e ;
      float x2 =  (0 +i*((canvas.x +canvas.y) /num)) +speed +e;
      float y2 = canvas.x+canvas.y +e;
      line (x1,y1,x2,y2);
    }
  }
}