class Palette {
  PVector posP, sizeP, targetPos ;
  int density = 0 ;
  
  color newColor, currentColor, colorWrite ;
  boolean inside, locked, validate ;
  
  Palette (PVector posP_, PVector sizeP_) {
    posP = posP_ ; 
    sizeP = sizeP_ ;
    targetPos = new PVector ( sizeP.x /2.0 +posP.x, sizeP.y /2.0 +posP.y ) ;
    currentColor = color (125,125,125 ) ;
  }
  
  void display(float parameter) {
    int px = round(posP.x) ;
    int py = round(posP.y) ;
    int sx = round(sizeP.x) ;
    int sy = round(sizeP.y) ;
    for ( int i = 0 ; i < 256 ; i++ ) {
      for ( int j = 0 ; j < 256 ; j++ ) {
        //color c = color(parameter, i -px, j -py ) ;
        color c = color(parameter, i , j  ) ;
        set (i +px -1, j +py -1 , c ) ;

      }
    }
    //........
    pipette() ;
  }
  
  
  // Pipette
  void pipette() {
    checkPipette() ; // look if the pipette are in the area or not
    returnNewColor() ; // give the value of new color selected by pipette
    
    strokeWeight(1) ;
    colorWrite(newColor) ;
    stroke(colorWrite) ;
    fill (newColor) ;
    ellipseMode(CENTER) ;
    ellipse ( targetPos.x, targetPos.y, 40, 40 ) ;
  }
  
  void checkPipette() {
    if ( mouseX < sizeP.x + posP.x && mouseX > posP.x && mouseY < sizeP.y + posP.y && mouseY > posP.y    && mousePressed) {
          targetPos.x = mouseX ;
          targetPos.y = mouseY ;
    }
  }
  
  //board color
  // new color
  void newColor(PVector posNC, PVector sizeNC) {
    strokeWeight(1) ; stroke (185) ;
    fill (newColor) ;
    rect(posNC.x, posNC.y, sizeNC.x, sizeNC.y ) ;
    
    colorWrite(newColor) ;
    fill(colorWrite) ;
    String newHexColor = hex(newColor) ;
    println(newHexColor) ;
    text(newHexColor , posNC.x +5 , posNC.y +5 +(sizeNC.y /2.0) );
  }
  // current color
  void currentColor(PVector posCC, PVector sizeCC) {
    strokeWeight(1) ; stroke (185) ;
    fill (currentColor) ;
    rect(posCC.x, posCC.y, sizeCC.x, sizeCC.y ) ;
    
    colorWrite(currentColor) ;
    fill(colorWrite) ;
    String currentHexColor = hex(currentColor) ;
    println(currentHexColor) ;
    text( currentHexColor , posCC.x +5 , posCC.y +5 +(sizeCC.y /2.0) );
  }
  
  /////////////////////////////////
  //button
  void buttonValidate (PVector posB, PVector sizeB, color buttonIN, color buttonOUT, color buttonBorderIN, color buttonBorderOUT, int buttonThickness, int typeOfButton, String title, color colorTitle)
  {
    if ( mouseX < sizeB.x + posB.x && mouseX > posB.x && mouseY < sizeB.y + posB.y && mouseY > posB.y) {
      inside = true ;
      fill(buttonIN) ;
    } else {
      inside = false ;
      fill (buttonOUT) ;
    }
    if(mousePressed && inside)    locked = true ;
    if(!mousePressed)             locked = false ;
    
    if(locked) currentColor = newColor ;
    
    if ( typeOfButton < 1 || typeOfButton > 2 ) rect(posB.x, posB.y, sizeB.x, sizeB.y ) ;
    
    if ( typeOfButton == 1  ) rect(posB.x, posB.y, sizeB.x, sizeB.y ) ;
    if ( typeOfButton == 2  ) { 
      ellipseMode(CORNER) ;
      ellipse(posB.x, posB.y, sizeB.x, sizeB.y);
    }
    fill(colorTitle) ;
    text (title, posB.x +5, posB.y +5 +(sizeB.y /2.0) ) ;
  }
  
  ///RETURN/////////////
  color colorWrite(color colorRef) {
    if( brightness( colorRef ) < 170 ) {
      colorWrite = color(185) ;
    } else {
      colorWrite = color(10) ;
    }
    return colorWrite ;
  }
  /////////
  color returnNewColor() {
    newColor = get(round(targetPos.x), round(targetPos.y) ) ;
    return newColor ;
  }  
}


