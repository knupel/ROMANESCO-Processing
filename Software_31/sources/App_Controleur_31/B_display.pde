/**
display and design
v 0.0.2
2018-2018
*/

/**
display structure background
*/
int thickness_line_deco = 2 ;
void display_structure() {
  noStroke();
  iVec2 pos = iVec2(0,0);
  iVec2 size = iVec2(width, height_header);
  display_structure_header(pos,size,rougeFonce);

  pos.set(0, pos_y_button_top);
  size.set(width,height_button_top);
  display_structure_top_button(pos,size,r.GRAY_1,jauneOrange);

  pos.set(0, pos_y_dropdown_top);
  size.set(width, height_dropdown_top);
  display_structure_dropdown_menu_general(pos,size,r.GRAY_1,jauneOrange);

  pos.set(0,pos_y_menu_general);
  size.set(width,height_menu_general);
  display_structure_general(pos,size,r.GRAY_1,r.GRAY_3);
  
  pos.set(0, pos_y_item_selected);
  size.set(width, height_item_selected);
  display_structure_item_selected(pos,size,r.GRAY_1,jauneOrange);

  pos.set(0, pos_y_inventory);
  size.set(width, height);
  display_structure_inventory_item(pos,size,r.GRAY_1,r.GRAY_3);

  display_structure_bottom(jauneOrange,rougeFonce);
}




void display_structure_header(iVec2 pos, iVec2 size, int colour_bg) {
  fill(colour_bg); 
  rect(pos,size);
}

void display_structure_top_button(iVec2 pos, iVec2 size, int colour_bg, int colour_line) {
  fill(colour_bg); 
  rect(pos,size); 

  fill(colour_line) ;
  rect(pos.x,pos.y,size.x,thickness_line_deco) ;
}

void display_structure_dropdown_menu_general(iVec2 pos, iVec2 size, int colour_bg, int colour_line) {
  fill(colour_bg); 
  rect(pos,size);
  // decoration 
  fill (colour_line) ;
  rect(pos.x,pos.y,size.x,thickness_line_deco) ;
}

void display_structure_general(iVec2 pos, iVec2 size, int colour_bg, int colour_line) {
  fill(colour_bg); 
  rect(pos,size);
}

void display_structure_menu_sound(iVec2 pos, iVec2 size, int colour_bg, int colour_line) {
  fill(colour_bg) ;
  rect(pos,size); 
  // decoration
  fill(colour_line);
  rect(pos.x,pos.y,size.x,thickness_line_deco); 
}

void display_structure_item_selected(iVec2 pos, iVec2 size, int colour_bg, int colour_line) {
  fill(colour_bg);
  rect(pos,size); 
  // decoration
  fill(colour_line);
  rect(pos.x,pos.y,size.x,thickness_line_deco); 
}

void display_structure_inventory_item(iVec2 pos, iVec2 size, int colour_bg, int colour_line) {
  fill(colour_bg);
  rect(pos,size); 
}


void display_structure_bottom(int colour_a, int colour_b) {
  // bottom decoration
  fill(colour_a);
  rect(0,height-9,width,2);
  fill(colour_b);
  rect(0,height-7,width,7);
}


void display_text() {
  if(insideNameversion) fill (jaune) ; else fill(orange) ;
  int posTextY = 18 ;
  textFont(FuturaStencil_20,16); 
  text(nameVersion,5,posTextY);
  //CLOCK
  fill(orange); 
  textFont(FuturaStencil_20,16); 
  textAlign(RIGHT);
  text(nf(hour(),2)   + ":" +nf(minute(),2) , width -10, posTextY);
  
  dispay_text_slider_top();  
  dislay_text_slider_item();
}





