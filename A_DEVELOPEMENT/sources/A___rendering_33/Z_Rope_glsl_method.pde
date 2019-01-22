/**
ROPE GLSL METHOD
v 0.0.6
* Copyleft (c) 2019-2019
* Stan le Punk > http://stanlepunk.xyz/
* @author Stan le Punk
* @see https://github.com/StanLepunK/Rope_method
*/

/**
transcription of few common glsl method

/**
mix
*/
float mix(float x, float y, float a) {
  return x*(1-a)+y*a;
}

Vec2 mix(Vec2 x, Vec2 y, Vec2 a) {
  return Vec2(mix(x.x,y.x,a.x),mix(x.y,y.y,a.y));
}

Vec3 mix(Vec3 x, Vec3 y, Vec3 a) {
  return Vec3(mix(x.x,y.x,a.x),mix(x.y,y.y,a.y),mix(x.z,y.z,a.z));
}

Vec4 mix(Vec4 x, Vec4 y, Vec4 a) {
  return Vec4(mix(x.x,y.x,a.x),mix(x.y,y.y,a.y),mix(x.z,y.z,a.z),mix(x.w,y.w,a.w));
}

/**
fract
*/
float fract(float x) {
  return x - floor(x);
}

Vec2 fract(Vec2 v) {
  return Vec2(fract(v.x),fract(v.y));
}

Vec3 fract(Vec3 v) {
  return Vec3(fract(v.x),fract(v.y),fract(v.z));
}

Vec4 fract(Vec4 v) {
  return Vec4(fract(v.x),fract(v.y),fract(v.z),fract(v.w));
}

/**
sign
*/
float sign(float x) {
  if(x < 0 ) {
    return -1.;
  } else if(x > 0) {
    return 1. ;
  } else return 0.0;
}

Vec2 sign(Vec2 x) {
  return Vec2(sign(x.x),sign(x.y));
}

Vec3 sign(Vec3 x) {
  return Vec3(sign(x.x),sign(x.y),sign(x.z));
}

Vec4 sign(Vec4 x) {
  return Vec4(sign(x.x),sign(x.y),sign(x.z),sign(x.w));
}


int sign(int x) {
  return int(sign(float(x)));
}

iVec2 sign(iVec2 x) {
  return iVec2(sign(x.x),sign(x.y));
}

iVec3 sign(iVec3 x) {
  return iVec3(sign(x.x),sign(x.y),sign(x.z));
}

iVec4 sign(iVec4 x) {
  return iVec4(sign(x.x),sign(x.y),sign(x.z),sign(x.w));
}


/**
step
*/
float step(float edge, float x) {
  if(x < edge) return 0; else return 1;
}

Vec2 step(Vec2 edge, Vec2 x) {
  return Vec2(step(edge.x,x.x),step(edge.y,x.y));
}

Vec3 step(Vec3 edge, Vec3 x) {
  return Vec3(step(edge.x,x.x),step(edge.y,x.y),step(edge.z,x.z));
}

Vec4 step(Vec4 edge, Vec4 x) {
  return Vec4(step(edge.x,x.x),step(edge.y,x.y),step(edge.z,x.z),step(edge.w,x.w));
}


/**
smoothstep
*/
float smoothstep(float edge0, float edge1, float x) {
  if(x <= edge0) {
    return 0; 
  } else if(x >= edge1) {
    return 1;
  } else {
    float t = clamp((x-edge0)/(edge1-edge0),0.,1.);
    return t*t*(3.-2.*t);
  }
}

Vec2 smoothstep(Vec2 edge0, Vec2 edge1, Vec2 x) {
  return Vec2(smoothstep(edge0.x,edge1.x,x.x),smoothstep(edge0.y,edge1.y,x.y));
}

Vec3 smoothstep(Vec3 edge0, Vec3 edge1, Vec3 x) {
  return Vec3(smoothstep(edge0.x,edge1.x,x.x),smoothstep(edge0.y,edge1.y,x.y),smoothstep(edge0.z,edge1.z,x.z));
}

Vec4 smoothstep(Vec4 edge0, Vec4 edge1, Vec4 x) {
  return Vec4(smoothstep(edge0.x,edge1.x,x.x),smoothstep(edge0.y,edge1.y,x.y),smoothstep(edge0.z,edge1.z,x.z),smoothstep(edge0.w,edge1.w,x.w));
}



/*
mod
*/
float mod(float x, float y) {
  return x-y*floor(x/y);
}

