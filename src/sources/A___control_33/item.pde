/**
ITEM 1.2.1
*/
void item_inventory() {
  int num_group = 1;
  for (TableRow row : inventory_item_table.rows()) {
    int item_group = row.getInt("Group");
    for (int i = 1 ; i <= num_group ; i++) {
      if (item_group == i) NUM_ITEM++;
    }
  }
  println("Items:", NUM_ITEM);
}

void info_item() {
  item_info_raw[0] = item_info[0] = ("") ;
  // the list start from '1' so we must init the '0'
  for(int i = 0 ; i < NUM_ITEM ; i++) {
    TableRow lookFor = inventory_item_table.getRow(i);
    int ID = lookFor.getInt("ID");
    for(int j = 0 ; j <= NUM_ITEM ; j++) {
      if(ID == j) { 
        /* 
        item_info_raw is used to call the save in the order of the item labrary ID, not alphabetic
        item_info is used to display in the alphabetic order, but when is calling the order alphabetic doesn't exist,
        and it's necessary to order it, but after that is not possible back to original order, it's a reason
        to create a raw list for the next loading item list :( very messy :( 
        */
        item_info_raw[j] = lookFor.getString("Name") + "/" +lookFor.getInt("ID") + "/" +lookFor.getInt("Library Order") ;
        item_info[j] = item_info_raw[j];
        item_name[j] = lookFor.getString("Name");
        item_ID [j] = lookFor.getInt("ID");

        item_group[j] = lookFor.getInt("Group");
        item_pack[j] = lookFor.getString("Pack");

        item_author[j] = lookFor.getString("Author");
        item_version[j] = lookFor.getString("Version");
        item_load_name[j] = lookFor.getString("Class name");
        item_slider[j] = lookFor.getString("Slider");
      }
    }
  }
}



void create_and_initialize_item() {
  inventory_item_table = loadTable(preference_path+"index_romanesco_items.csv","header");
  item_inventory();
  init_var_item();

  init_inventory();
  init_button_inventory();

  init_button_item_console();

  info_item();
}

void init_var_item() {
  item_group = new int [NUM_ITEM +1];
  item_GUI_on_off = new int [NUM_ITEM +1];

  item_info_raw = new String [NUM_ITEM +1];
  item_info = new String [NUM_ITEM +1];
  item_ID = new int [NUM_ITEM +1];

  item_author = new String [NUM_ITEM +1];
  item_name = new String [NUM_ITEM +1];
  item_version = new String [NUM_ITEM +1];
  item_pack = new String [NUM_ITEM +1];
  item_load_name = new String [NUM_ITEM +1];
  item_slider = new String [NUM_ITEM +1];
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
  println("init_button_item_console()",frameCount);
  pos_button_width_item = new int[button_item_num +num];
  pos_button_height_item = new int[button_item_num +num];
  width_button_item = new int[button_item_num +num];
  height_button_item = new int[button_item_num +num];

  item_button_state = new boolean[button_item_num]; 
}

void init_inventory() {
  inventory = new Inventory[NUM_ITEM +1] ;
  for(int i = 0 ; i < inventory.length ; i++ ) {
    inventory[i] = new Inventory("", true);
  }
}


