/**
ROPE - Romanesco processing environment – 
* Copyleft (c) 2014-2018
* Stan le Punk > http://stanlepunk.xyz/
CONSTANTS ROPE
v 0.1.3.4
Processing 3.3.7
* @author Stan le Punk
* @see https://github.com/StanLepunK/Rope
*/
/*
About constant https://en.wikipedia.org/wiki/Mathematical_constant
*/
public interface Rope_Constants {
	static final float PHI   = (1 + sqrt(5))/2; //a number of polys use the golden ratio...
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

	static final int CARTESIAN = 500;
	static final int POLAR = 501 ;

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
	
	// GRAY_1 > HSB,1,1,1 > color(0,0,.1);
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
	// GRAY_9 > HSB,1,1,1 > color(0,0,.9);
	static final int GRAY_9 = -1710619;
	static final int GRIS_9 = -1710619;

  // RED > HSB,1,1,1 > color(0,1,1);
	static final int RED      = -65536;
	static final int ROUGE    = -65536;
	// BLOOD > HSB,1,1,1 > color(0,1,.75);
	static final int BLOOD  = -4259840;
	static final int SANG   = -4259840; 
	// CARMINE > HSB,1,1,1 > color(0,1,.55);
	static final int CARMINE  = -7602176;
	static final int CARMIN   = -7602176; 
	// ORANGE > HSB,1,1,1 > color(.08,1,1);
	static final int ORANGE   = -34304;
	// OR > HSB,1,1,1 > color(0.12 1.0 1.0);
  static public int OR  = -20736;
  static public int GOLD  = -20736;
  // YELLOW > HSB,1,1,1 > color(0.166 1.0 1.0);
  static public int YELLOW  = -256;
  static public int JAUNE  = -256;
  // GREEN > HSB,1,1,1 > color(0.333 1.0 1.0);
	static final int GREEN    = -16711936;
	static final int VERT    = -16711936;
  // CYAN > HSB,1,1,1 > color(0.5 1.0 1.0);
	static public int CYAN    = -16711681;
	// BLUE > HSB,1,1,1 > color(.6503,1,1);
	static final int BLUE     = -16770561;
	static final int BLEU     = -16770561;  
  // MAGENTA > HSB,1,1,1 > color(.8333,1,1);
	static public int MAGENTA = -65281;
	// PURPLE > HSB,1,1,1 > color(.7496,1,1);
	static public int PURPLE  = -8453889;
	static public int VIOLET  = -8453889;  
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













