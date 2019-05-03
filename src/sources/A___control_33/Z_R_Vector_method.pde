/**
Vec, iVec and bVec rope method
v 0.4.1
* Copyleft (c) 2018-2019
* @author @stanlepunk
* @see https://github.com/StanLepunK/Rope_framework
*/




/**
Addition
v 0.0.4
*/
/**
* return the resultat of vector addition
*/
ivec2 iadd(ivec2 a, ivec2 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    int x = a.x + b.x ;
    int y = a.y + b.y ;
    return new ivec2(x,y) ;
  }
}

ivec3 iadd(ivec3 a, ivec3 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    int x = a.x + b.x ;
    int y = a.y + b.y ;
    int z = a.z + b.z ;
    return new ivec3(x,y,z)  ;
  }
}

ivec4 iadd(ivec4 a, ivec4 b) {  
  if(a == null || b == null) {
    return null ;
  } else {
    int x = a.x + b.x ;
    int y = a.y + b.y ;
    int z = a.z + b.z ;
    int w = a.w + b.w ;
    return new ivec4(x,y,z,w)  ;
  }
}

ivec2 iadd(ivec2 a, int arg) {
  return iadd(a,ivec2(arg,arg));
}

ivec3 iadd(ivec3 a, int arg) {
  return iadd(a,ivec3(arg,arg,arg));
}

ivec4 iadd(ivec4 a, int arg) {  
  return iadd(a,ivec4(arg,arg,arg,arg));
}




/**
Multiplication
v 0.0.1
*/
/**
* return the resultat of vector multiplication
*/
ivec2 imult(ivec2 a, ivec2 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    int x = a.x * b.x;
    int y = a.y * b.y;
    return new ivec2(x,y);
  }
}

ivec3 imult(ivec3 a, ivec3 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    int x = a.x * b.x;
    int y = a.y * b.y;
    int z = a.z * b.z;
    return new ivec3(x,y,z);
  }
}

ivec4 imult(ivec4 a, ivec4 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    int x = a.x * b.x;
    int y = a.y * b.y;
    int z = a.z * b.z;
    int w = a.w * b.w;
    return new ivec4(x,y,z,w);
  }
}

ivec2 imult(ivec2 a, int arg) {
  return imult(a,ivec2(arg,arg));
}

ivec3 imult(ivec3 a, int arg) {
  return imult(a,ivec3(arg,arg,arg));
}

ivec4 imult(ivec4 a, int arg) {  
  return imult(a,ivec4(arg,arg,arg,arg));
}


/**
Division
v 0.0.3
*/
/**
* return the resultat of vector division
*/
ivec2 idiv(ivec2 a, ivec2 b) {
  if(a == null || b == null) {
    return null;
  } else {
    int x = a.x / b.x;
    int y = a.y / b.y;
    return new ivec2(x,y);
  }
}

ivec3 idiv(ivec3 a, ivec3 b) {
  if(a == null || b == null) {
    return null;
  } else {
    int x = a.x / b.x;
    int y = a.y / b.y;
    int z = a.z / b.z;
    return new ivec3(x,y,z);
  }
}

ivec4 idiv(ivec4 a, ivec4 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    int x = a.x / b.x;
    int y = a.y / b.y;
    int z = a.z / b.z;
    int w = a.w / b.w;
    return new ivec4(x,y,z,w);
  }
}

ivec2 idiv(ivec2 a, int arg) {
  return idiv(a,ivec2(arg,arg));
}

ivec3 idiv(ivec3 a, int arg) {
  return idiv(a,ivec3(arg,arg,arg));
}

ivec4 idiv(ivec4 a, int arg) {  
  return idiv(a,ivec4(arg,arg,arg,arg));
}



/**
Substraction
v 0.0.1
*/
/**
* return the resultat of vector substraction
*/
ivec2 isub(ivec2 a, ivec2 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    int x = a.x - b.x;
    int y = a.y - b.y;
    return new ivec2(x,y);
  }
}

ivec3 isub(ivec3 a, ivec3 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    int x = a.x - b.x;
    int y = a.y - b.y;
    int z = a.z - b.z;
    return new ivec3(x,y,z);
  }
}

ivec4 isub(ivec4 a, ivec4 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    int x = a.x - b.x;
    int y = a.y - b.y;
    int z = a.z - b.z;
    int w = a.w - b.w;
    return new ivec4(x,y,z,w);
  }
}

ivec2 isub(ivec2 a, int arg) {
  return isub(a,ivec2(arg,arg));
}

ivec3 isub(ivec3 a, int arg) {
  return isub(a,ivec3(arg,arg,arg));
}

ivec4 isub(ivec4 a, int arg) {  
  return isub(a,ivec4(arg,arg,arg,arg));
}




































/**
METHOD
Vec
v 1.0.0
*/
/**
Addition
v 0.0.4
*/
/**
* return the resultat of vector addition
*/
vec2 add(vec2 a, vec2 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    float x = a.x + b.x ;
    float y = a.y + b.y ;
    return new vec2(x,y) ;
  }
}

vec3 add(vec3 a, vec3 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    float x = a.x + b.x ;
    float y = a.y + b.y ;
    float z = a.z + b.z ;
    return new vec3(x,y,z)  ;
  }
}

vec4 add(vec4 a, vec4 b) {  
  if(a == null || b == null) {
    return null ;
  } else {
    float x = a.x + b.x ;
    float y = a.y + b.y ;
    float z = a.z + b.z ;
    float w = a.w + b.w ;
    return new vec4(x,y,z,w)  ;
  }
}
/**
* iVec arg
*/
vec2 add(ivec2 a, ivec2 b) {
  return add(vec2(a),vec2(b));
}

vec3 add(ivec3 a, ivec3 b) {
  return add(vec3(a),vec3(b));
}

vec4 add(ivec4 a, ivec4 b) {  
  return add(vec4(a),vec4(b));
}
/**
* float arg
*/
vec2 add(vec2 a, float arg) {
  return add(a,vec2(arg,arg));
}

vec3 add(vec3 a, float arg) {
  return add(a,vec3(arg,arg,arg));
}

vec4 add(vec4 a, float arg) {  
  return add(a,vec4(arg,arg,arg,arg));
}
/**
* iVec + float
*/

vec2 add(ivec2 a, float arg) {
  return add(vec2(a),vec2(arg,arg));
}

