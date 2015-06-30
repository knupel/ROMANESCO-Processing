import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import codeanticode.tablet.*; 
import java.awt.event.KeyEvent; 
import com.leapmotion.leap.*; 
import java.net.*; 
import java.io.*; 
import java.util.*; 
import java.awt.*; 
import java.util.Iterator; 
import java.lang.reflect.*; 
import codeanticode.gsvideo.*; 
import oscP5.*; 
import netP5.*; 
import processing.net.*; 
import processing.pdf.*; 
import com.sun.syndication.feed.synd.*; 
import com.sun.syndication.io.*; 
import ddf.minim.*; 
import ddf.minim.analysis.*; 
import geomerative.*; 
import toxi.geom.*; 
import toxi.geom.mesh2d.*; 
import toxi.util.*; 
import toxi.util.datatypes.*; 
import toxi.processing.*; 
import com.onformative.yahooweather.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class PreScene_27 extends PApplet {


  //////////////////////////////////////////////////////////////////
 // Romanesco Unu 1.0.2 / version 27 / made with Processing 305 ///
//////////////////////////////////////////////////////////////////
/* 14.500 lines of code the 4th may 2015 !!!! */
String version = ("27") ;
String IAM = ("Prescene") ;
String prettyVersion = ("1.0.2") ;
String nameVersion = ("Romanesco Unu") ;
String preferencesPath = sketchPath("")+"preferences/" ;
//to work in dev, test phase
boolean testRomanesco = false ;
boolean fullRendering = true ;

  
public void setup() {
  if(fullRendering) frameRateRomanesco = 60 ; else frameRateRomanesco = 15 ;
  displaySetup(frameRateRomanesco) ; // the int value is the frameRate
  RG.init(this);  // Geomerative
  // common setup
  romanescoSetup() ;
  createVar() ;
  //specific setup
  presceneSetup() ; // the varObject setup of the Scene is more simple
  leapMotionSetup() ;
  OSCSetup() ;
  //common setup
  colorSetup() ;
  varObjSetup() ;
  fontSetup() ;
  // here we ask for the testRomanesco true, because the Minim Library talk too much in the consol
  if(fullRendering && !testRomanesco) soundSetup() ;
  P3DSetup(modeP3D, numObj, numSettingCamera, numSettingOrientationObject) ;
}



//DRAW
public void draw() {
  frame.setTitle(nameVersion + " " +prettyVersion+"."+version+ " | Pr\u00e9sc\u00e8ne | FPS: "+round(frameRate));
  //setting
  initDraw() ;
  // here we ask for the testRomanesco true, because the Minim Library talk too much in the consol
  if(fullRendering && !testRomanesco) soundDraw() ;
  updateVarRaw() ;
  OSCDraw() ;
  backgroundRomanesco() ;
  updateCommand() ;
  leapMotionUpdate() ;
  loadPrescene() ;
  
  //ROMANESCO
  cameraDraw() ;
  lightPosition() ;
  //use romanesco object
  romanescoManager.displayObject(ORDER_ONE, ORDER_TWO, ORDER_THREE) ;
  if(modeP3D) createGridCamera() ;
  stopCamera() ;
  
  //annexe
  info() ;
  if(fullRendering && !testRomanesco) curtain() ;
  
  // misc
  updateVarTemp() ;
  cursorDraw() ;

  // change to false if the information has be sent to Scene...but how ????
  keyboardFalse() ;
  
  opening() ;
}
//END DRAW









// MOUSE EVENT 
////////////////////

// MOUSEPRESSED
public void mousePressed() {
  if(mouseButton == LEFT ) { 
    clickShortLeft[0] = true ; 
    clickLongLeft[0] = true ;
  }
  if (mouseButton == RIGHT ) {
    clickShortRight[0] = true ; 
    clickLongRight[0] = true ;
  }
}

//MOUSE RELEASED
public void mouseReleased() {
  clickLongLeft[0] = false ; 
  clickLongRight[0] = false ;
}

// Mouse in or out of the sketch
public void mouseEntered(MouseEvent e) {
  MOUSE_IN_OUT = true ;
}

public void mouseExited(MouseEvent e) {
  MOUSE_IN_OUT = false ;
}



//MOUSE WHEEL
public void mouseWheel(MouseEvent event) {
  wheel[0] = event.getCount() *speedWheel ; 
}
//END MOUSEWHEEL


/////KEY/////
//KEYPRESSED
public void keyPressed () {
  shortCutsPrescene() ;
  nextPreviousKeypressed() ;
  keyboardTrue() ;

}
//END KEYPRESSED


//KEYRELEASED
public void keyReleased() {
  //special touch need to be long
  keyboardLongFalse() ;
  keyboard[keyCode] = false ;
}
//END KEYRELEASED
/**
Here you find
> variable Prescene
> update command for the mouse, cursor...
> tablet
> open method for the scene and controller
> keyboard command
*/

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
float speedLeapmotion = .15f ; // between 0.000001 and 1 : can be good between 0.1 and 0.4

// END VARIABLE
///////////////




// METHOD
/////////


Tablet tablet;
public void presceneSetup() {
  leap = new com.leapmotion.leap.Controller();
  tablet = new Tablet(this);
  if(fullRendering) displayInfo3D = false ; else displayInfo3D = true ;
}


//OPENING the other window
int count_to_open_controller = 0 ;
int time_int_second_to_open_controller = 12  ; // the scene run at 15 frame / second.
public void opening() {
    //OPEN CONTROLEUR and SCENE or MIROIR
  if (!testRomanesco && openControleur) {
    fill(blanc) ;
    stroke(blanc) ;
    textSize(60) ;
    text("Take your time, smoke a cigarette", width/2,height/2 ) ;
  }
  if (!testRomanesco) { 
    if (openScene)      { 
      open(sketchPath("")+"Scene_"+version+".app") ; 
      openScene = false ; 
    } else {
      count_to_open_controller += 1 ;
    }
    if (openControleur && count_to_open_controller > (time_int_second_to_open_controller *frameRateRomanesco) ) { 
      open(sketchPath("")+"Controleur_"+version+".app") ; 
      openControleur = false ; 
    } 
    // testRomanesco = true ;
  }
}


//INIT in real time and re-init the default setting of the display window


public void initDraw() {
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



public void updateCommand() {
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


public void cursorDraw() {
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
    posRef = mouse[0].copy() ;
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
public void updateMouseZ() {
  mouseZ -= wheel[0] ;
}


// END CURSOR DRAW
//////////////////









////////////////////////////////////////////////////////////
//MISC // MISC // MISC // MISC //

//file name for save
/**
May be not used
*/
public String nameNumber(String name) {
  String numPict ;
  int year = year() -2000 ;
  String newYear = String.valueOf(year) ;
  String newMonth = String.valueOf(month()) ;
  String newDay = String.valueOf(day()) ;
  
  String newSecond = String.valueOf((hour() *60 *60) + (minute() *60 ) + second()) ;
  numPict = (name + newYear + "_" + newMonth + "_" + newDay + "_" +newSecond) ;
  
  return numPict ;
}









// KEYBOARD & SHORTCUTS
///////////////////////
//GLOBAL

boolean[] keyboard = new boolean[526];

public void shortCutsPrescene() {
  keyboard[keyCode] = true ;
  // save Scene
  check_Keyboard_save_scene_CURRENT_path() ;
  check_Keyboard_save_scene_NEW_path() ;
  // load
  check_Keyboard_load_scene() ;

  // save
  // if (key == 's') selectOutput("Enregistrez le PDF et le PNG ", "saveImg") ;
  // info common command with Scene
  if (key == 'i') displayInfo = !displayInfo ;
  if (key == 'g') displayInfo3D = !displayInfo3D ;

}



// SCENE
///////////////////
boolean load_Scene_Setting_local, 
        save_Current_Scene_Setting_local,
        save_New_Scene_Setting_local ;
// Scene load
// CTRL + O
public void check_Keyboard_load_scene() {
  if(checkKeyboard(CONTROL) && !checkKeyboard(SHIFT) && checkKeyboard(KeyEvent.VK_O) ) { 
    load_Scene_Setting_local = true ;
    //println("load scene / local", load_Scene_Setting_local) ;
    keyboard[keyCode] = false;   //
    
  }
}

// Scene current save
// CTRL + S
public void check_Keyboard_save_scene_CURRENT_path() {
  if(checkKeyboard(CONTROL) && !checkKeyboard(SHIFT) && checkKeyboard(KeyEvent.VK_S) ) {
    save_Current_Scene_Setting_local = true ;
    //println("save on current path scene / local",  save_Current_Scene_Setting_local) ;
    keyboard[keyCode] = false ;   // just open one window, when use only the keyboard, if you don't use that open all the windows save and open
   }
}
// Scene new save
// CTRL + SHIFT + S
public void check_Keyboard_save_scene_NEW_path() {
  if(checkKeyboard(CONTROL) && checkKeyboard(SHIFT) && checkKeyboard(KeyEvent.VK_S) ) {
    save_New_Scene_Setting_local = true ;
    // println("save on a new path scene / local", save_New_Scene_Setting_local) ;
    keyboard[keyCode] = false ;   // just open one window, when use only the keyboard, if you don't use that open all the windows save and open
  }
}



public boolean checkKeyboard(int c) {
  if (keyboard.length >= c) {
    return keyboard[c];  
  }
  return false;
}



      
 // KEYBOARD COMMAND       
        
public void keyboardTrue() {
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
  
  if (keyCode == BACKSPACE ) backspaceTouch = true ;
  if (keyCode == DELETE ) deleteTouch = true ;
  if (keyCode == SHIFT ) shiftTouch = true ;
  if (keyCode == ALT ) altTouch = true ;
  if (keyCode == RETURN ) returnTouch = true ;
  if (keyCode == ENTER ) enterTouch = true ;
  if (keyCode == CONTROL ) ctrlTouch = true ;
  if (keyCode == 157 ) cmdTouch = true ;
  
  if (keyCode == LEFT ) leftTouch = true ;
  if (keyCode == RIGHT ) rightTouch = true ;
  if (keyCode == UP ) upTouch = true ;
  if (keyCode == DOWN ) downTouch = true ;
}

public void keyboardLongFalse() {
  if (key == ' ' ) spaceTouch = false ; 
  if (key == 'c'  || key == 'C' ) cLongTouch = false ;
  if (key == 'l'  || key == 'L' ) lLongTouch = false ;
  if (key == 'n'  || key == 'N' ) nLongTouch = false ;
  if (key == 'v'  || key == 'V' ) vLongTouch = false ;
}


public void keyboardFalse() {
  /** 
  check for the key and put false here, but it's less reactive that put false just after the use the boolean...here you display false three time !
  */
  // we add modulo to be sure the information about the boolean is transmit to the scene
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
  if (cmdTouch) cmdTouch = false ;
  
  if (upTouch) upTouch = false ;
  if (downTouch) downTouch = false ;
  if (leftTouch) leftTouch = false ;
  if (rightTouch) rightTouch = false ;
}
//END KEYBOARD
//////////////

// Prescene A-OSC
/////////////////////////////////////
NetAddress targetScene, targetMiroir;
//adress to scene information from the OSC sender
String sendToScene = ("127.0.0.1") ;
String sendToMiroir = ("127.0.0.1") ;

//message from controler

//message from pr\u00e9-Sc\u00e8ne
String toScene = ("Message from Prescene to Scene") ;

OscP5 osc;
//SETUP
public void OSCSetup() {
  osc = new OscP5(this, 10000);
  
  //send to the Sc\u00e8ne
  if (youCanSendToScene) targetScene = new NetAddress(sendToScene,9001);
  //send to the miroir
  if (!testRomanesco) {
    String [] addressIP = loadStrings(preferencesPath+"network/IP_local_miroir.txt") ;
    sendToMiroir = join(addressIP, "") ;
    targetMiroir = new NetAddress(sendToMiroir,9002);
  } else if (testRomanesco && youCanSendToMiroir )  {
    targetMiroir = new NetAddress(sendToMiroir,9002);
  }
}



public void oscEvent(OscMessage receive) {
  if(receive.addrPattern().equals("Controller")) {
    catchDataFromController(receive) ;
    splitDataButton() ;
    splitDataSlider() ;
    splitDataLoadSaveController() ;
    /**
    Why this line is commented ?
    */
    // splitDataLoadSave() ;
  }
  /**
  // may be is not a good place for that
  */
  translateDataFromController () ;
}













// OSC DRAW
////////////
public void OSCDraw() {
  OscMessage RomanescoScene = new OscMessage("Prescene");
  // Prepare the packets
   encapsuleDataPrescene() ;
   booleanLoadSaveScene() ;

   //SEND data to SCENE
   RomanescoScene.add(toScene);
  // send the load path to the scene to also open the save setting in the scene with only one opening window input
  RomanescoScene.add(path_to_load_scene_setting) ;
  // reset the path for the next send, because the Scene check this path, to know if this one is not null,
  // and if this one is not null, the Scene load data.
  path_to_load_scene_setting = ("") ;

  RomanescoScene.add(booleanLoadSave) ;

  //send
  if (youCanSendToScene) osc.send(RomanescoScene, targetScene); 
  if (youCanSendToMiroir) osc.send(RomanescoScene, targetMiroir);
}




// ANNEXE VOID of OSC DRAW
//////////////////////////
String booleanLoadSave = ("") ;

public void booleanLoadSaveScene() {
       // LOAD SAVE SCENE ORDER
  boolean load, save_current, save_new ;
  if (load_SCENE_Setting_GLOBAL          || load_Scene_Setting_local)          load = true ;         else load = false ;
  if (save_Current_SCENE_Setting_GLOBAL  || save_Current_Scene_Setting_local)  save_current = true ; else save_current = false ;
  if (save_New_SCENE_Setting_GLOBAL      || save_New_Scene_Setting_local)      save_new = true ;     else save_new = false ;

  String load_string = String.valueOf(load) ;
  String  saveCurrent_string = String.valueOf(save_current) ;
  String  saveNew_string = String.valueOf(save_new) ;

  // we change to false boolean load and data to false each 1 second to have a time to load and save
  if(frameCount%60 == 0) { 
    load_SCENE_Setting_GLOBAL = save_Current_SCENE_Setting_GLOBAL = save_New_SCENE_Setting_GLOBAL = false ;
    load_Scene_Setting_local = save_Current_Scene_Setting_local = save_New_Scene_Setting_local = false ;
  }

  booleanLoadSave = load_string + "/" +  saveCurrent_string + "/" + saveNew_string ;
}




// FROM PRESCENE to SCENE
String dataPreScene [] = new String [74] ;

public void encapsuleDataPrescene(){
  //CATCH data from preScene to Scene
   if (spaceTouch) dataPreScene [0] = ("1") ; else dataPreScene [0] =("0") ;
   if (aTouch)     dataPreScene [1] = ("1") ; else dataPreScene [1] = ("0") ;
   if (bTouch)     dataPreScene [2] = ("1") ; else dataPreScene [2] = ("0") ;
   if (cTouch)     dataPreScene [3] = ("1") ; else dataPreScene [3] = ("0") ;
   if (dTouch)     dataPreScene [4] = ("1") ; else dataPreScene [4] = ("0") ;
   if (eTouch)     dataPreScene [5] = ("1") ; else dataPreScene [5] = ("0") ;
   if (fTouch)     dataPreScene [6] = ("1") ; else dataPreScene [6] = ("0") ;
   if (gTouch)     dataPreScene [7] = ("1") ; else dataPreScene [7] = ("0") ;
   if (hTouch)     dataPreScene [8] = ("1") ; else dataPreScene [8] = ("0") ;
   if (iTouch)     dataPreScene [9] = ("1") ; else dataPreScene [9] = ("0") ;
   if (jTouch)     dataPreScene [10] = ("1") ; else dataPreScene [10] = ("0") ;
   if (kTouch)     dataPreScene [11] = ("1") ; else dataPreScene [11] = ("0") ;
   if (lTouch)     dataPreScene [12] = ("1") ; else dataPreScene [12] = ("0") ;
   if (mTouch)     dataPreScene [13] = ("1") ; else dataPreScene [13] = ("0") ;
   if (nTouch)     dataPreScene [14] = ("1") ; else dataPreScene [14] = ("0") ;
   if (oTouch)     dataPreScene [15] = ("1") ; else dataPreScene [15] = ("0") ;
   if (pTouch)     dataPreScene [16] = ("1") ; else dataPreScene [16] = ("0") ;
   if (qTouch)     dataPreScene [17] = ("1") ; else dataPreScene [17] = ("0") ;
   if (rTouch)     dataPreScene [18] = ("1") ; else dataPreScene [18] = ("0") ;
   if (sTouch)     dataPreScene [19] = ("1") ; else dataPreScene [19] = ("0") ;
   if (tTouch)     dataPreScene [20] = ("1") ; else dataPreScene [20] = ("0") ;
   if (uTouch)     dataPreScene [21] = ("1") ; else dataPreScene [21] = ("0") ;
   if (vTouch)     dataPreScene [22] = ("1") ; else dataPreScene [22] = ("0") ;
   if (wTouch)     dataPreScene [23] = ("1") ; else dataPreScene [23] = ("0") ;
   if (xTouch)     dataPreScene [24] = ("1") ; else dataPreScene [24] = ("0") ;
   if (yTouch)     dataPreScene [25] = ("1") ; else dataPreScene [25] = ("0") ;
   if (zTouch)     dataPreScene [26] = ("1") ; else dataPreScene [26] = ("0") ;

   if(rTouch) println("Prescene",rTouch,dataPreScene [18], frameCount) ;
   
   //FREE
   dataPreScene [27] = ("") ;
   dataPreScene [28] = ("") ;
   dataPreScene [29] = ("") ;
   
   // SPECIAL TOUCH
   if (enterTouch)    dataPreScene [30] = ("1") ; else dataPreScene [30] = ("0") ;
   if (deleteTouch)    dataPreScene [31] = ("1") ; else dataPreScene [31] = ("0") ;
   if (backspaceTouch) dataPreScene [32] = ("1") ; else dataPreScene [32] = ("0") ;
   if (upTouch) dataPreScene [33] = ("1") ; else dataPreScene [33] = ("0") ;
   if (downTouch) dataPreScene [34] = ("1") ; else dataPreScene [34] = ("0") ;
   if (rightTouch) dataPreScene [35] = ("1") ; else dataPreScene [35] = ("0") ;
   if (leftTouch) dataPreScene [36] = ("1") ; else dataPreScene [36] = ("0") ;
   if (ctrlTouch) dataPreScene [37] = ("1") ; else dataPreScene [37] = ("0") ;
   
   // MOUSE
   dataPreScene[40] = FloatToStringWithThree(pen[0].x) ; dataPreScene[41] = FloatToStringWithThree(pen[0].y) ; dataPreScene[42] = FloatToString(pen[0].z) ; 
   dataPreScene[43] = FloatToStringWithThree(norm(mouse[0].x, 0, width)) ; 
   dataPreScene[44] = FloatToStringWithThree(norm(mouse[0].y,0,height)) ;
   dataPreScene[45] = FloatToStringWithThree(norm(mouse[0].z,-depth,depth)) ;
   if (clickShortLeft[0]) dataPreScene [46] = ("1") ; else dataPreScene [46] = ("0") ;
   if (clickShortRight[0]) dataPreScene [47] = ("1") ; else dataPreScene [47] = ("0") ;
   if (clickLongLeft[0]) dataPreScene [48] = ("1") ; else dataPreScene [48] = ("0") ;
   if (clickLongRight[0]) dataPreScene [49] = ("1") ; else dataPreScene [49] = ("0") ;
   dataPreScene[50] = IntToString(wheel[0]) ;
   
   // NUMBER
   if (touch1)     dataPreScene [51] = ("1") ; else dataPreScene [51] = ("0") ;
   if (touch2)     dataPreScene [52] = ("1") ; else dataPreScene [52] = ("0") ;
   if (touch3)     dataPreScene [53] = ("1") ; else dataPreScene [53] = ("0") ;
   if (touch4)     dataPreScene [54] = ("1") ; else dataPreScene [54] = ("0") ;
   if (touch5)     dataPreScene [55] = ("1") ; else dataPreScene [55] = ("0") ;
   if (touch6)     dataPreScene [56] = ("1") ; else dataPreScene [56] = ("0") ;
   if (touch7)     dataPreScene [57] = ("1") ; else dataPreScene [57] = ("0") ;
   if (touch8)     dataPreScene [58] = ("1") ; else dataPreScene [58] = ("0") ;
   if (touch9)     dataPreScene [59] = ("1") ; else dataPreScene [59] = ("0") ;
   if (touch0)     dataPreScene [60] = ("1") ; else dataPreScene [60] = ("0") ;
   
   //longtouch
   if (cLongTouch) dataPreScene [61] = ("1") ; else dataPreScene [61] = ("0") ;
   if (lLongTouch) dataPreScene [62] = ("1") ; else dataPreScene [62] = ("0") ;
   if (nLongTouch) dataPreScene [63] = ("1") ; else dataPreScene [63] = ("0") ;
   if (vLongTouch) dataPreScene [64] = ("1") ; else dataPreScene [64] = ("0") ;
   
   // FREE
   dataPreScene [65] = ("") ;
   dataPreScene [66] = ("") ;
   dataPreScene [67] = ("") ;
   dataPreScene [68] = ("") ;
   dataPreScene [69] = ("") ;
   
   // ORDER
   if (ORDER_ONE) dataPreScene [70] = ("1") ; else dataPreScene [70] = ("0") ;
   if (ORDER_TWO) dataPreScene [71] = ("1") ; else dataPreScene [71] = ("0") ;
   if (ORDER_THREE) dataPreScene [72] = ("1") ; else dataPreScene [72] = ("0") ;
   if (LEAPMOTION_DETECTED) dataPreScene [73] = ("1") ; else dataPreScene [73] = ("0") ;

   
   toScene = join(dataPreScene, "/") ;

}










// LOAD
boolean openLoad = true ;
public void loadPrescene() {
	// we must send the load path to Scene to also open the save setting in the scene with only one opening window input
	if((load_SCENE_Setting_GLOBAL || load_Scene_Setting_local) && openLoad) {
		openLoad = false ;
		selectInput("Load setting Scene", "loadSettingScene") ; // ("display info in the window" , "name of the method callingBack" )
	}
}


String path_to_load_scene_setting = ("") ;
// method callingBack
public void loadSettingScene(File selection) {
  if (selection != null) {
  	path_to_load_scene_setting = selection.getAbsolutePath();
  	loadDataObject(path_to_load_scene_setting) ;
  } 
  load_SCENE_Setting_GLOBAL = false ;
  load_Scene_Setting_local = false ;
  openLoad = true ;
}
///////////////////////////////////////////////
//GRAPHIC CONFIGURATION OF THE SCENE DISPLAYING
//SCREEN CHOICE and FULLSCREEN
GraphicsEnvironment ge = GraphicsEnvironment.getLocalGraphicsEnvironment();
GraphicsDevice[] gs = ge.getScreenDevices();
//FULLSCREEN
boolean undecorated = false ;
boolean fullScreen = false ;
boolean displaySizeByImage ;
String displayMode = ("") ;
//ID of the screen
int myScreenToDisplayMySketch ;
//size of the Scene
int fullSceneWidth, fullSceneHeight, sceneWidth, sceneHeight ;
int depth ;
//to load the .csv who give the graphic configuration for the Scene
Table configurationScene;
//factor to divide the size of the Pr\u00e9-Sc\u00e8ne 
int divSizePreScene = 2 ;

String pathScenePropertySetting = sketchPath("")+"preferences/sceneProperty.csv" ;
TableRow row ;

//SETUP
public void displaySetup(int speed) {
  frameRate(speed) ;  // Le frameRate doit \u00eatre le m\u00eame dans tous les Sketches
  colorMode(HSB, HSBmode.r, HSBmode.g, HSBmode.b, HSBmode.a) ;
  loadPropertyPrescene() ;
  sizePrescene() ;
  backgroundSetup() ;
  backgroundShaderSetup(modeP3D) ;
}
//END DISPLAY START
//////////////////


//load property from table
public void loadPropertyPrescene() {
  configurationScene = loadTable(pathScenePropertySetting, "header");
  row = configurationScene.getRow(0);
  //fullscreen 
  if (row.getString("fullscreen").equals("TRUE") || row.getString("fullscreen").equals("true")) fullScreen = true ; else fullScreen = false ;
  //display on specific screen
  myScreenToDisplayMySketch = row.getInt("whichScreen") -1 ;
  //decorated the scene
  if (row.getString("decorated").equals("FALSE") || row.getString("decorated").equals("false") || fullScreen ) undecorated = true ; else undecorated = false ;

  // type of renderer
  if      ( row.getString("render").equals("P2D") ) { displayMode = ("P2D") ;  modeP3D = false ; }
  else if ( row.getString("render").equals("P3D") ) { displayMode = ("P3D") ; modeP3D = true ; }
  else if (  row.getString("render").equals("OPENGL")  || row.getString("render").equals("opengl") ) { displayMode = ("OPENGL") ; modeP3D = false ; }
  else { displayMode = ("Classic") ; modeP3D = false ; }
}





// SIZE SCENE
public void sizePrescene() {
      //size of the scene or prescene
  if(modeP3D) size(600,400,P3D) ; else size(600,400) ;
  depth = height ;
    //resizable frame by loading external image
  // if (row.getString("resizable").equals("TRUE")    || row.getString("fullscreen").equals("true")) {
  if (row.getString("resizable").equals("TRUE")) {
    frame.pack();  
    insets = frame.getInsets(); // use for the border of window (top and right)
    displaySizeByImage = true ;
  }
  
  //resize by cursor
  frame.setResizable(true);
}
// END SIZE SCENE

    
//CHANGE SIZE DISPLAY BY IMAGE LOADING
public void updateSizeDisplay(PImage imgDisplay) {
  if (imgDisplay != null ) {
    PVector newSizeSketch = new PVector (imgDisplay.width, imgDisplay.height ) ;
    setSize((int)newSizeSketch.x, (int)newSizeSketch.y) ;
    PVector newSizeWindow = new PVector ( Math.max( newSizeSketch.x, MIN_WINDOW_WIDTH)  + insets.left + insets.right, 
                                          Math.max( newSizeSketch.y, MIN_WINDOW_HEIGHT) + insets.top  + insets.bottom) ;
    frame.setSize((int)newSizeWindow.x, (int)newSizeWindow.y);
  }
}

//catch the size of display device to get the fullscreen on the screen of your choice
public PVector fullScreen(int whichScreen) {
  PVector size = new PVector(0,0) ;
  if (whichScreen >= gs.length ) { 
    whichScreen = 0 ;
  }
  size.x =  gs[whichScreen].getDisplayMode().getWidth() ;
  size.y =  gs[whichScreen].getDisplayMode().getHeight() ;
  
  frame.removeNotify();
  frame.setUndecorated(true);
  frame.addNotify();

  return size ;
}

public void sketchPos(int x, int y, int whichScreen) {
  if (whichScreen >= gs.length ) { 
    whichScreen = 0 ;
  } 
  GraphicsDevice gd = gs[whichScreen];
  GraphicsConfiguration[] gc = gd.getConfigurations();
  for (int i=0; i < gc.length; i++) {
    Rectangle gcBounds = gc[i].getBounds();
    int xoffs = gcBounds.x;
    int yoffs = gcBounds.y;
    int posX = (i*50)+xoffs ;
    int posY =  (i*60)+yoffs ;
    frame.setLocation(posX +x, posY +y);
  }
}

// END OF GRAPHIC CONFIGURATION
///////////////////////////////
// LEAP COMMAND
///////////////
boolean orderOneLeap, orderTwoLeap ;


public void updateLeapCommand() {
  // move the object
  if(finger.activefingers == 1 ) {
    orderOneLeap = true ; 
    orderTwoLeap = false ;
  }
  // rotate the object
  else if(finger.activefingers == 2) {
    orderOneLeap = false ; 
    orderTwoLeap = true ;
  }
  // move and rotate
  else if(finger.activefingers == 3) {
    orderOneLeap = true ; 
    orderTwoLeap = true ;
  } else if(finger.activefingers != 1 || finger.activefingers != 2 || finger.activefingers != 3) {
    orderOneLeap = false ; 
    orderTwoLeap = false ;
  }
    
}






/////////////////////////////
// VOID & FUNCTION LEAPMOTION
// LEAP MOTION
FingerLeap finger ;

public void leapMotionSetup() {
  finger = new FingerLeap() ;
}

public void leapMotionUpdate() {
  finger.updateLeap() ;
  LEAPMOTION_DETECTED = false ;
  if(fingerVisibleCheck()) LEAPMOTION_DETECTED = true ; else LEAPMOTION_DETECTED = false ;
}

public boolean fingerVisibleCheck() {
  if (finger.activefingers > 0) return true ; else return false ;
}


// DIRECT POS of the fingers in the LEAP FIELD DETECTION
// CLASSIC WORLD
public PVector averageFingerPos() {
  PVector pos = new PVector() ;
  if(finger.fingerCheck) {
    for(int i = 0; i < finger.num ; i++) {
      pos = new PVector(finger.averagePos.x *width, height -finger.averagePos.y *height,finger.averagePos.z  *(width+height) -((width+height)/2)) ;
    }
  }
  return pos ;
}


// GIVE the size of your world
public PVector averageFingerPos(PVector canvas) {
  PVector pos = new PVector() ;
  if(finger.fingerCheck) {
    for(int i = 0; i < finger.num ; i++) {
      pos = new PVector(finger.averagePos.x *canvas.x, canvas.y -finger.averagePos.y *canvas.y,finger.averagePos.z  *canvas.z -(canvas.z/2)) ;
    }
  }
  return pos ;
}



// POSITION from a direction, by adding info from the leap direction
PVector translatePosition = new PVector() ;
public PVector averageTranslatePosition(float speed) {
  if(finger.fingerCheck) {
    for(int i = 0; i < finger.num ; i++) {
      PVector tempDir = new PVector(finger.averageDir.x *speed, finger.averageDir.y *speed, finger.averageDir.z *speed) ; 
      translatePosition.add(tempDir) ;
    }
    return translatePosition ; 
  } else return translatePosition ;
}




///////////////////
//CLASS LEAPMOTION

com.leapmotion.leap.Controller leap;


class FingerLeap {
  //global
  // speed reactivity to update the position of the pointer - cursor in XYZ world - 
  float speed = .05f ;
  // Minimum value to accept finger in the count. The value must be between 0 to 1 ;
  float minValueToCountFinger = .95f ; 
  // range value around the first finger to accepted in the finger count 
  float rangeAroundTheFirstFinger = .2f ;
  //check if the fingers is present or no
  boolean fingerCheck ;
  boolean [] fingerVisible ;
  //for each finger
  int num ;
  int activefingers ;
  int [] ID ;
  int [] IDleap ;
  PVector [] pos ;
  PVector [] dir ;
  float [] magnitude, roll, pitch, yaw ;
  
  // average data
  PVector averagePos, averageDir ;
  PVector addPos = new PVector() ;
  float rangeMin = 0 ; 
  float rangeMax = 0 ;
  PVector findAveragePos = new PVector() ;
  
  FingerLeap() {
    leap = new com.leapmotion.leap.Controller();
  }
  
  
  public void updateLeap() {
    InteractionBox iBox = leap.frame().interactionBox();
    PointableList objectNum = leap.frame().pointables();
    //check finger
    fingerCheck = !objectNum.isEmpty() ;
    // create and init var ;
    num = objectNum.count() ;
    IDleap = new int[num] ;
    ID = new int[num] ;
    activefingers = 0 ;
    fingerVisible = new boolean [num] ;
    pos = new PVector[num] ;
    dir = new PVector[num] ;
    magnitude = new float [num] ; 
    roll= new float [num] ; 
    pitch= new float [num] ; 
    yaw = new float [num] ;
    
    // give info to variables for each finger display or not
    for(int i = 0; i < objectNum.count(); i++) {
      
      //initialization
      Pointable object = objectNum.get(i);
      com.leapmotion.leap.Vector normalPos = iBox.normalizePoint(object.stabilizedTipPosition());
      fingerVisible[i] = false ;
      
      // catch info
      IDleap[i] = object.id() ;
      ID[i] = i  ;
      // return normal position value between 0 to 1 
      pos[i] = new PVector(normalPos.getX(),normalPos.getY(),normalPos.getZ()) ;
      // return normal direction between - 1 to 1
      dir[i] = new PVector(normalPos.getX() *2 -1.0f, normalPos.getY() *2 -1.0f, normalPos.getZ() *2 -1.0f ) ;
      
      // misc value
      magnitude[i] = normalPos.magnitude() ; 
      roll[i] = normalPos.roll() ; 
      pitch[i] = normalPos.pitch() ; 
      yaw[i] = normalPos.yaw() ;
      
      
      //Find average position of all visible fingers
      findAveragePos(pos[i], i) ; 
    }
    // write the result
    averagePos = averagePos(addPos).copy() ;
    averageDir = new PVector(averagePos.x *2 -1.0f, averagePos.y *2 -1.0f,averagePos.z *2 -1.0f) ;
  }
  
  
  
  // ANNEXE
  
  //check if the finger is visible or not
  public void findAveragePos(PVector normalPos, int whichOne) {
    if(activefingers < 1) {
      if(normalPos.z < minValueToCountFinger) {
        addPos = normalPos.copy() ;
        rangeMin = addPos.z -rangeAroundTheFirstFinger ; 
        rangeMax = addPos.z +rangeAroundTheFirstFinger ;
        activefingers += 1 ;
        fingerVisible[whichOne] = true ;
      }
    // if there is one finger, we compare if the others are close of the firsts fingers  
    } else {
      // check if the next finger is in the range
      if(normalPos.z > rangeMin && normalPos.z < rangeMax) {
        // create a range from the average position Z
        rangeMin = addPos.z -rangeAroundTheFirstFinger ; 
        rangeMax = addPos.z +rangeAroundTheFirstFinger ;
        // check if the finger detected is in the range or not, we must do that because the detection of the finger is not perfect and add finger when the hand is deepness in detector
        // if it's ok we add a visible finger in the count
        // check if the finger detected is in the range or not, we must do that because the detection of the finger is not perfect and add finger when the hand is deepness in detector
        activefingers += 1 ;
        // if it's ok we add value
        addPos.add(normalPos.x,normalPos.y,normalPos.z) ;
        // after we divide by 2 because we've added a value at the end of this checking.
        addPos.div(2) ;
        fingerVisible[whichOne] = true ;
      }
    } 
  }

  
  
  // Function to calcul the average position and smooth this one
  public PVector averagePos(PVector infoPos) {
    PVector pos = new PVector() ;
    /*
    Average position of all visible fingers
    Finalize the calcule, and dodge the bad value
    */
    if(infoPos.x > 1.0f) infoPos.x /= 2.0f ;
    if(infoPos.y > 1.0f) infoPos.y /= 2.0f ;
    if(infoPos.z > 1.0f) infoPos.z /= 2.0f ;
    //smooth the result
    // pos = new PVector(follow(pos, speed).x, follow(pos, speed).y, follow(pos, speed).z) ;
    pos = follow(infoPos, speed).copy() ;
    // pos = infoPos.copy() ;
    return pos ;
  }
}
class Letter extends Romanesco {
  public Letter() {
    //from the index_objects.csv
    romanescoName = "Letter" ;
    IDobj = 1 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Version 1.2";
    romanescoPack = "Base" ;
    romanescoRender = "P3D" ;
    romanescoMode = "Point/Line/Triangle" ;
    romanescoSlider = "Hue fill,Saturation fill,Brightness fill,Alpha fill,Hue stroke,Saturation stroke,Brightness stroke,Alpha stroke,Thickness,Size X,Canvas X,Canvas Y,Canvas Z,Quantity,Speed" ;
  }
  //GLOBAL
  RFont f;
  RShape grp;
  boolean newSetting ;
  int sizeRef, sizeFont ;
  String sentenceRef = ("") ; 
  String pathRef = ("") ;
 
  int whichLetter ;
  int axeLetter ;
  int startDirection = -1 ;
  int numLetter ;

  
  //SETUP
  public void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
  }
  
  
  
  
  //DRAW
  public void display() {
    loadText(IDobj) ;
    
    if (parameter[IDobj] || pathFontObjTTF[IDobj] == null ) { 
      font[IDobj] = font[0] ;
      pathFontObjTTF[IDobj] = pathFontObjTTF[0] ;
    }
    //init and re-init Geomerative if few stuff change about this line like text, font and the size of the font
    sizeFont = PApplet.parseInt(fontSizeObj[IDobj]) ;
    //text
    String sentence = whichSentence(textImport[IDobj], 0, 0) ;
    

    
    //check if something change to update the RG.getText
    if ( sizeRef == sizeFont && sentenceRef.equals(sentence) && pathRef.equals(pathFontObjTTF[IDobj])) newSetting = true  ; else newSetting = false ;
    sizeRef = sizeFont ;
    sentenceRef = (sentence) ;
    pathRef = (pathFontObjTTF[IDobj]) ;
    if(!newSetting || resetParameter(IDobj)) {
     
      grp = RG.getText(sentence, pathFontObjTTF[IDobj], (int)sizeFont, CENTER); 
      newSetting = true ;
      axeLetter = PApplet.parseInt(random (grp.countChildren())) ;
    }
    if(resetParameter(IDobj)) {
      int choiceDir = floor(random(2)) ;
      if(choiceDir == 0 ) startDirection = -1 ; else startDirection = 1 ;
    }
    
    if(allBeats(IDobj) > 10 || nTouch ) axeLetter = PApplet.parseInt(random (grp.countChildren())) ;
    
    

    
    
    /////////
    //ENGINE
    
    //speed
    float speed ;
    if(motion[IDobj]) speed = map(speedObj[IDobj], 0,1, 0.000f, 0.3f ) *tempo[IDobj]  ; else speed = 0.0f ;
    //to stop the move
    if (!action[IDobj]) speed = 0.0f ; 
    if(clickLongLeft[IDobj] || spaceTouch) speed = -speed ;
    
    //num letter to display
    numLetter = (int)map(quantityObj[IDobj],0,1, 0,grp.countChildren() +1) ;
    
    //DISPLAY
    // thickness
    float thicknessLetter = map(thicknessObj[IDobj], .1f, height/3, 0.1f, height /10) ; ;

    // color
    if(mode[IDobj] <= 1) {
      noFill() ; stroke(fillObj[IDobj]) ; strokeWeight(thicknessLetter) ;
    } else {
      fill(fillObj[IDobj]) ; stroke(strokeObj[IDobj]) ; strokeWeight(thicknessLetter) ;
    }
    //jitter
    float jitterX = map(canvasXObj[IDobj],width/10, width, 0, width/40) ;
    float jitterY = map(canvasYObj[IDobj],width/10, width, 0, width/40) ;
    float jitterZ = map(canvasZObj[IDobj],width/10, width, 0, width/40) ;
    PVector jitter = new PVector (jitterX *jitterX, jitterY *jitterY, jitterZ *jitterZ) ;
    


    letters(speed, axeLetter, jitter) ;
    //END YOUR WORK
    

    
    // INFO
    objectInfo[IDobj] = ("Quantity of letter display " + numLetter + " - Speed " +PApplet.parseInt(speed*100)) ;

  }
  
  
  // ANNEXE
  float rotation ;
  
  public void letters(float speed, int axeLetter, PVector jttr) {
    //create a PVector arraylist from geomerative analyze
    // float rangeWhichLetter = width / grp.countChildren() ;
    if (sound[IDobj]) whichLetter = (int)allBeats(IDobj) ; else whichLetter = 0 ;
    
    //security against the array out bounds
    if(whichLetter < 0 ) whichLetter = 0 ; else if (whichLetter >= grp.countChildren()) whichLetter = grp.countChildren() -1  ;
    wheelLetter(numLetter, speed, jttr) ;

    
    if(axeLetter < 0 ) axeLetter = 0 ; else if (axeLetter >= grp.countChildren()) axeLetter = grp.countChildren() - 1 ;
    displayLetter(axeLetter, jttr) ;
  }
  
  int whichOneChangeDirection = 1 ;
  
  public void wheelLetter(int num, float speed, PVector jttr) {
    // direction rotation for each one
    if(frameCount%160 == 0 || nTouch) whichOneChangeDirection = round(random(1,num)) ;
    //position
    for ( int i = 0 ; i < num ; i++) {
      int targetLetter ;
      targetLetter = whichLetter +i ;
      if (targetLetter < grp.countChildren() ) {
        if(i%whichOneChangeDirection == 0 ) speed  = speed *-1  ;
        speed = speed *startDirection ;
        if(motion[IDobj]) grp.children[targetLetter].rotate(speed, grp.children[axeLetter].getCenter());
        displayLetter(targetLetter, jttr) ;
      }
    }
  }
  
  public void displayLetter(int which, PVector ampJttr) {
    RPoint[] pnts = grp.children[which].getPoints() ; 
    PVector [] points = geomerativeFontPoints(pnts)  ;
    /*
    noFill() ; stroke(c) ; strokeWeight(thickness) ;
    // security against the black brightness bug opacity
    if (alpha(c) == 0 ) {
      noFill() ; 
      noStroke() ; 
    } else {     
      fill (c) ; 
    }
    */
    for ( int i = 0; i < points.length; i++ ) {
      points[i].add(jitterPVector(ampJttr)) ;
      float factor = 40.0f ;
      points[i].z = points[i].z +(allBeats(IDobj) *factor) ; 

      if(mode[IDobj] == 0 ) point(points[i].x, points[i].y, points[i].z) ;
      if(mode[IDobj] == 1 ) if(i > 0 ) line( points[i-1].x, points[i-1].y, points[i-1].z,   points[i].x, points[i].y, points[i].z );
      if(mode[IDobj] == 2 ) if(i > 1 ) triangle(points[i-2].x, points[i-2].y, points[i-2].z,   points[i-1].x, points[i-1].y, points[i-1].z,   points[i].x, points[i].y, points[i].z );
      
    }
  }
  
  //ANNEXE VOID
  //jitter for PVector points
  public PVector jitterPVector(PVector range) {
    float factor = 0.0f ;
    if(sound[IDobj]) factor = 2.0f ; else factor = 0.1f  ;
    int rangeX = PApplet.parseInt(range.x *left[IDobj] *factor) ;
    int rangeY = PApplet.parseInt(range.y *right[IDobj] *factor) ;
    int rangeZ = PApplet.parseInt(range.z *mix[IDobj] *factor) ;
    PVector jitting = new PVector(0,0,0) ;
    jitting.x = random(-rangeX, rangeX) ;
    jitting.y = random(-rangeY, rangeY) ;
    jitting.z = random(-rangeZ, rangeZ) ;
    return jitting ;
  }
  
  //void work with geomerative
  public PVector [] geomerativeFontPoints(RPoint[] p) {
    PVector [] pts = new PVector [p.length] ;
    for(int i = 0 ; i <pts.length ; i++) {
      pts[i] = new PVector(0,0,0) ;
      pts[i].x = p[i].x ; 
      pts[i].y = p[i].y ;  
    }
    return pts ;
  }
  
}
//////////////////
//OBJECT ROMANESCO
class Horloge extends Romanesco {
  public Horloge() {
    //from the index_objects.csv
    romanescoName = "Horloge" ;
    IDobj = 2 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Stan Le Punk";
    romanescoVersion = "Version 2.0";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
    romanescoMode = "Ellipse Clock 12/Ellipse Clock 24/Line Clock 12/Line Clock 24/minutes/secondes" ;// separate the name by a slash and write the next mode immadialtly after this one.
    romanescoSlider = "Hue fill,Saturation fill,Brightness fill,Alpha fill,Width,Direction,Amplitude" ;
  }
  //GLOBAL
  
  
  //SETUP
  public void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
  }
  
  
  
  
  //DRAW
  public void display() {
    textAlign(CENTER);
    // typo
    float sizeFont = fontSizeObj[IDobj] +12 ;
    textFont(font[IDobj], sizeFont *allBeats(IDobj));
    
    // couleur du texte
    float t = alpha(fillObj[IDobj]) * abs(mix[IDobj]) ;
    if (sound[IDobj]) t = alpha(fillObj[IDobj]) ;
    int c = color(hue(fillObj[IDobj]), saturation(fillObj[IDobj]), brightness(fillObj[IDobj]), t ) ;
    // security against the blavk bug opacity
    if (alpha(c) == 0 ) {
      noFill() ; 
      noStroke() ; 
    } else {     
      fill (c) ; 
    }
    
    //rotation / deg
    float angle = map(directionObj[IDobj], 0,360, 0, TAU) ;
    //amplitude
    float amp = map(amplitudeObj[IDobj],0,1, 1, height  / 4) ;
    
    //CHANGE MODE DISPLAY
    /////////////////////
    if (mode[IDobj] == 0 ) {
      horlogeCercle (mouse[IDobj], angle, amp, 12 ) ; // on 12 hours model english clock
    } else if (mode[IDobj] == 1 ) {
      horlogeCercle (mouse[IDobj], angle,  amp, 24 ) ; // on 24 hours model international clock
    } else if (mode[IDobj] == 2 ) {
      horlogeLigne  (mouse[IDobj], angle, amp, 12 ) ; // on 12 hours model english clock
    } else if (mode[IDobj] == 3 ) {
      horlogeLigne  (mouse[IDobj], angle, amp, 24 ) ; // on 24 hours model international clock
    } else if (mode[IDobj] == 4 ) {
      horlogeMinute(mouse[IDobj], angle) ;
    } else if (mode[IDobj] == 5 ) {
      horlogeSeconde(mouse[IDobj], angle) ;
    }

  }
  
  
  //ANNEXE
  public void horlogeCercle(PVector posHorloge, float angle, float  amp, int timeMode) {
    //Angles pour sin() et cos() d\u00e9part \u00e0 3h, enlever PI/2 pour un d\u00e9part \u00e0 midi
    float s = map (second(), 0, 60, 0,    TWO_PI ) - HALF_PI ;
    float m = map (minute(), 0, 60, 0,    TWO_PI ) - HALF_PI ;
    float h = map (hour() % 12, 0, 12, 0, TWO_PI ) - HALF_PI ;
    
    
    //seconde
    textAlign(CENTER, CENTER) ;
    translate(posHorloge.x, posHorloge.y) ;
    rotate(angle) ;
    text (nf(second(),2), cos(s)*amp*8 , sin(s)*amp*8 ) ;
    //minute
    text (nf(minute(),2), cos(m)*amp*6 , sin(m)*amp*6  ) ;
    //heure
    text(nf(hour()%timeMode ,2), cos(h)*amp*4 , sin(h)*amp*4  ) ;
    // text
    if ( timeMode == 12 ) if (hour() < 12 ) text("AM", 0, 0) ; else  text("PM", 0, 0 ) ; else text("TIME", 0, 0) ;
    
    textAlign(LEFT, TOP) ;
  }
  
  
  ////
  public void horlogeLigne(PVector posHorloge, float angle, float amp, int timeMode) {
    //seconde
    textAlign(CENTER, CENTER) ;
    translate(posHorloge.x, posHorloge.y) ;
    rotate(angle) ;
    text( nf(hour()%timeMode,2)   + "." + 
          nf(minute(),2)   + "." + 
          nf(second(),2), 
          0, 0);
    textAlign(LEFT, TOP) ;
  }
  
  ////
  public void horlogeMinute(PVector posHorloge, float angle) {
    textAlign(CENTER, CENTER) ;
    translate(posHorloge.x, posHorloge.y) ;
    rotate(angle) ;
    text(hour() *60 + minute() + " MINUTES", 0,0) ;
    textAlign(LEFT, TOP) ;
  }
  
  ////
  public void horlogeSeconde(PVector posHorloge, float angle) {
    textAlign(CENTER, CENTER) ;
    translate(posHorloge.x, posHorloge.y) ;
    rotate(angle) ;
    text((hour() *3600) + (minute() *60) + second() + " SECONDES", 0,0) ;
    textAlign(LEFT, TOP) ;
  }
}
//end object one
//////////////////
//OBJECT ROMANESCO
class RSS extends Romanesco {
  public RSS() {
    //from the index_objects.csv
    romanescoName = "RSS" ;
    IDobj = 3 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Stan Le Punk";
    romanescoVersion = "version 1.1";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
    romanescoMode = "" ; // separate the name by a slash and write the next mode immadialtly after this one.
    romanescoSlider = "Hue fill,Saturation fill,Brightness fill,Alpha fill,Size X,Canvas X,Canvas Y,Canvas Z,Direction" ;
  }
  //GLOBAL
  FeedReader flux;
  String RSSliberation, RSSlemonde;
  float Rinfo ;
  int info = 0 ; 
  String messageRSS ;
  
  
  //SETUP
  public void setting() {
    startPosition(IDobj,width/10, height/2, 0) ;
    
    
    if(internet) {
      String [] fluxRSS = loadStrings(preferencesPath+"network/RSSReference.txt") ;
      String RSS = join(fluxRSS, "") ;
      flux = new FeedReader(RSS);
    }
    
  }
  
  
  
  
  //DRAW
  public void display() {
    float sizeFont = fontSizeObj[IDobj] ;
    textFont(font[IDobj], sizeFont + ( sizeFont *mix[IDobj]) *allBeats(IDobj) );
    // couleur du texte
    float t = alpha(fillObj[IDobj]) * abs(mix[IDobj]) ;
    if ( sound[IDobj] ) { t = alpha(fillObj[IDobj]) ; } 
    int c = color(hue(fillObj[IDobj]), saturation(fillObj[IDobj]), brightness(fillObj[IDobj]), t ) ;
    // security against the blavk bug opacity
    if (alpha(c) == 0 ) {
      noFill() ; 
      noStroke() ; 
    } else {     
      fill (c) ; 
    }
    
    //hauteur largeur, height & width
    float ratioTextBox ;
    ratioTextBox = allBeats(IDobj) *.25f ;
    if(ratioTextBox < 1 ) ratioTextBox = 1.f ;
    float largeur = canvasXObj[IDobj] *ratioTextBox ;
    float hauteur = canvasYObj[IDobj] *ratioTextBox ;    
      
    for( int i=info; i < info + 1; i++) {
      //internet = false ;
      if (internet && fullRendering) {
        if(i<flux.entry.length) messageRSS =  (i +""+flux.entry[i]) ;  else messageRSS =("  Big Brother is watching you") ;
      } else messageRSS = ("  Big Brother is watching you") ;
      int r ;
      if ( i > 9 ) r =2 ; else if( i > 0 && i < 10 ) r =1 ; else r =0 ; 
      String hune = messageRSS.substring(r);
      //rotation / degr\u00e9
      rotation(directionObj[IDobj], mouse[IDobj].x, mouse[IDobj].y) ;
      if(horizon[IDobj]) textAlign(CENTER) ; else textAlign(LEFT) ;
      text(hune, 0, 0, largeur, hauteur );
    }
    
    // BUTTON
    if(action[IDobj] && nTouch ) {
      Rinfo = random (1,24) ;
      info = round(Rinfo) ;
    }

  }
}
//end object one





// CLASS
////////////
//class RSS
class FeedReader {  
  SyndFeed feed;  
  String url,description,title;  
  int numEntries;  
  FeedEntry entry[];  
  
  public FeedReader(String _url) {  
    url=_url;  
    try {  
      feed=new SyndFeedInput().build(new XmlReader(new URL(url)));  
      description=feed.getDescription();  
      title=feed.getTitle();  
  
      java.util.List entrl=feed.getEntries();  
      Object [] o=entrl.toArray();  
      numEntries=o.length;  
  
      entry=new FeedEntry[numEntries];  
      for(int i=0; i< numEntries; i++) {  
        entry[i]=new FeedEntry((SyndEntryImpl)o[i]);  
      }  
    }  
    catch(Exception e) {  
      println("Exception in Feedreader: "+e.toString());  
      e.printStackTrace();  
    }  
  }  
  
}  
  
class FeedEntry {  
  Date pubdate;  
  SyndEntryImpl entry;  
  String author, contents, description, url, title;  
  public String newline = System.getProperty("line.separator");  
  
  public FeedEntry(SyndEntryImpl _entry) {  
    try {  
      entry=_entry;  
      author=entry.getAuthor();  
      Object [] o=entry.getContents().toArray();  
      if(o.length>0) contents=((SyndContentImpl)o[0]).getValue();  
      else contents="[No content.]";  
  
      description=entry.getDescription().getValue();  
      if(description.charAt(0)==  
        System.getProperty("line.separator").charAt(0))  
          description=description.substring(1);  
  
      url=entry.getLink();  
      title=entry.getTitle();  
      pubdate=entry.getPublishedDate();  
    }  
    catch(Exception e) {  
      println("Exception in FeedEntry: "+e.toString());  
      e.printStackTrace();  
    }  
  
  }  
  
  //to catch or translate the message
  public String toString() {  
    String s;
    s = title  ; 
    return s;  
  }
} 
//////////////////
//OBJECT ROMANESCO
class Karaoke extends Romanesco {
  public Karaoke() {
    //from the index_objects.csv
    romanescoName = "Karaoke" ;
    IDobj = 4 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Stan LePunk";
    romanescoVersion = "Version 2.0";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
    romanescoMode = "" ; // separate the name by a slash and write the next mode immadialtly after this one.
    romanescoSlider = "Hue fill,Saturation fill,Brightness fill,Alpha fill,Size X,Canvas X,Canvas Y,Direction" ;
  }
  //GLOBAL
  int chapter, sentence ;
  
  //SETUP
  public void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
  }
  
  
  
  
  //DRAW
  public void display() {
    loadText(IDobj) ;
    
    float sizeFont = fontSizeObj[IDobj] ;
    
    textFont(font[IDobj], sizeFont + ( sizeFont *mix[IDobj]) *allBeats(IDobj) );
    // couleur du texte
    float t = alpha(fillObj[IDobj]) * abs(mix[IDobj]) ;
    if ( sound[IDobj] ) { t = alpha(fillObj[IDobj]) ; } 
    int c = color(hue(fillObj[IDobj]), saturation(fillObj[IDobj]), brightness(fillObj[IDobj]), t ) ;
    // security against the blavk bug opacity
    if (alpha(c) == 0 ) {
      noFill() ; 
      noStroke() ; 
    } else {     
      fill (c) ; 
    }
    
    //hauteur largeur, height & width
    float largeur = canvasXObj[IDobj] *15 ;
    float hauteur = canvasYObj[IDobj] *15 ;
    
    //tracking chapter
    String karaokeChapters [] = split(textImport[IDobj], "*") ;
    //security button
    if(action[IDobj] && nLongTouch ) {
      
      if (chapter > -1 && chapter < karaokeChapters.length  && nextPrevious && (leftTouch || rightTouch  )) {
        chapter = chapter + tracking(chapter, karaokeChapters.length ) ;
        sentence = 0 ; // reset to start the chapter at the begin, and display the first sentence
        trackerUpdate = 0 ;
      // to choice a texte with the keyboard number 1 to 10 the zero is ten
      } else if (nextPrevious && touch0 && karaokeChapters.length > 9 ) {
        chapter = 0 ;  sentence = 0 ;
      } else if (nextPrevious && touch9 && karaokeChapters.length > 8 ) {
        chapter = 9 ;  sentence = 0 ;
      } else if (nextPrevious && touch8 && karaokeChapters.length > 7 ) {
        chapter = 8 ;  sentence = 0 ;
      } else if (nextPrevious && touch7 && karaokeChapters.length > 6 ) {
        chapter = 7 ;  sentence = 0 ;
      } else if (nextPrevious && touch6 && karaokeChapters.length > 5 ) {
        chapter = 6 ;  sentence = 0 ;
      } else if (nextPrevious && touch5 && karaokeChapters.length > 4 ) {
        chapter = 5 ;  sentence = 0 ;
      } else if (nextPrevious && touch4 && karaokeChapters.length > 3 ) {
        chapter = 4 ;  sentence = 0 ;
      } else if (nextPrevious && touch3  && karaokeChapters.length > 2 ) {
        chapter = 3 ; sentence = 0 ;
      } else if (nextPrevious && touch2 && karaokeChapters.length > 1 ) {
        chapter = 2 ; sentence = 0 ;
      } else if (nextPrevious && touch1 && karaokeChapters.length > 0 ) {
        chapter = 1 ; sentence = 0 ;
      }
    }
    
    //tracking sentence
    if ( chapter < karaokeChapters.length) {
      String karaokeSentences [] = split(karaokeChapters[chapter], "/") ;
      if (sentence > -1 && sentence < karaokeSentences.length  && nextPrevious && (downTouch || upTouch) ) {
        sentence = sentence + tracking(sentence, karaokeSentences.length ) ;
        trackerUpdate = 0 ;
      }
      rotation(directionObj[IDobj], mouse[IDobj].x, mouse[IDobj].y) ;
      //DISPLAY
      textAlign(CORNER);
      textFont(font[IDobj], sizeFont+ (mix[IDobj]) *6 *beat[IDobj]);
      text(karaokeSentences[sentence], 0, 0, largeur, hauteur) ;
    }

  }
}
//end object one
class Orbital extends Romanesco {
 
  // Diameter max
  float r_min;
  float r_max;
 
  // Shape spreaded dimensions
  float spreadL;
  float spreadW;
 
  // Process
  PVector rfactors = new PVector();
  PVector rotation = new PVector();
  PVector rotationToReach = new PVector();
 
  // attributes
  int iterations;
  float offset;
  float rad;
  float vel;
  int dir;
  float smoothf;
  float initialForce;
 
  Flock_Orbital flock;
 
  public Orbital() {
    romanescoName = "Orbital" ;
    IDobj = 5 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Alexandre Petit";
    romanescoVersion = "Version 0.0.2";
    romanescoPack = "Workshop" ;
    romanescoMode = "" ; // separate the differentes mode by "/"
    /** 
    List of the available sliders
    "Hue fill,Saturation fill,Brightness fill,Alpha fill,Hue stroke,Saturation stroke,Brightness stroke,Alpha stroke,Thickness,
    Size X,Size Y,Size Z,Canvas X,Canvas Y,Canvas Z,Quantity,
    Speed,Direction,Angle,Amplitude,Analyze,Family,Life,Force" ; 
    */
    romanescoSlider = "Hue fill,Saturation fill,Brightness fill,Alpha fill,Hue stroke,Saturation stroke,Brightness stroke,Alpha stroke,Quantity,Speed" ;
  }
 
  // Main method
  // setup
  public void setting() {
    startPosition(IDobj, width/2, height/2, 0);
  
    flock = new Flock_Orbital();
  
    dir = 0;
    vel = radians(2);//radians(8);
    rad = 100;
    offset = 20;
    iterations = 16; // [!] iterations is binded to band. Do not go over 16 (band count) !!
    smoothf = .05f;
    initialForce = 10;
  
    r_max = max(width, height) * .8f;
    r_min = max(width, height) * .2f;
    resetOrbit();
  
  
  }
 
  // draw
  public void display() {
    // it's nice to code the variable from the sliders or from sound... here to see easily what's happen in your object.
    float quantity = quantityObj[IDobj] *2.f ;

    // display
    orbital_1(quantity) ;

    objectInfo[IDobj] = ("There is " + flock.size() + " orbital shape") ;
    

  }
 
  public void orbital_1(float quantity) {
    update(quantity);
    render();
  }
 
 
  public void update(float quantity) {
  
    checkControls();
  
    rotationToReach.x += rfactors.x * vel * speedObj[IDobj];
    rotationToReach.y += rfactors.y * vel * speedObj[IDobj];
    rotationToReach.z += rfactors.z * vel * speedObj[IDobj];
    rotation.x += (rotationToReach.x - rotation.x) * smoothf;
    rotation.y += (rotationToReach.y - rotation.y) * smoothf;
    rotation.z += (rotationToReach.z - rotation.z) * smoothf;
    normaliseRotation(); // keep values between 0 and 2PI // FIXME
  
  
    Boid_Orbital b;
    PVector force = new PVector(initialForce *kick[IDobj], 0, 0);
    int it = ceil(iterations *quantity);
    if(!fullRendering) it /= 10 ;
    println(it) ;
    float lSpreadL = 1 ;
    float lSpreadW = 1 ;
    for(int i = 0; i < it; i++) {
        if (sound[IDobj] && i < NUM_BANDS) {
            lSpreadL = spreadL * band[IDobj][i];
            lSpreadW = spreadW * band[IDobj][i];
        }
        b = new Boid_Orbital(offset + (float)i/iterations * (rad * mix[IDobj]), 0, 0, rotation, spreadW, lSpreadL);
        b.applyForce(force);
        flock.addBoid(b);
      
       
        rotation.mult(-1);
        b = new Boid_Orbital(offset + (float)i/iterations * (rad * mix[IDobj]), 0, 0, rotation, spreadW, lSpreadW);
        b.applyForce(force);
        flock.addBoid(b);
        rotation.mult(-1);
    }
  
    flock.update();
  }
 
  public void checkControls() {
     if      (rTouch && action[IDobj]) changeDir();
     else if (xTouch && action[IDobj]) randomDir();
     else if (nTouch && action[IDobj]) randomPos();
     // else if (jTouch) ;//randomiserad = D_MIN + random(D_MAX - D_MIN);
     else if (kTouch && action[IDobj]) resetOrbit();
     else if (jTouch && action[IDobj]) jump();
  }
 
  public void render() {
      //flock.render();
      flock.render(hue(fillObj[IDobj]),
                   saturation(fillObj[IDobj]),
                   brightness(fillObj[IDobj]),
                   alpha(fillObj[IDobj]),
                  
                   hue(strokeObj[IDobj]),
                   saturation(strokeObj[IDobj]),
                   brightness(strokeObj[IDobj]),
                   alpha(strokeObj[IDobj])
               );
                 
  }
 
  public void changeDir() {
    int aux;
    do aux = (int)random(3);
    while(aux == dir);
    dir = aux;
    // println("changeDir:"+dir);
  
    rfactors.set(0,0,0);
  
    switch(dir) {
      case 0 : rfactors.x = 1; break;
      case 1 : rfactors.y = 1; break;
      case 2 : rfactors.z = 1; break;
    }
  }
 
  public void randomDir() {
    rfactors.x = random(1);
    rfactors.y = random(1);
    rfactors.z = random(1);
  }
 
  public void randomPos() {
    rotationToReach.x = random(TWO_PI);
    rotationToReach.y = random(TWO_PI);
    rotationToReach.z = random(TWO_PI);
  }
 
  public void resetOrbit() {
     rotationToReach.set(0,0,0);
     rfactors.set(0,radians(90),0);
  }
 
  public void jump() {
    int amp = 30 ;
    rotationToReach.x = rotation.x;
    rotationToReach.y = rotation.y;
    rotationToReach.z = radians(random(-amp,amp));
  }
 
  // Normalise interpolation before value interpolation
  public void normaliseRotation() {
     rotation.x = radians(degrees(rotation.x));
     rotation.y = radians(degrees(rotation.y));
     rotation.z = radians(degrees(rotation.z));
  }
 
 
}


// ----------------------------------------------------------------------------------------------------------------------------------------
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Flock class
// Does very little, simply manages the ArrayList of all the boids

class Flock_Orbital {
  ArrayList<Boid_Orbital> list_boids_orbital; // An ArrayList for all the boids

  Flock_Orbital() {
      list_boids_orbital = new ArrayList<Boid_Orbital>(); // Initialize the ArrayList
  }

  public void update() {
  
      Boid_Orbital b;
      int size = list_boids_orbital.size();
      for(int i = size-1; i>=0; i--) {
          b = list_boids_orbital.get(i);
          if (b.isDead()) {
              list_boids_orbital.remove(i);
          } else {
              b.update();
          }
      }
  }
 
  public void render() {
     render(360,0,100,100, 360,0,100,100);
  }
 
  public void render(float fillH, float fillS, float fillB, float fillA, float strokeH, float strokeS, float strokeB, float strokeA) {
     for(Boid_Orbital b : list_boids_orbital) {
         pushMatrix();
         rotate(b.rotation.x, 1, 0, 0);
         rotate(b.rotation.y, 0, 1, 0);
         rotate(b.rotation.z, 0, 0, 1);
  
         b.render(fillH, fillS, fillB, fillA, strokeH, strokeS, strokeB, strokeA);  // Passing the entire list of boids to each boid individually
         popMatrix();
      }
  }

  public void addBoid(Boid_Orbital b) {
      list_boids_orbital.add(b);
  }


  public int size() {
    return list_boids_orbital.size();
  }
 
  public void clear() {
      list_boids_orbital.clear();
  }
}


// ---------------------------------------------------------------------------------------------------------------------------
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Boid class
// Methods for Separation, Cohesion, Alignment added

class Boid_Orbital {

  PVector location;
  PVector velocity;
  PVector acceleration;
 
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  float friction;    // Friction
 
  PVector rotation;
  PVector source;
 
  int lifetime;
  int life;
 
  
  float L = 20;
  float W = 1;
 
  Boid_Orbital(float x, float y, float z, PVector _rotation, float _w, float _l) {
    acceleration = new PVector(0,0,0);
    velocity = new PVector(0,0,0);
    location = new PVector(x,y,z);
    lifetime = 300;
    life = lifetime;
    rotation = _rotation.get();
    source = location.get();
    maxspeed = 30;
    maxforce = 4;
    friction = .97f;
  }

  // Method to update location
  public void update() {
  // Update velocity
    velocity.mult(friction);
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    location.add(velocity);
    // Reset accelertion to 0 each cycle
    acceleration.mult(0);
  
    --life;
  }
 
  public void render(float fillH, float fillS, float fillB, float fillA, float strokeH, float strokeS, float strokeB, float strokeA) {
  
    float theta = velocity.heading2D() + radians(90);
    float alphaAmt = processAlpha();
  
    if (fillA > 0) {
        fill(fillH, fillS, fillB, fillA * alphaAmt);
    } else {
        noFill();
    }
  
    if (strokeA > 0) {
        stroke(strokeH, strokeS, strokeB, strokeA * alphaAmt);
    } else {
        noStroke();
    }
  
    pushMatrix();
    translate(location.x,location.y, location.z);
    rotate(theta);
  
    //box(r);
    //sphere(r);
    if (W == L) {
        box(W);
    } else {
        beginShape(TRIANGLE_STRIP);
        vertex(-W, -L);
        vertex(-W,  L);
        vertex( W,  L);
        vertex( W, -L);
        endShape();
    }
  
    popMatrix();
  }

  public void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }
 
  public boolean isDead() {
     return life <= 0 || (acceleration.mag() + velocity.mag()) < 1;
  }
 
  public float processAlpha() {
     return (float)life/lifetime;
  }
}
ArrayList<Atom> atomList ;

//object one
class Atome extends Romanesco {
  public Atome() {
    //from the index_objects.csv
    romanescoName = "Atome" ;
    IDobj = 6 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "version 1.3.1";
    romanescoPack = "Base" ;
    romanescoRender = "P3D" ;
    romanescoMode = "Chemical Name/File text/Electronic cloud/Ellipse circle/Ellipse triangle/Ellipse cloud/Triangle circle/Triangle triangle/Triangle cloud/Rectangle rectangle/Rectangle cloud" ;
    romanescoSlider = "Hue fill,Saturation fill,Brightness fill,Alpha fill,Hue stroke,Saturation stroke,Brightness stroke,Alpha stroke,Thickness,Size X,Size Y,Size Z,Canvas X,Canvas Y,Speed,Direction,Family,Quantity,Amplitude,Angle" ;
  }
  
  //GLOBAL
  int KelvinUnivers  ; // Kelvin degree influent on the mouvement of the Atom, at 0\u00b0K there is no move !!! 273K\u00b0 give 273/Kelvin = 1.0 multi reference when the water became ice ! 
  int atomTemperature ;
  float pressure = 1.0f ; // Atmospheric pressure. "1" is earth reference
  // wall of screen
  float restitution = 0.5f ;

  float bottom =    restitution ;
  float top =       restitution ;
  float wallRight = restitution ;
  float wallLeft =  restitution ;

  //Molecule.Atom
  boolean cloud = true ; // To swith ON/OFF phycic of the cloud

  float atomX = 0 ; float atomY = 0 ;
  
  //beat var
  float beatSizeProton = 1 ;
  float beatThicknessCloud = 1 ;
  float beatSizeCloud = 1 ;
  // var for the beat range reactivity
  int rangeA = 0 , rangeB = 0, rangeC  =0  ;
  
  //direction of atome
  PVector newDirection ;
  
  // 3D mode for the objects
  boolean threeDimension ;
  

  
  
  //SETUP
  public void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
    
    atomList = new ArrayList<Atom>();
    
    //add one atom to the start
   PVector pos = new PVector (random(width), random(height), 0) ;
   PVector vel = new PVector ( random(-1, 1), random(-1, 1), random(-1, 1) ) ;
   int Z = 1 ; // 1 is the hydrogen ID, you can choice between 1 to 118 the last atom knew
   int ion = round(random(0,0));
   float rebound = 0.5f ;
   int diam = 5 ;
   int Kstart = PApplet.parseInt(abs( mix[IDobj]) *1000) ; // Temperature of Atom, influence the mouvement behavior
   //motion
   
   Atom atm = new Atom( pos, vel, Z, ion, rebound, diam,  Kstart) ; 
   atomList.add(atm) ;
   
  }
  //DRAW
  public void display() {
    // SETTING PARAMETER
    loadText(IDobj) ;
    // 3D or 2D
    if(parameter[IDobj] & dTouch) threeDimension = !threeDimension ;
    
    //speed
    float speed = (speedObj[IDobj] *100) *(speedObj[IDobj] *100) ;
    float velLimit = tempo[IDobj] *5.0f ; // max of speed Atom
    if (velLimit < 1.1f ) velLimit = 1.1f ;
    //the atom temperature give the speed 
    if(sound[IDobj]) atomTemperature =  floor(speed *tempo[IDobj]) ; else atomTemperature = round(speed) ;
    //ratio evolution for atom temperature...give an idea to change the speed of this one
    //because the temp of atom is linked with velocity of this one.
    float tempAbs = 10.0f ;
    
    //VELOCITY and DIRECTION of atom
    if(motion[IDobj]) {
      if(spaceTouch && action[IDobj]) {
        newDirection = new PVector (-pen[IDobj].x, -pen[IDobj].y ) ;
      } else { 
        newDirection = normalDir(PApplet.parseInt(directionObj[IDobj])) ;
      }
    } else {
      newDirection = new PVector () ;
    }
    
    PVector newVelocity = new PVector (sq(tempo[IDobj]) *1000.f, sq(tempo[IDobj]) *1000.f);
    //security if the value is null to don't stop the move
    float acceleration ; 
    if(pen[IDobj].z == 0 ) acceleration = 1.f ; else acceleration = pen[IDobj].z *1000.f ;
    
    
    PVector soundDirection = new PVector() ;
    if(sound[IDobj]) soundDirection = new PVector(right[IDobj], left[IDobj]) ; else soundDirection = new PVector(0, 0) ;

    float velocityX = newDirection.x *newVelocity.x *acceleration ;
    float velocityY = newDirection.y *newVelocity.y *acceleration ;
    PVector changeVelocity = new PVector (velocityX, velocityY) ;
    
    // FACTOR SOUND REACTIVITY
    float maxBeat = map(amplitudeObj[IDobj],0,1,1,15) ;
    beat[IDobj] = map(beat[IDobj],1,10, 1,maxBeat) ;
    kick[IDobj] = map(kick[IDobj],1,10, 1,maxBeat) ;
    snare[IDobj] = map(snare[IDobj],1,10, 1,maxBeat) ;
    hat[IDobj] = map(hat[IDobj],1,10, 1,maxBeat) ;
    
    // thickness
    float thickness = map(thicknessObj[IDobj],0, width/3, 0, width/20) ;
    
    // TEXT
    float sizeFont = fontSizeObj[IDobj] *1.5f ;
    PVector posText = new PVector ( 0.0f, 0.0f, 0.0f ) ;
    int sizeTextName = PApplet.parseInt(sizeFont) ;
    int sizeTextInfo = PApplet.parseInt(sizeFont *.5f) ;

    //Canvas
    PVector marge = new PVector(map(canvasXObj[IDobj], width/10, width, width/20, width *3) , map(canvasYObj[IDobj], height/10, height, height/20, height *3) ) ;
      
      
      
    
    // DISPLAY and UPDATE ATOM
    for (Atom atm : atomList) {
      // main method
      atm.update (atomTemperature, velLimit, changeVelocity, tempAbs, soundDirection) ; // obligation to use this void, in the atomic univers
      atm.covalentCollision (atomList);
      
      // SIZE
      float sizeAtomeRawX = map (sizeXObj[IDobj], .1f, width, .2f, width *.05f) ;
      float sizeAtomeRawY = map (sizeYObj[IDobj], .1f, width, .2f, width *.05f) ;
      float sizeAtomeRawZ = map (sizeZObj[IDobj], .1f, width, .2f, width *.05f) ;
      float sizeAtomeX = sizeAtomeRawX *beatSizeProton ;
      float sizeAtomeY = sizeAtomeRawY *beatSizeProton ;
      float sizeAtomeZ = sizeAtomeRawZ *beatSizeProton ;
      PVector sizeAtomeXYZ = new PVector(sizeAtomeX,sizeAtomeY,sizeAtomeZ) ;
      //diameter
      float factorSizeField = sizeAtomeX *1.2f ; // factor size of the electronic Atom's Cloud
       //width
      float posTextInfo = map(sizeYObj[IDobj], .1f, width,sizeAtomeRawX*.2f, width*.2f) + (beat[IDobj] *2.0f)  ;

    
      
      //DISPLAY
      //PARAMETER FROM ROMANESCO
      //the proton change the with the beat of music
      int max = 118 ;
      if( (nTouch && action[IDobj]) || rangeA == 0 ) {
        rangeA = round(random(0,max-80)) ;
        rangeB = round(random(rangeA,max-40)) ;
        rangeC = round(random(rangeB,max)) ;
      }
      

      if ( atm.getProton() < rangeA ) { 
        beatSizeProton = beat[IDobj] ;
      } else if ( atm.getProton() > rangeA && atm.getProton() < rangeB ) {
        beatSizeProton = kick[IDobj] ;
      } else if ( atm.getProton() > rangeB && atm.getProton() < rangeC ) {
        beatSizeProton = snare[IDobj] ;
      } else if ( atm.getProton()  > rangeC ) {
        beatSizeProton = hat[IDobj] ;
      }
      /////////////////CLOUD///////////////////////////////////////
      if ( atm.getProton() < 41 ) { 
        beatThicknessCloud = beat[IDobj] ;
      } else if ( atm.getProton() > 40 && atm.getProton() < 66 ) {
        beatThicknessCloud = kick[IDobj] ;
      } else if ( atm.getProton() > 65 && atm.getProton() < 91 ) {
        beatThicknessCloud = snare[IDobj] ;
      } else if ( atm.getProton()  > 90 ) {
        beatThicknessCloud = hat[IDobj] ;
      }

      

      //MODE OF DISPLAY
      //romanescoMode = "Chemical Name/File text/Electronic cloud/Ellipse schema/Ellipse cloud/Triangle schema/Triangle cloud/Rectangle schema/Rectangle cloud/Box schema/Box cloud/Sphere schema/Sphere cloud" ;
      if (mode[IDobj] == 0 || mode[IDobj] == 255 ) 
      atm.titleAtom2D (fillObj[IDobj], strokeObj[IDobj], font[IDobj], sizeTextName, sizeTextInfo, posTextInfo, angleObj[IDobj]) ; // (color name, color Info, PFont, int sizeTextName,int  sizeTextInfo )
      else if (mode[IDobj] == 1 ) { 
        atm.title2D(fillObj[IDobj], font[IDobj], sizeTextName, posText, angleObj[IDobj]) ;
      } else if (mode[IDobj] == 2 ) {
        atm.display("", "POINT", sizeAtomeXYZ, fillObj[IDobj], strokeObj[IDobj], thickness, angleObj[IDobj]) ;
      } else if (mode[IDobj] == 3 ) {
        if(threeDimension) atm.display("SPHERE", "ELLIPSE", sizeAtomeXYZ, fillObj[IDobj], strokeObj[IDobj], thickness, angleObj[IDobj]) ;
        else atm.display("ELLIPSE", "ELLIPSE", sizeAtomeXYZ, fillObj[IDobj], strokeObj[IDobj], thickness, angleObj[IDobj]) ;
      } else if (mode[IDobj] == 4 ) {
        if(threeDimension) atm.display("SPHERE", "TRIANGLE", sizeAtomeXYZ, fillObj[IDobj], strokeObj[IDobj], thickness, angleObj[IDobj]) ;
        else atm.display("ELLIPSE", "TRIANGLE", sizeAtomeXYZ, fillObj[IDobj], strokeObj[IDobj], thickness, angleObj[IDobj]) ;
      } else if (mode[IDobj] == 5 ) {
        if(threeDimension) atm.display("SPHERE", "POINT", sizeAtomeXYZ, fillObj[IDobj], strokeObj[IDobj], thickness, angleObj[IDobj]) ;
        else atm.display("ELLIPSE", "POINT", sizeAtomeXYZ, fillObj[IDobj], strokeObj[IDobj], thickness, angleObj[IDobj]) ;
      } else if (mode[IDobj] == 6 ) {
        if(threeDimension) atm.display("TETRA", "ELLIPSE", sizeAtomeXYZ, fillObj[IDobj], strokeObj[IDobj], thickness, angleObj[IDobj]) ;
        else atm.display("TRIANGLE", "ELLIPSE", sizeAtomeXYZ, fillObj[IDobj], strokeObj[IDobj], thickness, angleObj[IDobj]) ;
      } else if (mode[IDobj] == 7 ) {
        if(threeDimension) atm.display("TETRA", "TRIANGLE", sizeAtomeXYZ, fillObj[IDobj], strokeObj[IDobj], thickness, angleObj[IDobj]) ;
        else atm.display("TRIANGLE", "TRIANGLE", sizeAtomeXYZ, fillObj[IDobj], strokeObj[IDobj], thickness, angleObj[IDobj]) ;
      } else if (mode[IDobj] == 8 ) {
        if(threeDimension) atm.display("TETRA", "POINT", sizeAtomeXYZ, fillObj[IDobj], strokeObj[IDobj], thickness, angleObj[IDobj]) ;
        else atm.display("TRIANGLE", "POINT", sizeAtomeXYZ, fillObj[IDobj], strokeObj[IDobj], thickness, angleObj[IDobj]) ;
      } else if (mode[IDobj] == 9 ) {
        if(threeDimension) atm.display("BOX", "RECTANGLE", sizeAtomeXYZ, fillObj[IDobj], strokeObj[IDobj], thickness, angleObj[IDobj]) ;
        else atm.display("RECTANGLE", "RECTANGLE", sizeAtomeXYZ, fillObj[IDobj], strokeObj[IDobj], thickness, angleObj[IDobj]) ;
      } else if (mode[IDobj] == 10 ) {
        if(threeDimension) atm.display("BOX", "POINT", sizeAtomeXYZ, fillObj[IDobj], strokeObj[IDobj], thickness, angleObj[IDobj]) ;
        else atm.display("RECTANGLE", "POINT", sizeAtomeXYZ, fillObj[IDobj], strokeObj[IDobj], thickness, angleObj[IDobj]) ;
      }
 

      
      //UNIVERS
      ////////////////////////////////////////////////////////////////////////////////////////////
      atm.universWall2D( bottom, top, wallRight, wallLeft, false, marge) ; // obligation to use this void
      ////////////////////////////////////////////////////////////////////////////////////////////
    }
    
    // info display
    objectInfo[IDobj] = ("Atoms "+atomList.size()) ;
    

    //CLEAR
    if (resetAction(IDobj)) atomList.clear() ;
    //ADD ATOM
    int maxValueReproduction = 25 ;
    if(fullRendering) maxValueReproduction = 1 ; else maxValueReproduction = 25 ;
    int speedReproduction = round(map(quantityObj[IDobj],0, 1, 30, maxValueReproduction));
    if(action[IDobj] && nLongTouch && clickLongLeft[IDobj] && frameCount % speedReproduction == 0) atomAdd(giveNametoAtom(), startingPosition[IDobj]) ;
    
    if(atomList.size()<1) {
      int num = PApplet.parseInt(random(1,9)) ;
      for(int i = 0 ; i < num ; i++ ) {
        atomAdd(giveNametoAtom(), startingPosition[IDobj]) ;
      }
    }

  }
  //END DRAW
  /////////
  
  
  
  
  
  //ANNEXE
  
  //give name to the atom from the file.txt in the source repository
  public String giveNametoAtom() {
    String s = ("") ;
    int whichChapter = floor(random(numChapters(textImport[IDobj]))) ;
    int whichSentence = floor(random(numMaxSentencesByChapter(textImport[IDobj]))) ;
    //give a random name, is this one is null in the array, give the tittle name of text
    if(whichSentence(textImport[IDobj], whichChapter, whichSentence) != null ) s = whichSentence(textImport[IDobj], whichChapter, whichSentence) ; else s = whichSentence(textImport[IDobj], 0, 0) ;
    return s ;
  }
  

  //Add atom with a specific name
  public void atomAdd(String name, PVector newPos) {
    //data
    //amplitude
    //give the field of type of atome must be create
    float numP = map(familyObj[IDobj], 0,1,1,118) ; //
    int Z = PApplet.parseInt(random (1,numP)) ; // Z is the number of protons give the number of electrons max knew is 118
    int ion = round(random(0,0)); // number of electron(s) less(Anion)   more(Cation)   / give the magnetism & conductivity of the atome cannot be equal or sup to "Z"proton
    
    int Kstart = PApplet.parseInt(abs( mix[IDobj]) *1000) ; // Temperature of Atom, influence the mouvement behavior

    if (Kstart > 500 ) Kstart = 500 ;
    // physic action & display in the Univers
    float rebound = 0.5f ;
    int diam = 5 ;
    // Atom motion
    float startVel = 1.0f ;
    PVector posA = new PVector (mouse[0].x -newPos.x, mouse[0].y -newPos.y, 0.0f) ;
    PVector velA = new PVector (random(-startVel, startVel ), random(-startVel, startVel ), random(-startVel, startVel ) ) ;
    
    for (Atom atm : atomList) {
      if(atm.insideField()) return;
    }
    Atom atm = new Atom(name, posA, velA, Z, ion, rebound, diam,  Kstart) ; 
    atomList.add(atm) ;
  }

}



















///////////
//CLASS ATOM
class Atom {
  String [] nameAtom = { "Atom", "H",                                                                                                                                                                                         "He", 
                                 "Li", "Be",                                                                                                                                                 "B",  "C",   "N",   "O",  "F",   "Ne", 
                                 "Na", "Mg",                                                                                                                                                 "Al", "Si",  "P",   "S",  "Cl",  "Ar",
                                 "K",  "Ca",                                                                                     "Sc", "Ti", "V",  "Cr", "Mn", "Fe", "Co", "Ni", "Cu", "Zn", "Ga", "Ge",  "As",  "Se", "Br",  "Kr",
                                 "Rb", "Sr",                                                                                     "Y",  "Zr", "Nb", "Mo", "Tc", "Ru", "Rh", "Pd", "Ag", "Cd", "In", "Sn",  "Sb",  "Te", "I",   "Xe",
                                 "Cs", "Ba", "La", "Ce", "Pr", "Nd", "Pm", "Sm", "Eu", "Gd", "Tb", "Dy", "Ho", "Er", "Tm", "Yb", "Lu", "Hf", "Ta", "W",  "Re", "Os", "Ir", "Pt", "Au", "Hg", "Tl", "Pb",  "Bi",  "Po", "At",  "Rn",
                                 "Fr", "Ra", "Ac", "Th", "Pa", "U",  "Np", "Pu", "Am", "Cm", "Bk", "Cf", "Es", "Fm", "Md", "No", "Lr", "Rf", "Db", "Sg", "Bh", "Hs", "Mt", "Ds", "Rg", "Cn", "Uut", "Fl", "Uup", "Lv", "Uus", "Uuo"  } ;
  float [] Pauling = { 0.0f,      2.20f,                                                                                                                                                                                         0.00f, 
                                 0.98f, 1.57f,                                                                                                                                                 2.04f, 2.55f,  3.04f,  3.44f,  3.98f,  0.00f, 
                                 0.93f, 1.31f,                                                                                                                                                 1.61f, 1.90f,  2.19f,  2.58f,  3.16f,  0.00f,
                                 0.82f, 1.00f,                                                                                     1.36f, 1.54f, 1.63f, 1.66f, 1.55f, 1.83f, 1.88f, 1.91f, 1.90f, 1.65f, 1.81f, 2.01f,  2.18f,  2.55f,  2.96f,  0.00f,
                                 0.82f, 0.95f,                                                                                     1.22f, 1.33f, 1.60f, 2.16f, 2.10f, 2.20f, 2.28f, 2.20f, 1.93f, 1.69f, 1.78f, 1.96f,  2.05f,  2.10f,  2.66f,  2.60f,
                                 0.79f, 0.90f, 1.10f, 1.12f, 1.13f, 1.14f, 1.13f, 1.17f, 1.20f, 1.20f, 1.20f, 1.22f, 1.23f, 1.24f, 1.25f, 1.10f, 1.27f, 1.30f, 1.50f, 1.70f, 1.90f, 2.20f, 2.20f, 2.20f, 2.40f, 1.90f, 1.80f, 1.80f,  1.90f,  2.00f,  2.20f,  0.00f,
                                 0.70f, 0.90f, 1.10f, 1.30f, 1.50f, 1.70f, 1.30f, 1.30f, 1.30f, 1.30f, 1.30f, 1.30f, 1.30f, 1.30f, 1.30f, 1.30f, 1.30f, 0.00f, 0.00f, 0.00f, 0.00f, 0.00f, 0.00f, 0.00f, 0.00f, 0.00f, 0.00f, 0.00f,  0.00f,  0.00f,  0.00f,  0.00f  } ;
  
  Univers nvrs ;
  //Univers data
  float K_atom  ;
  float pressure = 1.0f ;  
  // Atom data
 ArrayList<Electron> listE; // list of electron for each Atom
  PVector pos ;    // position of the atom
  PVector vel ;    // velocity of the atom
  float diamAtom ;
  float mass, rebound ; // diameter and answer on the wall
  
  //Atomic property
  int  neutron, proton, electron, ion, valenceElectron, missingElectron, freeElectronicSpace ;
  int n = 1 ; // number of electronic shell
  int electronLayer = 0 ; // number of electronic shell
  float screenEffect = 1.0f  ; 
  float electroNegativity = 0.0f ; // Electronegativity of atom 

  float mgt ; // ionic load : give the magnetism atom
  float amplitudeElectrocField = 1.0f ; // default parameter of the amplitude of electronic field
  float ampInfo = 1.0f ; // default parameter of the amplitude of electronic field
  
  boolean insideA, insideF, lock, collision, cloud ;
  
  // Bond variable for link atom
  int freeBond ;
  int bondLink = 0 ; // number of link between two atoms (1 to 3 is useful )
  boolean bond ;
  boolean [] covalentBond = new boolean [9] ;
  boolean covalentBondLast = true, mole = false ;
 
  
  int inAtom = color (360,100,100) ; // blanc
  
  String c = "" ; // empty field to give the information of bond capacity of atom
  
  // give by default the title of the text import
  String nickName = ("ATOM") ;
 
  /////////////////////CONSTRUCTOR ATOM////////////////////////////////////////////////////////////////
  //simple constructor
  Atom  (PVector pos_, PVector vel_, float rebound_, int d_ ) {
    pos = pos_  ;
    vel = vel_  ;
    rebound = rebound_ ; 
    diamAtom = d_ ;
    mass = d_ ;
    // UNIVERS
    nvrs = new Univers() ;
  }
  //Atomic constructor  
  Atom (PVector pos_, PVector vel_, int proton_, int ion_, float rebound_,int d_, int Kelvin_ ) {
    pos = pos_  ;
    vel = vel_  ;
    proton = proton_;
    if (proton < 21 ) neutron = proton_ ;
    if (proton > 20 && proton < 103 ) neutron = round(proton_  * 1.765f) -20  ; // behind 20 proton, the quantity of neutron is more important than proton.
    if (proton > 102 && proton < 111 ) neutron = round(proton_ * 0.54f)  +102 ;
    if (proton > 110 && proton < 116 ) neutron = round(proton_ * 2.475f) -110 ;  
    if (proton > 115  ) neutron = round(proton_ * 0.53f) +115 ; 
    
    mass = proton + neutron ; ion = ion_ ;
    electroNegativity = Pauling[proton_] ; // Give the electroNagativity of Atom whith Pauling board
    rebound = rebound_ ; 
    diamAtom = d_ ;
    K_atom = Kelvin_ ;
    float Ka = Kelvin_ / 273.0f ;
     
    vel.x = vel.x * Ka ;
    vel.y = vel.y * Ka ;
    vel.z = vel.z * Ka ;
    
    listE = new ArrayList<Electron>();
    // UNIVERS
    nvrs = new Univers() ;
    // initialize the covalent level
    electronicCovalentBond() ;
  }
  
  //Atomic constructor with nickname  
  Atom (String name, PVector pos_, PVector vel_, int proton_, int ion_, float rebound_,int d_, int Kelvin_ ) {
    nickName = name ;
    pos = pos_  ;
    vel = vel_  ;
    proton = proton_;
    if (proton < 21 ) neutron = proton_ ;
    if (proton > 20 && proton < 103 ) neutron = round(proton_  * 1.765f) -20  ; // behind 20 proton, the quantity of neutron is more important than proton.
    if (proton > 102 && proton < 111 ) neutron = round(proton_ * 0.54f)  +102 ;
    if (proton > 110 && proton < 116 ) neutron = round(proton_ * 2.475f) -110 ;  
    if (proton > 115  ) neutron = round(proton_ * 0.53f) +115 ; 
    
    mass = proton + neutron ; ion = ion_ ;
    electroNegativity = Pauling[proton_] ; // Give the electroNagativity of Atom whith Pauling board
    rebound = rebound_ ; 
    diamAtom = d_ ;
    K_atom = Kelvin_ ;
    float Ka = Kelvin_ / 273.0f ;
     
    vel.x = vel.x * Ka ;
    vel.y = vel.y * Ka ;
    vel.z = vel.z * Ka ;
    
    listE = new ArrayList<Electron>();
    // UNIVERS
    nvrs = new Univers() ;
    // initialize the covalent level
    electronicCovalentBond() ;
  }
  
  
  
  
  //UPDATE
  // classic update
  public void update(float velLimit) { 
    vel.limit(velLimit) ;
    // if (!collision || listA.size() < 2 ) pos.add(vel) ;
    if (!collision ) pos.add(vel) ;
  }
  
  // update Atom
  public void update(int Kelvin_univers, float velLimit, PVector changeVel, float tempAbs, PVector jitterDirection) { 
    float jitterX = map(random(jitterDirection.x), 0, 1, -1, 1) ;
    float jitterY = map(random(jitterDirection.y), 0, 1, -1, 1) ;
    vel.x = changeVel.x *jitterX ;
    vel.y = changeVel.y *jitterY;
    
    //update atom temperature
    if (K_atom < Kelvin_univers ) K_atom += tempAbs ;
    if (K_atom > Kelvin_univers ) K_atom -= tempAbs ; 
    
    float Kfactor =  K_atom / 273.0f ;
    float pressureFactor = 1.0f / pressure ;
    vel.limit(velLimit *Kfactor *pressureFactor) ; // limit of velocity, the K\u00b0 is very important factor.
    
    // check if collision's void is true or not, if it's false the position is caculate here
    if (!collision ) pos.add(vel) ;
    
    // update electron 
    int eBond = 0 ;
    if (bond) eBond = 1 ;

    electron = proton + ion + eBond ;
    if (electron < 0 ) electron = 0 ; // keep the number of electron equal to zero or positive
    mgt = ion ;
   // update display capacity
   if ( covalentBond[1]  )  c = "height places";
   if (!covalentBond[1]  )  c = "seven places" ;
   if (!covalentBond[2]  )  c = "six places";
   if (!covalentBond[3]  )  c = "five places" ;
   if (!covalentBond[4]  )  c = "four places"  ;
   if (!covalentBond[5]  )  c = "three places" ;
   if (!covalentBond[6]  )  c = "two places" ;
   if (!covalentBond[7]  )  c = "one place" ;
   if (!covalentBondLast )  c = "full";   
  }
  

////////////////////////////////////COLLISION/////////////////////////////////////////////////////////adapted from Ira Greenberg///////////////
//////////////////////////COLLISION SIMPLE//////////////////////////////////////////////////////////
  public void collision(ArrayList<Atom> listA ) {
    collision = true ; // this boolean give the hand at this collison() void for update the velocity
    for (Atom target : listA) {
      if (target != this) {
        /////////////////////////\\\\\\\\\\\\\\\\\\\
        //:::::::::Code for angle collision::::::::::
        // get distances between the "atoms" components
        PVector atomVect = new PVector();
        atomVect.x = target.pos.x - pos.x;
        atomVect.y = target.pos.y - pos.y;
        ////////////////////////////////////////////
        if (collide(target, target.radius(), radius()) ) {
          contact(target, atomVect) ; 
        } else {
          noContact(target) ;
        }
      } 
    }
  }
  //::::::::::::::::::::::::Resolve Collision::::::::::::::::::::::::::::
  public void contact(Atom target , PVector atomVect)  {
    resolveCollision(target, atomVect) ;
  }
  //::::::::::::
  public void noContact (Atom target)  {
    // global code for collsion
    collision = false ; // this boolean give the control of the velocity to the update() void
  }
  
  
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////COVALENT COLLISION//////////////////////////////////////////////////
  public void covalentCollision(ArrayList<Atom> listA ) {
    for (Atom target : listA) {
      if (target != this) {    // don't collide with ourselves. that would be weird.
        /////////////////////////\\\\\\\\\\\\\\\\\\\
        //:::::::::Code for angle collision::::::::::
        // get distances between the "atoms" components
        PVector atomVect = new PVector();
        atomVect.x = target.pos.x - pos.x;
        atomVect.y = target.pos.y - pos.y;
        ////////////////////////////////////////////
        if (collide( target, target.radiusElectronicField(), radiusElectronicField() ) ) {
          contactCovalentEN(target, atomVect) ;
          if (collide( target, target.radiusElectronicFieldCovalent(), radiusElectronicFieldCovalent() ) ) {
            contactCovalent(target, atomVect) ;
            statementCovalent(target) ;
          } else {
            noContactCovalent () ;
          }     
        } else {
          noContactCovalent () ;
        }     
      }
    }
  }
  //::::::::::::::::::::::::Resolve Collision::::::::::::::::::::::::::::
  //COVALENT COLLISION ////// the result depend of the covalent number ///////////////////
  public void contactCovalentEN(Atom target, PVector atomVect)  {
    if (target.electroNegativity == 0 || electroNegativity == 0) {
      resolveCollision(target , atomVect) ;
    }
  }
   
   
  public void contactCovalent(Atom target, PVector atomVect)  {
    if (!target.covalentBondLast || !covalentBondLast ) {
      resolveCollision(target , atomVect) ;
      resolveCollision(target , atomVect) ;
    }  else {
      // new motion of atom when is lock together//
      float factorAddMotion = 2.0f ; // 2.0 is average motion factor
      PVector newVel = new PVector ( (vel.x + target.vel.x) /factorAddMotion , (vel.y + target.vel.y) /factorAddMotion ) ;
      target.vel = newVel ;
      vel  = newVel ;
    }
   }
   
   
   
  //::::::::::::
  public void statementCovalent(Atom target) {
    if(target.covalentBond[1] && covalentBondLast) freeBond = 0 ;
    if(!target.covalentBond[1])  freeBond = 1 ;
    if(!target.covalentBond[2])  freeBond = 2 ;
    if(!target.covalentBond[3])  freeBond = 3 ;
    if(!target.covalentBond[4])  freeBond = 4 ;
    if(!target.covalentBond[5])  freeBond = 5 ;
    if(!target.covalentBond[6])  freeBond = 6 ;
    if(!target.covalentBond[7])  freeBond = 7 ;
    if(!target.covalentBondLast) freeBond = 8 ;
    
    switch(freeBond) {
      case 0 : target.covalentBond[1]  = false ;
      break ;
      case 1 : target.covalentBond[2]  = false ;
      break ;
      case 2 : target.covalentBond[3]  = false ;
      break ;
      case 3 : target.covalentBond[4]  = false ;
      break ;
      case 4 : target.covalentBond[5]  = false ;
      break ;
      case 5 : target.covalentBond[6]  = false ;
      break ;
      case 6 : target.covalentBond[7]  = false ;
      break ;
      case 7 : target.covalentBondLast = false ;
      break ;
      
      case 8 : break ;
    }
  }
  //::::::::::::::::::::::
  
  public void noContactCovalent() { // internal
    collision = false ; // this boolean give the control of the velocity to the update() void
    //for the covalent collision
    electronicCovalentBond() ;
  }
  
  // Update the bond of each atom
  public void electronicCovalentBond() { // internal
    if (proton < 3 ) { 
      covalentBond[0] = true ;
      if (valenceElectron == 0 ) { covalentBond[1] = false ; covalentBondLast = false ;  }
      if (valenceElectron == 1 ) { covalentBond[1] = false ; covalentBondLast = true ; }
      if (valenceElectron == 2 ) { covalentBond[1] = false ; covalentBondLast = false ; }
    }
    if (proton > 2 ) {      
      covalentBond[0] = true ;
      //if (valenceElectron == 0 ) { covalentBond[1] = true ; covalentBond[2] = true ; covalentBond[3] = true ; covalentBond[4] = true ; covalentBond[5] = true ; covalentBond[6] = true ; covalentBond[7] = true ;  covalentBondLast = true ; }// height place, but is full
      if (valenceElectron == 0 ) { covalentBond[1] = false ; covalentBond[2] = false ; covalentBond[3] = false ; covalentBond[4] = false ; covalentBond[5] = false ; covalentBond[6] = false ; covalentBond[7] = false ;  covalentBondLast = false ; }// height place, but is full
      if (valenceElectron == 1 ) { covalentBond[1] = false ; covalentBond[2] = true  ; covalentBond[3] = true  ; covalentBond[4] = true  ; covalentBond[5] = true  ; covalentBond[6] = true  ; covalentBond[7] = true  ; covalentBondLast = true   ; }     // seven places
      if (valenceElectron == 2 ) { covalentBond[1] = false ; covalentBond[2] = false ; covalentBond[3] = true  ; covalentBond[4] = true  ; covalentBond[5] = true  ; covalentBond[6] = true  ; covalentBond[7] = true  ; covalentBondLast = true   ; }    // six places
      if (valenceElectron == 3 ) { covalentBond[1] = false ; covalentBond[2] = false ; covalentBond[3] = false ; covalentBond[4] = true  ; covalentBond[5] = true  ; covalentBond[6] = true  ; covalentBond[7] = true  ; covalentBondLast = true   ; }      // five places
      if (valenceElectron == 4 ) { covalentBond[1] = false ; covalentBond[2] = false ; covalentBond[3] = false ; covalentBond[4] = false ; covalentBond[5] = true  ; covalentBond[6] = true  ; covalentBond[7] = true  ; covalentBondLast = true   ; }     // four places
      if (valenceElectron == 5 ) { covalentBond[1] = false ; covalentBond[2] = false ; covalentBond[3] = false ; covalentBond[4] = false ; covalentBond[5] = false ; covalentBond[6] = true  ; covalentBond[7] = true  ; covalentBondLast = true   ; }    // three places
      if (valenceElectron == 6 ) { covalentBond[1] = false ; covalentBond[2] = false ; covalentBond[3] = false ; covalentBond[4] = false ; covalentBond[5] = false ; covalentBond[6] = false ; covalentBond[7] = true  ; covalentBondLast = true   ; }     // two places
      if (valenceElectron == 7 ) { covalentBond[1] = false ; covalentBond[2] = false ; covalentBond[3] = false ; covalentBond[4] = false ; covalentBond[5] = false ; covalentBond[6] = false ; covalentBond[7] = false ; covalentBondLast = true   ; } // else {  covalentBondLast = false ; }   // one place
      if (valenceElectron == 8 ) { covalentBond[1] = false ; covalentBond[2] = false ; covalentBond[3] = false ; covalentBond[4] = false ; covalentBond[5] = false ; covalentBond[6] = false ; covalentBond[7] = false ; covalentBondLast = false  ; } // no place
    }
  }
  
 
///////////////////////////////////////////////////////////////////////////////
////////////////////////IONIC COLLISION////////////////////////////////////////
//:::::::::::::::::::::::the result depend of the positiv or negativ atom load.
  public void electronicCollision(ArrayList<Atom> listA, boolean ionicEffect ) {
    for (Atom target : listA) {
      if(ionicEffect) {
        if ( target.ion != 0 && ion !=0 ) {
          if (target != this) {    // don't collide with ourselves. that would be weird.
            /////////////////////////\\\\\\\\\\\\\\\\\\\
            //:::::::::Code for angle collision::::::::::
            // get distances between the "atoms" components
            PVector atomVect = new PVector();
            atomVect.x = target.pos.x - pos.x;
            atomVect.y = target.pos.y - pos.y;
            ////////////////////////////////////////////
            if (fieldCollide( target, 
                              target.radius(),                 radius(), 
                              target.radiusElectronicField(),  radiusElectronicField() )) {
              contactElectronic(target) ; // when a collision is found, add it to a list for later use.
            }
          }
        }
      } else if (target != this ) {
                /////////////////////////\\\\\\\\\\\\\\\\\\\
        //:::::::::Code for angle collision::::::::::
        // get distances between the "atoms" components
        PVector atomVect = new PVector();
        atomVect.x = target.pos.x - pos.x;
        atomVect.y = target.pos.y - pos.y;
        ////////////////////////////////////////////
        if (collide(target, target.radiusElectronicField(),  radiusElectronicField())) {
          contact(target, atomVect) ;
        }
      }
    }
  }
  //////////IONIC CONTACT///with anion or cation, negative or positive atom load////////
  public void contactElectronic(Atom target)  {
    // listA_electronicCollision.add(target); // when a collision is found, add it to a list for later use.
    // float forceMgt = abs(ion) + abs(target.ion) ;
    
    if (target.ion < 0) target.ion = -1 ;
    if (target.ion > 0) target.ion =  1 ;
    if (ion < 0) ion = -1 ;
    if (ion > 0) ion =  1 ;
    
    int mgt = ion + target.ion ;
    
    if ( mgt != 0 ) {
      target.vel.x = -target.vel.x ;
      target.vel.y = -target.vel.y ;
    } else {
      PVector newVel = new PVector(target.pos.x - pos.x, target.pos.y - pos.y , target.pos.z - pos.z);
      target.vel.x = -newVel.x;
      target.vel.y = -newVel.y;
      vel.x = newVel.x ;
      vel.y = newVel.y ;
    }
  }
//////////////////////COLLISION GLOBALE VOID//////////////////////////////////
//////////////////////RESOLVE COLLISION/////////////////////////////////
  public void resolveCollision(Atom target , PVector atomVect) {
    if (target.vel.x == 0 ) target.vel.x = vel.x ; 
    if (target.vel.y == 0 ) target.vel.y = vel.y ;
    
    /////////////////////////\\\\\\\\\\\\\\\\\\\\\\
    //:::::::::Code for angle collision::::::::::::
    // calculate magnitude of the vector separating the atoms
    float theta  = atan2(atomVect.y, atomVect.x);
    // precalculate trig values
    float sinus = sin(theta);
    float cosinus = cos(theta);
  /* atomTemp will hold rotated ball positions. You 
    just need to worry about atomTemp[1] position*/
    Ref[] atomTemp = {  new Ref(), new Ref() } ;
       /* "target.atom's" position is relative to "atom's"
    so you can use the vector between them (atomVect) as the 
    reference point in the rotation expressions.
    atomTemp[0].x and atomTemp[0].y will initialize
    automatically to 0.0, which is what you want
    since "target.atom" will rotate around "atom" */
    atomTemp[1].x  = cosinus * atomVect.x + sinus * atomVect.y;
    atomTemp[1].y  = cosinus * atomVect.y - sinus * atomVect.x;
    
    // rotate Temporary velocities
    PVector[] velTemp = {  new PVector(), new PVector() };
    velTemp[0].x  = cosinus * vel.x + sinus * vel.y;
    velTemp[0].y  = cosinus * vel.y - sinus * vel.x;
    velTemp[1].x  = cosinus * target.vel.x + sinus * target.vel.y;
    velTemp[1].y  = cosinus * target.vel.y - sinus * target.vel.x;
    
    /* Now that velocities are rotated, you can use 1D
    conservation of momentum equations to calculate 
    the final velocity along the x-axis. */
    PVector[] velFinal = {  new PVector(), new PVector() };
    // final rotated velocity for b[0]
    velFinal[0].x = ((mass - target.mass) * velTemp[0].x + 2 * target.mass * velTemp[1].x) / (mass + target.mass);
    velFinal[0].y = velTemp[0].y;
    // final rotated velocity for b[1]
    velFinal[1].x = ((target.mass - mass) * velTemp[1].x + 2 * mass * velTemp[0].x) / (mass + target.mass);
    velFinal[1].y = velTemp[1].y;
    
    // hack to avoid clumping
    atomTemp[0].x += velFinal[0].x;
    atomTemp[1].x += velFinal[1].x;
    
    /* Rotate ball positions and velocities back
    Reverse signs in trig expressions to rotate 
    in the opposite direction */
    // rotate Atom
    Ref[] atomFinal = { new Ref(), new Ref() };
    atomFinal[0].x = cosinus * atomTemp[0].x - sinus * atomTemp[0].y;
    atomFinal[0].y = cosinus * atomTemp[0].y + sinus * atomTemp[0].x;
    atomFinal[1].x = cosinus * atomTemp[1].x - sinus * atomTemp[1].y;
    atomFinal[1].y = cosinus * atomTemp[1].y + sinus * atomTemp[1].x;
    
    // update atom to screen position
    target.pos.x = pos.x + atomFinal[1].x;
    target.pos.y = pos.y + atomFinal[1].y;
    pos.x += atomFinal[0].x;
    pos.y += atomFinal[0].y;
    // update velocities
    vel.x = cosinus * velFinal[0].x - sinus * velFinal[0].y;
    vel.y = cosinus * velFinal[0].y + sinus * velFinal[0].x;
    target.vel.x = cosinus * velFinal[1].x - sinus * velFinal[1].y;
    target.vel.y = cosinus * velFinal[1].y + sinus * velFinal[1].x;
  }
  //////////
  
 
  //ELECTRON
  // number of missing electron
 
  public void electronicInfo() {

    // give the period of the atom, the period is call "n"
    if (proton < 3 )                  { n = 1 ; }
    if (proton > 2 && proton < 11 )   { n = 2 ; }
    if (proton > 10 && proton < 19 )  { n = 3 ; }
    if (proton > 18 && proton < 37 )  { n = 4 ; }
    if (proton > 36 && proton < 55 )  { n = 5 ; }
    if (proton > 54 && proton < 87 )  { n = 6 ; }
    if (proton > 86 && proton < 119 ) { n = 7 ; }
    
    // maxE is max of electron by layer "n". 32 is limit of electron by layer, this law is strange because is different of the periodic layer max ?????
    int e = electron  -electronLayer ;
    int maxE = 0 ;
    int mE = 0 ;
    int newN = 1 ;
    // may be it's better to don't use a loop and give the maxE with the number "n" to liberate the computer of this calcul.
    for ( int i = 0 ; i < n ; i++ ) {
      mE = constrain(round( 2*sq(newN)), 0, 32) ;
      maxE += mE ;
      newN += 1 ;
    }
    missingElectron = maxE -e  ; 
    
    //Valence shell, give the number of free place to connect atoms together
    if (n == 1 ) valenceElectron = 2 - missingElectron ;
    if (n == 2 ) valenceElectron = 8 - missingElectron ;
    if (n == 3 ) valenceElectron = 8 - (missingElectron -10) ;
    if (n == 4 ) valenceElectron = 8 - (missingElectron -24) ;
    if (n == 5 ) valenceElectron = 8 - (missingElectron -6) ; 
    if (n == 6 ) valenceElectron = 8 - (missingElectron -6) ;
    if (n == 7 ) valenceElectron = 8 - (missingElectron -6) ;
    //exception with rule
    if (proton > 20 && proton < 28 ) valenceElectron = proton%9 ; 
    if (proton > 38 && proton < 46 ) valenceElectron = proton%9 ;
    
    if (proton > 27 && proton < 31 ) valenceElectron = (proton%9) -1 ; 
    if (proton > 45 && proton < 49 ) valenceElectron = (proton%9) -1 ;
    if (proton > 48 && proton < 55 ) valenceElectron = valenceElectron +32 ;  
    
    if (proton > 56 && proton < 72 )   valenceElectron = 3 ; // lanthanides
    if (proton > 71 && proton < 77 )   valenceElectron = valenceElectron +42 ;
    if (proton > 76 && proton < 87 )   valenceElectron = valenceElectron +32 ;  
    if (proton > 88 && proton < 104 )  valenceElectron = 3 ; // actinides
    if (proton > 103 && proton < 109 ) valenceElectron = valenceElectron +42 ;
    if (proton > 108 && proton < 119 ) valenceElectron = valenceElectron +32 ;  
    
    //exception without rule
    //if (proton == 2  ) valenceElectron = 8 ;
    if (proton == 77 || proton == 109 ) valenceElectron = 8 ;
    if (proton == 19 || proton == 37 || proton == 55 || proton == 87 ) valenceElectron = 1 ;
    if (proton == 20 || proton == 38 || proton == 56 || proton == 88 ) valenceElectron = 2 ;
    
     if ( valenceElectron == 0 ) valenceElectron = 8 ; 
    
    //::::::::
    // To give the energy of atom
    if (proton < 3 ) freeElectronicSpace = 2 - valenceElectron ;
    if (proton > 2 ) freeElectronicSpace = 8 - valenceElectron ; 
  
     // ScreenEffect = 13.6 / (sq(n)) *freeElectronicSpace ; 
     screenEffect = 13.6f / (sq(n)) ; 
   }


  //add electron
  // create a list, to show the electronic cloud
  public void addElectron() {
    int i ;
    Electron lctrn = new Electron();
    for ( i = 0 ; i < electron ; i++) {
      if (listE.size() < electron ) {
        listE.add(lctrn) ;
      }
    }
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  ////////////////////
  //DISPLAY
  public void display(String core, String cloud, PVector size, int colorFill, int colorStroke, float thickness, float orientation) {
    appearance(colorFill, colorStroke,thickness) ;
    //check size
    size.x *= diamAtom ;
    size.y *= diamAtom ;
    size.z *= diamAtom ;
    
    
    pushMatrix() ;
    translate(pos.x, pos.y) ;
    rotateX(radians(orientation)) ;
    // CORE
    if(core.equals("ELLIPSE")) coreEllipse(size) ;
    if(core.equals("RECTANGLE")) coreRect(size) ;
    if(core.equals("TRIANGLE")) coreTriangle(size) ;
    if(core.equals("SPHERE")) coreSphere(size) ;
    if(core.equals("BOX")) coreBox(size) ;
    if(core.equals("TETRA")) coreTetra(size) ;
    
    //CLOUD
    if(cloud.equals("ELLIPSE")) cloudEllipse(size.x *.2f) ;
    if(cloud.equals("RECTANGLE")) cloudRectangle(size.x *.2f) ;
    if(cloud.equals("TRIANGLE")) cloudTriangle(size.x *.2f) ;
    if(cloud.equals("POINT")) {
      // special appearance for the point because Processing use the stroke for the point
      stroke(colorFill) ;
      strokeWeight(thickness *2.f) ;
      cloudPoint(size.x *.2f) ;
      appearance(colorFill, colorStroke,thickness) ;
    }
    
    popMatrix() ;
    
  }
  
  

  // DISPLAY TEXT and MISC
  ////////////////////////
  // text from main program
  /*
  void title2D(String title, color cName, PFont p, int sizeText, PVector posText, float orientation) {
    if (alpha(cName) != 0 ) {
      fill(cName); textFont(p, sizeText);
      textAlign(CENTER);
      text(title , pos.x +posText.x , pos.y +posText.y );
    }
  }
  */
  public void title2D(int colorText, PFont p, int sizeText, PVector posText, float orientation) {
    if ( alpha(colorText) != 0 ) {
      fill(colorText); textFont(p, sizeText);
      textAlign(CENTER) ;
      
      pushMatrix() ;
      translate(pos.x, pos.y) ;
      rotateX(radians(orientation)) ;
      text(nickName ,posText.x,posText.y);
      popMatrix() ;
    }
  }
  /////////////////////DISPLAY PROPERTY of ATOM////////////////////////////////////////////
  public void titleAtom2D (int colorText, int colorInfo, PFont p, int sizeTextName, int sizeTextInfo, float amp_, float orientation) {
    ampInfo = amp_ ;
    float posXtext = (n *diamAtom *ampInfo) *0.35f ;
    float posYtext = sizeTextName *0.25f *(ampInfo/10.0f) ;
    pushMatrix() ;
    translate(pos.x, pos.y) ;
    rotateX(radians(orientation)) ;
      
    if ( alpha(colorText) != 0 ) {
      fill(colorText); textFont(p, sizeTextName);
      textAlign(CENTER);

      text(nameAtom[proton] ,0 , posYtext );
    }
    //Info
    if ( alpha(colorInfo) != 0 ) {
      fill(colorInfo); textFont(p, sizeTextInfo);
      textAlign (LEFT) ; 
      text(ion,              posXtext , -posYtext );
      text(valenceElectron,  posXtext ,  2.3f *posYtext);
      textAlign (RIGHT) ; 
      text(proton,           -posXtext , 2.3f *posYtext);
      text(round(mass),      -posXtext , -posYtext); 

    }
    popMatrix() ;
  } 
  
  
  
  
  
  // ANNEXE DISPLAY
  // CORE 2D
  public void coreTriangle(PVector size) {
    primitive(0,0,PApplet.parseInt(size.x),3) ;
  }
  public void coreEllipse(PVector size) {
    ellipse(0,0,size.x, size.y) ;
  }
  
  public void coreRect(PVector size) {
    rectMode(CENTER) ;
    rect(0,0,size.x, size.y) ;
    rectMode(CORNER) ;
  }
  
  // CORE 3D
  public void coreSphere(PVector size) {
    int minFace = 10 ;
    int maxFace = 25 ;
    sphere(size.x *.4f) ;
    int face ;
    face = PApplet.parseInt(size.x * .2f) ;
    if(face < minFace ) face = minFace; else if(face > maxFace ) face = maxFace ;
    sphereDetail(face) ;
  }
  
  public void coreBox(PVector size) {
    box(size.x, size.y, size.z) ;
  }
  
  public void  coreTetra(PVector size) {
    int diam = (int)size.x ;
    polyhedron("TETRAHEDRON", "VERTEX", diam) ;
  }
  
  
  
  
  //CLOUD 
  
  
  public void cloudEllipse(float newAmplitudeElectrocField) {
    electronicInfo() ;
    noFill() ;
    ellipse (0, 0, radiusElectronicFieldCovalent() *newAmplitudeElectrocField, radiusElectronicFieldCovalent() *newAmplitudeElectrocField ) ;
    ellipse (0, 0, radiusElectronicField() *newAmplitudeElectrocField,     radiusElectronicField() *newAmplitudeElectrocField ) ;
  }
  
  public void cloudRectangle(float newAmplitudeElectrocField) {
    electronicInfo() ;
    noFill() ;
    rect(0, 0, radiusElectronicFieldCovalent() *newAmplitudeElectrocField, radiusElectronicFieldCovalent() *newAmplitudeElectrocField ) ;
    rect(0, 0, radiusElectronicField() *newAmplitudeElectrocField,     radiusElectronicField() *newAmplitudeElectrocField ) ;
  }
  
  public void cloudTriangle(float newAmplitudeElectrocField) {
    electronicInfo() ;
    noFill() ; 
    primitive(0,0,PApplet.parseInt(radiusElectronicFieldCovalent() *newAmplitudeElectrocField),3) ;
    primitive(0,0,PApplet.parseInt(radiusElectronicField() *newAmplitudeElectrocField),3) ;
  }
  
  // CLOUD POINT
  public void cloudPoint(float newAmplitudeElectrocField) {
    addElectron() ;
    electronicInfo() ;
    cloud = true ;
    PVector posElectron = new PVector() ; 
    float ElectronicCloud = radiusElectronicField() *.5f *newAmplitudeElectrocField;
    
    //
    for (Electron electron : listE) {
      float randomEx = random( -ElectronicCloud, ElectronicCloud ) ;
      float randomEy = random( -ElectronicCloud, ElectronicCloud ) ;
      
      // check if the electron are in the diameter
      
      if (sqrt(sq(randomEx) + sq(randomEy)) > ElectronicCloud) {
        posElectron.x = -ElectronicCloud ;
        posElectron.y = -ElectronicCloud ;
      } else {
        
        posElectron.x = randomEx ;
        posElectron.y = randomEy ;
        point(posElectron.x,posElectron.y) ;
        // electron.displayPoint2D(posElectron, thickness, colorFill) ; 
      }
    }
  }
  // END DISPLAY
  //////////////
  

  /////////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////EXTERNAL INFLUENCE///////////////////////////////////////////////////
  // Wall border
  public void universWall2D(float restitutionBottom_, float restitutionTop_, float restitutionRight_, float restitutionLeft_, boolean wallOnOff_, PVector marge) {
    nvrs.physicWall2D(restitutionBottom_, restitutionTop_, restitutionRight_, restitutionLeft_, wallOnOff_) ;
    nvrs.wall2D(pos, vel, radius(), radiusElectronicField(), rebound, cloud, marge ) ;
  }  
  //

   
  ////////////////////////////////////////////////////////////////////////////////////////////////  
  //////////////////////////////////////RETURN///////////////////////////////////////////////////

  //////DETECT COLLISION\\\\\\\\\\\\\\\\\\\\\\\\\\\\
  // Detection the cursor is on the atom
  public boolean radiusCursor2D() {
    return dist(pos.x, pos.y, mouseX, mouseY) < radius();
  }
    // Detection the cursor is on the atom
  public boolean radiusElectronicFieldCursor2D() {
    return dist(pos.x, pos.y, mouseX, mouseY) < radiusElectronicField();
  }
  
  //:::::::::detect a collision with the other proton
  public boolean collide(Atom target, float targetRadius, float radius) {
    float distance = target.pos.dist(pos); // distance between our center and the other ball center
    float thresh = targetRadius + radius; // thresh is our radius plus their radius
    if (distance < thresh) { // if the distance is less than the threshold, we are colliding!
      return true;
    } else {
      return false;
    }
  }
  //:::::::::detect a collision in field around
  public boolean fieldCollide(Atom target, float targetRadiusMin, float radiusMin, float targetRadiusMax, float radiusMax) {  
    float distance = target.pos.dist(pos); // distance between our center and the other ball center
    float minThresh = targetRadiusMin + radiusMin; // thresh is our radius plus their radius
    float maxThresh = targetRadiusMax + radiusMax;
    if (distance > minThresh && distance < maxThresh) { // if the distance is in the field there is effect  
      return true;
    } else {
      return false;
    }
  }
  //////RETURN MISC\\\\\\\\\\\\\\\\\\\\\
  //:::::::::::::::return detection cursor
  public boolean inside() {
    if (insideA) return true ; else return false ;
  }
  //
  public boolean insideField() {
    if (insideF) return true ; else return false ;
  }
  //::::::::::::::::: Calculate the surface of Atom
  public float surface() {
    return  PI*sq(diamAtom/2) ;   
  }
  //:::::::::::::::RADIUS:::::::::::::::::::
  //:::::::::::::::Return the radius of atom
  public float radius() { 
    return diamAtom / 2;
  }
  //:::::::::::::::Return the radius of the atom's electronic field
  public float radiusElectronicField() { 
    float REF ;
    float base = 1.0f ;
    float ratioPeriodic = 1.0f ;
    float ratioSizeAtom = 1.0f ;
    int maxPos = 0 ; // max position of the atom in the line line of periodic border
    int posAtom = 0 ; // position of the atom in the periodic border
    if (n == 1 ) { base = 1.0f ;  ratioPeriodic = 1.7f  ; maxPos = 2  ; posAtom = abs( proton -2)   ;  }
    if (n == 2 ) { base = 1.22f ; ratioPeriodic = 4.41f ; maxPos = 8  ; posAtom = abs( proton -10)  ;  }
    if (n == 3 ) { base = 2.29f ; ratioPeriodic = 2.67f ; maxPos = 8  ; posAtom = abs( proton -18)  ;  }
    if (n == 4 ) { base = 2.83f ; ratioPeriodic = 2.76f ; maxPos = 18 ; posAtom = abs( proton -36)  ;  }
    if (n == 5 ) { base = 3.48f ; ratioPeriodic = 2.45f ; maxPos = 18 ; posAtom = abs( proton -54)  ;  }
    if (n == 6 ) { base = 3.87f ; ratioPeriodic = 2.48f ; maxPos = 32 ; posAtom = abs( proton -86)  ;  }
    if (n == 7 ) { base = 4.55f ; ratioPeriodic = 2.50f ; maxPos = 32 ; posAtom = abs( proton -118) ;  }
    
    float newPosAtom = norm( posAtom, 0.0f, maxPos -1 ) ;
    if (newPosAtom == 0 ) { ratioSizeAtom = newPosAtom ; } else { ratioSizeAtom = newPosAtom / ((3.0f - pow(newPosAtom, 5)  ) -newPosAtom) ; }
    
    ratioSizeAtom = 1 + ( ratioSizeAtom *ratioPeriodic *base ) ;
    
    REF = diamAtom *amplitudeElectrocField *ratioSizeAtom  ;
    return REF ;
  }
  //:::::::::::::::Return the radius of the atom's electronic valence bond field 
  public float radiusElectronicFieldCovalent() {
    float REFC ;
    float base = 1.0f ;
    float ratioPeriodic = 1.0f ;
    float ratioSizeAtom = 1.0f ;
    int maxPos = 0 ; // max position of the atom in the line line of periodic border
    int posAtom = 0 ; // position of the atom in the periodic border
    if (n == 1 ) { base = 1.0f ;  ratioPeriodic = 1.7f  ; maxPos = 2  ; posAtom = abs( proton -2)   ;  }
    if (n == 2 ) { base = 1.22f ; ratioPeriodic = 4.41f ; maxPos = 8  ; posAtom = abs( proton -10)  ;  }
    if (n == 3 ) { base = 2.29f ; ratioPeriodic = 2.67f ; maxPos = 8  ; posAtom = abs( proton -18)  ;  }
    if (n == 4 ) { base = 2.83f ; ratioPeriodic = 2.76f ; maxPos = 18 ; posAtom = abs( proton -36)  ;  }
    if (n == 5 ) { base = 3.48f ; ratioPeriodic = 2.45f ; maxPos = 18 ; posAtom = abs( proton -54)  ;  }
    if (n == 6 ) { base = 3.87f ; ratioPeriodic = 2.48f ; maxPos = 32 ; posAtom = abs( proton -86)  ;  }
    if (n == 7 ) { base = 4.55f ; ratioPeriodic = 2.50f ; maxPos = 32 ; posAtom = abs( proton -118) ;  }
    
    float newPosAtom = norm( posAtom, 0.0f, maxPos -1 ) ;
    if (newPosAtom == 0 ) ratioSizeAtom = newPosAtom ; else ratioSizeAtom = newPosAtom / ((3.0f - pow(newPosAtom, 5)  ) -newPosAtom) ; 
    
    ratioSizeAtom = 1 + ( ratioSizeAtom *ratioPeriodic *base ) ;
    
    REFC = diamAtom *amplitudeElectrocField *ratioSizeAtom *0.8f ;
    return REFC ;
  }

  //::::::::::::::ELECTRONIC INFO:::::::::::::::::::::::::::::
  //::::::::::::::Return the number Valence
  public int valenceE() {
    electronicInfo() ;
    return valenceElectron ;
  }
  //:::::::::Return the quantity of free place in the last electronic valence shell
  public int freeE() {
    electronicInfo() ;
    return freeElectronicSpace ;
  }
  //return the proton
  public int getProton() {
    return proton ;
  }
  
  
  
  
  
  
  
  // ANNEXE
  //Optional void atom

  public void drag2D() {
    //strokeWeight(d) ;
    insideA = radiusCursor2D() ;
    insideF = radiusElectronicFieldCursor2D() ;
    if(mousePressed && insideA) lock = true;
    if(!mousePressed)           lock = false;
    if (lock) { 
      pos.x = mouseX; 
      pos.y = mouseY;
    }
  }
  //:::::::drag Atom
  public void drag2D(float inertia) {
    //strokeWeight(d) ;
    insideA = radiusCursor2D() ;
    insideF = radiusElectronicFieldCursor2D() ;
    if( mousePressed && insideA) lock = true ;
    if(!mousePressed)            lock = false ;
    if (lock) { 
      pos.x = mouseX; 
      pos.y = mouseY;
      vel.x = (mouseX -pmouseX) * inertia; 
      vel.y = (mouseY -pmouseY) * inertia;
      if (vel.x == 0 && vel.y == 0 ) 
      {
        vel.x = random(-1,1) ;
        vel.x = random(-1,1) ;
      }   
    }
  }
  // END ANNEXE
  
}

// END CLASS ATOM
/////////////////









//////////////////////////
//SUPER CLASS ELECTRON to create a list of electron
class Electron {
  Electron() {}
}

///////////////////////////////////////////////////
//Special class creat like reference for the rotate
class Ref {
  float x, y;
  Ref() { }
}
/////////////






/////////
//UNIVERS
/////////
class Univers {
  PVector newPos ;
  PVector newVel ;
  // PVector mvt ;
  
 // float nx, ny ;
 // float mvtx, mvty ; 
  
  float r, restitutionBottom, restitutionTop , restitutionRight ,  restitutionLeft  ;
  boolean wallOnOff ;
  
  Univers() {
    newVel = new PVector (1 , 1, 1 ) ; 
  }
  /*
  Univers(float mvtx, float mvty)
  {
    mvtx_ = mvtx ; mvty_ = mvty ; 
  }
  */
  public void physicWall2D(float restitutionBottom_, float restitutionTop_, float restitutionRight_, float restitutionLeft_, boolean wallOnOff_ ) {
    restitutionTop    = restitutionTop_ ;  
    restitutionBottom = restitutionBottom_ ; 
    restitutionRight  = restitutionRight_ ;  
    restitutionLeft   = restitutionLeft_ ;
    wallOnOff = wallOnOff_ ;
  }
  
  //void wall(float x_, float y_, float z_, float w_, float h_, float mvtx_, float mvty_)
  public void wall2D(PVector pos, PVector vel,  float radiusProton, float radiusElectronicCloud, float rebond_, boolean cloud_, PVector marge ) {
    newPos = pos ;
    newVel = vel ;
    boolean cloud = cloud_ ;  
    if (!cloud ) {
      r = radiusProton ;
    } else {
      r = radiusElectronicCloud ;
    }
    
    //float renderTop = restitutionTop + rebond_ ;
    float renderBottom = restitutionBottom + rebond_ ;
    float renderRight = restitutionRight + rebond_ ;
    //float renderLeft = restitutionLeft + rebond_ ;
    //::::::WALL ON
    if ( wallOnOff ) {
      if (pos.x > -r +marge.x || pos.x < r -marge.x ) {
      newVel.x = -newVel.x *renderRight ;        
      } else if (pos.y > -r +marge.y ||pos.y < r -marge.y ) {
        newVel.y = -newVel.y *renderBottom ;    
      }
    }
    
    //::::::WALL OFF
    //wall right
    if ( !wallOnOff ) {
      if (pos.x > +r + marge.x ) {
        newPos.x = -r -marge.x;
        newVel.x *=+1 ;
        //wall left
      } else if (pos.x < -r -marge.x  ) {
        newPos.x = +r + marge.x;
        newVel.x *=+1 ;
        //ground  
      } else if (pos.y > +r + marge.y ) {
        newPos.y = -r -marge.y;
        newVel.x *=+1 ;
        //roof  
      } else if (pos.y < -r -marge.y ) {
        newPos.y =  +r +marge.y;
        newVel.x *=+1 ;
      }
    }
  }
}
//END UNIVERS
/////////////
CreatureManager creatureManager ;
boolean useBackdrop = false;

//object one
class Abbyss extends Romanesco {
  public Abbyss() {
    //from the index_objects.csv
    romanescoName = "The Abbyss" ;
    IDobj = 7 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Andreas Gysin";
    romanescoVersion = "version 2.1";
    romanescoPack = "Base" ;
    romanescoRender = "P3D" ;
    romanescoMode = "Box Fish/Cubus/Floater/Radio/Worm/Sea Fly/Breather/Spider/Manta/Father/Super Nova" ;// separate the name by a slash and write the next mode immadialtly after this one.
    romanescoSlider = "Hue fill,Saturation fill,Brightness fill,Alpha fill,Hue stroke,Saturation stroke,Brightness stroke,Alpha stroke,Thickness" ;
  }
  //GLOBAL
  
  //SETUP
  public void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
    creatureManager = new CreatureManager(callingClass);
  }
  //DRAW
  public void display() {
    if(alpha(strokeObj[IDobj]) == 0 ) thicknessObj[IDobj] = 0 ;
    creatureManager.loop(fillObj[IDobj], strokeObj[IDobj], thicknessObj[IDobj], speedObj[IDobj] *100.0f);
    
    
    
    
    //CHANGE MODE DISPLAY
    /////////////////////
    int whichCreature ; 
    if (mode[IDobj] == 0 || mode[IDobj] == 255 ) whichCreature = 0 ;
    else if (mode[IDobj] == 1 ) whichCreature = 1 ;
    else if (mode[IDobj] == 2 ) whichCreature = 2 ;
    else if (mode[IDobj] == 3 ) whichCreature = 3 ;
    else if (mode[IDobj] == 4 ) whichCreature = 4 ;
    else if (mode[IDobj] == 5 ) whichCreature = 5 ;
    else if (mode[IDobj] == 6 ) whichCreature = 6 ;
    else if (mode[IDobj] == 7 ) whichCreature = 7 ;
    else if (mode[IDobj] == 8 ) whichCreature = 8 ;
    else if (mode[IDobj] == 9 ) whichCreature = 9 ;
    else if (mode[IDobj] == 10 ) whichCreature = 10 ;
    else if (mode[IDobj] == 11 ) whichCreature = 11 ;
    else if (mode[IDobj] == 12 ) whichCreature = 12 ;
    else whichCreature = 0 ;
    
    if(action[IDobj]) {
      if (nLongTouch && frameCount % 3 == 0) creatureManager.addCurrentCreature(whichCreature);
      //to cennect the creature to the camera
      if(cLongTouch) {
        if (upTouch )    creatureManager.nextCameraCreature();
        else if (downTouch )  creatureManager.prevCameraCreature();
      }
    }
    //
    if (resetAction(IDobj)) creatureManager.killAll(whichCreature);
    
    // info display
    objectInfo[IDobj] = ("Creatures "+ creatureManager.creatures.size()) ;

  }
}
//end object one












class CreatureManager {
  private ArrayList<SuperCreature>creatures;
  private ArrayList<Class>creatureClasses;

  int currentCameraCreature =-1;
  PVector releasePoint;

  SuperCreature previewCreature;  
  PApplet parent;
  String infoText;

  // int currentCreature = -1;
  int currentCreature = 5; // the breather object is display when you start this object
  boolean showCreatureInfo = false;
  boolean showCreatureAxis = false;
  boolean showAbyssOrigin  = false;
  boolean showManagerInfo = false;
  //boolean highTextQuality = false;

  CreatureManager(PApplet parent) {
    this.parent = parent;
    releasePoint = PVector.random3D();
    releasePoint.mult(100);
    creatures = new ArrayList<SuperCreature>();

    creatureClasses = scanClasses(parent, "SuperCreature");
    if (creatureClasses.size() > 0) selectNextCreature();
  }

  private ArrayList<Class> scanClasses(PApplet parent, String superClassName) {
    ArrayList<Class> classes = new ArrayList<Class>();  
    infoText = "";
    Class[] c = parent.getClass().getDeclaredClasses();
    for (int i=0; i<c.length; i++) {
      if (c[i].getSuperclass() != null && (c[i].getSuperclass().getSimpleName().equals(superClassName) )) {
        classes.add(c[i]);
        int n = classes.size()-1;
        String numb = str(n);
        if (n < 10) numb = " " + n;
        infoText += numb + "         " + c[i].getSimpleName() + "\n";
      }
    }
    return classes;
  }

  public ArrayList<SuperCreature> getCreatures() {
    return creatures;
  }

  public SuperCreature addCreature( int i) {
    if (i < 0 || i >= creatureClasses.size()) return null;

    SuperCreature f = null;
    try {
      Class c = creatureClasses.get(i);
      Constructor[] constructors = c.getConstructors();
      f = (SuperCreature) constructors[0].newInstance(parent);
    } 

    catch (InvocationTargetException e) {
      System.out.println(e);
    } 
    catch (InstantiationException e) {
      System.out.println(e);
    } 
    catch (IllegalAccessException e) {
      System.out.println(e);
    } 

    if (f != null) {
      releasePoint = PVector.random3D();
      releasePoint.mult(100);
      addCreature(f);
    }
    return f;
  }

  private void addCreature(SuperCreature c) {
    c.setManagerReference(this);
    creatures.add(c);
    tellAllThatCreatureHasBeenAdded(c);
  }

  private void tellAllThatCreatureHasBeenAdded(SuperCreature cAdded) {
    for (SuperCreature c : creatures) {
      c.creatureHasBeenAdded(cAdded);
    }
  }

  public void killCreature(SuperCreature c) {
    c.kill();
  }

  public void killAll(int whichCreature) {
    creatures.clear();
    // TODO:
    // the previewCreature needs to get out from the main array 
    // to avoid code like this:
    currentCreature--;
    selectNextCreature(whichCreature);
  }

  public void killCreatureByName(String creatureName) {
    for (SuperCreature c : creatures) {
      String name = c.creatureName;
      if (creatureName.equals(name)) creatures.remove(creatures.indexOf(c));
    }
  }
  
  // main void
  public void loop(int colorIn, int colorOut, float thickness, float speed) {
    if (showAbyssOrigin) {
      noFill();
      stroke(255, 0, 0);
      repere(200) ;
    }
    if (previewCreature != null) {
      previewCreature.setPos(releasePoint);
      previewCreature.energy = 200.0f;
    }
    for (SuperCreature c : creatures) { 
      c.preDraw();
      c.move(speed);      
      c.draw(colorIn, colorOut, thickness);
      c.postDraw();
    }
    //
    cleanUp();
  }

  public void cleanUp() {
    //remove dead cratures
    Iterator<SuperCreature> itr = creatures.iterator();
    while (itr.hasNext ()) {
      SuperCreature c = itr.next();
      if (c.getEnergy() <= 0) itr.remove();
    }
  }
  
  //add random creature
  public void addRandomCreature() {
    int r = floor(random(creatureClasses.size()));
    addCreature(r);
  }

  
  
  //add creature
  public SuperCreature addCurrentCreature() {
    if (currentCreature != -1) {
      previewCreature = addCreature(currentCreature);
    }
    return previewCreature;
  }
    // add specific creature
  public SuperCreature addCurrentCreature(int which) {
    if (which != -1) {
      previewCreature = addCreature(which);
    }
    return previewCreature;
  }

  public void setCurrentCreature(int i) {
    currentCreature = i;  
    if (currentCreature < -1 || currentCreature > creatureClasses.size()) {
      currentCreature = -1;
    }
    if (currentCreature > -1) {
      if (previewCreature != null) {
        previewCreature.kill();
        previewCreature = null;
      }
      if (currentCreature > -1) {
        previewCreature = addCreature(currentCreature);
      } 
      else {
        if (previewCreature != null) previewCreature.kill();
        previewCreature = null;
      }
    }
    else {
      if (previewCreature != null) {
        previewCreature.kill();
        previewCreature = null;
      }
    }
  }
  
  public void selectNextCreature() {
    if (creatureClasses.size() > 0) {
      currentCreature = ++currentCreature % creatureClasses.size();     
      setCurrentCreature(currentCreature);
    }
  }
  // we use this function when we kill all creature to show by default the creature select by the dropdown
  public void selectNextCreature(int which) {
    if (creatureClasses.size() > 0) {
      // currentCreature = ++currentCreature % creatureClasses.size();     
      setCurrentCreature(which);
    }
  }

  public void selectPrevCreature() {
    if (creatureClasses.size() > 0) {
      currentCreature--;
      if (currentCreature < 0) currentCreature = creatureClasses.size()-1;
      setCurrentCreature(currentCreature);
    }
  }

  public void toggleManagerInfo() {
    showManagerInfo = !showManagerInfo;
  }

  public void toggleCreatureInfo() {
    showCreatureInfo = !showCreatureInfo;
  }

  public void toggleAbyssOrigin() {
    showAbyssOrigin = !showAbyssOrigin;
  }

  public void toggleCreatureAxis() {
    showCreatureAxis = !showCreatureAxis;
  }
  
  //CAMERA
  ///////
  public void prevCameraCreature() {
    if (creatures.size() > 0) {
      
      currentCameraCreature--;
      //security for the arraylist !
      if (currentCameraCreature < 0) currentCameraCreature = creatures.size()-1;
      travelling(creatures.get(currentCameraCreature).getPos()) ;
    } else {
      currentCameraCreature = -1;
    }
  }
  public void nextCameraCreature() {
    if (creatures.size() > 0) {
      
      currentCameraCreature = ++currentCameraCreature % creatures.size();
      travelling(creatures.get(currentCameraCreature).getPos()) ;
    } else {
      currentCameraCreature = -1;
    }
  }
  // END CAMERA
  
}
//END CREATURE MANAGER
/////////////////////


//SUPER CREATURE
////////////////
/**
 * The SuperCreature class
 * Every creature will extend this class.
 */
abstract class SuperCreature {
  protected PVector pos, rot, sca;
  private PVector projectedPos;
  public float energy ; 
  private float power;
  String creatureName, creatureAuthor, creatureVersion;
  //CreatureDate creatureDate;
  CreatureManager cm;

  public SuperCreature() {
    creatureName = "Unknown";
    creatureAuthor = "Anonymous";
    creatureVersion = "Alpha";

    //energy = 100.0;
    power = 0.02f;
    pos = new PVector();
    projectedPos = new PVector();
    rot = new PVector();
    sca = new PVector(1, 1, 1);
  }

  public void setManagerReference(CreatureManager cm) {
    this.cm = cm;
  }

  public abstract void move(float s);
  public abstract void draw(int cIn, int cOut, float t);

  //applies the default transforms... can be used as a shortcut
  public void applyTransforms() {
    translate(pos.x, pos.y, pos.z);
    rotateX(rot.x);
    rotateY(rot.y);
    rotateZ(rot.z);
    scale(sca.x, sca.y, sca.z);
  }

  private void preDraw() {
    energy = max(0, energy - power); //creatures with energy == 0 will be removed
    pushStyle();
    strokeWeight(1); //apparently a pushStyle bug?
    pushMatrix();     
    // transforms are handled by the creature 
    // this allows greater flexibility for example for particle based creatures 
    // which don't use matrix transforms
    // we don't pre-translate, rotate and scale:
    // translate(pos.x, pos.y, pos.z);
    // rotateX(rot.x);
    // rotateY(rot.y);
    // rotateZ(rot.z);
    // scale(sca.x, sca.y, sca.z);
  };  


  private void postDraw() {
    popMatrix(); 
    popStyle();
    projectedPos.x = screenX(pos.x, pos.y, pos.z);
    projectedPos.y = screenY(pos.x, pos.y, pos.z);
  };

  public PVector getPos() {
    return pos.copy();
  }

  public void setPos(PVector pos) {
    this.pos = pos.copy();
  }

  public void creatureHasBeenAdded(SuperCreature c) {
  }

  public SuperCreature getNearest() {
    return getNearest("");
  }

  public SuperCreature getNearest(String creatureName) {
    float d = MAX_FLOAT;
    SuperCreature nearest = null;
    for (SuperCreature c : cm.getCreatures()) {
      if (c != this && (c.creatureName != creatureName)) {
        PVector p = c.getPos();
        PVector m = PVector.sub(pos, p);
        float s = m.x * m.x + m.y * m.y + m.z * m.z;//m.mag();
        if (s < d) {
          d = s; 
          nearest = c;
        }
      }
    }
    return nearest;
  }



  public float getEnergy() {
    return energy;
  }

  public void kill() {
    energy = 0.0f;
  }
}
//END SUPERCREATURE










//CREATURE CATALOGUE
//BOXFISH
/**
 * A simple box-like fish.
 * Just swims around following it's heartbeat.
 */
class AGBoxFish extends SuperCreature {
  PMatrix3D mat;
  PVector dimBox, dimR, dimF;
  float fF, fR, aF, aR, fRot, aRot;
  float eye;
  float spd;

  public AGBoxFish() {
    creatureAuthor  = "Andreas Gysin";
    creatureName    = "BoxFish";
    creatureVersion = "Beta";
    //energy = 0 ;

    mat = new PMatrix3D();
    mat.rotateY(random(TWO_PI));
    mat.rotateZ(random(-0.1f, 0.1f));

    dimR = new PVector(random(10, 30), random(10, 30));
    dimF = new PVector(random(5, 50), random(5, 20));
    dimBox = new PVector(random(20, 80), random(20, 80), random(15, 40));
    fF = random(0.1f, 0.3f);
    aF = random(0.6f, 1.0f);
    fR = random(0.8f, 0.9f);
    aR = random(0.6f, 1.0f);
    fRot = fF;//random(0.05, 0.1);
    aRot = random(0.02f, 0.05f);
    spd = fRot * 10;
    eye = random(1, 3);
  }

  public void move(float speed) {
    float s = sin(frameCount *fRot);
    mat.rotateY(s * aRot + (noise(pos.z * 0.01f, frameCount * 0.01f) -0.5f) * 0.1f);
    mat.rotateZ(s * aRot * 0.3f);
    mat.translate(-spd, 0, 0);
    mat.mult(new PVector(), pos);
  }

  public void setPos(PVector p) {
    float[] a = mat.get(null);
    a[3] = p.x;
    a[7] = p.y;
    a[11] = p.z;
    mat.set(a);
  }

  public void draw(int colorIn, int colorOut, float thickness) {
    applyMatrix(mat);
    pushMatrix();
    sphereDetail(5);
    scale(min(getEnergy() * 0.1f, 1)); //it's possible to animate a dying creature...
    translate(dimBox.x/4, 0, 0);
    float f = sin(frameCount * fF) * aF;  
    float r = sin(frameCount * fR) * aR;
    //float h = sin(frameCount * fF * 0.5 + aF);
    //float a = map(h, -1, 1, 20, 100);  

    //noStroke();
    //fill(255,0,0 a);
    //float hr = dimBox.z * 0.15 + h * dimBox.z * 0.03;
    //sphere(hr/2);
    //sphere(hr);

    fill(colorIn);
    stroke(colorOut);
    strokeWeight(thickness) ;
    
    box(dimBox.x, dimBox.y, dimBox.z);

    pushMatrix();
    translate(-dimBox.x/2, dimBox.y/2, dimBox.z/2);
    rotateZ(HALF_PI);
    rotateY(f - 1);
    rect(0, 0, dimF.x, dimF.y);
    popMatrix();

    pushMatrix();
    translate(-dimBox.x/2, dimBox.y/2, -dimBox.z/2);
    rotateZ(HALF_PI);
    rotateY(-f + 1);
    rect(0, 0, dimF.x, dimF.y);
    popMatrix();

    pushMatrix();
    translate(dimBox.x/2, dimBox.y/2, dimBox.z/2);
    rotateY(r);
    rect(0, 0, dimR.x, dimR.y);
    popMatrix();

    pushMatrix();
    translate(dimBox.x/2, dimBox.y/2, -dimBox.z/2);
    rotateY(-r);
    rect(0, 0, dimR.x, dimR.y);
    popMatrix();
    //eye of the fish
    noStroke();
    fill(colorOut);
    pushMatrix();
    translate(-dimBox.x/2 + eye, dimBox.y/3, -dimBox.z/2);
    sphere(eye);
    translate(0, 0, dimBox.z);
    sphere(eye);
    popMatrix();

    popMatrix();
  }
}
//END BOXFISH

/**
 * A creature with four tentacles.
 * Floats it's life away in the Abyss.
 */
class AGCubus extends SuperCreature {
  PVector fPos, fAng;
  float cSize;
  int segments;
  float bLen;
  float aFreq;
  float bOffs;
  float angRange;

  public AGCubus() {
    creatureAuthor  = "Andreas Gysin";
    creatureName    = "Cubus";
    creatureVersion = "Beta";

    cSize = random(6, 30);
    fPos = new PVector(random(-0.002f, 0.002f), random(-0.002f, 0.002f), random(-0.002f, 0.002f));
    fAng = new PVector(random(-0.005f, 0.005f), random(-0.005f, 0.005f), random(-0.005f, 0.005f));
    
    segments = PApplet.parseInt(random(5,9));
    bLen = random(4, 10);
    aFreq = random(0.01f, 0.1f);
    bOffs = random(5);
    angRange = random(0.3f, 0.6f);
  }

  public void move(float speed) {
    pos.x += sin(frameCount *fPos.x);
    pos.y += sin(frameCount *fPos.y );
    pos.z += cos(frameCount *fPos.y);

    rot.x = sin(frameCount*fAng.x) * TWO_PI;
    rot.y = sin(frameCount*fAng.y) * TWO_PI;
    rot.z = sin(frameCount*fAng.z) * TWO_PI; 
  }

  public void draw(int colorIn, int colorOut, float thickness) {    
    applyTransforms(); //shortcut   
    fill(colorIn) ;
    stroke(colorOut);

    // the body
    strokeWeight(thickness);
    box(cSize); 
    
    //the four tentacles
    strokeWeight(thickness);
    for (int j=0; j<4; j++) {
      PVector p = new PVector(bLen, 0); 
      PVector pos = new PVector(cSize/2, 0); 
      float ang = sin(frameCount*aFreq + j%2 * bOffs) * angRange;
      float l = bLen;
      beginShape();
      for (int i=0; i<segments+1; i++) {
        vertex(pos.x, pos.y);
        pos.x += p.x;
        pos.y += p.y;
        p = rotateVec(p, ang);
        p.limit(l);
        l *= 0.93f; //scale a bit, this factor could also be randomized.
      }
      endShape();
      rotateY(HALF_PI);
    }
  }

  public PVector rotateVec(PVector v, float angle) {
    float c = cos(angle);
    float s = sin(angle);
    return new PVector(v.x*c - v.y*s, v.x*s + v.y*c);
  }    
}


/**
 * A floating fish.
 * Position is calculated with Perlin noise.
 */
class AGFloater extends SuperCreature {

  PMatrix3D mat;
  float offset;
  float ampBody, ampWing;
  float freqBody, freqWing;
  float wBody, hBody, wWing;
  float noiseScale, noiseOffset;
  float speedMin, speedMax;

  public AGFloater() {
    creatureAuthor  = "Andreas Gysin";
    creatureName    = "Floater";
    creatureVersion = "Beta";

    mat = new PMatrix3D();
    mat.rotateY(random(TWO_PI));
    mat.rotateZ(random(-0.2f, 0.2f));

    freqBody = random(0.1f, 0.2f);
    freqWing = freqBody;
    offset = 1.2f + random(-0.1f,0.2f);
    float s = 0.9f;
    ampBody = random(10, 30)*s;
    ampWing = random(0.6f, 1.2f)*s;
    wBody = random(20, 40)*s;
    hBody = random(30, 90)*s;
    wWing = random(20, 50)*s;
    speedMin = random(2.5f,3.5f)*s;
    speedMax = random(4.5f,5.5f)*s;
    
    noiseScale = 0.012f;
    noiseOffset = random(1); 
  }

  public void move(float speedValue) {
    mat.rotateY(map(noise(frameCount * noiseScale + noiseOffset), 0, 1, -0.1f, 0.1f));
    float speed = map(sin(frameCount * freqBody), -1, 1, speedMin , speedMax ); 
    mat.translate(0 , 0, speed);
    mat.mult(new PVector(), pos); //update the position vector
  }

  public void setPos(PVector p) {
    float[] a = mat.get(null);
    a[3] = p.x;
    a[7] = p.y;
    a[11] = p.z;
    mat.set(a);
  }

  public void draw(int colorIn, int colorOut, float thickness) {
    applyMatrix(mat);
    //stroke(255);
    stroke(colorOut);
    fill(colorIn);
    strokeWeight(thickness) ;
    rotateX(-HALF_PI);
    scale(min(getEnergy() * 0.1f, 1));

    float h1 = sin(frameCount * freqBody) * ampBody;
    float h2 = sin(frameCount * freqWing + offset) * ampWing;

    translate(0, 0, h1);
    rectMode(CENTER);
    rect(0, 0, wBody, hBody);

    rectMode(CORNER);
    pushMatrix();
    translate(-wBody/2, -hBody/2, 0);
    rotateY(PI - h2);
    rect(0, 0, wWing, hBody);
    popMatrix();

    pushMatrix();
    translate(wBody/2, -hBody/2, 0);
    rotateY(h2);
    rect(0, 0, wWing, hBody);
    popMatrix();
  }
}



/**
 * An attempt of a radiolaria-like creature.
 * Uses vertex colors for gradients.
 */
class AGRadio extends SuperCreature {

  PVector pVel, rVel;
  int num, spikes;
  float freq;
  float rad, rFact;

  public AGRadio() {
    creatureAuthor  = "Andreas Gysin";
    creatureName    = "Radio";
    creatureVersion = "Alpha";

    pVel = new PVector( random(-1, 1), random(-1, 1), random(-1, 1) );
    rVel = new PVector( random(-0.01f, 0.01f), random(-0.01f, 0.01f), random(-0.01f, 0.01f) );
    num = round(random(20, 100));
    spikes = ceil(random(3, 12));
    freq = random(0.02f, 0.06f);
    rad = random(30, 60);
    rFact = random(0.2f, 0.4f);
  }

  public void move(float speed) {
    pos.add(pVel); 
    rot.add(rVel);  
    applyTransforms();
  }

  public void draw(int colorIn, int colorOut, float thickness) {  
    stroke(colorOut);
    fill(colorIn);
    strokeWeight(thickness);
    hint(DISABLE_DEPTH_TEST); 
    float arc = TWO_PI / num;    
    float f = frameCount * freq;
    float a = arc * spikes;
    beginShape(QUAD_STRIP);
    for (int i=0; i<num+1; i++) { 
      int j = i % num;
      float len = (sin(f + a * j)) * 0.2f;
      float c = cos(arc * j); 
      float s = sin(arc * j);
      float x = c * (rad + len * rad);
      float y = s * (rad + len * rad);
      float z = len * rad;
      fill(hue(colorIn), saturation(colorIn), brightness(colorIn), i % 2 * alpha(colorIn)  ); 
      vertex(x*rFact, y*rFact, z);
      fill(255, 0); 
      vertex(x, y, 0);
    }
    endShape();
    hint(ENABLE_DEPTH_TEST);
  }
}




/**
 * An example creature with simple spring and node classes.
 * Moves randomly trough the deep waters in search for meaning.
 */
class AGWorm extends SuperCreature {
  ArrayList<Node> nodes;
  ArrayList<Spring> springs;

  PVector dest;
  float nervosismo;
  float radius;
  float rSpeed, rDamp;
  float freq1, freq2;

  public AGWorm() {
    creatureAuthor = "Andreas Gysin";
    creatureName = "El Worm";
    creatureVersion = "Alpha";

    int num = PApplet.parseInt(random(7,22));
    float len = random(2, 15);
    float damp = random(0.85f, 0.95f);
    float k = random(0.15f,0.3f);
    radius = random(1.5f, 2.5f);   
    rSpeed = random(50,150);
    rDamp = random(0.005f, 0.02f);
    nervosismo = random(0.01f, 0.3f);
    freq1 = random(0.05f, 0.2f);
    freq2 = random(0.08f, 1.1f);

    nodes = new ArrayList<Node>();

    springs = new ArrayList<Spring>();
    for (int i=0; i<num; i++) {
      PVector p = PVector.add(pos, new PVector(random(-1,1),random(-1,1),random(-1,1)));
      Node n = new Node(p, damp);
      nodes.add(n);
    }
    
    for (int i=0; i<num-1; i++) {
      Spring s = new Spring(nodes.get(i), nodes.get(i+1), len, k);
      springs.add(s);
    }
    
    dest = new PVector();
  }

  public void move(float speed) {
    if (random(1) < nervosismo) {
      dest.add(new PVector(random(-rSpeed,rSpeed),random(-rSpeed,rSpeed),random(-rSpeed,rSpeed)));
    }
    pos.x += (dest.x - pos.x) * rDamp;
    pos.y += (dest.y - pos.y) * rDamp;
    pos.z += (dest.z - pos.z) * rDamp;
    nodes.get(0).setPos(pos);
    for (Spring s : springs) s.step();
    for (Node n : nodes) n.step();
  }

  public void draw(int colorIn, int colorOut, float thickness) {
    fill(colorIn);
    stroke(colorOut);
    strokeWeight(thickness) ;
    for (Spring s : springs) {
      line(s.a.x, s.a.y, s.a.z, s.b.x, s.b.y, s.b.z);
    }

    int i=0;
    //noStroke();
    sphereDetail(3);
    //fill(colorIn);  
    float baseFreq = frameCount * freq1;
    for (Node n : nodes) {
      float d = map( sin(baseFreq - i*freq2), -1, 1, radius, radius * 2);
      pushMatrix();
      translate(n.x, n.y, n.z);
      //if ((i + frameCount/5) % 4 == 0) d *= 0.5;
      sphere(d);      
      popMatrix();
      i++;
    }
  }

  class Node extends PVector {

    float damp;
    PVector vel;

    Node(PVector v, float damp) {
      super(v.x, v.y, v.z);
      this.damp = damp;
      vel = new PVector();
    }

    public void step() {
      add(vel);
      vel.mult(damp);
    }

    public void applyForce(PVector f) {
      vel.add(f);
    }

    public void setPos(PVector p) {
      this.x = p.x;
      this.y = p.y;
      this.z = p.z;
      vel = new PVector();
    }
  }
  
  class Spring {
    float len;
    float scaler;
    Node a, b;

    Spring(Node a, Node b, float len, float scaler) {
      this.a = a;
      this.b = b;
      this.len = len;
      this.scaler = scaler;
    }

    public void step() {

      PVector v = PVector.sub(b, a);
      float m = (v.mag() - len) / 2 * scaler;
      v.normalize();

      v.mult(m);    
      a.applyForce(v);

      v.mult(-1);    
      b.applyForce(v);
    }
  }
}



//SEA FLY
class EPSeaFly extends SuperCreature {

  PVector freqMulPos, freqMulAng;
  int count;

  public EPSeaFly() {
    creatureName = "EPSeaFly";
    creatureAuthor = "Edoardo Parini";
    creatureVersion = "1.0";

    freqMulPos = new PVector();
    freqMulPos.x = random(-0.002f, 0.002f); 
    freqMulPos.y = random(-0.002f, 0.002f); 
    freqMulPos.z = random(-0.002f, 0.002f);

    freqMulAng = new PVector();
    freqMulAng.x = random(-0.005f, 0.005f); 
    freqMulAng.y = random(-0.005f, 0.005f); 
    freqMulAng.z = random(-0.005f, 0.005f);
  }

  public void move(float speed) {
    count++;
    pos.x += sin(count *freqMulPos.x);
    pos.y += sin(count *freqMulPos.y);
    pos.z += cos(count *freqMulPos.y);

    rot.x = sin(count*freqMulAng.x) * TWO_PI;
    rot.y = sin(count*freqMulAng.y) * TWO_PI;
    rot.z = sin(count*freqMulAng.z) * TWO_PI;
    
    applyTransforms();
  }

  public void draw(int colorIn, int colorOut, float thickness) {

    stroke(colorOut);
    fill(colorIn); 
    strokeWeight(thickness) ; 
    // float dimR = 20;
    // float dimF = 10;  

    scale(0.2f);
    translate(count * 0.018f, count * 0.008f); 
    rotateX(count * 0.008f);

    PVector dim = new PVector(100, 60, 30);
    sphereDetail(3); 
    sphere(25);

    float aF = sin(count * 0.15f) * 0.8f;  
    float aR = sin(count * 0.25f) * 0.8f;

    pushMatrix();                            
    translate(-dim.x/2, dim.y/2, dim.z/2);
    rotateZ(aF/2 + 1.2f);
    rotateY(aF - 1);
    fill(hue(colorIn), saturation(colorIn), brightness(colorIn),alpha(colorIn)*.3f);
    quad(0, 0, 86, 20, 69, 63, 30, 76);
    noFill();
    quad(0, 0, 96, 23, 79, 73, 40, 86);
    popMatrix();

    pushMatrix();                          
    translate(-dim.x/2, dim.y/2, -dim.z/2);
    rotateZ(aF/2 + 1.2f);
    rotateY(-aF + 1);
    fill(hue(colorIn), saturation(colorIn), brightness(colorIn),alpha(colorIn)*.3f);
    quad(0, 0, 86, 20, 69, 63, 30, 76);
    noFill();
    quad(0, 0, 96, 23, 79, 73, 40, 86);
    popMatrix();

    pushMatrix();                          
    translate(dim.x/2, dim.y/2, dim.z/2);
    rotateY(aR);
    quad(0, 0, 96, 23, 79, 73, 40, 86);
    fill(hue(colorIn), saturation(colorIn), brightness(colorIn),alpha(colorIn)*.3f);
    quad(0, 0, 86, 20, 69, 63, 30, 76);
    popMatrix();

    pushMatrix();                  
    translate(dim.x/2, dim.y/2, -dim.z/2);
    rotateY(-aR);
    quad(0, 0, 86, 20, 69, 63, 30, 76);
    noFill();
    quad(0, 0, 96, 23, 79, 73, 40, 86);
    popMatrix();
  }
}






//BREATHER
class FFBreather extends SuperCreature {

  PVector oldPosition;
  PVector acc = new PVector(0,0);
  float xoff = 0.1f, yoff = 10.45f;
  float xadd = 0.001f, yadd = 0.005f;
  float xNoise = 0, yNoise = 0;
  PVector inside = new PVector(0,0);
  PVector center = new PVector(0,0);
  float sizeIt = 0, addSizeIt = 00.01f;
  float sizeItCos, breath, breathoff, breathadd;
  PVector one,two,three, len, newCenter;
  ArrayList<PVector >points  = new ArrayList <PVector>();
  float start = 0.0f;
  
  PVector rVel, pVel;

  int creatureSize, creatureWidth, realCreatureSize;
  float moveAroundCircle;

  public FFBreather() {
    creatureName = "The Breather";
    creatureAuthor = "Fabian Frei";
    creatureVersion = "1";
    
    randomStart();

    // math the shit out of it
    for(int i = 0;i < realCreatureSize;i++)
    {
      points.add(new PVector(cos(start)*creatureWidth,sin(start)*creatureWidth) );
      start += moveAroundCircle;
    }
  }

  public void randomStart() 
  {
    creatureSize = (int)random(3,11);
    if(creatureSize%2 != 0)
    {
      creatureSize++;
    }
    realCreatureSize = 3*creatureSize;
    creatureWidth = (int)random(10,100);
    moveAroundCircle = TWO_PI/realCreatureSize;

    pos = new PVector(random(0,width),random(0,height));
    oldPosition = pos;

    sizeIt = 0;
    addSizeIt = random(0.001f,0.1f);
    breathoff = random(0.001f,0.01f);
    breathadd = random(0.0001f,0.001f);
    xoff = random(0.001f,0.1f);
    yoff = random(10,100);
    xadd = random(0.00001f,0.01f);
    yadd = random(0.00001f, 0.01f);

     pVel = PVector.random3D();
    rVel = PVector.random3D();
    rVel.mult(random(0.01f, 0.03f));
    float s = random(0.5f, 1);
    sca.set(s,s,s);
  }


  public void move(float speed) {
    breath = noise(breathoff);
    breathoff += breathadd;

    sizeItCos = map(cos(sizeIt),-1,1,breath,1);
    sizeIt = sizeIt + addSizeIt;

    pos.add(pVel); 
    rot.add(rVel);  
    applyTransforms();
  }


  public void draw(int colorIn, int colorOut, float thickness) {
    stroke(colorOut);
    fill(colorIn);
    strokeWeight(thickness) ;

    for(int i = 0; i < points.size()-1;i+=2)
    {
      one = points.get(i);
      two =  points.get(i+1);

      if( i+2 < points.size() )
      {
        three = points.get(i+2);
      } 
      else {
        three = points.get(0);
      }

      len = PVector.sub(center,two);
      newCenter = PVector.add(PVector.mult(len,sizeItCos),two);

      beginShape(); 
      vertex(one.x,one.y,0);
      vertex(newCenter.x,newCenter.y,15+breath*75);
      vertex(three.x,three.y,0);
      endShape(CLOSE);
    }
  }
}




//HUBERT alias Spider
class LPHubert extends SuperCreature {

  PVector freqMulPos, freqMulAng;
  int num;
  int count;
  
  float cSize;
  float bLen;
  float aFreq;
  float bOffs;
  float angRange;
  float angT, scaR;

  int numberT, numberSeg, elSize, val2div;

  boolean isAngry = false;

  public LPHubert() {
    creatureAuthor ="Laura Perrenoud";
    creatureName ="Hubert";
    creatureVersion ="1.0";

    //////////////Mouvement al\u00e9toire
    freqMulPos = new PVector();
    freqMulPos.x = random(-0.002f, 0.002f); 
    freqMulPos.y = random(-0.002f, 0.002f); 
    freqMulPos.z = random(-0.002f, 0.002f);

    freqMulAng = new PVector();
    freqMulAng.x = random(-0.005f, 0.005f); 
    freqMulAng.y = random(-0.005f, 0.005f); 
    freqMulAng.z = random(-0.005f, 0.005f);
    /////////////////

    ///////////////Cr\u00e9ature random
    num = 10;
    cSize = random(6, 30);
    bLen = random(5, 15);
    aFreq = random(0.01f, 0.02f);
    bOffs = random(5);
    angRange = random(0.3f, 0.6f);
    numberT = PApplet.parseInt(random(3, 20));
    numberSeg = PApplet.parseInt(random(3, 7));
    elSize = 5;
    val2div = PApplet.parseInt(random(1, 3));
    scaR = (random(0.3f, 1.52f));
    sca.x = scaR;
    sca.y = scaR;
    sca.z = scaR;
    ////////////////
  }

  public void move(float speed) {
    count++;
    ////////////////
    pos.x += sin(count *freqMulPos.x);
    pos.y += sin(count *freqMulPos.y);
    pos.z += sin(count *freqMulPos.z);

    rot.x = sin(count*freqMulAng.x) * TWO_PI;
    rot.y = sin(count*freqMulAng.y) * TWO_PI;
    rot.z = sin(count*freqMulAng.z) * TWO_PI;

    applyTransforms();

  }

  public void draw(int colorIn, int colorOut, float thickness) {

    strokeWeight(thickness);
    fill(colorIn);
    stroke(colorOut);
    float val2 = sin(count*aFreq*3)*2;
    
    float a1 = sin(count*aFreq + bOffs) * angRange;
    float a2 = sin(count*aFreq) * angRange;

    for (int j=0; j<numberT; j++) {

      PVector p = new PVector(bLen, 0); 
      PVector pos = new PVector(cSize/6, 0); 
      float ang = (j % 2 == 0) ? a1 : a2;
      float l = bLen;

      for (int i=0; i<numberSeg; i++) {
        if (i<numberSeg-2) {
          pushMatrix();
          translate(pos.x + p.x, pos.y + p.y, 0);
          box(3+val2);
          popMatrix();
        }

        line(pos.x, pos.y, pos.x + p.x, pos.y + p.y);
        pos.x += p.x;
        pos.y += p.y;
        p = rotateVec(p, ang+(val2 * 0.1f));
        p.limit(l);
        l *= 0.99f;
        //l *= 0.93;
      }
      rotateY(PI*2/numberT);
    }
  }

  public PVector rotateVec(PVector v, float angle) {
    float c = cos(angle);
    float s = sin(angle);
    return new PVector(v.x*c - v.y*s, v.x*s + v.y*c);
  }
}


//MANTA
class MCManta extends SuperCreature {

  int sz, lgth, nb;
  float ang;
  float vel, freqY, ampY;
  //PVector colorF;
  PVector wingsAmp;
  int count;

  public MCManta() {
    creatureAuthor  = "Maxime Castelli";
    creatureName    = "Manta";
    creatureVersion = "Beta";

    freqY = random(0.01f, 0.03f);
    ampY = random(30, 90);
    //    colorF = new PVector();
    //    colorF.x = random(0.001, 0.004); 
    //    colorF.y = random(0.001, 0.004); 
    //    colorF.z = random(0.001, 0.004);

    ang = random(TWO_PI);
    vel = random(1, 2);

    wingsAmp = new PVector();
    wingsAmp.x = random(0.01f, 0.15f);
    wingsAmp.y = random(0.01f, 0.15f);
  }

  public void move(float speed) {
    count++;
    pos.x += cos(ang) *vel;
    pos.y = cos(count *freqY) *ampY;
    pos.z += sin(ang) *vel;
    rot.y = -ang;
    applyTransforms();
  }

  public void draw(int colorIn, int colorOut, float thickness) {

    sz = 25;
    lgth = 300;
    nb = lgth /sz ;

    fill(colorIn);
    stroke(colorOut);
    strokeWeight(thickness);
    rotateY(PI);

    //TETE
    sphereDetail(2);
    for (int i=0; i<2; i++) {
      pushMatrix();
      translate(40 +i*15, 0 +(sin(i+count*0.1f)));
      scale(2, i*0.8f);
      sphere(15);
      popMatrix();
    }

    //AILE 1
    pushMatrix();
    rotateX(0.6f*sin(count * wingsAmp.x) + radians(90));
    beginShape(TRIANGLE_STRIP);
    for (int l1=0; l1<10; l1++) {
      vertex(pow(l1, 2), l1*10, sin(count*wingsAmp.y)*5);
      vertex(75, 25, cos(count*wingsAmp.x)*10);
    }
    vertex(120, 0);
    endShape(CLOSE);  
    popMatrix();

    //AILE 2
    pushMatrix();
    rotateX(-0.6f*sin(count * wingsAmp.x) - radians(90));
    beginShape(TRIANGLE_STRIP);
    vertex(0, 0);
    for (int l2=0; l2<10; l2++) {
      vertex(pow(l2, 2), l2*10, sin(count*wingsAmp.y)*5);
      vertex(75, 25, -cos(count*wingsAmp.x)*10);
    }
    vertex(120, 0);
    endShape(CLOSE);
    popMatrix();

    //QUEUE
    translate(80, 0);
    beginShape(TRIANGLE_STRIP); 
    for (int j=0; j<15;j++) {
      vertex(j*10, sin(j-(count* wingsAmp.x))*(j), cos(j-(count* wingsAmp.y))*(j));
    }
    endShape();
  }
}



//SONAR
class PXPSonar extends SuperCreature {

  int time;
  int count;
  int bold = 2;
  int freq = 300;
  float fadeSpeed = 5;
  PVector freqMulRot, freqMulSca, freqMulPos;

  public PXPSonar() {
    creatureAuthor  = "Pierre-Xavier Puissant";
    creatureName    = "Sonar";
    creatureVersion = "1.0";

    freqMulRot = new PVector();
    freqMulRot.x = random(-0.0005f, 0.0005f);
    freqMulRot.y = random(-0.001f, 0.001f);
    freqMulRot.z = random(-0.0015f, 0.0015f);

    freqMulPos = new PVector();
    freqMulPos.x = random(-0.002f, 0.002f); 
    freqMulPos.y = random(-0.002f, 0.002f); 
    freqMulPos.z = random(-0.002f, 0.002f);

    /*freqMulSca = new PVector();
     freqMulSca.x = random(-0.005, 0.005);
     freqMulSca.y = random(-0.005, 0.005);
     freqMulSca.z = random(-0.005, 0.005);*/
  }

  public void move(float speed) {
    rot.x = sin(frameCount*freqMulRot.x) * TWO_PI;
    rot.y = sin(frameCount*freqMulRot.y) * TWO_PI;
    rot.z = sin(frameCount*freqMulRot.z) * TWO_PI;

    pos.x += sin(frameCount *freqMulPos.x);
    pos.y += sin(frameCount *freqMulPos.y);
    pos.z += cos(frameCount *freqMulPos.z);

    applyTransforms();
  }

  public void draw(int colorIn, int colorOut, float thickness) {
    time++;
    count++;
    float changeWH;
    float changeAL;
    float changeSca = map(sin(count*0.15f), -1,1, 1, 1.5f);
    
    fill(colorIn);
    for (int i = 0; i < bold; i++) { 
      changeAL = (freq-time*fadeSpeed)*(sin((PI/bold)*i));
      stroke(hue(colorOut), saturation(colorOut), brightness(colorOut), changeAL*2);
      changeWH = exp(sqrt(time*0.75f))+i;
      ellipse (0, 0, changeWH, changeWH);
    }
    if (time > freq) {
      time = 0;
    }

    rotateX(count*0.011f);
    rotateX(count*0.012f);
    rotateZ(count*0.013f);

    stroke (colorOut, alpha(colorOut) *.3f);    
    sphereDetail(6);
    sphere(30);    
    scale(changeSca, changeSca, changeSca);
    stroke (colorOut);
    sphereDetail(1);
    sphere(10);
  }
}


//FATHER
class OTFather extends SuperCreature {
  int count;
  int numSegmenti;
  int numTentacoli;
  int numPinne;
  float distPinne;
  float l;

  //TRIGO
  float sm1, sm2;
  float rx, ry;
  PVector pVel, rVel, noiseVel;

  public OTFather() {
    creatureName = "Father";
    creatureAuthor = "Oliviero Tavaglione";
    creatureVersion = "Beta";


    numSegmenti = floor(random(10, 20));
    numTentacoli = 1;
    numPinne = floor(random(2, 6));
    distPinne = random(0.2f, 0.5f);
    l = random(20, 40);

    sm1 = random(-0.005f, 0.005f);
    sm2 = random(-0.005f, 0.005f);    


    pVel = PVector.random3D();
    rVel = PVector.random3D();
    rVel.mult(random(0.01f, 0.03f));
    noiseVel =PVector.random3D();
    noiseVel.mult(random(0.005f, 0.03f));
    float s = random(0.5f, 1);
    sca.set(s,s,s);
  }

  public void move(float speed) {
    count++;
    pos.add(pVel); 
    rot.add(rVel);  
    applyTransforms();
  }


  public void draw(int colorIn, int colorOut, float thickness) {
    sphereDetail(8);

    //TESTA
    fill(colorIn);
    stroke(colorOut);
    strokeWeight(thickness) ;
    sphere(l);

    //ANTENNE
/*
    //float ly = sin(frameCount * 0.01) * 30;
    //float lz = -sin(frameCount * 0.01) * 30;
    float ly = random(l/2, sin(count * 0.01) * l);
    float lz = random(l, l + (l/1.5));
*/

    line(0, 0, 0, -l*2, 10, 30);
    line(0, 0, 0, -l*2, 10, -30);

    //PINNE  
    rotateY(-(numPinne-1) * distPinne / 2);
    //rotateY(-(numPinne-1) * distPinne / (distPinne - TWO_PI));
    for (int k=0; k<numPinne; k++) {

      float s = (cos(TWO_PI / (numPinne-1) * k));
      s = map(s, 1, -1, 0.9f, 1);
      pushMatrix();
      scale(s);
      
      for (int j=0; j<numTentacoli; j++) {
        pushMatrix();
        float a = (noise(count*noiseVel.x + j+k+1)-0.4f)*0.782f; 
        float b = (noise(count*noiseVel.y + j+k+1)-0.5f)*0.582f; 
        float c = (noise(count*noiseVel.z + j+k+1)-0.6f)*0.682f;

        for (int i=0; i<numSegmenti; i++) {
          rotateZ(a);
          rotateY(b);
          rotateX(c);
          translate(l*0.9f, 0, 0);
          scale(0.85f, 0.85f, 0.85f);
          box(l, l/2, l); 
          //ellipse(l/2, l, l, l);
        }


        popMatrix();


        //rotateY(TWO_PI/numTentacoli);
      }
      popMatrix();
      rotateY(distPinne);
    }
  }
}

//END CATALOGUE
class Boids extends Romanesco {
  public Boids() {
    romanescoName = "Boids" ;
    IDobj = 8 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Stan le Punk inspirated by Craig W. Reynolds";
    romanescoVersion = "Version 1.0.1";
    romanescoPack = "Base" ;
    romanescoMode = "Tetra monochrome/Tetra camaieu" ; // separate the differentes mode by "/"
    romanescoSlider = "Hue fill,Saturation fill,Brightness fill,Alpha fill,Hue stroke,Saturation stroke,Brightness stroke,Alpha stroke,Thickness,Size X,Canvas X,Canvas Y,Canvas Z,Quantity,Attraction,Repulsion,Influence,Alignment,Width,Speed" ;
  }
  
  Flock flock;
  Canvas myCanvas ;
  PVector birthPlace ;
  int maxColorRef = 360 ; // here we are in HSB 360
  int rangeAroundYourColor = 70 ;
  int numOfBoid ;
  // Main method
  // setup
  public void setting() {
   startPosition(IDobj, width/2, height/2, 0) ;
   // build the canvas where the boid can move
   PVector pos = new PVector (0, 0, 0) ;
   PVector size = new PVector(width,width,width) ;
   // PVector size = new PVector(canvasXObj[IDobj],canvasYObj[IDobj],canvasZObj[IDobj]) ;
   myCanvas = new Canvas(pos, size) ;
   // color colorBoid = color(80,100,100) ;
   birthPlace = pos.copy() ;
   flock = new Flock() ;

   // tetrahedronAdd() : weird why this method is here ?
   tetrahedronAdd() ;
  }
  
  // draw
  public void display() {
    // MAIN method
    float thickness = map(thicknessObj[IDobj],0,width/3,0,width/30 ) ;
    int size = (int)map(sizeXObj[IDobj],.1f,width, 2,width/10) ;
    float alignment = map(alignmentObj[IDobj],0,1,0,10) ;
    float cohesion = map(attractionObj[IDobj],0,1,0,10) ;
    float separation = map(repulsionObj[IDobj],0,1,0,10) ;
    PVector unity = new PVector(cohesion, separation) ;
    if(flock.listBoid.size() > 0 )flock.run(alignment, unity);
    
    // ANNEXE methods
    
    // GOAL of the boids
    //float depthGoal =sin(frameCount *.001) *300 ;
    // flock.goal(mouseX,mouseY, depthGoal);
    
    // INFLUENCE of the boid around him
    float ratioInfluence = influenceObj[IDobj] *400 +1 ;
    float influenceArea =  abs(sin(frameCount *.001f) *ratioInfluence) ;
    flock.influence(influenceArea);
    
    // SPEED
    float speed = map(speedObj[IDobj],0,1,.1f,10) ;
    flock.speed(speed) ;
    
    // cage size
    myCanvas.size.x = canvasXObj[IDobj] *10 ;
    myCanvas.size.y = canvasYObj[IDobj] *10 ;
    myCanvas.size.z = canvasZObj[IDobj] *10 ;
    myCanvas.update() ;
  
    flock.canvasSetting(myCanvas.left, myCanvas.right, myCanvas.top, myCanvas.bottom, myCanvas.front, myCanvas.back) ;
    
    // quantity of boids
    numOfBoid = PApplet.parseInt(quantityObj[IDobj] *700 +30); //amount of boids to start the program with
    if(!fullRendering) numOfBoid /= 15 ;
    
    // change the setting of the boid
    for(Boid b : flock.listBoid) {
      b.fillBoid = color(hue(b.fillBoid), saturation(fillObj[IDobj]), brightness(fillObj[IDobj]), alpha(fillObj[IDobj])) ;
      b.strokeBoid = color(hue(b.strokeBoid), saturation(strokeObj[IDobj]), brightness(strokeObj[IDobj]), alpha(strokeObj[IDobj])) ;
      b.size = size ;
      b.thickness = thickness;
    }
    
    
    if(flock.listBoid.size() < 1 ) {
      flock.add(birthPlace, numOfBoid, fillObj[IDobj], strokeObj[IDobj], maxColorRef, rangeAroundYourColor) ;
    }
    
    // clear the boids list
    // flock.clear() ;
    if(nTouch && action[IDobj]) {
      flock.add(birthPlace, numOfBoid, fillObj[IDobj], strokeObj[IDobj], maxColorRef, rangeAroundYourColor) ;
    }
    
    // INFO
    objectInfo[IDobj] = ("There is " + numOfBoid + " boids") ;
    if(displayInfo) {
      strokeWeight(1) ;
      stroke(255) ;
      myCanvas.canvasLine() ;
    }
  }
}













// FLOCK
class Flock {
  ArrayList<Boid> listBoid = new ArrayList<Boid>(); //will hold the boids in this BoidList
  // float h; //for color
 //  color colorBoid ;
  // Univers
  float left, right, top, bottom, front, back ;
  // 
  PVector birthPlace ;
  
  // Constructor just to init
  Flock() {}
  
  
  // CONSTRUCTOR
  Flock(int n, int fillBoid, int strokeBoid) {
   birthPlace = new PVector(width/2,height/2,0) ;
    for(int i = 0; i < n ; i++) {
      listBoid.add(new Boid(birthPlace, fillBoid, strokeBoid));
    }
  }
  
  
  // 
  Flock(PVector birthPlace, int n, int fillBoid, int strokeBoid) {
    this.birthPlace = birthPlace.copy() ;
    for(int i = 0; i < n ; i++) {
      listBoid.add(new Boid(birthPlace, fillBoid, strokeBoid));
    }
  }
  
  
  // Flock Camaieu constructor
  Flock(PVector birthPlace, int n, int fillBoid, int strokeBoid, int max, int range) {
     this.birthPlace = birthPlace.copy() ;
     
     float refFill = hue(fillBoid) ;
     float refStroke = hue(strokeBoid) ;
     for(int i = 0; i < n ; i++) {
      float newHueFill = camaieu(max, refFill, range) ;
      float newHueStroke = camaieu(max, refStroke, range) ;
      fillBoid = color (newHueFill, saturation(fillBoid), brightness(fillBoid)) ;
      strokeBoid = color (newHueStroke, saturation(strokeBoid), brightness(strokeBoid)) ;
      listBoid.add(new Boid(birthPlace, fillBoid, strokeBoid));
    }
  }
  
  

  
  
  // SETUP
  public void canvasSetting() {
    right = width ;
    left = 0 ;
    bottom = height ;
    top = 0 ;
    back = -300 ; 
    front = 300 ;
  }
  
  public void canvasSetting(float left, float right, float top, float bottom, float front, float back) {
    this.left = left ;
    this.right = right ;
    this.top = top ;
    this.bottom = bottom ;
    this.front = front ;
    this.back = back ;
  }
  
  
  // DRAW
  public void run(float ratioAlignment, PVector unity) {
    //iterate through the list of boids 
    for(Boid b : listBoid) {
     // Boid tempBoid = (Boid)listBoid.get(i); //create a temporary boid to process and make it the current boid in the list
    //  b.colorBoid = colorBoid;
      b.settingBounds (left, right, top, bottom, front, back);
      b.run (listBoid, ratioAlignment, unity); //tell the temporary boid to execute its run method
    }
  }
  
  // ANNEXE and EXTERNAL
  
   public void goal(float x, float y, float z) {
     for(Boid b : listBoid) b.goal(x,y,z);
   }
   
   public void influence(float neighborhoodRadius) {
     for(Boid b : listBoid) b.influence(neighborhoodRadius);
   }
   
   
 public void speed(float maxSpeed) {
    for(Boid b : listBoid) b.speed(maxSpeed);
  }
  
  // ADD and REMOVE boids
  
  // different rebirth
  public void add(int n) {
    listBoid.clear() ;
    for(int i = 0; i < n ; i++) listBoid.add(new Boid(birthPlace));
  }
  
  public void add(int n, int fillBoid, int strokeBoid) {
    listBoid.clear() ;
    for(int i = 0; i < n ; i++) listBoid.add(new Boid(birthPlace, fillBoid, strokeBoid));
  }
  
 public void add(PVector birthPlace, int n, int fillBoid, int strokeBoid, int max, int range) {
   listBoid.clear() ;
    float refFill = hue(fillBoid) ;
    float refStroke = hue(strokeBoid) ;
    for(int i = 0; i < n ; i++) {
      float newHueFill = camaieu(max, refFill, range) ;
      float newHueStroke = camaieu(max, refStroke, range) ;
      fillBoid = color (newHueFill, saturation(fillBoid), brightness(fillBoid)) ;
      strokeBoid = color (newHueStroke, saturation(strokeBoid), brightness(strokeBoid)) ;
      listBoid.add(new Boid(birthPlace,fillBoid,strokeBoid));
    }
  }
  
  
  
  
  public void clear(){
    listBoid.clear() ;
  }
  
  public void add() {
    listBoid.add(new Boid(new PVector(birthPlace.x,birthPlace.y,birthPlace.z)));
  }
  
  public void addBoid(Boid b) {
    listBoid.add(b);
  }
  
  // remove specific boid
  public void remove(int n) {
    if(n < listBoid.size())
      listBoid.remove(n);
  }
  
  // remove the last boid
  public void remove() {
    if(listBoid.size() > 0)
      listBoid.remove(listBoid.size()-1);
  }
}
// END FLOCK
///////////









// BOID
////////
class Boid {
  //fields
  PVector pos = new PVector() ;
  PVector acc = new PVector() ;
  PVector velNorm = new PVector() ;
  PVector ali = new PVector() ;
  PVector coh = new PVector() ;
  PVector sep = new PVector() ; 
  
  float neighborhoodRadius = 100 ; //radius in which it looks for fellow boids, we give 100 for default value
  float maxSpeed = 4; //maximum magnitude for the velocity vector
  float maxSteerForce = .1f; //maximum magnitude of the steering vector
  int fillBoid = color(255) ;
  int strokeBoid = color(255) ;
  float thickness = 1 ;
  int size = 1 ;
  
  
  
  // Canvas where the boids can move
  float left, right, top, bottom, front, back ;
  
  //constructors
    Boid(PVector pos) {
    this.pos = pos.copy() ;
    velNorm = new PVector(random(-1,1),random(-1,1),random(1,-1));
  }
  
  Boid(PVector pos, int fillBoid, int strokeBoid) {
    this.fillBoid = fillBoid ;
    this.strokeBoid = strokeBoid ;
    this.pos = pos.copy() ;
    velNorm = new PVector(random(-1,1),random(-1,1),random(1,-1));
  }
  
  Boid(PVector pos,PVector velNorm, float neighborhoodRadius) {
    this.pos = pos.copy() ;
    this.velNorm = velNorm.copy() ;
    this.neighborhoodRadius =neighborhoodRadius;
  }
  
  
  // DRAW
  public void run(ArrayList boidList, float ratioAlignment, PVector unity) {

    
    //acc.add(new PVector(0,.05,0));

    flock(boidList, ratioAlignment, unity);
    move();
    checkBounds();
    
    //display
    display();
  }
  
  
  // ANNEXE EXTERNAL METHOD
  public void goal(float x, float y, float z) {
    acc.add(steer(new PVector(x,y,z),true));
  }
  
  
  public void influence(float neighborhoodRadius) {
    this.neighborhoodRadius = neighborhoodRadius;
  }
  
  public void speed(float maxSpeed) {
    this.maxSpeed = maxSpeed ;
  }
  
  
  
  
  
  
  
  
  // ANNEXE INTERNAL METHOD
  // BEHAVIOR
  public void flock(ArrayList listBoids, float ratioAlignment, PVector unity) {
    ali = alignment(listBoids);
    coh = cohesion(listBoids);
    sep = seperation(listBoids);
   //  float ratioAlignment = 1 ; // original 1
    float ratioCohesion = unity.x ; // original 3
    float ratioSeparation = unity.y ; // original 1
    acc.add(PVector.mult(ali,ratioAlignment));
    acc.add(PVector.mult(coh,ratioCohesion));
    acc.add(PVector.mult(sep,ratioSeparation));
  }
  
  public void move() {
    velNorm.add(acc); // add acceleration to velocity
    velNorm.limit(maxSpeed); // make sure the velocity vector magnitude does not exceed maxSpeed
    pos.add(velNorm); // add velocity to position
    acc.mult(0); // reset acceleration
  }
  
  
  
  // UNIVERS
  // seeting in the Flock Class
  public void settingBounds(float left, float right, float top, float bottom, float front, float back) {
    this.left = left ;
    this.right = right ;
    this.top = top ;
    this.bottom = bottom ;
    this.front = front ;
    this.back = back ;
  }

  // check bound
  public void checkBounds() {
    // width
    if(pos.x > right) pos.x = left ;
    if(pos.x < left) pos.x = right ;
    //height
    if(pos.y > bottom) pos.y = top ;
    if(pos.y < top) pos.y = bottom ;
    // depth
    if(pos.z > front) pos.z = back ;
    if(pos.z < back) pos.z = front ;
  }
  
  
  
  
  
  
  // ENGINE
  
  /* STEERING, If arrival==true, the boid slows to meet the target. Credit to Craig Reynolds */
  public PVector steer(PVector target,boolean arrival) {
    PVector steer = new PVector(); //creates vector for steering
    if(!arrival) {
      steer.set(PVector.sub(target,pos)); //steering vector points towards target (switch target and pos for avoiding)
      steer.limit(maxSteerForce); //limits the steering force to maxSteerForce
    } else {
      PVector targetOffset = PVector.sub(target, pos);
      float distance=targetOffset.mag();
      float rampedSpeed = maxSpeed *(distance *.01f);
      float clippedSpeed = min(rampedSpeed,maxSpeed);
      PVector desiredVelocity = PVector.mult(targetOffset, (clippedSpeed /distance));
      steer.set(PVector.sub(desiredVelocity, velNorm));
    }
    return steer;
  }
  
  // DODGE. If weight == true avoidance vector is larger the closer the boid is to the target
  public PVector dodge(PVector target,boolean weight) {
    PVector steer = new PVector(); //creates vector for steering
    steer.set(PVector.sub(pos, target)); //steering vector points away from target
    if(weight)
      steer.mult(1/sq(PVector.dist(pos, target)));
    //steer.limit(maxSteerForce); //limits the steering force to maxSteerForce
    return steer;
  }
  
  
  // SEPARATION
  public PVector seperation(ArrayList <Boid> list) {
    PVector posSum = new PVector();
    PVector repulse;
    for(Boid b : list) {
      float d = PVector.dist(pos,b.pos);
      if(d > 0 && d <= neighborhoodRadius) {
        repulse = PVector.sub(pos,b.pos);
        repulse.normalize();
        repulse.div(d);
        posSum.add(repulse);
      }
    }
    return posSum;
  }
  
  
  // ALIGNMENT
  public PVector alignment(ArrayList <Boid> list) {
    PVector velSum = new PVector();
    int count = 0;
    for(Boid b : list) {
      float d = PVector.dist(pos,b.pos);
      if(d > 0 && d<= neighborhoodRadius) {
        velSum.add(b.velNorm);
        count++;
      }
    }
    if(count>0) {
      velSum.div((float)count);
      velSum.limit(maxSteerForce);
    }
    return velSum;
  }
  
  
  // COHESION
  public PVector cohesion(ArrayList <Boid> list) {
    PVector posSum = new PVector();
    PVector steer = new PVector();
    int count = 0;
    for(Boid b : list) {
      float d = dist(pos.x,pos.y,b.pos.x,b.pos.y);
      if(d > 0 && d <= neighborhoodRadius) {
        posSum.add(b.pos);
        count++;
      }
    }
    if(count>0) posSum.div((float)count);

    steer = PVector.sub(posSum,pos);
    steer.limit(maxSteerForce); 
    return steer;
  }
  // END ENGINE
  
  
  
  
  
  
  
  
  // DISPLAY
  public void display() {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    rotateY(atan2(-velNorm.z, velNorm.x));
    rotateZ(asin(velNorm.y /velNorm.mag()));
    strokeWeight(thickness) ;
    if(thickness <= 0 || alpha(strokeBoid) == 0 ) noStroke() ; else stroke(strokeBoid);
    // println(thickness, alpha(colorBoid)) ;
    if(alpha(fillBoid) == 0 ) noFill() ; else  fill(fillBoid);
    tetrahedron(size) ;
    /*
    size.x = 10 ;
    strokeWeight(size.x) ;
    point(0,0) ;
    */
    // box(size.x) ;
    // tetrahedronDisplay((int)size.x) ;
    
    endShape();
    //box(10);
    popMatrix();
  }
}



class MesAmis extends Romanesco {
  public MesAmis() {
    //from the index_objects.csv
    romanescoName = "Rubis" ;
    IDobj = 9 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "version 1.0";
    romanescoPack = "Base" ;
    romanescoRender = "P3D" ;
    //romanescoMode = "1 full/2 lines" but the line is not really interesting
    romanescoMode = "" ; // separate the name by a slash and write the next mode immadialtly after this one.
    romanescoSlider = "Hue fill,Saturation fill,Brightness fill,Alpha fill,Hue stroke,Saturation stroke,Brightness stroke,Alpha stroke,Thickness,Canvas X,Speed,Quantity,Amplitude" ;
  }
  //GLOBAL
  IntList IDpeople = new IntList() ;
  ArrayList<Ami> listPeople = new ArrayList<Ami>() ;
  int numPeople, rangePeople, refNumPeople ;
  PVector target ;
  boolean goBack  ;
  boolean newPeoplePosition, newPopulation ;
  
  
  //SETUP
  public void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
    int num = (int)random(15,25)  ;
    rangePeople = width/2 ;
    amiSetting(num, rangePeople) ;
  }
  
  
  

  //DRAW
  public void display() {
    
    PVector center = new PVector() ;
    
    PVector jitter = new PVector() ;
    if(sound[IDobj] && getTimeTrack() > 0.2f ) {
      float factor = .2f ;
      float valueX = left[IDobj]*factor *(width / 2 ) ;
      float valueY = right[IDobj]*factor *(height / 2 ) ;
      float valueZ = mix[IDobj]*factor *(height / 2 ) ;
      jitter = new PVector(valueX,valueY,valueZ) ;
    }
    
    
    float speed = map(speedObj[IDobj],0,1, .0001f, .2f);
    speed = speed*speed ;
    if(sound[IDobj]) speed *= allBeats(IDobj) ;
    float radiusMax = map(canvasXObj[IDobj], width/10, width, width/4, width *1.5f) ;
    float radiusMin = map(amplitudeObj[IDobj], 0, 1, radiusMax, radiusMax /10) ; ;
    
    // new population
    if(!fullRendering)  quantityObj[IDobj] *= .1f ;
    numPeople = (int)map(quantityObj[IDobj],0, 1, 10, 70) ; 
    if ( numPeople != refNumPeople ) newPopulation = true ;
    refNumPeople = (int)map(quantityObj[IDobj],0, 1, 10, 70) ;
    if(newPopulation) {
      listPeople.clear() ;
      amiSetting(numPeople, rangePeople) ;
      newPopulation = false ;
    }
    
    
    aspect(IDobj) ;
    amiDrawHeartMove(center, speed, radiusMin, radiusMax, jitter, mode[IDobj]) ;

  }
  
  ////////////////
  // VOID
  //setting
  public void amiSetting(int num, int size) {
    for ( int i = 0 ; i < num ; i++ ) {
      int ID = i ;
      //position of people
      PVector p  = new PVector (random(-size, size), random(-size, size), random(-size, size)) ;
      //friend of this people
      for ( int f = 0 ; f < num ; f++) IDpeople.append(f) ;
      int numFriend = (int)random(num / 2 ) ;
      int [] IDfriend = new int [numFriend] ;
      for ( int j = 0 ; j < numFriend ; j++) {
        int whichPeople = (int)random(IDpeople.size() ) ;
        int IDofFriend = IDpeople.get(whichPeople) ;
        IDfriend[j] = IDofFriend ;
        if(IDpeople.size() > 0 ) IDpeople.remove(whichPeople) ; 
      }
      //add information to the arraylist
      Ami people = new Ami(p, ID, IDfriend ) ;
      listPeople.add(people) ;
      //clear the list for a new start friend round
      IDpeople.clear() ;
    }
  }
  //draw
  //different points
  public void amiDrawHeartMove(PVector posCenter, float speed, float distMin, float distMax, PVector jitter, int mode) {
    // new distribution
    if(newPeoplePosition) {
      for(int i = 0 ; i < listPeople.size() ; i++) {
        int r = (int)distMax ;
        Ami peopleOrigin = listPeople.get(i) ;
        peopleOrigin.originalPos = new PVector(random(-r,r),random(-r,r),random(-r,r)) ; 
      }
      newPeoplePosition = false ;
    }
    
    // ACTION
    countAmiArrivedToTarget = 0 ;
    for(int i = 0 ; i < listPeople.size() ; i++) {
      Ami peopleOrigin = listPeople.get(i) ;
      //update
      if (!goBack) target = new PVector(posCenter.x, posCenter.y, posCenter.z) ; else  target = new PVector(peopleOrigin.originalPos.x, peopleOrigin.originalPos.y, peopleOrigin.originalPos.z) ;
      PVector jitting = new PVector(random(-jitter.x, jitter.x), random(-jitter.y, jitter.y), random(-jitter.y, jitter.y)) ;
      target.add(jitting) ;
      peopleOrigin.pos = heartMove(peopleOrigin.pos, target, distMin, speed) ;
      //draw
      if(mode == 0 ) triangleFriends(peopleOrigin) ;
      //if(mode == 1 ) lineFriends(peopleOrigin) ;

    }
    
    // info
    objectInfo[IDobj] =(numPeople + " summits") ;
  }
  
  
  
  /////////
  // ANNEXE
  
  // HEART MOVE
  int countAmiArrivedToTarget ;
  
  public PVector heartMove(PVector pos, PVector target, float distMin, float speed) {
    pos = gotoTarget(pos, target, speed) ; 
    float distance = 0 ;
    distance = PVector.dist(pos, target) ;
    if( distance < distMin  ) countAmiArrivedToTarget += 1 ;
    if(countAmiArrivedToTarget == listPeople.size() ) {
      goBack = !goBack ;
      newPeoplePosition = true ;
    }
    return pos ;
  }
  // END ANNEXE HEART MOVE
  
  
  
  // CONNECT YOUR FRIEND with line
  /*
  void lineFriends(Ami ami) {
    if (ami.friendList.length > 0 ) {
      PVector origin = ami.pos ;
      for ( int f = 0 ; f < ami.friendList.length ; f++) {
        Ami peopleDestination = listPeople.get(ami.friendList[f]) ; 
        PVector destination = peopleDestination.pos ;
        line(origin.x, origin.y, origin.z, destination.x, destination.y, destination.z) ;
      }
    }
  }
  */
  // END CONNECT YOUR FRIEND with line
  
  // CONNECT YOUR FRIEND with triangle
  public void triangleFriends(Ami ami) {
    if (ami.friendList.length > 1 ) {
      PVector me = ami.pos ;
      // f += 2
      for ( int f = 0 ; f < ami.friendList.length -1 ; f++) {
        Ami amiOne = listPeople.get(ami.friendList[f]) ;
        Ami amiTwo ;
        if (ami.friendList[f] +1 >= listPeople.size() )  amiTwo = listPeople.get(ami.friendList[0]) ; else amiTwo = listPeople.get(ami.friendList[f] +1) ; 
        PVector posAmiOne = amiOne.pos.copy() ;
        PVector posAmiTwo = amiTwo.pos.copy() ;
        //display
        beginShape() ;
        vertex(me.x, me.y, me.z) ;
        vertex(posAmiOne.x, posAmiOne.y, posAmiOne.z) ;
        vertex(posAmiTwo.x, posAmiTwo.y, posAmiTwo.z) ;
        endShape(CLOSE) ;
      }
    }
  }
  // END CONNECT YOUR FRIEND with triangle
  
  // END ANNEXE
  /////////////
}









////////////
// CLASS
class Ami {
  PVector pos = new PVector() ;
  PVector originalPos = new PVector() ;
  PVector size ;
  int ID ;
  int [] friendList ;
  
  Ami (PVector pos, int ID, int [] IDfriend ) {
    this.originalPos = pos ;
    this.pos = pos ;
    this.ID = ID ;
    friendList = new int [IDfriend.length] ;
    for ( int i = 0 ; i < IDfriend.length ; i ++ ) {
      friendList[i] = IDfriend[i] ;
    }
  }
  
  
  Ami ( PVector pos) {
    this.pos = pos ;
  }
}
Arbre arbre ;
//object three
class ArbreRomanesco extends Romanesco {
  public ArbreRomanesco() {
    //from the index_objects.csv
    romanescoName = "Arbre" ;
    IDobj = 10 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Version 1.3.1";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
    romanescoMode = "Line/Disc/Disc line/Rectangle/Rectangle line/Box" ;
    romanescoSlider = "Hue fill,Saturation fill,Brightness fill,Alpha fill,Hue stroke,Saturation stroke,Brightness stroke,Alpha stroke,Thickness,Size X,Size Y,Size Z,Quantity,Speed,Direction,Amplitude" ;
  }
  //GLOBAL
  float speed ;
  PVector posArbre = new PVector () ;
  //SETUP
  public void setting() {
    startPosition(IDobj, width/2, height/3, 0) ;
    arbre = new Arbre () ;
  }
  //DRAW
  public void display() {
    int maxFork ;
    if(fullRendering) maxFork = 8 ; else maxFork = 4 ; // we can go beyond but by after the calcul slowing too much the computer... 14 is a good limit
    // int maxNode = 32 ; // 
    // num fork for the tree
    int forkA = maxFork ; 
    int forkB = maxFork ;
    
    int n = PApplet.parseInt(map(quantityObj[IDobj],0,1,2,maxFork*2)) ;
    
    float epaisseur = thicknessObj[IDobj] ;
    float ratioLeft = map(left[IDobj], 0, 1, .5f, 2) ;
    float ratioRight = map(right[IDobj], 0, 1, .5f, 2) ;
    if(!fullRendering) {
      ratioLeft = .75f ;
      ratioRight = .75f ;
    }
    float ratioMix = ratioLeft + ratioRight ;

    // quantity of the shape

    //size of the shape
    float divA = .66f ;
    float divB = .66f ;
    if(sound[IDobj]) {
      divA = ratioLeft ;
      divB = ratioRight  ;
    } else {
      divA = .66f ;
      divB = .66f ;
    }
      
    
    //size
    int div_size = 20 ;
    float x = map(sizeXObj[IDobj],.1f,width,.1f,width /div_size) ;
    float y = map(sizeYObj[IDobj],.1f,width,.1f,width /div_size) ;
    float z = map(sizeZObj[IDobj],.1f,width,.1f,width /div_size) ;
    x = x *x *ratioMix ;
    y = y *y *ratioMix ;
    z = z *z *ratioMix ;

    PVector size  = new PVector(x,y,z) ;
    //orientation
    float direction = directionObj[IDobj] ;
    //amplitude
    float amplitude = map(amplitudeObj[IDobj], 0,1, 0.1f,width *.6f) ;
    if(fullRendering) amplitude = amplitude *allBeats(IDobj) ;
    



    // angle
    // float angle = map(angleObj[IDobj],0,360,0,180);
    float angle = 90 ; // but this function must be remove because it give no effect
    // speed
    if(motion[IDobj] && fullRendering) {
      float s = map(speedObj[IDobj],0,1,0,2) ;
      s *= s ;
      speed = s *tempo[IDobj] ; 
    } else if (!motion[IDobj] && fullRendering){ 
      speed = 0.0f ;
    } else {
      speed = 1.0f ;

    }
    
    aspect(IDobj) ;
    
    arbre.affichage (direction) ;
    arbre.actualisation(posArbre, epaisseur, size, divA, divB, forkA, forkB, amplitude, n, mode[IDobj], angle, speed, IDobj) ;
    
    //info
    objectInfo[IDobj] = ("Nodes " +(n-1) + " - Amplitude " + (int)amplitude + " - Orientation " +direction +  " - Speed " + (int)map(speed,0,4,0,100) );
    
  }
}
//end object two







/////////////////
//CLASS ARBRE
class Arbre {
  Arbre() {}
  // int vR = 1 ;  ;
  float theta, angleDirection ;
  float rotation = 90.0f  ;
  float direction   ;
 
//::::::::::::::::::::  
  public void affichage (float d) {
    direction = d ;
  }
//::::::::::::::::::::::::::::  
  public void actualisation (PVector posArbre, float e, PVector size, float divA, float divB, int forkA, int forkB, float amplitude, int n, int mode, float angle, float speed, int ID) {
    rotation += speed ;
    if (rotation > angle +90) speed*=-1 ; else if ( rotation < angle ) speed*=-1 ; 
    angle = rotation ; // de 0 \u00e0 180
    // Convert it to radians
    theta = radians(angle);
    angleDirection = radians (direction) ;
    pushMatrix () ;
    translate(posArbre.x,posArbre.y, 0) ;
    // Start the recursive branching
    rotate (angleDirection) ;
    branch(e, size, divA, divB, forkA, forkB, amplitude, n, mode, ID);
    popMatrix () ;

    
  }
  
  
  //float fourche = 10.0 ; 
  public void branch(float t, PVector proportion, float divA, float divB, int forkA, int forkB, float amplitude, int n, int mode, int ID) {
    PVector newSize = proportion.copy() ;
    newSize.x = proportion.x *divA ;
    newSize.y = proportion.y *divB;
    newSize.z = proportion.z *((divA +divB) *.5f) ;
    if(newSize.x < 0.1f ) newSize.x = 0.1f ;
    
    float newThickness = t ;
    newThickness = t *.66f ;
    
    // recursice need a end  !
    n = n-1 ;
    if (n >0) {
     displayBranch(newThickness, newSize, divA, divB, forkA, forkB, amplitude, n, -theta, mode, ID) ; 
     displayBranch(newThickness, newSize, divA, divB, forkA, forkB, amplitude, n, theta, mode, ID) ;
    }
  }
  
  //annexe branch
  public void displayBranch(float e, PVector newSize, float propA, float propB, int fourcheA, int fourcheB, float amplitude, int n, float t, int mode, int ID) {
    pushMatrix();    // Save the current state of transformation (i.e. where are we now)
    rotate(t);   // Rotate by theta

    strokeWeight (e) ;
    
    if (mode == 0  ) line(0, 0, 0, -amplitude);  // Draw the branch
    if (mode == 2  ) { ellipse(0,0, newSize.x, newSize.y) ; line(0, 0, 0, -amplitude); }
    if (mode == 4  ) { rect(0,0, newSize.x, newSize.y) ; line(0, 0, 0, -amplitude); }
    
    if (mode == 1 || mode == 3 || mode == 5 ) {
      if (mode == 1 )  ellipse(0,0, newSize.x , newSize.y) ;
      if (mode == 3 )  rect(0,0, newSize.x, newSize.y) ;
      if (mode == 5  ) box(newSize.x, newSize.y, newSize.z) ;
      if (!horizon[ID]) {
        //pushMatrix() ;
        float factor = 0.0f ;
        if(!vTouch && pen[0].z != 0) factor = map(pen[0].z,0.01f,1, -.5f,.5f) ; else factor = 0 ;
        translate(0,0, -newSize.z *factor) ; 
      } else {
        //pushMatrix() ;
        float factor = 0.0f ;
        if(!vTouch && pen[0].z != 0)factor = .15f + map(pen[0].z,0.01f,1, 1.2f,-1.2f) ; else factor = .15f ;
        translate(0,0, -newSize.z *factor) ;
        //popMatrix() ;
      }
    }
    translate(0, -amplitude); // Move to the end of the branch
    branch(e, newSize, propA, propB, fourcheA, fourcheB, amplitude, n, mode, ID);       // Ok, now call myself to draw two new branches!!
    popMatrix();     // Whenever we get back here, we "pop" in order to restore the previous matrix state
  }
}
  ArrayList<BOITEaMUSIQUE> boiteList ;
  
class Boxolyzer extends Romanesco {
  public Boxolyzer() {
    //from the index_objects.csv
    romanescoName = "Boxolyzer" ;
    IDobj = 11 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Version 1.0.1";
    romanescoPack = "Base" ;
    romanescoRender = "P3D" ;
    romanescoMode ="Classic/Circle" ;
    romanescoSlider = "Hue fill,Saturation fill,Brightness fill,Alpha fill,Hue stroke,Saturation stroke,Brightness stroke,Alpha stroke,Thickness,Size X,Size Y,Size Z,Canvas X,Quantity,Direction" ;
  }
  //GLOBAL
  boolean newDistribution ;
  int numBoxRef ;

  //SETUP
  public void setting() {
    startPosition(IDobj, 0, height/4, 0) ;
    
    boitesSetting() ;
  }
  //DRAW
  public void display() {
    //CLASSIC DISPLAY
    int numBox = PApplet.parseInt(map(quantityObj[IDobj],0, 1, 1, 16)) ;
    if (numBox != numBoxRef ) newDistribution = true ;
    numBoxRef = numBox ;
    Vec3 size = Vec3(sizeXObj[IDobj],sizeYObj[IDobj],sizeZObj[IDobj]) ;
    size.mult(2) ;

    // color and thickness
    aspect(IDobj) ; 
    //
    distribution(numBox, newDistribution) ;
    
    // MODE DISPLAY with the dropdown menu of controler
    /////////////////////
    if        (mode[IDobj] ==0) { boxolyzerClassic(size, horizon[IDobj] , directionObj[IDobj]) ;
    } else if (mode[IDobj] ==1) { boxolyzerCircle(size, (int)canvasXObj[IDobj], horizon[IDobj], directionObj[IDobj]) ;
    } 


    // INFO
    objectInfo[IDobj] = ("There is " +numBox + " bands analyzed");
    
  }
  
  //ANNEXE VOID
  public void distribution(int n, boolean newOne) {
     if (newOne) newDistributionBoite(n) ;
     newDistribution = false ;
   }
  
  boolean orientation ;
  // BOXLIZER CIRCLE
  public void boxolyzerCircle(Vec3 size, int diam, boolean groundPosition, float dir) {
    if( action[IDobj] && rTouch ) orientation = !orientation ;
    int surface = diam*diam ; // surface is equale of square surface where is the cirlcke...make sens ?
    int radius = ceil(radiusSurface(surface)) ;
    
    int n = boiteList.size() ;
    float factorSpectrum = 0 ;
    PVector pos = new PVector(0,0,0) ;
    
    for(int i=0; i < n; i++) {
      if(  i < band.length) factorSpectrum = band [IDobj][i] ;
      float stepAngle = map(i, 0, n, 0, 2*PI) ; 
      float angle =  2*PI - stepAngle;
      if(orientation) pos = new PVector(pointOnCirlcle(radius, angle).x + pos.x, pointOnCirlcle(radius, angle).y + pos.y ) ;
      else  pos = new PVector(pointOnCirlcle(radius, angle).x + pos.x, 0, pointOnCirlcle(radius, angle).y + pos.z) ;

      BOITEaMUSIQUE boiteAmusique = (BOITEaMUSIQUE) boiteList.get(i) ;
      boiteAmusique.showTheBoite(pos, size, factorSpectrum, groundPosition, dir) ;
    }
  }



  // EQUALIZER CLASSIC
  public void boxolyzerClassic(Vec3 size, boolean groundPosition, float dir) {
    PVector pos = new PVector(0,height *.5f ,0) ;
    float factorSpectrum = 0 ;
    int n = boiteList.size() ;
    // int canvasFinal = width ;
    int canvasFinal = (int)map(canvasXObj[IDobj], width/10, width, width/2,width*3)  ;
    int displacement_symetric = PApplet.parseInt(width *.5f -canvasFinal *.5f) ;
    for( int i = 0 ; i < n ; i++) {
      pos.x = (i *canvasFinal/n) + (canvasFinal /(n *2)) +displacement_symetric ;
      if( i < band.length) factorSpectrum = band [IDobj][i] ;
      BOITEaMUSIQUE boiteAmusique = (BOITEaMUSIQUE) boiteList.get(i) ;
      if(!fullRendering) factorSpectrum = .5f ;
      boiteAmusique.showTheBoite(pos, size, factorSpectrum, groundPosition, dir) ;
    }
  }
  // END EQUALIZER
  
  
  
  
  
  
  // GLOBAL VOID
  public void boitesSetting() {
    boiteList = new ArrayList<BOITEaMUSIQUE>();
  }
  //
  public void newDistributionBoite(int n) {
    boiteList.clear() ;
    for (int i = 0 ; i < n ; i++ ) addBoite(i) ;
  }
  //
  public void addBoite(int ID) {
    Vec3 size = Vec3(1,1,1) ;
    BOITEaMUSIQUE boiteAmusique = new BOITEaMUSIQUE(size, ID) ; 
    boiteList.add(boiteAmusique) ;
  }
  // END GLOBAL VOID
}
//END







///////
//CLASS
class BOITEaMUSIQUE {
  PVector pos = new PVector(0,0,0) ;
  Vec3 size ;
  int ID ;
  
  BOITEaMUSIQUE(Vec3 size, int ID) {
    this.ID = ID ;
    this.size = size ;
  }
  
  
  
  public void showTheBoite(PVector pos, Vec3 size, float factor, boolean groundLine, float dir) {
    Vec3 newSize = Vec3(size.x, size.y *factor,size.z *factor ) ;
    //put the box on the ground !
    float horizon = pos.y - ( newSize.y *.5f ) ;  
    pushMatrix() ;
    if (!groundLine) translate(pos.x, pos.y, pos.z) ; else translate(pos.x, horizon, pos.z) ;
    rotateX(radians(dir)) ;
    box(newSize.x,newSize.y,newSize.z) ;
    popMatrix() ;
  }
}

//object three
class Soleil extends Romanesco {
  public Soleil() {
    //from the index_objects.csv
    romanescoName = "Soleil" ;
    IDobj = 12 ;
    IDgroup = 2 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Version 1.1";
    romanescoPack = "Base" ;
    romanescoRender = "P3D" ;
    romanescoMode = "Beam/Lie'Bro'One/Lie'Bro'Two/Lie'Bro Noisy" ;
    romanescoSlider = "Hue fill,Saturation fill,Brightness fill,Alpha fill,Hue stroke,Saturation stroke,Brightness stroke,Alpha stroke,Thickness,Canvas X,Quantity,Speed,Angle,Amplitude" ;
  }
  //GLOBAL
  float jitter ;
  float angleRotation ;
  //SETUP
  public void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
    
  }
  PVector pos = new PVector() ;
  //DRAW
  public void display() {
    aspect(IDobj) ;
    //
    if(!motion[IDobj]) pos = new PVector(mouse[IDobj].x -width/2, mouse[IDobj].y -height/2,0) ; else pos = new PVector(0,0,0) ;
    int diam = PApplet.parseInt(map(canvasXObj[IDobj], width/10, width, width/10, width *1.2f) *allBeats(IDobj) ) ;
    int numBeam = (int)(quantityObj[IDobj] *180 +1) ;
    if(!fullRendering) numBeam /= 20 ;
    if(numBeam < 2 ) numBeam = 2 ;
    // Jitter
    jitter += (angleObj[IDobj] *.001f ) ;
    float jitting = cos(jitter) *tempo[IDobj] ;
     //noise
     PVector noise = new PVector() ;
     float amp = sq(amplitudeObj[IDobj] *10.0f) ;
     float rightNoise =  ((right[IDobj] *right[IDobj] *5) *amp) ;
     float leftNoise = ((left[IDobj] *left[IDobj] *5) *amp) ;
     if (sound[IDobj]) noise = new PVector(rightNoise, leftNoise) ; else noise = new PVector(amp,amp) ;
    // rotation speed
    float speedRotation = 0 ;
    speedRotation = sq(speedObj[IDobj] *10.0f *tempo[IDobj]) ;
    angleRotation += speedRotation ;
    rotate (radians(angleRotation)) ;

    // mode
    if(mode[IDobj] == 0) soleil(pos, diam, numBeam) ;
    if(mode[IDobj] == 1) soleil(pos, diam, numBeam, jitting) ;
    if(mode[IDobj] == 2) soleil(pos, diam, numBeam, jitter) ;
    if(mode[IDobj] == 3) soleil(pos, diam, numBeam, jitter, noise) ;
    
    // info display
    String revolution = ("") ;
    if(motion[IDobj]) revolution =("false") ; else revolution = ("true") ;
    objectInfo[IDobj] = ("The sun have " + numBeam + " beams - Motion "+revolution ) ;
    
    
  }
  
  // ANNEXE
  // soleil with jitter
  public void soleil(PVector pos, int diam, int numBeam, float jitter, PVector noise) {
    int numPoints = numBeam *2 ;
    for (int i = 0 ; i < numPoints -1 ; i = i +2) {
      float vibration = random(-noise.x, noise.y) ;
      PVector p1 = new PVector() ;
      PVector p2 = new PVector() ;
      p1 = circle(pos, diam, numPoints, jitter)[i].copy() ;
      p2 = circle(pos, diam, numPoints, jitter)[i +1].copy() ;
  
      beginShape() ;
      vertex(pos.x, pos.y, pos.z) ;
      vertex(p1.x +vibration, p1.y +vibration, p1.z +vibration) ;
      vertex(p2.x +vibration, p2.y +vibration, p2.z +vibration) ;
      endShape(CLOSE) ;
    }
  }
  
  
  // soleil with jitter
  public void soleil(PVector pos, int diam, int numBeam, float jitter) {
    int numPoints = numBeam *2 ;
    for (int i = 0 ; i < numPoints -1 ; i = i +2) {
      PVector p1 = new PVector() ;
      PVector p2 = new PVector() ;
      p1 = circle(pos, diam, numPoints, jitter)[i].copy() ;
      p2 = circle(pos, diam, numPoints, jitter)[i +1].copy() ;
  
      beginShape() ;
      vertex(pos.x, pos.y, pos.z) ;
      vertex(p1.x, p1.y, p1.z) ;
      vertex(p2.x, p2.y, p2.z) ;
      endShape(CLOSE) ;
    }
  }
  
  // classic soleil
  public void soleil(PVector pos, int diam, int numBeam) {
    int numPoints = numBeam *2 ;
    for (int i = 0 ; i < numPoints -1 ; i = i +2) {
      PVector p1 = new PVector() ;
      PVector p2 = new PVector() ;
      p1 = circle(pos, diam, numPoints)[i].copy() ;
      p2 = circle(pos, diam, numPoints)[i +1].copy() ;
      beginShape() ;
      vertex(pos.x, pos.y, pos.z) ;
      vertex(p1.x, p1.y, p1.z) ;
      vertex(p2.x, p2.y, p2.z) ;
      endShape(CLOSE) ;
    }
  }
}
//end object two
Spirale spirale ; 
//object three
class SpiraleRomanesco extends Romanesco {
  public SpiraleRomanesco() {
    //from the index_objects.csv
    romanescoName = "Spirale" ;
    IDobj = 13 ;
    IDgroup = 2 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Version 1.3";
    romanescoPack = "Base" ;
    romanescoRender = "P3D" ;
    romanescoMode = "Rectangle/Ellipse/Box" ;
    romanescoSlider = "Hue fill,Saturation fill,Brightness fill,Alpha fill,Hue stroke,Saturation stroke,Brightness stroke,Alpha stroke,Thickness,Size X,Size Y,Size Z,Quantity,Speed,Canvas X,Canvas Y,Canvas Z" ;
  }
  //GLOBAL
     
    float speed ; 
    boolean reverseSpeed;
  //SETUP
  public void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
    spirale = new Spirale() ;
  }
  //DRAW
  public void display() {
    aspect(IDobj) ;
    strokeWeight(thicknessObj[IDobj]*.02f) ;
    //quantity
    int n ;
    int nMax = 1 ;
     nMax = 1 + PApplet.parseInt(quantityObj[IDobj] *300) ; 
    if(!fullRendering) nMax *= .1f ;
    n = nMax ;

    float max = map(width,100,3000,1.0f,1.1f)  ;
    float z = max ;
    //speed
    
    if(rTouch) reverseSpeed = !reverseSpeed ;
    
    if(motion[IDobj]) {
      float s = map(speedObj[IDobj],0,1,0,8) ;
      s *= s ;
      if(reverseSpeed) speed = s *tempo[IDobj] ; else speed = s *tempo[IDobj] *-1.f ;
    } else { 
      speed = 0.0f ;
    }
    //sound volume
    float minValueVol = .8f ;
    float maxValueVol = 2.5f ;
    float volumeLeft = map (left[IDobj], 0,1, minValueVol, maxValueVol ) ;
    float volumeRight = map (right[IDobj], 0,1, minValueVol, maxValueVol ) ;
    float volumeMix = map (mix[IDobj], 0,1, minValueVol, maxValueVol ) ;
    
    
    //SIZE
    float beatMap = map(allBeats(IDobj),1,40,1,50) ;
    float minValueSize = .5f ;
    float maxValueSize = width/250 ;
    float widthTemp = map(sizeXObj[IDobj], .1f, width, minValueSize, maxValueSize) ;
    float heightTemp = map(sizeYObj[IDobj], .1f, width, minValueSize, maxValueSize) ;
    float depthTemp  = map(sizeZObj[IDobj], .1f, width, minValueSize, maxValueSize) ;

    
    float widthObj = pow(widthTemp, 3) *volumeLeft *beatMap ;
    float heightObj = pow(heightTemp, 3) *volumeRight *beatMap ;
    float depthObj = pow(depthTemp, 3) *volumeMix *beatMap ;
    
    PVector size = new PVector(widthObj, heightObj, depthObj) ;
    
    //amplitude of the translate
    float minValueCanvas = 0 ;
    float maxValueCanvas = 4 ;
    float canvasXtemp = map(canvasXObj[IDobj], width *.1f, width,minValueCanvas,maxValueCanvas) ;
    float canvasYtemp = map(canvasYObj[IDobj], width *.1f, width,minValueCanvas,maxValueCanvas) ;
    float canvasZtemp = map(canvasZObj[IDobj], width *.1f, width,minValueCanvas,maxValueCanvas) ;
    PVector canvas = new PVector(canvasXtemp, canvasYtemp, canvasZtemp)  ;
    
    PVector pos = new PVector() ; // we write that because the first part of the void is not available any more.
    spirale.actualisation (pos, speed) ;
    spirale.affichage (n, nMax, size, z, canvas, mode[IDobj]) ;
    
    // info display
    objectInfo[IDobj] = ("Speed "+speed+ " - Amplitude " + map(z, 1.01f, 1.27f, 1,100) + " - Quantity " + nMax) ;
  }
}





//CLASS
class Spirale extends Rotation {  
  Spirale () { 
    super () ;
  }
  float translate = 1.f ;
  float ratioSize = 1.f ;
  public void affichage (int n, int nMax, PVector size, float z, PVector canvas, int mode) {
    n = n-1 ;
    
    translate += z ;
    ratioSize += .1f ;
    
    float ratioRendering = 1.f ;
    if(fullRendering) ratioRendering = 1.f ; else ratioRendering = 6.f ;
    
    
    PVector newSize = new PVector (size.x *ratioSize *ratioRendering, size.y *ratioSize *ratioRendering, size.z *ratioSize *ratioRendering) ;

    //display Mode
    if (mode == 0 )      rect (0,0, newSize.x, newSize.y ) ;
    else if (mode == 1 ) ellipse (0,0,newSize.x,newSize.y) ;
    else if (mode == 2 ) box (newSize.x,newSize.y,newSize.z) ;
    //
    
    translate (translate *canvas.x *ratioRendering,translate *canvas.y *ratioRendering) ;
    rotate ( PI/6 ) ;
    // scale(z) ; 

    if ( n > 0) { 
      affichage (n, nMax, size, z, canvas, mode ) ; 
    } else{
      translate = 1.f ;
      ratioSize = 1.f ;
    }
  }
}
Balise balise ;
//object three
class BaliseRomanesco extends Romanesco {
  public BaliseRomanesco() {
    //from the index_objects.csv
    romanescoName = "Balise" ;
    IDobj = 14 ;
    IDgroup = 2 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Version 1.2";
    romanescoPack = "Base" ;
    romanescoRender = "P3D" ;
    romanescoMode = "Disc/Rectangle/Box/Box Snake" ;
    romanescoSlider = "Hue fill,Saturation fill,Brightness fill,Alpha fill,Hue stroke,Saturation stroke,Brightness stroke,Alpha stroke,Thickness,Size X,Size Y,Size Z,Quantity,Speed,Amplitude,Repulsion" ;
  }
  //GLOBAL
  float speed ;
  boolean change_rotation_direction ;
  //SETUP
  public void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
    balise = new Balise() ;
  }
  //DRAW
  public void display() {
    // authorization to make something with the sound in Prescene mode
    boolean authorization = false ;
    float tempo_balise = 1 ;
    // println(tempo[IDobj]) ;
    if(sound[IDobj] && fullRendering) {
      authorization = true ;
      tempo_balise = tempo[IDobj] ;
    } else {
      tempo_balise = 1.f ;
    }

    //reverse
    int rotation_direction = 1 ;
    if(reverse[IDobj]) rotation_direction = 1 ; else rotation_direction = -1 ;



    if (motion[IDobj]) speed = (map(speedObj[IDobj], 0,1, 0,20)) *tempo_balise *rotation_direction ; else speed = 0.0f ;
    // color and thickness
    aspect(IDobj) ;

    //amplitude
    float amp = map(amplitudeObj[IDobj], 0,1, 0, width *5) ;
    
    //factor size
    float factor = map(repulsionObj[IDobj],0,1,1,100) *(allBeats(IDobj) *.2f) ;
    if(factor < 1.0f ) factor = 1.0f ;


    
    
    
    

    // SIZE
    float factorBeat = .5f ;
    // float tempoEffect = 1 + ((beat[IDobj] -1  ) + (kick[IDobj] -1  ) + (snare[IDobj] -1  ) + (hat[IDobj] -1  ) );
    float tempoEffect = 1 + ((beat[IDobj] *factorBeat) + (kick[IDobj] *factorBeat) + (snare[IDobj] *factorBeat) + (hat[IDobj] *factorBeat));
    PVector sizeBalise = new PVector(sizeXObj[IDobj],sizeYObj[IDobj],sizeZObj[IDobj]) ;
    PVector var = new PVector(1,1) ;
    if(authorization) {
      sizeBalise  = new PVector (sizeXObj[IDobj] *tempoEffect, sizeYObj[IDobj] *tempoEffect, sizeZObj[IDobj] ) ;
      // variable position
      var = new PVector(left[IDobj] *5,right[IDobj] *5) ;
    }
    
    if(var.x <= 0 ) var.x = .1f ; 
    if(var.y <= 0 ) var.y = .1f ; 
    //quantity
    int maxBalise = 511 ;
    if(!fullRendering) maxBalise = 64 ;
    float radiusBalise = map(quantityObj[IDobj], 0,1, 2, maxBalise); // here the value max is 511 because we work with buffersize with 512 field
    
    
    balise.actualisation(mouse[IDobj] , speed) ;
    balise.display(amp, var, sizeBalise, factor, PApplet.parseInt(radiusBalise), authorization, mode[IDobj]) ;
    
    
    objectInfo[IDobj] = ("Size "+(int)sizeBalise.x + " / " + (int)sizeBalise.y + " / " + (int)sizeBalise.z  + " Radius " + PApplet.parseInt(radiusBalise) ) ;
  }
}
//end object two







// CLASS BALISE
class Balise extends Rotation {  
  
  Balise () { super () ; }
  
  public void display (float amp, PVector var, PVector sizeBalise, float factor, int max, boolean authorization, int mode) {
    pushMatrix() ;
    rectMode(CENTER) ;
    
    if ( max > 512 ) max = 512 ;

    for(int i = 0 ; i < max ; i++) {
      PVector v = new PVector(input(i,max,var,authorization).x, input(i,max,var,authorization).y) ;
      PVector posBalise = new PVector ( amp *v.x, amp *v.y ) ;
      v = new PVector (abs(v.x *factor), abs(v.y *factor) ) ;

      PVector newSize = new PVector(sizeBalise.x *v.x, sizeBalise.y *v.y, sizeBalise.z *((v.x +v.y)*.5f))   ;

      if (mode == 0 ) ellipse(posBalise.x, posBalise.y, newSize.x, newSize.y) ;
      if (mode == 1 ) rect   (posBalise.x, posBalise.y, newSize.x, newSize.y) ;
      if (mode == 2 ) boxes(posBalise, newSize, true) ;
      if (mode == 3 ) boxes(posBalise, newSize, false) ;
    }
    rectMode(CORNER) ;
    popMatrix() ;
    noStroke() ;
  }
  
  
  public void boxes(PVector pos, PVector size, boolean snake) {
    if(snake) pushMatrix() ;
    translate(pos.x, pos.y, pos.z) ;
    box(size.x, size.y, size.z) ;
    if(snake) popMatrix() ;
  }
  
  //calculate and return the position for each brick of the balise
  public PVector input( int whichOne, int max, PVector var, boolean authorization) {
    PVector value = new PVector(1,1,1) ;
    if(authorization) {
      value = new PVector ( (input.left.get(whichOne)*var.x), (input.right.get(whichOne)*var.y) ) ; 
    } else {
      float n = (float)whichOne ;
      n = n - (max/2) ;
      value = new PVector ( n*var.x *.01f, n*var.y *.01f ) ; 
    } 
    return value ;
  }
}
class Kofosphere extends Romanesco {
  public Kofosphere() {
    //from the index_objects.csv
    romanescoName = "Kofosphere" ;
    IDobj = 15 ;
    IDgroup = 2 ;
    romanescoAuthor  = "Kof";
    romanescoVersion = "Version 1.0";
    romanescoPack = "Base" ;
    romanescoRender = "P3D" ;
    romanescoMode = "Point color/Point mono/Pox color/Box mono" ;
    romanescoSlider = "Hue stroke,Saturation stroke,Brightness stroke,Alpha stroke,Hue fill,Saturation fill,Brightness fill,Alpha fill,Thickness,Size X,Size Y,Size Z,Canvas X,Quantity,Speed" ;
  }
  //GLOBAL

  Sphere sphere;
  
  //SETUP
  public void setting() {
   // very strange start position to be in the middle of the Scene
   startPosition(IDobj, width/2 -(width/4), height/2 -(height/4), 0) ;
    // startPosition(IDobj, 0, width/2, -(height *2)) ;
    
    float startingRadius = width ;
    
    sphere = new Sphere(startingPosition[IDobj],startingRadius);
  }
  
  
  
  
  //DRAW
  public void display() {
    float beatFactor = map(allBeats(IDobj), 1,12, 1.f, 3.5f) ;
    if(sound[IDobj]) canvasXObj[IDobj] = sq(map(canvasXObj[IDobj], width/10, width, .01f, 1.1f)) *beatFactor ; else canvasXObj[IDobj] = sq(map(canvasXObj[IDobj], width/10, width, .01f, 1.1f)) ;
    
    // quantity of particules
    float quantity = map(quantityObj[IDobj],0 ,1, 10,200);
    // methode to limit the number of particules for the prescene
    if(!fullRendering) quantity /= 10.f ;
    // methode to limit the number of particules for the complexe shape, in this case for the boxes
    if(fullRendering && (mode[IDobj] > 1 && mode[IDobj] < 4)) quantity /= 2.5f ;  
    
    // speed
    if(reverse[IDobj]) speedObj[IDobj] *= .001f ; else speedObj[IDobj] *= -.001f ;
    // size for the box
    float factorSizeDivide = .025f ;
    float newSizeX = sizeXObj[IDobj] *factorSizeDivide ;
    float newSizeY = sizeYObj[IDobj] *factorSizeDivide ;
    float newSizeZ = sizeZObj[IDobj] *factorSizeDivide ;
    // we make a square size to smooth the growth
    PVector size = new PVector(newSizeX *newSizeX, newSizeY *newSizeY,newSizeZ *newSizeZ) ; 
    
    sphere.drawSpheres(size, speedObj[IDobj], canvasXObj[IDobj], quantity, thicknessObj[IDobj], fillObj[IDobj], strokeObj[IDobj],mode[IDobj]);
    

    
    // INFO
    objectInfo[IDobj] = ("Quantity " + (int)quantity +  " - Speed ") ;

  }
  
  
  // ANNEXE VOID
  
}




////////////////////////////////////////////////
class Sphere{
  boolean kofosphereInColor ;
  PVector pos = new PVector();
  float radius;
  float density = 6.f;
  // color colorIn, colorOut;
  float speedRotateX  ;
  float speedRotateY ;

  
  // CONSTRUCTOR
  Sphere(PVector pos, float radius){
    this.pos = pos.copy();
    this.radius = radius;
    // as always
    noiseSeed(19);
  }

  
  
  public void drawSpheres(PVector size, float speed, float radiusFactor, float quantity, float thickness, int colorIn, int colorOut, int mode) {
    //color mode
    if(mode%2==0) kofosphereInColor = true ; else kofosphereInColor = false ;
    
    speed *= 100 ;
    quantity *=.01f ;
    // param
    speedRotateX += speed ;
    speedRotateY += speed ;
    //
    float newRadius =  radius *radiusFactor ;
    /// color
    float hueIn = hue(colorIn) ;
    float saturationIn = saturation(colorIn) ;
    float brightnessIn = brightness(colorIn) ;
    float opacityIn = alpha(colorIn) ;
    
    float hueOut = hue(colorOut) ;
    float saturationOut = saturation(colorOut) ;
    float brightnessOut = brightness(colorOut) ;
    float opacityOut = alpha(colorOut) ;

   

    
    pushMatrix();
    translate(pos.x,pos.y,pos.z);
    
    float d = noise(frameCount/100)*(1500.0f +(1500 *quantity));
    density = 2.9f +(20*(1 -quantity)) ;
    
    //speed rotation
    rotateX(speedRotateX);
    rotateY(speedRotateY);
    
    for(float f = -180 ; f < d; f += density){
      // we put this calcul here, because we don't need this calcul in the next loop.
      // it's more lighty for the computation
      if(kofosphereInColor) {
        hueIn = map(f,0,d,0,360) ;
        hueOut = map(f,0,d,0,360) ;
      }
      colorIn = color(hueIn,saturationIn,brightnessIn,opacityIn);
      colorOut = color(hueOut,saturationOut,brightnessOut,opacityOut);
      

        
      for(float ff = -90 ; ff < 90; ff += density){
        
        // apparence
        float factor = 250.f ;
        float x = cos(radians(f)) *factor  *cos(radians(ff));
        float y = sin(radians(f)) *factor *cos(radians(ff));
        float z = sin(radians(ff)) *factor;
        

        int maxThickness = height/3 ; // it's the max from Romanesco Thickness.
        float factorSize = map(abs(modelZ(x,y,z)),(maxThickness -thickness),0,.005f,1) ;
        
        // position
        float posX = cos(radians(f)) *newRadius *cos(radians(ff));
        float posY = sin(radians(f)) *newRadius *cos(radians(ff));
        float posZ = sin(radians(ff)) *newRadius;
        float deform = noise((frameCount +lerp(f,ff,noise((frameCount+ff)/222.0f))) *.003f) *1.33f;
        
        
        // DISPLAY MODE
        if(mode < 2 ) {
          strokeWeight(factorSize *3);
          stroke(colorIn);
          point(posX *deform,posY *deform,posZ *deform);
        } else if ( mode > 1 && mode < 4 ) {
          pushMatrix() ;
          strokeWeight(thickness);
          stroke(colorOut);
          fill(colorIn);
          translate(posX *deform,posY *deform,posZ *deform) ;
          // box(size.x, size.y, size.z) ;
          box(size.x *factorSize, size.y *factorSize, size.z *factorSize) ;
          popMatrix() ;
        }
        
      }
    }

    // axis();
    popMatrix();

  }

  public void axis(){
    stroke(255,20);
    strokeWeight(3);
    line(-200,0,0,200,0,0);
    line(0,-200,0,0,200,0);
    line(0,0,-200,0,0,200);

  }

}
Line line ;
//object three
class Lignes extends Romanesco {
  public Lignes() {
    //from the index_objects.csv
    romanescoName = "Lignes" ;
    IDobj = 16 ;
    IDgroup = 2 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Version 1.1";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
    romanescoSlider = "Hue fill,Saturation fill,Brightness fill,Alpha fill,Thickness,Quantity,Speed,Direction" ;
  }
  //GLOBAL
  float ampLine  =1.0f ;
  float speed ;
  float thicknessLine ;
  Boolean reverse = false ;
  //SETUP
  public void setting() {
    startPosition(IDobj, 0, 0, 0) ;
    line = new Line() ;
  }
  //DRAW
  public void display() {
    if( beat[IDobj] > 1 ) {
      ampLine = beat[IDobj] *(map(amplitudeObj[IDobj], 0,1, 0, 3)) ;
      thicknessLine = (thicknessObj[IDobj] *ampLine ) ;
    } else {
      thicknessLine = thicknessObj[IDobj] ;
    }

    //speed
    if(motion[IDobj]) speed = map(speedObj[IDobj], 0,1, 0, height/20 ) * tempo[IDobj]  ; else speed = 0.0f ;
    
    if(rTouch) reverse = !reverse ;
    if(reverse) speed = speed *1 ; else speed = speed * -1 ;
    //to stop the move
    if (action[IDobj]  && spaceTouch ) speed = 0.0f ;
    
    // size canvas
    PVector canvas = new PVector (map(canvasXObj[IDobj],width/10, width, height, height *5),map(canvasXObj[IDobj],width/10, width, width, width *5)) ; 
    //quantity
    float q = map(quantityObj[IDobj], 0, 1, canvas.x *.5f, canvas.y *.05f) ;
    //rotation
    rotation(directionObj[IDobj] +180, canvas.x *.5f, canvas.y *.5f ) ;
    //display
    line.drawLine (speed, q , fillObj[IDobj], thicknessLine, canvas, directionObj[IDobj]) ;
    
  }
}
//end 





//CLASS TRAME
class Line {
  Line()  { }
  
  float nbrlgn ; 
  int vitesse ;
  float vd, vg ;
  
  public void drawLine ( float v, float q, int c, float e, PVector canvas, float angle) {
    if( e < 0.1f ) e = 0.1f ; //security for the negative value
     strokeWeight(e) ;
    // security against the black brightness bug opacity
    if (alpha(c) == 0 ) noStroke() ; else stroke (c) ;
    
    float quantite = q*q *.001f ;
    //nbrlgn = quantite ;
   nbrlgn = (canvas.x + canvas.y) / quantite  ;
    vitesse += (v) ;
    if ( abs(vitesse) > quantite ) {
      vitesse = 0 ; 
    }
    for (int i=0 ; i < nbrlgn +1 ; i++) {
      float x1 = ( -(canvas.y) +i*( (canvas.x+ canvas.y ) /nbrlgn) ) +vitesse -e ;
      float y1 = -e ;
      float x2 =  ( 0 +i*( (canvas.x + canvas.y )  /nbrlgn) ) +vitesse +e ;
      float y2 = canvas.x+canvas.y +e ; 
      line ( x1 , y1 , x2 , y2);
      /*
      PVector a = new PVector(x1, y1 ) ;
      PVector b = new PVector(x2, y2 ) ;

      //PVector lattice = new PVector(canvas.x *.5, canvas.y *.5 ) ;
      PVector lattice = new PVector(width/2, height/2 ) ;
      //pushMatrix() ;
      //rotation(angle, canvas.x / nbrlgn , canvas.y / nbrlgn) ;
      rotation(a, lattice, radians(angle)) ;
      //rotation(b, lattice, radians(-angle)) ;
      line(a.x, a.y, b.x, b.y) ;
      //popMatrix() ;
      */
      
      
    }
  }
}
ArrayList<Pixel> encreList = new ArrayList<Pixel>(); ;
ArrayList<Pixel> starList = new ArrayList<Pixel>();

//object one
class Spray extends Romanesco {
  public Spray() {
    //from the index_objects.csv
    romanescoName = "Stars Spray" ;
    IDobj = 17 ;
    IDgroup = 2 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "version 1.1";
    romanescoPack = "Base" ;
    romanescoRender = "P3D" ;
    romanescoMode = "Star/Spray" ;
    romanescoSlider = "Hue fill,Saturation fill,Brightness fill,Alpha fill,Thickness,Size X,Size Y,Canvas X,Canvas Y,Quantity,Speed,Angle,Life,Repulsion" ;
  }
  //GLOBAL
  // INK
  int dry = 100; // time to dry the ink, and pixel stop to move
  float  inkDiffusion = 0.5f ; // size of spray 1 to 8 is good
  int  spray = 10 ; // power of the spray
  int inkFlux = 10 ; // flux is quantity ink for the pen or number of particules create each frame
  float angleSpray = 10.0f ; // like is write
  float factorPressure ;
  PVector sprayDirection ;
  boolean changeColor ;
  
  //GALAXIE
  
  //SETUP
  public void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
  }
  //DRAW
  public void display() {
    // change color pallete
    if(xTouch) changeColor = !changeColor ;
    
    
    if(mode[IDobj] == 0 && clickLongLeft[IDobj] && nLongTouch ) starProduction() ;
    if(mode[IDobj] == 0 ) displayStar() ;
    if(mode[IDobj] == 1 ) encre() ;
    
    // info display
    String whichColor = ("") ;
    if(changeColor) whichColor =("Original Color") ; else whichColor =("Color from Controller") ;
    objectInfo[IDobj] = ("Quantity Ink " +encreList.size() +" Quantity Star " + starList.size() + " / " + whichColor ) ;
    
    
  }
 
  
  //ANNEXE VOID
  
  //STAR PRODUCTION
  float jitterOne, jitterTwo, jitterThree, jitterFour ;
  float thicknessSoundEffect ;
  // display
  public void displayStar() {
    if(sound[IDobj]) {
      jitterOne = 5* random(-beat[IDobj],beat[IDobj]) ;
      jitterTwo = 5* random(-kick[IDobj],kick[IDobj]) ;
      jitterThree = 5* random(-snare[IDobj],snare[IDobj]) ;
      jitterFour = 5* random(-hat[IDobj],hat[IDobj]) ; 
    } else {
      jitterOne = 0 ; 
      jitterTwo = 0 ;
      jitterThree = 0 ;
      jitterFour = 0 ;
    }
    thicknessSoundEffect = 1 + jitterOne ;
      
      
    for (Pixel p : starList) {
      strokeWeight(thicknessObj[IDobj] *thicknessSoundEffect) ;  
      if(changeColor) stroke(hue(p.colour), saturation(p.colour), brightness(p.colour), alpha(fillObj[IDobj])); else stroke(fillObj[IDobj]) ;
      point(p.pos.x +jitterOne, p.pos.y +jitterTwo, p.pos.z +jitterThree) ;
    }
    if (resetAction(IDobj)) starList.clear() ;
  }
  
  // the orderer
  public void starProduction() {
    float depth = map(canvasZObj[IDobj], width/10, width, 0, width *3) ;
    PVector pos = new PVector(mouse[0].x - startingPosition[IDobj].x, mouse[0].y - startingPosition[IDobj].y, depth ) ;
    //tha first value must be smaller than second
    
    int sizeMin = (int)map(sizeXObj[IDobj],0.1f,width,1,20) ;
    int sizeMax = (int)map(sizeYObj[IDobj],0.1f,width,20, width *2) ;
    PVector size = new PVector(sizeMin,sizeMax) ;
    
    int numP = (int)map(quantityObj[IDobj],0,1,10,width) ;
    // limitation for the prescene rendering
    if(!fullRendering) {
      numP *= .001f ;
      if(numP < 5 ) numP = 5 ;
    }
    
    PVector numPoints = new PVector(numP/10,numP) ;
    
    int branchMin = (int)map(canvasXObj[IDobj], width/10, width,1,30) ;
    int branchMax = (int)map(canvasYObj[IDobj], width/10, width, 1, 30) ;
    PVector numBranchs = new PVector(branchMin,branchMax) ;

    int colour = fillObj[IDobj] ;
    int varAngle = (int)map(angleObj[IDobj], 0,360,0,180) ;
    PVector angle = new PVector(0,varAngle) ; // 0-360 degree
    starProducer(pos, size, numPoints, numBranchs, angle, colour) ;
  }
  
  // the factory
  public void starProducer(PVector pos, PVector size, PVector points, PVector branch,  PVector angle, int c) {
    if(points.x > points.y) points.x = points.y ;
    if(branch.x > branch.y) branch.x = branch.y ;
    if(angle.x > angle.y) angle.x = angle.y ;
    if(size.x > size.y) size.x = size.y ;
    
    int num = (int)round(random(branch.x , branch.y )) ;
    int startDirection = (int)random(angle.x,angle.y) ;
    int sizeStar = (int)random(size.x,size.y) ;
    star(pos, sizeStar, startDirection, (int)points.x, (int)points.y, num, c) ;
  }
  
  // the object
  public void star(PVector pos, int size,int direction, int min, int max, int numBranch, int colour) {
    pos.z = random(-pos.z, pos.z) ;
    float floatDirection = PApplet.parseFloat(direction) ;
    for (int i = 0 ; i < numBranch ; i++ ) {
      // give the direction of each branch
      float addDegree = 360.0f / PApplet.parseFloat(numBranch) ;
      floatDirection += addDegree ;
      // distribution points on the branch
      int n = (int)random(min,max) ;
      for ( int j = 0 ; j < n ; j++ ) {
        PVector posAroundTheStar = new PVector(0,0) ;
        PVector posFinal = new PVector(0,0) ;
        
        PVector dir = new PVector (0,0) ;
        dir = normalDir((int)floatDirection) ;
        //distrubution in each branch
        float factor = random(0,1) ;
        float newDistance = 0 ;
        newDistance = pow(factor,2) *size ;
        posAroundTheStar = new PVector(dir.x *newDistance, dir.y *newDistance) ;
        
        posFinal.add(posAroundTheStar) ;
        posFinal.add(pos) ;
        starList.add(new Pixel(posFinal, colour)) ;
        posAroundTheStar = new PVector(0,0) ;
      }
    }
  }
  // END STAR PROD
  ////////////////

  
  
  /////
  //INK
  public void encre() {
    factorPressure = map(pen[0].z, 0, 1, 1, 50 ) ;
    sprayDirection = new PVector (pen[0].x,pen[0].y) ;
    inkDiffusion = map (speedObj[IDobj] , 0,1, 0, 100 *tempo[IDobj]  ) ; // speed / vitesse
    
    float flux = map (quantityObj[IDobj], 0,1, 10,1000) ; // ink quantity
    if(!fullRendering) flux = 10 ; // limitation for the prescene rendering
    
    float thicknessPoint = thicknessObj[IDobj]*.1f ;
    inkFlux = PApplet.parseInt(flux) ;
    angleSpray   = map (angleObj[IDobj], 0,360, 0,180 ) ; // angle
    dry = (int)map(lifeObj[IDobj], 0,1, frameRate , 100000) ; // dur\u00e9e
    float spr ;
    spr = map(repulsionObj[IDobj],0,1, 1, width) ; // force de diffusion
    spray = PApplet.parseInt(spr) ;
    
    // INK DRY
    float var = tempo[IDobj] ;
    float timeDry = 1.0f / PApplet.parseFloat(dry) ;
  
   // add encre
   int security ;
   if (fullRendering) security = 1000000 ; else security = 5000 ;
   if (action[IDobj] && nLongTouch && clickLongLeft[0] && encreList.size() < security) addEncre(factorPressure, sprayDirection, angleSpray, spray, inkDiffusion, inkFlux, fillObj[IDobj]) ; 
  
    //display
    for ( Pixel e :  encreList ) {
      if (action[IDobj]) e.drying(var, timeDry) ;
      strokeWeight(thicknessPoint) ;
      noFill() ;
      if(changeColor) stroke(hue(e.colour), saturation(e.colour), brightness(e.colour), alpha(fillObj[IDobj])); else stroke(fillObj[IDobj]) ;
      point(e.pos.x, e.pos.y) ;
    }
    
    /////////////////////////////
    //CLEAR THE LIST IF NECESSARY 
    if (resetAction(IDobj)) encreList.clear() ;
  }
  public void addEncre(float fp, PVector d, float a, int spray, float diffusion, int flux, int colorInk) {
    for ( int i = 0 ; i < flux *fp ; i++ ) {
      
      //to make a good Spray, use a good distribution
      float distribution = random(1) *random(1) ;
      //distribution pixel on the axe, before splash on the angle distribution
      // also we use to the strong push of the pen to the spray longer 
      float distance = spray * fp * distribution  ;
      //angle projection spray
      float angleDeg = random(-a, a);
      float angle = radians(angleDeg) ;
      // calcul of the absolute position of each pixel
      PVector tilt = new PVector ( pen[0].x *distance, pen[0].y *distance ) ;
      //position the pixel around the laticce, pivot...
      PVector posTilt = new PVector ( mouse[0].x - tilt.x , mouse[0].y - tilt.y  ) ;
      
      //calcul the final position to display
      mouse[IDobj].x = rotation(posTilt, mouse[0], angle).x ;
      mouse[IDobj].y = rotation(posTilt, mouse[0], angle).y ;
      mouse[IDobj].sub(startingPosition[IDobj]) ;

      
      //put the pixel in the list to use peacefully
      encreList.add( new Pixel( mouse[IDobj], diffusion, colorInk)) ;
    }
  }
  
  public void resetEncre() {
    encreList.clear() ;
  }
  //END INK
  /////////
}
//end object one




  
Trame trame ;
//object three
class Damier extends Romanesco {
  public Damier() {
    //from the index_objects.csv
    romanescoName = "Damier" ;
    IDobj = 18 ;
    IDgroup = 2 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Version 1.1";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
    romanescoMode = "Rectangle/Ellipse/Box" ;
    romanescoSlider = "Hue fill,Saturation fill,Brightness fill,Alpha fill,Hue stroke,Saturation stroke,Brightness stroke,Alpha stroke,Thickness,Size X,Size Y,Size Z,Quantity,Speed,Amplitude" ;
  }
  //GLOBAL
  float d, g, m ;
  PVector size = new PVector(0,0,0) ;
  float angleTrame = 0 ;
  float angle = 0 ;
  float speed = 0 ;
  boolean reverse = false ;

  //SETUP
  public void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
    trame = new Trame() ;

  }
  //DRAW
  public void display() {
    // color and thickness
    aspect(IDobj) ;
    
    if ( sound[IDobj]) {
      g = map(left[IDobj],0,1,1,5) ; 
      d = map(right[IDobj],0,1,1,5) ; 
      m = map(mix[IDobj],0,1,1,5) ;
    } else {  
      g = 1.0f ;
      d = 1.0f ;
      m = 1.0f ;
    }
    float penPressure = map(pen[IDobj].z,0,1,1,width/100) ;
    float sizeXtemp = map(sizeXObj[IDobj],.1f,width,.1f,width/33) ;
    float sizeYtemp = map(sizeYObj[IDobj],.1f,width,.1f,width/33) ;
    float sizeZtemp = map(sizeZObj[IDobj],.1f,width,.1f,width/33) ;
    size.x = ((sizeXtemp *sizeXtemp) *penPressure *allBeats(IDobj) ) *g ;
    size.y = ((sizeYtemp *sizeYtemp) *penPressure *allBeats(IDobj)) *d ;
    size.z = ((sizeZtemp *sizeZtemp) *penPressure *allBeats(IDobj)) *m  ;
    //size

    //orientation / deg
    //speed
    speed = map(speedObj[IDobj], 0,1,0, 0.5f );
    if(rTouch) reverse = !reverse ;
    if(reverse) speed = speed *1 ; else speed = speed * -1 ;
    if (speed != 0 && motion[IDobj]) angleTrame += speed *tempo[IDobj] ;
    
    
    //rotation of the single shape
    if (action[IDobj]) angle = map(angleObj[IDobj], 0,100, 0, TAU) ; 
    
    //quantity
    int q = PApplet.parseInt(map(quantityObj[IDobj], 0, 1, 2, 15)) ;

    //amp
    float amp = map(amplitudeObj[IDobj],0,1, .1f, height /200) ;
    
    //MODE DISPLAY
    if(mode[IDobj] == 0 || mode[IDobj] == 255) trame.drawTrameRect(mouse[IDobj], angleTrame, angle, size , q, g, d, amp) ;
    else if (mode[IDobj] == 1) trame.drawTrameDisc(mouse[IDobj], angleTrame, angle, size , q, g, d, amp) ;
    else if (mode[IDobj] == 2) trame.drawTrameBox(mouse[IDobj], angleTrame, angle, size , q, g, d, amp) ;
    
    //INFO
    objectInfo[IDobj] =("Quantity " + q + " shapes / Angle " + (int)angle + " Speed " + PApplet.parseInt(speed *100) + " Amplitude " + PApplet.parseInt(amp *100)) ;
    
  }
  
}
//end object two





/////////////
//CLASS TRAME
class Trame {
  Trame(){}
  
  float nbrlgn ; 
  int vitesse ;
  
  //TRAME RECTANGLEe multiple
  public void drawTrameRect (PVector axe, float angleTrame, float angleObj, PVector size, int nbrlgn, float gauche, float droite, float amp ) {
    pushMatrix() ;
    translate(axe.x, axe.y) ;
    //calcul the position of each object
    for (int i=1 ; i < nbrlgn ; i++) {
      for (int j=1 ; j < nbrlgn ; j++) { 
        PVector pos = new PVector (  (i *width *amp) / nbrlgn, (j *height *amp ) / nbrlgn )  ;
        PVector newPosAfterRotation = rotation(pos, axe, angleTrame) ;        
        rectangleTrame (newPosAfterRotation, size.x, size.y, gauche, droite, angleObj ) ;      
      }
    }
    popMatrix() ;  
  }
  
  
  
  
  //TRAME DISC multiple
  public void drawTrameDisc (PVector axe, float angleTrame, float angleObj, PVector size, int nbrlgn, float gauche, float droite, float amp   ) {
    pushMatrix() ;
    translate(axe.x, axe.y) ;
    //calcul the position of each object
    for (int i=1 ; i < nbrlgn ; i++) {
      for (int j=1 ; j < nbrlgn ; j++) {
        PVector pos = new PVector (  (i *width *amp ) / nbrlgn, (j * height *amp ) / nbrlgn )  ;
        PVector newPosAfterRotation = rotation(pos, axe, angleTrame) ;        
        disqueTrame (newPosAfterRotation, size.x, size.y, gauche, droite, angleObj ) ;      
      }
    }
    popMatrix() ;  
  }
  
  
  //TRAME BOX
  public void drawTrameBox (PVector axe, float angleTrame, float angleObj, PVector size, int nbrlgn, float gauche, float droite, float amp   ) {
    pushMatrix() ;
    translate(axe.x, axe.y) ;
    //calcul the position of each object
    for (int i=1 ; i < nbrlgn ; i++) {
      for (int j=1 ; j < nbrlgn ; j++) {
        PVector pos = new PVector (  (i *width *amp ) / nbrlgn, (j * height *amp ) / nbrlgn )  ;
        PVector newPosAfterRotation = rotation(pos, axe, angleTrame) ;        
        boxTrame (newPosAfterRotation, size, gauche, droite, angleObj ) ;      
      }
    }
    popMatrix() ;  
  }
  
  public void rectangleTrame( PVector pos, float h, float l, float gauche, float droite, float aObj) {
    pushMatrix() ;
    rectMode(CENTER) ;
    translate(pos.x, pos.y) ;
    rotate(aObj) ;
    rect (0, 0, pow(l,1.4f), pow(h,1.4f)) ;
    rectMode(CORNER) ;
    popMatrix() ;
  }
  
  public void disqueTrame( PVector pos, float h, float l, float gauche, float droite, float aObj) {
    pushMatrix() ;
    ellipseMode(CENTER) ;
    translate(pos.x, pos.y) ;
    rotate(aObj) ;
    ellipse (0, 0, pow(l,1.4f), pow(h,1.4f)) ;
    ellipseMode(CORNER) ;
    popMatrix() ;
  }
  
  public void boxTrame( PVector pos, PVector size, float gauche, float droite, float aObj) {
    pushMatrix() ;
    translate(pos.x, pos.y) ;
    rotate(aObj) ;
    box (pow(size.x,1.4f), pow(size.y,1.4f), pow(size.z,1.4f)) ;
    popMatrix() ;
  }
}
class Anillos extends Romanesco {
 
  public Anillos() {
    romanescoName = "Anillos" ;
    IDobj = 19 ;
    IDgroup = 2 ;
    romanescoAuthor  = "David Robayo";
    romanescoVersion = "Version 0.0.2";
    romanescoPack = "Workshop june 2015" ;
    romanescoMode = "" ; // separate the differentes mode by "/"
    romanescoSlider = "Hue fill,Saturation fill,Brightness fill,Alpha fill,Hue stroke,Saturation stroke,Brightness stroke,Alpha stroke,Thickness,Size X,Quantity,Angle,Amplitude,Analyze" ;
  }
    // declare VAR
  //////////////
  float radius = .1f;
  float S = 10;
  float T = 10;
  
 // int N = 25;
  
  float ringX[] ;
  float ringY[] ;
  float ringK[] ;
 
  // Main method
  int NUM_ANNILOS_MAX = 30;
  int num_anillos;
 
  // setup
  public void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
    anillos_setting(num_anillos) ;
   
   }

   int num_ref_anillos ;
   // draw
   public void display() {
    aspect() ;

    float z = allBeats(IDobj) *10 ;
    float x = mouse[IDobj].x *2 ;
    float y = mouse[IDobj].y *2 ;
    Vec3 mouse_pos = Vec3(x, y, z) ;
   
    inter(mouse_pos, num_anillos) ;
    // display
   

 
    num_anillos = PApplet.parseInt( NUM_ANNILOS_MAX * quantityObj[IDobj] ) ;
   
    if( num_anillos != num_ref_anillos) {
        anillos_setting(num_anillos) ;
        num_ref_anillos = num_anillos ;
    }
  }
   
   
   
    
   
    // info
   
    /*
    Don't use with peasy cam
    */
    // objectInfo[IDobj] =("Hello, I'm "+IDobj+" and I'm not an integer. Je suis St\u00e9phanie Lebon !!") ;
 
  // annexe void
  public void aspect()   {
    stroke(
        hue(strokeObj[IDobj]),
        saturation(strokeObj[IDobj]),
        brightness(strokeObj[IDobj]),
        map(alpha(strokeObj[IDobj]),0.0f, 100.0f, 0, 30.0f)
        );
    strokeWeight(map(thicknessObj[IDobj], 0.1f , height/3, 0, width/12));
  }

  public void inter(Vec3 pos, int N)  {
    //println("je suis l\u00e0", frameCount) ;
    // calcul pos y
    for (int i = 0; i < N; i++) {
      ringY[i] += 0.2f * (N - i) * (pos.x - ringY[i]) / N;
    }
    for (int i = 0; i < N; i++) {
      ringY[i] -= 0.2f * (N - i) * (pos.y - ringY[i]) / N;
    }
   

    // diam
    float diam = radius *sizeXObj[IDobj] *allBeats(IDobj) ;
    float orientation = S *map(angleObj[IDobj],0,360,0,1);
    float effevtiveT = T *analyzeObj[IDobj];
   
    // render
    for (int i = N - 1; i >= 0; i--) {
      fill(hue(0+fillObj[IDobj]), saturation(fillObj[IDobj]), brightness(fillObj[IDobj]), alpha(fillObj[IDobj]));
      float x = ringX[i] -(ringX[i] /2) ;
      float y = ringY[i] -(ringY[i] / 2) ;
      Vec3 new_pos = Vec3(x ,  y, pos.z) ;
      drawCurl(new_pos, diam *ringK[i], -orientation *ringK[i], effevtiveT);
    }
   
     for (int i = 0; i < N; i++) {
      fill(hue(360-fillObj[IDobj]), saturation(fillObj[IDobj]), brightness(fillObj[IDobj]), alpha(fillObj[IDobj]));
      float x = ringX[i] -(ringX[i] /2) ;
      float y = ringY[i] -(ringY[i] / 2) ;
      Vec3 new_pos = Vec3(x ,  y, pos.z) ;
      drawCurl(new_pos, diam *ringK[i], +orientation *ringK[i], effevtiveT);
    }
   
   
  }
 
 
  // set your anillos
  public void anillos_setting(int N) {
      ringX = new float[N];
      ringY = new float[N];
      ringK = new float[N];
     for (int i = 0; i < N; i++) {
        ringX[i] = 0.5f * width/2;
        ringY[i] = 0.5f * height/2;
        ringK[i] = i + 1;
     }
   }



  public void drawCurl(Vec3 pos, float r, float s, float t) {
      pushMatrix();
      translate(pos.x, pos.y, pos.z);
      beginShape();
      vertex(-r, -t);
      bezierVertex(-r, s - t, +r, s - t, +r, -t);
      vertex(+r, +t);
      bezierVertex(+r, s + t, -r, s + t, -r, +t);
      endShape(CLOSE);
      popMatrix();
  }
}
class Galaxie extends Romanesco {
  public Galaxie() {
    //from the index_objects.csv
    romanescoName = "Galaxie" ;
    IDobj = 20 ;
    IDgroup = 2 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Version 1.3";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
    romanescoMode ="Point/Ellipse/Rectangle/Box" ;
    romanescoSlider = "Hue fill,Saturation fill,Brightness fill,Alpha fill,Hue stroke,Saturation stroke,Brightness stroke,Alpha stroke,Thickness,Size X,Size Y,Size Z,Canvas X,Canvas Y,Quantity,Speed,Influence" ;
  }
  //GLOBAL
    boolean makeSand = true ;
  boolean shiftGrain = false ;
  boolean gravityGrain = true ;
  PVector posCenterGrain = new PVector(0,0,0) ;

  PVector orientationStyletGrain ;

  int numGrains ;
  int numFromController ;
  PVector [] grain ;
  float vitesseGrainA = 0.0f;
  float vitesseGrainB = 0.0f ;
  PVector vitesseGrain = new PVector (0,0) ;
  float speedDust ;
  //vibration
  float vibrationGrain = 0.1f ;
  //the stream of sand
  PVector deformationGrain = new PVector () ;

  PVector motionGrain = new PVector () ;
  //float newRayonGrain = 1 ;
  float variableRayonGrain = -0.001f ;
  //float variableRayonGrain = -0.1 ;
  
  
  //SETUP
  public void setting() {
    startPosition(IDobj, 0, 0, 0) ;
  }
  //DRAW
  public void display() {
    
    //surface
    PVector marge = new PVector(map(canvasXObj[IDobj],width/10, width, width/20, width*10), map(canvasYObj[IDobj],width/10, width, height/20, height*10), map(canvasZObj[IDobj], width/10, width, width/10, width *10))  ;
    PVector surface = new PVector(marge.x *2 +width, marge.y *2 +height) ;
    
    //quantity of star
    float max = 1500 ;
    float min = 300 ;
    if(!fullRendering ) {
      min = 30 ;
      max = 150 ;
    }
    float quantity = map(quantityObj[IDobj],0,1,min,max) ;
    if (mode[IDobj] == 0 ) numFromController = PApplet.parseInt(quantity *10) ; else numFromController = PApplet.parseInt(quantity) ;
    

    if ((numGrains != numFromController && parameterButton[IDobj] == 1) || resetAction(IDobj) ) makeSand = true ;
    
    if (makeSand) {
      numGrains = numFromController ;
      grainSetup(numGrains, marge) ;
      makeSand = false ;
    }
 
    //give back the pen info
    float pressionGrain = sq(1 + pen[IDobj].z) ;
    orientationStyletGrain = new PVector ( pen[IDobj].x *10.0f , pen[IDobj].y *10.0f ) ;
    deformationGrain = orientationStyletGrain.copy() ; ;
    
    // speed / vitesse
     speedDust = map(speedObj[IDobj],0,1, 0.00005f ,.5f) ; 
     if(sound[IDobj]) speedDust *= 3 ;
        
    vitesseGrainA = map(left[IDobj],0,1, 1, 17) ;
    vitesseGrainB = map(right[IDobj],0,1, 1, 17) ;
    

    
    vitesseGrain.x = vitesseGrainA *speedDust *tempo[IDobj] *pressionGrain  ;
    vitesseGrain.y = vitesseGrainB *speedDust *tempo[IDobj] *pressionGrain  ;
    if(reverse[IDobj]) {
      vitesseGrain.x = vitesseGrain.x *1 ; 
      vitesseGrain.y = vitesseGrain.y *1 ; 
    } else {
      vitesseGrain.x = vitesseGrain.x *-1 ;
      vitesseGrain.y = vitesseGrain.y *-1 ;
    }
    
    // force
    int maxInfluence = 11 ;
    variableRayonGrain = map(influenceObj[IDobj], 0,1, 0, maxInfluence ) ;
    
    //size
    float objWidth =  .1f +sizeXObj[IDobj] *mix[IDobj] ;
    float objHeight = .1f +sizeYObj[IDobj] *mix[IDobj] ;
    float objDepth = .1f +sizeZObj[IDobj] *mix[IDobj] ;
    PVector size = new PVector(objWidth, objHeight,objDepth) ;
    
    //thickness / \u00e9paisseur
    float e = thicknessObj[IDobj] ;

    int colorIn = fillObj[IDobj] ;
    int colorOut = strokeObj[IDobj] ;
    

    
    // Axe rotation
    posCenterGrain = mouse[IDobj].copy() ;
    //ratio transformation du canvas
    float ratioX = surface.x / PApplet.parseFloat(width) ;
    float ratioY = surface.y / PApplet.parseFloat(height) ;
    
    PVector newPosCenterGrain = new PVector() ;
    newPosCenterGrain.x = posCenterGrain.x *ratioX -marge.x ;
    newPosCenterGrain.y = posCenterGrain.y *ratioY -marge.y ;
    // copy the final result
    posCenterGrain = newPosCenterGrain.copy() ;
    
    /////////
    //UPDATE
    if(motion[IDobj]) if (speedObj[IDobj] >= 0.01f) updateGrain(upTouch, downTouch, leftTouch, rightTouch, clickLongLeft[IDobj], marge);
    
    //////////////
    //DISPLAY MODE
    if (mode[IDobj] == 0) {
      pointSable(e, colorIn) ;
    } else if (mode[IDobj] == 1 ) {
      ellipseSable(size,e , colorIn, colorOut) ;
    } else if (mode[IDobj] == 2 ) {
      rectSable(size,e , colorIn, colorOut) ;
    } else if (mode[IDobj] == 3 ) {
      boxSable(size,e , colorIn, colorOut) ;
    } else {
      pointSable(objWidth, colorIn) ;
    }
    
   
    
    
    // INFO DISPLAY
    objectInfo[IDobj] =("Quantity " +numGrains + " - Canvas " + (int)surface.x + "x" + (int)surface.y + " - Center Galaxy " + PApplet.parseInt(posCenterGrain.x +marge.x) + "x" + PApplet.parseInt(posCenterGrain.y +marge.y) + " - speed" +PApplet.parseInt(speedDust *200.f)) ;
    if (objectInfoDisplay[IDobj]) {
      strokeWeight(1) ;
      stroke(blanc) ;
      noFill() ;
      text("Galaxy center", posCenterGrain.x +5, posCenterGrain.y -5) ; 
      line(-marge.x,       posCenterGrain.y, width +marge.x, posCenterGrain.y ) ;
      line(posCenterGrain.x, -marge.y,       posCenterGrain.x, marge.y +height ) ;
      
      rect(-marge.x, -marge.y, marge.x *2 + width, marge.y *2 + height) ;
    }
  }
  // END DISPLAY
  
  
  
    
    
  
  
  
  
  
  
  //ANNEXE VOID
  //DISPLAY MODE
  public void pointSable(float diam, int c) {
    for(int j = 0; j < grain.length; j++) {
      strokeWeight(diam) ;
      stroke(c) ;
      point(grain[j].x, grain[j].y);
      //set(int(grain[j].x), int(grain[j].y), colorIn);
    }
  }
  //
  public void ellipseSable(PVector size, float e, int cIn, int cOut) {
    for(int j = 0; j < grain.length; j++) {
      strokeWeight(e) ;
      stroke(cOut) ;
      fill(cIn) ;
      ellipse(grain[j].x, grain[j].y, size.x, size.y);
      //set(int(grain[j].x), int(grain[j].y), colorIn);
    }
  }
  // rect
  public void rectSable(PVector size, float e, int cIn, int cOut) {
    for(int j = 0; j < grain.length; j++) {
      strokeWeight(e) ;
      stroke(cOut) ;
      fill(cIn) ;
      rect(grain[j].x, grain[j].y, size.x, size.y);
      //set(int(grain[j].x), int(grain[j].y), colorIn);
    }
  }
  
  public void boxSable(PVector size, float e, int cIn, int cOut) {
    /* we change a little bit the z position, to have a good rendering when there is superpostion of the shape */
    float modificationPosZ = 0 ;
    float ratio = .001f ;
    for(int j = 0; j < grain.length; j++) {
       modificationPosZ += ratio ;
      strokeWeight(e) ;
      stroke(cOut) ;
      fill(cIn) ;
      
      pushMatrix() ;
      translate(grain[j].x, grain[j].y, modificationPosZ) ;
      box(size.x, size.y, size.z);
      popMatrix() ;
      //set(int(grain[j].x), int(grain[j].y), colorIn);
    }
  }
  
  //SETUP
  public void grainSetup(int num, PVector marge) {
    grain = new PVector [num] ;
    for(int i = 0; i < num ; i++) {
      grain[i] = new PVector (random(-marge.x, width +marge.x), random(-marge.y, height +marge.y)) ;
    }
    makeSand = true ;
  }
    
    
  //void update  
  public void updateGrain(boolean up, boolean down, boolean leftSide, boolean rightSide, boolean mouseClic, PVector area) {
    
    for(int i = 0; i < grain.length; i++) {
      // newRayonGrain = newRayonGrain -variableRayonGrain ;
      
      motionGrain.x = grain[i].x -posCenterGrain.x -(deformationGrain.x +right[IDobj]) +variableRayonGrain ;
      motionGrain.y = grain[i].y -posCenterGrain.y -(deformationGrain.y +left[IDobj] ) +variableRayonGrain ;
  
      PVector posGrain = new PVector () ;
      float r = dist(grain[i].x/vitesseGrain.x, grain[i].y /vitesseGrain.x, PApplet.parseInt(posCenterGrain.x) /vitesseGrain.x, PApplet.parseInt(posCenterGrain.y) /vitesseGrain.x);
      
      //spiral rotation
      if (mouseClic) {
        posGrain.x = cos(-1/r*vitesseGrain.y)*motionGrain.x - ( sin(-1/r*vitesseGrain.y)*motionGrain.y );
        posGrain.y = sin(-1/r*vitesseGrain.y)*motionGrain.x + ( cos(-1/r*vitesseGrain.y)*motionGrain.y );
      } else {
        posGrain.x = cos(1/r*vitesseGrain.y)*motionGrain.x - ( sin(1/r*vitesseGrain.y)*motionGrain.y );
        posGrain.y = sin(1/r*vitesseGrain.y)*motionGrain.x + ( cos(1/r*vitesseGrain.y)*motionGrain.y );
      }
      
      // to make line veticale or horizontal
      if (rightSide || leftSide  ) {
        posGrain.x = cos(1/r*vitesseGrain.y)*motionGrain.x ;
        posGrain.y = sin(1/r*vitesseGrain.y)*motionGrain.x ;
      } else if (down || up) {
        posGrain.x = sin(-1/r*vitesseGrain.y)*motionGrain.y ;
        posGrain.y = cos(-1/r*vitesseGrain.y)*motionGrain.y ;
      }

      
      //the dot follow the mouse  
      posGrain.x += posCenterGrain.x;
      posGrain.y += posCenterGrain.y;
      
      PVector vibGrain = new PVector(random(-vibrationGrain,vibrationGrain), random(-vibrationGrain,vibrationGrain), random(-vibrationGrain,vibrationGrain) ) ; 
      //return pos of the pixel
      grain[i].x = posGrain.x + vibGrain.x;
      grain[i].y = posGrain.y + vibGrain.y;
      
      // wall to move the pos to one border to other
      //marge around the scene
      float margeWidth = area.x ;
      float margeHeight = area.y ;
      if(grain[i].x > width +margeWidth) grain[i].x = -margeWidth;
      if(grain[i].x < -margeWidth)     grain[i].x = width +margeWidth;
      if(grain[i].y > height + margeHeight) grain[i].y = -margeHeight;
      if(grain[i].y < -margeHeight)     grain[i].y = height +margeHeight;
    }
  }

}
ArrayList <Hexagon> grid = new ArrayList <Hexagon> (); // the arrayList to store the whole grid of cells

class Honeycomb extends Romanesco {
  public Honeycomb() {
    //from the index_objects.csv
    romanescoName = "Nid d'abeilles" ;
    IDobj = 21 ;
    IDgroup = 2 ;
    romanescoAuthor  = "Amnon Owed";
    romanescoVersion = "Version 0.1";
    romanescoPack = "Base" ;
    romanescoRender = "P3D" ;
    romanescoMode = "" ;
    romanescoSlider = "Saturation fill,Brightness fill,Alpha fill,Thickness,Size X,Canvas X,Canvas Y" ;
  }
  //GLOBAL
  boolean newHoneycomb  ;
  float hexagonRadius = 8.8f; // the radius of the individual hexagon cell
  float radiusRef = hexagonRadius ;
  float hexagonStroke = 3.0f; // stroke weight around hexagons (simulated! much faster than using the stroke() method)
  float strokeRef = hexagonStroke ;
  float neighbourDistance = hexagonRadius*2 ; // the default distance to include up to 6 neighbours
  PVector canvas, canvasRef ;
  
  float sliderCanvasX, sliderCanvasY, sliderCanvasXref, sliderCanvasYref ;
  boolean initRef = true ;

  
  PVector[] v = new PVector[6]; // an array to store the 6 pre-calculated vertex positions of a hexagon

  //SETUP
  public void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
    canvas = new PVector(width, height) ;
    canvasRef = canvas.copy();
    initGrid(canvas); // initialize the CA grid of hexagons (including neighbour search and creation of hexagon vertex positions)
  }
  //DRAW
  public void display() {
    neighbourDistance = hexagonRadius *2;
    hexagonStroke = thicknessObj[IDobj] ;
    hexagonRadius = map(sizeXObj[IDobj],.1f,width, width /40, width/15)  ;

    
    // limitation for the preview
    int minSize = width/80 ;
    if(fullRendering) {
      sliderCanvasX = map(canvasXObj[IDobj], width/10, width, minSize, width *4) ;
      sliderCanvasY = map(canvasYObj[IDobj], width/10, width, minSize, width *4) ;      
    } else {
      sliderCanvasX = map(canvasXObj[IDobj], width/10, width, minSize, width) ;
      sliderCanvasY = map(canvasYObj[IDobj], width/10, width, minSize, width) ;
    }
    
    
    canvas = new PVector(sliderCanvasX,sliderCanvasY) ;
      
    // Good idea to lock the value when you come back for a new slider setting, must work around this concept
    if(initRef) {
      sliderCanvasXref = sliderCanvasX ;
      sliderCanvasYref = sliderCanvasY ;
      initRef = false ;
    }

    sliderCanvasXref = sliderCanvasX ;
    sliderCanvasYref = sliderCanvasY ;
    
    // music factor
    float soundSizeFactor ;
    if(getTimeTrack() > 0.2f) soundSizeFactor = allBeats(IDobj) ; else soundSizeFactor = 1.0f ;
    

    if(hexagonRadius != radiusRef || hexagonStroke != strokeRef || (canvas.x != canvasRef.x || canvas.y != canvasRef.y) ) {
      initGrid(canvas);
    }
    //update the reference
    canvasRef = canvas.copy() ;
    strokeRef = hexagonStroke ;
    radiusRef = hexagonRadius ;
    
    // DISPLAY
    noStroke() ;
    pushMatrix() ;
    translate(-width/2, -height/2) ;
    for (Hexagon h : grid) { h.calculateNewColor(); }
  
    // change the color of each hexagon cell to the new color and display it
    // this can be done in one loop because all calculations are already finished
    
    for (Hexagon h : grid) {
      h.changeColor();
      h.display(v, fillObj[IDobj],soundSizeFactor);
    }
    popMatrix() ;
    
    // new honeycomb
    //if((action[IDobj] && xTouch) || allBeats(IDobj) >= 3.125 ) newHoneycomb = true ;
    if((action[IDobj] && xTouch)) newHoneycomb = true ;
    
    if(newHoneycomb) {
      float r = random(1000000); // random number that is used by all the hexagon cells...
      for (Hexagon h : grid) { h.resetColor(r); } // ... to generate a new color
      newHoneycomb = false ;
    }
    
    
    // INFO
    objectInfo[IDobj] = (grid.size() + " hexagons") ;
  }
  
  
  
  // ANNEXE VOID
  // do everything needed to start up the grid ONCE
  public void initGrid(PVector canvas) {
    grid.clear(); // clear the grid
    
    // calculate horizontal grid size based on sketch width, hexagonRadius and a 'safety margin'
    int hX = PApplet.parseInt(canvas.x/hexagonRadius/3)+2;
    // calculate vertical grid size based on sketch height, hexagonRadius and a 'safety margin'
    int hY = PApplet.parseInt(canvas.y/hexagonRadius/0.866f)+3;
    
    // create the grid of hexagons
    for (int i=0; i<hX; i++) {
      for (int j=0; j<hY; j++) {
        // each hexagon contains it's xy position within the grid (also see the Hexagon class)
        grid.add(new Hexagon(i, j,hexagonRadius) );
      }
    }
    
    // let each hexagon in the grid find it's neighbours
    for (Hexagon h : grid) {
      h.getNeighbours(neighbourDistance);
    }
    
    // create the vertex positions for the hexagon
    for (int i=0; i<6; i++) {
      float r = hexagonRadius - hexagonStroke * 0.5f; // adapt radius to facilitate the 'simulated stroke'
      float theta = i*PI/3;
      v[i] = new PVector(r*cos(theta), r*sin(theta));
    }
  }
}
//end object two







/*

 Hexagon class to store a single cell inside a grid that can do the following things:
 - calculate it's own actual xy position based on it's ij coordinates within the grid
 - find it's neighbours within the grid based on a distance function
 - set it's color based on my own experimental color formula ;-)
 - calculate the average color of it's neighbours
 - calculate it's new color based on a set of rules
 - change it's current color by it's new color
 - display itself as a colored hexagon
 
*/

class Hexagon {
  float x, y; // actual xy position
  ArrayList <Hexagon> neighbours = new ArrayList <Hexagon> (); // arrayList to store the neighbours
  float currentColor, newColor; // store the current and new colors (actually just the hue)

  Hexagon(int i, int j, float radius) {
    x = 3*radius*(i+((j%2==0)?0:0.5f)); // calculate the actual x position within the sketch window
    y = 0.866f*radius*j; // calculate the actual y position within the sketch window
    resetColor(0); // set the initial color
  }

  public void resetColor(float r) {
    currentColor = (r+sin(x+r*0.01f)*30+y/6)%360; // could be anything, but this makes the grid look good! :D
  }

  // given a distance parameter, this will add all the neighbours within range to the list
  public void getNeighbours(float distance) {
    // neighbours.clear(); // in this sketch not required because neighbours are only searched once
    for (Hexagon h : grid) { // for all the cells in the grid
      if (h!=this) { // if it's not the cell itself
        if (dist(x,y, h.x,h.y) < distance) { // if it's within distance
          neighbours.add( h ); // then add it to the list: "Welcome neighbour!"
        }
      }
    }
  }
  
  // calculate the new color based on a completely arbitrary set of 'rules'
  // this could be anything, right now it's this, which makes the CA pretty dynamic
  // if you tweak this in the wrong way you quickly end up with boring static states
  public void calculateNewColor() {
    float avgColor = averageColor(); // get the average of the neighbours (see other method)
    float tmpColor = currentColor;
    if (avgColor < 0) {
      tmpColor = 50; // if the average color is below 0, set the color to 50
    } else if (avgColor < 150) {
      tmpColor += 5; // if the average color is between 0 and 150, add 5 to the color
    } else if (avgColor > 210) {
      tmpColor -= 5; // if the average color is above 210, subtract 5 from the color
    }
    // in all other cases (aka the average color is between 150 and 210) the color remains unchanged
    newColor = tmpColor;
  }
  
  // returns the average color (aka hue) of the neighbours
  public float averageColor() {
    float avgColor = 0; // start with 0
    for (Hexagon h : neighbours) {
      avgColor += h.currentColor; // add the color from each neighbour
    }
    avgColor /= neighbours.size(); // divide by the number of neighbours
    return avgColor; // done!
  }
  
  public void changeColor() {
    currentColor = newColor; // set the current color to the new(ly calculated) color
  }

  // display the hexagon at position xy with the current color
  // use the vertex positions that have been pre-calculated ONCE (instead of re-calculating these for each cell on each draw)
  public void display(PVector[] v, int in, float factor) {
    pushMatrix();
    translate(x, y);
    fill(currentColor, saturation(in), brightness(in), alpha(in));
    beginShape();
    for (int i=0; i<6; i++) { vertex(v[i].x *factor, v[i].y *factor); }
    endShape();
    popMatrix();
  }
}

class Webcam extends Romanesco {
  public Webcam() {
    //from the index_objects.csv
    romanescoName = "Webcam" ;
    IDobj = 22 ;
    IDgroup = 2 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Version 1.2";
    romanescoPack = "Base" ;
    romanescoRender = "P3D" ;
    romanescoMode = "Rectangle color/Rectangle mono/Point color/Point mono/Box color/Box mono" ;
    romanescoSlider = "Hue fill,Saturation fill,Brightness fill,Alpha fill,Size X,Size Y,Size Z,Canvas X,Canvas Y" ;
  }
  //GLOBAL
  int cameraStatut = 0 ;
  //class
  GSCapture cam;
  //Cameras
  int [] [] sizeCam = { {640,480}, {160,120}, {176,144}, {320,240}, {352,288} } ;
  int whichSizeCam = 4 ; // choice the resolution size of camera
  String whichCam = "1" ; // "1" to search an external webcam, the device "0" is the native webcam on mac
  boolean nativeWebCam ;
  int testDeviceCam ;
  
  PVector factorDisplayCam = new PVector (0,0) ;
  PVector factorDisplayPixel = new PVector (0,0) ;
  PVector factorCalcul = new PVector (0,0) ;
  
  int colorPixelCam ;
  
  int cellSizeX, cellSizeY, posPixelX, posPixelY   ;
  int cols ;
  int rows ; 
  
  
  //SETUP
  public void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
    cam = new GSCapture(callingClass, sizeCam [whichSizeCam][0], sizeCam [whichSizeCam][1], whichCam);
    
    //Logitech / 640x480 / 160x120 / 176x144 / 320x240 / 352x288
    // Imac 640x480 / 160x120 / 176x144 / 320x240 / 352x288
  }
  //DRAW
  public void display() {
    //PART ONE
    factorCalcul.x = sizeCam [whichSizeCam][0] ;
    factorCalcul.y = sizeCam [whichSizeCam][1] ;
    //calcul the ration between the size of camera and the size of the scene
    factorDisplayCam.x = width / factorCalcul.x ; 
    factorDisplayCam.y = height / factorCalcul.y ;
    
    float minVal = 0.1f ;
    float maxVal = height / 50 ;
    PVector factorSizePix = new PVector(map(sizeXObj[IDobj],0.1f,width, minVal, maxVal), map(sizeYObj[IDobj],0.1f,width, minVal, maxVal), map(sizeZObj[IDobj],0.1f,width, minVal, maxVal)) ; 
    factorDisplayPixel = new PVector(factorDisplayCam.x *factorSizePix.x , factorDisplayCam.y *factorSizePix.y, factorSizePix.z) ;//PARAMETER THAT YOU CAN USE
    
    //PART TWO
    cam.start();
    if(fullRendering) {
      cellSizeX = PApplet.parseInt(map(canvasYObj[IDobj],width/10, width, 50, 1))  ; 
      cellSizeY = PApplet.parseInt(map(canvasXObj[IDobj],width/10, width, 50, 1))  ;
    } else {
      cellSizeX = PApplet.parseInt(map(canvasYObj[IDobj],width/10, width, 50, 20))  ; 
      cellSizeY = PApplet.parseInt(map(canvasXObj[IDobj],width/10, width, 50, 20))  ;
    }
    if(cellSizeX < 1 ) cellSizeX = 1 ;
    if(cellSizeY < 1 ) cellSizeY = 1 ;
    
    cols = sizeCam [whichSizeCam][0] / cellSizeX; // before the resizing
    rows = sizeCam [whichSizeCam][1] / cellSizeY;
    if (testCam()) {
      cam.read();
      for (int i = 0; i < cols ; i++) {
        for (int j = 0; j < rows  ; j++) {
          // Where are we, pixel-wise?
          posPixelX = i *cellSizeX  ;
          posPixelY = j *cellSizeY  ;
          //// display pixel 
          int  loc = posPixelX  + posPixelY *cam.width; // classic
          //  int loc = (cam.width - x - 1) + y*cam.width; // mirror
          //make pixel
          PVector hsb = new PVector (hue(cam.pixels[loc]), saturation(cam.pixels[loc]), brightness(cam.pixels[loc]) ) ;

          
          // Make a new color with an alpha component
          displayPix(mode[IDobj],hsb) ; 
        }
      } 
    } else if (!testCam() && testDeviceCam < 180 )  {
      fill(0) ;
      testDeviceCam += 1 ;
      text("No external video signal, Romanesco try on the native Camera", 10 , 20 ) ;
    } 
    
    //TEST CAM
    // testDeviceCam += 1 ;
    if(!testCam() && nativeWebCam && testDeviceCam > 90  ) {
      cam = new GSCapture(callingClass, sizeCam [whichSizeCam][0], sizeCam [whichSizeCam][1], ("0")); 
     // if(testCam() )  nativeWebCam = true ; 
    } else {
      nativeWebCam = true ;
    }
    if(!testCam() && testDeviceCam == 180 ) {
      fill(0) ;
      text("No camera available on your stuff my Friend !", mouse[0].x , mouse[0].y ) ;
    }
    
    rectMode (CORNER) ; 
    ////////////////////

  }
  
  
  
  
  
  
  //annexe

  
  
  public void displayPix(int mode, PVector hsb) {
    //DISPLAY
    pushMatrix() ;
    //P3D Give the position and the orientation of your object in the 3 dimensionals space
    PVector newDisplay = new PVector  (cellSizeX *factorDisplayCam.x,   cellSizeY *factorDisplayCam.y) ;
    
    float newCellSizeX = cellSizeX *factorDisplayPixel.x *left[IDobj] ;
    float newCellSizeY = cellSizeY *factorDisplayPixel.y *right[IDobj] ;
    float factorSizeZ = map(sizeZObj[IDobj], .1f, width, .5f, 10) ;
    PVector newCellSize = new PVector (newCellSizeX, newCellSizeY, factorSizeZ ) ;
    //init the position of image on the middle of the screen
    PVector posMouseCam = new PVector ( width / 2, height /2) ;
    if (mouse[IDobj].x >= -startingPosition[IDobj].x && mouse[IDobj].y >= -startingPosition[IDobj].y) posMouseCam = mouse[IDobj] ;
    //create the ratio for the translate position in functiun of the size of the Scene, not really good algorythm
    float ratioDisplay = (float)width / (float)height ;
    float factorDisplacementRatioSizeOfTheDisplay = map(width, 0, 2000, .6f, .2f ) ;
    float factorTranslateX = factorDisplacementRatioSizeOfTheDisplay / ratioDisplay ;
    float factorTranslateY = factorDisplacementRatioSizeOfTheDisplay ;

    //finalization of the position
    float finalPosPixelX = ( (posPixelX +newDisplay.x *factorTranslateX) *factorDisplayCam.x) + posMouseCam.x - width *0.5f ;
    float finalPosPixelY = ( (posPixelY +newDisplay.y *factorTranslateY) *factorDisplayCam.y) + posMouseCam.y - height*0.5f ;
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
  public void rectangleMonochrome(PVector pos, PVector size, PVector hsb) {
    size = checkSize(size).copy() ;
    translate(pos.x, pos.y, pos.z);
    monochrome(hsb) ;
    fill(colorPixelCam) ;
    noStroke() ;
    antiBugFillBlack(colorPixelCam) ;
    rect (0,0, size.x, size.y) ;
  }
  //
  public void rectangleColour(PVector pos, PVector size, PVector hsb) {
    size = checkSize(size).copy() ;
    translate(pos.x, pos.y, pos.z);
    colour(hsb) ;
    fill(colorPixelCam) ;
    noStroke() ;
    antiBugFillBlack(colorPixelCam) ;
    rect (0,0, size.x, size.y) ;
  }
  //
  public void pointMonochrome(PVector pos, PVector size, PVector hsb) {
    size = checkSize(size).copy() ;
    translate(pos.x, pos.y, pos.z);
    monochrome(hsb) ;
    stroke(colorPixelCam) ;
    strokeWeight(size.x) ;
    antiBugFillBlack(colorPixelCam) ;
    point(0,0,0) ;
  }
  //
  public void pointColour(PVector pos, PVector size, PVector hsb) {
    size = checkSize(size).copy() ;
    translate(pos.x, pos.y, pos.z);
    colour(hsb) ;
    stroke(colorPixelCam) ;
    strokeWeight(size.x) ;
    antiBugFillBlack(colorPixelCam) ;
    point(0,0,0)  ;
  }
  //
  public void boxMonochrome(PVector pos, PVector size, PVector hsb) {
    size = checkSize(size).copy() ;
    float depth = (hsb.z +1) *size.z ;
    if(horizon[IDobj]) translate(pos.x, pos.y, depth *.5f); else translate(pos.x, pos.y, pos.z);
    monochrome(hsb) ;
    fill(colorPixelCam) ;
    antiBugFillBlack(colorPixelCam) ;
    noStroke() ;
    box(size.x, size.y, depth) ;
  }
  //
  public void boxColour(PVector pos, PVector size, PVector hsb) {
    size = checkSize(size).copy() ;
    float depth = (hsb.z +1) *size.z ;
    if(horizon[IDobj]) translate(pos.x, pos.y, depth *.5f); else translate(pos.x, pos.y, pos.z);
    colour(hsb) ;
    fill(colorPixelCam) ;
    antiBugFillBlack(colorPixelCam) ;
    noStroke() ;
    box(size.x, size.y, depth) ;
  }
  
  
  //Annexe
  
  // security size 
  public PVector checkSize(PVector size) {
    float minSize = 2.0f ;
    if (size.x < minSize ) size.x = minSize ;
    if (size.y < minSize ) size.y = minSize ;
    if (size.z < minSize ) size.z = minSize ;
    return size ;
  }
  
  public void colour(PVector hsb) {
    float newSat = hsb.y *map(saturation(fillObj[IDobj]),0,100,0,1) ;
    float newBrigth = hsb.z *map(brightness(fillObj[IDobj]),0,100,0,1) ;
    colorPixelCam = color(hsb.x, newSat, newBrigth, alpha(fillObj[IDobj]));
  }
  
  public void monochrome(PVector hsb) {
    float newHue = hue(fillObj[IDobj]) ;
    float newSat = hsb.y *map(saturation(fillObj[IDobj]),0,100,0,1) ;
    float newBrigth = hsb.z *map(brightness(fillObj[IDobj]),0,100,0,1) ;
    //display the result
    colorPixelCam = color(newHue, newSat, newBrigth, alpha(fillObj[IDobj]));
  }
  
  
  
  
  
  
  
  
  // test camera
  int testCam ;
  public boolean testCam() {
    if (cam.available()) testCam =+ 30 ; else testCam -= 1 ;
    if ( testCam < 1 ) testCam = 0 ;
    
    if ( testCam > 2 ) videoSignal = true ; else videoSignal = false ;
    // boolean returned
    if ( testCam > 2 ) return true ;  else return false ;
  }
}
class Escargot extends Romanesco {
  public Escargot() {
    //from the index_objects.csv
    romanescoName = "Image" ;
    IDobj = 23 ;
    IDgroup = 2 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "version 1.4.1";
    romanescoPack = "Base" ;
    romanescoRender = "P3D" ;
    romanescoMode = "Original/Raw/Point/Ellipse/Rectangle/Box/Cross/SVG/Vitraux" ;
    romanescoSlider = "Hue fill,Saturation fill,Brightness fill,Alpha fill,Hue stroke,Saturation stroke,Brightness stroke,Alpha stroke,Thickness,Size X,Size Y,Size Z,Speed,Direction,Amplitude,Analyze,Quantity,Repulsion" ;
  }
  //GLOBAL
  String pathSVG ;
    //VORONOI TOXIC
  // ranges for x/y positions of points
  FloatRange xpos, ypos;
  // helper class for rendering
  ToxiclibsSupport gfx;
  // empty voronoi mesh container
  Voronoi voronoi = new Voronoi();
  //VORONOI for void
  int thicknessVoronoi = 1 ;
  int colorStrokeVoronoi = color (0,0,0)  ;
  boolean whichColorVoronoi ;
  //ratio size image and window
  PVector ratioImgWindow = new PVector(1,1) ;
  //color strokeColor  ; // color for the stroke
  int thickness = 1 ; // if "zero" noStroke() is activate
  boolean useNewPalettePixColorToDisplay = true ; // if want use the original picture from the raw list to find color write "FALSE", but if you do that you can use the possibility to change the palette in Live, else use "TRUE"
  
  boolean colorPixDisplay = true ;
  boolean fillDisplay = true ;
  
  //ANALYZE PICTURE
  //size analyze pixel
  int pixelAnalyzeSize = 2; // pour la grille de mon cahier tester vec 40
  int pixelAnalyzeSizeRef = 2  ;
  //size display pixel
  int pixelDisplaySize = 1;
  int pixelStrokeWeight = 1;
  //escargot analyze
  int radiusAnalyze = 25 ; // radius analyze around the pixel
  int radiusAnalyzeRef = 25 ; // radius analyze around the pixel
  int speedAnalyze = 10 ; // quantity of point be analyzing in the image. It's random choice on the surface of the image.
  int maxEntryPoints = 500 ; // quantity of point be analyzing in the image. It's random choice on the surface of the image.
  int maxEntryPointsRef = 500 ; // quantity of point be analyzing in the image. It's random choice on the surface of the image.
  int maxVoronoiPoints = 125000 ; // max point for voronoi calcula bahond is very very slow
  
  String modeTri = ("b") ; // you can choice in few mode "hsb"(exact same hue, saturation and brithness the other mode is part of this three composantes, "b", "s", "hs", "hb", "sb"
  boolean useNewPalettePixColorToAnalyze = true ; // choice the color you analyze, the raw color you must write "FALSE" if you look in the "newColor" because you have change the color pixel for anything you must write "TRUE", best analyze with the new palette
  
  
  //PALETTE COLOR
  //random palette
  PVector HSBpalette = new PVector (6, 6, 12) ;  // quantity for each components of palette in HSB order // need "1" minimum in each componante
  //palette from you
  int hueColor[] =    new int [(int)HSBpalette.x] ;
  int satColor[] =    new int [(int)HSBpalette.y] ;
  int brightColor[] = new int [(int)HSBpalette.z] ;
  //spectrum for the color mode and more if you need
  Vec4 HSBmode = new Vec4 (360,100,100,100) ; // give the color mode in HSB
  
  //MOTION POSITION
  //Wind force, direction
  int windDirection = 25; //direction between 1 and 360
  int windForce = 3 ; //use the natural code of the wind 0 to 9 is good
  int objMotion = 1 ; //motion of the pixel is under influence of the wind, if the wind is strong the pixel motion become low
  PVector motionInfo = new PVector(windDirection, windForce, objMotion)  ;
  //ratio for the image, say if the picture must be adapted to the size window or not
  boolean ratioImg = true ;
  
  //COLOR MOTION
    /*
    each data (hueVariation, satVariation, brightVariation) is PVector with 3 values :
    value 1 : Pivot (laticce) between 0 to max, the max value is the componant of HSB for example 360 for the hue if it's a value choice is the colorMode
    value 2 : Speed evolution of this value : no max or min value but is better to use very small value like 0.1 or less
    value 3 : factor multiplication variation of the value 1 (pivot) must be include between "ZERO" and "ONE", if the value is "ZERO" it's the max of variation, if it's "ONE there's no variation 
    */
  //hue motion
  int huePivot = 180 ; // choice the color pivot on the wheel color, between "zero" and "HSBmode.x" ( HSBmode.x is the value of the hue wheel : generally 360 )
  float hueSpeed = 0.001f ; // Speed evolution of this value : no max or min value but is better to use very small value like 0.1 or less
  float hueRange = 0.0f ; // between "zero" and "one" : "zero" if the max amplitude between the pivot and the color start
  PVector hueVariation = new PVector (huePivot, hueSpeed, hueRange ) ;
  //saturation motion
  int satPivot = 10 ; // choice the color pivot on the wheel color, between "zero" and "HSBmode.y" ( HSBmode.y is the value of the saturation range : generally 100 )
  float satSpeed = 0.01f ; // no max or min value but is better to use very small value like 0.1 or less
  float satRange = 0.00f ; // between "zero" and "one" : "zero" if the max amplitude between the pivot and the color start
  PVector satVariation = new PVector (satPivot, satSpeed, satRange ) ;
  //saturation motion
  int brightPivot = 10 ; // choice the color pivot on the wheel color, between "zero" and "HSBmode.y" ( HSBmode.y is the value of the saturation range : generally 100 )
  float brightSpeed = 0.01f ; // no max or min value but is better to use very small value like 0.1 or less
  float brightRange = 0.00f ; // between "zero" and "one" : "zero" if the max amplitude between the pivot and the color start
  PVector brightVariation = new PVector (brightPivot, brightSpeed, brightRange ) ;
  
  //SOUND
  int forceBeat = 1 ;
  
  
  //SETUP
  public void setting() {
    startPosition(IDobj, 0, 0, 0) ;
    loadImg(IDobj) ;
    if(!scene) maxVoronoiPoints = 250 ;
    //load pattern SVG to display a Pixel pattern you create in Illustrator or other software
    pathSVG = preferencesPath +"pixel/model.svg" ;
    shapeSVGsetting(pathSVG) ;
    
    //random palette
    paletteRandom(HSBpalette, HSBmode ) ; // you must give the number of color and the size spectre color, here it's 360 for the hue and 100 for the rest
    
    //palette from you
    /*
    for ( int i = 0 ; i < (int)HSBpalette.x ; i++ ) hueColor[i] =    i * int(HSBmode.x /HSBpalette.x) ; // not minus by one because it's a whell system
    for ( int i = 0 ; i < (int)HSBpalette.y ; i++ ) satColor[i] =    i * int(HSBmode.y /(HSBpalette.y -1)) ;
    for ( int i = 0 ; i < (int)HSBpalette.z ; i++ ) brightColor[i] = i * int(HSBmode.z /(HSBpalette.z -1)) ;
    paletteClassic(hueColor, satColor, brightColor, HSBmode) ;
    */
  
    //step 2 if you use Voronoi
    voronoiToxicSetup() ;
  }
  
  
  
  String imgPathRef = ("") ;
  boolean firstSettingPosition = true ;
  //DRAW
  public void display() {
    /*
    if(firstSettingPosition && startingPos[IDobj].x == 0.0 && startingPos[IDobj].y == 0.0 ) {
      startingPos[IDobj].x = img[IDobj].width /4 ;
      startingPos[IDobj].y = img[IDobj].height /4 ;
      firstSettingPosition = false ;
    }
    */
    
    if(parameter[IDobj]) loadImg(IDobj) ;

    if(img[IDobj] != null) {  
      //MOTION
      windForce = (int)map(speedObj[IDobj],0,1,0,13) ;
      windDirection = (int)directionObj[IDobj] ;
      objMotion = PApplet.parseInt(map(repulsionObj[IDobj],0,1, 0,20) *(1.0f + pen[IDobj].z)) ;
      motionInfo.y = windForce ;
      //PEN
       if (pen[IDobj].z == 1 ) pen[IDobj].z = 0 ; else pen[IDobj].z = pen[IDobj].z ;
       if( (pen[IDobj].x == 1.0f && pen[IDobj].y == 1.0f) || (pen[IDobj].x == 0.0f && pen[IDobj].y == 0.0f) ) {
         motionInfo.x = windDirection  ; 
       } else {
         PVector convertTilt = new PVector (-pen[IDobj].x, -pen[IDobj].y) ;
         motionInfo.x = deg360(convertTilt) ;
       }
       
       // if (!spaceTouch) for( Pixel p : listEscargot) {
       //alternat beween the pen and the controleur
       // if( pen[IDobj].x == 0 && pen[IDobj].y == 0 ) newDirection = normalDir(int(map(valueObj[IDobj][18],0,100,0,360))) ; else newDirection = new PVector (-pen[IDobj].x  , -pen[IDobj].y ) ;
       
       if (!motion[IDobj]) for(Pixel p : listEscargot) {
         p.updatePosPixel(motionInfo, img[IDobj]) ;
       }
      ////////////////
      
      //ANALYZE
      //change the size of pixel ref for analyzing
      if (pixelAnalyzeSize != pixelAnalyzeSizeRef || radiusAnalyze != radiusAnalyzeRef || maxEntryPoints != maxEntryPointsRef) reInitilisationAnalyze() ;
  
      pixelAnalyzeSizeRef = pixelAnalyzeSize;
      radiusAnalyzeRef = radiusAnalyze ;
      maxEntryPointsRef = maxEntryPoints ;
      
      int n = PApplet.parseInt(map(quantityObj[IDobj],0,1,10,150)) ;
      maxEntryPoints = n *n ;
      
      // security for the vorono\u00ef displaying, because if you change the analyze in the voronoi process, Romanesco make the Arraylist error
      if(mode[IDobj] != 8 || (maxEntryPoints != maxEntryPointsRef && scene) ) {
        //if (maxEntryPoints > listPixelRaw.size() / 4 ) maxEntryPoints = listPixelRaw.size() ;
        radiusAnalyze = PApplet.parseInt(map(amplitudeObj[IDobj],0,1,2,100));
        pixelAnalyzeSize = PApplet.parseInt(map(analyzeObj[IDobj],0,1,100,2));
      } else {
        if(maxEntryPoints > maxVoronoiPoints) maxEntryPoints = maxVoronoiPoints  ;
      }
  
      
       //security for the droping img from external folder
       if(parameter[IDobj] && rTouch ) ratioImg = !ratioImg ;
       if(img[IDobj] != null && img[IDobj].width > 3 && ratioImg ) {
         analyzeImg(pixelAnalyzeSize) ;
         // ratioImgWindow = new PVector ((float)width / (float)img.width , (float)height / (float)img.height ) ;
         ratioImgWindow = new PVector ((float)width / (float)img[IDobj].width , (float)width / (float)img[IDobj].width ) ;
       } else if (img[IDobj] != null && img[IDobj].width > 3 && !ratioImg) {
         analyzeImg(pixelAnalyzeSize) ;
         ratioImgWindow = new PVector(1,1) ;
       } else {
         ratioImgWindow = new PVector(1,1) ;
       }
       
       //size and thickness
       PVector sizePix = new PVector (map(sizeXObj[IDobj],.1f,width, 1, height/30 ), map(sizeYObj[IDobj],.1f,width, 1, height/30 ), map(sizeZObj[IDobj],.1f,width, 1, height/30 )) ;
       float sizePoint = map(sizeXObj[IDobj],.1f,width, 1, height/6 ) ;
       float thickPix = map(thicknessObj[IDobj],0.1f,height *.33f, 0.1f, height/10 ) ;
       
       // range 100
       float soundHundredMin = random(80) ;
       float soundHundredMax = random(soundHundredMin, soundHundredMin +20) ;
       PVector rangeReactivitySoundHundred = new PVector (soundHundredMin, soundHundredMax) ;
       //range 360
       float soundThreeHundredSixtyMin = random(330) ;
       float soundThreeHundredSixtyMax = random(soundThreeHundredSixtyMin, soundThreeHundredSixtyMin +30) ;
       PVector rangeReactivitySoundThreeHundredSixty = new PVector (soundThreeHundredSixtyMin, soundThreeHundredSixtyMax) ;
       //Music factor
       PVector musicFactor = new PVector ( allBeats(IDobj) *left[IDobj], allBeats(IDobj) *right[IDobj]) ;
       forceBeat = (int)map(repulsionObj[IDobj],0,1,1,40) ;

       
       // update image
       if(parameter[IDobj] && imgPathRef != imagePath[whichImage[IDobj]] ) {
         analyzeDone = false ;
         escargotGOanalyze = false ;
         escargotClear() ;
         imgPathRef = imagePath[whichImage[IDobj]] ;
       }
      
      
      
      //choice new pattern SVG
      if ( action[IDobj] && pTouch ) {
        //step 1 clear the list for new analyze
        drawVertexSVG = false ;
        selectInput("select SVG pattern 50x50", "choiceSVG");
      }
      
      //change the color palette
      if (action[IDobj] && xTouch ) paletteRandom(HSBpalette, HSBmode ) ;
      
      //clear the pixels for the new analyze
      if (action[IDobj] && ( deleteTouch || backspaceTouch)) {
        escargotClear() ;
        analyzeDone = false ;
        totalPixCheckedInTheEscargot = 0 ;
      }
  
  
  
      
  
       //CHANGE MODE DISPLAY
      /////////////////////
      
      // correction position to rotate the picture by the center
      pushMatrix() ;
      translate(-img[IDobj].width /4, -img[IDobj].height /4) ;
      
      if (mode[IDobj] == 0 || mode[IDobj] == 255 ) {
        displayRawPixel(sizePoint, fillObj[IDobj], rangeReactivitySoundHundred, rangeReactivitySoundThreeHundredSixty, musicFactor, ratioImgWindow) ;
      } else if (mode[IDobj] == 1 ) {
        escargotRaw(sizePoint, fillObj[IDobj], rangeReactivitySoundHundred, rangeReactivitySoundThreeHundredSixty, musicFactor, ratioImgWindow) ;
      } else if (mode[IDobj] == 2 ) {
        escargotPoint(sizePix, fillObj[IDobj], rangeReactivitySoundHundred, rangeReactivitySoundThreeHundredSixty, musicFactor, ratioImgWindow) ;
      } else if (mode[IDobj] == 3 ) {
        escargotEllipse(sizePix, thickPix, fillObj[IDobj], strokeObj[IDobj], rangeReactivitySoundHundred, rangeReactivitySoundThreeHundredSixty, musicFactor, ratioImgWindow) ;
      } else if (mode[IDobj] == 4 ) {
        escargotRect(sizePix, thickPix, fillObj[IDobj], strokeObj[IDobj], rangeReactivitySoundHundred, rangeReactivitySoundThreeHundredSixty, musicFactor, ratioImgWindow) ;
      }else if (mode[IDobj] == 5 ) {
        escargotBox(sizePix, thickPix, fillObj[IDobj], strokeObj[IDobj], rangeReactivitySoundHundred, rangeReactivitySoundThreeHundredSixty, musicFactor, ratioImgWindow, horizon[IDobj]) ;
      } else if (mode[IDobj] == 6 ) {
        escargotCross(sizePix, thickPix, fillObj[IDobj], rangeReactivitySoundHundred, rangeReactivitySoundThreeHundredSixty, musicFactor, ratioImgWindow) ;
      } else if (mode[IDobj] == 7 ) {
        escargotSVG(sizePix, thickPix, fillObj[IDobj], strokeObj[IDobj], rangeReactivitySoundHundred, rangeReactivitySoundThreeHundredSixty, musicFactor, ratioImgWindow) ;
      } else if (mode[IDobj] == 8 ) {
        //if( listEscargot.size() < 600) {
        if( listEscargot.size() < maxVoronoiPoints + maxVoronoiPoints/10) {
          voronoiStatic(fillObj[IDobj], strokeObj[IDobj], thickPix, useNewPalettePixColorToDisplay, ratioImgWindow) ; 
        } else {
          text("Too much points to net vorono\u00ef connection", 20, height -20) ;
        }
      }
      
      // end of correction position
      popMatrix() ;
      
      // info display
      objectInfo[IDobj] = ("Image " +img[IDobj].width + "x"+img[IDobj].height + " Analyze "+listEscargot.size()+ " of " + maxEntryPoints+ " / Cell " + pixelAnalyzeSize+ "px / Radius analyze " + radiusAnalyze + " Scale " + ratioImgWindow.x + " / " +ratioImgWindow.y) ;
    } 
  }
  
  
  
  //ANNEXE VOID
  public void displayRawPixel(float sizeP, int cIn, PVector rangeHundred, PVector rangeThreeHundredSixty, PVector musicFactor, PVector ratio) {
    // we must create a PVector because i'm lazy to create an other void beatReactivity for one float
    PVector sizePixCtrl = new PVector (0,0,sizeP) ;
    float factorSat = map(saturation(cIn),0,100,0,1) ;
    float factorBright = map(brightness(cIn),0,100,0,1) ;
    
    for (Pixel p : listPixelRaw) {
      //display
      stroke(hue(p.colour),saturation(p.colour)*factorSat,brightness(p.colour)*factorBright, alpha(cIn)) ;
      float newSize = 0 ;
      if(sound[IDobj])  newSize = beatReactivityHSB(sizePixCtrl, p.size, p.colour, rangeThreeHundredSixty, rangeHundred, musicFactor ).z ; else newSize = sizeP ;
      strokeWeight(newSize) ;
      point(p.pos.x *ratio.x, p.pos.y *ratio.y) ;
    }
  }
  
  
  
  //Display which point is use to caluculate the barycenter
  public void escargotRaw(float sizeP, int cIn, PVector rangeHundred, PVector rangeThreeHundredSixty, PVector musicFactor, PVector ratio) {
    int c ;
    float factorSat = map(saturation(cIn),0,100,0,1) ;
    float factorBright = map(brightness(cIn),0,100,0,1) ;
    // we must create a PVector because i'm lazy to creat an other void beatReactivity for one float
    PVector sizePixCtrl = new PVector (0,0,sizeP) ;
    
    for ( Pixel p : listPixelRaw ) {
      if (p.ID == 1 ) {
        //color
        if ( colorPixDisplay ) c = p.newColour ; else c = p.colour ;
        
        //display
        stroke(hue(c),saturation(c)*factorSat,brightness(c)*factorBright, alpha(cIn)) ;
        float newSize = 0 ;
        if(sound[IDobj])  newSize = beatReactivityHSB(sizePixCtrl, p.size, p.colour, rangeThreeHundredSixty, rangeHundred, musicFactor ).z ; else newSize = sizeP ;
        strokeWeight(newSize) ;
        point(p.pos.x *ratio.x, p.pos.y *ratio.y) ;
      }
    }
  }


  //Display Barycenter
  public void escargotPoint(PVector size, int cIn, PVector rangeHundred, PVector rangeThreeHundredSixty, PVector musicFactor, PVector ratio) {
    int c ;
    float factorSat = map(saturation(cIn),0,100,0,1) ;
    float factorBright = map(brightness(cIn),0,100,0,1) ;
    // we must create a PVector because i'm lazy to creat an other void beatReactivity for one float
    //PVector sizePixCtrl = new PVector (0,0,size.x) ;

    for ( Pixel p : listEscargot ) {
      //check if we must display original color or the new palette
      int x = (int)p.pos.x ; int y = (int)p.pos.y ;
      if ( colorPixDisplay ) c = p.newColour ; else c = get(x , y) ;
  
      p.changeHue   (HSBmode, huePalette, hueStart, hueEnd) ;
      p.changeSat   (HSBmode, satPalette, satStart, satEnd) ; 
      p.changeBright(HSBmode, brightPalette,  brightStart, brightEnd) ;
      // update the color after change each componante
      p.updatePalette() ;
      
      stroke(hue(c),saturation(c)*factorSat,brightness(c)*factorBright, alpha(cIn)) ;
      PVector newSize = new PVector() ;
      newSize = newSize2D(size, p.size, rangeThreeHundredSixty, rangeHundred, musicFactor, c, forceBeat) ; //<>// //<>//
      
      if (soundButton[IDobj] == 1) strokeWeight(newSize.x) ; else strokeWeight(p.size.x *size.x) ;
      
       point(p.pos.x *ratio.x, p.pos.y *ratio.y) ; 
    }
  }
  
  
  
  
  
  //ELLIPSE
  public void escargotEllipse(PVector size, float thickness, int cIn, int cOut, PVector rangeHundred, PVector rangeThreeHundredSixty, PVector musicFactor, PVector ratio) {
    int c ;
    float factorSatIn = map(saturation(cIn),0,100,0,1) ;
    float factorBrightIn = map(brightness(cIn),0,100,0,1) ;
    float factorSatOut = map(saturation(cIn),0,100,0,1) ;
    float factorBrightOut = map(brightness(cIn),0,100,0,1) ;
   
    for (Pixel p : listEscargot) {
      
      if (colorPixDisplay) c = p.newColour ; else c = p.colour ;
      p.changeHue   (HSBmode, huePalette, hueStart, hueEnd) ;
      p.changeSat   (HSBmode, satPalette, satStart, satEnd) ; 
      p.changeBright(HSBmode, brightPalette, brightStart, brightEnd) ;
      // update the color after change each componante
      p.updatePalette() ; 

      //music influence on the opacity
      // A RETRAVAILLER
      
      //display
      if (alpha(cIn) != 0) fill(hue(c),saturation(c)*factorSatIn,brightness(c)*factorBrightIn, alpha(cIn)) ; else noFill() ;
      if (alpha(cOut) != 0) {
        stroke(hue(c),saturation(c)*factorSatOut,brightness(c)*factorBrightOut, alpha(cOut)) ; 
        strokeWeight(thickness ) ;
      } else { 
        noStroke() ;
      } 
      
      PVector newSize = new PVector() ;
      newSize = newSize2D(size, p.size, rangeThreeHundredSixty, rangeHundred, musicFactor, c, forceBeat) ;
      // display
      ellipse(p.pos.x *ratio.x,  p.pos.y *ratio.y, newSize.x, newSize.y) ; 
    }
  }
  
  //RECT
  public void escargotRect(PVector size, float thickness, int cIn, int cOut, PVector rangeHundred, PVector rangeThreeHundredSixty, PVector musicFactor, PVector ratio) {
    int c ;
    float factorSatIn = map(saturation(cIn),0,100,0,1) ;
    float factorBrightIn = map(brightness(cIn),0,100,0,1) ;
    float factorSatOut = map(saturation(cIn),0,100,0,1) ;
    float factorBrightOut = map(brightness(cIn),0,100,0,1) ;
    
    for (Pixel p : listEscargot) {
      if ( colorPixDisplay ) c = p.newColour ; else c = p.colour ;
      p.changeHue   (HSBmode, huePalette, hueStart, hueEnd) ;
      p.changeSat   (HSBmode, satPalette, satStart, satEnd) ; 
      p.changeBright(HSBmode, brightPalette, brightStart, brightEnd) ;
      // update the color after change each componante
      p.updatePalette() ; 
      
      //display
      if (alpha(cIn) != 0) fill(hue(c),saturation(c)*factorSatIn,brightness(c)*factorBrightIn, alpha(cIn)) ; else noFill() ;
      if (alpha(cOut) != 0) {
        stroke(hue(c),saturation(c)*factorSatOut,brightness(c)*factorBrightOut, alpha(cOut)) ; 
        strokeWeight(thickness ) ;
      } else { 
        noStroke() ;
      } 

      PVector newSize = new PVector() ;
      newSize = newSize2D(size, p.size, rangeThreeHundredSixty, rangeHundred, musicFactor, c, forceBeat) ;
      // display
      rect((p.pos.x - (newSize.x *.5f)) *ratio.x, (p.pos.y - (newSize.y *.5f)) *ratio.y, newSize.x , newSize.y) ; 
    }
  }
  
  
  //RECT
  public void escargotBox(PVector size, float thickness, int cIn, int cOut, PVector rangeHundred, PVector rangeThreeHundredSixty, PVector musicFactor, PVector ratio, boolean alignement) {
    int c ;
    float factorSatIn = map(saturation(cIn),0,100,0,1) ;
    float factorBrightIn = map(brightness(cIn),0,100,0,1) ;
    float factorSatOut = map(saturation(cIn),0,100,0,1) ;
    float factorBrightOut = map(brightness(cIn),0,100,0,1) ;
    
    for (Pixel p : listEscargot) {
      if ( colorPixDisplay ) c = p.newColour ; else c = p.colour ;
      p.changeHue   (HSBmode, huePalette, hueStart, hueEnd) ;
      p.changeSat   (HSBmode, satPalette, satStart, satEnd) ; 
      p.changeBright(HSBmode,brightPalette, brightStart, brightEnd) ;
      // update the color after change each componante
      p.updatePalette() ; 
      
      //display
      if (alpha(cIn) != 0) fill(hue(c),saturation(c)*factorSatIn,brightness(c)*factorBrightIn, alpha(cIn)) ; else noFill() ;
      if (alpha(cOut) != 0) {
        stroke(hue(c),saturation(c)*factorSatOut,brightness(c)*factorBrightOut, alpha(cOut)) ; 
        strokeWeight(thickness ) ;
      } else { 
        noStroke() ;
      } 
      //recalculate the pose  to scale with coordonate in the middle of the shape ( like(RectMode(CENTER) )

      // float witness = beatReactivityHSB(size, p.size, c, rangeThreeHundredSixty, rangeHundred, musicFactor ).z  ;
      PVector newSize = new PVector() ;
      newSize = newSize3D(size, p.size, rangeThreeHundredSixty, rangeHundred, musicFactor, c, forceBeat) ;
      // display
      pushMatrix() ;
      if (!alignement) {
        translate(p.pos.x *ratio.x, p.pos.y *ratio.y, 0) ;
      } else {
        float horizon = newSize.z *.5f ;
        translate(p.pos.x *ratio.x, p.pos.y *ratio.y, horizon) ;
      }
      //show
      box(newSize.x, newSize.y, newSize.z) ;
      /*
      if (soundButton[IDobj] == 1) { 
        if( witness > size.z) box(newSize.x, newSize.y, newSize.z) ; 
      } else if (soundButton[IDobj] == 0){ 
        box(newSize.x, newSize.y, newSize.z) ; 
      }
      */
      popMatrix() ;
    }
  }
  
  
  //CROSS
  public void escargotCross(PVector size, float thickness, int cIn, PVector rangeHundred, PVector rangeThreeHundredSixty, PVector musicFactor, PVector ratio) {
    int c ; 
    float factorSat = map(saturation(cIn),0,100,0,1) ;
    float factorBright = map(brightness(cIn),0,100,0,1) ;
    
    for (Pixel p : listEscargot) {
      
      if ( colorPixDisplay ) c = p.newColour ; else c = p.colour ;
      p.changeHue   (HSBmode, huePalette, hueStart, hueEnd) ;
      p.changeSat   (HSBmode, satPalette, satStart, satEnd) ; 
      p.changeBright(HSBmode, brightPalette, brightStart, brightEnd) ;
      // update the color after change each componante
      p.updatePalette() ;
      

      int newC = color(hue(c),saturation(c)*factorSat,brightness(c)*factorBright, alpha(cIn)) ;

      PVector pos = new PVector(p.pos.x *ratio.x, p.pos.y *ratio.y) ;
      PVector newSize = new PVector() ;
      newSize = newSize3D(size, p.size, rangeThreeHundredSixty, rangeHundred, musicFactor, c, forceBeat) ;
      // display
      if (alpha(cIn) > 0 ) crossPoint3D(pos, newSize, newC, thickness) ;
    }
  }
  
  
  
  /////////////
  //display SVG shave like pixel
  public void escargotSVG(PVector size, float thickness, int cIn, int cOut, PVector rangeHundred, PVector rangeThreeHundredSixty, PVector musicFactor, PVector ratio) {
    int c ;
    float factorSatIn = map(saturation(cIn),0,100,0,1) ;
    float factorBrightIn = map(brightness(cIn),0,100,0,1) ;
    float factorSatOut = map(saturation(cIn),0,100,0,1) ;
    float factorBrightOut = map(brightness(cIn),0,100,0,1) ;
    
    for (Pixel p : listEscargot) { 
      //check if we must display original color or the new palette
      int x = (int)p.pos.x ; int y = (int)p.pos.y ;
      if (colorPixDisplay) c = p.newColour ; else c = get(x , y) ;
      
      p.changeHue   (HSBmode, huePalette, hueStart, hueEnd) ;
      p.changeSat   (HSBmode, satPalette, satStart, satEnd) ; 
      p.changeBright(HSBmode,brightPalette, brightStart, brightEnd) ;
      // update the color after change each componante
      p.updatePalette() ; 
      
      //display
      if (alpha(cIn) != 0) fill(hue(c),saturation(c)*factorSatIn,brightness(c)*factorBrightIn, alpha(cIn)) ; else noFill() ;
      if (alpha(cOut) != 0) {
        stroke(hue(c),saturation(c)*factorSatOut,brightness(c)*factorBrightOut, alpha(cOut)) ; 
        strokeWeight(thickness ) ;
      } else { 
        noStroke() ;
      } 
      //recalculate the pose  to scale with coordonate in the middle of the shape ( like(RectMode(CENTER) ) 
      
      PVector newSize = new PVector() ;
      newSize = newSize2D(size, p.size, rangeThreeHundredSixty, rangeHundred, musicFactor, c, forceBeat) ;
      // display
      float sizeSVG = newSize.x *.1f ;
      PVector newPos = new PVector ( p.pos.x - (50 *sizeSVG *.5f) *ratio.x ,p.pos.y - (50 *sizeSVG *.5f) *ratio.y) ;
  
      if (drawVertexSVG) drawBezierVertex(newPos, sizeSVG , listPointsFromSVG, shapeInfo ) ;
    }
  }
  
  
  
  
  
  /////////
  //VORONOI
  public void voronoiToxicSetup(){
    // focus x positions around horizontal center (w/ 33% standard deviation)
    xpos=new BiasedFloatRange(0, width, width/2, 0.333f);
    // focus y positions around bottom (w/ 50% standard deviation)
    ypos=new BiasedFloatRange(0, height, height, 0.5f);
    
    gfx = new ToxiclibsSupport(callingClass);
  }
  
  // DRAW
  public void voronoiStatic(int fill, int stroke, float thickness, boolean whichColor, PVector ratio) {
    whichColorVoronoi = whichColor ;
    // thicknessVoronoi = e ;
    //colorStrokeVoronoi = stroke ;
  
  
    for (Pixel b : listEscargot) {
      //security against the NaN result
      if (Float.isNaN(b.pos.x)) ; else voronoi.addPoint(new Vec2D(b.pos.x *ratio.x, b.pos.y *ratio.y));
    }
  
    for (Polygon2D poly : voronoi.getRegions() ) {
      //to recalculate the position in the arraylist
      PVector findPosFromVoronoi = new PVector (0,0) ;
      for (Vec2D v : voronoi.getSites() ) {
        if (poly.containsPoint(v) ) {
          //position in grid
          findPosFromVoronoi.x = PApplet.parseInt(v.x/pixelAnalyzeSize) ;
          findPosFromVoronoi.y = PApplet.parseInt(v.y/pixelAnalyzeSize) ;
          if(findPosFromVoronoi.x > cols -1 ) findPosFromVoronoi.x = cols -1 ;
          if(findPosFromVoronoi.y > rows -1 ) findPosFromVoronoi.y = rows -1 ;
          int posInList = (PApplet.parseInt(findPosFromVoronoi.x / ratio.x )  * rows ) + PApplet.parseInt(findPosFromVoronoi.y /ratio.y) ; 
          
          //look the color in the list
          if(posInList < listPixelRaw.size() ) {
            Pixel p = (Pixel) listPixelRaw.get(posInList) ;
            
            if (whichColorVoronoi) {
              //change the color with the new palette
              p.changeHue   (HSBmode, huePalette, hueStart, hueEnd) ;
              p.changeSat   (HSBmode, satPalette, satStart, satEnd) ; 
              p.changeBright(HSBmode,brightPalette, brightStart, brightEnd) ;
              // update the color after change each componante
              p.updatePalette() ; 
              float newSat = map(saturation(p.newColour),0,100, 0,saturation(fill)) ;
              float newBright = map(brightness(p.newColour),0,100, 0,brightness(fill)) ;
              fill(hue(p.newColour), newSat, newBright, alpha(fill)) ;
            } else {
              //original color of the pix
              fill(hue(p.colour), saturation(p.colour), brightness(p.colour), alpha(fill)) ;
            }
            if(thicknessVoronoi == 0 ) { 
              noStroke() ; 
            } else { 
              stroke(stroke) ;
              strokeWeight(thickness) ;
            }
          }
          gfx.polygon2D(poly);
        }
      }
    }
    //clear voronoi list
    voronoi = new Voronoi();
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  //COLOR
  //beat rectivity
  public PVector beatReactivityHSB(PVector sizeFromControleur, PVector sizeFromList, int beatColor, PVector range360, PVector range100, PVector beatFactor) {
    PVector newSize = sizeFromControleur.copy() ;
    //HUE
    if ( hue(beatColor) > range360.x && hue(beatColor) < range360.y ) {
      newSize.x = newSize.x             *beatFactor.x ; 
      newSize.y = newSize.y             *beatFactor.x ;
      newSize.z = newSize.z *beatFactor.x ;
    } else {
      newSize.x = newSize.x ;
      newSize.y = newSize.y ;
      newSize.z = newSize.z ;
    }
    
    //BRIGHTNESS
    if ( brightness(beatColor) > range100.x && brightness(beatColor) < range100.y ) { 
      newSize.x = sizeFromList.x        *sizeFromControleur.x *beatFactor.y ;  
      newSize.y = sizeFromList.y        *sizeFromControleur.y *beatFactor.y ;
      newSize.z = sizeFromList.z                  *beatFactor.y  ; 
    } else {
      newSize.x = sizeFromList.x *sizeFromControleur.x ;
      newSize.y = sizeFromList.y *sizeFromControleur.y ;
      newSize.z = newSize.z ;
    }
    
    //SATURATION
    if ( saturation(beatColor) > range100.x && saturation(beatColor) < range100.y ) { 
      newSize.x = sizeFromList.x *sizeFromControleur.x *beatFactor.z ; 
      newSize.y = sizeFromList.y *sizeFromControleur.y *beatFactor.z ;
      newSize.z =                 sizeFromControleur.z *beatFactor.z  ; 
    } else {
      newSize.x = sizeFromList.x *sizeFromControleur.x ;
      newSize.y = sizeFromList.y *sizeFromControleur.y ;
      newSize.z = newSize.z ;
      
    }
    return newSize ;
  }
  
  // SIZE PIXEL CALCUL
  // 2D PIXEL
  public PVector newSize2D(PVector size, PVector classSize, PVector range360, PVector range100, PVector factor, int c, int beatAmplitude) {
    PVector result = new PVector() ;
    if (result.z > size.z || soundButton[IDobj] == 1) {
    result.x = beatReactivityHSB(size, classSize, c, range360, range100, factor).x *map(allBeats(IDobj),1,40,1,beatAmplitude);
    result.y = beatReactivityHSB(size, classSize, c, range360, range100, factor).y *map(allBeats(IDobj),1,40,1,beatAmplitude) ;
    result.z = beatReactivityHSB(size, classSize, c, range360, range100, factor).z ;
      
    } else {
      result.x = classSize.x *size.x ;
      result.y = classSize.y *size.y ;
    }
    return result ;
  }
  // 3D PIXEL
  public PVector newSize3D(PVector size, PVector classSize, PVector range360, PVector range100, PVector factor, int c, int beatAmplitude) {
    PVector result = new PVector() ;
    float ratioDepth = map(brightness(c),0,100,0,1) ;
    result.x = beatReactivityHSB(size, classSize, c, range360, range100, factor).x *map(allBeats(IDobj),1,40,1,beatAmplitude) ;
    result.y = beatReactivityHSB(size, classSize, c, range360, range100, factor).y *map(allBeats(IDobj),1,40,1,beatAmplitude) ;
    result.z = beatReactivityHSB(size, classSize, c, range360, range100, factor).z ;
      
    if (soundButton[IDobj] == 1) {
      result.x = result.x *size.x ;
      result.y = result.y *size.y ;
      result.z = result.z *size.z *ratioDepth ;
    } else {
      result.x = classSize.x *size.x ;
      result.y = classSize.y *size.y ;
      result.z = (result.x + result.y)*.25f *size.z *ratioDepth ;
    }
    return result ;
  }
  
  
  
  
  
  
  
  
  
  //////////////////////////////
  //VOID ANALYZE
  //ReInit the Analyze image
  public void reInitilisationAnalyze() { 
      escargotGOanalyze = false ;
      escargotClear() ;
      analyzeDone = false ;
      totalPixCheckedInTheEscargot = 0 ;
  }
    
  //main analyze void    
  public void analyzeImg(int sizePixForAnalyze) {
    //Analyze image
    // put in this void the size of pixel you want, to create grid analyzing and image than you want analyze
    colorAnalyzeSetting(sizePixForAnalyze, img[IDobj]) ;
    
    //step 2
    //three componants : FIRST : size of the pixel grid // SECOND which PImage // THIRD mirror "FALSE" or "TRUE"
    recordPixelRaw(sizePixForAnalyze, img[IDobj], false) ; 
    
    //step 3
    // give the list point of Pixel must be change with the new palette
    changeColorOfPixel(listPixelRaw) ; 
    
    //step 4
    //escargot analyze of the arraylist create by the void recordPixelRaw
    
   if (escargotGOanalyze && listEscargot.size() < maxEntryPoints) {
      //security to make sure the speed is not higher to the max entry points
      if (speedAnalyze > maxEntryPoints / 10 ) speedAnalyze = maxEntryPoints / 10 ;
      for (int i = 0 ; i < speedAnalyze ; i++ ) {
        int whichPointInTheList  = (int)random(listPixelRaw.size()) ;
        //void without control for escargot analyze
        //escargotAnalyze(whichPointInTheList, radiusAnalyze, modeTri, useNewPalettePixColorToAnalyze ) ;
        
        //void with control for escargot analyze, the last component is a boolean control
        escargotAnalyze(whichPointInTheList, radiusAnalyze, modeTri, useNewPalettePixColorToAnalyze, escargotGOanalyze, sizePixForAnalyze ) ; // escargotStopAnalyze
      }
    }
  }
}





//////////////////
//ESCARGOT ANALYZE
/////////////////
//GLOBAL
boolean escargotGOanalyze = false ; // to stop the escargot analyze
// analyse en escargot \u00e9toil\u00e9 / analyze staring snail
int [] matricePosPixel = new int [10] ;

int getPixelEscargotAnalyze ;
//Barycentre
PVector barycenterEscargot = new PVector(0,0 ) ;
ArrayList<Pixel> listEscargot =  new ArrayList<Pixel>()   ;
//Temp Array List
ArrayList<Pixel> listPixelTemp =  new ArrayList<Pixel>()   ;
ArrayList<Pixel> listPixelByCol =  new ArrayList<Pixel>()  ;
ArrayList<Pixel> listPixelByRow =  new ArrayList<Pixel>() ;

//lattice pixel
int startingPixelToAnalyze ;
//level ananlyze around the pixel lattice
int  maxSnailLevel ; // degre of perimeter of analyze around the main pixel, and max perimeter
int  [] lockEscargot = new int[9] ; // for the 8 direction around the lattice, pivot, main pixel plus 1 for the origin
//info
int  numberPixelAnalyze ;
int  totalPixCheckedInTheEscargot ;


//main void analyze
//SETUP
public void escargotClear() {
  if(listEscargot.size() > 0 ) { 
    listEscargot.clear() ;
    listPixelRaw.clear() ;
  }
}

//DRAW

//CLASSIC ANALYZE
//analyze a specific point
public void escargotAnalyze(int pivot, int max, String mode, boolean whichColor, int sizePix ) {
  maxSnailLevel = max ;
  //setting the lockEscargot
  for (int i = 0 ; i< lockEscargot.length ; i++) lockEscargot[i] = 0 ;
  
  if(listPixelRaw.size() > 0 && pivot < listPixelRaw.size() ) {
    Pixel pixelRef = (Pixel) listPixelRaw.get(pivot) ;


    if (pixelRef.ID == 0 ) {
      startingPixelToAnalyze += 1 ; // information of how many pixel is starting point analyzing
      //choice wich color of pixel must be use for the analyzis, the original one or the new one
      int colorRef ;
      if ( !whichColor ) colorRef = pixelRef.colour ; else colorRef = pixelRef.newColour ;
      
      for (int snailLevel = 1 ; snailLevel <= maxSnailLevel ; snailLevel++) {
        for (int escargotPos = 1 ; escargotPos < 10 ; escargotPos++) { // "posPixelAroundTheMainPixel" give the direction around the pixel pivot
          if (lockEscargot[escargotPos -1] == 0 ) {
            //cols and rows is var from TAB "B_Pixel_Analyze_raw_Record"
            //strange the way is vetical and we must use the rows, not a same way than pixel who use the cols
                                    //escargot analyze algorythme return the position of pixel neightbor in the ordre of ArrayList
            getPixelEscargotAnalyze = escargot(escargotPos, pivot, snailLevel, rows, listPixelRaw.size() ) ; // find the position of the pixel target in the list
            
            if (getPixelEscargotAnalyze > 0 && getPixelEscargotAnalyze < listPixelRaw.size()  ) {  // check if the pixel is valid for the list
              Pixel pixelEscargotAnalyze = (Pixel) listPixelRaw.get(getPixelEscargotAnalyze) ; //look the pixel in the list
              
              //check the color by field hue, saturation, brightness
              if (mode.equals("hsb"))    hueSaturationBrightnessCheck(escargotPos, colorRef, pixelEscargotAnalyze, whichColor) ; 
              //check the color by field hue
              else if (mode.equals("h"))  hueCheck(escargotPos, colorRef, pixelEscargotAnalyze, whichColor) ; 
              //check the color by field saturation
              else if (mode.equals("s"))  saturationCheck(escargotPos, colorRef, pixelEscargotAnalyze, whichColor) ; 
              //check the color by field brightness
              else if (mode.equals("b"))  brightnessCheck(escargotPos, colorRef, pixelEscargotAnalyze, whichColor) ;
              //check the color by field hue and saturation
              else if (mode.equals("hs"))  hueSaturationCheck(escargotPos, colorRef, pixelEscargotAnalyze, whichColor) ;
              //check the color by field hue and brigthness
              else if (mode.equals("hb"))  hueBrightnessCheck(escargotPos, colorRef, pixelEscargotAnalyze, whichColor) ;
              //check the color by field saturation and brigthness
              else if (mode.equals("sb"))  saturationBrightnessCheck(escargotPos, colorRef, pixelEscargotAnalyze, whichColor) ;   
              else hueCheck(escargotPos, colorRef, pixelEscargotAnalyze, whichColor) ; 
            }
          }
        }
      }
      //COMPLETE THE LIST of pixel escargot in the area around the barrycenter, to change the ID "zero" to "one"
      //check in cols to complete the pixel area after Escargot Analyze
      checkPixelInCol() ;
      //check in row to complete the pixel area after Escargot Analyze
      checkPixelInRow() ;
      
      //calculate the barycenter of the family point, this void must be in the main lood for include the good color
      findEscargot(colorRef, sizePix) ;
      //clear the temp for the next round analyzis
      for (int i = 0 ; i< lockEscargot.length ; i++) lockEscargot[i] = 0 ;
      listPixelTemp.clear() ;
      barycenterEscargot = new PVector(0,0) ;
      numberPixelAnalyze = 0 ;
      
    }
  }
}




//CLASSIC ANALYZE
//analyze a specific point, with possibility to stop the analyzis
public void escargotAnalyze(int pivot, int max, String mode, boolean whichColor, boolean analyzeGO, int sizePix ) {
  maxSnailLevel = max ;
  //setting the lockEscargot
  for (int i = 0 ; i< lockEscargot.length ; i++) lockEscargot[i] = 0 ;
  
  if(listPixelRaw.size() > 0 && pivot < listPixelRaw.size() ) {
    Pixel pixelRef = (Pixel) listPixelRaw.get(pivot) ;


    if (pixelRef.ID == 0 && analyzeGO ) {
      pixelRef.changeID(1) ;
      startingPixelToAnalyze += 1 ; // information of how many pixel is starting point analyzing
      //choice wich color of pixel must be use for the analyzis, the original one or the new one
      int colorRef ;
      if ( !whichColor ) colorRef = pixelRef.colour ; else colorRef = pixelRef.newColour ;
      
      for ( int snailLevel = 1 ; snailLevel <= maxSnailLevel ; snailLevel++) {
        for ( int escargotPos = 1 ; escargotPos < 10 ; escargotPos++) { // "posPixelAroundTheMainPixel" give the direction around the pixel pivot
          if (lockEscargot[escargotPos -1] == 0 ) {
            //cols and rows is var from TAB "B_Pixel_Analyze_raw_Record"
            //strange the way is vetical and we must use the rows, not a same way than pixel who use the cols
                                    //escargot analyze algorythme return the position of pixel neightbor in the ordre of ArrayList
            getPixelEscargotAnalyze = escargot(escargotPos, pivot, snailLevel, rows, listPixelRaw.size() ) ; // find the position of the pixel target in the list
            
            if (getPixelEscargotAnalyze > 0 && getPixelEscargotAnalyze < listPixelRaw.size()  ) {  // check if the pixel is valid for the list
              Pixel pixelEscargotAnalyze = (Pixel) listPixelRaw.get(getPixelEscargotAnalyze) ; //look the pixel in the list
              
              //check the color by field hue, saturation, brightness
              if (mode.equals("hsb"))    hueSaturationBrightnessCheck(escargotPos, colorRef, pixelEscargotAnalyze, whichColor) ; 
              //check the color by field hue
              else if (mode.equals("h"))  hueCheck(escargotPos, colorRef, pixelEscargotAnalyze, whichColor) ; 
              //check the color by field saturation
              else if (mode.equals("s"))  saturationCheck(escargotPos, colorRef, pixelEscargotAnalyze, whichColor) ; 
              //check the color by field brightness
              else if (mode.equals("b"))  brightnessCheck(escargotPos, colorRef, pixelEscargotAnalyze, whichColor) ;
              //check the color by field hue and saturation
              else if (mode.equals("hs"))  hueSaturationCheck(escargotPos, colorRef, pixelEscargotAnalyze, whichColor) ;
              //check the color by field hue and brigthness
              else if (mode.equals("hb"))  hueBrightnessCheck(escargotPos, colorRef, pixelEscargotAnalyze, whichColor) ;
              //check the color by field saturation and brigthness
              else if (mode.equals("sb"))  saturationBrightnessCheck(escargotPos, colorRef, pixelEscargotAnalyze, whichColor) ;   
              else hueCheck(escargotPos, colorRef, pixelEscargotAnalyze, whichColor) ; 
            }
          }
        }
      } 
        
      //COMPLETE THE LIST of pixel escargot in the area around the barrycenter, to change the ID "zero" to "one"
      //check in cols to complete the pixel area after Escargot Analyze
      checkPixelInCol() ;
      //check in row to complete the pixel area after Escargot Analyze
      checkPixelInRow() ;
      
      
      //calculate the barycenter of the family point, this void must be in the main lood for include the good color
      findEscargot(colorRef, sizePix) ;
      

      
      
      //clear the temp for the next round analyzis
      for (int i = 0 ; i< lockEscargot.length ; i++) lockEscargot[i] = 0 ;
      listPixelTemp.clear() ;
      barycenterEscargot = new PVector(0,0) ;
      totalPixCheckedInTheEscargot += numberPixelAnalyze ;
      
      numberPixelAnalyze = 0 ;
      
    }
  }
}





//ANNEXE PRIVATE VOID


///////////////////////
//COMPLETE THE ESCARGOT
//COL
private void checkPixelInCol() {
  int numPixInCol = 0 ;
  
  for ( int whichCol = 1 ; whichCol <= cols ; whichCol++) {
    for ( int j = 0 ; j< listPixelTemp.size() ; j++) {
      Pixel pixTemp = (Pixel) listPixelTemp.get(j) ;
      if( pixTemp.gridPos.x == whichCol ) {
        numPixInCol += 1 ;
        listPixelByCol.add(new Pixel(pixTemp.rank)) ;
      }
    }
    //Changez the ID "ZERO" to "ONE" of pixel if there is more of one point in col
    if(numPixInCol > 1  ) {
      int [] pixPosInCol = new int [numPixInCol] ;
      for ( int k = 0 ; k < listPixelByCol.size() ; k++) {
        Pixel pixByCol = (Pixel) listPixelByCol.get(k) ;
        pixPosInCol[k] = pixByCol.rank ;
      }
      pixPosInCol = sort(pixPosInCol) ;
      for(int l = pixPosInCol[0] ; l < pixPosInCol[pixPosInCol.length -1] ; l++) {
        Pixel pix = (Pixel) listPixelRaw.get(l) ;
        if(pix.ID == 0) {
          // git a new ID "ONE" to say this Pixel has been checked, and now don'k try to make something with her
          pix.changeID(1) ;
          //complet the temp list completed
          PVector posInTheGrid = gridPosition(l) ;
      //    listPixelTempCompleted.add(new Pixel(l, posInTheGrid)) ;
          listPixelTemp.add(new Pixel(l, posInTheGrid)) ;
        }
      }
    }
    //clear the  list for the next col
    numPixInCol = 0 ; 
    listPixelByCol.clear() ;
  }
}


//ROW
private void checkPixelInRow() {
  int numPixInRow = 0 ;
  for ( int whichRow = 1 ; whichRow <= rows ; whichRow++) {
    for ( int j = 0 ; j< listPixelTemp.size() ; j++) {
      Pixel pixTemp = (Pixel) listPixelTemp.get(j) ;
      if( pixTemp.gridPos.y == whichRow ) { 
        numPixInRow += 1 ;
        listPixelByRow.add(new Pixel(pixTemp.rank, pixTemp.gridPos)) ;
      }
    }
    //Changez the ID "ZERO" to "ONE" of pixel if there is more of one point in col
    if(numPixInRow > 1  ) {
      int [] pixPosInRow = new int [numPixInRow] ;
      int [] whichColForPix = new int [numPixInRow] ;
      for ( int k = 0 ; k < listPixelByRow.size() ; k++) {
        Pixel pixByRow = (Pixel) listPixelByRow.get(k) ;
        pixPosInRow[k] = pixByRow.rank ;
        whichColForPix[k] = (int)pixByRow.gridPos.x ;
      }
      //pixPosInRow = sort(pixPosInRow) ;
      whichColForPix = sort(whichColForPix) ;
      int startPoint = whichColForPix[0] ;
      int lastPoint = whichColForPix[pixPosInRow.length -1] ;

      for(int l = startPoint ; l < lastPoint  ; l++) {
        int whichPixel = (l-1) * rows + pixPosInRow[0] %rows ;
        Pixel pix = (Pixel) listPixelRaw.get(whichPixel) ;
        if(pix.ID == 0) {
          // git a new ID "ONE" to say this Pixel has been checked, and now don'k try to make something with her
          pix.changeID(1) ;
          //complet the temp list completed
          PVector posInTheGrid = gridPosition(whichPixel) ;
          //listPixelTempCompleted.add(new Pixel(whichPixel, posInTheGrid)) ;
          listPixelTemp.add(new Pixel(whichPixel, posInTheGrid)) ;
        } 
      }
    }
    //clear the  list for the next row
    numPixInRow = 0 ;
    listPixelByRow.clear() ; 
  }
}

////////////
//BARYCENTER
public void findEscargot(int cRef, int pixSize) {
  for ( Pixel p :  listPixelTemp ) {
    PVector posInTheGrid = p.gridPos ;
    barycenterEscargot.x += posInDisplay(posInTheGrid.x, pixSize) ;
    barycenterEscargot.y += posInDisplay(posInTheGrid.y, pixSize) ;
  }
  //divid the some of the point to find the position of the barycenter
  barycenterEscargot.x /= listPixelTemp.size() ; 
  barycenterEscargot.y /= listPixelTemp.size() ;

  PVector sizeBarycenter = new PVector(numberPixelAnalyze, numberPixelAnalyze) ;
  //add barycenter in the list
  listEscargot.add(new Pixel(barycenterEscargot, sizeBarycenter, cRef)); 
}


//SCALE THE POSITION FROM THE GRID TO DISPLAY
public float posInDisplay(float posInGrid, int sizeCell) {
  float p = 0 ;
  p = posInGrid * sizeCell - (sizeCell * .5f ) ;
  return p ;
}
  

/////////////////////////////////////////////////
//POSITION in the grid systeme with cols and rows
public PVector gridPosition(int posPixel) {
  PVector gridPos = new PVector (0,0) ;
  for ( int j = 0 ; j < cols ; j++) {

    // return the collums where leave the pixel
    if (posPixel >= rows * j && posPixel < (rows * j) + rows) {
        gridPos.x = j +1 ;
    }
    // return the line(row) where leave the pixel
    for ( int k = 0 ; k < rows ; k++) {
      if (posPixel == (rows * (j)) + k) {
        gridPos.y = k +1 ;
      }
    }
  }
  return gridPos ;
}

///////////////////
int wichColorCheck ;
//HSB CHECK
//by hsb
public void hueSaturationBrightnessCheck(int escargotPos_n, int cRef, Pixel pixelEscargotAnalyze, boolean whichPix) {
  //choice the ref color in pix Class a original color or the new one
  if( !whichPix ) wichColorCheck = pixelEscargotAnalyze.colour ; else wichColorCheck = pixelEscargotAnalyze.newColour ;
  if( pixelEscargotAnalyze.ID == 0 // check if the pixel is never analyze before
      && hue(wichColorCheck) == hue(cRef) // and if the hue is good
      && saturation(wichColorCheck) == saturation(cRef) // and if the saturation is good
      && brightness(wichColorCheck) == brightness(cRef) ) { // and if the brightness is good too 
    // change the ID "ZERO" to "ONE" to indicate this that pixel has to be checked and have a good color.
    pixelEscargotAnalyze.changeID(1) ;
    //return the coordinate in the grid system rows and cols
    PVector posInTheGrid = gridPosition(getPixelEscargotAnalyze) ;
    
    listPixelTemp.add( new Pixel(getPixelEscargotAnalyze, posInTheGrid)) ;
    
    numberPixelAnalyze += 1 ; // count of pixel has be analyzing
  } else {
    //close this direction for the next round
    lockEscargot[escargotPos_n -1] = 1 ;
  }
}

//by hue
public void hueCheck(int escargotPos_n, int cRef, Pixel pixelEscargotAnalyze, boolean whichPix) {
  //choice the ref color in pix Class a original color or the new one
  if( !whichPix ) wichColorCheck = pixelEscargotAnalyze.colour ; else wichColorCheck = pixelEscargotAnalyze.newColour ;
  if( pixelEscargotAnalyze.ID == 0 && hue(wichColorCheck) == hue(cRef) ) { // check if the pixel is never analyze before and if the hue is good
  // change the ID "ZERO" to "ONE" to indicate this that pixel has to be checked and have a good color.
    pixelEscargotAnalyze.changeID(1) ;
    //return the coordinate in the grid system rows and cols
    PVector posInTheGrid = gridPosition(getPixelEscargotAnalyze) ;
    
    listPixelTemp.add( new Pixel(getPixelEscargotAnalyze, posInTheGrid)) ;
    
    numberPixelAnalyze += 1 ; // count of pixel has be analyzing
  } else {
    //close this direction for the next round
    lockEscargot[escargotPos_n -1] = 1 ;
  }
}

//by saturation
public void saturationCheck(int escargotPos_n, int cRef, Pixel pixelEscargotAnalyze, boolean whichPix) {
  //choice the ref color in pix Class a original color or the new one
  if( !whichPix ) wichColorCheck = pixelEscargotAnalyze.colour ; else wichColorCheck = pixelEscargotAnalyze.newColour ;
  if( pixelEscargotAnalyze.ID == 0 && saturation(wichColorCheck) == saturation(cRef) ) // check if the pixel is never analyze before and if the hue is good
    {

    // change the ID "ZERO" to "ONE" to indicate this that pixel has to be checked and have a good color.
    pixelEscargotAnalyze.changeID(1) ;
    //return the coordinate in the grid system rows and cols
    PVector posInTheGrid = gridPosition(getPixelEscargotAnalyze) ;
    
    listPixelTemp.add( new Pixel(getPixelEscargotAnalyze, posInTheGrid)) ;
    
    numberPixelAnalyze += 1 ; // count of pixel has be analyzing
  } else {
    //close this direction for the next round
    lockEscargot[escargotPos_n -1] = 1 ;
  }
}

//by brightness
public void brightnessCheck(int escargotPos_n, int cRef, Pixel pixelEscargotAnalyze, boolean whichPix) {
  //choice the ref color in pix Class a original color or the new one
  if( !whichPix ) wichColorCheck = pixelEscargotAnalyze.colour ; else wichColorCheck = pixelEscargotAnalyze.newColour ;
  if( pixelEscargotAnalyze.ID == 0 && brightness(wichColorCheck) == brightness(cRef) ) // check if the pixel is never analyze before and if the hue is good
    {
      // change the ID "ZERO" to "ONE" to indicate this that pixel has to be checked and have a good color.
    pixelEscargotAnalyze.changeID(1) ;
    //return the coordinate in the grid system rows and cols
    PVector posInTheGrid = gridPosition(getPixelEscargotAnalyze) ;
    
    listPixelTemp.add( new Pixel(getPixelEscargotAnalyze, posInTheGrid)) ;
    
    numberPixelAnalyze += 1 ; // count of pixel has be analyzing
  } else {
    //close this direction for the next round
    lockEscargot[escargotPos_n -1] = 1 ;
  }
}
//by hue and saturation
public void hueSaturationCheck(int escargotPos_n, int cRef, Pixel pixelEscargotAnalyze, boolean whichPix) {
  //choice the ref color in pix Class a original color or the new one
  if( !whichPix ) wichColorCheck = pixelEscargotAnalyze.colour ; else wichColorCheck = pixelEscargotAnalyze.newColour ;
  if( pixelEscargotAnalyze.ID == 0 // check if the pixel is never analyze before
      && hue(wichColorCheck) == hue(cRef) // and if the hue is good
      && saturation(wichColorCheck) == saturation(cRef) ) // and if the saturation is good
      { 
    // change the ID "ZERO" to "ONE" to indicate this that pixel has to be checked and have a good color.
    pixelEscargotAnalyze.changeID(1) ;
    //return the coordinate in the grid system rows and cols
    PVector posInTheGrid = gridPosition(getPixelEscargotAnalyze) ;
    
    listPixelTemp.add( new Pixel(getPixelEscargotAnalyze, posInTheGrid)) ;
    
    numberPixelAnalyze += 1 ; // count of pixel has be analyzing
  } else {
    //close this direction for the next round
    lockEscargot[escargotPos_n -1] = 1 ;
  }
}

// by hue and brigthness
public void hueBrightnessCheck(int escargotPos_n, int cRef, Pixel pixelEscargotAnalyze, boolean whichPix) {
  //choice the ref color in pix Class a original color or the new one
  if( !whichPix ) wichColorCheck = pixelEscargotAnalyze.colour ; else wichColorCheck = pixelEscargotAnalyze.newColour ;
  if( pixelEscargotAnalyze.ID == 0 // check if the pixel is never analyze before
      && hue(wichColorCheck) == hue(cRef) // and if the hue is good
      && brightness(wichColorCheck) == brightness(cRef) ) { // and if the brightness is good too 
    // change the ID "ZERO" to "ONE" to indicate this that pixel has to be checked and have a good color.
    pixelEscargotAnalyze.changeID(1) ;
    //return the coordinate in the grid system rows and cols
    PVector posInTheGrid = gridPosition(getPixelEscargotAnalyze) ;
    
    listPixelTemp.add( new Pixel(getPixelEscargotAnalyze, posInTheGrid)) ;
    
    numberPixelAnalyze += 1 ; // count of pixel has be analyzing
  } else {
    //close this direction for the next round
    lockEscargot[escargotPos_n -1] = 1 ;
  }
}

//by saturation and brightness
public void saturationBrightnessCheck(int escargotPos_n, int cRef, Pixel pixelEscargotAnalyze, boolean whichPix) {
  //choice the ref color in pix Class a original color or the new one
  if( !whichPix ) wichColorCheck = pixelEscargotAnalyze.colour ; else wichColorCheck = pixelEscargotAnalyze.newColour ;
  if( pixelEscargotAnalyze.ID == 0 // check if the pixel is never analyze before
      && saturation(wichColorCheck) == saturation(cRef) // and if the saturation is good
      && brightness(wichColorCheck) == brightness(cRef) ) { // and if the brightness is good too 
    // change the ID "ZERO" to "ONE" to indicate this that pixel has to be checked and have a good color.
    pixelEscargotAnalyze.changeID(1) ;
    //return the coordinate in the grid system rows and cols
    PVector posInTheGrid = gridPosition(getPixelEscargotAnalyze) ;
    
    listPixelTemp.add( new Pixel(getPixelEscargotAnalyze, posInTheGrid)) ;
    
    numberPixelAnalyze += 1 ; // count of pixel has be analyzing
  } else {
    //close this direction for the next round
    lockEscargot[escargotPos_n -1] = 1 ;
  }
}

///////////////////


//////////////////
//MATRICE ESCARGOT
//escargot analyze algorythme return the position of pixel neightbor in the ordre of ArrayList
//strange the order int the arraylist is vertical, not like a pixel order who is horizontale, So we must use the rows, not cols to find a good neightbor pixel.
public int escargot(int escargotPos_n, int start, int level, int numRows, int sizeList ) {
  //pivot
  matricePosPixel[1] = start + (0*level *numRows) + (0*level)  ; // neutre
  //autour du pivot
  ////////////////
  matricePosPixel[2] = start + (1*level *numRows) + (0*level)  ; // Est
  //special condition for the bottom boarder
  if (start%numRows + level >= numRows ) matricePosPixel[3] = -1 ; else matricePosPixel[3] = start + (1*level *numRows) + (1*level)  ; // Sud-Est
  if (start%numRows + level >= numRows ) matricePosPixel[4] = -1 ; else matricePosPixel[4] = start + (0*level *numRows) + (1*level)  ; // Sud
  if (start%numRows + level >= numRows ) matricePosPixel[5] = -1 ; else matricePosPixel[5] = start - (1*level *numRows) + (1*level)  ; // Sud-Ouest
  matricePosPixel[6] = start - (1*level *numRows) + (0*level)  ; // Ouest
  //special condition for the top boarder
  if (start%numRows < level ) matricePosPixel[7] = -1 ; else matricePosPixel[7] = start - (1*level *numRows) - (1*level)  ; // Nord-Ouest
  if (start%numRows < level ) matricePosPixel[8] = -1 ; else matricePosPixel[8] = start + (0*level *numRows) - (1*level)  ; // Nord
  if( start%numRows < level ) matricePosPixel[9] = -1 ; else matricePosPixel[9] = start + (1*level *numRows) - (1*level)  ; // Nord-Est
  
  if      ( escargotPos_n == 1 ) return matricePosPixel [1] ;
  else if ( escargotPos_n == 2 ) return matricePosPixel [2] ;
  else if ( escargotPos_n == 3 ) return matricePosPixel [3] ;
  else if ( escargotPos_n == 4 ) return matricePosPixel [4] ;
  else if ( escargotPos_n == 5 ) return matricePosPixel [5] ;
  else if ( escargotPos_n == 6 ) return matricePosPixel [6] ;
  else if ( escargotPos_n == 7 ) return matricePosPixel [7] ;
  else if ( escargotPos_n == 8 ) return matricePosPixel [8] ;
  else if ( escargotPos_n == 9 ) return matricePosPixel [9] ;
  else return matricePosPixel[0] ;
}














////////////////
//PIXEL ANALYZE
///////////////
ArrayList<Pixel> listPixelRaw = new ArrayList<Pixel>() ;
// Number of columns and rows in our system
int cols, rows ; 
float ratioCols, ratioRows;
//give the position in the order of displaying
int whereIsPixel ;
//security when you load an image, to start the displaying only if you've finish to analyze this one
boolean analyzeDone ;

//SETUP
//SETTING
public void colorAnalyzeSetting(int pixSize, PImage imgAnalyze) {
  if (imgAnalyze != null ) {
    
    cols = imgAnalyze.width / pixSize;
    rows = imgAnalyze.height / pixSize;
    
    ratioCols = width / imgAnalyze.width ;
    ratioRows = height / imgAnalyze.height ;
  } 
}




//RECORD
//RAW RECORD without timer
public void recordPixelRaw(int cellSize, PImage imgRecord, boolean mirror) {
  if (imgRecord != null && !analyzeDone  ) {
    imgRecord.loadPixels() ;
    //start analyze
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        
        int x = i*cellSize;
        int y = j*cellSize;
        //check if there is mirror effect or not
        if(!mirror) whereIsPixel =  y*imgRecord.width +x; else whereIsPixel = (imgRecord.width -x -1) + y*imgRecord.width; // Reversing x to mirror the image
        //analyze the color of the pixel in the HSB mode
        float h = hue       (imgRecord.pixels[whereIsPixel]);
        float s = saturation(imgRecord.pixels[whereIsPixel]);
        float b = brightness(imgRecord.pixels[whereIsPixel]);
        // Make a new color and position
        int c = color(h, s, b);
        PVector pos = new PVector(x+cellSize/2, y+cellSize/2 ) ;
        //add position and color of the pixel in the list
        listPixelRaw.add(new Pixel(pos, c)) ;
      }
    }
    analyzeDone = true ;
    escargotGOanalyze = true ;
  } 
}

//RAW RECORD with timer
int stepAnalyzeImg ;
//from image
public void recordPixelRaw(int cellSize, PImage imgRecord, float time, boolean mirror) {
  int newStep = timer(time) ;
  //analyze each new step
  if (stepAnalyzeImg != newStep ) {
    //clear the list for new analyze
    listPixelRaw.clear() ;
    
    imgRecord.loadPixels() ;
    //start analyze
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        int x = i*cellSize;
        int y = j*cellSize;
        //check if there is mirror effect or not
        if(!mirror) whereIsPixel =  y*imgRecord.width +x; else whereIsPixel = (imgRecord.width - x - 1) + y*imgRecord.width; // Reversing x to mirror the image
        //analyze the color of the pixel in the HSB mode
        float h = hue       (imgRecord.pixels[whereIsPixel]);
        float s = saturation(imgRecord.pixels[whereIsPixel]);
        float b = brightness(imgRecord.pixels[whereIsPixel]);
        // Make a new color and position
        int c = color(h, s, b);
        PVector pos = new PVector(x+cellSize/2, y+cellSize/2 ) ;
        //add position and color of the pixel in the list
        listPixelRaw.add(new Pixel(pos, c)) ;
      }
    }
  }
  stepAnalyzeImg = newStep ;
}








////////////
//DRAW SVG
PShape shapeSVG ;
boolean drawVertexSVG ;
ArrayList<PVector> listPointsFromSVG = new ArrayList<PVector>();;
ArrayList <PVector> shapeInfo = new ArrayList<PVector>(); ;

//SETUP
public void shapeSVGsetting(String p) {
  drawVertexSVG = false ;
  listPointsFromSVG.clear();
  shapeInfo.clear();
  shapeSVG = loadShape(p) ;
  startPoint = endPoint = 0 ;
  createListOfPoint(shapeSVG) ;
}


//Information about the shape
PShape[] childrenShape ; // to create a shape children from SVG
int IDshapeChildren ;
int startPoint, endPoint ;

public void createListOfPoint (PShape s ) {
  
  int  numChildren, numPoint;
  PVector pos  ;
  //find the quantity object from SVG
  numChildren = s.getChildCount(); 
  
  //if there is children, separate the shape
  if ( numChildren > 0 ) {
    for ( int i = 0 ; i  < numChildren ; i++) {
      childrenShape = s.getChildren() ;
      createListOfPoint (childrenShape[i]) ;
    }
  //if there no children we can write the shape in the list
  } else {
    numPoint = s.getVertexCount() ;
    //to find the exit point in the list
    endPoint = startPoint + numPoint ;
    
    
    //add information ID, entry and exit point of each children shape for the future !
    shapeInfo.add(new PVector(IDshapeChildren, startPoint, endPoint )) ;
    //display information
    //to find the ID shape
    IDshapeChildren += 1 ;
    //to find the next entry point in the list
    
    //startPoint = endPoint +1 ;
    startPoint = endPoint  ;
    
    //startPoint = endPoint  ;
    //loop to put the point from SVG in the list
    for ( int j = 0 ; j < numPoint ; j++) {
      pos = new PVector (s.getVertexX(j), s.getVertexY(j), 0.0f ) ;
      listPointsFromSVG.add(new PVector(pos.x, pos.y, pos.z)) ;
    }
    drawVertexSVG = true ;
  }
}




//Draw shape bezier Vertex
public void drawBezierVertex(ArrayList<PVector> list, ArrayList<PVector> shapes) {
    if (drawVertexSVG) {
      for ( int i = 0 ; i < shapes.size() ; i++) {
      int start = PApplet.parseInt(shapes.get(i).y) ;
      int end   = PApplet.parseInt(shapes.get(i).z) ;
      beginShape() ;
      for ( int j = start ; j < end ; j++) {
        if (j == start ) { 
          
          vertex(list.get(j).x, list.get(j).y) ;
        } else if (j > start && j < end -2 ) { 
          bezierVertex( list.get(j).x, list.get(j).y, list.get(j+1).x, list.get(j+1).y, list.get(j+2).x, list.get(j+2).y ) ;
        }
        //must be different of "0" for the starting point
        if( j != start ) j += 2 ; // +=2 for the switch to next point because the BezierVertex need the coordinate
      }
      endShape() ;
    }
  }
}
//Draw with scale
public void drawBezierVertex(PVector pos, float scale, ArrayList<PVector> list, ArrayList<PVector> shapes) {
  if (drawVertexSVG) {
      for ( int i = 0 ; i < shapes.size() ; i++) {
      int start = PApplet.parseInt(shapes.get(i).y) ;
      int end   = PApplet.parseInt(shapes.get(i).z) ;
      beginShape() ;
      for ( int j = start ; j < end ; j++) {
        if (j == start ) { 
          
          vertex(list.get(j).x *scale +pos.x, list.get(j).y *scale +pos.y) ;
        } else if (j > start && j < end -2 ) { 
          bezierVertex( list.get(j).x   *scale +pos.x, list.get(j).y   *scale +pos.y, 
                        list.get(j+1).x *scale +pos.x, list.get(j+1).y *scale +pos.y, 
                        list.get(j+2).x *scale +pos.x, list.get(j+2).y *scale +pos.y ) ;
        }
        //must be different of "0" for the starting point
        if( j != start ) j += 2 ; // +=2 for the switch to next point because the BezierVertex need the coordinate
      }
      endShape() ;
    }
  }
}










//LOAD PATTERN
//SVG PATTERN
String pathSVGescargot ;

//load SVG
public void choiceSVG(File selection) {
  if (selection == null) {
    println("no pattern selected");
  } else {
    pathSVGescargot  = selection.getAbsolutePath() ;
    shapeSVGsetting(pathSVGescargot) ;

  }
}
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
  public void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
    loadImg(IDobj) ;
  }
  
  // declare VAR
  //////////////
  float speed = .3f ;
  // GRID IMAGE
  int sizePixel_image ;
  int altitude_image ;
  // GRID SIMPLE
  float amplitude_simple_grid = 30 ;
  float step  = .01f ;  
  float refSizeTriangle ;
  Vec2 canvasRef ;
  Vec4 fill_color, stroke_color ;
  
  
  // draw
  public void display() {
    // color to Vec4 composant
    fill_color = Vec4(hue(fillObj[IDobj]),saturation(fillObj[IDobj]),brightness(fillObj[IDobj]),alpha(fillObj[IDobj])) ;
    stroke_color = Vec4(hue(strokeObj[IDobj]),saturation(strokeObj[IDobj]),brightness(strokeObj[IDobj]),alpha(strokeObj[IDobj])) ;
    // load image
    if(parameter[IDobj]) loadImg(IDobj) ;


    if(motion[IDobj]) speed = speedObj[IDobj] *.7f ; else speed = 0 ;
    
    
    
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
      int sizePix_grid_simple = PApplet.parseInt(sizePixMin +sizeXObj[IDobj] /33) ;
      if(!fullRendering) sizePix_grid_simple *= 3 ;
      //size canvas grid
      Vec2 newCanvas = Vec2(canvasXObj[IDobj],canvasYObj[IDobj]) ;
      newCanvas.mult(4.5f) ;
      // create grid if there is no grid
      if( grid_surface_simple.size() < 1) create_surface_simple(sizePix_grid_simple,newCanvas) ;
      
      // from of the wave
      int maxStep = (int)map(influenceObj[IDobj],0,1,2,50) ;
      step = map(noise(5),0,1,0,maxStep) ; // break the linear mode of the wave
      // amplitude
      amplitude_simple_grid = amplitudeObj[IDobj] *height *.07f *beat[IDobj] *mix[IDobj]  ;
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
      float speed_image = speedObj[IDobj] * .2f ;
      float amplitude_image = amplitudeObj[IDobj] *width *2 *mix[IDobj] ;
      altitude_image = PApplet.parseInt(sin(frameCount *speed_image) *amplitude_image) ;
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
  public void update_and_clean(int whichMode) {
    if(whichMode == 0 ) {
      if( grid_surface_simple.size() > 0 )grid_surface_simple.clear() ;
      update_surface_image(sizePixel_image, fill_color, stroke_color,thicknessObj[IDobj], altitude_image) ;
    } else if (whichMode == 1 || whichMode == 2 ) {
      if( grid_surface_image.size() > 0 )grid_surface_image.clear() ;
      update_surface_simple(fillObj[IDobj], strokeObj[IDobj], thicknessObj[IDobj], speed, amplitude_simple_grid, step) ;
    }
  }
  
  
  // SURFACE SIMPLE
  public void create_surface_simple(int sizePix, Vec2 canvas) {
    /*
    PVector startingPosition give the starting position for the drawing grid, the value is -1 to 1
    if you start with (0,0) the canvas start from the center, if you use the extreme value, the draw start from corner.
    this value can be interesting for the rotation axes.
    */
    PVector startingPosition = new PVector(0, 0) ; 
    surfaceGrid(sizePix, canvas, startingPosition, grid_surface_simple) ;
  }
  
  
  public void update_surface_simple(int c_fill, int c_stroke, float thickness, float speed, float amplitude, float step) {
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
  
  public void moveAllTriangle(float speed, float amplitude, float step) {
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
  public void update_surface_image(int sizePix, Vec4 color_fill, Vec4 color_stroke, float thickness, int altitude) {
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
  public void surface_build_image_grid(float x, float y, int altitude, int sizeTriangle, ArrayList<Polygon> gridTriangle, Vec4 color_fill, Vec4 color_stroke, float thickness) {
      //setting grid
    PVector startingPosition = new PVector(x, y) ; 
    /*
    PVector startingPosition give the starting position for the drawing grid, the value is -1 to 1
     if you start with (0,0) the canvas start from the center, if you use the extreme value, the draw start from corner.
     this value can be interesting for the rotation axes.
     */
    surfaceGridImg(sizeTriangle, startingPosition, image, gridTriangle) ;
    if(gridTriangle.size() > 0 ) {
      if(testRomanesco) println("compute Surface grid");
      surfaceImgColor(gridTriangle, color_fill, color_stroke, thickness) ;
      
      surfaceImgSummit(altitude, gridTriangle) ;
      createSurfaceShape(gridTriangle) ;
      newPicture = false ;
    }
  }
  
  // CHANGE PATTERN from IMAGE
  PImage imgSurface ;
  
  
  public void surfaceGridImg(int sizePix, PVector startingPosition, PImage imgSurface, ArrayList<Polygon> gridTriangle) {
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
  public void surfaceImgColor(ArrayList<Polygon> gridTriangle, Vec4 color_fill, Vec4 color_stroke, float thickness) {
    /* We calculated the value of first pixel in the pixel arraylist to remove or add this "firstValue" to the other the pixel, 
     because we need have count from zero to find give the good color to the good polygon. */
    Polygon ref = (Polygon) grid_surface_image.get(0) ;
    int firstValue = PApplet.parseInt((ref.pos.y -1) *imgSurface.width +ref.pos.x) ;

    for (Polygon t : gridTriangle) {
      // find the pixel in the picture import with the triangle grid to return the color to polygon.
      int  rankPixel = PApplet.parseInt((t.pos.y) *imgSurface.width +t.pos.x) -firstValue ;
  
      
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
  
  public void surfaceImgSummit(int altitude, ArrayList<Polygon> gridTriangle) {
    /* We calculated the value of first pixel in the pixel arraylist to remove or add this "firstValue" to the other the pixel, 
     because we need have count from zero to find give the good color to the good polygon. */
    PVector posFirstValue = (PVector) listTrianglePoint.get(0) ;
    int firstValue = PApplet.parseInt((posFirstValue.y -1) *imgSurface.width +posFirstValue.x) ;
  
    for (PVector pos : listTrianglePoint) {
      int  rankPixel = PApplet.parseInt((pos.y) *imgSurface.width +pos.x) -firstValue ;
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
  public void createSurfaceShape(ArrayList<Polygon> gridTriangle) {
    if(testRomanesco) println("Create high Surface mesh");
    patternShape = createShape();
    patternShape.beginShape(TRIANGLES);
    for (Polygon t : gridTriangle) {
      t.draw_polygon_in_PShape(patternShape) ;
    }
    patternShape.endShape(CLOSE);
    if(testRomanesco) println("High Surface mesh has been created with "+patternShape.getVertexCount()+" vertex");
  }
  //
  public void surfaceShapeDraw() {
    shape(patternShape);
  }
  // END SHAPE METHOD
  ///////////////////




















// BUILD
/////////

// GRID TRIANGLE
ArrayList<PVector> listTrianglePoint = new ArrayList<PVector>() ;

// Main void
public void surfaceGrid(int triangleSize, Vec2 canvas, PVector startingPositionToDraw, ArrayList<Polygon> gridTriangle) {
  buildTriangleGrid(triangleSize, canvas, startingPositionToDraw, gridTriangle) ;
  selectCommonSummit(gridTriangle) ;
}


// Annexe void
// build the grid
public void buildTriangleGrid(int triangleSize, Vec2 canvas, PVector startingPositionToDraw, ArrayList<Polygon> gridTriangle) {
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
  float medianLineLength = sideLengthOfEquilateralTriangle *(sqrt(3) *.5f) ; // find the length of the mediane equilateral triangle
  
  // angle correction
  float correction = .5235f ;
  float correctionAngle  ;
  
  // Build the grid
  for(int i = 0 ; i < canvas.y/medianLineLength ; i++) {
    float verticalCorrection = medianLineLength *i ;
    // we change the starting line to make a good pattern.
    float horizontalCorrection ;
    if(i%2 == 0 ) horizontalCorrection = 0 ; else horizontalCorrection = sideLengthOfEquilateralTriangle *.5f ;
    
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
      pos.x = j *(sideLengthOfEquilateralTriangle *.5f) +horizontalCorrection ; 
      pos.add(startingPos) ;
      
      //create triangle and add in the list of triangle
      Polygon triangle = new Polygon(pos, radiusCircumCircle, correctionAngle, 3, countTriangle++);
      gridTriangle.add(triangle) ;
      
    }
  }
}


// build the list of the common summit
public void selectCommonSummit(ArrayList<Polygon> gridTriangle) {
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
        float range = .1f ;
        if((posSum.x <= sumPoint.x +range && posSum.x >= sumPoint.x -range)  && (posSum.y <= sumPoint.y +range && posSum.y >= sumPoint.y -range) ) addSum = false ;
      }
      if(addSum)listTrianglePoint.add(posSum) ;
      addSum = true ;
    }
  }
}

// END BUILD
///////////

// Z BACKGROUND
//////////////////////////////////////////////////////////////////
Vec4  colorBackground, colorBackgroundRef, colorBackgroundPrescene;


public void backgroundSetup() {
  colorBackgroundRef = Vec4() ;
  colorBackground = Vec4() ;
  colorBackgroundPrescene = Vec4(0,0,20,HSBmode.a) ;
}


public void backgroundRomanesco() {
  // in preview mode the background is always on, to remove the trace effect
  if(!fullRendering) { 
    onOffBackground = false ;
    colorBackground = colorBackgroundPrescene.copy() ;
    backgroundP3D(colorBackground) ;
  } else {
    if(onOffBackground) {
      if(whichShader == 0) {
        // check if the color model is changed after the shader used
        if(g.colorModeX != 360 || g.colorModeY != 100 || g.colorModeZ !=100 || g.colorModeA !=100) colorMode(HSB,360,100,100,100) ;
        // choice the rendering color palette for the classic background
        if(fullRendering) {
          // check if the slider background are move, if it's true update the color background
          if(!compare(colorBackgroundRef,updateBackground())) colorBackground = updateBackground().copy() ;
          else colorBackgroundRef = updateBackground().copy() ;
          backgroundP3D(colorBackground) ;
        } 
        backgroundP3D(colorBackground) ;
      } else {
        backgroundShaderDraw(modeP3D, whichShader) ;
      }
    }
  }
}






// ANNEXE VOID BACKGROUND
/////////////////////////
public Vec4 updateBackground() {
  //to smooth the curve of transparency background
  // HSB
  float hue_bg =         map(valueSlider[0][0],0,MAX_VALUE_SLIDER,0,HSBmode.r) ;
  float saturation_bg =  map(valueSlider[0][1],0,MAX_VALUE_SLIDER,0,HSBmode.g) ;
  float brigthness_bg =  map(valueSlider[0][2],0,MAX_VALUE_SLIDER,0,HSBmode.b) ;
  // ALPHA
  float factorSmooth = 2.5f ;
  float nx = norm(valueSlider[0][3], 0.0f , MAX_VALUE_SLIDER) ;
  float alpha = pow (nx, factorSmooth);
  alpha = map(alpha, 0, 1, 0.8f, HSBmode.a) ;
  return Vec4(hue_bg,saturation_bg,brigthness_bg,alpha) ;
}

//diffenrent background
public void backgroundClassic(Vec4 c) {
  //DISPLAY FINAL
  noStroke() ;
  fill(c.r,c.g, c.b, c.a) ;
  rect (0,0, width, height) ;
}

//P3D
//BACKGROUND
////////////
public void backgroundP3D(Vec4 c) {
  // I don't remember why there is an alpha comparaison with under or upper 90 ?
  if(c.a < 90 ) {
    fill(c.r, c.g, c.b, c.a) ;
    noStroke() ;
    pushMatrix() ;
    translate(-sizeBackgroundP3D.x *.5f,-sizeBackgroundP3D.y *.5f , -sizeBackgroundP3D.z) ;
    rect(0,0, sizeBackgroundP3D.x, sizeBackgroundP3D.y) ;
    popMatrix() ;
  } else {
    background(c.r, c.g, c.b, c.a) ;
  }
  
}





// BACKGROUND SHADER
PShader blurOne, blurTwo, cellular, damierEllipse, heart, necklace,  psy, sinLight, snow ;
//PShader bizarre, water, psyTwo, psyThree ;

public void backgroundShaderSetup(boolean renderP3D) {
  if(renderP3D) {
    String pathShaderBG = preferencesPath +"background_shader/" ;
    

    blurOne = loadShader(pathShaderBG+"blurOneFrag.glsl") ;
    blurTwo = loadShader(pathShaderBG+"blurTwoFrag.glsl") ;
    cellular = loadShader(pathShaderBG+"cellularFrag.glsl") ;
    damierEllipse = loadShader(pathShaderBG+"damierEllipseFrag.glsl") ;
    heart = loadShader(pathShaderBG+"heartFrag.glsl") ;
    necklace = loadShader(pathShaderBG+"necklaceFrag.glsl") ;
    psy = loadShader(pathShaderBG+"psyFrag.glsl") ;
    sinLight = loadShader(pathShaderBG+"sinLightFrag.glsl") ;
    snow = loadShader(pathShaderBG+"snowFrag.glsl") ;

    /*
    bizarre = loadShader(pathShaderBG+"bizarreFrag.glsl") ; // work bad
    water = loadShader(pathShaderBG+"waterFrag.glsl") ; // problem
    psyTwo = loadShader(pathShaderBG+"psyTwoFrag.glsl") ; // problem
    psyThree = loadShader(pathShaderBG+"psyThreeFrag.glsl") ; // problem
    */
  }
}



public void backgroundShaderDraw(boolean renderP3D, int whichOne) {
  if( (renderP3D && testRomanesco) ||  (renderP3D && fullRendering) ) {
    PVector posBGshader = new PVector(0,0) ;
    PVector sizeBGshader = new PVector(width,height, height) ; 
    fill(0) ; noStroke() ;

    if     (whichOne ==1) rectangle(posBGshader, sizeBGshader, blurOne ) ;
    else if(whichOne ==2) rectangle(posBGshader, sizeBGshader, blurTwo ) ;
    else if(whichOne ==3) rectangle(posBGshader, sizeBGshader, cellular) ;
    else if(whichOne ==4) rectangle(posBGshader, sizeBGshader, damierEllipse) ;
    else if(whichOne ==5) rectangle(posBGshader, sizeBGshader, heart) ;
    else if(whichOne ==6) rectangle(posBGshader, sizeBGshader, necklace) ;
    else if(whichOne ==7) rectangle(posBGshader, sizeBGshader, psy) ;
    else if(whichOne ==8) rectangle(posBGshader, sizeBGshader, snow ) ;
    else if(whichOne ==9) rectangle(posBGshader, sizeBGshader, sinLight ) ;
    
    
    //rectangle(posBGshader, sizeBGshader, bizarre) ;  // work bad
    //rectangle(posBGshader, sizeBGshader, water) ; // problem
    //rectangle(posBGshader, sizeBGshader, psyTwo) ; // problem
    //rectangle(posBGshader, sizeBGshader, psyThree) ; // problem
  }  else if (whichOne != 0  ) {
    backgroundP3D(Vec4(100)) ;
    int sizeText = 14 ;
    textSize(sizeText) ;
    fill(orange) ; noStroke() ;
    text("Shader is ON", sizeText, height/3) ;
  } 

}

float shaderMouseX, shaderMouseY ;
public void rectangle(PVector pos, PVector size, PShader s) {
  int factorSize = 10 ;
  size.mult(factorSize) ;
  pushMatrix() ;
  translate(-size.x *.5f,-size.y *.5f , -size.z*.5f) ;
  shader(s) ;
  
  
  PVector RGBbackground  = new PVector () ;
  RGBbackground = HSBtoRGB(map(valueSlider[0][0],0,MAX_VALUE_SLIDER,0,HSBmode.x), map(valueSlider[0][1],0,MAX_VALUE_SLIDER,0,HSBmode.y), map(valueSlider[0][2],0,MAX_VALUE_SLIDER,0,HSBmode.z) ) ;
  float redNorm = map(RGBbackground.x,0,255,0,1) ;
  float greenNorm = map(RGBbackground.y,0,255,0,1) ;
  float blueNorm = map(RGBbackground.z,0,255,0,1) ;
  float alphaNorm = map(valueSlider[0][3],0,MAX_VALUE_SLIDER,0,1) ;
  float varTime = (float)millis() *.001f ;
  if(spaceTouch) {
    shaderMouseX = map(mouse[0].x,0,width,0,1) ;
    shaderMouseY = map(mouse[0].y,0,height,0,1) ;
  }
  
  s.set("colorBG",redNorm, greenNorm, blueNorm, alphaNorm) ; 
  s.set("mixSound", mix[0]) ;
  s.set("timeTrack", getTimeTrack()) ;
  s.set("tempo", tempo[0]) ;
  s.set("beat", allBeats(0)) ;
  s.set("mouse",shaderMouseX, shaderMouseY) ;
  s.set("resolution",size.x/factorSize, size.y/factorSize) ;
  s.set("time", varTime);
  
  beginShape(QUADS) ;
  vertex(pos.x,pos.y) ;
  vertex(pos.x +size.x,pos.y) ;
  vertex(pos.x +size.x,pos.y +size.y) ;
  vertex(pos.x,pos.y +size.y) ;
  endShape() ;
  resetShader() ;
  popMatrix() ;
}






//
//END BACKGROUND
/////////////////////////////
// Camera Engine version 6.a
////////////////////////////
private PVector posSceneMouseRef = new PVector() ;
private PVector posEyeMouseRef = new PVector() ;
private PVector posSceneCameraRef= new PVector() ;
private PVector posEyeCameraRef = new PVector() ;
private PVector eyeCamera = new PVector() ;
private PVector sceneCamera = new PVector() ;
private PVector deltaScenePos = new PVector() ;
private PVector deltaEyePos = new PVector() ;
private PVector tempEyeCamera = new PVector() ;
private boolean newRefSceneMouse = true ;
private boolean newRefEyeMouse = true ;

// Update Camera position
/* We move the scene 
*/

public PVector updatePosCamera(boolean authorization, boolean leapMotionDetected, PVector posDevice) {
  if(authorization) {
    //create the ref to calcul the new position of the Scene
    if(newRefSceneMouse) {
      posSceneCameraRef = sceneCamera.copy() ;
      posSceneMouseRef = posDevice.copy() ;
      //to create a only one ref position
      newRefSceneMouse = false ;
    }

    //create the delta between the ref and the mouse position
    deltaScenePos = PVector.sub(posDevice, posSceneMouseRef) ;
    if (leapMotionDetected) return      PVector.add(PVector.mult(deltaScenePos,-1), posSceneCameraRef ) ; 
                            else return PVector.add(deltaScenePos, posSceneCameraRef ) ;
  } else {
    //change the boolean to true for the next mousepressed
    newRefSceneMouse = true ;
    return sceneCamera ;
  }
}
//


// Update Camera EYE position
public PVector updateEyeCamera(boolean authorization, PVector posMouse) {
  // PVector refEyeCamera = new PVector()  ;
  if(authorization) {
    //create the ref to calcul the new position of the Scene
    if(newRefEyeMouse) {
      posEyeCameraRef = tempEyeCamera ;
      posEyeMouseRef = posMouse.copy() ;
    }
    //to create a only one ref position
    newRefEyeMouse = false ;
    //create the delta between the ref and the mouse position
    deltaEyePos = PVector.sub(posMouse, posEyeMouseRef) ;
    tempEyeCamera = PVector.add(deltaEyePos, posEyeCameraRef ) ;

    //rotation of the camera
    // return eyeClassic(tempEyeCamera) ;
    return eyeClassic(tempEyeCamera).copy() ;
  } else {
    //change the boolean to true for the next mousepressed
    newRefEyeMouse = true ;
    return eyeCamera ;
  }
  
}




// EYE POSITION two solutions
/*
Solution 1
We must use this one with le leapmotion information, because with the leapmotion device
there is no "pmouse" information.
*/
PVector eyeMemory ;
public PVector eyeClassic(PVector tempEye) {
  PVector eyeP3D = new PVector() ;
  eyeP3D = new PVector(map(tempEye.y, 0, width, 0, 360), map(tempEye.x, 0, height, 0, 360)) ; 
  return eyeP3D ;
}


/*
solution 2
we can use this better void when we don't use the leapmotion */

// Solution interesting but there is problem with it ??????????
public PVector eyeAdvanced(PVector PreviousPos, PVector pos, PVector speed) {
  PVector eyeP3D = new PVector() ;
  // eyeP3D.x += (PreviousPos.y -pos.y) *speed.y;
  // eyeP3D.y += (PreviousPos.x -pos.x) *-speed.x;
  eyeP3D.x += (PreviousPos.y -pos.y) *speed.y;
  eyeP3D.y += (PreviousPos.x -pos.x) *-speed.x;
  
  if(eyeP3D.x > 360) eyeP3D.x = 0 ;
  if(eyeP3D.x < 0) eyeP3D.x = 360 ;
  if(eyeP3D.y > 360) eyeP3D.y = 0 ; 
  if(eyeP3D.y < 0) eyeP3D.y = 360 ;
  return eyeP3D ;
}

// END EYE POSITION
/////////////////////

//travelling
boolean gotoCameraPosition, gotoCameraEye, travellingPriority ;

//speed must be 1 or less
float speedMoveOfCamera = 0.1f ;
//CAMERA Stuff
private boolean moveScene, moveEye ;

PVector targetPosCam = new PVector() ;

//P3D ROMANESCO STUFF
PVector speedDirectionOfObject  ;
// PVector  P3DpositionMouseRef = new PVector() ;


PVector deltaObjDir = new PVector() ;

PVector tempObjDir = new PVector() ;
PVector sizeBackgroundP3D  ;


// P3D SETUP
////////////
public void P3DSetup(boolean modeP3D, int numObj, int numSettingCamera, int numSettingOrientationObject) {
      
  if(modeP3D) {
    sizeBackgroundP3D = new PVector(width *100, height *100, height *7.5f) ;
    settingAllCameras (numSettingCamera) ;
    settingObjManipulation (numObj) ;
    settingObjectManipulation(numObj, numSettingCamera, numSettingOrientationObject) ;
    initVariableCamera() ;
  }
}


// ANNEXE setting object manipulation
public void settingObjManipulation (int numObj) {
  //P3D for all ROMANESCO object
  for ( int i = 0 ; i < numObj ; i++ ) {
    posObj[i] = new PVector() ; 
    dirObj[i] = new PVector () ;
    dirObjX [i] = 0 ;
    dirObjY [i] = 0 ;
  }
}

public void settingObjectManipulation (int numObj, int numSettingCamera, int numSettingOrientationObject) {
  // object orientation
  for ( int i = 0 ; i < numSettingOrientationObject ; i++ ) {
    for (int j = 0 ; j < numObj ; j++ ) {
       posObjSetting [i][j] = new PVector() ;
       dirObjSetting [i][j] = new PVector() ;
     }
   }
}

// ANNEXE setting camera manipulation
public void settingAllCameras (int numSettingCamera) {
  if (eyeCameraSetting != null && sceneCameraSetting != null ) {
    for ( int i = 0 ; i < numSettingCamera ; i++ ) {
       eyeCameraSetting[i] = new PVector () ;
       sceneCameraSetting[i] = new PVector () ;
    }
  }
}
  


//END SETUP
///////////













////////////////////////////////
//OBJECT position and direction
// MAIN
// final direction and oriention with object ID
public void objectMove(boolean movePos, boolean moveDir, int ID) {
  //UPDATE
  //position
  if (!movePos)  newObjRefPos = true ;
  PVector newPos = updatePosObj(posObj[ID], ID, movePos) ;
  posObjX[ID] = newPos.x ;
  posObjY[ID] = newPos.y ;
  posObjZ[ID] = newPos.z ;
  //rotation
  if (!moveDir) newObjRefDir = true ;
    //speed rotation
  float speed = 100.0f ; // 150 is medium speed rotation
  speedDirectionOfObject = new PVector(speed /(float)width, speed /(float)height) ; 
  dirObjX[ID] = updateDirObj(speedDirectionOfObject, ID, moveDir).x ; 
  dirObjY[ID] = updateDirObj(speedDirectionOfObject, ID, moveDir).y ;
  
  //RESET
  if(touch0) {
    posObjX[ID] = posObjSetting [0][ID].x ;
    posObjY[ID] = posObjSetting [0][ID].y ;
    posObjZ[ID] = posObjSetting [0][ID].z ;
    dirObjX[ID] = dirObjSetting [0][ID].x ;
    dirObjY[ID] = dirObjSetting [0][ID].y ;
  }
  addRefObj(ID) ;
}




// UPDATE POSITION & DIRECTION obj
//////////////////////////////////

// update direction obj
/////////////////////////////////////////////
PVector  P3DdirectionMouseRef = new PVector() ;

public PVector updateDirObj(PVector speed, int ID, boolean authorization) {
  if(authorization) {
    if(newObjRefDir) {
      dirObjRef = tempObjDir.copy() ;
      P3DdirectionMouseRef = mouse[0].copy() ;
    }
    //to create a only one ref position
    newObjRefDir = false ;
    //create the delta between the ref and the mouse position
    deltaObjDir = PVector.sub(mouse[0], P3DdirectionMouseRef) ;
    tempObjDir = PVector.add(deltaObjDir, dirObjRef) ;
    
    //rotation of the camera
    dirObj[ID] = eyeClassic(tempObjDir).copy() ;
  } else {
    newObjRefDir = true ;
  }
  return dirObj[ID] ;
}
// end update direction obj
////////////////////////////



// update position obj
//////////////////////
PVector P3DpositionMouseRef = new PVector() ;

public PVector updatePosObj(PVector pos, int ID, boolean authorization) {
  Vec3 deltaObjPos = new Vec3() ;
  // we must re-init the Z value because the behavior of the wheel is different than coordonate of the mouse who are permanent.
  P3DpositionMouseRef.z = 0 ;

  // XY pos
  if(newObjRefPos) {
    posObjRef[ID] = pos.copy() ;
    P3DpositionMouseRef.x = mouse[0].x ;
    P3DpositionMouseRef.y = mouse[0].y ;
    // special op with the wheel value, because this value is not constant
    P3DpositionMouseRef.z -= wheel[0] ;

  }
  // Z position with the wheel
  deltaObjPos.z = wheel[0] -P3DpositionMouseRef.z ;

  // X et Y pos with the mouse coordonate
  if (authorization) {
    //to create a only one ref position
    newObjRefPos = false ;
    //create the delta between the ref and the mouse position
    deltaObjPos.x = mouse[0].x -P3DpositionMouseRef.x ;
    deltaObjPos.y = mouse[0].y -P3DpositionMouseRef.y ;
  } 

  // special op with the wheel value
  deltaObjPos.z *= -1.f ;
  /**
  // WORK AROUND CAMERA, to find the position of the camera when we Rotate the camera...
  // VERY HARD !!!!!
  // mag obg
  float magObj = mag(deltaObjPos) ;
  // polar info for the obj and the camera
  Vec3 polarObj = toPolar(deltaObjPos) ;
  
  // info 
  // println("real pos cam ", sceneCamera) ;
  float magCam =  height/2 ;
  Vec3 posCamCorrection = new Vec3( sceneCamera.x, sceneCamera.y, sceneCamera.z + magCam) ;

  
  // polar info for the obj and the camera
  Vec3 polarObj = toPolar(deltaObjPos) ;
  float norm360longitude = mapCycle(eyeCamera.x,0,360) ;
  float norm360latitude = mapCycle(eyeCamera.y ,0,360) ;
  // transform value 0-360 to 0-2PI
  float longitude = map(norm360longitude,0,360, 0, TAU) ;
  float latitude = map(norm360latitude, 0,360,0,TAU) ;
  // finalize calcul for the cartesian position of camera



 
  Vec3 cart_sol_1 = toCartesian(longitude, latitude, magCam) ;
  strokeWeight (10) ;
  stroke (0,0,100) ;
  int ratio = 2 ;
  point(cart_sol_1.x *ratio,cart_sol_1.y *ratio,cart_sol_1.z *ratio) ;
  // cartEye.x *= -1 ;
  
  println("cartesian classic Eye ", (int)cart_sol_1.x, 
                                    (int)cart_sol_1.y, 
                                    (int)cart_sol_1.z ) ;
                                    
                                    Vec3 cart_sol_2 = toCartesian3D ( Vec2 (mouse[0].x,mouse[0].y), Vec2(width,height), magCam) ;
  point(cart_sol_2.x,cart_sol_2.y ,cart_sol_2.z ) ;
  println("cartesian Alternative Eye ",(int)cart_sol_2.x, (int)cart_sol_2.y, (int)cart_sol_2.z) ;
  
  // *************************************
  ///////////////////////////////////
  // TRY THIS SOLUTION, same than sceneCamera ???????
  
  // if(!moveScene) sceneCamera = (follow(origin, target, speed)) ;

  
  // END WORK around the camera
  ////////////////////////////
  */

  PVector delta = deltaObjPos.copyVecToPVector() ;
  // final position
  pos = PVector.add(posObjRef[ID], delta) ;
  return pos ;
}
// end update position obj
//////////////////////////




// local method update position and direction
///////////////////////////////////////////



//go to the new position
public void P3DmoveObj(int ID) {
  translate(posObjX[ID], posObjY[ID], posObjZ[ID]) ;
  rotateX(radians(dirObjX[ID])) ;
  rotateY(radians(dirObjY[ID])) ;
}


// END UPDATE POSITION & DIRECTION obj
//////////////////////////////////////










//Create ref position
public void addRefObj(int ID) {
  if(modeP3D) {
    posObj[ID] = new PVector (posObjX[ID], posObjY[ID],posObjZ[ID]) ;
    dirObj[ID] = new PVector (dirObjX[ID], dirObjY[ID]);
  }
}



//starting position
public void startPosition(int ID, int x, int y, int z) {
  startingPosition[ID] = new PVector(x,y,z) ;
  posObjX[ID] = x -(width/2) ;
  posObjY[ID] = y -(height/2) ;
  posObjZ[ID] = z ;
  
  posObjSetting [0][ID] = new PVector(posObjX[ID], posObjY[ID], posObjZ[ID] ) ;
  mouse[ID] = new PVector (x,y,z) ;
}
// END MOVE OBJECT
///////////////////////////////////////////






// METHOD Variable update variable camera
/////////////////////////////////////////
float dirCamX,dirCamY,dirCamZ,
      centerCamX,centerCamY,centerCamZ,
      upX,upY,upZ ;
float focal, deformation ;

Vec3 finalSceneCamera ;
Vec2 finalEyeCamera ;





// init var
public void initVariableCamera() {
  variableCameraPresceneRendering() ;
}










// MOVE CAMERA
//////////////
public void cameraDraw() {
  updateCamera(moveScene, moveEye, LEAPMOTION_DETECTED, cLongTouch) ;
  // set camera variable
  /* look if the user is on the Prescene or not, and other stuff to display the good views */
  setVariableCamera(cLongTouch) ;

  // deformation and focal of the lenz camera
  paralaxe(focal, deformation) ;
  
  //camera order from the mouse or from the leap
  controlCamera(cLongTouch) ;

  /*
      //void with speed setting
  float speed = 150.0 ; // 150 is medium speed rotation
  PVector speedRotation = new PVector(speed /(float)width, speed /(float)height) ; 
  */
  startCamera() ;
  
  //to change the scene position with a specific point
  if(gotoCameraPosition || gotoCameraEye ) {
    moveCamera(sceneCamera, targetPosCam, speedMoveOfCamera) ;
  }

  //catch ref camera
  catchCameraInfo() ;
}
//END CAMERA DRAW



















// Annexe method of the method cameraDraw()
///////////////////////////////////////////
public void setVariableCamera(boolean authorization) {
  // float focal = map(valueSlider[0][19],0,360,28,200) ;

  /* this method need to be on the Prescene sketch and on the window.
  1. boolean prescene : On prescene, because on Scene we don't need to have a global view : boolean prescene
  2. boolean MOUSE_IN_OUT : because if we mode out the sketch the keyevent is not updated, and the camera stay in camera view */
  if(fullRendering || (cLongTouch && MOUSE_IN_OUT && prescene)) variableCameraFullrendering(authorization) ; else variableCameraPresceneRendering() ;
}

public void variableCameraFullrendering(boolean authorization) {
    // world rendering
  focal = map(valueSlider[0][19],0,360,28,200) ;
  deformation = map(valueSlider[0][20],0,360,-1,1) ;
  // camera
  dirCamX = map(valueSlider[0][21],0,360,0,width)  ; // on controler is Eye X
  dirCamY = map(valueSlider[0][22],0,360,0,height)  ; // on controler is Eye Y
  dirCamZ = map(valueSlider[0][23],0,360,0,width)  ; // on controler is Eye Z
  
  centerCamX = map(valueSlider[0][24],0,360,0,width)  ; // on controler is Position X
  centerCamY = map(valueSlider[0][25],0,360,0,height)  ; // on controler is Position Y
  centerCamZ = map(valueSlider[0][26],0,360,0,width)  ; // on controler is Position Z

  upX = map(valueSlider[0][27],0,360,-1,1) ;
  upY = 1 ; // not interesting
  upZ = 0 ; // not interesting

  // displacement of the scene
  int displacement_scene_x = width/2 ;
  int displacement_scene_y = height/2 ;
  int displacement_scene_z = 0 ;
  
  // Check the special move camera
  float compare_pos_scene_x = finalSceneCamera.x - sceneCamera.x ;
  float compare_pos_scene_y = finalSceneCamera.y - sceneCamera.y ;
  float compare_pos_scene_z = finalSceneCamera.z - sceneCamera.z ;
  boolean specialMoveCamera ;
  if( compare_pos_scene_x != displacement_scene_x || 
      compare_pos_scene_y != displacement_scene_y || 
      compare_pos_scene_z != displacement_scene_y ) specialMoveCamera = true ; else specialMoveCamera = false ;
  
  // final camera position
  if (checkMouseMove(authorization) || specialMoveCamera) {
    finalSceneCamera = new Vec3 (sceneCamera.x +displacement_scene_x, sceneCamera.y +displacement_scene_y, sceneCamera.z +displacement_scene_z) ;
    finalEyeCamera = new Vec2 (radians(eyeCamera.x), radians(eyeCamera.y) ) ;
  }
}


public void variableCameraPresceneRendering() {
      // default setting camera from Processing.org example, like the camera above
    /*
    float dirCamX = width/2.0 ; // eye X
    float dirCamY = height/2.0 ; // eye Y
    float dirCamZ = (height/2.0) / tan(PI*30.0 / 180.0) ; // // eye Z
    float centerCamX = width/2.0 ; // Position X
    float centerCamY = height/2.0 ; // Position Y
    float centerCamZ = 0 ; // Position Z
    float upX = 0 ;
    float upY = 1 ;
    float upZ = 0 ;
    */
     // world rendering
    focal = 40 ; // 28-200
    deformation = 0 ; // -1 to 1 
    // camera
    dirCamX = width/2.0f ; // eye X
    dirCamY = height/2.0f ; // eye Y
    dirCamZ = (height/2.0f) / tan(PI*30.0f / 180.0f) ; // eye Z
    
    centerCamX = width/2.0f ; // Position X
    centerCamY = height/2.0f ; // Position Y
    centerCamZ = 0 ; // Position Z
    
    upX = 0 ;
    upY = 1 ;
    upZ = 0 ;
        // final camera position
    finalSceneCamera = new Vec3 (width/2, height, -width) ;
    float longitude = -45 ;
    float latitude = 0 ;
    finalEyeCamera = new Vec2 (longitude, latitude) ;

}



//CATCH a ref position and direction of the camera
PVector posCamRef = new PVector() ;
PVector eyeCamRef = new PVector() ;
//boolean security to catch the reference camera when you reset the position of this one
boolean catchCam = true ;

public void catchCameraInfo() {
  if(catchCam) {
    posCamRef = getPosCamera() ;
    eyeCamRef = getEyeCamera() ;
  }
  catchCam = false ;
}
//END catch position



//camera order from the mouse or from the leap
public void controlCamera(boolean authorazation) {
  if(authorazation) {
    if(ORDER_ONE || ORDER_THREE) moveScene = true ;   else moveScene = false ;
    if(ORDER_TWO || ORDER_THREE) moveEye = true ;   else moveEye = false ;
      
    //update z position of the camera
    sceneCamera.z -= wheel[0] ;
      
    // change camera position
    if(enterTouch) travelling(posCamRef) ;
    if (touch0) {
      changeCameraPosition(0) ;
    }
  } else if (!authorazation || (ORDER_ONE && ORDER_ONE && ORDER_THREE) ) {
    moveScene = false ;
    moveEye = false ;
  }  
}


//startCamera with speed setting
public void startCamera() {
  pushMatrix() ;
  camera(dirCamX, dirCamY, dirCamZ, centerCamX, centerCamY, centerCamZ, upX, upY, upZ) ;
  beginCamera() ;
  // scene position
  translate(finalSceneCamera.x, finalSceneCamera.y, finalSceneCamera.z) ;
  // scene orientation direction
  /* eyeCamera, is not a good terminilogy because the real eye camera is not use here. Here we just move the world. */
  rotateX(finalEyeCamera.x) ;
  rotateY(finalEyeCamera.y) ;
  /**  
  // you find popMatrix() in the method stopCamera() ;
  */
}





// update the position of the scene (camera) and the orientation
public void updateCamera(boolean scene, boolean eye, boolean leapMotion, boolean authorization) {
  if(authorization) {
    // update the world position

    /* We cannot use the method copy() of the PVector, because we must preserve the "Z" parameter of this PVector to move the Scene with the wheel */
    sceneCamera.x = updatePosCamera(scene, leapMotion, mouse[0]).x ;
    sceneCamera.y = updatePosCamera(scene, leapMotion, mouse[0]).y ;
    eyeCamera = updateEyeCamera(eye, mouse[0]).copy() ;
  }
}


// move camera to target
public void moveCamera(PVector origin, PVector target, float speed) {
  if(!moveScene) sceneCamera = follow(origin, target, speed) ;
  if(!moveEye && (gotoCameraPosition || gotoCameraEye)) eyeCamera = backEye()  ;
}


// CHANGE CAMERA POSITION
public void changeCameraPosition(int ID) {
  eyeCamera = eyeCameraSetting[ID].copy() ;
  sceneCamera = sceneCameraSetting[ID].copy() ;
  gotoCameraPosition = false ;
  gotoCameraEye = false ;
}


//stop
public void stopCamera() {
  popMatrix() ;
  endCamera() ;
  stopParalaxe() ;
}


// check if the mouse move or not, it's use to update or not the position of the world.
// we must use that to don't update the scene when we load the save scene setting
Vec3 mouseCheckRef = Vec3() ;
int wheelCheckRef = 0 ;

public boolean checkMouseMove( boolean authorization) {
  boolean mouseMove ;
  if( authorization && (!compare(mouseCheckRef, Vec3(mouse[0])) || wheelCheckRef != wheel[0])) mouseMove = true ; else mouseMove = false ;
  // create ref
  wheelCheckRef = wheel[0] ;
  mouseCheckRef = Vec3(mouse[0]) ;
  return mouseMove ;
}




















//GET
public PVector getEyeCamera() { return eyeCamera ; }
public PVector getPosCamera() { return sceneCamera ; }




//INIT FOLLOW
float distFollowRef = 0 ;
PVector eyeBackRef = new PVector() ;
//travelling with only camera position
public void travelling(PVector target) {
  distFollowRef = PVector.dist(target, sceneCamera) ;
  
  targetPosCam = target ; 
  eyeBackRef = getEyeCamera() ;
  absPosition = new PVector() ;
  gotoCameraPosition = true ;
  gotoCameraEye = true ;
}
//END INIT FOLLOW



float speedX  ;
float speedY  ;
    
public PVector backEye() {
  PVector eye = new PVector() ;

  if(gotoCameraEye) {
    if(currentDistToTarget > 2 ) {
      travellingPriority = true ;
      if (eyeBackRef.x < 180 ) eye.x = map(currentDistToTarget,distFollowRef, 0,eyeBackRef.x, 0) ; else eye.x = map(currentDistToTarget,distFollowRef, 0,eyeBackRef.x, 360) ;
      if (eyeBackRef.y < 180 ) eye.y = map(currentDistToTarget,distFollowRef, 0,eyeBackRef.y, 0) ; else eye.y = map(currentDistToTarget,distFollowRef, 0,eyeBackRef.y, 360) ;
      //stop the calcul
      if(eye.x < 2 || eye.x > 358 ) eye.x = 0 ;
      if(eye.y < 2 || eye.y > 358 ) eye.y = 0 ; 
      if(eye.x == 0  && eye.y == 0) {
        gotoCameraEye = false ;
        travellingPriority = false ;
      }
    } else {
      //speed of the eye to return to original position
      float speedBackEye = 0.2f ;
      float ratioX = eyeBackRef.x / frameRate *speedBackEye ;
      float ratioY = eyeBackRef.y / frameRate *speedBackEye ;
      speedX += ratioX ;
      speedY += ratioY ;
      if (eyeBackRef.x < 180 && !travellingPriority ) eye.x = eyeBackRef.x -speedX ; else eye.x  = eyeBackRef.x +speedX ;
      if (eyeBackRef.y < 180 && !travellingPriority ) eye.y = eyeBackRef.y -speedY ; else eye.y  = eyeBackRef.y +speedY ;
      // to stop the calcul
      if(eye.x < 2 || eye.x > 358 ) eye.x = 0 ;
      if(eye.y < 2 || eye.y > 358 ) eye.y = 0 ;  
      
      if(eye.x == 0  && eye.y == 0) {
        travellingPriority = false ;
        gotoCameraEye = false ;
        speedX = 0 ;
        speedY = 0 ;
      }
    }
  } 
  return eye ;
}


//MAIN VOID
PVector speedByAxes = new PVector() ;
//calculate new position to go at the new target camera
PVector distToTargetUpdated = new PVector () ;
float currentDistToTarget = 0 ;
PVector currentPosition = new PVector() ;
PVector absPosition = new PVector() ;

public PVector follow(PVector origin, PVector target, float speed) {
  //very weird I must inverse the value to have the good result !
  //and change again at the end of the algorithm
  target.x = -target.x ;
  target.y = -target.y ;
  target.z = -target.z ;
  
  //updated the distance in realtime
  distToTargetUpdated = PVector.sub(currentPosition, target) ;
  currentDistToTarget = PVector.dist(currentPosition, target) ;
  
  
  //calculate the speed to go to target
  PVector absValueOfDist = new PVector (abs(distToTargetUpdated.x),abs(distToTargetUpdated.y),abs(distToTargetUpdated.z));
  absValueOfDist.normalize() ;
  //speedByAxes = PVector.div(absValueOfDist, 1.0 / speed) ; 
  speedByAxes = PVector.mult(absValueOfDist, speed) ;
  // PVector rangeStop = PVector.mult(speedByAxes,5000) ;
  PVector rangeStop = new PVector(5,5,5) ; 
  //calculate the new absolute position

  //XYZ
  if ( (distToTargetUpdated.x > rangeStop.x || distToTargetUpdated.x < -rangeStop.x) && 
       (distToTargetUpdated.y > rangeStop.y || distToTargetUpdated.y < -rangeStop.y) && 
       (distToTargetUpdated.y > rangeStop.z || distToTargetUpdated.y < -rangeStop.z))  {
    if (origin.x < target.x )  absPosition.x += speedByAxes.x ;  else absPosition.x -= speedByAxes.x ;
    if (origin.y < target.y )  absPosition.y += speedByAxes.y ;  else absPosition.y -= speedByAxes.y ;
    if (origin.z < target.z )  absPosition.z += speedByAxes.z ;  else absPosition.z -= speedByAxes.z ;
  //XY  
  } else if ( (distToTargetUpdated.x > rangeStop.x || distToTargetUpdated.x < -rangeStop.x) && 
              (distToTargetUpdated.y > rangeStop.y || distToTargetUpdated.y < -rangeStop.y)) {
    if (origin.x < target.x )  absPosition.x += speedByAxes.x ;  else absPosition.x -= speedByAxes.x ;
    if (origin.y < target.y )  absPosition.y += speedByAxes.y ;  else absPosition.y -= speedByAxes.y ;
    absPosition.z += 0 ;
  //XZ
  } else if ( (distToTargetUpdated.x > rangeStop.x || distToTargetUpdated.x < -rangeStop.x) && 
              (distToTargetUpdated.y > rangeStop.z || distToTargetUpdated.y < -rangeStop.z))  {
    if (origin.x < target.x )  absPosition.x += speedByAxes.x ;  else absPosition.x -= speedByAxes.x ;
    absPosition.y += 0 ;
    if (origin.z < target.z )  absPosition.z += speedByAxes.z ;  else absPosition.z -= speedByAxes.z ;
  //YZ
  } else if ( (distToTargetUpdated.y > rangeStop.y || distToTargetUpdated.y < -rangeStop.y) && 
              (distToTargetUpdated.y > rangeStop.z || distToTargetUpdated.y < -rangeStop.z))  {
    absPosition.x += 0 ;
    if (origin.y < target.y )  absPosition.y += speedByAxes.y ;  else absPosition.y -= speedByAxes.y ;
    if (origin.z < target.z )  absPosition.z += speedByAxes.z ;  else absPosition.z -= speedByAxes.z ;
  //X
  } else if ( (distToTargetUpdated.x > rangeStop.x || distToTargetUpdated.x < -rangeStop.x)) {
    if (origin.x < target.x )  absPosition.x += speedByAxes.x ;  else absPosition.x -= speedByAxes.x ;
    absPosition.y += 0 ;
    absPosition.z += 0 ;
  //Y  
  } else if ( (distToTargetUpdated.y > rangeStop.y || distToTargetUpdated.y < -rangeStop.y))  {
    absPosition.x += 0 ;
    if (origin.y < target.y )  absPosition.y += speedByAxes.y ;  else absPosition.y -= speedByAxes.y ;
    absPosition.z += 0 ;
  //Z
  } else if ( (distToTargetUpdated.y > rangeStop.z || distToTargetUpdated.y < -rangeStop.z))  {
    absPosition.x += 0 ;
    absPosition.y += 0 ;
    if (origin.z < target.z )  absPosition.z += speedByAxes.z ;  else absPosition.z -= speedByAxes.z ;
  //IT'S DONE, NOTHING TO DO NOW
  } else {  
    absPosition.x += 0 ;
    absPosition.y += 0 ;
    absPosition.z += 0 ;
    gotoCameraPosition = false ;
  }
  
  //very weird I must inverse the value to have the good result !
  target.x = -target.x ;
  target.y = -target.y ;
  target.z = -target.z ;


  //finalize the newposition of the point
  currentPosition = PVector.add(origin, absPosition) ;
  
  return currentPosition ;
}


// END CAMERA P3D
/////////////////




























// PERSPECTIVE
//////////////
public void paralaxe() {
  float aspect = PApplet.parseFloat(width)/PApplet.parseFloat(height) ;
  float fov = 1.0f ;
  float cameraZ = (height/2.0f) / tan(fov/2.0f);
  perspective(fov, aspect, cameraZ *.02f, cameraZ*100.0f);
}


public void paralaxe(float focal, float deformation) {
  // ratio deformation
  float aspect = PApplet.parseFloat(width)/PApplet.parseFloat(height) ;
  aspect += deformation ;
  // focal
  focal = constrain(focal, 28,200) ;
  focal = map(focal,28,200,140,5) ;
  float fov = radians(focal) ;
  // this algo is from Processing example
  float cameraZ = (height/2.0f) / tan(fov/2.0f);
  
  // this algo is from Processing example
  perspective(fov, aspect, cameraZ *.02f, cameraZ*100.0f);
}

// use to stop perspective correction for the info display
public void stopParalaxe() {
  perspective() ;
}
// END PERSPECTIVE
//////////////////












// GRID CAMERA WORLD
/////////////////////
public void createGridCamera() {
  // PVector sizeGrid = new PVector(width *20, height *20, width *20) ;
  float thickness = .5f ;
  int rougeX = 0xffD31216 ;
  int vertY = 0xff2DA308 ;
  int jauneY = 0xffEFB90F ;
  int bleuGrid = 0xff596F91 ;
  PFont font = createFont("SansSerif",10) ;
  gridCamera(sizeBackgroundP3D, thickness, rougeX, vertY, jauneY, bleuGrid, font, displayInfo3D) ;

}



//repere camera
public void gridCamera(PVector size, float thickness, int colorX, int colorY,int colorZ, int colorGrid, PFont font, boolean showGrid) {
  if(showGrid)  {
    PVector newSize =  PVector.mult(size,.2f) ;

    int posTxt = 10 ;
    
    textFont(font, 10) ;
    textAlign(LEFT, BOTTOM);
    //GRID
    grid(size, thickness *.1f, colorGrid) ;

    //AXES
    strokeWeight(thickness *.1f) ;
    // X LINE
    fill(colorX) ;
    pushMatrix() ;
    text("X LINE XXX", posTxt,-posTxt) ;
    popMatrix() ;
    stroke(colorX) ; noFill() ;
    line(-newSize.x,0,0,newSize.x,0,0) ;

    // Y LINE
    fill(colorY) ;
    pushMatrix() ;
    rotateZ(radians(-90)) ;
    text("Y LINE YYY", posTxt,-posTxt) ;
    popMatrix() ;
    stroke(colorY) ; noFill() ;
    line(0,-newSize.y,0,0,newSize.y,0) ;
    
    // Z LINE
    fill(colorZ) ;
    pushMatrix() ;
    rotateY(radians(90)) ;
    text("Z LINE ZZZ", posTxt,-posTxt) ;
    popMatrix() ;
    stroke(colorZ) ; noFill() ;
    line(0,0,-newSize.z,0,0,newSize.z) ;
  }
}


public void grid(PVector s, float thickness, int colorGrid) {
  strokeWeight(thickness) ;
  noFill() ;
  stroke(colorGrid) ;
  int sizeX = (int)s.z ;
  //horizontal grid
  for ( int i = -sizeX ; i<= sizeX ; i = i+10 ) {
    if(i != 0 ) line(i,0,-sizeX,i,0,sizeX) ;
  }
}
//END CAMERA GRID WORLD
///////////////////////
//COLOR for internal use
int fond ;
int rouge, orange, jaune, vert, bleu, noir, blanc, gris  ;

public void colorSetup() {
  rouge = color(10,100,100);
  orange = color(25,100,100);
  jaune = color(50,100,100) ;
  vert = color(150,100,100);
  bleu = color(235,100,100);
  noir = color(10,100,0);
  gris = color(10,50,50);
  blanc = color(0,0,100);
}

//ROLLOVER TEXT ON BACKGROUNG CHANGE
int colorW ;
//
public int colorWrite(int colorRef, int threshold, int clear, int deep) {
  if( brightness( colorRef ) < threshold ) {
    colorW = color(clear) ;
  } else {
    colorW = color(deep) ;
  }
  return colorW ;
}







////////////////////
// Void antiBugBlack
public void antiBugFillBlack(int c) {
      if (alpha(c) == 0 ) {
    noFill() ; 
    noStroke() ; 
  } else {     
    fill (c) ; 
  }
}


// activate the fill, stroke and set the the strokeWeight
public void appearance(int colorFill, int colorStroke, float thickness) {
  //check the color
  if(alpha(colorFill) <=0)  noFill() ; else fill(colorFill) ;
  
  if(alpha(colorStroke) <=0) noStroke() ;
  else {
    stroke(colorStroke) ;
    strokeWeight(thickness) ;
  }
}
  
  
  
  
  
  
  
  
  
////////////////  
// PALETTE COLOR
//GLOBAL
//Range of each component HSB to change the color palette of image
//HUE
int [] hueStart  ;
int [] hueEnd  ;
int [] huePalette, huePaletteRef ;

//SATURATION
int [] satStart  ;
int [] satEnd  ;
int [] satPalette, satPaletteRef ;
//BRIGHTNESS
int [] brightStart  ;
int [] brightEnd  ;
int [] brightPalette, brightPaletteRef ;


//DRAW OR SETUP
//MAKE PALETTE
// random hue Palette
public void paletteRandom(PVector n, Vec4 spectrum) {
  huePalette = new int [(int)n.x] ;
  huePaletteRef = new int [(int)n.x] ;
  for (int i = 0 ; i < (int)n.x ; i++) huePalette [i] = huePaletteRef [i] = (int)random(spectrum.x) ;
  huePalette = sort(huePalette) ;
  huePaletteRef = sort(huePaletteRef) ;
  //calcul of the value range of each color on color wheel
  hueSpectrumPalette(huePalette, (int)spectrum.x) ;
  
  //saturation
  satPalette = new int [(int)n.y] ;
  satPaletteRef = new int [(int)n.y] ;
  for (int i = 0 ; i < (int)n.y ; i++) satPalette [i] = satPaletteRef [i] = (int)random(spectrum.y) ;
  satPalette = sort(satPalette) ;
  satPaletteRef = sort(satPaletteRef) ;
  //calcul of the value range of each color on color wheel
  satSpectrumPalette(satPalette, (int)spectrum.y) ;
  
  //brightness
  brightPalette = new int [(int)n.z] ;
  brightPaletteRef = new int [(int)n.z] ;
  for (int i = 0 ; i < (int)n.z ; i++) brightPalette [i] = brightPaletteRef [i] = (int)random(spectrum.z) ;
  brightPalette = sort(brightPalette) ;
  brightPaletteRef = sort(brightPaletteRef) ;
  //calcul of the value range of each color on color wheel
  brightSpectrumPalette(brightPalette, (int)spectrum.z) ;
  
}

//palette with color from you !!!!
public void paletteClassic(int [] hueList, int[] satList, int[] brightList, PVector spectrum) {
  huePalette = new int [hueList.length] ;
  huePaletteRef = new int [hueList.length] ;
  for (int i = 0 ; i < hueList.length ; i++) huePalette [i] = huePaletteRef [i] = hueList[i] ;
  huePalette = sort(huePalette) ;
  huePaletteRef = sort(huePaletteRef) ;
  //calcul of the value range of each color on color wheel
  hueSpectrumPalette(huePalette, (int)spectrum.x) ;
  
  //saturation
  satPalette = new int [satList.length] ;
  satPaletteRef = new int [satList.length] ;
  for (int i = 0 ; i < satList.length ; i++) satPalette [i] = satPaletteRef [i] = satList[i] ;
  satPalette = sort(satPalette) ;
  satPaletteRef = sort(satPaletteRef) ;
  //calcul of the value range of each color on color wheel
  satSpectrumPalette(satPalette, (int)spectrum.y) ;
  
  //brightness
  brightPalette = new int [brightList.length] ;
  brightPaletteRef = new int [brightList.length] ;
  for (int i = 0 ; i < brightList.length ; i++) brightPalette [i] = brightPaletteRef [i] = brightList [i];
  brightPalette = sort(brightPalette) ;
  brightPaletteRef = sort(brightPaletteRef) ;
  //calcul of the value range of each color on color wheel
  brightSpectrumPalette(brightPalette, (int)spectrum.z) ;
  
}





//ANNEXE VOID

//for the live modification
//HSB void
public void paletteHSB(PVector hueVar, PVector satVar, PVector brightVar) {
 paletteHue(hueVar ) ;
 paletteSat(satVar ) ;
 paletteBright(brightVar ) ;
}

//hue void
public void paletteHue(PVector hueInfo )  {
  float cycle = cycle(hueInfo.y) ;
  float factor = map(cycle, -1,1, hueInfo.z,1) ;
  for ( int i = 0 ; i < huePalette.length ; i++ ) {
     huePalette [i] = PApplet.parseInt(hueInfo.x + (factor * (huePaletteRef [i] - hueInfo.x))) ;
  }
  hueSpectrumPalette(huePalette, (int)HSBmode.x) ;
}

//saturation void
public void paletteSat(PVector satInfo )  {
  float cycle = cycle(satInfo.y) ;
  float factor = map(cycle, -1,1, satInfo.z,1) ;
  for ( int i = 0 ; i < satPalette.length ; i++ ) {
     satPalette [i] = PApplet.parseInt(satInfo.x + (factor * (satPaletteRef [i] - satInfo.x))) ;
  }
  satSpectrumPalette(satPalette, (int)HSBmode.y) ;
}

//brightness void
public void paletteBright(PVector brightInfo )  {
  float cycle = cycle(brightInfo.y) ;
  float factor = map(cycle, -1,1, brightInfo.z,1) ;
  for ( int i = 0 ; i < brightPalette.length ; i++ ) {
     brightPalette [i] = PApplet.parseInt(brightInfo.x + (factor * (brightPaletteRef [i] - brightInfo.x))) ;
  }
  brightSpectrumPalette(brightPalette, (int)HSBmode.z) ;
}






//hue Spectrum
public void hueSpectrumPalette(int [] hueP, int sizeSpectrum) {  
  if( hueP.length > 0 ) {
    int max = hueP.length  ;
    hueStart = new int [max] ;
    hueEnd = new int [max] ;
    int [] zoneLeftHue = new int [max] ;
    int [] zoneRightHue = new int [max] ;
    int [] zoneHue = new int [max] ;
  
    
    // int total = 0 ;
    if(max >1 ) {
      for ( int i = 0 ; i < max ; i++ ) {
        if ( i == 0 ) {
          zoneLeftHue[i] = (hueP[i] + sizeSpectrum - hueP[max -1 ]  ) /2  ;
          zoneRightHue[i] = (hueP[i+1] - hueP[i] ) / 2 ;
          
          if (hueP[i] < zoneLeftHue[i] ) hueStart[i] = sizeSpectrum - ( zoneLeftHue[i] - hueP[i]) ; else hueStart[i] = hueP[i] - zoneLeftHue[i] ;
          hueEnd[i] = hueP[i] + zoneRightHue[i] ;
          
          zoneHue[i] = zoneLeftHue[i] + zoneRightHue[i] ;
          
        } else if ( i > 0 && i < max-1 ) {
          zoneLeftHue[i] = (hueP[i] - hueP[i-1]  ) / 2  ;
          zoneRightHue[i] = (hueP[i+1] - hueP[i] ) / 2 ;
          
          hueStart[i] = hueP[i] - zoneLeftHue[i] ;
          hueEnd[i] = hueP[i] + zoneRightHue[i] ;
          
          zoneHue[i] = zoneLeftHue[i] + zoneRightHue[i] ;
          
        } else if ( i == max -1 ) { 
          zoneLeftHue[i] = (hueP[i] - hueP[i-1]  ) / 2  ;
          zoneRightHue[i] = (sizeSpectrum - hueP[max -1] + hueP[0] ) / 2 ;
          
          hueStart[i] = hueP[i] - zoneLeftHue[i] ;
          if( hueP[i] + zoneRightHue[i] > sizeSpectrum ) hueEnd[i] = (hueP[i] + zoneRightHue[i]) -sizeSpectrum ; else hueEnd[i] = hueP[i] + zoneRightHue[i] ;
          
          zoneHue[i] = zoneLeftHue[i] + zoneRightHue[i] ;
        }
      }
    } else {
      zoneLeftHue[0] = hueP[0]  ;
      zoneRightHue[0] = sizeSpectrum - hueP[0]  ;
      hueStart[0] = 0 ;
      hueEnd[0] = sizeSpectrum ;
    }
  }
}

//saturation Spectrum
public void satSpectrumPalette(int [] satP, int sizeSpectrum) {  
  if(satP.length > 0 ) {
    int max = satP.length  ;
    satStart = new int [max] ;
    satEnd = new int [max] ;
    int [] zoneLeftSat = new int [max] ;
    int [] zoneRightSat = new int [max] ;
    int [] zoneSat = new int [max] ;
  
    
    //int total = 0 ;
    if (max > 1 ) {
      for ( int i = 0 ; i < max ; i++ ) {
        if ( i == 0 ) {
          zoneLeftSat[i] = (satP[i] + sizeSpectrum - satP[max -1 ]  ) /2  ;
          zoneRightSat[i] = (satP[i+1] - satP[i] ) / 2 ;
          
          if (satP[i] < zoneLeftSat[i] ) satStart[i] = sizeSpectrum - ( zoneLeftSat[i] - satP[i]) ; else satStart[i] = satP[i] - zoneLeftSat[i] ;
          satEnd[i] = satP[i] + zoneRightSat[i] ;
          
          zoneSat[i] = zoneLeftSat[i] + zoneRightSat[i] ;
          
        } else if ( i > 0 && i < max-1 ) {
          zoneLeftSat[i] = (satP[i] - satP[i-1]  ) / 2  ;
          zoneRightSat[i] = (satP[i+1] - satP[i] ) / 2 ;
          
          satStart[i] = satP[i] - zoneLeftSat[i] ;
          satEnd[i] = satP[i] + zoneRightSat[i] ;
          
          zoneSat[i] = zoneLeftSat[i] + zoneRightSat[i] ;
          
        } else if ( i == max -1 ) { 
          zoneLeftSat[i] = (satP[i] - satP[i-1]  ) / 2  ;
          zoneRightSat[i] = (sizeSpectrum - satP[max -1] + satP[0] ) / 2 ;
          
          satStart[i] = satP[i] - zoneLeftSat[i] ;
          if( satP[i] + zoneRightSat[i] > sizeSpectrum ) satEnd[i] = (satP[i] + zoneRightSat[i]) -sizeSpectrum ; else satEnd[i] = satP[i] + zoneRightSat[i] ;
          
          zoneSat[i] = zoneLeftSat[i] + zoneRightSat[i] ;
        }
      }
    } else {
      zoneLeftSat[0] = satP[0]  ;
      zoneRightSat[0] = sizeSpectrum - satP[0]  ;
      satStart[0] = 0 ;
      satEnd[0] = sizeSpectrum ;
    }
  }
}




//brightness Spectrum
public void brightSpectrumPalette(int [] brightP, int sizeSpectrum) {  
  if(brightP.length > 0 ) {
    int max = brightP.length  ;
    brightStart = new int [max] ;
    brightEnd = new int [max] ;
    int [] zoneLeftBright = new int [max] ;
    int [] zoneRightBright = new int [max] ;
    int [] zoneBright = new int [max] ;
  
    
    //int total = 0 ;
    if ( max > 1 ) {
      for ( int i = 0 ; i < max ; i++ ) {
        if ( i == 0 ) {
          zoneLeftBright[i] = (brightP[i] + sizeSpectrum - brightP[max -1 ]  ) /2  ;
          zoneRightBright[i] = (brightP[i+1] - brightP[i] ) / 2 ;
          
          if (brightP[i] < zoneLeftBright[i] ) brightStart[i] = sizeSpectrum - ( zoneLeftBright[i] - brightP[i]) ; else brightStart[i] = brightP[i] - zoneLeftBright[i] ;
          brightEnd[i] = brightP[i] + zoneRightBright[i] ;
          
          zoneBright[i] = zoneLeftBright[i] + zoneRightBright[i] ;
          
        } else if ( i > 0 && i < max-1 ) {
          zoneLeftBright[i] = (brightP[i] - brightP[i-1]  ) / 2  ;
          zoneRightBright[i] = (brightP[i+1] - brightP[i] ) / 2 ;
          
          brightStart[i] = brightP[i] - zoneLeftBright[i] ;
          brightEnd[i] = brightP[i] + zoneRightBright[i] ;
          
          zoneBright[i] = zoneLeftBright[i] + zoneRightBright[i] ;
          
        } else if ( i == max -1 ) { 
          zoneLeftBright[i] = (brightP[i] - brightP[i-1]  ) / 2  ;
          zoneRightBright[i] = (sizeSpectrum - brightP[max -1] + brightP[0] ) / 2 ;
          
          brightStart[i] = brightP[i] - zoneLeftBright[i] ;
          if( brightP[i] + zoneRightBright[i] > sizeSpectrum ) brightEnd[i] = (brightP[i] + zoneRightBright[i]) -sizeSpectrum ; else brightEnd[i] = brightP[i] + zoneRightBright[i] ;
          
          zoneBright[i] = zoneLeftBright[i] + zoneRightBright[i] ;
        }
      } 
    } else {
      zoneLeftBright[0] = brightP[0]  ;
      zoneRightBright[0] = sizeSpectrum - brightP[0]  ;
      brightStart[0] = 0 ;
      brightEnd[0] = sizeSpectrum ;
    }
  }
}




//CHANGE COLOR pixel in the list of Pixel
public void changeColorOfPixel(ArrayList listMustBeChange ) {
  for( int i = 0 ; i<listMustBeChange.size() ; i++) {
    Pixel p = (Pixel) listMustBeChange.get(i) ;
    p.changeHue   (HSBmode, huePalette, hueStart, hueEnd) ;
    p.changeSat   (HSBmode, satPalette, satStart, satEnd) ; 
    p.changeBright(HSBmode, brightPalette, brightStart, brightEnd) ;
    
    p.updatePalette() ; 
  }
}



//convert color HSB to RVB
public PVector HSBtoRGB(float hue, float saturation, float brightness) {
  PVector PVectorRGB = new PVector() ;
  
  int c = color (hue, saturation, brightness);
  colorMode(RGB,255) ;
  PVectorRGB = new PVector (red(c), green(c), blue(c)) ;
  colorMode(HSB,HSBmode.r,HSBmode.r,HSBmode.b,HSBmode.a) ;
  return PVectorRGB ;
}



// camaieu
// return hue or other date in range of specific data float
public int camaieu(int max, float colorRef, int range) {
  float camaieu = 0 ;
  float whichColor = random(-range, range) ;
  camaieu = colorRef +whichColor ;
  if(camaieu < 0 ) camaieu = max +camaieu ;
  if(camaieu > max) camaieu = camaieu -max ;
 
  return (int)camaieu ;
}














  
/*
Here you findPath
LIGHT POSITION

CHECK FOLDER
*/



// LIGHT POSITION
/*
This void is necessary to diplay the info, not directly for the light because you don't use Light in the Prescene
*/
PVector lightPos = new PVector() ;
public void lightPosition() {
  if(modeP3D && lLongTouch) {
    lightPos.x = mouse[0].x ;
    lightPos.y = mouse[0].y ;
    lightPos.z -= wheel[0] ;
  }
}


//////////////
//CHECK FOLDER
PImage imgDefault ;
PImage[] img ;
ArrayList imageFiles = new ArrayList();

String textRaw ;
String[] textImport ;
ArrayList textFiles = new ArrayList();

String [] imagePath, textPath ;
boolean folderImageIsSelected = true ;
boolean folderFileTextIsSelected = true ;
// use when we open manuelly the folder
int countImageSelection, countFileTextSelection ;
int refImageNumFiles, refTextNumFiles ;



// main void
public void loadImg(int ID) {
  checkImageFolder() ;
  // whichImage is the int return from the dropdown menu
  if(whichImage[ID] > imagePath.length ) whichImage[ID] = 0 ;

  if(imagePath != null && imagePath.length > 0) {
    String image_current_path = imagePath[whichImage[ID]] ;
    if(!image_current_path.equals(image_path_ref[ID])) {
      img[ID] = loadImage(image_current_path) ;
    }
    image_path_ref[ID] = image_current_path ;
  }
}

public void loadText(int ID) {
  checkFileTextFolder() ;
  // whichText is the int return from the dropdown menu
  if(whichText[ID] > textPath.length ) whichText[ID] = 0 ;
  textImport[ID] = importText(textPath[whichText[ID]]) ;
}



// check what's happen in the selected folder
public void checkImageFolder() {
  String path = sketchPath +"/" +preferencesPath +"Images" ;
  ArrayList allFiles = listFilesRecursive(path);
  //check if something happen in the folder
  if(refImageNumFiles != allFiles.size() ) {
    folderImageIsSelected = true ;
    refImageNumFiles = allFiles.size() ;
  }
  // If something happen, algorithm work 
  if(folderImageIsSelected) {
    countImageSelection++ ;
    imageFiles.clear() ;
    String fileName = "";
    for (int i = 0; i < allFiles.size(); i++) {
      File f = (File) allFiles.get(i);   
      fileName = f.getName(); 
  
      // Add it to the list if it's not a directory
      if (f.isDirectory() == false) {
        String lastThree = fileName.substring(fileName.length()-3, fileName.length());
        if (lastThree.equals("PNG") || lastThree.equals("png") || lastThree.equals("JPG") || lastThree.equals("jpg") || lastThree.equals("GIF") || lastThree.equals("gif")) {
          imageFiles.add(f);
        }
      }
    }
    // edit the image path
    imagePath = new String[imageFiles.size()] ;
    for (int i = 0; i < imageFiles.size(); i++) {
      File f = (File) imageFiles.get(i);
      imagePath[i] = f.getAbsolutePath() ;
    }
    
    // to don't loop with this void
    folderImageIsSelected = false ;
  }
}

public void checkFileTextFolder() {
  String path = sketchPath +"/" +preferencesPath +"Karaoke" ;
  ArrayList allFiles = listFilesRecursive(path);
  
  //check if something happen in the folder
  if(refTextNumFiles != allFiles.size() ) {
    folderFileTextIsSelected = true ;
    refTextNumFiles = allFiles.size() ; 
  }
  // If something happen, algorithm work 
  if(folderFileTextIsSelected) {
    countFileTextSelection++ ;
    textFiles.clear() ;
    String fileName = "";
    for (int i = 0; i < allFiles.size(); i++) {
      File f = (File) allFiles.get(i);   
      fileName = f.getName(); 
  
      // Add it to the list if it's not a directory
      if (f.isDirectory() == false) {
        String lastThree = fileName.substring(fileName.length()-3, fileName.length());
        if (lastThree.equals("TXT") || lastThree.equals("txt")) {
          textFiles.add(f);
        }
      }
    }
    // edit the path file
    textPath = new String[textFiles.size()] ;
    for (int i = 0; i < textFiles.size(); i++) {
      File f = (File) textFiles.get(i); 
      textPath[i] = f.getAbsolutePath() ;
    }
    
    // to don't loop with this void
    folderFileTextIsSelected = false ;
  }
}
// end main void




// This function returns all the files in a directory as an array of Strings  
public String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } 
  else {
    // If it's not a directory
    return null;
  }
}

// This function returns all the files in a directory as an array of File objects
// This is useful if you want more info about the file
public File[] listFiles(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    File[] files = file.listFiles();
    return files;
  } 
  else {
    // If it's not a directory
    return null;
  }
}

// Function to get a list ofall files in a directory and all subdirectories
public ArrayList listFilesRecursive(String dir) {
  ArrayList fileList = new ArrayList(); 
  recurseDir(fileList, dir);
  return fileList;
}

// Recursive function to traverse subdirectories
public void recurseDir(ArrayList a, String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    // If you want to include directories in the list
    a.add(file);  
    File[] subfiles = file.listFiles();
    for (int i = 0; i < subfiles.length; i++) {
      // Call this function on all files in this directory
      recurseDir(a, subfiles[i].getAbsolutePath());
    }
  } 
  else {
    a.add(file);
  }
}
//END CHECK FOLDER
/////////////////










// NEW VOID TEXT
String importRaw [] ;



public String importText(String path) {
  importRaw = loadStrings(path) ;
  return join(importRaw, "") ;
}


// info num Chapters
public int numChapters(String txt) {
  String chapters [] = split(txt, "*") ;
  return chapters.length ;
}

// info num Sentences
public int numMaxSentencesByChapter(String txt) {
  String chapters [] = split(txt, "*") ;
  // find the quantity of chapter and sentences by chapter to create the final double array String
  int numChapter = chapters.length ;
  int maxSentencesByChapter = 0 ;  
  for ( int i = 0 ; i < numChapter ; i++) {
    String sentences [] = split(chapters[i], "/") ;
    if ( sentences.length > maxSentencesByChapter ) maxSentencesByChapter = sentences.length ; 
  }
  
  return maxSentencesByChapter ;
}



public String whichSentence(String txt, int whichChapter, int whichSentence) {
  String chapters [] = split(txt, "*") ;
  String  [][] repartition ;
  
  // find the quantity of chapter and sentences by chapter to create the final double array String
  int numChapter = chapters.length ;
  int maxSentencesByChapter = 0 ;  
  for ( int i = 0 ; i < numChapter ; i++) {
    String sentences [] = split(chapters[i], "/") ;
    if ( sentences.length > maxSentencesByChapter ) maxSentencesByChapter = sentences.length ; 
  }
  //create the final double array string
  repartition = new String [numChapter][maxSentencesByChapter] ;
  //put the sentences in the double String by chapter
  for ( int i = 0 ; i < numChapter ; i++) {
    String sentences [] = split(chapters[i], "/") ;
    for ( int j = 0 ; j <  sentences.length ; j++) {
      repartition [i][j] = sentences[j] ;
    }
  }
  //security
  if(whichChapter > chapters.length ) whichChapter = 0 ;
  if(whichSentence > maxSentencesByChapter ) whichSentence = 0 ;
  
  return repartition[whichChapter][whichSentence] ;
}

// END TEXT
//////////















//////////////
//DISPLAY INFO
boolean displayInfo, displayInfo3D ;
int posInfo = 2 ;


public void info() {
  if (displayInfo) {
    //perspective() ;
    displayInfoScene() ;
    displayInfoObject() ;
  }
  if (modeP3D && displayInfo3D) displayInfo3D() ;
}

public void displayInfoScene() {
  noStroke() ;
  fill(0,100,0, 50) ;
  rectMode(CORNER) ;
  textAlign(LEFT) ;
  rect(0,-5,width, 15*posInfo) ;
  posInfo = 2 ;
  fill(0,0,100) ;
  textFont(SansSerif10, 10) ;
  //INFO SIZE and RENDERER
  String displayModeInfo ;
  if (displayMode.equals("Classic") ) displayModeInfo = ("classic") ; else displayModeInfo = displayMode ;
  String infoRendering =("");
  if(fullRendering) infoRendering = ("Full rendering") ; else infoRendering = ("Preview rendering") ;
  text("Size " + width + "x" + height + " / "  + infoRendering + " / Render mode " + displayModeInfo + " / FrameRate " + (int)frameRate, 15,15) ;
  //INFO MOUSE and PEN
  text("Mouse " + mouseX + " / " + mouseY + " molette " + wheel[0] + " pen orientation " + (int)deg360(pen[0]) +"\u00b0   stylet pressur " + PApplet.parseInt(pen[0].z *10),15, 15 *posInfo ) ;  
  posInfo += 1 ;
  // LIGHT INFO
  text("Light Position " + lightPos.x + " / " + lightPos.y + " / "+ lightPos.z,15, 15 *posInfo  ) ;
  posInfo += 1 ;
  //INFO SOUND
  if (getTimeTrack() > 1 ) text("the track play until " +getTimeTrack() + "  Tempo " + getTempoRef() , 15,15 *(posInfo)) ; else text("no track detected ", 15, 15 *(posInfo)) ;
  posInfo += 1 ;
  text("right " + right_volume_info, 15, 15 *(posInfo)) ;  
  text("left "  + left_volume_info,  50, 15 *(posInfo)) ;
  posInfo += 1 ;
}


int posInfoObj = 1 ;

public void displayInfoObject() {
  noStroke() ;
  fill(0,100,0, 50) ;
  rectMode(CORNER) ;
  textAlign(LEFT) ;
  float heightBox = 15*posInfoObj ;
  rect(0, height -heightBox,width, heightBox) ;
  fill(0,0,100) ;
  textFont(SansSerif10, 10) ;
  
  posInfoObj = 1 ;
  // for (Romanesco objR : RomanescoList)
  for(int i = 0 ; i < numObj ; i++) {
    
    if(show_object[i]) {
      posInfoObj += 1 ;
      String position = ("x:" +(int)posObjX[i] + " y:" + (int)posObjY[i]+ " z:" + (int)posObjZ[i]) ;
      text(objectName[i] + " - Coord " + position + " - " + objectInfo[objectID[i]], 10, height -(15 *(posInfoObj -1))) ;
    }
  }
}



//INFO 3D
public void displayInfo3D() {
   String posCam = ( PApplet.parseInt(-1 *sceneCamera.x ) + " / " + PApplet.parseInt(sceneCamera.y) + " / " +  PApplet.parseInt(sceneCamera.z -height/2)) ;
   String eyeDirectionCam = ( PApplet.parseInt(eyeCamera.x) + " / " + PApplet.parseInt(eyeCamera.y) ) ;
  fill(0,0,100) ; 
  textFont(SansSerif10, 10) ;
  textAlign(RIGHT) ;
  text("Position " +posCam, width/2 -30 , height/2 -30) ;
  text("Direction " +eyeDirectionCam, width/2 -30 , height/2 -15) ;
}



//////
//P3D

//REPERE 3D
public void repere(int size, PVector pos, String name) {
  pushMatrix() ;
  translate(pos.x +20 , pos.y -20, pos.z) ;
  fill(blanc) ;
  text(name, 0,0) ;
  popMatrix() ;
  line(-size +pos.x,pos.y, pos.z,size +pos.x, pos.y, pos.z) ;
  line(pos.x,-size +pos.y, pos.z, pos.x,size +pos.y, pos.z) ;
  line(pos.x, pos.y,-size +pos.z, pos.x, pos.y,size +pos.z) ;
}
//repere cross
public void repere(int size) {
  line(-size,0,0,size,0,0) ;
  line(0,-size,0,0,size,0) ;
  line(0,0,-size,0,0,size) ;
}



//END P3D
/////////
////////////////
//END DISPLAY INFO





//DRAWING
//CROSS
public void crossPoint2D(PVector pos, int colorCross, int e, int size) {
  stroke(colorCross) ;
  strokeWeight(e) ;
  
  line(pos.x, pos.y -size, pos.x, pos.y +size) ;
  line(pos.x +size, pos.y, pos.x -size, pos.y) ;
}


// other cross
public void crossPoint2D(PVector pos, PVector size, int colorCross, float e ) {
  if (e <0.1f) e = 0.1f ;
  stroke(colorCross) ;
  strokeWeight(e) ;
  //horizontal
  line(pos.x, pos.y -size.x, pos.x, pos.y +size.x) ;
  //vertical
  line(pos.x +size.y, pos.y, pos.x -size.y, pos.y) ;
}
public void crossPoint3D(PVector pos, PVector size, int colorCross, float e ) {
  if (e <0.1f) e = 0.1f ;
  stroke(colorCross) ;
  strokeWeight(e) ;
  //horizontal
  line(pos.x, pos.y -size.x,0, pos.x, pos.y +size.x,0) ;
  //vertical
  line(pos.x +size.y, pos.y,0, pos.x -size.y, pos.y,0) ;
  //depth
  line(pos.x, pos.y,size.z, pos.x, pos.y,-size.z) ;
}
//


//END DRAWING
////////////
















// MISC
///////


//curtain
public void curtain() {
  if(!onOffCurtain) {
    rectMode(CORNER) ;
    fill (0) ; 
    noStroke() ;
    rect(-1,-1, width+2, height+2);
  }
}
//end curtain



// OS mac DETECTION
boolean mavericks = false ;
public void OSMavericksCheck() {
  // check OSX version
  String OS = System.getProperty("os.version") ;
  OS  = OS.replace(".","");
  int OSversion = Integer.parseInt(OS);
  if(OSversion >= 1090  ) mavericks = true ; else mavericks = false ;
}


// END MISC
///////////








//////////
//KEYBOARD

//short Touch
boolean aTouch, bTouch, cTouch, dTouch, eTouch, fTouch, gTouch, hTouch, iTouch, jTouch, kTouch, lTouch, mTouch, nTouch, oTouch, pTouch, qTouch, rTouch, sTouch, tTouch, uTouch, vTouch, wTouch, xTouch, yTouch, zTouch,
        leftTouch, rightTouch, upTouch, downTouch, 
        touch0, touch1, touch2, touch3, touch4, touch5, touch6, touch7, touch8, touch9, 
        backspaceTouch, deleteTouch, enterTouch, returnTouch, shiftTouch, altTouch, escTouch, ctrlTouch, cmdTouch ;
//long touch
boolean spaceTouch, cLongTouch, lLongTouch, nLongTouch, vLongTouch ;  

//END KEYBOARD
//////////////






//DETECTION
//CIRLCLE
public boolean insideCircle (PVector pos, int diam) {
  if (dist(pos.x, pos.y, mouseX, mouseY) < diam) return true  ; else return false ;
}

//RECTANGLE
public boolean insideRect(PVector pos, PVector size) { 
    if(mouse[0].x > pos.x && mouse[0].x < pos.x + size.x && mouse[0].y >  pos.y && mouse[0].y < pos.y + size.y) return true ; else return false ;
}
//DETECTION





////////
//TIME
public int minClock() {
  return hour()*60 + minute() ;
}


//timer
int chrnmtr, chronometer, newChronometer ;

public int timer(float tempo) {
  int translateTempo = PApplet.parseInt(1000 *tempo) ;
  newChronometer = millis()%translateTempo ;
  if ( chronometer > newChronometer ) {
    chrnmtr += 1  ;
  }
  chronometer = newChronometer ;
  return chrnmtr ;
}

//make cycle from speed
float totalCycle ;
public float cycle(float add) {
  totalCycle += add ; // choice here the speed of the cycle
  return sin(totalCycle) ;
}


//END TIME
///////////



// EASING
////////
PVector targetIN = new PVector () ;
//Pen
PVector easingIN = new PVector () ;
//
public PVector easing(PVector targetOUT, float effectOUT) {
  targetIN.x = targetOUT.x;
  float dx = targetIN.x - easingIN.x;
  if(abs(dx) > 1) {
    easingIN.x += dx * effectOUT;
  }
  
  targetIN.y = targetOUT.y;
  float dy = targetIN.y - easingIN.y;
  if(abs(dy) > 1) {
    easingIN.y += dy * effectOUT;
  }
  return easingIN ;
}
//
public void resetEasing(PVector targetOUT) {
  easingIN.x = targetOUT.x ; easingIN.y = targetOUT.y ;
}
//end easing




//////////////////
//tracking with pad
public void nextPreviousKeypressed() {
    //tracking
  nextPrevious = true ;
}
//
public int tracking(int t, int n) {
  if (nextPrevious) {
    if (downTouch && t < n-1 ) {
      trackerUpdate = +1 ;
    } else if (upTouch  && t > 0 ) {
      trackerUpdate = -1 ;
    } 
  }
  if (nextPrevious) {
    if ( leftTouch  && t > 0 ) {
      trackerUpdate = -1 ;
    } else if ( rightTouch && t < n-1 ) {
      trackerUpdate = +1 ;
    }
  }
  nextPrevious = false ;
  return trackerUpdate ;
}
//END nextPrevious









///////////////////////////////////////////
//TRANSLATOR INT to String, FLOAT to STRING
//truncate
public float truncate( float x ) {
    return round( x * 100.0f ) / 100.0f;
}
//Int to String with array list
/*
@ return String
*/
public String joinIntToString(int []data) {
  String intString ;
  String [] dataString = new String [data.length] ;
  for ( int i = 0 ; i < data.length ; i++) dataString[i] = Integer.toString(data[i]) ;
  intString = join(dataString,"/") ;
  
  return intString ;
}

//float to String with array list
public String joinFloatToString(float []data) {
  String floatString ;
  String [] dataString = new String [data.length] ;
  //for ( int i = 0 ; i < data.length ; i++) dataString[i] = Float.toString(data[i]) ;
  //we must use just one decimal after coma, to dodge the outBoundIndex blablabla
  for ( int i = 0 ; i < data.length ; i++) dataString[i] = String.format("%.1f" ,data[i]) ;
  floatString = join(dataString,"/") ;
  
  return floatString ;
}

//Translater to String
public String FloatToString(float data) {
  String newData ;
  newData = String.format("%.1f", data ) ;
  return newData ;
}
//
public String FloatToStringWithThree(float data) {
  String newData ;
  newData = String.format("%.3f", data ) ;
  return newData ;
}
//
public String IntToString(int data) {
  String newData ;
  newData = Integer.toString(data ) ;
  return newData ;
}
//END TRANSLATOR
///////////////
//LIGHT and SHADER
//////////////////


// SHADER PIX LIGHT
///////////////////
PShader pixShader;

public void shaderSetup() {
  String path = (preferencesPath +"shader/") ;
  pixShader = loadShader(path+"pixFrag.glsl", path+"pixVert.glsl");
}

public void callShader() {
  /* in the draw */
  shader(pixShader);
}



// LIGHT ROMANESCO
//////////////////
public void lightSetup() {
  if(modeP3D) {
    shaderSetup() ;
    float min =.001f ;
    float max = 0.3f ;
    speedColorLight = new PVector(random(min,max),random(min,max),random(min,max)) ;
  }
}
// END SETUP
////////////



//DRAW


PVector speedColorLight = new PVector(0,0,0) ;
// ambient
Vec4 colourAmbient = Vec4() ;
Vec4 colourAmbientRef = Vec4() ;
// directional light 1
Vec4 colorLightDir_1 = Vec4(0,100,100,100);
Vec3 dirLightDir_1 = Vec3(0,0,1);
Vec4 colorLightDir_1_ref = Vec4();
Vec3 dirLightDir_1_ref = Vec3();

// directional light 2
Vec4 colorLightDir_2 = Vec4(0,100,100,100);
Vec3 dirLightDir_2 = Vec3(0,0,1);
Vec4 colorLightDir_2_ref = Vec4();
Vec3 dirLightDir_2_ref = Vec3();


/*
boolean lightOneMove, lightTwoMove, lightAmbientMove ;
boolean AmbientOnOff  ;
boolean directionalLightOneOnOff, directionalLightTwoOnOff  ;
*/


public void lightDraw() {
  if(modeP3D) {
    callShader() ;
    
    // ambient light
    // if(eLightAmbient == 1 ) AmbientOnOff = true ; else AmbientOnOff = false ;
    if(onOffLightAmbient){ 
      //if(eLightAmbientAction == 1 ) lightAmbientMove = true ; else lightAmbientMove = false ;
      Vec4 newRef = Vec4(map(valueSlider[0][12],0,MAX_VALUE_SLIDER,0,HSBmode.x), map(valueSlider[0][13],0,MAX_VALUE_SLIDER,0,HSBmode.y), map(valueSlider[0][14],0,MAX_VALUE_SLIDER,0,HSBmode.z),HSBmode.w) ;
      if(!compare(newRef, colourAmbientRef)) colourAmbient = newRef.copy() ;
      colourAmbientRef = newRef.copy() ;
      ambientLightPix(colourAmbient) ;
    }
    
    // Directional light one
   // if(eLightOne == 1 ) directionalLightOneOnOff = true ; else directionalLightOneOnOff = false ;
   if(onOffDirLightOne) {
     // direction
      // if(eLightOneAction == 1 ) lightOneMove = true ; else lightOneMove = false ;
      if(onOffDirLightOneAction) {
        Vec3 newRefDir = Vec3(map(lightPos.x,0,width, -1,1),map(lightPos.y,0,height, -1,1),map(lightPos.z,-750,750, -1,1)) ;
        if(!compare(newRefDir, dirLightDir_1_ref)) dirLightDir_1 = newRefDir.copy() ;
        dirLightDir_1_ref = newRefDir.copy() ;
      }
      // color
      Vec4 newRefColor = Vec4(map(valueSlider[0][6], 0, MAX_VALUE_SLIDER, 0, HSBmode.x), map(valueSlider[0][7],0, MAX_VALUE_SLIDER, 0, HSBmode.y), map(valueSlider[0][8], 0, MAX_VALUE_SLIDER, 0, HSBmode.z),HSBmode.w) ;
      if(!compare(newRefColor, colorLightDir_1_ref)) colorLightDir_1 = newRefColor.copy() ;
      colorLightDir_1_ref = newRefColor.copy() ;
      // rendering
      directionalLightPix(colorLightDir_1, dirLightDir_1) ;
    }
    
    // Directional light two
   //  if(eLightTwo == 1 ) directionalLightTwoOnOff = true ; else directionalLightTwoOnOff = false ;
   if(onOffDirLightTwo) {
     // direction
      // if(eLightTwoAction == 1 ) lightTwoMove = true ; else lightTwoMove = false ;
      if(onOffDirLightTwoAction) {
        Vec3 newRefDir = Vec3(map(lightPos.x,0,width, 1,-1),map(lightPos.y,0,height, 1,-1),map(lightPos.z,-750,750, 1,-1)) ;
        if(!compare(newRefDir, dirLightDir_2_ref)) dirLightDir_2 = newRefDir.copy() ;
        dirLightDir_2_ref = newRefDir.copy() ;
      }
      // color
      Vec4 newRefColor = Vec4(map(valueSlider[0][9], 0, MAX_VALUE_SLIDER, 0, HSBmode.x), map(valueSlider[0][10],0, MAX_VALUE_SLIDER, 0, HSBmode.y), map(valueSlider[0][11], 0, MAX_VALUE_SLIDER, 0, HSBmode.z),HSBmode.w) ;
      if(!compare(newRefColor, colorLightDir_2_ref)) colorLightDir_2 = newRefColor.copy() ;
      colorLightDir_2_ref = newRefColor.copy() ;
      //colorLightDir_2 = new Vec4 (map(valueSlider[0][9], 0, MAX_VALUE_SLIDER, 0, HSBmode.x), map(valueSlider[0][10],0, MAX_VALUE_SLIDER, 0, HSBmode.y), map(valueSlider[0][11], 0, MAX_VALUE_SLIDER, 0, HSBmode.z),HSBmode.w) ;
      // rendering
      directionalLightPix(colorLightDir_2, dirLightDir_2) ;
    }
    
  }
}
// END LIGHT ROMANESCO
//////////////////////























/// AMBIENT LIGHT
/////////////////
public void ambientLightPix(Vec4 rgba) {
  float alphaNormal = map(rgba.a,0,g.colorModeA,0,1) ;
  /**
   check the color mode of your skecth, if this one is on RGB, you must apply the alpha on RGB component, else in HSB you must apply only on SB components 
   */
  if(g.colorMode == 1 ) {
    rgba.r *= alphaNormal ;
    rgba.g *= alphaNormal ;
    rgba.b *= alphaNormal; 
  } else {
    rgba.g *= alphaNormal ; 
    rgba.b *= alphaNormal  ;
  }
  ambientLight(rgba.r, rgba.g, rgba.b);
}
public void ambientLightPix(Vec4 rgba, Vec3 pos) {
      float alphaNormal = map(rgba.a,0,g.colorModeA,0,1) ;
  /** 
  check the color mode of your skecth, if this one is on RGB, you must apply the alpha on RGB component, else in HSB you must apply only on SB components 
  */
  if(g.colorMode == 1 ) {
    rgba.r *= alphaNormal ;
    rgba.g *= alphaNormal ;
    rgba.b *= alphaNormal; 
  } else {
    rgba.g *= alphaNormal ; 
    rgba.b *= alphaNormal  ;
  }
  ambientLight(rgba.r, rgba.g, rgba.b, pos.x, pos.y, pos.z);
}
// END AMBIENT LIGHT
////////////////////


//DIRECTIONAL LIGHT
///////////////////
/**
open a list of lights with a max of height lights
@param Vec4 [] colour RGBa float component value 0-255
@param Vec4 [] dir xyz float component value -1 to 1
*/
// specific void
///////////////
public void directionalLightPix(Vec4 rgba, Vec3 dir) {
    float alphaNormal = map(rgba.a,0,g.colorModeA,0,1) ;
  /**
  check the color mode of your skecth, if this one is on RGB, you must apply the alpha on RGB component, else in HSB you must apply only on SB components 
   */
  if(g.colorMode == 1 ) {
    rgba.r *= alphaNormal ;
    rgba.g *= alphaNormal ;
    rgba.b *= alphaNormal; 
  } else {
    rgba.g *= alphaNormal ; 
    rgba.b *= alphaNormal  ;
  }
  directionalLight(rgba.r, rgba.g, rgba.b, dir.x, dir.y, dir.z);
  
}
// END DIRECTIONAL LIGHT
////////////////////////





// POINT LIGTH
//////////////
public void pointLightList() {
  float r = 255 *abs(cos(frameCount *.01f)) ;
  float g = 255 *abs(cos(frameCount *.002f)) ;
  float b = 255 *abs(cos(frameCount *.003f)) ;
  float a = 255 ;
  Vec4 colorLightOne = new Vec4(r, g, b, a) ;
  Vec4 colorLightTwo = new Vec4(g, b,  r, a) ;
    float x = mouseX ;
  float y = mouseY ;
  float z = 200 ;
  Vec3 posLightOne = new Vec3(x, y, z) ;
  x = width -mouseX ;
  y = height -mouseY ;
  Vec3 posLightTwo = new Vec3(x, y, z) ;
  pointLightPix(colorLightOne, posLightOne);
  pointLightPix(colorLightTwo, posLightTwo);
}


public void pointLightPix(Vec4 colourPlusAlpha, Vec3 pos) {
   float alpha = map(colourPlusAlpha.a,0,255,0,1) ;
   pointLight(colourPlusAlpha.r *alpha, colourPlusAlpha.g *alpha, colourPlusAlpha.b *alpha, pos.x, pos.y, pos.z) ;
}








//SPOT LIGHT
/////////////
public void spotLightPixList() {
  float r = 255 *abs(cos(frameCount *.002f)) ;
  float g = 255 *abs(cos(frameCount *.01f)) ;
  float b = 255 *abs(cos(frameCount *.004f)) ;
  float a = 255 ;
  Vec4 colorLightOne = new Vec4(r, g, b, a) ;
  Vec4 colorLightTwo = new Vec4(g, b,  r, a) ;
  Vec4 colorLightThree = new Vec4(b, r,  g, a) ;
  
  float x = mouseX ;
  float y = mouseY ;
  float z = 200 ;
  Vec3 posLightOne = new Vec3(x, y, z) ;
  x = width -mouseX ;
  y = height -mouseY ;
  Vec3 posLightTwo = new Vec3(x, y, z) ;
  x = width *sin(frameCount *.002f) ;
  y = height *sin(frameCount *.01f) ;
  Vec3 posLightThree = new Vec3(x, y, z) ;
  
  float dirX = 0 ;
  float dirY = 0 ;
  float dirZ = -1 ;
  Vec3 dirLight = new Vec3(dirX, dirY, dirZ) ;
  
  /*
  float ratio = 1.2 +(5 *abs(sin(frameCount *.003))) ;
  float angle = TAU/ratio ; // good from PI/2 to
  float concentration = 1+ 100 *abs(sin(frameCount *.004)); // try 1 > 1000
  */
   float angle = TAU /2 ;
  float concentration = 100 ;

  
  spotLightPix(colorLightOne, posLightOne, dirLight, angle, concentration) ;
  spotLightPix(colorLightTwo, posLightTwo, dirLight, angle, concentration) ;
  spotLightPix(colorLightThree, posLightThree, dirLight, angle, concentration) ;
}

public void spotLightPix(Vec4 rgba, Vec3 pos, Vec3 dir, float angle, float concentration) {
   float alpha = map(rgba.a,0,255,0,1) ;
   spotLight(rgba.r *alpha, rgba.g *alpha, rgba.b *alpha, pos.x, pos.y, pos.z, dir.x, dir.y, dir.z, angle, concentration) ;
}
// END SHADER PIX LIGTH
//////////////////////

// END LIGHT
////////////







// GLOBAL SHADER
////////////////
public void  shaderDraw() {
  // Color value fro the global vertex
  ////////////////////////////////////
  Vec4 RGBa = new Vec4(1, 1, 1, .5f) ; // it's OPENGL data between 0 to 1 
    // the range is between -1 to 1, you can go beyond but take care at your life !
  PVector RGB = new PVector(RGBa.r, RGBa.g, RGBa.b);

  pixShader.set("colorVertex", RGB);
  pixShader.set("alphaVertex", RGBa.a);
  // pixlightShader.set("contrast", 1.);
  
  
  // vertex position
  //////////////////
  // float canvasZ = cos(frameCount *.01) ;
  PVector canvasXYZ = new PVector (1,1,1) ;
  
  pixShader.set("canvas", canvasXYZ);
  pixShader.set("zoom", 1.f);
}

// GLOBAL SHADER
////////////////
// Z_LOAD
public void loadDataObject(String path) {
	JSONArray load = new JSONArray() ;
	load = loadJSONArray(path);
	// init counter
	int startPosJSONDataWorld = 0 ;
	int startPosJSONDataCam = 1 ;
	int startPosJSONDataObj = 0;
    
    // PART ONE
	JSONObject dataWorld = load.getJSONObject(startPosJSONDataWorld);
	onOffBackground = dataWorld.getBoolean("on/off") ;


	colorBackground.r = dataWorld.getFloat("hue background") ;
	colorBackground.g = dataWorld.getFloat("saturation background");
	colorBackground.b = dataWorld.getFloat("brightness background") ;
	colorBackground.a = dataWorld.getFloat("refresh background") ;
	colorBackgroundRef = colorBackground.copy() ;

	// color ambient light
	colourAmbient.r = dataWorld.getFloat("hue ambient") ;
	colourAmbient.g = dataWorld.getFloat("saturation ambient") ;
	colourAmbient.b = dataWorld.getFloat("brightness ambient") ;
	colourAmbient.a = dataWorld.getFloat("alpha ambient") ;
	// pos ambient light
	/**
	Not use at this time
	dataWorld.setFloat("pos x ambient", value) ;
	dataWorld.setFloat("pos y ambient", value) ;
	dataWorld.setFloat("pos z ambient", value) ;
	*/
	// color light one
	colorLightDir_1.r = dataWorld.getFloat("hue light 1") ;
	colorLightDir_1.g = dataWorld.getFloat("saturation light 1") ;
	colorLightDir_1.b = dataWorld.getFloat("brightness light 1") ;
	colorLightDir_1.a = dataWorld.getFloat("alpha light 1") ;
	// pos light one
	dirLightDir_1.x = dataWorld.getFloat("pos x light 1") ;
	dirLightDir_1.y = dataWorld.getFloat("pos y light 1") ;
	dirLightDir_1.z = dataWorld.getFloat("pos z light 1") ;
	// color light two
	colorLightDir_2.r = dataWorld.getFloat("hue light 2") ;
	colorLightDir_2.g = dataWorld.getFloat("saturation light 2") ;
	colorLightDir_2.b = dataWorld.getFloat("brightness light 2") ;
	colorLightDir_2.a = dataWorld.getFloat("alpha light 2") ;
	// pos light two
	dirLightDir_2.x = dataWorld.getFloat("pos x light 2") ;
	dirLightDir_2.y = dataWorld.getFloat("pos y light 2") ;
	dirLightDir_2.z = dataWorld.getFloat("pos z light 2") ;
	// sound
	/**
	// I don't know, if it's pertinent to save this data ?
	dataWorld.setFloat("sound left", value) ;
	dataWorld.setFloat("sound right", value) ;
	dataWorld.setBoolean("beat", value) ;
	dataWorld.setBoolean("kick", value) ;
	dataWorld.setBoolean("snare", value) ;
	dataWorld.setBoolean("hat", value) ;
	*/





	// PART TWO
	int numCamera = 1 ;
	for (int i = startPosJSONDataCam ; i < startPosJSONDataCam + numCamera ; i++ ) {
		JSONObject dataCam = load.getJSONObject(i);
		// lenz
		focal = dataCam.getFloat("focal") ;
		deformation = dataCam.getFloat("deformation") ;
        // camera orientation
		dirCamX = dataCam.getFloat("eye x") ;
		dirCamY = dataCam.getFloat("eye y") ;
		dirCamZ = dataCam.getFloat("eye z") ;
		centerCamX = dataCam.getFloat("pos x") ;
		centerCamY = dataCam.getFloat("pos y") ;
		centerCamY = dataCam.getFloat("pos z") ;
		upX = dataCam.getFloat("upX");
		/**
		// not use in this time, maybe for the future
		upY = dataCam.getFloat("upY"); ;
		upZ = dataCam.getFloat("upZ"); ;
		*/
        // curent position
		finalSceneCamera.x = dataCam.getFloat("scene x") *width ;
		finalSceneCamera.y = dataCam.getFloat("scene y") *width ;
		finalSceneCamera.z = dataCam.getFloat("scene z") *width ;
		finalEyeCamera.x = dataCam.getFloat("longitude") ;
		finalEyeCamera.y = dataCam.getFloat("latitude") ;
	}
    

    // PART THREE
	for (int i = 2 ; i < load.size() ;i++) {
		JSONObject dataObj = load.getJSONObject(i) ;
		int ID = dataObj.getInt("ID obj") ;
		/**
		int fontRefID = dataObj.getInt("which font") ;
		whichFont[ID] = 
		*/
		whichImage[ID] = dataObj.getInt("which picture") ;
		whichText[ID] = dataObj.getInt("which text") ;
        // display mode
		mode[ID] = dataObj.getInt("Mode obj") ;
		
        // slider fill
        float h_fill = dataObj.getFloat("hue fill") ;
        float s_fill = dataObj.getFloat("saturation fill") ;
        float b_fill = dataObj.getFloat("brightness fill") ;
        float a_fill = dataObj.getFloat("alpha fill") ;
		// slider stroke
		float h_stroke = dataObj.getFloat("hue stroke") ;
        float s_stroke = dataObj.getFloat("saturation stroke") ;
        float b_stroke = dataObj.getFloat("brightness stroke") ;
        float a_stroke = dataObj.getFloat("alpha stroke") ;

        if(fullRendering) {
        	fillObj[ID] = color(h_fill, s_fill, b_fill, a_fill) ;
			strokeObj[ID] = color(h_stroke, s_stroke, b_stroke, a_stroke) ;
			thicknessObj[ID] = dataObj.getFloat("thickness") *height ;
		} else {
			// preview display
			fillObj[ID] = COLOR_FILL_OBJ_PREVIEW ;
			strokeObj[ID] =  COLOR_STROKE_OBJ_PREVIEW ;
			thicknessObj[ID] = THICKNESS_OBJ_PREVIEW ;
	    }

		sizeXObj[ID] = dataObj.getFloat("width") *width ;
		sizeYObj[ID] = dataObj.getFloat("height") *width ;
		sizeZObj[ID] = dataObj.getFloat("depth") *width ;
		canvasXObj[ID] = dataObj.getFloat("canvas x") *width ;
		canvasYObj[ID] = dataObj.getFloat("canvas y") *width ;
		canvasZObj[ID] = dataObj.getFloat("canvas z") *width ;
		familyObj[ID] = dataObj.getFloat("family") ;
		quantityObj[ID] = dataObj.getFloat("quantity") ;
		lifeObj[ID] = dataObj.getFloat("life") ;

		speedObj[ID] = dataObj.getFloat("speed") ;
		directionObj[ID] = dataObj.getFloat("direction") ;
		angleObj[ID] = dataObj.getFloat("angle") ;
		amplitudeObj[ID] = dataObj.getFloat("amplitude") ;
		attractionObj[ID] = dataObj.getFloat("attraction") ;
		repulsionObj[ID] = dataObj.getFloat("repulsion") ;
		alignmentObj[ID] = dataObj.getFloat("aligmnent") ;
		influenceObj[ID] = dataObj.getFloat("influence") ;
		analyzeObj[ID] = dataObj.getFloat("analyze") ;

		posObjX[ID]	= dataObj.getFloat("pos x obj") *width ;
		posObjY[ID]	= dataObj.getFloat("pos y obj") *width ;
		posObjZ[ID]	= dataObj.getFloat("pos z obj") *width ;

		dirObjX[ID]	= dataObj.getFloat("longitude obj") ;
		dirObjY[ID]	= dataObj.getFloat("latitude obj") ;
	}

}
// CONSTANT NUMBER
final float PHI = (1 + sqrt(5))/2; //a number of polys use the golden ratio...
final float ROOT2 = sqrt(2); //...and the square root of two, the famous first irrationnal number by Pythagore
final float EULER = 2.718281828459045235360287471352f; // Constant d'Euler



// ALGEBRE
//roots dimensions n
public float roots(float valueToRoots, int n) {
  return pow(valueToRoots, 1.0f/n) ;
}





//GEOMETRY
//////////

// EQUATION CIRLCE
public float perimeterCircle ( int r ) {
  float p = 2*r*PI  ;
  return p ;
}


public float radiusSurface(int surface) {
  // calcul the radius from circle surface
  return sqrt(surface/PI);
}


// GEOMETRY POLAR
/*

@return float
*/
public float longitude(float x, float range) {
  return map(x, 0,range, 0, TAU) ;
}
public float latitude(float y, float range) {
  return map(y, 0,range, 0, TAU) ;
}
/*
Return normal vector from angle 0 >2PI 
@return Vec3
*/
public Vec3 toCartesian(float longitude, float latitude) {
  /*
  // physical model
  float x = sin(longitude) *cos(latitude) ;
  float y = sin(longitude) *sin(latitude) ;
  float z = cos(longitude)  ;
  */
  // First Algo
  float x = sin(latitude) *cos(longitude);
  float y = sin(latitude) *sin(longitude);
  float z = cos(latitude);
  return new Vec3(x, y, z);
}
/*
Return normal vector from angle 0 >2PI 
@return Vec3
*/
public Vec3 toCartesian(float longitude, float latitude, float radius) {
  /* // physical model
  // weird behavior on the z axis 
  float x = sin(longitude) *cos(latitude) *radius;
  float y = sin(longitude) *sin(latitude) *radius;
  float z = cos(longitude) *radius;
  */

  /* // mathematical model
  float x = cos(longitude) *cos(latitude) *radius;
  float y = sin(longitude) *cos(latitude) *radius;
  float z = sin(longitude) *radius;
  */
  // First Algo
  float x = radius *sin(latitude) *cos(longitude);
  float y = radius *sin(latitude) *sin(longitude);
  float z = radius *cos(latitude);
  return new Vec3(x, y, z);
}
/* 
return a vector info : radius,longitude, latitude
@return Vec3
*/
public Vec3 toPolar(Vec3 cart) {
  float radius = sqrt(cart.x * cart.x + cart.y * cart.y + cart.z * cart.z);
  float longitude = acos(cart.x / sqrt(cart.x * cart.x + cart.y * cart.y)) * (cart.y < 0 ? -1 : 1);
  float latitude = acos(cart.z / radius) * (cart.z < 0 ? -1 : 1);
  // check NaN result
  if (Float.isNaN(longitude)) longitude = 0 ;
  if (Float.isNaN(latitude)) latitude = 0 ;
  if (Float.isNaN(radius)) radius = 0 ;
  // result
  return new Vec3(radius, longitude, latitude) ;
}

///////////////
// Cartesian 3D
/*
@ return Vec3
return the position of point on Sphere, with longitude and latitude
*/
//If you want just the final pos
public Vec3 toCartesian3D(Vec2 pos, Vec2 range, float sizeField)  {
  // vertical plan position
  float verticalY = toCartesian2D(pos.y, Vec2(0,range.y), Vec2(0,TAU), sizeField).x ;
  float verticalZ = toCartesian2D(pos.y, Vec2(0,range.y), Vec2(0,TAU), sizeField).y ; 
  Vec3 posVertical = new Vec3(0, verticalY, verticalZ) ;
  // horizontal plan position
  float horizontalX = toCartesian2D(pos.x, Vec2(0,range.x), Vec2(0,TAU), sizeField).x ; 
  float horizontalZ = toCartesian2D(pos.x, Vec2(0,range.x), Vec2(0,TAU), sizeField).y  ;
  Vec3 posHorizontal = new Vec3(horizontalX, 0, horizontalZ) ;
  
  return projectionSphere (middle(posVertical,posHorizontal), sizeField) ;
}



//Step 1 : translate the mouse position x and y  on the sphere, we must do that separately
/*
@ return Vec2 
return lineat value on the circle perimeter
*/
public Vec2 toCartesian2D (float posMouse, Vec2 range, Vec2 targetRadian, float distance) {
  float rotationPlan = map(posMouse, range.x, range.y, targetRadian.x, targetRadian.y)  ;
  float x = cos(rotationPlan) *distance ;
  float y = sin(rotationPlan) *distance ;
  return new Vec2 (x, y) ;
}


// END POLAR and CARTESIAN coord
/////////////////////////////////




//bisectorProjection
/* 
@ return Vec3
calculte the projection position on the sphere, we supose the center of the sphere is 0,0,0

the bisector is the midlle position of two points who are on the surface of sphere
*/
public Vec3 projectionSphere(Vec3 point, float radius ) {
  Vec3 center = new Vec3(0) ;
  float distanceBetweenCenterAndBisector = point.dist(center) ;
  float rapport = radius /distanceBetweenCenterAndBisector ;
  point.mult(rapport) ;
  return point ;
}










// normal direction 0-360 to -1, 1 PVector
public PVector normalDir(int direction) {
  int numPoints = 360;
  float angle = TWO_PI/(float)numPoints;
  direction = 360-direction;
  direction += 180;
  return new PVector(sin(angle*direction), cos(angle*direction));
}
// degre direction from PVector direction
public float deg360 (PVector dir) {
  float deg360 ;
  deg360 = 360 -(degrees(atan2(dir.x, dir.y)) +180)   ;
  return deg360 ;
}

//ROTATION
//GLOBAL
PVector resultPositionOfRotation = new PVector() ;
//DRAW

public PVector rotation(PVector ref, PVector lattice, float angle) {
  float a = angle( lattice, ref ) + angle;
  float d = distance( lattice, ref );
  
  resultPositionOfRotation.x = lattice.x + cos( a ) * d;
  resultPositionOfRotation.y = lattice.y + sin( a ) * d;
  //
  return resultPositionOfRotation;
}

public float angle(PVector p0, PVector p1) {
  return atan2( p1.y - p0.y, p1.x - p0.x );
}
  
public float distance(PVector p0, PVector p1) {
  return sqrt( ( p0.x -p1.x) *( p0.x -p1.x) +( p0.y -p1.y) *( p0.y -p1.y));
}


//other Rotation
//Rotation Objet
public void rotation (float angle, float posX, float posY ) {
  translate(posX, posY ) ;
  rotate (radians(angle) ) ;
}

//END OF ROTATION


// END EQUATION
///////////////







// PRIMITIVE 2D
///////////////




//DISC
public void disc( PVector pos, int diam, int c ) {
  for ( int i = 1 ; i < diam +1 ; i++) {
    circle(c, pos, i) ;
  }
}

public void chromaticDisc( PVector pos, int diam ) {
  for ( int i = 1 ; i < diam +1 ; i++) {
    chromaticCircle(pos, i) ;
  }
}



//CIRCLE
public void chromaticCircle(PVector pos, int d) {
  int surface = d*d ; // surface is equale of square surface where is the cirlcke...make sens ?

  int radius = ceil(radiusSurface(surface)) ;
  int numPoints = ceil(perimeterCircle( radius)) ;
  for(int i=0; i < numPoints; i++) {
      //circle
      float stepAngle = map(i, 0, numPoints, 0, 2*PI) ; 
      float angle =  2*PI - stepAngle;
      //color
      int c = color (i, 100,100) ;
      //display
      set(PApplet.parseInt(pointOnCirlcle(radius, angle).x + pos.x) , PApplet.parseInt(pointOnCirlcle(radius, angle).y + pos.y), c);
  }
}

// END DISC


// PRIMITIVE  with "n" summits
public void primitive(int x, int y, int radius, int summits) {
  if(summits < 3) summits = 3 ;
  PVector pos = new PVector (x,y) ;
  PVector [] summit = new PVector[summits] ;
  // create coord of the shape
  for (int i = 0 ; i < summits ; i++) {
    summit[i] = circle(pos, radius, summits)[i].copy() ; 
  }
  
  //draw the shape
  beginShape() ;
  for (int i = 0 ; i < summits ; i++) {
    vertex(summit[i].x, summit[i].y) ;
  }
  vertex(summit[0].x, summit[0].y) ;
  endShape() ;
}










// summits around the circle
public PVector [] circle (PVector pos, int d, int num) {
  PVector [] p = new PVector [num] ;
  int surface = d*d ; 
  int radius = ceil(radiusSurface(surface)) ;
  
  // choice your starting point
  float startingAnglePos = PI*.5f;
  if(num == 4) startingAnglePos = PI*.25f;
  
  for( int i=0 ; i < num ; i++) {
    float stepAngle = map(i, 0, num, 0, TAU) ; 
    float angle =  TAU - stepAngle -startingAnglePos;
    p[i] = new PVector(pointOnCirlcle(radius, angle).x +pos.x,pointOnCirlcle(radius, angle).y + pos.y) ;
  }
  return p ;
}

public PVector [] circle (PVector pos, int d, int num, float jitter) {
  PVector [] p = new PVector [num] ;
  int surface = d*d ; 
  int radius = ceil(radiusSurface(surface)) ;
  
  // choice your starting point
  float startingAnglePos = PI*.5f;
  if(num == 4) startingAnglePos = PI*.25f;
  
  float angleCorrection ; // this correction is cosmetic, when we'he a pair beam this one is stable for your eyes :)
  for( int i=0 ; i < num ; i++) {
    int beam = num /2 ;
    if ( beam%2 == 0 ) angleCorrection = PI / num ; else angleCorrection = 0.0f ;
    if ( num%2 == 0 ) jitter *= -1 ; else jitter *= 1 ; // the beam have two points at the top and each one must go to the opposate...
    
    float stepAngle = map(i, 0, num, 0, TAU) ;
    float jitterAngle = map(jitter, -1, 1, -PI/num, PI/num) ;
    float angle =  TAU -stepAngle +jitterAngle +angleCorrection -startingAnglePos;
    
    p[i] = new PVector(pointOnCirlcle(radius, angle).x +pos.x, pointOnCirlcle(radius, angle ).y +pos.y) ;
  }
  return p ;
}


//full cirlce
public void circle(int c, PVector pos, int d) {
  int surface = d*d ; // surface is equale of square surface where is the cirlcke...make sens ?

  int radius = ceil(radiusSurface(surface)) ;
  int numPoints = ceil(perimeterCircle(radius)) ;
  for(int i=0; i < numPoints; i++) {
      float stepAngle = map(i, 0, numPoints, 0, 2*PI) ; 
      float angle =  2*PI - stepAngle;
      set(PApplet.parseInt(pointOnCirlcle(radius, angle).x + pos.x) , PApplet.parseInt(pointOnCirlcle(radius, angle).y + pos.y), c);
  }
}

//circle with a specific quantity points
public void circle(int c, PVector pos, int d, int num) {
  int surface = d*d ; // surface is equale of square surface where is the cirlcke...make sens ?

  int radius = ceil(radiusSurface(surface)) ;
  for(int i=0; i < num; i++) {
      float stepAngle = map(i, 0, num, 0, 2*PI) ; 
      float angle =  2*PI - stepAngle;
      set(PApplet.parseInt(pointOnCirlcle(radius, angle).x + pos.x) , PApplet.parseInt(pointOnCirlcle(radius, angle).y + pos.y), c);
  }
}


//circle with a specific quantity points and specific shape for each point
public void circle(PVector pos, int d, int num, PVector size, String shape) {
  int surface = d*d ; // surface is equale of square surface where is the cirlcke...make sens ?
  int whichShape = 0 ;
  if (shape.equals("point") )  whichShape = 0;
  else if (shape.equals("ellipse") )  whichShape = 1 ;
  else if (shape.equals("rect") )  whichShape = 2 ;
  else if (shape.equals("box") )  whichShape = 3 ;
  else if (shape.equals("sphere") )  whichShape = 4 ;
  else whichShape = 0 ;

  int radius = ceil(radiusSurface(surface)) ;
  for(int i=0; i < num; i++) {
    float stepAngle = map(i, 0, num, 0, 2*PI) ; 
    float angle =  2*PI - stepAngle;
    PVector newPos = new PVector(pointOnCirlcle(radius, angle).x + pos.x, pointOnCirlcle(radius, angle).y + pos.y) ;
    if(whichShape == 0 ) point(newPos.x, newPos.y) ;
    if(whichShape == 1 ) ellipse(newPos.x, newPos.y, size.x, size.y) ;
    if(whichShape == 2 ) rect(newPos.x, newPos.y, size.x, size.y) ;
    if(whichShape == 3 ) {
      pushMatrix() ;
      translate(newPos.x, newPos.y,0) ;
      box(size.x, size.y, size.z) ;
      popMatrix() ;
    }
    if(whichShape == 4 ) {
      pushMatrix() ;
      translate(newPos.x, newPos.y,0) ;
      int detail = (int)size.x /4 ;
      if (detail > 10 ) detail = 10 ;
      sphereDetail(detail) ;
      sphere(size.x) ;
      popMatrix() ;
    }
  }
}


public PVector pointOnCirlcle(int r, float angle) {
  PVector posPix = new PVector () ;
  posPix.x = cos(angle) *r ;
  posPix.y = sin(angle) *r ;
  return posPix ;
}


// END PRIMITIVE 2D
///////////////////










//PRIMITIVE 3D
//////////////

// this triangle is a primitive 2D in 3D world
public void triangle(float x1, float y1, float z1, float x2, float y2, float z2, float x3, float y3, float z3) {
  beginShape() ;
  vertex(x1, y1, z1) ;
  vertex(x2, y2, z2) ;
  vertex(x3, y3, z3) ;
  endShape(CLOSE) ;
}



// SIMPLE TETRAHEDRON
/////////////////////
ArrayList listPointTetrahedron = new ArrayList() ;
// main method
/* The starting size is around "one pixel */
public void tetrahedron(int size) {
  tetrahedronClear() ;
  tetrahedronAdd() ;
  tetrahedronDisplay(size) ;
}

// add function
public void tetrahedronAdd() {
  listPointTetrahedron.add (new PVector(1, 1, 1));
  listPointTetrahedron.add (new PVector(-1, -1, 1));
  listPointTetrahedron.add (new PVector(-1, 1, -1));
  listPointTetrahedron.add (new PVector(1, -1, -1));
}


// clear function
public void tetrahedronClear() {
  listPointTetrahedron.clear() ;
}
public void tetrahedronDisplay(int size) {
  int finalSize = size /2 ;
  int n = 4 ; // quantity of face of Tetrahedron
  for(int i = 0 ; i < n ; i++) {
    // choice of each point
    int a = i ;
    int b = i+1 ;
    int c = i+2 ;
    if(i == n-2 ) c = 0 ;
    if(i == n-1 ) {
      b = 0 ;
      c = 1 ;
    }
    PVector v1 = (PVector)listPointTetrahedron.get(a) ;
    PVector v2 = (PVector)listPointTetrahedron.get(b) ;
    PVector v3 = (PVector)listPointTetrahedron.get(c) ;
    // scale the position of the points
    v1 = new PVector(v1.x *finalSize, v1.y *finalSize, v1.z *finalSize) ;
    v2 = new PVector(v2.x *finalSize, v2.y *finalSize, v2.z *finalSize) ;
    v3 = new PVector(v3.x *finalSize, v3.y *finalSize, v3.z *finalSize) ;
    renderTetrahedron(v1, v2, v3) ;
  }
}

public void renderTetrahedron(PVector v1, PVector v2, PVector v3) {
  beginShape() ;
  vertex(v1.x, v1.y, v1.z) ;
  vertex(v2.x, v2.y, v2.z) ;
  vertex(v3.x, v3.y, v3.z) ;
  endShape() ;
}


// END SIMPLE TETRAHEDRON
////////////////////////





//POLYDRON
  //create Polyhedron
  /*
  "TETRAHEDRON","CUBE", "OCTOHEDRON", "DODECAHEDRON","ICOSAHEDRON","CUBOCTAHEDRON","ICOSI DODECAHEDRON",
  "TRUNCATED CUBE","TRUNCATED OCTAHEDRON","TRUNCATED DODECAHEDRON","TRUNCATED ICOSAHEDRON","TRUNCATED CUBOCTAHEDRON","RHOMBIC CUBOCTAHEDRON",
  "RHOMBIC DODECAHEDRON","RHOMBIC TRIACONTAHEDRON","RHOMBIC COSI DODECAHEDRON SMALL","RHOMBIC COSI DODECAHEDRON GREAT"
  All Polyhedrons can use "POINT" and "LINE" display mode.
  except the "TETRAHEDRON" who can also use "VERTEX" display mode.
  */
  
// MAIN VOID to create polyhedron
public void polyhedron(String whichPolyhedron, String whichStyleToDraw, int size) {
  //This is where the actual defining of the polyhedrons takes place

   
  listPVectorPolyhedron.clear(); //clear out whatever verts are currently defined
  
  if(whichPolyhedron.equals("TETRAHEDRON")) tetrahedron_poly(size) ;
  if(whichPolyhedron.equals("CUBE")) cube(size) ;
  if(whichPolyhedron.equals("OCTOHEDRON")) octohedron(size) ;
  if(whichPolyhedron.equals("DODECAHEDRON"))dodecahedron(size) ;
  if(whichPolyhedron.equals("ICOSAHEDRON"))icosahedron(size) ;
  if(whichPolyhedron.equals("CUBOCTAHEDRON"))cuboctahedron(size) ;
  if(whichPolyhedron.equals("ICOSI DODECAHEDRON"))icosi_dodecahedron(size) ;

  if(whichPolyhedron.equals("TRUNCATED CUBE"))truncated_cube(size) ;
  if(whichPolyhedron.equals("TRUNCATED OCTAHEDRON"))truncated_octahedron(size) ;
  if(whichPolyhedron.equals("TRUNCATED DODECAHEDRON"))truncated_dodecahedron(size) ;
  if(whichPolyhedron.equals("TRUNCATED ICOSAHEDRON"))truncated_icosahedron(size) ;
  if(whichPolyhedron.equals("TRUNCATED CUBOCTAHEDRON"))truncated_cuboctahedron(size) ;
  
  if(whichPolyhedron.equals("RHOMBIC CUBOCTAHEDRON"))rhombic_cuboctahedron(size) ;
  if(whichPolyhedron.equals("RHOMBIC DODECAHEDRON"))rhombic_dodecahedron(size) ;
  if(whichPolyhedron.equals("RHOMBIC TRIACONTAHEDRON"))rhombic_triacontahedron(size) ;
  if(whichPolyhedron.equals("RHOMBIC COSI DODECAHEDRON SMALL"))rhombic_cosi_dodecahedron_small(size) ;
  if(whichPolyhedron.equals("RHOMBIC COSI DODECAHEDRON GREAT"))rhombic_cosi_dodecahedron_great(size) ;
  
  // which method to draw
  if(whichStyleToDraw.equals("LINE")) drawLinePolyhedron(whichPolyhedron) ;
  if(whichStyleToDraw.equals("POINT")) drawPointPolyhedron(whichPolyhedron) ;
  if(whichStyleToDraw.equals("VERTEX")) drawVertexPolyhedron(whichPolyhedron) ;

}




// POLYHEDRON DETAIL 
////////////
//set up initial polyhedron
float factorSizePolyhedron ;
//some variables to hold the current polyhedron...
ArrayList listPVectorPolyhedron = new ArrayList();
float edgeLengthOfPolyhedron;
String strName, strNotes;

// FEW POLYHEDRON
// BASIC
public void tetrahedron_poly(int size) {
  listPVectorPolyhedron.add(new PVector(1, 1, 1)) ;
  listPVectorPolyhedron.add(new PVector(-1, -1, 1)) ;
  listPVectorPolyhedron.add(new PVector(-1, 1, -1)) ;
  listPVectorPolyhedron.add(new PVector(1, -1, -1)) ;
  edgeLengthOfPolyhedron = 0 ;
  factorSizePolyhedron = size /2;
}

public void cube(int size) {
  addVerts(1, 1, 1);
  edgeLengthOfPolyhedron = 2;
  factorSizePolyhedron = size /2;
}

public void octohedron(int size) {
  addPermutations(1, 0, 0);
  edgeLengthOfPolyhedron = ROOT2;
  factorSizePolyhedron = size *.8f;
}

public void dodecahedron(int size) {
  addVerts(1, 1, 1);
  addPermutations(0, 1/PHI, PHI);
  edgeLengthOfPolyhedron = 2/PHI;
  factorSizePolyhedron = size /2.5f;
}


// SPECIAL
public void icosahedron(int size) {
  addPermutations(0, 1, PHI);
  edgeLengthOfPolyhedron = 2.0f;
  factorSizePolyhedron = size /2.7f;
}

public void icosi_dodecahedron(int size) {
  addPermutations(0, 0, 2*PHI);
  addPermutations(1, PHI, sq(PHI));
  edgeLengthOfPolyhedron = 2;
  factorSizePolyhedron = size/5;
}

public void cuboctahedron(int size) {
  addPermutations(1, 0, 1);
  edgeLengthOfPolyhedron = ROOT2;
  factorSizePolyhedron = size /1.9f;
}


// TRUNCATED
public void truncated_cube(int size) {
  addPermutations(ROOT2 - 1, 1, 1);
  edgeLengthOfPolyhedron = 2*(ROOT2 - 1);     
  factorSizePolyhedron = size /2.1f;
}

public void truncated_octahedron(int size) {
  addPermutations(0, 1, 2);
  addPermutations(2, 1, 0);
  edgeLengthOfPolyhedron = ROOT2;
  factorSizePolyhedron = size/3.4f;
}

public void truncated_cuboctahedron(int size) {
  addPermutations(ROOT2 + 1, 2*ROOT2 + 1, 1);
  addPermutations(ROOT2 + 1, 1, 2*ROOT2 + 1);
  edgeLengthOfPolyhedron = 2;
  factorSizePolyhedron = size/6.9f;
}

public void truncated_dodecahedron(int size) {
  addPermutations(0, 1/PHI, PHI + 2);
  addPermutations(1/PHI, PHI, 2*PHI);
  addPermutations(PHI, 2, sq(PHI));
  edgeLengthOfPolyhedron = 2*(PHI - 1);
  factorSizePolyhedron = size/6;
}

public void truncated_icosahedron(int size) {
  addPermutations(0, 1, 3*PHI);
  addPermutations(2, 2*PHI + 1, PHI);
  addPermutations(1, PHI + 2, 2*PHI);
  edgeLengthOfPolyhedron = 2;
  factorSizePolyhedron = size/8;
}

// RHOMBIC
public void rhombic_dodecahedron(int size) {
  addVerts(1, 1, 1);
  addPermutations(0, 0, 2);
  edgeLengthOfPolyhedron = sqrt(3);
  factorSizePolyhedron = size /2.8f;
}

public void rhombic_triacontahedron(int size) {
  addVerts(sq(PHI), sq(PHI), sq(PHI));
  addPermutations(sq(PHI), 0, pow(PHI, 3));
  addPermutations(0, PHI, pow(PHI, 3));
  edgeLengthOfPolyhedron = PHI*sqrt(PHI + 2);
  factorSizePolyhedron = size /7.2f;
}

public void rhombic_cuboctahedron(int size) {
  addPermutations(ROOT2 + 1, 1, 1);
  edgeLengthOfPolyhedron = 2;
  factorSizePolyhedron = size/4.2f;
}

public void rhombic_cosi_dodecahedron_small(int size) {
  addPermutations(1, 1, pow(PHI, 3));
  addPermutations(sq(PHI), PHI, 2*PHI);
  addPermutations(PHI + 2, 0, sq(PHI));
  edgeLengthOfPolyhedron = 2;
  factorSizePolyhedron = size/7.4f;
}

public void rhombic_cosi_dodecahedron_great(int size) {
  addPermutations(1/PHI, 1/PHI, PHI + 3);
  addPermutations(2/PHI, PHI, 2*PHI + 1);
  addPermutations(1/PHI, sq(PHI), 3*PHI - 1);
  addPermutations(2*PHI - 1, 2, PHI + 2);
  addPermutations(PHI, 3, 2*PHI);
  edgeLengthOfPolyhedron = 2*PHI - 2;
  factorSizePolyhedron = size/7.8f;
}



//Built Tetrahedron
// EASY METHOD, for direct and single drawing
// classic and easy method
public void drawPointPolyhedron(String polyhedronName) {
  for (int i=0; i <listPVectorPolyhedron.size(); i++) {
    PVector point = (PVector)listPVectorPolyhedron.get(i) ;
    if(polyhedronName.equals("TETRAHEDRON")) {
      pushMatrix() ;
      rotateX(TAU -1) ;
      rotateY(PI/4) ;
    }
    point(point.x *factorSizePolyhedron, point.y *factorSizePolyhedron, point.z *factorSizePolyhedron);
    if(polyhedronName.equals("TETRAHEDRON")) popMatrix() ;
  }
}

public void drawLinePolyhedron(String polyhedronName) {
  for (int i=0; i <listPVectorPolyhedron.size(); i++) {
    for (int j=i +1; j < listPVectorPolyhedron.size(); j++) {
      if (isEdge(i, j, listPVectorPolyhedron) || edgeLengthOfPolyhedron == 0 ) {
        PVector v1 = (PVector)listPVectorPolyhedron.get(i) ;
        PVector v2 = (PVector)listPVectorPolyhedron.get(j) ;
        if(polyhedronName.equals("TETRAHEDRON")) {
          pushMatrix() ;
          rotateX(TAU -1) ;
          rotateY(PI/4) ;
        }
        line(v1.x *factorSizePolyhedron, v1.y *factorSizePolyhedron, v1.z *factorSizePolyhedron, v2.x *factorSizePolyhedron, v2.y *factorSizePolyhedron, v2.z *factorSizePolyhedron);
        if(polyhedronName.equals("TETRAHEDRON")) popMatrix() ;
      }
    }
  }
}

public void drawVertexPolyhedron(String polyhedronName) {
  // TETRAHEDRON
  if(polyhedronName.equals("TETRAHEDRON")) {
    pushMatrix() ;
    rotateX(TAU -1) ;
    rotateY(PI/4) ;
    int n = 4 ; // quantity of face of Tetrahedron
    for(int i = 0 ; i < n ; i++) {
      // choice of each point
      int a = i ;
      int b = i+1 ;
      int c = i+2 ;
      if(i == n-2 ) c = 0 ;
      if(i == n-1 ) {
        b = 0 ;
        c = 1 ;
      }
      PVector v1 = (PVector)listPVectorPolyhedron.get(a) ;
      PVector v2 = (PVector)listPVectorPolyhedron.get(b) ;
      PVector v3 = (PVector)listPVectorPolyhedron.get(c) ;
      // scale the position of the points
      v1 = new PVector(v1.x *factorSizePolyhedron, v1.y *factorSizePolyhedron, v1.z *factorSizePolyhedron) ;
      v2 = new PVector(v2.x *factorSizePolyhedron, v2.y *factorSizePolyhedron, v2.z *factorSizePolyhedron) ;
      v3 = new PVector(v3.x *factorSizePolyhedron, v3.y *factorSizePolyhedron, v3.z *factorSizePolyhedron) ;
      
      // drawing
      beginShape() ;
      vertex(v1.x, v1.y, v1.z) ;
      vertex(v2.x, v2.y, v2.z) ;
      vertex(v3.x, v3.y, v3.z) ;
      endShape(CLOSE) ;
    }
    popMatrix() ;
  // OTHER POLYHEDRON
  } else {
    beginShape() ;
    for (int i=0; i <listPVectorPolyhedron.size(); i++) {
      for (int j=i +1; j <listPVectorPolyhedron.size(); j++) {
        if (isEdge(i, j, listPVectorPolyhedron) || edgeLengthOfPolyhedron == 0 ) {
          // vLine((PVector)listPVectorPolyhedron.get(i), (PVector)listPVectorPolyhedron.get(j));
          PVector v1 = (PVector)listPVectorPolyhedron.get(i) ;
          PVector v2 = (PVector)listPVectorPolyhedron.get(j) ;
          v1 = new PVector(v1.x *factorSizePolyhedron, v1.y *factorSizePolyhedron, v1.z *factorSizePolyhedron) ;
          v2 = new PVector(v2.x *factorSizePolyhedron, v2.y *factorSizePolyhedron, v2.z *factorSizePolyhedron) ;
          vertex(v1.x, v1.y, v1.z) ;
          vertex(v2.x, v2.y, v2.z) ;
        }
      }
    }
    endShape(CLOSE) ;
  }
}
// END of EASY METHOD and DIRECT METHOD

 











// annexe draw polyhedron
public boolean isEdge(int vID1, int vID2, ArrayList listPoint) {
  //had some rounding errors that were messing things up, so I had to make it a bit more forgiving...
  int pres = 1000;
  PVector v1 = (PVector)listPoint.get(vID1);
  PVector v2 = (PVector)listPoint.get(vID2);
  float d = sqrt(sq(v1.x - v2.x) + sq(v1.y - v2.y) + sq(v1.z - v2.z)) + .00001f;
  return (PApplet.parseInt(d *pres)==PApplet.parseInt(edgeLengthOfPolyhedron *pres));
}

// END DRAW POLYHEDRON
//////////////////////


// ADD POINTS for built POLYHEDRON
/////////////////////////////////

 
public void addPermutations(float x, float y, float z) {
  //adds vertices for all three permutations of x, y, and z
  addVerts(x, y, z);
  addVerts(z, x, y);
  addVerts(y, z, x);
}


 
public void addVerts(float x, float y, float z) {
  //adds the requested vert and all "mirrored" verts
  listPVectorPolyhedron.add (new PVector(x, y, z));
  // z
  if (z != 0.0f) listPVectorPolyhedron.add (new PVector(x, y, -z)); 
  // y
  if (y != 0.0f) {
    listPVectorPolyhedron.add (new PVector(x, -y, z));
    if (z != 0.0f) listPVectorPolyhedron.add (new PVector(x, -y, -z));
  } 
  // x
  if (x != 0.0f) {
    listPVectorPolyhedron.add (new PVector(-x, y, z));
    if (z != 0.0f) listPVectorPolyhedron.add(new PVector(-x, y, -z));
    if (y != 0.0f) {
      listPVectorPolyhedron.add (new PVector(-x, -y, z));
      if (z != 0.0f) listPVectorPolyhedron.add (new PVector(-x, -y, -z));
    }
  }
}
// END POLYHEDRON














// END PRIMITIVE 3D
///////////////////

// END GEOMETRY
///////////////












// MISC
////////

// MAP
///////
/*
map the value between the min and the max
@ return float
*/
public float mapCycle(float value, float min, float max) {
  max += .000001f ;
  float newValue ;
  if(min < 0 && max >= 0 ) {
    float tempMax = max + abs(min) ;
    value += abs(min) ;
    float tempMin = 0 ;
    newValue =  tempMin +abs(value)%(tempMax - tempMin)  ;
    newValue -= abs(min) ;
    return newValue ;
  } else if ( min < 0 && max < 0) {
    newValue = abs(value)%(abs(max)+min) -max ;
    return newValue ;
  } else {
    newValue = min + abs(value)%(max - min) ;
    return newValue ;
  }
}

/*
map the value between the min and the max, but this value is lock between the min and the max
@ return float
*/
public float mapLocked(float value, float sourceMin, float sourceMax, float targetMin, float targetMax) {
  if(sourceMax >= targetMax ) sourceMax = targetMax ;
  if (value < sourceMin ) value = sourceMin ;
  if (value > sourceMax ) value = sourceMax ;
  float newMax = sourceMax - sourceMin ;
  float deltaTarget = targetMax - targetMin ;
  float ratio = ((value - sourceMin) / newMax ) ;
  float result = targetMin +deltaTarget *ratio;
  return result; 
}

// to map not linear, start the curve slowly to finish hardly
public float mapStartSmooth(float value, float sourceMin, float sourceMax, float targetMin, float targetMax, int level) {
  if(sourceMax >= targetMax ) sourceMax = targetMax ;
  if (value < sourceMin ) value = sourceMin ;
  if (value > sourceMax ) value = sourceMax ;
  float newMax = sourceMax - sourceMin ;
  float deltaTarget = targetMax - targetMin ;
  float ratio = ((value - sourceMin) / newMax ) ;
  ratio = pow(ratio, level) ;
  float result = targetMin +deltaTarget *ratio;
  return result;
}

// to map not linear, start the curve hardly to finish slowly
public float mapEndSmooth(float value, float sourceMin, float sourceMax, float targetMin, float targetMax, int level) {
  if(sourceMax >= targetMax ) sourceMax = targetMax ;
  if (value < sourceMin ) value = sourceMin ;
  if (value > sourceMax ) value = sourceMax ;
  float newMax = sourceMax - sourceMin ;
  float deltaTarget = targetMax - targetMin ;
  float ratio = ((value - sourceMin) / newMax ) ;
  ratio = roots(ratio, level) ;
  float result = targetMin +deltaTarget *ratio;
  return result;
}

// to map not linear, like a "S"
public float mapEndStartSmooth(float value, float sourceMin, float sourceMax, float targetMin, float targetMax, int level) {
  if(sourceMax >= targetMax ) sourceMax = targetMax ;
  if (value < sourceMin ) value = sourceMin ;
  if (value > sourceMax ) value = sourceMax ;
  float newMax = sourceMax - sourceMin ;
  float deltaTarget = targetMax - targetMin ;
  float ratio = ((value - sourceMin) / newMax ) ;
  ratio = map(ratio,0,1, -1, 1 ) ;
  int correction = 1 ;
  if(level % 2 == 1 ) correction = 1 ; else correction = -1 ;
  if (ratio < 0 ) ratio = pow(ratio, level) *correction  ; else ratio = pow(ratio, level)  ;
  ratio = map(ratio, -1,1, 0,1) ;
  float result = targetMin +deltaTarget *ratio;
  return result;
}
// END MAP
//////////





// MATH PVECTOR
///////////////
// FOLLOW PVECTOR
PVector goToPosFollow = new PVector() ;
// CALCULATE THE POS of PVector Traveller, give the target pos and the speed to go.
public PVector follow(PVector target, float speed) {
  // calcul X pos
  float targetX = target.x;
  float dx = targetX - goToPosFollow.x;
  if(abs(dx) != 0) {
    goToPosFollow.x += dx * speed;
  }
  // calcul Y pos
  float targetY = target.y;
  float dy = targetY - goToPosFollow.y;
  if(abs(dy) != 0) {
    goToPosFollow.y += dy * speed;
  }
  // calcul Z pos
  float targetZ = target.z;
  float dz = targetZ - goToPosFollow.z;
  if(abs(dz) != 0) {
    goToPosFollow.z += dz * speed;
  }
  return goToPosFollow ;
}


//////////////////////////////////////////////
// THIS PART MUST BE DEPRECaTED in the future

// CALCULATE THE POS of PVector Traveller
public PVector gotoTarget(PVector origin,  PVector finish, float speed) {
  PVector pos = new PVector() ;
  if(origin.x > finish.x) pos.x = origin.x  -distanceDone(origin, finish, speed).x ; else pos.x = origin.x  +distanceDone(origin, finish, speed).x ; 
  if(origin.y > finish.y) pos.y = origin.y  -distanceDone(origin, finish, speed).y ; else pos.y = origin.y  +distanceDone(origin, finish, speed).y ; 
  if(origin.z > finish.z) pos.z = origin.z  -distanceDone(origin, finish, speed).z ; else pos.z = origin.z  +distanceDone(origin, finish, speed).z ; 
  return pos ;
}
// end calcultate




// DISTANCE DONE
PVector distance, distanceToDo ;
PVector distanceDone = new PVector() ;

public PVector distanceDone(PVector origin,  PVector finish, float speedRef) {
  PVector dist = new PVector() ;
  PVector distance = new PVector() ;
  boolean stopX = false ;
  boolean stopY = false ;
  boolean stopZ = false ;
  distance.x = abs(finish.x - origin.x) ;
  distance.y = abs(finish.y - origin.y) ;
  distance.z = abs(finish.z - origin.z) ;
  //calcul the speed for XYZ
  PVector speed = new PVector(speedMoveTo(distance.x, speedRef), speedMoveTo(distance.y, speedRef), speedMoveTo(distance.z, speedRef)) ;
  // for the X
  dist.x = distance.x -distanceDone.x ;
  if(dist.x <= 0 ) stopX = true ; else stopX = false ;
  if(speed.x > dist.x ) speed.x = dist.x ;
  if(!stopX) distanceDone.x += speed.x ; else distanceDone.x = distance.x ;
  // for the Y
  dist.y = distance.y -distanceDone.y ;
  if(dist.y <= 0 ) stopY = true ; else stopY = false ;
  if(speed.y > dist.y ) speed.y = dist.y ;
  if(!stopY) distanceDone.y += speed.y ; else distanceDone.y = distance.y ;
  // for the Z
  dist.z = distance.z -distanceDone.z ;
  if(dist.z <= 0 ) stopZ = true ; else stopZ = false ;
  if(speed.z > dist.z ) speed.z = dist.z ;
  if(!stopZ) distanceDone.z += speed.z ; else distanceDone.z = distance.z ;
  //
  return distanceDone ;
}


public float speedMoveTo(float distance, float speed) {
  return distance *1 *speed ;
}


// END of the deprecated function
/////////////////////////////////
////////////
///////
//METEO
//GLOBAL
YahooWeather weather;
int updateIntervallMillis = 30000;
boolean meteo ;

int sunRise, sunSet ;



//SETUP
public void meteoSetup() {
  if (meteo) {
    String [] md = loadStrings (preferencesPath+"meteo.txt")  ;
    String meteoData  = join(md, "") ;
    String splitMeteoData [] = split(meteoData, '/') ;
  
    if (splitMeteoData[2].equals("celsius") ) weather = new YahooWeather(this, Integer.parseInt(splitMeteoData[4]), "c", updateIntervallMillis); else weather = new YahooWeather(this, Integer.parseInt(splitMeteoData[4]), "f", updateIntervallMillis) ;
  }
}

//DRAW
public void meteoDraw() {
  if(meteo) {
    weather.update();
  
    //the sun set and the sunrise is calculate in minutes, one day is 1440 minutes, and the start is midnight
    sunRise = PApplet.parseInt(clock24(weather.getSunrise(), 1)) ;
    sunSet = PApplet.parseInt(clock24(weather.getSunset(), 1)) ;
  }
}


//ANNEXE

//CLOCK SUN
public String clock24(String t, int mode) {
  String [] split = new String [2] ;
  String [] splitTime = new String [2] ;
  String clockSunset =  t ;
  //transform clock in 24h mode, then in number (int) ;
  split = split(clockSunset, " ") ;
  splitTime = split(split[0], ":") ;
  
  int hourSunset ;
  if (split[1].equals("pm") == true ) hourSunset = PApplet.parseInt(splitTime[0]) +12 ; else hourSunset = PApplet.parseInt(splitTime[0]) ;
  
  String clock24 = (hourSunset +"h"+splitTime[1]) ;
  int m = (PApplet.parseInt(hourSunset) * 60 + PApplet.parseInt(splitTime[1])) ;
  String min = (m + "") ;
  
  if (mode == 0 ) return clock24  ; else return min ;
}

//METEO COLOR
//global
float sky_h, sky_s, sky_b, sunValue ;



//one color
public int meteoColor(int colorOfTheDay, int whatTimeIsIt, int speedRiseSet, int pressure) {
  int colorOfSky ;
  
  int sunrise,sunset ;
  float wPressure = map(pressure,930, 1060, 0,1) ;
  

  sunrise = PApplet.parseInt(clock24(weather.getSunrise(), 1)) ;
  sunset = PApplet.parseInt(clock24(weather.getSunset(), 1)) ;
  
  //basic 
  //if ( sunrise < whatTimeIsIt && sunset < whatTimeIsIt ) colorOfSky = bleuCiel ; else colorOfSky = bleuNuit ; 
  
  //smooth
  int minValueSat = 0 ;
  int minValueBright = 0 ;
  int maxValueSat = PApplet.parseInt(100 *wPressure) ;
  int maxValueBright = 100 ;
  speedRiseSet /= 2 ;
  

  //sunrise
  if (  whatTimeIsIt  > sunrise -speedRiseSet && whatTimeIsIt < sunrise +speedRiseSet ) {
    sunValue = whatTimeIsIt - sunrise +speedRiseSet  ;
    sky_h = hue(colorOfTheDay) ;
    sky_s = map(sunValue, 0,speedRiseSet, minValueSat, maxValueSat) ;
    sky_b = map(sunValue, 0,speedRiseSet, minValueBright, maxValueBright) ;
  //sunset   
  } else if (  whatTimeIsIt  > sunset -speedRiseSet && whatTimeIsIt < sunset +speedRiseSet ) {
    sunValue = whatTimeIsIt - sunset +speedRiseSet  ;
    sky_h = hue(colorOfTheDay) ;
    sky_s = map(sunValue, 0,speedRiseSet, maxValueSat, minValueSat) ;
    sky_b = map(sunValue, 0,speedRiseSet, maxValueBright, minValueBright) ;
  //the night  
  } else if ( whatTimeIsIt <= sunrise -speedRiseSet || whatTimeIsIt >= sunset +speedRiseSet ) {
    sky_h = hue(colorOfTheDay) ;
    sky_s = minValueSat ;
    sky_b = minValueBright ;
  //the day
  } else if ( whatTimeIsIt >= sunrise +speedRiseSet || whatTimeIsIt <= sunset -speedRiseSet ) {
    sky_h = hue(colorOfTheDay) ;
    sky_s = maxValueSat ;
    sky_b = maxValueBright ;
  }
  
  colorOfSky = color (sky_h,sky_s,sky_b) ;
  // colorOfSky = bleuNuit ;
  
  return colorOfSky ;
}



//PRESSION
public int hectoPascal(float pressureToConvert) {
  int HP ;
  if (pressureToConvert < 800 ) HP = PApplet.parseInt(pressureToConvert *33.86f) ; else HP = (int)pressureToConvert ;
  return HP ;
}
//WIND FORCE
public int beaufort() {
  int forceDuVent = 0 ;
  if (weather.getWindSpeed() < 1 ) forceDuVent = 0 ;
  if (weather.getWindSpeed() > 0 && weather.getWindSpeed() < 6 ) forceDuVent = 1 ;
  if (weather.getWindSpeed() > 5 && weather.getWindSpeed() < 12 ) forceDuVent = 2 ;
  if (weather.getWindSpeed() > 11 && weather.getWindSpeed() < 20 ) forceDuVent = 3 ;
  if (weather.getWindSpeed() > 19 && weather.getWindSpeed() < 29 ) forceDuVent = 4 ;
  if (weather.getWindSpeed() > 28 && weather.getWindSpeed() < 39 ) forceDuVent = 5 ;
  if (weather.getWindSpeed() > 38 && weather.getWindSpeed() < 50 ) forceDuVent = 6 ;
  if (weather.getWindSpeed() > 49 && weather.getWindSpeed() < 62 ) forceDuVent = 7 ;
  if (weather.getWindSpeed() > 61 && weather.getWindSpeed() < 75 ) forceDuVent = 8 ;
  if (weather.getWindSpeed() > 74 && weather.getWindSpeed() < 89 ) forceDuVent = 9 ;
  if (weather.getWindSpeed() > 88 && weather.getWindSpeed() < 103 ) forceDuVent = 10 ;
  if (weather.getWindSpeed() > 102 && weather.getWindSpeed() < 118) forceDuVent = 11 ;
  if (weather.getWindSpeed() > 117 ) forceDuVent = 12 ;
  return forceDuVent ;
}



//WIND DIRECTION
//GLOBAL
String vent ;
//Void
public String windFrench() {
  //wind
  
  if (weather.getWindDirection() > 348 || weather.getWindDirection() <  11 ) vent = "de Nord" ;
  if (weather.getWindDirection() >= 11  && weather.getWindDirection() < 34 )  vent = "de Nord-Nord-Est" ;
  if (weather.getWindDirection() >= 34  && weather.getWindDirection() < 56 )  vent = "de Nord-Est" ;
  if (weather.getWindDirection() >= 56  && weather.getWindDirection() < 79 )  vent = "de Est-Est-Nord" ;
  
  if (weather.getWindDirection() >= 79  && weather.getWindDirection() < 101 ) vent = "d'Est" ;
  if (weather.getWindDirection() >= 101  && weather.getWindDirection() < 124 ) vent = "d'Est-Est-Sud" ;
  if (weather.getWindDirection() >= 124 && weather.getWindDirection() < 146 ) vent = "de Sud-Est" ;
  if (weather.getWindDirection() >= 146 && weather.getWindDirection() < 169 ) vent = "de Sud-Sud-Est" ;
  
  if (weather.getWindDirection() >= 169 && weather.getWindDirection() < 191 ) vent = "de Sud" ;
  if (weather.getWindDirection() >= 191 && weather.getWindDirection() < 214 ) vent = "de Sud-Sud-Ouest" ;
  if (weather.getWindDirection() >= 214 && weather.getWindDirection() < 236 ) vent = "de Sud-Ouest" ;
  if (weather.getWindDirection() >= 236 && weather.getWindDirection() < 259 ) vent = "de Ouest-Ouest-Sud" ;
  
  if (weather.getWindDirection() >= 259 && weather.getWindDirection() < 281 ) vent = "d'Ouest" ;
  if (weather.getWindDirection() >= 281 && weather.getWindDirection() < 304 ) vent = "d'Ouest-Ouest-Nord" ;
  if (weather.getWindDirection() >= 304 && weather.getWindDirection() < 326 ) vent = "de Nord-Ouest" ;
  if (weather.getWindDirection() >= 326 && weather.getWindDirection() < 348 ) vent = "de Nord-Nord-Ouest" ;
  return vent ;
}




//TRADUCTION
String frenchWeatherDescription ;
public String traductionWeather(int code) {
  if (code == 0 ) { frenchWeatherDescription =  "tornade" ; }
  if (code == 1 ) { frenchWeatherDescription =  "temp\u00eate tropicale" ; }
  if (code == 2 ) { frenchWeatherDescription =  "ouragan" ; }
  if (code == 3 ) { frenchWeatherDescription =  "orage violent" ; }
  if (code == 4 ) { frenchWeatherDescription =  "orage" ; }
  if (code == 5 ) { frenchWeatherDescription =  "pluie et neige m\u00e9lang\u00e9es" ; }
  if (code == 6 ) { frenchWeatherDescription =  "pluie et giboul\u00e9e (grelons?)" ; }
  if (code == 7 ) { frenchWeatherDescription =  "neige et giboul\u00e9e (grelons?)" ; }
  if (code == 8 ) { frenchWeatherDescription =  "bruine verglassante" ; }
  if (code == 9 ) { frenchWeatherDescription =  "bruine" ; }
  if (code == 10 ) { frenchWeatherDescription =  "pluie verglassante" ; }
  if (code == 11 ) { frenchWeatherDescription =  "averses" ; }
  if (code == 12 ) { frenchWeatherDescription =  "averses" ; }
  if (code == 13 ) { frenchWeatherDescription =  "averses de neige" ; }
  if (code == 14 ) { frenchWeatherDescription =  "averses de neige l\u00e9g\u00e8re" ; }
  if (code == 15 ) { frenchWeatherDescription =  "rafales de neige" ; }
  if (code == 16 ) { frenchWeatherDescription =  "neige" ; }
  if (code == 17 ) { frenchWeatherDescription =  "gr\u00eale" ; }
  if (code == 18 ) { frenchWeatherDescription =  "giboul\u00e9e" ; }
  if (code == 19 ) { frenchWeatherDescription =  "poussi\u00e8re" ; }
  if (code == 20 ) { frenchWeatherDescription =  "brouillard" ; }
  if (code == 21 ) { frenchWeatherDescription =  "brume" ; }
  if (code == 22 ) { frenchWeatherDescription =  "pollu\u00e9" ; }
  if (code == 23 ) { frenchWeatherDescription =  "bourrasque" ; }
  if (code == 24 ) { frenchWeatherDescription =  "venteux" ; }
  if (code == 25 ) { frenchWeatherDescription =  "froid" ; }
  if (code == 26 ) { frenchWeatherDescription =  "couvert" ; }
  if (code == 27 ) { frenchWeatherDescription =  "nuit plut\u00f4t couverte" ; }
  if (code == 28 ) { frenchWeatherDescription =  "journ\u00e9e plut\u00f4t couverte" ; }
  if (code == 29 ) { frenchWeatherDescription =  "nuit partiellement couverte" ; }
  if (code == 30 ) { frenchWeatherDescription =  "journ\u00e9e partiellement couverte" ; }
  if (code == 31 ) { frenchWeatherDescription =  "nuit d\u00e9gag\u00e9e" ; }
  if (code == 32 ) { frenchWeatherDescription =  "ensolleill\u00e9" ; }
  if (code == 33 ) { frenchWeatherDescription =  "nuit d\u00e9gag\u00e9e" ; }
  if (code == 34 ) { frenchWeatherDescription =  "journ\u00e9e d\u00e9gag\u00e9e" ; }
  if (code == 35 ) { frenchWeatherDescription =  "pluie et gr\u00eale" ; }
  if (code == 36 ) { frenchWeatherDescription =  "chaud" ; }
  if (code == 37 ) { frenchWeatherDescription =  "orages localis\u00e9s" ; }
  if (code == 38 ) { frenchWeatherDescription =  "orages \u00e9parses" ; }
  if (code == 39 ) { frenchWeatherDescription =  "orages \u00e9parses" ; }
  if (code == 40 ) { frenchWeatherDescription =  "averses \u00e9parses" ; }
  if (code == 41 ) { frenchWeatherDescription =  "grosses chute de neige" ; }
  if (code == 42 ) { frenchWeatherDescription =  "chutes de neige \u00e9parses" ; }
  if (code == 43 ) { frenchWeatherDescription =  "grosses chute de neige" ; }
  if (code == 44 ) { frenchWeatherDescription =  "partiellement couvert" ; }
  if (code == 45 ) { frenchWeatherDescription =  "pluies violentes" ; }
  if (code == 46 ) { frenchWeatherDescription =  "averses de neige" ; }
  if (code == 47 ) { frenchWeatherDescription =  "pluies violentes isol\u00e9es" ; }
  if (code == 3200 ) { frenchWeatherDescription =  "non r\u00e9pertori\u00e9" ; } 
  
  return frenchWeatherDescription ;
}
//END METEO
//////////
// Z OSC Prescene & Scene
/////////////////////////
// RECEIVE INFO from CONTROLLER
////////////////////////////////
int numOfPartSendByController = 7 ; 
String fromController [] = new String [numOfPartSendByController] ;
//EVENT to check what else is receive by the receiver





// ANNEXE VOID of OSC RECEIVE

// catch raw osc data
public void catchDataFromController(OscMessage receive) {
  for ( int i = 0 ; i < fromController.length ; i++ ) {
    fromController [i] = receive.get(i).stringValue() ;
  }
}

// split data button
public void splitDataButton() {
  //Split data from the String Data
  valueButtonGlobal = PApplet.parseInt(split(fromController [0], '/')) ;
  // stick the Int(String) chain from the group object "one" and "two" is single chain integer(String).
  String fullChainValueButtonObj =("") ;
  for ( int i = 1 ; i <= NUM_GROUP ; i++ ) {
    fullChainValueButtonObj += fromController [i]+"/" ;
  }
  valueButtonObj = PApplet.parseInt(split(fullChainValueButtonObj, '/')) ;
}

// split data slider
public void splitDataSlider() {
    //SLIDER
  //split String value from controller
  int numTotalGroup = NUM_GROUP +1 ;
  for ( int i = 0 ; i < numTotalGroup ; i++ ) {
    valueSliderTemp [i] = split(fromController [i +numTotalGroup], '/') ;
  }
  // translate the String value to the float var to use
  for ( int i = 0 ; i < NUM_GROUP +1 ; i++ ) {
    // security because there not same quantity of slider in the group MISC "zero" and OBJECT group "one and two".
    int n = 0 ;
    if ( i < 1 ) n = NUM_SLIDER_MISC ; else n = NUM_SLIDER_OBJ ;
    for (int j = 0 ; j < n ; j++) {
      valueSlider[i][j] = Float.valueOf(valueSliderTemp[i][j]) ;
    }
  }
}


// split data boolean to give load or save order
public void splitDataLoadSaveController() {
    // LOAD SAVE

  /*
  +1 for the global group
  *2 because there is one group for the button and an other one for the slider
  */
  int whichOne = (NUM_GROUP +1) *2 ;
  String [] booleanSave  ;

  booleanSave = split(fromController[whichOne], '/') ;
  // convert string to boolean
  load_SCENE_Setting_GLOBAL = Boolean.valueOf(booleanSave[0]).booleanValue();
  save_Current_SCENE_Setting_GLOBAL = Boolean.valueOf(booleanSave[1]).booleanValue();
  save_New_SCENE_Setting_GLOBAL = Boolean.valueOf(booleanSave[2]).booleanValue();
}



// TRANSFORM info from controler to use in the PRESCENE
public void translateDataFromController () {

  // sound option on/off
  if(valueButtonGlobal[1] == 1 ) onOffBeat = true ; else onOffBeat = false ;
  if(valueButtonGlobal[2] == 1 ) onOffKick = true ; else onOffKick = false ;
  if(valueButtonGlobal[3] == 1 ) onOffSnare = true ; else onOffSnare = false ;
  if(valueButtonGlobal[4] == 1 ) onOffHat = true ; else onOffHat = false ;
  // backgound option on/off
  if(valueButtonGlobal[6] == 1 ) onOffCurtain = true ; else onOffCurtain = false ;
  if(valueButtonGlobal[7] == 1 ) onOffBackground = true ; else onOffBackground = false ;
  // light on/off
  if(valueButtonGlobal[8] == 1 ) onOffDirLightOne = true ; else onOffDirLightOne = false ;
  if(valueButtonGlobal[9] == 1 ) onOffDirLightTwo = true ; else onOffDirLightTwo = false ;
  if(valueButtonGlobal[10] == 1 ) onOffLightAmbient = true ; else onOffLightAmbient = false ;
  // light move light on/off
  if(valueButtonGlobal[11] == 1 ) onOffDirLightOneAction = true ; else onOffDirLightOneAction = false ;
  if(valueButtonGlobal[12] == 1 ) onOffDirLightTwoAction = true ; else onOffDirLightTwoAction = false ;
  if(valueButtonGlobal[13] == 1 ) onOffLightAmbientAction = true ; else onOffLightAmbientAction = false ;
  
  // list choice
   whichShader = valueButtonGlobal[14] ;
  choiceFont(valueButtonGlobal[5]) ;
  whichImage[0] = valueButtonGlobal[15] ;
  whichText[0] = valueButtonGlobal[16] ;
  
  //OBJECTS
  for ( int i = 0 ; i < numObj-1 ; i++) {
    int iPlusOne = i+1 ;
    objectButton   [iPlusOne] = valueButtonObj[i *10 +1] ;
    parameterButton[iPlusOne] = valueButtonObj[i *10 +2] ;
    soundButton    [iPlusOne] = valueButtonObj[i *10 +3] ;
    actionButton   [iPlusOne] = valueButtonObj[i *10 +4] ;
    mode     [iPlusOne] = valueButtonObj[i *10 +9] ;
    if (objectButton[iPlusOne] == 1 ) show_object[iPlusOne] = true ; else show_object[iPlusOne] = false ;
    if (parameterButton[iPlusOne] == 1 ) parameter[iPlusOne] = true ; else parameter[iPlusOne] = false ;
    if (soundButton[iPlusOne] == 1 ) sound[iPlusOne] = true ; else sound[iPlusOne] = false ;
    if (actionButton[iPlusOne] == 1 ) action[iPlusOne] = true ; else action[iPlusOne] = false ;
  }

}

// END OSC RECEIVE
///////////////////
ObjectRomanescoManager romanescoManager ;
// CLASS ROMANESCO MANAGER
public void romanescoSetup() {
  romanescoManager = new ObjectRomanescoManager(this);
  romanescoManager.addObjectRomanesco() ;
  romanescoManager.finishIndex() ;
  romanescoManager.writeInfoUser() ;
}


//Update the var of the object
public void updateObject(int ID, int group) {
  //initialization
  if(!initValueMouse[ID]) { 
    mouse[ID] = mouse[0].copy() ;
    pen[ID] = pen[0].copy() ;
    initValueMouse[ID] = true ;
  }
  if(!initValueControleur[ID]) {
    font[ID] = font[0] ;
    updateSliderValue(ID,group ) ;
    initValueControleur[ID] = true ;
    whichImage[ID] = whichImage[0] ;
    whichText[ID] = whichText[0] ;
  }
  
  // info
  objectInfoDisplay[ID] = displayInfo?true:false ;
  
  
  if(parameter[ID]) {
    whichImage[ID] = whichImage[0] ;
    whichText[ID] = whichText[0] ;
    font[ID] = font[0] ;
    updateSliderValue(ID,group ) ;
  }
  updateSound(ID) ;
  
  if(action[ID] ){
    if(spaceTouch) {
      pen[ID] = pen[0].copy() ;
      mouse[ID] = mouse[0].copy() ;
    }
    if (mTouch) motion[ID] = !motion[ID] ;
    if (hTouch) horizon[ID] = !horizon[ID] ;
    if (rTouch) reverse[ID] = !reverse[ID] ;
    /*
    clickLongLeft[ID] = clickLongLeft[0] ;
    clickLongRight[ID] = clickLongRight[0] ;
    */
    clickLongLeft[ID] = ORDER_ONE ;
    clickLongRight[ID] = ORDER_TWO ;
    clickShortLeft[ID] = clickShortLeft[0] ;
    clickShortRight[ID] = clickShortRight[0] ;
  }
}




//
public void updateSliderValue(int ID, int group) {
  for ( int i = 0 ; i <= NUM_GROUP ; i++) if( group == i ) {
    int which_group = i-1 ;
    if(fullRendering) {
      /**
      Changer : le fill et le stroke doivent se calculer sur des valeurs s\u00e9par\u00e9e, hue, sat, bright and alpha, sinon quand on les change cela change tout d'une seul coup.
      */
      // fill obj
      if      ( !firstOpeningObj[ID] ) fillObj[ID]                                          = color ( fill_hue_raw[which_group], fill_sat_raw[which_group],  fill_bright_raw[which_group], fill_alpha_raw[which_group]) ; 
      else if ( fill_hue_temp[which_group] != fill_hue_raw[which_group] ) fillObj[ID]       = color ( fill_hue_raw[which_group], saturation(fillObj[ID]),    brightness(fillObj[ID]),      alpha(fillObj[ID])) ;
      else if ( fill_sat_temp[which_group] != fill_sat_raw[which_group] ) fillObj[ID]       = color ( hue(fillObj[ID]),          fill_sat_raw[which_group],  brightness(fillObj[ID]),      alpha(fillObj[ID])) ; 
      else if ( fill_bright_temp[which_group] != fill_bright_raw[which_group] ) fillObj[ID] = color ( hue(fillObj[ID]),          saturation(fillObj[ID]),    fill_bright_raw[which_group], alpha(fillObj[ID])) ;   
      else if( fill_alpha_temp[which_group] != fill_alpha_raw[which_group] ) fillObj[ID]    = color ( hue(fillObj[ID]),          saturation(fillObj[ID]),    brightness(fillObj[ID]),      fill_alpha_raw[which_group]) ;  
      // stroke obj
      if      ( !firstOpeningObj[ID] ) strokeObj[ID]                                          = color ( stroke_hue_raw[which_group], stroke_sat_raw[which_group],  stroke_bright_raw[which_group], stroke_alpha_raw[which_group]) ; 
      else if ( stroke_hue_temp[which_group] != stroke_hue_raw[which_group] ) strokeObj[ID]       = color ( stroke_hue_raw[which_group], saturation(strokeObj[ID]),    brightness(strokeObj[ID]),      alpha(strokeObj[ID])) ;
      else if ( stroke_sat_temp[which_group] != stroke_sat_raw[which_group] ) strokeObj[ID]       = color ( hue(strokeObj[ID]),          stroke_sat_raw[which_group],  brightness(strokeObj[ID]),      alpha(strokeObj[ID])) ; 
      else if ( stroke_bright_temp[which_group] != stroke_bright_raw[which_group] ) strokeObj[ID] = color ( hue(strokeObj[ID]),          saturation(strokeObj[ID]),    stroke_bright_raw[which_group], alpha(strokeObj[ID])) ;   
      else if( stroke_alpha_temp[which_group] != stroke_alpha_raw[which_group] ) strokeObj[ID]    = color ( hue(strokeObj[ID]),          saturation(strokeObj[ID]),    brightness(strokeObj[ID]),      stroke_alpha_raw[which_group]) ;  
      // thickness
      if (thicknessRaw[which_group] != thicknessTemp[which_group] || !firstOpeningObj[ID]) thicknessObj[ID] = thicknessRaw[which_group] ;
    } else {
      // preview display
      fillObj[ID] = COLOR_FILL_OBJ_PREVIEW ;
      strokeObj[ID] =  COLOR_STROKE_OBJ_PREVIEW ;
      thicknessObj[ID] = THICKNESS_OBJ_PREVIEW ;
    }
    // column 2
    if (sizeXRaw[which_group] != sizeXTemp[which_group] || !firstOpeningObj[ID]) sizeXObj[ID] = sizeXRaw[which_group] ; 
    if (sizeYRaw[which_group] != sizeYTemp[which_group] || !firstOpeningObj[ID]) sizeYObj[ID] = sizeYRaw[which_group] ; 
    if (sizeZRaw[which_group] != sizeZTemp[which_group] || !firstOpeningObj[ID]) sizeZObj[ID] = sizeZRaw[which_group] ;
    if (canvasXRaw[which_group] != canvasXTemp[which_group] || !firstOpeningObj[ID]) canvasXObj[ID] = canvasXRaw[which_group] ; 
    if (canvasYRaw[which_group] != canvasYTemp[which_group] || !firstOpeningObj[ID]) canvasYObj[ID] = canvasYRaw[which_group] ; 
    if (canvasZRaw[which_group] != canvasZTemp[which_group] || !firstOpeningObj[ID]) canvasZObj[ID] = canvasZRaw[which_group] ;
    if (familyRaw[which_group] != familyTemp[which_group] || !firstOpeningObj[ID]) familyObj[ID] = familyRaw[which_group] ;
    if (quantityRaw[which_group] != quantityTemp[which_group] || !firstOpeningObj[ID]) quantityObj[ID] = quantityRaw[which_group] ;
    if (lifeRaw[which_group] != lifeTemp[which_group] || !firstOpeningObj[ID]) lifeObj[ID] = lifeRaw[which_group] ;
    //column 3
    if (speedRaw[which_group] != speedTemp[which_group] || !firstOpeningObj[ID]) speedObj[ID] = speedRaw[which_group] ;
    if (directionRaw[which_group] != directionTemp[which_group] || !firstOpeningObj[ID]) directionObj[ID] = directionRaw[which_group] ;
    if (angleRaw[which_group] != angleTemp[which_group] || !firstOpeningObj[ID]) angleObj[ID] = angleRaw[which_group] ;
    if (amplitudeRaw[which_group] != amplitudeTemp[which_group] || !firstOpeningObj[ID]) amplitudeObj[ID] = amplitudeRaw[which_group] ;
    if (attractionRaw[which_group] != attractionTemp[which_group] || !firstOpeningObj[ID]) attractionObj[ID] = attractionRaw[which_group] ;
    if (repulsionRaw[which_group] != repulsionTemp[which_group] || !firstOpeningObj[ID]) repulsionObj[ID] = repulsionRaw[which_group] ;
    if (alignmentRaw[which_group] != alignmentTemp[which_group] || !firstOpeningObj[ID]) alignmentObj[ID] = alignmentRaw[which_group] ;
    if (influenceRaw[which_group] != influenceTemp[which_group] || !firstOpeningObj[ID]) influenceObj[ID] = influenceRaw[which_group] ;
    if (analyzeRaw[which_group] != analyzeTemp[which_group] || !firstOpeningObj[ID]) analyzeObj[ID] = analyzeRaw[which_group] ; 

    //future slider ???
    if (fontSizeRaw[which_group] != fontSizeTemp[which_group] || !firstOpeningObj[ID]) fontSizeObj[ID] = fontSizeRaw[which_group] ;
  }
  /** 
  make the obj has be never update in the future except by the moving slider 
  */
  firstOpeningObj[ID] = true ; 

}





//
public void updateSound(int ID) {
  if(sound[ID]) {
    left[ID]  = left[0] ;// value(0,1)
    right[ID] = right[0] ;//float value(0,1)
    mix[ID]  = mix[0] ;//   is average volume between the left and the right / float value(0,1)
    
    beat[ID] = beat[0] ;//    is beat : value 1,10 
    kick[ID] = kick[0] ;//   is beat kick : value 1,10 
    snare[ID] = snare [0] ;//   is beat snare : value 1,10 
    hat[ID]  = hat[0] ;//   is beat hat : value 1,10 

    tempo[ID]   = tempo[0] ;     // global speed of track  / float value(0,1)
    tempoBeat[ID] = tempoBeat[0] ;  // speed of track calculate on the beat
    tempoKick[ID] = tempoKick[0] ; // speed of track calculate on the kick
    tempoSnare[ID] = tempoSnare[0] ;// speed of track calculate on the snare
    tempoHat[ID] = tempoHat[0] ;// speed of track calculte on the hat
    
    for (int i = 0 ; i <NUM_BANDS ; i++) {
      band[ID][i] = band[0][i] ;
    }
  } else {
    left[ID]  = 1 ;// value(0,1)
    right[ID] = 1 ;//float value(0,1)
    mix[ID]  = 1 ;//   is average volume between the left and the right / float value(0,1)
    
    beat[ID] = 1 ;//    is beat : value 1,10 
    kick[ID] = 1 ;//   is beat kick : value 1,10 
    snare[ID] = 1 ;//   is beat snare : value 1,10 
    hat[ID]  = 1 ;//   is beat hat : value 1,10 
    
    tempo[ID]   = 1 ;     // global speed of track  / float value(0,1)
    tempoBeat[ID] = 1 ;  // speed of track calculate on the beat
    tempoKick[ID] = 1 ; // speed of track calculate on the kick
    tempoSnare[ID] = 1 ;// speed of track calculate on the snare
    tempoHat[ID] = 1 ;// speed of track calculte on the hat
    
    for (int i = 0 ; i <NUM_BANDS ; i++) {
      band[ID][i] = 1 ;
    }
  }
}


// RESET list and Object
// by action
public boolean resetAction(int ID) {
  boolean e = false ;
  //global delete
  if (backspaceTouch) e = true ;
  //SPECIFIC DELETE when the paramer button of contr\u00f4leur is ON
  else if (deleteTouch) if ( action[ID]) e = true ;
  return e ;
}
// by parameter
public boolean resetParameter(int ID) {
  boolean e = false ;
  //global delete
  if (backspaceTouch) e = true ;
  //SPECIFIC DELETE when the paramer button of contr\u00f4leur is ON
  else if (deleteTouch) if (parameter[ID]) e = true ;
  return e ;
}
///////////////////////////////////////




//CLASS
// inspired from Andreas Gysin work from The Abyss Project
class ObjectRomanescoManager {
  private ArrayList<Romanesco>RomanescoList ;
  private ArrayList<Class>objectRomanescoList;
  
  PApplet parent;
  String objectNameRomanesco [] ;
  String classRomanescoName [] ;
  int numClasses ;
  
  ObjectRomanescoManager(PApplet parent) {
    this.parent = parent;
    RomanescoList = new ArrayList<Romanesco>() ;
    //scan the existant classes
    objectRomanescoList = scanClasses(parent, "Romanesco");
  }
  
  //STEP ONE
  //ADD CLASSES
  private ArrayList<Class> scanClasses(PApplet parent, String superClassName) {
    ArrayList<Class> classes = new ArrayList<Class>();

    Class[] c = parent.getClass().getDeclaredClasses();
    
    //create the index table
    for (int i=0; i<c.length; i++) {
      if (c[i].getSuperclass() != null && c[i].getSuperclass().getSimpleName().equals(superClassName) ) {
        classes.add(c[i]);
        numClasses = classes.size() ;
      }
    }
    createIndex(numClasses) ;
    
    //init the String info
    objectNameRomanesco = new String[numClasses] ;
    for ( int i =0 ; i <objectNameRomanesco.length ; i++) objectNameRomanesco[i] =("") ;
    
    //add class in Romanesco, plus add info in the String for the index
    int numObjectRomanesco = 0 ;
    for (int i=0; i<c.length; i++) {
      if (c[i].getSuperclass() != null && c[i].getSuperclass().getSimpleName().equals(superClassName) ) {
        objectNameRomanesco[numObjectRomanesco] = c[i].getSimpleName() ;
        numObjectRomanesco += 1 ;
      }
    }
    beginIndex() ;
    
    
    return classes;  
  }
  //END ADD CLASSES
  /////////////////
  
  
  
  //////////////////////////////////////
  // INDEX and INFO OBJECT FROM CLASSES
  String pathObjects = preferencesPath+"objects/" ;
  
  ////////////////
  // INTERN VOID
  //create the canvas index
  public void createIndex(int num) {
    indexObjects = new Table() ;
    indexObjects.addColumn("Library Order") ;
    indexObjects.addColumn("Name") ;
    indexObjects.addColumn("ID") ;
    indexObjects.addColumn("Group") ;
    indexObjects.addColumn("Version") ;
    indexObjects.addColumn("Author") ;
    indexObjects.addColumn("Class name") ;
    indexObjects.addColumn("Pack") ;
    indexObjects.addColumn("Render") ;
    indexObjects.addColumn("Mode") ;
    
    
    // add row
    rowIndexObject = new TableRow [num] ;
    for(int i = 0 ; i < rowIndexObject.length ; i++) {
      rowIndexObject[i] = indexObjects.addRow() ;
    }
    
    // create var for info object, need to be create here
    int numPlusOne = num + 1 ;
    objectID = new int[numPlusOne] ;
    objectName = new String[numPlusOne] ;
    objectAuthor = new String[numPlusOne] ;
    objectVersion = new String[numPlusOne] ;
    objectPack = new String[numPlusOne] ;
    objectInfo = new String[numPlusOne] ;
    // init var
    for ( int i = 0 ; i<numPlusOne ; i++ ) {
      objectName [i] = "My name is Nobody" ;
      objectInfo [i] = "Sorry nobody write about me !" ;
      objectID [i] = 0 ;
    }
    
    
    
  }
  
  // put information in the index
  public void beginIndex() {
    for(int i = 0 ; i < rowIndexObject.length ; i++) {
      rowIndexObject[i].setString("Class name", objectNameRomanesco[i]) ;
      rowIndexObject[i].setInt("Library Order", i+1) ;
    }
  }
  

  
  
  
  ////////////////
  /**
  EXTERNAL  VOID
  * romanescoManager.finishIndex() ;
  * use with in romanescoSetup() {}
  */
  //finish index
  public void finishIndex() {
      // catch the different parameter from object class Romanesco
    for (int i=0 ; i < RomanescoList.size() ; i++ ) {
      Romanesco objR = (Romanesco) RomanescoList.get(i) ;
      rowIndexObject[i].setString("Name", objR.romanescoName) ;
      rowIndexObject[i].setInt("ID", objR.IDobj) ;
      rowIndexObject[i].setInt("Group", objR.IDgroup) ;
      rowIndexObject[i].setString("Author", objR.romanescoAuthor) ;
      rowIndexObject[i].setString("Version", objR.romanescoVersion) ;
      rowIndexObject[i].setString("Render", objR.romanescoRender) ;
      rowIndexObject[i].setString("Pack", objR.romanescoPack) ;
      rowIndexObject[i].setString("Mode", objR.romanescoMode) ;
      rowIndexObject[i].setString("Slider", objR.romanescoSlider) ;
    }
    saveTable(indexObjects, pathObjects+"index_romanesco_objects.csv") ; 
    NUM_OBJ = RomanescoList.size() ;
  }
  
  /*
  * romanescoManager.writeInfoUser() ;
  * use with in romanescoSetup() {}
  */
  //ADD info for the user
  public void writeInfoUser() {
      // catch the different parameter from object class Romanesco
    for (int i=0 ; i < RomanescoList.size() ; i++ ) {
      Romanesco objR = (Romanesco) RomanescoList.get(i) ;
      objectID[objR.IDobj] = objR.IDobj ;
      objectName[objR.IDobj] = objR.romanescoName ;
      objectAuthor[objR.IDobj] = objR.romanescoAuthor ;
      objectVersion[objR.IDobj] = objR.romanescoVersion ;
      objectPack[objR.IDobj] = objR.romanescoPack ;
    }
  }
    
  
  //END of the INDEX
  //////////////////
  
  
  
  
  
  
  
  /////////////////////////////////
  //ADD OBJECT from the sub-classes
  public void addObjectRomanesco() {
    int n = floor(objectRomanescoList.size()-1) ;
    for( int i = 0 ; i <= n ; i++) {
    addObject(i) ;
    }
  }
  //
  public Romanesco addObject(int i) {
    if (i < 0 || i >= objectRomanescoList.size()) return null;
    
    Romanesco f = null;
    try {
      Class c = objectRomanescoList.get(i);
      Constructor[] constructors = c.getConstructors();
      f = (Romanesco) constructors[0].newInstance(parent);
    }
    catch (InvocationTargetException e) {
      System.out.println(e);
    } 
    catch (InstantiationException e) {
      System.out.println(e);
    } 
    catch (IllegalAccessException e) {
      System.out.println(e);
    } 
    //add object 
    if (f != null) {
      addObject(f);
    }
    return f;
  }
  
  // finalization of adding object
  private void addObject(Romanesco objR) {
    objR.setManagerReference(this);
    RomanescoList.add(objR);
  }
  //END ADD OBJECT
  ////////////////
  
  
  
  ////////
  //SETUP
  // INIT ROMANESCO OBJECT
  public void initObj() {
    for (Romanesco objR : RomanescoList) {
      motion[objR.IDobj] = true ;
      initValueMouse[objR.IDobj] = true ;
      objR.setting() ;
      posObjRef[objR.IDobj] = startingPosition[objR.IDobj].copy() ;
    }
  }
  

  // END SETUP
  ////////////
  
  
  
  ////////
  // DRAW
  public void displayObject(boolean movePos, boolean moveDir, boolean movePosAndDir) {
    // when you use the third order Romanesco understand the the first and the second are true
    if(movePosAndDir) {
      moveDir = true ;
      movePos = true ;
    }
    
    //the method
    if (show_object != null) {
      for (Romanesco objR : RomanescoList) {
        if (show_object[objR.IDobj]) {
          updateObject(objR.IDobj, objR.IDgroup) ;
          pushMatrix() ;
          addRefObj(objR.IDobj) ;
          if(vLongTouch && action[objR.IDobj] ) objectMove(movePos, moveDir, objR.IDobj) ;
          P3DmoveObj(objR.IDobj) ;
          objR.display() ;
          popMatrix() ;
        }
      }
    }
  }
  // END DRAW
  //////////
}
//END OBJECT ROMANESCO MANAGER












////////////////////////
//SUPER CLASS ROMANESCO
abstract class Romanesco {
  String romanescoName, romanescoAuthor, romanescoVersion, romanescoPack, romanescoRender, romanescoMode, romanescoSlider ;
  int IDobj, IDgroup ;
  //object manager return
  ObjectRomanescoManager orm ;
  
  public Romanesco() {
    romanescoName = "Unknown" ;
    romanescoAuthor = "Anonymous";
    romanescoVersion = "Alpha";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
    romanescoMode = "" ; // separate the name by a slash and write the next mode immadialtly after this one.
    romanescoSlider = "all" ;
    IDgroup = 0 ;
    IDobj = 0 ;
  }
  
  //manager return
  public void setManagerReference(ObjectRomanescoManager orm) {
    this.orm = orm;
  }
  
  //IMPORTANT
  //declared the void use in the sub-classes here
  public abstract void setting();
  public abstract void display();
}
// END SUPER ROMANESCO
///////////////////////
//GLOBAL
//////////////////////////////MINIM///////////////////////////////////
//GLOBAL PARAMETER Minim
Minim minim;
AudioInput input; // music from outside
// spectrum
FFT fft; 

//beat
BeatDetect beatEnergy, beatFrequency;
BeatListener bl;


float beatData, kickData, snareData, hatData ;
float minBeat = 1.0f ;
float maxBeat = 10.0f  ;

//volume
int right_volume_info = 0 ;
int left_volume_info = 0 ;


//////////////
// SOUND SETUP
public void soundSetup() {
  //Sound
  minim = new Minim(this);
  //sound from outside
  minim.debugOn();
  input = minim.getLineIn(Minim.STEREO, 512);
  
  spectrumSetup(NUM_BANDS) ;
  beatSetup() ;
}
// END SOUND SETUP
//////////////////




/////////////
// SOUND DRAW
public void soundDraw() {
  spectrum(input.mix, NUM_BANDS) ;
  beatEnergy.detect(input.mix);
  initTempo() ;
  soundRomanesco() ;
  right_volume_info = PApplet.parseInt(input.right.get(1)  *100) ; 
  left_volume_info = PApplet.parseInt(input.left.get(1)  *100) ;
}
// END SOUND DRAW
/////////////////






//specific stuff from romanesco
//////////////////////////////
public void soundRomanesco() {
  int sound = 1 ;
    
  float volumeControleurG = map(valueSlider[0][4], 0,MAX_VALUE_SLIDER, 0, 1.3f ) ;
  left[0] = map(input.left.get(sound),  -0.07f,0.1f,  0, volumeControleurG);
  
  float volumeControleurD = map(valueSlider[0][5], 0,MAX_VALUE_SLIDER, 0, 1.3f ) ;
  right[0] = map(input.right.get(sound),  -0.07f,0.1f,  0, volumeControleurD);
  
  float volumeControleurM = map(( (valueSlider[0][4] + valueSlider[0][5]) *.5f), 0,MAX_VALUE_SLIDER, 0, 1.3f ) ;
  mix[0] = map(input.mix.get(sound),  -0.07f,0.1f,  0, volumeControleurM);
  
  //volume
  if(left[0] < 0 ) left[0] = 0 ;
  if(left[0] > 1 ) left[0] = 1.0f ; 
  if(right[0] < 0 ) right[0] = 0 ;
  if(right[0] > 1 ) right[0] = 1.0f ; 
  if(mix[0] < 0 ) mix[0] = 0 ;
  if(mix[0] > 1 ) mix[0] = 1.0f ;
  
  //Beat
  beat[0] = getBeat(onOffBeat) ;
  kick[0] = getKick(onOffKick) ;
  snare[0] = getSnare(onOffSnare) ;
  hat[0] = getHat(onOffHat) ;
  
  
  //spectrum
  for ( int i = 0 ; i < NUM_BANDS ; i++ ) {
    band[0][i] = bandSprectrum[i] ;
  }
  
  //tempo
  tempo[0] = getTempoRef() ;
  tempoKick[0] = getTempoKickRef() ;
  tempoSnare[0] = getTempoSnareRef() ;
  tempoHat[0] = getTempoHatRef() ;
}
  



//////
//BEAT
//GLOBAL
int beatNum, kickNum, snareNum, hatNum ;
//setup
public void beatSetup() {
  //Beat Frequency
  beatFrequency = new BeatDetect(input.bufferSize(), input.sampleRate());
  beatFrequency.setSensitivity(300);
  kickData = snareData = hatData = minBeat; 
  bl = new BeatListener(beatFrequency, input); 
  
  //Beat energy
  beatEnergy = new BeatDetect();
  beatData = 1.0f ;
}
//RETURN
//BEAT QUANTITY
public int getBeatNum() {
  if ( beatEnergy.isOnset() ) beatNum += 1 ; else if (  getTotalSpectrum(NUM_BANDS) < 0.03f ) beatNum = 0 ;
  return beatNum ;
}
public int getKickNum() {
  if ( beatFrequency.isKick()  ) kickNum += 1 ; else if (  getTotalSpectrum(NUM_BANDS) < 0.03f ) kickNum = 0 ;
  return kickNum ;
}
public int getSnareNum() {
  if ( beatFrequency.isSnare()  ) snareNum += 1 ; else if (  getTotalSpectrum(NUM_BANDS) < 0.03f ) snareNum = 0 ;
  return snareNum ;
}
public int getHatNum() {
  if ( beatFrequency.isHat()  ) hatNum += 1 ; else if (  getTotalSpectrum(NUM_BANDS) < 0.03f ) hatNum = 0 ;
  return hatNum ;
}

//RESULT
public float getBeat(boolean beat) {
  if (beat) {
    if ( beatEnergy.isOnset() ) beatData = maxBeat;
    beatData *= 0.95f;
    if ( beatData < minBeat ) beatData = minBeat;
  } else beatData = 1.0f ;
  
  return beatData ;
}

public float getKick(boolean kick) {
  if (kick) {
    if ( beatFrequency.isKick() )  kickData = maxBeat;
    kickData = constrain(kickData * 0.95f, minBeat, maxBeat);
  } else kickData = 1.0f ;
  //
  return kickData ;
}

public float getSnare(boolean snare) {
  if (snare) {
    if ( beatFrequency.isSnare() )  snareData = maxBeat;
    snareData = constrain(snareData * 0.95f, minBeat, maxBeat);
  } else snareData = 1.0f ;
  //
  return snareData ;
}

public float getHat(boolean hat) {
  if (hat) {
    if ( beatFrequency.isHat() )  hatData = maxBeat;
    hatData = constrain(hatData * 0.95f, minBeat, maxBeat);
  } else hatData = 1.0f ;
  //
  return hatData ;
}
//END BEAT
/////////







///////
//TEMPO
float tempoMin = 0.01f ;
float tempoMax = 1.0f ;
int maxSpecific = 1 ;

// float tempoBeat = 0.005 ;
float mesure ; 
boolean refresh = false ;

//Direct Specific Analyze
//GLOBAL

float tempoBeatRef = 1 ;
float tempoKickRef = 1 ; 
float tempoSnareRef = 1 ; 
float tempoHatRef = 1 ; // for Beat, Kick, Snare, Hat
float tempoB, tempoK,  tempoS,  tempoH  ;
float tempoBeatAdd  = 0.005f ;
float tempoKickAdd  = 0.005f ;
float tempoSnareAdd = 0.005f ;
float tempoHatAdd   = 0.005f ;
//RETURN



//INITIALIZATION

public void initTempo() {
  // this weird float who's not used must be here, we must work around !
  float init = getTempoBeat() + getTempoKick()  + getTempoHat() + getTempoSnare() ;
}


//return global tempo
public float getTempoRef() {
  // I remove the snare because is very bad information and slow down the the speed
  float tempoRef = 1 - (getTempoBeatRef() + getTempoKickRef()  + getTempoHatRef() ) *.33f ;
  return tempoRef ;
}
//get tempo
public float getTempo() {
  // I remove the snare because is very bad information and slow down the the speed
  float tempo = (getTempoBeat() + getTempoKick()  + getTempoHat() ) *.33f ;
  return tempo ;
}
// return direct BEAT
public float getTempoBeat() {
  if ( beatEnergy.isOnset()  ) {
    if( tempoB != 0 ) tempoBeatRef = tempoB ;
    tempoB = 0 ; 
  } else {
    tempoB += tempoBeatAdd  ;
  }
  return tempoB ;
}
public float getTempoBeatRef() {
  if (tempoBeatRef > maxSpecific || getTotalSpectrum(NUM_BANDS) < 0.03f  ) tempoBeatRef = maxSpecific  ; 
  return  tempoBeatRef ;
}


// return direct KICK
public float getTempoKick() {
  if ( beatFrequency.isKick()  ) {
    if( tempoK != 0 ) tempoKickRef = tempoK ;
    tempoK = 0 ; 
  } else {
    tempoK += tempoKickAdd  ;
  }
  return tempoK ;
}
public float getTempoKickRef() {
  if (tempoKickRef > maxSpecific || getTotalSpectrum(NUM_BANDS) < 0.03f  ) tempoKickRef = maxSpecific  ; 
  return  tempoKickRef ;
}

// return direct SNARE
public float getTempoSnare() {
  if ( beatFrequency.isSnare()  ) {
    if( tempoS != 0 ) tempoSnareRef = tempoS ;
    tempoS = 0 ; 
  } else {
    tempoS += tempoSnareAdd  ;
  }
  return tempoS ;
}
public float getTempoSnareRef() {
  if (tempoSnareRef > maxSpecific || getTotalSpectrum(NUM_BANDS) < 0.03f  ) tempoSnareRef = maxSpecific  ; 
  return  tempoSnareRef ;
}

// return direct Hat
public float getTempoHat() {
  if ( beatFrequency.isHat()  ) {
    if( tempoH != 0 ) tempoHatRef = tempoH ;
    tempoH = 0 ; 
  } else {
    tempoH += tempoHatAdd  ;
  }
  return tempoH ;
}
public float getTempoHatRef() {
  if (tempoHatRef > maxSpecific || getTotalSpectrum(NUM_BANDS) < 0.03f  ) tempoHatRef = maxSpecific  ; 
  return  tempoHatRef ;
}




//Average Analyze
//GLOBAL
float tempoAverage, tempoAverageRef  ;
float tempoBeatAverage = 0.05f ;
//RETURN
public float tempoAverageRef() {
  //regulation du tempo
  if ( mesure == 0 && !refresh ) {
    tempoAverageRef = tempoAverage()  ;
    tempoAverage = 0.01f ;
    refresh = true ;
  }
  if ( mesure != 0 ) refresh = false ;
  
  return tempoAverageRef ;
}


public float tempoAverage() {
  mesure = second()%2 ;
  
  if ( beatEnergy.isOnset() || beatFrequency.isKick() || beatFrequency.isSnare() || beatFrequency.isHat()  )  tempoAverage += tempoBeatAverage  ;
  if ( tempoAverage > 1.0f ) tempoAverage = 1.0f ;
  
  //regulation du tempo
  if ( mesure == 0 && !refresh ) {
    tempoAverageRef = tempoAverage  ;
    tempoAverage = 0.01f ;
    refresh = true ;
  }
  
  if ( mesure != 0 ) refresh = false ;
  
  return tempoAverage ;
}

//END TEMPO
//////////


//TIME TRACK
////////////
//GLOBAL
int timeTrack  ;
//RETURN
public float getTimeTrack() {
  float t ; 
  timeTrack += millis() % 10 ;
  t = timeTrack *.01f ;
  if ( getTotalSpectrum(NUM_BANDS) < 0.1f ) timeTrack = 0 ;
  return round( t * 10.0f ) / 10.0f; 
}
////////////////
//END TIME TRACK


//SPECTRUM
//////////
//SPECTRUM
//info text band
float [] bandSprectrum  ;
//SETUP
public void spectrumSetup(int n) {
  //spectrum
  bandSprectrum = new float [n] ;
  fft = new FFT(input.bufferSize(), input.sampleRate());
  fft.linAverages(n);
}

//DRAW
//just create spectrum
public void spectrum(AudioBuffer fftData, int n) {
  fft.forward(fftData) ;
  for(int i = 0; i < n ; i++)
  {
    fft.scaleBand(i, 0.5f ) ;
    bandSprectrum[i] = fft.getBand(i) ;
  }
}

//ANNEXE VOID
public float getTotalSpectrum(int NUM_BANDS) {
  float t = 0 ;
  if (bandSprectrum != null ) {
   for ( int i = 0 ; i < NUM_BANDS ; i++ ) {
     //  if(bandSprectrum[i] != null ) t += bandSprectrum[i] ;
      t += bandSprectrum[i] ;
    }
  }
  return t ;
}
//END SPECTRUM
//////////////





//CLASS to use the beat analyze
class BeatListener implements AudioListener {
  private BeatDetect beatFrequency;
  private AudioInput source;
  
  BeatListener(BeatDetect beatFrequency, AudioInput source) {
    this.source = source;
    this.source.addListener(this);
    this.beatFrequency = beatFrequency;
  }
  
  public void samples(float[] samps) {
    beatFrequency.detect(source.mix);
  }
  
  public void samples(float[] sampsL, float[] sampsR) {
    beatFrequency.detect(source.mix);
  }
}



//END MINIM
public void stop() {
  input.close() ;
  minim.stop() ;
  super.stop() ;
}
//////
//END
// Z VAR ///////////////////////
// GLOBAL SETTING ////






 






//FLUX RSS or TWITTER ????


//SOUND


//GEOMERATIVE

//TOXIC





// METEO


//CALLING class or library in Other Class, you must call the PApplet too in your class
PApplet callingClass = this ;
// use for the border of window (top and right)
java.awt.Insets insets; 

// framerate of the scene
int frameRateRomanesco ;



// Max value whi is return from the slider controller
int MAX_VALUE_SLIDER = 360 ;
// num obj count in Romanesco Manager
int NUM_OBJ ;



boolean videoSignal = false ;
//variable for the tracking
boolean nextPrevious = false ;
int nextPreviousInt = 0 ; // for send to Syphon
int trackerUpdate ; // must be reset after each use
//spectrum for the color mode and more if you need
Vec4 HSBmode = new Vec4 (360,100,100,100) ; // give the color mode in HSB
//path to open the controleur
String findPath ; 



// MOUSE DETECTION
// return if the cursor (mouse) is in the sketch or not
boolean MOUSE_IN_OUT = true ;





// COMMAND BOOLEAN
//BOOLEAN COMMAND
/* command from leap motion, mouse or other devices if we code for that :) */
boolean ORDER, ORDER_ONE, ORDER_TWO, ORDER_THREE ;
boolean LEAPMOTION_DETECTED ;



// SAVE
boolean load_SCENE_Setting_GLOBAL, save_Current_SCENE_Setting_GLOBAL, save_New_SCENE_Setting_GLOBAL ;




// HIGH VAR
boolean modeP3D, modeP2D, modeOPENGL, modeClassic ;
//spectrum band
int NUM_BANDS = 16 ;
//font
int numFont = 50 ;
//quantity of group object slider
int NUM_GROUP = 2 ;

int NUM_SLIDER_MISC = 30 ;
int NUM_SLIDER_OBJ = 30 ;

int numButtonGlobal = 21 ; // group zero
int numButtonObj  ; // group one, two and three

// VAR obj
int COLOR_FILL_OBJ_PREVIEW  ; 
int COLOR_STROKE_OBJ_PREVIEW ;
int THICKNESS_OBJ_PREVIEW = 2 ;
int numObj ;
Table indexObjects ;
TableRow [] rowIndexObject ;
//MISC var
//info object
String [] objectInfo, objectName, objectAuthor, objectVersion, objectPack ;
int [] objectID ;
boolean [] objectInfoDisplay ;
//for the leap motion ?
int objectLeapID[] ;
//BUTTON CONTROLER
boolean objectParameter[] ;

//VAR object
//raw
int [] fill_hue_raw, fill_sat_raw, fill_bright_raw, fill_alpha_raw ;
int [] stroke_hue_raw, stroke_sat_raw, stroke_bright_raw, stroke_alpha_raw ;
float [] thicknessRaw ; 
float [] sizeXRaw, sizeYRaw, sizeZRaw, canvasXRaw, canvasYRaw, canvasZRaw ;
float [] familyRaw, quantityRaw, lifeRaw ;
float [] speedRaw ;
float [] directionRaw, angleRaw ;
float [] amplitudeRaw, attractionRaw, repulsionRaw ;
float [] alignmentRaw, influenceRaw, analyzeRaw ;
/* used in this time with sizeXObj */
float []fontSizeRaw ;
/*
//add in the next version when there is 30 slider by group
//future slider available now ;
//for the next relase
float [] curveRaw ;
*/

// temp
/* value used to know if the value slider have change or nor */
int [] fill_hue_temp, fill_sat_temp, fill_bright_temp, fill_alpha_temp ;
int [] stroke_hue_temp, stroke_sat_temp, stroke_bright_temp, stroke_alpha_temp ;
float [] thicknessTemp ; 
float [] sizeXTemp, sizeYTemp, sizeZTemp, canvasXTemp, canvasYTemp, canvasZTemp ;
float [] familyTemp, quantityTemp, lifeTemp ;
float [] speedTemp ;
float [] directionTemp, angleTemp ;
float [] amplitudeTemp, attractionTemp, repulsionTemp ;
float [] alignmentTemp, influenceTemp, analyzeTemp ;
/* used in this time with sizeXObj */
float []fontSizeTemp ;
/*
//add in the next version when there is 30 slider by group
//future slider available now ;
//for the next relase
float [] curveTemp ;
*/



//object
boolean [] firstOpeningObj ; // used to check if this object is already opening before
int [] fillObj, strokeObj ;
float [] thicknessObj ; 
float [] sizeXObj, sizeYObj, sizeZObj, canvasXObj, canvasYObj, canvasZObj ;
float [] familyObj, quantityObj, lifeObj ;
float [] speedObj ;
float [] directionObj, angleObj ;
float [] amplitudeObj, attractionObj, repulsionObj ;
float [] alignmentObj, influenceObj, analyzeObj ;
/* used in this time with sizeXObj */
float []fontSizeObj ;
/*
//add in the next version when there is 30 slider by group
//future slider available now ;
//for the next relase
float []curveObj ;
*/

//font
PFont police ;



//OSC VAR
// button
int whichFont ;
// int eBeat, eKick, eSnare, eHat, eCurtain, eBackground ;
boolean onOffBeat, onOffKick, onOffSnare, onOffHat, onOffCurtain, onOffBackground ;
boolean onOffDirLightOne,       onOffDirLightTwo,       onOffLightAmbient,
        onOffDirLightOneAction, onOffDirLightTwoAction, onOffLightAmbientAction ;

// int eLightOne, eLightTwo, eLightAmbient,
 //   eLightOneAction, eLightTwoAction, eLightAmbientAction ;
int whichShader ; 
int [] whichImage, whichText ;
String [] image_path_ref  ;
int [] objectButton,soundButton, actionButton, parameterButton ;
boolean [] show_object, sound, action, parameter ;

int mode[]  ;

//BUTTON
int [] valueButtonGlobal, valueButtonObj  ;

//SLIDER
String valueSliderTemp[][]  = new String [NUM_GROUP+1][NUM_SLIDER_OBJ] ;

// becareful if the number of MISC SLIDERS is upper than OBJ SLIDER, that can be a problem in the future.
float valueSlider[][]  = new float [NUM_GROUP+1][NUM_SLIDER_OBJ] ;


//MISC
//var to init the data of the object when is switch ON for the first time
boolean  [] initValueMouse, initValueControleur ;
//parameter for the super class
float [] left, right, mix ;
//beat
float [] beat, kick, snare, hat ;
// spectrum
float band[][] ;
//tempo
float [] tempo, tempoBeat, tempoKick, tempoSnare, tempoHat ;


//P3D OBJECT
//setting and save
int numSettingCamera = 1 ;
int numSettingOrientationObject = 1 ;
PVector [][] posObjSetting, dirObjSetting ;
PVector [] eyeCameraSetting, sceneCameraSetting ;
//position
PVector startingPosition [] ;
float [] posObjX, posObjY, posObjZ ;

// PVector posObjRef ;
boolean newObjRefPos ;
PVector [] posObj, dirObj, posObjRef ;
//orientation
float [] dirObjX, dirObjY ;
PVector dirObjRef ;
boolean newObjRefDir ;

//position of object and wheel
PVector [] mouse, pen ;
boolean [] clickShortLeft, clickShortRight, clickLongLeft, clickLongRight;
int wheel[] ;
//pen info

//boolean object
boolean [] motion, horizon, setting, reverse, clearList ;

//main font for each object
String [] pathFontTTF, pathFontVLW, pathFontObjTTF ;
PFont font[]  ;



















//init var
public void createVar() {
  numObj = romanescoManager.numClasses + 1 ;
  //BUTTON CONTROLER
  numButtonObj = numObj*10 ;

  createVarButton() ;
  createVarSound() ;
  createVarP3D(numObj, numSettingCamera, numSettingOrientationObject) ;
  createVarCursor() ;
  createVarObject() ;
  createMiscVar() ;
  
  romanescoManager.initObj() ;
}
// misc var
public void createMiscVar() {

    
   objectLeapID = new int[numObj] ;
   
   objectInfoDisplay = new boolean[numObj] ;
    
   setting = new boolean [numObj]  ;
   // boolean clear
   clearList = new boolean[numObj] ;
   motion = new boolean [numObj]  ;
   horizon = new boolean [numObj]  ;
   reverse = new boolean [numObj] ;
   // IMAGE
   img = new PImage[numObj] ;
   whichImage = new int[numObj] ;
   image_path_ref = new String[numObj] ;
   // TEXT
   textImport = new String [numObj] ;
   whichText = new int[numObj] ;
  //main font for each object
   font = new PFont[numObj] ;
   pathFontObjTTF = new String[numObj] ;
   pathFontTTF = new String [numFont] ;  
   pathFontVLW = new String [numFont] ;
   font = new PFont[numFont] ;
   //MISC
   //var to init the data of the object when is switch ON for the first time
   initValueMouse = new boolean [numObj]  ;
   initValueControleur = new boolean [numObj]  ;
}
// var cursor
public void createVarCursor() {
  //position of object and wheel
   mouse  = new PVector[numObj] ;
   clickShortLeft = new boolean [numObj] ;
   clickShortRight = new boolean [numObj] ;
   clickLongLeft = new boolean [numObj] ;
   clickLongRight = new boolean [numObj] ;
   wheel = new int [numObj] ;
  //pen info
   pen = new PVector[numObj] ;
}
// P3D
public void createVarP3D(int numObj, int numSettingCamera, int numSettingOrientationObject) {
   // setting and save
   eyeCameraSetting = new PVector [numSettingCamera] ;
   sceneCameraSetting = new PVector [numSettingCamera] ;

   posObjSetting = new PVector [numSettingOrientationObject] [numObj] ;
   dirObjSetting = new PVector [numSettingOrientationObject] [numObj] ;
   //
   startingPosition = new PVector[numObj] ;
   posObjX = new float[numObj] ;
   posObjY = new float[numObj] ;
   posObjZ = new float[numObj] ;
   
   // orientation
   dirObjX = new float[numObj] ;
   dirObjY = new float[numObj] ;
   posObjRef = new PVector[numObj] ;
   posObj = new PVector[numObj] ;
   dirObj = new PVector[numObj] ;
}

public void createVarSound() {
  // volume 
   left = new float [numObj] ;
   right = new float [numObj] ;
   mix  = new float [numObj] ;
   // beat
   beat  = new float [numObj] ;
   kick  = new float [numObj] ;
   snare  = new float [numObj] ;
   hat  = new float [numObj] ;
   // spectrum
   band = new float [numObj][NUM_BANDS] ;
   // tempo
   tempo = new float [numObj] ;
   tempoBeat = new float [numObj] ;
   tempoKick = new float [numObj] ;
   tempoSnare = new float [numObj] ;
   tempoHat = new float [numObj] ;
}
//

//
public void createVarButton() {
  objectButton = new int [numObj] ;
  soundButton = new int [numObj] ;
  actionButton = new int [numObj] ;
  parameterButton = new int [numObj] ;
  show_object = new boolean [numObj] ;
  sound = new boolean [numObj] ;
  action = new boolean [numObj] ;
  parameter = new boolean [numObj] ;
  mode = new int [numObj] ;
  
  // you must init this var, because we launch this part of code before the controller. And if we don't init the value is NaN and return an error.
  valueButtonGlobal = new int[numButtonGlobal] ;
  valueButtonObj = new int[numObj*10] ;

}

public void createVarObject() {
  // RAW
  fill_hue_raw = new int[NUM_GROUP] ;   fill_sat_raw = new int[NUM_GROUP] ;   fill_bright_raw = new int[NUM_GROUP] ;    fill_alpha_raw = new int[NUM_GROUP] ;
  stroke_hue_raw = new int[NUM_GROUP] ; stroke_sat_raw = new int[NUM_GROUP] ; stroke_bright_raw = new int[NUM_GROUP] ;  stroke_alpha_raw = new int[NUM_GROUP] ;
  thicknessRaw = new float[NUM_GROUP] ;
  sizeXRaw = new float[NUM_GROUP] ;   sizeYRaw = new float[NUM_GROUP] ;    sizeZRaw = new float[NUM_GROUP] ;
  canvasXRaw = new float[NUM_GROUP] ; canvasYRaw = new float[NUM_GROUP] ;  canvasZRaw = new float[NUM_GROUP] ;
  familyRaw = new float[NUM_GROUP] ;  quantityRaw = new float[NUM_GROUP] ; lifeRaw = new float[NUM_GROUP] ;
  speedRaw = new float[NUM_GROUP] ;
  directionRaw = new float[NUM_GROUP] ;
  angleRaw = new float[NUM_GROUP] ;
  amplitudeRaw = new float[NUM_GROUP] ;
  attractionRaw = new float[NUM_GROUP] ;
  repulsionRaw = new float[NUM_GROUP] ;
  alignmentRaw = new float[NUM_GROUP] ;
  influenceRaw = new float[NUM_GROUP] ;
  analyzeRaw = new float[NUM_GROUP] ;
  //future slider
  /* used in this time with the sizeXobj */
  fontSizeRaw = new float[NUM_GROUP] ;
  
  // Temp
  /* used to compare the value slider, to know if the value of the obhject must be updated orn ot */
  fill_hue_temp = new int[NUM_GROUP] ;    fill_sat_temp = new int[NUM_GROUP] ;    fill_bright_temp = new int[NUM_GROUP] ;   fill_alpha_temp = new int[NUM_GROUP] ;
  stroke_hue_temp = new int[NUM_GROUP] ;  stroke_sat_temp = new int[NUM_GROUP] ;  stroke_bright_temp = new int[NUM_GROUP] ; stroke_alpha_temp = new int[NUM_GROUP] ;
  thicknessTemp = new float[NUM_GROUP] ;
  sizeXTemp = new float[NUM_GROUP] ;   sizeYTemp = new float[NUM_GROUP] ;    sizeZTemp = new float[NUM_GROUP] ;
  canvasXTemp = new float[NUM_GROUP] ; canvasYTemp = new float[NUM_GROUP] ;  canvasZTemp = new float[NUM_GROUP] ;
  familyTemp = new float[NUM_GROUP] ;  quantityTemp = new float[NUM_GROUP] ; lifeTemp = new float[NUM_GROUP] ;
  speedTemp = new float[NUM_GROUP] ;
  directionTemp = new float[NUM_GROUP] ;
  angleTemp = new float[NUM_GROUP] ;
  amplitudeTemp = new float[NUM_GROUP] ;
  attractionTemp = new float[NUM_GROUP] ;
  repulsionTemp = new float[NUM_GROUP] ;
  alignmentTemp = new float[NUM_GROUP] ;
  influenceTemp = new float[NUM_GROUP] ;
  analyzeTemp = new float[NUM_GROUP] ;
  //future slider
  /* used in this time with the sizeXobj */
  fontSizeTemp = new float[NUM_GROUP] ;
  
  // VAR object
  firstOpeningObj = new boolean[numObj] ; // used to check if this object is already opening before
  fillObj = new int[numObj] ;
  strokeObj = new int[numObj] ;
  // column 2
  thicknessObj = new float[numObj] ; ;
  sizeXObj = new float[numObj] ; sizeYObj = new float[numObj] ; sizeZObj = new float[numObj] ;
  canvasXObj = new float[numObj] ; canvasYObj = new float[numObj] ; canvasZObj = new float[numObj] ;
  familyObj = new float[numObj] ; quantityObj = new float[numObj] ; lifeObj = new float[numObj] ;
   //column 3
  speedObj = new float[numObj] ;
  directionObj = new float[numObj] ;
  angleObj = new float[numObj] ;
  amplitudeObj = new float[numObj] ;
  attractionObj = new float[numObj] ;
  repulsionObj = new float[numObj] ;
  alignmentObj = new float[numObj] ;
  influenceObj = new float[numObj] ;
  analyzeObj = new float[numObj] ;
  

    //future slider
  /* used in this time with the sizeXobj */
  fontSizeObj = new float[numObj] ;
}
// END CREATE VAR
//////////////////



// SETTING VAR
//SETUP
public void varObjSetup() {
  dirObjRef = new PVector() ;
  for (int i = 0 ; i < numObj ; i++ ) {
    pen[i] = new PVector() ;
    // use the 250 value for "z" to keep the position light on the front
    mouse[i] = new PVector() ;
    wheel[i] = 0 ;

  }
    // init global var for the color obj preview mode display
  COLOR_FILL_OBJ_PREVIEW = color (0,0,100,30) ; 
  COLOR_STROKE_OBJ_PREVIEW = color (0,0,100,30) ;
}
// END SETTING AR


/* 
UPDATE DATA from CONTROLER and PRESCENE
Those value are used to updated the object data value, and updated at the end of the loop the temp value
*/
public void updateVarRaw() {
  for(int i = 0 ; i < NUM_GROUP ; i++) {
    int minSource = 0 ;
    // int maxSource = 1 ;
    float minSize = .1f ;
    // fill
    fill_hue_raw[i] = (int)valueSlider[i+1][0] ;
    fill_sat_raw[i] = (int)map(valueSlider[i+1][1],0,MAX_VALUE_SLIDER,0,HSBmode.g);    
    fill_bright_raw[i] = (int)map(valueSlider[i+1][2],0,MAX_VALUE_SLIDER,0,HSBmode.b) ;   
    fill_alpha_raw[i] = (int)map(valueSlider[i+1][3],0,MAX_VALUE_SLIDER,0,HSBmode.a);
    // stroke
    stroke_hue_raw[i] = (int)valueSlider[i+1][4] ; 
    stroke_sat_raw[i] = (int)map(valueSlider[i+1][5],0,MAX_VALUE_SLIDER,0,HSBmode.g);  
    stroke_bright_raw[i] = (int)map(valueSlider[i+1][6],0,MAX_VALUE_SLIDER,0,HSBmode.b) ; 
    stroke_alpha_raw[i] = (int)map(valueSlider[i+1][7],0,MAX_VALUE_SLIDER,0,HSBmode.a);
    // 
    thicknessRaw[i] = mapStartSmooth(valueSlider[i+1][8], minSource, MAX_VALUE_SLIDER, minSize, (height*.33f), 2) ;

    // size
    sizeXRaw[i] = map(valueSlider[i+1][10], minSource, MAX_VALUE_SLIDER, minSize, width) ;
    sizeYRaw[i] = map(valueSlider[i+1][11], minSource, MAX_VALUE_SLIDER, minSize, width) ;
    sizeZRaw[i] = map(valueSlider[i+1][12], minSource, MAX_VALUE_SLIDER, minSize, width) ;
    // canvas
    canvasXRaw[i] = map(valueSlider[i+1][13], minSource, MAX_VALUE_SLIDER, width *minSize, width) ;
    canvasYRaw[i] = map(valueSlider[i+1][14], minSource, MAX_VALUE_SLIDER, width *minSize, width) ;
    canvasZRaw[i] = map(valueSlider[i+1][15], minSource, MAX_VALUE_SLIDER, width *minSize, width) ;
    // misc
    familyRaw[i] = map(valueSlider[i+1][16],minSource, MAX_VALUE_SLIDER, 0, 1) ;
    quantityRaw[i] = map(valueSlider[i+1][17], minSource, MAX_VALUE_SLIDER, 0, 1) ;
    lifeRaw[i] = map(valueSlider[i+1][18],minSource, MAX_VALUE_SLIDER,0,1) ;
    //column 3
    speedRaw[i] = map(valueSlider[i+1][20],minSource, MAX_VALUE_SLIDER,0,1) ;
    directionRaw[i] = map(valueSlider[i+1][21],minSource, MAX_VALUE_SLIDER,0,360) ;
    angleRaw[i] = map(valueSlider[i+1][22],minSource, MAX_VALUE_SLIDER,0,360) ;
    amplitudeRaw[i] = map(valueSlider[i+1][23],minSource, MAX_VALUE_SLIDER,0,1) ;
    // force
    attractionRaw[i] = map(valueSlider[i+1][24],minSource, MAX_VALUE_SLIDER,0,1) ;
    repulsionRaw[i] = map(valueSlider[i+1][25],minSource, MAX_VALUE_SLIDER,0,1) ;
    alignmentRaw[i] = map(valueSlider[i+1][26],minSource, MAX_VALUE_SLIDER,0,1) ;
    influenceRaw[i] = map(valueSlider[i+1][27],minSource, MAX_VALUE_SLIDER,0,1) ;
    analyzeRaw[i] = map(valueSlider[i+1][28],minSource, MAX_VALUE_SLIDER,0 , 1) ;

    /* used in this time with sizeXObj */
    fontSizeRaw[i] = map(sizeXRaw[i], minSize, width, 1, (float)height *.025f) ;
    fontSizeRaw[i] = 3 +(fontSizeRaw[i] *fontSizeRaw[i]) ;
  }
}


/* Those temp value are used to know is the object value must be updated */
public void updateVarTemp() {
    for(int i = 0 ; i < NUM_GROUP ; i++) {
    // fill
    fill_hue_temp[i] = fill_hue_raw[i] ;
    fill_sat_temp[i] = fill_sat_raw[i] ;    
    fill_bright_temp[i] = fill_bright_raw[i] ;   
    fill_alpha_temp[i] = fill_alpha_raw[i] ;
    // stroke
    stroke_hue_temp[i] = stroke_hue_raw[i] ; 
    stroke_sat_temp[i] = stroke_sat_raw[i] ;  
    stroke_bright_temp[i] = stroke_bright_raw[i] ; 
    stroke_alpha_temp[i] = stroke_alpha_raw[i] ;
    //
    thicknessTemp[i] = thicknessRaw[i] ;
    //size
    sizeXTemp[i] = sizeXRaw[i] ;
    sizeYTemp[i] = sizeYRaw[i] ;
    sizeZTemp[i] = sizeZRaw[i] ;
    // canvas
    canvasXTemp[i] = canvasXRaw[i] ;
    canvasYTemp[i] = canvasYRaw[i] ;
    canvasZTemp[i] = canvasZRaw[i] ;
    // misc
    familyTemp[i] = familyRaw[i] ;
    quantityTemp[i] = quantityRaw[i] ;
    lifeTemp[i] = lifeRaw[i] ;
    //column 3
    speedTemp[i] = speedRaw[i] ;
    directionTemp[i] = directionRaw[i] ;
    angleTemp[i] = angleRaw[i] ;
    amplitudeTemp[i] = amplitudeRaw[i] ;
    // force
    attractionTemp[i] = attractionRaw[i] ;
    repulsionTemp[i] = repulsionRaw[i] ;
    influenceTemp[i] = influenceRaw[i] ;
    alignmentTemp[i] = alignmentRaw[i] ;
    analyzeTemp[i] = analyzeRaw[i] ;

    /* used in this time with sizeXObj */
    fontSizeTemp[i] = fontSizeRaw[i] ;
  }
}


//SHORTCUT VAR
//SOUND
public float allBeats(int ID) {
  return (beat[ID]*.25f) +(kick[ID]*.25f) +(hat[ID]*.25f) +(snare[ID]*.25f) ;
}
// ASPECT

public void aspect(int ID) {
  if(alpha(fillObj[ID]) == 0 ) noFill() ; else fill(fillObj[ID]) ;
  if(alpha(strokeObj[ID]) == 0 ) noStroke() ; else stroke(strokeObj[ID]) ;
  strokeWeight(thicknessObj[ID]) ;
}












////////////////////////
// FONT and TEXT MANAGER

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
      


      
//SETUP
public void fontSetup() {
  String fontPathVLW = preferencesPath +"Font/typoVLW/" ;

  //write font path
  pathFontVLW[1] = fontPathVLW+"AmericanTypewriter-96.vlw";
  pathFontVLW[2] = fontPathVLW+"AmericanTypewriter-Bold-96.vlw";
  pathFontVLW[3] = fontPathVLW+"BancoITCStd-Heavy-96.vlw";
  pathFontVLW[4] = fontPathVLW+"CinquentaMilMeticais-96.vlw";
  pathFontVLW[5] = fontPathVLW+"Container-Regular-96.vlw";
  pathFontVLW[6] = fontPathVLW+"Diesel-96.vlw";
  pathFontVLW[7] = fontPathVLW+"Digital2-96.vlw";
  pathFontVLW[8] = fontPathVLW+"DIN-Regular-96.vlw";
  pathFontVLW[9] = fontPathVLW+"DIN-Bold-96.vlw";
  pathFontVLW[10] = fontPathVLW+"EastBlocICGClosed-96.vlw";
  pathFontVLW[11] = fontPathVLW+"FuturaStencilICG-96.vlw";
  pathFontVLW[12] = fontPathVLW+"FetteFraktur-96.vlw";
  pathFontVLW[13] = fontPathVLW+"GANGBANGCRIME-96.vlw";
  pathFontVLW[14] = fontPathVLW+"JuanitaDecoITCStd-96.vlw";
  pathFontVLW[15] = fontPathVLW+"Komikahuna-96.vlw";
  pathFontVLW[16] = fontPathVLW+"MesquiteStd-96.vlw";
  pathFontVLW[17] = fontPathVLW+"NanumBrush-96.vlw";
  pathFontVLW[18] = fontPathVLW+"RosewoodStd-Regular-96.vlw";
  pathFontVLW[19] = fontPathVLW+"3theHardwayRMX-96.vlw";
  pathFontVLW[20] = fontPathVLW+"Tokyo-One-96.vlw";
  pathFontVLW[21] = fontPathVLW+"MinionPro-Regular-96.vlw";
  pathFontVLW[22] = fontPathVLW+"MinionPro-Bold-96.vlw";
  // special font
  pathFontVLW[49] = fontPathVLW+"DIN-Regular-10.vlw";
  SansSerif10 = loadFont(fontPathVLW+"SansSerif-10.vlw" );
  
  // write font path for TTF
  String prefixTTF = preferencesPath +"Font/typoTTF/" ;
  //by default
  pathFontTTF[0] = prefixTTF+"FuturaStencil.ttf";
  // type
  pathFontTTF[1] = prefixTTF+"AmericanTypewriter.ttf";
  pathFontTTF[2] = prefixTTF+"AmericanTypewriter.ttf";
  pathFontTTF[3] = prefixTTF+"Banco.ttf";
  pathFontTTF[4] = prefixTTF+"Cinquenta.ttf";
  pathFontTTF[5] = prefixTTF+"FuturaStencil.ttf";
  pathFontTTF[6] = prefixTTF+"FuturaStencil.ttf";
  pathFontTTF[7] = prefixTTF+"Digital2.ttf";
  pathFontTTF[8] = prefixTTF+"FuturaStencil.ttf";
  pathFontTTF[9] = prefixTTF+"FuturaStencil.ttf";
  pathFontTTF[10] = prefixTTF+"FuturaStencil.ttf";
  pathFontTTF[11] = prefixTTF+"FuturaStencil.ttf";
  pathFontTTF[12] = prefixTTF+"FetteFraktur.ttf";
  pathFontTTF[13] = prefixTTF+"GangBangCrime.ttf";
  pathFontTTF[14] = prefixTTF+"JuanitaITC.ttf";
  pathFontTTF[15] = prefixTTF+"Komikahuna.ttf";
  pathFontTTF[16] = prefixTTF+"FuturaStencil.ttf";
  pathFontTTF[17] = prefixTTF+"FuturaStencil.ttf";
  pathFontTTF[18] = prefixTTF+"FuturaStencil.ttf";
  pathFontTTF[19] = prefixTTF+"3Hardway.ttf";
  pathFontTTF[20] = prefixTTF+"FuturaStencil.ttf";
  pathFontTTF[21] = prefixTTF+"MinionWebPro.ttf";
  pathFontTTF[22] = prefixTTF+"MinionWebPro.ttf";
  // special font
  pathFontTTF[49] = prefixTTF+"FuturaStencil.ttf";

  // load
  AmericanTypewriter=loadFont      (pathFontVLW[1]);
  AmericanTypewriterBold=loadFont  (pathFontVLW[2]);
  Banco=loadFont                   (pathFontVLW[3]);
  Cinquenta=loadFont               (pathFontVLW[4]);
  ContainerRegular=loadFont        (pathFontVLW[5]);
  Diesel=loadFont                  (pathFontVLW[6]);
  Digital=loadFont                 (pathFontVLW[7]);
  DinRegular=loadFont              (pathFontVLW[8]);
  DinBold=loadFont                 (pathFontVLW[9]);
  EastBloc=loadFont                (pathFontVLW[10]);
  FuturaStencil=loadFont           (pathFontVLW[11]);
  FetteFraktur=loadFont            (pathFontVLW[12]);
  GangBangCrime=loadFont           (pathFontVLW[13]);
  JuanitaOutline=loadFont          (pathFontVLW[14]);
  Komikahuna=loadFont              (pathFontVLW[15]);
  Mesquite=loadFont                (pathFontVLW[16]);
  NanumBrush=loadFont              (pathFontVLW[17]);
  Rosewood=loadFont                (pathFontVLW[18]);
  TheHardwayRMX=loadFont           (pathFontVLW[19]);
  TokyoOne=loadFont                (pathFontVLW[20]);
  Minion=loadFont                  (pathFontVLW[21]);
  MinionBold=loadFont              (pathFontVLW[22]);

  // default and special font
  DinRegular10=loadFont            (pathFontVLW[49]);

  font[0] = FuturaStencil ;
  pathFontObjTTF[0] = pathFontTTF[0] ;
}




public void choiceFont( int whichOne)  { 
  if (whichOne == 1 )     { pathFontObjTTF[0] = pathFontTTF[1] ; font[0] = AmericanTypewriter ;  }
  else if (whichOne ==2 ) { pathFontObjTTF[0] = pathFontTTF[2] ; font[0] = AmericanTypewriterBold ; }
  else if (whichOne == 3) { pathFontObjTTF[0] = pathFontTTF[3] ; font[0] = Banco ; }
  else if (whichOne ==4)  { pathFontObjTTF[0] = pathFontTTF[4] ; font[0] = Cinquenta ; }
  else if (whichOne ==5)  { pathFontObjTTF[0] = pathFontTTF[5] ; font[0] = ContainerRegular ; }
  else if (whichOne ==6)  { pathFontObjTTF[0] = pathFontTTF[6] ; font[0] = Diesel ; }
  else if (whichOne ==7)  { pathFontObjTTF[0] = pathFontTTF[7] ; font[0] = Digital ; }
  else if (whichOne ==8)  { pathFontObjTTF[0] = pathFontTTF[8] ; font[0] = DinRegular ; }
  else if (whichOne ==9)  { pathFontObjTTF[0] = pathFontTTF[9] ; font[0] = DinBold ; }
  else if (whichOne ==10) { pathFontObjTTF[0] = pathFontTTF[10] ; font[0] = EastBloc ; }
  else if (whichOne ==11) { pathFontObjTTF[0] = pathFontTTF[11] ; font[0] = FetteFraktur ; }
  else if (whichOne ==12) { pathFontObjTTF[0] = pathFontTTF[12] ; font[0] = FuturaStencil ; }
  else if (whichOne ==13) { pathFontObjTTF[0] = pathFontTTF[13] ; font[0] = GangBangCrime ; }
  else if (whichOne ==14) { pathFontObjTTF[0] = pathFontTTF[14] ; font[0] = JuanitaOutline ; }   
  else if (whichOne ==15) { pathFontObjTTF[0] = pathFontTTF[15] ; font[0] = Komikahuna ; }
  else if (whichOne ==16) { pathFontObjTTF[0] = pathFontTTF[16] ; font[0] = Mesquite ; }
  else if (whichOne ==17) { pathFontObjTTF[0] = pathFontTTF[17] ; font[0] = Minion ; }
  else if (whichOne ==18) { pathFontObjTTF[0] = pathFontTTF[18] ; font[0] = MinionBold ; }
  else if (whichOne ==19) { pathFontObjTTF[0] = pathFontTTF[19] ; font[0] = NanumBrush ; }
  else if (whichOne ==20) { pathFontObjTTF[0] = pathFontTTF[20] ; font[0] = Rosewood ; }
  else if (whichOne ==21) { pathFontObjTTF[0] = pathFontTTF[21] ; font[0] = TheHardwayRMX ; }
  else if (whichOne ==22) { pathFontObjTTF[0] = pathFontTTF[22] ; font[0] = TokyoOne ; } 
  else                     { pathFontObjTTF[0] = pathFontTTF[49]  ; font[0] = AmericanTypewriter ; }
}
//END FONT




// END FONT and TEXT MANAGER
////////////////////////////
// CLASS VEC 0.1.9
//////////////////
// inspireted by GLSL code and PVector

// VEC 2
////////////////
class Vec2 {
  float x,y = 0;
  float s,t = 0;
  float u,v = 0;
  
  Vec2() {
  }
  
  Vec2(float value) {
    this.x = this.y = this.s = this.t = this.u = this.v = value ;
  }
  
  Vec2(float x, float y) {
    this.x = this.s = this.u = x ;
    this.y = this.t = this.v = y ;
  }
  
  
  // multiplication
  /* multiply Vector by a float value */
  public void mult(float mult) {
    x *= mult ; y *= mult ;
    // update value
    s = u = x ;
    t = v = y ;
  }
  
  // mult by vector
  public void mult(Vec2 v_a) {
    x *= v_a.x ; y *= v_a.y ; 
    // update value
    s = u = x ;
    t = v = y ;
  }
  
  
    // division
  ///////////
  /*
  @ return Vec
  divide Vector by a float value */
  public void div(float div) {
    x /= div ; y /= div ; 
    // update value
    s = u = x ;
    t = v = y ;
  }
  
  // divide by vector
  public void div(Vec2 v_a) {
    x /= v_a.x ; y /= v_a.y ;  
    // update value
    s = u = x ;
    t = v = y ;
  }
  
  
  // addition
  ///////////
  /* add two Vector together */
  public Vec2 add(Vec2 v_a, Vec2 v_b) {
    x = v_a.x + v_b.x ;
    y = v_a.y + v_b.y ;
    // update value
    s = u = x ;
    t = v = y ;
    return new Vec2(x,y)  ;
  }
  
  /* mapping
  return mapping vector
  @return Vec2
  */
  public Vec2 mapVec(float minIn, float maxIn, float minOut, float maxOut) {
    x = map(x,minIn, maxIn, minOut, maxOut) ;
    y = map(y,minIn, maxIn, minOut, maxOut) ;
    // update value
    s = u = x ;
    t = v = y ;
    return new Vec2(x,y) ;
  }
  
  /* magnitude or length of Vec2
  @ return float
  */
  /////////////////////
  public float mag() {
    x *= x ;
    y *= y ; 
    return sqrt(x+y) ;
  }

  public float mag(Vec2 v_target) {
    float new_x = (v_target.x -x) *(v_target.x -x) ;
    float new_y = (v_target.y -y) *(v_target.y -y) ;
    return sqrt(new_x +new_y) ;
  }
  
  
  // Distance
  ////////////
  /*
  @ return float
  distance between himself and an other vector
  */
  public float dist(Vec2 v_target) {
    float dx = x - v_target.x;
    float dy = y - v_target.y;
    return (float) Math.sqrt(dx*dx + dy*dy);
  }
  
  
  
  /*catch info
  /////////////
  return all the componant of Vec
  @return Vec2
  */
  public Vec2 copy() {
    return new Vec2(x,y) ;
  }
  /*
  return all the componant of Vec in type PVector
  @return PVector
  */
  public PVector copyVecToPVector() {
    return new PVector(x,y) ;
  }
  

}
// END VEC 2
////////////









// VEC 3
////////////////
class Vec3 {
  float x,y,z  = 0 ;
  float r, g, b = 0 ;
  float s, t, p = 0 ;
  Vec3() {}
  
  Vec3(float value) {
    this.x = this.y = this.z  = this.r = this.g = this.b =this.s = this.t = this.p = value ;
  }
  
  Vec3(float x, float y, float z) {
    this.x = this.r =this.s = x ;
    this.y = this.g =this.t = y ;
    this.z = this.b = this.p =z ;
  }
  
  // multiplication
  /* multiply Vector by a float value */
  public void mult(float mult) {
    x *= mult ; y *= mult ; z *= mult ;
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
  }
  
  // mult by vector
  public void mult(Vec3 v_a) {
    x *= v_a.x ; y *= v_a.y ; z *= v_a.z ; 
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
  }
  
  
  
  // division
  ///////////
  /*
  @ return Vec
  divide Vector by a float value */
  public void div(float div) {
    x /= div ; y /= div ; z /= div ;
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
  }
  
  // divide by vector
  public void div(Vec3 v_a) {
    x /= v_a.x ; y /= v_a.y ; z /= v_a.z ; 
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
  }
  
  
  
  // addition
  /* add two Vector together */
  public Vec3 add(Vec3 v_a, Vec3 v_b) {
    x = v_a.x + v_b.x ;
    y = v_a.y + v_b.y ;
    z = v_a.z + v_b.z ;
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
    return new Vec3(x,y,z)  ;
  }
  
  
  
  /*
  mapping
  return mapping vector
  @return Vec3
  */
  public Vec3 mapVec(float minIn, float maxIn, float minOut, float maxOut) {
    x = map(x, minIn, maxIn, minOut, maxOut) ;
    y = map(y, minIn, maxIn, minOut, maxOut) ;
    z = map(z, minIn, maxIn, minOut, maxOut) ;
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
    return new Vec3(x,y,z) ;
  }
  
  
  
  // Magnitude
  ////////////
  /* Magnitude or length of Vec3
  @ return float
  */
  /////////////////////
  public float mag() {
    x *= x ;
    y *= y ; 
    z *= z ;
    return sqrt(x+y+z) ;
  }

  public float mag(Vec3 v_target) {
    float new_x = (v_target.x -x) *(v_target.x -x) ;
    float new_y = (v_target.y -y) *(v_target.y -y) ;
    float new_z = (v_target.z -z) *(v_target.z -z) ;
    return sqrt(new_x +new_y +new_z) ;
  }
  
  // Distance
  ////////////
  /*
  @ return float
  distance himself and an other vector
  */
  public float dist(Vec3 v_target) {
    float dx = x - v_target.x;
    float dy = y - v_target.y;
    float dz = z - v_target.z;
    return (float) Math.sqrt(dx*dx + dy*dy + dz*dz);
  }
  
  // catch info
  /////////////
  /*
  return all the component of Vec
  @return Vec3
  */
  public Vec3 copy() {
    return new Vec3(x,y,z) ;
  }
  /*
  return all the component of Vec in type PVector
  @return PVector
  */
  public PVector copyVecToPVector() {
    return new PVector(x,y,z) ;
  }
  
  
}
// END VEC 3
////////////






// VEC 4
////////
class Vec4 {
  float x,y,z,w = 0 ;
  float r, g, b, a = 0 ;
  float s, t, p, q = 0 ;
  
  Vec4 () {}
  
  Vec4(float value) {
    this.x = this.y = this.z = this.w = this.r = this.g = this.b = this.a =this.s = this.t = this.p = this.q = value ;
  }
  
  Vec4(float x, float y, float z, float w) {
    this.x = this.r = this.s = x ;
    this.y = this.g = this.t =y ;
    this.z = this.b = this.p =z ;
    this.w = this.a = this.q = w ;
  }
  
  
  // multiplication
  // mult by float
  public void mult(float mult) {
    x *= mult ; y *= mult ; z *= mult ; w *= mult ;
    r = s = x ;
    g = t = y ;
    b = p = z ;
    a = q = w ;
  }
  
  // mult by vector
  public void mult(Vec4 v_a) {
    x *= v_a.x ; y *= v_a.y ; z *= v_a.z ; w *= v_a.w ;
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
    a = q = w ;
  }
  
  
    // division
  ///////////
  /*
  @ return Vec
  divide Vector by a float value */
  public void div(float div) {
    x /= div ; y /= div ; z /= div ; w /= div ;
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
    a = q = w ;
  }
  
  // divide by vector
  public void div(Vec4 v_a) {
    x /= v_a.x ; y /= v_a.y ; z /= v_a.z ; w /= v_a.w ;
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
    a = q = w ;
  }
  
  // addition
  /* add two Vector together */
  public Vec4 add(Vec4 v_a, Vec4 v_b) {
    x = v_a.x + v_b.x ;
    y = v_a.y + v_b.y ;
    z = v_a.z + v_b.z ;
    w = v_a.w + v_b.w ;
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
    a = q = w ;
    return new Vec4(x,y,z,w)  ;
  }
  
  /* mapping
  return mapping vector
  @return Vec4
  */
  public Vec4 mapVec(float minIn, float maxIn, float minOut, float maxOut) {
    x = map(x, minIn, maxIn, minOut, maxOut) ;
    y = map(y, minIn, maxIn, minOut, maxOut) ;
    z = map(z, minIn, maxIn, minOut, maxOut) ;
    w = map(w, minIn, maxIn, minOut, maxOut) ;
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
    a = q = w ;
    return new Vec4(x,y,z,w) ;
  }
  
  // magnitude or length
  /////////////////////
  public float mag() {
    x *= x ;
    y *= y ; 
    z *= z ;
    w *= w ;  ;
    return sqrt(x+y+z+w) ;
  }

  public float mag(Vec4 v_target) {
    float new_x = (v_target.x -x) *(v_target.x -x) ;
    float new_y = (v_target.y -y) *(v_target.y -y) ;
    float new_z = (v_target.z -z) *(v_target.z -z) ;
    float new_w = (v_target.w -w) *(v_target.w -w) ;
    return sqrt(new_x +new_y +new_z +new_w) ;
  }
  
  // Distance
  ////////////
  // distance himself and an other vector
  public float dist(Vec4 v_target) {
    float dx = x - v_target.x;
    float dy = y - v_target.y;
    float dz = z - v_target.z;
    float dw = w - v_target.w;
    return (float) Math.sqrt(dx*dx + dy*dy + dz*dz + dw*dw);
  }
    
  // catch info
  /////////////
  public Vec4 copy() {
    return new Vec4(x,y,z,w) ;
  }
}
// END VEC 4
////////////



// CLASS Vec5
/////////////

class Vec5 {
  float a,b,c,d,e = 0 ;

  
  Vec5 () {}
  
  Vec5(float value) {
    this.a = this.b = this.c = this.d = this.e = value ;
  }
  
  Vec5(float a, float b, float c, float d, float e) {
    this.a = a ;
    this.b = b ;
    this.c = c ;
    this.d = d ;
    this.e = e ;
  }
  // catch info
  /////////////
  public Vec5 copy() {
    return new Vec5(a,b,c,d,e) ;
  }
}

// END VEC 5
////////////












// External Methods VEC
///////////////////////



// Addition
// return the resultat of vector addition
public Vec2 add(Vec2 v_a, Vec2 v_b) {
    float x = v_a.x + v_b.x ;
    float y = v_a.y + v_b.y ;
    return new Vec2(x,y) ;
}
public Vec3 add(Vec3 v_a, Vec3 v_b) {
    float x = v_a.x + v_b.x ;
    float y = v_a.y + v_b.y ;
    float z = v_a.z + v_b.z ;
    return new Vec3(x,y,z)  ;
}
public Vec4 add(Vec4 v_a, Vec4 v_b) {
    float x = v_a.x * v_b.x ;
    float y = v_a.y * v_b.y ;
    float z = v_a.z * v_b.z ;
    float w = v_a.w * v_b.w ;
    return new Vec4(x,y,z, w)  ;
}


// Multiplication
// return the resultat of vector multiplication
public Vec2 mult(Vec2 v_a, Vec2 v_b) {
    float x = v_a.x * v_b.x ;
    float y = v_a.y * v_b.y ;
    return new Vec2(x,y) ;
}
public Vec3 mult(Vec3 v1, Vec3 v_b) {
    float x = v1.x * v_b.x ;
    float y = v1.y * v_b.y ;
    float z = v1.z * v_b.z ;
    return new Vec3(x,y,z)  ;
}
public Vec4 mult(Vec4 v_a, Vec4 v_b) {
    float x = v_a.x * v_b.x ;
    float y = v_a.y * v_b.y ;
    float z = v_a.z * v_b.z ;
    float w = v_a.w * v_b.w ;
    return new Vec4(x,y,z, w)  ;
}


// Division
// return the resultat of vector addition
public Vec2 div(Vec2 v_a, Vec2 v_b) {
    float x = v_a.x / v_b.x ;
    float y = v_a.y / v_b.y ;
    return new Vec2(x,y) ;
}
public Vec3 div(Vec3 v1, Vec3 v_b) {
    float x = v1.x / v_b.x ;
    float y = v1.y / v_b.y ;
    float z = v1.z / v_b.z ;
    return new Vec3(x,y,z)  ;
}
public Vec4 div(Vec4 v_a, Vec4 v_b) {
    float x = v_a.x / v_b.x ;
    float y = v_a.y / v_b.y ;
    float z = v_a.z / v_b.z ;
    float w = v_a.w / v_b.w ;
    return new Vec4(x,y,z, w)  ;
}


// compare two vectors Vec
/*
@ return boolean
*/
// Vec method
// Vec2 compare
public boolean compare(Vec2 v_a, Vec2 v_b) {
  if( v_a != null && v_b != null ) {
    if((v_a.x == v_b.x) && (v_a.y == v_b.y)) {
      return true ; 
    } else return false ;
  } else return false ;
}
// Vec3 compare
public boolean compare(Vec3 v_a, Vec3 v_b) {
  if( v_a != null && v_b != null ) {
    if((v_a.x == v_b.x) && (v_a.y == v_b.y) && (v_a.z == v_b.z)) {
            return true ; 
    } else return false ;
  } else return false ;
}
// Vec4 compare
public boolean compare(Vec4 v_a, Vec4 v_b) {
  if( v_a != null && v_b != null ) {
    if((v_a.x == v_b.x) && (v_a.y == v_b.y) && (v_a.z == v_b.z) && (v_a.w == v_b.w)) {
            return true ; 
    } else return false ;
  } else return false ;
}



/* Map
return mapping vector
@return Vec2, Vec3 or Vec4
*/
public Vec2 mapVec(Vec2 v,float minIn, float maxIn, float minOut, float maxOut) {
  float x = map(v.x, minIn, maxIn, minOut, maxOut) ;
  float y = map(v.y, minIn, maxIn, minOut, maxOut) ;
  return new Vec2(x,y) ;
}
public Vec3 mapVec(Vec3 v,float minIn, float maxIn, float minOut, float maxOut) {
  float x = map(v.x, minIn, maxIn, minOut, maxOut) ;
  float y = map(v.y, minIn, maxIn, minOut, maxOut) ;
  float z = map(v.z, minIn, maxIn, minOut, maxOut) ;
  return new Vec3(x,y,z) ;
}
public Vec4 mapVec(Vec4 v,float minIn, float maxIn, float minOut, float maxOut) {
  float x = map(v.x, minIn, maxIn, minOut, maxOut) ;
  float y = map(v.y, minIn, maxIn, minOut, maxOut) ;
  float z = map(v.z, minIn, maxIn, minOut, maxOut) ;
  float w = map(v.w, minIn, maxIn, minOut, maxOut) ;
  return new Vec4(x,y,z,w) ;
}


// Magnitude or Length Vector
/*
@return float
*/
// mag Vec2
public float mag(Vec2 v_a) {
  float x = v_a.x*v_a.x ;
  float y = v_a.y *v_a.y ;
  return sqrt(x+y) ;
}

public float mag(Vec2 v_a, Vec2 v_b) {
  // same result than dist
  float x = (v_b.x -v_a.x)*(v_b.x -v_a.x) ;
  float y = (v_b.y -v_a.y)*(v_b.y -v_a.y) ;
  return sqrt(x+y) ;
}
// mag Vec3
public float mag(Vec3 v_a) {
  float x = v_a.x*v_a.x ;
  float y = v_a.y *v_a.y ;
  float z = v_a.z *v_a.z ;
  return sqrt(x+y+z) ;
}

public float mag(Vec3 v_a, Vec3 v_b) {
  // same result than dist
  float x = (v_b.x -v_a.x)*(v_b.x -v_a.x) ;
  float y = (v_b.y -v_a.y)*(v_b.y -v_a.y) ;
  float z = (v_b.z -v_a.z)*(v_b.z -v_a.z) ;
  return sqrt(x+y+z) ;
}
// mag Vec4
public float mag(Vec4 v_a) {
  float x = v_a.x*v_a.x ;
  float y = v_a.y *v_a.y ;
  float z = v_a.z *v_a.z ;
  float w = v_a.w *v_a.w ;
  return sqrt(x+y+z+w) ;
}

public float mag(Vec4 v_a, Vec4 v_b) {
  // same result than dist
  float x = (v_b.x -v_a.x)*(v_b.x -v_a.x) ;
  float y = (v_b.y -v_a.y)*(v_b.y -v_a.y) ;
  float z = (v_b.z -v_a.z)*(v_b.z -v_a.z) ;
  float w = (v_b.w -v_a.w)*(v_b.w -v_a.w) ;
  return sqrt(x+y+z+w) ;
}



// Distance
/*
return float
return the distance beatwen two vectors
*/
public float dist(Vec2 v_a, Vec2 v_b) {
    float dx = v_a.x - v_b.x;
    float dy = v_a.y - v_b.y;
    return (float) Math.sqrt(dx*dx + dy*dy);
}
public float dist(Vec3 v_a, Vec3 v_b) {
    float dx = v_a.x - v_b.x;
    float dy = v_a.y - v_b.y;
    float dz = v_a.z - v_b.z;
    return (float) Math.sqrt(dx*dx + dy*dy + dz*dz);
}
public float dist(Vec4 v_a, Vec4 v_b) {
    float dx = v_a.x - v_b.x;
    float dy = v_a.y - v_b.y;
    float dz = v_a.z - v_b.z;
    float dw = v_a.w - v_b.w;
    return (float) Math.sqrt(dx*dx + dy*dy + dz*dz + dw*dw);
}


// Middle
////////
/*
@ return Vec2, Vec3 or Vec4
return the middle between two Vector
*/
public Vec4 middle(Vec4 p1, Vec4 p2)  {
  Vec4 middle ;
  middle = add(p1, p2);
  middle.div(2) ;
  return middle ;
}

public Vec3 middle(Vec3 p1, Vec3 p2)  {
  Vec3 middle ;
  middle = add(p1, p2);
  middle.div(2) ;
  return middle ;
}

public Vec2 middle(Vec2 p1, Vec2 p2)  {
  Vec2 middle ;
  middle = add(p1, p2);
  middle.div(2) ;
  return middle ;
}


// Copy 
/*
@ return Vec3
Transform PVector in Vec
*/
public Vec3 copyPVectorToVec(PVector p) {
  return new Vec3(p.x,p.y,p.z) ;
}







// return a Vec value
// Vec 5
////////
public Vec5 Vec5(float a, float b, float c, float d, float e) {
  return new Vec5(a,b,c,d,e) ;
}

public Vec5 Vec5(float v) {
  return new Vec5(v) ;
}

public Vec5 Vec5() {
  return new Vec5(0.f) ;
}

// Vec 4
////////
public Vec4 Vec4(float x, float y, float z, float w) {
  return new Vec4(x,y,z,w) ;
}

public Vec4 Vec4(float v) {
  return new Vec4(v) ;
}

public Vec4 Vec4() {
  return new Vec4(0.f) ;
}

// Vec 3
////////
public Vec3 Vec3(float x, float y, float z) {
  return new Vec3(x,y,z) ;
}

public Vec3 Vec3(float v) {
  return new Vec3(v) ;
}

public Vec3 Vec3(PVector p) {
  return new Vec3(p.x, p.y, p.z) ;
}

public Vec3 Vec3() {
  return new Vec3(0.f) ;
}

// Vec 2
////////
public Vec2 Vec2(float x, float y) { 
  return new Vec2(x,y) ;
}

public Vec2 Vec2(float v) {
  return new Vec2(v) ;
}

public Vec2 Vec2(PVector p) {
  return new Vec2(p.x, p.y) ;
}

public Vec2 Vec2() {
  return new Vec2(0.f) ;
}
// END CLASS VEC
///////////////
/////////////
//CLASS PIXEL
/////////////
class Pixel {
  int colour, newColour ;
  PVector newC = new PVector (0,0,0) ; ;
  PVector pos ;
  PVector newPos = new PVector(0,0,0) ; // absolute pos in the display size : horizontal sytem of pixel system
  PVector gridPos ; // position with cols and rows system : vertical system of ArrayList
  PVector size = new PVector (1,1,1) ;
  float field = 1.0f ;
  PVector wind ; // the wind force who can change the position of the pixel
  float life = 1.0f ;
  int rank = -1 ;
  int ID = 0 ;
  
  //DIFFERENT CONSTRUCTOR
  
  //classic pixel
  Pixel(PVector pos) {
    this.pos = new PVector(pos.x, pos.y, pos.z) ;
  }
  
  Pixel(PVector pos, int colour) {
    this.pos = new PVector(pos.x, pos.y, pos.z) ;
    this.colour = colour ;
  }
  
  Pixel(PVector pos, PVector size) {
    this.pos = new PVector(pos.x, pos.y, pos.z) ;
    this.size = new PVector(size.x, size.y, size.z) ;
  }
  
  //pixel with size
  Pixel(PVector pos, PVector size, int colour) {
    this.pos = new PVector(pos.x, pos.y, pos.z) ;
    this.size = new PVector(size.x, size.y, size.z) ;
    this.colour = colour ;
  }
  
  //INK CONSTRUCTOR
  Pixel(PVector pos, float field, int colour) {
    this.pos = new PVector(pos.x, pos.y, pos.z) ;
    this.field = field ;
    this.colour = colour ;
  }
  Pixel(PVector pos, float field) {
    this.pos = new PVector(pos.x, pos.y, pos.z) ;
    this.field = field ;
  }
  
  //RANK PIXEL CONSTRUCTOR
  Pixel(int rank, PVector gridPos) {
    this.rank = rank ;
    this.gridPos = gridPos ;
  }
  Pixel(int rank) {
    this.rank = rank ;
  }
  
  
  
  
  //DISPLAY
    //without effect
  public void displayPixel(int diam) {
    strokeWeight(diam) ;
    stroke(this.colour) ;
    if (newPos.x == 0 && newPos.y == 0 && newPos.z == 0) newPos = pos ; // else newPos = newPos ;
    //test display with ID
    if (ID == 1 ) point(newPos.x, newPos.y) ;
  }
  //with effect
  public void displayPixel(int diam, PVector effectColor) {
    strokeWeight(diam) ;
    
    stroke(hue(newColour), effectColor.x *saturation(newColour), effectColor.y *brightness(newColour), effectColor.z) ;
    if (newPos.x == 0 && newPos.y == 0 && newPos.z == 0) newPos = pos ; // else newPos = newPos ;
    point(newPos.x, newPos.y) ;
  }

  //change ID after analyze if this one is good
  public void changeID(int newID) {  ID = newID ; }
  
  // END DISPLAY
  
  
  
  // UPDATE
  //drying is like jitter but with time effect, it's very subtil so we use a float timer.
    // classic
  public void drying(float timePast) {
    if (field > 0 ) { 
      field -= timePast ;
      float rad;
      float angle;
      rad = random(-1,1) *field;
      angle = random(-1,1) * TAU;
      pos.x += rad * cos(angle);
      pos.y += rad * sin(angle);
    }
  }
  // with external var
  public void drying(float var, float timePast) {
    if (field > 0 ) { 
      field -= timePast ;
      float rad;
      float angle;
      rad = random(-1,1) *field *var;
      angle = random(-1,1) * TAU;
      pos.x += rad * cos(angle);
      pos.y += rad * sin(angle);
    }
  }
  
  
  
  
  
  //CHANGE COLOR 
  // hue from Range
  public void changeHue(Vec4 HSBinfo, int[] newHue,  int[] start, int[] end) {
    float h = hue(this.colour) ;
    
    for( int i = 0 ; i < newHue.length ; i++) {
      if (start[i] < end[i] ) {
        if( h >= start[i] && h <= end[i] ) h = newHue[i] ; 
      } else if ( start[i] > end[i] ) {
        if( (h >= start[i] && h <= HSBinfo.x) || h <= end[i] ) { 
          if( h >= newHue[newHue.length -1] ) h = newHue[newHue.length -1] ; 
          else h = newHue[i] ; 
        }
      }        
    }
    newC.x = h ;
  }
  
  // saturation from Range
  public void changeSat(Vec4 HSBinfo, int[] newSat,  int[] start, int[] end) {
    float s = saturation(this.colour) ;
    
    for( int i = 0 ; i < newSat.length ; i++) {
      if (start[i] < end[i] ) {
        if( s >= start[i] && s <= end[i] ) s = newSat[i] ; 
      } else if ( start[i] > end[i] ) {
        if( (s >= start[i] && s <= HSBinfo.y) || s <= end[i] ) { 
          if( s >= newSat[newSat.length -1] ) s = newSat[newSat.length -1] ;
          else s = newSat[i] ;
        }
      }        
    }
    newC.y = s ;
  }
  
  // saturation from Range
  public void changeBright(Vec4 HSBinfo, int[] newBright,  int[] start, int[] end) {
    float b = brightness(this.colour) ;

    
    for( int i = 0 ; i < newBright.length ; i++) {
      if (start[i] < end[i] ) {
        if( b >= start[i] && b <= end[i] ) b = newBright[i] ; 
      } else if ( start[i] > end[i] ) {
        if( (b >= start[i] && b <= HSBinfo.z) || b <= end[i] ) { 
          if( b >= newBright[newBright.length -1] ) b = newBright[newBright.length -1] ;
          else b = newBright[i] ;
        }
      }        
    }
    newC.z = b ;
  }
  
  
  
  //change color of pixel for single color
  // void changeColor(color nc) { color c = nc ; }
  
  public void updatePalette() { 
    int h = (int)newC.x ;
    int s = (int)newC.y ;
    int b = (int)newC.z ;

    newColour = color(h,s,b) ;
  }
  
  
  //UPDATE POSITION with the wind
  public void updatePosPixel(PVector effectPosition, PImage pic) {
    PVector dir = normalDir((int)effectPosition.x) ;
    
    wind = new PVector (1.0f *dir.x *effectPosition.y  + random(-effectPosition.z, effectPosition.z) ,   1.0f *dir.y *effectPosition.y  + random(-effectPosition.z, effectPosition.z))   ;
    pos.add(wind) ;
    //keep the pixel in the scene
    if (pos.x< 0)          pos.x= pic.width;
    if (pos.x> pic.width)  pos.x=0;
    if (pos.y< 0)          pos.y= pic.height;
    if (pos.y> pic.height) pos.y=0;
  }
  
  
  
  //return position with display size
  public PVector posPixel(PVector effectPosition, PImage pic) {
    PVector dir = normalDir((int)effectPosition.x) ;

    newPos = pos ;
    
    wind = new PVector (1.0f *dir.x *effectPosition.y  + random(-effectPosition.z, effectPosition.z) ,   1.0f *dir.y *effectPosition.y  + random(-effectPosition.z, effectPosition.z))   ;
    newPos.add(wind) ;
    //keep the pixel in the scene
    if (newPos.x< 0)          newPos.x= pic.width;
    if (newPos.x> pic.width)  newPos.x=0;
    if (newPos.y< 0)          newPos.y= pic.height;
    if (newPos.y> pic.height) newPos.y=0;
    
    return new PVector (newPos.x, newPos.y) ;
  }
}
// END CLASS PIXEL
/////////////////






//CLASS ROTATION
////////////////
class Rotation {
  float rotation ;
  float angle  ;
  
  Rotation () {}
  
  public void actualisation (PVector pos, float speed) {
    rotation += speed ;
    if ( rotation > 360 ) rotation = 0 ; else if (rotation < 0 ) rotation = 360 ;
    float angle = rotation ;
    translate (pos.x, pos.y) ;
    rotate (radians(angle) ) ;
  }
} 
// END CLASS ROTATION










// CANVAS
/////////////////
/* Canvas 1.c by Stan le Punk february 2015 */
class Canvas {
  PVector pos, size ;
  PVector [] points  ;
    // X coord
  float left, right ;
  // Y coord
  float top, bottom ;
  // Z coord
  float front, back ;
  
  Canvas(PVector pos, PVector size) {
    this.pos = pos ;
    this.size = size ;
    update() ;
  }
  
  
  public void update() {
    // X coord
    this.left = pos.x -(size.x *.5f) ;
    this.right = pos.x +(size.x *.5f) ;
   // Y coord
   this.top = pos.y -(size.y *.5f) ;
   this.bottom = pos.y +(size.y *.5f) ;
   // Z coord
   this.front = pos.z +(size.z *.5f) ;
   this.back =  pos.z -(size.z *.5f) ;
    
    if(size.y != 0) {
      points = new PVector[8] ;
      points[0] = new PVector(left,top,front) ;
      points[1] = new PVector(right,top,front) ;
      points[2] = new PVector(right,bottom,front) ;
      points[3] = new PVector(left,bottom,front) ;
      points[4] = new PVector(left,top,back) ;
      points[5] = new PVector(right,top,back) ;
      points[6] = new PVector(right,bottom,back) ;
      points[7] = new PVector(left,bottom,back) ;
    } else {
      points = new PVector[4] ;
      points[0] = new PVector(left,top) ;
      points[1] = new PVector(right,top) ;
      points[2] = new PVector(right,bottom) ;
      points[3] = new PVector(left,bottom) ;
    }
  }
  
  
  
  
  public void canvasLine() {
    if(points.length > 4) {
      for(int i = 1 ; i < 4 ; i++) {
        // draw line box
        line(points[i-1].x, points[i-1].y,points[i-1].z, points[i].x,points[i].y, points[i-1].z) ;
        line(points[i+3].x, points[i+3].y,points[i+3].z, points[i+4].x,points[i+4].y, points[i+4].z) ;
      }
      // special line
      line(points[0].x, points[0].y,points[0].z, points[3].x,points[3].y, points[3].z) ;
      line(points[4].x, points[4].y,points[4].z, points[7].x,points[7].y, points[7].z) ;
      
      
      for(int i = 0 ; i < 4 ; i++) {
        line(points[i].x,points[i].y, points[i].z, points[i+4].x, points[i+4].y,points[i+4].z) ;
      }
    } else {
      // draw line rect
      for(int i = 1 ; i < 4 ; i++) {
         line(points[i-1].x, points[i-1].y, points[i].x,points[i].y) ;
      }
      // close
      line(points[3].x, points[3].y, points[0].x,points[0].y) ;
    }
  }
}
// END CANVAS
/////////////
























// CLASS POLYGONE june 2015 / 1.1.2
///////////////////////////////////
class Polygon {
  Vec4 [] points ;
  PVector pos ;
  float radius ;
  // put the alpha to zero by default in case there is polygon outside the array when you want change the color of polygone
  int color_fill = color(255) ;
  int color_stroke = color(0) ;
  float strokeWeight = 1 ;
  int ID ;


  /*
  Maybe need to remove this option
  */
 //  PShape polygon;


  Polygon(PVector pos, float radius, float rotation, int num_of_summit, int ID) {
    this.pos = pos.copy() ;
    this.radius = radius ;
    this.ID = ID ;
    points = new Vec4 [num_of_summit] ;
    float angle = TAU / num_of_summit ;

    for (int i = 0; i < num_of_summit; i++) {
      float newAngle = angle*i;
      float x = pos.x + cos(newAngle +rotation) *radius;
      float y = pos.y + sin(newAngle +rotation) *radius;
      float z = pos.z ;
      points[i] = new Vec4(x, y, z, ID) ;
    }
    /*
    // Maybe need to remove this option
    polygon = createShape();
    create_poly_in_PShape();
    */
  }

  // DRAW
  public void draw_polygon() {
    fill(color_fill) ;
    stroke(color_stroke) ;
    strokeWeight(strokeWeight) ;
    // check for transparency
    if(strokeWeight == 0 || alpha(color_stroke) == 0) noStroke() ;
    if(alpha(color_fill) == 0) noFill() ;
    // draw
    beginShape();
    for (int i = 0; i < points.length; i++) {
      vertex(points[i].x, points[i].y, points[i].z);
    }
    endShape(CLOSE) ;
  }
  
  public void draw_polygon(PVector motion) {
    fill(color_fill) ;
    stroke(color_stroke) ;
    strokeWeight(strokeWeight) ;
    // check for transparency
    if(strokeWeight == 0 || alpha(color_stroke) == 0) noStroke() ;
    if(alpha(color_fill) == 0) noFill() ;
    // draw
    pushMatrix() ;
    translate(motion.x,motion.y,motion.z) ;
    beginShape();
    for (int i = 0; i < points.length; i++) {
      vertex(points[i].x, points[i].y, points[i].z);
    }
    endShape(CLOSE) ;
    popMatrix() ;
  }
  
  public void draw_polygon(PVector motion, PVector rotation) {
    fill(color_fill) ;
    stroke(color_stroke) ;
    strokeWeight(strokeWeight) ;
    // check for transparency
    if(strokeWeight == 0 || alpha(color_stroke) == 0) noStroke() ;
    if(alpha(color_fill) == 0) noFill() ;
    // draw
    pushMatrix() ;
    translate(motion.x,motion.y,motion.z) ;
    rotateX(radians(rotation.x)) ;
    rotateZ(radians(rotation.y)) ;
    rotateY(radians(rotation.z)) ;
    beginShape();
    for (int i = 0; i < points.length; i++) {
      vertex(points[i].x, points[i].y, points[i].z);
    }
    endShape(CLOSE) ;
    popMatrix() ;
  }
  
  
  // SHAPE METHOD
  public void draw_polygon_in_PShape(PShape in) {
    in.fill(color_fill) ;
    in.stroke(color_stroke) ;
    in.strokeWeight(strokeWeight) ;
    // check for trnsparency
    if(strokeWeight == 0 || alpha(color_stroke) == 0) in.noStroke() ;
    if(alpha(color_fill) == 0) in.noFill() ;
    // draw
    for (int i = 0; i < points.length; i++) {
      in.vertex(points[i].x, points[i].y, points[i].z);
    }
  }
  
  public void draw_polygon_in_PShape(PShape in, PVector motion) {
    in.fill(color_fill) ;
    in.stroke(color_stroke) ;
    in.strokeWeight(strokeWeight) ;
    // check for trnsparency
    if(strokeWeight == 0 || alpha(color_stroke) == 0) in.noStroke() ;
    if(alpha(color_fill) == 0) in.noFill() ;
    // draw
    pushMatrix() ;
    translate(motion.x,motion.y,motion.z) ;
    for (int i = 0; i < points.length; i++) {
      in.vertex(points[i].x, points[i].y, points[i].z);
    }
    popMatrix() ;
  }
  //
  /*
  // Maybe need to remove this option
  void create_poly_in_PShape() {
    polygon.beginShape();

    polygon.fill(color_fill) ;
    polygon.stroke(color_stroke) ;
    polygon.strokeWeight(strokeWeight) ;
    for (int i = 0; i < points.length; i++) {
      polygon.vertex(points[i].x, points[i].y, points[i].z);
    }
    polygon.endShape(CLOSE) ;
  }
*/

  //UPDATE ALL THE POINT
  public void update_AllPoints_Zpos_Polygon(float newPosZ) {
    for (int i = 0; i < points.length; i++) {
      points[i].z = newPosZ ;
    }
  }


  //UPDATE SPECIFIC POINT
  public void update_SpecificPoints_Zpos_Polygon(PVector ref, float newPosZ) {
    for (int i = 0; i < points.length; i++) {
      float range = .1f ; // we use a range around the point to be sure to catch it.
      if ((ref.x <= points[i].x +range && ref.x >= points[i].x -range)  && (ref.y <= points[i].y +range && ref.y >= points[i].y -range) ) points[i].z = newPosZ ;
    }
  }


  public boolean check_SpecificPoint_Polygon(PVector ref, float newPosZ) {
    boolean checked = false ;
    for (int i = 0; i < points.length; i++) {
      float range = .1f ; // we use a range around the point to be sure to catch it.
      if ((ref.x <= points[i].x +range && ref.x >= points[i].x -range)  && (ref.y <= points[i].y +range && ref.y >= points[i].y -range) ) checked = true ; 
      else checked = false ;
    }
    return checked ;
  }

}
// END POLYGON
///////////////


  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "PreScene_27" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
