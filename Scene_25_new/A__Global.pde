///////////////////////
// GLOBAL SETTING ////
/////////////////////


//internet connection
Boolean internet = true ;
//video connection
Boolean videoSignal = false ;

String bigBrother = (" BIG BROTHER DON'T WATCHING YOU !!") ;

//variable for the tracking
Boolean nextPrevious = false ;
int nextPreviousInt = 0 ; // for send to Syphon
int trackerUpdate ; // must be reset after each use

//VIDEO
import codeanticode.gsvideo.*;
// SYPHON
import codeanticode.syphon.*;

//INTERNET
import processing.net.*;
//FLUX RSS or TWITTER ????
import com.sun.syndication.feed.synd.*;
import com.sun.syndication.io.*;


// for Processing 211
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





//Variable CLAVIER
// int space ;
boolean displayInfo ;



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









////////
//ANNEXE
//INIT in real time and re-init the default setting of the display window


void initDraw() {
  rectMode (CORNER) ; 
  //load text raw for the different object
  importText(sketchPath("")+"karaoke.txt") ;
  splitText() ;
}
////////////////////
//SAVE SCENE PICTURE
void beginSave() {
    if (countSave == 1 ) savePDF = true ;
  if (savePDF) beginRecord(PDF, savePathPDF) ; 
}
void endSave() {
    //SAVE IMAGE END
  if (savePDF ) {
    endRecord();
    savePDF = false ;
    countSave = 0 ;
  }
}
void keySave() {
  if(key == 's' ) selectOutput("Enregistrez le PDF et le PNG ", "saveImg") ;
}
