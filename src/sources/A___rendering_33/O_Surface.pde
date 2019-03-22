/**
SURFACE
2014-2019
v 1.1.2
*/

class Surface extends Romanesco {
  public Surface() {
    item_name = "Surface" ;
    item_author  = "Stan le Punk";
    item_version = "Version 1.1.2";
    item_pack = "Base 2014-2019";
    item_costume = "" ;
    item_mode = "Surfimage/Vague/Vague++" ; // separate the differentes mode by "/"

    hue_fill_is = true;
    sat_fill_is = true;
    bright_fill_is = true;
    alpha_fill_is = true;
    hue_stroke_is = true;
    sat_stroke_is = true;
    bright_stroke_is = true;
    alpha_stroke_is = true;
    thickness_is = true;
    size_x_is = true;
    // size_y_is = true;
    // size_z_is = true;
    // diameter_is = true;
    canvas_x_is = true;
    canvas_y_is = true;
    // canvas_z_is = true;

    // frequence_is = true;
    speed_x_is = true;
    // speed_y_is = true;
    // speed_z_is = true;
    // spurt_x_is = true;
    // spurt_y_is = true;
    // spurt_z_is = true;
    // dir_x_is = true;
    // dir_y_is = true;
    // dir_z_is = true;
    // jit_x_is = true;
    // jit_y_is = true;
    // jit_z_is = true;
    swing_x_is = true;
    // swing_y_is = true;
    // swing_z_is = true;

    // quantity_is = true;
    // variety_is = true;
    // life_is = true;
    // flow_is = true;
    quality_is = true;
    // area_is = true;
    // angle_is = true;
    // scope_is = true;
    // scan_is = true;
    // align_is = true;
    // repulsion_is = true;
    // attraction_is = true;
    // density_is = true;
    influence_is = true;
    // calm_is = true;
    // spectrum_is = true;
  }
  
  // Main method image 
  boolean newPicture ;
  boolean choicePicture = false ;
  PImage image  ;
  ArrayList<Polygon> grid_surface_image;
  // Main method surface simple
  ArrayList<Polygon> grid_surface_simple;
  
  // setup
  void setup() {
    setting_start_position(ID_item, width/2, height/2, -height/2) ;
    setting_start_direction(ID_item,45,-10) ;
    load_bitmap(ID_item);
  }
  
