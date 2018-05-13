/**
SETTING SAVE and LOAD 
v 2.3.0
*/
void load_setup() {
  set_data_save_setting() ;
  load_data_GUI(preference_path+"setting/defaultSetting.csv") ;
  load_saved_file_controller(preference_path+"setting/defaultSetting.csv") ;
  //load text interface 
  // 0 is French
  // 1 is english
  apply_text_gui() ;
}






// LOAD INFO OBJECT from the PRESCENE
Table inventory_item_table, shaderBackgroundList;
int numGroup []; 
int [] item_rank, item_ID, item_group, item_camera_video_on_off, item_GUI_on_off;
String [] item_info, item_info_raw;
String [] item_name, item_author, item_version, item_pack, item_load_name, item_slider; 
String [] shader_bg_name, shader_bg_author;

//BUTTON

int button_general_num;

int lastDropdown;
int [] value_button_general; 


//Variable must be send to Scene
// statement on_off for the item group
int button_item_num;
boolean [] item_button_state;
int num_dropdown_item;
int [] value_button_item;
int [] pos_button_width_item, pos_button_height_item, width_button_item, height_button_item ;




Inventory [] inventory ;

class Inventory {
  String name = "" ;
  boolean is = false ;
  Inventory(String name, boolean is) {
    this.name = name ;
    this.is = is;
  }

  public boolean is() {
    return is;
  }

  public void set_is(boolean is) {
    this.is = is;
  }

  public String get_name() {
    return name;
  }
}



















/**
SETTING INFO BUTTON AND SLIDER
*/
void load_data_GUI(String path) {
  Table table = loadTable(path, "header");
  // create the var info for the slider we need
  //int count_slider_general = 0;
  int count_slider_background = 0;
  int count_slider_filter = 0;
  int count_slider_light = 0;
  int count_slider_sound = 0;
  int count_slider_camera = 0;
  int count_slider_item = 0;

  for (TableRow row : table.rows()) {
    String s = row.getString("Type") ; 
    if(s.equals("Slider item")) count_slider_item++ ;  
    else if(s.equals("Slider background")) count_slider_background++;
    else if(s.equals("Slider filter")) count_slider_filter++; 
    else if(s.equals("Slider light")) count_slider_light++; 
    else if(s.equals("Slider sound")) count_slider_sound++; 
    else if(s.equals("Slider camera")) count_slider_camera++; 
    //else if(s.equals("Slider general")) count_slider_general++;
  }
  //println("silder general", count_slider_general);
  println("sliders background",count_slider_background);
  println("sliders filter",count_slider_filter);
  println("sliders light",count_slider_light);
  println("sliders sound",count_slider_sound);
  println("sliders camera",count_slider_camera);
  println("sliders item",count_slider_item);

  // info_slider_general = new Vec5 [count_slider_general];
  info_button_general = new iVec3 [10];
  for(int i = 0 ; i < info_button_general.length ; i++) {
    info_button_general[i] = iVec3();
  }

  info_slider_background = new Vec5 [count_slider_background];
  info_slider_filter = new Vec5 [count_slider_filter];
  info_slider_light = new Vec5 [count_slider_light];
  info_slider_sound = new Vec5 [count_slider_sound];
  info_slider_camera = new Vec5 [count_slider_camera];



  info_slider_item = new Vec5 [count_slider_item];
  // create the var info for the item we need
  info_list_item_ID = new int [NUM_ITEM] ;
  
  // we don't count from the save in case we add object and this one has never use before and he don't exist in the data base
  info_button_item = new iVec3 [NUM_ITEM *BUTTON_ITEM_CONSOLE +BUTTON_ITEM_CONSOLE] ; 
  for(int i = 0 ; i < info_button_item.length ; i++) {
    info_button_item[i] = iVec3();
  }
}











/**
SAVE
v 2.0.0
*/
String savePathSetting = ("") ;
void saveSetting(File selection) {
  savePathSetting = selection.getAbsolutePath() ;
  if (selection != null) saveSetting(savePathSetting) ;
}

