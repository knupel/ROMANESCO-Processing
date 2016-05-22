// Z_class 1.0.1






//CLASS ROTATION
////////////////
class Rotation {
  float rotation ;
  float angle  ;
  
  Rotation () {}
  
  void actualisation (PVector pos, float speed) {
    rotation += speed ;
    if ( rotation > 360 ) rotation = 0 ; else if (rotation < 0 ) rotation = 360 ;
    float angle = rotation ;
    translate (pos.x, pos.y) ;
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
// END POLYGON
///////////////