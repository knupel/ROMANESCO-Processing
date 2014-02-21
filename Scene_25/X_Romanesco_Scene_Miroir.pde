//GLOBAL


//var to init the data of the object when is switch ON for the first time, one boolean foer the slider and an other one for the mouse...
boolean initValueSlider [] = new boolean [numObj +1]  ;
boolean initValueMouse [] = new boolean [numObj +1]  ;
//parameter for the super class
float gauche[]  = new float [numObj +1] ;
float droite[] = new float [numObj +1] ;
float mix[]  = new float [numObj +1] ;
//beat
float beat[]  = new float [numObj +1] ;
float kick[]  = new float [numObj +1] ;
float snare[]  = new float [numObj +1] ;
float hat[]  = new float [numObj +1] ;
// spectrum
float band[][] = new float [numObj +1][numBand] ;
//tempo
float tempo[] = new float [numObj +1] ;
float tempoBeat[] = new float [numObj +1] ;
float tempoKick[] = new float [numObj +1] ;
float tempoSnare[] = new float [numObj +1] ;
float tempoHat[] = new float [numObj +1] ;
//meteo
PVector motionMeteo[] = new PVector[numObj +1]  ; // direction, speed
int tempMeteo [] = new int [numObj +1] ;
int humidityMeteo [] = new int [numObj +1] ;
int pressureMeteo [] = new int [numObj +1] ;
float visibilityMeteo [] = new float [numObj +1] ;

//P3D OBJECT
//position
boolean startingPosition [] = new boolean[numObj +1] ;
PVector startingPos [] = new PVector[numObj +1] ;
PVector P3Dposition [] = new PVector[numObj + 1] ;
PVector P3DpositionObjRef [] = new PVector[numObj + 1] ;
boolean P3DrefPos [] = new boolean[numObj +1] ;
//orientation
PVector P3Ddirection [] = new PVector[numObj + 1] ;
PVector P3DdirectionObjRef [] = new PVector[numObj + 1] ;
boolean P3DrefDir [] = new boolean[numObj +1] ;

//position of object and wheel
PVector mouse[]    = new PVector[numObj +1] ;
PVector pmouse[]    = new PVector[numObj +1] ;
boolean clickShortLeft[] = new boolean [numObj +1] ;
boolean clickShortRight[] = new boolean [numObj +1] ;
boolean clickLongLeft[] = new boolean [numObj +1] ;
boolean clickLongRight[] = new boolean [numObj +1] ;
boolean mousepressed[] = new boolean [numObj +1] ;
int wheel[] = new int [numObj + 1] ;
//pen info
PVector pen[]    = new PVector[numObj +1] ;
//boolean clear
boolean clearList[] = new boolean[numObj+1] ;
//motion object
boolean motion [] = new boolean [numObj +1]  ;
//to add new object
// boolean newObj[] = new boolean[numObj+1] ;
//main font for each object
PFont font[] = new PFont[numObj+1] ;
String pathFontObjTTF[] = new String[numObj+1] ;




////////////
//SUPER CLASS
class SuperRomanesco
{
  int IDobj ;
  float valueObj[][]  = new float[numObj] [numSliderFamilly] ;
  
