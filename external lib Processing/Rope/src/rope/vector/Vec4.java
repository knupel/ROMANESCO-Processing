package rope.vector;

public class Vec4 extends Vec {
	public Vec4() {
  	super(4);
  	set(0,0,0,0);
  }
	
  public Vec4(float v) {
  	super(4);
  	set(v,v,v,v);
  }
  
  public Vec4(float x, float y, float z, float w) {
    super(4) ;
    set(x,y,z,w);
  }
  
  private String warning = "Contructor class Vec4() cannot use the String key_random: ";
  public Vec4(String key_random, float r1) {
    super(4) ;
    if(key_random.equals(RANDOM)) {
      set(random(-r1,r1),random(-r1,r1),random(-r1,r1),random(-r1,r1));
    } else if(key_random.equals(RANDOM_ZERO)) {
      set(random(0,r1),random(0,r1),random(0,r1),random(0,r1));
    } else {
      this.x = this.y = this.z = this.w = this.r = this.g = this.b = this.a =this.s = this.t = this.p = this.q = 0 ;
      System.out.println(warning+key_random);
    }
  }
  
  public Vec4(String key_random, float r1, float r2, float r3, float r4) {
    super(4) ;
    if(key_random.equals(RANDOM)) {
      set(random(-r1,r1),random(-r2,r2),random(-r3,r3),random(-r4,r4));
    } else if(key_random.equals(RANDOM_ZERO)) {
      set(random(0,r1),random(0,r2),random(0,r3),random(0,r4));
    } else {
      this.x = this.y = this.z = this.w = this.r = this.g = this.b = this.a =this.s = this.t = this.p = this.q = 0 ;
      System.out.println(warning+key_random);;
    }
  }

  public Vec4(String key_random, float a1, float a2, float b1, float b2, float c1, float c2, float d1, float d2) {
    super(4) ;
    if(key_random.equals(RANDOM_RANGE)) {
      set(random(a1,a2),random(b1,b2),random(c1,c2),random(d1,d2));
    } else {
      this.x = this.y = this.z  = this.r = this.g = this.b =this.s = this.t = this.p = 0 ;
      System.out.println(warning+key_random);
    }
  }
  
  /**
   * set vec
   * @param x
   * @param y
   * @param z
   * @param w
   * @return
   */
  public Vec4 set(float x, float y, float z, float w) {
    this.x = this.r = this.s = x ;
    this.y = this.g = this.t = y ;
    this.z = this.b = this.p = z ;
    this.w = this.a = this.q = w ;
    return this ;
  }
  
  public Vec4 set(float v) {
    set(v,v,v,v);
    return this ;
  }
  
  public Vec4 set(Vec v) {
    if ( v == null) {
      set(0,0,0,0);
      return this ;
    }  else if(v instanceof Vec5 || v instanceof Vec6) {
      set(v.a,v.b,v.c,v.d);
      return this ;
    } else {
      set(v.x,v.y,v.z,v.w);
      return this ;
    }
  }

  public Vec4 set(iVec v) {
    if ( v == null) {
      set(0,0,0,0);
      return this ;
    } else if(v instanceof iVec5 || v instanceof iVec6) {
      set(v.a,v.b,v.c,v.d);
      return this ;
    } else {
      set(v.x,v.y,v.z,v.w);
      return this ;
    }
  }
  
  public Vec4 set(float[] source) {
    set(source[0],source[1],source[2],source[3]);
    return this ;
  }
  
  public Vec4 set_x(float x) {
    return set(x,this.y,this.z,this.w);
  }

  public Vec4 set_y(float y) {
    return set(this.x,y,this.z,this.w);
  }

  public Vec4 set_z(float z) {
    return set(this.x,this.y,z,this.w);
  }

  public Vec4 set_w(float w) {
    return set(this.x,this.y,this.z,w);
  }

  // rgba
  public Vec4 set_r(float x) {
    return set(x,this.y,this.z,this.w);
  }

  public Vec4 set_g(float y) {
    return set(this.x,y,this.z,this.w);
  }

  public Vec4 set_b(float z) {
    return set(this.x,this.y,z,this.w);
  }

  public Vec4 set_a(float w) {
    return set(this.x,this.y,this.z,w);
  }

  // stpq
  public Vec4 set_s(float x) {
    return set(x,this.y,this.z,this.w);
  }

  public Vec4 set_t(float y) {
    return set(this.x,y,this.z,this.w);
  }

  public Vec4 set_p(float z) {
    return set(this.x,this.y,z,this.w);
  }

  public Vec4 set_q(float w) {
    return set(this.x,this.y,this.z,w);
  }
  
  /**
   * sum
   * @return
   */
  public float sum() {
    return x+y+z+w;
  }
  
