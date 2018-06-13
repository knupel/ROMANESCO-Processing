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
        /* 
        item_info_raw is used to call the save in the order of the item labrary ID, not alphabetic
        item_info is used to display in the alphabetic order, but when is calling the order alphabetic doesn't exist,
        and it's necessary to order it, but after that is not possible back to original order, it's a reason
        to create a raw list for the next loading item list :( very messy :( 
        */
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



void create_and_initialize_data() {
  inventory_item_table = loadTable(preference_path+"index_romanesco_items.csv", "header") ;
  shaderBackgroundList = loadTable(preference_path+"shader/shaderBackgroundList.csv", "header") ;
  item_inventory();
  init_var_item();
  //init_slider();
  init_inventory();
  init_button_inventory();


  init_button_item_console();

 // init_dropdown();
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
  int num = BUTTON_ITEM_CONSOLE;
  button_item_num = NUM_ITEM *num;
  value_button_item = new int[button_item_num] ;
  // button item
  button_item = new Button_dynamic[button_item_num +num];
  pos_button_width_item = new int[button_item_num +num];
  pos_button_height_item = new int[button_item_num +num];
  width_button_item = new int[button_item_num +num];
  height_button_item = new int[button_item_num +num];

  item_button_state = new boolean[button_item_num]; 
}

void init_inventory() {
  inventory = new Inventory[NUM_ITEM +1] ;
  for(int i = 0 ; i < inventory.length ; i++ ) {
    inventory[i] = new Inventory("", true) ;
  }
}


void build_button_item_console() {
  for ( int i = BUTTON_ITEM_CONSOLE ; i < button_item_num +BUTTON_ITEM_CONSOLE; i++) {
    if(NUM_ITEM > 0) {
      iVec2 pos = iVec2(pos_button_width_item[i], pos_button_height_item[i]) ;
      iVec2 size = iVec2(width_button_item[i], height_button_item[i]) ; 
      button_item[i] = new Button_dynamic(pos, size) ;
      button_item[i].set_aspect_on_off(button_on_in,button_on_out,button_off_in,button_off_out);
      //button_item[i].fill(gris, grisNoir) ;

      // here we give information for the item button, we need later to manage the dynamic GUI
      int ID_temp = i / BUTTON_ITEM_CONSOLE ; // because there is few button by item
      String [] temp = split(item_info[ID_temp], "/") ;
      button_item[i].set_label(temp[0]) ;
      button_item[i].set_id(Integer.parseInt(temp[1]));
      button_item[i].set_rank(Integer.parseInt(temp[2]));
    } 
  }
}







// LOCAL METHOD SETUP
void set_button_item_console() {
  PVector posRelativeMainButton = new PVector (-8, -10) ;
  PVector posRelativeSettingButton = new PVector (-8,14) ;
  PVector posRelativeSoundButton = new PVector (-8,25) ;
  PVector posRelativeActionButton = new PVector (4,25) ;

  int pos_y = pos_y_item_selected +local_pos_y_button_item_selected ;
  //position and area for the rollover
  int num = BUTTON_ITEM_CONSOLE;
  for (int i = 1 ; i <= NUM_ITEM ; i++) {
    //main
    pos_button_width_item[i*num+0] = offset_y_item +(int)posRelativeMainButton.x ; 
    pos_button_height_item[i*num+0] = pos_y +(int)posRelativeMainButton.y ; 
    width_button_item[i*num+0] = 20 ; 
    height_button_item[i*num+0] = 20 ;  
    //setting
    pos_button_width_item[i*num+1] = offset_y_item +(int)posRelativeSettingButton.x ; 
    pos_button_height_item[i*num+1] = pos_y +(int)posRelativeSettingButton.y  ; 
    width_button_item[i*num+1] = 19 ; 
    height_button_item[i*num+1] = 6 ; 
    //sound
    pos_button_width_item[i*num+2] = offset_y_item +(int)posRelativeSoundButton.x ; 
    pos_button_height_item[i*num+2] = pos_y +(int)posRelativeSoundButton.y ; 
    width_button_item[i*num+2] = 10 ; 
    height_button_item[i*num+2] = 6 ; 
    //action
    pos_button_width_item[i*num+3] = offset_y_item +(int)posRelativeActionButton.x ; 
    pos_button_height_item[i*num+3] = pos_y +(int)posRelativeActionButton.y ; 
    width_button_item[i*num+3] = 10 ; 
    height_button_item[i*num+3] = 6 ; 
  }
}


