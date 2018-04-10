/**

DEPRECATED

*/

void crossPoint3D(PVector pos, PVector size, color colorCross, float e ) {
  if (e <0.1) e = 0.1 ;
  stroke(colorCross) ;
  strokeWeight(e) ;
  //horizontal
  line(pos.x, pos.y -size.x,0, pos.x, pos.y +size.x,0) ;
  //vertical
  line(pos.x +size.y, pos.y,0, pos.x -size.y, pos.y,0) ;
  //depth
  line(pos.x, pos.y,size.z, pos.x, pos.y,-size.z) ;
}









/**
CLASS PIXEL
*/

class Old_Pixel {
  color colour, newColour ;
  PVector newC = new PVector (0,0,0) ; ;
  PVector pos ;
  PVector newPos = new PVector(0,0,0) ; // absolute pos in the display size : horizontal sytem of pixel system
  PVector gridPos ; // position with cols and rows system : vertical system of ArrayList
  PVector size = new PVector (1,1,1) ;
  float field = 1.0 ;
  PVector wind ; // the wind force who can change the position of the pixel
  float life = 1.0 ;
  int rank = -1 ;
  int ID = 0 ;
  
  //DIFFERENT CONSTRUCTOR
  
  //classic pixel
  Old_Pixel(PVector pos) {
    this.pos = new PVector(pos.x, pos.y, pos.z) ;
  }
  
  Old_Pixel(PVector pos, color colour) {
    this.pos = new PVector(pos.x, pos.y, pos.z) ;
    this.colour = colour ;
  }
  
  Old_Pixel(PVector pos, PVector size) {
    this.pos = new PVector(pos.x, pos.y, pos.z) ;
    this.size = new PVector(size.x, size.y, size.z) ;
  }
  
  //pixel with size
  Old_Pixel(PVector pos, PVector size, color colour) {
    this.pos = new PVector(pos.x, pos.y, pos.z) ;
    this.size = new PVector(size.x, size.y, size.z) ;
    this.colour = colour ;
  }
  
  //INK CONSTRUCTOR
  Old_Pixel(PVector pos, float field, color colour) {
    this.pos = new PVector(pos.x, pos.y, pos.z) ;
    this.field = field ;
    this.colour = colour ;
  }
  Old_Pixel(PVector pos, float field) {
    this.pos = new PVector(pos.x, pos.y, pos.z) ;
    this.field = field ;
  }
  
  //RANK PIXEL CONSTRUCTOR
  Old_Pixel(int rank, PVector gridPos) {
    this.rank = rank ;
    this.gridPos = gridPos ;
  }
  Old_Pixel(int rank) {
    this.rank = rank ;
  }
  
  
  
  
  //DISPLAY
    //without effect
  void displayPixel(int diam) {
    strokeWeight(diam) ;
    stroke(this.colour) ;
    if (newPos.x == 0 && newPos.y == 0 && newPos.z == 0) newPos = pos ; // else newPos = newPos ;
    //test display with ID
    if (ID == 1 ) point(newPos.x, newPos.y) ;
  }
  //with effect
  void displayPixel(int diam, PVector effectColor) {
    strokeWeight(diam) ;
    
    stroke(hue(newColour), effectColor.x *saturation(newColour), effectColor.y *brightness(newColour), effectColor.z) ;
    if (newPos.x == 0 && newPos.y == 0 && newPos.z == 0) newPos = pos ; // else newPos = newPos ;
    point(newPos.x, newPos.y) ;
  }

  //change ID after analyze if this one is good
  void changeID(int newID) {  ID = newID ; }
  
  // END DISPLAY
  
  
  
  // UPDATE
  //drying is like jitter but with time effect, it's very subtil so we use a float timer.
    // classic
  void drying(float timePast) {
    if (field > 0 ) { 
      field -= timePast ;
      float rad;
      float angle;
      rad = random(-1,1) *field;
      angle = random(-1,1) * TAU;
      pos.x += rad * cos(angle);
      pos.y += rad * sin(angle);
    }
  }
  // with external var
  void drying(float var, float timePast) {
    if (field > 0 ) { 
      field -= timePast ;
      float rad;
      float angle;
      rad = random(-1,1) *field *var;
      angle = random(-1,1) * TAU;
      pos.x += rad * cos(angle);
      pos.y += rad * sin(angle);
    }
  }
  
  
  
  
  
