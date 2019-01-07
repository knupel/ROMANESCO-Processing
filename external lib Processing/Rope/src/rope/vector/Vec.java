package rope.vector;
import rope.core.BigBangRope;
/**
 * Vec class
 * v 1.17.1
* 2015-2018
* Processing 3.4 compatible
* Vector class with a float precision
 * @author Stan le Punk
 * @see http://stanlepunk.xyz/
 * @see https://github.com/StanLepunK/Rope
*/
public abstract class Vec extends BigBangRope {
	public int num;
	public float x,y,z,w = Float.NaN;
	public float a,b,c,d,e,f = Float.NaN;
	public float r,g = Float.NaN;
	public float s,t,p,q = Float.NaN;
	public float u,v = Float.NaN;
	
  public Vec(int num) {
  	// super();
    this.num = num;
  }
  /**
  * @return the number of components
  */
  public int get_num() {
    return num;
  }

  /**
  array
  */
  /**
  * return the list of component
  * @return float []
  */
  public float [] array() {
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
      float array [] = {a,b,c,d,e};
      return array;
    } else if(num == 6) {
      float array [] = {a,b,c,d,e,f};
      return array;
    } else return null ;
  }
}
