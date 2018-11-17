/**
ROPE METHOD
v 2.0.3
* Copyleft (c) 2014-2018
* Stan le Punk > http://stanlepunk.xyz/

* @author Stan le Punk
* @see https://github.com/StanLepunK/Rope
*/


/**
ADVANCED GHOST METHOD
v 1.0.0
All advanced ghost push Processing method further.
Processing and Vec, iVec and bVec method
the idea here is create method directly insprating from Processing to simplify the coder life
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
  rect(p.x,p.y,s.x,s.y);
}
void rect(Vec3 p, Vec2 s) {
  if(renderer_P3D()) {
    start_matrix();
    translate(p.x,p.y,p.z);
    rect(0,0,s.x,s.y);
    stop_matrix();
  } else rect(p.x,p.y,s.x,s.y);
}

void rect(iVec2 p, iVec2 s) {
  rect(p.x,p.y,s.x,s.y) ;
}

void rect(iVec3 p, iVec2 s) {
  Vec3 temp_pos = Vec3((int)p.x,(int)p.y,(int)p.z);
  Vec2 temp_size = Vec2((int)s.x,(int)s.y);
  rect(temp_pos,temp_size);
}




/**
Box
*/
void box(Vec3 p) {
  box(p.x,p.y,p.z);
}

void box(iVec3 p) {
  box(p.x,p.y,p.z);
}




/**
Point
*/
void point(Vec2 p) {
  point(p.x,p.y);
}
void point(Vec3 p) {
  if(renderer_P3D()) point(p.x,p.y,p.z); 
  else point(p.x,p.y) ;
}

void point(iVec2 p) {
  point(p.x,p.y);
}
void point(iVec3 p) {
  if(renderer_P3D()) point(p.x,p.y,p.z); 
  else point(p.x,p.y);
}




/**
Line
*/
void line(Vec2 a, Vec2 b){
  line(a.x,a.y,b.x,b.y);
}
void line(Vec3 a, Vec3 b){
  if(renderer_P3D()) line(a.x,a.y,a.z,b.x,b.y,b.z); 
  else line(a.x,a.y,b.x,b.y);
}

void line(iVec2 a, iVec2 b) {
  line(a.x,a.y,b.x,b.y);
}

void line(iVec3 a, iVec3 b) {
  if(renderer_P3D()) line(a.x,a.y,a.z,b.x,b.y,b.z); 
  else line(a.x,a.y,b.x,b.y);
}



/**
Vertex
v 0.0.2
*/
void vertex(Vec2 xy) {
  vertex(xy.x,xy.y);
}

void vertex(Vec3 xyz) {
  if(renderer_P3D()) vertex(xyz.x,xyz.y,xyz.z); 
  else vertex(xyz.x,xyz.y);
}
//
void vertex(iVec2 xy) {
  vertex(xy.x,xy.y);
}

void vertex(iVec3 xyz){
  if(renderer_P3D()) vertex(xyz.x,xyz.y,xyz.z); 
  else vertex(xyz.x,xyz.y);
}
//
void vertex(Vec2 xy, Vec2 uv) {
  vertex(xy.x,xy.y,uv.u,uv.v);
}

void vertex(iVec2 xy, Vec2 uv) {
  vertex(xy.x,xy.y,uv.u,uv.v);
}
//
void vertex(Vec3 xyz, Vec2 uv) {
  if(renderer_P3D()) vertex(xyz.x,xyz.y,xyz.z,uv.u,uv.v); 
  else vertex(xyz.x,xyz.y,uv.u,uv.v);
}

void vertex(iVec3 xyz, Vec2 uv) {
  if(renderer_P3D()) vertex(xyz.x,xyz.y,xyz.z,uv.u,uv.v); 
  else vertex(xyz.x,xyz.y,uv.u,uv.v);
}



/**
Bezier Vertex
*/
void bezierVertex(Vec2 a, Vec2 b, Vec2 c) {
  bezierVertex(a.x, a.y,b.x,b.y,c.x,c.y);
}

void bezierVertex(Vec3 a, Vec3 b, Vec3 c) {
  if(renderer_P3D()) bezierVertex(a.x,a.y,a.z,b.x,b.y,b.z,c.x,c.y,c.z); 
  else bezierVertex(a.x,a.y,b.x,b.y,c.x,c.y);
}

void bezierVertex(iVec2 a, iVec2 b, iVec2 c) {
  bezierVertex(a.x,a.y,b.x,b.y,c.x,c.y);
}

void bezierVertex(iVec3 a, iVec3 b, iVec3 c) {
  if(renderer_P3D()) bezierVertex(a.x,a.y,a.z,b.x,b.y,b.z,c.x,c.y,c.z); 
  else bezierVertex(a.x,a.y,b.x,b.y,c.x,c.y);
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
  if(a > 0) fill(c.r,c.g,c.b,a); 
  else noFill();
}

void fill(Vec4 c) {
  if(c.w > 0) fill(c.x,c.y,c.z,c.w); 
  else noFill();
}

