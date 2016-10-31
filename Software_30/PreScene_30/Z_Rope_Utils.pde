/**
RPE UTILS 1.18.0
Rope – Romanesco Processing Environment – 2015 – 2016
* @author Stan le Punk
* @see https://github.com/StanLepunK/Utils
*/

/**
CONSTANT NUMBER must be here to be generate before all

*/
final float PHI = (1 + sqrt(5))/2; //a number of polys use the golden ratio...
final float ROOT2 = sqrt(2); //...and the square root of two, the famous first irrationnal number by Pythagore
final float EULER = 2.718281828459045235360287471352; // Constant d'Euler
// about constant https://en.wikipedia.org/wiki/Mathematical_constant








/**
Rope – Romanesco Processing environment – 
BACKGROUND_2D_3D 0.0.3
* @author Stan le Punk
* @see other Processing work on https://github.com/StanLepunK
*/

float MAX_RATIO_DEPTH = 6.9 ;

/**
Normalize background
*/

void background_norm(Vec4 bg) {
  background_norm(bg.x, bg.y, bg.z, bg.a) ;
}

void background_norm(Vec3 bg) {
  background_norm(bg.x, bg.y, bg.z, 1) ;
}

void background_norm(Vec2 bg) {
  background_norm(bg.x, bg.x, bg.x, bg.y) ;
}

void background_norm(float c, float a) {
  background_norm(c, c, c, a) ;
}

void background_norm(float c) {
  background_norm(c, c, c, 1) ;
}

void background_norm(float r,float g, float b) {
  background_norm(r, g, b, 1) ;
}

// Main method
void background_norm(float r_c, float g_c, float b_c, float a_c) {
  float x = map(r_c,0,1, 0, g.colorModeX) ;
  float y = map(g_c,0,1, 0, g.colorModeY) ;
  float z = map(b_c,0,1, 0, g.colorModeZ) ;
  float a = map(a_c,0,1, 0, g.colorModeA) ;
  noStroke() ;
  fill(x, y, z, a) ;
  int canvas_x = width ;
  int canvas_y = height ;
  if(renderer_P3D()) {
    canvas_x = width *100 ;
    canvas_y = height *100 ;
    int pos_x = - canvas_x /2 ;
    int pos_y = - canvas_y /2 ;
    // this problem of depth is not clarify, is must refactoring
    int pos_z = int( -height *MAX_RATIO_DEPTH) ;
    pushMatrix() ;
    translate(0,0,pos_z) ;
    rect(pos_x,pos_y,canvas_x, canvas_y) ;
    popMatrix() ;
  } else {
    rect(0,0,canvas_x, canvas_y) ;
  }
}



/**
Background
*/
void background_rope(float colour) {
  background_norm(colour / g.colorModeX, colour / g.colorModeY, colour / g.colorModeZ) ;
  // background_2D(colour, g.colorModeA) ;
}

void background_rope(float colour, float alpha) {
  background_norm(colour / g.colorModeX, colour / g.colorModeY, colour / g.colorModeZ, alpha / g.colorModeA) ;
}


void background_rope(float red, float green, float blue, float alpha) {
  background_norm(red / g.colorModeX, green / g.colorModeY, blue / g.colorModeZ, alpha / g.colorModeA) ;
}

void background_rope(float red, float green, float blue) {
  background_norm(red / g.colorModeX, green / g.colorModeY, blue / g.colorModeZ) ;
}

void background_rope(Vec4 c) {
  background_norm(c.x / g.colorModeX, c.y / g.colorModeY, c.z / g.colorModeZ, c.w / g.colorModeA) ;
}

void background_rope(Vec3 c) {
  background_norm(c.x / g.colorModeX, c.y / g.colorModeY, c.z / g.colorModeZ) ;
}

void background_rope(Vec2 c) {
  background_norm(c.x / g.colorModeX, c.x / g.colorModeY, c.x / g.colorModeZ, c.y / g.colorModeA) ;
}















/**
TABLE METHOD 0.0.3
for Table with the first COLLUMN is used for name and the next 6 for the value.
The method is used with the Class Info

*/
// table method for row sort
void buildTable(Table table, TableRow [] tableRow, String [] col_name, String [] row_name) {
  // add col
  for(int i = 0 ; i < col_name.length ; i++) {
    table.addColumn(col_name[i]);
  }
  // add row
  tableRow = new TableRow[row_name.length] ;
  buildRow(table, row_name) ;
}

void buildTable(Table table, String [] col_name) {
  // add col
  for(int i = 0 ; i < col_name.length ; i++) {
    table.addColumn(col_name[i]);
  }
}

void buildRow(Table table, String [] row_name) {
  int num_row = table.getRowCount() ;
  for(int i = 0 ; i < num_row ; i++) {
    TableRow row = table.getRow(i) ;
    row.setString(table.getColumnTitle(0), row_name[i]) ; 
  }
}

