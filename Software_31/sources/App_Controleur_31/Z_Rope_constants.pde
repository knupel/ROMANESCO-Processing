/**
ROPE - Romanesco processing environment – 
* Copyleft (c) 2014-2017 
* Stan le Punk > http://stanlepunk.xyz/
CONSTANT ROPE
v 0.1.0.2
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

	static final int PERLIN   = 100;
	static final int CHAOS    = 101;
	static final int FLUID    = 102;
	static final int HOLE     = 103;
	static final int GRAVITY  = 103;
	static final int MAGNETIC = 104;


	static final int BLACK = -16777216;
	static final int WHITE = -1;
	// static final int GRAY = 4050 ; // this already existe
	static final int GRAY_MEDIUM = -8618884;

	static final int RED   = -65536;
	static final int GREEN = -16711936;
	static final int BLUE  = -16776961;

	static public int YELLOW  = -256;
	static public int MAGENTA = -65281;
	static public int CYAN    = -16711681;

	static final int HUE        = 50 ;
	static final int SATURATION = 51 ;
	static final int BRIGHTNESS = 52;

	static final int ALPHA = 99 ;

	static final String RANDOM       = "RANDOM";
	static final String RANDOM_ZERO  = "RANDOM ZERO";
	static final String RANDOM_RANGE = "RANDOM RANGE";
}