  /**
   * mult
   * @param m_x
   * @param m_y
   * @param m_z
   * @param m_w
   * @return
   */
  public Vec4 mult(float m_x, float m_y, float m_z, float m_w) {
    x *= m_x ; 
    y *= m_y ; 
    z *= m_z ; 
    w *= m_w ;
    set(x,y,z,w) ;
    return this ;
  }

  public Vec4 mult(float m) {
    return mult(m,m,m,m);
  }

  public Vec4 mult(Vec v) {
    if(v != null) {
      return mult(v.x,v.y,v.z,v.w);
    } else return null ;
  }

  public Vec4 mult(iVec v) {
    if(v != null) {
      return mult(v.x,v.y,v.z,v.w);
    } else return null ;
  }
  
  /**
   * div
   * @param d_x
   * @param d_y
   * @param d_z
   * @param d_w
   * @return
   */
  public Vec4 div(float d_x, float d_y, float d_z, float d_w) {
    if(d_x != 0) x /= d_x; 
    if(d_y != 0) y /= d_y; 
    if(d_z != 0) z /= d_z; 
    if(d_w != 0) w /= d_w;
    set(x,y,z,w);
    return this;
  }
  
  public Vec4 div(float d) {
    return div(d,d,d,d);
  }
  
  public Vec4 div(Vec v) {
    if(v != null) {
      return div(v.x,v.y,v.z,v.w);
    } else return null;
  }

  public Vec4 div(iVec v) {
    if(v != null) {
      return div(v.x,v.y,v.z,v.w);
    } else return null;
  }
  
  
  /**
   * add
   * @param a_x
   * @param a_y
   * @param a_z
   * @param a_w
   * @return
   */
  public Vec4 add(float a_x,float a_y,float a_z,float a_w) {
    x += a_x;
    y += a_y;
    z += a_z;
    w += a_w;
    set(x,y,z,w);
    return this;
  }

  public Vec4 add(float a) {
    return add(a,a,a,a);
  }

  public Vec4 add(Vec v) {
    if(v != null) {
      return add(v.x,v.y,v.z,v.w);
    } else return null;
  }

  public Vec4 add(iVec v) {
    if(v != null) {
      return add(v.x,v.y,v.z,v.w);
    } else return null;
  }
  
  
  /**
   * sub
   * @param a_x
   * @param a_y
   * @param a_z
   * @param a_w
   * @return
   */
  public Vec4 sub(float a_x,float a_y,float a_z, float a_w) {
    x -= a_x;
    y -= a_y;
    z -= a_z;
    w -= a_w; 
    set(x,y,z,w);
    return this;
  }

  public Vec4 sub(float a) {
    return sub(a,a,a,a);
  }

  public Vec4 sub(Vec v) {
    if(v != null) {
      return sub(v.x,v.y,v.z,v.w);
    } else return null;
  }

  public Vec4 sub(iVec v) {
    if(v != null) {
      return sub(v.x,v.y,v.z,v.w);
    } else return null;
  }
  
  /**
   * average
   * @return float average of sum components
   */
  public float average() {
    return (this.x + this.y +this.z +this.w) *.25f;
  }
  
  /**
   * 
   * @param v
   * @return
   */
  public float dot(Vec4 v) {
    if(v != null) {
      return x*v.x + y*v.y + z*v.z + w*this.w;
    } else {
      System.out.println("Your Vec arg is"+null) ;
      return 0 ;
    }
  }
  
  public float dot(float x, float y, float z, float w) {
    return this.x*x + this.y*y + this.z*z + this.w*w;
  }
  
  
  /**
   * 
   * @param pow
   * @return Vec4 component powering by each value
   */
  public Vec4 pow(int pow) {
    this.pow(pow,pow,pow,pow);
    return this;
  }
  
  public Vec4 pow(int pow_x, int pow_y, int pow_z, int pow_w) {
    x = (float)Math.pow(x,pow_x);
    y = (float)Math.pow(y,pow_y);
    z = (float)Math.pow(z,pow_z);
    w = (float)Math.pow(w,pow_w);
    set(x,y,z,w);
    return this;
  }
  
  /**
   * 
   * @param v_target
   * @return
   */
  float dist(Vec4 v_target) {
    if(v_target != null) {
      float dx = x - v_target.x;
      float dy = y - v_target.y;
      float dz = z - v_target.z;
      float dw = w - v_target.w;
      return (float) Math.sqrt(dx*dx + dy*dy + dz*dz + dw*dw);
    } else {
      System.out.println("Your Vec arg is"+null);
      return 0 ;
    }
  }
  
  
  
  /**
   * direction normal
   * @return
   */
  public Vec4 dir() {
    return dir(new Vec4(0)) ;
  }
  public Vec4 dir(float a_x, float a_y, float a_z, float a_w) {
    return dir(new Vec4(a_x,a_y,a_z,a_w));
  }
  
