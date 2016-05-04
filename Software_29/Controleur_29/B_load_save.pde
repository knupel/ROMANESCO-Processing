/**
SETTING SAVE and LOAD 2.1.3
*/

//SETUP
void load_setup() {
  buildSaveTable() ;
  createInfoButtonAndSlider(sketchPath("")+"preferences/setting/defaultSetting.csv") ;
  load_saved_file_controller(sketchPath("")+"preferences/setting/defaultSetting.csv") ;
  
  //load text interface 
  // 0 is French
  // 1 is english
  textGUI() ;
}
//END SETUP






// LOAD INFO OBJECT from the PRESCENE
/////////////////////////////////////
Table item_list_table, shaderBackgroundList;
int numGroup [] ; 
int [] item_rank, item_ID, item_group, item_camera_video_on_off, item_GUI_on_off ;
String [] item_info, item_info_raw ;
String [] item_name, item_author, item_version, item_pack, item_load_name, item_slider ; 
String [] shader_bg_name, shader_bg_author ;



//BUTTON
int numButton [] ;
int numButtonTotalObjects ;
int lastDropdown, numDropdown ;
int [] value_button_general, value_button_item ; 
int [] pos_button_width_item, pos_button_height_item, width_button_item, height_button_item  ;



//Variable must be send to Scene
///////////////////////////////////////
// statement on_of for the object group
int [] on_off_item_console ;
// boolean [] on_off_item_list ; 
ItemOnOff [] on_off_item_list ;


//////////
//DROPDOWN
//GLOBAL
Dropdown dropdown [] ;
Dropdown dropdown_font, dropdown_bg, dropdown_image_bitmap, dropdown_image_svg, dropdown_movie, dropdown_file_text, dropdown_camera_video  ;

PVector pos_dropdown[] ;
PVector pos_dropdown_font, pos_dropdown_bg, pos_dropdown_image_bitmap, pos_dropdown_image_svg, pos_dropdown_movie, pos_dropdown_file_text, pos_dropdown_camera_video ;
PVector size_dropdown_font, size_dropdown_bg, size_dropdown_image_bitmap, size_dropdown_image_svg, size_dropdown_movie, size_dropdown_file_text, size_dropdown_camera_video, size_dropdown_mode ;
PVector posTextDropdown = new PVector(2,8)  ;


String [] modeListRomanesco, font_dropdown_list, image_bitmap_dropdown_list, image_svg_dropdown_list, movie_dropdown_list, file_text_dropdown_list,  name_camera_video_dropdown_list, list_dropdown ;
int  [] ID_camera_video_list ;

float marge_around_dropdown ;



class ItemOnOff {
  String name = "" ;
  boolean on_off = false ;
  ItemOnOff(String name, boolean on_off) {
    this.name = name ;
    this.on_off = on_off ;
  }
}











/**
SETTING INFO BUTTON AND SLIDER
*/

// create var info for the button and the slider
void createInfoButtonAndSlider(String path) {
  Table table = loadTable(path, "header");
  // create the var info for the slider we need
  int countSlider = 0 ;
  for (TableRow row : table.rows()) {
    String s = row.getString("Type") ;
    if( s.equals("Slider")) countSlider++ ; 
  }
  infoSlider = new Vec5 [countSlider] ;
  // create the var info for the item we need
  info_list_item_ID = new int [NUM_ITEM] ;
  
  // we don't count from the save in case we add object and this one has never use before and he don't exist in the data base
  infoButton = new PVector [NUM_ITEM *4 +10] ; 
  for(int i = 0 ; i < infoButton.length ; i++) infoButton[i] = new PVector() ;
}










/**
SAVE & LOAD

*/
/**
SAVE
*/
String savePathSetting = ("") ;
void saveSetting(File selection) {
  savePathSetting = selection.getAbsolutePath() ;
  if (selection != null) saveSetting(savePathSetting) ;
}

void saveSetting(String path) {
  saveInfoSlider() ;
  save_info_item() ;
  midiButtonManager(true) ;
  saveTable(saveSetting, path);
  saveSetting.clearRows() ;
}



