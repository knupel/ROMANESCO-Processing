/** 
Core_scene 
v 1.5.0
2013-2017
*/


/**
OPENING
*/
boolean open_controller = false ;
boolean open_prescene = true ;
int count_to_open_controller = 0 ;
int time_int_second_to_open_controller = 12  ; // the scene run and run slow at the beginning like at 15 frame / second.


void opening() {
// open prescene
  if (open_prescene) {
    if (open_prescene) {
      launch(sketchPath("")+"PreScene_"+version+"_preview.app") ; 
      open_prescene = false ; 
      open_controller = true ;
    } 
  }

  // open controller
  if(open_controller) {
    count_to_open_controller += 1 ;
    int time_factor_to_open = 60 ;
    if (open_controller && count_to_open_controller > (time_int_second_to_open_controller *time_factor_to_open) ) { 
      launch(sketchPath("")+"Controleur_"+version+".app") ; 
      open_controller = false ; 
    }
  }
}






/**
We use this void to re-init the temp value of SHORT EVENT from the Préscène, because this one is not refresh at the same framerate than the Scene.
Prescene have a 15 fps and the 60 fps, so the resulte when you press a key on the Prescene, this one is only refresh on the Scène after 4 frames.
*/
void init_value_temp_prescene() {
  // to change the value of the keyboard "a" to "z" to false
  for(int i = 1 ; i < 27 ;i++) {
    if(data_osc_prescene[i].equals("1")) {
      data_osc_prescene[i] = "0" ;
    }
  }
  // to change the value of the special touch of keyboard like ENTER, BACKSPACE to false
  for(int i = 30 ; i < 38 ;i++) {
    if(data_osc_prescene[i].equals("1")) data_osc_prescene[i] = "0" ;
  }
  // to change the value of the special num touch of keyboard from '0' to '9'
  for(int i = 51 ; i < 61 ;i++) {
    if(data_osc_prescene[i].equals("1")) data_osc_prescene[i] = "0" ;
  }
}










/**
* MANAGE DIALOGUE SCENE
*/
void save_dial_scene(String path) {
  Table save_dial = new Table();
  save_dial.addColumn("fx active");
  save_dial.addColumn("fx slider active");
  TableRow table_row = save_dial.addRow();

  // slider fx
  String list_slider = "";
  String list_fx = "";
  if(active_fx != null && active_fx.size() > 0) {  
    for(Integer i : active_fx) {
      int target = i - num_special_fx;
      if(target >= 0) {
        String [] names = get_fx(fx_manager,target).get_name_slider();
        list_fx += get_fx(fx_manager,target).get_name() + "/";
        if(names != null && names.length > 0) {
          for(int k = 0 ; k < names.length ; k++) {
            list_slider += names[k] + "/";    
          }
        }
      }
    }
  }
  table_row.setString("fx active",list_fx);
  table_row.setString("fx slider active",list_slider);
  saveTable(save_dial,path+"/dialogue_from_scene.csv");
}




