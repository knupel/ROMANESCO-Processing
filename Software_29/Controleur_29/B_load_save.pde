/**
SETTING SAVE and LOAD 2.1.2
*/

//SETUP
void loadSetup() {
  buildSaveTable() ;
  createInfoButtonAndSlider(sketchPath("")+"preferences/setting/defaultSetting.csv") ;
  loadSaveController(sketchPath("")+"preferences/setting/defaultSetting.csv") ;
  
  //load text interface 
  // 0 is French
  // 1 is english
  textGUI() ;
}
//END SETUP






// LOAD INFO OBJECT from the PRESCENE
/////////////////////////////////////
Table objectList, shaderBackgroundList;
int numGroup [] ; 
int [] item_rank, item_ID, item_group, item_camera_video_on_off, item_GUI_on_off ;
String [] item_info ;
String [] item_name, item_author, item_version, item_pack, item_load_name, item_slider ; 
String [] shader_bg_name, shader_bg_author ;



//BUTTON
int numButton [] ;
int numButtonTotalObjects ;
int lastDropdown, numDropdown ;
int [] value_button_G0, value_button_item ; 
int [] pos_button_width_item, pos_button_height_item, width_button_item, height_button_item  ;



//Variable must be send to Scene
///////////////////////////////////////
// statement on_of for the object group
int [] on_off_item ;
boolean [] on_off_item_menu ; 


//////////
//DROPDOWN
//GLOBAL
Dropdown dropdown [] ;
Dropdown dropdown_font, dropdown_bg, dropdown_image, dropdown_file_text, dropdown_camera_video  ;

PVector pos_dropdown[] ;
PVector pos_dropdown_font, pos_dropdownBackground, pos_dropdown_image, pos_dropdown_file_text, pos_dropdown_camera_video ;
PVector size_dropdown_font, sizeDropdownBackground, size_dropdown_image, size_dropdown_file_text, size_dropdown_camera_video, size_dropdown_mode ;
PVector posTextDropdown = new PVector(2,8)  ;


String [] modeListRomanesco, font_dropdown_list, image_dropdown_list, file_text_dropdown_list,  name_camera_video_dropdown_list, list_dropdown ;
int  [] ID_camera_video_list ;

float marge_around_dropdown ;















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
  for (int i = 1 ; i < NUM_SLIDER_MISC ; i++) {
     // set PVector info Slider
     int temp = i-1 ;
     infoSlider[temp].c = slider[i].getValue() ;
     infoSlider[temp].d = slider[i].getValueMin() ;
     infoSlider[temp].e = slider[i].getValueMax() ;
     setSlider(i, (int)infoSlider[temp].b, infoSlider[temp].c,infoSlider[temp].d,infoSlider[temp].e) ;
   }
  
  // the group one, two, three
  for (int i = 1 ; i < NUM_GROUP_SLIDER ; i++) { 
    for(int j = 1 ; j < NUM_SLIDER_OBJ ; j++) {
      // set PVector info Slider
      int IDslider = j +(i *100) ;
      // third loop to check and find the good PVector array in the list
      for(int k = 0 ; k < infoSlider.length ;k++) {
        if( (int)infoSlider[k].a ==IDslider) {
          infoSlider[k].c = slider[IDslider].getValue() ;
          infoSlider[k].d = slider[IDslider].getValueMin() ;
          infoSlider[k].e = slider[IDslider].getValueMax() ;
          setSlider(IDslider, (int)infoSlider[k].b, infoSlider[k].c,infoSlider[k].d,infoSlider[k].e) ;
        }
      }
    }
  }
  showAllSliders = false ;
}

