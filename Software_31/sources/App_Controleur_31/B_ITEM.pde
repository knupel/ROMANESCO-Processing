/**
ITEM 1.2.0
*/
void item_inventory() {
  int num_group = 1;
  for (TableRow row : inventory_item_table.rows()) {
    int item_group = row.getInt("Group");
    for (int i = 1 ; i <= num_group ; i++) {
      if (item_group == i) NUM_ITEM ++;
    }
  }
  println("Items:", NUM_ITEM);
}



void info_item() {
  item_info_raw[0] = item_info[0] = ("") ;
  // the list start from '1' so we must init the '0'
  for(int i = 0 ; i < NUM_ITEM ; i++) {
    TableRow lookFor = inventory_item_table.getRow(i) ;
    int ID = lookFor.getInt("ID") ;
    for(int j = 0 ; j <= NUM_ITEM ; j++) {
      if(ID == j) { 

        /* item_info_raw is used to call the save in the order of the item labrary ID, not alphabetic
           item_info is used to display in the alphabetic order, but when is calling the order alphabetic doesn't exist,
           and it's necessary to order it, but after that is not possible back to original order, it's a reason
           to create a raw list for the next loading item list :( very messy :( */
        item_info_raw[j] = lookFor.getString("Name") + "/" +lookFor.getInt("ID") + "/" +lookFor.getInt("Library Order") ;
        item_info[j] = item_info_raw[j] ;
        item_name[j] = lookFor.getString("Name");
        item_ID [j] = lookFor.getInt("ID") ;

        item_group[j] = lookFor.getInt("Group");
        item_pack[j] = lookFor.getString("Pack");

        item_author[j] = lookFor.getString("Author");
        item_version[j] = lookFor.getString("Version");
        item_load_name[j] = lookFor.getString("Class name");
        item_slider[j] = lookFor.getString("Slider") ;
      }
    }
  }
}



void build_item_library() {
  inventory_item_table = loadTable(preference_path+"index_romanesco_items.csv", "header") ;
  shaderBackgroundList = loadTable(preference_path+"shader/shaderBackgroundList.csv", "header") ;
  item_inventory();
  init_var_item();
  //init_slider();
  init_button_inventory_item();
  init_button_item_console();
  init_dropdown();
  info_item();
  info_bg_shader();
}

void init_var_item() {
  item_group = new int [NUM_ITEM +1] ;
  item_GUI_on_off = new int [NUM_ITEM +1] ;

  item_info_raw = new String [NUM_ITEM +1] ;
  item_info = new String [NUM_ITEM +1] ;
  item_ID = new int [NUM_ITEM +1] ;

  item_author = new String [NUM_ITEM +1] ;
  item_name = new String [NUM_ITEM +1] ;
  item_version = new String [NUM_ITEM +1] ;
  item_pack = new String [NUM_ITEM +1] ;
  item_load_name = new String [NUM_ITEM +1] ;
  item_slider = new String [NUM_ITEM +1] ;
}




/**
Item console
*/
Button_dynamic[] button_item ;

void init_button_item_console() {
  numButton[1] = NUM_ITEM *10 ;
  value_button_item = new int[numButton[1]] ;
  // button item
  button_item = new Button_dynamic[numButton[1] +10] ;
  pos_button_width_item = new int[numButton[1] +10] ;
  pos_button_height_item = new int[numButton[1] +10] ;
  width_button_item = new int[numButton[1] +10] ;
  height_button_item = new int[numButton[1] +10] ;
  on_off_item_console = new int[numButton[1]] ;
  // on_off_inventory_item = new boolean[NUM_ITEM +1] ;
  on_off_inventory_item = new Item_ON_OFF[NUM_ITEM +1] ;
  for(int i = 0 ; i < on_off_inventory_item.length ; i++ ) {
    on_off_inventory_item[i] = new Item_ON_OFF("", true) ;
  }
}


