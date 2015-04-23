// CONSTANT NUMBER
final float PHI = (1 + sqrt(5))/2; //a number of polys use the golden ratio...
final float ROOT2 = sqrt(2); //...and the square root of two, the famous first irrationnal number by Pythagore
final float EULER = 2.718281828459045235360287471352; // Constant d'Euler



// ALGEBRE
//roots dimensions n
float roots(float valueToRoots, int n) {
  return pow(valueToRoots, 1.0/n) ;
}





//GEOMETRY
/////////////////////////////////
// EQUATION CIRLCE
float perimeterCircle ( int r ) {
  float p = 2*r*PI  ;
  return p ;
}


float radiusSurface(int surface) {
  // calcul the radius from circle surface
  return sqrt(surface/PI);
}


// END EQUATION CIRCLE
//////////////////////




// normal direction 0-360 to -1, 1 PVector
PVector normalDir(int direction) {
  int numPoints = 360;
  float angle = TWO_PI/(float)numPoints;
  direction = 360-direction;
  direction += 180;
  return new PVector(sin(angle*direction), cos(angle*direction));
}
// degre direction from PVector direction
float deg360 (PVector dir) {
  float deg360 ;
  deg360 = 360 -(degrees(atan2(dir.x, dir.y)) +180)   ;
  return deg360 ;
}

//ROTATION
//GLOBAL
PVector resultPositionOfRotation = new PVector() ;
//DRAW

PVector rotation(PVector ref, PVector lattice, float angle) {
  float a = angle( lattice, ref ) + angle;
  float d = distance( lattice, ref );
  
  resultPositionOfRotation.x = lattice.x + cos( a ) * d;
  resultPositionOfRotation.y = lattice.y + sin( a ) * d;
  //
  return resultPositionOfRotation;
}

float angle(PVector p0, PVector p1) {
  return atan2( p1.y - p0.y, p1.x - p0.x );
}
  
float distance(PVector p0, PVector p1) {
  return sqrt( ( p0.x -p1.x) *( p0.x -p1.x) +( p0.y -p1.y) *( p0.y -p1.y));
}


//other Rotation
//Rotation Objet
void rotation (float angle, float posX, float posY ) {
  translate(posX, posY ) ;
  rotate (radians(angle) ) ;
}

//END OF ROTATION


// END EQUATION
///////////////







// PRIMITIVE 2D
///////////////




//DISC
void disc( PVector pos, int diam, color c ) {
  for ( int i = 1 ; i < diam +1 ; i++) {
    circle(c, pos, i) ;
  }
}

void chromaticDisc( PVector pos, int diam ) {
  for ( int i = 1 ; i < diam +1 ; i++) {
    chromaticCircle(pos, i) ;
  }
}



//CIRCLE
void chromaticCircle(PVector pos, int d) {
  int surface = d*d ; // surface is equale of square surface where is the cirlcke...make sens ?

  int radius = ceil(radiusSurface(surface)) ;
  int numPoints = ceil(perimeterCircle( radius)) ;
  for(int i=0; i < numPoints; i++) {
      //circle
      float stepAngle = map(i, 0, numPoints, 0, 2*PI) ; 
      float angle =  2*PI - stepAngle;
      //color
      color c = color (i, 100,100) ;
      //display
      set(int(pointOnCirlcle(radius, angle).x + pos.x) , int(pointOnCirlcle(radius, angle).y + pos.y), c);
  }
}

// END DISC


// PRIMITIVE  with "n" summits
void primitive(int x, int y, int radius, int summits) {
  if(summits < 3) summits = 3 ;
  PVector pos = new PVector (x,y) ;
  PVector [] summit = new PVector[summits] ;
  // create coord of the shape
  for (int i = 0 ; i < summits ; i++) {
    summit[i] = circle(pos, radius, summits)[i].copy() ; 
  }
  
  //draw the shape
  beginShape() ;
  for (int i = 0 ; i < summits ; i++) {
    vertex(summit[i].x, summit[i].y) ;
  }
  vertex(summit[0].x, summit[0].y) ;
  endShape() ;
}










