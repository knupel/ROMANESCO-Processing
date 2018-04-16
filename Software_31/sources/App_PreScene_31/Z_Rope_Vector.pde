/**
ROPE VECTOR
v 2.6.8
* Copyleft (c) 2014-2018 
* Stan le Punk > http://stanlepunk.xyz/
Rope – Romanesco Processing Environment: 2015–2017
* @author Stan le Punk
* @see https://github.com/StanLepunK/Rope
*/
/**
inspireted by GLSL code and PVector from Daniel Shiffman
ROPE is not add before Vec, because is too long, and little too much to have something like
that RopeVec(), ROVec(), RPEVec() or RVec(), plus there is no confusion with PVector, so stay simple !
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
// END VEC 3
////////////







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
// END VEC 4
////////////


/**
CLASS Vec5
v 0.0.2
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

// END VEC 5
////////////







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

/**
END VEC 6
*/

/**


END CLASS Vec and iVec


*/






















































/**

METHOD
Vec and iVec
v 0.5.0

*/
/**
Addition
v 0.0.4
*/
/**
* return the resultat of vector addition
*/
Vec2 add(Vec2 a, Vec2 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    float x = a.x + b.x ;
    float y = a.y + b.y ;
    return new Vec2(x,y) ;
  }
}

Vec3 add(Vec3 a, Vec3 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    float x = a.x + b.x ;
    float y = a.y + b.y ;
    float z = a.z + b.z ;
    return new Vec3(x,y,z)  ;
  }
}

Vec4 add(Vec4 a, Vec4 b) {  
  if(a == null || b == null) {
    return null ;
  } else {
    float x = a.x + b.x ;
    float y = a.y + b.y ;
    float z = a.z + b.z ;
    float w = a.w + b.w ;
    return new Vec4(x,y,z,w)  ;
  }
}
/**
* iVec arg
*/
Vec2 add(iVec2 a, iVec2 b) {
  return add(Vec2(a),Vec2(b));
}

Vec3 add(iVec3 a, iVec3 b) {
  return add(Vec3(a),Vec3(b));
}

Vec4 add(iVec4 a, iVec4 b) {  
  return add(Vec4(a),Vec4(b));
}
/**
* float arg
*/
Vec2 add(Vec2 a, float arg) {
  return add(a,Vec2(arg,arg));
}

Vec3 add(Vec3 a, float arg) {
  return add(a,Vec3(arg,arg,arg));
}

Vec4 add(Vec4 a, float arg) {  
  return add(a,Vec4(arg,arg,arg,arg));
}
/**
* iVec + float
*/
Vec2 add(iVec2 a, float arg) {
  return add(Vec2(a),Vec2(arg,arg));
}

Vec3 add(iVec3 a, float arg) {
  return add(Vec3(a),Vec3(arg,arg,arg));
}

Vec4 add(iVec4 a, float arg) {  
  return add(Vec4(a),Vec4(arg,arg,arg,arg));
}



/**
Multiplication
v 0.0.3
*/
/**
* return the resultat of vector multiplication
*/
Vec2 mult(Vec2 a, Vec2 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    float x = a.x * b.x;
    float y = a.y * b.y;
    return new Vec2(x,y);
  }
}

Vec3 mult(Vec3 a, Vec3 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    float x = a.x * b.x;
    float y = a.y * b.y;
    float z = a.z * b.z;
    return new Vec3(x,y,z);
  }
}

Vec4 mult(Vec4 a, Vec4 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    float x = a.x * b.x;
    float y = a.y * b.y;
    float z = a.z * b.z;
    float w = a.w * b.w;
    return new Vec4(x,y,z,w);
  }
}
/**
* iVec arg
*/
Vec2 mult(iVec2 a, iVec2 b) {
  return mult(Vec2(a),Vec2(b));
}

Vec3 mult(iVec3 a, iVec3 b) {
  return mult(Vec3(a),Vec3(b));
}

Vec4 mult(iVec4 a, iVec4 b) {  
  return mult(Vec4(a),Vec4(b));
}
/**
* float arg
*/
Vec2 mult(Vec2 a, float arg) {
  return mult(a,Vec2(arg,arg));
}

Vec3 mult(Vec3 a, float arg) {
  return mult(a,Vec3(arg,arg,arg));
}

Vec4 mult(Vec4 a, float arg) {  
  return mult(a,Vec4(arg,arg,arg,arg));
}
/**
* iVec + float
*/
Vec2 mult(iVec2 a, float arg) {
  return mult(Vec2(a),Vec2(arg,arg));
}

Vec3 mult(iVec3 a, float arg) {
  return mult(Vec3(a),Vec3(arg,arg,arg));
}

Vec4 mult(iVec4 a, float arg) {  
  return mult(Vec4(a),Vec4(arg,arg,arg,arg));
}




/**
Division
v 0.0.3
*/
/**
* return the resultat of vector division
*/
Vec2 div(Vec2 a, Vec2 b) {
  if(a == null || b == null) {
    return null;
  } else {
    float x = a.x /b.x;
    float y = a.y /b.y;
    return new Vec2(x,y);
  }
}

Vec3 div(Vec3 a, Vec3 b) {
  if(a == null || b == null) {
    return null;
  } else {
    float x = a.x /b.x;
    float y = a.y /b.y;
    float z = a.z /b.z;
    return new Vec3(x,y,z);
  }
}

Vec4 div(Vec4 a, Vec4 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    float x = a.x /b.x;
    float y = a.y /b.y;
    float z = a.z /b.z;
    float w = a.w /b.w;
    return new Vec4(x,y,z,w);
  }
}
/**
* iVec arg
*/
Vec2 div(iVec2 a, iVec2 b) {
  return div(Vec2(a),Vec2(b));
}

Vec3 div(iVec3 a, iVec3 b) {
  return div(Vec3(a),Vec3(b));
}

Vec4 div(iVec4 a, iVec4 b) {  
  return div(Vec4(a),Vec4(b));
}
/**
* float arg
*/
Vec2 div(Vec2 a, float arg) {
  return div(a,Vec2(arg,arg));
}

