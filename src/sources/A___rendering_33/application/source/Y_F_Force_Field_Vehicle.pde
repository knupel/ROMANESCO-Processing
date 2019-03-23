/**
* Vehicle
* refactoring by Stan le Punk
* @see @stanlepunk
* @see https://github.com/StanLepunK/Force_Field
* 2017-2019
* v 1.4.1
*
* Run on Processing 3.5.3
* Rope library 0.4.0
*
* work based on the code traduction of Daniel Shiffman from Reynolds Study algorithm
* @see http://natureofcode.com
* @see http://natureofcode.com/book/chapter-6-autonomous-agents/
* About Craig Reynolds 
* @see http://www.red3d.com/cwr/
*/

public class Vehicle implements rope.core.R_Constants {
  // The usual stuff
  private vec2 starting_direction;
  private vec2 position;
  private vec2 velocity;
  private vec2 acceleration;
  private float radius = 1.;
  private float max_force;    // Maximum steering force
  private float ref_max_force;    // Maximum steering force

  private float max_speed;    // Maximum speed
  private float ref_max_speed;  // Maximum speed

  private boolean manage_border_is = false;

  private Force_field ff ;

  public Vehicle(vec2 position, float max_speed, float max_force) {
    this.position = position.copy();
    this.ref_max_speed = this.max_speed = max_speed;
    this.ref_max_force = this.max_force = max_force;
    acceleration = vec2();
    velocity = vec2();
  }
  /**
  set
  */
  public void set_radius(float radius) {
    this.radius = radius;
  }

  public void set_position(vec2 position) {
    if(this.position == null) {
      this.position = vec2(position);
    } else {
      this.position.set(position);
    }
  }

  public void set_speed(float speed) {
    this.ref_max_speed = this.max_speed = speed;
  }

  public void mult_speed(float mult) {
    this.max_speed *=mult;
  }

  public void add_speed(float add) {
    this.max_speed +=add;
  }
  
  /**
  get
  */
  public vec2 get_position() {
    vec2 temp_pos = position.copy() ;
    return temp_pos.add(vec2(ff.canvas_pos));
  }

  public vec2 get_absolute_position() {
    return position ;
  }
  
  public float get_direction() {
    return velocity.angle() ;
  }
  


  /**
  update
  */
  // Method to update position
  public void update(Force_field ff) {
    this.ff = ff ;
    // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(max_speed);
    position.add(velocity);
    // Reset accelertion to 0 each cycle
    acceleration.mult(0);
  }

  /**
  manage border
  */
  public void manage_border(boolean manage_border_is) {
    this.manage_border_is = manage_border_is;
  }


  /**
  SWAP
  v 0.2.1
  */
  public void swap() {
    float res = ff.resolution ;
    float offset_cell_vehicle = radius *2 + (res *.5) ;

    if(ff.type != GRAVITY) {
      swap_border(offset_cell_vehicle,manage_border_is);
    }

    if(ff.type == GRAVITY || ff.type == MAGNETIC) {
      swap_spot(offset_cell_vehicle);
    }   
  }

  /*
  * swap border v 0.0.4
  * before borders
  */
  private void swap_border(float offset_cell_vehicle, boolean from_border_is) {
    go_side(offset_cell_vehicle, from_border_is);
  }

  /*
  * swap_spot v 0.2.0
  */
  private void swap_spot(float offset_cell_vehicle) {
    for(int index = 0 ; index < ff.get_spot_num() ; index++) {
      vec2 pos_vehicle = get_position().copy();
      vec2 pos_spot = vec2(ff.get_spot_pos(index).x,ff.get_spot_pos(index).y);
      vec2 diam = ff.get_spot_size(index);
      int tesla = ff.get_spot_tesla(index);
      
      // GRAVITY case
      if(ff.type == GRAVITY) {
        // GET IN TO THE HOLE
        if(!ff.reverse_is) {
          // go in the hole
          if(inside(pos_spot, diam, pos_vehicle, ELLIPSE)) {
            go_side(offset_cell_vehicle,false);
          }
        // GET OUT OF THE HOLE
        } else {          
          // go out of the hole
          if(!out_of_canvas(offset_cell_vehicle, pos_vehicle)) {
            go_spot();
          }
        }
      }

      // MAGNETIC case
      if(ff.type == MAGNETIC) {
       if(inside(pos_spot, diam, pos_vehicle, ELLIPSE) && tesla > 0) {
          go_spot();
        } 
      }    
    } 
  }