void build_button_item_console() {
  for ( int i = BUTTON_ITEM_CONSOLE ; i < button_item_num +BUTTON_ITEM_CONSOLE; i++) {
    if(NUM_ITEM > 0) {
      ivec2 pos = ivec2(pos_button_width_item[i], pos_button_height_item[i]);
      ivec2 size = ivec2(width_button_item[i], height_button_item[i]); 
      button_item[i] = new Button_dynamic(pos, size);
      button_item[i].set_aspect_on_off(button_on_in,button_on_out,button_off_in,button_off_out);
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
  ivec2 pos_main_button = ivec2(7, -10) ;
  ivec2 pos_param_button = ivec2(7,14) ;
  ivec2 pos_sound_button = ivec2(7,25) ;
  ivec2 pos_action_button = ivec2(19,25) ;

  int pos_y = pos_y_item_selected +local_pos_y_button_item;
  //position and area for the rollover
  int num = BUTTON_ITEM_CONSOLE;
  for (int i = 1 ; i <= NUM_ITEM ; i++) {
    //main
    pos_button_width_item[i*num+0] = offset_x_item +pos_main_button.x; 
    pos_button_height_item[i*num+0] = pos_y +pos_main_button.y; 
    width_button_item[i*num+0] = 20 ; 
    height_button_item[i*num+0] = 20 ;  
    //setting
    pos_button_width_item[i*num+1] = offset_x_item +pos_param_button.x; 
    pos_button_height_item[i*num+1] = pos_y +pos_param_button.y; 
    width_button_item[i*num+1] = 19 ; 
    height_button_item[i*num+1] = 6 ; 
    //sound
    pos_button_width_item[i*num+2] = offset_x_item +pos_sound_button.x; 
    pos_button_height_item[i*num+2] = pos_y +pos_sound_button.y; 
    width_button_item[i*num+2] = 10 ; 
    height_button_item[i*num+2] = 6 ; 
    //action
    pos_button_width_item[i*num+3] = offset_x_item +pos_action_button.x; 
    pos_button_height_item[i*num+3] = pos_y +pos_action_button.y; 
    width_button_item[i*num+3] = 10 ; 
    height_button_item[i*num+3] = 6 ; 
  }
}

void display_button_item_console(boolean keep_setting) {
  int pointer = 0 ;
  for(int i = 1 ; i <= NUM_ITEM ; i++) {
    if(inventory[i].is()) {
      int distance = pointer *DIST_BETWEEN_ITEM;
      for(int j = 0 ; j < BUTTON_ITEM_CONSOLE ; j++) {
        int rank = i*BUTTON_ITEM_CONSOLE+j;
        button_item[rank].change_pos(distance, 0);
        button_item[rank].update_pos(inventory[i].is());
        button_item[rank].update(mouseX,mouseY);
         button_item[rank].rollover(!dropdown_is());

        if(j == 0) {
          PImage [] pic = {ON_in_thumbnail[i], ON_out_thumbnail[i],OFF_in_thumbnail[i], OFF_out_thumbnail[i]};
          button_item[rank].show_picto(pic);
        }
        if(j == 1) button_item[rank].show_picto(picSetting);
        if(j == 2) button_item[rank].show_picto(picSound); 
        if(j == 3) button_item[rank].show_picto(picAction);

      }
      int px = pos_button_width_item[i*BUTTON_ITEM_CONSOLE +2] +distance;
      int py = pos_button_height_item[i*BUTTON_ITEM_CONSOLE +1] -15;
      ivec2 pos = ivec2(px,py);
      ivec2 size = ivec2(20,100);
      item_thumbnail_info(pos,size,i,1);
      pointer ++ ;
    } else if(!keep_setting) {
      for(int jj = 0 ; jj < BUTTON_ITEM_CONSOLE ; jj++) {
        int rank = i*BUTTON_ITEM_CONSOLE+jj;
        if(jj == 0) button_item[rank].set_is(false); // show item
        if(jj == 1) button_item[rank].set_is(false); // setting item
        if(jj == 2) button_item[rank].set_is(false); // setting sound
        if(jj == 3) button_item[rank].set_is(false); // setting action
      }
    } 
  }
}


void check_button_item_console() {
  if(NUM_ITEM > 0){
    // item available
    int num = button_item_num +BUTTON_ITEM_CONSOLE;
    for(int i = BUTTON_ITEM_CONSOLE ; i < num ; i++) {
      if(button_item[i].is()) {
        item_button_state[i-BUTTON_ITEM_CONSOLE] = true; 
      } else {
        item_button_state[i-BUTTON_ITEM_CONSOLE] = false;
      }
    }
  }
}

void mousepressed_button_item_console() {
  if(!dropdown_is() && NUM_ITEM > 0) {
    for(int i = BUTTON_ITEM_CONSOLE ; i < NUM_ITEM *BUTTON_ITEM_CONSOLE +BUTTON_ITEM_CONSOLE ; i++) {
      button_item[i].update_pos(inventory[i/BUTTON_ITEM_CONSOLE].is());
      if(button_item[i].inside()) button_item[i].switch_is();
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
  ivec2 pos = ivec2();
  ivec2 size = ivec2();
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
        pos = ivec2(left_flag, top_text +step);
        size = ivec2(w,h);
        button_inventory[i].pos(pos);
        button_inventory[i].size(size);
      } else if (i > num_item_by_col && i <= num_item_by_col *2) {
        
        pos = ivec2(left_flag +col_size_list_item, top_text +step -max_size_col);
        size = ivec2(w,h);
        button_inventory[i].pos(pos);
        button_inventory[i].size(size);
      } else if (i > num_item_by_col *2 && i <= num_item_by_col *3) {
        
        pos = ivec2(left_flag +(col_size_list_item *2), top_text +step -(max_size_col *2));
        size = ivec2(w,h);
        button_inventory[i].pos(pos);
        button_inventory[i].size(size);
      } else if (i > num_item_by_col *3 && i <= num_item_by_col *4) {
        pos = ivec2(left_flag +(col_size_list_item *3), top_text +step -(max_size_col *3));
        size = ivec2(w,h);
        button_inventory[i].pos(pos);
        button_inventory[i].size(size);
      } else if (i > num_item_by_col *4 && i <= num_item_by_col *5) {
        pos = ivec2(left_flag +(col_size_list_item *4), top_text +step -(max_size_col *4));
        size = ivec2(w,h);
        button_inventory[i].pos(pos);
        button_inventory[i].size(size);
      } else if (i > num_item_by_col *5 && i <= num_item_by_col *6) {
        pos = ivec2(left_flag +(col_size_list_item *5), top_text +step -(max_size_col *5));
        size = ivec2(w,h);
        button_inventory[i].pos(pos);
        button_inventory[i].size(size) ;
      } else if (i > num_item_by_col *6 && i <= num_item_by_col *7) {
        pos = ivec2(left_flag +(col_size_list_item *6), top_text +step -(max_size_col *6));
        size = ivec2(w,h);
        button_inventory[i].pos(pos);
        button_inventory[i].size(size);
      } else if (i > num_item_by_col *7 && i <= num_item_by_col *8) {
        pos = ivec2(left_flag +(col_size_list_item *7), top_text +step -(max_size_col *7));
        size = ivec2(w,h);
        button_inventory[i].pos(pos) ;
        button_inventory[i].size(size) ;
      } else if (i > num_item_by_col *8 && i <= num_item_by_col *9) {
        pos = ivec2(left_flag +(col_size_list_item *8), top_text +step -(max_size_col *8));
        size = ivec2(w,h);
        button_inventory[i].pos(pos);
        button_inventory[i].size(size);
      } else if (i > num_item_by_col *9 && i <= num_item_by_col *10) {
        pos = ivec2(left_flag +(col_size_list_item *9), top_text +step -(max_size_col *9));
        size = ivec2(w,h);
        button_inventory[i].pos(pos);
        button_inventory[i].size(size);
      }
    }
  }
}

void set_inventory_item(boolean keep_state) {
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
  if(item_info.length > 0) {
    for(int i = 0 ; i < item_info.length ; i++) {
      if(item_info[i] != "" && button_inventory[i].pos != null) {
       button_inventory[i].show_label();
      }
    }
  }
}

void update_button_inventory() {
  if(item_info.length > 0) {
    for(int i = 0 ; i < item_info.length ; i++) {
      if(item_info[i] != "" && button_inventory[i].pos != null) {
       button_inventory[i].update(mouseX,mouseY);
       button_inventory[i].rollover(!dropdown_is());
      }
    }
  }
}


void check_button_inventory() {
  // Check to display or not the item in the controller
  if( NUM_ITEM > 0 && !INIT_INTERFACE ) {
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
  if( NUM_ITEM > 0 ) {
    for(int i = 1 ; i < button_inventory.length ; i++ ) {
      if(button_inventory[i].inside()) button_inventory[i].switch_is();
    }
    for(int i = 1 ; i < on_off_inventory_save.length ; i++ ) {
      on_off_inventory_save[i] = button_inventory[i].is() ;
    }
  }
}



