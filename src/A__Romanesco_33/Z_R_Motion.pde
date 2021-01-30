/**
ROPE - Romanesco processing environment – 
* Copyleft (c) 2014-2021
* Stan le Punk > http://stanlepunk.xyz/
* Rope Motion  2015-2021
* v 1.4.0
Rope – Romanesco Processing Environment – 
* @author @stanlepunk
* @see https://github.com/StanLepunK/Rope_framework
*/




/**
* Method motion
* v 0.2.0
*/
/**
* follow
* v 0.2.0
*/

vec2 follow(vec2 target, float speed, vec3 buf) {
  vec3 f = follow(target.x(), target.y(), 0, speed, speed, speed, buf);
  return vec2(f.x(),f.y());
}

vec2 follow(vec2 target, vec2 speed, vec3 buf) {
  vec3 f = follow(target.x(), target.y(), 0, speed.x(), speed.y(), 0, buf);
  return vec2(f.x(),f.y());
}

vec2 follow(float tx, float ty, float speed, vec3 buf) {
  vec3 f = follow(tx, ty ,0 ,speed, speed, speed, buf);
  return vec2(f.x(), f.y());
}

vec3 follow(vec3 target, float speed, vec3 buf) {
  return follow(target.x(), target.y(), target.z(), speed, speed, speed, buf);
}

vec3 follow(vec3 target, vec3 speed, vec3 buf) {
  return follow(target.x(), target.y(), target.z(), speed.x(), speed.y(), speed.z(), buf);
}


vec3 follow(float tx, float ty, float tz, float speed, vec3 buf) {
  return follow(tx, ty, tz, speed, speed, speed, buf);
}

/**
* master method
* Compute position vector Traveller, give the target pos and the speed to go.
*/
float check_speed_follow(float speed) {
  if(speed < 0 || speed > 1) {
    printErrTempo(120,"vec3 follow(): speed parameter must be a normal value between [0.0, 1.0]\n instead value 1 is attribute to speed");
    speed = 1.0;
  }
  return speed;
}

vec3 follow(float tx, float ty, float tz, float sx, float sy, float sz, vec3 buf) {
  sx = check_speed_follow(sx);
  sy = check_speed_follow(sy);
  sz = check_speed_follow(sz);
  // calcul X pos
  float dx = tx - buf.x();
  if(abs(dx) != 0) {
    buf.add_x(dx * sx);
  }
  // calcul Y pos
  float dy = ty - buf.y();
  if(abs(dy) != 0) {
    buf.add_y(dy * sy);
  }
  // calcul Z pos
  float dz = tz - buf.z();
  if(abs(dz) != 0) {
    buf.add_z(dz * sy);
  }
  return buf;
}





/**
Class Motion 
v 1.1.0
2016-2018
* @author Stan le Punk
* @see https://github.com/StanLepunK/Motion
*/

class Motion {
  float vel_ref = 1. ;
  float vel = 1. ;
  float max_vel = 1 ;

  float acc = .01 ;
  float dec = .01 ;
  boolean  acc_is = false ;
  boolean  dec_is = true ;

  vec3 dir  ;
  int tempo = 0 ;
  private boolean tempo_is = false ;
  
  // constructor
  Motion() {
  }

  Motion(float max_vel) {
    this.max_vel = max_vel ;
  }



  // get
  float get_velocity() {
    return vel ;
  }

  vec3 get_direction() {
    return dir ;
  }

  float get_acceleration() {
    return acc;
  }

  float get_deceleration() {
    return dec;
  }

  boolean acceleration_is() {
    return acc_is ;
  }

  boolean deceleration_is() {
    return dec_is ;
  }

  boolean velocity_is() {
    if(vel == 0) return false ; else return true ;
  }




  // set
  public void set_deceleration(float dec) {
    this.dec = abs(dec) ;
  }

  public void set_acceleration(float acc) {
    this.acc = abs(acc) ;
  }

  public void set_velocity(float vel) {
    this.vel = vel ;
  }

  public void set_max_velocity(float max_vel) {
    this.max_vel = max_vel ;
  }

  public void set_tempo(int tempo) {
    tempo_is = true ;
    this.tempo = tempo ;
  }

  void reset() {
    this.vel = 0 ;
    this.vel_ref = 0 ;
    if(dir == null) {
      this.dir = vec3(0) ;
    } else {
      this.dir.set(0) ;
    }
  }




