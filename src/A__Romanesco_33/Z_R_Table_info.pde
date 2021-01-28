/**
* TABLE METHOD
* v 0.0.4
* 2016-2020
* for Table with the first COLLUMN is used for name and the next 6 for the value.
*The method is used with the Class Info
*
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

void setTable(Table table, TableRow [] rows, Info_Object... info) {
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


void setRow(Table table, Info_Object info) {
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
Info_dict 
v 0.3.0.1
*/
public class Info_dict {
  ArrayList<Info> list;
  char type_list = 'o';

  Info_dict(char type_list) {
    this.type_list = type_list;
  }

  Info_dict() {
    list = new ArrayList<Info>();
  }

  // add Object
  void add(String name, Object a) {
    Info_Object info = new Info_Object(name,a);
    list.add(info);
  }
  void add(String name, Object a, Object b) {
    Info_Object info = new Info_Object(name,a,b);
    list.add(info);
  }
  void add(String name, Object a, Object b, Object c) {
    Info_Object info = new Info_Object(name,a,b,c);
    list.add(info);
  }
  void add(String name, Object a, Object b, Object c, Object d) {
    Info_Object info = new Info_Object(name,a,b,c,d);
    list.add(info);
  }
  void add(String name, Object a, Object b, Object c, Object d, Object e) {
    Info_Object info = new Info_Object(name,a,b,c,d,e);
    list.add(info);
  }
  void add(String name, Object a, Object b, Object c, Object d, Object e, Object f) {
    Info_Object info = new Info_Object(name,a,b,c,d,e,f);
    list.add(info);
  }
  void add(String name, Object a, Object b, Object c, Object d, Object e, Object f, Object g) {
    Info_Object info = new Info_Object(name,a,b,c,d,e,f,g);
    list.add(info);
  }

   // size
   int size() {
    return list.size();
   }

  // read
  void read() {
    println("Object list");
    for(Info a : list) {
      if(a instanceof Info_Object) {
        Info_Object obj = (Info_Object)a ;
        if(obj.a != null && obj.b == null && obj.c == null && obj.d == null && obj.e == null && obj.f == null && obj.g == null) {
          println(a,get_type(obj.a));   
        }
        if(obj.a != null && obj.b != null && obj.c == null && obj.d == null && obj.e == null && obj.f == null && obj.g == null) {
          println(a,get_type(obj.a),get_type(obj.b));   
        }
        if(obj.a != null && obj.b != null && obj.c != null && obj.d == null && obj.e == null && obj.f == null && obj.g == null) {
          println(a,get_type(obj.a),get_type(obj.b),get_type(obj.c));   
        }
        if(obj.a != null && obj.b != null && obj.c != null && obj.d != null && obj.e == null && obj.f == null && obj.g == null) {
          println(a,get_type(obj.a),get_type(obj.b),get_type(obj.c),get_type(obj.d));   
        }
        if(obj.a != null && obj.b != null && obj.c != null && obj.d != null && obj.e != null && obj.f == null && obj.g == null) {
          println(a,get_type(obj.a),get_type(obj.b),get_type(obj.c),get_type(obj.d),get_type(obj.e));   
        }
        if(obj.a != null && obj.b != null && obj.c != null && obj.d != null && obj.e != null && obj.f != null && obj.g == null) {
          println(a,get_type(obj.a),get_type(obj.b),get_type(obj.c),get_type(obj.d),get_type(obj.e),get_type(obj.f));   
        }
        if(obj.a != null && obj.b != null && obj.c != null && obj.d != null && obj.e != null && obj.f != null && obj.g != null) {
          println(a,get_type(obj.a),get_type(obj.b),get_type(obj.c),get_type(obj.d),get_type(obj.e),get_type(obj.f),get_type(obj.g));   
        }      
      }
    }
  }

  // get
  Info get(int target) {
    if(target < list.size() && target >= 0) {
      return list.get(target);
    } else return null;
  }
  
