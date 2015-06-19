//GLOBAL
//////////////////////////////MINIM///////////////////////////////////
//GLOBAL PARAMETER Minim
Minim minim;
AudioInput input; // music from outside
// spectrum
FFT fft; 

//beat
BeatDetect beatEnergy, beatFrequency;
BeatListener bl;


float beatData, kickData, snareData, hatData ;
float minBeat = 1.0 ;
float maxBeat = 10.0  ;

//volume
int right_volume_info = 0 ;
int left_volume_info = 0 ;


//////////////
// SOUND SETUP
void soundSetup() {
  //Sound
  minim = new Minim(this);
  //sound from outside
  minim.debugOn();
  input = minim.getLineIn(Minim.STEREO, 512);
  
  spectrumSetup(NUM_BANDS) ;
  beatSetup() ;
}
// END SOUND SETUP
//////////////////




/////////////
// SOUND DRAW
void soundDraw() {
  spectrum(input.mix, NUM_BANDS) ;
  beatEnergy.detect(input.mix);
  initTempo() ;
  soundRomanesco() ;
  right_volume_info = int(input.right.get(1)  *100) ; 
  left_volume_info = int(input.left.get(1)  *100) ;
}
// END SOUND DRAW
/////////////////






//specific stuff from romanesco
//////////////////////////////
void soundRomanesco() {
  int sound = 1 ;
    
  float volumeControleurG = map(valueSlider[0][4], 0,MAX_VALUE_SLIDER, 0, 1.3 ) ;
  left[0] = map(input.left.get(sound),  -0.07,0.1,  0, volumeControleurG);
  
  float volumeControleurD = map(valueSlider[0][5], 0,MAX_VALUE_SLIDER, 0, 1.3 ) ;
  right[0] = map(input.right.get(sound),  -0.07,0.1,  0, volumeControleurD);
  
  float volumeControleurM = map(( (valueSlider[0][4] + valueSlider[0][5]) *.5), 0,MAX_VALUE_SLIDER, 0, 1.3 ) ;
  mix[0] = map(input.mix.get(sound),  -0.07,0.1,  0, volumeControleurM);
  
  //volume
  if(left[0] < 0 ) left[0] = 0 ;
  if(left[0] > 1 ) left[0] = 1.0 ; 
  if(right[0] < 0 ) right[0] = 0 ;
  if(right[0] > 1 ) right[0] = 1.0 ; 
  if(mix[0] < 0 ) mix[0] = 0 ;
  if(mix[0] > 1 ) mix[0] = 1.0 ;
  
  //Beat
  beat[0] = getBeat(onOffBeat) ;
  kick[0] = getKick(onOffKick) ;
  snare[0] = getSnare(onOffSnare) ;
  hat[0] = getHat(onOffHat) ;
  
  
  //spectrum
  for ( int i = 0 ; i < NUM_BANDS ; i++ ) {
    band[0][i] = bandSprectrum[i] ;
  }
  
  //tempo
  tempo[0] = getTempoRef() ;
  tempoKick[0] = getTempoKickRef() ;
  tempoSnare[0] = getTempoSnareRef() ;
  tempoHat[0] = getTempoHatRef() ;
}
  



//////
//BEAT
//GLOBAL
int beatNum, kickNum, snareNum, hatNum ;
//setup
void beatSetup() {
  //Beat Frequency
  beatFrequency = new BeatDetect(input.bufferSize(), input.sampleRate());
  beatFrequency.setSensitivity(300);
  kickData = snareData = hatData = minBeat; 
  bl = new BeatListener(beatFrequency, input); 
  
  //Beat energy
  beatEnergy = new BeatDetect();
  beatData = 1.0 ;
}
//RETURN
//BEAT QUANTITY
int getBeatNum() {
  if ( beatEnergy.isOnset() ) beatNum += 1 ; else if (  getTotalSpectrum(NUM_BANDS) < 0.03 ) beatNum = 0 ;
  return beatNum ;
}
int getKickNum() {
  if ( beatFrequency.isKick()  ) kickNum += 1 ; else if (  getTotalSpectrum(NUM_BANDS) < 0.03 ) kickNum = 0 ;
  return kickNum ;
}
int getSnareNum() {
  if ( beatFrequency.isSnare()  ) snareNum += 1 ; else if (  getTotalSpectrum(NUM_BANDS) < 0.03 ) snareNum = 0 ;
  return snareNum ;
}
int getHatNum() {
  if ( beatFrequency.isHat()  ) hatNum += 1 ; else if (  getTotalSpectrum(NUM_BANDS) < 0.03 ) hatNum = 0 ;
  return hatNum ;
}

