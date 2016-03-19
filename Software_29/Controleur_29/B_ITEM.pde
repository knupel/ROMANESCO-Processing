/**
ITEM 1.0.0
*/
// Obj
int NUM_ITEM ;
int STEP_ITEM = 40 ;
final int BUTTON_ITEM_CONSOLE = 4 ;
PVector [] infoButton ;
int [] info_list_item_ID ; 

PImage[] OFF_in_thumbnail ;
PImage[] OFF_out_thumbnail ;
PImage[] ON_in_thumbnail ;
PImage[] ON_out_thumbnail ;

PImage[] picSetting = new PImage[4] ;
PImage[] picSound = new PImage[4] ;
PImage[] picAction = new PImage[4] ;


void info_item() {

  item_info[0] = ("") ;
  // the list start from '1' so we must init the '0'
  for(int i = 0 ; i < NUM_ITEM ; i++) {
    TableRow lookFor = item_list_table.getRow(i) ;
    int ID = lookFor.getInt("ID") ;
    for(int j = 0 ; j <= NUM_ITEM ; j++) {
      if(ID == j ) { 

        item_info[j] = lookFor.getString("Name") + "/" +lookFor.getInt("ID") + "/" +lookFor.getInt("Library Order") ;

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
  item_list_table = loadTable(sketchPath("")+"preferences/objects/index_romanesco_objects.csv", "header") ;
  shaderBackgroundList = loadTable(sketchPath("")+"preferences/shader/shaderBackgroundList.csv", "header") ;
  numByGroup() ;
  init_var_item() ;
  init_slider() ;
  init_button() ;
  info_item() ;
  infoShaderBackground() ;
}

void init_var_item() {
// item_rank = new int [NUM_ITEM +1] ;
  item_group = new int [NUM_ITEM +1] ;
  item_GUI_on_off = new int [NUM_ITEM +1] ;

  item_info = new String [NUM_ITEM +1] ;
  item_ID = new int [NUM_ITEM +1] ;

  item_author = new String [NUM_ITEM +1] ;
  item_version = new String [NUM_ITEM +1] ;
  item_pack = new String [NUM_ITEM +1] ;
  item_load_name = new String [NUM_ITEM +1] ;
  item_slider = new String [NUM_ITEM +1] ;
}




/**
Item console 1.0.0
*/
Button_dynamic[] button_item ;
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
  int pos_y = line_item_button_slider +correction_button_item ;
  //position and area for the rollover
  for (int i = 1 ; i <= NUM_ITEM ; i++) {
    //main
    pos_button_width_item[i*10+1] = margeLeft +(int)posRelativeMainButton.x ; 
    pos_button_height_item[i*10+1] = pos_y +(int)posRelativeMainButton.y ; 
    width_button_item[i*10+1] = 20 ; 
    height_button_item[i*10+1] = 20 ;  
    //setting
    pos_button_width_item[i*10+2] = margeLeft +(int)posRelativeSettingButton.x ; 
    pos_button_height_item[i*10+2] = pos_y +(int)posRelativeSettingButton.y  ; 
    width_button_item[i*10+2] = 19 ; 
    height_button_item[i*10+2] = 6 ; 
    //sound
    pos_button_width_item[i*10+3] = margeLeft +(int)posRelativeSoundButton.x ; 
    pos_button_height_item[i*10+3] = pos_y +(int)posRelativeSoundButton.y ; 
    width_button_item[i*10+3] = 10 ; 
    height_button_item[i*10+3] = 6 ; 
    //action
    pos_button_width_item[i*10+4] = margeLeft +(int)posRelativeActionButton.x ; 
    pos_button_height_item[i*10+4] = pos_y +(int)posRelativeActionButton.y ; 
    width_button_item[i*10+4] = 10 ; 
    height_button_item[i*10+4] = 6 ; 
 }
}





void button_draw_item_console() {
  int pointer = 0 ;


  for( int i = 1 ; i <= NUM_ITEM ; i++ ) {
    if(on_off_item_console_list[i]) {
      int distance = pointer *STEP_ITEM ;
      for(int j = 1 ; j <= BUTTON_ITEM_CONSOLE ; j++) {
      	button_item[i *10 + j].change_pos(distance, 0) ;
      	button_item[i *10 + j].update_pos(on_off_item_console_list[i]) ;
      	if(j == 1) button_item[i*10 +j].button_pic_serie(OFF_in_thumbnail, OFF_out_thumbnail, ON_in_thumbnail, ON_out_thumbnail, i) ; 
      	if(j == 2) button_item[i*10 +j].button_pic(picSetting) ;
      	if(j == 3) button_item[i*10 +j].button_pic(picSound) ; 
      	if(j == 4) button_item[i*10 +j].button_pic(picAction) ; 

      }
      PVector pos = new PVector (pos_button_width_item[i*10 +2] +distance, pos_button_height_item[i*10 +1] +10) ;
      PVector size = new PVector (20, 30) ;
      text_info_object(pos, size, i, 1) ;
      pointer ++ ;
    }
  }
}


void button_check_item_console() {
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

void button_mousePressed_item_console() {
  if(!dropdownActivity && NUM_ITEM > 0 ) {
    for( int i = 11 ; i < NUM_ITEM *10 +BUTTON_ITEM_CONSOLE ; i++ ) { 
      button_item[i].update_pos(on_off_item_console_list[i /10]) ;
      button_item[i].mousePressed()  ;
    }
  }
}












/**
ITEM LIST
*/
Button[] button_item_list ;

void build_button_item_list() {
  Vec2 pos = Vec2() ;
  Vec2 size = Vec2() ;

  int text_size = 12 ;
  int max_by_col = 10 ;
  int spacing = text_size + (text_size /4 ) ;
  int max_size_col =  max_by_col *spacing;
  int col_size_list_item = 80 ;
  int left_flag = colOne +10 ;
  int top_text =  line_item_menu_text -5 ;
  int ratio_rollover_x = 9 ;

  color col_off_out_menu_item = rougeTresTresFonce ;
  item_info = sort(item_info) ;
  // build button
  for( int i = 0 ; i < button_item_list.length ; i++) {
    int step = i *spacing;
    String [] temp_item_info_split = split(item_info[i], "/") ;
    if(temp_item_info_split[0] != "" ) {
      if(i <= max_by_col ) {
        pos = Vec2(left_flag, top_text +step) ;
        size = Vec2(length_String_in_pixel(temp_item_info_split[0], ratio_rollover_x ), text_size) ;
        button_item_list[i] = new Button(pos, size) ;
      } else if (i > max_by_col && i <= max_by_col *2)  {
        pos = Vec2(left_flag +col_size_list_item, top_text +step -max_size_col) ;
        size = Vec2(length_String_in_pixel(temp_item_info_split[0], ratio_rollover_x ), text_size) ;
        button_item_list[i] = new Button(pos, size) ;
      } else if (i > max_by_col*2 && i <= max_by_col *3)  {
        pos = Vec2(left_flag +(col_size_list_item *2), top_text +step -(max_size_col *2)) ;
        size = Vec2(length_String_in_pixel(temp_item_info_split[0], ratio_rollover_x ), text_size) ;
        button_item_list[i] = new Button(pos, size) ;
      }
    }
  }
  // set button
  for( int i = 0 ; i < button_item_list.length ; i++) {
    if(item_info[i] != "" ) {
      String [] temp_item_info_split = split(item_info[i], "/") ;
      button_item_list[i].set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out_menu_item) ;
      button_item_list[i].set_on_off(on_off_item_console_list[i]) ;
      button_item_list[i].set_name(temp_item_info_split[0]) ;
      button_item_list[i].set_ID(Integer.parseInt(temp_item_info_split[1])) ;
      button_item_list[i].set_rank(Integer.parseInt(temp_item_info_split[2])) ;
    }
  }
}
// Display the list of all the item available
void button_draw_item_list() {
  textFont(textUsual_3) ;
  int text_size = 12 ;
  textSize(text_size) ;  
  // present the list in alphabetical order

  // display the list
  if(item_info.length > 0  ) {
    for(int i = 0 ; i < item_info.length ; i++) {
      if(item_info[i] != "" ) button_item_list[i].button_text((int)button_item_list[i].pos.x , (int)button_item_list[i].pos.y +text_size) ;
    }
  }
}

void button_check_item_list() {
  /*
  Check to display or not the item in the controller
  */
  if( NUM_ITEM > 0) {
    for(int i = 1 ; i < button_item_list.length ; i++) {
      // here it's boolean not an int because we don't need to send it via OSC.
      int ID = button_item_list[i].ID ;
      if(button_item_list[i].on_off) {
        on_off_item_console_list[ID] = true ; // use ID item
      } else { 
        on_off_item_console_list[ID] = false ;
      }
    }
  }
}



void button_mousePressed_item_list() {
  if(!dropdownActivity && NUM_ITEM > 0 ) 
    for(int i = 1 ; i < button_item_list.length ; i++ ) 
      button_item_list[i].mousePressed() ;
}