/**
RPE UTILS 1.21.0.1
Rope – Romanesco Processing Environment – 2015–2016
* @author Stan le Punk
* @see https://github.com/StanLepunK/Utils_rope
*/

/**
CONSTANT NUMBER must be here to be generate before all

*/
final float PHI = (1 + sqrt(5))/2; //a number of polys use the golden ratio...
final float ROOT2 = sqrt(2); //...and the square root of two, the famous first irrationnal number by Pythagore
final float EULER = 2.718281828459045235360287471352; // Constant d'Euler
// about constant https://en.wikipedia.org/wiki/Mathematical_constant

/**
COLOR 0.0.1
I MUST clean the Z_Color of Romanesco and keed what is good 
*/
// camaieu
// return hue or other date in range of specific data float
int camaieu(int max, float colorRef, int range) {
  float camaieu = 0 ;
  float whichColor = random(-range, range) ;
  camaieu = colorRef +whichColor ;
  if(camaieu < 0 ) camaieu = max +camaieu ;
  if(camaieu > max) camaieu = camaieu -max ;
 
  return (int)camaieu ;
}



boolean alpha_range(float min, float max, int colour) {
  float alpha = alpha(colour) ;
  return in_range(min, max, alpha) ;
}

boolean red_range(float min, float max, int colour) {
  float  r = alpha(colour) ;
  return in_range(min, max, r) ;
}

boolean green_range(float min, float max, int colour) {
  float  g = alpha(colour) ;
  return in_range(min, max, g) ;
}

boolean blue_range(float min, float max, int colour) {
  float  b = alpha(colour) ;
  return in_range(min, max, b) ;
}

boolean saturation_range(float min, float max, int colour) {
  float  s = alpha(colour) ;
  return in_range(min, max, s) ;
}

boolean brightness_range(float min, float max, int colour) {
  float  b = alpha(colour) ;
  return in_range(min, max, b) ;
}


boolean hue_range(float min, float max, int colour) {
  int c_m = g.colorMode ;
  float c_x = g.colorModeX ;
  float c_y = g.colorModeY ;
  float c_z = g.colorModeZ ;
  float c_a = g.colorModeA ;
  colorMode(HSB, c_x, c_y, c_z, c_a) ;
  float  h = hue(colour) ;

  boolean result = false ;
  // test for the wheel value, hue is one of them ;
  result = in_range_wheel(min, max, c_x, h) ;
  // return to the current colorMode
  colorMode(c_m, c_x, c_y, c_z, c_a) ;
  return result ;
}


















/**
EXPORT FILE PDF_PNG 0.0.2

*/
// global PDF / PNG
String default_folder_shot_pdf = "pdf_folder" ;
String default_folder_shot_png = "png_folder" ;
String default_name_pdf = "pdf_file_" ;
String default_name_png = "png_file_" ;
String ranking_shot = "_######" ;

void start_shot(String path_folder, String name_file) {
  start_PDF(path_folder, name_file) ;
  start_PNG(path_folder, name_file) ;
}

void start_shot(String name_file) {
  start_PDF(default_folder_shot_pdf, name_file) ;
  start_PNG(default_folder_shot_png, name_file) ;
}

void start_shot() {
  start_PDF() ;
  // start_PNG() ;
}

void save_shot() {
  stop_PDF() ;
  save_PNG() ;
}
void event_shot() {
  event_PNG() ;
  event_PDF() ;
}




// PDF
import processing.pdf.*;
boolean record_PDF;
void start_PDF() {
  start_PDF(default_folder_shot_pdf, default_name_pdf+ranking_shot) ;
}

void start_PDF(String name_file) {
  start_PDF(default_folder_shot_pdf, name_file) ;
}
void start_PDF(String path_folder, String name_file) {
  if (record_PDF && !record_PNG) {
    if(renderer_P3D()) {
      beginRaw(PDF, path_folder+"/"+name_file+".pdf"); 
    } else {
      beginRecord(PDF, path_folder+"/"+name_file+".pdf");
    }
  }
}

