/**
ROPE METHOD
v 1.4.1
* Copyleft (c) 2014-2018
* Stan le Punk > http://stanlepunk.xyz/
Processing and Vec, iVec and bVec method
the idea here is create method directly insprating from Processing to simplify the coder life
* @author Stan le Punk
* @see https://github.com/StanLepunK/Rope
*/



/**
colorMode
*/
/**
* colorMode(Vec5 color_component)
* @param component give in order : mode, x, y, z and alpha
*/
void colorMode(Vec5 component) {
  int mode = (int)component.a;
  if(mode == HSB) {
    colorMode(HSB,component.b,component.c,component.d,component.e);
  } else if(mode == RGB) {
    colorMode(RGB,component.b,component.c,component.d,component.e);
  } else {
    printErr("The first component of your vec is", mode, "and don't match with any Processing colorMode, instead the current colorMode will be used");
  }
}
/**
* colorMode(int mode, Vec4 color_component)
* @param mode give environment HSB or RGB
* @param color_component give in order : x, y, z and alpha
*/
void colorMode(int mode, Vec4 component) {
  if(mode == HSB) {
    colorMode(HSB,component.x,component.y,component.z,component.w);
  } else if(mode == RGB) {
    colorMode(RGB,component.x,component.y,component.z,component.w);
  } else {
    printErr("int mode", mode, "don't match with any Processing colorMode, instead the current colorMode will be used");
  }
}
/**
* colorMode(int mode, Vec3 color_component)
* @param mode give environment HSB or RGB
* @param color_component give in order : x, y, z
*/
void colorMode(int mode, Vec3 component) {
  colorMode(mode, Vec4(component.x,component.y,component.z,g.colorModeA));
}
/**
* colorMode(int mode, Vec2 color_component)
* @param mode give environment HSB or RGB
* @param color_component give in order the x give x,y,z and y give the alpha
*/
void colorMode(int mode, Vec2 component) {
   colorMode(mode, Vec4(component.x,component.x,component.x,component.y));
}

/**
floor
*/
iVec2 floor(Vec2 arg) {
  return iVec2(floor(arg.x),floor(arg.y));
}

iVec3 floor(Vec3 arg) {
  return iVec3(floor(arg.x),floor(arg.y),floor(arg.z));
}

iVec4 floor(Vec4 arg) {
  return iVec4(floor(arg.x),floor(arg.y),floor(arg.z),floor(arg.w));
}

/**
round
*/
iVec2 round(Vec2 arg) {
  return iVec2(round(arg.x),round(arg.y));
}

iVec3 round(Vec3 arg) {
  return iVec3(round(arg.x),round(arg.y),round(arg.z));
}

iVec4 round(Vec4 arg) {
  return iVec4(round(arg.x),round(arg.y),round(arg.z),round(arg.w));
}

/**
ceil
*/
iVec2 ceil(Vec2 arg) {
  return iVec2(ceil(arg.x),ceil(arg.y));
}

iVec3 ceil(Vec3 arg) {
  return iVec3(ceil(arg.x),ceil(arg.y),ceil(arg.z));
}

iVec4 ceil(Vec4 arg) {
  return iVec4(ceil(arg.x),ceil(arg.y),ceil(arg.z),ceil(arg.w));
}

/**
set
*/
void set(iVec2 pos, int c) {
  set(pos.x, pos.y, c);
}

void set(Vec2 pos, int c) {
  set((int)pos.x, (int)pos.y, c);
}
/**
random
*/
float random (Vec2 v) {
  return random(v.x, v.y);
}

float random (iVec2 v) {
  return random(v.x, v.y);
}




/**
Ellipse
v 0.1.1
*/
// with Vec2 or iVec2
void ellipse(Vec2 p, Vec s) {
  ellipse(p.x,p.y, s.x,s.y);
}

void ellipse(Vec2 p, float x, float y) {
  ellipse(p.x,p.y,x,y);
}

void ellipse(Vec2 p, float x) {
  ellipse(p.x,p.y,x,x);
}


