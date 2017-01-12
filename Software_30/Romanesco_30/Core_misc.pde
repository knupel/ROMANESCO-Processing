/**
SIZE WINDOW
*/
void sizeWindow() {
  //setting the Scene size
  sliderHeight.sliderUpdate() ;
  sliderWidth.sliderUpdate() ;
  
  heightSlider = int(map(sliderHeight.getValue(),0,1,1,standardSizeHeight.length))  ;
  widthSlider = int(map(sliderWidth.getValue(),0,1,1,standardSizeWidth.length))  ;
  String h = Integer.toString(standardSizeHeight[heightSlider -1]) ;
  String w = Integer.toString(standardSizeWidth[widthSlider-1]) ;
  //check the width
  int correctionPosY = -14 ;
  if ( widthSlider <= 1 ) {
    fill(rougeFonce) ;
    text("Width " + w, posSliderWidth.x, posSliderWidth.y +correctionPosY);
  } else {
    fill(vertFonce) ;
    text("Width " + w, posSliderWidth.x, posSliderWidth.y +correctionPosY);
  }
  //check the height
  if ( heightSlider <= 1 ) {
    fill(rougeFonce) ;
    text("Heigth " + h, posSliderHeight.x, posSliderHeight.y +correctionPosY);
  } else {
    fill(vertFonce) ;
    text("Heigth " + h, posSliderHeight.x, posSliderHeight.y +correctionPosY);
  }
}










/**
SCREEN
*/
int screenNum  ;
//SETUP 
void whichScreenSetup(int n , PVector infoPos) {
  //quantity of button choice
  screenNum = n ;
  whichScreenButton = new Button [screenNum] ;
  //position of the button  
  int x = (int)infoPos.x ;
  int y = (int)infoPos.y ;
  int space = (int)infoPos.z ;
  
  for ( int i = 0 ; i <  screenNum ; i++) {
    Vec2 pos = Vec2( x +( i *space), y ) ;
    Vec2 size = Vec2(20,20) ;
    String title = Integer.toString(i+1) ;
    whichScreenButton[i] = new Button(pos, size, c1, c2, c3, c4, title) ;
  }
}



void choice_screen_for_fullscreen() {
/**
    With Processing 3.0b7 we cannot use this method to choose on which screen display the full screen
    On which screen display the window
    fill(orange) ;
    text("on screen", 10.0, 120.0);
    whichScreenDraw() ;
    */
    /**
    // Instead to use fullscreen method choice, we say is always true
    */
    buttonWhichScreenOnOff = 1 ;
}


void whichScreenDraw() {
  for(int i = 0 ; i <screenNum ; i++) {
    whichScreenButton[i].displayButton() ;
  }
}

//MOUSEPRESSED
void whichScreenPressed() {
  for(int i =0 ; i< screenNum ; i++ ) {
    if (whichScreenButton[i].inside ) {
      for( int j =0 ; j < screenNum ; j++ ) whichScreenButton[j].OnOff = false ;
    }
  }
}

//MOUSERELEASED
int buttonWhichScreenOnOff ;

void whichScreenReleased() {
  buttonWhichScreenOnOff = 0 ;
  for(int i = 0 ; i<screenNum ; i++ ) {
    whichScreenButton[i].mouseClic() ;
    if(whichScreenButton[i].OnOff) buttonWhichScreenOnOff += 1 ;
  }
}

//ID screen
int IDscreen = 0 ;
int IDscreenSelected() {
  for (int i = 0 ; i < screenNum ; i++ ) { 
    if (whichScreenButton[i].OnOff == true ) IDscreen = i+1 ; else IDscreen = 1 ;
  }
  return IDscreen ;
}