  //CHANGE COLOR 
  // hue from Range
  void changeHue(Vec4 HSBinfo, int[] newHue,  int[] start, int[] end) {
    float h = hue(this.colour) ;
    
    for( int i = 0 ; i < newHue.length ; i++) {
      if (start[i] < end[i] ) {
        if( h >= start[i] && h <= end[i] ) h = newHue[i] ; 
      } else if ( start[i] > end[i] ) {
        if( (h >= start[i] && h <= HSBinfo.x) || h <= end[i] ) { 
          if( h >= newHue[newHue.length -1] ) h = newHue[newHue.length -1] ; 
          else h = newHue[i] ; 
        }
      }        
    }
    newC.x = h ;
  }
  
  // saturation from Range
  void changeSat(Vec4 HSBinfo, int[] newSat,  int[] start, int[] end) {
    float s = saturation(this.colour) ;
    
    for( int i = 0 ; i < newSat.length ; i++) {
      if (start[i] < end[i] ) {
        if( s >= start[i] && s <= end[i] ) s = newSat[i] ; 
      } else if ( start[i] > end[i] ) {
        if( (s >= start[i] && s <= HSBinfo.y) || s <= end[i] ) { 
          if( s >= newSat[newSat.length -1] ) s = newSat[newSat.length -1] ;
          else s = newSat[i] ;
        }
      }        
    }
    newC.y = s ;
  }
  
  // saturation from Range
  void changeBright(Vec4 HSBinfo, int[] newBright,  int[] start, int[] end) {
    float b = brightness(this.colour) ;

    
    for( int i = 0 ; i < newBright.length ; i++) {
      if (start[i] < end[i] ) {
        if( b >= start[i] && b <= end[i] ) b = newBright[i] ; 
      } else if ( start[i] > end[i] ) {
        if( (b >= start[i] && b <= HSBinfo.z) || b <= end[i] ) { 
          if( b >= newBright[newBright.length -1] ) b = newBright[newBright.length -1] ;
          else b = newBright[i] ;
        }
      }        
    }
    newC.z = b ;
  }
  
  
  
  //change color of pixel for single color
  // void changeColor(color nc) { color c = nc ; }
  
  void updatePalette() { 
    int h = (int)newC.x ;
    int s = (int)newC.y ;
    int b = (int)newC.z ;

    newColour = color(h,s,b) ;
  }
  
  
  //UPDATE POSITION with the wind
  void updatePosPixel(PVector effectPosition, PImage pic) {
    PVector dir = normal_direction((int)effectPosition.x) ;
    
    wind = new PVector (1.0 *dir.x *effectPosition.y  + random(-effectPosition.z, effectPosition.z) ,   1.0 *dir.y *effectPosition.y  + random(-effectPosition.z, effectPosition.z))   ;
    pos.add(wind) ;
    //keep the pixel in the scene
    if (pos.x< 0)          pos.x= pic.width;
    if (pos.x> pic.width)  pos.x=0;
    if (pos.y< 0)          pos.y= pic.height;
    if (pos.y> pic.height) pos.y=0;
  }
  
  
  
  //return position with display size
  PVector posPixel(PVector effectPosition, PImage pic) {
    PVector dir = normal_direction((int)effectPosition.x) ;

    newPos = pos ;
    
    wind = new PVector (1.0 *dir.x *effectPosition.y  + random(-effectPosition.z, effectPosition.z) ,   1.0 *dir.y *effectPosition.y  + random(-effectPosition.z, effectPosition.z))   ;
    newPos.add(wind) ;
    //keep the pixel in the scene
    if (newPos.x< 0)          newPos.x= pic.width;
    if (newPos.x> pic.width)  newPos.x=0;
    if (newPos.y< 0)          newPos.y= pic.height;
    if (newPos.y> pic.height) newPos.y=0;
    
    return new PVector (newPos.x, newPos.y) ;
  }
}
// END CLASS PIXEL
/////////////////



















/**
 OLD Method deprecated
*/
//////////////////////////////////////////////
// THIS PART MUST BE DEPRECATED in the future
PVector rotation (PVector ref, PVector lattice, float angle) {
  float a = angle(lattice, ref) + angle;
  float d = distance( lattice, ref );
  float x = lattice.x + cos( a ) * d;
  float y = lattice.y + sin( a ) * d;
  return new PVector(x,y);
}
float distance( PVector p0, PVector p1) {
  return sqrt((p0.x - p1.x) *(p0.x - p1.x) +(p0.y - p1.y ) *(p0.y - p1.y ) );
}
float angle( PVector p0, PVector p1) {
  return atan2( p1.y -p0.y, p1.x -p0.x );
}