Vec3 div(Vec3 a, float arg) {
  return div(a,Vec3(arg,arg,arg));
}

Vec4 div(Vec4 a, float arg) {  
  return div(a,Vec4(arg,arg,arg,arg));
}
/**
* iVec + float
*/
Vec2 div(iVec2 a, float arg) {
  return div(Vec2(a),Vec2(arg,arg));
}

Vec3 div(iVec3 a, float arg) {
  return div(Vec3(a),Vec3(arg,arg,arg));
}

Vec4 div(iVec4 a, float arg) {  
  return div(Vec4(a),Vec4(arg,arg,arg,arg));
}


/**
Substraction
v 0.0.4
*/
/**
* return the resultat of vector substraction
*/
Vec2 sub(Vec2 a, Vec2 v_b) {
  if(a == null || v_b == null) {
    return null ;
  } else {
    float x = a.x - v_b.x;
    float y = a.y - v_b.y;
    return new Vec2(x,y);
  }
}

Vec3 sub(Vec3 a, Vec3 v_b) {
  if(a == null || v_b == null) {
    return null ;
  } else {
    float x = a.x - v_b.x;
    float y = a.y - v_b.y;
    float z = a.z - v_b.z;
    return new Vec3(x,y,z);
  }
}

Vec4 sub(Vec4 a, Vec4 v_b) {
  if(a == null || v_b == null) {
    return null ;
  } else {
    float x = a.x - v_b.x;
    float y = a.y - v_b.y;
    float z = a.z - v_b.z;
    float w = a.w - v_b.w;
    return new Vec4(x,y,z,w);
  }
}
/**
* iVec arg
*/
Vec2 sub(iVec2 a, iVec2 b) {
  return sub(Vec2(a),Vec2(b));
}

Vec3 sub(iVec3 a, iVec3 b) {
  return sub(Vec3(a),Vec3(b));
}

Vec4 sub(iVec4 a, iVec4 b) {  
  return sub(Vec4(a),Vec4(b));
}
/**
* float arg
*/
Vec2 sub(Vec2 a, float arg) {
  return sub(a,Vec2(arg,arg));
}

Vec3 sub(Vec3 a, float arg) {
  return sub(a,Vec3(arg,arg,arg));
}

Vec4 sub(Vec4 a, float arg) {  
  return sub(a,Vec4(arg,arg,arg,arg));
}
/**
* iVec + float
*/
Vec2 sub(iVec2 a, float arg) {
  return sub(Vec2(a),Vec2(arg,arg));
}

Vec3 sub(iVec3 a, float arg) {
  return sub(Vec3(a),Vec3(arg,arg,arg));
}

Vec4 sub(iVec4 a, float arg) {  
  return sub(Vec4(a),Vec4(arg,arg,arg,arg));
}



/**
Cross
v 0.0.2
*/
Vec3 cross(Vec3 v1, Vec3 v2) {
  if(v1 == null ||  v2 == null) {
    return null;
  } else {
    float crossX = v1.y * v2.z - v2.y * v1.z;
    float crossY = v1.z * v2.x - v2.z * v1.x;
    float crossZ = v1.x * v2.y - v2.x * v1.y;
    return Vec3(crossX, crossY, crossZ);
  }
}
/**
* @deprecated "cross(Vec3 v1, Vec3 v2, Vec3 target), can be deprecated in the future, need to be test"
*/
@Deprecated
Vec3 cross(Vec3 v1, Vec3 v2, Vec3 target) {
  println("cross(Vec3 v1, Vec3 v2, Vec3 target), can be deprecated in the future, need to be test");
  if(v1 == null ||  v2 == null || target == null) {
    return null ;
  } else {
    float crossX = v1.y * v2.z - v2.y * v1.z;
    float crossY = v1.z * v2.x - v2.z * v1.x;
    float crossZ = v1.x * v2.y - v2.x * v1.y;

    if (target == null) {
      target = Vec3(crossX, crossY, crossZ);
    } else {
      target.set(crossX, crossY, crossZ);
    }
    return target ;
  }  
}



/**
Equals
v 0.0.2
*/
/**
* Compare Vector with or without area
* we must add a compare method for the case when we need to compare in vector in the a class
*
* @return boolean
*/
// Vec2 equals

/**
* @deprecated instead use compare()
*/
@Deprecated
boolean equals(Vec2 v_a, Vec2 v_b) {
  return compare(v_a,v_b);
}
/**
* @deprecated instead use compare()
*/
@Deprecated
boolean equals(Vec3 v_a, Vec3 v_b) {
  return compare(v_a,v_b);
}
/**
* @deprecated instead use compare()
*/
@Deprecated
boolean equals(Vec4 v_a, Vec4 v_b) {
  return compare(v_a,v_b);
}
/**
* @deprecated instead use compare()
*/
@Deprecated
boolean equals(Vec2 v_a, Vec2 v_b, Vec2 area) {
  return compare(v_a,v_b, area);
}
/**
* @deprecated instead use compare()
*/
@Deprecated
boolean equals(Vec3 v_a, Vec3 v_b, Vec3 area) {
   return compare(v_a,v_b, area);
}
/**
* @deprecated instead use compare()
*/
@Deprecated
boolean equals(Vec4 v_a, Vec4 v_b, Vec4 area) {
  return compare(v_a,v_b, area);
}





boolean compare(Vec2 v_a, Vec2 v_b) {
  if(v_a == null || v_b == null) {
    println("Is not possible to compare", v_a, "to", v_b) ;
    return false ;
  } else {
    return equals(Vec4(v_a.x,v_a.y,0,0),Vec4(v_b.x,v_b.y,0,0)) ;
  }
}

