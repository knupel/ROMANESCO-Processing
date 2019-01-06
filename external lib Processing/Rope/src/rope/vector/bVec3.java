package rope.vector;

public class bVec3 extends bVec {
	
	public bVec3(boolean x, boolean y, boolean z) {
		super(3);
		set(x,y,z);
		
	}
	
	public bVec3(boolean arg) {
		super(3);
		set(arg);
	}
	
	public bVec3(bVec b) {
		super(3);	
		set(b);
	}

	/**
   * set
   * @param x
   * @param y
   * @param z
   * @return
   */
  public bVec3 set(boolean x, boolean y, boolean z) {
  	this.x = x;
  	this.y = y;
  	this.z = z;
  	return this;
  }
  
  public bVec3 set(boolean arg){
    set(arg,arg,arg);
    return this;
  }

  public bVec3 set(bVec v) {
    if(v == null) {
      this.x = this.y = this.z = false;
      return this;
    } else if(v instanceof bVec5 || v instanceof bVec6) {
      set(v.a,v.b,v.c);
      return this;
    } else {
      set(v.x,v.y,v.z);
      return this;
    }
  }

  // xyz
  public bVec3 set_x(boolean x) {
    return set(x,this.y,this.z);
  }

  public bVec3 set_y(boolean y) {
    return set(this.x,y,this.z);
  }

  public bVec3 set_z(boolean z) {
    return set(this.x,this.y,z);
  }
	
	@Override 
	public String toString() {
		return "[ " + x + ", " + y + ", " + z + " ]";
	}

}
