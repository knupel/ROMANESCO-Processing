/**
WEBCAM 
2011-2019
v 1.2.10
*/
class Webcam extends Romanesco {
  public Webcam() {
    //from the index_objects.csv
    item_name = "Webcam" ;
    item_author  = "Stan le Punk";
    item_version = "Version 1.2.10";
    item_pack = "Base 2012-2019" ;
    item_costume = "" ;
    item_mode = "Rectangle color/Rectangle mono/Point color/Point mono/Box color/Box mono" ;

    hue_fill_is = true;
    sat_fill_is = true;
    bright_fill_is = true;
    alpha_fill_is = true;
    hue_stroke_is = false;
    sat_stroke_is = false;
    bright_stroke_is = false;
    alpha_stroke_is = false;
    thickness_is = false;
    size_x_is = true;
    size_y_is = true;
    size_z_is = true;
    diameter_is = false;
    canvas_x_is = true;
    canvas_y_is = true;
    canvas_z_is = false;

    // frequence_is = true;
    speed_x_is = false;
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
    swing_x_is = false;
    swing_y_is = false;
    swing_z_is = false;

    quantity_is = false;
    variety_is = false;
    life_is = false;
    flow_is = false;
    quality_is = false;
    area_is = false;
    angle_is = false;
    scope_is = false;
    scan_is = false;
    align_is = false;
    repulsion_is = false;
    attraction_is = false;
    density_is = false;
    influence_is = false;
    calm_is = false;
    spectrum_is = false;
  }
  //GLOBAL
  int cameraStatut = 0 ;

  vec2 factorDisplayCam ;
  vec3 factorDisplayPixel ;
  
  color colorPixelCam ;
  
  int cellSizeX, cellSizeY, posPixelX, posPixelY   ;
  int cols ;
  int rows ; 
  
  
  //SETUP
  void setup() {
    setting_start_position(ID_item, 0, 0, 0) ;
    factorDisplayCam = vec2();
    factorDisplayPixel = vec3();
  }
  //DRAW
  void draw() {
    select_camera(3);
    video_camera_manager();
    //PART ONE
    //calcul the ration between the size of camera and the size of the scene
    factorDisplayCam.set(width / CAM_SIZE.x,height / CAM_SIZE.y);
    
    // size
    float minVal = 0.1 ;
    float maxVal = height / 50 ;
    float size_x = map(get_size_x(),0.1,width, minVal, maxVal) *transient_value[3][ID_item] ;
    float size_y = map(get_size_y(),0.1,width, minVal, maxVal) *transient_value[2][ID_item] ;
    float size_z = map(get_size_z(),0.1,width, minVal, maxVal) *transient_value[4][ID_item] ;
    vec3 factorSizePix = vec3(size_x, size_y, size_z) ; 
    factorDisplayPixel.set(factorDisplayCam.x *factorSizePix.x,factorDisplayCam.y *factorSizePix.y, factorSizePix.z) ;//PARAMETER THAT YOU CAN USE
    
    //PART TWO

    if(FULL_RENDERING) {
      cellSizeX = int(map(get_canvas_y(),width/10, width, 50, 1))  ; 
      cellSizeY = int(map(get_canvas_x(),width/10, width, 50, 1))  ;
    } else {
      cellSizeX = int(map(get_canvas_y(),width/10, width, 50, 20))  ; 
      cellSizeY = int(map(get_canvas_x(),width/10, width, 50, 20))  ;
    }
    if(cellSizeX < 1 ) cellSizeX = 1 ;
    if(cellSizeY < 1 ) cellSizeY = 1 ;
    
    cols = (int)CAM_SIZE.x / cellSizeX; // before the resizing
    rows = (int)CAM_SIZE.y / cellSizeY;
    if (BROADCAST) {
      get_cam().loadPixels();
      for (int i = 0; i < cols ; i++) {
        for (int j = 0; j < rows ; j++) {
          // Where are we, pixel-wise?
          posPixelX = i *cellSizeX  ;
          posPixelY = j *cellSizeY  ;
          //// display pixel 
          int  loc = posPixelX +posPixelY *get_cam().width; // classic
          //  int loc = (cam.width - x - 1) + y*cam.width; // mirror
          //make pixel
          if(get_cam().pixels.length > 0) {

            PVector hsb = new PVector (hue(get_cam().pixels[loc]), saturation(get_cam().pixels[loc]), brightness(get_cam().pixels[loc]) ) ;
            // Make a new color with an alpha component
            displayPix(get_mode_id(),hsb) ; 
          }
        }
      } 
    } else {
      fill(get_fill()) ;
      textSize(get_size_x()/10) ;
      text("Big Brother stops watching you, you're so boring !",0,0) ;
    } 
    rectMode (CORNER) ;
  }
  
  
  
  
  
  
  //annexe

  
  
