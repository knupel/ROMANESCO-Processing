/**
ROPE VECTOR
v 2.7.0
* Copyleft (c) 2014-2018 
* Stan le Punk > http://stanlepunk.xyz/
Rope – Romanesco Processing Environment: 2015–2018
* @author Stan le Punk
* @see https://github.com/StanLepunK/Rope
*/
/**
inspireted by GLSL code and PVector from Daniel Shiffman
*/







/**
bVec class
v 0.3.2.0
2017-2017
vector with int precision
*/
abstract class bVec implements Rope_Constants {
  private int num ;
  boolean x,y,z,w;
  boolean a,b,c,d,e,f;
  bVec(int num) {
    this.num = num ;
  }
  
  /**
  * @return the number of componenets
  */
  int get_num() {
    return num;
  }
  /**
  array
  */
  /**
  * return the list of component
  * @return float []
  */
  public boolean [] get_array() {
    if(num == 2) {
      boolean array [] = {x,y};
      return array;
    } else if(num == 3) {
      boolean array [] = {x,y,z};
      return array;
    } else if(num == 4) {
      boolean array [] = {x,y,z,w};
      return array;
    } else if(num == 5) {
      boolean array [] = {a,b,c,d,e,f};
      return array;
    } else if(num == 6) {
      boolean array [] = {a,b,c,d,e,f};
      return array;
    } else return null ;
  }
}



/**
bVec2
v 0.0.2
*/
class bVec2 extends bVec {
  bVec2(boolean x, boolean y) {
    super(2);
    set(x,y);
  }

  bVec2(bVec v) {
    super(2);
    set(v);
  }
  
  public bVec2 set(boolean arg){
    set(arg,arg);
    return this;
  }

  public bVec2 set(bVec v) {
    if(v == null) {
      this.x = this.y = false;
      return this;
    } else if(v instanceof bVec5 || v instanceof bVec6) {
      set(v.a,v.b);
      return this;
    } else {
      set(v.x,v.y);
      return this;
    }
  }

  /** 
  * master method set
  * @return bVec
  */
  public bVec2 set(boolean x, boolean y) {
    this.x = this.a = x ;
    this.y = this.b = y ;
    return this;
  }

  @Override String toString() {
    return "[ " + x + ", " + y + " ]" ;
  }
}

/**
bVec3
v 0.0.1
*/
class bVec3 extends bVec {
  bVec3(boolean x, boolean y, boolean z) {
    super(3);
    set(x,y,z);
  }

  bVec3(bVec v) {
    super(3);
    set(v);
  }
  
  public bVec3 set(boolean b){
    set(b,b,b);
    return this;
  }

  public bVec3 set(bVec v) {
    if(v == null) {
      this.x = this.y = false;
      return this;
    } else if(v instanceof bVec5 || v instanceof bVec6) {
      set(v.a,v.b,v.c);
      return this;
    } else {
      set(v.x,v.y,v.z);
      return this;
    }
  }

  /** 
  * master method set
  * @return bVec
  */
  public bVec3 set(boolean x, boolean y, boolean z) {
    this.x = this.a = x ;
    this.y = this.b = y ;
    this.z = this.c = z ;
    return this;
  }

  @Override String toString() {
    return "[ " + x + ", " + y + ", " + z +" ]" ;
  }
}

/**
bVec4
v 0.0.1
*/
class bVec4 extends bVec {
  bVec4(boolean x, boolean y, boolean z, boolean w) {
    super(4);
    set(x,y,z,w);
  }

  bVec4(bVec v) {
    super(4);
    set(v);
  }
  
  public bVec4 set(boolean b){
    set(b,b,b,b);
    return this;
  }

  public bVec4 set(bVec v) {
    if(v == null) {
      this.x = this.y = false;
      return this;
    } else if(v instanceof bVec5 || v instanceof bVec6) {
      set(v.a,v.b,v.c,v.d);
      return this;
    } else {
      set(v.x,v.y,v.z,v.w);
      return this;
    }
  }

  /** 
  * master method set
  * @return bVec
  */
  public bVec4 set(boolean x, boolean y, boolean z, boolean w) {
    this.x = this.a = x ;
    this.y = this.b = y ;
    this.z = this.c = z ;
    this.w = this.d = w ;
    return this;
  }

  @Override String toString() {
    return "[ " + x + ", " + y + ", " + z + ", " + w +" ]" ;
  }
}


/**
bVec5
v 0.0.1
*/
class bVec5 extends bVec {
  bVec5(boolean a, boolean b, boolean c, boolean d, boolean e) {
    super(5);
    set(a,b,c,d,e);
  }

  bVec5(bVec v) {
    super(5);
    set(v);
  }
  
  public bVec5 set(boolean b){
    set(b,b,b,b,b);
    return this;
  }

  public bVec5 set(bVec v) {
    if(v == null) {
      this.x = this.y = false;
      return this;
    } else if(v instanceof bVec5 || v instanceof bVec6) {
      set(v.a,v.b,v.c,v.d,v.e);
      return this;
    } else {
      set(v.x,v.y,v.z,v.w,false);
      return this;
    }
  }

  /** 
  * master method set
  * @return bVec
  */
  public bVec5 set(boolean a, boolean b, boolean c, boolean d, boolean e) {
    this.a = a;
    this.b = b;
    this.c = c;
    this.d = d;
    this.e = e;
    return this;
  }

  @Override String toString() {
    return "[ " + a + ", " + b + ", " + c + ", " + d + ", " + e +" ]" ;
  }
}


/**
bVec5
v 0.0.1
*/
class bVec6 extends bVec {
  bVec6(boolean a, boolean b, boolean c, boolean d, boolean e, boolean f) {
    super(6);
    set(a,b,c,d,e,f);
  }

  bVec6(bVec v) {
    super(6);
    set(v);
  }
  
  public bVec6 set(boolean b){
    set(b,b,b,b,b,b);
    return this;
  }

  public bVec6 set(bVec v) {
    if(v == null) {
      this.x = this.y = false;
      return this;
    } else if(v instanceof bVec5 || v instanceof bVec6) {
      set(v.a,v.b,v.c,v.d,v.e,v.f);
      return this;
    } else {
      set(v.x,v.y,v.z,v.w,false,false);
      return this;
    }
  }

  /** 
  * master method set
  * @return bVec
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

  @Override String toString() {
    return "[ " + a + ", " + b + ", " + c + ", " + d + ", " + e + ", " + f +" ]" ;
  }
}











/**
iVec class
v 0.10
2017-2018
vector with int precision
*/
abstract class iVec implements Rope_Constants {
  private int num;
  int x,y,z,w;
  int a,b,c,d,e,f;
  int r,g;
  int s,t,p,q;
  int u,v;
  iVec(int num) {
    this.num = num ;
  }
  /**
  * @return the number of componenets
  */
  int get_num() {
    return num;
  }
  /**
  array
  */
  /**
  * return the list of component
  * @return float []
  */
  public int [] get_array() {
    if(num == 2) {
      int array [] = {x,y};
      return array;
    } else if(num == 3) {
      int array [] = {x,y,z};
      return array;
    } else if(num == 4) {
      int array [] = {x,y,z,w};
      return array;
    } else if(num == 5) {
      int array [] = {a,b,c,d,e,f};
      return array;
    } else if(num == 6) {
      int array [] = {a,b,c,d,e,f};
      return array;
    } else return null ;
  }
}

/**
iVec2
v 0.0.3
*/
class iVec2 extends iVec {
  iVec2(int x, int y) {
    super(2);
    set(x,y);
  }

