/**
* ROPE SCIENCE
* v 0.7.10
* Copyleft (c) 2014-2021
* @author @stanlepunk
* @see https://github.com/StanLepunK/Rope_framework
* Processing 4.0.a2
*/




/**
* check if int number is prime number
*/
boolean is_prime(int n) {
  if(n == 2) {
    return true;
  } else if (n%2==0) {
    return false;
  } else {
    for(int i=3; i*i<=n ; i+=2) {
      if(n%i==0) {
        return false;
      }
    }
    return true;
  } 
}




/**
Gaussian randomize
v 0.0.2
*/
@Deprecated
float random_gaussian(float value) {
  return random_gaussian(value, .4) ;
}

@Deprecated
float random_gaussian(float value, float range) {
  /*
  * It's cannot possible to indicate a value result here, this part need from the coder ?
  */
  printErrTempo(240,"float random_gaussian(); method must be improved or totaly deprecated");
  range = abs(range) ;
  float distrib = random(-1, 1) ;
  float result = 0 ;
  if(value == 0) {
    value = 1 ;
    result = (pow(distrib,5)) *(value *range) +value ;
    result-- ;
  } else {
    result = (pow(distrib,5)) *(value *range) +value ;
  }
  return result;
}



/**
Next Gaussian randomize
v 0.0.2
*/
/**
* return value from -1 to 1
* @return float
*/
Random random = new Random();
float random_next_gaussian() {
  return random_next_gaussian(1,1);
}

float random_next_gaussian(int n) {
  return random_next_gaussian(1,n);
}

float random_next_gaussian(float range) {
  return random_next_gaussian(range,1);
}

float random_next_gaussian(float range, int n) {
  float roots = (float)random.nextGaussian();
  float arg = map(roots,-2.5,2.5,-1,1);  
  if(n > 1) {
    if(n%2 ==0 && arg < 0) {
       arg = -1 *pow(arg,n);
     } else {
       arg = pow(arg,n);
     }
     return arg *range ;
  } else {
    return arg *range ;
  }
}


















/**
Physic Rope
v 0.0.2
*/
public double g_force(double dist, double m_1, double m_2) {
  return R_Constants.G *(dist*dist)/(m_1 *m_2);
}























/**
* Math rope 
* v 1.9.0
* @author Stan le Punk
* @see https://github.com/StanLepunK/Math_rope
*/

//roots dimensions n
float roots(float valueToRoots, int n) {
  return pow(valueToRoots, 1.0/n) ;
}

// Decimal
// @return a specific quantity of decimal after comma
float decimale(float arg, int n) {
  float div = pow(10, abs(n)) ;
  return Math.round(arg *div) / div;
}


/**
* geometry util
* v. 0.0.7
*/
float perimeter_disc(int r) {
  return 2 *r *PI ;
}

float radius_from_circle_surface(int surface) {
  return sqrt(surface/PI) ;
}


boolean inside(ivec pos, ivec size, ivec2 target_pos) {
  return inside(vec2(pos.x,pos.y), vec2(size.x,size.y), vec2(target_pos), ELLIPSE);
}

boolean inside(ivec pos, ivec size, ivec2 target_pos, int type) {
  return inside(vec2(pos.x,pos.y), vec2(size.x,size.y), vec2(target_pos), type);
}

boolean inside(vec pos, vec size, vec2 target_pos) {
  return inside(pos, size, target_pos, ELLIPSE);
}

boolean inside(vec pos, vec size, vec2 target_pos, int type) {
  if(type == ELLIPSE) {
    // this part can be improve to check the 'x' and the 'y'
    if (dist(vec2(pos.x,pos.y), target_pos) < size.x *.5) return true ; 
    else return false ;
  } else {
    if(target_pos.x > pos.x && target_pos.x < pos.x +size.x && 
       target_pos.y > pos.y && target_pos.y < pos.y +size.y) return true ; 
      else return false ;
  } 
}





