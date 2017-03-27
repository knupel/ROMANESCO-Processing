/**
OSC Prescene 
2014 - 2017
v 1.1.0
*/
NetAddress [] target_scene ;
String [] ID_address_scene ;

//message from controler

//message from pré-Scène
String toScene = ("Message from Prescene to Scene") ;

OscP5 osc_send_scene;
OscP5 osc_receive_controller ;

int port_receive_controller = 10_000 ;
int port_send_scene = 9_100 ;

//SETUP
void OSC_setup() {


  osc_receive_controller = new OscP5(this, port_receive_controller);
  osc_send_scene = new OscP5(this, port_send_scene);


  //send to the Scène


//   int port_mirror = 9_200 ; // may be is not import to have a other port for the miroor ?

  
  //send to the miroir
  if (!TEST_ROMANESCO) {
    String [] addressIP = loadStrings(preference_path+"network/IP_address_mirror.txt") ;
    String join_address = join(addressIP, "") ;
    String [] temp = split(join_address,"/") ;

    int num_valid_address = 0 ;
    for(int i = 0 ; i < temp.length ; i++) {
      if(temp[i].equals("IP_address") || temp[i].equals("")) {
        // nothing happens
      } else {
        num_valid_address ++ ;
      }   
    }
    if (youCanSendToScene) {
      ID_address_scene = new String[num_valid_address] ;
      target_scene = new NetAddress[num_valid_address] ;
     //  targetScene = new NetAddress(sendToScene, port_send_scene);
    }
    

    for(int i = 0 ; i < num_valid_address ; i++) {
      ID_address_scene[i] = temp[i+1] ;
    }

    set_ip_address() ; 
  } 


  // must stop the process to give a time to initialization for the OSC process
  try { 
    Thread.sleep(6000); 
  } 
  catch (InterruptedException e) { 
  }
  println("OSC setup done") ;
}




void set_ip_address() {
  for(int i = 0 ; i < target_scene.length ; i++) {
     target_scene[i] = new NetAddress(ID_address_scene[i], port_send_scene) ;
  }
  // target_scene = new NetAddress(ID_adress_scene,address_scene) ;
}



void oscEvent(OscMessage receive) {
  if(receive.addrPattern().equals("Controller")) {
    catchDataFromController(receive) ;
    splitDataButton() ;
    splitDataSlider() ;
    splitDataLoadSaveController() ;
  }
}


void update_OSC_data_controller() {
  translateDataFromController_buttonGlobal() ;
  translateDataFromController_buttonItem() ;
}





/**
OSC send
v 1.0.1
*/
void OSC_send() {
  OscMessage RomanescoScene = new OscMessage("Prescene");
  booleanLoadSaveScene() ;

  //SEND data to SCENE
  RomanescoScene.add(toScene);
  // send the load path to the scene to also open the save setting in the scene with only one opening window input
  RomanescoScene.add(path_to_load_scene_setting) ;
  // reset the path for the next send, because the Scene check this path, to know if this one is not null,
  // and if this one is not null, the Scene load data.
  path_to_load_scene_setting = ("") ;

  RomanescoScene.add(booleanLoadSave) ;

  //send
  // println(youCanSendToScene, frameCount) ;
  for(int i = 0 ; i < target_scene.length ; i++) {
    println(target_scene[i]) ;
    osc_send_scene.send(RomanescoScene, target_scene[i]);
  }
  
}











/**
OSC load
V 1.0.0
*/
String booleanLoadSave = ("") ;

void booleanLoadSaveScene() {
       // LOAD SAVE SCENE ORDER
  boolean load, save_current, save_new ;

  if (load_SCENE_Setting_GLOBAL || load_Scene_Setting_local) {
    load = true ; 
  } else {
    load = false ;
  }

  if (save_Current_SCENE_Setting_GLOBAL || save_Current_Scene_Setting_local) {
    save_current = true ; 
  } else {
    save_current = false ;
  }

  if (save_New_SCENE_Setting_GLOBAL || save_New_Scene_Setting_local) {
    save_new = true ;
  } else {
    save_new = false ;
  }

  String load_string = String.valueOf(load) ;
  String  saveCurrent_string = String.valueOf(save_current) ;
  String  saveNew_string = String.valueOf(save_new) ;

  // we change to false boolean load and data to false each 1 second to have a time to load and save
  if(frameCount%60 == 0) { 
    load_SCENE_Setting_GLOBAL = save_Current_SCENE_Setting_GLOBAL = save_New_SCENE_Setting_GLOBAL = false ;
    load_Scene_Setting_local = save_Current_Scene_Setting_local = save_New_Scene_Setting_local = false ;
  }

  booleanLoadSave = load_string + "/" +  saveCurrent_string + "/" + saveNew_string ;
}