vec3 add(ivec3 a, float arg) {
  return add(vec3(a),vec3(arg,arg,arg));
}

vec4 add(ivec4 a, float arg) {  
  return add(vec4(a),vec4(arg,arg,arg,arg));
}




/**
Multiplication
v 0.0.4
*/
/**
* return the resultat of vector multiplication
*/
vec2 mult(vec2 a, vec2 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    float x = a.x * b.x;
    float y = a.y * b.y;
    return new vec2(x,y);
  }
}

vec3 mult(vec3 a, vec3 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    float x = a.x * b.x;
    float y = a.y * b.y;
    float z = a.z * b.z;
    return new vec3(x,y,z);
  }
}

vec4 mult(vec4 a, vec4 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    float x = a.x * b.x;
    float y = a.y * b.y;
    float z = a.z * b.z;
    float w = a.w * b.w;
    return new vec4(x,y,z,w);
  }
}
/**
* iVec arg
*/
vec2 mult(ivec2 a, ivec2 b) {
  return mult(vec2(a),vec2(b));
}

vec3 mult(ivec3 a, ivec3 b) {
  return mult(vec3(a),vec3(b));
}

vec4 mult(ivec4 a, ivec4 b) {  
  return mult(vec4(a),vec4(b));
}

/**
* float arg
*/
vec2 mult(vec2 a, float arg) {
  return mult(a,vec2(arg,arg));
}

vec3 mult(vec3 a, float arg) {
  return mult(a,vec3(arg,arg,arg));
}

vec4 mult(vec4 a, float arg) {  
  return mult(a,vec4(arg,arg,arg,arg));
}
/**
* iVec + float
*/
vec2 mult(ivec2 a, float arg) {
  return mult(vec2(a),vec2(arg,arg));
}

vec3 mult(ivec3 a, float arg) {
  return mult(vec3(a),vec3(arg,arg,arg));
}

vec4 mult(ivec4 a, float arg) {  
  return mult(vec4(a),vec4(arg,arg,arg,arg));
}




/**
Division
v 0.0.4
*/
/**
* return the resultat of vector division
*/
vec2 div(vec2 a, vec2 b) {
  if(a == null || b == null) {
    return null;
  } else {
    float x = a.x /b.x;
    float y = a.y /b.y;
    return new vec2(x,y);
  }
}

vec3 div(vec3 a, vec3 b) {
  if(a == null || b == null) {
    return null;
  } else {
    float x = a.x /b.x;
    float y = a.y /b.y;
    float z = a.z /b.z;
    return new vec3(x,y,z);
  }
}

vec4 div(vec4 a, vec4 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    float x = a.x /b.x;
    float y = a.y /b.y;
    float z = a.z /b.z;
    float w = a.w /b.w;
    return new vec4(x,y,z,w);
  }
}
/**
* iVec arg
*/
vec2 div(ivec2 a, ivec2 b) {
  return div(vec2(a),vec2(b));
}

vec3 div(ivec3 a, ivec3 b) {
  return div(vec3(a),vec3(b));
}

vec4 div(ivec4 a, ivec4 b) {  
  return div(vec4(a),vec4(b));
}
/**
* float arg
*/
vec2 div(vec2 a, float arg) {
  return div(a,vec2(arg,arg));
}

vec3 div(vec3 a, float arg) {
  return div(a,vec3(arg,arg,arg));
}

vec4 div(vec4 a, float arg) {  
  return div(a,vec4(arg,arg,arg,arg));
}
/**
* iVec + float
*/
vec2 div(ivec2 a, float arg) {
  return div(vec2(a),vec2(arg,arg));
}

vec3 div(ivec3 a, float arg) {
  return div(vec3(a),vec3(arg,arg,arg));
}

vec4 div(ivec4 a, float arg) {  
  return div(vec4(a),vec4(arg,arg,arg,arg));
}


/**
Substraction
v 0.0.5
*/
/**
* return the resultat of vector substraction
*/
vec2 sub(vec2 a, vec2 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    float x = a.x - b.x;
    float y = a.y - b.y;
    return new vec2(x,y);
  }
}

vec3 sub(vec3 a, vec3 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    float x = a.x - b.x;
    float y = a.y - b.y;
    float z = a.z - b.z;
    return new vec3(x,y,z);
  }
}

vec4 sub(vec4 a, vec4 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    float x = a.x - b.x;
    float y = a.y - b.y;
    float z = a.z - b.z;
    float w = a.w - b.w;
    return new vec4(x,y,z,w);
  }
}
/**
* iVec arg
*/
vec2 sub(ivec2 a, ivec2 b) {
  return sub(vec2(a),vec2(b));
}

vec3 sub(ivec3 a, ivec3 b) {
  return sub(vec3(a),vec3(b));
}

vec4 sub(ivec4 a, ivec4 b) {  
  return sub(vec4(a),vec4(b));
}
/**
* float arg
*/
vec2 sub(vec2 a, float arg) {
  return sub(a,vec2(arg,arg));
}

vec3 sub(vec3 a, float arg) {
  return sub(a,vec3(arg,arg,arg));
}

vec4 sub(vec4 a, float arg) {  
  return sub(a,vec4(arg,arg,arg,arg));
}
/**
* iVec + float
*/
vec2 sub(ivec2 a, float arg) {
  return sub(vec2(a),vec2(arg,arg));
}

vec3 sub(ivec3 a, float arg) {
  return sub(vec3(a),vec3(arg,arg,arg));
}

vec4 sub(ivec4 a, float arg) {  
  return sub(vec4(a),vec4(arg,arg,arg,arg));
}



/**
Cross
v 0.0.2
*/
vec3 cross(vec3 v1, vec3 v2) {
  if(v1 == null ||  v2 == null) {
    return null;
  } else {
    float crossX = v1.y * v2.z - v2.y * v1.z;
    float crossY = v1.z * v2.x - v2.z * v1.x;
    float crossZ = v1.x * v2.y - v2.x * v1.y;
    return vec3(crossX, crossY, crossZ);
  }
}
/**
* @deprecated "cross(vec3 v1, vec3 v2, vec3 target), can be deprecated in the future, need to be test"
*/
@Deprecated
vec3 cross(vec3 v1, vec3 v2, vec3 target) {
  println("cross(vec3 v1, vec3 v2, vec3 target), can be deprecated in the future, need to be test");
  if(v1 == null ||  v2 == null || target == null) {
    return null ;
  } else {
    float crossX = v1.y * v2.z - v2.y * v1.z;
    float crossY = v1.z * v2.x - v2.z * v1.x;
    float crossZ = v1.x * v2.y - v2.x * v1.y;

    if (target == null) {
      target = vec3(crossX, crossY, crossZ);
    } else {
      target.set(crossX, crossY, crossZ);
    }
    return target ;
  }  
}



