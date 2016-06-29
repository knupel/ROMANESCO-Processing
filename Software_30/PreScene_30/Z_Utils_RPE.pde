/**
RPE UTILS 1.13.7
*/

/**
CONSTANT NUMBER must be here to be generate before all
*/
/////////////////////////////////////////////////////////
final float PHI = (1 + sqrt(5))/2; //a number of polys use the golden ratio...
final float ROOT2 = sqrt(2); //...and the square root of two, the famous first irrationnal number by Pythagore
final float EULER = 2.718281828459045235360287471352; // Constant d'Euler
final int  INT_MAX = 2147483647 ;
// about constant https://en.wikipedia.org/wiki/Mathematical_constant

/**
Class info
*/
class Info {
  String name ;
  String s_a, s_b, s_c, s_d, s_e, s_f ;
  float f_a, f_b, f_c, f_d, f_e, f_f = Float.NaN ;
  int i_a, i_b, i_c, i_d, i_e, i_f = INT_MAX  ;
  int num_value ;
  boolean float_bool ;
  boolean integer ;
  boolean string ;
  
  
  /**
  String value
  */
  Info(String name, String a) {
    num_value = 1 ;
    string = true ;
    this.name = name ;
    this.s_a = a ;
  }
   
  Info(String name, String a, String b) {
    num_value = 2 ;
    string = true ;
    this.name = name ;
    this.s_a = a ;
    this.s_b = b ;
  }

  Info(String name, String a, String b, String c) {
    num_value = 3 ;
    string = true ;
    this.name = name ;
    this.s_a = a ;
    this.s_b = b ;
    this.s_c = c ;
  }

  Info(String name, String a, String b, String c, String d) {
    num_value = 4 ;
    string = true ;
    this.name = name ;
    this.s_a = a ;
    this.s_b = b ;
    this.s_c = c ;
    this.s_d = d ;
  }

  Info(String name, String a, String b, String c, String d, String e) {
    num_value = 5 ;
    string = true ;
    this.name = name ;
    this.s_a = a ;
    this.s_b = b ;
    this.s_c = c ;
    this.s_d = d ;
    this.s_e = e ;
  }

  Info(String name, String a, String b, String c, String d, String e, String f) {
    num_value = 6 ;
    string = true ;
    this.name = name ;
    this.s_a = a ;
    this.s_b = b ;
    this.s_c = c ;
    this.s_d = d ;
    this.s_e = e ;
    this.s_f = f ;
  }



  /**
  Float value
  */
  Info(String name, float a) {
    num_value = 1 ;
    float_bool = true ;
    this.name = name ;
    this.f_a = a ;
  }
   
  Info(String name, float a, float b) {
    num_value = 2 ;
    float_bool = true ;
    this.name = name ;
    this.f_a = a ;
    this.f_b = b ;
  }

  Info(String name, float a, float b, float c) {
    num_value = 3 ;
    float_bool = true ;
    this.name = name ;
    this.f_a = a ;
    this.f_b = b ;
    this.f_c = c ;
  }

  Info(String name, float a, float b, float c, float d) {
    num_value = 4 ;
    float_bool = true ;
    this.name = name ;
    this.f_a = a ;
    this.f_b = b ;
    this.f_c = c ;
    this.f_d = d ;
  }

  Info(String name, float a, float b, float c, float d, float e) {
    num_value = 5 ;
    float_bool = true ;
    this.name = name ;
    this.f_a = a ;
    this.f_b = b ;
    this.f_c = c ;
    this.f_d = d ;
    this.f_e = e ;
  }

  Info(String name, float a, float b, float c, float d, float e, float f) {
    num_value = 6 ;
    float_bool = true ;
    this.name = name ;
    this.f_a = a ;
    this.f_b = b ;
    this.f_c = c ;
    this.f_d = d ;
    this.f_e = e ;
    this.f_f = f ;
  }

  /**
  Integare value
  */
  Info(String name, int a) {
    num_value = 1 ;
    integer = true ;
    this.name = name ;
    this.i_a = a ;
  }

  Info(String name, int a, int b) {
    num_value = 2 ;
    integer = true ;
    this.name = name ;
    this.i_a = a ;
    this.i_b = b ;
  }

