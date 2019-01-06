package rope.vector;
import rope.core.BigBangRope;
/**
 * bVec class
 * v 1.0.1
 * 2015-2019
 * Processing 3.4
 * Vector with a boolean precision
 * @author Stan le Punk
 * @see http://stanlepunk.xyz/
 * @see https://github.com/StanLepunK/Rope
*/
public abstract class bVec extends BigBangRope {
	private int num ;
	public boolean x,y,z,w;
	public boolean a,b,c,d,e,f;
	public bVec(int num) {
		this.num = num;
	}
	
	public int get_num() {
		return this.num;
	}
	
	
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
      boolean array [] = {a,b,c,d,e};
      return array;
    } else if(num == 6) {
      boolean array [] = {a,b,c,d,e,f};
      return array;
    } else return null ;
  }

}