//RESULT
float getBeat(boolean beat) {
  if (beat) {
    if ( beatEnergy.isOnset() ) beatData = maxBeat;
    beatData *= 0.95;
    if ( beatData < minBeat ) beatData = minBeat;
  } else beatData = 1.0 ;
  
  return beatData ;
}

float getKick(boolean kick) {
  if (kick) {
    if ( beatFrequency.isKick() )  kickData = maxBeat;
    kickData = constrain(kickData * 0.95, minBeat, maxBeat);
  } else kickData = 1.0 ;
  //
  return kickData ;
}

float getSnare(boolean snare) {
  if (snare) {
    if ( beatFrequency.isSnare() )  snareData = maxBeat;
    snareData = constrain(snareData * 0.95, minBeat, maxBeat);
  } else snareData = 1.0 ;
  //
  return snareData ;
}

float getHat(boolean hat) {
  if (hat) {
    if ( beatFrequency.isHat() )  hatData = maxBeat;
    hatData = constrain(hatData * 0.95, minBeat, maxBeat);
  } else hatData = 1.0 ;
  //
  return hatData ;
}
//END BEAT
/////////







///////
//TEMPO
float tempoMin = 0.01 ;
float tempoMax = 1.0 ;
int maxSpecific = 1 ;

// float tempoBeat = 0.005 ;
float mesure ; 
boolean refresh = false ;

//Direct Specific Analyze
//GLOBAL

float tempoBeatRef = 1 ;
float tempoKickRef = 1 ; 
float tempoSnareRef = 1 ; 
float tempoHatRef = 1 ; // for Beat, Kick, Snare, Hat
float tempoB, tempoK,  tempoS,  tempoH  ;
float tempoBeatAdd  = 0.005 ;
float tempoKickAdd  = 0.005 ;
float tempoSnareAdd = 0.005 ;
float tempoHatAdd   = 0.005 ;
//RETURN



//INITIALIZATION

void initTempo() {
  // this weird float who's not used must be here, we must work around !
  float init = getTempoBeat() + getTempoKick()  + getTempoHat() + getTempoSnare() ;
}


//return global tempo
float getTempoRef() {
  // I remove the snare because is very bad information and slow down the the speed
  float tempoRef = 1 - (getTempoBeatRef() + getTempoKickRef()  + getTempoHatRef() ) *.33 ;
  return tempoRef ;
}
//get tempo
float getTempo() {
  // I remove the snare because is very bad information and slow down the the speed
  float tempo = (getTempoBeat() + getTempoKick()  + getTempoHat() ) *.33 ;
  return tempo ;
}
// return direct BEAT
float getTempoBeat() {
  if ( beatEnergy.isOnset()  ) {
    if( tempoB != 0 ) tempoBeatRef = tempoB ;
    tempoB = 0 ; 
  } else {
    tempoB += tempoBeatAdd  ;
  }
  return tempoB ;
}
float getTempoBeatRef() {
  if (tempoBeatRef > maxSpecific || getTotalSpectrum(NUM_BANDS) < 0.03  ) tempoBeatRef = maxSpecific  ; 
  return  tempoBeatRef ;
}


// return direct KICK
float getTempoKick() {
  if ( beatFrequency.isKick()  ) {
    if( tempoK != 0 ) tempoKickRef = tempoK ;
    tempoK = 0 ; 
  } else {
    tempoK += tempoKickAdd  ;
  }
  return tempoK ;
}
float getTempoKickRef() {
  if (tempoKickRef > maxSpecific || getTotalSpectrum(NUM_BANDS) < 0.03  ) tempoKickRef = maxSpecific  ; 
  return  tempoKickRef ;
}

