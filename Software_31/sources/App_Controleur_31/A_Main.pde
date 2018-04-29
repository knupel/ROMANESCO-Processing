/**
Build interface 
v 3.2.0
2014-2018
Romanesco Processing Environment
*/
import java.awt.event.KeyEvent;
import java.awt.image.*;
import java.awt.*;
/**
SETTING
*/
void setting() {
  colorSetup() ;  
  frameRate(60) ; 
  noStroke () ; 
  surface.setResizable(true);
  background(gris);
}

void reset() {
  init_slider_dynamic() ;
  INIT_INTERFACE = false ;
}

void info_bg_shader() {
  int n = shaderBackgroundList.getRowCount() ;
  shader_bg_name = new String[n] ;
  shader_bg_author = new String[n] ;
  for (int i = 0 ; i < n ; i++ ) {
     TableRow row = shaderBackgroundList.getRow(i) ;
     shader_bg_name[i] = row.getString("Name") ;
     shader_bg_author[i] = row.getString("Author") ;
  }
}






















/**
STRUCTURE DESIGN
*/
int line_decoration_small = 2 ;
int line_decoration_medium = 4 ;
int line_decoration_big = 6 ;
void display_structure_header() {
  noStroke() ;
  fill (rougeFonce) ; 
  rect(0,0, width, height_header) ;
}
void display_structure_top_button() {
  noStroke() ;
  //background
  fill(gris) ; 
  rect(0, pos_y_button_top, width, height_button_top) ; // main band
  //decoration
  fill(jauneOrange) ;
  rect(0,pos_y_button_top, width, line_decoration_small) ;
}
void display_structure_dropdown_menu_general() {
  noStroke() ;
  // backgorund
  fill(grisNoir) ; 
  rect(0, pos_y_dropdown_top, width, height_dropdown_top) ; // main band
  //decoration
  fill (jauneOrange) ;
  rect(0,pos_y_dropdown_top, width, line_decoration_small) ;
}

void display_structure_general() {
  noStroke() ;
  // background
  fill(gris) ; 
  rect(0,pos_y_menu_general , width, height_menu_general) ;
  // LINE DECORATION
  fill(noir) ;
  rect(0,pos_y_menu_general , width, line_decoration_small) ;
}

void display_structure_menu_sound() {
  noStroke() ;
    // background
  fill(gris) ;
  rect(0, pos_y_menu_sound, width, height_menu_sound) ; 
  // top decoration
  fill(grisTresFonce) ;
  rect(0, pos_y_menu_sound, width, line_decoration_medium) ; 
  fill(grisFonce) ;
  rect(0, pos_y_menu_sound, width, line_decoration_small) ; 
}

void display_structure_item_selected() {
  noStroke() ;
  // background
  fill(grisFonce) ;
  rect(0, pos_y_item_selected, width, height_item_selected) ; 
  // top decoration
  fill(jauneOrange) ;
  rect(0, pos_y_item_selected, width, line_decoration_medium) ; 
  fill(rougeFonce) ;
  rect(0, pos_y_item_selected, width, line_decoration_small) ; 
}

void display_structure_inventory_item() {
  noStroke() ;
  // background
  fill(gris) ;
  rect(0, pos_y_inventory_item , width, height) ; 
  // top decoration
  fill(grisTresFonce) ;
  rect(0, pos_y_inventory_item, width, line_decoration_small) ;
}

void display_structure_bottom() {
  noStroke() ;
  // bottom decoration
  fill (jauneOrange) ;
  rect(0,height-9, width, 2) ;
  fill (rougeFonce) ;
  rect(0,height-7, width, 7) ;
}

/**
TEXT
*/
void display_text() {
  if(insideNameversion) fill (jaune) ; else fill(orange) ;
  int posTextY = 18 ;
  textFont(FuturaStencil_20,16); 
  text(nameVersion, 5, posTextY);
  //CLOCK
  fill (orange) ; 
  textFont(FuturaStencil_20,16); textAlign(RIGHT);
  text(nf(hour(),2)   + ":" +nf(minute(),2) , width -10, posTextY);
  
  dispay_text_slider_top( height_menu_general +64) ;
  
  dislay_text_slider_item() ;
}






void check_interface() {
  if(size_ref.x != width || size_ref.y != height) INIT_INTERFACE = true ;
}

void init_interface() {
  if(INIT_INTERFACE) {
    build_button_inventory_item() ;
    set_inventory_item() ;
    size_ref.set(width, height) ;
  }
}






















/**
SLIDER
v 2.0.0
*/
void build_slider() {
  // background
  for (int i = 0 ; i < NUM_SLIDER_BACKGROUND ; i++) {
    Vec2 temp_size_mol = Vec2(size_slider_background[i].y *ratio_size_molette, size_slider_background[i].y *ratio_size_molette) ;
    Vec2 temp_pos = Vec2(pos_slider_background[i].x, pos_slider_background[i].y -(slider_height *.6)) ;
    if(info_save_raw_list(info_slider_background,i).a > -1 ) {
      slider_adj_background[i] = new Slider_adjustable(temp_pos, size_slider_background[i], temp_size_mol, "ELLIPSE");
      slider_adj_background[i].set_id(i);
    }
  }

  // filter
  for (int i = 0 ; i < NUM_SLIDER_FILTER ; i++) {
    Vec2 temp_size_mol = Vec2(size_slider_filter[i].y *ratio_size_molette, size_slider_filter[i].y *ratio_size_molette) ;
    Vec2 temp_pos = Vec2(pos_slider_filter[i].x, pos_slider_filter[i].y -(slider_height *.6)) ;
    if(info_save_raw_list(info_slider_filter,i).a > -1 ) {
      slider_adj_filter[i] = new Slider_adjustable(temp_pos, size_slider_filter[i], temp_size_mol, "ELLIPSE");
      slider_adj_filter[i].set_id(i);
    }
  }

  // light
  for (int i = 0 ; i < NUM_SLIDER_LIGHT ; i++) {
    Vec2 temp_size_mol = Vec2(size_slider_light[i].y *ratio_size_molette, size_slider_light[i].y *ratio_size_molette) ;
    Vec2 temp_pos = Vec2(pos_slider_light[i].x, pos_slider_light[i].y -(slider_height *.6)) ;
    if(info_save_raw_list(info_slider_light,i).a > -1 ) {
      slider_adj_light[i] = new Slider_adjustable(temp_pos, size_slider_light[i], temp_size_mol, "ELLIPSE");
      slider_adj_light[i].set_id(i);
    }
  }

  // sound
  for (int i = 0 ; i < NUM_SLIDER_SOUND ; i++) {
    Vec2 temp_size_mol = Vec2(size_slider_sound[i].y *ratio_size_molette, size_slider_sound[i].y *ratio_size_molette) ;
    Vec2 temp_pos = Vec2(pos_slider_sound[i].x, pos_slider_sound[i].y -(slider_height *.6)) ;
    if(info_save_raw_list(info_slider_sound,i).a > -1 ) {
      slider_adj_sound[i] = new Slider_adjustable(temp_pos, size_slider_sound[i], temp_size_mol, "ELLIPSE");
      slider_adj_sound[i].set_id(i);
    }
  }

  // camera
  for (int i = 0 ; i < NUM_SLIDER_CAMERA ; i++) {
    Vec2 temp_size_mol = Vec2(size_slider_camera[i].y *ratio_size_molette, size_slider_camera[i].y *ratio_size_molette) ;
    Vec2 temp_pos = Vec2(pos_slider_camera[i].x, pos_slider_camera[i].y -(slider_height *.6)) ;
    if(info_save_raw_list(info_slider_camera,i).a > -1 ) {
      slider_adj_camera[i] = new Slider_adjustable(temp_pos, size_slider_camera[i], temp_size_mol, "ELLIPSE");
      slider_adj_camera[i].set_id(i);
    }
  }

  // item
  for (int i = 0 ; i < NUM_SLIDER_ITEM ; i++) {
    Vec2 temp_size_mol = Vec2(size_slider_item[i].y *ratio_size_molette, size_slider_item[i].y *ratio_size_molette) ;
    Vec2 temp_pos = Vec2(pos_slider_item[i].x, pos_slider_item[i].y -(slider_height *.6)) ;
    if(info_save_raw_list(info_slider_item,i).a > -1 ) {
      slider_adj_item[i] = new Slider_adjustable(temp_pos, size_slider_item[i], temp_size_mol, "ELLIPSE");
      slider_adj_item[i].set_id(i);
    }
  }  
}