// CALCULATE THE POS of PVector Traveller
PVector gotoTarget(PVector origin,  PVector finish, float speed) {
  PVector pos = new PVector() ;
  if(origin.x > finish.x) pos.x = origin.x  -distanceDone(origin, finish, speed).x ; else pos.x = origin.x  +distanceDone(origin, finish, speed).x ; 
  if(origin.y > finish.y) pos.y = origin.y  -distanceDone(origin, finish, speed).y ; else pos.y = origin.y  +distanceDone(origin, finish, speed).y ; 
  if(origin.z > finish.z) pos.z = origin.z  -distanceDone(origin, finish, speed).z ; else pos.z = origin.z  +distanceDone(origin, finish, speed).z ; 
  return pos ;
}
// end calcultate




// DISTANCE DONE
PVector distance, distanceToDo ;
PVector distanceDone = new PVector() ;

PVector distanceDone(PVector origin,  PVector finish, float speedRef) {
  PVector dist = new PVector() ;
  PVector distance = new PVector() ;
  boolean stopX = false ;
  boolean stopY = false ;
  boolean stopZ = false ;
  distance.x = abs(finish.x - origin.x) ;
  distance.y = abs(finish.y - origin.y) ;
  distance.z = abs(finish.z - origin.z) ;
  //calcul the speed for XYZ
  PVector speed = new PVector(speedMoveTo(distance.x, speedRef), speedMoveTo(distance.y, speedRef), speedMoveTo(distance.z, speedRef)) ;
  // for the X
  dist.x = distance.x -distanceDone.x ;
  if(dist.x <= 0 ) stopX = true ; else stopX = false ;
  if(speed.x > dist.x ) speed.x = dist.x ;
  if(!stopX) distanceDone.x += speed.x ; else distanceDone.x = distance.x ;
  // for the Y
  dist.y = distance.y -distanceDone.y ;
  if(dist.y <= 0 ) stopY = true ; else stopY = false ;
  if(speed.y > dist.y ) speed.y = dist.y ;
  if(!stopY) distanceDone.y += speed.y ; else distanceDone.y = distance.y ;
  // for the Z
  dist.z = distance.z -distanceDone.z ;
  if(dist.z <= 0 ) stopZ = true ; else stopZ = false ;
  if(speed.z > dist.z ) speed.z = dist.z ;
  if(!stopZ) distanceDone.z += speed.z ; else distanceDone.z = distance.z ;
  //
  return distanceDone ;
}


float speedMoveTo(float distance, float speed) {
  return distance *1 *speed ;
}



// PVector goToPosFollow = = new PVector() ;
// CALCULATE THE POS of PVector Traveller, give the target pos and the speed to go.
PVector follow(PVector target, float speed) {
  PVector goToPosFollow = new PVector() ;
  // calcul X pos
  float targetX = target.x;
  float dx = targetX - goToPosFollow.x;
  if(abs(dx) != 0) {
    goToPosFollow.x += dx * speed;
  }
  // calcul Y pos
  float targetY = target.y;
  float dy = targetY - goToPosFollow.y;
  if(abs(dy) != 0) {
    goToPosFollow.y += dy * speed;
  }
  // calcul Z pos
  float targetZ = target.z;
  float dz = targetZ - goToPosFollow.z;
  if(abs(dz) != 0) {
    goToPosFollow.z += dz * speed;
  }
  return goToPosFollow ;
}





























//CLASS ROTATION
////////////////
class Rotation {
  float rotation ;
  float angle  ;
  
  Rotation () {}
  
  void update(Vec pos_temp, float speed) {
    Vec3 pos = Vec3() ;
    if(pos_temp instanceof Vec2) {
      Vec2 p = (Vec2) pos_temp ;
      pos.set(p.x, p.y, 0) ;
    } else if(pos_temp instanceof Vec3) {
      Vec3 p = (Vec3) pos_temp ;
      pos.set(p) ;
    }

    rotation += speed ;
    if (rotation > 360) {
      rotation = 0 ; 
    } else if (rotation < 0 ) {
      rotation = 360 ;
    }
    float angle = rotation ;
    translate (pos) ;
    rotate (radians(angle) ) ;
  }
} 
// END CLASS ROTATION