  Info [] get(String which) {
    Info [] info;
    int count = 0;
    for(Info a : list) {
      if(a.get_name().equals(which)) {
        count++;
      }
    }
    if (count > 0 ) {
      info = new Info[count] ;
      count = 0;
      for(Info a : list) {
        if(a.get_name().equals(which)) {
          info[count] = a;
          count++;
        }
      }
    } else {
      info = new Info_String[1];
      info[0] = null;
    }
    if(info.length == 1 && info[0] == null )return null ; else return info;
  }

  // clear
  void clear() {
    list.clear();
  }

  // remove
  void remove(String which) {
    for(int i = 0 ; i < list.size() ; i++) {
      Info a = list.get(i);
      if(a.get_name().equals(which)) {
        list.remove(i);
      }
    }
  }
  
  void remove(int target) {
   if(target < list.size()) {
      list.remove(target);
    }
  }
}

/**
Info_int_dict
v 0.0.2
*/

public class Info_int_dict extends Info_dict {
  ArrayList<Info_int> list_int;
  Info_int_dict() {
    super('i');
    list_int = new ArrayList<Info_int>();
  }


  // add int
  void add(String name, int a) {
    Info_int info = new Info_int(name,a);
    list_int.add(info);
  } 
  void add(String name, int a, int b) {
    Info_int info = new Info_int(name,a,b);
    list_int.add(info);
  } 

  void add(String name, int a, int b, int c) {
    Info_int info = new Info_int(name,a,b,c);
    list_int.add(info);
  } 
  void add(String name, int a, int b, int c, int d) {
    Info_int info = new Info_int(name, a,b,c,d);
    list_int.add(info);
  } 
  void add(String name, int a, int b, int c, int d, int e) {
    Info_int info = new Info_int(name,a,b,c,d,e);
    list_int.add(info);
  } 
  void add(String name, int a, int b, int c, int d, int e, int f) {
    Info_int info = new Info_int(name,a,b,c,d,e,f);
    list_int.add(info);
  }
  void add(String name, int a, int b, int c, int d, int e, int f, int g) {
    Info_int info = new Info_int(name,a,b,c,d,e,f,g);
    list_int.add(info);
  }


  // size
  int size() {
    return list_int.size() ;
  }

  // read
  void read() {
    println("Integer list");
    for(Info a : list_int) {
      println(a,"Integer");
    }
  }
  

  // get
  Info_int get(int target) {
    if(target < list_int.size() && target >= 0) {
      return list_int.get(target);
    } else return null;
  }
  
  Info_int [] get(String which) {
    Info_int [] info  ;
    int count = 0;
    for(Info_int a : list_int) {
      if(a.get_name().equals(which)) {
        count++;
      }
    }
    if (count > 0 ) {
      info = new Info_int[count] ;
      count = 0 ;
      for(Info_int a : list_int) {
        if(a.get_name().equals(which)) {
          info[count] = a;
          count++;
        }
      }
    } else {
      info = new Info_int[1] ;
      info[0] = null;
    }
    if(info.length == 1 && info[0] == null )return null ; else return info ;
  }

  // clear
  void clear() {
    list_int.clear();
  }

  // remove
  void remove(String which) {
    for(int i = 0 ; i < list_int.size() ; i++) {
      Info_int a = list_int.get(i) ;
      if(a.get_name().equals(which)) {
        list_int.remove(i);
      }
    }
  }
  
  void remove(int target) {
   if(target < list_int.size()) {
      list_int.remove(target);
    }
  }
}

/**
Info_float_dict
v 0.0.2
*/
public class Info_float_dict extends Info_dict {
  ArrayList<Info_float> list_float ;
  Info_float_dict() {
    super('f');
    list_float = new ArrayList<Info_float>();
  }

