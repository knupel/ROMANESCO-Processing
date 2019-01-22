/**
ROPE SCIENCE
v 0.4.0
* Copyleft (c) 2014-2018 
* Stan le Punk > http://stanlepunk.xyz/
* @author Stan le Punk
* @see https://github.com/StanLepunK/Rope_method
*
the sketch method tab is not included on this repository if you need
* @see https://github.com/StanLepunK/Old_code/tree/master/Science_rope_2017_12_8
*/

/**
WAVE
*/
float sin_wave(float speed, float scale) {
  return sin(frameCount*speed)*scale;
}

Vec2 sin_wave(Vec2 speed, Vec2 scale) {
  float x = sin(frameCount*speed.x)*scale.x;
  float y = sin(frameCount*speed.y)*scale.y;
  return Vec2(x,y);
}

Vec3 sin_wave(Vec3 speed, Vec3 scale) {
  float x = sin(frameCount*speed.x)*scale.x;
  float y = sin(frameCount*speed.y)*scale.y;
  float z = sin(frameCount*speed.z)*scale.z;
  return Vec3(x,y,z);
}

Vec4 sin_wave(Vec4 speed, Vec4 scale) {
  float x = sin(frameCount*speed.x)*scale.x;
  float y = sin(frameCount*speed.y)*scale.y;
  float z = sin(frameCount*speed.z)*scale.z;
  float w = sin(frameCount*speed.w)*scale.w;
  return Vec4(x,y,z,w);
}


float cos_wave(float speed, float scale) {
  return cos(frameCount*speed)*scale;
}

Vec2 cos_wave(Vec2 speed, Vec2 scale) {
  float x = cos(frameCount*speed.x)*scale.x;
  float y = cos(frameCount*speed.y)*scale.y;
  return Vec2(x,y);
}

Vec3 cos_wave(Vec3 speed, Vec3 scale) {
  float x = cos(frameCount*speed.x)*scale.x;
  float y = cos(frameCount*speed.y)*scale.y;
  float z = cos(frameCount*speed.z)*scale.z;
  return Vec3(x,y,z);
}

Vec4 cos_wave(Vec4 speed, Vec4 scale) {
  float x = cos(frameCount*speed.x)*scale.x;
  float y = cos(frameCount*speed.y)*scale.y;
  float z = cos(frameCount*speed.z)*scale.z;
  float w = cos(frameCount*speed.w)*scale.w;
  return Vec4(x,y,z,w);
}




















/**
Physic Rope
v 0.0.2
*/
public double g_force(double dist, double m_1, double m_2) {
  return RConstants.G *(dist*dist)/(m_1 *m_2);
}



/**
Math rope 
v 1.8.17
* @author Stan le Punk
* @see https://github.com/StanLepunK/Math_rope
*/
/**
Algebra utils
*/
//roots dimensions n
float roots(float valueToRoots, int n) {
  return pow(valueToRoots, 1.0/n) ;
}

// Decimal
// @return a specific quantity of decimal after comma
float decimale (float var, int n) {
  float div = pow(10, abs(n)) ;
  return Math.round(var *div) / div;
}


/**
geometry util
v. 0.0.7
*/
float perimeter_disc(int r) {
  return 2 *r *PI ;
}

float radius_from_circle_surface(int surface) {
  return sqrt(surface/PI) ;
}


boolean inside(iVec pos, iVec size, iVec2 target_pos) {
  return inside(Vec2(pos.x,pos.y), Vec2(size.x,size.y), Vec2(target_pos), ELLIPSE);
}

boolean inside(iVec pos, iVec size, iVec2 target_pos, int type) {
  return inside(Vec2(pos.x,pos.y), Vec2(size.x,size.y), Vec2(target_pos), type);
}

boolean inside(Vec pos, Vec size, Vec2 target_pos) {
  return inside(pos, size, target_pos, ELLIPSE);
}

boolean inside(Vec pos, Vec size, Vec2 target_pos, int type) {
  if(type == ELLIPSE) {
    // this part can be improve to check the 'x' and the 'y'
    if (dist(Vec2(pos.x,pos.y), target_pos) < size.x *.5) return true ; 
    else return false ;
  } else {
    if(target_pos.x > pos.x && target_pos.x < pos.x +size.x && 
       target_pos.y > pos.y && target_pos.y < pos.y +size.y) return true ; 
      else return false ;
  } 
}






/**
GEOMETRY POLAR and CARTESIAN
*/
/**
Info
http://mathinsight.org/vectors_cartesian_coordinates_2d_3d
http://zone.ni.com/reference/en-XX/help/371361H-01/gmath/3d_cartesian_coordinate_rotation_euler/
http://www.mathsisfun.com/polar-cartesian-coordinates.html
https://en.wikipedia.org/wiki/Spherical_coordinate_system
http://stackoverflow.com/questions/20769011/converting-3d-polar-coordinates-to-cartesian-coordinates
http://www.vias.org/comp_geometry/math_coord_convert_3d.htm
http://mathworld.wolfram.com/Sphere.html
*/
/*
@return float
*/
float longitude(float x, float range) {
  return map(x, 0,range, 0, TAU) ;
}

float latitude(float y, float range) {
  return map(y, 0,range, 0, TAU) ;
}

/**
angle
v 0.0.2
* @return float
*/
float angle_radians(float y, float range) {
  return map(y, 0,range, 0, TAU) ;
}

float angle_degrees(float y, float range) {
  return map(y, 0,range, 0, 360) ;
}

float angle(Vec2 a, Vec2 b) {
  return atan2(b.y -a.y, b.x -a.x);
}