// CANVAS
/////////////////
/* Canvas 1.c by Stan le Punk february 2015 */
class Canvas {
  PVector pos, size ;
  PVector [] points  ;
    // X coord
  float left, right ;
  // Y coord
  float top, bottom ;
  // Z coord
  float front, back ;
  
  Canvas(PVector pos, PVector size) {
    this.pos = pos ;
    this.size = size ;
    update() ;
  }
  
  
  void update() {
    // X coord
    this.left = pos.x -(size.x *.5) ;
    this.right = pos.x +(size.x *.5) ;
   // Y coord
   this.top = pos.y -(size.y *.5) ;
   this.bottom = pos.y +(size.y *.5) ;
   // Z coord
   this.front = pos.z +(size.z *.5) ;
   this.back =  pos.z -(size.z *.5) ;
    
    if(size.y != 0) {
      points = new PVector[8] ;
      points[0] = new PVector(left,top,front) ;
      points[1] = new PVector(right,top,front) ;
      points[2] = new PVector(right,bottom,front) ;
      points[3] = new PVector(left,bottom,front) ;
      points[4] = new PVector(left,top,back) ;
      points[5] = new PVector(right,top,back) ;
      points[6] = new PVector(right,bottom,back) ;
      points[7] = new PVector(left,bottom,back) ;
    } else {
      points = new PVector[4] ;
      points[0] = new PVector(left,top) ;
      points[1] = new PVector(right,top) ;
      points[2] = new PVector(right,bottom) ;
      points[3] = new PVector(left,bottom) ;
    }
  }
  
  
  
  
  void canvasLine() {
    if(points.length > 4) {
      for(int i = 1 ; i < 4 ; i++) {
        // draw line box
        line(points[i-1].x, points[i-1].y,points[i-1].z, points[i].x,points[i].y, points[i-1].z) ;
        line(points[i+3].x, points[i+3].y,points[i+3].z, points[i+4].x,points[i+4].y, points[i+4].z) ;
      }
      // special line
      line(points[0].x, points[0].y,points[0].z, points[3].x,points[3].y, points[3].z) ;
      line(points[4].x, points[4].y,points[4].z, points[7].x,points[7].y, points[7].z) ;
      
      
      for(int i = 0 ; i < 4 ; i++) {
        line(points[i].x,points[i].y, points[i].z, points[i+4].x, points[i+4].y,points[i+4].z) ;
      }
    } else {
      // draw line rect
      for(int i = 1 ; i < 4 ; i++) {
         line(points[i-1].x, points[i-1].y, points[i].x,points[i].y) ;
      }
      // close
      line(points[3].x, points[3].y, points[0].x,points[0].y) ;
    }
  }
}
// END CANVAS
/////////////























/**
MUST BE REMPLACED BY PRIMITIVE
*/
// CLASS POLYGONE june 2015 / 1.1.2
///////////////////////////////////
class Polygon {
  Vec4 [] points ;
  PVector pos ;
  float radius ;
  // put the alpha to zero by default in case there is polygon outside the array when you want change the color of polygone
  color color_fill = color(255) ;
  color color_stroke = color(0) ;
  float strokeWeight = 1 ;
  int ID ;


  /*
  Maybe need to remove this option
  */
 //  PShape polygon;


  Polygon(PVector pos, float radius, float rotation, int num_of_summit, int ID) {
    this.pos = pos.copy() ;
    this.radius = radius ;
    this.ID = ID ;
    points = new Vec4 [num_of_summit] ;
    float angle = TAU / num_of_summit ;

    for (int i = 0; i < num_of_summit; i++) {
      float newAngle = angle*i;
      float x = pos.x + cos(newAngle +rotation) *radius;
      float y = pos.y + sin(newAngle +rotation) *radius;
      float z = pos.z ;
      points[i] = new Vec4(x, y, z, ID) ;
    }
    /*
    // Maybe need to remove this option
    polygon = createShape();
    create_poly_in_PShape();
    */
  }

  // DRAW
  void draw_polygon() {
    fill(color_fill) ;
    stroke(color_stroke) ;
    strokeWeight(strokeWeight) ;
    // check for transparency
    if(strokeWeight == 0 || alpha(color_stroke) == 0) noStroke() ;
    if(alpha(color_fill) == 0) noFill() ;
    // draw
    beginShape();
    for (int i = 0; i < points.length; i++) {
      vertex(points[i].x, points[i].y, points[i].z);
    }
    endShape(CLOSE) ;
  }
  
