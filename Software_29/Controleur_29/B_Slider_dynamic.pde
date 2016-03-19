// Tab: B_Slider_dynamic
StringList sliderControler = new StringList() ;

StringList [] slider_item  ;
String [] slider_item_raw  ;

String [][] slider_itemListRaw  ;
boolean [] item_active ;
boolean [][] display_slider  ;

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
  slider_item = new StringList [NUM_ITEM +1] ;
  slider_item_raw = new String [NUM_ITEM +1] ;
  slider_itemListRaw = new String [NUM_ITEM +1][NUM_SLIDER_ITEM +1] ;
  item_active = new boolean[NUM_ITEM +1] ;
  display_slider = new boolean [NUM_GROUP_SLIDER] [NUM_SLIDER_ITEM +1] ;
}


void recoverActiveSliderFromObj() {
  slider_item_raw[0] = ("not used") ;

  for(int i = 1 ; i <= NUM_ITEM ; i++) {
    slider_item_raw[i] = item_slider[item_ID[i]] ;
  }
}


void init_sliderDynamic() {
  for ( int j = 1 ; j < NUM_GROUP_SLIDER ; j++) {
    showSliderGroup[j] = false ;
  }
  loadSaveSetting = false ;
}




void listSliderObject() {
  //create the String list for each object
  for ( int i = 0 ; i < slider_item.length ; i++) {
    slider_item[i] = new  StringList() ;
  }

  //setting the list to don't have a null value
  for (int i = 0 ; i < slider_item.length ; i++) {
    for( int j = 0 ; j < NUM_SLIDER_ITEM ; j++ ) {
      slider_item[i].append("") ;
    }
  }
  // had value to the slider list object
  for (int i = 0 ; i <= NUM_ITEM ; i++) {
    String [] listSliderTemp = splitText(slider_item_raw[i], (",")) ;
    for( int j = 0 ; j < NUM_SLIDER_ITEM ; j++ ) {
      for ( int k = 0 ; k < listSliderTemp.length ; k++ ) {
        if(listSliderTemp[k].equals(sliderControler.get(j))) {
          slider_item[i].set(j,listSliderTemp[k]) ;
        } else if(listSliderTemp[k].equals("all") ) {
          slider_item[i].set(j,"all") ;
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

  sliderName[11] = ("Size X") ;
  sliderName[12] = ("Size Y") ;
  sliderName[13] = ("Size Z") ;
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
void check_slider_item() {
   check_item_parameter_on_off() ;
   whichSliderMustBeDisplay() ;
   // check the group slider
   for ( int i = 1 ; i <= NUM_ITEM ; i++) {
    if (item_active[i]) {
      showSliderGroup[item_group[i]] = true ;
    }
  }
  
  
  
   //check if the slider must be display
  if (resetSlider) {
    // use this boolean to have a boolean slider true, if don't use thi boolean no onr slider can be true and active
    boolean [] firstCheck = new boolean [NUM_GROUP_SLIDER] ; // true ;
    //reset slider for new check
    for(int i = 1 ; i < NUM_GROUP_SLIDER ; i++) {
      firstCheck [i] = true ;
      for(int j = 0 ; j < NUM_SLIDER_ITEM ; j++) {
        display_slider[i][j] = false ;
      }
    }
   
    //active slider
    int IDgroup = 0 ;
     if (showAllSliders) {
      for ( int i = 1 ; i < NUM_SLIDER_ITEM ; i++) {
        display_slider[1][i] = true ;
      }
    } else {
      for ( int i = 1 ; i <= NUM_ITEM ; i++) {

        if (item_active[i]) {
          IDgroup = 1 ;
          for(int j = 1 ; j < NUM_SLIDER_ITEM ; j++) {
            if (firstCheck[1])  {
              if((sliderControler.get(j).equals(slider_item[i].get(j)) || slider_item[i].get(j).equals("all"))) {
                display_slider[IDgroup][j] = true ; 
              } else display_slider[IDgroup][j] = false ;
            } else {
              if (!allSliderUsed) { 
                if((sliderControler.get(j).equals(slider_item[i].get(j)) || slider_item[i].get(j).equals("all")) && display_slider[IDgroup][j]) {
                  display_slider[IDgroup][j] = true ; 
                } else {
                  display_slider[IDgroup][j] = false ;
                }
              } else if (allSliderUsed) {
                if (!display_slider[IDgroup][j]) if (sliderControler.get(j).equals(slider_item[i].get(j)) || slider_item[i].get(j).equals("all")) {
                  display_slider[IDgroup][j] = true ; 
                } else {
                  display_slider[IDgroup][j] = false ;
                }
              }
            }
          }
        }

        // wait the first cross of active object to change
        if (item_active[i]) firstCheck[IDgroup] = false ;
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

void check_item_parameter_on_off() {
  for(int i = 0 ; i < NUM_ITEM ; i++ ) {
    int whichOne = i*10 +2 ;
    witnessActivity = activityButtonParameter ;
    if (on_off_item_console[whichOne] == 1) {
      item_active[i+1] = true ;
      if(mousePressed)  activityButtonParameter = !activityButtonParameter ;
    } else { 
      item_active[i+1] = false ;
      if(mousePressed) activityButtonParameter = !activityButtonParameter  ;
      
    }
    //check ctivity
    if(witnessActivity != activityButtonParameter ) activityParameter = true ;
  }

  
  if(activityParameter) resetSlider = true ;
  activityParameter = false ;
}