  // declare VAR
  //////////////
  float speed = .3 ;
  // GRID IMAGE
  int sizePixel_image ;
  int altitude_image ;
  // GRID SIMPLE
  float amplitude_simple_grid = 30 ;
  float ratio_swing = 4 ;
  float step  = .01 ;  
  float refSizeTriangle ;
  vec2 canvasRef ;
  vec4 fill_color, stroke_color ;
  
  
  // draw
  void draw() {
    if(grid_surface_image == null) grid_surface_image = new ArrayList<Polygon>();
    if(grid_surface_simple == null) grid_surface_simple = new ArrayList<Polygon>();
    // color to vec4 composant
    fill_color = vec4(hue(get_fill()),saturation(get_fill()),brightness(get_fill()),alpha(get_fill())) ;
    stroke_color = vec4(hue(get_stroke()),saturation(get_stroke()),brightness(get_stroke()),alpha(get_stroke())) ;
    // load image
    if(parameter_is()) {
      load_bitmap(ID_item);
    }

    //ratio speed
    float ratio_speed = get_speed_x() *get_speed_x() *get_speed_x() ;

    //speed
    if(motion_is() ) {
      speed = ratio_speed ; 
    } else { 
      speed = 0 ;
    }
    // swing
    if(sound_is() && sound_is()) { 
      ratio_swing = all_transient(ID_item) ; 
    } else {
      ratio_swing = 2 ;
    }
    // update motion
    if(motion_is()) {
      float speed_image = ratio_speed ;
      float amplitude_image = get_swing_x() *width *ratio_swing ;
      altitude_image = int(sin(frameCount *speed_image) *amplitude_image) ;
    }
    
    
    
    // IMAGE GRID
    sizePixel_image = floor(map(get_quality(), 0,1,width/20,2)) ;
    if(!FULL_RENDERING) sizePixel_image *= 3 ;
    // update data of the image
    if(key_n) {
      newPicture = false ; 
      choicePicture = false ;
    }
    
    
    
    
    // simple grid param
    ////////////////////
    if(get_mode_id() != 0 ) {
      //size pixel triangle
      int sizePixMin = 7 ;
      int sizePix_grid_simple = int(sizePixMin +get_size_x() /11) ;
      if(!FULL_RENDERING) sizePix_grid_simple *= 3 ;
      //size canvas grid
      vec2 newCanvas = vec2(get_canvas_x(),get_canvas_y()) ;
      newCanvas.mult(4.5) ;
      // create grid if there is no grid
      if(grid_surface_simple.size() < 1) create_surface_simple(sizePix_grid_simple,newCanvas) ;
      
      // from of the wave
      int maxStep = (int)map(get_influence(),0,1,2,50) ;
      step = map(noise(5),0,1,0,maxStep) ; // break the linear mode of the wave
      // amplitude
      amplitude_simple_grid = get_swing_x() *height *.07 *ratio_swing  ;
      amplitude_simple_grid *= amplitude_simple_grid  ;
      
      // clear the list
      if(refSizeTriangle != get_size_x() || !canvasRef.equals(newCanvas)) {
        grid_surface_simple.clear() ;
      }
      
      // Vague + clear
      if(get_mode_id() == 1 ) {
        if(refSizeTriangle != get_size_x() || !canvasRef.equals(newCanvas)) {
          if(get_mode_id() == 1 ) grid_surface_simple.clear() ;
          create_surface_simple(sizePix_grid_simple,newCanvas) ;
        }
      }
      // vague ++
      if(get_mode_id() == 2) {
        if(refSizeTriangle != get_size_x() || !canvasRef.equals(newCanvas)) {
          create_surface_simple(sizePix_grid_simple,newCanvas) ;
        }
      }
      // make the reference
      refSizeTriangle = get_size_x() ;
      canvasRef = newCanvas ;
    }
    // END simple grid param
    ////////////////////////
    

    
    
    // update all mode
    /////////////////////////////
    update_and_clean(get_mode_id()) ;
    
    // info
    if(get_mode_id() == 0 ) {
      String about_img = ("no image available");
      if(image != null) {
        about_img = ("size: "+image.width+"x"+image.height);
      }
      item_info[ID_item] =("Mode: " + get_mode_name() +" | Triangles:"+grid_surface_image.size() + " | " + about_img); 
    } else item_info[ID_item] =("Mode: " + get_mode_name() +" | Triangles:"+grid_surface_simple.size()) ;
    
    
  }
  // End Display method
  ////////////////////
  
  
  
  
  // Annexe method
 
  // method display mode
  void update_and_clean(int whichMode) {
    if(whichMode == 0 ) {
      if( grid_surface_simple.size() > 0 )grid_surface_simple.clear() ;
      update_surface_image(sizePixel_image, fill_color, stroke_color,get_thickness(), altitude_image) ;
    } else if (whichMode == 1 || whichMode == 2 ) {
      if( grid_surface_image.size() > 0 )grid_surface_image.clear() ;
      update_surface_simple(get_fill(), get_stroke(), get_thickness(), speed, amplitude_simple_grid, step) ;
    }
  }
  
  
  // SURFACE SIMPLE
  void create_surface_simple(int sizePix, vec2 canvas) {
    /*
    PVector setting_position give the starting position for the drawing grid, the value is -1 to 1
    if you start with (0,0) the canvas start from the center, if you use the extreme value, the draw start from corner.
    this value can be interesting for the rotation axes.
    */
    PVector pos = new PVector(0, 0) ; 
    surfaceGrid(sizePix, canvas, pos, grid_surface_simple) ;
  }
  
  
  void update_surface_simple(color c_fill, color c_stroke, float thickness, float speed, float amplitude, float step) {
    moveAllTriangle(speed, amplitude, step) ;
    for (Polygon t : grid_surface_simple) {
      t.color_fill = c_fill ;
      t.color_stroke = c_stroke ;
      t.strokeWeight = thickness ;
      t.draw_polygon() ;
    }
  }
  
  
  