// SAVE SLIDERS
// save the position and the ID of the slider molette
void saveInfoSlider() {
  //group zero
  for (int i = 1 ; i < NUM_SLIDER_GENERAL ; i++) {
     // set PVector info Slider
     int temp = i-1 ;
     infoSlider[temp].c = slider[i].getValue() ;
     infoSlider[temp].d = slider[i].getValueMin() ;
     infoSlider[temp].e = slider[i].getValueMax() ;
     setSlider(i, (int)infoSlider[temp].b, infoSlider[temp].c,infoSlider[temp].d,infoSlider[temp].e) ;
   }
  
  // item info slider
  for(int i = 1 ; i <= NUM_SLIDER_ITEM ; i++) {
    // set PVector info Slider
    int IDslider = i +100 ;
    // third loop to check and find the good PVector array in the list
    for(int j = 0 ; j < infoSlider.length ;j++) {
      if( (int)infoSlider[j].a ==IDslider) {
        infoSlider[j].c = slider[IDslider].getValue() ;
        infoSlider[j].d = slider[IDslider].getValueMin() ;
        infoSlider[j].e = slider[IDslider].getValueMax() ;
        setSlider(IDslider, (int)infoSlider[j].b, infoSlider[j].c,infoSlider[j].d,infoSlider[j].e) ;
      }
    }
  }

  showAllSliders = false ;
}

void save_info_item() {
  for(int i = 0 ; i < NUM_ITEM ; i++) {
    set_item(item_ID[i] +1) ;
  }
}




// BUTTON SAVE
Table saveSetting ;
//write the value in the table
void setButton(int IDbutton, int IDmidi, boolean b) {
  TableRow buttonSetting = saveSetting.addRow() ;
  buttonSetting.setString("Type", "Button") ;
  buttonSetting.setInt("ID button", IDbutton) ;
  buttonSetting.setInt("ID midi", IDmidi) ;
  if(b) buttonSetting.setInt("On Off", 1) ; else buttonSetting.setInt("On Off", 0) ;
}
//
void setSlider(int IDslider, int IDmidi, float value, float min, float max) {
  TableRow sliderSetting = saveSetting.addRow() ;
  sliderSetting.setString("Type", "Slider") ;
  sliderSetting.setInt("ID slider", IDslider) ;
  sliderSetting.setInt("ID midi", IDmidi) ;
  sliderSetting.setFloat("Value slider", value) ; 
  sliderSetting.setFloat("Min slider", min) ; 
  sliderSetting.setFloat("Max slider", max) ; 
}

// void set_item(int ID_item, boolean display_item_on_off) {
void set_item(int ID_item) {
  TableRow item_setting = saveSetting.addRow() ;
  item_setting.setString("Type", "Item") ;
  item_setting.setInt("Item ID", ID_item) ;

  // if(on_off_item_list[ID_item]) item_setting.setInt("Item On Off", 1) ; 
  if(on_off_item_list[ID_item].on_off) item_setting.setInt("Item On Off", 1) ; 
  else item_setting.setInt("Item On Off", 0) ;
  item_setting.setString("Item Name", item_name[ID_item]) ;
  item_setting.setString("Item Class Name", item_load_name[ID_item]) ;
}

void buildSaveTable() {
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

/**
END SAVE

*/















/**
LOAD

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
  int countButton = 0 ;
  int countSlider = 0 ;
  int count_item = 0 ;


  for (TableRow row : settingTable.rows()) {
    String s = row.getString("Type") ;
    // button
    if( s.equals("Button")){ 
      int IDbutton = row.getInt("ID button") ;
      int IDmidi = row.getInt("ID midi") ;
      int onOff = row.getInt("On Off") ;
      /* if(countButton < infoButton.length) is used in case that the number is inferior at the number of object in save file */
      if(countButton < infoButton.length) infoButton[countButton] = new PVector(IDbutton,IDmidi,onOff) ;
      countButton++ ; 
    }

    // slider
    if( s.equals("Slider")) {
      int IDslider = row.getInt("ID slider") ;
      int IDmidi = row.getInt("ID midi") ;
      float valueSlider = row.getFloat("Value slider") ; 
      float min = row.getFloat("Min slider") ;
      float max = row.getFloat("Max slider") ;
      infoSlider[countSlider] = Vec5(IDslider,IDmidi,valueSlider,min,max) ;
      countSlider++ ;
    }
    
    // item list
    if(s.equals("Item")) {
      info_list_item_ID[count_item] = row.getInt("Item ID") ;

      String [] temp_item_info_split = split(item_info_raw[count_item +1], "/") ;
      int ID =  Integer.parseInt(temp_item_info_split[2]) ;
      // int ID =  count_item +1 ;
      boolean on_off = false ;
      if( row.getInt("Item On Off") == 1) on_off = true ; else  on_off = false ;

      on_off_item_list[ID].name = item_name[count_item +1] ; 
      on_off_item_list[ID].on_off = on_off ; 
      count_item++ ;
    }
  }
}















