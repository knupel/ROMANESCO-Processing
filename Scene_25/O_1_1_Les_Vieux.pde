ArrayList<Tri> listTri ;
Bezier bezier ;

//object one
class LesVieux extends SuperRomanesco {
  public LesVieux() {
    //from the index_objects.csv
    romanescoName = "Les Vieux" ;
    IDobj = 1 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Alpha 2.1";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
    romanescoMode = "1 Triangle/2 Courbe" ;
    romanescoSlider = "Hue fill,Saturation fill,Brightness fill,Alpha fill,Hue stroke,Saturation stroke,Brightness stroke,Alpha stroke,Thickness,Canvas X,Speed,Amplitude" ;
  }
  //GLOBAL
  
  Tri tri[] ;
  //SETUP
  void setting() {
    startPosition(IDobj, width/2, height/3, 0) ;
    bezier = new Bezier() ;
    doubleTriangleSetting() ;
  }
  //DRAW
  void display() {
    aspect(IDobj) ;
    
    if(mode[IDobj] == 0 ) doubleTriangleDisplay() ;
    if(mode[IDobj] == 1 ) courbe() ;
    
  }
  
  // ANNEXE
  // COURBE
  float speedCurve ;
  void courbe() {
    float bezierPoint = map(forceObj[IDobj],0,1,1,100) *beat[IDobj] ;
    
    float b1 = (bezierPoint + (left[IDobj] *100)) *2.0 ;
    float b2 = (bezierPoint + (right[IDobj] *100)) *2.0 ;
    float b3 = (bezierPoint + (left[IDobj] *100)) *2.0 ;
    float b4 = (bezierPoint + (right[IDobj] *100)) *2.0 ;
    float b5 = (bezierPoint - (left[IDobj] *100)) *2.0 ;
    float b6 = (bezierPoint - (right[IDobj] *100)) *2.0 ;
    float b7 = (bezierPoint - (left[IDobj] *100)) *2.0 ;
    float b8 = (bezierPoint - (right[IDobj] *100)) *2.0 ;
    
    //vitesse / speed
    if (motion[IDobj]) speedCurve  = speedObj[IDobj]*20 *tempo[IDobj] ; else speedCurve = 0.0 ;
    //amplitude
    float ampB = map(amplitudeObj[IDobj],0,1, -50, width *.5) ;
    int amp = int(ampB) ;
    //color
    //pos point of the shape
    PVector posBezier = new PVector (0,0) ;
    posBezier.x = (mouse[IDobj].x - (width /2))  *2 ;
    posBezier.y = (mouse[IDobj].y - (height /2)) *2  ;
    
    bezier.actualisation (mouse[IDobj], speedCurve) ;
    bezier.affichageBezier (posBezier, amp, b1, b2, b3, b4, b5, b6, b7, b8) ;
  }
  // END CURVE
  
  // TRIANGLE DOUBLE
  void doubleTriangleSetting() {
    listTri = new ArrayList<Tri>() ;
    int numTri = 2 ;
    for ( int i = 0 ; i < numTri ; i++) {
      Tri tri = new Tri() ;
      listTri.add(tri) ;
    }
  }
  void doubleTriangleDisplay() {
    if (spaceTouch && action[IDobj]) mouse[IDobj] = mouse[0].copy() ;
    PVector pos = new PVector(mouse[IDobj].x, mouse[IDobj].y) ;
    PVector canvas = new PVector (canvasXObj[IDobj] *10,canvasYObj[IDobj] *10) ;
    //thickness
    if(sound[IDobj]) thicknessObj[IDobj] *= mix[IDobj] ;
    // speed
    if(sound[IDobj]) speedObj[IDobj] = speedObj[IDobj] *tempo[IDobj] *100.0 ;
    //which side display the triangle
    PVector side ;

    for (int i=0 ; i < listTri.size() ; i++ ) {
      Tri tri = (Tri) listTri.get(i) ;
      if( i == 0 ) side = new PVector(canvas.x,0) ; else side = new PVector(0,canvas.y) ;
      tri.display(pos, canvas, side.x, side.y, speedObj[IDobj] *100.0) ;
    }
  }
}
//end object one




//CLASS BEZIER COURBE
class Bezier extends Rotation {  
  Bezier () { super () ; }
  
  void affichageBezier (PVector pos, int z, float b1, float b2, float b3, float b4, float b5, float b6, float b7, float b8) {
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
  }
}
// END CLASS BEZIER COURBE
//////////////////////////





//////////////
//CLASS TRIANGLE
class Tri {
  float pX, pY ;
  float dirX = 1.0 ;
  float dirY = 1.0 ;
  float newVX, newVY ;
  //constructor
  Tri () { }
 
  //Paramètre superClass  
  //speed move
  void actualisation(float speed, PVector canvas) {
    if (pX > canvas.x || pX < 0 ) dirX*=-1.0 ;
    if (pY > canvas.y || pY < 0) dirY*=-1.0 ;

    newVX = speed *dirX  ;
    newVY = speed *dirY  ;
    
    pX += newVX  ;
    pY += newVY  ;
  }
  
  
  //DISPLAY
  //void triangles (int coteA, int coteB, PVector pos, int coteC, color cIn, color cOut, float e, float vitesseX, float vitesseY) {
  void display (PVector pos, PVector canvas, float coteA, float coteB, float speed) {
    actualisation(speed, canvas) ;
    
    //display
    beginShape () ;
    strokeCap(ROUND);
    vertex (pos.x, pos.y);
    vertex (pX, coteB) ;
    vertex (coteA, coteB ) ;
    vertex (coteA, pY ) ;
    endShape(CLOSE) ;
  }
}
