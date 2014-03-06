// HIGH VAR
boolean modeP3D = true ;
//spectrum band
int numBand = 16 ;
int numSliderFamilly = 40 ; // slider by familly object (global, object, trame, typo)
//quantity of group object slider
int numGroup = 3 ;

int numSliderGroupZero = 14 ;
int numSlider = 30 ;

int numButtonGroupZero = 50 ;
int numButtonGroupObj  ;

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
color fillRaw[], strokeRaw[] ;
float thicknessRaw[] ; 
PVector sizeRaw[], canvasRaw[] ;
float speedRaw[], forceRaw[], orientationRaw[], angleRaw[] ;
float familyRaw[], quantityRaw[], lifeRaw[] , analyzeRaw[], amplitudeRaw[];
//add in the next version when there is 30 slider by group
float curveRaw[], attractionRaw[] ;

//object
color fillObj[], strokeObj[] ;
float thicknessObj[] ;
PVector sizeObj[], canvasObj[] ;
float speedObj[], forceObj[], orientationObj[], angleObj[] ;
float familyObj[], quantityObj[], lifeObj[] , analyzeObj[], amplitudeObj[];
//add in the next version when there is 30 slider by group
float curveObj[], attractionObj[] ;
//font
PFont police ;



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
int valueButtonGroupZero[] = new int[numButtonGroupZero] ;
int valueButtonGroupObj[] = new int[numButtonGroupObj] ;

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
boolean initValueSlider [] = new boolean [numObj]  ;
// boolean initValueMouse [] = new boolean [numObj]  ;
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
void createVar() {
  numObj = romanescoManager.numClasses + 1 ;
  //BUTTON CONTROLER
  numButtonGroupObj = numObj*10 ;

  createVarButton() ;
  //createVarSlider() ;
  createVarSound() ;
  createVarP3D() ;
  createVarCursor() ;
  createVarObject() ;
  
  //boolean clear
   clearList = new boolean[numObj] ;
  //motion object
   motion = new boolean [numObj]  ;
  //main font for each object
   font = new PFont[numObj] ;
   pathFontObjTTF = new String[numObj] ;
     //MISC
  //var to init the data of the object when is switch ON for the first time
   //initValueSlider = new boolean [numObj]  ;
   //initValueMouse = new boolean [numObj]  ;
}

