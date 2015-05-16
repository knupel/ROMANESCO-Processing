// CLASS VEC 0.1.5
//////////////////
// inspireted by GLSL code and PVector

// VEC 2
////////////////
class Vec2 {
  float x,y = 0;
  float s,t = 0;
  float u,v = 0;
  
  Vec2() {
  }
  
  Vec2(float value) {
    this.x = this.y = this.s = this.t = this.u = this.v = value ;
  }
  
  Vec2(float x, float y) {
    this.x = this.s = this.u = x ;
    this.y = this.t = this.v = y ;
  }
  
  
  // multiplication
  /* multiply Vector by a float value */
  void mult(float mult) {
    x *= mult ; y *= mult ;
    // update value
    s = u = x ;
    t = v = y ;
  }
  
  // mult by vector
  void mult(Vec2 v_a) {
    x *= v_a.x ; y *= v_a.y ; 
    // update value
    s = u = x ;
    t = v = y ;
  }
  
  
    // division
  ///////////
  /*
  @ return Vec
  divide Vector by a float value */
  void div(float div) {
    x /= div ; y /= div ; 
    // update value
    s = u = x ;
    t = v = y ;
  }
  
  // divide by vector
  void div(Vec2 v_a) {
    x /= v_a.x ; y /= v_a.y ;  
    // update value
    s = u = x ;
    t = v = y ;
  }
  
  
  // addition
  ///////////
  /* add two Vector together */
  Vec2 add(Vec2 v_a, Vec2 v_b) {
    x = v_a.x + v_b.x ;
    y = v_a.y + v_b.y ;
    // update value
    s = u = x ;
    t = v = y ;
    return new Vec2(x,y)  ;
  }
  
  /* mapping
  return mapping vector
  @return Vec2
  */
  Vec2 mapVec(float minIn, float maxIn, float minOut, float maxOut) {
    x = map(x,minIn, maxIn, minOut, maxOut) ;
    y = map(y,minIn, maxIn, minOut, maxOut) ;
    // update value
    s = u = x ;
    t = v = y ;
    return new Vec2(x,y) ;
  }
  
  /* magnitude or length of Vec2
  @ return float
  */
  /////////////////////
  float mag() {
    x *= x ;
    y *= y ; 
    return sqrt(x+y) ;
  }

  float mag(Vec2 v_target) {
    float new_x = (v_target.x -x) *(v_target.x -x) ;
    float new_y = (v_target.y -y) *(v_target.y -y) ;
    return sqrt(new_x +new_y) ;
  }
  
  
  // Distance
  ////////////
  /*
  @ return float
  distance between himself and an other vector
  */
  float dist(Vec2 v_target) {
    float dx = x - v_target.x;
    float dy = y - v_target.y;
    return (float) Math.sqrt(dx*dx + dy*dy);
  }
  
  
  
  /*catch info
  /////////////
  return all the componant of Vec
  @return Vec2
  */
  Vec2 copy() {
    return new Vec2(x,y) ;
  }
  /*
  return all the componant of Vec in type PVector
  @return PVector
  */
  PVector copyVecToPVector() {
    return new PVector(x,y) ;
  }
  

}
// END VEC 2
////////////









// VEC 3
////////////////
class Vec3 {
  float x,y,z  = 0 ;
  float r, g, b = 0 ;
  float s, t, p = 0 ;
  Vec3() {}
  
  Vec3(float value) {
    this.x = this.y = this.z  = this.r = this.g = this.b =this.s = this.t = this.p = value ;
  }
  
  Vec3(float x, float y, float z) {
    this.x = this.r =this.s = x ;
    this.y = this.g =this.t = y ;
    this.z = this.b = this.p =z ;
  }
  
  // multiplication
  /* multiply Vector by a float value */
  void mult(float mult) {
    x *= mult ; y *= mult ; z *= mult ;
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
  }
  
  // mult by vector
  void mult(Vec3 v_a) {
    x *= v_a.x ; y *= v_a.y ; z *= v_a.z ; 
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
  }
  
  
  
  // division
  ///////////
  /*
  @ return Vec
  divide Vector by a float value */
  void div(float div) {
    x /= div ; y /= div ; z /= div ;
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
  }
  
  // divide by vector
  void div(Vec3 v_a) {
    x /= v_a.x ; y /= v_a.y ; z /= v_a.z ; 
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
  }
  
  
  
  // addition
  /* add two Vector together */
  Vec3 add(Vec3 v_a, Vec3 v_b) {
    x = v_a.x + v_b.x ;
    y = v_a.y + v_b.y ;
    z = v_a.z + v_b.z ;
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
    return new Vec3(x,y,z)  ;
  }
  
  
  
