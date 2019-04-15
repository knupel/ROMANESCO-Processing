/**
SAVE
v 2.1.0
*/
String savePathSetting = ("") ;
void save_controller_setting(File selection) {
  savePathSetting = selection.getAbsolutePath() ;
  if (selection != null) {
    save_controller_setting(savePathSetting);
  }
}

void save_controller_setting(String path) {
  println("Save controller in progress:",path);
  save_info_slider();
  save_info_item();
  save_info_media();
  // for the fake item 0 with all the buttom console
  for(int i = 0 ; i < BUTTON_ITEM_CONSOLE ;i++) {
    set_data_button(i, 0,false,"Button item");
  }  
  midi_manager(true);
  saveTable(saveSetting, path);
  saveSetting.clearRows() ;
}






void autosave() {
  println("Autosave in progress");
  save_controller_setting(autosave_path);
}











/**
* dialogue data is a save can be read not often by the scene like setting mouse...
*/
void save_dial_controller(String path) {
  Table save_dial = new Table();
  save_dial.addColumn("mouse reactivity");
  TableRow table_row = save_dial.addRow() ;
  table_row.setFloat("mouse reactivity",mouse_reactivity);
  saveTable(save_dial,path+"/dialogue_from_controller.csv");
}






























// SAVE MEDIA PATH
void save_info_media() {
  for(File file : media_files) {
    String path = file.getAbsolutePath();
    set_data_media("Media",path);
  }
}




