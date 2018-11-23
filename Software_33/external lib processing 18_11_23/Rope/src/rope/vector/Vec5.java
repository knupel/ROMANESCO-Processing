package rope.vector;

public class Vec5 extends Vec {
  public Vec5() {
  	super(5);
  	set(0,0,0,0,0);
  }
  
  public Vec5(float v) {
  	super(5);
  	set(v,v,v,v,v);
  }

  public Vec5(float a, float b, float c, float d, float e) {
    super(5) ;
    set(a,b,c,d,e);
  }
  
  private String warning = "Contructor class Vec5() cannot use the String key_random: ";
  public Vec5(String key_random, float r1) {
    super(5) ;
    if(key_random.equals(RANDOM)) {
      set(random(-r1,r1),random(-r1,r1),random(-r1,r1),random(-r1,r1),random(-r1,r1));
    } else if(key_random.equals(RANDOM_ZERO)) {
      set(random(0,r1),random(0,r1),random(0,r1),random(0,r1),random(0,r1));
    } else {
      this.a = this.b = this.c = this.d = this.e = 0 ;
      System.out.println(warning+key_random) ;
    }
  }
  
  public Vec5(String key_random, float r1, float r2, float r3, float r4, float r5) {
    super(5) ;
    if(key_random.equals(RANDOM)) {
      set(random(-r1,r1),random(-r2,r2),random(-r3,r3),random(-r4,r4),random(-r5,r5));
    } else if(key_random.equals(RANDOM_ZERO)) {
      set(random(0,r1),random(0,r2),random(0,r3),random(0,r4),random(0,r5));
    } else {
      this.a = this.b = this.c = this.d = this.e = 0 ;
      System.out.println(warning+key_random);
    }
  }

  public Vec5(String key_random, float a1, float a2, float b1, float b2, float c1, float c2, float d1, float d2, float e1, float e2) {
    super(5) ;
    if(key_random.equals(RANDOM_RANGE)) {
      set(random(a1,a2),random(b1,b2),random(c1,c2),random(d1,d2),random(e1,e2));
    } else {
      this.a = this.b = this.c = this.d = this.e = 0;
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
   * @return
   */
  public Vec5 set(float a,float b, float c, float d, float e) {
  	this.a = a;
  	this.b = b;
  	this.c = c;
  	this.d = d;
  	this.e = e;
  	return this;
  }
  
  public Vec5 set(float[] source) {
    set(source[0],source[1],source[2],source[3],source[4]);
    return this ;
  }
  
  public Vec5 set(float v) {
    set(v,v,v,v,v);
    return this;
  }
  
  public Vec5 set(Vec v) {
    if( v == null) {
      a = b = c = d = e = 0 ;
      return this ;
    } else if(v instanceof Vec5 || v instanceof Vec6) {
      set(v.a,v.b,v.c,v.d,v.e);
      return this ;
    } else {
      set(v.x,v.y,v.z,v.w,0);
      return this ;
    }
  }
  
  
  // abcde
  public Vec5 set_a(float a) {
    return set(a,this.b,this.c,this.d,this.e);
  }

  public Vec5 set_b(float b) {
    return set(this.a,b,this.c,this.d,this.e);
  }

  public Vec5 set_c(float c) {
    return set(this.a,this.b,c,this.d,this.e);
  }

  public Vec5 set_d(float d) {
    return set(this.a,this.b,this.c,d,this.e);
  }

  public Vec5 set_e(float e) {
    return set(this.a,this.b,this.c,this.d,e);
  }
  
  
  
  /**
   * max
   * @return
   */
  public float max_vec() {
    float [] list = {a,b,c,d,e} ;
    return max(list) ;
  }
  
  /**
   * min
   * @return
   */
  public float min_vec() {
    float [] list = {a,b,c,d,e} ;
    return min(list) ;
  }
  
  /**
   * copy
   * @return
   */
  public Vec5 copy() {
    return new Vec5(a,b,c,d,e) ;
  }
  
  @Override 
  public String toString() {
    return "[ " + a + ", " + b + ", " + c + ", " + d + ", " + e + " ]";
  }
}
