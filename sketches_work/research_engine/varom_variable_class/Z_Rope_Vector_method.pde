/**
Vec, iVec and bVec method
v 0.1.0
* Copyleft (c) 2018-2018
* Stan le Punk > http://stanlepunk.xyz/
Rope – Romanesco Processing Environment: 2015–2018
* @author Stan le Punk
* @see https://github.com/StanLepunK/Rope
*/




/**
Addition
v 0.0.4
*/
/**
* return the resultat of vector addition
*/
iVec2 iadd(iVec2 a, iVec2 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    int x = a.x + b.x ;
    int y = a.y + b.y ;
    return new iVec2(x,y) ;
  }
}

iVec3 iadd(iVec3 a, iVec3 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    int x = a.x + b.x ;
    int y = a.y + b.y ;
    int z = a.z + b.z ;
    return new iVec3(x,y,z)  ;
  }
}

iVec4 iadd(iVec4 a, iVec4 b) {  
  if(a == null || b == null) {
    return null ;
  } else {
    int x = a.x + b.x ;
    int y = a.y + b.y ;
    int z = a.z + b.z ;
    int w = a.w + b.w ;
    return new iVec4(x,y,z,w)  ;
  }
}

iVec2 iadd(iVec2 a, int arg) {
  return iadd(a,iVec2(arg,arg));
}

iVec3 iadd(iVec3 a, int arg) {
  return iadd(a,iVec3(arg,arg,arg));
}

iVec4 iadd(iVec4 a, int arg) {  
  return iadd(a,iVec4(arg,arg,arg,arg));
}




/**
Multiplication
v 0.0.1
*/
/**
* return the resultat of vector multiplication
*/
iVec2 imult(iVec2 a, iVec2 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    int x = a.x * b.x;
    int y = a.y * b.y;
    return new iVec2(x,y);
  }
}

iVec3 imult(iVec3 a, iVec3 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    int x = a.x * b.x;
    int y = a.y * b.y;
    int z = a.z * b.z;
    return new iVec3(x,y,z);
  }
}

iVec4 imult(iVec4 a, iVec4 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    int x = a.x * b.x;
    int y = a.y * b.y;
    int z = a.z * b.z;
    int w = a.w * b.w;
    return new iVec4(x,y,z,w);
  }
}

iVec2 imult(iVec2 a, int arg) {
  return imult(a,iVec2(arg,arg));
}

iVec3 imult(iVec3 a, int arg) {
  return imult(a,iVec3(arg,arg,arg));
}

iVec4 imult(iVec4 a, int arg) {  
  return imult(a,iVec4(arg,arg,arg,arg));
}


/**
Division
v 0.0.3
*/
/**
* return the resultat of vector division
*/
iVec2 idiv(iVec2 a, iVec2 b) {
  if(a == null || b == null) {
    return null;
  } else {
    int x = a.x / b.x;
    int y = a.y / b.y;
    return new iVec2(x,y);
  }
}

iVec3 idiv(iVec3 a, iVec3 b) {
  if(a == null || b == null) {
    return null;
  } else {
    int x = a.x / b.x;
    int y = a.y / b.y;
    int z = a.z / b.z;
    return new iVec3(x,y,z);
  }
}

iVec4 idiv(iVec4 a, iVec4 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    int x = a.x / b.x;
    int y = a.y / b.y;
    int z = a.z / b.z;
    int w = a.w / b.w;
    return new iVec4(x,y,z,w);
  }
}

iVec2 idiv(iVec2 a, int arg) {
  return idiv(a,iVec2(arg,arg));
}

iVec3 idiv(iVec3 a, int arg) {
  return idiv(a,iVec3(arg,arg,arg));
}

iVec4 idiv(iVec4 a, int arg) {  
  return idiv(a,iVec4(arg,arg,arg,arg));
}



/**
Substraction
v 0.0.1
*/
/**
* return the resultat of vector substraction
*/
iVec2 isub(iVec2 a, iVec2 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    int x = a.x - b.x;
    int y = a.y - b.y;
    return new iVec2(x,y);
  }
}

iVec3 isub(iVec3 a, iVec3 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    int x = a.x - b.x;
    int y = a.y - b.y;
    int z = a.z - b.z;
    return new iVec3(x,y,z);
  }
}

iVec4 isub(iVec4 a, iVec4 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    int x = a.x - b.x;
    int y = a.y - b.y;
    int z = a.z - b.z;
    int w = a.w - b.w;
    return new iVec4(x,y,z,w);
  }
}

iVec2 isub(iVec2 a, int arg) {
  return isub(a,iVec2(arg,arg));
}

iVec3 isub(iVec3 a, int arg) {
  return isub(a,iVec3(arg,arg,arg));
}

iVec4 isub(iVec4 a, int arg) {  
  return isub(a,iVec4(arg,arg,arg,arg));
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
Vec2 add(Vec2 a, Vec2 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    float x = a.x + b.x ;
    float y = a.y + b.y ;
    return new Vec2(x,y) ;
  }
}

Vec3 add(Vec3 a, Vec3 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    float x = a.x + b.x ;
    float y = a.y + b.y ;
    float z = a.z + b.z ;
    return new Vec3(x,y,z)  ;
  }
}

Vec4 add(Vec4 a, Vec4 b) {  
  if(a == null || b == null) {
    return null ;
  } else {
    float x = a.x + b.x ;
    float y = a.y + b.y ;
    float z = a.z + b.z ;
    float w = a.w + b.w ;
    return new Vec4(x,y,z,w)  ;
  }
}
/**
* iVec arg
*/
Vec2 add(iVec2 a, iVec2 b) {
  return add(Vec2(a),Vec2(b));
}

Vec3 add(iVec3 a, iVec3 b) {
  return add(Vec3(a),Vec3(b));
}

Vec4 add(iVec4 a, iVec4 b) {  
  return add(Vec4(a),Vec4(b));
}
/**
* float arg
*/
Vec2 add(Vec2 a, float arg) {
  return add(a,Vec2(arg,arg));
}

