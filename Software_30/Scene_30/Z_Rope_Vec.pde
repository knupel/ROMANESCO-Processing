/**
CLASS ROPE VEC 1.8.5.0
Rope – Romanesco Processing Environment: 2015–2017
* @author Stan le Punk
* @see https://github.com/StanLepunK/Vec
* inspireted by GLSL code and PVector from Daniel Shiffman
* ROPE is not add before Vec, because is too long, and little too much to have something like
* that RopeVec(), ROVec(), RPEVec() or RVec(), plus there is no confusion with PVector, so stay simple !
*/
/**
Vec Master

*/
abstract class Vec {
  /**
  may be remove ref in the future
  */
  float ref_x, ref_y, ref_z, ref_w = Float.NaN  ;
  float x,y,z,w = Float.NaN ;
  float a,b,c,d,e,f = Float.NaN  ;
  float r,g = Float.NaN ;
  float s,t,p,q = Float.NaN ;
  float u,v = Float.NaN;

  Vec() {}
}

/**
VEC 2

*/
class Vec2 extends Vec {

  Vec2(float x, float y) {
    super() ;
    this.ref_x = this.x = this.s = this.u = x ;
    this.ref_y = this.y = this.t = this.v = y ;
  }
  /**
  Random constructor
  */
  Vec2(String key_random, int r1) {
    super() ;
    if(key_random.equals("RANDOM")) {
      this.ref_x = this.x = this.s = this.u = random(-r1,r1) ;
      this.ref_y = this.y = this.t = this.v = random(-r1,r1) ;
    } else if(key_random.equals("RANDOM ZERO")) {
      this.ref_x = this.x = this.s = this.u = random(0,r1) ;
      this.ref_y = this.y = this.t = this.v = random(0,r1) ;
    } else {
      this.ref_x = this.ref_y = this.x = this.y = this.s = this.t = this.u = this.v = 0 ;
      println("the key word for the random is not available use the String 'RANDOM' or 'RANDOM ZERO' ") ;
    }
  }
  
  Vec2(String key_random, int r1, int r2) {
    super() ;
    if(key_random.equals("RANDOM")) {
      this.ref_x = this.x = this.s = this.u = random(-r1,r1) ;
      this.ref_y = this.y = this.t = this.v = random(-r2,r2) ;
    } else if(key_random.equals("RANDOM ZERO")) {
      this.ref_x = this.x = this.s = this.u = random(0,r1) ;
      this.ref_y = this.y = this.t = this.v = random(0,r2) ;
    } else if(key_random.equals("RANDOM RANGE")) {
      this.ref_x = this.x = this.s = this.u = random(r1,r2) ;
      this.ref_y = this.y = this.t = this.v = random(r1,r2) ;
    } else {
      this.ref_x = this.ref_y = this.x = this.y = this.s = this.t = this.u = this.v = 0 ;
      println("the key word for the random is not available use the String 'RANDOM' or 'RANDOM ZERO' or 'RANDOM RANGE' ") ;
    }
  }

  Vec2(String key_random, int a1, int a2, int b1, int b2) {
    super() ;
    if(key_random.equals("RANDOM RANGE")) {
      this.ref_x = this.x = this.s = this.u = random(a1,a2) ;
      this.ref_y = this.y = this.t = this.v = random(b1,b2) ;
    } else {
      this.ref_x = this.ref_y = this.x = this.y = this.s = this.t = this.u = this.v = 0 ;
      println("the key word for the random is not available use the String 'RANDOM RANGE' ") ;
    }
  }
  /**
  Set
  */
   /**
   * Sets components of the vector using two or three separate
   * variables, the data from a Vec, or the values from a float array.
   */
  public Vec2 set(float v) {
    this.x = this.s = this.u = v;
    this.y = this.t = this.v = v ;
    return this;
  }
  public Vec2 set(float x, float y) {
    this.x = this.s = this.u = x ;
    this.y = this.t = this.v = y ;
    return this;
  }


  /**
   * @param v any variable of type Vec
   */
  public Vec2 set(Vec2 v) {
    if(v == null) {
      this.x = this.s = this.u = 0 ;
      this.y = this.t = this.v = 0 ;
      return this;
    } else {
      this.x = this.s = this.u = v.x ;
      this.y = this.t = this.v = v.y ;
      return this;
    }
  }


  /**
   * Set the x, y (and maybe z) coordinates using a float[] array as the source.
   * @param source array to copy from
   */
  public Vec2 set(float[] source) {
    this.x = this.s = this.u = source[0];
    this.y = this.t = this.v = source[1];
    return this;
  }

  
  
  
  
  
  
  
  
  /**
  multiplication
  */
  /* multiply Vector by a same float value */
  Vec2 mult(float mult) {
    x *= mult ; 
    y *= mult ;

    set(x,y) ;
    return this ;
  }
  
  /* multiply Vector by different float value */
  Vec2 mult(float mult_x, float mult_y) {
    x *= mult_x ; 
    y *= mult_y ;

    set(x,y) ;
    return this;
  }
  
  // mult by vector
  Vec2 mult(Vec2 v) {
    if(v != null) {
      x *= v.x ; 
      y *= v.y ; 
    }
    set(x,y) ;
    return this;
  }
  
  /**
  division
  */
  /*
  divide Vector by a float value */
  Vec2 div(float div) {
    x /= div ; 
    y /= div ; 
    
    set(x,y) ;
    return this;
    
  }
  
  // divide by vector
  Vec2 div(Vec2 v) {
    if(v != null) {
      x /= v.x ; 
      y /= v.y ;
    }  
    set(x,y) ;
    return this;
  }
  
  
  /** 
  Addition
  */
  /* add float value */
  Vec2 add(float value) {
    x += value ;
    y += value ;
    
    set(x,y) ;
    return this ;
  }

  Vec2 add(float value_a, float value_b) {
    x += value_a ;
    y += value_b ;
    
    set(x,y) ;
    return this ;
  }
  /* add Vector */
  Vec2 add(Vec v) {
    if(v != null) {
      x += v.x ;
      y += v.y ;
    }
    set(x,y) ;
    return this ;
  }
  /* add two Vector together */
  Vec2 add(Vec v_a, Vec v_b) {
    if(v_a != null &&  v_b != null) {
      x = v_a.x + v_b.x ;
      y = v_a.y + v_b.y ;
    }
    set(x,y) ;
    return this ;
  }


  /**
  Substraction
  */
    /* add float value */
  Vec2 sub(float value) {
    x -= value ;
    y -= value ;
    
    set(x,y) ;
    return this ;
  }
  Vec2 sub(float value_a,float value_b) {
    x -= value_a ;
    y -= value_b ;
    
    set(x,y) ;
    return this ;
  }
  /* add one Vector */
  Vec2 sub(Vec v) {
    if(v != null) {
      x -= v.x ;
      y -= v.y ;
    }
    set(x,y) ;
    return this ;
  }
  
  /* add two Vector together */
  Vec2 sub(Vec v_a, Vec v_b) {
    if(v_a != null &&  v_b != null) {
      x = v_a.x - v_b.x ;
      y = v_a.y - v_b.y ;
    }
    set(x,y) ;
    return this ;
  }

  /**
  Average
  */
  float average() {
    return (this.x + this.y) *.5 ;
  }


    /**
  Dot
  */
  public float dot(Vec2 v) {
    if(v != null) {
      return x*v.x + y*v.y ;
    } else {
      println("Your Vec arg is", null) ;
      return x *0 + y *0  ;
    }
  }
  public float dot(float x, float y) {
    return this.x*x + this.y*y ;
  }

  
  
  /**
  Direction
  */
  //return mapping vector
  // @return Vec2
  Vec2 dir() {
    return dir(Vec2(0)) ;
  }
  Vec2 dir(float a_x, float a_y) {
    return dir(Vec2(a_x,a_y)) ;
  }
  Vec2 dir(Vec2 origin) {
    if(origin != null) {
      float dist = dist(origin) ;
      sub(origin) ;
      div(dist) ;
    }
    set(x,y) ;
    return this ;
  }


  /**
  Tangent
  */
  Vec2 tan() {
    return tan(Vec2(x,y)) ;
  }
  Vec2 tan(float a_x, float a_y) {
    return tan(Vec2(a_x,a_y)) ;
  }

  Vec2 tan(Vec2 target) {
    if(target != null) {
      float mag = mag() ;
      target.div(mag) ;
      x = -target.y ;
      y = target.x ;
    }
    set(x,y) ;
    return this ;
  }
  

  /**
  Min Max
  */
    // find the min and the max value in the vector list
  // @ float
  float max_vec() {
    float [] list = { x, y} ;
    return max(list) ;
  }
  float min_vec() {
    float [] list = { x, y} ;
    return min(list) ;
  }

  /**
  Normalize
  */
  /*
  return mapping vector
  @return Vec2
  */
  /*
  Vec2 normalize(Vec2 min, Vec2 max) {
    if(min != null && max != null) {
      x = map(x, min.x, max.x, 0, 1) ;
      y = map(y, min.y, max.y, 0, 1) ;
    }
    set(x,y) ;
    return this ;
  }
  */
  
  
  Vec2 normalize(Vec2 target) {
    if (target == null) {
      target = Vec2();
    }
    float m = mag();
    if (m > 0) {
      target.set(x/m, y/m);
    } else {
      target.set(x, y);
    }
    return target;
  }

  Vec2 normalize() {
    float m = mag();
    if (m != 0 && m != 1) {
      div(m);
    }
    return this ;
  }

  /**
 Map
  */
  /*
  return mapping vector
  @return Vec2
  */
  Vec2 mapVec(float minIn, float maxIn, float minOut, float maxOut) {
    x = map(x,minIn, maxIn, minOut, maxOut) ;
    y = map(y,minIn, maxIn, minOut, maxOut) ;
    
    set(x,y) ;
    return this ;
  }
  
   /**
  Mag
  */
  /* magnitude or length of Vec2
  @ return float
  */
  float mag() {
    return sqrt(x*x + y*y) ;
  }