float angle(Vec2 v) {
  return atan2(v.y, v.x);
}



  

/* 
return a vector info : radius,longitude, latitude
@return Vec3
*/
Vec3 to_polar(Vec3 cart) {
  float radius = sqrt(cart.x * cart.x + cart.y * cart.y + cart.z * cart.z);
  float phi = acos(cart.x / sqrt(cart.x * cart.x + cart.y * cart.y)) * (cart.y < 0 ? -1 : 1);
  float theta = acos(cart.z / radius) * (cart.z < 0 ? -1 : 1);
  // check NaN result
  if (Float.isNaN(phi)) phi = 0 ;
  if (Float.isNaN(theta)) theta = 0 ;
  if (Float.isNaN(radius)) radius = 0 ;
  // result
  //return new Vec3(radius, longitude, latitude) ;
  return new Vec3(phi, theta, radius) ;
}


///////////////
// Cartesian 3D
/*
@ return Vec3
return the position of point on Sphere, with longitude and latitude
*/
//If you want just the final pos
Vec3 to_cartesian_3D(Vec2 pos, Vec2 range, float sizeField)  {
  // vertical plan position
  float verticalY = to_cartesian_2D(pos.y, Vec2(0,range.y), Vec2(0,TAU), sizeField).x ;
  float verticalZ = to_cartesian_2D(pos.y, Vec2(0,range.y), Vec2(0,TAU), sizeField).y ; 
  Vec3 posVertical = new Vec3(0, verticalY, verticalZ) ;
  // horizontal plan position
  float horizontalX = to_cartesian_2D(pos.x, Vec2(0,range.x), Vec2(0,TAU), sizeField).x ; 
  float horizontalZ = to_cartesian_2D(pos.x, Vec2(0,range.x), Vec2(0,TAU), sizeField).y  ;
  Vec3 posHorizontal = new Vec3(horizontalX, 0, horizontalZ) ;
  
  return projection(middle(posVertical, posHorizontal), sizeField) ;
}

Vec3 to_cartesian_3D(float latitude, float longitude) {
  float radius_normal = 1 ;
  return to_cartesian_3D(latitude, longitude, radius_normal);
}

// main method
Vec3 to_cartesian_3D(float latitude, float longitude,  float radius) {
  // https://en.wikipedia.org/wiki/List_of_common_coordinate_transformations
  

  /*
  //  Must be improve is not really good in the border versus direct polar rotation with the matrix
  */ 
  float theta = longitude%TAU ;
  float phi = latitude%PI ;

  float x = radius *sin(theta) *cos(phi);
  float y = radius *sin(theta) *sin(phi);
  float z = radius *cos(theta);
  return new Vec3(x, y, z);
}
/*
Vec3 to_cartesian_3D(float longitude, float latitude, float radius) {
  // https://en.wikipedia.org/wiki/List_of_common_coordinate_transformations
  float x = radius *sin(latitude) *cos(longitude);
  float y = radius *sin(latitude) *sin(longitude);
  float z = radius *cos(latitude);
  return new Vec3(x, y, z);
}
*/



//Step 1 : translate the mouse position x and y  on the sphere, we must do that separately
/*
@ return Vec2 
return linear value on the circle perimeter
*/
Vec2 to_cartesian_2D (float posMouse, Vec2 range, Vec2 targetRadian, float distance) {
  float rotationPlan = map(posMouse, range.x, range.y, targetRadian.x, targetRadian.y)  ;
  return to_cartesian_2D (rotationPlan, distance) ;
}

Vec2 to_cartesian_2D (float angle) {
  float radius_normal = 1 ;
  return to_cartesian_2D (angle, radius_normal) ;
}

// main method
Vec2 to_cartesian_2D (float angle, float radius) {
  float x = cos(angle) *radius;
  float y = sin(angle) *radius ;
  return Vec2(x,y) ;
}







/**
Projection
*/
// Cartesian projection 2D
Vec2 projection(Vec2 direction) {
  return projection(direction, Vec2(), 1.) ;
}

Vec2 projection(Vec2 direction, float radius) {
  return projection(direction, Vec2(), radius) ;
}
Vec2 projection(Vec2 direction, Vec2 origin, float radius) {
  // Vec3 p = point_to_project.normalize(origin) ;
  Vec2 ref = direction.copy() ;
  Vec2 p = ref.dir(origin) ;
  p.mult(radius) ;
  p.add(origin) ;
  return p ;
}
// polar projection 2D
Vec2 projection(float angle) {
  return projection(angle, 1) ;
}
Vec2 projection(float angle, float radius) {
  return Vec2(cos(angle) *radius, sin(angle) *radius) ;
}
// cartesian projection 3D
Vec3 projection(Vec3 direction) {
  return projection(direction, Vec3(), 1.) ;
}

Vec3 projection(Vec3 direction, float radius) {
  return projection(direction, Vec3(), radius) ;
}

Vec3 projection(Vec3 direction, Vec3 origin, float radius) {
  Vec3 ref = direction.copy() ;
  Vec3 p = ref.dir(origin) ;
  p.mult(radius) ;
  p.add(origin) ;
  return p ;
}


/**
look at 
before target direction
v 0.0.2
*/
// Target direction return the normal direction of the target from the origin
@Deprecated
Vec2 target_direction(Vec2 target, Vec2 my_position) {
  printErrTempo(240, "Vec2 target_direction() deprecated instead use look_at(Vec target, Vec origin) method, becareful the result is mult by -1");
  return projection(target, my_position, 1).sub(my_position);
}