void build_button_item_console() {
    //button item
  Vec2 pos = Vec2() ;
  Vec2 size = Vec2() ;

  button_item[0] = new Button_dynamic(pos, size) ;
  button_item[0].set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;
  button_item[0].set_color_bg(gris, grisNoir) ;

  int num = numButton[1] ;
  for ( int j = 11 ; j < 10 +num ; j++) {
    if(NUM_ITEM > 0) {
      pos = Vec2(pos_button_width_item[j], pos_button_height_item[j]) ;
      size = Vec2(width_button_item[j], height_button_item[j]) ; 
      button_item[j] = new Button_dynamic(pos, size) ;
      button_item[j].set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;
      button_item[j].set_color_bg(gris, grisNoir) ;

      /* here we give information for the item button, we need later to manage the dynamic GUI */
      int ID_temp = j / 10 ; // because there is few button by item
      String [] temp = split(item_info[ID_temp], "/") ;
      button_item[j].set_name(temp[0]) ;
      button_item[j].set_ID(Integer.parseInt(temp[1])) ;
      button_item[j].set_rank(Integer.parseInt(temp[2])) ;
    } 
  }
}







// LOCAL METHOD SETUP
PVector posRelativeMainButton = new PVector (-8, -10) ;
PVector posRelativeSettingButton = new PVector (-8,14) ;
PVector posRelativeSoundButton = new PVector (-8,25) ;
PVector posRelativeActionButton = new PVector (4,25) ;
void set_button_item_console() {
  int pos_y = pos_y_item_selected +local_pos_y_button_item_selected ;
  //position and area for the rollover
  for (int i = 1 ; i <= NUM_ITEM ; i++) {
    //main
    pos_button_width_item[i*10+1] = offset_y_item +(int)posRelativeMainButton.x ; 
    pos_button_height_item[i*10+1] = pos_y +(int)posRelativeMainButton.y ; 
    width_button_item[i*10+1] = 20 ; 
    height_button_item[i*10+1] = 20 ;  
    //setting
    pos_button_width_item[i*10+2] = offset_y_item +(int)posRelativeSettingButton.x ; 
    pos_button_height_item[i*10+2] = pos_y +(int)posRelativeSettingButton.y  ; 
    width_button_item[i*10+2] = 19 ; 
    height_button_item[i*10+2] = 6 ; 
    //sound
    pos_button_width_item[i*10+3] = offset_y_item +(int)posRelativeSoundButton.x ; 
    pos_button_height_item[i*10+3] = pos_y +(int)posRelativeSoundButton.y ; 
    width_button_item[i*10+3] = 10 ; 
    height_button_item[i*10+3] = 6 ; 
    //action
    pos_button_width_item[i*10+4] = offset_y_item +(int)posRelativeActionButton.x ; 
    pos_button_height_item[i*10+4] = pos_y +(int)posRelativeActionButton.y ; 
    width_button_item[i*10+4] = 10 ; 
    height_button_item[i*10+4] = 6 ; 
  }
}





void display_button_item_console() {
  int pointer = 0 ;
  for( int i = 1 ; i <= NUM_ITEM ; i++ ) {
    if(on_off_inventory_item[i].on_off) {
      int distance = pointer *DIST_BETWEEN_ITEM ;
      for(int j = 1 ; j <= BUTTON_ITEM_CONSOLE ; j++) {
      	button_item[i *10 + j].change_pos(distance, 0) ;
        button_item[i *10 + j].update_pos(on_off_inventory_item[i].on_off) ;

      	if(j == 1) button_item[i*10 +j].button_pic_serie(OFF_in_thumbnail, OFF_out_thumbnail, ON_in_thumbnail, ON_out_thumbnail, i) ; 
      	if(j == 2) button_item[i*10 +j].button_pic(picSetting) ;
      	if(j == 3) button_item[i*10 +j].button_pic(picSound) ; 
      	if(j == 4) button_item[i*10 +j].button_pic(picAction) ; 

      }
      PVector pos = new PVector (pos_button_width_item[i*10 +2] +distance, pos_button_height_item[i*10 +1] +10) ;
      PVector size = new PVector (20, 30) ;
      text_info_object(pos, size, i, 1) ;
      pointer ++ ;
    } else {
      for(int j = 1 ; j <= BUTTON_ITEM_CONSOLE ; j++) {
        if(j == 1) button_item[i*10 +j].on_off = false ; 
        if(j == 2) button_item[i*10 +j].on_off = false ;
        if(j == 3) button_item[i*10 +j].on_off = false ;
        if(j == 4) button_item[i*10 +j].on_off = false ;
      }
    }
  }
}


void check_button_item_console() {
  // Item check
  if( NUM_ITEM > 0){
    // item available
    int num = numButton[1] +10 ;
    for( int i = 11 ; i < num ; i++) {
      if(button_item[i].on_off) {
        on_off_item_console[i-10] = 1 ; 
      } else on_off_item_console[i-10] = 0 ;
    }
  }
}

