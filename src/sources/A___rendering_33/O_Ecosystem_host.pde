/**
Ecosysteme Host 
2016-2018
V 0.1.10
*/
class Ecosystem_DNA extends Romanesco {
	public Ecosystem_DNA() {
		item_name = "Eco DNA" ;
		item_author  = "Stan le Punk";
		item_version = "Version 0.1.9";
		item_pack = "Ecosystem 2016-2018";
    item_costume = "Point/Ellipse/Triangle/Rect/flower/Cross/ABC" ;
		item_mode = "" ; // separate the differentes mode by "/"

	  hue_fill_is = true;
    sat_fill_is = true;
    bright_fill_is = true;
    alpha_fill_is = true;
    hue_stroke_is = true;
    sat_stroke_is = true;
    bright_stroke_is = true;
    alpha_stroke_is = true;
    thickness_is = true;
    size_x_is = true;
    size_y_is = true;
    size_z_is = true;
    // diameter_is = true;
    canvas_x_is = true;
    canvas_y_is = true;
    canvas_z_is = true;

    // frequence_is = true;
    speed_x_is = true;
    // speed_y_is = true;
    // speed_z_is = true;
    // spurt_x_is = true;
    // spurt_y_is = true;
    // spurt_z_is = true;
    dir_x_is = true;
    // dir_y_is = true;
    // dir_z_is = true;
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
    // area_is = true;
    // angle_is = true;
    // scope_is = true;
    // scan_is = true;
    // align_is = true;
    // repulsion_is = true;
    // attraction_is = true;
    density_is = true;
    // influence_is = true;
    // calm_is = true;
    spectrum_is = true;
  }

  vec3 pos, canvas, radius, size ;
  int min_host = 5 ;
  int max_host = 1000 ;
  vec3 ratio_canvas = vec3(.5, 1.5, .5) ;
  float ratio_size = .5 ;

  void setup() {
    // here we cannot use the setting pos, because it's too much ling with the item 26 !!!
    setting_start_position(ID_item, 0,0,0) ;
    load_nucleotide_table(items_path+"ecosystem/code.csv");

    canvas = vec3(get_canvas_x(), get_canvas_y(), get_canvas_z()) ;
    canvas.mult(ratio_canvas) ;
    size = vec3(get_size_x(), get_size_y(), get_size_z()) ;
    size.mult(ratio_size) ;
    pos = vec3(width/2, height/2, 0) ;
    
    set_host(pos, size, canvas, get_quantity()) ;
    init_symbiosis() ;

  }


  boolean rebuilt_host = false ;
	void draw() {
    float speed_rotation_host = get_speed_x() *get_speed_x();
    int direction_host = 1 ;
    boolean motion_bool_host = true ;
    
    /**
    change beat system for better reactivity
    
    */
    float radius_x = get_canvas_x() *all_transient(ID_item) ;
    canvas.set(radius_x, get_canvas_y(), get_canvas_z()) ;
    canvas.mult(ratio_canvas) ;
    radius.set(canvas) ;
    

    size.set(get_size_x(), get_size_y(), get_size_z()) ;
    size.mult(ratio_size) ;

    if(reverse_is()) {
      direction_host = 1; 
    } else { 
      direction_host = -1;
    }

    if(motion_is()) {
      motion_bool_host = true; 
    } else {
      motion_bool_host = false;
    }

    if(birth_is()) {
      set_host(pos, size, canvas, get_quantity()) ;
      init_symbiosis() ;
    	birth_is(false);
    }
    
    boolean_host(fill_is(), stroke_is(), wire_is()) ;

    if(get_costume().get_type() == TEXT_ROPE) {
      textFont(get_font());
    }

    float direction = get_dir_x();

    show_host(size, canvas, radius, direction, speed_rotation_host, direction_host, get_costume(), get_fill(), get_stroke(), get_thickness(), get_spectrum(), motion_bool_host, info_agent) ;
		
	}

	boolean info_agent = false ;
	boolean decorum_display = true ;
	boolean agent_display = true ;
	boolean bg_refresh = true ;
	int direction_dna = 1 ;
	float speed_rotation_dna = .01 ;




  void set_host(vec3 pos, vec3 size, vec3 canvas, float ratio_quantity) {
    radius = vec3(canvas) ;
    int num = num_host(min_host, max_host, ratio_quantity) ;
    create_host(num, get_density(), pos, size, canvas, radius) ; 
  }

  int num_host(int min, int max, float ratio) {
    int num = min ;
    num = int(max *ratio +min) ;
    if(!FULL_RENDERING) num = min ;
    return num ;
  }
}





/**
CREATE
*/
void create_host(int num, float density, vec3 pos, vec3 size, vec3 canvas, vec3 radius) {
  // host
  pos_host(pos) ;
  size_host(size) ;
  canvas_host(canvas) ;
  radius_host(radius) ;

  int height_dna = (int)canvas.y ;
  int radius_dna = (int)radius.x ;
  int num_nucleotide = num ;
  int num_helix = 2 ; 

  init_host_target(num *num_helix) ;
  int by_revolution = 11 + int(density *74) ;

  create_dna(num_helix, num_nucleotide, by_revolution, pos, size, height_dna, radius_dna) ;
}


void init_symbiosis() {
  init_symbiosis_area(strand_DNA.num()) ;
  set_symbiosis_area(strand_DNA.get_nuc_pos()) ;
}


/**
UPDATE SYMBIOSIS
*/
void update_symbiosis() {
  update_symbiosis_area(strand_DNA.get_nuc_pos()) ;
}


void sync_symbiosis(int id_item) {
  sync_symbiosis(FLORA_LIST) ;
}