// return direct SNARE
float getTempoSnare() {
  if ( beatFrequency.isSnare()  ) {
    if( tempoS != 0 ) tempoSnareRef = tempoS ;
    tempoS = 0 ; 
  } else {
    tempoS += tempoSnareAdd  ;
  }
  return tempoS ;
}
float getTempoSnareRef() {
  if (tempoSnareRef > maxSpecific || getTotalSpectrum(NUM_BANDS) < 0.03  ) tempoSnareRef = maxSpecific  ; 
  return  tempoSnareRef ;
}

// return direct Hat
float getTempoHat() {
  if ( beatFrequency.isHat()  ) {
    if( tempoH != 0 ) tempoHatRef = tempoH ;
    tempoH = 0 ; 
  } else {
    tempoH += tempoHatAdd  ;
  }
  return tempoH ;
}
float getTempoHatRef() {
  if (tempoHatRef > maxSpecific || getTotalSpectrum(NUM_BANDS) < 0.03  ) tempoHatRef = maxSpecific  ; 
  return  tempoHatRef ;
}




//Average Analyze
//GLOBAL
float tempoAverage, tempoAverageRef  ;
float tempoBeatAverage = 0.05 ;
//RETURN
float tempoAverageRef() {
  //regulation du tempo
  if ( mesure == 0 && !refresh ) {
    tempoAverageRef = tempoAverage()  ;
    tempoAverage = 0.01 ;
    refresh = true ;
  }
  if ( mesure != 0 ) refresh = false ;
  
  return tempoAverageRef ;
}


float tempoAverage() {
  mesure = second()%2 ;
  
  if ( beatEnergy.isOnset() || beatFrequency.isKick() || beatFrequency.isSnare() || beatFrequency.isHat()  )  tempoAverage += tempoBeatAverage  ;
  if ( tempoAverage > 1.0 ) tempoAverage = 1.0 ;
  
  //regulation du tempo
  if ( mesure == 0 && !refresh ) {
    tempoAverageRef = tempoAverage  ;
    tempoAverage = 0.01 ;
    refresh = true ;
  }
  
  if ( mesure != 0 ) refresh = false ;
  
  return tempoAverage ;
}

//END TEMPO
//////////


//TIME TRACK
////////////
//GLOBAL
int timeTrack  ;
//RETURN
float getTimeTrack() {
  float t ; 
  timeTrack += millis() % 10 ;
  t = timeTrack *.01 ;
  if ( getTotalSpectrum(NUM_BANDS) < 0.1 ) timeTrack = 0 ;
  return round( t * 10.0f ) / 10.0f; 
}
////////////////
//END TIME TRACK


//SPECTRUM
//////////
//SPECTRUM
//info text band
float [] bandSprectrum  ;
//SETUP
void spectrumSetup(int n) {
  //spectrum
  bandSprectrum = new float [n] ;
  fft = new FFT(input.bufferSize(), input.sampleRate());
  fft.linAverages(n);
}

//DRAW
//just create spectrum
void spectrum(AudioBuffer fftData, int n) {
  fft.forward(fftData) ;
  for(int i = 0; i < n ; i++)
  {
    fft.scaleBand(i, 0.5 ) ;
    bandSprectrum[i] = fft.getBand(i) ;
  }
}

//ANNEXE VOID
float getTotalSpectrum(int NUM_BANDS) {
  float t = 0 ;
  if (bandSprectrum != null ) {
   for ( int i = 0 ; i < NUM_BANDS ; i++ ) {
     //  if(bandSprectrum[i] != null ) t += bandSprectrum[i] ;
      t += bandSprectrum[i] ;
    }
  }
  return t ;
}
//END SPECTRUM
//////////////





//CLASS to use the beat analyze
class BeatListener implements AudioListener {
  private BeatDetect beatFrequency;
  private AudioInput source;
  
  BeatListener(BeatDetect beatFrequency, AudioInput source) {
    this.source = source;
    this.source.addListener(this);
    this.beatFrequency = beatFrequency;
  }
  
  void samples(float[] samps) {
    beatFrequency.detect(source.mix);
  }
  
  void samples(float[] sampsL, float[] sampsR) {
    beatFrequency.detect(source.mix);
  }
}



//END MINIM
void stop() {
  input.close() ;
  minim.stop() ;
  super.stop() ;
}
//////
//END
