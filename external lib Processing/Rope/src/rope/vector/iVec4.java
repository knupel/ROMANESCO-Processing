package rope.vector;

public class iVec4 extends iVec {
  public iVec4() {
  	super(4);
  	set(0,0,0,0);
  }
  
  public iVec4(int v) {
  	super(4);
  	set(v,v,v,v);
  }
  
  public iVec4(int x, int y, int z, int w) {
    super(4);
    set(x,y,z,w);
  }

  public iVec4(iVec v) {
    super(4);
    set(v);
  }
  
  
  /**
   * set
   * @param x
   * @param y
   * @param z
   * @param w
   * @return
   */
  public iVec4 set(int x, int y, int z, int w) {
  	this.x = this.r = this.s = x;
  	this.y = this.g = this.t = y;
  	this.z = this.b = this.p = z;
  	this.w = this.a = this.q = w;
  	return this;
  }
  
  public void set(int arg){
    set(arg,arg,arg,arg);
  }

  public iVec4 set(iVec v) {
    if(v == null) {
      this.x  = this.y = this.z = this.w = 0 ;
      return this;
    } else if(v instanceof iVec5 || v instanceof iVec6) {
      set(v.a,v.b,v.c,v.d);
      return this;
    } else {
      set(v.x,v.y,v.z,v.w);
      return this;
    }
  }

  // xyzw
  public iVec4 set_x(int x) {
    return set(x,this.y,this.z,this.w);
  }

  public iVec4 set_y(int y) {
    return set(this.x,y,this.z,this.w);
  }

  public iVec4 set_z(int z) {
    return set(this.x,this.y,z,this.w);
  }

  public iVec4 set_w(int w) {
    return set(this.x,this.y,this.z,w);
  }

  // rgba
  public iVec4 set_r(int x) {
    return set(x,this.y,this.z,this.w);
  }

  public iVec4 set_g(int y) {
    return set(this.x,y,this.z,this.w);
  }

  public iVec4 set_b(int z) {
    return set(this.x,this.y,z,this.w);
  }

  public iVec4 set_a(int w) {
    return set(this.x,this.y,this.z,w);
  }

  // stpq
  public iVec4 set_s(int x) {
    return set(x,this.y,this.z,this.w);
  }

  public iVec4 set_t(int y) {
    return set(this.x,y,this.z,this.w);
  }

  public iVec4 set_p(int z) {
    return set(this.x,this.y,z,this.w);
  }

  public iVec4 set_q(int w) {
    return set(this.x,this.y,this.z,w);
  }
  
  /**
   * sum
   * @return
   */
  public int sum() {
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
  public iVec4 mult(int m_x, int m_y, int m_z, int m_w) {
    x *= m_x ; y *= m_y ; z *= m_z ; w *= m_w ;
    set(x,y,z,w) ;
    return this ;
  }

  public iVec4 mult(int m) {
    return mult(m,m,m,m);
  }

  public iVec4 mult(iVec v) {
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
  public iVec4 div(int d_x, int d_y, int d_z, int d_w) {
    if(d_x != 0) x /= d_x; 
    if(d_y != 0) y /= d_y; 
    if(d_z != 0) z /= d_z; 
    if(d_w != 0) w /= d_w;
    set(x,y,z,w);
    return this;
  }
  
  public iVec4 div(int d) {
    return div(d,d,d,d);
  }
  
  public iVec4 div(iVec v) {
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
  public iVec4 add(int a_x,int a_y,int a_z,int a_w) {
    x += a_x;
    y += a_y;
    z += a_z;
    w += a_w;
    set(x,y,z,w);
    return this;
  }

  public iVec4 add(int a) {
    return add(a,a,a,a);
  }

  public iVec4 add(iVec v) {
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
  public iVec4 sub(int a_x,int a_y,int a_z, int a_w) {
    x -= a_x;
    y -= a_y;
    z -= a_z;
    w -= a_w; 
    set(x,y,z,w);
    return this;
  }

  public iVec4 sub(int a) {
    return sub(a,a,a,a);
  }

  public iVec4 sub(iVec v) {
    if(v != null) {
      return sub(v.x,v.y,v.z,v.w);
    } else return null;
  }
  
  
  /**
   * equals
   * @param target
   * @return
   */
  public boolean equals(iVec4 target) {
    if(target != null ) {
      if((x == target.x) && (y == target.y) && (z == target.z) && (w == target.w)) {
        return true; 
      } else return false;
    } else return false;
  }

  public boolean equals(int target) {
    if((x == target) && (y == target) && (z == target) && (w == target)) 
    return true; 
    else return false;
  }
  
  public boolean equals(int tx, int ty, int tz, int tw) {
    if((x == tx) && (y == ty) && (z == tz) && (w == tw)) 
    return true; 
    else return false;
  }
  
  /**
   * copy
   * @return
   */
  public iVec4 copy() {
    return new iVec4(x,y,z,w) ;
  }
  
  
  @Override 
  public String toString() {
    return "[ " + x + ", " + y + ", " + z + ", " + w + " ]" ;
  }

}
