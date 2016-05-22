import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.awt.event.KeyEvent; 
import com.leapmotion.leap.*; 
import java.awt.Font; 
import java.awt.image.BufferedImage; 
import java.awt.FontMetrics; 
import java.net.*; 
import java.io.*; 
import java.util.*; 
import java.awt.*; 
import java.util.Iterator; 
import java.lang.reflect.*; 
import java.awt.image.*; 
import processing.video.*; 
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
import codeanticode.syphon.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class PreScene_30 extends PApplet {


  ////////////////////////////////////////////////////////////////////
 // Romanesco Unu 1.2.0 / version 30 / made with Processing 3.1.1 ///
////////////////////////////////////////////////////////////////////
/* 14.500 lines of code the 4th may 2015 !!!! */

String version = ("30") ;
String IAM = ("Prescene") ;
String prettyVersion = ("1.2.0") ;
String nameVersion = ("Romanesco Unu") ;
String preference_path, import_path ;


/*
Use true when you want 
display color
used sound
 maximum possibility of the object
 full frame rate
*/
boolean TEST_ROMANESCO = false ;
boolean FULL_RENDERING = false ;

public void settings() {
  size(600,400,P3D) ;
  pixelDensity(displayDensity()) ;
  syphon_settings() ;
}

  
public void setup() {
  camera_video_setup() ;
  
  preference_path = sketchPath("")+"preferences/" ;
  import_path = sketchPath("")+"import/" ;

  display_setup(60) ; // the int value is the frameRate
  RG.init(this);  // Geomerative
  // common setup

  romanesco_setup() ;
  P3D_setup(numObj, numSettingCamera, numSettingOrientationObject) ;
  create_variable() ;
  //specific setup
  prescene_setup() ; // the varObject setup of the Scene is more simple
  leapmotion_setup() ;
  
  //common setup
  color_setup() ;
  syphon_setup() ;

  init_variable_item_min_max() ; 
  init_variable_item() ;

  font_setup() ;

  // here we ask for the TEST_ROMANESCO true, because the Minim Library talk too much in the consol
  if(!TEST_ROMANESCO) sound_setup() ;
 //  P3D_setup(numObj, numSettingCamera, numSettingOrientationObject) ;
  // Light and shader setup
  light_position_setup() ;
  light_setup() ;
  if(FULL_RENDERING) shader_setup() ;

  OSC_setup() ;
}



//DRAW
public void draw() {
  surface.setTitle(nameVersion + " " +prettyVersion+"."+version+ " | Pr\u00e9sc\u00e8ne | FPS: "+round(frameRate));
  //setting
  init_and_update_diplay_var() ;
  syphon_draw() ;
  // camera_video_draw() ;
  // here we ask for the TEST_ROMANESCO true, because the Minim Library talk too much in the consol
  if(!TEST_ROMANESCO) soundDraw() ;
  
  update_OSC_data() ;
  OSC_send() ;

  update_raw_value() ;

  background_romanesco() ;
  updateCommand() ;
  leapMotionUpdate() ;
  loadPrescene() ;
  
  //ROMANESCO
  cameraDraw() ;
  
  // LIGHT
  light_position_draw(mouse[0], wheel[0]) ; // not in the conditional because we need to display in the info box
  light_update_position_direction() ;
  if(FULL_RENDERING) {
    light_call_shader() ;
    light_display() ;
    shader_draw() ;
  }


  //use romanesco object
  rpe_manager.displayObject(ORDER_ONE, ORDER_TWO, ORDER_THREE) ;
  createGridCamera(displayInfo3D) ;
  stopCamera() ;

  
  //annexe
  info() ;
  if(FULL_RENDERING && !TEST_ROMANESCO) curtain() ;
  
  // misc
  update_temp_value() ;
  cursorDraw() ;
  
  // change to false if the information has be sent to Scene...but how ????
  keyboardFalse() ;

  // deprecated, now the Scene must open in first.
  // opening() ;
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
// Tab: A_Core_Prescene
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
int speedWheel = 4 ; // 5 is too quick
float speedLeapmotion = .15f ; // between 0.000001 and 1 : can be good between 0.1 and 0.4

// END VARIABLE
///////////////




// METHOD
/////////

/*
import codeanticode.tablet.*;
Tablet tablet;
*/
public void prescene_setup() {
  leap = new com.leapmotion.leap.Controller();
 //  tablet = new Tablet(this);
  if(FULL_RENDERING) displayInfo3D = false ; else displayInfo3D = true ;
}

/**
Deprecated

//OPENING the other window
int count_to_open_controller = 0 ;
int time_int_second_to_open_controller = 12  ; // the scene run at 15 frame / second.
void opening() {
    //OPEN CONTROLEUR and SCENE or MIROIR
  if (!TEST_ROMANESCO && openControleur) {
    fill(blanc) ;
    stroke(blanc) ;
    textSize(48) ;
    text(version, sin(frameCount * .05) *width, height/2 ) ;
  }
  if (!TEST_ROMANESCO) { 
    if (openScene)      {
      if(fullScreen) launch(sketchPath("")+"Scene_"+version+"_fullscreen.app") ; else launch(sketchPath("")+"Scene_"+version+"_window.app") ;
      openScene = false ; 
    } else {
      count_to_open_controller += 1 ;
    }

    int time_factor_to_open = 15 ;
    if (openControleur && count_to_open_controller > (time_int_second_to_open_controller *time_factor_to_open) ) { 
      launch(sketchPath("")+"Controleur_"+version+".app") ; 
      openControleur = false ; 
    } 
    // TEST_ROMANESCO = true ;
  }
}
*/





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




Vec3 posRef = Vec3() ;
int mouseZ ;


public void cursorDraw() {
  updateLeapCommand() ;
  updateMouseZ() ;
  
  //mousePressed
  if(ORDER_ONE || ORDER_TWO || ORDER_THREE) ORDER = true ; else ORDER = false ;
  
  //check the tablet
  // pen[0] = new PVector (norm(tablet.getTiltX(),0,1), norm(tablet.getTiltY(),0,1), tablet.getPressure()) ;
  pen[0] = Vec3() ;
  
  // Leap and mouse move
  if (orderOneLeap || orderTwoLeap) {
    mouse[0] = Vec3(averageTranslatePosition(speedLeapmotion).x, -averageTranslatePosition(speedLeapmotion).y,averageTranslatePosition(speedLeapmotion).z)  ;
  } else if(posRef.x != mouseX || posRef.y != mouseY) {
    mouse[0] = Vec3(mouseX,mouseY,0) ;
    posRef.set(mouse[0]) ;
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
    keyboard[keyCode] = false;   //
    
  }
}

// Scene current save
// CTRL + S
public void check_Keyboard_save_scene_CURRENT_path() {
  if(checkKeyboard(CONTROL) && !checkKeyboard(SHIFT) && checkKeyboard(KeyEvent.VK_S) ) {
    save_Current_Scene_Setting_local = true ;
    keyboard[keyCode] = false ;   // just open one window, when use only the keyboard, if you don't use that open all the windows save and open
   }
}
// Scene new save
// CTRL + SHIFT + S
public void check_Keyboard_save_scene_NEW_path() {
  if(checkKeyboard(CONTROL) && checkKeyboard(SHIFT) && checkKeyboard(KeyEvent.VK_S) ) {
    save_New_Scene_Setting_local = true ;
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
  if (key == 'c'  || key == 'C' ) { 
    cTouch = true ; 
    cLongTouch = true ; 
  }
  if (key == 'd'  || key == 'D' ) dTouch = true ;
  if (key == 'e'  || key == 'E' ) eTouch = true ;
  if (key == 'f'  || key == 'F' ) fTouch = true ;
  if (key == 'g'  || key == 'G' ) gTouch = true ;
  if (key == 'h'  || key == 'H' ) hTouch = true ;
  if (key == 'i'  || key == 'I' ) iTouch = true ;
  if (key == 'j'  || key == 'J' ) jTouch = true ;
  if (key == 'k'  || key == 'K' ) kTouch = true ;
  if (key == 'l'  || key == 'L' ) { 
    lTouch = true ; 
    lLongTouch = true ; 
  }
  if (key == 'm'  || key == 'M' ) mTouch = true ;
  if (key == 'n'  || key == 'N' ) { 
    nTouch = true ; 
    nLongTouch = true ; 
  }
  if (key == 'o'  || key == 'O' ) oTouch = true ;
  if (key == 'p'  || key == 'P' ) pTouch = true ;
  if (key == 'q'  || key == 'Q' ) qTouch = true ;
  if (key == 'r'  || key == 'R' ) rTouch = true ;
  if (key == 's'  || key == 'S' ) sTouch = true ;
  if (key == 't'  || key == 'T' ) tTouch = true ;
  if (key == 'u'  || key == 'U' ) uTouch = true ;
  if (key == 'v'  || key == 'V' ) { 
    vTouch = true ; 
    vLongTouch = true ; 
  }
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
  if (keyCode == SHIFT ) {
    shiftTouch = true ;
    shiftLongTouch = true ;
  }
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

  if (keyCode == SHIFT ) shiftLongTouch = false ;
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
/**
OSC PRescene 1.0.1
*/
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
public void OSC_setup() {
  osc = new OscP5(this, 10000);
  //send to the Sc\u00e8ne
  if (youCanSendToScene) targetScene = new NetAddress(sendToScene,9001);
  //send to the miroir
  if (!TEST_ROMANESCO) {
    String [] addressIP = loadStrings(preference_path+"network/IP_local_miroir.txt") ;
    sendToMiroir = join(addressIP, "") ;
    targetMiroir = new NetAddress(sendToMiroir,9002);
  } else if (TEST_ROMANESCO && youCanSendToMiroir )  {
    targetMiroir = new NetAddress(sendToMiroir,9002);
  }
  println("OSC setup done") ;
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
  
}

public void update_OSC_data() {
  translateDataFromController_buttonGlobal() ;
  translateDataFromController_buttonItem() ;
}













// OSC DRAW
////////////
public void OSC_send() {
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
   dataPreScene[40] = float_to_String_3(pen[0].x) ; dataPreScene[41] = float_to_String_3(pen[0].y) ; dataPreScene[42] = float_to_String_1(pen[0].z) ; 
   dataPreScene[43] = float_to_String_3(norm(mouse[0].x, 0, width)) ; 
   dataPreScene[44] = float_to_String_3(norm(mouse[0].y,0,height)) ;
   dataPreScene[45] = float_to_String_3(norm(mouse[0].z,-depth,depth)) ;
   if (clickShortLeft[0]) dataPreScene [46] = ("1") ; else dataPreScene [46] = ("0") ;
   if (clickShortRight[0]) dataPreScene [47] = ("1") ; else dataPreScene [47] = ("0") ;
   if (clickLongLeft[0]) dataPreScene [48] = ("1") ; else dataPreScene [48] = ("0") ;
   if (clickLongRight[0]) dataPreScene [49] = ("1") ; else dataPreScene [49] = ("0") ;
   dataPreScene[50] = int_to_String(wheel[0]) ;
   
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

   if (shiftLongTouch) dataPreScene [65] = ("1") ; else dataPreScene [65] = ("0") ;
   
   // FREE
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
// Tab: A_Save_load
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
// Tab: A_Screen_Prescene
///////////////////////////////////////////////
//GRAPHIC CONFIGURATION OF THE SCENE DISPLAYING
//SCREEN CHOICE and FULLSCREEN
/*
GraphicsEnvironment ge = GraphicsEnvironment.getLocalGraphicsEnvironment();
GraphicsDevice[] gs = ge.getScreenDevices();
*/
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
String pathScenePropertySetting = "preferences/sceneProperty.csv" ;
TableRow row ;
Table configurationScene;

//factor to divide the size of the Pr\u00e9-Sc\u00e8ne 
int divSizePreScene = 2 ;



//SETUP
public void display_setup(int speed) {
  frameRate(speed) ;  // Le frameRate doit \u00eatre le m\u00eame dans tous les Sketches
  colorMode(HSB, HSBmode.r, HSBmode.g, HSBmode.b, HSBmode.a) ;
  loadPropertyPrescene() ;
  sizePrescene() ;
  background_setup() ;
  background_shader_setup() ;
}
//END DISPLAY START
//////////////////


//load property from table


public void loadPropertyPrescene() {
  configurationScene = loadTable(sketchPath("") + pathScenePropertySetting, "header");
  row = configurationScene.getRow(0);
  //fullscreen 
  if (row.getString("fullscreen").equals("TRUE") || row.getString("fullscreen").equals("true")) fullScreen = true ; else fullScreen = false ;
  //display on specific screen
  myScreenToDisplayMySketch = row.getInt("whichScreen") -1 ;
  //decorated the scene
  if (row.getString("decorated").equals("FALSE") || row.getString("decorated").equals("false") || fullScreen ) undecorated = true ; else undecorated = false ;
}





// SIZE SCENE
public void sizePrescene() {
  depth = height ;
  //resizable frame by loading external image
  if (row.getString("resizable").equals("TRUE")) {
    frame.pack();  
    insets = frame.getInsets(); // use for the border of window (top and right)
    displaySizeByImage = true ;
  }
  
  //resize by cursor
  surface.setResizable(true);
}
// END SIZE SCENE

    
// END OF GRAPHIC CONFIGURATION
///////////////////////////////
// Tab: B_leapmotion
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

public void leapmotion_setup() {
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
    pos = follow(infoPos, speed).copy() ;
    // pos = infoPos.copy() ;
    return pos ;
  }
}
/**
LETTER || 2012 || 1.2.0
*/
class Letter extends Romanesco {
  public Letter() {
    //from the index_objects.csv
    RPE_name = "Letter" ;
    ID_item = 1 ;
    ID_group = 1 ;
    RPE_author  = "Stan le Punk";
    RPE_version = "Version 1.2";
    RPE_pack = "Base" ;
    romanescoRender = "P3D" ;
    RPE_mode = "Point/Line/Triangle" ;
    RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Stroke hue,Stroke sat,Stroke bright,Stroke alpha,Thickness,Size X,Canvas X,Canvas Y,Canvas Z,Quantity,Speed X" ;
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
  public void setup() {
    startPosition(ID_item, width/2, height/2, 0) ;
  }
  
  
  
  
  //DRAW
  public void draw() {
    load_txt(ID_item) ;
    
    if (parameter[ID_item] || pathFontObjTTF[ID_item] == null ) { 
      font[ID_item] = font[0] ;
      pathFontObjTTF[ID_item] = pathFontObjTTF[0] ;
    }
    //init and re-init Geomerative if few stuff change about this line like text, font and the size of the font
    sizeFont = PApplet.parseInt(font_size_item[ID_item]) ;
    //text
    String sentence = whichSentence(text_import[ID_item], 0, 0) ;
    

    
    //check if something change to update the RG.getText
    if ( sizeRef == sizeFont && sentenceRef.equals(sentence) && pathRef.equals(pathFontObjTTF[ID_item])) newSetting = true  ; else newSetting = false ;
    sizeRef = sizeFont ;
    sentenceRef = (sentence) ;
    pathRef = (pathFontObjTTF[ID_item]) ;
    if(!newSetting || resetParameter(ID_item)) {
     
      grp = RG.getText(sentence, pathFontObjTTF[ID_item], (int)sizeFont, CENTER); 
      newSetting = true ;
      axeLetter = PApplet.parseInt(random (grp.countChildren())) ;
    }
    if(resetParameter(ID_item)) {
      int choiceDir = floor(random(2)) ;
      if(choiceDir == 0 ) startDirection = -1 ; else startDirection = 1 ;
    }
    
    if(allBeats(ID_item) > 10 || nTouch ) axeLetter = PApplet.parseInt(random (grp.countChildren())) ;
    
    

    
    
    /////////
    //ENGINE
    
    //speed
    float speed ;
    if(motion[ID_item]) speed = map(speed_x_item[ID_item], 0,1, 0.000f, 0.3f ) *tempo[ID_item]  ; else speed = 0.0f ;
    //to stop the move
    if (!action[ID_item]) speed = 0.0f ; 
    if(clickLongLeft[ID_item] || spaceTouch) speed = -speed ;
    
    //num letter to display
    numLetter = (int)map(quantity_item[ID_item],0,1, 0,grp.countChildren() +1) ;
    
    //DISPLAY
    // thickness
    float thicknessLetter = map(thickness_item[ID_item], .1f, height/3, 0.1f, height /10) ; ;

    // color
    if(mode[ID_item] <= 1) {
      noFill() ; stroke(fill_item[ID_item]) ; strokeWeight(thicknessLetter) ;
    } else {
      fill(fill_item[ID_item]) ; stroke(stroke_item[ID_item]) ; strokeWeight(thicknessLetter) ;
    }
    //jitter
    float jitterX = map(canvas_x_item[ID_item],width/10, width, 0, width/40) ;
    float jitterY = map(canvas_y_item[ID_item],width/10, width, 0, width/40) ;
    float jitterZ = map(canvas_z_item[ID_item],width/10, width, 0, width/40) ;
    PVector jitter = new PVector (jitterX *jitterX, jitterY *jitterY, jitterZ *jitterZ) ;
    


    letters(speed, axeLetter, jitter) ;
    //END YOUR WORK
    

    
    // INFO
    objectInfo[ID_item] = ("Quantity of letter display " + numLetter + " - Speed " +PApplet.parseInt(speed*100)) ;

  }
  
  
  // ANNEXE
  float rotation ;
  
  public void letters(float speed, int axeLetter, PVector jttr) {
    //create a PVector arraylist from geomerative analyze
    // float rangeWhichLetter = width / grp.countChildren() ;
    if (sound[ID_item]) whichLetter = (int)allBeats(ID_item) ; else whichLetter = 0 ;
    
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
        if(motion[ID_item]) grp.children[targetLetter].rotate(speed, grp.children[axeLetter].getCenter());
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
      points[i].z = points[i].z +(allBeats(ID_item) *factor) ; 

      if(mode[ID_item] == 0 ) point(points[i].x, points[i].y, points[i].z) ;
      if(mode[ID_item] == 1 ) if(i > 0 ) line( points[i-1].x, points[i-1].y, points[i-1].z,   points[i].x, points[i].y, points[i].z );
      if(mode[ID_item] == 2 ) if(i > 1 ) triangle(points[i-2].x, points[i-2].y, points[i-2].z,   points[i-1].x, points[i-1].y, points[i-1].z,   points[i].x, points[i].y, points[i].z );
      
    }
  }
  
  //ANNEXE VOID
  //jitter for PVector points
  public PVector jitterPVector(PVector range) {
    float factor = 0.0f ;
    if(sound[ID_item]) factor = 2.0f ; else factor = 0.1f  ;
    int rangeX = PApplet.parseInt(range.x *left[ID_item] *factor) ;
    int rangeY = PApplet.parseInt(range.y *right[ID_item] *factor) ;
    int rangeZ = PApplet.parseInt(range.z *mix[ID_item] *factor) ;
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
/**
HORLOGE || 2012 || 2.0.2
*/

class Horloge extends Romanesco {
  public Horloge() {
    //from the index_objects.csv
    RPE_name = "Horloge" ;
    ID_item = 2 ;
    ID_group = 1 ;
    RPE_author  = "Stan Le Punk";
    RPE_version = "Version 2.0.1";
    RPE_pack = "Base" ;
    romanescoRender = "classic" ;
    RPE_mode = "Ellipse Clock 12/Ellipse Clock 24/Line Clock 12/Line Clock 24/minutes/secondes" ;// separate the name by a slash and write the next mode immadialtly after this one.
    RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Canvas X,Direction X,Area,Speed X,Size X" ;
  }
  //GLOBAL
  Vec3 pos_clock = Vec3() ; 
  int local_frameCount ;
  
  //SETUP
  public void setup() {
    startPosition(ID_item, width/2, height/2, -width) ;
    pos_clock = Vec3(width/2,height/2,0) ;
  }
  
  
  
  
  //DRAW
  public void draw() {
    textAlign(CENTER);
    // typo
    float sizeFont = font_size_item[ID_item] +12 ;
    textFont(font[ID_item], sizeFont *allBeats(ID_item));
    
    // couleur du texte
    float t = alpha(fill_item[ID_item]) * abs(mix[ID_item]) ;
    if (sound[ID_item]) t = alpha(fill_item[ID_item]) ;
    int c = color(hue(fill_item[ID_item]), saturation(fill_item[ID_item]), brightness(fill_item[ID_item]), t ) ;
    // security against the blavk bug opacity
    if (alpha(c) == 0 ) {
      noFill() ; 
      noStroke() ; 
    } else {     
      fill (c) ; 
    }
    
    //rotation / deg
    float angle = map(dir_x_item[ID_item], 0,360, 0, TAU) ;
    //amplitude
    float amp = map(swing_x_item[ID_item],0,1, 1, height  / 4) ;

    // pos clock
    if(motion[ID_item]) {
      local_frameCount += 1 ;
      int direction = 1 ;
      if(reverse[ID_item]) direction = -1 ;
      float speed_x = speed_x_item[ID_item] *.02f ;
      float speed_y = speed_x_item[ID_item] *.01f ;
      float speed_z = speed_x_item[ID_item] *.03f ;
      float pos_x = sin(local_frameCount *speed_x *direction) *width *.5f  +(width/2)  ;
      float pos_y = cos(local_frameCount *speed_y *direction) *height *.5f +(height/2) ;
      float pos_z = sin(local_frameCount *speed_z *direction) *height ;
      pos_clock = Vec3(pos_x,pos_y,pos_z) ;
    }

    
    //CHANGE MODE DISPLAY
    /////////////////////
    if (mode[ID_item] == 0 ) {
      horlogeCercle (pos_clock, angle, amp, 12 ) ; // on 12 hours model english clock
    } else if (mode[ID_item] == 1 ) {
      horlogeCercle (pos_clock, angle,  amp, 24 ) ; // on 24 hours model international clock
    } else if (mode[ID_item] == 2 ) {
      horlogeLigne  (pos_clock, angle, amp, 12 ) ; // on 12 hours model english clock
    } else if (mode[ID_item] == 3 ) {
      horlogeLigne  (pos_clock, angle, amp, 24 ) ; // on 24 hours model international clock
    } else if (mode[ID_item] == 4 ) {
      horlogeMinute(pos_clock, angle) ;
    } else if (mode[ID_item] == 5 ) {
      horlogeSeconde(pos_clock, angle) ;
    }

  }
  
  
  //ANNEXE
  public void horlogeCercle(Vec3 posHorloge, float angle, float  amp, int timeMode) {
    //Angles pour sin() et cos() d\u00e9part \u00e0 3h, enlever PI/2 pour un d\u00e9part \u00e0 midi
    float s = map (second(), 0, 60, 0,    TWO_PI ) - HALF_PI ;
    float m = map (minute(), 0, 60, 0,    TWO_PI ) - HALF_PI ;
    float h = map (hour() % 12, 0, 12, 0, TWO_PI ) - HALF_PI ;
    
    
    //seconde
    textAlign(CENTER, CENTER) ;
    translate(posHorloge.x, posHorloge.y, posHorloge.z) ;
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
  public void horlogeLigne(Vec3 posHorloge, float angle, float amp, int timeMode) {
    //seconde
    textAlign(CENTER, CENTER) ;
    translate(posHorloge.x, posHorloge.y, posHorloge.z) ;
    rotate(angle) ;
    text( nf(hour()%timeMode,2)   + "." + 
          nf(minute(),2)   + "." + 
          nf(second(),2), 
          0, 0);
    textAlign(LEFT, TOP) ;
  }
  
  ////
  public void horlogeMinute(Vec3 posHorloge, float angle) {
    textAlign(CENTER, CENTER) ;
    translate(posHorloge.x, posHorloge.y, posHorloge.z) ;
    rotate(angle) ;
    text(hour() *60 + minute() + " MINUTES", 0,0) ;
    textAlign(LEFT, TOP) ;
  }
  
  ////
  public void horlogeSeconde(Vec3 posHorloge, float angle) {
    textAlign(CENTER, CENTER) ;
    translate(posHorloge.x, posHorloge.y, posHorloge.z) ;
    rotate(angle) ;
    text((hour() *3600) + (minute() *60) + second() + " SECONDES", 0,0) ;
    textAlign(LEFT, TOP) ;
  }
}
//end object one
/**
RSS || 2012 || 1.1.0
*/
class RSS extends Romanesco {
  public RSS() {
    //from the index_objects.csv
    RPE_name = "RSS" ;
    ID_item = 3 ;
    ID_group = 1 ;
    RPE_author  = "Stan Le Punk";
    RPE_version = "version 1.1";
    RPE_pack = "Base" ;
    romanescoRender = "classic" ;
    RPE_mode = "" ; // separate the name by a slash and write the next mode immadialtly after this one.
    RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Size X,Canvas X,Canvas Y,Canvas Z,Direction X" ;
  }
  //GLOBAL
  FeedReader flux;
  String RSSliberation, RSSlemonde;
  float Rinfo ;
  int info = 0 ; 
  String messageRSS ;
  
  
  //SETUP
  public void setup() {
    
    startPosition(ID_item,width/10, height/2, 0) ;
    
    /*
    if(internet) {
      println("je suis RSS problem 1") ;
      String [] fluxRSS = loadStrings(preference_path+"network/RSSReference.txt") ;
      println("je suis RSS problem 2") ;
      String RSS = join(fluxRSS, "") ;
      println("je suis RSS problem 3") ;
      try {
        // flux = new FeedReader(RSS);
      } catch(Exception e) {
        println("je suis RSS problem 4") ;
        e.printStackTrace() ;
      }
    }
    */

    
    
  }
  
  
  
  
  //DRAW
  public void draw() {
    float sizeFont = font_size_item[ID_item] ;
    textFont(font[ID_item], sizeFont + ( sizeFont *mix[ID_item]) *allBeats(ID_item) );
    // couleur du texte
    float t = alpha(fill_item[ID_item]) * abs(mix[ID_item]) ;
    if ( sound[ID_item] ) { t = alpha(fill_item[ID_item]) ; } 
    int c = color(hue(fill_item[ID_item]), saturation(fill_item[ID_item]), brightness(fill_item[ID_item]), t ) ;
    // security against the blavk bug opacity
    if (alpha(c) == 0 ) {
      noFill() ; 
      noStroke() ; 
    } else {     
      fill (c) ; 
    }
    
    //hauteur largeur, height & width
    float ratioTextBox ;
    ratioTextBox = allBeats(ID_item) *.25f ;
    if(ratioTextBox < 1 ) ratioTextBox = 1.f ;
    float largeur = canvas_x_item[ID_item] *ratioTextBox ;
    float hauteur = canvas_y_item[ID_item] *ratioTextBox ;    
      
    for( int i=info; i < info + 1; i++) {
      //internet = false ;
      if (internet && FULL_RENDERING) {
        if(i<flux.entry.length) messageRSS =  (i +""+flux.entry[i]) ;  else messageRSS =("  Big Brother is watching you") ;
      } else messageRSS = ("  Big Brother is watching you") ;
      int r ;
      if ( i > 9 ) r =2 ; else if( i > 0 && i < 10 ) r =1 ; else r =0 ; 
      String hune = messageRSS.substring(r);
      //rotation / degr\u00e9
      rotation(dir_x_item[ID_item], mouse[ID_item].x, mouse[ID_item].y) ;
      if(horizon[ID_item]) textAlign(CENTER) ; else textAlign(LEFT) ;
      text(hune, 0, 0, largeur, hauteur );
    }
    
    // BUTTON
    if(action[ID_item] && nTouch ) {
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
/**
KARAOKE || 2011 || 2.0.0
*/

class Karaoke extends Romanesco {
  public Karaoke() {
    //from the index_objects.csv
    RPE_name = "Karaoke" ;
    ID_item = 4 ;
    ID_group = 1 ;
    RPE_author  = "Stan LePunk";
    RPE_version = "Version 2.0";
    RPE_pack = "Base" ;
    RPE_mode = "" ; // separate the name by a slash and write the next mode immadialtly after this one.
    RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Size X,Canvas X,Canvas Y,Direction X" ;
  }
  //GLOBAL
  int chapter, sentence ;
  
  //SETUP
  public void setup() {
    startPosition(ID_item, width/2, height/2, 0) ;
  }
  
  
  
  
  //DRAW
  public void draw() {
    load_txt(ID_item) ;
    
    float sizeFont = font_size_item[ID_item] ;
    
    textFont(font[ID_item], sizeFont + ( sizeFont *mix[ID_item]) *allBeats(ID_item) );
    // couleur du texte
    float t = alpha(fill_item[ID_item]) * abs(mix[ID_item]) ;
    if ( sound[ID_item] ) { t = alpha(fill_item[ID_item]) ; } 
    int c = color(hue(fill_item[ID_item]), saturation(fill_item[ID_item]), brightness(fill_item[ID_item]), t ) ;
    // security against the blavk bug opacity
    if (alpha(c) == 0 ) {
      noFill() ; 
      noStroke() ; 
    } else {     
      fill (c) ; 
    }
    
    //hauteur largeur, height & width
    float largeur = canvas_x_item[ID_item] *15 ;
    float hauteur = canvas_y_item[ID_item] *15 ;
    
    //tracking chapter
    String karaokeChapters [] = split(text_import[ID_item], "*") ;
    //security button
    if(action[ID_item] && nLongTouch ) {
      
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
      rotation(dir_x_item[ID_item], mouse[ID_item].x, mouse[ID_item].y) ;
      //DISPLAY
      textAlign(CORNER);
      textFont(font[ID_item], sizeFont+ (mix[ID_item]) *6 *beat[ID_item]);
      text(karaokeSentences[sentence], 0, 0, largeur, hauteur) ;
    }

  }
}
//end object one

/**
ORBITAL || 2015 || 0.0.2
*/
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
    RPE_name = "Orbital" ;
    ID_item = 5 ;
    ID_group = 1 ;
    RPE_author  = "Alexandre Petit";
    RPE_version = "Version 0.0.2";
    RPE_pack = "Workshop" ;
    RPE_mode = "" ; // separate the differentes mode by "/"
    /** 
    List of the available sliders
    "Hue fill,Saturation fill,Brightness fill,Alpha fill,Hue stroke,Saturation stroke,Brightness stroke,Alpha stroke,Thickness,
    Size X,Size Y,Size Z,Canvas X,Canvas Y,Canvas Z,Quantity,
    Speed,Direction,Angle,Amplitude,Analyze,Family,Life,Force" ; 
    */
    RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Stroke hue,Stroke sat,Stroke bright,Stroke alpha,Quantity,Speed X" ;
  }
 
  // Main method
  // setup
  public void setup() {
    startPosition(ID_item, width/2, height/2, 0);
  
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
  public void draw() {
    // it's nice to code the variable from the sliders or from sound... here to see easily what's happen in your object.
    float quantity = quantity_item[ID_item] *2.f ;

    // display
    orbital_1(quantity) ;

    objectInfo[ID_item] = ("There is " + flock.size() + " orbital shape") ;
    

  }
 
  public void orbital_1(float quantity) {
    update(quantity);
    render();
  }
 
 
  public void update(float quantity) {
  
    checkControls();
  
    rotationToReach.x += rfactors.x * vel * speed_x_item[ID_item];
    rotationToReach.y += rfactors.y * vel * speed_x_item[ID_item];
    rotationToReach.z += rfactors.z * vel * speed_x_item[ID_item];
    rotation.x += (rotationToReach.x - rotation.x) * smoothf;
    rotation.y += (rotationToReach.y - rotation.y) * smoothf;
    rotation.z += (rotationToReach.z - rotation.z) * smoothf;
    normaliseRotation(); // keep values between 0 and 2PI // FIXME
  
  
    Boid_Orbital b;
    PVector force = new PVector(initialForce *kick[ID_item], 0, 0);
    int it = ceil(iterations *quantity);
    if(!FULL_RENDERING) it /= 10 ;
    float lSpreadL = 1 ;
    float lSpreadW = 1 ;
    for(int i = 0; i < it; i++) {
        if (sound[ID_item] && i < NUM_BANDS) {
            lSpreadL = spreadL * band[ID_item][i];
            lSpreadW = spreadW * band[ID_item][i];
        }
        b = new Boid_Orbital(offset + (float)i/iterations * (rad * mix[ID_item]), 0, 0, rotation, spreadW, lSpreadL);
        b.applyForce(force);
        flock.addBoid(b);
      
       
        rotation.mult(-1);
        b = new Boid_Orbital(offset + (float)i/iterations * (rad * mix[ID_item]), 0, 0, rotation, spreadW, lSpreadW);
        b.applyForce(force);
        flock.addBoid(b);
        rotation.mult(-1);
    }
  
    flock.update();
  }
 
  public void checkControls() {
     if      (rTouch && action[ID_item]) changeDir();
     else if (xTouch && action[ID_item]) randomDir();
     else if (nTouch && action[ID_item]) randomPos();
     // else if (jTouch) ;//randomiserad = D_MIN + random(D_MAX - D_MIN);
     else if (kTouch && action[ID_item]) resetOrbit();
     else if (jTouch && action[ID_item]) jump();
  }
 
  public void render() {
      //flock.render();
      flock.render(hue(fill_item[ID_item]),
                   saturation(fill_item[ID_item]),
                   brightness(fill_item[ID_item]),
                   alpha(fill_item[ID_item]),
                  
                   hue(stroke_item[ID_item]),
                   saturation(stroke_item[ID_item]),
                   brightness(stroke_item[ID_item]),
                   alpha(stroke_item[ID_item])
               );
                 
  }
 
  public void changeDir() {
    int aux;
    do aux = (int)random(3);
    while(aux == dir);
    dir = aux;
  
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
/**
ATOME || 2012 || 1.3.2
*/

ArrayList<Atom> atomList ;

//object one
class Atome extends Romanesco {
  public Atome() {
    //from the index_objects.csv
    RPE_name = "Atome" ;
    ID_item = 6 ;
    ID_group = 1 ;
    RPE_author  = "Stan le Punk";
    RPE_version = "version 1.3.2";
    RPE_pack = "Base" ;
    RPE_mode = "Chemical Name/File text/Electronic cloud/Ellipse circle/Ellipse triangle/Ellipse cloud/Triangle circle/Triangle triangle/Triangle cloud/Rectangle rectangle/Rectangle cloud" ;
    RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Stroke hue,Stroke sat,Stroke bright,Stroke alpha,Thickness,Size X,Size Y,Size Z,Canvas X,Canvas Y,Speed X,Direction X,Variety,Quantity,Area,Angle" ;
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
  public void setup() {
    startPosition(ID_item, width/2, height/2, 0) ;
    
    atomList = new ArrayList<Atom>();
    
    //add one atom to the start
   PVector pos = new PVector (random(width), random(height), 0) ;
   PVector vel = new PVector ( random(-1, 1), random(-1, 1), random(-1, 1) ) ;
   int Z = 1 ; // 1 is the hydrogen ID, you can choice between 1 to 118 the last atom knew
   int ion = round(random(0,0));
   float rebound = 0.5f ;
   int diam = 5 ;
   int Kstart = PApplet.parseInt(abs( mix[ID_item]) *1000) ; // Temperature of Atom, influence the mouvement behavior
   //motion
   
   Atom atm = new Atom( pos, vel, Z, ion, rebound, diam,  Kstart) ; 
   atomList.add(atm) ;
   
  }
  //DRAW
  public void draw() {
    // SETTING PARAMETER
    load_txt(ID_item) ;
    // 3D or 2D
    if(parameter[ID_item] & dTouch) threeDimension = !threeDimension ;
    
    //speed
    float speed = (speed_x_item[ID_item] *100) *(speed_x_item[ID_item] *100) ;
    float velLimit = tempo[ID_item] *5.0f ; // max of speed Atom
    if (velLimit < 1.1f ) velLimit = 1.1f ;
    //the atom temperature give the speed 
    if(sound[ID_item]) atomTemperature =  floor(speed *tempo[ID_item]) ; else atomTemperature = round(speed) ;
    //ratio evolution for atom temperature...give an idea to change the speed of this one
    //because the temp of atom is linked with velocity of this one.
    float tempAbs = 10.0f ;
    
    //VELOCITY and DIRECTION of atom
    if(motion[ID_item]) {
      if(spaceTouch && action[ID_item]) {
        newDirection = new PVector (-pen[ID_item].x, -pen[ID_item].y ) ;
      } else { 
        newDirection = normal_direction(PApplet.parseInt(dir_x_item[ID_item])) ;
      }
    } else {
      newDirection = new PVector () ;
    }
    
    PVector newVelocity = new PVector (sq(tempo[ID_item]) *1000.f, sq(tempo[ID_item]) *1000.f);
    //security if the value is null to don't stop the move
    float acceleration ; 
    if(pen[ID_item].z == 0 ) acceleration = 1.f ; else acceleration = pen[ID_item].z *1000.f ;
    
    
    PVector soundDirection = new PVector() ;
    if(sound[ID_item]) soundDirection = new PVector(right[ID_item], left[ID_item]) ; else soundDirection = new PVector(0, 0) ;

    float velocityX = newDirection.x *newVelocity.x *acceleration ;
    float velocityY = newDirection.y *newVelocity.y *acceleration ;
    PVector changeVelocity = new PVector (velocityX, velocityY) ;
    
    // FACTOR SOUND REACTIVITY
    float maxBeat = map(swing_x_item[ID_item],0,1,1,15) ;
    beat[ID_item] = map(beat[ID_item],1,10, 1,maxBeat) ;
    kick[ID_item] = map(kick[ID_item],1,10, 1,maxBeat) ;
    snare[ID_item] = map(snare[ID_item],1,10, 1,maxBeat) ;
    hat[ID_item] = map(hat[ID_item],1,10, 1,maxBeat) ;
    
    // thickness
    float thickness = map(thickness_item[ID_item],0, width/3, 0, width/20) ;
    
    // TEXT
    float sizeFont = font_size_item[ID_item] *1.5f ;
    PVector posText = new PVector ( 0.0f, 0.0f, 0.0f ) ;
    int sizeTextName = PApplet.parseInt(sizeFont) ;
    int sizeTextInfo = PApplet.parseInt(sizeFont *.5f) ;

    //Canvas
    PVector marge = new PVector(map(canvas_x_item[ID_item], width/10, width, width/20, width *3) , map(canvas_y_item[ID_item], height/10, height, height/20, height *3) ) ;
      
      
      
    
    // DISPLAY and UPDATE ATOM
    for (Atom atm : atomList) {
      // main method
      atm.update (atomTemperature, velLimit, changeVelocity, tempAbs, soundDirection) ; // obligation to use this void, in the atomic univers
      atm.covalentCollision (atomList);
      
      // SIZE
      float sizeAtomeRawX = map (size_x_item[ID_item], .1f, width, .2f, width *.05f) ;
      float sizeAtomeRawY = map (size_y_item[ID_item], .1f, width, .2f, width *.05f) ;
      float sizeAtomeRawZ = map (size_z_item[ID_item], .1f, width, .2f, width *.05f) ;
      float sizeAtomeX = sizeAtomeRawX *beatSizeProton ;
      float sizeAtomeY = sizeAtomeRawY *beatSizeProton ;
      float sizeAtomeZ = sizeAtomeRawZ *beatSizeProton ;
      PVector sizeAtomeXYZ = new PVector(sizeAtomeX,sizeAtomeY,sizeAtomeZ) ;
      //diameter
      float factorSizeField = sizeAtomeX *1.2f ; // factor size of the electronic Atom's Cloud
       //width
      float posTextInfo = map(size_y_item[ID_item], .1f, width,sizeAtomeRawX*.2f, width*.2f) + (beat[ID_item] *2.0f)  ;

    
      
      //DISPLAY
      //PARAMETER FROM ROMANESCO
      //the proton change the with the beat of music
      int max = 118 ;
      if( (nTouch && action[ID_item]) || rangeA == 0 ) {
        rangeA = round(random(0,max-80)) ;
        rangeB = round(random(rangeA,max-40)) ;
        rangeC = round(random(rangeB,max)) ;
      }
      

      if ( atm.getProton() < rangeA ) { 
        beatSizeProton = beat[ID_item] ;
      } else if ( atm.getProton() > rangeA && atm.getProton() < rangeB ) {
        beatSizeProton = kick[ID_item] ;
      } else if ( atm.getProton() > rangeB && atm.getProton() < rangeC ) {
        beatSizeProton = snare[ID_item] ;
      } else if ( atm.getProton()  > rangeC ) {
        beatSizeProton = hat[ID_item] ;
      }
      /////////////////CLOUD///////////////////////////////////////
      if ( atm.getProton() < 41 ) { 
        beatThicknessCloud = beat[ID_item] ;
      } else if ( atm.getProton() > 40 && atm.getProton() < 66 ) {
        beatThicknessCloud = kick[ID_item] ;
      } else if ( atm.getProton() > 65 && atm.getProton() < 91 ) {
        beatThicknessCloud = snare[ID_item] ;
      } else if ( atm.getProton()  > 90 ) {
        beatThicknessCloud = hat[ID_item] ;
      }

      

      //MODE OF DISPLAY
      //RPE_mode = "Chemical Name/File text/Electronic cloud/Ellipse schema/Ellipse cloud/Triangle schema/Triangle cloud/Rectangle schema/Rectangle cloud/Box schema/Box cloud/Sphere schema/Sphere cloud" ;
      if (mode[ID_item] == 0 || mode[ID_item] == 255 ) 
      atm.titleAtom2D (fill_item[ID_item], stroke_item[ID_item], font[ID_item], sizeTextName, sizeTextInfo, posTextInfo, angle_item[ID_item]) ; // (color name, color Info, PFont, int sizeTextName,int  sizeTextInfo )
      else if (mode[ID_item] == 1 ) { 
        atm.title2D(fill_item[ID_item], font[ID_item], sizeTextName, posText, angle_item[ID_item]) ;
      } else if (mode[ID_item] == 2 ) {
        atm.display("", "POINT", sizeAtomeXYZ, fill_item[ID_item], stroke_item[ID_item], thickness, angle_item[ID_item]) ;
      } else if (mode[ID_item] == 3 ) {
        if(threeDimension) atm.display("SPHERE", "ELLIPSE", sizeAtomeXYZ, fill_item[ID_item], stroke_item[ID_item], thickness, angle_item[ID_item]) ;
        else atm.display("ELLIPSE", "ELLIPSE", sizeAtomeXYZ, fill_item[ID_item], stroke_item[ID_item], thickness, angle_item[ID_item]) ;
      } else if (mode[ID_item] == 4 ) {
        if(threeDimension) atm.display("SPHERE", "TRIANGLE", sizeAtomeXYZ, fill_item[ID_item], stroke_item[ID_item], thickness, angle_item[ID_item]) ;
        else atm.display("ELLIPSE", "TRIANGLE", sizeAtomeXYZ, fill_item[ID_item], stroke_item[ID_item], thickness, angle_item[ID_item]) ;
      } else if (mode[ID_item] == 5 ) {
        if(threeDimension) atm.display("SPHERE", "POINT", sizeAtomeXYZ, fill_item[ID_item], stroke_item[ID_item], thickness, angle_item[ID_item]) ;
        else atm.display("ELLIPSE", "POINT", sizeAtomeXYZ, fill_item[ID_item], stroke_item[ID_item], thickness, angle_item[ID_item]) ;
      } else if (mode[ID_item] == 6 ) {
        if(threeDimension) atm.display("TETRA", "ELLIPSE", sizeAtomeXYZ, fill_item[ID_item], stroke_item[ID_item], thickness, angle_item[ID_item]) ;
        else atm.display("TRIANGLE", "ELLIPSE", sizeAtomeXYZ, fill_item[ID_item], stroke_item[ID_item], thickness, angle_item[ID_item]) ;
      } else if (mode[ID_item] == 7 ) {
        if(threeDimension) atm.display("TETRA", "TRIANGLE", sizeAtomeXYZ, fill_item[ID_item], stroke_item[ID_item], thickness, angle_item[ID_item]) ;
        else atm.display("TRIANGLE", "TRIANGLE", sizeAtomeXYZ, fill_item[ID_item], stroke_item[ID_item], thickness, angle_item[ID_item]) ;
      } else if (mode[ID_item] == 8 ) {
        if(threeDimension) atm.display("TETRA", "POINT", sizeAtomeXYZ, fill_item[ID_item], stroke_item[ID_item], thickness, angle_item[ID_item]) ;
        else atm.display("TRIANGLE", "POINT", sizeAtomeXYZ, fill_item[ID_item], stroke_item[ID_item], thickness, angle_item[ID_item]) ;
      } else if (mode[ID_item] == 9 ) {
        if(threeDimension) atm.display("BOX", "RECTANGLE", sizeAtomeXYZ, fill_item[ID_item], stroke_item[ID_item], thickness, angle_item[ID_item]) ;
        else atm.display("RECTANGLE", "RECTANGLE", sizeAtomeXYZ, fill_item[ID_item], stroke_item[ID_item], thickness, angle_item[ID_item]) ;
      } else if (mode[ID_item] == 10 ) {
        if(threeDimension) atm.display("BOX", "POINT", sizeAtomeXYZ, fill_item[ID_item], stroke_item[ID_item], thickness, angle_item[ID_item]) ;
        else atm.display("RECTANGLE", "POINT", sizeAtomeXYZ, fill_item[ID_item], stroke_item[ID_item], thickness, angle_item[ID_item]) ;
      }
 

      
      //UNIVERS
      ////////////////////////////////////////////////////////////////////////////////////////////
      atm.universWall2D( bottom, top, wallRight, wallLeft, false, marge) ; // obligation to use this void
      ////////////////////////////////////////////////////////////////////////////////////////////
    }
    
    // info display
    objectInfo[ID_item] = ("Atoms "+atomList.size()) ;
    

    //CLEAR
    if (resetAction(ID_item)) atomList.clear() ;
    //ADD ATOM
    int maxValueReproduction = 25 ;
    if(FULL_RENDERING) maxValueReproduction = 1 ; else maxValueReproduction = 25 ;
    int speedReproduction = round(map(quantity_item[ID_item],0, 1, 30, maxValueReproduction));
    if(action[ID_item] && nLongTouch && clickLongLeft[ID_item] && frameCount % speedReproduction == 0) atomAdd(giveNametoAtom(), item_setting_position[0][ID_item]) ;
    
    if(atomList.size()<1) {
      int num = PApplet.parseInt(random(1,9)) ;
      for(int i = 0 ; i < num ; i++ ) {
        atomAdd(giveNametoAtom(), item_setting_position[0][ID_item]) ;
      }
    }

  }
  //END DRAW
  /////////
  
  
  
  
  
  //ANNEXE
  
  //give name to the atom from the file.txt in the source repository
  public String giveNametoAtom() {
    String s = ("") ;
    int whichChapter = floor(random(numChapters(text_import[ID_item]))) ;
    int whichSentence = floor(random(numMaxSentencesByChapter(text_import[ID_item]))) ;
    //give a random name, is this one is null in the array, give the tittle name of text
    if(whichSentence(text_import[ID_item], whichChapter, whichSentence) != null ) s = whichSentence(text_import[ID_item], whichChapter, whichSentence) ; else s = whichSentence(text_import[ID_item], 0, 0) ;
    return s ;
  }
  

  //Add atom with a specific name
  public void atomAdd(String name, Vec3 newPos) {
    //data
    //amplitude
    //give the field of type of atome must be create
    float numP = map(variety_item[ID_item], 0,1,1,118) ; //
    int Z = PApplet.parseInt(random (1,numP)) ; // Z is the number of protons give the number of electrons max knew is 118
    int ion = round(random(0,0)); // number of electron(s) less(Anion)   more(Cation)   / give the magnetism & conductivity of the atome cannot be equal or sup to "Z"proton
    
    int Kstart = PApplet.parseInt(abs( mix[ID_item]) *1000) ; // Temperature of Atom, influence the mouvement behavior

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
    primitive(Vec2(),size.x,3) ;
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
    float radius = radiusElectronicFieldCovalent() *newAmplitudeElectrocField ;
    primitive(Vec2(),radius,3) ;
    primitive(Vec2(),radius,3) ;
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
/**
The ABBYSS || 2014 || 2.1.1
*/

CreatureManager creatureManager ;
boolean useBackdrop = false;

//object one
class The_Abbyss extends Romanesco {
  public The_Abbyss() {
    //from the index_objects.csv
    RPE_name = "The Abbyss" ;
    ID_item = 7 ;
    ID_group = 1 ;
    RPE_author  = "Andreas Gysin";
    RPE_version = "version 2.1.1";
    RPE_pack = "Base" ;
    RPE_mode = "Box Fish/Cubus/Floater/Radio/Worm/Sea Fly/Breather/Spider/Manta/Father/Super Nova" ;// separate the name by a slash and write the next mode immadialtly after this one.
    RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Stroke hue,Stroke sat,Stroke bright,Stroke alpha,Thickness" ;
  }
  //GLOBAL
  
  //SETUP
  public void setup() {
    startPosition(ID_item, width/2, height/2, 0) ;
    creatureManager = new CreatureManager(callingClass);
  }
  //DRAW
  public void draw() {
    if(alpha(stroke_item[ID_item]) == 0 ) thickness_item[ID_item] = 0 ;
    creatureManager.loop(fill_item[ID_item], stroke_item[ID_item], thickness_item[ID_item], speed_x_item[ID_item] *100.0f);
    
    
    
    
    //CHANGE MODE DISPLAY
    /////////////////////
    int whichCreature ; 
    if (mode[ID_item] == 0 || mode[ID_item] == 255 ) whichCreature = 0 ;
    else if (mode[ID_item] == 1 ) whichCreature = 1 ;
    else if (mode[ID_item] == 2 ) whichCreature = 2 ;
    else if (mode[ID_item] == 3 ) whichCreature = 3 ;
    else if (mode[ID_item] == 4 ) whichCreature = 4 ;
    else if (mode[ID_item] == 5 ) whichCreature = 5 ;
    else if (mode[ID_item] == 6 ) whichCreature = 6 ;
    else if (mode[ID_item] == 7 ) whichCreature = 7 ;
    else if (mode[ID_item] == 8 ) whichCreature = 8 ;
    else if (mode[ID_item] == 9 ) whichCreature = 9 ;
    else if (mode[ID_item] == 10 ) whichCreature = 10 ;
    else if (mode[ID_item] == 11 ) whichCreature = 11 ;
    else if (mode[ID_item] == 12 ) whichCreature = 12 ;
    else whichCreature = 0 ;
    
    if(action[ID_item]) {
      if (nLongTouch && frameCount % 3 == 0) creatureManager.addCurrentCreature(whichCreature);
      //to cennect the creature to the camera
      if(cLongTouch) {
        if (upTouch )    creatureManager.nextCameraCreature();
        else if (downTouch )  creatureManager.prevCameraCreature();
      }
    }
    //
    if (resetAction(ID_item)) creatureManager.killAll(whichCreature);
    
    // info display
    objectInfo[ID_item] = ("Creatures "+ creatureManager.creatures.size()) ;

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
/**
BOIDS || 2015 || 1.0.1
*/

class Boids extends Romanesco {
  public Boids() {
    RPE_name = "Boids" ;
    ID_item = 8 ;
    ID_group = 1 ;
    RPE_author  = "Stan le Punk";
    RPE_version = "Version 1.0.1";
    RPE_pack = "Base" ;
    RPE_mode = "Tetra monochrome/Tetra camaieu" ; // separate the differentes mode by "/"
    RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Stroke hue,Stroke sat,Stroke bright,Stroke alpha,Thickness,Size X,Canvas X,Canvas Y,Canvas Z,Quantity,Attraction,Repulsion,Influence,Alignment,Speed X" ;
  }
  
  Flock flock;
  Canvas myCanvas ;
  PVector birthPlace ;
  int maxColorRef = 360 ; // here we are in HSB 360
  int rangeAroundYourColor = 70 ;
  int numOfBoid ;
  // Main method
  // setup
  public void setup() {
   startPosition(ID_item, width/2, height/2, -width) ;
   // build the canvas where the boid can move
   PVector pos = new PVector (0, 0, 0) ;
   PVector size = new PVector(width,width,width) ;
   // PVector size = new PVector(canvas_x_item[ID_item],canvas_y_item[ID_item],canvas_z_item[ID_item]) ;
   myCanvas = new Canvas(pos, size) ;
   // color colorBoid = color(80,100,100) ;
   birthPlace = pos.copy() ;
   flock = new Flock() ;

   // tetrahedronAdd() : weird why this method is here ?
   tetrahedronAdd() ;
  }
  
  // draw
  public void draw() {
    // MAIN method
    float thickness = map(thickness_item[ID_item],0,width/3,0,width/30 ) ;
    int size = (int)map(size_x_item[ID_item],.1f,width, 2,width/10) ;
    float alignment = map(alignment_item[ID_item],0,1,0,10) ;
    float cohesion = map(attraction_item[ID_item],0,1,0,10) ;
    float separation = map(repulsion_item[ID_item],0,1,0,10) ;
    PVector unity = new PVector(cohesion, separation) ;
    if(flock.listBoid.size() > 0 )flock.run(alignment, unity);
    
    // ANNEXE methods
    
    // GOAL of the boids
    if(spaceTouch) {
      float depthGoal =sin(frameCount *.002f) *width ;
      float pos_x = map(mouse[ID_item].x,0,width, -canvas_x_item[ID_item], canvas_x_item[ID_item] ) ;
      float pos_y = map(mouse[ID_item].y,0,height, -canvas_y_item[ID_item], canvas_y_item[ID_item] ) ;
      flock.goal(pos_x,pos_y, depthGoal);
    }

    int beat_sensibility = 5 ;
    if(allBeats(ID_item) > beat_sensibility) {      
      float depthGoal =sin(frameCount *.003f) *width ;
      float pos_x = sin(frameCount *.003f) *canvas_x_item[ID_item] ;
      float pos_y = cos(frameCount *.003f) *canvas_y_item[ID_item] ;
      flock.goal(pos_x,pos_y, depthGoal);
    }


    
    // INFLUENCE of the boid around him
    float ratioInfluence = influence_item[ID_item] *400 +1 ;
    float influenceArea =  abs(sin(frameCount *.001f) *ratioInfluence) ;
    flock.influence(influenceArea);
    
    // SPEED
    float speed = map(speed_x_item[ID_item],0,1,.1f,7) ;
    speed *= speed ;
    if(sound[ID_item] )speed *= (map(mix[ID_item],0,1,.00000001f,7)) ;
    if(!motion[ID_item] || (sound[ID_item] && getTimeTrack() < .2f)) speed = .00000001f ;
    flock.speed(speed) ;
    
    // cage size
    myCanvas.size.x = canvas_x_item[ID_item] *10 ;
    myCanvas.size.y = canvas_y_item[ID_item] *10 ;
    myCanvas.size.z = canvas_z_item[ID_item] *10 ;
    myCanvas.update() ;
  
    flock.canvasSetting(myCanvas.left, myCanvas.right, myCanvas.top, myCanvas.bottom, myCanvas.front, myCanvas.back) ;
    
    // quantity of boids
    numOfBoid = PApplet.parseInt(quantity_item[ID_item] *700 +30); //amount of boids to start the program with
    if(!FULL_RENDERING) numOfBoid /= 15 ;
    
    // change the setting of the boid
    for(Boid b : flock.listBoid) {
      b.fillBoid = color(hue(b.fillBoid), saturation(fill_item[ID_item]), brightness(fill_item[ID_item]), alpha(fill_item[ID_item])) ;
      b.strokeBoid = color(hue(b.strokeBoid), saturation(stroke_item[ID_item]), brightness(stroke_item[ID_item]), alpha(stroke_item[ID_item])) ;
      b.size = size ;
      b.thickness = thickness;
    }
    
    
    if(flock.listBoid.size() < 1 ) {
      flock.add(birthPlace, numOfBoid, fill_item[ID_item], stroke_item[ID_item], maxColorRef, rangeAroundYourColor) ;
    }
    
    // clear the boids list
    // flock.clear() ;
    if(nTouch && action[ID_item]) {
      flock.add(birthPlace, numOfBoid, fill_item[ID_item], stroke_item[ID_item], maxColorRef, rangeAroundYourColor) ;
    }
    
    // INFO
    objectInfo[ID_item] = ("There is " + numOfBoid + " boids") ;
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
    if(alpha(fillBoid) == 0 ) noFill() ; else  fill(fillBoid);
    tetrahedron(size) ;

    
    endShape();
    //box(10);
    popMatrix();
  }
}
/**
RUBIS || 2013 || 1.0.3
*/

class MesAmis extends Romanesco {
  public MesAmis() {
    //from the index_objects.csv
    RPE_name = "Rubis" ;
    ID_item = 9 ;
    ID_group = 1 ;
    RPE_author  = "Stan le Punk";
    RPE_version = "version 1.0.2";
    RPE_pack = "Base" ;
    //RPE_mode = "1 full/2 lines" but the line is not really interesting
    RPE_mode = "Vertex/Point" ; // separate the name by a slash and write the next mode immadialtly after this one.
    RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Stroke hue,Stroke sat,Stroke bright,Stroke alpha,Thickness,Canvas X,Speed X,Jitter X,Jitter Y,Jitter Z,Quantity,Swing X" ;
  }
  //GLOBAL
  IntList IDpeople = new IntList() ;
  ArrayList<Ami> listPeople = new ArrayList<Ami>() ;
  int numPeople, rangePeople, refNumPeople ;
  PVector target ;
  boolean goBack  ;
  boolean newPeoplePosition, newPopulation ;
  
  
  //SETUP
  public void setup() {
    startPosition(ID_item, width/2, height/2, 0) ;
    int num = (int)random(15,25)  ;
    rangePeople = width/2 ;
    amiSetting(num, rangePeople) ;
  }
  
  
  

  //DRAW
  public void draw() {
    
    Vec3 center = Vec3() ;

    // speed
    float speed = map(speed_x_item[ID_item],0,1, .0001f, .2f);
    speed = speed*speed ;
    if(sound[ID_item]) speed *= allBeats(ID_item) ;



    Vec3 jitter = Vec3() ;
    if(sound[ID_item] && getTimeTrack() > 0.2f ) {
      float valueX = left[ID_item] *jitter_x_item[ID_item] *width ;
      float valueY = right[ID_item] *jitter_y_item[ID_item] *width ;
      float valueZ = mix[ID_item] *jitter_z_item[ID_item] *width ;
      jitter.set(valueX,valueY,valueZ) ;
    }

    // size of the rubis
    float radiusMax = canvas_x_item[ID_item] *.7f ;
    float radiusMin = map(swing_x_item[ID_item], 0, 1, radiusMax, radiusMax /10) ;


     // stop motion
    if(!motion[ID_item]) { 
      speed = 0 ; 
      jitter.set(0) ;
    }

 


    
    // new population
    int max_people = 150 ;
    if(!FULL_RENDERING)  quantity_item[ID_item] *= .1f ;
    numPeople = (int)map(quantity_item[ID_item],0, 1, 10, max_people) ; 
    if ( numPeople != refNumPeople ) newPopulation = true ;
    refNumPeople = (int)map(quantity_item[ID_item],0, 1, 10, max_people) ;
    if(newPopulation) {
      listPeople.clear() ;
      amiSetting(numPeople, rangePeople) ;
      newPopulation = false ;
    }
    
    
    aspect_rpe(ID_item) ;
    ami_heart_move(center, speed, radiusMin, radiusMax, jitter, mode[ID_item]) ;

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
  public void ami_heart_move(Vec3 posCenter, float speed, float distMin, float distMax, Vec3 jitter, int mode) {
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
      if(mode == 1 ) pointFriends() ;

    }
    
    // info
    objectInfo[ID_item] =(numPeople + " summits") ;
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
  public void pointFriends() {
    if (listPeople.size() > 1 ) {
      //PVector me = ami.pos ;
      // f += 2
     for (Ami ami : listPeople) {
        //Ami amiOne = listPeople.get(ami.friendList[f]) ;
        // Ami amiTwo ;
        //if (ami.friendList[f] +1 >= listPeople.size() )  amiTwo = listPeople.get(ami.friendList[0]) ; else amiTwo = listPeople.get(ami.friendList[f] +1) ; 
        //PVector posAmiOne = amiOne.pos.copy() ;
        //PVector posAmiTwo = amiTwo.pos.copy() ;
        //display
        point(ami.pos.x, ami.pos.y, ami.pos.z) ;
        //point(posAmiOne.x, posAmiOne.y, posAmiOne.z) ;
        // point(posAmiTwo.x, posAmiTwo.y, posAmiTwo.z) ;
      }
    }
  }
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

/**
ARBRE || 2012 || 1.3.1
*/

Arbre arbre ;
//object three
class ArbreRomanesco extends Romanesco {
  public ArbreRomanesco() {
    //from the index_objects.csv
    RPE_name = "Arbre" ;
    ID_item = 10 ;
    ID_group = 1 ;
    RPE_author  = "Stan le Punk";
    RPE_version = "Version 1.3.1";
    RPE_pack = "Base" ;
    RPE_mode = "Line/Disc/Disc line/Rectangle/Rectangle line/Box" ;
    RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Stroke hue,Stroke sat,Stroke bright,Stroke alpha,Thickness,Size X,Size Y,Size Z,Quantity,Speed X,Direction X,Canvas X" ;
  }
  //GLOBAL
  float speed ;
  PVector posArbre = new PVector () ;
  //SETUP
  public void setup() {
    startPosition(ID_item, width/2, height/3, 0) ;
    arbre = new Arbre () ;
  }
  //DRAW
  public void draw() {
    int maxFork ;
    if(FULL_RENDERING) maxFork = 8 ; else maxFork = 4 ; // we can go beyond but by after the calcul slowing too much the computer... 14 is a good limit
    // int maxNode = 32 ; // 
    // num fork for the tree
    int forkA = maxFork ; 
    int forkB = maxFork ;
    
    int n = PApplet.parseInt(map(quantity_item[ID_item],0,1,2,maxFork*2)) ;
    
    float epaisseur = thickness_item[ID_item] ;
    float ratioLeft = map(left[ID_item], 0, 1, .5f, 2) ;
    float ratioRight = map(right[ID_item], 0, 1, .5f, 2) ;
    if(!FULL_RENDERING) {
      ratioLeft = .75f ;
      ratioRight = .75f ;
    }
    float ratioMix = ratioLeft + ratioRight ;

    // quantity of the shape

    //size of the shape
    float divA = .66f ;
    float divB = .66f ;
    if(sound[ID_item]) {
      divA = ratioLeft ;
      divB = ratioRight  ;
    } else {
      divA = .66f ;
      divB = .66f ;
    }
      
    
    //size
    int div_size = 20 ;
    float x = map(size_x_item[ID_item],.1f,width,.1f,width /div_size) ;
    float y = map(size_y_item[ID_item],.1f,width,.1f,width /div_size) ;
    float z = map(size_z_item[ID_item],.1f,width,.1f,width /div_size) ;
    x = x *x *ratioMix ;
    y = y *y *ratioMix ;
    z = z *z *ratioMix ;

    PVector size  = new PVector(x,y,z) ;
    //orientation
    float direction = dir_x_item[ID_item] ;
    //amplitude
    float amplitude = map(swing_x_item[ID_item], 0,1, 0.1f,width *.6f) ;
    if(FULL_RENDERING) amplitude = amplitude *allBeats(ID_item) ;
    



    // angle
    // float angle = map(angle_item[ID_item],0,360,0,180);
    float angle = 90 ; // but this function must be remove because it give no effect
    // speed
    if(motion[ID_item] && FULL_RENDERING) {
      float s = map(speed_x_item[ID_item],0,1,0,2) ;
      s *= s ;
      speed = s *tempo[ID_item] ; 
    } else if (!motion[ID_item] && FULL_RENDERING){ 
      speed = 0.0f ;
    } else {
      speed = 1.0f ;

    }
    
    aspect_rpe(ID_item) ;
    
    arbre.affichage (direction) ;
    arbre.actualisation(posArbre, epaisseur, size, divA, divB, forkA, forkB, amplitude, n, mode[ID_item], angle, speed, ID_item) ;
    
    //info
    objectInfo[ID_item] = ("Nodes " +(n-1) + " - Amplitude " + (int)amplitude + " - Orientation " +direction +  " - Speed " + (int)map(speed,0,4,0,100) );
    
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
/**
BOXOLYZER || 2012|| 1.0.3
*/
ArrayList<BOITEaMUSIQUE> boiteList ;
  
class Boxolyzer extends Romanesco {
  public Boxolyzer() {
    //from the index_objects.csv
    RPE_name = "Boxolyzer" ;
    ID_item = 11 ;
    ID_group = 1 ;
    RPE_author  = "Stan le Punk";
    RPE_version = "Version 1.0.4";
    RPE_pack = "Base" ;
    RPE_mode ="Classic/Circle" ;
    RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Stroke hue,Stroke sat,Stroke bright,Stroke alpha,Thickness,Size X,Size Y,Size Z,Canvas X,Quantity,Direction X" ;
  }
  //GLOBAL
  boolean newDistribution ;
  int numBoxRef ;

  //SETUP
  public void setup() {
    startPosition(ID_item, 0, 0, 0) ;
    
    boitesSetting() ;
  }
  //DRAW
  public void draw() {
    //CLASSIC DISPLAY
    int numBox = PApplet.parseInt(map(quantity_item[ID_item],0, 1, 1, 16)) ;
    if (numBox != numBoxRef ) newDistribution = true ;
    numBoxRef = numBox ;
    Vec3 size = Vec3(size_x_item[ID_item],size_y_item[ID_item],size_z_item[ID_item]) ;
    size.mult(2) ;

    // color and thickness
    aspect_rpe(ID_item) ; 
    //
    distribution(numBox, newDistribution) ;
    
    // MODE DISPLAY with the dropdown menu of controler
    /////////////////////
    if  (mode[ID_item] ==0) boxolyzerClassic(size, horizon[ID_item] , dir_x_item[ID_item]) ;
    else if (mode[ID_item] ==1) boxolyzerCircle(size, (int)canvas_x_item[ID_item], horizon[ID_item], dir_x_item[ID_item]) ;



    // INFO
    objectInfo[ID_item] = ("There is " +numBox + " bands analyzed");
    
  }
  
  //ANNEXE VOID
  public void distribution(int n, boolean newOne) {
     if (newOne) newDistributionBoite(n) ;
     newDistribution = false ;
   }
  
  boolean orientation ;
  // BOXLIZER CIRCLE
  public void boxolyzerCircle(Vec3 size, int diam, boolean groundPosition, float dir) {
    if( action[ID_item] && rTouch ) orientation = !orientation ;
    int surface = diam*diam ; // surface is equale of square surface where is the cirlcke...make sens ?
    int radius = ceil(radius_from_circle_surface(surface)) ;
    
    int n = boiteList.size() ;
    float factorSpectrum = 0 ;
    Vec3 pos = Vec3() ;
    
    for(int i=0; i < n; i++) {
      if(  i < band.length) factorSpectrum = band [ID_item][i] ;
      float stepAngle = map(i, 0, n, 0, 2*PI) ; 
      float angle =  2*PI - stepAngle;
      if(orientation) pos.set(projection(angle, radius).x +pos.x, projection(angle, radius).y +pos.y, pos.z) ;
      else  pos.set(projection(angle, radius).x +pos.x, 0, projection(angle, radius).y +pos.z) ;

      BOITEaMUSIQUE boiteAmusique = (BOITEaMUSIQUE) boiteList.get(i) ;
      boiteAmusique.showTheBoite(pos, size, factorSpectrum, groundPosition, dir) ;
    }
  }



  // EQUALIZER CLASSIC
  public void boxolyzerClassic(Vec3 size, boolean groundPosition, float dir) {
    Vec3 pos = Vec3(0,height *.5f ,0) ;
    float factorSpectrum = 0 ;
    int n = boiteList.size() ;
    // int canvasFinal = width ;
    int canvasFinal = (int)map(canvas_x_item[ID_item], width/10, width, width/2,width*3)  ;
    int displacement_symetric = PApplet.parseInt(width *.5f -canvasFinal *.5f) ;
    for( int i = 0 ; i < n ; i++) {
      pos.x = (i *canvasFinal/n) + (canvasFinal /(n *2)) +displacement_symetric ;
      if( i < band.length) factorSpectrum = band [ID_item][i] ;
      BOITEaMUSIQUE boiteAmusique = (BOITEaMUSIQUE) boiteList.get(i) ;
      if(!FULL_RENDERING) factorSpectrum = .5f ;
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
    Vec3 size = Vec3(1) ;
    BOITEaMUSIQUE boiteAmusique = new BOITEaMUSIQUE(size, ID) ; 
    boiteList.add(boiteAmusique) ;
  }
  // END GLOBAL VOID
}
//END







///////
//CLASS
class BOITEaMUSIQUE {
  //PVector pos = new PVector(0,0,0) ;
  Vec3 size ;
  int ID ;
  
  BOITEaMUSIQUE(Vec3 size, int ID) {
    this.ID = ID ;
    this.size = size ;
  }
  
  
  
  public void showTheBoite(Vec3 pos, Vec3 size, float factor, boolean groundLine, float dir) {
    Vec3 newSize = Vec3(size.x, size.y *factor, size.z *factor) ;
    //put the box on the ground !

    pushMatrix() ;
    if (!groundLine) {
      translate(pos) ; 
    } else {
      float horizon = pos.y -(newSize.z *.5f) ;  
      translate(pos.x, horizon, pos.z) ;
    }
    rotateX(radians(dir)) ;
    box(newSize.x,newSize.y,newSize.z) ;
    popMatrix() ;
  }
}
/**
SOLEIL || 2012 || 1.1.1
*/

class Soleil extends Romanesco {
  public Soleil() {
    //from the index_objects.csv
    RPE_name = "Soleil" ;
    ID_item = 12 ;
    ID_group = 1 ;
    RPE_author  = "Stan le Punk";
    RPE_version = "Version 1.1.1";
    RPE_pack = "Base" ;
    RPE_mode = "Beam/Lie'Bro'One/Lie'Bro'Two/Lie'Bro Noisy" ;
    RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Stroke hue,Stroke sat,Stroke bright,Stroke alpha,Thickness,Canvas X,Quantity,Speed X,Angle,Canvas X" ;
  }
  //GLOBAL
  float jitter ;
  float angleRotation ;
  //SETUP
  public void setup() {
    startPosition(ID_item, width/2, height/2, 0) ;
    
  }
  PVector pos = new PVector() ;
  //DRAW
  public void draw() {
    aspect_rpe(ID_item) ;
    //
    if(spaceTouch && action[ID_item]) pos = new PVector(mouse[ID_item].x -width/2, mouse[ID_item].y -height/2,0) ; else pos = new PVector(0,0,0) ;
    int diam = PApplet.parseInt(map(canvas_x_item[ID_item], width/10, width, width/10, width *1.2f) *allBeats(ID_item) ) ;
    int numBeam = (int)(quantity_item[ID_item] *180 +1) ;
    if(!FULL_RENDERING) numBeam /= 20 ;
    if(numBeam < 2 ) numBeam = 2 ;
    // Jitter
    jitter += (angle_item[ID_item] *.001f ) ;
    float jitting = cos(jitter) *tempo[ID_item] ;
     //noise
     PVector noise = new PVector() ;
     float amp = sq(swing_x_item[ID_item] *10.0f) ;
     float rightNoise =  ((right[ID_item] *right[ID_item] *5) *amp) ;
     float leftNoise = ((left[ID_item] *left[ID_item] *5) *amp) ;
     if (sound[ID_item]) noise = new PVector(rightNoise, leftNoise) ; else noise = new PVector(amp,amp) ;
     // rotation direction
     int direction = 1 ;
     if(reverse[ID_item]) direction = 1 ; else direction = -1 ;
     if(!motion[ID_item]) direction = 0 ;
    // rotation speed
    float speedRotation = 0 ;
    speedRotation = sq(speed_x_item[ID_item] *10.0f *tempo[ID_item]) *direction ;
    angleRotation += speedRotation ;
    rotate (radians(angleRotation)) ;

    // mode
    if(mode[ID_item] == 0) soleil(pos, diam, numBeam) ;
    if(mode[ID_item] == 1) soleil(pos, diam, numBeam, jitting) ;
    if(mode[ID_item] == 2) soleil(pos, diam, numBeam, jitter) ;
    if(mode[ID_item] == 3) soleil(pos, diam, numBeam, jitter, noise) ;
    
    // info display
    String revolution = ("") ;
    if(spaceTouch && action[ID_item]) revolution =("false") ; else revolution = ("true") ;
    objectInfo[ID_item] = ("The sun have " + numBeam + " beams - Motion "+revolution ) ;
    
    
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
/**
SPIRALE  || 2011 || 1.3.1
*/
Spirale spirale ; 
//object three
class SpiraleRomanesco extends Romanesco {
  public SpiraleRomanesco() {
    //from the index_objects.csv
    RPE_name = "Spirale" ;
    ID_item = 13 ;
    ID_group = 1 ;
    RPE_author  = "Stan le Punk";
    RPE_version = "Version 1.3.1";
    RPE_pack = "Base" ;
    RPE_mode = "Rectangle/Ellipse/Box" ;
    RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Stroke hue,Stroke sat,Stroke bright,Stroke alpha,Thickness,Size X,Size Y,Size Z,Quantity,Speed X,Canvas X,Canvas Y,Alignment" ;
  }
  //GLOBAL
     
    float speed ; 
    boolean reverseSpeed;
  //SETUP
  public void setup() {
    startPosition(ID_item, width/2, height/2, 0) ;
    spirale = new Spirale() ;
  }
  //DRAW
  public void draw() {
    aspect_rpe(ID_item) ;
    strokeWeight(thickness_item[ID_item]*.02f) ;
    //quantity
    int n ;
    int nMax = 1 ;
     nMax = 1 + PApplet.parseInt(quantity_item[ID_item] *300) ; 
    if(!FULL_RENDERING) nMax *= .1f ;
    n = nMax ;

    float max = map(width,100,3000,1.0f,1.1f)  ;
    float z = max ;
    //speed
    
    // if(reverse[ID_item]) reverseSpeed = !reverseSpeed ;
    
    if(motion[ID_item]) {
      float s = map(speed_x_item[ID_item],0,1,0,8) ;
      s *= s ;
      if(reverse[ID_item]) speed = s *tempo[ID_item] ; else speed = s *tempo[ID_item] *-1.f ;
    } else { 
      speed = 0.0f ;
    }
    //sound volume
    float minValueVol = .8f ;
    float maxValueVol = 5.5f ;
    if(!sound[ID_item]) maxValueVol = 1 ;
    float volumeLeft = map (left[ID_item], 0,1, minValueVol, maxValueVol ) ;
    float volumeRight = map (right[ID_item], 0,1, minValueVol, maxValueVol ) ;
    float volumeMix = map (mix[ID_item], 0,1, minValueVol, maxValueVol ) ;
    
    
    //SIZE
    float beatMap = map(beat[ID_item] +snare[ID_item] +hat[ID_item],1,9,1,50) ;
    float minValueSize = .5f ;
    float maxValueSize = width *.003f ;
    
    float widthTemp = map(size_x_item[ID_item], .1f, width, minValueSize, maxValueSize) ;
    float heightTemp = map(size_y_item[ID_item], .1f, width, minValueSize, maxValueSize) ;
    float depthTemp  = map(size_z_item[ID_item], .1f, width, minValueSize, maxValueSize) ;
    
    widthTemp *= widthTemp ;
    heightTemp *= heightTemp ;
    depthTemp *= depthTemp ;

    
    float widthObj = pow(widthTemp, 3) *volumeLeft *beatMap ;
    float heightObj = pow(heightTemp, 3) *volumeRight *beatMap ;
    float depthObj = pow(depthTemp, 3) *volumeMix *beatMap ;
    
    PVector size = new PVector(widthObj, heightObj, depthObj) ;
    
    //amplitude of the translate
    float minValueCanvas = .01f ;
    float maxValueCanvas = 3 *(kick[ID_item] *.7f) ;
    float canvasXtemp = map(canvas_x_item[ID_item], width *.1f, width,minValueCanvas,maxValueCanvas) ;
    float canvasYtemp = map(canvas_y_item[ID_item], width *.1f, width,minValueCanvas,maxValueCanvas) ;
    // float canvasZtemp = map(canvas_z_item[ID_item], width *.1, width,minValueCanvas,maxValueCanvas) ;
    PVector canvas = new PVector(canvasXtemp, canvasYtemp)  ;
    
    PVector pos = new PVector() ; // we write that because the first part of the void is not available any more.
    spirale.actualisation (pos, speed) ;
    spirale.affichage (n, nMax, size, z, canvas, mode[ID_item], horizon[ID_item], alignment_item[ID_item]) ;
    
    // info display
    objectInfo[ID_item] = ("Speed "+speed+ " - Amplitude " + map(z, 1.01f, 1.27f, 1,100) + " - Quantity " + nMax) ;
  }
}





//CLASS
class Spirale extends Rotation {  
  Spirale () { 
    super () ;
  }
  float translate = 1.f ;
  float ratioSize = 1.f ;

  public void affichage (int n, int nMax, PVector size, float z, PVector canvas, int mode, boolean horizon, float alignment) {
    n = n-1 ;
    
    translate += z ;
    ratioSize += .1f ;
    
    float ratioRendering = 1.f ;
    if(FULL_RENDERING) ratioRendering = 1.f ; else ratioRendering = 6.f ;
    
    
    PVector newSize = new PVector (size.x *ratioSize *ratioRendering, size.y *ratioSize *ratioRendering, size.z *ratioSize *ratioRendering) ;

    //display Mode
    if (mode == 0 )      rect (0,0, newSize.x, newSize.y ) ;
    else if (mode == 1 ) ellipse (0,0,newSize.x,newSize.y) ;
    else if (mode == 2 ) box (newSize.x,newSize.y,newSize.z) ;
    //
    
    float new_pos_x = translate *canvas.x *ratioRendering ;
    float new_pos_y = translate *canvas.y *ratioRendering ;
    float new_pos_z = 0 ;
    if(horizon) new_pos_z = size.z *.5f *alignment ;

    translate (new_pos_x,new_pos_y,new_pos_z) ;
    rotate ( PI/6 ) ;

    if ( n > 0) { 
      affichage (n, nMax, size, z, canvas, mode, horizon, alignment) ; 
    } else{
      translate = 1.f ;
      ratioSize = 1.f ;
    }
  }
}
/**
BALISE || 2011 || 1.2.1
*/
Balise balise ;
//object three
class BaliseRomanesco extends Romanesco {
  public BaliseRomanesco() {
    //from the index_objects.csv
    RPE_name = "Balise" ;
    ID_item = 14 ;
    ID_group = 1 ;
    RPE_author  = "Stan le Punk";
    RPE_version = "Version 1.2.1";
    RPE_pack = "Base" ;
    RPE_mode = "Disc/Rectangle/Box/Box Snake" ;
    RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Stroke hue,Stroke sat,Stroke bright,Stroke alpha,Thickness,Size X,Size Y,Size Z,Quantity,Speed X,Canvas X,Repulsion" ;
  }
  //GLOBAL
  float speed ;
  boolean change_rotation_direction ;
  //SETUP
  public void setup() {
    startPosition(ID_item, width/2, height/2, 0) ;
    balise = new Balise() ;
  }
  //DRAW
  public void draw() {
    // authorization to make something with the sound in Prescene mode
    boolean authorization = false ;
    float tempo_balise = 1 ;
    if(sound[ID_item] && FULL_RENDERING) {
      authorization = true ;
      tempo_balise = tempo[ID_item] ;
    } else {
      tempo_balise = 1.f ;
    }

    //reverse
    int rotation_direction = 1 ;
    if(reverse[ID_item]) rotation_direction = 1 ; else rotation_direction = -1 ;



    if (motion[ID_item]) speed = (map(speed_x_item[ID_item], 0,1, 0,20)) *tempo_balise *rotation_direction ; else speed = 0.0f ;
    // color and thickness
    aspect_rpe(ID_item) ;

    //amplitude
    float amp = map(swing_x_item[ID_item], 0,1, 0, width *9) ;
    
    //factor size
    float factor = map(repulsion_item[ID_item],0,1,1,100) *(allBeats(ID_item) *.2f) ;
    if(factor < 1.0f ) factor = 1.0f ;


    
    
    
    

    // SIZE
    float factorBeat = .5f ;
    float tempoEffect = 1 + ((beat[ID_item] *factorBeat) + (kick[ID_item] *factorBeat) + (snare[ID_item] *factorBeat) + (hat[ID_item] *factorBeat));
    PVector sizeBalise = new PVector(size_x_item[ID_item],size_y_item[ID_item],size_z_item[ID_item]) ;
    PVector var = new PVector(1,1) ;
    if(authorization) {
      sizeBalise  = new PVector (size_x_item[ID_item] *tempoEffect, size_y_item[ID_item] *tempoEffect, size_z_item[ID_item] ) ;
      // variable position
      var = new PVector(left[ID_item] *5,right[ID_item] *5) ;
    }
    
    if(var.x <= 0 ) var.x = .1f ; 
    if(var.y <= 0 ) var.y = .1f ; 
    //quantity
    int maxBalise = 511 ;
    if(!FULL_RENDERING) maxBalise = 64 ;
    float radiusBalise = map(quantity_item[ID_item], 0,1, 2, maxBalise); // here the value max is 511 because we work with buffersize with 512 field
    
    PVector newPos = new PVector() ;
    balise.actualisation(newPos, speed) ;
    balise.display(amp, var, sizeBalise, factor, PApplet.parseInt(radiusBalise), authorization, mode[ID_item]) ;
    
    
    objectInfo[ID_item] = ("Size "+(int)sizeBalise.x + " / " + (int)sizeBalise.y + " / " + (int)sizeBalise.z  + " Radius " + PApplet.parseInt(radiusBalise) ) ;
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
      value = new PVector ((input.left.get(whichOne)*var.x), (input.right.get(whichOne)*var.y) ) ; 
    } else {
      float n = (float)whichOne ;
      n = n - (max/2) ;
      value = new PVector ( n*var.x *.01f, n*var.y *.01f ) ; 
    } 
    return value ;
  }
}
/**
KOFOSPHERE || 2013 || 1.0.1
*/
class Kofosphere extends Romanesco {
  public Kofosphere() {
    //from the index_objects.csv
    RPE_name = "Kofosphere" ;
    ID_item = 15 ;
    ID_group = 1 ;
    RPE_author  = "Kof";
    RPE_version = "Version 1.0.1";
    RPE_pack = "Base" ;
    RPE_mode = "Point color/Point mono/Box color/Box mono" ;
    RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Stroke hue,Stroke sat,Stroke bright,Stroke alpha,Thickness,Size X,Size Y,Size Z,Canvas X,Quantity,Speed X" ;
  }
  //GLOBAL

  Sphere sphere;
  
  //SETUP
  public void setup() {
   // very strange start position to be in the middle of the Scene
   startPosition(ID_item, width/2 -(width/4), height/2 -(height/4), 0) ;
    // startPosition(ID_item, 0, width/2, -(height *2)) ;
    
    float startingRadius = width ;
    
    sphere = new Sphere( new PVector(item_setting_position[0][ID_item].x,item_setting_position[0][ID_item].y),startingRadius);
  }
  
  
  
  
  //DRAW
  public void draw() {
    float beatFactor = map(allBeats(ID_item), 1,12, 1.f, 3.5f) ;
    float radius = map(canvas_x_item[ID_item], width/10, width, .01f, 1.1f) ;
    if(sound[ID_item]) radius = sq(radius) *beatFactor ; 
    
    // quantity of particules
    float quantity = map(quantity_item[ID_item],0 ,1, 10,200);
    // methode to limit the number of particules for the prescene
    if(!FULL_RENDERING) quantity /= 10.f ;
    // methode to limit the number of particules for the complexe shape, in this case for the boxes
    if(FULL_RENDERING && (mode[ID_item] > 1 && mode[ID_item] < 4)) quantity /= 2.5f ;  
    
    // speed
    float ratio_speed = .1f ;
    float norm_speed = map(speed_x_item[ID_item],0,1,0,1.5f) ;
    norm_speed *= norm_speed ;
    if(reverse[ID_item]) norm_speed *= ratio_speed ; else norm_speed *= -ratio_speed ;
    Vec2 speed = Vec2(norm_speed) ;
    speed.mult(.5f +left[ID_item], .5f +right[ID_item]) ;

    // size for the box
    float factorSizeDivide = .025f ;
    float newSizeX = size_x_item[ID_item] *factorSizeDivide ;
    float newSizeY = size_y_item[ID_item] *factorSizeDivide ;
    float newSizeZ = size_z_item[ID_item] *factorSizeDivide ;
    // we make a square size to smooth the growth
    PVector size = new PVector(newSizeX *newSizeX, newSizeY *newSizeY,newSizeZ *newSizeZ) ; 
    
    sphere.drawSpheres(size, speed, radius, quantity, thickness_item[ID_item], fill_item[ID_item], stroke_item[ID_item],mode[ID_item]);
    

    
    // INFO
    objectInfo[ID_item] = ("Quantity " + (int)quantity +  " - Speed ") ;

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

  
  float newRadius ;
  public void drawSpheres(PVector size, Vec2 speed, float radiusFactor, float quantity, float thickness, int colorIn, int colorOut, int mode) {
    //color mode
    if(mode%2==0) kofosphereInColor = true ; else kofosphereInColor = false ;
    
    quantity *=.01f ;
    // param
    speedRotateX += speed.x ;
    speedRotateY += speed.y ;
    //
    newRadius =  radius *radiusFactor ;
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
    //speed rotation
    rotateX(speedRotateX);
    rotateY(speedRotateY);
    
    float d = noise(frameCount/100)*(1500.0f +(1500 *quantity));
    density = 2.9f +(20*(1 -quantity)) ;
    

    
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
/**
SPIRALE  || 2011 || 1.1.1
*/
Line line ;
//object three
class Lignes extends Romanesco {
  public Lignes() {
    //from the index_objects.csv
    RPE_name = "Lignes" ;
    ID_item = 16 ;
    ID_group = 1 ;
    RPE_author  = "Stan le Punk";
    RPE_version = "Version 1.1.1";
    RPE_pack = "Base" ;
    RPE_mode = "Lines 1/Lines 2/Lines 3/Lines 4/Lines 5/Lines 6" ;
    RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Thickness,Quantity,Speed X,Direction X,Canvas X,Angle,Alignment" ;
  }
  //GLOBAL
  float ampLine  =1.0f ;
  float speed ;
  float thicknessLine ;
  //SETUP
  public void setup() {
    startPosition(ID_item, 0, 0, -width) ;
    line = new Line() ;
  }
  //DRAW
  public void draw() {
    if( beat[ID_item] > 1 ) {
      ampLine = beat[ID_item] *(map(swing_x_item[ID_item], 0,1, 0, 3)) ;
      thicknessLine = (thickness_item[ID_item] *ampLine ) ;
    } else {
      thicknessLine = thickness_item[ID_item] ;
    }

    //speed
    if(motion[ID_item]) speed = map(speed_x_item[ID_item], 0,1, 0, height/20 ) * tempo[ID_item]  ; else speed = 0.0f ;
    
    if(reverse[ID_item]) speed = speed *1 ; else speed = speed * -1 ;
    //to stop the move
    if (action[ID_item]  && spaceTouch ) speed = 0.0f ;
    
    // size canvas
    PVector canvas = new PVector (map(canvas_x_item[ID_item],width/10, width, height, height *5),map(canvas_x_item[ID_item],width/10, width, width, width *5)) ; 
    //quantity
    int num = (int)map(quantity_item[ID_item], 0, 1, canvas.x *.5f, canvas.y *.05f) ;

    int step_angle = (int)angle_item[ID_item] ;
    float step_rotate = map(alignment_item[ID_item],0,1,0,TAU)  ;
    
    for(int i = 0 ; i < 6 ; i++) {
      int num_grid = i +1 ;
      if(mode[ID_item] == i) loop_display_line(num_grid, step_angle, step_rotate /num_grid, canvas, num, speed, thicknessLine) ;

    }
  }

  public void loop_display_line(int num_grid, int step, float step_rotate, PVector canvas, int num, float speed, float thickness) {
    for(int i = 0 ; i < num_grid ; i++) {
      int angle = step *i ;
      float rotation_grid = step_rotate *i ;
      pushMatrix() ;
      rotateX(rotation_grid) ;
      display_line(canvas, num, speed / (i +1), thicknessLine,angle) ;
      popMatrix() ;
    }
  }

  

  public void display_line(PVector canvas, int num, float speed, float thickness, int start_angle_deg) {
    float direction = dir_x_item[ID_item] +start_angle_deg ;
    //rotation
    // rotation(direction, canvas.x *.5, canvas.y *.5 ) ;
    rotation(direction, 0, 0) ;
    //display
    line.drawLine (speed, num, fill_item[ID_item], thickness, canvas) ;

  }
}
//end 





//CLASS TRAME
class Line {
  Line()  { }
  
  float nbrlgn ; 
  int vitesse ;
  float vd, vg ;
  
  public void drawLine ( float v, float q, int c, float e, PVector canvas) {
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
/**
ENCRE  || 2012 || 1.1.1
*/
ArrayList<Old_Pixel> encreList = new ArrayList<Old_Pixel>(); ;
ArrayList<Old_Pixel> starList = new ArrayList<Old_Pixel>();

//object one
class Spray extends Romanesco {
  public Spray() {
    //from the index_objects.csv
    RPE_name = "Stars Spray" ;
    ID_item = 17 ;
    ID_group = 1 ;
    RPE_author  = "Stan le Punk";
    RPE_version = "version 1.1.1";
    RPE_pack = "Base" ;
    RPE_mode = "Star/Spray" ;
    RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Thickness,Size X,Size Y,Canvas X,Canvas Y,Quantity,Speed X,Angle,Life,Repulsion" ;
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
  public void setup() {
    startPosition(ID_item, width/2, height/2, 0) ;
  }
  //DRAW
  public void draw() {
    // change color pallete
    if(xTouch) changeColor = !changeColor ;
    
    
    if(mode[ID_item] == 0 ) {
      if(clickLongLeft[ID_item] && nLongTouch || starList.size()<1 ) starProduction() ;
      displayStar() ;
    }
    if(mode[ID_item] == 1 ) encre() ;
    
    // info display
    String whichColor = ("") ;
    if(changeColor) whichColor =("Original Color") ; else whichColor =("Colsor from Controller") ;
    objectInfo[ID_item] = ("Quantity ink " +encreList.size() +" Quantity stars " + starList.size() + " / " + whichColor ) ;
    
    
  }
 
  
  //ANNEXE VOID
  
  //STAR PRODUCTION
  float jitterOne, jitterTwo, jitterThree, jitterFour ;
  float thicknessSoundEffect ;
  // display
  public void displayStar() {
    if(sound[ID_item]) {
      jitterOne = 5* random(-beat[ID_item],beat[ID_item]) ;
      jitterTwo = 5* random(-kick[ID_item],kick[ID_item]) ;
      jitterThree = 5* random(-snare[ID_item],snare[ID_item]) ;
      jitterFour = 5* random(-hat[ID_item],hat[ID_item]) ; 
    } else {
      jitterOne = 0 ; 
      jitterTwo = 0 ;
      jitterThree = 0 ;
      jitterFour = 0 ;
    }
    thicknessSoundEffect = 1 + jitterOne ;
      
      
    for (Old_Pixel p : starList) {
      strokeWeight(thickness_item[ID_item] *thicknessSoundEffect) ;  
      if(changeColor) stroke(hue(p.colour), saturation(p.colour), brightness(p.colour), alpha(fill_item[ID_item])); else stroke(fill_item[ID_item]) ;
      point(p.pos.x +jitterOne, p.pos.y +jitterTwo, p.pos.z +jitterThree) ;
    }
    if (resetAction(ID_item)) starList.clear() ;
  }
  
  // the orderer
  public void starProduction() {
    float depth = map(canvas_z_item[ID_item], width/10, width, 0, width *3) ;
    PVector pos = new PVector(mouse[0].x - item_setting_position[0][ID_item].x, mouse[0].y - item_setting_position[0][ID_item].y, depth ) ;
    //tha first value must be smaller than second
    
    int sizeMin = (int)map(size_x_item[ID_item],0.1f,width,1,20) ;
    int sizeMax = (int)map(size_y_item[ID_item],0.1f,width,20, width *2) ;
    PVector size = new PVector(sizeMin,sizeMax) ;
    
    int numP = (int)map(quantity_item[ID_item],0,1,10,width) ;
    // limitation for the prescene rendering
    if(!FULL_RENDERING) {
      numP *= .001f ;
      if(numP < 5 ) numP = 5 ;
    }
    
    PVector numPoints = new PVector(numP/10,numP) ;
    
    int branchMin = (int)map(canvas_x_item[ID_item], width/10, width,1,30) ;
    int branchMax = (int)map(canvas_y_item[ID_item], width/10, width, 1, 30) ;
    PVector numBranchs = new PVector(branchMin,branchMax) ;

    int colour = fill_item[ID_item] ;
    int varAngle = (int)map(angle_item[ID_item], 0,360,0,180) ;
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
        dir = normal_direction((int)floatDirection) ;
        //distrubution in each branch
        float factor = random(0,1) ;
        float newDistance = 0 ;
        newDistance = pow(factor,2) *size ;
        posAroundTheStar = new PVector(dir.x *newDistance, dir.y *newDistance) ;
        
        posFinal.add(posAroundTheStar) ;
        posFinal.add(pos) ;
        starList.add(new Old_Pixel(posFinal, colour)) ;
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
    inkDiffusion = map (speed_x_item[ID_item] , 0,1, 0, 100 *tempo[ID_item]  ) ; // speed / vitesse
    
    float flux = map (quantity_item[ID_item], 0,1, 10,1000) ; // ink quantity
    if(!FULL_RENDERING) flux = 10 ; // limitation for the prescene rendering
    
    float thicknessPoint = thickness_item[ID_item]*.1f ;
    inkFlux = PApplet.parseInt(flux) ;
    angleSpray   = map (angle_item[ID_item], 0,360, 0,180 ) ; // angle
    dry = (int)map(life_item[ID_item], 0,1, frameRate , 100000) ; // dur\u00e9e
    float spr ;
    spr = map(repulsion_item[ID_item],0,1, 1, width) ; // force de diffusion
    spray = PApplet.parseInt(spr) ;
    
    // INK DRY
    float var = tempo[ID_item] ;
    float timeDry = 1.0f / PApplet.parseFloat(dry) ;
  
   // add encre
   int security ;
   if (FULL_RENDERING) security = 1000000 ; else security = 5000 ;
   if (action[ID_item] && nLongTouch && clickLongLeft[0] && encreList.size() < security) addEncre(factorPressure, sprayDirection, angleSpray, spray, inkDiffusion, inkFlux, fill_item[ID_item]) ; 
  
    //display
    for ( Old_Pixel e :  encreList ) {
      if (action[ID_item]) e.drying(var, timeDry) ;
      strokeWeight(thicknessPoint) ;
      noFill() ;
      if(changeColor) stroke(hue(e.colour), saturation(e.colour), brightness(e.colour), alpha(fill_item[ID_item])); else stroke(fill_item[ID_item]) ;
      point(e.pos.x, e.pos.y) ;
    }
    
    /////////////////////////////
    //CLEAR THE LIST IF NECESSARY 
    if (resetAction(ID_item)) encreList.clear() ;
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
      Vec2 tilt = Vec2 ( pen[0].x *distance, pen[0].y *distance ) ;
      //position the pixel around the laticce, pivot...
      Vec2 posTilt = Vec2( mouse[0].x - tilt.x , mouse[0].y - tilt.y  ) ;
      
      //calcul the final position to display
      mouse[ID_item].x = rotation(posTilt, Vec2(mouse[0].x, mouse[0].y), angle).x ;
      mouse[ID_item].y = rotation(posTilt, Vec2(mouse[0].x, mouse[0].y), angle).y ;
      mouse[ID_item].sub(Vec3(item_setting_position[0][ID_item])) ;

      
      //put the pixel in the list to use peacefully
      encreList.add( new Old_Pixel(new PVector(mouse[ID_item].x,mouse[ID_item].y,mouse[ID_item].z), diffusion, colorInk)) ;
    }
  }
  
  public void resetEncre() {
    encreList.clear() ;
  }
  //END INK
  /////////
}
//end object one




  
/**
TRAME || 2012 || 1.1.1
*/

Trame trame ;
//object three
class Damier extends Romanesco {
  public Damier() {
    //from the index_objects.csv
    RPE_name = "Damier" ;
    ID_item = 18 ;
    ID_group = 1 ;
    RPE_author  = "Stan le Punk";
    RPE_version = "Version 1.1.1";
    RPE_pack = "Base" ;
    RPE_mode = "Rectangle/Ellipse/Box" ;
    RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Stroke hue,Stroke sat,Stroke bright,Stroke alpha,Thickness,Size X,Size Y,Size Z,Quantity,Speed X,Canvas X" ;
  }
  //GLOBAL
  float d, g, m ;
  PVector size = new PVector(0,0,0) ;
  float angleTrame = 0 ;
  float angle = 0 ;
  float speed = 0 ;

  //SETUP
  public void setup() {
    startPosition(ID_item, width/2, height/2, -width) ;
    trame = new Trame() ;

  }
  //DRAW
  public void draw() {
    // color and thickness
    aspect_rpe(ID_item) ;
    
    if ( sound[ID_item]) {
      g = map(left[ID_item],0,1,1,5) ; 
      d = map(right[ID_item],0,1,1,5) ; 
      m = map(mix[ID_item],0,1,1,5) ;
    } else {  
      g = 1.0f ;
      d = 1.0f ;
      m = 1.0f ;
    }
    float penPressure = map(pen[ID_item].z,0,1,1,width/100) ;
    float sizeXtemp = map(size_x_item[ID_item],.1f,width,.1f,width/33) ;
    float sizeYtemp = map(size_y_item[ID_item],.1f,width,.1f,width/33) ;
    float sizeZtemp = map(size_z_item[ID_item],.1f,width,.1f,width/33) ;
    size.x = ((sizeXtemp *sizeXtemp) *penPressure *allBeats(ID_item) ) *g ;
    size.y = ((sizeYtemp *sizeYtemp) *penPressure *allBeats(ID_item)) *d ;
    size.z = ((sizeZtemp *sizeZtemp) *penPressure *allBeats(ID_item)) *m  ;
    //size

    //orientation / deg
    //speed
    speed = map(speed_x_item[ID_item], 0,1,0, 0.5f );
    if(reverse[ID_item]) speed = speed *1 ; else speed = speed * -1 ;
    if (speed != 0 && motion[ID_item]) angleTrame += speed *tempo[ID_item] ;
    
    
    //rotation of the single shape
    if (action[ID_item]) angle = map(angle_item[ID_item], 0,100, 0, TAU) ; 
    
    //quantity
    int q = PApplet.parseInt(map(quantity_item[ID_item], 0, 1, 2, 9)) ;
    if(FULL_RENDERING) q *= q ;

    //amp
    float amp = map(swing_x_item[ID_item],0,1, .3f, width *.007f) ;
    amp *= amp ;
    
    //MODE DISPLAY
    if(mode[ID_item] == 0 || mode[ID_item] == 255) trame.drawTrameRect(mouse[ID_item], angleTrame, angle, size , q, g, d, amp) ;
    else if (mode[ID_item] == 1) trame.drawTrameDisc(mouse[ID_item], angleTrame, angle, size , q, g, d, amp) ;
    else if (mode[ID_item] == 2) trame.drawTrameBox(mouse[ID_item], angleTrame, angle, size , q, g, d, amp) ;
    
    //INFO
    objectInfo[ID_item] =("Quantity " + q + " shapes / Angle " + (int)angle + " Speed " + PApplet.parseInt(speed *100) + " Amplitude " + PApplet.parseInt(amp *100)) ;
    
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
  public void drawTrameRect (Vec3 axe, float angleTrame, float angle_item, PVector size, int nbrlgn, float gauche, float droite, float amp ) {
    pushMatrix() ;
    translate(axe.x, axe.y) ;
    // calcul the position of each object
    for (int i=1 ; i < nbrlgn ; i++) {
      for (int j=1 ; j < nbrlgn ; j++) { 
        Vec2 pos = Vec2 ((i *width *amp) / nbrlgn, (j *height *amp ) / nbrlgn )  ;
        Vec2 newPosAfterRotation = rotation(pos, Vec2(axe.x,axe.y), angleTrame) ;        
        rectangleTrame (newPosAfterRotation, size.x, size.y, gauche, droite, angle_item ) ;      
      }
    }
    popMatrix() ;  
  }
  
  
  
  
  //TRAME DISC multiple
  public void drawTrameDisc (Vec3 axe, float angleTrame, float angle_item, PVector size, int nbrlgn, float gauche, float droite, float amp   ) {
    pushMatrix() ;
    translate(axe.x, axe.y) ;
    // calcul the position of each object
    for (int i=1 ; i < nbrlgn ; i++) {
      for (int j=1 ; j < nbrlgn ; j++) {
        Vec2 pos = Vec2 (  (i *width *amp ) / nbrlgn, (j * height *amp ) / nbrlgn )  ;
        Vec2 newPosAfterRotation = rotation(pos, Vec2(axe.x,axe.y), angleTrame) ;        
        disqueTrame (newPosAfterRotation, size.x, size.y, gauche, droite, angle_item ) ;      
      }
    }
    popMatrix() ;  
  }
  
  
  //TRAME BOX
  public void drawTrameBox (Vec3 axe, float angleTrame, float angle_item, PVector size, int nbrlgn, float gauche, float droite, float amp   ) {
    pushMatrix() ;
    translate(axe.x, axe.y) ;
    //calcul the position of each object
    for (int i=1 ; i < nbrlgn ; i++) {
      for (int j=1 ; j < nbrlgn ; j++) {
        Vec2 pos = Vec2 (  (i *width *amp ) / nbrlgn, (j * height *amp ) / nbrlgn )  ;
        Vec2 newPosAfterRotation = rotation(pos, Vec2(axe.x,axe.y), angleTrame) ;        
        boxTrame (newPosAfterRotation, size, gauche, droite, angle_item ) ;      
      }
    }
    popMatrix() ;  
  }
  
  public void rectangleTrame(Vec2 pos, float h, float l, float gauche, float droite, float aObj) {
    pushMatrix() ;
    rectMode(CENTER) ;
    translate(pos.x, pos.y) ;
    rotate(aObj) ;
    rect (0, 0, pow(l,1.4f), pow(h,1.4f)) ;
    rectMode(CORNER) ;
    popMatrix() ;
  }
  
  public void disqueTrame(Vec2 pos, float h, float l, float gauche, float droite, float aObj) {
    pushMatrix() ;
    ellipseMode(CENTER) ;
    translate(pos.x, pos.y) ;
    rotate(aObj) ;
    ellipse (0, 0, pow(l,1.4f), pow(h,1.4f)) ;
    ellipseMode(CORNER) ;
    popMatrix() ;
  }
  
  public void boxTrame(Vec2 pos, PVector size, float gauche, float droite, float aObj) {
    pushMatrix() ;
    translate(pos.x, pos.y) ;
    rotate(aObj) ;
    box (pow(size.x,1.4f), pow(size.y,1.4f), pow(size.z,1.4f)) ;
    popMatrix() ;
  }
}
/**
VECTORIAL || 2015 || 0.0.1
*/

class Vectorial extends Romanesco {
 
  public Vectorial() {
    RPE_name = "Vectorial" ;
    ID_item = 19 ;
    ID_group = 1 ;
    RPE_author  = "Stan le Punk";
    RPE_version = "Version 0.0.1";
    RPE_pack = "Base 2016" ;
    RPE_mode = "Classic/Walker" ; // separate the differentes mode by "/"
    RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Stroke hue,Stroke sat,Stroke bright,Stroke alpha,Thickness,Jitter X,Jitter Y,Jitter Z,Canvas X,Canvas Y,Swing X,Swing Y,Swing Z" ;
  }



  boolean walker  ;
  float beat_factor = 1 ;

 
  // setup
  public void setup() {
    startPosition(ID_item, 0, 0, -height) ;
    load_svg(ID_item) ;
    svg_import[ID_item].build() ;
    svg_import[ID_item].svg_mode(CENTER) ;
  }


  public void draw() {
    if(parameter[ID_item]) {
      load_svg(ID_item) ;
      svg_import[ID_item].svg_mode(CENTER) ;
    }
    // color
    float factor_sat_fill = map(saturation(fill_item[ID_item]), 0,100,0,1) ;
    float factor_bright_fill = map(brightness(fill_item[ID_item]), 0,100,0,1) ;
    float factor_alpha_fill = map(alpha(fill_item[ID_item]), 0,100,0,1) ;
    Vec4 factor_fill = Vec4(1,factor_sat_fill,factor_bright_fill, factor_alpha_fill) ;

    float factor_sat_stroke = map(saturation(stroke_item[ID_item]), 0,100,0,1) ;
    float factor_bright_stroke = map(brightness(stroke_item[ID_item]), 0,100,0,1) ;
    float factor_alpha_stroke = map(alpha(stroke_item[ID_item]), 0,100,0,1) ;
    Vec4 factor_stroke = Vec4(1,factor_sat_stroke,factor_bright_stroke, factor_alpha_stroke) ;


    // scale
    float scale_x = map(canvas_x_item[ID_item], canvas_x_min_max.x, canvas_x_min_max.y, .1f, 8);
    float scale_y = map(canvas_y_item[ID_item], canvas_y_min_max.x, canvas_y_min_max.y, .1f, 8);
    Vec3 scale_3D = Vec3(scale_x, scale_y,1) ;

    // beat factor
    if(sound[ID_item]) beat_factor = allBeats(ID_item) ; else beat_factor = 1.f ;


    
    // jitter
    Vec3 jitting = Vec3(jitter_x_item[ID_item],jitter_y_item[ID_item],jitter_z_item[ID_item]);
    jitting.mult((int)height/2 *beat_factor) ;

    // pos
    Vec3 pos_3D = Vec3 (mouse[ID_item].x,mouse[ID_item].y, mouse[ID_item].z); 
    
    // display and mode
    if(mode[ID_item] == 0 ) {
      if(walker) {
        svg_import[ID_item].build() ;
        walker = false ;
      }
      full_svg_3D(pos_3D, scale_3D, jitting, svg_import[ID_item], factor_fill, factor_stroke) ;
    }
    else if(mode[ID_item] == 1 ) {
      walker = true ;
      walker_svg_3D(pos_3D, scale_3D, svg_import[ID_item], factor_fill, factor_stroke) ;
      if(nTouch ) svg_import[ID_item].build() ;
      if(beat_factor > 5 && FULL_RENDERING) svg_import[ID_item].build() ;
    }
  }



  // annexe
  public void walker_svg_3D(Vec3 pos_3D, Vec3 scale_3D, RPEsvg svg, Vec4 factor_fill, Vec4 factor_stroke) {
    Vec3 swing = Vec3(swing_x_item[ID_item],swing_y_item[ID_item],swing_z_item[ID_item]) ;
    swing.mult(height /5 *beat_factor) ;
    for(int ID = 0 ; ID < svg.num_brick() ; ID++ ) {
      int length = svg.list_points_of_interest(ID).length ;
      Vec3 [] value = new Vec3[length] ;
      for(int i = 0 ; i < value.length ; i++) {
        value[i] = new Vec3("RANDOM", (int)swing.x, (int)swing.y,(int)swing.z) ;
        value[i].mult(.1f) ;
      }
      svg.add_def(ID, value) ;
      svg.pos(pos_3D) ;
      svg.scale(scale_3D) ;
      svg.original_style(true, true) ;
      svg.fill_factor(factor_fill) ; 
      svg.stroke_factor(factor_stroke) ; 
      svg.draw_3D(ID) ;
    }
  }

   // 
   public void full_svg_3D(Vec3 pos_3D, Vec3 scale_3D, Vec3 jitter_3D, RPEsvg svg, Vec4 factor_fill, Vec4 factor_stroke) {
    svg.pos(pos_3D) ;
    svg.scale(scale_3D) ;
    svg.jitter(jitter_3D) ;
    svg.original_style(true, true) ;
    svg.fill_factor(factor_fill) ; 
    svg.stroke_factor(factor_stroke) ; 
    svg.draw_3D() ;
  }
}
/**
GALAXIE || 2012 || 1.3.0
*/

class Galaxie extends Romanesco {
  public Galaxie() {
    //from the index_objects.csv
    RPE_name = "Galaxie" ;
    ID_item = 20 ;
    ID_group = 1 ;
    RPE_author  = "Stan le Punk";
    RPE_version = "Version 1.3";
    RPE_pack = "Base" ;
    RPE_mode ="Point/Ellipse/Rectangle/Box" ;
    RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Stroke hue,Stroke sat,Stroke bright,Stroke alpha,Thickness,Size X,Size Y,Size Z,Canvas X,Canvas Y,Quantity,Speed X,Influence" ;
  }
  //GLOBAL
  boolean makeSand = true ;
  boolean shiftGrain = false ;
  boolean gravityGrain = true ;
  Vec3 posCenterGrain = Vec3();

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
  public void setup() {
    startPosition(ID_item, 0, 0, 0) ;
  }
  //DRAW
  public void draw() {
    
    //surface
    PVector marge = new PVector(map(canvas_x_item[ID_item],width/10, width, width/20, width*10), map(canvas_y_item[ID_item],width/10, width, height/20, height*10), map(canvas_z_item[ID_item], width/10, width, width/10, width *10))  ;
    PVector surface = new PVector(marge.x *2 +width, marge.y *2 +height) ;
    
    //quantity of star
    float max = 1500 ;
    float min = 300 ;
    if(!FULL_RENDERING ) {
      min = 30 ;
      max = 150 ;
    }
    float quantity = map(quantity_item[ID_item],0,1,min,max) ;
    if (mode[ID_item] == 0 ) numFromController = PApplet.parseInt(quantity *10) ; else numFromController = PApplet.parseInt(quantity) ;
    

    if ((numGrains != numFromController && parameterButton[ID_item] == 1) || resetAction(ID_item) ) makeSand = true ;
    
    if (makeSand) {
      numGrains = numFromController ;
      grainSetup(numGrains, marge) ;
      makeSand = false ;
    }
 
    //give back the pen info
    float pressionGrain = sq(1 + pen[ID_item].z) ;
    orientationStyletGrain = new PVector ( pen[ID_item].x *10.0f , pen[ID_item].y *10.0f ) ;
    deformationGrain = orientationStyletGrain.copy() ; ;
    
    // speed / vitesse
     speedDust = map(speed_x_item[ID_item],0,1, 0.00005f ,.5f) ; 
     if(sound[ID_item]) speedDust *= 3 ;
        
    vitesseGrainA = map(left[ID_item],0,1, 1, 17) ;
    vitesseGrainB = map(right[ID_item],0,1, 1, 17) ;
    

    
    vitesseGrain.x = vitesseGrainA *speedDust *tempo[ID_item] *pressionGrain  ;
    vitesseGrain.y = vitesseGrainB *speedDust *tempo[ID_item] *pressionGrain  ;
    if(reverse[ID_item]) {
      vitesseGrain.x = vitesseGrain.x *1 ; 
      vitesseGrain.y = vitesseGrain.y *1 ; 
    } else {
      vitesseGrain.x = vitesseGrain.x *-1 ;
      vitesseGrain.y = vitesseGrain.y *-1 ;
    }
    
    // force
    int maxInfluence = 11 ;
    variableRayonGrain = map(influence_item[ID_item], 0,1, 0, maxInfluence ) ;
    
    //size
    float objWidth =  .1f +size_x_item[ID_item] *mix[ID_item] ;
    float objHeight = .1f +size_y_item[ID_item] *mix[ID_item] ;
    float objDepth = .1f +size_z_item[ID_item] *mix[ID_item] ;
    PVector size = new PVector(objWidth, objHeight,objDepth) ;
    
    //thickness / \u00e9paisseur
    float e = thickness_item[ID_item] ;

    int colorIn = fill_item[ID_item] ;
    int colorOut = stroke_item[ID_item] ;
    

    
    // Axe rotation
    posCenterGrain.set(mouse[ID_item]) ;
    //ratio transformation du canvas
    float ratioX = surface.x / PApplet.parseFloat(width) ;
    float ratioY = surface.y / PApplet.parseFloat(height) ;
    
    Vec3 newPosCenterGrain = Vec3() ;
    newPosCenterGrain.x = posCenterGrain.x *ratioX -marge.x ;
    newPosCenterGrain.y = posCenterGrain.y *ratioY -marge.y ;
    // copy the final result
    posCenterGrain.set(newPosCenterGrain) ;
    
    /////////
    //UPDATE
    if(motion[ID_item]) if (speed_x_item[ID_item] >= 0.01f) updateGrain(upTouch, downTouch, leftTouch, rightTouch, clickLongLeft[ID_item], marge);
    
    //////////////
    //DISPLAY MODE
    if (mode[ID_item] == 0) {
      pointSable(e, colorIn) ;
    } else if (mode[ID_item] == 1 ) {
      ellipseSable(size,e , colorIn, colorOut) ;
    } else if (mode[ID_item] == 2 ) {
      rectSable(size,e , colorIn, colorOut) ;
    } else if (mode[ID_item] == 3 ) {
      boxSable(size,e , colorIn, colorOut) ;
    } else {
      pointSable(objWidth, colorIn) ;
    }
    
   
    
    
    // INFO DISPLAY
    objectInfo[ID_item] =("Quantity " +numGrains + " - Canvas " + (int)surface.x + "x" + (int)surface.y + " - Center Galaxy " + PApplet.parseInt(posCenterGrain.x +marge.x) + "x" + PApplet.parseInt(posCenterGrain.y +marge.y) + " - speed" +PApplet.parseInt(speedDust *200.f)) ;
    if (objectInfoDisplay[ID_item]) {
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
      
      motionGrain.x = grain[i].x -posCenterGrain.x -(deformationGrain.x +right[ID_item]) +variableRayonGrain ;
      motionGrain.y = grain[i].y -posCenterGrain.y -(deformationGrain.y +left[ID_item] ) +variableRayonGrain ;
  
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
/**
HONEYCOMB || 2011 || 0.1.1
*/
ArrayList <Hexagon> grid = new ArrayList <Hexagon> (); // the arrayList to store the whole grid of cells

class Honeycomb extends Romanesco {
  public Honeycomb() {
    //from the index_objects.csv
    RPE_name = "Nid d'abeille" ;
    ID_item = 21 ;
    ID_group = 1 ;
    RPE_author  = "Amnon Owed";
    RPE_version = "Version 0.1.1";
    RPE_pack = "Base" ;
    RPE_mode = "" ;
    RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Thickness,Size X,Canvas X,Canvas Y" ;
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
  public void setup() {
    startPosition(ID_item, width/2, height/2, 0) ;
    canvas = new PVector(width, height) ;
    canvasRef = canvas.copy();
    initGrid(canvas); // initialize the CA grid of hexagons (including neighbour search and creation of hexagon vertex positions)
  }
  //DRAW
  public void draw() {
    neighbourDistance = hexagonRadius *2;
    hexagonStroke = thickness_item[ID_item] ;
    hexagonRadius = map(size_x_item[ID_item],.1f,width, width /40, width/15)  ;

    
    // limitation for the preview
    int minSize = width/80 ;
    if(FULL_RENDERING) {
      sliderCanvasX = map(canvas_x_item[ID_item], width/10, width, minSize, width *4) ;
      sliderCanvasY = map(canvas_y_item[ID_item], width/10, width, minSize, width *4) ;      
    } else {
      sliderCanvasX = map(canvas_x_item[ID_item], width/10, width, minSize, width) ;
      sliderCanvasY = map(canvas_y_item[ID_item], width/10, width, minSize, width) ;
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
    if(getTimeTrack() > 0.2f) soundSizeFactor = allBeats(ID_item) ; else soundSizeFactor = 1.0f ;
    

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
      h.display(v, fill_item[ID_item],soundSizeFactor);
    }
    popMatrix() ;
    
    // new honeycomb
    //if((action[ID_item] && xTouch) || allBeats(ID_item) >= 3.125 ) newHoneycomb = true ;
    if((action[ID_item] && nTouch)) newHoneycomb = true ;
    
    if(newHoneycomb) {
      float r = random(1000000); // random number that is used by all the hexagon cells...
      for (Hexagon h : grid) { h.resetColor(r); } // ... to generate a new color
      newHoneycomb = false ;
    }
    
    
    // INFO
    objectInfo[ID_item] = (grid.size() + " hexagons") ;
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
/**
WEBCAM || 2011 || 1.2.2
*/
class Webcam extends Romanesco {
  public Webcam() {
    //from the index_objects.csv
    RPE_name = "Webcam" ;
    ID_item = 22 ;
    ID_group = 1 ;
    RPE_author  = "Stan le Punk";
    RPE_version = "Version 1.2.2";
    RPE_pack = "Base" ;
    RPE_mode = "Rectangle color/Rectangle mono/Point color/Point mono/Box color/Box mono" ;
    RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Size X,Size Y,Size Z,Canvas X,Canvas Y" ;
  }
  //GLOBAL
  int cameraStatut = 0 ;



  
  PVector factorDisplayCam = new PVector (0,0) ;
  PVector factorDisplayPixel = new PVector (0,0) ;
  // PVector factorCalcul = new PVector (0,0) ;
  
  int colorPixelCam ;
  
  int cellSizeX, cellSizeY, posPixelX, posPixelY   ;
  int cols ;
  int rows ; 
  
  
  //SETUP
  public void setup() {
    startPosition(ID_item, width/2, height/2, 0) ;
  }
  //DRAW
  public void draw() {
    //PART ONE
    //calcul the ration between the size of camera and the size of the scene
    factorDisplayCam.x = width / CAM_SIZE.x ; 
    factorDisplayCam.y = height / CAM_SIZE.y ;
    
    // size
    float minVal = 0.1f ;
    float maxVal = height / 50 ;
    float size_x = map(size_x_item[ID_item],0.1f,width, minVal, maxVal) *snare[ID_item] ;
    float size_y = map(size_y_item[ID_item],0.1f,width, minVal, maxVal) *kick[ID_item] ;
    float size_z = map(size_z_item[ID_item],0.1f,width, minVal, maxVal) *hat[ID_item] ;
    PVector factorSizePix = new PVector(size_x, size_y, size_z) ; 
    factorDisplayPixel = new PVector(factorDisplayCam.x *factorSizePix.x , factorDisplayCam.y *factorSizePix.y, factorSizePix.z) ;//PARAMETER THAT YOU CAN USE
    
    //PART TWO

    if(FULL_RENDERING) {
      cellSizeX = PApplet.parseInt(map(canvas_y_item[ID_item],width/10, width, 50, 1))  ; 
      cellSizeY = PApplet.parseInt(map(canvas_x_item[ID_item],width/10, width, 50, 1))  ;
    } else {
      cellSizeX = PApplet.parseInt(map(canvas_y_item[ID_item],width/10, width, 50, 20))  ; 
      cellSizeY = PApplet.parseInt(map(canvas_x_item[ID_item],width/10, width, 50, 20))  ;
    }
    if(cellSizeX < 1 ) cellSizeX = 1 ;
    if(cellSizeY < 1 ) cellSizeY = 1 ;
    
    cols = (int)CAM_SIZE.x / cellSizeX; // before the resizing
    rows = (int)CAM_SIZE.y / cellSizeY;
    if (cam.available()) {
      cam.loadPixels();
      for (int i = 0; i < cols ; i++) {
        for (int j = 0; j < rows  ; j++) {
          // Where are we, pixel-wise?
          posPixelX = i *cellSizeX  ;
          posPixelY = j *cellSizeY  ;
          //// display pixel 
          int  loc = posPixelX  +posPixelY *cam.width; // classic
          //  int loc = (cam.width - x - 1) + y*cam.width; // mirror
          //make pixel
          PVector hsb = new PVector (hue(cam.pixels[loc]), saturation(cam.pixels[loc]), brightness(cam.pixels[loc]) ) ;

          
          // Make a new color with an alpha component
          displayPix(mode[ID_item],hsb) ; 
        }
      } 
    } else {
      fill(fill_item[ID_item]) ;
      textSize(size_x_item[ID_item]/10) ;
      text("Big Brother stops watching you, you're so boring !",0,0) ;
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
    
    float newCellSizeX = cellSizeX *factorDisplayPixel.x *left[ID_item] ;
    float newCellSizeY = cellSizeY *factorDisplayPixel.y *right[ID_item] ;
    float factorSizeZ = map(size_z_item[ID_item], .1f, width, .01f, height/100) ;
    PVector newCellSize = new PVector (newCellSizeX, newCellSizeY, factorSizeZ ) ;
    //init the position of image on the middle of the screen
    Vec3 posMouseCam = Vec3( width / 2, height /2, 0) ;
    if (mouse[ID_item].x >= -item_setting_position[0][ID_item].x && mouse[ID_item].y >= -item_setting_position[0][ID_item].y) posMouseCam.set(mouse[ID_item]) ;
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
    float depth = (hsb.z +.05f) *size.z ;
    if(horizon[ID_item]) translate(pos.x, pos.y, depth *.5f); else translate(pos.x, pos.y, pos.z);
    monochrome(hsb) ;
    fill(colorPixelCam) ;
    antiBugFillBlack(colorPixelCam) ;
    noStroke() ;
    box(size.x, size.y, depth) ;
  }
  //
  public void boxColour(PVector pos, PVector size, PVector hsb) {
    float depth = (hsb.z +.05f) *size.z ;
    if(horizon[ID_item]) translate(pos.x, pos.y, depth *.5f); else translate(pos.x, pos.y, pos.z);
    colour(hsb) ;
    fill(colorPixelCam) ;
    antiBugFillBlack(colorPixelCam) ;
    noStroke() ;
    box(size.x, size.y, depth) ;
  }
  
  
  //Annexe
  
  // security size 
  public PVector checkSize(PVector size) {
    float minSize = .5f ;
    if (size.x < minSize ) size.x = minSize ;
    if (size.y < minSize ) size.y = minSize ;
    if (size.z < minSize ) size.z = minSize ;
    return size ;
  }
  
  public void colour(PVector hsb) {
    float newSat = hsb.y *map(saturation(fill_item[ID_item]),0,100,0,1) ;
    float newBrigth = hsb.z *map(brightness(fill_item[ID_item]),0,100,0,1) ;
    colorPixelCam = color(hsb.x, newSat, newBrigth, alpha(fill_item[ID_item]));
  }
  
  public void monochrome(PVector hsb) {
    float newHue = hue(fill_item[ID_item]) ;
    float newSat = hsb.y *map(saturation(fill_item[ID_item]),0,100,0,1) ;
    float newBrigth = hsb.z *map(brightness(fill_item[ID_item]),0,100,0,1) ;
    //display the result
    colorPixelCam = color(newHue, newSat, newBrigth, alpha(fill_item[ID_item]));
  }
}
/**
ESCARGOT || 2011 || 1.4.3
*/
class Escargot extends Romanesco {
  public Escargot() {
    //from the index_objects.csv
    RPE_name = "Image" ;
    ID_item = 23 ;
    ID_group = 1 ;
    RPE_author  = "Stan le Punk";
    RPE_version = "version 1.4.3";
    RPE_pack = "Base" ;
    RPE_mode = "Original/Raw/Point/Ellipse/Rectangle/Box/Cross/SVG/Vitraux" ;
    RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Stroke hue,Stroke sat,Stroke bright,Stroke alpha,Thickness,Size X,Size Y,Size Z,Speed X,Direction X,Canvas X,Quality,Quantity,Repulsion" ;
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
  public void setup() {
    startPosition(ID_item, 0, 0, 0) ;
    load_bitmap(ID_item) ;
    if(!FULL_RENDERING) maxVoronoiPoints = 250 ;
    //load pattern SVG to display a Pixel pattern you create in Illustrator or other software
    pathSVG = preference_path +"pixel/model.svg" ;
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
  public void draw() {
    /*
    if(firstSettingPosition && startingPos[ID_item].x == 0.0 && startingPos[ID_item].y == 0.0 ) {
      startingPos[ID_item].x = img[ID_item].width /4 ;
      startingPos[ID_item].y = img[ID_item].height /4 ;
      firstSettingPosition = false ;
    }
    */
    
    if(parameter[ID_item]) load_bitmap(ID_item) ;

    if(bitmap_import[ID_item] != null) {  
      //MOTION
      windForce = (int)map(speed_x_item[ID_item],0,1,0,13) ;
      windDirection = (int)dir_x_item[ID_item] ;
      if(reverse[ID_item]) windDirection += 180 ;
      objMotion = PApplet.parseInt(map(repulsion_item[ID_item],0,1, 0,20) *(1.0f + pen[ID_item].z)) ;
      motionInfo.y = windForce ;
      //PEN
       if (pen[ID_item].z == 1 ) pen[ID_item].z = 0 ; else pen[ID_item].z = pen[ID_item].z ;
       if( (pen[ID_item].x == 1.0f && pen[ID_item].y == 1.0f) || (pen[ID_item].x == 0.0f && pen[ID_item].y == 0.0f) ) {
         motionInfo.x = windDirection  ; 
       } else {
         PVector convertTilt = new PVector (-pen[ID_item].x, -pen[ID_item].y) ;
         motionInfo.x = deg360(convertTilt) ;
       }
       
       // if (!spaceTouch) for( Old_Pixel p : listEscargot) {
       //alternat beween the pen and the controleur
       // if( pen[ID_item].x == 0 && pen[ID_item].y == 0 ) newDirection = normalDir(int(map(valueObj[ID_item][18],0,100,0,360))) ; else newDirection = new PVector (-pen[ID_item].x  , -pen[ID_item].y ) ;
       
       if (!motion[ID_item]) for(Old_Pixel p : listEscargot) {
         p.updatePosPixel(motionInfo, bitmap_import[ID_item]) ;
       }
      ////////////////
      
      //ANALYZE
      //change the size of pixel ref for analyzing
      if (pixelAnalyzeSize != pixelAnalyzeSizeRef || radiusAnalyze != radiusAnalyzeRef || maxEntryPoints != maxEntryPointsRef) reInitilisationAnalyze() ;
  
      pixelAnalyzeSizeRef = pixelAnalyzeSize;
      radiusAnalyzeRef = radiusAnalyze ;
      maxEntryPointsRef = maxEntryPoints ;
      
      int n = PApplet.parseInt(map(quantity_item[ID_item],0,1,10,150)) ;
      maxEntryPoints = n *n ;
      
      // security for the vorono\u00ef displaying, because if you change the analyze in the voronoi process, Romanesco make the Arraylist error
      if(mode[ID_item] != 8 || (maxEntryPoints != maxEntryPointsRef && scene) ) {
        //if (maxEntryPoints > listPixelRaw.size() / 4 ) maxEntryPoints = listPixelRaw.size() ;
        radiusAnalyze = PApplet.parseInt(map(swing_x_item[ID_item],0,1,2,100));
        pixelAnalyzeSize = PApplet.parseInt(map(quality_item[ID_item],0,1,100,2));
      } else {
        if(maxEntryPoints > maxVoronoiPoints) maxEntryPoints = maxVoronoiPoints  ;
      }
  
      
       //security for the droping img from external folder
       if(parameter[ID_item] && aTouch ) ratioImg = !ratioImg ;
       if(bitmap_import[ID_item] != null && bitmap_import[ID_item].width > 3 && ratioImg ) {
         analyzeImg(pixelAnalyzeSize) ;
         // ratioImgWindow = new PVector ((float)width / (float)img.width , (float)height / (float)img.height ) ;
         ratioImgWindow = new PVector ((float)width / (float)bitmap_import[ID_item].width , (float)width / (float)bitmap_import[ID_item].width ) ;
       } else if (bitmap_import[ID_item] != null && bitmap_import[ID_item].width > 3 && !ratioImg) {
         analyzeImg(pixelAnalyzeSize) ;
         ratioImgWindow = new PVector(1,1) ;
       } else {
         ratioImgWindow = new PVector(1,1) ;
       }
       
       //size and thickness
       PVector sizePix = new PVector (map(size_x_item[ID_item],.1f,width, 1, height/30 ), map(size_y_item[ID_item],.1f,width, 1, height/30 ), map(size_z_item[ID_item],.1f,width, 1, height/30 )) ;
       float sizePoint = map(size_x_item[ID_item],.1f,width, 1, height/6 ) ;
       float thickPix = map(thickness_item[ID_item],0.1f,height *.33f, 0.1f, height/10 ) ;
       
       // range 100
       float soundHundredMin = random(80) ;
       float soundHundredMax = random(soundHundredMin, soundHundredMin +20) ;
       PVector rangeReactivitySoundHundred = new PVector (soundHundredMin, soundHundredMax) ;
       //range 360
       float soundThreeHundredSixtyMin = random(330) ;
       float soundThreeHundredSixtyMax = random(soundThreeHundredSixtyMin, soundThreeHundredSixtyMin +30) ;
       PVector rangeReactivitySoundThreeHundredSixty = new PVector (soundThreeHundredSixtyMin, soundThreeHundredSixtyMax) ;
       //Music factor
       PVector musicFactor = new PVector ( allBeats(ID_item) *left[ID_item], allBeats(ID_item) *right[ID_item]) ;
       forceBeat = (int)map(repulsion_item[ID_item],0,1,1,40) ;

       
       // update image
       if(parameter[ID_item] && imgPathRef != bitmap_path[which_bitmap[ID_item]] ) {
         analyzeDone = false ;
         escargotGOanalyze = false ;
         escargotClear() ;
         imgPathRef = bitmap_path[which_bitmap[ID_item]] ;
       }
      
      
      
      //choice new pattern SVG
      if ( action[ID_item] && pTouch ) {
        //step 1 clear the list for new analyze
        drawVertexSVG = false ;
        selectInput("select SVG pattern 50x50", "choiceSVG");
      }
      
      //change the color palette
      if (action[ID_item] && xTouch ) paletteRandom(HSBpalette, HSBmode ) ;
      
      //clear the pixels for the new analyze
      if (action[ID_item] && ( deleteTouch || backspaceTouch)) {
        escargotClear() ;
        analyzeDone = false ;
        totalPixCheckedInTheEscargot = 0 ;
      }
  
  
  
      
  
       //CHANGE MODE DISPLAY
      /////////////////////
      
      // correction position to rotate the picture by the center
      pushMatrix() ;
      translate(-bitmap_import[ID_item].width /4, -bitmap_import[ID_item].height /4) ;
      
      if (mode[ID_item] == 0 || mode[ID_item] == 255 ) {
        displayRawPixel(sizePoint, fill_item[ID_item], rangeReactivitySoundHundred, rangeReactivitySoundThreeHundredSixty, musicFactor, ratioImgWindow) ;
      } else if (mode[ID_item] == 1 ) {
        escargotRaw(sizePoint, fill_item[ID_item], rangeReactivitySoundHundred, rangeReactivitySoundThreeHundredSixty, musicFactor, ratioImgWindow) ;
      } else if (mode[ID_item] == 2 ) {
        escargotPoint(sizePix, fill_item[ID_item], rangeReactivitySoundHundred, rangeReactivitySoundThreeHundredSixty, musicFactor, ratioImgWindow) ;
      } else if (mode[ID_item] == 3 ) {
        escargotEllipse(sizePix, thickPix, fill_item[ID_item], stroke_item[ID_item], rangeReactivitySoundHundred, rangeReactivitySoundThreeHundredSixty, musicFactor, ratioImgWindow) ;
      } else if (mode[ID_item] == 4 ) {
        escargotRect(sizePix, thickPix, fill_item[ID_item], stroke_item[ID_item], rangeReactivitySoundHundred, rangeReactivitySoundThreeHundredSixty, musicFactor, ratioImgWindow) ;
      }else if (mode[ID_item] == 5 ) {
        escargotBox(sizePix, thickPix, fill_item[ID_item], stroke_item[ID_item], rangeReactivitySoundHundred, rangeReactivitySoundThreeHundredSixty, musicFactor, ratioImgWindow, horizon[ID_item]) ;
      } else if (mode[ID_item] == 6 ) {
        escargotCross(sizePix, thickPix, fill_item[ID_item], rangeReactivitySoundHundred, rangeReactivitySoundThreeHundredSixty, musicFactor, ratioImgWindow) ;
      } else if (mode[ID_item] == 7 ) {
        escargotSVG(sizePix, thickPix, fill_item[ID_item], stroke_item[ID_item], rangeReactivitySoundHundred, rangeReactivitySoundThreeHundredSixty, musicFactor, ratioImgWindow) ;
      } else if (mode[ID_item] == 8 ) {
        //if( listEscargot.size() < 600) {
        if( listEscargot.size() < maxVoronoiPoints + maxVoronoiPoints/10) {
          voronoiStatic(fill_item[ID_item], stroke_item[ID_item], thickPix, useNewPalettePixColorToDisplay, ratioImgWindow) ; 
        } else {
          text("Too much points to net vorono\u00ef connection", 20, height -20) ;
        }
      }
      
      // end of correction position
      popMatrix() ;
      
      // info display
      objectInfo[ID_item] = ("Image " +bitmap_import[ID_item].width + "x"+bitmap_import[ID_item].height + " Analyze "+listEscargot.size()+ " of " + maxEntryPoints+ " / Cell " + pixelAnalyzeSize+ "px / Radius analyze " + radiusAnalyze + " Scale " + ratioImgWindow.x + " / " +ratioImgWindow.y) ;
    } 
  }
  
  
  
  //ANNEXE VOID
  public void displayRawPixel(float sizeP, int cIn, PVector rangeHundred, PVector rangeThreeHundredSixty, PVector musicFactor, PVector ratio) {
    // we must create a PVector because i'm lazy to create an other void beatReactivity for one float
    PVector sizePixCtrl = new PVector (0,0,sizeP) ;
    float factorSat = map(saturation(cIn),0,100,0,1) ;
    float factorBright = map(brightness(cIn),0,100,0,1) ;
    
    for (Old_Pixel p : listPixelRaw) {
      //display
      stroke(hue(p.colour),saturation(p.colour)*factorSat,brightness(p.colour)*factorBright, alpha(cIn)) ;
      float newSize = 0 ;
      if(sound[ID_item])  newSize = beatReactivityHSB(sizePixCtrl, p.size, p.colour, rangeThreeHundredSixty, rangeHundred, musicFactor ).z ; else newSize = sizeP ;
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
    
    for ( Old_Pixel p : listPixelRaw ) {
      if (p.ID == 1 ) {
        //color
        if ( colorPixDisplay ) c = p.newColour ; else c = p.colour ;
        
        //display
        stroke(hue(c),saturation(c)*factorSat,brightness(c)*factorBright, alpha(cIn)) ;
        float newSize = 0 ;
        if(sound[ID_item])  newSize = beatReactivityHSB(sizePixCtrl, p.size, p.colour, rangeThreeHundredSixty, rangeHundred, musicFactor ).z ; else newSize = sizeP ;
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

    for (Old_Pixel p : listEscargot ) {
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
      newSize = newSize2D(size, p.size, rangeThreeHundredSixty, rangeHundred, musicFactor, c, forceBeat) ; //<>//
      
      if (soundButton[ID_item] == 1) strokeWeight(newSize.x) ; else strokeWeight(p.size.x *size.x) ;
      
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
   
    for (Old_Pixel p : listEscargot) {
      
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
    
    for (Old_Pixel p : listEscargot) {
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
    
    for (Old_Pixel p : listEscargot) {
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
      if (soundButton[ID_item] == 1) { 
        if( witness > size.z) box(newSize.x, newSize.y, newSize.z) ; 
      } else if (soundButton[ID_item] == 0){ 
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
    
    for (Old_Pixel p : listEscargot) {
      
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
    
    for (Old_Pixel p : listEscargot) { 
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
  
  
    for (Old_Pixel b : listEscargot) {
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
            Old_Pixel p = (Old_Pixel) listPixelRaw.get(posInList) ;
            
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
    if (result.z > size.z || soundButton[ID_item] == 1) {
    result.x = beatReactivityHSB(size, classSize, c, range360, range100, factor).x *map(allBeats(ID_item),1,40,1,beatAmplitude);
    result.y = beatReactivityHSB(size, classSize, c, range360, range100, factor).y *map(allBeats(ID_item),1,40,1,beatAmplitude) ;
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
    result.x = beatReactivityHSB(size, classSize, c, range360, range100, factor).x *map(allBeats(ID_item),1,40,1,beatAmplitude) ;
    result.y = beatReactivityHSB(size, classSize, c, range360, range100, factor).y *map(allBeats(ID_item),1,40,1,beatAmplitude) ;
    result.z = beatReactivityHSB(size, classSize, c, range360, range100, factor).z ;
      
    if (soundButton[ID_item] == 1) {
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
    colorAnalyzeSetting(sizePixForAnalyze, bitmap_import[ID_item]) ;
    
    //step 2
    //three componants : FIRST : size of the pixel grid // SECOND which PImage // THIRD mirror "FALSE" or "TRUE"
    recordPixelRaw(sizePixForAnalyze, bitmap_import[ID_item], false) ; 
    
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
ArrayList<Old_Pixel> listEscargot =  new ArrayList<Old_Pixel>()   ;
//Temp Array List
ArrayList<Old_Pixel> listPixelTemp =  new ArrayList<Old_Pixel>()   ;
ArrayList<Old_Pixel> listPixelByCol =  new ArrayList<Old_Pixel>()  ;
ArrayList<Old_Pixel> listPixelByRow =  new ArrayList<Old_Pixel>() ;

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
    Old_Pixel pixelRef = (Old_Pixel) listPixelRaw.get(pivot) ;


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
              Old_Pixel pixelEscargotAnalyze = (Old_Pixel) listPixelRaw.get(getPixelEscargotAnalyze) ; //look the pixel in the list
              
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
    Old_Pixel pixelRef = (Old_Pixel) listPixelRaw.get(pivot) ;


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
              Old_Pixel pixelEscargotAnalyze = (Old_Pixel) listPixelRaw.get(getPixelEscargotAnalyze) ; //look the pixel in the list
              
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
      Old_Pixel pixTemp = (Old_Pixel) listPixelTemp.get(j) ;
      if( pixTemp.gridPos.x == whichCol ) {
        numPixInCol += 1 ;
        listPixelByCol.add(new Old_Pixel(pixTemp.rank)) ;
      }
    }
    //Changez the ID "ZERO" to "ONE" of pixel if there is more of one point in col
    if(numPixInCol > 1  ) {
      int [] pixPosInCol = new int [numPixInCol] ;
      for ( int k = 0 ; k < listPixelByCol.size() ; k++) {
        Old_Pixel pixByCol = (Old_Pixel) listPixelByCol.get(k) ;
        pixPosInCol[k] = pixByCol.rank ;
      }
      pixPosInCol = sort(pixPosInCol) ;
      for(int l = pixPosInCol[0] ; l < pixPosInCol[pixPosInCol.length -1] ; l++) {
        Old_Pixel pix = (Old_Pixel) listPixelRaw.get(l) ;
        if(pix.ID == 0) {
          // git a new ID "ONE" to say this Pixel has been checked, and now don'k try to make something with her
          pix.changeID(1) ;
          //complet the temp list completed
          PVector posInTheGrid = gridPosition(l) ;
      //    listPixelTempCompleted.add(new Pixel(l, posInTheGrid)) ;
          listPixelTemp.add(new Old_Pixel(l, posInTheGrid)) ;
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
      Old_Pixel pixTemp = (Old_Pixel) listPixelTemp.get(j) ;
      if( pixTemp.gridPos.y == whichRow ) { 
        numPixInRow += 1 ;
        listPixelByRow.add(new Old_Pixel(pixTemp.rank, pixTemp.gridPos)) ;
      }
    }
    //Changez the ID "ZERO" to "ONE" of pixel if there is more of one point in col
    if(numPixInRow > 1  ) {
      int [] pixPosInRow = new int [numPixInRow] ;
      int [] whichColForPix = new int [numPixInRow] ;
      for ( int k = 0 ; k < listPixelByRow.size() ; k++) {
        Old_Pixel pixByRow = (Old_Pixel) listPixelByRow.get(k) ;
        pixPosInRow[k] = pixByRow.rank ;
        whichColForPix[k] = (int)pixByRow.gridPos.x ;
      }
      //pixPosInRow = sort(pixPosInRow) ;
      whichColForPix = sort(whichColForPix) ;
      int startPoint = whichColForPix[0] ;
      int lastPoint = whichColForPix[pixPosInRow.length -1] ;

      for(int l = startPoint ; l < lastPoint  ; l++) {
        int whichPixel = (l-1) * rows + pixPosInRow[0] %rows ;
        Old_Pixel pix = (Old_Pixel) listPixelRaw.get(whichPixel) ;
        if(pix.ID == 0) {
          // git a new ID "ONE" to say this Pixel has been checked, and now don'k try to make something with her
          pix.changeID(1) ;
          //complet the temp list completed
          PVector posInTheGrid = gridPosition(whichPixel) ;
          //listPixelTempCompleted.add(new Pixel(whichPixel, posInTheGrid)) ;
          listPixelTemp.add(new Old_Pixel(whichPixel, posInTheGrid)) ;
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
  for ( Old_Pixel p :  listPixelTemp ) {
    PVector posInTheGrid = p.gridPos ;
    barycenterEscargot.x += posInDisplay(posInTheGrid.x, pixSize) ;
    barycenterEscargot.y += posInDisplay(posInTheGrid.y, pixSize) ;
  }
  //divid the some of the point to find the position of the barycenter
  barycenterEscargot.x /= listPixelTemp.size() ; 
  barycenterEscargot.y /= listPixelTemp.size() ;

  PVector sizeBarycenter = new PVector(numberPixelAnalyze, numberPixelAnalyze) ;
  //add barycenter in the list
  listEscargot.add(new Old_Pixel(barycenterEscargot, sizeBarycenter, cRef)); 
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
public void hueSaturationBrightnessCheck(int escargotPos_n, int cRef, Old_Pixel pixelEscargotAnalyze, boolean whichPix) {
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
    
    listPixelTemp.add( new Old_Pixel(getPixelEscargotAnalyze, posInTheGrid)) ;
    
    numberPixelAnalyze += 1 ; // count of pixel has be analyzing
  } else {
    //close this direction for the next round
    lockEscargot[escargotPos_n -1] = 1 ;
  }
}

//by hue
public void hueCheck(int escargotPos_n, int cRef, Old_Pixel pixelEscargotAnalyze, boolean whichPix) {
  //choice the ref color in pix Class a original color or the new one
  if( !whichPix ) wichColorCheck = pixelEscargotAnalyze.colour ; else wichColorCheck = pixelEscargotAnalyze.newColour ;
  if( pixelEscargotAnalyze.ID == 0 && hue(wichColorCheck) == hue(cRef) ) { // check if the pixel is never analyze before and if the hue is good
  // change the ID "ZERO" to "ONE" to indicate this that pixel has to be checked and have a good color.
    pixelEscargotAnalyze.changeID(1) ;
    //return the coordinate in the grid system rows and cols
    PVector posInTheGrid = gridPosition(getPixelEscargotAnalyze) ;
    
    listPixelTemp.add( new Old_Pixel(getPixelEscargotAnalyze, posInTheGrid)) ;
    
    numberPixelAnalyze += 1 ; // count of pixel has be analyzing
  } else {
    //close this direction for the next round
    lockEscargot[escargotPos_n -1] = 1 ;
  }
}

//by saturation
public void saturationCheck(int escargotPos_n, int cRef, Old_Pixel pixelEscargotAnalyze, boolean whichPix) {
  //choice the ref color in pix Class a original color or the new one
  if( !whichPix ) wichColorCheck = pixelEscargotAnalyze.colour ; else wichColorCheck = pixelEscargotAnalyze.newColour ;
  if( pixelEscargotAnalyze.ID == 0 && saturation(wichColorCheck) == saturation(cRef) ) // check if the pixel is never analyze before and if the hue is good
    {

    // change the ID "ZERO" to "ONE" to indicate this that pixel has to be checked and have a good color.
    pixelEscargotAnalyze.changeID(1) ;
    //return the coordinate in the grid system rows and cols
    PVector posInTheGrid = gridPosition(getPixelEscargotAnalyze) ;
    
    listPixelTemp.add( new Old_Pixel(getPixelEscargotAnalyze, posInTheGrid)) ;
    
    numberPixelAnalyze += 1 ; // count of pixel has be analyzing
  } else {
    //close this direction for the next round
    lockEscargot[escargotPos_n -1] = 1 ;
  }
}

//by brightness
public void brightnessCheck(int escargotPos_n, int cRef, Old_Pixel pixelEscargotAnalyze, boolean whichPix) {
  //choice the ref color in pix Class a original color or the new one
  if( !whichPix ) wichColorCheck = pixelEscargotAnalyze.colour ; else wichColorCheck = pixelEscargotAnalyze.newColour ;
  if( pixelEscargotAnalyze.ID == 0 && brightness(wichColorCheck) == brightness(cRef) ) // check if the pixel is never analyze before and if the hue is good
    {
      // change the ID "ZERO" to "ONE" to indicate this that pixel has to be checked and have a good color.
    pixelEscargotAnalyze.changeID(1) ;
    //return the coordinate in the grid system rows and cols
    PVector posInTheGrid = gridPosition(getPixelEscargotAnalyze) ;
    
    listPixelTemp.add( new Old_Pixel(getPixelEscargotAnalyze, posInTheGrid)) ;
    
    numberPixelAnalyze += 1 ; // count of pixel has be analyzing
  } else {
    //close this direction for the next round
    lockEscargot[escargotPos_n -1] = 1 ;
  }
}
//by hue and saturation
public void hueSaturationCheck(int escargotPos_n, int cRef, Old_Pixel pixelEscargotAnalyze, boolean whichPix) {
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
    
    listPixelTemp.add( new Old_Pixel(getPixelEscargotAnalyze, posInTheGrid)) ;
    
    numberPixelAnalyze += 1 ; // count of pixel has be analyzing
  } else {
    //close this direction for the next round
    lockEscargot[escargotPos_n -1] = 1 ;
  }
}

// by hue and brigthness
public void hueBrightnessCheck(int escargotPos_n, int cRef, Old_Pixel pixelEscargotAnalyze, boolean whichPix) {
  //choice the ref color in pix Class a original color or the new one
  if( !whichPix ) wichColorCheck = pixelEscargotAnalyze.colour ; else wichColorCheck = pixelEscargotAnalyze.newColour ;
  if( pixelEscargotAnalyze.ID == 0 // check if the pixel is never analyze before
      && hue(wichColorCheck) == hue(cRef) // and if the hue is good
      && brightness(wichColorCheck) == brightness(cRef) ) { // and if the brightness is good too 
    // change the ID "ZERO" to "ONE" to indicate this that pixel has to be checked and have a good color.
    pixelEscargotAnalyze.changeID(1) ;
    //return the coordinate in the grid system rows and cols
    PVector posInTheGrid = gridPosition(getPixelEscargotAnalyze) ;
    
    listPixelTemp.add( new Old_Pixel(getPixelEscargotAnalyze, posInTheGrid)) ;
    
    numberPixelAnalyze += 1 ; // count of pixel has be analyzing
  } else {
    //close this direction for the next round
    lockEscargot[escargotPos_n -1] = 1 ;
  }
}

//by saturation and brightness
public void saturationBrightnessCheck(int escargotPos_n, int cRef, Old_Pixel pixelEscargotAnalyze, boolean whichPix) {
  //choice the ref color in pix Class a original color or the new one
  if( !whichPix ) wichColorCheck = pixelEscargotAnalyze.colour ; else wichColorCheck = pixelEscargotAnalyze.newColour ;
  if( pixelEscargotAnalyze.ID == 0 // check if the pixel is never analyze before
      && saturation(wichColorCheck) == saturation(cRef) // and if the saturation is good
      && brightness(wichColorCheck) == brightness(cRef) ) { // and if the brightness is good too 
    // change the ID "ZERO" to "ONE" to indicate this that pixel has to be checked and have a good color.
    pixelEscargotAnalyze.changeID(1) ;
    //return the coordinate in the grid system rows and cols
    PVector posInTheGrid = gridPosition(getPixelEscargotAnalyze) ;
    
    listPixelTemp.add( new Old_Pixel(getPixelEscargotAnalyze, posInTheGrid)) ;
    
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
ArrayList<Old_Pixel> listPixelRaw = new ArrayList<Old_Pixel>() ;
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
        listPixelRaw.add(new Old_Pixel(pos, c)) ;
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
        listPixelRaw.add(new Old_Pixel(pos, c)) ;
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
/**
SURFACE || 2014 || 1.0.0
*/

class Surface extends Romanesco {
  public Surface() {
    RPE_name = "Surface" ;
    ID_item = 24 ;
    ID_group = 1 ;
    RPE_author  = "Stan le Punk";
    RPE_version = "Version 1.0.0";
    RPE_pack = "Base" ;
    RPE_mode = "Surfimage/Vague/Vague++" ; // separate the differentes mode by "/"
    RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Stroke hue,Stroke sat,Stroke bright,Stroke alpha,Thickness,Influence,Canvas X,Canvas Y,Quality,Canvas X,Speed X,Size X" ;
  }
  
  // Main method image 
  boolean newPicture ;
  boolean choicePicture = false ;
  PImage image  ;
  ArrayList<Polygon> grid_surface_image = new ArrayList<Polygon>();
  // Main method surface simple
  ArrayList<Polygon> grid_surface_simple = new ArrayList<Polygon>();
  
  // setup
  public void setup() {
    startPosition(ID_item, width/2, height/2, 0) ;
    load_bitmap(ID_item) ;
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
  public void draw() {
    // color to Vec4 composant
    fill_color = Vec4(hue(fill_item[ID_item]),saturation(fill_item[ID_item]),brightness(fill_item[ID_item]),alpha(fill_item[ID_item])) ;
    stroke_color = Vec4(hue(stroke_item[ID_item]),saturation(stroke_item[ID_item]),brightness(stroke_item[ID_item]),alpha(stroke_item[ID_item])) ;
    // load image
    if(parameter[ID_item]) load_bitmap(ID_item) ;


    if(motion[ID_item]) speed = speed_x_item[ID_item] *.7f ; else speed = 0 ;
    
    
    
    // IMAGE GRID
    sizePixel_image = floor(map(quality_item[ID_item], 0,1,width/20,2)) ;
    if(!FULL_RENDERING) sizePixel_image *= 3 ;
    // update data of the image
    if(nTouch) {
      newPicture = false ; 
      choicePicture = false ;
    }
    
    
    
    
    // simple grid param
    ////////////////////
    if(mode[ID_item] != 0 ) {
      //size pixel triangle
      int sizePixMin = 7 ;
      int sizePix_grid_simple = PApplet.parseInt(sizePixMin +size_x_item[ID_item] /11) ;
      if(!FULL_RENDERING) sizePix_grid_simple *= 3 ;
      //size canvas grid
      Vec2 newCanvas = Vec2(canvas_x_item[ID_item],canvas_y_item[ID_item]) ;
      newCanvas.mult(4.5f) ;
      // create grid if there is no grid
      if( grid_surface_simple.size() < 1) create_surface_simple(sizePix_grid_simple,newCanvas) ;
      
      // from of the wave
      int maxStep = (int)map(influence_item[ID_item],0,1,2,50) ;
      step = map(noise(5),0,1,0,maxStep) ; // break the linear mode of the wave
      // amplitude
      amplitude_simple_grid = swing_x_item[ID_item] *height *.07f *allBeats(ID_item)  ;
      amplitude_simple_grid *= amplitude_simple_grid  ;
      
      // clear the list
      if(resetAction(ID_item)) {
        grid_surface_simple.clear() ;
      }
      
      // Vague + clear
      if(mode[ID_item] == 1 ) {
        if( refSizeTriangle != size_x_item[ID_item] || !compare(canvasRef,newCanvas) ) {
          if(mode[ID_item] == 1 ) grid_surface_simple.clear() ;
          create_surface_simple(sizePix_grid_simple,newCanvas) ;
        }
      }
      // vague ++
      if(mode[ID_item] == 2) {
        if( refSizeTriangle != size_x_item[ID_item] || !compare(canvasRef,newCanvas) ) {
          create_surface_simple(sizePix_grid_simple,newCanvas) ;
        }
      }
      // make the reference
      refSizeTriangle = size_x_item[ID_item] ;
      canvasRef = newCanvas ;
    }
    // END simple grid param
    ////////////////////////
    
    // update image grid
    if(motion[ID_item]) {
      float speed_image = speed_x_item[ID_item] * .2f ;
      float amplitude_image = swing_x_item[ID_item] *width *2 *allBeats(ID_item) ;
      altitude_image = PApplet.parseInt(sin(frameCount *speed_image) *amplitude_image) ;
    }
    
    
    // update all mode
    /////////////////////////////
    update_and_clean(mode[ID_item]) ;
    
    // info
    if(mode[ID_item] == 0 ) {
      objectInfo[ID_item] =("Mode: " + mode[ID_item] +" | Triangles:"+grid_surface_image.size() + " | " + image.width + "x" + image.height) ; 
    } else objectInfo[ID_item] =("Mode: " + mode[ID_item] +" | Triangles:"+grid_surface_simple.size()) ;
    
    
  }
  // End Display method
  ////////////////////
  
  
  
  
  // Annexe method
  ///////////////
 
  // method display mode
  public void update_and_clean(int whichMode) {
    if(whichMode == 0 ) {
      if( grid_surface_simple.size() > 0 )grid_surface_simple.clear() ;
      update_surface_image(sizePixel_image, fill_color, stroke_color,thickness_item[ID_item], altitude_image) ;
    } else if (whichMode == 1 || whichMode == 2 ) {
      if( grid_surface_image.size() > 0 )grid_surface_image.clear() ;
      update_surface_simple(fill_item[ID_item], stroke_item[ID_item], thickness_item[ID_item], speed, amplitude_simple_grid, step) ;
    }
  }
  
  
  // SURFACE SIMPLE
  public void create_surface_simple(int sizePix, Vec2 canvas) {
    /*
    PVector setting_position give the starting position for the drawing grid, the value is -1 to 1
    if you start with (0,0) the canvas start from the center, if you use the extreme value, the draw start from corner.
    this value can be interesting for the rotation axes.
    */
    PVector pos = new PVector(0, 0) ; 
    surfaceGrid(sizePix, canvas, pos, grid_surface_simple) ;
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
      image = bitmap_import[ID_item] ;
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
    PVector pos = new PVector(x, y) ; 
    /*
    PVector setting_position give the starting position for the drawing grid, the value is -1 to 1
     if you start with (0,0) the canvas start from the center, if you use the extreme value, the draw start from corner.
     this value can be interesting for the rotation axes.
     */
    surfaceGridImg(sizeTriangle, pos, image, gridTriangle) ;
    if(gridTriangle.size() > 0 ) {
      if(TEST_ROMANESCO) println("compute Surface grid");
      surfaceImgColor(gridTriangle, color_fill, color_stroke, thickness) ;
      
      surfaceImgSummit(altitude, gridTriangle) ;
      createSurfaceShape(gridTriangle) ;
      newPicture = false ;
    }
  }
  
  // CHANGE PATTERN from IMAGE
  PImage imgSurface ;
  
  
  public void surfaceGridImg(int sizePix, PVector pos, PImage imgSurface, ArrayList<Polygon> gridTriangle) {
    if(imgSurface != null) {
      // find info from image
      this.imgSurface = imgSurface ;
      // clear the list if you load an other picture.
      gridTriangle.clear(); 
      listTrianglePoint.clear() ;
      
      //classic grid method
      Vec2 canvas = Vec2(imgSurface.width, imgSurface.height);
      surfaceGrid(sizePix, canvas, pos, gridTriangle) ;
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
    if(TEST_ROMANESCO) println("Create high Surface mesh");
    patternShape = createShape();
    patternShape.beginShape(TRIANGLES);
    for (Polygon t : gridTriangle) {
      t.draw_polygon_in_PShape(patternShape) ;
    }
    patternShape.endShape(CLOSE);
    if(TEST_ROMANESCO) println("High Surface mesh has been created with "+patternShape.getVertexCount()+" vertex");
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
public void surfaceGrid(int triangleSize, Vec2 canvas, PVector pos, ArrayList<Polygon> gridTriangle) {
  buildTriangleGrid(triangleSize, canvas, pos, gridTriangle) ;
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
/**
Movisco || 2016 || 0.01
*/

class Movisco extends Romanesco {
	public Movisco() {
		RPE_name = "Movisco" ;
		ID_item = 25 ;
		ID_group = 1 ;
		RPE_author  = "Stan le Punk";
		RPE_version = "Version 0.0.1";
		RPE_pack = "Base" ;
		RPE_mode = "" ; // separate the differentes mode by "/"
		RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Stroke hue,Stroke sat,Stroke bright,Stroke alpha,Thickness,Influence,Canvas X,Canvas Y,Quality,Canvas X,Speed X,Size X" ;
	}

	int rows, cols ;
	int num_pixel ;
	int step_grid = 10;
	int step_grid_analyze = 10 ;
	int correction_pos_y = 0 ;
	// create variable to carch in HSB or RGB mode
	Vec3 color_pixel_HSB[];
	Vec3 color_pixel_RGB[];

	int pix_step ;

	// setup
	public void setup() {
		startPosition(ID_item, width/2, height/2, 0) ;
		load_movie(ID_item) ;

		pix_step = 50 ;
		if(movieImport[ID_item] != null) {
			set_grid_movie(pix_step, ID_item) ;
			full_window_movie(ID_item) ;
			center_movie_in_the_height(ID_item) ;
		}
	}

	// draw
	public void draw() {
		if(movieImport[ID_item] != null) {
			analyze_movie_pixel(ID_item) ;
			int size_cloud_pix = PApplet.parseInt(pix_step *2) ;
			float comp_1 = 1 ; // red or hue
			float comp_2 = 1 ; // green or saturation
			float comp_3 = 1 ;  // blue or brightnes
			float comp_4 = .9f ; // alpha
			float comp_5 = .9f ; // pixel density in case or the pixel are particle system
			Vec5 density = Vec5(comp_1,comp_2,comp_3,comp_4,comp_5) ; // Vec5(red,green,blue,alpha, pixel density) value factor between 0 and 1

			float size_pix = 1 ;
			String pattern = "4_RANDOM" ;
			float depth = 0 ;
			display_movie_cloud(size_pix, size_cloud_pix, pattern, density, depth) ;
		}
	}

	// Annexe method
	public void set_grid_movie(int pix_step, int ID_item) {
		step_grid = pix_step ;
		step_grid_analyze = pix_step ;
		rows = movieImport[ID_item].width / step_grid;
		cols = movieImport[ID_item].height / step_grid;
		num_pixel = rows *cols ;
		if(g.colorMode == 3 )  color_pixel_HSB = new Vec3[num_pixel]; 
		else color_pixel_RGB = new Vec3[num_pixel];
		for(int i = 0 ; i < num_pixel ; i++) {
			if(g.colorMode == 3 ) color_pixel_HSB[i] = Vec3(0) ; else color_pixel_RGB[i] = Vec3(0) ;
		}
	}








	// DRAW
	//////////////////
	public void analyze_movie_pixel(int ID_item) {
	  if (movieImport[ID_item].available()) {
	  movieImport[ID_item].read();
	    movieImport[ID_item].loadPixels();
	    int count = 0;
	    for (int i = 0; i < cols; i++) {
	      for (int j = 0; j < rows; j++) {
	        int color_temp = movieImport[ID_item].get(j *step_grid_analyze, i *step_grid_analyze) ;
	        if(g.colorMode == 3 ) color_pixel_HSB[count] = Vec3 (hue(color_temp), saturation(color_temp), brightness(color_temp)) ;
	        else color_pixel_RGB[count] = Vec3 (red(color_temp), green(color_temp), blue(color_temp)) ;
	        count++;
	      }
	    }
	  }
	}









	/**
	display the pixel
	*/
	public void display_movie_cloud(float size_pix, int size_pix_cloud, String pattern, Vec5 density_cloud, float ratio_depth) {
	  // setting color because the color pix can be diffenrent for the RGB or the HSB
	  /* catch the value of the alpha, because this one is not a component of the video, but from the colorMode.
	  And we don't know this one in advance */
	  float value_alpha_max = g.colorModeA ;
	  Vec3 [] color_temp = new Vec3[num_pixel] ;
	        
	  if(g.colorMode == 1 ) for (int i = 0 ; i < color_pixel_RGB.length ;i++) color_temp[i] = color_pixel_RGB[i].copy() ;
	  else for (int i = 0 ; i < color_pixel_HSB.length ;i++) color_temp[i] = color_pixel_HSB[i].copy() ;
	  
	  for (int i = 0; i < cols; i++) {
	    for (int j = 0; j < rows; j++) {
	      int which_point = i *rows +j ;
	      float r = color_temp[which_point].r *density_cloud.a ;
	      float gr = color_temp[which_point].g *density_cloud.b;
	      float b = color_temp[which_point].b *density_cloud.c;
	      float a =  value_alpha_max *density_cloud.d ;


	      // note the order of i and j is different between camera and movie
	      int x = j *step_grid ;
	      int y = i *step_grid +correction_pos_y ;
	      float bright = 0 ;
	      if(g.colorMode == 3 ) bright = color_pixel_HSB[which_point].b ; 
	      else bright = brightness(color(color_pixel_RGB[which_point].r,color_pixel_RGB[which_point].g,color_pixel_RGB[which_point].b)) ;
	      float z = map(bright,0, g.colorModeA ,0,1) ;
	      Vec3 pos = Vec3(x,y,z) ;

	      z *= ratio_depth ;
	      int num = (int)(color_temp[i *rows + j].b *density_cloud.e) ;

	      //display
	      fill(r, gr, b, a);
	      stroke(r, gr, b, a);
	      strokeWeight(size_pix) ;
	      pixel_cloud(pos, num, size_pix_cloud, pattern);
	    }
	  }
	}




	// local method

	// Pixel shape
	public void pixel_cloud(Vec3 pos, int num, int radius, String pattern) {
	  Pixel_cloud p = new Pixel_cloud(num, "3D", "ORDER") ;
	  p.beat(20) ;
	  p.pattern(pattern) ;
	  p.distribution(Vec3(pos.x +(step_grid /2),pos.y,pos.z), radius) ;
	  p.costume() ;
	}


	public void pixel_classic(Vec3 pos, int size_int, Vec4 colour, String costume) {
	  Vec3 size = Vec3(size_int) ;
	  Pixel p = new Pixel(pos, size, colour, costume) ;
	  p.angle(p.colour.z) ;
	  p.costume() ;
	}




	/**
	Put the movie to the right and nice place
	*/
	public void full_window_movie(int ID_item) {
	  // use this method only one time, in the setting for example
	  if(movieImport[ID_item].width != width || movieImport[ID_item].height != height) {
	    float ratio = PApplet.parseFloat(width) / PApplet.parseFloat(movieImport[ID_item].width) ;
	    step_grid *= ratio ;
	  }
	}


	public void center_movie_in_the_height(int ID_item) {
	  if(movieImport[ID_item].height != height) {
	    float ratio = PApplet.parseFloat(width) / PApplet.parseFloat(movieImport[ID_item].width) ;
	    correction_pos_y = PApplet.parseInt((height -(movieImport[ID_item].height *ratio))  *.5f );
	  } 
	}
}
/**
Ecosysteme || 2016 || 0.0.6
*/

interface RULES_ECOSYSTEME {
	float CLOCK = 1.5f ;
	int TIME_TO_BE_CARRION = 10 ;
}




class Ecosysteme extends Romanesco {
	public Ecosysteme() {
		RPE_name = "Ecosysteme" ;
		ID_item = 26 ;
		ID_group = 1 ;
		RPE_author  = "Stan le Punk";
		RPE_version = "Version 0.0.4";
		RPE_pack = "Base" ;
		RPE_mode = "Tetra/Face/Line/Info" ; // separate the differentes mode by "/"
		RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Stroke hue,Stroke sat,Stroke bright,Stroke alpha,Thickness,Size X,Canvas X,Canvas Y,Canvas Z,Speed X,Quantity,Scope,Life" ;
	}






	/**
	setting
	*/
	public void setup() {
		startPosition(ID_item, width/2, height/2, 0) ;
		DISPLAY_INFO = false ; ;
		ENVIRONMENT = 3 ;
		if (ENVIRONMENT == 3 ) {
	    Vec3 pos_box = Vec3(width/2,height/2,0) ;
	    int scale_box = 4 ;
	    // Vec3 size_box = Vec3(canvas_x_item[ID_item] *scale_box, canvas_y_item[ID_item] *scale_box, canvas_z_item[ID_item] *scale_box) ;
	    Vec3 size_box = Vec3(width *scale_box, width *scale_box, width *scale_box) ;
	    build_environment(pos_box, size_box) ;
	  } else {
	    Vec2 pos_box = Vec2(width/2,height/2) ;
	    Vec2 size_box = Vec2(width,height) ;
	    build_environment(pos_box, size_box) ;
	  }
	  
	  float quantity = .2f ;
	  float life = .5f ;
	  float size = width/5 ; // it's like a first third part of the slider I think ????
	  float speed = .3f ;
	  float scope = .3f ;
	  ecosystem_setting(quantity, life, size, speed, scope) ;
	}











	/**
	draw / display
	*/
	boolean tetra_face, poly_face, poly_line  ;
	int flora_costume, corpse_costume, carnivore_costume, herbivore_costume, bacterium_costume  ;
	
	public void draw() {
		// info
		// print_info_carnivore(CARNIVORE_LIST) ;
		// costume
		if(tetra_face) {
			flora_costume = corpse_costume = carnivore_costume = herbivore_costume = bacterium_costume = TETRAHEDRON_RPE ;
		} else if (poly_face) {
			flora_costume = SPHERE_LOW_RPE ;
			herbivore_costume = TETRAHEDRON_RPE ;
			carnivore_costume = CROSS_3_RPE ;
			bacterium_costume = CROSS_2_RPE ;
			corpse_costume = BOX_RPE ;
		} else if (poly_line) {
			flora_costume = 1002 ;
			herbivore_costume = 1002 ;
			carnivore_costume = 1005 ;
			bacterium_costume = 1003 ;
			corpse_costume = 1001 ;
		}

		// set colour
		Vec4 fill_flora = Vec4(hue(fill_item[ID_item]), saturation(fill_item[ID_item]), brightness(fill_item[ID_item]),alpha(fill_item[ID_item])) ;
		Vec4 stroke_flora = Vec4(hue(stroke_item[ID_item]), saturation(stroke_item[ID_item]), brightness(stroke_item[ID_item]),alpha(stroke_item[ID_item])) ;
		Vec4 fill_herbivore = Vec4(fill_flora) ;
		Vec4 stroke_herbivore = Vec4(stroke_flora) ;
		Vec4 fill_carnivore = Vec4(fill_flora) ;
		Vec4 stroke_carnivore = Vec4(stroke_flora) ;
		Vec4 fill_bacterium = Vec4(fill_flora) ;
		Vec4 stroke_bacterium = Vec4(stroke_flora) ;
		Vec4 fill_corpse = Vec4(fill_flora) ;
		Vec4 stroke_corpse = Vec4(stroke_flora) ;

		// calcul the reflect color
		float target_colour_herbivore = -60 ;
		float target_colour_carnivore = -95 ;
		float target_colour_bacterium = 120 ;
		float target_colour_corpse = 120 ;
		fill_herbivore.x = map_cycle(target_colour_herbivore +fill_flora.x, 0,360) ;
		fill_carnivore.x = map_cycle(target_colour_carnivore +fill_flora.x, 0,360) ;
		fill_bacterium.x = map_cycle(target_colour_bacterium +fill_flora.x, 0,360) ;
		fill_corpse.x = map_cycle(target_colour_corpse +fill_flora.x, 0,360) ;
		
		stroke_herbivore.x = map_cycle(target_colour_herbivore +stroke_flora.x, 0,360) ;
		stroke_carnivore.x = map_cycle(target_colour_carnivore +stroke_flora.x, 0,360) ;
		stroke_bacterium.x = map_cycle(target_colour_bacterium +stroke_flora.x, 0,360) ;
		stroke_corpse.x = map_cycle(target_colour_corpse +stroke_flora.x, 0,360) ;

      float temp_fill_corps_y = fill_corpse.y ;
      float temp_stroke_corps_y = stroke_corpse.y ;
      fill_corpse.y *= .1f ;
		stroke_corpse.y *= .1f ;
		float temp_fill_corps_z = fill_corpse.z ;
      float temp_stroke_corps_z = stroke_corpse.z ;
      fill_corpse.z *= .3f ;
		stroke_corpse.z *= .3f ;


		set_colour_flora(fill_flora, stroke_flora, thickness_item[ID_item]) ;
		set_colour_herbivore(fill_herbivore, stroke_herbivore, thickness_item[ID_item]) ;
		set_colour_carnivore(fill_carnivore, stroke_carnivore, thickness_item[ID_item]) ;
		set_colour_bacterium(fill_bacterium, stroke_bacterium, thickness_item[ID_item]) ;
		set_colour_corpse(fill_corpse, stroke_corpse, thickness_item[ID_item]) ;

		fill_corpse.y = temp_fill_corps_y ;
		stroke_corpse.y = temp_stroke_corps_y ;
		fill_corpse.z = temp_fill_corps_z ;
		stroke_corpse.z = temp_stroke_corps_z ;

		flora(FLORA_LIST, DISPLAY_INFO, flora_costume) ;
		herbivore(HERBIVORE_LIST, FLORA_LIST, DISPLAY_INFO, herbivore_costume) ;
		carnivore(CARNIVORE_LIST, HERBIVORE_LIST, CORPSE_LIST, DISPLAY_INFO, carnivore_costume) ;
		bacterium(BACTERIUM_LIST, CORPSE_LIST, DISPLAY_INFO, bacterium_costume) ;
		corpse(CORPSE_LIST, DISPLAY_INFO, corpse_costume) ;


		// mode
		/*
			"Tetra/Face/Line/Info"
	boolean tetra_face, poly_face, poly_line  ;
	*/
		if(mode[ID_item] == 0 ) {
			tetra_face = true ;
			poly_face = false ;
			poly_line = false ;
			DISPLAY_INFO = false ;
		} else if(mode[ID_item] == 1 ) {
			tetra_face = false ;
			poly_face = true ;
			poly_line = false ;
			DISPLAY_INFO = false ;
		} else if(mode[ID_item] == 2 ) {
			tetra_face = false ;
			poly_face = false ;
			poly_line = true ;
			DISPLAY_INFO = false ;
		} else if(mode[ID_item] == 3 ) {
			tetra_face = false ;
			poly_face = false ;
			poly_line = false ;
			DISPLAY_INFO = true ;
		}



      // add flora
		if(action[ID_item]  && nTouch) {
			ecosystem_setting(quantity_item[ID_item], life_item[ID_item], size_x_item[ID_item], speed_x_item[ID_item], scope_item[ID_item]) ;
		}
	}


	public void ecosystem_setting(float quantity, float life, float size, float speed, float scope) {
		clear_ecosystem() ;
		// QUANTITY
		float factor_num = 1 ;
		if(!FULL_RENDERING) factor_num = .1f ;
		int num_flora = ceil(800 *quantity *factor_num) ;
		int num_herbivore = ceil(400 *quantity *factor_num) ; 
		int num_carnivore = ceil(4 *quantity *factor_num) ; 
		int num_bacterium = ceil(8 *quantity *factor_num) ;

		// Colour
		Vec4 colour_flora = Vec4(100,100,80,100) ;
		Vec4 colour_herbivore = Vec4(50,100,100,100) ;
		Vec4 colour_carnivore = Vec4(0,100,100,100)  ; 
		Vec4 colour_bacterium = Vec4(30,0,30,100) ;

		// Size
		int size_flora = ceil(.01f *size) ;
		int size_herbivore = ceil(.15f *size) ;
		int size_carnivore = ceil(.45f *size);
		int size_bacterium = ceil(.01f *size) ;

		// Life
		int life_herbivore = ceil(500 *life) ;
		int life_carnivore = ceil(1000  *life) ;
		int life_bacterium = ceil(10000  *life) ;

		// Velocity
		int velocity_herbivore = ceil(6 *speed) ;
		int velocity_carnivore = ceil(12 *speed) ;
		int velocity_bacterium = ceil(2 *speed) ;

		//Radar
		float radar_herbivore = .01f *scope;
		float radar_carnivore = .04f *scope ;
		float radar_bacterium = .24f *scope ;
		if(ENVIRONMENT == 3) {
			// in 3D it's necessary to give very very bigger range for the radar.
			int ratio_range_radar = 5 ;
			radar_herbivore *= ratio_range_radar ;
			radar_carnivore *= ratio_range_radar ;
			radar_bacterium *= ratio_range_radar ;
		}
		// BUILD
		build_flora(size_flora, colour_flora, num_flora) ;
		build_herbivore(size_herbivore, life_herbivore, velocity_herbivore, radar_herbivore, colour_herbivore, num_herbivore) ;
		build_carnivore(size_carnivore, life_carnivore, velocity_carnivore, radar_carnivore, colour_carnivore, num_carnivore) ;
		build_bacterium(size_bacterium, life_bacterium, velocity_bacterium, radar_bacterium, colour_bacterium, num_bacterium) ;
	}
	














	/**
	ANNEXE METHODE
	*/
	/**
	UPDATE ECOSYSTEME 0.0.3
	*/

	/**
	BIOTOPE
	*/
	public Vec4 biotope_colour() {
	  float normal_humus_level = 1 - HUMUS / HUMUS_MAX ;
	  float var_colour_ground = 90 *normal_humus_level ;
	  return Vec4(40,90, 5 +var_colour_ground,100) ;
	}
	/**
	End biotope
	*/













	/**
	Flora update 0.0.2
	*/
	public void flora(ArrayList<Flora> list_f, boolean info, int which_costume) {

	  // remove
	  for(Flora f : list_f) {
	    if(f.life < 0 ) {
	      list_f.remove(f) ;
	      break ;
	    }
	  }

	  // life of the agent
	  for(Flora f : list_f) {
	    // info
	    float ratio = PApplet.parseFloat(f.size) / PApplet.parseFloat(f.size_ref) ;
	    float alpha = g.colorModeA *ratio ;
	    if(alpha <= 0) alpha = .001f ;
	    f.colour.set(f.colour.r, f.colour.g, f.colour.b, alpha) ;
	    // update
	    f.growth() ;
	    f.statement() ;

	    // display
	    if(original_flora_aspect) f.aspect(f.colour, f.colour, 1) ; else f.aspect(fill_colour_flora, stroke_colour_flora, thickness_flora) ;
	    if(!info) f.costume_agent(which_costume) ; 
	    else f.info_visual_text(f.colour, SIZE_TEXT_INFO) ; 
	  }
	}
	 /**
	 set colour
	 */
	boolean original_flora_aspect = true ;
	Vec4 fill_colour_flora, stroke_colour_flora ;
	float thickness_flora ; 
	public void set_colour_flora(Vec4 fill_colour, Vec4 stroke_colour, float thickness) {
	  original_flora_aspect = false ;
	  if(fill_colour_flora == null) fill_colour_flora = Vec4(fill_colour) ; else fill_colour_flora.set(fill_colour) ;
	  if(stroke_colour_flora == null) stroke_colour_flora = Vec4(stroke_colour) ; else stroke_colour_flora.set(stroke_colour) ;
	  thickness_flora = thickness ;
	}
	/**
	End flora
	*/






















	/**
	HERBIVORE update 0.0.2
	*/
	public void herbivore(ArrayList<Herbivore> list_h, ArrayList<Flora> list_f, boolean info, int which_costume) {

	  // remove and add in the corpse list of dead body
	  for(Herbivore h : list_h) {
	    if(!h.alive) {
	      CORPSE_LIST.add(h) ;
	      list_h.remove(h) ;
	      break ;
	    }
	  }

	  // life of the agent
	  for(Herbivore h : list_h) {
	    int radius = h.size ;
	    // motion
	    h.rebound(LIMIT, REBOUND) ;
	    h.motion() ;
	    h.set_position() ;
	    h.set_starving(4) ;

	    // pick
	    if(!h.calm) pick_static_agent(h, list_f, info) ;

	    // time to eat
	    eat_flora(h, list_f, info) ;

	    // statement
	    h.statement() ;
	    h.hunger() ;

	    // display
	    if(original_herbivore_aspect) h.aspect(h.colour, h.colour, 1)  ; else h.aspect(fill_colour_herbivore, stroke_colour_herbivore, thickness_herbivore) ;
	    if(!info) h.costume_agent(which_costume) ; 
	    else h.info(h.colour, SIZE_TEXT_INFO) ;
	  }
	}
	 /**
	 set colour
	 */
	boolean original_herbivore_aspect = true ;
	Vec4 fill_colour_herbivore, stroke_colour_herbivore ;
	float thickness_herbivore ; 
	public void set_colour_herbivore(Vec4 fill_colour, Vec4 stroke_colour, float thickness) {
	  original_herbivore_aspect = false ;
	  if(fill_colour_herbivore == null) fill_colour_herbivore = Vec4(fill_colour) ; else fill_colour_herbivore.set(fill_colour) ;
	  if(stroke_colour_herbivore == null) stroke_colour_herbivore = Vec4(stroke_colour) ; else stroke_colour_herbivore.set(stroke_colour) ;
	  thickness_herbivore = thickness ;
	}
	 /**
	local method
	*/
	public void eat_flora(Herbivore h, ArrayList<Flora> list_flora_target, boolean info) {
	  if(h.eating) {
	    Flora target ;
	    target = list_flora_target.get((int)h.ID_target.x) ;
	    h.eat(target, info) ;
	  } else {
	    for(Flora target : list_flora_target) {
	      h.eat(target, info) ;
	      if(h.eating) {
	        h.ID_target.set(list_flora_target.indexOf(target),target.ID) ;
	        break ;
	      }
	    }
	  }
	}


	public void pick_static_agent(Herbivore h, ArrayList<Flora> list_flora_target, boolean info) {
	  for(Flora target : list_flora_target) {
	    h.watch(target, info) ;
	    h.pick(target) ;
	    if(h.picking()) break ;
	  }
	}
	/**
	End herbivore update
	*/



























	/**
	CARNIVORE update 0.0.2
	*/
	public void carnivore(ArrayList<Carnivore> list_carnivore, ArrayList<Herbivore> list_herbivore, ArrayList<Agent> list_dead_body, boolean info, int which_costume) {

	  /// remove and add in the corpse list of dead body
	  for(Carnivore c : list_carnivore) {
	    if(!c.alive) {
	      CORPSE_LIST.add(c) ;
	      list_carnivore.remove(c) ;
	      break ;
	    }
	  }

	  // life of the agent
	  for(Carnivore c : list_carnivore) {
	    // motion
	    c.motion() ;
	    int radius = c.size ;
	    c.rebound(LIMIT, REBOUND) ;
	    c.set_position() ;
	    c.set_starving(8) ;

	    

	    // hunt
	    if(!c.calm) hunt_dynamic_agent(c, list_herbivore, info) ;    
	    // eat after hunt, if this order is not respect the carnivore prefere hunt to eat and finish to die :)
	    if(list_dead_body.size() >= 0 ) eat_meat(c, list_dead_body, info) ; else c.eating = false ;


	    c.statement() ;
	    c.hunger() ;


	    // display
	    if(original_carnivore_aspect) c.aspect(c.colour, c.colour, 1) ; else c.aspect(fill_colour_carnivore, stroke_colour_carnivore, thickness_carnivore) ;
	    if(!info) c.costume_agent(which_costume) ; 
	    else c.info(c.colour, SIZE_TEXT_INFO) ;
	  }
	}
	 /**
	 set colour
	 */
	boolean original_carnivore_aspect = true ;
	 Vec4 fill_colour_carnivore, stroke_colour_carnivore ;
	 float thickness_carnivore ; 
	public void set_colour_carnivore(Vec4 fill_colour, Vec4 stroke_colour, float thickness) {
	  original_carnivore_aspect = false ;
	  if(fill_colour_carnivore == null) fill_colour_carnivore = Vec4(fill_colour) ; else fill_colour_carnivore.set(fill_colour) ;
	  if(stroke_colour_carnivore == null) stroke_colour_carnivore = Vec4(stroke_colour) ; else stroke_colour_carnivore.set(stroke_colour) ;
	  thickness_carnivore = thickness ;
	}

	/**
	local method eat
	*/
	public void eat_meat(Carnivore c, ArrayList<Agent> list_agent_target, boolean info) {
	  // first eat the agent who eat just before without look in the list
	  if(c.eating) {
	    int pointer = (int)c.ID_target.x ;
	    int ID_target = (int)c.ID_target.y ;
	    /* here we point directly in a specific point of the list, 
	    if the pointer is superior of the list, 
	    because if it's inferior a corpse can be eat by an other Agent */
	    if(pointer < list_agent_target.size() ) {
	      Agent target = list_agent_target.get((int)c.ID_target.x) ;
	      /* if the entry point of the list return an agent 
	      with a same ID than a ID_target corpse eat just before, 
	      the Carnivore can continue the lunch */
	      if (target.ID == ID_target ) c.eat(target, info) ; 
	      else {
	        /* If the ID returned is different, a corpse was leave from the list, 
	        and it's necessary to check in the full ist to find if any corpse have a seme ID */
	        for(Agent target_in_list : list_agent_target) {
	          if (target_in_list.ID == ID_target ) c.eat(target_in_list, info) ; else c.eating = false ;
	        }
	      }
	    }
	  /* If the last research don't find the corpse, may be this one is return to dust ! */
	  } else {
	    for(Agent target : list_agent_target) {
	      c.eat(target, info) ;
	      if(c.eating) {
	        c.ID_target.set(list_agent_target.indexOf(target),target.ID) ;
	        break ;
	      }
	    }
	  }
	}




	/**
	local method hunt
	*/

	public void hunt_dynamic_agent(Carnivore c, ArrayList<Herbivore> list_herbivore_target, boolean info) {
	  // first watch the agent who watch just before without look in the list
	  if(c.watching) find_target(c, list_herbivore_target, info) ;
	  if(c.tracking && c.max_time_track > c.time_track) focus_on_target(c, list_herbivore_target, info) ; else c.hunt_stop() ;
	}



	// Local method : The hunt is launching !
	public void focus_on_target(Carnivore c, ArrayList<Herbivore> list_herbivore_target, boolean info) {
	  int pointer = (int)c.ID_target.x ;
	  int ID_target = (int)c.ID_target.y ;
	  /* here we point directly in a specific point of the list, 
	  if the pointer is superior of the list, 
	  because if it's inferior a corpse can be watch by an other Agent */
	  if(pointer < list_herbivore_target.size() ) {
	    Herbivore target = list_herbivore_target.get((int)c.ID_target.x) ;
	    /* if the entry point of the list return an agent 
	    with a same ID than a ID_target agent watch just before, 
	    the Carnivore can continue the track */
	    if (target.ID == ID_target ) {
	      hunt_and_kill(c, target, info) ; 
	    } else {
	      /* If the ID returned is different, a target was leave from the list, 
	      and it's necessary to check in the full ist to find if any agent have a same ID */
	      for(Herbivore target_in_list : list_herbivore_target) {
	        if (target_in_list.ID == ID_target ) {
	          hunt_and_kill(c, target_in_list, info) ;
	        } else {
	          c.hunt_stop() ;
	        } 
	      }
	    }
	  } else c.hunt_stop() ;
	}
	// super local method
	public void hunt_and_kill(Carnivore c, Agent target, boolean info) {
	  if(c.dist_to_target(target, info) < c.radar) {
	    c.hunt(target, info) ; 
	    c.kill(target, info) ;
	  } else c.hunt_stop() ;
	}




	// Local method : Find target is the Big Carnivore Brother is watching you !
	public void find_target(Carnivore c, ArrayList<Herbivore> list_herbivore_target, boolean info) {
	  // float [] dist_list = new float[0] ;
	  ArrayList <Vec3> closest_target = new ArrayList<Vec3>() ;
	  // find the closest target 
	  for(Herbivore target : list_herbivore_target) {
	    if(c.dist_to_target(target, info) < c.radar) {
	      float dist = c.dist_to_target(target, info) ;
	      /*catch distance to compare with the last one
	      plus catch index in the list and the ID target
	      and add in the nice target list
	      */
	      Vec3 new_target = Vec3(dist, list_herbivore_target.indexOf(target), target.ID) ;
	      closest_target.add(new_target) ;
	      // compare the target to see which one is the closest.
	      if(closest_target.size() > 1) if (closest_target.get(1).x <= closest_target.get(0).x ) closest_target.remove(0) ; else closest_target.remove(1) ;
	    } 
	  }
	  // Start the hunt party with the selected target
	  if(closest_target.size() > 0 ) {
	    Herbivore target = list_herbivore_target.get((int)closest_target.get(0).y) ;
	    c.hunt(target, info) ;
	    c.kill(target, info) ;
	    if(c.tracking) c.ID_target.set(list_herbivore_target.indexOf(target),target.ID) ;
	  }
	}

	/**
	End carnivore update
	*/

























	/**
	Bacterium update 0.0.2
	*/
	public void bacterium(ArrayList<Bacterium> list_bacterium, ArrayList<Agent> list_dead_body, boolean info, int which_costume) {
	  // remove bacterium
	  for(Bacterium b : list_bacterium) {
	    if(b.size < 0 ) {
	      list_bacterium.remove(b) ;
	      break ;
	    }
	  }


	  // life of the agent
	  for(Bacterium b : list_bacterium) {
	    int radius = b.size ;
	    // motion
	    b.rebound(LIMIT, REBOUND) ;
	    b.motion() ;
	    b.set_position() ;
	    b.set_starving(2) ;

	    // hunt
	    if(!b.calm) hunt_static_agent(b, list_dead_body, info) ;
	    // eat
	    if(list_dead_body.size() >= 0 ) eat_corpse(b, list_dead_body, info) ; else b.eating = false ;
	    
	    // statement
	    b.statement() ;
	    b.hunger() ;

	    // display
	    if(original_bacterium_aspect) b.aspect(b.colour, b.colour, 1) ; else b.aspect(fill_colour_bacterium, stroke_colour_bacterium, thickness_bacterium) ;
	    if(!info) b.costume_agent(which_costume) ; 
	    else b.info(b.colour, SIZE_TEXT_INFO) ;
	  }
	}

	 /**
	set colour
	*/
	boolean original_bacterium_aspect = true ;
	 Vec4 fill_colour_bacterium, stroke_colour_bacterium ;
	 float thickness_bacterium ; 
	public void set_colour_bacterium(Vec4 fill_colour, Vec4 stroke_colour, float thickness) {
	  original_bacterium_aspect = false ;
	  if(fill_colour_bacterium == null) fill_colour_bacterium = Vec4(fill_colour) ; else fill_colour_bacterium.set(fill_colour) ;
	  if(stroke_colour_bacterium == null) stroke_colour_bacterium = Vec4(stroke_colour) ; else stroke_colour_bacterium.set(stroke_colour) ;
	  thickness_bacterium = thickness ;
	}


	// local method
	public void eat_corpse(Bacterium b, ArrayList<Agent> list_corpse_target, boolean info) {
	// first eat the agent who eat just before without look in the list
	  if(b.eating) {
	    int pointer = (int)b.ID_target.x ;
	    int ID_target = (int)b.ID_target.y ;
	    /* here we point directly in a specific point of the list, 
	    if the pointer is superior of the list, 
	    because if it's inferior a corpse can be eat by an other Agent */
	    if(pointer < list_corpse_target.size() ) {
	      Agent target = list_corpse_target.get((int)b.ID_target.x) ;
	      /* if the entry point of the list return an agent 
	      with a same ID than a ID_target corpse eat just before, 
	      the Carnivore can continue the lunch */
	      if (target.ID == ID_target ) b.eat(target, info) ; 
	      else {
	        /* If the ID returned is different, a corpse was leave from the list, 
	        and it's necessary to check in the full ist to find if any corpse have a seme ID */
	        for(Agent target_in_list : list_corpse_target) {
	          if (target_in_list.ID == ID_target ) b.eat(target_in_list, info) ; else b.eating = false ;
	        }
	      }
	    }
	  /* If the last research don't find the corpse, may be this one is return to dust ! */
	  } else {
	    for(Agent target : list_corpse_target) {
	      b.eat(target, info) ;
	      if(b.eating) {
	        b.ID_target.set(list_corpse_target.indexOf(target),target.ID) ;
	        break ;
	      }
	    }
	  }
	}


	public void hunt_static_agent(Bacterium b, ArrayList<Agent> list_target, boolean info) {
	  for(Agent target : list_target) {
	    b.watch(target, info) ;
	    b.pick(target) ;
	    if(b.picking()) break ;
	  }
	}
	/**
	End bacterium
	*/













	/**
	CORPSE || DEAD BODY update 0.0.2
	*/
	public void corpse(ArrayList<Agent> list_dead_body, boolean info, int which_costume) {
	  // the dead body is burried !
	  for(Agent corpse : list_dead_body) {
	    if(corpse.size < 0) {
	      list_dead_body.remove(corpse) ;
	      break ;
	    }
	  }
	  // Dead bobies is undead
	  for(Agent corpse : list_dead_body) {
	    Vec4 colour_of_death = Vec4(0,0,30,g.colorModeA); 

	    corpse.set_colour(colour_of_death) ;
	    corpse.carrion() ;

	    // display
	    if(original_corpse_aspect) corpse.aspect(corpse.colour, corpse.colour, 1) ; else corpse.aspect(fill_colour_corpse, stroke_colour_corpse, thickness_corpse) ;
	    if(!info) corpse.costume_agent(which_costume) ; 
	    else {
	      corpse.info_visual(corpse.colour) ;
	      corpse.info_text(corpse.colour, SIZE_TEXT_INFO) ;
	    }
	  }
	}
	 /**
	set colour
	*/
	boolean original_corpse_aspect = true ;
	 Vec4 fill_colour_corpse, stroke_colour_corpse ;
	 float thickness_corpse ; 
	public void set_colour_corpse(Vec4 fill_colour, Vec4 stroke_colour, float thickness) {
	  original_corpse_aspect = false ;
	  if(fill_colour_corpse == null) fill_colour_corpse = Vec4(fill_colour) ; else fill_colour_corpse.set(fill_colour) ;
	  if(stroke_colour_corpse == null) stroke_colour_corpse = Vec4(stroke_colour) ; else stroke_colour_corpse.set(stroke_colour) ;
	  thickness_corpse = thickness ;
	}
	/**
	END CORPSE || DEAD BODY update 0.0.2
	*/
	/**
	END UPDATE ECOSYSTEME 0.0.3
	*/







































	/**
	MANAGE ECOSYSTEM BUILT 0.0.5
	*/
	/**
	LIST
	*/
	ArrayList<Flora> FLORA_LIST = new ArrayList<Flora>() ;
	ArrayList<Bacterium> BACTERIUM_LIST = new ArrayList<Bacterium>() ;
	ArrayList<Herbivore> HERBIVORE_LIST = new ArrayList<Herbivore>() ;
	ArrayList<Carnivore> CARNIVORE_LIST = new ArrayList<Carnivore>() ;
	ArrayList<Agent> CORPSE_LIST = new ArrayList<Agent>() ;


	/**
	Clear ecosysteme
	*/
	public void clear_ecosystem() {
	  FLORA_LIST.clear() ;
	  BACTERIUM_LIST.clear() ;
	  HERBIVORE_LIST.clear() ;
	  CARNIVORE_LIST.clear() ;
	  CORPSE_LIST.clear() ;
	}


	/**
	ENVIRONMENT
	*/
	Vec3 BOX = Vec3(100,100,100) ;
	Vec3 BOX_POS = Vec3() ;
	Vec6 LIMIT = Vec6(0,BOX.x,0,BOX.y,0,BOX.z) ;
	boolean REBOUND ;
	int SIZE_TEXT_INFO ;
	float HUMUS, HUMUS_MAX ;
	int ENVIRONMENT = 3 ; // 2 is for 2D, 3 for 3D
	boolean DISPLAY_INFO = false ;
	/**
	* Create enviromnent where the ecosystem will be live
	*/
	public void build_environment(Vec2 pos, Vec2 size) {
	  Vec3 pos_3D = Vec3(pos.x, pos.y,0) ;
	  Vec3 size_3D = Vec3(size.x, size.y,0) ;
	  build_environment(pos_3D, size_3D) ;
	  // write here to be sure the Environment have a good info
	  ENVIRONMENT = 2 ; 
	}

	public void build_environment(Vec3 pos, Vec3 size) {
	  BOX_POS.set(pos) ;
	  BOX.set(size) ;

	  float left = BOX_POS.x - (BOX.x *.5f) ;
	  float right = BOX_POS.x + (BOX.x *.5f) ;
	  float top = BOX_POS.y - (BOX.y *.5f) ;
	  float bottom = BOX_POS.y + (BOX.y *.5f) ;
	  float front = BOX_POS.z - (BOX.z *.5f) ;
	  float back = BOX_POS.z + (BOX.z *.5f) ;
	  LIMIT.set(left,right, top, bottom, front, back) ;

	  REBOUND = false ;
	  SIZE_TEXT_INFO = 18 ;
	  HUMUS_MAX = HUMUS = BOX.x *BOX.y *.01f ;
	}








	/**
	FLORA
	*/
	/**
	* build the plant of the ecosystem
	*/
	public void build_flora(int size_template, Vec4 colour, int num) {
	  for(int i = 0 ; i < num ; i++) {
	    int size = PApplet.parseInt(random(ceil(size_template *.5f), ceil(size_template*3))) ;
	    String name = "salad" ;
	    if(ENVIRONMENT == 2 ) {
	      Vec2 pos = Vec2("RANDOM RANGE",(int)LIMIT.a, (int)LIMIT.b, (int)LIMIT.c, (int)LIMIT.d) ;
	      add_flora(pos, size, name, colour) ;
	    } else if (ENVIRONMENT == 3 ) {
	      Vec3 pos = Vec3("RANDOM RANGE",(int)LIMIT.a, (int)LIMIT.b, (int)LIMIT.c, (int)LIMIT.d, (int)LIMIT.e, (int)LIMIT.f) ;
	      add_flora(pos, size, name, colour) ;
	    }
	  }
	}

	public void add_flora(Vec2 pos, int size, String name, Vec4 colour) {
	   Vec3 final_pos =  Vec3(pos.x,pos.y,0) ;
	   add_flora(final_pos, size, name, colour) ;
	}
	public void add_flora(Vec3 pos, int size, String name, Vec4 colour) {
	   Flora f = new Flora(pos, size, name) ;
	   FLORA_LIST.add(f) ;
	   f.set_colour(colour) ;
	   f.set_growth(2) ;
	   f.set_need(.5f) ;
	}


	/**
	// AGENT
	*/
	/**
	// BACTERIUM
	*/
	public void build_bacterium(int size, int life, int velocity, float radar, Vec4 colour, int num) {
		for(int i = 0 ; i < num ; i++) {
			String name = "bacterium" ;
			if(ENVIRONMENT == 2 ) {
				Vec2 pos = Vec2("RANDOM RANGE",(int)LIMIT.a, (int)LIMIT.b, (int)LIMIT.c, (int)LIMIT.d) ;
				add_bacterium(pos, size, life, velocity, radar, name, colour) ;
			} else {
				Vec3 pos = Vec3("RANDOM RANGE",(int)LIMIT.a, (int)LIMIT.b, (int)LIMIT.c, (int)LIMIT.d, (int)LIMIT.e, (int)LIMIT.f) ;
				add_bacterium(pos, size, life, velocity, radar, name, colour) ;

			}
		}
	}

	public void add_bacterium(Vec2 pos, int size, int life, int velocity, float radar, String name, Vec4 colour) {
		Vec3 final_pos = Vec3(pos) ;
		add_bacterium(final_pos, size, life, velocity, radar, name, colour) ;
	}

	public void add_bacterium(Vec3 pos, int size, int life, int velocity, float radar, String name, Vec4 colour) {
	  Bacterium b = new Bacterium(pos, size, life, velocity, radar, name) ;
	  BACTERIUM_LIST.add(b) ;
	  b.set_colour(colour) ;
	}




	/**
	// HERBIVORE
	*/

	public void build_herbivore(int size, int life, int velocity, float radar, Vec4 colour, int num) {
		for(int i = 0 ; i < num ; i++) {
			String name = "human" ;
			if(ENVIRONMENT == 2 ) {
				Vec2 pos = Vec2("RANDOM RANGE",(int)LIMIT.a, (int)LIMIT.b, (int)LIMIT.c, (int)LIMIT.d) ;
				add_herbivore(pos, size, life, velocity, radar, name, colour) ;
			} else {
				Vec3 pos = Vec3("RANDOM RANGE",(int)LIMIT.a, (int)LIMIT.b, (int)LIMIT.c, (int)LIMIT.d, (int)LIMIT.e, (int)LIMIT.f) ;
				add_herbivore(pos, size, life, velocity, radar, name, colour) ;
			}
		}
	}

	public void add_herbivore(Vec2 pos, int size, int life, int velocity, float radar, String name, Vec4 colour) {
	   Vec3 final_pos = Vec3(pos) ;
	   add_herbivore(final_pos, size, life, velocity, radar, name, colour) ;
	}

	public void add_herbivore(Vec3 pos, int size, int life, int velocity, float radar, String name, Vec4 colour) {
	   Herbivore h = new Herbivore(pos, size, life, velocity, radar, name) ;
	   HERBIVORE_LIST.add(h) ;
	   h.set_meat_quality(4) ;
	   h.set_colour(colour) ;
	   h.set_gourmet(3.5f) ;
	}



	/**
	// CARNIVORE
	*/

	public void build_carnivore(int size, int life, int velocity, float radar, Vec4 colour, int num) {
		for(int i = 0 ; i < num ; i++) {
			String name = "ALIEN" ;
			if(ENVIRONMENT == 2 ) {
				Vec2 pos = Vec2("RANDOM RANGE",(int)LIMIT.a, (int)LIMIT.b, (int)LIMIT.c, (int)LIMIT.d) ;
				add_carnivore(pos, size, life, velocity, radar, name, colour) ;
			} else {
				Vec3 pos = Vec3("RANDOM RANGE",(int)LIMIT.a, (int)LIMIT.b, (int)LIMIT.c, (int)LIMIT.d, (int)LIMIT.e, (int)LIMIT.f) ;
				add_carnivore(pos, size, life, velocity, radar, name, colour) ;
			}
		}
	}

	public void add_carnivore(Vec2 pos, int size, int life, int velocity, float radar, String name, Vec4 colour) {
	   Vec3 final_pos = Vec3(pos) ;
	   add_carnivore(final_pos, size, life, velocity, radar, name, colour) ;
	}
	public void add_carnivore(Vec3 pos, int size, int life, int velocity, float radar, String name, Vec4 colour) {
	   Carnivore c = new Carnivore(pos, size, life, velocity, radar, name) ;
	   CARNIVORE_LIST.add(c) ;
	   c.set_colour(colour) ;
	   c.set_gourmet(2.5f) ;
	}
	/**
	END BUILT
	*/



































	/**
	CLASS AGENT

	*/
  /**
  CLASS AGENT 0.0.5
  */
  class Agent implements RULES_ECOSYSTEME {
    String name ;
    int ID = 0 ;
    Vec2 ID_target = Vec2(-1) ;

    boolean watching = true   ;
    boolean alive = true ;
    boolean carrion ;
    boolean calm ;
    boolean eating ;
    boolean tracking ;


    int age = 0 ;
    int life_expectancy = 1 ;
    int dead_since = 0 ;
    int life, life_max ;

    Vec3 pos, motion, direction ;
    Vec3 velocity_xyz ;
    Vec4 colour = Vec4(0,0,0,g.colorModeA) ;
    int velocity, velocity_ref ;

    int size, size_ref ;

    int meat_quality ;

    int radar ;
    int speed_eating = 1 ;
    int eat_zone ;
    int greed = PApplet.parseInt(180 *CLOCK) ; // num of frame before stop to eat :)
    float gourmet = 2.f ;
    int digestion = 2 ;
    
    // watching variable
    int size_target ;
    int time_watching = 0 ;
    int max_watching = 600 ;


    int step_hunger ;
    int hunger  ;
    int starving = 1 ;

    Agent(Vec3 pos, int size, int life, int velocity, String name) {
      this.name = name ;
      this.ID = PApplet.parseInt(random(1000000)) ;
      this.colour.set(colour) ;

      this.size = this.size_ref = size ;
      this.life_max = this.life = life ;

      this.pos = pos ;
      this.velocity = this.velocity_ref = velocity ;
      motion = Vec3(pos) ; ;
      direction = Vec3("RANDOM",1) ;
      velocity_xyz = Vec3() ;

      // statement
      step_hunger = (size + life)/2 *((life_expectancy -age)/life_expectancy) ;
      hunger = 0 ;
      meat_quality = 1 ;
    }



    /**
    //SET AGENT
    */
    public void set_agent(int step_hunger, int hunger, int meat_quality, int speed_eating) {
      set_meat_quality(meat_quality) ;
      set_step_hunger(step_hunger) ;
      set_hunger(hunger) ;
      set_speed_eating(speed_eating) ;
    }
    

    public void set_greed(int greed) {
      this.greed = PApplet.parseInt(greed *CLOCK) ;
    }

    public void set_starving(int starving) {
      this.starving = starving ;
    }

    public void set_gourmet(float gourmet) {
      this.gourmet = abs(gourmet) +1.1f ;
    }

    public void set_meat_quality(int meat_quality) {
      this.meat_quality = meat_quality ;
    }

    public void set_step_hunger(float step_hunger) {
      this.step_hunger = PApplet.parseInt(size *step_hunger) ;
    }

    public void set_hunger(int hunger) {
      this.hunger = hunger ;
    }

    public void set_speed_eating(int speed_eating) {
      this.speed_eating = 1 ;
    }

    public void set_colour(Vec4 colour) {
      this.colour.set(colour) ;
    }

    public void set_alive(boolean alive) {
      this.alive = alive ;
    }

    public void set_watching(int  max_watching) {
      this.max_watching = max_watching ;
    }

    public void set_digestion(int digestion) {
      if(digestion <= 0) {
        println("Please use a positive value !") ;
        this.digestion = 1 ;
      } else {
        this.digestion = digestion ;
      }
    }




    
    /**
    // MOTION
    */
    public void rebound(Vec6 l, boolean rebound_on_limit) {
      if(ENVIRONMENT == 2 ) rebound(l.a, l.b, l.c, l.d, 0, 0, rebound_on_limit) ;
      else if(ENVIRONMENT == 3) rebound(l.a, l.b, l.c, l.d, l.e, l.f,  rebound_on_limit) ;
    }
    
    public void rebound(float left, float right, float top, float bottom, float front, float back, boolean rebound_on_limit) {
      Vec3 pos_temp = Vec3(pos.x, pos.y,pos.z);
      Vec3 dir_temp = Vec3(direction.x, direction.y,direction.z);
      
      if(rebound_on_limit) {
        dir_temp.set(rebound(left, right, top, bottom, front, back, pos_temp, dir_temp)) ;
        direction.set(dir_temp) ;
      } else {
        Vec3 motion_temp = Vec3(motion.x, motion.y,motion.z) ;
        motion_temp.set(jump(left, right, top, bottom, front, back, motion_temp)) ;
        motion.set(motion_temp) ;
      }
    }


    // local method
    public Vec3 rebound(float left, float right, float top, float bottom, float front, float back, Vec3 pos, Vec3 dir) {
      // here we use size to have a physical rebound
      int effect = size ;
      left -=effect ;
      right +=effect ;
      top -=effect ;
      bottom +=effect ;
      front -=effect;
      back +=effect;

      // detection x
      if(pos.x > right ) dir.x *= -1 ;
      else if (pos.x < left ) dir.x *= -1 ;
      // detection y
      if(pos.y > bottom) dir.y *= -1 ;
      else if (pos.y < top ) dir.y *= -1 ;
      // detection z
      if(pos.z > front) dir.z *= -1 ;
      else if (pos.z < back ) dir.z *= -1 ;
      return Vec3(dir) ;
    }


    public Vec3 jump(float left, float right, float top, float bottom, float front, float back, Vec3 motion) {
      // here we use radar to find a good jump
      int effect = radar ;
      left -=effect ;
      right +=effect ;
      top -=effect ;
      bottom +=effect ;
      front -=effect;
      back +=effect;

      if(motion.x > right ) motion.x = left ;
      else if (motion.x < left ) motion.x = right ;
      // detection y
      if(motion.y > bottom) motion.y = top ;
      else if (motion.y < top ) motion.y = bottom  ;
      // detection z
      if(motion.z > back) motion.z = front ;
      else if (motion.z < front ) motion.z = back ;
      return Vec3(motion) ;
    }



    public void motion() {
      velocity_xyz.set(velocity) ;
      velocity_xyz.mult(direction) ;
      motion.add(velocity_xyz) ;
    }
    
    public void set_position() {
      if(ENVIRONMENT == 2 ) pos.set(motion.x, motion.y, 0) ; else if(ENVIRONMENT == 3 ) pos.set(motion.x, motion.y, motion.z) ;
    }








    /**
    // STATEMENT
    */
    public void statement() {
      time_to_eat() ;
      if(calm) velocity = 0 ; else velocity = velocity_ref ;

      // corpse
      if(life <= 0) {
        alive = false ;
        life = 0 ;
      }
      if(!alive) direction.set(Vec3(0)) ;

      // health
      if(life > life_max) {
        life = life_max ;
      }

      
    }

    // local method
    int start_eating ;
    public void time_to_eat() {
      if(hunger < step_hunger) {
        calm = false ;
        start_eating = frameCount ; 
      } else {
        int time_to_stop_eating = start_eating +greed ;
        if (time_to_stop_eating > frameCount) calm = true ; 
      }

    }
    

    public void carrion() {
      int threshold = 2 ;
      if(!alive) {
        dead_since += PApplet.parseInt(1.f *CLOCK) ;
        if(size < size_ref / threshold || dead_since > (TIME_TO_BE_CARRION *frameRate)) carrion = true ; 
        else carrion = false ;
      } 
    }



    public void hunger() {
      if(frameCount%(1 +PApplet.parseInt(frameRate *CLOCK)) == 0) {
        hunger -= starving ;
        if(hunger <= 0) life -= starving ;
      }
    }














    /**
    // ASPECT
    */
    public void aspect(float thickness) {
      if(thickness <= 0) { 
        noStroke() ;
        fill(colour.r,colour.g,colour.b,colour.a) ;
      } else { 
        strokeWeight(thickness) ;
        stroke(colour) ;
        fill(colour) ;
      }
    }
    public void aspect(Vec4 c_fill, Vec4 c_stroke, float thickness) {
      if(thickness <= 0) { 
        noStroke() ;
        fill(c_fill) ;
      } else { 
        strokeWeight(thickness) ;
        stroke(c_stroke) ;
        fill(c_fill) ;
      }
    }
   
    /**
    // costume
    */
    public void costume_agent(int ID_costume) {
      costume(pos, size, ID_costume) ;
    }
    
    



    /**
    // void info
    */
    public void info_visual(Vec4 colour) {
      Vec3 pos_temp = Vec3(0) ;
      aspect(Vec4(0), colour, 1) ;
      matrix_start() ;
      translate(pos) ;
      ellipse(pos_temp.x, pos_temp.y, size *2, size *2) ;
      matrix_end() ;
    }

    public void info_text(Vec4 colour, int size_text) {
      aspect(colour, colour, 1) ;
      Vec2 pos_text = Vec2(0) ;
      matrix_start() ;
      translate(pos) ;
      textSize(size_text) ;
      textAlign(CENTER) ;
      text(name, pos_text.x, pos_text.y) ;
      text(life + " " + size + " " + size_ref, pos_text.x, pos_text.y +(size_text *1.2f) ) ;
      textSize(16) ;
      if(alive) {
        if (eating) {
          text("I'm eating", pos_text.x, pos_text.y +(size_text *2.4f) ) ;
        } else {
          if(calm) text("I'm cool", pos_text.x, pos_text.y +(size_text *2.4f) ) ; 
          if(!calm) text("I'm hungry", pos_text.x, pos_text.y +(size_text *2.4f) ) ;
        }
      } else {
        if(!carrion) text("I'm dead", pos_text.x, pos_text.y +(size_text *2.4f) ) ; else text("I'm carrion", pos_text.x, pos_text.y +(size_text *2.4f) ) ;
      }
      matrix_end() ;
    }

    public void info_print_agent() {
      // basic Agent info
      println(this.name + " " +this.getClass().getSimpleName()) ;
      info_print_agent_structure() ;
      info_print_agent_motion() ;
      info_print_agent_statement() ;
    }
    public void info_print_agent_structure() {
      println("CARACTERISTIC",this.name) ;
      println(this.name, "size", this.size) ;
      println(this.name, "life", this.life) ;
      println(this.name, "meat quality", this.meat_quality) ;
      println(this.name, "Food exigency", this.gourmet) ;

    }

    public void info_print_agent_motion() {
      println("MOTION",this.name) ;
      println(this.name, "velocity", this.velocity_ref) ;
      println(this.name, "current velocity", this.velocity) ;
      println(this.name, "position", this.pos) ;
      println(this.name, "direction", this.direction) ;
      println(this.name, "motion", this.motion) ;
    }


    public void info_print_agent_statement() {
      println("STATEMENT",this.name) ;
      println(this.name, "alive", this.alive) ;
      println(this.name, "carrion", this.carrion) ;
      println(this.name, "calm", this.calm) ;
      println(this.name, "eating", this.eating) ;
      println(this.name, "hunger", this.hunger) ;
      println(this.name, "watching", this.watching) ;
      println(this.name, "tracking", this.tracking) ;

    }
  }
  /**
  END AGENT
  */
























	/**
	CLASS CHILDREN AGENT

	*/
	/**
	SUB CLASS BACTERIUM 0.0.2
	*/
	class Bacterium extends Agent {
	  float humus_prod = .25f ;
	  // boolean eating   ;
	  Bacterium(Vec3 pos, int size, int life, int velocity, float radar, String name) {
	    super(pos, size, life, velocity, name) ;
	    this.radar = PApplet.parseInt(size *radar) ;
	    eat_zone = PApplet.parseInt(size *2) + size ;
	  }

	  public void set_humus_prod(float prod) {
	    this.humus_prod = prod ;
	  }



	  public void watch(Agent a, boolean info) {
	    // Vec3 pos_target = a.pos.copy() ;
	    if(dist(a.pos,pos) < radar && !a.alive ) {
	      if(info) {
	        stroke(colour) ;
	        strokeWeight(1) ;
	        line(a.pos, pos) ;
	      }
	      watching = false ; 
	    } else watching = true ;
	  }




	   // Method
	  public void eat(Agent a, boolean info) {
	    if(dist(a.pos,pos) < eat_zone ) {
	      if(info) line(a.pos, pos) ;
	      float calories = speed_eating *humus_prod ;
	      a.size -= speed_eating ;
	      hunger += (calories *digestion) ;
	      HUMUS += (calories *humus_prod) ;
	      life += (calories *.75f) ;
	      eating = true ;
	    } else eating = false ;
	  }


	  public void pick(Agent a) {
	    if (!watching) direction.set(target_direction(a.pos,pos)) ; 
	  }

	  public boolean picking() {
	    if (watching) return false ; else return true ;
	  }

	  // info
	  public void info(Vec4 colour, int size_text) {
	    info_visual_bacterium(colour) ;
	    info_text(colour, size_text) ;
	  }

	  public void info_visual_bacterium(Vec4 colour) {
	    aspect(Vec4(), colour, 1) ;
	    Vec3 pos_temp = Vec3 (0) ;
	    matrix_start() ;
	    translate(pos) ;
	    ellipse(pos_temp.x, pos_temp.y, radar*2, radar*2) ;
	    ellipse(pos_temp.x, pos_temp.y, eat_zone *2, eat_zone *2) ;
	    ellipse(pos_temp.x, pos_temp.y, size *2, size *2) ;
	    matrix_end() ;
	  }


	  // print
	  public void info_print_bacterium() {
	    println("INFO",this.name) ;
	    println("No particular info for the moment") ;
	  }
	}
	/**
	END SUB CLASS BACTERIUM
	*/





























  /**
  SUB CLASS CARNIVORE 0.0.2
  */
  class Carnivore extends Agent {
    boolean killing   ;
    int attack = 1 ;
    int kill_zone ;
    int time_track ;
    int max_time_track = PApplet.parseInt(360 *CLOCK) ;

    Carnivore(Vec3 pos, int size, int life, int velocity, float radar, String name) {
      super(pos, size, life, velocity, name) ;
      this.radar = PApplet.parseInt(size *radar) ;
      kill_zone = PApplet.parseInt(size *2) +size ;
      eat_zone = PApplet.parseInt(size *1.2f) ;
    }


    public void set_kill_zone(int radius) {
      this.kill_zone = radius ;
    }

    public void set_attack(int attack) {
      this.attack = attack ;
    }

    public void set_max_time_track(int max) {
      this.max_time_track = PApplet.parseInt(max *frameRate *CLOCK) ;
    }






    // hunt
    public void hunt(Agent a, boolean info) {
      if(a.alive) {
        hunt_in_progress() ;
        follow(a, info) ;
      } else {
        hunt_stop() ;
      } 
    }

    public void kill(Agent a, boolean info) {
      if(dist(a.pos,pos) < kill_zone && a.alive ) {
        if(info) {
          stroke(colour) ;
          strokeWeight(1) ;
          line(a.pos, pos) ;
        }
        a.life -= 1 *attack ;
        // a.size -= 1 ;
      }
    }

    public void follow(Agent a, boolean info) {
      if(info) {
        stroke(colour) ;
        strokeWeight(1) ;
        line(a.pos, pos) ;
      }
      direction.set(target_direction(a.pos, pos)) ;
    }

    public float dist_to_target(Agent a, boolean info) {
      float dist = dist(a.pos,pos) ;
      if(dist < radar) {
        if(info) {
          stroke(colour) ;
          strokeWeight(1) ;
          line(a.pos, pos) ;
        }
      }
      return dist ;
    }

    public void hunt_in_progress() {
      time_track += 1 ;
      tracking = true ; 
      watching = false ;
    }

    public void hunt_stop() {
      time_track = 0 ;
      tracking = false ; 
      watching = true ;
    }







    // heat
    public void eat(Agent a, boolean info) {
      if(dist(a.pos,pos) < eat_zone && !a.alive && threshold_quality_meat(a, gourmet)) {
        if(info) {
          stroke(colour) ;
          strokeWeight(1) ;
          line(a.pos, pos) ;
        }
        float calories = a.meat_quality *speed_eating ;
        a.size -= speed_eating ;
        hunger += (calories *digestion) ;
        life += calories ;
        eating = true ;
      } else eating = false ;
    }



    public boolean threshold_quality_meat(Agent a, float step) {
      if(a.size > a.size_ref / step ) return true ; else return false ;
    }

    

    


    
    // info
    public void info(Vec4 colour, int text_size) {
      info_visual_carnivore(colour) ;
      info_text(colour, SIZE_TEXT_INFO) ;
    }

    public void info_visual_carnivore(Vec4 colour) {
      Vec3 pos_temp = Vec3(0) ;
      aspect(Vec4(), colour, 1) ;
      matrix_start() ;
      translate(pos) ;
      ellipse(pos_temp.x, pos_temp.y, radar*2, radar*2) ;
      ellipse(pos_temp.x, pos_temp.y, kill_zone *2, kill_zone *2) ;
      ellipse(pos_temp.x, pos_temp.y, eat_zone *2, eat_zone *2) ;
      ellipse(pos_temp.x, pos_temp.y, size *2, size *2) ;
      matrix_end() ;
    }

    // print
    public void info_print_carnivore() {
      println("INFO",this.name) ;
      println("time track", PApplet.parseInt((float)time_track / frameRate));
    }
  }
  /**
  END SUB CLASS CARNIVORE 0.0.2
*/























  /**
  SUB CLASS HERBIVORE 0.0.2
  */
  class Herbivore extends Agent {
    // boolean eating   ;
    Herbivore(Vec3 pos, int size, int life, int velocity, float radar, String name) {
      super(pos, size, life, velocity, name) ;
      this.radar = PApplet.parseInt(size *radar) ;
      eat_zone = PApplet.parseInt(size *1.2f) ;
    }


    // watch
    public void watch(Flora f, boolean info) {
      if(time_watching < max_watching) {
        if(dist(f.pos,pos) < radar && threshold_quality_food(f, gourmet) && f.size >= size_target) {
          if(info) {
            stroke(colour) ;
            strokeWeight(1) ;
            line(f.pos, pos) ;
          }
          size_target = f.size ;
          time_watching ++ ;
          watching = false ; 
        } else {
          watching = true ;
        } 
      } else {
        time_watching = 0 ;
        size_target = 0 ;
      }
    }


    // eat
    public void eat(Flora f, boolean info) {
      if(dist(f.pos,pos) < eat_zone && threshold_quality_food(f, gourmet) ) {
        if(info) line(f.pos, pos) ;
        float calories = f.nutrient_quality *speed_eating ;
        f.life -= speed_eating ;
        f.size -= speed_eating ;
        hunger += (calories *digestion) ;
        life += calories ;
        eating = true ;
        //calm = true ;
        size_target = 0 ;
      } else {
        eating = false ;
      }
    }
    // local method
    public boolean threshold_quality_food(Flora f, float step) {
      if(f.size > f.size_ref / step ) return true ; else return false ;
    }


    // pick
    public void pick(Flora f) {
      if (!watching) {
        Vec3 pos_target = f.pos.copy() ;
        direction.set(target_direction(pos_target, pos)) ; 
      }
    }

    public boolean picking() {
      if (watching) return false ; else return true ;
    }


    // info
    public void info(Vec4 colour, int size_text) {
      info_visual_herbivore(colour) ;
      info_text(colour, size_text) ;
    }

    public void info_visual_herbivore(Vec4 colour) {
      aspect(Vec4(),colour, 1) ;
      Vec3 pos_temp = Vec3(0) ;
      matrix_start() ;
      translate(pos) ;
      ellipse(pos_temp.x, pos_temp.y, radar*2, radar*2) ;
      ellipse(pos_temp.x, pos_temp.y, eat_zone *2, eat_zone *2) ;
      ellipse(pos_temp.x, pos_temp.y, size *2, size *2) ;
      matrix_end() ;
    }
    
    // print
    public void info_print_herbivore() {
      println("INFO",this.name) ;
      println("No particular info for the moment") ;
    }
  }
  /**
  SUB CLASS HERBIVORE 0.0.2
  */



















  /**
  Flora 0.0.4
  */
  class Flora implements RULES_ECOSYSTEME {
    String name ;
    int ID = 0 ;

    Vec3 pos ;
    int size, size_ref, size_max ;
    int speed_growth = 1 ;
    int life, life_max ;

    Vec4 colour = new Vec4(0,0,0,g.colorModeA) ;

    int nutrient_quality ;
    float need = 1.f ;
    /**
    Constructor
    */
    Flora(Vec3 pos, int size, String name) {
      this.name = name ;
      this.ID = PApplet.parseInt(random(1000000)) ;

      this.size = this.size_ref = this.size_max  = size ;
      this.life = this.life_max = size ;
      this.colour.set(colour);

      this.pos = pos ;

      this.nutrient_quality = 1 ;
    }
    /**
    Set Flora
    */
    public void set_Flora_quality(int nutrient_quality) {
       this.nutrient_quality =  nutrient_quality ;
    }
    public void set_colour(Vec4 colour) {
      this.colour.set(colour) ;
    }

    public void set_growth(int speed) {
      this.speed_growth = speed ;
    }

    public void set_need(float need) {
      this.need = need ;
    }



   public void statement() {
     if(size > size_max) size = size_max ;
     if(life > life_max) life = life_max ;
   }
    

    public void growth() {
      if(frameCount%(180 *CLOCK) == 0 ) {
        this.size += speed_growth ;
        this.life += speed_growth ;
        HUMUS -= need ;
      } 
    }


    /**
    Aspect
    */
    public void aspect(float thickness) {
      if(thickness <= 0) { 
        noStroke() ;
        fill(colour.r,colour.g,colour.b,colour.a) ;
      } else { 
        strokeWeight(thickness) ;
        stroke(colour) ;
        fill(colour) ;
      }
    }
    
    public void aspect(Vec4 c_fill, Vec4 c_stroke, float thickness) {
      if(thickness <= 0) { 
        noStroke() ;
        fill(c_fill) ;
      } else { 
        strokeWeight(thickness) ;
        stroke(c_stroke) ;
        fill(c_fill) ;
      }
    }
    /**
    // costume
    */
    public void costume_agent(int ID_costume) {
      costume(pos, size, ID_costume) ;
    }
    
    /**
    // info
    */
    public void info_visual_text(Vec4 colour, int size_text) {
      aspect(colour,colour, 1) ;
      textSize(size_text) ;
      textAlign(CENTER) ;
      
      Vec2 pos_text = Vec2(0) ;

      matrix_start() ;
      translate(pos) ;
      text(name, pos_text.x, pos_text.y) ;
      text(life, pos_text.x, pos_text.y +(size_text *1.2f) ) ;
      matrix_end() ;
    }

      // print
    public void info_print_flora() {
      println("INFO",this.name) ;
      println("No particular info for the moment") ;
    }
  }
  /**
  END Flora 0.0.4
  */

















  /**
  INFO 0.0.2
  */

  public void print_info_environment() {
    println("ENVIRONMENT") ;
    println("Humus", HUMUS) ;
  }


  public void print_info_herbivore(ArrayList<Herbivore> list_h) {
    for(Herbivore h : list_h) {
          // h.info_print_agent_() ;
      // h.info_print_agent_motion() ;
      //h.info_print_agent_structure() ;
      h.info_print_agent_statement() ;
      h.info_print_herbivore() ;
    }
  }

  public void print_info_bacterium(ArrayList<Bacterium> list_b) {
    for(Bacterium b : list_b) {
          // b.info_print_agent_() ;
      // b.info_print_agent_motion() ;
      b.info_print_agent_structure() ;
      b.info_print_agent_statement() ;
      b.info_print_bacterium() ;
    }
  }

  public void print_info_carnivore(ArrayList<Carnivore> list_c) {
    for(Carnivore c : list_c) {
      // c.info_print_agent() ;
      // c.info_print_agent_motion() ;
      c.info_print_agent_structure() ;
      c.info_print_agent_statement() ;
      c.info_print_carnivore() ;
    }
  }


  public void print_list(){
    println("Flora", FLORA_LIST.size()) ;
    println("Bacterium",BACTERIUM_LIST.size()) ;
    println("Herbivore",HERBIVORE_LIST.size()) ;
    println("Carnivore",CARNIVORE_LIST.size()) ;
    println("Corpse",CORPSE_LIST.size()) ;
  }
  /**
	END INFO
  */
}
/**
BACKGROUND 1.1.1
Romanesco Processing Environment
*/
float MAX_RATIO_DEPTH = 6.9f ;

/*
Normalize background
*/

public void background_norm_P3D(Vec4 bg) {
  background_norm_P3D(bg.x, bg.y, bg.z, bg.a) ;
}

public void background_norm_P3D(Vec3 bg) {
  background_norm_P3D(bg.x, bg.y, bg.z, 1) ;
}

public void background_norm_P3D(float c, float a) {
  background_norm_P3D(c, c, c, a) ;
}

public void background_norm_P3D(float c) {
  background_norm_P3D(c, c, c, 1) ;
}

public void background_norm_P3D(float r,float g, float b) {
  background_norm_P3D(r, g, b, 1) ;
}

// Main method
public void background_norm_P3D(float r_c, float g_c, float b_c, float a_c) {
  float x = map(r_c,0,1, 0, g.colorModeX) ;
  float y = map(g_c,0,1, 0, g.colorModeY) ;
  float z = map(b_c,0,1, 0, g.colorModeZ) ;
  float a = map(a_c,0,1, 0, g.colorModeA) ;
  noStroke() ;
  fill(x, y, z, a) ;
  int canvas_x = width *100 ;
  int canvas_y = height *100 ;
  int pos_x = - canvas_x /2 ;
  int pos_y = - canvas_y /2 ;
  // this problem of depth is not clarify, is must refactoring
  int pos_z = PApplet.parseInt( -height *MAX_RATIO_DEPTH) ;
  pushMatrix() ;
  translate(0,0,pos_z) ;
  rect(pos_x,pos_y,canvas_x, canvas_y) ;
  popMatrix() ;
}





/**
ROMANESCO BACKGROUND 0.4.1

*/
Vec4  colorBackground, colorBackgroundRef, colorBackgroundPrescene;


public void background_setup() {
  colorBackgroundRef = Vec4() ;
  colorBackground = Vec4() ;
  colorBackgroundPrescene = Vec4(0,0,20,g.colorModeA) ;
}


public void background_romanesco() {
  // in preview mode the background is always on, to remove the trace effect
  if(!FULL_RENDERING) { 
    onOffBackground = false ;
    colorBackground = colorBackgroundPrescene.copy() ;
    background_norm_P3D(colorBackground.normalize(Vec4(g.colorModeX,g.colorModeY,g.colorModeZ,g.colorModeA ))) ;
  } else {
    if(onOffBackground) {
      if(whichShader == 0) {
        // check if the color model is changed after the shader used
        if(g.colorModeX != 360 || g.colorModeY != 100 || g.colorModeZ !=100 || g.colorModeA !=100) colorMode(HSB,360,100,100,100) ;
        // choice the rendering color palette for the classic background
        if(FULL_RENDERING) {
          // check if the slider background are move, if it's true update the color background
          if(!compare(colorBackgroundRef,update_background())) colorBackground.set(update_background()) ;
          else colorBackgroundRef.set(update_background()) ;
          background_norm_P3D(colorBackground.normalize(Vec4(g.colorModeX,g.colorModeY,g.colorModeZ,g.colorModeA ))) ;
        } 
        background_norm_P3D(colorBackground.normalize(Vec4(g.colorModeX,g.colorModeY,g.colorModeZ,g.colorModeA ))) ;
      } else {
        background_shader_draw(whichShader) ;
      }
    }
  }
}






// ANNEXE VOID BACKGROUND
/////////////////////////
public Vec4 update_background() {
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







// BACKGROUND SHADER
PShader blurOne, blurTwo, cellular, damierEllipse, heart, necklace,  psy, sinLight, snow ;
//PShader bizarre, water, psyTwo, psyThree ;

public void background_shader_setup() {
  String pathShaderBG = preference_path +"shader/shader_bg/" ;

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



public void background_shader_draw(int whichOne) {
  if(TEST_ROMANESCO || FULL_RENDERING) {
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
    background_norm_P3D(Vec4(1)) ;
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
  
  

  Vec4 RGBbackground = HSBa_to_RGBa( map(valueSlider[0][0],0,MAX_VALUE_SLIDER,0,g.colorModeX), 
                                map(valueSlider[0][1],0,MAX_VALUE_SLIDER,0,g.colorModeY), 
                                map(valueSlider[0][2],0,MAX_VALUE_SLIDER,0,g.colorModeZ),
                                map(valueSlider[0][3],0,MAX_VALUE_SLIDER,0,g.colorModeA)  ) ;
  float redNorm = map(RGBbackground.x,0,255,0,1) ;
  float greenNorm = map(RGBbackground.y,0,255,0,1) ;
  float blueNorm = map(RGBbackground.z,0,255,0,1) ;
  float alphaNorm = map(RGBbackground.w,0,255,0,1) ;
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
/**
Camera Engine version 6.0.2
*/
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

public PVector updatePosCamera(boolean authorization, boolean leapMotionDetected, Vec3 posDevice) {
  if(authorization) {
    //create the ref to calcul the new position of the Scene
    if(newRefSceneMouse) {
      posSceneCameraRef.set(sceneCamera) ;
      posSceneMouseRef.set(new PVector(posDevice.x,posDevice.y,posDevice.z)) ;
      //to create a only one ref position
      newRefSceneMouse = false ;
    }

    //create the delta between the ref and the mouse position
    deltaScenePos = PVector.sub(new PVector(posDevice.x,posDevice.y,posDevice.z), posSceneMouseRef) ;
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
public PVector updateEyeCamera(boolean authorization, PVector pos) {
  if(authorization) {
    //create the ref to calcul the new position of the Scene
    if(newRefEyeMouse) {
      posEyeCameraRef.set(tempEyeCamera) ;
      posEyeMouseRef.set(pos) ;
    }
    //to create a only one ref position
    newRefEyeMouse = false ;
    
    //create the delta between the ref and the mouse position
    deltaEyePos = PVector.sub(pos, posEyeMouseRef) ;
    tempEyeCamera = PVector.add(deltaEyePos, posEyeCameraRef ) ;

    //rotation of the camera
    // return eyeClassic(tempEyeCamera) ;
    return eyeClassic(tempEyeCamera) ;
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
/**
Camera display 1.0.5
*/
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
public void P3D_setup(int numObj, int numSettingCamera, int numSettingItem) {
    settingAllCameras (numSettingCamera) ;
    settingObjManipulation (numObj) ;
    settingObjectManipulation(numObj, numSettingItem) ;
    initVariableCamera() ;
    println("P3D setup done") ;
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

public void settingObjectManipulation (int numObj, int numSetting) {
  // object orientation
  for ( int i = 0 ; i < numSetting ; i++ ) {
    for (int j = 0 ; j < numObj ; j++ ) {
       item_setting_position [i][j] = Vec3() ;
       item_setting_direction [i][j] = Vec2() ;
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
    posObjX[ID] = item_setting_position [0][ID].x ;
    posObjY[ID] = item_setting_position [0][ID].y ;
    posObjZ[ID] = item_setting_position [0][ID].z ;

    dirObjX[ID] = item_setting_direction [0][ID].x ;
    dirObjY[ID] = item_setting_direction [0][ID].y ;

    P3DdirectionMouseRef.set(0,0,0) ;
    tempObjDir.set(0,0,0) ;
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
      if(dirObjRef == null) dirObjRef =tempObjDir.copy() ; else dirObjRef.set(tempObjDir) ;
      P3DdirectionMouseRef.set(new PVector(mouse[0].x,mouse[0].y,mouse[0].z)) ;
    }
    //to create a only one ref position
    newObjRefDir = false ;
    //create the delta between the ref and the mouse position
    deltaObjDir = PVector.sub(new PVector(mouse[0].x,mouse[0].y,mouse[0].z), P3DdirectionMouseRef) ;
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
    posObjRef[ID].set(pos.x, pos.y, pos.z) ;
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
  float magCam =  height/2 ;
  Vec3 posCamCorrection = new Vec3( sceneCamera.x, sceneCamera.y, sceneCamera.z + magCam) ;

  
  // polar info for the obj and the camera
  Vec3 polarObj = toPolar(deltaObjPos) ;
  float norm360longitude = map_cycle(eyeCamera.x,0,360) ;
  float norm360latitude = map_cycle(eyeCamera.y ,0,360) ;
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
  
  // *************************************
  ///////////////////////////////////
  // TRY THIS SOLUTION, same than sceneCamera ???????
  
  // if(!moveScene) sceneCamera = (follow(origin, target, speed)) ;

  
  // END WORK around the camera
  ////////////////////////////
  */

  PVector delta = deltaObjPos.copy_PVector() ;
  // final position
  pos = PVector.add(new PVector(posObjRef[ID].x,posObjRef[ID].y,posObjRef[ID].z), delta) ;
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
  posObj[ID] = new PVector (posObjX[ID], posObjY[ID],posObjZ[ID]) ;
  dirObj[ID] = new PVector (dirObjX[ID], dirObjY[ID]);
}



//starting position
public void startPosition(int ID, int x, int y, int z) {
  // tartingPosition[ID] = Vec3(x,y,z) ;
  posObjX[ID] = x -(width/2) ;
  posObjY[ID] = y -(height/2) ;
  posObjZ[ID] = z ;
  
  item_setting_position [0][ID] = Vec3(posObjX[ID], posObjY[ID], posObjZ[ID] ) ;
  item_setting_direction [0][ID] = Vec2(dirObjX[ID], dirObjY[ID]) ;
  mouse[ID] = Vec3(x,y,z) ;
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


















/**
// Annexe method of the method cameraDraw()
///////////////////////////////////////////
*/
public void setVariableCamera(boolean authorization) {
  // float focal = map(valueSlider[0][19],0,360,28,200) ;

  /* this method need to be on the Prescene sketch and on the window.
  1. boolean prescene : On prescene, because on Scene we don't need to have a global view : boolean prescene
  2. boolean MOUSE_IN_OUT : because if we mode out the sketch the keyevent is not updated, and the camera stay in camera view */
  if(FULL_RENDERING || (cLongTouch && (MOUSE_IN_OUT || clickLongLeft[0] || clickLongRight[0]) && prescene)) variableCameraFullrendering(authorization) ; else variableCameraPresceneRendering() ;
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
    eyeCamera.set(updateEyeCamera(eye, new PVector(mouse[0].x,mouse[0].y,mouse[0].z))) ;
  }
}


// move camera to target
public void moveCamera(PVector origin, PVector target, float speed) {
  if(!moveScene) sceneCamera = follow(origin, target, speed) ;
  if(!moveEye && (gotoCameraPosition || gotoCameraEye)) eyeCamera = backEye()  ;
}


// CHANGE CAMERA POSITION
public void changeCameraPosition(int ID) {
  eyeCamera.set(eyeCameraSetting[ID]) ;
  sceneCamera.set(sceneCameraSetting[ID]) ;
  updateEyeCamera(true, new PVector()) ;
  tempEyeCamera.set(0,0,0) ;
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



























/**
// PERSPECTIVE
//////////////
*/
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











/**
// GRID CAMERA WORLD
/////////////////////
*/
//repere camera
public void createGridCamera(boolean showGrid) {
  if(showGrid)  {
    float thickness = .1f ;


    // Very weird it's necessary to pass by PVector, if we don't do that when we use camera the grid disappear
    PVector size =  PVector.mult(sizeBackgroundP3D,.2f) ;
    Vec3 size_grid = Vec3(size) ;
    size_grid.mult(1,1,5) ;

    int posTxt = 10 ;
    
    textSize(10) ;
    textAlign(LEFT, BOTTOM);
    strokeWeight(thickness) ;

    grid(size_grid) ;
    axe_x(size_grid, posTxt) ;
    axe_y(size_grid, posTxt) ;
    axe_z(size_grid, posTxt) ;
  }
}

// void axe_x(PVector size, int pos) {
public void axe_x(Vec3 size, int pos) {
  fill(0xffD31216) ;
  stroke(0xffD31216) ; 

  text("X LINE XXX", pos,-pos) ;

  noFill() ;
  line( -size.x,0,0,
        size.x,0,0) ;

}
// void axe_y(PVector size, int pos) {
public void axe_y(Vec3 size, int pos) {
    fill(0xff2DA308) ;
    stroke(0xff2DA308) ; 

    pushMatrix() ;
    rotateZ(radians(-90)) ;
    text("Y LINE YYY", pos, -pos) ;
    popMatrix() ;

    noFill() ;
    line( 0,-size.y,0,
          0,size.y,0) ;

}
// void axe_z(PVector size, int pos) {
public void axe_z(Vec3 size, int pos) {
    fill(0xffEFB90F) ;
    stroke(0xffEFB90F) ; 

    pushMatrix() ;
    rotateY(radians(90)) ;
    text("Z LINE ZZZ", pos, -pos) ;
    popMatrix() ;

    noFill() ;
    line( 0,0,-size.z,
          0,0,size.z) ;

}

// void grid(PVector size) {
public void grid(Vec3 size) {
  noFill() ;
  stroke(0xff596F91) ;
  // int size_grid = (int)size.z ;
  int step = 50 ;
  //horizontal grid
  for ( float i = -size.z ; i <= size.z ; i = i+step ) {
    if(i != 0 ) line( i, 0, -size.z, 
                      i, 0, size.z) ;
  }
}
//END CAMERA GRID WORLD
///////////////////////
// Tab: Z_Color 1.0.1
//COLOR for internal use
int fond ;
int rouge, orange, jaune, vert, bleu, noir, blanc, gris  ;

public void color_setup() {
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
    Old_Pixel p = (Old_Pixel) listMustBeChange.get(i) ;
    p.changeHue   (HSBmode, huePalette, hueStart, hueEnd) ;
    p.changeSat   (HSBmode, satPalette, satStart, satEnd) ; 
    p.changeBright(HSBmode, brightPalette, brightStart, brightEnd) ;
    
    p.updatePalette() ; 
  }
}



//convert color HSB to RVB
public Vec3 HSB_to_RGB(float hue, float saturation, float brightness) {
  Vec4 vecRGB = HSBa_to_RGBa(hue, saturation, brightness, g.colorModeA).copy() ;
  return Vec3(vecRGB.x,vecRGB.y,vecRGB.z) ;
}

public Vec4 HSBa_to_RGBa(float hue, float saturation, float brightness, float alpha) {
  Vec4 previousColorMode = Vec4(g.colorModeX, g.colorModeY, g.colorModeY, g.colorModeA) ;
  int c = color (hue, saturation, brightness, alpha);

  colorMode(RGB,255) ;
  Vec4 vecRGBa = Vec4 (red(c), green(c), blue(c), alpha(c)) ;
  // return to the previous colorMode
  // colorMode(HSB,HSBmode.r,HSBmode.r,HSBmode.b,HSBmode.a) ;
  colorMode(HSB,previousColorMode.r, previousColorMode.g, previousColorMode.b, previousColorMode.a) ;
  return vecRGBa ;
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














  
/**
CORE SCENE and PRESCENE 1.1.1
*/






/**
CHECK FOLDER
*/
public void init_and_update_diplay_var() {
  rectMode (CORNER) ;
  textAlign(LEFT) ;
  sizeBackgroundP3D = new PVector(width *100, height *100, height *7.5f) ;
}

/**
bitmap
*/
PImage[] bitmap_import ;
ArrayList bitmap_files = new ArrayList();
boolean folder_bitmap_is_selected = true ;
String [] bitmap_path ;
int count_bitmap_selection ;
int ref_bitmap_num_files ;


public void load_bitmap(int ID) {
  check_bitmap_folder_scene() ;
  // which_bitmap is the int return from the dropdown menu
  if(which_bitmap[ID] > bitmap_path.length ) which_bitmap[ID] = 0 ;

  if(bitmap_path != null && bitmap_path.length > 0) {
    String bitmap_current_path = bitmap_path[which_bitmap[ID]] ;
    if(!bitmap_current_path.equals(bitmap_path_ref[ID])) {
      bitmap_import[ID] = loadImage(bitmap_current_path) ;
    }
    bitmap_path_ref[ID] = bitmap_current_path ;
  }
}

public void check_bitmap_folder_scene() {
  // String path = sketchPath("") +"/" +preference_path +"Images" ;
  String path = import_path +"bitmap" ;

  // String path = preference_path +"Images" ;
  ArrayList allFiles = listFilesRecursive(path);
  //check if something happen in the folder
  if(ref_bitmap_num_files != allFiles.size() ) {
    folder_bitmap_is_selected = true ;
    ref_bitmap_num_files = allFiles.size() ;
  }
  // If something happen, algorithm work 
  if(folder_bitmap_is_selected) {
    count_bitmap_selection++ ;
    bitmap_files.clear() ;
    String fileName = "";
    for (int i = 0; i < allFiles.size(); i++) {
      File f = (File) allFiles.get(i);   
      fileName = f.getName(); 
  
      // Add it to the list if it's not a directory
      if (f.isDirectory() == false) {
        String lastThree = fileName.substring(fileName.length()-3, fileName.length());
        if (lastThree.equals("PNG") || lastThree.equals("png") || lastThree.equals("JPG") || lastThree.equals("jpg") || lastThree.equals("GIF") || lastThree.equals("gif")) {
          bitmap_files.add(f);
        }
      }
    }
    // edit the image path
    bitmap_path = new String[bitmap_files.size()] ;
    for (int i = 0; i < bitmap_files.size(); i++) {
      File f = (File) bitmap_files.get(i);
      bitmap_path[i] = f.getAbsolutePath() ;
    }
    
    // to don't loop with this void
    folder_bitmap_is_selected = false ;
  }
}


/**
svg
*/

RPEsvg[] svg_import ;
ArrayList svg_files = new ArrayList();
boolean folder_svg_is_selected = true ;
String [] svg_path ;
int count_svg_selection ;
int ref_svg_num_files ;


public void load_svg(int ID) {
  check_svg_folder_scene() ;
  // which_bitmap is the int return from the dropdown menu
  if(which_svg[ID] > svg_path.length ) which_svg[ID] = 0 ;

  if(svg_path != null && svg_path.length > 0) {
    String svg_current_path = svg_path[which_svg[ID]] ;
    if(!svg_current_path.equals(svg_path_ref[ID])) {
      svg_import[ID] = new RPEsvg(svg_current_path, svg_current_path) ;
    }
    svg_path_ref[ID] = svg_current_path ;
  }
}

public void check_svg_folder_scene() {
  // String path = sketchPath("") +"/" +preference_path +"Images" ;
  String path = import_path +"svg" ;

  // String path = preference_path +"Images" ;
  ArrayList allFiles = listFilesRecursive(path);
  //check if something happen in the folder
  if(ref_bitmap_num_files != allFiles.size() ) {
    folder_svg_is_selected = true ;
    ref_svg_num_files = allFiles.size() ;
  }
  // If something happen, algorithm work 
  if(folder_svg_is_selected) {
    count_svg_selection++ ;
    svg_files.clear() ;
    String fileName = "";
    for (int i = 0; i < allFiles.size(); i++) {
      File f = (File) allFiles.get(i);   
      fileName = f.getName(); 
  
      // Add it to the list if it's not a directory
      if (f.isDirectory() == false) {
        String lastThree = fileName.substring(fileName.length()-3, fileName.length());
        if (lastThree.equals("SVG") || lastThree.equals("svg")) {
          svg_files.add(f);
        }
      }
    }
    // edit the image path
    svg_path = new String[svg_files.size()] ;
    for (int i = 0; i < svg_files.size(); i++) {
      File f = (File) svg_files.get(i);
      svg_path[i] = f.getAbsolutePath() ;
    }
    
    // to don't loop with this void
    folder_svg_is_selected = false ;
  }
}




/**
text
*/
String[] text_import ;
ArrayList text_files = new ArrayList();
boolean folder_text_is_selected = true ;
String [] text_path ;
int count_text_selection ;
int ref_text_num_files ;

public void load_txt(int ID) {
  check_text_folder_scene() ;
  // which_text is the int return from the dropdown menu
  if(text_path != null && text_path.length > 0) {
    if(which_text[ID] > text_path.length ) which_text[ID] = 0 ;
    text_import[ID] = importText(text_path[which_text[ID]]) ;
  } else {
    text_import[ID] = "Big Brother has been burning all books, it's not possible to read anything" ;
  }
    
}




public void check_text_folder_scene() {
  // String path = sketchPath("") +"/" +preference_path +"Karaoke" ;
  String path = import_path +"karaoke" ;
  ArrayList allFiles = listFilesRecursive(path);
  
  //check if something happen in the folder
  if(ref_text_num_files != allFiles.size() ) {
    folder_text_is_selected = true ;
    ref_text_num_files = allFiles.size() ; 
  }
  // If something happen, algorithm work 
  if(folder_text_is_selected) {
    count_text_selection++ ;
    text_files.clear() ;
    String fileName = "";
    for (int i = 0; i < allFiles.size(); i++) {
      File f = (File) allFiles.get(i);   
      fileName = f.getName(); 
  
      // Add it to the list if it's not a directory
      if (f.isDirectory() == false) {
        String lastThree = fileName.substring(fileName.length()-3, fileName.length());
        if (lastThree.equals("TXT") || lastThree.equals("txt")) {
          text_files.add(f);
        }
      }
    }
    // edit the path file
    text_path = new String[text_files.size()] ;
    for (int i = 0; i < text_files.size(); i++) {
      File f = (File) text_files.get(i); 
      text_path[i] = f.getAbsolutePath() ;
    }
    
    // to don't loop with this void
    folder_text_is_selected = false ;
  }
}


/**
movie
*/
Movie[] movieImport ;
ArrayList movie_files = new ArrayList();
boolean folder_movie_is_selected = true ;
String [] movie_path, movieImportPath ;
int count_movie_selection ;
int ref_movie_num_files ;

public void load_movie(int ID) {
  check_movie_folder_scene() ;
  if(movie_path != null && movie_path.length > 0) {
    if(which_movie[ID] > movie_path.length ) which_movie[ID] = 0 ;
    movieImportPath[ID] = movie_path[which_text[ID]] ;
  } else {
    movieImportPath[ID] = "no movie" ;
  }
  setting_movie(ID) ;
}



// Movie Manager
public void setting_movie(int ID_item) {
  String lastThree = movieImportPath[ID_item].substring(movieImportPath[ID_item].length()-3, movieImportPath[ID_item].length());
  if (lastThree.equals("MOV") || lastThree.equals("mov")) {
    movieImport[ID_item] = new Movie(this, movieImportPath[ID_item]);
    movieImport[ID_item].loop();
    movieImport[ID_item].read();
  } else {
    println("BIG BROTHER don't find any movie, that's can became a proble, a real problem for you !") ;
    /**
    bug between OSC and the text, but only in Romanesco, not in isolated sketch see folder Processing 3.0.2 bug
    */
    // text("BIG BROTHER disagree your movie and burn it !", width/2, height/2) ;
  }
}





public void check_movie_folder_scene() {
  // String path = sketchPath("") +"/" +preference_path +"Karaoke" ;
  String path = import_path +"movie" ;
  ArrayList allFiles = listFilesRecursive(path);
  
  //check if something happen in the folder
  if(ref_movie_num_files != allFiles.size() ) {
    folder_movie_is_selected = true ;
    ref_movie_num_files = allFiles.size() ; 
  }
  // If something happen, algorithm work 
  if(folder_movie_is_selected) {
    count_movie_selection++ ;
    movie_files.clear() ;
    String fileName = "";
    for (int i = 0; i < allFiles.size(); i++) {
      File f = (File) allFiles.get(i);   
      fileName = f.getName(); 
  
      // Add it to the list if it's not a directory
      if (f.isDirectory() == false) {
        String lastThree = fileName.substring(fileName.length()-3, fileName.length());
        if (lastThree.equals("MOV") || lastThree.equals("mov")) {
          movie_files.add(f);
        }
      }
    }
    // edit the path file
    movie_path = new String[movie_files.size()] ;
    for (int i = 0; i < movie_files.size(); i++) {
      File f = (File) movie_files.get(i); 
      movie_path[i] = f.getAbsolutePath() ;
    }
    
    // to don't loop with this void
    folder_movie_is_selected = false ;
  }
}



/**
method to check folder
*/
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
/**
END CHECK FOLDER
*/





































/**
Text manager
*/
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

/**
End text manager
*/
















/**
MIROIR
*/

boolean syphon_on_off  ;
SyphonServer server ;


public void syphon_settings() {
  PJOGL.profile=1;
}

public void syphon_setup() {
  String name_syphon = (nameVersion + " " + prettyVersion +"."+version) ;
  server = new SyphonServer(this, name_syphon);
  println("Syphon setup done") ;
}

public void syphon_draw() {
  if(yTouch) syphon_on_off = !syphon_on_off ;
  if(syphon_on_off) server.sendScreen();
}
/**
END MIROIR
*/










/**
DISPLAY INFO
*/
boolean displayInfo, displayInfo3D ;
int posInfo = 2 ;


public void info() {
  int color_text = color(0,0,100) ;
  int color_bg = color(0,100,100,50) ;
  if (displayInfo) {
    //perspective() ;
    displayInfoScene(color_bg,color_text) ;
    displayInfoObject(color_bg,color_text) ;
  }
  if (displayInfo3D) displayInfo3D(color_text) ;
}

public void displayInfoScene(int bg_txt, int txt) {
  noStroke() ;
  fill(bg_txt) ;
  rectMode(CORNER) ;
  textAlign(LEFT) ;
  rect(0,-5,width, 15*posInfo) ;
  posInfo = 2 ;
  fill(txt) ;
  textFont(SansSerif10, 10) ;
  //INFO SIZE and RENDERER
  String displayModeInfo ;
  if (displayMode.equals("Classic") ) displayModeInfo = ("classic") ; else displayModeInfo = displayMode ;
  String infoRendering =("");
  if(FULL_RENDERING) infoRendering = ("Full rendering") ; else infoRendering = ("Preview rendering") ;
  text("Size " + width + "x" + height + " / "  + infoRendering + " / Render mode " + displayModeInfo + " / FrameRate " + (int)frameRate, 15,15) ;
  // INFO SYPHON
  text("Syphon " +syphon_on_off + " / press \u201cy\u201c to on/off the Syphon",15, 15 *posInfo ) ;
  posInfo += 1 ;
  //INFO MOUSE and PEN
  text("Mouse " + mouseX + " / " + mouseY + " molette " + wheel[0] + " pen orientation " + (int)deg360(Vec2(pen[0].x,pen[0].y)) +"\u00b0   stylet pressur " + PApplet.parseInt(pen[0].z *10),15, 15 *posInfo ) ;  
  posInfo += 1 ;
  // LIGHT INFO
  text("Directional light ONE || pos " + PApplet.parseInt(pos_light[1].x)+ " / " + PApplet.parseInt(pos_light[1].y) + " / "+ PApplet.parseInt(pos_light[1].z) + " || dir " + decimale(dir_light[1].x,2) + " / " + decimale(dir_light[1].y,2) + " / "+ decimale(dir_light[1].z,2),15, 15 *posInfo  ) ;
  posInfo += 1 ;
  text("Directional light TWO || pos " + PApplet.parseInt(pos_light[2].x)+ " / " + PApplet.parseInt(pos_light[2].y) + " / "+ PApplet.parseInt(pos_light[2].z) + " || dir " + decimale(dir_light[2].x,2) + " / " + decimale(dir_light[2].y,2) + " / "+ decimale(dir_light[2].z,2),15, 15 *posInfo  ) ;
  posInfo += 1 ;
  //INFO SOUND
  if (getTimeTrack() > 1 ) text("the track play until " +getTimeTrack() + "  Tempo " + getTempoRef() , 15,15 *(posInfo)) ; else text("no track detected ", 15, 15 *(posInfo)) ;
  posInfo += 1 ;
  text("right " + right_volume_info, 15, 15 *(posInfo)) ;  
  text("left "  + left_volume_info,  50, 15 *(posInfo)) ;
  posInfo += 1 ;
}


int posInfoObj = 1 ;

public void displayInfoObject(int bg_txt, int txt) {
  noStroke() ;
  fill(bg_txt) ;
  rectMode(CORNER) ;
  textAlign(LEFT) ;
  float heightBox = 15*posInfoObj ;
  rect(0, height -heightBox,width, heightBox) ;
  fill(txt) ;
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
public void displayInfo3D(int txt) {
   String posCam = ( PApplet.parseInt(-1 *sceneCamera.x ) + " / " + PApplet.parseInt(sceneCamera.y) + " / " +  PApplet.parseInt(sceneCamera.z -height/2)) ;
   String eyeDirectionCam = ( PApplet.parseInt(eyeCamera.x) + " / " + PApplet.parseInt(eyeCamera.y) ) ;
  fill(txt) ; 
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
/**
END DISPLAY INFO
*/





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
boolean cLongTouch, lLongTouch, nLongTouch, vLongTouch,
        spaceTouch, shiftLongTouch ;  

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
// Tab: Z_LIGHT and SHADER
// version 1.3.2 //////////
//////////////////////////
// LIGHT POSITION
PVector var_light_pos  ;
PVector var_light_dir  ;
/**
In this time we just use the var_light_pos with the pos light, may be in the future it's possible to use the couple
*/
public void light_position_setup() {
  var_light_pos = new PVector(width/2, height/2, -width *2) ;
  var_light_dir = new PVector(width/2, height/2, width *2) ;
}

public void light_position_draw(Vec3 mouse, int wheel) {
  if(lLongTouch && !shiftLongTouch ) {
    var_light_pos.x = mouse.x ;
    var_light_pos.y = mouse.y ;
    var_light_pos.z += wheel ;
  }
  if(lLongTouch && shiftLongTouch) {
    var_light_dir.x = mouse.x ;
    var_light_dir.y = mouse.y ;
    var_light_dir.z += wheel ;
  }
}


// INTERNAL VAR
PShader pixShader;
// PVector speedColorLight = new PVector() ;

Vec4 [] color_light ;
Vec4 [] color_light_ref ;
Vec3 [] color_setting ;

Vec3 [] dir_light ;
Vec3 [] dir_light_ref ;

Vec3 [] pos_light ;
Vec3 [] pos_light_ref ;

boolean [] on_off_light, on_off_light_action ;






public void shader_setup() {
  String path = (preference_path +"shader/shader_light/") ;
  pixShader = loadShader(path+"light_pix_frag_romanesco.glsl", path+"light_pix_vert_romanesco.glsl");
  shader(pixShader);
}
// END SETUP
////////////













public void light_setup() {
  /*
  float min =.001 ;
  float max = 0.3 ;
  speedColorLight = new PVector(random(min,max),random(min,max),random(min,max)) ;
  */
  int num_light = 3 ;
  color_light = new Vec4[num_light] ;
  color_light_ref = new Vec4[num_light] ;
  color_setting = new Vec3[num_light] ;
  dir_light = new Vec3[num_light] ;
  dir_light_ref = new Vec3[num_light] ;
  pos_light = new Vec3[num_light] ;
  pos_light_ref = new Vec3[num_light] ;
  on_off_light = new boolean[num_light] ;
  on_off_light_action  = new boolean[num_light] ;
  

  for (int i = 0 ; i < num_light ; i++ ) {
    color_light[i] = Vec4(0,100,100,100); 
    color_light_ref[i] = Vec4() ;
    dir_light[i] = Vec3(0,0,-1); 
    dir_light_ref[i] = dir_light[i].copy();
    pos_light[i] = Vec3(width/2,height/2, width *2); 
    pos_light_ref[i] = Vec3() ;
  }
}


// END SETUP
////////////




//DRAW
public void light_call_shader() {
  shader(pixShader);
}



public void light_update_position_direction() {
  // update value from the controller
   // shader_value_dev() ; // method to test valmue without controller etc.
  shader_value_romanesco(valueSlider, onOffLightAmbient, onOffDirLightOne, onOffDirLightTwo, onOffDirLightOneAction, onOffDirLightTwoAction) ;
    // DIRECTIONAL and  SPOT LIGHT UPDATE
  // Vec6 range_input_direction_3D = new Vec6(-1,1,   -1,1,  -1,1) ;
  Vec6 range_input_direction_3D = new Vec6(0,width,   0,height,  -width, width) ;
  
  Vec6 range_input_position_3D = new Vec6(0,width,   0,height,  -width, width) ;
  Vec6 range_output_position_3D = new Vec6(0,width,   0,height,  -width, width) ;


    // Position and direction of the directional light
  if(onOffDirLightOneAction) {
    dir_light[1] = light_direction(var_light_dir, range_input_direction_3D, on_off_light_action[1], dir_light[1],  dir_light_ref[1]).copy() ;
    pos_light[1] = light_position(var_light_pos, range_input_position_3D, range_output_position_3D, on_off_light_action[1], pos_light[1],  pos_light_ref[1]).copy() ;
    color_light[1] = light_color(color_setting [1], MAX_VALUE_SLIDER, HSBmode, color_light[1], color_light_ref[1]).copy() ;
  }
  if(onOffDirLightTwoAction) {
    dir_light[2] = light_direction(var_light_dir, range_input_direction_3D, on_off_light_action[2], dir_light[2],  dir_light_ref[2]).copy() ;
    PVector reverse_var_pos = new PVector(map(var_light_pos.x,0,width,width,0), map(var_light_pos.y,0,height,height,0),var_light_pos.z) ;
    pos_light[2] = light_position(reverse_var_pos, range_input_position_3D, range_output_position_3D, on_off_light_action[2], pos_light[2],  pos_light_ref[2]).copy() ;
    color_light[2] = light_color(color_setting [2], MAX_VALUE_SLIDER, HSBmode, color_light[2], color_light_ref[2]).copy() ;
  }
}


public void light_display() {

  // spotLightPixList() ;
  
  // ambient light
  if(on_off_light[0]){ 
    Vec4 newRef = Vec4(map(color_setting [0].r,0,MAX_VALUE_SLIDER,0,HSBmode.r), map(color_setting [0].g,0,MAX_VALUE_SLIDER,0,HSBmode.g), map(color_setting [0].b,0,MAX_VALUE_SLIDER,0,HSBmode.b),HSBmode.a) ;
    if(!compare(newRef, color_light_ref[0])) color_light[0] = newRef.copy() ;
    color_light_ref[0] = newRef.copy() ;
    ambientLightPix(color_light[0]) ;
  }
  // Spot light one
 
  float angle = TAU /2 ;
  float concentration = 10 ;
  // Vec6 range_input_direction_3D = new Vec6(0,width,   0,height,  -width, width) ;





  // display light
  if(on_off_light[1]) {
    light_spot_display(color_light[1], pos_light[1], dir_light[1], angle, concentration) ;
  }
  if(on_off_light[2]) {
    light_spot_display(color_light[2], pos_light[2], dir_light[2], angle, concentration) ;
  }
}



public void shader_draw() {
  // Color value fro the global vertex
  Vec4 RGBa = new Vec4(1, 1, 1, .5f) ; // it's OPENGL data between 0 to 1, the range is between -1 to 1, you can go beyond but take care at your life !
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
// END DRAW
///////////



















// ANNEXE
//////////

//DIRECTIONAL LIGHT
///////////////////




/**
open a list of lights with a max of height lights
@param Vec4 [] colour RGBa float component value 0-255
@param Vec4 [] dir xyz float component value -1 to 1
*/

// Display light
/**
Here we use a direction of light
*/
public void light_directional_display(Vec4 rgba, Vec3 dir) {
  rgba = check_colorMode_for_alpha(rgba).copy() ;
  directionalLight(rgba.r, rgba.g, rgba.b, dir.x, dir.y, dir.z);
}
// END DIRECTIONAL LIGHT
////////////////////////







// AMBIENT LIGHT
/////////////////
public void ambientLightPix(Vec4 rgba) {
  rgba = check_colorMode_for_alpha(rgba).copy() ;
  ambientLight(rgba.r, rgba.g, rgba.b);
}

public void ambientLightPix(Vec4 rgba, Vec3 pos) {
  rgba = check_colorMode_for_alpha(rgba).copy() ;
  ambientLight(rgba.r, rgba.g, rgba.b, pos.x, pos.y, pos.z);
}
// END AMBIENT LIGHT
////////////////////








// POINT LIGTH
//////////////


// Display light
/**
Here we use a position of light
*/
public void light_point_display(Vec4 rgba, Vec3 pos) {
  rgba = check_colorMode_for_alpha(rgba).copy() ;
  pointLight(rgba.r, rgba.g, rgba.b, pos.x, pos.y, pos.z);
}
// END POINT LIGHT
/////////////////




//SPOT LIGHT
/////////////
public void light_spot_display(Vec4 rgba, Vec3 pos, Vec3 dir, float angle, float concentration) {
  rgba = check_colorMode_for_alpha(rgba).copy() ;
  spotLight(rgba.r, rgba.g, rgba.b, pos.x, pos.y, pos.z, dir.x, dir.y, dir.z, angle, concentration) ;
}
// END SHADER PIX LIGTH
//////////////////////

// END LIGHT
////////////








// GLOBAL SHADER
////////////////

// COMMON LIGHT METHODE
//////////////////////
// update color
public Vec4 light_color(Vec3 value, int max, Vec4 color_univers, Vec4 color_light, Vec4 color_light_ref) {
  Vec4 newRefColor = Vec4(map(value.x, 0, max, 0, color_univers.x), map(value.y,0, max, 0, color_univers.y), map(value.z, 0, max, 0, color_univers.z),color_univers.w) ;
  if(!compare(newRefColor, color_light_ref)) color_light = newRefColor.copy() ;
  return newRefColor ;
}

// update direction
public Vec3 light_direction(PVector var, Vec6 range3D, boolean authorization, Vec3 dir, Vec3 dir_ref) {
  if(authorization) {
    
    Vec3 newRefDir = Vec3(map(var.x,range3D.a,range3D.b, -1,1),map(var.y,range3D.c,range3D.d, -1,1),map(var.z,range3D.e,range3D.f, -1,1)) ;
    if(!compare(newRefDir, dir_ref)) dir = newRefDir.copy() ;
    dir_ref = newRefDir.copy() ; 
  }
  return dir_ref  ;
}


// update position
public Vec3 light_position(PVector var, Vec6 range3D, Vec6 range3D_target,boolean authorization, Vec3 pos, Vec3 pos_ref) {
  if(authorization) {
    Vec3 newRefPos = Vec3(map(var.x,range3D.a,range3D.b, range3D_target.a,range3D_target.b),map(var.y,range3D.c,range3D.d, range3D_target.c,range3D_target.d),map(var.z,range3D.e,range3D.f, range3D_target.e,range3D_target.f)) ;
    if(!compare(newRefPos, pos_ref)) pos = newRefPos.copy() ;
    pos_ref = newRefPos.copy() ; 
  }
  return pos_ref  ;
}

/**
check the color mode of your skecth, if this one is on RGB, you must apply the alpha on RGB component, else in HSB you must apply only on SB components 
*/
public Vec4 check_colorMode_for_alpha(Vec4 rgba) {
  float alphaNormal = map(rgba.a,0,g.colorModeA,0,1) ;

  if(g.colorMode == 1 ) {
    rgba.r *= alphaNormal ;
    rgba.g *= alphaNormal ;
    rgba.b *= alphaNormal; 
  } else {
    rgba.g *= alphaNormal ; 
    rgba.b *= alphaNormal  ;
  }
  return rgba ;
}



// METHODE to manage external var
/////////////////////////////////
public void shader_value_romanesco(float [][]value, boolean onOffLightAmbient,  boolean onOffDirLightOne, boolean onOffDirLightTwo, boolean onOffDirLightOneAction, boolean onOffDirLightTwoAction) {
  color_setting [0] = Vec3(value[0][12],value[0][13],value[0][14]) ;
  color_setting [1] = Vec3(value[0][6],value[0][7],value[0][8]) ;
  color_setting [2] = Vec3(value[0][9],value[0][10],value[0][11]) ;

  on_off_light[0] = onOffLightAmbient ;
  on_off_light[1] = onOffDirLightOne ;
  on_off_light[2] = onOffDirLightTwo ;
  // on_off_light_action[0] = true ;
  on_off_light_action[1] = onOffDirLightOneAction ;
  on_off_light_action[2] = onOffDirLightTwoAction ;

//  var_light_dir = new PVector(0,0,1) ;
}

// VARIABLE TO TEST METHODE without Romanesco
public void shader_value_dev() {
    // color_setting [0] = Vec3(abs(cos(frameCount*.001)) *360,abs(cos(frameCount*.01) *360),abs(sin(frameCount*.1) *360))
  // float hue = abs(cos(frameCount*.001)) *360 ;
  //float saturation = map(mouseX, 0, width, 0,360) ;
  // float brightness = map(mouseY, 0, height, 0,360) ;
  float hue = sin(frameCount *.005f) *360 ;
  float saturation = 360 ;
  float brightness = sin(frameCount *.002f) *360 ;

  color_setting [0] = Vec3(hue,saturation,brightness); // (360,360,360) not (360,100,100) it's a reason why we must map the value
  color_setting [1] = Vec3(280,360,360) ;
  color_setting [2] = Vec3(0,360,360) ;
  
  var_light_pos = new PVector(mouseX,mouseY,200)  ; 
  var_light_dir = new PVector(0,0,1) ;
   // var_light_pos = new PVector(mouseX,mouseY,sin(frameCount *.1) *500)  ;
  
 //  var_light_dir = new PVector(mouseX,mouseY,sin(frameCount *.1) *500)  ;


  // on_off_light[0] = true ;
  on_off_light[1] = true ;
  on_off_light[2] = true ;
  on_off_light_action[0] = true ;
  on_off_light_action[1] = true ;
  on_off_light_action[2] = true ;
}
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
	color_light[0].r = dataWorld.getFloat("hue ambient") ;
	color_light[0].g = dataWorld.getFloat("saturation ambient") ;
	color_light[0].b = dataWorld.getFloat("brightness ambient") ;
	color_light[0].a = dataWorld.getFloat("alpha ambient") ;
	// pos ambient light
	/**
	Not use at this time
	dataWorld.setFloat("pos x ambient", value) ;
	dataWorld.setFloat("pos y ambient", value) ;
	dataWorld.setFloat("pos z ambient", value) ;
	*/
	// color light one
	color_light[1].r = dataWorld.getFloat("hue light 1") ;
	color_light[1].g = dataWorld.getFloat("saturation light 1") ;
	color_light[1].b = dataWorld.getFloat("brightness light 1") ;
	color_light[1].a = dataWorld.getFloat("alpha light 1") ;
	// pos light one
	dir_light[1].x = dataWorld.getFloat("pos x light 1") ;
	dir_light[1].y = dataWorld.getFloat("pos y light 1") ;
	dir_light[1].z = dataWorld.getFloat("pos z light 1") ;
	// color light two
	color_light[2].r = dataWorld.getFloat("hue light 2") ;
	color_light[2].g = dataWorld.getFloat("saturation light 2") ;
	color_light[2].b = dataWorld.getFloat("brightness light 2") ;
	color_light[2].a = dataWorld.getFloat("alpha light 2") ;
	// dir light two
	dir_light[2].x = dataWorld.getFloat("pos x light 2") ;
	dir_light[2].y = dataWorld.getFloat("pos y light 2") ;
	dir_light[2].z = dataWorld.getFloat("pos z light 2") ;
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
		which_bitmap[ID] = dataObj.getInt("which picture") ;
		which_svg[ID] = dataObj.getInt("which svg") ;
		which_movie[ID] = dataObj.getInt("which movie") ;
		which_text[ID] = dataObj.getInt("which text") ;
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

        if(FULL_RENDERING) {
        	fill_item[ID] = color(h_fill, s_fill, b_fill, a_fill) ;
			stroke_item[ID] = color(h_stroke, s_stroke, b_stroke, a_stroke) ;
			thickness_item[ID] = dataObj.getFloat("thickness") *height ;
		} else {
			// preview display
			fill_item[ID] = COLOR_FILL_OBJ_PREVIEW ;
			stroke_item[ID] =  COLOR_STROKE_OBJ_PREVIEW ;
			thickness_item[ID] = THICKNESS_OBJ_PREVIEW ;
	    }

		size_x_item[ID] = dataObj.getFloat("width") *width ;
		size_y_item[ID] = dataObj.getFloat("height") *width ;
		size_z_item[ID] = dataObj.getFloat("depth") *width ;
		canvas_x_item[ID] = dataObj.getFloat("canvas x") *width ;
		canvas_y_item[ID] = dataObj.getFloat("canvas y") *width ;
		canvas_z_item[ID] = dataObj.getFloat("canvas z") *width ;
		variety_item[ID] = dataObj.getFloat("family") ;
		quantity_item[ID] = dataObj.getFloat("quantity") ;
		life_item[ID] = dataObj.getFloat("life") ;

		speed_x_item[ID] = dataObj.getFloat("speed") ;
		dir_x_item[ID] = dataObj.getFloat("direction") ;
		angle_item[ID] = dataObj.getFloat("angle") ;
		swing_x_item[ID] = dataObj.getFloat("amplitude") ;
		repulsion_item[ID] = dataObj.getFloat("repulsion") ;
		attraction_item[ID] = dataObj.getFloat("attraction") ;
		alignment_item[ID] = dataObj.getFloat("aligmnent") ;
		influence_item[ID] = dataObj.getFloat("influence") ;

		posObjX[ID]	= dataObj.getFloat("pos x obj") *width ;
		posObjY[ID]	= dataObj.getFloat("pos y obj") *width ;
		posObjZ[ID]	= dataObj.getFloat("pos z obj") *width ;

		dirObjX[ID]	= dataObj.getFloat("longitude obj") ;
		dirObjY[ID]	= dataObj.getFloat("latitude obj") ;
	}

}
/**
Romanesco Processing Environment Manager \u2013 RPE Manager 2.0.4
*/
RPE_MANAGER rpe_manager ;
// CLASS ROMANESCO MANAGER
public void romanesco_setup() {
  rpe_manager = new RPE_MANAGER(this);
  rpe_manager.addObjectRomanesco() ;
  rpe_manager.finishIndex() ;
  rpe_manager.writeInfoUser() ;
  println("Romanesco setup done") ;
}


//Update the var of the object
public void updateObject(int ID) {
  //initialization
  if(!initValueMouse[ID]) { 
    mouse[ID] = mouse[0].copy() ;
    pen[ID] = pen[0].copy() ;
    initValueMouse[ID] = true ;
  }
  if(!initValueControleur[ID]) {
    font[ID] = font[0] ;
    update_slider_value(ID) ;
    initValueControleur[ID] = true ;
    which_bitmap[ID] = which_bitmap[0] ;
    which_text[ID] = which_text[0] ;
    which_svg[ID] = which_svg[0] ;
    which_movie[ID] = which_movie[0] ;
  }
  
  // info
  objectInfoDisplay[ID] = displayInfo?true:false ;
  
  
  if(parameter[ID]) {
    which_bitmap[ID] = which_bitmap[0] ;
    which_text[ID] = which_text[0] ;
    which_svg[ID] = which_svg[0] ;
    which_movie[ID] = which_movie[0] ;
    font[ID] = font[0] ;
    update_slider_value(ID) ;
  }
  updateSound(ID) ;
  
  if(action[ID] ){
    if(spaceTouch) {
      pen[ID].set(pen[0]) ;
      mouse[ID].set(mouse[0]) ;
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
public void update_slider_value(int ID) {
    if(FULL_RENDERING) {
      /**
      Changer : le fill et le stroke doivent se calculer sur des valeurs s\u00e9par\u00e9e, hue, sat, bright and alpha, sinon quand on les change cela change tout d'une seul coup.
      */
      // fill obj
      if      ( !first_opening_item[ID] ) fill_item[ID]               = color ( fill_hue_raw, fill_sat_raw,  fill_bright_raw, fill_alpha_raw) ; 
      else if ( fill_hue_temp != fill_hue_raw) fill_item[ID]       = color ( fill_hue_raw,      saturation(fill_item[ID]),    brightness(fill_item[ID]),  alpha(fill_item[ID])) ;
      else if ( fill_sat_temp != fill_sat_raw) fill_item[ID]       = color ( hue(fill_item[ID]),  fill_sat_raw,               brightness(fill_item[ID]),  alpha(fill_item[ID])) ; 
      else if ( fill_bright_temp != fill_bright_raw) fill_item[ID] = color ( hue(fill_item[ID]),  saturation(fill_item[ID]),    fill_bright_raw,          alpha(fill_item[ID])) ;   
      else if ( fill_alpha_temp != fill_alpha_raw) fill_item[ID]   = color ( hue(fill_item[ID]),  saturation(fill_item[ID]),    brightness(fill_item[ID]),  fill_alpha_raw) ;  
      // stroke obj
      if      ( !first_opening_item[ID] ) stroke_item[ID]                   = color (stroke_hue_raw, stroke_sat_raw, stroke_bright_raw, stroke_alpha_raw) ; 
      else if ( stroke_hue_temp != stroke_hue_raw) stroke_item[ID]       = color ( stroke_hue_raw,      saturation(stroke_item[ID]),  brightness(stroke_item[ID]),  alpha(stroke_item[ID])) ;
      else if ( stroke_sat_temp != stroke_sat_raw) stroke_item[ID]       = color ( hue(stroke_item[ID]),  stroke_sat_raw,             brightness(stroke_item[ID]),  alpha(stroke_item[ID])) ; 
      else if ( stroke_bright_temp != stroke_bright_raw) stroke_item[ID] = color ( hue(stroke_item[ID]),  saturation(stroke_item[ID]),  stroke_bright_raw,          alpha(stroke_item[ID])) ;   
      else if ( stroke_alpha_temp != stroke_alpha_raw) stroke_item[ID]   = color ( hue(stroke_item[ID]),  saturation(stroke_item[ID]),  brightness(stroke_item[ID]),  stroke_alpha_raw) ;  
      // thickness
      if (thickness_raw != thickness_temp|| !first_opening_item[ID]) thickness_item[ID] = thickness_raw ;
    } else {
      // preview display
      fill_item[ID] = COLOR_FILL_OBJ_PREVIEW ;
      stroke_item[ID] =  COLOR_STROKE_OBJ_PREVIEW ;
      thickness_item[ID] = THICKNESS_OBJ_PREVIEW ;
    }
    if (size_x_raw != size_x_temp || !first_opening_item[ID]) size_x_item[ID] = size_x_raw ; 
    if (size_y_raw != size_y_temp || !first_opening_item[ID]) size_y_item[ID] = size_y_raw ; 
    if (size_z_raw != size_z_temp || !first_opening_item[ID]) size_z_item[ID] = size_z_raw ;

    if (font_size_raw != font_size_temp || !first_opening_item[ID]) font_size_item[ID] = font_size_raw ; 

    if (canvas_x_raw != canvas_x_temp || !first_opening_item[ID]) canvas_x_item[ID] = canvas_x_raw ; 
    if (canvas_y_raw != canvas_y_temp || !first_opening_item[ID]) canvas_y_item[ID] = canvas_y_raw ; 
    if (canvas_z_raw != canvas_z_temp || !first_opening_item[ID]) canvas_z_item[ID] = canvas_z_raw ;


    // column 2
    if (reactivity_raw != reactivity_temp || !first_opening_item[ID]) reactivity_item[ID] = reactivity_raw ; 

    if (speed_x_raw != speed_x_temp || !first_opening_item[ID]) speed_x_item[ID] = speed_x_raw ; 
    if (speed_y_raw != speed_y_temp || !first_opening_item[ID]) speed_y_item[ID] = speed_y_raw ; 
    if (speed_z_raw != speed_z_temp || !first_opening_item[ID]) speed_z_item[ID] = speed_z_raw ;

    if (spurt_x_raw != spurt_x_temp || !first_opening_item[ID]) spurt_x_item[ID] = spurt_x_raw ; 
    if (spurt_y_raw != spurt_y_temp || !first_opening_item[ID]) spurt_y_item[ID] = spurt_y_raw ; 
    if (spurt_z_raw != spurt_z_temp || !first_opening_item[ID]) spurt_z_item[ID] = spurt_z_raw ;

    if (dir_x_raw != dir_x_temp || !first_opening_item[ID]) dir_x_item[ID] = dir_x_raw ; 
    if (dir_y_raw != dir_y_temp || !first_opening_item[ID]) dir_y_item[ID] = dir_y_raw ; 
    if (dir_z_raw != dir_z_temp || !first_opening_item[ID]) dir_z_item[ID] = dir_z_raw ;

    if (jitter_x_raw != jitter_x_temp || !first_opening_item[ID]) jitter_x_item[ID] = jitter_x_raw ; 
    if (jitter_y_raw != jitter_y_temp || !first_opening_item[ID]) jitter_y_item[ID] = jitter_y_raw ; 
    if (jitter_z_raw != jitter_z_temp || !first_opening_item[ID]) jitter_z_item[ID] = jitter_z_raw ;

    if (swing_x_raw != swing_x_temp || !first_opening_item[ID]) swing_x_item[ID] = swing_x_raw ; 
    if (swing_y_raw != swing_y_temp || !first_opening_item[ID]) swing_y_item[ID] = swing_y_raw ; 
    if (swing_z_raw != swing_z_temp || !first_opening_item[ID]) swing_z_item[ID] = swing_z_raw ;

    // col 3
    if (quantity_raw != quantity_temp || !first_opening_item[ID]) quantity_item[ID] = quantity_raw ;
    if (variety_raw != variety_temp || !first_opening_item[ID]) variety_item[ID] = variety_raw ;

    if (life_raw != life_temp || !first_opening_item[ID]) life_item[ID] = life_raw ;
    if (flow_raw != flow_temp || !first_opening_item[ID]) flow_item[ID] = flow_raw ;
    if (quality_raw != quality_temp || !first_opening_item[ID]) quality_item[ID] = quality_raw ;

    if (area_raw != area_temp || !first_opening_item[ID]) area_item[ID] = area_raw ;
    if (angle_raw != angle_temp || !first_opening_item[ID]) angle_item[ID] = angle_raw ;
    if (scope_raw != scope_temp || !first_opening_item[ID]) scope_item[ID] = scope_raw ;
    if (scan_raw != scan_temp || !first_opening_item[ID]) scan_item[ID] = scan_raw ;

    if (alignment_raw != alignment_temp || !first_opening_item[ID]) alignment_item[ID] = alignment_raw ;
    if (repulsion_raw != repulsion_temp || !first_opening_item[ID]) repulsion_item[ID] = repulsion_raw ;
    if (attraction_raw != attraction_temp || !first_opening_item[ID]) attraction_item[ID] = attraction_raw ;
    if (charge_raw != charge_temp || !first_opening_item[ID]) charge_item[ID] = charge_raw ;

    if (influence_raw != influence_temp || !first_opening_item[ID]) influence_item[ID] = influence_raw ;
    if (calm_raw != calm_temp || !first_opening_item[ID]) calm_item[ID] = calm_raw ;
    if (need_raw != need_temp || !first_opening_item[ID]) need_item[ID] = need_raw ;



  /** 
  make the obj has be never update in the future except by the moving slider 
  */
  first_opening_item[ID] = true ; 

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
class RPE_MANAGER {
  private ArrayList<Romanesco>RomanescoList ;
  private ArrayList<Class>objectRomanescoList;
  
  PApplet parent;
  String objectNameRomanesco [] ;
  String classRomanescoName [] ;
  int numClasses ;
  
  RPE_MANAGER(PApplet parent) {
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
  String pathObjects = preference_path+"objects/" ;
  
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
  * rpe_manager.finishIndex() ;
  * use with in romanesco_setup() {}
  */
  //finish index
  public void finishIndex() {
      // catch the different parameter from object class Romanesco
    for (int i=0 ; i < RomanescoList.size() ; i++ ) {
      Romanesco objR = (Romanesco) RomanescoList.get(i) ;
      rowIndexObject[i].setString("Name", objR.RPE_name) ;
      rowIndexObject[i].setInt("ID", objR.ID_item) ;
      rowIndexObject[i].setInt("Group", objR.ID_group) ;
      rowIndexObject[i].setString("Author", objR.RPE_author) ;
      rowIndexObject[i].setString("Version", objR.RPE_version) ;
      rowIndexObject[i].setString("Render", objR.romanescoRender) ;
      rowIndexObject[i].setString("Pack", objR.RPE_pack) ;
      rowIndexObject[i].setString("Mode", objR.RPE_mode) ;
      rowIndexObject[i].setString("Slider", objR.RPE_slider) ;
    }
    saveTable(indexObjects, pathObjects+"index_romanesco_objects.csv") ; 
    NUM_OBJ = RomanescoList.size() ;
  }
  
  /*
  * rpe_manager.writeInfoUser() ;
  * use with in romanesco_setup() {}
  */
  //ADD info for the user
  public void writeInfoUser() {
      // catch the different parameter from object class Romanesco
    for (int i=0 ; i < RomanescoList.size() ; i++ ) {
      Romanesco objR = (Romanesco) RomanescoList.get(i) ;
      objectID[objR.ID_item] = objR.ID_item ;
      objectName[objR.ID_item] = objR.RPE_name ;
      objectAuthor[objR.ID_item] = objR.RPE_author ;
      objectVersion[objR.ID_item] = objR.RPE_version ;
      objectPack[objR.ID_item] = objR.RPE_pack ;
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
    int num = 0 ;
    for (Romanesco objR : RomanescoList) {
      motion[objR.ID_item] = true ;
      initValueMouse[objR.ID_item] = true ;
      num ++ ;
      objR.setup() ;
      if(posObjRef[objR.ID_item] == null) posObjRef[objR.ID_item] = Vec3() ;
      posObjRef[objR.ID_item].set(item_setting_position[0][objR.ID_item]) ;
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
        if (show_object[objR.ID_item]) {
          updateObject(objR.ID_item) ;
          pushMatrix() ;
          addRefObj(objR.ID_item) ;
          if(vLongTouch && action[objR.ID_item] ) objectMove(movePos, moveDir, objR.ID_item) ;
          P3DmoveObj(objR.ID_item) ;
          objR.draw() ;
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
  String RPE_name, RPE_author, RPE_version, RPE_pack, romanescoRender, RPE_mode, RPE_slider ;
  int ID_item, ID_group ;
  //object manager return
  RPE_MANAGER orm ;
  
  public Romanesco() {
    RPE_name = "Unknown" ;
    RPE_author = "Anonymous";
    RPE_version = "Alpha";
    RPE_pack = "Base" ;
    romanescoRender = "classic" ;
    RPE_mode = "" ; // separate the name by a slash and write the next mode immadialtly after this one.
    RPE_slider = "all" ;
    ID_group = 0 ;
    ID_item = 0 ;
  }
  
  //manager return
  public void setManagerReference(RPE_MANAGER orm) {
    this.orm = orm;
  }
  
  //IMPORTANT
  //declared the void use in the sub-classes here
  public abstract void setup();
  public abstract void draw();
}
// END SUPER ROMANESCO
///////////////////////
/**
Z_Math 1.8.5
*/
// CONSTANT NUMBER must be here to be generate before all
/////////////////////////////////////////////////////////
final float PHI = (1 + sqrt(5))/2; //a number of polys use the golden ratio...
final float ROOT2 = sqrt(2); //...and the square root of two, the famous first irrationnal number by Pythagore
final float EULER = 2.718281828459045235360287471352f; // Constant d'Euler
// about constant https://en.wikipedia.org/wiki/Mathematical_constant


// ALGEBRE
//roots dimensions n
public float roots(float valueToRoots, int n) {
  return pow(valueToRoots, 1.0f/n) ;
}


// Decimal
// @return a specific quantity of decimal after comma
public float decimale (float var, int n) {
  float div = pow(10, abs(n)) ;
  return Math.round(var *div) / div;
}





//GEOMETRY
//////////

// EQUATION CIRLCE
public float perimeter_disc(int r) {
  return 2 *r *PI ;
}



//EQUATION
public float radius_from_circle_surface(int surface) {
  return sqrt(surface/PI) ;
}





// GEOMETRY POLAR and CARTESIAN

/**
Info
http://mathinsight.org/vectors_cartesian_coordinates_2d_3d
http://zone.ni.com/reference/en-XX/help/371361H-01/gmath/3d_cartesian_coordinate_rotation_euler/
http://www.mathsisfun.com/polar-cartesian-coordinates.html
https://en.wikipedia.org/wiki/Spherical_coordinate_system
http://stackoverflow.com/questions/20769011/converting-3d-polar-coordinates-to-cartesian-coordinates
http://www.vias.org/comp_geometry/math_coord_convert_3d.htm
http://mathworld.wolfram.com/Sphere.html
*/
/*

@return float
*/
public float longitude(float x, float range) {
  return map(x, 0,range, 0, TAU) ;
}
public float latitude(float y, float range) {
  return map(y, 0,range, 0, TAU) ;
}
public float angle_radians(float y, float range) {
  return map(y, 0,range, 0, TAU) ;
}
public float angle_degrees(float y, float range) {
  return map(y, 0,range, 0, 360) ;
}

public float angle(Vec2 a, Vec2 b) {
  return atan2( b.y -a.y, b.x -a.x );
}



  





/* 
return a vector info : radius,longitude, latitude
@return Vec3
*/
public Vec3 to_polar(Vec3 cart) {
  float radius = sqrt(cart.x * cart.x + cart.y * cart.y + cart.z * cart.z);
  float phi = acos(cart.x / sqrt(cart.x * cart.x + cart.y * cart.y)) * (cart.y < 0 ? -1 : 1);
  float theta = acos(cart.z / radius) * (cart.z < 0 ? -1 : 1);
  // check NaN result
  if (Float.isNaN(phi)) phi = 0 ;
  if (Float.isNaN(theta)) theta = 0 ;
  if (Float.isNaN(radius)) radius = 0 ;
  // result
  //return new Vec3(radius, longitude, latitude) ;
  return new Vec3(phi, theta, radius) ;
}


///////////////
// Cartesian 3D
/*
@ return Vec3
return the position of point on Sphere, with longitude and latitude
*/
//If you want just the final pos
public Vec3 to_cartesian_3D(Vec2 pos, Vec2 range, float sizeField)  {
  // vertical plan position
  float verticalY = to_cartesian_2D(pos.y, Vec2(0,range.y), Vec2(0,TAU), sizeField).x ;
  float verticalZ = to_cartesian_2D(pos.y, Vec2(0,range.y), Vec2(0,TAU), sizeField).y ; 
  Vec3 posVertical = new Vec3(0, verticalY, verticalZ) ;
  // horizontal plan position
  float horizontalX = to_cartesian_2D(pos.x, Vec2(0,range.x), Vec2(0,TAU), sizeField).x ; 
  float horizontalZ = to_cartesian_2D(pos.x, Vec2(0,range.x), Vec2(0,TAU), sizeField).y  ;
  Vec3 posHorizontal = new Vec3(horizontalX, 0, horizontalZ) ;
  
  return projection(middle(posVertical, posHorizontal), sizeField) ;
}

public Vec3 to_cartesian_3D(float latitude, float longitude) {
  float radius_normal = 1 ;
  return to_cartesian_3D(latitude, longitude, radius_normal);
}

// main method
public Vec3 to_cartesian_3D(float latitude, float longitude,  float radius) {
  // https://en.wikipedia.org/wiki/List_of_common_coordinate_transformations
  /**
  Must be improve is not really good in the border versus direct polar rotation with the matrix
  */ 
  float theta = longitude%TAU ;
  float phi = latitude%PI ;

  float x = radius *sin(theta) *cos(phi);
  float y = radius *sin(theta) *sin(phi);
  float z = radius *cos(theta);
  return new Vec3(x, y, z);
}
/*
Vec3 to_cartesian_3D(float longitude, float latitude, float radius) {
  // https://en.wikipedia.org/wiki/List_of_common_coordinate_transformations
  float x = radius *sin(latitude) *cos(longitude);
  float y = radius *sin(latitude) *sin(longitude);
  float z = radius *cos(latitude);
  return new Vec3(x, y, z);
}
*/



//Step 1 : translate the mouse position x and y  on the sphere, we must do that separately
/*
@ return Vec2 
return linear value on the circle perimeter
*/
public Vec2 to_cartesian_2D (float posMouse, Vec2 range, Vec2 targetRadian, float distance) {
  float rotationPlan = map(posMouse, range.x, range.y, targetRadian.x, targetRadian.y)  ;
  return to_cartesian_2D (rotationPlan, distance) ;
}

public Vec2 to_cartesian_2D (float angle) {
  float radius_normal = 1 ;
  return to_cartesian_2D (angle, radius_normal) ;
}

// main method
public Vec2 to_cartesian_2D (float angle, float radius) {
  float x = cos(angle) *radius;
  float y = sin(angle) *radius ;
  return Vec2(x,y) ;
}







/**
// Projection
*/
// Cartesian projection 2D
public Vec2 projection(Vec2 target) {
  return projection(target, Vec2(), 1.f) ;
}

public Vec2 projection(Vec2 target, float radius) {
  return projection(target, Vec2(), radius) ;
}
public Vec2 projection(Vec2 direction, Vec2 origin, float radius) {
  // Vec3 p = point_to_project.normalize(origin) ;
  Vec2 ref = direction.copy() ;
  Vec2 p = ref.dir(origin) ;
  p.mult(radius) ;
  p.add(origin) ;
  return p ;
}
// polar projection 2D
public Vec2 projection(float angle) {
  return projection(angle, 1) ;
}
public Vec2 projection(float angle, int r) {
  return Vec2(cos(angle) *r, sin(angle) *r) ;
}
// cartesian projection 3D
public Vec3 projection(Vec3 target) {
  return projection(target, Vec3(), 1.f) ;
}

public Vec3 projection(Vec3 target, float radius) {
  return projection(target, Vec3(), radius) ;
}

public Vec3 projection(Vec3 direction, Vec3 origin, float radius) {
  Vec3 ref = direction.copy() ;
  Vec3 p = ref.dir(origin) ;
  p.mult(radius) ;
  p.add(origin) ;
  return p ;
}





/**
SPHERE PROJECTION
*/
/**
// FIBONACCI SPHERE PROJECTION CARTESIAN
*/
public Vec3 [] list_cartesian_fibonacci_sphere (int num, float step, float root) {
  float root_sphere = root *num ;
  Vec3 [] list_points = new Vec3[num] ;
  for (int i = 0; i < list_points.length ; i++) list_points[i] = distribution_cartesian_fibonacci_sphere(i, num, step, root_sphere) ;
  return list_points ;
}
/*
float root_cartesian_fibonnaci(int num) {
  return random(1) *num ;
}
*/

public Vec3 distribution_cartesian_fibonacci_sphere(int n, int num, float step, float root) {
  if(n<num) {
    float offset = 2.f / num ;
    float y  = (n *offset) -1 + (offset / 2.f) ;
    float r = sqrt(1 - pow(y,2)) ;
    float phi = ((n +root)%num) * step ;
    
    float x = cos(phi) *r ;
    float z = sin(phi) *r ;
    
    return Vec3(x,y,z) ;
  } else return Vec3() ;
}

/**
// POLAR PROJECTION FIBONACCI SPHERE
*/
public Vec2 [] list_polar_fibonacci_sphere(int num, float step) {
  Vec2 [] list_points = new Vec2[num] ;
  for (int i = 0; i < list_points.length ; i++) list_points[i] = distribution_polar_fibonacci_sphere(i, num, step) ;
  return list_points ;
}
public Vec2 distribution_polar_fibonacci_sphere(int n, int num, float step) {
  if(n<num) {
    float longitude = PHI *TAU *n;
    longitude /= step ;
    // like a normalization of the result ?
    longitude -= floor(longitude); 
    longitude *= TAU;
    if (longitude > PI)  longitude -= TAU;
    // Convert dome height (which is proportional to surface area) to latitude
    float latitude = asin(-1 + 2*n/(float)num);
    return Vec2(longitude, latitude) ;
  } else return Vec2() ;

}










// normal direction 0-360 to -1, 1 PVector
public PVector normal_direction(int direction) {
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

public float deg360 (Vec2 dir) {
  float deg360 ;
  deg360 = 360 -(degrees(atan2(dir.x, dir.y)) +180)   ;
  return deg360 ;
}

//ROTATION
//GLOBAL

//DRAW

//other Rotation
//Rotation Objet
public void rotation (float angle, float posX, float posY) {
  translate(posX, posY ) ;
  rotate (radians(angle) ) ;
}
public void rotation (float angle, Vec2 pos) {
  translate(pos.x, pos.y) ;
  rotate (radians(angle) ) ;
}



public Vec2 rotation (Vec2 ref, Vec2 lattice, float angle) {
  float a = angle(lattice, ref) + angle;
  float d = lattice.dist(ref);
  float x = lattice.x + cos( a ) * d;
  float y = lattice.y + sin( a ) * d;
  return Vec2(x,y);
}

/**
May be must push to deprecated
*/
public Vec2 rotation_lattice(Vec2 ref, Vec2 lattice, float angle) {
  float a = angle( lattice, ref ) + angle;
  float d = dist( lattice, ref );
  float x = lattice.x + cos( a ) * d;
  float y = lattice.y + sin( a ) * d;
  return Vec2(x,y);
}
//END OF ROTATION


// END EQUATION
///////////////






/**
// PRIMITIVE 2D
//////////////
*/


/**
//DISC
*/
public void disc( PVector pos, int diam, int c ) {
  for ( int i = 1 ; i < diam +1 ; i++) {
    circle(c, pos, i) ;
  }
}

public void chromatic_disc( PVector pos, int diam ) {
  for ( int i = 1 ; i < diam +1 ; i++) {
    chromatic_circle(pos, i) ;
  }
}


/**
//CIRCLE
*/
public void chromatic_circle(PVector pos, int d) {
  int surface = d*d ; // surface is equale of square surface where is the cirlcke...make sens ?

  int radius = ceil(radius_from_circle_surface(surface)) ;
  int numPoints = ceil(perimeter_disc( radius)) ;
  for(int i=0; i < numPoints; i++) {
      //circle
      float stepAngle = map(i, 0, numPoints, 0, 2*PI) ; 
      float angle =  2*PI - stepAngle;
      //color
      int c = color (i, 100,100) ;
      //display
      set(PApplet.parseInt(projection(angle, radius).x + pos.x) , PApplet.parseInt(projection(angle, radius).y + pos.y), c);
  }
}


//full cirlce
public void circle(int c, PVector pos, int d) {
  int surface = d*d ; // surface is equale of square surface where is the cirlcke...make sens ?

  int radius = ceil(radius_from_circle_surface(surface)) ;
  int numPoints = ceil(perimeter_disc(radius)) ;
  for(int i=0; i < numPoints; i++) {
      float stepAngle = map(i, 0, numPoints, 0, 2*PI) ; 
      float angle =  2*PI - stepAngle;
      set(PApplet.parseInt(projection(angle, radius).x + pos.x) , PApplet.parseInt(projection(angle, radius).y + pos.y), c);
  }
}

//circle with a specific quantity points
public void circle(int c, PVector pos, int d, int num) {
  int surface = d*d ; // surface is equale of square surface where is the cirlcke...make sens ?

  int radius = ceil(radius_from_circle_surface(surface)) ;
  for(int i=0; i < num; i++) {
      float stepAngle = map(i, 0, num, 0, 2*PI) ; 
      float angle =  2*PI - stepAngle;
      set(PApplet.parseInt(projection(angle, radius).x + pos.x) , PApplet.parseInt(projection(angle, radius).y + pos.y), c);
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

  int radius = ceil(radius_from_circle_surface(surface)) ;
  for(int i=0; i < num; i++) {
    float stepAngle = map(i, 0, num, 0, 2*PI) ; 
    float angle =  2*PI - stepAngle;
    PVector newPos = new PVector(projection(angle, radius).x + pos.x, projection(angle, radius).y + pos.y) ;
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
// summits around the circle
public PVector [] circle (PVector pos, int d, int num) {
  PVector [] p = new PVector [num] ;
  int surface = d*d ; 
  int radius = ceil(radius_from_circle_surface(surface)) ;
  
  // choice your starting point
  float startingAnglePos = PI*.5f;
  if(num == 4) startingAnglePos = PI*.25f;
  
  for( int i=0 ; i < num ; i++) {
    float stepAngle = map(i, 0, num, 0, TAU) ; 
    float angle =  TAU - stepAngle -startingAnglePos;
    p[i] = new PVector(projection(angle, radius).x +pos.x,projection(angle, radius).y + pos.y) ;
  }
  return p ;
}

public PVector [] circle (PVector pos, int d, int num, float jitter) {
  PVector [] p = new PVector [num] ;
  int surface = d*d ; 
  int radius = ceil(radius_from_circle_surface(surface)) ;
  
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
    
    p[i] = new PVector(projection(angle, radius).x +pos.x, projection(angle, radius).y +pos.y) ;
  }
  return p ;
}
/**
// END DISC and CIRCLE
*/











/**
// PRIMITIVE  with "n" summits
*/
public void primitive(float radius, int summits) {
  Vec3 pos = new Vec3 () ;
  float orientation = 0 ;
  Vec2 dir = Vec2() ;
  primitive(pos, radius, summits, orientation, dir) ;
}

public void primitive(Vec2 p, float radius, int summits) {
  Vec3 pos = new Vec3 (p.x,p.y,0) ;
  float orientation = 0 ;
  Vec2 dir = Vec2() ;
  primitive(pos, radius, summits, orientation, dir) ;
}
public void primitive(Vec2 p, float radius, int summits, float orientation) {
  Vec3 pos = new Vec3 (p.x,p.y,0) ;
  Vec2 dir = Vec2() ;
  primitive(pos, radius, summits, orientation, dir) ;
}

// Primitive with Vec method
public void primitive(Vec3 pos, float radius, int summits) {
  float orientation = 0 ;
  Vec2 dir = Vec2() ;
  primitive(pos, radius, summits, orientation, dir) ;
}

public void primitive(Vec3 pos, float radius, int summits, Vec2 dir) {
  float orientation = 0 ;
  primitive(pos, radius, summits, orientation, dir) ;
}

public void primitive(Vec3 pos, float radius, int summits, float orientation) {
  Vec2 dir = Vec2() ;
  primitive(pos, radius, summits, orientation, dir) ;
}

// Primitive with Vec method and angle to display
public void primitive(Vec3 pos, float radius, int summits, float orientation, Vec2 dir) {
  //  if(summits < 3) summits = 3 ;
  if(summits < 2) summits = 2 ;
  Vec3 [] points = new Vec3[summits] ;
  // create coord of the shape
  if(dir == null ) {
    // call POLYGON 2D
    for (int i = 0 ; i < summits ; i++) points[i] = polygon_2D(summits, orientation)[i].copy() ;
  } else if (dir != null && renderer_P3D()) {
    /**
    // call POLYGON 3D
    but must be refactoring because the metod polygon_3D is a little shitty !!!!!
    for (int i = 0 ; i < summits ; i++) {points[i] = polygon_3D(summits, orientation, dir)[i].copy() ;
    */
    // for (int i = 0 ; i < summits ; i++) points[i] = polygon_3D(pos, radius, summits, orientation, dir)[i].copy() ;
    /**
    // classic version with polygon_2D method
    */
    // matrix_3D_start(pos, dir) ;
    for (int i = 0 ; i < summits ; i++) points[i] = polygon_2D(summits, orientation)[i].copy() ;
    // matrix_end() ;
  } else {
    for (int i = 0 ; i < summits ; i++) points[i] = polygon_2D(summits, orientation)[i].copy() ;
  }
  //draw the shape
  /**
  this rotate part must be integrate with a cartesian method in the circle method
  */
  draw_primitive(pos, dir, radius, points) ;
  /**
  With advance shitty version of Polygon_3D
  */
  // if(dir == null ) draw_primitive(pos, radius, points) ; else if (dir != null && renderer_P3D()) draw_primitive( points) ;
}


// local method
public void draw_primitive (Vec3 [] pts) {
  Vec3 pos = Vec3() ;
  // Vec2 dir_polar = Vec2() ;
  int radius = 1 ;
  draw_primitive (pos, radius, pts) ;
}

public void draw_primitive (float radius, Vec3 [] pts) {
  Vec3 pos = Vec3() ;
  // Vec2 dir_polar = Vec2() ;
  draw_primitive (pos, radius, pts) ;
}

public void draw_primitive (Vec3 pos, Vec2 dir, float radius, Vec3 [] pts) {
  // special one because we have direction for the polygone, so we must use the matrix system until have a good algorithm for the cartesian direction
  if(renderer_P3D()) matrix_3D_start(pos, dir) ; else matrix_2D_start(Vec2(pos.x, pos.y), 0) ;
  draw_primitive (radius, pts) ;
  matrix_end() ;
}

// main draw primitive
public void draw_primitive (Vec3 pos, float radius, Vec3 [] pts) {
  beginShape() ;
  for (int i = 0 ; i < pts.length ; i++) {
    if (pts[i] != null ) {
      pts[i].mult(radius) ;
      pts[i].add(pos) ;
      // test the rendering and if the shape if a line or not, to coice between vertex and line display
      if(renderer_P3D())  {
        if ( pts.length <= 2 && pts.length > 1 ) {
          // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> here we make an exception in the structure code for the pts[i+1] because this one haven't make .mult() and .add() method to the final position
          if (i < pts.length -1) line(pts[i], pts[i+1].mult(radius).add(pos)) ;
        } else {
          vertex(pts[i]) ;
        }
      // 2D  
      } else {
        if ( pts.length <= 2 && pts.length > 1 ) {
          
          if (i < pts.length -1) {
            // >>>>>>>>>>>>>here we make an exception in the structure code for the pts[i+1] because this one haven't make .mult() and .add() method to the final position
            Vec2 point_b = new Vec2(pts[i+1].x, pts[i+1].y) ;
            point_b.mult(radius).add(Vec2(pos.x, pos.y)) ;
            line(pts[i].x,pts[i].y, point_b.x, point_b.y) ;

          } 
        } else {
          vertex(pts[i].x, pts[i].y) ;
        }
      }
    }
  }
  endShape(CLOSE) ;
}










/**
POLYGON
*/
// summits around the polygon 2D
public Vec3 [] polygon_2D (int num) {
  float new_orientation = 0 ;
  return polygon_2D (num, new_orientation) ;
}


// main method
public Vec3 [] polygon_2D (int num, float new_orientation) {
  Vec3 [] p = new Vec3 [num] ;
  // choice your starting point
  float startingAnglePos = PI*.5f +new_orientation;
  if(num == 4) startingAnglePos = PI*.25f +new_orientation;
  // calcul the position of each summit, step by step
  for( int i=0 ; i < num ; i++) {
    float stepAngle = map(i, 0, num, 0, TAU) ; 
    float orientation = TAU -stepAngle -startingAnglePos ;
    Vec2 temp_orientation_xy = to_cartesian_2D(orientation) ;
    
    float x = temp_orientation_xy.x  ;
    float y = temp_orientation_xy.y  ;
    float z = 0 ;
    p[i] = Vec3(x,y,z) ;
  }
  return p ;
}
/**
POLYGON 3D
but must be refactoring because the metod is a little shitty !!!!!
*/
// polygon with 3D direction in cartesian world
public Vec3 [] polygon_3D (int num, float new_orientation, Vec3 dir) {
  Vec3 pos = Vec3() ;
  int radius = 1 ;
  return polygon_3D (pos, radius, num, new_orientation, dir) ;
}

public Vec3 [] polygon_3D (Vec3 pos, float radius, int num, float new_orientation, Vec3 dir) {
  /*
  Inspirated by : Creating a polygon perpendicular to a line segment Written by Paul Bourke February 1997
  http://paulbourke.net/geometry/circlesphere/
  */
  Vec3 p1 = dir.copy() ;
  Vec3 p2 = to_cartesian_3D(PI,PI) ;
  Vec3 support = to_cartesian_3D(PI,PI) ;
  /*
  Vec3 p2 = Vec3(0,0,1) ;
  Vec3 support = Vec3 (1,0,0) ;
  */
  // prepare the vector direction
  Vec3 r = Vec3() ;
  Vec3 s = Vec3() ;
  Vec3 p2_sub_p1 = sub(p1,p2);

  r = cross(p2_sub_p1, support, r) ;
  s = cross(p2_sub_p1, r, s) ;
  r.dir() ;
  s.dir() ;

  // prepare polygone in 3D world
  Vec3 plane = new Vec3();
  int num_temp = num +1 ;
  Vec3 [] p ;
  p = new Vec3 [num_temp] ;

  // init Vec3 p
  for(int i = 0 ; i < num_temp ; i++) p[i] = Vec3() ;
  
  // create normal direction for the point
  float theta, delta;
  delta = TAU / num;
  int step = 0 ;
  for (theta = 0 ; theta < TAU ; theta += delta) {
    plane.x = p1.x + r.x * cos(theta +delta) + s.x * sin(theta +delta);
    plane.y = p1.y + r.y * cos(theta +delta) + s.y * sin(theta +delta);
    plane.z = p1.z + r.z * cos(theta +delta) + s.z * sin(theta +delta);
    /**
    plane is not a normal value, it's big problem :(((((((
    */
    plane.mult(radius) ;
    plane.add(pos) ;
    // write summits
    p[step] = plane.copy() ;

    step ++ ;
  }

  return p ;
}
/**
END POLYGON
*/



















// TRIANGLE
public void triangle(float x_a, float y_a, float z_a, float x_b, float y_b, float z_b, float x_c, float y_c, float z_c) {
  Vec3 a = Vec3(x_a, y_a, z_a) ;
  Vec3 b = Vec3(x_b, y_b, z_b) ;
  Vec3 c = Vec3(x_c, y_c, z_c) ;
  triangle(a, b, c) ;
}
public void triangle(float x_a, float y_a, float x_b, float y_b, float x_c, float y_c) {
  Vec3 a = Vec3(x_a, y_a, 0) ;
  Vec3 b = Vec3(x_b, y_b, 0) ;
  Vec3 c = Vec3(x_c, y_c, 0) ;
  triangle(a, b, c) ;
}

public void triangle(Vec2 aa, Vec2 bb, Vec2 cc) {
  Vec3 a = Vec3(aa.x, aa.y, 0) ;
  Vec3 b = Vec3(bb.x, bb.y, 0) ;
  Vec3 c = Vec3(cc.x, cc.y, 0) ;
  triangle(a, b, c) ;
}

public void triangle(Vec3 a, Vec3 b, Vec3 c) {
  beginShape() ;
  if(renderer_P3D()) {
    vertex(a.x, a.y, a.z) ;
    vertex(b.x, b.y, b.z) ;
    vertex(c.x, c.y, c.z) ;
  } else {
    vertex(a.x, a.y) ;
    vertex(b.x, b.y) ;
    vertex(c.x, c.y) ;
  }
  endShape(CLOSE) ;
}
// END TRIANGLE



// END PRIMITIVE 2D
///////////////////


















/**
//PRIMITIVE 3D
//////////////
*/

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











/**
// MISC
////////
*/






/**
// TARGET direction
*/
// Target direction return the normal direction of the target from the origin
public Vec2 target_direction(Vec2 target, Vec2 my_position) {
  return projection(target, my_position, 1).sub(my_position) ;
}

public Vec3 target_direction(Vec3 target, Vec3 my_position) {
  return projection(target, my_position, 1).sub(my_position) ;
}
/**
 OLD Method deprecated
*/
//////////////////////////////////////////////
// THIS PART MUST BE DEPRECATED in the future
public PVector rotation (PVector ref, PVector lattice, float angle) {
  float a = angle(lattice, ref) + angle;
  float d = distance( lattice, ref );
  float x = lattice.x + cos( a ) * d;
  float y = lattice.y + sin( a ) * d;
  return new PVector(x,y);
}
public float distance( PVector p0, PVector p1) {
  return sqrt((p0.x - p1.x) *(p0.x - p1.x) +(p0.y - p1.y ) *(p0.y - p1.y ) );
}
public float angle( PVector p0, PVector p1) {
  return atan2( p1.y -p0.y, p1.x -p0.x );
}


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



// PVector goToPosFollow = = new PVector() ;
// CALCULATE THE POS of PVector Traveller, give the target pos and the speed to go.
public PVector follow(PVector target, float speed) {
  PVector goToPosFollow = new PVector() ;
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
// Tab: Z_Module
// Z_Module 1.1



// CAMERA
/////////
Capture cam;
String[] cameras ;
String[] cam_name ;
PVector[] cam_size ;
int[] cam_fps ;
int which_cam = 0;
int ref_cam = -1 ;
PVector CAM_SIZE ;
boolean CAMERA_AVAILABLE ;

boolean new_cam = true ;
boolean stop_cam = false ;
boolean init_cam = false ;



// Main method camera
public void camera_video_setup() {
  list_cameras() ;
  if(new_cam && which_cam > -1) launch_camera(which_cam) ;
}

public void camera_video_draw() {
  if(ref_cam != which_cam || which_cam == -1) {
    new_cam = true ;
    camera_stop() ;
    ref_cam = which_cam ;
    if (new_cam && which_cam > -1 ) launch_camera(which_cam) ;
    if (cam.available()) cam.read();
  }
}





// annexe methode camera
public void launch_camera(int which_cam) {
  if(CAMERA_AVAILABLE) {
    // if(FULL_RENDERING) which_cam = 0 ; else which_cam = 7 ; // 4 is normal camera around 800x600 or 640x360 with 30 fps
    if(!init_cam) {
      init_camera(which_cam) ;
      init_cam = true ;
    }
    CAM_SIZE = cam_size[which_cam].copy() ;
    // surface.setSize((int)cam_size[which_cam].x, (int)cam_size[which_cam].y) ;
    new_cam = false ;

  }
}

public void camera_stop() {
  cam.stop() ;
  init_cam = false ;
}




public void init_camera(int which_camra) {
  cam = new Capture(this, cameras[which_camra]);
  cam.start();     
  cam.read(); 

}


public void list_cameras() {
  cameras = Capture.list();
  cam_name = new String[cameras.length] ;
  cam_size = new PVector[cameras.length] ;
  cam_fps = new int[cameras.length] ;
  
  // about the camera
  if (cameras.length != 0) {
    CAMERA_AVAILABLE = true ;
    // println("Available cameras:");
    for(int i = 0 ; i < cameras.length ; i++) {
      String cam_data [] = split(cameras[i],",") ;
      // camera name
      cam_name[i] = cam_data [0].substring(5,cam_data[0].length()) ;
      // size camera
      String size = cam_data [1].substring(5,cam_data[1].length()) ;
      String [] sizeXY = split(size,"x") ;
      cam_size[i] = new PVector(Integer.parseInt(sizeXY[0]), Integer.parseInt(sizeXY[1])) ;  // Integer.parseInt("1234");
      // fps
      String fps = cam_data [2].substring(4,cam_data[2].length()) ;
      cam_fps[i] = Integer.parseInt(fps) ;
    }
  } else {
    CAMERA_AVAILABLE = false ;
  }
}
// END CAMERA
/////////////












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
    String [] md = loadStrings (preference_path+"meteo.txt")  ;
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
/**
Z_OSC Version 1.1.1
*/
/////////////////////////
// RECEIVE INFO from CONTROLLER
////////////////////////////////
int numOfPartSendByController = 5 ; 
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
public void translateDataFromController_buttonGlobal() {
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
  which_bitmap[0] = valueButtonGlobal[15] ;
  which_svg[0] = valueButtonGlobal[16] ;
  which_text[0] = valueButtonGlobal[17] ;
  which_movie[0] = valueButtonGlobal[18] ;
  which_cam = valueButtonGlobal[19] ;
}
public void translateDataFromController_buttonItem() {
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
// CLASS PIX 0.1.5
/////////////////////
/**
https://github.com/StanLepunK/Pixel
*/
public interface Pixel_Constants {
  static public final String RANDOM = "RANDOM";

  // BASIC SHAPES 2D
  static public final String POINT = "POINT";
  static public final String LINE = "LINE";
  static public final String TRIANGLE = "TRI";
  static public final String TETRAGON = "TETRA";
  static public final String RECTANGLE = "RECT";
  static public final String PENTAGON = "PENTA";
  static public final String HEXAGON = "HEXA";
  static public final String HEPTAGON = "HEPTA";
  static public final String OCTAGON = "OCTA";
  static public final String ENNEAGON = "ENNE";
  static public final String DECAGON = "DECA";
  static public final String HENDECAGON = "HENDE";
  static public final String DODECAGON = "DODE";

  static public final String POLYGONE = "POLY";


  // BASIC SHAPES 3D
  static public final String CUBE = "CUBE";
  static public final String BOX = "BOX";
  
  // SPECIAL SHAPES
  static public final String RING = "RING";
  static public final String DISC = "DISC";
  static public final String SPHERE = "SPHERE";
  static public final String STAR = "STAR";
  static public final String CROSS = "CROSS";

}


// MOTHER CLASS
// No contructor in this Class

class Pix implements Pixel_Constants{
  // P3D mode
  Vec3 pos, new_pos ;
  Vec3 size  ;
  Vec2 angle ;
  
  // in cartesian mode
  Vec3 dir = Vec3() ;

  Vec3 grid_position ;
  int ID, rank ;
  String costume  ;
  Vec4 colour, new_colour   ;


  public void init_mother_arg() {
    pos = Vec3(width/2, height/2,0 ) ;
    new_pos = pos.copy() ;
    size = Vec3(1) ;
    angle = Vec2(0);
    grid_position = pos.copy() ;
    // give a WHITE color to the pixel
    if(g.colorMode == 3 ) colour = Vec4(0, 0, g.colorModeZ, g.colorModeA) ; else colour = Vec4(g.colorModeX, g.colorModeY, g.colorModeZ, g.colorModeA) ;
    new_colour = colour.copy() ;

    int ID = 0 ;
    int rank = -1 ;
    costume = POINT ;
  }
  
  
  // RETURN color in Vec4
  // test the color mode to return the good data for each component
  public Vec4 int_color_to_vec4_color(int c) {
    Vec4 color_temp = new Vec4() ;
    /*
    if(g.colorMode == 3 ) color_temp = Vec4(hue(c), saturation(c), brightness(c),g.colorModeA) ;
    else color_temp = Vec4(red(c),green(c), blue(c),g.colorModeA) ;
    */
    if(g.colorMode == 3 ) color_temp = Vec4(hue(c), saturation(c), brightness(c),alpha(c)) ;
    else color_temp = Vec4(red(c),green(c), blue(c),alpha(c)) ;
    return color_temp ;
  }






    // ID
 //change ID after analyze if this one is good
  public void changeID(int ID) {  
    this.ID = ID ; 
  }
  
  // change size
  public void size(float size_pix) {
    size = Vec3(size_pix,size_pix,size_pix) ;
  }
  public void size(float size_x, float size_y) {
    size = Vec3(size_x,size_y,1) ;
  }
  public void size(float size_x, float size_y, float size_z) {
    size = Vec3(size_x,size_y,size_z) ;
  }

  public void size(Vec2 size_pix) {
    size = Vec3(size_pix.x,size_pix.y,1) ;
  }
  public void size(Vec3 size_pix) {
    size = Vec3(size_pix.x,size_pix.y,size_pix.z) ;
  }


  // angle
  public void angle(float angle_x) {
    this.angle = Vec2(angle_x,0) ;
  }

  public void angle(Vec2 angle) {
    this.angle = angle ;
  }

  // normal direction
  public void direction(Vec3 dir) {
    this.dir = dir ;
  }

  public void direction(float x, float y, float z) {
    this.dir = Vec3(x,y,z) ;
  }

  public void dir_x(float x) {
    dir.x = x ;
  }

  public void direction_y(float y) {
    dir.y = y ;
  }
  public void direction_z(float z) {
    dir.z = z ;
  }







  // COSTUME
  //////////
  
  
  
  // mother method
  public void costume_2D(Vec3 p, Vec3 s, Vec2 ang) {
    if (costume == POINT) point(p.x, p.y) ;
    else if(costume == DISC ) ellipse(p.x, p.y, s.x, s.y) ;
    else if(costume == LINE ) primitive(p, s.x, 2, ang.x) ;
    else if(costume == TRIANGLE ) primitive(p, s.x, 3, ang.x) ;
    else if(costume == TETRAGON ) primitive(p, s.x, 4, ang.x) ;
    else if(costume == RECTANGLE ) rect(p.x -(s.x/2), p.y -(s.y/2), s.x, s.y) ;
    else if(costume == PENTAGON ) primitive(p, s.x, 5, ang.x) ;
    else if(costume == HEXAGON ) primitive(p, s.x, 6, ang.x) ;
    else if(costume == HEPTAGON ) primitive(p, s.x, 7, ang.x) ;
    else if(costume == OCTAGON ) primitive(p, s.x, 8, ang.x) ;
    else if(costume == ENNEAGON ) primitive(p, s.x, 9, ang.x) ;
    else if(costume == DECAGON ) primitive(p, s.x, 10, ang.x) ;
    else if(costume == HENDECAGON ) primitive(p, s.x, 11, ang.x) ;
    else if(costume == DODECAGON ) primitive(p, s.x, 12, ang.x) ;
    else point(p.x, p.y) ;
  }

  // costume 3D
  /////////////
    // local translation      
  //float cor_x = 0 ;
  // float cor_y = 0 ;
  public void costume_3D(Vec3 pos, Vec3 s, Vec2 ang, Vec2 dir_polar){
    display_costume(pos, s, ang, dir_polar) ;

  }

  public void costume_3D(Vec3 pos, Vec3 s, Vec2 ang, Vec3 dir_cart) {
    // change cartesian direction to polar direction
    Vec3 dir = to_polar(dir_cart) ;
    Vec2 dir_polar = Vec2(dir.x, dir.y) ;
    display_costume(pos, s, ang, dir_polar) ;
  }

  public void display_costume(Vec3 pos, Vec3 size_shape, Vec2 ang, Vec2 dir) {
    if (costume == POINT) point(pos) ;
    else if(costume == DISC ) {
      ellipse(pos.x,pos.y,size_shape.x, size_shape.y) ;
    } else if(costume == LINE ) {
      primitive(pos, size_shape.x, 2, ang.x, dir) ;
    } else if(costume == TRIANGLE ) {
      primitive(pos, size_shape.x, 3, ang.x, dir) ;
    } else if(costume == TETRAGON ) {
      primitive(pos, size_shape.x, 4, ang.x, dir) ;
    } else if(costume == RECTANGLE ) {
      rect(pos.x -(size.x/2), pos.y -(size.y/2), size.x, size.y) ;
    } else if(costume == PENTAGON ) {
      primitive(pos, size_shape.x, 5, ang.x, dir) ;
    } else if(costume == HEXAGON ) {
      primitive(pos, size_shape.x, 6, ang.x, dir) ;
    } else if(costume == HEPTAGON ) {
      primitive(pos, size_shape.x, 7, ang.x, dir) ;
    } else if(costume == OCTAGON ) {
      primitive(pos, size_shape.x, 8, ang.x, dir) ;
    } else if(costume == ENNEAGON ) {
      primitive(pos, size_shape.x, 9, ang.x, dir) ;
    } else if(costume == DECAGON ) {
      primitive(pos, size_shape.x, 10, ang.x, dir) ;
    } else if(costume == HENDECAGON ) {
      primitive(pos, size_shape.x, 11, ang.x, dir) ;
    } else if(costume == DODECAGON ) {
      primitive(pos, size_shape.x, 12, ang.x, dir) ;
    } else {
      point(pos) ;
    }
  }

  // end local translation
  // End costume 3D

  // END COSTUME
  //////////////







  //ASPECT
  /////////

  //without effect
  // basic

  /**
  improve methode to check if the stroke must be Stroke or noStroke()
  */
  public void aspect() {
    float thickness = 1 ;
    aspect(colour, colour, thickness) ;
  }

  public void aspect(boolean new_colour_choice) {
    float thickness = 1 ;
    Vec4 color_choice = Vec4() ;
    if(new_colour_choice) color_choice = new_colour.copy() ; else color_choice = colour.copy() ;
    aspect(color_choice, color_choice, thickness) ;
  }

  public void aspect(boolean new_colour_choice, float thickness) {
    Vec4 color_choice = Vec4() ;
    if(new_colour_choice) color_choice = new_colour.copy() ; else color_choice = colour.copy() ;

    if(thickness <= 0) { 
      noStroke() ;
      fill(color_choice.r,color_choice.g,color_choice.b,color_choice.a) ;

    } else { 
      strokeWeight(thickness) ;
      stroke(color_choice.r,color_choice.g,color_choice.b,color_choice.a) ;
      fill(color_choice.r,color_choice.g,color_choice.b,color_choice.a) ;
    }
  }

  public void aspect(float thickness) {
    if(thickness <= 0) { 
      noStroke() ;
      fill(colour.r,colour.g,colour.b,colour.a) ;

    } else { 
      strokeWeight(thickness) ;
      stroke(colour.r,colour.g,colour.b,colour.a) ;
      fill(colour.r,colour.g,colour.b,colour.a) ;
    }
  }

  public void aspect(int c) {
    float thickness = 1 ;
    Vec4 color_pix = int_color_to_vec4_color(c).copy() ;
    aspect(color_pix, color_pix, thickness) ;
  }

  public void aspect(Vec4 color_pix) {
    float thickness = 1 ;
    aspect(color_pix, color_pix, thickness) ;
  }

  public void aspect(Vec4 color_pix, float thickness) {
    aspect(color_pix, color_pix, thickness) ;
  }
  
  
  // main method aspect
  public void aspect(Vec4 color_fill, Vec4 color_stroke, float thickness) {
    if(color_fill.a <= 0 && color_stroke.a <= 0) {
      noStroke() ; 
      noFill() ;
    } else {
      if (renderer_P3D()) {
        // stroke part
        if(thickness <= 0 || color_stroke.a <= 0 ) noStroke() ; else {
          if(costume == POINT ) {
            println("Costume is POINT, the Vec size is used for the strokeWeight") ;
            strokeWeight((size.x + size.y + size.z)/3) ; 
          } else strokeWeight(thickness) ;
          stroke(color_stroke.r, color_stroke.g, color_stroke.b, color_stroke.a) ;
        }
        // fill part
        if (color_fill.a <= 0 ) noFill() ; else fill(color_fill.r,color_fill.g, color_fill.b, color_fill.a) ;
      } else {
        // stroke part
        if(thickness <= 0 || color_stroke.a <= 0 ) noStroke() ; 
        else {
          if(costume == POINT ) { 
            strokeWeight((size.x + size.y + size.z)/3) ;
            println("Costume is POINT, the diameter is used for the strokeWeight") ;
          } else strokeWeight(thickness) ;
          stroke(color_stroke.r, color_stroke.g, color_stroke.b, color_stroke.a) ;
        }
        // fill part
        if (color_fill.a <= 0 ) noFill() ; else fill(color_fill.r,color_fill.g, color_fill.b, color_fill.a) ;
      }
    }
  }




  //with effect
  /**
  Methode must be refactoring, very weird
  */
  /*
  void aspect(int diam, PVector effectColor) {
    strokeWeight(diam) ;
    stroke(new_colour.r, effectColor.x *new_colour.g, effectColor.y *new_colour.b, effectColor.z *new_colour.a) ;
  }
  */
  // END ASPECT
  /////////////
  
  
  
  
  
    // CHANGE COLOR
  ////////////////
  //direct change HSB
  public void change_hue(int new_hue, int target_color, boolean use_new_colour) {
    change_hue(new_hue, target_color, target_color +1, use_new_colour) ;
  }
  public void change_saturation(int new_sat, int target_color, boolean use_new_colour) {
    change_saturation(new_sat, target_color, target_color +1, use_new_colour) ;
  }
  public void change_brightness(int new_bright, int target_color, boolean use_new_colour) {
    change_brightness(new_bright, target_color, target_color +1, use_new_colour) ;
  }
  //direct change RGB
  public void change_red(int new_red, int target_color, boolean use_new_colour) {
    change_red(new_red, target_color, target_color +1, use_new_colour) ;
  }
  public void change_green(int new_green, int target_color, boolean use_new_colour) {
    change_green(new_green, target_color, target_color +1, use_new_colour) ;
  }
  public void change_blue(int new_blue, int target_color, boolean use_new_colour) {
    change_blue(new_blue, target_color, target_color +1, use_new_colour) ;
  }
  //direct change ALPHA
  public void change_alpha(int new_alpha, int target_color, boolean use_new_colour) {
    change_alpha(new_alpha, target_color, target_color +1, use_new_colour) ;
  }
  
  // change with range
  // HSB change
  public void change_hue(int new_hue, int start, int end, boolean use_new_colour) {
    float hue_temp ; ;
    if(!use_new_colour) hue_temp = change_color_component_from_specific_component("hue", colour.r, new_hue, start, end) ; 
    else hue_temp = change_color_component_from_specific_component("hue", new_colour.r, new_hue, start, end) ;
    new_colour = Vec4(hue_temp, new_colour.y, new_colour.z, new_colour.w)  ;
  }
  public void change_saturation(int new_saturation, int start, int end, boolean use_new_colour) {
    float saturation_temp ;
    if(!use_new_colour) saturation_temp = change_color_component_from_specific_component("saturation", colour.g, new_saturation, start, end) ;
    else saturation_temp = change_color_component_from_specific_component("saturation", new_colour.g, new_saturation, start, end) ;
    new_colour = Vec4(new_colour.x, saturation_temp, new_colour.z, new_colour.w)  ;
  }
  public void change_brightness(int new_brightness, int start, int end, boolean use_new_colour) {
    float brightness_temp ;
    if(!use_new_colour) brightness_temp = change_color_component_from_specific_component("brightness", colour.b, new_brightness, start, end) ;
    else brightness_temp = change_color_component_from_specific_component("brightness", new_colour.b, new_brightness, start, end) ;
    new_colour = Vec4(new_colour.x, new_colour.y, brightness_temp, new_colour.w)  ;
  }
  // RGB change
  public void change_red(int new_red, int start, int end, boolean use_new_colour) {
    float red_temp ;
    if(!use_new_colour) red_temp = change_color_component_from_specific_component("red", colour.r, new_red, start, end) ;
    else red_temp = change_color_component_from_specific_component("red", new_colour.r, new_red, start, end) ;
    new_colour = Vec4(red_temp, new_colour.y, new_colour.z, new_colour.w)  ;
  }
  public void change_green(int new_green, int start, int end, boolean use_new_colour) {
    float green_temp ;
    if(!use_new_colour) green_temp = change_color_component_from_specific_component("green", colour.g, new_green, start, end) ;
    else green_temp = change_color_component_from_specific_component("green", new_colour.g, new_green, start, end) ;
    new_colour = Vec4(new_colour.x, green_temp, new_colour.z, new_colour.w)  ;
  }
  public void change_blue(int new_blue, int start, int end, boolean use_new_colour) {
    float blue_temp ;
    if(!use_new_colour) blue_temp = change_color_component_from_specific_component("blue", colour.b, new_blue, start, end) ;
    else blue_temp = change_color_component_from_specific_component("blue", new_colour.b, new_blue, start, end) ;
    new_colour = Vec4(new_colour.x, new_colour.y, blue_temp, new_colour.w)  ;
  }

  // ALPHA change
  public void change_alpha(int new_alpha, int start, int end, boolean use_new_colour) {
    float alpha_temp ;
    if(!use_new_colour) alpha_temp = change_color_component_from_specific_component("alpha", colour.a, new_alpha, start, end) ;
    else alpha_temp = change_color_component_from_specific_component("alpha", new_colour.a, new_alpha, start, end) ;
    new_colour = Vec4(new_colour.x, new_colour.y, new_colour.z, alpha_temp)  ;
  }



  // INTERNAL method to change color
  public float change_color_component_from_specific_component (String which_component, float original_component, int new_component, int start_range, int end_range) {
    if (start_range < end_range ) {
      if(original_component >= start_range && original_component <= end_range) original_component = new_component ; 
    } else if (start_range > end_range) {
      if( (original_component >= start_range && original_component <= roof(which_component)) || original_component <= end_range) { 
        original_component = new_component ;
      }
    }        
    return original_component ;
  }
  
  //
  public float roof(String which_component) {
    float roof = 1 ;
    switch(which_component) {
      case "HUE" : roof = g.colorModeX ; break ; 
      case "SATURATION" : roof = g.colorModeY ; break ; 
      case "BRIGHTNESS" : roof = g.colorModeZ ; break ; 
      case "RED" : roof = g.colorModeX ; break ; 
      case "GREEN" : roof = g.colorModeY ; break ; 
      case "BLUE" :  roof = g.colorModeZ ; break ;
      case "ALPHA" :  roof = g.colorModeA ; break ; 

      case "hue" :  roof = g.colorModeX ; break ; 
      case "saturation" :  roof = g.colorModeY ; break ; 
      case "brightness" :  roof = g.colorModeZ ; break ;  
      case "red" :  roof = g.colorModeX ; break ; 
      case "green" :  roof = g.colorModeY ; break ; 
      case "blue" :  roof = g.colorModeZ ; break ;
      case "alpha" :  roof = g.colorModeA ; break ; 

      case "Hue" :  roof = g.colorModeX ; break ;  
      case "Saturation" :  roof = g.colorModeY ; break ;  
      case "Brightness" :  roof = g.colorModeZ ; break ; 
      case "Red" :  roof = g.colorModeX ; break ; 
      case "Green" :  roof = g.colorModeY ; break ; 
      case "Blue" :  roof = g.colorModeZ ; break ; 
      case "Alpha" :  roof = g.colorModeA ; break ;
    }
    return roof ;
  }
}
// END MOTHER CLASS
//////////////////////

















/**

// CHILD CLASS
////////////////
*/
/**
// PIXEL CLOUD
/////////////////////
*/
class Pixel_cloud extends Pix implements Pixel_Constants {
  int num ;
  float beat_ref = .001f ;
  float beat = .001f ;
  String pattern = "RADIUS" ;
  Vec3 [] point, point_normal ;
  String cloud_2D_or_3D, order_or_Chaos ;
  boolean polar_build = false ;

  Vec3 orientation = Vec3(0,PI/2,0) ; 
  float radius = 1 ;
  




  Pixel_cloud(int num, String cloud_2D_or_3D, String order_or_Chaos) {
    init_mother_arg() ;
    this.num = num ;
    this.cloud_2D_or_3D = cloud_2D_or_3D ;
    this.order_or_Chaos = order_or_Chaos ;
    point = new Vec3[num] ;
    point_normal = new Vec3[num] ;
    init(cloud_2D_or_3D, order_or_Chaos) ;
  }
  
  /*
  Use this constructor if you want build a cartesian sphere with a real coord in the 3D space, you must ask a "POINT" costume
  */
  Pixel_cloud(int num, String cloud_2D_or_3D, String order_or_Chaos, String build) {
    init_mother_arg() ;
    if(build == "POLAR") polar_build = true ; else polar_build = false ;
    this.num = num ;
    this.cloud_2D_or_3D = cloud_2D_or_3D ;
    this.order_or_Chaos = order_or_Chaos ;
    point = new Vec3[num] ;
    point_normal = new Vec3[num] ;
    init(cloud_2D_or_3D, order_or_Chaos) ;
    costume = DISC ;
  }

/**
  // BUILD
  //////////
*/
    // internal method
  public void init(String cloud_2D_or_3D, String order_or_Chaos) {
    if(cloud_2D_or_3D == "2D") cartesian_pos_2D(order_or_Chaos) ; else {
      if(polar_build) polar_pos_3D(order_or_Chaos) ;  else cartesian_pos_3D(order_or_Chaos) ; 
    }
  }


    public void cartesian_pos_2D(String order_or_chaos) {
    float angle = TAU / num ;
    float tetha  = angle ;
    for(int i = 0 ; i < num ; i++ ) {
      if(order_or_chaos == "ORDER") point_normal[i] = Vec3(cos(tetha),sin(tetha), 0 ) ; else {
        tetha  = random(-PI, PI) ;
        point_normal[i] = Vec3(cos(tetha),sin(tetha), 0 ) ;
      }
      tetha += angle ;
    }
  }

  public void cartesian_pos_3D(String order_or_chaos) {
    if(order_or_chaos == "ORDER") {
      // sted and root maybe must be define somewhere ????
      float step = PI * (3 - sqrt(5.f)) ; 
      float root = PI ;
      point_normal = list_cartesian_fibonacci_sphere (num, step, root) ;
    } else {
      for(int i = 0 ; i < point.length ; i++ ) {
        float tetha  = random(-PI, PI) ;
        float phi  = random(-TAU, TAU) ;
        point_normal[i] = Vec3(cos(tetha) *cos(phi),
                        cos(tetha) *sin(phi), 
                        sin(tetha) ) ; 
      }
    }
  }


  public void polar_pos_3D(String order_or_chaos) {
    float step = TAU ;
    if(order_or_chaos == "ORDER") {
      for (int i = 0; i < point_normal.length ; i++) {
        
        point[i] = Vec3() ;
        point[i].x = distribution_polar_fibonacci_sphere(i, num, step).x ;
        point[i].y = distribution_polar_fibonacci_sphere(i, num, step).y ;
        point[i].z = 0  ;
      }
    } else {
      for (int i = 0; i < point_normal.length ; i++) {
        int which = floor(random(num)) ;
        point[i] = Vec3() ;
        point[i].x = distribution_polar_fibonacci_sphere(which, num, step).x ;
        point[i].y = distribution_polar_fibonacci_sphere(which, num, step).y ;
        point[i].z = 0  ;
      }
    }
  }
  /**
  END BUILD
  */






  // DISPLAY
  //////////////
  
  // external method
  public void beat(int n) {
    this.beat = beat_ref *n ;
  }


   // return list of point
  public Vec3 [] list() {
    return point ;
  }
  // change orientation
  public void orientation(Vec3 orientation) {
    this.orientation = orientation ;
  }

   public void orientation(float x, float y, float z) {
    this.orientation = Vec3(x,y,z) ;
  }

  public void orientation_x(float orientation_x) {
    this.orientation = Vec3(orientation_x,0,0) ;
  }
  public void orientation_y(float orientation_y) {
    this.orientation = Vec3(0,orientation_y,0) ;
  }
  public void orientation_z(float orientation_z) {
    this.orientation = Vec3(0,0,orientation_z) ;
  }



  // angle
  public void angle(float angle) {
    if(costume != RECTANGLE ) this.angle = Vec2(angle,0) ; else println("This method don't work with 'RECTANGLE' because it's basic processing shape") ;
  }


  public void pattern(String pattern) {
    this.pattern = pattern ;
  }


/**
  // distribution inside
  */
  /*
  void distribution_inside(Vec3 pos, int radius) {
    this.pos = pos ;
    float new_radius = radius  ;
    for (int i = 0 ; i < point.length ; i++) {
      point[i] = point_normal[i].copy() ;
      new_radius = distribution_pattern(radius, pattern) ;
      point[i].mult(new_radius) ;
      point[i].add(pos) ;
    }
  }
  */
  
/*
  void distribution_inside(Vec3 pos, int radius, String pattern_distribution) {
    float new_radius = radius  ;
    for (int i = 0 ; i < point.length ; i++) {
      point[i] = point_normal[i].copy() ;
      new_radius = distribution_pattern(radius, pattern_distribution) ;
      point[i].mult(new_radius) ;
      point[i].add(pos) ;
    }
  }
  */
  /**
  distribution_surface
  */
  public void distribution(Vec3 pos, float radius) {
    this.pos = pos ;
    this.radius = radius ;
    if(polar_build)  distribution_surface_polar() ; else distribution_surface_cartesian() ;
  }
  // distribution surface cartesian

  public void distribution_surface_polar() {
    if(pattern != "RADIUS") radius = abs(distribution_pattern(radius, pattern)) ;
  }

 // distribution surface cartesian
 public void distribution_surface_cartesian() {

    float radius_temp = radius  ;
    for (int i = 0 ; i < point.length ; i++) {
      point[i] = point_normal[i].copy() ;
      if(pattern != "RADIUS") radius_temp = distribution_pattern(radius, pattern) ;
      point[i].mult(radius_temp) ;
      point[i].add(pos) ;
    }
  }
  
  /**
  distribution pattern
  */
  // internal method
  public float distribution_pattern(float range, String pattern_distribution) {
    float pos = 1 ;
    float normal_distribution = 1 ;
    
    float root_1 = 0 ;
    float root_2 = 0 ;
    float root_3 = 0 ;
    float root_4 = 0 ;
     if(pattern_distribution.contains("RANDOM")) {
      root_1 = random(1) ;
      if(pattern_distribution.contains("2") || pattern_distribution.contains("3") || pattern_distribution.contains("4")|| pattern_distribution.contains("SPECIAL")) {
        root_2 = random(1) ;
        root_3 = random(1) ;
        root_4 = random(1) ;
      }
    }

    float t = 0 ;
    if(pattern_distribution.contains("SIN") || pattern_distribution.contains("COS")) t = frameCount *beat ;
    float factor_1_2 = 1.2f ;
    float factor_0_5 = .5f ;
    float factor_12_0 = 12.f ;
    float factor_10_0 = 10.f ;
    
    if(pattern_distribution == "RANDOM") normal_distribution = root_1 ;
    else if(pattern_distribution == "ROOT_RANDOM") normal_distribution = sqrt(root_1) ;
    else if(pattern_distribution == "QUARTER_RANDOM") normal_distribution = 1 -(.25f *root_1) ;
    
    else if(pattern_distribution == "2_RANDOM") normal_distribution = root_1 *root_2 ;

    else if(pattern_distribution == "3_RANDOM") normal_distribution = root_1 *root_2 *root_3 ;

    else if(pattern_distribution == "4_RANDOM") normal_distribution = root_1 *root_2 *root_3 *root_4 ;
    else if(pattern_distribution == "SPECIAL_A_RANDOM") normal_distribution = .25f *( root_1 +root_2 +root_3 +root_4) ;
    else if(pattern_distribution == "SPECIAL_B_RANDOM") {
      float temp = root_1 -root_2 +root_3 -root_4 ;
      if(temp < 0) temp += 4 ;
      normal_distribution = .25f *temp ;
    }

    else if(pattern_distribution == "SIN") normal_distribution = sin(t) ;
    else if(pattern_distribution == "COS") normal_distribution = cos(t) ;
    else if(pattern_distribution == "SIN_TAN_COS") normal_distribution = sin(tan(cos(t) *factor_1_2)) ;
    else if(pattern_distribution == "SIN_TAN") normal_distribution = sin(tan(t)*factor_0_5) ;
    else if(pattern_distribution == "SIN_POW_SIN") normal_distribution = sin(pow(8.f,sin(t))) ;
    else if(pattern_distribution == "POW_SIN_PI") normal_distribution = pow(sin((t) *PI), factor_12_0) ;
    else if(pattern_distribution == "SIN_TAN_POW_SIN") normal_distribution = sin(tan(t) *pow(sin(t),factor_10_0)) ;



    pos = range *normal_distribution ;
    return pos ;
  }
  
  
  
  
  
  
  


 



 
  
  
  
  /**
  // COSTUME and display
  // child method
  */

  public void costume() {
    costume(this.costume) ;
  }
  public void costume(String costume) {
    this.costume = costume ;
    if (renderer_P3D()) give_points_to_costume_3D() ; else  give_points_to_costume_2D() ;
  }
  
  // local method
  public void give_points_to_costume_2D() {
    for(int i  = 0 ; i < point.length ;i++) {
      // method from mother class need pass info arg
      costume_2D(point[i], size, angle) ;
    }
  }
  public void give_points_to_costume_3D() {
    if(!polar_build) {
      for(int i  = 0 ; i < point.length ;i++) {
        // method from mother class need pass info arg
        costume_3D(point[i], size, angle,point_normal[i]) ;
      }
    } else {
      // method from here don't need to pass info about arg
      costume_3D_local_polar() ;
    }
  }
  
  // internal
  public void costume_3D_local_polar() {
   matrix_start() ;
   translate(pos) ;
    for(int i = 0 ; i < num ;i++) {
      matrix_start() ;
      /**
      super effect
      float rot = (map(mouseX,0,width,-PI,PI)) ;
      dir_pol[i].y += rot ;
      */
      rotateYZ(Vec2(point[i].x,point[i].y)) ;

      Vec3 pos_primitive = Vec3(radius,0,0) ;
      translate(pos_primitive) ;

      matrix_start() ;
      rotateXYZ(orientation) ;
    //  int summits = 5 ;
      Vec3 pos_local_primitive = Vec3() ;
      Vec2 orientation_polar = Vec2() ;
      costume_3D(pos_local_primitive, size, angle, orientation_polar) ;
      matrix_end() ;
      matrix_end() ;
    }
   matrix_end() ;

  }
  /**
  // END COSTUME
  */
}
/**
END CLASS PIXEL CLOUD
*/














/**
Class pixel Basic

*/
class Pixel extends Pix implements Pixel_Constants {
  // CONSTRUCTOR
  
  // PIXEL 2D
  Pixel(Vec2 pos_2D) {
    init_mother_arg() ;
    this.pos = new Vec3(pos_2D.x,pos_2D.y, 0)  ;
  }

  Pixel(Vec2 pos_2D, Vec2 size_2D) {
    init_mother_arg() ;
    this.pos = new Vec3(pos_2D.x,pos_2D.y, 0)  ;
    this.size = new Vec3(size_2D.x,size_2D.y,0) ; ;
  }
  
  // Constructor plus color components
  Pixel(Vec2 pos_2D, Vec4 color_vec) {
    init_mother_arg() ;
    this.pos = new Vec3(pos_2D.x,pos_2D.y, 0)  ;
    colour = color_vec.copy() ;
    new_colour = colour.copy() ;
    
  }

  Pixel(Vec2 pos_2D, Vec2 size_2D, Vec4 color_vec) {
    init_mother_arg() ;
    this.pos = new Vec3(pos_2D.x,pos_2D.y, 0)  ;
    this.size = new Vec3(size_2D.x,size_2D.y,0) ;
    colour = color_vec.copy() ;
    new_colour = colour.copy() ;
  }

  // Constructor with costume indication
  Pixel(Vec2 pos_2D, Vec2 size_2D, String costume) {
    init_mother_arg() ;
    this.costume = costume ;
    this.pos = new Vec3(pos_2D.x,pos_2D.y, 0)  ;
    this.size = new Vec3(size_2D.x,size_2D.y,0) ; ;
  }
  
  // Constructor plus color components
  Pixel(Vec2 pos_2D, Vec4 color_vec, String costume) {
    init_mother_arg() ;
    this.costume = costume ;
    this.pos = new Vec3(pos_2D.x,pos_2D.y, 0)  ;
    colour = color_vec.copy() ;
    new_colour = colour.copy() ;
    
  }

  Pixel(Vec2 pos_2D, Vec2 size_2D, Vec4 color_vec, String costume) {
    init_mother_arg() ;
    this.costume = costume ;
    this.pos = new Vec3(pos_2D.x,pos_2D.y, 0)  ;
    this.size = new Vec3(size_2D.x,size_2D.y,0) ;
    colour = color_vec.copy() ;
    new_colour = colour.copy() ;
  }

  // Constructor with costume indication
  Pixel(Vec2 pos_2D, Vec2 size_2D, int summits) {
    init_mother_arg() ;
    choice_costume(summits) ;
    this.pos = new Vec3(pos_2D.x,pos_2D.y, 0)  ;
    this.size = new Vec3(size_2D.x,size_2D.y,0) ; ;
  }
  
  // Constructor plus color components
  Pixel(Vec2 pos_2D, Vec4 color_vec, int summits) {
    init_mother_arg() ;
    choice_costume(summits) ;
    this.pos = new Vec3(pos_2D.x,pos_2D.y, 0)  ;
    colour = color_vec.copy() ;
    new_colour = colour.copy() ;
    
  }

  Pixel(Vec2 pos_2D, Vec2 size_2D, Vec4 color_vec, int summits) {
    init_mother_arg() ;
    choice_costume(summits) ;
    this.pos = new Vec3(pos_2D.x,pos_2D.y, 0)  ;
    this.size = new Vec3(size_2D.x,size_2D.y,0) ;
    colour = color_vec.copy() ;
    new_colour = colour.copy() ;
  }


  //PIXEL 3D
  Pixel(Vec3 pos_3D) {
    init_mother_arg() ;
    this.pos = pos_3D  ;
  }

  Pixel(Vec3 pos_3D, Vec3 size_3D) {
    init_mother_arg() ;
    this.pos = pos_3D ;
    this.size = size_3D ;
  }
  // constructor plus color component
  Pixel(Vec3 pos_3D,  Vec4 color_vec) {
    init_mother_arg() ;
    this.pos = pos_3D ;
    colour = color_vec.copy() ;
    new_colour = colour.copy() ;
  }
  
  Pixel(Vec3 pos_3D, Vec3 size_3D, Vec4 color_vec) {
    init_mother_arg() ;
    this.pos = pos_3D ;
    this.size = size_3D ;
    colour = color_vec.copy() ;
    new_colour = colour.copy() ;
  }

  // with costume indication
  Pixel(Vec3 pos_3D, Vec3 size_3D, String costume) {
    init_mother_arg() ;
    this.costume = costume ;
    this.pos = pos_3D ;
    this.size = size_3D ;
  }
  // constructor plus color component
  Pixel(Vec3 pos_3D,  Vec4 color_vec, String costume) {
    init_mother_arg() ;
    this.costume = costume ;
    this.pos = pos_3D ;
    colour = color_vec.copy() ;
    new_colour = colour.copy() ;
  }
  
  Pixel(Vec3 pos_3D, Vec3 size_3D, Vec4 color_vec, String costume) {
    init_mother_arg() ;
    this.costume = costume ;
    this.pos = pos_3D ;
    this.size = size_3D ;
    colour = color_vec.copy() ;
    new_colour = colour.copy() ;
  }

  // with costume indication
  Pixel(Vec3 pos_3D, Vec3 size_3D, int summits) {
    init_mother_arg() ;
    choice_costume(summits) ;
    this.pos = pos_3D ;
    this.size = size_3D ;
  }
  // constructor plus color component
  Pixel(Vec3 pos_3D,  Vec4 color_vec, int summits) {
    init_mother_arg() ;
    choice_costume(summits) ;
    this.pos = pos_3D ;
    colour = color_vec.copy() ;
    new_colour = colour.copy() ;
  }
  
  Pixel(Vec3 pos_3D, Vec3 size_3D, Vec4 color_vec, int summits) {
    init_mother_arg() ;
    choice_costume(summits) ;
    this.pos = pos_3D ;
    this.size = size_3D ;
    colour = color_vec.copy() ;
    new_colour = colour.copy() ;
  }



  



  
  //RANK PIXEL CONSTRUCTOR
  Pixel(int rank) {
    init_mother_arg() ;
    this.rank = rank ;
  }
  
  Pixel(int rank, Vec2 grid_position_2D) {
    init_mother_arg() ;
    this.rank = rank ;
    this.grid_position = new Vec3(grid_position_2D.x,grid_position_2D.y,0) ;
  }
  Pixel(int rank, Vec3 grid_position) {
    init_mother_arg() ;
    this.rank = rank ;
    this.grid_position = grid_position ;
  }
  

  public void choice_costume(int summits) {
    if(summits == 1) this.costume = "POINT" ;
    else if(summits == 2) this.costume = "LINE" ;
    else if(summits == 3) this.costume = "TRI" ;
    else if(summits == 4) this.costume = "SQUARE" ;
    else if(summits == 5) this.costume = "PENTA" ;
    else if(summits == 6) this.costume = "HEXA" ;
    else if(summits == 7) this.costume = "HEPTA" ;
    else if(summits == 8) this.costume = "OCTA" ;
    else if(summits == 9) this.costume = "ENNE" ;
    else if(summits == 10) this.costume = "DECA" ;
    else if(summits == 11) this.costume = "HENDE" ;
    else if(summits == 12) this.costume = "DODE" ;
    else if(summits > 12) this.costume = "DISC" ;
  }




   


  // METHOD
  ///////////////

  // COSTUME
  // child method
  public void costume() {
    if (renderer_P3D()) {
      costume_3D(pos, size, angle, dir) ;
    } else {
      costume_2D(pos, size, angle) ;
    }
  }

  public void costume(String costume) {
    this.costume = costume ;
    costume() ;
  }
}
// END CLASS PIXEL
/////////////////
























// PIXEL MOTION
///////////////
class Pixel_motion extends Pix implements Pixel_Constants {
    /**
    Not sure I must keep the arg field and life
  */
  float field = 1.0f ;
  float life = 1.0f ;


    //INK CONSTRUCTOR
  /**
  Pixel(Vec2 pos_2D, float field, int color_pixel_in_int) {
    init_mother_arg() ;
    this.pos_2D = pos_2D ;
    this.field = field ;
    this.color_pixel_in_int = color_pixel_in_int ;
    colour = int_color_to_vec4_color(color_pixel_in_int).copy() ;
  }
  Pixel(Vec2 pos_2D, float field) {
    init_mother_arg() ;
    this.pos_2D = pos_2D ;
    this.field = field ;
  }
  */




  
  // DRYING
  //drying is like jitter but with time effect, it's very subtil so we use a float timer.
    // classic
  public void stop_motion_2D(float timePast) {
  }
  
  
  
  /**
  This part must be refactoring, is really a confusing way to code
  For example why we use PImage ????
  Why do we use 'wind', can't we use 'motion' instead ????
  
  //UPDATE POSITION with the wind
  void update_position_2D(PVector effectPosition, PImage pic) {
    Vec2 dir_2D = norm_dir("DEG",effectPosition.x) ;
    
    velocity_2D = Vec2 (  1.0 *dir_2D.x *effectPosition.y  + random(-effectPosition.z) ,
                      1.0 *dir_2D.y *effectPosition.y  + random(-effectPosition.z))   ;
    pos_2D.add(wind_2D) ;
    //keep the pixel in the scene
    if (pos_2D.x< 0)          pos_2D.x= pic.width;
    if (pos_2D.x> pic.width)  pos_2D.x=0;
    if (pos_2D.y< 0)          pos_2D.y= pic.height;
    if (pos_2D.y> pic.height) pos_2D.y=0;
  }
  
  
  
  //return position with display size
  Vec2 position_2D(PVector effectPosition, PImage pic) {
    Vec2 dir_2D = norm_dir("DEG",effectPosition.x) ;

    new_pos_2D = pos_2D.copy() ;
    
    direction_2D = Vec2 (  1.0 *dir_2D.x *effectPosition.y  + random(-effectPosition.z, effectPosition.z) ,
                      1.0 *dir_2D.y *effectPosition.y  + random(-effectPosition.z, effectPosition.z))   ;
                  
    new_pos_2D.add(wind_2D) ;
    //keep the pixel in the scene
    if (new_pos_2D.x< 0)          new_pos_2D.x= pic.width;
    if (new_pos_2D.x> pic.width)  new_pos_2D.x=0;
    if (new_pos_2D.y< 0)          new_pos_2D.y= pic.height;
    if (new_pos_2D.y> pic.height) new_pos_2D.y=0;
    
    return new_pos_2D ;
  }
  */
  /**
  End of method who must be refactoring
  */
}
/**
Class RPEsvg 1.1.0
RPE \u2013 Romanesco Processing Environment \u2013 
* @author Stan le Punk
* @see other Processing work on https://github.com/StanLepunK
*/

class RPEsvg {
  PShape shape_SVG ;
  String path = "" ;
  String name = "" ;
  ArrayList<Brick_SVG> list_brick_SVG = new ArrayList<Brick_SVG>() ;
  String header_svg = "" ;
  int ID_brick ;
  String saved_path_svg = "" ;

  boolean bool_pos_svg, bool_jitter_svg, bool_scale_svg ;
  boolean keep_change ;

  boolean display_fill_original = true ;
  boolean display_stroke_original = true ;
  boolean display_thickness_original = true ;

  boolean display_fill_custom = false ;
  boolean display_stroke_custom = false ;
  boolean display_thickness_custom = false ;
  // 2D var
  Vec2 pos_svg_2D = Vec2() ;
  Vec2 jitter_svg_2D = Vec2() ;
  Vec2 scale_svg_2D = Vec2() ;
  // 3D var
  Vec3 pos_svg_3D = Vec3() ;
  Vec3 jitter_svg_3D = Vec3() ;
  Vec3 scale_svg_3D = Vec3() ;

  // Aspect default
  Vec4 fill_custom = Vec4(0,0,0,g.colorModeA) ;
  Vec4 stroke_custom = Vec4(g.colorModeX,g.colorModeY,g.colorModeZ,g.colorModeA) ;
  float thickness_custom = 1 ;

  Vec4 fill_factor = Vec4(1) ;
  Vec4 stroke_factor = Vec4(1) ;






  /**  
  CONSTRUCTOR

  */
  RPEsvg(String path, String name) {
    this.name = name ;
    this.path = path ;
    saved_path_svg = "RPE_SVG/" + name + "/" ;
    // build() ;
  }
  

  
  








  /**
  PUBLIC METHOD

  */

  public void build() {
    list_brick_SVG.clear() ;
    list_ellipse_SVG.clear() ;
    list_rectangle_SVG.clear() ;
    list_vertice_SVG.clear() ;

    shape_SVG = loadShape(path) ;
    // name_SVG = shape_SVG.getName() ;
    // list_vertex(shape_SVG, name_SVG) ;
    XML svg_info = loadXML(path) ;
    analyze_SVG(svg_info) ;
    save_brick_SVG() ;
    build_SVG(list_brick_SVG) ;
  } 
  /**
  METHOD to draw all the SVG
  */
  
  // PUBLIC METHOD 2D
  public void draw_2D() {
    reset() ;
    draw_SVG (pos_svg_2D, scale_svg_2D, jitter_svg_2D) ;
    change_boolean_to_false() ;
  }
  
  public void draw_2D(int ID) {
    reset() ;
    draw_SVG (pos_svg_2D, scale_svg_2D, jitter_svg_2D, ID) ;
    change_boolean_to_false() ;
  }

  public void draw_2D(String layer_or_group_name) {
    reset() ;
    draw_SVG (pos_svg_2D, scale_svg_2D, jitter_svg_2D, layer_or_group_name) ;
    change_boolean_to_false() ;
  }
  
  /**
  // PUBLIC METHOD 3D
  */
  public void draw_3D() {
    reset() ;
    draw_SVG (pos_svg_3D, scale_svg_3D, jitter_svg_3D) ;
    change_boolean_to_false() ;
  }
  
  public void draw_3D(int ID) {
    reset() ;
    draw_SVG (pos_svg_3D, scale_svg_3D, jitter_svg_3D, ID) ;
    change_boolean_to_false() ;  
  }
  

  
  /**
  TEMPORARY CHANGE
  This change don't modify the original coord of point
  */
  // 2D
  public void pos(Vec2 pos) {
    bool_pos_svg = true ;
    pos_svg_2D.set(pos) ;
  }
  public void pos(float x, float y) {
    bool_pos_svg = true ;
    pos_svg_2D.set(x,y) ;
  }
  public void scale(Vec2 scale) {
    bool_scale_svg = true ;
    scale_svg_2D.set(scale) ;
  }
  public void scale(float x, float y) {
    bool_scale_svg = true ;
    scale_svg_2D.set(x,y) ;
  }

  public void jitter(Vec2 jitter) {
    bool_jitter_svg = true ;
    jitter_svg_2D.set(jitter) ;
  }
  public void jitter(int x, int y) {
    bool_jitter_svg = true ;
    jitter_svg_2D.set(x,y) ;
  }
  // 3D
  public void pos(Vec3 pos) {
    bool_pos_svg = true ;
    pos_svg_3D.set(pos) ;
  }
  public void pos(float x, float y, float z) {
    bool_pos_svg = true ;
    pos_svg_3D.set(x,y,z) ;
  }
  public void scale(Vec3 scale) {
    bool_scale_svg = true ;
    scale_svg_3D.set(scale) ;
  }
  public void scale(float x, float y, float z) {
    bool_scale_svg = true ;
    scale_svg_3D.set(x,y,z) ;
  }
  public void jitter(Vec3 jitter) {
    bool_jitter_svg = true ;
    jitter_svg_3D.set(jitter) ;
  }
  public void jitter(int x, int y, int z) {
    bool_jitter_svg = true ;
    jitter_svg_3D.set(x,y,z) ;
  }
  
  
  
  /* 
  method start() & end() use in correlation with reset for the change like jitter, pos, scale...
  when the svg is using in split mode with name or ID param
  */
  public void start() {
    keep_change = true ;
  }
  public void end() {
    keep_change = false ;
    reset() ;
  }


  /**
  ASPECT
  */

  public void original_style(boolean fill, boolean stroke) {
    display_fill_original = fill ;
    display_stroke_original = stroke ;
    display_thickness_original = stroke ;
  }

  public void original_fill(boolean fill) {
    display_fill_original = fill ;
  }

  public void original_stroke(boolean stroke) {
    display_stroke_original = stroke ;
    display_thickness_original = stroke ;
  }

  public void fill_custom(int x, int y, int z, int a) {
    display_fill_original = false ;
    display_fill_custom = true ;
    fill_custom.set(x,y,z,a) ;
  }

  public void stroke_custom(int x, int y, int z, int a) {
    display_stroke_original = false ;
    display_stroke_custom = true ;
    stroke_custom.set(x,y,z,a) ;
  }

  public void thickness_custom(float x) {
    display_thickness_original = false ;
    display_thickness_custom = true ;
    thickness_custom = x ;
  }

  public void fill_factor(float x, float y, float z, float a) {
    fill_factor.set(x,y,z,a) ;
  }

  public void stroke_factor(float x, float y, float z, float a) {
    stroke_factor.set(x,y,z,a) ;
  }

  public void fill_factor(Vec4 f) {
    fill_factor.set(f.x,f.y,f.z,f.a) ;
  }

  public void stroke_factor(Vec4 f) {
    stroke_factor.set(f.x,f.y,f.z,f.a) ;
  }

  /**
  PERMANENTE CHANGE
  This change modify the original points
  */
  public void add_def(int target, Vec3... value) {
    if(list_brick_SVG.size() > 0) {
      Brick_SVG b = (Brick_SVG) list_brick_SVG.get(target) ;
      if(b.kind == "polygon" || b.kind == "path") {
        for(Vertices v : list_vertice_SVG) {
          if(v.ID == b.ID) v.add_value(value) ;
        }
      } 
      else if(b.kind == "circle" || b.kind == "ellipse") {
        for(Ellipse e : list_ellipse_SVG) {
          if(e.ID == b.ID) e.add_value(value) ;
        }
      } 
      else if(b.kind == "rect") {
        for(Rectangle r : list_rectangle_SVG) {
          if(r.ID == b.ID) r.add_value(value) ;
        }
      } 
    } 
  }
  

  /**
  SVG info
  */
  public String name() {
    return name ;
  }
  
  /* return quantity of brick */
  public int num_brick() {
    return list_brick_SVG.size() ;
  }
  

  /*
  list
  */
  public Vec3 [] list_points_of_interest(int target) {
    Vec3 [] p = new Vec3[1] ;
    p[0] = Vec3(2147483647,2147483647,2147483647) ; // it's maximum value of int in 8 bit :)

    if(list_brick_SVG.size() > 0) {
      Brick_SVG b = (Brick_SVG) list_brick_SVG.get(target) ;
      if(b.kind == "polygon" || b.kind == "path") {
        for(Vertices v : list_vertice_SVG) {
          if(v.ID == b.ID) return v.vertices() ;
        }
      } else if(b.kind == "circle" || b.kind == "ellipse") {
        for(Ellipse e : list_ellipse_SVG) {
          if(e.ID == b.ID) {
            p[0] = e.pos ;
            return p ;
          }
        }
      } else if(b.kind == "rect") {
        for(Rectangle r : list_rectangle_SVG) {
          if(r.ID == b.ID) { 
            p[0] = r.pos ;
            return p ;
          }
        }
      } 
    } else return p ;
    return p ;
  }





  /*
  method to return different definition about the brick
  */
  public String [] name_brick() {
    return name_brick_SVG(list_brick_SVG) ;
  }

  public String name_brick(int target) {
    if(list_brick_SVG.size() > 0 && target < list_brick_SVG.size()) {
      Brick_SVG b = (Brick_SVG) list_brick_SVG.get(target) ;
      return b.brick_name ;

    } else return "No idea for this ID !" ;
  }

  public String [] family_brick() {
    return family_brick_SVG(list_brick_SVG) ;
  }
  public String family_brick(int target) {
    if(list_brick_SVG.size() > 0 && target < list_brick_SVG.size()) {
      Brick_SVG b = (Brick_SVG) list_brick_SVG.get(target) ;
      return b.family_name ;

    } else return "No idea for this ID !" ;
  }

  public String [] kind_brick() {
    return kind_brick_SVG(list_brick_SVG) ;
  }
  public String kind_brick(int target) {
    if(list_brick_SVG.size() > 0 && target < list_brick_SVG.size()) {
      Brick_SVG b = (Brick_SVG) list_brick_SVG.get(target) ;
      return b.kind ;

    } else return "No idea for this ID !" ;
  }





  
  




  /**
  Canvas SVG
  */
  public float width() {
    if(shape_SVG != null) return shape_SVG.width ; else return 0;
  }
  public float height() {
    if(shape_SVG != null) return shape_SVG.height ; else return 0;
  }
  
  public Vec2 canvas() {
    if(shape_SVG != null) return Vec2(shape_SVG.width, shape_SVG.height) ; else return Vec2();
  }
  
  
  
  
  
  /**
  Canvas brick SVG
  */
  public float width_brick(int target) {
    if(list_brick_SVG.size() > 0 && target <list_brick_SVG.size()) {
      Brick_SVG b_svg = list_brick_SVG.get(target) ;
      return b_svg.width ; 
    } else return 0 ;
  }

  public float height_brick(int target) {
    if(list_brick_SVG.size() > 0 && target <list_brick_SVG.size()) {
      Brick_SVG b_svg = list_brick_SVG.get(target) ;
      return b_svg.height ; 
    } else return 0 ;
  }
  
  public Vec2 canvas_brick(int target) {
    if(list_brick_SVG.size() > 0 && target <list_brick_SVG.size()) {
      Brick_SVG b_svg = list_brick_SVG.get(target) ;
      return Vec2(b_svg.width, b_svg.height) ;
    } else return Vec2() ;
  }




 /**
  SETTING
  */
  

  
  
  
  boolean position_center = false ;
  public void svg_mode(int mode) {
    // for info CORNER = 0 / CENTER = 3 > Global variable from Processing
    if(mode == 0 ) position_center = false ;
    else if(mode == 3 ) position_center = true ;
    else position_center = false ;
  }
  /**
  // END PUBLIC METHOD


  */
  







  
  
  
  
  
  






  
  
  
  
  
  
  
  
  /**
  PRIVATE METHOD


  */

  /**
  DRAW

  */
  // reset all change to something flat and borring !
  public void reset() {
    if(!keep_change) {
      if(!bool_pos_svg) {
        pos_svg_2D.set(0) ;
        pos_svg_3D.set(0) ;
      }
      if(!bool_jitter_svg) {
        jitter_svg_2D.set(0) ;
        jitter_svg_3D.set(0) ;
      }
      if(!bool_scale_svg) {
        scale_svg_2D.set(1) ;
        scale_svg_3D.set(1) ;
      }
    }
  }
  
  public void change_boolean_to_false() {
    bool_pos_svg = false ;
    bool_scale_svg = false ;
    bool_jitter_svg = false ;
  }
  /**
  Draw all shape
  */
  // INTERN METHOD 2D
  public void draw_SVG(Vec2 pos, Vec2 scale, Vec2 jitter) {
    for(int i = 0 ; i < list_brick_SVG.size() ; i++) {
      Brick_SVG b = (Brick_SVG) list_brick_SVG.get(i) ;
      float average_scale = (scale.x + scale.y) *.5f ;
      aspect(b, average_scale) ;
      display_shape_2D(b, pos, scale, jitter) ;
    }
  }
  
  // INTERN METHOD 3D
  public void draw_SVG (Vec3 pos, Vec3 scale, Vec3 jitter) {
    for(int i = 0 ; i < list_brick_SVG.size() ; i++) {
      Brick_SVG b = (Brick_SVG) list_brick_SVG.get(i) ;
      float average_scale = (scale.x + scale.y + scale.z) *.333f ;
      aspect(b, average_scale) ;
      display_shape_3D(b, pos, scale, jitter) ;
    }
  }
 
  
  /**
  Draw shape by ID
  */
  // 2D
  public void draw_SVG (Vec2 pos, Vec2 scale, Vec2 jitter, int ID) {
    if(ID < list_brick_SVG.size()) {
      Brick_SVG b = (Brick_SVG) list_brick_SVG.get(ID) ;
      float average_scale = (scale.x + scale.y) *.5f ;
      aspect(b, average_scale) ;
      display_shape_2D(b, pos, scale, jitter) ;
    }
  }
  // 3D
  public void draw_SVG (Vec3 pos, Vec3 scale, Vec3 jitter, int ID) {
    if(ID < list_brick_SVG.size()) {
      Brick_SVG b = (Brick_SVG) list_brick_SVG.get(ID) ;
      float average_scale = (scale.x + scale.y + scale.z) *.333f ;
      aspect(b, average_scale) ;
      display_shape_3D(b, pos, scale, jitter) ;
    }
  }
  
  
  
  /**
  Draw shape by name
  */
  // draw all file from shape or group of layer
  // must be factoring is very ligth method :)
  public void draw_SVG (Vec2 pos, Vec2 scale, Vec2 jitter, String layer_name) {
    for(int i = 0 ; i < list_brick_SVG.size() ; i++) {
      Brick_SVG b = (Brick_SVG) list_brick_SVG.get(i) ;
      if( b.family_name.contains(layer_name)) {
        // build_path(pos, scale, jitter, v) ;
        float average_scale = (scale.x + scale.y) *.5f ;
        aspect(b, average_scale) ;
        display_shape_2D(b, pos, scale, jitter) ;
      }
    }
  }
  // 3D
  public void draw_SVG (Vec3 pos, Vec3 scale, Vec3 jitter, String layer_name) {
    for(int i = 0 ; i < list_brick_SVG.size() ; i++) {
      Brick_SVG b = (Brick_SVG) list_brick_SVG.get(i) ;
      if( b.family_name.contains(layer_name)) {
        // build_path(pos, scale, jitter, v) ;
        float average_scale = (scale.x + scale.y) *.5f ;
        aspect(b, average_scale) ;
        display_shape_3D(b, pos, scale, jitter) ;
      }
    }
  }
  /**
  END DRAW METHOD

  */


  /**
  ASPECT
  */
  public void aspect(Brick_SVG b, float scale_thickness) {
    aspect_original(b, scale_thickness) ;
    aspect_custom() ;
  }


  public void aspect_original(Brick_SVG b, float scale_thickness) {
    if(display_fill_original) b.aspect_fill(fill_factor) ; else noFill() ;
    if(display_stroke_original && display_thickness_original) b.aspect_stroke(scale_thickness,stroke_factor) ; else noStroke() ;
  }

  public void aspect_custom() {
    if(fill_custom.a > 0 && display_fill_custom && !display_fill_original) fill(fill_custom.r *fill_factor.x,fill_custom.g *fill_factor.y, fill_custom.b *fill_factor.y, fill_custom.a *fill_factor.w) ; 
    if(stroke_custom.a > 0 || thickness_custom > 0 && display_stroke_custom && !display_stroke_original) {
      stroke(stroke_custom.r *stroke_factor.x,stroke_custom.g *stroke_factor.y,stroke_custom.b *stroke_factor.z, stroke_custom.a *stroke_factor.w) ;
      strokeWeight(thickness_custom) ;
    }
    if(!display_fill_original && !display_fill_custom) noFill() ;
    if(!display_stroke_original && !display_stroke_custom) noStroke() ;
  }



  
  


































  /**
BUILD

  */
  /**
  Display method
  */
  public void display_shape_2D(Brick_SVG b, Vec2 pos, Vec2 scale, Vec2 jitter) {
    if(b.kind == "path" || b.kind == "polygon") {
      for(Vertices v : list_vertice_SVG) {
        if(v.ID == b.ID) build_path(pos, scale, jitter, v) ;
      }
    } else if(b.kind == "ellipse" || b.kind == "circle") {
      for(Ellipse e : list_ellipse_SVG) {
        if(e.ID == b.ID) {
          build_ellipse(pos, scale, jitter, e) ;
        }
      }
    } else if(b.kind == "rect") {
      for(Rectangle r : list_rectangle_SVG) {
        if(r.ID == b.ID) {
          build_rectangle(pos, scale, jitter, r) ;
        }
      }
    }
  }

  public void display_shape_3D(Brick_SVG b, Vec3 pos, Vec3 scale, Vec3 jitter) {
    if(b.kind == "path" || b.kind == "polygon") {
      for(Vertices v : list_vertice_SVG) {
        if(v.ID == b.ID) build_path(pos, scale, jitter, v) ;
      }
    } else if(b.kind == "ellipse" || b.kind == "circle") {
      for(Ellipse e : list_ellipse_SVG) {
        if(e.ID == b.ID) {
          build_ellipse(pos, scale, jitter, e) ;
        }
      }
    } else if(b.kind == "rect") {
      for(Rectangle r : list_rectangle_SVG) {
        if(r.ID == b.ID) {
          build_rectangle(pos, scale, jitter, r) ;
        }
      }
    }
  }


  /**
  Build list point of SVG
  */
  public void build_SVG(ArrayList<Brick_SVG> list) {
    PShape [] children = new PShape[list.size()] ;
    for(int i = 0 ; i < list.size() ; i++) {
      PShape mother = loadShape( saved_path_svg + name + "_" + i + ".svg") ;
      children = mother.getChildren() ;
      Brick_SVG b = (Brick_SVG) list.get(i) ;
      if( b.kind == "polygon" || b.kind == "path")  vertex_count(children[0], mother.getName(), b.ID) ;
      else if(b.kind == "circle" || b.kind == "ellipse") ellipse_count(b.full_xml_SVG, mother.getName(), b.ID) ;
      else if(b.kind == "rect") rectangle_count(b.full_xml_SVG, mother.getName(), b.ID) ;
    }
  }
  



  /**
  ELLIPSE & CIRCLE
  */
  /**
  build
  */
  // list of group SVG
  ArrayList<Ellipse> list_ellipse_SVG = new ArrayList<Ellipse>() ;
  
  public void ellipse_count(XML xml_shape, String geom_name, int ID) {
    float r = xml_shape.getChild(0).getFloat("r") ;
    float rx = (float)xml_shape.getChild(0).getFloat("rx") ;
    float ry = (float)xml_shape.getChild(0).getFloat("ry") ;
    float cx = xml_shape.getChild(0).getFloat("cx") ;
    float cy = xml_shape.getChild(0).getFloat("cy") ;
    if(r > 0 ) rx = ry = r ;
  
    Ellipse e = new Ellipse(cx, cy, rx, ry, ID) ;
    list_ellipse_SVG.add(e) ;
  }
  

  /**
  Main method to draw ellipse
  */
  public void build_ellipse(Vec2 pos, Vec2 scale, Vec2 jitter, Ellipse e) {
    Vec2 temp_pos = Vec2(e.pos.x, e.pos.y)  ;
    Vec2 center_pos = canvas().copy() ;
    center_pos.mult(.5f) ; 
  
    // the order of operation is very weird, because is not a same for the build_vertex()
    if(position_center) temp_pos.sub(center_pos) ;
    if(!scale.compare(Vec2(1))) temp_pos.mult(scale) ; 
    if(!pos.compare(Vec2())) temp_pos.add(pos) ;
  
    Vec2 temp_size = e.size.copy() ;
    ellipse(temp_pos, temp_size.mult(scale)) ;
  }
  
  public void build_ellipse(Vec3 pos, Vec3 scale, Vec3 jitter, Ellipse e) {
    Vec3 temp_pos = Vec3(e.pos.x, e.pos.y,0)  ;
    Vec3 center_pos = Vec3(canvas().x,canvas().y, 0) ;
    center_pos.mult(.5f) ; 
  
    // the order of operation is very weird, because is not a same for the build_vertex()
    if(position_center) temp_pos.sub(center_pos) ;
    if(!scale.compare(Vec3(1))) temp_pos.mult(scale) ; 
    if(!pos.compare(Vec3())) temp_pos.add(pos) ;
  
    Vec2 temp_size = e.size.copy() ;
    ellipse(temp_pos, temp_size.mult(scale.x, scale.y)) ;
  }
  /**
  END CIRCLE & ELLIPSE
  */
  



  /**
  RECTANGLE
  */
  /**
  build
  */
  // list of group SVG
  ArrayList<Rectangle> list_rectangle_SVG = new ArrayList<Rectangle>() ;
  
  public void rectangle_count(XML xml_shape, String geom_name, int ID) {
    float x = xml_shape.getChild(0).getFloat("x") ;
    float y = xml_shape.getChild(0).getFloat("y") ;
    int width_rect = xml_shape.getChild(0).getInt("width") ;
    int height_rect = xml_shape.getChild(0).getInt("height") ;
  
    Rectangle r = new Rectangle(x, y, width_rect, height_rect, ID) ;
    list_rectangle_SVG.add(r) ;
  }
  
  /**
  Main method to draw ellipse
  */
  public void build_rectangle(Vec2 pos, Vec2 scale, Vec2 jitter, Rectangle r) {
    Vec2 temp_pos = Vec2(r.pos.x, r.pos.y)  ;
    Vec2 center_pos = canvas().copy() ;
    center_pos.mult(.5f) ; 
  
    // the order of operation is very weird, because is not a same for the build_vertex()
    if(position_center) temp_pos.sub(center_pos) ;
    if(!scale.compare(Vec2(1))) temp_pos.mult(scale) ; 
    if(!pos.compare(Vec2())) temp_pos.add(pos) ;
  
    Vec2 temp_size = r.size.copy() ;
    rect(temp_pos, temp_size.mult(scale)) ;
  }
  
  public void build_rectangle(Vec3 pos, Vec3 scale, Vec3 jitter, Rectangle r) {
    Vec3 temp_pos = Vec3(r.pos.x, r.pos.y,0)  ;
    Vec3 center_pos = Vec3(canvas().x,canvas().y, 0) ;
    center_pos.mult(.5f) ; 
  
    // the order of operation is very weird, because is not a same for the build_vertex()
    if(position_center) temp_pos.sub(center_pos) ;
    if(!scale.compare(Vec3(1))) temp_pos.mult(scale) ; 
    if(!pos.compare(Vec3())) temp_pos.add(pos) ;
  
    Vec2 temp_size = r.size.copy() ;
    rect(temp_pos, temp_size.mult(scale.x, scale.y)) ;
  }
  /**
  END RECTANGLE
  */
  

  


  /**
  VERTEX
  */
  /**
  Build
  */
  // list of group SVG
  ArrayList<Vertices> list_vertice_SVG = new ArrayList<Vertices>() ;
  // here we must build few object for each group, but how ?
  Vec3 [] vert ;
  int [] vertex_code ;
  int code_vertex_count ;
  
  public void vertex_count(PShape geom_shape, String geom_name, int ID) {
    int num = geom_shape.getVertexCount() ;
    vertex_code = new int[num] ;
    vert = new Vec3[num] ;
    vertex_code = geom_shape.getVertexCodes() ;
    code_vertex_count = geom_shape.getVertexCodeCount() ;
    
    // Vertices v = new Group_vert(code_vertex_count, num, vertex_code, geom_shape.getName()) ;
    Vertices v = new Vertices(code_vertex_count, num, geom_shape, geom_name, ID) ;
    v.build_vertices_3D(geom_shape) ;
    list_vertice_SVG.add(v) ;
  }
  /**
  END VERTEX
  */
 
  









  /**
  Draw Vertice
  adapted from Processing PShape drawPath for the vertex
  https://github.com/processing/processing/blob/master/core/src/processing/core/PShape.java
  line 1700 and the dust !
  */
  /**
  for the 2D vertex
  */
  
  public void build_path(Vec2 pos, Vec2 scale, Vec2 jitter, Vertices v) {
    Vec2 center_pos = Vec2(canvas().x,canvas().y) ;
    center_pos.mult(.5f) ; 
    if(!scale.compare(Vec2(1))) center_pos.mult(scale) ; 
  
    if (v.vert == null) return;
  
    boolean insideContour = false;
    beginShape();
    // for the simple vertex
    if (v.code_vertex_count == 0) {  
      for (int i = 0; i <  v.vert.length; i++) {
        Vec2 temp_pos_a = Vec2(v.vert[i].x,v.vert[i].y) ;
        //
        if(!scale.compare(Vec2(1))) temp_pos_a.mult(scale) ;
        //
        if(!jitter.compare(Vec2())) {
          Vec2 jitter_pos = Vec2().jitter((int)jitter.x,(int)jitter.y) ;
          temp_pos_a.add(jitter_pos) ;
        }
        //
        if(position_center) temp_pos_a.sub(center_pos) ;
        //
        if(!pos.compare(Vec2())) temp_pos_a.add(pos) ;
  
        vertex(temp_pos_a);
      }
    // for the complex draw vertex, with bezier, curve...
    } else {  
      int index = 0;
      for (int j = 0; j < v.code_vertex_count; j++) {
        Vec2 temp_pos_a , temp_pos_b, temp_pos_c ;
  
        switch (v.vertex_code[j]) {
          //---------
          case VERTEX:
          temp_pos_a = Vec2(v.vert[index].x,v.vert[index].y) ;
          //
          if(!scale.compare(Vec2(1))) temp_pos_a.mult(scale) ;
          //
          if(!jitter.compare(Vec2())) {
            Vec2 jitter_pos = Vec2().jitter((int)jitter.x,(int)jitter.y) ;
            temp_pos_a.add(jitter_pos) ;
          }
          //
          if(position_center) temp_pos_a.sub(center_pos) ;
          //
          if(!pos.compare(Vec2())) temp_pos_a.add(pos) ;
          //
          vertex(temp_pos_a);
          index++;
          break;
          // QUADRATIC_VERTEX
          case QUADRATIC_VERTEX:
          temp_pos_a = Vec2(v.vert[index].x,v.vert[index].y) ;
          temp_pos_b = Vec2(v.vert[index +1].x,v.vert[index +1].y) ;
          //
          if(!scale.compare(Vec2(1))) {
            temp_pos_a.mult(scale) ;
            temp_pos_b.mult(scale) ;
          }
          //
          if(!jitter.compare(Vec2())) {
            Vec2 jitter_pos = Vec2().jitter((int)jitter.x,(int)jitter.y) ;
            temp_pos_a.add(jitter_pos) ;
            jitter_pos = Vec2().jitter((int)jitter.x,(int)jitter.y) ;
            temp_pos_b.add(jitter_pos) ;
          }
          //
          if(position_center) {
            temp_pos_a.sub(center_pos) ;
            temp_pos_b.sub(center_pos) ;
          }
          //
          if(!pos.compare(Vec2())) {
            temp_pos_a.add(pos) ;
            temp_pos_b.add(pos) ;
          }
          //
          quadraticVertex(temp_pos_a, temp_pos_b);
          index += 2;
          break;
          // BEZIER_VERTEX     
          case BEZIER_VERTEX:
          temp_pos_a = Vec2(v.vert[index].x,v.vert[index].y) ;
          temp_pos_b = Vec2(v.vert[index +1].x,v.vert[index +1].y) ;
          temp_pos_c = Vec2(v.vert[index +2].x,v.vert[index +2].y) ;
          //
          if(!scale.compare(Vec2(1))) {
            temp_pos_a.mult(scale) ;
            temp_pos_b.mult(scale) ;
            temp_pos_c.mult(scale) ;
          }
          //
          if(!jitter.compare(Vec2())) {
            Vec2 jitter_pos = Vec2().jitter((int)jitter.x,(int)jitter.y) ;
            temp_pos_a.add(jitter_pos) ;
            jitter_pos = Vec2().jitter((int)jitter.x,(int)jitter.y) ;
            temp_pos_b.add(jitter_pos) ;
            jitter_pos = Vec2().jitter((int)jitter.x,(int)jitter.y) ;
            temp_pos_c.add(jitter_pos) ;
          }
          //
          if(position_center) {
            temp_pos_a.sub(center_pos) ;
            temp_pos_b.sub(center_pos) ;
            temp_pos_c.sub(center_pos) ;
          }
          //
          if(!pos.compare(Vec2())) {
            temp_pos_a.add(pos) ;
            temp_pos_b.add(pos) ;
            temp_pos_c.add(pos) ;
          }
          //
          bezierVertex(temp_pos_a, temp_pos_b, temp_pos_c);
          index += 3;
          break;
          // CURVE_VERTEX
          case CURVE_VERTEX:
          temp_pos_a = Vec2(v.vert[index].x,v.vert[index].y) ;
          //
          if(!scale.compare(Vec2(1))) temp_pos_a.mult(scale) ;
          //
          if(!jitter.compare(Vec2())) {
            Vec2 jitter_pos = Vec2().jitter((int)jitter.x,(int)jitter.y) ;
            temp_pos_a.add(jitter_pos) ;
          }
          //
          if(position_center) temp_pos_a.sub(center_pos) ;
          //
          if(!pos.compare(Vec2())) temp_pos_a.add(pos) ;
          //
          curveVertex(temp_pos_a);
          index++;
          break;
          // BREAK
          case BREAK:
          if (insideContour) {
            endContour();
          }
          beginContour();
          insideContour = true;
        }
      }
    }
    if (insideContour) {
      endContour();
    }
    endShape(CLOSE);
  }
  /**
  for the 3D vertex
  */
  public void build_path(Vec3 pos, Vec3 scale, Vec3 jitter, Vertices v) {
    Vec3 center_pos = Vec3(canvas().x,canvas().y,0) ;
    center_pos.mult(.5f) ; 
    if(!scale.compare(Vec3(1))) center_pos.mult(scale) ; 
  
    if (v.vert == null) return;
  
    boolean insideContour = false;
    beginShape();
    // for the simple vertex
    if (v.code_vertex_count == 0) {  
      for (int i = 0; i <  v.vert.length; i++) {
        Vec3 temp_pos_a = v.vert[i].copy() ;
        //
        if(!scale.compare(Vec3(1))) temp_pos_a.mult(scale) ;
        //
        if(!jitter.compare(Vec3())) {
          Vec3 jitter_pos = Vec3().jitter((int)jitter.x,(int)jitter.y,(int)jitter.z) ;
          temp_pos_a.add(jitter_pos) ;
        }
        //
        if(position_center) temp_pos_a.sub(center_pos) ;
        //
        if(!pos.compare(Vec3())) temp_pos_a.add(pos) ;
        //
        vertex(temp_pos_a);
      }
    // for the complex draw vertex, with bezier, curve...
    } else {  
      int index = 0;
      for (int j = 0; j < v.code_vertex_count; j++) {
        Vec3 temp_pos_a , temp_pos_b, temp_pos_c ;
  
        switch (v.vertex_code[j]) {
          //----------
          case VERTEX:
          temp_pos_a = v.vert[index].copy() ;
          //
          if(!scale.compare(Vec3(1))) temp_pos_a.mult(scale) ;
          //
          if(!jitter.compare(Vec3())) {
            Vec3 jitter_pos = Vec3().jitter((int)jitter.x,(int)jitter.y,(int)jitter.z) ;
            temp_pos_a.add(jitter_pos) ;
          }
          //
          if(position_center) temp_pos_a.sub(center_pos) ;
          //
          if(!pos.compare(Vec3())) temp_pos_a.add(pos) ;
          //
          vertex(temp_pos_a);
          index++;
          break;
        // QUADRATIC_VERTEX
          case QUADRATIC_VERTEX:
          temp_pos_a = v.vert[index].copy() ;
          temp_pos_b = v.vert[index +1].copy() ;
          //
          if(!scale.compare(Vec3(1))) {
            temp_pos_a.mult(scale) ;
            temp_pos_b.mult(scale) ;
          }
          //
          if(!jitter.compare(Vec3())) {
            Vec3 jitter_pos = Vec3().jitter((int)jitter.x,(int)jitter.y,(int)jitter.z) ;
            temp_pos_a.add(jitter_pos) ;
            jitter_pos = Vec3().jitter((int)jitter.x,(int)jitter.y,(int)jitter.z) ;
            temp_pos_b.add(jitter_pos) ;
          }
          //
          if(position_center) {
            temp_pos_a.sub(center_pos) ;
            temp_pos_b.sub(center_pos) ;
          }
          //
          if(!pos.compare(Vec3())) {
            temp_pos_a.add(pos) ;
            temp_pos_b.add(pos) ;
          }
          //
          quadraticVertex(temp_pos_a, temp_pos_b);
          index += 2;
          break;
          // BEZIER_VERTEX
          case BEZIER_VERTEX:
          temp_pos_a = v.vert[index].copy() ;
          temp_pos_b = v.vert[index +1].copy() ;
          temp_pos_c = v.vert[index +2].copy() ;
          //
          if(!scale.compare(Vec3(1))) {
            temp_pos_a.mult(scale) ;
            temp_pos_b.mult(scale) ;
            temp_pos_c.mult(scale) ;
          }
          //
          if(!jitter.compare(Vec3())) {
            Vec3 jitter_pos = Vec3().jitter((int)jitter.x,(int)jitter.y,(int)jitter.z) ;
            temp_pos_a.add(jitter_pos) ;
            jitter_pos = Vec3().jitter((int)jitter.x,(int)jitter.y,(int)jitter.z) ;
            temp_pos_b.add(jitter_pos) ;
            jitter_pos = Vec3().jitter((int)jitter.x,(int)jitter.y,(int)jitter.z) ;
            temp_pos_c.add(jitter_pos) ;
          }
          //
          if(position_center) {
            temp_pos_a.sub(center_pos) ;
            temp_pos_b.sub(center_pos) ;
            temp_pos_c.sub(center_pos) ;
          }
          //
          if(!pos.compare(Vec3())) {
            temp_pos_a.add(pos) ;
            temp_pos_b.add(pos) ;
            temp_pos_c.add(pos) ;
          }
          //
          bezierVertex(temp_pos_a, temp_pos_b, temp_pos_c);
          index += 3;
          break;
          // CURVE_VERTEX
          case CURVE_VERTEX:
          temp_pos_a = v.vert[index].copy() ;
          //
          if(!scale.compare(Vec3(1))) temp_pos_a.mult(scale) ;
          //
          if(!jitter.compare(Vec3())) {
            Vec3 jitter_pos = Vec3().jitter((int)jitter.x,(int)jitter.y,(int)jitter.z) ;
            temp_pos_a.add(jitter_pos) ;
          }
          //
          if(position_center) temp_pos_a.sub(center_pos) ;
          //
          if(!pos.compare(Vec3())) temp_pos_a.add(pos) ;
          //
          curveVertex(temp_pos_a);
          index++;
          break;
          // BREAK
          case BREAK:
          if (insideContour) {
            endContour();
          }
          beginContour();
          insideContour = true;
        }
      }
    }
    if (insideContour) {
      endContour();
    }
    endShape(CLOSE);
  }
  /**
  END BUILD

  */



  /**
  EXTRACT POINT
  
  */
  
  public void extract(Vertices v) {
    if (v.vert == null) return;
    if (v.code_vertex_count == 0) {  
      for (int i = 0; i <  v.vert.length; i++) {
        Vec3 temp_pos_a = v.vert[i].copy() ;
        vertex(temp_pos_a);
      }
    // for the complex draw vertex, with bezier, curve...
    } else {  
      int index = 0;
      for (int j = 0; j < v.code_vertex_count; j++) {
        Vec3 temp_pos_a , temp_pos_b, temp_pos_c ;
        switch (v.vertex_code[j]) {
          case VERTEX:
          temp_pos_a = v.vert[index].copy() ;
          vertex(temp_pos_a);
          index++;
          break;
          // QUADRATIC_VERTEX
          case QUADRATIC_VERTEX:
          temp_pos_a = v.vert[index].copy() ;
          temp_pos_b = v.vert[index +1].copy() ;
          //
          quadraticVertex(temp_pos_a, temp_pos_b);
          index += 2;
          break;
          // BEZIER_VERTEX
          case BEZIER_VERTEX:
          temp_pos_a = v.vert[index].copy() ;
          temp_pos_b = v.vert[index +1].copy() ;
          temp_pos_c = v.vert[index +2].copy() ;
          //
          bezierVertex(temp_pos_a, temp_pos_b, temp_pos_c);
          index += 3;
          break;
          // CURVE_VERTEX
          case CURVE_VERTEX:
          temp_pos_a = v.vert[index].copy() ;
          curveVertex(temp_pos_a);
          index++;
          break;
          // BREAK
          case BREAK:
        }
      }
    }
  }






  /**
  INFO

  */
  public String [] name_brick_SVG (ArrayList<Brick_SVG> list_brick) {
    String [] list ;
    if(list_brick.size() > 0 ) {
      list = new String[list_brick.size()] ;
      for (int i = 0 ; i < list.length ; i++) {
        Brick_SVG b_svg = list_brick.get(i) ;
        list[i] = b_svg.brick_name ;
      }
      return list ;
    } else {
      list = new String[1] ;
      list[0] = "no item in the list" ;
      return list ;
    }
  }
  
  public String [] kind_brick_SVG (ArrayList<Brick_SVG> list_brick) {
    String [] list ;
    if(list_brick.size() > 0 ) {
      list = new String[list_brick.size()] ;
      for (int i = 0 ; i < list.length ; i++) {
        Brick_SVG b_svg = list_brick.get(i) ;
        list[i] = b_svg.kind ;
      }
      return list ;
    } else {
      list = new String[1] ;
      list[0] = "no item in the list" ;
      return list ;
    }
  }
  
  public String [] family_brick_SVG (ArrayList<Brick_SVG> list_brick) {
    String [] list ;
    if(list_brick.size() > 0 ) {
      list = new String[list_brick.size()] ;
      for (int i = 0 ; i < list.length ; i++) {
        Brick_SVG b_svg = list_brick.get(i) ;
        list[i] = b_svg.family_name ;
      }
      return list ;
    } else {
      list = new String[1] ;
      list[0] = "no item in the list" ;
      return list ;
    }
  }
  /**
  END INFO

  */
  

  


















  
  
  /**
  ANALYZE

  */
  public void analyze_SVG(XML target) {
    // catch the header to rebuild a SVG as small as possible to use Processing build PShapeSVG of Processing engine
    header_svg = catch_header_SVG(target) ;

    ID_brick = 0 ;
    String primal_name =("") ;
    String primal_opacity = ("none") ;
    deep_analyze_SVG(header_svg, target, primal_name, primal_opacity) ;
  }
  
  public void save_brick_SVG() {
    /* here in the future :
    Save name of SVG, width, height and other global properties
    */
    for(int i = 0 ; i < list_brick_SVG.size() ; i++) {
      Brick_SVG shape = (Brick_SVG) list_brick_SVG.get(i) ;
      saveXML(shape.full_xml_SVG,  saved_path_svg + name + "_" + i + ".svg") ;
    }
  }
  
  
  
  // Local method
  public void deep_analyze_SVG(String header, XML target, String ancestral_name, String opacity_group) {
    String ID_xml =("") ;
    ID_xml = get_kind_SVG(target) ;
    // check for group or layer shape
    if(check_group_SVG(target)) {
      XML [] g_group = target.getChildren("g") ;
      if(g_group.length > 0) {
        for(int i = 0 ; i < g_group.length ; i++) {
          String new_name = ancestral_name + g_group[i].getString("id") ;
          // check if there is opacity for the group or not
          if(opacity_group == null || opacity_group == "none")  opacity_group = g_group[i].getString("opacity") ;
          deep_analyze_SVG(header, g_group[i], new_name, opacity_group) ;
        }
      }
    }
    // catch the shape
    // add the opacity here for the brick ????
    if(check_kind_SVG(target)) add_brick_SVG(header_svg, target, ancestral_name, opacity_group) ;
  }
  
  
  
  public void add_brick_SVG(String header, XML target, String ancestral_name, String opacity_group) {
    XML [] g_rect = target.getChildren("rect") ;
    if(g_rect.length > 0) {
      for(int i = 0 ; i < g_rect.length ; i++) {
        catch_brick_shape(header, g_rect[i], ancestral_name, opacity_group) ;
      }
    }
    XML [] g_circle = target.getChildren("circle") ;
    if(g_circle.length > 0) {
      for(int i = 0 ; i < g_circle.length ; i++) {
        catch_brick_shape(header, g_circle[i], ancestral_name, opacity_group) ;
      }
    }
    XML [] g_ellipse = target.getChildren("ellipse") ;
    if(g_ellipse.length > 0) {
      for(int i = 0 ; i < g_ellipse.length ; i++) {
        catch_brick_shape(header, g_ellipse[i], ancestral_name, opacity_group) ;
      }
    }
    XML [] g_polygon = target.getChildren("polygon") ;
    if(g_polygon.length > 0) {
      for(int i = 0 ; i < g_polygon.length ; i++) {
        catch_brick_shape(header, g_polygon[i], ancestral_name, opacity_group) ;
      }
    }
    XML [] g_path = target.getChildren("path") ;
    if(g_path.length > 0) {
      for(int i = 0 ; i < g_path.length ; i++) {
        catch_brick_shape(header, g_path[i], ancestral_name, opacity_group) ;
      }
    }
  }
    




  /**
  CATCH INFO 
  */
  public String catch_header_SVG(XML target) {
    String s = "" ;
    String string_to_split = target.toString() ;
    String [] part = string_to_split.split("<") ;
    s = "<"+part[1] ;
    return s ;
  }
  
  
  public void catch_brick_shape(String header, XML target, String ancestral_name, String opacity_group) {
    Brick_SVG new_brick = new Brick_SVG(header, target, ID_brick, ancestral_name, opacity_group) ;
    list_brick_SVG.add(new_brick) ;
    ID_brick++ ;
  }
  /**
  CHECK INFO
  */  
  public boolean check_kind_SVG(XML target) {
    boolean result = false ;
    if(target.getChild("path") != null ) result = true ;
    else if(target.getChild("rect")!= null ) result = true ;
    else if(target.getChild("polygon")!= null ) result = true ;
    else if(target.getChild("circle")!= null ) result = true ;
    else if(target.getChild("ellipse")!= null ) result = true ;
    else if(target.getChild("g")!= null ) result = false ;
    else result = false ;
    return result ;
  }

  public boolean check_group_SVG(XML target) {
    boolean result = false ;
    if(target.getChild("g")!= null ) result = true ;
    else result = false ;
    return result ;
  }
  /**
  GET
  */
  public String get_kind_SVG(XML target) {
    String kind = "" ;
    if(target.getChild("path") != null ) kind = "path" ;
    else if(target.getChild("polygon")!= null ) kind = "polygon" ;
    else if(target.getChild("circle")!= null )kind = "circle" ;
    else if(target.getChild("ellipse")!= null ) kind = "ellipse" ;
    else if(target.getChild("rect")!= null ) kind = "rect" ;
    else if(target.getChild("g")!= null ) kind = "g" ;
    else kind = "no kind detected" ;
    return kind ;
  }
  /**
  END ANALYZE

  */
  
  






























  
  /**
  PRIVATE CLASS

  */
  /**
  class brick
  */
  private class Brick_SVG {
    String file_name ;
    String brick_name = "no name" ;
    String family_name = "no name" ;
    String kind = "" ;
    int ID ;
    int fill, stroke ;
    float strokeWeight ;
    float opacity, opacity_group ;
    int width, height ;
    XML full_xml_SVG ;
    String built_svg_file = "" ;
   
    Brick_SVG(String header, XML brick_xml, int ID, String ancestral_name, String str_opacity_group) {
  
      this.ID = ID ;
      built_svg_file = header + brick_xml.toString() + "</svg>" ;
      full_xml_SVG = parseXML(built_svg_file) ;
  
      brick_name = get_name(brick_xml) ;
      family_name = ancestral_name + "_" + get_name(full_xml_SVG) ;
      this.kind = get_kind_SVG(full_xml_SVG) ;
      if(str_opacity_group != "none" && str_opacity_group != null) opacity_group = Float.valueOf(str_opacity_group.trim()).floatValue(); else opacity_group = 1.f ;
      set_aspect(brick_xml) ;
    }
  
    public String get_name(XML target) {
      String name = "no name" ;
      if(target.getString("id") != null) name = target.getString("id") ;
      return name ;
    }
    /**
    aspect
    */
    public void set_aspect(XML target) {
      String fill_str =  target.getString("fill") ;        
      String stroke_str =  target.getString("stroke") ;
      String strokeWeight_str =  target.getString("stroke-width") ;
      String opacity_str =  target.getString("opacity") ; 
      // fill
      if(fill_str == null || fill_str.contains("none")) fill = 0xffFFFFFF ; 
      else {
        String fill_temp = "" ;
        fill_temp = fill_str.substring(1) ;
        fill = unhex(fill_temp) ;
      }
      // stroke
      if(stroke_str == null  || stroke_str.contains("none")) stroke = 0xff000000 ; 
      else {
        String stroke_temp = "" ;
        stroke_temp = stroke_str.substring(1) ;
        stroke = unhex(stroke_temp) ;
      }
      // strokeWeight
      if(strokeWeight_str == null  || strokeWeight_str.contains("none")) strokeWeight = 1.f ; 
      else strokeWeight = Float.valueOf(strokeWeight_str.trim()).floatValue();
      // opacity
      if(opacity_str == null || opacity_str.contains("none")) opacity = 1.f ; 
      else opacity = Float.valueOf(opacity_str.trim()).floatValue();
      if(opacity == 1.f && opacity_group != 1.f) opacity = opacity_group ;
    }
    
    
    
    public void aspect_fill(Vec4 factor) {
      // HSB mmode
      if(g.colorMode == 3) {
        fill(hue(fill) *factor.x, saturation(fill) *factor.y, brightness(fill) *factor.z, opacity *g.colorModeA *factor.w) ;
      // RGB mmode
      } else if( g.colorMode == 1 ) {
        float red_col = red(fill) *factor.x ;
        float alpha_col = opacity *g.colorModeA *factor.w ;
        alpha_col = opacity *g.colorModeA *factor.w  ;
        fill(red_col, green(fill) *factor.y, blue(fill) *factor.z, alpha_col) ;
      }
    }

    public void aspect_stroke(float scale, Vec4 factor) {
      float thickness = strokeWeight ;
      if(scale != 1 ) thickness *= scale ;
      // HSB mmode
      if(g.colorMode == 3) {
        if(strokeWeight <= 0)  {
          noStroke() ;
        } else {
          strokeWeight(thickness) ;
          stroke(hue(stroke) *factor.x, saturation(stroke) *factor.y, brightness(stroke) *factor.z, opacity *g.colorModeA *factor.w) ; 
        }
      // RGB mmode
      } else if( g.colorMode == 1 ) {
        if(strokeWeight <= 0)  {
          noStroke() ;
        } else {
          strokeWeight(thickness) ;
          stroke(red(stroke) *factor.x, green(stroke) *factor.y, blue(stroke) *factor.z, opacity *g.colorModeA *factor.w) ; 
        }
      }
    }
  }
  


















    
  
  /**
  class to build all specific group
  */
  private class Vertices {
    String shape_name = "my name is noboby" ;
    Vec2 size ;
    Vec3 [] vert ;
    int [] vertex_code ;
    int code_vertex_count ;
    int num ;
    int ID ;
    
    Vertices(int code_vertex_count, int num, PShape p, String mother_name, int ID) {
      this.ID = ID ;
      this.num = num ;
      // not sur we need this shape_name !
      this.shape_name = mother_name + "<>" +p.getName() ;
  
      this.code_vertex_count = code_vertex_count ;
      
      vert = new Vec3[num] ;
      vertex_code = new int[num] ;
      vertex_code = p.getVertexCodes() ;
      size = Vec2(p.width, p.height);
    }
    
    public void build_vertices_3D(PShape path) {
      for(int i = 0 ; i < num ; i++) {
        vert[i] = Vec3(path.getVertex(i)) ;
      }
    }
    
    public Vec3 [] vertices() {
      return vert ;
    }

    public void add_value(Vec3... value) {
      if(value.length <= vert.length) {
        for(int i = 0 ; i < value.length ; i++) {
          vert[i].add(value[i]) ;
        }
      } else {
        for(int i = 0 ; i < vert.length ; i++) {
          vert[i].add(value[i]) ;
        }
      }
    }
  }


  /**
  Class Ellipse
  */

  class Ellipse {
    String shape_name ;
    Vec3 pos ;
    Vec2 size ;
    int ID ;
  
    Ellipse(float cx, float cy,  float rx, float ry, int ID) {
      this.ID = ID ;
      this.pos = Vec3(cx, cy,0) ;
      this.size = Vec2(rx, ry).mult(2) ;
    }
    
    public void add_value(Vec3... value) {
      pos.add(value[0]) ;
    }
    
  }

  /**
  Class Rectangle
  */
  class Rectangle {
    String shape_name ;
    Vec3 pos ;
    Vec2 size ;
    int ID ;
  
    Rectangle(float x, float y,  int width_rect, int height_rect, int ID) {
      this.ID = ID ;
      this.pos = Vec3(x, y,0) ;
      this.size = Vec2(width_rect, height_rect) ;
    }
    
    public void add_value(Vec3... value) {
      pos.add(value[0]) ;
    }
    
  }
  /**
  END OF PRIVATE CLASS

  */
}
/**
END OF MAIN CLASS

*/
// Tab: Z_Sound
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
public void sound_setup() {
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
/**
RPE UTILS 1.12.6
*/


// MAP
///////
/*
map the value between the min and the max
@ return float
*/
public float map_cycle(float value, float min, float max) {
  max += .000001f ;
  float newValue ;
  if(min < 0 && max >= 0 ) {
    float tempMax = max +abs(min) ;
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
public float map_locked(float value, float sourceMin, float sourceMax, float targetMin, float targetMax) {
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
public float map_smooth_start(float value, float sourceMin, float sourceMax, float targetMin, float targetMax, int level) {
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
public float map_smooth_end(float value, float sourceMin, float sourceMax, float targetMin, float targetMax, int level) {
  if (value < sourceMin ) value = sourceMin ;
  if (value > sourceMax ) value = sourceMax ;
  float newMax = sourceMax - sourceMin ;
  float deltaTarget = targetMax - targetMin ;
  float ratio = ((value - sourceMin) / newMax ) ;
  // ratio = roots(ratio, level) ; // the method roots is use in math util
  ratio = pow(ratio, 1.0f/level) ;
  float result = targetMin +deltaTarget *ratio;
  return result;
}

// to map not linear, like a "S"
public float map_smooth(float value, float sourceMin, float sourceMax, float targetMin, float targetMax, int level) {
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



/**
Check renderer
*/
public boolean renderer_P3D() {
  if(get_renderer_name(getGraphics()).equals("processing.opengl.PGraphics3D")) return true ; else return false ;
}


public String get_renderer_name(final PGraphics graph) {
  try {
    if (Class.forName(JAVA2D).isInstance(graph))  return JAVA2D;
    if (Class.forName(FX2D).isInstance(graph))    return FX2D;
    if (Class.forName(P2D).isInstance(graph))     return P2D;
    if (Class.forName(P3D).isInstance(graph))     return P3D;
    if (Class.forName(PDF).isInstance(graph))     return PDF;
    if (Class.forName(DXF).isInstance(graph))     return DXF;
  }

  catch (ClassNotFoundException ex) {
  }
  return "Unknown";
}



/**
TRANSLATOR INT to String, FLOAT to STRING
*/
//truncate
public float truncate( float x ) {
    return round( x * 100.0f ) / 100.0f;
}
//Int to String with array list
/*
@ return String
*/
public String join_int_to_String(int []data) {
  String intString ;
  String [] dataString = new String [data.length] ;
  for ( int i = 0 ; i < data.length ; i++) dataString[i] = Integer.toString(data[i]) ;
  intString = join(dataString,"/") ;
  
  return intString ;
}

//float to String with array list
public String join_float_to_String(float []data) {
  String floatString ;
  String [] dataString = new String [data.length] ;
  //for ( int i = 0 ; i < data.length ; i++) dataString[i] = Float.toString(data[i]) ;
  //we must use just one decimal after coma, to dodge the outBoundIndex blablabla
  for ( int i = 0 ; i < data.length ; i++) dataString[i] = String.format("%.1f" ,data[i]) ;
  floatString = join(dataString,"/") ;
  
  return floatString ;
}

//Translater to String
public String float_to_String_1(float data) {
  String newData ;
  newData = String.format("%.1f", data ) ;
  return newData ;
}
//
public String float_to_String_2(float data) {
  String newData ;
  newData = String.format("%.2f", data ) ;
  return newData ;
}
//
public String float_to_String_3(float data) {
  String newData ;
  newData = String.format("%.3f", data ) ;
  return newData ;
}
//
public String int_to_String(int data) {
  String newData ;
  newData = Integer.toString(data ) ;
  return newData ;
}
//END TRANSLATOR
///////////////




/**
STRING UTILS
*/

//STRING SPLIT
public String [] split_text(String textToSplit, String separator) {
  String [] text = textToSplit.split(separator) ;
  return text  ;
}


//STRING COMPARE LIST SORT
//raw compare
public int longest_word( String[] listWordsToSort) {
  int sizeWord = 0 ;
  for ( int i = 0 ; i < listWordsToSort.length ; i++) {
    if (listWordsToSort[i].length() > sizeWord )  sizeWord = listWordsToSort[i].length() ;
  }
  return  sizeWord ;
}
//with starting and end keypoint in the String must be sort
public int longest_word( String[] listWordsToSort, int start, int finish ) {
  int sizeWord = 0 ;

  for ( int i = start ; i < finish ; i++) {
    if (listWordsToSort[i].length() > sizeWord )  sizeWord = listWordsToSort[i].length() ;
  }
  return  sizeWord ;
}



// with the same size_text for each line
public int longest_word_in_pixel(String[] listWordsToSort, int size_font) {
  int sizeWord = 0 ;
  for ( int i = 0 ; i < listWordsToSort.length ; i++) {
    if (length_String_in_pixel(listWordsToSort[i], size_font) > sizeWord )  sizeWord = length_String_in_pixel(listWordsToSort[i],size_font) ;
  }
  return  sizeWord ;
}

// with the same size_text for each line, choice the which line you check
public int longest_word_in_pixel( String[] listWordsToSort, int size_font, int start, int finish ) {
  int sizeWord = 0 ;
  for ( int i = start ; i <= finish ; i++) {
    if (length_String_in_pixel(listWordsToSort[i], size_font) > sizeWord )  sizeWord = length_String_in_pixel(listWordsToSort[i],size_font) ;
  }
  return  sizeWord ;
}

// with list of size_text for each line
public int longest_word_in_pixel( String[] listWordsToSort, int [] size_font) {
  int sizeWord = 0 ;
  for ( int i = 0 ; i < listWordsToSort.length ; i++) {
    if (length_String_in_pixel(listWordsToSort[i], size_font[i]) > sizeWord )  sizeWord = length_String_in_pixel(listWordsToSort[i],size_font[i]) ;
  }
  return  sizeWord ;
}

// with list of size_text for each line, choice the which line you check
public int longest_word_in_pixel( String[] listWordsToSort, int [] size_font, int start, int finish ) {
  int sizeWord = 0 ;
  for ( int i = start ; i <= finish ; i++) {
    if (length_String_in_pixel(listWordsToSort[i], size_font[i]) > sizeWord )  sizeWord = length_String_in_pixel(listWordsToSort[i],size_font[i]) ;
  }
  return  sizeWord ;
}




 



public int length_String_in_pixel(String target, int ratio) {
  Font font = new Font("defaultFont", Font.BOLD, ratio) ;
  BufferedImage img = new BufferedImage(1, 1, BufferedImage.TYPE_INT_ARGB);
  FontMetrics fm = img.getGraphics().getFontMetrics(font);
  return fm.stringWidth(target);
}




// Research a specific word in String
public boolean research_in_String(String research, String target) {
  boolean result = false ;
  for(int i = 0 ; i < target.length() - research.length() +1; i++) {
    result = target.regionMatches(i,research,0,research.length()) ;
    if (result) break ;
  }
  return result ;
}
/** 
Tab: Z_VAR
Version 1.0.8
*/
// GLOBAL SETTING ////






 







//FLUX RSS or TWITTER ????


//SOUND


//GEOMERATIVE

//TOXIC





// METEO

// SYPHON


//CALLING class or library in Other Class, you must call the PApplet too in your class
PApplet callingClass = this ;
// use for the border of window (top and right)
java.awt.Insets insets; 



int MIN_WINDOW_WIDTH = 128 ; 
int MIN_WINDOW_HEIGHT = 128 ;
// Max value whi is return from the slider controller
int MAX_VALUE_SLIDER = 360 ;
// num obj count in Romanesco Manager
int NUM_OBJ ;




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
//boolean modeP3D, modeP2D, modeOPENGL, modeClassic ;
//spectrum band
int NUM_BANDS = 16 ;
//font
int numFont = 50 ;
//quantity of group object slider
int NUM_GROUP = 1 ;

int NUM_SLIDER_MISC = 30 ;
int NUM_SLIDER_OBJ = 48 ;

int numButtonGlobal = 21 ; // group zero
int numButtonObj  ; 
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

/**
Var item
*/
//raw
int fill_hue_raw, fill_sat_raw, fill_bright_raw, fill_alpha_raw ;
int stroke_hue_raw, stroke_sat_raw, stroke_bright_raw, stroke_alpha_raw ;
float thickness_raw ; 
float size_x_raw, size_y_raw, size_z_raw ;
float canvas_x_raw, canvas_y_raw, canvas_z_raw ;
float font_size_raw ;

float reactivity_raw ;
float speed_x_raw, speed_y_raw, speed_z_raw ;
float spurt_x_raw, spurt_y_raw, spurt_z_raw ;
float dir_x_raw, dir_y_raw, dir_z_raw ;
float jitter_x_raw, jitter_y_raw, jitter_z_raw ;
float swing_x_raw, swing_y_raw, swing_z_raw ;

float quantity_raw, variety_raw ; 
float life_raw, flow_raw, quality_raw ;

float area_raw, angle_raw, scope_raw, scan_raw ;
float alignment_raw, repulsion_raw, attraction_raw, charge_raw ;

float influence_raw, calm_raw, need_raw ;




// String name
String fill_hue_name = "fill_hue" ;     
String fill_sat_name = "fill_sat" ;     
String fill_bright_name= "fill_bright" ;     
String fill_alpha_name = "fill_alpha" ;

String stroke_hue_name = "stroke_hue" ; 
String stroke_sat_name = "stroke_sat" ; 
String stroke_bright_name= "stroke_bright" ; 
String stroke_alpha_name = "stroke_alpha" ;

String thickness_name = "thickness" ; 

String size_x_name = "size_x" ;     
String size_y_name = "size_y" ;     
String size_z_name = "size_z" ;

String font_size_name = "font_size";

String canvas_x_name = "canvas_x" ; 
String canvas_y_name = "canvas_y" ; 
String canvas_z_name = "canvas_z" ;

String reactivity_name = "reactivity" ;

String speed_x_name = "speed_x" ; 
String speed_y_name = "speed_y" ; 
String speed_z_name = "speed_z" ;

String spurt_x_name = "spurt_x" ; 
String spurt_y_name= "spurt_y"; 
String spurt_z_name = "spurt_z" ;

String dir_x_name = "dir_x" ; 
String dir_y_name = "dir_y" ; 
String dir_z_name = "dir_z" ;

String jitter_x_name = "jitter_x" ; 
String jitter_y_name = "jitter_y" ; 
String jitter_z_name = "jitter_z" ;

String swing_x_name = "swing_x" ; 
String swing_y_name = "swing_y" ; 
String swing_z_name = "swing_z";

String quantity_name = "quantity" ; 
String variety_name = "variety"; 

String life_name = "life" ; 
String flow_name = "flow" ; 
String quality_name = "quality";

String area_name = "area" ; 
String angle_name = "angle" ; 
String scope_name = "scope" ; 
String scan_name = "scan" ;

String alignment_name = "alignment" ; 
String repulsion_name = "repulsion" ; 
String attraction_name = "attraction" ; 
String charge_name = "charge" ;

String influence_name = "influence" ; 
String calm_name = "calm" ; 
String need_name = "need" ;



// MIN MAX MAP SLIDER
Vec2 fill_hue_min_max, fill_sat_min_max , fill_bright_min_max , fill_alpha_min_max ;
Vec2 stroke_hue_min_max, stroke_sat_min_max, stroke_bright_min_max, stroke_alpha_min_max  ;
Vec2 thickness_min_max ; 
Vec2 size_x_min_max, size_y_min_max, size_z_min_max ;
Vec2 font_size_min_max ;
Vec2 canvas_x_min_max, canvas_y_min_max, canvas_z_min_max ;

Vec2 reactivity_min_max ;
Vec2 speed_x_min_max, speed_y_min_max, speed_z_min_max ;
Vec2 spurt_x_min_max, spurt_y_min_max, spurt_z_min_max ;
Vec2 dir_x_min_max, dir_y_min_max, dir_z_min_max  ; 
Vec2 jitter_x_min_max, jitter_y_min_max, jitter_z_min_max ;
Vec2 swing_x_min_max, swing_y_min_max, swing_z_min_max ;

Vec2 quantity_min_max, variety_min_max ; 
Vec2 life_min_max, flow_min_max, quality_min_max ;
Vec2 area_min_max, angle_min_max, scope_min_max, scan_min_max ; 

Vec2 alignment_min_max, repulsion_min_max, attraction_min_max, charge_min_max ;
Vec2 influence_min_max, calm_min_max, need_min_max ;


// temp
/* value used to know if the value slider have change or nor */
int fill_hue_temp, fill_sat_temp, fill_bright_temp, fill_alpha_temp ;
int stroke_hue_temp, stroke_sat_temp, stroke_bright_temp, stroke_alpha_temp ;
float thickness_temp; 
float size_x_temp, size_y_temp, size_z_temp ;
float canvas_x_temp, canvas_y_temp, canvas_z_temp ;
float font_size_temp ;

float reactivity_temp ;
float speed_x_temp, speed_y_temp, speed_z_temp ;
float spurt_x_temp, spurt_y_temp, spurt_z_temp ;
float dir_x_temp, dir_y_temp,dir_z_temp ;
float jitter_x_temp, jitter_y_temp, jitter_z_temp ;
float swing_x_temp, swing_y_temp, swing_z_temp ;

float quantity_temp, variety_temp ;
float life_temp, flow_temp, quality_temp ;
float area_temp, angle_temp, scope_temp, scan_temp ;

float alignment_temp, repulsion_temp, attraction_temp, charge_temp ;
float influence_temp, calm_temp, need_temp ;




// item target final
boolean [] first_opening_item ; // used to check if this object is already opening before
int [] fill_item, stroke_item ;
float [] thickness_item ; 
float [] size_x_item, size_y_item, size_z_item ;
float [] font_size_item ;
float [] canvas_x_item, canvas_y_item, canvas_z_item ;

float [] reactivity_item ;
float [] speed_x_item, speed_y_item, speed_z_item ;
float [] spurt_x_item, spurt_y_item, spurt_z_item ;
float [] dir_x_item, dir_y_item, dir_z_item ;
float [] jitter_x_item, jitter_y_item, jitter_z_item ;
float [] swing_x_item, swing_y_item, swing_z_item ;

float [] quantity_item, variety_item ;
float [] life_item, flow_item, quality_item ;

float [] area_item, angle_item, scope_item, scan_item ;
float [] alignment_item, repulsion_item, attraction_item, charge_item ;
float [] influence_item, calm_item, need_item ;

/**
End var item
*/

//font
PFont police ;



//OSC VAR
// button
int whichFont ;

boolean onOffBeat, onOffKick, onOffSnare, onOffHat, onOffCurtain, onOffBackground ;
boolean onOffDirLightOne,       onOffDirLightTwo,       onOffLightAmbient,
        onOffDirLightOneAction, onOffDirLightTwoAction, onOffLightAmbientAction ;


int whichShader ; 
int [] which_bitmap, which_text, which_svg, which_movie ;
/**
No text_path_ref ???????
*/
String [] bitmap_path_ref, svg_path_ref, movie_path_ref  ;

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
Vec3 [][] item_setting_position ;
Vec2 [][] item_setting_direction ;
PVector [] eyeCameraSetting, sceneCameraSetting ;
//position
// Vec3 setting_position [] ;
float [] posObjX, posObjY, posObjZ ;
// Vec3 [] pos_item ;

// PVector posObjRef ;
boolean newObjRefPos ;
PVector [] posObj, dirObj ;
Vec3 [] posObjRef ;
//orientation
float [] dirObjX, dirObjY ;
PVector dirObjRef ;
boolean newObjRefDir ;

//position of object and wheel
Vec3 [] mouse, pen ;
boolean [] clickShortLeft, clickShortRight, clickLongLeft, clickLongRight;
int wheel[] ;
//pen info

//boolean object
boolean [] motion, horizon, setting, reverse, clearList ;

//main font for each object
String [] pathFontTTF, pathFontVLW, pathFontObjTTF ;
PFont font[]  ;



















//init var
public void create_variable() {
  numObj = rpe_manager.numClasses + 1 ;
  //BUTTON CONTROLER
  numButtonObj = numObj*10 ;
  createMiscVar() ;
  create_variableButton() ;
  create_variableSound() ;
  create_variableP3D(numObj, numSettingCamera, numSettingOrientationObject) ;
  create_variableCursor() ;
  create_var_item() ;
  rpe_manager.initObj() ;
  println("create_variable done") ;
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
  bitmap_import = new PImage[numObj] ;
  which_bitmap = new int[numObj] ;
  bitmap_path_ref = new String[numObj] ;
  // SVG
  svg_import = new RPEsvg[numObj] ;
  which_svg = new int[numObj] ;
  svg_path_ref = new String[numObj] ;

  // Movie
  movieImport = new Movie[numObj] ;
  movieImportPath = new String[numObj] ;
  which_movie = new int[numObj] ;
  movie_path_ref = new String[numObj] ;
  // TEXT
  text_import = new String [numObj] ;
  which_text = new int[numObj] ;
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
public void create_variableCursor() {
  //position of object and wheel
   mouse  = new Vec3[numObj] ;
   clickShortLeft = new boolean [numObj] ;
   clickShortRight = new boolean [numObj] ;
   clickLongLeft = new boolean [numObj] ;
   clickLongRight = new boolean [numObj] ;
   wheel = new int [numObj] ;
  //pen info
   pen = new Vec3[numObj] ;
}
// P3D
public void create_variableP3D(int numObj, int numSettingCamera, int numSettingOrientationObject) {
   // setting and save
   eyeCameraSetting = new PVector [numSettingCamera] ;
   sceneCameraSetting = new PVector [numSettingCamera] ;

   item_setting_position = new Vec3 [numSettingOrientationObject] [numObj] ;
   item_setting_direction = new Vec2 [numSettingOrientationObject] [numObj] ;
   //
   // setting_position = new Vec3[numObj] ;
   posObjX = new float[numObj] ;
   posObjY = new float[numObj] ;
   posObjZ = new float[numObj] ;
   
   // orientation
   dirObjX = new float[numObj] ;
   dirObjY = new float[numObj] ;
   posObjRef = new Vec3[numObj] ;
   posObj = new PVector[numObj] ;
   dirObj = new PVector[numObj] ;
}

public void create_variableSound() {
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
public void create_variableButton() {
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

public void create_var_item() {
 
  // VAR object
  first_opening_item = new boolean[numObj] ; // used to check if this object is already opening before
  fill_item = new int[numObj] ;
  stroke_item = new int[numObj] ;
  // column 2
  thickness_item = new float[numObj] ; 

  size_x_item = new float[numObj] ; 
  size_y_item = new float[numObj] ; 
  size_z_item = new float[numObj] ;

  font_size_item = new float[numObj] ;

  canvas_x_item = new float[numObj] ; 
  canvas_y_item = new float[numObj] ; 
  canvas_z_item = new float[numObj] ;

   //column 3
  reactivity_item = new float[numObj] ;

  speed_x_item = new float[numObj] ; 
  speed_y_item = new float[numObj] ;
  speed_z_item = new float[numObj] ;

  spurt_x_item = new float[numObj] ; 
  spurt_y_item = new float[numObj] ;
  spurt_z_item = new float[numObj] ;

  dir_x_item = new float[numObj] ; 
  dir_y_item = new float[numObj] ;
  dir_z_item = new float[numObj] ;

  jitter_x_item = new float[numObj] ; 
  jitter_y_item = new float[numObj] ;
  jitter_z_item = new float[numObj] ;

  swing_x_item = new float[numObj] ; 
  swing_y_item = new float[numObj] ;
  swing_z_item = new float[numObj] ;

  quantity_item = new float[numObj] ; 
  variety_item = new float[numObj] ; 

  life_item = new float[numObj] ;
  flow_item = new float[numObj] ;
  quality_item = new float[numObj] ;

  area_item = new float[numObj] ;
  angle_item = new float[numObj] ;
  scope_item = new float[numObj] ;
  scan_item = new float[numObj] ;

  alignment_item = new float[numObj] ;
  repulsion_item = new float[numObj] ;
  attraction_item = new float[numObj] ;
  charge_item = new float[numObj] ;


  influence_item = new float[numObj] ;
  calm_item = new float[numObj] ;
  need_item = new float[numObj] ;
}
// END CREATE VAR
//////////////////



// SETTING VAR
//SETUP
public void init_variable_item() {
  dirObjRef = new PVector() ;
  for (int i = 0 ; i < numObj ; i++ ) {
    pen[i] = Vec3() ;
    // use the 250 value for "z" to keep the position light on the front
    mouse[i] = Vec3() ;
    wheel[i] = 0 ;
  }
    // init global var for the color obj preview mode display
  COLOR_FILL_OBJ_PREVIEW = color (0,0,100,30) ; 
  COLOR_STROKE_OBJ_PREVIEW = color (0,0,100,30) ;
}


public void init_variable_item_min_max() {
  float min_size = .1f ;
  float factor_area = PHI ;

  fill_hue_min_max = Vec2(0,360) ; // data from controller value 0 - 360
  fill_sat_min_max = Vec2(0,HSBmode.g) ;     
  fill_bright_min_max = Vec2(0,HSBmode.b) ;     
  fill_alpha_min_max = Vec2(0,HSBmode.a) ;

  stroke_hue_min_max = Vec2(0,360) ; // data from controller value 0 - 360
  stroke_sat_min_max = Vec2(0,HSBmode.g) ; 
  stroke_bright_min_max = Vec2(0,HSBmode.b); 
  stroke_alpha_min_max = Vec2(0,HSBmode.a) ;

  thickness_min_max = Vec2(min_size, PApplet.parseFloat(height)*.33f) ; 

  size_x_min_max = Vec2(min_size, width) ;     
  size_y_min_max = Vec2(min_size, width) ;     
  size_z_min_max = Vec2(min_size, width) ;

  font_size_min_max = Vec2((float)height *.005f, (float)height *.05f);

  canvas_x_min_max = Vec2(width *min_size, width *factor_area) ; 
  canvas_y_min_max = Vec2(width *min_size, width *factor_area); 
  canvas_z_min_max = Vec2(width *min_size, width *factor_area) ;

  reactivity_min_max = Vec2(0,1) ;

  speed_x_min_max = Vec2(0,1) ; 
  speed_y_min_max = Vec2(0,1) ; 
  speed_z_min_max = Vec2(0,1) ;

  spurt_x_min_max = Vec2(0,1) ; 
  spurt_y_min_max = Vec2(0,1) ; 
  spurt_z_min_max = Vec2(0,1) ;

  dir_x_min_max = Vec2(0,360) ; // data from controller value 0 - 360 
  dir_y_min_max = Vec2(0,360) ; //  data from controller value 0 - 360
  dir_z_min_max = Vec2(0,360) ; // data from controller value 0 - 360

  jitter_x_min_max = Vec2(0,1) ; 
  jitter_y_min_max = Vec2(0,1) ; 
  jitter_z_min_max = Vec2(0,1) ;

  swing_x_min_max = Vec2(0,1) ; 
  swing_y_min_max = Vec2(0,1) ; 
  swing_z_min_max = Vec2(0,1) ;

  quantity_min_max = Vec2(0,1) ; 
  variety_min_max = Vec2(0,1) ; 

  life_min_max = Vec2(0,1) ; 
  flow_min_max = Vec2(0,1) ; 
  quality_min_max = Vec2(0,1) ;

  area_min_max = Vec2(width *min_size, width *factor_area) ; 
  angle_min_max = Vec2(0,360) ;  // data from controller value 0 - 360
  scope_min_max = Vec2(width *min_size, width *factor_area) ; 
  scan_min_max = Vec2(0,360) ; // data from controller value 0 - 360

  alignment_min_max = Vec2(0,1) ; 
  repulsion_min_max = Vec2(0,1) ; 
  attraction_min_max = Vec2(0,1) ; 
  charge_min_max = Vec2(0,1) ;

  influence_min_max = Vec2(0,1) ; 
  calm_min_max = Vec2(0,1) ; 
  need_min_max = Vec2(0,1) ;
}
// END SETTING AR


/* 
UPDATE DATA from CONTROLER and PRESCENE
Those value are used to updated the object data value, and updated at the end of the loop the temp value
*/
public void update_raw_value() {
   int minSource = 0 ;
   int smooth_slider = 2 ;
  // fill
  fill_hue_raw = (int)map(valueSlider[1][0], minSource, MAX_VALUE_SLIDER, fill_hue_min_max.x, fill_hue_min_max.y);
  fill_sat_raw = (int)map(valueSlider[1][1], minSource, MAX_VALUE_SLIDER, fill_sat_min_max.x, fill_sat_min_max.y);    
  fill_bright_raw = (int)map(valueSlider[1][2], minSource, MAX_VALUE_SLIDER, fill_bright_min_max.x, fill_bright_min_max.y) ;   
  fill_alpha_raw = (int)map(valueSlider[1][3], minSource, MAX_VALUE_SLIDER, fill_alpha_min_max.x, fill_alpha_min_max.y);
  // stroke
  stroke_hue_raw = (int)map(valueSlider[1][4], minSource, MAX_VALUE_SLIDER, stroke_hue_min_max.x,stroke_hue_min_max.y);   
  stroke_sat_raw = (int)map(valueSlider[1][5], minSource, MAX_VALUE_SLIDER, stroke_sat_min_max.x,stroke_sat_min_max.y);  
  stroke_bright_raw = (int)map(valueSlider[1][6], minSource, MAX_VALUE_SLIDER, stroke_bright_min_max.x, stroke_bright_min_max.y) ; 
  stroke_alpha_raw = (int)map(valueSlider[1][7], minSource, MAX_VALUE_SLIDER, stroke_alpha_min_max.x, stroke_alpha_min_max.y);
  // 
  thickness_raw = map_smooth_start(valueSlider[1][8], minSource, MAX_VALUE_SLIDER, thickness_min_max.x, thickness_min_max.y, smooth_slider) ;
  // size
  size_x_raw = map_smooth_start(valueSlider[1][9], minSource, MAX_VALUE_SLIDER, size_x_min_max.x, size_x_min_max.y, smooth_slider) ;
  size_y_raw = map_smooth_start(valueSlider[1][10], minSource, MAX_VALUE_SLIDER, size_y_min_max.x, size_y_min_max.y, smooth_slider) ;
  size_z_raw = map_smooth_start(valueSlider[1][11], minSource, MAX_VALUE_SLIDER, size_z_min_max.x, size_z_min_max.y, smooth_slider) ;
  // size font
  font_size_raw = map(valueSlider[1][12], minSource, MAX_VALUE_SLIDER, font_size_min_max.x, font_size_min_max.y) ;
  // canvas
  canvas_x_raw = map_smooth_start(valueSlider[1][13], minSource, MAX_VALUE_SLIDER, canvas_x_min_max.x, canvas_x_min_max.y, smooth_slider) ;
  canvas_y_raw = map_smooth_start(valueSlider[1][14], minSource, MAX_VALUE_SLIDER, canvas_y_min_max.x, canvas_y_min_max.y, smooth_slider) ;
  canvas_z_raw = map_smooth_start(valueSlider[1][15], minSource, MAX_VALUE_SLIDER, canvas_z_min_max.x, canvas_z_min_max.y, smooth_slider) ;

  // size font
  reactivity_raw = map(valueSlider[1][16], minSource, MAX_VALUE_SLIDER, reactivity_min_max.x, reactivity_min_max.y) ;
  // speed
  speed_x_raw = map(valueSlider[1][17], minSource, MAX_VALUE_SLIDER, speed_x_min_max.x, speed_x_min_max.y) ;
  speed_y_raw = map(valueSlider[1][18], minSource, MAX_VALUE_SLIDER, speed_y_min_max.x, speed_y_min_max.y) ;
  speed_z_raw = map(valueSlider[1][19], minSource, MAX_VALUE_SLIDER, speed_z_min_max.x, speed_z_min_max.y) ;
  // spurt
  spurt_x_raw = map(valueSlider[1][20], minSource, MAX_VALUE_SLIDER, spurt_x_min_max.x, spurt_x_min_max.y) ;
  spurt_y_raw = map(valueSlider[1][21], minSource, MAX_VALUE_SLIDER, spurt_y_min_max.x, spurt_y_min_max.y) ;
  spurt_z_raw = map(valueSlider[1][22], minSource, MAX_VALUE_SLIDER, spurt_z_min_max.x, spurt_z_min_max.y) ;
  // direction
  dir_x_raw = map(valueSlider[1][23], minSource, MAX_VALUE_SLIDER, dir_x_min_max.x, dir_x_min_max.y) ;
  dir_y_raw = map(valueSlider[1][24], minSource, MAX_VALUE_SLIDER, dir_y_min_max.x, dir_y_min_max.y) ;
  dir_z_raw = map(valueSlider[1][25], minSource, MAX_VALUE_SLIDER, dir_z_min_max.x, dir_z_min_max.y) ;
  // jitter
  jitter_x_raw = map(valueSlider[1][26], minSource, MAX_VALUE_SLIDER, jitter_x_min_max.x, jitter_x_min_max.y) ;
  jitter_y_raw = map(valueSlider[1][27], minSource, MAX_VALUE_SLIDER, jitter_y_min_max.x, jitter_y_min_max.y) ;
  jitter_z_raw = map(valueSlider[1][28], minSource, MAX_VALUE_SLIDER, jitter_z_min_max.x, jitter_z_min_max.y) ;
  // spurt
  swing_x_raw = map(valueSlider[1][29], minSource, MAX_VALUE_SLIDER, swing_x_min_max.x, swing_x_min_max.y) ;
  swing_y_raw = map(valueSlider[1][30], minSource, MAX_VALUE_SLIDER, swing_y_min_max.x, swing_y_min_max.y) ;
  swing_z_raw = map(valueSlider[1][31], minSource, MAX_VALUE_SLIDER, swing_z_min_max.x, swing_z_min_max.y) ;

  // misc
  quantity_raw = map(valueSlider[1][32], minSource, MAX_VALUE_SLIDER, quantity_min_max.x, quantity_min_max.y) ;
  variety_raw = map(valueSlider[1][33], minSource, MAX_VALUE_SLIDER, variety_min_max.x, variety_min_max.y) ;
  // bio
  life_raw = map(valueSlider[1][34], minSource, MAX_VALUE_SLIDER, life_min_max.x, life_min_max.y) ;
  flow_raw = map(valueSlider[1][35], minSource, MAX_VALUE_SLIDER, flow_min_max.x, flow_min_max.y) ;
  quality_raw = map(valueSlider[1][36], minSource, MAX_VALUE_SLIDER, quality_min_max.x, quality_min_max.y) ;
  // radar
  area_raw = map_smooth_start(valueSlider[1][37], minSource, MAX_VALUE_SLIDER, area_min_max.x, area_min_max.y, smooth_slider) ;
  angle_raw = map(valueSlider[1][38], minSource, MAX_VALUE_SLIDER, angle_min_max.x, angle_min_max.y) ;
  scope_raw = map(valueSlider[1][39], minSource, MAX_VALUE_SLIDER, scope_min_max.x, scope_min_max.y) ;
  scan_raw = map(valueSlider[1][40], minSource, MAX_VALUE_SLIDER, scan_min_max.x, scan_min_max.y) ;

  // force or behavior
  alignment_raw = map(valueSlider[1][41], minSource, MAX_VALUE_SLIDER, alignment_min_max.x, alignment_min_max.y) ;
  repulsion_raw = map(valueSlider[1][42], minSource, MAX_VALUE_SLIDER, repulsion_min_max.x, repulsion_min_max.y) ;
  attraction_raw = map(valueSlider[1][43], minSource, MAX_VALUE_SLIDER, attraction_min_max.x, attraction_min_max.y) ;
  charge_raw = map(valueSlider[1][44], minSource, MAX_VALUE_SLIDER, charge_min_max.x, charge_min_max.y) ;


  influence_raw = map(valueSlider[1][45], minSource, MAX_VALUE_SLIDER, influence_min_max.x, influence_min_max.y) ;
  calm_raw = map(valueSlider[1][46], minSource, MAX_VALUE_SLIDER, calm_min_max.x, calm_min_max.y) ;
  need_raw = map(valueSlider[1][47], minSource, MAX_VALUE_SLIDER, need_min_max.x, need_min_max.y) ; 

}


/* Those temp value are used to know is the object value must be updated */
public void update_temp_value() {
  // fill
  fill_hue_temp = fill_hue_raw ;
  fill_sat_temp = fill_sat_raw ;    
  fill_bright_temp = fill_bright_raw ;   
  fill_alpha_temp = fill_alpha_raw ;
  // stroke
  stroke_hue_temp = stroke_hue_raw ; 
  stroke_sat_temp = stroke_sat_raw ;  
  stroke_bright_temp = stroke_bright_raw ; 
  stroke_alpha_temp = stroke_alpha_raw ;
  //
  thickness_temp= thickness_raw ;
  //size
  size_x_temp = size_x_raw ;
  size_y_temp = size_y_raw ;
  size_z_temp = size_z_raw ;
  // font size
  font_size_temp = font_size_raw ;
  // canvas
  canvas_x_temp = canvas_x_raw ;
  canvas_y_temp = canvas_y_raw ;
  canvas_z_temp = canvas_z_raw ;
  // misc
  reactivity_temp = reactivity_raw ;
  // speed
  speed_x_temp = speed_x_raw ;
  speed_y_temp = speed_y_raw ;
  speed_z_temp = speed_z_raw ;
  // spurt
  spurt_x_temp = spurt_x_raw ;
  spurt_y_temp = spurt_y_raw ;
  spurt_z_temp = spurt_z_raw ;
  // direction
  dir_x_temp = dir_x_raw ;
  dir_y_temp = dir_y_raw ;
  dir_z_temp = dir_z_raw ;
  // jitter
  jitter_x_temp = jitter_x_raw ;
  jitter_y_temp = jitter_y_raw ;
  jitter_z_temp = jitter_z_raw ;
  // direction
  swing_x_temp = swing_x_raw ;
  swing_y_temp = swing_y_raw ;
  swing_z_temp = swing_z_raw ;

  quantity_temp = quantity_raw ;
  variety_temp = variety_raw ;

  life_temp = life_raw ;
  flow_temp = flow_raw ;
  quality_temp = quality_raw ;

  area_temp = area_raw ;
  angle_temp = angle_raw ;
  scope_temp = scope_raw ;
  scan_temp = scan_raw ;
  // force
  alignment_temp = alignment_raw ;
  repulsion_temp = repulsion_raw ;
  attraction_temp = attraction_raw ;
  charge_temp = charge_raw ;

  influence_temp = influence_raw ;
  calm_temp = calm_raw ;
  need_temp = need_raw ;
}


//SHORTCUT VAR
//SOUND
public float allBeats(int ID) {
  return (beat[ID]*.25f) +(kick[ID]*.25f) +(hat[ID]*.25f) +(snare[ID]*.25f) ;
}
// ASPECT

public void aspect_rpe(int ID) {
  if(alpha(fill_item[ID]) == 0 ) noFill() ; else fill(fill_item[ID]) ;
  if(alpha(stroke_item[ID]) == 0 ) noStroke() ; else stroke(stroke_item[ID]) ;
  strokeWeight(thickness_item[ID]) ;
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
public void font_setup() {
  String fontPathVLW = import_path +"font/typoVLW/" ;
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
  String prefixTTF = preference_path +"Font/typoTTF/" ;
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
  // 
  println("font setup done") ;
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
/**
CLASS VEC 1.2.4
RPE \u2013 Romanesco Processing Environment \u2013 2015 \u2013 2016
* @author Stan le Punk
* @see https://github.com/StanLepunK/Vec
* inspireted by GLSL code and PVector from Daniel Shiffman
*/


/**
VEC 2

*/
class Vec2 {
  float ref_x, ref_y = 0 ;
  float x,y = 0;
  float s,t = 0;
  float u,v = 0;
  
  Vec2() {}
  
  Vec2(float value) {
    this.ref_x = this.ref_y = this.x = this.y = this.s = this.t = this.u = this.v = value ;
  }
  
  Vec2(float x, float y) {
    this.ref_x = this.x = this.s = this.u = x ;
    this.ref_y = this.y = this.t = this.v = y ;
  }
  /**
  Random constructor
  */
  Vec2(String key_random, int r1) {
    if(key_random.equals("RANDOM")) {
      this.ref_x = this.x = this.s = this.u = random(-r1,r1) ;
      this.ref_y = this.y = this.t = this.v = random(-r1,r1) ;
    } else if(key_random.equals("RANDOM ZERO")) {
      this.ref_x = this.x = this.s = this.u = random(0,r1) ;
      this.ref_y = this.y = this.t = this.v = random(0,r1) ;
    } else {
      this.ref_x = this.ref_y = this.x = this.y = this.s = this.t = this.u = this.v = 0 ;
      println("the key word for the random is not available use the String 'RANDOM' or 'RANDOM ZERO' ") ;
    }
  }
  
  Vec2(String key_random, int r1, int r2) {
    if(key_random.equals("RANDOM")) {
      this.ref_x = this.x = this.s = this.u = random(-r1,r1) ;
      this.ref_y = this.y = this.t = this.v = random(-r2,r2) ;
    } else if(key_random.equals("RANDOM ZERO")) {
      this.ref_x = this.x = this.s = this.u = random(0,r1) ;
      this.ref_y = this.y = this.t = this.v = random(0,r2) ;
    } else if(key_random.equals("RANDOM RANGE")) {
      this.ref_x = this.x = this.s = this.u = random(r1,r2) ;
      this.ref_y = this.y = this.t = this.v = random(r1,r2) ;
    } else {
      this.ref_x = this.ref_y = this.x = this.y = this.s = this.t = this.u = this.v = 0 ;
      println("the key word for the random is not available use the String 'RANDOM' or 'RANDOM ZERO' or 'RANDOM RANGE' ") ;
    }
  }

  Vec2(String key_random, int a1, int a2, int b1, int b2) {
    if(key_random.equals("RANDOM RANGE")) {
      this.ref_x = this.x = this.s = this.u = random(a1,a2) ;
      this.ref_y = this.y = this.t = this.v = random(b1,b2) ;
    } else {
      this.ref_x = this.ref_y = this.x = this.y = this.s = this.t = this.u = this.v = 0 ;
      println("the key word for the random is not available use the String 'RANDOM RANGE' ") ;
    }
  }
  /**
  Set
  */
   /**
   * Sets components of the vector using two or three separate
   * variables, the data from a Vec, or the values from a float array.
   */
  public Vec2 set(float value) {
     this.x = this.s = this.u = this.y = this.t = this.v = value ;
     /*
    this.x = value ;
    this.s = value ;
    this.u = value ;

    this.y = value ;
    this.t = value ;
    this.v = value ;
    */
    return this;
  }
  public Vec2 set(float x, float y) {
    this.x = x ;
    this.s = x ;
    this.u = x ;

    this.y = y ;
    this.t = y ;
    this.v = y ;
    return this;
  }


  /**
   * @param v any variable of type Vec
   */
  public Vec2 set(Vec2 value) {
    this.x = value.x ;
    this.s = value.x ;
    this.u = value.x ;

    this.y = value.y ;
    this.t = value.y ;
    this.v = value.y ;
    return this;
  }


  /**
   * Set the x, y (and maybe z) coordinates using a float[] array as the source.
   * @param source array to copy from
   */
  public Vec2 set(float[] source) {
    this.x = source[0];
    this.s = source[0];
    this.u = source[0];

    this.y = source[1];
    this.t = source[1];
    this.v = source[1];
    return this;
  }

  
  
  
  
  
  
  
  
  /**
  multiplication
  */
  /* multiply Vector by a same float value */
  public Vec2 mult(float mult) {
    x *= mult ; 
    y *= mult ;

    set(x,y) ;
    return new Vec2(x,y);
  }
  
  /* multiply Vector by different float value */
  public Vec2 mult(float mult_x, float mult_y) {
    x *= mult_x ; 
    y *= mult_y ;

    set(x,y) ;
    return new Vec2(x,y);
  }
  
  // mult by vector
  public Vec2 mult(Vec2 v_a) {
    x *= v_a.x ; 
    y *= v_a.y ; 

    set(x,y) ;
    return new Vec2(x,y);
  }
  
  /**
  division
  */
  /*
  divide Vector by a float value */
  public Vec2 div(float div) {
    x /= div ; y /= div ; 
    
    set(x,y) ;
    return new Vec2(x,y);
    
  }
  
  // divide by vector
  public Vec2 div(Vec2 v_a) {
    x /= v_a.x ; y /= v_a.y ;  
    
    set(x,y) ;
    return new Vec2(x,y);
  }
  
  
  /** 
  Addition
  */
  /* add float value */
  public Vec2 add(float value) {
    x += value ;
    y += value ;
    
    set(x,y) ;
    return new Vec2(x,y);
  }

  public Vec2 add(float value_a, float value_b) {
    x += value_a ;
    y += value_b ;
    
    set(x,y) ;
    return new Vec2(x,y);
  }
  /* add Vector */
  public Vec2 add(Vec2 v_a) {
    x += v_a.x ;
    y += v_a.y ;
    
    set(x,y) ;
    return new Vec2(x,y);
  }
  /* add two Vector together */
  public Vec2 add(Vec2 v_a, Vec2 v_b) {
    x = v_a.x + v_b.x ;
    y = v_a.y + v_b.y ;
    
    set(x,y) ;
    return new Vec2(x,y);
  }


  /**
  Substraction
  */
    /* add float value */
  public Vec2 sub(float value) {
    x -= value ;
    y -= value ;
    
    set(x,y) ;
    return new Vec2(x,y);
  }
  public Vec2 sub(float value_a,float value_b) {
    x -= value_a ;
    y -= value_b ;
    
    set(x,y) ;
    return new Vec2(x,y);
  }
  /* add one Vector */
  public Vec2 sub(Vec2 v_a) {
    x -= v_a.x ;
    y -= v_a.y ;
    
    set(x,y) ;
    return new Vec2(x,y);
  }
  
  /* add two Vector together */
  public Vec2 sub(Vec2 v_a, Vec2 v_b) {
    x = v_a.x - v_b.x ;
    y = v_a.y - v_b.y ;
    
    set(x,y) ;
    return new Vec2(x,y);
  }


    /**
  Dot
  */
  public float dot(Vec2 v) {
    return x*v.x + y*v.y;
  }
  public float dot(float x, float y) {
    return this.x*x + this.y*y ;
  }

  
  
  /**
  Direction
  */
  //return mapping vector
  // @return Vec2
  public Vec2 dir() {
    return dir(Vec2(0)) ;
  }
  public Vec2 dir(float a_x, float a_y) {
    return dir(Vec2(a_x,a_y)) ;
  }
  public Vec2 dir(Vec2 origin) {
    float dist = dist(origin) ;
    sub(origin) ;
    div(dist) ;

    set(x,y) ;
    return new Vec2(x,y);
  }


  /**
  Tangent
  */
  public Vec2 tan() {
    return tan(Vec2(x,y)) ;
  }
  public Vec2 tan(float a_x, float a_y) {
    return tan(Vec2(a_x,a_y)) ;
  }

  public Vec2 tan(Vec2 target) {
    float mag = mag() ;
    target.div(mag) ;
    x = -target.y ;
    y = target.x ;

    set(x,y) ;
    return new Vec2(x,y) ;
  }
  

  /**
  Min Max
  */
    // find the min and the max value in the vector list
  // @ float
  public float max_vec() {
    float [] list = { x, y} ;
    return max(list) ;
  }
  public float min_vec() {
    float [] list = { x, y} ;
    return min(list) ;
  }

  /**
  Normalize
  */
  /*
  return mapping vector
  @return Vec2
  */
  public Vec2 normalize(Vec2 min, Vec2 max) {
    x = map(x, min.x, max.x, 0, 1) ;
    y = map(y, min.y, max.y, 0, 1) ;
    
    set(x,y) ;
    return new Vec2(x,y) ;
  }
  
  public Vec2 normalize(Vec2 max) {
    x = map(x, 0, max.x, 0, 1) ;
    y = map(y, 0, max.y, 0, 1) ;
    
    set(x,y) ;
    return new Vec2(x,y) ;
  }

  /**
 Map
  */
  /*
  return mapping vector
  @return Vec2
  */
  public Vec2 mapVec(float minIn, float maxIn, float minOut, float maxOut) {
    x = map(x,minIn, maxIn, minOut, maxOut) ;
    y = map(y,minIn, maxIn, minOut, maxOut) ;
    
    set(x,y) ;
    return new Vec2(x,y) ;
  }
  
   /**
  Mag
  */
  /* magnitude or length of Vec2
  @ return float
  */
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
  
  
  /**
  Distance
  */
  /*
  @ return float
  distance between himself and an other vector
  */
  public float dist(Vec2 v_target) {
    float dx = x - v_target.x;
    float dy = y - v_target.y;
    return (float) Math.sqrt(dx*dx + dy*dy);
  }
  
  
  /**
  Jitter
  */
  /* create jitter effect around the vector position */
  /* with global range */
  public Vec2 jitter(int range) {
    return jitter(range,range) ;
  }
  public Vec2 jitter(Vec2 range) {
    return jitter((int)range.x,(int)range.y) ;
  }
  /* with specific range */
  public Vec2 jitter(int range_x,int range_y) {
    x = ref_x ;
    y = ref_y ;
    x += random(-range_x, range_x) ;
    y += random(-range_y, range_y) ;
    
    set(x,y) ;
    return new Vec2(x,y) ;
  }
  
  
  /**
  Circular
  */
  /* create a circular motion effect */
  public Vec2 revolution(int radius, float speed) {
    float new_speed = speed *.01f ; 
    x = ref_x ;
    y = ref_y ;
    float m_x = sin(frameCount *new_speed) ;
    float m_y = cos(frameCount *new_speed) ;
    m_x *=radius ;
    m_y *=radius ;
    
    return new Vec2(x +m_x, y +m_y) ;
  }
  
  /**
  Compare
  */
  public boolean compare(Vec2 target) {
    if(target != null ) {
      if((x == target.x) && (y == target.y)) {
              return true ; 
      } else return false ;
    } else return false ;
  }
    public boolean compare(float target) {
    if((x == target) && (y == target)) 
    return true ; 
    else return false ;
  }
  
  public boolean compare(float t_x,float t_y) {
    if((x == t_x) && (y == t_y)) 
    return true ; 
    else return false ;
  }
  
  
  
  /**
  Copy
  */
  /*
  return all the component of Vec
  @return Vec2
  */
  public Vec2 copy() {
    return new Vec2(x,y) ;
  }
  /*
  return all the component of Vec in type PVector
  @return PVector
  */
  public PVector copy_PVector() {
    return new PVector(x,y) ;
  }


  /**
  Print info
  */
  public @Override String toString() {
    return "[ " + x + ", " + y + " ]";
  }
}
// END VEC 2
////////////






/**
VEC 3

*/
class Vec3 {
  float ref_x, ref_y, ref_z = 0 ;
  float x,y,z  = 0 ;
  float r, g, b = 0 ;
  float s, t, p = 0 ;
  
  
  
  /**
  Constructor
  */
  Vec3() {}
  
  Vec3(float value) {
    this.ref_x = this.ref_y = this.ref_z = this.x = this.y = this.z  = this.r = this.g = this.b =this.s = this.t = this.p = value ;
  }
  
  Vec3(float x, float y, float z) {
    this.ref_x = this.x = this.r = this.s = x ;
    this.ref_y = this.y = this.g = this.t = y ;
    this.ref_z = this.z = this.b = this.p = z ;
  }

  Vec3(Vec2 v) {
    this.ref_x = this.x = this.r = this.s = v.x ;
    this.ref_y = this.y = this.g = this.t = v.y ;
    this.ref_z = this.z = this.b = this.p = 0 ;
  }
  
   /**
  Random constructor
  */ 
  // random generator for the Vec
  Vec3(String key_random, int r1) {
    if(key_random.equals("RANDOM")) {
      this.ref_x = this.x = this.r = this.s = random(-r1,r1) ;
      this.ref_y = this.y = this.g = this.t = random(-r1,r1) ;
      this.ref_z = this.z = this.b = this.p = random(-r1,r1) ;
    } else if(key_random.equals("RANDOM ZERO")) {
      this.ref_x = this.x = this.r = this.s = random(0,r1) ;
      this.ref_y = this.y = this.g = this.t = random(0,r1) ;
      this.ref_z = this.z = this.b = this.p = random(0,r1) ;
    } else {
      this.ref_x = this.ref_y = this.ref_z = this.x = this.y = this.z  = this.r = this.g = this.b =this.s = this.t = this.p = 0 ;
      println("the key word for the random is not available use the String 'RANDOM' or 'RANDOM ZERO' ") ;
    }
  }
  
  Vec3(String key_random, int r1, int r2, int r3) {
    if(key_random.equals("RANDOM")) {
      this.ref_x = this.x = this.r = this.s = random(-r1,r1) ;
      this.ref_y = this.y = this.g = this.t = random(-r2,r2) ;
      this.ref_z = this.z = this.b = this.p = random(-r3,r3) ;
    } else if(key_random.equals("RANDOM ZERO")) {
      this.ref_x = this.x = this.r = this.s = random(0,r1) ;
      this.ref_y = this.y = this.g = this.t = random(0,r2) ;
      this.ref_z = this.z = this.b = this.p = random(0,r3) ;
    } else {
      this.ref_x = this.ref_y = this.ref_z = this.x = this.y = this.z  = this.r = this.g = this.b =this.s = this.t = this.p = 0 ;
      println("the key word for the random is not available use the String 'RANDOM' or 'RANDOM ZERO' ") ;
    }
  }

  Vec3(String key_random, int a1, int a2, int b1, int b2, int c1, int c2) {
    if(key_random.equals("RANDOM RANGE")) {
      this.ref_x = this.x = this.r = this.s = random(a1,a2) ;
      this.ref_y = this.y = this.g = this.t = random(b1,b2) ;
      this.ref_z = this.z = this.b = this.p = random(c1,c2) ;
    } else {
      this.ref_x = this.ref_y = this.ref_z = this.x = this.y = this.z  = this.r = this.g = this.b =this.s = this.t = this.p = 0 ;
      println("the key word for the random is not available use the String 'RANDOM RANGE' ") ;
    }
  }



  /**
  Set
  */
   /**
   * Sets components of the vector using two or three separate
   * variables, the data from a Vec, or the values from a float array.
   */
   
   public Vec3 set(float value) {
    this.x = value ;
    this.r = value ;
    this.s = value ;
    this.y = value;
    this.g = value;
    this.t = value ;
    this.z = value;
    this.b = value;
    this.p = value ;
    return this;
  }
  public Vec3 set(float x, float y, float z) {
    this.x = x ;
    this.r = x ;
    this.s = x ;
    this.y = y;
    this.g = y;
    this.t = y ;
    this.z = z;
    this.b = z;
    this.p = z ;
    return this;
  }


  /**
   * @param v any variable of type Vec
   */
  public Vec3 set(Vec3 value) {
    this.x = value.x ;
    this.r = value.x ;
    this.s = value.x ;

    this.y = value.y ;
    this.g = value.y ;
    this.t = value.y ;

    this.z = value.z ;
    this.b = value.z ;
    this.p = value.z ;
    return this;
  }


  /**
   * Set the x, y (and maybe z) coordinates using a float[] array as the source.
   * @param source array to copy from
   */
  public Vec3 set(float[] source) {
    this.x = source[0] ;
    this.r = source[0] ;
    this.s = source[0] ;

    this.y = source[1] ;
    this.g = source[1] ;
    this.t = source[1] ;

    this.z = source[2] ;
    this.b = source[2] ;
    this.p = source[2] ;
    return this;
  }
  
  
  
  
  
  
  
  
  
  
  
  /**
  METHOD
  */
  /**
  Mult
  */
  /* multiply Vector by a same float value */
  public Vec3 mult(float mult) {
    x *= mult ; y *= mult ; z *= mult ;
    
    set(x,y,z) ;
    return new Vec3(x,y,z) ;
  }
  
  /* multiply Vector by a different float value */
  public Vec3 mult(float mult_x, float mult_y, float mult_z) {
    x *= mult_x ; y *= mult_y ; z *= mult_z ;
    
    set(x,y,z) ;
    return new Vec3(x,y,z) ;
  }
  
  // mult by vector
  public Vec3 mult(Vec3 v_a) {
    x *= v_a.x ; y *= v_a.y ; z *= v_a.z ; 
    
    set(x,y,z) ;
    return new Vec3(x,y,z) ;
  }
  
  
  
  /**
  Division
  */
  /*
  @ return Vec
  divide Vector by a float value */
  public Vec3 div(float div) {
    x /= div ; y /= div ; z /= div ;
    
    set(x,y,z) ;
    return new Vec3(x,y,z) ;
  }
  
  // divide by vector
  public Vec3 div(Vec3 v_a) {
    x /= v_a.x ; y /= v_a.y ; z /= v_a.z ; 
    
    set(x,y,z) ;
    return new Vec3(x,y,z) ;
  }
  
  
  
  /**
  Addition
  */
    /* add float value */
  public Vec3 add(float value) {
    x += value ;
    y += value ;
    z += value ;
    
    set(x,y,z) ;
    return new Vec3(x,y,z) ;
  }
  public Vec3 add(float value_a,float value_b,float value_c) {
    x += value_a ;
    y += value_b ;
    z += value_c ;
    
    set(x,y,z) ;
    return new Vec3(x,y,z) ;
  }
  /* add one Vector */
  public Vec3 add(Vec3 v_a) {
    x += v_a.x ;
    y += v_a.y ;
    z += v_a.z ;
    
    set(x,y,z) ;
    return new Vec3(x,y,z) ;
  }
  
  /* add two Vector together */
  public Vec3 add(Vec3 v_a, Vec3 v_b) {
    x = v_a.x + v_b.x ;
    y = v_a.y + v_b.y ;
    z = v_a.z + v_b.z ;

    set(x,y,z) ;
    return new Vec3(x,y,z) ;
  }



  /**
  Substraction
  */
    /* add float value */
  public Vec3 sub(float value) {
    x -= value ;
    y -= value ;
    z -= value ;
    
    set(x,y,z) ;
    return new Vec3(x,y,z) ;
  }
  public Vec3 sub(float value_a,float value_b,float value_c) {
    x -= value_a ;
    y -= value_b ;
    z -= value_c ;

    set(x,y,z) ;
    return new Vec3(x,y,z) ;
  }
  /* add one Vector */
  public Vec3 sub(Vec3 v_a) {
    x -= v_a.x ;
    y -= v_a.y ;
    z -= v_a.z ;

    set(x,y,z) ;
    return new Vec3(x,y,z) ;
  }
  
  /* add two Vector together */
  public Vec3 sub(Vec3 v_a, Vec3 v_b) {
    x = v_a.x - v_b.x ;
    y = v_a.y - v_b.y ;
    z = v_a.z - v_b.z ;

    set(x,y,z) ;
    return new Vec3(x,y,z) ;
  }


  /**
  Dot
  */
  public float dot(Vec3 v) {
    return x*v.x + y*v.y + z*v.z;
  }
  public float dot(float x, float y, float z) {
    return this.x*x + this.y*y + this.z*z;
  }

  /**
  Cross
  */
  public Vec3 cross(Vec3 v) {
    return cross(v, null);
  }
  public Vec3 cross(float x, float y, float z) {
    Vec3 v = Vec3(x,y,z) ;
    return cross(v, null);
  }

  public Vec3 cross(Vec3 v, Vec3 target) {
    float crossX = y*v.z - v.y*z;
    float crossY = z*v.x - v.z*x;
    float crossZ = x*v.y - v.x*y;

    if (target == null) {
      target = Vec3(crossX, crossY, crossZ);
    } else {
      target.set(crossX, crossY, crossZ);
    }
    return target;
  }
  

  /**
  Direction cartesian
  */
  public Vec3 dir() {
    return dir(Vec3(0)) ;
  }
  public Vec3 dir(float a_x, float a_y, float a_z) {
    return dir(Vec3(a_x,a_y,a_z)) ;
  }
  public Vec3 dir(Vec3 origin) {
    float dist = dist(origin) ;
    sub(origin) ;
    div(dist) ;

    set(x,y,z) ;
    return new Vec3(x,y,z) ;
  }
  
  

  /**
  Tangent
  */
  // to find the tangent you need to associate an other vector of your dir vector to create a reference plane.
  public Vec3 tan(float float_to_make_plane_ref_x, float float_to_make_plane_ref_y, float float_to_make_plane_ref_z) {
    return tan(Vec3(float_to_make_plane_ref_x, float_to_make_plane_ref_y, float_to_make_plane_ref_z)) ;
  }

  public Vec3 tan(Vec3 vector_to_make_plane_ref) {
    Vec3 tangent = cross(vector_to_make_plane_ref) ;
    return tangent ;
  }
  

  /**
  Map
  */
  // find the min and the max value in the vector list
  // @ float
  public float max_vec() {
    float [] list = { x, y, z } ;
    return max(list) ;
  }
  public float min_vec() {
    float [] list = { x, y, z } ;
    return min(list) ;
  }





  /**
  Normalize
  */
  /*
  return mapping vector
  @return Vec3
  */
  public Vec3 normalize(Vec3 min, Vec3 max) {
    x = map(x, min.x, max.x, 0, 1) ;
    y = map(y, min.y, max.y, 0, 1) ;
    z = map(z, min.z, max.z, 0, 1) ;
    
    set(x,y,z) ;
    return new Vec3(x,y,z) ;
  }
  
  public Vec3 normalize(Vec3 max) {
    x = map(x, 0, max.x, 0, 1) ;
    y = map(y, 0, max.y, 0, 1) ;
    z = map(z, 0, max.z, 0, 1) ;

    set(x,y,z) ;
    return new Vec3(x,y,z) ;
  }

  /**
  Map
  */
  /*
  return mapping vector
  @return Vec3
  */
  public Vec3 mapVec(float minIn, float maxIn, float minOut, float maxOut) {
    x = map(x, minIn, maxIn, minOut, maxOut) ;
    y = map(y, minIn, maxIn, minOut, maxOut) ;
    z = map(z, minIn, maxIn, minOut, maxOut) ;

    set(x,y,z) ;
    return new Vec3(x,y,z) ;
  }
  
  
  
  /**
  Magnitude
  */
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
  
  /**
  Distance
  */
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
  
  /**
  Jitter
  */
  /* create jitter effect around the vector position */
  /* with global range */
  public Vec3 jitter(int range) {
    return jitter(range,range,range) ;
  }
  public Vec3 jitter(Vec3 range) {
    return jitter((int)range.x,(int)range.y,(int)range.z) ;
  }
  /* with specific range */
  public Vec3 jitter(int range_x,int range_y,int range_z) {
    x = ref_x ;
    y = ref_y ;
    z = ref_z ;
    x += random(-range_x, range_x) ;
    y += random(-range_y, range_y) ;
    z += random(-range_z, range_z) ;

    set(x,y,z) ;
    return new Vec3(x,y,z) ;
  }
  
  
  
  /**
  Circular
  */
  /* create a circular motion effect */
  public Vec3 revolutionX(int rx, int ry, float speed) {
    return revolutionX(Vec2(rx,ry), speed) ;
  }
  public Vec3 revolutionX(int r, float speed) {
    return revolutionX(Vec2(r,r), speed) ;
  }
  public Vec3 revolutionX(Vec2 radius, float speed) {
    float new_speed = speed *.01f ; 
    x = ref_x ;
    y = ref_y ;
    float m_x = sin(frameCount *new_speed) ;
    float m_y = cos(frameCount *new_speed) ;
    m_x *=radius.x ;
    m_y *=radius.y ;
    return new Vec3(x +m_x, y +m_y, z) ;
  }
  //
  public Vec3 revolutionY(int rx, int ry, float speed) {
    return revolutionY(Vec2(rx,ry), speed) ;
  }
  public Vec3 revolutionY(int r, float speed) {
    return revolutionY(Vec2(r,r), speed) ;
  }
  public Vec3 revolutionY(Vec2 radius, float speed) {
    float new_speed = speed *.01f ; 
    x = ref_x ;
    z = ref_z ;
    float m_x = sin(frameCount *new_speed) ;
    float m_z = cos(frameCount *new_speed) ;
    m_x *=radius.x ;
    m_z *=radius.y ;
    return new Vec3(x +m_x, y, z +m_z) ;
  }
  //
  public Vec3 revolutionZ(int rx, int ry, float speed) {
    return revolutionZ(Vec2(rx,ry), speed) ;
  }
    public Vec3 revolutionZ(int r, float speed) {
    return revolutionZ(Vec2(r,r), speed) ;
  }
  public Vec3 revolutionZ(Vec2 radius, float speed) {
    float new_speed = speed *.01f ; 
    y = ref_y ;
    z = ref_z ;
    float m_y = sin(frameCount *new_speed) ;
    float m_z = cos(frameCount *new_speed) ;
    m_y *=radius.x ;
    m_z *=radius.y ;
    return new Vec3(x, y +m_y, z +m_z) ;
  }
  
  
  /**
  Compare
  */
  public boolean compare(Vec3 target) {
    if(target != null ) {
      if((x == target.x) && (y == target.y) && (z == target.z)) {
              return true ; 
      } else return false ;
    } else return false ;
  }
  
  public boolean compare(float target) {
    if((x == target) && (y == target) && (z == target)) 
    return true ; 
    else return false ;
  }
  
  public boolean compare(float t_x,float t_y,float t_z) {
    if((x == t_x) && (y == t_y) && (z == t_z)) 
    return true ; 
    else return false ;
  }
  


  
  
  /**
  Copy
  */
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
  public PVector copy_PVector() {
    return new PVector(x,y,z) ;
  }

  /**
  Print info
  */
  public @Override String toString() {
    return "[ " + x + ", " + y + ", " + z + " ]";
  }
  
  
}
// END VEC 3
////////////





/**
VEC 4

*/
class Vec4 {
  float ref_x, ref_y, ref_z, ref_w = 0 ;
  float x,y,z,w = 0 ;
  float r, g, b, a = 0 ;
  float s, t, p, q = 0 ;
  /**
  Constructor
  */
  Vec4 () {}
  
  Vec4(float value) {
    this.ref_x = this.ref_y = this.ref_z = this.ref_w = this.x = this.y = this.z = this.w = this.r = this.g = this.b = this.a =this.s = this.t = this.p = this.q = value ;
  }
  
  Vec4(float x, float y, float z, float w) {
    this.ref_x = this.x = this.r = this.s = x ;
    this.ref_y = this.y = this.g = this.t = y ;
    this.ref_z = this.z = this.b = this.p = z ;
    this.ref_w = this.w = this.a = this.q = w ;
  }

  Vec4(Vec3 v) {
    this.ref_x = this.x = this.r = this.s = v.x ;
    this.ref_y = this.y = this.g = this.t = v.y ;
    this.ref_z = this.z = this.b = this.p = v.z ;
    this.ref_w = this.w = this.a = this.q = 0 ;
  }

  Vec4(Vec2 v) {
    this.ref_x = this.x = this.r = this.s = v.x ;
    this.ref_y = this.y = this.g = this.t = v.y ;
    this.ref_z = this.z = this.b = this.p = 0 ;
    this.ref_w = this.w = this.a = this.q = 0 ;
  }

  Vec4(Vec2 v1, Vec2 v2) {
    this.ref_x = this.x = this.r = this.s = v1.x ;
    this.ref_y = this.y = this.g = this.t = v1.y ;
    this.ref_z = this.z = this.b = this.p = v2.x ;
    this.ref_w = this.w = this.a = this.q = v2.y ;
  }




  /**
  Random constructor
  */ 
  // random generator for the Vec
  Vec4(String key_random, int r1) {
    if(key_random.equals("RANDOM")) {
      this.ref_x = this.x = this.r =this.s = random(-r1,r1) ;
      this.ref_y = this.y = this.g =this.t = random(-r1,r1) ;
      this.ref_z = this.z = this.b = this.p = random(-r1,r1) ;
      this.ref_w = this.w = this.a = this.q = random(-r1,r1) ;
    } else if(key_random.equals("RANDOM ZERO")) {
      this.ref_x = this.x = this.r =this.s = random(0,r1) ;
      this.ref_y = this.y = this.g =this.t = random(0,r1) ;
      this.ref_z = this.z = this.b = this.p = random(0,r1) ;
      this.ref_w = this.w = this.a = this.q = random(0,r1) ;
    } else {
      this.ref_x = this.ref_y = this.ref_z = this.ref_w = this.x = this.y = this.z = this.w = this.r = this.g = this.b = this.a =this.s = this.t = this.p = this.q = 0 ;
      println("the key word for the random is not available use the String 'RANDOM' or 'RANDOM ZERO' ") ;
    }
  }
  
  Vec4(String key_random, int r1, int r2, int r3, int r4) {
    if(key_random.equals("RANDOM")) {
      this.ref_x = this.x = this.r =this.s = random(-r1,r1) ;
      this.ref_y = this.y = this.g =this.t = random(-r2,r2) ;
      this.ref_z = this.z = this.b = this.p = random(-r3,r3) ;
      this.ref_w = this.w = this.a = this.q = random(-r4,r4) ;
    } else if(key_random.equals("RANDOM ZERO")) {
      this.ref_x = this.x = this.r =this.s = random(0,r1) ;
      this.ref_y = this.y = this.g =this.t = random(0,r2) ;
      this.ref_z = this.z = this.b = this.p = random(0,r3) ;
      this.ref_w = this.w = this.a = this.q = random(0,r4) ;
    } else {
      this.ref_x = this.ref_y = this.ref_z = this.ref_w = this.x = this.y = this.z = this.w = this.r = this.g = this.b = this.a =this.s = this.t = this.p = this.q = 0 ;
      println("the key word for the random is not available use the String 'RANDOM' or 'RANDOM ZERO' ") ;
    }
  }

  Vec4(String key_random, int a1, int a2, int b1, int b2, int c1, int c2, int d1, int d2) {
    if(key_random.equals("RANDOM RANGE")) {
      this.ref_x = this.x = this.r = this.s = random(a1,a2) ;
      this.ref_y = this.y = this.g = this.t = random(b1,b2) ;
      this.ref_z = this.z = this.b = this.p = random(c1,c2) ;
      this.ref_w = this.w = this.a = this.q = random(d1,d2) ;
    } else {
      this.ref_x = this.ref_y = this.ref_z = this.x = this.y = this.z  = this.r = this.g = this.b =this.s = this.t = this.p = 0 ;
      println("the key word for the random is not available use the String 'RANDOM RANGE' ") ;
    }
  }
  
  /**
  Set
  */
   /**
   * Sets components of the vector using two or three separate
   * variables, the data from a Vec, or the values from a float array.
   */
  public Vec4 set(float value) {
    this.x = value ;
    this.r = value ;
    this.s = value ;
    this.y = value ;
    this.g = value ;
    this.t = value ;
    this.z = value ;
    this.b = value ;
    this.p = value ;
    this.w = value ;
    this.a = value ;
    this.q = value ;
    return this;
  }
  
  
  public Vec4 set(float x, float y, float z, float w) {
    this.x = x ;
    this.r = x ;
    this.s = x ;
    this.y = y ;
    this.g = y ;
    this.t = y ;
    this.z = z ;
    this.b = z ;
    this.p = z ;
    this.w = w ;
    this.a = w ;
    this.q = w ;
    return this;
  }


  /**
   * @param v any variable of type Vec
   */
  public Vec4 set(Vec4 value) {
    this.x = value.x ;
    this.r = value.x ;
    this.s = value.x ;

    this.y = value.y ;
    this.g = value.y ;
    this.t = value.y ;

    this.z = value.z ;
    this.b = value.z ;
    this.p = value.z ;

    this.w = value.w ;
    this.a = value.w ;
    this.q = value.w ;
    return this;
  }


  /**
   * Set the x, y (and maybe z) coordinates using a float[] array as the source.
   * @param source array to copy from
   */
  public Vec4 set(float[] source) {
    this.x = source[0] ;
    this.r = source[0] ;
    this.s = source[0] ;

    this.y = source[1] ;
    this.g = source[1] ;
    this.t = source[1] ;

    this.z = source[2] ;
    this.b = source[2] ;
    this.p = source[2] ;

    this.w = source[3] ;
    this.a = source[3] ;
    this.q = source[3] ;
    return this;
  }



  /** 
  METHOD
  */
  /**
  Multiplication
  */
  // mult by a same float
  public Vec4 mult(float mult) {
    x *= mult ; y *= mult ; z *= mult ; w *= mult ;

    set(x,y,z,w) ;
    return new Vec4(x,y,z,w) ;
  }
  
    // mult by a different float
  public Vec4 mult(float mult_x, float mult_y, float mult_z, float mult_w) {
    x *= mult_x ; y *= mult_y ; z *= mult_z ; w *= mult_w ;

    set(x,y,z,w) ;
    return new Vec4(x,y,z,w) ;
  }
  
  // mult by vector
  public Vec4 mult(Vec4 v_a) {
    x *= v_a.x ; y *= v_a.y ; z *= v_a.z ; w *= v_a.w ;

    set(x,y,z,w) ;
    return new Vec4(x,y,z,w) ;
  }
  
  
  /**
  Division
  */
  /*
  @ return Vec
  divide Vector by a float value */
  public Vec4 div(float div) {
    x /= div ; y /= div ; z /= div ; w /= div ;
    
    set(x,y,z,w) ;
    return new Vec4(x,y,z,w) ;
  }
  
  // divide by vector
  public Vec4 div(Vec4 v_a) {
    x /= v_a.x ; y /= v_a.y ; z /= v_a.z ; w /= v_a.w ;
    
    set(x,y,z,w) ;
    return new Vec4(x,y,z,w) ;
  }
  
  
  /**
  Addition
  */
    /* add float value */
  public Vec4 add(float value) {
    x += value ;
    y += value ;
    z += value ;
    w += value ;
    
    set(x,y,z,w) ;
    return new Vec4(x,y,z,w) ;
  }
  public Vec4 add(float value_a,float value_b,float value_c,float value_d) {
    x += value_a ;
    y += value_b ;
    z += value_c ;
    w += value_d ;
    
    set(x,y,z,w) ;
    return new Vec4(x,y,z,w) ;
  }
  /* add vec */
  public Vec4 add(Vec4 v_a) {
    x += v_a.x ;
    y += v_a.y ;
    z += v_a.z ;
    w += v_a.w ;
    
    set(x,y,z,w) ;
    return new Vec4(x,y,z,w)  ;
  }
  /* add two Vector together */
  public Vec4 add(Vec4 v_a, Vec4 v_b) {
    x = v_a.x + v_b.x ;
    y = v_a.y + v_b.y ;
    z = v_a.z + v_b.z ;
    w = v_a.w + v_b.w ;
    
    set(x,y,z,w) ;
    return new Vec4(x,y,z,w) ;
  }

  /**
  Substraction
  */
    /* add float value */
  public Vec4 sub(float value) {
    x -= value ;
    y -= value ;
    z -= value ;
    w -= value ;
    
    set(x,y,z,w) ;
    return new Vec4(x,y,z,w) ;
  }
  public Vec4 sub(float value_a,float value_b,float value_c, float value_d) {
    x -= value_a ;
    y -= value_b ;
    z -= value_c ;
    w -= value_d ;
    
    set(x,y,z,w) ;
    return new Vec4(x,y,z,w) ;
  }
  /* add one Vector */
  public Vec4 sub(Vec4 v_a) {
    x -= v_a.x ;
    y -= v_a.y ;
    z -= v_a.z ;
    w -= v_a.w ;
    
    set(x,y,z,w) ;
    return new Vec4(x,y,z,w) ;
  }
  
  /* add two Vector together */
  public Vec4 sub(Vec4 v_a, Vec4 v_b) {
    x = v_a.x - v_b.x ;
    y = v_a.y - v_b.y ;
    z = v_a.z - v_b.z ;
    w = v_a.w - v_b.w ;
    
    set(x,y,z,w) ;
    return new Vec4(x,y,z,w) ;
  }

  /**
  Dot
  */
  public float dot(Vec4 v) {
    return x*v.x + y*v.y + z*v.z + w*this.w;
  }
  public float dot(float x, float y, float z, float w) {
    return this.x*x + this.y*y + this.z*z + this.w*w;
  }



  /**
  Direction cartesian
  */
  public Vec4 dir() {
    return dir(Vec4(0)) ;
  }
  public Vec4 dir(float a_x, float a_y, float a_z, float a_w) {
    return dir(Vec4(a_x,a_y,a_z,a_w)) ;
  }
  public Vec4 dir(Vec4 origin) {
    float dist = dist(origin) ;
    sub(origin) ;
    div(dist) ;

    
    set(x,y,z,w) ;
    return new Vec4(x,y,z,w) ;
  }
  
  /**
  Min Max
  */
    // find the min and the max value in the vector list
  // @ float
  public float max_vec() {
    float [] list = { x, y, z, w } ;
    return max(list) ;
  }
  public float min_vec() {
    float [] list = { x, y, z,w } ;
    return min(list) ;
  }

  /**
  Normalize
  */
  /*
  return mapping vector
  @return Vec3
  */
  public Vec4 normalize(Vec4 min, Vec4 max) {
    x = map(x, min.x, max.x, 0, 1) ;
    y = map(y, min.y, max.y, 0, 1) ;
    z = map(z, min.z, max.z, 0, 1) ;
    w = map(w, min.w, max.w, 0, 1) ;
    
    set(x,y,z,w) ;
    return new Vec4(x,y,z,w) ;
  }
  

  public Vec4 normalize(Vec4 max) {
    x = map(x, 0, max.x, 0, 1) ;
    y = map(y, 0, max.y, 0, 1) ;
    z = map(z, 0, max.z, 0, 1) ;
    w = map(w, 0, max.w, 0, 1) ;
    
    set(x,y,z,w) ;
    return new Vec4(x,y,z,w) ;
  }

  /**
  Map
  */
  /* mapping
  return mapping vector
  @return Vec4
  */
  public Vec4 mapVec(float minIn, float maxIn, float minOut, float maxOut) {
    x = map(x, minIn, maxIn, minOut, maxOut) ;
    y = map(y, minIn, maxIn, minOut, maxOut) ;
    z = map(z, minIn, maxIn, minOut, maxOut) ;
    w = map(w, minIn, maxIn, minOut, maxOut) ;
    
    set(x,y,z,w) ;
    return new Vec4(x,y,z,w) ;
  }
  
  /**
  Magnitude or length
 */
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
  
  /**
  Distance
  */
  // distance himself and an other vector
  public float dist(Vec4 v_target) {
    float dx = x - v_target.x;
    float dy = y - v_target.y;
    float dz = z - v_target.z;
    float dw = w - v_target.w;
    return (float) Math.sqrt(dx*dx + dy*dy + dz*dz + dw*dw);
  }
  
  
  /**
  Jitter
  */
  /* create jitter effect around the vector position */
  /* with global range */
  public Vec4 jitter(int range) {
    return jitter(range,range,range,range) ;
  }
  public Vec4 jitter(Vec4 range) {
    return jitter((int)range.x,(int)range.y,(int)range.z,(int)range.w) ;
  }
  /* with specific range */
  public Vec4 jitter(int range_x,int range_y,int range_z,int range_w) {
    x = ref_x ;
    y = ref_y ;
    z = ref_z ;
    w = ref_w ;
    x += random(-range_x, range_x) ;
    y += random(-range_y, range_y) ;
    z += random(-range_z, range_z) ;
    w += random(-range_z, range_z) ;
    
    set(x,y,z,w) ;
    return new Vec4(x,y,z,w) ;
  }
  
   
  /**
  Compare
  */
  public boolean compare(Vec4 target) {
    if(target != null ) {
      if((x == target.x) && (y == target.y) && (z == target.z) && (w == target.w)) {
              return true ; 
      } else return false ;
    } else return false ;
  }
  public boolean compare(float target) {
    if((x == target) && (y == target) && (z == target) && (w == target)) 
    return true ; 
    else return false ;
  }
  
  public boolean compare(float t_x,float t_y,float t_z,float t_w) {
    if((x == t_x) && (y == t_y) && (z == t_z)&& (w == t_w)) 
    return true ; 
    else return false ;
  }
  
  /**
  Copy
  */
  public Vec4 copy() {
    return new Vec4(x,y,z,w) ;
  }

  /**
  Print info
  */
  public @Override String toString() {
    return "[ " + x + ", " + y + ", " + z + ", " + w + " ]";
  }
}
// END VEC 4
////////////


/**
CLASS Vec5

*/
class Vec5 {
  float a,b,c,d,e = 0 ;

  /**
  Constructor
  */
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

  Vec5(Vec4 v) {
    this.a = v.x ;
    this.b = v.y ;
    this.c = v.z ;
    this.d = v.w ;
    this.e = 0 ;
  }

  Vec5(Vec3 v) {
    this.a = v.x ;
    this.b = v.y ;
    this.c = v.z ;
    this.d = 0 ;
    this.e = 0 ;
  }

  Vec5(Vec2 v) {
    this.a = v.x ;
    this.b = v.y ;
    this.c = 0 ;
    this.d = 0 ;
    this.e = 0 ;
  }

  Vec5(Vec2 v1, Vec2 v2) {
    this.a = v1.x ;
    this.b = v1.y ;
    this.c = v2.x ;
    this.d = v2.y ;
    this.e = 0 ;
  }

  Vec5(Vec3 v1, Vec2 v2) {
    this.a = v1.x ;
    this.b = v1.y ;
    this.c = v1.z ;
    this.d = v2.x ;
    this.e = v2.y ;
  }

  Vec5(Vec2 v1, Vec3 v2) {
    this.a = v1.x ;
    this.b = v1.y ;
    this.c = v2.x ;
    this.d = v2.y ;
    this.e = v2.z ;
  }
  
  
  
  /**
  Random Constructor
  */
  // random generator for the Vec
  Vec5(String key_random, int r1) {
    if(key_random.equals("RANDOM")) {
      this.a = random(-r1,r1) ;
      this.b = random(-r1,r1) ;
      this.c = random(-r1,r1) ;
      this.d = random(-r1,r1) ;
      this.e = random(-r1,r1) ;
    } else if(key_random.equals("RANDOM ZERO")) {
      this.a = random(0,r1) ;
      this.b = random(0,r1) ;
      this.c = random(0,r1) ;
      this.d = random(0,r1) ;
      this.e = random(0,r1) ;
    } else {
      this.a = this.b = this.c = this.d = this.e = 0 ;
      println("the key word for the random is not available use the String 'RANDOM' or 'RANDOM ZERO' ") ;
    }
  }
  
  Vec5(String key_random, int r1, int r2, int r3, int r4, int r5) {
    if(key_random.equals("RANDOM")) {
      this.a = random(-r1,r1) ;
      this.b = random(-r2,r2) ;
      this.c = random(-r3,r3) ;
      this.d = random(-r4,r4) ;
      this.e = random(-r5,r5) ;
    } else if(key_random.equals("RANDOM ZERO")) {
      this.a = random(0,r1) ;
      this.b = random(0,r2) ;
      this.c = random(0,r3) ;
      this.d = random(0,r4) ;
      this.e = random(0,r5) ;
    } else {
      this.a = this.b = this.c = this.d = this.e = 0 ;
      println("the key word for the random is not available use the String 'RANDOM' or 'RANDOM ZERO' ") ;
    }
  }

  Vec5(String key_random, int a1, int a2, int b1, int b2, int c1, int c2, int d1, int d2, int e1, int e2) {
    if(key_random.equals("RANDOM RANGE")) {
      this.a = random(a1,a2) ;
      this.b = random(b1,b2) ;
      this.c = random(c1,c2) ;
      this.d = random(d1,d2) ;
      this.e = random(e1,e2) ;
    } else {
      this.a = this.b = this.c = this.d = this.e = 0 ;
      println("the key word for the random is not available use the String 'RANDOM RANGE' ") ;
    }
  }


  /**
  Set
  */
   /**
   * Sets components of the vector using two or three separate
   * variables, the data from a Vec, or the values from a float array.
   */
   
   public Vec5 set(float value) {
    this.a = value ;
    this.b = value;
    this.c = value;
    this.d = value;
    this.e = value;
    return this;
  }
  
  public Vec5 set(float a, float b, float c, float d, float e) {
    this.a = a ;
    this.b = b;
    this.c = c;
    this.d = d;
    this.e = e;
    return this;
  }


  /**
   * @param v any variable of type Vec
   */
  public Vec5 set(Vec5 value) {
    a = value.a ;
    b = value.b ;
    c = value.c ;
    d = value.d ;
    e = value.e ;
    return this;
  }


  /**
   * Set the x, y (and maybe z) coordinates using a float[] array as the source.
   * @param source array to copy from
   */
  public Vec5 set(float[] source) {
    a = source[0] ;
    b = source[1] ;
    c = source[2] ;
    d = source[3] ;
    e = source[4] ;
    return this;
  }

  /**
  Min Max
  */
    // find the min and the max value in the vector list
  // @ float
  public float max_vec() {
    float [] list = { a,b,c,d,e} ;
    return max(list) ;
  }
  public float min_vec() {
    float [] list = {a,b,c,d,e} ;
    return min(list) ;
  }
  
  /**
  Copy
  */
  public Vec5 copy() {
    return new Vec5(a,b,c,d,e) ;
  }
  
  /**
  Print info
  */
  public @Override String toString() {
    return "[ " + a + ", " + b + ", " + c + ", " + d + ", " + e + " ]";
  }
}

// END VEC 5
////////////


/**
CLASS Vec6

*/
class Vec6 {
  float a,b,c,d,e,f = 0 ;

  /**
  Constructor
  */
  Vec6 () {}
  
  Vec6(float value) {
    this.a = this.b = this.c = this.d = this.e = this.f = value ;
  }
  
  Vec6(float a, float b, float c, float d, float e, float f) {
    this.a = a ;
    this.b = b ;
    this.c = c ;
    this.d = d ;
    this.e = e ;
    this.f = f ;
  }

  Vec6(Vec5 v) {
    this.a = v.a ;
    this.b = v.b ;
    this.c = v.c ;
    this.d = v.d ;
    this.e = v.e ;
    this.f = 0 ;

  }


  Vec6(Vec4 v) {
    this.a = v.x ;
    this.b = v.y ;
    this.c = v.z ;
    this.d = v.w ;
    this.e = 0 ;
    this.f = 0 ;
  }

  Vec6(Vec3 v) {
    this.a = v.x ;
    this.b = v.y ;
    this.c = v.z ;
    this.d = 0 ;
    this.e = 0 ;
    this.f = 0 ;
  }

  Vec6(Vec2 v) {
    this.a = v.x ;
    this.b = v.y ;
    this.c = 0 ;
    this.d = 0 ;
    this.e = 0 ;
    this.f = 0 ;
  }

  Vec6(Vec2 v1, Vec2 v2) {
    this.a = v1.x ;
    this.b = v1.y ;
    this.c = v2.x ;
    this.d = v2.y ;
    this.e = 0 ;
    this.f = 0 ;
  }

  Vec6(Vec3 v1, Vec3 v2) {
    this.a = v1.x ;
    this.b = v1.y ;
    this.c = v1.z ;
    this.d = v2.x ;
    this.e = v2.y ;
    this.f = v2.z ;
  }

  Vec6(Vec2 v1, Vec2 v2, Vec2 v3) {
    this.a = v1.x ;
    this.b = v1.y ;
    this.c = v2.x ;
    this.d = v2.y ;
    this.e = v3.x ;
    this.f = v3.y ;
  }
  
  Vec6(Vec4 v1, Vec2 v2) {
    this.a = v1.x ;
    this.b = v1.y ;
    this.c = v1.z ;
    this.d = v1.w ;
    this.e = v2.x ;
    this.f = v2.y ;
  }

  Vec6(Vec3 v1, Vec2 v2) {
    this.a = v1.x ;
    this.b = v1.y ;
    this.c = v1.z ;
    this.d = v2.x ;
    this.e = v2.y ;
    this.f = 0 ;
  }

  Vec6(Vec2 v1, Vec3 v2) {
    this.a = v1.x ;
    this.b = v1.y ;
    this.c = v2.x ;
    this.d = v2.y ;
    this.e = v2.z ;
    this.f = 0 ;
  }

  Vec6(Vec2 v1, Vec4 v2) {
    this.a = v1.x ;
    this.b = v1.y ;
    this.c = v2.x ;
    this.d = v2.y ;
    this.e = v2.z ;
    this.f = v2.w ;
  }
  
  /**
  Random Constructor
  */
  Vec6(String key_random, int r1) {
    if(key_random.equals("RANDOM")) {
      this.a = random(-r1,r1) ;
      this.b = random(-r1,r1) ;
      this.c = random(-r1,r1) ;
      this.d = random(-r1,r1) ;
      this.e = random(-r1,r1) ;
    } else if(key_random.equals("RANDOM ZERO")) {
      this.a = random(0,r1) ;
      this.b = random(0,r1) ;
      this.c = random(0,r1) ;
      this.d = random(0,r1) ;
      this.e = random(0,r1) ;
    } else {
      this.a = this.b = this.c = this.d = this.e = this.f = 0 ;
      println("the key word for the random is not available use the String 'RANDOM' or 'RANDOM ZERO' ") ;
    }
  }
  
  Vec6(String key_random, int r1, int r2, int r3, int r4, int r5, int r6) {
    if(key_random.equals("RANDOM")) {
      this.a = random(-r1,r1) ;
      this.b = random(-r2,r2) ;
      this.c = random(-r3,r3) ;
      this.d = random(-r4,r4) ;
      this.e = random(-r5,r5) ;
      this.f = random(-r6,r6) ;
    } else if(key_random.equals("RANDOM")) {
      this.a = random(0,r1) ;
      this.b = random(0,r2) ;
      this.c = random(0,r3) ;
      this.d = random(0,r4) ;
      this.e = random(0,r5) ;
      this.f = random(0,r6) ;
    } else {
      this.a = this.b = this.c = this.d = this.e = this.f = 0 ;
      println("the key word for the random is not available use the String 'RANDOM' or 'RANDOM ZERO' ") ;
    }
  }

  Vec6(String key_random, int a1, int a2, int b1, int b2, int c1, int c2, int d1, int d2, int e1, int e2, int f1, int f2) {
    if(key_random.equals("RANDOM RANGE")) {
      this.a = random(a1,a2) ;
      this.b = random(b1,b2) ;
      this.c = random(c1,c2) ;
      this.d = random(d1,d2) ;
      this.e = random(e1,e2) ;
      this.f = random(f1,f2) ;
    } else {
      this.a = this.b = this.c = this.d = this.e = this.f = 0 ;
      println("the key word for the random is not available use the String 'RANDOM RANGE' ") ;
    }
  }

  /**
  Set
  */
   /**
   * Sets components of the vector using two or three separate
   * variables, the data from a Vec, or the values from a float array.
   */
  public Vec6 set(float a, float b, float c, float d, float e, float f) {
    this.a = a ;
    this.b = b ;
    this.c = c ;
    this.d = d ;
    this.e = e ;
    this.f = f ;
    return this;
  }


  /**
   * @param v any variable of type Vec
   */
  public Vec6 set(Vec6 value) {
    a = value.a ;
    b = value.b ;
    c = value.c ;
    d = value.d ;
    e = value.e ;
    f = value.f ;
    return this;
  }


  /**
   * Set the x, y (and maybe z) coordinates using a float[] array as the source.
   * @param source array to copy from
   */
  public Vec6 set(float[] source) {
    a = source[0] ;
    b = source[1] ;
    c = source[2] ;
    d = source[3] ;
    e = source[4] ;
    f = source[5] ;
    return this;
  }


  /**
  Min Max
  */
      // find the min and the max value in the vector list
  // @ float
  public float max_vec() {
    float [] list = {a,b,c,d,e,f} ;
    return max(list) ;
  }
  public float min_vec() {
    float [] list = {a,b,c,d,e,f} ;
    return min(list) ;
  }

  /**
  Copy
  */
  public Vec6 copy() {
    return new Vec6(a,b,c,d,e,f) ;
  }

  /**
  Print info
  */
  public @Override String toString() {
    return "[ " + a + ", " + b + ", " + c + ", " + d + ", " + e + ", " + f + " ]" ;
  }
}

// END VEC 6
////////////
















/**
External Methods VEC

*/
/**
Addition
*/
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
    float x = v_a.x + v_b.x ;
    float y = v_a.y + v_b.y ;
    float z = v_a.z + v_b.z ;
    float w = v_a.w + v_b.w ;
    return new Vec4(x,y,z, w)  ;
}


/**
Multiplication
*/
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


/**
Division
*/
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


/**
Substraction
*/
// return the resultat of vector substraction
public Vec2 sub(Vec2 v_a, Vec2 v_b) {
    float x = v_a.x - v_b.x ;
    float y = v_a.y - v_b.y ;
    return new Vec2(x,y) ;
}
public Vec3 sub(Vec3 v_a, Vec3 v_b) {
    float x = v_a.x - v_b.x ;
    float y = v_a.y - v_b.y ;
    float z = v_a.z - v_b.z ;
    return new Vec3(x,y,z)  ;
}
public Vec4 sub(Vec4 v_a, Vec4 v_b) {
    float x = v_a.x - v_b.x ;
    float y = v_a.y - v_b.y ;
    float z = v_a.z - v_b.z ;
    float w = v_a.w - v_b.w ;
    return new Vec4(x,y,z, w)  ;
}


/**
Cross
*/
public Vec3 cross(Vec3 v1, Vec3 v2, Vec3 target) {
  float crossX = v1.y * v2.z - v2.y * v1.z;
  float crossY = v1.z * v2.x - v2.z * v1.x;
  float crossZ = v1.x * v2.y - v2.x * v1.y;

  if (target == null) {
    target = Vec3(crossX, crossY, crossZ);
  } else {
    target.set(crossX, crossY, crossZ);
  }
  return target;
}





/**
Compare
*/
/*
Compare Vector with or without area
compare two vectors Vec without area

@ return boolean
*/
// Vec2 compare
public boolean compare(Vec2 v_a, Vec2 v_b) {
  return compare(Vec4(v_a.x,v_a.y,0,0),Vec4(v_b.x,v_b.y,0,0)) ;
}

// Vec3 compare
public boolean compare(Vec3 v_a, Vec3 v_b) {
  return compare(Vec4(v_a.x, v_a.y, v_a.z, 0),Vec4(v_b.x, v_b.y, v_b.z, 0)) ;
}
// Vec4 compare
public boolean compare(Vec4 v_a, Vec4 v_b) {
  if( v_a != null && v_b != null ) {
    if((v_a.x == v_b.x) && (v_a.y == v_b.y) && (v_a.z == v_b.z) && (v_a.w == v_b.w)) {
            return true ; 
    } else return false ;
  } else return false ;
}


/* 
compare if the first vector is in the area of the second vector, 
the area of the second vector is define by a Vec area, 
that give the possibility of different size for each component
*/
/*
@ return boolean
*/
// Vec method
// Vec2 compare with area
public boolean compare(Vec2 v_a, Vec2 v_b, Vec2 area) {
  return compare(Vec4(v_a.x, v_a.y, 0, 0),Vec4(v_b.x, v_b.y, 0, 0),Vec4(area.x, area.y, 0, 0)) ;
}
// Vec3 compare with area
public boolean compare(Vec3 v_a, Vec3 v_b, Vec3 area) {
  return compare(Vec4(v_a.x, v_a.y, v_a.z, 0),Vec4(v_b.x, v_b.y, v_b.z, 0),Vec4(area.x, area.y, area.z, 0)) ;
}
// Vec4 compare with area
public boolean compare(Vec4 v_a, Vec4 v_b, Vec4 area) {
  if( v_a != null && v_b != null && area != null ) {
    if(    (v_a.x >= v_b.x -area.x && v_a.x <= v_b.x +area.x) 
        && (v_a.y >= v_b.y -area.y && v_a.y <= v_b.y +area.y) 
        && (v_a.z >= v_b.z -area.z && v_a.z <= v_b.z +area.z) 
        && (v_a.w >= v_b.w -area.w && v_a.w <= v_b.w +area.w)) {
            return true ; 
    } else return false ;
  } else return false ;
}



/**
Map
*/
/*
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

/**
Magnitude or length
*/
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



/**
Distance
*/
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


/**
Middle
*/
/*
@ return Vec2, Vec3 or Vec4
return the middle between two Vector
*/
public Vec2 middle(Vec2 p1, Vec2 p2)  {
  Vec2 middle ;
  middle = add(p1, p2);
  middle.div(2) ;
  return middle ;
}

public Vec2 middle(Vec2 [] list)  {
  Vec2 middle = Vec2() ;
  for (int i = 0 ; i < list.length ; i++) {
    middle.add(list[i]);
  }
  middle.div(list.length) ;
  return middle ;
}

public Vec3 middle(Vec3 p1, Vec3 p2) {
  Vec3 middle ;
  middle = add(p1, p2);
  middle.div(2) ;
  return middle ;
}

public Vec3 middle(Vec3 [] list)  {
  Vec3 middle = Vec3() ;
  for (int i = 0 ; i < list.length ; i++) {
    middle.add(list[i]);
  }
  middle.div(list.length) ;
  return middle ;
}

public Vec4 middle(Vec4 p1, Vec4 p2)  {
  Vec4 middle ;
  middle = add(p1, p2);
  middle.div(2) ;
  return middle ;
}

public Vec4 middle(Vec4 [] list)  {
  Vec4 middle = Vec4() ;
  for (int i = 0 ; i < list.length ; i++) {
    middle.add(list[i]);
  }
  middle.div(list.length) ;
  return middle ;
}






/**
Copy
*/
/*
@ return Vec3
Transform PVector in Vec
*/
public Vec3 copyPVectorToVec(PVector p) {
  return new Vec3(p.x,p.y,p.z) ;
}



/**
Jitter
*/
// Vec2
public Vec2 jitter_2D(int range) {
  return jitter_2D(range, range) ;
}
public Vec2 jitter_2D(Vec2 range) {
  return jitter_2D((int)range.x, (int)range.y) ;
}
public Vec2 jitter_2D(int range_x, int range_y) {
  Vec2 jitter = Vec2() ;
  jitter.x = random(-range_x, range_x) ;
  jitter.y = random(-range_y, range_y) ;
  return jitter ;
}
// Vec3
public Vec3 jitter_3D(int range) {
  return jitter_3D(range, range, range) ;
}
public Vec3 jitter_3D(Vec3 range) {
  return jitter_3D((int)range.x, (int)range.y, (int)range.z) ;
}
public Vec3 jitter_3D(int range_x, int range_y, int range_z) {
  Vec3 jitter = Vec3() ;
  jitter.x = random(-range_x, range_x) ;
  jitter.y = random(-range_y, range_y) ;
  jitter.z = random(-range_z, range_z) ;
  return jitter ;
}
// Vec4
public Vec4 jitter_4D(int range) {
  return jitter_4D(range, range, range, range) ;
}
public Vec4 jitter_4D(Vec4 range) {
  return jitter_4D((int)range.x, (int)range.y, (int)range.z, (int)range.w) ;
}
public Vec4 jitter_4D(int range_x, int range_y, int range_z, int range_w) {
  Vec4 jitter = Vec4() ;
  jitter.x = random(-range_x, range_x) ;
  jitter.y = random(-range_y, range_y) ;
  jitter.z = random(-range_z, range_z) ;
  jitter.w = random(-range_w, range_w) ;
  return jitter ;
}
// END JITTER
/////////////


/**
Normalize
*/
// VEC 2 from angle
///////////////////
public Vec2 norm_rad(float angle) {
  float x = (float)Math.cos(angle) ;
  float y = (float)Math.sin(angle) ;
  return Vec2(x,y) ;
}

public Vec2 norm_deg(float angle) {
  angle = radians(angle) ;
  float x = (float)Math.cos(angle) ;
  float y = (float)Math.sin(angle) ;
  return Vec2(x,y) ;
}


// normalize direction

public Vec2 norm_dir(String type, float direction) {
  float x, y = 0 ;
  if(type.equals("DEG")) {
    float angle = TWO_PI/360.f;
    direction = 360-direction;
    direction += 180;
    x = sin(angle *direction) ;
    y = cos(angle *direction);
  } else if (type.equals("RAD")) {
    x = sin(direction) ;
    y = cos(direction);
  } else {
    println("the type must be 'RAD' for radians or 'DEG' for degrees") ;
    x = 0 ;
    y = 0 ;
  }
  return new Vec2(x,y) ;
}
// END VEC FROM ANGLE
/////////////////////




/**
Return a new Vec
*/
/**
Vec 2
*/
public Vec2 Vec2(float x, float y) { 
  return new Vec2(x,y) ;
}

public Vec2 Vec2(float v) {
  return new Vec2(v) ;
}

public Vec2 Vec2(PVector p) {
  return new Vec2(p.x, p.y) ;
}

public Vec2 Vec2(Vec2 p) {
  return new Vec2(p.x, p.y) ;
}

public Vec2 Vec2() {
  return new Vec2() ;
}

public Vec2 Vec2(String s, int x, int y) { 
  return new Vec2(s,x,y) ;
}

public Vec2 Vec2(String s, int a, int b, int c, int d) { 
  return new Vec2(s,a,b,c,d) ;
}

public Vec2 Vec2(String s, int v) {
  return new Vec2(s,v) ;
}
/**
Vec 3
*/
public Vec3 Vec3(float x, float y, float z) {
  return new Vec3(x,y,z) ;
}

public Vec3 Vec3(float v) {
  return new Vec3(v) ;
}

public Vec3 Vec3(PVector p) {
  return new Vec3(p.x, p.y, p.z) ;
}

public Vec3 Vec3(Vec3 p) {
  return new Vec3(p.x, p.y, p.z) ;
}

public Vec3 Vec3(Vec2 p) {
  return new Vec3(p) ;
}

public Vec3 Vec3() {
  return new Vec3() ;
}

public Vec3 Vec3(String s, int x, int y, int z) { 
  return new Vec3(s,x,y,z) ;
}

public Vec3 Vec3(String s, int a, int b, int c, int d, int e, int f) { 
  return new Vec3(s,a,b,c,d,e,f) ;
}

public Vec3 Vec3(String s, int v) {
  return new Vec3(s,v) ;
}
/**
Vec 4
*/
public Vec4 Vec4() {
  return new Vec4() ;
}

public Vec4 Vec4(float x, float y, float z, float w) {
  return new Vec4(x,y,z,w) ;
}

public Vec4 Vec4(float v) {
  return new Vec4(v) ;
}

// build with Vec
public Vec4 Vec4(Vec4 p) {
  return new Vec4(p.x,p.y,p.z,p.w) ;
}
public Vec4 Vec4(Vec3 p) {
  return new Vec4(p) ;
}
public Vec4 Vec4(Vec2 p) {
  return new Vec4(p) ;
}
public Vec4 Vec4(Vec2 p1,Vec2 p2) {
  return new Vec4(p1,p2) ;
}


public Vec4 Vec4(String s, int x, int y, int z, int w) { 
  return new Vec4(s,x,y,z,w) ;
}

public Vec4 Vec4(String s, int a, int b, int c, int d, int e, int f, int g, int h) { 
  return new Vec4(s,a,b,c,d,e,f,g,h) ;
}

public Vec4 Vec4(String s, int v) {
  return new Vec4(s,v) ;
}
/**
Vec 5
*/
public Vec5 Vec5() {
  return new Vec5() ;
}

public Vec5 Vec5(float a, float b, float c, float d, float e) {
  return new Vec5(a,b,c,d,e) ;
}

public Vec5 Vec5(float v) {
  return new Vec5(v) ;
}

// build with Vec
public Vec5 Vec5(Vec5 p) {
  return new Vec5(p.a,p.b,p.c,p.d,p.e) ;
}
public Vec5 Vec5(Vec4 p) {
  return new Vec5(p) ;
}
public Vec5 Vec5(Vec3 p) {
  return new Vec5(p) ;
}
public Vec5 Vec5(Vec2 p) {
  return new Vec5(p) ;
}
public Vec5 Vec5(Vec2 p1,Vec2 p2) {
  return new Vec5(p1,p2) ;
}
public Vec5 Vec5(Vec3 p1,Vec2 p2) {
  return new Vec5(p1,p2) ;
}
public Vec5 Vec5(Vec2 p1,Vec3 p2) {
  return new Vec5(p1,p2) ;
}

public Vec5 Vec5(String s, int a, int b, int c, int d, int e) { 
  return new Vec5(s,a,b,c,d,e) ;
}

public Vec5 Vec5(String s, int a, int b, int c, int d, int e, int f, int g, int h, int i, int j) { 
  return new Vec5(s,a,b,c,d,e,f,g,h,i,j) ;
}

public Vec5 Vec5(String s, int v) {
  return new Vec5(s,v) ;
}
/**
Vec 6
*/
public Vec6 Vec6() {
  return new Vec6(0.f) ;
}

public Vec6 Vec6(float a, float b, float c, float d, float e, float f) {
  return new Vec6(a,b,c,d,e,f) ;
}

public Vec6 Vec6(float v) {
  return new Vec6(v) ;
}

// build with vec
public Vec6 Vec6(Vec6 p) {
  return new Vec6(p.a, p.b, p.c, p.d, p.e, p.f) ;
}
public Vec6 Vec6(Vec5 p) {
  return new Vec6(p) ;
}
public Vec6 Vec6(Vec4 p) {
  return new Vec6(p) ;
}
public Vec6 Vec6(Vec3 p) {
  return new Vec6(p) ;
}
public Vec6 Vec6(Vec2 p) {
  return new Vec6(p) ;
}
public Vec6 Vec6(Vec2 p1,Vec2 p2) {
  return new Vec6(p1,p2) ;
}
public Vec6 Vec6(Vec2 p1,Vec3 p2) {
  return new Vec6(p1,p2) ;
}
public Vec6 Vec6(Vec3 p1,Vec2 p2) {
  return new Vec6(p1,p2) ;
}
public Vec6 Vec6(Vec4 p1,Vec2 p2) {
  return new Vec6(p1,p2) ;
}
public Vec6 Vec6(Vec2 p1,Vec4 p2) {
  return new Vec6(p1,p2) ;
}
public Vec6 Vec6(Vec2 p1,Vec2 p2, Vec2 p3) {
  return new Vec6(p1,p2,p3) ;
}
public Vec6 Vec6(Vec3 p1,Vec3 p2) {
  return new Vec6(p1,p2) ;
}



public Vec6 Vec6(String s, int a, int b, int c, int d, int e, int f) { 
  return new Vec6(s,a,b,c,d,e,f) ;
}

public Vec6 Vec6(String s, int a, int b, int c, int d, int e, int f, int g, int h, int i, int j, int k, int l) { 
  return new Vec6(s,a,b,c,d,e,f,g,h,i,j,k,l) ;
}

public Vec6 Vec6(String s, int v) {
  return new Vec6(s,v) ;
}










/**
PROCESSING METHOD in VEC mode

*/
/**
background
*/
public void background(Vec4 c) {
  background(c.r,c.g,c.b,c.a) ;
}

public void background(Vec3 c) {
  background(c.r,c.g,c.b) ;
}

public void background(Vec2 c) {
  background(c.x,c.y) ;
}

/**
Ellipse
*/
public void ellipse(Vec2 p, Vec2 s) {
  ellipse(p.x, p.y, s.x, s.y) ;
}
public void ellipse(Vec3 p, Vec2 s) {
  if(renderer_P3D()) {
    matrix_start() ;
    translate(p.x, p.y, p.z) ;
    ellipse(0,0, s.x, s.y) ;
    matrix_end() ;
  } else ellipse(p.x, p.y, s.x, s.y) ;
}



/**
Rect
*/
public void rect(Vec2 p, Vec2 s) {
  rect(p.x, p.y, s.x, s.y) ;
}
public void rect(Vec3 p, Vec2 s) {
  if(renderer_P3D()) {
    matrix_start() ;
    translate(p.x, p.y,p.z ) ;
    rect(0,0, s.x, s.y) ;
    matrix_end() ;
  } else rect(p.x, p.y, s.x, s.y) ;
}

/**
Box
*/
public void box(Vec3 p) {
  box(p.x, p.y, p.z) ;
}

/**
Point
*/
public void point(Vec2 p) {
  point(p.x, p.y) ;
}
public void point(Vec3 p) {
  if(renderer_P3D()) point(p.x, p.y, p.z) ; else  point(p.x, p.y) ;
}
/**
Line
*/
public void line(Vec2 a, Vec2 b){
  line(a.x, a.y, b.x,b.y) ;
}
public void line(Vec3 a, Vec3 b){
  if(renderer_P3D()) line(a.x, a.y, a.z, b.x,b.y, b.z) ; else line(a.x, a.y, b.x,b.y) ;
}
/**
Vertex
*/
public void vertex(Vec2 a){
  vertex(a.x, a.y) ;
}
public void vertex(Vec3 a){
  if(renderer_P3D()) vertex(a.x, a.y, a.z) ; else vertex(a.x, a.y) ;
}

/**
Bezier Vertex
*/
public void bezierVertex(Vec2 a, Vec2 b, Vec2 c) {
  bezierVertex(a.x, a.y, b.x, b.y, c.x, c.y) ;
}

public void bezierVertex(Vec3 a, Vec3 b, Vec3 c) {
  if(renderer_P3D()) bezierVertex(a.x, a.y, a.z, b.x, b.y, b.z, c.x, c.y, c.z) ; else bezierVertex(a.x, a.y, b.x, b.y, c.x, c.y) ;
}

/**
Quadratic Vertex
*/
public void quadraticVertex(Vec2 a, Vec2 b) {
  quadraticVertex(a.x, a.y, b.x, b.y) ;
}

public void quadraticVertex(Vec3 a, Vec3 b) {
  if(renderer_P3D()) quadraticVertex(a.x, a.y, a.z, b.x, b.y, b.z) ; else quadraticVertex(a.x, a.y, b.x, b.y) ;
}

/**
Curve Vertex
*/
public void curveVertex(Vec2 a){
  curveVertex(a.x, a.y) ;
}
public void curveVertex(Vec3 a){
  if(renderer_P3D()) curveVertex(a.x, a.y, a.z) ; else curveVertex(a.x, a.y) ;
}


/**
Fill
*/
public void fill(Vec2 c) {
  fill(c.x, c.y) ;
}
public void fill(Vec3 c) {
  fill(c.r,c.g,c.b) ;
}
public void fill(Vec4 c) {
  if( c.a > 0) fill(c.r,c.g,c.b,c.a) ; else noFill() ;
}
/**
Stroke
*/
public void stroke(Vec2 c) {
  stroke(c.x, c.y) ;
}
public void stroke(Vec3 c) {
  stroke(c.r,c.g,c.b) ;
}
public void stroke(Vec4 c) {
  if(c.a > 0) stroke(c.r,c.g,c.b,c.a) ; else noStroke() ;
}





/**
Translate
*/
public void translate(Vec3 t){
  if(renderer_P3D()) translate(t.x, t.y, t.z) ; else translate(t.x, t.y) ;
}

public void translate(Vec2 t){
  translate(t.x, t.y) ;
}

public void translateX(float t){
  translate(t, 0) ;
}

public void translateY(float t){
  translate(0, t) ;
}

public void translateZ(float t){
  translate(0, 0, t) ;
}


/**
Rotate
*/
public void rotateXY(Vec2 rot) {
  rotateX(rot.x) ;
  rotateY(rot.y) ;
}

public void rotateXZ(Vec2 rot) {
  rotateX(rot.x) ;
  rotateZ(rot.y) ;
}

public void rotateYZ(Vec2 rot) {
  rotateY(rot.x) ;
  rotateZ(rot.y) ;
}
public void rotateXYZ(Vec3 rot) {
  rotateX(rot.x) ;
  rotateY(rot.y) ;
  rotateZ(rot.z) ;
}

/**
Matrix
*/
public void matrix_3D_start(Vec3 pos, Vec3 dir_cart) {
  Vec3 dir = dir_cart.copy() ;
  pushMatrix() ;
  translate(pos) ;
  float radius = sqrt(dir.x * dir.x + dir.y * dir.y + dir.z * dir.z);
  float longitude = acos(dir.x / sqrt(dir.x * dir.x + dir.y * dir.y)) * (dir.y < 0 ? -1 : 1);
  float latitude = acos(dir.z / radius) * (dir.z < 0 ? -1 : 1);
  // check NaN result
  if (Float.isNaN(longitude)) longitude = 0 ;
  if (Float.isNaN(latitude)) latitude = 0 ;
  if (Float.isNaN(radius)) radius = 0 ;
  rotateX(latitude) ;
  rotateY(longitude) ;
}

public void matrix_3D_start(Vec3 pos, Vec2 dir_polar) {
  pushMatrix() ;
  translate(pos) ;
  rotateXY(dir_polar) ;
}

public void matrix_2D_start(Vec2 pos, float orientation) {
  pushMatrix() ;
  translate(pos) ;
  rotate(orientation) ;
}

public void matrix_end() {
  popMatrix() ;
}

public void matrix_start() {
  pushMatrix() ;
}
// Z_class 1.0.1






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
/**
RPE Costume 0.0.6
*/
final int POINT_RPE = 0 ;
final int ELLIPSE_RPE = 1 ;
final int RECT_RPE = 2 ;


final int TRIANGLE_RPE = 13 ;
final int SQUARE_RPE = 14 ;
final int PENTAGON_RPE = 15 ;
final int HEXAGON_RPE = 16 ;
final int HEPTAGON_RPE = 17 ;
final int OCTOGON_RPE = 18 ;
final int NONAGON_RPE = 19 ;
final int DECAGON_RPE = 20 ;

final int CROSS_2_RPE = 52 ;
final int CROSS_3_RPE = 53 ;

final int SPHERE_LOW_RPE = 100 ;
final int SPHERE_MEDIUM_RPE = 101 ;
final int SPHERE_HIGH_RPE = 102 ;
final int TETRAHEDRON_RPE = 103 ;
final int BOX_RPE = 104 ;


public void costume(Vec3 pos, int size_int,  int which_costume)  {
	Vec3 dir_null = Vec3() ;
	Vec3 size = Vec3(size_int) ;
	costume(pos, size, dir_null, which_costume) ;
}

public void costume(Vec3 pos, Vec3 size,  int which_costume)  {
	Vec3 dir_null = Vec3() ;
	costume(pos, size, dir_null, which_costume) ;
}

public void costume(Vec2 pos, int size_int,  int which_costume)  {
	Vec3 dir_null = Vec3() ;
	Vec3 size = Vec3(size_int) ;
	costume(Vec3(pos.x,pos.y,0), size, dir_null, which_costume) ;
}

public void costume(Vec2 pos, Vec3 size,  int which_costume)  {
	Vec3 dir_null = Vec3() ;
	costume(Vec3(pos.x,pos.y,0), size, dir_null, which_costume) ;
}

/**
Change the method for method with 
case
and 
break
*/
public void costume(Vec3 pos, Vec3 size, Vec3 dir, int which_costume) {
	if (which_costume == 0 ) {
		point(pos) ;
	}  else if (which_costume == 1 ) {
		matrix_start() ;
		translate(pos) ;
		ellipse(0,0, size.x, size.y) ;
		matrix_end() ;
	}  else if (which_costume == 2 ) {
		matrix_start() ;
		translate(pos) ;
		rect(0,0, size.x, size.y) ;
		matrix_end() ;
	}  




		else if (which_costume == 13) {
		primitive(pos, size.x, 3) ;
	}  else if (which_costume == 14) {
		primitive(pos, size.x, 4) ;
	} else if (which_costume == 15) {
		primitive(pos, size.x, 5) ;
	} else if (which_costume == 16) {
		primitive(pos, size.x, 6) ;
	} else if (which_costume == 17) {
		primitive(pos, size.x, 7) ;
	} else if (which_costume == 18) {
		primitive(pos, size.x, 8) ;
	} else if (which_costume == 19) {
		primitive(pos, size.x, 9) ;
	} else if (which_costume == 20) {
		primitive(pos, size.x, 10) ;
	}



		else if (which_costume == 52) {
		matrix_start() ;
		translate(pos) ;
		cross_2(size) ;
		matrix_end() ;
	} else if (which_costume == 53) {
		matrix_start() ;
		translate(pos) ;
		cross_3(size) ;
		matrix_end() ;
	}




		else if (which_costume == 100) {
		matrix_start() ;
		translate(pos) ;
		sphereDetail(5);
		sphere(size.x) ;
		matrix_end() ;
	} else if (which_costume == 101) {
		matrix_start() ;
		translate(pos) ;
		sphereDetail(12);
		sphere(size.x) ;
		matrix_end() ;
	}else if (which_costume == 102) {
		matrix_start() ;
		translate(pos) ;
		sphere(size.x) ;
		matrix_end() ;
	} else if (which_costume == 103) {
		matrix_start() ;
		translate(pos) ;
		tetrahedron((int)size.x) ;
		matrix_end() ;
	} else if (which_costume == 104) {
		matrix_start() ;
		translate(pos) ;
		box(size) ;
		matrix_end() ;
	} 



		else if (which_costume == 1001) {
		matrix_start() ;
		translate(pos) ;
		polyhedron("TETRAHEDRON","LINE", (int)size.x) ;
		matrix_end() ;
	} else if (which_costume == 1002) {
		matrix_start() ;
		translate(pos) ;
		polyhedron("CUBE","LINE", (int)size.x) ;
		matrix_end() ;
	} else if (which_costume == 1003) {
		matrix_start() ;
		translate(pos) ;
		polyhedron("OCTOHEDRON","LINE", (int)size.x) ;
		matrix_end() ;
	} else if (which_costume == 1004) {
		matrix_start() ;
		translate(pos) ;
		polyhedron("RHOMBIC COSI DODECAHEDRON SMALL","LINE", (int)size.x) ;
		matrix_end() ;
	} else if (which_costume == 1005) {
		matrix_start() ;
		translate(pos) ;
		polyhedron("ICOSI DODECAHEDRON","LINE", (int)size.x) ;
		matrix_end() ;
	}
}









// ANNEXE COSTUME
// CROSS
public void cross_2(Vec3 size) {
	float ratio_cross = .3f ;
	float scale_cross = (size.x + size.y + size.z) *.3f ;
	float small_part = scale_cross *ratio_cross ;

	box(size.x, small_part, small_part) ;
	box(small_part, size.y, small_part) ;
}


public void cross_3(Vec3 size) {
	float ratio_cross = .3f ;
	float scale_cross = (size.x + size.y + size.z) *.3f ;
	float small_part = scale_cross *ratio_cross ;
   
	box(size.x, small_part, small_part) ;
	box(small_part, size.y, small_part) ;
	box(small_part, small_part, size.z) ;
}
// Deprecated method
/////////////////////

// Tab: Z_class
/////////////
//CLASS PIXEL
/////////////

class Old_Pixel {
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
  Old_Pixel(PVector pos) {
    this.pos = new PVector(pos.x, pos.y, pos.z) ;
  }
  
  Old_Pixel(PVector pos, int colour) {
    this.pos = new PVector(pos.x, pos.y, pos.z) ;
    this.colour = colour ;
  }
  
  Old_Pixel(PVector pos, PVector size) {
    this.pos = new PVector(pos.x, pos.y, pos.z) ;
    this.size = new PVector(size.x, size.y, size.z) ;
  }
  
  //pixel with size
  Old_Pixel(PVector pos, PVector size, int colour) {
    this.pos = new PVector(pos.x, pos.y, pos.z) ;
    this.size = new PVector(size.x, size.y, size.z) ;
    this.colour = colour ;
  }
  
  //INK CONSTRUCTOR
  Old_Pixel(PVector pos, float field, int colour) {
    this.pos = new PVector(pos.x, pos.y, pos.z) ;
    this.field = field ;
    this.colour = colour ;
  }
  Old_Pixel(PVector pos, float field) {
    this.pos = new PVector(pos.x, pos.y, pos.z) ;
    this.field = field ;
  }
  
  //RANK PIXEL CONSTRUCTOR
  Old_Pixel(int rank, PVector gridPos) {
    this.rank = rank ;
    this.gridPos = gridPos ;
  }
  Old_Pixel(int rank) {
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
    PVector dir = normal_direction((int)effectPosition.x) ;
    
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
    PVector dir = normal_direction((int)effectPosition.x) ;

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
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "PreScene_30" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