  // event
  public void stop() {
    this.vel_ref = this.vel ;
    set_velocity(0) ;
  }

  public void start() {
    set_velocity(vel_ref) ;
  }

  public void acceleration_is(boolean state) {
    acc_is = state ;
  }

  public void deceleration_is(boolean state) {
    dec_is = state ;
  }


  // motion
  // deceleration
  public void deceleration() {
    if(vel > 0) {
      vel -= dec ;
      // to stop object
      if(vel < 0) vel = 0 ;
    } else if(vel < 0 ) {
      vel += dec ;
      if(vel > 0) vel = 0 ;
    }
  }
  
  // acceleration
  public void acceleration() {
    if(vel > 0) {
      vel += acc ;
      // limit the velocity to the maximum velocity
      if(vel > max_vel) vel = max_vel ;
    } else if(vel < 0 ) {
      vel -= acc ;
      // limit the velocity to the maximum velocity
      if(abs(vel) > max_vel) vel = -max_vel ;
    }
  }







  /**
  leading 
  v 0.0.3
  */
  public vec2 leading(vec2 leading_pos, vec2 exec_pos) {
    vec3 current_pos_3D = vec3(leading_pos) ;
    vec3 my_pos_3D = vec3(exec_pos) ;
    vec3 lead = leading(current_pos_3D, my_pos_3D) ;
    return vec2(lead.x, lead.y) ;
  }


  vec3 for_vel ;
  vec3 for_dir ;

  vec3 leading_pos ;
  vec3 leading_ref ;
  boolean apply_acc = false ;

  public vec3 leading(vec3 leading_pos, vec3 exec_pos) {
    if(leading_ref == null) {
      leading_ref = vec3(exec_pos) ;
    }
    vec3 new_pos = vec3(exec_pos) ;

    vec3 velocity_xyz = apply_leading(leading_pos) ;
    if(velocity_xyz.equals(vec3(0))) {
      // follow the lead when this one move
      apply_acc = true ;
      new_pos.sub(sub(leading_ref, leading_pos)) ;
    } else {
      new_pos.add(velocity_xyz) ;
    }
    leading_ref.set(leading_pos) ;
    return new_pos ;
  }


  private vec3 apply_leading(vec3 leading_pos) {
    // init var if var is null
    if (dir == null) {
      dir = vec3() ;
    }
    if (for_vel == null) {
      for_vel = vec3() ;
    }
    if (for_dir == null) {
      for_dir = vec3() ;
    }
    if (leading_pos == null) {
      leading_pos = vec3() ;
    }


    vec3 vel_vec3 = vec3() ;
    leading_pos.set(leading_pos) ;

    if(for_vel.equals(leading_pos)) {
      // limit speed
      if (abs(vel) > max_vel) {
        if(vel < 0) {
          vel = -max_vel ;
        } else {
          vel = max_vel ;
        }
      }
      

      if(abs(vel) >= max_vel || !acc_is) {
        apply_acc = false ;
      }

      if(apply_acc && acc_is) {
        acceleration() ;
      }

      if(!apply_acc && dec_is) {
        deceleration() ;
      }

      // update position
      vel_vec3 = mult(dir, vel) ;
    } else {
      vel = dist(leading_pos, for_vel) ;
      dir = sub(leading_pos, for_dir) ;
      dir.normalize() ;
    }
    for_vel.set(leading_pos) ;

    // calcul direction
    if(!tempo_is) tempo = int(frameRate *.25) ;
    if(tempo != 0) {
      if(frameCount%tempo == 0) {
        for_dir.set(leading_pos) ;
      } 
    }
    
    //
    return vel_vec3 ;
  }
  /**
  end leading
  */

  
}







/**
PATH
*/
class Path extends Motion {
  // list of the keypoint, use super_class Path
  ArrayList<vec3> path ;
  // distance between the keypoint and the position of the translation shape
  float dist_from_start = 0 ;
  float dist_a_b = 0 ;

  // a & b are points to calculate the direction and position of the translation to give at the shape
  // vec3 origin, target ;
  // speed ratio to adjust the speed xy according to position target
  vec3 ratio  ;
  //keypoint 
  vec3 pos ;
  

  // find a good keypoint in the ArrayList
  int n = 0 ;
  int m = 1 ;

  Path() {
    super() ;
    path = new ArrayList<vec3>() ;
    pos = vec3(MAX_INT) ;
  }
   // set
   void set_velocity(float velocity) {
    if(vel < 0) {
      System.err.println("negative value, class Path use the abslolute value of") ;
      System.err.println(vel) ;
    }
    this.vel = abs(vel) ;
   }

  