  /*
  mapping
  return mapping vector
  @return Vec3
  */
  Vec3 mapVec(float minIn, float maxIn, float minOut, float maxOut) {
    x = map(x, minIn, maxIn, minOut, maxOut) ;
    y = map(y, minIn, maxIn, minOut, maxOut) ;
    z = map(z, minIn, maxIn, minOut, maxOut) ;
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
    return new Vec3(x,y,z) ;
  }
  
  
  
  // Magnitude
  ////////////
  /* Magnitude or length of Vec3
  @ return float
  */
  /////////////////////
  float mag() {
    x *= x ;
    y *= y ; 
    z *= z ;
    return sqrt(x+y+z) ;
  }

  float mag(Vec3 v_target) {
    float new_x = (v_target.x -x) *(v_target.x -x) ;
    float new_y = (v_target.y -y) *(v_target.y -y) ;
    float new_z = (v_target.z -z) *(v_target.z -z) ;
    return sqrt(new_x +new_y +new_z) ;
  }
  
  // Distance
  ////////////
  /*
  @ return float
  distance himself and an other vector
  */
  float dist(Vec3 v_target) {
    float dx = x - v_target.x;
    float dy = y - v_target.y;
    float dz = z - v_target.z;
    return (float) Math.sqrt(dx*dx + dy*dy + dz*dz);
  }
  
  // catch info
  /////////////
  /*
  return all the component of Vec
  @return Vec3
  */
  Vec3 copy() {
    return new Vec3(x,y,z) ;
  }
  /*
  return all the component of Vec in type PVector
  @return PVector
  */
  PVector copyVecToPVector() {
    return new PVector(x,y,z) ;
  }
  
  
}
// END VEC 3
////////////






// VEC 4
////////
class Vec4 {
  float x,y,z,w = 0 ;
  float r, g, b, a = 0 ;
  float s, t, p, q = 0 ;
  
  Vec4 () {}
  
  Vec4(float value) {
    this.x = this.y = this.z = this.w = this.r = this.g = this.b = this.a =this.s = this.t = this.p = this.q = value ;
  }
  
  Vec4(float x, float y, float z, float w) {
    this.x = this.r = this.s = x ;
    this.y = this.g = this.t =y ;
    this.z = this.b = this.p =z ;
    this.w = this.a = this.q = w ;
  }
  
  
  // multiplication
  // mult by float
  void mult(float mult) {
    x *= mult ; y *= mult ; z *= mult ; w *= mult ;
    r = s = x ;
    g = t = y ;
    b = p = z ;
    a = q = w ;
  }
  
  // mult by vector
  void mult(Vec4 v_a) {
    x *= v_a.x ; y *= v_a.y ; z *= v_a.z ; w *= v_a.w ;
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
    a = q = w ;
  }
  
  
    // division
  ///////////
  /*
  @ return Vec
  divide Vector by a float value */
  void div(float div) {
    x /= div ; y /= div ; z /= div ; w /= div ;
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
    a = q = w ;
  }
  
  // divide by vector
  void div(Vec4 v_a) {
    x /= v_a.x ; y /= v_a.y ; z /= v_a.z ; w /= v_a.w ;
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
    a = q = w ;
  }
  
  // addition
  /* add two Vector together */
  Vec4 add(Vec4 v_a, Vec4 v_b) {
    x = v_a.x + v_b.x ;
    y = v_a.y + v_b.y ;
    z = v_a.z + v_b.z ;
    w = v_a.w + v_b.w ;
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
    a = q = w ;
    return new Vec4(x,y,z,w)  ;
  }
  
  /* mapping
  return mapping vector
  @return Vec4
  */
  Vec4 mapVec(float minIn, float maxIn, float minOut, float maxOut) {
    x = map(x, minIn, maxIn, minOut, maxOut) ;
    y = map(y, minIn, maxIn, minOut, maxOut) ;
    z = map(z, minIn, maxIn, minOut, maxOut) ;
    w = map(w, minIn, maxIn, minOut, maxOut) ;
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
    a = q = w ;
    return new Vec4(x,y,z,w) ;
  }
  
  // magnitude or length
  /////////////////////
  float mag() {
    x *= x ;
    y *= y ; 
    z *= z ;
    w *= w ;  ;
    return sqrt(x+y+z+w) ;
  }

  float mag(Vec4 v_target) {
    float new_x = (v_target.x -x) *(v_target.x -x) ;
    float new_y = (v_target.y -y) *(v_target.y -y) ;
    float new_z = (v_target.z -z) *(v_target.z -z) ;
    float new_w = (v_target.w -w) *(v_target.w -w) ;
    return sqrt(new_x +new_y +new_z +new_w) ;
  }
  