/**
DNA
*/
Helix strand_DNA ;


void create_dna(int num_helix, int num, int by_revolution, vec3 pos, vec3 size, int height_dna, int radius_dna) {
  int nucleotide = num ;

  int num_strand = num_helix ;

  strand_DNA = new Helix(num_strand, nucleotide, by_revolution) ;
  strand_DNA.set_radius(radius_dna) ;
  strand_DNA.set_height(height_dna) ;
  strand_DNA.set_final_pos(pos) ;
}




/**
SHOW
*/
void show_host(vec3 size, vec3 canvas, vec3 radius, float direction, float speed_rotation_host, int direction_host, Costume costume, int fill, int stroke, float thickness, float spectrum, boolean rotation_bool_host, boolean info) {
	int height_dna = (int)canvas.y ;
	int radius_dna = (int)radius.x ;
  show_dna(size, height_dna, radius_dna, direction, speed_rotation_host, direction_host, costume, fill, stroke, thickness, spectrum, rotation_bool_host, info) ;
}



float rotation_dna = 0 ;
void show_dna(vec3 size, int height_dna, int radius_dna, float direction, float speed_rotation_dna, int direction_dna, Costume costume, int fill, int stroke, float thickness, float spectrum, boolean rotation_bool_dna, boolean info) {
	// show DNA
  if(height_dna > 0 ) {
    if(rotation_bool_dna) {
      rotation_dna += abs(speed_rotation_dna) *direction_dna ;
      // rotation_dna = abs(rotation_dna) *direction_dna ;
      strand_DNA.rotation(rotation_dna) ;
      strand_DNA.set_radius(radius_dna) ;
      strand_DNA.set_height(height_dna) ;
    }  
    for(int i = 0 ; i < strand_DNA.length() ; i++) {
      costume_DNA(strand_DNA, i, size, direction, costume, fill, stroke, thickness, spectrum, info) ;
    }
  }
}


boolean display_fill_is, display_stroke_is ;
boolean link_is ;
void boolean_host(boolean fill_is, boolean stroke_is, boolean link_is) {
  display_fill_is = fill_is ;
  display_stroke_is = stroke_is ;
  this.link_is = link_is ;
}

void costume_DNA(Helix helix, int target, vec3 size, float direction, Costume costume, int fill_int, int stroke_int, float thickness, float spectrum, boolean info) {
  vec3 pos_a = helix.get_nuc_pos(0)[target] ;
  vec3 pos_b = helix.get_nuc_pos(1)[target] ;

  float angle_a = helix.get_nuc_angle(0)[target]  +direction ;
  float angle_b = helix.get_nuc_angle(1)[target]  +direction ;

  int size_link = 1 ;

  float radius = helix.get_radius().x ;
  float alpha_min = .01 ;
  float alpha_max = .8 ;
  
  aspect_is(display_fill_is, display_stroke_is) ;
  aspect(fill_int, stroke_int, thickness) ;
  if(link_is) line(pos_a, pos_b) ;
  

  vec4 fill = to_hsba(fill_int) ;
  vec4 stroke = to_hsba(stroke_int) ;

  // alpha
  float ratio_a = map(pos_a.z , -radius, radius, 0 +alpha_min, alpha_max) ;
  float alpha_a = g.colorModeA * ratio_a  ;
  float fill_alpha_a = alpha_a * map(fill.w, 0,100,0,1) ;
  float stroke_alpha_a = alpha_a * map(stroke.w, 0,100,0,1) ;


  vec4 fill_strand_a = vec4(fill.x, fill.y, fill.z, fill_alpha_a) ;
  vec4 stroke_strand_a = vec4(stroke.x, stroke.y, stroke.z, stroke_alpha_a) ;

  // change for the opposite color
  float hue_fill = fill.x +(spectrum *.5)  ;
  float hue_stroke = stroke.x +(spectrum *.5) ;
  if(hue_fill > g.colorModeX) hue_fill = hue_fill - g.colorModeX ;
  if(hue_stroke > g.colorModeX) hue_stroke = hue_stroke - g.colorModeX ;

  // alpha
  float ratio_b = map(pos_b.z, -radius, radius, 0 +alpha_min, alpha_max) ;
  float alpha_b = g.colorModeA *ratio_b ;
  float fill_alpha_b = alpha_b * map(fill.w, 0,100,0,1) ;
  float stroke_alpha_b = alpha_b * map(stroke.w, 0,100,0,1) ;
  


  vec4 fill_strand_b = vec4(hue_fill, fill.y, fill.z, fill_alpha_b) ;
  vec4 stroke_strand_b = vec4(hue_stroke, stroke.y, stroke.z, stroke_alpha_b) ;
  
  


  aspect_is(display_fill_is, display_stroke_is) ;
  aspect(fill_strand_a, stroke_strand_a, thickness,costume);

  if(costume.get_type() == TEXT_ROPE) {
    String nuc_a = "" +helix.get_DNA(0).sequence_a.get(target).nac ;
    costume_rotate_y() ;
    costume_text(nuc_a) ;
  }

  costume_rotate_y() ;
  costume(pos_a,size,angle_a,costume);

  

  aspect_is(display_fill_is, display_stroke_is) ;
  aspect(fill_strand_b, stroke_strand_b, thickness,costume) ;
  
  if(costume.get_type() == TEXT_ROPE) {
    String nuc_b = "" +helix.get_DNA(0).sequence_b.get(target).nac ;
    costume_rotate_y() ;
    costume_text(nuc_b) ;
  }

  costume_rotate_y() ;
  costume(pos_b, size, angle_b,costume) ;

}





























