// HIGH VAR
int numBand = 16 ;
int numSliderFamilly = 40 ; // slider by familly object (global, object, trame, typo)

int numSliderGlobal = 14 ;
int numSlider = 30 ;

int numButtonGlobal = 50 ;
int numButtonObj  ;

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
color objectFill[]  ;



//OSC VAR


// button
int eBeat, eKick, eSnare, eHat, eCurtain, eMeteo ;
int objectButton []  ;
int soundButton []  ;
int actionButton[]  ;
int parameterButton[]  ;
boolean object[]  ;
boolean sound[]  ;
boolean action[]  ;
boolean parameter[]  ;

int modeButton[]  ;

//BUTTON
int valueButtonGlobal[] = new int[numButtonGlobal] ;
int valueButtonObj[] = new int[numButtonObj] ;

//SLIDER
String valueSliderTempGlobal[]  = new String [numSliderGlobal] ;
String valueSliderTempObj[]  = new String [numSlider] ;
String valueSliderTempTex[]  = new String [numSlider] ;
String valueSliderTempTypo[]  = new String [numSlider] ;

float valueSliderGlobal[]  = new float [numSliderGlobal] ;
float valueSliderObj[]  = new float [numSlider] ;
float valueSliderTex[]  = new float [numSlider] ;
float valueSliderTypo[]  = new float [numSlider] ;


//MISC
//var to init the data of the object when is switch ON for the first time
boolean initValueSlider [] = new boolean [numObj]  ;
boolean initValueMouse [] = new boolean [numObj]  ;
//parameter for the super class
float left[] ;
float right[] ;
float mix[] ;
//beat
float beat[] ;
float kick[] ;
float snare[] ;
float hat[] ;
// spectrum
float band[][] ;
//tempo
float tempo[] ;
float tempoBeat[] ;
float tempoKick[] ;
float tempoSnare[] ;
float tempoHat[] ;
//meteo
PVector motionMeteo[] ; // direction, speed
int tempMeteo [] ;
int humidityMeteo [] ;
int pressureMeteo [] ;
float visibilityMeteo [] ;

//P3D OBJECT
//position
//position
boolean startingPosition [] ;
PVector startingPos [] ;
PVector P3Dposition [] ;
PVector P3DpositionObjRef [] ;
boolean P3DrefPos [] ;
//orientation
PVector P3Ddirection [] ;
PVector P3DdirectionObjRef [] ;
boolean P3DrefDir [] ;

//position of object and wheel
PVector mouse[] ;
PVector pmouse[] ;
boolean clickShortLeft[] ;
boolean clickShortRight[] ;
boolean clickLongLeft[] ;
boolean clickLongRight[] ;
boolean mousepressed[] ;
int wheel[] ;
//pen info
PVector pen[] ;
//boolean clear
boolean clearList[] ;
//motion object
boolean motion []  ;
//main font for each object
PFont font[]  ;
String pathFontObjTTF[] ;













//init var
void initVarObject() {
  numObj = romanescoManager.numClasses + 1 ;
  //BUTTON CONTROLER
  numButtonObj = numObj*10 ;

  // button
  objectButton = new int [numObj] ;
  soundButton = new int [numObj] ;
  actionButton = new int [numObj] ;
  parameterButton = new int [numObj] ;
  object = new boolean [numObj] ;
  sound = new boolean [numObj] ;
  action = new boolean [numObj] ;
  parameter = new boolean [numObj] ;
  modeButton = new int [numObj] ;
  
  valueButtonGlobal = new int[numButtonGlobal] ;
  valueButtonObj = new int[numButtonObj] ;
  //SLIDER
  valueSliderTempGlobal  = new String [numSliderGlobal] ;
  valueSliderTempObj  = new String [numSlider] ;
  valueSliderTempTex  = new String [numSlider] ;
  valueSliderTempTypo  = new String [numSlider] ;
  
  valueSliderGlobal  = new float [numSliderGlobal] ;
  valueSliderObj  = new float [numSlider] ;
  valueSliderTex  = new float [numSlider] ;
  valueSliderTypo  = new float [numSlider] ;
  
  //MISC
  //var to init the data of the object when is switch ON for the first time
   initValueSlider = new boolean [numObj]  ;
   initValueMouse = new boolean [numObj]  ;
  //parameter for the super class
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
  //meteo
   motionMeteo = new PVector[numObj]  ; // direction, speed
   tempMeteo = new int [numObj] ;
   humidityMeteo = new int [numObj] ;
   pressureMeteo = new int [numObj] ;
   visibilityMeteo = new float [numObj] ;
  
  //P3D OBJECT
  //position
  //position
   startingPosition = new boolean[numObj] ;
   startingPos = new PVector[numObj] ;
   P3Dposition = new PVector[numObj] ;
   P3DpositionObjRef = new PVector[numObj] ;
   P3DrefPos = new boolean[numObj] ;
  //orientation
   P3Ddirection = new PVector[numObj] ;
   P3DdirectionObjRef = new PVector[numObj] ;
   P3DrefDir = new boolean[numObj] ;
  
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
  //boolean clear
   clearList = new boolean[numObj] ;
  //motion object
   motion = new boolean [numObj]  ;
  //main font for each object
   font = new PFont[numObj] ;
   pathFontObjTTF = new String[numObj] ;

  
  //VAR object
  objectFill = new color[numObj] ;
}


// UPDATE DATA from CONTROLER and PRESCENE
void updateData() {
  //from controler
  objectFill[0] = color(map(valueSliderObj[0],0,100,0,360), valueSliderObj[1], valueSliderObj[2], valueSliderObj[3]) ;
}
