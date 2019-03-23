/**
* BOXOLYZER
* 2012-2019
* v 2.0.4
*/

  
class Boxolyzer extends Romanesco {
  ArrayList<Equalyzer> box_list ;
  public Boxolyzer() {
    //from the index_objects.csv
    item_name = "Boxolyzer" ;
    item_author  = "Stan le Punk";
    item_version = "Version 2.0.4";
    item_pack = "Base 2012-2019";

    item_costume = "ellipse/triangle/rect/cross/pentagon/flower 5/flower 7/Star 5/Star 7/Super Star 8/Super Star 12";
    item_mode = "Line/Circle";

    hue_fill_is = true;
    sat_fill_is = true;
    bright_fill_is = true;
    alpha_fill_is = true;
    hue_stroke_is = true;
    sat_stroke_is = true;
    bright_stroke_is  = true;
    alpha_stroke_is = true;
    thickness_is = true;
    size_x_is = true;
    size_y_is = true;
    size_z_is = true;
    //diameter_is = true;
    canvas_x_is = true;
    // canvas_y_is = true;
    // canvas_z_is = true;

    // frequence_is = true;
    // speed_x_is = true;
    // speed_y_is = true;
    // speed_z_is = true;
    // spurt_x_is = true;
    // spurt_y_is = true;
    // spurt_z_is = true;
    dir_x_is = true;
    dir_y_is = true;
    dir_z_is = true;
    // jit_x_is = true;
    // jit_y_is = true;
    // jit_z_is = true;
    // swing_x_is = true;
    // swing_y_is = true;
    // swing_z_is = true;

    quantity_is = true;
    // variety_is = true;
    // life_is = true;
    // flow_is = true;
    // quality_is = true;
    area_is = true;
    // angle_is = true;
    // scope_is = true;
    // scan_is = true;
    // align_is = true;
    // repulsion_is = true;
    // attraction_is = true;
    // density_is = true;
    // influence_is = true;
    // calm_is = true;
    // spectrum_is = true;

    // grid_is = true;
    // viscosity_is = true;
    // diffusion_is = true;
    // power_is = true;
    // mass_is = true;

  }
  boolean new_distribution;
  int num_box_ref;

  //SETUP
  void setup() {
    setting_start_position(ID_item,width/2,height/2,0);
    boitesSetting();
  }
  
  //DRAW
  void draw() {
    //CLASSIC DISPLAY
    int num_box = int(map(get_quantity(),0,1,1,NUM_BANDS));
    if (num_box != num_box_ref) {
      new_distribution = true;
    }
    num_box_ref = num_box;
    vec3 size = get_size().copy();

    // color and thickness
    
    aspect(get_fill(), get_stroke(), get_thickness());
    aspect_is(fill_is(),stroke_is()); 
    //
    distribution(num_box, new_distribution);
    
    // MODE DISPLAY with the dropdown menu of controler
    if (get_mode_id() == 0) {
      boxolyzer_line(horizon_is());
    } else if (get_mode_id() == 1) {
      boxolyzer_circle((int)get_canvas_x(),horizon_is());
    }



    // INFO
    info("There is ",num_box," bands analyzed");
    
  }
  
  //ANNEXE VOID
  void distribution(int n, boolean newOne) {
     if (newOne) newDistributionBoite(n) ;
     new_distribution = false ;
   }
  