// summits around the circle
PVector [] circle (PVector pos, int d, int num) {
  PVector [] p = new PVector [num] ;
  int surface = d*d ; 
  int radius = ceil(radiusSurface(surface)) ;
  
  // choice your starting point
  float startingAnglePos = PI*.5;
  if(num == 4) startingAnglePos = PI*.25;
  
  for( int i=0 ; i < num ; i++) {
    float stepAngle = map(i, 0, num, 0, TAU) ; 
    float angle =  TAU - stepAngle -startingAnglePos;
    p[i] = new PVector(pointOnCirlcle(radius, angle).x +pos.x,pointOnCirlcle(radius, angle).y + pos.y) ;
  }
  return p ;
}

PVector [] circle (PVector pos, int d, int num, float jitter) {
  PVector [] p = new PVector [num] ;
  int surface = d*d ; 
  int radius = ceil(radiusSurface(surface)) ;
  
  // choice your starting point
  float startingAnglePos = PI*.5;
  if(num == 4) startingAnglePos = PI*.25;
  
  float angleCorrection ; // this correction is cosmetic, when we'he a pair beam this one is stable for your eyes :)
  for( int i=0 ; i < num ; i++) {
    int beam = num /2 ;
    if ( beam%2 == 0 ) angleCorrection = PI / num ; else angleCorrection = 0.0 ;
    if ( num%2 == 0 ) jitter *= -1 ; else jitter *= 1 ; // the beam have two points at the top and each one must go to the opposate...
    
    float stepAngle = map(i, 0, num, 0, TAU) ;
    float jitterAngle = map(jitter, -1, 1, -PI/num, PI/num) ;
    float angle =  TAU -stepAngle +jitterAngle +angleCorrection -startingAnglePos;
    
    p[i] = new PVector(pointOnCirlcle(radius, angle).x +pos.x, pointOnCirlcle(radius, angle ).y +pos.y) ;
  }
  return p ;
}


//full cirlce
void circle(color c, PVector pos, int d) {
  int surface = d*d ; // surface is equale of square surface where is the cirlcke...make sens ?

  int radius = ceil(radiusSurface(surface)) ;
  int numPoints = ceil(perimeterCircle(radius)) ;
  for(int i=0; i < numPoints; i++) {
      float stepAngle = map(i, 0, numPoints, 0, 2*PI) ; 
      float angle =  2*PI - stepAngle;
      set(int(pointOnCirlcle(radius, angle).x + pos.x) , int(pointOnCirlcle(radius, angle).y + pos.y), c);
  }
}

//circle with a specific quantity points
void circle(color c, PVector pos, int d, int num) {
  int surface = d*d ; // surface is equale of square surface where is the cirlcke...make sens ?

  int radius = ceil(radiusSurface(surface)) ;
  for(int i=0; i < num; i++) {
      float stepAngle = map(i, 0, num, 0, 2*PI) ; 
      float angle =  2*PI - stepAngle;
      set(int(pointOnCirlcle(radius, angle).x + pos.x) , int(pointOnCirlcle(radius, angle).y + pos.y), c);
  }
}


//circle with a specific quantity points and specific shape for each point
void circle(PVector pos, int d, int num, PVector size, String shape) {
  int surface = d*d ; // surface is equale of square surface where is the cirlcke...make sens ?
  int whichShape = 0 ;
  if (shape.equals("point") )  whichShape = 0;
  else if (shape.equals("ellipse") )  whichShape = 1 ;
  else if (shape.equals("rect") )  whichShape = 2 ;
  else if (shape.equals("box") )  whichShape = 3 ;
  else if (shape.equals("sphere") )  whichShape = 4 ;
  else whichShape = 0 ;

  int radius = ceil(radiusSurface(surface)) ;
  for(int i=0; i < num; i++) {
    float stepAngle = map(i, 0, num, 0, 2*PI) ; 
    float angle =  2*PI - stepAngle;
    PVector newPos = new PVector(pointOnCirlcle(radius, angle).x + pos.x, pointOnCirlcle(radius, angle).y + pos.y) ;
    if(whichShape == 0 ) point(newPos.x, newPos.y) ;
    if(whichShape == 1 ) ellipse(newPos.x, newPos.y, size.x, size.y) ;
    if(whichShape == 2 ) rect(newPos.x, newPos.y, size.x, size.y) ;
    if(whichShape == 3 ) {
      pushMatrix() ;
      translate(newPos.x, newPos.y,0) ;
      box(size.x, size.y, size.z) ;
      popMatrix() ;
    }
    if(whichShape == 4 ) {
      pushMatrix() ;
      translate(newPos.x, newPos.y,0) ;
      int detail = (int)size.x /4 ;
      if (detail > 10 ) detail = 10 ;
      sphereDetail(detail) ;
      sphere(size.x) ;
      popMatrix() ;
    }
  }
}


