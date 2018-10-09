// CLASS ROMANESCO
abstract class Romanesco {
    String romanescoName, romanescoAuthor, romanescoVersion, romanescoPack, romanescoMode, romanescoSlider ;
    int IDobj, IDgroup ;
    public Romanesco() {
    romanescoName = "Unknown" ;
    romanescoAuthor = "Anonymous";
    romanescoVersion = "Alpha";
    romanescoPack = "Base" ;
    romanescoMode = "" ; // separate the name by a slash and write the next mode immadialtly after this one.
    romanescoSlider = "all" ;
    IDgroup = 0 ;
    IDobj = 0 ;
  }
  abstract void setting();
  abstract void display();
}







// ROMANESCO STUFF
// ROMANESCO Parameter
// int IDobj = 0 ;
boolean fullRendering = true ;
int numObj = 50 ;
// 
int speedWheel = 5 ;

/*
int widthOfYourSketch = 400 ;
int heightOfYourSketch = 400 ;
color colorBackground = 0 ;
*/
String [] objectInfo  ;


void startPosition(int ID, float x,float y, float z) {
  posObj[ID] = new PVector(x,y) ;
}




void romanescoBasicSetting() {
  colorMode(HSB,360,100,100,100) ;
  romanesco_application_var() ;
  romanesco_framework_var() ;
  // event
  initVar() ;
}



// ROMANESCO VAR
//////////////////////////////


color [] fillObj, strokeObj ;
float [] thicknessObj ;
float [] sizeXObj, sizeYObj, sizeZObj ;
float [] canvasXObj, canvasYObj, canvasZObj ;
float [] familyObj, lifeObj, quantityObj ;
float [] speedObj, directionObj, angleObj ;
float [] amplitudeObj, attractionObj, repulsionObj ;
float [] analyzeObj, influenceObj, alignmentObj ;

PImage [] img ;
PVector [] posObj, mouse ;
int [] wheel ;

// option
int [] mode ;
// must be delete in the future
int [] whichImage ;

boolean []  action ;
boolean [] parameter ;
boolean []  motion ;
boolean []  sound ;
boolean displayInfo ;
boolean motion_on_off = true ;
boolean sound_on_off = true ;

// key touch
boolean  vTouch, mTouch,  iTouch,  backspaceTouch, deleteTouch ;
// other touch
boolean aTouch,bTouch,cTouch,dTouch,eTouch,fTouch,gTouch,jTouch,kTouch,lTouch,
        oTouch,pTouch,qTouch,sTouch,tTouch,uTouch,wTouch,yTouch,zTouch,
        rTouch, xTouch, hTouch, nTouch ;
        


// sound
// Volume
float [] left, right, mix ;
// Beat
float []beat, kick, snare, hat ; 
// Tempo
float [] tempo, tempoBeat, tempoKick, tempoSnare, tempoHat ;
int NUM_BANDS = 16 ;
float band[][] ;
// mouse
boolean [] clickShortLeft, clickShortRight, clickLongLeft, clickLongRight;


// var framework
boolean touchNum[]  ;
boolean showObj[] ;
boolean moveCamera = true ;


float allBeats(int ID) {
  return (beat[ID]*.25) +(kick[ID]*.25) +(hat[ID]*.25) +(snare[ID]*.25) ;
}



void romanesco_framework_var() {
    touchNum = new boolean[10] ;
    showObj = new boolean[10] ;
    touchNum[0] = true ;
}