void setTable(Table table, TableRow [] rows, Info_obj... info) {
  for(int i = 0 ; i < rows.length ; i++) {
    if(rows[i] != null) {
      for(int j = 0 ; j < info.length ; j++) {
        if(info[j] != null && info[j].get_name().equals(rows[i].getString(table.getColumnTitle(0)))) {
          if(table.getColumnCount() > 1 && info[j].catch_a() != null)  write_row(rows[i], table.getColumnTitle(1), info[j].catch_a()) ;
          if(table.getColumnCount() > 2 && info[j].catch_b() != null)  write_row(rows[i], table.getColumnTitle(2), info[j].catch_b()) ;
          if(table.getColumnCount() > 3 && info[j].catch_c() != null)  write_row(rows[i], table.getColumnTitle(3), info[j].catch_c()) ;
          if(table.getColumnCount() > 4 && info[j].catch_d() != null)  write_row(rows[i], table.getColumnTitle(4), info[j].catch_d()) ;
          if(table.getColumnCount() > 5 && info[j].catch_e() != null)  write_row(rows[i], table.getColumnTitle(5), info[j].catch_e()) ;
          if(table.getColumnCount() > 6 && info[j].catch_f() != null)  write_row(rows[i], table.getColumnTitle(6), info[j].catch_f()) ;
        }
        
      }
    }
  }
}


void setRow(Table table, Info_obj info) {
  TableRow result = table.findRow(info.get_name(), table.getColumnTitle(0)) ;
  if(result != null) {
    if(table.getColumnCount() > 1 && info.catch_a() != null)  write_row(result, table.getColumnTitle(1), info.catch_a()) ;
    if(table.getColumnCount() > 2 && info.catch_b() != null)  write_row(result, table.getColumnTitle(2), info.catch_b()) ;
    if(table.getColumnCount() > 3 && info.catch_c() != null)  write_row(result, table.getColumnTitle(3), info.catch_c()) ;
    if(table.getColumnCount() > 4 && info.catch_d() != null)  write_row(result, table.getColumnTitle(4), info.catch_d()) ;
    if(table.getColumnCount() > 5 && info.catch_e() != null)  write_row(result, table.getColumnTitle(5), info.catch_e()) ;
    if(table.getColumnCount() > 6 && info.catch_f() != null)  write_row(result, table.getColumnTitle(6), info.catch_f()) ;
  }
}

void write_row(TableRow row, String col_name, Object o) {
  if(o instanceof String) {
    String s = (String) o ;
    row.setString(col_name, s);
  } else if(o instanceof Short) {
    short sh = (Short) o ;
    row.setInt(col_name, sh);
  } else if(o instanceof Integer) {
    int in = (Integer) o ;
    row.setInt(col_name, in);
  } else if(o instanceof Float) {
    float f = (Float) o ;
    row.setFloat(col_name, f);
  } else if(o instanceof Character) {
    char c = (Character) o ;
    String s = Character.toString(c) ;
    row.setString(col_name, s);
  } else if(o instanceof Boolean) {
    boolean b = (Boolean) o ;
    String s = Boolean.toString(b) ;
    row.setString(col_name, s);
  } 
}






/**
print tempo

*/
void printTempo(int tempo, Object... var) {
  if(frameCount%tempo == 0 ) {
    println(var) ;
  }
}







/**
Class info 0.2.2

*/
public class Info_dict {
  ArrayList<Info> list ;
  char type_list = 'o' ;

  Info_dict(char type_list) {
    this.type_list = type_list ;

  }

  Info_dict() {
    list = new ArrayList<Info>() ;
  }

  // add Object
  void add(String name, Object a) {
    Info_obj info = new Info_obj(name, a) ;
    list.add(info) ;
  }
  void add(String name, Object a, Object b) {
    Info_obj info = new Info_obj(name, a,b) ;
    list.add(info) ;
  }
  void add(String name, Object a, Object b, Object c) {
    Info_obj info = new Info_obj(name, a,b,c) ;
    list.add(info) ;
  }
  void add(String name, Object a, Object b, Object c, Object d) {
    Info_obj info = new Info_obj(name, a,b,c,d) ;
    list.add(info) ;
  }
  void add(String name, Object a, Object b, Object c, Object d, Object e) {
    Info_obj info = new Info_obj(name, a,b,c,d,e) ;
    list.add(info) ;
  }
  void add(String name, Object a, Object b, Object c, Object d, Object e, Object f) {
    Info_obj info = new Info_obj(name, a,b,c,d,e,f) ;
    list.add(info) ;
  }
 
  /**
  read
  */  
  void read() {
    for(Info a : list) {
      println(a, type(type_list)) ;
    }
  }
  /**
  check type
  */ 
  String type (char type)  {
    String t = ("Unknow") ;
    if(type == 'i') t = "Integer" ;
    else if(type == 's') t = "String" ;
    else if(type == 'f') t = "Float" ;
    else if(type == 'o') t = "Object" ;
    else if(type == 'v') t = "Vec" ;
    else t = ("Unknow") ;
    return t ;
  }
  
  /**
  get
  */
  Info get(int target) {
    if(target < list.size() && target >= 0) {
      return list.get(target) ;
    } else return null ;
  }
  
