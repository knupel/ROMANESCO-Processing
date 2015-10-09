// ROMANESCO FRAMEWORK 4C 15_10_09

/**
key "i" to show the slider
key "SHIFT" + # of your object to display this one
key "c" + mouse or wheel to move your object
*/

// FOR YOU
// Declare your object here
Romanesco yourObj_1 ;
Romanesco yourObj_2 ;
Romanesco yourObj_3 ;
Romanesco orbital ;
Romanesco test ;





void setup() {
  // NOT FOR YOU
  //////////////////////////
  size(500,500, P3D) ; 
  romanescoBasicSetting() ;
  RG.init(this); // init GEOMERATIVE
  load_data() ;
  setValueController() ;
  setController() ;
  camera_setup() ;
  // END NOT FOR YOU
  /////////////////////
  
  
  
  
  // SET YOUR OBJECT
  ///////////////////
  /*
  here we use the void update_var_object to set all the variable of your object
  */
  // object one
  yourObj_1 = new YourObj_1() ;
  update_var_object(yourObj_1.IDobj) ;
  yourObj_1.setting() ;
  // object two
  yourObj_2 = new YourObj_2() ;
  update_var_object(yourObj_2.IDobj) ;
  yourObj_2.setting() ;
  // object three
  yourObj_3 = new YourObj_3() ;
  update_var_object(yourObj_3.IDobj) ;
  yourObj_3.setting() ;
    // object four
  orbital = new Orbital() ;
  update_var_object(orbital.IDobj) ;
  orbital.setting() ;


  // Test
  test = new Test() ;
  update_var_object(test.IDobj) ;
  test.setting() ;
}


// Declare the DRAW for YOUR OBJECT
void display_your_obj() {
  if(showObj[1]) yourObj_1.display() ;
  if(showObj[2]) yourObj_2.display() ;
  if(showObj[3]) yourObj_3.display() ;
  if(showObj[5]) orbital.display() ;

  
  // test.display() ;
}


void update_var_of_your_obj() {
  update_var_object(yourObj_1.IDobj) ;
  update_var_object(yourObj_2.IDobj) ;
  update_var_object(yourObj_3.IDobj) ;
  update_var_object(orbital.IDobj) ;
  
  update_var_object(test.IDobj) ;
}
// END OBJECT
/////////////
/**
After this line there is nothing to do for the object
*/















// NOT FOR YOU
///////////////
void draw() {
  frame.setTitle("Romanesco Framework / FPS : "+round(frameRate));
  background(0) ;
  camera_draw() ;
  updtate_global_var() ;
  updateRomanesco() ;
  sound_simulation() ;
  update_var_of_your_obj() ;
  reset_keyboard() ;
  controller_draw() ;
}