/**
SOUNDA Rope
for SOUNDA > SOUND-Analyze
v 1.4.2
* Copyleft (c) 2017-2018
* Stan le Punk > http://stanlepunk.xyz/
* @author Stan le Punk
* @see https://github.com/StanLepunK/Sound_rope

* Class Sounda use Minim library
* more information about this library 
* @author Damien Quartz
* @see https://github.com/ddf/Minim
*/



/**
Class Sounda
v 0.0.3
*/
public class Sounda implements Rope_Constants {
  private int analyze_length;
  
  import ddf.minim.*;
  import ddf.minim.analysis.*;
  Minim minim;
  AudioInput input;
  AudioBuffer source_buffer;
  FFT fft;

  public Sounda(int analyze_length) {
    this.analyze_length = analyze_length;
    minim = new Minim(this);
    input = minim.getLineIn(Minim.STEREO, analyze_length);
  }




  public void update() {
    if(spectrum_is) update_spectrum();
    if(tempo_is) update_tempo();
  }
  
  /**
  stop minim
  */
  public void stop() {
    input.close() ;
    minim.stop() ;
  }

  /**
  MISC
  v 0.2.0
  */
  // int target_sound = 1 ;
  
  public float get_right() {
    float sum = 0 ; 
    for(int i = 0 ; i < get_buffer_size() ; i++) {
      sum += get_right(i);
    }
    return sum / get_buffer_size(); 
  }

  public float get_left() {
    float sum = 0 ; 
    for(int i = 0 ; i < get_buffer_size() ; i++) {
      sum += get_left(i);
    }
    return sum / get_buffer_size(); 
  }

  public float get_mix() {
    float sum = 0 ; 
    for(int i = 0 ; i < get_buffer_size() ; i++) {
      sum += get_mix(i);
    }
    return sum / get_buffer_size(); 
  }
  

  public float get_right(int target_sample) {
    if(target_sample < get_buffer_size()) {
       return input.right.get(target_sample);
    } else {
      printErrTempo(60, "method get_right("+target_sample+"): no target match in buffer, instead target 0 is use");
      return input.right.get(0);
    }
    
  }

  public float get_left(int target_sample) {
    if(target_sample < get_buffer_size()) {
      return input.left.get(target_sample); 
    } else {
      printErrTempo(60, "method get_left("+target_sample+"): no target match in buffer, instead target 0 is use");
      return input.left.get(0);
    }
  }

  public float get_mix(int target_sample) {
    if(target_sample < get_buffer_size()) {
      return input.mix.get(target_sample);
    } else {
      printErrTempo(60, "method get_mix("+target_sample+"): no target match in buffer, instead target 0 is use");
      return input.mix.get(0);
    }
  }

  public int get_buffer_size() {
    return analyze_length;
  }


  /**
  time track
  v 1.1.1
  */
  int time_track_elapse ;
  float no_sound_since ;
  float threshold_spectrum_sensibility = .6;
  int time_to_reset_time_track = 20;

  public void set_time_track(float threshold, int time_to_reset) {
    threshold_spectrum_sensibility = threshold;
    time_to_reset_time_track = time_to_reset;
  }

  public float get_time_track() {
    float result = 0;
    if(get_spectrum_sum() < threshold_spectrum_sensibility) {
      no_sound_since += .1;
    } else {
      no_sound_since = 0;
    }

    if(no_sound_since > time_to_reset_time_track) {
      time_track_elapse = 0;
      result = 0 ;
    } else {
      time_track_elapse += millis()%10 ;
      result = time_track_elapse *.01 ;
    }

    result = round(result *10.0f) /10.0f ;
    return result; 
  }


  public boolean sound_is() {
    if(get_time_track() > .2 ) return true ; else return false;
  }


  /**
  set buffer
  */
  void audio_buffer(int canal) {
    switch(canal) {
      case RIGHT :
        source_buffer = input.right ;
        break ;
      case LEFT :
        source_buffer = input.left ;
        break ;
      case 41 :
        source_buffer = input.mix ;
        break ;
      default :
        source_buffer = input.mix ;
    }
  }


