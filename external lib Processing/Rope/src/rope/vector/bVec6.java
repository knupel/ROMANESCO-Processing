package rope.vector;

public class bVec6 extends bVec {
	
	public bVec6(boolean a,boolean b,boolean c, boolean d, boolean e, boolean f) {
		super(6);
		set(a,b,c,d,e,f);
	}
	
	public bVec6(boolean arg) {
		super(6);
		set(arg);
	}
	
	public bVec6(bVec b) {
		super(6);	
		set(b);
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
  public bVec6 set(boolean a, boolean b, boolean c, boolean d, boolean e, boolean f) {
  	this.a = a;
  	this.b = b;
  	this.c = c;
  	this.d = d;
  	this.e = e;
  	this.f = f;
  	return this;
  }
  
  public bVec6 set(boolean arg){
    set(arg,arg,arg,arg,arg,arg);
    return this;
  }

  public bVec6 set(bVec v) {
    if(v == null) {
      this.a = this.b = this.c = this.d = this.e = this.f = false;
      return this;
    } else if(v instanceof bVec5 || v instanceof bVec6) {
      set(v.a,v.b,v.c,v.d,v.e,v.f);
      return this;
    } else {
      set(v.x,v.y,v.z,v.w,false,false);
      return this;
    }
  }

  // abcdef
  public bVec6 set_a(boolean a) {
    return set(a,this.b,this.c,this.d,this.e,this.f);
  }

  public bVec6 set_b(boolean b) {
    return set(this.a,b,this.c,this.d,this.e,this.f);
  }

  public bVec6 set_c(boolean c) {
    return set(this.a,this.b,c,this.d,this.e,this.f);
  }

  public bVec6 set_d(boolean d) {
    return set(this.a,this.b,this.c,d,this.e,this.f);
  }

  public bVec6 set_e(boolean e) {
    return set(this.a,this.b,this.c,this.d,e,this.f);
  }

  public bVec6 set_f(boolean f) {
    return set(this.a,this.b,this.c,this.d,this.e,f);
  }
	
	@Override 
	public String toString() {
		return "[ " + a + ", " + b + ", " + c + ", " + d + ", " + e + ", " + f + " ]";
	}
}
