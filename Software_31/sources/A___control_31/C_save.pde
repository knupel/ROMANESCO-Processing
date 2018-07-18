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


void autosave() {
  println("Autosave in progress");
  save_controller_setting(autosave_path);
}



void save_controller_setting(String path) {
  println("Save controller in progress:",path);
  save_info_slider();
  save_info_item();
  // for the fake item 0 with all the buttom console
  for(int i = 0 ; i < BUTTON_ITEM_CONSOLE ;i++) {
    set_data_button(i, 0,false,"Button item");
  }  
  midi_manager(true);
  saveTable(saveSetting, path);
  saveSetting.clearRows() ;
}




// SAVE SLIDERS
// save the position and the ID of the slider molette
void save_info_slider() {
  int start = 0;
  // background
  for (int i = start ; i < NUM_SLIDER_BACKGROUND ; i++) {
    cropinfo_slider_background[i].set_value(slider_adj_background[i].get_value(0));
    cropinfo_slider_background[i].set_min(slider_adj_background[i].get_min_norm());
    cropinfo_slider_background[i].set_max(slider_adj_background[i].get_max_norm());
    set_data_slider(i,cropinfo_slider_background[i],"Slider background");
  }

  // filter
  for (int i = start ; i < NUM_SLIDER_FILTER ; i++) {
    cropinfo_slider_filter[i].set_value(slider_adj_filter[i].get_value(0));
    cropinfo_slider_filter[i].set_min(slider_adj_filter[i].get_min_norm());
    cropinfo_slider_filter[i].set_max(slider_adj_filter[i].get_max_norm());
    set_data_slider(i,cropinfo_slider_filter[i],"Slider filter");
  }

  // light
  for (int i = start ; i < NUM_SLIDER_LIGHT ; i++) {
    cropinfo_slider_light[i].set_value(slider_adj_light[i].get_value(0));
    cropinfo_slider_light[i].set_min(slider_adj_light[i].get_min_norm());
    cropinfo_slider_light[i].set_max(slider_adj_light[i].get_max_norm());
    set_data_slider(i,cropinfo_slider_light[i],"Slider light");
  }

  // sound
  for (int i = start ; i < NUM_SLIDER_SOUND ; i++) {
    cropinfo_slider_sound[i].set_value(slider_adj_sound[i].get_value(0));
    cropinfo_slider_sound[i].set_min(slider_adj_sound[i].get_min_norm());
    cropinfo_slider_sound[i].set_max(slider_adj_sound[i].get_max_norm());
    set_data_slider(i,cropinfo_slider_sound[i],"Slider sound");
  }

  // sound setting
  for (int i = start ; i < NUM_SLIDER_SOUND_SETTING ; i++) {
    cropinfo_slider_sound_setting[i].set_value(slider_sound_setting[i].get_value());
    set_data_slider(i,cropinfo_slider_sound_setting[i],"Slider sound setting");
  }

  // camera
  for (int i = start ; i < NUM_SLIDER_CAMERA ; i++) {
    // int temp = i-1 ;
    cropinfo_slider_camera[i].set_value(slider_adj_camera[i].get_value(0));
    cropinfo_slider_camera[i].set_min(slider_adj_camera[i].get_min_norm());
    cropinfo_slider_camera[i].set_max(slider_adj_camera[i].get_max_norm());
    set_data_slider(i,cropinfo_slider_camera[i],"Slider camera");
  }
 
  // item
  for(int i = 0; i < NUM_SLIDER_ITEM ; i++) {
    int IDslider = i;
    for(int k = 0 ; k < cropinfo_slider_item.length ;k++) {
      if(cropinfo_slider_item[k].get_id() == IDslider) {
        cropinfo_slider_item[k].set_value(slider_adj_item[IDslider].get_value(0));
        cropinfo_slider_item[k].set_min(slider_adj_item[IDslider].get_min_norm());
        cropinfo_slider_item[k].set_max(slider_adj_item[IDslider].get_max_norm());
        set_data_slider(IDslider,cropinfo_slider_item[k],"Slider item");
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