@Deprecated
Vec3 target_direction(Vec3 target, Vec3 my_position) {
   printErrTempo(240, "Vec2 target_direction() deprecated instead use look_at(Vec target, Vec origin) method, becareful the result is mult by -1");
  return projection(target, my_position, 1).sub(my_position) ;
}


Vec2 look_at(Vec2 target, Vec2 origin) {
  return projection(target, origin, 1).sub(origin).mult(-1,1);
}

Vec3 look_at(Vec3 target, Vec3 origin) {
  return projection(target, origin, 1).sub(origin);
}





/**
SPHERE PROJECTION
*/
/**
FIBONACCI SPHERE PROJECTION CARTESIAN
*/
Vec3 [] list_cartesian_fibonacci_sphere (int num, float step, float root) {
  float root_sphere = root *num ;
  Vec3 [] list_points = new Vec3[num] ;
  for (int i = 0; i < list_points.length ; i++) list_points[i] = distribution_cartesian_fibonacci_sphere(i, num, step, root_sphere) ;
  return list_points ;
}
/*
float root_cartesian_fibonnaci(int num) {
  return random(1) *num ;
}
*/

Vec3 distribution_cartesian_fibonacci_sphere(int n, int num, float step, float root) {
  if(n<num) {
    float offset = 2. / num ;
    float y  = (n *offset) -1 + (offset / 2.) ;
    float r = sqrt(1 - pow(y,2)) ;
    float phi = ((n +root)%num) * step ;
    
    float x = cos(phi) *r ;
    float z = sin(phi) *r ;
    
    return Vec3(x,y,z) ;
  } else return Vec3() ;
}

/**
POLAR PROJECTION FIBONACCI SPHERE
*/
Vec2 [] list_polar_fibonacci_sphere(int num, float step) {
  Vec2 [] list_points = new Vec2[num] ;
  for (int i = 0; i < list_points.length ; i++) list_points[i] = distribution_polar_fibonacci_sphere(i, num, step) ;
  return list_points ;
}
Vec2 distribution_polar_fibonacci_sphere(int n, int num, float step) {
  if(n<num) {
    float longitude = r.PHI *TAU *n;
    longitude /= step ;
    // like a normalization of the result ?
    longitude -= floor(longitude); 
    longitude *= TAU;
    if (longitude > PI)  longitude -= TAU;
    // Convert dome height (which is proportional to surface area) to latitude
    float latitude = asin(-1 + 2*n/(float)num);
    return Vec2(longitude, latitude) ;
  } else return Vec2() ;

}




// normal direction 0-360 to -1, 1 PVector
PVector normal_direction(int direction) {
  int numPoints = 360;
  float angle = TWO_PI/(float)numPoints;
  direction = 360-direction;
  direction += 180;
  return new PVector(sin(angle*direction), cos(angle*direction));
}

// degre direction from PVector direction
float deg360 (PVector dir) {
  float deg360 ;
  deg360 = 360 -(degrees(atan2(dir.x, dir.y)) +180)   ;
  return deg360 ;
}

float deg360 (Vec2 dir) {
  float deg360 ;
  deg360 = 360 -(degrees(atan2(dir.x, dir.y)) +180)   ;
  return deg360 ;
}

/**
ROTATION
*/
//Rotation Objet
void rotation (float angle, float posX, float posY) {
  translate(posX, posY ) ;
  rotate (radians(angle) ) ;
}
void rotation (float angle, Vec2 pos) {
  translate(pos.x, pos.y) ;
  rotate (radians(angle) ) ;
}

Vec2 rotation (Vec2 ref, Vec2 lattice, float angle) {
  float a = angle(lattice, ref) + angle;
  float d = lattice.dist(ref);
  float x = lattice.x + cos( a ) * d;
  float y = lattice.y + sin( a ) * d;
  return Vec2(x,y);
}

/**
May be must push to deprecated
*/
Vec2 rotation_lattice(Vec2 ref, Vec2 lattice, float angle) {
  float a = angle( lattice, ref ) + angle;
  float d = dist( lattice, ref );
  float x = lattice.x + cos( a ) * d;
  float y = lattice.y + sin( a ) * d;
  return Vec2(x,y);
}









/**
PRIMITIVE 2D
*/
/**
DISC
*/
void disc(PVector pos, int diam, int c ) {
  for ( int i = 1 ; i < diam +1 ; i++) {
    circle(c, pos, i) ;
  }
}

void chromatic_disc( PVector pos, int diam ) {
  for ( int i = 1 ; i < diam +1 ; i++) {
    chromatic_circle(pos, i) ;
  }
}

/**
CIRCLE
*/
void chromatic_circle(PVector pos, int d) {
  int surface = d*d ; // surface is equale of square surface where is the cirlcke...make sens ?

  int radius = ceil(radius_from_circle_surface(surface)) ;
  int numPoints = ceil(perimeter_disc( radius)) ;
  for(int i=0; i < numPoints; i++) {
      //circle
      float stepAngle = map(i, 0, numPoints, 0, 2*PI) ; 
      float angle =  2*PI - stepAngle;
      //color
      color c = color (i, 100,100) ;
      //display
      set(int(projection(angle, radius).x + pos.x) , int(projection(angle, radius).y + pos.y), c);
  }
}


//full cirlce
void circle(color c, PVector pos, int d) {
  int surface = d*d ; // surface is equale of square surface where is the cirlcke...make sens ?

  int radius = ceil(radius_from_circle_surface(surface)) ;
  int numPoints = ceil(perimeter_disc(radius)) ;
  for(int i=0; i < numPoints; i++) {
      float stepAngle = map(i, 0, numPoints, 0, 2*PI) ; 
      float angle =  2*PI - stepAngle;
      set(int(projection(angle, radius).x + pos.x) , int(projection(angle, radius).y + pos.y), c);
  }
}

