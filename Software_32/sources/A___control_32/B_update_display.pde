/**
update, display and design
v 0.0.6
2018-2018
*/

/**
STRUCTURE DISPLAY
*/
int thickness_line_deco = 2 ;
void display_structure() {
  // check event for structure
  if(button_curtain_is == 1) {
    set_colour_structure_background_mass(r.GRENAT_PROFOND,r.BLOOD);
  } else {
    set_colour_structure_background_mass(r.GRAY_1,r.GRAY_3);
  }



  // display
  noStroke();
  iVec2 pos = iVec2(0,0);
  iVec2 size = iVec2(width, height_header);
  display_structure_header(pos,size, fill_header_struc);

  pos.set(0,pos_y_button_top);
  size.set(width,height_button_top);
  display_structure_top_button(pos,size,structure_background_mass_a,structure_background_line_a);

  pos.set(0,pos_y_dropdown_top);
  size.set(width, height_dropdown_top);
  display_structure_dropdown_menu_general(pos,size,structure_background_mass_a,structure_background_line_a);

  pos.set(0,pos_y_menu_general);
  size.set(width,height_menu_general);
  display_structure_general(pos,size,structure_background_mass_a,structure_background_mass_b);
  
  pos.set(0,pos_y_item_selected);
  size.set(width, height_item_selected);
  display_structure_item_selected(pos,size,structure_background_mass_a,structure_background_line_a);

  pos.set(0,pos_y_inventory);
  size.set(width, height);
  display_structure_inventory_item(pos,size,structure_background_mass_a,structure_background_mass_b);

  display_structure_bottom(structure_background_line_a,structure_background_line_b);
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
DROPDOWN UPDATE and DISPLAY
*/
/**
display
*/
void show_dropdown() {
  update_dropdown_bar_content() ;
  
  for(int i = 0 ; i < dropdown_bar.length ; i++) {
    if(i == 1) {
      //
    }
    dropdown_bar[i].set_content(dropdown_content[i]);
  }

  update_dropdown(dropdown_setting);
  update_dropdown(dropdown_bar);

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
update
*/
void update_dropdown(Dropdown... dd) {
  for(int i = 0 ; i < dd.length ; i++) {
    dd[i].update(mouseX,mouseY);
    dd[i].show_header_text();
    dd[i].show_box();
    dd[i].show_selection(dd[i].get_pos().x +3 , dd[i].get_pos().y +22);
  }
}

void update_dropdown_bar_content() {
  dropdown_content [0] = shader_bg_name;
  dropdown_content [1] = filter_dropdown_list;
  dropdown_content [2] = font_dropdown_list;
  dropdown_content [3] = file_text_dropdown_list;
  
  dropdown_content [4] = bitmap_dropdown_list;
  dropdown_content [5] = shape_dropdown_list;
  dropdown_content [6] = movie_dropdown_list;
}


void update_dropdown_item() {
  int pointer = 0 ;
  iVec2 offset_selection = iVec2(18,8);
  for (int i = 1 ; i <= NUM_ITEM ; i++) {
    update_dropdown_item(dd_item_costume, list_item_costume, inventory, i,offset_selection, pointer);
    update_dropdown_item(dd_item_mode, list_item_mode, inventory, i,offset_selection,pointer);
    show_dropdown_box_item(dd_item_costume, list_item_costume, inventory, i,offset_selection, pointer);
    show_dropdown_box_item(dd_item_mode, list_item_mode, inventory, i,offset_selection,pointer);
    if(inventory[i].is()) pointer++;
  }
}

void update_dropdown_item(Dropdown [] dd, String [] list, Inventory [] inventory, int index, iVec2 offset, int pointer) {
  if(inventory[index].is()) {
    int distance = pointer *DIST_BETWEEN_ITEM;
    dd[index].offset(distance, 0);
    String boxes[] = split(list[index],"/");
    if (boxes.length > 1) {
      if(dropdown_is() && dd[index].locked_is()) {
        dd[index].update(mouseX,mouseY); 
      } else if(!dropdown_is()) {
        dd[index].update(mouseX,mouseY); 
      }
    }
    // display which element is selected
    if (dd[index].get_selection() > -1 && boxes.length > 1) {
      int selection = dd[index].get_selection() +1;
      String name = dd[index].get_name() + " " + selection;
      dd[index].show_header_text(name);  
    } else {
      fill(r.GRAY_3);
      iVec2 pos = dd[index].get_pos().add(dd[index].get_header_text_pos());
      PFont font = dd[index].get_font();
      textFont(font);
      text(dd[index].get_name(),pos);
    }     
  }
}


void show_dropdown_box_item(Dropdown [] dd, String [] list, Inventory [] inventory, int index, iVec2 offset, int pointer) {
  if(inventory[index].is()) {
    int distance = pointer *DIST_BETWEEN_ITEM;
    dd[index].offset(distance, 0);
    String boxes[] = split(list[index],"/");
    if (boxes.length > 1) {
      // dd[index].update(mouseX,mouseY); 
      dd[index].show_box();
    } 
  }
}





















/**
SLIDER UPDATE and DISPLAY
*/
void show_slider_controller() {
  show_slider_background();
  show_slider_filter();
  show_slider_light();
  show_slider_sound();
  if(dropdown_setting.get_selection() == 0) {
    show_slider_sound_setting();
  } else if (dropdown_setting.get_selection() == 1) {
    show_slider_camera();
  }

  pass_slider_general_to_osc();

  show_slider_item();
}









/**
manageslider part
*/
boolean slider_already_used;
void slider_already_used(boolean state) {
  slider_already_used = state;
}

boolean slider_already_used_is() {
  return slider_already_used;
}

int dna_gui_processing;
void set_dna_gui_processing(int dna) {
  dna_gui_processing = dna;
}

int get_dna_gui_processing() {
  return dna_gui_processing;
}














void update_slider(Slider slider, Cropinfo [] info_slider) {
  update_midi_slider(slider,info_slider);

  //check
  if(slider instanceof Sladj) {
    Sladj sladj = (Sladj)slider;
    boolean state = false ;
    for(int i = 0 ; i < sladj.molette.length ; i++) {
      if(sladj.molette[i].used_is || sladj.molette[i].inside_is) {
        state = true;
        break;
      }
    }

    if(!state) {
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
  } else {
    slider.inside_molette_ellipse();
  }
  
  // multislider case
  boolean add_slider_to_selection = false;
  if(keyPressed && key == CODED && keyCode == SHIFT) {
    slider_already_used(false);
    add_slider_to_selection = true;
  }
  
  // single slider case
  if(slider.molette_inside_is() && !add_slider_to_selection && !slider_already_used_is()) {
    set_dna_gui_processing(slider.get_dna()); // dna id to securise for the only gui using
    slider_already_used(true);
  }
  

  // update the active slider
  if(add_slider_to_selection || slider.get_dna() == get_dna_gui_processing() || !slider_already_used_is()) {
    slider.update(mouseX,mouseY);
  }

  if(add_slider_to_selection) {
    slider.keep_selection(true);
    slider.select(true);
  } else if(slider_already_used_is()) {
    if(slider.get_dna() == get_dna_gui_processing()) {
      slider.keep_selection(true);
    } else {
      slider.keep_selection(false);
    }
    slider.select(true);
  } else {
    slider.keep_selection(false);
    slider.select(false);
  }
}




// SLIDER DRAW
void show_slider_background() {
  boolean show_is = false;
  if(!dropdown_is()) {
    show_is = show_slider_structure_colour(pos_slider_background, size_slider_background, value_slider_background);
  }
  for (int i = 0 ; i < NUM_SLIDER_BACKGROUND ; i++) {
    if(!dropdown_is()) {
      update_slider(slider_adj_background[i],cropinfo_slider_background);
    }
    if(!show_is || i >= 3 ) slider_adj_background[i].show_structure();
    slider_adj_background[i].show_adj();
    slider_adj_background[i].show_molette();
    slider_adj_background[i].show_label();
  }
}

void show_slider_filter() {
  for (int i = 0 ; i < NUM_SLIDER_FX ; i++) {
    if(!dropdown_is()) {
      update_slider(slider_adj_fx[i],cropinfo_slider_fx);
    }    
    slider_adj_fx[i].show_structure();
    slider_adj_fx[i].show_adj();
    slider_adj_fx[i].show_molette();
    slider_adj_fx[i].show_label();
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
      update_slider(slider_adj_light[i],cropinfo_slider_light);
    }   
    boolean show_is = false;
    for(int k = 0 ; k < is.length ; k++) {
      if(!is[k]) {
        int num_special_slider = 3;
        for(int m = 0 ; m < num_special_slider ; m++) {
          if(i == k*num_special_slider+m) {
            show_is = true;
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
      update_slider(slider_adj_sound[i],cropinfo_slider_sound);
    }   
    slider_adj_sound[i].show_structure();
    slider_adj_sound[i].show_adj();
    slider_adj_sound[i].show_molette();
    slider_adj_sound[i].show_label();
  }
}

void show_slider_sound_setting() {
  int rank = 0;
  for (int i = 0 ; i < NUM_SLIDER_SOUND_SETTING ; i++) {
    if(!dropdown_is()) {
      update_slider(slider_sound_setting[i],cropinfo_slider_sound_setting);
    }
    rank += slider_sound_setting[i].get_value().length;

    slider_sound_setting[i].show_structure();
    slider_sound_setting[i].show_molette();
    slider_sound_setting[i].show_label();
  }
}

void show_slider_camera() {
  for (int i = 0 ; i < NUM_SLIDER_CAMERA ; i++) {
    if(!dropdown_is()) {
      update_slider(slider_adj_camera[i],cropinfo_slider_camera);
    }    
    slider_adj_camera[i].show_structure();
    slider_adj_camera[i].show_adj();
    slider_adj_camera[i].show_molette();
    slider_adj_camera[i].show_label();  
  }
}

void pass_slider_general_to_osc() {
  for (int i = 0 ; i < NUM_SLIDER_BACKGROUND ; i++) {
    pass_slider_to_osc_arg(slider_adj_background[i], value_slider_background);
  }

  for (int i = 0 ; i < NUM_SLIDER_FX ; i++) {    
    pass_slider_to_osc_arg(slider_adj_fx[i], value_slider_filter);
  }

  for (int i = 0 ; i < NUM_SLIDER_LIGHT ; i++) { 
    pass_slider_to_osc_arg(slider_adj_light[i],value_slider_light);
  }

  for (int i = 0 ; i < NUM_SLIDER_SOUND ; i++) {   
    pass_slider_to_osc_arg(slider_adj_sound[i],value_slider_sound);
  }
  
  int rank = 0;
  for (int i = 0 ; i < NUM_SLIDER_SOUND_SETTING ; i++) {
    pass_multi_slider_to_osc_arg(slider_sound_setting[i],value_slider_sound_setting,rank);
    rank += slider_sound_setting[i].get_value().length;
  }

  for (int i = 0 ; i < NUM_SLIDER_CAMERA ; i++) {   
    pass_slider_to_osc_arg(slider_adj_camera[i],value_slider_camera);  
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
    update_slider(slider_adj_item[index],cropinfo_slider_item);
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
  if(show_is) {
    slider_adj_item[index].show_structure();
  }
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
void item_thumbnail_info(iVec2 pos, iVec2 size, int IDorder, int IDfamily) {
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
  float spacing = 0;
  for(int i = 0 ; i < size_text.length ; i++) {
    spacing += size_text[i];
  }
  spacing /= size_text.length;
  spacing *= ratio_size.y;

  //define the size of the background
  int start_point_list = int(start_end.x);
  int end_point_list = int(start_end.y);
  
  int size_word = int(longest_String_pixel(font,list, size_text, start_point_list, end_point_list));
  float width_rect =  size_word *ratio_size.x;
  int height_rect = list.length *(int)spacing;
  
  // create the point to build the background

  Vec2 a = Vec2(pos.x + 0,pos.y + 0);
  Vec2 b = Vec2(pos.x + width_rect, pos.y + 0);
  Vec2 c = Vec2(pos.x + width_rect, pos.y + height_rect);
  Vec2 d = Vec2(pos.x + 0, pos.y + height_rect);
  
  // display background
  beginShape();
  vertex(a);
  vertex(b);
  vertex(c);
  vertex(d);
  endShape(CLOSE);
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





/**
pass info for OSC
*/
void pass_slider_to_osc_arg(Slider slider, float [] value_slider) {
  int valueMax = 360;
  float val_single_slider = slider.get_value(0);
  value_slider[slider.get_id()] = constrain(map(val_single_slider,0,1,0,valueMax),0,valueMax);
}



void pass_multi_slider_to_osc_arg(Slider slider, float [] value_slider, int rank) {
  int valueMax = 360;
  for(int i = 0 ; i < slider.get_value().length ; i++) {
    float value = slider.get_value(i);
    value_slider[rank] = constrain(map(value,0,1,0,valueMax),0,valueMax);
    rank++;
  } 
}



































/**
BUTTON
*/
/**
init
*/
void init_button_general() {
  button_general_num = 20;
  value_button_general = new int[button_general_num];
}
/**
check button
*/
void check_button() {
  check_button_general() ;
  check_button_item_console() ;
  check_button_inventory() ;
}

void check_button_general() {
  /* Check to send by OSC to Scene and Prescene */
  if(button_bg.is()) button_background_is = 1 ; else button_background_is = 0 ;
  // FX
  for(int i = 0 ; i < NUM_BUTTON_FX ; i++) {
    if(button_fx[i].is()) button_fx_is[i] = 1 ; else button_fx_is[i] = 0 ;
  }
  //LIGHT ONE
  if(button_light_ambient.is())  light_ambient_button_is = 1 ; else  light_ambient_button_is = 0 ;
  if(button_light_ambient_action.is()) light_ambient_action_button_is = 1 ; else light_ambient_action_button_is =  0 ;
  //LIGHT ONE
  if(button_light_1.is()) light_light_1_button_is = 1 ; else light_light_1_button_is = 0 ;
  if(button_light_1_action.is()) light_light_action_1_button_is = 1 ; else light_light_action_1_button_is = 0 ;
  // LIGHT TWO
  if(button_light_2.is()) light_light_2_button_is = 1 ; else light_light_2_button_is = 0 ;
  if(button_light_2_action.is()) light_light_action_2_button_is = 1 ; else light_light_action_2_button_is = 0 ;
  //SOUND
  for(int i = 0 ; i < NUM_BUTTON_TRANSIENT ; i++) {
    if(button_transient[i].is()) button_transient_is[i] = 1 ; else button_transient_is[i] = 0 ;
  }
  //Check position of button
  if(button_curtain.is()) button_curtain_is = 1 ; else button_curtain_is = 0;
  if(button_midi.is()) button_midi_is = 1 ; else button_midi_is = 0;
  // reset button
  if(button_reset_camera.is()) button_reset_camera_is = 1 ; else button_reset_camera_is = 0;

  // misc item button
  if(button_reset_item_on.is()) button_reset_item_on_is = 1 ; else button_reset_item_on_is = 0;
  if(button_birth.is()) button_birth_is = 1 ; else button_birth_is = 0;
  if(button_3D.is()) button_3D_is = 1 ; else button_3D_is = 0;

}


/**
mouse pressed
*/
void mousePressed_button_general() {
  if(button_bg.inside()) button_bg.switch_is();

  for(int i = 0 ; i < NUM_BUTTON_FX ; i++) {
    if(button_fx[i].inside()) button_fx[i].switch_is();
  }

  if(button_light_ambient.inside()) button_light_ambient.switch_is();
  if(button_light_ambient_action.inside()) button_light_ambient_action.switch_is();

  if(button_light_1.inside()) button_light_1.switch_is();
  if(button_light_1_action.inside()) button_light_1_action.switch_is();

  if(button_light_2.inside()) button_light_2.switch_is();
  if(button_light_2_action.inside()) button_light_2_action.switch_is();
  
  for(int i = 0 ; i < NUM_BUTTON_TRANSIENT ; i++) {
    if(button_transient[i].inside()) button_transient[i].switch_is();
  }
  if(button_midi.inside()) button_midi.switch_is();
  if(button_curtain.inside())button_curtain.switch_is();
  // reset button
  if(button_reset_camera.inside()) button_reset_camera.switch_is();
  // item action
  if(button_reset_item_on.inside())button_reset_item_on.switch_is();
  if(button_birth.inside()) button_birth.switch_is();
  if(button_3D.inside())button_3D.switch_is();
}




/**
display
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
  Vec2 pos_window = Vec2(mouseX , mouseY -20);
  Vec2 ratio_size = Vec2(1.6, 1.3);
  int speed = 7;
  int size_angle = 2;
  Vec2 range_check = Vec2(0,0);
  String [] text = new String[1];
  int [] size_text = new int[1];
  size_text [0] = 20 ;
  textFont(FuturaStencil_20);

  noStroke();
  int alpha_bg_rollover = int(g.colorModeA *.8);

  if(button_curtain.inside()) {
    text [0] = ("CUT") ;
    noStroke() ;
    fill(fill_info_window_rect, alpha_bg_rollover) ;
    background_text_list(Vec2(pos_window.x, pos_window.y), text, size_text, size_angle, speed, ratio_size,range_check,FuturaStencil_20);
    fill(fill_info_window_text);
    text(text [0], pos_window.x, pos_window.y);
  }

  if(button_midi.inside()) {
    text[0] = ("MIDI");
    fill(fill_info_window_rect, alpha_bg_rollover);
    background_text_list(Vec2(pos_window.x, pos_window.y), text, size_text, size_angle, speed, ratio_size, range_check, FuturaStencil_20);
    fill(fill_info_window_text);
    text(text[0],pos_window.x, pos_window.y);
  }


  if(button_reset_camera.inside()) {
    text[0] = ("RESET CAMERA");
    fill(fill_info_window_rect, alpha_bg_rollover);
    background_text_list(Vec2(pos_window.x, pos_window.y), text, size_text, size_angle, speed, ratio_size, range_check, FuturaStencil_20);
    fill(fill_info_window_text);
    text(text[0],pos_window.x, pos_window.y);
  }

  if(button_reset_item_on.inside()) {
    text[0] = ("RESET COORD ITEM ON");
    fill(fill_info_window_rect, alpha_bg_rollover);
    background_text_list(Vec2(pos_window.x, pos_window.y), text, size_text, size_angle, speed, ratio_size, range_check, FuturaStencil_20);
    fill(fill_info_window_text);
    text(text[0],pos_window.x, pos_window.y);
  }

  if(button_birth.inside()) {
    text[0] = ("BIRTH");
    fill(fill_info_window_rect, alpha_bg_rollover);
    background_text_list(Vec2(pos_window.x, pos_window.y), text, size_text, size_angle, speed, ratio_size, range_check, FuturaStencil_20);
    fill(fill_info_window_text);
    text(text[0],pos_window.x, pos_window.y);
  }

  if(button_3D.inside()) {
    text[0] = ("3 DIMENSIONS");
    fill(fill_info_window_rect, alpha_bg_rollover);
    background_text_list(Vec2(pos_window.x, pos_window.y), text, size_text, size_angle, speed, ratio_size, range_check, FuturaStencil_20);
    fill(fill_info_window_text);
    text(text[0],pos_window.x, pos_window.y);
  }
}



void display_button_general() {
  if(button_bg.is()) {
    button_bg.set_label(shader_bg_name[which_bg_shader] + " on");
  } else {
    button_bg.set_label(shader_bg_name[which_bg_shader] + " off");
  }
  button_bg.show_label();

  // FX
  for(int i = 0 ; i < NUM_BUTTON_FX ; i++) {
    button_fx[i].show_label();
  }

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
  for(int i = 0 ; i < NUM_BUTTON_TRANSIENT ; i++) {
    button_transient[i].show_label();
  }
  //MIDI / CURTAIN
  button_curtain.show_picto(pic_curtain);
  // RESET
  button_reset_camera.show_picto(pic_reset_camera);
  button_reset_item_on.show_picto(pic_reset_item_on);
  // MISC
  button_birth.show_picto(pic_birth);
  button_3D.show_picto(pic_3D);
  // 
  button_midi.show_picto(pic_midi);

}


/**
update
*/
void update_button() {
  update_button_general();
  update_button_inventory();
  /**
  void update_button_item(); 
  > the method don't exist, 
  it is include in method display_button_item_console(boolean keep_setting)
  */
}

void update_button_general() {
  update_button_local(button_curtain,button_reset_camera,button_reset_item_on,button_birth,button_3D);
  update_button_local(button_midi);
  update_button_local(button_bg,
                      button_light_ambient,button_light_ambient_action,
                      button_light_1,button_light_1_action,
                      button_light_2,button_light_2_action);
  update_button_local(button_fx);
  update_button_local(button_transient);
}

void update_button_local(Button... b) {
  for(int i = 0 ; i < b.length ; i++) {
    b[i].update(mouseX,mouseY,dropdown_is());
  }
}