void saveSetting(String path) {
  save_info_slider() ;
  save_info_item() ;
  midi_manager(true) ;
  saveTable(saveSetting, path);
  saveSetting.clearRows() ;
}

// SAVE SLIDERS
// save the position and the ID of the slider molette
void save_info_slider() {
  // background
  for (int i = 1 ; i < NUM_SLIDER_BACKGROUND ; i++) {
    int temp = i-1 ;
    info_slider_background[temp].c = slider_adj_background[i].get_value() ;
    info_slider_background[temp].d = slider_adj_background[i].get_min_norm() ;
    info_slider_background[temp].e = slider_adj_background[i].get_max_norm() ;
    set_data_slider(i, info_slider_background[temp],"Slider background") ;
  }

  // filter
  for (int i = 1 ; i < NUM_SLIDER_FILTER ; i++) {
    int temp = i-1 ;
    info_slider_filter[temp].c = slider_adj_filter[i].get_value() ;
    info_slider_filter[temp].d = slider_adj_filter[i].get_min_norm() ;
    info_slider_filter[temp].e = slider_adj_filter[i].get_max_norm() ;
    set_data_slider(i, info_slider_filter[temp],"Slider filter") ;
  }

  // light
  for (int i = 1 ; i < NUM_SLIDER_LIGHT ; i++) {
    int temp = i-1 ;
    info_slider_light[temp].c = slider_adj_light[i].get_value() ;
    info_slider_light[temp].d = slider_adj_light[i].get_min_norm() ;
    info_slider_light[temp].e = slider_adj_light[i].get_max_norm() ;
    set_data_slider(i, info_slider_light[temp],"Slider light") ;
  }

  // sound
  for (int i = 1 ; i < NUM_SLIDER_SOUND ; i++) {
    int temp = i-1 ;
    info_slider_sound[temp].c = slider_adj_sound[i].get_value() ;
    info_slider_sound[temp].d = slider_adj_sound[i].get_min_norm() ;
    info_slider_sound[temp].e = slider_adj_sound[i].get_max_norm() ;
    set_data_slider(i, info_slider_sound[temp],"Slider sound") ;
  }

  // camera
  for (int i = 1 ; i < NUM_SLIDER_CAMERA ; i++) {
    int temp = i-1 ;
    info_slider_camera[temp].c = slider_adj_camera[i].get_value() ;
    info_slider_camera[temp].d = slider_adj_camera[i].get_min_norm() ;
    info_slider_camera[temp].e = slider_adj_camera[i].get_max_norm() ;
    set_data_slider(i, info_slider_camera[temp],"Slider camera") ;
  }
  
  // item
  for(int i = 0 ; i < NUM_SLIDER_ITEM ; i++) {
    int IDslider = i;
    for(int k = 0 ; k < info_slider_item.length ;k++) {
      if((int)info_slider_item[k].a == IDslider) {
        info_slider_item[k].c = slider_adj_item[IDslider].get_value() ;
        info_slider_item[k].d = slider_adj_item[IDslider].get_min_norm() ;
        info_slider_item[k].e = slider_adj_item[IDslider].get_max_norm() ;
        set_data_slider(IDslider, info_slider_item[k],"Slider item") ;
      }
    }
  }
  show_all_slider_item = false ;
}

void save_info_item() {
  for(int i = 0 ; i < NUM_ITEM ; i++) {
    set_data_item(item_ID[i] +1) ;
  }
}




// BUTTON SAVE
Table saveSetting;
void set_data_save_setting() {
  saveSetting = new Table() ;
  saveSetting.addColumn("Type") ;
  saveSetting.addColumn("ID slider") ;
  saveSetting.addColumn("Min slider") ;
  saveSetting.addColumn("Max slider") ;
  saveSetting.addColumn("Value slider") ;
  saveSetting.addColumn("ID button") ;
  saveSetting.addColumn("On Off") ;
  saveSetting.addColumn("ID midi") ;
  saveSetting.addColumn("Item ID") ;
  saveSetting.addColumn("Item On Off") ;
  saveSetting.addColumn("Item Name") ;
  saveSetting.addColumn("Item Class Name") ;
}