void save_info_item() {
  for(int i = 0 ; i < NUM_ITEM ; i++) {
    println("save", i, item_ID[i] +1) ;
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

  println(on_off_item_menu[ID_item]) ;
  if(on_off_item_menu[ID_item]) item_setting.setInt("Item On Off", 1) ; 
  else item_setting.setInt("Item On Off", 0) ;
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
}

/**
END SAVE

*/















/**
LOAD

*/
void loadSettingController(File selection) {
  if (selection != null) {
    String loadPathControllerSetting = selection.getAbsolutePath();
    loadSaveController(loadPathControllerSetting) ;
    loadSaveSetting = true ;
    setSave = true ;
  } 
}



// loadSave(path) read info from save file
void loadSaveController(String path) {
  
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
    if( s.equals("Slider")){
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
      int which_one = info_list_item_ID[count_item] ;
      String [] temp_item_info_split = split(item_info[which_one], "/") ;
      int ID =  Integer.parseInt(temp_item_info_split[2]) ;
      
      if(row.getInt("Item On Off") == 1) {
        println(count_item, ID) ;
        on_off_item_menu[ID] = true ; 
      } else on_off_item_menu[ID] = false ;
      count_item++ ;
    }
  }
}















// SETTING SAVE
/////////////////////////
Boolean setSave = true ;
void settingDataFromSave() {
  if(setSave) {
    setButtonSave() ;
    setSliderSave() ;
    setSave = false ;
  }
}


// Setting SLIDER from save
void setSliderSave() {
  for (int i = 1 ; i < NUM_SLIDER_MISC ; i++) {
    setttingSliderSave(i) ;
  }
  for (int i = 1 ; i < NUM_GROUP_SLIDER ; i++) { 
    for(int j = 1 ; j < NUM_SLIDER_OBJ ; j++) {
      int whichOne = j +(i *100) ;
      setttingSliderSave(whichOne) ;
    }
  }
}
// local method of setSliderSave()
void setttingSliderSave(int whichOne) {
  Vec5 infoSliderTemp = infoSaveFromRawList(infoSlider, whichOne).copy() ;
  slider[whichOne].setMidi((int)infoSliderTemp.b) ; 
  slider[whichOne].setMolette(infoSliderTemp.c) ; 
  slider[whichOne].setMinMax(infoSliderTemp.d, infoSliderTemp.e) ;
}




//setting BUTTON from save
void setButtonSave() {
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
    for (int j = 1 ; j <= BUTTON_BY_OBJECT ; j++) {
      rank++ ;
      buttonRank = (int)infoButton[rank].x ;
      if(infoButton[rank].z == 1.0 && buttonRank == (i*10)+j) button_item[buttonRank].on_off = true ; else button_item[buttonRank].on_off = false ; 
      button_item[buttonRank].IDmidi = (int)infoButton[rank].y ; 
    }
  }
}




// infoSaveFromRawList read info to translate and give a good position
Vec5 infoSaveFromRawList(Vec5[] list, int pos) {
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
int numCol = 15 ;
String[] genTxtGUI = new String[numCol] ;
String[] sliderNameLight = new String[numCol] ;
String[] sliderNameCamera = new String[numCol] ;
String[] sliderNameOne = new String[numCol] ;
String[] sliderNameTwo = new String[numCol] ;
String[] sliderNameThree = new String[numCol] ;

TableRow [] row = new TableRow[numCol+1] ;

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
    
  for ( int i = 0 ; i < numCol ; i++) {

    row[i] = textGUI.getRow(i) ;
    for ( int j = 1 ; j < numCol ; j++) {
      String whichCol = Integer.toString(j) ;
      if ( i == 0 ) genTxtGUI[j] = row[i].getString("Column "+whichCol) ;
      if ( i == 1 ) sliderNameLight[j] = row[i].getString("Column "+whichCol) ;
      if ( i == 2 ) sliderNameCamera[j] = row[i].getString("Column "+whichCol) ;
      if ( i == 3 ) sliderNameOne[j] = row[i].getString("Column "+whichCol) ;
      if ( i == 4 ) sliderNameTwo[j] = row[i].getString("Column "+whichCol) ;
      if ( i == 5 ) sliderNameThree[j] = row[i].getString("Column "+whichCol) ;
    }
  }
}





//IMPORT VIGNETTE
void importPicButtonSetup() {

  
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
    OFF_out_thumbnail[i] = loadImage("thumbnail/OFF_out/OFF_out_"+className+".png") ;
    ON_in_thumbnail[i] = loadImage("thumbnail/ON_in/ON_in_"+className+".png") ;
    ON_out_thumbnail[i] = loadImage("thumbnail/ON_out/ON_out_"+className+".png") ;
  }
}