void display_slider() {
  //display_slider_general();
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
    int whichGroup = 0;
    display_slider_engine(slider_adj_background[i], whichGroup);
  }
}

void display_slider_filter() {
  slider_filter_display_bg();
  for (int i = 0 ; i < NUM_SLIDER_FILTER ; i++) {
    update_slider(slider_adj_filter[i],value_slider_filter,info_slider_filter);
    int whichGroup = 0;
    display_slider_engine(slider_adj_filter[i], whichGroup);
  }
}

void display_slider_light() {
  slider_light_0_display_bg();
  slider_light_1_display_bg();
  slider_light_2_display_bg();

  for (int i = 0 ; i < NUM_SLIDER_LIGHT ; i++) {
    update_slider(slider_adj_light[i],value_slider_light,info_slider_light);
    int whichGroup = 0;
    display_slider_engine(slider_adj_light[i], whichGroup);
  }
}

void display_slider_sound() {
  slider_sound_display_bg();
  for (int i = 0 ; i < NUM_SLIDER_SOUND ; i++) {
    update_slider(slider_adj_sound[i],value_slider_sound,info_slider_sound);
    int whichGroup = 0;
    display_slider_engine(slider_adj_sound[i], whichGroup);
  }
}

void display_slider_camera() {
  slider_camera_display_bg();
  for (int i = 0 ; i < NUM_SLIDER_CAMERA ; i++) {
    update_slider(slider_adj_camera[i],value_slider_camera,info_slider_camera);
    int whichGroup = 0;
    display_slider_engine(slider_adj_camera[i], whichGroup);
  }
}



























// SLIDER SETUP
// MAIN METHOD SLIDER SETUP
void set_slider() {
  //set_slider_general(correction_slider_general_pos_y) ;
  set_slider_background(correction_slider_general_pos_y);
  set_slider_filter(correction_slider_general_pos_y);
  set_slider_light(correction_slider_general_pos_y);
  set_slider_sound(correction_slider_general_pos_y);
  set_slider_camera(correction_slider_general_pos_y);

  set_slider_item_console(height_item_selected +local_pos_y_slider_button);
}



void set_slider_background(int correction_local_y) {
  for(int i = 0 ; i < NUM_SLIDER_BACKGROUND ;i++) {
    float posY = offset_background_y +correction_local_y +(i *spacing_slider);
    pos_slider_background[i] = Vec2(offset_background_x, posY);
    size_slider_background[i] = Vec2(slider_width,slider_height);
  }
}

void set_slider_filter(int correction_local_y) {
  for(int i = 0 ; i < NUM_SLIDER_FILTER ;i++) {
    float posY = offset_filter_y +correction_local_y +(i *spacing_slider);
    pos_slider_filter[i] = Vec2(offset_filter_x, posY);
    size_slider_filter[i] = Vec2(slider_width,slider_height);
  }
}

void set_slider_light(int correction_local_y) {
  int count = 0;
  int index = 0;
  for(int i = 0 ; i < NUM_SLIDER_LIGHT ;i++) {
    float posY = offset_light_y[index] +correction_local_y +(count *spacing_slider);
    pos_slider_light[i] = Vec2(offset_light_x[index], posY);
    size_slider_light[i] = Vec2(slider_width,slider_height);
    count++;
    if(count > 2) {
      index++;
      count = 0;
    }
  }
}

void set_slider_sound(int correction_local_y) {
  for(int i = 0 ; i < NUM_SLIDER_SOUND ;i++) {
    float posY = offset_sound_y +correction_local_y +(i *spacing_slider);
    pos_slider_sound[i] = Vec2(offset_sound_x, posY);
    size_slider_sound[i] = Vec2(slider_width,slider_height);
  }
}


void set_slider_camera(int correction_local_y) {
  for(int i = 0 ; i < NUM_SLIDER_CAMERA ;i++) {
    float posY = offset_camera_y +correction_local_y +(i *spacing_slider);
    pos_slider_camera[i] = Vec2(offset_camera_x, posY);
    size_slider_camera[i] = Vec2(slider_width,slider_height);
  }
}

void set_slider_item_console(int pos_y) {
  // where the controller must display the slider
  for( int i = 0 ; i < NUM_SLIDER_ITEM_BY_COL ; i++) {
    for (int j = 0 ; j < NUM_COL_SLIDER ; j++) {
      int whichSlider = i +(j *NUM_SLIDER_ITEM_BY_COL) ;
      int pos_x = 0 ;
      switch(j) {
        case 0 : pos_x = col_1; 
        break;
        case 1 : pos_x = col_2;
        break;
        case 2 : pos_x = col_3;
        break;
      }
      pos_slider_item[whichSlider] = Vec2(pos_x, pos_y +i *spacing_slider);
      size_slider_item[whichSlider] = Vec2(slider_width, slider_height);
    }
  }
}

