// Vec3 compare
boolean compare(Vec3 v_a, Vec3 v_b) {
    if(v_a == null || v_b == null) {
    println("Is not possible to compare", v_a, "to", v_b) ;
    return false ;
  } else {
    return equals(Vec4(v_a.x, v_a.y, v_a.z, 0),Vec4(v_b.x, v_b.y, v_b.z, 0)) ;
  }
}
// Vec4 compare
boolean compare(Vec4 v_a, Vec4 v_b) {
  if(v_a != null && v_b != null ) {
    if((v_a.x == v_b.x) && (v_a.y == v_b.y) && (v_a.z == v_b.z) && (v_a.w == v_b.w)) {
            return true ; 
    } else {
      return false ;
    }
  } else {
    return false ;
  } 
}


/** 
* compare if the first vector is in the area of the second vector, 
* the area of the second vector is define by a Vec area, 
* that give the possibility of different size for each component
* @return boolean
*/
// Vec method
/**
* compare with area
*/
boolean compare(Vec2 v_a, Vec2 v_b, Vec2 area) {
  if(v_a == null || v_b == null || area == null) {
    println("Is not possible to compare", v_a, "with", v_b, "with", area) ;
    return false ;
  } else {
    return equals(Vec4(v_a.x, v_a.y, 0, 0),Vec4(v_b.x, v_b.y, 0, 0),Vec4(area.x, area.y, 0, 0)) ;
  }
}

boolean compare(Vec3 v_a, Vec3 v_b, Vec3 area) {
    if(v_a == null || v_b == null || area == null) {
    println("Is not possible to compare", v_a, "with", v_b, "with", area) ;
    return false ;
  } else {
    return equals(Vec4(v_a.x, v_a.y, v_a.z, 0),Vec4(v_b.x, v_b.y, v_b.z, 0),Vec4(area.x, area.y, area.z, 0)) ;
  }
}

boolean compare(Vec4 v_a, Vec4 v_b, Vec4 area) {
  if(v_a != null && v_b != null && area != null ) {
    if(    (v_a.x >= v_b.x -area.x && v_a.x <= v_b.x +area.x) 
        && (v_a.y >= v_b.y -area.y && v_a.y <= v_b.y +area.y) 
        && (v_a.z >= v_b.z -area.z && v_a.z <= v_b.z +area.z) 
        && (v_a.w >= v_b.w -area.w && v_a.w <= v_b.w +area.w)) {
            return true ; 
    } else {
      return false ;
    }
  } else {
    return false ;
  }
}









/**
Map
*/
/**
* return mapping vector
* @return Vec
*/
Vec2 map_vec(Vec2 v,float minIn, float maxIn, float minOut, float maxOut) {
  if(v != null) {
    float x = map(v.x, minIn, maxIn, minOut, maxOut) ;
    float y = map(v.y, minIn, maxIn, minOut, maxOut) ;
    return new Vec2(x,y) ;
  } else return null ;
}
Vec3 map_vec(Vec3 v,float minIn, float maxIn, float minOut, float maxOut) {
  if(v != null) {
    float x = map(v.x, minIn, maxIn, minOut, maxOut) ;
    float y = map(v.y, minIn, maxIn, minOut, maxOut) ;
    float z = map(v.z, minIn, maxIn, minOut, maxOut) ;
    return new Vec3(x,y,z) ;
  } else return null ;
}
Vec4 map_vec(Vec4 v,float minIn, float maxIn, float minOut, float maxOut) {
  if(v != null) {
    float x = map(v.x, minIn, maxIn, minOut, maxOut) ;
    float y = map(v.y, minIn, maxIn, minOut, maxOut) ;
    float z = map(v.z, minIn, maxIn, minOut, maxOut) ;
    float w = map(v.w, minIn, maxIn, minOut, maxOut) ;
    return new Vec4(x,y,z,w) ;
  } else return null ;
}

/**
Magnitude or length
*/
/**
* @return float
*/
// mag Vec2
float mag(Vec2 v_a) {
  float x = v_a.x*v_a.x ;
  float y = v_a.y *v_a.y ;
  return sqrt(x+y) ;
}

float mag(Vec2 v_a, Vec2 v_b) {
  // same result than dist
  float x = (v_b.x -v_a.x)*(v_b.x -v_a.x) ;
  float y = (v_b.y -v_a.y)*(v_b.y -v_a.y) ;
  return sqrt(x+y) ;
}
// mag Vec3
float mag(Vec3 v_a) {
  float x = v_a.x*v_a.x ;
  float y = v_a.y *v_a.y ;
  float z = v_a.z *v_a.z ;
  return sqrt(x+y+z) ;
}

float mag(Vec3 v_a, Vec3 v_b) {
  // same result than dist
  float x = (v_b.x -v_a.x)*(v_b.x -v_a.x) ;
  float y = (v_b.y -v_a.y)*(v_b.y -v_a.y) ;
  float z = (v_b.z -v_a.z)*(v_b.z -v_a.z) ;
  return sqrt(x+y+z) ;
}
// mag Vec4
float mag(Vec4 v_a) {
  float x = v_a.x*v_a.x ;
  float y = v_a.y *v_a.y ;
  float z = v_a.z *v_a.z ;
  float w = v_a.w *v_a.w ;
  return sqrt(x+y+z+w) ;
}

float mag(Vec4 v_a, Vec4 v_b) {
  // same result than dist
  float x = (v_b.x -v_a.x)*(v_b.x -v_a.x) ;
  float y = (v_b.y -v_a.y)*(v_b.y -v_a.y) ;
  float z = (v_b.z -v_a.z)*(v_b.z -v_a.z) ;
  float w = (v_b.w -v_a.w)*(v_b.w -v_a.w) ;
  return sqrt(x+y+z+w) ;
}



/**
Distance
v 0.0.2
*/
/**
* return the distance beatwen two vectors
* @return float
*/
float dist(Vec2 v_a, Vec2 v_b) {
  if(v_a != null && v_b != null) {
    float dx = v_a.x - v_b.x;
    float dy = v_a.y - v_b.y;
    return (float) Math.sqrt(dx*dx + dy*dy);
  } else return Float.NaN ;
    
}
float dist(Vec3 v_a, Vec3 v_b) {
  if(v_a != null && v_b != null) {
    float dx = v_a.x - v_b.x;
    float dy = v_a.y - v_b.y;
    float dz = v_a.z - v_b.z;
    return (float) Math.sqrt(dx*dx + dy*dy + dz*dz);
  } else return Float.NaN ;
}