/**
Equals
v 0.0.2
*/
/*
@Deprecated // use compare()
boolean equals(vec2 v_a, vec2 v_b) {
  return compare(v_a,v_b);
}

@Deprecated // use compare()
boolean equals(vec3 v_a, vec3 v_b) {
  return compare(v_a,v_b);
}

@Deprecated // use compare()
boolean equals(vec4 v_a, vec4 v_b) {
  return compare(v_a,v_b);
}

@Deprecated // use compare()
boolean equals(vec2 v_a, vec2 v_b, vec2 area) {
  return compare(v_a,v_b, area);
}

@Deprecated // use compare()
boolean equals(vec3 v_a, vec3 v_b, vec3 area) {
   return compare(v_a,v_b, area);
}

@Deprecated // use compare()
boolean equals(vec4 v_a, vec4 v_b, vec4 area) {
  return compare(v_a,v_b, area);
}
*/



/** 
* compare if the first vector is in the area of the second vector, 
* the area of the second vector is define by a Vec area, 
* that give the possibility of different size for each component
* @return boolean
* v 0.2.0
*/

boolean compare(ivec2 a, ivec2 b) {
  return compare(vec2(a),vec2(b));
}

boolean compare(ivec3 a, ivec3 b) {
  return compare(vec3(a),vec3(b));
}

boolean compare(ivec4 a, ivec4 b) {
  return compare(vec4(a),vec4(b));
}


boolean compare(vec2 a, vec2 b) {
  if(a == null || b == null) {
    println("Is not possible to compare", a, "to", b) ;
    return false ;
  } else {
    return compare(vec4(a.x,a.y,0,0),vec4(b.x,b.y,0,0)) ;
  }
}

// vec3 compare
boolean compare(vec3 a, vec3 b) {
    if(a == null || b == null) {
    println("Is not possible to compare", a, "to", b) ;
    return false ;
  } else {
    return compare(vec4(a.x,a.y,a.z, 0),vec4(b.x,b.y,b.z, 0)) ;
  }
}
// vec4 compare
boolean compare(vec4 a, vec4 b) {
  if(a != null && b != null ) {
    if((a.x == b.x) && (a.y == b.y) && (a.z == b.z) && (a.w == b.w)) {
      return true ; 
    } else {
      return false ;
    }
  } else {
    return false ;
  } 
}


/**
* compare with area
*/
boolean compare(ivec2 a, ivec2 b, ivec2 area) {
  return compare(vec2(a),vec2(b),vec2(area));
}

boolean compare(ivec3 a, ivec3 b, ivec3 area) {
  return compare(vec3(a),vec3(b),vec3(area));
}

boolean compare(ivec4 a, ivec4 b, ivec4 area) {
  return compare(vec4(a),vec4(b),vec4(area));
}

boolean compare(vec2 a, vec2 b, vec2 area) {
  if(a == null || b == null || area == null) {
    println("Is not possible to compare", a, "with", b, "with", area) ;
    return false ;
  } else {
    return compare(vec4(a.x,a.y, 0, 0),vec4(b.x,b.y, 0, 0),vec4(area.x, area.y, 0, 0)) ;
  }
}

boolean compare(vec3 a, vec3 b, vec3 area) {
    if(a == null || b == null || area == null) {
    println("Is not possible to compare", a, "with", b, "with", area) ;
    return false ;
  } else {
    return compare(vec4(a.x,a.y,a.z, 0),vec4(b.x,b.y,b.z, 0),vec4(area.x, area.y, area.z, 0)) ;
  }
}

boolean compare(vec4 a, vec4 b, vec4 area) {
  if(a != null && b != null && area != null ) {
    if(    (a.x >= b.x -area.x && a.x <= b.x +area.x) 
        && (a.y >= b.y -area.y && a.y <= b.y +area.y) 
        && (a.z >= b.z -area.z && a.z <= b.z +area.z) 
        && (a.w >= b.w -area.w && a.w <= b.w +area.w)) {
            return true ; 
    } else {
      return false ;
    }
  } else {
    return false ;
  }
}









/**
Map
*/
/**
* return mapping vector
* @return Vec
*/
vec2 map(vec2 v,float minIn, float maxIn, float minOut, float maxOut) {
  if(v != null) {
    float x = map(v.x, minIn, maxIn, minOut, maxOut) ;
    float y = map(v.y, minIn, maxIn, minOut, maxOut) ;
    return new vec2(x,y) ;
  } else return null ;
}


vec3 map(vec3 v,float minIn, float maxIn, float minOut, float maxOut) {
  if(v != null) {
    float x = map(v.x, minIn, maxIn, minOut, maxOut) ;
    float y = map(v.y, minIn, maxIn, minOut, maxOut) ;
    float z = map(v.z, minIn, maxIn, minOut, maxOut) ;
    return new vec3(x,y,z) ;
  } else return null ;
}


vec4 map(vec4 v,float minIn, float maxIn, float minOut, float maxOut) {
  if(v != null) {
    float x = map(v.x, minIn, maxIn, minOut, maxOut) ;
    float y = map(v.y, minIn, maxIn, minOut, maxOut) ;
    float z = map(v.z, minIn, maxIn, minOut, maxOut) ;
    float w = map(v.w, minIn, maxIn, minOut, maxOut) ;
    return new vec4(x,y,z,w) ;
  } else return null ;
}


/**
Magnitude or length
*/
/**
* @return float
*/
// mag vec2
float mag(vec2 a) {
  float x = a.x*a.x ;
  float y = a.y *a.y ;
  return sqrt(x+y) ;
}