//init void
// var cursor
void createVarCursor() {
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
void createVarP3D() {
  startingPosition = new boolean[numObj] ;
   startingPos = new PVector[numObj] ;
   P3Dposition = new PVector[numObj] ;
   P3DpositionObjRef = new PVector[numObj] ;
   P3DrefPos = new boolean[numObj] ;
  //orientation
   P3Ddirection = new PVector[numObj] ;
   P3DdirectionObjRef = new PVector[numObj] ;
   P3DrefDir = new boolean[numObj] ;
}

void createVarSound() {
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
/*
void createVarSlider() {
  //valueSliderTempGroup = new String [numGroup] [numSlider] ;
  valueSliderTempGroupZero  = new String [numSliderGroupZero] ;
  valueSliderTempGroupOne  = new String [numSlider] ;
  valueSliderTempGroupTwo  = new String [numSlider] ;
  valueSliderTempGroupThree  = new String [numSlider] ;
  
  valueSliderGlobal  = new float [numSliderGroupZero] ;
  valueSliderGroupOne  = new float [numSlider] ;
  valueSliderGroupTwo  = new float [numSlider] ;
  valueSliderGroupThree  = new float [numSlider] ;
}
*/
//
void createVarButton() {
  objectButton = new int [numObj] ;
  soundButton = new int [numObj] ;
  actionButton = new int [numObj] ;
  parameterButton = new int [numObj] ;
  object = new boolean [numObj] ;
  sound = new boolean [numObj] ;
  action = new boolean [numObj] ;
  parameter = new boolean [numObj] ;
  modeButton = new int [numObj] ;
  
  valueButtonGroupZero = new int[numButtonGroupZero] ;
  valueButtonGroupObj = new int[numButtonGroupObj] ;
}

void createVarObject() {
    // VAR raw 
  fillRaw = new color[numObj] ;
  strokeRaw = new color[numObj] ;
  // column 1
  thicknessRaw = new float[numObj] ; ;
  sizeRaw = new PVector[numObj] ; ;
  canvasRaw = new PVector[numObj] ;
  quantityRaw = new float[numObj] ;
  //column 3
  speedRaw = new float[numObj] ;
  orientationRaw = new float[numObj] ;
  angleRaw = new float[numObj] ;
  amplitudeRaw = new float[numObj] ;
  analyzeRaw = new float[numObj] ;
  familyRaw = new float[numObj] ;
  lifeRaw = new float[numObj] ;
  forceRaw = new float[numObj] ;
  
  // VAR object
  fillObj = new color[numObj] ;
  strokeObj = new color[numObj] ;
  // column 2
  thicknessObj = new float[numObj] ; ;
  sizeObj = new PVector[numObj] ; ;
  canvasObj = new PVector[numObj] ; ;
  quantityObj = new float[numObj] ;
   //column 3
  speedObj = new float[numObj] ;
  orientationObj = new float[numObj] ;
  angleObj = new float[numObj] ;
  amplitudeObj = new float[numObj] ;
  analyzeObj = new float[numObj] ;
  familyObj = new float[numObj] ;
  lifeObj = new float[numObj] ;
  forceObj = new float[numObj] ;
  
  //init the PVector
  for (int i = 0 ; i < numObj ; i++) {
    sizeRaw[i] = new PVector(0,0,0 ) ;
    canvasRaw[i] = new PVector(0,0,0) ;
    sizeObj[i] = new PVector(0,0,0 ) ;
    canvasObj[i] = new PVector(0,0,0) ;
  }
}
// END CREATE VAR
//////////////////


// UPDATE DATA from CONTROLER and PRESCENE
void updateVar() {
  //from column 1
  //fill
  for(int i = 0 ; i < numGroup ; i++) {
    
    //column 1
    //println(i, numObj) ;
    fillRaw[i] = color(map(valueSlider[i+1][0],0,100,0,360), valueSlider[i+1][1], valueSlider[i+1][2], valueSlider[i+1][3]) ;
    
    strokeRaw[i] = color(map(valueSlider[i+1][4],0,100,0,360), valueSlider[i+1][5], valueSlider[i+1][6], valueSlider[i+1][7]) ;

    //column 2
    int minSource = 0 ;
    int maxSource = 100 ;
    float minSize = .1 ;
    thicknessRaw[i] = map(valueSlider[i+1][10],minSource,maxSource,minSize, (height*.33)) ;
    sizeRaw[i].x = map(valueSlider[i+1][11],minSource,maxSource,minSize,width) ;
    sizeRaw[i].y = map(valueSlider[i+1][12],minSource,maxSource,minSize,width) ;
    sizeRaw[i].z = map(valueSlider[i+1][13],minSource,maxSource,minSize,width) ;
    canvasRaw[i].x = map(valueSlider[i+1][14],minSource,maxSource,0,width) ;
    canvasRaw[i].y = map(valueSlider[i+1][15],minSource,maxSource,0,height) ;
    canvasRaw[i].z = map(valueSlider[i+1][16],minSource,maxSource,0,width) ;
    quantityRaw[i] = map(valueSlider[i+1][17], minSource, maxSource,1,200) ;
    //column 3
    speedRaw[i] = valueSlider[i+1][20] ;
    orientationRaw[i] = map(valueSlider[i+1][21],minSource, maxSource,0,360) ;
    angleRaw[i] = map(valueSlider[i+1][22],minSource, maxSource,0,360) ;
    amplitudeRaw[i] = map(valueSlider[i+1][23],minSource, maxSource,1,height) ;
    analyzeRaw[i] = valueSlider[i+1][24] ;
    familyRaw[i] = map(valueSlider[i+1][25],minSource, maxSource,1,240) ;
    lifeRaw[i] = valueSlider[i+1][26] +1 ;
    forceRaw[i] = valueSlider[i+1][27] +1 ;
  }
}




