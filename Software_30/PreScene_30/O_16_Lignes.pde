/**
SPIRALE  || 2011 || 1.1.1
*/
Line line ;
//object three
class Lignes extends Romanesco {
  public Lignes() {
    //from the index_objects.csv
    RPE_name = "Lignes" ;
    ID_item = 16 ;
    ID_group = 1 ;
    RPE_author  = "Stan le Punk";
    RPE_version = "Version 1.1.1";
    RPE_pack = "Base" ;
    RPE_mode = "Lines 1/Lines 2/Lines 3/Lines 4/Lines 5/Lines 6" ;
    RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Thickness,Quantity,Speed X,Direction X,Canvas X,Angle,Alignment" ;
  }
  //GLOBAL
  float ampLine  =1.0 ;
  float speed ;
  float thicknessLine ;
  //SETUP
  void setup() {
    startPosition(ID_item, 0, 0, -width) ;
    line = new Line() ;
  }
  //DRAW
  void draw() {
    if( beat[ID_item] > 1 ) {
      ampLine = beat[ID_item] *(map(swing_x_item[ID_item], 0,1, 0, 3)) ;
      thicknessLine = (thickness_item[ID_item] *ampLine ) ;
    } else {
      thicknessLine = thickness_item[ID_item] ;
    }

    //speed
    if(motion[ID_item]) speed = map(speed_x_item[ID_item], 0,1, 0, height/20 ) * tempo[ID_item]  ; else speed = 0.0 ;
    
    if(reverse[ID_item]) speed = speed *1 ; else speed = speed * -1 ;
    //to stop the move
    if (action[ID_item]  && spaceTouch ) speed = 0.0 ;
    
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