float mag(vec2 a, vec2 b) {
  // same result than dist
  float x = (b.x -a.x)*(b.x -a.x) ;
  float y = (b.y -a.y)*(b.y -a.y) ;
  return sqrt(x+y) ;
}
// mag vec3
float mag(vec3 a) {
  float x = a.x*a.x ;
  float y = a.y *a.y ;
  float z = a.z *a.z ;
  return sqrt(x+y+z) ;
}

float mag(vec3 a, vec3 b) {
  // same result than dist
  float x = (b.x -a.x)*(b.x -a.x) ;
  float y = (b.y -a.y)*(b.y -a.y) ;
  float z = (b.z -a.z)*(b.z -a.z) ;
  return sqrt(x+y+z) ;
}
// mag vec4
float mag(vec4 a) {
  float x = a.x*a.x ;
  float y = a.y*a.y ;
  float z = a.z*a.z ;
  float w = a.w*a.w ;
  return sqrt(x+y+z+w) ;
}

float mag(vec4 a, vec4 b) {
  // same result than dist
  float x = (b.x -a.x)*(b.x -a.x) ;
  float y = (b.y -a.y)*(b.y -a.y) ;
  float z = (b.z -a.z)*(b.z -a.z) ;
  float w = (b.w -a.w)*(b.w -a.w) ;
  return sqrt(x+y+z+w) ;
}



/**
Distance
v 0.0.2
*/
/**
* return the distance beatwen two vectors
* @return float
*/
float dist(vec2 a, vec2 b) {
  if(a != null && b != null) {
    float dx = a.x - b.x;
    float dy = a.y - b.y;
    return (float) Math.sqrt(dx*dx + dy*dy);
  } else return Float.NaN ;
    
}
float dist(vec3 a, vec3 b) {
  if(a != null && b != null) {
    float dx = a.x - b.x;
    float dy = a.y - b.y;
    float dz = a.z - b.z;
    return (float) Math.sqrt(dx*dx + dy*dy + dz*dz);
  } else return Float.NaN ;
}

float dist(vec4 a, vec4 b) {
  if(a != null && b != null) {
    float dx = a.x - b.x;
    float dy = a.y - b.y;
    float dz = a.z - b.z;
    float dw = a.w - b.w;
    return (float) Math.sqrt(dx*dx + dy*dy + dz*dz + dw*dw);
  } else return Float.NaN ;
}


/**
Deprecated Middle
*/
/**
* return the middle between two Vector
* @return Vec
*/
vec2 middle(vec2 a, vec2 b)  {
  vec2 middle ;
  middle = add(a,b);
  middle.div(2) ;
  println("The method middle is deprecated instead use barycenter(Vec... arg)") ;
  return middle ;
}

vec2 middle(vec2 [] list)  {
  vec2 middle = vec2() ;
  for (int i = 0 ; i < list.length ; i++) {
    middle.add(list[i]);
  }
  middle.div(list.length) ;
  println("The method middle is deprecated instead use barycenter(Vec... arg)") ;
  return middle ;
}

vec3 middle(vec3 a, vec3 b) {
  vec3 middle ;
  middle = add(a,b);
  middle.div(2) ;
  return middle ;
}

vec3 middle(vec3 [] list)  {
  vec3 middle = vec3() ;
  for (int i = 0 ; i < list.length ; i++) {
    middle.add(list[i]);
  }
  middle.div(list.length) ;
  println("The method middle is deprecated instead use barycenter(Vec... arg)") ;
  return middle ;
}

vec4 middle(vec4 a, vec4 b)  {
  vec4 middle ;
  middle = add(a,b);
  middle.div(2) ;
  println("The method middle is deprecated instead use barycenter(Vec... arg)") ;
  return middle ;
}

vec4 middle(vec4 [] list)  {
  vec4 middle = vec4() ;
  for (int i = 0 ; i < list.length ; i++) {
    middle.add(list[i]);
  }
  middle.div(list.length) ;
  println("The method middle is deprecated instead use barycenter(Vec... arg)") ;
  return middle ;
}


/**
barycenter
*/
vec2 barycenter(vec2... v) {
  int div_num = v.length ;
  vec2 sum = vec2() ;
  for(int i = 0 ; i < div_num ; i++) {
    sum.add(v[i]) ;
  }
  return sum.div(div_num) ;
}

 
vec3 barycenter(vec3... v) {
  int div_num = v.length ;
  vec3 sum = vec3() ;
  for(int i = 0 ; i < div_num ; i++) {
    sum.add(v[i]) ;
  }
  return sum.div(div_num) ;
}

vec4 barycenter(vec4... v) {
  int div_num = v.length ;
  vec4 sum = vec4() ;
  for(int i = 0 ; i < div_num ; i++) {
    sum.add(v[i]) ;
  }
  return sum.div(div_num) ;
}





/**
Jitter
v 0.0.2
*/
// vec2
vec2 jitter_2D(int range) {
  return jitter_2D(range, range) ;
}
vec2 jitter_2D(vec2 range) {
  return jitter_2D((int)range.x, (int)range.y) ;
}
vec2 jitter_2D(int range_x, int range_y) {
  vec2 jitter = vec2() ;
  jitter.x = random_next_gaussian(range_x, 2);
  jitter.y = random_next_gaussian(range_y, 2);
  return jitter ;
}
// vec3
vec3 jitter_3D(int range) {
  return jitter_3D(range, range, range) ;
}
vec3 jitter_3D(vec3 range) {
  return jitter_3D((int)range.x, (int)range.y, (int)range.z) ;
}
vec3 jitter_3D(int range_x, int range_y, int range_z) {
  vec3 jitter = vec3() ;
  jitter.x = random_next_gaussian(range_x, 2);
  jitter.y = random_next_gaussian(range_y, 2);
  jitter.z = random_next_gaussian(range_z, 2);
  return jitter ;
}
// vec4
vec4 jitter_4D(int range) {
  return jitter_4D(range, range, range, range) ;
}
vec4 jitter_4D(vec4 range) {
  return jitter_4D((int)range.x, (int)range.y, (int)range.z, (int)range.w) ;
}
vec4 jitter_4D(int range_x, int range_y, int range_z, int range_w) {
  vec4 jitter = vec4() ;
  jitter.x = random_next_gaussian(range_x, 2);
  jitter.y = random_next_gaussian(range_y, 2);
  jitter.z = random_next_gaussian(range_z, 2);
  jitter.w = random_next_gaussian(range_w, 2);
  return jitter ;
}