Vec2 mod(Vec2 x, Vec2 y) {
  return Vec2(mod(x.x,y.x),mod(x.y,y.y));
}

Vec3 mod(Vec3 x, Vec3 y) {
  return Vec3(mod(x.x,y.x),mod(x.y,y.y),mod(x.z,y.z));
}

Vec4 mod(Vec4 x, Vec4 y) {
  return Vec4(mod(x.x,y.x),mod(x.y,y.y),mod(x.z,y.z),mod(x.w,y.w));
}

iVec2 mod(iVec2 x, iVec2 y) {
  return iVec2(mod(x.x,y.x),mod(x.y,y.y));
}

iVec3 mod(iVec3 x, iVec3 y) {
  return iVec3(mod(x.x,y.x),mod(x.y,y.y),mod(x.z,y.z));
}

iVec4 mod(iVec4 x, iVec4 y) {
  return iVec4(mod(x.x,y.x),mod(x.y,y.y),mod(x.z,y.z),mod(x.w,y.w));
}

/**
clamp
*/
float clamp(float x, float min, float max) {
  return min(max(x,min),max);
}

Vec2 clamp(Vec2 x, Vec2 min, Vec2 max) {
  return min(max(x,min),max);
}

Vec3 clamp(Vec3 x, Vec3 min, Vec3 max) {
  return min(max(x,min),max);
}

Vec4 clamp(Vec4 x, Vec4 min, Vec4 max) {
  return min(max(x,min),max);
}




/**
equal
*/
boolean equal(float x, float y) {
  return x==y?true:false;
}

boolean equal(int x, int y) {
  return equal((float)x,(float)y);
}

// with Vec
bVec2 equal(Vec2 x, Vec2 y) {
  if(x != null && y != null) {
    return bVec2(equal(x.x,y.x),equal(x.y,y.y));
  } else return null;
}

bVec3 equal(Vec3 x, Vec3 y) {
  if(x != null && y != null) {
    return bVec3(equal(x.x,y.x),equal(x.y,y.y),equal(x.z,y.z));
  } else return null;
}

bVec4 equal(Vec4 x, Vec4 y) {
  if(x != null && y != null) {
    return bVec4(equal(x.x,y.x),equal(x.y,y.y),equal(x.z,y.z),equal(x.w,y.w));
  } else return null;
}

// width iVec
bVec2 equal(iVec2 x, iVec2 y) {
  if(x != null && y != null) {
    return bVec2(equal(x.x,y.x),equal(x.y,y.y));
  } else return null;
}

bVec3 equal(iVec3 x, iVec3 y) {
  if(x != null && y != null) {
    return bVec3(equal(x.x,y.x),equal(x.y,y.y),equal(x.z,y.z));
  } else return null;
}

bVec4 equal(iVec4 x, iVec4 y) {
  if(x != null && y != null) {
    return bVec4(equal(x.x,y.x),equal(x.y,y.y),equal(x.z,y.z),equal(x.w,y.w));
  } else return null;
}




/**
lessThan
*/
boolean lessThan(float x, float y) {
  return x<y?true:false;
}

boolean lessThan(int x, int y) {
  return lessThan((float)x,(float)y);
}

// with Vec
bVec2 lessThan(Vec2 x, Vec2 y) {
  if(x != null && y != null) {
    return bVec2(lessThan(x.x,y.x),lessThan(x.y,y.y));
  } else return null;
}

bVec3 lessThan(Vec3 x, Vec3 y) {
  if(x != null && y != null) {
    return bVec3(lessThan(x.x,y.x),lessThan(x.y,y.y),lessThan(x.z,y.z));
  } else return null;
}

bVec4 lessThan(Vec4 x, Vec4 y) {
  if(x != null && y != null) {
    return bVec4(lessThan(x.x,y.x),lessThan(x.y,y.y),lessThan(x.z,y.z),lessThan(x.w,y.w));
  } else return null;
}

// width iVec
bVec2 lessThan(iVec2 x, iVec2 y) {
  if(x != null && y != null) {
    return bVec2(lessThan(x.x,y.x),lessThan(x.y,y.y));
  } else return null;
}

bVec3 lessThan(iVec3 x, iVec3 y) {
  if(x != null && y != null) {
    return bVec3(lessThan(x.x,y.x),lessThan(x.y,y.y),lessThan(x.z,y.z));
  } else return null;
}

bVec4 lessThan(iVec4 x, iVec4 y) {
  if(x != null && y != null) {
    return bVec4(lessThan(x.x,y.x),lessThan(x.y,y.y),lessThan(x.z,y.z),lessThan(x.w,y.w));
  } else return null;
}