/**
display dropdown
*/
// DRAW DROPDOWN
boolean dropdownActivity ;
int dropdownActivityCount ;
void display_dropdown() {
  update_dropdown_bar_content() ;
  
  for(int i = 0 ; i < dropdown_bar.length ; i++) {
    dropdown_bar[i].set_content(dropdown_content[i]);
    update_dropdown_bar(dropdown_bar[i]);
  }

  // item
  update_dropdown_item() ;
  
  which_bg_shader = dropdown_bar[0].get_content_line();
  which_filter = dropdown_bar[1].get_content_line();
  which_font = dropdown_bar[2].get_content_line();
  which_text = dropdown_bar[3].get_content_line();
  which_bitmap = dropdown_bar[4].get_content_line();
  which_shape = dropdown_bar[5].get_content_line();
  which_movie = dropdown_bar[6].get_content_line();

  // check the activity o the dropdown
  if(dropdownActivityCount > 0 ) {
    dropdownActivity = true; 
  } else {
    dropdownActivity = false;
  }
  dropdownActivityCount = 0;
}












/**
DISPLAY ITEM
v 0.1.0
*/
/**
display slider
*/
void display_slider() {
  display_slider_background();
  display_slider_filter();
  display_slider_light();
  display_slider_sound();
  display_slider_camera();
  display_slider_item();
}


// SLIDER DRAW
void display_slider_background() {
  slider_background_display_bg();
  for (int i = 0 ; i < NUM_SLIDER_BACKGROUND ; i++) {
    update_slider(slider_adj_background[i],value_slider_background,info_slider_background);
    show_slider(slider_adj_background[i]);
  }
}

void display_slider_filter() {
  slider_filter_display_bg();
  for (int i = 0 ; i < NUM_SLIDER_FILTER ; i++) {
    update_slider(slider_adj_filter[i],value_slider_filter,info_slider_filter);
    show_slider(slider_adj_filter[i]);
  }
}

void display_slider_light() {
  slider_light_0_display_bg();
  slider_light_1_display_bg();
  slider_light_2_display_bg();

  for (int i = 0 ; i < NUM_SLIDER_LIGHT ; i++) {
    update_slider(slider_adj_light[i],value_slider_light,info_slider_light);
    show_slider(slider_adj_light[i]);
  }
}

void display_slider_sound() {
  for(int i = 0 ; i < slider_adj_sound.length ; i++) {
    slider_adj_sound[i].show_structure();
  }
  for (int i = 0 ; i < NUM_SLIDER_SOUND ; i++) {
    update_slider(slider_adj_sound[i],value_slider_sound,info_slider_sound);
    show_slider(slider_adj_sound[i]);
  }
}

void display_slider_camera() {
  for(int i = 0 ; i < slider_adj_camera.length ; i++) {
    slider_adj_camera[i].show_structure();
  }
  for (int i = 0 ; i < NUM_SLIDER_CAMERA ; i++) {
    update_slider(slider_adj_camera[i],value_slider_camera,info_slider_camera);
    show_slider(slider_adj_camera[i]);
  }
}



void dispay_text_slider_top() {
  // background
  for(int i = 0 ; i < NUM_SLIDER_BACKGROUND ; i++) {
    slider_adj_background[i].show_label();
  }
  // filter
  for(int i = 0 ; i < NUM_SLIDER_FILTER ; i++) {
    slider_adj_filter[i].show_label();
  }
  // light
  for(int i = 0 ; i < NUM_SLIDER_LIGHT ; i++) {
    slider_adj_light[i].show_label();
  }
  // sound
  for(int i = 0 ; i < NUM_SLIDER_SOUND ; i++ ) {
    slider_adj_sound[i].show_label();
  } 
  // camera
  for(int i = 0 ; i < slider_camera_name.length ; i++) {
    slider_adj_camera[i].show_label();
  }
}



// Slider display for the global slider background, camera, light, sound....
/*
When you add a new sliders, you must change the starting value from 'NAN' to a value between 0 and 1 in the file 'defaultSetting.csv' in the 'preferences/setting' folder.
And you must add the name of this one in the 'preferences/'  folder slider_name_en.csv' and in the 'slider_name_fr' file
*/
void slider_background_display_bg() {
  show_slider_hsb(pos_slider_background, size_slider_background, value_slider_background) ;
  show_slider_background(pos_slider_background[3], size_slider_background[3], rounded_slider, blancGris);
}


void slider_filter_display_bg() {
  // nothing at this time
}