/**
OSC write
v 1.0.1
*/
String dataPreScene [] = new String [74] ;

void write_osc_keyboard_short_event() {
  if (spaceTouch) dataPreScene [0] = ("1") ; else dataPreScene [0] =("0") ;
  if (aTouch)     dataPreScene [1] = ("1") ; else dataPreScene [1] = ("0") ;
  if (bTouch)     dataPreScene [2] = ("1") ; else dataPreScene [2] = ("0") ;
  if (cTouch)     dataPreScene [3] = ("1") ; else dataPreScene [3] = ("0") ;
  if (dTouch)     dataPreScene [4] = ("1") ; else dataPreScene [4] = ("0") ;
  if (eTouch)     dataPreScene [5] = ("1") ; else dataPreScene [5] = ("0") ;
  if (fTouch)     dataPreScene [6] = ("1") ; else dataPreScene [6] = ("0") ;
  if (gTouch)     dataPreScene [7] = ("1") ; else dataPreScene [7] = ("0") ;
  if (hTouch)     dataPreScene [8] = ("1") ; else dataPreScene [8] = ("0") ;
  if (iTouch)     dataPreScene [9] = ("1") ; else dataPreScene [9] = ("0") ;
  if (jTouch)     dataPreScene [10] = ("1") ; else dataPreScene [10] = ("0") ;
  if (kTouch)     dataPreScene [11] = ("1") ; else dataPreScene [11] = ("0") ;
  if (lTouch)     dataPreScene [12] = ("1") ; else dataPreScene [12] = ("0") ;
  if (mTouch)     dataPreScene [13] = ("1") ; else dataPreScene [13] = ("0") ;
  if (nTouch)     dataPreScene [14] = ("1") ; else dataPreScene [14] = ("0") ;
  if (oTouch)     dataPreScene [15] = ("1") ; else dataPreScene [15] = ("0") ;
  if (pTouch)     dataPreScene [16] = ("1") ; else dataPreScene [16] = ("0") ;
  if (qTouch)     dataPreScene [17] = ("1") ; else dataPreScene [17] = ("0") ;
  if (rTouch)     dataPreScene [18] = ("1") ; else dataPreScene [18] = ("0") ;
  if (sTouch)     dataPreScene [19] = ("1") ; else dataPreScene [19] = ("0") ;
  if (tTouch)     dataPreScene [20] = ("1") ; else dataPreScene [20] = ("0") ;
  if (uTouch)     dataPreScene [21] = ("1") ; else dataPreScene [21] = ("0") ;
  if (vTouch)     dataPreScene [22] = ("1") ; else dataPreScene [22] = ("0") ;
  if (wTouch)     dataPreScene [23] = ("1") ; else dataPreScene [23] = ("0") ;
  if (xTouch)     dataPreScene [24] = ("1") ; else dataPreScene [24] = ("0") ;
  if (yTouch)     dataPreScene [25] = ("1") ; else dataPreScene [25] = ("0") ;
  if (zTouch)     dataPreScene [26] = ("1") ; else dataPreScene [26] = ("0") ;
  //FREE
  dataPreScene [27] = ("") ;
  dataPreScene [28] = ("") ;
  dataPreScene [29] = ("") ;

  // SPECIAL TOUCH
  if (enterTouch)    dataPreScene [30] = ("1") ; else dataPreScene [30] = ("0") ;
  if (deleteTouch)    dataPreScene [31] = ("1") ; else dataPreScene [31] = ("0") ;
  if (backspaceTouch) dataPreScene [32] = ("1") ; else dataPreScene [32] = ("0") ;
  if (upTouch) dataPreScene [33] = ("1") ; else dataPreScene [33] = ("0") ;
  if (downTouch) dataPreScene [34] = ("1") ; else dataPreScene [34] = ("0") ;
  if (rightTouch) dataPreScene [35] = ("1") ; else dataPreScene [35] = ("0") ;
  if (leftTouch) dataPreScene [36] = ("1") ; else dataPreScene [36] = ("0") ;
  if (ctrlTouch) dataPreScene [37] = ("1") ; else dataPreScene [37] = ("0") ;
  
  dataPreScene [38] = ("") ;
  dataPreScene [39] = ("") ;
  /*
  from 40
  to 50
  it's other event method
  */


  if (touch1)     dataPreScene [51] = ("1") ; else dataPreScene [51] = ("0") ;
  if (touch2)     dataPreScene [52] = ("1") ; else dataPreScene [52] = ("0") ;
  if (touch3)     dataPreScene [53] = ("1") ; else dataPreScene [53] = ("0") ;
  if (touch4)     dataPreScene [54] = ("1") ; else dataPreScene [54] = ("0") ;
  if (touch5)     dataPreScene [55] = ("1") ; else dataPreScene [55] = ("0") ;
  if (touch6)     dataPreScene [56] = ("1") ; else dataPreScene [56] = ("0") ;
  if (touch7)     dataPreScene [57] = ("1") ; else dataPreScene [57] = ("0") ;
  if (touch8)     dataPreScene [58] = ("1") ; else dataPreScene [58] = ("0") ;
  if (touch9)     dataPreScene [59] = ("1") ; else dataPreScene [59] = ("0") ;
  if (touch0)     dataPreScene [60] = ("1") ; else dataPreScene [60] = ("0") ;

  /*
  from 61
  to 73
  it's other event method
  */
}