//circle with a specific quantity points
void circle(color c, PVector pos, int d, int num) {
  int surface = d*d ; // surface is equale of square surface where is the cirlcke...make sens ?

  int radius = ceil(radius_from_circle_surface(surface)) ;
  for(int i=0; i < num; i++) {
      float stepAngle = map(i, 0, num, 0, 2*PI) ; 
      float angle =  2*PI - stepAngle;
      set(int(projection(angle, radius).x + pos.x) , int(projection(angle, radius).y + pos.y), c);
  }
}
//circle with a specific quantity points and specific shape for each point
void circle(PVector pos, int d, int num, PVector size, String shape) {
  int surface = d*d ; // surface is equale of square surface where is the cirlcke...make sens ?
  int whichShape = 0 ;
  if (shape.equals("point") )  whichShape = 0;
  else if (shape.equals("ellipse") )  whichShape = 1 ;
  else if (shape.equals("rect") )  whichShape = 2 ;
  else if (shape.equals("box") )  whichShape = 3 ;
  else if (shape.equals("sphere") )  whichShape = 4 ;
  else whichShape = 0 ;

  int radius = ceil(radius_from_circle_surface(surface)) ;
  for(int i=0; i < num; i++) {
    float stepAngle = map(i, 0, num, 0, 2*PI) ; 
    float angle =  2*PI - stepAngle;
    PVector newPos = new PVector(projection(angle, radius).x + pos.x, projection(angle, radius).y + pos.y) ;
    if(whichShape == 0 ) point(newPos.x, newPos.y) ;
    if(whichShape == 1 ) ellipse(newPos.x, newPos.y, size.x, size.y) ;
    if(whichShape == 2 ) rect(newPos.x, newPos.y, size.x, size.y) ;
    if(whichShape == 3 ) {
      pushMatrix() ;
      translate(newPos.x, newPos.y,0) ;
      box(size.x, size.y, size.z) ;
      popMatrix() ;
    }
    if(whichShape == 4 ) {
      pushMatrix() ;
      translate(newPos.x, newPos.y,0) ;
      int detail = (int)size.x /4 ;
      if (detail > 10 ) detail = 10 ;
      sphereDetail(detail) ;
      sphere(size.x) ;
      popMatrix() ;
    }
  }
}
// summits around the circle
PVector [] circle (PVector pos, int d, int num) {
  PVector [] p = new PVector [num] ;
  int surface = d*d ; 
  int radius = ceil(radius_from_circle_surface(surface)) ;
  
  // choice your starting point
  float startingAnglePos = PI*.5;
  if(num == 4) startingAnglePos = PI*.25;
  
  for( int i=0 ; i < num ; i++) {
    float stepAngle = map(i, 0, num, 0, TAU) ; 
    float angle =  TAU - stepAngle -startingAnglePos;
    p[i] = new PVector(projection(angle, radius).x +pos.x,projection(angle, radius).y + pos.y) ;
  }
  return p ;
}

PVector [] circle (PVector pos, int d, int num, float jitter) {
  PVector [] p = new PVector [num] ;
  int surface = d*d ; 
  int radius = ceil(radius_from_circle_surface(surface)) ;
  
  // choice your starting point
  float startingAnglePos = PI*.5;
  if(num == 4) startingAnglePos = PI*.25;
  
  float angleCorrection ; // this correction is cosmetic, when we'he a pair beam this one is stable for your eyes :)
  for( int i=0 ; i < num ; i++) {
    int beam = num /2 ;
    if ( beam%2 == 0 ) angleCorrection = PI / num ; else angleCorrection = 0.0 ;
    if ( num%2 == 0 ) jitter *= -1 ; else jitter *= 1 ; // the beam have two points at the top and each one must go to the opposate...
    
    float stepAngle = map(i, 0, num, 0, TAU) ;
    float jitterAngle = map(jitter, -1, 1, -PI/num, PI/num) ;
    float angle =  TAU -stepAngle +jitterAngle +angleCorrection -startingAnglePos;
    
    p[i] = new PVector(projection(angle, radius).x +pos.x, projection(angle, radius).y +pos.y) ;
  }
  return p ;
}
/**
END DISC and CIRCLE
*/











/**
PRIMITIVE shape
v 1.0.1
with "n" summits
*/
void primitive(float radius, int summits) {
  Vec3 pos = Vec3();
  float angle = 0;
  Vec2 dir_P3D = Vec2();
  primitive(pos,radius,summits,angle,dir_P3D);
}

// Primitive with Vec method
void primitive(Vec pos, float radius, int summits) {
  float angle = 0;
  Vec2 dir_P3D = Vec2();
  primitive(pos,radius,summits,angle,dir_P3D);
}

void primitive(Vec pos, float radius, int summits, Vec2 dir_P3D) {
  float angle = 0;
  primitive(pos,radius,summits,angle,dir_P3D);
}

void primitive(Vec pos, float radius, int summits, float angle) {
  Vec2 dir_P3D = Vec2();
  primitive(pos,radius,summits,angle,dir_P3D);
}

