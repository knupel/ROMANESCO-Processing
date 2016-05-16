// Tab: B_Slider_dynamic
StringList slider_item_controller = new StringList() ;

StringList [] slider_item  ;
String [] slider_item_raw  ;

String [][] slider_item_list_raw  ;
boolean [] item_active ;
boolean [][] display_slider  ;

boolean [] showSliderGroup = new boolean[NUM_GROUP_SLIDER] ;

boolean resetSlider = true ;
boolean allSliderUsed = false ;
boolean showAllSliders = false ;

//these sliders name are not used for the interface but for the display analyze slider





// col 1
int hue_fill_rank = 1 ;
int sat_fill_rank = 2 ;
int bright_fill_rank = 3 ;
int alpha_fill_rank = 4 ;

int hue_stroke_rank = 5 ;
int sat_stroke_rank = 6 ;
int bright_stroke_rank = 7 ;
int alpha_stroke_rank = 8 ;
int thickness_rank = 9 ;

int size_x_rank = 10 ;
int size_y_rank = 11 ;
int size_z_rank = 12 ;

int font_size_rank = 13 ;

int canvas_x_rank = 14 ;
int canvas_y_rank = 15 ;
int canvas_z_rank = 16 ;


// col 2
int reactivity_rank = 17 ;

int speed_x_rank = 18 ;
int speed_y_rank = 19 ;
int speed_z_rank = 20 ;

int spurt_x_rank = 21 ;
int spurt_y_rank = 22 ;
int spurt_z_rank = 23 ;

int dir_x_rank = 24 ;
int dir_y_rank = 25 ;
int dir_z_rank = 26 ;

int jitter_x_rank = 27 ;
int jitter_y_rank = 28 ;
int jitter_z_rank = 29 ;

int swing_x_rank = 30 ;
int swing_y_rank = 31 ;
int swing_z_rank = 32 ;

// col 3
int quantity_rank = 33 ;
int variety_rank = 34 ;

int life_rank = 35 ;
int flow_rank = 36 ;
int quality_rank = 37 ;

int area_rank = 38 ;
int angle_rank = 39 ;
int scope_rank = 40 ;
int scan_rank = 41 ;

int alignment_rank = 42 ;
int repulsion_rank = 43 ;
int attraction_rank = 44 ;
int charge_rank = 45 ;

int influence_rank = 46 ;
int calm_rank = 47 ;
int need_rank = 48 ;







void set_display_slider() {
  setSliderDynamic() ;
  list_item_slider_gui() ;
  recover_active_slider_from_item() ;
  list_slider_item() ;
}

void setSliderDynamic() {
  slider_item = new StringList [NUM_ITEM +1] ;
  slider_item_raw = new String [NUM_ITEM +1] ;
  slider_item_list_raw = new String [NUM_ITEM +1][NUM_SLIDER_ITEM +1] ;
  item_active = new boolean[NUM_ITEM +1] ;
  display_slider = new boolean [NUM_GROUP_SLIDER] [NUM_SLIDER_ITEM +1] ;
}


void recover_active_slider_from_item() {
  slider_item_raw[0] = ("not used") ;
  for(int i = 1 ; i <= NUM_ITEM ; i++) {
    slider_item_raw[i] = item_slider[item_ID[i]] ;
  }
}


void init_slider_dynamic() {
  for ( int j = 1 ; j < NUM_GROUP_SLIDER ; j++) {
    showSliderGroup[j] = false ;
  }
  LOAD_SETTING = false ;
}




void list_slider_item() {
  //create the String list for each item
  for ( int i = 0 ; i < slider_item.length ; i++) {
    slider_item[i] = new StringList() ;
  }

  //setting the list to don't have a null value
  for (int i = 0 ; i < slider_item.length ; i++) {
    for( int j = 0 ; j <= NUM_SLIDER_ITEM ; j++ ) {
      slider_item[i].append("") ;
    }
  }
  // had value to the slider list object
  for (int i = 1 ; i <= NUM_ITEM ; i++) {
    String [] listSliderTemp = split_text(slider_item_raw[i], (",")) ;
    for( int j = 0 ; j < NUM_SLIDER_ITEM ; j++ ) {
      for ( int k = 0 ; k < listSliderTemp.length ; k++ ) {
        if(listSliderTemp[k].equals(slider_item_controller.get(j))) {
          slider_item[i].set(j,listSliderTemp[k]) ;
        } else if(listSliderTemp[k].equals("all") ) {
          slider_item[i].set(j,"all") ;
        }
      }
    }
  }
}




void list_item_slider_gui() {
  for(int i = 0 ; i <= NUM_SLIDER_ITEM ; i++) {
    slider_item_controller.append(slider_item_name[i]) ;
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
      for ( int i = 1 ; i <= NUM_SLIDER_ITEM ; i++) {
        display_slider[1][i] = true ;
      }
    } else {
      for ( int i = 1 ; i <= NUM_ITEM ; i++) {
        if (item_active[i]) {
          IDgroup = 1 ;
          for(int j = 1 ; j <= NUM_SLIDER_ITEM ; j++) {
            if (firstCheck[1])  {
              if((slider_item_controller.get(j).equals(slider_item[i].get(j)) || slider_item[i].get(j).equals("all"))) {
                display_slider[IDgroup][j] = true ; 
              } else display_slider[IDgroup][j] = false ;
            } else {
              if (!allSliderUsed) { 
                if((slider_item_controller.get(j).equals(slider_item[i].get(j)) || slider_item[i].get(j).equals("all")) && display_slider[IDgroup][j]) {
                  display_slider[IDgroup][j] = true ; 
                } else {
                  display_slider[IDgroup][j] = false ;
                }
              } else if (allSliderUsed) {
                if (!display_slider[IDgroup][j]) if (slider_item_controller.get(j).equals(slider_item[i].get(j)) || slider_item[i].get(j).equals("all")) {
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
