/**
ROPE - Romanesco processing environment – 
* Copyleft (c) 2014-2018
* Stan le Punk > http://stanlepunk.xyz/
CONSTANTS ROPE
v 0.1.3.11
Processing 3.3.7
* @author Stan le Punk
* @see https://github.com/StanLepunK/Rope
*/
/*
About constant https://en.wikipedia.org/wiki/Mathematical_constant
*/
public interface Rope_Constants {
  static final int  NOTHING = 0;
  static final int  NONE = 0;
  static final int  NULL = 0;
  
   
  
	static final float PHI = (1 + sqrt(5))/2; //a number of polys use the golden ratio... > 1.618....
  static final float GOLD_NUMBER = PHI;
  static final float GOLD_ANGLE = TAU / (PHI*PHI); // > 137.500 in degree
	static final float ROOT2 = sqrt(2); //...and the square root of two, the famous first irrationnal number by Pythagore
	static final float EULER = 2.718281828459045235360287471352; // Euler number constant
	static final double G    = 0.00000000006693; // last gravity constant

	static final int HUE = 50;
	static final int SATURATION = 51;
	static final int BRIGHTNESS = 52;

	static final int ALPHA = 100 ;

	static final int FLUID = 200;
	static final int GRAVITY = 201;
	static final int MAGNETIC = 202;

	static final int BLANK = 300;
	static final int PERLIN = 301;
	static final int CHAOS = 302;
	static final int ORDER = 303;
	static final int EQUATION = 304;

	static final int DRAW = 400;
	static final int FIT = 450;

	static final int CARTESIAN = 500;
	static final int POLAR = 501 ;

	static final int MIX = 600 ;

	static final int STATIC = 1000;
	static final int DYNAMIC = 1001;


	/**
	GRAPHIC
	*/
	static final int PIXEL = 800;
	static final int STAR = 810;
  
  /**
  COLOUR
  */
	static final int BLACK = -16777216;
	static final int NOIR = -16777216;
	static final int WHITE = -1;
	static final int BLANC = -1;
	// static final int GRAY = 4050 ; // this already existe
	// static final int GRAY_MEDIUM = -8618884;
	
	// GRAY_1 > HSB,1,1,1 > color(0,0,.1); > cloase to BLACK
	static final int GRAY_1 = -15132391;
	static final int GRIS_1 = -15132391;
	// GRAY_2 > HSB,1,1,1 > color(0,0,.2);	
	static final int GRAY_2 = -13421773;
	static final int GRIS_2 = -13421773;
	// GRAY_3 > HSB,1,1,1 > color(0,0,.3);
	static final int GRAY_3 = -11776948;
	static final int GRIS_3 = -11776948;
	// GRAY_4 > HSB,1,1,1 > color(0,0,.4);
	static final int GRAY_4 = -10066330;
	static final int GRIS_4 = -10066330;
	// GRAY_5 > HSB,1,1,1 > color(0,0,.5);
	static final int GRAY_MEDIUM = -8421505;
	static final int GRAY_5 = -8421505;
	static final int GRIS = -8421505;
	static final int GRIS_MOYEN = -8421505;
	static final int GRIS_5 = -8421505;
	// GRAY_6 > HSB,1,1,1 > color(0,0,.6);
	static final int GRAY_6 = -6710887;
	static final int GRIS_6 = -6710887;
	// GRAY_7 > HSB,1,1,1 > color(0,0,.7);
	static final int GRAY_7 = -5066062;
	static final int GRIS_7 = -5066062;
	// GRAY_8 > HSB,1,1,1 > color(0,0,.8);
	static final int GRAY_8 = -3355444;
	static final int GRIS_8 = -3355444;
	// GRAY_9 > HSB,1,1,1 > color(0,0,.9); > cloase to WHITE
	static final int GRAY_9 = -1710619;
	static final int GRIS_9 = -1710619;
  