// Primitive with Vec method and angle to display
void primitive(Vec pos_raw, float radius, int summits, float angle, Vec2 dir_P3D) {
  Vec3 pos = null ;
  if(pos_raw instanceof Vec2) {
    pos = Vec3(pos_raw.x, pos_raw.y, 0);
  } else if(pos_raw instanceof Vec3) {
    pos = Vec3(pos_raw.x, pos_raw.y, pos_raw.z);
  }

  if(summits < 2) {
    summits = 2;
  }

  Vec3 [] points = new Vec3[summits];
  // create coord of the shape
  if(summits == 2 && angle == 0) {
    points[0] = Vec3(-.5,0,0);
    points[1] = Vec3(.5,0,0);
  } else {
    for (int i = 0 ; i < summits ; i++) {
      points[i] = polygon_2D(summits, angle)[i].copy();
    }
  }

  draw_primitive(pos,dir_P3D,radius,points);
  

  /**
  * IN FUTURE MUST BE COMPUTE with POLYGON 3D may be in 2028 ??????

  if (dir_P3D != null && renderer_P3D()) {
    // polygon_3D()
    // method must be used in the future when this one is not shitty instead polugon2D() with matrix();
    // classic version with polygon_2D method
    for (int i = 0 ; i < summits ; i++) {
      printTempo(60,"param",i,summits,angle);
      points[i] = polygon_2D(summits, angle)[i].copy();
      printTempo(60,"point",points[i]);
    }
  } else {
    for (int i = 0 ; i < summits ; i++) {
      points[i] = polygon_2D(summits, angle)[i].copy();
    }
  }

  // draw the shape
  // this rotate part must be integrate with a cartesian method in the circle method
  draw_primitive(pos,dir_P3D,radius,points);

  
  With advance shitty version of Polygon_3D
  if(dir == null ) {
    draw_primitive(pos, radius, points); 
  } else if (dir != null && renderer_P3D()) {
    draw_primitive( points);
  }
  */
}









// local method
void draw_primitive(Vec3 [] pts) {
  Vec3 pos = Vec3() ;
  // Vec2 dir_polar = Vec2() ;
  int radius = 1 ;
  draw_primitive (pos, radius, pts) ;
}

void draw_primitive(float radius, Vec3 [] pts) {
  Vec3 pos = Vec3() ;
  // Vec2 dir_polar = Vec2() ;
  draw_primitive (pos,radius,pts) ;
}

void draw_primitive(Vec3 pos, Vec2 dir, float radius, Vec3 [] pts) {
  // special one because we have direction for the polygon, 
  // so we must use the matrix system until have a good algorithm for the cartesian direction
  /*
  if(renderer_P3D()) {
    start_matrix_3D(pos, dir); 
  } else {
    start_matrix_2D(Vec2(pos.x, pos.y),0);
  }
  */
  draw_primitive(Vec3(),radius,pts);
  // stop_matrix();
}








/**
* main draw primitive
* the line rendering is awful, very very low when there is a lot of shape,
* may be the compute on polygon_2D() is guilty
*/
void draw_primitive(Vec3 pos, float radius, Vec3 [] pts) {
  boolean check_line = false;
  if(pts.length == 2) {
    check_line = true;
  }

  if(check_line) {
    if(renderer_P3D()) {
      line(pts[0],pts[1].mult(radius).add(pos));
    } else {
      Vec2 point_b = Vec2(pts[1].x,pts[1].y);
      point_b.mult(radius).add(Vec2(pos.x,pos.y));
      line(pts[0].x,pts[0].y,point_b.x,point_b.y);
    }
  } else if(!check_line) {
    beginShape();
    for (int i = 0 ; i < pts.length ; i++) {
      if (pts[i] != null ) {
        pts[i].mult(radius);
        pts[i].add(pos);
        // test the rendering and if the shape if a line or not, to choice between vertex and line display
        if(renderer_P3D()) {
          vertex(pts[i]);
        } else {
          vertex(pts[i].x,pts[i].y);
        }
      }
    }
    endShape(CLOSE) ;
  }
}





























/**
POLYGON
*/
/**
POLYGON 2D
v 0.1.0
*/
Vec3 [] polygon_2D (int num) {
  float new_orientation = 0 ;
  return polygon_2D (num, new_orientation) ;
}


// main method
Vec3 [] polygon_2D (int num, float new_orientation) {
  Vec3 [] p = new Vec3[num];
  // choice your starting point
  float start_angle = PI*.5 +new_orientation;
  if(num == 4) {
    start_angle = PI*.25 +new_orientation;
  }
  // calcul the position of each summit, step by step
  for(int i = 0 ; i < num ; i++) {
    p[i] = compute_coord_polygon_2D(i,num,start_angle).copy();
  }
  return p;
}

Vec3 compute_coord_polygon_2D(int target, int num, float start_angle) {
  float step_angle = map(target,0,num,0,TAU); 
  float orientation = TAU -step_angle -start_angle;
  Vec2 temp_orientation_xy = to_cartesian_2D(orientation);
  float x = temp_orientation_xy.x;
  float y = temp_orientation_xy.y;
  float z = 0 ;
  return Vec3(x,y,z);
}


/**
POLYGON 3D
but must be refactoring because the metod is a little shitty !!!!!
*/
// polygon with 3D direction in cartesian world
Vec3 [] polygon_3D(int num, float new_orientation, Vec3 dir) {
  Vec3 pos = Vec3();
  int radius = 1 ;
  return polygon_3D (pos, radius, num, new_orientation, dir) ;
}


