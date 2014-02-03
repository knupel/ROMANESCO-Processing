////////////////////////////////////
//CURSOR, MOUSE, TABLET, LEAP MOTION
//GLOBAL
Tablet tablet;

//SETUP
void cursorSetup() {
  tablet = new Tablet(this);
  //mouse
  mouse[0] = new PVector(0,0) ;
  pmouse[0] = new PVector(0,0) ;
  wheel[0] = 0 ;
}


//DRAW
void cursorDraw() {
  pen[0] = new PVector (norm(tablet.getTiltX(),0,1), norm(tablet.getTiltY(),0,1), tablet.getPressure()) ;
  mouse[0] = new PVector(mouseX, mouseY ) ;
  pmouse[0] = new PVector(pmouseX, pmouseY ) ;
  wheel[0] = 0 ;
  // if( clickShortLeft[0] || clickShortRight[0] || clickLongLeft[0] || clickLongRight[0] ) mousepressed[0] = true ; else mousepressed[0] = false ;
  //re-init the mouse button for the short click
  clickShortLeft[0] = false ; 
  clickShortRight[0] = false ;
}
////////////////////////////////////////
//END CURSOR, MOUSE, TABLET, LEAP MOTION





//////////
//KEYBOARD

//short Touch
boolean aTouch, bTouch, cTouch, dTouch, eTouch, fTouch, gTouch, hTouch, iTouch, jTouch, kTouch, lTouch, mTouch, nTouch, oTouch, pTouch, qTouch, rTouch, sTouch, tTouch, uTouch, vTouch, wTouch, xTouch, yTouch, zTouch,
        leftTouch, rightTouch, upTouch, downTouch, 
        touch0, touch1, touch2, touch3, touch4, touch5, touch6, touch7, touch8, touch9, 
        backspaceTouch, deleteTouch, enterTouch, returnTouch, shiftTouch, altTouch, escTouch, ctrlTouch ;
//long touch
boolean spaceTouch, cLongTouch, nLongTouch, vLongTouch ;
        
        
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
  if (key == 'l'  || key == 'L' ) lTouch = true ;
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
  if (key == 'n'  || key == 'N' ) nLongTouch = false ;
  if (key == 'v'  || key == 'V' ) vLongTouch = false ;
}

