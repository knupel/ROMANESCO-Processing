/**
Vec and iVec method
the idea here is create method directly insprating from Processing to simplify the coder life
v 1.0.2

*/
/**
set
*/
void set(iVec2 pos, int c) {
  set(pos.x, pos.y, c) ;
}

void set(Vec2 pos, int c) {
  set((int)pos.x, (int)pos.y, c) ;
}
/**
random
*/
float random (Vec2 v) {
  return random(v.x, v.y) ;
}

float random (iVec2 v) {
  return random(v.x, v.y) ;
}
/**
background
*/
// Vec
void background(Vec4 c) {
  background(c.r,c.g,c.b,c.a) ;
}

void background(Vec3 c) {
  background(c.r,c.g,c.b) ;
}

void background(Vec2 c) {
  background(c.x,c.y) ;
}
// iVec
void background(iVec4 c) {
  background(c.x,c.y,c.z,c.w) ;
}

void background(iVec3 c) {
  background(c.x,c.y,c.z) ;
}

void background(iVec2 c) {
  background(c.x,c.y) ;
}

/**
Ellipse
*/
// Vec
void ellipse(Vec2 p, Vec2 s) {
  ellipse(p.x, p.y, s.x, s.y) ;
}
void ellipse(Vec3 p, Vec2 s) {
  if(renderer_P3D()) {
    start_matrix() ;
    translate(p.x, p.y, p.z) ;
    ellipse(0,0, s.x, s.y) ;
    stop_matrix() ;
  } else ellipse(p.x, p.y, s.x, s.y) ;
}

// iVec
void ellipse(iVec2 p, iVec2 s) {
  ellipse(p.x, p.y, s.x, s.y) ;
}
void ellipse(iVec3 p, iVec2 s) {
  Vec3 temp_pos = Vec3((int)p.x, (int)p.y, (int)p.z);
  Vec2 temp_size = Vec2((int)s.x,(int)s.y);
  ellipse(temp_pos, temp_size) ;
}



/**
Rect
*/
void rect(Vec2 p, Vec2 s) {
  rect(p.x, p.y, s.x, s.y) ;
}
void rect(Vec3 p, Vec2 s) {
  if(renderer_P3D()) {
    start_matrix() ;
    translate(p.x, p.y,p.z ) ;
    rect(0,0, s.x, s.y) ;
    stop_matrix() ;
  } else rect(p.x, p.y, s.x, s.y) ;
}

void rect(iVec2 p, iVec2 s) {
  rect(p.x, p.y, s.x, s.y) ;
}

void rect(iVec3 p, iVec2 s) {
  Vec3 temp_pos = Vec3((int)p.x, (int)p.y, (int)p.z);
  Vec2 temp_size = Vec2((int)s.x, (int)s.y);
  rect(temp_pos, temp_size) ;
}

/**
Box
*/
void box(Vec3 p) {
  box(p.x, p.y, p.z) ;
}

void box(iVec3 p) {
  box(p.x, p.y, p.z) ;
}

/**
Point
*/
void point(Vec2 p) {
  point(p.x, p.y) ;
}
void point(Vec3 p) {
  if(renderer_P3D()) point(p.x, p.y, p.z) ; else  point(p.x, p.y) ;
}

void point(iVec2 p) {
  point(p.x, p.y) ;
}
void point(iVec3 p) {
  if(renderer_P3D()) point(p.x, p.y, p.z) ; else  point(p.x, p.y) ;
}
/**
Line
*/
void line(Vec2 a, Vec2 b){
  line(a.x, a.y, b.x,b.y) ;
}
void line(Vec3 a, Vec3 b){
  if(renderer_P3D()) line(a.x, a.y, a.z, b.x,b.y, b.z) ; else line(a.x, a.y, b.x,b.y) ;
}

void line(iVec2 a, iVec2 b){
  line(a.x, a.y, b.x,b.y) ;
}
void line(iVec3 a, iVec3 b){
  if(renderer_P3D()) line(a.x, a.y, a.z, b.x,b.y, b.z) ; else line(a.x, a.y, b.x,b.y) ;
}
/**
Vertex
*/
void vertex(Vec2 a){
  vertex(a.x, a.y) ;
}
void vertex(Vec3 a){
  if(renderer_P3D()) vertex(a.x, a.y, a.z) ; else vertex(a.x, a.y) ;
}

