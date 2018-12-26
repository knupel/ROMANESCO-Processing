class Slider {
  PVector posSlider, sizeSlider ;
  float spos, newspos;    // molette position
  float sposMin, sposMax;   // max and min values of slider
  int follow;              // follow the molette
  boolean inside;           // cursor in or out of the button
  boolean locked;
  color color_slider, color_sliderBorder ;
  int thickness_slider ;

  Slider (PVector posSlider_, PVector sizeSlider_, int follow_, color color_slider_, color color_sliderBorder_, int thickness_slider_)
  {
    sizeSlider = sizeSlider_ ;
    posSlider = posSlider_ ;
    // float widthtoheight = sizeSlider.x - sizeSlider.y;
    
    spos = posSlider.x + sizeSlider.x /2 - sizeSlider.y /2; // starting position of molette
    newspos = spos;
    sposMin = posSlider.x;
    sposMax = posSlider.x + sizeSlider.x - sizeSlider.y;
    
    follow = follow_;
    
    color_slider = color_slider_   ; color_sliderBorder = color_sliderBorder_ ; thickness_slider = thickness_slider ; 
    
  }
  //////////UPDATE/////////////////////
  void update() {
    if(detection()) {
      inside = true;
    } else {
      inside = false;
    }
    if(mousePressed && inside)    locked = true ;
    if(!mousePressed)             locked = false ;
    if(locked)                    newspos = constrain(mouseX -sizeSlider.y /2, sposMin, sposMax) ;
    if(abs(newspos - spos) > 1)   spos = spos + (newspos-spos)/follow ;
  }
  
  /////////SLIDER///////////////
  //CLASSIC
  void slider() {
    // draw slider
    strokeWeight(thickness_slider) ; stroke (color_sliderBorder) ;
    fill(color_slider);
    rect(posSlider.x, posSlider.y, sizeSlider.x, sizeSlider.y);
     
  }
  //SPECIAL
  void sliderColor() {
    // draw slider
    int px = round(posSlider.x) ;
    int py = round(posSlider.y) ;
    int sx = round(sizeSlider.x) ;
    int sy = round(sizeSlider.y) ;
    
    for ( int i = px ; i < px + sx ; i++ ) {
      for ( int j = py ; j < py + sy ; j++ ) {
        color c = color(i, 255, 255 ) ;
        set (i, j, c ) ;
      }
    }
  }
  
  //////////////////MOLETTE/////////////////
  void molette (PVector ratio, color moletteIN, color moletteOUT, color moletteBorderIN, color moletteBorderOUT, int moletteThickness, int typeOfMolette) { // button, stick... no word for that in english !!!!
    
    strokeWeight (moletteThickness ) ;
    if(inside || locked) {
      stroke(moletteBorderIN );
      fill(moletteIN);
    } else {
      stroke(moletteBorderOUT ) ;
      fill(moletteOUT);
    }
    
    //draw molette and choice of type of Molette
    float posMolY = posSlider.y -( sizeSlider.y * ( (ratio.y /2.0) -0.5 ) ) ;
    
    float sizeMolX = sizeSlider.y *ratio.x ;
    float sizeMolY = sizeSlider.y *ratio.y ;
    
    float lagX = sizeMolX - sizeSlider.y ;
    
    float posMolX = map(spos, sposMin, sposMax, sposMin, sposMax -lagX ) ;
    
    if ( typeOfMolette < 1 || typeOfMolette > 2 ) rect(posMolX, posMolY, sizeMolX, sizeMolY);
    
    if ( typeOfMolette == 1  ) rect(posMolX, posMolY, sizeMolX, sizeMolY);
    if ( typeOfMolette == 2  ) { 
      ellipseMode(CORNER) ;
      ellipse(posMolX, posMolY, sizeMolX, sizeMolY);
    }

  }
  
  ////////////RETURN
  boolean detection() { 
    if(mouseX > posSlider.x && mouseX < posSlider.x + sizeSlider.x && mouseY >  posSlider.y && mouseY < posSlider.y + sizeSlider.y) {
      return true;
    } else {
      return false;
    }
  }
  // return molette position on the slider
  float getPos() { 
    // to get the value
    return ( ( spos-posSlider.x) / (sizeSlider.x-posSlider.x) ) *255.0 ;
  }
  
}