PVector pointOnCirlcle(int r, float angle) {
  PVector posPix = new PVector () ;
  posPix.x = cos(angle) *r ;
  posPix.y = sin(angle) *r ;
  return posPix ;
}


// END PRIMITIVE 2D
///////////////////










//PRIMITIVE 3D
//////////////

// this triangle is a primitive 2D in 3D world
void triangle(float x1, float y1, float z1, float x2, float y2, float z2, float x3, float y3, float z3) {
  beginShape() ;
  vertex(x1, y1, z1) ;
  vertex(x2, y2, z2) ;
  vertex(x3, y3, z3) ;
  endShape(CLOSE) ;
}



// SIMPLE TETRAHEDRON
/////////////////////
ArrayList listPointTetrahedron = new ArrayList() ;
// main method
/* The starting size is around "one pixel */
void tetrahedron(int size) {
  tetrahedronClear() ;
  tetrahedronAdd() ;
  tetrahedronDisplay(size) ;
}

// add function
void tetrahedronAdd() {
  listPointTetrahedron.add (new PVector(1, 1, 1));
  listPointTetrahedron.add (new PVector(-1, -1, 1));
  listPointTetrahedron.add (new PVector(-1, 1, -1));
  listPointTetrahedron.add (new PVector(1, -1, -1));
}


// clear function
void tetrahedronClear() {
  listPointTetrahedron.clear() ;
}
void tetrahedronDisplay(int size) {
  int finalSize = size /2 ;
  int n = 4 ; // quantity of face of Tetrahedron
  for(int i = 0 ; i < n ; i++) {
    // choice of each point
    int a = i ;
    int b = i+1 ;
    int c = i+2 ;
    if(i == n-2 ) c = 0 ;
    if(i == n-1 ) {
      b = 0 ;
      c = 1 ;
    }
    PVector v1 = (PVector)listPointTetrahedron.get(a) ;
    PVector v2 = (PVector)listPointTetrahedron.get(b) ;
    PVector v3 = (PVector)listPointTetrahedron.get(c) ;
    // scale the position of the points
    v1 = new PVector(v1.x *finalSize, v1.y *finalSize, v1.z *finalSize) ;
    v2 = new PVector(v2.x *finalSize, v2.y *finalSize, v2.z *finalSize) ;
    v3 = new PVector(v3.x *finalSize, v3.y *finalSize, v3.z *finalSize) ;
    renderTetrahedron(v1, v2, v3) ;
  }
}

void renderTetrahedron(PVector v1, PVector v2, PVector v3) {
  beginShape() ;
  vertex(v1.x, v1.y, v1.z) ;
  vertex(v2.x, v2.y, v2.z) ;
  vertex(v3.x, v3.y, v3.z) ;
  endShape() ;
}


// END SIMPLE TETRAHEDRON
////////////////////////





//POLYDRON
  //create Polyhedron
  /*
  "TETRAHEDRON","CUBE", "OCTOHEDRON", "DODECAHEDRON","ICOSAHEDRON","CUBOCTAHEDRON","ICOSI DODECAHEDRON",
  "TRUNCATED CUBE","TRUNCATED OCTAHEDRON","TRUNCATED DODECAHEDRON","TRUNCATED ICOSAHEDRON","TRUNCATED CUBOCTAHEDRON","RHOMBIC CUBOCTAHEDRON",
  "RHOMBIC DODECAHEDRON","RHOMBIC TRIACONTAHEDRON","RHOMBIC COSI DODECAHEDRON SMALL","RHOMBIC COSI DODECAHEDRON GREAT"
  All Polyhedrons can use "POINT" and "LINE" display mode.
  except the "TETRAHEDRON" who can also use "VERTEX" display mode.
  */
  