  Info [] get(String which) {
    Info [] info  ;
    int count = 0 ;
    for(Info a : list) {
      if(a.get_name().equals(which)) {
        count++ ;
      }
    }
    if (count > 0 ) {
      info = new Info[count] ;
      count = 0 ;
      for(Info a : list) {
        if(a.get_name().equals(which)) {
          info[count] = a ;
          count++ ;
        }
      }
    } else {
      info = new Info_String[1] ;
      info[0] = null ;
    }
    if(info.length == 1 && info[0] == null )return null ; else return info ;
  }
  /**
  clear
  */
  void clear() {
    list.clear() ;
  }
  /**
  remove
  */
  void remove(String which) {
    for(int i = 0 ; i < list.size() ; i++) {
      Info a = list.get(i) ;
      if(a.get_name().equals(which)) {
        list.remove(i) ;
      }
    }
  }
  
  void remove(int target) {
   if(target < list.size()) {
      list.remove(target) ;
    }
  }
}

/**
Info_int_dict

*/
public class Info_int_dict extends Info_dict {
  ArrayList<Info_int> list_int ;
  Info_int_dict() {
    super('i') ;
    list_int = new ArrayList<Info_int>() ;
  }


  // add int
  void add(String name, int a) {
    Info_int info = new Info_int(name, a) ;
    list_int.add(info) ;
  } 
  void add(String name, int a, int b) {
    Info_int info = new Info_int(name, a,b) ;
    list_int.add(info) ;
  } 

  void add(String name, int a, int b, int c) {
    Info_int info = new Info_int(name, a,b,c) ;
    list_int.add(info) ;
  } 
  void add(String name, int a, int b, int c, int d) {
    Info_int info = new Info_int(name, a,b,c,d) ;
    list_int.add(info) ;
  } 
  void add(String name, int a, int b, int c, int d, int e) {
    Info_int info = new Info_int(name, a,b,c,d,e) ;
    list_int.add(info) ;
  } 
  void add(String name, int a, int b, int c, int d, int e, int f) {
    Info_int info = new Info_int(name, a,b,c,d,e,f) ;
    list_int.add(info) ;
  }
  /**
  read
  */ 
  void read() {
    for(Info a : list_int) {
      println(a, type(a.get_type())) ;
    }
  }
  
  /**
  get
  */
  Info_int get(int target) {
    if(target < list_int.size() && target >= 0) {
      return list_int.get(target) ;
    } else return null ;
  }
  
  Info_int [] get(String which) {
    Info_int [] info  ;
    int count = 0 ;
    for(Info_int a : list_int) {
      if(a.get_name().equals(which)) {
        count++ ;
      }
    }
    if (count > 0 ) {
      info = new Info_int[count] ;
      count = 0 ;
      for(Info_int a : list_int) {
        if(a.get_name().equals(which)) {
          info[count] = a ;
          count++ ;
        }
      }
    } else {
      info = new Info_int[1] ;
      info[0] = null ;
    }
    if(info.length == 1 && info[0] == null )return null ; else return info ;
  }
  /**
  clear
  */
  void clear() {
    list_int.clear() ;
  }
  /**
  remove
  */
  void remove(String which) {
    for(int i = 0 ; i < list_int.size() ; i++) {
      Info_int a = list_int.get(i) ;
      if(a.get_name().equals(which)) {
        list_int.remove(i) ;
      }
    }
  }
  
  void remove(int target) {
   if(target < list_int.size()) {
      list_int.remove(target) ;
    }
  }
}


/**
Info_float_dict

*/
public class Info_float_dict extends Info_dict {
  ArrayList<Info_float> list_float ;
  Info_float_dict() {
    super('f') ;
    list_float = new ArrayList<Info_float>() ;
  }

  // add float
  void add(String name, float a) {
    Info_float info = new Info_float(name, a) ;
    list_float.add(info) ;
  }
  void add(String name, float a, float b) {
    Info_float info = new Info_float(name, a,b) ;
    list_float.add(info) ;
  }
  void add(String name, float a, float b, float c) {
    Info_float info = new Info_float(name, a,b,c) ;
    list_float.add(info) ;
  }
  void add(String name, float a, float b, float c, float d) {
    Info_float info = new Info_float(name, a,b,c,d) ;
    list_float.add(info) ;
  }
  void add(String name, float a, float b, float c, float d, float e) {
    Info_float info = new Info_float(name, a,b,c,d,e) ;
    list_float.add(info) ;
  }
  void add(String name, float a, float b, float c, float d, float e, float f) {
    Info_float info = new Info_float(name, a,b,c,d,e,f) ;
    list_float.add(info) ;
  }
  /**
  read
  */
  void read() {
    for(Info a : list_float) {
      println(a, type(a.get_type())) ;
    }
  }
   
  /**
  get
  */
  Info_float get(int target) {
    if(target < list_float.size() && target >= 0) {
      return list_float.get(target) ;
    } else return null ;
  }
  
  Info_float [] get(String which) {
    Info_float [] info  ;
    int count = 0 ;
    for(Info_float a : list_float) {
      if(a.get_name().equals(which)) {
        count++ ;
      }
    }
    if (count > 0 ) {
      info = new Info_float[count] ;
      count = 0 ;
      for(Info_float a : list_float) {
        if(a.get_name().equals(which)) {
          info[count] = a ;
          count++ ;
        }
      }
    } else {
      info = new Info_float[1] ;
      info[0] = null ;
    }
    if(info.length == 1 && info[0] == null )return null ; else return info ;
  }
  /**
  clear
  */
  void clear() {
    list_float.clear() ;
  }
  /**
  remove
  */
  void remove(String which) {
    for(int i = 0 ; i < list_float.size() ; i++) {
      Info a = list_float.get(i) ;
      if(a.get_name().equals(which)) {
        list_float.remove(i) ;
      }
    }
  }
  