/**
greaterThan
*/
boolean greaterThan(float x, float y) {
  return x>y?true:false;
}

boolean greaterThan(int x, int y) {
  return greaterThan((float)x,(float)y);
}

// with Vec
bVec2 greaterThan(Vec2 x, Vec2 y) {
  if(x != null && y != null) {
    return bVec2(greaterThan(x.x,y.x),greaterThan(x.y,y.y));
  } else return null; 
}

bVec3 greaterThan(Vec3 x, Vec3 y) {
  if(x != null && y != null) {
    return bVec3(greaterThan(x.x,y.x),greaterThan(x.y,y.y),greaterThan(x.z,y.z));
  } else return null; 
}

bVec4 greaterThan(Vec4 x, Vec4 y) {
  if(x != null && y != null) {
    return bVec4(greaterThan(x.x,y.x),greaterThan(x.y,y.y),greaterThan(x.z,y.z),greaterThan(x.w,y.w));
  } else return null; 
}

// width iVec
bVec2 greaterThan(iVec2 x, iVec2 y) {
  if(x != null && y != null) {
    return bVec2(greaterThan(x.x,y.x),greaterThan(x.y,y.y));
  } else return null; 
}

bVec3 greaterThan(iVec3 x, iVec3 y) {
  if(x != null && y != null) {
    return bVec3(greaterThan(x.x,y.x),greaterThan(x.y,y.y),greaterThan(x.z,y.z));
  } else return null; 
}

bVec4 greaterThan(iVec4 x, iVec4 y) {
  if(x != null && y != null) {
    return bVec4(greaterThan(x.x,y.x),greaterThan(x.y,y.y),greaterThan(x.z,y.z),greaterThan(x.w,y.w));
  } else return null; 
}






/**
greaterThanEqual
*/
boolean greaterThanEqual(float x, float y) {
  return x>=y?true:false;
}

boolean greaterThanEqual(int x, int y) {
  return greaterThanEqual((float)x,(float)y);
}

// with Vec
bVec2 greaterThanEqual(Vec2 x, Vec2 y) {
  if(x != null && y != null) {
    return bVec2(greaterThanEqual(x.x,y.x),greaterThanEqual(x.y,y.y));
  } else return null; 
}

bVec3 greaterThanEqual(Vec3 x, Vec3 y) {
  if(x != null && y != null) {
    return bVec3(greaterThanEqual(x.x,y.x),greaterThanEqual(x.y,y.y),greaterThanEqual(x.z,y.z));
  } else return null; 
}

bVec4 greaterThanEqual(Vec4 x, Vec4 y) {
  if(x != null && y != null) {
    return bVec4(greaterThanEqual(x.x,y.x),greaterThanEqual(x.y,y.y),greaterThanEqual(x.z,y.z),greaterThanEqual(x.w,y.w));
  } else return null; 
}

// width iVec
bVec2 greaterThanEqual(iVec2 x, iVec2 y) {
  if(x != null && y != null) {
    return bVec2(greaterThanEqual(x.x,y.x),greaterThanEqual(x.y,y.y));
  } else return null; 
}

bVec3 greaterThanEqual(iVec3 x, iVec3 y) {
  if(x != null && y != null) {
    return bVec3(greaterThanEqual(x.x,y.x),greaterThanEqual(x.y,y.y),greaterThanEqual(x.z,y.z));
  } else return null; 
}

bVec4 greaterThanEqual(iVec4 x, iVec4 y) {
  if(x != null && y != null) {
    return bVec4(greaterThanEqual(x.x,y.x),greaterThanEqual(x.y,y.y),greaterThanEqual(x.z,y.z),greaterThanEqual(x.w,y.w));
  } else return null; 
}






/**
lessThanEqual
*/
boolean lessThanEqual(float x, float y) {
  return x<=y?true:false;
}

boolean lessThanEqual(int x, int y) {
  return lessThanEqual((float)x,(float)y);
}

// with Vec
bVec2 lessThanEqual(Vec2 x, Vec2 y) {
  if(x != null && y != null) {
    return bVec2(lessThanEqual(x.x,y.x),lessThanEqual(x.y,y.y));
  } else return null; 
}

bVec3 lessThanEqual(Vec3 x, Vec3 y) {
  if(x != null && y != null) {
    return bVec3(lessThanEqual(x.x,y.x),lessThanEqual(x.y,y.y),lessThanEqual(x.z,y.z));
  } else return null; 
}