// SETTING SAVE
/////////////////////////

void set_data_from_save() {
  if(INIT_INTERFACE) {
    set_button_item_list() ;
    set_item_list() ;
    set_button_from_saved_file() ;
    set_slider_save() ;

    INIT_INTERFACE = false ;
  }
}


// Setting SLIDER from save
void set_slider_save() {
  // general
  for (int i = 1 ; i < NUM_SLIDER_GENERAL ; i++) {
    setttingSliderSave(i) ;
  }
  // item
  for(int j = 1 ; j < NUM_SLIDER_ITEM ; j++) {
    setttingSliderSave(j +100) ;
  }
}


// local method of set_slider_save()
void setttingSliderSave(int whichOne) {
  Vec5 infoSliderTemp = info_save_raw_list(infoSlider, whichOne).copy() ;
  slider[whichOne].setMidi((int)infoSliderTemp.b) ; 
  slider[whichOne].setMolette(infoSliderTemp.c) ; 
  slider[whichOne].setMinMax(infoSliderTemp.d, infoSliderTemp.e) ;
}




//setting BUTTON from save
void set_button_from_saved_file() {
  // close loop to save the button statement, 
  // see void midiButtonManager(boolean saveButton)
  int rank = 0 ;
  // Background and Curtain
  if(infoButton[rank].z  == 1.0) button_bg.on_off = true ; else button_bg.on_off = false ;
  button_bg.IDmidi = (int)infoButton[rank].y ; 
  rank++ ;
  if(infoButton[rank].z == 1.0) button_curtain.on_off = true ; else button_curtain.on_off = false ;
  button_curtain.IDmidi = (int)infoButton[rank].y ; 
  rank++ ;
  //LIGHT ONE
  if(infoButton[rank].z == 1.0) button_light_1.on_off = true ; else button_light_1.on_off = false ;
  button_light_1.IDmidi = (int)infoButton[rank].y ; 
  rank++ ;
  if(infoButton[rank].z == 1.0) button_light_1_action.on_off = true ; else button_light_1_action.on_off = false ;
  button_light_1_action.IDmidi = (int)infoButton[rank].y ; 
  rank++ ;
  // LIGHT TWO
  if(infoButton[rank].z == 1.0) button_light_2.on_off = true ; else button_light_2.on_off = false ;
  button_light_2.IDmidi = (int)infoButton[rank].y ; 
  rank++ ;
  if(infoButton[rank].z == 1.0) button_light_2_action.on_off = true ; else button_light_2_action.on_off = false ;
  button_light_2_action.IDmidi = (int)infoButton[rank].y ; 
  rank++ ;
  //SOUND
  if(infoButton[rank].z == 1.0) button_beat.on_off = true ; else button_beat.on_off = false ;
  button_beat.IDmidi = (int)infoButton[rank].y ;
 rank++ ; 
  if(infoButton[rank].z == 1.0) button_kick.on_off = true ; else button_kick.on_off = false ;
  button_kick.IDmidi = (int)infoButton[rank].y ; 
  rank++ ;
  if(infoButton[rank].z == 1.0) button_snare.on_off = true ; else button_snare.on_off = false ;
  button_snare.IDmidi = (int)infoButton[rank].y ;
  rank++ ;
  if(infoButton[rank].z == 1.0) button_hat.on_off = true ; else button_hat.on_off = false ;
  button_hat.IDmidi = (int)infoButton[rank].y ; 
  rank++ ;
  
  //
  rank--  ;
  //
  
  // int whichGroup = 1 ;
  int buttonRank ;
  for( int i = 1 ; i <= NUM_ITEM ; i++ ) {
    for (int j = 1 ; j <= BUTTON_ITEM_CONSOLE ; j++) {
      rank++ ;
      buttonRank = (int)infoButton[rank].x ;
      if(infoButton[rank].z == 1.0 && buttonRank == (i*10)+j) {
        button_item[buttonRank].on_off = true ;
      } else {
        button_item[buttonRank].on_off = false ; 
      }
      button_item[buttonRank].IDmidi = (int)infoButton[rank].y ; 
    }
  }
}




