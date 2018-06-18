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
  display_structure_header(pos,size, fill_header_struc);

  pos.set(0, pos_y_button_top);
  size.set(width,height_button_top);
  display_structure_top_button(pos,size,structure_background_gray_a,structure_background_colour_a);

  pos.set(0, pos_y_dropdown_top);
  size.set(width, height_dropdown_top);
  display_structure_dropdown_menu_general(pos,size,structure_background_gray_a,structure_background_colour_a);

  pos.set(0,pos_y_menu_general);
  size.set(width,height_menu_general);
  display_structure_general(pos,size,structure_background_gray_a,structure_background_gray_b);
  
  pos.set(0, pos_y_item_selected);
  size.set(width, height_item_selected);
  display_structure_item_selected(pos,size,structure_background_gray_a,structure_background_colour_a);

  pos.set(0, pos_y_inventory);
  size.set(width, height);
  display_structure_inventory_item(pos,size,structure_background_gray_a,structure_background_gray_b);

  display_structure_bottom(structure_background_colour_a,structure_background_colour_b);
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


void show_misc_text() {
  if(insideNameversion) fill (fill_text_title_in) ; else fill(fill_text_title_out) ;
  int posTextY = 18 ;
  textFont(FuturaStencil_20,16); 
  text(nameVersion,5,posTextY);
  //CLOCK
  fill(fill_text_title_out); 
  textFont(FuturaStencil_20,16); 
  textAlign(RIGHT);
  text(nf(hour(),2)   + ":" +nf(minute(),2) , width -10, posTextY);
}





/**
display dropdown
*/
// DRAW DROPDOWN
void show_dropdown() {
  update_dropdown_bar_content() ;
  
  for(int i = 0 ; i < dropdown_bar.length ; i++) {
    dropdown_bar[i].set_content(dropdown_content[i]);
    // update_dropdown_bar(dropdown_bar[i]);
  }

  update_dropdown(dropdown_bar);
  update_dropdown(dropdown_setting);



  // item
  update_dropdown_item() ;
  
  which_bg_shader = dropdown_bar[0].get_selection();
  which_filter = dropdown_bar[1].get_selection();
  which_font = dropdown_bar[2].get_selection();
  which_text = dropdown_bar[3].get_selection();
  which_bitmap = dropdown_bar[4].get_selection();
  which_shape = dropdown_bar[5].get_selection();
  which_movie = dropdown_bar[6].get_selection();  
}












/**
DISPLAY ITEM
v 0.2.1
*/
/**
display slider
*/
void show_slider_controller() {
  show_slider_background();
  show_slider_filter();
  show_slider_light();
  show_slider_sound();
  if(dropdown_setting.get_selection() == 0) {
    show_slider_camera();
  } else if (dropdown_setting.get_selection() == 1) {
    show_slider_sound_setting();
  }
  show_slider_item();
}



// SLIDER DRAW
void show_slider_background() {
  boolean show_is = false;
  if(!dropdown_is()) {
    show_is = show_slider_structure_colour(pos_slider_background, size_slider_background, value_slider_background);
  }
  for (int i = 0 ; i < NUM_SLIDER_BACKGROUND ; i++) {
    if(!dropdown_is()) {
      update_slider(slider_adj_background[i],info_slider_background);
    }
    pass_slider_to_osc_arg(slider_adj_background[i], value_slider_background);
    if(!show_is || i >= 3 ) slider_adj_background[i].show_structure();
    slider_adj_background[i].show_adj();
    slider_adj_background[i].show_molette();
    slider_adj_background[i].show_label();
  }
}

void show_slider_filter() {
  for (int i = 0 ; i < NUM_SLIDER_FILTER ; i++) {
    if(!dropdown_is()) {
      update_slider(slider_adj_filter[i],info_slider_filter);
    }    
    pass_slider_to_osc_arg(slider_adj_filter[i], value_slider_filter);
    slider_adj_filter[i].show_structure();
    slider_adj_filter[i].show_adj();
    slider_adj_filter[i].show_molette();
    slider_adj_filter[i].show_label();
  }
}