  float mag(Vec v_target) {
    if(v_target != null) {
      float new_x = (v_target.x -x) *(v_target.x -x) ;
      float new_y = (v_target.y -y) *(v_target.y -y) ;
      return sqrt(new_x +new_y) ;
    } else {
      println("Your Vec arg is", null) ;
      return 0 ;
    }
  }
  
  
  /**
  Distance
  */
  /*
  @ return float
  distance between himself and an other vector
  */
  float dist(Vec v_target) {
    if(v_target != null) {
      float dx = x - v_target.x;
      float dy = y - v_target.y;
      return (float) Math.sqrt(dx*dx + dy*dy);
    } else {
      println("Your Vec arg is", null) ;
      return 0 ;
    }
 
  }
  
  
  /**
  Jitter
  */
  /* create jitter effect around the vector position */
  /* with global range */
  Vec2 jitter(int range) {
    return jitter(range,range) ;
  }
  Vec2 jitter(Vec2 range) {
    if(range != null) {
      return jitter((int)range.x,(int)range.y) ;
    } else {
      return jitter(0,0) ;
    }
    
  }
  /* with specific range */
  Vec2 jitter(int range_x,int range_y) {
    println("jitter 1", x, y) ;
    /*
    x = ref_x ;
    y = ref_y ;
    */
    x += random(-range_x, range_x) ;
    y += random(-range_y, range_y) ;
    set(x,y) ;
    return this ;
  }
  
  
  /**
  Revolution
  */
  /* create a circular motion effect */
  Vec2 revolution(int radius, float speed) {
    float new_speed = speed *.01 ;
    /*
    x = ref_x ;
    y = ref_y ;
    */
    float m_x = sin(frameCount *new_speed) ;
    float m_y = cos(frameCount *new_speed) ;
    m_x *=radius ;
    m_y *=radius ;
    
    return this ;
  }


  Vec2 revolution(int r_x, int r_y, float speed) {
    float new_speed = speed *.01 ;
    /*
    x = ref_x ;
    y = ref_y ;
    */
    float m_x = sin(frameCount *new_speed) ;
    float m_y = cos(frameCount *new_speed) ;
    m_x *=r_x ;
    m_y *=r_y ;
    
    return this ;
  }

  Vec2 revolution(Vec2 radius, float speed) {
    float new_speed = speed *.01 ;
    /*
    x = ref_x ;
    y = ref_y ;
    */
    float m_x = sin(frameCount *new_speed) ;
    float m_y = cos(frameCount *new_speed) ;

    m_x *=radius.x ;
    m_y *=radius.y ;
    
    return this ;
  }

  /**
  Equals
  */
  boolean equals(Vec2 target) {
    if(target != null ) {
      if((x == target.x) && (y == target.y)) {
        return true ; 
      } else return false ;
    } else return false ;
  }

  boolean equals(float target) {
    if((x == target) && (y == target)) 
    return true ; 
    else return false ;
  }
  
  boolean equals(float t_x,float t_y) {
    if((x == t_x) && (y == t_y)) 
    return true ; 
    else return false ;
  }



  
  /**
  Compare deprecated
  */
  boolean compare(Vec2 target) {
    if(target != null ) {
      if((x == target.x) && (y == target.y)) {
        return true ; 
      } else return false ;
    } else return false ;
  }

  boolean compare(float target) {
    if((x == target) && (y == target)) 
    return true ; 
    else return false ;
  }
  
  boolean compare(float t_x,float t_y) {
    if((x == t_x) && (y == t_y)) 
    return true ; 
    else return false ;
  }
  
  
  
  /**
  Copy
  */
  /*
  return all the component of Vec
  @return Vec2
  */
  Vec2 copy() {
    return new Vec2(x,y) ;
  }
  /*
  return all the component of Vec in type PVector
  @return PVector
  */
  PVector copy_PVector() {
    return new PVector(x,y) ;
  }


  /**
  Print info
  */
  @ Override String toString() {
    return "[ " + x + ", " + y + " ]";
  }
}
// END VEC 2
////////////






/**

VEC 3

*/
class Vec3 extends Vec {
 
  /**
  Constructor
  */
  Vec3(float x, float y, float z) {
    super() ;
    this.ref_x = this.x = this.r = this.s = x ;
    this.ref_y = this.y = this.g = this.t = y ;
    this.ref_z = this.z = this.b = this.p = z ;
  }
  
   /**
  Random constructor
  */ 
  // random generator for the Vec
  Vec3(String key_random, int r1) {
    super() ;
    if(key_random.equals("RANDOM")) {
      this.ref_x = this.x = this.r = this.s = random(-r1,r1) ;
      this.ref_y = this.y = this.g = this.t = random(-r1,r1) ;
      this.ref_z = this.z = this.b = this.p = random(-r1,r1) ;
    } else if(key_random.equals("RANDOM ZERO")) {
      this.ref_x = this.x = this.r = this.s = random(0,r1) ;
      this.ref_y = this.y = this.g = this.t = random(0,r1) ;
      this.ref_z = this.z = this.b = this.p = random(0,r1) ;
    } else {
      this.ref_x = this.ref_y = this.ref_z = this.x = this.y = this.z  = this.r = this.g = this.b =this.s = this.t = this.p = 0 ;
      println("the key word for the random is not available use the String 'RANDOM' or 'RANDOM ZERO' ") ;
    }
  }
  
  Vec3(String key_random, int r1, int r2, int r3) {
    super() ;
    if(key_random.equals("RANDOM")) {
      this.ref_x = this.x = this.r = this.s = random(-r1,r1) ;
      this.ref_y = this.y = this.g = this.t = random(-r2,r2) ;
      this.ref_z = this.z = this.b = this.p = random(-r3,r3) ;
    } else if(key_random.equals("RANDOM ZERO")) {
      this.ref_x = this.x = this.r = this.s = random(0,r1) ;
      this.ref_y = this.y = this.g = this.t = random(0,r2) ;
      this.ref_z = this.z = this.b = this.p = random(0,r3) ;
    } else {
      this.ref_x = this.ref_y = this.ref_z = this.x = this.y = this.z  = this.r = this.g = this.b =this.s = this.t = this.p = 0 ;
      println("the key word for the random is not available use the String 'RANDOM' or 'RANDOM ZERO' ") ;
    }
  }

  Vec3(String key_random, int a1, int a2, int b1, int b2, int c1, int c2) {
    super() ;
    if(key_random.equals("RANDOM RANGE")) {
      this.ref_x = this.x = this.r = this.s = random(a1,a2) ;
      this.ref_y = this.y = this.g = this.t = random(b1,b2) ;
      this.ref_z = this.z = this.b = this.p = random(c1,c2) ;
    } else {
      this.ref_x = this.ref_y = this.ref_z = this.x = this.y = this.z  = this.r = this.g = this.b =this.s = this.t = this.p = 0 ;
      println("the key word for the random is not available use the String 'RANDOM RANGE' ") ;
    }
  }



  /**
  Set
  */
   /**
   * Sets components of the vector using two or three separate
   * variables, the data from a Vec, or the values from a float array.
   */
   
   public Vec3 set(float v) {
    this.x = this.r = this.s = v ;
    this.y = this.g = this.t = v ;
    this.z = this.b = this.p = v ;
    return this ;
  }
  public Vec3 set(float x, float y, float z) {
    this.x = this.r = this.s = x ;
    this.y = this.g = this.t = y ;
    this.z = this.b = this.p = z ;
    return this ;
  }


  /**
   * @param v any variable of type Vec
   */
  public Vec3 set(Vec3 v) {
    if(v == null) {
      this.x = this.r = this.s = 0 ;
      this.y = this.g = this.t = 0 ;
      this.z = this.b = this.p = 0 ;
      return this ;
    } else {
      this.x = v.x ;
      this.r = v.x ;
      this.s = v.x ;

      this.y = v.y ;
      this.g = v.y ;
      this.t = v.y ;

      this.z = v.z ;
      this.b = v.z ;
      this.p = v.z ;
      return this ;
    }
  }


  /**
   * Set the x, y (and maybe z) coordinates using a float[] array as the source.
   * @param source array to copy from
   */
  public Vec3 set(float[] source) {
    this.x = source[0] ;
    this.r = source[0] ;
    this.s = source[0] ;

    this.y = source[1] ;
    this.g = source[1] ;
    this.t = source[1] ;

    this.z = source[2] ;
    this.b = source[2] ;
    this.p = source[2] ;
    return this ;
  }
  
  
  
  
  
  
  
  
  
  
  
  /**
  METHOD
  */
  /**
  Mult
  */
  /* multiply Vector by a same float value */
  Vec3 mult(float mult) {
    x *= mult ; y *= mult ; z *= mult ;
    
    set(x,y,z) ;
    return this ;
  }
  
  /* multiply Vector by a different float value */
  Vec3 mult(float mult_x, float mult_y, float mult_z) {
    x *= mult_x ; y *= mult_y ; z *= mult_z ;
    
    set(x,y,z) ;
    return this ;
  }
  
  // mult by vector
  Vec3 mult(Vec3 v) {
    if(v != null) {
      x *= v.x ; 
      y *= v.y ; 
      z *= v.z ; 
    }
    set(x,y,z) ;
    return this ;
  }
  
  
  
  /**
  Division
  */
  /*
  @ return Vec
  divide Vector by a float value */
  Vec3 div(float div) {
    x /= div ; 
    y /= div ; 
    z /= div ;
    
    set(x,y,z) ;
    return this ;
  }
  
  // divide by vector
  Vec3 div(Vec3 v) {
    if(v != null) {
      x /= v.x ; 
      y /= v.y ; 
      z /= v.z ; 
    }
    set(x,y,z) ;
    return this ;
  }
  
  
  
  /**
  Addition
  */
    /* add float value */
  Vec3 add(float value) {
    x += value ;
    y += value ;
    z += value ;
    
    set(x,y,z) ;
    return this ;
  }
  Vec3 add(float value_a,float value_b,float value_c) {
    x += value_a ;
    y += value_b ;
    z += value_c ;
    
    set(x,y,z) ;
    return this ;
  }
  /* add one Vector */
  Vec3 add(Vec v) {
    if(v != null) {
      x += v.x ;
      y += v.y ;
      z += v.z ;
    }
    set(x,y,z) ;
    return this ;
  }
  
  /* add two Vector together */
  Vec3 add(Vec v_a, Vec v_b) {
    if(v_a != null &&  v_b != null) {
      x = v_a.x + v_b.x ;
      y = v_a.y + v_b.y ;
      z = v_a.z + v_b.z ;
    }
    set(x,y,z) ;
    return this ;
  }



  /**
  Substraction
  */
    /* add float value */
  Vec3 sub(float value) {
    x -= value ;
    y -= value ;
    z -= value ;
    
    set(x,y,z) ;
    return this ;
  }
  Vec3 sub(float value_a,float value_b,float value_c) {
    x -= value_a ;
    y -= value_b ;
    z -= value_c ;

    set(x,y,z) ;
    return this ;
  }
  /* add one Vector */
  Vec3 sub(Vec v) {
    if(v != null) {
      x -= v.x ;
      y -= v.y ;
      z -= v.z ;
    }
    set(x,y,z) ;
    return this ;
  }
  
  /* add two Vector together */
  Vec3 sub(Vec v_a, Vec v_b) {
    if(v_a != null &&  v_b != null) {
      x = v_a.x - v_b.x ;
      y = v_a.y - v_b.y ;
      z = v_a.z - v_b.z ;
    }
    set(x,y,z) ;
    return this ;
  }