// iVec
void fill(iVec2 c) {
  if(c.y > 0) fill(c.x,c.y); 
  else noFill();
}
void fill(iVec3 c) {
  fill(c.x,c.y,c.z);
}

void fill(iVec3 c, float a) {
  if(a > 0) fill(c.x,c.y,c.z,a);
  else noFill();
}

void fill(iVec4 c) {
  if(c.w > 0) fill(c.x,c.y,c.z,c.w); 
  else noFill();
}




/**
Stroke
*/
// Vec
void stroke(Vec2 c) {
  if(c.y > 0) stroke(c.x,c.y); 
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
  if(c.y > 0) stroke(c.x,c.y); 
  else noStroke();
}
void stroke(iVec3 c) {
  stroke(c.x, c.y, c.z);
}

void stroke(iVec3 c, float a) {
  if(a > 0) stroke(c.x,c.y,c.z,a); 
  else noStroke();
}

void stroke(iVec4 c) {
  if(c.w > 0) stroke(c.x,c.y,c.z,c.w); 
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
  if(renderer_P3D()) {
    translate(t.x,t.y,t.z); 
  } else {
    translate(t.x,t.y);
  }
}

void translate(Vec2 t){
  translate(round(t.x),round(t.y));
}

// iVec
void translate(iVec3 t){
  if(renderer_P3D()) {
    translate(t.x,t.y,t.z); 
  } else {
    translate(t.x,t.y);
  }
}

void translate(iVec2 t){
  translate(t.x,t.y);
}

void translateX(float t){
  translate(t,0);
}

void translateY(float t){
  translate(0,t);
}

void translateZ(float t){
  translate(0,0,t);
}


/**
Rotate
*/
// Vec
void rotateXY(Vec2 rot) {
  rotateX(rot.x);
  rotateY(rot.y);
}

void rotateXZ(Vec2 rot) {
  rotateX(rot.x);
  rotateZ(rot.y);
}

void rotateYZ(Vec2 rot) {
  rotateY(rot.x);
  rotateZ(rot.y);
}
void rotateXYZ(Vec3 rot) {
  rotateX(rot.x);
  rotateY(rot.y);
  rotateZ(rot.z);
}

// iVec
void rotateXY(iVec2 rot) {
  rotateX(rot.x);
  rotateY(rot.y);
}

void rotateXZ(iVec2 rot) {
  rotateX(rot.x);
  rotateZ(rot.y);
}

void rotateYZ(iVec2 rot) {
  rotateY(rot.x);
  rotateZ(rot.y);
}
void rotateXYZ(iVec3 rot) {
  rotateX(rot.x);
  rotateY(rot.y);
  rotateZ(rot.z);
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
  if (Float.isNaN(longitude)) longitude = 0;
  if (Float.isNaN(latitude)) latitude = 0;
  if (Float.isNaN(radius)) radius = 0;
  rotateX(latitude);
  rotateY(longitude);
}

void start_matrix_3D(Vec pos, Vec2 dir_polar) {
  if(pos instanceof Vec2) {
    Vec2 p = (Vec2) pos;
    pushMatrix();
    translate(p);
    rotateXY(dir_polar);
  } else if(pos instanceof Vec3) {
    Vec3 p = (Vec3) pos;
    pushMatrix();
    translate(p);
    rotateXY(dir_polar);
  } else {
    printErr("Error in void start_matrix_3D(), Vec pos is not an instance of Vec2 or Vec3, the matrix cannot be init") ;
    exit() ;
  }
}