float dist(Vec4 v_a, Vec4 v_b) {
  if(v_a != null && v_b != null) {
    float dx = v_a.x - v_b.x;
    float dy = v_a.y - v_b.y;
    float dz = v_a.z - v_b.z;
    float dw = v_a.w - v_b.w;
    return (float) Math.sqrt(dx*dx + dy*dy + dz*dz + dw*dw);
  } else return Float.NaN ;
}


/**
Deprecated Middle
*/
/**
* return the middle between two Vector
* @return Vec
*/
Vec2 middle(Vec2 p1, Vec2 p2)  {
  Vec2 middle ;
  middle = add(p1, p2);
  middle.div(2) ;
  println("The method middle is deprecated instead use barycenter(Vec... arg)") ;
  return middle ;
}

Vec2 middle(Vec2 [] list)  {
  Vec2 middle = Vec2() ;
  for (int i = 0 ; i < list.length ; i++) {
    middle.add(list[i]);
  }
  middle.div(list.length) ;
  println("The method middle is deprecated instead use barycenter(Vec... arg)") ;
  return middle ;
}

Vec3 middle(Vec3 p1, Vec3 p2) {
  Vec3 middle ;
  middle = add(p1, p2);
  middle.div(2) ;
  return middle ;
}

Vec3 middle(Vec3 [] list)  {
  Vec3 middle = Vec3() ;
  for (int i = 0 ; i < list.length ; i++) {
    middle.add(list[i]);
  }
  middle.div(list.length) ;
  println("The method middle is deprecated instead use barycenter(Vec... arg)") ;
  return middle ;
}

Vec4 middle(Vec4 p1, Vec4 p2)  {
  Vec4 middle ;
  middle = add(p1, p2);
  middle.div(2) ;
  println("The method middle is deprecated instead use barycenter(Vec... arg)") ;
  return middle ;
}

Vec4 middle(Vec4 [] list)  {
  Vec4 middle = Vec4() ;
  for (int i = 0 ; i < list.length ; i++) {
    middle.add(list[i]);
  }
  middle.div(list.length) ;
  println("The method middle is deprecated instead use barycenter(Vec... arg)") ;
  return middle ;
}


/**
barycenter
*/
Vec2 barycenter(Vec2... v) {
  int div_num = v.length ;
  Vec2 sum = Vec2() ;
  for(int i = 0 ; i < div_num ; i++) {
    sum.add(v[i]) ;
  }
  return sum.div(div_num) ;
}

 
Vec3 barycenter(Vec3... v) {
  int div_num = v.length ;
  Vec3 sum = Vec3() ;
  for(int i = 0 ; i < div_num ; i++) {
    sum.add(v[i]) ;
  }
  return sum.div(div_num) ;
}

Vec4 barycenter(Vec4... v) {
  int div_num = v.length ;
  Vec4 sum = Vec4() ;
  for(int i = 0 ; i < div_num ; i++) {
    sum.add(v[i]) ;
  }
  return sum.div(div_num) ;
}





/**
Jitter
v 0.0.2
*/
// Vec2
Vec2 jitter_2D(int range) {
  return jitter_2D(range, range) ;
}
Vec2 jitter_2D(Vec2 range) {
  return jitter_2D((int)range.x, (int)range.y) ;
}
Vec2 jitter_2D(int range_x, int range_y) {
  Vec2 jitter = Vec2() ;
  jitter.x = random_next_gaussian(range_x, 2);
  jitter.y = random_next_gaussian(range_y, 2);
  return jitter ;
}
// Vec3
Vec3 jitter_3D(int range) {
  return jitter_3D(range, range, range) ;
}
Vec3 jitter_3D(Vec3 range) {
  return jitter_3D((int)range.x, (int)range.y, (int)range.z) ;
}
Vec3 jitter_3D(int range_x, int range_y, int range_z) {
  Vec3 jitter = Vec3() ;
  jitter.x = random_next_gaussian(range_x, 2);
  jitter.y = random_next_gaussian(range_y, 2);
  jitter.z = random_next_gaussian(range_z, 2);
  return jitter ;
}
// Vec4
Vec4 jitter_4D(int range) {
  return jitter_4D(range, range, range, range) ;
}
Vec4 jitter_4D(Vec4 range) {
  return jitter_4D((int)range.x, (int)range.y, (int)range.z, (int)range.w) ;
}
Vec4 jitter_4D(int range_x, int range_y, int range_z, int range_w) {
  Vec4 jitter = Vec4() ;
  jitter.x = random_next_gaussian(range_x, 2);
  jitter.y = random_next_gaussian(range_y, 2);
  jitter.z = random_next_gaussian(range_z, 2);
  jitter.w = random_next_gaussian(range_w, 2);
  return jitter ;
}
// END JITTER
/////////////


/**
Normalize
*/
// VEC 2 from angle
///////////////////
Vec2 norm_rad(float angle) {
  float x = (float)Math.cos(angle) ;
  float y = (float)Math.sin(angle) ;
  return Vec2(x,y) ;
}

Vec2 norm_deg(float angle) {
  angle = radians(angle) ;
  float x = (float)Math.cos(angle) ;
  float y = (float)Math.sin(angle) ;
  return Vec2(x,y) ;
}


// normalize direction
Vec2 norm_dir(String type, float direction) {
  float x, y = 0 ;
  if(type.equals("DEG")) {
    float angle = TWO_PI/360.;
    direction = 360-direction;
    direction += 180;
    x = sin(angle *direction) ;
    y = cos(angle *direction);
  } else if (type.equals("RAD")) {
    x = sin(direction) ;
    y = cos(direction);
  } else {
    println("the type must be 'RAD' for radians or 'DEG' for degrees") ;
    x = 0 ;
    y = 0 ;
  }
  return new Vec2(x,y) ;
}
// END VEC FROM ANGLE
/////////////////////