  /**
  Average
  */
  float average() {
    return (this.x + this.y +this.z) *.333 ;
  }


  /**
  Dot
  */
  public float dot(Vec3 v) {
    if(v != null) {
      return x*v.x + y*v.y + z*v.z;
    } else {
      println("Your Vec arg is", null) ;
      return 0 ;
    }
    
  }
  public float dot(float x, float y, float z) {
    return this.x*x + this.y*y + this.z*z;
  }

  /**
  Cross
  */
  Vec3 cross(Vec3 v) {
    if(v != null) {
      return cross(v, null);
    } else return null ;
    
  }
  Vec3 cross(float x, float y, float z) {
    Vec3 v = Vec3(x,y,z) ;
    return cross(v, null);
  }

  Vec3 cross(Vec3 v, Vec3 target) {
    if(v != null && target != null) {
      float crossX = y*v.z - v.y*z;
      float crossY = z*v.x - v.z*x;
      float crossZ = x*v.y - v.x*y;
      if (target == null) {
        target = Vec3(crossX, crossY, crossZ);
      } else {
        target.set(crossX, crossY, crossZ);
      }
      return target;
    } else return null ;

  }
  

  /**
  Direction cartesian
  */
  Vec3 dir() {
    return dir(Vec3(0)) ;
  }
  Vec3 dir(float a_x, float a_y, float a_z) {
    return dir(Vec3(a_x,a_y,a_z)) ;
  }
  Vec3 dir(Vec3 origin) {
    if(origin != null) {
      float dist = dist(origin) ;
      sub(origin) ;
      div(dist) ;
    }
    set(x,y,z) ;
    return this ;
  }
  
  

  /**
  Tangent
  */
  // to find the tangent you need to associate an other vector of your dir vector to create a reference plane.
  Vec3 tan(float float_to_make_plane_ref_x, float float_to_make_plane_ref_y, float float_to_make_plane_ref_z) {
    return tan(Vec3(float_to_make_plane_ref_x, float_to_make_plane_ref_y, float_to_make_plane_ref_z)) ;
  }

  Vec3 tan(Vec3 vector_to_make_plane_ref) {
    if(vector_to_make_plane_ref != null) {
      Vec3 tangent = cross(vector_to_make_plane_ref) ;
      return tangent ;
    } else return null ;
  }
  

  /**
  Map
  */
  // find the min and the max value in the vector list
  // @ float
  float max_vec() {
    float [] list = { x, y, z } ;
    return max(list) ;
  }
  float min_vec() {
    float [] list = { x, y, z } ;
    return min(list) ;
  }





  /**
  Normalize
  */
  /*
  return normalize vector with length of 1
  @return Vec3
  */
  /*
  Vec3 normalize(Vec min, Vec max) {
    if(min != null && max != null) {
      x = map(x, min.x, max.x, 0, 1) ;
      y = map(y, min.y, max.y, 0, 1) ;
      z = map(z, min.z, max.z, 0, 1) ;
    }
    set(x,y,z) ;
    return new Vec3(x,y,z) ;
  }
  */
  
  public Vec3 normalize(Vec3 target) {
    if (target == null) {
      target = Vec3();
    }
    float m = mag();
    if (m > 0) {
      target.set(x/m, y/m, z/m);
    } else {
      target.set(x, y, z);
    }
    return target;
  }

  public Vec3 normalize() {
    float m = mag();
    if (m != 0 && m != 1) {
      div(m);
    }
    return this ;
  }

  /**
  Map
  */
  /*
  return mapping vector
  @return Vec3
  */
  Vec3 mapVec(float minIn, float maxIn, float minOut, float maxOut) {
    x = map(x, minIn, maxIn, minOut, maxOut) ;
    y = map(y, minIn, maxIn, minOut, maxOut) ;
    z = map(z, minIn, maxIn, minOut, maxOut) ;

    set(x,y,z) ;
    return this ;
  }
  
  
  
  /**
  Magnitude
  */
  /* Magnitude or length of Vec3
  @ return float
  */
  /////////////////////
  float mag() {
    return sqrt(x*x + y*y + z*z) ;
  }


  float mag(Vec3 v_target) {
    if(v_target != null) {
      float new_x = (v_target.x -x) *(v_target.x -x) ;
      float new_y = (v_target.y -y) *(v_target.y -y) ;
      float new_z = (v_target.z -z) *(v_target.z -z) ;
      return sqrt(new_x +new_y +new_z) ;
    } else {
      println("Your Vec arg is", null) ;
      return 0 ;
    }
  }
  
  /**
  Distance
  */
  /*
  @ return float
  distance himself and an other vector
  */
  float dist(Vec v_target) {
    if(v_target != null) {
      float dx = x - v_target.x;
      float dy = y - v_target.y;
      float dz = z - v_target.z;
      return (float) Math.sqrt(dx*dx + dy*dy + dz*dz);
    } else {
      println("Your Vec arg is", null) ;
      return 0 ;
    }
  }
  
  /**
  Jitter
  */
  /* create jitter effect around the vector position */
  /* with global range */
  Vec3 jitter(int range) {
    return jitter(range,range,range) ;
  }
  Vec3 jitter(Vec3 range) {
    if(range != null) {
      return jitter((int)range.x,(int)range.y,(int)range.z) ;
    } else return jitter(0, 0, 0) ;
    
  }
  /* with specific range */
  Vec3 jitter(int range_x,int range_y,int range_z) {
    /*
    x = ref_x ;
    y = ref_y ;
    z = ref_z ;
    */
    x += random(-range_x, range_x) ;
    y += random(-range_y, range_y) ;
    z += random(-range_z, range_z) ;

    set(x,y,z) ;
    return this ;
  }
  
  
  
  /**
  Revolution
  */
  /* create a circular motion effect */
  Vec3 revolutionX(int rx, int ry, float speed) {
    return revolutionX(Vec2(rx,ry), speed) ;
  }
  Vec3 revolutionX(int r, float speed) {
    return revolutionX(Vec2(r,r), speed) ;
  }
  Vec3 revolutionX(Vec2 radius, float speed) {
    if(radius != null) {
      float new_speed = speed *.01 ; 
      /*
      x = ref_x ;
      y = ref_y ;
      */
      float m_x = sin(frameCount *new_speed) ;
      float m_y = cos(frameCount *new_speed) ;
      m_x *=radius.x ;
      m_y *=radius.y ;
      return new Vec3(x +m_x, y +m_y, z) ;
    } else return null ;

  }
  //
  Vec3 revolutionY(int rx, int ry, float speed) {
    return revolutionY(Vec2(rx,ry), speed) ;
  }
  Vec3 revolutionY(int r, float speed) {
    return revolutionY(Vec2(r,r), speed) ;
  }
  Vec3 revolutionY(Vec2 radius, float speed) {
    if(radius != null) {
      float new_speed = speed *.01 ; 
      /*
      x = ref_x ;
      z = ref_z ;
      */
      float m_x = sin(frameCount *new_speed) ;
      float m_z = cos(frameCount *new_speed) ;
      m_x *=radius.x ;
      m_z *=radius.y ;
      return new Vec3(x +m_x, y, z +m_z) ;
    } else return null ;
  }
  //
  Vec3 revolutionZ(int rx, int ry, float speed) {
    return revolutionZ(Vec2(rx,ry), speed) ;
  }

  Vec3 revolutionZ(int r, float speed) {
    return revolutionZ(Vec2(r,r), speed) ;
  }
  Vec3 revolutionZ(Vec2 radius, float speed) {
    if(radius != null) {
      float new_speed = speed *.01 ; 
      /*
      y = ref_y ;
      z = ref_z ;
      */
      float m_y = sin(frameCount *new_speed) ;
      float m_z = cos(frameCount *new_speed) ;
      m_y *=radius.x ;
      m_z *=radius.y ;
      return new Vec3(x, y +m_y, z +m_z) ;
    } else return null ;
  }


  /**
  Equals
  */
  boolean equals(Vec3 target) {
    if(target != null) {
      if((x == target.x) && (y == target.y) && (z == target.z)) {
        return true ; 
      } else return false ;
    } else return false ;
  }
  
  boolean equals(float target) {
    if((x == target) && (y == target) && (z == target)) 
    return true ; 
    else return false ;
  }
  
  boolean equals(float t_x,float t_y,float t_z) {
    if((x == t_x) && (y == t_y) && (z == t_z)) 
    return true ; 
    else return false ;
  }
  
  
  /**
  Compare deprecated
  */
  boolean compare(Vec3 target) {
    if(target != null) {
      if((x == target.x) && (y == target.y) && (z == target.z)) {
        return true ; 
      } else return false ;
    } else return false ;
  }
  
  boolean compare(float target) {
    if((x == target) && (y == target) && (z == target)) 
    return true ; 
    else return false ;
  }
  
  boolean compare(float t_x,float t_y,float t_z) {
    if((x == t_x) && (y == t_y) && (z == t_z)) 
    return true ; 
    else return false ;
  }
  


  
  
  /**
  Copy
  */
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
  PVector copy_PVector() {
    return new PVector(x,y,z) ;
  }

  /**
  Print info
  */
  @ Override String toString() {
    return "[ " + x + ", " + y + ", " + z + " ]";
  }
  
  
}
// END VEC 3
////////////





/**
VEC 4

*/
class Vec4 extends Vec {
  /**
  Constructor
  */
  
  Vec4(float x, float y, float z, float w) {
    super() ;
    this.ref_x = this.x = this.r = this.s = x ;
    this.ref_y = this.y = this.g = this.t = y ;
    this.ref_z = this.z = this.b = this.p = z ;
    this.ref_w = this.w = this.a = this.q = w ;
  }



  /**
  Random constructor
  */ 
  // random generator for the Vec
  Vec4(String key_random, int r1) {
    super() ;
    if(key_random.equals("RANDOM")) {
      this.ref_x = this.x = this.r =this.s = random(-r1,r1) ;
      this.ref_y = this.y = this.g =this.t = random(-r1,r1) ;
      this.ref_z = this.z = this.b = this.p = random(-r1,r1) ;
      this.ref_w = this.w = this.a = this.q = random(-r1,r1) ;
    } else if(key_random.equals("RANDOM ZERO")) {
      this.ref_x = this.x = this.r =this.s = random(0,r1) ;
      this.ref_y = this.y = this.g =this.t = random(0,r1) ;
      this.ref_z = this.z = this.b = this.p = random(0,r1) ;
      this.ref_w = this.w = this.a = this.q = random(0,r1) ;
    } else {
      this.ref_x = this.ref_y = this.ref_z = this.ref_w = this.x = this.y = this.z = this.w = this.r = this.g = this.b = this.a =this.s = this.t = this.p = this.q = 0 ;
      println("the key word for the random is not available use the String 'RANDOM' or 'RANDOM ZERO' ") ;
    }
  }
  