  /**
  SPECTRUM
  v 0.0.3
  */
  float[] spectrum  ;
  int spectrum_bands = 0 ;
  float scale_spectrum = .1 ;
  boolean spectrum_is;
  public void set_spectrum(int num, float scale) {
    spectrum_is = true;
    if(num > analyze_length) {
      spectrum_bands = analyze_length ;
    } else {
      spectrum_bands = num ;
    }

    // band_size = analyze_length / spectrum_bands ;
    spectrum = new float [spectrum_bands] ;
    fft = new FFT(input.bufferSize(), input.sampleRate());
    fft.linAverages(spectrum_bands);

    scale_spectrum = scale;
  }

  public void update_spectrum() {
    if(source_buffer == null) {
      println("void spectrum(): there is no AudioBuffer selected, by default AudioBuffer input.mix is used");
      source_buffer = input.mix;
    }
    fft.forward(source_buffer);
    for(int i = 0 ; i < band_num();i++) {
      fft.scaleBand(i,scale_spectrum);
    } 
  }

  public float [] get_spectrum() {
    float [] f = new float[spectrum_bands];
    for(int i = 0 ; i < spectrum_bands ; i++) {
      f[i] = fft.getBand(i);
    }
    return f;
  }


  public float get_spectrum(int band_target){
    if(band_target < band_num()) {
      return fft.getBand(band_target);
    } else return Float.NaN; 
  }

  public int band_num() {
    return spectrum_bands;
  }


  public float get_spectrum_sum() {
    float result = 0 ;
    for (int i = 0 ; i < band_num() ; i++) {
      result += get_spectrum(i);
    }
    return result ;
  }

  public float get_spectrum_average() {
    return get_spectrum_sum() / band_num();
  }


  public float get_spectrum_beat_sum(int beat_target) {
    float result = 0 ;
    for (int i = get_section_in(beat_target) ; i < get_section_out(beat_target) ; i++) {
      result += get_spectrum(i);
    }
    return result ;
  }


  public float get_spectrum_beat_average(int beat_target) {
    return get_spectrum_beat_sum(beat_target) / band_num();
  }

  /**
  SECTION
  */
  // int num_section ;
  Section section_band[];
  public void set_section(iVec2[] in_out) {
    int num_section = in_out.length;
    section_band = new Section[num_section];
    // check the max value of section
    for(int i = 0 ; i < num_section ; i++) {
      if(in_out[i].y > spectrum_bands) {
        in_out[i].y = spectrum_bands;
        in_out[i].x = spectrum_bands -1;
        println("'OUT' of beat is upper of spectrum, the value beat 'y' max analyze is cap to the spectrum, and 'x' to spectrum minus '1") ;
      }
      if(in_out[i].x > spectrum_bands) {
        in_out[i].y = spectrum_bands;
        in_out[i].x = spectrum_bands -1;
        println("'IN' of beat is upper of spectrum, the value beat 'y' max analyze is cap to the spectrum, and 'x' to spectrum minus '1") ;
      }
    }
    for(int i = 0 ; i < num_section ; i++) {
      int length_analyze = in_out[i].y - in_out[i].x ;
      section_band[i] = new Section(in_out[i].x, in_out[i].y);
    }
  }

  // get beat section
  public int get_section(int band_target) {
    int section = -1;
    for(int i = 0 ; i < section_band.length ;i++) {
      if(band_target > section_band[i].in && band_target < section_band[i].out) {
        section = i ;
        break;
      }
    }
    if(section == -1) {
      println("method get_section(): No section match with the target",band_target,"the method return -1");
    }
    return section ;
  }

  public int get_section_in(int section_target) {
    if(section_target < section_band.length) {
      return section_band[section_target].in ;
    } else {
      printErr("method get_section_in(): target",section_target,"not found, method return -1");
      return -1;
    }
  }

  public int get_section_out(int section_target) {
    if(section_target < section_band.length) {
      return section_band[section_target].out;
    } else {
      printErr("method get_section_out(): target",section_target,"not found, method return -1");
      return -1;
    }
  }