  Info(String name, int a, int b, int c) {
    num_value = 3 ;
    integer = true ;
    this.name = name ;
    this.i_a = a ;
    this.i_b = b ;
    this.i_c = c ;
  }

  Info(String name, int a, int b, int c, int d) {
    num_value = 4 ;
    integer = true ;
    this.name = name ;
    this.i_a = a ;
    this.i_b = b ;
    this.i_c = c ;
    this.i_d = d ;
  }

  Info(String name, int a, int b, int c, int d, int e) {
    num_value = 5 ;
    integer = true ;
    this.name = name ;
    this.i_a = a ;
    this.i_b = b ;
    this.i_c = c ;
    this.i_d = d ;
    this.i_e = e ;
  }

  Info(String name, int a, int b, int c, int d, int e, int f) {
    num_value = 6 ;
    integer = true ;
    this.name = name ;
    this.i_a = a ;
    this.i_b = b ;
    this.i_c = c ;
    this.i_d = d ;
    this.i_e = e ;
    this.i_f = f ;
  }

  /**
  Vec variable
  */
  Info(String name, Vec2 v) {
    num_value = 2 ;
    float_bool = true ;
    this.name = name ;
    this.f_a = v.x ;
    this.f_b = v.y ;
  }

  Info(String name, Vec3 v) {
    num_value = 3 ;
    float_bool = true ;
    this.name = name ;
    this.f_a = v.x ;
    this.f_b = v.y ;
    this.f_c = v.z ;
  }

  Info(String name, Vec4 v) {
    num_value = 4 ;
    float_bool = true ;
    this.name = name ;
    this.f_a = v.x ;
    this.f_b = v.y ;
    this.f_c = v.z ;
    this.f_d = v.w ;
  }

  Info(String name, Vec5 v) {
    num_value = 5 ;
    float_bool = true ;
    this.name = name ;
    this.f_a = v.a ;
    this.f_b = v.b ;
    this.f_c = v.c ;
    this.f_d = v.d ;
    this.f_e = v.e ;
  }

  Info(String name, Vec6 v) {
    num_value = 6 ;
    float_bool = true ;
    this.name = name ;
    this.f_a = v.a ;
    this.f_b = v.b ;
    this.f_c = v.c ;
    this.f_d = v.d ;
    this.f_e = v.e ;
    this.f_f = v.f ;
  }



