package rope.vector;

public class Vec6 extends Vec {
  public Vec6() {
  	super(6);
  	set(0,0,0,0,0,0); 
  }

  public Vec6(float v) {
  	super(6);
  	set(v,v,v,v,v,v); 
  }

  public Vec6(float a, float b, float c, float d, float e, float f) {
    super(6) ;
    set(a,b,c,d,e,f);
  }
  
  private String warning = "Contructor class Vec6() cannot use the String key_random: ";
  public Vec6(String key_random, float r1) {
    super(6) ;
    if(key_random.equals(RANDOM)) {
      set(random(-r1,r1),random(-r1,r1),random(-r1,r1),random(-r1,r1),random(-r1,r1),random(-r1,r1));
    } else if(key_random.equals(RANDOM_ZERO)) {
      set(random(0,r1),random(0,r1),random(0,r1),random(0,r1),random(0,r1),random(0,r1));
    } else {
      this.a = this.b = this.c = this.d = this.e = this.f = 0 ;
      System.out.println(warning+key_random);
    }
  }
  
  public Vec6(String key_random, float r1, float r2, float r3, float r4, float r5, float r6) {
    super(6) ;
    if(key_random.equals(RANDOM)) {
      set(random(-r1,r1),random(-r2,r2),random(-r3,r3),random(-r4,r4),random(-r5,r5),random(-r6,r6));
    } else if(key_random.equals(RANDOM_ZERO)) {
      set(random(0,r1),random(0,r2),random(0,r3),random(0,r4),random(0,r5),random(0,r6));
    } else {
      this.a = this.b = this.c = this.d = this.e = this.f = 0 ;
      System.out.println(warning+key_random);
    }
  }

  public Vec6(String key_random, float a1, float a2, float b1, float b2, float c1, float c2, float d1, float d2, float e1, float e2, float f1, float f2) {
    super(6) ;
    if(key_random.equals(RANDOM_RANGE)) {
      set(random(a1,a2),random(b1,b2),random(c1,c2),random(d1,d2),random(e1,e2),random(f1,f2));
    } else {
      this.a = this.b = this.c = this.d = this.e = this.f = 0 ;
      System.out.println(warning+key_random);
    }
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
  public Vec6 set(float a, float b, float c, float d, float e, float f) {
  	this.a = a;
  	this.b = b;
  	this.c = c;
  	this.d = d;
  	this.e = e;
  	this.f = f;
  	return this;
  }
  
  public Vec6 set(float[] source) {
    set(source[0],source[1],source[2],source[3],source[4],source[5]);
    return this ;
  }
  
  public Vec6 set(float v) {
    set(v,v,v,v,v,v);
    return this;
  }
  
  public Vec6 set(Vec v) {
    if ( v == null) {    
      a = b = c = d = e = f = 0;
      return this;
    } else if(v instanceof Vec5 || v instanceof Vec6) {
      set(v.a ,v.b,v.c,v.d,v.e,v.f);
      return this;
    } else {
      set(v.x,v.y,v.z,v.w,0,0);
      return this;
    }
  }
  
  public Vec6 set_a(float a) {
    return set(a,this.b,this.c,this.d,this.e,this.f);
  }

  public Vec6 set_b(float b) {
    return set(this.a,b,this.c,this.d,this.e,this.f);
  }

  public Vec6 set_c(float c) {
    return set(this.a,this.b,c,this.d,this.e,this.f);
  }

  public Vec6 set_d(float d) {
    return set(this.a,this.b,this.c,d,this.e,this.f);
  }

  public Vec6 set_e(float e) {
    return set(this.a,this.b,this.c,this.d,e,this.f);
  }

  public Vec6 set_f(float f) {
    return set(this.a,this.b,this.c,this.d,this.e,f);
  }
  
  /**
   * max
   * @return
   */
  public float max_vec() {
    float [] list = {a,b,c,d,e,f} ;
    return max(list) ;
  }
  
  /**
   * min
   * @return
   */
  public float min_vec() {
    float [] list = {a,b,c,d,e,f} ;
    return min(list) ;
  }
  
  /**
   * copy
   * @return
   */
  public Vec6 copy() {
    return new Vec6(a,b,c,d,e,f) ;
  }
  
  @Override 
  public String toString() {
    return "[ " + a + ", " + b + ", " + c + ", " + d + ", " + e + ", " + f + " ]" ;
  }
  
  
}
