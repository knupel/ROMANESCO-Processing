/**
ROPE GLSL METHOD
v 0.0.6
* Copyleft (c) 2019-2019
* @author @stanlepunk
* @see https://github.com/StanLepunK/Rope_framework
*/

/**
transcription of few common glsl method

/**
mix
*/
float mix(float x, float y, float a) {
  return x*(1-a)+y*a;
}

vec2 mix(vec2 x, vec2 y, vec2 a) {
  return vec2(mix(x.x,y.x,a.x),mix(x.y,y.y,a.y));
}

vec3 mix(vec3 x, vec3 y, vec3 a) {
  return vec3(mix(x.x,y.x,a.x),mix(x.y,y.y,a.y),mix(x.z,y.z,a.z));
}

vec4 mix(vec4 x, vec4 y, vec4 a) {
  return vec4(mix(x.x,y.x,a.x),mix(x.y,y.y,a.y),mix(x.z,y.z,a.z),mix(x.w,y.w,a.w));
}

/**
fract
*/
float fract(float x) {
  return x - floor(x);
}

vec2 fract(vec2 v) {
  return vec2(fract(v.x),fract(v.y));
}

vec3 fract(vec3 v) {
  return vec3(fract(v.x),fract(v.y),fract(v.z));
}

vec4 fract(vec4 v) {
  return vec4(fract(v.x),fract(v.y),fract(v.z),fract(v.w));
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

vec2 sign(vec2 x) {
  return vec2(sign(x.x),sign(x.y));
}

vec3 sign(vec3 x) {
  return vec3(sign(x.x),sign(x.y),sign(x.z));
}

vec4 sign(vec4 x) {
  return vec4(sign(x.x),sign(x.y),sign(x.z),sign(x.w));
}


int sign(int x) {
  return int(sign(float(x)));
}

ivec2 sign(ivec2 x) {
  return ivec2(sign(x.x),sign(x.y));
}

ivec3 sign(ivec3 x) {
  return ivec3(sign(x.x),sign(x.y),sign(x.z));
}

ivec4 sign(ivec4 x) {
  return ivec4(sign(x.x),sign(x.y),sign(x.z),sign(x.w));
}


/**
step
*/
float step(float edge, float x) {
  if(x < edge) return 0; else return 1;
}

vec2 step(vec2 edge, vec2 x) {
  return vec2(step(edge.x,x.x),step(edge.y,x.y));
}

vec3 step(vec3 edge, vec3 x) {
  return vec3(step(edge.x,x.x),step(edge.y,x.y),step(edge.z,x.z));
}

vec4 step(vec4 edge, vec4 x) {
  return vec4(step(edge.x,x.x),step(edge.y,x.y),step(edge.z,x.z),step(edge.w,x.w));
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

vec2 smoothstep(vec2 edge0, vec2 edge1, vec2 x) {
  return vec2(smoothstep(edge0.x,edge1.x,x.x),smoothstep(edge0.y,edge1.y,x.y));
}

vec3 smoothstep(vec3 edge0, vec3 edge1, vec3 x) {
  return vec3(smoothstep(edge0.x,edge1.x,x.x),smoothstep(edge0.y,edge1.y,x.y),smoothstep(edge0.z,edge1.z,x.z));
}

vec4 smoothstep(vec4 edge0, vec4 edge1, vec4 x) {
  return vec4(smoothstep(edge0.x,edge1.x,x.x),smoothstep(edge0.y,edge1.y,x.y),smoothstep(edge0.z,edge1.z,x.z),smoothstep(edge0.w,edge1.w,x.w));
}



/*
mod
*/
float mod(float x, float y) {
  return x-y*floor(x/y);
}

vec2 mod(vec2 x, vec2 y) {
  return vec2(mod(x.x,y.x),mod(x.y,y.y));
}

vec3 mod(vec3 x, vec3 y) {
  return vec3(mod(x.x,y.x),mod(x.y,y.y),mod(x.z,y.z));
}

vec4 mod(vec4 x, vec4 y) {
  return vec4(mod(x.x,y.x),mod(x.y,y.y),mod(x.z,y.z),mod(x.w,y.w));
}

ivec2 mod(ivec2 x, ivec2 y) {
  return ivec2(mod(x.x,y.x),mod(x.y,y.y));
}

ivec3 mod(ivec3 x, ivec3 y) {
  return ivec3(mod(x.x,y.x),mod(x.y,y.y),mod(x.z,y.z));
}

ivec4 mod(ivec4 x, ivec4 y) {
  return ivec4(mod(x.x,y.x),mod(x.y,y.y),mod(x.z,y.z),mod(x.w,y.w));
}

/**
clamp
*/
float clamp(float x, float min, float max) {
  return min(max(x,min),max);
}

vec2 clamp(vec2 x, vec2 min, vec2 max) {
  return min(max(x,min),max);
}

vec3 clamp(vec3 x, vec3 min, vec3 max) {
  return min(max(x,min),max);
}

vec4 clamp(vec4 x, vec4 min, vec4 max) {
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

// with vec
bvec2 equal(vec2 x, vec2 y) {
  if(x != null && y != null) {
    return bvec2(equal(x.x,y.x),equal(x.y,y.y));
  } else return null;
}

bvec3 equal(vec3 x, vec3 y) {
  if(x != null && y != null) {
    return bvec3(equal(x.x,y.x),equal(x.y,y.y),equal(x.z,y.z));
  } else return null;
}

bvec4 equal(vec4 x, vec4 y) {
  if(x != null && y != null) {
    return bvec4(equal(x.x,y.x),equal(x.y,y.y),equal(x.z,y.z),equal(x.w,y.w));
  } else return null;
}

// width ivec
bvec2 equal(ivec2 x, ivec2 y) {
  if(x != null && y != null) {
    return bvec2(equal(x.x,y.x),equal(x.y,y.y));
  } else return null;
}

bvec3 equal(ivec3 x, ivec3 y) {
  if(x != null && y != null) {
    return bvec3(equal(x.x,y.x),equal(x.y,y.y),equal(x.z,y.z));
  } else return null;
}

bvec4 equal(ivec4 x, ivec4 y) {
  if(x != null && y != null) {
    return bvec4(equal(x.x,y.x),equal(x.y,y.y),equal(x.z,y.z),equal(x.w,y.w));
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

// with vec
bvec2 lessThan(vec2 x, vec2 y) {
  if(x != null && y != null) {
    return bvec2(lessThan(x.x,y.x),lessThan(x.y,y.y));
  } else return null;
}

bvec3 lessThan(vec3 x, vec3 y) {
  if(x != null && y != null) {
    return bvec3(lessThan(x.x,y.x),lessThan(x.y,y.y),lessThan(x.z,y.z));
  } else return null;
}

bvec4 lessThan(vec4 x, vec4 y) {
  if(x != null && y != null) {
    return bvec4(lessThan(x.x,y.x),lessThan(x.y,y.y),lessThan(x.z,y.z),lessThan(x.w,y.w));
  } else return null;
}

// width ivec
bvec2 lessThan(ivec2 x, ivec2 y) {
  if(x != null && y != null) {
    return bvec2(lessThan(x.x,y.x),lessThan(x.y,y.y));
  } else return null;
}

bvec3 lessThan(ivec3 x, ivec3 y) {
  if(x != null && y != null) {
    return bvec3(lessThan(x.x,y.x),lessThan(x.y,y.y),lessThan(x.z,y.z));
  } else return null;
}

bvec4 lessThan(ivec4 x, ivec4 y) {
  if(x != null && y != null) {
    return bvec4(lessThan(x.x,y.x),lessThan(x.y,y.y),lessThan(x.z,y.z),lessThan(x.w,y.w));
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

// with vec
bvec2 greaterThan(vec2 x, vec2 y) {
  if(x != null && y != null) {
    return bvec2(greaterThan(x.x,y.x),greaterThan(x.y,y.y));
  } else return null; 
}

bvec3 greaterThan(vec3 x, vec3 y) {
  if(x != null && y != null) {
    return bvec3(greaterThan(x.x,y.x),greaterThan(x.y,y.y),greaterThan(x.z,y.z));
  } else return null; 
}

bvec4 greaterThan(vec4 x, vec4 y) {
  if(x != null && y != null) {
    return bvec4(greaterThan(x.x,y.x),greaterThan(x.y,y.y),greaterThan(x.z,y.z),greaterThan(x.w,y.w));
  } else return null; 
}

// width ivec
bvec2 greaterThan(ivec2 x, ivec2 y) {
  if(x != null && y != null) {
    return bvec2(greaterThan(x.x,y.x),greaterThan(x.y,y.y));
  } else return null; 
}

bvec3 greaterThan(ivec3 x, ivec3 y) {
  if(x != null && y != null) {
    return bvec3(greaterThan(x.x,y.x),greaterThan(x.y,y.y),greaterThan(x.z,y.z));
  } else return null; 
}

bvec4 greaterThan(ivec4 x, ivec4 y) {
  if(x != null && y != null) {
    return bvec4(greaterThan(x.x,y.x),greaterThan(x.y,y.y),greaterThan(x.z,y.z),greaterThan(x.w,y.w));
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

// with vec
bvec2 greaterThanEqual(vec2 x, vec2 y) {
  if(x != null && y != null) {
    return bvec2(greaterThanEqual(x.x,y.x),greaterThanEqual(x.y,y.y));
  } else return null; 
}

bvec3 greaterThanEqual(vec3 x, vec3 y) {
  if(x != null && y != null) {
    return bvec3(greaterThanEqual(x.x,y.x),greaterThanEqual(x.y,y.y),greaterThanEqual(x.z,y.z));
  } else return null; 
}

bvec4 greaterThanEqual(vec4 x, vec4 y) {
  if(x != null && y != null) {
    return bvec4(greaterThanEqual(x.x,y.x),greaterThanEqual(x.y,y.y),greaterThanEqual(x.z,y.z),greaterThanEqual(x.w,y.w));
  } else return null; 
}

// width ivec
bvec2 greaterThanEqual(ivec2 x, ivec2 y) {
  if(x != null && y != null) {
    return bvec2(greaterThanEqual(x.x,y.x),greaterThanEqual(x.y,y.y));
  } else return null; 
}

bvec3 greaterThanEqual(ivec3 x, ivec3 y) {
  if(x != null && y != null) {
    return bvec3(greaterThanEqual(x.x,y.x),greaterThanEqual(x.y,y.y),greaterThanEqual(x.z,y.z));
  } else return null; 
}

bvec4 greaterThanEqual(ivec4 x, ivec4 y) {
  if(x != null && y != null) {
    return bvec4(greaterThanEqual(x.x,y.x),greaterThanEqual(x.y,y.y),greaterThanEqual(x.z,y.z),greaterThanEqual(x.w,y.w));
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

// with vec
bvec2 lessThanEqual(vec2 x, vec2 y) {
  if(x != null && y != null) {
    return bvec2(lessThanEqual(x.x,y.x),lessThanEqual(x.y,y.y));
  } else return null; 
}

bvec3 lessThanEqual(vec3 x, vec3 y) {
  if(x != null && y != null) {
    return bvec3(lessThanEqual(x.x,y.x),lessThanEqual(x.y,y.y),lessThanEqual(x.z,y.z));
  } else return null; 
}

bvec4 lessThanEqual(vec4 x, vec4 y) {
  if(x != null && y != null) {
    return bvec4(lessThanEqual(x.x,y.x),lessThanEqual(x.y,y.y),lessThanEqual(x.z,y.z),lessThanEqual(x.w,y.w));
  } else return null; 
}

// width ivec
bvec2 lessThanEqual(ivec2 x, ivec2 y) {
  if(x != null && y != null) {
    return bvec2(lessThanEqual(x.x,y.x),lessThanEqual(x.y,y.y));
  } else return null; 
}

bvec3 lessThanEqual(ivec3 x, ivec3 y) {
  if(x != null && y != null) {
    return bvec3(lessThanEqual(x.x,y.x),lessThanEqual(x.y,y.y),lessThanEqual(x.z,y.z));
  } else return null; 
}

bvec4 lessThanEqual(ivec4 x, ivec4 y) {
  if(x != null && y != null) {
    return bvec4(lessThanEqual(x.x,y.x),lessThanEqual(x.y,y.y),lessThanEqual(x.z,y.z),lessThanEqual(x.w,y.w));
  } else return null; 
}







/**
all
v 0.0.2
*/
boolean all(bvec2 b) {
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
    printErr("method all(bvec2 b) return false because argument is",b);
    return false;
  }
}

boolean all(bvec3 b) {
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
    printErr("method all(bvec3 b) return false because argument is",b);
    return false;
  }
}

boolean all(bvec4 b) {
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
    printErr("method all(bvec4 b) return false because argument is",b);
    return false;
  }
}

boolean all(bvec5 b) {
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
    printErr("method all(bvec5 b) return false because argument is",b);
    return false;
  }
}

boolean all(bvec6 b) {
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
    printErr("method all(bvec6 b) return false because argument is",b);
    return false;
  }
}




/**
any
*/
boolean any(bvec2 b) {
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

boolean any(bvec3 b) {
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

boolean any(bvec4 b) {
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

boolean any(bvec5 b) {
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

boolean any(bvec6 b) {
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