//write the value in the table
void set_data_button(int IDbutton, int IDmidi, boolean b, String type) {
  TableRow buttonSetting = saveSetting.addRow() ;
  buttonSetting.setString("Type", type) ;
  buttonSetting.setInt("ID button", IDbutton) ;
  buttonSetting.setInt("ID midi", IDmidi) ;
  if(b) buttonSetting.setInt("On Off", 1) ; else buttonSetting.setInt("On Off", 0) ;
}
//
// void set_data_slider(int IDslider, int IDmidi, float value, float min, float max, String name) {
void set_data_slider(int IDslider, Vec5 info, String name){
  TableRow sliderSetting = saveSetting.addRow();
  sliderSetting.setString("Type",name);
  sliderSetting.setInt("ID slider",IDslider);
  sliderSetting.setInt("ID midi",(int)info.b);
  sliderSetting.setFloat("Value slider", info.c); 
  sliderSetting.setFloat("Min slider",info.d); 
  sliderSetting.setFloat("Max slider",info.e); 
}

// void set_data_item(int ID_item, boolean display_item_on_off) {
void set_data_item(int ID_item) {
  TableRow item_setting = saveSetting.addRow() ;
  item_setting.setString("Type", "Item") ;
  item_setting.setInt("Item ID", ID_item) ;

  // if(on_off_inventory_item[ID_item]) item_setting.setInt("Item On Off", 1) ; 
  if(inventory[ID_item].is()) item_setting.setInt("Item On Off", 1); 
  else item_setting.setInt("Item On Off", 0);
  item_setting.setString("Item Name", item_name[ID_item]) ;
  item_setting.setString("Item Class Name", item_load_name[ID_item]);
}




























/**
LOAD
v 2.0.2
*/
void load_setting_controller(File selection) {
  if (selection != null) {
    String loadPathControllerSetting = selection.getAbsolutePath();
    load_saved_file_controller(loadPathControllerSetting) ;
    INIT_INTERFACE = true ;
    LOAD_SETTING = true ;
  } 
}



// loadSave(path) read info from save file
void load_saved_file_controller(String path) {
  Table settingTable = loadTable(path, "header");
  // re-init the counter for the new loop
  int count_button_item = 0 ;
  int count_button_general = 0 ;
  int count_slider_general = 0;
  int count_slider_background = 0;
  int count_slider_filter = 0;
  int count_slider_light = 0;
  int count_slider_sound = 0;
  int count_slider_camera = 0;
  int count_slider_item = 0;
  int count_item = 0 ;


  for (TableRow row : settingTable.rows()) {
    String s = row.getString("Type");
    // button general
    if(s.equals("Button general")){ 
      int IDbutton = row.getInt("ID button") ;
      int IDmidi = row.getInt("ID midi") ;
      int onOff = row.getInt("On Off") ;
      if(count_button_general < info_button_general.length) {
        info_button_general[count_button_general].set(IDbutton,IDmidi,onOff);
      }
      count_button_general++; 
    }

    // button item
    if(s.equals("Button item")){ 
      int IDbutton = row.getInt("ID button") ;
      int IDmidi = row.getInt("ID midi") ;
      int onOff = row.getInt("On Off") ;
      if(count_button_item < info_button_item.length) {
        info_button_item[count_button_item].set(IDbutton,IDmidi,onOff);
      }
      count_button_item++; 
    }

    // slider background
    if(s.equals("Slider background")) {
      set_info_slider(row, "Slider background", info_slider_background, count_slider_background);
      count_slider_background++;
    }

    // slider filter
    if(s.equals("Slider filter")) {
      set_info_slider(row, "Slider filter", info_slider_filter, count_slider_filter);
      count_slider_filter++;
    }    
    // slider light
    if(s.equals("Slider light")) {
      set_info_slider(row, "Slider light", info_slider_light, count_slider_light);
      count_slider_light++;
    }

    // slider sound
    if(s.equals("Slider sound")) {
      set_info_slider(row, "Slider sound", info_slider_sound, count_slider_sound);
      count_slider_sound++;
    }
    
    // slider camera
    if(s.equals("Slider camera")) {
      set_info_slider(row, "Slider camera", info_slider_camera, count_slider_camera);
      count_slider_camera++;
    }

    // slider item
    if(s.equals("Slider item")) {
      set_info_slider(row, "Slider item", info_slider_item, count_slider_item);
      count_slider_item++;
    }

    
    // item list
    if(s.equals("Item")) {
      info_list_item_ID[count_item] = row.getInt("Item ID") ;

      String [] temp_item_info_split = split(item_info_raw[count_item +1], "/") ;
      int ID =  Integer.parseInt(temp_item_info_split[2]) ;
      boolean on_off = false ;
      if(row.getInt("Item On Off") == 1) {
        on_off = true; 
      } else {
        on_off = false;
      }

      inventory[ID].name = item_name[count_item +1]; 
      inventory[ID].set_is(on_off); 
      count_item++ ;
    }
  }
}


