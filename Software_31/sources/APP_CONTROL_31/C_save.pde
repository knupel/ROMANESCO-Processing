/**
SAVE
v 2.0.0
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
    info_slider_background[i].c = slider_adj_background[i].get_value() ;
    info_slider_background[i].d = slider_adj_background[i].get_min_norm() ;
    info_slider_background[i].e = slider_adj_background[i].get_max_norm() ;
    set_data_slider(i, info_slider_background[i],"Slider background") ;
  }

  // filter
  for (int i = start ; i < NUM_SLIDER_FILTER ; i++) {
    info_slider_filter[i].c = slider_adj_filter[i].get_value() ;
    info_slider_filter[i].d = slider_adj_filter[i].get_min_norm() ;
    info_slider_filter[i].e = slider_adj_filter[i].get_max_norm() ;
    set_data_slider(i, info_slider_filter[i],"Slider filter") ;
  }

  // light
  for (int i = start ; i < NUM_SLIDER_LIGHT ; i++) {
    info_slider_light[i].c = slider_adj_light[i].get_value() ;
    info_slider_light[i].d = slider_adj_light[i].get_min_norm() ;
    info_slider_light[i].e = slider_adj_light[i].get_max_norm() ;
    set_data_slider(i, info_slider_light[i],"Slider light") ;
  }

  // sound
  for (int i = start ; i < NUM_SLIDER_SOUND ; i++) {
    info_slider_sound[i].c = slider_adj_sound[i].get_value() ;
    info_slider_sound[i].d = slider_adj_sound[i].get_min_norm() ;
    info_slider_sound[i].e = slider_adj_sound[i].get_max_norm() ;
    set_data_slider(i, info_slider_sound[i],"Slider sound") ;
  }

  // sound setting
  for (int i = start ; i < NUM_SLIDER_SOUND_SETTING ; i++) {
    info_slider_sound_setting[i].c = slider_sound_setting[i].get_value();
    set_data_slider(i, info_slider_sound_setting[i],"Slider sound setting") ;
  }

  // camera
  for (int i = start ; i < NUM_SLIDER_CAMERA ; i++) {
    // int temp = i-1 ;
    info_slider_camera[i].c = slider_adj_camera[i].get_value() ;
    info_slider_camera[i].d = slider_adj_camera[i].get_min_norm() ;
    info_slider_camera[i].e = slider_adj_camera[i].get_max_norm() ;
    set_data_slider(i, info_slider_camera[i],"Slider camera") ;
  }
 
  // item
  for(int i = 0; i < NUM_SLIDER_ITEM ; i++) {
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