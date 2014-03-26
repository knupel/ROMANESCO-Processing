import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.Iterator; 
import java.lang.reflect.*; 
import codeanticode.gsvideo.*; 
import codeanticode.syphon.*; 
import processing.net.*; 
import com.sun.syndication.feed.synd.*; 
import com.sun.syndication.io.*; 
import java.net.*; 
import java.io.*; 
import java.util.*; 
import java.awt.*; 
import geomerative.*; 
import toxi.geom.*; 
import toxi.geom.mesh2d.*; 
import toxi.util.*; 
import toxi.util.datatypes.*; 
import toxi.processing.*; 
import com.onformative.yahooweather.*; 
import ddf.minim.*; 
import ddf.minim.analysis.*; 
import processing.pdf.*; 
import sojamo.drop.*; 
import twitter4j.StatusDeletionNotice; 
import twitter4j.StatusDeletionNotice; 
import twitter4j.StatusListener; 
import twitter4j.Status; 
import twitter4j.FilterQuery; 
import twitter4j.TwitterStreamFactory; 
import twitter4j.TwitterStream; 
import twitter4j.conf.ConfigurationBuilder; 
import oscP5.*; 
import netP5.*; 

import twitter4j.examples.block.*; 
import twitter4j.examples.trends.*; 
import twitter4j.conf.*; 
import twitter4j.json.*; 
import twitter4j.internal.async.*; 
import twitter4j.internal.logging.*; 
import twitter4j.api.*; 
import twitter4j.internal.json.*; 
import twitter4j.examples.friendsandfollowers.*; 
import twitter4j.*; 
import twitter4j.examples.directmessage.*; 
import twitter4j.media.*; 
import twitter4j.examples.list.*; 
import twitter4j.examples.stream.*; 
import twitter4j.examples.search.*; 
import twitter4j.examples.friendship.*; 
import twitter4j.examples.timeline.*; 
import twitter4j.util.*; 
import twitter4j.examples.tweets.*; 
import twitter4j.examples.user.*; 
import twitter4j.examples.async.*; 
import twitter4j.examples.help.*; 
import twitter4j.examples.media.*; 
import twitter4j.auth.*; 
import twitter4j.internal.util.*; 
import twitter4j.examples.account.*; 
import twitter4j.examples.geo.*; 
import twitter4j.internal.http.*; 
import twitter4j.examples.spamreporting.*; 
import twitter4j.examples.oauth.*; 
import twitter4j.examples.favorite.*; 
import twitter4j.examples.json.*; 
import twitter4j.examples.notification.*; 
import twitter4j.examples.listsubscribers.*; 
import twitter4j.management.*; 
import twitter4j.examples.listmembers.*; 
import twitter4j.examples.savedsearches.*; 
import twitter4j.examples.legal.*; 
import twitter4j.internal.org.json.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Scene_25 extends PApplet {

  //////////////////////////////////////////////////////////////////////////////////////////
 // Romanesco Pr\u00e9sc\u00e8ne Alpha 0.25 work with Processing 211 export with Processing 203  ////
//////////////////////////////////////////////////////////////////////////////////////////
String release =("25") ;


//MANAGER CLASS

 
ObjectRomanescoManager romanescoManager ;

public void setup() {
  romanescoSetup() ;
  createVar() ;
  initVarScene() ;
  displaySetup(60) ; // the int give the frameRate
  miroirSetup() ;
  //dropping image from folder on the Sc\u00e8ne
  drop = new SDrop(this);
  //load font
  fontSetup() ;
  //GEOMERATIVE
  RG.init(this);

  soundSetup() ;
  cursorSetup() ; // the cursor setup of the Prescene is more complexe
  OSCSetup() ;
  meteoSetup() ;
  P3DSetup() ;
  lightSetup(); // for the Scene only
}

//DRAW
public void draw() {
  initDraw() ;
  miroirDraw() ;
  soundDraw() ;
  OSCDraw() ;
  meteoDraw() ;
  updateVar() ;
  backgroundRomanesco() ;
  
  beginSave() ;
  //ROMANESCO
  cameraDraw() ;
  lightDraw() ;
  romanescoManager.displayObject() ;
  stopCamera() ;
  
  endSave() ;
  curtain() ;  
  
  nextPreviousKeypressed() ;
}
//END DRAW

/////KEY/////
//KEYPRESSED
public void keyPressed () {
  keySave() ;
}
// HIGH VAR///////////////////////
// GLOBAL SETTING ////
/////////////////////

Boolean internet = true ;
String bigBrother = (" BIG BROTHER DON'T WATCHING YOU !!") ;

Boolean videoSignal = false ;
//variable for the tracking
Boolean nextPrevious = false ;
int nextPreviousInt = 0 ; // for send to Syphon
int trackerUpdate ; // must be reset after each use







//FLUX RSS or TWITTER ????


// for Processing 211



//for the fullscreen and screen choice

//to make the window is resizable
java.awt.Insets insets; // use for the border of window (top and right)

//GEOMERATIVE

//TOXIC





//METEO

//SOUND


//CALLING class or library in Other Class, you must call the PApplet too in your class
PApplet callingClass = this ;

 // when you work only with prescene presceneOnly is true, on Prescene in the sketch Prescene
//but in the Miroir and Scene sketch presceneOnly must be true for the final work.
boolean presceneOnly = true ;
//spectrum for the color mode and more if you need
PVector HSBmode = new PVector (360,100,100) ; // give the color mode in HSB
//path to open the controleur
String findPath ; 

//Variable CLAVIER
boolean displayInfo ;
//PDF save picture

boolean savePDF ;
String savePathPDF, savePathPNG ;
// to drop load image

SDrop drop;
boolean resizableByImgDrop ;
//IMAGE
PImage img ;
String pathImg ; 
//
boolean modeP3D ;
//spectrum band
int numBand = 16 ;
//font
int numFont = 50 ;
//quantity of group object slider
int numGroup = 3 ;

int numSliderGroupZero = 14 ;
int numSlider = 30 ;

int numButtonGlobal = 21 ; // group zero
int numButtonObj  ; // group one, two and three

//VAR
int numObj ;
Table indexObjects ;
TableRow [] rowIndexObject ;
//MISC var
String objectName [] ;
int objectID[] ;
//BUTTON CONTROLER
boolean objectParameter[] ;

//VAR object
//raw
int [] fillRaw, strokeRaw ;
float [] thicknessRaw ; 
float [] sizeXRaw, sizeYRaw, sizeZRaw, canvasXRaw, canvasYRaw, canvasZRaw ;
float [] speedRaw, forceRaw, directionRaw, angleRaw ;
float [] familyRaw, quantityRaw, lifeRaw, analyzeRaw, amplitudeRaw;
//add in the next version when there is 30 slider by group
float [] curveRaw, attractionRaw ;

//object
int [] fillObj, strokeObj ;
float [] thicknessObj ;
float [] sizeXObj, sizeYObj, sizeZObj, canvasXObj, canvasYObj, canvasZObj ;
float [] speedObj, forceObj, directionObj, angleObj ;
float [] familyObj, quantityObj, lifeObj , analyzeObj, amplitudeObj;
//add in the next version when there is 30 slider by group
float curveObj[], attractionObj[] ;
//font
PFont police ;



//OSC VAR
// button
int eBeat, eKick, eSnare, eHat, eCurtain, eMeteo ;
int [] objectButton,soundButton, actionButton, parameterButton ;
boolean [] object, sound, action, parameter ;

int mode[]  ;

//BUTTON
int [] valueButtonGlobal, valueButtonObj  ;
/*
int valueButtonGroupZero[] = new int[numButtonGroupZero] ;
int valueButtonGroupObj[] = new int[numButtonGroupObj] ;
*/
//SLIDER
String valueSliderTemp[][]  = new String [numGroup+1][numSlider] ;
/*
String valueSliderTempGroupZero[]  = new String [numSliderGroupZero] ;
String valueSliderTempGroupOne[]  = new String [numSlider] ;
String valueSliderTempGroupTwo[]  = new String [numSlider] ;
String valueSliderTempGroupThree[]  = new String [numSlider] ;
*/
float valueSlider[][]  = new float [numGroup+1][numSlider] ;
/*
float valueSliderGlobal[]  = new float [numSliderGroupZero] ;
float valueSliderGroupOne[]  = new float [numSlider] ;
float valueSliderGroupTwo[]  = new float [numSlider] ;
float valueSliderGroupThree[]  = new float [numSlider] ;
*/

//MISC
//var to init the data of the object when is switch ON for the first time
boolean  [] initValueMouse, initValueSlider ;
// boolean initValueMouse [] = new boolean [numObj]  ;
//parameter for the super class
float [] left, right, mix ;
//beat
float [] beat, kick, snare, hat ;
// spectrum
float band[][] ;
//tempo
float [] tempo, tempoBeat, tempoKick, tempoSnare, tempoHat ;


//P3D OBJECT
//position
//position
boolean startingPosition [] ;
PVector startingPos [] ;
float [] P3DpositionX, P3DpositionY, P3DpositionZ ;
//PVector P3Dposition [] ;
PVector P3DpositionObjRef [] ;
boolean P3DrefPos [] ;
PVector [] posManipulation, dirManipulation ;
//orientation
float [] P3DdirectionX, P3DdirectionY ;
//PVector P3Ddirection [] ;
PVector P3DdirectionObjRef [] ;
boolean P3DrefDir [] ;

//position of object and wheel
PVector [] mouse, pmouse, pen ;
boolean [] clickShortLeft, clickShortRight, clickLongLeft, clickLongRight, mousepressed ;
int wheel[] ;
//pen info

//boolean clear
boolean clearList[] ;
//motion object
boolean [] motion, horizon  ;

//main font for each object
String [] pathFontTTF, pathFontVLW, pathFontObjTTF ;
PFont font[]  ;




////////////////////
//SAVE SCENE PICTURE
public void beginSave() {
    if (countSave == 1 ) savePDF = true ;
  if (savePDF) beginRecord(PDF, savePathPDF) ; 
}
public void endSave() {
    //SAVE IMAGE END
  if (savePDF ) {
    endRecord();
    savePDF = false ;
    countSave = 0 ;
  }
}
public void keySave() {
  if(key == 's' ) selectOutput("Enregistrez le PDF et le PNG ", "saveImg") ;
}



//init var
public void initDraw() {
  rectMode (CORNER) ; 
  //load text raw for the different object
  importText(sketchPath("")+"karaoke.txt") ;
  splitText() ;
}

public void createVar() {
  numObj = romanescoManager.numClasses + 1 ;
  //BUTTON CONTROLER
  numButtonObj = numObj*10 ;

  createVarButton() ;
  //createVarSlider() ;
  createVarSound() ;
  createVarP3D() ;
  createVarCursor() ;
  createVarObject() ;
  
  createMiscVar() ;
  

   romanescoManager.initObj() ;
}

//init void
// misc var
public void createMiscVar() {
    //boolean clear
   clearList = new boolean[numObj] ;
  //motion object
   motion = new boolean [numObj]  ;
   horizon = new boolean [numObj]  ;
  //main font for each object
   font = new PFont[numObj] ;
   pathFontObjTTF = new String[numObj] ;
   pathFontTTF = new String [numFont] ;  
   pathFontVLW = new String [numFont] ;
   font = new PFont[numFont] ;
     //MISC
  //var to init the data of the object when is switch ON for the first time
   initValueMouse = new boolean [numObj]  ;
   initValueSlider = new boolean [numObj]  ;
}
// var cursor
public void createVarCursor() {
  //position of object and wheel
   mouse  = new PVector[numObj] ;
   pmouse = new PVector[numObj] ;
   clickShortLeft = new boolean [numObj] ;
   clickShortRight = new boolean [numObj] ;
   clickLongLeft = new boolean [numObj] ;
   clickLongRight = new boolean [numObj] ;
   mousepressed = new boolean [numObj] ;
   wheel = new int [numObj] ;
  //pen info
   pen = new PVector[numObj] ;
}
// P3D
public void createVarP3D() {
  startingPosition = new boolean[numObj] ;
   startingPos = new PVector[numObj] ;
   P3DpositionX = new float[numObj] ;
   P3DpositionY = new float[numObj] ;
   P3DpositionZ = new float[numObj] ;
   P3DpositionObjRef = new PVector[numObj] ;
   P3DrefPos = new boolean[numObj] ;
   
  //orientation
   P3DdirectionX = new float[numObj] ;
   P3DdirectionY = new float[numObj] ;
   P3DdirectionObjRef = new PVector[numObj] ;
   posManipulation = new PVector[numObj] ;
   dirManipulation = new PVector[numObj] ;
   P3DrefDir = new boolean[numObj] ;
}

public void createVarSound() {
   left = new float [numObj] ;
   right = new float [numObj] ;
   mix  = new float [numObj] ;
  //beat
   beat  = new float [numObj] ;
   kick  = new float [numObj] ;
   snare  = new float [numObj] ;
   hat  = new float [numObj] ;
  // spectrum
   band = new float [numObj][numBand] ;
  //tempo
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
  object = new boolean [numObj] ;
  sound = new boolean [numObj] ;
  action = new boolean [numObj] ;
  parameter = new boolean [numObj] ;
  mode = new int [numObj] ;
  
  // you must init this var, because we launch this part of code before the controler. And if we don't init the value is NaN and return an error.
  valueButtonGlobal = new int[numButtonGlobal] ;
  valueButtonObj = new int[numObj*10] ;

}

public void createVarObject() {
    // VAR raw
  fillRaw = new int[numGroup] ;
  strokeRaw = new int[numGroup] ;
  // column 1
  thicknessRaw = new float[numGroup] ; ;
  sizeXRaw = new float[numGroup] ; sizeYRaw = new float[numGroup] ; sizeZRaw = new float[numGroup] ;
  canvasXRaw = new float[numGroup] ; canvasYRaw = new float[numGroup] ; canvasZRaw = new float[numGroup] ;
  quantityRaw = new float[numGroup] ;
  //column 3
  speedRaw = new float[numGroup] ;
  directionRaw = new float[numGroup] ;
  angleRaw = new float[numGroup] ;
  amplitudeRaw = new float[numGroup] ;
  analyzeRaw = new float[numGroup] ;
  familyRaw = new float[numGroup] ;
  lifeRaw = new float[numGroup] ;
  forceRaw = new float[numGroup] ;
  
  // VAR object
  fillObj = new int[numObj] ;
  strokeObj = new int[numObj] ;
  // column 2
  thicknessObj = new float[numObj] ; ;
  sizeXObj = new float[numObj] ; sizeYObj = new float[numObj] ; sizeZObj = new float[numObj] ;
  canvasXObj = new float[numObj] ; canvasYObj = new float[numObj] ; canvasZObj = new float[numObj] ;
  quantityObj = new float[numObj] ;
   //column 3
  speedObj = new float[numObj] ;
  directionObj = new float[numObj] ;
  angleObj = new float[numObj] ;
  amplitudeObj = new float[numObj] ;
  analyzeObj = new float[numObj] ;
  familyObj = new float[numObj] ;
  lifeObj = new float[numObj] ;
  forceObj = new float[numObj] ;
}
// END CREATE VAR
//////////////////


// UPDATE DATA from CONTROLER and PRESCENE
public void updateVar() {
  //from column 1
  for(int i = 0 ; i < numGroup ; i++) {
    //column 1
    fillRaw[i] = color(map(valueSlider[i+1][0],0,100,0,360), valueSlider[i+1][1], valueSlider[i+1][2], valueSlider[i+1][3]) ;
    strokeRaw[i] = color(map(valueSlider[i+1][4],0,100,0,360), valueSlider[i+1][5], valueSlider[i+1][6], valueSlider[i+1][7]) ;

    //column 2
    int minSource = 0 ;
    int maxSource = 100 ;
    float minSize = .1f ;
    thicknessRaw[i] = map(valueSlider[i+1][10],minSource,maxSource,minSize, (height*.33f)) ;
    sizeXRaw[i] = map(valueSlider[i+1][11],minSource,maxSource,minSize,width) ;
    sizeYRaw[i] = map(valueSlider[i+1][12],minSource,maxSource,minSize,width) ;
    sizeZRaw[i] = map(valueSlider[i+1][13],minSource,maxSource,minSize,width) ;
    canvasXRaw[i] = map(valueSlider[i+1][14],minSource,maxSource, width *.1f,width *5) ;
    canvasYRaw[i] = map(valueSlider[i+1][15],minSource,maxSource,height *.1f, height *5) ;
    canvasZRaw[i] = map(valueSlider[i+1][16],minSource,maxSource,width *.1f, width *5) ;
    quantityRaw[i] = map(valueSlider[i+1][17], minSource, maxSource,1,100) ;
    //column 3
    speedRaw[i] = valueSlider[i+1][20] ;
    directionRaw[i] = map(valueSlider[i+1][21],minSource, maxSource,0,360) ;
    angleRaw[i] = map(valueSlider[i+1][22],minSource, maxSource,0,360) ;
    amplitudeRaw[i] = map(valueSlider[i+1][23],minSource, maxSource,1,height) ;
    analyzeRaw[i] = valueSlider[i+1][24] ;
    familyRaw[i] = map(valueSlider[i+1][25],minSource, maxSource,1,100) ;
    lifeRaw[i] = valueSlider[i+1][26] +1 ;
    forceRaw[i] = valueSlider[i+1][27] +1 ;

  }
}
//specific at the Scene
String valueTempPreScene[] = new String [61] ;
//Special var for the Scene and the Miroir
PVector mouseCamera, pmouseCamera, mouseSuperRomanesco, pmouseSuperRomanesco ;


public void initVarScene() {
  mouseSuperRomanesco = new PVector(0,0,0) ;
  pmouseSuperRomanesco = new PVector(0,0,0) ;
  mouseCamera = new PVector(0,0,0) ;
  pmouseCamera = new PVector(0,0,0) ;
}
ArrayList<Tri> listTri ;

//object one
class Triangle extends SuperRomanesco {
  public Triangle() {
    //from the index_objects.csv
    romanescoName = "Triangle" ;
    IDobj = 1 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Alpha 2.0";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
  }
  //GLOBAL
  
  Tri tri[] ;
  //SETUP
  public void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
    listTri = new ArrayList<Tri>() ;
    int numTri = 2 ;
    float thickness ;
    for ( int i = 0 ; i < numTri ; i++) {
      Tri tri = new Tri() ;
      listTri.add(tri) ;
    }
  }
  //DRAW
  public void display() {
    PVector pos = new PVector(mouse[IDobj].x, mouse[IDobj].y) ;
    PVector canvas = new PVector (canvasXObj[IDobj],canvasYObj[IDobj]) ;
    //thickness
    if(sound[IDobj]) thicknessObj[IDobj] *= mix[IDobj] ;
    // speed
    if(sound[IDobj]) speedObj[IDobj] *= tempo[IDobj] ;
    //which side display the triangle
    PVector side ;

    for (int i=0 ; i < listTri.size() ; i++ ) {
      Tri tri = (Tri) listTri.get(i) ;
      if( i == 0 ) side = new PVector(canvasXObj[IDobj],0) ; else side = new PVector(0,canvasYObj[IDobj]) ;
      tri.display(pos, canvas, fillObj[IDobj], strokeObj[IDobj], side.x, side.y,thicknessObj[IDobj], speedObj[IDobj]) ;
    }
  }
}
//end object one





//////////////
//CLASS TRIANGLE
class Tri {
  float pX, pY ;
  float dirX = 1.0f ;
  float dirY = 1.0f ;
  float newVX, newVY ;
  //constructor
  Tri () { }
 
  //Param\u00e8tre superClass  
  //speed move
  public void actualisation(float speed, PVector canvas) {
    if (pX > canvas.x || pX < 0 ) dirX*=-1.0f ;
    if (pY > canvas.y || pY < 0) dirY*=-1.0f ;

    newVX = speed *dirX  ;
    newVY = speed *dirY  ;
    
    pX += newVX  ;
    pY += newVY  ;
  }
  
  
  //DISPLAY
  //void triangles (int coteA, int coteB, PVector pos, int coteC, color cIn, color cOut, float e, float vitesseX, float vitesseY) {
  public void display (PVector pos, PVector canvas, int cIn, int cOut, float coteA, float coteB,  float thickness, float speed) {
    //check the opacity of color
    int alphaIn = (cIn >> 24) & 0xFF; 
    int alphaOut = (cOut >> 24) & 0xFF; 
    // to display or not
    if ( alphaIn == 0 ) noFill() ; else fill (cIn) ;
    if ( alphaOut == 0) {
      noStroke() ;
    } else {
      stroke ( cOut ) ;
      strokeWeight (thickness) ;
    }
    
    //update
    actualisation(speed, canvas) ;
    
    //display
    beginShape () ;
    strokeCap(ROUND);
    vertex (pos.x, pos.y);
    vertex (pX, coteB) ;
    vertex (coteA, coteB ) ;
    vertex (coteA, pY ) ;
    endShape(CLOSE) ;
  }
}
CreatureManager creatureManager ;
boolean useBackdrop = false;

//object one
class Abbyss extends SuperRomanesco {
  public Abbyss() {
    //from the index_objects.csv
    romanescoName = "The Abbyss" ;
    IDobj = 2 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Andreas Gysin";
    romanescoVersion = "Beta 2.0";
    romanescoPack = "Base" ;
    romanescoRender = "P3D" ;
    romanescoMode = "1 Box Fish/2 Cubus/3 Floater/4 Radio/5 Worm/6 Sea Fly/7 Breather/8 Spider/9 Manta/10 Father/11 Super Nova" ;// separate the name by a slash and write the next mode immadialtly after this one.
  }
  //GLOBAL
  
  //SETUP
  public void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
    creatureManager = new CreatureManager(callingClass);
  }
  //DRAW
  public void display() {
    creatureManager.loop(fillObj[IDobj], strokeObj[IDobj], thicknessObj[IDobj], speedObj[IDobj]);
    
    
    
    
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
      if ( nLongTouch && frameCount % 3 == 0) creatureManager.addCurrentCreature(whichCreature);
      //to cennect the creature to the camera
      if(cLongTouch) {
        if (upTouch )    creatureManager.nextCameraCreature();
        else if (downTouch )  creatureManager.prevCameraCreature();
      }
    }

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
    return pos.get();
  }

  public void setPos(PVector pos) {
    this.pos = pos.get();
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
ArrayList<Atom> atomList ;

//object one
class Atome extends SuperRomanesco {
  public Atome() {
    //from the index_objects.csv
    romanescoName = "ATOM" ;
    IDobj = 3 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Alpha 2.0";
    romanescoPack = "Base" ;
    romanescoRender = "P3D" ;
    romanescoMode = "1 Schema/2 Cloud/3 Title/4 Font" ;
  }
  
  //GLOBAL
  int KelvinUnivers  ; // Kelvin degree influent on the mouvement of the Atom, at 0\u00b0K there is no move !!! 273K\u00b0 give 273/Kelvin = 1.0 multi reference when the water became ice ! 
  int t ;
  float pressure = 1.0f ; // Atmospheric pressure. "1" is earth reference
  // wall of screen
  float restitution = 0.5f ;

  float bottom =    restitution ;
  float top =       restitution ;
  float wallRight = restitution ;
  float wallLeft =  restitution ;

  //Molecule.Atom
  boolean cloud = true ; // To swith ON/OFF phycic of the cloud
  // ArrayList<Atom> listA ;
  PVector changeVelocity = new PVector (0.0f , 0.0f) ;

  float atomX = 0 ; float atomY = 0 ;
  
  float beatSizeProton = 1 ;
  float beatThicknessCloud = 1 ;
  float beatSizeCloud = 1 ;
  
  //direction of atome
  PVector newDirection ;
  
  
  //SETUP
  public void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
    
    atomList = new ArrayList<Atom>();
    
    //add one atom to the start
   PVector pos = new PVector (random(width), random(height), 0) ;
   PVector vel = new PVector ( random(-1, 1 ), random(-1, 1 ), random(-1, 1 ) ) ;
   int Z = PApplet.parseInt(familyObj[IDobj]) ;
   int ion = round(random(0,0));
   float rebound = 0.5f ;
   int diam = 5 ;
   int Kstart = PApplet.parseInt(abs( mix[IDobj]) *1000) ; // Temperature of Atom, influence the mouvement behavior
   //motion
   motion[IDobj] = true ;
   
   Atom atm = new Atom( pos, vel, Z, ion, rebound, diam,  Kstart) ; 
   atomList.add(atm) ;
   
   // init font
   font[IDobj] = font[0] ;
  }
  //DRAW
  public void display() {
    if (parameter[IDobj]) font[IDobj] = font[0] ;
    
        //OBJECT
    for (Atom atm : atomList) {
      ////////////////UPDATE////////////////////////////////////////
      float velLimit = (tempo[IDobj] ) *5.0f ; // max of speed Atom
      if (velLimit < 1.1f ) velLimit = 1.1f ;
      //the atom temperature give the speed 
      float s = map(speedObj[IDobj],0,100, 0.0f,17.0f);
      float speed = s*s*s ;
      if(sound[IDobj]) t =  floor(speed  * tempo[IDobj]) ; else t = round(speed) ;
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
        newDirection = new PVector (0,0,0 ) ;
      }
      
      PVector newVelocity = new PVector ( sq(tempo[IDobj]) *1000.0f , sq(tempo[IDobj]) *1000.0f );
      //security if the value is null to don't stop the move
      float acceleration ; 
      if(pen[IDobj].z == 0 ) acceleration = 1.0f  ; else acceleration = pen[IDobj].z * 1000.0f  ;
      changeVelocity = new PVector (newDirection.x * newVelocity.x *right[IDobj] *acceleration  , newDirection.y * newVelocity.y *left[IDobj] *acceleration  ) ;
      
      atm.update (t, velLimit, changeVelocity, tempAbs) ; // obligation to use this void, in the atomic univers
      //COLLISION
      atm.covalentCollision (atomList);
      //DRAG
      float inertia = 1.0f ; // strong of the drag
      atm.drag2D(inertia) ;
    
      
      //DISPLAY
      //PARAMETER FROM ROMANESCO
      //the proton change the with the beat of music
      //diameter
      float fp = map (sizeXObj[IDobj], 0,100, 1, 20) ;
      int factorSizeProton = PApplet.parseInt(fp) ;
      
      if ( atm.getProton() < 21 ) { 
        beatSizeProton = beat[IDobj] ;
      } else if ( atm.getProton() > 20 && atm.getProton() < 45 ) {
        beatSizeProton = kick[IDobj] ;
      } else if ( atm.getProton() > 44 && atm.getProton() < 65 ) {
        beatSizeProton = snare[IDobj] ;
      } else if ( atm.getProton()  > 64 ) {
        beatSizeProton = hat[IDobj] ;
      }
      /////////////////CLOUD///////////////////////////////////////
      //  int factorSizeProton = int(OC21 / 40.0 + 1 ) ;
      if ( atm.getProton() < 21 ) { 
        beatThicknessCloud = beat[IDobj] ;
      } else if ( atm.getProton() > 20 && atm.getProton() < 45 ) {
        beatThicknessCloud = kick[IDobj] ;
      } else if ( atm.getProton() > 44 && atm.getProton() < 65 ) {
        beatThicknessCloud = snare[IDobj] ;
      } else if ( atm.getProton()  > 64 ) {
        beatThicknessCloud = hat[IDobj] ;
      }
      
      //thickness / \u00e9paisseur
      float factorThicknessCloud = thicknessObj[IDobj] *beatThicknessCloud ;
      //diameter
      float factorSizeField = map(sizeXObj[IDobj], 0,100, 1, 10) ; // factor size of the electronic Atom's Cloud
      // float factorSizeField = OC21 / 20.0 ; // factor size of the electronic Atom's Cloud
      
      /////////TEXT///
      
      float corps ;
      //diameter / hauteur
      corps = map(sizeXObj[IDobj], 0, 100, 6, height *0.66f) ;
     
      PVector posText = new PVector ( 0.0f, 0.0f, 0.0f ) ;
      int sizeTextName = PApplet.parseInt(corps) ;
      int sizeTextInfo = PApplet.parseInt(corps / 2.0f) ;
      //width
      float posTextInfo = sizeYObj[IDobj] + (beat[IDobj] *2.0f)  ;
      //Canvas
      PVector marge = new PVector(canvasXObj[IDobj], canvasYObj[IDobj]) ;
      

      //MODE OF DISPLAY
        if (mode[IDobj] == 0 || mode[IDobj] == 255 ) {
          atm.display( fillObj[IDobj], factorSizeProton * beatSizeProton ) ; // wait color
          atm.eCloudEllipse2D(strokeObj[IDobj], factorSizeField, cloud, factorThicknessCloud) ;
        } else if (mode[IDobj] == 1 ) {
          atm.display( fillObj[IDobj], factorSizeProton * beatSizeProton ) ; // wait color
          atm.eCloudPoint2D(strokeObj[IDobj], factorSizeField, cloud) ;
        } else if (mode[IDobj] == 2 ) {
          atm.title2D (fillObj[IDobj], font[IDobj] , sizeTextName, posText ) ; 
        } else {
          atm.titleAtom2D (fillObj[IDobj], strokeObj[IDobj], font[IDobj] , sizeTextName, sizeTextInfo, posTextInfo ) ; // (color name, color Info, PFont, int sizeTextName,int  sizeTextInfo )
        }
  
      
      //UNIVERS
      ////////////////////////////////////////////////////////////////////////////////////////////
      atm.universWall2D( bottom, top, wallRight, wallLeft, false, marge) ; // obligation to use this void
      ////////////////////////////////////////////////////////////////////////////////////////////
      
      ///////////////////////// INTERNAL VOID \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
      //Electronic Info 
      //atm.electronicInfo() ; // give the number of electronic shell and the Valence Shell
      //atm.addElectron() ;    // add electron on the atom at the begin the electron is equal to "Z"proton
    }
    
    
    

    //CLEAR
    if (emptyList(IDobj)) atomList.clear() ;
    //ADD ATOM
    if(action[IDobj] && nLongTouch && frameCount % 2 == 0) atomAdd(giveNametoAtom()) ;

  }
  //END DRAW
  /////////
  
  
  
  //ANNEXE
  
  //give name to the atom from the karaoke.txt in the source repository
  public String giveNametoAtom() {
    String s = ("") ;
    int whichChapter = floor(random(sentencesByChapter.length)) ;
    int whichSentence = floor(random(sentencesByChapter[0].length)) ;
    //give a random name, is this one is null in the array, give the tittle name of text
    if(sentencesByChapter[whichChapter][whichSentence] != null ) s = sentencesByChapter[whichChapter][whichSentence] ; else s = sentencesByChapter[0][0] ;
    return s ;
  }
  
  // ADD function
  public void atomAdd() {
    //data
    //amplitude
    //give the field of type of atome must be create
    float numP = map(familyObj[IDobj],1,100,1,118) ;
    int Z = PApplet.parseInt(random (1,numP)) ; // Z is the number of protons give the number of electrons max knew is 118
    int ion = round(random(0,0)); // number of electron(s) less(Anion)   more(Cation)   / give the magnetism & conductivity of the atome cannot be equal or sup to "Z"proton
    
    int Kstart = PApplet.parseInt(abs( mix[IDobj]) *1000) ; // Temperature of Atom, influence the mouvement behavior

    if (Kstart > 500 ) Kstart = 500 ;
    // physic action & display in the Univers
    float rebound = 0.5f ;
    int diam = 5 ;
    // Atom motion
    float startVel = 1.0f ;
    PVector posA = new PVector ( mouse[IDobj].x, mouse[IDobj].y, 0.0f ) ;
    PVector velA = new PVector ( random(-startVel, startVel ), random(-startVel, startVel ), random(-startVel, startVel ) ) ;
    
    for (Atom atm : atomList) {
      if(atm.insideField()) return;
    }
    Atom atm = new Atom( posA, velA, Z, ion, rebound, diam,  Kstart) ; 
    atomList.add(atm) ;
  }
  
  //Add atom with a specific name
  public void atomAdd(String name) {
    //data
    //amplitude
    //give the field of type of atome must be create
    float numP = familyObj[IDobj] ;
    int Z = PApplet.parseInt(random (1,numP)) ; // Z is the number of protons give the number of electrons max knew is 118
    int ion = round(random(0,0)); // number of electron(s) less(Anion)   more(Cation)   / give the magnetism & conductivity of the atome cannot be equal or sup to "Z"proton
    
    int Kstart = PApplet.parseInt(abs( mix[IDobj]) *1000) ; // Temperature of Atom, influence the mouvement behavior

    if (Kstart > 500 ) Kstart = 500 ;
    // physic action & display in the Univers
    float rebound = 0.5f ;
    int diam = 5 ;
    // Atom motion
    float startVel = 1.0f ;
    PVector posA = new PVector ( mouse[IDobj].x, mouse[IDobj].y, 0.0f ) ;
    PVector velA = new PVector ( random(-startVel, startVel ), random(-startVel, startVel ), random(-startVel, startVel ) ) ;
    
    for (Atom atm : atomList) {
      if(atm.insideField()) return;
    }
    Atom atm = new Atom(name, posA, velA, Z, ion, rebound, diam,  Kstart) ; 
    atomList.add(atm) ;
  }

}



















