boolean switch_image ;
PImage image_1, image_2 ;


void load_data() {
    image_1 = loadImage("purosGirl.jpg") ;
    image_2 = loadImage("no future.jpg") ; 
}


void sound_simulation() {
  // SIMULATED your entry sound
  left [0] = .5 + abs(sin(frameCount *.01) *.5) ;  // @return float value 0 > 1 / 1 when it's the sound is off
  right[0] = .5 + abs(cos(frameCount *.01) *.5) ; // @return float value 0 > 1 / 1 when it's the sound is off
  mix [0] = left [0] + right[0] *.5 ; // @return float value 0 > 1 / 1 when it's the sound is off
  // Beat
  if(frameCount%120 == 0 ) beat[0] = 3 ;  // @return float value 1 > 3 / last value when the sound is off
  if(frameCount%180 == 0 ) kick[0] = 3 ; // @return float value 1 > 3 / last value when the sound is off
  if(frameCount%300 == 0 ) snare[0] = 3 ; // @return float value 1 > 3 / last value when the sound is off
  if(frameCount%420 == 0 ) hat[0] = 3 ;  // @return float value 1 > 3 / last value when the sound is off
  if(beat[0] > 1 ) beat[0] -= .07 ; 
  if(kick[0] > 1 ) kick[0] -= .07 ;
  if(snare[0] > 1 ) snare[0] -= .07 ;
  if(hat[0] > 1 ) hat[0] -= .07 ;
  // Tempo
  tempo[0] = .5 ; // @return float value 0 > 1 / 1 when it's the sound is off
  tempoBeat[0] = .5 ; // @return float value 0 > 1 / 1 when it's the sound is off
  tempoKick[0] = .5 ; // @return float value 0 > 1 / 1 when it's the sound is off
  tempoSnare [0] = .5 ; // @return float value 0 > 1 / 1 when it's the sound is off
  tempoHat[0] = .5 ; // @return float value 0 > 1 / 1 when it's the sound is off
  // Spectrum
  for(int i = 0 ; i < NUM_BANDS ; i++) {
    band [0][i] = noise(i) *abs(sin(frameCount)*32) ; ;
    // println("spectrum: "; i,band [0][i]) ;
  }
}

void update_var_object(int IDobj) {
  apply_value_slider_CP5_on_value_Romanesco(IDobj) ;
  // YOUR SOURCE 
  /*
  image, text...
  */
  
 //  if(key == 'a' && frameCount%6 == 0) {
  if(switch_image) img[IDobj] = image_2 ; else img[IDobj] = image_1 ;
  
}