/**
ROPE PROCESSING METHOD
v 2.4.3
* Copyleft (c) 2014-2019
* Stan le Punk > http://stanlepunk.xyz/
* @author @stanlepunk
* @see https://github.com/StanLepunK/Rope_framework
* Processing 3.5.3
*/


/**
ADVANCED GHOST METHOD
v 1.0.1
All advanced ghost push Processing method further.
Processing and vec, ivec and bvec method
the idea here is create method directly insprating from Processing to simplify the coder life
*/

/**
* colorMode(vec5 color_component)
* @param component give in order : mode, x, y, z and alpha
*/
void colorMode(vec5 component) {
  int mode = (int)component.w;
  if(mode == HSB) {
    colorMode(HSB,component.b(),component.c(),component.d(),component.e());
  } else if(mode == RGB) {
    colorMode(RGB,component.b(),component.c(),component.d(),component.e());
  } else {
    printErr("The first component of your vec is", mode, "and don't match with any Processing colorMode, instead the current colorMode will be used");
  }
}
/**
* colorMode(int mode, vec4 color_component)
* @param mode give environment HSB or RGB
* @param color_component give in order : x, y, z and alpha
*/
void colorMode(int mode, vec4 component) {
  if(mode == HSB) {
    colorMode(HSB,component.x,component.y,component.z,component.w);
  } else if(mode == RGB) {
    colorMode(RGB,component.x,component.y,component.z,component.w);
  } else {
    printErr("int mode", mode, "don't match with any Processing colorMode, instead the current colorMode will be used");
  }
}
/**
* colorMode(int mode, vec3 color_component)
* @param mode give environment HSB or RGB
* @param color_component give in order : x, y, z
*/
void colorMode(int mode, vec3 component) {
  colorMode(mode, vec4(component.x,component.y,component.z,g.colorModeA));
}
/**
* colorMode(int mode, vec2 color_component)
* @param mode give environment HSB or RGB
* @param color_component give in order the x give x,y,z and y give the alpha
*/
void colorMode(int mode, vec2 component) {
   colorMode(mode, vec4(component.x,component.x,component.x,component.y));
}







/**
floor
*/
vec2 floor(vec2 arg) {
  return vec2(floor(arg.x),floor(arg.y));
}

vec3 floor(vec3 arg) {
  return vec3(floor(arg.x),floor(arg.y),floor(arg.z));
}

vec4 floor(vec4 arg) {
  return vec4(floor(arg.x),floor(arg.y),floor(arg.z),floor(arg.w));
}






/**
round
*/
vec2 round(vec2 arg) {
  return vec2(round(arg.x),round(arg.y));
}

vec3 round(vec3 arg) {
  return vec3(round(arg.x),round(arg.y),round(arg.z));
}

vec4 round(vec4 arg) {
  return vec4(round(arg.x),round(arg.y),round(arg.z),round(arg.w));
}





/**
ceil
*/
vec2 ceil(vec2 arg) {
  return vec2(ceil(arg.x),ceil(arg.y));
}

vec3 ceil(vec3 arg) {
  return vec3(ceil(arg.x),ceil(arg.y),ceil(arg.z));
}

vec4 ceil(vec4 arg) {
  return vec4(ceil(arg.x),ceil(arg.y),ceil(arg.z),ceil(arg.w));
}


/**
abs
*/
vec2 abs(vec2 arg) {
  return vec2(abs(arg.x),abs(arg.y));
}

vec3 abs(vec3 arg) {
  return vec3(abs(arg.x),abs(arg.y),abs(arg.z));
}

vec4 abs(vec4 arg) {
  return vec4(abs(arg.x),abs(arg.y),abs(arg.z),abs(arg.w));
}

ivec2 abs(ivec2 arg) {
  return ivec2(abs(arg.x),abs(arg.y));
}

ivec3 abs(ivec3 arg) {
  return ivec3(abs(arg.x),abs(arg.y),abs(arg.z));
}

ivec4 abs(ivec4 arg) {
  return ivec4(abs(arg.x),abs(arg.y),abs(arg.z),abs(arg.w));
}



/**
max
*/
vec2 max(vec2 a, vec2 b) {
  return vec2(max(a.x,b.x),max(a.y,b.y));
}

vec3 max(vec3 a, vec3 b) {
  return vec3(max(a.x,b.x),max(a.y,b.y),max(a.z,b.z));
}

vec4 max(vec4 a, vec4 b) {
  return vec4(max(a.x,b.x),max(a.y,b.y),max(a.z,b.z),max(a.w,b.w));
}

ivec2 max(ivec2 a, ivec2 b) {
  return ivec2(max(a.x,b.x),max(a.y,b.y));
}

ivec3 max(ivec3 a, ivec3 b) {
  return ivec3(max(a.x,b.x),max(a.y,b.y),max(a.z,b.z));
}

ivec4 max(ivec4 a, ivec4 b) {
  return ivec4(max(a.x,b.x),max(a.y,b.y),max(a.z,b.z),max(a.w,b.w));
}



/**
min
*/
vec2 min(vec2 a, vec2 b) {
  return vec2(min(a.x,b.x),min(a.y,b.y));
}

vec3 min(vec3 a, vec3 b) {
  return vec3(min(a.x,b.x),min(a.y,b.y),min(a.z,b.z));
}

vec4 min(vec4 a, vec4 b) {
  return vec4(min(a.x,b.x),min(a.y,b.y),min(a.z,b.z),min(a.w,b.w));
}

ivec2 min(ivec2 a, ivec2 b) {
  return ivec2(min(a.x,b.x),min(a.y,b.y));
}

ivec3 min(ivec3 a, ivec3 b) {
  return ivec3(min(a.x,b.x),min(a.y,b.y),min(a.z,b.z));
}

ivec4 min(ivec4 a, ivec4 b) {
  return ivec4(min(a.x,b.x),min(a.y,b.y),min(a.z,b.z),min(a.w,b.w));
}





/**
set
*/
void set(ivec2 pos, int c) {
  set(pos.x, pos.y, c);
}

void set(vec2 pos, int c) {
  set((int)pos.x, (int)pos.y, c);
}



/**
random
*/
float random (vec2 v) {
  return random(v.x, v.y);
}

float random (ivec2 v) {
  return random(v.x, v.y);
}




/**
Ellipse
v 0.1.1
*/
// with vec2 or ivec2
void ellipse(vec2 p, vec s) {
  ellipse(p.x,p.y, s.x,s.y);
}

void ellipse(vec2 p, float x, float y) {
  ellipse(p.x,p.y,x,y);
}

void ellipse(vec2 p, float x) {
  ellipse(p.x,p.y,x,x);
}


// ivec
void ellipse(ivec2 p, ivec s) {
  ellipse(p.x,p.y,s.x,s.y) ;
}

void ellipse(ivec2 p, int x, int y) {
  ellipse(p.x,p.y, x,y);
}

