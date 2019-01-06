package rope.vector;

public class bVec2 extends bVec {
	
	public bVec2(boolean x,boolean y) {
		super(2);
		set(x,y);
	}
	
	public bVec2(boolean arg) {
		super(2);
		set(arg);
	}
	
	public bVec2(bVec b) {
		super(2);
		set(b);	
	}


	/**
   * set
   * @param x
   * @param y
   * @return
   */
  public bVec2 set(boolean x, boolean y) {
  	this.x = x;
  	this.y = y;
  	return this;
  }
  
  public bVec2 set(boolean arg){
    set(arg,arg);
    return this;
  }
  
  public bVec2 set(bVec v) {
    if(v == null) {
      this.x = this.y = false;
      return this;
    } else if(v instanceof bVec5 || v instanceof bVec6) {
      set(v.a,v.b);
      return this;
    } else {
      set(v.x,v.y);
      return this;
    }
  }
  
  // xy
  public bVec2 set_x(boolean x) {
    return set(x,this.y);
  }

  public bVec2 set_y(boolean y) {
    return set(this.x,y);
  }
	
	
	
	@Override 
	public String toString() {
		return "[ " + x + ", " + y + " ]";
	}

}