void set_info_slider(TableRow row, String name, Vec5 [] info, int rank) {
  int IDslider = row.getInt("ID slider") ;
  int IDmidi = row.getInt("ID midi") ;
  float value_slider = row.getFloat("Value slider") ; 
  float min = row.getFloat("Min slider") ;
  float max = row.getFloat("Max slider") ;
  info[rank] = Vec5(IDslider,IDmidi,value_slider,min,max) ;
}




















/**
SETTING SAVE
*/
boolean first_load;
void set_data() {
  if(INIT_INTERFACE) {
    set_button_inventory_item();
    if(!first_load) {
      set_inventory_item(false);
      first_load = true ;
    } else {
      set_inventory_item(true);
    }
    set_button_from_saved_file() ;
    set_slider_data_group() ;
    INIT_INTERFACE = false ;
  }
}


// Setting SLIDER from save
void set_slider_data_group() {
  for (int i = 0 ; i < NUM_SLIDER_BACKGROUND ; i++) {
    setting_data_slider(slider_adj_background,info_slider_background,i) ;
  }

  for (int i = 0 ; i < NUM_SLIDER_FILTER ; i++) {
    setting_data_slider(slider_adj_filter,info_slider_filter,i) ;
  }

  for (int i = 0 ; i < NUM_SLIDER_LIGHT ; i++) {
    setting_data_slider(slider_adj_light,info_slider_light,i) ;
  }

  for (int i = 0 ; i < NUM_SLIDER_SOUND ; i++) {
    setting_data_slider(slider_adj_sound,info_slider_sound,i) ;
  }

  for (int i = 0 ; i < NUM_SLIDER_CAMERA ; i++) {
    setting_data_slider(slider_adj_camera,info_slider_camera,i) ;
  }

  for(int i = 0 ; i < NUM_SLIDER_ITEM ; i++) {
    setting_data_slider(slider_adj_item,info_slider_item,i) ;
  }
}


// local method of set_slider_save()
void setting_data_slider(Slider_adjustable [] slider_adj, Vec5 [] info_slider, int index) {
  Vec5 info_temp = info_save_raw_list(info_slider,index).copy();
  slider_adj[index].set_id_midi((int)info_temp.b); 
  slider_adj[index].set_pos_molette(info_temp.c);
  slider_adj[index].set_min_max(info_temp.d, info_temp.e);
}