///////////
//CLAS ATOM
class Atom 
{
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
  float d, mass, rebound ; // diameter and answer on the wall
  
  //Atomic property
  int  neutron, proton, electron, ion, valenceElectron, missingElectron, freeElectronicSpace ;
  int n = 1 ; // number of electronic shell
  int electronLayer = 0 ; // number of electronic shell
  float screenEffect = 1.0f  ; 
  float electroNegativity = 0.0f ; // Electronegativity of atom 

  float mgt ; // ionic load : give the magnetism atom
  float amp = 1.0f ; // default parameter of the amplitude of electronic field
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
    d = d_ ;
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
    rebound = rebound_ ; d = d_ ;
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
    rebound = rebound_ ; d = d_ ;
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
  public void update(int Kelvin_univers, float velLimit, PVector changeVel, float tempAbs) { 
    vel.x = changeVel.x ;
    vel.y = changeVel.y;
    
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
  
//:::::::Optional void atom ( position, detection...)
  public void drag2D() {
    //strokeWeight(d) ;
    insideA = radiusCursor2D() ;
    insideF = radiusElectronicFieldCursor2D() ;
    if(mousePressed && insideA)   { lock = true; }
    if(!mousePressed)             { lock = false; }
    if(lock) 
    { 
      pos.x = mouseX; 
      pos.y = mouseY;
    }
  }
  //:::::::drag Atom
  public void drag2D(float inertia) {
    //strokeWeight(d) ;
    insideA = radiusCursor2D() ;
    insideF = radiusElectronicFieldCursor2D() ;
    if( mousePressed && insideA) { lock = true; }
    if(!mousePressed)            { lock = false; }
    if(lock) 
    { 
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
        if (collide(target, target.radius(), radius() ) ) {
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
        /*
        if (fieldCollide( target, 
                          target.radiusElectronicFieldCovalent(), radiusElectronicFieldCovalent(), 
                          target.radiusElectronicField(),         radiusElectronicField()          )) {
        */
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
    //  float linking = abs(target.electroNegativity - electroNegativity) * 25.0 ;
    //  float linkingLuck = random(100);
    // if (!target.covalentBondLast || !covalentBondLast ) {
       if (!target.covalentBondLast || !covalentBondLast ) {
           resolveCollision(target , atomVect) ;
           //   if ( linkingLuck < linking ) {
        resolveCollision(target , atomVect) ;
      }  else {
        // new motion of atom when is lock together//
   //     mole = true ; // say the atom is now a molecule
        float factorAddMotion = 2.0f ; // 2.0 is average motion factor
        PVector newVel = new PVector ( (vel.x + target.vel.x) /factorAddMotion , (vel.y + target.vel.y) /factorAddMotion ) ;
        target.vel = newVel ;
        vel  = newVel ;
      }
  //   }
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
  
  public void noContactCovalent() // internal
  {
    collision = false ; // this boolean give the control of the velocity to the update() void
    //for the covalent collision
    electronicCovalentBond() ;
  }
  
  // Update the bond of each atom
  public void electronicCovalentBond() // internal
  {
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
  
  //Display classic
  public void display ( int c, float fs ) {
    if(alpha(c) != 0 ) {
      float thickness = d*fs ;
      if ( thickness < 0.1f ) thickness = 0.1f ;
      strokeWeight(thickness) ;
      if(insideA) { 
        fill(inAtom) ; stroke(inAtom) ;
      } else {
        fill(c) ; stroke(c) ;
        insideA = false ;
      }
      point (pos.x, pos.y) ;
    }
  }
  
  
  //////////////display the electronic Cloud/////////////////////////////
  //Possible to creat a void with 3D or with ellipse
  public void eCloudPoint2D(int eColor, float amp, boolean cloud_) {
    addElectron() ;
    electronicInfo() ;
    
    cloud = cloud_ ;  // send the information to class Univers for the wall
    float Ex ;
    float Ey ;
    
    float ElectronicCloud = radiusElectronicField() *2;
    int Ed = round(d / 10) ;
    if (Ed < 1 ) Ed = 1 ;
    if ( alpha(eColor) != 0 ) {
      for (Electron lctrn : listE) {
        float randomEx = random( -ElectronicCloud, ElectronicCloud ) ;
        float randomEy = random( -ElectronicCloud, ElectronicCloud ) ;
        
        if ( sqrt(sq(randomEx) + sq(randomEy)) > (ElectronicCloud/2 ) ) // to keep the electron in the radius of atom
        {
          Ex = -ElectronicCloud ;
          Ey = -ElectronicCloud ;
        } else {
          Ex = pos.x + randomEx ;
          Ey = pos.y + randomEy ;  
          lctrn.displayPoint2D(Ex, Ey, Ed, eColor) ; 
        }
      }
    }
  }
  // display the ellipse of Valence bond
  public void eCloudEllipse2D(int eColor, float amp, boolean cloud_, float thickness) {
    electronicInfo() ;
    // boolean cloud = cloud_ ;  // send the information to class Univers for the wall

    noFill() ; 
    if ( thickness < 0.1f ) thickness = 0.1f ;
    if ( alpha(eColor) != 0 ) {
      strokeWeight(thickness) ;
      stroke( eColor) ;
      ellipse (pos.x, pos.y, radiusElectronicFieldCovalent() *amp, radiusElectronicFieldCovalent() *amp ) ;
      ellipse (pos.x, pos.y, radiusElectronicField() *amp,     radiusElectronicField() *amp ) ;  
    }  
    
  }
////////////////DISPLAY///////////////////////////////////////////////////////////////////
//////////////Display text & Misc
  // text from main program
  public void title2D(String title, int cName, PFont p, int sizeText, PVector posText ) {
    if ( alpha(cName) != 0 ) {
      fill(cName); textFont(p, sizeText);
      textAlign(CENTER);
      text(title , pos.x +posText.x , pos.y +posText.y );
    }
  }
  public void title2D(int cName, PFont p, int sizeText, PVector posText ) {
    if ( alpha(cName) != 0 ) {
      fill(cName); textFont(p, sizeText);
      textAlign(CENTER) ;
      text(nickName , pos.x +posText.x , pos.y +posText.y );
    }
  }
///////////////////////DISPLAY PROPERTY of ATOM////////////////////////////////////////////
  public void titleAtom2D (int cName, int cInfo, PFont p, int sizeTextName, int sizeTextInfo, float amp_ ) {
    // name
     
    ampInfo = amp_ ;
    float posXtext = (n *d *ampInfo) *0.35f ;
    float posYtext = sizeTextName *0.25f *(ampInfo/10.0f) ;
    
    if ( alpha(cName) != 0 ) {
      fill(cName); textFont(p, sizeTextName);
      textAlign(CENTER);

      text(nameAtom[proton] , pos.x , pos.y + posYtext );
    }
    //Info
    if ( alpha(cInfo) != 0 ) {
      fill(cInfo); textFont(p, sizeTextInfo);
      textAlign (LEFT) ; 
      text(ion,              pos.x +posXtext , pos.y -posYtext );
      text(valenceElectron,  pos.x +posXtext , pos.y +( 2.3f *posYtext));
      //text(valenceElectron,  pos.x +posXtext , pos.y +sizeTextInfo);
      textAlign (RIGHT) ; 
     // text(proton,           pos.x -posXtext , pos.y +sizeTextInfo); 
      text(proton,           pos.x -posXtext , pos.y +( 2.3f *posYtext));
      text(round(mass),      pos.x -posXtext , pos.y -posYtext); 
      
      // capacity of atom for the Covalent Bond
      /*
      String capacity = c ;
      textFont(p, 10); textAlign(CENTER);
      text(capacity , pos.x , pos.y -15 ); 
      //Energy of atom
      String sE = nf(screenEffect, 1, 2 ) ;
      text("SE " + sE + " / EN " + electroNegativity , pos.x , pos.y +20 );
      */
    }
   
   //size of electronicCloud
   //text(radiusElectronicField() , pos.x , pos.y +20 ); 
    
  } 
  

///////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////EXTERNAL INFLUENCE///////////////////////////////////////////////////
  //Wall border
  public void universWall2D(float restitutionBottom_, float restitutionTop_, float restitutionRight_, float restitutionLeft_, boolean wallOnOff_, PVector marge) {
    nvrs.physicWall2D(restitutionBottom_, restitutionTop_, restitutionRight_, restitutionLeft_, wallOnOff_) ;
    nvrs.wall2D(pos, vel, radius(), radiusElectronicField(), rebound, cloud, marge ) ;
  }  
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

   
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
    return  PI*sq(d/2) ;   
  }
  //:::::::::::::::RADIUS:::::::::::::::::::
  //:::::::::::::::Return the radius of atom
  public float radius() { 
    return d / 2;
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
    
    REF =( d *amp *ratioSizeAtom ) ;
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
    if (newPosAtom == 0 ) { ratioSizeAtom = newPosAtom ; } else { ratioSizeAtom = newPosAtom / ((3.0f - pow(newPosAtom, 5)  ) -newPosAtom) ; }
    
    ratioSizeAtom = 1 + ( ratioSizeAtom *ratioPeriodic *base ) ;
    
    REFC =( d *amp *ratioSizeAtom *0.8f ) ;
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
}



//////////////////////////
//SUPER CLASS ELECTRON
class Electron {
  float thick = 1.0f ;
  Electron() {}
  //::::::::::::::::::::::::::::::::::::::::::::::::::
  public void displayPoint2D(float x_ , float y_ ,int d_ , int eColor) {
    if (alpha(eColor) != 0 ) { 
      strokeWeight(d_) ;
      stroke(eColor) ;
      point(x_, y_) ;
    } 
      
    
  //  set(int(x_), int(y_), eColor ) ;
  }
  
  //::::::::::::::::::::::::::::::::::::::::::::::::::
  public void displayPoint3D(float x_ , float y_ , float z_ ,int d_ , int eColor) {
    if (alpha(eColor) != 0 ) {
      strokeWeight(d_) ;
      stroke(eColor) ;
      point(x_, y_, z_) ;
    }
  }
  
  //:::::::::::::::::::::::::::::::::::::::::::::::::::
  public void displayEllipse(float x_ , float y_ ,int d_ , int eColorFill, int eColorStroke, float eThick ) {
    thick = eThick ;
    if (alpha(eColorFill) != 0 && alpha( eColorStroke) != 0  ) {
      strokeWeight(thick) ;
      fill(eColorFill) ;
      stroke(eColorStroke) ;
      ellipse(x_, y_, d_, d_) ;
    } else if (alpha(eColorFill) == 0 ) {
      strokeWeight(thick) ;
      noFill() ;
      stroke(eColorStroke) ;
      ellipse(x_, y_, d_, d_) ;
    } else if (alpha(eColorStroke) == 0 ) {
      noStroke() ;
      fill(eColorFill) ;
      ellipse(x_, y_, d_, d_) ;
    }
  }
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
      //wall right
      if (pos.x > width -r +marge.x || pos.x < r -marge.x ) {
      newVel.x = -newVel.x *renderRight ;        
      } else if (pos.y > height -r + marge.y ||pos.y < r -marge.y ) {
        newVel.y = -newVel.y *renderBottom ;    
      }
    }
    
    //::::::WALL OFF
    //wall right
    if ( !wallOnOff ) {
      if (pos.x > width +r + marge.x ) {
        newPos.x = -r -marge.x;
        newVel.x *=+1 ;
        //wall left
      } else if (pos.x < -r -marge.x  ) {
        newPos.x = width +r + marge.x;
        newVel.x *=+1 ;
        //ground  
      } else if (pos.y > height +r + marge.y ) {
        newPos.y = -r -marge.y;
        newVel.x *=+1 ;
        //roof  
      } else if (pos.y < -r -marge.y ) {
        newPos.y =  height +r +marge.y;
        newVel.x *=+1 ;
      }
    }
  }
}
//END UNIVERS
/////////////
ArrayList<Encre> encreList ;

//object one
class Spray extends SuperRomanesco {
  public Spray() {
    //from the index_objects.csv
    romanescoName = "Spray" ;
    IDobj = 4 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Stan le Punk";
        romanescoVersion = "Alpha 2.0";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
  }
  //GLOBAL
  float inkDry = 0.0001f ; // time to dry the ink, and pixel stop to move
  float  inkDiffusion = 4.0f ; // size of spray 1 to 8 is good
  int  spray = 10 ; // power of the spray
  int inkFlux = 10 ; // flux is quantity ink for the pen or number of particules create each frame
  float angleSpray = 10.0f ; // like is write

  float factorPressure ;
  PVector sprayDirection ;
  
  //SETUP
  public void setting() {
    startPosition(IDobj, 0, 0, 0) ;
    
    encreList = new ArrayList<Encre>();
  }
  //DRAW
  public void display() {
    factorPressure = map(pen[0].z, 0, 1, 1, 50 ) ;
    sprayDirection = new PVector (pen[0].x,pen[0].y) ;
    inkDiffusion = map (speedObj[IDobj] , 0,100, 0, 100 *tempo[IDobj]  ) ; // speed / vitesse
    float flux = map (quantityObj[IDobj], 0,100, 1,1000  ) ; // ink quantity
    float thicknessPoint = thicknessObj[IDobj]*.1f ;
    inkFlux = PApplet.parseInt(flux) ;
    angleSpray   = map (angleObj[IDobj], 0,360, 0,180 ) ; // angle
    inkDry = map (lifeObj[IDobj], 1,100, 1.0f , .0000000001f) ; // dur\u00e9e
    float spr ;
    spr = map(forceObj[IDobj], 1,100 , 1, width) ; // force de diffusion
    spray = PApplet.parseInt(spr) ;
  
   // add encre 
   if (action[IDobj] && nLongTouch && clickLongLeft[0]) addEncre(factorPressure, sprayDirection, angleSpray, spray, inkDiffusion, inkDry, inkFlux) ; 
  
    //display
    for ( Encre e :  encreList ) {
      if (actionButton[IDobj] == 1) e.jitter(tempo[IDobj]) ;
      strokeWeight(thicknessPoint) ;
      noFill() ;
      stroke(fillObj[IDobj]) ;
      point(e.x, e.y) ;
    }
    
    /////////////////////////////
    //CLEAR THE LIST IF NECESSARY 
    if (emptyList(IDobj)) encreList.clear() ;
  }
  
  
  
  //ANNEXE VOID
  public void addEncre(float fp, PVector d, float a, int spray, float dif, float dry, int flux) {
    for ( int i = 0 ; i < flux *fp ; i++ ) {
      
      //to make a good Spray, use a good distribution
      float distribution = random(1) * random(1) ;
      //distribution pixel on the axe, before splash on the angle distribution
      // also we use to the strong push of the pen to the spray longer 
      float distance = spray * fp * distribution  ;
      //angle projection spray
      float angleDeg = random(-a, a);
      float angle = radians(angleDeg) ;
      // calcul of the absolute position of each pixel
      PVector tilt = new PVector ( pen[0].x * distance, pen[0].y * distance ) ;
      //position the pixel around the laticce, pivot...
      PVector posTilt = new PVector ( mouse[0].x - tilt.x , mouse[0].y - tilt.y  ) ;
      
      //calcul the final position to display
      mouse[IDobj].x = rotation(posTilt, mouse[0], angle).x ;
      mouse[IDobj].y = rotation(posTilt, mouse[0], angle).y ;

      
      //put the pixel in the list to use peacefully
      encreList.add( new Encre( mouse[IDobj].x, mouse[IDobj].y, dry, dif)) ;
    }
  }
  
  public void resetEncre() {
    resetEasing(mouse[0] ) ; 
    /*
    if ( c == c ) listE.clear() ; // clear the list if the ink is different
    c = ( c + 1 ) % numColor; // to change the ink after new press on the mmouse
    */
  }
}
//end object one




//Super Class
class Encre {
  float x, y ;
  float dry ;
  float radius ;
  
  Encre (float x, float y, float dry, float radius ) {
    this.x = x ;
    this.y = y ;
    this.dry = dry ;
    this.radius = radius ;
  }

  public void jitter(float var) {
    if (radius > 0 ) radius -= dry ;
    float rad;
    float angle;
    rad = random(-1,1) * radius *var;
    angle = random(-1,1) * ( 2 * PI );
    x += rad * cos(angle);
    y += rad * sin(angle);

  }
}
  
Spirale spirale ; 
//object three
class SpiraleRomanesco extends SuperRomanesco {
  public SpiraleRomanesco() {
    //from the index_objects.csv
    romanescoName = "Spirale" ;
    IDobj = 5 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Alpha 2.0";
    romanescoPack = "Base" ;
    romanescoRender = "P3D" ;
    romanescoMode = "1 Rectangle/2 Ellipse/3 Box" ;
  }
  //GLOBAL
     
    float speed ; ;
  //SETUP
  public void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
    spirale = new Spirale() ;
  }
  //DRAW
  public void display() {
    //quantity
    int n ;
    int nMax = 20 + (int)quantityObj[IDobj] *3 ;
    n = nMax ;
    //amplitude
    float ratioScreen = height - 400 ;
    if (ratioScreen < 1 ) ratioScreen = 1 ;
    float ratio = 1.25f + (ratioScreen *.0005f) ; 
    float z = map(amplitudeObj[IDobj], 0,100,1.01f, ratio)  ;
    //speed
    
    if(motion[IDobj]) {
      float s = map(speedObj[IDobj],0,100,0,8) ;
      s *= s ;
      speed = s *tempo[IDobj] ; 
    } else { 
      speed = 0.0f ;
    }
    //sound volume
    float volumeG = map (left[IDobj], 0,1, 0.5f, 1.5f ) ;
    float volumeD = map (right[IDobj], 0,1, 0.5f, 1.5f ) ;
    
    float heightObj = width  *sizeYObj[IDobj]  *volumeG *0.0005f *kick[IDobj] ;
    float widthObj = height *sizeXObj[IDobj]  *volumeD *0.0005f *hat[IDobj] ;
    float depthObj = height *sizeZObj[IDobj]  *volumeD *0.0005f *hat[IDobj] ;
    PVector size = new PVector(widthObj, heightObj, depthObj) ;
    
    spirale.actualisation (mouse[IDobj], speed) ;
    spirale.affichage (n, nMax, size, z, fillObj[IDobj], strokeObj[IDobj], thicknessObj[IDobj], mode[IDobj]) ;
  }
}





//CLASS
class Spirale extends Rotation {  
  
  Spirale () { 
    super () ;
  }
  public void affichage (int n, int nMax, PVector size, float z, int cIn, int cOut, float e, int mode) {
    n = n-1 ;
    int puissance = nMax-n ;
    float ap = pow (z,puissance) ;
    
    //check the opacity of color
    int alphaIn = (cIn >> 24) & 0xFF; 
    int alphaOut = (cOut >> 24) & 0xFF; 
    // to display or not
    if ( alphaIn == 0 ) noFill() ; else fill (cIn) ;
    if ( alphaOut == 0) {
      noStroke() ;
    } else {
      stroke ( cOut ) ; 
      if( e < 0.1f ) e = 0.1f ; //security for the negative value
      strokeWeight ( e / ap) ;
    }
    
    //display Mode
    if (mode == 0 )      rect (0,0, size.x, size.y ) ;
    else if (mode == 1 ) ellipse (0,0,size.x,size.y) ;
    else if (mode == 2 ) box (size.x,size.y,size.z) ;
    //
    
    translate (2,0 ) ;
    rotate ( PI/6 ) ;
    scale(z) ; 

    if ( n > 0) { affichage (n, nMax, size, z, cIn, cOut, e, mode ) ; }
  }
}
Arbre arbre ;
//object three
class ArbreRomanesco extends SuperRomanesco {
  public ArbreRomanesco() {
    //from the index_objects.csv
    romanescoName = "Arbre" ;
    IDobj = 6 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Alpha 2.0";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
    romanescoMode = "1 Trait/2 Disc/3 Disc trait/4 Rectangle/5 Rectangle trait/6 Box" ;
  }
  //GLOBAL
  float speed ;
  PVector posArbre = new PVector (random(width), random(height) ) ;
  //SETUP
  public void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
    arbre = new Arbre () ;
  }
  //DRAW
  public void display() {
    float epaisseur = thicknessObj[IDobj] ;
    float g = map(left[IDobj], -1, 1, 0, 5) ;
    float d = map(right[IDobj], -1, 1, 2, 7) ;
    int ng = round(g);
    int nd = round( d );
    int propA = ng ;
    int propB =  nd ;
    
    //size
    float x = sizeXObj[IDobj] * (ng + nd ) ;
    float y = sizeYObj[IDobj] * (ng + nd ) ;
    float z = sizeZObj[IDobj] * (ng + nd ) ;
    PVector size  = new PVector(x,y,z  ) ;
    int fourcheA = nd  ; 
    int fourcheB = ng ;
    //orientation
    float direction = directionObj[IDobj] ;
    //amplitude
    float ampSon ;
    if(sound[IDobj]) ampSon = map (abs(mix[IDobj]), 0, 1, .1f ,4) ; else ampSon = 1.0f ;
    float amplitude = map(amplitudeObj[IDobj], 0,100, 0,height *.2f) *ampSon ;
    int n = (ng+nd) ;
    //quantity
    float quantityNode = map(quantityObj[IDobj],1,100,2,32) ;
    int maxNode = PApplet.parseInt(quantityNode) ;
    if ( n>maxNode ) { n = maxNode ; } ;


    // angle
    float angle = map(angleObj[IDobj],0,360,0,90);
    // speed
    if(motion[IDobj]) {
      float s = map(speedObj[IDobj],0,100,0,2) ;
      s *= s ;
      speed = s *tempo[IDobj] ; 
    } else { 
      speed = 0.0f ;
    }
    
    arbre.affichage (direction) ;
    posArbre = new PVector (mouse[IDobj].x, mouse[IDobj].y) ;
    arbre.actualisation(posArbre, fillObj[IDobj], strokeObj[IDobj], epaisseur, size, propA, propB, fourcheA, fourcheB, amplitude, n, mode[IDobj], angle, speed) ;
    
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
  public void actualisation (PVector posArbre, int cIn, int cOut, float e, PVector size, int propA, int propB, int fourcheA, int fourcheB, float amplitude, int n, int mode, float angle, float speed) {
    rotation += speed ;
    // float newAngle = 180 - angle ;
    if ( rotation > angle + 90  ) speed*=-1 ; else if ( rotation < angle ) speed*=-1 ; 
    angle = rotation ; // de 0 \u00e0 180
    // Convert it to radians
    theta = radians(angle);
  
    angleDirection = radians (direction) ;
    pushMatrix () ;
    translate(posArbre.x,posArbre.y);
    // Start the recursive branching
    rotate (angleDirection) ;
    branch(cIn, cOut, e, size, propA, propB, fourcheA, fourcheB, amplitude, n, mode);
    popMatrix () ;
    
  }
//::::::::::::::::::::::::::::  
  public void branch(int colorIn, int colorOut, float e, PVector proportion, int propA, int propB, int fourcheA, int fourcheB, float amplitude, int n, int mode) {
    proportion.x *= random (propA, propB ) / 10 ;
    float fourche = random (0,10) ;
    stroke ( colorOut ) ;
    fill ( colorIn ) ;
    
    //En cours pour v\u00e9rifier la fin de la boucle qui bug qd celle-ci est trop grande.
    if ( e < 0.1f ) e = 0.1f ;
    if( proportion.x < 1 ) proportion.x = 1 ;
    
    
    n = n-1 ;
    // Toutes fonctions r\u00e9p\u00e9titives doit poss\u00e9der une sortie, ici une taille inf\u00e9rieure \u00e0 2
    if (n > 0) {
      if (fourche < fourcheA  ) displayBranch(colorIn, colorOut, e, proportion, propA, propB, fourcheA, fourcheB, amplitude, n, -theta, mode) ; 
                           else displayBranch(colorIn, colorOut,e, proportion, propA, propB, fourcheA, fourcheB, amplitude, n, theta, mode) ;
    }
  }
  
  //annexe branch
  public void displayBranch(int colorIn, int colorOut,float e, PVector proportion, int propA, int propB, int fourcheA, int fourcheB, float amplitude, int n, float t, int mode) {
    pushMatrix();    // Save the current state of transformation (i.e. where are we now)
    rotate(t);   // Rotate by theta

    strokeWeight (e ) ;
     if (mode == 0  ) line(0, 0, 0, -amplitude);  // Draw the branch
    if (mode == 1 ) ellipse(0,0, proportion.x  , proportion.x  ) ;
    if (mode == 2  ) {  ellipse(0,0, proportion.x  , proportion.x  ) ; line(0, 0, 0, -amplitude); }
    if (mode == 3 ) rect(0,0, proportion.x  , proportion.x  ) ;
    if (mode == 4  ) {  rect(0,0, proportion.x  , proportion.x  ) ; line(0, 0, 0, -amplitude); }
    if (mode == 5  ) box(proportion.x  , proportion.x  , proportion.x  ) ;
    translate(0, -amplitude); // Move to the end of the branch
    branch(colorIn, colorOut, e, proportion, propA, propB, fourcheA, fourcheB, amplitude, n, mode);       // Ok, now call myself to draw two new branches!!
    popMatrix();     // Whenever we get back here, we "pop" in order to restore the previous matrix state
  }
}
Bezier bezier ;
//object three
class Courbe extends SuperRomanesco {
  public Courbe() {
    //from the index_objects.csv
    romanescoName = "Courbe" ;
    IDobj = 7 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Alpha 2.0";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
  }
  //GLOBAL
  float speed ;
  //SETUP
  public void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
    bezier = new Bezier() ;
  }
  //DRAW
  public void display() {
    float bezierPoint = forceObj[IDobj] *beat[IDobj] ;
    
    float b1 = (bezierPoint + (left[IDobj] *100)) *2.0f ;
    float b2 = (bezierPoint + (right[IDobj] *100)) *2.0f ;
    float b3 = (bezierPoint + (left[IDobj] *100)) *2.0f ;
    float b4 = (bezierPoint + (right[IDobj] *100)) *2.0f ;
    float b5 = (bezierPoint - (left[IDobj] *100)) *2.0f ;
    float b6 = (bezierPoint - (right[IDobj] *100)) *2.0f ;
    float b7 = (bezierPoint - (left[IDobj] *100)) *2.0f ;
    float b8 = (bezierPoint - (right[IDobj] *100)) *2.0f ;
    
    //vitesse / speed
    if (motion[IDobj]) speed  = speedObj[IDobj]*.2f *tempo[IDobj] ; else speed = 0.0f ;

    
    //amplitude
    float ampB = map(amplitudeObj[IDobj],0,100, -50, width *.5f) ;
    int amp = PApplet.parseInt(ampB) ;
    //color
    //pos point of the shape
    PVector posBezier = new PVector (0,0) ;
    posBezier.x = (mouse[IDobj].x - (width /2))  *2 ;
    posBezier.y = (mouse[IDobj].y - (height /2)) *2  ;
    
    bezier.actualisation (mouse[IDobj], speed) ;
    bezier.affichageBezier (fillObj[IDobj], strokeObj[IDobj], posBezier, thicknessObj[IDobj], amp, b1, b2, b3, b4, b5, b6, b7, b8) ;
    
  }
}
//end object two



class Bezier extends Rotation {  
  Bezier () { super () ; }
  