/**
Inspirated by : Creating a polygon perpendicular to a line segment Written by Paul Bourke February 1997
@see http://paulbourke.net/geometry/circlesphere/
*/
Vec3 [] polygon_3D(Vec3 pos, float radius, int num, float new_orientation, Vec3 dir) {

  Vec3 p1 = dir.copy();
  Vec3 p2 = to_cartesian_3D(PI,PI);
  Vec3 support = to_cartesian_3D(PI,PI);
  /*
  Vec3 p2 = Vec3(0,0,1) ;
  Vec3 support = Vec3 (1,0,0) ;
  */
  // prepare the vector direction
  Vec3 r = Vec3();
  Vec3 s = Vec3();
  Vec3 p2_sub_p1 = sub(p1,p2);

  r = cross(p2_sub_p1,support,r);
  s = cross(p2_sub_p1,r,s);
  r.dir();
  s.dir();

  // prepare polygone in 3D world
  Vec3 plane = Vec3();
  int num_temp = num +1 ;
  Vec3 [] p ;
  p = new Vec3 [num_temp] ;

  // init Vec3 p
  for(int i = 0 ; i < num_temp ; i++) p[i] = Vec3() ;
  
  // create normal direction for the point
  float theta, delta;
  delta = TAU / num;
  int step = 0 ;
  for (theta = 0 ; theta < TAU ; theta += delta) {
    plane.x = p1.x + r.x * cos(theta +delta) + s.x * sin(theta +delta);
    plane.y = p1.y + r.y * cos(theta +delta) + s.y * sin(theta +delta);
    plane.z = p1.z + r.z * cos(theta +delta) + s.z * sin(theta +delta);
    /**
    plane is not a normal value, it's big problem :(((((((
    */
    plane.mult(radius);
    plane.add(pos);
    // write summits
    p[step] = plane.copy();

    step++ ;
  }
  return p ;
}
/**
END POLYGON
*/



















/**
TRIANGLE
*/
void triangle(float x_a, float y_a, float z_a, float x_b, float y_b, float z_b, float x_c, float y_c, float z_c) {
  Vec3 a = Vec3(x_a, y_a, z_a) ;
  Vec3 b = Vec3(x_b, y_b, z_b) ;
  Vec3 c = Vec3(x_c, y_c, z_c) ;
  triangle(a, b, c) ;
}
void triangle(float x_a, float y_a, float x_b, float y_b, float x_c, float y_c) {
  Vec3 a = Vec3(x_a, y_a, 0) ;
  Vec3 b = Vec3(x_b, y_b, 0) ;
  Vec3 c = Vec3(x_c, y_c, 0) ;
  triangle(a, b, c) ;
}

void triangle(Vec2 aa, Vec2 bb, Vec2 cc) {
  Vec3 a = Vec3(aa.x, aa.y, 0) ;
  Vec3 b = Vec3(bb.x, bb.y, 0) ;
  Vec3 c = Vec3(cc.x, cc.y, 0) ;
  triangle(a,b,c) ;
}

void triangle(Vec3 a, Vec3 b, Vec3 c) {
  beginShape();
  vertex(a);
  vertex(b);
  vertex(c);
  endShape(CLOSE);
}





















/**
PRIMITIVE 3D
*/

/**
POLYDRON
v 0.2.0
*/
  //create Polyhedron
  /*
  "TETRAHEDRON","CUBE", "OCTOHEDRON", "DODECAHEDRON","ICOSAHEDRON","CUBOCTAHEDRON","ICOSI DODECAHEDRON",
  "TRUNCATED CUBE","TRUNCATED OCTAHEDRON","TRUNCATED DODECAHEDRON","TRUNCATED ICOSAHEDRON","TRUNCATED CUBOCTAHEDRON","RHOMBIC CUBOCTAHEDRON",
  "RHOMBIC DODECAHEDRON","RHOMBIC TRIACONTAHEDRON","RHOMBIC COSI DODECAHEDRON SMALL","RHOMBIC COSI DODECAHEDRON GREAT"
  All Polyhedrons can use "POINT" and "LINE" display mode.
  except the "TETRAHEDRON" who can also use "VERTEX" display mode.
  */
  
// MAIN VOID to create polyhedron
void polyhedron(String type, String style, int size) {
  //This is where the actual defining of the polyhedrons takes place

  if(vec_polyhedron_list != null) {
    //clear out whatever verts are currently defined
    vec_polyhedron_list.clear();
  } else {
    vec_polyhedron_list = new ArrayList();
  }
  
  if(type.equals("TETRAHEDRON")) tetrahedron_poly(size) ;
  if(type.equals("CUBE")) cube(size) ;
  if(type.equals("OCTOHEDRON")) octohedron(size) ;
  if(type.equals("DODECAHEDRON"))dodecahedron(size) ;
  if(type.equals("ICOSAHEDRON"))icosahedron(size) ;
  if(type.equals("CUBOCTAHEDRON"))cuboctahedron(size) ;
  if(type.equals("ICOSI DODECAHEDRON"))icosi_dodecahedron(size) ;

  if(type.equals("TRUNCATED CUBE"))truncated_cube(size) ;
  if(type.equals("TRUNCATED OCTAHEDRON"))truncated_octahedron(size) ;
  if(type.equals("TRUNCATED DODECAHEDRON"))truncated_dodecahedron(size) ;
  if(type.equals("TRUNCATED ICOSAHEDRON"))truncated_icosahedron(size) ;
  if(type.equals("TRUNCATED CUBOCTAHEDRON"))truncated_cuboctahedron(size) ;
  
  if(type.equals("RHOMBIC CUBOCTAHEDRON"))rhombic_cuboctahedron(size) ;
  if(type.equals("RHOMBIC DODECAHEDRON"))rhombic_dodecahedron(size) ;
  if(type.equals("RHOMBIC TRIACONTAHEDRON"))rhombic_triacontahedron(size) ;
  if(type.equals("RHOMBIC COSI DODECAHEDRON SMALL"))rhombic_cosi_dodecahedron_small(size) ;
  if(type.equals("RHOMBIC COSI DODECAHEDRON GREAT"))rhombic_cosi_dodecahedron_great(size) ;
  
  // which method to draw
  if(style.equals("LINE")) polyhedron_draw_line(type) ;
  if(style.equals("POINT")) polyhedron_draw_point(type) ;
  if(style.equals("VERTEX")) polyhedron_draw_vertex(type) ;

}




