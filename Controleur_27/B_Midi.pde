//MIDI
//SETUP
void midiSetup() {
  //get an instance of MidiIO
  midiIO = MidiIO.getInstance(this);
  //open the first midi channel of the first device if there Input
  if (midiIO.numberOfInputDevices() > 0 ) midiIO.openInput(0,0);
}
//DRAW
void midiDraw() {
  //save midi setting molette
  if (EtatMidiButton == 1) selectMidi = true ; else selectMidi = false ;
}




// MIDI SETTING


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
// END MIDI