  // Distance
  ////////////
  // distance himself and an other vector
  float dist(Vec4 v_target) {
    float dx = x - v_target.x;
    float dy = y - v_target.y;
    float dz = z - v_target.z;
    float dw = w - v_target.w;
    return (float) Math.sqrt(dx*dx + dy*dy + dz*dz + dw*dw);
  }
    
  // catch info
  /////////////
  Vec4 copy() {
    return new Vec4(x,y,z,w) ;
  }
}
// END VEC 4
////////////



// CLASS Vec5
/////////////

class Vec5 {
  float a,b,c,d,e = 0 ;

  
  Vec5 () {}
  
  Vec5(float value) {
    this.a = this.b = this.c = this.d = this.e = value ;
  }
  
  Vec5(float a, float b, float c, float d, float e) {
    this.a = a ;
    this.b = b ;
    this.c = c ;
    this.d = d ;
    this.e = e ;
  }
  // catch info
  /////////////
  Vec5 copy() {
    return new Vec5(a,b,c,d,e) ;
  }
}

// END VEC 5
////////////












// External Methods VEC
///////////////////////



// Addition
// return the resultat of vector addition
Vec2 add(Vec2 v_a, Vec2 v_b) {
    float x = v_a.x + v_b.x ;
    float y = v_a.y + v_b.y ;
    return new Vec2(x,y) ;
}
Vec3 add(Vec3 v_a, Vec3 v_b) {
    float x = v_a.x + v_b.x ;
    float y = v_a.y + v_b.y ;
    float z = v_a.z + v_b.z ;
    return new Vec3(x,y,z)  ;
}
Vec4 add(Vec4 v_a, Vec4 v_b) {
    float x = v_a.x * v_b.x ;
    float y = v_a.y * v_b.y ;
    float z = v_a.z * v_b.z ;
    float w = v_a.w * v_b.w ;
    return new Vec4(x,y,z, w)  ;
}


// Multiplication
// return the resultat of vector multiplication
Vec2 mult(Vec2 v_a, Vec2 v_b) {
    float x = v_a.x * v_b.x ;
    float y = v_a.y * v_b.y ;
    return new Vec2(x,y) ;
}
Vec3 mult(Vec3 v1, Vec3 v_b) {
    float x = v1.x * v_b.x ;
    float y = v1.y * v_b.y ;
    float z = v1.z * v_b.z ;
    return new Vec3(x,y,z)  ;
}
Vec4 mult(Vec4 v_a, Vec4 v_b) {
    float x = v_a.x * v_b.x ;
    float y = v_a.y * v_b.y ;
    float z = v_a.z * v_b.z ;
    float w = v_a.w * v_b.w ;
    return new Vec4(x,y,z, w)  ;
}


// Division
// return the resultat of vector addition
Vec2 div(Vec2 v_a, Vec2 v_b) {
    float x = v_a.x / v_b.x ;
    float y = v_a.y / v_b.y ;
    return new Vec2(x,y) ;
}
Vec3 div(Vec3 v1, Vec3 v_b) {
    float x = v1.x / v_b.x ;
    float y = v1.y / v_b.y ;
    float z = v1.z / v_b.z ;
    return new Vec3(x,y,z)  ;
}
Vec4 div(Vec4 v_a, Vec4 v_b) {
    float x = v_a.x / v_b.x ;
    float y = v_a.y / v_b.y ;
    float z = v_a.z / v_b.z ;
    float w = v_a.w / v_b.w ;
    return new Vec4(x,y,z, w)  ;
}


// compare two vectors Vec
/*
@ return boolean
*/
// Vec method
boolean equals(Vec2 v_a, Vec2 v_b) {
  if((v_a.x == v_b.x) && (v_a.y == v_b.y)) return true ; else return false ;
}
boolean equals(Vec3 v_a, Vec3 v_b) {
  if((v_a.x == v_b.x) && (v_a.y == v_b.y) && (v_a.z == v_b.z)) return true ; else return false ;
}
boolean equals(Vec4 v_a, Vec4 v_b) {
  if((v_a.x == v_b.x) && (v_a.y == v_b.y) && (v_a.z == v_b.z) && (v_a.w == v_b.w)) return true ; else return false ;
}



