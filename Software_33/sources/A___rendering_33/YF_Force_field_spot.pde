/**
SPOT
v 0.2.0
*/
public class Spot {
  private Vec previous_pos;
  private Vec pos; 
  // private Vec raw_pos;
  private Vec size;
  private boolean reverse_charge_is;
  private boolean emitter_is;

  ArrayList<iVec2> area_detection;

  private int tesla = 0;
  private int mass = 0;
  
  // constructor
  public Spot() {

  }



  // set
  public void set_pos(Vec pos) {
    if(pos instanceof Vec2) {
      if(this.pos == null) {
        this.previous_pos = Vec2();
      } else {
        this.previous_pos = Vec2(this.pos.x, this.pos.y);
      }
      this.pos = Vec2((Vec2)pos);
    } else if(pos instanceof Vec3) {
      if(this.pos == null) {
        this.previous_pos = Vec3();
      } else {
        this.previous_pos = Vec3(this.pos.x, this.pos.y,this.pos.z);
      }
      this.pos = Vec3((Vec3)pos);
    }
  }

  public void set_size(Vec size) {
    if(size instanceof Vec2) {
      this.size = Vec2((Vec2)size);
    } else if(size instanceof Vec3) {
      this.size = Vec3((Vec3)size);
    }
  }

  public void reverse_charge(boolean reverse_is) {
    this.reverse_charge_is = reverse_is ;
  }

  public void set_tesla(int tesla) {
    this.tesla = tesla ;
  }

  public void set_mass(int mass) {
    this.mass = abs(mass) ;
  } 

  // get
  public int get_mass() {
    return mass;
  }

  public int get_tesla() {
    if(!reverse_charge_is) return tesla; else return -tesla ;
  }

  public Vec get_pos() {
    return pos;
  }

  public Vec get_size() {
    return size;
  }

  // misc
  public boolean emitter_is() {
    if(get_tesla() < 0 || emitter_is) return true ; else return false;
  }

  public void reverse_emitter(boolean state) {
    this.emitter_is = state ;
  }
  

  // area_detection
  private void detection(int radius) {
    if(area_detection == null) {
      area_detection = new ArrayList<iVec2>(); 
      add(radius);
    } else {
      area_detection.clear();
      add(radius);
    }   
  }

  private void add(int radius) {
    for(int x = -radius ; x <= radius ; x++) {
      for(int y = -radius ; y <= radius ; y++) {
        if(inside(Vec2(0), Vec2(radius), Vec2(x,y), ELLIPSE)) {
          iVec2 in = iVec2(x,y);
          area_detection.add(in);
        }  
      }
    }
  }

  ArrayList<iVec2> get_detection() {
    return area_detection;
  }


  public boolean activity_is() {
    if(pos.x != previous_pos.x || pos.y != previous_pos.y || pos.z != previous_pos.z) {
      return true; 
    } else {
      return false;
    }
  }
}