  boolean orientation ;
  // BOXLIZER CIRCLE
  void boxolyzer_circle(int diam, boolean groundPosition) {
    if( action_is() && key_r ) orientation = !orientation ;
    int surface = diam*diam ; // surface is equale of square surface where is the cirlcke...make sens ?
    int radius = ceil(radius_from_circle_surface(surface)) ;
    
    int n = box_list.size() ;
    float factorSpectrum = 0 ;
    vec3 pos = vec3() ;
    for(int i=0; i < n; i++) {
      if(i < band_length()) {
        factorSpectrum = band [ID_item][i] ;
      }
      float stepAngle = map(i, 0, n, 0, 2*PI) ; 
      float angle =  2*PI - stepAngle;
      if(orientation) {
        pos.set(projection(angle,radius).x +pos.x, projection(angle, radius).y +pos.y, pos.z);
      } else {
        pos.set(projection(angle, radius).x +pos.x, 0, projection(angle, radius).y +pos.z);
      }

      Equalyzer boxolyzer = (Equalyzer) box_list.get(i);
      boxolyzer.set_pos(pos);
      boxolyzer.set_size(get_size());
      boxolyzer.set_dir(get_dir());
      boxolyzer.set_ratio_spectrum(factorSpectrum);
      boxolyzer.set_ratio_costume(get_area());
      boxolyzer.set_costume(get_costume().get_type());
      boxolyzer.show(groundPosition);
    }
  }



  // EQUALIZER CLASSIC
  void boxolyzer_line(boolean groundPosition) {
    vec3 pos = vec3(0,height *.5,0);
    float factorSpectrum = 0;
    int num = box_list.size();
    int canvasFinal = (int)map(get_canvas_x(), width/10, width, width/2,width*3)  ;
    int displacement_symetric = int(width *.5 -canvasFinal *.5) ;
    vec3 displacement = vec3(width/2, height/2, 0) ;
    for(int i = 0 ; i < num ; i++) {
      pos.x = (i *canvasFinal /num) + (canvasFinal /(num *2)) +displacement_symetric ;
      if(i < band_length()) {
        factorSpectrum = get_band(i);
      }
      Equalyzer boxolyzer = (Equalyzer) box_list.get(i) ;
      if(!FULL_RENDERING) {
        factorSpectrum = .5 ;
      }
      boxolyzer.set_pos(sub(pos,displacement));
      boxolyzer.set_size(get_size());
      boxolyzer.set_dir(get_dir());
      boxolyzer.set_ratio_spectrum(factorSpectrum);
      boxolyzer.set_ratio_costume(get_area());
      boxolyzer.set_costume(get_costume().get_type());
      boxolyzer.show(groundPosition);
    }
  }
 
  
  
  // GLOBAL VOID
  void boitesSetting() {
    box_list = new ArrayList<Equalyzer>();
  }
  //
  void newDistributionBoite(int n) {
    box_list.clear() ;
    for (int i = 0 ; i < n ; i++ ) addBoite(i) ;
  }
  //
  void addBoite(int ID) {
    vec3 size = vec3(1) ;
    Equalyzer boxolyzer = new Equalyzer(size, ID) ; 
    box_list.add(boxolyzer) ;
  }
  // END GLOBAL VOID
  private class Equalyzer {
    vec3 size;
    int ID;
    vec3 pos;
    vec3 dir;
    float ratio_spectrum;
    int costume;
    float ratio_costume;

    Equalyzer(vec3 size, int ID) {
      this.ID = ID ;
      this.size = size ;
    }

    void set_size(vec3 size) {
      if(this.size == null) {
        this.size = size.copy();
      } else {
        this.size.set(size);
      }
    }

    void set_pos(vec3 pos) {
      if(this.pos == null) {
        this.pos = pos.copy();
      } else {
        this.pos.set(pos);
      }
    }

    void set_dir(vec3 dir) {
      if(this.dir == null) {
        this.dir = dir.copy();
      } else {
        this.dir.set(dir);
      }
    }

    void set_ratio_spectrum(float ratio_spectrum) {
      this.ratio_spectrum = ratio_spectrum;
    }

    void set_costume(int costume) {
      this.costume = costume;
    }

    void set_ratio_costume(float ratio_costume) {
      this.ratio_costume = ratio_costume;
    }
    
    void show(boolean ground_line) {
      size.mult(ratio_spectrum);

      if(ground_line) {
        float horizon = pos.y -(size.z *.5);
        pos.set(pos.x,horizon,pos.z);
      }
      set_ratio_costume_size(map(ratio_costume,width*.1, width*TAU,0,1));
      costume(pos,size,dir,costume);
    }
  }
}
