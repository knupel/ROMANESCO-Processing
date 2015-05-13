

// VARIABLES PRESCENE
/////////////////////
boolean scene = false ;
boolean prescene = true ;

//to opening app
boolean openScene = true ;
boolean openMiroir = true ;
boolean openControleur = true ;
//send to the other sketches
boolean youCanSendToScene = true ;
boolean youCanSendToMiroir = true ;

// Web cam activity
// boolean cameraOnOff = false ;

// internet connection
boolean internet = true ;
String bigBrother = ("BIG BROTHER DON'T WATCHING YOU !!") ;




// CURSOR SPEED
int speedWheel = 5 ;
float speedLeapmotion = .15 ; // between 0.000001 and 1 : can be good between 0.1 and 0.4

// END VARIABLE
///////////////




// METHOD
/////////

import codeanticode.tablet.*;
Tablet tablet;
void presceneSetup() {
  leap = new com.leapmotion.leap.Controller();
  tablet = new Tablet(this);
  displayInfo3D = true ;
}


//OPENING the other window
void opening() {
    //OPEN CONTROLEUR and SCENE or MIROIR
  if (!testRomanesco && openControleur) {
    fill(blanc) ;
    stroke(blanc) ;
    textSize(28 ) ;
    text("Take your time, smoke a cigarette", 50,height/2 ) ;
  }
  if (!testRomanesco) { 
    if (openControleur) { open(sketchPath("")+"Controleur_"+version+".app") ; openControleur = false ; } 
    if (openScene)      { open(sketchPath("")+"Scene_"+version+".app") ; openScene = false ; }
    // testRomanesco = true ;
  }
}


//INIT in real time and re-init the default setting of the display window


void initDraw() {
  //Default display shape and text
  rectMode (CORNER) ; 
  textAlign(LEFT) ;
  //SCENE ATTRIBUT
  //  if (fullScreen ) sketchPos(0,0, myScreenToDisplayMySketch) ; 
  
  //change the size of displaying if you load an image or a new image
  if (displaySizeByImage ) updateSizeDisplay(imgDefault) ;
  

}









///////////////////////
//CURSOR, MOUSE, TABLET
//GLOBAL



void updateCommand() {
  // move the object
  if(clickLongLeft[0] || finger.activefingers == 1 ) {
    ORDER_ONE = true ; 
    ORDER_TWO = false ;
    ORDER_THREE = false ;
  }
  // rotate the object
  else if(clickLongRight[0] || finger.activefingers == 2) {
    ORDER_ONE = false ; 
    ORDER_TWO = true ;
    ORDER_THREE = false ;
  }
  // move and rotate
  else if(finger.activefingers == 3) {
    ORDER_ONE = false ; 
    ORDER_TWO = false ;
    ORDER_THREE = true ;
  }

  if(!clickLongLeft[0] && !clickLongRight[0] && finger.activefingers != 2 && finger.activefingers != 1 && finger.activefingers != 3)  {
  // false
    ORDER_ONE = false ;
    ORDER_TWO = false ;
    ORDER_THREE = false ;
  }
}




PVector posRef = new PVector() ;
int mouseZ ;


void cursorDraw() {
  updateLeapCommand() ;
  updateMouseZ() ;
  
  //mousePressed
  if(ORDER_ONE || ORDER_TWO || ORDER_THREE) ORDER = true ; else ORDER = false ;
  
  //check the tablet
  pen[0] = new PVector (norm(tablet.getTiltX(),0,1), norm(tablet.getTiltY(),0,1), tablet.getPressure()) ;
  
  // Leap and mouse move
  if (orderOneLeap || orderTwoLeap) {
    mouse[0] = new PVector(averageTranslatePosition(speedLeapmotion).x, -averageTranslatePosition(speedLeapmotion).y,averageTranslatePosition(speedLeapmotion).z)  ;
  } else if(posRef.x != mouseX || posRef.y != mouseY) {
    mouse[0] = new PVector(mouseX,mouseY) ;
    pmouse[0] = new PVector(pmouseX,pmouseY) ;
    posRef = mouse[0].copy() ;
  }
  

  
  // security to reset the pmouse for start clean for the next rotation
  if(!ORDER) {
    if(pmouse[0].x != mouse[0].x || pmouse[0].y != mouse[0].y ) {
      pmouse[0] = gotoTarget(pmouse[0],  mouse[0], .1) ;
    }
  } 

  //re-init the wheel value to be sure this one is stopped
  wheel[0] = 0 ;
  //re-init the mouse button for the short click
  clickShortLeft[0] = false ; 
  clickShortRight[0] = false ;
  
  //why this line is here ????
  if (nextPrevious) nextPreviousInt = 1 ; else nextPreviousInt = 0 ;
}


// ANNEXE VOID
void updateMouseZ() {
  mouseZ -= wheel[0] ;
}


// END CURSOR DRAW
//////////////////









////////////////////////////////////////////////////////////
//MISC // MISC // MISC // MISC //


//file name for save
String nameNumber(String name) {
  String numPict ;
  int year = year() -2000 ;
  String newYear = String.valueOf(year) ;
  String newMonth = String.valueOf(month()) ;
  String newDay = String.valueOf(day()) ;
  
  String newSecond = String.valueOf((hour() *60 *60) + (minute() *60 ) + second()) ;
  numPict = (name + newYear + "_" + newMonth + "_" + newDay + "_" +newSecond) ;
  
  return numPict ;
}



















      
        
        
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
  if (key == 'l'  || key == 'L' ) { lTouch = true ; lLongTouch = true ; }
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
  if (key == 'l'  || key == 'L' ) lLongTouch = false ;
  if (key == 'n'  || key == 'N' ) nLongTouch = false ;
  if (key == 'v'  || key == 'V' ) vLongTouch = false ;
}


void keyboardFalse() {
  // check for the key and put false here, but it's less reactive that put false just after the use the boolean...here you display false three time !
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
//////////////