/**
SLIDER DISPLAY GENERAL
*/
void dispay_text_slider_top(int pos) {
  // GROUP ZERO
  textAlign(LEFT);
  textFont(textUsual_1) ; 
  fill (colorTextUsual) ;

  //BACKGROUND
  Vec2 pos_local = Vec2(slider_width+5,3);
  // background
  for(int i = 0 ; i < NUM_SLIDER_BACKGROUND ; i++) {
    text(slider_background_name[i], add(pos_slider_background[i],pos_local));
  }

  // filter
  for(int i = 0 ; i < NUM_SLIDER_FILTER ; i++) {
    text(slider_filter_name[i], add(pos_slider_filter[i],pos_local));
  }

  // light
  for(int i = 0 ; i < NUM_SLIDER_LIGHT ; i++) {
    text(slider_light_name[i], add(pos_slider_light[i],pos_local));
  }

  // sound
  for(int i = 0 ; i < NUM_SLIDER_SOUND ; i++ ) {
    text(slider_sound_name[i], add(pos_slider_sound[i],pos_local));
  }
  
  // CAMERA
  for(int i = 0 ; i < slider_camera_name.length ; i++) {
    text(slider_camera_name[i], add(pos_slider_camera[i],pos_local));
  }
}






// Slider display for the global slider background, camera, light, sound....
/*
When you add a new sliders, you must change the starting value from 'NAN' to a value between 0 and 1 in the file 'defaultSetting.csv' in the 'preferences/setting' folder.
And you must add the name of this one in the 'preferences/'  folder slider_name_en.csv' and in the 'slider_name_fr' file
*/
void slider_background_display_bg() {
  int start = 0 ;
  slider_display_hsb(pos_slider_background, size_slider_background, value_slider_background) ;
  slider_show_background(pos_slider_background[3], size_slider_background[3], rounded_slider, blancGris);
}


void slider_filter_display_bg() {
  // nothing at this time
}


void slider_light_0_display_bg() {
  int start = 0;
  int length = 3 ;
  Vec2 [] pos = new Vec2[length];
  Vec2 [] size = new Vec2[length];
  float [] value = new float[length];
  System.arraycopy(pos_slider_light,start,pos,0,length);
  System.arraycopy(size_slider_light,start,size,0,length);
  System.arraycopy(value_slider_light,start,value,0,length);
  slider_display_hsb(pos, size, value);
}

void slider_light_1_display_bg() {
  int start = 3 ;
  int length = 3 ;
  Vec2 [] pos = new Vec2[length];
  Vec2 [] size = new Vec2[length];
  float [] value = new float[length];
  System.arraycopy(pos_slider_light,start,pos,0,length);
  System.arraycopy(size_slider_light,start,size,0,length);
  System.arraycopy(value_slider_light,start,value,0,length);
  slider_display_hsb(pos, size, value);
}

void slider_light_2_display_bg() {
  int start = 6 ;
  int length = 3 ;
  Vec2 [] pos = new Vec2[length];
  Vec2 [] size = new Vec2[length];
  float [] value = new float[length];
  System.arraycopy(pos_slider_light,start,pos,0,length);
  System.arraycopy(size_slider_light,start,size,0,length);
  System.arraycopy(value_slider_light,start,value,0,length);
  slider_display_hsb(pos, size, value);
}

void slider_sound_display_bg() {
  slider_show_background(pos_slider_sound[0], size_slider_sound[0], rounded_slider, grisClair) ;
  slider_show_background(pos_slider_sound[1], size_slider_sound[1], rounded_slider, grisClair) ;
}

void slider_camera_display_bg() {
  // we cannot loop, because we change the color of display at the end of the function
  slider_show_background(pos_slider_camera[0], size_slider_camera[0], rounded_slider, grisClair);
  slider_show_background(pos_slider_camera[1], size_slider_camera[1], rounded_slider, grisClair);
  slider_show_background(pos_slider_camera[2], size_slider_camera[2], rounded_slider, blancGris);
  slider_show_background(pos_slider_camera[3], size_slider_camera[3], rounded_slider, blancGris);
  slider_show_background(pos_slider_camera[4], size_slider_camera[4], rounded_slider, blancGris);
  slider_show_background(pos_slider_camera[5], size_slider_camera[5], rounded_slider, grisClair);
  slider_show_background(pos_slider_camera[6], size_slider_camera[6], rounded_slider, grisClair);
  slider_show_background(pos_slider_camera[7], size_slider_camera[7], rounded_slider, grisClair);
  slider_show_background(pos_slider_camera[8], size_slider_camera[8], rounded_slider, grisClair);
}

// supra local void
void slider_display_hsb(Vec2 [] pos, Vec2 [] size, float [] value) {
  if (mouseX > (pos[0].x ) && mouseX < ( pos[0].x +size[0].x) 
      && mouseY > ( pos[0].y - 5) && mouseY < pos[0].y +40) {
    slider_show_hue_background(pos[0], size[0]) ;
    slider_show_saturation_background(pos[1], size[1], value[0], value[1], value[2] ) ;
    slider_show_brightness_background(pos[2], size[2], value[0], value[1], value[2] ) ;
  } else {
    slider_show_background(pos[0], size[0], rounded_slider, grisClair);
    slider_show_background(pos[1], size[1], rounded_slider, grisClair);
    slider_show_background(pos[2], size[2], rounded_slider, grisClair);
  }
}











/**
Item slider
*/
/*
When you add a new sliders, you must change the starting value from 'NAN' to a value between 0 and 1 in the file 'defaultSetting.csv' in the 'preferences/setting' folder.
And you must add the name of this one in the 'preferences/'  folder slider_name_en.csv' and in the 'slider_name_fr' file
*/
void display_slider_item() {
  /* different way to display depend the displaying mode. 
  Can change with "ctrl+x" */
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
              display_slider_engine(slider_adj_item[k], whichGroup); 
            }
          }
        }
      }
    }
  } else {
    for(int i = 0 ; i < NUM_SLIDER_ITEM ; i++) {
      update_slider(slider_adj_item[i],value_slider_item,info_slider_item);
      display_slider_engine(slider_adj_item[i], whichGroup);
    }
  } 
}




void dislay_text_slider_item() {
  fill(colorTextUsual);
  textFont(textUsual_1);  
  textAlign(LEFT);
  
  // Legend text slider position for the item
  int correction_local_y = local_pos_y_slider_button +4 ;
  int correction_local_x = slider_width + 5 ;
  for (int i = 0 ; i < NUM_SLIDER_ITEM_BY_COL ; i++) {
    int which_one = i+(NUM_SLIDER_ITEM_BY_COL *0);
    int which_two = i+(NUM_SLIDER_ITEM_BY_COL *1);
    int which_three = i+(NUM_SLIDER_ITEM_BY_COL *2);
    int factor = i;
    // change name for few slider from col 1
    String switch_text = slider_item_name[which_one];
    if(switch_text.equals("f_hue")) switch_text = "FILL";
    else if(switch_text.equals("f_saturation")) switch_text = "saturation";
    else if(switch_text.equals("f_brightness")) switch_text = "brightness";
    else if(switch_text.equals("f_alpha")) switch_text = "alpha";
    else if(switch_text.equals("s_hue")) switch_text = "STROKE";
    else if(switch_text.equals("s_saturation")) switch_text = "saturation";
    else if(switch_text.equals("s_brightness")) switch_text = "brightness";
    else if(switch_text.equals("s_alpha")) switch_text = "alpha";
    else if(switch_text.equals("thickness")) switch_text = "THICKNESS";
    text(switch_text, col_1 +correction_local_x, height_item_selected +correction_local_y +(factor *spacing_slider));
    // no change for text for col 2 and 3
    text(slider_item_name[which_two], col_2 +correction_local_x, height_item_selected +correction_local_y +(factor *spacing_slider));
    text(slider_item_name[which_three], col_3 +correction_local_x, height_item_selected +correction_local_y +(factor *spacing_slider));
  }
}






