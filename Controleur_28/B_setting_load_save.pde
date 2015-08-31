// Tab: B_setting_load_save

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
int [] objectLibraryOrder, objectID, objectGroup ;
String  [] objectName , objectAuthor, objectVersion, objectPack, objectRender, objectLoadName, objectSlider ; 
boolean [] objectClassic, objectP2D, objectP3D ;
//int [][] objectLibraryOrder, objectID, objectGroup ;
//String  [][] objectName , objectAuthor, objectVersion, objectPack, objectRender, objectLoadName, objectSlider ; 
//boolean [][] objectClassic, objectP2D, objectP3D ;
String [] shaderBackgroundName, shaderBackgroundAuthor ;



//BOUTON
int numButton [] ;
int numButtonTotalObjects ;
int lastDropdown, numDropdown ;
//BUTTON
int valueButtonGroup_0[], valueButtonGroup_1[], valueButtonGroup_2[] ; 
Simple  BOmidi, BOcurtain,
        buttonBackground, 
        buttonLightAmbient, buttonLightAmbientAction,
        buttonLightOne, buttonLightOneAction,
        buttonLightTwo, buttonLightTwoAction,
        Bbeat, Bkick, Bsnare, Bhat;
        
//button group one
Simple[] button_G1  ;
int pos_button_width_G1[], pos_button_height_G1[], width_button_G1[], height_button_G1[]  ;
// int opacity_button_G1[], posWidthBOf[], posHeightBOf[], longueurBOf[], hauteurBOf[]  ;
// int thickness_stroke_G1[], transparenceBoutonBOf[], posWidthBOf[], posHeightBOf[], longueurBOf[], hauteurBOf[]  ;
// int opacity_stroke_G1[], epaisseurBordBOf[], transparenceBoutonBOf[], posWidthBOf[], posHeightBOf[], longueurBOf[], hauteurBOf[]  ;
// int transparenceBordBOf[], epaisseurBordBOf[], transparenceBoutonBOf[], posWidthBOf[], posHeightBOf[], longueurBOf[], hauteurBOf[]  ;
//button group two
Simple[] button_G2  ;
int pos_button_width_G2[], pos_button_height_G2[], width_button_G2[], height_button_G2[]  ;
// int transparenceBordBTf[], epaisseurBordBTf[], transparenceBoutonBTf[], posWidthBTf[],posHeightBTf[], longueurBTf[], hauteurBTf[]  ;



//Variable must be send to Scene
///////////////////////////////////////
// statement on_of for the object group
int on_off_group_one[], on_off_group_two[] ; 


//////////
//DROPDOWN
int startLoopObject, endLoopObject, startLoopTexture, endLoopTexture ;
//GLOBAL
Dropdown dropdown[], dropdownFont, dropdownBackground, dropdownImage, dropdownFileText, dropdownCameraVideo  ;

PVector posDropdownFont, posDropdownBackground, posDropdownImage, posDropdownFileText, posDropdownCameraVideo, posDropdown[] ;
PVector sizeDropdownFont, sizeDropdownBackground, sizeDropdownImage, sizeDropdownFileText, sizeDropdownCameraVideo, sizeDropdownMode ;
PVector posTextDropdown = new PVector(2,8)  ;


String [] modeListRomanesco, policeDropdownList, imageDropdownList, fileTextDropdownList,  cameraVideoDropdownList, listDropdown, listDropdownBackground;

float margeAroundDropdown ;


//SETTING
 /////////
void buildLibrary() {
  objectList = loadTable(sketchPath("")+"preferences/objects/index_romanesco_objects.csv", "header") ;
  shaderBackgroundList = loadTable(sketchPath("")+"preferences/shaderBackgroundList.csv", "header") ;
  numByGroup() ;
  initVarObject() ;
  initVarSlider() ;
  initVarButton() ;
  infoByObject() ;
  infoShaderBackground() ;
}

void initVarSlider() {
  for (int i = 0 ; i < NUM_SLIDER_TOTAL ;i++) {
    sizeSlider[i] = new PVector() ;
    posSlider[i] = new PVector() ; 
  }
}

void initVarObject() {

  objectLibraryOrder = new int [numObj +1] ;
  objectID = new int [numObj +1] ;
  objectGroup = new int [numObj +1] ;
  objectName = new String [numObj +1] ;
  objectAuthor = new String [numObj +1] ;
  objectVersion = new String [numObj +1] ;
  objectPack = new String [numObj +1] ;
  objectRender = new String [numObj +1] ;
  objectLoadName = new String [numObj +1] ;
  objectClassic = new boolean [numObj +1] ;
  objectP2D = new boolean [numObj +1] ;
  objectP3D = new boolean [numObj +1] ;
  objectSlider = new String [numObj +1] ;
}