  public int section_num() {
    if(section_band != null && section_band.length > 0) {
      return section_band.length ;
    } else {
      printErr("method section_num(): no array beat found method return -1");
      return -1;
    }
  }



  /**
  BEAT 
  v 0.1.1
  */
  /**
  beat method
  v 0.0.5
  */
  boolean beat_advance_is ;
  boolean [][] beat_band_is ;
  /**
  setting
  */
  public void set_beat(float... threshold) {
    iVec2 [] in_out = new iVec2[threshold.length];
    int part = spectrum_bands / in_out.length;
    for(int i = 0 ; i < in_out.length ; i++) {
      in_out[i] = iVec2(i*part,(i+1)*part);
    }
    set_section(in_out);
    int [] id_beat_section = new int [threshold.length];
    for(int i = 0 ; i < id_beat_section.length ; i++) {
      id_beat_section[i]=i;
    }
    set_beat(id_beat_section, threshold);
  }


  public void set_beat(int[] target_beat_section, float... threshold) {
    if(section_band != null) {
      beat_advance_is = true ;
      beat_band_is = new boolean [target_beat_section.length][spectrum_bands];
      // init var
      for(int i = 0 ; i < beat_band_is.length ; i++) {
        if(target_beat_section[i] < section_num()) {
          int target_section = target_beat_section[i];
          section_band[target_section].set_threshold(threshold[i]);

        } else {
          printErr("method set_beat(): int target_beat_section",target_beat_section[i],"is out of the num os section available");
        }
        for(int k = 0 ; k < beat_band_is[0].length ; k++) {
          beat_band_is[i][k] = false;
        }
      }
      // declare which band must be analyze when there is a beat detection
      for(int i = 0 ; i < section_band.length ; i++ ) {
        for(int k = section_band[i].in ; k < section_band[i].out ; k++) {
          beat_band_is[i][k] = true ;
        }
      }
    } else {
      printErr("method set_beat(): there is no section initialized, use method set_section(), before set_beat() advance mode");
    }
    
  }

  // boolean beat is
  public boolean beat_is() {
    boolean beat_is = false ;
    for(int i = 0 ; i < section_num() ; i++) {
      for(int k = 0 ; k < spectrum_bands ; k++ ) {
        if(beat_band_is(i,k)) {
          beat_is = true ; 
          break ;
        }
      }
    }
    return beat_is; 
  }

  public boolean beat_is(int beat_target) {
    boolean beat_is = false ;
    if(beat_target < section_band.length) {
      for(int band_target = section_band[beat_target].in ; band_target < section_band[beat_target].out ; band_target++) {
        if(beat_band_is(beat_target,band_target)) {
          beat_is = true; 
          break ;
        }
      }
    } else {
      printErrTempo(60,"method beat_is(",beat_target,") is out of the range, by default method return false",frameCount); 
    }
    return beat_is;
  }



  // beat band is
  public boolean beat_band_is(int beat_target, int band_target) {
    if(get_spectrum(band_target) > get_beat_threshold(beat_target,band_target)) {
      return true ; 
    } else {
      return false ;
    }
  }

  Section get_beat(int beat_target) {
    return section_band[beat_target];
  }


  // get bet threshold
  public float get_beat_threshold(int section_target, int band_target) {
    float threshold = Float.MAX_VALUE ;
    // check if the target is on the beat range analyze
    if(beat_advance_is && beat_band_is[section_target][band_target]) {
      threshold = section_band[section_target].get_threshold();
    } 
    return threshold;
  }


  public float get_beat_threshold(int section_target) {
    return section_band[section_target].get_threshold();
  }



  /**
  TEMPO
  v 0.4.1
  */
  /**
  master method
  */
  String [] tempo_name = {"silenzio","largo","larghetto","adagio","andante","moderato","allegro","presto","prestissimo"};
  Tempo [] tempo;
  boolean tempo_is;

  public void set_tempo() {
    set_tempo(null);
  }