void show_slider_light() {
  boolean [] is = new boolean[3];
  if(!dropdown_is()) {
    is[0] = slider_light_0_show_structure_colour();
    is[1] = slider_light_1_show_structure_colour();
    is[2] = slider_light_2_show_structure_colour();
  }


  for (int i = 0 ; i < NUM_SLIDER_LIGHT ; i++) {
    if(!dropdown_is()) {
      update_slider(slider_adj_light[i],info_slider_light);
    }   
    pass_slider_to_osc_arg(slider_adj_light[i],value_slider_light);
    boolean show_is = false;
    for(int k = 0 ; k < is.length ; k++) {
      if(!is[k]) {
        int num_special_slider = 3;
        for(int m = 0 ; m < num_special_slider ; m++) {
          if(i == k*num_special_slider+m) {
            show_is = true ;
            break;
          }
        }
      }
    }  
    if(show_is) slider_adj_light[i].show_structure();
    slider_adj_light[i].show_adj();
    slider_adj_light[i].show_molette();
    slider_adj_light[i].show_label();
  }
}

void show_slider_sound() {
  for (int i = 0 ; i < NUM_SLIDER_SOUND ; i++) {
    if(!dropdown_is()) {
      update_slider(slider_adj_sound[i],info_slider_sound);
    }   
    pass_slider_to_osc_arg(slider_adj_sound[i],value_slider_sound);
    slider_adj_sound[i].show_structure();
    slider_adj_sound[i].show_adj();
    slider_adj_sound[i].show_molette();
    slider_adj_sound[i].show_label();
  }
}

void show_slider_sound_setting() {
  for (int i = 0 ; i < NUM_SLIDER_SOUND_SETTING ; i++) {
    if(!dropdown_is()) {
      update_slider(slider_sound_setting[i],info_slider_sound_setting);
    } 
    pass_slider_to_osc_arg(slider_sound_setting[i],value_slider_sound_setting);
    slider_sound_setting[i].show_structure();
    slider_sound_setting[i].show_molette();
    slider_sound_setting[i].show_label();
  }
}

void show_slider_camera() {
  for (int i = 0 ; i < NUM_SLIDER_CAMERA ; i++) {
    if(!dropdown_is()) {
      update_slider(slider_adj_camera[i],info_slider_camera);
    }    
    pass_slider_to_osc_arg(slider_adj_camera[i],value_slider_camera);
    slider_adj_camera[i].show_structure();
    slider_adj_camera[i].show_adj();
    slider_adj_camera[i].show_molette();
    slider_adj_camera[i].show_label();  
  }
}







// Slider display for the global slider background, camera, light, sound....
/*
When you add a new sliders, you must change the starting value from 'NAN' to a value between 0 and 1 in the file 'defaultSetting.csv' in the 'preferences/setting' folder.
And you must add the name of this one in the 'preferences/'  folder slider_name_en.csv' and in the 'slider_name_fr' file
*/
boolean slider_light_0_show_structure_colour() {
  int start = 0;
  int length = 3 ;
  iVec2 [] pos = new iVec2[length];
  iVec2 [] size = new iVec2[length];
  float [] value = new float[length];
  System.arraycopy(pos_slider_light,start,pos,0,length);
  System.arraycopy(size_slider_light,start,size,0,length);
  System.arraycopy(value_slider_light,start,value,0,length);
  return show_slider_structure_colour(pos, size, value);
}

boolean slider_light_1_show_structure_colour() {
  int start = 3 ;
  int length = 3 ;
  iVec2 [] pos = new iVec2[length];
  iVec2 [] size = new iVec2[length];
  float [] value = new float[length];
  System.arraycopy(pos_slider_light,start,pos,0,length);
  System.arraycopy(size_slider_light,start,size,0,length);
  System.arraycopy(value_slider_light,start,value,0,length);
  return show_slider_structure_colour(pos, size, value);
}

boolean slider_light_2_show_structure_colour() {
  int start = 6 ;
  int length = 3 ;
  iVec2 [] pos = new iVec2[length];
  iVec2 [] size = new iVec2[length];
  float [] value = new float[length];
  System.arraycopy(pos_slider_light,start,pos,0,length);
  System.arraycopy(size_slider_light,start,size,0,length);
  System.arraycopy(value_slider_light,start,value,0,length);
  return show_slider_structure_colour(pos, size, value);
}




