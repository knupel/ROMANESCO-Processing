class Surface extends Romanesco {
  public Surface() {
    romanescoName = "Surface" ;
    IDobj = 24 ;
    IDgroup = 2 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Version 1.0.0";
    romanescoPack = "Base" ;
    romanescoMode = "Surfimage/Vague/Vague++" ; // separate the differentes mode by "/"
    romanescoSlider = "Hue fill,Saturation fill,Brightness fill,Alpha fill,Hue stroke,Saturation stroke,Brightness stroke,Alpha stroke,Thickness,Influence,Width,Canvas X,Canvas Y,Analyze,Amplitude,Speed" ;
  }
  
  // Main method image 
  boolean newPicture ;
  boolean choicePicture = false ;
  PImage image  ;
  ArrayList<Polygon> grid_surface_image = new ArrayList<Polygon>();
  // Main method surface simple
  ArrayList<Polygon> grid_surface_simple = new ArrayList<Polygon>();
  
  // setup
  void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
    loadImg(IDobj) ;
  }
  
  // declare VAR
  //////////////
  float speed = .3 ;
  // GRID IMAGE
  int sizePixel_image ;
  int altitude_image ;
  // GRID SIMPLE
  float amplitude_simple_grid = 30 ;
  float step  = .01 ;  
  float refSizeTriangle ;
  Vec2 canvasRef ;
  Vec4 fill_color, stroke_color ;
  
  
  // draw
  void display() {
    // color to Vec4 composant
    fill_color = Vec4(hue(fillObj[IDobj]),saturation(fillObj[IDobj]),brightness(fillObj[IDobj]),alpha(fillObj[IDobj])) ;
    stroke_color = Vec4(hue(strokeObj[IDobj]),saturation(strokeObj[IDobj]),brightness(strokeObj[IDobj]),alpha(strokeObj[IDobj])) ;
    // load image
    if(parameter[IDobj]) loadImg(IDobj) ;


    if(motion[IDobj]) speed = speedObj[IDobj] *.7 ; else speed = 0 ;
    
    
    
    // IMAGE GRID
    sizePixel_image = floor(map(analyzeObj[IDobj], 0,1,width/20,2)) ;
    if(!fullRendering) sizePixel_image *= 3 ;
    // update data of the image
    if(nTouch) {
      newPicture = false ; 
      choicePicture = false ;
    }
    
    
    
    
    // simple grid param
    ////////////////////
    if(mode[IDobj] != 0 ) {
      //size pixel triangle
      int sizePixMin = 7 ;
      int sizePix_grid_simple = int(sizePixMin +sizeXObj[IDobj] /33) ;
      if(!fullRendering) sizePix_grid_simple *= 3 ;
      //size canvas grid
      Vec2 newCanvas = Vec2(canvasXObj[IDobj],canvasYObj[IDobj]) ;
      newCanvas.mult(4.5) ;
      // create grid if there is no grid
      if( grid_surface_simple.size() < 1) create_surface_simple(sizePix_grid_simple,newCanvas) ;
      
      // from of the wave
      int maxStep = (int)map(influenceObj[IDobj],0,1,2,50) ;
      step = map(noise(5),0,1,0,maxStep) ; // break the linear mode of the wave
      // amplitude
      amplitude_simple_grid = amplitudeObj[IDobj] *height *.07 *beat[IDobj] *mix[IDobj]  ;
      amplitude_simple_grid *= amplitude_simple_grid  ;
      
      // clear the list
      if(resetAction(IDobj)) {
        grid_surface_simple.clear() ;
      }
      
      // Vague + clear
      if(mode[IDobj] == 1 ) {
        if( refSizeTriangle != sizeXObj[IDobj] || !compare(canvasRef,newCanvas) ) {
          if(mode[IDobj] == 1 ) grid_surface_simple.clear() ;
          create_surface_simple(sizePix_grid_simple,newCanvas) ;
        }
      }
      // vague ++
      if(mode[IDobj] == 2) {
        if( refSizeTriangle != sizeXObj[IDobj] || !compare(canvasRef,newCanvas) ) {
          create_surface_simple(sizePix_grid_simple,newCanvas) ;
        }
      }
      // make the reference
      refSizeTriangle = sizeXObj[IDobj] ;
      canvasRef = newCanvas ;
    }
    // END simple grid param
    ////////////////////////
    
    // update image grid
    if(motion[IDobj]) {
      float speed_image = speedObj[IDobj] * .2 ;
      float amplitude_image = amplitudeObj[IDobj] *width *2 *mix[IDobj] ;
      altitude_image = int(sin(frameCount *speed_image) *amplitude_image) ;
    }
    
    
    // update all mode
    /////////////////////////////
    update_and_clean(mode[IDobj]) ;
    
    // info
    if(mode[IDobj] == 0 ) {
      objectInfo[IDobj] =("Mode: " + mode[IDobj] +" | Triangles:"+grid_surface_image.size() + " | " + image.width + "x" + image.height) ; 
    } else objectInfo[IDobj] =("Mode: " + mode[IDobj] +" | Triangles:"+grid_surface_simple.size()) ;
    
    
  }
  // End Display method
  ////////////////////
  
  
  
  
  // Annexe method
  ///////////////
 
  // method display mode
  void update_and_clean(int whichMode) {
    if(whichMode == 0 ) {
      if( grid_surface_simple.size() > 0 )grid_surface_simple.clear() ;
      update_surface_image(sizePixel_image, fill_color, stroke_color,thicknessObj[IDobj], altitude_image) ;
    } else if (whichMode == 1 || whichMode == 2 ) {
      if( grid_surface_image.size() > 0 )grid_surface_image.clear() ;
      update_surface_simple(fillObj[IDobj], strokeObj[IDobj], thicknessObj[IDobj], speed, amplitude_simple_grid, step) ;
    }
  }
  
  
  // SURFACE SIMPLE
  void create_surface_simple(int sizePix, Vec2 canvas) {
    /*
    PVector startingPosition give the starting position for the drawing grid, the value is -1 to 1
    if you start with (0,0) the canvas start from the center, if you use the extreme value, the draw start from corner.
    this value can be interesting for the rotation axes.
    */
    PVector startingPosition = new PVector(0, 0) ; 
    surfaceGrid(sizePix, canvas, startingPosition, grid_surface_simple) ;
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
  Vec4 stroke_ref = new Vec4()  ;
  Vec4 fill_ref = new Vec4()  ;
  // float alpha_fill_ref  ;
  float thickness_ref  ;
  int altitude_ref ;
  boolean refresh_surface ;
    // advice method
  void update_surface_image(int sizePix, Vec4 color_fill, Vec4 color_stroke, float thickness, int altitude) {
    if( !compare(stroke_ref,color_stroke) || !compare(fill_ref,color_fill) || thickness_ref != thickness || altitude_ref != altitude) refresh_surface = true ;
    stroke_ref = color_stroke.copy() ;
    fill_ref = color_fill.copy() ;
    altitude_ref = altitude ;
    thickness_ref = thickness ;
    // if(choicePicture) loadImageFromFolder() ;
    if(!choicePicture) {
      image = img[IDobj] ;
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
    PVector startingPosition = new PVector(x, y) ; 
    /*
    PVector startingPosition give the starting position for the drawing grid, the value is -1 to 1
     if you start with (0,0) the canvas start from the center, if you use the extreme value, the draw start from corner.
     this value can be interesting for the rotation axes.
     */
    surfaceGridImg(sizeTriangle, startingPosition, image, gridTriangle) ;
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
  
  
  void surfaceGridImg(int sizePix, PVector startingPosition, PImage imgSurface, ArrayList<Polygon> gridTriangle) {
    if(imgSurface != null) {
      // find info from image
      this.imgSurface = imgSurface ;
      // clear the list if you load an other picture.
      gridTriangle.clear(); 
      listTrianglePoint.clear() ;
      
      //classic grid method
      Vec2 canvas = Vec2(imgSurface.width, imgSurface.height);
      surfaceGrid(sizePix, canvas, startingPosition, gridTriangle) ;
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
void surfaceGrid(int triangleSize, Vec2 canvas, PVector startingPositionToDraw, ArrayList<Polygon> gridTriangle) {
  buildTriangleGrid(triangleSize, canvas, startingPositionToDraw, gridTriangle) ;
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
