Line line ;
//object three
class Lignes extends SuperRomanesco {
  public Lignes() {
    //from the index_objects.csv
    romanescoName = "Lignes" ;
    IDobj = 10 ;
    IDgroup = 2 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Alpha 2.1";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
  }
  //GLOBAL
  float ampLine  =1.0 ;
  float speed ;
  float thicknessLine ;
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
    if(motion[IDobj]) speed = map(speedObj[IDobj], 0,100, -25,25 ) * tempo[IDobj]  ; else speed = 0.0 ;
    //to stop the move
    if (action[IDobj]  && spaceTouch ) speed = 0.0 ;
    
    rotation(directionObj[IDobj], mouse[IDobj].x, mouse[IDobj].y ) ;
    
    //quantité
    float q = map(quantityObj[IDobj], 1, 100, width , height *.2) ;



    line.drawLine (speed, q , fillObj[IDobj],  thicknessLine) ;
    
  }
}
//end 





//CLASS TRAME
class Line {
  Line()  { }
  
  float nbrlgn ; 
  int vitesse ;
  float vd, vg ;
  
  void drawLine ( float v, float q, color cOut, float e) {
    if( e < 0.1 ) e = 0.1 ; //security for the negative value
    stroke (cOut) ; strokeWeight(e) ;
    float quantite = q*q *.001 ;
    //nbrlgn = quantite ;
   nbrlgn = (width + height) / quantite  ;
    vitesse += (v) ;
    if ( abs(vitesse) > quantite ) {
      vitesse = 0 ; 
    }
    for (int i=0 ; i < nbrlgn +1 ; i++) {
      float x1 = ( -(height) +i*( (width+ height ) /nbrlgn) ) +vitesse -e ;
      float y1 = -e ;
      float x2 =  ( 0 +i*( (width + height )  /nbrlgn) ) +vitesse +e ;
      float y2 = width+height +e ; 
      line ( x1 , y1 , x2 , y2);
    }
  }

}
