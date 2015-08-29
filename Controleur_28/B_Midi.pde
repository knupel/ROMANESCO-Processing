// Tab: B_Midi
//SETUP
void midiSetup() {
  midiIO = MidiIO.getInstance(this);
}

//DRAW
boolean init_midi ;

void midiDraw() {
  /* 
  Button to activate the midi setting > mapping + choice the midi deveice
  */
   if(selectMidi || !init_midi) {
    check_midi_input() ;
    int midi_channel = 0 ;
    open_input_midi(which_midi_input, midi_channel) ;
    init_midi = true ;
  }

  if(selectMidi) {
    
    if(midiIO.numberOfInputDevices() < 1 ) fill(rougeFonce) ; else fill(grisTresFonce) ;
    stroke(jaune) ;
    strokeWeight(1.5) ;
    window_midi_info(pos_midi_info, size_x_window_info_midi, spacing_midi_info) ;
    noStroke() ;

    textFont(textUsual_1);  textAlign(LEFT);
    if(midiIO.numberOfInputDevices() < 1 ) fill(blanc) ; else fill(grisClair) ;
    display_select_midi_device(pos_midi_info, spacing_midi_info) ;
    midi_device_choice(pos_midi_info, spacing_midi_info) ;
  }

  if (EtatMidiButton == 1) selectMidi = true ; else selectMidi = false ;

}









// ANNEXE METHODE
/////////////////

// DISPLAY INFO MIDI INPUT
//////////////////////////
void midi_device_choice(PVector pos, int spacing) {
  int num_line = 0 ;
  if (!choice_midi_device || !choice_midi_default_device) {
    text("Press the ID number to select an input Midi", pos.x, pos.y) ;

    text(midiIO.numberOfInputDevices() + " device(s) available(s)", pos.x, pos.y +spacing) ;
    for (int i = 0; i < midiIO.numberOfInputDevices(); i++) {
      num_line = i +2 ;
      // to make something clean for the reading
      String ID_input = "" +i ;
      if (i > 9 ) ID_input = nf(i, 2) ;
      //
      text("input device "+ID_input+": "+midiIO.getInputDeviceName(i), pos.x, pos.y +(num_line *spacing));
    }
  }
}



void display_select_midi_device(PVector pos, int spacing) {
  if(which_midi_input < midiIO.numberOfInputDevices() ) {
    if (which_midi_input >= 0 && (choice_midi_device || choice_midi_default_device)) {
      text("Current midi device is " + midiIO.getInputDeviceName(which_midi_input), pos.x, pos.y) ;
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
    size_y = int(spacing *2.5 +(spacing *(midiIO.numberOfInputDevices() *1.2))) ;
  } else {
    size_y = int(spacing *2.5) ;
  }
  rect(pos_x, pos_y, size_x, size_y) ;
}
// END DISPLAY INFO MIDI INPUT
//////////////////////////////









// SELECT MIDI DEVICE
/////////////////////
// check midi input
boolean choice_midi_device, choice_midi_default_device ;
int which_midi_input = -1 ;
void check_midi_input() {
  if (midiIO.numberOfInputDevices() > 0 && !choice_midi_device && !choice_midi_default_device) {
    for (int i = 0; i < midiIO.numberOfInputDevices (); i++) {
      which_midi_input = i ;
      break ;
    }
  }
}

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




// OPEN AND CLOSE INPUT MIDI
/////////////////////////////////////////////////////
void open_input_midi(int whichOne, int whichChannel) {
  if ((!choice_midi_device || !choice_midi_default_device) &&  whichOne != -1 && whichOne < midiIO.numberOfInputDevices() ) {
    midiIO.openInput(whichOne, whichChannel);
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






// MIDI MANAGER
/////////////////
void midiButtonManager(boolean saveButton) {
  // close loop for load save button
  // see void buttonSetSaveSetting()
  int rank = 0 ;
  midiButton(buttonBackground, rank++, saveButton) ;
  midiButton(BOcurtain, rank++, saveButton) ;
  
  midiButton(buttonLightOne, rank++, saveButton) ;
  midiButton(buttonLightOneAction, rank++, saveButton) ;
  midiButton(buttonLightTwo, rank++, saveButton) ;
  midiButton(buttonLightTwoAction, rank++, saveButton) ;
  
  midiButton(Bbeat, rank++, saveButton) ;
  midiButton(Bkick, rank++, saveButton) ;
  midiButton(Bsnare, rank++, saveButton) ;
  midiButton(Bhat, rank++, saveButton) ;
  
  int whichGroup = 1 ;
  for( int i = 1 ; i <= numGroup[whichGroup ] ; i++ ) {
    rank = 1 ;
    midiButton(BOf[posRankButton(i,rank)], posRankButton(i,rank), saveButton) ; rank++ ;
    midiButton(BOf[posRankButton(i,rank)], posRankButton(i,rank), saveButton) ; rank++ ;
    midiButton(BOf[posRankButton(i,rank)], posRankButton(i,rank), saveButton) ; rank++ ;
    midiButton(BOf[posRankButton(i,rank)], posRankButton(i,rank), saveButton) ;
  }
  whichGroup = 2 ; 
  for( int i = 1 ; i <= numGroup[whichGroup] ; i++ ) {
    rank = 1 ;
    midiButton(BTf[posRankButton(i,rank)], posRankButton(i,rank), saveButton) ; rank++ ;
    midiButton(BTf[posRankButton(i,rank)], posRankButton(i,rank), saveButton) ; rank++ ;
    midiButton(BTf[posRankButton(i,rank)], posRankButton(i,rank), saveButton) ; rank++ ; 
    midiButton(BTf[posRankButton(i,rank)], posRankButton(i,rank), saveButton) ;     
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
  if(selectMidi && b.inside && mousePressed) b.selectIDmidi(numMidi) ;
}

//
void updateMidiButton(Button b) {
   if(valMidi == 127 && numMidi == b.IDmidi()) {
    b.onOff = !b.onOff ;
    valMidi = 0 ;
  }
}



//SLIDER MIDI SETTING


//give which button is active and check is this button have a same IDmidi that Object
void sliderMidiUpdate(int whichOne) {
  // update info from midi controller
  if (numMidi == slider[whichOne].IDmidi()) slider[whichOne].updateMidi(valMidi) ;

  
  if(selectMidi && slider[whichOne].lockedMol()) {
    for(int i = 0 ; i <infoSlider.length ; i++) {
      if(whichOne == (int)infoSlider[i].a) {
        infoSlider[i].b = numMidi  ;
      }
    }
  }
  
  //ID midi from controller midi button setting
  if (selectMidi && slider[whichOne].lockedMol()) slider[whichOne].selectIDmidi(numMidi) ;
  
  //ID midi from save
  if(loadSaveSetting) slider[whichOne].selectIDmidi((int)infoSaveFromRawList(infoSlider, whichOne).b) ;
}
// END MIDI MANAGER
///////////////////