// POLYHEDRON DETAIL 
//set up initial polyhedron
float factor_size_polyhedron ;
//some variables to hold the current polyhedron...
ArrayList<Vec3>vec_polyhedron_list;
float edge_polyhedron_length;
String strName, strNotes;

// FEW POLYHEDRON
// BASIC
void tetrahedron_poly(int size) {
  if(vec_polyhedron_list == null) vec_polyhedron_list = new ArrayList();
  vec_polyhedron_list.add(Vec3(1,1,1));
  vec_polyhedron_list.add(Vec3(-1,-1,1));
  vec_polyhedron_list.add(Vec3(-1,1,-1));
  vec_polyhedron_list.add(Vec3(1,-1,-1));
  edge_polyhedron_length = 0 ;
  factor_size_polyhedron = size /2;
}

void cube(int size) {
  addVerts(1, 1, 1);
  edge_polyhedron_length = 2;
  factor_size_polyhedron = size /2;
}

void octohedron(int size) {
  addPermutations(1, 0, 0);
  edge_polyhedron_length = r.ROOT2;
  factor_size_polyhedron = size *.8;
}

void dodecahedron(int size) {
  addVerts(1, 1, 1);
  addPermutations(0, 1/r.PHI, r.PHI);
  edge_polyhedron_length = 2/r.PHI;
  factor_size_polyhedron = size /2.5;
}


// SPECIAL
void icosahedron(int size) {
  addPermutations(0,1,r.PHI);
  edge_polyhedron_length = 2.0;
  factor_size_polyhedron = size /2.7;
}

void icosi_dodecahedron(int size) {
  addPermutations(0,0,2*r.PHI);
  addPermutations(1,r.PHI,sq(r.PHI));
  edge_polyhedron_length = 2;
  factor_size_polyhedron = size/5;
}

void cuboctahedron(int size) {
  addPermutations(1,0,1);
  edge_polyhedron_length = r.ROOT2;
  factor_size_polyhedron = size /1.9;
}


// TRUNCATED
void truncated_cube(int size) {
  addPermutations(r.ROOT2-1,1,1);
  edge_polyhedron_length = 2*(r.ROOT2-1);     
  factor_size_polyhedron = size /2.1;
}

void truncated_octahedron(int size) {
  addPermutations(0,1,2);
  addPermutations(2,1,0);
  edge_polyhedron_length = r.ROOT2;
  factor_size_polyhedron = size/3.4;
}

void truncated_cuboctahedron(int size) {
  addPermutations(r.ROOT2+1,2*r.ROOT2 + 1, 1);
  addPermutations(r.ROOT2+1,1,2*r.ROOT2 + 1);
  edge_polyhedron_length = 2;
  factor_size_polyhedron = size/6.9;
}

void truncated_dodecahedron(int size) {
  addPermutations(0,1/r.PHI,r.PHI+2);
  addPermutations(1/r.PHI,r.PHI,2*r.PHI);
  addPermutations(r.PHI,2,sq(r.PHI));
  edge_polyhedron_length = 2*(r.PHI - 1);
  factor_size_polyhedron = size/6;
}

void truncated_icosahedron(int size) {
  addPermutations(0,1,3*r.PHI);
  addPermutations(2,2*r.PHI+1,r.PHI);
  addPermutations(1,r.PHI+2,2*r.PHI);
  edge_polyhedron_length = 2;
  factor_size_polyhedron = size/8;
}

// RHOMBIC
void rhombic_dodecahedron(int size) {
  addVerts(1,1,1);
  addPermutations(0,0,2);
  edge_polyhedron_length = sqrt(3);
  factor_size_polyhedron = size /2.8;
}

void rhombic_triacontahedron(int size) {
  addVerts(sq(r.PHI), sq(r.PHI), sq(r.PHI));
  addPermutations(sq(r.PHI), 0, pow(r.PHI, 3));
  addPermutations(0,r.PHI, pow(r.PHI,3));
  edge_polyhedron_length = r.PHI*sqrt(r.PHI+2);
  factor_size_polyhedron = size /7.2;
}

void rhombic_cuboctahedron(int size) {
  addPermutations(r.ROOT2 + 1, 1, 1);
  edge_polyhedron_length = 2;
  factor_size_polyhedron = size/4.2;
}

void rhombic_cosi_dodecahedron_small(int size) {
  addPermutations(1, 1, pow(r.PHI,3));
  addPermutations(sq(r.PHI),r.PHI,2*r.PHI);
  addPermutations(r.PHI+2,0,sq(r.PHI));
  edge_polyhedron_length = 2;
  factor_size_polyhedron = size/7.4;
}

void rhombic_cosi_dodecahedron_great(int size) {
  addPermutations(1/r.PHI,1/r.PHI,r.PHI+3);
  addPermutations(2/r.PHI,r.PHI,2*r.PHI+1);
  addPermutations(1/r.PHI, sq(r.PHI),3*r.PHI-1);
  addPermutations(2*r.PHI-1,2,r.PHI+2);
  addPermutations(r.PHI,3,2*r.PHI);
  edge_polyhedron_length = 2*r.PHI-2;
  factor_size_polyhedron = size/7.8;
}



