///////////////////////
// GLOBAL SETTING ////
/////////////////////
int numObj = 99 ; // minimum 2 object because sur first Object is Zero and it use like ref. So the "1" is the real first object.
int numBand = 16 ; // num band for the spectrum sound

//Web cam activity
// boolean cameraOnOff = false ;
//internet connection
Boolean internet = true ;
Boolean videoSignal = false ;
String bigBrother = ("BIG BROTHER DON'T WATCHING YOU !!") ;

/*
// Screen size
//String [] sD ;
*/



//variable for the tracking
Boolean nextPrevious = false ;
int nextPreviousInt = 0 ; // for send to Syphon
int trackerUpdate ; // must be reset after each use

//VIDEO
import codeanticode.gsvideo.*;

//INTERNET
import processing.net.*;
//FLUX RSS or TWITTER ????
import com.sun.syndication.feed.synd.*;
import com.sun.syndication.io.*;

//TABLET GRAPHIC
import codeanticode.tablet.*;
//LEAP MOTION
import com.leapmotion.leap.*;
com.leapmotion.leap.Controller leap;




// for processing 2.0.b9
import java.net.*;
import java.io.*;
import java.util.*;
//for the fullscreen and screen choice
import java.awt.*;


//to make the window is resizable
java.awt.Insets insets; // use for the border of window (top and right)

//GEOMERATIVE
import geomerative.*;
//TOXIC
import toxi.geom.*;
import toxi.geom.mesh2d.*;
import toxi.util.*;
import toxi.util.datatypes.*;
import toxi.processing.*;

//METEO
import com.onformative.yahooweather.*;


//SOUND
import ddf.minim.*;
import ddf.minim.analysis.*;

///////IMPORTANT///////////////////////////////////////////////////////////////////////
//CALLING class or library in Other Class, you must call the PApplet too in your class
PApplet callingClass = this ;




//fenêtre texte
String texte ;
//Variable CLAVIER



//PDF save picture
import processing.pdf.*;
boolean savePDF ;
String savePathPDF, savePathPNG ;




//LOAD IMAGE
// to drop load image
import sojamo.drop.*;
SDrop drop;
boolean resizableByImgDrop ;

//IMAGE
PImage img ;
String pathImg ; 





//OPENING the other window
void opening() {
    //OPEN CONTROLEUR and SCENE or MIROIR
  if (!testRomanesco && openControleur) {
    fill(blanc) ;
    stroke(blanc) ;
    textSize(36 ) ;
    text(" WAIT FOR CONTROLEUR", 50,50 ) ;
  }
  if (!testRomanesco) { 
    if (openControleur) { open(sketchPath("")+"Controleur_"+release+".app") ; openControleur = false ; } 
    if (openScene)      { open(sketchPath("")+"Scene_"+release+".app") ; openScene = false ; }
   // if (openMiroir)     { open(sketchPath("")+"Miroir_24.app") ; openMiroir = false ; }
    testRomanesco = true ;
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
  resizableByImgDrop = true ;
  if ( resizableByImgDrop && displaySizeByImage ) updateSizeDisplay(img) ;
  
  //load text raw for the different object
  importText(sketchPath("")+"karaoke.txt") ;
  splitText() ;
}





//INFO
void displayInfo3D() {
   String posCam = ( int(sceneCamera.x +width/2) + " / " + int(sceneCamera.y +height/2) + " / " +  int(sceneCamera.z -height/2)) ;
   String eyeDirectionCam = ( int(eyeCamera.x) + " / " + int(eyeCamera.y) ) ;
  fill(blanc) ; 
  textFont(SansSerif10, 10) ;
  textAlign(RIGHT) ;
  text("Position " +posCam, width/2 -30 , height/2 -30) ;
  text("Direction " +eyeDirectionCam, width/2 -30 , height/2 -15) ;
}