  // add float
  void add(String name, float a) {
    Info_float info = new Info_float(name,a);
    list_float.add(info);
  }
  void add(String name, float a, float b) {
    Info_float info = new Info_float(name,a,b);
    list_float.add(info);
  }
  void add(String name, float a, float b, float c) {
    Info_float info = new Info_float(name,a,b,c);
    list_float.add(info);
  }
  void add(String name, float a, float b, float c, float d) {
    Info_float info = new Info_float(name,a,b,c,d);
    list_float.add(info);
  }
  void add(String name, float a, float b, float c, float d, float e) {
    Info_float info = new Info_float(name,a,b,c,d,e);
    list_float.add(info);
  }
  void add(String name, float a, float b, float c, float d, float e, float f) {
    Info_float info = new Info_float(name,a,b,c,d,e,f);
    list_float.add(info);
  }
  void add(String name, float a, float b, float c, float d, float e, float f, float g) {
    Info_float info = new Info_float(name,a,b,c,d,e,f,g);
    list_float.add(info);
  }

  // size
  int size() {
    return list_float.size() ;
  }

  //read
  void read() {
    println("Float list");
    for(Info a : list_float) {
      println(a,"Float");
    }
  }
   

  // get
  Info_float get(int target) {
    if(target < list_float.size() && target >= 0) {
      return list_float.get(target);
    } else return null;
  }
  
  Info_float [] get(String which) {
    Info_float [] info;
    int count = 0;
    for(Info_float a : list_float) {
      if(a.get_name().equals(which)) {
        count++;
      }
    }
    if (count > 0 ) {
      info = new Info_float[count] ;
      count = 0 ;
      for(Info_float a : list_float) {
        if(a.get_name().equals(which)) {
          info[count] = a;
          count++;
        }
      }
    } else {
      info = new Info_float[1] ;
      info[0] = null;
    }
    if(info.length == 1 && info[0] == null )return null ; else return info ;
  }

  // clear
  void clear() {
    list_float.clear();
  }

  // remove
  void remove(String which) {
    for(int i = 0 ; i < list_float.size() ; i++) {
      Info a = list_float.get(i) ;
      if(a.get_name().equals(which)) {
        list_float.remove(i);
      }
    }
  }
  
  void remove(int target) {
   if(target < list_float.size()) {
      list_float.remove(target);
    }
  }
}



/**
Info_String_dict

*/
public class Info_String_dict extends Info_dict {
  ArrayList<Info_String> list_String ;
  Info_String_dict() {
    super('s');
    list_String = new ArrayList<Info_String>();
  }

  // add String
  void add(String name, String a) {
    Info_String info = new Info_String(name,a);
    list_String.add(info);
  }
  void add(String name, String a, String b) {
    Info_String info = new Info_String(name,a,b); 
    list_String.add(info);
  }
  void add(String name, String a, String b, String c) {
    Info_String info = new Info_String(name,a,b,c);
    list_String.add(info);
  }
  void add(String name, String a, String b, String c, String d) {
    Info_String info = new Info_String(name,a,b,c,d);
    list_String.add(info);
  }
  void add(String name, String a, String b, String c, String d, String e) {
    Info_String info = new Info_String(name,a,b,c,d,e);
    list_String.add(info);
  }
  void add(String name, String a, String b, String c, String d, String e, String f) {
    Info_String info = new Info_String(name,a,b,c,d,e,f);
    list_String.add(info);
  }
  void add(String name, String a, String b, String c, String d, String e, String f,String g) {
    Info_String info = new Info_String(name,a,b,c,d,e,f,g);
    list_String.add(info);
  }

  // size
  int size() {
    return list_String.size() ;
  }

  //read
  void read() {
    println("String list");
    for(Info a : list_String) {
      println(a,"String");
    }
  }
  

  // get
  Info_String get(int target) {
    if(target < list_String.size() && target >= 0) {
      return list_String.get(target);
    } else return null;
  }
  