  Vec4(String key_random, int r1, int r2, int r3, int r4) {
    super() ;
    if(key_random.equals("RANDOM")) {
      this.ref_x = this.x = this.r =this.s = random(-r1,r1) ;
      this.ref_y = this.y = this.g =this.t = random(-r2,r2) ;
      this.ref_z = this.z = this.b = this.p = random(-r3,r3) ;
      this.ref_w = this.w = this.a = this.q = random(-r4,r4) ;
    } else if(key_random.equals("RANDOM ZERO")) {
      this.ref_x = this.x = this.r =this.s = random(0,r1) ;
      this.ref_y = this.y = this.g =this.t = random(0,r2) ;
      this.ref_z = this.z = this.b = this.p = random(0,r3) ;
      this.ref_w = this.w = this.a = this.q = random(0,r4) ;
    } else {
      this.ref_x = this.ref_y = this.ref_z = this.ref_w = this.x = this.y = this.z = this.w = this.r = this.g = this.b = this.a =this.s = this.t = this.p = this.q = 0 ;
      println("the key word for the random is not available use the String 'RANDOM' or 'RANDOM ZERO' ") ;
    }
  }

  Vec4(String key_random, int a1, int a2, int b1, int b2, int c1, int c2, int d1, int d2) {
    super() ;
    if(key_random.equals("RANDOM RANGE")) {
      this.ref_x = this.x = this.r = this.s = random(a1,a2) ;
      this.ref_y = this.y = this.g = this.t = random(b1,b2) ;
      this.ref_z = this.z = this.b = this.p = random(c1,c2) ;
      this.ref_w = this.w = this.a = this.q = random(d1,d2) ;
    } else {
      this.ref_x = this.ref_y = this.ref_z = this.x = this.y = this.z  = this.r = this.g = this.b =this.s = this.t = this.p = 0 ;
      println("the key word for the random is not available use the String 'RANDOM RANGE' ") ;
    }
  }
  
  /**
  Set
  */
   /**
   * Sets components of the vector using two or three separate
   * variables, the data from a Vec, or the values from a float array.
   */
  public Vec4 set(float v) {
    this.x = this.r = this.s = v ;
    this.y = this.g = this.t = v ;
    this.z = this.b = this.p = v ;
    this.w = this.a = this.q = v ;
    return this ;
  }
  
  
  public Vec4 set(float x, float y, float z, float w) {
    this.x = this.r = this.s = x ;
    this.y = this.g = this.t = y ;
    this.z = this.b = this.p = z ;
    this.w = this.a = this.q = w ;
    return this ;
  }


  /**
   * @param v any variable of type Vec
   */
  public Vec4 set(Vec4 v) {
    if ( v == null) {
      this.x = this.r = this.s = 0 ;
      this.y = this.g = this.t = 0 ;
      this.z = this.b = this.p = 0 ;
      this.w = this.a =  this.q = 0 ;
      return this ;
    } else {
      this.x = this.r = this.s = v.x ;
      this.y = this.g = this.t = v.y ;
      this.z = this.b = this.p = v.z ;
      this.w = this.a = this.q = v.w ;
      return this ;
    }
  }


  /**
   * Set the x, y (and maybe z) coordinates using a float[] array as the source.
   * @param source array to copy from
   */
  public Vec4 set(float[] source) {
    this.x = this.r = this.s = source[0] ;
    this.y = this.g = this.t = source[1] ;
    this.z = this.b = this.p = source[2] ;
    this.w = this.a = this.q = source[3] ;
    return this ;
  }



  /** 
  METHOD
  */
  /**
  Multiplication
  */
  // mult by a same float
  Vec4 mult(float mult) {
    x *= mult ; y *= mult ; z *= mult ; w *= mult ;

    set(x,y,z,w) ;
    return this ;
  }
  
    // mult by a different float
  Vec4 mult(float mult_x, float mult_y, float mult_z, float mult_w) {
    x *= mult_x ; y *= mult_y ; z *= mult_z ; w *= mult_w ;

    set(x,y,z,w) ;
    return this ;
  }
  
  // mult by vector
  Vec4 mult(Vec4 v) {
    if(v != null) {
      x *= v.x ; 
      y *= v.y ; 
      z *= v.z ; 
      w *= v.w ;
    }
    set(x,y,z,w) ;
    return this ;
  }
  
  
  /**
  Division
  */
  /*
  @ return Vec
  divide Vector by a float value */
  Vec4 div(float div) {
    x /= div ; y /= div ; z /= div ; w /= div ;
    set(x,y,z,w) ;
    return this ;
  }
  
  // divide by vector
  Vec4 div(Vec4 v) {
    if(v != null) {
      x /= v.x ; 
      y /= v.y ; 
      z /= v.z ; 
      w /= v.w ;
    }
    set(x,y,z,w) ;
    return this ;
  }
  
  
  /**
  Addition
  */
    /* add float value */
  Vec4 add(float value) {
    x += value ;
    y += value ;
    z += value ;
    w += value ;
    
    set(x,y,z,w) ;
    return this ;
  }
  Vec4 add(float value_a,float value_b,float value_c,float value_d) {
    x += value_a ;
    y += value_b ;
    z += value_c ;
    w += value_d ;
    
    set(x,y,z,w) ;
    return this ;
  }
  /* add vec */
  Vec4 add(Vec v) {
    if(v != null) {
      x += v.x ;
      y += v.y ;
      z += v.z ;
      w += v.w ;
    }
    set(x,y,z,w) ;
    return this  ;
  }
  /* add two Vector together */
  Vec4 add(Vec v_a, Vec v_b) {
    if(v_a != null && v_b != null) {
      x = v_a.x + v_b.x ;
      y = v_a.y + v_b.y ;
      z = v_a.z + v_b.z ;
      w = v_a.w + v_b.w ;
    }
    set(x,y,z,w) ;
    return this ;
  }

  /**
  Substraction
  */
    /* add float value */
  Vec4 sub(float value) {
    x -= value ;
    y -= value ;
    z -= value ;
    w -= value ;
    
    set(x,y,z,w) ;
    return this ;
  }
  Vec4 sub(float value_a,float value_b,float value_c, float value_d) {
    x -= value_a ;
    y -= value_b ;
    z -= value_c ;
    w -= value_d ;
    
    set(x,y,z,w) ;
    return this ;
  }
  /* add one Vector */
  Vec4 sub(Vec v) {
    if(v != null) {
      x -= v.x ;
      y -= v.y ;
      z -= v.z ;
      w -= v.w ;
    }
    set(x,y,z,w) ;
    return this ;
  }
  
  /* add two Vector together */
  Vec4 sub(Vec v_a, Vec v_b) {
    if(v_a != null &&  v_b != null) {
      x = v_a.x - v_b.x ;
      y = v_a.y - v_b.y ;
      z = v_a.z - v_b.z ;
      w = v_a.w - v_b.w ;
    }
    set(x,y,z,w) ;
    return this ;
  }


  /**
  Average
  */
  float average() {
    return (this.x + this.y +this.z +this.w) *.25 ;
  }

  /**
  Dot
  */
  public float dot(Vec4 v) {
    if(v != null) {
      return x*v.x + y*v.y + z*v.z + w*this.w;
    } else {
      println("Your Vec arg is", null) ;
      return 0 ;
    }
    
  }
  public float dot(float x, float y, float z, float w) {
    return this.x*x + this.y*y + this.z*z + this.w*w;
  }



  /**
  Direction cartesian
  */
  Vec4 dir() {
    return dir(Vec4(0)) ;
  }
  Vec4 dir(float a_x, float a_y, float a_z, float a_w) {
    return dir(Vec4(a_x,a_y,a_z,a_w)) ;
  }
  Vec4 dir(Vec4 origin) {
    if(origin != null) {
      float dist = dist(origin) ;
      sub(origin) ;
      div(dist) ;
    }
    set(x,y,z,w) ;
    return this ;
  }
  
  /**
  Min Max
  */
    // find the min and the max value in the vector list
  // @ float
  float max_vec() {
    float [] list = { x, y, z, w } ;
    return max(list) ;
  }
  float min_vec() {
    float [] list = { x, y, z,w } ;
    return min(list) ;
  }





    /**
  Normalize
  */
  /*
  return normalize vector with length of 1
  @return Vec4
  */
  /*
  Vec4 normalize(Vec min, Vec max) {
    if(min != null && max != null) {
      x = map(x, min.x, max.x, 0, 1) ;
      y = map(y, min.y, max.y, 0, 1) ;
      z = map(z, min.z, max.z, 0, 1) ;
      w = map(w, min.w, max.w, 0, 1) ;
    }
    set(x,y,z,w) ;
    return new Vec4(x,y,z,w) ;
  }
  */
  

  public Vec4 normalize(Vec4 target) {
    if (target == null) {
      target = Vec4();
    }
    float m = mag();
    if (m > 0) {
      target.set(x/m, y/m, z/m, w/m);
    } else {
      target.set(x, y, z, w);
    }
    return target;
  }

  public Vec4 normalize() {
    float m = mag();
    if (m != 0 && m != 1) {
      div(m);
    }
    return this ;
  }

  /**
  Map
  */
  /* mapping
  return mapping vector
  @return Vec4
  */
  Vec4 mapVec(float minIn, float maxIn, float minOut, float maxOut) {
    x = map(x, minIn, maxIn, minOut, maxOut) ;
    y = map(y, minIn, maxIn, minOut, maxOut) ;
    z = map(z, minIn, maxIn, minOut, maxOut) ;
    w = map(w, minIn, maxIn, minOut, maxOut) ;
    
    set(x,y,z,w) ;
    return this ;
  }
  
  /**
  Magnitude or length
 */
  float mag() {
    return sqrt(x*x + y*y + z*z + w*w) ;
  }

  float mag(Vec4 v_target) {
    if(v_target != null) {
      float new_x = (v_target.x -x) *(v_target.x -x) ;
      float new_y = (v_target.y -y) *(v_target.y -y) ;
      float new_z = (v_target.z -z) *(v_target.z -z) ;
      float new_w = (v_target.w -w) *(v_target.w -w) ;
      return sqrt(new_x +new_y +new_z +new_w) ;
    } else {
      println("Your Vec arg is", null) ;
      return 0 ;
    }
  }
  