/**
* https://forum.processing.org/two/discussion/90/point-and-line-intersection-detection
* refactoring from Quark Algorithm
*/
boolean is_on_line(vec2 start, vec2 end, vec2 point, float range) {
  vec2 vp = vec2();
  vec2 line = sub(end,start);
  float l2 = line.magSq();
  if (l2 == 0.0) {
    vp.set(start);
    return false;
  }
  vec2 pv0_line = sub(point, start);
  float t = pv0_line.dot(line)/l2;
  pv0_line.normalize();
  vp.set(line);
  vp.mult(t);
  vp.add(start);
  float d = dist(point, vp);
  if (t >= 0 && t <= 1 && d <= range) {
    return true;
  } else {
    return false;
  }
}

/**
* https://forum.processing.org/one/topic/how-do-i-find-if-a-point-is-inside-a-complex-polygon.html
* http://paulbourke.net/geometry/
* thks to Moggach and Paul Brook
*/
boolean in_polygon(vec [] points, vec2 pos) {
  int i, j;
  boolean is = false;
  int sides = points.length;
  for(i = 0, j = sides - 1 ; i < sides ; j = i++) {
    if (( ((points[i].y() <= pos.y()) && (pos.y() < points[j].y())) || ((points[j].y() <= pos.y()) && (pos.y() < points[i].y()))) &&
          (pos.x() < (points[j].x() - points[i].x()) * (pos.y() - points[i].y()) / (points[j].y() - points[i].y()) + points[i].x())) {
      is = !is;
    }
  }
  return is;
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
* angle
* v 0.0.2
* @return float
*/
float angle_radians(float y, float range) {
  return map(y, 0,range, 0, TAU) ;
}

float angle_degrees(float y, float range) {
  return map(y, 0,range, 0, 360) ;
}

float angle(vec2 a, vec2 b) {
  return atan2(b.y -a.y, b.x -a.x);
}

float angle(vec2 v) {
  return atan2(v.y, v.x);
}



  

/* 
return a vector info : radius,longitude, latitude
@return vec3
*/
vec3 to_polar(vec3 cart) {
  float radius = sqrt(cart.x * cart.x + cart.y * cart.y + cart.z * cart.z);
  float phi = acos(cart.x / sqrt(cart.x * cart.x + cart.y * cart.y)) * (cart.y < 0 ? -1 : 1);
  float theta = acos(cart.z / radius) * (cart.z < 0 ? -1 : 1);
  // check NaN result
  if (Float.isNaN(phi)) phi = 0 ;
  if (Float.isNaN(theta)) theta = 0 ;
  if (Float.isNaN(radius)) radius = 0 ;
  // result
  //return new vec3(radius, longitude, latitude) ;
  return new vec3(phi, theta, radius) ;
}







// Cartesian 3D
/**
// @ return vec3
// return the position of point on Sphere, with longitude and latitude
*/
//If you want just the final pos
vec3 to_cartesian_3D(vec2 pos, vec2 range, float sizeField)  {
  // vertical plan position
  float verticalY = to_cartesian_2D(pos.y, vec2(0,range.y), vec2(0,TAU), sizeField).x ;
  float verticalZ = to_cartesian_2D(pos.y, vec2(0,range.y), vec2(0,TAU), sizeField).y ; 
  vec3 posVertical = new vec3(0, verticalY, verticalZ) ;
  // horizontal plan position
  float horizontalX = to_cartesian_2D(pos.x, vec2(0,range.x), vec2(0,TAU), sizeField).x ; 
  float horizontalZ = to_cartesian_2D(pos.x, vec2(0,range.x), vec2(0,TAU), sizeField).y  ;
  vec3 posHorizontal = new vec3(horizontalX, 0, horizontalZ) ;
  
  return projection(middle(posVertical, posHorizontal), sizeField) ;
}

vec3 to_cartesian_3D(float latitude, float longitude) {
  float radius_normal = 1 ;
  return to_cartesian_3D(latitude, longitude, radius_normal);
}

// main method
vec3 to_cartesian_3D(float latitude, float longitude,  float radius) {
  // https://en.wikipedia.org/wiki/List_of_common_coordinate_transformations
  // https://en.wikipedia.org/wiki/Spherical_coordinate_system
  // https://fr.wikipedia.org/wiki/Coordonn%C3%A9es_sph%C3%A9riques
  

  /*
  //  Must be improve is not really good in the border versus direct polar rotation with the matrix
  */ 
  float theta = longitude%TAU ;
  float phi = latitude%PI ;

  float x = radius *sin(theta) *cos(phi);
  float y = radius *sin(theta) *sin(phi);
  float z = radius *cos(theta);
  return new vec3(x, y, z);
}
/*
vec3 to_cartesian_3D(float longitude, float latitude, float radius) {
  // https://en.wikipedia.org/wiki/List_of_common_coordinate_transformations
  float x = radius *sin(latitude) *cos(longitude);
  float y = radius *sin(latitude) *sin(longitude);
  float z = radius *cos(latitude);
  return new vec3(x, y, z);
}
*/







// To cartesian 2D
vec2 to_cartesian_2D(float pos, vec2 range, vec2 target_rad, float distance) {
  float rotation_plan = map(pos, range.x, range.y, target_rad.x, target_rad.y)  ;
  return to_cartesian_2D(rotation_plan, distance);
}

vec2 to_cartesian_2D(float angle, float radius) {
  return to_cartesian_2D(angle).mult(radius);
}

// main method
vec2 to_cartesian_2D(float angle) {
  float x = cos(angle);
  float y = sin(angle);
  return vec2(x,y);
}







/**
// Projection
*/
// Cartesian projection 2D
vec2 projection(vec2 direction) {
  return projection(direction, vec2(), 1.) ;
}

vec2 projection(vec2 direction, float radius) {
  return projection(direction, vec2(), radius) ;
}
vec2 projection(vec2 direction, vec2 origin, float radius) {
  vec2 p = direction.copy().dir(origin) ;
  p.mult(radius) ;
  p.add(origin) ;
  return p ;
}
// polar projection 2D
vec2 projection(float angle) {
  return projection(angle, 1) ;
}
vec2 projection(float angle, float radius) {
  return vec2(cos(angle) *radius, sin(angle) *radius) ;
}
// cartesian projection 3D
vec3 projection(vec3 direction) {
  return projection(direction, vec3(), 1.) ;
}

vec3 projection(vec3 direction, float radius) {
  return projection(direction, vec3(), radius) ;
}

vec3 projection(vec3 direction, vec3 origin, float radius) {
  vec3 ref = direction.copy() ;
  vec3 p = ref.dir(origin) ;
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
vec2 target_direction(vec2 target, vec2 my_position) {
  printErrTempo(240, "vec2 target_direction() deprecated instead use look_at(vec target, vec origin) method, becareful the result is mult by -1");
  return projection(target, my_position, 1).sub(my_position);
}

@Deprecated
vec3 target_direction(vec3 target, vec3 my_position) {
   printErrTempo(240, "vec2 target_direction() deprecated instead use look_at(vec target, vec origin) method, becareful the result is mult by -1");
  return projection(target, my_position, 1).sub(my_position) ;
}


vec2 look_at(vec2 target, vec2 origin) {
  return projection(target, origin, 1).sub(origin).mult(-1,1);
}

vec3 look_at(vec3 target, vec3 origin) {
  return projection(target, origin, 1).sub(origin);
}





/**
SPHERE PROJECTION
*/
/**
FIBONACCI SPHERE PROJECTION CARTESIAN
*/
vec3 [] list_cartesian_fibonacci_sphere(int num, float step, float root) {
  float root_sphere = root *num ;
  vec3 [] list_points = new vec3[num] ;
  for (int i = 0; i < list_points.length ; i++) list_points[i] = distribution_cartesian_fibonacci_sphere(i, num, step, root_sphere) ;
  return list_points ;
}
/*
float root_cartesian_fibonnaci(int num) {
  return random(1) *num ;
}
*/

vec3 distribution_cartesian_fibonacci_sphere(int n, int num, float step, float root) {
  if(n<num) {
    float offset = 2. / num ;
    float y  = (n *offset) -1 + (offset / 2.) ;
    float r = sqrt(1 - pow(y,2)) ;
    float phi = ((n +root)%num) * step ;
    
    float x = cos(phi) *r ;
    float z = sin(phi) *r ;
    
    return vec3(x,y,z) ;
  } else return vec3() ;
}

/**
POLAR PROJECTION FIBONACCI SPHERE
*/
vec2 [] list_polar_fibonacci_sphere(int num, float step) {
  vec2 [] list_points = new vec2[num] ;
  for (int i = 0; i < list_points.length ; i++) list_points[i] = distribution_polar_fibonacci_sphere(i, num, step) ;
  return list_points ;
}
vec2 distribution_polar_fibonacci_sphere(int n, int num, float step) {
  if(n<num) {
    float longitude = r.PHI *TAU *n;
    longitude /= step ;
    // like a normalization of the result ?
    longitude -= floor(longitude); 
    longitude *= TAU;
    if (longitude > PI)  longitude -= TAU;
    // Convert dome height (which is proportional to surface area) to latitude
    float latitude = asin(-1 + 2*n/(float)num);
    return vec2(longitude, latitude) ;
  } else return vec2() ;

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
float deg360(PVector dir) {
  float deg360 ;
  deg360 = 360 -(degrees(atan2(dir.x, dir.y)) +180);
  return deg360 ;
}

float deg360(vec2 dir) {
  float deg360 ;
  deg360 = 360 -(degrees(atan2(dir.x, dir.y)) +180);
  return deg360 ;
}

/**
ROTATION
*/
//Rotation Objet
void rotation(float angle, float pos_x, float pos_y) {
  translate(pos_x,pos_y);
  rotate (radians(angle));
}

void rotation(float angle, vec2 pos) {
  translate(pos.x,pos.y);
  rotate(radians(angle));
}

vec2 rotation(vec2 ref, vec2 lattice, float angle) {
  float a = angle(lattice, ref) +angle;
  float d = lattice.dist(ref);
  float x = lattice.x +cos(a) *d;
  float y = lattice.y +sin(a) *d;
  return vec2(x,y);
}

/**
May be must push to deprecated
*/
vec2 rotation_lattice(vec2 ref, vec2 lattice, float angle) {
  float a = angle( lattice, ref) +angle;
  float d = dist( lattice, ref);
  float x = lattice.x +cos(a) *d;
  float y = lattice.y +sin(a) *d;
  return vec2(x,y);
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
PRIMITIVE 3D
*/

/**
* POLYHEDRON
* v 0.3.1
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

@Deprecated
void polyhedron(String type, String style, int size) {
  if(style.equals("LINE")) polyhedron(type, LINE, size);
  if(style.equals("POINT")) polyhedron(type, POINT, size);
  if(style.equals("VERTEX")) polyhedron(type, VERTEX, size);
}

@Deprecated
void polyhedron(String type, String style, int size, PGraphics other) {
  if(style.equals("LINE")) polyhedron(type, LINE, size, other);
  if(style.equals("POINT")) polyhedron(type, POINT, size, other);
  if(style.equals("VERTEX")) polyhedron(type, VERTEX, size, other);
}

void polyhedron(String type, int style, int size) {
  polyhedron(type,style,size,null);
}

void polyhedron(String type, int style, int size, PGraphics other) {
  //This is where the actual defining of the polyhedrons takes place
  if(vec_polyhedron_list != null) {
    //clear out whatever verts are currently defined
    vec_polyhedron_list.clear();
  } else {
    vec_polyhedron_list = new ArrayList();
  }
  
  if(type.equals("TETRAHEDRON")) tetrahedron_poly(size);
  if(type.equals("CUBE")) cube(size);
  if(type.equals("OCTOHEDRON")) octohedron(size);
  if(type.equals("DODECAHEDRON"))dodecahedron(size);
  if(type.equals("ICOSAHEDRON")) icosahedron(size);
  if(type.equals("CUBOCTAHEDRON")) cuboctahedron(size);
  if(type.equals("ICOSI DODECAHEDRON")) icosi_dodecahedron(size);

  if(type.equals("TRUNCATED CUBE")) truncated_cube(size);
  if(type.equals("TRUNCATED OCTAHEDRON")) truncated_octahedron(size);
  if(type.equals("TRUNCATED DODECAHEDRON")) truncated_dodecahedron(size);
  if(type.equals("TRUNCATED ICOSAHEDRON")) truncated_icosahedron(size);
  if(type.equals("TRUNCATED CUBOCTAHEDRON")) truncated_cuboctahedron(size);
  
  if(type.equals("RHOMBIC CUBOCTAHEDRON")) rhombic_cuboctahedron(size);
  if(type.equals("RHOMBIC DODECAHEDRON")) rhombic_dodecahedron(size);
  if(type.equals("RHOMBIC TRIACONTAHEDRON")) rhombic_triacontahedron(size);
  if(type.equals("RHOMBIC COSI DODECAHEDRON SMALL")) rhombic_cosi_dodecahedron_small(size);
  if(type.equals("RHOMBIC COSI DODECAHEDRON GREAT")) rhombic_cosi_dodecahedron_great(size);
  
  if(style == LINE) {
    polyhedron_draw_line(type,other);
  } else if(style == POINT) {
    polyhedron_draw_point(type,other);
  } else if(style == VERTEX) { 
    polyhedron_draw_vertex(type,other);
  } else {
    polyhedron_draw_line(type,other);
  }
}




// POLYHEDRON DETAIL 
//set up initial polyhedron
float factor_size_polyhedron ;
//some variables to hold the current polyhedron...
ArrayList<vec3>vec_polyhedron_list;
float edge_polyhedron_length;

// FEW POLYHEDRON
// BASIC
void tetrahedron_poly(int size) {
  if(vec_polyhedron_list == null) vec_polyhedron_list = new ArrayList();
  vec_polyhedron_list.add(vec3(1,1,1));
  vec_polyhedron_list.add(vec3(-1,-1,1));
  vec_polyhedron_list.add(vec3(-1,1,-1));
  vec_polyhedron_list.add(vec3(1,-1,-1));
  edge_polyhedron_length = 0 ;
  factor_size_polyhedron = size /2;
}

void cube(int size) {
  add_vertices(1, 1, 1);
  edge_polyhedron_length = 2;
  factor_size_polyhedron = size /2;
}

void octohedron(int size) {
  add_permutations(1, 0, 0);
  edge_polyhedron_length = r.ROOT2;
  factor_size_polyhedron = size *.8;
}

void dodecahedron(int size) {
  add_vertices(1, 1, 1);
  add_permutations(0, 1/r.PHI, r.PHI);
  edge_polyhedron_length = 2/r.PHI;
  factor_size_polyhedron = size /2.5;
}


// SPECIAL
void icosahedron(int size) {
  add_permutations(0,1,r.PHI);
  edge_polyhedron_length = 2.0;
  factor_size_polyhedron = size /2.7;
}

void icosi_dodecahedron(int size) {
  add_permutations(0,0,2*r.PHI);
  add_permutations(1,r.PHI,sq(r.PHI));
  edge_polyhedron_length = 2;
  factor_size_polyhedron = size/5;
}

void cuboctahedron(int size) {
  add_permutations(1,0,1);
  edge_polyhedron_length = r.ROOT2;
  factor_size_polyhedron = size /1.9;
}


// TRUNCATED
void truncated_cube(int size) {
  add_permutations(r.ROOT2-1,1,1);
  edge_polyhedron_length = 2*(r.ROOT2-1);     
  factor_size_polyhedron = size /2.1;
}

void truncated_octahedron(int size) {
  add_permutations(0,1,2);
  add_permutations(2,1,0);
  edge_polyhedron_length = r.ROOT2;
  factor_size_polyhedron = size/3.4;
}

void truncated_cuboctahedron(int size) {
  add_permutations(r.ROOT2+1,2*r.ROOT2 + 1, 1);
  add_permutations(r.ROOT2+1,1,2*r.ROOT2 + 1);
  edge_polyhedron_length = 2;
  factor_size_polyhedron = size/6.9;
}

void truncated_dodecahedron(int size) {
  add_permutations(0,1/r.PHI,r.PHI+2);
  add_permutations(1/r.PHI,r.PHI,2*r.PHI);
  add_permutations(r.PHI,2,sq(r.PHI));
  edge_polyhedron_length = 2*(r.PHI - 1);
  factor_size_polyhedron = size/6;
}

void truncated_icosahedron(int size) {
  add_permutations(0,1,3*r.PHI);
  add_permutations(2,2*r.PHI+1,r.PHI);
  add_permutations(1,r.PHI+2,2*r.PHI);
  edge_polyhedron_length = 2;
  factor_size_polyhedron = size/8;
}

// RHOMBIC
void rhombic_dodecahedron(int size) {
  add_vertices(1,1,1);
  add_permutations(0,0,2);
  edge_polyhedron_length = sqrt(3);
  factor_size_polyhedron = size /2.8;
}

void rhombic_triacontahedron(int size) {
  add_vertices(sq(r.PHI), sq(r.PHI), sq(r.PHI));
  add_permutations(sq(r.PHI), 0, pow(r.PHI, 3));
  add_permutations(0,r.PHI, pow(r.PHI,3));
  edge_polyhedron_length = r.PHI*sqrt(r.PHI+2);
  factor_size_polyhedron = size /7.2;
}

void rhombic_cuboctahedron(int size) {
  add_permutations(r.ROOT2 + 1, 1, 1);
  edge_polyhedron_length = 2;
  factor_size_polyhedron = size/4.2;
}

void rhombic_cosi_dodecahedron_small(int size) {
  add_permutations(1, 1, pow(r.PHI,3));
  add_permutations(sq(r.PHI),r.PHI,2*r.PHI);
  add_permutations(r.PHI+2,0,sq(r.PHI));
  edge_polyhedron_length = 2;
  factor_size_polyhedron = size/7.4;
}

void rhombic_cosi_dodecahedron_great(int size) {
  add_permutations(1/r.PHI,1/r.PHI,r.PHI+3);
  add_permutations(2/r.PHI,r.PHI,2*r.PHI+1);
  add_permutations(1/r.PHI, sq(r.PHI),3*r.PHI-1);
  add_permutations(2*r.PHI-1,2,r.PHI+2);
  add_permutations(r.PHI,3,2*r.PHI);
  edge_polyhedron_length = 2*r.PHI-2;
  factor_size_polyhedron = size/7.8;
}



//Built Tetrahedron
// EASY METHOD, for direct and single drawing
// classic and easy method
void polyhedron_draw_point(String name) {
  polyhedron_draw_point(name,null);
}

void polyhedron_draw_point(String name, PGraphics other) {
  for (int i = 0 ; i < vec_polyhedron_list.size() ; i++) {
    vec3 point = vec_polyhedron_list.get(i);
    if(name.equals("TETRAHEDRON")) {
      tetrahedron_draw_point(point, other);
    } else {
      point(point.mult(factor_size_polyhedron));
    }
  }
}


void polyhedron_draw_line(String name) {
  polyhedron_draw_line(name,null);
}

void polyhedron_draw_line(String name, PGraphics other) {
  for (int i=0; i < vec_polyhedron_list.size(); i++) {
    for (int j = i+1; j < vec_polyhedron_list.size(); j++) {
      if (edge_is(i, j, vec_polyhedron_list) || edge_polyhedron_length == 0) {
        vec3 v1 = vec_polyhedron_list.get(i).copy();
        vec3 v2 = vec_polyhedron_list.get(j).copy();
        if(name.equals("TETRAHEDRON")) {
          tetrahedron_draw_line(v1, v2, other);
        } else {
          line(v1.mult(factor_size_polyhedron), v2.mult(factor_size_polyhedron), other);
        }
      }
    }
  }
}



void polyhedron_draw_vertex(String name) {
  polyhedron_draw_vertex(name,null);
}

void polyhedron_draw_vertex(String name, PGraphics other) {
  // TETRAHEDRON
  if(name.equals("TETRAHEDRON")) {
    tetrahedron_draw_vertex(other);
  // OTHER POLYHEDRON
  } else {
    beginShape(other) ;
    for (int i= 0; i <vec_polyhedron_list.size(); i++) {
      for (int j= i +1; j <vec_polyhedron_list.size(); j++) {
        if (edge_is(i, j, vec_polyhedron_list) || edge_polyhedron_length == 0 ) {
          // vLine((PVector)vec_polyhedron_list.get(i), (PVector)vec_polyhedron_list.get(j));
          vec3 v1 = vec_polyhedron_list.get(i).copy();
          vec3 v2 = vec_polyhedron_list.get(j).copy();
          v1.mult(factor_size_polyhedron);
          v2.mult(factor_size_polyhedron);;
          vertex(v1,other);
          vertex(v2,other);
        }
      }
    }
    endShape(CLOSE,other);
  }
}
// END of EASY METHOD and DIRECT METHOD





/**
annexe draw polyhedron
*/
boolean edge_is(int vID1, int vID2, ArrayList<vec3> array_points) {
  //had some rounding errors that were messing things up, so I had to make it a bit more forgiving...
  int pres = 1000;
  vec3 v1 = array_points.get(vID1).copy();
  vec3 v2 = array_points.get(vID2).copy();
  float d = sqrt(sq(v1.x - v2.x) + sq(v1.y - v2.y) + sq(v1.z - v2.z)) + .00001;
  return (int(d *pres)==int(edge_polyhedron_length *pres));
}






// ADD POINTS for built POLYHEDRON
/////////////////////////////////
void add_permutations(float x, float y, float z) {
  //adds vertices for all three permutations of x, y, and z
  add_vertices(x, y, z);
  add_vertices(z, x, y);
  add_vertices(y, z, x);
}


 
void add_vertices(float x, float y, float z) {
  //adds the requested vert and all "mirrored" verts
  vec_polyhedron_list.add (vec3(x,y,z));
  // z
  if (z != 0.0) vec_polyhedron_list.add (vec3(x,y,-z)); 
  // y
  if (y != 0.0) {
    vec_polyhedron_list.add (vec3(x, -y, z));
    if (z != 0.0) vec_polyhedron_list.add(vec3(x,-y,-z));
  } 
  // x
  if (x != 0.0) {
    vec_polyhedron_list.add (vec3(-x, y, z));
    if (z != 0.0) vec_polyhedron_list.add(vec3(-x,y,-z));
    if (y != 0.0) {
      vec_polyhedron_list.add(vec3(-x, -y, z));
      if (z != 0.0) vec_polyhedron_list.add(vec3(-x,-y,-z));
    }
  }
}


/**
* tetrahedron
*/
void tetrahedron_draw_point(vec3 point, PGraphics other) {
  push(other);
  rotateX(TAU -1,other);
  rotateY(PI/4,other);
  point(point.mult(factor_size_polyhedron));
  pop(other);
}


void tetrahedron_draw_line(vec3 v1, vec3 v2, PGraphics other) {
  push(other) ;
  rotateX(TAU -1,other);
  rotateY(PI/4,other);
  line(v1.mult(factor_size_polyhedron), v2.mult(factor_size_polyhedron), other);
  pop(other);
}


void tetrahedron_draw_vertex(PGraphics other) {
  push(other);
  rotateX(TAU -1,other);
  rotateY(PI/4,other) ;
  int n = 4 ; // quantity of face of Tetrahedron
  for(int i = 0 ; i < n ; i++) {
      // choice of each point
      int a = i ;
      int b = i+1 ;
      int c = i+2 ;
      if(i == n-2 ) c = 0 ;
      if(i == n-1 ) {
        b = 0 ;
        c = 1 ;
      }
      vec3 v1 = vec_polyhedron_list.get(a).copy();
      vec3 v2 = vec_polyhedron_list.get(b).copy();
      vec3 v3 = vec_polyhedron_list.get(c).copy();
      // scale the position of the points
      v1.mult(factor_size_polyhedron);
      v2.mult(factor_size_polyhedron);
      v3.mult(factor_size_polyhedron);
      
      // drawing
      beginShape(other);
      vertex(v1,other);
      vertex(v2,other);
      vertex(v3,other);
      endShape(CLOSE,other);
    }
    pop(other);
 }
