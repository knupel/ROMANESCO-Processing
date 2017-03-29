/**
Sound 
v 1.0.0
*/
// boolean
boolean SOUND_PLAY ;
//GLOBAL PARAMETER Minim
Minim minim;
AudioInput input; // music from outside
// spectrum
FFT fft; 
BeatDetect beatEnergy, beatFrequency;
BeatListener bl;
float beatData, kickData, snareData, hatData ;


float minBeat = 1.0 ;
float maxBeat = 10.0  ;
int beatNum, kickNum, snareNum, hatNum ;
//setup


//volume
int right_volume_info = 0 ;
int left_volume_info = 0 ;




//////////////
// SOUND SETUP
void sound_setup() {
  //Sound
  minim = new Minim(this);
  //sound from outside
  minim.debugOn();
  input = minim.getLineIn(Minim.STEREO, 512);
  
  spectrumSetup(NUM_BANDS) ;
  beatSetup() ;
}






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
int time_track_elapse  ;
void time_track() {
  if(getTimeTrack() > .2 ) SOUND_PLAY = true ; else SOUND_PLAY = false ;
}
//RETURN
float getTimeTrack() {
  float t ; 
  time_track_elapse += millis() % 10 ;
  t = time_track_elapse *.01 ;
  if ( getTotalSpectrum(NUM_BANDS) < 0.1 ) time_track_elapse = 0 ;
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