  iVec2(iVec v) {
    super(2);
    set(v);
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
  * set method master
  * here we cannot set the arg a,b, c,d,e,f cause r,g,b,a
  */
  public iVec2 set(int x, int y) {
    this.x = this.s = this.u = x ;
    this.y = this.t = this.v = y ;
    return this;
  }

  /**
  sum
  */
  /**
  * sum return the sum of all components
  * @return int
  */
  int sum() {
    return x+y;
  }

  /**
  Multiplication
  v 0.0.1
  */
  iVec2 mult(int m_x, int m_y) {
    x *= m_x; 
    y *= m_y; 
    set(x,y);
    return this;
  }

  iVec2 mult(int m) {
    return mult(m,m);
  }

  iVec2 mult(iVec v) {
    if(v != null) {
      return mult(v.x,v.y);
    } else return null;
  }

   
  /**
  Division
  v 0.0.1
  */
  /**
  * divide Vector by a int value 
  */
  iVec2 div(int d_x, int d_y) {
    if(d_x != 0) x /= d_x; 
    if(d_y != 0) y /= d_y; 
    set(x,y);
    return this;
  }
  iVec2 div(int d) {
    return div(d,d);
  }
  

  iVec2 div(iVec v) {
    if(v != null) {
      return div(v.x,v.y);
    } else return null;
  }
  
  
  /**
  Addition
  v 0.0.1
  */
  /** 
  * add float value 
  */
  iVec2 add(int a_x,int a_y) {
    x += a_x;
    y += a_y;
    set(x,y);
    return this;
  }

  iVec2 add(int a) {
    return add(a,a);
  }


  iVec2 add(iVec v) {
    if(v != null) {
      return add(v.x,v.y);
    } else return null;
  }


  /**
  Substraction
  */
  /** 
  * sub float value 
  */
  iVec2 sub(int a_x,int a_y) {
    x -= a_x;
    y -= a_y;
    set(x,y);
    return this;
  }

  iVec2 sub(int a) {
    return sub(a,a);
  }


  iVec2 sub(iVec v) {
    if(v != null) {
      return sub(v.x,v.y);
    } else return null;
  }


  /**
  Equals
  */
  boolean equals(iVec2 target) {
    if(target != null ) {
      if((x == target.x) && (y == target.y)) {
        return true; 
      } else return false;
    } else return false;
  }

  boolean equals(int target) {
    if((x == target) && (y == target)) 
    return true; 
    else return false;
  }
  
  boolean equals(int tx, int ty) {
    if((x == tx) && (y == ty)) 
    return true; 
    else return false;
  }



  /**
  Copy
  */
  /**
  * return all the component of Vec
  * @return iVec2
  */
  iVec2 copy() {
    return new iVec2(x,y) ;
  }



  @Override String toString() {
    return "[ " + x + ", " + y + " ]" ;
  }
}





/**
iVec3
v 0.2.0
*/
class iVec3 extends iVec {
  iVec3(int x, int y, int z) {
    super(3);
    set(x,y,z);
  }

  iVec3(iVec v) {
    super(3);
    set(v);
  }
  

  public void set(int arg){
    set(arg,arg, arg);
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
  * set method master
  * here we cannot set the arg a,b, c,d,e,f cause r,g,b,a
  */
  public iVec3 set(int x, int y, int z) {
    this.x = this.r = this.s = x ;
    this.y = this.g = this.t = y ;
    this.z = this.b = this.p = z ;
    return this ;
  }

  /**
  sum
  */
  /**
  * sum return the sum of all components
  * @return int
  */
  int sum() {
    return x+y+z;
  }

  /**
  Multiplication
  v 0.0.2
  */
    /**
  * multiply Vector by int value
  * @return iVec3 
  */
  iVec3 mult(int m_x, int m_y, int m_z) {
    x *= m_x; 
    y *= m_y; 
    z *= m_z;
    set(x,y,z) ;
    return this ;
  }

  iVec3 mult(int m) {
    return mult(m,m,m);
  }

  iVec3 mult(iVec v) {
    if(v != null) {
      return mult(v.x,v.y,v.z);
    } else return null ;
  }
   
  /**
  Division
  v 0.0.2
  */
  /**
  * divide Vector by int value
  * @return iVec3 
  */
  iVec3 div(int d_x, int d_y, int d_z) {
    if(d_x != 0) x /= d_x; 
    if(d_y != 0) y /= d_y; 
    if(d_z != 0) z /= d_z; 
    set(x,y,z);
    return this;
  }
  iVec3 div(int d) {
    return div(d,d,d);
  }
  
  iVec3 div(iVec v) {
    if(v != null) {
      return div(v.x,v.y,v.z);
    } else return null;
  }
  
  
  /**
  Addition
  v 0.0.1
  */
  /** 
  * add int value 
  */
  iVec3 add(int a_x,int a_y,int a_z) {
    x += a_x;
    y += a_y;
    z += a_z;
    set(x,y,z);
    return this;
  }

  iVec3 add(int a) {
    return add(a,a,a);
  }

  iVec3 add(iVec v) {
    if(v != null) {
      return add(v.x,v.y,v.z);
    } else return null;
  }


  /**
  Substraction
  v 0.0.1
  */
  /** 
  * sub int value 
  */
  iVec3 sub(int a_x,int a_y,int a_z) {
    x -= a_x;
    y -= a_y;
    z -= a_z;
    set(x,y,z);
    return this;
  }

  iVec3 sub(int a) {
    return sub(a,a,a);
  }

  iVec3 sub(iVec v) {
    if(v != null) {
      return sub(v.x,v.y,v.z);
    } else return null;
  }

  /**
  Equals
  */
  boolean equals(iVec3 target) {
    if(target != null ) {
      if((x == target.x) && (y == target.y) && (z == target.z)) {
        return true; 
      } else return false;
    } else return false;
  }

  boolean equals(int target) {
    if((x == target) && (y == target) && (z == target)) 
    return true; 
    else return false;
  }
  
  boolean equals(int tx, int ty, int tz) {
    if((x == tx) && (y == ty) && (z == tz)) 
    return true; 
    else return false;
  }

  /**
  Copy
  */
  /**
  * return all the component of Vec
  * @return iVec3
  */
  iVec3 copy() {
    return new iVec3(x,y,z) ;
  }





  @Override String toString() {
    return "[ " + x + ", " + y + ", " + z + " ]" ;
  }
}


  

/**
iVec4
v 0.2.0
*/
class iVec4 extends iVec {
  iVec4(int x, int y, int z, int w) {
    super(4) ;
    set(x,y,z,w);
  }

  iVec4(iVec v) {
    super(4) ;
    set(v);
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
  * set method master
  * here we cannot set the arg a,b, c,d,e,f cause r,g,b,a
  */
  public iVec4 set(int x, int y, int z, int w) {
    this.x = this.r = this.s = x ;
    this.y = this.g = this.t = y ;
    this.z = this.b = this.p = z ;
    this.w = this.a = this.q = w ;
    return this ;
  }

  /**
  sum
  */
  /**
  * sum return the sum of all components
  * @return int
  */
  int sum() {
    return x+y+z+w;
  }

  /**
  Multiplication
  v 0.0.2
  */
    iVec4 mult(int m_x, int m_y, int m_z, int m_w) {
    x *= m_x ; y *= m_y ; z *= m_z ; w *= m_w ;
    set(x,y,z,w) ;
    return this ;
  }

  iVec4 mult(int m) {
    return mult(m,m,m,m);
  }

  iVec4 mult(iVec v) {
    if(v != null) {
      return mult(v.x,v.y,v.z,v.w);
    } else return null ;
  }
   
  /**
  Division
  v 0.0.2
  */
  /**
  * @return Vec
  * divide Vector by a float value 
  */
  iVec4 div(int d_x, int d_y, int d_z, int d_w) {
    if(d_x != 0) x /= d_x; 
    if(d_y != 0) y /= d_y; 
    if(d_z != 0) z /= d_z; 
    if(d_w != 0) w /= d_w;
    set(x,y,z,w);
    return this;
  }
  iVec4 div(int d) {
    return div(d,d,d,d);
  }
  
  iVec4 div(iVec v) {
    if(v != null) {
      return div(v.x,v.y,v.z,v.w);
    } else return null;
  }
  
  
  /**
  Addition
  v 0.0.1
  */
  /* 
  * add float value 
  */
  iVec4 add(int a_x,int a_y,int a_z,int a_w) {
    x += a_x;
    y += a_y;
    z += a_z;
    w += a_w;
    set(x,y,z,w);
    return this;
  }

  iVec4 add(int a) {
    return add(a,a,a,a);
  }

  iVec4 add(iVec v) {
    if(v != null) {
      return add(v.x,v.y,v.z,v.w);
    } else return null;
  }


  /**
  Substraction
  v 0.0.1
  */
  /* 
  * sub float value 
  */
  iVec4 sub(int a_x,int a_y,int a_z, int a_w) {
    x -= a_x;
    y -= a_y;
    z -= a_z;
    w -= a_w; 
    set(x,y,z,w);
    return this;
  }

  iVec4 sub(int a) {
    return sub(a,a,a,a);
  }

  iVec4 sub(iVec v) {
    if(v != null) {
      return sub(v.x,v.y,v.z,v.w);
    } else return null;
  }

  /**
  Equals
  */
  boolean equals(iVec4 target) {
    if(target != null ) {
      if((x == target.x) && (y == target.y) && (z == target.z) && (w == target.w)) {
        return true; 
      } else return false;
    } else return false;
  }

  boolean equals(int target) {
    if((x == target) && (y == target) && (z == target) && (w == target)) 
    return true; 
    else return false;
  }
  
  boolean equals(int tx, int ty, int tz, int tw) {
    if((x == tx) && (y == ty) && (z == tz) && (w == tw)) 
    return true; 
    else return false;
  }

  /**
  Copy
  */
  /**
  * return all the component of Vec
  * @return iVec4
  */
  iVec4 copy() {
    return new iVec4(x,y,z,w) ;
  }



  @Override String toString() {
    return "[ " + x + ", " + y + ", " + z + ", " + w + " ]" ;
  }
}

/**
iVec5
v 0.0.3
*/
class iVec5 extends iVec {
  iVec5(int a, int b, int c, int d, int e) {
    super(5) ;
    set(a,b,c,d,e);
  }