  void remove(int target) {
   if(target < list_float.size()) {
      list_float.remove(target) ;
    }
  }
}



/**
Info_String_dict

*/
public class Info_String_dict extends Info_dict {
  ArrayList<Info_String> list_String ;
  Info_String_dict() {
    super('s') ;
    list_String = new ArrayList<Info_String>() ;
  }

  // add String
  void add(String name, String a) {
    Info_String info = new Info_String(name, a) ;
    list_String.add(info) ;
  }
  void add(String name, String a, String b) {
    Info_String info = new Info_String(name, a,b) ;
    list_String.add(info) ;
  }
  void add(String name, String a, String b, String c) {
    Info_String info = new Info_String(name, a,b,c) ;
    list_String.add(info) ;
  }
  void add(String name, String a, String b, String c, String d) {
    Info_String info = new Info_String(name, a,b,c,d) ;
    list_String.add(info) ;
  }
  void add(String name, String a, String b, String c, String d, String e) {
    Info_String info = new Info_String(name, a,b,c,d,e) ;
    list_String.add(info) ;
  }
  void add(String name, String a, String b, String c, String d, String e, String f) {
    Info_String info = new Info_String(name, a,b,c,d,e,f) ;
    list_String.add(info) ;
  }

  
  void read() {
    for(Info a : list_String) {
      println(a, type(a.get_type())) ;
    }
  }
  
  /**
  get
  */
  Info_String get(int target) {
    if(target < list_String.size() && target >= 0) {
      return list_String.get(target) ;
    } else return null ;
  }
  
  Info_String [] get(String which) {
    Info_String [] info  ;
    int count = 0 ;
    for(Info_String a : list_String) {
      if(a.get_name().equals(which)) {
        count++ ;
      }
    }
    if (count > 0 ) {
      info = new Info_String[count] ;
      count = 0 ;
      for(Info_String a : list_String) {
        if(a.get_name().equals(which)) {
          info[count] = a ;
          count++ ;
        }
      }
    } else {
      info = new Info_String[1] ;
      info[0] = null ;
    }
    if(info.length == 1 && info[0] == null )return null ; else return info ;
  }
  /**
  clear
  */
  void clear() {
    list_String.clear() ;
  }
  /**
  remove
  */
  void remove(String which) {
    for(int i = 0 ; i < list_String.size() ; i++) {
      Info_String a = list_String.get(i) ;
      if(a.get_name().equals(which)) {
        list_String.remove(i) ;
      }
    }
  }
  
  void remove(int target) {
   if(target < list_String.size()) {
      list_String.remove(target) ;
    }
  }
}


/**
Info_Vec_dict

*/
public class Info_Vec_dict extends Info_dict {
  ArrayList<Info_Vec> list_Vec ;
  Info_Vec_dict() {
    super('v') ;
    list_Vec = new ArrayList<Info_Vec>() ;
  }

  // add Vec
  void add(String name, Vec a) {
    Info_Vec info = new Info_Vec(name, a) ;
    list_Vec.add(info) ;
  }
  void add(String name, Vec a, Vec b) {
    Info_Vec info = new Info_Vec(name, a,b) ;
    list_Vec.add(info) ;
  }
  void add(String name, Vec a, Vec b, Vec c) {
    Info_Vec info = new Info_Vec(name, a,b,c) ;
    list_Vec.add(info) ;
  }
  void add(String name, Vec a, Vec b, Vec c, Vec d) {
    Info_Vec info = new Info_Vec(name, a,b,c,d) ;
    list_Vec.add(info) ;
  }
  void add(String name, Vec a, Vec b, Vec c, Vec d, Vec e) {
    Info_Vec info = new Info_Vec(name, a,b,c,d,e) ;
    list_Vec.add(info) ;
  }
  void add(String name, Vec a, Vec b, Vec c, Vec d, Vec e, Vec f) {
    Info_Vec info = new Info_Vec(name, a,b,c,d,e,f) ;
    list_Vec.add(info) ;
  }

  
  void read() {
    for(Info a : list_Vec) {
      println(a, type(a.get_type())) ;
    }
  }
  
  /**
  get
  */
  Info_Vec get(int target) {
    if(target < list_Vec.size() && target >= 0) {
      return list_Vec.get(target) ;
    } else return null ;
  }
  
  Info_Vec [] get(String which) {
    Info_Vec [] info  ;
    int count = 0 ;
    for(Info_Vec a : list_Vec) {
      if(a.get_name().equals(which)) {
        count++ ;
      }
    }
    if (count > 0 ) {
      info = new Info_Vec[count] ;
      count = 0 ;
      for(Info_Vec a : list_Vec) {
        if(a.get_name().equals(which)) {
          info[count] = a ;
          count++ ;
        }
      }
    } else {
      info = new Info_Vec[1] ;
      info[0] = null ;
    }
    if(info.length == 1 && info[0] == null )return null ; else return info ;
  }
  /**
  clear
  */
  void clear() {
    list_Vec.clear() ;
  }
  /**
  remove
  */
  void remove(String which) {
    for(int i = 0 ; i < list_Vec.size() ; i++) {
      Info_Vec a = list_Vec.get(i) ;
      if(a.get_name().equals(which)) {
        list_Vec.remove(i) ;
      }
    }
  }
  
