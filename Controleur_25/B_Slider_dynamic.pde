StringList sliderControler = new StringList() ;

StringList [] sliderObj  ;
String [] sliderObjRaw  ;

String [][] sliderObjListRaw  ;
boolean [] objectActive ;
boolean [][] displaySlider  ;

boolean [] showSliderGroup = new boolean[NUM_GROUP_SLIDER] ;

boolean resetSlider = true ;
boolean allSliderUsed = false ;
boolean showAllSliders = false ;

//these sliders name are not used for the interface but for the display analyze slider
String hueFill = ("Hue fill") ;
String saturationFill = ("Saturation fill") ;
String brightnessFill = ("Brightness fill") ;
String alphaFill = ("Alpha fill") ;
String hueStroke = ("Hue stroke") ;
String saturationStroke = ("Saturation stroke") ;
String brightnessStroke = ("Brightness stroke") ;
String alphaStroke = ("Alpha stroke") ;
String thickness = ("Thickness") ;
String widthObj = ("Width") ;
String heightObj = ("Height") ;
String depthObj = ("Depth") ;
String canvasX = ("Canvas X") ;
String canvasY = ("Canvas Y") ;
String canvasZ = ("Canvas Z") ;
String quantity = ("Quantity") ;
String speed = ("Speed") ;
String direction = ("Direction") ;
String angle = ("Angle") ;
String amplitude = ("Amplitude") ;
String analyze = ("Analyze") ;
String family = ("Family") ;
String life = ("Life") ;
String force = ("Force") ;


int hueFillRank = 1 ;
int saturationFillRank = 2 ;
int brightnessFillRank = 3 ;
int alphaFillRank = 4 ;
int hueStrokeRank = 5 ;
int saturationStrokeRank = 6 ;
int brightnessStrokeRank = 7 ;
int alphaStrokeRank = 8 ;

int thicknessRank = 11 ;
int widthObjRank = 12 ;
int heightObjRank = 13 ;
int depthObjRank = 14 ;
int canvasXRank = 15 ;
int canvasYRank = 16 ;
int canvasZRank = 17 ;
int quantityRank = 18 ;

int speedRank = 21 ;
int directionRank = 22 ;
int angleRank = 23 ;
int amplitudeRank = 24 ;
int analyzeRank = 25 ;
int familyRank = 26 ;
int lifeRank = 27 ;
int forceRank = 28 ;






void setDisplaySlider() {
  setSliderDynamic() ;
  listSliderInterface() ;
  recoverActiveSliderFromObj() ;
  listSliderObject() ;
}

void setSliderDynamic() {
  sliderObj = new StringList [numObj +1] ;
  sliderObjRaw = new String [numObj +1] ;
  sliderObjListRaw = new String [numObj +1][SLIDER_BY_GROUP +1] ;
  objectActive = new boolean[numObj +1] ;
  displaySlider = new boolean [NUM_GROUP_SLIDER] [SLIDER_BY_GROUP +1] ;
}


void recoverActiveSliderFromObj() {
  sliderObjRaw[0] = ("not used") ;
  for(int i = 1 ; i <= numObj ; i++) {
    sliderObjRaw[i] = objectSlider[objectID[i]] ;
  }
}


void initVarSliderDynamic() {
  loadSliderPos = false ; 
  for ( int j = 1 ; j < NUM_GROUP_SLIDER ; j++) {
    showSliderGroup[j] = false ;
  }
}




void listSliderObject() {
  //create the String list for each object
  for ( int i = 0 ; i < sliderObj.length ; i++) {
    sliderObj[i] = new  StringList() ;
  }

  //setting the list to don't have a null value
  for (int i = 0 ; i < sliderObj.length ; i++) {
    for( int j = 0 ; j < SLIDER_BY_GROUP ; j++ ) {
      sliderObj[i].append("") ;
    }
  }
  // had value to the slider list object
  for (int i = 0 ; i <= numObj ; i++) {
    String [] listSliderTemp = splitText(sliderObjRaw[i], (",")) ;
    for( int j = 0 ; j < SLIDER_BY_GROUP ; j++ ) {
      for ( int k = 0 ; k < listSliderTemp.length ; k++ ) {
        if(listSliderTemp[k].equals(sliderControler.get(j))) {
          sliderObj[i].set(j,listSliderTemp[k]) ;
        } else if(listSliderTemp[k].equals("all") ) {
          sliderObj[i].set(j,"all") ;
        }
      }
    }
  }
}



