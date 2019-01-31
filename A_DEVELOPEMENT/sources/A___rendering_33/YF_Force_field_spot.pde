/**
SPOT
* @see http://stanlepunk.xyz
* @see https://github.com/StanLepunK/Force_Field
v 0.3.0
*/
public class Spot {
  private vec previous_pos;
  private vec pos; 
  // private Vec raw_pos;
  private vec size;
  private boolean reverse_charge_is;
  private boolean emitter_is;

  ArrayList<ivec2> area_detection;

  private int tesla = 0;
  private int mass = 0;
  
  // constructor
  public Spot() {

  }



  // set
  public void set_pos(vec pos) {
    if(pos instanceof vec2) {
      if(this.pos == null) {
        this.previous_pos = vec2();
      } else {
        this.previous_pos = vec2(this.pos.x, this.pos.y);
      }
      this.pos = vec2((vec2)pos);
    } else if(pos instanceof vec3) {
      if(this.pos == null) {
        this.previous_pos = vec3();
      } else {
        this.previous_pos = vec3(this.pos.x, this.pos.y,this.pos.z);
      }
      this.pos = vec3((vec3)pos);
    }
  }

  public void set_size(vec size) {
    if(size instanceof vec2) {
      this.size = vec2((vec2)size);
    } else if(size instanceof vec3) {
      this.size = vec3((vec3)size);
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
    if(!reverse_charge_is) {
      return tesla; 
    } else {
      return -tesla;
    }
  }

  public vec get_pos() {
    return pos;
  }

  public vec get_size() {
    return size;
  }

  // misc
  public boolean emitter_is() {
    if(get_tesla() < 0 || emitter_is) {
      return true; 
    } else {
      return false;
    }
  }

  public void reverse_emitter(boolean state) {
    this.emitter_is = state ;
  }
  

  // area_detection
  private void detection(int radius) {
    if(area_detection == null) {
      area_detection = new ArrayList<ivec2>(); 
      add(radius);
    } else {
      area_detection.clear();
      add(radius);
    }   
  }

  private void add(int radius) {
    for(int x = -radius ; x <= radius ; x++) {
      for(int y = -radius ; y <= radius ; y++) {
        if(inside(vec2(0), vec2(radius), vec2(x,y), ELLIPSE)) {
          ivec2 in = ivec2(x,y);
          area_detection.add(in);
        }  
      }
    }
  }

  ArrayList<ivec2> get_detection() {
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