void display_button_item_console() {
  int pointer = 0 ;
  for( int i = 1 ; i <= NUM_ITEM ; i++ ) {
    if(inventory[i].is()) {
      int distance = pointer *DIST_BETWEEN_ITEM ;
      for(int j = 0 ; j < BUTTON_ITEM_CONSOLE ; j++) {
      	button_item[i *BUTTON_ITEM_CONSOLE + j].change_pos(distance, 0) ;
        button_item[i *BUTTON_ITEM_CONSOLE + j].update_pos(inventory[i].is()) ;
        if(j == 0) {
          PImage [] pic = {ON_in_thumbnail[i], ON_out_thumbnail[i],OFF_in_thumbnail[i], OFF_out_thumbnail[i]};
          button_item[i*BUTTON_ITEM_CONSOLE +j].show_picto(pic);
        }
        if(j == 1) button_item[i*BUTTON_ITEM_CONSOLE +j].show_picto(picSetting);
        if(j == 2) button_item[i*BUTTON_ITEM_CONSOLE +j].show_picto(picSound); 
        if(j == 3) button_item[i*BUTTON_ITEM_CONSOLE +j].show_picto(picAction);

      }
      iVec2 pos = iVec2(pos_button_width_item[i*BUTTON_ITEM_CONSOLE +2] +distance, pos_button_height_item[i*BUTTON_ITEM_CONSOLE +1] +10) ;
      iVec2 size = iVec2(20, 30);
      text_info_item(pos, size, i, 1);
      pointer ++ ;
    } else {
      for(int j = 0 ; j < BUTTON_ITEM_CONSOLE ; j++) {
        if(j == 0) button_item[i*BUTTON_ITEM_CONSOLE +j].set_is(false); 
        if(j == 1) button_item[i*BUTTON_ITEM_CONSOLE +j].set_is(false);
        if(j == 2) button_item[i*BUTTON_ITEM_CONSOLE +j].set_is(false);
        if(j == 3) button_item[i*BUTTON_ITEM_CONSOLE +j].set_is(false);
      }
    }
  }
}

void check_button_item_console() {
  if(NUM_ITEM > 0){
    // item available
    int num = button_item_num +BUTTON_ITEM_CONSOLE;
    for( int i = BUTTON_ITEM_CONSOLE+1 ; i < num ; i++) {
      if(button_item[i].is()) {
        item_button_state[i-BUTTON_ITEM_CONSOLE] = true ; 
      } else item_button_state[i-BUTTON_ITEM_CONSOLE] = false ;
    }
  }
}

void mousepressed_button_item_console() {

  if(!dropdown_is() && NUM_ITEM > 0) {
    for(int i = BUTTON_ITEM_CONSOLE ; i < NUM_ITEM *BUTTON_ITEM_CONSOLE +BUTTON_ITEM_CONSOLE ; i++) {
      button_item[i].update_pos(inventory[i/BUTTON_ITEM_CONSOLE].is());
      button_item[i].update(dropdown_is())  ;
    }
  }
}












/**
ITEM INVENTORY
*/
Button[] button_inventory ;
boolean [] on_off_inventory_save ;

void init_button_inventory() {
  button_inventory = new Button[NUM_ITEM +1] ;
  on_off_inventory_save = new boolean[NUM_ITEM +1] ;
}

void build_inventory() {
  for(int i = 0 ; i < button_inventory.length ; i++) {
    if(button_inventory[i] == null) {
      button_inventory[i] = new Button();
    }
  }
}