void listSliderInterface() {
  sliderControler.append("not used") ;
  // col one
  sliderControler.append(hueFill) ;
  sliderControler.append(saturationFill) ;
  sliderControler.append(brightnessFill) ;
  sliderControler.append(alphaFill) ;
  sliderControler.append(hueStroke) ;
  sliderControler.append(saturationStroke) ;
  sliderControler.append(brightnessStroke) ;
  sliderControler.append(alphaStroke) ;
  sliderControler.append("not used") ;
  sliderControler.append("not used") ;
  // col two
  sliderControler.append(thickness) ;
  sliderControler.append(widthObj) ;
  sliderControler.append(heightObj) ;
  sliderControler.append(depthObj) ;
  sliderControler.append(canvasX) ;
  sliderControler.append(canvasY) ;
  sliderControler.append(canvasZ) ;
  sliderControler.append(quantity) ;
  sliderControler.append("not used") ;
  sliderControler.append("not used") ;
  // col three
  sliderControler.append(speed) ;
  sliderControler.append(direction) ;
  sliderControler.append(angle) ;
  sliderControler.append(amplitude) ;
  sliderControler.append(analyze) ;
  sliderControler.append(family) ;
  sliderControler.append(life) ;
  sliderControler.append(force) ;
  sliderControler.append("not used") ;
  sliderControler.append("not used") ;
}



// DRAW
void checkSlider() {
   checkObjectOnOff() ;
   // check the group slider
   for ( int i = 1 ; i <= numObj ; i++) {
    if (objectActive[i]) {
      showSliderGroup[objectGroup[i]] = true ;
    }
  }
  
  
  
   //check if the slider must be display
  if (resetSlider) {
    // use this boolean to have a boolean slider true, if don't use thi boolean no onr slider can be true and active
    boolean [] firstCheck = new boolean [NUM_GROUP_SLIDER] ; // true ;
    //reset slider for new check
    for(int i = 1 ; i < NUM_GROUP_SLIDER ; i++) {
      firstCheck [i] = true ;
      for(int j = 0 ; j <SLIDER_BY_GROUP ; j++) {
        displaySlider[i][j] = false ;
      }
    }
   
    //active slider
    int IDgroup = 0 ;
     if (showAllSliders) {
      for ( int i = 1 ; i < NUM_GROUP_SLIDER ; i++) {
        for ( int j = 1 ; j < SLIDER_BY_GROUP ; j++) {
        displaySlider[i][j] = true ;
        }
      }
    } else {
      for ( int i = 1 ; i <= numObj ; i++) {
        if (objectActive[i]) {
          for (int j = 1 ; j < NUM_GROUP_SLIDER ; j++) {
           if (objectGroup[i] == j) { IDgroup = j ;
              for(int k = 1 ; k < SLIDER_BY_GROUP ; k++) {
                if (firstCheck[j])  {
                  if((sliderControler.get(k).equals(sliderObj[i].get(k)) || sliderObj[i].get(k).equals("all"))) displaySlider[IDgroup][k] = true ; else displaySlider[IDgroup][k] = false ;
                } else {
                  if (!allSliderUsed) { 
                    if((sliderControler.get(k).equals(sliderObj[i].get(k)) || sliderObj[i].get(k).equals("all")) && displaySlider[IDgroup][k]) displaySlider[IDgroup][k] = true ; else displaySlider[IDgroup][k] = false ;
                  } else if (allSliderUsed) {
                    if (!displaySlider[IDgroup][k]) if (sliderControler.get(k).equals(sliderObj[i].get(k)) || sliderObj[i].get(k).equals("all")) displaySlider[IDgroup][k] = true ; else displaySlider[IDgroup][k] = false ;
                  }
                }
              }
            }
          }
        }
        // wait the first cross of active object to change
        if (objectActive[i]) firstCheck[IDgroup] = false ;
      }
    }
    
   
    
    //firstCheck = false ;
    resetSlider = false ;  
  }
}


boolean activityButtonParameter, witnessActivity, activityParameter ; 

void checkObjectOnOff() {
  for(int i = 0 ; i < numGroup[1] ; i++ ) {
    int whichOne = i*10 +2 ;
    witnessActivity = activityButtonParameter ;
    if (EtatBOf[whichOne] == 1) {
      objectActive[i+1] = true ; 
      if(mousePressed)  activityButtonParameter = !activityButtonParameter ;
    } else { 
      objectActive[i+1] = false ;
      if(mousePressed) activityButtonParameter = !activityButtonParameter  ;
      
    }
    //check ctivity
    if(witnessActivity != activityButtonParameter ) activityParameter = true ;
  }
  for(int i = 0 ; i < numGroup[2] ; i++ ) {
    int whichOne = i*10 +2 ;
    if (EtatBTf[whichOne] == 1) { 
      objectActive[i +numGroup[1] +1] = true ; 
      if(mousePressed)  activityButtonParameter = !activityButtonParameter ;
      } else { 
      objectActive[i+numGroup[1] +1] = false ; 
      if(mousePressed)  activityButtonParameter = !activityButtonParameter ;
    }
  }
  for(int i = 0 ; i < numGroup[3] ; i++ ) {
    int whichOne = i*10 +2 ;
    if (EtatBTYf[whichOne] == 1) {
      objectActive[i +numGroup[1] +numGroup[2] +1] = true ; 
      if(mousePressed)  activityButtonParameter = !activityButtonParameter ;
    } else { 
      objectActive[i +numGroup[1] +numGroup[2] +1] = false ;
      if(mousePressed)  activityButtonParameter = !activityButtonParameter ;
    }
  }
  
  if(activityParameter) resetSlider = true ;
  activityParameter = false ;
}