//setting BUTTON from save
void set_button_from_saved_file() {
  // close loop to save the button statement, 
  // see void midiButtonManager(boolean saveButton)
  int rank = 0;
  // background
  if(info_button_general[rank].z == 1.0) button_bg.set_is(true) ; else button_bg.set_is(false);
  button_bg.set_id_midi((int)info_button_general[rank].y); 
  rank++ ;
  // curtain
  if(info_button_general[rank].z == 1.0) button_curtain.set_is(true); else button_curtain.set_is(false);
  button_curtain.set_id_midi((int)info_button_general[rank].y); 
  rank++ ;
  //LIGHT ONE
  if(info_button_general[rank].z == 1.0) button_light_1.set_is(true); else button_light_1.set_is(false);
  button_light_1.set_id_midi((int)info_button_general[rank].y); 
  rank++ ;
  if(info_button_general[rank].z == 1.0) button_light_1_action.set_is(true); else button_light_1_action.set_is(false);
  button_light_1_action.set_id_midi((int)info_button_general[rank].y); 
  rank++ ;
  // LIGHT TWO
  if(info_button_general[rank].z == 1.0) button_light_2.set_is(true); else button_light_2.set_is(false);
  button_light_2.set_id_midi((int)info_button_general[rank].y); 
  rank++ ;
  if(info_button_general[rank].z == 1.0) button_light_2_action.set_is(true); else button_light_2_action.set_is(false);
  button_light_2_action.set_id_midi((int)info_button_general[rank].y); 
  rank++ ;
  //SOUND
  if(info_button_general[rank].z == 1.0) button_beat.set_is(true); else button_beat.set_is(false);
  button_beat.set_id_midi((int)info_button_general[rank].y);
  rank++ ; 
  if(info_button_general[rank].z == 1.0) button_kick.set_is(true); else button_kick.set_is(false);
  button_kick.set_id_midi((int)info_button_general[rank].y); 
  rank++ ;
  if(info_button_general[rank].z == 1.0) button_snare.set_is(true); else button_snare.set_is(false);
  button_snare.set_id_midi((int)info_button_general[rank].y);
  rank++ ;
  if(info_button_general[rank].z == 1.0) button_hat.set_is(true); else button_hat.set_is(false);
  button_hat.set_id_midi((int)info_button_general[rank].y); 
  rank++ ;
  
  //
  
  //
  

  /**
  can be simplify not sure it's necessary to use buttonRank
  */
  rank = 4; // start a 4 because we don't use the fourth for historic and bad reason
  int buttonRank ;
  for( int i = 1 ; i <= NUM_ITEM ; i++ ) {
    // for (int j = 1 ; j <= BUTTON_ITEM_CONSOLE ; j++) {
    for (int j = 0 ; j < BUTTON_ITEM_CONSOLE ; j++) {
      buttonRank = info_button_item[rank].x;
      if(info_button_item[rank].z == 1.0 && buttonRank == (i*BUTTON_ITEM_CONSOLE)+j) {
        button_item[buttonRank].set_is(true);
      } else {
        button_item[buttonRank].set_is(false); 
      }
      button_item[buttonRank].set_id_midi((int)info_button_item[rank].y);
      rank++ ;
    }
  }
}




// info_save_raw_list read info to translate and give a good position
Vec5 info_save_raw_list(Vec5[] list, int pos) {
  if(list != null) {
    Vec5 info = Vec5() ;
    float value_slider = 0 ;
    float value_slider_min = 0 ;
    float value_slider_max = 1 ;
    float IDmidi = 0 ;
    for(int i = 0 ; i < list.length ;i++) {
      if(list[i] != null ) if((int)list[i].a == pos) {
        value_slider = list[i].c ;
        value_slider_min = list[i].d ;
        value_slider_max = list[i].e ;
        IDmidi = list[i].b ;
        info = Vec5(pos, IDmidi,value_slider,value_slider_min,value_slider_max) ;
        break;
      } else {
        info = Vec5(-1) ;
      }
    }
    return info ;
  } else return null; 
}













