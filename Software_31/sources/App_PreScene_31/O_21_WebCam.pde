/**
WEBCAM 
2011-2018
v 1.2.6
*/
class Webcam extends Romanesco {
  public Webcam() {
    //from the index_objects.csv
    RPE_name = "Webcam" ;
    ID_item = 21 ;
    ID_group = 1 ;
    RPE_author  = "Stan le Punk";
    RPE_version = "Version 1.2.5";
    RPE_pack = "Base" ;
    RPE_mode = "Rectangle color/Rectangle mono/Point color/Point mono/Box color/Box mono" ;
    RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Size X,Size Y,Size Z,Canvas X,Canvas Y" ;
  }
  //GLOBAL
  int cameraStatut = 0 ;

  Vec2 factorDisplayCam ;
  Vec3 factorDisplayPixel ;
  
  color colorPixelCam ;
  
  int cellSizeX, cellSizeY, posPixelX, posPixelY   ;
  int cols ;
  int rows ; 
  
  
  //SETUP
  void setup() {
    setting_start_position(ID_item, 0, 0, 0) ;
    factorDisplayCam = Vec2();
    factorDisplayPixel = Vec3();
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
    float size_x = map(size_x_item[ID_item],0.1,width, minVal, maxVal) *snare[ID_item] ;
    float size_y = map(size_y_item[ID_item],0.1,width, minVal, maxVal) *kick[ID_item] ;
    float size_z = map(size_z_item[ID_item],0.1,width, minVal, maxVal) *hat[ID_item] ;
    Vec3 factorSizePix = Vec3(size_x, size_y, size_z) ; 
    factorDisplayPixel.set(factorDisplayCam.x *factorSizePix.x,factorDisplayCam.y *factorSizePix.y, factorSizePix.z) ;//PARAMETER THAT YOU CAN USE
    
    //PART TWO

    if(FULL_RENDERING) {
      cellSizeX = int(map(canvas_y_item[ID_item],width/10, width, 50, 1))  ; 
      cellSizeY = int(map(canvas_x_item[ID_item],width/10, width, 50, 1))  ;
    } else {
      cellSizeX = int(map(canvas_y_item[ID_item],width/10, width, 50, 20))  ; 
      cellSizeY = int(map(canvas_x_item[ID_item],width/10, width, 50, 20))  ;
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
            displayPix(mode[ID_item],hsb) ; 
          }
        }
      } 
    } else {
      fill(fill_item[ID_item]) ;
      textSize(size_x_item[ID_item]/10) ;
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
    float factorSizeZ = map(size_z_item[ID_item], .1, width, .01, height/100) ;
    PVector newCellSize = new PVector (newCellSizeX, newCellSizeY, factorSizeZ ) ;
    //init the position of image on the middle of the screen
    Vec3 posMouseCam = Vec3( width / 2, height /2, 0) ;
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
    if(horizon[ID_item]) translate(pos.x, pos.y, depth *.5); else translate(pos.x, pos.y, pos.z);
    monochrome(hsb) ;
    fill(colorPixelCam) ;
    antiBugFillBlack(colorPixelCam) ;
    noStroke() ;
    box(size.x, size.y, depth) ;
  }
  //
  void boxColour(PVector pos, PVector size, PVector hsb) {
    float depth = (hsb.z +.05) *size.z ;
    if(horizon[ID_item]) translate(pos.x, pos.y, depth *.5); else translate(pos.x, pos.y, pos.z);
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
    float newSat = hsb.y *map(saturation(fill_item[ID_item]),0,100,0,1) ;
    float newBrigth = hsb.z *map(brightness(fill_item[ID_item]),0,100,0,1) ;
    colorPixelCam = color(hsb.x, newSat, newBrigth, alpha(fill_item[ID_item]));
  }
  
  void monochrome(PVector hsb) {
    float newHue = hue(fill_item[ID_item]) ;
    float newSat = hsb.y *map(saturation(fill_item[ID_item]),0,100,0,1) ;
    float newBrigth = hsb.z *map(brightness(fill_item[ID_item]),0,100,0,1) ;
    //display the result
    colorPixelCam = color(newHue, newSat, newBrigth, alpha(fill_item[ID_item]));
  }
}