  void remove(int target) {
   if(target < list_Vec.size()) {
      list_Vec.remove(target) ;
    }
  }
}



/**

Class Info

*/
interface Info {
  String get_name() ;
  
  Object catch_a() ;
  Object catch_b() ;
  Object catch_c() ;
  Object catch_d() ;
  Object catch_e() ;
  Object catch_f() ;

  char get_type() ;
}
 
abstract class Info_method implements Info {
  String name  ;
  Info_method (String name) {
    this.name = name ;
  }


  String get_name() { 
    return name ;
  }
}


/**
INFO int

*/
class Info_int extends Info_method {
  char type = 'i' ;
  int a, b, c, d, e, f ;
  int num_value ;  
  /**
  int value
  */

  Info_int(String name) {
    super(name) ;
  }

  Info_int(String name, int... var) {
    super(name) ;
    if(var.length > 6 ) num_value = 6 ; else num_value = var.length ;
    if(var.length > 0) this.a = var[0] ;
    if(var.length > 1) this.b = var[1] ;
    if(var.length > 2) this.c = var[2] ;
    if(var.length > 3) this.d = var[3] ;
    if(var.length > 4) this.e = var[4] ;
    if(var.length > 5) this.f = var[5] ;
  }

  /**
  get
  */
  int get_a() { return a ; }
  int get_b() { return b ; }
  int get_c() { return c ; }
  int get_d() { return d ; }
  int get_e() { return e ; }
  int get_f() { return f ; }

  Object catch_a() { return a ; }
  Object catch_b() { return b ; }
  Object catch_c() { return c ; }
  Object catch_d() { return d ; }
  Object catch_e() { return e ; }
  Object catch_f() { return f ; }
  
  char get_type() { return type ; }

  /**
  Print info
  */
  @ Override String toString() {
    if(num_value == 1) {
      return "[ " + name + ": " + a + " ]";
    } else if(num_value == 2) {
      return "[ " + name + ": " + a + ", " + b + " ]";
    } else if(num_value == 3) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + " ]";
    } else if(num_value == 4) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + " ]";
    } else if(num_value == 5) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + " ]";
    } else if(num_value == 6) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + ", " + f + " ]";
    } else {
      return "hmmm hmmm there is problem with your stuff mate";
    }
  }
}

/**
INFO String

*/
class Info_String extends Info_method {
  char type = 's' ;
  String a, b, c, d, e, f ;
  int num_value ;  

  Info_String(String name) {
    super(name) ;
  }

  Info_String(String name, String... var) {
    super(name) ;
    if(var.length > 6 ) num_value = 6 ; else num_value = var.length ;
    if(var.length > 0) this.a = var[0] ;
    if(var.length > 1) this.b = var[1] ;
    if(var.length > 2) this.c = var[2] ;
    if(var.length > 3) this.d = var[3] ;
    if(var.length > 4) this.e = var[4] ;
    if(var.length > 5) this.f = var[5] ;
  }

  /**
  get
  */
  String get_a() { return a ; }
  String get_b() { return b ; }
  String get_c() { return c ; }
  String get_d() { return d ; }
  String get_e() { return e ; }
  String get_f() { return f ; }

  Object catch_a() { return a ; }
  Object catch_b() { return b ; }
  Object catch_c() { return c ; }
  Object catch_d() { return d ; }
  Object catch_e() { return e ; }
  Object catch_f() { return f ; }

  char get_type() { return type ; }

  /**
  Print info
  */
  @ Override String toString() {
    if(num_value == 1) {
      return "[ " + name + ": " + a + " ]";
    } else if(num_value == 2) {
      return "[ " + name + ": " + a + ", " + b + " ]";
    } else if(num_value == 3) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + " ]";
    } else if(num_value == 4) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + " ]";
    } else if(num_value == 5) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + " ]";
    } else if(num_value == 6) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + ", " + f + " ]";
    } else {
      return "hmmm hmmm there is problem with your stuff mate";
    }
  }
}

/**
INFO float

*/
class Info_float extends Info_method {
  char type = 'f' ;
  float a, b, c, d, e, f ;
  int num_value ; 

  Info_float(String name) {
    super(name) ;
  }

  Info_float(String name, float... var) {
    super(name) ;
    if(var.length > 6 ) num_value = 6 ; else num_value = var.length ;
    if(var.length > 0) this.a = var[0] ;
    if(var.length > 1) this.b = var[1] ;
    if(var.length > 2) this.c = var[2] ;
    if(var.length > 3) this.d = var[3] ;
    if(var.length > 4) this.e = var[4] ;
    if(var.length > 5) this.f = var[5] ;
  }


  /**
  get
  */
  float get_a() { return a ; }
  float get_b() { return b ; }
  float get_c() { return c ; }
  float get_d() { return d ; }
  float get_e() { return e ; }
  float get_f() { return f ; }