void mousepressed_button_item_console() {
  if(!dropdownActivity && NUM_ITEM > 0 ) {
    for( int i = 11 ; i <= NUM_ITEM *10 +BUTTON_ITEM_CONSOLE ; i++ ) { 
      button_item[i].update_pos(on_off_inventory_item[i /10].on_off) ;
      button_item[i].mousePressed()  ;
    }
  }
}












/**
ITEM INVENTORY
*/
Button[] button_inventory_item ;
boolean [] on_off_inventory_item_save ;

void init_button_inventory_item() {
  button_inventory_item = new Button[NUM_ITEM +1] ;
  on_off_inventory_item_save = new boolean[NUM_ITEM +1] ;
}

void build_button_inventory_item() {
  for(int i = 0 ; i < button_inventory_item.length ; i++) {
    if(button_inventory_item[i] == null) {
      button_inventory_item[i] = new Button();
    }
  }
}

void set_button_inventory_item() {
  Vec2 pos = Vec2() ;
  Vec2 size = Vec2() ;
  height_inventory_item = height -pos_y_inventory_item ;

  int text_size = 12 ;
  int spacing = text_size + (text_size /4 ) ;
  int num_item_by_col = int(float(height_inventory_item) /(spacing *1.2)) ;


  int max_size_col = num_item_by_col *spacing;
  int col_size_list_item = 80 ;
  int left_flag = grid_col[0] +10 ;
  int top_text = pos_y_inventory_item -5 ;
  int ratio_rollover_x = 9 ;


  item_info = sort(item_info) ;
  // build button
  for( int i = 0 ; i < button_inventory_item.length ; i++) {
    int step = i *spacing;
    String [] temp_item_info_split = split(item_info[i], "/") ;
    if(temp_item_info_split[0] != "" ) {
      // Must bo optimized, it's very very very too long, too much, too bad, too too...
      if(i <= num_item_by_col) {
        pos = Vec2(left_flag, top_text +step) ;
        size = Vec2(width_String(temp_item_info_split[0], ratio_rollover_x ), text_size) ;
        button_inventory_item[i].set_pos(pos) ;
        button_inventory_item[i].set_size(size) ;
      } else if (i > num_item_by_col && i <= num_item_by_col *2)  {
        pos = Vec2(left_flag +col_size_list_item, top_text +step -max_size_col) ;
        size = Vec2(width_String(temp_item_info_split[0], ratio_rollover_x ), text_size) ;
        button_inventory_item[i].set_pos(pos) ;
        button_inventory_item[i].set_size(size) ;
      } else if (i > num_item_by_col *2 && i <= num_item_by_col *3)  {
        pos = Vec2(left_flag +(col_size_list_item *2), top_text +step -(max_size_col *2)) ;
        size = Vec2(width_String(temp_item_info_split[0], ratio_rollover_x ), text_size) ;
        button_inventory_item[i].set_pos(pos) ;
        button_inventory_item[i].set_size(size) ;
      } else if (i > num_item_by_col *3 && i <= num_item_by_col *4)  {
        pos = Vec2(left_flag +(col_size_list_item *3), top_text +step -(max_size_col *3)) ;
        size = Vec2(width_String(temp_item_info_split[0], ratio_rollover_x ), text_size) ;
        button_inventory_item[i].set_pos(pos) ;
        button_inventory_item[i].set_size(size) ;
      } else if (i > num_item_by_col *4 && i <= num_item_by_col *5)  {
        pos = Vec2(left_flag +(col_size_list_item *4), top_text +step -(max_size_col *4)) ;
        size = Vec2(width_String(temp_item_info_split[0], ratio_rollover_x ), text_size) ;
        button_inventory_item[i].set_pos(pos) ;
        button_inventory_item[i].set_size(size) ;
      } else if (i > num_item_by_col *5 && i <= num_item_by_col *6)  {
        pos = Vec2(left_flag +(col_size_list_item *5), top_text +step -(max_size_col *5)) ;
        size = Vec2(width_String(temp_item_info_split[0], ratio_rollover_x ), text_size) ;
        button_inventory_item[i].set_pos(pos) ;
        button_inventory_item[i].set_size(size) ;
      } else if (i > num_item_by_col *6 && i <= num_item_by_col *7)  {
        pos = Vec2(left_flag +(col_size_list_item *6), top_text +step -(max_size_col *6)) ;
        size = Vec2(width_String(temp_item_info_split[0], ratio_rollover_x ), text_size) ;
        button_inventory_item[i].set_pos(pos) ;
        button_inventory_item[i].set_size(size) ;
      } else if (i > num_item_by_col *7 && i <= num_item_by_col *8)  {
        pos = Vec2(left_flag +(col_size_list_item *7), top_text +step -(max_size_col *7)) ;
        size = Vec2(width_String(temp_item_info_split[0], ratio_rollover_x ), text_size) ;
        button_inventory_item[i].set_pos(pos) ;
        button_inventory_item[i].set_size(size) ;
      } else if (i > num_item_by_col *8 && i <= num_item_by_col *9)  {
        pos = Vec2(left_flag +(col_size_list_item *8), top_text +step -(max_size_col *8)) ;
        size = Vec2(width_String(temp_item_info_split[0], ratio_rollover_x ), text_size) ;
        button_inventory_item[i].set_pos(pos) ;
        button_inventory_item[i].set_size(size) ;
      } else if (i > num_item_by_col *9 && i <= num_item_by_col *10)  {
        pos = Vec2(left_flag +(col_size_list_item *9), top_text +step -(max_size_col *9)) ;
        size = Vec2(width_String(temp_item_info_split[0], ratio_rollover_x ), text_size) ;
        button_inventory_item[i].set_pos(pos) ;
        button_inventory_item[i].set_size(size) ;
      }
    }
  }
}