  /**
  Print info
  */
  @ Override String toString() {
    if(num_value == 1 && float_bool) {
      return "[ " + name + ": " + f_a + " ]";
    } else if(num_value == 2 && float_bool) {
      return "[ " + name + ": " + f_a + ", " + f_b + " ]";
    } else if(num_value == 3 && float_bool) {
      return "[ " + name + ": " + f_a + ", " + f_b + ", " + f_c + " ]";
    } else if(num_value == 4 && float_bool) {
      return "[ " + name + ": " + f_a + ", " + f_b + ", " + f_c + ", " + f_d + " ]";
    } else if(num_value == 5 && float_bool) {
      return "[ " + name + ": " + f_a + ", " + f_b + ", " + f_c + ", " + f_d + ", " + f_e + " ]";
    } else if(num_value == 6 && float_bool) {
      return "[ " + name + ": " + f_a + ", " + f_b + ", " + f_c + ", " + f_d + ", " + f_e + ", " + f_f + " ]";
    } else if(num_value == 1 && integer) {
      return "[ " + name + ": " + i_a + " ]";
    } else if(num_value == 2 && integer) {
      return "[ " + name + ": " + i_a + ", " + i_b + " ]";
    } else if(num_value == 3 && integer) {
      return "[ " + name + ": " + i_a + ", " + i_b + ", " + i_c + " ]";
    } else if(num_value == 4 && integer) {
      return "[ " + name + ": " + i_a + ", " + i_b + ", " + i_c + ", " + i_d + " ]";
    } else if(num_value == 5 && integer) {
      return "[ " + name + ": " + i_a + ", " + i_b + ", " + i_c + ", " + i_d + ", " + i_e + " ]";
    } else if(num_value == 6 && integer) {
      return "[ " + name + ": " + i_a + ", " + i_b + ", " + i_c + ", " + i_d + ", " + i_e + ", " + i_f + " ]";
    } else if(num_value == 1 && string) {
      return "[ " + name + ": " + s_a + " ]";
    } else if(num_value == 2 && string) {
      return "[ " + name + ": " + s_a + ", " + s_b + " ]";
    } else if(num_value == 3 && string) {
      return "[ " + name + ": " + s_a + ", " + s_b + ", " + s_c + " ]";
    } else if(num_value == 4 && string) {
      return "[ " + name + ": " + s_a + ", " + s_b + ", " + s_c + ", " + s_d + " ]";
    } else if(num_value == 5 && string) {
      return "[ " + name + ": " + s_a + ", " + s_b + ", " + s_c + ", " + s_d + ", " + s_e + " ]";
    } else if(num_value == 6 && string) {
      return "[ " + name + ": " + s_a + ", " + s_b + ", " + s_c + ", " + s_d + ", " + s_e + ", " + s_f + " ]";
    }
    else {
      return "hmmm hmmm there is problem with your stuff mate";
    }
  }
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
TRANSLATOR INT to String, FLOAT to STRING
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
String float_to_String_1(float data) {
  String float_string_value ;
  float_string_value = String.format("%.1f", data ) ;
  String [] temp = split(float_string_value, ",") ;
  float_string_value = temp[0] +"." + temp[1] ;
  return float_string_value ;
}
//
String float_to_String_2(float data) {
  String float_string_value ;
  float_string_value = String.format("%.2f", data ) ;
  String [] temp = split(float_string_value, ",") ;
  float_string_value = temp[0] +"." + temp[1] ;
  return float_string_value ;
}
//
String float_to_String_3(float data) {
  String float_string_value ;
  float_string_value = String.format("%.3f", data ) ;
  String [] temp = split(float_string_value, ",") ;
  float_string_value = temp[0] +"." + temp[1] ;
  return float_string_value ;
}

//
String float_to_String_4(float data) {
  String float_string_value ;
  float_string_value = String.format("%.4f", data ) ;
  String [] temp = split(float_string_value, ",") ;
  float_string_value = temp[0] +"." + temp[1] ;
  return float_string_value ;
}
//
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
    if (length_String_in_pixel(listWordsToSort[i], size_font) > sizeWord )  sizeWord = length_String_in_pixel(listWordsToSort[i],size_font) ;
  }
  return  sizeWord ;
}

// with the same size_text for each line, choice the which line you check
int longest_word_in_pixel( String[] listWordsToSort, int size_font, int start, int finish ) {
  int sizeWord = 0 ;
  for ( int i = start ; i <= finish ; i++) {
    if (length_String_in_pixel(listWordsToSort[i], size_font) > sizeWord )  sizeWord = length_String_in_pixel(listWordsToSort[i],size_font) ;
  }
  return  sizeWord ;
}

// with list of size_text for each line
int longest_word_in_pixel( String[] listWordsToSort, int [] size_font) {
  int sizeWord = 0 ;
  for ( int i = 0 ; i < listWordsToSort.length ; i++) {
    if (length_String_in_pixel(listWordsToSort[i], size_font[i]) > sizeWord )  sizeWord = length_String_in_pixel(listWordsToSort[i],size_font[i]) ;
  }
  return  sizeWord ;
}

// with list of size_text for each line, choice the which line you check
int longest_word_in_pixel( String[] listWordsToSort, int [] size_font, int start, int finish ) {
  int sizeWord = 0 ;
  for ( int i = start ; i <= finish ; i++) {
    if (length_String_in_pixel(listWordsToSort[i], size_font[i]) > sizeWord )  sizeWord = length_String_in_pixel(listWordsToSort[i],size_font[i]) ;
  }
  return  sizeWord ;
}




import java.awt.Font; 
import java.awt.image.BufferedImage ;
import java.awt.FontMetrics ;

int length_String_in_pixel(String target, int ratio) {
  Font font = new Font("defaultFont", Font.BOLD, ratio) ;
  BufferedImage img = new BufferedImage(1, 1, BufferedImage.TYPE_INT_ARGB);
  FontMetrics fm = img.getGraphics().getFontMetrics(font);
  return fm.stringWidth(target);
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