  public void set_tempo(float... threshold) {
    tempo_is = true;
    if(threshold != null) {
      // printErrTempo(60,"method set_tempo() is not availble at this time try in an other life");
      if(section_num() > 0 && threshold.length <= section_num()) {
        tempo = new Tempo[section_num()];
        for(int i = 0 ; i < section_num() ; i++) {
          tempo[i] = new Tempo(get_beat(i));
          tempo[i].set_threshold(threshold[i]);
        }
      } else {
        printErrTempo(60,"method set_tempo(boolean true) must be used after set_section() method");
      }
    } else {
      tempo = new Tempo[1];
      tempo[0] = new Tempo();
    }
  }


  public int get_tempo() {
    if(tempo.length > 1) {
      int sum = 0 ; 
      for(int i = 0 ; i < tempo.length ; i++) {
        sum += tempo[i].get_tempo();
      }
      return sum / tempo.length;
    } else {
      return tempo[0].get_tempo();
    } 
  }

  public float get_tempo_threshold(int target_tempo) {
    return tempo[target_tempo].get_threshold();
  }

  public int get_tempo(int target_tempo) {
    if(tempo.length > 1 && target_tempo < tempo.length) {
      return tempo[target_tempo].get_tempo();
    } else {
      printErrTempo(60,"method get_tempo(int target_tempo): target_tempo",target_tempo," is out of tempo num, instead the method use the global tempo");
      return tempo[0].get_tempo();
    } 
  }

  public String get_tempo_name() {
    return get_tempo_name(0);
  }

  public String get_tempo_name(int target_tempo) {
    if(tempo[target_tempo].get_tempo() <= 0) return tempo_name[target_tempo];
    else if(tempo[target_tempo].get_tempo() > 0 && tempo[target_tempo].get_tempo() <= 60) return tempo_name[1];
    else if(tempo[target_tempo].get_tempo() > 60 && tempo[target_tempo].get_tempo() <= 66) return tempo_name[2];
    else if(tempo[target_tempo].get_tempo() > 66 && tempo[target_tempo].get_tempo() <= 76) return tempo_name[3];
    else if(tempo[target_tempo].get_tempo() > 76 && tempo[target_tempo].get_tempo() <= 108) return tempo_name[4];
    else if(tempo[target_tempo].get_tempo() > 108 && tempo[target_tempo].get_tempo() <= 120) return tempo_name[5];
    else if(tempo[target_tempo].get_tempo() > 120 && tempo[target_tempo].get_tempo() <= 160) return tempo_name[6];
    else if(tempo[target_tempo].get_tempo() > 160 && tempo[target_tempo].get_tempo() <= 200) return tempo_name[7];
    else return tempo_name[7];
  }

  public void update_tempo() {
    for(int i = 0 ; i < tempo.length ; i++) {
      tempo[i].update();
    }
  }


  /**
  color spectrum
  v 0.1.0
  */
  int [] color_spectrum(int component, int sort) {
    Vec2 range = Vec2(-1) ;
    return color_spectrum(component, sort, range);
  }


