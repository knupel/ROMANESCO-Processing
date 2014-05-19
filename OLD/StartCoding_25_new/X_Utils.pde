////////////////////////////////////
//CURSOR, MOUSE, TABLET, LEAP MOTION
//GLOBAL
Tablet tablet;

//SETUP
void cursorSetup() {
  tablet = new Tablet(this);
  //mouse
  for (int i = 0 ; i < numObj ; i++ ) {
    pen[i] = new PVector(0,0,0) ;
    mouse[i] = new PVector(0,0) ;
    pmouse[i] = new PVector(0,0) ;
    wheel[i] = 0 ;
  }
}


//DRAW
void cursorDraw() {
  pen[0] = new PVector (norm(tablet.getTiltX(),0,1), norm(tablet.getTiltY(),0,1), tablet.getPressure()) ;
  mouse[0] = new PVector(mouseX, mouseY ) ;
  pmouse[0] = new PVector(pmouseX, pmouseY ) ;
  wheel[0] = 0 ;
  // if( clickShortLeft[0] || clickShortRight[0] || clickLongLeft[0] || clickLongRight[0] ) mousepressed[0] = true ; else mousepressed[0] = false ;
  //re-init the mouse button for the short click
  clickShortLeft[0] = false ; 
  clickShortRight[0] = false ;
}
////////////////////////////////////////
//END CURSOR, MOUSE, TABLET, LEAP MOTION





//////////
//KEYBOARD

//short Touch
boolean aTouch, bTouch, cTouch, dTouch, eTouch, fTouch, gTouch, hTouch, iTouch, jTouch, kTouch, lTouch, mTouch, nTouch, oTouch, pTouch, qTouch, rTouch, sTouch, tTouch, uTouch, vTouch, wTouch, xTouch, yTouch, zTouch,
        leftTouch, rightTouch, upTouch, downTouch, 
        touch0, touch1, touch2, touch3, touch4, touch5, touch6, touch7, touch8, touch9, 
        backspaceTouch, deleteTouch, enterTouch, returnTouch, shiftTouch, altTouch, escTouch, ctrlTouch ;
//long touch
boolean spaceTouch, cLongTouch, nLongTouch, vLongTouch ;
        
        
void keyboardTrue() {
  if (key == ' ' ) spaceTouch = true ; 
  
  if (key == 'a'  || key == 'A' ) aTouch = true ;
  if (key == 'b'  || key == 'B' ) bTouch = true ;
  if (key == 'c'  || key == 'C' ) { cTouch = true ; cLongTouch = true ; }
  if (key == 'd'  || key == 'D' ) dTouch = true ;
  if (key == 'e'  || key == 'E' ) eTouch = true ;
  if (key == 'f'  || key == 'F' ) fTouch = true ;
  if (key == 'g'  || key == 'G' ) gTouch = true ;
  if (key == 'h'  || key == 'H' ) hTouch = true ;
  if (key == 'i'  || key == 'I' ) iTouch = true ;
  if (key == 'j'  || key == 'J' ) jTouch = true ;
  if (key == 'k'  || key == 'K' ) kTouch = true ;
  if (key == 'l'  || key == 'L' ) lTouch = true ;
  if (key == 'm'  || key == 'M' ) mTouch = true ;
  if (key == 'n'  || key == 'N' ) { nTouch = true ; nLongTouch = true ; }
  if (key == 'o'  || key == 'O' ) oTouch = true ;
  if (key == 'p'  || key == 'P' ) pTouch = true ;
  if (key == 'q'  || key == 'Q' ) qTouch = true ;
  if (key == 'r'  || key == 'R' ) rTouch = true ;
  if (key == 's'  || key == 'S' ) sTouch = true ;
  if (key == 't'  || key == 'T' ) tTouch = true ;
  if (key == 'u'  || key == 'U' ) uTouch = true ;
  if (key == 'v'  || key == 'V' ) { vTouch = true ; vLongTouch = true ; }
  if (key == 'w'  || key == 'W' ) wTouch = true ;
  if (key == 'x'  || key == 'X' ) xTouch = true ;
  if (key == 'y'  || key == 'Y' ) yTouch = true ;
  if (key == 'z'  || key == 'Z' ) zTouch = true ;
  
  if (key == '0' ) touch0 = true ;
  if (key == '1' ) touch1 = true ;
  if (key == '2' ) touch2 = true ;
  if (key == '3' ) touch3 = true ;
  if (key == '4' ) touch4 = true ;
  if (key == '5' ) touch5 = true ;
  if (key == '6' ) touch6 = true ;
  if (key == '7' ) touch7 = true ;
  if (key == '8' ) touch8 = true ;
  if (key == '9' ) touch9 = true ;
  
  if( keyCode == BACKSPACE ) backspaceTouch = true ;
  if (keyCode == DELETE ) deleteTouch = true ;
  if( keyCode == SHIFT ) shiftTouch = true ;
  if( keyCode == ALT ) altTouch = true ;
  if( keyCode == RETURN ) returnTouch = true ;
  if( keyCode == ENTER ) enterTouch = true ;
  if( keyCode == CONTROL ) ctrlTouch = true ;
  
  if( keyCode == LEFT ) leftTouch = true ;
  if( keyCode == RIGHT ) rightTouch = true ;
  if( keyCode == UP ) upTouch = true ;
  if( keyCode == DOWN ) downTouch = true ;
}