  Info_String [] get(String which) {
    Info_String [] info  ;
    int count = 0 ;
    for(Info_String a : list_String) {
      if(a.get_name().equals(which)) {
        count++;
      }
    }
    if (count > 0 ) {
      info = new Info_String[count] ;
      count = 0;
      for(Info_String a : list_String) {
        if(a.get_name().equals(which)) {
          info[count] = a;
          count++;
        }
      }
    } else {
      info = new Info_String[1];
      info[0] = null;
    }
    if(info.length == 1 && info[0] == null )return null ; else return info;
  }

  // clear
  void clear() {
    list_String.clear();
  }

  // remove
  void remove(String which) {
    for(int i = 0 ; i < list_String.size() ; i++) {
      Info_String a = list_String.get(i);
      if(a.get_name().equals(which)) {
        list_String.remove(i);
      }
    }
  }
  
  void remove(int target) {
   if(target < list_String.size()) {
      list_String.remove(target);
    }
  }
}


/**
Info_vec_dict
*/
public class Info_vec_dict extends Info_dict {
  ArrayList<Info_vec> list_vec ;
  Info_vec_dict() {
    super('v') ;
    list_vec = new ArrayList<Info_vec>() ;
  }

  // add vec
  void add(String name, vec a) {
    Info_vec info = new Info_vec(name,a);
    list_vec.add(info);
  }
  void add(String name, vec a, vec b) {
    Info_vec info = new Info_vec(name,a,b);
    list_vec.add(info);
  }
  void add(String name, vec a, vec b, vec c) {
    Info_vec info = new Info_vec(name,a,b,c);
    list_vec.add(info);
  }
  void add(String name, vec a, vec b, vec c, vec d) {
    Info_vec info = new Info_vec(name,a,b,c,d);
    list_vec.add(info);
  }
  void add(String name, vec a, vec b, vec c, vec d, vec e) {
    Info_vec info = new Info_vec(name,a,b,c,d,e);
    list_vec.add(info);
  }
  void add(String name, vec a, vec b, vec c, vec d, vec e, vec f) {
    Info_vec info = new Info_vec(name,a,b,c,d,e,f);
    list_vec.add(info);
  }
  void add(String name, vec a, vec b, vec c, vec d, vec e, vec f, vec g) {
    Info_vec info = new Info_vec(name,a,b,c,d,e,f,g);
    list_vec.add(info);
  }

  // size
  int size() {
    return list_vec.size();
  }

  //read
  void read() {
    println("vec list");
    for(Info a : list_vec) {
      println(a,"vec");
    }
  }
  

  // get
  Info_vec get(int target) {
    if(target < list_vec.size() && target >= 0) {
      return list_vec.get(target);
    } else return null;
  }
  
  Info_vec [] get(String which) {
    Info_vec [] info;
    int count = 0 ;
    for(Info_vec a : list_vec) {
      if(a.get_name().equals(which)) {
        count++;
      }
    }
    if (count > 0 ) {
      info = new Info_vec[count];
      count = 0 ;
      for(Info_vec a : list_vec) {
        if(a.get_name().equals(which)) {
          info[count] = a;
          count++ ;
        }
      }
    } else {
      info = new Info_vec[1];
      info[0] = null ;
    }
    if(info.length == 1 && info[0] == null )return null ; else return info;
  }

  // clear
  void clear() {
    list_vec.clear();
  }

  // remove
  void remove(String which) {
    for(int i = 0 ; i < list_vec.size() ; i++) {
      Info_vec a = list_vec.get(i) ;
      if(a.get_name().equals(which)) {
        list_vec.remove(i);
      }
    }
  }
  
  void remove(int target) {
   if(target < list_vec.size()) {
      list_vec.remove(target);
    }
  }
}



/**
Info 0.1.0.2

*/
interface Info {
  String get_name();

  Object [] catch_all() ;
  Object catch_obj(int arg);

  char get_type();
}
 
abstract class Info_method implements Info {
  String name  ;
  // error message
  String error_target = "Your target is beyond of my knowledge !" ;
  String error_value_message = "This value is beyond of my power mate !" ;
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
  int a, b, c, d, e, f, g ;
  int num_value ;  