// supra local void
boolean show_slider_structure_colour(iVec2 [] pos, iVec2 [] size, float [] value) {
  if (mouseX > (pos[0].x ) && mouseX < ( pos[0].x +size[0].x) 
      && mouseY > ( pos[0].y - 5) && mouseY < pos[0].y +40) {
    show_slider_hue_structure(pos[0], size[0]) ;
    show_slider_saturation_structure(pos[1],size[1],value[0],value[1],value[2]);
    show_slider_brightness_structure(pos[2],size[2],value[0],value[1],value[2]);
    return true;
  } else {
    return false;
  }
}


/**
Item
*/
/*
When you add a new sliders, you must change the starting value from 'NAN' to a value between 0 and 1 in the file 'defaultSetting.csv' in the 'preferences/setting' folder.
And you must add the name of this one in the 'preferences/'  folder slider_name_en.csv' and in the 'slider_name_fr' file
*/
void show_slider_item() {
  boolean [] is = new boolean[2];
  if(!show_all_slider_item) {
    if(!dropdown_is()) {
      is[0] = show_slider_item_colour(hue_fill_rank, sat_fill_rank, bright_fill_rank); // fill
      is[1] = show_slider_item_colour(hue_stroke_rank, sat_stroke_rank, bright_stroke_rank); // stroke
    }
    for (int i = 1 ; i <= NUM_ITEM ; i++) {
      if (item_active[i]) {
        if (item_group[i] == 1) { 
          for(int k = 0 ; k < NUM_SLIDER_ITEM ; k++) {
            if (display_slider[k]) {
              show_slider(k,is);
            }
          }
        }
      }
    }
  } else {
    if(!dropdown_is()) {
      is[0] = show_slider_item_colour(hue_fill_rank, sat_fill_rank, bright_fill_rank); // fill
      is[1] = show_slider_item_colour(hue_stroke_rank, sat_stroke_rank, bright_stroke_rank); // stroke
    }
    for(int i = 0 ; i < NUM_SLIDER_ITEM ; i++) {
      show_slider(i,is);
    }
  } 
}


void show_slider(int index, boolean [] is) {
  if(!dropdown_is()) {
    update_slider(slider_adj_item[index],info_slider_item);
  }
  pass_slider_to_osc_arg(slider_adj_item[index],value_slider_item);
  boolean show_is = false ;
  for(int k = 0 ; k < is.length ;k++) {
    if(!is[k]) {
      int num_special_slider = 3;
      int step = 4 ;
      for(int m = 0 ; m < num_special_slider ; m++) {    
        if(index == k* step +m || index == 3 || index > 6) {
          show_is = true;
          break;
        } 
      }
    }
  }
  if(show_is) slider_adj_item[index].show_structure();
  slider_adj_item[index].show_adj();
  slider_adj_item[index].show_molette();
  slider_adj_item[index].show_label();
}