//LOAD text Interface
void apply_text_gui() {
  String lang[] ;
  lang = loadStrings(preference_path+"language.txt");

  String l = join(lang,"") ;
  int language = Integer.parseInt(l);
  Table gui_table;
  if(language == 0) {
    gui_table = loadTable(preference_path+"slider_name_fr.csv","header");
  } else if (language == 1) {
    gui_table = loadTable(preference_path+"slider_name_en.csv","header");
  } else {
    gui_table = loadTable(preference_path+"slider_name_en.csv","header");
  }


  int num_row = gui_table.getRowCount();
  for (int i = 0 ; i < num_row ; i++) {
    TableRow row = gui_table.getRow(i);
    String name = row.getString("name");
    int num = NUM_SLIDER_ITEM_BY_COL ;

    if(name.equals("general")) {
      // 
    } else if(name.equals("background")) {
      for(int k = 0 ; k < NUM_SLIDER_BACKGROUND ; k++) {
        slider_background_name[k] = row.getString("col "+k);
      } 
    } else if(name.equals("filter")) {
      for(int k = 0 ; k < NUM_SLIDER_FILTER ; k++) {
        slider_filter_name[k] = row.getString("col "+k);
      }
    } else if(name.equals("light")) {
      for(int k = 0 ; k < NUM_SLIDER_LIGHT ; k++) {
        slider_light_name[k] = row.getString("col "+k);
      }
    } else if(name.equals("sound")) {
      for(int k = 0 ; k < NUM_SLIDER_SOUND ; k++) {
        slider_sound_name[k] = row.getString("col "+k);
      }
    } else if(name.equals("camera")) {
      for(int k = 0 ; k < NUM_SLIDER_CAMERA ; k++) {
        slider_camera_name[k] = row.getString("col "+k);
      }
    } else if(name.equals("item a")) {
      for(int k = 0 ; k < num ; k++) {
        slider_item_name[k] = row.getString("col "+k);
      }
    } else if(name.equals("item b")) {
      for(int k = 0 ; k < num ; k++) {
        slider_item_name[k +num] = row.getString("col "+k);
      }
    } else if(name.equals("item c")) {
      for(int k = 0 ; k < num ; k++) {
        slider_item_name[k +(num*2)] = row.getString("col "+k);
      }
    }   
  }
}





//IMPORT VIGNETTE
void set_import_pic_button() {
  //picto setting
  for(int i = 0 ; i < 4 ; i++) {
    picCurtain[i] = loadImage("picto/picto_curtain_"+i+".png") ;
    picMidi[i] = loadImage("picto/picto_midi_"+i+".png") ;
    picSetting[i] = loadImage("picto/picto_setting_"+i+".png") ;
    picSound[i] = loadImage("picto/picto_sound_"+i+".png") ;
    picAction[i] = loadImage("picto/picto_action_"+i+".png") ;
  }
  // load thumbnail
  int num = NUM_ITEM +1 ;
  OFF_in_thumbnail = new PImage[num] ;
  OFF_out_thumbnail = new PImage[num] ;
  ON_in_thumbnail = new PImage[num] ;
  ON_out_thumbnail = new PImage[num] ;
  for(int i=0 ;  i<num ; i++ ) {
    String className = ("0") ;
    if (item_load_name[i] != null) className = item_load_name[i] ;
    OFF_in_thumbnail[i] = loadImage("thumbnail/OFF_in/OFF_in_"+className+".png") ;
    if(OFF_in_thumbnail[i] == null) OFF_in_thumbnail[i] = loadImage("thumbnail/OFF_in/OFF_in_0.png") ;
    //
    OFF_out_thumbnail[i] = loadImage("thumbnail/OFF_out/OFF_out_"+className+".png") ;
    if(OFF_out_thumbnail[i] == null) OFF_out_thumbnail[i] = loadImage("thumbnail/OFF_out/OFF_out_0.png") ;
    // 
    ON_in_thumbnail[i] = loadImage("thumbnail/ON_in/ON_in_"+className+".png") ;
    if(ON_in_thumbnail[i] == null) ON_in_thumbnail[i] = loadImage("thumbnail/ON_in/ON_in_0.png") ;
    //
    ON_out_thumbnail[i] = loadImage("thumbnail/ON_out/ON_out_"+className+".png") ;
    if(ON_out_thumbnail[i] == null) ON_out_thumbnail[i] = loadImage("thumbnail/ON_out/ON_out_0.png") ;
  }
}