void slider_light_0_display_bg() {
  int start = 0;
  int length = 3 ;
  iVec2 [] pos = new iVec2[length];
  iVec2 [] size = new iVec2[length];
  float [] value = new float[length];
  System.arraycopy(pos_slider_light,start,pos,0,length);
  System.arraycopy(size_slider_light,start,size,0,length);
  System.arraycopy(value_slider_light,start,value,0,length);
  show_slider_hsb(pos, size, value);
}

void slider_light_1_display_bg() {
  int start = 3 ;
  int length = 3 ;
  iVec2 [] pos = new iVec2[length];
  iVec2 [] size = new iVec2[length];
  float [] value = new float[length];
  System.arraycopy(pos_slider_light,start,pos,0,length);
  System.arraycopy(size_slider_light,start,size,0,length);
  System.arraycopy(value_slider_light,start,value,0,length);
  show_slider_hsb(pos, size, value);
}

void slider_light_2_display_bg() {
  int start = 6 ;
  int length = 3 ;
  iVec2 [] pos = new iVec2[length];
  iVec2 [] size = new iVec2[length];
  float [] value = new float[length];
  System.arraycopy(pos_slider_light,start,pos,0,length);
  System.arraycopy(size_slider_light,start,size,0,length);
  System.arraycopy(value_slider_light,start,value,0,length);
  show_slider_hsb(pos, size, value);
}




// supra local void
void show_slider_hsb(iVec2 [] pos, iVec2 [] size, float [] value) {
  if (mouseX > (pos[0].x ) && mouseX < ( pos[0].x +size[0].x) 
      && mouseY > ( pos[0].y - 5) && mouseY < pos[0].y +40) {
    show_slider_hue_background(pos[0], size[0]) ;
    show_slider_saturation_background(pos[1], size[1], value[0], value[1], value[2] ) ;
    show_slider_brightness_background(pos[2], size[2], value[0], value[1], value[2] ) ;
  } else {
    show_slider_background(pos[0], size[0], rounded_slider, grisClair);
    show_slider_background(pos[1], size[1], rounded_slider, grisClair);
    show_slider_background(pos[2], size[2], rounded_slider, grisClair);
  }
}


/**
Item
*/
/*
When you add a new sliders, you must change the starting value from 'NAN' to a value between 0 and 1 in the file 'defaultSetting.csv' in the 'preferences/setting' folder.
And you must add the name of this one in the 'preferences/'  folder slider_name_en.csv' and in the 'slider_name_fr' file
*/
void display_slider_item() {
  display_bg_slider_item() ;
  
  int whichGroup = 1;
  if(!show_all_slider_item) {
    for (int i = 1 ; i <= NUM_ITEM ; i++) {
      if (item_active[i]) {
        if (showSliderGroup[1] && item_group[i] == 1) { 
          for(int k = 0 ; k < NUM_SLIDER_ITEM ; k++) {
            if (display_slider[1][k]) {
              // int whichOne = item_group[i] *100 +j ;
              update_slider(slider_adj_item[k],value_slider_item,info_slider_item); 
              show_slider(slider_adj_item[k]); 
            }
          }
        }
      }
    }
  } else {
    for(int i = 0 ; i < NUM_SLIDER_ITEM ; i++) {
      update_slider(slider_adj_item[i],value_slider_item,info_slider_item);
      show_slider(slider_adj_item[i]);
    }
  } 
}

void dislay_text_slider_item() {
  for(int i = 0 ; i < NUM_SLIDER_ITEM ; i++) {
    slider_adj_item[i].show_label();
  }
}


void display_bg_slider_item() {
  // to find the good slider in the array
  int whichGroup = 1 ;
  // COL 1
  show_slider_item_HSB(whichGroup, hue_fill_rank, sat_fill_rank, bright_fill_rank) ;
  if (display_slider[whichGroup][alpha_fill_rank]) show_slider_background(pos_slider_item[alpha_fill_rank], size_slider_item[alpha_fill_rank], rounded_slider, blanc ) ;
  
  //outline color
  show_slider_item_HSB(whichGroup, hue_stroke_rank, sat_stroke_rank, bright_stroke_rank);

  for(int i = alpha_stroke_rank ; i < slider_adj_item.length ; i++) {
    slider_adj_item[i].show_structure();
  }
}




