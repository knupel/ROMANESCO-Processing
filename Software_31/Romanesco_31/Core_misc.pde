/**
SIZE WINDOW
actually there is bug with Processing for the resize window in P3D, so we need to
create few apps dedicated and launch... that's growth the size of the zip file...
C'est la vie...
We mut use the boolean to indicate to the launcher, the problem after that it's possible to choice which app must be launch
*/
// boolean resize_bug = true ;

void size_window() {
  int correctionPosY = -14 ;
  // size_window_width(standard_format_for_Processing_bug, correctionPosY) ;
  /**
  This lines bellow must use when the bug will be fix !!!!
  */
  size_window_width(standard_size_width, correctionPosY) ;
  size_window_height(standard_size_height, correctionPosY) ;
}

void size_window_width(int [] format_width, int pos_y) {
  sliderWidth.sliderUpdate() ;
  widthSlider = int(map(sliderWidth.getValue(),0,1,1,format_width.length))  ;
  String w = Integer.toString(format_width[widthSlider-1]) ;
  if (widthSlider <= 1 ) {
    fill(rougeFonce) ;
    text("Width " + w, posSliderWidth.x, posSliderWidth.y +pos_y);
  } else {
    fill(vertFonce) ;
    text("Width " + w, posSliderWidth.x, posSliderWidth.y +pos_y);
  }
}

void size_window_height(int[] format_height, int pos_y) {
  sliderHeight.sliderUpdate() ;
  heightSlider = int(map(sliderHeight.getValue(),0,1,1,format_height.length))  ;
  String h = Integer.toString(format_height[heightSlider -1]) ;
  if (heightSlider <= 1 ) {
    fill(rougeFonce) ;
    text("Heigth " + h, posSliderHeight.x, posSliderHeight.y +pos_y);
  } else {
    fill(vertFonce) ;
    text("Heigth " + h, posSliderHeight.x, posSliderHeight.y +pos_y);
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