  int [] color_spectrum(int component, int sort, Vec2... range) {
    boolean reverse_alpha = true;
    // set range
    boolean range_is = false ;
    Vec2 range_x = null;
    Vec2 range_y = null;
    Vec2 range_z = null;
    Vec2 range_a = null;
    if(range.length == 1 && range[0].equals(-1)) {
      range_is = false ;
    } else {
      range_is = true ;
      if(range.length == 1) {
        range_x = range[0];
        range_y = range[0];
        range_z = range[0];
        range_a = range[0];
      } else if(range.length == 2) {
        range_x = range[0];
        range_y = range[0];
        range_z = range[0];
        range_a = range[1];
      } else if(range.length == 3) {
        range_x = range[0];
        range_y = range[1];
        range_z = range[2];
      } else if(range.length == 4) {
        range_x = range[0];
        range_y = range[1];
        range_z = range[2];
        range_a = range[3];
      } 
    }
    
    // spectrum part
    int x = 0;
    int y = 0;
    int z = 0;
    int a = 0;

    float norm_x = 1.;
    float norm_y = 1.;
    float norm_z = 1.;
    float norm_a = 1.;

    int [] line = new int[floor(band_num()/component)];
    int c = 0;
    int where = 0;
    int offset_0 = 0;
    int offset_1 = 0;
    int offset_2 = 0;
    int offset_3 = 0;

    for(int i = 0 ; i < line.length ; i++) {
      iVec5 sort_colour = sort_colour(i, line.length, component, sort);
      where = sort_colour.a;
      offset_0 = sort_colour.b;
      offset_1 = sort_colour.c;
      offset_2 = sort_colour.d;
      offset_3 = sort_colour.e;

      switch(component) {
        case 1:
        norm_x = get_spectrum(where);
        if(norm_x > 1) norm_x = 1;

        if(range_is) {
          norm_x = map(norm_x, 0,1, range_x.x, range_x.y) ;
        }

        x = int(norm_x *g.colorModeX);
        c = color(x);
        break ;
        //
        case 2:
        norm_x = get_spectrum(where);
        if(norm_x > 1) norm_x = 1;

        if(!reverse_alpha) {
          norm_a = get_spectrum(where +offset_1);
          if(norm_a > 1) norm_a = 1 ;
        } else {
          norm_a = 1 -get_spectrum(where +offset_1);
          if(norm_a < 0) norm_a = 0;
        }
        
        if(range_is) {
          norm_x = map(norm_x, 0,1, range_x.x, range_x.y) ;
          norm_a = map(norm_a, 0,1, range_a.x, range_a.y) ;
        }
        
        x = int(norm_x *g.colorModeX);
        y = int(norm_x *g.colorModeY);
        z = int(norm_x *g.colorModeZ);
        a = int(norm_a *g.colorModeA);
        c = color(x,y,z,a);
        break ;
        //
        case 3:
        norm_x = get_spectrum(where);
        norm_y = get_spectrum(where +offset_1);
        norm_z = get_spectrum(where +offset_2);

        if(norm_x > 1) norm_x = 1;
        if(norm_y > 1) norm_y = 1;
        if(norm_z > 1) norm_z = 1;

        if(range_is) {
          norm_x = map(norm_x, 0,1, range_x.x, range_x.y) ;
          norm_y = map(norm_y, 0,1, range_y.x, range_y.y) ;
          norm_z = map(norm_z, 0,1, range_z.x, range_z.y) ;
        }

        x = int(norm_x *g.colorModeX);
        y = int(norm_y *g.colorModeY);
        z = int(norm_z *g.colorModeZ);
        c = color(x,y,z);
        break ;
        //
        case 4:
        norm_x = get_spectrum(where);
        norm_y = get_spectrum(where +offset_1);
        norm_z = get_spectrum(where +offset_2);

        if(norm_x > 1) norm_x = 1;
        if(norm_y > 1) norm_y = 1;
        if(norm_z > 1) norm_z = 1;

        if(!reverse_alpha) {
          norm_a = get_spectrum(where +offset_3);
          if(norm_a > 1) norm_a = 1 ;
        } else {
          norm_a = 1 -get_spectrum(where +offset_3);
          if(norm_a < 0) norm_a = 0;
        }

        if(range_is) {
          norm_x = map(norm_x, 0,1, range_x.x, range_x.y) ;
          norm_y = map(norm_y, 0,1, range_y.x, range_y.y) ;
          norm_z = map(norm_z, 0,1, range_z.x, range_z.y) ;
          norm_a = map(norm_a, 0,1, range_a.x, range_a.y) ;
        }

        x = int(norm_x *g.colorModeX);
        y = int(norm_y *g.colorModeY);
        z = int(norm_z *g.colorModeZ);
        a = int(norm_a *g.colorModeA);
        c = color(x,y,z,a);
        break ;
        //
        default:
        norm_x = get_spectrum(where);

        if(norm_x > 1) norm_x = 1;

        if(range_is) {
          norm_x = map(norm_x, 0,1, range_x.x, range_x.y) ;
        }
        x = int(norm_x *g.colorModeX);
        c = color(x);
        break ;
      }
      line[i] = c ;
    }
    return line ;
  }