void ellipse(ivec2 p, int x) {
  ellipse(p.x,p.y,x,x);
}

// with vec3 or ivec3
void ellipse(ivec3 p, int x, int y) {
  ellipse(p,ivec2(x,y));
}

void ellipse(ivec3 p, int x) {
  ellipse(p,ivec2(x));
}

void ellipse(ivec3 p, ivec s) {
  vec3 temp_pos = vec3((int)p.x, (int)p.y, (int)p.z);
  vec2 temp_size = vec2((int)s.x,(int)s.y);
  ellipse(temp_pos, temp_size);
}


void ellipse(vec3 p, float x, float y) {
  ellipse(p,vec2(x,y));
}

void ellipse(vec3 p, float x) {
  ellipse(p,vec2(x));
}

/**
main method
*/
void ellipse(vec3 p, vec s) {
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
void rect(vec2 p, vec2 s) {
  rect(p.x,p.y,s.x,s.y);
}
void rect(vec3 p, vec2 s) {
  if(renderer_P3D()) {
    start_matrix();
    translate(p.x,p.y,p.z);
    rect(0,0,s.x,s.y);
    stop_matrix();
  } else rect(p.x,p.y,s.x,s.y);
}

void rect(ivec2 p, ivec2 s) {
  rect(p.x,p.y,s.x,s.y) ;
}

void rect(ivec3 p, ivec2 s) {
  vec3 temp_pos = vec3((int)p.x,(int)p.y,(int)p.z);
  vec2 temp_size = vec2((int)s.x,(int)s.y);
  rect(temp_pos,temp_size);
}


/**
Triangle
*/
void triangle(ivec a, ivec b, ivec2 c) {
  triangle(vec3(a.x,a.y,a.z),vec3(b.x,b.y,b.z),vec3(c.x,c.y,c.z));
}

void triangle(vec a, vec b, vec c) {
  if(a.z == 0 && b.z == 0 && c.z == 0) {
    triangle(a.x,a.y,b.x,b.y,c.x,c.y);
  } else {
    if(renderer_P3D()) {
      beginShape();
      vertex(a.x,a.y,a.z);
      vertex(b.x,b.y,b.z);
      vertex(c.x,c.y,c.z);
      endShape(CLOSE);
    } else {

      triangle(a.x,a.y,b.x,b.y,c.x,c.y);
    }
  }
}




/**
Box
*/
void box(vec3 p) {
  box(p.x,p.y,p.z);
}

void box(ivec3 p) {
  box(p.x,p.y,p.z);
}




/**
Point
*/
void point(vec2 p) {
  point(p.x,p.y);
}
void point(vec3 p) {
  if(renderer_P3D()) point(p.x,p.y,p.z); 
  else point(p.x,p.y) ;
}

void point(ivec2 p) {
  point(p.x,p.y);
}
void point(ivec3 p) {
  if(renderer_P3D()) point(p.x,p.y,p.z); 
  else point(p.x,p.y);
}




/**
Line
*/
void line(vec2 a, vec2 b){
  line(a.x,a.y,b.x,b.y);
}
void line(vec3 a, vec3 b){
  if(renderer_P3D()) line(a.x,a.y,a.z,b.x,b.y,b.z); 
  else line(a.x,a.y,b.x,b.y);
}

void line(ivec2 a, ivec2 b) {
  line(a.x,a.y,b.x,b.y);
}

void line(ivec3 a, ivec3 b) {
  if(renderer_P3D()) line(a.x,a.y,a.z,b.x,b.y,b.z); 
  else line(a.x,a.y,b.x,b.y);
}



/**
Vertex
v 0.0.2
*/
void vertex(vec2 xy) {
  vertex(xy.x,xy.y);
}

void vertex(vec3 xyz) {
  if(renderer_P3D()) vertex(xyz.x,xyz.y,xyz.z); 
  else vertex(xyz.x,xyz.y);
}
//
void vertex(ivec2 xy) {
  vertex(xy.x,xy.y);
}

void vertex(ivec3 xyz){
  if(renderer_P3D()) vertex(xyz.x,xyz.y,xyz.z); 
  else vertex(xyz.x,xyz.y);
}
//
void vertex(vec2 xy, vec2 uv) {
  vertex(xy.x,xy.y,uv.u,uv.v);
}

void vertex(ivec2 xy, vec2 uv) {
  vertex(xy.x,xy.y,uv.u,uv.v);
}
//
void vertex(vec3 xyz, vec2 uv) {
  if(renderer_P3D()) vertex(xyz.x,xyz.y,xyz.z,uv.u,uv.v); 
  else vertex(xyz.x,xyz.y,uv.u,uv.v);
}

void vertex(ivec3 xyz, vec2 uv) {
  if(renderer_P3D()) vertex(xyz.x,xyz.y,xyz.z,uv.u,uv.v); 
  else vertex(xyz.x,xyz.y,uv.u,uv.v);
}



/**
Bezier Vertex
*/
void bezierVertex(vec2 a, vec2 b, vec2 c) {
  bezierVertex(a.x, a.y,b.x,b.y,c.x,c.y);
}

void bezierVertex(vec3 a, vec3 b, vec3 c) {
  if(renderer_P3D()) bezierVertex(a.x,a.y,a.z,b.x,b.y,b.z,c.x,c.y,c.z); 
  else bezierVertex(a.x,a.y,b.x,b.y,c.x,c.y);
}

void bezierVertex(ivec2 a, ivec2 b, ivec2 c) {
  bezierVertex(a.x,a.y,b.x,b.y,c.x,c.y);
}

void bezierVertex(ivec3 a, ivec3 b, ivec3 c) {
  if(renderer_P3D()) bezierVertex(a.x,a.y,a.z,b.x,b.y,b.z,c.x,c.y,c.z); 
  else bezierVertex(a.x,a.y,b.x,b.y,c.x,c.y);
}





/**
Quadratic Vertex
*/
void quadraticVertex(vec2 a, vec2 b) {
  quadraticVertex(a.x, a.y, b.x, b.y);
}

void quadraticVertex(vec3 a, vec3 b) {
  if(renderer_P3D()) quadraticVertex(a.x, a.y, a.z, b.x, b.y, b.z); 
  else quadraticVertex(a.x, a.y, b.x, b.y) ;
}

void quadraticVertex(ivec2 a, ivec2 b) {
  quadraticVertex(a.x, a.y, b.x, b.y);
}

void quadraticVertex(ivec3 a, ivec3 b) {
  if(renderer_P3D()) quadraticVertex(a.x, a.y, a.z, b.x, b.y, b.z); 
  else quadraticVertex(a.x, a.y, b.x, b.y);
}




/**
Curve Vertex
*/
void curveVertex(vec2 a) {
  curveVertex(a.x, a.y);
}
void curveVertex(vec3 a){
  if(renderer_P3D()) curveVertex(a.x, a.y, a.z) ; 
  else curveVertex(a.x, a.y);
}

void curveVertex(ivec2 a) {
  curveVertex(a.x, a.y);
}
void curveVertex(ivec3 a){
  if(renderer_P3D()) curveVertex(a.x, a.y, a.z) ; 
  else curveVertex(a.x, a.y);
}





/**
Fill
*/
// vec
void fill(vec2 c) {
  if( c.y > 0) fill(c.x, c.y); 
  else noFill();
}
void fill(vec3 c) {
  fill(c.x,c.y,c.z) ;
}

void fill(vec3 c, float a) {
  if(a > 0) fill(c.x,c.y,c.z,a); 
  else noFill();
}

void fill(vec4 c) {
  if(c.w > 0) fill(c.x,c.y,c.z,c.w); 
  else noFill();
}

// ivec
void fill(ivec2 c) {
  if(c.y > 0) fill(c.x,c.y); 
  else noFill();
}
void fill(ivec3 c) {
  fill(c.x,c.y,c.z);
}

void fill(ivec3 c, float a) {
  if(a > 0) fill(c.x,c.y,c.z,a);
  else noFill();
}

void fill(ivec4 c) {
  if(c.w > 0) fill(c.x,c.y,c.z,c.w); 
  else noFill();
}




/**
Stroke
*/
// vec
void stroke(vec2 c) {
  if(c.y > 0) stroke(c.x,c.y); 
  else noStroke();
}
void stroke(vec3 c) {
  stroke(c.x,c.y,c.z);
}

void stroke(vec3 c, float a) {
  if(a > 0) stroke(c.x,c.y,c.z,a); 
  else noStroke();
}

void stroke(vec4 c) {
  if(c.w > 0) stroke(c.x,c.y,c.z,c.w); 
  else noStroke();
}
// ivec
void stroke(ivec2 c) {
  if(c.y > 0) stroke(c.x,c.y); 
  else noStroke();
}
void stroke(ivec3 c) {
  stroke(c.x, c.y, c.z);
}

void stroke(ivec3 c, float a) {
  if(a > 0) stroke(c.x,c.y,c.z,a); 
  else noStroke();
}

void stroke(ivec4 c) {
  if(c.w > 0) stroke(c.x,c.y,c.z,c.w); 
  else noStroke();
}



/**
text
v 0.2.0
*/
void text(String s, vec pos) {
  if(pos instanceof vec2 && s != null) {
    vec2 p = (vec2)pos;
    text(s,p.x,p.y);
  } else if(pos instanceof vec3 && s != null) {
    vec3 p = (vec3)pos;
    text(s,p.x,p.y,p.z);
  } else {
    printErrTempo(60,"method text(): String message is null or vec is not an instance of vec3 or vec2");
  }
}

void text(char c, vec pos) {
  if(pos instanceof vec2) {
    vec2 p = (vec2)pos;
    text(c, p.x, p.y);
  } else if(pos instanceof vec3) {
    vec3 p = (vec3)pos;
    text(c,p.x,p.y,p.z);
  }
}

void text(int num, vec pos) {
  if(pos instanceof vec2) {
    vec2 p = (vec2)pos;
    text(num, p.x, p.y);
  } else if(pos instanceof vec3) {
    vec3 p = (vec3)pos;
    text(num,p.x,p.y,p.z);
  } 
}

void text(float num, vec pos) {
  if(pos instanceof vec2) {
    vec2 p = (vec2) pos;
    text(num, p.x, p.y);
  } else if(pos instanceof vec3) {
    vec3 p = (vec3) pos;
    text(num,p.x,p.y,p.z);
  } 
}

// ivec
void text(String s, ivec pos) {
  if(pos instanceof ivec2 && s != null) {
    vec2 temp_pos = vec2(pos.x,pos.y);
    text(s, temp_pos);
  } else if(pos instanceof ivec2) {
    vec3 temp_pos = vec3(pos.x,pos.y,pos.z);
    text(s, temp_pos);
  } else {
    printErrTempo(60,"method text(): String message is null or ivec is not an instance of ivec3 or ivec2");
  }  
}

void text(char c, ivec pos) {
  if(pos instanceof ivec2) {
    vec2 temp_pos = vec2(pos.x,pos.y);
    text(c, temp_pos);
  } else if(pos instanceof ivec2) {
    vec3 temp_pos = vec3(pos.x,pos.y,pos.z);
    text(c, temp_pos);
  } 
}

void text(int num, ivec pos) {
  if(pos instanceof ivec2) {
    vec2 temp_pos = vec2(pos.x,pos.y);
    text(num, temp_pos);
  } else if(pos instanceof ivec2) {
    vec3 temp_pos = vec3(pos.x,pos.y,pos.z);
    text(num, temp_pos);
  }
}

void text(float num, ivec pos) {
  if(pos instanceof ivec2) {
    vec2 temp_pos = vec2(pos.x,pos.y);
    text(num, temp_pos);
  } else if(pos instanceof ivec2) {
    vec3 temp_pos = vec3(pos.x,pos.y,pos.z);
    text(num, temp_pos);
  } 
}








/**
Translate
*/
// vec
void translate(vec3 t) {
  if(renderer_P3D()) {
    translate(t.x,t.y,t.z); 
  } else {
    translate(t.x,t.y);
  }
}

void translate(vec2 t){
  translate(round(t.x),round(t.y));
}

// ivec
void translate(ivec3 t){
  if(renderer_P3D()) {
    translate(t.x,t.y,t.z); 
  } else {
    translate(t.x,t.y);
  }
}

void translate(ivec2 t){
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
// vec
void rotateXY(vec2 rot) {
  rotateX(rot.x);
  rotateY(rot.y);
}

void rotateXZ(vec2 rot) {
  rotateX(rot.x);
  rotateZ(rot.y);
}

void rotateYZ(vec2 rot) {
  rotateY(rot.x);
  rotateZ(rot.y);
}
void rotateXYZ(vec3 rot) {
  rotateX(rot.x);
  rotateY(rot.y);
  rotateZ(rot.z);
}

// ivec
void rotateXY(ivec2 rot) {
  rotateX(rot.x);
  rotateY(rot.y);
}

void rotateXZ(ivec2 rot) {
  rotateX(rot.x);
  rotateZ(rot.y);
}

void rotateYZ(ivec2 rot) {
  rotateY(rot.x);
  rotateZ(rot.y);
}
void rotateXYZ(ivec3 rot) {
  rotateX(rot.x);
  rotateY(rot.y);
  rotateZ(rot.z);
}







/**
Matrix
v 0.1.0
*/
// vec
void start_matrix_3D(vec pos, vec3 dir_cart) {
  vec3 dir = dir_cart.copy() ;
  pushMatrix() ;
  if(pos instanceof vec2) {
    vec2 p = (vec2) pos ;
    translate(p) ;
  } else if(pos instanceof vec3) {
    vec3 p = (vec3) pos ;
    translate(p) ;
  } else {
    printErr("Error in void start_matrix_3D(), vec pos is not an instance of vec2 or vec3, the matrix don't translate your object") ;
    // exit() ;
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

void start_matrix_3D(vec pos, vec2 dir_polar) {
  if(pos instanceof vec2) {
    vec2 p = (vec2) pos;
    pushMatrix();
    translate(p);
    rotateXY(dir_polar);
  } else if(pos instanceof vec3) {
    vec3 p = (vec3) pos;
    pushMatrix();
    translate(p);
    rotateXY(dir_polar);
  } else {
    printErr("Error in void start_matrix_3D(), vec pos is not an instance of vec2 or vec3, the matrix cannot be init") ;
    // exit() ;
  }
}

void start_matrix_2D(vec pos, float orientation) {
  if(pos instanceof vec2) {
    vec2 p = (vec2)pos;
    pushMatrix();
    translate(p);
    rotate(orientation);
  } else if(pos instanceof vec3) {
    vec3 p = (vec3)pos;
    pushMatrix();
    translate(p.x, p.y);
    rotate(orientation);
  } else {
    printErr("Error in void start_matrix_3D(), vec pos is not an instance of vec2 or vec3, the matrix cannot be init") ;
    // exit();
  }
}

// ivec
void start_matrix_3D(ivec pos, ivec3 dir_cart) {
  vec3 temp_dir_cart = vec3(dir_cart.x, dir_cart.y, dir_cart.z);
  if(pos instanceof ivec2) {
    vec2 temp_pos = vec2(pos.x, pos.y);
    start_matrix_3D(temp_pos, temp_dir_cart);
  } else if(pos instanceof ivec3) {
    vec3 temp_pos = vec3(pos.x, pos.y, pos.z);
    start_matrix_3D(temp_pos, temp_dir_cart);
  } 
}

void start_matrix_3D(ivec pos, ivec2 dir_polar) {
  vec2 temp_dir_polar = vec2(dir_polar.x, dir_polar.y);
  if(pos instanceof ivec2) {
    vec2 temp_pos = vec2(pos.x, pos.y);
    start_matrix_3D(temp_pos, temp_dir_polar);
  } else if(pos instanceof ivec3) {
    vec3 temp_pos = vec3(pos.x, pos.y, pos.z);
    start_matrix_3D(temp_pos, temp_dir_polar);
  }
}

void start_matrix_2D(ivec pos, float orientation) {
  if(pos instanceof ivec2) {
    vec2 temp_pos = vec2(pos.x, pos.y);
    start_matrix_2D(temp_pos, orientation);
  } else if(pos instanceof ivec3) {
    vec3 temp_pos = vec3(pos.x, pos.y, pos.z);
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
void matrix_3D_start(vec3 pos, vec3 dir_cart) {
  vec3 dir = dir_cart.copy() ;
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
void matrix_3D_start(vec3 pos, vec2 dir_polar) {
  pushMatrix() ;
  translate(pos) ;
  rotateXY(dir_polar) ;
  printErr("void matrix_3D_start() is deprecated instead use start_matrix_3D()") ;
}

@Deprecated
void matrix_2D_start(vec2 pos, float orientation) {
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
v 0.2.2
*/
boolean get_layer_is_correct() {
  if(get_layer() != null && get_layer().width > 0 && get_layer().height > 0) {
    return true;
  } else {
    return false;
  }
}

// colorMode
void colorMode(int mode) {
  if(get_layer_is_correct()) {
    get_layer().colorMode(mode);
  } else {
    g.colorMode(mode);
  }
}

void colorMode(int mode, float max) {
  if(get_layer_is_correct()) {
    get_layer().colorMode(mode,max);
  } else {
    g.colorMode(mode,max);
  } 
}


void colorMode(int mode, float max1, float max2, float max3) {
  if(get_layer_is_correct()) {
    get_layer().colorMode(mode,max1,max2,max3);
  } else {
    g.colorMode(mode,max1,max2,max3);
  }
}
void colorMode(int mode, float max1, float max2, float max3, float maxA) {
  if(get_layer_is_correct()) {
    get_layer().colorMode(mode,max1,max2,max3,maxA);
  } else {
    g.colorMode(mode,max1,max2,max3,maxA);
  }
}




// Processing ghost method

// position
void translate(float x, float y) {
  if(get_layer_is_correct()) {
    get_layer().translate(x,y);
  } else {
    g.translate(x,y);
  }
}

void translate(float x, float y, float z) {
  if(get_layer_is_correct()) {
    get_layer().translate(x,y,z);
  } else {
    g.translate(x,y,z);
  }
}


// rotate
void rotate(float arg) {
  if(get_layer_is_correct()) {
    get_layer().rotate(arg);
  } else {
    g.rotate(arg);
  }
}


void rotateX(float arg) {
  if(get_layer_is_correct()) {
    get_layer().rotateX(arg);
  } else {
    g.rotateX(arg);
  }
}

void rotateY(float arg) {
  if(get_layer_is_correct()) {
    get_layer().rotateY(arg);
  } else {
    g.rotateY(arg);
  }
}


void rotateZ(float arg) {
  if(get_layer_is_correct()) {
    get_layer().rotateZ(arg);
  } else {
    g.rotateZ(arg);
  }
}

// scale
void scale(float s) {
  if(get_layer_is_correct()) {
    get_layer().scale(s);
  } else {
    g.scale(s);
  }
}

void scale(float x, float y) {
  if(get_layer_is_correct()) {
    get_layer().scale(x,y);
  } else {
    g.scale(x,y);
  }
}

void scale(float x, float y, float z) {
  if(get_layer_is_correct()) {
    get_layer().scale(x,y,z);
  } else {
    g.scale(x,y,z);
  }
}

// shear
void shearX(float angle) {
  if(get_layer_is_correct()) {
    get_layer().shearX(angle);
  } else {
    g.shearX(angle);
  }
}

void shearY(float angle) {
  if(get_layer_is_correct()) {
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
  if(get_layer_is_correct()) {
    get_layer().noFill();
  } else {
    g.noFill();
  }
} 

void fill(int rgb) {
  if(get_layer_is_correct()) {
    get_layer().fill(rgb);
  } else {
    g.fill(rgb);
  }
}


void fill(int rgb, float alpha) {
  if(get_layer_is_correct()) {
    get_layer().fill(rgb,alpha);
  } else {
    g.fill(rgb,alpha);
  }
}

void fill(float gray) {
  if(get_layer_is_correct()) {
    get_layer().fill(gray);
  } else {
    g.fill(gray);
  }
}


void fill(float gray, float alpha) {
  if(get_layer_is_correct()) {
    get_layer().fill(gray,alpha);
  } else {
    g.fill(gray,alpha);
  }
}

void fill(float v1, float v2, float v3) {
  if(get_layer_is_correct()) {
    get_layer().fill(v1,v2,v3);
  } else {
    g.fill(v1,v2,v3);
  }
}

void fill(float v1, float v2, float v3, float alpha) {
  if(get_layer_is_correct()) {
    get_layer().fill(v1,v2,v3,alpha);
  } else {
    g.fill(v1,v2,v3,alpha);
  }
}

// stroke
void noStroke() {
  if(get_layer_is_correct()) {
    get_layer().noStroke();
  } else {
    g.noStroke();
  }
} 

void stroke(int rgb) {
  if(get_layer_is_correct()) {
    get_layer().stroke(rgb);
  } else {
    g.stroke(rgb);
  }
}




void stroke(int rgb, float alpha) {
  if(get_layer_is_correct()) {
    get_layer().stroke(rgb,alpha);
  } else {
    g.stroke(rgb,alpha);
  }
}

void stroke(float gray) {
  if(get_layer_is_correct()) {
    get_layer().stroke(gray);
  } else {
    g.stroke(gray);
  }
}


void stroke(float gray, float alpha) {
  if(get_layer_is_correct()) {
    get_layer().stroke(gray,alpha);
  } else {
    g.stroke(gray,alpha);
  }
}

void stroke(float v1, float v2, float v3) {
  if(get_layer_is_correct()) {
    get_layer().stroke(v1,v2,v3);
  } else {
    g.stroke(v1,v2,v3);
  }
}

void stroke(float v1, float v2, float v3, float alpha) {
  if(get_layer_is_correct()) {
    get_layer().stroke(v1,v2,v3,alpha);
  } else {
    g.stroke(v1,v2,v3,alpha);
  }
}


// strokeWeight
void strokeWeight(float thickness) {
  if(get_layer_is_correct()) {
    get_layer().strokeWeight(thickness);
  } else {
    g.strokeWeight(thickness);
  }
}

// strokeJoin
void strokeJoin(int join) {
  if(get_layer_is_correct()) {
    get_layer().strokeJoin(join);
  } else {
    g.strokeJoin(join);
  }
}

// strokeJoin
void strokeCapstrokeCap(int cap) {
  if(get_layer_is_correct()) {
    get_layer().strokeCap(cap);
  } else {
    g.strokeCap(cap);
  }
}












/**
shape
*/

void rectMode(int mode) {
  if(get_layer_is_correct()) {
    get_layer().rectMode(mode);
  } else {
    g.rectMode(mode);
  }
}

void ellipseMode(int mode) {
  if(get_layer_is_correct()) {
    get_layer().ellipseMode(mode);
  } else {
    g.ellipseMode(mode);
  }
}

// rect
void rect(float px, float py, float sx, float sy) {
  if(get_layer_is_correct()) {
    get_layer().rect(px,py,sx,sy);
  } else {
    g.rect(px,py,sx,sy);
  }
}


void rect(float  px, float py, float sx, float sy, float r) {
  if(get_layer_is_correct()) {
    get_layer().rect(px,py,sx,sy,r);
  } else {
    g.rect(px,py,sx,sy,r);
  }
}

void rect(float px, float py, float sx, float sy, float tl, float tr, float br, float bl) {
  if(get_layer_is_correct()) {
    get_layer().rect(px,py,sx,sy,tl,tr,br,bl);
  } else {
    g.rect(px,py,sx,sy,tl,tr,br,bl);
  }
}


//arc
void arc(float a, float b, float c, float d, float start, float stop) {
  if(get_layer_is_correct()) {
    get_layer().arc(a,b,c,d,start,stop);
  } else {
    g.arc(a,b,c,d,start,stop);
  }
}

void arc(float a, float b, float c, float d, float start, float stop, int mode) {
  if(get_layer_is_correct()) {
    get_layer().arc(a,b,c,d,start,stop,mode);
  } else {
    g.arc(a,b,c,d,start,stop,mode);
  }
}

// ellipse
void ellipse(int px, int py, int sx, int sy) {
  if(get_layer_is_correct()) {
    get_layer().ellipse(px,py,sx,sy);
  } else {
    g.ellipse(px,py,sx,sy);
  }
}




// box
void box(float s) {
  if(get_layer_is_correct()) {
    get_layer().box(s,s,s);
  } else {
    g.box(s,s,s);
  }
}

void box(float w, float h, float d) {
  if(get_layer_is_correct()) {
    get_layer().box(w,h,d);
  } else {
    g.box(w,h,d);
  }
}


// sphere
void sphere(float r) {
  if(get_layer_is_correct()) {
    get_layer().sphere(r);
  } else {
    g.sphere(r);
    // p.sphere(r);
  }
}


// sphere detail
void sphereDetail(int res) {
  if(get_layer_is_correct()) {
    get_layer().sphereDetail(res);
  } else {
    g.sphereDetail(res);
  }
}

void sphereDetail(int ures, int vres) {
  if(get_layer_is_correct()) {
    get_layer().sphereDetail(ures,vres);
  } else {
    g.sphereDetail(ures,vres);
  }
}




//line
void line(float x1, float y1, float x2, float y2) {
  if(get_layer_is_correct()) {
    get_layer().line(x1,y1,x2,y2);
  } else {
    g.line(x1,y1,x2,y2);
  }
}

void line(float x1, float y1, float z1, float x2, float y2, float z2) {
  if(get_layer_is_correct()) {
    get_layer().line(x1,y1,z1,x2,y2,z2);
  } else {
    g.line(x1,y1,z1,x2,y2,z2);
  }
}






// point
void point(float x, float y) {
  if(get_layer_is_correct()) {
    get_layer().point(x,y);
  } else {
    g.point(x,y);
  }
}

void point(float x, float y, float z) {
  if(get_layer_is_correct()) {
    get_layer().point(x,y,z);
  } else {
    g.point(x,y,z);
  }
}

// quad
void quad(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  if(get_layer_is_correct()) {
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
  if(get_layer_is_correct()) {
    get_layer().beginShape();
  } else {
    g.beginShape();
  }
}

void beginShape(int kind) {
  if(get_layer_is_correct()) {
    get_layer().beginShape(kind);
  } else {
    g.beginShape(kind);
  }
}


void endShape() {
  if(get_layer_is_correct()) {
    get_layer().endShape();
  } else {
    g.endShape();
  }
}

void endShape(int mode) {
  if(get_layer_is_correct()) {
    get_layer().endShape(mode);
  } else {
    g.endShape(mode);
  }
}

// shape
void shape(PShape shape) {
  if(get_layer_is_correct()) {
    get_layer().shape(shape);
  } else {
    g.shape(shape);
  }
}

void shape(PShape shape, float x, float y) {
  if(get_layer_is_correct()) {
    get_layer().shape(shape,x,y);
  } else {
    g.shape(shape,x,y);
  }
}

void shape(PShape shape, float a, float b, float c, float d) {
  if(get_layer_is_correct()) {
    get_layer().shape(shape,a,b,c,d);
  } else {
    g.shape(shape,a,b,c,d);
  }
}




//vertex
void vertex(float x, float y) {
  if(get_layer_is_correct()) {
    get_layer().vertex(x,y);
  } else {
    g.vertex(x,y);
  }
}

void vertex(float x, float y, float z) {
  if(get_layer_is_correct()) {
    get_layer().vertex(x,y,z);
  } else {
    g.vertex(x,y,z);
  }
}

void vertex(float [] v) {
  if(get_layer_is_correct()) {
    get_layer().vertex(v);
  } else {
    g.vertex(v);
  }
}

void vertex(float x, float y, float u, float v) {
  if(get_layer_is_correct()) {
    get_layer().vertex(x,y,u,v);
  } else {
    g.vertex(x,y,u,v);
  }
} 


void vertex(float x, float y, float z, float u, float v) {
  if(get_layer_is_correct()) {
    get_layer().vertex(x,y,z,u,v);
  } else {
    g.vertex(x,y,z,u,v);
  }
}  


// quadratic vertex
void quadraticVertex(float cx, float cy, float x3, float y3) {
  if(get_layer_is_correct()) {
    get_layer().quadraticVertex(cx,cy,x3,y3);
  } else {
    g.quadraticVertex(cx,cy,x3,y3);
  }
}

void quadraticVertex(float cx, float cy, float cz, float x3, float y3, float z3) {
  if(get_layer_is_correct()) {
    get_layer().quadraticVertex(cx,cy,cz,x3,y3,z3);
  } else {
    g.quadraticVertex(cx,cy,cz,x3,y3,z3);
  }
}

// curve vertex
void curveVertex(float x, float y) {
  if(get_layer_is_correct()) {
    get_layer().curveVertex(x,y);
  } else {
    g.curveVertex(x,y);
  }
}

void curveVertex(float x, float y, float z) {
  if(get_layer_is_correct()) {
    get_layer().curveVertex(x,y,z);
  } else {
    g.curveVertex(x,y,z);
  }
}


//bezier vertex
void bezierVertex(float x2, float y2, float x3, float y3, float x4, float y4) {
  if(get_layer_is_correct()) {
    get_layer().bezierVertex(x2,y2,x3,y3,x4,y4);
  } else {
    g.bezierVertex(x2,y2,x3,y3,x4,y4);
  }
}


void bezierVertex(float x2, float y2, float z2, float x3, float y3, float z3, float x4, float y4, float z4) {
  if(get_layer_is_correct()) {
    get_layer().bezierVertex(x2,y2,z2,x3,y3,z3,x4,y4,z4);
  } else {
    g.bezierVertex(x2,y2,z2,x3,y3,z3,x4,y4,z4);
  }
}

// bezier
void bezier(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  if(get_layer_is_correct()) {
    get_layer().bezier(x1,y1,x2,y2,x3,y3,x4,y4);
  } else {
    g.bezier(x1,y1,x2,y2,x3,y3,x4,y4);
  }
}

void bezier(float x1, float y1, float z1, float x2, float y2, float z2, float x3, float y3, float z3, float x4, float y4, float z4) {
  if(get_layer_is_correct()) {
    get_layer().bezier(x1,y1,z1,x2,y2,z2,x3,y3,z3,x4,y4,z4);
  } else {
    g.bezier(x1,y1,z1,x2,y2,z2,x3,y3,z3,x4,y4,z4);
  }
}

// bezier detail
void bezierDetail(int detail) {
  if(get_layer_is_correct()) {
    get_layer().bezierDetail(detail);
  } else {
    g.bezierDetail(detail);
  }
}

// curve
void curve(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  if(get_layer_is_correct()) {
    get_layer().curve(x1,y1,x2,y2,x3,y3,x4,y4);
  } else {
    g.curve(x1,y1,x2,y2,x3,y3,x4,y4);
  }
}


void curve(float x1, float y1, float z1, float x2, float y2, float z2, float x3, float y3, float z3, float x4, float y4, float z4) {
  if(get_layer_is_correct()) {
    get_layer().curve(x1,y1,z1,x2,y2,z2,x3,y3,z3,x4,y4,z4);
  } else {
    g.curve(x1,y1,z1,x2,y2,z2,x3,y3,z3,x4,y4,z4);
  }
}

// curve detail
void curveDetail(int detail) {
  if(get_layer_is_correct()) {
    get_layer().curveDetail(detail);
  } else {
    g.curveDetail(detail);
  }
}




















// light
void lights() {
  if(get_layer_is_correct()) {
    get_layer().lights();
  } else {
    g.lights();
  }
}

void noLights() {
  if(get_layer_is_correct()) {
    get_layer().noLights();
  } else {
    g.noLights();
  }
}

// ambient light
void ambientLight(float v1, float v2, float v3) {
  if(get_layer_is_correct()) {
    get_layer().ambientLight(v1,v2,v3);
  } else {
    g.ambientLight(v1,v2,v3);
  }
}


void ambientLight(float v1, float v2, float v3, float x, float y, float z) {
  if(get_layer_is_correct()) {
    get_layer().ambientLight(v1,v2,v3,x,y,z);
  } else {
    g.ambientLight(v1,v2,v3,x,y,z);
  }
}


//directionalLight(v1, v2, v3, nx, ny, nz)
void directionalLight(float v1, float v2, float v3, float nx, float ny, float nz) {
  if(get_layer_is_correct()) {
    get_layer().directionalLight(v1,v2,v3,nx,ny,nz);
  } else {
    g.directionalLight(v1,v2,v3,nx,ny,nz);
  }
}



// lightFalloff(constant, linear, quadratic)
void lightFalloff(float constant, float linear, float quadratic) {
  if(get_layer_is_correct()) {
    get_layer().lightFalloff(constant,linear,quadratic);
  } else {
    g.lightFalloff(constant,linear,quadratic);
  }
}


// lightSpecular(v1, v2, v3) 

void lightSpecular(float v1, float v2, float v3) {
  if(get_layer_is_correct()) {
    get_layer().lightSpecular(v1,v2,v3);
  } else {
    g.lightSpecular(v1,v2,v3);
  }
}

// normal(nx, ny, nz)
void normal(float nx, float ny, float nz) {
  if(get_layer_is_correct()) {
    get_layer().normal(nx,ny,nz);
  } else {
    g.normal(nx,ny,nz);
  }
}


// pointLight(v1, v2, v3, x, y, z)
void pointLight(float v1, float v2, float v3, float x, float y, float z) {
  if(get_layer_is_correct()) {
    get_layer().pointLight(v1,v2,v3,x,y,z);
  } else {
    g.pointLight(v1,v2,v3,x,y,z);
  }
}

// spotLight(v1, v2, v3, x, y, z, nx, ny, nz, angle, concentration)
void spotLight(float v1, float v2, float v3, float x, float y, float z, float nx, float ny, float nz, float angle, float concentration) {
  if(get_layer_is_correct()) {
    get_layer().spotLight(v1,v2,v3,x,y,z,nx,ny,nz,angle,concentration);
  } else {
    g.spotLight(v1,v2,v3,x,y,z,nx,ny,nz,angle,concentration);
  }
}


/**
Material properties
*/
void ambient(int rgb) {
  if(get_layer_is_correct()) {
    get_layer().ambient(rgb);
  } else {
    g.ambient(rgb);
  }
}

void ambient(float gray) {
  if(get_layer_is_correct()) {
    get_layer().ambient(gray);
  } else {
    g.ambient(gray);
  }
}


void ambient(float v1, float v2, float v3) {
  if(get_layer_is_correct()) {
    get_layer().ambient(v1,v2,v3);
  } else {
    g.ambient(v1,v2,v3);
  }
}


// emissive
void emissive(int rgb) {
  if(get_layer_is_correct()) {
    get_layer().emissive(rgb);
  } else {
    g.emissive(rgb);
  }
}

void emissive(float gray) {
  if(get_layer_is_correct()) {
    get_layer().emissive(gray);
  } else {
    g.emissive(gray);
  }
}


void emissive(float v1, float v2, float v3) {
  if(get_layer_is_correct()) {
    get_layer().emissive(v1,v2,v3);
  } else {
    g.emissive(v1,v2,v3);
  }
}


// specular
void specular(int rgb) {
  if(get_layer_is_correct()) {
    get_layer().specular(rgb);
  } else {
    g.specular(rgb);
  }
}

void specular(float gray) {
  if(get_layer_is_correct()) {
    get_layer().specular(gray);
  } else {
    g.specular(gray);
  }
}


void specular(float v1, float v2, float v3) {
  if(get_layer_is_correct()) {
    get_layer().specular(v1,v2,v3);
  } else {
    g.specular(v1,v2,v3);
  }
}


// shininess(shine)
void shininess(float shine) {
  if(get_layer_is_correct()) {
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
  if(get_layer_is_correct()) {
    get_layer().camera();
  } else {
    g.camera();
  }
}

void camera(float eyeX, float eyeY, float eyeZ, float centerX, float centerY, float centerZ, float upX, float upY, float upZ) {
  if(get_layer_is_correct()) {
    get_layer().camera(eyeX,eyeY,eyeZ,centerX,centerY,centerZ,upX,upY,upZ);
  } else {
    g.camera(eyeX,eyeY,eyeZ,centerX,centerY,centerZ,upX,upY,upZ);
  }
}


void beginCamera() {
  if(get_layer_is_correct()) {
    get_layer().beginCamera();
  } else {
    g.beginCamera();
  }
}

void endCamera() {
  if(get_layer_is_correct()) {
    get_layer().endCamera();
  } else {
    g.endCamera();
  }
}


// frustum(left, right, bottom, top, near, far)
void frustum(float left, float right, float bottom, float top, float near, float far) {
  if(get_layer_is_correct()) {
    get_layer().frustum(left,right,bottom,top,near,far);
  } else {
    g.frustum(left,right,bottom,top,near,far);
  }
}


// ortho
void ortho() {
  if(get_layer_is_correct()) {
    get_layer().ortho();
  } else {
    g.ortho();
  }
}

void ortho(float left, float right, float bottom, float top) {
  if(get_layer_is_correct()) {
    get_layer().ortho(left,right,bottom,top);
  } else {
    g.ortho(left,right,bottom,top);
  }
}


void ortho(float left, float right, float bottom, float top, float near, float far) {
  if(get_layer_is_correct()) {
    get_layer().ortho(left,right,bottom,top,near,far);
  } else {
    g.ortho(left,right,bottom,top,near,far);
  }
}


  
// perspective
void perspective() {
  if(get_layer_is_correct()) {
    get_layer().perspective();
  } else {
    g.perspective();
  }
}


void perspective(float fovy, float aspect, float zNear, float zFar) {
  if(get_layer_is_correct()) {
    get_layer().perspective(fovy,aspect,zNear,zFar);
  } else {
    g.perspective(fovy,aspect,zNear,zFar);
  }
}


















/**
matrix
*/
void pushMatrix() {
  if(get_layer_is_correct()) {
    get_layer().pushMatrix();
  } else {
    g.pushMatrix();
  }
}


void popMatrix() {
  if(get_layer_is_correct()) {
    get_layer().popMatrix();
  } else {
    g.popMatrix();
  }
}


// apply matrix
void applyMatrix(PMatrix source) {
  if(get_layer_is_correct()) {
    get_layer().applyMatrix(source);
  } else {
    g.applyMatrix(source);
  }
}

void applyMatrix(float n00, float n01, float n02, float n10, float n11, float n12) {
  if(get_layer_is_correct()) {
    get_layer().applyMatrix(n00,n01,n02,n10,n11,n12);
  } else {
    g.applyMatrix(n00,n01,n02,n10,n11,n12);
  }
}

void applyMatrix(float n00, float n01, float n02, float n03, float n10, float n11, float n12, float n13, float n20, float n21, float n22, float n23, float n30, float n31, float n32, float n33) {
  if(get_layer_is_correct()) {
    get_layer().applyMatrix(n00,n01,n02,n03,n10,n11,n12,n13,n20,n21,n22,n23,n30,n31,n32,n33);
  } else {
    g.applyMatrix(n00,n01,n02,n03,n10,n11,n12,n13,n20,n21,n22,n23,n30,n31,n32,n33);
  }
}



void resetMatrix() {
  if(get_layer_is_correct()) {
    get_layer().resetMatrix();
  } else {
    g.resetMatrix();
  }
}


  












/**
image
*/
void image(PImage img, float x, float y) {
  if(get_layer_is_correct()) {
    get_layer().image(img,x,y);
  } else {
    g.image(img,x,y);
  }
}

void image(PImage img, float a, float b, float c, float d) {
  if(get_layer_is_correct()) {
    get_layer().image(img,a,b,c,d);
  } else {
    g.image(img,a,b,c,d);
  }
}














/**
get
*/
int get(int x, int y) {
  if(get_layer_is_correct()) {
    return get_layer().get(x,y);
  } else {
    return g.get(x,y);
  }
} 


PImage get(int x, int y, int w, int h) {
  if(get_layer_is_correct()) {
    return get_layer().get(x,y,w,h);
  } else {
    return g.get(x,y,w,h);
  }
}


PImage get() {
  if(get_layer_is_correct()) {
    return get_layer().get();
  } else {
    return g.get();
  }
}









/**
loadPixels()
*/
void loadPixels() {
  if(get_layer_is_correct()) {
    get_layer().loadPixels();
  } else {
    g.loadPixels();
  }
}


/**
updatePixels()
*/
void updatePixels() {
  if(get_layer_is_correct()) {
    get_layer().updatePixels();
  } else {
    g.updatePixels();
  }
}








/**
tint
*/
void tint(int rgb) {
  if(get_layer_is_correct()) {
    get_layer().tint(rgb);
  } else {
    g.tint(rgb);
  }
}

void tint(int rgb, float alpha) {
  if(get_layer_is_correct()) {
    get_layer().tint(rgb,alpha);
  } else {
    g.tint(rgb,alpha);
  }
}

void tint(float gray) {
  if(get_layer_is_correct()) {
    get_layer().tint(gray);
  } else {
    g.tint(gray);
  }
}

void tint(float gray, float alpha) {
  if(get_layer_is_correct()) {
    get_layer().tint(gray,alpha);
  } else {
    g.tint(gray,alpha);
  }
}

void tint(float v1, float v2, float v3) {
  if(get_layer_is_correct()) {
    get_layer().tint(v1,v2,v3);
  } else {
    g.tint(v1,v2,v3);
  }
}

void tint(ivec4 v) {
  tint(v.x,v.y,v.z,v.w);
}

void tint(ivec3 v) {
  tint(v.x,v.y,v.z,g.colorModeA);
}

void tint(ivec2 v) {
  tint(v.x,v.x,v.x,v.y);
}

void tint(vec4 v) {
  tint(v.x,v.y,v.z,v.w);
}

void tint(vec3 v) {
  tint(v.x,v.y,v.z,g.colorModeA);
}

void tint(vec2 v) {
  tint(v.x,v.x,v.x,v.y);
}

void tint(float v1, float v2, float v3, float alpha) {
  if(get_layer_is_correct()) {
    get_layer().tint(v1,v2,v3,alpha);
  } else {
    g.tint(v1,v2,v3,alpha);
  }
}















/**
blend
*/
void blend(int sx, int sy, int sw, int sh, int dx, int dy, int dw, int dh, int mode) {
  if(get_layer_is_correct()) {
    get_layer().blend(sx,sy,sw,sh,dx,dy,dw,dh,mode);
  } else {
    g.blend(sx,sy,sw,sh,dx,dy,dw,dh,mode);
  }
}


void blend(PImage src, int sx, int sy, int sw, int sh, int dx, int dy, int dw, int dh, int mode) {
  if(get_layer_is_correct()) {
    get_layer().blend(src,sx,sy,sw,sh,dx,dy,dw,dh,mode);
  } else {
    g.blend(src,sx,sy,sw,sh,dx,dy,dw,dh,mode);
  }
}













/**
filter
v 0.0.2
*/
void filter(PShader shader) {
  if(get_layer_is_correct()) {
    get_layer().filter(shader);
  } else if (g.pixels != null) {
    g.filter(shader);
  }
}

void filter(int kind) {
  if(get_layer_is_correct()) {
    get_layer().filter(kind);
  } else if (g.pixels != null) {
    g.filter(kind);
  }
}

void filter(int kind, float param) {
  if(get_layer_is_correct()) {
    get_layer().filter(kind,param);
  } else if (g.pixels != null) {
    g.filter(kind,param);
  }
}













/**
set
*/
void set(int x, int y, int c) {
  if(get_layer_is_correct()) {
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
  if(get_layer_is_correct()) {
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
2017-2019
v 0.1.2
*/
void text(char c, float x, float y) {
  if(get_layer_is_correct()) {
    get_layer().text(c,x,y);
  } else {
    g.text(c,x,y);
  }
}


void text(char c, float x, float y, float z) {
  if(get_layer_is_correct()) {
    get_layer().text(c,x,y,z);
  } else {
    g.text(c,x,y,z);
  }
}

void text(char [] chars, int start, int stop, float x, float y) {
  if(get_layer_is_correct()) {
    get_layer().text(chars,start,stop,x,y);
  } else {
    g.text(chars,start,stop,x,y);
  }
}


void text(char [] chars, int start, int stop, float x, float y, float z) {
  if(get_layer_is_correct()) {
    get_layer().text(chars,start,stop,x,y,z);
  } else {
    g.text(chars,start,stop,x,y,z);
  }
}



void text(String str, float x, float y) {
  if(get_layer_is_correct()) {
    get_layer().text(str,x,y);
  } else {
    g.text(str,x,y);
  }
}


void text(String str, float x, float y, float z) {
  if(get_layer_is_correct()) {
    get_layer().text(str,x,y,z);
  } else {
    g.text(str,x,y,z);
  }
}


void text(String str, float x1, float y1, float x2, float y2) {
  if(get_layer_is_correct()) {
    get_layer().text(str,x1,y1,x2,y2);
  } else {
    g.text(str,x1,y1,x2,y2);
  }
}

void text(float num, float x, float y) {
  if(get_layer_is_correct()) {
    get_layer().text(num,x,y);
  } else {
    g.text(num,x,y);
  }
}


void text(float num, float x, float y, float z) {
  if(get_layer_is_correct()) {
    get_layer().text(num,x,y,z);
  } else {
    g.text(num,x,y,z);
  }
}


void text(int num, float x, float y) {
  if(get_layer_is_correct()) {
    get_layer().text(num,x,y);
  } else {
    g.text(num,x,y);
  }
}


void text(int num, float x, float y, float z) {
  if(get_layer_is_correct()) {
    get_layer().text(num,x,y,z);
  } else {
    g.text(num,x,y,z);
  }
}


// text Align
void textAlign(int alignX) {
  if(get_layer_is_correct()) {
    get_layer().textAlign(alignX);
  } else {
    g.textAlign(alignX);
  }
}


void textAlign(int alignX, int alignY) {
  if(get_layer_is_correct()) {
    get_layer().textAlign(alignX,alignY);
  } else {
    g.textAlign(alignX,alignY);
  }
}

// textLeading(leading)
void textLeading(float leading) {
if(get_layer_is_correct()) {
    get_layer().textLeading(leading);
  } else {
    g.textLeading(leading);
  }
}


// textMode(mode)
void textMode(int mode) {
  if(get_layer_is_correct()) {
    get_layer().textMode(mode);
  } else {
    g.textMode(mode);
  }
}

// text Size
void textSize(float size) {
  if(get_layer_is_correct()) {
    get_layer().textSize(size);
  } else {
    g.textSize(size);
  }
}


// textFont
void textFont(PFont font) {
  if(font != null) {
    if(get_layer_is_correct()) {
      get_layer().textFont(font);
    } else {
      g.textFont(font);
    }
  }
}

void textFont(PFont font, float size) {
  if(get_layer_is_correct()) {
    if(get_layer() != null) {
      get_layer().textFont(font,size);
    } else {
      g.textFont(font,size);
    }
  }
}






  