// SAVE SLIDERS
// save the position and the ID of the slider molette
void save_info_slider() {
  int start = 0;
  // background
  for (int i = start ; i < NUM_SLIDER_BACKGROUND ; i++) {
    cropinfo_slider_fx_bg[i].set_value(slider_adj_background[i].get(0));
    cropinfo_slider_fx_bg[i].set_min(slider_adj_background[i].get_min_norm());
    cropinfo_slider_fx_bg[i].set_max(slider_adj_background[i].get_max_norm());
    set_data_slider(i,cropinfo_slider_fx_bg[i],"Slider background");
  }

  // FX
  for (int i = start ; i < NUM_SLIDER_FX ; i++) {
    cropinfo_slider_fx[i].set_value(slider_adj_fx[i].get(0));
    cropinfo_slider_fx[i].set_min(slider_adj_fx[i].get_min_norm());
    cropinfo_slider_fx[i].set_max(slider_adj_fx[i].get_max_norm());
    set_data_slider(i,cropinfo_slider_fx[i],"Slider fx");
  }

  // MIX
  for (int i = start ; i < NUM_SLIDER_MIX ; i++) {
    cropinfo_slider_fx_mix[i].set_value(slider_adj_fx_mix[i].get(0));
    cropinfo_slider_fx_mix[i].set_min(slider_adj_fx_mix[i].get_min_norm());
    cropinfo_slider_fx_mix[i].set_max(slider_adj_fx_mix[i].get_max_norm());
    set_data_slider(i,cropinfo_slider_fx_mix[i],"Slider mix");
  }

  // light
  for (int i = start ; i < NUM_SLIDER_LIGHT ; i++) {
    cropinfo_slider_light[i].set_value(slider_adj_light[i].get(0));
    cropinfo_slider_light[i].set_min(slider_adj_light[i].get_min_norm());
    cropinfo_slider_light[i].set_max(slider_adj_light[i].get_max_norm());
    set_data_slider(i,cropinfo_slider_light[i],"Slider light");
  }

  // sound
  for (int i = start ; i < NUM_SLIDER_SOUND ; i++) {
    cropinfo_slider_sound[i].set_value(slider_adj_sound[i].get(0));
    cropinfo_slider_sound[i].set_min(slider_adj_sound[i].get_min_norm());
    cropinfo_slider_sound[i].set_max(slider_adj_sound[i].get_max_norm());
    set_data_slider(i,cropinfo_slider_sound[i],"Slider sound");
  }

  // sound setting
  for (int i = start ; i < NUM_SLIDER_SOUND_SETTING ; i++) {
    cropinfo_slider_sound_setting[i].set_value(slider_sound_setting[i].get());
    set_data_slider(i,cropinfo_slider_sound_setting[i],"Slider sound setting");
  }

  // camera
  for (int i = start ; i < NUM_SLIDER_CAMERA ; i++) {
    // int temp = i-1 ;
    cropinfo_slider_camera[i].set_value(slider_adj_camera[i].get(0));
    cropinfo_slider_camera[i].set_min(slider_adj_camera[i].get_min_norm());
    cropinfo_slider_camera[i].set_max(slider_adj_camera[i].get_max_norm());
    set_data_slider(i,cropinfo_slider_camera[i],"Slider camera");
  }
 
  // item
  String [] slider_name = new String[NUM_COL_SLIDER];
  slider_name [0] = "Slider item a";
  slider_name [1] = "Slider item b";
  slider_name [2] = "Slider item c";
  slider_name [3] = "Slider item d";
  int index = 0;
  for(int i = 0; i < NUM_SLIDER_ITEM ; i++) {
    int slider_ID = i;
    for(int k = 0 ; k < cropinfo_slider_item.length ;k++) {
      if(cropinfo_slider_item[k].get_id() == slider_ID) {
        cropinfo_slider_item[k].set_value(slider_adj_item[slider_ID].get(0));
        cropinfo_slider_item[k].set_min(slider_adj_item[slider_ID].get_min_norm());
        cropinfo_slider_item[k].set_max(slider_adj_item[slider_ID].get_max_norm());
        int min = NUM_SLIDER_ITEM_BY_COL *index;
        int max = NUM_SLIDER_ITEM_BY_COL *(index+1);
        if(i >= min && i <= max) {
          set_data_slider(slider_ID,cropinfo_slider_item[k],slider_name[index]);
          if(i == max) index++;
        } 
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





Table saveSetting;
void set_data_save_setting() {
  saveSetting = new Table();
  saveSetting.addColumn("Type") ;
  saveSetting.addColumn("ID slider");
  saveSetting.addColumn("Min slider");
  saveSetting.addColumn("Max slider");
  saveSetting.addColumn("Value length");
  saveSetting.addColumn("Value slider 0");
  saveSetting.addColumn("Value slider 1");
  saveSetting.addColumn("Value slider 2");
  saveSetting.addColumn("Value slider 3");
  saveSetting.addColumn("ID button");
  saveSetting.addColumn("On Off");
  saveSetting.addColumn("ID midi");
  saveSetting.addColumn("Item ID");
  saveSetting.addColumn("Item On Off");
  saveSetting.addColumn("Item Name");
  saveSetting.addColumn("Item Class Name");
  saveSetting.addColumn("Path");
}

//write the value in the table
void set_data_button(int IDbutton, int IDmidi, boolean is_on_off, String type) {
  TableRow buttonSetting = saveSetting.addRow() ;
  buttonSetting.setString("Type", type) ;
  buttonSetting.setInt("ID button", IDbutton) ;
  buttonSetting.setInt("ID midi", IDmidi) ;
  if(is_on_off) {
    buttonSetting.setInt("On Off",1); 
  } else {
    buttonSetting.setInt("On Off",0);
  }
}

//
void set_data_slider(int id_slider, Cropinfo info, String name){
  TableRow sliderSetting = saveSetting.addRow();
  sliderSetting.setString("Type",name);
  sliderSetting.setInt("ID slider",id_slider);
  sliderSetting.setInt("ID midi",info.get_id_midi());
  for(int i = 0 ; i < info.get_value().length; i++) {
    sliderSetting.setFloat("Value slider "+i, info.get_value(i));
  }
  sliderSetting.setInt("Value length",info.get_value().length);    
  sliderSetting.setFloat("Min slider",info.get_min()); 
  sliderSetting.setFloat("Max slider",info.get_max()); 
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


void set_data_media(String type, String path) {
  TableRow media = saveSetting.addRow() ;
  media.setString("Type",type);
  media.setString("Path",path);
}