  Object catch_a() { return a ; }
  Object catch_b() { return b ; }
  Object catch_c() { return c ; }
  Object catch_d() { return d ; }
  Object catch_e() { return e ; }
  Object catch_f() { return f ; }
  
  char get_type() { return type ; }
  /**
  Print info
  */
  @ Override String toString() {
    if(num_value == 1) {
      return "[ " + name + ": " + a + " ]";
    } else if(num_value == 2) {
      return "[ " + name + ": " + a + ", " + b + " ]";
    } else if(num_value == 3) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + " ]";
    } else if(num_value == 4) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + " ]";
    } else if(num_value == 5) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + " ]";
    } else if(num_value == 6) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + ", " + f + " ]";
    } else {
      return "hmmm hmmm there is problem with your stuff mate";
    }
  }
}

/**
INFO Vec
*/
class Info_Vec extends Info_method {
  char type = 'v' ;
  Vec a, b, c, d, e, f ;
  int num_value ;  

  Info_Vec(String name) {
    super(name) ;
  }
  /**
  Vec value
  */
  Info_Vec(String name, Vec... var) {
    super(name) ;
    if(var.length > 6 ) num_value = 6 ; else num_value = var.length ;
    if(var.length > 0) this.a = var[0] ;
    if(var.length > 1) this.b = var[1] ;
    if(var.length > 2) this.c = var[2] ;
    if(var.length > 3) this.d = var[3] ;
    if(var.length > 4) this.e = var[4] ;
    if(var.length > 5) this.f = var[5] ;
  }



  /**
  get
  */
  Vec get_a() { return a ; }
  Vec get_b() { return b ; }
  Vec get_c() { return c ; }
  Vec get_d() { return d ; }
  Vec get_e() { return e ; }
  Vec get_f() { return f ; }

  Object catch_a() { return a ; }
  Object catch_b() { return b ; }
  Object catch_c() { return c ; }
  Object catch_d() { return d ; }
  Object catch_e() { return e ; }
  Object catch_f() { return f ; }
  
  char get_type() { return type ; }
  /**
  Print info
  */
  @ Override String toString() {
    if(num_value == 1) {
      return "[ " + name + ": " + a + " ]";
    } else if(num_value == 2) {
      return "[ " + name + ": " + a + ", " + b + " ]";
    } else if(num_value == 3) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + " ]";
    } else if(num_value == 4) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + " ]";
    } else if(num_value == 5) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + " ]";
    } else if(num_value == 6) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + ", " + f + " ]";
    } else {
      return "hmmm hmmm there is problem with your stuff mate";
    }
  }
}




/**
INFO OBJECT
*/
class Info_obj extends Info_method {
  char type = 'o' ;
  Object a, b, c, d, e, f ;
  int num_value ;

  Info_obj(String name) {
    super(name) ;
  }

  /**
  Object value
  */
  Info_obj(String name, Object... var) {
    super(name) ;
    if(var.length > 6 ) num_value = 6 ; else num_value = var.length ;
    if(var.length > 0) this.a = var[0] ;
    if(var.length > 1) this.b = var[1] ;
    if(var.length > 2) this.c = var[2] ;
    if(var.length > 3) this.d = var[3] ;
    if(var.length > 4) this.e = var[4] ;
    if(var.length > 5) this.f = var[5] ;
  }


  /**
  get
  */
  Object get_a() { return a ; }
  Object get_b() { return b ; }
  Object get_c() { return c ; }
  Object get_d() { return d ; }
  Object get_e() { return e ; }
  Object get_f() { return f ; }

  Object catch_a() { return a ; }
  Object catch_b() { return b ; }
  Object catch_c() { return c ; }
  Object catch_d() { return d ; }
  Object catch_e() { return e ; }
  Object catch_f() { return f ; }
  
  char get_type() { return type ; }

  /**
  Print info
  */
  @ Override String toString() {
    if(num_value == 1) {
      return "[ " + name + ": " + a + " ]";
    } else if(num_value == 2) {
      return "[ " + name + ": " + a + ", " + b + " ]";
    } else if(num_value == 3) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + " ]";
    } else if(num_value == 4) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + " ]";
    } else if(num_value == 5) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + " ]";
    } else if(num_value == 6) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + ", " + f + " ]";
    } else {
      return "hmmm hmmm there is problem with your stuff mate";
    }
  }
}












/**
Random around value
*/

float random_gaussian(float value) {
  float distrib = random(-1, 1) ;
  return (pow(distrib,5)) *(value*.4) +value ;
}





/**
MAP
map the value between the min and the max
@ return float
*/
float map_cycle(float value, float min, float max) {
  max += .000001 ;
  float newValue ;
  if(min < 0 && max >= 0 ) {
    float tempMax = max +abs(min) ;
    value += abs(min) ;
    float tempMin = 0 ;
    newValue =  tempMin +abs(value)%(tempMax - tempMin)  ;
    newValue -= abs(min) ;
    return newValue ;
  } else if ( min < 0 && max < 0) {
    newValue = abs(value)%(abs(max)+min) -max ;
    return newValue ;
  } else {
    newValue = min + abs(value)%(max - min) ;
    return newValue ;
  }
}