void display_bg_slider_item() {
  // to find the good slider in the array
  int whichGroup = 1 ;
  // COL 1
  slider_HSB_item_display(whichGroup, hue_fill_rank, sat_fill_rank, bright_fill_rank) ;
  if (display_slider[whichGroup][alpha_fill_rank]) slider_show_background(pos_slider_item[alpha_fill_rank], size_slider_item[alpha_fill_rank], rounded_slider, blanc ) ;
  
  //outline color
  slider_HSB_item_display(whichGroup, hue_stroke_rank, sat_stroke_rank, bright_stroke_rank) ;
  if (display_slider[whichGroup][alpha_stroke_rank]) slider_show_background(pos_slider_item[alpha_stroke_rank], size_slider_item[alpha_stroke_rank], rounded_slider, blancGrisClair) ;
  //  thickness
  if (display_slider[whichGroup][thickness_rank]) slider_show_background(pos_slider_item[thickness_rank], size_slider_item[thickness_rank], rounded_slider, blanc) ;
  // size
  if (display_slider[whichGroup][size_x_rank]) slider_show_background(pos_slider_item[size_x_rank], size_slider_item[size_x_rank], rounded_slider, blancGrisClair) ;
  if (display_slider[whichGroup][size_y_rank]) slider_show_background(pos_slider_item[size_y_rank], size_slider_item[size_y_rank], rounded_slider, blancGrisClair) ;
  if (display_slider[whichGroup][size_z_rank]) slider_show_background(pos_slider_item[size_z_rank], size_slider_item[size_z_rank], rounded_slider, blancGrisClair) ;
  // Font size
  if(display_slider[whichGroup][font_size_rank]) slider_show_background(pos_slider_item[font_size_rank], size_slider_item[font_size_rank], rounded_slider, blancGrisClair) ;
  // canvas
  if (display_slider[whichGroup][canvas_x_rank]) slider_show_background (pos_slider_item[canvas_x_rank], size_slider_item[canvas_x_rank], rounded_slider, blanc) ;
  if (display_slider[whichGroup][canvas_y_rank]) slider_show_background(pos_slider_item[canvas_y_rank], size_slider_item[canvas_y_rank], rounded_slider, blanc) ;
  if (display_slider[whichGroup][canvas_z_rank]) slider_show_background(pos_slider_item[canvas_z_rank], size_slider_item[canvas_z_rank], rounded_slider, blanc) ;

  

  // COL 2
  // reactivity
  if(display_slider[whichGroup][reactivity_rank]) slider_show_background(pos_slider_item[reactivity_rank], size_slider_item[reactivity_rank], rounded_slider, blancGrisClair) ;
  // speed
  if(display_slider[whichGroup][speed_x_rank]) slider_show_background(pos_slider_item[speed_x_rank], size_slider_item[speed_x_rank], rounded_slider, blanc) ;
  if(display_slider[whichGroup][speed_y_rank]) slider_show_background(pos_slider_item[speed_y_rank], size_slider_item[speed_y_rank], rounded_slider, blanc) ;
  if(display_slider[whichGroup][speed_z_rank]) slider_show_background(pos_slider_item[speed_z_rank], size_slider_item[speed_z_rank], rounded_slider, blanc) ;
  // spurt
  if(display_slider[whichGroup][spurt_x_rank]) slider_show_background(pos_slider_item[spurt_x_rank], size_slider_item[spurt_x_rank], rounded_slider, blancGrisClair) ;
  if(display_slider[whichGroup][spurt_y_rank]) slider_show_background(pos_slider_item[spurt_y_rank], size_slider_item[spurt_y_rank], rounded_slider, blancGrisClair) ;
  if(display_slider[whichGroup][spurt_z_rank]) slider_show_background(pos_slider_item[spurt_z_rank], size_slider_item[spurt_z_rank], rounded_slider, blancGrisClair) ;
  // direction
  if(display_slider[whichGroup][dir_x_rank]) slider_show_background(pos_slider_item[dir_x_rank], size_slider_item[dir_x_rank], rounded_slider, blanc) ;
  if(display_slider[whichGroup][dir_y_rank]) slider_show_background(pos_slider_item[dir_y_rank], size_slider_item[dir_y_rank], rounded_slider, blanc) ;
  if(display_slider[whichGroup][dir_z_rank]) slider_show_background(pos_slider_item[dir_z_rank], size_slider_item[dir_z_rank], rounded_slider, blanc) ;
  // jitter
  if(display_slider[whichGroup][jitter_x_rank]) slider_show_background(pos_slider_item[jitter_x_rank], size_slider_item[jitter_x_rank], rounded_slider, blancGrisClair) ;
  if(display_slider[whichGroup][jitter_y_rank]) slider_show_background(pos_slider_item[jitter_y_rank], size_slider_item[jitter_y_rank], rounded_slider, blancGrisClair) ;
  if(display_slider[whichGroup][jitter_z_rank]) slider_show_background(pos_slider_item[jitter_z_rank], size_slider_item[jitter_z_rank], rounded_slider, blancGrisClair) ;
  // swing
  if(display_slider[whichGroup][swing_x_rank]) slider_show_background(pos_slider_item[swing_x_rank], size_slider_item[swing_x_rank], rounded_slider, blancGrisClair) ;
  if(display_slider[whichGroup][swing_y_rank]) slider_show_background(pos_slider_item[swing_y_rank], size_slider_item[swing_y_rank], rounded_slider, blancGrisClair) ;
  if(display_slider[whichGroup][swing_z_rank]) slider_show_background(pos_slider_item[swing_z_rank], size_slider_item[swing_z_rank], rounded_slider, blancGrisClair) ;

  
  // COL 3
  // quantity
  if(display_slider[whichGroup][quantity_rank]) slider_show_background(pos_slider_item[quantity_rank], size_slider_item[quantity_rank], rounded_slider, blancGrisClair) ;
  // variety
  if(display_slider[whichGroup][variety_rank]) slider_show_background(pos_slider_item[variety_rank], size_slider_item[variety_rank], rounded_slider, blancGrisClair) ; 
  // life
  if(display_slider[whichGroup][life_rank]) slider_show_background(pos_slider_item[life_rank], size_slider_item[life_rank], rounded_slider, blancGrisClair) ;
  // fertility
  if(display_slider[whichGroup][flow_rank]) slider_show_background(pos_slider_item[flow_rank], size_slider_item[flow_rank], rounded_slider, blancGrisClair) ;
  // quality
  if(display_slider[whichGroup][quality_rank]) slider_show_background(pos_slider_item[quality_rank], size_slider_item[quality_rank], rounded_slider, blancGrisClair) ;
  
  // area
  if(display_slider[whichGroup][area_rank]) slider_show_background(pos_slider_item[area_rank], size_slider_item[area_rank], rounded_slider, blancGrisClair) ;
  // angle
  if(display_slider[whichGroup][angle_rank]) slider_show_background(pos_slider_item[angle_rank], size_slider_item[angle_rank], rounded_slider, blancGrisClair) ;
  // scope
  if(display_slider[whichGroup][scope_rank]) slider_show_background(pos_slider_item[scope_rank], size_slider_item[scope_rank], rounded_slider, blancGrisClair) ;
  // scan
  if(display_slider[whichGroup][scan_rank]) slider_show_background(pos_slider_item[scan_rank], size_slider_item[scan_rank], rounded_slider, blancGrisClair) ;
  
  // alignment
  if(display_slider[whichGroup][alignment_rank]) slider_show_background(pos_slider_item[alignment_rank], size_slider_item[alignment_rank], rounded_slider, blancGrisClair) ;
  // repulsion
  if(display_slider[whichGroup][repulsion_rank]) slider_show_background(pos_slider_item[repulsion_rank], size_slider_item[repulsion_rank], rounded_slider, blancGrisClair) ;
  // attraction
  if(display_slider[whichGroup][attraction_rank]) slider_show_background(pos_slider_item[attraction_rank], size_slider_item[attraction_rank], rounded_slider, blancGrisClair) ;
  // density
  if(display_slider[whichGroup][density_rank]) slider_show_background(pos_slider_item[density_rank], size_slider_item[density_rank], rounded_slider, blancGrisClair) ;
  
  // influence
  if(display_slider[whichGroup][influence_rank]) slider_show_background(pos_slider_item[influence_rank], size_slider_item[influence_rank], rounded_slider, blancGrisClair) ;
  // calm
  if(display_slider[whichGroup][calm_rank]) slider_show_background(pos_slider_item[calm_rank], size_slider_item[calm_rank], rounded_slider, blancGrisClair) ;
  // spectrum
  //println(display_slider[1].length, spectrum_rank);
  if(display_slider[whichGroup][spectrum_rank]) slider_show_background(pos_slider_item[spectrum_rank], size_slider_item[spectrum_rank], rounded_slider, blancGrisClair) ;
}
// local void to display the HSB slider and display the specific color of this one
void slider_HSB_item_display(int whichGroup, int hueRank, int satRank, int brightRank) {
  if (mouseX > (pos_slider_item[hueRank].x ) && mouseX < (pos_slider_item[hueRank].x +size_slider_item[hueRank].x) 
       && mouseY > (pos_slider_item[hueRank].y - 5) && mouseY < pos_slider_item[hueRank].y +30) 
  {
    if (display_slider[whichGroup][hueRank]) slider_show_hue_background(pos_slider_item[hueRank], size_slider_item[hueRank]) ; 
    if (display_slider[whichGroup][satRank]) slider_show_saturation_background(pos_slider_item[satRank], size_slider_item[satRank], value_slider_item[hueRank], value_slider_item[satRank], value_slider_item[brightRank]) ;
    if (display_slider[whichGroup][brightRank]) slider_show_brightness_background(pos_slider_item[brightRank], size_slider_item[brightRank], value_slider_item[hueRank], value_slider_item[satRank], value_slider_item[brightRank]) ;
  } else {
    if (display_slider[whichGroup][hueRank]) slider_show_background(pos_slider_item[hueRank], size_slider_item[hueRank], rounded_slider, blanc);
    if (display_slider[whichGroup][satRank]) slider_show_background(pos_slider_item[satRank], size_slider_item[satRank], rounded_slider, blanc);
    if (display_slider[whichGroup][brightRank]) slider_show_background(pos_slider_item[brightRank], size_slider_item[brightRank], rounded_slider, blanc);
  }
}







