Vec3 add(Vec3 a, float arg) {
  return add(a,Vec3(arg,arg,arg));
}

Vec4 add(Vec4 a, float arg) {  
  return add(a,Vec4(arg,arg,arg,arg));
}
/**
* iVec + float
*/

Vec2 add(iVec2 a, float arg) {
  return add(Vec2(a),Vec2(arg,arg));
}

Vec3 add(iVec3 a, float arg) {
  return add(Vec3(a),Vec3(arg,arg,arg));
}

Vec4 add(iVec4 a, float arg) {  
  return add(Vec4(a),Vec4(arg,arg,arg,arg));
}




/**
Multiplication
v 0.0.4
*/
/**
* return the resultat of vector multiplication
*/
Vec2 mult(Vec2 a, Vec2 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    float x = a.x * b.x;
    float y = a.y * b.y;
    return new Vec2(x,y);
  }
}

Vec3 mult(Vec3 a, Vec3 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    float x = a.x * b.x;
    float y = a.y * b.y;
    float z = a.z * b.z;
    return new Vec3(x,y,z);
  }
}

Vec4 mult(Vec4 a, Vec4 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    float x = a.x * b.x;
    float y = a.y * b.y;
    float z = a.z * b.z;
    float w = a.w * b.w;
    return new Vec4(x,y,z,w);
  }
}
/**
* iVec arg
*/
Vec2 mult(iVec2 a, iVec2 b) {
  return mult(Vec2(a),Vec2(b));
}

Vec3 mult(iVec3 a, iVec3 b) {
  return mult(Vec3(a),Vec3(b));
}

Vec4 mult(iVec4 a, iVec4 b) {  
  return mult(Vec4(a),Vec4(b));
}

/**
* float arg
*/
Vec2 mult(Vec2 a, float arg) {
  return mult(a,Vec2(arg,arg));
}

Vec3 mult(Vec3 a, float arg) {
  return mult(a,Vec3(arg,arg,arg));
}

Vec4 mult(Vec4 a, float arg) {  
  return mult(a,Vec4(arg,arg,arg,arg));
}
/**
* iVec + float
*/
Vec2 mult(iVec2 a, float arg) {
  return mult(Vec2(a),Vec2(arg,arg));
}

Vec3 mult(iVec3 a, float arg) {
  return mult(Vec3(a),Vec3(arg,arg,arg));
}

Vec4 mult(iVec4 a, float arg) {  
  return mult(Vec4(a),Vec4(arg,arg,arg,arg));
}




/**
Division
v 0.0.4
*/
/**
* return the resultat of vector division
*/
Vec2 div(Vec2 a, Vec2 b) {
  if(a == null || b == null) {
    return null;
  } else {
    float x = a.x /b.x;
    float y = a.y /b.y;
    return new Vec2(x,y);
  }
}

Vec3 div(Vec3 a, Vec3 b) {
  if(a == null || b == null) {
    return null;
  } else {
    float x = a.x /b.x;
    float y = a.y /b.y;
    float z = a.z /b.z;
    return new Vec3(x,y,z);
  }
}

Vec4 div(Vec4 a, Vec4 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    float x = a.x /b.x;
    float y = a.y /b.y;
    float z = a.z /b.z;
    float w = a.w /b.w;
    return new Vec4(x,y,z,w);
  }
}
/**
* iVec arg
*/
Vec2 div(iVec2 a, iVec2 b) {
  return div(Vec2(a),Vec2(b));
}

Vec3 div(iVec3 a, iVec3 b) {
  return div(Vec3(a),Vec3(b));
}

Vec4 div(iVec4 a, iVec4 b) {  
  return div(Vec4(a),Vec4(b));
}
/**
* float arg
*/
Vec2 div(Vec2 a, float arg) {
  return div(a,Vec2(arg,arg));
}

Vec3 div(Vec3 a, float arg) {
  return div(a,Vec3(arg,arg,arg));
}

Vec4 div(Vec4 a, float arg) {  
  return div(a,Vec4(arg,arg,arg,arg));
}
/**
* iVec + float
*/
Vec2 div(iVec2 a, float arg) {
  return div(Vec2(a),Vec2(arg,arg));
}

Vec3 div(iVec3 a, float arg) {
  return div(Vec3(a),Vec3(arg,arg,arg));
}

Vec4 div(iVec4 a, float arg) {  
  return div(Vec4(a),Vec4(arg,arg,arg,arg));
}


/**
Substraction
v 0.0.5
*/
/**
* return the resultat of vector substraction
*/
Vec2 sub(Vec2 a, Vec2 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    float x = a.x - b.x;
    float y = a.y - b.y;
    return new Vec2(x,y);
  }
}

Vec3 sub(Vec3 a, Vec3 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    float x = a.x - b.x;
    float y = a.y - b.y;
    float z = a.z - b.z;
    return new Vec3(x,y,z);
  }
}

Vec4 sub(Vec4 a, Vec4 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    float x = a.x - b.x;
    float y = a.y - b.y;
    float z = a.z - b.z;
    float w = a.w - b.w;
    return new Vec4(x,y,z,w);
  }
}
/**
* iVec arg
*/
Vec2 sub(iVec2 a, iVec2 b) {
  return sub(Vec2(a),Vec2(b));
}

Vec3 sub(iVec3 a, iVec3 b) {
  return sub(Vec3(a),Vec3(b));
}

Vec4 sub(iVec4 a, iVec4 b) {  
  return sub(Vec4(a),Vec4(b));
}
/**
* float arg
*/
Vec2 sub(Vec2 a, float arg) {
  return sub(a,Vec2(arg,arg));
}

Vec3 sub(Vec3 a, float arg) {
  return sub(a,Vec3(arg,arg,arg));
}

Vec4 sub(Vec4 a, float arg) {  
  return sub(a,Vec4(arg,arg,arg,arg));
}
/**
* iVec + float
*/
Vec2 sub(iVec2 a, float arg) {
  return sub(Vec2(a),Vec2(arg,arg));
}

Vec3 sub(iVec3 a, float arg) {
  return sub(Vec3(a),Vec3(arg,arg,arg));
}