  // WAVE MOVE
  int whichTriangleMove ;
  //wave
  float theta = 0 ;
  float wavePosition ;
  
  void moveAllTriangle(float speed, float amplitude, float step) {
     // wave move for triangle
    theta += speed ;
    wavePosition = theta ;
    whichTriangleMove++ ;
    if( whichTriangleMove > grid_surface_simple.size() ) whichTriangleMove = 0 ;
    //update pattern
    for ( Polygon t : grid_surface_simple) {
      t.update_AllPoints_Zpos_Polygon(sin(wavePosition)*amplitude) ;
      wavePosition += step ;
    }
  }
  // END SURFACE SIMPLE
  
  
  
  
  
  
  
  
  
  
  
  
  // BUILD SURFACE IMAGE
  vec4 stroke_ref = vec4()  ;
  vec4 fill_ref = vec4()  ;
  // float alpha_fill_ref  ;
  float thickness_ref  ;
  int altitude_ref ;
  boolean refresh_surface ;
    // advice method
  void update_surface_image(int sizePix, vec4 color_fill, vec4 color_stroke, float thickness, int altitude) {
    if( !stroke_ref.equals(color_stroke) || !fill_ref.equals(color_fill) || thickness_ref != thickness || altitude_ref != altitude) refresh_surface = true ;
    stroke_ref = color_stroke.copy() ;
    fill_ref = color_fill.copy() ;
    altitude_ref = altitude ;
    thickness_ref = thickness ;
    // if(choicePicture) loadImageFromFolder() ;
    if(!choicePicture) {
      image = bitmap[ID_item] ;
      newPicture = true ;
      choicePicture = true ;
    }
    if((newPicture && choicePicture) || refresh_surface) {
      surface_build_image_grid(0,0,altitude, sizePix, grid_surface_image, color_fill, color_stroke, thickness) ;
      refresh_surface = false ;
    }
    if(image != null) surfaceShapeDraw() ;
  }
  
  
  
  // SURFACE METHODE
  // annexe method
  void surface_build_image_grid(float x, float y, int altitude, int sizeTriangle, ArrayList<Polygon> gridTriangle, vec4 color_fill, vec4 color_stroke, float thickness) {
      //setting grid
    PVector pos = new PVector(x, y) ; 
    /*
    PVector setting_position give the starting position for the drawing grid, the value is -1 to 1
     if you start with (0,0) the canvas start from the center, if you use the extreme value, the draw start from corner.
     this value can be interesting for the rotation axes.
     */
    surfaceGridImg(sizeTriangle, pos, image, gridTriangle) ;
    if(gridTriangle.size() > 0 ) {
      println("compute Surface grid");
      surfaceImgColor(gridTriangle, color_fill, color_stroke, thickness) ;
      
      surfaceImgSummit(altitude, gridTriangle) ;
      createSurfaceShape(gridTriangle) ;
      newPicture = false ;
    }
  }
  
  // CHANGE PATTERN from IMAGE
  PImage imgSurface ;
  
  
  void surfaceGridImg(int sizePix, PVector pos, PImage imgSurface, ArrayList<Polygon> gridTriangle) {
    if(imgSurface != null) {
      // find info from image
      this.imgSurface = imgSurface ;
      // clear the list if you load an other picture.
      gridTriangle.clear(); 
      listTrianglePoint.clear() ;
      
      //classic grid method
      vec2 canvas = vec2(imgSurface.width, imgSurface.height);
      surfaceGrid(sizePix, canvas, pos, gridTriangle) ;
    }
  }
  