void keyboardLongFalse() {
  if (key == ' ' ) spaceTouch = false ; 
  if (key == 'c'  || key == 'C' ) cLongTouch = false ;
  if (key == 'n'  || key == 'N' ) nLongTouch = false ;
  if (key == 'v'  || key == 'V' ) vLongTouch = false ;
}

void keyboardFalse() {
    // check for the key and put false here, but it's less reactive that put false just after the use the boolean...here you display false three time !
  //spaceTouch = false ; 
  
  if(aTouch) aTouch = false ; 
  if(bTouch) bTouch = false ;
  if(cTouch) cTouch = false ;
  if(dTouch) dTouch = false ;
  if(eTouch) eTouch = false ;
  if(fTouch) fTouch = false ;
  if(gTouch) gTouch = false ;
  if(hTouch) hTouch = false ;
  if(iTouch) iTouch = false ;
  if(jTouch) jTouch = false ;
  if(kTouch) kTouch = false ;
  if(lTouch) lTouch = false ;
  if(mTouch) mTouch = false ;
  if(nTouch) nTouch = false ;
  if(oTouch) oTouch = false ;
  if(pTouch) pTouch = false ;
  if(qTouch) qTouch = false ;
  if(rTouch) rTouch = false ;
  if(sTouch) sTouch = false ;
  if(tTouch) tTouch = false ;
  if(uTouch) uTouch = false ;
  if(vTouch) vTouch = false ;
  if(wTouch) wTouch = false ;
  if(xTouch) xTouch = false ;
  if(yTouch) yTouch = false ;
  if(zTouch) zTouch = false ;
  
  if(touch0) touch0 = false ;
  if(touch1) touch1 = false ;
  if(touch2) touch2 = false ;
  if(touch3) touch3 = false ;
  if(touch4) touch4 = false ;
  if(touch5) touch5 = false ;
  if(touch6) touch6 = false ;
  if(touch7) touch7 = false ;
  if(touch8) touch8 = false ;
  if(touch9) touch9 = false ;
  
  if (backspaceTouch) backspaceTouch = false ;
  if (deleteTouch) deleteTouch = false ; 
  if (enterTouch) enterTouch = false ;
  if (returnTouch) returnTouch = false ;
  if (shiftTouch) shiftTouch = false ;
  if (altTouch) altTouch = false ; 
  if (escTouch) escTouch = false ;
  if (ctrlTouch) ctrlTouch = false ;
  
  if(upTouch ) upTouch = false ;
  if(downTouch) downTouch = false ;
  if (leftTouch) leftTouch = false ;
  if (rightTouch ) rightTouch = false ;

}
//END KEYBOARD