  void draw_polygon(PVector motion) {
    fill(color_fill) ;
    stroke(color_stroke) ;
    strokeWeight(strokeWeight) ;
    // check for transparency
    if(strokeWeight == 0 || alpha(color_stroke) == 0) noStroke() ;
    if(alpha(color_fill) == 0) noFill() ;
    // draw
    pushMatrix() ;
    translate(motion.x,motion.y,motion.z) ;
    beginShape();
    for (int i = 0; i < points.length; i++) {
      vertex(points[i].x, points[i].y, points[i].z);
    }
    endShape(CLOSE) ;
    popMatrix() ;
  }
  
  void draw_polygon(PVector motion, PVector rotation) {
    fill(color_fill) ;
    stroke(color_stroke) ;
    strokeWeight(strokeWeight) ;
    // check for transparency
    if(strokeWeight == 0 || alpha(color_stroke) == 0) noStroke() ;
    if(alpha(color_fill) == 0) noFill() ;
    // draw
    pushMatrix() ;
    translate(motion.x,motion.y,motion.z) ;
    rotateX(radians(rotation.x)) ;
    rotateZ(radians(rotation.y)) ;
    rotateY(radians(rotation.z)) ;
    beginShape();
    for (int i = 0; i < points.length; i++) {
      vertex(points[i].x, points[i].y, points[i].z);
    }
    endShape(CLOSE) ;
    popMatrix() ;
  }
  
  
  // SHAPE METHOD
  void draw_polygon_in_PShape(PShape in) {
    in.fill(color_fill) ;
    in.stroke(color_stroke) ;
    in.strokeWeight(strokeWeight) ;
    // check for trnsparency
    if(strokeWeight == 0 || alpha(color_stroke) == 0) in.noStroke() ;
    if(alpha(color_fill) == 0) in.noFill() ;
    // draw
    for (int i = 0; i < points.length; i++) {
      in.vertex(points[i].x, points[i].y, points[i].z);
    }
  }
  
  void draw_polygon_in_PShape(PShape in, PVector motion) {
    in.fill(color_fill) ;
    in.stroke(color_stroke) ;
    in.strokeWeight(strokeWeight) ;
    // check for trnsparency
    if(strokeWeight == 0 || alpha(color_stroke) == 0) in.noStroke() ;
    if(alpha(color_fill) == 0) in.noFill() ;
    // draw
    pushMatrix() ;
    translate(motion.x,motion.y,motion.z) ;
    for (int i = 0; i < points.length; i++) {
      in.vertex(points[i].x, points[i].y, points[i].z);
    }
    popMatrix() ;
  }
  //
  /*
  // Maybe need to remove this option
  void create_poly_in_PShape() {
    polygon.beginShape();

    polygon.fill(color_fill) ;
    polygon.stroke(color_stroke) ;
    polygon.strokeWeight(strokeWeight) ;
    for (int i = 0; i < points.length; i++) {
      polygon.vertex(points[i].x, points[i].y, points[i].z);
    }
    polygon.endShape(CLOSE) ;
  }
*/

  //UPDATE ALL THE POINT
  void update_AllPoints_Zpos_Polygon(float newPosZ) {
    for (int i = 0; i < points.length; i++) {
      points[i].z = newPosZ ;
    }
  }


  //UPDATE SPECIFIC POINT
  void update_SpecificPoints_Zpos_Polygon(PVector ref, float newPosZ) {
    for (int i = 0; i < points.length; i++) {
      float range = .1 ; // we use a range around the point to be sure to catch it.
      if ((ref.x <= points[i].x +range && ref.x >= points[i].x -range)  && (ref.y <= points[i].y +range && ref.y >= points[i].y -range) ) points[i].z = newPosZ ;
    }
  }


  boolean check_SpecificPoint_Polygon(PVector ref, float newPosZ) {
    boolean checked = false ;
    for (int i = 0; i < points.length; i++) {
      float range = .1 ; // we use a range around the point to be sure to catch it.
      if ((ref.x <= points[i].x +range && ref.x >= points[i].x -range)  && (ref.y <= points[i].y +range && ref.y >= points[i].y -range) ) checked = true ; 
      else checked = false ;
    }
    return checked ;
  }

}
/**

END POLYGON
*/







