  /**
  Distance
  */
  // distance himself and an other vector
  float dist(Vec4 v_target) {
    if(v_target != null) {
      float dx = x - v_target.x;
      float dy = y - v_target.y;
      float dz = z - v_target.z;
      float dw = w - v_target.w;
      return (float) Math.sqrt(dx*dx + dy*dy + dz*dz + dw*dw);
    } else {
      println("Your Vec arg is", null) ;
      return 0 ;
    }
  }
  
  
  /**
  Jitter
  */
  /* create jitter effect around the vector position */
  /* with global range */
  Vec4 jitter(int range) {
    return jitter(range,range,range,range) ;
  }
  Vec4 jitter(Vec4 range) {
    if(range != null) {
      return jitter((int)range.x,(int)range.y,(int)range.z,(int)range.w) ;
    } else return jitter(0) ;
  }
  /* with specific range */
  Vec4 jitter(int range_x,int range_y,int range_z,int range_w) {
    /*
    x = ref_x ;
    y = ref_y ;
    z = ref_z ;
    w = ref_w ;
    */
    x += random(-range_x, range_x) ;
    y += random(-range_y, range_y) ;
    z += random(-range_z, range_z) ;
    w += random(-range_z, range_z) ;
    
    set(x,y,z,w) ;
    return this ;
  }


    /**
  Equals
  */
  boolean equals(Vec4 target) {
    if(target != null ) {
      if((x == target.x) && (y == target.y) && (z == target.z) && (w == target.w)) {
        return true ; 
      } else return false ;
    } else return false ;
  }
  boolean equals(float target) {
    if((x == target) && (y == target) && (z == target) && (w == target)) 
    return true ; 
    else return false ;
  }
  
  boolean equals(float t_x,float t_y,float t_z,float t_w) {
    if((x == t_x) && (y == t_y) && (z == t_z)&& (w == t_w)) 
    return true ; 
    else return false ;
  }


  
   
  /**
  Compare deprecated
  */
  boolean compare(Vec4 target) {
    if(target != null ) {
      if((x == target.x) && (y == target.y) && (z == target.z) && (w == target.w)) {
        return true ; 
      } else return false ;
    } else return false ;
  }
  boolean compare(float target) {
    if((x == target) && (y == target) && (z == target) && (w == target)) 
    return true ; 
    else return false ;
  }
  
  boolean compare(float t_x,float t_y,float t_z,float t_w) {
    if((x == t_x) && (y == t_y) && (z == t_z)&& (w == t_w)) 
    return true ; 
    else return false ;
  }
  
  /**
  Copy
  */
  Vec4 copy() {
    return new Vec4(x,y,z,w) ;
  }

  /**
  Print info
  */
  @ Override String toString() {
    return "[ " + x + ", " + y + ", " + z + ", " + w + " ]";
  }
}
// END VEC 4
////////////


/**
CLASS Vec5

*/
class Vec5 extends Vec{

  /**
  Constructor
  */
  Vec5(float a, float b, float c, float d, float e) {
    super() ;
    this.a = a ;
    this.b = b ;
    this.c = c ;
    this.d = d ;
    this.e = e ;
  }

  /**
  Random Constructor
  */
  // random generator for the Vec
  Vec5(String key_random, int r1) {
    super() ;
    if(key_random.equals("RANDOM")) {
      this.a = random(-r1,r1) ;
      this.b = random(-r1,r1) ;
      this.c = random(-r1,r1) ;
      this.d = random(-r1,r1) ;
      this.e = random(-r1,r1) ;
    } else if(key_random.equals("RANDOM ZERO")) {
      this.a = random(0,r1) ;
      this.b = random(0,r1) ;
      this.c = random(0,r1) ;
      this.d = random(0,r1) ;
      this.e = random(0,r1) ;
    } else {
      this.a = this.b = this.c = this.d = this.e = 0 ;
      println("the key word for the random is not available use the String 'RANDOM' or 'RANDOM ZERO' ") ;
    }
  }
  
  Vec5(String key_random, int r1, int r2, int r3, int r4, int r5) {
    super() ;
    if(key_random.equals("RANDOM")) {
      this.a = random(-r1,r1) ;
      this.b = random(-r2,r2) ;
      this.c = random(-r3,r3) ;
      this.d = random(-r4,r4) ;
      this.e = random(-r5,r5) ;
    } else if(key_random.equals("RANDOM ZERO")) {
      this.a = random(0,r1) ;
      this.b = random(0,r2) ;
      this.c = random(0,r3) ;
      this.d = random(0,r4) ;
      this.e = random(0,r5) ;
    } else {
      this.a = this.b = this.c = this.d = this.e = 0 ;
      println("the key word for the random is not available use the String 'RANDOM' or 'RANDOM ZERO' ") ;
    }
  }

  Vec5(String key_random, int a1, int a2, int b1, int b2, int c1, int c2, int d1, int d2, int e1, int e2) {
    super() ;
    if(key_random.equals("RANDOM RANGE")) {
      this.a = random(a1,a2) ;
      this.b = random(b1,b2) ;
      this.c = random(c1,c2) ;
      this.d = random(d1,d2) ;
      this.e = random(e1,e2) ;
    } else {
      this.a = this.b = this.c = this.d = this.e = 0 ;
      println("the key word for the random is not available use the String 'RANDOM RANGE' ") ;
    }
  }


  /**
  Set
  */
  /**
  * Sets components of the vector using two or three separate
  * variables, the data from a Vec, or the values from a float array.
  */
  public Vec5 set(float value) {
    this.a = this.b = this.c = this.d = this.e = value;
    return this ;
  }
  
  public Vec5 set(float a, float b, float c, float d, float e) {
    this.a = a ;
    this.b = b;
    this.c = c;
    this.d = d;
    this.e = e;
    return this ;
  }


  /**
   * @param v any variable of type Vec
   */
  public Vec5 set(Vec5 v) {
    if( v == null) {
      a = b = c = d = e = 0 ;
      return this ;
    } else {
      a = v.a ;
      b = v.b ;
      c = v.c ;
      d = v.d ;
      e = v.e ;
      return this ;
    }
  }


  /**
   * Set the x, y (and maybe z) coordinates using a float[] array as the source.
   * @param source array to copy from
   */
  public Vec5 set(float[] source) {
    a = source[0] ;
    b = source[1] ;
    c = source[2] ;
    d = source[3] ;
    e = source[4] ;
    return this ;
  }

  /**
  Min Max
  */
    // find the min and the max value in the vector list
  // @ float
  float max_vec() {
    float [] list = { a,b,c,d,e} ;
    return max(list) ;
  }
  float min_vec() {
    float [] list = {a,b,c,d,e} ;
    return min(list) ;
  }
  
  /**
  Copy
  */
  Vec5 copy() {
    return new Vec5(a,b,c,d,e) ;
  }
  
  /**
  Print info
  */
  @ Override String toString() {
    return "[ " + a + ", " + b + ", " + c + ", " + d + ", " + e + " ]";
  }
}

// END VEC 5
////////////


/**
CLASS Vec6

*/
class Vec6 extends Vec {

  /**
  Constructor
  */
  Vec6(float a, float b, float c, float d, float e, float f) {
    super() ;
    this.a = a ;
    this.b = b ;
    this.c = c ;
    this.d = d ;
    this.e = e ;
    this.f = f ;
  }

  
  /**
  Random Constructor
  */
  Vec6(String key_random, int r1) {
    super() ;
    if(key_random.equals("RANDOM")) {
      this.a = random(-r1,r1) ;
      this.b = random(-r1,r1) ;
      this.c = random(-r1,r1) ;
      this.d = random(-r1,r1) ;
      this.e = random(-r1,r1) ;
    } else if(key_random.equals("RANDOM ZERO")) {
      this.a = random(0,r1) ;
      this.b = random(0,r1) ;
      this.c = random(0,r1) ;
      this.d = random(0,r1) ;
      this.e = random(0,r1) ;
    } else {
      this.a = this.b = this.c = this.d = this.e = this.f = 0 ;
      println("the key word for the random is not available use the String 'RANDOM' or 'RANDOM ZERO' ") ;
    }
  }
  
  Vec6(String key_random, int r1, int r2, int r3, int r4, int r5, int r6) {
    super() ;
    if(key_random.equals("RANDOM")) {
      this.a = random(-r1,r1) ;
      this.b = random(-r2,r2) ;
      this.c = random(-r3,r3) ;
      this.d = random(-r4,r4) ;
      this.e = random(-r5,r5) ;
      this.f = random(-r6,r6) ;
    } else if(key_random.equals("RANDOM")) {
      this.a = random(0,r1) ;
      this.b = random(0,r2) ;
      this.c = random(0,r3) ;
      this.d = random(0,r4) ;
      this.e = random(0,r5) ;
      this.f = random(0,r6) ;
    } else {
      this.a = this.b = this.c = this.d = this.e = this.f = 0 ;
      println("the key word for the random is not available use the String 'RANDOM' or 'RANDOM ZERO' ") ;
    }
  }

  Vec6(String key_random, int a1, int a2, int b1, int b2, int c1, int c2, int d1, int d2, int e1, int e2, int f1, int f2) {
    super() ;
    if(key_random.equals("RANDOM RANGE")) {
      this.a = random(a1,a2) ;
      this.b = random(b1,b2) ;
      this.c = random(c1,c2) ;
      this.d = random(d1,d2) ;
      this.e = random(e1,e2) ;
      this.f = random(f1,f2) ;
    } else {
      this.a = this.b = this.c = this.d = this.e = this.f = 0 ;
      println("the key word for the random is not available use the String 'RANDOM RANGE' ") ;
    }
  }

  /**
  Set
  */
  /**
  * Sets components of the vector using two or three separate
  * variables, the data from a Vec, or the values from a float array.
  */
  public Vec6 set(float v) {
    this.a = this.b = this.c = this.d = this.e = this.f = v;
    return this;
  }

  public Vec6 set(float a, float b, float c, float d, float e, float f) {
    this.a = a ;
    this.b = b ;
    this.c = c ;
    this.d = d ;
    this.e = e ;
    this.f = f ;
    return this;
  }


  /**
   * @param v any variable of type Vec
   */
  public Vec6 set(Vec6 v) {
    if ( v == null) {    
      a = b = c = d = e = f = 0 ;
      return this ;
    } else {
      a = v.a ;
      b = v.b ;
      c = v.c ;
      d = v.d ;
      e = v.e ;
      f = v.f ;
      return this ;
    }
  }


  /**
   * Set the x, y (and maybe z) coordinates using a float[] array as the source.
   * @param source array to copy from
   */
  public Vec6 set(float[] source) {
    a = source[0] ;
    b = source[1] ;
    c = source[2] ;
    d = source[3] ;
    e = source[4] ;
    f = source[5] ;
    return this ;
  }