  public void affichageBezier (int cIn, int cOut, PVector pos, float e, int z, float b1, float b2, float b3, float b4, float b5, float b6, float b7, float b8) {
    //check the opacity of color
    int alphaIn = (cIn >> 24) & 0xFF; 
    int alphaOut = (cOut >> 24) & 0xFF; 
    // to display or not
    if ( alphaIn == 0 ) noFill() ; else fill (cIn) ;
    if ( alphaOut == 0) {
      noStroke() ;
    } else {
      stroke ( cOut ) ; 
      if( e < 0.1f ) e = 0.1f ; //security for the negative value
      strokeWeight (e) ;
    }
    /*
    float zy = map (z, 0, 101, 0, height/2) ;
    float posYH = height / 2 - zy ;
    float posYB = height / 2 + zy ;
    float posXG = -zy ;
    float posXD = width + zy ;
    */
    float zy = map (z, 0, 101, 0, pos.y/2) ;
    //float posYH = pos.x / 2 - zy ;
    // float posYB = pos.y / 2 + zy ;
    float posXG = -zy ;
    float posXD = pos.x + zy ;
    beginShape();
    vertex(posXG, 0);
    bezierVertex(b1, b2, b3, b4,
                posXD, 0 );  
    bezierVertex(b5, b6, b7, b8,  
                posXG, 0);
    endShape();
    noStroke() ;
  }
  
}
Balise balise ;
//object three
class BaliseRomanesco extends SuperRomanesco {
  public BaliseRomanesco() {
    //from the index_objects.csv
    romanescoName = "Balise" ;
    IDobj = 8 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Alpha 2.0";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
    romanescoMode = "1 Disc/2 Rectangle" ;
  }
  //GLOBAL
  float speed ;
  //SETUP
  public void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
    balise = new Balise() ;
  }
  //DRAW
  public void display() {
    if (motion[IDobj]) speed = (map(speedObj[IDobj], 0,100, 0,20)) *tempo[IDobj] ; else speed = 0.0f ;

    //amplitude
    float amp = map(amplitudeObj[IDobj], 0,100, 0, width) ;

    //hauteur / largeur
    float tempoEffect = 1 + ((beat[IDobj] -1  ) + (kick[IDobj] -1  ) + (snare[IDobj] -1  ) + (hat[IDobj] -1  ) );
    PVector sizeBalise  = new PVector (sizeXObj[IDobj] *tempoEffect, sizeYObj[IDobj] *tempoEffect ) ;
    // variable position
    PVector var = new PVector(left[IDobj],right[IDobj]) ; 
    //quantity
    float radiusBalise = map(quantityObj[IDobj], 1,100, 2, 511); // here the value max is 511 because we work with buffersize with 512 field
    
    balise.actualisation (mouse[IDobj] , speed) ;
    if (mode[IDobj] == 0 || mode[IDobj] == 255 ) {
      balise.baliseDisc (fillObj[IDobj], strokeObj[IDobj], thicknessObj[IDobj], amp, var, sizeBalise, PApplet.parseInt(radiusBalise), sound[IDobj]) ;
    } else if (mode[IDobj] == 1 ) {
     balise.baliseRect (fillObj[IDobj], strokeObj[IDobj], thicknessObj[IDobj], amp, var, sizeBalise, PApplet.parseInt(radiusBalise), sound[IDobj]) ;
    } 
    
  }
}
//end object two







// CLASS BALISE
class Balise extends Rotation {  
  
  Balise () { super () ; }
  
  public void baliseDisc (int cIn, int cOut, float e, float amp, PVector var, PVector sizeBalise, int max, boolean sound ) {
    pushMatrix() ;
    rectMode(CENTER) ;
    
    PVector inputResult = new PVector(0,0,0) ;
    if ( max > 512 ) max = 512 ;
    for(int i = 0 ; i < max ; i++) {
      PVector v = new PVector(input( i,max,var,sound).x, input(i,max,var,sound).y) ;
      PVector posBalise = new PVector ( amp * v.x, amp * v.y ) ;
      
      stroke(cOut) ;
      fill(cIn) ;
      strokeWeight(e) ;
      ellipse(posBalise.x, posBalise.y, sizeBalise.x *abs(v.x*50), sizeBalise.y * abs(v.y*50) ) ;
    }
    rectMode(CORNER) ;
    popMatrix() ;
    noStroke() ;
  }
  
  public void baliseRect (int cIn, int cOut, float e, float amp, PVector var, PVector sizeBalise, int max, boolean sound ) {
    pushMatrix() ;
    rectMode(CENTER) ;
    PVector inputResult = new PVector(0,0,0) ;
    if ( max > 512 ) max = 512 ;
    for(int i = 0 ; i < max ; i++) {
      PVector v = new PVector(input( i,max,var,sound).x, input(i,max,var,sound).y) ;
      PVector posBalise = new PVector ( amp * v.x, amp * v.y ) ;
      //check the opacity of color
      stroke(cOut) ;
      fill(cIn) ;
      strokeWeight(e) ;
      rect(posBalise.x, posBalise.y, sizeBalise.x *abs(v.x*50), sizeBalise.y * abs(v.y*50) ) ;
    }
    rectMode(CORNER) ;
    popMatrix() ;
    noStroke() ;
  }
  
  //calculate and return the position for each brick of the balise
  public PVector input( int whichOne, int max, PVector var, boolean b) {
    PVector value = new PVector(0,0,0) ;
    if(b) {
      value = new PVector ( (input.left.get(whichOne)*var.x), (input.right.get(whichOne)*var.y) ) ; 
    } else {
      float n = (float)whichOne ;
      n = n - (max/2) ;
      value = new PVector ( n*var.x *.01f, n*var.y *.01f ) ; 
    }
    return value ;
  }
}
ArrayList <Polygon2D> polygons = new ArrayList <Polygon2D> (); // Liste pour les polygones (objet 8 )
ArrayList <Vec2D> points = new ArrayList <Vec2D> ();


//object three
class Polygone extends SuperRomanesco {
  public Polygone() {
    //from the index_objects.csv
    romanescoName = "Polygone" ;
    IDobj = 9 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Alpha 2.0";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
  }
  //GLOBAL
  int draggedPolygon = -1;
  boolean onPolygon;
  float anglePoly ;
  float speed ;
  PVector finalPos = new PVector(0,0,0) ;
  float ratioSound = 1 ;
  float raioControler = 1 ;
  float ratioFinal ;
  Vec2D mousePolygon;
  ToxiclibsSupport gfx = new ToxiclibsSupport(callingClass);
  
  //SETUP
  public void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
    // init
    for(int i = 0 ; i < 4 ; i++) {
      mousePolygon = new Vec2D(random(width),random(height));
      points.add(mousePolygon);
    }
    polygons.add(new Polygon2D(points));
    points.clear();
  }
  
  
  //DRAW
  public void display() {
    
    if (parameter[IDobj]) {
      //Dessin des points
      mousePolygon = new Vec2D(mouse[0].x,mouse[0].y);
      
      // prescene preview points
      int cCross = color (hue(strokeObj[IDobj]), saturation(strokeObj[IDobj]), brightness(strokeObj[IDobj]), 120);
      float eCross = map(thicknessObj[IDobj],0,100, 1,15) ; ;
      int sCross = 5 ;
      for (Vec2D p : points) {
        PVector newPos = new PVector ( p.x, p.y) ;
        crossPoint(newPos, cCross, PApplet.parseInt(eCross), sCross) ;
      }
     
    }
    
    //display shape
    //PARAMETER
    //thickness
    float e = thicknessObj[IDobj] ;
    if ( e < 0.1f ) e = 0.1f ; // security against the negative value
    //gap and scale effect
    float ratioControler = map(amplitudeObj[IDobj], 0, 100, 0.1f,10) ;
    float ratioSound = abs(mix[IDobj]) ;
    if (!sound[IDobj] ) ratioFinal =  ratioControler *ratioSound ; else ratioFinal =ratioControler ;


    PVector pos = new PVector (mouse[IDobj].x, mouse[IDobj].y ) ;
    PVector posPoly = new PVector ( width/2  - mouse[IDobj].x,
                                    height/2 - mouse[IDobj].y) ; 

    //color
    int colorIn = fillObj[IDobj] ;
    int colorOut = strokeObj[IDobj] ;
    //speed
    if (motion[IDobj]) speed = (map(speedObj[IDobj], 0,100, 0,20)) *tempo[IDobj] ; else speed = 0.0f ;
    anglePoly += speed ;
    if(anglePoly > 360 ) anglePoly = 0 ;
    float angle = map(anglePoly, 0, 360, 0, TAU) ;
        
    if(motion[IDobj]) finalPos = rotation(pos, posPoly, angle) ;
    //.............
    translate(finalPos.x -posPoly.x, finalPos.y -posPoly.y) ;
    scale(ratioFinal) ;

    
    
    // (re)set onPolygon to false
    onPolygon = false;
    // draw all the polygons
    for (Polygon2D p : polygons) {

      //check the opacity of color
      int alphaIn = (colorIn >> 24) & 0xFF; 
      int alphaOut = (colorOut >> 24) & 0xFF; 
      // to display or not
      if ( alphaIn == 0 ) noFill() ; else fill (colorIn) ;
      if ( alphaOut == 0) {
        noStroke() ;
      } else {
        stroke ( colorOut ) ; 
        if( e < 0.1f ) e = 0.1f ; //security for the negative value
        strokeWeight (e) ;
      }
      gfx.polygon2D(p);
    }
    
    
    
    
    //create the shape and close the shape
    if ( parameter[IDobj]) {
     
      // if the mouse is NOT on a polygon
      if (!onPolygon) {
        // add a point at mouseX,mouseY
        if(clickShortLeft[IDobj] && nLongTouch ) {
          points.add(mousePolygon);
        }
        // if the right mouse button is pressed
        // and there are more than 2 points
        if (clickLongRight[IDobj] && points.size() > 2) {
          // create a polygon from the points
          polygons.add(new Polygon2D(points));
          // clear the points
          points.clear();
        }
      }
    }
    
    
    //remove specific shape
    if ( action[IDobj]) {
      // delete the polygon under the mouse
      if (dTouch && !clickLongLeft[IDobj] && !clickLongRight[IDobj] && !clickShortLeft[IDobj] && !clickShortRight[IDobj]) {
        for (int i=polygons.size()-1; i>=0; i--) {
          if (polygons.get(i).containsPoint(mousePolygon)) {
            polygons.remove(i);
          }
        }
      }
      // remove the last point (if points > 0)
      if (xTouch) {
        if (points.size() > 0) {
          points.remove(points.size()-1);
        }
      }
    }
    
    
    //move polygone probleme
    // if (actionButton[IDobj] == 1 ) draggedPolygon = -1 ; 
    
    
    /////////////////////////////
    //CLEAR THE LIST IF NECESSARY 
    if (emptyList(IDobj))  {
      polygons.clear() ;
      points.clear() ;
    }
    
  }
}
//end object two


Line line ;
//object three
class Lignes extends SuperRomanesco {
  public Lignes() {
    //from the index_objects.csv
    romanescoName = "Lignes" ;
    IDobj = 10 ;
    IDgroup = 2 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Alpha 2.1";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
  }
  //GLOBAL
  float ampLine  =1.0f ;
  float speed ;
  float thicknessLine ;
  //SETUP
  public void setting() {
    startPosition(IDobj, 0, 0, 0) ;
    line = new Line() ;
  }
  //DRAW
  public void display() {
    if( beat[IDobj] > 1 ) {
      ampLine = beat[IDobj] *(map(amplitudeObj[IDobj], 0,100, 0, 3)) ;
      thicknessLine = (thicknessObj[IDobj] *ampLine ) ;
    } else {
      thicknessLine = thicknessObj[IDobj] ;
    }

    //speed
    if(motion[IDobj]) speed = map(speedObj[IDobj], 0,100, -25,25 ) * tempo[IDobj]  ; else speed = 0.0f ;
    //to stop the move
    if (action[IDobj]  && spaceTouch ) speed = 0.0f ;
    
    rotation(directionObj[IDobj], mouse[IDobj].x, mouse[IDobj].y ) ;
    
    //quantit\u00e9
    float q = map(quantityObj[IDobj], 1, 100, width , height *.2f) ;



    line.drawLine (speed, q , fillObj[IDobj],  thicknessLine) ;
    
  }
}
//end 





//CLASS TRAME
class Line {
  Line()  { }
  
  float nbrlgn ; 
  int vitesse ;
  float vd, vg ;
  
  public void drawLine ( float v, float q, int cOut, float e) {
    if( e < 0.1f ) e = 0.1f ; //security for the negative value
    stroke (cOut) ; strokeWeight(e) ;
    float quantite = q*q *.001f ;
    //nbrlgn = quantite ;
   nbrlgn = (width + height) / quantite  ;
    vitesse += (v) ;
    if ( abs(vitesse) > quantite ) {
      vitesse = 0 ; 
    }
    for (int i=0 ; i < nbrlgn +1 ; i++) {
      float x1 = ( -(height) +i*( (width+ height ) /nbrlgn) ) +vitesse -e ;
      float y1 = -e ;
      float x2 =  ( 0 +i*( (width + height )  /nbrlgn) ) +vitesse +e ;
      float y2 = width+height +e ; 
      line ( x1 , y1 , x2 , y2);
    }
  }

}
Trame trame ;
//object three
class Damier extends SuperRomanesco {
  public Damier() {
    //from the index_objects.csv
    romanescoName = "Damier" ;
    IDobj = 11 ;
    IDgroup = 2 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Alpha 2.0";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
    romanescoMode = "1 Rectangle/2 Ellipse/3 Box" ;
  }
  //GLOBAL
  float d, g ;
  PVector size = new PVector(0,0,0) ;
  float angleTrame = 0 ;
  float angle = 0 ;
  float vitesse = 0 ;

