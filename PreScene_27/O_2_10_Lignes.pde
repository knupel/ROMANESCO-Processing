Line line ;
//object three
class Lignes extends SuperRomanesco {
  public Lignes() {
    //from the index_objects.csv
    romanescoName = "Lignes" ;
    IDobj = 10 ;
    IDgroup = 2 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Version 1.1";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
    romanescoSlider = "Hue fill,Saturation fill,Brightness fill,Alpha fill,Thickness,Quantity,Speed,Direction" ;
  }
  //GLOBAL
  float ampLine  =1.0 ;
  float speed ;
  float thicknessLine ;
  Boolean reverse = false ;
  //SETUP
  void setting() {
    startPosition(IDobj, 0, 0, 0) ;
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
    
    if(rTouch) reverse = !reverse ;
    if(reverse) speed = speed *1 ; else speed = speed * -1 ;
    //to stop the move
    if (action[IDobj]  && spaceTouch ) speed = 0.0 ;
    
    // size canvas
    PVector canvas = new PVector (map(canvasXObj[IDobj],width/10, width, height, height *5),map(canvasXObj[IDobj],width/10, width, width, width *5)) ; 
    //quantity
    float q = map(quantityObj[IDobj], 0, 1, canvas.x *.5, canvas.y *.05) ;
    //rotation
    rotation(directionObj[IDobj] +180, canvas.x *.5, canvas.y *.5 ) ;
    //display
    line.drawLine (speed, q , fillObj[IDobj], thicknessLine, canvas, directionObj[IDobj]) ;
    
  }
}
//end 





//CLASS TRAME
class Line {
  Line()  { }
  
  float nbrlgn ; 
  int vitesse ;
  float vd, vg ;
  
  void drawLine ( float v, float q, color c, float e, PVector canvas, float angle) {
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