  void displayPix(int mode, PVector hsb) {
    //DISPLAY
    pushMatrix() ;
    //P3D Give the position and the orientation of your object in the 3 dimensionals space
    PVector newDisplay = new PVector  (cellSizeX *factorDisplayCam.x,   cellSizeY *factorDisplayCam.y) ;
    
    float newCellSizeX = cellSizeX *factorDisplayPixel.x *left[ID_item] ;
    float newCellSizeY = cellSizeY *factorDisplayPixel.y *right[ID_item] ;
    float factorSizeZ = map(get_size_z(), .1, width, .01, height/100) ;
    PVector newCellSize = new PVector (newCellSizeX, newCellSizeY, factorSizeZ ) ;
    //init the position of image on the middle of the screen
    vec3 posMouseCam = vec3( width / 2, height /2, 0) ;
    if (mouse[ID_item].x >= -item_setting_position[0][ID_item].x && mouse[ID_item].y >= -item_setting_position[0][ID_item].y) posMouseCam.set(mouse[ID_item]) ;
    //create the ratio for the translate position in functiun of the size of the Scene, not really good algorythm
    float ratioDisplay = (float)width / (float)height ;
    float factorDisplacementRatioSizeOfTheDisplay = map(width, 0, 2000, .6, .2 ) ;
    float factorTranslateX = factorDisplacementRatioSizeOfTheDisplay / ratioDisplay ;
    float factorTranslateY = factorDisplacementRatioSizeOfTheDisplay ;

    //finalization of the position
    float finalPosPixelX = ( (posPixelX +newDisplay.x *factorTranslateX) *factorDisplayCam.x) + posMouseCam.x - width *0.5 ;
    float finalPosPixelY = ( (posPixelY +newDisplay.y *factorTranslateY) *factorDisplayCam.y) + posMouseCam.y - height*0.5 ;
    PVector pos = new PVector (finalPosPixelX, finalPosPixelY, 0);
    //translate(finalPosPixelX, finalPosPixelY, finalPosPixelZ);
               
    rectMode(CENTER) ;
    
    if(mode == 0 ) rectangleColour(pos, newCellSize, hsb) ;
    if(mode == 1 ) rectangleMonochrome(pos, newCellSize, hsb) ;
    if(mode == 2 ) pointColour(pos, newCellSize, hsb) ;
    if(mode == 3 ) pointMonochrome(pos, newCellSize, hsb) ;
    if(mode == 4 ) boxColour(pos, newCellSize, hsb) ;
    if(mode == 5 ) boxMonochrome(pos, newCellSize, hsb) ;
    //
    popMatrix() ;
  }
  
  
  
  
  
  
  // different mode
  void rectangleMonochrome(PVector pos, PVector size, PVector hsb) {
    size = checkSize(size).copy() ;
    translate(pos.x, pos.y, pos.z);
    monochrome(hsb) ;
    fill(colorPixelCam) ;
    noStroke() ;
    antiBugFillBlack(colorPixelCam) ;
    rect (0,0, size.x, size.y) ;
  }
  //
  void rectangleColour(PVector pos, PVector size, PVector hsb) {
    size = checkSize(size).copy() ;
    translate(pos.x, pos.y, pos.z);
    colour(hsb) ;
    fill(colorPixelCam) ;
    noStroke() ;
    antiBugFillBlack(colorPixelCam) ;
    rect (0,0, size.x, size.y) ;
  }
  //
  void pointMonochrome(PVector pos, PVector size, PVector hsb) {
    size = checkSize(size).copy() ;
    translate(pos.x, pos.y, pos.z);
    monochrome(hsb) ;
    stroke(colorPixelCam) ;
    strokeWeight(size.x) ;
    antiBugFillBlack(colorPixelCam) ;
    point(0,0,0) ;
  }
  //
  void pointColour(PVector pos, PVector size, PVector hsb) {
    size = checkSize(size).copy() ;
    translate(pos.x, pos.y, pos.z);
    colour(hsb) ;
    stroke(colorPixelCam) ;
    strokeWeight(size.x) ;
    antiBugFillBlack(colorPixelCam) ;
    point(0,0,0)  ;
  }
  //
  void boxMonochrome(PVector pos, PVector size, PVector hsb) {
    float depth = (hsb.z +.05) *size.z ;
    if(horizon_is()) translate(pos.x, pos.y, depth *.5); else translate(pos.x, pos.y, pos.z);
    monochrome(hsb) ;
    fill(colorPixelCam) ;
    antiBugFillBlack(colorPixelCam) ;
    noStroke() ;
    box(size.x, size.y, depth) ;
  }
  //
  void boxColour(PVector pos, PVector size, PVector hsb) {
    float depth = (hsb.z +.05) *size.z ;
    if(horizon_is()) translate(pos.x, pos.y, depth *.5); else translate(pos.x, pos.y, pos.z);
    colour(hsb) ;
    fill(colorPixelCam) ;
    antiBugFillBlack(colorPixelCam) ;
    noStroke() ;
    box(size.x, size.y, depth) ;
  }

  void antiBugFillBlack(color c) {
    if (alpha(c) == 0 ) {
      noFill() ; 
      noStroke() ; 
    } else {     
      fill (c) ; 
    }
  }
    
    
  //Annexe
  
  // security size 
  PVector checkSize(PVector size) {
    float minSize = .5 ;
    if (size.x < minSize ) size.x = minSize ;
    if (size.y < minSize ) size.y = minSize ;
    if (size.z < minSize ) size.z = minSize ;
    return size ;
  }
  
  void colour(PVector hsb) {
    float newSat = hsb.y *map(saturation(get_fill()),0,100,0,1) ;
    float newBrigth = hsb.z *map(brightness(get_fill()),0,100,0,1) ;
    colorPixelCam = color(hsb.x, newSat, newBrigth, alpha(get_fill()));
  }
  
  void monochrome(PVector hsb) {
    float newHue = hue(get_fill()) ;
    float newSat = hsb.y *map(saturation(get_fill()),0,100,0,1) ;
    float newBrigth = hsb.z *map(brightness(get_fill()),0,100,0,1) ;
    //display the result
    colorPixelCam = color(newHue, newSat, newBrigth, alpha(get_fill()));
  }
}