void start_matrix_2D(Vec pos, float orientation) {
  if(pos instanceof Vec2) {
    Vec2 p = (Vec2)pos;
    pushMatrix();
    translate(p);
    rotate(orientation);
  } else if(pos instanceof Vec3) {
    Vec3 p = (Vec3)pos;
    pushMatrix();
    translate(p.x, p.y);
    rotate(orientation);
  } else {
    printErr("Error in void start_matrix_3D(), Vec pos is not an instance of Vec2 or Vec3, the matrix cannot be init") ;
    exit();
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
void start_matrix() {
  pushMatrix() ;
}


void stop_matrix() {
  popMatrix() ;
}




/**
Matrix deprecated
*/
@Deprecated
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

@Deprecated
void matrix_3D_start(Vec3 pos, Vec2 dir_polar) {
  pushMatrix() ;
  translate(pos) ;
  rotateXY(dir_polar) ;
  printErr("void matrix_3D_start() is deprecated instead use start_matrix_3D()") ;
}

@Deprecated
void matrix_2D_start(Vec2 pos, float orientation) {
  pushMatrix() ;
  translate(pos) ;
  rotate(orientation) ;
  printErr("void matrix_2D_start() is deprecated instead use start_matrix_2D()") ;
}

@Deprecated
void matrix_end() {
  popMatrix() ;
  printErr("void matrix_end() is deprecated instead use stop_matrix()") ;
}

@Deprecated
void matrix_start() {
  pushMatrix() ;
  printErr("void matrix_start() is deprecated instead use start_matrix()") ;
}





















































/**
GHOST METHODS for PROCESSING
2018-2018
v 0.1.2
*/
// colorMode
void colorMode(int mode) {
  if(get_layer() != null) {
    get_layer().colorMode(mode);
  } else {
    g.colorMode(mode);
  }
}

void colorMode(int mode, float max) {
  if(get_layer() != null) {
    get_layer().colorMode(mode,max);
  } else {
    g.colorMode(mode,max);
  } 
}


void colorMode(int mode, float max1, float max2, float max3) {
  if(get_layer() != null) {
    get_layer().colorMode(mode,max1,max2,max3);
  } else {
    g.colorMode(mode,max1,max2,max3);
  }
}
void colorMode(int mode, float max1, float max2, float max3, float maxA) {
  if(get_layer() != null) {
    get_layer().colorMode(mode,max1,max2,max3,maxA);
  } else {
    g.colorMode(mode,max1,max2,max3,maxA);
  }
}




// Processing ghost method

// position
void translate(float x, float y) {
  if(get_layer() != null) {
    get_layer().translate(x,y);
  } else {
    g.translate(x,y);
  }
}

void translate(float x, float y, float z) {
  if(get_layer() != null) {
    get_layer().translate(x,y,z);
  } else {
    g.translate(x,y,z);
  }
}


// rotate
void rotate(float arg) {
  if(get_layer() != null) {
    get_layer().rotate(arg);
  } else {
    g.rotate(arg);
  }
}


void rotateX(float arg) {
  if(get_layer() != null) {
    get_layer().rotateX(arg);
  } else {
    g.rotateX(arg);
  }
}

void rotateY(float arg) {
  if(get_layer() != null) {
    get_layer().rotateY(arg);
  } else {
    g.rotateY(arg);
  }
}


void rotateZ(float arg) {
  if(get_layer() != null) {
    get_layer().rotateZ(arg);
  } else {
    g.rotateZ(arg);
  }
}

// scale
void scale(float s) {
  if(get_layer() != null) {
    get_layer().scale(s);
  } else {
    g.scale(s);
  }
}

void scale(float x, float y) {
  if(get_layer() != null) {
    get_layer().scale(x,y);
  } else {
    g.scale(x,y);
  }
}

void scale(float x, float y, float z) {
  if(get_layer() != null) {
    get_layer().scale(x,y,z);
  } else {
    g.scale(x,y,z);
  }
}

// shear
void shearX(float angle) {
  if(get_layer() != null) {
    get_layer().shearX(angle);
  } else {
    g.shearX(angle);
  }
}

void shearY(float angle) {
  if(get_layer() != null) {
    get_layer().shearY(angle);
  } else {
    g.shearY(angle);
  }
}













/**
aspect
*/
// fill
void noFill() {
  if(get_layer() != null) {
    get_layer().noFill();
  } else {
    g.noFill();
  }
} 

void fill(int rgb) {
  if(get_layer() != null) {
    get_layer().fill(rgb);
  } else {
    g.fill(rgb);
  }
}


void fill(int rgb, float alpha) {
  if(get_layer() != null) {
    get_layer().fill(rgb,alpha);
  } else {
    g.fill(rgb,alpha);
  }
}

void fill(float gray) {
  if(get_layer() != null) {
    get_layer().fill(gray);
  } else {
    g.fill(gray);
  }
}


void fill(float gray, float alpha) {
  if(get_layer() != null) {
    get_layer().fill(gray,alpha);
  } else {
    g.fill(gray,alpha);
  }
}

void fill(float v1, float v2, float v3) {
  if(get_layer() != null) {
    get_layer().fill(v1,v2,v3);
  } else {
    g.fill(v1,v2,v3);
  }
}

void fill(float v1, float v2, float v3, float alpha) {
  if(get_layer() != null) {
    get_layer().fill(v1,v2,v3,alpha);
  } else {
    g.fill(v1,v2,v3,alpha);
  }
}

// stroke
void noStroke() {
  if(get_layer() != null) {
    get_layer().noStroke();
  } else {
    g.noStroke();
  }
} 

void stroke(int rgb) {
  if(get_layer() != null) {
    get_layer().stroke(rgb);
  } else {
    g.stroke(rgb);
  }
}


void stroke(int rgb, float alpha) {
  if(get_layer() != null) {
    get_layer().stroke(rgb,alpha);
  } else {
    g.stroke(rgb,alpha);
  }
}

void stroke(float gray) {
  if(get_layer() != null) {
    get_layer().stroke(gray);
  } else {
    g.stroke(gray);
  }
}


void stroke(float gray, float alpha) {
  if(get_layer() != null) {
    get_layer().stroke(gray,alpha);
  } else {
    g.stroke(gray,alpha);
  }
}

void stroke(float v1, float v2, float v3) {
  if(get_layer() != null) {
    get_layer().stroke(v1,v2,v3);
  } else {
    g.stroke(v1,v2,v3);
  }
}

void stroke(float v1, float v2, float v3, float alpha) {
  if(get_layer() != null) {
    get_layer().stroke(v1,v2,v3,alpha);
  } else {
    g.stroke(v1,v2,v3,alpha);
  }
}


// strokeWeight
void strokeWeight(float thickness) {
  if(get_layer() != null) {
    get_layer().strokeWeight(thickness);
  } else {
    g.strokeWeight(thickness);
  }
}

// strokeJoin
void strokeJoin(int join) {
  if(get_layer() != null) {
    get_layer().strokeJoin(join);
  } else {
    g.strokeJoin(join);
  }
}

// strokeJoin
void strokeCapstrokeCap(int cap) {
  if(get_layer() != null) {
    get_layer().strokeCap(cap);
  } else {
    g.strokeCap(cap);
  }
}












/**
shape
*/
// rect
void rect(float px, float py, float sx, float sy) {
  if(get_layer() != null) {
    get_layer().rect(px,py,sx,sy);
  } else {
    g.rect(px,py,sx,sy);
  }
}


void rect(float  px, float py, float sx, float sy, float r) {
  if(get_layer() != null) {
    get_layer().rect(px,py,sx,sy,r);
  } else {
    g.rect(px,py,sx,sy,r);
  }
}

void rect(float px, float py, float sx, float sy, float tl, float tr, float br, float bl) {
  if(get_layer() != null) {
    get_layer().rect(px,py,sx,sy,tl,tr,br,bl);
  } else {
    g.rect(px,py,sx,sy,tl,tr,br,bl);
  }
}


//arc
void arc(float a, float b, float c, float d, float start, float stop) {
  if(get_layer() != null) {
    get_layer().arc(a,b,c,d,start,stop);
  } else {
    g.arc(a,b,c,d,start,stop);
  }
}

void arc(float a, float b, float c, float d, float start, float stop, int mode) {
  if(get_layer() != null) {
    get_layer().arc(a,b,c,d,start,stop,mode);
  } else {
    g.arc(a,b,c,d,start,stop,mode);
  }
}

// ellipse
void ellipse(int px, int py, int sx, int sy) {
  if(get_layer() != null) {
    get_layer().ellipse(px,py,sx,sy);
  } else {
    g.ellipse(px,py,sx,sy);
  }
}




// box
void box(float s) {
  if(get_layer() != null) {
    get_layer().box(s,s,s);
  } else {
    g.box(s,s,s);
  }
}

void box(float w, float h, float d) {
  if(get_layer() != null) {
    get_layer().box(w,h,d);
  } else {
    g.box(w,h,d);
  }
}


// sphere
void sphere(float r) {
  if(get_layer() != null) {
    get_layer().sphere(r);
  } else {
    g.sphere(r);
    // p.sphere(r);
  }
}


// sphere detail
void sphereDetail(int res) {
  if(get_layer() != null) {
    get_layer().sphereDetail(res);
  } else {
    g.sphereDetail(res);
  }
}

void sphereDetail(int ures, int vres) {
  if(get_layer() != null) {
    get_layer().sphereDetail(ures,vres);
  } else {
    g.sphereDetail(ures,vres);
  }
}




//line
void line(float x1, float y1, float x2, float y2) {
  if(get_layer() != null) {
    get_layer().line(x1,y1,x2,y2);
  } else {
    g.line(x1,y1,x2,y2);
  }
}

void line(float x1, float y1, float z1, float x2, float y2, float z2) {
  if(get_layer() != null) {
    get_layer().line(x1,y1,z1,x2,y2,z2);
  } else {
    g.line(x1,y1,z1,x2,y2,z2);
  }
}






// point
void point(float x, float y) {
  if(get_layer() != null) {
    get_layer().point(x,y);
  } else {
    g.point(x,y);
  }
}

void point(float x, float y, float z) {
  if(get_layer() != null) {
    get_layer().point(x,y,z);
  } else {
    g.point(x,y,z);
  }
}

// quad
void quad(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  if(get_layer() != null) {
    get_layer().quad(x1,y1,x2,y2,x3,y3,x4,y4);
  } else {
    g.quad(x1,y1,x2,y2,x3,y3,x4,y4);
  }
}

// triangle
/*
method already use somewhere else
void triangle(float x1, float y1, float x2, float y2, float x3, float y3) {
  if(get_layer() != null) {
    get_layer().triangle(x1,y1,x2,y2,x3,y3);
  } else {
    g.triangle(x1,y1,x2,y2,x3,y3);
  }
}
*/


/**
vertex
*/
// begin
void beginShape() {
  if(get_layer() != null) {
    get_layer().beginShape();
  } else {
    g.beginShape();
  }
}

void beginShape(int kind) {
  if(get_layer() != null) {
    get_layer().beginShape(kind);
  } else {
    g.beginShape(kind);
  }
}


void endShape() {
  if(get_layer() != null) {
    get_layer().endShape();
  } else {
    g.endShape();
  }
}

void endShape(int mode) {
  if(get_layer() != null) {
    get_layer().endShape(mode);
  } else {
    g.endShape(mode);
  }
}

// shape
void shape(PShape shape) {
  if(get_layer() != null) {
    get_layer().shape(shape);
  } else {
    g.shape(shape);
  }
}

void shape(PShape shape, float x, float y) {
  if(get_layer() != null) {
    get_layer().shape(shape,x,y);
  } else {
    g.shape(shape,x,y);
  }
}

void shape(PShape shape, float a, float b, float c, float d) {
  if(get_layer() != null) {
    get_layer().shape(shape,a,b,c,d);
  } else {
    g.shape(shape,a,b,c,d);
  }
}




//vertex
void vertex(float x, float y) {
  if(get_layer() != null) {
    get_layer().vertex(x,y);
  } else {
    g.vertex(x,y);
  }
}

void vertex(float x, float y, float z) {
  if(get_layer() != null) {
    get_layer().vertex(x,y,z);
  } else {
    g.vertex(x,y,z);
  }
}

void vertex(float [] v) {
  if(get_layer() != null) {
    get_layer().vertex(v);
  } else {
    g.vertex(v);
  }
}

void vertex(float x, float y, float u, float v) {
  if(get_layer() != null) {
    get_layer().vertex(x,y,u,v);
  } else {
    g.vertex(x,y,u,v);
  }
} 


void vertex(float x, float y, float z, float u, float v) {
  if(get_layer() != null) {
    get_layer().vertex(x,y,z,u,v);
  } else {
    g.vertex(x,y,z,u,v);
  }
}  


// quadratic vertex
void quadraticVertex(float cx, float cy, float x3, float y3) {
  if(get_layer() != null) {
    get_layer().quadraticVertex(cx,cy,x3,y3);
  } else {
    g.quadraticVertex(cx,cy,x3,y3);
  }
}

void quadraticVertex(float cx, float cy, float cz, float x3, float y3, float z3) {
  if(get_layer() != null) {
    get_layer().quadraticVertex(cx,cy,cz,x3,y3,z3);
  } else {
    g.quadraticVertex(cx,cy,cz,x3,y3,z3);
  }
}

// curve vertex
void curveVertex(float x, float y) {
  if(get_layer() != null) {
    get_layer().curveVertex(x,y);
  } else {
    g.curveVertex(x,y);
  }
}

void curveVertex(float x, float y, float z) {
  if(get_layer() != null) {
    get_layer().curveVertex(x,y,z);
  } else {
    g.curveVertex(x,y,z);
  }
}


//bezier vertex
void bezierVertex(float x2, float y2, float x3, float y3, float x4, float y4) {
  if(get_layer() != null) {
    get_layer().bezierVertex(x2,y2,x3,y3,x4,y4);
  } else {
    g.bezierVertex(x2,y2,x3,y3,x4,y4);
  }
}


void bezierVertex(float x2, float y2, float z2, float x3, float y3, float z3, float x4, float y4, float z4) {
  if(get_layer() != null) {
    get_layer().bezierVertex(x2,y2,z2,x3,y3,z3,x4,y4,z4);
  } else {
    g.bezierVertex(x2,y2,z2,x3,y3,z3,x4,y4,z4);
  }
}

// bezier
void bezier(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  if(get_layer() != null) {
    get_layer().bezier(x1,y1,x2,y2,x3,y3,x4,y4);
  } else {
    g.bezier(x1,y1,x2,y2,x3,y3,x4,y4);
  }
}

void bezier(float x1, float y1, float z1, float x2, float y2, float z2, float x3, float y3, float z3, float x4, float y4, float z4) {
  if(get_layer() != null) {
    get_layer().bezier(x1,y1,z1,x2,y2,z2,x3,y3,z3,x4,y4,z4);
  } else {
    g.bezier(x1,y1,z1,x2,y2,z2,x3,y3,z3,x4,y4,z4);
  }
}

// bezier detail
void bezierDetail(int detail) {
  if(get_layer() != null) {
    get_layer().bezierDetail(detail);
  } else {
    g.bezierDetail(detail);
  }
}

// curve
void curve(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  if(get_layer() != null) {
    get_layer().curve(x1,y1,x2,y2,x3,y3,x4,y4);
  } else {
    g.curve(x1,y1,x2,y2,x3,y3,x4,y4);
  }
}


void curve(float x1, float y1, float z1, float x2, float y2, float z2, float x3, float y3, float z3, float x4, float y4, float z4) {
  if(get_layer() != null) {
    get_layer().curve(x1,y1,z1,x2,y2,z2,x3,y3,z3,x4,y4,z4);
  } else {
    g.curve(x1,y1,z1,x2,y2,z2,x3,y3,z3,x4,y4,z4);
  }
}

// curve detail
void curveDetail(int detail) {
  if(get_layer() != null) {
    get_layer().curveDetail(detail);
  } else {
    g.curveDetail(detail);
  }
}




















// light
void lights() {
  if(get_layer() != null) {
    get_layer().lights();
  } else {
    g.lights();
  }
}

void noLights() {
  if(get_layer() != null) {
    get_layer().noLights();
  } else {
    g.noLights();
  }
}

// ambient light
void ambientLight(float v1, float v2, float v3) {
  if(get_layer() != null) {
    get_layer().ambientLight(v1,v2,v3);
  } else {
    g.ambientLight(v1,v2,v3);
  }
}


void ambientLight(float v1, float v2, float v3, float x, float y, float z) {
  if(get_layer() != null) {
    get_layer().ambientLight(v1,v2,v3,x,y,z);
  } else {
    g.ambientLight(v1,v2,v3,x,y,z);
  }
}


//directionalLight(v1, v2, v3, nx, ny, nz)
void directionalLight(float v1, float v2, float v3, float nx, float ny, float nz) {
  if(get_layer() != null) {
    get_layer().directionalLight(v1,v2,v3,nx,ny,nz);
  } else {
    g.directionalLight(v1,v2,v3,nx,ny,nz);
  }
}



// lightFalloff(constant, linear, quadratic)
void lightFalloff(float constant, float linear, float quadratic) {
  if(get_layer() != null) {
    get_layer().lightFalloff(constant,linear,quadratic);
  } else {
    g.lightFalloff(constant,linear,quadratic);
  }
}


// lightSpecular(v1, v2, v3) 

void lightSpecular(float v1, float v2, float v3) {
  if(get_layer() != null) {
    get_layer().lightSpecular(v1,v2,v3);
  } else {
    g.lightSpecular(v1,v2,v3);
  }
}

// normal(nx, ny, nz)
void normal(float nx, float ny, float nz) {
  if(get_layer() != null) {
    get_layer().normal(nx,ny,nz);
  } else {
    g.normal(nx,ny,nz);
  }
}


// pointLight(v1, v2, v3, x, y, z)
void pointLight(float v1, float v2, float v3, float x, float y, float z) {
  if(get_layer() != null) {
    get_layer().pointLight(v1,v2,v3,x,y,z);
  } else {
    g.pointLight(v1,v2,v3,x,y,z);
  }
}

// spotLight(v1, v2, v3, x, y, z, nx, ny, nz, angle, concentration)
void spotLight(float v1, float v2, float v3, float x, float y, float z, float nx, float ny, float nz, float angle, float concentration) {
  if(get_layer() != null) {
    get_layer().spotLight(v1,v2,v3,x,y,z,nx,ny,nz,angle,concentration);
  } else {
    g.spotLight(v1,v2,v3,x,y,z,nx,ny,nz,angle,concentration);
  }
}


/**
Material properties
*/
void ambient(int rgb) {
  if(get_layer() != null) {
    get_layer().ambient(rgb);
  } else {
    g.ambient(rgb);
  }
}

void ambient(float gray) {
  if(get_layer() != null) {
    get_layer().ambient(gray);
  } else {
    g.ambient(gray);
  }
}


void ambient(float v1, float v2, float v3) {
  if(get_layer() != null) {
    get_layer().ambient(v1,v2,v3);
  } else {
    g.ambient(v1,v2,v3);
  }
}


// emissive
void emissive(int rgb) {
  if(get_layer() != null) {
    get_layer().emissive(rgb);
  } else {
    g.emissive(rgb);
  }
}

void emissive(float gray) {
  if(get_layer() != null) {
    get_layer().emissive(gray);
  } else {
    g.emissive(gray);
  }
}


void emissive(float v1, float v2, float v3) {
  if(get_layer() != null) {
    get_layer().emissive(v1,v2,v3);
  } else {
    g.emissive(v1,v2,v3);
  }
}


// specular
void specular(int rgb) {
  if(get_layer() != null) {
    get_layer().specular(rgb);
  } else {
    g.specular(rgb);
  }
}

void specular(float gray) {
  if(get_layer() != null) {
    get_layer().specular(gray);
  } else {
    g.specular(gray);
  }
}


void specular(float v1, float v2, float v3) {
  if(get_layer() != null) {
    get_layer().specular(v1,v2,v3);
  } else {
    g.specular(v1,v2,v3);
  }
}


// shininess(shine)
void shininess(float shine) {
  if(get_layer() != null) {
    get_layer().shininess(shine);
  } else {
    g.shininess(shine);
  }
}























/**
camera ghost
*/
// camera
void camera() {
  if(get_layer() != null) {
    get_layer().camera();
  } else {
    g.camera();
  }
}

void camera(float eyeX, float eyeY, float eyeZ, float centerX, float centerY, float centerZ, float upX, float upY, float upZ) {
  if(get_layer() != null) {
    get_layer().camera(eyeX,eyeY,eyeZ,centerX,centerY,centerZ,upX,upY,upZ);
  } else {
    g.camera(eyeX,eyeY,eyeZ,centerX,centerY,centerZ,upX,upY,upZ);
  }
}


void beginCamera() {
  if(get_layer() != null) {
    get_layer().beginCamera();
  } else {
    g.beginCamera();
  }
}

void endCamera() {
  if(get_layer() != null) {
    get_layer().endCamera();
  } else {
    g.endCamera();
  }
}


// frustum(left, right, bottom, top, near, far)
void frustum(float left, float right, float bottom, float top, float near, float far) {
  if(get_layer() != null) {
    get_layer().frustum(left,right,bottom,top,near,far);
  } else {
    g.frustum(left,right,bottom,top,near,far);
  }
}


// ortho
void ortho() {
  if(get_layer() != null) {
    get_layer().ortho();
  } else {
    g.ortho();
  }
}

void ortho(float left, float right, float bottom, float top) {
  if(get_layer() != null) {
    get_layer().ortho(left,right,bottom,top);
  } else {
    g.ortho(left,right,bottom,top);
  }
}


void ortho(float left, float right, float bottom, float top, float near, float far) {
  if(get_layer() != null) {
    get_layer().ortho(left,right,bottom,top,near,far);
  } else {
    g.ortho(left,right,bottom,top,near,far);
  }
}


  
// perspective
void perspective() {
  if(get_layer() != null) {
    get_layer().perspective();
  } else {
    g.perspective();
  }
}


void perspective(float fovy, float aspect, float zNear, float zFar) {
  if(get_layer() != null) {
    get_layer().perspective(fovy,aspect,zNear,zFar);
  } else {
    g.perspective(fovy,aspect,zNear,zFar);
  }
}


















/**
matrix
*/
void pushMatrix() {
  if(get_layer() != null) {
    get_layer().pushMatrix();
  } else {
    g.pushMatrix();
  }
}


void popMatrix() {
  if(get_layer() != null) {
    get_layer().popMatrix();
  } else {
    g.popMatrix();
  }
}


// apply matrix
void applyMatrix(PMatrix source) {
  if(get_layer() != null) {
    get_layer().applyMatrix(source);
  } else {
    g.applyMatrix(source);
  }
}

void applyMatrix(float n00, float n01, float n02, float n10, float n11, float n12) {
  if(get_layer() != null) {
    get_layer().applyMatrix(n00,n01,n02,n10,n11,n12);
  } else {
    g.applyMatrix(n00,n01,n02,n10,n11,n12);
  }
}

void applyMatrix(float n00, float n01, float n02, float n03, float n10, float n11, float n12, float n13, float n20, float n21, float n22, float n23, float n30, float n31, float n32, float n33) {
  if(get_layer() != null) {
    get_layer().applyMatrix(n00,n01,n02,n03,n10,n11,n12,n13,n20,n21,n22,n23,n30,n31,n32,n33);
  } else {
    g.applyMatrix(n00,n01,n02,n03,n10,n11,n12,n13,n20,n21,n22,n23,n30,n31,n32,n33);
  }
}



void resetMatrix() {
  if(get_layer() != null) {
    get_layer().resetMatrix();
  } else {
    g.resetMatrix();
  }
}


  












/**
image
*/
void image(PImage img, float x, float y) {
  if(get_layer() != null) {
    get_layer().image(img,x,y);
  } else {
    g.image(img,x,y);
  }
}

void image(PImage img, float a, float b, float c, float d) {
  if(get_layer() != null) {
    get_layer().image(img,a,b,c,d);
  } else {
    g.image(img,a,b,c,d);
  }
}














/**
get
*/
int get(int x, int y) {
  if(get_layer() != null) {
    return get_layer().get(x,y);
  } else {
    return g.get(x,y);
  }
} 


PImage get(int x, int y, int w, int h) {
  if(get_layer() != null) {
    return get_layer().get(x,y,w,h);
  } else {
    return g.get(x,y,w,h);
  }
}


PImage get() {
  if(get_layer() != null) {
    return get_layer().get();
  } else {
    return g.get();
  }
}









/**
loadPixels()
*/
void loadPixels() {
  if(get_layer() != null) {
    get_layer().loadPixels();
  } else {
    g.loadPixels();
  }
}


/**
updatePixels()
*/
void updatePixels() {
  if(get_layer() != null) {
    get_layer().updatePixels();
  } else {
    g.updatePixels();
  }
}








/**
tint
*/
void tint(int rgb) {
  if(get_layer() != null) {
    get_layer().tint(rgb);
  } else {
    g.tint(rgb);
  }
}

void tint(int rgb, float alpha) {
  if(get_layer() != null) {
    get_layer().tint(rgb,alpha);
  } else {
    g.tint(rgb,alpha);
  }
}

void tint(float gray) {
  if(get_layer() != null) {
    get_layer().tint(gray);
  } else {
    g.tint(gray);
  }
}

void tint(float gray, float alpha) {
  if(get_layer() != null) {
    get_layer().tint(gray,alpha);
  } else {
    g.tint(gray,alpha);
  }
}

void tint(float v1, float v2, float v3) {
  if(get_layer() != null) {
    get_layer().tint(v1,v2,v3);
  } else {
    g.tint(v1,v2,v3);
  }
}

void tint(float v1, float v2, float v3, float alpha) {
  if(get_layer() != null) {
    get_layer().tint(v1,v2,v3,alpha);
  } else {
    g.tint(v1,v2,v3,alpha);
  }
}















/**
blend
*/
void blend(int sx, int sy, int sw, int sh, int dx, int dy, int dw, int dh, int mode) {
  if(get_layer() != null) {
    get_layer().blend(sx,sy,sw,sh,dx,dy,dw,dh,mode);
  } else {
    g.blend(sx,sy,sw,sh,dx,dy,dw,dh,mode);
  }
}


void blend(PImage src, int sx, int sy, int sw, int sh, int dx, int dy, int dw, int dh, int mode) {
  if(get_layer() != null) {
    get_layer().blend(src,sx,sy,sw,sh,dx,dy,dw,dh,mode);
  } else {
    g.blend(src,sx,sy,sw,sh,dx,dy,dw,dh,mode);
  }
}













/**
filter
*/
void filter(PShader shader) {
  if(get_layer() != null) {
    get_layer().filter(shader);
  } else {
    g.filter(shader);
  }
}

void filter(int kind) {
  if(get_layer() != null) {
    get_layer().filter(kind);
  } else {
    g.filter(kind);
  }
}

void filter(int kind, float param) {
  if(get_layer() != null) {
    get_layer().filter(kind,param);
  } else {
    g.filter(kind,param);
  }
}













/**
set
*/
void set(int x, int y, int c) {
  if(get_layer() != null) {
    get_layer().set(x,y,c);
  } else {
    /*
    x *= displayDensity();
    y *= displayDensity();
    */
    g.set(x,y,c);
  }
}

void set(int x, int y, PImage img) {
  if(get_layer() != null) {
    get_layer().set(x,y,img);
  } else {
    /*
    x *= displayDensity();
    y *= displayDensity();
    */
    g.set(x,y,img);
  }
}














/**
text
*/
void text(char c, float x, float y) {
  if(get_layer() != null) {
    get_layer().text(c,x,y);
  } else {
    g.text(c,x,y);
  }
}


void text(char c, float x, float y, float z) {
  if(get_layer() != null) {
    get_layer().text(c,x,y,z);
  } else {
    g.text(c,x,y,z);
  }
}

void text(char [] chars, int start, int stop, float x, float y) {
  if(get_layer() != null) {
    get_layer().text(chars,start,stop,x,y);
  } else {
    g.text(chars,start,stop,x,y);
  }
}


void text(char [] chars, int start, int stop, float x, float y, float z) {
  if(get_layer() != null) {
    get_layer().text(chars,start,stop,x,y,z);
  } else {
    g.text(chars,start,stop,x,y,z);
  }
}



void text(String str, float x, float y) {
  if(get_layer() != null) {
    get_layer().text(str,x,y);
  } else {
    g.text(str,x,y);
  }
}


void text(String str, float x, float y, float z) {
  if(get_layer() != null) {
    get_layer().text(str,x,y,z);
  } else {
    g.text(str,x,y,z);
  }
}


void text(String str, float x1, float y1, float x2, float y2) {
  if(get_layer() != null) {
    get_layer().text(str,x1,y1,x2,y2);
  } else {
    g.text(str,x1,y1,x2,y2);
  }
}

void text(float num, float x, float y) {
  if(get_layer() != null) {
    get_layer().text(num,x,y);
  } else {
    g.text(num,x,y);
  }
}


void text(float num, float x, float y, float z) {
  if(get_layer() != null) {
    get_layer().text(num,x,y,z);
  } else {
    g.text(num,x,y,z);
  }
}


void text(int num, float x, float y) {
  if(get_layer() != null) {
    get_layer().text(num,x,y);
  } else {
    g.text(num,x,y);
  }
}


void text(int num, float x, float y, float z) {
  if(get_layer() != null) {
    get_layer().text(num,x,y,z);
  } else {
    g.text(num,x,y,z);
  }
}


// text Align
void textAlign(int alignX) {
  if(get_layer() != null) {
    get_layer().textAlign(alignX);
  } else {
    g.textAlign(alignX);
  }
}


void textAlign(int alignX, int alignY) {
  if(get_layer() != null) {
    get_layer().textAlign(alignX,alignY);
  } else {
    g.textAlign(alignX,alignY);
  }
}

// textLeading(leading)
void textLeading(float leading) {
if(get_layer() != null) {
    get_layer().textLeading(leading);
  } else {
    g.textLeading(leading);
  }
}


// textMode(mode)
void textMode(int mode) {
  if(get_layer() != null) {
    get_layer().textMode(mode);
  } else {
    g.textMode(mode);
  }
}

// text Size
void textSize(float size) {
  if(get_layer() != null) {
    get_layer().textSize(size);
  } else {
    g.textSize(size);
  }
}


// textFont
void textFont(PFont which) {
  if(get_layer() != null) {
    get_layer().textFont(which);
  } else {
    g.textFont(which);
  }
}

void textFont(PFont which, float size) {
  if(get_layer() != null) {
    get_layer().textFont(which,size);
  } else {
    g.textFont(which,size);
  }
}






  