  Info_int(String name) {
    super(name) ;
  }

  Info_int(String name, int... arg) {
    super(name);
    int len = arg.length;
    if(len > 7 ) {
      num_value = 7 ; 
    } else {
      num_value = len;
    }
    if(len > 0) this.a = arg[0] ;
    if(len > 1) this.b = arg[1] ;
    if(len > 2) this.c = arg[2] ;
    if(len > 3) this.d = arg[3] ;
    if(len > 4) this.e = arg[4] ;
    if(len > 5) this.f = arg[5] ;
    if(len > 6) this.g = arg[6] ;
  }


  // get
  int [] get() {
    int [] list = new int[]{a,b,c,d,e,f,g} ;
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
    } else if(which == 6) {
      return g ;
    } else {
      System.err.println(error_target) ;
      return 0 ;
    } 
  }
  
  Object [] catch_all() {
    Object [] list = new Object[]{a,b,c,d,e,f,g} ;
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
    } else if(which == 6) {
      return g ;
    } else {
      System.err.println(error_target) ;
      return null ;
    } 
  }
  
  char get_type() { return type ; }

  // Print info
  @Override String toString() {
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
    } else if(num_value == 7) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + ", " + f + ", " + g +" ]";
    } else {
      System.err.println(num_value) ;
      System.err.println(error_value_message) ;
      return "hmmm hmmm there is problem with your stuff mate";
    }
  }
}

/**
INFO String
*/
class Info_String extends Info_method {
  char type = 's' ;
  String a, b, c, d, e, f, g ;
  int num_value ;  

  Info_String(String name) {
    super(name) ;
  }

  Info_String(String name, String... arg) {
    super(name);
    int len = arg.length;
    if(len > 7 ) {
      num_value = 7 ; 
    } else {
      num_value = len;
    }
    if(len > 0) this.a = arg[0] ;
    if(len > 1) this.b = arg[1] ;
    if(len > 2) this.c = arg[2] ;
    if(len > 3) this.d = arg[3] ;
    if(len > 4) this.e = arg[4] ;
    if(len > 5) this.f = arg[5] ;
    if(len > 6) this.g = arg[6] ;
  }


  // get
  String [] get() {
    String [] list = new String[]{a,b,c,d,e,f,g} ;
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
    } else if(which == 6) {
      return g ;
    }else {
      System.err.println(error_target) ;
      return null ;
    }
  }
  
  Object [] catch_all() {
    Object [] list = new Object[]{a,b,c,d,e,f,g} ;
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
    } else if(which == 6) {
      return g ;
    }else {
      System.err.println(error_target) ;
      return null ;
    }
  }

  char get_type() { return type ; }


  // Print info
  @Override String toString() {
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
    } else if(num_value == 7) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + ", " + f + ", " + g + " ]";
    } else {
      System.err.println(num_value) ;
      System.err.println(error_value_message) ;
      return "hmmm hmmm there is problem with your stuff mate";
    }
  }
}

/**
INFO float
*/
class Info_float extends Info_method {
  char type = 'f' ;
  float a, b, c, d, e, f, g ;
  int num_value ; 

  Info_float(String name) {
    super(name) ;
  }

  Info_float(String name, float... arg) {
    super(name);
    int len = arg.length;
    if(len > 7 ) {
      num_value = 7 ; 
    } else {
      num_value = len;
    }
    if(len > 0) this.a = arg[0] ;
    if(len > 1) this.b = arg[1] ;
    if(len > 2) this.c = arg[2] ;
    if(len > 3) this.d = arg[3] ;
    if(len > 4) this.e = arg[4] ;
    if(len > 5) this.f = arg[5] ;
    if(len > 6) this.g = arg[6] ;
  }