  // constant sorting
  int SORT_HASH = 0;
  int SORT_BLOCK_RGBA = 1;
  int SORT_BLOCK_ARGB = 1;


  iVec5 sort_colour(int i, int line_length, int component, int sort) {
    // iVec5 result = iVec5();
    int w = 0;
    int r = 0;
    int g = 0;
    int b = 0;
    int a = 0;
    if(sort == SORT_HASH) {
      // pixel position
      w = i *component;
      // pixel component
      r = 0;
      g = 1;
      b = 2;
      a = 3;
    } else if(sort == SORT_BLOCK_RGBA) {
      // pixel position
      w = i;
      // pixel component
      r = 0;
      g = line_length;
      b = line_length *2;
      a = line_length *3;
    } else if(sort == SORT_BLOCK_ARGB) {
      // pixel position
      w = i;
      // pixel component
      a = 0;
      r = line_length;
      g = line_length *2;
      b = line_length *3;
    }
    return iVec5(w,r,g,b,a);
  }




  /**
  Private class
  */
  /**
  class Section
  v 0.1.0
  */
  class Section {
    float threshold = 1;
    int in ;
    int out ;
    int [] beat_band;

    public Section() {
      beat_band = new int[get_spectrum().length];
      this.in = 0;
      this.out = beat_band.length;
    }

    public Section(int in, int out) {
      beat_band = new int[out -in +1];
      this.in = in;
      this.out = out;
    }


    public Section(int in, int out, float threshold) {
      beat_band = new int[out -in +1];
      this.in = in;
      this.out = out;
      this.threshold = threshold;
    }

    public boolean beat_is() {
      boolean beat_is = false ;
      int max = out ;
      if(out >= spectrum_bands) {
        max = spectrum_bands -1;
      }

      for(int i = in ; i <= max ; i++) {
        if(get_spectrum(i) > threshold) {
          beat_is = true ;
          break ;
        }
      }
      return beat_is ;
    }
    
    // set
    public void set_threshold(float threshold) {
      this.threshold = threshold;
    }

    public void set_in(int in) {
      beat_band = new int[out -in +1];
      this.in = in;
    }

    public void set_out(int out) {
      beat_band = new int[out -in +1];
      this.out = out;
    }

    // get
    public float get_threshold() {
      return threshold;
    }

    public int get_in() {
      return in ;
    }

    public int get_out() {
      return out ;
    }
  }



  /**
  class Tempo
  v 0.0.1
  */
  class Tempo {
    private int tempo;
    private int progress;
    private int time_tempo_count;
    private int sec_tempo_count;
    private float threshold;
    private int in, out;

    public Tempo () {
      this.in = 0 ;
      this.out = get_spectrum().length;
      set_threshold(4.5);
    }

    public Tempo (Section s) {
      this.in = s.get_in();
      this.out =  s.get_out();
      set_threshold(4.5);
    }


    private void update() {
      if(second() != sec_tempo_count) {
        time_tempo_count++;
        sec_tempo_count = second();
      }
      compute_tempo();
    }

    private int time_elapse = 0;
    private boolean new_tempo_count = true;
    private void compute_tempo() {
      if(sound_is()) {
        int time = 4;
        if(time_tempo_count%time == 0 && new_tempo_count) {
          new_tempo_count = false;
          time_elapse = 0;
          tempo = progress;
          if(tempo < 40) tempo = 40;
          progress = 0;
        } 

        if(time_tempo_count%time != 0) new_tempo_count = true;

        time_elapse++;
        count_tempo();
      } else {
        progress = 0 ;
        tempo = 0 ;
      } 
    }
    
    private void count_tempo() {
      for(int target_band = in ; target_band < out ; target_band++) {
        if(get_spectrum(target_band) > threshold) {
          progress++;
          break;
        }
      }
    }


    public void set_threshold(float threshold) {
      this.threshold = threshold;
    }

    public float get_threshold() {
      return threshold;
    }


    public int get_tempo() {
      return tempo;
    }
  }
}






































































































































































































