  boolean out_of_canvas(float offset_cell_vehicle, vec2 pos_vehicle) {
    return inside(vec2(-offset_cell_vehicle), vec2(ff.get_canvas()), pos_vehicle, RECT);
  }
  /**
  go
  v 0.2.1
  */
  /*
  * manage vehicle when this one must swap to an other place
  */
  private void go_spot() {
    ArrayList<Spot> list = ff.get_list();
    // select an emitter to spurt out vehicles                                                                
    int spot_emitter = floor(random(list.size()));
    Spot spot = list.get(spot_emitter);
    if(spot.get_size() != null && spot.get_pos() != null) {
      position.set(vec2(0));
      position.add(vec2(spot.get_pos()));
    } else {
      /*
      * recursive in case the spot not initialized, may be it's little dangerous if no spot has be init !
      */
      go_spot();
    }
  }
  

  private void go_side(float offset_cell_vehicle, boolean from_border_is) {
    float offset = offset_cell_vehicle ;
    // go to opposite
    if(from_border_is) {      
      if (position.x < -offset) {
        position.x = ff.get_canvas().x -offset;
      }
      if (position.x > ff.get_canvas().x -offset) {
        position.x = -offset;
      }
      // y pos
      if (position.y < -offset) {
        position.y = ff.get_canvas().y -offset ;
      }
      if (position.y > ff.get_canvas().y -offset) {
        position.y = -offset;
      }
    // go to a random position
    }
    
    boolean swap_is = false ;
    if(from_border_is == false) {
      if (position.x < -offset) swap_is = true;
      else if (position.x > ff.get_canvas().x -offset) swap_is = true;
      else if (position.y < -offset) swap_is = true ;
      else if (position.y > ff.get_canvas().y -offset) swap_is = true;
    }

    if(swap_is || ff.type == GRAVITY ) {
      int which_canvas_side = floor(random(4));
      if(which_canvas_side == 0) {
        position.x = random(ff.canvas.x) -offset;
        position.y = -offset; 
      } else if(which_canvas_side == 1) {
        position.x = random(ff.canvas.x) -offset;
        position.y = ff.canvas.y -offset;
      } else if(which_canvas_side == 2) {
        position.x = -offset;
        position.y = random(ff.canvas.y) -offset;
      } else if(which_canvas_side == 3) {
        position.x = ff.canvas.x -offset;
        position.y = random(ff.canvas.y) -offset;
      }
    }    
  }



  
  /**
  follow
  v 0.1.0
  */
  // Implementing Reynolds' flow field following algorithm
  public void follow() {
    vec2 temp_pos = get_absolute_position().copy();
    vec2 desired  = ff.dir_in_grid(temp_pos);
    vec2 steer = vec2();
    vec2 velocity_total = velocity.copy();

    if(desired != null) {
      starting_direction = null;
      desired.mult(max_speed);
      // Steering is desired minus velocity
      steer = sub(desired, velocity_total);
    // case where the direction returned is null for the emitter spot case  
    } else {
      if(starting_direction == null) {
        float theta = random(-PI,PI);
        starting_direction = vec2(cos(theta),sin(theta));
      }
      steer = sub(starting_direction, velocity_total);
    }

    steer.limit(max_force);  // Limit to maximum steering force
    apply_force(steer);
    reset_param();
  }


  private void reset_param() {
    this.max_speed = this.ref_max_speed;
    this.max_force = this.ref_max_force;
  }

  private void apply_force(vec2 steer) {
    // We could add mass here if we want A = F / M
    acceleration.add(steer);
  }
}