  /**
  color guide
  https://fr.wikipedia.org/wiki/Liste_de_noms_de_couleur
  */
  // RED > HSB,1,1,1 > color(0,1,1);
	static final int RED = -65536;
	static final int ROUGE = -65536;
	// BLOOD > HSB,1,1,1 > color(0,1,.75);
	static final int BLOOD = -4259840;
	static final int SANG = -4259840; 
	// CARMINE > HSB,1,1,1 > color(0,1,.55);
	static final int CARMINE = -7602176;
	static final int CARMIN = -7602176; 
	// ORANGE > HSB,1,1,1 > color(.08,1,1);
	static final int ORANGE = -34304;
	// OR > HSB,1,1,1 > color(0.12 1.0 1.0);
  static public int OR = -20736;
  static public int GOLD = -20736;
  // YELLOW > HSB,1,1,1 > color(0.166 1.0 1.0);
  static public int YELLOW = -256;
  static public int JAUNE = -256;
  // BOUTEILLE / BOTTLE > HSB,1,1,1 > color(0.33333334 0.9150943 0.41568628);
	static final int BOUTEILLE = -16160247;
	static final int BOTTLE = -16160247;
	// GREEN > HSB,1,1,1 > color(0.333 1.0 1.0);
	static final int GREEN = -16711936;
	static final int VERT = -16711936;
  // CYAN > HSB,1,1,1 > color(0.5 1.0 1.0);
	static public int CYAN = -16711681;
	// BLUE > HSB,1,1,1 > color(.6503,1,1);
	static final int BLUE = -16770561;
	static final int BLEU = -16770561;  
  // MAGENTA > HSB,1,1,1 > color(.8333,1,1);
	static public int MAGENTA = -65281;
  // PINK > HSB,1,1,1 > color(.86,.65,1);
	static public int PINK = -42524;
	static public int ROSE = -42524;
	// PURPLE > HSB,1,1,1 > color(.7496,1,1);
	static public int PURPLE = -8453889;
	static public int VIOLET = -8453889;  
  /**
  String Constants
  */
	static final String RANDOM       = "RANDOM";
	static final String RANDOM_ZERO  = "RANDOM ZERO";
	static final String RANDOM_RANGE = "RANDOM RANGE";
	static final String RANDOM_ROOT = "ROOT_RANDOM";
  static final String RANDOM_QUARTER ="QUARTER_RANDOM";
  static final String RANDOM_2 = "2_RANDOM" ;
  static final String RANDOM_3 = "3_RANDOM" ;
  static final String RANDOM_4 = "4_RANDOM" ;
  static final String RANDOM_X_A = "SPECIAL_A_RANDOM" ;
  static final String RANDOM_X_B = "SPECIAL_B_RANDOM" ;

  static final String SIN = "SIN" ;
  static final String COS = "COS" ;
  static final String TAN = "TAN" ;
  static final String TRIG_0 = "SIN_TAN" ;
  static final String TRIG_1 = "SIN_TAN_COS" ;
  static final String TRIG_2 = "SIN_POW_SIN" ;
  static final String TRIG_3 = "POW_SIN_PI" ;
  static final String TRIG_4 = "SIN_TAN_POW_SIN" ;
}