/**
translate int color to Vec4 color
*/
Vec4 color_HSB_a(int c) {
  return Vec4(hue(c), saturation(c), brightness(c), alpha(c)) ;
}

Vec4 color_RGB_a(int c) {
  return Vec4(red(c), green(c), blue(c), alpha(c)) ;
}

Vec3 color_HSB(int c) {
  return Vec3(hue(c), saturation(c), brightness(c)) ;
}

Vec3 color_RGB(int c) {
  return Vec3(red(c), green(c), blue(c)) ;
}
































/**
New Vec, iVec and bVec
v 0.0.2
*/



/**
Return a new bVec
*/
/**
* @return bVec
*/
/**
bVec2
*/
bVec2 bVec2() {
  return new bVec2(false,false) ;
}

bVec2 bVec2(boolean b) {
  return new bVec2(b,b);
}

bVec2 bVec2(boolean x, boolean y) { 
  return new bVec2(x,y) ;
}

bVec2 bVec2(boolean [] array) {
  if(array.length == 1) {
    return new bVec2(array[0],array[0]);
  } else if (array.length > 1) {
    return new bVec2(array[0],array[1]);
  } else {
    return null;
  }
}

bVec2 bVec2(bVec b) {
  if(b == null) {
    println("bVec null, instead 'false' is used to build bVec") ;
    return new bVec2(false,false) ;
  } else if(b instanceof bVec5 || b instanceof bVec6) {
    return new bVec2(b.a,b.b) ;
  } else {
    return new bVec2(b.x,b.y) ;
  }
}

/**
iVec3
*/
bVec3 bVec3() {
  return new bVec3(false,false,false) ;
}

bVec3 bVec3(boolean b) {
  return new bVec3(b,b,b);
}

bVec3 bVec3(boolean x, boolean y, boolean z) { 
  return new bVec3(x,y,z) ;
}