// local void to display the HSB slider and display the specific color of this one
void show_slider_item_HSB(int whichGroup, int hueRank, int satRank, int brightRank) {
  if (mouseX > (pos_slider_item[hueRank].x ) && mouseX < (pos_slider_item[hueRank].x +size_slider_item[hueRank].x) 
       && mouseY > (pos_slider_item[hueRank].y - 5) && mouseY < pos_slider_item[hueRank].y +30) 
  {
    if (display_slider[whichGroup][hueRank]) show_slider_hue_background(pos_slider_item[hueRank], size_slider_item[hueRank]) ; 
    if (display_slider[whichGroup][satRank]) show_slider_saturation_background(pos_slider_item[satRank], size_slider_item[satRank], value_slider_item[hueRank], value_slider_item[satRank], value_slider_item[brightRank]) ;
    if (display_slider[whichGroup][brightRank]) show_slider_brightness_background(pos_slider_item[brightRank], size_slider_item[brightRank], value_slider_item[hueRank], value_slider_item[satRank], value_slider_item[brightRank]) ;
  } else {
    if (display_slider[whichGroup][hueRank]) show_slider_background(pos_slider_item[hueRank], size_slider_item[hueRank], rounded_slider, blanc);
    if (display_slider[whichGroup][satRank]) show_slider_background(pos_slider_item[satRank], size_slider_item[satRank], rounded_slider, blanc);
    if (display_slider[whichGroup][brightRank]) show_slider_background(pos_slider_item[brightRank], size_slider_item[brightRank], rounded_slider, blanc);
  }
}


/**
display item info
*/
void text_info_item(iVec2 pos, iVec2 size, int IDorder, int IDfamily) {
  if (mouseX > pos.x && mouseX < (size.x + pos.x ) && mouseY > pos.y - 10 && mouseY <  (size.y + pos.y) -20 ) {
    iVec2 fontPos = iVec2(-10, -20 ) ;
    
    if (NUM_ITEM > 0 ) {
      display_info_item(IDorder, fontPos) ;
    }
  }
}

void display_info_item(int IDorder, iVec2 pos) {
  int whichLine = 0 ;
  int num = inventory_item_table.getRowCount() ;
  for ( int j = 0 ; j < num ; j++) {
    TableRow lookFor = inventory_item_table.getRow(j);
    int ID = lookFor.getInt("ID") ;
    if ( ID == IDorder ) {
      whichLine = j ;
    }
  }
  TableRow displayInfo = inventory_item_table.getRow(whichLine) ;
  int num_line = 4 ;
  String [] text = new String[num_line] ;
  int [] size_text = new int[num_line] ;
  text[0] = displayInfo.getString("Name") ;
  text[1] = displayInfo.getString("Author") ;
  text[2] = displayInfo.getString("Version") ;
  text[3] = displayInfo.getString("Pack") ;
  size_text [0] = 20 ;
  size_text [1] = 15 ;
  size_text [2] = 10 ;
  size_text [3] = 10 ;

  // background window
  int pos_correction_y = -30 ;
  Vec2 pos_window = Vec2(pos.x +mouseX , pos.y + mouseY +pos_correction_y) ;
  Vec2 ratio_size = Vec2( 1.4, 1.3) ;
  int speed = 7 ;
  int size_angle = 2 ;
  fill(rougeFonce, 150) ;
  Vec2 range_check = Vec2(0,1) ;
  background_text_list(Vec2(pos_window.x +2, pos_window.y), text, size_text, size_angle, speed, ratio_size, range_check,FuturaStencil_20) ;


  // text
  fill(jaune) ;  
  textSize(size_text [0] ) ;
  textFont(FuturaStencil_20) ;
  text(text[0], pos_window.x, pos_window.y +5) ;
  textSize(size_text [1] ) ;
  text(text[1], pos_window.x, pos_window.y +20) ;
  textSize(size_text [2] ) ;
  text(text[2], pos_window.x, pos_window.y +30) ;
  text(text[3], pos_window.x, pos_window.y +40) ;
}