// MAIN VOID to create polyhedron
void polyhedron(String whichPolyhedron, String whichStyleToDraw, int size) {
  //This is where the actual defining of the polyhedrons takes place

   
  listPVectorPolyhedron.clear(); //clear out whatever verts are currently defined
  
  if(whichPolyhedron.equals("TETRAHEDRON")) tetrahedron_poly(size) ;
  if(whichPolyhedron.equals("CUBE")) cube(size) ;
  if(whichPolyhedron.equals("OCTOHEDRON")) octohedron(size) ;
  if(whichPolyhedron.equals("DODECAHEDRON"))dodecahedron(size) ;
  if(whichPolyhedron.equals("ICOSAHEDRON"))icosahedron(size) ;
  if(whichPolyhedron.equals("CUBOCTAHEDRON"))cuboctahedron(size) ;
  if(whichPolyhedron.equals("ICOSI DODECAHEDRON"))icosi_dodecahedron(size) ;

  if(whichPolyhedron.equals("TRUNCATED CUBE"))truncated_cube(size) ;
  if(whichPolyhedron.equals("TRUNCATED OCTAHEDRON"))truncated_octahedron(size) ;
  if(whichPolyhedron.equals("TRUNCATED DODECAHEDRON"))truncated_dodecahedron(size) ;
  if(whichPolyhedron.equals("TRUNCATED ICOSAHEDRON"))truncated_icosahedron(size) ;
  if(whichPolyhedron.equals("TRUNCATED CUBOCTAHEDRON"))truncated_cuboctahedron(size) ;
  
  if(whichPolyhedron.equals("RHOMBIC CUBOCTAHEDRON"))rhombic_cuboctahedron(size) ;
  if(whichPolyhedron.equals("RHOMBIC DODECAHEDRON"))rhombic_dodecahedron(size) ;
  if(whichPolyhedron.equals("RHOMBIC TRIACONTAHEDRON"))rhombic_triacontahedron(size) ;
  if(whichPolyhedron.equals("RHOMBIC COSI DODECAHEDRON SMALL"))rhombic_cosi_dodecahedron_small(size) ;
  if(whichPolyhedron.equals("RHOMBIC COSI DODECAHEDRON GREAT"))rhombic_cosi_dodecahedron_great(size) ;
  
  // which method to draw
  if(whichStyleToDraw.equals("LINE")) drawLinePolyhedron(whichPolyhedron) ;
  if(whichStyleToDraw.equals("POINT")) drawPointPolyhedron(whichPolyhedron) ;
  if(whichStyleToDraw.equals("VERTEX")) drawVertexPolyhedron(whichPolyhedron) ;

}




// POLYHEDRON DETAIL 
////////////
//set up initial polyhedron
float factorSizePolyhedron ;
//some variables to hold the current polyhedron...
ArrayList listPVectorPolyhedron = new ArrayList();
float edgeLengthOfPolyhedron;
String strName, strNotes;

// FEW POLYHEDRON
// BASIC
void tetrahedron_poly(int size) {
  listPVectorPolyhedron.add(new PVector(1, 1, 1)) ;
  listPVectorPolyhedron.add(new PVector(-1, -1, 1)) ;
  listPVectorPolyhedron.add(new PVector(-1, 1, -1)) ;
  listPVectorPolyhedron.add(new PVector(1, -1, -1)) ;
  edgeLengthOfPolyhedron = 0 ;
  factorSizePolyhedron = size /2;
}

void cube(int size) {
  addVerts(1, 1, 1);
  edgeLengthOfPolyhedron = 2;
  factorSizePolyhedron = size /2;
}

void octohedron(int size) {
  addPermutations(1, 0, 0);
  edgeLengthOfPolyhedron = ROOT2;
  factorSizePolyhedron = size *.8;
}