  iVec5(iVec v) {
    super(5) ;
    set(v);
  } 

  public void set(int arg){
    set(arg,arg,arg,arg,arg);
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
  * set main
  */
  public iVec5 set(int a, int b, int c, int d, int e) {
    this.a = a;
    this.b = b;
    this.c = c;
    this.d = d;
    this.e = e;
    return this;
  }

  /**
  array
  */
  /**
  * return the list of component
  * @return int []
  */
  public int [] get_array() {
    int array [] = {a,b,c,d,e};
    return array ;
  }


  /**
  Copy
  */
  /**
  * return all the component of Vec
  * @return iVec5
  */
  iVec5 copy() {
    return new iVec5(a,b,c,d,e) ;
  }

  @Override String toString() {
    return "[ " + a + ", " + b + ", " + c + ", " + d + ", " + e + " ]" ;
  }
}

/**
iVec6
*/
class iVec6 extends iVec {
  iVec6(int a, int b, int c, int d, int e, int f) {
    super(6) ;
    set(a,b,c,d,e,f);
  }

  iVec6(iVec v) {
    super(6) ;
    set(v);
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
  * set method master
  * here we cannot set the arg a,b, c,d,e,f cause r,g,b,a
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


  /**
  Copy
  */
  /**
  * return all the component of Vec
  * @return iVec6
  */
  iVec6 copy() {
    return new iVec6(a,b,c,d,e,f) ;
  }

  @Override String toString() {
    return "[ " + a + ", " + b + ", " + c + ", " + d + ", " + e + ", " + f + " ]" ;
  }
}










































/**
Vec class
v 1.15.0
2015-2017
Vector with a float precision

*/
public abstract class Vec implements Rope_Constants {
  int num ;
  float x,y,z,w = Float.NaN;
  float a,b,c,d,e,f = Float.NaN;
  float r,g = Float.NaN;
  float s,t,p,q = Float.NaN;
  float u,v = Float.NaN;
  Vec(int num) {
    this.num = num ;
  }
  /**
  * @return the number of components
  */
  public int get_num() {
    return num ;
  }

  /**
  array
  */
  /**
  * return the list of component
  * @return float []
  */
  public float [] get_array() {
    if(num == 2) {
      float array [] = {x,y};
      return array;
    } else if(num == 3) {
      float array [] = {x,y,z};
      return array;
    } else if(num == 4) {
      float array [] = {x,y,z,w};
      return array;
    } else if(num == 5) {
      float array [] = {a,b,c,d,e,f};
      return array;
    } else if(num == 6) {
      float array [] = {a,b,c,d,e,f};
      return array;
    } else return null ;
  }
}


/**
Vec 2
*/
public class Vec2 extends Vec {

  public Vec2(float x, float y) {
    super(2);
    set(x,y);
  }
  /**
  Random constructor
  */
  public Vec2(String key_random, int r1) {
    super(2) ;
    if(key_random.equals(RANDOM)) {
      set(random(-r1,r1),random(-r1,r1));
    } else if(key_random.equals(RANDOM_ZERO)) {
      set(random(0,r1),random(0,r1));
    } else {
      this.x = this.y = this.s = this.t = this.u = this.v = 0 ;
      println("the key word for the random is not available use the String 'RANDOM' or 'RANDOM ZERO' ") ;
    }
  }
  
  public Vec2(String key_random, int r1, int r2) {
    super(2) ;
    if(key_random.equals(RANDOM)) {
      set(random(-r1,r1),random(-r2,r2));
    } else if(key_random.equals(RANDOM_ZERO)) {
      set(random(0,r1),random(0,r2));
    } else if(key_random.equals(RANDOM_RANGE)) {
      set(random(r1,r2),random(r1,r2));
    } else {
      this.x = this.y = this.s = this.t = this.u = this.v = 0 ;
      println("the key word for the random is not available use the String 'RANDOM' or 'RANDOM ZERO' or 'RANDOM RANGE' ") ;
    }
  }

  public Vec2(String key_random, int a1, int a2, int b1, int b2) {
    super(2) ;
    if(key_random.equals(RANDOM_RANGE)) {
      set(random(a1,a2),random(b1,b2));
    } else {
      this.x = this.y = this.s = this.t = this.u = this.v = 0 ;
      println("the key word for the random is not available use the String 'RANDOM RANGE' ") ;
    }
  }
  /**
  Set
  */
  /**
  * Sets components of the vector using two or three separate
  * variables, the data from a Vec, or the values from a float array.
  */
  public Vec2 set(float v) {
    set(v,v);
    return this;
  }

  /**
  * @param v any variable of type Vec
  */
  public Vec2 set(Vec v) {
    if(v == null) {
      set(0,0);
      return this;
    } else if(v instanceof Vec5 || v instanceof Vec6) {
      set(v.a,v.b);
      return this;
    } else {
      set(v.x,v.y);
      return this;
    }
  }

  public Vec2 set(iVec v) {
    if(v == null) {
      set(0,0);
      return this;
    } else if(v instanceof iVec5 || v instanceof iVec6) {
      set(v.a,v.b);
      return this;
    } else {
      set(v.x,v.y);
      return this;
    }
  }

  /**
  * Set the x, y (and maybe z) coordinates using a float[] array as the source.
  * @param source array to copy from
  */
  public Vec2 set(float[] source) {
    set(source[0],source[1]);
    return this;
  }

  // xy
  public Vec2 set_x(float x) {
    return set(x,this.y);
  }

  public Vec2 set_y(float y) {
    return set(this.x,y);
  }

  // st
  public Vec2 set_s(float x) {
    return set(x,this.y);
  }

  public Vec2 set_t(float y) {
    return set(this.x,y);
  }

  // uv
  public Vec2 set_u(float x) {
    return set(x,this.y);
  }

  public Vec2 set_v(float y) {
    return set(this.x,y);
  }


  /**
  * set method master
  * here we cannot set the arg a,b, c,d,e,f cause r,g,b,a
  */
  public Vec2 set(float x, float y) {
    this.x = this.s = this.u = x;
    this.y = this.t = this.v = y;
    return this;
  }

  /**
  sum
  */
  /**
  * sum return the sum of all components
  * @return float
  */
  float sum() {
    return x+y;
  } 
   
  /**
  multiplication
  */
  /**
  * multiply Vector by different float value 
  */
  Vec2 mult(float m_x, float m_y) {
    x *= m_x ; 
    y *= m_y ;
    set(x,y) ;
    return this;
  }

  Vec2 mult(float m) {
    return mult(m,m);
  }

  Vec2 mult(Vec v) {
    if(v != null) {
      return mult(v.x,v.y);
    } else return null ;
  }

  Vec2 mult(iVec v) {
    if(v != null) {
      return mult(v.x,v.y);
    } else return null ;
  }
  

  
  /**
  division
  */
  /**
  * divide Vector by a float value 
  */
  Vec2 div(float d_x, float d_y) {
    if(d_x != 0) x /= d_x; 
    if(d_y != 0) y /= d_y; 
    set(x,y) ;
    return this;   
  }

  Vec2 div(float d) {
    return div(d,d);
  }

  Vec2 div(Vec v) {
    if(v != null) {
      return div(v.x,v.y);
    } else return null ;
  }

  Vec2 div(iVec v) {
    if(v != null) {
      return div(v.x,v.y);
    } else return null ;
  }
  
  
  /** 
  Addition
  */
  /** 
  * add float value 
  */
  public Vec2 add(float a_a, float a_b) {
    x += a_a ;
    y += a_b ; 
    set(x,y) ;
    return this ;
  }

  public Vec2 add(float a) {
    return add(a,a);
  }

  public Vec2 add(Vec v) {
    if(v != null) {
      return add(v.x,v.y);
    } else return null ;
  }

  public Vec2 add(iVec v) {
    if(v != null) {
      return add(v.x,v.y);
    } else return null ;
  }


  /**
  * add two Vector together 
  * @deprecated is not necessary to use this method in the inner class, instead use the external one
  */
  @Deprecated
  Vec2 add(Vec v_a, Vec v_b) {
    if(v_a != null &&  v_b != null) {
      x = v_a.x + v_b.x;
      y = v_a.y + v_b.y;
      return this ;
    } else return null;  
  }


  /**
  Substraction
  */
  /* add float value */
  public Vec2 sub(float s_a,float s_b) {
    x -= s_a;
    y -= s_b; 
    set(x,y);
    return this ;
  }

  public Vec2 sub(float s) {
    return sub(s,s);
  }

  public Vec2 sub(Vec v) {
    if(v != null) {
      return sub(v.x,v.y);
    } else return null;
  }

  public Vec2 sub(iVec v) {
    if(v != null) {
      return sub(v.x,v.y);
    } else return null;
  }
  