void background_text_list(Vec2 pos, String [] list, int [] size_text, int size_angle, int speed_rotation, Vec2 ratio_size, Vec2 start_end, PFont font) {
  // create the starting point of the shape
  pos = Vec2(pos.x -(size_text[0] *.5), pos.y -size_text[0]) ;

  // spacing
  float spacing = 0 ;
  for(int i = 0 ; i < size_text.length ; i++) {
    spacing += size_text[i] ;
  }
  spacing /= size_text.length ;
  spacing *= ratio_size.y;

  //define the size of the background
  int start_point_list = int(start_end.x) ;
  int end_point_list = int(start_end.y) ;
  
  int size_word = int(longest_String_pixel(font,list, size_text, start_point_list, end_point_list)) ;
  float width_rect =  size_word *ratio_size.x ;
  int height_rect = list.length *(int)spacing ;
  
  // create the point to build the background
  int diam = size_angle;
  int speed = speed_rotation ;
  Vec2 a = Vec2(pos.x + 0,pos.y + 0).revolution(diam *3, speed/2) ;
  Vec2 b = Vec2(pos.x + width_rect, pos.y + 0).revolution(int(diam *1.5), speed) ;
  Vec2 c = Vec2(pos.x + width_rect, pos.y + height_rect).revolution(diam *2, int(speed *1.2)) ;
  Vec2 d = Vec2(pos.x + 0, pos.y + height_rect).revolution(diam, int(speed *.7)) ;
  
  // display background
  beginShape();
  vertex(a);
  vertex(b);
  vertex(c);
  vertex(d);
  endShape(CLOSE) ;
}




















/**
slider method
*/
void show_slider_background(iVec2 pos, iVec2 size, int rounded, int c) {
  fill(c);
  rect(pos.x, pos.y -(size.y *.5), size.x, size.y, rounded);
}

// hue
void show_slider_hue_background(iVec2 pos, iVec2 size) {
  pushMatrix();
  translate (pos.x , pos.y -(size.y *.5));
  for (int i = 0 ; i < size.x ; i++) {
    for (int j = 0 ; j <= size.y ; j++) {
      float cr = map(i,0,size.x,0,360);
      fill(cr,100,100);
      rect(i,j,1,1);
    }
  }
  popMatrix();
}

// saturation
void show_slider_saturation_background(iVec2 pos, iVec2 size, float colour, float s, float d) {
  pushMatrix ();
  translate (pos.x, pos.y-(size.y *.5));
  for ( int i = 0 ; i < size.x ; i++) {
    for ( int j = 0 ; j <=size.y ; j++) {
      float cr = map(i,0,size.x,0,100);
      float dens = map(d,0,size.x,0,100);
      fill (colour,cr,dens);
      rect (i,j,1,1);
    }
  }
  popMatrix();
}

// brightness
void show_slider_brightness_background(iVec2 pos, iVec2 size, float colour, float s, float d) {
  pushMatrix ();
  translate (pos.x, pos.y-(size.y *.5));
  for (int i = 0 ; i < size.x ; i++) {
    for (int j = 0 ; j <= size.y ; j++) {
      float cr = map(i,0,size.x,0,100);
      float sat = map(s,0,size.x,0,100);
      fill (colour, sat, cr) ;
      rect (i,j,1,1) ;
    }
  }
  popMatrix() ;
}

void show_slider(Slider_adjustable sa) {
  sa.show_adj();
  sa.show_molette();
}