  // color surface
  void surfaceImgColor(ArrayList<Polygon> gridTriangle, vec4 color_fill, vec4 color_stroke, float thickness) {
    /* We calculated the value of first pixel in the pixel arraylist to remove or add this "firstValue" to the other the pixel, 
     because we need have count from zero to find give the good color to the good polygon. */
    Polygon ref = (Polygon) grid_surface_image.get(0) ;
    int firstValue = int((ref.pos.y -1) *imgSurface.width +ref.pos.x) ;

    for (Polygon t : gridTriangle) {
      // find the pixel in the picture import with the triangle grid to return the color to polygon.
      int  rankPixel = int((t.pos.y) *imgSurface.width +t.pos.x) -firstValue ;
  
      
      if (rankPixel < imgSurface.pixels.length) { //security for the array crash
        int colorTriangle = imgSurface.pixels[rankPixel] ;
        float newSat = saturation(colorTriangle) ;
        float newBright = brightness(colorTriangle) ;
        if (color_fill.gre() <= newSat ) newSat = color_fill.gre();
        if (color_fill.bri() <= newBright ) newBright = color_fill.bri();
        t.color_fill = color(hue(colorTriangle),newSat, newBright, color_fill.w) ;
        t.color_stroke = color(stroke_color.x,stroke_color.y,stroke_color.z,stroke_color.w)  ;
        t.strokeWeight = thickness ;
      }
    }
  }
  
  void surfaceImgSummit(int altitude, ArrayList<Polygon> gridTriangle) {
    /* We calculated the value of first pixel in the pixel arraylist to remove or add this "firstValue" to the other the pixel, 
     because we need have count from zero to find give the good color to the good polygon. */
    PVector posFirstValue = (PVector) listTrianglePoint.get(0) ;
    int firstValue = int((posFirstValue.y -1) *imgSurface.width +posFirstValue.x) ;
  
    for (PVector pos : listTrianglePoint) {
      int  rankPixel = int((pos.y) *imgSurface.width +pos.x) -firstValue ;
      //security for the array crash
      if (rankPixel < imgSurface.pixels.length) {
        float brightness = brightness(imgSurface.pixels[rankPixel]) ;
        // this value can change with you colorMode environement
        float maxValueBrightness = 255 ;
        pos.z = map(brightness, 0, maxValueBrightness, 0, 1) ;
  
        // update position
        for (Polygon t : gridTriangle) {
          t.update_SpecificPoints_Zpos_Polygon(pos, pos.z *altitude) ;
        }
      }
    }
  }
}










// SHAPE METHOD
  PShape patternShape;
  // local void
  void createSurfaceShape(ArrayList<Polygon> gridTriangle) {
    println("Create high Surface mesh");
    patternShape = createShape();
    patternShape.beginShape(TRIANGLES);
    for (Polygon t : gridTriangle) {
      t.draw_polygon_in_PShape(patternShape) ;
    }
    patternShape.endShape(CLOSE);
    println("High Surface mesh has been created with "+patternShape.getVertexCount()+" vertex");
  }
  //
  void surfaceShapeDraw() {
    shape(patternShape);
  }
  // END SHAPE METHOD
  ///////////////////




















// BUILD
/////////

// GRID TRIANGLE
ArrayList<PVector> listTrianglePoint = new ArrayList<PVector>() ;

// Main void
void surfaceGrid(int triangleSize, vec2 canvas, PVector pos, ArrayList<Polygon> gridTriangle) {
  buildTriangleGrid(triangleSize, canvas, pos, gridTriangle) ;
  selectCommonSummit(gridTriangle) ;
}