  /**
  * sub two Vector together 
  * @deprecated is not necessary to use this method in the inner class, instead use the external one
  */
  @Deprecated
  Vec2 sub(Vec v_a, Vec v_b) {
    if(v_a != null &&  v_b != null) {
      x = v_a.x -v_b.x;
      y = v_a.y -v_b.y;
    }
    set(x,y);
    return this;
  }

  /**
  Average
  */
  public float average() {
    return (this.x +this.y) *.5;
  }


  /**
  Dot
  v 0.0.1.1
  */
  public float dot(Vec v) {
    if(v != null) {
      return x*v.x + y*v.y;
    } else {
      println("Your Vec arg is", null);
      return x*0 + y*0;
    }
  }
  public float dot(float x, float y) {
    return this.x*x + this.y*y;
  }

  
  
  /**
  Direction
  */
  /**
  * return mapping vector
  * @return Vec2
  */
  public Vec2 dir() {
    return dir(Vec2(0));
  }
  public Vec2 dir(float a_x, float a_y) {
    return dir(Vec2(a_x,a_y));
  }
  public Vec2 dir(Vec2 origin) {
    if(origin != null) {
      float dist = dist(origin);
      sub(origin);
      div(dist);
    }
    set(x,y);
    return this;
  }


  /**
  Tangent
  */
  public Vec2 tan() {
    return tan(Vec2(x,y));
  }
  public Vec2 tan(float a_x, float a_y) {
    return tan(Vec2(a_x,a_y)) ;
  }

  public Vec2 tan(Vec2 target) {
    if(target != null) {
      float mag = mag() ;
      target.div(mag);
      x = -target.y;
      y = target.x;
    }
    set(x,y);
    return this;
  }

  /**
  Angle
  Heading for PVector 
  */
  /**
  *
  * Calculate the angle of rotation for this vector (only 2D vectors)
  *
  * @webref vec:method
  * @usage web_application
  * @return the angle of rotation
  * @brief Calculate the angle of rotation for this vector
  */
  public float angle() {
    float angle = (float) Math.atan2(y, x);
    return angle;
  }
  /**
  * heading is a similar method of PVector
  */
  public float heading() {
    return angle();
  }
  

  /**
  Min Max
  */
  /**
  * find the min and the max value in the vector list
  * @return float
  */
  public float max_vec() {
    float [] list = {x,y};
    return max(list);
  }
  public float min_vec() {
    float [] list = {x,y};
    return min(list);
  }

  /**
  Normalize
  */
  public Vec2 normalize(Vec2 target) {
    if (target == null) {
      target = Vec2();
    }
    float m = mag();
    if (m > 0) {
      target.set(x/m, y/m);
    } else {
      target.set(x, y);
    }
    return target;
  }

  public Vec2 normalize() {
    float m = mag();
    if (m != 0 && m != 1) {
      div(m);
    }
    return this ;
  }



  /**
 Map
  */
  /**
  * return mapping vector
  * @return Vec2
  */
  public Vec2 map_vec(float minIn, float maxIn, float minOut, float maxOut) {
    x = map(x,minIn, maxIn, minOut, maxOut);
    y = map(y,minIn, maxIn, minOut, maxOut);  
    set(x,y) ;
    return this ;
  }

  public Vec2 map_vec(Vec2 minIn, Vec2 maxIn, Vec2 minOut, Vec2 maxOut) {
    x = map(x,minIn.x, maxIn.x, minOut.x, maxOut.x);
    y = map(y,minIn.y, maxIn.y, minOut.y, maxOut.y);   
    set(x,y) ;
    return this ;
  }
  
   /**
  Mag and MagSQ
  */
  /**
  * magnitude or length of Vec2
  * @return float
  */
  public float magSq() {
    return (x*x + y*y);
  }


  public float mag() {
    return (float) Math.sqrt(x*x + y*y) ;
  }

  float mag(Vec v_target) {
    if(v_target != null) {
      float new_x = (v_target.x -x) *(v_target.x -x);
      float new_y = (v_target.y -y) *(v_target.y -y);
      return sqrt(new_x +new_y) ;
    } else {
      println("Your Vec arg is", null);
      return 0 ;
    }
  }


  /**
  limit
  */
  public Vec2 limit(float max) {
    if (magSq() > max*max) {
      normalize();
      mult(max);
    }
    return this;
  }
  
  
  /**
  Distance
  */
  /** 
  * distance between himself and an other vector
  * @return float
  */
  public float dist(Vec v_target) {
    if(v_target != null) {
      float dx = x -v_target.x;
      float dy = y -v_target.y;
      return (float) Math.sqrt(dx*dx + dy*dy);
    } else {
      println("Your Vec arg is", null);
      return 0 ;
    }
  }
  
  
  /**
  Jitter
  */
  /**
  * create jitter effect around the vector position with global range 
  */
  public Vec2 jitter(int range) {
    return jitter(range,range);
  }
  public Vec2 jitter(Vec2 range) {
    if(range != null) {
      return jitter((int)range.x,(int)range.y) ;
    } else {
      return jitter(0,0);
    }
    
  }
  /** 
  * with specific range 
  */
  public Vec2 jitter(int range_x,int range_y) {
    x += random_next_gaussian(range_x,3);
    y += random_next_gaussian(range_y,3);
    set(x,y);
    return this;
  }
  
  
  /**
  Revolution
  */
  /**
  * create a circular motion effect 
  */
  Vec2 revolution(int radius, float speed) {
    float new_speed = speed *.01;
    float m_x = sin(frameCount *new_speed);
    float m_y = cos(frameCount *new_speed);
    m_x *=radius;
    m_y *=radius;   
    return this;
  }


  Vec2 revolution(int r_x, int r_y, float speed) {
    float new_speed = speed*.01;
    float m_x = sin(frameCount *new_speed);
    float m_y = cos(frameCount *new_speed);
    m_x *=r_x;
    m_y *=r_y;    
    return this;
  }

  Vec2 revolution(Vec2 radius, float speed) {
    float new_speed = speed*.01;
    float m_x = sin(frameCount *new_speed);
    float m_y = cos(frameCount *new_speed);
    m_x *=radius.x;
    m_y *=radius.y;    
    return this ;
  }

  /**
  Equals
  */
  boolean equals(Vec2 target) {
    if(target != null ) {
      if((x == target.x) && (y == target.y)) {
        return true; 
      } else return false;
    } else return false;
  }

  boolean equals(float target) {
    if((x == target) && (y == target)) 
    return true; 
    else return false;
  }
  
  boolean equals(float t_x,float t_y) {
    if((x == t_x) && (y == t_y)) 
    return true; 
    else return false;
  }



  
  /**
  Compare deprecated
  */
  boolean compare(Vec2 target) {
    if(target != null ) {
      if((x == target.x) && (y == target.y)) {
        return true; 
      } else return false;
    } else return false;
  }

  boolean compare(float target) {
    if((x == target) && (y == target)) 
    return true ; 
    else return false ;
  }
  
  boolean compare(float t_x,float t_y) {
    if((x == t_x) && (y == t_y)) 
    return true; 
    else return false;
  }
  
  
  
  /**
  Copy
  */
  /**
  * return all the component of Vec
  * @return Vec2
  */
  Vec2 copy() {
    return new Vec2(x,y);
  }
  /**
  * return all the component of Vec in type PVector
  * @return PVector
  */
  PVector copy_PVector() {
    return new PVector(x,y);
  }



  /**
  Print info
  */
  @Override String toString() {
    return "[ " + x + ", " + y + " ]";
  }
}
// END VEC 2
////////////





/**
VEC 3
v 1.0.0
*/
class Vec3 extends Vec {
 
  /**
  Constructor
  */
  Vec3(float x, float y, float z) {
    super(3) ;
    set(x,y,z);
  }
  
   /**
  Random constructor
  */ 
  /**
  * random generator for the Vec
  */
  Vec3(String key_random, int r1) {
    super(3) ;
    if(key_random.equals(RANDOM)) {
      set(random(-r1,r1),random(-r1,r1),random(-r1,r1));
    } else if(key_random.equals(RANDOM_ZERO)) {
      set(random(0,r1),random(0,r1),random(0,r1));
    } else {
      this.x = this.y = this.z  = this.r = this.g = this.b =this.s = this.t = this.p = 0 ;
      println("the key word for the random is not available use the String 'RANDOM' or 'RANDOM ZERO' ") ;
    }
  }
  
  Vec3(String key_random, int r1, int r2, int r3) {
    super(3) ;
    if(key_random.equals(RANDOM)) {
      set(random(-r1,r1),random(-r2,r2),random(-r3,r3));
    } else if(key_random.equals(RANDOM_ZERO)) {
      set(random(0,r1),random(0,r2),random(0,r3));
    } else {
      this.x = this.y = this.z  = this.r = this.g = this.b =this.s = this.t = this.p = 0 ;
      println("the key word for the random is not available use the String 'RANDOM' or 'RANDOM ZERO' ") ;
    }
  }