void vertex(iVec2 a){
  vertex(a.x, a.y) ;
}
void vertex(iVec3 a){
  if(renderer_P3D()) vertex(a.x, a.y, a.z) ; else vertex(a.x, a.y) ;
}

/**
Bezier Vertex
*/
void bezierVertex(Vec2 a, Vec2 b, Vec2 c) {
  bezierVertex(a.x, a.y, b.x, b.y, c.x, c.y) ;
}

void bezierVertex(Vec3 a, Vec3 b, Vec3 c) {
  if(renderer_P3D()) bezierVertex(a.x, a.y, a.z, b.x, b.y, b.z, c.x, c.y, c.z) ; else bezierVertex(a.x, a.y, b.x, b.y, c.x, c.y) ;
}

void bezierVertex(iVec2 a, iVec2 b, iVec2 c) {
  bezierVertex(a.x, a.y, b.x, b.y, c.x, c.y) ;
}

void bezierVertex(iVec3 a, iVec3 b, iVec3 c) {
  if(renderer_P3D()) bezierVertex(a.x, a.y, a.z, b.x, b.y, b.z, c.x, c.y, c.z) ; else bezierVertex(a.x, a.y, b.x, b.y, c.x, c.y) ;
}

/**
Quadratic Vertex
*/
void quadraticVertex(Vec2 a, Vec2 b) {
  quadraticVertex(a.x, a.y, b.x, b.y) ;
}

void quadraticVertex(Vec3 a, Vec3 b) {
  if(renderer_P3D()) quadraticVertex(a.x, a.y, a.z, b.x, b.y, b.z) ; else quadraticVertex(a.x, a.y, b.x, b.y) ;
}

void quadraticVertex(iVec2 a, iVec2 b) {
  quadraticVertex(a.x, a.y, b.x, b.y) ;
}

void quadraticVertex(iVec3 a, iVec3 b) {
  if(renderer_P3D()) quadraticVertex(a.x, a.y, a.z, b.x, b.y, b.z) ; else quadraticVertex(a.x, a.y, b.x, b.y) ;
}

/**
Curve Vertex
*/
void curveVertex(Vec2 a){
  curveVertex(a.x, a.y) ;
}
void curveVertex(Vec3 a){
  if(renderer_P3D()) curveVertex(a.x, a.y, a.z) ; else curveVertex(a.x, a.y) ;
}

void curveVertex(iVec2 a){
  curveVertex(a.x, a.y) ;
}
void curveVertex(iVec3 a){
  if(renderer_P3D()) curveVertex(a.x, a.y, a.z) ; else curveVertex(a.x, a.y) ;
}


/**
Fill
*/
// vec
void fill(Vec2 c) {
  if( c.y > 0) fill(c.x, c.y) ; else noFill() ;
}
void fill(Vec3 c) {
  fill(c.r,c.g,c.b) ;
}

void fill(Vec3 c, float a) {
  if( a > 0)  fill(c.r,c.g,c.b, a) ; else noFill() ;
}

void fill(Vec4 c) {
  if( c.w > 0) fill(c.x, c.y, c.z, c.w) ; else noFill() ;
}

// iVec
void fill(iVec2 c) {
  if( c.y > 0) fill(c.x, c.y) ; else noFill() ;
}
void fill(iVec3 c) {
  fill(c.x, c.y, c.z) ;
}

void fill(iVec3 c, float a) {
  if( a > 0)  fill(c.x, c.y, c.z, a) ; else noFill() ;
}

void fill(iVec4 c) {
  if( c.w > 0) fill(c.x, c.y, c.z, c.w) ; else noFill() ;
}
/**
Stroke
*/
// Vec
void stroke(Vec2 c) {
  if(c.y > 0) stroke(c.x, c.y) ; else noStroke() ;
}
void stroke(Vec3 c) {
  stroke(c.r,c.g,c.b) ;
}

void stroke(Vec3 c, float a) {
  if( a > 0)  stroke(c.r,c.g,c.b, a) ; else noStroke() ;
}