//Built Tetrahedron
// EASY METHOD, for direct and single drawing
// classic and easy method
void polyhedron_draw_point(String name) {
  for (int i = 0 ; i < vec_polyhedron_list.size() ; i++) {
    Vec3 point = vec_polyhedron_list.get(i);
    if(name.equals("TETRAHEDRON")) {
      pushMatrix() ;
      rotateX(TAU -1) ;
      rotateY(PI/4) ;
    }
    point(point.x *factor_size_polyhedron, point.y *factor_size_polyhedron, point.z *factor_size_polyhedron);
    if(name.equals("TETRAHEDRON")) popMatrix() ;
  }
}

void polyhedron_draw_line(String name) {
  for (int i=0; i <vec_polyhedron_list.size(); i++) {
    for (int j=i +1; j < vec_polyhedron_list.size(); j++) {
      if (isEdge(i, j, vec_polyhedron_list) || edge_polyhedron_length == 0 ) {
        Vec3 v1 = vec_polyhedron_list.get(i).copy();
        Vec3 v2 = vec_polyhedron_list.get(j).copy();
        if(name.equals("TETRAHEDRON")) {
          pushMatrix() ;
          rotateX(TAU -1) ;
          rotateY(PI/4) ;
        }
        line(v1.x *factor_size_polyhedron, v1.y *factor_size_polyhedron, v1.z *factor_size_polyhedron, v2.x *factor_size_polyhedron, v2.y *factor_size_polyhedron, v2.z *factor_size_polyhedron);
        if(name.equals("TETRAHEDRON")) popMatrix() ;
      }
    }
  }
}

void polyhedron_draw_vertex(String name) {
  // TETRAHEDRON
  if(name.equals("TETRAHEDRON")) {
    pushMatrix() ;
    rotateX(TAU -1) ;
    rotateY(PI/4) ;
    int n = 4 ; // quantity of face of Tetrahedron
    for(int i = 0 ; i < n ; i++) {
      // println("je suis là face",i);
      // choice of each point
      int a = i ;
      int b = i+1 ;
      int c = i+2 ;
      if(i == n-2 ) c = 0 ;
      if(i == n-1 ) {
        b = 0 ;
        c = 1 ;
      }
      Vec3 v1 = vec_polyhedron_list.get(a).copy();
      Vec3 v2 = vec_polyhedron_list.get(b).copy();
      Vec3 v3 = vec_polyhedron_list.get(c).copy();
      // scale the position of the points
      v1.mult(factor_size_polyhedron);
      v2.mult(factor_size_polyhedron);
      v3.mult(factor_size_polyhedron);
      
      // drawing
      beginShape() ;
      vertex(v1) ;
      vertex(v2) ;
      vertex(v3) ;
      endShape(CLOSE) ;
    }
    popMatrix() ;
  // OTHER POLYHEDRON
  } else {
    beginShape() ;
    for (int i= 0; i <vec_polyhedron_list.size(); i++) {
      for (int j= i +1; j <vec_polyhedron_list.size(); j++) {
        if (isEdge(i, j, vec_polyhedron_list) || edge_polyhedron_length == 0 ) {
          // vLine((PVector)vec_polyhedron_list.get(i), (PVector)vec_polyhedron_list.get(j));
          Vec3 v1 = vec_polyhedron_list.get(i).copy();
          Vec3 v2 = vec_polyhedron_list.get(j).copy();
          v1.mult(factor_size_polyhedron);
          v2.mult(factor_size_polyhedron);;
          vertex(v1);
          vertex(v2);
        }
      }
    }
    endShape(CLOSE) ;
  }
}
// END of EASY METHOD and DIRECT METHOD

 



/**
annexe draw polyhedron
*/
boolean isEdge(int vID1, int vID2, ArrayList<Vec3>listPoint) {
  //had some rounding errors that were messing things up, so I had to make it a bit more forgiving...
  int pres = 1000;
  Vec3 v1 = listPoint.get(vID1).copy();
  Vec3 v2 = listPoint.get(vID2).copy();
  float d = sqrt(sq(v1.x - v2.x) + sq(v1.y - v2.y) + sq(v1.z - v2.z)) + .00001;
  return (int(d *pres)==int(edge_polyhedron_length *pres));
}






// ADD POINTS for built POLYHEDRON
/////////////////////////////////
void addPermutations(float x, float y, float z) {
  //adds vertices for all three permutations of x, y, and z
  addVerts(x, y, z);
  addVerts(z, x, y);
  addVerts(y, z, x);
}


 
void addVerts(float x, float y, float z) {
  //adds the requested vert and all "mirrored" verts
  vec_polyhedron_list.add (Vec3(x,y,z));
  // z
  if (z != 0.0) vec_polyhedron_list.add (Vec3(x,y,-z)); 
  // y
  if (y != 0.0) {
    vec_polyhedron_list.add (Vec3(x, -y, z));
    if (z != 0.0) vec_polyhedron_list.add(Vec3(x,-y,-z));
  } 
  // x
  if (x != 0.0) {
    vec_polyhedron_list.add (Vec3(-x, y, z));
    if (z != 0.0) vec_polyhedron_list.add(Vec3(-x,y,-z));
    if (y != 0.0) {
      vec_polyhedron_list.add(Vec3(-x, -y, z));
      if (z != 0.0) vec_polyhedron_list.add(Vec3(-x,-y,-z));
    }
  }
}