  /**
  Min Max
  */
      // find the min and the max value in the vector list
  // @ float
  float max_vec() {
    float [] list = {a,b,c,d,e,f} ;
    return max(list) ;
  }
  float min_vec() {
    float [] list = {a,b,c,d,e,f} ;
    return min(list) ;
  }

  /**
  Copy
  */
  Vec6 copy() {
    return new Vec6(a,b,c,d,e,f) ;
  }

  /**
  Print info
  */
  @ Override String toString() {
    return "[ " + a + ", " + b + ", " + c + ", " + d + ", " + e + ", " + f + " ]" ;
  }
}

// END VEC 6
////////////
















/**
External Methods VEC

*/
/**
Addition
*/
// return the resultat of vector addition
Vec2 add(Vec2 v_a, Vec2 v_b) {
  if(v_a == null || v_b == null) {
    return null ;
  } else {
    float x = v_a.x + v_b.x ;
    float y = v_a.y + v_b.y ;
    return new Vec2(x,y) ;
  }

}

Vec3 add(Vec3 v_a, Vec3 v_b) {
  if(v_a == null || v_b == null) {
    return null ;
  } else {
    float x = v_a.x + v_b.x ;
    float y = v_a.y + v_b.y ;
    float z = v_a.z + v_b.z ;
    return new Vec3(x,y,z)  ;
  }
}

Vec4 add(Vec4 v_a, Vec4 v_b) {  
  if(v_a == null || v_b == null) {
    return null ;
  } else {
    float x = v_a.x + v_b.x ;
    float y = v_a.y + v_b.y ;
    float z = v_a.z + v_b.z ;
    float w = v_a.w + v_b.w ;
    return new Vec4(x,y,z, w)  ;
  }
}

Vec2 add(Vec2 v_a, float v) {  
  if(v_a == null ) {
    return null ;
  } else {
    float x = v_a.x +v ;
    float y = v_a.y +v ;
    return new Vec2(x,y) ;
  }
}

Vec3 add(Vec3 v_a, float v) {
  if(v_a == null ) {
    return null ;
  } else {
    float x = v_a.x +v ;
    float y = v_a.y +v ;
    float z = v_a.z +v ;
    return new Vec3(x,y,z)  ;
  }
}

Vec4 add(Vec4 v_a, float v) {
  if(v_a == null ) {
    return null ;
  } else {
    float x = v_a.x +v ;
    float y = v_a.y +v ;
    float z = v_a.z +v ;
    float w = v_a.w +v ;
    return new Vec4(x,y,z, w)  ;
  }
}


/**
Multiplication
*/
// return the resultat of vector multiplication
Vec2 mult(Vec2 v_a, Vec2 v_b) {
  if(v_a == null || v_b == null) {
    return null ;
  } else {
    float x = v_a.x * v_b.x ;
    float y = v_a.y * v_b.y ;
    return new Vec2(x,y) ;
  }
}

Vec3 mult(Vec3 v_a, Vec3 v_b) {
  if(v_a == null || v_b == null) {
    return null ;
  } else {
    float x = v_a.x * v_b.x ;
    float y = v_a.y * v_b.y ;
    float z = v_a.z * v_b.z ;
    return new Vec3(x,y,z)  ;
  }
}

Vec4 mult(Vec4 v_a, Vec4 v_b) {
  if(v_a == null || v_b == null) {
    return null ;
  } else {
    float x = v_a.x * v_b.x ;
    float y = v_a.y * v_b.y ;
    float z = v_a.z * v_b.z ;
    float w = v_a.w * v_b.w ;
    return new Vec4(x,y,z, w)  ;
  }
}

Vec2 mult(Vec2 v_a, float v) {
  if(v_a == null) {
    return null ;
  } else {
    float x = v_a.x *v ;
    float y = v_a.y *v ;
    return new Vec2(x,y) ;
  }
}

Vec3 mult(Vec3 v_a, float v) {
  if(v_a == null) {
    return null ;
  } else {
    float x = v_a.x *v ;
    float y = v_a.y *v ;
    float z = v_a.z *v ;
    return new Vec3(x,y,z)  ;
  }
}

Vec4 mult(Vec4 v_a, float v) {
  if(v_a == null) {
    return null ;
  } else {
    float x = v_a.x *v ;
    float y = v_a.y *v ;
    float z = v_a.z *v ;
    float w = v_a.w *v ;
    return new Vec4(x,y,z, w)  ;
  }
}


/**
Division
*/
// return the resultat of vector addition
Vec2 div(Vec2 v_a, Vec2 v_b) {
  if(v_a == null || v_b == null) {
    return null ;
  } else {
    float x = v_a.x / v_b.x ;
    float y = v_a.y / v_b.y ;
    return new Vec2(x,y) ;
  }
}

Vec3 div(Vec3 v_a, Vec3 v_b) {
  if(v_a == null || v_b == null) {
    return null ;
  } else {
    float x = v_a.x / v_b.x ;
    float y = v_a.y / v_b.y ;
    float z = v_a.z / v_b.z ;
    return new Vec3(x,y,z)  ;
  }
}

Vec4 div(Vec4 v_a, Vec4 v_b) {
  if(v_a == null || v_b == null) {
    return null ;
  } else {
    float x = v_a.x / v_b.x ;
    float y = v_a.y / v_b.y ;
    float z = v_a.z / v_b.z ;
    float w = v_a.w / v_b.w ;
    return new Vec4(x,y,z, w)  ;
  }
}


Vec2 div(Vec2 v_a, float v) {
  if(v_a == null) {
    return null ;
  } else {
    float x = v_a.x /v ;
    float y = v_a.y /v ;
    return new Vec2(x,y) ;
  }
}

Vec3 div(Vec3 v_a, float v) {
  if(v_a == null) {
    return null ;
  } else {
    float x = v_a.x /v ;
    float y = v_a.y /v ;
    float z = v_a.z /v ;
    return new Vec3(x,y,z)  ;
  }
}

Vec4 div(Vec4 v_a, float v) {
  if(v_a == null) {
    return null ;
  } else {
    float x = v_a.x /v ;
    float y = v_a.y /v ;
    float z = v_a.z /v ;
    float w = v_a.w /v;
    return new Vec4(x,y,z, w)  ;
  }
}


/**
Substraction
*/
// return the resultat of vector substraction
Vec2 sub(Vec2 v_a, Vec2 v_b) {
  if(v_a == null || v_b == null) {
    return null ;
  } else {
    float x = v_a.x - v_b.x ;
    float y = v_a.y - v_b.y ;
    return new Vec2(x,y) ;
  }
}

Vec3 sub(Vec3 v_a, Vec3 v_b) {
  if(v_a == null || v_b == null) {
    return null ;
  } else {
    float x = v_a.x - v_b.x ;
    float y = v_a.y - v_b.y ;
    float z = v_a.z - v_b.z ;
    return new Vec3(x,y,z)  ;
  }
}

Vec4 sub(Vec4 v_a, Vec4 v_b) {
  if(v_a == null || v_b == null) {
    return null ;
  } else {
    float x = v_a.x - v_b.x ;
    float y = v_a.y - v_b.y ;
    float z = v_a.z - v_b.z ;
    float w = v_a.w - v_b.w ;
    return new Vec4(x,y,z, w)  ;
  }
}

Vec2 sub(Vec2 v_a, float v) {
  if(v_a == null) {
    return null ;
  } else {
    float x = v_a.x -v ;
    float y = v_a.y -v ;
    return new Vec2(x,y) ;
  }
}

Vec3 sub(Vec3 v_a, float v) {
  if(v_a == null) {
    return null ;
  } else {
    float x = v_a.x -v ;
    float y = v_a.y -v ;
    float z = v_a.z -v ;
    return new Vec3(x,y,z)  ;
  }
}

Vec4 sub(Vec4 v_a, float v) {
  if(v_a == null) {
    return null ;
  } else {
    float x = v_a.x -v ;
    float y = v_a.y -v ;
    float z = v_a.z -v ;
    float w = v_a.w -v ;
    return new Vec4(x,y,z, w)  ;
  }
}