/**
Normalize
*/
// VEC 2 from angle
vec2 norm_rad(float angle) {
  float x = (float)Math.cos(angle) ;
  float y = (float)Math.sin(angle) ;
  return vec2(x,y) ;
}

vec2 norm_deg(float angle) {
  angle = radians(angle) ;
  float x = (float)Math.cos(angle) ;
  float y = (float)Math.sin(angle) ;
  return vec2(x,y) ;
}


// normalize direction
vec2 norm_dir(String type, float direction) {
  float x, y = 0 ;
  if(type.equals("DEG")) {
    float angle = TWO_PI/360.;
    direction = 360-direction;
    direction += 180;
    x = sin(angle *direction) ;
    y = cos(angle *direction);
  } else if (type.equals("RAD")) {
    x = sin(direction) ;
    y = cos(direction);
  } else {
    println("the type must be 'RAD' for radians or 'DEG' for degrees") ;
    x = 0 ;
    y = 0 ;
  }
  return new vec2(x,y) ;
}





























/**
New Vec, iVec and bVec
v 0.0.3
*/

/**
Return a new bVec
*/
/**
* @return bVec
*/
/**
bvec2
*/
bvec2 bvec2() {
  return new bvec2(false,false) ;
}

bvec2 bvec2(boolean b) {
  return new bvec2(b,b);
}

bvec2 bvec2(boolean x, boolean y) { 
  return new bvec2(x,y) ;
}

bvec2 bvec2(boolean [] array) {
  if(array.length == 1) {
    return new bvec2(array[0],array[0]);
  } else if (array.length > 1) {
    return new bvec2(array[0],array[1]);
  } else {
    return null;
  }
}

bvec2 bvec2(bvec b) {
  if(b == null) {
    println("bVec null, instead 'false' is used to build bVec") ;
    return new bvec2(false,false) ;
  } else if(b instanceof bvec5 || b instanceof bvec6) {
    return new bvec2(b.a(),b.b()) ;
  } else {
    return new bvec2(b.x,b.y) ;
  }
}

/**
ivec3
*/
bvec3 bvec3() {
  return new bvec3(false,false,false) ;
}

bvec3 bvec3(boolean b) {
  return new bvec3(b,b,b);
}

bvec3 bvec3(boolean x, boolean y, boolean z) { 
  return new bvec3(x,y,z) ;
}