  public Vec4 dir(Vec4 origin) {
    if(origin != null) {
      float dist = dist(origin);
      sub(origin);
      div(dist);
    }
    set(x,y,z,w);
    return this;
  }
  
  /**
   * max
   * @return
   */
  public float max_vec() {
    float [] list = {x,y,z,w};
    return max(list);
  }
  
  /**
   * min
   * @return
   */
  public float min_vec() {
    float [] list = {x,y,z,w};
    return min(list);
  }
  
  
  /**
   * magSq
   * @return
   */
  public float magSq() {
    return (x*x + y*y + z*z +w*w) ;
  }

  /**
   * mag
   * @return
   */
  public float mag() {
    return (float) Math.sqrt(x*x + y*y + z*z + w*w);
  }

  float mag(Vec4 v_target) {
    if(v_target != null) {
      float new_x = (v_target.x -x) *(v_target.x -x);
      float new_y = (v_target.y -y) *(v_target.y -y);
      float new_z = (v_target.z -z) *(v_target.z -z);
      float new_w = (v_target.w -w) *(v_target.w -w);
      return (float)Math.sqrt(new_x +new_y +new_z +new_w);
    } else {
      System.out.println("Your Vec arg is"+null);
      return 0 ;
    }
  }
  
  
  /**
   * normalize
   * @param target
   * @return
   */
  public Vec4 normalize(Vec4 target) {
    if (target == null) {
      target = new Vec4();
    }
    float m = mag();
    if (m > 0) {
      target.set(x/m, y/m, z/m, w/m);
    } else {
      target.set(x,y,z,w);
    }
    return target;
  }

  public Vec4 normalize() {
    float m = mag();
    if (m != 0 && m != 1) {
      div(m);
    }
    return this;
  }
  
  
  /**
   * map
   * @param minIn
   * @param maxIn
   * @param minOut
   * @param maxOut
   * @return Vec4 where each target is Vec component
   */
  public Vec4 map(float minIn, float maxIn, float minOut, float maxOut) {
    x = map(x,minIn,maxIn,minOut,maxOut);
    y = map(y,minIn,maxIn,minOut,maxOut);
    z = map(z,minIn,maxIn,minOut,maxOut);
    w = map(w,minIn,maxIn,minOut,maxOut);
    set(x,y,z,w);
    return this;
  }

  public Vec4 map(Vec4 minIn, Vec4 maxIn, Vec4 minOut, Vec4 maxOut) {
    x = map(x,minIn.x,maxIn.x,minOut.x,maxOut.x);
    y = map(y,minIn.y,maxIn.y,minOut.y,maxOut.y);   
    z = map(z,minIn.z,maxIn.z,minOut.z,maxOut.z);   
    w = map(w,minIn.w,maxIn.w,minOut.w,maxOut.w);
    set(x,y,z,w);
    return this;
  }
  
  
  
  /**
   * limit
   * @param max
   * @return
   */
  public Vec4 limit(float max) {
    if (magSq() > max*max) {
      normalize();
      mult(max);
    }
    return this;
  }
  
  
  
  /**
   * jitter
   * @param range
   * @return
   */
  public Vec4 jitter(int range) {
    return jitter(range,range,range,range) ;
  }
  
  public Vec4 jitter(Vec4 range) {
    if(range != null) {
      return jitter((int)range.x,(int)range.y,(int)range.z,(int)range.w) ;
    } else return jitter(0) ;
  }

  public Vec4 jitter(int range_x,int range_y, int range_z, int range_w) {
    x += random_next_gaussian(range_x,3);
    y += random_next_gaussian(range_y,3);
    z += random_next_gaussian(range_z,3);
    w += random_next_gaussian(range_w,3);
    set(x,y,z,w);
    return this;
  }
  
  /**
   * equals
   * @param target
   * @return true if the target components is equals to Vec
   */
  public boolean equals(Vec4 target) {
    if(target != null ) {
      if((x == target.x) && (y == target.y) && (z == target.z) && (w == target.w)) {
        return true; 
      } else return false;
    } else return false;
  }
  
  public boolean equals(float target) {
    if((x == target) && (y == target) && (z == target) && (w == target)) 
    return true; 
    else return false;
  }
  
  public boolean equals(float t_x,float t_y,float t_z,float t_w) {
    if((x == t_x) && (y == t_y) && (z == t_z)&& (w == t_w)) 
    return true; 
    else return false;
  }
  
  /**
   * copy
   * @return
   */
  public Vec4 copy() {
    return new Vec4(x,y,z,w);
  }
  
  
  @Override 
  public String toString() {
    return "[ " + x + ", " + y + ", " + z + ", " + w + " ]";
  } 
}