void stroke(Vec4 c) {
  if(c.a > 0) stroke(c.r,c.g,c.b,c.a) ; else noStroke() ;
}
// iVec
void stroke(iVec2 c) {
  if(c.y > 0) stroke(c.x, c.y) ; else noStroke() ;
}
void stroke(iVec3 c) {
  stroke(c.x, c.y, c.z) ;
}

void stroke(iVec3 c, float a) {
  if( a > 0)  stroke(c.x, c.y, c.z, a) ; else noStroke() ;
}

void stroke(iVec4 c) {
  if(c.w > 0) stroke(c.x, c.y, c.z, c.w) ; else noStroke() ;
}



/**
text
*/
void text(String s, Vec pos) {
  if(pos instanceof Vec2) {
    Vec2 p = (Vec2) pos ;
    text(s, p.x, p.y) ;
  } else if(pos instanceof Vec3) {
    Vec3 p = (Vec3) pos ;
    text(s, p.x, p.x, p.z) ;
  }
}

void text(char c, Vec pos) {
  if(pos instanceof Vec2) {
    Vec2 p = (Vec2) pos ;
    text(c, p.x, p.y) ;
  } else if(pos instanceof Vec3) {
    Vec3 p = (Vec3) pos ;
    text(c, p.x, p.x, p.z) ;
  }
}

void text(int num, Vec pos) {
  if(pos instanceof Vec2) {
    Vec2 p = (Vec2) pos ;
    text(num, p.x, p.y) ;
  } else if(pos instanceof Vec3) {
    Vec3 p = (Vec3) pos ;
    text(num, p.x, p.x, p.z) ;
  }
}

void text(float num, Vec pos) {
  if(pos instanceof Vec2) {
    Vec2 p = (Vec2) pos ;
    text(num, p.x, p.y) ;
  } else if(pos instanceof Vec3) {
    Vec3 p = (Vec3) pos ;
    text(num, p.x, p.x, p.z) ;
  }
}

// iVec
void text(String s, iVec pos) {
  if(pos instanceof iVec2) {
    Vec2 temp_pos = Vec2(pos.x, pos.y);
    text(s, temp_pos);
  } else if(pos instanceof iVec2) {
    Vec3 temp_pos = Vec3(pos.x, pos.y, pos.z);
    text(s, temp_pos);
  }  
}

void text(char c, iVec pos) {
  if(pos instanceof iVec2) {
    Vec2 temp_pos = Vec2(pos.x, pos.y);
    text(c, temp_pos);

  } else if(pos instanceof iVec2) {
    Vec3 temp_pos = Vec3(pos.x, pos.y, pos.z);
    text(c, temp_pos);
  }  
}

void text(int num, iVec pos) {
  if(pos instanceof iVec2) {
    Vec2 temp_pos = Vec2(pos.x, pos.y);
    text(num, temp_pos);

  } else if(pos instanceof iVec2) {
    Vec3 temp_pos = Vec3(pos.x, pos.y, pos.z);
    text(num, temp_pos);
  }  
}

void text(float num, iVec pos) {
  if(pos instanceof iVec2) {
    Vec2 temp_pos = Vec2(pos.x, pos.y);
    text(num, temp_pos);

  } else if(pos instanceof iVec2) {
    Vec3 temp_pos = Vec3(pos.x, pos.y, pos.z);
    text(num, temp_pos);
  }  
}

/**
image
v 0.0.2
*/
void image(PImage img, iVec pos) {
  if(pos instanceof iVec2) {
    image(img, Vec2(pos.x, pos.y));
  } else if(pos instanceof iVec3) {
    image(img, Vec3(pos.x, pos.y, pos.z));
  }
}

void image(PImage img, iVec pos, iVec2 size) {
  if(pos instanceof iVec2) {
    image(img, Vec2(pos.x, pos.y), Vec2(size.x, size.y));
  } else if(pos instanceof iVec3) {
    image(img, Vec3(pos.x, pos.y, pos.z), Vec2(size.x, size.y));
  } 
}


void image(PImage img, Vec pos) {
  if(pos instanceof Vec2) {
    Vec2 p = (Vec2) pos ;
    image(img, p.x, p.y) ;
  } else if(pos instanceof Vec3) {
    Vec3 p = (Vec3) pos ;
    start_matrix() ;
    translate(p) ;
    image(img, 0,0) ;
    stop_matrix() ;
  }
}

