/**
MIDI CONTROL
v 2.0.1
2014-2018
*/
void init_midi() {
  check_midi_input() ;
  open_midi_bus() ;
  select_first_midi_input() ;
}

void update_midi() {
  midi_select(which_midi_input, num_midi_input) ;
  use_specific_midi_input(which_midi_input) ;
}













/**
MAIN METHOD
*/
import themidibus.*; 
MidiBus [] myBus; 
int  num_midi_input;
int which_midi_input = -1;
boolean choice_midi_device, choice_midi_default_device;
String [] name_midi_input;
String [] ID_midi_input;
void check_midi_input() {
  name_midi_input = MidiBus.availableInputs();
  num_midi_input = name_midi_input.length;
  ID_midi_input = new String[num_midi_input];
}


void open_midi_bus() {
  myBus = new MidiBus[num_midi_input] ;
  for(int i = 0 ; i < num_midi_input ; i++) {
    myBus [i] = new MidiBus(this, i, "Java Sound Synthesizer");
    ID_midi_input [i] = myBus [i].getBusName() ;
  }
}

void select_first_midi_input() {
  if (num_midi_input > 0 && !choice_midi_device && !choice_midi_default_device) which_midi_input = 0 ;
}

void close_midi_input_bus() {
  for(int i = 0 ; i < num_midi_input ; i++) {
      myBus [i].close() ;
  }
}



// info from controller midi device
int midi_channel, midi_CC, midi_value ; 
long long_timestamp ;
String midi_bus_name ;
// this void is an upper method like draw, setup, setting...
void controllerChange(int channel, int CC, int value, long timestamp, String bus_name) {
  midi_channel = channel ;
  midi_CC = CC ;
  midi_value = value ;
  midi_bus_name = bus_name ;
  long_timestamp = timestamp ;
}







































// give the midi info to the romanesco variable
void use_specific_midi_input(int ID) {
  if(ID_midi_input != null && ID >= 0 && ID < ID_midi_input.length) {
    if(ID_midi_input[ID].equals(midi_bus_name)) {
      midi_channel_romanesco = midi_channel ;
      midi_CC_romanesco = midi_CC ;
      midi_value_romanesco = midi_value ;
    }
  }
  if(ID >= ID_midi_input.length) {
    printErr("No MIDI devices match with your request");
  }
}


// Give new midi device to Romanesco
void open_input_midi(int which_one, int num) {
  if ((!choice_midi_device || !choice_midi_default_device) &&  which_one != -1 && which_one < num) {
    use_specific_midi_input(which_one) ;
    choice_midi_default_device = true ;
    choice_midi_device = true ;
  }
}

// reset 
void reset_input_midi_device() {
  if (which_midi_input >= 0 ) {
    which_midi_input = -1 ;
    choice_midi_device = false ;
  }
}









// DISPLAY INFO MIDI INPUT
//////////////////////////
void display_midi_device_available(Vec2 pos, int spacing) {
  int num_line = 0 ;
  if (!choice_midi_device || !choice_midi_default_device) {
    text("Press the ID number to select an input Midi", pos.x, pos.y) ;

    text(num_midi_input + " device(s) available(s)", pos.x, pos.y +spacing) ;
    for (int i = 0; i < num_midi_input; i++) {
      num_line = i +2 ;
      // to make something clean for the reading
      String ID_input = "" +i ;
      if (i > 9 ) ID_input = nf(i, 2) ;
      //
      text("input device "+ID_input+": "+name_midi_input [i], pos.x, pos.y +(num_line *spacing));
    }
  }
}



void display_select_midi_device(Vec2 pos, int spacing) {
  if(which_midi_input < num_midi_input ) {
    if (which_midi_input >= 0 && (choice_midi_device || choice_midi_default_device)) {
      text("Current midi device is " + name_midi_input [which_midi_input], pos.x, pos.y) ;
      text("If you want choice an other input press “N“ ", pos.x, pos.y + spacing) ;
    }
  } else {
    choice_midi_device = false ;
  }
}



void window_midi_info(Vec2 pos, int size_x, int spacing) {
  int pos_x = (int)pos.x -(spacing/2) ;
  int pos_y = (int)pos.y -spacing ;
  int size_y = 0 ;
  if (!choice_midi_device || !choice_midi_default_device) {
    size_y = int(spacing *2.5 +(spacing *(num_midi_input *1.2))) ;
  } else {
    size_y = int(spacing *2.5) ;
  }
  rect(pos_x, pos_y, size_x, size_y) ;
}