void set_inventory_item(boolean keep_state) {
  // println("keep_state set_inventory_item()",keep_state);
  boolean local_state = keep_state ;
  color col_off_out_menu_item = rougeTresTresFonce ;
  // give the the good statement
  for( int i = 0 ; i < button_inventory_item.length ; i++) {
    if(item_info[i] != "" ) {
      button_inventory_item[i].set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out_menu_item) ;

      String [] temp_item_info_split = split(item_info[i], "/") ;
      button_inventory_item[i].set_name(temp_item_info_split[0]) ;
      button_inventory_item[i].set_ID(Integer.parseInt(temp_item_info_split[1])) ;
      button_inventory_item[i].set_rank(Integer.parseInt(temp_item_info_split[2])) ;
      // start a second loop to check again if the saved name is ok with the alphabetical sort of the item.
      for(int j = 0 ; j < on_off_inventory_item.length ; j++) {
        if(on_off_inventory_item[j].name.equals(button_inventory_item[i].name) && !keep_state) {
          if(INIT_INTERFACE) {
            button_inventory_item[i].set_on_off(on_off_inventory_item[j].on_off) ;
          } else {
            button_inventory_item[i].set_on_off(on_off_inventory_item_save[i]) ;
            on_off_inventory_item[j].on_off = on_off_inventory_item_save[i] ;
          }
        }
      }
    }
  }
}





// Display the list of all the item available
void display_button_inventory_item() {
  textFont(textUsual_3) ;
  int text_size = 12 ;
  textSize(text_size) ;  
  // present the list in alphabetical order

  // display the list
  if(item_info.length > 0  ) {
    for(int i = 0 ; i < item_info.length ; i++) {
      if(item_info[i] != "" && button_inventory_item[i].pos != null) {
        button_inventory_item[i].button_text((int)button_inventory_item[i].pos.x , (int)button_inventory_item[i].pos.y +text_size) ;
      }
    }
  }
}

void check_button_inventory_item() {
  /*
  Check to display or not the item in the controller
  */
  if(NUM_ITEM > 0 && !INIT_INTERFACE ) {
    for(int i = 1 ; i < button_inventory_item.length ; i++) {
      // here it's boolean not an int because we don't need to send it via OSC.
      int ID = button_inventory_item[i].ID ;
      if(button_inventory_item[i].on_off) {
        on_off_inventory_item[ID].on_off = true ; // use ID item
      } else { 
        on_off_inventory_item[ID].on_off = false ;
      }
    }
  }
}

void mousepressed_button_inventory_item() {
  if(!dropdownActivity && NUM_ITEM > 0 ) {
    for(int i = 1 ; i < button_inventory_item.length ; i++ ) {
      button_inventory_item[i].mousePressed() ;
    }
    for(int i = 1 ; i < on_off_inventory_item_save.length ; i++ ) {
      on_off_inventory_item_save[i] = button_inventory_item[i].on_off ;
    }
  }
}