// iVec
void ellipse(iVec2 p, iVec s) {
  ellipse(p.x,p.y,s.x,s.y) ;
}

void ellipse(iVec2 p, int x, int y) {
  ellipse(p.x,p.y, x,y);
}

void ellipse(iVec2 p, int x) {
  ellipse(p.x,p.y,x,x);
}

// with Vec3 or iVec3
void ellipse(iVec3 p, int x, int y) {
  ellipse(p,iVec2(x,y));
}

void ellipse(iVec3 p, int x) {
  ellipse(p,iVec2(x));
}

void ellipse(iVec3 p, iVec s) {
  Vec3 temp_pos = Vec3((int)p.x, (int)p.y, (int)p.z);
  Vec2 temp_size = Vec2((int)s.x,(int)s.y);
  ellipse(temp_pos, temp_size);
}


void ellipse(Vec3 p, float x, float y) {
  ellipse(p,Vec2(x,y));
}

void ellipse(Vec3 p, float x) {
  ellipse(p,Vec2(x));
}

/**
main method
*/
void ellipse(Vec3 p, Vec s) {
  if(renderer_P3D()) {
    start_matrix() ;
    translate(p.x, p.y, p.z);
    ellipse(0,0, s.x, s.y);
    stop_matrix() ;
  } else {
    ellipse(p.x,p.y,s.x,s.y);
  }
}







/**
Rect
*/
void rect(Vec2 p, Vec2 s) {
  rect(p.x,p.y, s.x,s.y);
}
void rect(Vec3 p, Vec2 s) {
  if(renderer_P3D()) {
    start_matrix();
    translate(p.x, p.y,p.z );
    rect(0,0, s.x, s.y);
    stop_matrix();
  } else rect(p.x, p.y, s.x, s.y);
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
  if(renderer_P3D()) point(p.x, p.y, p.z); 
  else point(p.x, p.y) ;
}

void point(iVec2 p) {
  point(p.x, p.y) ;
}
void point(iVec3 p) {
  if(renderer_P3D()) point(p.x, p.y, p.z); 
  else point(p.x, p.y);
}
/**
Line
*/
void line(Vec2 a, Vec2 b){
  line(a.x,a.y, b.x,b.y) ;
}
void line(Vec3 a, Vec3 b){
  if(renderer_P3D()) line(a.x, a.y, a.z, b.x,b.y, b.z); 
  else line(a.x,a.y, b.x,b.y);
}

void line(iVec2 a, iVec2 b) {
  line(a.x,a.y, b.x,b.y);
}

void line(iVec3 a, iVec3 b) {
  if(renderer_P3D()) line(a.x, a.y, a.z, b.x,b.y, b.z); 
  else line(a.x,a.y, b.x,b.y);
}
/**
Vertex
v 0.0.2
*/
void vertex(Vec2 xy) {
  vertex(xy.x,xy.y);
}

void vertex(Vec3 xyz) {
  if(renderer_P3D()) vertex(xyz.x, xyz.y, xyz.z); 
  else vertex(xyz.x, xyz.y);
}
//
void vertex(iVec2 xy) {
  vertex(xy.x,xy.y);
}

void vertex(iVec3 xyz){
  if(renderer_P3D()) vertex(xyz.x, xyz.y, xyz.z); 
  else vertex(xyz.x, xyz.y);
}
//
void vertex(Vec2 xy, Vec2 uv) {
  vertex(xy.x, xy.y, uv.u, uv.v);
}

void vertex(iVec2 xy, Vec2 uv) {
  vertex(xy.x, xy.y, uv.u, uv.v);
}
//
void vertex(Vec3 xyz, Vec2 uv) {
  if(renderer_P3D()) vertex(xyz.x, xyz.y, xyz.z, uv.u, uv.v); 
  else vertex(xyz.x, xyz.y, uv.u, uv.v);
}

void vertex(iVec3 xyz, Vec2 uv) {
  if(renderer_P3D()) vertex(xyz.x, xyz.y, xyz.z, uv.u, uv.v); 
  else vertex(xyz.x, xyz.y, uv.u, uv.v);
}
/**
Bezier Vertex
*/

