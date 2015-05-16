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






int hueFillRank = 1 ;
int saturationFillRank = 2 ;
int brightnessFillRank = 3 ;
int alphaFillRank = 4 ;
int hueStrokeRank = 5 ;
int saturationStrokeRank = 6 ;
int brightnessStrokeRank = 7 ;
int alphaStrokeRank = 8 ;
int thicknessRank = 9 ;

int widthObjRank = 11 ;
int heightObjRank = 12 ;
int depthObjRank = 13 ;
int canvasXRank = 14 ;
int canvasYRank = 15 ;
int canvasZRank = 16 ;
int familyRank = 17 ;
int quantityRank = 18 ;
int lifeRank = 19 ;

int speedRank = 21 ;
int directionRank = 22 ;
int angleRank = 23 ;
int amplitudeRank = 24 ;
int attractionRank = 25 ;
int repulsionRank = 26 ;
int influenceRank = 27 ;
int alignmentRank = 28 ;
int analyzeRank = 29 ;








void setDisplaySlider() {
  setSliderDynamic() ;
  giveNameSliderUsedByObject() ;
  listSliderInterface() ;
  recoverActiveSliderFromObj() ;
  listSliderObject() ;
}

void setSliderDynamic() {
  sliderObj = new StringList [numObj +1] ;
  sliderObjRaw = new String [numObj +1] ;
  sliderObjListRaw = new String [numObj +1][NUM_SLIDER_OBJ +1] ;
  objectActive = new boolean[numObj +1] ;
  displaySlider = new boolean [NUM_GROUP_SLIDER] [NUM_SLIDER_OBJ +1] ;
}


void recoverActiveSliderFromObj() {
  sliderObjRaw[0] = ("not used") ;
  for(int i = 1 ; i <= numObj ; i++) {
    sliderObjRaw[i] = objectSlider[objectID[i]] ;
  }
}


void initVarSliderDynamic() {
  for ( int j = 1 ; j < NUM_GROUP_SLIDER ; j++) {
    showSliderGroup[j] = false ;
  }
  loadSaveSetting = false ;
}




void listSliderObject() {
  //create the String list for each object
  for ( int i = 0 ; i < sliderObj.length ; i++) {
    sliderObj[i] = new  StringList() ;
  }

  //setting the list to don't have a null value
  for (int i = 0 ; i < sliderObj.length ; i++) {
    for( int j = 0 ; j < NUM_SLIDER_OBJ ; j++ ) {
      sliderObj[i].append("") ;
    }
  }
  // had value to the slider list object
  for (int i = 0 ; i <= numObj ; i++) {
    String [] listSliderTemp = splitText(sliderObjRaw[i], (",")) ;
    for( int j = 0 ; j < NUM_SLIDER_OBJ ; j++ ) {
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


String  sliderName [] = new String[NUM_SLIDER_TOTAL +1] ;


void giveNameSliderUsedByObject() {
  sliderName[0] = ("not used") ;
  sliderName[1] = ("Hue fill") ;
  sliderName[2] = ("Saturation fill") ;
  sliderName[3] = ("Brightness fill") ;
  sliderName[4] = ("Alpha fill") ;
  sliderName[5] = ("Hue stroke") ;
  sliderName[6] = ("Saturation stroke") ;
  sliderName[7] = ("Brightness stroke") ;
  sliderName[8] = ("Alpha stroke") ;
  sliderName[9] = ("Thickness") ;
  sliderName[10] = ("not used") ;

  sliderName[11] = ("Width") ;
  sliderName[12] = ("Height") ;
  sliderName[13] = ("Depth") ;
  sliderName[14] = ("Canvas X") ;
  sliderName[15] = ("Canvas Y") ;
  sliderName[16] = ("Canvas Z") ;
  sliderName[17] = ("Family") ;
  sliderName[18] = ("Quantity") ;
  sliderName[19] = ("Life") ;
  sliderName[20] = ("not used") ;

  sliderName[21] = ("Speed") ;
  sliderName[22] = ("Direction") ;
  sliderName[23] = ("Angle") ;
  sliderName[24] = ("Amplitude") ;
  sliderName[25] = ("Attraction") ;
  sliderName[26] = ("Repulsion") ;
  sliderName[27] = ("Alignment") ;
  sliderName[28] = ("Influence") ;
  sliderName[29] = ("Analyze") ;
  sliderName[30] = ("not used") ;
}


void listSliderInterface() {
  for(int i = 0 ; i <NUM_SLIDER_TOTAL ; i++) {
    sliderControler.append(sliderName[i]) ;
  }
}



// DRAW
void checkSliderObject() {
   checkObjectOnOff() ;
   whichSliderMustBeDisplay() ;
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
      for(int j = 0 ; j <NUM_SLIDER_OBJ ; j++) {
        displaySlider[i][j] = false ;
      }
    }
   
    //active slider
    int IDgroup = 0 ;
     if (showAllSliders) {
      for ( int i = 1 ; i < NUM_GROUP_SLIDER ; i++) {
        for ( int j = 1 ; j < NUM_SLIDER_OBJ ; j++) {
        displaySlider[i][j] = true ;
        }
      }
    } else {
      for ( int i = 1 ; i <= numObj ; i++) {
        if (objectActive[i]) {
          for (int j = 1 ; j < NUM_GROUP_SLIDER ; j++) {
           if (objectGroup[i] == j) { IDgroup = j ;
              for(int k = 1 ; k < NUM_SLIDER_OBJ ; k++) {
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



// CHOICE which slider must be display after checking the keyboard
void whichSliderMustBeDisplay() {
  switch(sliderModeDisplay) {
    case 0 : 
    resetSlider = true ;
    showAllSliders = true ;
    break ;
    case 1 : 
    resetSlider = true ;
    showAllSliders = false ;
    allSliderUsed = true ;
    break ;
    case 2 : 
    resetSlider = true ;
    showAllSliders = false ;
    allSliderUsed = false ;
    break ;
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
  
  if(activityParameter) resetSlider = true ;
  activityParameter = false ;
}