bVec4 lessThanEqual(Vec4 x, Vec4 y) {
  if(x != null && y != null) {
    return bVec4(lessThanEqual(x.x,y.x),lessThanEqual(x.y,y.y),lessThanEqual(x.z,y.z),lessThanEqual(x.w,y.w));
  } else return null; 
}

// width iVec
bVec2 lessThanEqual(iVec2 x, iVec2 y) {
  if(x != null && y != null) {
    return bVec2(lessThanEqual(x.x,y.x),lessThanEqual(x.y,y.y));
  } else return null; 
}

bVec3 lessThanEqual(iVec3 x, iVec3 y) {
  if(x != null && y != null) {
    return bVec3(lessThanEqual(x.x,y.x),lessThanEqual(x.y,y.y),lessThanEqual(x.z,y.z));
  } else return null; 
}

bVec4 lessThanEqual(iVec4 x, iVec4 y) {
  if(x != null && y != null) {
    return bVec4(lessThanEqual(x.x,y.x),lessThanEqual(x.y,y.y),lessThanEqual(x.z,y.z),lessThanEqual(x.w,y.w));
  } else return null; 
}







/**
all
*/
boolean all(bVec2 b) {
  if(b != null) {
    boolean [] list = b.array();
    boolean result = true;
    for(int i = 0 ; i < list.length ; i++) {
      if(list[i] == false) {
        result = false;
        break;
      }
    }
    return result;
  } else {
    printErr("method all() return false because argument is",b);
    return false;
  }
}

boolean all(bVec3 b) {
  if(b != null) {
    boolean [] list = b.array();
    boolean result = true;
    for(int i = 0 ; i < list.length ; i++) {
      if(list[i] == false) {
        result = false;
        break;
      }
    }
    return result;
  } else {
    printErr("method all() return false because argument is",b);
    return false;
  }
}

boolean all(bVec4 b) {
  if(b != null) {
    boolean [] list = b.array();
    boolean result = true;
    for(int i = 0 ; i < list.length ; i++) {
      if(list[i] == false) {
        result = false;
        break;
      }
    }
    return result;
  } else {
    printErr("method all() return false because argument is",b);
    return false;
  }
}

boolean all(bVec5 b) {
  if(b != null) {
    boolean [] list = b.array();
    boolean result = true;
    for(int i = 0 ; i < list.length ; i++) {
      if(list[i] == false) {
        result = false;
        break;
      }
    }
    return result;
  } else {
    printErr("method all() return false because argument is",b);
    return false;
  }
}

boolean all(bVec6 b) {
  if(b != null) {
    boolean [] list = b.array();
    boolean result = true;
    for(int i = 0 ; i < list.length ; i++) {
      if(list[i] == false) {
        result = false;
        break;
      }
    }
    return result;
  } else {
    printErr("method all() return false because argument is",b);
    return false;
  }
}




/**
any
*/
boolean any(bVec2 b) {
  if(b != null) {
    boolean [] list = b.array();
    boolean result = false;
    for(int i = 0 ; i < list.length ; i++) {
      if(list[i] == true) {
        result = true;
        break;
      }
    }
    return result;
  } else {
    printErr("method any() return false because argument is",b);
    return false;
  }
}

boolean any(bVec3 b) {
  if(b != null) {
    boolean [] list = b.array();
    boolean result = false;
    for(int i = 0 ; i < list.length ; i++) {
      if(list[i] == true) {
        result = true;
        break;
      }
    }
    return result;
  } else {
    printErr("method any() return false because argument is",b);
    return false;
  }
}

boolean any(bVec4 b) {
  if(b != null) {
    boolean [] list = b.array();
    boolean result = false;
    for(int i = 0 ; i < list.length ; i++) {
      if(list[i] == true) {
        result = true;
        break;
      }
    }
    return result;
  } else {
    printErr("method any() return false because argument is",b);
    return false;
  }
}

boolean any(bVec5 b) {
  if(b != null) {
    boolean [] list = b.array();
    boolean result = false;
    for(int i = 0 ; i < list.length ; i++) {
      if(list[i] == true) {
        result = true;
        break;
      }
    }
    return result;
  } else {
    printErr("method any() return false because argument is",b);
    return false;
  }
}

boolean any(bVec6 b) {
  if(b != null) {
    boolean [] list = b.array();
    boolean result = false;
    for(int i = 0 ; i < list.length ; i++) {
      if(list[i] == true) {
        result = true;
        break;
      }
    }
    return result;
  } else {
    printErr("method any() return false because argument is",b);
    return false;
  }
}