/**
Processing constant


public interface PConstants {

  static public final int X = 0;
  static public final int Y = 1;
  static public final int Z = 2;

  static final String JAVA2D = "processing.awt.PGraphicsJava2D";

  static final String P2D = "processing.opengl.PGraphics2D";
  static final String P3D = "processing.opengl.PGraphics3D";

  static final String FX2D = "processing.javafx.PGraphicsFX2D";

  static final String PDF = "processing.pdf.PGraphicsPDF";
  static final String SVG = "processing.svg.PGraphicsSVG";
  static final String DXF = "processing.dxf.RawDXF";

  static final int OTHER   = 0;
  static final int WINDOWS = 1;
  static final int MACOSX  = 2;
  static final int LINUX   = 3;

  static final float EPSILON = 0.0001f;

  static final float MAX_FLOAT = Float.MAX_VALUE;

  static final float MIN_FLOAT = -Float.MAX_VALUE;

  static final int MAX_INT = Integer.MAX_VALUE;

  static final int MIN_INT = Integer.MIN_VALUE;

  static public final int VERTEX = 0;
  static public final int BEZIER_VERTEX = 1;
  static public final int QUADRATIC_VERTEX = 2;
  static public final int CURVE_VERTEX = 3;
  static public final int BREAK = 4;

  static final float PI = (float) Math.PI;
  static final float HALF_PI = (float) (Math.PI / 2.0);
  static final float THIRD_PI = (float) (Math.PI / 3.0);
  static final float QUARTER_PI = (float) (Math.PI / 4.0);
  static final float TWO_PI = (float) (2.0 * Math.PI);
  static final float TAU = (float) (2.0 * Math.PI);
  static final float DEG_TO_RAD = PI/180.0f;
  static final float RAD_TO_DEG = 180.0f/PI;

  static final String WHITESPACE = " \t\n\r\f\u00A0";

  static final int RGB   = 1;  // image & color
  static final int ARGB  = 2;  // image
  static final int HSB   = 3;  // color
  static final int ALPHA = 4;  // image

  static final int TIFF  = 0;
  static final int TARGA = 1;
  static final int JPEG  = 2;
  static final int GIF   = 3;

  static final int BLUR      = 11;
  static final int GRAY      = 12;
  static final int INVERT    = 13;
  static final int OPAQUE    = 14;
  static final int POSTERIZE = 15;
  static final int THRESHOLD = 16;
  static final int ERODE     = 17;
  static final int DILATE    = 18;

  public final static int REPLACE    = 0;
  public final static int BLEND      = 1 << 0;
  public final static int ADD        = 1 << 1;
  public final static int SUBTRACT   = 1 << 2;
  public final static int LIGHTEST   = 1 << 3;
  public final static int DARKEST    = 1 << 4;
  public final static int DIFFERENCE = 1 << 5;
  public final static int EXCLUSION  = 1 << 6;
  public final static int MULTIPLY   = 1 << 7;
  public final static int SCREEN     = 1 << 8;
  public final static int OVERLAY    = 1 << 9;
  public final static int HARD_LIGHT = 1 << 10;
  public final static int SOFT_LIGHT = 1 << 11;
  public final static int DODGE      = 1 << 12;
  public final static int BURN       = 1 << 13;

  static final int CHATTER   = 0;
  static final int COMPLAINT = 1;
  static final int PROBLEM   = 2;

  static final int PROJECTION = 0;
  static final int MODELVIEW  = 1;

  static final int CUSTOM       = 0; // user-specified fanciness
  static final int ORTHOGRAPHIC = 2; // 2D isometric projection
  static final int PERSPECTIVE  = 3; // perspective matrix

  static final int GROUP           = 0;   

  static final int POINT           = 2;   // primitive
  static final int POINTS          = 3;   // vertices

  static final int LINE            = 4;   // primitive
  static final int LINES           = 5;   
  static final int LINE_STRIP      = 50; 
  static final int LINE_LOOP       = 51;

  static final int TRIANGLE        = 8;   // primitive
  static final int TRIANGLES       = 9;   // vertices
  static final int TRIANGLE_STRIP  = 10;  // vertices
  static final int TRIANGLE_FAN    = 11;  // vertices

  static final int QUAD            = 16;  // primitive
  static final int QUADS           = 17;  // vertices
  static final int QUAD_STRIP      = 18;  // vertices

  static final int POLYGON         = 20;  // in the end, probably cannot
  static final int PATH            = 21;  // separate these two

  static final int RECT            = 30;  // primitive
  static final int ELLIPSE         = 31;  // primitive
  static final int ARC             = 32;  // primitive

  static final int SPHERE          = 40;  // primitive
  static final int BOX             = 41;  // primitive

  static final int OPEN = 1;
  static final int CLOSE = 2;

  static final int CORNER   = 0;
  static final int CORNERS  = 1;

  static final int RADIUS   = 2;

  static final int CENTER   = 3;

  static final int DIAMETER = 3;

  static final int CHORD  = 2;
  static final int PIE    = 3;

  static final int BASELINE = 0;

  static final int TOP = 101;
  static final int BOTTOM = 102;

  static final int NORMAL     = 1;
  static final int IMAGE      = 2;

  public static final int CLAMP = 0;
  public static final int REPEAT = 1;

  static final int MODEL = 4;

  static final int SHAPE = 5;

  static final int SQUARE   = 1 << 0;  // called 'butt' in the svg spec
  static final int ROUND    = 1 << 1;
  static final int PROJECT  = 1 << 2;  // called 'square' in the svg spec
  static final int MITER    = 1 << 3;
  static final int BEVEL    = 1 << 5;

  static final int AMBIENT = 0;
  static final int DIRECTIONAL  = 1;
  static final int SPOT = 3;

  static final char BACKSPACE = 8;
  static final char TAB       = 9;
  static final char ENTER     = 10;
  static final char RETURN    = 13;
  static final char ESC       = 27;
  static final char DELETE    = 127;

  static final int CODED     = 0xffff;

  static final int UP        = KeyEvent.VK_UP;
  static final int DOWN      = KeyEvent.VK_DOWN;
  static final int LEFT      = KeyEvent.VK_LEFT;
  static final int RIGHT     = KeyEvent.VK_RIGHT;

  static final int ALT       = KeyEvent.VK_ALT;
  static final int CONTROL   = KeyEvent.VK_CONTROL;
  static final int SHIFT     = KeyEvent.VK_SHIFT;

  static final int PORTRAIT = 1;
  static final int LANDSCAPE = 2;

  static final int SPAN = 0;

  static final int ARROW = Cursor.DEFAULT_CURSOR;
  static final int CROSS = Cursor.CROSSHAIR_CURSOR;
  static final int HAND  = Cursor.HAND_CURSOR;
  static final int MOVE  = Cursor.MOVE_CURSOR;
  static final int TEXT  = Cursor.TEXT_CURSOR;
  static final int WAIT  = Cursor.WAIT_CURSOR;

  static final int DISABLE_DEPTH_TEST         =  2;
  static final int ENABLE_DEPTH_TEST          = -2;

  static final int ENABLE_DEPTH_SORT          =  3;
  static final int DISABLE_DEPTH_SORT         = -3;

  static final int DISABLE_OPENGL_ERRORS      =  4;
  static final int ENABLE_OPENGL_ERRORS       = -4;

  static final int DISABLE_DEPTH_MASK         =  5;
  static final int ENABLE_DEPTH_MASK          = -5;

  static final int DISABLE_OPTIMIZED_STROKE   =  6;
  static final int ENABLE_OPTIMIZED_STROKE    = -6;

  static final int ENABLE_STROKE_PERSPECTIVE  =  7;
  static final int DISABLE_STROKE_PERSPECTIVE = -7;

  static final int DISABLE_TEXTURE_MIPMAPS    =  8;
  static final int ENABLE_TEXTURE_MIPMAPS     = -8;

  static final int ENABLE_STROKE_PURE         =  9;
  static final int DISABLE_STROKE_PURE        = -9;

  static final int ENABLE_BUFFER_READING      =  10;
  static final int DISABLE_BUFFER_READING     = -10;

  static final int DISABLE_KEY_REPEAT         =  11;
  static final int ENABLE_KEY_REPEAT          = -11;

  static final int DISABLE_ASYNC_SAVEFRAME    =  12;
  static final int ENABLE_ASYNC_SAVEFRAME     = -12;

  static final int HINT_COUNT                 =  13;
}
*/












