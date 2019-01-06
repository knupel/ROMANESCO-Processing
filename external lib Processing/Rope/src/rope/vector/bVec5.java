package rope.vector;

public class bVec5 extends bVec {

	public bVec5(boolean a,boolean b,boolean c, boolean d, boolean e) {
		super(5);
		set(a,b,c,d,e);
	}
	
	public bVec5(boolean arg) {
		super(5);	
		set(arg);
	}
	
	public bVec5(bVec b) {
		super(5);	
		set(b);
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
  public bVec5 set(boolean a, boolean b, boolean c, boolean d, boolean e) {
  	this.a = a;
  	this.b = b;
  	this.c = c;
  	this.d = d;
  	this.e = e;
  	return this;
  }
  
  public bVec5 set(boolean arg){
    set(arg,arg,arg,arg,arg);
    return this;
  }

  public bVec5 set(bVec v) {
    if(v == null) {
      this.a = this.b = this.c = this.d = this.e = false;
      return this;
    } else if(v instanceof bVec5 || v instanceof bVec6) {
      set(v.a,v.b,v.c,v.d,v.e);
      return this;
    } else {
      set(v.x,v.y,v.z,v.w,false);
      return this;
    }
  }


  // abcde
  public bVec5 set_a(boolean a) {
    return set(a,this.b,this.c,this.d,this.e);
  }

  public bVec5 set_b(boolean b) {
    return set(this.a,b,this.c,this.d,this.e);
  }

  public bVec5 set_c(boolean c) {
    return set(this.a,this.b,c,this.d,this.e);
  }

  public bVec5 set_d(boolean d) {
    return set(this.a,this.b,this.c,d,this.e);
  }

  public bVec5 set_e(boolean e) {
    return set(this.a,this.b,this.c,this.d,e);
  }
	
	@Override 
	public String toString() {
		return "[ " + a + ", " + b + ", " + c + ", " + d + ", " + e + " ]";
	}
}