///////////////////////////////////////////
//TRANSLATOR INT to String, FLOAT to STRING
String joinIntToString(int []data) {
  String intString ;
  String [] dataString = new String [data.length] ;
  for ( int i = 0 ; i < data.length ; i++) dataString[i] = Integer.toString(data[i]) ;
  intString = join(dataString,"/") ;
  
  return intString ;
}

String joinFloatToString(float []data) {
  String floatString ;
  String [] dataString = new String [data.length] ;
  //for ( int i = 0 ; i < data.length ; i++) dataString[i] = Float.toString(data[i]) ;
  //we must use just one decimal after coma, to dodge the outBoundIndex blablabla
  for ( int i = 0 ; i < data.length ; i++) dataString[i] = String.format("%.1f" ,data[i]) ;
  floatString = join(dataString,"/") ;
  
  return floatString ;
}

//Translater to String
String FloatToString(float data) {
  String newData ;
  newData = String.format("%.1f", data ) ;
  return newData ;
}
//
String FloatToStringWithThree(float data) {
  String newData ;
  newData = String.format("%.3f", data ) ;
  return newData ;
}
//
String IntToString(int data) {
  String newData ;
  newData = Integer.toString(data ) ;
  return newData ;
}
//END TRANSLATOR



//////////////
//FONT
PFont SansSerif10,

      AmericanTypewriter, AmericanTypewriterBold,
      Banco, 
      ContainerRegular, Cinquenta,
      Diesel,
      Digital, 
      DinRegular10 ,DinRegular, DinBold,
      EastBloc,
      FetteFraktur, FuturaStencil,
      GangBangCrime,
      Juanita, JuanitaOutline,
      Komikahuna,
      Mesquite,
      Minion, MinionBold,
      NanumBrush, 
      Rosewood,
      TheHardwayRMX,
      TokyoOne, TokyoOneSolid ;
      
String pathFont [] = new String [50] ;  
      
//SETUP
void fontSetup() {
  String fontPath = sketchPath("")+"commonsData/typoVLW/" ;
  //write font path
  pathFont[1] = (fontPath+"AmericanTypewriter-96.vlw");
  pathFont[2] = (fontPath+"AmericanTypewriter-Bold-96.vlw");
  pathFont[3] = (fontPath+"BancoITCStd-Heavy-96.vlw");
  pathFont[4] = (fontPath+"CinquentaMilMeticais-96.vlw");
  pathFont[5] = (fontPath+"Container-Regular-96.vlw");
  pathFont[6] = (fontPath+"Diesel-96.vlw");
  pathFont[7] = (fontPath+"Digital2-96.vlw");
  pathFont[8] = (fontPath+"DIN-Regular-96.vlw");
  pathFont[9] = (fontPath+"DIN-Bold-96.vlw");
  pathFont[10] = (fontPath+"EastBlocICGClosed-96.vlw");
  pathFont[11] = (fontPath+"FuturaStencilICG-96.vlw");
  pathFont[12] = (fontPath+"FetteFraktur-96.vlw");
  pathFont[13] = (fontPath+"GANGBANGCRIME-96.vlw");
  pathFont[14] = (fontPath+"JuanitaDecoITCStd-96.vlw");
  pathFont[15] = (fontPath+"Komikahuna-96.vlw");
  pathFont[16] = (fontPath+"MesquiteStd-96.vlw");
  pathFont[17] = (fontPath+"NanumBrush-96.vlw");
  pathFont[18] = (fontPath+"RosewoodStd-Regular-96.vlw");
  pathFont[19] = (fontPath+"3theHardwayRMX-96.vlw");
  pathFont[20] = (fontPath+"Tokyo-One-96.vlw");
  pathFont[21] = (fontPath+"MinionPro-Regular-96.vlw");
  pathFont[22] = (fontPath+"MinionPro-Bold-96.vlw");
  //special font
  pathFont[49] = (fontPath+"DIN-Regular-10.vlw");
  SansSerif10 = loadFont(fontPath+"SansSerif-10.vlw") ;
  
  //load
  AmericanTypewriter=loadFont      (pathFont[1]);
  AmericanTypewriterBold=loadFont  (pathFont[2]);
  Banco=loadFont                   (pathFont[3]);
  Cinquenta=loadFont               (pathFont[4]);
  ContainerRegular=loadFont        (pathFont[5]);
  Diesel=loadFont                  (pathFont[6]);
  Digital=loadFont                 (pathFont[7]);
  DinRegular=loadFont              (pathFont[8]);
  DinBold=loadFont                 (pathFont[9]);
  EastBloc=loadFont                (pathFont[10]);
  FuturaStencil=loadFont           (pathFont[11]);
  FetteFraktur=loadFont            (pathFont[12]);
  GangBangCrime=loadFont           (pathFont[13]);
  JuanitaOutline=loadFont          (pathFont[14]);
  Komikahuna=loadFont              (pathFont[15]);
  Mesquite=loadFont                (pathFont[16]);
  NanumBrush=loadFont              (pathFont[17]);
  Rosewood=loadFont                (pathFont[18]);
  TheHardwayRMX=loadFont           (pathFont[19]);
  TokyoOne=loadFont                (pathFont[20]);
  Minion=loadFont                  (pathFont[21]);
  MinionBold=loadFont              (pathFont[22]);
  
  //default and special font
  DinRegular10=loadFont            (pathFont[49]);
  font[0] = AmericanTypewriter ;
  
}




