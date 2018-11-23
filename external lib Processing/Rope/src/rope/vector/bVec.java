package rope.vector;

import rope.core.BigBangRope;

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
      boolean array [] = {a,b,c,d,e,f};
      return array;
    } else if(num == 6) {
      boolean array [] = {a,b,c,d,e,f};
      return array;
    } else return null ;
  }

}