void image(PImage img, Vec pos, Vec2 size) {
  if(pos instanceof Vec2) {
    Vec2 p = (Vec2) pos ;
    image(img, p.x, p.y, size.x, size.y) ;
  } else if(pos instanceof Vec3) {
    Vec3 p = (Vec3) pos ;
    start_matrix() ;
    translate(p) ;
    image(img, 0,0, size.x, size.y) ;
    stop_matrix() ;
  }
}





/**
Translate
*/
// Vec
void translate(Vec3 t){
  if(renderer_P3D()) translate(t.x, t.y, t.z) ; else translate(t.x, t.y) ;
}

void translate(Vec2 t){
  translate(t.x, t.y) ;
}
// iVec
void translate(iVec3 t){
  if(renderer_P3D()) translate(t.x, t.y, t.z) ; else translate(t.x, t.y) ;
}

void translate(iVec2 t){
  translate(t.x, t.y) ;
}

void translateX(float t){
  translate(t, 0) ;
}

void translateY(float t){
  translate(0, t) ;
}

void translateZ(float t){
  translate(0, 0, t) ;
}


/**
Rotate
*/
// Vec
void rotateXY(Vec2 rot) {
  rotateX(rot.x) ;
  rotateY(rot.y) ;
}

void rotateXZ(Vec2 rot) {
  rotateX(rot.x) ;
  rotateZ(rot.y) ;
}

void rotateYZ(Vec2 rot) {
  rotateY(rot.x) ;
  rotateZ(rot.y) ;
}
void rotateXYZ(Vec3 rot) {
  rotateX(rot.x) ;
  rotateY(rot.y) ;
  rotateZ(rot.z) ;
}

// iVec
void rotateXY(iVec2 rot) {
  rotateX(rot.x) ;
  rotateY(rot.y) ;
}

void rotateXZ(iVec2 rot) {
  rotateX(rot.x) ;
  rotateZ(rot.y) ;
}

void rotateYZ(iVec2 rot) {
  rotateY(rot.x) ;
  rotateZ(rot.y) ;
}
void rotateXYZ(iVec3 rot) {
  rotateX(rot.x) ;
  rotateY(rot.y) ;
  rotateZ(rot.z) ;
}

/**
Matrix

*/
// Vec
void start_matrix_3D(Vec pos, Vec3 dir_cart) {
  Vec3 dir = dir_cart.copy() ;
  pushMatrix() ;
  if(pos instanceof Vec2) {
    Vec2 p = (Vec2) pos ;
    translate(p) ;
  } else if(pos instanceof Vec3) {
    Vec3 p = (Vec3) pos ;
    translate(p) ;
  } else {
    System.err.println("error in start_matrix_3D(), Vec pos is not an instance of Vec2 or Vec3, the matrix don't translate your object") ;
    exit() ;
  }
  float radius = sqrt(dir.x * dir.x + dir.y * dir.y + dir.z * dir.z);
  float longitude = acos(dir.x / sqrt(dir.x * dir.x + dir.y * dir.y)) * (dir.y < 0 ? -1 : 1);
  float latitude = acos(dir.z / radius) * (dir.z < 0 ? -1 : 1);
  // check NaN result
  if (Float.isNaN(longitude)) longitude = 0 ;
  if (Float.isNaN(latitude)) latitude = 0 ;
  if (Float.isNaN(radius)) radius = 0 ;
  rotateX(latitude) ;
  rotateY(longitude) ;
}

void start_matrix_3D(Vec pos, Vec2 dir_polar) {
  if(pos instanceof Vec2) {
    Vec2 p = (Vec2) pos ;
    pushMatrix() ;
    translate(p) ;
    rotateXY(dir_polar) ;
  } else if(pos instanceof Vec3) {
    Vec3 p = (Vec3) pos ;
    pushMatrix() ;
    translate(p) ;
    rotateXY(dir_polar) ;
  } else {
    System.err.println("error in start_matrix_3D(), Vec pos is not an instance of Vec2 or Vec3, the matrix cannot be init") ;
    exit() ;
  }
}