// local void to display the HSB slider and display the specific color of this one
boolean show_slider_item_colour(int hueRank, int satRank, int brightRank) {
  boolean is = (mouseX > (pos_slider_item[hueRank].x ) 
                        && mouseX < (pos_slider_item[hueRank].x +size_slider_item[hueRank].x) 
                        && mouseY > (pos_slider_item[hueRank].y - 5) 
                        && mouseY < pos_slider_item[hueRank].y +30);

  if (is) {
    if (display_slider[hueRank]) show_slider_hue_structure(pos_slider_item[hueRank], size_slider_item[hueRank]) ; 
    if (display_slider[satRank]) show_slider_saturation_structure(pos_slider_item[satRank], size_slider_item[satRank], value_slider_item[hueRank], value_slider_item[satRank], value_slider_item[brightRank]) ;
    if (display_slider[brightRank]) show_slider_brightness_structure(pos_slider_item[brightRank], size_slider_item[brightRank], value_slider_item[hueRank], value_slider_item[satRank], value_slider_item[brightRank]) ;
    
  } 
  return is;
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
  fill(fill_info_window_rect,150);
  Vec2 range_check = Vec2(0,1) ;
  background_text_list(Vec2(pos_window.x +2, pos_window.y), text, size_text, size_angle, speed, ratio_size, range_check,FuturaStencil_20) ;


  // text
  fill(fill_info_window_text);  
  textSize(size_text[0]);
  textFont(FuturaStencil_20);
  text(text[0], pos_window.x, pos_window.y +5);
  textSize(size_text[1]);
  text(text[1], pos_window.x, pos_window.y +20);
  textSize(size_text[2]);
  text(text[2], pos_window.x, pos_window.y +30);
  text(text[3], pos_window.x, pos_window.y +40);
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

// hue
void show_slider_hue_structure(iVec2 pos, iVec2 size) {
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
void show_slider_saturation_structure(iVec2 pos, iVec2 size, float colour, float s, float d) {
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
void show_slider_brightness_structure(iVec2 pos, iVec2 size, float colour, float s, float d) {
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



void update_slider(Slider slider, Vec5 [] info_slider) {
  //MIDI update
  update_midi_slider(slider,info_slider);


  // MIN and MAX molette
  //check
  if(slider instanceof Sladj) {
    Sladj sladj = (Sladj)slider;
    if(!sladj.molette_used_is() && !sladj.inside_molette_is()) {
      // min molette
      if(!sladj.inside_max() && !sladj.locked_max_is()) {
        sladj.inside_min();
        sladj.select_min(shift_key);
        sladj.update_min();
      }
      // max molette
      if(!sladj.inside_min() && !sladj.locked_min_is()) {
        sladj.inside_max();
        sladj.select_max(shift_key);
        sladj.update_max();
      }
    }
    // update 
    sladj.update_min_max();
    if(!sladj.locked_max_is() && !sladj.locked_max_is()) {
      sladj.inside_molette_ellipse();
    } 
  } else {
    slider.inside_molette_ellipse();
  }
  
  
  

  // CURRENT molette
  // check
  
  // update
  slider.select(true);
  slider.update(mouseX,mouseY);
  
  // translate float value to int, to use OSC easily without problem of Array Outbound...blablah
  /*
  int valueMax = 360 ;
  value_slider[slider.get_id()] = constrain(map(slider.get_value(),0,1,0,valueMax),0,valueMax)  ;
  */
}


void pass_slider_to_osc_arg(Slider slider, float [] value_slider) {
  int valueMax = 360 ;
  value_slider[slider.get_id()] = constrain(map(slider.get_value(),0,1,0,valueMax),0,valueMax)  ;
}




































/**
BUTTON display
*/
void show_button() {
  display_button_general();
  if(change_size_window_is()) {
    display_button_item_console(true);
    change_size_window(false);
  } else {
    display_button_item_console(false);
  }
  display_button_inventory();
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
    fill(fill_info_window_rect, alpha_bg_rollover) ;
    background_text_list(Vec2(pos_window.x, pos_window.y), text, size_text, size_angle, speed, ratio_size, range_check, FuturaStencil_20) ;
    fill(fill_info_window_text) ;
    text(text [0],pos_window.x, pos_window.y) ;
  }

  if(button_curtain.rollover()) {
    text [0] = ("CUT") ;
    noStroke() ;
    fill(fill_info_window_rect, alpha_bg_rollover) ;
    background_text_list(Vec2(pos_window.x, pos_window.y), text, size_text, size_angle, speed, ratio_size,range_check,FuturaStencil_20) ;
    fill(fill_info_window_text) ;
    text(text [0], pos_window.x, pos_window.y) ;
  }
}



void display_button_general() {
  if(button_bg.is()) {
    button_bg.set_label(shader_bg_name[which_bg_shader] + " on");
  } else {
    button_bg.set_label(shader_bg_name[which_bg_shader] + " off");
  }
  button_bg.show_label();

  // Light ambient
  if(button_light_ambient.is()) {
    button_light_ambient.set_label("ambient on");
  } else {
    button_light_ambient.set_label("ambient off");
  }
  button_light_ambient.show_label();
  button_light_ambient_action.show_label();
  //LIGHT ONE
  if(button_light_1.is()) {
    button_light_1.set_label("spot light on");
  } else {
    button_light_1.set_label("spot light off");
  }
  button_light_1.show_label();
  button_light_1_action.show_label();
  // LIGHT TWO
  if(button_light_2.is()) {
    button_light_2.set_label("spot light on");
  } else {
    button_light_2.set_label("spot light off");
  }
  button_light_2.show_label();
  button_light_2_action.show_label();
  
  // SOUND
  button_kick.show_label();
  button_snare.show_label();
  button_hat.show_label();


  
  //MIDI / CURTAIN
  button_midi.show_picto(picMidi) ;
  button_curtain.show_picto(picCurtain) ;
}