void keyboardFalse() {
    // check for the key and put false here, but it's less reactive that put false just after the use the boolean...here you display false three time !
  //spaceTouch = false ; 
  
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






///////
//METEO
//GLOBAL
YahooWeather weather;
int updateIntervallMillis = 30000;

int sunRise, sunSet ;



//SETUP
void meteoSetup() {
  String [] md = loadStrings (sketchPath("")+"meteo.txt")  ;
  String meteoData  = join(md, "") ;
  String splitMeteoData [] = split(meteoData, '/') ;

  if (splitMeteoData[2].equals("celsius") ) weather = new YahooWeather(this, Integer.parseInt(splitMeteoData[4]), "c", updateIntervallMillis); else weather = new YahooWeather(this, Integer.parseInt(splitMeteoData[4]), "f", updateIntervallMillis) ;
}

//DRAW
void meteoDraw() {
  weather.update();

  //the sun set and the sunrise is calculate in minutes, one day is 1440 minutes, and the start is midnight
  sunRise = int(clock24(weather.getSunrise(), 1)) ;
  sunSet = int(clock24(weather.getSunset(), 1)) ;
}


//ANNEXE

//CLOCK SUN
String clock24(String t, int mode) {
  String [] split = new String [2] ;
  String [] splitTime = new String [2] ;
  String clockSunset =  t ;
  //transform clock in 24h mode, then in number (int) ;
  split = split(clockSunset, " ") ;
  splitTime = split(split[0], ":") ;
  
  int hourSunset ;
  if (split[1].equals("pm") == true ) hourSunset = int(splitTime[0]) +12 ; else hourSunset = int(splitTime[0]) ;
  
  String clock24 = (hourSunset +"h"+splitTime[1]) ;
  int m = (int(hourSunset) * 60 + int(splitTime[1])) ;
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
color meteoColor(color colorOfTheDay, int whatTimeIsIt, int speedRiseSet, int pressure) {
  color colorOfSky ;
  
  int sunrise,sunset ;
  float wPressure = map(pressure,930, 1060, 0,1) ;
  

  sunrise = int(clock24(weather.getSunrise(), 1)) ;
  sunset = int(clock24(weather.getSunset(), 1)) ;
  
  //basic 
  //if ( sunrise < whatTimeIsIt && sunset < whatTimeIsIt ) colorOfSky = bleuCiel ; else colorOfSky = bleuNuit ; 
  
  //smooth
  int minValueSat = 0 ;
  int minValueBright = 0 ;
  int maxValueSat = int(100 *wPressure) ;
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
  //println("time: " + whatTimeIsIt + " || " + sky_h + " / " + sky_s + " / " + sky_b ) ;
  
  colorOfSky = color (sky_h,sky_s,sky_b) ;
  // colorOfSky = bleuNuit ;
  
  return colorOfSky ;
}



//PRESSION
int hectoPascal(float pressureToConvert) {
  int HP ;
  if (pressureToConvert < 800 ) HP = int(pressureToConvert *33.86) ; else HP = (int)pressureToConvert ;
  return HP ;
}
//WIND FORCE
int beaufort() {
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
String windFrench() {
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
String traductionWeather(int code) {
  if (code == 0 ) { frenchWeatherDescription =  "tornade" ; }
  if (code == 1 ) { frenchWeatherDescription =  "tempête tropicale" ; }
  if (code == 2 ) { frenchWeatherDescription =  "ouragan" ; }
  if (code == 3 ) { frenchWeatherDescription =  "orage violent" ; }
  if (code == 4 ) { frenchWeatherDescription =  "orage" ; }
  if (code == 5 ) { frenchWeatherDescription =  "pluie et neige mélangées" ; }
  if (code == 6 ) { frenchWeatherDescription =  "pluie et giboulée (grelons?)" ; }
  if (code == 7 ) { frenchWeatherDescription =  "neige et giboulée (grelons?)" ; }
  if (code == 8 ) { frenchWeatherDescription =  "bruine verglassante" ; }
  if (code == 9 ) { frenchWeatherDescription =  "bruine" ; }
  if (code == 10 ) { frenchWeatherDescription =  "pluie verglassante" ; }
  if (code == 11 ) { frenchWeatherDescription =  "averses" ; }
  if (code == 12 ) { frenchWeatherDescription =  "averses" ; }
  if (code == 13 ) { frenchWeatherDescription =  "averses de neige" ; }
  if (code == 14 ) { frenchWeatherDescription =  "averses de neige légère" ; }
  if (code == 15 ) { frenchWeatherDescription =  "rafales de neige" ; }
  if (code == 16 ) { frenchWeatherDescription =  "neige" ; }
  if (code == 17 ) { frenchWeatherDescription =  "grêle" ; }
  if (code == 18 ) { frenchWeatherDescription =  "giboulée" ; }
  if (code == 19 ) { frenchWeatherDescription =  "poussière" ; }
  if (code == 20 ) { frenchWeatherDescription =  "brouillard" ; }
  if (code == 21 ) { frenchWeatherDescription =  "brume" ; }
  if (code == 22 ) { frenchWeatherDescription =  "pollué" ; }
  if (code == 23 ) { frenchWeatherDescription =  "bourrasque" ; }
  if (code == 24 ) { frenchWeatherDescription =  "venteux" ; }
  if (code == 25 ) { frenchWeatherDescription =  "froid" ; }
  if (code == 26 ) { frenchWeatherDescription =  "couvert" ; }
  if (code == 27 ) { frenchWeatherDescription =  "nuit plutôt couverte" ; }
  if (code == 28 ) { frenchWeatherDescription =  "journée plutôt couverte" ; }
  if (code == 29 ) { frenchWeatherDescription =  "nuit partiellement couverte" ; }
  if (code == 30 ) { frenchWeatherDescription =  "journée partiellement couverte" ; }
  if (code == 31 ) { frenchWeatherDescription =  "nuit dégagée" ; }
  if (code == 32 ) { frenchWeatherDescription =  "ensolleillé" ; }
  if (code == 33 ) { frenchWeatherDescription =  "nuit dégagée" ; }
  if (code == 34 ) { frenchWeatherDescription =  "journée dégagée" ; }
  if (code == 35 ) { frenchWeatherDescription =  "pluie et grêle" ; }
  if (code == 36 ) { frenchWeatherDescription =  "chaud" ; }
  if (code == 37 ) { frenchWeatherDescription =  "orages localisés" ; }
  if (code == 38 ) { frenchWeatherDescription =  "orages éparses" ; }
  if (code == 39 ) { frenchWeatherDescription =  "orages éparses" ; }
  if (code == 40 ) { frenchWeatherDescription =  "averses éparses" ; }
  if (code == 41 ) { frenchWeatherDescription =  "grosses chute de neige" ; }
  if (code == 42 ) { frenchWeatherDescription =  "chutes de neige éparses" ; }
  if (code == 43 ) { frenchWeatherDescription =  "grosses chute de neige" ; }
  if (code == 44 ) { frenchWeatherDescription =  "partiellement couvert" ; }
  if (code == 45 ) { frenchWeatherDescription =  "pluies violentes" ; }
  if (code == 46 ) { frenchWeatherDescription =  "averses de neige" ; }
  if (code == 47 ) { frenchWeatherDescription =  "pluies violentes isolées" ; }
  if (code == 3200 ) { frenchWeatherDescription =  "non répertorié" ; } 
  
  return frenchWeatherDescription ;
}
//END METEO
///////////





///////////////////////////////////////////
//TRANSLATOR INT to String, FLOAT to STRING
String joinIntToString(int []data) {
  String intString ;
  String [] dataString = new String [data.length] ;
  for ( int i = 0 ; i < data.length ; i++) dataString[i] = Integer.toString(data[i]) ;
  intString = join(dataString,"/") ;
  
  return intString ;
}

String joinFloatToString(float []data) {
  String floatString ;
  String [] dataString = new String [data.length] ;
  //for ( int i = 0 ; i < data.length ; i++) dataString[i] = Float.toString(data[i]) ;
  //we must use just one decimal after coma, to dodge the outBoundIndex blablabla
  for ( int i = 0 ; i < data.length ; i++) dataString[i] = String.format("%.1f" ,data[i]) ;
  floatString = join(dataString,"/") ;
  
  return floatString ;
}

//Translater to String
String FloatToString(float data) {
  String newData ;
  newData = String.format("%.1f", data ) ;
  return newData ;
}
//
String FloatToStringWithThree(float data) {
  String newData ;
  newData = String.format("%.3f", data ) ;
  return newData ;
}
//
String IntToString(int data) {
  String newData ;
  newData = Integer.toString(data ) ;
  return newData ;
}
//END TRANSLATOR



//////////////
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
      
String pathFont [] = new String [50] ;  
      
//SETUP
void fontSetup() {
  //write font path
  pathFont[1] = ("typo/AmericanTypewriter-96.vlw");
  pathFont[2] = ("typo/AmericanTypewriter-Bold-96.vlw");
  pathFont[3] = ("typo/BancoITCStd-Heavy-96.vlw");
  pathFont[4] = ("typo/CinquentaMilMeticais-96.vlw");
  pathFont[5] = ("typo/Container-Regular-96.vlw");
  pathFont[6] = ("typo/Diesel-96.vlw");
  pathFont[7] = ("typo/Digital2-96.vlw");
  pathFont[8] = ("typo/DIN-Regular-96.vlw");
  pathFont[9] = ("typo/DIN-Bold-96.vlw");
  pathFont[10] = ("typo/EastBlocICGClosed-96.vlw");
  pathFont[11] = ("typo/FuturaStencilICG-96.vlw");
  pathFont[12] = ("typo/FetteFraktur-96.vlw");
  pathFont[13] = ("typo/GANGBANGCRIME-96.vlw");
  pathFont[14] = ("typo/JuanitaDecoITCStd-96.vlw");
  pathFont[15] = ("typo/Komikahuna-96.vlw");
  pathFont[16] = ("typo/MesquiteStd-96.vlw");
  pathFont[17] = ("typo/NanumBrush-96.vlw");
  pathFont[18] = ("typo/RosewoodStd-Regular-96.vlw");
  pathFont[19] = ("typo/3theHardwayRMX-96.vlw");
  pathFont[20] = ("typo/Tokyo-One-96.vlw");
  pathFont[21] = ("typo/MinionPro-Regular-96.vlw");
  pathFont[22] = ("typo/MinionPro-Bold-96.vlw");
  //special font
  pathFont[49] = ("typo/DIN-Regular-10.vlw");
  
  //load
  AmericanTypewriter=loadFont      (pathFont[1]);
  AmericanTypewriterBold=loadFont  (pathFont[2]);
  Banco=loadFont                   (pathFont[3]);
  Cinquenta=loadFont               (pathFont[4]);
  ContainerRegular=loadFont        (pathFont[5]);
  Diesel=loadFont                  (pathFont[6]);
  Digital=loadFont                 (pathFont[7]);
  DinRegular=loadFont              (pathFont[8]);
  DinBold=loadFont                 (pathFont[9]);
  EastBloc=loadFont                (pathFont[10]);
  FuturaStencil=loadFont           (pathFont[11]);
  FetteFraktur=loadFont            (pathFont[12]);
  GangBangCrime=loadFont           (pathFont[13]);
  JuanitaOutline=loadFont          (pathFont[14]);
  Komikahuna=loadFont              (pathFont[15]);
  Mesquite=loadFont                (pathFont[16]);
  NanumBrush=loadFont              (pathFont[17]);
  Rosewood=loadFont                (pathFont[18]);
  TheHardwayRMX=loadFont           (pathFont[19]);
  TokyoOne=loadFont                (pathFont[20]);
  Minion=loadFont                  (pathFont[21]);
  MinionBold=loadFont              (pathFont[22]);
  
  //default and special font
  DinRegular10=loadFont            (pathFont[49]);
  font[0] = AmericanTypewriter ;
  SansSerif10 = loadFont("typo/SansSerif-10.vlw") ;
}




void whichFont (int whichFont) { 
  if (whichFont == 1 )     font[0] = AmericanTypewriter ; 
  else if (whichFont ==2 ) font[0] = AmericanTypewriterBold ;
  else if (whichFont == 3) font[0] = Banco ;
  else if (whichFont ==4)  font[0] = Cinquenta ;
  else if (whichFont ==5)  font[0] = ContainerRegular ;
  else if (whichFont ==6)  font[0] = Diesel ;
  else if (whichFont ==7)  font[0] = Digital ;
  else if (whichFont ==8)  font[0] = DinRegular ;
  else if (whichFont ==9)  font[0] = DinBold ;
  else if (whichFont ==10)  font[0] = EastBloc ;
  else if (whichFont ==11) font[0] = FetteFraktur ;
  else if (whichFont ==12) font[0] = FuturaStencil ;
  else if (whichFont ==13) font[0] = GangBangCrime ;
  else if (whichFont ==14) font[0] = JuanitaOutline ;    
  else if (whichFont ==15) font[0] = Komikahuna ;
  else if (whichFont ==16) font[0] = Mesquite ;
  else if (whichFont ==17) font[0] = Minion ;
  else if (whichFont ==18) font[0] = MinionBold ;
  else if (whichFont ==19) font[0] = NanumBrush ;
  else if (whichFont ==20) font[0] = Rosewood ;
  else if (whichFont ==21) font[0] = TheHardwayRMX ;
  else if (whichFont ==22) font[0] = TokyoOne ; 
  else font[0] = AmericanTypewriter ;
}
//END FONT
//////////




//BACKGROUND
////////////
void backgroundClassic() {
  color fond = color (map(valueSliderGlobal[0],0,100,0,360), valueSliderGlobal[1], valueSliderGlobal[2], valueSliderGlobal[3] ) ; 
  //DISPLAY FINAL
  noStroke() ;
  fill(fond ) ;
  rect (0,0, width, height) ;
}

//P3D
//BACKGROUND
////////////
void backgroundP3D() {
  color fond = color (map(valueSliderGlobal[0],0,100,0,360), valueSliderGlobal[1], valueSliderGlobal[2], valueSliderGlobal[3] ) ; 
  fill(fond) ;
  noStroke() ;
  pushMatrix() ;
  final PVector sizeBG = new PVector(width *100, height *100) ;
  translate(-sizeBG.x *.5,-sizeBG.y *.5 , -3100) ;
  rect(0,0, sizeBG.x,sizeBG.y) ;
  popMatrix() ;
}

//END BACKGROUND

//ZOOM
//with the wheel mouse
float getCountZoom ;

void zoom() {
  getCountZoom = wheel[0] ;
}
//END ZOOM

//END P3D