void bezierVertex(Vec2 a, Vec2 b, Vec2 c) {
  bezierVertex(a.x, a.y, b.x, b.y, c.x, c.y);
}

void bezierVertex(Vec3 a, Vec3 b, Vec3 c) {
  if(renderer_P3D()) bezierVertex(a.x, a.y, a.z, b.x, b.y, b.z, c.x, c.y, c.z); 
  else bezierVertex(a.x, a.y, b.x, b.y, c.x, c.y);
}

void bezierVertex(iVec2 a, iVec2 b, iVec2 c) {
  bezierVertex(a.x, a.y, b.x, b.y, c.x, c.y);
}

void bezierVertex(iVec3 a, iVec3 b, iVec3 c) {
  if(renderer_P3D()) bezierVertex(a.x, a.y, a.z, b.x, b.y, b.z, c.x, c.y, c.z); 
  else bezierVertex(a.x, a.y, b.x, b.y, c.x, c.y);
}

/**
Quadratic Vertex
*/
void quadraticVertex(Vec2 a, Vec2 b) {
  quadraticVertex(a.x, a.y, b.x, b.y);
}

void quadraticVertex(Vec3 a, Vec3 b) {
  if(renderer_P3D()) quadraticVertex(a.x, a.y, a.z, b.x, b.y, b.z); 
  else quadraticVertex(a.x, a.y, b.x, b.y) ;
}

void quadraticVertex(iVec2 a, iVec2 b) {
  quadraticVertex(a.x, a.y, b.x, b.y);
}

void quadraticVertex(iVec3 a, iVec3 b) {
  if(renderer_P3D()) quadraticVertex(a.x, a.y, a.z, b.x, b.y, b.z); 
  else quadraticVertex(a.x, a.y, b.x, b.y);
}

/**
Curve Vertex
*/
void curveVertex(Vec2 a) {
  curveVertex(a.x, a.y);
}
void curveVertex(Vec3 a){
  if(renderer_P3D()) curveVertex(a.x, a.y, a.z) ; 
  else curveVertex(a.x, a.y);
}

void curveVertex(iVec2 a) {
  curveVertex(a.x, a.y);
}
void curveVertex(iVec3 a){
  if(renderer_P3D()) curveVertex(a.x, a.y, a.z) ; 
  else curveVertex(a.x, a.y);
}


/**
Fill
*/
// vec
void fill(Vec2 c) {
  if( c.y > 0) fill(c.x, c.y); 
  else noFill();
}
void fill(Vec3 c) {
  fill(c.r,c.g,c.b) ;
}

void fill(Vec3 c, float a) {
  if(a > 0) fill(c.r,c.g,c.b, a); 
  else noFill();
}

void fill(Vec4 c) {
  if(c.w > 0) fill(c.x, c.y, c.z, c.w); 
  else noFill();
}

// iVec
void fill(iVec2 c) {
  if(c.y > 0) fill(c.x, c.y); 
  else noFill();
}
void fill(iVec3 c) {
  fill(c.x, c.y, c.z);
}

void fill(iVec3 c, float a) {
  if(a > 0) fill(c.x,c.y,c.z,a);
  else noFill();
}

void fill(iVec4 c) {
  if(c.w > 0) fill(c.x, c.y, c.z, c.w); 
  else noFill();
}
/**
Stroke
*/
// Vec
void stroke(Vec2 c) {
  if(c.y > 0) stroke(c.x, c.y); 
  else noStroke();
}
void stroke(Vec3 c) {
  stroke(c.r,c.g,c.b);
}

void stroke(Vec3 c, float a) {
  if(a > 0) stroke(c.r,c.g,c.b, a); 
  else noStroke();
}

void stroke(Vec4 c) {
  if(c.a > 0) stroke(c.r,c.g,c.b,c.a); 
  else noStroke();
}
// iVec
void stroke(iVec2 c) {
  if(c.y > 0) stroke(c.x, c.y); 
  else noStroke();
}
void stroke(iVec3 c) {
  stroke(c.x, c.y, c.z);
}