void initVarButton() {
  numButton = new int[NUM_GROUP_SLIDER] ;
  
  numButton[0] = 18 ;
  for (int i = 1 ; i < NUM_GROUP_SLIDER ; i++ ) {
    numButton[i] = numGroup[i]*10 ;
    numButtonTotalObjects += numGroup[i] ;
  }

  numDropdown = numObj +1 ; // add one for the dropdownmenu
  lastDropdown = numDropdown -1 ;
  
  valueButtonGroup_0 = new int[numButton[0]] ;
  valueButtonGroup_1 = new int[numButton[1]] ;
  valueButtonGroup_2 = new int[numButton[2]] ;
  // Group one
  button_G1 = new Simple[numButton[1] +10] ;
  pos_button_width_G1 =              new int[numButton[1] +10] ;
  pos_button_height_G1 =             new int[numButton[1] +10] ;
  width_button_G1 =              new int[numButton[1] +10] ;
  height_button_G1 =               new int[numButton[1] +10] ;
  
  // group two
  button_G2 = new Simple[numButton[2] +10] ;
  pos_button_width_G2 =              new int[numButton[2] +10] ;
  pos_button_height_G2 =             new int[numButton[2] +10] ;
  width_button_G2 =              new int[numButton[2] +10] ;
  height_button_G2 =               new int[numButton[2] +10] ;
  

  
  //paramètre bouton
  on_off_group_one = new int[numButton[1]] ;
  on_off_group_two = new int[numButton[2]] ;
  
  //dropdown
  modeListRomanesco = new String[numDropdown] ;
  dropdown = new Dropdown[numDropdown] ;
  posDropdown = new PVector[numDropdown] ;
  startLoopObject = 1 ;
  endLoopObject = 1 +numGroup[1] ;
  startLoopTexture = endLoopObject ; 
  endLoopTexture = startLoopTexture +numGroup[2] ;

}


void infoShaderBackground() {
  int n = shaderBackgroundList.getRowCount() ;
  shaderBackgroundName = new String[n] ;
  shaderBackgroundAuthor = new String[n] ;
  for (int i = 0 ; i < n ; i++ ) {
     TableRow row = shaderBackgroundList.getRow(i) ;
     shaderBackgroundName[i] = row.getString("Name") ;
     shaderBackgroundAuthor[i] = row.getString("Author") ;
  }
}

void infoByObject() {
  for(int i = 0 ; i < numObj ; i++) {
    TableRow lookFor = objectList.getRow(i) ;
    int ID = lookFor.getInt("ID") ;
    for(int j = 0 ; j <= numObj ; j++) {
      if(ID == j ) { 
        objectLibraryOrder[j] =lookFor.getInt("Library Order") ;
        objectID [j] = lookFor.getInt("ID") ;
        objectGroup[j] = lookFor.getInt("Group");
        objectPack[j] = lookFor.getString("Pack");
        objectRender[j] = lookFor.getString("Render");
        objectAuthor[j] = lookFor.getString("Author");
        objectVersion[j] = lookFor.getString("Version");
        objectLoadName[j] = lookFor.getString("Class name");
        objectName[j] = lookFor.getString("Name");
        objectSlider[j] = lookFor.getString("Slider") ;
      }
    }
  }
}



void numByGroup() {
  numGroup  = new int[NUM_GROUP_SLIDER] ;
  for (TableRow row : objectList.rows()) {
    int objectGroup = row.getInt("Group");
    for (int i = 0 ; i < NUM_SLIDER_TOTAL ;i++) {
      if (objectGroup == i) numGroup[i] += 1 ;
    }
  }
  //give the num total of objects
  numObj = numGroup[1] +numGroup[2] ;
}
// END BUILD LIBRARY
////////////////////











//////////////////////////////////
// SETTING INFO BUTTON AND SLIDER

// create var info for the button and the slider

void createInfoButtonAndSlider(String path) {
  Table table = loadTable(path, "header");
  // create the good num of Var info about slider and button
  int countButton = 0 ;
  int countSlider = 0 ;
  
  for (TableRow row : table.rows()) {
    String s = row.getString("Type") ;
    if( s.equals("Slider")) countSlider++ ; 
  }
  infoSlider = new Vec5 [countSlider] ;
  
  // we don't count from the save in case we add object and this one has never use before and he don't exist in the data base
  infoButton = new PVector [numObj*4 +10] ; 
  for(int i = 0 ; i < infoButton.length ; i++) infoButton[i] = new PVector() ;
}
//////////////////////////////////









/////////////
// SAVE LOAD

// SAVE
///////
String savePathSetting = ("") ;
void saveSetting(File selection) {
  savePathSetting = selection.getAbsolutePath() ;
  if (selection != null) saveSetting(savePathSetting) ;
}

