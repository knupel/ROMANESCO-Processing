/**
SPIRALE  || 2011 || 1.1.1
*/
Line line ;
//object three
class Lignes extends Romanesco {
  public Lignes() {
    //from the index_objects.csv
    romanescoName = "Lignes" ;
    IDobj = 16 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Version 1.1.1";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
    romanescoMode = "Lines 1/Lines 2/Lines 3/Lines 4/Lines 5/Lines 6" ;
    romanescoSlider = "Fill hue,Fill sat,Fill bright,Fill alpha,Thickness,Quantity,Speed X,Direction X,Canvas X,Angle,Alignment" ;
  }
  //GLOBAL
  float ampLine  =1.0 ;
  float speed ;
  float thicknessLine ;
  //SETUP
  void setting() {
    startPosition(IDobj, 0, 0, -width) ;
    line = new Line() ;
  }
  //DRAW
  void display() {
    if( beat[IDobj] > 1 ) {
      ampLine = beat[IDobj] *(map(amplitudeObj[IDobj], 0,1, 0, 3)) ;
      thicknessLine = (thicknessObj[IDobj] *ampLine ) ;
    } else {
      thicknessLine = thicknessObj[IDobj] ;
    }

    //speed
    if(motion[IDobj]) speed = map(speedObj[IDobj], 0,1, 0, height/20 ) * tempo[IDobj]  ; else speed = 0.0 ;
    
    if(reverse[IDobj]) speed = speed *1 ; else speed = speed * -1 ;
    //to stop the move
    if (action[IDobj]  && spaceTouch ) speed = 0.0 ;
    
    // size canvas
    PVector canvas = new PVector (map(canvasXObj[IDobj],width/10, width, height, height *5),map(canvasXObj[IDobj],width/10, width, width, width *5)) ; 
    //quantity
    int num = (int)map(quantityObj[IDobj], 0, 1, canvas.x *.5, canvas.y *.05) ;

    int step_angle = (int)angleObj[IDobj] ;
    float step_rotate = map(alignmentObj[IDobj],0,1,0,TAU)  ;
    
    for(int i = 0 ; i < 6 ; i++) {
      int num_grid = i +1 ;
      if(mode[IDobj] == i) loop_display_line(num_grid, step_angle, step_rotate /num_grid, canvas, num, speed, thicknessLine) ;

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
    float direction = directionObj[IDobj] +start_angle_deg ;
    //rotation
    // rotation(direction, canvas.x *.5, canvas.y *.5 ) ;
    rotation(direction, 0, 0) ;
    //display
    line.drawLine (speed, num, fillObj[IDobj], thickness, canvas) ;

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