// info_save_raw_list read info to translate and give a good position
Vec5 info_save_raw_list(Vec5[] list, int pos) {
  Vec5 info = new Vec5() ;
  float valueSlider = 0 ;
  float valueSliderMin = 0 ;
  float valueSliderMax = 1 ;
  float IDmidi = 0 ;
  for(int i = 0 ; i < list.length ;i++) {
    if(list[i] != null ) if((int)list[i].a == pos) {
      valueSlider = list[i].c ;
      valueSliderMin = list[i].d ;
      valueSliderMax = list[i].e ;
      IDmidi = list[i].b ;
      info = new Vec5(pos, IDmidi,valueSlider,valueSliderMin,valueSliderMax) ;
      break;
    } else {
      info = new Vec5(-1,-1,-1,-1,-1) ;
    }
  }
  return info ;
}
/**
END LOAD

*/












//LOAD text Interface
Table textGUI;
String[] genTxtGUI = new String[SLIDER_BY_COL] ;
String[] slider_item_nameLight = new String[SLIDER_BY_COL] ;
String[] slider_item_nameCamera = new String[SLIDER_BY_COL] ;

TableRow [] row = new TableRow[SLIDER_BY_COL +1] ;

String lang[] ;

void textGUI() {
  if (!test)lang = loadStrings(sketchPath("") +"preferences/language.txt") ; else lang = loadStrings("preferences/language.txt") ;
  String l = join(lang,"") ;
  int language = Integer.parseInt(l);

  
  if( language == 0 ) { 
    textGUI = loadTable(sketchPath("")+"preferences/sliderListFR.csv", "header") ;
  } else if (language == 1 ) {
    textGUI = loadTable(sketchPath("")+"preferences/sliderListEN.csv", "header") ;
  } else {
    textGUI = loadTable(sketchPath("")+"preferences/sliderListEN.csv", "header") ;
  }
    
  for ( int i = 0 ; i <  SLIDER_BY_COL ; i++) {

    row[i] = textGUI.getRow(i) ;
    for ( int j = 1 ; j <  SLIDER_BY_COL ; j++) {
      String whichCol = Integer.toString(j) ;
      if ( i == 0 ) genTxtGUI[j] = row[i].getString("Column "+whichCol) ;
      if ( i == 1 ) slider_item_nameLight[j] = row[i].getString("Column "+whichCol) ;
      if ( i == 2 ) slider_item_nameCamera[j] = row[i].getString("Column "+whichCol) ;
    }
    for ( int j = 1 ; j <  SLIDER_BY_COL_PLUS_ONE ; j++) {
      String whichCol = Integer.toString(j) ;
      if ( i == 3 ) slider_item_name[j +(SLIDER_BY_COL *0)] = row[i].getString("Column "+whichCol) ;
      if ( i == 4 ) slider_item_name[j +(SLIDER_BY_COL *1)] = row[i].getString("Column "+whichCol) ;
      if ( i == 5 ) slider_item_name[j +(SLIDER_BY_COL *2)] = row[i].getString("Column "+whichCol) ;
    }
  }
}





//IMPORT VIGNETTE
void set_import_pic_button() {

  
  //picto setting
  for(int i = 0 ; i<4 ; i++) {
    picCurtain[i]   = loadImage("picto/picto_curtain_"+i+".png") ;
    picMidi[i]   = loadImage("picto/picto_midi_"+i+".png") ;
    picSetting[i] = loadImage("picto/picto_setting_"+i+".png") ;
    picSound[i]   = loadImage("picto/picto_sound_"+i+".png") ;
    picAction[i]   = loadImage("picto/picto_action_"+i+".png") ;
  }
  // load thumbnail
  int num = NUM_ITEM +1 ;
  OFF_in_thumbnail = new PImage[num] ;
  OFF_out_thumbnail = new PImage[num] ;
  ON_in_thumbnail = new PImage[num] ;
  ON_out_thumbnail = new PImage[num] ;
  for(int i=0 ;  i<num ; i++ ) {
    String className = ("0") ;
    if (item_load_name[i] != null ) className = item_load_name[i] ;
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
