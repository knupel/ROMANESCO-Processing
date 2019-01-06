package rope.vector;
import rope.core.BigBangRope;
/**
 * iVec class
 * v 1.0.1
 * 2015-2018
 * Processing 3.4
 * Vector with a integer precision
 * @author Stan le Punk
 * @see http://stanlepunk.xyz/
 * @see https://github.com/StanLepunK/Rope
*/
public abstract class iVec extends BigBangRope {
	private int num;
	public int x,y,z,w;
	public int a,b,c,d,e,f;
	public int r,g;
	public int s,t,p,q;
	public int u,v;
	

	public iVec(int num) {
		this.num = num;
	}
	
	/**
	 * @return the number of component
	 */
	public int get_num() {
		return num;
	}

	/**
	* return the list of component
	* @return float []
	*/
	public int [] get_array() {
		if(num == 2) {
			int array [] = {x,y};
			return array;
		} else if(num == 3) {
			int array [] = {x,y,z};
			return array;
		} else if(num == 4) {
			int array [] = {x,y,z,w};
			return array;
		} else if(num == 5) {
			int array [] = {a,b,c,d,e};
			return array;
		} else if(num == 6) {
			int array [] = {a,b,c,d,e,f};
			return array;
		} else return null ;
	}
}