Vec4 sub(iVec4 a, float arg) {  
  return sub(Vec4(a),Vec4(arg,arg,arg,arg));
}



/**
Cross
v 0.0.2
*/
Vec3 cross(Vec3 v1, Vec3 v2) {
  if(v1 == null ||  v2 == null) {
    return null;
  } else {
    float crossX = v1.y * v2.z - v2.y * v1.z;
    float crossY = v1.z * v2.x - v2.z * v1.x;
    float crossZ = v1.x * v2.y - v2.x * v1.y;
    return Vec3(crossX, crossY, crossZ);
  }
}
/**
* @deprecated "cross(Vec3 v1, Vec3 v2, Vec3 target), can be deprecated in the future, need to be test"
*/
@Deprecated
Vec3 cross(Vec3 v1, Vec3 v2, Vec3 target) {
  println("cross(Vec3 v1, Vec3 v2, Vec3 target), can be deprecated in the future, need to be test");
  if(v1 == null ||  v2 == null || target == null) {
    return null ;
  } else {
    float crossX = v1.y * v2.z - v2.y * v1.z;
    float crossY = v1.z * v2.x - v2.z * v1.x;
    float crossZ = v1.x * v2.y - v2.x * v1.y;

    if (target == null) {
      target = Vec3(crossX, crossY, crossZ);
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
/**
* Compare Vector with or without area
* we must add a compare method for the case when we need to compare in vector in the a class
*
* @return boolean
*/
// Vec2 equals

/**
* @deprecated instead use compare()
*/
@Deprecated
boolean equals(Vec2 v_a, Vec2 v_b) {
  return compare(v_a,v_b);
}
/**
* @deprecated instead use compare()
*/
@Deprecated
boolean equals(Vec3 v_a, Vec3 v_b) {
  return compare(v_a,v_b);
}
/**
* @deprecated instead use compare()
*/
@Deprecated
boolean equals(Vec4 v_a, Vec4 v_b) {
  return compare(v_a,v_b);
}
/**
* @deprecated instead use compare()
*/
@Deprecated
boolean equals(Vec2 v_a, Vec2 v_b, Vec2 area) {
  return compare(v_a,v_b, area);
}
/**
* @deprecated instead use compare()
*/
@Deprecated
boolean equals(Vec3 v_a, Vec3 v_b, Vec3 area) {
   return compare(v_a,v_b, area);
}
/**
* @deprecated instead use compare()
*/
@Deprecated
boolean equals(Vec4 v_a, Vec4 v_b, Vec4 area) {
  return compare(v_a,v_b, area);
}





boolean compare(Vec2 a, Vec2 b) {
  if(a == null || b == null) {
    println("Is not possible to compare", a, "to", b) ;
    return false ;
  } else {
    return equals(Vec4(a.x,a.y,0,0),Vec4(b.x,b.y,0,0)) ;
  }
}

// Vec3 compare
boolean compare(Vec3 a, Vec3 b) {
    if(a == null || b == null) {
    println("Is not possible to compare", a, "to", b) ;
    return false ;
  } else {
    return equals(Vec4(a.x,a.y,a.z, 0),Vec4(b.x,b.y,b.z, 0)) ;
  }
}
// Vec4 compare
boolean compare(Vec4 a, Vec4 b) {
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
* compare if the first vector is in the area of the second vector, 
* the area of the second vector is define by a Vec area, 
* that give the possibility of different size for each component
* @return boolean
*/
// Vec method
/**
* compare with area
*/
boolean compare(Vec2 a, Vec2 b, Vec2 area) {
  if(a == null || b == null || area == null) {
    println("Is not possible to compare", a, "with", b, "with", area) ;
    return false ;
  } else {
    return equals(Vec4(a.x,a.y, 0, 0),Vec4(b.x,b.y, 0, 0),Vec4(area.x, area.y, 0, 0)) ;
  }
}

boolean compare(Vec3 a, Vec3 b, Vec3 area) {
    if(a == null || b == null || area == null) {
    println("Is not possible to compare", a, "with", b, "with", area) ;
    return false ;
  } else {
    return equals(Vec4(a.x,a.y,a.z, 0),Vec4(b.x,b.y,b.z, 0),Vec4(area.x, area.y, area.z, 0)) ;
  }
}

boolean compare(Vec4 a, Vec4 b, Vec4 area) {
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
Vec2 map_vec(Vec2 v,float minIn, float maxIn, float minOut, float maxOut) {
  if(v != null) {
    float x = map(v.x, minIn, maxIn, minOut, maxOut) ;
    float y = map(v.y, minIn, maxIn, minOut, maxOut) ;
    return new Vec2(x,y) ;
  } else return null ;
}
Vec3 map_vec(Vec3 v,float minIn, float maxIn, float minOut, float maxOut) {
  if(v != null) {
    float x = map(v.x, minIn, maxIn, minOut, maxOut) ;
    float y = map(v.y, minIn, maxIn, minOut, maxOut) ;
    float z = map(v.z, minIn, maxIn, minOut, maxOut) ;
    return new Vec3(x,y,z) ;
  } else return null ;
}
Vec4 map_vec(Vec4 v,float minIn, float maxIn, float minOut, float maxOut) {
  if(v != null) {
    float x = map(v.x, minIn, maxIn, minOut, maxOut) ;
    float y = map(v.y, minIn, maxIn, minOut, maxOut) ;
    float z = map(v.z, minIn, maxIn, minOut, maxOut) ;
    float w = map(v.w, minIn, maxIn, minOut, maxOut) ;
    return new Vec4(x,y,z,w) ;
  } else return null ;
}

/**
Magnitude or length
*/
/**
* @return float
*/
// mag Vec2
float mag(Vec2 a) {
  float x = a.x*a.x ;
  float y = a.y *a.y ;
  return sqrt(x+y) ;
}

float mag(Vec2 a, Vec2 b) {
  // same result than dist
  float x = (b.x -a.x)*(b.x -a.x) ;
  float y = (b.y -a.y)*(b.y -a.y) ;
  return sqrt(x+y) ;
}
// mag Vec3
float mag(Vec3 a) {
  float x = a.x*a.x ;
  float y = a.y *a.y ;
  float z = a.z *a.z ;
  return sqrt(x+y+z) ;
}

float mag(Vec3 a, Vec3 b) {
  // same result than dist
  float x = (b.x -a.x)*(b.x -a.x) ;
  float y = (b.y -a.y)*(b.y -a.y) ;
  float z = (b.z -a.z)*(b.z -a.z) ;
  return sqrt(x+y+z) ;
}
// mag Vec4
float mag(Vec4 a) {
  float x = a.x*a.x ;
  float y = a.y*a.y ;
  float z = a.z*a.z ;
  float w = a.w*a.w ;
  return sqrt(x+y+z+w) ;
}

float mag(Vec4 a, Vec4 b) {
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
float dist(Vec2 a, Vec2 b) {
  if(a != null && b != null) {
    float dx = a.x - b.x;
    float dy = a.y - b.y;
    return (float) Math.sqrt(dx*dx + dy*dy);
  } else return Float.NaN ;
    
}
float dist(Vec3 a, Vec3 b) {
  if(a != null && b != null) {
    float dx = a.x - b.x;
    float dy = a.y - b.y;
    float dz = a.z - b.z;
    return (float) Math.sqrt(dx*dx + dy*dy + dz*dz);
  } else return Float.NaN ;
}

float dist(Vec4 a, Vec4 b) {
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
Vec2 middle(Vec2 a, Vec2 b)  {
  Vec2 middle ;
  middle = add(a,b);
  middle.div(2) ;
  println("The method middle is deprecated instead use barycenter(Vec... arg)") ;
  return middle ;
}

Vec2 middle(Vec2 [] list)  {
  Vec2 middle = Vec2() ;
  for (int i = 0 ; i < list.length ; i++) {
    middle.add(list[i]);
  }
  middle.div(list.length) ;
  println("The method middle is deprecated instead use barycenter(Vec... arg)") ;
  return middle ;
}

Vec3 middle(Vec3 a, Vec3 b) {
  Vec3 middle ;
  middle = add(a,b);
  middle.div(2) ;
  return middle ;
}

Vec3 middle(Vec3 [] list)  {
  Vec3 middle = Vec3() ;
  for (int i = 0 ; i < list.length ; i++) {
    middle.add(list[i]);
  }
  middle.div(list.length) ;
  println("The method middle is deprecated instead use barycenter(Vec... arg)") ;
  return middle ;
}

Vec4 middle(Vec4 a, Vec4 b)  {
  Vec4 middle ;
  middle = add(a,b);
  middle.div(2) ;
  println("The method middle is deprecated instead use barycenter(Vec... arg)") ;
  return middle ;
}

Vec4 middle(Vec4 [] list)  {
  Vec4 middle = Vec4() ;
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
Vec2 barycenter(Vec2... v) {
  int div_num = v.length ;
  Vec2 sum = Vec2() ;
  for(int i = 0 ; i < div_num ; i++) {
    sum.add(v[i]) ;
  }
  return sum.div(div_num) ;
}

 
Vec3 barycenter(Vec3... v) {
  int div_num = v.length ;
  Vec3 sum = Vec3() ;
  for(int i = 0 ; i < div_num ; i++) {
    sum.add(v[i]) ;
  }
  return sum.div(div_num) ;
}

Vec4 barycenter(Vec4... v) {
  int div_num = v.length ;
  Vec4 sum = Vec4() ;
  for(int i = 0 ; i < div_num ; i++) {
    sum.add(v[i]) ;
  }
  return sum.div(div_num) ;
}





/**
Jitter
v 0.0.2
*/
// Vec2
Vec2 jitter_2D(int range) {
  return jitter_2D(range, range) ;
}
Vec2 jitter_2D(Vec2 range) {
  return jitter_2D((int)range.x, (int)range.y) ;
}
Vec2 jitter_2D(int range_x, int range_y) {
  Vec2 jitter = Vec2() ;
  jitter.x = random_next_gaussian(range_x, 2);
  jitter.y = random_next_gaussian(range_y, 2);
  return jitter ;
}
// Vec3
Vec3 jitter_3D(int range) {
  return jitter_3D(range, range, range) ;
}
Vec3 jitter_3D(Vec3 range) {
  return jitter_3D((int)range.x, (int)range.y, (int)range.z) ;
}
Vec3 jitter_3D(int range_x, int range_y, int range_z) {
  Vec3 jitter = Vec3() ;
  jitter.x = random_next_gaussian(range_x, 2);
  jitter.y = random_next_gaussian(range_y, 2);
  jitter.z = random_next_gaussian(range_z, 2);
  return jitter ;
}
// Vec4
Vec4 jitter_4D(int range) {
  return jitter_4D(range, range, range, range) ;
}
Vec4 jitter_4D(Vec4 range) {
  return jitter_4D((int)range.x, (int)range.y, (int)range.z, (int)range.w) ;
}
Vec4 jitter_4D(int range_x, int range_y, int range_z, int range_w) {
  Vec4 jitter = Vec4() ;
  jitter.x = random_next_gaussian(range_x, 2);
  jitter.y = random_next_gaussian(range_y, 2);
  jitter.z = random_next_gaussian(range_z, 2);
  jitter.w = random_next_gaussian(range_w, 2);
  return jitter ;
}
// END JITTER
/////////////


/**
Normalize
*/
// VEC 2 from angle
///////////////////
Vec2 norm_rad(float angle) {
  float x = (float)Math.cos(angle) ;
  float y = (float)Math.sin(angle) ;
  return Vec2(x,y) ;
}

Vec2 norm_deg(float angle) {
  angle = radians(angle) ;
  float x = (float)Math.cos(angle) ;
  float y = (float)Math.sin(angle) ;
  return Vec2(x,y) ;
}


// normalize direction
Vec2 norm_dir(String type, float direction) {
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
  return new Vec2(x,y) ;
}




/**
translate int color to Vec4 color
*/
Vec4 color_HSBA(int c) {
  return Vec4(hue(c), saturation(c), brightness(c), alpha(c)) ;
}

Vec4 color_RGBA(int c) {
  return Vec4(red(c), green(c), blue(c), alpha(c)) ;
}

Vec3 color_HSB(int c) {
  return Vec3(hue(c), saturation(c), brightness(c)) ;
}

Vec3 color_RGB(int c) {
  return Vec3(red(c), green(c), blue(c)) ;
}
































/**
New Vec, iVec and bVec
v 0.0.2
*/

/**
Return a new bVec
*/
/**
* @return bVec
*/
/**
bVec2
*/
bVec2 bVec2() {
  return new bVec2(false,false) ;
}

bVec2 bVec2(boolean b) {
  return new bVec2(b,b);
}

bVec2 bVec2(boolean x, boolean y) { 
  return new bVec2(x,y) ;
}

bVec2 bVec2(boolean [] array) {
  if(array.length == 1) {
    return new bVec2(array[0],array[0]);
  } else if (array.length > 1) {
    return new bVec2(array[0],array[1]);
  } else {
    return null;
  }
}

bVec2 bVec2(bVec b) {
  if(b == null) {
    println("bVec null, instead 'false' is used to build bVec") ;
    return new bVec2(false,false) ;
  } else if(b instanceof bVec5 || b instanceof bVec6) {
    return new bVec2(b.a,b.b) ;
  } else {
    return new bVec2(b.x,b.y) ;
  }
}

/**
iVec3
*/
bVec3 bVec3() {
  return new bVec3(false,false,false) ;
}

bVec3 bVec3(boolean b) {
  return new bVec3(b,b,b);
}

bVec3 bVec3(boolean x, boolean y, boolean z) { 
  return new bVec3(x,y,z) ;
}

bVec3 bVec3(boolean [] array) {
  if(array.length == 1) {
    return new bVec3(array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new bVec3(array[0],array[1],false);
  } else if (array.length > 2) {
    return new bVec3(array[0],array[1],array[2]);
  } else {
    return null;
  }
}

bVec3 bVec3(bVec b) {
  if(b == null) {
    println("bVec null, instead 'false' is used to build bVec") ;
    return new bVec3(false,false,false) ;
  } else if(b instanceof bVec5 || b instanceof bVec6) {
    return new bVec3(b.a,b.b,b.c) ;
  } else {
    return new bVec3(b.x,b.y,b.z) ;
  }
}

/**
iVec4
*/
bVec4 bVec4() {
  return new bVec4(false,false,false,false) ;
}

bVec4 bVec4(boolean b) {
  return new bVec4(b,b,b,b);
}

bVec4 bVec4(boolean x, boolean y, boolean z, boolean w) { 
  return new bVec4(x,y,z,w) ;
}

bVec4 bVec4(boolean [] array) {
  if(array.length == 1) {
    return new bVec4(array[0],array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new bVec4(array[0],array[1],false,false);
  } else if (array.length == 3) {
    return new bVec4(array[0],array[1],array[2],false);
  } else if (array.length > 3) {
    return new bVec4(array[0],array[1],array[2],array[3]);
  } else {
    return null;
  }
}

bVec4 bVec4(bVec b) {
  if(b == null) {
    println("bVec null, instead 'false' is used to build bVec") ;
    return new bVec4(false,false,false,false) ;
  } else if(b instanceof bVec5 || b instanceof bVec6) {
    return new bVec4(b.a,b.b,b.c,b.d) ;
  } else {
    return new bVec4(b.x,b.y,b.z,b.w) ;
  }
}

/**
iVec5
*/
bVec5 bVec5() {
  return new bVec5(false,false,false,false,false) ;
}

bVec5 bVec5(boolean b) {
  return new bVec5(b,b,b,b,b);
}

bVec5 bVec5(boolean a, boolean b, boolean c, boolean d, boolean e) { 
  return new bVec5(a,b,c,d,e) ;
}

bVec5 bVec5(boolean [] array) {
  if(array.length == 1) {
    return new bVec5(array[0],array[0],array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new bVec5(array[0],array[1],false,false,false);
  } else if (array.length == 3) {
    return new bVec5(array[0],array[1],array[2],false,false);
  } else if (array.length == 4) {
    return new bVec5(array[0],array[1],array[2],array[3],false);
  } else if (array.length >4) {
    return new bVec5(array[0],array[1],array[2],array[3],array[4]);
  } else {
    return null;
  }
}

bVec5 bVec5(bVec b) {
  if(b == null) {
    println("bVec null, instead 'false' is used to build bVec") ;
    return new bVec5(false,false,false,false,false) ;
  } else if(b instanceof bVec5 || b instanceof bVec6) {
    return new bVec5(b.a,b.b,b.c,b.d,b.e) ;
  } else {
    return new bVec5(b.x,b.y,b.z,b.w,false) ;
  }
}

/**
bVec6
*/
bVec6 bVec6() {
  return new bVec6(false,false,false,false,false,false) ;
}

bVec6 bVec6(boolean b) {
  return new bVec6(b,b,b,b,b,b);
}

bVec6 bVec6(boolean a, boolean b, boolean c, boolean d, boolean e, boolean f) { 
  return new bVec6(a,b,c,d,e,f) ;
}

bVec6 bVec6(boolean [] array) {
  if(array.length == 1) {
    return new bVec6(array[0],array[0],array[0],array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new bVec6(array[0],array[1],false,false,false,false);
  } else if (array.length == 3) {
    return new bVec6(array[0],array[1],array[2],false,false,false);
  } else if (array.length == 4) {
    return new bVec6(array[0],array[1],array[2],array[3],false,false);
  } else if (array.length == 5) {
    return new bVec6(array[0],array[1],array[2],array[3],array[4],false);
  }  else if (array.length > 5) {
    return new bVec6(array[0],array[1],array[2],array[3],array[4],array[5]);
  } else {
    return null;
  }
}

bVec6 bVec6(bVec b) {
  if(b== null) {
    println("bVec null, instead 'false' is used to build bVec") ;
    return new bVec6(false,false,false,false,false,false) ;
  } else if(b instanceof bVec5 || b instanceof bVec6) {
    return new bVec6(b.a,b.b,b.c,b.d,b.e,b.f) ;
  } else {
    return new bVec6(b.x,b.y,b.z,b.w,false,false) ;
  }
}

























/**
Return a new iVec
*/
/**
iVec2
*/
iVec2 iVec2() {
  return iVec2(0) ;
}

iVec2 iVec2(int v) {
  return new iVec2(v,v);
}

iVec2 iVec2(int x, int y) { 
  return new iVec2(x,y) ;
}

iVec2 iVec2(int [] array) {
  if(array.length == 1) {
    return new iVec2(array[0],array[0]);
  } else if (array.length > 1) {
    return new iVec2(array[0],array[1]);
  } else {
    return null;
  }
}

iVec2 iVec2(iVec p) {
  if(p == null) {
    println("iVec null, instead '0' is used to build iVec") ;
    return new iVec2(0,0) ;
  } else if(p instanceof iVec5 || p instanceof iVec6) {
    return new iVec2(p.a,p.b) ;
  } else {
    return new iVec2(p.x,p.y) ;
  }
}

/**
iVec3
*/
iVec3 iVec3() {
  return iVec3(0) ;
}

iVec3 iVec3(int v) {
  return new iVec3(v,v,v);
}

iVec3 iVec3(int x, int y, int z) { 
  return new iVec3(x,y,z) ;
}

iVec3 iVec3(int [] array) {
  if(array.length == 1) {
    return new iVec3(array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new iVec3(array[0],array[1],0);
  } else if (array.length > 2) {
    return new iVec3(array[0],array[1],array[2]);
  } else {
    return null;
  }
}

iVec3 iVec3(iVec p) {
  if(p == null) {
    println("iVec null, instead '0' is used to build iVec") ;
    return new iVec3(0,0,0) ;
  } else if(p instanceof iVec5 || p instanceof iVec6) {
    return new iVec3(p.a,p.b,p.c) ;
  } else {
    return new iVec3(p.x,p.y,p.z) ;
  }
}

/**
iVec4
*/
iVec4 iVec4() {
  return iVec4(0) ;
}

iVec4 iVec4(int v) {
  return new iVec4(v,v,v,v);
}

iVec4 iVec4(int x, int y, int z, int w) { 
  return new iVec4(x,y,z,w) ;
}

iVec4 iVec4(int [] array) {
  if(array.length == 1) {
    return new iVec4(array[0],array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new iVec4(array[0],array[1],0,0);
  } else if (array.length == 3) {
    return new iVec4(array[0],array[1],array[2],0);
  } else if (array.length > 3) {
    return new iVec4(array[0],array[1],array[2],array[3]);
  } else {
    return null;
  }
}

iVec4 iVec4(iVec p) {
  if(p == null) {
    println("iVec null, instead '0' is used to build iVec") ;
    return new iVec4(0,0,0,0) ;
  } else if(p instanceof iVec5 || p instanceof iVec6) {
    return new iVec4(p.a,p.b,p.c,p.d) ;
  } else {
    return new iVec4(p.x,p.y,p.z,p.w) ;
  }
}

/**
iVec5
*/
iVec5 iVec5() {
  return iVec5(0) ;
}

iVec5 iVec5(int v) {
  return new iVec5(v,v,v,v,v);
}

iVec5 iVec5(int a, int b, int c, int d, int e) { 
  return new iVec5(a,b,c,d,e) ;
}

iVec5 iVec5(int [] array) {
  if(array.length == 1) {
    return new iVec5(array[0],array[0],array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new iVec5(array[0],array[1],0,0,0);
  } else if (array.length == 3) {
    return new iVec5(array[0],array[1],array[2],0,0);
  } else if (array.length == 4) {
    return new iVec5(array[0],array[1],array[2],array[3],0);
  } else if (array.length > 4) {
    return new iVec5(array[0],array[1],array[2],array[3],array[4]);
  } else {
    return null;
  }
}

iVec5 iVec5(iVec p) {
  if(p == null) {
    println("iVec null, instead '0' is used to build iVec") ;
    return new iVec5(0,0,0,0,0) ;
  } else if(p instanceof iVec5 || p instanceof iVec6) {
    return new iVec5(p.a,p.b,p.c,p.d,p.e) ;
  } else {
    return new iVec5(p.x,p.y,p.z,p.w,0) ;
  }
}

/**
iVec6
*/
iVec6 iVec6() {
  return iVec6(0) ;
}

iVec6 iVec6(int v) {
  return new iVec6(v,v,v,v,v,v);
}

iVec6 iVec6(int a, int b, int c, int d, int e, int f) { 
  return new iVec6(a,b,c,d,e,f) ;
}

iVec6 iVec6(int [] array) {
  if(array.length == 1) {
    return new iVec6(array[0],array[0],array[0],array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new iVec6(array[0],array[1],0,0,0,0);
  } else if (array.length == 3) {
    return new iVec6(array[0],array[1],array[2],0,0,0);
  } else if (array.length == 4) {
    return new iVec6(array[0],array[1],array[2],array[3],0,0);
  } else if (array.length == 5) {
    return new iVec6(array[0],array[1],array[2],array[3],array[4],0);
  }  else if (array.length > 5) {
    return new iVec6(array[0],array[1],array[2],array[3],array[4],array[5]);
  } else {
    return null;
  }
}

iVec6 iVec6(iVec p) {
  if(p == null) {
    println("iVec null, instead '0' is used to build iVec") ;
    return new iVec6(0,0,0,0,0,0) ;
  } else if(p instanceof iVec5 || p instanceof iVec6) {
    return new iVec6(p.a,p.b,p.c,p.d,p.e,p.f) ;
  } else {
    return new iVec6(p.x,p.y,p.z,p.w,0,0) ;
  }
}
























/**
Return a new Vec
v 0.0.4
*/
/**
Vec 2
*/
Vec2 Vec2() {
  return new Vec2(0,0) ;
}

Vec2 Vec2(float x, float y) { 
  return new Vec2(x,y) ;
}

Vec2 Vec2(float [] array) {
  if(array.length == 1) {
    return new Vec2(array[0],array[0]);
  } else if (array.length > 1) {
    return new Vec2(array[0],array[1]);
  } else {
    return null;
  }
}

Vec2 Vec2(int [] array) {
  if(array.length == 1) {
    return new Vec2(array[0],array[0]);
  } else if (array.length > 1) {
    return new Vec2(array[0],array[1]);
  } else {
    return null;
  }
}

Vec2 Vec2(float v) {
  return new Vec2(v,v) ;
}

Vec2 Vec2(PVector p) {
  if(p == null) {
    return new Vec2(0,0);
  } else {
    return new Vec2(p.x, p.y);
  }
}

Vec2 Vec2(Vec p) {
  if(p == null) {
    return new Vec2(0,0);
  } else if(p instanceof Vec5 || p instanceof Vec6) {
    return new Vec2(p.a,p.b);
  } else {
    return new Vec2(p.x,p.y);
  }
}


Vec2 Vec2(iVec p) {
  if(p == null) {
    return new Vec2(0,0);
  } else if(p instanceof iVec5 || p instanceof iVec6) {
    return new Vec2(p.a,p.b);
  } else {
    return new Vec2(p.x,p.y);
  }
}


Vec2 Vec2(String s, int x, int y) { 
  return new Vec2(s,x,y);
}

Vec2 Vec2(String s, int a, int b, int c, int d) { 
  return new Vec2(s,a,b,c,d);
}

Vec2 Vec2(String s, int v) {
  return new Vec2(s,v);
}
/**
Vec 3
*/
Vec3 Vec3() {
  return new Vec3(0,0,0) ;
}

Vec3 Vec3(float x, float y, float z) {
  return new Vec3(x,y,z);
}

Vec3 Vec3(float [] array) {
  if(array.length == 1) {
    return new Vec3(array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new Vec3(array[0],array[1],0);
  } else if (array.length > 2) {
    return new Vec3(array[0],array[1],array[2]);
  } else {
    return null;
  }
}

Vec3 Vec3(int [] array) {
  if(array.length == 1) {
    return new Vec3(array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new Vec3(array[0],array[1],0);
  } else if (array.length > 2) {
    return new Vec3(array[0],array[1],array[2]);
  } else {
    return null;
  }
}

Vec3 Vec3(float v) {
  return new Vec3(v,v,v);
}

Vec3 Vec3(PVector p) {
  if(p == null) {
    return new Vec3(0,0,0);
  } else {
    return new Vec3(p.x, p.y, p.z);
  }
}

Vec3 Vec3(Vec p) {
  if(p == null) {
    return new Vec3(0,0,0);
  } else if(p instanceof Vec5 || p instanceof Vec6) {
    return new Vec3(p.a,p.b,p.c);
  } else {
    return new Vec3(p.x,p.y,p.z);
  }
}

Vec3 Vec3(iVec p) {
  if(p == null) {
    return new Vec3(0,0,0);
  } else if(p instanceof iVec5 || p instanceof iVec6) {
    return new Vec3(p.a,p.b,p.c);
  } else {
    return new Vec3(p.x,p.y,p.z);
  }
}



Vec3 Vec3(String s, int x, int y, int z) { 
  return new Vec3(s,x,y,z);
}

Vec3 Vec3(String s, int a, int b, int c, int d, int e, int f) { 
  return new Vec3(s,a,b,c,d,e,f);
}

Vec3 Vec3(String s, int v) {
  return new Vec3(s,v);
}
/**
Vec 4
*/
Vec4 Vec4() {
  return new Vec4(0,0,0,0);
}

Vec4 Vec4(float x, float y, float z, float w) {
  return new Vec4(x,y,z,w);
}

Vec4 Vec4(float [] array) {
  if(array.length == 1) {
    return new Vec4(array[0],array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new Vec4(array[0],array[1],0,0);
  } else if (array.length == 3) {
    return new Vec4(array[0],array[1],array[2],0);
  } else if (array.length > 3) {
    return new Vec4(array[0],array[1],array[2],array[3]);
  } else {
    return null;
  }
}

Vec4 Vec4(int [] array) {
  if(array.length == 1) {
    return new Vec4(array[0],array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new Vec4(array[0],array[1],0,0);
  } else if (array.length == 3) {
    return new Vec4(array[0],array[1],array[2],0);
  } else if (array.length > 3) {
    return new Vec4(array[0],array[1],array[2],array[3]);
  } else {
    return null;
  }
}

Vec4 Vec4(float v) {
  return new Vec4(v,v,v,v);
}

Vec4 Vec4(PVector p) {
  if(p == null) {
    return new Vec4(0,0,0,0);
  } else {
    return new Vec4(p.x, p.y, p.z, 0);
  }
}
// build with Vec
Vec4 Vec4(Vec p) {
  if(p == null) {
    return new Vec4(0,0,0,0);
  } else if(p instanceof Vec5 || p instanceof Vec6) {
    return new Vec4(p.a,p.b,p.c,p.d);
  } else {
    return new Vec4(p.x,p.y,p.z,p.w);
  }
}

Vec4 Vec4(iVec p) {
  if(p == null) {
    return new Vec4(0,0,0,0);
  } else if(p instanceof iVec5 || p instanceof iVec6) {
    return new Vec4(p.a,p.b,p.c,p.d);
  } else {
    return new Vec4(p.x,p.y,p.z,p.w);
  }
}



Vec4 Vec4(String s, int x, int y, int z, int w) { 
  return new Vec4(s,x,y,z,w);
}

Vec4 Vec4(String s, int a, int b, int c, int d, int e, int f, int g, int h) { 
  return new Vec4(s,a,b,c,d,e,f,g,h);
}

Vec4 Vec4(String s, int v) {
  return new Vec4(s,v);
}
/**
Vec 5
*/
Vec5 Vec5() {
  return new Vec5(0,0,0,0,0);
}

Vec5 Vec5(float a, float b, float c, float d, float e) {
  return new Vec5(a,b,c,d,e);
}

Vec5 Vec5(float [] array) {
  if(array.length == 1) {
    return new Vec5(array[0],array[0],array[0],array[0],array[0]);
  } else if (array.length == 2){
    return new Vec5(array[0],array[1],0,0,0) ;
  } else if (array.length == 3){
    return new Vec5(array[0],array[1],array[2],0,0) ;
  } else if (array.length == 4){
    return new Vec5(array[0],array[1],array[2],array[3],0) ;
  }  else if (array.length > 4){
    return new Vec5(array[0],array[1],array[2],array[3],array[4]) ;
  } else {
    return null;
  }
}

Vec5 Vec5(int [] array) {
  if(array.length == 1) {
    return new Vec5(array[0],array[0],array[0],array[0],array[0]);
  } else if (array.length == 2){
    return new Vec5(array[0],array[1],0,0,0) ;
  } else if (array.length == 3){
    return new Vec5(array[0],array[1],array[2],0,0) ;
  } else if (array.length == 4){
    return new Vec5(array[0],array[1],array[2],array[3],0) ;
  }  else if (array.length > 4){
    return new Vec5(array[0],array[1],array[2],array[3],array[4]) ;
  } else {
    return null;
  }
}

Vec5 Vec5(float v) {
  return new Vec5(v,v,v,v,v);
}

Vec5 Vec5(PVector p) {
  if(p == null) {
    return new Vec5(0,0,0,0,0);
  } else {
    return new Vec5(p.x, p.y, p.z, 0,0);
  }
}
// build with Vec
Vec5 Vec5(Vec p) {
  if(p == null) {
    return new Vec5(0,0,0,0,0);
  } else if(p instanceof Vec5 || p instanceof Vec6) {
    return new Vec5(p.a,p.b,p.c,p.d,p.e);
  } else {
    return new Vec5(p.x,p.y,p.z,p.w,p.e);
  }
}

Vec5 Vec5(iVec p) {
  if(p == null) {
    return new Vec5(0,0,0,0,0);
  }  else if(p instanceof iVec5 || p instanceof iVec6) {
    return new Vec5(p.a,p.b,p.c,p.d,p.e);
  } else {
    return new Vec5(p.x,p.y,p.z,p.w,p.e);
  }
}


Vec5 Vec5(String s, int a, int b, int c, int d, int e) { 
  return new Vec5(s,a,b,c,d,e);
}

Vec5 Vec5(String s, int a, int b, int c, int d, int e, int f, int g, int h, int i, int j) { 
  return new Vec5(s,a,b,c,d,e,f,g,h,i,j);
}

Vec5 Vec5(String s, int v) {
  return new Vec5(s,v);
}
/**
Vec 6
*/
Vec6 Vec6() {
  return new Vec6(0,0,0,0,0,0) ;
}

Vec6 Vec6(float a, float b, float c, float d, float e, float f) {
  return new Vec6(a,b,c,d,e,f);
}

Vec6 Vec6(float [] array) {
  if(array.length == 1) {
    return new Vec6(array[0],array[0],array[0],array[0],array[0],array[0]);
  } else if (array.length == 2){
    return new Vec6(array[0],array[1],0,0,0,0) ;
  } else if (array.length == 3){
    return new Vec6(array[0],array[1],array[2],0,0,0) ;
  } else if (array.length == 4){
    return new Vec6(array[0],array[1],array[2],array[3],0,0) ;
  } else if (array.length == 5){
    return new Vec6(array[0],array[1],array[2],array[3],array[4],0) ;
  }  else if (array.length > 5){
    return new Vec6(array[0],array[1],array[2],array[3],array[4],array[5]) ;
  } else {
    return null;
  }
}

Vec6 Vec6(int [] array) {
  if(array.length == 1) {
    return new Vec6(array[0],array[0],array[0],array[0],array[0],array[0]);
  } else if (array.length == 2){
    return new Vec6(array[0],array[1],0,0,0,0) ;
  } else if (array.length == 3){
    return new Vec6(array[0],array[1],array[2],0,0,0) ;
  } else if (array.length == 4){
    return new Vec6(array[0],array[1],array[2],array[3],0,0) ;
  } else if (array.length == 5){
    return new Vec6(array[0],array[1],array[2],array[3],array[4],0) ;
  }  else if (array.length > 5){
    return new Vec6(array[0],array[1],array[2],array[3],array[4],array[5]) ;
  } else {
    return null;
  }
}

Vec6 Vec6(float v) {
  return new Vec6(v,v,v,v,v,v);
}
Vec6 Vec6(PVector p) {
  if(p == null) {
    return new Vec6(0,0,0,0,0,0);
  } else {
    return new Vec6(p.x, p.y, p.z, 0,0,0);
  }
}

// build with vec
Vec6 Vec6(Vec p) {
  if(p == null) {
    return new Vec6(0,0,0,0,0,0);
  } else if(p instanceof Vec5 || p instanceof Vec6) {
    return new Vec6(p.a,p.b,p.c,p.d,p.e,p.f);
  } else {
    return new Vec6(p.x,p.y,p.z,p.w,p.e,p.f);
  }
}

Vec6 Vec6(iVec p) {
  if(p == null) {
    return new Vec6(0,0,0,0,0,0) ;
  } else if(p instanceof iVec5 || p instanceof iVec6) {
    return new Vec6(p.a,p.b,p.c,p.d,p.e,p.f);
  } else {
    return new Vec6(p.x,p.y,p.z,p.w,p.e,p.f);
  }
}



Vec6 Vec6(String s, int a, int b, int c, int d, int e, int f) { 
  return new Vec6(s,a,b,c,d,e,f);
}

Vec6 Vec6(String s, int a, int b, int c, int d, int e, int f, int g, int h, int i, int j, int k, int l) { 
  return new Vec6(s,a,b,c,d,e,f,g,h,i,j,k,l);
}

Vec6 Vec6(String s, int v) {
  return new Vec6(s,v);
}