/**
METEO

*/
/**

METEO

*/
YahooWeather weather;
int updateIntervallMillis = 30000;
boolean meteo ;

int sunRise, sunSet ;



//SETUP
void meteoSetup() {
  if (meteo) {
    String [] md = loadStrings (preference_path+"meteo.txt")  ;
    String meteoData  = join(md, "") ;
    String splitMeteoData [] = split(meteoData, '/') ;
  
    if (splitMeteoData[2].equals("celsius") ) weather = new YahooWeather(this, Integer.parseInt(splitMeteoData[4]), "c", updateIntervallMillis); else weather = new YahooWeather(this, Integer.parseInt(splitMeteoData[4]), "f", updateIntervallMillis) ;
  }
}

//DRAW
void meteoDraw() {
  if(meteo) {
    weather.update();
  
    //the sun set and the sunrise is calculate in minutes, one day is 1440 minutes, and the start is midnight
    sunRise = int(clock24(weather.getSunrise(), 1)) ;
    sunSet = int(clock24(weather.getSunset(), 1)) ;
  }
}


//ANNEXE

//CLOCK SUN
String clock24(String t, int mode) {
  String [] split = new String [2] ;
  String [] splitTime = new String [2] ;
  String clockSunset =  t ;
  //transform clock in 24h mode, then in number (int) ;
  split = split(clockSunset, " ") ;
  splitTime = split(split[0], ":") ;
  
  int hourSunset ;
  if (split[1].equals("pm") == true ) hourSunset = int(splitTime[0]) +12 ; else hourSunset = int(splitTime[0]) ;
  
  String clock24 = (hourSunset +"h"+splitTime[1]) ;
  int m = (int(hourSunset) * 60 + int(splitTime[1])) ;
  String min = (m + "") ;
  
  if (mode == 0 ) return clock24  ; else return min ;
}

//METEO COLOR
//global
float sky_h, sky_s, sky_b, sunValue ;



//one color
color meteoColor(color colorOfTheDay, int whatTimeIsIt, int speedRiseSet, int pressure) {
  color colorOfSky ;
  
  int sunrise,sunset ;
  float wPressure = map(pressure,930, 1060, 0,1) ;
  

  sunrise = int(clock24(weather.getSunrise(), 1)) ;
  sunset = int(clock24(weather.getSunset(), 1)) ;
  
  //basic 
  //if ( sunrise < whatTimeIsIt && sunset < whatTimeIsIt ) colorOfSky = bleuCiel ; else colorOfSky = bleuNuit ; 
  
  //smooth
  int minValueSat = 0 ;
  int minValueBright = 0 ;
  int maxValueSat = int(100 *wPressure) ;
  int maxValueBright = 100 ;
  speedRiseSet /= 2 ;
  

  //sunrise
  if (  whatTimeIsIt  > sunrise -speedRiseSet && whatTimeIsIt < sunrise +speedRiseSet ) {
    sunValue = whatTimeIsIt - sunrise +speedRiseSet  ;
    sky_h = hue(colorOfTheDay) ;
    sky_s = map(sunValue, 0,speedRiseSet, minValueSat, maxValueSat) ;
    sky_b = map(sunValue, 0,speedRiseSet, minValueBright, maxValueBright) ;
  //sunset   
  } else if (  whatTimeIsIt  > sunset -speedRiseSet && whatTimeIsIt < sunset +speedRiseSet ) {
    sunValue = whatTimeIsIt - sunset +speedRiseSet  ;
    sky_h = hue(colorOfTheDay) ;
    sky_s = map(sunValue, 0,speedRiseSet, maxValueSat, minValueSat) ;
    sky_b = map(sunValue, 0,speedRiseSet, maxValueBright, minValueBright) ;
  //the night  
  } else if ( whatTimeIsIt <= sunrise -speedRiseSet || whatTimeIsIt >= sunset +speedRiseSet ) {
    sky_h = hue(colorOfTheDay) ;
    sky_s = minValueSat ;
    sky_b = minValueBright ;
  //the day
  } else if ( whatTimeIsIt >= sunrise +speedRiseSet || whatTimeIsIt <= sunset -speedRiseSet ) {
    sky_h = hue(colorOfTheDay) ;
    sky_s = maxValueSat ;
    sky_b = maxValueBright ;
  }
  
  colorOfSky = color (sky_h,sky_s,sky_b) ;
  // colorOfSky = bleuNuit ;
  
  return colorOfSky ;
}