void whichFont (int whichFont) { 
  if (whichFont == 1 )     font[0] = AmericanTypewriter ; 
  else if (whichFont ==2 ) font[0] = AmericanTypewriterBold ;
  else if (whichFont == 3) font[0] = Banco ;
  else if (whichFont ==4)  font[0] = Cinquenta ;
  else if (whichFont ==5)  font[0] = ContainerRegular ;
  else if (whichFont ==6)  font[0] = Diesel ;
  else if (whichFont ==7)  font[0] = Digital ;
  else if (whichFont ==8)  font[0] = DinRegular ;
  else if (whichFont ==9)  font[0] = DinBold ;
  else if (whichFont ==10)  font[0] = EastBloc ;
  else if (whichFont ==11) font[0] = FetteFraktur ;
  else if (whichFont ==12) font[0] = FuturaStencil ;
  else if (whichFont ==13) font[0] = GangBangCrime ;
  else if (whichFont ==14) font[0] = JuanitaOutline ;    
  else if (whichFont ==15) font[0] = Komikahuna ;
  else if (whichFont ==16) font[0] = Mesquite ;
  else if (whichFont ==17) font[0] = Minion ;
  else if (whichFont ==18) font[0] = MinionBold ;
  else if (whichFont ==19) font[0] = NanumBrush ;
  else if (whichFont ==20) font[0] = Rosewood ;
  else if (whichFont ==21) font[0] = TheHardwayRMX ;
  else if (whichFont ==22) font[0] = TokyoOne ; 
  else font[0] = AmericanTypewriter ;
}
//END FONT
//////////




//BACKGROUND
////////////
void backgroundClassic() {
  color fond = color (map(valueSlider[0][0],0,100,0,360), valueSlider[0][1], valueSlider[0][2], valueSlider[0][3] ) ; 
  //DISPLAY FINAL
  noStroke() ;
  fill(fond ) ;
  rect (0,0, width, height) ;
}

//P3D
//BACKGROUND
////////////
void backgroundP3D() {
  color fond = color (map(valueSlider[0][0],0,100,0,360), valueSlider[0][1], valueSlider[0][2], valueSlider[0][3] ) ; 
  fill(fond) ;
  noStroke() ;
  pushMatrix() ;
  final PVector sizeBG = new PVector(width *100, height *100) ;
  translate(-sizeBG.x *.5,-sizeBG.y *.5 , -3100) ;
  rect(0,0, sizeBG.x,sizeBG.y) ;
  popMatrix() ;
}

//END BACKGROUND

//ZOOM
//with the wheel mouse
float getCountZoom ;

void zoom() {
  getCountZoom = wheel[0] ;
}
//END ZOOM

//END P3D