  Vec3(String key_random, int a1, int a2, int b1, int b2, int c1, int c2) {
    super(3) ;
    if(key_random.equals(RANDOM_RANGE)) {
      set(random(a1,a2),random(b1,b2),random(c1,c2));
    } else {
      this.x = this.y = this.z  = this.r = this.g = this.b =this.s = this.t = this.p = 0 ;
      println("the key word for the random is not available use the String 'RANDOM RANGE' ") ;
    }
  }



  /**
  Set
  */
  /**
  * Sets components of the vector using two or three separate
  * variables, the data from a Vec, or the values from a float array.
  */
   
   public Vec3 set(float v) {
    set(v,v,v);
    return this ;
  }

  /**
  * @param v any variable of type Vec
  */
  public Vec3 set(Vec v) {
    if(v == null) {
      set(0,0,0);
      return this ;
    } else if(v instanceof Vec5 || v instanceof Vec6) {
      set(v.a,v.b,v.c);
      return this ;
    } else {
      set(v.x,v.y,v.z);
      return this ;
    }
  }

  public Vec3 set(iVec v) {
    if(v == null) {
      set(0,0,0);
      return this ;
    } else if(v instanceof iVec5 || v instanceof iVec6) {
      set(v.a,v.b,v.c);
      return this ;
    } else {
      set(v.x,v.y,v.z);
      return this ;
    }
  }


  // xyz
  public Vec3 set_x(float x) {
    return set(x,this.y,this.z);
  }

  public Vec3 set_y(float y) {
    return set(this.x,y,this.z);
  }

  public Vec3 set_z(float z) {
    return set(this.x,this.y,z);
  }

  // rgb
  public Vec3 set_r(float x) {
    return set(x,this.y,this.z);
  }

  public Vec3 set_g(float y) {
    return set(this.x,y,this.z);
  }

  public Vec3 set_b(float z) {
    return set(this.x,this.y,z);
  }

  // stp
  public Vec3 set_s(float x) {
    return set(x,this.y,this.z);
  }

  public Vec3 set_t(float y) {
    return set(this.x,y,this.z);
  }

  public Vec3 set_p(float z) {
    return set(this.x,this.y,z);
  }


  /**
  * set method master
  * here we cannot set the arg a,b, c,d,e,f cause r,g,b,a
  */
  public Vec3 set(float x, float y, float z) {
    this.x = this.r = this.s = x ;
    this.y = this.g = this.t = y ;
    this.z = this.b = this.p = z ;
    return this ;
  }


  /**
  * Set the x, y (and maybe z) coordinates using a float[] array as the source.
  * @param source array to copy from
  */
  public Vec3 set(float[] source) {
    set(source[0],source[1],source[2]);
    return this ;
  }
  
  
  
  
  
  
  
  
  
  
  
  /**
  METHOD
  */
  /**
  sum
  */
  /**
  * sum return the sum of all components
  * @return float
  */
  float sum() {
    return x+y+z;
  } 
  /**
  Mult
  v 0.0.2
  */
  /** 
  * multiply Vector by a different float value 
  */
  Vec3 mult(float m_x, float m_y, float m_z) {
    x *= m_x;
    y *= m_y; 
    z *= m_z; 
    set(x,y,z);
    return this;
  }

  Vec3 mult(float m) {
    return mult(m,m,m);
  }
  
  // mult by vector
  Vec3 mult(Vec v) {
    if(v != null) {
      return mult(v.x,v.y,v.z);
    } else return null;   
  }
  Vec3 mult(iVec v) {
    if(v != null) {
      return mult(v.x,v.y,v.z);
    } else return null;   
  }
  
  
  
  /**
  Division
  v 0.0.3
  */
  /**
  * divide Vector by a float value 
  */
  Vec3 div(float d_x, float d_y, float d_z) {
    if(d_x != 0) x /= d_x; 
    if(d_y != 0) y /= d_y; 
    if(d_z != 0) z /= d_z; 
    set(x,y,z);
    return this;
  }

  Vec3 div(float d) {
    return div(d,d,d);
  }
  
  Vec3 div(Vec v) {
    if(v != null) {
      return div(v.x,v.y,v.z);
    } else return null;   
  }
  Vec3 div(iVec v) {
    if(v != null) {
      return div(v.x,v.y,v.z);
    } else return null;   
  }
  
  
  
  /**
  Addition
  */
  /** 
  * add float value 
  */

  Vec3 add(float a_x,float a_y,float a_z) {
    x += a_x;
    y += a_y;
    z += a_z;
    set(x,y,z);
    return this;
  }
  Vec3 add(float a) {
    return add(a,a,a);
  }

  Vec3 add(Vec v) {
    if(v != null) {
      return add(v.x,v.y,v.z);
    } return null;
  }

  Vec3 add(iVec v) {
    if(v != null) {
      return add(v.x,v.y,v.z);
    } return null;
  }
  
  /**
  * add two Vector together 
  * @deprecated is not necessary to use this method in the inner class, instead use the external one
  */
  @Deprecated
  Vec3 add(Vec v_a, Vec v_b) {
    if(v_a != null &&  v_b != null) {
      x = v_a.x +v_b.x;
      y = v_a.y +v_b.y;
      z = v_a.z +v_b.z;
    }
    set(x,y,z);
    return this;
  }



  /**
  Substraction
  */
  /** 
  * add float value 
  */
  Vec3 sub(float s_x,float s_y,float s_z) {
    x -= s_x;
    y -= s_y;
    z -= s_z;
    set(x,y,z);
    return this;
  }

  Vec3 sub(float s) {
    return sub(s,s,s);
  }

  Vec3 sub(Vec v) {
    if(v != null) {
      sub(v.x,v.y,v.z);
    } return null;
  }

  Vec3 sub(iVec v) {
    if(v != null) {
      sub(v.x,v.y,v.z);
    } return null;
  }
  
  /**
  * sub two Vector together 
  * @deprecated is not necessary to use this method in the inner class, instead use the external one
  */
  @Deprecated
  Vec3 sub(Vec v_a, Vec v_b) {
    if(v_a != null &&  v_b != null) {
      x = v_a.x -v_b.x;
      y = v_a.y -v_b.y;
      z = v_a.z -v_b.z;
    }
    set(x,y,z);
    return this;
  }


  /**
  Average
  */
  float average() {
    return (this.x + this.y +this.z) *.333f;
  }


  /**
  Dot
  */
  public float dot(Vec3 v) {
    if(v != null) {
      return x*v.x + y*v.y + z*v.z;
    } else {
      println("Your Vec arg is", null) ;
      return 0 ;
    }
    
  }
  public float dot(float x, float y, float z) {
    return this.x*x + this.y*y + this.z*z;
  }

  /**
  Cross
  v 0.0.2
  */
  Vec3 cross(Vec3 v) {
    if(v != null) {
      return cross(v, null);
    } else return null ;
    
  }
  Vec3 cross(float x, float y, float z) {
    Vec3 v = Vec3(x,y,z) ;
    return cross(v, null);
  }
  

  /**
  this one is very odd, why taeget is necessary ????
  */
  Vec3 cross(Vec3 v, Vec3 target) {
    if(v != null && target != null) {
      float crossX = y*v.z - v.y*z;
      float crossY = z*v.x - v.z*x;
      float crossZ = x*v.y - v.x*y;
      if (target == null) {
        target = Vec3(crossX, crossY, crossZ);
      } else {
        target.set(crossX, crossY, crossZ);
      }
      return target;
    } else return null ;

  }
  

  /**
  Direction cartesian
  */
  Vec3 dir() {
    return dir(Vec3(0)) ;
  }
  Vec3 dir(float a_x, float a_y, float a_z) {
    return dir(Vec3(a_x,a_y,a_z)) ;
  }
  Vec3 dir(Vec3 origin) {
    if(origin != null) {
      float dist = dist(origin) ;
      sub(origin) ;
      div(dist) ;
    }
    set(x,y,z) ;
    return this ;
  }
  
  

  /**
  Tangent
  */
  /**
  * to find the tangent you need to associate an other vector of your dir vector to create a reference plane.
  */
  Vec3 tan(float float_to_make_plane_ref_x, float float_to_make_plane_ref_y, float float_to_make_plane_ref_z) {
    return tan(Vec3(float_to_make_plane_ref_x, float_to_make_plane_ref_y, float_to_make_plane_ref_z)) ;
  }

  Vec3 tan(Vec3 vector_to_make_plane_ref) {
    if(vector_to_make_plane_ref != null) {
      Vec3 tangent = cross(vector_to_make_plane_ref) ;
      return tangent ;
    } else return null ;
  }
  

  /**
  Map
  */
  /**
  * find the min and the max value in the vector list
  * @return float
  */
  float max_vec() {
    float [] list = { x, y, z } ;
    return max(list) ;
  }
  float min_vec() {
    float [] list = { x, y, z } ;
    return min(list) ;
  }





