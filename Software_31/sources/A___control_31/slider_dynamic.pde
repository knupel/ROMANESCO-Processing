/**
Slider_dynamic
v 2.0.2.1
*/
StringList slider_item_controller = new StringList();

StringList [] sliders_by_item;
String [] sliders_by_item_raw;

String [][] slider_inventory_item_raw;
boolean [] item_active;
boolean [] display_slider;

boolean reset_slider_item = true;
boolean show_all_slider_item_active = false;
boolean show_all_slider_item = false;

//these sliders name are not used for the interface but for the display analyze slider
// col 1
int hue_fill_rank = 0;
int sat_fill_rank = 1;
int bright_fill_rank = 2;
int alpha_fill_rank = 3;

int hue_stroke_rank = 4;
int sat_stroke_rank = 5;
int bright_stroke_rank = 6;
int alpha_stroke_rank = 7;
int thickness_rank = 8;

int size_x_rank = 9;
int size_y_rank = 10;
int size_z_rank = 11;

int font_size_rank = 12;

int canvas_x_rank = 13;
int canvas_y_rank = 14;
int canvas_z_rank = 15;

// col 2
int reactivity_rank = 16;

int speed_x_rank = 17;
int speed_y_rank = 18;
int speed_z_rank = 19;

int spurt_x_rank = 20;
int spurt_y_rank = 21;
int spurt_z_rank = 22;

int dir_x_rank = 23;
int dir_y_rank = 24;
int dir_z_rank = 25;

int jitter_x_rank = 26;
int jitter_y_rank = 27;
int jitter_z_rank = 28;

int swing_x_rank = 29;
int swing_y_rank = 30;
int swing_z_rank = 31;

// col 3
int quantity_rank = 32;
int variety_rank = 33;

int life_rank = 34;
int flow_rank = 35;
int quality_rank = 36;

int area_rank = 37;
int angle_rank = 38;
int scope_rank = 39;
int scan_rank = 40;

int alignment_rank = 41;
int repulsion_rank = 42;
int attraction_rank = 43;
int density_rank = 44;

int influence_rank = 45;
int calm_rank = 46;
int spectrum_rank = 47;







void set_display_slider() {
  set_dynamic_slider() ;
  list_item_slider_gui() ;
  recover_active_slider_from_item() ;
  list_slider_item() ;
}

void set_dynamic_slider() {
  sliders_by_item = new StringList [NUM_ITEM +1];
  sliders_by_item_raw = new String [NUM_ITEM +1];

  slider_inventory_item_raw = new String [NUM_ITEM +1][NUM_SLIDER_ITEM +1] ;
  item_active = new boolean [NUM_ITEM +1] ;
  display_slider = new boolean [NUM_SLIDER_ITEM +1] ;
}


void recover_active_slider_from_item() {
  sliders_by_item_raw[0] = ("not used") ;
  for(int i = 1 ; i <= NUM_ITEM ; i++) {
    sliders_by_item_raw[i] = item_slider[item_ID[i]] ;
  }
}






void list_slider_item() {
  //create the String list for each item
  for ( int i = 0 ; i < sliders_by_item.length ; i++) {
    sliders_by_item[i] = new StringList() ;
  }

  // setting the list to don't have a null value
  for (int i = 0 ; i < sliders_by_item.length ; i++) {
    for( int j = 0 ; j <= NUM_SLIDER_ITEM ; j++ ) {
      sliders_by_item[i].append("") ;
    }
  }
  // add value to item slider list
  for (int i = 1 ; i <= NUM_ITEM ; i++) {
    String [] temp = split_text(sliders_by_item_raw[i], (",")) ;
    for(int j = 0 ; j < NUM_SLIDER_ITEM ; j++) {
      for (int k = 0 ; k < temp.length ; k++) {
        if(temp[k].equals(slider_item_controller.get(j))) {
          sliders_by_item[i].set(j,temp[k]);
        } else if(temp[k].equals("all") ) {
          sliders_by_item[i].set(j,"all") ;
        }
      }
    }
  }
}




void list_item_slider_gui() {
  for(int i = 0 ; i < NUM_SLIDER_ITEM ; i++) {
    slider_item_controller.append(slider_item_name[i]) ;
  }
}



// DRAW
void check_slider_item() {
  check_item_parameter_on_off() ;
  which_slider_display() ;
  //check if the slider must be display
  if (reset_slider_item) {
    // use this boolean to have a boolean slider true, if don't use thi boolean no onr slider can be true and active
    boolean firstCheck = true ; 
    //reset slider for new check
    for(int i = 0 ; i < NUM_SLIDER_ITEM ; i++) {
      display_slider[i] = false;
    }
    //active slider item
    if (show_all_slider_item) {
      for (int i = 0 ; i < NUM_SLIDER_ITEM ; i++) {
        display_slider[i] = true;
      }
    } else {
      for (int i = 1 ; i <= NUM_ITEM ; i++) {
        if (item_active[i]) {
          for(int k = 0 ; k < NUM_SLIDER_ITEM ; k++) {
            if (firstCheck) {
              if((slider_item_controller.get(k).equals(sliders_by_item[i].get(k)) || sliders_by_item[i].get(k).equals("all"))) {
                display_slider[k] = true; 
              } else {
                display_slider[k] = false;
              }
            } else {
              if (!show_all_slider_item_active) {
                if((slider_item_controller.get(k).equals(sliders_by_item[i].get(k)) || sliders_by_item[i].get(k).equals("all")) && display_slider[k]) {
                  display_slider[k] = true; 
                } else {
                  display_slider[k] = false;
                }
              } else if (show_all_slider_item_active) {
                if (!display_slider[k]) {
                  if (slider_item_controller.get(k).equals(sliders_by_item[i].get(k)) || sliders_by_item[i].get(k).equals("all")) {
                    display_slider[k] = true;
                  } 
                } 
                /*
                else {
                  display_slider[IDgroup][k] = false;
                }
                */
              }
            }
          }
          firstCheck = false ;
        }
      }
    }
    reset_slider_item = false ;  
  }
}



// CHOICE which slider must be display after checking the keyboard
void which_slider_display() {
  switch(slider_mode_display) {
    case 0 : 
    reset_slider_item = true ;
    show_all_slider_item = true ;
    break ;
    case 1 : 
    reset_slider_item = true;
    show_all_slider_item = false;
    show_all_slider_item_active = true;
    break ;
    case 2 : 
    reset_slider_item = true ;
    show_all_slider_item = false ;
    show_all_slider_item_active = false ;
    break ;
  }
}


void check_item_parameter_on_off() {
  boolean button_is = false;
  boolean witness_activity_is = false;
  boolean parameter_activity_is = false;
  for(int i = 0 ; i < NUM_ITEM ; i++ ) {
    int whichOne = i*BUTTON_ITEM_CONSOLE +1;
    witness_activity_is = button_is;
    if (item_button_state[whichOne]) {
      item_active[i+1] = true;
      if(mousePressed) {
        button_is = !button_is;
      }
    } else { 
      item_active[i+1] = false;
      if(mousePressed) {
        button_is = !button_is;
      }     
    }
    //check ctivity
    if(witness_activity_is != button_is) {
      parameter_activity_is = true;
    }
  }
  if(parameter_activity_is) {
    reset_slider_item = true;
  }
}