//PRESSION
int hectoPascal(float pressureToConvert) {
  int HP ;
  if (pressureToConvert < 800 ) HP = int(pressureToConvert *33.86) ; else HP = (int)pressureToConvert ;
  return HP ;
}
//WIND FORCE
int beaufort() {
  int forceDuVent = 0 ;
  if (weather.getWindSpeed() < 1 ) forceDuVent = 0 ;
  if (weather.getWindSpeed() > 0 && weather.getWindSpeed() < 6 ) forceDuVent = 1 ;
  if (weather.getWindSpeed() > 5 && weather.getWindSpeed() < 12 ) forceDuVent = 2 ;
  if (weather.getWindSpeed() > 11 && weather.getWindSpeed() < 20 ) forceDuVent = 3 ;
  if (weather.getWindSpeed() > 19 && weather.getWindSpeed() < 29 ) forceDuVent = 4 ;
  if (weather.getWindSpeed() > 28 && weather.getWindSpeed() < 39 ) forceDuVent = 5 ;
  if (weather.getWindSpeed() > 38 && weather.getWindSpeed() < 50 ) forceDuVent = 6 ;
  if (weather.getWindSpeed() > 49 && weather.getWindSpeed() < 62 ) forceDuVent = 7 ;
  if (weather.getWindSpeed() > 61 && weather.getWindSpeed() < 75 ) forceDuVent = 8 ;
  if (weather.getWindSpeed() > 74 && weather.getWindSpeed() < 89 ) forceDuVent = 9 ;
  if (weather.getWindSpeed() > 88 && weather.getWindSpeed() < 103 ) forceDuVent = 10 ;
  if (weather.getWindSpeed() > 102 && weather.getWindSpeed() < 118) forceDuVent = 11 ;
  if (weather.getWindSpeed() > 117 ) forceDuVent = 12 ;
  return forceDuVent ;
}



//WIND DIRECTION
//GLOBAL
String vent ;
//Void
String windFrench() {
  //wind
  
  if (weather.getWindDirection() > 348 || weather.getWindDirection() <  11 ) vent = "de Nord" ;
  if (weather.getWindDirection() >= 11  && weather.getWindDirection() < 34 )  vent = "de Nord-Nord-Est" ;
  if (weather.getWindDirection() >= 34  && weather.getWindDirection() < 56 )  vent = "de Nord-Est" ;
  if (weather.getWindDirection() >= 56  && weather.getWindDirection() < 79 )  vent = "de Est-Est-Nord" ;
  
  if (weather.getWindDirection() >= 79  && weather.getWindDirection() < 101 ) vent = "d'Est" ;
  if (weather.getWindDirection() >= 101  && weather.getWindDirection() < 124 ) vent = "d'Est-Est-Sud" ;
  if (weather.getWindDirection() >= 124 && weather.getWindDirection() < 146 ) vent = "de Sud-Est" ;
  if (weather.getWindDirection() >= 146 && weather.getWindDirection() < 169 ) vent = "de Sud-Sud-Est" ;
  
  if (weather.getWindDirection() >= 169 && weather.getWindDirection() < 191 ) vent = "de Sud" ;
  if (weather.getWindDirection() >= 191 && weather.getWindDirection() < 214 ) vent = "de Sud-Sud-Ouest" ;
  if (weather.getWindDirection() >= 214 && weather.getWindDirection() < 236 ) vent = "de Sud-Ouest" ;
  if (weather.getWindDirection() >= 236 && weather.getWindDirection() < 259 ) vent = "de Ouest-Ouest-Sud" ;
  
  if (weather.getWindDirection() >= 259 && weather.getWindDirection() < 281 ) vent = "d'Ouest" ;
  if (weather.getWindDirection() >= 281 && weather.getWindDirection() < 304 ) vent = "d'Ouest-Ouest-Nord" ;
  if (weather.getWindDirection() >= 304 && weather.getWindDirection() < 326 ) vent = "de Nord-Ouest" ;
  if (weather.getWindDirection() >= 326 && weather.getWindDirection() < 348 ) vent = "de Nord-Nord-Ouest" ;
  return vent ;
}




