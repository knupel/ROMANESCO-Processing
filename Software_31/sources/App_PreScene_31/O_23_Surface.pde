/**
SURFACE
2014-2018
v 1.0.3
*/

class Surface extends Romanesco {
  public Surface() {
    item_name = "Surface" ;
    ID_item = 23 ;
    ID_group = 1 ;
    item_author  = "Stan le Punk";
    item_version = "Version 1.0.3";
    item_pack = "Base" ;
    item_mode = "Surfimage/Vague/Vague++" ; // separate the differentes mode by "/"
    // item_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Stroke hue,Stroke sat,Stroke bright,Stroke alpha,Thickness,Influence,Canvas X,Canvas Y,Quality,Canvas X,Speed X,Size X,Swing X" ;
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
    size_y_is = false;
    size_z_is = false;
    font_size_is = false;
    canvas_x_is = true;
    canvas_y_is = true;
    canvas_z_is = false;

    reactivity_is = false;
    speed_x_is = true;
    speed_y_is = false;
    speed_z_is = false;
    spurt_x_is = false;
    spurt_y_is = false;
    spurt_z_is = false;
    dir_x_is = false;
    dir_y_is = false;
    dir_z_is = false;
    jit_x_is = false;
    jit_y_is = false;
    jit_z_is  = false;
    swing_x_is = true;
    swing_y_is = false;
    swing_z_is = false;

    num_is = false;
    variety_is = false;
    life_is = false;
    flow_is = false;
    quality_is = true;
    area_is = false;
    angle_is = false;
    scope_is = false;
    scan_is = false;
    align_is = false;
    repulsion_is = false;
    attraction_is = false;
    density_is = false;
    influence_is = true;
    calm_is = false;
    spectrum_is = false;
  }
  
  // Main method image 
  boolean newPicture ;
  boolean choicePicture = false ;
  PImage image  ;
  ArrayList<Polygon> grid_surface_image = new ArrayList<Polygon>();
  // Main method surface simple
  ArrayList<Polygon> grid_surface_simple = new ArrayList<Polygon>();
  