//
void write_osc_other_event(){
  // MOUSE
  dataPreScene[40] = float_to_String_3(pen[0].x) ; 
  dataPreScene[41] = float_to_String_3(pen[0].y) ; 
  dataPreScene[42] = float_to_String_1(pen[0].z) ; 
  dataPreScene[43] = float_to_String_3(norm(mouse[0].x, 0, width)) ; 
  dataPreScene[44] = float_to_String_3(norm(mouse[0].y,0,height)) ;
  dataPreScene[45] = float_to_String_3(norm(mouse[0].z,-depth,depth)) ;

  if (clickShortLeft[0]) dataPreScene [46] = ("1") ; else dataPreScene [46] = ("0") ;
  if (clickShortRight[0]) dataPreScene [47] = ("1") ; else dataPreScene [47] = ("0") ;
  if (clickLongLeft[0]) dataPreScene [48] = ("1") ; else dataPreScene [48] = ("0") ;
  if (clickLongRight[0]) dataPreScene [49] = ("1") ; else dataPreScene [49] = ("0") ;
  dataPreScene[50] = int_to_String(wheel[0]) ;


  //longtouch
  if (cLongTouch) dataPreScene [61] = ("1") ; else dataPreScene [61] = ("0") ;
  if (lLongTouch) dataPreScene [62] = ("1") ; else dataPreScene [62] = ("0") ;
  if (nLongTouch) dataPreScene [63] = ("1") ; else dataPreScene [63] = ("0") ;
  if (vLongTouch) dataPreScene [64] = ("1") ; else dataPreScene [64] = ("0") ;

  if (shiftLongTouch) dataPreScene [65] = ("1") ; else dataPreScene [65] = ("0") ;

  // FREE
  dataPreScene [66] = ("") ;
  dataPreScene [67] = ("") ;
  dataPreScene [68] = ("") ;
  dataPreScene [69] = ("") ;

  // ORDER
  if (ORDER_ONE) dataPreScene [70] = ("1") ; else dataPreScene [70] = ("0") ;
  if (ORDER_TWO) dataPreScene [71] = ("1") ; else dataPreScene [71] = ("0") ;
  if (ORDER_THREE) dataPreScene [72] = ("1") ; else dataPreScene [72] = ("0") ;
  if (LEAPMOTION_DETECTED) dataPreScene [73] = ("1") ; else dataPreScene [73] = ("0") ;
}


void join_osc_data() {
  toScene = join(dataPreScene, "/") ;
}


