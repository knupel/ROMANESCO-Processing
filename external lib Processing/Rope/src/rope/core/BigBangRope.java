package rope.core;
/**
	* ROPE > Romanesco processing environment
	* Copyleft (c) 2014-2018
	* v 0.0.1
	* Processing 3.4
	* @author Stan le Punk
	* @see http://stanlepunk.xyz/
	* @see https://github.com/StanLepunK/Rope
	*/
//import processing.core.*;
import java.util.Random;
public abstract class BigBangRope implements RConstants {

	private String VERSION = "##Rope 0.0.2##";
	
	public String version() {
		return VERSION;
	}
	
	// I try to catch Processing method but my knowledge is to low ta pass this Static problem,
	// so I rewrite the method from processing core
	// return processing.core.PApplet.random(high);
	// Cannot make a static reference to the non-static method random(float) from the type PApplet
	
	/**
	 * 
	 * @param high
	 * @return random number, this method is a copy of Processing one
	 */
	Random internalRandom;
	protected float random(float high) {
		// avoid an infinite loop when 0 or NaN are passed in
		if (high == 0 || high != high) {
			return 0;
		}
		
		if (internalRandom == null) {
			internalRandom = new Random();
		}

		// for some reason (rounding error?) Math.random() * 3
		// can sometimes return '3' (once in ~30 million tries)
		// so a check was added to avoid the inclusion of 'howbig'
		float value = 0;
		do {
			value = internalRandom.nextFloat() * high;
		} while (value == high);
		return value;
	}
	
	
	/**
	 * 
	 * @param low
	 * @param high
	 * @return random number, this method is a copy of Processing one
	 */
	protected float random(float low, float high) {	
		if (low >= high) return low;
		float diff = high - low;
		float value = 0;
		// because of rounding error, can't just add low, otherwise it may hit high
		// https://github.com/processing/processing/issues/4551
		do {
			value = random(diff) + low;
		} while (value == high);
		return value;
	}



	// Min_MAX
	private String ERROR_MIN_MAX = "Cannot use min() or max() on an empty array.";
	/**
	 * 
	 * @param arg
	 * @return from Processing max() method
	 */
	protected float max(float[] list) {
    if (list.length == 0) {
      throw new ArrayIndexOutOfBoundsException(ERROR_MIN_MAX);
    }
    float max = list[0];
    for (int i = 1; i < list.length; i++) {
      if (list[i] > max) max = list[i];
    }
    return max;
  }
	
  /**
   * 
   * @param arg
   * @return Processing min() method
   */
	protected float min(float[] list) {
    if (list.length == 0) {
      throw new ArrayIndexOutOfBoundsException(ERROR_MIN_MAX);
    }
    float min = list[0];
    for (int i = 1; i < list.length; i++) {
      if (list[i] < min) min = list[i];
    }
    return min;
  }

  /**
   * 
   * @param value
   * @param start1
   * @param stop1
   * @param start2
   * @param stop2
   * @return Processing map() method
   */
  protected float map(float value, 	float start1, float stop1,
                                		float start2, float stop2) {
    float outgoing =
      start2 + (stop2 - start2) * ((value - start1) / (stop1 - start1));
    String badness = null;
    if (outgoing != outgoing) {
      badness = "NaN (not a number)";

    } else if (outgoing == Float.NEGATIVE_INFINITY ||
               outgoing == Float.POSITIVE_INFINITY) {
      badness = "infinity";
    }
    if (badness != null) {
      final String msg =
        String.format("map(%s, %s, %s, %s, %s) called, which returns %s",
                      value, start1, stop1,
                      start2, stop2, badness);
      System.out.println(msg);
    }
    return outgoing;
  }
  
  
  
  /**
  Next Gaussian randomize
  v 0.0.2
  */
  /**
  * return value from -1 to 1
  * @return float
  */
  Random random = new Random();
  public float random_next_gaussian() {
    return random_next_gaussian(1,1);
  }

  public float random_next_gaussian(int n) {
    return random_next_gaussian(1,n);
  }

  public float random_next_gaussian(float range) {
    return random_next_gaussian(range,1);
  }

  public float random_next_gaussian(float range, int n) {
    float roots = (float)random.nextGaussian();
    float var = map(roots,-2.5f,2.5f,-1,1);  
    if(n > 1) {
      if(n%2 ==0 && var < 0) {
         var = -1 *(float)Math.pow(var,n);
       } else {
         var = (float)Math.pow(var,n);
       }
       return var *range ;
    } else {
      return var *range ;
    }
  }
}