/**
slider method
*/
void slider_show_background(Vec2 pos, Vec2 size, int rounded, int c) {
  fill(c);
  rect(pos.x, pos.y -(size.y *.5), size.x, size.y, rounded);

}

// hue
void slider_show_hue_background(Vec2 pos, Vec2 size) {
  pushMatrix ();
  translate (pos.x , pos.y -(size.y *.5));
  for (int i = 0 ; i < size.x ; i++) {
    for (int j = 0 ; j <= size.y ; j++) {
      float cr = map(i,0,size.x,0,360);
      fill (cr,100,100);
      rect (i,j,1,1);
    }
  }
  popMatrix();
}

// saturation
void slider_show_saturation_background(Vec2 pos, Vec2 size, float colour, float s, float d) {
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
void slider_show_brightness_background(Vec2 pos, Vec2 size, float colour, float s, float d) {
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


void update_slider(Slider_adjustable sa, float [] value_slider, Vec5 [] info_slider) {
  //MIDI update
  update_midi_slider(sa,info_slider);
  // MIN and MAX molette
  //check
  if(!sa.lockedMol && !sa.insideMol) {
    // min molette
    if(!sa.insideMax() && !sa.lockedMax) {
      sa.insideMin();
      sa.select_min();
      sa.update_min();
    }
    // max molette
    if(!sa.insideMin() && !sa.lockedMin) {
      sa.insideMax();
      sa.select_max();
      sa.update_max();
    }
  }
  // update 
  sa.update_min_max();
  
  
  // CURRENT molette
  // check
  if(!sa.lockedMax && !sa.lockedMax) sa.insideMol_Ellipse() ;
  // update
  sa.select_molette();
  sa.update_molette();
  
  // translate float value to int, to use OSC easily without problem of Array Outbound...blablah
  int valueMax = 360 ;
  value_slider[sa.get_id()] = constrain(map(sa.get_value(),0,1,0,valueMax),0,valueMax)  ;
}




void display_slider_engine(Slider_adjustable sa, int whichGroup) {
  if (whichGroup == 0) {
    display_min_max_slider(sa, grisTresFonce, gris);
    display_mollette(sa, blanc, blancGris);
  } else {
    display_min_max_slider(sa, grisFonce, grisClair);
    display_mollette(sa, blanc, blancGris);
  }
}

void display_min_max_slider(Slider_adjustable sa, color colorIn, color colorOut) {
  float thickness = 0 ;
  sa.display_min_max(ratio_pos_slider_adjustable, ratio_size_slider_adjustable, colorIn, colorOut, colorIn, colorOut, thickness) ;
}

void display_mollette(Slider_adjustable sa, color colorMolIn, color colorMolOut) {
  sa.show_molette(colorMolIn,colorMolOut, colorMolIn,colorMolOut,1);
}


































/**
BUTTON
v 1.0.0
*/
/**
BUTTON BUILD
*/
Button  button_midi, button_curtain,
        button_bg, 
        button_light_ambient, button_light_ambient_action,
        button_light_1, button_light_1_action,
        button_light_2, button_light_2_action,
        button_beat, button_kick, button_snare, button_hat;


// init button
void init_button_general() {
  numButton = new int[NUM_GROUP_SLIDER] ;
  numButton[0] = 20 ;
  value_button_general = new int[numButton[0]] ;
}


// build button
void build_button_general() {
  //MIDI
  button_midi  = new Button(pos_midi_button, size_midi_button) ;
  //curtain
  button_curtain  = new Button(pos_curtain_button, size_curtain_button) ;
  // General
  button_bg = new Button(pos_bg_button, size_bg_button) ;
  button_bg.set_on_off(true) ;
  button_bg.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;
  // LIGHT AMBIENT
  button_light_ambient = new Button(posLightAmbientButton, sizeLightAmbientButton) ;
  button_light_ambient.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;

  button_light_ambient_action = new Button(posLightAmbientAction, sizeLightAmbientAction) ;
  button_light_ambient_action.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;
  // LIGHT ONE
  button_light_1 = new Button(posLightOneButton, sizeLightOneButton) ;
  button_light_1.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;

  button_light_1_action = new Button(posLightOneAction, sizeLightOneAction) ;
  button_light_1_action.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;
  // LIGHT TWO 
  button_light_2 = new Button(posLightTwoButton, sizeLightTwoButton) ;
  button_light_2.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;
  button_light_2_action = new Button(posLightTwoAction, sizeLightTwoAction) ;
  button_light_2_action.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;
  
  /**
  Sound
  */
  button_beat = new Button(pos_beat_button, size_beat_button) ;
  button_beat.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;

  button_kick = new Button(pos_kick_button, size_kick_button) ;
  button_kick.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;

  button_snare = new Button(pos_snare_button, size_snare_button) ;
  button_snare.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;

  button_hat = new Button(pos_hat_button, size_hat_button) ;
  button_hat.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;
}













/**
Setting button
*/
void set_button_general() {
  // MIDI
  size_midi_button = Vec2(50,26);
  pos_midi_button = Vec2(col_1 +correctionMidiX, pos_y_button_top +correctionMidiY);
  pos_midi_info =Vec2(pos_midi_button.x +correction_info_midi_x, pos_midi_button.y +correction_info_midi_y);
  // CURTAIN
  size_curtain_button = Vec2(30,30);
  pos_curtain_button = Vec2(col_1 +correctionCurtainX, pos_y_button_top +correctionCurtainY); 
  
  
  // BACKGROUND
  pos_bg_button = Vec2(offset_background_x, offset_background_y +correction_button_txt_y);
  size_bg_button = Vec2(120,10);
  
  // LIGHT
  // ambient button
  posLightAmbientButton = Vec2(offset_light_x[0], offset_light_y[0] +correction_button_txt_y);
  sizeLightAmbientButton = Vec2(80,10);
  posLightAmbientAction = Vec2(offset_light_x[0] +90, posLightAmbientButton.y); // for the y we take the y of the button
  sizeLightAmbientAction = Vec2(45,10);
  // light one button
  posLightOneButton = Vec2(offset_light_x[1], offset_light_y[1] +correction_button_txt_y);
  sizeLightOneButton = Vec2(80,10);
  posLightOneAction = Vec2(offset_light_x[1] +90, posLightOneButton.y); // for the y we take the y of the button
  sizeLightOneAction = Vec2(45,10);
  // light two button
  posLightTwoButton = Vec2(offset_light_x[2], offset_light_y[2] +correction_button_txt_y);
  sizeLightTwoButton = Vec2(80,10);
  posLightTwoAction = Vec2(offset_light_x[2] +90, posLightTwoButton.y); // for the y we take the y of the button
  sizeLightTwoAction = Vec2(45,10);
  
  //SOUND BUTTON
  size_beat_button = Vec2(30,10); 
  size_kick_button = Vec2(30,10); 
  size_snare_button = Vec2(40,10); 
  size_hat_button = Vec2(30,10);
  
  pos_beat_button = Vec2(offset_sound_x, offset_sound_y +correction_button_txt_y); 
  pos_kick_button = Vec2(pos_beat_button.x +size_beat_button.x +5, offset_sound_y +correction_button_txt_y); 
  pos_snare_button = Vec2(pos_kick_button.x +size_kick_button.x +5, offset_sound_y +correction_button_txt_y); 
  pos_hat_button = Vec2(pos_snare_button.x +size_snare_button.x +5, offset_sound_y +correction_button_txt_y);
}






/**
Display Button
*/
/**
MAIN METHOD
*/
void display_button_and_dropdown() {
  display_button_general() ;
  display_button_item_console() ;
  display_button_inventory_item() ;
  display_dropdown() ;

  button_header() ;
  midiButtonManager(false) ;
}

void check_button() {
  check_button_general() ;
  check_button_item_console() ;
  check_button_inventory_item() ;
}

void mousepressed_button_general() {
  if(!dropdownActivity) {
    button_bg.mousePressedText() ;
    //LIGHT ONE
    button_light_ambient.mousePressedText() ;
    button_light_ambient_action.mousePressedText() ;
    //LIGHT ONE
    button_light_1.mousePressedText() ;
    button_light_1_action.mousePressedText() ;
    // LIGHT TWO
    button_light_2.mousePressedText() ;
    button_light_2_action.mousePressedText() ;
    //son
    button_beat.mousePressedText() ;
    button_kick.mousePressedText() ;
    button_snare.mousePressedText() ;
    button_hat.mousePressedText() ;
    //midi
    button_midi.mousePressed() ;
    //curtain
    button_curtain.mousePressed() ;
  }
}

/**
DRAW LOCAL METHOD
*/
void button_header() {
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
  button_bg.button_text(shader_bg_name[which_bg_shader] + " on/off", pos_bg_button, titleButtonMedium, sizeTitleButton) ;
  //button_bg.button_text(shader_bg_name[state_bg_shader] + " on/off", pos_bg_button, titleButtonMedium, sizeTitleButton) ;
  // Light ambient
  button_light_ambient.button_text("Ambient on/off", posLightAmbientButton, titleButtonMedium, sizeTitleButton) ;
  button_light_ambient_action.button_text("action", posLightAmbientAction, titleButtonMedium, sizeTitleButton) ;
  //LIGHT ONE
  button_light_1.button_text("Light on/off", posLightOneButton, titleButtonMedium, sizeTitleButton) ;
  button_light_1_action.button_text("action", posLightOneAction, titleButtonMedium, sizeTitleButton) ;
  // LIGHT TWO
  button_light_2.button_text("Light on/off",  posLightTwoButton, titleButtonMedium, sizeTitleButton) ;
  button_light_2_action.button_text("action",  posLightTwoAction, titleButtonMedium, sizeTitleButton) ;
  
  // SOUND
  button_beat.button_text("BEAT", pos_beat_button, titleButtonMedium, sizeTitleButton) ;
  button_kick.button_text("KICK", pos_kick_button, titleButtonMedium, sizeTitleButton) ;
  button_snare.button_text("SNARE", pos_snare_button, titleButtonMedium, sizeTitleButton) ;
  button_hat.button_text("HAT", pos_hat_button, titleButtonMedium, sizeTitleButton) ;
  
  //MIDI / CURTAIN
  button_midi.button_pic(picMidi) ;
  button_curtain.button_pic(picCurtain) ;
}

void check_button_general() {
  /* Check to send by OSC to Scene and Prescene */
  if(button_bg.on_off) state_BackgroundButton = 1 ; else state_BackgroundButton = 0 ;
  //LIGHT ONE
  if(button_light_ambient.on_off)  state_LightAmbientButton = 1 ; else  state_LightAmbientButton = 0 ;
  if(button_light_ambient_action.on_off) state_LightAmbientAction = 1 ; else state_LightAmbientAction =  0 ;
  //LIGHT ONE
  if(button_light_1.on_off) state_LightOneButton = 1 ; else state_LightOneButton = 0 ;
  if(button_light_1_action.on_off) state_LightOneAction = 1 ; else state_LightOneAction = 0 ;
  // LIGHT TWO
  if(button_light_2.on_off) state_LightTwoButton = 1 ; else state_LightTwoButton = 0 ;
  if(button_light_2_action.on_off) state_LightTwoAction = 1 ; else state_LightTwoAction = 0 ;
  //SOUND
  if(button_beat.on_off) state_button_beat = 1 ; else state_button_beat = 0 ;
  if(button_kick.on_off) state_button_kick = 1 ; else state_button_kick = 0 ;
  if(button_snare.on_off) state_button_snare = 1 ; else state_button_snare = 0 ;
  if(button_hat.on_off) state_button_hat = 1 ; else state_button_hat = 0 ;
  //Check position of button
  if(button_midi.on_off) state_midi_button = 1 ; else state_midi_button = 0 ;
  if(button_curtain.on_off) state_curtain_button = 1 ; else state_curtain_button = 0 ;
}





























/**
DROPDOWN 
v 1.1.0
*/
// int ref_size_image_bitmap_dropdown, ref_size_image_svg_dropdown, ref_size_movie_dropdown, refSizeFileTextDropdown, refSizeCameraVideoDropdown ;
PVector pos_text_dropdown_image_bitmap, pos_text_dropdown_image_svg, pos_text_dropdown_movie, posTextdropdown_file_text, posTextdropdown_camera_video ; 
color selectedText;
color colorBoxIn, colorBoxOut, colorBoxText;
color colorDropdownBG;
color color_dropdown_header_in, color_dropdown_header_out;
color color_dropdown_item_in, color_dropdown_item_out;

void init_dropdown() {
  // dropdown bar
  dropdown_bar = new Dropdown[num_dropdown_bar];
  dropdown_bar_pos = new Vec3[num_dropdown_bar];
  dropdown_bar_size = new Vec2[num_dropdown_bar];
  dropdown_bar_pos_text = new Vec2[num_dropdown_bar];
  dropdown_content = new String[num_dropdown_bar][0];

  // dropdown item
  num_dropdown_item = NUM_ITEM +1; // add one for the dropdownmenu
  lastDropdown = num_dropdown_item -1;
  mode_list_RPE = new String[num_dropdown_item];
  dropdown_item_mode = new Dropdown[num_dropdown_item];
  pos_dropdown = new Vec3[num_dropdown_item];

  for(int i = 0 ; i < num_dropdown_item ; i++) {
    pos_dropdown[i] = Vec3();
  }
}




void set_dropdown_general() {
  colorDropdownBG = rougeTresFonce ;
  color_dropdown_header_in = jaune ;
  color_dropdown_header_out = orange ;
  color_dropdown_item_in = rouge ;
  color_dropdown_item_out = rougeTresFonce ;
  colorBoxIn = jaune ; 
  colorBoxOut = orange ;
  colorBoxText = rougeFonce ;
  selectedText = vertFonce ;

  //load the external list  for each mode and split to read in the interface
  for (int i = 0 ; i<inventory_item_table.getRowCount() ; i++) {
    TableRow row = inventory_item_table.getRow(i);
    mode_list_RPE [row.getInt("ID")] = row.getString("Mode"); 
  }
  //font
  String pList [] = loadStrings(import_path+"font/fontList.txt") ;
  String policeList = join(pList, "") ;
  font_dropdown_list = split(policeList, "/") ;
  
  //image
  update_media() ;
 
  for(int i = 0 ; i < dropdown_bar.length ; i++) {
    dropdown_bar_pos[i] = Vec3(pos_x_dropdown_bar[i],pos_y_dropdown_bar, .1);
    dropdown_bar_size[i] = Vec2(width_dropdown_bar[i],height_dropdown_header_bar);
    int num_box = 7;
    dropdown_bar_pos_text[i] = Vec2(3,10);
    ROPE_color dropdown_color_bar = new ROPE_color(colorDropdownBG, colorBoxIn, colorBoxOut, color_dropdown_header_in, color_dropdown_header_out, colorBoxText);
    dropdown_bar[i] = new Dropdown(name_dropdown_bar[i],dropdown_content[i],dropdown_bar_pos[i],dropdown_bar_size[i],dropdown_bar_pos_text[i], dropdown_color_bar,num_box, height_box_dropdown);
    dropdown_bar[i].set_font_header(title_dropdown_medium);
    dropdown_bar[i].set_font_box(textUsual_1);
  }
}

void set_dropdown_item_selected() {
  //common param
  int num_box = 7;
  size_dropdown_mode = Vec2(20,15);
  float x = offset_y_item + -8;
  float y = height_item_selected +local_pos_y_dropdown_item_selected;
  float z = .1;

  ROPE_color dropdown_color_item = new ROPE_color(colorDropdownBG, colorBoxIn, colorBoxOut, color_dropdown_item_in, color_dropdown_item_out, colorBoxText);
  // group item
  for (int i = 0 ; i <= NUM_ITEM ; i++ ) {
    if(mode_list_RPE[i] != null) {
      //Split the dropdown to display in the dropdown
      String [] item_mode_dropdown_list = split(mode_list_RPE[i], "/" ) ;
      //to change the title of the header dropdown
      pos_dropdown[i].set(x, y, z) ; // 'x' 'y' is pos and 'z' is marge between the dropdown and the header
      dropdown_item_mode[i] = new Dropdown("M", 
                                  item_mode_dropdown_list, 
                                  pos_dropdown[i], 
                                  size_dropdown_mode, 
                                  posTextDropdown, 
                                  dropdown_color_item,
                                  num_box, 
                                  height_box_dropdown) ;
      dropdown_item_mode[i].set_font_header(title_dropdown_medium);
      dropdown_item_mode[i].set_font_box(textUsual_1);

    }
  }
}









// DRAW DROPDOWN
boolean dropdownActivity ;
int dropdownActivityCount ;
void display_dropdown() {
  update_dropdown_bar_content() ;
  
  // update_dropdown_background() ;
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










// Annexe method
int update_dropdown_bar(Dropdown dd) {
  int content_line = SWITCH_VALUE_FOR_DROPDOWN ;
  dd.update();
  
  if (dropdownOpen) dropdownActivityCount = +1 ;
  marge_around_dropdown = dd.get_size().y  ;
  //give the size of menu recalculate with the size of the word inside
  Vec2 new_size = dd.size_box.copy();
  //compare the standard size of dropdown with the number of element of the list.
  int height_dd_open = 0 ;
  if(dd.get_content().length < dd.get_num_box()) {
    height_dd_open = dd.get_content().length; 
  } else {
    height_dd_open = dd.get_num_box();
  }


  Vec2 temp_size = Vec2(new_size.x +(marge_around_dropdown *1.5), dd.get_size().y *height_dd_open +marge_around_dropdown) ; // we must add +1 to the size of the dropdown for the title plus the item list
  //new pos to include the slider
  Vec2 temp_pos = Vec2(dd.get_pos().x -marge_around_dropdown, dd.get_pos().y);
  if(!inside(temp_pos,temp_size,Vec2(mouseX,mouseY),RECT)) dd.locked = false;
  

  // display the selection
  if(!dd.locked && dd.get_content().length > 0) {
    fill(selectedText) ;
    content_line = dd.get_content_line() ;
    textFont(dd.get_font_header());
    text(dd.get_content()[dd.get_content_line()], dd.get_pos().x +3 , dd.get_pos().y +22) ;
  }
  return content_line ;
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
  for (int i = 1 ; i <= NUM_ITEM ; i++) {
    if(mode_list_RPE[i] != null && on_off_inventory_item[i].on_off) {
      int distance = pointer *STEP_ITEM ;
      pointer ++ ;

      dropdown_item_mode[i].change_pos(distance, 0) ;

      String m [] = split(mode_list_RPE[i], "/") ;
      if ( m.length > 1) {
        dropdown_item_mode[i].update();
        if (dropdownOpen) dropdownActivityCount++ ;
        marge_around_dropdown = size_dropdown_mode.y  ;

        //give the size of menu recalculate with the size of the word inside
        Vec2 newSizeModeTypo = dropdown_item_mode[i].size_box.copy();
        int heightDropdown = 0 ;

        if(dropdown_item_mode[i].content.length <  dropdown_item_mode[i].get_num_box()) {
          heightDropdown = dropdown_item_mode[i].content.length ; 
        } else {
          heightDropdown = dropdown_item_mode[i].get_num_box();
        }

        Vec2 temp_size = Vec2(newSizeModeTypo.x +(marge_around_dropdown *1.5), size_dropdown_mode.y *(heightDropdown +1) +marge_around_dropdown) ; // we must add +1 to the size of the dropdown for the title plus the item list
        
        //new pos to include the slider
        Vec2 temp_pos = Vec2(dropdown_item_mode[i].get_pos().x -marge_around_dropdown, dropdown_item_mode[i].get_pos().y) ;
        if (!inside(temp_pos,temp_size,Vec2(mouseX,mouseY),RECT)) {
          dropdown_item_mode[i].locked = false;
        }
      }
      // display which element is selected
      if (dropdown_item_mode[i].get_content_line() > -1 && m.length > 1) {
        textFont(title_dropdown_medium);      
        text(dropdown_item_mode[i].get_content_line() +1, dropdown_item_mode[i].get_pos().x +12, dropdown_item_mode[i].get_pos().y +8) ;
      }
    }
  }
}









// DROPDOWN MOUSEPRESSED
void mousepressed_dropdown() {
  // dropdown bar
  for(int i = 0 ; i < dropdown_bar.length ; i++) {
    check_dropdown_mousepressed (dropdown_bar[i]);
  }
  // Item menu
  for(int i = 0 ; i < dropdown_item_mode.length ; i++) {
    check_dropdown_mousepressed(dropdown_item_mode[i]);
  } 
}

void check_dropdown_mousepressed(Dropdown dd) {
  if (dd != null) {
    if (inside(dd.get_pos(), dd.get_size(),Vec2(mouseX,mouseY),RECT) && !dd.locked) {
      dd.locked = true;
    } else if (dd.locked) {
      // println("locked",dd.get_name(),frameCount);
      float new_width = dd.size_box.x ;
      int line = dd.selectDropdownLine(new_width);
      if (line > -1 ) {
        dd.whichDropdownLine(line);
        dd.locked = false;        
      } 
    }
  }
}

























/**
OTHER METHOD 
*/
//show info
void text_info_object(PVector pos, PVector size, int IDorder, int IDfamily) {
  if (mouseX > pos.x && mouseX < (size.x + pos.x ) && mouseY > pos.y - 10 && mouseY <  (size.y + pos.y) -20 ) {
    PVector fontPos = new PVector(-10, -20 ) ;
    
    if (NUM_ITEM > 0 ) {
      display_info_object(IDorder, fontPos) ;
    }
  }
}





void display_info_object(int IDorder, PVector pos) {
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
  int diam = size_angle ;
  int speed = speed_rotation ;
  Vec2 a = Vec2(pos.x + 0,pos.y + 0).revolution(diam *3, speed/2) ;
  Vec2 b = Vec2(pos.x + width_rect, pos.y + 0).revolution(int(diam *1.5), speed) ;
  Vec2 c = Vec2(pos.x + width_rect, pos.y + height_rect).revolution(diam *2, int(speed *1.2)) ;
  Vec2 d = Vec2(pos.x + 0, pos.y + height_rect).revolution(diam, int(speed *.7)) ;
  
  // display background
  beginShape() ;
  vertex(a.x, a.y) ;
  vertex(b.x, b.y) ;
  vertex(c.x, c.y) ;
  vertex(d.x, d.y) ;
  endShape(CLOSE) ;
}