void romanesco_application_var() {
  objectInfo = new String[numObj] ;
    // slider
  fillObj = new color[numObj] ; // 360,100,100,100
  strokeObj = new color[numObj] ; // 360,100,100,100
  thicknessObj = new float[numObj] ; // 0.1 > height/3
  
  sizeXObj = new float[numObj] ; // 0.1 > width
  sizeYObj = new float[numObj] ; // 0.1 > width
  sizeZObj = new float[numObj] ; // 0.1 > width
  canvasXObj = new float[numObj] ; // width/10 > width
  canvasYObj = new float[numObj] ; // width/10 > width
  canvasZObj = new float[numObj] ; // width/10 > width
  familyObj= new float[numObj] ; // 0 > 1
  quantityObj = new float[numObj] ; // 0 > 1
  lifeObj = new float[numObj] ; // 0 > 1
  
  speedObj = new float[numObj] ;  // 0 > 1
  directionObj= new float[numObj] ; // 0 > 360
  angleObj = new float[numObj] ; // 0 > 360
  amplitudeObj = new float[numObj] ; // 0 > 1
  attractionObj = new float[numObj] ; // 0 > 1
  repulsionObj = new float[numObj] ; // 0 > 1
  influenceObj = new float[numObj] ; // 0 > 1
  alignmentObj = new float[numObj] ; // 0 > 1
  analyzeObj = new float[numObj] ; // 0 > 1
  
  // option
  mode = new int[numObj] ;
  action = new boolean[numObj] ;
  motion = new boolean[numObj] ;
  sound = new boolean[numObj] ;
  parameter = new boolean[numObj] ;
  // mouse parameter
  clickShortLeft = new boolean[numObj] ;
  clickShortRight = new boolean[numObj] ;
  clickLongLeft = new boolean[numObj] ;
  clickLongRight = new boolean[numObj] ;

  
  // misc
  img = new PImage[numObj] ;
  posObj = new PVector[numObj] ;
  mouse = new PVector[numObj] ;
  wheel = new int[numObj] ;
  
  // must be delete in the future
  whichImage = new int[numObj] ;
  
  // sound
  left = new float[numObj] ;
  right= new float[numObj] ;
  mix = new float[numObj] ;
  // Beat
  beat= new float[numObj] ;
  kick= new float[numObj] ;
  snare= new float[numObj] ; 
  hat = new float[numObj] ; 
  // Tempo
  tempo= new float[numObj] ;
  tempoBeat= new float[numObj] ;
  tempoKick= new float[numObj] ;
  tempoSnare= new float[numObj] ;
  tempoHat= new float[numObj] ;
  //
  band = new float [numObj][NUM_BANDS] ;
}


void initVar() {
  for(int i = 0 ; i < numObj ; i++) {
    motion[i] = true ;
    action[i] = true ;
    posObj[i] = new PVector() ;
    mouse[i] = new PVector(width/2, height/2) ;
  }
}





void updtate_global_var() {
  mouse[0] = new PVector(mouseX,mouseY) ;
}



// update var obj
void updateRomanesco() {
  update_keyboard_true() ;
  update_sound() ;
  update_button_and_mode() ;
  update_mouse_event() ;
  update_obj() ;
  update_info() ;
  // the method are here to can use the true in the object Romanesco
  update_keyboard_false() ;
}





// annexe method update
void update_obj() {
    // update the object
  pushMatrix() ;
  translate(posObj[0].x,posObj[0].y) ;
  display_your_obj() ;
  popMatrix() ;
}
void update_info() {
    // display info
  int posY = 1 ;
  if(!displayInfo) {
    for (int i = 0 ; i < numObj ; i++) {
      if(objectInfo[i] != null) {
        posY += 1 ;
        fill(255) ;
        text("ID " + i + " / " + objectInfo[i],10 , height - (11*posY)  );
      }
    }
  }
}
//
void update_mouse_event() {
    // update mouse parameter
  for(int i = 0 ; i < numObj ; i++ ) {
    clickLongLeft[i] = clickLongLeft[0] ;
    clickLongRight[i] = clickLongRight[0] ;
    clickShortLeft[i] = clickShortLeft[0] ;
    clickShortRight[i] = clickShortRight[0] ;
    mouse[i] = mouse[0].copy() ;
    wheel[i] = wheel[0] ;
  }
  clickShortLeft[0] = false ; 
  clickShortRight[0] = false ;
}
//
void update_button_and_mode() {
    //update parameter
  for (int i = 0 ; i<numObj ;i++) {
    motion[i] = motion_on_off ;
    sound[i] = sound_on_off  ;
    parameter[i] = true ;
    if(keyPressed) {
      for(int j = 0 ; j <  touchNum.length ; j++) {
        if(touchNum[j]) mode[i] = j ;
      }
    }
  }
}
//
void update_sound() {
    // update sound parameter
  for (int i = 0 ; i<numObj ;i++) {
    if(sound[i]) {
      left[i]  = left[0] ;// value(0,1)
      right[i] = right[0] ;//float value(0,1)
      mix[i]  = mix[0] ;//   is average volume between the left and the right / float value(0,1)
      
      beat[i] = beat[0] ;//    is beat : value 1,10 
      kick[i] = kick[0] ;//   is beat kick : value 1,10 
      snare[i] = snare [0] ;//   is beat snare : value 1,10 
      hat[i]  = hat[0] ;//   is beat hat : value 1,10 
  
      tempo[i]   = tempo[0] ;     // global speed of track  / float value(0,1)
      tempoBeat[i] = tempoBeat[0] ;  // speed of track calculate on the beat
      tempoKick[i] = tempoKick[0] ; // speed of track calculate on the kick
      tempoSnare[i] = tempoSnare[0] ;// speed of track calculate on the snare
      tempoHat[i] = tempoHat[0] ;// speed of track calculte on the hat
      
      for (int j = 0 ; j <NUM_BANDS ; j++) {
        band[i][j] = band[0][j] ;
      }
    } else {
      left[i]  = 1 ;// value(0,1)
      right[i] = 1 ;//float value(0,1)
      mix[i]  = 1 ;//   is average volume between the left and the right / float value(0,1)
      
      beat[i] = 1 ;//    is beat : value 1,10 
      kick[i] = 1 ;//   is beat kick : value 1,10 
      snare[i] = 1 ;//   is beat snare : value 1,10 
      hat[i]  = 1 ;//   is beat hat : value 1,10 
      
      tempo[i]   = 1 ;     // global speed of track  / float value(0,1)
      tempoBeat[i] = 1 ;  // speed of track calculate on the beat
      tempoKick[i] = 1 ; // speed of track calculate on the kick
      tempoSnare[i] = 1 ;// speed of track calculate on the snare
      tempoHat[i] = 1 ;// speed of track calculte on the hat
      
      for (int j = 0 ; j <NUM_BANDS ; j++) {
        band[i][j] = 1 ;
      }
    }
  }
}