  // setup
  void setup() {
    setting_start_position(ID_item, width/2, height/2, -height/2) ;
    setting_start_direction(ID_item, 45, -10) ;
    load_bitmap(ID_item) ;
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
  Vec2 canvasRef ;
  Vec4 fill_color, stroke_color ;
  
  
  // draw
  void draw() {
    // color to Vec4 composant
    fill_color = Vec4(hue(fill_item[ID_item]),saturation(fill_item[ID_item]),brightness(fill_item[ID_item]),alpha(fill_item[ID_item])) ;
    stroke_color = Vec4(hue(stroke_item[ID_item]),saturation(stroke_item[ID_item]),brightness(stroke_item[ID_item]),alpha(stroke_item[ID_item])) ;
    // load image
    if(parameter[ID_item]) load_bitmap(ID_item) ;

    //ratio speed
    float ratio_speed = speed_x_item[ID_item] *speed_x_item[ID_item] *speed_x_item[ID_item] ;

    //speed
    if(motion[ID_item] ) {
      speed = ratio_speed ; 
    } else { 
      speed = 0 ;
    }
    // swing
    if(sound[ID_item] && sound_is()) { 
      ratio_swing = allBeats(ID_item) ; 
    } else {
      ratio_swing = 2 ;
    }
    // update motion
    if(motion[ID_item]) {
      float speed_image = ratio_speed ;
      float amplitude_image = swing_x_item[ID_item] *width *ratio_swing ;
      altitude_image = int(sin(frameCount *speed_image) *amplitude_image) ;
    }
    
    
    
    // IMAGE GRID
    sizePixel_image = floor(map(quality_item[ID_item], 0,1,width/20,2)) ;
    if(!FULL_RENDERING) sizePixel_image *= 3 ;
    // update data of the image
    if(key_n) {
      newPicture = false ; 
      choicePicture = false ;
    }
    
    
    
    
    // simple grid param
    ////////////////////
    if(mode[ID_item] != 0 ) {
      //size pixel triangle
      int sizePixMin = 7 ;
      int sizePix_grid_simple = int(sizePixMin +size_x_item[ID_item] /11) ;
      if(!FULL_RENDERING) sizePix_grid_simple *= 3 ;
      //size canvas grid
      Vec2 newCanvas = Vec2(canvas_x_item[ID_item],canvas_y_item[ID_item]) ;
      newCanvas.mult(4.5) ;
      // create grid if there is no grid
      if(grid_surface_simple.size() < 1) create_surface_simple(sizePix_grid_simple,newCanvas) ;
      
      // from of the wave
      int maxStep = (int)map(influence_item[ID_item],0,1,2,50) ;
      step = map(noise(5),0,1,0,maxStep) ; // break the linear mode of the wave
      // amplitude
      amplitude_simple_grid = swing_x_item[ID_item] *height *.07 *ratio_swing  ;
      amplitude_simple_grid *= amplitude_simple_grid  ;
      
      // clear the list
      if(refSizeTriangle != size_x_item[ID_item] || !canvasRef.equals(newCanvas)) {
        grid_surface_simple.clear() ;
      }
      
      // Vague + clear
      if(mode[ID_item] == 1 ) {
        if(refSizeTriangle != size_x_item[ID_item] || !canvasRef.equals(newCanvas)) {
          if(mode[ID_item] == 1 ) grid_surface_simple.clear() ;
          create_surface_simple(sizePix_grid_simple,newCanvas) ;
        }
      }
      // vague ++
      if(mode[ID_item] == 2) {
        if(refSizeTriangle != size_x_item[ID_item] || !canvasRef.equals(newCanvas)) {
          create_surface_simple(sizePix_grid_simple,newCanvas) ;
        }
      }
      // make the reference
      refSizeTriangle = size_x_item[ID_item] ;
      canvasRef = newCanvas ;
    }
    // END simple grid param
    ////////////////////////
    

    
    
    // update all mode
    /////////////////////////////
    update_and_clean(mode[ID_item]) ;
    
    // info
    if(mode[ID_item] == 0 ) {
      objectInfo[ID_item] =("Mode: " + mode[ID_item] +" | Triangles:"+grid_surface_image.size() + " | " + image.width + "x" + image.height) ; 
    } else objectInfo[ID_item] =("Mode: " + mode[ID_item] +" | Triangles:"+grid_surface_simple.size()) ;
    
    
  }
  // End Display method
  ////////////////////
  
  
  
  
  // Annexe method
  ///////////////
 
  // method display mode
  void update_and_clean(int whichMode) {
    if(whichMode == 0 ) {
      if( grid_surface_simple.size() > 0 )grid_surface_simple.clear() ;
      update_surface_image(sizePixel_image, fill_color, stroke_color,thickness_item[ID_item], altitude_image) ;
    } else if (whichMode == 1 || whichMode == 2 ) {
      if( grid_surface_image.size() > 0 )grid_surface_image.clear() ;
      update_surface_simple(fill_item[ID_item], stroke_item[ID_item], thickness_item[ID_item], speed, amplitude_simple_grid, step) ;
    }
  }
  
  
  // SURFACE SIMPLE
  void create_surface_simple(int sizePix, Vec2 canvas) {
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
    for ( Polygon t : grid_surface_simple) {
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
  ////////////////////////////////////////////////////////////////////
  Vec4 stroke_ref = Vec4()  ;
  Vec4 fill_ref = Vec4()  ;
  // float alpha_fill_ref  ;
  float thickness_ref  ;
  int altitude_ref ;
  boolean refresh_surface ;
    // advice method
  void update_surface_image(int sizePix, Vec4 color_fill, Vec4 color_stroke, float thickness, int altitude) {
    if( !stroke_ref.equals(color_stroke) || !fill_ref.equals(color_fill) || thickness_ref != thickness || altitude_ref != altitude) refresh_surface = true ;
    stroke_ref = color_stroke.copy() ;
    fill_ref = color_fill.copy() ;
    altitude_ref = altitude ;
    thickness_ref = thickness ;
    // if(choicePicture) loadImageFromFolder() ;
    if(!choicePicture) {
      image = bitmap_import[ID_item] ;
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
  ///////////////////
  // annexe method
  void surface_build_image_grid(float x, float y, int altitude, int sizeTriangle, ArrayList<Polygon> gridTriangle, Vec4 color_fill, Vec4 color_stroke, float thickness) {
      //setting grid
    PVector pos = new PVector(x, y) ; 
    /*
    PVector setting_position give the starting position for the drawing grid, the value is -1 to 1
     if you start with (0,0) the canvas start from the center, if you use the extreme value, the draw start from corner.
     this value can be interesting for the rotation axes.
     */
    surfaceGridImg(sizeTriangle, pos, image, gridTriangle) ;
    if(gridTriangle.size() > 0 ) {
      if(TEST_ROMANESCO) println("compute Surface grid");
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
      Vec2 canvas = Vec2(imgSurface.width, imgSurface.height);
      surfaceGrid(sizePix, canvas, pos, gridTriangle) ;
    }
  }
  
  // color surface
  void surfaceImgColor(ArrayList<Polygon> gridTriangle, Vec4 color_fill, Vec4 color_stroke, float thickness) {
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
        if (color_fill.g <= newSat ) newSat = color_fill.g ;
        if (color_fill.b <= newBright ) newBright = color_fill.b ;
        t.color_fill = color(hue(colorTriangle),newSat, newBright, color_fill.a) ;
        t.color_stroke = color(stroke_color.r,stroke_color.g,stroke_color.b,stroke_color.a)  ;
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
  // END SURFACE METHODE
  //////////////////////
}










// SHAPE METHOD
  PShape patternShape;
  // local void
  void createSurfaceShape(ArrayList<Polygon> gridTriangle) {
    if(TEST_ROMANESCO) println("Create high Surface mesh");
    patternShape = createShape();
    patternShape.beginShape(TRIANGLES);
    for (Polygon t : gridTriangle) {
      t.draw_polygon_in_PShape(patternShape) ;
    }
    patternShape.endShape(CLOSE);
    if(TEST_ROMANESCO) println("High Surface mesh has been created with "+patternShape.getVertexCount()+" vertex");
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
void surfaceGrid(int triangleSize, Vec2 canvas, PVector pos, ArrayList<Polygon> gridTriangle) {
  buildTriangleGrid(triangleSize, canvas, pos, gridTriangle) ;
  selectCommonSummit(gridTriangle) ;
}


// Annexe void
// build the grid
void buildTriangleGrid(int triangleSize, Vec2 canvas, PVector startingPositionToDraw, ArrayList<Polygon> gridTriangle) {
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