  /**
  Normalize
  */
  public Vec3 normalize(Vec3 target) {
    if (target == null) {
      target = Vec3();
    }
    float m = mag();
    if (m > 0) {
      target.set(x/m, y/m, z/m);
    } else {
      target.set(x, y, z);
    }
    return target;
  }

  public Vec3 normalize() {
    float m = mag();
    if (m != 0 && m != 1) {
      div(m);
    }
    return this ;
  }

  /**
  Map
  */
  /**
  * Mapped Vector
  * @return Vec3
  */
  public Vec3 map_vec(float minIn, float maxIn, float minOut, float maxOut) {
    x = map(x,minIn,maxIn,minOut,maxOut) ;
    y = map(y,minIn,maxIn,minOut,maxOut) ;
    z = map(z,minIn,maxIn,minOut,maxOut) ;

    set(x,y,z) ;
    return this ;
  }

  public Vec3 map_vec(Vec3 minIn, Vec3 maxIn, Vec3 minOut, Vec3 maxOut) {
    x = map(x,minIn.x,maxIn.x,minOut.x,maxOut.x);
    y = map(y,minIn.y,maxIn.y,minOut.y,maxOut.y);   
    z = map(z,minIn.z,maxIn.z,minOut.z,maxOut.z);   
    set(x,y,z) ;
    return this ;
  }
  
  
  
  /**
  Mag and MagSQ
  */
  /**
  * Magnitude or length of Vec3
  * @return float
  */
  /////////////////////
  public float magSq() {
    return (x*x + y*y + z*z) ;
  }


  public float mag() {
    return (float) Math.sqrt(x*x + y*y + z*z) ;
  }


  float mag(Vec3 v_target) {
    if(v_target != null) {
      float new_x = (v_target.x -x) *(v_target.x -x) ;
      float new_y = (v_target.y -y) *(v_target.y -y) ;
      float new_z = (v_target.z -z) *(v_target.z -z) ;
      return sqrt(new_x +new_y +new_z) ;
    } else {
      println("Your Vec arg is", null) ;
      return 0 ;
    }
  }
  /**
  limit
  */
  public Vec3 limit(float max) {
    if (magSq() > max*max) {
      normalize();
      mult(max);
    }
    return this;
  }
  
  /**
  Distance
  */
  /**
  * @return float
  * distance himself and an other vector
  */
  float dist(Vec v_target) {
    if(v_target != null) {
      float dx = x - v_target.x;
      float dy = y - v_target.y;
      float dz = z - v_target.z;
      return (float) Math.sqrt(dx*dx + dy*dy + dz*dz);
    } else {
      println("Your Vec arg is", null) ;
      return 0 ;
    }
  }
  
  /**
  Jitter
  v 0.0.2
  */
  /** 
  * create jitter effect around the vector position, with global range
  */
  public Vec3 jitter(int range) {
    return jitter(range,range,range) ;
  }
  public Vec3 jitter(Vec3 range) {
    if(range != null) {
      return jitter((int)range.x,(int)range.y,(int)range.z) ;
    } else return jitter(0, 0, 0) ;
    
  }
  /** 
  * with specific range 
  */
  public Vec3 jitter(int range_x,int range_y, int range_z) {
    x += random_next_gaussian(range_x,3);
    y += random_next_gaussian(range_y,3);
    z += random_next_gaussian(range_z,3);
    set(x,y,z);
    return this;
  }
  
  
  /**
  Revolution
  */
  /** 
  * create a circular motion effect 
  */
  Vec3 revolutionX(int rx, int ry, float speed) {
    return revolutionX(Vec2(rx,ry), speed) ;
  }
  Vec3 revolutionX(int r, float speed) {
    return revolutionX(Vec2(r,r), speed) ;
  }
  Vec3 revolutionX(Vec2 radius, float speed) {
    if(radius != null) {
      float new_speed = speed *.01 ; 

      float m_x = sin(frameCount *new_speed) ;
      float m_y = cos(frameCount *new_speed) ;
      m_x *=radius.x ;
      m_y *=radius.y ;
      return new Vec3(x +m_x, y +m_y, z) ;
    } else return null ;

  }

  Vec3 revolutionY(int rx, int ry, float speed) {
    return revolutionY(Vec2(rx,ry), speed) ;
  }
  Vec3 revolutionY(int r, float speed) {
    return revolutionY(Vec2(r,r), speed) ;
  }
  Vec3 revolutionY(Vec2 radius, float speed) {
    if(radius != null) {
      float new_speed = speed *.01 ; 

      float m_x = sin(frameCount *new_speed) ;
      float m_z = cos(frameCount *new_speed) ;
      m_x *=radius.x ;
      m_z *=radius.y ;
      return new Vec3(x +m_x, y, z +m_z) ;
    } else return null ;
  }

  Vec3 revolutionZ(int rx, int ry, float speed) {
    return revolutionZ(Vec2(rx,ry), speed) ;
  }

  Vec3 revolutionZ(int r, float speed) {
    return revolutionZ(Vec2(r,r), speed) ;
  }
  Vec3 revolutionZ(Vec2 radius, float speed) {
    if(radius != null) {
      float new_speed = speed *.01 ; 

      float m_y = sin(frameCount *new_speed) ;
      float m_z = cos(frameCount *new_speed) ;
      m_y *=radius.x ;
      m_z *=radius.y ;
      return new Vec3(x, y +m_y, z +m_z) ;
    } else return null ;
  }


  /**
  Equals
  */
  boolean equals(Vec3 target) {
    if(target != null) {
      if((x == target.x) && (y == target.y) && (z == target.z)) {
        return true ; 
      } else return false ;
    } else return false ;
  }
  
  boolean equals(float target) {
    if((x == target) && (y == target) && (z == target)) 
    return true ; 
    else return false ;
  }
  
  boolean equals(float t_x,float t_y,float t_z) {
    if((x == t_x) && (y == t_y) && (z == t_z)) 
    return true ; 
    else return false ;
  }
  
  
  /**
  Compare deprecated
  */
  boolean compare(Vec3 target) {
    if(target != null) {
      if((x == target.x) && (y == target.y) && (z == target.z)) {
        return true ; 
      } else return false ;
    } else return false ;
  }
  
  boolean compare(float target) {
    if((x == target) && (y == target) && (z == target)) 
    return true ; 
    else return false ;
  }
  
  boolean compare(float t_x,float t_y,float t_z) {
    if((x == t_x) && (y == t_y) && (z == t_z)) 
    return true ; 
    else return false ;
  }
   
  /**
  Copy
  */
  /**
  * return all the component of Vec
  * @return Vec3
  */
  Vec3 copy() {
    return new Vec3(x,y,z) ;
  }
  /**
  * return all the component of Vec in type PVector
  * @return PVector
  */
  PVector copy_PVector() {
    return new PVector(x,y,z) ;
  }


  /**
  Print info
  */
  @Override String toString() {
    return "[ " + x + ", " + y + ", " + z + " ]";
  }
}








/**
VEC 4
v 1.0.0
*/
class Vec4 extends Vec {
  /**
  Constructor
  */
  
  Vec4(float x, float y, float z, float w) {
    super(4) ;
    set(x,y,z,w);
  }



  /**
  Random constructor
  */ 
  /**
  * random generator for the Vec
  */
  Vec4(String key_random, int r1) {
    super(4) ;
    if(key_random.equals(RANDOM)) {
      set(random(-r1,r1),random(-r1,r1),random(-r1,r1),random(-r1,r1));
    } else if(key_random.equals(RANDOM_ZERO)) {
      set(random(0,r1),random(0,r1),random(0,r1),random(0,r1));
    } else {
      this.x = this.y = this.z = this.w = this.r = this.g = this.b = this.a =this.s = this.t = this.p = this.q = 0 ;
      println("the key word for the random is not available use the String 'RANDOM' or 'RANDOM ZERO' ") ;
    }
  }
  
  Vec4(String key_random, int r1, int r2, int r3, int r4) {
    super(4) ;
    if(key_random.equals(RANDOM)) {
      set(random(-r1,r1),random(-r2,r2),random(-r3,r3),random(-r4,r4));
    } else if(key_random.equals(RANDOM_ZERO)) {
      set(random(0,r1),random(0,r2),random(0,r3),random(0,r4));
    } else {
      this.x = this.y = this.z = this.w = this.r = this.g = this.b = this.a =this.s = this.t = this.p = this.q = 0 ;
      println("the key word for the random is not available use the String 'RANDOM' or 'RANDOM ZERO' ") ;
    }
  }

  Vec4(String key_random, int a1, int a2, int b1, int b2, int c1, int c2, int d1, int d2) {
    super(4) ;
    if(key_random.equals(RANDOM_RANGE)) {
      set(random(a1,a2),random(b1,b2),random(c1,c2),random(d1,d2));
    } else {
      this.x = this.y = this.z  = this.r = this.g = this.b =this.s = this.t = this.p = 0 ;
      println("the key word for the random is not available use the String 'RANDOM RANGE' ") ;
    }
  }
  
