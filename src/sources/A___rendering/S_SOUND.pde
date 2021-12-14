/**
SOUND
v 1.4.1
*/
Sounda sounda;
int [] transient_section_id;

void sound_setup() {
  int length_analyze = 512 ;
  sounda = new Sounda(length_analyze);

  float scale_spectrum_sound = .11 ;
  sounda.set_spectrum(NUM_BANDS, scale_spectrum_sound);

  int len = sounda.buffer_size();
  int section_1 = len/8 ;
  int section_2 = len/3 ;
  int section_3 = len - (len/6);
  set_section_analyze(section_1,section_2,section_3);
  set_transient();
  sounda.set_tempo();
}

void sound_draw() {
  // setting
  sounda.audio_buffer(r.MIX);
  update_volume_setting();
  update_section_setting();
  update_transient_setting();
  // update
  sounda.update_spectrum(true);
  transient_romanesco();
  spectrum_romaneco();
  tempo_romanesco();
  
  /*
  println("in out 0",sounda.get_section_in(0),sounda.get_section_out(0));
  println("in out 1",sounda.get_section_in(1),sounda.get_section_out(1));
  println("in out 2",sounda.get_section_in(2),sounda.get_section_out(2));
  println("in out 3",sounda.get_section_in(3),sounda.get_section_out(3));
  */
  
}

















/**
ROMANESCO SOUND DRAW
*/
void tempo_romanesco() {
  tempo_rom[0] = sounda.get_tempo();
  tempo_rom_kick[0] = sounda.get_tempo();
  tempo_rom_snare[0] = sounda.get_tempo();
  tempo_rom_hat[0] = sounda.get_tempo();
}

void spectrum_romaneco() {
  for (int i = 0 ; i < sounda.spectrum_size() ; i++ ) {
    band[0][i] = sounda.get_spectrum(i);
  }
}

void transient_romanesco() {
  int max_transient_value = 10 ;
  float back_factor = .95;
  // transient global
  boolean transient_global_is = false; 
  for(int i = 1 ; i < transient_button_is.length ; i++) {
    if(transient_button_is(i)) {
      transient_global_is = true;
      break;
    }
  }
  if(transient_global_is && sounda.transient_is()) {    
    transient_value[0][0] = max_transient_value;
  } else {
    transient_value[0][0] *= back_factor;
  }

  // give catch value `0` from the lib because here we use `0` for the master transient
  for(int i = 1 ; i < transient_button_is.length ; i++) {
    if(transient_button_is(i) && sounda.transient_is(i-1)) {
      transient_value[i][0] = max_transient_value;   
    } else {
      transient_value[i][0] *= back_factor;
    }
  }
}


boolean transient_is(int index) {
  boolean is = false ;
  if(index > 0 && index < sounda.section_size()) {
    is = sounda.transient_is(index);
  } else if(index == 0) {
    for(int i = 0 ; i < sounda.section_size() ;i++) {
      if(sounda.transient_is(i)) {
        is = sounda.transient_is(i);
        break;
      }
    }
  }
  if(index >= sounda.section_size()) {
    printErr("method transient_is():",index,"is out of sounda.section_size()");
  }
  return is;
}

















/**
UPDATE SETTING SOUND
*/
void update_section_setting() {
  int cut_section_1 = (int)map(value_slider_sound_setting[0],0,360,0,sounda.buffer_size());
  int cut_section_2 = (int)map(value_slider_sound_setting[1],0,360,0,sounda.buffer_size());
  int cut_section_3 = (int)map(value_slider_sound_setting[2],0,360,0,sounda.buffer_size());
  set_section_analyze(cut_section_1,cut_section_2,cut_section_3);
}

void update_transient_setting() {
  vec2 [] transient_threshold = new vec2[4];
  for(int i = 0 ; i < transient_threshold.length ; i++) {
    int index = i*2;
    float threshold_low = map(value_slider_sound_setting[index+3],0,360,4,0);
    float threshold_high = map(value_slider_sound_setting[index+4],0,360,4,0);
    transient_threshold[i] = vec2(threshold_low,threshold_high);
    sounda.set_transient(i,transient_threshold[i]);
  }
}

void update_volume_setting() {
  float vol_left_controller = map(value_slider_sound[0],0,MAX_VALUE_SLIDER,0,1.3);
  left[0] = map(sounda.get_left(),-.07,.1,0,vol_left_controller);
  
  float col_right_controller = map(value_slider_sound[1],0,MAX_VALUE_SLIDER,0,1.3);
  right[0] = map(sounda.get_right(),-.07,.1,0,col_right_controller);
  
  float vol_mix = map(((value_slider_sound[0] +value_slider_sound[1]) *.5),0,MAX_VALUE_SLIDER,0,1.3);
  mix[0] = map(sounda.get_mix(),  -.07,.1,0,vol_mix);
  
  //volume
  if(left[0] < 0 ) left[0] = 0;
  if(left[0] > 1 ) left[0] = 1.; 
  if(right[0] < 0 ) right[0] = 0;
  if(right[0] > 1 ) right[0] = 1.; 
  if(mix[0] < 0 ) mix[0] = 0;
  if(mix[0] > 1 ) mix[0] = 1.;
}













/**
SET
*/
void set_section_analyze(int... section_entry) {
  int len = sounda.buffer_size();
  int num_part = section_entry.length +1;
  ivec2 [] in_out = new ivec2[num_part];
  int part = len/(num_part*2);
  in_out[0] = ivec2(0,section_entry[0]); 
  in_out[1] = ivec2(section_entry[0],section_entry[1]);
  in_out[2] = ivec2(section_entry[1],section_entry[2]);
  in_out[3] = ivec2(section_entry[2],len);
  sounda.set_section(in_out);
}

void set_transient() {
  vec2 [] transient_part_threshold = new vec2[sounda.section_size()];
  transient_part_threshold[0] = vec2(.1, 2.5);
  transient_part_threshold[1] = vec2(.1, 2.5);
  transient_part_threshold[2] = vec2(.1, 2.5);
  transient_part_threshold[3] = vec2(.1, 2.5);

  sounda.init_transient(transient_part_threshold);
  sounda.set_transient_low_pass(20);     
  sounda.set_transient_smooth_slow(3.);
  sounda.set_transient_smooth_fast(21.);
  sounda.set_transient_ratio_log(100,50,40,30); 
  sounda.set_transient_threshold_low(.05,.08,.12,.16);
  sounda.set_transient_threshold_high(.8,.3,.25,.20);
}
















/**
GET
*/
int band_length() {
  return band[0].length;
}

float get_time_track() {
  if(sounda != null) {
    return sounda.get_time_track();
  } else {
    float f = Float.NaN ;
    return f;
  }
}

boolean sound_is() {
  return sounda.sound_is();
}

float get_right(int target_sample) {
  return sounda.get_right(target_sample);
}

float get_left(int target_sample) {
  return sounda.get_left(target_sample);
}

float get_mix(int target_sample) {
  return sounda.get_mix(target_sample);
}


String get_tempo_name() {
  return sounda.get_tempo_name();
} 

int get_tempo() {
  return sounda.get_tempo();
}