void set_button_inventory() {
  iVec2 pos = iVec2();
  iVec2 size = iVec2();
  height_inventory = height -pos_y_inventory ;

  int h = 12 ;
  int spacing = h + (h /4 ) ;
  int num_item_by_col = int(float(height_inventory) /(spacing *1.2)) ;

  int max_size_col = num_item_by_col *spacing;
  int col_size_list_item = 80 ;
  int left_flag = grid_col[0] +10 ;
  int top_text = pos_y_inventory -(h/2);
  int ratio_rollover_x = 9 ;

  item_info = sort(item_info) ;
  // build button
  for(int i = 0 ; i < button_inventory.length ; i++) {
    int step = i *spacing;
    String [] temp_item_info_split = split(item_info[i], "/");
    int w = width_String(temp_item_info_split[0], ratio_rollover_x);
    if(temp_item_info_split[0] != "" ) {
      // Must be optimized, it's very very very too long, too much, too bad, too too...
      if(i <= num_item_by_col) {
        pos = iVec2(left_flag, top_text +step);
        size = iVec2(w,h);
        button_inventory[i].pos(pos);
        button_inventory[i].size(size);
      } else if (i > num_item_by_col && i <= num_item_by_col *2) {
        
        pos = iVec2(left_flag +col_size_list_item, top_text +step -max_size_col);
        size = iVec2(w,h);
        button_inventory[i].pos(pos);
        button_inventory[i].size(size);
      } else if (i > num_item_by_col *2 && i <= num_item_by_col *3) {
        
        pos = iVec2(left_flag +(col_size_list_item *2), top_text +step -(max_size_col *2));
        size = iVec2(w,h);
        button_inventory[i].pos(pos);
        button_inventory[i].size(size);
      } else if (i > num_item_by_col *3 && i <= num_item_by_col *4) {
        pos = iVec2(left_flag +(col_size_list_item *3), top_text +step -(max_size_col *3));
        size = iVec2(w,h);
        button_inventory[i].pos(pos);
        button_inventory[i].size(size);
      } else if (i > num_item_by_col *4 && i <= num_item_by_col *5) {
        pos = iVec2(left_flag +(col_size_list_item *4), top_text +step -(max_size_col *4));
        size = iVec2(w,h);
        button_inventory[i].pos(pos);
        button_inventory[i].size(size);
      } else if (i > num_item_by_col *5 && i <= num_item_by_col *6) {
        pos = iVec2(left_flag +(col_size_list_item *5), top_text +step -(max_size_col *5));
        size = iVec2(w,h);
        button_inventory[i].pos(pos);
        button_inventory[i].size(size) ;
      } else if (i > num_item_by_col *6 && i <= num_item_by_col *7) {
        pos = iVec2(left_flag +(col_size_list_item *6), top_text +step -(max_size_col *6));
        size = iVec2(w,h);
        button_inventory[i].pos(pos);
        button_inventory[i].size(size);
      } else if (i > num_item_by_col *7 && i <= num_item_by_col *8) {
        pos = iVec2(left_flag +(col_size_list_item *7), top_text +step -(max_size_col *7));
        size = iVec2(w,h);
        button_inventory[i].pos(pos) ;
        button_inventory[i].size(size) ;
      } else if (i > num_item_by_col *8 && i <= num_item_by_col *9) {
        pos = iVec2(left_flag +(col_size_list_item *8), top_text +step -(max_size_col *8));
        size = iVec2(w,h);
        button_inventory[i].pos(pos);
        button_inventory[i].size(size);
      } else if (i > num_item_by_col *9 && i <= num_item_by_col *10) {
        pos = iVec2(left_flag +(col_size_list_item *9), top_text +step -(max_size_col *9));
        size = iVec2(w,h);
        button_inventory[i].pos(pos);
        button_inventory[i].size(size);
      }
    }
  }
}

void set_inventory_item(boolean keep_state) {
  // println("keep_state set_inventory_item()",keep_state);
  boolean local_state = keep_state ;
  //color col_off_out_menu_item = rougeTresTresFonce ;
  // give the the good statement
  for( int i = 0 ; i < button_inventory.length ; i++) {
    if(item_info[i] != "" ) {
      button_inventory[i].set_aspect_on_off(button_on_in,button_on_out,button_off_in,button_off_out) ;

      String [] temp_item_info_split = split(item_info[i], "/") ;
      button_inventory[i].set_label(temp_item_info_split[0]);
      button_inventory[i].set_font_size(12);
      button_inventory[i].set_font(textUsual_3);
      button_inventory[i].set_id(Integer.parseInt(temp_item_info_split[1])) ;
      button_inventory[i].set_rank(Integer.parseInt(temp_item_info_split[2])) ;
      // start a second loop to check again if the saved name is ok with the alphabetical sort of the item.
      for(int j = 0 ; j < inventory.length ; j++) {
        if(inventory[j].name.equals(button_inventory[i].name) && !keep_state) {
          if(INIT_INTERFACE) {
            button_inventory[i].set_is(inventory[j].is()) ;
          } else {
            button_inventory[i].set_is(on_off_inventory_save[i]) ;
            inventory[j].set_is(on_off_inventory_save[i]) ;
          }
        }
      }
    }
  }
}

void display_button_inventory() {
  //textFont(textUsual_3) ;
  // int text_size = 12 ;
  // textSize(text_size) ;  
  // present the list in alphabetical order
  // display the list
  if(item_info.length > 0  ) {
    for(int i = 0 ; i < item_info.length ; i++) {
      if(item_info[i] != "" && button_inventory[i].pos != null) {
        // button_inventory[i].set_pos_label((int)button_inventory[i].pos.x , (int)button_inventory[i].pos.y +text_size);
        button_inventory[i].show_label();
      }
    }
  }
}

void check_button_inventory() {
  // Check to display or not the item in the controller
  if(NUM_ITEM > 0 && !INIT_INTERFACE ) {
    for(int i = 1 ; i < button_inventory.length ; i++) {
      // here it's boolean not an int because we don't need to send it via OSC.
      int ID = button_inventory[i].get_id() ;
      if(button_inventory[i].is()) {
        inventory[ID].set_is(true); // use ID item
      } else { 
        inventory[ID].set_is(false);
      }
    }
  }
}

void mousepressed_button_inventory() {
  if(!dropdown_is() && NUM_ITEM > 0 ) {
    for(int i = 1 ; i < button_inventory.length ; i++ ) {
      button_inventory[i].update(dropdown_is());
    }
    for(int i = 1 ; i < on_off_inventory_save.length ; i++ ) {
      on_off_inventory_save[i] = button_inventory[i].is() ;
    }
  }
}