void update_slider(Slider_adjustable sa, float [] value_slider, Vec5 [] info_slider) {
  //MIDI update
  update_midi_slider(sa,info_slider);
  // MIN and MAX molette
  //check
  if(!sa.molette_used_is() && !sa.inside_molette_is()) {
    // min molette
    if(!sa.inside_max() && !sa.locked_max_is()) {
      sa.inside_min();
      sa.select_min();
      sa.update_min();
    }
    // max molette
    if(!sa.inside_min() && !sa.locked_min_is()) {
      sa.inside_max();
      sa.select_max();
      sa.update_max();
    }
  }
  // update 
  sa.update_min_max();
  
  
  // CURRENT molette
  // check
  if(!sa.locked_max_is() && !sa.locked_max_is()) sa.inside_molette_ellipse() ;
  // update
  sa.select_molette();
  sa.update_molette();
  
  // translate float value to int, to use OSC easily without problem of Array Outbound...blablah
  int valueMax = 360 ;
  value_slider[sa.get_id()] = constrain(map(sa.get_value(),0,1,0,valueMax),0,valueMax)  ;
}





/*
void display_min_max_slider(Slider_adjustable sa, color colorIn, color colorOut) {
  sa.show_adj();
}
*/
































/**
BUTTON display
*/
void display_button_and_dropdown() {
  display_button_general();
  display_button_item_console();
  display_button_inventory_item();
  display_dropdown();
  display_button_header();
}






void display_button_header() {
  // background window
  Vec2 pos_window = Vec2(mouseX , mouseY -20) ;
  Vec2 ratio_size = Vec2( 1.6, 1.3) ;
  int speed = 7 ;
  int size_angle = 2 ;
  Vec2 range_check = Vec2(0,0) ;
  String [] text = new String[1] ;
  int [] size_text = new int[1] ;
  size_text [0] = 20 ;
  textFont(FuturaStencil_20) ;

  noStroke() ;
  int alpha_bg_rollover = int(g.colorModeA *.8) ;

  if(button_midi.rollover()) {
    text [0] = ("MIDI") ;    
    fill(grisTresFonce, alpha_bg_rollover) ;
    background_text_list(Vec2(pos_window.x, pos_window.y), text, size_text, size_angle, speed, ratio_size, range_check, FuturaStencil_20) ;
    fill(jaune) ;
    text(text [0],pos_window.x, pos_window.y) ;
  }

  if(button_curtain.rollover()) {
    text [0] = ("CUT") ;
    noStroke() ;
    fill(grisTresFonce, alpha_bg_rollover) ;
    background_text_list(Vec2(pos_window.x, pos_window.y), text, size_text, size_angle, speed, ratio_size,range_check,FuturaStencil_20) ;
    fill(jaune) ;
    text(text [0], pos_window.x, pos_window.y) ;
  }
}


void display_button_general() {
  button_bg.button_text(shader_bg_name[which_bg_shader] + " on/off", pos_button_background, titleButtonMedium, sizeTitleButton) ;
  //button_bg.button_text(shader_bg_name[state_bg_shader] + " on/off", pos_button_background, titleButtonMedium, sizeTitleButton) ;
  // Light ambient
  button_light_ambient.button_text("Ambient on/off", pos_light_ambient_buttonButton, titleButtonMedium, sizeTitleButton) ;
  button_light_ambient_action.button_text("action", pos_light_ambient_button_action, titleButtonMedium, sizeTitleButton) ;
  //LIGHT ONE
  button_light_1.button_text("Light on/off", pos_light_1_button, titleButtonMedium, sizeTitleButton) ;
  button_light_1_action.button_text("action", pos_light_1_button_action, titleButtonMedium, sizeTitleButton) ;
  // LIGHT TWO
  button_light_2.button_text("Light on/off",  pos_light_2_button, titleButtonMedium, sizeTitleButton) ;
  button_light_2_action.button_text("action",  pos_light_2_button_action, titleButtonMedium, sizeTitleButton) ;
  
  // SOUND
  button_beat.button_text("BEAT", pos_beat_button, titleButtonMedium, sizeTitleButton) ;
  button_kick.button_text("KICK", pos_kick_button, titleButtonMedium, sizeTitleButton) ;
  button_snare.button_text("SNARE", pos_snare_button, titleButtonMedium, sizeTitleButton) ;
  button_hat.button_text("HAT", pos_hat_button, titleButtonMedium, sizeTitleButton) ;
  
  //MIDI / CURTAIN
  button_midi.button_pic(picMidi) ;
  button_curtain.button_pic(picCurtain) ;
}