package rope.vector;

public class iVec2 extends iVec {
	public iVec2() {
  	super(2);
  	set(0,0);
  }
  
  public iVec2(int v) {
  	super(2);
  	set(v,v);
  }
  
  public iVec2(int x, int y) {
    super(2);
    set(x,y);
  }

  public iVec2(iVec v) {
    super(2);
    set(v);
  }
  
  /**
   * set
   * @param x
   * @param y
   * @return
   */
  public iVec2 set(int x, int y) {
  	this.x = this.s = this.u = x;
  	this.y = this.t = this.v = y;
  	return this;
  }
  
  public iVec2 set(int arg){
    set(arg,arg);
    return this;
  }
  
  public iVec2 set(iVec v) {
    if(v == null) {
      this.x = this.y = 0;
      return this;
    } else if(v instanceof iVec5 || v instanceof iVec6) {
      set(v.a,v.b);
      return this;
    } else {
      set(v.x,v.y);
      return this;
    }
  }
  
  // xy
  public iVec2 set_x(int x) {
    return set(x,this.y);
  }

  public iVec2 set_y(int y) {
    return set(this.x,y);
  }

  // st
  public iVec2 set_s(int x) {
    return set(x,this.y);
  }

  public iVec2 set_t(int y) {
    return set(this.x,y);
  }

  // uv
  public iVec2 set_u(int x) {
    return set(x,this.y);
  }

  public iVec2 set_v(int y) {
    return set(this.x,y);
  }
  
  
  /**
   * sum
   * @return
   */
  public int sum() {
    return x+y;
  }
  
  /**
   * mult
   * @param m_x
   * @param m_y
   * @return
   */
  public iVec2 mult(int m_x, int m_y) {
    x *= m_x; 
    y *= m_y; 
    set(x,y);
    return this;
  }

  public iVec2 mult(int m) {
    return mult(m,m);
  }

  public iVec2 mult(iVec v) {
    if(v != null) {
      return mult(v.x,v.y);
    } else return null;
  }
  
  
  /**
   * div
   * @param d_x
   * @param d_y
   * @return
   */
  public iVec2 div(int d_x, int d_y) {
    if(d_x != 0) x /= d_x; 
    if(d_y != 0) y /= d_y; 
    set(x,y);
    return this;
  }
  
  public iVec2 div(int d) {
    return div(d,d);
  }
  

  public iVec2 div(iVec v) {
    if(v != null) {
      return div(v.x,v.y);
    } else return null;
  }
  
  /**
   * add
   * @param a_x
   * @param a_y
   * @return
   */
  public iVec2 add(int a_x,int a_y) {
    x += a_x;
    y += a_y;
    set(x,y);
    return this;
  }

  public iVec2 add(int a) {
    return add(a,a);
  }


  public iVec2 add(iVec v) {
    if(v != null) {
      return add(v.x,v.y);
    } else return null;
  }
  
  /**
   * sub
   * @param a_x
   * @param a_y
   * @return
   */
  public iVec2 sub(int a_x,int a_y) {
    x -= a_x;
    y -= a_y;
    set(x,y);
    return this;
  }

  public iVec2 sub(int a) {
    return sub(a,a);
  }


  public iVec2 sub(iVec v) {
    if(v != null) {
      return sub(v.x,v.y);
    } else return null;
  }
  
  /**
   * equals
   * @param target
   * @return
   */
  public boolean equals(iVec2 target) {
    if(target != null ) {
      if((x == target.x) && (y == target.y)) {
        return true; 
      } else return false;
    } else return false;
  }

  public boolean equals(int target) {
    if((x == target) && (y == target)) 
    return true; 
    else return false;
  }
  
  public boolean equals(int tx, int ty) {
    if((x == tx) && (y == ty)) 
    return true; 
    else return false;
  }
  
  /**
   * copy
   * @return
   */
  public iVec2 copy() {
    return new iVec2(x,y) ;
  }
  
  @Override 
  public String toString() {
    return "[ " + x + ", " + y + " ]" ;
  }

}