  // get
  float [] get() {
    float [] list = new float[]{a,b,c,d,e,f,g} ;
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
    } else if(which == 6) {
      return g ;
    } else {
      System.err.println(error_target) ;
      return 0.0 ;
    }
  }
  
  Object [] catch_all() {
    Object [] list = new Object[]{a,b,c,d,e,f,g} ;
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
    } else if(which == 6) {
      return g ;
    } else {
      System.err.println(error_target) ;
      return null ;
    }
  }

  char get_type() { return type ; }
  
  // Print info
  @Override String toString() {
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
    } else if(num_value == 7) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + ", " + f + ", " + g + " ]";
    } else {
      System.err.println(num_value) ;
      System.err.println(error_value_message) ;
      return "hmmm hmmm there is problem with your stuff mate";
    }
  }
}

/**
INFO vec
v 0.0.2
*/
class Info_vec extends Info_method {
  char type = 'v' ;
  vec a, b, c, d, e, f, g ;
  int num_value ;  

  Info_vec(String name) {
    super(name) ;
  }

  // vec value
  Info_vec(String name, vec... arg) {
    super(name);
    int len = arg.length;
    if(len > 7 ) {
      num_value = 7 ; 
    } else {
      num_value = len;
    }
    if(len > 0) this.a = arg[0] ;
    if(len > 1) this.b = arg[1] ;
    if(len > 2) this.c = arg[2] ;
    if(len > 3) this.d = arg[3] ;
    if(len > 4) this.e = arg[4] ;
    if(len > 5) this.f = arg[5] ;
    if(len > 6) this.g = arg[6] ;
  }




  // get
  vec [] get() {
    vec [] list = new vec[]{a,b,c,d,e,f,g} ;
    return list ;
  }

  vec get(int which) {
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
    } else if(which == 6) {
      return g ;
    }else {
      System.err.println(error_target) ;
      return null;
    }
  }
  
  Object [] catch_all() {
    Object [] list = new Object[]{a,b,c,d,e,f,g} ;
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
    } else if(which == 6) {
      return g ;
    } else {
      System.err.println(error_target) ;
      return null ;
    }
  }

  char get_type() { return type; }

  // Print info
  @Override String toString() {
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
    } else if(num_value == 7) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + ", " + f + ", " + g + " ]";
    } else {
      System.err.println(num_value) ;
      System.err.println(error_value_message) ;
      return "hmmm hmmm there is problem with your stuff mate";
    }
  }
}




/**
INFO OBJECT
v 0.0.2
*/
class Info_Object extends Info_method {
  char type = 'o' ;
  Object a, b, c, d, e, f, g ;
  int num_value ;

  Info_Object(String name) {
    super(name) ;
  }


  // Object value
  Info_Object(String name, Object... arg) {
    super(name);
    int len = arg.length;
    if(len > 7 ) {
      num_value = 7 ; 
    } else {
      num_value = len;
    }
    if(len > 0) this.a = arg[0];
    if(len > 1) this.b = arg[1];
    if(len > 2) this.c = arg[2];
    if(len > 3) this.d = arg[3];
    if(len > 4) this.e = arg[4];
    if(len > 5) this.f = arg[5];
    if(len > 6) this.g = arg[6];
  }


  // get
  Object [] get() {
    Object [] list = new Object []{a,b,c,d,e,f,g} ;
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
    } else if(which == 6) {
      return g ;
    } else {
      printErr(error_target) ;
      return null ;
    }
  }
  
  Object [] catch_all() {
    Object [] list = new Object[]{a,b,c,d,e,f,g} ;
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
    } else if(which == 6) {
      return g ;
    } else {
      printErr(error_target) ;
      return null ;
    }
  }
  
  char get_type() { return type ; }


  // Print info
  @Override String toString() {
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
    } else if(num_value == 7) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + ", " + f + ", " + g + " ]";
    } else {
      printErr(num_value) ;
      printErr(error_value_message) ;
      return "hmmm hmmm there is problem with your stuff mate";
    }
  }
}