  //SETUP
  public void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
    trame = new Trame() ;

  }
  //DRAW
  public void display() {
    if ( sound[IDobj]) {
      g = left[IDobj] ; 
      d = right[IDobj] ; 
    } else {  
      g = 0.0f ;
      d = 0.0f ;
    }
    size.x = ( sizeXObj[IDobj] + pen[IDobj].z ) * abs(1 + g) ;
    size.y = ( sizeYObj[IDobj] + pen[IDobj].z) * abs(1 + d) ;
    size.z = ( sizeZObj[IDobj] + pen[IDobj].z)  ;
    //size

    //orientation / deg
    translate( mouse[IDobj].x, mouse[IDobj].y) ;
    vitesse = map(speedObj[IDobj], 0,100,0, 0.07f );
    //speed rotation
    if ( vitesse == 0  ) angleTrame = angleObj[IDobj] ; else angleTrame += vitesse *tempo[IDobj] ;
    if (spaceTouch && action[IDobj]) angle = map(angleObj[IDobj], 0,100, 0, TAU) ; else angle = 0 ;
    //quantity
    int q = PApplet.parseInt(map(quantityObj[IDobj], 0, 100, 2,50)) ;

    //amp
    float amp = map(amplitudeObj[IDobj],0,100, .5f, 3) ;
    
    //MODE DISPLAY
    if(mode[IDobj] == 0 || mode[IDobj] == 255) trame.drawTrameRect(mouse[IDobj], angleTrame, angle, size , q, fillObj[IDobj], strokeObj[IDobj], thicknessObj[IDobj], g, d, amp) ;
    else if (mode[IDobj] == 1) trame.drawTrameDisc(mouse[IDobj], angleTrame, angle, size , q, fillObj[IDobj], strokeObj[IDobj], thicknessObj[IDobj], g, d, amp) ;
    else if (mode[IDobj] == 2) trame.drawTrameBox(mouse[IDobj], angleTrame, angle, size , q, fillObj[IDobj], strokeObj[IDobj], thicknessObj[IDobj], g, d, amp) ;
    
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
  public void drawTrameRect (PVector axe, float angleTrame, float angleObj, PVector size, int nbrlgn, int cIn, int cOut, float e, float gauche, float droite, float amp ) {
    //check the opacity of color
    shapeProperty(cIn, cOut, e) ;
    
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
  public void drawTrameDisc (PVector axe, float angleTrame, float angleObj, PVector size, int nbrlgn, int cIn, int cOut, float e, float gauche, float droite, float amp   ) {
    //check the opacity of color
    
    shapeProperty(cIn, cOut, e) ;
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
  public void drawTrameBox (PVector axe, float angleTrame, float angleObj, PVector size, int nbrlgn, int cIn, int cOut, float e, float gauche, float droite, float amp   ) {
    //check the opacity of color
    
    shapeProperty(cIn, cOut, e) ;
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
  
  
  

  
  
  
  //Display 
  public void shapeProperty(int cIn, int cOut, float e) {
    int alphaIn = (cIn >> 24) & 0xFF; 
    int alphaOut = (cOut >> 24) & 0xFF; 
    // to display or not
    if ( alphaIn == 0 ) noFill() ; else fill (cIn) ;
    if ( alphaOut == 0) {
      noStroke() ;
    } else {
      stroke ( cOut ) ; 
      if( e < 0.1f ) e = 0.1f ; //security for the negative value
      strokeWeight (e) ;
    }
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
ArrayList rideauList = new ArrayList() ;

//object one
class Rideau extends SuperRomanesco {
  public Rideau() {
    //from the index_objects.csv
    romanescoName = "Rideau" ;
    IDobj = 12 ;
    IDgroup = 2 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Alpha 2.0";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
    romanescoMode ="1 Rectangle/2 Box" ;
  }
  //GLOBAL
  

  //SETUP
  public void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
  }
  //DRAW
  public void display() {
    //END OF DON'T TOUCH
    //speed / vitesse
    float vitesse = 0.01f + (speedObj[IDobj] *0.001f) ;
    //dur\u00e9e / life
    int vie = 100 + (100 * PApplet.parseInt(lifeObj[IDobj])) ;
    //thickness / \u00e9paisseur
    // int epaisseur = 1 + int((valueObj[IDobj][13] *.5) + abs(mix[IDobj]) *10);
    float thickness = thicknessObj[IDobj] + abs(mix[IDobj]) *10 ;
    
    PVector size = new PVector(sizeXObj[IDobj],sizeYObj[IDobj],sizeYObj[IDobj]) ;
    //Color
    float opacityIn = round(alpha(fillObj[IDobj]) + ((mix[IDobj]) *25 )) ;
    float opacityOut = alpha(strokeObj[IDobj]) ;
    int colorIn = fillObj[IDobj] ;
    int colorOut = strokeObj[IDobj] ;
    
   //orientation / degr\u00e9
   rotation(directionObj[IDobj], (mouse[IDobj].x *2) -width/2  , (mouse[IDobj].y *2) -height/2 ) ;
    
    for (int i=0 ; i < rideauList.size(); i++) {
      Curtain c = (Curtain) rideauList.get(i); // GET donne l'ordre d'aller chercher de la particule dans le la Valise Fourre Tout
      if (c.disparition () ) {
        rideauList.remove (i) ;
      } else {
        c.actualisation ();
        if(mode[IDobj] == 0 || mode[IDobj] == 255) c.drawRect(colorIn, colorOut, opacityIn, opacityOut, thickness, size.x)  ;
        else if (mode[IDobj] == 1) c.drawBox(colorIn, colorOut, opacityIn, opacityOut, thickness, size)  ;
        
      }
    }
    if (action[IDobj] && nTouch) {
      rideauList.add( new Curtain(vitesse, vie )) ;
    }
    
  }
}
//end object one







//////////////
//CLASS CURTAIN
class Curtain { 
  int chrono, transp, transpb ;
  int vp ;
  float croissance, v, mvt, posX ; 
  Curtain(float vitesse, int vie)  {
   v = vitesse ; vp = vie ; 
  }
  
  public boolean disparition () {
    if (vp < 0 ) {
      return true ;
    } else {
      return false ;
    }
  }
  
  
  public void actualisation() {
    
    mvt += v ;
    posX += mvt ;
    if (posX > width ) { 
      posX = width  ;  
      mvt*=-1 ;
      mvt = mvt - v ;
    } else if (posX < 0 ) { 
      posX = 0 ;       
      mvt*=-1 ;
    }
  }
  
  
  //SHAPE
  public void drawRect (int cIn, int cOut, float oIn, float oOut, float e, float h) {
    //security for the negative valu
    if( e < 0.1f ) e = 0.1f ;

    if (vp < oIn )   { oIn = vp ;   } else { oIn = oIn ; }
    if (vp < oOut )  { oOut = vp ;  } else { oOut = oOut ; }
    
    //life
    vp = vp + chrono ;
    chrono = -1 ; 
    
    //DISPLAY
    strokeWeight(e) ;
    fill ( cIn, oIn ) ;
    stroke (cOut, oOut ) ;
    rect ( posX ,  -e, posX - (mouse[0].x/3) , h+(2*e) ) ;
  }
  
  
  public void drawBox (int cIn, int cOut, float oIn, float oOut, float e, PVector size) {
    //security for the negative valu
    if( e < 0.1f ) e = 0.1f ;

    if (vp < oIn )   { oIn = vp ;   } else { oIn = oIn ; }
    if (vp < oOut )  { oOut = vp ;  } else { oOut = oOut ; }
    
    //life
    vp = vp + chrono ;
    chrono = -1 ; 
    
    //DISPLAY
    strokeWeight(e) ;
    fill ( cIn, oIn ) ;
    stroke (cOut, oOut ) ;
    translate(posX ,  -e) ;
    box(size.x+(2*e), posX - (mouse[0].x/3), size.z+(2*e)) ;
    //rect ( posX ,  -e, posX - (mouseX/3) , size.x+(2*e) ) ;
  }
}
  ArrayList<BOITEaMUSIQUE> boiteList ;
  
class Boxolyzer extends SuperRomanesco {
  public Boxolyzer() {
    //from the index_objects.csv
    romanescoName = "Boxolyzer" ;
    IDobj = 13 ;
    IDgroup = 2 ;
    romanescoAuthor  = "My name is Nobody";
    romanescoVersion = "Alpha 1.0";
    romanescoPack = "Base" ;
    romanescoRender = "P3D" ;
    romanescoMode ="1 Classic/2 Circle" ;
  }
  //GLOBAL
  boolean newDistribution ;
  int numBoxRef ;

  //SETUP
  public void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
    
    boitesSetting() ;
  }
  //DRAW
  public void display() {
    //CLASSIC DISPLAY
    int numBox = PApplet.parseInt(map(quantityObj[IDobj],1,100,1,16)) ;
    if (numBox != numBoxRef ) newDistribution = true ;
    numBoxRef = numBox ;
    PVector size = new PVector(sizeXObj[IDobj],sizeYObj[IDobj],sizeZObj[IDobj]) ;
    //
    fill(fillObj[IDobj]) ;
    stroke(strokeObj[IDobj]) ;
    strokeWeight(thicknessObj[IDobj]) ; 
    //
    distribution(numBox, newDistribution) ;
    
    // MODE DISPLAY with the dropdown menu of controler
    /////////////////////
    if        (mode[IDobj] ==0) { boxolyzerClassic(size, horizon[IDobj] , directionObj[IDobj]) ;
    } else if (mode[IDobj] ==1) { boxolyzerCircle(size, PApplet.parseInt(canvasXObj[IDobj]*.1f), horizon[IDobj], directionObj[IDobj]) ;
    } else if (mode[IDobj] ==2) {
    // and same for the next
    } else {
    }
    
  }
  
  //ANNEXE VOID
  public void distribution(int n, boolean newOne) {
     if (newOne) newDistributionBoite(n) ;
     newDistribution = false ;
   }
  
  boolean orientation ;
  // BOXLIZER CIRCLE
  public void boxolyzerCircle(PVector size, int diam, boolean groundPosition, float dir) {
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
  public void boxolyzerClassic(PVector size, boolean groundPosition, float dir) {
    PVector pos = new PVector(0,height /2 ,0) ;
    float factorSpectrum = 0 ;
    int n = boiteList.size() ;
    for( int i = 0 ; i < n ; i++) {
      pos.x = (i *width/n) + (width/(n*2)) ;
      if(  i < band.length) factorSpectrum = band [IDobj][i] ;
      BOITEaMUSIQUE boiteAmusique = (BOITEaMUSIQUE) boiteList.get(i) ;
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
    PVector size = new PVector (1,1,1) ;
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
  PVector size = new PVector (0,0,0) ;
  int ID ;
  
  BOITEaMUSIQUE(PVector size, int ID) {
    this.ID = ID ;
    this.size = size ;
  }
  
  
  
  public void showTheBoite(PVector pos, PVector size, float factor, boolean groundLine, float dir) {
    PVector newSize = new PVector (size.x, size.y *factor,size.z *factor ) ;
    //put the box on the ground !
    float horizon = pos.y - ( newSize.y *.5f ) ;  
    pushMatrix() ;
    if (!groundLine) translate(pos.x, pos.y, pos.z) ; else translate(pos.x, horizon, pos.z) ;
    rotateX(radians(dir)) ;
    box(newSize.x,newSize.y,newSize.z) ;
    popMatrix() ;
  }
}

class Webcam extends SuperRomanesco {
  public Webcam() {
    //from the index_objects.csv
    romanescoName = "Webcam" ;
    IDobj = 14 ;
    IDgroup = 2 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Alpha 2.0";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
    romanescoMode = "1 classic/2 monochrome" ;
  }
  //GLOBAL
  int cameraStatut = 0 ;
  //class
  GSCapture cam;
  //Cameras
  int [] [] sizeCam = { {640,480}, {160,120}, {176,144}, {320,240}, {352,288} } ;
  int whichSizeCam = 4 ; // choice the resolution size of camera
  String whichCam = "2" ; // choice the camera
  boolean nativeWebCam ;
  int testDeviceCam ;
  
  PVector factorDisplayCam = new PVector ( 0,0) ;
  PVector factorDisplayPixel = new PVector ( 0,0) ;
  PVector factorCalcul = new PVector (0,0) ;
  // PVector posMovie = new PVector(0,0 ) ; // position x & y for the camera
  
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
    
    factorDisplayPixel = factorDisplayCam ;//PARAMETER THAT YOU CAN USE
    
    //PART TWO
    cam.start();
    cellSizeX = 2 + PApplet.parseInt(sizeYObj[IDobj])  ; 
    cellSizeY = 2 + PApplet.parseInt(sizeXObj[IDobj])  ;
    // factorDisplayPixel.x = factorDisplayCam.x / (20 -TD123/10 ) ; 
   //  factorDisplayPixel.y = factorDisplayCam.y / (20 -TD123/10 ) ; 
    
    cols = sizeCam [whichSizeCam][0] / cellSizeX; // before the resizing
    rows = sizeCam [whichSizeCam][1] / cellSizeY; 
    if (testCam()) {
      cam.read();
      cam.loadPixels() ;
      for (int i = 0; i < cols ; i++) {
        for (int j = 0; j < rows  ; j++) {
          // Where are we, pixel-wise?
          posPixelX = i *cellSizeX  ;
          posPixelY = j *cellSizeY  ;
          //// display pixel 
          int  loc = posPixelX  + posPixelY *cam.width; // classic
          //  int loc = (cam.width - x - 1) + y*cam.width; // mirror
          // FUN
          /*
          int loc = x + y; 
          int loc = x *y;
          int loc = cam.width  + y*cam.width;
          */
          
          //make pixel
          float h = hue(cam.pixels[loc]);
          float s = saturation(cam.pixels[loc]);
          float b = brightness(cam.pixels[loc]);
          // Make a new color with an alpha component
         // color c = color(h, s, b);
          
          
          //mode of display
          if (mode[IDobj] == 0 || mode[IDobj] == 255 ) {
            //color mode
            colorPixelCam = color(h, s, b, alpha(fillObj[IDobj]));
          } else if (mode[IDobj] == 1 ) {
            //monochrome mode, change param from the cam with the slider influence
            float newHue = hue(fillObj[IDobj]) ;
            float newSat = s * map(saturation(fillObj[IDobj]),0,100,0,1) ;
            float newBrigth = b * map(brightness(fillObj[IDobj]),0,100,0,1) ;
            //display the result
            colorPixelCam = color(newHue, newSat, newBrigth, alpha(fillObj[IDobj]));
          }
          ////////////
          
          //DISPLAY
          //DON'T TOUCH
          pushMatrix() ;
          //P3D Give the position and the orientation of your object in the 3 dimensionals space

          //END OF DON'T TOUCH 
          PVector newDisplay = new PVector  (cellSizeX *factorDisplayCam.x,   cellSizeY *factorDisplayCam.y) ;
          PVector newCellSize = new PVector (cellSizeX *factorDisplayPixel.x *left[IDobj], cellSizeY *factorDisplayPixel.y *right[IDobj]) ;

          //init the position of image on the middle of the screen
          PVector posMouseCam = new PVector ( width / 2, height /2) ;
          if (mouse[IDobj].x >= -startingPos[IDobj].x && mouse[IDobj].y >= -startingPos[IDobj].y) posMouseCam = mouse[IDobj] ;
          //create the ratio for the translate position in functiun of the size of the Scene, not really good algorythm
          float ratioDisplay = (float)width / (float)height ;
          float factorDisplacementRatioSizeOfTheDisplay = map(width, 0, 2000, .6f, .2f ) ;
          float factorTranslateX = factorDisplacementRatioSizeOfTheDisplay / ratioDisplay ;
          float factorTranslateY = factorDisplacementRatioSizeOfTheDisplay ;
          //finalization of the position
          translate( ( (posPixelX +newDisplay.x *factorTranslateX) *factorDisplayCam.x) + posMouseCam.x - width *0.5f , 
                     ( (posPixelY +newDisplay.y *factorTranslateY) *factorDisplayCam.y) + posMouseCam.y - height*0.5f  );
                     
          rectMode(CENTER) ;
          fill(colorPixelCam) ;
          noStroke() ;
          rect (0,0, newCellSize.x, newCellSize.y) ;
          //DON'T TOUCH
          popMatrix() ;
          //END OF DON'T TOUCH
        }
      } 
    } else if (!testCam() && testDeviceCam < 180 )  {
      fill(0) ;
      testDeviceCam += 1 ;
      text("No extarnal video signal, Romanesco try on the native Camera", mouse[0].x , mouse[0].y ) ;
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
  int testCam ;
  public boolean testCam() {
    if (cam.available() ) testCam =+ 30 ; else testCam -= 1 ;
    if ( testCam < 1 ) testCam = 0 ;
    
    if ( testCam > 2 ) {
      videoSignal = true ;
    } else {
      videoSignal = false ;
    }
    
    if ( testCam > 2 ) return true ;  else return false ;
  }
}
//end object one







// END OBJECT ROMANESCO
///////////////////////


class Galaxie extends SuperRomanesco {
  public Galaxie() {
    //from the index_objects.csv
    romanescoName = "Galaxie" ;
    IDobj = 15 ;
    IDgroup = 2 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Alpha 2.0";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
    romanescoMode ="1 Point/2 Ellipse/3 Rectangle" ;
  }
  //GLOBAL
    boolean makeSand = true ;
  boolean shiftGrain = false ;
  boolean gravityGrain = true ;
  PVector posCenterGrain = new PVector(0,0,0) ;

  PVector orientationStyletGrain ;

  int numGrains ;
  int numFromControler ;
  PVector [] grain ;
  float vitesseGrainA = 0.0f;
  float vitesseGrainB = 0.0f ;
  PVector vitesseGrain = new PVector (0,0) ;
  float speedDust ;
  //vibration
  float vibrationGrain = 0.1f ;
  //the stream of sand
  PVector deformationGrain = new PVector (0.0f, 0.0f ) ;

  PVector motionGrain = new PVector (0.0f , 0.0f) ;
  float newRayonGrain = 1 ;
  float variableRayonGrain = -0.001f ;
  
  
  //SETUP
  public void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
  }
  //DRAW
  public void display() {
    
    if (mode[IDobj] == 0 || mode[IDobj] == 255 ) numFromControler = PApplet.parseInt(3*(sq(quantityObj[IDobj])) ) ; else numFromControler = 30 + PApplet.parseInt(10 *quantityObj[IDobj]) ;
    if (numGrains != numFromControler && parameterButton[IDobj] == 1 ) makeSand = true ;
    if (makeSand) {
      numGrains = numFromControler ;
      grainSetup(numGrains) ;
      makeSand = false ;
    }
 
    //give back the pen info
    float pressionGrain = sq(1 + pen[IDobj].z) ;
    orientationStyletGrain = new PVector ( 4* pen[IDobj].x , pen[IDobj].y ) ;
    
    //float vitesse = vitesseGrainA ;
   // float vitesseSound = gaucheDroite ;
    // speed / vitesse
    vitesseGrainA = map(left[IDobj],0,1, 1, 2) ;
    vitesseGrainB = map(right[IDobj],0,1, 1, 2) ;
    
    if(motion[IDobj]) speedDust = map(speedObj[IDobj],0,100, 0.0001f ,2) ; else speedDust = 0.0001f ;
    
    vitesseGrain.x = vitesseGrainA *speedDust *tempo[IDobj] *pressionGrain  ;
    vitesseGrain.y = vitesseGrainB *speedDust *tempo[IDobj] *pressionGrain  ;

    posCenterGrain.x = mouse[IDobj].x ;
    posCenterGrain.y = mouse[IDobj].y ;
    
    //size
    float objWidth =  sizeXObj[IDobj] *mix[IDobj] ;
    float objHeight =  sizeYObj[IDobj] *.1f *mix[IDobj] ;
    PVector size = new PVector(objWidth *10, objHeight *10) ;
    
    //thickness / \u00e9paisseur
    float e = thicknessObj[IDobj] *mix[IDobj] ;

    int colorIn = fillObj[IDobj] ;
    int colorOut = strokeObj[IDobj] ;
    
    //surface
    PVector surface = new PVector(canvasXObj[IDobj], canvasYObj[IDobj], canvasZObj[IDobj])  ;
    
    /////////
    //UPDATE
    updateGrain(upTouch, downTouch, leftTouch, rightTouch, clickLongLeft[IDobj], surface);
    
    //////////////
    //DISPLAY MODE
    if (mode[IDobj] == 0 || mode[IDobj] == 255 ) {
      pointSable(objWidth, colorIn) ;
    } else if (mode[IDobj] == 1 ) {
      ellipseSable(size,e , colorIn, colorOut) ;
    } else if (mode[IDobj] == 2 ) {
      rectSable(size,e , colorIn, colorOut) ;
    } else {
      pointSable(objWidth, colorIn) ;
    }
  }
    
    
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
  //
  public void rectSable(PVector size, float e, int cIn, int cOut) {
    for(int j = 0; j < grain.length; j++) {
      strokeWeight(e) ;
      stroke(cOut) ;
      fill(cIn) ;
      rect(grain[j].x, grain[j].y, size.x, size.y);
      //set(int(grain[j].x), int(grain[j].y), colorIn);
    }
  }
  
  //SETUP
  public void grainSetup( int num) {
    grain = new PVector [num] ;
    for(int i = 0; i < num ; i++) {
      grain[i] = new PVector (random(width), random(height)) ;
    }
    makeSand = true ;
  }
    
    
  //void update  
  public void updateGrain(boolean up, boolean down, boolean leftSide, boolean rightSide, boolean mouseClic, PVector area) {
    
    for(int i = 0; i < grain.length; i++) {
      newRayonGrain = newRayonGrain -variableRayonGrain ;
      
      motionGrain.x = grain[i].x -posCenterGrain.x -(deformationGrain.x +right[IDobj])  ;
      motionGrain.y = grain[i].y -posCenterGrain.y -(deformationGrain.y +left[IDobj] ) ;
  
      PVector posGrain = new PVector ( 0,0, 0) ;
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
class Escargot extends SuperRomanesco {
  public Escargot() {
    //from the index_objects.csv
    romanescoName = "Escargot" ;
    IDobj = 16 ;
    IDgroup = 2 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Alpha 2.1";
    romanescoPack = "Base" ;
    romanescoRender = "P3D" ;
    romanescoMode = "1 Original/2 Raw/3 Point/4 Ellipse/5 Rectangle/6 Box/7 Cross/8 SVG/9 Vitraux" ;
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
  int strokeColor  ; // color for the stroke
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
  int maxVoronoiPoints = 500 ; // max point for voronoi calcula bahond is very very slow
  
  String modeTri = ("b") ; // you can choice in few mode "hsb"(exact same hue, saturation and brithness the other mode is part of this three composantes, "b", "s", "hs", "hb", "sb"
  boolean useNewPalettePixColorToAnalyze = true ; // choice the color you analyze, the raw color you must write "FALSE" if you look in the "newColor" because you have change the color pixel for anything you must write "TRUE", best analyze with the new palette
  
  
  //PALETTE COLOR
  //random palette
  PVector HSBpalette = new PVector (6, 6, 12) ;  // quantity for eaches components of palette in HSB order // need "1" minimum in each componante
  //palette from you
  int hueColor[] =    new int [(int)HSBpalette.x] ;
  int satColor[] =    new int [(int)HSBpalette.y] ;
  int brightColor[] = new int [(int)HSBpalette.z] ;
  //spectrum for the color mode and more if you need
  PVector HSBmode = new PVector (360,100,100) ; // give the color mode in HSB
  
  //MOTION POSITION
  //Wind force, direction
  int windDirection = 25; //direction between 1 and 360
  int windForce = 3 ; //use the natural code of the wind 0 to 9 is good
  int objMotion = 1 ; //motion of the pixel is under influence of the wind, if the wind is strong the pixel motion become low
  PVector motionInfo = new PVector(windDirection, windForce, objMotion)  ;
  //ratio for the image, say if the picture must be adapted to the size window or not
  boolean ratioImg ;
  
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
  
  
  //SETUP
  public void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
    //load pattern SVG to display a Pixel pattern you create in Illustrator or other software
    pathSVG = sketchPath("")+"preferences/pixel/model.svg" ;
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
    //setting voronoi
    voronoiToxicSetup() ;
  }
  
  
  
  
  //DRAW
  public void display() {
    //MOTION
    windForce = (int)map(speedObj[IDobj],0,100,0,13) ;
    windDirection = (int)directionObj[IDobj] ;
    objMotion = PApplet.parseInt(map(forceObj[IDobj],0,100, 0,20) *(1.0f + pen[IDobj].z)) ;
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
     
     if (!motion[IDobj]) for( Pixel p : listEscargot) {
       p.updatePosPixel(motionInfo, img) ;
     }
    ////////////////
    
    
    //ANALYZE
    //change the size of pixel ref for analyzing
    if (pixelAnalyzeSize != pixelAnalyzeSizeRef || radiusAnalyze != radiusAnalyzeRef || maxEntryPoints != maxEntryPointsRef  ) reInitilisationAnalyze() ;

    pixelAnalyzeSizeRef = pixelAnalyzeSize;
    radiusAnalyzeRef = radiusAnalyze ;
    maxEntryPointsRef = maxEntryPoints ;
    
    int n = PApplet.parseInt(map(quantityObj[IDobj],0,100,4,50)) ;
    //maxEntryPoints = int(map(valueObj[IDobj][14],0,100,1,50)) *int(map(valueObj[IDobj][14],0,100,1,50)) *int(map(valueObj[IDobj][14],0,100,1,50)) ;
    maxEntryPoints = n *n *n ;
    //if (maxEntryPoints > listPixelRaw.size() / 4 ) maxEntryPoints = listPixelRaw.size() ;

    radiusAnalyze = PApplet.parseInt(map(amplitudeObj[IDobj],0,100,2,100));
    pixelAnalyzeSize = PApplet.parseInt(map(analyzeObj[IDobj],0,100,2,30));
    

    
     //security for the droping img from external folder
     if(parameter[IDobj] && rTouch ) ratioImg = !ratioImg ;
     if( img != null && img.width > 3 && ratioImg ) {
       analyzeImg(pixelAnalyzeSize) ;
       ratioImgWindow = new PVector ((float)width / (float)img.width , (float)height / (float)img.height ) ;
     } else if (img != null && img.width > 3 && !ratioImg) {
       analyzeImg(pixelAnalyzeSize) ;
       ratioImgWindow = new PVector(1,1) ;
     } else {
       ratioImgWindow = new PVector(1,1) ;
     }
       
     
     //size and thickness
     PVector sizePix = new PVector (map(sizeXObj[IDobj],0,width, 1, 50 ), map(sizeYObj[IDobj],0,height, 1, 50 ), map(sizeZObj[IDobj],0,width, 1, 50 )) ;

     float thickPix = map(thicknessObj[IDobj],0,height *.33f, 1, 50 ) ;
     //PVector infoSizePix = new PVector(widthPix,heightPix, thickPix) ;
     //modify the size
     // float factorSizePix ;
     
     // range 100
     float soundHundredMin = random(80) ;
     float soundHundredMax = random(soundHundredMin, soundHundredMin +20) ;
     PVector rangeReactivitySoundHundred = new PVector (soundHundredMin, soundHundredMax) ;
     //range 360
     float soundThreeHundredSixtyMin = random(330) ;
     float soundThreeHundredSixtyMax = random(soundThreeHundredSixtyMin, soundThreeHundredSixtyMin +30) ;
     PVector rangeReactivitySoundThreeHundredSixty = new PVector (soundThreeHundredSixtyMin, soundThreeHundredSixtyMax) ;
     //Music factor
     PVector musicFactor = new PVector (kick[IDobj] *.2f, snare[IDobj]*.2f, beat[IDobj]*.2f) ; // hsb reactivity, the first PVector is for the hue, the second for the saturation, the third for the brightness
     
     //opacity
     int opacityShapeIn =  (int)alpha(fillObj[IDobj]) ;
     int opacityShapeOut = (int)alpha(strokeObj[IDobj]) ;
     
     //open new image for the background
    if ( parameter[IDobj] && oTouch ) {
      //step 1 clear the list for new analyze
      selectInput("Select jpg picture", "choiceImg");
      //this void is connected with the void in the main DRAW TAB (keypressed() key == 'o' selectInput("Choisissez une belle image", "choiceImg");
      escargotGOanalyze = false ;
      escargotClear() ;
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
    if(img != null) translate((width*.5f)-(img.width *.5f) ,(height *.5f)-(img.height *.5f),0) ;
    if (mode[IDobj] == 0 || mode[IDobj] == 255 ) {
      displayRawPixel(thickPix, opacityShapeIn, rangeReactivitySoundHundred, rangeReactivitySoundThreeHundredSixty, musicFactor, ratioImgWindow) ;
    } else if (mode[IDobj] == 1 ) {
      escargotRaw(thickPix, opacityShapeIn, rangeReactivitySoundHundred, rangeReactivitySoundThreeHundredSixty, musicFactor, ratioImgWindow) ;
    } else if (mode[IDobj] == 2 ) {
      escargotPoint(thickPix, opacityShapeIn, rangeReactivitySoundHundred, rangeReactivitySoundThreeHundredSixty, musicFactor, ratioImgWindow) ;
    } else if (mode[IDobj] == 3 ) {
      escargotEllipse(sizePix, thickPix, opacityShapeIn, opacityShapeOut, rangeReactivitySoundHundred, rangeReactivitySoundThreeHundredSixty, musicFactor, ratioImgWindow ) ;
    } else if (mode[IDobj] == 4 ) {
      escargotRect(sizePix, thickPix, opacityShapeIn, opacityShapeOut, rangeReactivitySoundHundred, rangeReactivitySoundThreeHundredSixty, musicFactor, ratioImgWindow ) ;
    }else if (mode[IDobj] == 5 ) {
      escargotBox(sizePix, thickPix, opacityShapeIn, opacityShapeOut, rangeReactivitySoundHundred, rangeReactivitySoundThreeHundredSixty, musicFactor, ratioImgWindow, horizon[IDobj] ) ;
    } else if (mode[IDobj] == 6 ) {
      escargotCross(sizePix, thickPix, opacityShapeIn, rangeReactivitySoundHundred, rangeReactivitySoundThreeHundredSixty, musicFactor, ratioImgWindow ) ;
    } else if (mode[IDobj] == 7 ) {
      escargotSVG(sizePix, thickPix, opacityShapeIn, opacityShapeOut, rangeReactivitySoundHundred, rangeReactivitySoundThreeHundredSixty, musicFactor, ratioImgWindow) ;
    } else if (mode[IDobj] == 8 ) {
      if( listEscargot.size() < maxVoronoiPoints) voronoiStatic(strokeColor, thickness, useNewPalettePixColorToDisplay) ; else text("Trop de point a afficher", 20, height - 20 ) ;
    }

  }
  
  
  
  //ANNEXE VOID
  public void displayRawPixel(float sizeP, int opacity, PVector rangeHundred, PVector rangeThreeHundredSixty, PVector musicFactor, PVector ratio) {
    // we must create a PVector because i'm lazy to creat an other void beatReactivity for one float
    PVector sizePixCtrl = new PVector (0,0,sizeP) ;
    
    for ( Pixel p : listPixelRaw ) {
      //display
      stroke(p.c, opacity) ;
      if(soundButton[IDobj] == 1 ) strokeWeight(beatReactivityHSB(sizePixCtrl, p.size, p.c, rangeThreeHundredSixty, rangeHundred, musicFactor ).z) ; else strokeWeight(sizeP) ;
      point(p.pos.x *ratio.x, p.pos.y *ratio.y) ;
    }
  }
  
  
  
  //Display which point is use to caluculate the barycenter
  public void escargotRaw(float sizeP, int opacity, PVector rangeHundred, PVector rangeThreeHundredSixty, PVector musicFactor, PVector ratio) {
    int c ;
    // we must create a PVector because i'm lazy to creat an other void beatReactivity for one float
    PVector sizePixCtrl = new PVector (0,0,sizeP) ;
    
    for ( Pixel p : listPixelRaw ) {
      if (p.ID == 1 ) {
        //color
        if ( colorPixDisplay ) c = p.newColor ; else c = p.c ;
        
        //display
        stroke(c, opacity) ;
        strokeWeight(beatReactivityHSB(sizePixCtrl, p.size, c, rangeThreeHundredSixty, rangeHundred, musicFactor ).z) ;
        point(p.pos.x *ratio.x, p.pos.y *ratio.y) ;
      }
    }
  }


  //Display Barycenter
  public void escargotPoint(float sizeP, int opacity, PVector rangeHundred, PVector rangeThreeHundredSixty, PVector musicFactor, PVector ratio) {
    int c ;
    // we must create a PVector because i'm lazy to creat an other void beatReactivity for one float
    PVector sizePixCtrl = new PVector (0,0,sizeP) ;

    for ( Pixel p : listEscargot ) {
      //check if we must display original color or the new palette
      int x = (int)p.pos.x ; int y = (int)p.pos.y ;
      if ( colorPixDisplay ) c = p.newColor ; else c = get(x , y) ;
  
      p.changeHue   (huePalette,     hueStart,    hueEnd) ;
      p.changeSat   (satPalette,     satStart,    satEnd) ; 
      p.changeBright(brightPalette,  brightStart, brightEnd) ;
      // update the color after change each componante
      p.updatePalette() ;
      
      stroke(c, opacity) ;
      if(soundButton[IDobj] == 1 ) strokeWeight(beatReactivityHSB(sizePixCtrl, p.size, p.c, rangeThreeHundredSixty, rangeHundred, musicFactor ).z) ; else strokeWeight(sizeP) ;
      point(p.pos.x *ratio.x, p.pos.y *ratio.y) ; 
    }
  }
  
  
  
  
  
  //ELLIPSE
  public void escargotEllipse(PVector size, float thickness, int opacityIn, int opacityOut, PVector rangeHundred, PVector rangeThreeHundredSixty, PVector musicFactor, PVector ratio) {
    int c ;
    //PVector newSize = new PVector (sizePix.x, sizePix.y, sizePix.z) ;   ;
   // float newStrokeWeight = sizePix.z   ;
   
    for ( Pixel p : listEscargot ) {
      
      if ( colorPixDisplay ) c = p.newColor ; else c = p.c ;
      p.changeHue   (huePalette,     hueStart,    hueEnd) ;
      p.changeSat   (satPalette,     satStart,    satEnd) ; 
      p.changeBright(brightPalette,  brightStart, brightEnd) ;
      // update the color after change each componante
      p.updatePalette() ; 

      //music influence on the opacity
      // A RETRAVAILLER
      
      //display
      if (opacityIn != 0) fill(c, opacityIn) ; else noFill() ;
      
      if (opacityOut != 0) {
        stroke(c, opacityOut) ; 
        strokeWeight(thickness ) ;
      } else { 
        noStroke() ;
      } 
      ellipse(p.pos.x *ratio.x,  p.pos.y *ratio.y,    beatReactivityHSB(size, p.size, c, rangeThreeHundredSixty, rangeHundred, musicFactor ).x,       beatReactivityHSB(size, p.size, c, rangeThreeHundredSixty, rangeHundred, musicFactor ).y) ; 
    }
  }
  

  
  
  
  
  //RECT
  public void escargotRect(PVector size, float thickness, int opacityIn, int opacityOut, PVector rangeHundred, PVector rangeThreeHundredSixty, PVector musicFactor, PVector ratio) {
    int c ;
    // PVector newSize = new PVector (sizePix.x *.01, sizePix.y *.01) ;   ;
    // float newStrokeWeight = sizePix.z   ;
    
    for ( Pixel p : listEscargot ) {
      
      if ( colorPixDisplay ) c = p.newColor ; else c = p.c ;
      p.changeHue   (huePalette,     hueStart,    hueEnd) ;
      p.changeSat   (satPalette,     satStart,    satEnd) ; 
      p.changeBright(brightPalette,  brightStart, brightEnd) ;
      // update the color after change each componante
      p.updatePalette() ; 
     
     //music influence on the opacity
      
      //display
      if (opacityIn != 0) fill(c, opacityIn) ; else noFill() ;
      if (opacityOut != 0) {
        stroke(c, opacityOut) ; 
        strokeWeight(thickness) ;
      } else { 
        noStroke() ;
      }
      //recalculate the pose  to scale with coordonate in the middle of the shape ( like(RectMode(CENTER) )
      float sizeX = beatReactivityHSB(size, p.size, c,rangeThreeHundredSixty, rangeHundred, musicFactor ).x ;
      float sizeY = beatReactivityHSB(size, p.size, c,rangeThreeHundredSixty, rangeHundred, musicFactor ).y ; 
      rect((p.pos.x - (sizeX *.5f)) *ratio.x, (p.pos.y - (sizeY *.5f)) *ratio.y, sizeX , sizeY) ; 
    }
  }
  
  
  //RECT
  public void escargotBox(PVector size, float thickness, int opacityIn, int opacityOut, PVector rangeHundred, PVector rangeThreeHundredSixty, PVector musicFactor, PVector ratio, boolean alignement) {
    int c ;
    // PVector newSize = new PVector (sizePix.x *.01, sizePix.y *.01) ;   ;
    // float newStrokeWeight = sizePix.z   ;
    
    for ( Pixel p : listEscargot ) {
      
      if ( colorPixDisplay ) c = p.newColor ; else c = p.c ;
      p.changeHue   (huePalette,     hueStart,    hueEnd) ;
      p.changeSat   (satPalette,     satStart,    satEnd) ; 
      p.changeBright(brightPalette,  brightStart, brightEnd) ;
      // update the color after change each componante
      p.updatePalette() ; 
     
     //music influence on the opacity
      
      //display
      if (opacityIn != 0) fill(c, opacityIn) ; else noFill() ;
      if (opacityOut != 0) {
        stroke(c, opacityOut) ; 
        strokeWeight(thickness) ;
      } else { 
        noStroke() ;
      }
      //recalculate the pose  to scale with coordonate in the middle of the shape ( like(RectMode(CENTER) )
      float sizeX = beatReactivityHSB(size, p.size, c,rangeThreeHundredSixty, rangeHundred, musicFactor ).x ;
      float sizeY = beatReactivityHSB(size, p.size, c,rangeThreeHundredSixty, rangeHundred, musicFactor ).y ;
      float sizeZ = beatReactivityHSB(size, p.size, c,rangeThreeHundredSixty, rangeHundred, musicFactor ).z *brightness(c) ;
      pushMatrix() ;
      // translate( (p.pos.x - (sizeX *.5)) *ratio.x, (p.pos.y - (sizeY *.5)) *ratio.y, 0 ) ;
      
      if (!alignement) {
        //translate(pos.x, pos.y, pos.z) ; 
        translate( p.pos.x *ratio.x, p.pos.y *ratio.y, 0 ) ;
      } else {
        float horizon = sizeZ *.5f ;
        translate(p.pos.x *ratio.x, p.pos.y *ratio.y, horizon) ;
        //translate( p.pos.x *ratio.x, p.pos.y *ratio.y, 0 ) ;
      }
      
      box(sizeX , sizeY, sizeZ ) ; 
      popMatrix() ;
    }
  }
  
  
  //CROSS
  public void escargotCross(PVector size, float thickness, int opacity, PVector rangeHundred, PVector rangeThreeHundredSixty, PVector musicFactor, PVector ratio) {
    int c ; 
    PVector newSize = new PVector (size.x, size.y) ;
    // float newStrokeWeight = sizePix.z   ;
    
    for ( Pixel p : listEscargot ) {
      
      if ( colorPixDisplay ) c = p.newColor ; else c = p.c ;
      p.changeHue   (huePalette,     hueStart,    hueEnd) ;
      p.changeSat   (satPalette,     satStart,    satEnd) ; 
      p.changeBright(brightPalette,  brightStart, brightEnd) ;
      // update the color after change each componante
      p.updatePalette() ;
      
      //music influence on the opacity
      //A TRAVAILLER
  
      int newC = color(c, opacity) ;
     //  void crossPoint(PVector pos, PVector size, color colorCross, float e, )
     PVector pos = new PVector(p.pos.x *ratio.x, p.pos.y *ratio.y) ;
      crossPoint(pos, newSize, newC, thickness) ;
    }
  }
  
  
  
  /////////////
  //display SVG shave like pixel
  public void escargotSVG(PVector size, float thickness, int opacityIn, int opacityOut, PVector rangeHundred, PVector rangeThreeHundredSixty, PVector musicFactor, PVector ratio) {
    int c ;
    // PVector newSize = new PVector (sizePix.x, sizePix.y, sizePix.y) ;
    
    for ( Pixel p : listEscargot ) { 
      //check if we must display original color or the new palette
      int x = (int)p.pos.x ; int y = (int)p.pos.y ;
      if ( colorPixDisplay ) c = p.newColor ; else c = get(x , y) ;
      
      p.changeHue   (huePalette,     hueStart,    hueEnd) ;
      p.changeSat   (satPalette,     satStart,    satEnd) ; 
      p.changeBright(brightPalette,  brightStart, brightEnd) ;
      // update the color after change each componante
      p.updatePalette() ; 
      
      //music influence on the opacity
      //A TRAVAILLER
     
      
      //display
      if (opacityIn != 0) fill(c, opacityIn) ; else noFill() ;
      if (opacityOut != 0) {
        stroke(c, opacityOut) ; 
        strokeWeight(thickness) ;
      } else { 
        noStroke() ;
      }
      //recalculate the pose  to scale with coordonate in the middle of the shape ( like(RectMode(CENTER) ) 
      float sizeSVG =  .01f *p.size.x *size.x ;
      PVector newPos = new PVector ( p.pos.x - (50 *sizeSVG *.5f) *ratio.x ,p.pos.y - (50 *sizeSVG *.5f) *ratio.y) ;
  
      //PVector newPos = new PVector ( p.pos.x -(p.size.x *float(sizePix)  *.05), p.pos.y - (p.size.y *float(sizePix)  *.05) ) ;
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
  
  public void voronoiStatic(int stroke, int e, boolean whichColor) {
    whichColorVoronoi = whichColor ;
    thicknessVoronoi = e ;
    colorStrokeVoronoi = stroke ;
  
  
    for ( Pixel b : listEscargot) {
      //security against the NaN result
      if ( Float.isNaN(b.pos.x) ) ; else voronoi.addPoint(new Vec2D(b.pos.x, b.pos.y));
    }
  
    for (Polygon2D poly : voronoi.getRegions() ) {
      //to recalculate the position in the arraylist
      PVector findPosFromVoronoi = new PVector (0,0) ;
      for ( Vec2D v : voronoi.getSites() ) {
        if ( poly.containsPoint( v ) ) {
          //position in grid
          findPosFromVoronoi.x = PApplet.parseInt(v.x /pixelAnalyzeSize) ;
          findPosFromVoronoi.y = PApplet.parseInt(v.y /pixelAnalyzeSize) ;
          if(findPosFromVoronoi.x > cols -1 ) findPosFromVoronoi.x = cols -1 ;
          if(findPosFromVoronoi.y > rows -1 ) findPosFromVoronoi.y = rows -1 ;
          int posInList = ((int)findPosFromVoronoi.x  * rows ) + (int)findPosFromVoronoi.y ; 
          
          //look the color in the list
          Pixel p = (Pixel) listPixelRaw.get(posInList) ;
          if ( whichColorVoronoi ) {
            //change the color with the new palette
            p.changeHue   (huePalette,     hueStart,    hueEnd) ;
            p.changeSat   (satPalette,     satStart,    satEnd) ; 
            p.changeBright(brightPalette,  brightStart, brightEnd) ;
            // update the color after change each componante
            p.updatePalette() ; 
            fill(p.newColor) ;
          } else {
            //original color of the pix
            fill(p.c) ;
          }
          if(thicknessVoronoi == 0 ) { 
            noStroke() ; 
          } else { 
            stroke(colorStrokeVoronoi) ;
            strokeWeight(thicknessVoronoi) ;
          }
          gfx.polygon2D(poly);
        }
      }
    }
    //clear voronoi list
    voronoi = new Voronoi();
  }
  
  
  public void voronoiMotion(PVector motion) {
    //security
    for ( Pixel b : listEscargot) {
      //security against the NaN result
      if ( Float.isNaN(b.pos.x) ) {
        PVector pos = b.posPixel(motion, img);
        voronoi.addPoint(new Vec2D(pos.x, pos.y));
      }
    }
  
    for (Polygon2D poly : voronoi.getRegions() ) {
      //to recalculate the position in the arraylist
      PVector findPosFromVoronoi = new PVector (0,0) ;
      for ( Vec2D v : voronoi.getSites() ) {
        if ( poly.containsPoint( v ) ) {
          //position in grid
          findPosFromVoronoi.x = PApplet.parseInt(v.x /pixelAnalyzeSize) ;
          findPosFromVoronoi.y = PApplet.parseInt(v.y /pixelAnalyzeSize) ;
          if(findPosFromVoronoi.x > cols -1 ) findPosFromVoronoi.x = cols -1 ;
          if(findPosFromVoronoi.y > rows -1 ) findPosFromVoronoi.y = rows -1 ;
          int posInList = ((int)findPosFromVoronoi.x  * rows ) + (int)findPosFromVoronoi.y ; 
          
          //look the color in the list
          Pixel p = (Pixel) listPixelRaw.get(posInList) ;
          if ( whichColorVoronoi ) {
            //change the color with the new palette
            p.changeHue   (huePalette,     hueStart,    hueEnd) ;
            p.changeSat   (satPalette,     satStart,    satEnd) ; 
            p.changeBright(brightPalette,  brightStart, brightEnd) ;
            // update the color after change each componante
            p.updatePalette() ; 
            fill(p.newColor) ;
          } else {
            //original color of the pix
            fill(p.c) ;
          }
          if(thicknessVoronoi == 0 ) { 
            noStroke() ; 
          } else { 
            stroke(colorStrokeVoronoi) ;
            strokeWeight(thicknessVoronoi) ;
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
    PVector newSize = new PVector (sizeFromControleur.x, sizeFromControleur.y, sizeFromControleur.z) ;
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
    //step 1
    /* 
    clear the list for new analyze
    here we don't use because we clear when we call the new image by the keyboard
    */
    //escargotClear() ;
    
    // put in this void the size of pixel you want, to create grid analyzing and image than you want analyze
    colorAnalyzeSetting(sizePixForAnalyze, img) ;
    
    //step 2
    //three componants : FIRST : size of the pixel grid // SECOND which PImage // THIRD mirror "FALSE" or "TRUE"
    recordPixelRaw(sizePixForAnalyze, img, false) ; 
    
    //step 3
    // give the list point of Pixel must be change with the new palette
    changeColorOfPixel(listPixelRaw) ; 
    
    //step 4
    //escargot analyze of the arraylist create by the void recordPixelRaw
    
   if ( escargotGOanalyze && listEscargot.size() < maxEntryPoints ) {
      //security to make sure the speed is not higher to the max entry points
      if ( speedAnalyze > maxEntryPoints / 10 ) speedAnalyze = maxEntryPoints / 10 ;
      for (int i = 0 ; i < speedAnalyze ; i++ ) {
        int whichPointInTheList  = (int)random(listPixelRaw.size()) ;
        //void without control for escargot analyze
        //escargotAnalyze(whichPointInTheList, radiusAnalyze, modeTri, useNewPalettePixColorToAnalyze ) ;
        
        //void with control for escargot analyze, the last componant is a boolean control
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
      if ( !whichColor ) colorRef = pixelRef.c ; else colorRef = pixelRef.newColor ;
      
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
      if ( !whichColor ) colorRef = pixelRef.c ; else colorRef = pixelRef.newColor ;
      
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
  listEscargot.add(new Pixel(barycenterEscargot, cRef, sizeBarycenter)); 
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
  if( !whichPix ) wichColorCheck = pixelEscargotAnalyze.c ; else wichColorCheck = pixelEscargotAnalyze.newColor ;
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
  if( !whichPix ) wichColorCheck = pixelEscargotAnalyze.c ; else wichColorCheck = pixelEscargotAnalyze.newColor ;
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
  if( !whichPix ) wichColorCheck = pixelEscargotAnalyze.c ; else wichColorCheck = pixelEscargotAnalyze.newColor ;
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
  if( !whichPix ) wichColorCheck = pixelEscargotAnalyze.c ; else wichColorCheck = pixelEscargotAnalyze.newColor ;
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
  if( !whichPix ) wichColorCheck = pixelEscargotAnalyze.c ; else wichColorCheck = pixelEscargotAnalyze.newColor ;
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
  if( !whichPix ) wichColorCheck = pixelEscargotAnalyze.c ; else wichColorCheck = pixelEscargotAnalyze.newColor ;
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
  if( !whichPix ) wichColorCheck = pixelEscargotAnalyze.c ; else wichColorCheck = pixelEscargotAnalyze.newColor ;
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
public void drawBezierVertex(ArrayList<PVector> list, ArrayList<PVector> shapes)
{
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
public void drawBezierVertex(PVector pos, float scale, ArrayList<PVector> list, ArrayList<PVector> shapes)
{
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










//LOAD IMAGE AND PATTERN
//SVG PATTERN
String pathSVGescargot ;
//load image
public void choiceImg(File selection) {
  if (selection == null) {
    println("no file selected");
  } else {
    pathImg  = selection.getAbsolutePath() ;
    img = loadImage(pathImg) ;
    analyzeDone = false ;
  }
}

//load SVG
public void choiceSVG(File selection) {
  if (selection == null) {
    println("no pattern selected");
  } else {
    pathSVGescargot  = selection.getAbsolutePath() ;
    shapeSVGsetting(pathSVGescargot) ;

  }
}

/*
// drop event
void dropEvent(DropEvent theDropEvent) {
  // if the dropped object is an image, then load the image into our PImage.
  if(theDropEvent.isImage()) {
      escargotGOanalyze = false ;
      escargotClear() ;

    img = theDropEvent.loadImage();
    analyzeDone = false ;
  }
}
//end drop event
*/


/*
void truc() {
  if(object[IDobj] ) { 
    text( "Info Escargot " + totalPixCheckedInTheEscargot + " Pixels analyz " +  " on " + listPixelRaw.size() + "    Escargots " + listEscargot.size() , 15, 15 * (posInfoObj) ) ;  posInfoObj += 1 ; 
  } else { 
    text("No image thred", 15, 15 *(posInfoObj) ) ;
    posInfoObj += 1 ;
  }
}
*/
class Letter extends SuperRomanesco {
  public Letter() {
    //from the index_objects.csv
    romanescoName = "Letter" ;
    IDobj = 17 ;
    IDgroup = 3 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Alpha 1.1";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
  }
  //GLOBAL
  RFont f;
  RShape grp;
  boolean newSetting ;
  int sizeRef ;
  String sentenceRef = ("") ; 
  String pathRef = ("") ;
 
  int whichLetter ;
  //spped
  float speed ;
  
  //SETUP
  public void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
  }
  
  
  
  
  //DRAW
  public void display() {
    if (parameter[IDobj] || pathFontObjTTF[IDobj] == null ) { 
      font[IDobj] = font[0] ;
      pathFontObjTTF[IDobj] = pathFontObjTTF[0] ;
    }
    //init and re-init Geomerative if few stuff change about this line like text, font and the size of the font
    int sizeFont = PApplet.parseInt(map(sizeYObj[IDobj],0,height,height/50, height *2)) ;
    
    
    //tracking chapter
    String textChapters [] = split(textRaw, "*") ;
    //we use in this case the tittle of the text
    String sentence = textChapters [0] ;

    
    //check if something change to update the RG.getText
    if (sizeRef == sizeFont && sentenceRef.equals(sentence) && pathRef.equals(pathFontObjTTF[IDobj])) newSetting = true  ; else newSetting = false ;
    sizeRef = sizeFont ;
    sentenceRef = (sentence) ;
    pathRef = (pathFontObjTTF[IDobj]) ;

    if(!newSetting) { 
      grp = RG.getText(sentence, pathFontObjTTF[IDobj], sizeFont, CENTER); 
      newSetting = true ;
    }
    
    
    /////////
    //ENGINE
    float rangeTargetLetter = height / grp.countChildren() ;
    int targetLetter = floor((mouse[IDobj].y +width/2) / rangeTargetLetter) ;
    if(targetLetter >= grp.countChildren() )targetLetter = targetLetter -1 ; 
    //speed
    if(motion[IDobj]) speed = map(speedObj[IDobj], 0,100, 0.001f, 0.01f ) * tempo[IDobj]  ; else speed = 0.0f ;
    //to stop the move
    if (action[IDobj]  && spaceTouch ) speed = 0.0f ; 
    if(mousepressed[0]) speed = -speed ;
    
    //DISPLAY
    float thicknessLetter = thicknessObj[IDobj] ;
    //color
    int colorIn = fillObj[IDobj] ;
    // color colorOut = color ( map(valueObj[IDobj][5],0,100,0,360), valueObj[IDobj][6], valueObj[IDobj][7],valueObj[IDobj][8] ) ;
    //jitter
    int jitter = PApplet.parseInt(map(amplitudeObj[IDobj],0,100,1,15)) ;
    
    //final position
    translate(mouse[IDobj].x, mouse[IDobj].y) ;
    
    fill(colorIn); noStroke() ;
    //grp.children[whichLetter].draw();
    //grp.draw();

    oneLetter(speed, targetLetter, colorIn, thicknessLetter, jitter) ;
    //END YOUR WORK
    
    // MODE DISPLAY with the dropdown menu of controler
    /////////////////////
    if (mode[IDobj] == 0 || mode[IDobj] == 255 ) {
      //// just for information we use 0 to display the mode 1...same for the next mode +1...
    } else if (mode[IDobj] == 1 ) {
    } else if (mode[IDobj] == 2 ) {
    // and same for the next
    }

  }
  
  
  // ANNEXE
    public void oneLetter(float s, int target, int cIn, float t, int jttr) {
    //create a PVector arraylist from geomerative analyze
    // float rangeWhichLetter = width / grp.countChildren() ;
    if (action[IDobj] && spaceTouch) whichLetter += (wheel[0] *.1f) ;
    //security against the array out bounds
    if(whichLetter < 0 ) whichLetter = 0 ; else if (whichLetter >= grp.countChildren()) whichLetter = grp.countChildren() - 1 ;
    if(target < 0 ) target = 0 ; else if (target >= grp.countChildren()) target = grp.countChildren() - 1 ;
    //position
    if(motion[IDobj]) grp.children[whichLetter].rotate(s, grp.children[target].getCenter());
    
    displayLetter(whichLetter, cIn, t, jttr) ;
    displayLetter(target, cIn, t, jttr) ;
  }
  
  public void displayLetter(int which, int c, float alpha, int ampJttr) {
    RPoint[] pnts = grp.children[which].getPoints() ; 
    PVector [] points = geomerativeFontPoints(pnts)  ;
    noFill() ; stroke(c) ; strokeWeight(alpha) ;
    for ( int i = 1; i < points.length; i++ ) {
      //points[i].add(jitterPVector(ampJttr)) ;
      if(points[i].z <= 0) points[i].z = points[i].z *right[IDobj] *20 ; else points[i].z = points[i].z *left[IDobj] *20 ;
      // if(points[i].z <= 0) points[i-1].z *= droite[IDobj] ; else points[i-1].z *= gauche[IDobj] ;
      line( points[i-1].x, points[i-1].y, points[i-1].z,   points[i].x, points[i].y, points[i].z );
    }
  }
  
  //ANNEXE VOID
  public void annexe() {}
  //jitter for PVector points
  public PVector jitterPVector(int range) {
    PVector jitting = new PVector(0,0,0) ;
    jitting.x = random(-range, range) ;
    jitting.y = random(-range, range) ;
    jitting.z = random(-range, range) ;
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
class Horloge extends SuperRomanesco {
  public Horloge() {
    //from the index_objects.csv
    romanescoName = "A CERCLE" ;
    IDobj = 18 ;
    IDgroup = 3 ;
    romanescoAuthor  = "Stan Le Punk";
    romanescoVersion = "Alpha 2.0";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
    romanescoMode = "1 Ellipse Clock 12/2 Ellipse Clock 24/3 Line Clock 12/4 Line Clock 24/5 minutes/6 secondes" ;// separate the name by a slash and write the next mode immadialtly after this one.
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
    float corps ;
    //size letter / corps
    corps = map(sizeYObj[IDobj], 0, height, 6, 2 *height) ;
    textFont(font[IDobj], corps + (mix[IDobj] *30));
    
    // couleur du texte
    float t = alpha(fillObj[IDobj]) * abs(mix[IDobj]) ;
    if ( sound[IDobj] ) { t = alpha(fillObj[IDobj]) ; } 
    int c = color(hue(fillObj[IDobj]), saturation(fillObj[IDobj]), brightness(fillObj[IDobj]), t ) ;
    //rotation / deg
    float angle = map(directionObj[IDobj], 0,360, 0, TAU) ;
    //amplitude
    float amp = map(amplitudeObj[IDobj],0,height,0, width *.75f) ;
    
    //CHANGE MODE DISPLAY
    /////////////////////
    if (mode[IDobj] == 0 || mode[IDobj] == 255 ) {
      horlogeCercle (mouse[IDobj], angle, amp, c, 12 ) ; // on 12 hours model english clock
    } else if (mode[IDobj] == 1 ) {
      horlogeCercle (mouse[IDobj], angle,  amp, c, 24 ) ; // on 24 hours model international clock
    } else if (mode[IDobj] == 2 ) {
      horlogeLigne  (mouse[IDobj], angle, amp, c, 12 ) ; // on 12 hours model english clock
    } else if (mode[IDobj] == 3 ) {
      horlogeLigne  (mouse[IDobj], angle, amp, c, 24 ) ; // on 24 hours model international clock
    } else if (mode[IDobj] == 4 ) {
      horlogeMinute(mouse[IDobj], angle, c) ;
    } else if (mode[IDobj] == 5 ) {
      horlogeSeconde(mouse[IDobj], angle, c) ;
    }

  }
  
  
  //ANNEXE
  public void horlogeCercle(PVector posHorloge, float angle, float  amp, int colorHorloge, int timeMode) {
    //Angles pour sin() et cos() d\u00e9part \u00e0 3h, enlever PI/2 pour un d\u00e9part \u00e0 midi
    float s = map (second(), 0, 60, 0,    TWO_PI ) - HALF_PI ;
    float m = map (minute(), 0, 60, 0,    TWO_PI ) - HALF_PI ;
    float h = map (hour() % 12, 0, 12, 0, TWO_PI ) - HALF_PI ;
    
    fill (colorHorloge) ;
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
  public void horlogeLigne(PVector posHorloge, float angle, float amp, int colorHorloge, int timeMode) {
    fill (colorHorloge) ;
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
  public void horlogeMinute(PVector posHorloge, float angle, int colorHorloge ) {
    fill (colorHorloge) ;
    textAlign(CENTER, CENTER) ;
    translate(posHorloge.x, posHorloge.y) ;
    rotate(angle) ;
    text(hour() *60 + minute() + " MINUTES", 0,0) ;
    textAlign(LEFT, TOP) ;
  }
  
  ////
  public void horlogeSeconde(PVector posHorloge, float angle, int colorHorloge ) {
    
    fill (colorHorloge) ;
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
class RSS extends SuperRomanesco {
  public RSS() {
    //from the index_objects.csv
    romanescoName = "RSS" ;
    IDobj = 19 ;
    IDgroup = 3 ;
    romanescoAuthor  = "Stan Le Punk";
    romanescoVersion = "Alpha 2.0";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
    romanescoMode = "" ; // separate the name by a slash and write the next mode immadialtly after this one.
  }
  //GLOBAL
  FeedReader flux;
  String RSSliberation, RSSlemonde;
  float Rinfo ;
  int info = 0 ; 
  String messageRSS ;
  
  
  //SETUP
  public void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
    if(internet) {
      String [] fluxRSS = loadStrings(sketchPath("")+"RSSReference.txt") ;
      String RSS = join(fluxRSS, "") ;
      flux = new FeedReader(RSS);
    }
  }
  
  
  
  
  //DRAW
  public void display() {
    float corps ;
    //size text / corps
    corps = map(sizeYObj[IDobj], 0, height, 6, height *0.33f) ;
    textFont(font[IDobj], corps + ( corps * mix[IDobj]) );
    // couleur du texte
    float t = alpha(fillObj[IDobj]) * abs(mix[IDobj]) ;
    if ( sound[IDobj] ) { t = alpha(fillObj[IDobj]) ; } 
    int c = color(hue(fillObj[IDobj]), saturation(fillObj[IDobj]), brightness(fillObj[IDobj]), t ) ;
    
    //hauteur largeur, height & width
    float largeur = canvasXObj[IDobj] *3 ;
    float hauteur = canvasYObj[IDobj] *3 ;
    
    fill(c) ;
      
    for( int i=info; i < info + 1; i++) {
      //internet = false ;
      if (internet && presceneOnly) messageRSS =  (i +""+flux.entry[i]) ; else messageRSS = bigBrother ;
      int r ;
      if ( i > 9 ) r =2 ; else if( i > 0 && i < 10 ) r =1 ; else r =0 ; 
      String hune = messageRSS.substring(r);
      //rotation / degr\u00e9
      rotation(directionObj[IDobj], mouse[IDobj].x, mouse[IDobj].y) ;
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
class Karaoke extends SuperRomanesco {
  public Karaoke() {
    //from the index_objects.csv
    romanescoName = "Karaoke" ;
    IDobj = 20 ;
    IDgroup = 3 ;
    romanescoAuthor  = "Stan LePunk";
    romanescoVersion = "Alpha 2.0";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
    romanescoMode = "" ; // separate the name by a slash and write the next mode immadialtly after this one.
  }
  //GLOBAL
  int chapter, sentence ;
  
  //SETUP
  public void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
  }
  
  
  
  
  //DRAW
  public void display() {
    float corps ;
    //size text / corps
    corps = map(sizeYObj[IDobj], 0, height, 6, height *0.33f) ;
    textFont(font[IDobj], corps + ( corps * mix[IDobj]) );
    // couleur du texte
    float t = alpha(fillObj[IDobj]) * abs(mix[IDobj]) ;
    if ( sound[IDobj] ) { t = alpha(fillObj[IDobj]) ; } 
    int c = color(hue(fillObj[IDobj]), saturation(fillObj[IDobj]), brightness(fillObj[IDobj]), t ) ;
    
    //hauteur largeur, height & width
    float largeur = canvasXObj[IDobj] *3 ;
    float hauteur = canvasYObj[IDobj] *3 ;
    
    //tracking chapter
    String karaokeChapters [] = split(textRaw, "*") ;
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
      textFont(font[IDobj], corps + (mix[IDobj]) *6 *beat[IDobj]);
      fill(c) ;
      text(karaokeSentences[sentence], 0 , 0 , largeur, hauteur ) ;
    }

  }
}
//end object one


//////////////////
//OBJECT ROMANESCO
Twitter twt;
ArrayList<MessageTwitter> listMsg ;
String joinedWordsTwitter = ("") ;

//
class Twitos extends SuperRomanesco {
  public Twitos() {
    //from the index_objects.csv
    romanescoName = "Twitos" ;
    IDobj = 21 ;
    IDgroup = 3 ;
    romanescoAuthor  = "Stan Le Punk";
    romanescoVersion = "Alpha 2.1";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
    romanescoMode = "" ; // separate the name by a slash and write the next mode immadialtly after this one.
  }
  //GLOBAL
  String message ;
  String hashtag ;
  
  
  //SETUP
  public void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
    listMsg = new ArrayList<MessageTwitter>() ;
    String [] hshtg = loadStrings(sketchPath("")+"preferences/twitter/ashtagReference.txt")  ;
    hashtag = join(hshtg, "") ;
    
    twt = new Twitter(hashtag, 2, true); // false ou true pour Online ou non
    
    if (internet ) twt.setup();
  }
  
  
  
  
  //DRAW
  public void display() {
    float corps ;
    //size text / corps
    corps = map(sizeYObj[IDobj], 0, height, 6, height *0.33f) ;
    textFont(font[IDobj], corps + ( corps * mix[IDobj]) );
    // couleur du texte
    float t = alpha(fillObj[IDobj]) * abs(mix[IDobj]) ;
    if ( sound[IDobj] ) { t = alpha(fillObj[IDobj]) ; } 
    int c = color(hue(fillObj[IDobj]), saturation(fillObj[IDobj]), brightness(fillObj[IDobj]), t ) ;
    

    
    //hauteur largeur, height & width
    float largeur = canvasXObj[IDobj] *3 ;
    float hauteur = canvasYObj[IDobj] *3 ;
    
    // message reception
    if (internet) message = twt.update() ; else message = bigBrother ;
    // full message
    // split the message to can remove the hashtag
    if (message == null ) { 
      boolean acces = false ;
      if(internet) acces = twt.twitterAcces() ;
       if (acces && joinedWordsTwitter.equals("") ) joinedWordsTwitter = (hashtag) ; 
    } else {
      String[] words = splitTokens(message);
      // to remove the Hashtag
      if (words[0] == words[0] ) words[0] = ("") ; // must clean that if the the first word is not an ashtag, is a problem
      // rebuilt the sentence
      joinedWordsTwitter = join(words, " ") ;
    }
    
    listMsg.add( new MessageTwitter(trim(joinedWordsTwitter))) ;
    if ( listMsg.size()> 1 ) listMsg.remove(0) ; // to change the tweet by the new one
    
    
    //DISPLAY
    textAlign(CORNER);
    textFont(font[IDobj], corps + (mix[IDobj]) *6 *beat[IDobj]);
    for (MessageTwitter msgTwt : listMsg)  {
      rotation(directionObj[IDobj], mouse[IDobj].x, mouse[IDobj].y) ;
      if (soundButton[IDobj] != 1) msgTwt.display( -width/2 , 0, largeur, hauteur, c ) ; else msgTwt.display(-width/2 -(right[IDobj]*20) , -(left[IDobj ]*20) , largeur, hauteur, c ) ;
    }

  }
}
//end object one






////////////////////////
//CLASS MESSAGE TWITTER
class MessageTwitter {
  String mt ;
  
  MessageTwitter(String mt ) {
    this.mt = mt ;
  }
  //constructor test
  MessageTwitter() {}
  
  public void display(float d, float g , float l, float h, int c) {
    fill(c) ;
    text(mt, d, g, l, h) ;
  }
}
//////////////////
////////////////





//////////////////
//CLASS TWITER









ArrayList twitter_statuses; 

class Twitter {
  
  String[] statuses_offline = { "Romanesco Alpha "+release, "Romanesco Alpha "+release, "Romanesco Alpha "+release, "Romanesco Alpha "+release };
  
  String keyword;

  float periodNextStatus;
  float period = 0.0f;
  float time=0.0f;

  boolean isOnline = false;
  // boolean isOnline = true;
  int offlineIndex = 0;

  Twitter(String k, float period, boolean online) {
    periodNextStatus = period;
    keyword = k;
    twitter_statuses = new ArrayList();
    isOnline = online;
  }
  ///////////////////
  boolean twitterAcces ;
  public void setup() {
    // load the file.txt to read your twitter code
    String [] codeT = loadStrings(sketchPath("")+"preferences/twitter/twitterCode.txt")  ;
    String codeTwitter = join(codeT, "") ;
    String [] cT = split(codeTwitter, ",") ;
    
    //use this line if don't use the Sc\u00e8ne
    if(presceneOnly ) if (cT[0].equals("true") || cT[0].equals("TRUE") ) { 
      twitterAcces = true ; 
    } else {
      twitterAcces = false ;
      joinedWordsTwitter = ("GIVE ME THE TWITTER CODE") ;
    }
    

    //acces twitter
    if (isOnline && twitterAcces) {
      // Configuration builder est simplement un objet qui stocke 
      // l'information d'application / authentification d'une application Twitter
      // Pass\u00e9 en param\u00e8tre \u00e0 l'instance de Twitter Stream
      ConfigurationBuilder cb = new ConfigurationBuilder();
      cb.setDebugEnabled(false)
        .setOAuthConsumerKey(cT[2])
        .setOAuthConsumerSecret(cT[4])
        .setOAuthAccessToken(cT[6])
        .setOAuthAccessTokenSecret(cT[8]);  

      // Objet qui permet de r\u00e9cup\u00e9rer les tweets
      TwitterStream ts = new TwitterStreamFactory(cb.build()).getInstance();
  
      // Filter Query est un objet qui permet de faire une requ\u00eate sur la base de donn\u00e9es de Twitter
      // en fonction de param\u00e8tres (par exemple des mots cl\u00e9s)
      FilterQuery filterQuery = new FilterQuery() ; 
      filterQuery.track(new String[] { keyword } ); 
  
      // On fait le lien entre le TwitterStream (qui r\u00e9cup\u00e8re les messages) et notre \u00e9couteur  
      ts.addListener(new TwitterListener());
      // On d\u00e9marre la recherche !
      ts.filter(filterQuery);
    }
  }
  
  
  public boolean twitterAcces() {
    if (twitterAcces) return true ; else return false ;
  }
  /////////////////////////////
  public String update() {
    period += millis() - time;
    time = millis();

    // Plus grand que notre p\u00e9riode ? 
    if (period/1000 >= periodNextStatus) {
      // R\u00e9-initialise
      period = 0.0f;
      // On prend le premier message dans la liste (= le plus ancien)
      // Puis on l'affiche
      if (isOnline) {
        if (twitter_statuses.size() > 0) {
          Status currentStatus = (Status)twitter_statuses.remove(0);
          return currentStatus.getText();
        }
      } else {
        //String s =  statuses_offline[1];
        String s =  statuses_offline[offlineIndex];
        offlineIndex = (offlineIndex+1)%statuses_offline.length;
        return s;
      }
    }
    return null;
  }
};


// ------------------------------------------------------------
// class TwitterListener
//
// Classe qui permet "d'\u00e9couter" les messages entrants
// r\u00e9cup\u00e9r\u00e9s par notre instance TwitterStream
// ------------------------------------------------------------
class TwitterListener implements StatusListener{
  // onStatus : nouveau message qui vient d'arriver 
  public void onStatus(Status status) {
    twitter_statuses.add(status);
  }  

  // onDeletionNotice
  public void onDeletionNotice(StatusDeletionNotice statusDeletionNotice) {
  }

  // onTrackLimitationNotice
  public void onTrackLimitationNotice(int numberOfLimitedStatuses) {
  }  

  // onScrubGeo : r\u00e9cup\u00e9ration d'infos g\u00e9ographiques
  public void onScrubGeo(long userId, long upToStatusId) {
   System.out.println("Got scrub_geo event userId:" + userId + " upToStatusId:" + upToStatusId);
  }

  // onException : une erreur est survenue (d\u00e9connexion d'internet, etc...)
  public void onException(Exception ex) {
    ex.printStackTrace();
  }
}


//video
/*
void truc() {
  if(object[IDobj] && videoSignal ) { 
    text( "Camera active ", 15, 15 * (posInfoObj) ) ;  posInfoObj += 1 ; 
  } else { 
    text("No Video Signal", 15, 15 *(posInfoObj) ) ;
    posInfoObj += 1 ;
  }
}
*/

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
public void paletteRandom(PVector n, PVector spectrum)
{
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
public void paletteClassic(int [] hueList, int[] satList, int[] brightList, PVector spectrum)
{
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
public void paletteHue(PVector hueInfo )  {  // (huePivot, hueSpeed, hueRange )
  float cycle = cycle(hueInfo.y) ;
  float factor = map(cycle, -1,1, hueInfo.z,1) ;
  for ( int i = 0 ; i < huePalette.length ; i++ ) {
     huePalette [i] = PApplet.parseInt(hueInfo.x + (factor * (huePaletteRef [i] - hueInfo.x))) ;
  }
  hueSpectrumPalette(huePalette, (int)HSBmode.x) ;
}

//saturation void
public void paletteSat(PVector satInfo ) { // (satPivot, satSpeed, satRange )
  float cycle = cycle(satInfo.y) ;
  float factor = map(cycle, -1,1, satInfo.z,1) ;
  for ( int i = 0 ; i < satPalette.length ; i++ ) {
     satPalette [i] = PApplet.parseInt(satInfo.x + (factor * (satPaletteRef [i] - satInfo.x))) ;
  }
  satSpectrumPalette(satPalette, (int)HSBmode.y) ;
}

//brightness void
public void paletteBright(PVector brightInfo ) {  // (brightPivot, brightSpeed, brightRange )
  float cycle = cycle(brightInfo.y) ;
  float factor = map(cycle, -1,1, brightInfo.z,1) ;
  for ( int i = 0 ; i < brightPalette.length ; i++ ) {
     brightPalette [i] = PApplet.parseInt(brightInfo.x + (factor * (brightPaletteRef [i] - brightInfo.x))) ;
  }
  brightSpectrumPalette(brightPalette, (int)HSBmode.z) ;
}






//hue Spectrum
public void hueSpectrumPalette(int [] hueP, int sizeSpectrum)
{  
  if( hueP.length > 0 ) {
    int max = hueP.length  ;
    hueStart = new int [max] ;
    hueEnd = new int [max] ;
    int [] zoneLeftHue = new int [max] ;
    int [] zoneRightHue = new int [max] ;
    int [] zoneHue = new int [max] ;
  
    
    int total = 0 ;
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
public void satSpectrumPalette(int [] satP, int sizeSpectrum)
{  
  if(satP.length > 0 ) {
    int max = satP.length  ;
    satStart = new int [max] ;
    satEnd = new int [max] ;
    int [] zoneLeftSat = new int [max] ;
    int [] zoneRightSat = new int [max] ;
    int [] zoneSat = new int [max] ;
  
    
    int total = 0 ;
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
public void brightSpectrumPalette(int [] brightP, int sizeSpectrum)
{  
  if(brightP.length > 0 ) {
    int max = brightP.length  ;
    brightStart = new int [max] ;
    brightEnd = new int [max] ;
    int [] zoneLeftBright = new int [max] ;
    int [] zoneRightBright = new int [max] ;
    int [] zoneBright = new int [max] ;
  
    
    int total = 0 ;
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
public void changeColorOfPixel(ArrayList listMustBeChange )
{
  for( int i = 0 ; i<listMustBeChange.size() ; i++) {
    Pixel p = (Pixel) listMustBeChange.get(i) ;
    p.changeHue   (huePalette,     hueStart,    hueEnd) ;
    p.changeSat   (satPalette,     satStart,    satEnd) ; 
    p.changeBright(brightPalette,  brightStart, brightEnd) ;
    
    p.updatePalette() ; 
  }
}














  
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
//END COLOR
///////////







//DRAWING
//////////

//cross
///////
public void crossPoint(PVector pos, int colorCross, int e, int size) {
  stroke(colorCross) ;
  strokeWeight(e) ;
  
  line(pos.x, pos.y -size, pos.x, pos.y +size) ;
  line(pos.x +size, pos.y, pos.x -size, pos.y) ;
}


//just a little cross, for make cursor, point etc
public void crossPoint(PVector pos, PVector size, int colorCross, float e ) {
  if (e <0.1f) e = 0.1f ;
  stroke(colorCross) ;
  strokeWeight(e) ;
  //horizontal
  line(pos.x, pos.y -size.x, pos.x, pos.y +size.x) ;
  //vertical
  line(pos.x +size.y, pos.y, pos.x -size.y, pos.y) ;
}
//end cross
///////////


//CURTAIN////
/////////////
public void curtain() {
  // we must put a security for the rideau, if not there is bug sometime and the rideau appear we don't know why
  if( eCurtain == 1) {
    rectMode(CORNER) ;
    float rideau = 100 ; 
    fill (0, rideau ) ; 
    noStroke() ;
    rect(-1,-1, width+2, height+2);
    fill(75, rideau) ;
    textSize(36) ;
    textFont(ContainerRegular) ;
  }
}
//end curtain
/////////////

//////////////
//END DRAWING


//CURSOR, PEN, LEAP MOTION
//CURSOR, MOUSE, TABLET, LEAP MOTION
//GLOBAL
public void cursorSetup() {
  for (int i = 0 ; i < numObj ; i++ ) {
    pen[i] = new PVector(0,0,0) ;
    mouse[i] = new PVector(0,0) ;
    pmouse[i] = new PVector(0,0) ;
    wheel[i] = 0 ;
  }
}


public void cursorDraw() {
  //mousePressed
  if( clickShortLeft[0] || clickShortRight[0] || clickLongLeft[0] || clickLongRight[0] ) mousepressed[0] = true ; else mousepressed[0] = false ;
  //next previous
  if (nextPrevious) nextPreviousInt = 1 ; else nextPreviousInt = 0 ;
}
///////////////
//END CURSOR, PEN, 

















//INSIDE
//CIRLCLE
public boolean insideCircle (PVector pos, int diam) {
  if (dist(pos.x, pos.y, mouseX, mouseY) < diam) return true  ; else return false ;
}

//RECTANGLE
public boolean insideRect(PVector pos, PVector size) { 
    if(mouse[0].x > pos.x && mouse[0].x < pos.x + size.x && mouse[0].y >  pos.y && mouse[0].y < pos.y + size.y) return true ; else return false ;
}

//LOCKED
public boolean locked ( boolean inside ) {
  if ( inside  && mousepressed[0] ) return true ; else return false ;
}




















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







////////////
//SAVE IMAGE
////////////
int countSave = 0 ;
public void saveImg(File selection) {
  
  if (selection == null) {
    println("no picture saved");
  } else {
    
    savePathPNG = savePathPDF  = selection.getAbsolutePath() ;
    countSave += 1 ;
    
    if (!savePathPDF.endsWith(".pdf")) {
      savePathPDF += ".pdf";
    }
    
    if (!savePathPNG.endsWith(".png")) {
      savePathPNG += ".png";
    }
    saveFrame(savePathPNG);
        
  }
}
////////////////
//END SAVE IMAGE
///////////////



/////////////
//BACKGROUND
/////////////
int artificialTime ;
//FOND
public void backgroundRomanesco() {
  noStroke() ;
  int bg ;
  //to smooth the curve of transparency background
  float facteur = 2.5f ;
  // float homothety = 100.0 ;
  float nx = norm(valueSlider[0][3], 0.0f , 100.0f) ;
  float ny = pow (nx ,facteur );
  ny = map(ny, 0, 1 , 0.8f, 100 ) ;
  
  bg = color (map(valueSlider[0][0],0,100,0,360), valueSlider[0][1], valueSlider[0][2], ny ) ; 
  //choice the background
  if(displayMode.equals("Classic")) backgroundClassic(bg) ;
  else if(displayMode.equals("P3D")) backgroundP3D(bg) ;
}

//diffenrent background
public void backgroundClassic(int c) {
  //DISPLAY FINAL
  noStroke() ;
  fill(c) ;
  rect (0,0, width, height) ;
}

//P3D
//BACKGROUND
////////////
PVector sizeBG ;
public void backgroundP3D(int c) {
  fill(c) ;
  noStroke() ;
  pushMatrix() ;
  sizeBG = new PVector(width *100, height *100, height *7) ;
  translate(-sizeBG.x *.5f,-sizeBG.y *.5f , -sizeBG.z) ;
  rect(0,0, sizeBG.x,sizeBG.y) ;
  popMatrix() ;
}
//END BACKGROUND
////////////////


///////////////////////////////////////////////
// MISC
//////////////////////////////////////////////

//easing
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



//drop event
public void dropEvent(DropEvent theDropEvent) {
  // if the dropped object is an image, then load the image into our PImage.
  if(theDropEvent.isImage()) {
      escargotGOanalyze = false ;
      escargotClear() ;

   // println("### loading image ...");
    img = theDropEvent.loadImage();
    analyzeDone = false ;
  }
}
//end dropevent


// zoom
//with the wheel mouse
private float getCountZoom ;
public void zoom() { getCountZoom = wheel[0] ; }
//end zoom


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





///////////////////////////////////////////////
// END MISC
//////////////////////////////////////////////






  ///////////////////////////////////
 //    GRAPHIC CONFIGURATION  //////
///////////////////////////////////

//SCREEN CHOICE and FULLSCREEN
GraphicsEnvironment g = GraphicsEnvironment.getLocalGraphicsEnvironment();
GraphicsDevice[] gs = g.getScreenDevices();
//FULLSCREEN
boolean undecorated = false ;
boolean fullScreen = false ;
boolean displaySizeByImage ;
String displayMode = ("") ;
//ID of the screen
int whichScreen ;
//size of the Scene
int sceneWidth, sceneHeight ;
//to load the .csv who give the graphic configuration for the Scene
Table configurationScene;


String pathScenePropertySetting = sketchPath("")+"preferences/sceneProperty.csv" ;
TableRow row ;
//SETUP
public void displaySetup(int speed) {
  frameRate(speed) ; noCursor () ;
  colorMode(HSB, HSBmode.x, HSBmode.y, HSBmode.z, 100) ;
  configurationScene = loadTable(pathScenePropertySetting, "header");
  
  loadPropertyScene() ;
  sizeScene() ;
}


//load property from table
public void loadPropertyScene() {
  row = configurationScene.getRow(0);
  //fullscreen 
  if (row.getString("fullscreen").equals("TRUE") || row.getString("fullscreen").equals("true")) fullScreen = true ; else fullScreen = false ;
  //display on specific screen
  whichScreen = row.getInt("whichScreen") -1 ;
  //decorated the scene
  if (row.getString("decorated").equals("FALSE") || row.getString("decorated").equals("false") || fullScreen ) undecorated = true ; else undecorated = false ;
  //size of the scene when it's not fullscreen
  sceneWidth = row.getInt("width") ;
  sceneHeight =  row.getInt("height")  ;
  //SYPHON
  if(row.getString("miroir").equals("TRUE") || row.getString("miroir").equals("true")) sendToSyphon = true ; else sendToSyphon = false ;
  

  // type of renderer
  if      ( row.getString("render").equals("P2D") ) { displayMode = ("P2D") ;  modeP3D = false ; }
  else if ( row.getString("render").equals("P3D") ) { displayMode = ("P3D") ; modeP3D = true ; }
  else if (  row.getString("render").equals("OPENGL")  || row.getString("render").equals("opengl") ) { displayMode = ("OPENGL") ; modeP3D = false ; }
  else { displayMode = ("Classic") ; modeP3D = false ; }
}
// end load property

//size scene
public void sizeScene() {
    //create the Scene on fullscreen mode
  if ( fullScreen && displayMode.equals("Classic")) {
    size(screenWidth(whichScreen),screenHeight(whichScreen)) ;
    sketchPos(0, 0, whichScreen) ;
  } else if ( fullScreen && displayMode.equals("P2D")) {
    if ( !isGL() ) removeBorder() ;
    size(screenWidth(whichScreen),screenHeight(whichScreen), P2D) ;
    sketchPos(0, 0, whichScreen) ;
  } else if ( fullScreen && modeP3D) {
    if ( !isGL() ) removeBorder() ;
    size(screenWidth(whichScreen),screenHeight(whichScreen), P3D) ;
    sketchPos(0, 0, whichScreen) ;
  } else if ( fullScreen && displayMode.equals("OPENGL")) {
    if ( !isGL() ) removeBorder() ;
    size(screenWidth(whichScreen),screenHeight(whichScreen), OPENGL) ;
    sketchPos(0, 0, whichScreen) ;
  }
  //create the Scene on window mode
  else if ( !fullScreen && displayMode.equals("Classic")  )      size(sceneWidth, sceneHeight) ;
  else if ( !fullScreen && displayMode.equals("P2D")  )   size(sceneWidth, sceneHeight, P2D) ;
  else if ( !fullScreen && modeP3D )   size(sceneWidth, sceneHeight, P3D) ;
  else if ( !fullScreen && displayMode.equals("OPENGL") ) size(sceneWidth, sceneHeight, OPENGL) ;
  else size(sceneWidth, sceneHeight) ;
  
  //resizable frame by loading external image when Romanesco is not on fullscreen mode
  if (row.getString("resizable").equals("TRUE")  && !fullScreen && displayMode.equals("Classic") ) {
    frame.pack();  
    insets = frame.getInsets(); // use for the border of window (top and right)
    displaySizeByImage = true ;
  }
}
// END size scene




//REMOVE DECORTION WINDOW
public void removeBorder() {
  frame.removeNotify();
  frame.setUndecorated(undecorated);
  frame.addNotify();
}


    

//CHANGE SIZE DISPLAY BY IMAGE LOADING
public void updateSizeDisplay(PImage imgDisplay)
{
  if (imgDisplay != null ) {
    PVector newSizeSketch = new PVector (imgDisplay.width, imgDisplay.height ) ;
    setSize((int)newSizeSketch.x, (int)newSizeSketch.y) ;
    PVector newSizeWindow = new PVector ( Math.max( newSizeSketch.x, MIN_WINDOW_WIDTH)  + insets.left + insets.right, 
                                          Math.max( newSizeSketch.y, MIN_WINDOW_HEIGHT) + insets.top  + insets.bottom) ;
    frame.setSize((int)newSizeWindow.x, (int)newSizeWindow.y);
  }
}

//SCREN SIZE
//catch the size of display device to get the fullscreen on the screen of your choice
public PVector fullScreen(int whichScreen) {
  PVector size = new PVector(0,0) ;
  if (whichScreen >= gs.length ) { 
    whichScreen = 0 ;
    println( "screen choice not available") ;
  }
  size.x =  gs[whichScreen].getDisplayMode().getWidth() ;
  size.y =  gs[whichScreen].getDisplayMode().getHeight() ;

  return size ;
}
// width
public int screenWidth(int whichScreen) {
  int x = 0 ;
  if (whichScreen >= gs.length ) { 
    whichScreen = 0 ;
    println( "screen choice not available") ;
  }
  x = gs[whichScreen].getDisplayMode().getWidth() ;
  return x ;
}
//heigth
public int screenHeight(int whichScreen) {
  int y = 0 ;
  if (whichScreen >= gs.length ) { 
    whichScreen = 0 ;
    println( "screen choice not available") ;
  }
  y = gs[whichScreen].getDisplayMode().getHeight() ;
  return y ;
}
// END SCREEN SIZE





//SKETCH POSITION
public void sketchPos(int x, int y, int which) {
  if (which >= gs.length ) { 
    which = 0 ;
    println( "screen choice not available") ;
  } 
  GraphicsDevice gd = gs[which];
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



// MIROIR
/////////
Miroir miroir;
boolean sendToSyphon  ;

public void miroirSetup() {
  if (sendToSyphon) miroir = new Miroir(this);
}

public void miroirDraw() {
  if (sendToSyphon) miroir.update();
}




class Miroir {
  public PGraphics canvas;
  public SyphonServer server;
  PApplet that;
  Miroir(PApplet that) {
    this.that = that;
    canvas = createGraphics(that.width, that.height, P3D);
    // Create syhpon server to send frames out.
    //server = new SyphonServer(that, "Processing Syphon");
    server = new SyphonServer(that, "Romanesco");
  }
  public void update() {
    that.loadPixels();
    canvas.loadPixels();
    //mirror effect
    /*
    for(int i=0;i<that.pixels.length;i++){
      canvas.pixels[i] = that.pixels[i];
    }
    */
    for(int x = 0; x < that.width; x++) {
     for(int y = 0; y < that.height; y++) {
         canvas.pixels[((that.height-y-1)*that.width+x)] = that.pixels[y*that.width+x];
     }
   }
    canvas.updatePixels();
    server.sendImage(canvas);
  }
}
//END MIROIR


  //////////////////////////////////////
 ///  END OF GRAPHIC CONFIGURATION ////
//////////////////////////////////////




//TRANSLATOR
////////////
//truncate
public float truncate( float x ) {
    return round( x * 100.0f ) / 100.0f;
}

//file name for save
public String nameNumber(String name) {
  String numPict ;
  int year = year() -2000 ;
  String newYear = String.valueOf(year) ;
  String newMonth = String.valueOf(month()) ;
  String newDay = String.valueOf(day()) ;
  
  String newSecond = String.valueOf((hour() *60 *60) + (minute() *60 ) + second()) ;
  numPict = (name + newYear + "_" + newMonth + "_" + newDay + "_" +newSecond) ;
  return numPict  ;
}
//END TRANSLATOR
////////////////










//////////
//KEYBOARD

//short Touch
boolean aTouch, bTouch, cTouch, dTouch, eTouch, fTouch, gTouch, hTouch, iTouch, jTouch, kTouch, lTouch, mTouch, nTouch, oTouch, pTouch, qTouch, rTouch, sTouch, tTouch, uTouch, vTouch, wTouch, xTouch, yTouch, zTouch,
        leftTouch, rightTouch, upTouch, downTouch, 
        touch0, touch1, touch2, touch3, touch4, touch5, touch6, touch7, touch8, touch9, 
        backspaceTouch, deleteTouch, enterTouch, returnTouch, shiftTouch, altTouch, escTouch, ctrlTouch ;
//long touch
boolean spaceTouch, cLongTouch, nLongTouch, vLongTouch ;  

//END KEYBOARD
//////////////






////////////////////////
// FONT and TEXT MANAGER

//////
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
  String fontPathVLW = sketchPath("")+"preferences/Font/typoVLW/" ;
  //write font path
  pathFontVLW[1] = (fontPathVLW+"AmericanTypewriter-96.vlw");
  pathFontVLW[2] = (fontPathVLW+"AmericanTypewriter-Bold-96.vlw");
  pathFontVLW[3] = (fontPathVLW+"BancoITCStd-Heavy-96.vlw");
  pathFontVLW[4] = (fontPathVLW+"CinquentaMilMeticais-96.vlw");
  pathFontVLW[5] = (fontPathVLW+"Container-Regular-96.vlw");
  pathFontVLW[6] = (fontPathVLW+"Diesel-96.vlw");
  pathFontVLW[7] = (fontPathVLW+"Digital2-96.vlw");
  pathFontVLW[8] = (fontPathVLW+"DIN-Regular-96.vlw");
  pathFontVLW[9] = (fontPathVLW+"DIN-Bold-96.vlw");
  pathFontVLW[10] = (fontPathVLW+"EastBlocICGClosed-96.vlw");
  pathFontVLW[11] = (fontPathVLW+"FuturaStencilICG-96.vlw");
  pathFontVLW[12] = (fontPathVLW+"FetteFraktur-96.vlw");
  pathFontVLW[13] = (fontPathVLW+"GANGBANGCRIME-96.vlw");
  pathFontVLW[14] = (fontPathVLW+"JuanitaDecoITCStd-96.vlw");
  pathFontVLW[15] = (fontPathVLW+"Komikahuna-96.vlw");
  pathFontVLW[16] = (fontPathVLW+"MesquiteStd-96.vlw");
  pathFontVLW[17] = (fontPathVLW+"NanumBrush-96.vlw");
  pathFontVLW[18] = (fontPathVLW+"RosewoodStd-Regular-96.vlw");
  pathFontVLW[19] = (fontPathVLW+"3theHardwayRMX-96.vlw");
  pathFontVLW[20] = (fontPathVLW+"Tokyo-One-96.vlw");
  pathFontVLW[21] = (fontPathVLW+"MinionPro-Regular-96.vlw");
  pathFontVLW[22] = (fontPathVLW+"MinionPro-Bold-96.vlw");

  //special font
  pathFontVLW[49] = (fontPathVLW+"DIN-Regular-10.vlw");
  SansSerif10 = loadFont(fontPathVLW+"SansSerif-10.vlw") ;

  //write font path for TTF
  String prefixTTF = (sketchPath("")+"preferences/Font/typoTTF/") ;
  //by default
  pathFontTTF[0] = (prefixTTF+"FuturaStencil.ttf");
  //type
  pathFontTTF[1] = (prefixTTF+"AmericanTypewriter.ttf");
  pathFontTTF[2] = (prefixTTF+"AmericanTypewriter.ttf");
  pathFontTTF[3] = (prefixTTF+"Banco.ttf");
  pathFontTTF[4] = (prefixTTF+"Cinquenta.ttf");
  pathFontTTF[5] = (prefixTTF+"FuturaStencil.ttf");
  pathFontTTF[6] = (prefixTTF+"FuturaStencil.ttf");
  pathFontTTF[7] = (prefixTTF+"Digital2.ttf");
  pathFontTTF[8] = (prefixTTF+"FuturaStencil.ttf");
  pathFontTTF[9] = (prefixTTF+"FuturaStencil.ttf");
  pathFontTTF[10] = (prefixTTF+"FuturaStencil.ttf");
  pathFontTTF[11] = (prefixTTF+"FuturaStencil.ttf");
  pathFontTTF[12] = (prefixTTF+"FetteFraktur.ttf");
  pathFontTTF[13] = (prefixTTF+"GangBangCrime.ttf");
  pathFontTTF[14] = (prefixTTF+"JuanitaITC.ttf");
  pathFontTTF[15] = (prefixTTF+"Komikahuna.ttf");
  pathFontTTF[16] = (prefixTTF+"FuturaStencil.ttf");
  pathFontTTF[17] = (prefixTTF+"FuturaStencil.ttf");
  pathFontTTF[18] = (prefixTTF+"FuturaStencil.ttf");
  pathFontTTF[19] = (prefixTTF+"3Hardway.ttf");
  pathFontTTF[20] = (prefixTTF+"FuturaStencil.ttf");
  pathFontTTF[21] = (prefixTTF+"MinionWebPro.ttf");
  pathFontTTF[22] = (prefixTTF+"MinionWebPro.ttf");
  //special font
  pathFontTTF[49] = (prefixTTF+"FuturaStencil.ttf");

  //load
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

  //default and special font
  DinRegular10=loadFont            (pathFontVLW[49]);

  font[0] = FuturaStencil ;
  pathFontObjTTF[0] = pathFontTTF[0] ;
}




public void whichFont( int whichFont) 
{ 
  if (whichFont == 1 )     { pathFontObjTTF[0] = pathFontTTF[1] ; font[0] = AmericanTypewriter ;  }
  else if (whichFont ==2 ) { pathFontObjTTF[0] = pathFontTTF[2] ; font[0] = AmericanTypewriterBold ; }
  else if (whichFont == 3) { pathFontObjTTF[0] = pathFontTTF[3] ; font[0] = Banco ; }
  else if (whichFont ==4)  { pathFontObjTTF[0] = pathFontTTF[4] ; font[0] = Cinquenta ; }
  else if (whichFont ==5)  { pathFontObjTTF[0] = pathFontTTF[5] ; font[0] = ContainerRegular ; }
  else if (whichFont ==6)  { pathFontObjTTF[0] = pathFontTTF[6] ; font[0] = Diesel ; }
  else if (whichFont ==7)  { pathFontObjTTF[0] = pathFontTTF[7] ; font[0] = Digital ; }
  else if (whichFont ==8)  { pathFontObjTTF[0] = pathFontTTF[8] ; font[0] = DinRegular ; }
  else if (whichFont ==9)  { pathFontObjTTF[0] = pathFontTTF[9] ; font[0] = DinBold ; }
  else if (whichFont ==10) { pathFontObjTTF[0] = pathFontTTF[10] ; font[0] = EastBloc ; }
  else if (whichFont ==11) { pathFontObjTTF[0] = pathFontTTF[11] ; font[0] = FetteFraktur ; }
  else if (whichFont ==12) { pathFontObjTTF[0] = pathFontTTF[12] ; font[0] = FuturaStencil ; }
  else if (whichFont ==13) { pathFontObjTTF[0] = pathFontTTF[13] ; font[0] = GangBangCrime ; }
  else if (whichFont ==14) { pathFontObjTTF[0] = pathFontTTF[14] ; font[0] = JuanitaOutline ; }   
  else if (whichFont ==15) { pathFontObjTTF[0] = pathFontTTF[15] ; font[0] = Komikahuna ; }
  else if (whichFont ==16) { pathFontObjTTF[0] = pathFontTTF[16] ; font[0] = Mesquite ; }
  else if (whichFont ==17) { pathFontObjTTF[0] = pathFontTTF[17] ; font[0] = Minion ; }
  else if (whichFont ==18) { pathFontObjTTF[0] = pathFontTTF[18] ; font[0] = MinionBold ; }
  else if (whichFont ==19) { pathFontObjTTF[0] = pathFontTTF[19] ; font[0] = NanumBrush ; }
  else if (whichFont ==20) { pathFontObjTTF[0] = pathFontTTF[20] ; font[0] = Rosewood ; }
  else if (whichFont ==21) { pathFontObjTTF[0] = pathFontTTF[21] ; font[0] = TheHardwayRMX ; }
  else if (whichFont ==22) { pathFontObjTTF[0] = pathFontTTF[22] ; font[0] = TokyoOne ; } 
  else                     { pathFontObjTTF[0] = pathFontTTF[49]  ; font[0] = AmericanTypewriter ; }
}
//END FONT

//TEXT
String importRaw [] ;
String  textRaw ;
String [][] sentencesByChapter ;

public void importText(String path) {
  importRaw = loadStrings(path) ;
  textRaw = join(importRaw, "") ;
}

public void splitText() {
  String karaokeChapters [] = split(textRaw, "*") ;
  
  // find the quantity of chapter and sentences by chapter to create the final double array String
  int numChapter = karaokeChapters.length ;
  int maxSentencesByChapter = 0 ;  
  for ( int i = 0 ; i < numChapter ; i++) {
    String sentences [] = split(karaokeChapters[i], "/") ;
    if ( sentences.length > maxSentencesByChapter ) maxSentencesByChapter = sentences.length ; 
  }
  //create the final double array string
  sentencesByChapter = new String [numChapter][maxSentencesByChapter] ;
  //put the sentences in the double String by chapter
  for ( int i = 0 ; i < numChapter ; i++) {
    String sentences [] = split(karaokeChapters[i], "/") ;
    for ( int j = 0 ; j <  sentences.length ; j++) {
      sentencesByChapter [i][j] = sentences[j] ;
    }
  }
}
// END TEXT
//////////

// END FONT and TEXT MANAGER
////////////////////////////








//////////////
//DISPLAY INFO
int posInfoObj = 2 ;

public void displayInfoScene() {
  noStroke() ;
  fill(0,100,0, 50) ;
  rect(0,-5,width, 15*posInfoObj) ;
  posInfoObj = 2 ;
  fill(0,0,100) ;
  textFont(SansSerif10, 10) ;
  //INFO SIZE and RENDERER
  String displayModeInfo ;
  if (displayMode.equals("Classic") ) displayModeInfo = ("classique") ; else displayModeInfo = displayMode ;
  if (img != null ) text ("Taille de la sc\u00e8ne " + width + "x" + height + " Taille de l'image "+ img.width + "x"+ img.height + "   Mode d'affichage " + displayModeInfo , 15,15 ) ; 
  else text("Taille de la sc\u00e8ne " + width + "x" + height + "   mode d'affichage " + displayModeInfo, 15,15) ;
  //INFO MOUSE and PEN
  text("position X " + mouse[0].x + "  position Y " + mouse[0].y + "  molette " + wheel[0] + "    stylet orientation " + (int)deg360(pen[0]) +"\u00b0   stylet pression " + PApplet.parseInt(pen[0].z *10),15, 15 * (posInfoObj) ) ;  
  posInfoObj += 1 ;
  //INFO SOUND
  if (getTimeTrack() > 1 ) text("Le morceau dure depuis " +getTimeTrack() + "  Tempo " + getTempoRef() , 15,15 *(posInfoObj)) ; else text("Aucun morceau d\u00e9tect\u00e9 ", 15, 15 *(posInfoObj)) ;
  posInfoObj += 1 ;
  //INFO WEATHER and METEO
  text(weather.getCityName() + " / " + traductionWeather (weather.getWeatherConditionCode()) + "    Temp\u00e9rature " + weather.getTemperature() + "C\u00b0" + "   Pression " + hectoPascal(weather.getPressure()) + " HectoPascal", 15,15 *(posInfoObj)) ; 
  posInfoObj += 1 ;
  text ("Vent " + windFrench() + " de Force " + beaufort() + "     Lev\u00e9 du soleil " + weather.getSunrise() + "     Couch\u00e9 du soleil " + weather.getSunset(), 15,15 *(posInfoObj)) ; 
  posInfoObj += 1 ;

}
////////////////
//END DISPLAY INFO















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

//repere camera
public void repereCamera(PVector size) {
  size.x = size.x *.1f ;
  size.y = size.y *.1f ;
  
  int xColor = rouge ;
  int yColor = vert ;
  int zColor = jaune ;
  int posTxt = 10 ;
  textFont(SansSerif10, 10) ;
  
  
  //GRID
  grid(size) ;
  //AXES
  strokeWeight(.2f) ;
  // X LINE
  fill(xColor) ;
  text("X LINE XXX", posTxt,-posTxt) ;
  stroke(xColor) ; noFill() ;
  line(-size.x,0,0,size.x,0,0) ;
  
  // Y LINE
  fill(yColor) ;
  pushMatrix() ;
  rotateZ(radians(-90)) ;
  text("Y LINE YYY", posTxt,-posTxt) ;
  popMatrix() ;
  stroke(yColor) ; noFill() ;
  line(0,-size.y,0,0,size.y,0) ;
  
  // Z LINE
  fill(zColor) ;
  pushMatrix() ;
  rotateY(radians(90)) ;
  text("Z LINE ZZZ", posTxt,-posTxt) ;
  popMatrix() ;
  stroke(zColor) ; noFill() ;
  line(0,0,-size.z,0,0,size.z) ;
}


public void grid(PVector s) {
  strokeWeight(.1f) ;
  noFill() ;
  stroke(bleu) ;
  int sizeX = (int)s.z ;
  //horizontal grid
  for ( int i = -sizeX ; i<= sizeX ; i = i+10 ) {
    if(i != 0 ) line(i,0,-sizeX,i,0,sizeX) ;
  }
}
//END REPERE 3D


//END P3D
/////////
//EQUATION
// EQUATION CIRLCE
public float perimeterCircle ( int r ) {
  float p = 2*r*PI  ;
  return p ;
}
//EQUATION
public float radiusSurface(int s) {
  float  r = sqrt(s/PI) ;
  return r ;
}
// END EQUATION CIRCLE
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
  return sqrt( ( p0.x - p1.x ) * ( p0.x - p1.x ) + ( p0.y - p1.y ) * ( p0.y - p1.y ) );
}

//other Rotation
//Rotation Objet

public void rotation (float angle, float posX, float posY ) {
  translate(posX, posY ) ;
  rotate (radians(angle) ) ;
}

//END OF ROTATION


// END EQUATION





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
/////////////
//CLASS PIXEL
/////////////
class Pixel
{
  int c, newColor ;
  PVector newC = new PVector (0,0,0) ; ;
  PVector pos ;
  PVector newPos = new PVector(0,0,0) ; // absolute pos in the display size : horizontal sytem of pixel system
  PVector gridPos ; // position with cols and rows system : vertical system of ArrayList
  PVector size = new PVector (1,1) ;
  PVector vent ; // the wind force who can change the position of the pixel
  int rank = -1 ;
  int ID = 0 ;
  
  //DIFFERENT CONSTRUCTOR
  
  //classic pixel
  Pixel(PVector pos, int c) {
    this.pos = pos ;
    this.c = c ;
  }
  
  //pixel with size
  Pixel(PVector pos, int c, PVector size) {
    this.pos = pos ;
    this.c = c ;
    this.size = size ;
  }
  
  //rank pixel in the array
  Pixel(int rank, PVector gridPos) {
    this.rank = rank ;
    this.gridPos = gridPos ;
  }
  
  //rank
  Pixel(int rank) {
    this.rank = rank ;
  }
  
  
  
  
  //DISPLAY
  //with effect
  public void displayPixel(int diam, PVector effectColor) {
    strokeWeight(diam) ;
    
    stroke(hue(newColor), effectColor.x *saturation(newColor), effectColor.y *brightness(newColor), effectColor.z) ;
    if (newPos.x == 0 && newPos.y == 0 && newPos.z == 0) newPos = pos ; // else newPos = newPos ;
    point(newPos.x, newPos.y) ;
  }
  
  //without effect
  public void displayPixel(int diam) {
    strokeWeight(diam) ;
    stroke(c) ;
    if (newPos.x == 0 && newPos.y == 0 && newPos.z == 0) newPos = pos ; // else newPos = newPos ;
    //test display with ID
    if (ID == 1 ) point(newPos.x, newPos.y) ;
  }
  
  //Identit\u00e9 de la pixel
  //change ID after analyze if this one is good
  public void changeID(int newID) {  ID = newID ; }
  
  
  
  
  
  //CHANGE COLOR 
  // hue from Range
  public void changeHue(int[] newHue,  int[] start, int[] end) {
    float h = hue(c) ;
    
    for( int i = 0 ; i < newHue.length ; i++) {
      if (start[i] < end[i] ) {
        if( h >= start[i] && h <= end[i] ) h = newHue[i] ; 
      } else if ( start[i] > end[i] ) {
        if( (h >= start[i] && h <= HSBmode.x) || h <= end[i] ) { 
          if( h >= newHue[newHue.length -1] ) h = newHue[newHue.length -1] ; 
          else h = newHue[i] ; 
        }
      }        
    }
    newC.x = h ;
  }
  
  // saturation from Range
  public void changeSat(int[] newSat,  int[] start, int[] end) {
    float s = saturation(c) ;
    
    for( int i = 0 ; i < newSat.length ; i++) {
      if (start[i] < end[i] ) {
        if( s >= start[i] && s <= end[i] ) s = newSat[i] ; 
      } else if ( start[i] > end[i] ) {
        if( (s >= start[i] && s <= HSBmode.y) || s <= end[i] ) { 
          if( s >= newSat[newSat.length -1] ) s = newSat[newSat.length -1] ;
          else s = newSat[i] ;
        }
      }        
    }
    newC.y = s ;
  }
  
  // saturation from Range
  public void changeBright(int[] newBright,  int[] start, int[] end) {
    float b = brightness(c) ;

    
    for( int i = 0 ; i < newBright.length ; i++) {
      if (start[i] < end[i] ) {
        if( b >= start[i] && b <= end[i] ) b = newBright[i] ; 
      } else if ( start[i] > end[i] ) {
        if( (b >= start[i] && b <= HSBmode.z) || b <= end[i] ) { 
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

    newColor = color(h, s, b) ;
  }
  
  
  //UPDATE POSITION with the wind
  public void updatePosPixel(PVector effectPosition, PImage pic) {
    PVector dir = normalDir((int)effectPosition.x) ;
    
    vent = new PVector (1.0f *dir.x *effectPosition.y  + random(-effectPosition.z, effectPosition.z) ,   1.0f *dir.y *effectPosition.y  + random(-effectPosition.z, effectPosition.z))   ;
    pos.add(vent) ;
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
    
    vent = new PVector (1.0f *dir.x *effectPosition.y  + random(-effectPosition.z, effectPosition.z) ,   1.0f *dir.y *effectPosition.y  + random(-effectPosition.z, effectPosition.z))   ;
    newPos.add(vent) ;
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

boolean beatOnOff, kickOnOff, snareOnOff, hatOnOff ;

float beatData, kickData, snareData, hatData ;
float minBeat = 1.0f ;
float maxBeat = 10.0f  ;

//volume
//float leftRaw, rightBrute, // son right left
//      mixBrute ;

//////////////
// SOUND SETUP
public void soundSetup() {
  //Sound
  minim = new Minim(this);
  //sound from outside
  minim.debugOn();
  input = minim.getLineIn(Minim.STEREO, 512);
  
  spectrumSetup(numBand) ;
  beatSetup() ;
}
// END SOUND SETUP
//////////////////




/////////////
// SOUND DRAW
public void soundDraw() {
  spectrum(input.mix, numBand) ;
  beatEnergy.detect(input.mix);
  initTempo() ;
  soundRomanesco() ;
}
// END SOUND DRAW
/////////////////






//specific stuff from romanesco
//////////////////////////////
public void soundRomanesco() {
  int sound = 1 ;
    
  float volumeControleurG = map(valueSlider[0][4], 0,100, 0, 1.3f ) ;
  left[0] = map(input.left.get(sound),  -0.07f,0.1f,  0, volumeControleurG);
  
  float volumeControleurD = map(valueSlider[0][5], 0,100, 0, 1.3f ) ;
  right[0] = map(input.right.get(sound),  -0.07f,0.1f,  0, volumeControleurD);
  
  float volumeControleurM = map(( (valueSlider[0][4] + valueSlider[0][5]) *.5f), 0,100, 0, 1.3f ) ;
  mix[0] = map(input.mix.get(sound),  -0.07f,0.1f,  0, volumeControleurM);
  
  //volume
  if(left[0] < 0 ) left[0] = 0 ;
  if(left[0] > 1 ) left[0] = 1.0f ; 
  if(right[0] < 0 ) right[0] = 0 ;
  if(right[0] > 1 ) right[0] = 1.0f ; 
  if(mix[0] < 0 ) mix[0] = 0 ;
  if(mix[0] > 1 ) mix[0] = 1.0f ;
  
  //Beat
  if(eBeat == 1 )  beatOnOff = true ; else beatOnOff = false ;
  if(eKick == 1 )  kickOnOff = true ; else kickOnOff = false ;
  if(eSnare == 1 ) snareOnOff = true ; else snareOnOff = false ;
  if(eHat == 1 )   hatOnOff = true ; else hatOnOff = false ;
  beat[0] = getBeat(beatOnOff) ;
  kick[0] = getKick(kickOnOff) ;
  snare[0] = getSnare(snareOnOff) ;
  hat[0] = getHat(hatOnOff) ;
  
  //spectrum
  for ( int i = 0 ; i < numBand ; i++ ) {
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
  if ( beatEnergy.isOnset() ) beatNum += 1 ; else if (  getTotalSpectrum(numBand) < 0.03f ) beatNum = 0 ;
  return beatNum ;
}
public int getKickNum() {
  if ( beatFrequency.isKick()  ) kickNum += 1 ; else if (  getTotalSpectrum(numBand) < 0.03f ) kickNum = 0 ;
  return kickNum ;
}
public int getSnareNum() {
  if ( beatFrequency.isSnare()  ) snareNum += 1 ; else if (  getTotalSpectrum(numBand) < 0.03f ) snareNum = 0 ;
  return snareNum ;
}
public int getHatNum() {
  if ( beatFrequency.isHat()  ) hatNum += 1 ; else if (  getTotalSpectrum(numBand) < 0.03f ) hatNum = 0 ;
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
  if (tempoBeatRef > maxSpecific || getTotalSpectrum(numBand) < 0.03f  ) tempoBeatRef = maxSpecific  ; 
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
  if (tempoKickRef > maxSpecific || getTotalSpectrum(numBand) < 0.03f  ) tempoKickRef = maxSpecific  ; 
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
  if (tempoSnareRef > maxSpecific || getTotalSpectrum(numBand) < 0.03f  ) tempoSnareRef = maxSpecific  ; 
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
  if (tempoHatRef > maxSpecific || getTotalSpectrum(numBand) < 0.03f  ) tempoHatRef = maxSpecific  ; 
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
  if ( getTotalSpectrum(numBand) < 0.1f ) timeTrack = 0 ;
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
public float getTotalSpectrum(int numBand) {
  float t = 0 ;
  // float t = bandSprectrum[0] + bandSprectrum[1] + bandSprectrum[2] + bandSprectrum[3] + bandSprectrum[4] + bandSprectrum[5] + bandSprectrum[6] + bandSprectrum[7] + bandSprectrum[8] + bandSprectrum[9] + bandSprectrum[10] + bandSprectrum[11] + bandSprectrum[12] + bandSprectrum[13] + bandSprectrum[14] + bandSprectrum[15] ;
  for ( int i = 0 ; i < numBand ; i++ ) {
    t += bandSprectrum[i] ;
  }
  return t ;
}
//END SPECTRUM
//////////////





//CLASS to use the beat analyze
class BeatListener implements AudioListener
{
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
//////////////
///////
//METEO
//GLOBAL
YahooWeather weather;
int updateIntervallMillis = 30000;
boolean meteo ;

int sunRise, sunSet ;



//SETUP
public void meteoSetup() {
  if(meteo) {
    String [] md = loadStrings (sketchPath("")+"meteo.txt")  ;
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

//DRAW

//Two color
/*
color meteoColor(color day, color night, int whatTimeIsIt, int speedRiseSet)
{
  color colorOfSky ;
  int sunrise,sunset ;
  

  sunrise = int(clock24(weather.getSunrise(), 1)) ;
  sunset = int(clock24(weather.getSunset(), 1)) ;

  //basic 
  //if ( sunrise < whatTimeIsIt && sunset < whatTimeIsIt ) colorOfSky = bleuCiel ; else colorOfSky = bleuNuit ; 
  
  //smooth


  if (  whatTimeIsIt  > sunrise -30 && whatTimeIsIt < sunrise +31 ) {
    sunValue = whatTimeIsIt - sunrise +31  ;
    sky_h = map(sunValue, 0,60, hue(night),       hue(day)) ;
    sky_s = map(sunValue, 0,60, saturation(night),saturation(day)) ;
    sky_b = map(sunValue, 0,60, brightness(night),brightness(day)) ;
  } else if (  whatTimeIsIt  > sunset -30 && whatTimeIsIt < sunset +31 ) {
    sunValue = whatTimeIsIt - sunset +31  ;
    sky_h = map(sunValue, 0,60, hue(day),       hue(night)) ;
    sky_s = map(sunValue, 0,60, saturation(day),saturation(night)) ;
    sky_b = map(sunValue, 0,60, brightness(day),brightness(night)) ;
  } else if ( whatTimeIsIt < sunrise -30 || whatTimeIsIt > sunset +30 ) {
    sky_h = hue(night) ;
    sky_s = saturation(night) ;
    sky_b = brightness(night) ;
  } else {
    sky_h = hue(day) ;
    sky_s = saturation(day) ;
    sky_b = brightness(day) ;
  }
  
  colorOfSky = color (sky_h,sky_s,sky_b) ;
  // colorOfSky = bleuNuit ;
  
  return colorOfSky ;
}

*/



//one color
public int meteoColor(int colorOfTheDay, int whatTimeIsIt, int speedRiseSet, int pressure)
{
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
public int hectoPascal(float pressureToConvert)
{
  int HP ;
  if (pressureToConvert < 800 ) HP = PApplet.parseInt(pressureToConvert *33.86f) ; else HP = (int)pressureToConvert ;
  return HP ;
}
//WIND FORCE
public int beaufort()
{
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
public String windFrench()
{
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
///////////



OscP5 osc;


//SLIDER and BUTTON




//SETUP
public void OSCSetup() {
   if(sendToSyphon) osc = new OscP5(this, 10002); else osc = new OscP5(this, 10001);
}

//EVENT
String dataPreScene [] = new String[9] ;
// to check what else is receive by the receiver
public void oscEvent(OscMessage receive ) {
  //BUTTON
  //position in the receive list, here is the last i+1, so it's numSlider
  String sizeInfoRecption = ("") ;
  for (int i = 0 ; i < dataPreScene.length ; i++ ) {
    dataPreScene [i] = receive.get(i).stringValue() ;
    sizeInfoRecption += dataPreScene [i] ;
  }
    

  //BUTTON
  valueButtonGlobal = PApplet.parseInt(split(dataPreScene[0], '/')) ;
  // stick the Int(String) chain from the group one, two and three is single chain integer(String).
  String fullChainValueButtonObj =("") ;
  for ( int i = 1 ; i <= numGroup ; i++ ) {
    fullChainValueButtonObj += dataPreScene[i]+"/" ;
  }
  valueButtonObj = PApplet.parseInt(split(fullChainValueButtonObj, '/')) ;
  
  //SLIDER
  //split String value from controler
  for ( int i = 0 ; i < numGroup+1 ; i++ ) {
    valueSliderTemp [i] = split(dataPreScene[i+4], '/') ;
    
  }
  //PRESCENE
  valueTempPreScene = split(dataPreScene[8], '/') ;
  // translate the String value to the float var to use
  for ( int i = 0 ; i < numGroup+1 ; i++ ) {
    // security because there not same quantity of slider in the group one and the other group
    int n = 0 ;
    if ( i < 1 ) n = numSliderGroupZero ; else n = numSlider ;
    for (int j = 0 ; j < n ; j++) {
      valueSlider[i][j] = Float.valueOf(valueSliderTemp[i][j]) ;
    }
  }
  
  if(valueTempPreScene[0].equals("0") ) spaceTouch = false ; else spaceTouch = true ;  
  
  if(valueTempPreScene[1].equals("0") ) aTouch = false ; else aTouch = true ;
  if(valueTempPreScene[2].equals("0") ) bTouch = false ; else bTouch = true ;
  if(valueTempPreScene[3].equals("0") ) cTouch = false ; else cTouch = true ;
  if(valueTempPreScene[4].equals("0") ) dTouch = false ; else dTouch = true ;
  if(valueTempPreScene[5].equals("0") ) eTouch = false ; else eTouch = true ;
  if(valueTempPreScene[6].equals("0") ) fTouch = false ; else fTouch = true ;
  if(valueTempPreScene[7].equals("0") ) gTouch = false ; else gTouch = true ;
  if(valueTempPreScene[8].equals("0") ) hTouch = false ; else hTouch = true ;
  if(valueTempPreScene[9].equals("0") ) iTouch = false ; else iTouch = true ;
  if(valueTempPreScene[10].equals("0") ) jTouch = false ; else jTouch = true ;
  if(valueTempPreScene[11].equals("0") ) kTouch = false ; else kTouch = true ;
  if(valueTempPreScene[12].equals("0") ) lTouch = false ; else lTouch = true ;
  if(valueTempPreScene[13].equals("0") ) mTouch = false ; else mTouch = true ;
  if(valueTempPreScene[14].equals("0") ) nTouch = false ; else nTouch = true ;
  if(valueTempPreScene[15].equals("0") ) oTouch = false ; else oTouch = true ;
  if(valueTempPreScene[16].equals("0") ) pTouch = false ; else pTouch = true ;
  if(valueTempPreScene[17].equals("0") ) qTouch = false ; else qTouch = true ;
  if(valueTempPreScene[18].equals("0") ) rTouch = false ; else rTouch = true ;
  if(valueTempPreScene[19].equals("0") ) sTouch = false ; else sTouch = true ;
  if(valueTempPreScene[20].equals("0") ) tTouch = false ; else tTouch = true ;
  if(valueTempPreScene[21].equals("0") ) uTouch = false ; else uTouch = true ;
  if(valueTempPreScene[22].equals("0") ) vTouch = false ; else vTouch = true ;
  if(valueTempPreScene[23].equals("0") ) wTouch = false ; else wTouch = true ;
  if(valueTempPreScene[24].equals("0") ) xTouch = false ; else xTouch = true ;
  if(valueTempPreScene[25].equals("0") ) yTouch = false ; else yTouch = true ;
  if(valueTempPreScene[26].equals("0") ) zTouch = false ; else zTouch = true ;
  //long touch
  if(valueTempPreScene[27].equals("0") ) cLongTouch = false ; else cLongTouch = true ;
  if(valueTempPreScene[28].equals("0") ) nLongTouch = false ; else nLongTouch = true ;
  if(valueTempPreScene[29].equals("0") ) vLongTouch = false ; else vLongTouch = true ;
  
  if(valueTempPreScene[30].equals("0") ) enterTouch = false ; else enterTouch = true ;
  if(valueTempPreScene[31].equals("0") ) deleteTouch = false ; else deleteTouch = true ;
  if(valueTempPreScene[32].equals("0") ) backspaceTouch = false ; else backspaceTouch = true ;
  if(valueTempPreScene[33].equals("0") ) upTouch = false ; else upTouch = true ;
  if(valueTempPreScene[34].equals("0") ) downTouch = false ; else downTouch = true ;
  if(valueTempPreScene[35].equals("0") ) rightTouch = false ; else rightTouch = true ;
  if(valueTempPreScene[36].equals("0") ) leftTouch = false ; else leftTouch = true ;
  if(valueTempPreScene[37].equals("0") ) ctrlTouch = false ; else ctrlTouch = true ;

  //MOUSE, CURSOR, PEN
  //PMOUSE
  if(spaceTouch) {
    pmouseSuperRomanesco.x = map(Float.valueOf(valueTempPreScene[38].replaceAll(",", ".")), 0,1,0, width) ;
    pmouseSuperRomanesco.y = map(Float.valueOf(valueTempPreScene[39].replaceAll(",", ".")), 0,1,0,height) ;
  }
  
  // line for the camera Pmouse, i don't understand why we need this temp var
  if(cLongTouch) {
    pmouseCamera.x = map(Float.valueOf(valueTempPreScene[38].replaceAll(",", ".")), 0,1,0, width) ;
    pmouseCamera.y = map(Float.valueOf(valueTempPreScene[39].replaceAll(",", ".")), 0,1,0,height) ;
  }
  //
  pmouse[0].x = map(Float.valueOf(valueTempPreScene[38].replaceAll(",", ".")), 0,1,0, width) ;
  pmouse[0].y = map(Float.valueOf(valueTempPreScene[39].replaceAll(",", ".")), 0,1,0,height) ;

  //PEN
  pen[0].x = Float.valueOf(valueTempPreScene[40].replaceAll(",", ".")) ;
  pen[0].y = Float.valueOf(valueTempPreScene[41].replaceAll(",", ".")) ;
  pen[0].z = Float.valueOf(valueTempPreScene[42].replaceAll(",", ".")) ;
  
  //MOUSE
  // reference to stop, it's a trick for a bug
  if(spaceTouch) {
    mouseSuperRomanesco.x = map(Float.valueOf(valueTempPreScene[43].replaceAll(",", ".")), 0,1,0, width) ;
    mouseSuperRomanesco.y = map(Float.valueOf(valueTempPreScene[44].replaceAll(",", ".")), 0, 1, 0,height) ;
    mouseSuperRomanesco.z = map(Float.valueOf(valueTempPreScene[45].replaceAll(",", ".")), 0, 1, -750,750) ;
  }
  
  // line for the camera
  if(cLongTouch) {
    mouseCamera.x = map(Float.valueOf(valueTempPreScene[43].replaceAll(",", ".")), 0,1,0, width) ;
    mouseCamera.y = map(Float.valueOf(valueTempPreScene[44].replaceAll(",", ".")), 0, 1, 0,height) ;
    mouseCamera.z = map(Float.valueOf(valueTempPreScene[45].replaceAll(",", ".")), 0, 1, -750,750) ;
  }
  mouse[0].x = map(Float.valueOf(valueTempPreScene[43].replaceAll(",", ".")), 0,1,0, width) ;
  mouse[0].y = map(Float.valueOf(valueTempPreScene[44].replaceAll(",", ".")), 0, 1, 0,height) ;
  mouse[0].z = map(Float.valueOf(valueTempPreScene[45].replaceAll(",", ".")), 0, 1, -750,750) ;
  
  //BUTTON
  if(valueTempPreScene[46].equals("0") ) clickShortLeft[0] = false ; else clickShortLeft[0] = true ;
  if(valueTempPreScene[47].equals("0") ) clickShortRight[0] = false ; else clickShortRight[0] = true ;
  if(valueTempPreScene[48].equals("0") ) clickLongLeft[0] = false ; else clickLongLeft[0] = true ;
  if(valueTempPreScene[49].equals("0") ) clickLongRight[0] = false ; else clickLongRight[0] = true ;
  
  //WHEEL
  wheel[0] = Integer.parseInt(valueTempPreScene[50]) ;
  //END MOUSE, CURSOR, PEN
  
  //number key
  if(valueTempPreScene[51].equals("0") ) touch1 = false ; else touch1 = true ;
  if(valueTempPreScene[52].equals("0") ) touch2 = false ; else touch2 = true ;
  if(valueTempPreScene[53].equals("0") ) touch3 = false ; else touch3 = true ;
  if(valueTempPreScene[54].equals("0") ) touch4 = false ; else touch4 = true ;
  if(valueTempPreScene[55].equals("0") ) touch5 = false ; else touch5 = true ;
  if(valueTempPreScene[56].equals("0") ) touch6 = false ; else touch6 = true ;
  if(valueTempPreScene[57].equals("0") ) touch7 = false ; else touch7 = true ;
  if(valueTempPreScene[58].equals("0") ) touch8 = false ; else touch8 = true ;
  if(valueTempPreScene[59].equals("0") ) touch9 = false ; else touch9 = true ;
  if(valueTempPreScene[60].equals("0") ) touch0 = false ; else touch0 = true ;
  

}


//DRAW
public void OSCDraw() {
  //GLOBAL
  if(valueButtonGlobal.length > 1 || valueButtonObj.length > 1 ) {
    eBeat = valueButtonGlobal[1] ;
    eKick = valueButtonGlobal[2] ;
    eSnare = valueButtonGlobal[3] ;
    eHat = valueButtonGlobal[4] ;
    //meteo
    eMeteo = valueButtonGlobal[5] ;
    //dropdown typo
    whichFont(valueButtonGlobal[7]) ;
    //curtain
    eCurtain = valueButtonGlobal[10] ;
    
  
    //OBJECT
    for ( int i = 0 ; i < numObj-1 ; i++) {
      int iPlusOne = i+1 ;
      objectButton   [i +1] = valueButtonObj[i *10 +1] ;
      parameterButton[i +1] = valueButtonObj[i *10 +2] ;
      soundButton    [i +1] = valueButtonObj[i *10 +3] ;
      actionButton   [i +1] = valueButtonObj[i *10 +4] ;
      mode           [i +1] = valueButtonObj[i *10 +9] ;
      //create the boolean
      if (objectButton[iPlusOne] == 1 ) object[iPlusOne] = true ; else object[iPlusOne] = false ;
      if (parameterButton[iPlusOne] == 1 ) parameter[iPlusOne] = true ; else parameter[iPlusOne] = false ;
      if (soundButton[iPlusOne] == 1 ) sound[iPlusOne] = true ; else sound[iPlusOne] = false ;
      if (actionButton[iPlusOne] == 1 ) action[iPlusOne] = true ; else action[iPlusOne] = false ;
    }
  }
}
private PVector posSceneMouseRef, posEyeMouseRef ;
private PVector posSceneCameraRef, posEyeCameraRef ;
private PVector eyeCamera, sceneCamera ;
private PVector deltaScenePos, deltaEyePos ;
private PVector tempEyeCamera ;

private boolean newRefSceneMouse = true ;
private boolean newRefEyeMouse = true ;
//travelling
boolean gotoCameraPosition, gotoCameraEye, travellingPriority ;

//speed must be 1 or less
float speedMoveOfCamera = 0.1f ;
//CAMERA Stuff
private boolean moveScene, moveEye ;

PVector targetPosCam = new PVector(0, 0, 0) ;

//P3D STUFF
PVector speedDirectionOfObject  ;
PVector  P3DpositionMouseRef, deltaObjPos ;
PVector  P3DdirectionMouseRef, deltaObjDir, P3DtempObjDir ;


//SETUP
public void P3DSetup() {
  if(modeP3D) {
    //CAMERA
    sceneCamera = new PVector (width/2 , height/2, 0) ;
    sceneCamera = new PVector (0,0,0) ;
    eyeCamera = new PVector (0,0,0) ;
    //
    posSceneCameraRef = new PVector (0,0,0) ;
    posEyeCameraRef = new PVector (0,0,0) ;
    //
    deltaScenePos = new PVector (0,0,0) ;
    deltaEyePos = new PVector (0,0,0) ;
    //
    tempEyeCamera = new PVector(0,0,0) ;
    
    //P3D
    for ( int i = 0 ; i < numObj ; i ++ ) {
      posManipulation[i] = new PVector(0,0,0) ; 
      dirManipulation[i] = new PVector (0,0,0) ;
      P3DdirectionX [i] = 0 ;
      P3DdirectionY [i] = 0 ;
      P3DpositionObjRef[i] = new PVector(0,0,0) ; 
      P3DdirectionObjRef[i] = new PVector(0,0,0) ;
    }
    P3DpositionMouseRef = new PVector(0,0,0) ; deltaObjPos = new PVector(0,0,0) ;
    P3DdirectionMouseRef = new PVector(0,0,0) ; deltaObjDir = new PVector(0,0,0) ;

  }
}

//END SETUP




//OBJECT ORIENTATION AND POSITION, For specific object
//final direction and oriention with object ID
public void P3Dmanipulation(int ID) {
  if(modeP3D) {
    //position
    if (!clickLongLeft[0] )  P3DrefPos[0] = true ;
    P3DpositionX[ID] = P3Dposition(posManipulation[ID], ID).x ;
    P3DpositionY[ID] = P3Dposition(posManipulation[ID], ID).y ;
    P3DpositionZ[ID] = P3Dposition(posManipulation[ID], ID).z ;
    //rotation
    if (!clickLongRight[0] ) P3DrefDir[0] = true ;
      //speed rotation
    float speed = 150.0f ; // 150 is medium speed rotation
    speedDirectionOfObject = new PVector(speed /(float)width, speed /(float)height) ; 
    P3DdirectionX[ID] = P3Ddirection(dirManipulation[ID], speedDirectionOfObject, ID).x ; 
    P3DdirectionY[ID] = P3Ddirection(dirManipulation[ID], speedDirectionOfObject, ID).y ;

  }
  addRefObj(ID) ;
}

//direction
public PVector P3Ddirection(PVector dir, PVector speed, int ID) {
  //XY pos
  if(P3DrefDir[0]  ) {
    P3DdirectionObjRef[0] = dir ;
    P3DdirectionMouseRef = new PVector(mouse[0].x, mouse[0].y) ;
  }
  if(clickLongRight[0]) {
    //to create a only one ref position
    P3DrefDir[0] = false ;
    //create the delta between the ref and the mouse position
    deltaObjDir.x = mouse[0].x -P3DdirectionMouseRef.x ;
    deltaObjDir.y = mouse[0].y -P3DdirectionMouseRef.y ;
    P3DtempObjDir = PVector.add(deltaObjDir, P3DdirectionObjRef[0] ) ;
    //rotation of the camera
    dir.x += (pmouse[0].y-mouse[0].y) * speed.y;
    dir.y += (pmouse[0].x-mouse[0].x) * -speed.x;
    if(dir.x > 360 ) dir.x = 0 ;
    if(dir.x < 0  ) dir.x = 360 ;
    if(dir.y > 360 ) dir.y = 0 ; 
    if(dir.y < 0   ) dir.y = 360 ; 
  }
  return dir ;
}
//position
public PVector P3Dposition(PVector pos, int ID) {
  // XY pos
  if(P3DrefPos[0]  ) {
    P3DpositionObjRef[ID] = pos ;
    P3DpositionMouseRef = new PVector(mouse[0].x, mouse[0].y) ;
  }
  if (clickLongLeft[0]) {
    //to create a only one ref position
    P3DrefPos[0] = false ;
    //create the delta between the ref and the mouse position
    deltaObjPos.x = mouse[0].x -P3DpositionMouseRef.x ;
    deltaObjPos.y = mouse[0].y -P3DpositionMouseRef.y ;
    pos = PVector.add(deltaObjPos, P3DpositionObjRef[ID] ) ;
  }
  // Z pos
  zoom() ;
  pos.z -= getCountZoom ;
  return pos ;
}
//Create ref position
public void addRefObj(int ID) {
  if(modeP3D) {
    posManipulation[ID] = new PVector ( P3DpositionX[ID], P3DpositionY[ID],P3DpositionZ[ID]) ;
    dirManipulation[ID] = new PVector ( P3DdirectionX[ID], P3DdirectionY[ID]);
  }
}

//go to the new position
public void P3DmoveObj(int ID) {
  translate(P3DpositionX[ID], P3DpositionY[ID], P3DpositionZ[ID]) ;
  rotateX(radians(P3DdirectionX[ID])) ;
  rotateY(radians(P3DdirectionY[ID])) ;
}


//END OF P3D OBJECT ORIENTATION AND DIRECTION


//starting position
public void startPosition(int ID, int x, int y, int z) {
  //P3Dposition[ID] = new PVector(width/2 -x, height/2 -y, z) ;
  P3DpositionX[ID] = x -(width/2) ;
  P3DpositionY[ID] = y -(height/2) ;
  P3DpositionZ[ID] = z ;
  mouse[ID] = new PVector (x,y) ;
  // startingPosition[ID] = false ;
}
public void startPosition(int ID, int x, int y) {
  //P3Dposition[ID] = new PVector(width/2 -x, height/2 -y, z) ;
  P3DpositionX[ID] = x -(width/2) ;
  P3DpositionY[ID] = y -(height/2);
  // mouse[ID] = new PVector (x,y) ;
  // startingPosition[ID] = false ;
}





////////
//CAMERA
public void cameraDraw() {
  if(modeP3D) {
    //camera order
    if(clickLongLeft[0] && cLongTouch) moveScene = true ;   else moveScene = false ;
    if(clickLongRight[0] && cLongTouch) moveEye = true ;   else moveEye = false ;
    
    //void with speed setting
    float speed = 150.0f ; // 150 is medium speed rotation
    PVector speedRotation = new PVector(speed /(float)width, speed /(float)height) ; 
    //println("void cameraDraw()",clickLongLeft[0], cLongTouch, moveScene) ;
    
    startCamera(moveScene, moveEye, speedRotation) ;
    //to change the scene position with a specific point
    if(gotoCameraPosition || gotoCameraEye ) updateCamera(sceneCamera, targetPosCam, speedMoveOfCamera) ;
    
    //back to the ref position in smooth mode
    if(cLongTouch) if(enterTouch) {
      //calculate the distance and few stuffes to move the camera
      travelling(posCamRef) ;
    }
    // back to origine raw style
    if(cLongTouch) if (touch0) {
      eyeCamera = new PVector(0,0) ;
      sceneCamera = new PVector(0,0,0) ;
      gotoCameraPosition = false ;
      gotoCameraEye = false ;
    }
    //catch ref camera
    catchCameraInfo() ;
  }
}
//END CAMERA DRAW


//CATCH a ref position and direction of the camera
PVector posCamRef = new PVector(0,0,0) ;
PVector eyeCamRef = new PVector(0,0) ;
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





//startCamera with speed setting
public void startCamera(boolean scene, boolean eye, PVector speed) {
  pushMatrix() ;
  //Move the Scene
  //println("void startCamera avant", scene) ;
  if(scene) {
    //create the ref to calcul the new position of the Scene
    
    if(newRefSceneMouse) {
      posSceneCameraRef = sceneCamera ;
      posSceneMouseRef = new PVector(mouse[0].x, mouse[0].y) ;
    }
    //to create a only one ref position
    newRefSceneMouse = false ;
    //create the delta between the ref and the mouse position
    deltaScenePos.x = mouse[0].x -posSceneMouseRef.x ;
    deltaScenePos.y = mouse[0].y -posSceneMouseRef.y ;
    sceneCamera = PVector.add(deltaScenePos, posSceneCameraRef ) ;
  } else {
    //change the boolean to true for the next mousepressed
    newRefSceneMouse = true ;
  }
    
  
  //move the eye camera
  if(eye) {
    //create the ref to calcul the new position of the Scene
    if(newRefEyeMouse) {
      posEyeCameraRef = tempEyeCamera ;
      posEyeMouseRef = new PVector(mouse[0].x, mouse[0].y) ;
    }
    //to create a only one ref position
    newRefEyeMouse = false ;
    //create the delta between the ref and the mouse position
    deltaEyePos.x = mouse[0].x -posEyeMouseRef.x ;
    deltaEyePos.y = mouse[0].y -posEyeMouseRef.y ;
    tempEyeCamera = PVector.add(deltaEyePos, posEyeCameraRef ) ;

    //rotation of the camera
    //solution 2
    eyeCamera.x += (pmouse[0].y-mouse[0].y) * speed.y;
    eyeCamera.y += (pmouse[0].x-mouse[0].x) *-speed.x;
    if(eyeCamera.x > 360 ) eyeCamera.x = 0 ;
    if( eyeCamera.x < 0  ) eyeCamera.x = 360 ;
    if(eyeCamera.y > 360 ) eyeCamera.y = 0 ; 
    if(eyeCamera.y < 0   ) eyeCamera.y = 360 ; 
  } else {
    //change the boolean to true for the next mousepressed
    newRefEyeMouse = true ;
  }
  //zoom
  //zoom
  if(cLongTouch) { 
    zoom() ;
    sceneCamera.z -= getCountZoom ;
  }

  
  camera() ;
  beginCamera() ;

  //scene position
  translate(sceneCamera.x +width/2, sceneCamera.y +height/2, sceneCamera.z) ;
  //eye direction
  rotateX(radians(eyeCamera.x)) ;
  rotateY(radians(eyeCamera.y)) ;

}
//end camera with speed setting
///////////////////////////////

//UPDATE CAMERA POSITION
public void updateCamera(PVector origin, PVector target, float speed) {
  if(!moveScene) sceneCamera = (follow(origin, target, speed)) ;
  if(!moveEye && (gotoCameraPosition || gotoCameraEye)) eyeCamera = backEye()  ;
}
//stop
public void stopCamera() {
  if(modeP3D) {
    popMatrix() ;
    endCamera() ;
  }
}
//END of CAMERA move




//CHANGE the position of the CAMERA
///////////////////////////////////
//RAW
public void cameraGoto(PVector newPos ) {
  sceneCamera = newPos ;
}


//END of change position of CAMERA
//////////////////////////////////


//GET
public PVector getEyeCamera() { return eyeCamera ; }
public PVector getPosCamera() { return sceneCamera ; }




//INIT FOLLOW
float distFollowRef = 0 ;
PVector eyeBackRef = new PVector(0,0,0 ) ;
//travelling with only camera position
public void travelling(PVector target) {
  distFollowRef = PVector.dist(target, sceneCamera) ;
  
  targetPosCam = target ; 
  eyeBackRef = getEyeCamera() ;
  absPosition = new PVector(0,0,0) ;
  gotoCameraPosition = true ;
  gotoCameraEye = true ;
}


//END INIT FOLLOW

float speedX  ;
float speedY  ;
    
public PVector backEye() {
  PVector eye = new PVector(0,0) ;

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
      //speedX += .5 ;
      //speedY += .5 ;
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
  
  //reset the value and the boolean for a next move
  /*
  if(currentDistToTarget < 5 && (eye.x < 2 || eye.x > 358 )  && (eye.y < 2 || eye.y > 358 )) {
    gotoCameraEye = false ;
  */
  return eye ;
}


//MAIN VOID
PVector speedByAxes = new PVector(0,0,0) ;
//
/*
void cameraGoto(PVector newPos, float speed) {
  cameraSpeedMove = speed ;
  newDistanceToTarget = new PVector(0,0,0) ;
  distToCamera = PVector.sub(sceneCamera, newPos) ;
  speedByAxes = PVector.div(distToCamera, 1.0 / speed) ;
}
*/
//calculate new position to go at the new target camera
PVector distToTargetUpdated = new PVector (0,0,0) ;
float currentDistToTarget = 0 ;
PVector currentPosition = new PVector(0,0,0) ;
PVector absPosition = new PVector(0,0,0) ;
// PVector targetPoint ;

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





//LIGHT
///////
PVector colorAmbient = new PVector(0,0,0);
PVector colorLight = new PVector(0,0,0);
PVector dirLight = new PVector(0,0,0);

PVector speedColorLight = new PVector(0,0,0) ;
//PVector speedSpotLight = new PVector(0,0,0) ;
//SETUP
public void lightSetup() {
  if(modeP3D) {
    float min =.001f ;
    float max = 0.3f ;
    speedColorLight = new PVector(random(min,max),random(min,max),random(min,max)) ;
  }
}

//DRAW
public void lightDraw() {
  if(modeP3D) {
    //change color of the directional light
    //PVector lightValue = new PVector (map(valueSliderGlobal[6],0,100,0,360), valueSliderGlobal[7], valueSliderGlobal[8]) ;
    colorLight = new PVector (map(valueSlider[0][6],0,100,0,360), valueSlider[0][7], valueSlider[0][8]) ;
    colorAmbient = new PVector (map(valueSlider[0][9],0,100,0,360), valueSlider[0][10], valueSlider[0][11]) ;

    /*
    colorLight.x += speedColorLight.x ;
    colorLight.y += speedColorLight.y ;
    colorLight.z += speedColorLight.z ;
  
    if (colorLight.x > 360 ) colorLight.x = 0 ;
    if (colorLight.y > 100 ) colorLight.y = 0 ;
    if (colorLight.z > 100 ) colorLight.z = 0 ;

    colorAmbianceLight.x = map(mouseX, 0,width,0,360) ;
    colorAmbianceLight.y = map(mouseY, 0,height,0,100) ;
    if (mousePressed) colorAmbianceLight.z = map(mouseY, 0,height,0,100) ; else colorAmbianceLight.z = map(mouseX, 0,width,0,100) ;
    */
    
    // change the direction of the light
    dirLight.x = map(mouseX,0,width, -1,1) ;
    dirLight.y = map(mouseY,0,height, -1,1) ;
    
    //result
    romanescoLight(colorAmbient, colorLight, dirLight) ;
  }
}

//ANNEXE LIGHT VOID
public void romanescoLight(PVector colorAmbLight, PVector colorLight, PVector dir) {
  directionalLight(colorLight.x, colorLight.y, colorLight.z, dir.x, dir.y, dir.z);
  // don't use the ambiant light if you need the object color
  ambientLight(colorAmbLight.x, colorAmbLight.y, colorAmbLight.z);
}


// END LIGHT
////////////
// CLASS ROMANESCO MANAGER
public void romanescoSetup() {
  romanescoManager = new ObjectRomanescoManager(this);
  romanescoManager.addObjectRomanesco() ;
  romanescoManager.finishTheIndex() ;
}


//Update the var of the object
public void updateObject(int ID, int group) {
  //initialization
  if(!initValueMouse[ID]) { 
    mouse[ID] = mouse[0] ;
    initValueMouse[ID] = true ;
  }
  if(!initValueSlider[ID]) {
    updateParameter(ID,group ) ;
    initValueSlider[ID] = true ;
  }
  
  if(parameter[ID] ) {
    updateParameter(ID,group ) ;
  }
  updateSound(ID) ;
  
  if(action[ID] ){
    if(spaceTouch) mouse[ID] = mouse[0] ;  else mouse[ID] = mouseSuperRomanesco ;
    if( mTouch ) motion[ID] = !motion[ID] ;
    if (hTouch) horizon[ID] = !horizon[ID] ;
  }

}




//
public void updateParameter(int ID, int group) {
  for ( int i = 0 ; i <= numGroup ; i++) if( group == i ) {
    int whichOne = i-1 ;
    fillObj[ID] = fillRaw[whichOne] ;
    strokeObj[ID] = strokeRaw[whichOne] ;
    thicknessObj[ID] = thicknessRaw[whichOne] ;
    sizeXObj[ID] = sizeXRaw[whichOne] ; 
    sizeYObj[ID] = sizeYRaw[whichOne] ; 
    sizeZObj[ID] = sizeZRaw[whichOne] ;
    canvasXObj[ID] = canvasXRaw[whichOne] ; 
    canvasYObj[ID] = canvasYRaw[whichOne] ; 
    canvasZObj[ID] = canvasZRaw[whichOne] ;
    quantityObj[ID] = quantityRaw[whichOne] ;
    //column 3
    speedObj[ID] = speedRaw[whichOne] ;
    directionObj[ID] = directionRaw[whichOne] ;
    angleObj[ID] = angleRaw[whichOne] ;
    amplitudeObj[ID] = amplitudeRaw[whichOne] ;
    analyzeObj[ID] = analyzeRaw[whichOne] ; 
    familyObj[ID] = familyRaw[whichOne] ;
    lifeObj[ID] = lifeRaw[whichOne] ;
    forceObj[ID] = forceRaw[whichOne] ;
  }
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
    
    for (int i = 0 ; i <numBand ; i++) {
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
    
    for (int i = 0 ; i <numBand ; i++) {
      band[ID][i] = 1 ;
    }
  }
}


//Clear the list
public boolean emptyList(int ID) {
  boolean e = false ;
  //global delete
  if (backspaceTouch) e = true ;
  //SPECIFIC DELETE when the paramer button of contr\u00f4leur is ON
  else if (deleteTouch) if ( action[ID]) e = true ;
  return e ;
}
///////////////////////////////////////




//CLASS
// inspired from Andreas Gysin work from The Abyss Project
class ObjectRomanescoManager {
  private ArrayList<SuperRomanesco>RomanescoList ;
  private ArrayList<Class>objectRomanescoList;
  
  PApplet parent;
  String objectNameRomanesco [] ;
  String classRomanescoName [] ;
  int numClasses ;
  
  ObjectRomanescoManager(PApplet parent) {
    this.parent = parent;
    RomanescoList = new ArrayList<SuperRomanesco>() ;
    //scan the existant classes
    objectRomanescoList = scanClasses(parent, "SuperRomanesco");
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
    writeIndex() ;
    
    return classes;  
  }
  //END ADD CLASSES
  /////////////////
  
  
  
  /////////////////////////////////////////////
  //CREATE an index.csv for the objects classes
  String pathObjects = sketchPath("")+"preferences/objects/" ;
  
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
    
    // numObj = num +1 ;
    objectName = new String[num +1] ;
    objectID = new int[num +1] ;
    
    // add row
    rowIndexObject = new TableRow [num] ;
    for(int i = 0 ; i < rowIndexObject.length ; i++) {
      rowIndexObject[i] = indexObjects.addRow() ;
    }
  }
  
  // put information in the index
  public void writeIndex() {
    for(int i = 0 ; i < rowIndexObject.length ; i++) {
      rowIndexObject[i].setString("Class name", objectNameRomanesco[i]) ;
      rowIndexObject[i].setInt("Library Order", i+1) ;
    }
  }
  
  //external void
  public void finishTheIndex() {
      // catch the different parameter from object class Romanesco
    for (int i=0 ; i < RomanescoList.size() ; i++ ) {
      SuperRomanesco objR = (SuperRomanesco) RomanescoList.get(i) ;
      rowIndexObject[i].setString("Name", objR.romanescoName) ;
      rowIndexObject[i].setInt("ID", objR.IDobj) ;
      rowIndexObject[i].setInt("Group", objR.IDgroup) ;
      rowIndexObject[i].setString("Author", objR.romanescoAuthor) ;
      rowIndexObject[i].setString("Version", objR.romanescoVersion) ;
      rowIndexObject[i].setString("Render", objR.romanescoRender) ;
      rowIndexObject[i].setString("Pack", objR.romanescoPack) ;
      rowIndexObject[i].setString("Mode", objR.romanescoMode) ;
    }
    saveTable(indexObjects, pathObjects+"index_romanesco_objects.csv") ; 
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
  public SuperRomanesco addObject(int i) {
    if (i < 0 || i >= objectRomanescoList.size()) return null;
    
    SuperRomanesco f = null;
    try {
      Class c = objectRomanescoList.get(i);
      Constructor[] constructors = c.getConstructors();
      f = (SuperRomanesco) constructors[0].newInstance(parent);
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
  private void addObject(SuperRomanesco objR) {
    objR.setManagerReference(this);
    RomanescoList.add(objR);
  }
  //END ADD OBJECT
  ////////////////
  
  
  
  ////////
  //SETUP
  // INIT ROMANESCO OBJECT
  public void initObj() {
    for (SuperRomanesco objR : RomanescoList) {
      motion[objR.IDobj] = true ;
      initValueMouse [objR.IDobj] = true ;
      objR.setting() ;
    }
  }
  // END SETUP
  ////////////
  
  
  
  ////////
  // DRAW
  public void displayObject() {
    for (SuperRomanesco objR : RomanescoList) {
      if (object[objR.IDobj]) {
        updateObject(objR.IDobj, objR.IDgroup) ;
        pushMatrix() ;
        //addRefObj(objR.IDobj) ;
        if(vLongTouch && action[objR.IDobj] ) P3Dmanipulation(objR.IDobj) ;
        P3DmoveObj(objR.IDobj) ;
        objR.display() ;
        popMatrix() ;
      }
    }
  }
  // END DRAW
  //////////
}
//END OBJECT ROMANESCO MANAGER
////////////////////////
//SUPER CLASS ROMANESCO
abstract class SuperRomanesco {
  String romanescoName, romanescoAuthor, romanescoVersion, romanescoPack, romanescoRender, romanescoMode ;
  int IDobj, IDgroup ;
  //object manager return
  ObjectRomanescoManager orm ;
  
  public SuperRomanesco() {
    romanescoName = "Unknown" ;
    romanescoAuthor = "Anonymous";
    romanescoVersion = "Alpha";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
    romanescoMode = "" ; // separate the name by a slash and write the next mode immadialtly after this one.
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
/*
Romanesco Project by Stanislas Mar\u00e7ais
http://romanescoproject.wordpress.com/
http://stanislas-marcais.blogspot.fr/ 
*/

/*
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Un grand Merci \u00e0 Laetitia, ma femme pour son soutient pendant toutes ses semaines, ses mois, ses ann\u00e9es de d\u00e9veloppement
Big up and thanks to Laetitia, my wife for the support all night long, all weeks, all months, all years of coding
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

/*
Big Thanks too the Processing community : 
Daniel Shiffman for the slider, 
Marius Waltz for Reads RSS and Atom feeds, 
Philho for the advice on the Forum, 
Andres Colubri for the sender Syphon
adrock42 from the Forum Processing for the improvement of Syphon
Mark webster and their workshop.


Andreas Gysin for the creaturs from The Abyss project
Nicopt\u00e8re and 0 to 1 algorithm concept

Mais aussi,
Agnes et le Crash Lab de Mains d'\u0152uvre \u00e0 Saint-Ouen
et biensur Ivan sans lequel je n'aurais pas connu Processing
*/
// MUST BE REMOVE IN THE NEXT RELEAS, but the class is not clean and ready for that
String texte ;
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Scene_25" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