  /**
  Set
  */
  /**
  * Sets components of the vector using two or three separate
  * variables, the data from a Vec, or the values from a float array.
  */
  public Vec4 set(float v) {
    set(v,v,v,v);
    return this ;
  }
  
  /**
   * @param v any variable of type Vec
   */
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


  /**
  * Set the x, y (and maybe z) coordinates using a float[] array as the source.
  * @param source array to copy from
  */
  public Vec4 set(float[] source) {
    set(source[0],source[1],source[2],source[3]);
    return this ;
  }

  // xyzw
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
  * set method master
  * here we cannot set the arg a,b, c,d,e,f cause r,g,b,a
  */
  public Vec4 set(float x, float y, float z, float w) {
    this.x = this.r = this.s = x ;
    this.y = this.g = this.t = y ;
    this.z = this.b = this.p = z ;
    this.w = this.a = this.q = w ;
    return this ;
  }



  /** 
  METHOD
  */
      /**
  sum
  */
  /**
  * sum return the sum of all components
  * @return float
  */
  float sum() {
    return x+y+z+w;
  } 
  /**
  Multiplication
  v 0.0.2
  */
    Vec4 mult(float m_x, float m_y, float m_z, float m_w) {
    x *= m_x ; 
    y *= m_y ; 
    z *= m_z ; 
    w *= m_w ;
    set(x,y,z,w) ;
    return this ;
  }

  Vec4 mult(float m) {
    return mult(m,m,m,m);
  }

  Vec4 mult(Vec v) {
    if(v != null) {
      return mult(v.x,v.y,v.z,v.w);
    } else return null ;
  }

  Vec4 mult(iVec v) {
    if(v != null) {
      return mult(v.x,v.y,v.z,v.w);
    } else return null ;
  }
   
  /**
  Division
  v 0.0.3
  */
  /** 
  * @return Vec
  * divide Vector by a float value 
  */
  Vec4 div(float d_x, float d_y, float d_z, float d_w) {
    if(d_x != 0) x /= d_x; 
    if(d_y != 0) y /= d_y; 
    if(d_z != 0) z /= d_z; 
    if(d_w != 0) w /= d_w;
    set(x,y,z,w);
    return this;
  }
  Vec4 div(float d) {
    return div(d,d,d,d);
  }
  
  Vec4 div(Vec v) {
    if(v != null) {
      return div(v.x,v.y,v.z,v.w);
    } else return null;
  }

  Vec4 div(iVec v) {
    if(v != null) {
      return div(v.x,v.y,v.z,v.w);
    } else return null;
  }
  
  
  /**
  Addition
  v 0.0.2
  */
  /**
  * add float value 
  */
  Vec4 add(float a_x,float a_y,float a_z,float a_w) {
    x += a_x;
    y += a_y;
    z += a_z;
    w += a_w;
    set(x,y,z,w);
    return this;
  }

  Vec4 add(float a) {
    return add(a,a,a,a);
  }

  Vec4 add(Vec v) {
    if(v != null) {
      return add(v.x,v.y,v.z,v.w);
    } else return null;
  }

  Vec4 add(iVec v) {
    if(v != null) {
      return add(v.x,v.y,v.z,v.w);
    } else return null;
  }

  /**
  * add two Vector together 
  * @deprecated is not necessary to use this method in the inner class, instead use the external one
  */
  @Deprecated
  Vec4 add(Vec v_a, Vec v_b) {
    if(v_a != null && v_b != null) {
      x = v_a.x + v_b.x;
      y = v_a.y + v_b.y;
      z = v_a.z + v_b.z;
      w = v_a.w + v_b.w;
    }
    set(x,y,z,w);
    return this;
  }

  /**
  Substraction
  */
  /** 
  * sub float value
  * @return Vec4 
  */
  Vec4 sub(float a_x,float a_y,float a_z, float a_w) {
    x -= a_x;
    y -= a_y;
    z -= a_z;
    w -= a_w; 
    set(x,y,z,w);
    return this;
  }

  Vec4 sub(float a) {
    return sub(a,a,a,a);
  }

  Vec4 sub(Vec v) {
    if(v != null) {
      return sub(v.x,v.y,v.z,v.w);
    } else return null;
  }

  Vec4 sub(iVec v) {
    if(v != null) {
      return sub(v.x,v.y,v.z,v.w);
    } else return null;
  }
  
  /**
  * sub two Vector together 
  * @deprecated is not necessary to use this method in the inner class, instead use the external one
  */
  @Deprecated
  Vec4 sub(Vec v_a, Vec v_b) {
    if(v_a != null &&  v_b != null) {
      x = v_a.x -v_b.x;
      y = v_a.y -v_b.y;
      z = v_a.z -v_b.z;
      w = v_a.w -v_b.w;
    }
    set(x,y,z,w);
    return this;
  }


  /**
  Average
  */
  float average() {
    return (this.x + this.y +this.z +this.w) *.25;
  }

  /**
  Dot
  */
  public float dot(Vec4 v) {
    if(v != null) {
      return x*v.x + y*v.y + z*v.z + w*this.w;
    } else {
      println("Your Vec arg is", null) ;
      return 0 ;
    }
    
  }
  public float dot(float x, float y, float z, float w) {
    return this.x*x + this.y*y + this.z*z + this.w*w;
  }



  /**
  Direction cartesian
  */
  Vec4 dir() {
    return dir(Vec4(0)) ;
  }
  Vec4 dir(float a_x, float a_y, float a_z, float a_w) {
    return dir(Vec4(a_x,a_y,a_z,a_w));
  }
  Vec4 dir(Vec4 origin) {
    if(origin != null) {
      float dist = dist(origin);
      sub(origin);
      div(dist);
    }
    set(x,y,z,w);
    return this;
  }
  
  /**
  Min Max
  */
  /**
  * find the min and the max value in the vector list
  * @return float
  */
  float max_vec() {
    float [] list = {x,y,z,w};
    return max(list);
  }
  float min_vec() {
    float [] list = {x,y,z,w};
    return min(list);
  }