void start_matrix_2D(Vec pos, float orientation) {
  if(pos instanceof Vec2) {
    Vec2 p = (Vec2) pos ;
    pushMatrix() ;
    translate(p) ;
    rotate(orientation) ;
  } else if(pos instanceof Vec3) {
    Vec3 p = (Vec3) pos ;
    pushMatrix() ;
    translate(p.x, p.y) ;
    rotate(orientation) ;
  } else {
    System.err.println("Vec pos is not an instance of Vec2 or Vec3, the matrix cannot be init") ;
    exit() ;
  }
}

// iVec
void start_matrix_3D(iVec pos, iVec3 dir_cart) {
  Vec3 temp_dir_cart = Vec3(dir_cart.x, dir_cart.y, dir_cart.z);
  if(pos instanceof iVec2) {
    Vec2 temp_pos = Vec2(pos.x, pos.y);
    start_matrix_3D(temp_pos, temp_dir_cart);
  } else if(pos instanceof iVec3) {
    Vec3 temp_pos = Vec3(pos.x, pos.y, pos.z);
    start_matrix_3D(temp_pos, temp_dir_cart);
  } 
}

void start_matrix_3D(iVec pos, iVec2 dir_polar) {
  Vec2 temp_dir_polar = Vec2(dir_polar.x, dir_polar.y);
  if(pos instanceof iVec2) {
    Vec2 temp_pos = Vec2(pos.x, pos.y);
    start_matrix_3D(temp_pos, temp_dir_polar);
  } else if(pos instanceof iVec3) {
    Vec3 temp_pos = Vec3(pos.x, pos.y, pos.z);
    start_matrix_3D(temp_pos, temp_dir_polar);
  }
}

void start_matrix_2D(iVec pos, float orientation) {
  if(pos instanceof iVec2) {
    Vec2 temp_pos = Vec2(pos.x, pos.y);
    start_matrix_2D(temp_pos, orientation);
  } else if(pos instanceof iVec3) {
    Vec3 temp_pos = Vec3(pos.x, pos.y, pos.z);
    start_matrix_2D(temp_pos, orientation);
  }
}



// stop ans Start Matrix
void stop_matrix() {
  popMatrix() ;
}

void start_matrix() {
  pushMatrix() ;
}


/**
Matrix 
deprecated
*/
void matrix_3D_start(Vec3 pos, Vec3 dir_cart) {
  Vec3 dir = dir_cart.copy() ;
  pushMatrix() ;
  translate(pos) ;
  float radius = sqrt(dir.x * dir.x + dir.y * dir.y + dir.z * dir.z);
  float longitude = acos(dir.x / sqrt(dir.x * dir.x + dir.y * dir.y)) * (dir.y < 0 ? -1 : 1);
  float latitude = acos(dir.z / radius) * (dir.z < 0 ? -1 : 1);
  // check NaN result
  if (Float.isNaN(longitude)) longitude = 0 ;
  if (Float.isNaN(latitude)) latitude = 0 ;
  if (Float.isNaN(radius)) radius = 0 ;
  rotateX(latitude) ;
  rotateY(longitude) ;
  System.err.println("Deprecated method matrix_3D_start(Vec3 arg, Vec3 cartesian_dir) is deprecated instead use start_matrix_3D(Vec3 arg, Vec3 cartesian_dir)") ;
}

void matrix_3D_start(Vec3 pos, Vec2 dir_polar) {
  pushMatrix() ;
  translate(pos) ;
  rotateXY(dir_polar) ;
  System.err.println("Deprecated method matrix_3D_start(Vec3 arg, Vec3 polar_dir) is deprecated instead use start_matrix_3D(Vec3 arg, Vec2 polar_dir)") ;
}

void matrix_2D_start(Vec2 pos, float orientation) {
  pushMatrix() ;
  translate(pos) ;
  rotate(orientation) ;
  System.err.println("Deprecated method matrix_2D_start(Vec2 pos, float orientation) is deprecated instead use start_matrix_2D(Vec2 pos, float orientation)") ;
}

void matrix_end() {
  popMatrix() ;
  System.err.println("Deprecated method matrix_end() is deprecated instead use stop_matrix()") ;
}

void matrix_start() {
  pushMatrix() ;
  System.err.println("Deprecated method matrix_start() is deprecated instead use start_matrix()") ;
}