void stroke(iVec3 c, float a) {
  if(a > 0) stroke(c.x, c.y, c.z, a); 
  else noStroke();
}

void stroke(iVec4 c) {
  if(c.w > 0) stroke(c.x, c.y, c.z, c.w); 
  else noStroke();
}



/**
text
*/
void text(String s, Vec pos) {
  if(pos instanceof Vec2 && s != null) {
    Vec2 p = (Vec2)pos;
    text(s, p.x, p.y);
  } else if(pos instanceof Vec3 && s != null) {
    Vec3 p = (Vec3)pos;
    text(s, p.x, p.x, p.z);
  } else {
    printErrTempo(60,"method text(): String message is null or Vec is not an instance of Vec3 or Vec2");
  }
}

void text(char c, Vec pos) {
  if(pos instanceof Vec2) {
    Vec2 p = (Vec2)pos;
    text(c, p.x, p.y);
  } else if(pos instanceof Vec3) {
    Vec3 p = (Vec3)pos;
    text(c, p.x, p.x, p.z);
  }
}

void text(int num, Vec pos) {
  if(pos instanceof Vec2) {
    Vec2 p = (Vec2)pos;
    text(num, p.x, p.y);
  } else if(pos instanceof Vec3) {
    Vec3 p = (Vec3)pos;
    text(num, p.x, p.x, p.z);
  } 
}

void text(float num, Vec pos) {
  if(pos instanceof Vec2) {
    Vec2 p = (Vec2) pos;
    text(num, p.x, p.y);
  } else if(pos instanceof Vec3) {
    Vec3 p = (Vec3) pos;
    text(num, p.x, p.x, p.z);
  } 
}

// iVec
void text(String s, iVec pos) {
  if(pos instanceof iVec2 && s != null) {
    Vec2 temp_pos = Vec2(pos.x, pos.y);
    text(s, temp_pos);
  } else if(pos instanceof iVec2) {
    Vec3 temp_pos = Vec3(pos.x,pos.y,pos.z);
    text(s, temp_pos);
  } else {
    printErrTempo(60,"method text(): String message is null or iVec is not an instance of iVec3 or iVec2");
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
Translate
*/
// Vec
void translate(Vec3 t) {
  if(renderer_P3D()) translate(t.x, t.y, t.z) ; else translate(t.x, t.y);
}

void translate(Vec2 t){
  translate(t.x, t.y);
}
// iVec
void translate(iVec3 t){
  if(renderer_P3D()) translate(t.x, t.y, t.z) ; else translate(t.x, t.y);
}

void translate(iVec2 t){
  translate(t.x, t.y);
}

void translateX(float t){
  translate(t, 0);
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
v 0.1.0
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
    printErr("Error in void start_matrix_3D(), Vec pos is not an instance of Vec2 or Vec3, the matrix don't translate your object") ;
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
    printErr("Error in void start_matrix_3D(), Vec pos is not an instance of Vec2 or Vec3, the matrix cannot be init") ;
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
    printErr("Error in void start_matrix_3D(), Vec pos is not an instance of Vec2 or Vec3, the matrix cannot be init") ;
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
  printErr("void matrix_3D_start() is deprecated instead use start_matrix_3D()") ;
}

void matrix_3D_start(Vec3 pos, Vec2 dir_polar) {
  pushMatrix() ;
  translate(pos) ;
  rotateXY(dir_polar) ;
  printErr("void matrix_3D_start() is deprecated instead use start_matrix_3D()") ;
}

void matrix_2D_start(Vec2 pos, float orientation) {
  pushMatrix() ;
  translate(pos) ;
  rotate(orientation) ;
  printErr("void matrix_2D_start() is deprecated instead use start_matrix_2D()") ;
}

void matrix_end() {
  popMatrix() ;
  printErr("void matrix_end() is deprecated instead use stop_matrix()") ;
}

void matrix_start() {
  pushMatrix() ;
  printErr("void matrix_start() is deprecated instead use start_matrix()") ;
}