  // next
  public void previous() {
    vec3 origin, target ;
    if (path.size() > 1 ) {
      vec3 key_a = vec3() ;
      vec3 key_b = vec3() ;
      int origin_rank = path.size() - n -1 ;
      int target_rank = path.size() - m -1 ;
      key_a = (vec3) path.get(origin_rank) ;
      key_b = (vec3) path.get(target_rank) ;

      origin = vec3(key_a) ;
      target = vec3(key_b) ;
      go(origin, target) ;

    } else if (path.size() == 1) {
      vec3 key_a = (vec3) path.get(0) ;
      origin = vec3(key_a) ;
      pos.set(origin) ;
    } else {
      pos.set(-100) ;
    }
  }






  // next
  public void next() {
    vec3 origin, target ;
    if (path.size() > 1 ) {
      vec3 key_a = vec3() ;
      vec3 key_b = vec3() ;
      key_a = (vec3) path.get(n) ;
      key_b = (vec3) path.get(m) ;

      origin = vec3(key_a) ;
      target = vec3(key_b) ;
      go(origin, target) ;

    } else if (path.size() == 1) {
      vec3 key_a = (vec3) path.get(n) ;
      origin = vec3(key_a) ;
      pos.set(origin) ;
    } else {
      pos.set(-100) ;
    }
  }




  // private method of class
  private void go(vec3 origin, vec3 target) {
    if(pos.equals(vec3(MAX_INT))) {
      pos.set(origin) ;
    }
    // distance between the keypoint a & b and the position of the translation shape
    dist_a_b = origin.dist(target) ;
    dist_from_start = pos.dist(origin) ;
    //update the position
    if (dist_from_start < dist_a_b) {
      // calcul speed ratio
      vec3 speed_ratio = sub(origin,target) ;

      // final calcul ratio
      if(ratio == null) {
        ratio = vec3() ;
      }
      ratio.x = speed_ratio.x / speed_ratio.y ;
      ratio.y = speed_ratio.y / speed_ratio.x ;
      if(abs(ratio.x) > abs(ratio.y) ) { 
        ratio.x = 1.0 ; ratio.y = abs(ratio.y) ; 
      } else { 
        ratio.x = abs(ratio.x) ; ratio.y = 1.0 ; 
      }
      
      // Give the good direction to the translation
      if (speed_ratio.x == 0) {
        pos.x += 0 ;
        if (origin.y - target.y < 0 )  {
          pos.y += vel ; 
        } else {
          pos.y -= vel ;
        }
      } 
      if (speed_ratio.y == 0) {
        pos.y += 0 ;
        if (origin.x - target.x < 0 ) {
          pos.x += vel ; 
        } else {
          pos.x -= vel ;
        }     
      }

      if (speed_ratio.x != 0 && speed_ratio.y != 0  )  {
        if (origin.x - target.x < 0 ) {
          pos.x += (vel *ratio.x) ; 
        } else {
          pos.x -= (vel *ratio.x) ;
        }
        if (origin.y - target.y < 0 ) {
          pos.y += (vel *ratio.y) ; 
        } else {
          pos.y -= (vel *ratio.y) ;
        }
      }
    } else {
      n++ ; 
      m++ ;
    }
    //change to the next keypoint 
    if (target.equals(pos)) {  
      m++ ; 
      n++ ; 
    }
    
    if (n != path.size() && m == 1) { 
      m = 1 ; 
      n = 0 ; 
    }
    
    if (m == path.size()) { 
      m = 0 ; 
    }
    
    if (n == path.size()) { 
      n = 0 ; 
    } 
  }









  // get
  vec3 get_pos() {
    return pos ;
  }

  int path_size() {
    return path.size() ;
  }

  vec3 [] path() {
    vec3 [] list = new vec3[path.size()] ;
    for(int i = 0 ; i < path.size() ; i++) {
      list[i] = path.get(i).copy() ;
    }
    return list ;
  }

  ArrayList<vec3> path_ArrayList() {
    return path ;
  }
  

  // add point to the list to make the path
  void add(vec coord) {
    path.add(vec3(coord.x,coord.y,coord.z)) ;
  }
  void add(int x, int y, int z) {
    path.add(vec3(x,y,z)) ;
  }

  void add(int x, int y) {
    path.add(vec3(x,y,0)) ;
  }
}