void dodecahedron(int size) {
  addVerts(1, 1, 1);
  addPermutations(0, 1/PHI, PHI);
  edgeLengthOfPolyhedron = 2/PHI;
  factorSizePolyhedron = size /2.5;
}


// SPECIAL
void icosahedron(int size) {
  addPermutations(0, 1, PHI);
  edgeLengthOfPolyhedron = 2.0;
  factorSizePolyhedron = size /2.7;
}

void icosi_dodecahedron(int size) {
  addPermutations(0, 0, 2*PHI);
  addPermutations(1, PHI, sq(PHI));
  edgeLengthOfPolyhedron = 2;
  factorSizePolyhedron = size/5;
}

void cuboctahedron(int size) {
  addPermutations(1, 0, 1);
  edgeLengthOfPolyhedron = ROOT2;
  factorSizePolyhedron = size /1.9;
}


// TRUNCATED
void truncated_cube(int size) {
  addPermutations(ROOT2 - 1, 1, 1);
  edgeLengthOfPolyhedron = 2*(ROOT2 - 1);     
  factorSizePolyhedron = size /2.1;
}

void truncated_octahedron(int size) {
  addPermutations(0, 1, 2);
  addPermutations(2, 1, 0);
  edgeLengthOfPolyhedron = ROOT2;
  factorSizePolyhedron = size/3.4;
}

void truncated_cuboctahedron(int size) {
  addPermutations(ROOT2 + 1, 2*ROOT2 + 1, 1);
  addPermutations(ROOT2 + 1, 1, 2*ROOT2 + 1);
  edgeLengthOfPolyhedron = 2;
  factorSizePolyhedron = size/6.9;
}

void truncated_dodecahedron(int size) {
  addPermutations(0, 1/PHI, PHI + 2);
  addPermutations(1/PHI, PHI, 2*PHI);
  addPermutations(PHI, 2, sq(PHI));
  edgeLengthOfPolyhedron = 2*(PHI - 1);
  factorSizePolyhedron = size/6;
}

void truncated_icosahedron(int size) {
  addPermutations(0, 1, 3*PHI);
  addPermutations(2, 2*PHI + 1, PHI);
  addPermutations(1, PHI + 2, 2*PHI);
  edgeLengthOfPolyhedron = 2;
  factorSizePolyhedron = size/8;
}

// RHOMBIC
void rhombic_dodecahedron(int size) {
  addVerts(1, 1, 1);
  addPermutations(0, 0, 2);
  edgeLengthOfPolyhedron = sqrt(3);
  factorSizePolyhedron = size /2.8;
}

void rhombic_triacontahedron(int size) {
  addVerts(sq(PHI), sq(PHI), sq(PHI));
  addPermutations(sq(PHI), 0, pow(PHI, 3));
  addPermutations(0, PHI, pow(PHI, 3));
  edgeLengthOfPolyhedron = PHI*sqrt(PHI + 2);
  factorSizePolyhedron = size /7.2;
}

void rhombic_cuboctahedron(int size) {
  addPermutations(ROOT2 + 1, 1, 1);
  edgeLengthOfPolyhedron = 2;
  factorSizePolyhedron = size/4.2;
}

void rhombic_cosi_dodecahedron_small(int size) {
  addPermutations(1, 1, pow(PHI, 3));
  addPermutations(sq(PHI), PHI, 2*PHI);
  addPermutations(PHI + 2, 0, sq(PHI));
  edgeLengthOfPolyhedron = 2;
  factorSizePolyhedron = size/7.4;
}

void rhombic_cosi_dodecahedron_great(int size) {
  addPermutations(1/PHI, 1/PHI, PHI + 3);
  addPermutations(2/PHI, PHI, 2*PHI + 1);
  addPermutations(1/PHI, sq(PHI), 3*PHI - 1);
  addPermutations(2*PHI - 1, 2, PHI + 2);
  addPermutations(PHI, 3, 2*PHI);
  edgeLengthOfPolyhedron = 2*PHI - 2;
  factorSizePolyhedron = size/7.8;
}