  SuperRomanesco (int IDobj) {
    this.IDobj = IDobj ;
  }
  
  
  //DRAW
  void data(String [] d, String [] soundData) {
    
    float newWindDirection ;
    
    if ( mainButton[IDobj] == 1  ) {
      ///////////////////
      ///GLOBAL
      if ( parameterButton[IDobj] == 1 || !initValueSlider[IDobj] ) {
        for (int i = 1 ; i < d.length ; i++) valueObj[IDobj][i]  = float(d[i]) ;
        //after the first init, we don't need to init again the color when the setting button is off, so we say the init is true
        initValueSlider[IDobj] = true ;
      }
      
      //SOUND
      if (soundButton[IDobj] == 1 ) {
        
        beat[IDobj] = float(soundData[3]) ; 
        kick[IDobj] =  float(soundData[4]) ; 
        snare[IDobj] = float(soundData[5]) ; 
        hat[IDobj] = float(soundData[6]) ;
         //tempo
        tempo[IDobj] = getTempoRef() ;
        tempoKick[IDobj] = getTempoKickRef() ;
        tempoSnare[IDobj] = getTempoSnareRef() ;
        tempoHat[IDobj] = getTempoHatRef() ;
        //volume security value
        if (gauche[IDobj] == 0 ) gauche[IDobj] = 0.01 ;
        if (droite[IDobj] == 0 ) droite[IDobj] = 0.01 ;
        if (mix[IDobj] == 0 ) mix[IDobj] = 0.01 ;
        gauche[IDobj] = float(soundData[0]) ; droite[IDobj] = float(soundData[1]) ; mix[IDobj] = float(soundData[2]) ;
                //spectrum
        for ( int i = 0 ; i < numBand ; i++) {
          band [IDobj][i] = float(soundData[10 + i]) ;
        }
      } else {
        gauche[IDobj] = .05 ; droite[IDobj] = .05 ;  mix[IDobj] = .05 ;
        beat[IDobj] = 1.0 ; kick[IDobj] = 1.0 ; snare[IDobj] = 1.0 ; hat[IDobj] = 1.0 ;
        tempo[IDobj] = 1.0 ; tempoKick[IDobj] = 1.0 ; tempoSnare[IDobj] = 1.0 ; tempoHat[IDobj] = 1.0 ;
      }
      
      //ACTION
      if (actionButton[IDobj] == 1) {
        // motion
        if( mTouch ) motion[IDobj] = !motion[IDobj] ;
        // mouse
        clickShortLeft[IDobj]  = clickShortLeft[0] ;
        clickShortRight[IDobj] = clickShortRight[0] ;
        clickLongLeft[IDobj]  = clickLongLeft[0] ;
        clickLongRight[IDobj] = clickLongRight[0] ;
        mousepressed[IDobj] = mousepressed[0] ;
        if (spaceTouch || !initValueMouse[IDobj]) {
          pen[IDobj] = pen[0] ; 
          mouse[IDobj] = PVector.sub(mouse[0],startingPos[IDobj]) ;
          pmouse[IDobj] = PVector.sub(pmouse[0],startingPos[IDobj]) ;
          wheel[IDobj] = wheel[0] ;
        } else {
         //the object start at the good place when the object is open at the first time !
         //mouse[IDobj] = mouseSuperRomanesco ;
         //pmouse[IDobj] = pmouseSuperRomanesco ;
         mouse[IDobj] = PVector.sub(mouseSuperRomanesco, startingPos[IDobj]) ;
         pmouse[IDobj] = PVector.sub(pmouseSuperRomanesco, startingPos[IDobj]) ;
         // the pressure of pen is between 0 and 1, so we must give a value in case if there is no pressure,
         // when the user go away from the space touch for the tilt no problem is stay in memory
         if (pen[IDobj].z == 0.0 ) pen[IDobj].z = 1.0 ;
        }
      }
      //METEO
      if(meteoButton[IDobj] == 1 ) {
        //meteo
        newWindDirection = weather.getWindDirection() +180  ;
        if (newWindDirection > 360 ) newWindDirection -= 360 ;
        motionMeteo[IDobj] = new PVector(newWindDirection, beaufort())  ; // direction, speed
        tempMeteo [IDobj] = weather.getTemperature() ;
        humidityMeteo [IDobj] =weather.getHumidity()  ;
        pressureMeteo [IDobj] = hectoPascal(weather.getPressure())  ;
        visibilityMeteo [IDobj] = weather.getVisibleDistance() ;
      } else {
        motionMeteo[IDobj] = new PVector(-1,-1)  ; // direction, speed
        tempMeteo [IDobj] = -274 ;
        humidityMeteo [IDobj] = -1 ; ;
        pressureMeteo [IDobj] = -1 ;
        visibilityMeteo [IDobj] = -1 ;
      }
      initValueMouse[IDobj] = true ;
      //END
    }
  }
}
////////////////////////
//END OF SUPER ROMANESCO

       