void stop_PDF() {
  if (record_PDF && !record_PNG) {
    if(renderer_P3D()) {
      endRaw(); 
    } else {
      endRecord() ;
    }
    record_PDF = false;
  }
}

void event_PDF() {
  record_PDF = true;
}




// PNG
boolean record_PNG ;
boolean naming_PNG ;
String path_folder_png, name_file_png  ;

void start_PNG(String path_folder, String name_file) {
  path_folder_png = path_folder ;
  name_file_png = name_file ;
  naming_PNG = true ;
}

void save_PNG() {
  if(record_PNG) {
    if(!naming_PNG) {
      saveFrame(default_folder_shot_png +"/"+ default_name_png + ranking_shot+".png");
    } else {
      saveFrame(path_folder_png +"/"+ name_file_png +".png");
    }
    record_PNG = false ;
  }
}

void event_PNG() {
  record_PNG = true;
}

/**
END EXPORT FILE PDF / PNG
*/



















/**
Rope – Romanesco Processing environment – 
BACKGROUND_2D_3D 0.1.0
* @author Stan le Punk
* @see other Processing work on https://github.com/StanLepunK
*/

float MAX_RATIO_DEPTH = 6.9 ;
// int MAX_DEPTH = 1000 ;

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
  rectMode(CORNER) ;
  float x = map(r_c,0,1, 0, g.colorModeX) ;
  float y = map(g_c,0,1, 0, g.colorModeY) ;
  float z = map(b_c,0,1, 0, g.colorModeZ) ;
  float a = map(a_c,0,1, 0, g.colorModeA) ;
  noStroke() ;
  fill(x, y, z, a) ;
  Vec2 canvas_bg = Vec2(width, height) ;
  if(renderer_P3D()) {
    canvas_bg.mult(100) ;
    Vec2 pos_bg = Vec2(canvas_bg) ;
    pos_bg.mult(-1) ;
    pos_bg.div(2) ;
    // this problem of depth is not clarify, is must refactoring
    float depth  = int(height *MAX_RATIO_DEPTH)  ;
    // if(depth > MAX_DEPTH) depth = MAX_DEPTH ;

    pushMatrix() ;
    translate(pos_bg.x,pos_bg.y,-depth) ;
    rect(Vec2(0),canvas_bg) ;
    popMatrix() ;
  } else {
    rect(Vec2(0),canvas_bg) ;
  }
  // HSB mode
  if(g.colorMode == 3) {
    fill(0, 0, g.colorModeZ) ;
    stroke(0) ;
  // RGB MODE
  } else if (g.colorMode == 1) {
    fill(g.colorModeX, g.colorModeY, g.colorModeZ) ;
    stroke(0) ;
  }
  strokeWeight(1) ; 
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
          for(int k = 1 ; k < 7 ; k++) {
            if(table.getColumnCount() > k && info[j].catch_obj(k-1) != null)  write_row(rows[i], table.getColumnTitle(k), info[j].catch_obj(k-1)) ;
          }
        }
        
      }
    }
  }
}