/*
map the value between the min and the max, but this value is lock between the min and the max
@ return float
*/
float map_locked(float value, float sourceMin, float sourceMax, float targetMin, float targetMax) {
  if(sourceMax >= targetMax ) sourceMax = targetMax ;
  if (value < sourceMin ) value = sourceMin ;
  if (value > sourceMax ) value = sourceMax ;
  float newMax = sourceMax - sourceMin ;
  float deltaTarget = targetMax - targetMin ;
  float ratio = ((value - sourceMin) / newMax ) ;
  float result = targetMin +deltaTarget *ratio;
  return result; 
}

// to map not linear, start the curve slowly to finish hardly
float map_smooth_start(float value, float sourceMin, float sourceMax, float targetMin, float targetMax, int level) {
  if (value < sourceMin ) value = sourceMin ;
  if (value > sourceMax ) value = sourceMax ;
  float newMax = sourceMax - sourceMin ;
  float deltaTarget = targetMax - targetMin ;
  float ratio = ((value - sourceMin) / newMax ) ;
  ratio = pow(ratio, level) ;
  float result = targetMin +deltaTarget *ratio;
  return result;
}

// to map not linear, start the curve hardly to finish slowly
float map_smooth_end(float value, float sourceMin, float sourceMax, float targetMin, float targetMax, int level) {
  if (value < sourceMin ) value = sourceMin ;
  if (value > sourceMax ) value = sourceMax ;
  float newMax = sourceMax - sourceMin ;
  float deltaTarget = targetMax - targetMin ;
  float ratio = ((value - sourceMin) / newMax ) ;
  // ratio = roots(ratio, level) ; // the method roots is use in math util
  ratio = pow(ratio, 1.0/level) ;
  float result = targetMin +deltaTarget *ratio;
  return result;
}

// to map not linear, like a "S"
float map_smooth(float value, float sourceMin, float sourceMax, float targetMin, float targetMax, int level) {
  if (value < sourceMin ) value = sourceMin ;
  if (value > sourceMax ) value = sourceMax ;
  float newMax = sourceMax - sourceMin ;
  float deltaTarget = targetMax - targetMin ;
  float ratio = ((value - sourceMin) / newMax ) ;
  ratio = map(ratio,0,1, -1, 1 ) ;
  int correction = 1 ;
  if(level % 2 == 1 ) correction = 1 ; else correction = -1 ;
  if (ratio < 0 ) ratio = pow(ratio, level) *correction  ; else ratio = pow(ratio, level)  ;
  ratio = map(ratio, -1,1, 0,1) ;
  float result = targetMin +deltaTarget *ratio;
  return result;
}
// END MAP
//////////












/**
CHECK

*/


/**
Check renderer
*/
boolean renderer_P3D() {
  if(get_renderer_name(getGraphics()).equals("processing.opengl.PGraphics3D")) return true ; else return false ;
}


String get_renderer_name(final PGraphics graph) {
  try {
    if (Class.forName(JAVA2D).isInstance(graph))  return JAVA2D;
    if (Class.forName(FX2D).isInstance(graph))    return FX2D;
    if (Class.forName(P2D).isInstance(graph))     return P2D;
    if (Class.forName(P3D).isInstance(graph))     return P3D;
    if (Class.forName(PDF).isInstance(graph))     return PDF;
    if (Class.forName(DXF).isInstance(graph))     return DXF;
  }

  catch (ClassNotFoundException ex) {
  }
  return "Unknown";
}


/**
Check Type
*/
public String object_type(Object t) {
  String type = "Type unknow" ;
  if(t instanceof Integer) {
    type = ("Integer") ;
  } else if(t instanceof Float) {
    type = ("Float") ;
  } else if(t instanceof String) {
    type = ("String") ;
  } else if(t instanceof Double) {
    type = ("Double") ;
  } else if(t instanceof Long) {
    type = ("Long") ;
  } else if(t instanceof Short) {
    type = ("Short") ;
  } else if(t instanceof Boolean) {
    type = ("Boolean") ;
  } else if(t instanceof Byte) {
    type = ("Byte") ;
  } else if(t instanceof Character) {
    type = ("Character") ;
  }else {
    type = ("Type unknow") ;
  }
  return type ;
}























/**
TRANSLATOR INT to String, FLOAT to STRING 0.0.3
*/
//truncate
float truncate( float x ) {
    return round( x * 100.0f ) / 100.0f;
}
//Int to String with array list
/*
@ return String
*/
String join_int_to_String(int []data) {
  String intString ;
  String [] dataString = new String [data.length] ;
  for ( int i = 0 ; i < data.length ; i++) dataString[i] = Integer.toString(data[i]) ;
  intString = join(dataString,"/") ;
  
  return intString ;
}

//float to String with array list
String join_float_to_String(float []data) {
  String floatString ;
  String [] dataString = new String [data.length] ;
  //for ( int i = 0 ; i < data.length ; i++) dataString[i] = Float.toString(data[i]) ;
  //we must use just one decimal after coma, to dodge the outBoundIndex blablabla
  for ( int i = 0 ; i < data.length ; i++) dataString[i] = String.format("%.1f" ,data[i]) ;
  floatString = join(dataString,"/") ;
  
  return floatString ;
}

