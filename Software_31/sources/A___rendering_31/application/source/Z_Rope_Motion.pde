/**
ROPE - Romanesco processing environment – 
* Copyleft (c) 2014-2017 
* Stan le Punk > http://stanlepunk.xyz/
Rope Motion  2015 – 2017
v 1.1.0
Rope – Romanesco Processing Environment – 
* @author Stan le Punk
* @see https://github.com/StanLepunK/Rope
*/




/**
Method motion
v 0.1.0
*/
Vec2 follow(Vec2 target, float speed) {
  Vec3 f = follow(Vec3(target.x,target.y,0), speed);
  return Vec2(f.x,f.y);
}

Vec3 dest_3D_follow_rope;
// Compute position Vector Traveller, give the target pos and the speed to go.
Vec3 follow(Vec3 target, float speed) {
  if(dest_3D_follow_rope == null) dest_3D_follow_rope = Vec3();
  // calcul X pos
  float dx = target.x - dest_3D_follow_rope.x;
  if(abs(dx) != 0) {
    dest_3D_follow_rope.x += dx * speed;
  }
  // calcul Y pos
  float dy = target.y - dest_3D_follow_rope.y;
  if(abs(dy) != 0) {
    dest_3D_follow_rope.y += dy * speed;
  }
  // calcul Z pos
  float dz = target.z - dest_3D_follow_rope.z;
  if(abs(dz) != 0) {
    dest_3D_follow_rope.z += dz * speed;
  }
  return dest_3D_follow_rope;
}






/**
Class Motion 
v 1.0.7.2
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

  Vec3 dir  ;
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

  Vec3 get_direction() {
    return dir ;
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
      this.dir = Vec3(0) ;
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
  public Vec2 leading(Vec2 leading_pos, Vec2 exec_pos) {
    Vec3 current_pos_3D = Vec3(leading_pos) ;
    Vec3 my_pos_3D = Vec3(exec_pos) ;
    Vec3 lead = leading(current_pos_3D, my_pos_3D) ;
    return Vec2(lead.x, lead.y) ;
  }


  Vec3 for_vel ;
  Vec3 for_dir ;

  Vec3 leading_pos ;
  Vec3 leading_ref ;
  boolean apply_acc = false ;

  public Vec3 leading(Vec3 leading_pos, Vec3 exec_pos) {
    if(leading_ref == null) {
      leading_ref = Vec3(exec_pos) ;
    }
    Vec3 new_pos = Vec3(exec_pos) ;

    Vec3 velocity_xyz = apply_leading(leading_pos) ;
    if(velocity_xyz.equals(Vec3(0))) {
      // follow the lead when this one move
      apply_acc = true ;
      new_pos.sub(sub(leading_ref, leading_pos)) ;
    } else {
      new_pos.add(velocity_xyz) ;
    }
    leading_ref.set(leading_pos) ;
    return new_pos ;
  }


  private Vec3 apply_leading(Vec3 leading_pos) {
    // init var if var is null
    if (dir == null) {
      dir = Vec3() ;
    }
    if (for_vel == null) {
      for_vel = Vec3() ;
    }
    if (for_dir == null) {
      for_dir = Vec3() ;
    }
    if (leading_pos == null) {
      leading_pos = Vec3() ;
    }


    Vec3 vel_vec3 = Vec3() ;
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
  ArrayList<Vec3> path ;
  // distance between the keypoint and the position of the translation shape
  float dist_from_start = 0 ;
  float dist_a_b = 0 ;

  // a & b are points to calculate the direction and position of the translation to give at the shape
  // Vec3 origin, target ;
  // speed ratio to adjust the speed xy according to position target
  Vec3 ratio  ;
  //keypoint 
  Vec3 pos ;
  

  // find a good keypoint in the ArrayList
  int n = 0 ;
  int m = 1 ;

  Path() {
    super() ;
    path = new ArrayList<Vec3>() ;
    pos = Vec3(MAX_INT) ;
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
    Vec3 origin, target ;
    if (path.size() > 1 ) {
      Vec3 key_a = Vec3() ;
      Vec3 key_b = Vec3() ;
      int origin_rank = path.size() - n -1 ;
      int target_rank = path.size() - m -1 ;
      key_a = (Vec3) path.get(origin_rank) ;
      key_b = (Vec3) path.get(target_rank) ;

      origin = Vec3(key_a) ;
      target = Vec3(key_b) ;
      go(origin, target) ;

    } else if (path.size() == 1) {
      Vec3 key_a = (Vec3) path.get(0) ;
      origin = Vec3(key_a) ;
      pos.set(origin) ;
    } else {
      pos.set(-100) ;
    }
  }






  // next
  public void next() {
    Vec3 origin, target ;
    if (path.size() > 1 ) {
      Vec3 key_a = Vec3() ;
      Vec3 key_b = Vec3() ;
      key_a = (Vec3) path.get(n) ;
      key_b = (Vec3) path.get(m) ;

      origin = Vec3(key_a) ;
      target = Vec3(key_b) ;
      go(origin, target) ;

    } else if (path.size() == 1) {
      Vec3 key_a = (Vec3) path.get(n) ;
      origin = Vec3(key_a) ;
      pos.set(origin) ;
    } else {
      pos.set(-100) ;
    }
  }




  // private method of class
  private void go(Vec3 origin, Vec3 target) {
    if(pos.equals(Vec3(MAX_INT))) {
      pos.set(origin) ;
    }
    // distance between the keypoint a & b and the position of the translation shape
    dist_a_b = origin.dist(target) ;
    dist_from_start = pos.dist(origin) ;
    //update the position
    if (dist_from_start < dist_a_b) {
      // calcul speed ratio
      Vec3 speed_ratio = sub(origin,target) ;

      // final calcul ratio
      if(ratio == null) {
        ratio = Vec3() ;
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
  Vec3 get_pos() {
    return pos ;
  }

  int path_size() {
    return path.size() ;
  }

  Vec3 [] path() {
    Vec3 [] list = new Vec3[path.size()] ;
    for(int i = 0 ; i < path.size() ; i++) {
      list[i] = path.get(i).copy() ;
    }
    return list ;
  }

  ArrayList<Vec3> path_ArrayList() {
    return path ;
  }
  

  // add point to the list to make the path
  void add(Vec coord) {
    path.add(Vec3(coord.x,coord.y,coord.z)) ;
  }
  void add(int x, int y, int z) {
    path.add(Vec3(x,y,z)) ;
  }

  void add(int x, int y) {
    path.add(Vec3(x,y,0)) ;
  }
}