/* Map
return mapping vector
@return Vec2, Vec3 or Vec4
*/
Vec2 mapVec(Vec2 v,float minIn, float maxIn, float minOut, float maxOut) {
  float x = map(v.x, minIn, maxIn, minOut, maxOut) ;
  float y = map(v.y, minIn, maxIn, minOut, maxOut) ;
  return new Vec2(x,y) ;
}
Vec3 mapVec(Vec3 v,float minIn, float maxIn, float minOut, float maxOut) {
  float x = map(v.x, minIn, maxIn, minOut, maxOut) ;
  float y = map(v.y, minIn, maxIn, minOut, maxOut) ;
  float z = map(v.z, minIn, maxIn, minOut, maxOut) ;
  return new Vec3(x,y,z) ;
}
Vec4 mapVec(Vec4 v,float minIn, float maxIn, float minOut, float maxOut) {
  float x = map(v.x, minIn, maxIn, minOut, maxOut) ;
  float y = map(v.y, minIn, maxIn, minOut, maxOut) ;
  float z = map(v.z, minIn, maxIn, minOut, maxOut) ;
  float w = map(v.w, minIn, maxIn, minOut, maxOut) ;
  return new Vec4(x,y,z,w) ;
}


// Magnitude or Length Vector
/*
@return float
*/
// mag Vec2
float mag(Vec2 v_a) {
  float x = v_a.x*v_a.x ;
  float y = v_a.y *v_a.y ;
  return sqrt(x+y) ;
}

float mag(Vec2 v_a, Vec2 v_b) {
  // same result than dist
  float x = (v_b.x -v_a.x)*(v_b.x -v_a.x) ;
  float y = (v_b.y -v_a.y)*(v_b.y -v_a.y) ;
  return sqrt(x+y) ;
}
// mag Vec3
float mag(Vec3 v_a) {
  float x = v_a.x*v_a.x ;
  float y = v_a.y *v_a.y ;
  float z = v_a.z *v_a.z ;
  return sqrt(x+y+z) ;
}

float mag(Vec3 v_a, Vec3 v_b) {
  // same result than dist
  float x = (v_b.x -v_a.x)*(v_b.x -v_a.x) ;
  float y = (v_b.y -v_a.y)*(v_b.y -v_a.y) ;
  float z = (v_b.z -v_a.z)*(v_b.z -v_a.z) ;
  return sqrt(x+y+z) ;
}
// mag Vec4
float mag(Vec4 v_a) {
  float x = v_a.x*v_a.x ;
  float y = v_a.y *v_a.y ;
  float z = v_a.z *v_a.z ;
  float w = v_a.w *v_a.w ;
  return sqrt(x+y+z+w) ;
}

float mag(Vec4 v_a, Vec4 v_b) {
  // same result than dist
  float x = (v_b.x -v_a.x)*(v_b.x -v_a.x) ;
  float y = (v_b.y -v_a.y)*(v_b.y -v_a.y) ;
  float z = (v_b.z -v_a.z)*(v_b.z -v_a.z) ;
  float w = (v_b.w -v_a.w)*(v_b.w -v_a.w) ;
  return sqrt(x+y+z+w) ;
}



// Distance
/*
return float
return the distance beatwen two vectors
*/
float dist(Vec2 v_a, Vec2 v_b) {
    float dx = v_a.x - v_b.x;
    float dy = v_a.y - v_b.y;
    return (float) Math.sqrt(dx*dx + dy*dy);
}
float dist(Vec3 v_a, Vec3 v_b) {
    float dx = v_a.x - v_b.x;
    float dy = v_a.y - v_b.y;
    float dz = v_a.z - v_b.z;
    return (float) Math.sqrt(dx*dx + dy*dy + dz*dz);
}
float dist(Vec4 v_a, Vec4 v_b) {
    float dx = v_a.x - v_b.x;
    float dy = v_a.y - v_b.y;
    float dz = v_a.z - v_b.z;
    float dw = v_a.w - v_b.w;
    return (float) Math.sqrt(dx*dx + dy*dy + dz*dz + dw*dw);
}


// Middle
////////
/*
@ return Vec2, Vec3 or Vec4
return the middle between two Vector
*/
Vec4 middle(Vec4 p1, Vec4 p2)  {
  Vec4 middle ;
  middle = add(p1, p2);
  middle.div(2) ;
  return middle ;
}

Vec3 middle(Vec3 p1, Vec3 p2)  {
  Vec3 middle ;
  middle = add(p1, p2);
  middle.div(2) ;
  return middle ;
}

Vec2 middle(Vec2 p1, Vec2 p2)  {
  Vec2 middle ;
  middle = add(p1, p2);
  middle.div(2) ;
  return middle ;
}


// Copy 
/*
@ return Vec3
Transform PVector in Vec
*/
Vec3 copyPVectorToVec(PVector p) {
  return new Vec3(p.x,p.y,p.z) ;
}







// return a Vec value
Vec4 Vec4(float x, float y, float z, float w) {
  return new Vec4(x,y,z,w) ;
}

Vec3 Vec3(float x, float y, float z) {
  return new Vec3(x,y,z) ;
}

Vec2 Vec2(float x, float y) {
  return new Vec2(x,y) ;
}
// END CLASS VEC
///////////////