// update keyboard
void update_keyboard_false() {
  nTouch = false ;
  vTouch = false ;
}

void update_keyboard_true() {
    // give an idea to what's happen in Romanesco
  if (keyPressed) {
    if (key == 'n' ) nTouch = true ;
    if (key == 'r' ) rTouch = true ;
    if (key == 'x' ) xTouch = true ;
    if (key == 'h' ) hTouch = true ;
    
    // for the user
    if (key == 'a' ) aTouch = true ;
    if (key == 'b' ) bTouch = true ;
    if (key == 'c' ) cTouch = true ;
    if (key == 'd' ) dTouch = true ;
    if (key == 'e' ) eTouch = true ;
    if (key == 'f' ) fTouch = true ;
    if (key == 'g' ) gTouch = true ;
    if (key == 'j' ) jTouch = true ;
    if (key == 'k' ) kTouch = true ;
    if (key == 'l' ) lTouch = true ;
    if (key == 'o' ) oTouch = true ;
    if (key == 'p' ) pTouch = true ;
    if (key == 'q' ) qTouch = true ;
    if (key == 's' ) sTouch = true ;
    if (key == 't' ) tTouch = true ;
    if (key == 'u' ) uTouch = true ;
    if (key == 'w' ) wTouch = true ;
    if (key == 'y' ) yTouch = true ;
    if (key == 'z' ) zTouch = true ;
   /**
   Cause problem with the peasycam must be resolve in the future
   */
   //  if (key == 'v' ) vTouch = true ;    
  }
  
  // update var for the fake rendering
  // if(iTouch) displayInfo = true ; else displayInfo = false ;
     /**
   vTouch Cause problem with the peasycam must be resolve in the future
   */
   /*
  if(vTouch) {
    for(int i = 0 ; i < numObj ; i++) posObj[i] = new PVector(mouseX, mouseY) ;
  }
  */
}

// FAKE METHOD
///////////////////////////////////////////////////////////
// we must use to simulate the behavior of the application
// must be delete in the future
void loadImg(int ID) {
}


int timeTrack  ;
//RETURN
float getTimeTrack() {
  float t ; 
  timeTrack += millis() % 10 ;
  t = timeTrack *.01 ;
  return round( t * 10.0f ) / 10.0f; 
}


boolean resetAction(int ID) {
  boolean e = false ;
  //global delete
  // if (backspaceTouch || deleteTouch) e = true ;
 // if (deleteTouch) e = true ;
  if (backspaceTouch || deleteTouch ) e = true ;
  backspaceTouch = false ;
  deleteTouch = false ;
  return e ;
}

void reset_keyboard() {
  nTouch = false ;
  vTouch = false ;
  rTouch = false ;
  xTouch = false ;
  hTouch = false ;
  // for user
  aTouch = false ;
  bTouch = false ;
  cTouch = false ;
  dTouch = false ;
  eTouch = false ;
  fTouch = false ;
  gTouch = false ;
  jTouch = false ;
  kTouch = false ;
  lTouch = false ;
  oTouch = false ;
  pTouch = false ;
  qTouch = false ;
  sTouch = false ;
  tTouch = false ;
  uTouch = false ;
  wTouch = false ;
  yTouch = false ;
  zTouch = false ;
}

// END FAKE METHODE
///////////////////