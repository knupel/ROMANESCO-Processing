package rope.vector;

public class iVec6 extends iVec {
	public iVec6() {
  	super(6);
  	set(0,0,0,0,0,0); 
  }

  public iVec6(int v) {
  	super(6);
  	set(v,v,v,v,v,v); 
  }
  public iVec6(int a, int b, int c, int d, int e, int f) {
    super(6);
    set(a,b,c,d,e,f);
  }

  public iVec6(iVec v) {
    super(6);
    set(v);
  }
  
  /**
   * set
   * @param a
   * @param b
   * @param c
   * @param d
   * @param e
   * @param f
   * @return
   */
  public iVec6 set(int a, int b, int c, int d, int e, int f) {
  	this.a = a;
  	this.b = b;
  	this.c = c;
  	this.d = d;
  	this.e = e;
  	this.f = f;
  	return this;
  }
  
  public void set(int arg){
    set(arg,arg,arg,arg,arg,arg);
  }

  public iVec6 set(iVec v) {
    if(v == null) {
      this.a = this.b = this.c = this.d = this.e = this.f = 0;
      return this;
    } else if(v instanceof iVec5 || v instanceof iVec6) {
      set(v.a,v.b,v.c,v.d,v.e,v.f);
      return this;
    } else {
      set(v.x,v.y,v.z,v.w,0,0);
      return this;
    }
  }

  // abcdef
  public iVec6 set_a(int a) {
    return set(a,this.b,this.c,this.d,this.e,this.f);
  }

  public iVec6 set_b(int b) {
    return set(this.a,b,this.c,this.d,this.e,this.f);
  }

  public iVec6 set_c(int c) {
    return set(this.a,this.b,c,this.d,this.e,this.f);
  }

  public iVec6 set_d(int d) {
    return set(this.a,this.b,this.c,d,this.e,this.f);
  }

  public iVec6 set_e(int e) {
    return set(this.a,this.b,this.c,this.d,e,this.f);
  }

  public iVec6 set_f(int f) {
    return set(this.a,this.b,this.c,this.d,this.e,f);
  }
  
  /**
   * get array component
   */
  public int [] get_array() {
    int array [] = {a,b,c,d,e,f};
    return array ;
  }
  
  /**
   * copy
   * @return
   */
  public iVec6 copy() {
    return new iVec6(a,b,c,d,e,f) ;
  }
  
  
  @Override 
  public String toString() {
    return "[ " + a + ", " + b + ", " + c + ", " + d + ", " + e + ", " + f + " ]" ;
  }

}