// ANNEXE don't need MIDI LIBRARIE CODE
boolean init_midi ;
void midi_select(int which_one, int num) {
  if(selectMidi || !init_midi) {
    open_input_midi(which_one, num) ;
    init_midi = true ;
  }

  if(selectMidi) {  
    if(num < 1 ) fill(rougeFonce) ; else fill(grisTresFonce) ;
    stroke(jaune) ;
    strokeWeight(1.5) ;
    window_midi_info(pos_midi_info, size_x_window_info_midi, spacing_midi_info) ;
    noStroke() ;

    textFont(textUsual_1);  textAlign(LEFT);
    if(num < 1 ) fill(blanc) ; else fill(grisClair) ;
    display_select_midi_device(pos_midi_info, spacing_midi_info) ;
    display_midi_device_available(pos_midi_info, spacing_midi_info) ;
  }
  if (button_midi_is == 1) selectMidi = true ; else selectMidi = false ;
}


void select_input_midi_device() {
  if (key == '0') which_midi_input = 0 ;
  if (key == '1') which_midi_input = 1 ;
  if (key == '2') which_midi_input = 2 ;
  if (key == '3') which_midi_input = 3 ;
  if (key == '4') which_midi_input = 4 ;
  if (key == '5') which_midi_input = 5 ;
  if (key == '6') which_midi_input = 6 ;
  if (key == '7') which_midi_input = 7 ;
  if (key == '8') which_midi_input = 8 ;
  if (key == '9') which_midi_input = 9 ;
}

void keypressed_midi() {
  if (!choice_midi_device) select_input_midi_device() ;
  if (key =='n' && choice_midi_device) reset_input_midi_device() ;
}


























/**
MIDI MANAGER
*/
void midi_manager(boolean saveButton) {
  // close loop for load save button
  // see void buttonSetSaveSetting()
  int rank = 0 ;
  midi_button(button_bg, rank++, saveButton,"Button general") ;
  midi_button(button_curtain, rank++, saveButton,"Button general") ;
  
  midi_button(button_light_1, rank++, saveButton,"Button general") ;
  midi_button(button_light_1_action, rank++, saveButton,"Button general") ;
  midi_button(button_light_2, rank++, saveButton,"Button general") ;
  midi_button(button_light_2_action, rank++, saveButton,"Button general") ;
  
  midi_button(button_beat, rank++, saveButton,"Button general") ;
  midi_button(button_kick, rank++, saveButton,"Button general") ;
  midi_button(button_snare, rank++, saveButton,"Button general") ;
  midi_button(button_hat, rank++, saveButton,"Button general") ;
  
  for( int i = 1 ; i <= NUM_ITEM ; i++ ) {
    rank = 0 ;
    midi_button(button_item[posRankButton(i,rank)], posRankButton(i,rank), saveButton,"Button item"); 
    rank++ ;
    midi_button(button_item[posRankButton(i,rank)], posRankButton(i,rank), saveButton,"Button item"); 
    rank++ ;
    midi_button(button_item[posRankButton(i,rank)], posRankButton(i,rank), saveButton,"Button item"); 
    rank++ ;
    midi_button(button_item[posRankButton(i,rank)], posRankButton(i,rank), saveButton,"Button item");
  }
}


//
int posRankButton(int pos, int rank) {
  return pos* BUTTON_ITEM_CONSOLE +rank ;
}

//
void midi_button(Button b, int IDbutton, boolean saveButton, String type) {
  setttingMidiButton(b) ;
  updateMidiButton(b) ;
  if(saveButton) set_data_button(IDbutton, b.get_id_midi(), b.is(), type) ;
}

//
void setttingMidiButton(Button b) {
  if(selectMidi && b.inside && mousePressed) b.set_id_midi(midi_CC_romanesco) ;
}

//
void updateMidiButton(Button b) {
   if(midi_value_romanesco == 127 && midi_CC_romanesco == b.get_id_midi()) {
    b.switch_is();
    midi_value_romanesco = 0 ;
  }
}


//give which button is active and check is this button have a same ID midi that Item
void update_midi_slider(Slider_adjustable sa, Vec5 [] info_slider) {
  // update info from midi controller
  if (midi_CC_romanesco == sa.get_id_midi()) sa.update_midi(midi_value_romanesco) ;

  
  if(selectMidi && sa.molette_used_is()) {
    for(int i = 0 ; i <info_slider.length ; i++) {
      if(sa.get_id() == (int)info_slider[sa.get_id()].a) {
        info_slider[i].b = midi_CC_romanesco;
      }
    }
  }
  
  //ID midi from controller midi button setting
  if (selectMidi && sa.molette_used_is()) sa.set_id_midi(midi_CC_romanesco);
  
  //ID midi from save
  if(LOAD_SETTING) sa.set_id_midi((int)info_save_raw_list(info_slider, sa.get_id()).b);
}