void saveSetting(String path) {
  saveInfoSlider() ;
  midiButtonManager(true) ;
  saveTable(saveSetting, path+".csv");
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
}


// END SAVE
///////////







//LOAD setting
//////
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
     infoSlider[countSlider] = new Vec5(IDslider,IDmidi,valueSlider,min,max) ;
     countSlider++ ;
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
  if(infoButton[rank].z  == 1.0) buttonBackground.onOff = true ; else buttonBackground.onOff = false ;
  buttonBackground.IDmidi = (int)infoButton[rank].y ; 
  rank++ ;
  if(infoButton[rank].z == 1.0) BOcurtain.onOff = true ; else BOcurtain.onOff = false ;
  BOcurtain.IDmidi = (int)infoButton[rank].y ; 
  rank++ ;
  //LIGHT ONE
  if(infoButton[rank].z == 1.0) buttonLightOne.onOff = true ; else buttonLightOne.onOff = false ;
  buttonLightOne.IDmidi = (int)infoButton[rank].y ; 
  rank++ ;
  if(infoButton[rank].z == 1.0) buttonLightOneAction.onOff = true ; else buttonLightOneAction.onOff = false ;
  buttonLightOneAction.IDmidi = (int)infoButton[rank].y ; 
  rank++ ;
  // LIGHT TWO
  if(infoButton[rank].z == 1.0) buttonLightTwo.onOff = true ; else buttonLightTwo.onOff = false ;
  buttonLightTwo.IDmidi = (int)infoButton[rank].y ; 
  rank++ ;
  if(infoButton[rank].z == 1.0) buttonLightTwoAction.onOff = true ; else buttonLightTwoAction.onOff = false ;
  buttonLightTwoAction.IDmidi = (int)infoButton[rank].y ; 
  rank++ ;
  //SOUND
  if(infoButton[rank].z == 1.0) Bbeat.onOff = true ; else Bbeat.onOff = false ;
  Bbeat.IDmidi = (int)infoButton[rank].y ;
 rank++ ; 
  if(infoButton[rank].z == 1.0) Bkick.onOff = true ; else Bkick.onOff = false ;
  Bkick.IDmidi = (int)infoButton[rank].y ; 
  rank++ ;
  if(infoButton[rank].z == 1.0) Bsnare.onOff = true ; else Bsnare.onOff = false ;
  Bsnare.IDmidi = (int)infoButton[rank].y ;
  rank++ ;
  if(infoButton[rank].z == 1.0) Bhat.onOff = true ; else Bhat.onOff = false ;
  Bhat.IDmidi = (int)infoButton[rank].y ; 
  rank++ ;
  
  //
  rank--  ;
  //
  
  int whichGroup = 1 ;
  int buttonRank ;
  for( int i = 1 ; i <= numGroup[whichGroup] ; i++ ) {
    for (int j = 1 ; j <= BUTTON_BY_OBJECT ; j++) {
      rank++ ;
      buttonRank = (int)infoButton[rank].x ;
      if(infoButton[rank].z == 1.0 && buttonRank == (i*10)+j) button_G1[buttonRank].onOff = true ; else button_G1[buttonRank].onOff = false ; 
      button_G1[buttonRank].IDmidi = (int)infoButton[rank].y ; 
    }
  }
  whichGroup = 2 ; 
  for( int i = 1 ; i <= numGroup[whichGroup] ; i++ ) {
    for (int j = 1 ; j <= BUTTON_BY_OBJECT ; j++) {
      rank++ ;
      buttonRank = (int)infoButton[rank].x ;
      if(infoButton[rank].z == 1.0 && buttonRank == (i*10)+j) button_G2[buttonRank].onOff = true ; else button_G2[buttonRank].onOff = false ; 
      button_G2[buttonRank].IDmidi = (int)infoButton[rank].y ; 
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
// END SETTING SAVE
///////////////////











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
  int num = numGroup[1] +numGroup[2] +1 ;
  OFF_in_thumbnail = new PImage[num] ;
  OFF_out_thumbnail = new PImage[num] ;
  ON_in_thumbnail = new PImage[num] ;
  ON_out_thumbnail = new PImage[num] ;
  for(int i=0 ;  i<num ; i++ ) {
    String className = ("0") ;
    if (objectLoadName[i] != null ) className = objectLoadName[i] ;
    OFF_in_thumbnail[i] = loadImage("thumbnail/OFF_in/OFF_in_"+className+".png") ;
    OFF_out_thumbnail[i] = loadImage("thumbnail/OFF_out/OFF_out_"+className+".png") ;
    ON_in_thumbnail[i] = loadImage("thumbnail/ON_in/ON_in_"+className+".png") ;
    ON_out_thumbnail[i] = loadImage("thumbnail/ON_out/ON_out_"+className+".png") ;
  }
}