//TRADUCTION
String frenchWeatherDescription ;
String traductionWeather(int code) {
  if (code == 0 ) { frenchWeatherDescription =  "tornade" ; }
  if (code == 1 ) { frenchWeatherDescription =  "tempête tropicale" ; }
  if (code == 2 ) { frenchWeatherDescription =  "ouragan" ; }
  if (code == 3 ) { frenchWeatherDescription =  "orage violent" ; }
  if (code == 4 ) { frenchWeatherDescription =  "orage" ; }
  if (code == 5 ) { frenchWeatherDescription =  "pluie et neige mélangées" ; }
  if (code == 6 ) { frenchWeatherDescription =  "pluie et giboulée (grelons?)" ; }
  if (code == 7 ) { frenchWeatherDescription =  "neige et giboulée (grelons?)" ; }
  if (code == 8 ) { frenchWeatherDescription =  "bruine verglassante" ; }
  if (code == 9 ) { frenchWeatherDescription =  "bruine" ; }
  if (code == 10 ) { frenchWeatherDescription =  "pluie verglassante" ; }
  if (code == 11 ) { frenchWeatherDescription =  "averses" ; }
  if (code == 12 ) { frenchWeatherDescription =  "averses" ; }
  if (code == 13 ) { frenchWeatherDescription =  "averses de neige" ; }
  if (code == 14 ) { frenchWeatherDescription =  "averses de neige légère" ; }
  if (code == 15 ) { frenchWeatherDescription =  "rafales de neige" ; }
  if (code == 16 ) { frenchWeatherDescription =  "neige" ; }
  if (code == 17 ) { frenchWeatherDescription =  "grêle" ; }
  if (code == 18 ) { frenchWeatherDescription =  "giboulée" ; }
  if (code == 19 ) { frenchWeatherDescription =  "poussière" ; }
  if (code == 20 ) { frenchWeatherDescription =  "brouillard" ; }
  if (code == 21 ) { frenchWeatherDescription =  "brume" ; }
  if (code == 22 ) { frenchWeatherDescription =  "pollué" ; }
  if (code == 23 ) { frenchWeatherDescription =  "bourrasque" ; }
  if (code == 24 ) { frenchWeatherDescription =  "venteux" ; }
  if (code == 25 ) { frenchWeatherDescription =  "froid" ; }
  if (code == 26 ) { frenchWeatherDescription =  "couvert" ; }
  if (code == 27 ) { frenchWeatherDescription =  "nuit plutôt couverte" ; }
  if (code == 28 ) { frenchWeatherDescription =  "journée plutôt couverte" ; }
  if (code == 29 ) { frenchWeatherDescription =  "nuit partiellement couverte" ; }
  if (code == 30 ) { frenchWeatherDescription =  "journée partiellement couverte" ; }
  if (code == 31 ) { frenchWeatherDescription =  "nuit dégagée" ; }
  if (code == 32 ) { frenchWeatherDescription =  "ensolleillé" ; }
  if (code == 33 ) { frenchWeatherDescription =  "nuit dégagée" ; }
  if (code == 34 ) { frenchWeatherDescription =  "journée dégagée" ; }
  if (code == 35 ) { frenchWeatherDescription =  "pluie et grêle" ; }
  if (code == 36 ) { frenchWeatherDescription =  "chaud" ; }
  if (code == 37 ) { frenchWeatherDescription =  "orages localisés" ; }
  if (code == 38 ) { frenchWeatherDescription =  "orages éparses" ; }
  if (code == 39 ) { frenchWeatherDescription =  "orages éparses" ; }
  if (code == 40 ) { frenchWeatherDescription =  "averses éparses" ; }
  if (code == 41 ) { frenchWeatherDescription =  "grosses chute de neige" ; }
  if (code == 42 ) { frenchWeatherDescription =  "chutes de neige éparses" ; }
  if (code == 43 ) { frenchWeatherDescription =  "grosses chute de neige" ; }
  if (code == 44 ) { frenchWeatherDescription =  "partiellement couvert" ; }
  if (code == 45 ) { frenchWeatherDescription =  "pluies violentes" ; }
  if (code == 46 ) { frenchWeatherDescription =  "averses de neige" ; }
  if (code == 47 ) { frenchWeatherDescription =  "pluies violentes isolées" ; }
  if (code == 3200 ) { frenchWeatherDescription =  "non répertorié" ; } 
  
  return frenchWeatherDescription ;
}
/**
END METEO
*/
