void setRow(Table table, Info_obj info) {
  TableRow result = table.findRow(info.get_name(), table.getColumnTitle(0)) ;
  if(result != null) {
    for(int k = 1 ; k < 7 ; k++) {
      if(table.getColumnCount() > k && info.catch_obj(k-1) != null)  write_row(result, table.getColumnTitle(k), info.catch_obj(k-1)) ;
    }
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
Info_dict 0.2.3

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

   // size
   int size() {
    return list.size() ;
   }

  // read
  void read() {
    for(Info a : list) {
      println(a, type(type_list)) ;
    }
  }

  // check type
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
  

  // get
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

  // clear
  void clear() {
    list.clear() ;
  }

  // remove
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


  // size
  int size() {
    return list_int.size() ;
  }

  // read
  void read() {
    for(Info a : list_int) {
      println(a, type(a.get_type())) ;
    }
  }
  

  // get
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

  // clear
  void clear() {
    list_int.clear() ;
  }

  // remove
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

  // size
  int size() {
    return list_float.size() ;
  }

  //read
  void read() {
    for(Info a : list_float) {
      println(a, type(a.get_type())) ;
    }
  }
   

  // get
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

  // clear
  void clear() {
    list_float.clear() ;
  }

  // remove
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

  // size
  int size() {
    return list_String.size() ;
  }

  //read
  void read() {
    for(Info a : list_String) {
      println(a, type(a.get_type())) ;
    }
  }
  

  // get
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

  // clear
  void clear() {
    list_String.clear() ;
  }

  // remove
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

  // size
  int size() {
    return list_Vec.size() ;
  }

  //read
  void read() {
    for(Info a : list_Vec) {
      println(a, type(a.get_type())) ;
    }
  }
  

  // get
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

  // clear
  void clear() {
    list_Vec.clear() ;
  }

  // remove
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
Info 0.1.0

*/
interface Info {
  String get_name() ;

  Object [] catch_all() ;
  Object catch_obj(int arg) ;

  char get_type() ;
}
 
abstract class Info_method implements Info {
  String name  ;
  // error message
  String error_target = "Your target is beyond of my knowledge !" ;
  String error_value = "This value is beyond of my power mate !" ;
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


  // get
  int [] get_all() {
    int [] list = new int[]{a,b,c,d,e,f} ;
    return list ;
  }

  int get(int which) {
    if(which == 0) {
      return a ; 
    } else if(which == 1) {
      return b ;
    } else if(which == 2) {
      return c ;
    } else if(which == 3) {
      return d ;
    } else if(which == 4) {
      return e ;
    } else if(which == 5) {
      return f ;
    } else {
      System.err.println(error_target) ;
      return 0 ;
    } 
  }
  
  Object [] catch_all() {
    Object [] list = new Object[]{a,b,c,d,e,f} ;
    return list ;
  }

  Object catch_obj(int which) {
    if(which == 0) {
      return a ; 
    } else if(which == 1) {
      return b ;
    } else if(which == 2) {
      return c ;
    } else if(which == 3) {
      return d ;
    } else if(which == 4) {
      return e ;
    } else if(which == 5) {
      return f ;
    } else {
      System.err.println(error_target) ;
      return null ;
    } 
  }
  
  char get_type() { return type ; }

  // Print info
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
      System.err.println(error_value) ;
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


  // get
  String [] get_all() {
    String [] list = new String[]{a,b,c,d,e,f} ;
    return list ;
  }

  String get(int which) {
    if(which == 0) {
      return a ; 
    } else if(which == 1) {
      return b ;
    } else if(which == 2) {
      return c ;
    } else if(which == 3) {
      return d ;
    } else if(which == 4) {
      return e ;
    } else if(which == 5) {
      return f ;
    } else {
      System.err.println(error_target) ;
      return null ;
    }
  }
  
  Object [] catch_all() {
    Object [] list = new Object[]{a,b,c,d,e,f} ;
    return list ;
  }

  Object catch_obj(int which) {
    if(which == 0) {
      return a ; 
    } else if(which == 1) {
      return b ;
    } else if(which == 2) {
      return c ;
    } else if(which == 3) {
      return d ;
    } else if(which == 4) {
      return e ;
    } else if(which == 5) {
      return f ;
    } else {
      System.err.println(error_target) ;
      return null ;
    }
  }

  char get_type() { return type ; }


  // Print info
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
      System.err.println(error_value) ;
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

  // get
  float [] get_all() {
    float [] list = new float[]{a,b,c,d,e,f} ;
    return list ;
  }

  float get(int which) {
    if(which == 0) {
      return a ; 
    } else if(which == 1) {
      return b ;
    } else if(which == 2) {
      return c ;
    } else if(which == 3) {
      return d ;
    } else if(which == 4) {
      return e ;
    } else if(which == 5) {
      return f ;
    } else {
      System.err.println(error_target) ;
      return 0.0 ;
    }
  }
  
  Object [] catch_all() {
    Object [] list = new Object[]{a,b,c,d,e,f} ;
    return list ;
  }

  Object catch_obj(int which) {
    if(which == 0) {
      return a ; 
    } else if(which == 1) {
      return b ;
    } else if(which == 2) {
      return c ;
    } else if(which == 3) {
      return d ;
    } else if(which == 4) {
      return e ;
    } else if(which == 5) {
      return f ;
    } else {
      System.err.println(error_target) ;
      return null ;
    }
  }

  char get_type() { return type ; }
  
  // Print info
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
      System.err.println(error_value) ;
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

  // Vec value
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




  // get
  Vec [] get_all() {
    Vec [] list = new Vec[]{a,b,c,d,e,f} ;
    return list ;
  }

  Vec get(int which) {
    if(which == 0) {
      return a ; 
    } else if(which == 1) {
      return b ;
    } else if(which == 2) {
      return c ;
    } else if(which == 3) {
      return d ;
    } else if(which == 4) {
      return e ;
    } else if(which == 5) {
      return f ;
    } else {
      System.err.println(error_target) ;
      return null ;
    }
  }
  
  Object [] catch_all() {
    Object [] list = new Object[]{a,b,c,d,e,f} ;
    return list ;
  }

  Object catch_obj(int which) {
    if(which == 0) {
      return a ; 
    } else if(which == 1) {
      return b ;
    } else if(which == 2) {
      return c ;
    } else if(which == 3) {
      return d ;
    } else if(which == 4) {
      return e ;
    } else if(which == 5) {
      return f ;
    } else {
      System.err.println(error_target) ;
      return null ;
    }
  }

  char get_type() { return type ; }

  // Print info
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
      System.err.println(error_value) ;
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


  // Object value
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


  // get
  Object [] get_all() {
    Object [] list = new Object []{a,b,c,d,e,f} ;
    return list ;
  }

  Object get(int which) {
    if(which == 0) {
      return a ; 
    } else if(which == 1) {
      return b ;
    } else if(which == 2) {
      return c ;
    } else if(which == 3) {
      return d ;
    } else if(which == 4) {
      return e ;
    } else if(which == 5) {
      return f ;
    } else {
      System.err.println(error_target) ;
      return null ;
    }
  }
  
  Object [] catch_all() {
    Object [] list = new Object[]{a,b,c,d,e,f} ;
    return list ;
  }

  Object catch_obj(int which) {
    if(which == 0) {
      return a ; 
    } else if(which == 1) {
      return b ;
    } else if(which == 2) {
      return c ;
    } else if(which == 3) {
      return d ;
    } else if(which == 4) {
      return e ;
    } else if(which == 5) {
      return f ;
    } else {
      System.err.println(error_target) ;
      return null ;
    }
  }
  
  char get_type() { return type ; }


  // Print info
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
      System.err.println(error_value) ;
      return "hmmm hmmm there is problem with your stuff mate";
    }
  }
}
/**
END INFO LIST

*/























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
MISC


*/

/**
Random around value
*/

float random_gaussian(float value) {
  float distrib = random(-1, 1) ;
  return (pow(distrib,5)) *(value*.4) +value ;
}









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
check value in range
*/
boolean in_range(float min, float max, float value) {
  if(value <= max && value >= min) {
    return true ; 
  } else {
    return false ;
  }
}

boolean in_range_wheel(float min, float max, float roof_max, float value) {
  if(value <= max && value >= min) {
    return true ;
  } else {
    // wheel value
    if(max > roof_max ) {
      // test hight value
      if(value <= (max - roof_max)) {
        return true ;
      } 
    } 
    if (min < 0) {
      // here it's + min 
      if(value >= (roof_max + min)) {
        return true ;
      } 
    } 
    return false ;
  }
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