  /**
  Normalize
  */
  public Vec4 normalize(Vec4 target) {
    if (target == null) {
      target = Vec4();
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
  Map
  */
  /**
  * mapping
  * return mapping vector
  * @return Vec4
  */
  public Vec4 map_vec(float minIn, float maxIn, float minOut, float maxOut) {
    x = map(x,minIn,maxIn,minOut,maxOut);
    y = map(y,minIn,maxIn,minOut,maxOut);
    z = map(z,minIn,maxIn,minOut,maxOut);
    w = map(w,minIn,maxIn,minOut,maxOut);
    set(x,y,z,w);
    return this;
  }

  public Vec4 map_vec(Vec4 minIn, Vec4 maxIn, Vec4 minOut, Vec4 maxOut) {
    x = map(x,minIn.x,maxIn.x,minOut.x,maxOut.x);
    y = map(y,minIn.y,maxIn.y,minOut.y,maxOut.y);   
    z = map(z,minIn.z,maxIn.z,minOut.z,maxOut.z);   
    w = map(w,minIn.w,maxIn.w,minOut.w,maxOut.w);
    set(x,y,z,w);
    return this;
  }

  /**
  Magnitude or length
  */
  public float magSq() {
    return (x*x + y*y + z*z +w*w) ;
  }


  public float mag() {
    return (float) Math.sqrt(x*x + y*y + z*z + w*w);
  }

  float mag(Vec4 v_target) {
    if(v_target != null) {
      float new_x = (v_target.x -x) *(v_target.x -x);
      float new_y = (v_target.y -y) *(v_target.y -y);
      float new_z = (v_target.z -z) *(v_target.z -z);
      float new_w = (v_target.w -w) *(v_target.w -w);
      return sqrt(new_x +new_y +new_z +new_w);
    } else {
      println("Your Vec arg is", null);
      return 0 ;
    }
  }

  /**
  limit
  */
  public Vec4 limit(float max) {
    if (magSq() > max*max) {
      normalize();
      mult(max);
    }
    return this;
  }
  
  /**
  Distance
  */
  /**
  * distance himself and an other vector
  */
  float dist(Vec4 v_target) {
    if(v_target != null) {
      float dx = x - v_target.x;
      float dy = y - v_target.y;
      float dz = z - v_target.z;
      float dw = w - v_target.w;
      return (float) Math.sqrt(dx*dx + dy*dy + dz*dz + dw*dw);
    } else {
      println("Your Vec arg is", null) ;
      return 0 ;
    }
  }
  
  
  /**
  Jitter
  */
  /**
  * create jitter effect around the vector position, with global range 
  */
  public Vec4 jitter(int range) {
    return jitter(range,range,range,range) ;
  }
  public Vec4 jitter(Vec4 range) {
    if(range != null) {
      return jitter((int)range.x,(int)range.y,(int)range.z,(int)range.w) ;
    } else return jitter(0) ;
  }
  /**
  * with specific range 
  */
  public Vec4 jitter(int range_x,int range_y, int range_z, int range_w) {
    x += random_next_gaussian(range_x,3);
    y += random_next_gaussian(range_y,3);
    z += random_next_gaussian(range_z,3);
    w += random_next_gaussian(range_w,3);
    set(x,y,z,w);
    return this;
  }


  /**
  Equals
  */
  boolean equals(Vec4 target) {
    if(target != null ) {
      if((x == target.x) && (y == target.y) && (z == target.z) && (w == target.w)) {
        return true; 
      } else return false;
    } else return false;
  }
  boolean equals(float target) {
    if((x == target) && (y == target) && (z == target) && (w == target)) 
    return true; 
    else return false;
  }
  
  boolean equals(float t_x,float t_y,float t_z,float t_w) {
    if((x == t_x) && (y == t_y) && (z == t_z)&& (w == t_w)) 
    return true; 
    else return false;
  }


  
   
  /**
  Compare deprecated
  */
  boolean compare(Vec4 target) {
    if(target != null ) {
      if((x == target.x) && (y == target.y) && (z == target.z) && (w == target.w)) {
        return true ; 
      } else return false ;
    } else return false ;
  }
  boolean compare(float target) {
    if((x == target) && (y == target) && (z == target) && (w == target)) 
    return true; 
    else return false;
  }
  
  boolean compare(float t_x,float t_y,float t_z,float t_w) {
    if((x == t_x) && (y == t_y) && (z == t_z)&& (w == t_w)) 
    return true ; 
    else return false ;
  }
  
  /**
  Copy
  */
  Vec4 copy() {
    return new Vec4(x,y,z,w);
  }

  /**
  Print info
  */
  @Override String toString() {
    return "[ " + x + ", " + y + ", " + z + ", " + w + " ]";
  }
}








/**
CLASS Vec5
*/
class Vec5 extends Vec{

  /**
  Constructor
  */
  Vec5(float a, float b, float c, float d, float e) {
    super(5) ;
    set(a,b,c,d,e);
  }

  /**
  Random Constructor
  */
  /**
  * random generator for the Vec
  */
  Vec5(String key_random, int r1) {
    super(5) ;
    if(key_random.equals(RANDOM)) {
      set(random(-r1,r1),random(-r1,r1),random(-r1,r1),random(-r1,r1),random(-r1,r1));
    } else if(key_random.equals(RANDOM_ZERO)) {
      set(random(0,r1),random(0,r1),random(0,r1),random(0,r1),random(0,r1));
    } else {
      this.a = this.b = this.c = this.d = this.e = 0 ;
      println("the key word for the random is not available use the String 'RANDOM' or 'RANDOM ZERO' ") ;
    }
  }
  
  Vec5(String key_random, int r1, int r2, int r3, int r4, int r5) {
    super(5) ;
    if(key_random.equals(RANDOM)) {
      set(random(-r1,r1),random(-r2,r2),random(-r3,r3),random(-r4,r4),random(-r5,r5));
    } else if(key_random.equals(RANDOM_ZERO)) {
      set(random(0,r1),random(0,r2),random(0,r3),random(0,r4),random(0,r5));
    } else {
      this.a = this.b = this.c = this.d = this.e = 0 ;
      println("the key word for the random is not available use the String 'RANDOM' or 'RANDOM ZERO' ");
    }
  }

  Vec5(String key_random, int a1, int a2, int b1, int b2, int c1, int c2, int d1, int d2, int e1, int e2) {
    super(5) ;
    if(key_random.equals(RANDOM_RANGE)) {
      set(random(a1,a2),random(b1,b2),random(c1,c2),random(d1,d2),random(e1,e2));
    } else {
      this.a = this.b = this.c = this.d = this.e = 0;
      println("the key word for the random is not available use the String 'RANDOM RANGE' ");
    }
  }


  /**
  Set
  */
  /**
  * Set components of the vector using two or three separate
  * variables, the data from a Vec, or the values from a float array.
  */
  public Vec5 set(float v) {
    set(v,v,v,v,v);
    return this;
  }

  /**
  * @param v any variable of type Vec
  */
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

  /**
   * Set the x, y (and maybe z) coordinates using a float[] array as the source.
   * @param source array to copy from
   */
  public Vec5 set(float[] source) {
    set(source[0],source[1],source[2],source[3],source[4]);
    return this ;
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
  * master method set
  */
  public Vec5 set(float a, float b, float c, float d, float e) {
    this.a = a;
    this.b = b;
    this.c = c;
    this.d = d;
    this.e = e;
    return this ;
  }

  /**
  Min Max
  */
  /**
  * Find the min and the max value in the vector list
  * @return float
  */
  float max_vec() {
    float [] list = {a,b,c,d,e} ;
    return max(list) ;
  }
  float min_vec() {
    float [] list = {a,b,c,d,e} ;
    return min(list) ;
  }
  
  /**
  Copy
  */
  Vec5 copy() {
    return new Vec5(a,b,c,d,e) ;
  }


  
  /**
  Print info
  */
  @Override String toString() {
    return "[ " + a + ", " + b + ", " + c + ", " + d + ", " + e + " ]";
  }
}








/**
CLASS Vec6
v 0.0.2
*/
class Vec6 extends Vec {

  /**
  Constructor
  */
  Vec6(float a, float b, float c, float d, float e, float f) {
    super(6) ;
    set(a,b,c,d,e,f);
  }

  
  /**
  Random Constructor
  */
  Vec6(String key_random, int r1) {
    super(6) ;
    if(key_random.equals(RANDOM)) {
      set(random(-r1,r1),random(-r1,r1),random(-r1,r1),random(-r1,r1),random(-r1,r1),random(-r1,r1));
    } else if(key_random.equals(RANDOM_ZERO)) {
      set(random(0,r1),random(0,r1),random(0,r1),random(0,r1),random(0,r1),random(0,r1));
    } else {
      this.a = this.b = this.c = this.d = this.e = this.f = 0 ;
      println("the key word for the random is not available use the String 'RANDOM' or 'RANDOM ZERO' ") ;
    }
  }
  
  Vec6(String key_random, int r1, int r2, int r3, int r4, int r5, int r6) {
    super(6) ;
    if(key_random.equals(RANDOM)) {
      set(random(-r1,r1),random(-r2,r2),random(-r3,r3),random(-r4,r4),random(-r5,r5),random(-r6,r6));
    } else if(key_random.equals(RANDOM_ZERO)) {
      set(random(0,r1),random(0,r2),random(0,r3),random(0,r4),random(0,r5),random(0,r6));
    } else {
      this.a = this.b = this.c = this.d = this.e = this.f = 0 ;
      println("the key word for the random is not available use the String 'RANDOM' or 'RANDOM ZERO' ") ;
    }
  }

  Vec6(String key_random, int a1, int a2, int b1, int b2, int c1, int c2, int d1, int d2, int e1, int e2, int f1, int f2) {
    super(6) ;
    if(key_random.equals(RANDOM_RANGE)) {
      set(random(a1,a2),random(b1,b2),random(c1,c2),random(d1,d2),random(e1,e2),random(f1,f2));
    } else {
      this.a = this.b = this.c = this.d = this.e = this.f = 0 ;
      println("the key word for the random is not available use the String 'RANDOM RANGE' ") ;
    }
  }

  /**
  Set
  */
  /**
  * Sets components of the vector using two or three separate
  * variables, the data from a Vec, or the values from a float array.
  */
  public Vec6 set(float v) {
    set(v,v,v,v,v,v);
    return this;
  }

  /**
  * @param v any variable of type Vec
  */
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

  /**
  * Set the x, y (and maybe z) coordinates using a float[] array as the source.
  * @param source array to copy from
  */
  public Vec6 set(float[] source) {
    set(source[0],source[1],source[2],source[3],source[4],source[5]);
    return this ;
  }


    // abcdef
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
  * set main
  */
  public Vec6 set(float a, float b, float c, float d, float e, float f) {
    this.a = a ;
    this.b = b ;
    this.c = c ;
    this.d = d ;
    this.e = e ;
    this.f = f ;
    return this;
  }


  /**
  Min Max
  */
  /**
  * Find the min and the max value in the vector list
  * @return float
  */
  float max_vec() {
    float [] list = {a,b,c,d,e,f} ;
    return max(list) ;
  }
  float min_vec() {
    float [] list = {a,b,c,d,e,f} ;
    return min(list) ;
  }

  /**
  Copy
  */
  Vec6 copy() {
    return new Vec6(a,b,c,d,e,f) ;
  }

  /**
  Print info
  */
  @Override String toString() {
    return "[ " + a + ", " + b + ", " + c + ", " + d + ", " + e + ", " + f + " ]" ;
  }
}