bvec3 bvec3(boolean [] array) {
  if(array.length == 1) {
    return new bvec3(array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new bvec3(array[0],array[1],false);
  } else if (array.length > 2) {
    return new bvec3(array[0],array[1],array[2]);
  } else {
    return null;
  }
}

bvec3 bvec3(bvec b) {
  if(b == null) {
    println("bVec null, instead 'false' is used to build bVec") ;
    return new bvec3(false,false,false) ;
  } else {
    return new bvec3(b.x,b.y,b.z) ;
  }
}

/**
ivec4
*/
bvec4 bvec4() {
  return new bvec4(false,false,false,false) ;
}

bvec4 bvec4(boolean b) {
  return new bvec4(b,b,b,b);
}

bvec4 bvec4(boolean x, boolean y, boolean z, boolean w) { 
  return new bvec4(x,y,z,w) ;
}

bvec4 bvec4(boolean [] array) {
  if(array.length == 1) {
    return new bvec4(array[0],array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new bvec4(array[0],array[1],false,false);
  } else if (array.length == 3) {
    return new bvec4(array[0],array[1],array[2],false);
  } else if (array.length > 3) {
    return new bvec4(array[0],array[1],array[2],array[3]);
  } else {
    return null;
  }
}

bvec4 bvec4(bvec b) {
  if(b == null) {
    println("bVec null, instead 'false' is used to build bVec") ;
    return new bvec4(false,false,false,false) ;
  } else {
    return new bvec4(b.x,b.y,b.z,b.w) ;
  }
}

/**
ivec5
*/
bvec5 bvec5() {
  return new bvec5(false,false,false,false,false) ;
}

bvec5 bvec5(boolean b) {
  return new bvec5(b,b,b,b,b);
}

bvec5 bvec5(boolean a, boolean b, boolean c, boolean d, boolean e) { 
  return new bvec5(a,b,c,d,e) ;
}

bvec5 bvec5(boolean [] array) {
  if(array.length == 1) {
    return new bvec5(array[0],array[0],array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new bvec5(array[0],array[1],false,false,false);
  } else if (array.length == 3) {
    return new bvec5(array[0],array[1],array[2],false,false);
  } else if (array.length == 4) {
    return new bvec5(array[0],array[1],array[2],array[3],false);
  } else if (array.length >4) {
    return new bvec5(array[0],array[1],array[2],array[3],array[4]);
  } else {
    return null;
  }
}

bvec5 bvec5(bvec b) {
  if(b == null) {
    println("bVec null, instead 'false' is used to build bVec") ;
    return new bvec5(false,false,false,false,false) ;
  } else if(b instanceof bvec5 || b instanceof bvec6) {
    return new bvec5(b.a(),b.b(),b.c(),b.d(),b.e) ;
  } else {
    return new bvec5(b.x,b.y,b.z,b.w,false) ;
  }
}

/**
bvec6
*/
bvec6 bvec6() {
  return new bvec6(false,false,false,false,false,false) ;
}

bvec6 bvec6(boolean b) {
  return new bvec6(b,b,b,b,b,b);
}

bvec6 bvec6(boolean a, boolean b, boolean c, boolean d, boolean e, boolean f) { 
  return new bvec6(a,b,c,d,e,f) ;
}

bvec6 bvec6(boolean [] array) {
  if(array.length == 1) {
    return new bvec6(array[0],array[0],array[0],array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new bvec6(array[0],array[1],false,false,false,false);
  } else if (array.length == 3) {
    return new bvec6(array[0],array[1],array[2],false,false,false);
  } else if (array.length == 4) {
    return new bvec6(array[0],array[1],array[2],array[3],false,false);
  } else if (array.length == 5) {
    return new bvec6(array[0],array[1],array[2],array[3],array[4],false);
  }  else if (array.length > 5) {
    return new bvec6(array[0],array[1],array[2],array[3],array[4],array[5]);
  } else {
    return null;
  }
}

bvec6 bvec6(bvec b) {
  if(b== null) {
    println("bVec null, instead 'false' is used to build bVec") ;
    return new bvec6(false,false,false,false,false,false) ;
  } else if(b instanceof bvec5 || b instanceof bvec6) {
    return new bvec6(b.a(),b.b(),b.c(),b.d(),b.e,b.f) ;
  } else {
    return new bvec6(b.x,b.y,b.z,b.w,false,false) ;
  }
}

























/**
Return a new iVec
*/
/**
ivec2
*/
ivec2 ivec2() {
  return ivec2(0) ;
}

ivec2 ivec2(int v) {
  return new ivec2(v,v);
}

ivec2 ivec2(int x, int y) { 
  return new ivec2(x,y) ;
}


ivec2 ivec2(int [] array) {
  if(array.length == 1) {
    return new ivec2(array[0],array[0]);
  } else if (array.length > 1) {
    return new ivec2(array[0],array[1]);
  } else {
    return null;
  }
}

ivec2 ivec2(ivec p) {
  if(p == null) {
    println("iVec null, instead '0' is used to build iVec") ;
    return new ivec2(0,0) ;
  } else {
    return new ivec2(p.x,p.y) ;
  }
}

ivec2 ivec2(float v) {
  return new ivec2(int(v),int(v));
}

ivec2 ivec2(float x, float y) { 
  return new ivec2(int(x),int(y));
}

ivec2 ivec2(float [] array) {
  if(array.length == 1) {
    return new ivec2(int(array[0]),int(array[0]));
  } else if (array.length > 1) {
    return new ivec2(int(array[0]),int(array[1]));
  } else {
    return null;
  }
}

ivec2 ivec2(vec p) {
  if(p == null) {
    println("Vec null, instead '0' is used to build iVec") ;
    return new ivec2(0,0) ;
  } else {
    return new ivec2(int(p.x),int(p.y));
  }
}


ivec2 ivec2(PGraphics media) {
  if(media != null) {
    return new ivec2(media.width,media.height);
  } else {
    return null;
  }
}

ivec2 ivec2(PImage media) {
  if(media != null) {
    return new ivec2(media.width,media.height);
  } else {
    return null;
  }
}

/**
ivec3
*/
ivec3 ivec3() {
  return ivec3(0) ;
}

ivec3 ivec3(int v) {
  return new ivec3(v,v,v);
}

ivec3 ivec3(int x, int y, int z) { 
  return new ivec3(x,y,z) ;
}

ivec3 ivec3(int [] array) {
  if(array.length == 1) {
    return new ivec3(array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new ivec3(array[0],array[1],0);
  } else if (array.length > 2) {
    return new ivec3(array[0],array[1],array[2]);
  } else {
    return null;
  }
}

ivec3 ivec3(ivec p) {
  if(p == null) {
    println("iVec null, instead '0' is used to build iVec") ;
    return new ivec3(0,0,0) ;
  } else {
    return new ivec3(p.x,p.y,p.z) ;
  }
}

ivec3 ivec3(float v) {
  return new ivec3(int(v),int(v),int(v));
}

ivec3 ivec3(float x, float y,float z) { 
  return new ivec3(int(x),int(y),int(z));
}

ivec3 ivec3(float [] array) {
  if(array.length == 1) {
    return new ivec3(int(array[0]),int(array[0]),int(array[0]));
  } else if (array.length == 2) {
    return new ivec3(int(array[0]),int(array[1]),0);
  } else if (array.length > 2) {
    return new ivec3(int(array[0]),int(array[1]),int(array[2]));
  } else {
    return null;
  }
}

ivec3 ivec3(vec p) {
  if(p == null) {
    println("Vec null, instead '0' is used to build iVec") ;
    return new ivec3(0,0,0) ;
  } else {
    return new ivec3(int(p.x),int(p.y),int(p.z));
  }
}

/**
ivec4
*/
ivec4 ivec4() {
  return ivec4(0) ;
}

ivec4 ivec4(int v) {
  return new ivec4(v,v,v,v);
}

ivec4 ivec4(int x, int y, int z, int w) { 
  return new ivec4(x,y,z,w) ;
}

ivec4 ivec4(int [] array) {
  if(array.length == 1) {
    return new ivec4(array[0],array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new ivec4(array[0],array[1],0,0);
  } else if (array.length == 3) {
    return new ivec4(array[0],array[1],array[2],0);
  } else if (array.length > 3) {
    return new ivec4(array[0],array[1],array[2],array[3]);
  } else {
    return null;
  }
}

ivec4 ivec4(ivec p) {
  if(p == null) {
    println("iVec null, instead '0' is used to build iVec") ;
    return new ivec4(0,0,0,0) ;
  } else {
    return new ivec4(p.x,p.y,p.z,p.w) ;
  }
}

ivec4 ivec4(float v) {
  return new ivec4(int(v),int(v),int(v),int(v));
}

ivec4 ivec4(float x, float y, float z, float w) { 
  return new ivec4(int(x),int(y),int(z),int(w));
}

ivec4 ivec4(float [] array) {
  if(array.length == 1) {
    return new ivec4(int(array[0]),int(array[0]),int(array[0]),int(array[0]));
  } else if (array.length == 2) {
    return new ivec4(int(array[0]),int(array[1]),0,0);
  } else if (array.length == 3) {
    return new ivec4(int(array[0]),int(array[1]),int(array[2]),0);
  } else if (array.length > 3) {
    return new ivec4(int(array[0]),int(array[1]),int(array[2]),int(array[3]));
  } else {
    return null;
  }
}


ivec4 ivec4(vec p) {
  if(p == null) {
    println("Vec null, instead '0' is used to build iVec") ;
    return new ivec4(0,0,0,0) ;
  } else {
    return new ivec4(int(p.x),int(p.y),int(p.z),int(p.w));
  }
}

/**
ivec5
*/
ivec5 ivec5() {
  return ivec5(0) ;
}

ivec5 ivec5(int v) {
  return new ivec5(v,v,v,v,v);
}

ivec5 ivec5(int a, int b, int c, int d, int e) { 
  return new ivec5(a,b,c,d,e) ;
}

ivec5 ivec5(int [] array) {
  if(array.length == 1) {
    return new ivec5(array[0],array[0],array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new ivec5(array[0],array[1],0,0,0);
  } else if (array.length == 3) {
    return new ivec5(array[0],array[1],array[2],0,0);
  } else if (array.length == 4) {
    return new ivec5(array[0],array[1],array[2],array[3],0);
  } else if (array.length > 4) {
    return new ivec5(array[0],array[1],array[2],array[3],array[4]);
  } else {
    return null;
  }
}

ivec5 ivec5(ivec p) {
  if(p == null) {
    println("iVec null, instead '0' is used to build iVec") ;
    return new ivec5(0,0,0,0,0) ;
  } else if(p instanceof ivec5 || p instanceof ivec6) {
    return new ivec5(p.a(),p.b(),p.c(),p.d(),p.e) ;
  } else {
    return new ivec5(p.x,p.y,p.z,p.w,0) ;
  }
}

ivec5 ivec5(vec p) {
  if(p == null) {
    println("Vec null, instead '0' is used to build iVec") ;
    return new ivec5(0,0,0,0,0) ;
  } else if(p instanceof vec5 || p instanceof vec6) {
    return new ivec5(int(p.a()),int(p.b()),int(p.c()),int(p.d()),int(p.e));
  } else {
    return new ivec5(int(p.x),int(p.y),int(p.z),int(p.w),0);
  }
}

/**
ivec6
*/
ivec6 ivec6() {
  return ivec6(0) ;
}

ivec6 ivec6(int v) {
  return new ivec6(v,v,v,v,v,v);
}

ivec6 ivec6(int a, int b, int c, int d, int e, int f) { 
  return new ivec6(a,b,c,d,e,f) ;
}

ivec6 ivec6(int [] array) {
  if(array.length == 1) {
    return new ivec6(array[0],array[0],array[0],array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new ivec6(array[0],array[1],0,0,0,0);
  } else if (array.length == 3) {
    return new ivec6(array[0],array[1],array[2],0,0,0);
  } else if (array.length == 4) {
    return new ivec6(array[0],array[1],array[2],array[3],0,0);
  } else if (array.length == 5) {
    return new ivec6(array[0],array[1],array[2],array[3],array[4],0);
  }  else if (array.length > 5) {
    return new ivec6(array[0],array[1],array[2],array[3],array[4],array[5]);
  } else {
    return null;
  }
}

ivec6 ivec6(ivec p) {
  if(p == null) {
    println("iVec null, instead '0' is used to build iVec") ;
    return new ivec6(0,0,0,0,0,0) ;
  } else if(p instanceof ivec5 || p instanceof ivec6) {
    return new ivec6(p.a(),p.b(),p.c(),p.d(),p.e,p.f) ;
  } else {
    return new ivec6(p.x,p.y,p.z,p.w,0,0) ;
  }
}

ivec6 ivec6(vec p) {
  if(p == null) {
    println("Vec null, instead '0' is used to build iVec") ;
    return new ivec6(0,0,0,0,0,0) ;
  } else if(p instanceof vec5 || p instanceof vec6) {
    return new ivec6(int(p.a()),int(p.b()),int(p.c()),int(p.d()),int(p.e),int(p.f));
  } else {
    return new ivec6(int(p.x),int(p.y),int(p.z),int(p.w),0,0);
  }
}
























/**
Return a new Vec
*/
/**
Vec 2
*/
vec2 vec2() {
  return new vec2(0,0) ;
}

vec2 vec2(float x, float y) { 
  return new vec2(x,y) ;
}

vec2 vec2(float [] array) {
  if(array.length == 1) {
    return new vec2(array[0],array[0]);
  } else if (array.length > 1) {
    return new vec2(array[0],array[1]);
  } else {
    return null;
  }
}

vec2 vec2(int [] array) {
  if(array.length == 1) {
    return new vec2(array[0],array[0]);
  } else if (array.length > 1) {
    return new vec2(array[0],array[1]);
  } else {
    return null;
  }
}

vec2 vec2(float v) {
  return new vec2(v,v) ;
}

vec2 vec2(PVector p) {
  if(p == null) {
    return new vec2(0,0);
  } else {
    return new vec2(p.x, p.y);
  }
}

vec2 vec2(vec p) {
  if(p == null) {
    return new vec2(0,0);
  } else {
    return new vec2(p.x,p.y);
  }
}


vec2 vec2(ivec p) {
  if(p == null) {
    return new vec2(0,0);
  } else {
    return new vec2(p.x,p.y);
  }
}




vec2 vec2(PGraphics media) {
  if(media != null) {
    return new vec2(media.width,media.height);
  } else {
    return null;
  }
}

vec2 vec2(PImage media) {
  if(media != null) {
    return new vec2(media.width,media.height);
  } else {
    return null;
  }
}
/**
Vec 3
*/
vec3 vec3() {
  return new vec3(0,0,0) ;
}

vec3 vec3(float x, float y, float z) {
  return new vec3(x,y,z);
}

vec3 vec3(float [] array) {
  if(array.length == 1) {
    return new vec3(array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new vec3(array[0],array[1],0);
  } else if (array.length > 2) {
    return new vec3(array[0],array[1],array[2]);
  } else {
    return null;
  }
}

vec3 vec3(int [] array) {
  if(array.length == 1) {
    return new vec3(array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new vec3(array[0],array[1],0);
  } else if (array.length > 2) {
    return new vec3(array[0],array[1],array[2]);
  } else {
    return null;
  }
}

vec3 vec3(float v) {
  return new vec3(v,v,v);
}

vec3 vec3(PVector p) {
  if(p == null) {
    return new vec3(0,0,0);
  } else {
    return new vec3(p.x, p.y, p.z);
  }
}

vec3 vec3(vec p) {
  if(p == null) {
    return new vec3(0,0,0);
  } else {
    return new vec3(p.x,p.y,p.z);
  }
}

vec3 vec3(ivec p) {
  if(p == null) {
    return new vec3(0,0,0);
  } else {
    return new vec3(p.x,p.y,p.z);
  }
}



/**
Vec 4
*/
vec4 vec4() {
  return new vec4(0,0,0,0);
}

vec4 vec4(float x, float y, float z, float w) {
  return new vec4(x,y,z,w);
}

vec4 vec4(float [] array) {
  if(array.length == 1) {
    return new vec4(array[0],array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new vec4(array[0],array[1],0,0);
  } else if (array.length == 3) {
    return new vec4(array[0],array[1],array[2],0);
  } else if (array.length > 3) {
    return new vec4(array[0],array[1],array[2],array[3]);
  } else {
    return null;
  }
}

vec4 vec4(int [] array) {
  if(array.length == 1) {
    return new vec4(array[0],array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new vec4(array[0],array[1],0,0);
  } else if (array.length == 3) {
    return new vec4(array[0],array[1],array[2],0);
  } else if (array.length > 3) {
    return new vec4(array[0],array[1],array[2],array[3]);
  } else {
    return null;
  }
}

vec4 vec4(float v) {
  return new vec4(v,v,v,v);
}

vec4 vec4(PVector p) {
  if(p == null) {
    return new vec4(0,0,0,0);
  } else {
    return new vec4(p.x, p.y, p.z, 0);
  }
}
// build with Vec
vec4 vec4(vec p) {
  if(p == null) {
    return new vec4(0,0,0,0);
  } else {
    return new vec4(p.x,p.y,p.z,p.w);
  }
}

vec4 vec4(ivec p) {
  if(p == null) {
    return new vec4(0,0,0,0);
  } else {
    return new vec4(p.x,p.y,p.z,p.w);
  }
}



/**
Vec 5
*/
vec5 vec5() {
  return new vec5(0,0,0,0,0);
}

vec5 vec5(float a, float b, float c, float d, float e) {
  return new vec5(a,b,c,d,e);
}

vec5 vec5(float [] array) {
  if(array.length == 1) {
    return new vec5(array[0],array[0],array[0],array[0],array[0]);
  } else if (array.length == 2){
    return new vec5(array[0],array[1],0,0,0) ;
  } else if (array.length == 3){
    return new vec5(array[0],array[1],array[2],0,0) ;
  } else if (array.length == 4){
    return new vec5(array[0],array[1],array[2],array[3],0) ;
  }  else if (array.length > 4){
    return new vec5(array[0],array[1],array[2],array[3],array[4]) ;
  } else {
    return null;
  }
}

vec5 vec5(int [] array) {
  if(array.length == 1) {
    return new vec5(array[0],array[0],array[0],array[0],array[0]);
  } else if (array.length == 2){
    return new vec5(array[0],array[1],0,0,0) ;
  } else if (array.length == 3){
    return new vec5(array[0],array[1],array[2],0,0) ;
  } else if (array.length == 4){
    return new vec5(array[0],array[1],array[2],array[3],0) ;
  }  else if (array.length > 4){
    return new vec5(array[0],array[1],array[2],array[3],array[4]) ;
  } else {
    return null;
  }
}

vec5 vec5(float v) {
  return new vec5(v,v,v,v,v);
}

vec5 vec5(PVector p) {
  if(p == null) {
    return new vec5(0,0,0,0,0);
  } else {
    return new vec5(p.x, p.y, p.z, 0,0);
  }
}
// build with Vec
vec5 vec5(vec p) {
  if(p == null) {
    return new vec5(0,0,0,0,0);
  } else if(p instanceof vec5 || p instanceof vec6) {
    return new vec5(p.a(),p.b(),p.c(),p.d(),p.e);
  } else {
    return new vec5(p.x,p.y,p.z,p.w,p.e);
  }
}

vec5 vec5(ivec p) {
  if(p == null) {
    return new vec5(0,0,0,0,0);
  }  else if(p instanceof ivec5 || p instanceof ivec6) {
    return new vec5(p.a(),p.b(),p.c(),p.d(),p.e);
  } else {
    return new vec5(p.x,p.y,p.z,p.w,p.e);
  }
}


/**
Vec 6
*/
vec6 vec6() {
  return new vec6(0,0,0,0,0,0) ;
}

vec6 vec6(float a, float b, float c, float d, float e, float f) {
  return new vec6(a,b,c,d,e,f);
}

vec6 vec6(float [] array) {
  if(array.length == 1) {
    return new vec6(array[0],array[0],array[0],array[0],array[0],array[0]);
  } else if (array.length == 2){
    return new vec6(array[0],array[1],0,0,0,0) ;
  } else if (array.length == 3){
    return new vec6(array[0],array[1],array[2],0,0,0) ;
  } else if (array.length == 4){
    return new vec6(array[0],array[1],array[2],array[3],0,0) ;
  } else if (array.length == 5){
    return new vec6(array[0],array[1],array[2],array[3],array[4],0) ;
  }  else if (array.length > 5){
    return new vec6(array[0],array[1],array[2],array[3],array[4],array[5]) ;
  } else {
    return null;
  }
}

vec6 vec6(int [] array) {
  if(array.length == 1) {
    return new vec6(array[0],array[0],array[0],array[0],array[0],array[0]);
  } else if (array.length == 2){
    return new vec6(array[0],array[1],0,0,0,0) ;
  } else if (array.length == 3){
    return new vec6(array[0],array[1],array[2],0,0,0) ;
  } else if (array.length == 4){
    return new vec6(array[0],array[1],array[2],array[3],0,0) ;
  } else if (array.length == 5){
    return new vec6(array[0],array[1],array[2],array[3],array[4],0) ;
  }  else if (array.length > 5){
    return new vec6(array[0],array[1],array[2],array[3],array[4],array[5]) ;
  } else {
    return null;
  }
}

vec6 vec6(float v) {
  return new vec6(v,v,v,v,v,v);
}
vec6 vec6(PVector p) {
  if(p == null) {
    return new vec6(0,0,0,0,0,0);
  } else {
    return new vec6(p.x, p.y, p.z, 0,0,0);
  }
}

// build with vec
vec6 vec6(vec p) {
  if(p == null) {
    return new vec6(0,0,0,0,0,0);
  } else if(p instanceof vec5 || p instanceof vec6) {
    return new vec6(p.a(),p.b(),p.c(),p.d(),p.e,p.f);
  } else {
    return new vec6(p.x,p.y,p.z,p.w,p.e,p.f);
  }
}

vec6 vec6(ivec p) {
  if(p == null) {
    return new vec6(0,0,0,0,0,0) ;
  } else if(p instanceof ivec5 || p instanceof ivec6) {
    return new vec6(p.a(),p.b(),p.c(),p.d(),p.e,p.f);
  } else {
    return new vec6(p.x,p.y,p.z,p.w,p.e,p.f);
  }
}












