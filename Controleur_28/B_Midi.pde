// Tab: B_Midi
// MIDI controller version 2.0
import themidibus.*; //Import the library
MidiBus [] myBus; // The MidiBus
int  num_midi_input ;
int which_midi_input = -1 ;
//SETUP
void midi_init() {
  check_midi_input() ;
  open_midi_bus() ;
  select_first_midi_input() ;
}

void midi_update() {
  midi_select() ;
  use_specific_midi_input(which_midi_input) ;

}



// MAIN METHODE
//////////////


// this method catch the first device found
boolean choice_midi_device, choice_midi_default_device ;
String [] name_midi_input ;
String [] ID_midi_input ;

void check_midi_input() {
  name_midi_input = MidiBus.availableInputs() ;
  num_midi_input = name_midi_input.length ;
  ID_midi_input = new String[num_midi_input] ;
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
void controllerChange(int channel, int CC, int value, long timestamp, String bus_name) {
  midi_channel = channel ;
  midi_CC = CC ;
  midi_value = value ;
  midi_bus_name = bus_name ;
  long_timestamp = timestamp ;
}



// END MAIN METHODE
///////////////////





























// ROMANESCO METHODE MIDI
//////////////////////////

void use_specific_midi_input(int ID) {
  if(ID_midi_input != null && ID >= 0) {
    if(ID_midi_input [ID].equals(midi_bus_name)) {
      midi_channel_romanesco = midi_channel ;
      midi_CC_romanesco = midi_CC ;
      midi_value_romanesco = midi_value ;
    }
  }
}



// DISPLAY INFO MIDI INPUT
//////////////////////////
void display_midi_device_available(PVector pos, int spacing) {
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



void display_select_midi_device(PVector pos, int spacing) {
  if(which_midi_input < num_midi_input ) {
    if (which_midi_input >= 0 && (choice_midi_device || choice_midi_default_device)) {
      text("Current midi device is " + name_midi_input [which_midi_input], pos.x, pos.y) ;
      text("If you want choice an other input press “N“ ", pos.x, pos.y + spacing) ;
    }
  } else {
    choice_midi_device = false ;
  }
}



void window_midi_info(PVector pos, int size_x, int spacing) {
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
// END DISPLAY INFO MIDI INPUT
//////////////////////////////






















// ANNEXE don't need MIDI LIBRARIE CODE
boolean init_midi ;

void midi_select() {
  /* 
  Button to activate the midi setting > mapping + choice the midi deveice
  */
   if(selectMidi || !init_midi) {
    //check_midi_input() ;
    open_input_midi(which_midi_input) ;
    init_midi = true ;
  }

  if(selectMidi) {
    
    if(num_midi_input < 1 ) fill(rougeFonce) ; else fill(grisTresFonce) ;
    stroke(jaune) ;
    strokeWeight(1.5) ;
    window_midi_info(pos_midi_info, size_x_window_info_midi, spacing_midi_info) ;
    noStroke() ;

    textFont(textUsual_1);  textAlign(LEFT);
    if(num_midi_input < 1 ) fill(blanc) ; else fill(grisClair) ;
    display_select_midi_device(pos_midi_info, spacing_midi_info) ;
    display_midi_device_available(pos_midi_info, spacing_midi_info) ;
  }

  if (state_midi_button == 1) selectMidi = true ; else selectMidi = false ;

}


// OPEN AND CLOSE INPUT MIDI
/////////////////////////////////////////////////////

void open_input_midi(int whichOne) {
  if ((!choice_midi_device || !choice_midi_default_device) &&  whichOne != -1 && whichOne < num_midi_input ) {
    use_specific_midi_input(whichOne) ;
    choice_midi_default_device = true ;
    choice_midi_device = true ;
  }
}

//
void open_new_input_midi() {
  if (which_midi_input >= 0 ) {
    which_midi_input = -1 ;
    choice_midi_device = false ;
  }
}
// END OPEN AND CLOSE INPUT MIDI
////////////////////////////////





void select_midi_device() {
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

void midi_keyPressed() {
  if (!choice_midi_device) select_midi_device() ;
  if (key =='n' && choice_midi_device) open_new_input_midi() ;
}

// END SELECT MIDI DEVICE
/////////////////////////


























// MIDI MANAGER
/////////////////
void midiButtonManager(boolean saveButton) {
  // close loop for load save button
  // see void buttonSetSaveSetting()
  int rank = 0 ;
  midiButton(button_bg, rank++, saveButton) ;
  midiButton(button_curtain, rank++, saveButton) ;
  
  midiButton(button_light_1, rank++, saveButton) ;
  midiButton(button_light_1_action, rank++, saveButton) ;
  midiButton(button_light_2, rank++, saveButton) ;
  midiButton(button_light_2_action, rank++, saveButton) ;
  
  midiButton(button_beat, rank++, saveButton) ;
  midiButton(button_kick, rank++, saveButton) ;
  midiButton(button_snare, rank++, saveButton) ;
  midiButton(button_hat, rank++, saveButton) ;
  
  int whichGroup = 1 ;
  for( int i = 1 ; i <= numGroup[whichGroup ] ; i++ ) {
    rank = 1 ;
    midiButton(button_G1[posRankButton(i,rank)], posRankButton(i,rank), saveButton) ; rank++ ;
    midiButton(button_G1[posRankButton(i,rank)], posRankButton(i,rank), saveButton) ; rank++ ;
    midiButton(button_G1[posRankButton(i,rank)], posRankButton(i,rank), saveButton) ; rank++ ;
    midiButton(button_G1[posRankButton(i,rank)], posRankButton(i,rank), saveButton) ;
  }
  whichGroup = 2 ; 
  for( int i = 1 ; i <= numGroup[whichGroup] ; i++ ) {
    rank = 1 ;
    midiButton(button_G2[posRankButton(i,rank)], posRankButton(i,rank), saveButton) ; rank++ ;
    midiButton(button_G2[posRankButton(i,rank)], posRankButton(i,rank), saveButton) ; rank++ ;
    midiButton(button_G2[posRankButton(i,rank)], posRankButton(i,rank), saveButton) ; rank++ ; 
    midiButton(button_G2[posRankButton(i,rank)], posRankButton(i,rank), saveButton) ;     
  }
}


//
int posRankButton(int pos, int rank) {
  return pos*10 +rank ;
}

//
void midiButton(Button b, int IDbutton, boolean saveButton) {
  setttingMidiButton(b) ;
  updateMidiButton(b) ;
  if(saveButton) setButton(IDbutton, b.IDmidi(), b.onOff) ;
}

//
void setttingMidiButton(Button b) {
  if(selectMidi && b.inside && mousePressed) b.selectIDmidi(midi_CC_romanesco) ;
}

//
void updateMidiButton(Button b) {
   if(midi_value_romanesco == 127 && midi_CC_romanesco == b.IDmidi()) {
    b.onOff = !b.onOff ;
    midi_value_romanesco = 0 ;
  }
}



//SLIDER MIDI SETTING


//give which button is active and check is this button have a same IDmidi that Object
void sliderMidiUpdate(int whichOne) {
  // update info from midi controller
  if (midi_CC_romanesco == slider[whichOne].IDmidi()) slider[whichOne].updateMidi(midi_value_romanesco) ;

  
  if(selectMidi && slider[whichOne].lockedMol()) {
    for(int i = 0 ; i <infoSlider.length ; i++) {
      if(whichOne == (int)infoSlider[i].a) {
        infoSlider[i].b = midi_CC_romanesco  ;
      }
    }
  }
  
  //ID midi from controller midi button setting
  if (selectMidi && slider[whichOne].lockedMol()) slider[whichOne].selectIDmidi(midi_CC_romanesco) ;
  
  //ID midi from save
  if(loadSaveSetting) slider[whichOne].selectIDmidi((int)infoSaveFromRawList(infoSlider, whichOne).b) ;
}
// END MIDI MANAGER
///////////////////