//Translater to String
// float to String
String float_to_String_1(float data) {
  String float_string_value ;
  float_string_value = String.format("%.1f", data ) ;
  return float_String(float_string_value) ;
}
//
String float_to_String_2(float data) {
  String float_string_value ;
  float_string_value = String.format("%.2f", data ) ;
  return float_String(float_string_value) ;
}
//
String float_to_String_3(float data) {
  String float_string_value ;
  float_string_value = String.format("%.3f", data ) ;
  return float_String(float_string_value) ;
}

//
String float_to_String_4(float data) {
  String float_string_value ;
  float_string_value = String.format("%.4f", data ) ;
  return float_String(float_string_value) ;
}
// local
String float_String(String value) {
  if(value.contains(".")) {
    return value ;
  } else {
    String [] temp = split(value, ",") ;
    value = temp[0] +"." + temp[1] ;
    return value ;
  }
}


// int to String
String int_to_String(int data) {
  String float_string_value ;
  float_string_value = Integer.toString(data ) ;
  return float_string_value ;
}

//END TRANSLATOR
///////////////
























/**
STRING UTILS
*/

//STRING SPLIT
String [] split_text(String textToSplit, String separator) {
  String [] text = textToSplit.split(separator) ;
  return text  ;
}


//STRING COMPARE LIST SORT
//raw compare
int longest_word( String[] listWordsToSort) {
  int sizeWord = 0 ;
  for ( int i = 0 ; i < listWordsToSort.length ; i++) {
    if (listWordsToSort[i].length() > sizeWord )  sizeWord = listWordsToSort[i].length() ;
  }
  return  sizeWord ;
}
//with starting and end keypoint in the String must be sort
int longest_word( String[] listWordsToSort, int start, int finish ) {
  int sizeWord = 0 ;

  for ( int i = start ; i < finish ; i++) {
    if (listWordsToSort[i].length() > sizeWord )  sizeWord = listWordsToSort[i].length() ;
  }
  return  sizeWord ;
}



// with the same size_text for each line
int longest_word_in_pixel(String[] listWordsToSort, int size_font) {
  int sizeWord = 0 ;
  for ( int i = 0 ; i < listWordsToSort.length ; i++) {
    if (width_String(listWordsToSort[i], size_font) > sizeWord )  sizeWord = width_String(listWordsToSort[i],size_font) ;
  }
  return  sizeWord ;
}

// with the same size_text for each line, choice the which line you check
int longest_word_in_pixel( String[] listWordsToSort, int size_font, int start, int finish ) {
  int sizeWord = 0 ;
  for ( int i = start ; i <= finish ; i++) {
    if (width_String(listWordsToSort[i], size_font) > sizeWord )  sizeWord = width_String(listWordsToSort[i],size_font) ;
  }
  return  sizeWord ;
}

// with list of size_text for each line
int longest_word_in_pixel( String[] listWordsToSort, int [] size_font) {
  int sizeWord = 0 ;
  for ( int i = 0 ; i < listWordsToSort.length ; i++) {
    if (width_String(listWordsToSort[i], size_font[i]) > sizeWord )  sizeWord = width_String(listWordsToSort[i],size_font[i]) ;
  }
  return  sizeWord ;
}

// with list of size_text for each line, choice the which line you check
int longest_word_in_pixel( String[] listWordsToSort, int [] size_font, int start, int finish ) {
  int sizeWord = 0 ;
  for ( int i = start ; i <= finish ; i++) {
    if (width_String(listWordsToSort[i], size_font[i]) > sizeWord )  sizeWord = width_String(listWordsToSort[i],size_font[i]) ;
  }
  return  sizeWord ;
}




import java.awt.Font; 
import java.awt.image.BufferedImage ;
import java.awt.FontMetrics ;

int width_String(String target, int size) {
  return width_String("defaultFont", target, size) ;
}


int width_String(String font_name, String target, int size) {
  Font font = new Font(font_name, Font.BOLD, size) ;
  BufferedImage img = new BufferedImage(1, 1, BufferedImage.TYPE_INT_ARGB);
  FontMetrics fm = img.getGraphics().getFontMetrics(font);
  return fm.stringWidth(target);
}


int width_char(char target, int size) {
  return width_char("defaultFont", target, size) ;
}

int width_char(String font_name, char target, int size) {
  Font font = new Font(font_name, Font.BOLD, size) ;
  BufferedImage img = new BufferedImage(1, 1, BufferedImage.TYPE_INT_ARGB);
  FontMetrics fm = img.getGraphics().getFontMetrics(font);
  return fm.charWidth(target);
}





// Research a specific word in String
boolean research_in_String(String research, String target) {
  boolean result = false ;
  for(int i = 0 ; i < target.length() - research.length() +1; i++) {
    result = target.regionMatches(i,research,0,research.length()) ;
    if (result) break ;
  }
  return result ;
}





// remove the path of your file
String file_name(String s) {
  String file_name = "" ;
  String [] split_path = s.split("/") ;
  file_name = split_path[split_path.length -1] ;
  return file_name ;
}