//Built Tetrahedron
// EASY METHOD, for direct and single drawing
// classic and easy method
void drawPointPolyhedron(String polyhedronName) {
  for (int i=0; i <listPVectorPolyhedron.size(); i++) {
    PVector point = (PVector)listPVectorPolyhedron.get(i) ;
    if(polyhedronName.equals("TETRAHEDRON")) {
      pushMatrix() ;
      rotateX(TAU -1) ;
      rotateY(PI/4) ;
    }
    point(point.x *factorSizePolyhedron, point.y *factorSizePolyhedron, point.z *factorSizePolyhedron);
    if(polyhedronName.equals("TETRAHEDRON")) popMatrix() ;
  }
}

void drawLinePolyhedron(String polyhedronName) {
  for (int i=0; i <listPVectorPolyhedron.size(); i++) {
    for (int j=i +1; j < listPVectorPolyhedron.size(); j++) {
      if (isEdge(i, j, listPVectorPolyhedron) || edgeLengthOfPolyhedron == 0 ) {
        PVector v1 = (PVector)listPVectorPolyhedron.get(i) ;
        PVector v2 = (PVector)listPVectorPolyhedron.get(j) ;
        if(polyhedronName.equals("TETRAHEDRON")) {
          pushMatrix() ;
          rotateX(TAU -1) ;
          rotateY(PI/4) ;
        }
        line(v1.x *factorSizePolyhedron, v1.y *factorSizePolyhedron, v1.z *factorSizePolyhedron, v2.x *factorSizePolyhedron, v2.y *factorSizePolyhedron, v2.z *factorSizePolyhedron);
        if(polyhedronName.equals("TETRAHEDRON")) popMatrix() ;
      }
    }
  }
}

void drawVertexPolyhedron(String polyhedronName) {
  // TETRAHEDRON
  if(polyhedronName.equals("TETRAHEDRON")) {
    pushMatrix() ;
    rotateX(TAU -1) ;
    rotateY(PI/4) ;
    int n = 4 ; // quantity of face of Tetrahedron
    for(int i = 0 ; i < n ; i++) {
      // choice of each point
      int a = i ;
      int b = i+1 ;
      int c = i+2 ;
      if(i == n-2 ) c = 0 ;
      if(i == n-1 ) {
        b = 0 ;
        c = 1 ;
      }
      PVector v1 = (PVector)listPVectorPolyhedron.get(a) ;
      PVector v2 = (PVector)listPVectorPolyhedron.get(b) ;
      PVector v3 = (PVector)listPVectorPolyhedron.get(c) ;
      // scale the position of the points
      v1 = new PVector(v1.x *factorSizePolyhedron, v1.y *factorSizePolyhedron, v1.z *factorSizePolyhedron) ;
      v2 = new PVector(v2.x *factorSizePolyhedron, v2.y *factorSizePolyhedron, v2.z *factorSizePolyhedron) ;
      v3 = new PVector(v3.x *factorSizePolyhedron, v3.y *factorSizePolyhedron, v3.z *factorSizePolyhedron) ;
      
      // drawing
      beginShape() ;
      vertex(v1.x, v1.y, v1.z) ;
      vertex(v2.x, v2.y, v2.z) ;
      vertex(v3.x, v3.y, v3.z) ;
      endShape(CLOSE) ;
    }
    popMatrix() ;
  // OTHER POLYHEDRON
  } else {
    beginShape() ;
    for (int i=0; i <listPVectorPolyhedron.size(); i++) {
      for (int j=i +1; j <listPVectorPolyhedron.size(); j++) {
        if (isEdge(i, j, listPVectorPolyhedron) || edgeLengthOfPolyhedron == 0 ) {
          // vLine((PVector)listPVectorPolyhedron.get(i), (PVector)listPVectorPolyhedron.get(j));
          PVector v1 = (PVector)listPVectorPolyhedron.get(i) ;
          PVector v2 = (PVector)listPVectorPolyhedron.get(j) ;
          v1 = new PVector(v1.x *factorSizePolyhedron, v1.y *factorSizePolyhedron, v1.z *factorSizePolyhedron) ;
          v2 = new PVector(v2.x *factorSizePolyhedron, v2.y *factorSizePolyhedron, v2.z *factorSizePolyhedron) ;
          vertex(v1.x, v1.y, v1.z) ;
          vertex(v2.x, v2.y, v2.z) ;
        }
      }
    }
    endShape(CLOSE) ;
  }
}
// END of EASY METHOD and DIRECT METHOD

 











