package rope.vector;

public class iVec3 extends iVec {
	public iVec3() {
  	super(3);
  	set(0,0,0);
  }
  
  public iVec3(int v) {
  	super(3);
  	set(v,v,v);
  }
  
  public iVec3(int x, int y, int z) {
    super(3);
    set(x,y,z);
  }

  public iVec3(iVec v) {
    super(3);
    set(v);
  }
  
  /**
   * set
   * @param x
   * @param y
   * @param z
   * @return
   */
  public iVec3 set(int x, int y, int z) {
  	this.x = this.r = this.s = x;
  	this.y = this.g = this.t = y;
  	this.z = this.b = this.p = z;
  	return this;
  }
  
  public iVec3 set(int arg){
    set(arg,arg,arg);
    return this;
  }

  public iVec3 set(iVec v) {
    if(v == null) {
      this.x = this.y = this.z = 0;
      return this;
    } else if(v instanceof iVec5 || v instanceof iVec6) {
      set(v.a,v.b,v.c);
      return this;
    } else {
      set(v.x,v.y,v.z);
      return this;
    }
  }

  // xyz
  public iVec3 set_x(int x) {
    return set(x,this.y,this.z);
  }

  public iVec3 set_y(int y) {
    return set(this.x,y,this.z);
  }

  public iVec3 set_z(int z) {
    return set(this.x,this.y,z);
  }

  // rgb
  public iVec3 set_r(int x) {
    return set(x,this.y,this.z);
  }

  public iVec3 set_g(int y) {
    return set(this.x,y,this.z);
  }

  public iVec3 set_b(int z) {
    return set(this.x,this.y,z);
  }

  // stp
  public iVec3 set_s(int x) {
    return set(x,this.y,this.z);
  }

  public iVec3 set_t(int y) {
    return set(this.x,y,this.z);
  }

  public iVec3 set_p(int z) {
    return set(this.x,this.y,z);
  }
  
  /**
   * sum
   * @return
   */
  public int sum() {
    return x+y+z;
  }
  
  
  /**
   * mult
   * @param m_x
   * @param m_y
   * @param m_z
   * @return
   */
  public iVec3 mult(int m_x, int m_y, int m_z) {
    x *= m_x; 
    y *= m_y; 
    z *= m_z;
    set(x,y,z) ;
    return this ;
  }

  public iVec3 mult(int m) {
    return mult(m,m,m);
  }

  public iVec3 mult(iVec v) {
    if(v != null) {
      return mult(v.x,v.y,v.z);
    } else return null ;
  }
  
  /**
   * div
   * @param d_x
   * @param d_y
   * @param d_z
   * @return
   */
  public iVec3 div(int d_x, int d_y, int d_z) {
    if(d_x != 0) x /= d_x; 
    if(d_y != 0) y /= d_y; 
    if(d_z != 0) z /= d_z; 
    set(x,y,z);
    return this;
  }
  
  public iVec3 div(int d) {
    return div(d,d,d);
  }
  
  public iVec3 div(iVec v) {
    if(v != null) {
      return div(v.x,v.y,v.z);
    } else return null;
  }
  
  /**
   * add
   * @param a_x
   * @param a_y
   * @param a_z
   * @return
   */
  public iVec3 add(int a_x,int a_y,int a_z) {
    x += a_x;
    y += a_y;
    z += a_z;
    set(x,y,z);
    return this;
  }

  public iVec3 add(int a) {
    return add(a,a,a);
  }

  public iVec3 add(iVec v) {
    if(v != null) {
      return add(v.x,v.y,v.z);
    } else return null;
  }
  
  /**
   * sub
   * @param a_x
   * @param a_y
   * @param a_z
   * @return
   */
  public iVec3 sub(int a_x,int a_y,int a_z) {
    x -= a_x;
    y -= a_y;
    z -= a_z;
    set(x,y,z);
    return this;
  }

  public iVec3 sub(int a) {
    return sub(a,a,a);
  }

  public iVec3 sub(iVec v) {
    if(v != null) {
      return sub(v.x,v.y,v.z);
    } else return null;
  }
  
  /**
   * equals
   * @param target
   * @return
   */
  public boolean equals(iVec3 target) {
    if(target != null ) {
      if((x == target.x) && (y == target.y) && (z == target.z)) {
        return true; 
      } else return false;
    } else return false;
  }

  public boolean equals(int target) {
    if((x == target) && (y == target) && (z == target)) 
    return true; 
    else return false;
  }
  
  public boolean equals(int tx, int ty, int tz) {
    if((x == tx) && (y == ty) && (z == tz)) 
    return true; 
    else return false;
  }
  
  /**
   * copy
   * @return
   */
  public iVec3 copy() {
    return new iVec3(x,y,z) ;
  }
  
  
  @Override 
  public String toString() {
    return "[ " + x + ", " + y + ", " + z + " ]" ;
  }
}