/**
Cross
*/
Vec3 cross(Vec3 v1, Vec3 v2, Vec3 target) {
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
*/
/*
Compare Vector with or without area
compare two vectors Vec without area

@ return boolean
*/
// Vec2 equals
boolean equals(Vec2 v_a, Vec2 v_b) {
  if(v_a == null || v_b == null) {
    println("Is not possible to compare", v_a, "to", v_b) ;
    return false ;
  } else {
    return equals(Vec4(v_a.x,v_a.y,0,0),Vec4(v_b.x,v_b.y,0,0)) ;
  }
}

// Vec3 compare
boolean equals(Vec3 v_a, Vec3 v_b) {
    if(v_a == null || v_b == null) {
    println("Is not possible to compare", v_a, "to", v_b) ;
    return false ;
  } else {
    return equals(Vec4(v_a.x, v_a.y, v_a.z, 0),Vec4(v_b.x, v_b.y, v_b.z, 0)) ;
  }
}
// Vec4 compare
boolean equals(Vec4 v_a, Vec4 v_b) {
  if(v_a != null && v_b != null ) {
    if((v_a.x == v_b.x) && (v_a.y == v_b.y) && (v_a.z == v_b.z) && (v_a.w == v_b.w)) {
            return true ; 
    } else {
      return false ;
    }
  } else {
    return false ;
  } 
}


/* 
compare if the first vector is in the area of the second vector, 
the area of the second vector is define by a Vec area, 
that give the possibility of different size for each component
*/
/*
@ return boolean
*/
// Vec method
// Vec2 compare with area
boolean equals(Vec2 v_a, Vec2 v_b, Vec2 area) {
  if(v_a == null || v_b == null || area == null) {
    println("Is not possible to compare", v_a, "with", v_b, "with", area) ;
    return false ;
  } else {
    return equals(Vec4(v_a.x, v_a.y, 0, 0),Vec4(v_b.x, v_b.y, 0, 0),Vec4(area.x, area.y, 0, 0)) ;
  }
}
// Vec3 compare with area
boolean equals(Vec3 v_a, Vec3 v_b, Vec3 area) {
    if(v_a == null || v_b == null || area == null) {
    println("Is not possible to compare", v_a, "with", v_b, "with", area) ;
    return false ;
  } else {
    return equals(Vec4(v_a.x, v_a.y, v_a.z, 0),Vec4(v_b.x, v_b.y, v_b.z, 0),Vec4(area.x, area.y, area.z, 0)) ;
  }
}
// Vec4 compare with area
boolean equals(Vec4 v_a, Vec4 v_b, Vec4 area) {
  if(v_a != null && v_b != null && area != null ) {
    if(    (v_a.x >= v_b.x -area.x && v_a.x <= v_b.x +area.x) 
        && (v_a.y >= v_b.y -area.y && v_a.y <= v_b.y +area.y) 
        && (v_a.z >= v_b.z -area.z && v_a.z <= v_b.z +area.z) 
        && (v_a.w >= v_b.w -area.w && v_a.w <= v_b.w +area.w)) {
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
/*
return mapping vector
@return Vec2, Vec3 or Vec4
*/
Vec2 mapVec(Vec2 v,float minIn, float maxIn, float minOut, float maxOut) {
  if(v != null) {
    float x = map(v.x, minIn, maxIn, minOut, maxOut) ;
    float y = map(v.y, minIn, maxIn, minOut, maxOut) ;
    return new Vec2(x,y) ;
  } else return null ;
}
Vec3 mapVec(Vec3 v,float minIn, float maxIn, float minOut, float maxOut) {
  if(v != null) {
    float x = map(v.x, minIn, maxIn, minOut, maxOut) ;
    float y = map(v.y, minIn, maxIn, minOut, maxOut) ;
    float z = map(v.z, minIn, maxIn, minOut, maxOut) ;
    return new Vec3(x,y,z) ;
  } else return null ;
}
Vec4 mapVec(Vec4 v,float minIn, float maxIn, float minOut, float maxOut) {
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



/**
Distance
*/
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


/**
Deprecated Middle
*/
/*
@ return Vec2, Vec3 or Vec4
return the middle between two Vector
*/
Vec2 middle(Vec2 p1, Vec2 p2)  {
  Vec2 middle ;
  middle = add(p1, p2);
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

Vec3 middle(Vec3 p1, Vec3 p2) {
  Vec3 middle ;
  middle = add(p1, p2);
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

Vec4 middle(Vec4 p1, Vec4 p2)  {
  Vec4 middle ;
  middle = add(p1, p2);
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
  jitter.x = random(-range_x, range_x) ;
  jitter.y = random(-range_y, range_y) ;
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
  jitter.x = random(-range_x, range_x) ;
  jitter.y = random(-range_y, range_y) ;
  jitter.z = random(-range_z, range_z) ;
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
  jitter.x = random(-range_x, range_x) ;
  jitter.y = random(-range_y, range_y) ;
  jitter.z = random(-range_z, range_z) ;
  jitter.w = random(-range_w, range_w) ;
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
// END VEC FROM ANGLE
/////////////////////



/**
translate int color to Vec4 color
*/
Vec4 color_HSB_a(int c) {
  return Vec4(hue(c), saturation(c), brightness(c), alpha(c)) ;
}

Vec4 color_RGB_a(int c) {
  return Vec4(red(c), green(c), blue(c), alpha(c)) ;
}

Vec3 color_HSB(int c) {
  return Vec3(hue(c), saturation(c), brightness(c)) ;
}

Vec3 color_RGB(int c) {
  return Vec3(red(c), green(c), blue(c)) ;
}





/**
Return a new Vec
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

Vec2 Vec2(float v) {
  return new Vec2(v,v) ;
}

Vec2 Vec2(PVector p) {
  if(p == null) {
    println("PVector null, instead '0' is used to build Vec2") ;
    return new Vec2(0,0) ;
  } else {
    return new Vec2(p.x, p.y) ;
  }
}

Vec2 Vec2(Vec2 p) {
  if(p == null) {
    println("Vec2 null, instead '0' is used to build Vec2") ;
    return new Vec2(0,0) ;
  } else {
    return new Vec2(p.x, p.y) ;
  }
}


Vec2 Vec2(String s, int x, int y) { 
  return new Vec2(s,x,y) ;
}

Vec2 Vec2(String s, int a, int b, int c, int d) { 
  return new Vec2(s,a,b,c,d) ;
}

Vec2 Vec2(String s, int v) {
  return new Vec2(s,v) ;
}
/**
Vec 3
*/
Vec3 Vec3() {
  return new Vec3(0,0,0) ;
}

Vec3 Vec3(float x, float y, float z) {
  return new Vec3(x,y,z) ;
}

Vec3 Vec3(float v) {
  return new Vec3(v,v,v) ;
}

Vec3 Vec3(PVector p) {
  if(p == null) {
    println("PVector null, instead '0' is used to build Vec3") ;
    return new Vec3(0,0,0) ;
  } else {
    return new Vec3(p.x, p.y, p.z) ;
  }
}

Vec3 Vec3(Vec3 p) {
  if(p == null) {
    println("Vec3 null, instead '0' is used to build Vec3") ;
    return new Vec3(0,0,0) ;
  } else {
    return new Vec3(p.x, p.y, p.z) ;
  }
}

Vec3 Vec3(Vec2 p) {
  if(p == null) {
    println("Vec2 null, instead '0' is used to build Vec3") ;
    return new Vec3(0,0,0) ;
  } else {
    return new Vec3(p.x, p.y, 0) ;
  }
}

Vec3 Vec3(String s, int x, int y, int z) { 
  return new Vec3(s,x,y,z) ;
}

Vec3 Vec3(String s, int a, int b, int c, int d, int e, int f) { 
  return new Vec3(s,a,b,c,d,e,f) ;
}

Vec3 Vec3(String s, int v) {
  return new Vec3(s,v) ;
}
/**
Vec 4
*/
Vec4 Vec4() {
  return new Vec4(0,0,0,0) ;
}

Vec4 Vec4(float x, float y, float z, float w) {
  return new Vec4(x,y,z,w) ;
}

Vec4 Vec4(float v) {
  return new Vec4(v,v,v,v) ;
}

// build with Vec
Vec4 Vec4(Vec4 p) {
  if(p == null) {
    println("Vec4 null, instead '0' is used to build Vec4") ;
    return new Vec4(0,0,0,0) ;
  } else {
    return new Vec4(p.x, p.y, p.z, p.w) ;
  }
}
Vec4 Vec4(Vec3 p) {
  if(p == null) {
    println("Vec3 null, instead '0' is used to build Vec4") ;
    return new Vec4(0,0,0,0) ;
  } else {
    return new Vec4(p.x, p.y, p.z, 0) ;
  }
}
Vec4 Vec4(Vec2 p) {
  if(p == null) {
    println("Vec2 null, instead '0' is used to build Vec4") ;
    return new Vec4(0,0,0,0) ;
  } else {
    return new Vec4(p.x, p.y, 0, 0) ;
  }
}

Vec4 Vec4(Vec2 p1,Vec2 p2) {
  if(p1 == null) {
    println("first Vec2 null, instead '0' is used to build Vec4") ;
    return new Vec4(0,0, p2.x, p2.y) ;
  } else if (p2 == null) {
    println("second Vec2 null, instead '0' is used to build Vec4") ;
    return new Vec4(p1.x, p1.y, 0, 0) ;
  }  else if (p1 == null && p2 == null) {
    println("all Vec2 null, instead '0' is used to build Vec4") ;
    return new Vec4(0,0,0,0) ;
  } else {
    return new Vec4(p1.x, p1.y, p2.x, p2.y) ;
  }
}


Vec4 Vec4(String s, int x, int y, int z, int w) { 
  return new Vec4(s,x,y,z,w) ;
}

Vec4 Vec4(String s, int a, int b, int c, int d, int e, int f, int g, int h) { 
  return new Vec4(s,a,b,c,d,e,f,g,h) ;
}

Vec4 Vec4(String s, int v) {
  return new Vec4(s,v) ;
}
/**
Vec 5
*/
Vec5 Vec5() {
  return new Vec5(0,0,0,0,0) ;
}

Vec5 Vec5(float a, float b, float c, float d, float e) {
  return new Vec5(a,b,c,d,e) ;
}

Vec5 Vec5(float v) {
  return new Vec5(v,v,v,v,v) ;
}

// build with Vec
Vec5 Vec5(Vec5 p) {
  if(p == null) {
    println("Vec5 null, instead '0' is used to build Vec5") ;
    return new Vec5(0,0,0,0,0) ;
  } else {
    return new Vec5(p.a,p.b,p.c,p.d,p.e) ;
  }
}

Vec5 Vec5(Vec4 p) {
  if(p == null) {
    println("Vec4 null, instead '0' is used to build Vec5") ;
    return new Vec5(0,0,0,0,0) ;
  } else {
    return new Vec5(p.x,p.y,p.z,p.w,0) ;
  }
}
Vec5 Vec5(Vec3 p) {
  if(p == null) {
    println("Vec3 null, instead '0' is used to build Vec5") ;
    return new Vec5(0,0,0,0,0) ;
  } else {
    return new Vec5(p.x,p.y,p.z,0,0) ;
  }
}
Vec5 Vec5(Vec2 p) {
  if(p == null) {
    println("Vec2 null, instead '0' is used to build Vec5") ;
    return new Vec5(0,0,0,0,0) ;
  } else {
    return new Vec5(p.x,p.y,0,0,0) ;
  }
}

Vec5 Vec5(Vec2 p1,Vec2 p2) {
  if(p1 == null) {
    println("first Vec2 null, instead '0' is used to build Vec5") ;
    return new Vec5(0,0, p2.x, p2.y, 0) ;
  } else if (p2 == null) {
    println("second Vec2 null, instead '0' is used to build Vec5") ;
    return new Vec5(p1.x, p1.y, 0, 0, 0) ;
  }  else if (p1 == null && p2 == null) {
    println("all Vec2 null, instead '0' is used to build Vec4") ;
    return new Vec5(0,0,0,0,0) ;
  } else {
    return new Vec5(p1.x,p1.y,p2.x,p2.y,0) ;
  }
}
Vec5 Vec5(Vec2 p1,Vec3 p2) {
  if(p1 == null) {
    println("first Vec2 null, instead '0' is used to build Vec5") ;
    return new Vec5(0, 0, p2.x, p2.y, p2.z) ;
  } else if (p2 == null) {
    println("second Vec3 null, instead '0' is used to build Vec5") ;
    return new Vec5(p1.x, p1.y, 0, 0, 0) ;
  }  else if (p1 == null && p2 == null) {
    println("Vec2 and Vec3 null, instead '0' is used to build Vec4") ;
    return new Vec5(0,0,0,0,0) ;
  } else {
    return new Vec5(p1.x,p1.y,p2.x,p2.y,p2.z) ;
  }
}

Vec5 Vec5(Vec3 p1,Vec2 p2) {
  if(p1 == null) {
    println("first Vec3 null, instead '0' is used to build Vec5") ;
    return new Vec5(0, 0, 0, p2.x, p2.y) ;
  } else if (p2 == null) {
    println("second Vec2 null, instead '0' is used to build Vec5") ;
    return new Vec5(p1.x, p1.y, p1.z, 0, 0) ;
  }  else if (p1 == null && p2 == null) {
    println("Vec3 and Vec2 null, instead '0' is used to build Vec4") ;
    return new Vec5(0,0,0,0,0) ;
  } else {
    return new Vec5(p1.x,p1.y,p1.z,p2.x,p2.y) ;
  }
}



Vec5 Vec5(String s, int a, int b, int c, int d, int e) { 
  return new Vec5(s,a,b,c,d,e) ;
}

Vec5 Vec5(String s, int a, int b, int c, int d, int e, int f, int g, int h, int i, int j) { 
  return new Vec5(s,a,b,c,d,e,f,g,h,i,j) ;
}

Vec5 Vec5(String s, int v) {
  return new Vec5(s,v) ;
}
/**
Vec 6
*/
Vec6 Vec6() {
  return new Vec6(0,0,0,0,0,0) ;
}

Vec6 Vec6(float a, float b, float c, float d, float e, float f) {
  return new Vec6(a,b,c,d,e,f) ;
}

Vec6 Vec6(float v) {
  return new Vec6(v,v,v,v,v,v) ;
}

// build with vec
Vec6 Vec6(Vec6 p) {
  if(p == null) {
    println("Vec6 null, instead '0' is used to build Vec6") ;
    return new Vec6(0,0,0,0,0,0) ;
  } else {
    return new Vec6(p.a,p.b,p.c,p.d,p.e,p.f) ;
  }
}
Vec6 Vec6(Vec5 p) {
  if(p == null) {
    println("Vec5 null, instead '0' is used to build Vec6") ;
    return new Vec6(0,0,0,0,0,0) ;
  } else {
    return new Vec6(p.a,p.b,p.c,p.d,p.e,0) ;
  }
}
Vec6 Vec6(Vec4 p) {
  if(p == null) {
    println("Vec4 null, instead '0' is used to build Vec6") ;
    return new Vec6(0,0,0,0,0,0) ;
  } else {
    return new Vec6(p.x,p.y,p.z,p.w,0,0) ;
  }
}
Vec6 Vec6(Vec3 p) {
  if(p == null) {
    println("Vec3 null, instead '0' is used to build Vec6") ;
    return new Vec6(0,0,0,0,0,0) ;
  } else {
    return new Vec6(p.x,p.y,p.z,0,0,0) ;
  }
}
Vec6 Vec6(Vec2 p) {
  if(p == null) {
    println("Vec2 null, instead '0' is used to build Vec6") ;
    return new Vec6(0,0,0,0,0,0) ;
  } else {
    return new Vec6(p.x,p.y,0,0,0,0) ;
  }
}
Vec6 Vec6(Vec2 p1,Vec2 p2) {
  if(p1 == null) {
    println("first Vec2 null, instead '0' is used to build Vec6") ;
    return new Vec6(0,0, p2.x, p2.y, 0,0) ;
  } else if (p2 == null) {
    println("second Vec2 null, instead '0' is used to build Vec6") ;
    return new Vec6(p1.x, p1.y, 0, 0, 0,0) ;
  }  else if (p1 == null && p2 == null) {
    println("all Vec2 null, instead '0' is used to build Vec6") ;
    return new Vec6(0,0,0,0,0,0) ;
  } else {
    return new Vec6(p1.x,p1.y,p2.x,p2.y,0,0) ;
  }
}
Vec6 Vec6(Vec2 p1,Vec3 p2) {
  if(p1 == null) {
    println("first Vec2 null, instead '0' is used to build Vec6") ;
    return new Vec6(0, 0, p2.x, p2.y, p2.z,0) ;
  } else if (p2 == null) {
    println("second Vec3 null, instead '0' is used to build Vec6") ;
    return new Vec6(p1.x, p1.y, 0, 0, 0,0) ;
  }  else if (p1 == null && p2 == null) {
    println("Vec2 and Vec3 null, instead '0' is used to build Vec6") ;
    return new Vec6(0,0,0,0,0,0) ;
  } else {
    return new Vec6(p1.x,p1.y,p2.x,p2.y,p2.z, 0) ;
  }
}
Vec6 Vec6(Vec3 p1,Vec2 p2) {
  if(p1 == null) {
    println("first Vec3 null, instead '0' is used to build Vec6") ;
    return new Vec6(0, 0, 0, p2.x, p2.y,0) ;
  } else if (p2 == null) {
    println("second Vec2 null, instead '0' is used to build Vec6") ;
    return new Vec6(p1.x, p1.y, p1.z, 0, 0, 0) ;
  }  else if (p1 == null && p2 == null) {
    println("Vec3 and Vec2 null, instead '0' is used to build Vec6") ;
    return new Vec6(0,0,0,0,0,0) ;
  } else {
    return new Vec6(p1.x,p1.y,p1.z,p2.x,p2.y,0) ;
  }
}
Vec6 Vec6(Vec2 p1,Vec4 p2) {
  if(p1 == null) {
    println("first Vec2 null, instead '0' is used to build Vec6") ;
    return new Vec6(0, 0, p2.x, p2.y, p2.z, p2.w) ;
  } else if (p2 == null) {
    println("second Vec4 null, instead '0' is used to build Vec6") ;
    return new Vec6(p1.x, p1.y, 0, 0, 0, 0) ;
  }  else if (p1 == null && p2 == null) {
    println("Vec2 and Vec4 null, instead '0' is used to build Vec6") ;
    return new Vec6(0,0,0,0,0,0) ;
  } else {
    return new Vec6(p1.x,p1.y,p2.x,p2.y,p2.z, p2.w) ;
  }
}

Vec6 Vec6(Vec4 p1,Vec2 p2) {
  if(p1 == null) {
    println("first Vec4 null, instead '0' is used to build Vec6") ;
    return new Vec6(0, 0, 0, 0, p2.x, p2.y) ;
  } else if (p2 == null) {
    println("second Vec2 null, instead '0' is used to build Vec6") ;
    return new Vec6(p1.x, p1.y, p1.z, p1.w, 0, 0) ;
  }  else if (p1 == null && p2 == null) {
    println("Vec4 and Vec2 null, instead '0' is used to build Vec6") ;
    return new Vec6(0,0,0,0,0,0) ;
  } else {
    return new Vec6(p1.x,p1.y,p1.z,p1.w, p2.x,p2.y) ;
  }
}

Vec6 Vec6(Vec2 p1,Vec2 p2, Vec2 p3) {
  if(p1 == null && p2!= null && p3 != null) {
    println("first Vec2 null, instead '0' is used to build Vec6") ;
    return new Vec6(0,0, p2.x, p2.y,p3.x,p3.y) ;
  } else if (p1 != null && p2 == null && p3 != null) {
    println("second Vec2 null, instead '0' is used to build Vec6") ;
    return new Vec6(p1.x, p1.y, 0, 0, p3.x,p3.y) ;
  } else if (p1 != null && p2 != null && p3 == null) {
    println("third Vec2 null, instead '0' is used to build Vec6") ;
    return new Vec6(p1.x, p1.y, p2.x, p2.y ,0,0) ;
  } else if (p1 == null && p2 == null && p3 != null) {
    println("first and second Vec2 null, instead '0' is used to build Vec6") ;
    return new Vec6(0, 0, 0, 0,p3.x,p3.y) ;
  } else if (p1 == null && p2 != null && p3 == null) {
    println("first and third Vec2 null, instead '0' is used to build Vec6") ;
    return new Vec6(0, 0, p2.x, p2.y, 0, 0) ;
  } else if (p1 != null && p2 == null && p3 == null) {
    println("second and third Vec2 null, instead '0' is used to build Vec6") ;
    return new Vec6(p1.x, p1.y, 0,0, 0, 0) ;
  } else if (p1 == null && p2 == null && p3 == null) {
    println("all Vec2 null, instead '0' is used to build Vec6") ;
    return new Vec6(0,0,0,0,0,0) ;
  } else {
    return new Vec6(p1.x,p1.y,p2.x,p2.y,p3.x,p3.y) ;
  }
}

Vec6 Vec6(Vec3 p1,Vec3 p2) {
  if(p1 == null) {
    println("first Vec3 null, instead '0' is used to build Vec6") ;
    return new Vec6(0,0, 0, p2.x, p2.y, p2.z) ;
  } else if (p2 == null) {
    println("second Vec3 null, instead '0' is used to build Vec6") ;
    return new Vec6(p1.x, p1.y, p1.z, 0, 0,0) ;
  }  else if (p1 == null && p2 == null) {
    println("all Vec3 null, instead '0' is used to build Vec6") ;
    return new Vec6(0,0,0,0,0,0) ;
  } else {
    return new Vec6(p1.x,p1.y,p2.x,p2.y,0,0) ;
  }
}



Vec6 Vec6(String s, int a, int b, int c, int d, int e, int f) { 
  return new Vec6(s,a,b,c,d,e,f) ;
}

Vec6 Vec6(String s, int a, int b, int c, int d, int e, int f, int g, int h, int i, int j, int k, int l) { 
  return new Vec6(s,a,b,c,d,e,f,g,h,i,j,k,l) ;
}

Vec6 Vec6(String s, int v) {
  return new Vec6(s,v) ;
}










/**
PROCESSING VEC METHOD 1.0.1

*/
/**
random
*/
float random (Vec2 v) {
  return random(v.x, v.y) ;
}
/**
background
*/
void background(Vec4 c) {
  background(c.r,c.g,c.b,c.a) ;
}

void background(Vec3 c) {
  background(c.r,c.g,c.b) ;
}

void background(Vec2 c) {
  background(c.x,c.y) ;
}

/**
Ellipse
*/
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

/**
Box
*/
void box(Vec3 p) {
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
/**
Line
*/
void line(Vec2 a, Vec2 b){
  line(a.x, a.y, b.x,b.y) ;
}
void line(Vec3 a, Vec3 b){
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

/**
Bezier Vertex
*/
void bezierVertex(Vec2 a, Vec2 b, Vec2 c) {
  bezierVertex(a.x, a.y, b.x, b.y, c.x, c.y) ;
}

void bezierVertex(Vec3 a, Vec3 b, Vec3 c) {
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

/**
Curve Vertex
*/
void curveVertex(Vec2 a){
  curveVertex(a.x, a.y) ;
}
void curveVertex(Vec3 a){
  if(renderer_P3D()) curveVertex(a.x, a.y, a.z) ; else curveVertex(a.x, a.y) ;
}


/**
Fill
*/
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
  if( c.a > 0) fill(c.r,c.g,c.b,c.a) ; else noFill() ;
}
/**
Stroke
*/
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

/**
image
*/
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
void translate(Vec3 t){
  if(renderer_P3D()) translate(t.x, t.y, t.z) ; else translate(t.x, t.y) ;
}

void translate(Vec2 t){
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

/**
Matrix

*/

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