// annexe draw polyhedron
boolean isEdge(int vID1, int vID2, ArrayList listPoint) {
  //had some rounding errors that were messing things up, so I had to make it a bit more forgiving...
  int pres = 1000;
  PVector v1 = (PVector)listPoint.get(vID1);
  PVector v2 = (PVector)listPoint.get(vID2);
  float d = sqrt(sq(v1.x - v2.x) + sq(v1.y - v2.y) + sq(v1.z - v2.z)) + .00001;
  return (int(d *pres)==int(edgeLengthOfPolyhedron *pres));
}

// END DRAW POLYHEDRON
//////////////////////


// ADD POINTS for built POLYHEDRON
/////////////////////////////////

 
void addPermutations(float x, float y, float z) {
  //adds vertices for all three permutations of x, y, and z
  addVerts(x, y, z);
  addVerts(z, x, y);
  addVerts(y, z, x);
}


 
void addVerts(float x, float y, float z) {
  //adds the requested vert and all "mirrored" verts
  listPVectorPolyhedron.add (new PVector(x, y, z));
  // z
  if (z != 0.0) listPVectorPolyhedron.add (new PVector(x, y, -z)); 
  // y
  if (y != 0.0) {
    listPVectorPolyhedron.add (new PVector(x, -y, z));
    if (z != 0.0) listPVectorPolyhedron.add (new PVector(x, -y, -z));
  } 
  // x
  if (x != 0.0) {
    listPVectorPolyhedron.add (new PVector(-x, y, z));
    if (z != 0.0) listPVectorPolyhedron.add(new PVector(-x, y, -z));
    if (y != 0.0) {
      listPVectorPolyhedron.add (new PVector(-x, -y, z));
      if (z != 0.0) listPVectorPolyhedron.add (new PVector(-x, -y, -z));
    }
  }
}
// END POLYHEDRON














// END PRIMITIVE 3D
///////////////////

// END GEOMETRY
///////////////












// MISC
////////

// MAP
float mapLocked(float value, float sourceMin, float sourceMax, float targetMin, float targetMax) {
  if(sourceMax >= targetMax ) sourceMax = targetMax ;
  if (value < sourceMin ) value = sourceMin ;
  if (value > sourceMax ) value = sourceMax ;
  float newMax = sourceMax - sourceMin ;
  float deltaTarget = targetMax - targetMin ;
  float ratio = ((value - sourceMin) / newMax ) ;
  float result = targetMin +deltaTarget *ratio;
  return result; 
}

float mapStartSmooth(float value, float sourceMin, float sourceMax, float targetMin, float targetMax, int level) {
  if(sourceMax >= targetMax ) sourceMax = targetMax ;
  if (value < sourceMin ) value = sourceMin ;
  if (value > sourceMax ) value = sourceMax ;
  float newMax = sourceMax - sourceMin ;
  float deltaTarget = targetMax - targetMin ;
  float ratio = ((value - sourceMin) / newMax ) ;
  ratio = pow(ratio, level) ;
  float result = targetMin +deltaTarget *ratio;
  return result;
}

float mapEndSmooth(float value, float sourceMin, float sourceMax, float targetMin, float targetMax, int level) {
  if(sourceMax >= targetMax ) sourceMax = targetMax ;
  if (value < sourceMin ) value = sourceMin ;
  if (value > sourceMax ) value = sourceMax ;
  float newMax = sourceMax - sourceMin ;
  float deltaTarget = targetMax - targetMin ;
  float ratio = ((value - sourceMin) / newMax ) ;
  ratio = roots(ratio, level) ;
  float result = targetMin +deltaTarget *ratio;
  return result;
}


