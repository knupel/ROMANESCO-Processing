package rope.vector;

public class iVec5 extends iVec {
  public iVec5() {
  	super(5);
  	set(0,0,0,0,0); 
  }

  public iVec5(int v) {
  	super(5);
  	set(v,v,v,v,v); 
  }

  public iVec5(int a, int b, int c, int d, int e) {
    super(5) ;
    set(a,b,c,d,e);
  }

  public iVec5(iVec v) {
    super(5) ;
    set(v);
  }
  
  /**
   * set
   * @param a
   * @param b
   * @param c
   * @param d
   * @param e
   * @return
   */
  public iVec5 set(int a, int b, int c, int d, int e) {
  	this.a = a;
  	this.b = b;
  	this.c = c;
  	this.d = d;
  	this.e = e;
  	return this;
  }
  
  public iVec5 set(int arg){
    set(arg,arg,arg,arg,arg);
    return this;
  }

  public iVec5 set(iVec v) {
    if(v == null) {
      this.a = this.b = this.c = this.d = this.e = 0;
      return this;
    } else if(v instanceof iVec5 || v instanceof iVec6) {
      set(v.a,v.b,v.c,v.d,v.e);
      return this;
    } else {
      set(v.x,v.y,v.z,v.w,0);
      return this;
    }
  }


  // abcde
  public iVec5 set_a(int a) {
    return set(a,this.b,this.c,this.d,this.e);
  }

  public iVec5 set_b(int b) {
    return set(this.a,b,this.c,this.d,this.e);
  }

  public iVec5 set_c(int c) {
    return set(this.a,this.b,c,this.d,this.e);
  }

  public iVec5 set_d(int d) {
    return set(this.a,this.b,this.c,d,this.e);
  }

  public iVec5 set_e(int e) {
    return set(this.a,this.b,this.c,this.d,e);
  }
  
  /**
   * get array component
   */
  public int [] get_array() {
    int array [] = {a,b,c,d,e};
    return array ;
  }
  
  /**
   * copy
   * @return
   */
  public iVec5 copy() {
    return new iVec5(a,b,c,d,e);
  }
  
  @Override 
  public String toString() {
    return "[ " + a + ", " + b + ", " + c + ", " + d + ", " + e + " ]";
  }

}
