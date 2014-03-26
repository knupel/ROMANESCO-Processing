Bezier bezier ;
//object three
class Courbe extends SuperRomanesco {
  public Courbe() {
    //from the index_objects.csv
    romanescoName = "Courbe" ;
    IDobj = 7 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Alpha 2.0";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
  }
  //GLOBAL
  float speed ;
  //SETUP
  void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
    bezier = new Bezier() ;
  }
  //DRAW
  void display() {
    float bezierPoint = forceObj[IDobj] *beat[IDobj] ;
    
    float b1 = (bezierPoint + (left[IDobj] *100)) *2.0 ;
    float b2 = (bezierPoint + (right[IDobj] *100)) *2.0 ;
    float b3 = (bezierPoint + (left[IDobj] *100)) *2.0 ;
    float b4 = (bezierPoint + (right[IDobj] *100)) *2.0 ;
    float b5 = (bezierPoint - (left[IDobj] *100)) *2.0 ;
    float b6 = (bezierPoint - (right[IDobj] *100)) *2.0 ;
    float b7 = (bezierPoint - (left[IDobj] *100)) *2.0 ;
    float b8 = (bezierPoint - (right[IDobj] *100)) *2.0 ;
    
    //vitesse / speed
    if (motion[IDobj]) speed  = speedObj[IDobj]*.2 *tempo[IDobj] ; else speed = 0.0 ;

    
    //amplitude
    float ampB = map(amplitudeObj[IDobj],0,100, -50, width *.5) ;
    int amp = int(ampB) ;
    //color
    //pos point of the shape
    PVector posBezier = new PVector (0,0) ;
    posBezier.x = (mouse[IDobj].x - (width /2))  *2 ;
    posBezier.y = (mouse[IDobj].y - (height /2)) *2  ;
    
    bezier.actualisation (mouse[IDobj], speed) ;
    bezier.affichageBezier (fillObj[IDobj], strokeObj[IDobj], posBezier, thicknessObj[IDobj], amp, b1, b2, b3, b4, b5, b6, b7, b8) ;
    
  }
}
//end object two



class Bezier extends Rotation {  
  Bezier () { super () ; }
  
  void affichageBezier (color cIn, color cOut, PVector pos, float e, int z, float b1, float b2, float b3, float b4, float b5, float b6, float b7, float b8) {
    //check the opacity of color
    int alphaIn = (cIn >> 24) & 0xFF; 
    int alphaOut = (cOut >> 24) & 0xFF; 
    // to display or not
    if ( alphaIn == 0 ) noFill() ; else fill (cIn) ;
    if ( alphaOut == 0) {
      noStroke() ;
    } else {
      stroke ( cOut ) ; 
      if( e < 0.1 ) e = 0.1 ; //security for the negative value
      strokeWeight (e) ;
    }
    /*
    float zy = map (z, 0, 101, 0, height/2) ;
    float posYH = height / 2 - zy ;
    float posYB = height / 2 + zy ;
    float posXG = -zy ;
    float posXD = width + zy ;
    */
    float zy = map (z, 0, 101, 0, pos.y/2) ;
    //float posYH = pos.x / 2 - zy ;
    // float posYB = pos.y / 2 + zy ;
    float posXG = -zy ;
    float posXD = pos.x + zy ;
    beginShape();
    vertex(posXG, 0);
    bezierVertex(b1, b2, b3, b4,
                posXD, 0 );  
    bezierVertex(b5, b6, b7, b8,  
                posXG, 0);
    endShape();
    noStroke() ;
  }
  
}