bVec3 bVec3(boolean [] array) {
  if(array.length == 1) {
    return new bVec3(array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new bVec3(array[0],array[1],false);
  } else if (array.length > 2) {
    return new bVec3(array[0],array[1],array[2]);
  } else {
    return null;
  }
}

bVec3 bVec3(bVec b) {
  if(b == null) {
    println("bVec null, instead 'false' is used to build bVec") ;
    return new bVec3(false,false,false) ;
  } else if(b instanceof bVec5 || b instanceof bVec6) {
    return new bVec3(b.a,b.b,b.c) ;
  } else {
    return new bVec3(b.x,b.y,b.z) ;
  }
}

/**
iVec4
*/
bVec4 bVec4() {
  return new bVec4(false,false,false,false) ;
}

bVec4 bVec4(boolean b) {
  return new bVec4(b,b,b,b);
}

bVec4 bVec4(boolean x, boolean y, boolean z, boolean w) { 
  return new bVec4(x,y,z,w) ;
}

bVec4 bVec4(boolean [] array) {
  if(array.length == 1) {
    return new bVec4(array[0],array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new bVec4(array[0],array[1],false,false);
  } else if (array.length == 3) {
    return new bVec4(array[0],array[1],array[2],false);
  } else if (array.length > 3) {
    return new bVec4(array[0],array[1],array[2],array[3]);
  } else {
    return null;
  }
}

bVec4 bVec4(bVec b) {
  if(b == null) {
    println("bVec null, instead 'false' is used to build bVec") ;
    return new bVec4(false,false,false,false) ;
  } else if(b instanceof bVec5 || b instanceof bVec6) {
    return new bVec4(b.a,b.b,b.c,b.d) ;
  } else {
    return new bVec4(b.x,b.y,b.z,b.w) ;
  }
}

/**
iVec5
*/
bVec5 bVec5() {
  return new bVec5(false,false,false,false,false) ;
}

bVec5 bVec5(boolean b) {
  return new bVec5(b,b,b,b,b);
}

bVec5 bVec5(boolean a, boolean b, boolean c, boolean d, boolean e) { 
  return new bVec5(a,b,c,d,e) ;
}

bVec5 bVec5(boolean [] array) {
  if(array.length == 1) {
    return new bVec5(array[0],array[0],array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new bVec5(array[0],array[1],false,false,false);
  } else if (array.length == 3) {
    return new bVec5(array[0],array[1],array[2],false,false);
  } else if (array.length == 4) {
    return new bVec5(array[0],array[1],array[2],array[3],false);
  } else if (array.length >4) {
    return new bVec5(array[0],array[1],array[2],array[3],array[4]);
  } else {
    return null;
  }
}

bVec5 bVec5(bVec b) {
  if(b == null) {
    println("bVec null, instead 'false' is used to build bVec") ;
    return new bVec5(false,false,false,false,false) ;
  } else if(b instanceof bVec5 || b instanceof bVec6) {
    return new bVec5(b.a,b.b,b.c,b.d,b.e) ;
  } else {
    return new bVec5(b.x,b.y,b.z,b.w,false) ;
  }
}

/**
bVec6
*/
bVec6 bVec6() {
  return new bVec6(false,false,false,false,false,false) ;
}

bVec6 bVec6(boolean b) {
  return new bVec6(b,b,b,b,b,b);
}

bVec6 bVec6(boolean a, boolean b, boolean c, boolean d, boolean e, boolean f) { 
  return new bVec6(a,b,c,d,e,f) ;
}

bVec6 bVec6(boolean [] array) {
  if(array.length == 1) {
    return new bVec6(array[0],array[0],array[0],array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new bVec6(array[0],array[1],false,false,false,false);
  } else if (array.length == 3) {
    return new bVec6(array[0],array[1],array[2],false,false,false);
  } else if (array.length == 4) {
    return new bVec6(array[0],array[1],array[2],array[3],false,false);
  } else if (array.length == 5) {
    return new bVec6(array[0],array[1],array[2],array[3],array[4],false);
  }  else if (array.length > 5) {
    return new bVec6(array[0],array[1],array[2],array[3],array[4],array[5]);
  } else {
    return null;
  }
}

bVec6 bVec6(bVec b) {
  if(b== null) {
    println("bVec null, instead 'false' is used to build bVec") ;
    return new bVec6(false,false,false,false,false,false) ;
  } else if(b instanceof bVec5 || b instanceof bVec6) {
    return new bVec6(b.a,b.b,b.c,b.d,b.e,b.f) ;
  } else {
    return new bVec6(b.x,b.y,b.z,b.w,false,false) ;
  }
}

























/**
Return a new iVec
*/
/**
iVec2
*/
iVec2 iVec2() {
  return iVec2(0) ;
}

iVec2 iVec2(int v) {
  return new iVec2(v,v);
}

iVec2 iVec2(int x, int y) { 
  return new iVec2(x,y) ;
}

iVec2 iVec2(int [] array) {
  if(array.length == 1) {
    return new iVec2(array[0],array[0]);
  } else if (array.length > 1) {
    return new iVec2(array[0],array[1]);
  } else {
    return null;
  }
}

iVec2 iVec2(iVec p) {
  if(p == null) {
    println("iVec null, instead '0' is used to build iVec") ;
    return new iVec2(0,0) ;
  } else if(p instanceof iVec5 || p instanceof iVec6) {
    return new iVec2(p.a,p.b) ;
  } else {
    return new iVec2(p.x,p.y) ;
  }
}

/**
iVec3
*/
iVec3 iVec3() {
  return iVec3(0) ;
}

iVec3 iVec3(int v) {
  return new iVec3(v,v,v);
}

iVec3 iVec3(int x, int y, int z) { 
  return new iVec3(x,y,z) ;
}

iVec3 iVec3(int [] array) {
  if(array.length == 1) {
    return new iVec3(array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new iVec3(array[0],array[1],0);
  } else if (array.length > 2) {
    return new iVec3(array[0],array[1],array[2]);
  } else {
    return null;
  }
}

iVec3 iVec3(iVec p) {
  if(p == null) {
    println("iVec null, instead '0' is used to build iVec") ;
    return new iVec3(0,0,0) ;
  } else if(p instanceof iVec5 || p instanceof iVec6) {
    return new iVec3(p.a,p.b,p.c) ;
  } else {
    return new iVec3(p.x,p.y,p.z) ;
  }
}

/**
iVec4
*/
iVec4 iVec4() {
  return iVec4(0) ;
}

iVec4 iVec4(int v) {
  return new iVec4(v,v,v,v);
}

iVec4 iVec4(int x, int y, int z, int w) { 
  return new iVec4(x,y,z,w) ;
}

iVec4 iVec4(int [] array) {
  if(array.length == 1) {
    return new iVec4(array[0],array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new iVec4(array[0],array[1],0,0);
  } else if (array.length == 3) {
    return new iVec4(array[0],array[1],array[2],0);
  } else if (array.length > 3) {
    return new iVec4(array[0],array[1],array[2],array[3]);
  } else {
    return null;
  }
}

iVec4 iVec4(iVec p) {
  if(p == null) {
    println("iVec null, instead '0' is used to build iVec") ;
    return new iVec4(0,0,0,0) ;
  } else if(p instanceof iVec5 || p instanceof iVec6) {
    return new iVec4(p.a,p.b,p.c,p.d) ;
  } else {
    return new iVec4(p.x,p.y,p.z,p.w) ;
  }
}

/**
iVec5
*/
iVec5 iVec5() {
  return iVec5(0) ;
}

iVec5 iVec5(int v) {
  return new iVec5(v,v,v,v,v);
}

iVec5 iVec5(int a, int b, int c, int d, int e) { 
  return new iVec5(a,b,c,d,e) ;
}

iVec5 iVec5(int [] array) {
  if(array.length == 1) {
    return new iVec5(array[0],array[0],array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new iVec5(array[0],array[1],0,0,0);
  } else if (array.length == 3) {
    return new iVec5(array[0],array[1],array[2],0,0);
  } else if (array.length == 4) {
    return new iVec5(array[0],array[1],array[2],array[3],0);
  } else if (array.length > 4) {
    return new iVec5(array[0],array[1],array[2],array[3],array[4]);
  } else {
    return null;
  }
}

iVec5 iVec5(iVec p) {
  if(p == null) {
    println("iVec null, instead '0' is used to build iVec") ;
    return new iVec5(0,0,0,0,0) ;
  } else if(p instanceof iVec5 || p instanceof iVec6) {
    return new iVec5(p.a,p.b,p.c,p.d,p.e) ;
  } else {
    return new iVec5(p.x,p.y,p.z,p.w,0) ;
  }
}

/**
iVec6
*/
iVec6 iVec6() {
  return iVec6(0) ;
}

iVec6 iVec6(int v) {
  return new iVec6(v,v,v,v,v,v);
}

iVec6 iVec6(int a, int b, int c, int d, int e, int f) { 
  return new iVec6(a,b,c,d,e,f) ;
}

iVec6 iVec6(int [] array) {
  if(array.length == 1) {
    return new iVec6(array[0],array[0],array[0],array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new iVec6(array[0],array[1],0,0,0,0);
  } else if (array.length == 3) {
    return new iVec6(array[0],array[1],array[2],0,0,0);
  } else if (array.length == 4) {
    return new iVec6(array[0],array[1],array[2],array[3],0,0);
  } else if (array.length == 5) {
    return new iVec6(array[0],array[1],array[2],array[3],array[4],0);
  }  else if (array.length > 5) {
    return new iVec6(array[0],array[1],array[2],array[3],array[4],array[5]);
  } else {
    return null;
  }
}

iVec6 iVec6(iVec p) {
  if(p == null) {
    println("iVec null, instead '0' is used to build iVec") ;
    return new iVec6(0,0,0,0,0,0) ;
  } else if(p instanceof iVec5 || p instanceof iVec6) {
    return new iVec6(p.a,p.b,p.c,p.d,p.e,p.f) ;
  } else {
    return new iVec6(p.x,p.y,p.z,p.w,0,0) ;
  }
}
























/**
Return a new Vec
v 0.0.4
*/
/**
Vec 2
*/
Vec2 Vec2() {
  return new Vec2(0,0) ;
}

Vec2 Vec2(float x, float y) { 
  return new Vec2(x,y) ;
}

Vec2 Vec2(float [] array) {
  if(array.length == 1) {
    return new Vec2(array[0],array[0]);
  } else if (array.length > 1) {
    return new Vec2(array[0],array[1]);
  } else {
    return null;
  }
}

Vec2 Vec2(int [] array) {
  if(array.length == 1) {
    return new Vec2(array[0],array[0]);
  } else if (array.length > 1) {
    return new Vec2(array[0],array[1]);
  } else {
    return null;
  }
}

Vec2 Vec2(float v) {
  return new Vec2(v,v) ;
}

Vec2 Vec2(PVector p) {
  if(p == null) {
    return new Vec2(0,0);
  } else {
    return new Vec2(p.x, p.y);
  }
}

Vec2 Vec2(Vec p) {
  if(p == null) {
    return new Vec2(0,0);
  } else if(p instanceof Vec5 || p instanceof Vec6) {
    return new Vec2(p.a,p.b);
  } else {
    return new Vec2(p.x,p.y);
  }
}


Vec2 Vec2(iVec p) {
  if(p == null) {
    return new Vec2(0,0);
  } else if(p instanceof iVec5 || p instanceof iVec6) {
    return new Vec2(p.a,p.b);
  } else {
    return new Vec2(p.x,p.y);
  }
}


Vec2 Vec2(String s, int x, int y) { 
  return new Vec2(s,x,y);
}

Vec2 Vec2(String s, int a, int b, int c, int d) { 
  return new Vec2(s,a,b,c,d);
}

Vec2 Vec2(String s, int v) {
  return new Vec2(s,v);
}
/**
Vec 3
*/
Vec3 Vec3() {
  return new Vec3(0,0,0) ;
}

Vec3 Vec3(float x, float y, float z) {
  return new Vec3(x,y,z);
}

Vec3 Vec3(float [] array) {
  if(array.length == 1) {
    return new Vec3(array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new Vec3(array[0],array[1],0);
  } else if (array.length > 2) {
    return new Vec3(array[0],array[1],array[2]);
  } else {
    return null;
  }
}

Vec3 Vec3(int [] array) {
  if(array.length == 1) {
    return new Vec3(array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new Vec3(array[0],array[1],0);
  } else if (array.length > 2) {
    return new Vec3(array[0],array[1],array[2]);
  } else {
    return null;
  }
}

Vec3 Vec3(float v) {
  return new Vec3(v,v,v);
}

Vec3 Vec3(PVector p) {
  if(p == null) {
    return new Vec3(0,0,0);
  } else {
    return new Vec3(p.x, p.y, p.z);
  }
}

Vec3 Vec3(Vec p) {
  if(p == null) {
    return new Vec3(0,0,0);
  } else if(p instanceof Vec5 || p instanceof Vec6) {
    return new Vec3(p.a,p.b,p.c);
  } else {
    return new Vec3(p.x,p.y,p.z);
  }
}

Vec3 Vec3(iVec p) {
  if(p == null) {
    return new Vec3(0,0,0);
  } else if(p instanceof iVec5 || p instanceof iVec6) {
    return new Vec3(p.a,p.b,p.c);
  } else {
    return new Vec3(p.x,p.y,p.z);
  }
}



Vec3 Vec3(String s, int x, int y, int z) { 
  return new Vec3(s,x,y,z);
}

Vec3 Vec3(String s, int a, int b, int c, int d, int e, int f) { 
  return new Vec3(s,a,b,c,d,e,f);
}

Vec3 Vec3(String s, int v) {
  return new Vec3(s,v);
}
/**
Vec 4
*/
Vec4 Vec4() {
  return new Vec4(0,0,0,0);
}

Vec4 Vec4(float x, float y, float z, float w) {
  return new Vec4(x,y,z,w);
}

Vec4 Vec4(float [] array) {
  if(array.length == 1) {
    return new Vec4(array[0],array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new Vec4(array[0],array[1],0,0);
  } else if (array.length == 3) {
    return new Vec4(array[0],array[1],array[2],0);
  } else if (array.length > 3) {
    return new Vec4(array[0],array[1],array[2],array[3]);
  } else {
    return null;
  }
}

Vec4 Vec4(int [] array) {
  if(array.length == 1) {
    return new Vec4(array[0],array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new Vec4(array[0],array[1],0,0);
  } else if (array.length == 3) {
    return new Vec4(array[0],array[1],array[2],0);
  } else if (array.length > 3) {
    return new Vec4(array[0],array[1],array[2],array[3]);
  } else {
    return null;
  }
}

Vec4 Vec4(float v) {
  return new Vec4(v,v,v,v);
}

Vec4 Vec4(PVector p) {
  if(p == null) {
    return new Vec4(0,0,0,0);
  } else {
    return new Vec4(p.x, p.y, p.z, 0);
  }
}
// build with Vec
Vec4 Vec4(Vec p) {
  if(p == null) {
    return new Vec4(0,0,0,0);
  } else if(p instanceof Vec5 || p instanceof Vec6) {
    return new Vec4(p.a,p.b,p.c,p.d);
  } else {
    return new Vec4(p.x,p.y,p.z,p.w);
  }
}

Vec4 Vec4(iVec p) {
  if(p == null) {
    return new Vec4(0,0,0,0);
  } else if(p instanceof iVec5 || p instanceof iVec6) {
    return new Vec4(p.a,p.b,p.c,p.d);
  } else {
    return new Vec4(p.x,p.y,p.z,p.w);
  }
}



Vec4 Vec4(String s, int x, int y, int z, int w) { 
  return new Vec4(s,x,y,z,w);
}

Vec4 Vec4(String s, int a, int b, int c, int d, int e, int f, int g, int h) { 
  return new Vec4(s,a,b,c,d,e,f,g,h);
}

Vec4 Vec4(String s, int v) {
  return new Vec4(s,v);
}
/**
Vec 5
*/
Vec5 Vec5() {
  return new Vec5(0,0,0,0,0);
}

Vec5 Vec5(float a, float b, float c, float d, float e) {
  return new Vec5(a,b,c,d,e);
}

Vec5 Vec5(float [] array) {
  if(array.length == 1) {
    return new Vec5(array[0],array[0],array[0],array[0],array[0]);
  } else if (array.length == 2){
    return new Vec5(array[0],array[1],0,0,0) ;
  } else if (array.length == 3){
    return new Vec5(array[0],array[1],array[2],0,0) ;
  } else if (array.length == 4){
    return new Vec5(array[0],array[1],array[2],array[3],0) ;
  }  else if (array.length > 4){
    return new Vec5(array[0],array[1],array[2],array[3],array[4]) ;
  } else {
    return null;
  }
}

Vec5 Vec5(int [] array) {
  if(array.length == 1) {
    return new Vec5(array[0],array[0],array[0],array[0],array[0]);
  } else if (array.length == 2){
    return new Vec5(array[0],array[1],0,0,0) ;
  } else if (array.length == 3){
    return new Vec5(array[0],array[1],array[2],0,0) ;
  } else if (array.length == 4){
    return new Vec5(array[0],array[1],array[2],array[3],0) ;
  }  else if (array.length > 4){
    return new Vec5(array[0],array[1],array[2],array[3],array[4]) ;
  } else {
    return null;
  }
}

Vec5 Vec5(float v) {
  return new Vec5(v,v,v,v,v);
}

Vec5 Vec5(PVector p) {
  if(p == null) {
    return new Vec5(0,0,0,0,0);
  } else {
    return new Vec5(p.x, p.y, p.z, 0,0);
  }
}
// build with Vec
Vec5 Vec5(Vec p) {
  if(p == null) {
    return new Vec5(0,0,0,0,0);
  } else if(p instanceof Vec5 || p instanceof Vec6) {
    return new Vec5(p.a,p.b,p.c,p.d,p.e);
  } else {
    return new Vec5(p.x,p.y,p.z,p.w,p.e);
  }
}

Vec5 Vec5(iVec p) {
  if(p == null) {
    return new Vec5(0,0,0,0,0);
  }  else if(p instanceof iVec5 || p instanceof iVec6) {
    return new Vec5(p.a,p.b,p.c,p.d,p.e);
  } else {
    return new Vec5(p.x,p.y,p.z,p.w,p.e);
  }
}


Vec5 Vec5(String s, int a, int b, int c, int d, int e) { 
  return new Vec5(s,a,b,c,d,e);
}

Vec5 Vec5(String s, int a, int b, int c, int d, int e, int f, int g, int h, int i, int j) { 
  return new Vec5(s,a,b,c,d,e,f,g,h,i,j);
}

Vec5 Vec5(String s, int v) {
  return new Vec5(s,v);
}
/**
Vec 6
*/
Vec6 Vec6() {
  return new Vec6(0,0,0,0,0,0) ;
}

Vec6 Vec6(float a, float b, float c, float d, float e, float f) {
  return new Vec6(a,b,c,d,e,f);
}

Vec6 Vec6(float [] array) {
  if(array.length == 1) {
    return new Vec6(array[0],array[0],array[0],array[0],array[0],array[0]);
  } else if (array.length == 2){
    return new Vec6(array[0],array[1],0,0,0,0) ;
  } else if (array.length == 3){
    return new Vec6(array[0],array[1],array[2],0,0,0) ;
  } else if (array.length == 4){
    return new Vec6(array[0],array[1],array[2],array[3],0,0) ;
  } else if (array.length == 5){
    return new Vec6(array[0],array[1],array[2],array[3],array[4],0) ;
  }  else if (array.length > 5){
    return new Vec6(array[0],array[1],array[2],array[3],array[4],array[5]) ;
  } else {
    return null;
  }
}

Vec6 Vec6(int [] array) {
  if(array.length == 1) {
    return new Vec6(array[0],array[0],array[0],array[0],array[0],array[0]);
  } else if (array.length == 2){
    return new Vec6(array[0],array[1],0,0,0,0) ;
  } else if (array.length == 3){
    return new Vec6(array[0],array[1],array[2],0,0,0) ;
  } else if (array.length == 4){
    return new Vec6(array[0],array[1],array[2],array[3],0,0) ;
  } else if (array.length == 5){
    return new Vec6(array[0],array[1],array[2],array[3],array[4],0) ;
  }  else if (array.length > 5){
    return new Vec6(array[0],array[1],array[2],array[3],array[4],array[5]) ;
  } else {
    return null;
  }
}

Vec6 Vec6(float v) {
  return new Vec6(v,v,v,v,v,v);
}
Vec6 Vec6(PVector p) {
  if(p == null) {
    return new Vec6(0,0,0,0,0,0);
  } else {
    return new Vec6(p.x, p.y, p.z, 0,0,0);
  }
}

// build with vec
Vec6 Vec6(Vec p) {
  if(p == null) {
    return new Vec6(0,0,0,0,0,0);
  } else if(p instanceof Vec5 || p instanceof Vec6) {
    return new Vec6(p.a,p.b,p.c,p.d,p.e,p.f);
  } else {
    return new Vec6(p.x,p.y,p.z,p.w,p.e,p.f);
  }
}

Vec6 Vec6(iVec p) {
  if(p == null) {
    return new Vec6(0,0,0,0,0,0) ;
  } else if(p instanceof iVec5 || p instanceof iVec6) {
    return new Vec6(p.a,p.b,p.c,p.d,p.e,p.f);
  } else {
    return new Vec6(p.x,p.y,p.z,p.w,p.e,p.f);
  }
}





Vec6 Vec6(String s, int a, int b, int c, int d, int e, int f) { 
  return new Vec6(s,a,b,c,d,e,f);
}

Vec6 Vec6(String s, int a, int b, int c, int d, int e, int f, int g, int h, int i, int j, int k, int l) { 
  return new Vec6(s,a,b,c,d,e,f,g,h,i,j,k,l);
}

Vec6 Vec6(String s, int v) {
  return new Vec6(s,v);
}