// Annexe void
// build the grid
void buildTriangleGrid(int triangleSize, vec2 canvas, PVector startingPositionToDraw, ArrayList<Polygon> gridTriangle) {
  triangleSize *=2 ;
  // setting var
  PVector pos =new PVector() ;
  int countTriangle = 0 ;
  // security
  if(triangleSize > canvas.x ) canvas.x = triangleSize ;
  if(triangleSize > canvas.y ) canvas.y = triangleSize ;
  
  //starting position
  startingPositionToDraw.x = map(startingPositionToDraw.x,-1,1,0,1) ;
  startingPositionToDraw.y = map(startingPositionToDraw.y,-1,1,0,1) ;
  PVector startingPos = new PVector(-canvas.x *startingPositionToDraw.x, -canvas.y *startingPositionToDraw.y) ;
  // define geometric data
  int radiusCircumCircle = triangleSize ;
  float sideLengthOfEquilateralTriangle = radiusCircumCircle *sqrt(3) ; // find the length of triangle side
  float medianLineLength = sideLengthOfEquilateralTriangle *(sqrt(3) *.5) ; // find the length of the mediane equilateral triangle
  
  // angle correction
  float correction = .5235 ;
  float correctionAngle  ;
  
  // Build the grid
  for(int i = 0 ; i < canvas.y/medianLineLength ; i++) {
    float verticalCorrection = medianLineLength *i ;
    // we change the starting line to make a good pattern.
    float horizontalCorrection ;
    if(i%2 == 0 ) horizontalCorrection = 0 ; else horizontalCorrection = sideLengthOfEquilateralTriangle *.5 ;
    
    for(int j = 0 ; j < canvas.x/sideLengthOfEquilateralTriangle*2 ; j++) {
      if(j%2 == 0 ) {
        correctionAngle = correction +PI ;
        // correction of the triangle position to have a good line
        float correctionPosY = (radiusCircumCircle*2) -medianLineLength ; 
        pos.y = radiusCircumCircle -correctionPosY + verticalCorrection;
        
      } else {
        pos.y = radiusCircumCircle +verticalCorrection ;
        correctionAngle = correction +TAU ;
      }
      pos.x = j *(sideLengthOfEquilateralTriangle *.5) +horizontalCorrection ; 
      pos.add(startingPos) ;
      
      //create triangle and add in the list of triangle
      Polygon triangle = new Polygon(pos, radiusCircumCircle, correctionAngle, 3, countTriangle++);
      gridTriangle.add(triangle) ;
      
    }
  }
}


// build the list of the common summit
void selectCommonSummit(ArrayList<Polygon> gridTriangle) {
  // loop to check the triangle list and add summit point to list
  boolean addSum = true ;
  for(Polygon p : gridTriangle) {
    int num = p.points.length ;
    for (int i = 0 ; i < num ; i++) {
      // find the position of the summit
      PVector posSum = new PVector(p.points[i].x, p.points[i].y) ;
      
      // check if the summits points are in the list
      for(PVector sumPoint : listTrianglePoint) {
        // we use a range around the point, because the calcul of the summit is not exact.
        float range = .1 ;
        if((posSum.x <= sumPoint.x +range && posSum.x >= sumPoint.x -range)  && (posSum.y <= sumPoint.y +range && posSum.y >= sumPoint.y -range) ) addSum = false ;
      }
      if(addSum)listTrianglePoint.add(posSum) ;
      addSum = true ;
    }
  }
}

// END BUILD
///////////











/**
MUST BE REMPLACED BY PRIMITIVE
*/
// CLASS POLYGONE june 2015 / 1.1.2
///////////////////////////////////

class Polygon {
  vec4 [] points ;
  PVector pos ;
  float radius ;
  // put the alpha to zero by default in case there is polygon outside the array when you want change the color of polygone
  color color_fill = color(255) ;
  color color_stroke = color(0) ;
  float strokeWeight = 1 ;
  int ID ;



  Polygon(PVector pos, float radius, float rotation, int num_of_summit, int ID) {
    this.pos = pos.copy() ;
    this.radius = radius ;
    this.ID = ID ;
    points = new vec4 [num_of_summit] ;
    float angle = TAU / num_of_summit ;

    for (int i = 0; i < num_of_summit; i++) {
      float newAngle = angle*i;
      float x = pos.x + cos(newAngle +rotation) *radius;
      float y = pos.y + sin(newAngle +rotation) *radius;
      float z = pos.z ;
      points[i] = new vec4(x, y, z, ID) ;
    }
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
}





