float mapEndStartSmooth(float value, float sourceMin, float sourceMax, float targetMin, float targetMax, int level) {
  if(sourceMax >= targetMax ) sourceMax = targetMax ;
  if (value < sourceMin ) value = sourceMin ;
  if (value > sourceMax ) value = sourceMax ;
  float newMax = sourceMax - sourceMin ;
  float deltaTarget = targetMax - targetMin ;
  float ratio = ((value - sourceMin) / newMax ) ;
  ratio = map(ratio,0,1, -1, 1 ) ;
  int correction = 1 ;
  if(level % 2 == 1 ) correction = 1 ; else correction = -1 ;
  if (ratio < 0 ) ratio = pow(ratio, level) *correction  ; else ratio = pow(ratio, level)  ;
  ratio = map(ratio, -1,1, 0,1) ;
  float result = targetMin +deltaTarget *ratio;
  return result;
}
// END MAP





// MATH PVECTOR
///////////////
// FOLLOW PVECTOR
PVector goToPosFollow = new PVector() ;
// CALCULATE THE POS of PVector Traveller, give the target pos and the speed to go.
PVector follow(PVector target, float speed) {
  // calcul X pos
  float targetX = target.x;
  float dx = targetX - goToPosFollow.x;
  if(abs(dx) != 0) {
    goToPosFollow.x += dx * speed;
  }
  // calcul Y pos
  float targetY = target.y;
  float dy = targetY - goToPosFollow.y;
  if(abs(dy) != 0) {
    goToPosFollow.y += dy * speed;
  }
  // calcul Z pos
  float targetZ = target.z;
  float dz = targetZ - goToPosFollow.z;
  if(abs(dz) != 0) {
    goToPosFollow.z += dz * speed;
  }
  return goToPosFollow ;
}


//////////////////////////////////////////////
// THIS PART MUST BE DEPRECaTED in the future

// CALCULATE THE POS of PVector Traveller
PVector gotoTarget(PVector origin,  PVector finish, float speed) {
  PVector pos = new PVector() ;
  if(origin.x > finish.x) pos.x = origin.x  -distanceDone(origin, finish, speed).x ; else pos.x = origin.x  +distanceDone(origin, finish, speed).x ; 
  if(origin.y > finish.y) pos.y = origin.y  -distanceDone(origin, finish, speed).y ; else pos.y = origin.y  +distanceDone(origin, finish, speed).y ; 
  if(origin.z > finish.z) pos.z = origin.z  -distanceDone(origin, finish, speed).z ; else pos.z = origin.z  +distanceDone(origin, finish, speed).z ; 
  return pos ;
}
// end calcultate




// DISTANCE DONE
PVector distance, distanceToDo ;
PVector distanceDone = new PVector() ;

PVector distanceDone(PVector origin,  PVector finish, float speedRef) {
  PVector dist = new PVector() ;
  PVector distance = new PVector() ;
  boolean stopX = false ;
  boolean stopY = false ;
  boolean stopZ = false ;
  distance.x = abs(finish.x - origin.x) ;
  distance.y = abs(finish.y - origin.y) ;
  distance.z = abs(finish.z - origin.z) ;
  //calcul the speed for XYZ
  PVector speed = new PVector(speedMoveTo(distance.x, speedRef), speedMoveTo(distance.y, speedRef), speedMoveTo(distance.z, speedRef)) ;
  // for the X
  dist.x = distance.x -distanceDone.x ;
  if(dist.x <= 0 ) stopX = true ; else stopX = false ;
  if(speed.x > dist.x ) speed.x = dist.x ;
  if(!stopX) distanceDone.x += speed.x ; else distanceDone.x = distance.x ;
  // for the Y
  dist.y = distance.y -distanceDone.y ;
  if(dist.y <= 0 ) stopY = true ; else stopY = false ;
  if(speed.y > dist.y ) speed.y = dist.y ;
  if(!stopY) distanceDone.y += speed.y ; else distanceDone.y = distance.y ;
  // for the Z
  dist.z = distance.z -distanceDone.z ;
  if(dist.z <= 0 ) stopZ = true ; else stopZ = false ;
  if(speed.z > dist.z ) speed.z = dist.z ;
  if(!stopZ) distanceDone.z += speed.z ; else distanceDone.z = distance.z ;
  //
  return distanceDone ;
}


float speedMoveTo(float distance, float speed) {
  return distance *1 *speed ;
}


// END of the deprecated function
/////////////////////////////////
