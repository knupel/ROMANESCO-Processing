ArrayList<Tri> listTri ;

//object one
class Triangle extends SuperRomanesco {
  public Triangle() {
    //from the index_objects.csv
    romanescoName = "Triangle" ;
    IDobj = 1 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Alpha 2.0";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
  }
  //GLOBAL
  
  Tri tri[] ;
  //SETUP
  void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
    listTri = new ArrayList<Tri>() ;
    int numTri = 2 ;
    float thickness ;
    for ( int i = 0 ; i < numTri ; i++) {
      Tri tri = new Tri() ;
      listTri.add(tri) ;
    }
  }
  //DRAW
  void display() {
    PVector pos = new PVector(mouse[IDobj].x, mouse[IDobj].y) ;
    PVector canvas = new PVector (canvasXObj[IDobj],canvasYObj[IDobj]) ;
    //thickness
    if(sound[IDobj]) thicknessObj[IDobj] *= mix[IDobj] ;
    // speed
    if(sound[IDobj]) speedObj[IDobj] *= tempo[IDobj] ;
    //which side display the triangle
    PVector side ;

    for (int i=0 ; i < listTri.size() ; i++ ) {
      Tri tri = (Tri) listTri.get(i) ;
      if( i == 0 ) side = new PVector(canvasXObj[IDobj],0) ; else side = new PVector(0,canvasYObj[IDobj]) ;
      tri.display(pos, canvas, fillObj[IDobj], strokeObj[IDobj], side.x, side.y,thicknessObj[IDobj], speedObj[IDobj]) ;
    }
  }
}
//end object one





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
  void display (PVector pos, PVector canvas, color cIn, color cOut, float coteA, float coteB,  float thickness, float speed) {
    //check the opacity of color
    int alphaIn = (cIn >> 24) & 0xFF; 
    int alphaOut = (cOut >> 24) & 0xFF; 
    // to display or not
    if ( alphaIn == 0 ) noFill() ; else fill (cIn) ;
    if ( alphaOut == 0) {
      noStroke() ;
    } else {
      stroke ( cOut ) ;
      strokeWeight (thickness) ;
    }
    
    //update
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
