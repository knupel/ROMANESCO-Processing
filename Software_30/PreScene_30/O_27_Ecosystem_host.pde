/**
Ecosysteme || 2016 || 0.1.0
*/
class Ecosystem_DNA extends Romanesco {
	public Ecosystem_DNA() {
		RPE_name = "Eco DNA" ;
		ID_item = 27 ;
		ID_group = 1 ;
		RPE_author  = "Stan le Punk";
		RPE_version = "Version 0.1.0";
		RPE_pack = "Ecosystem" ;
		RPE_mode = "Point/Ellipse/Triangle/Rect/Cross/ABC" ; // separate the differentes mode by "/"
		RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Stroke hue,Stroke sat,Stroke bright,Stroke alpha,Thickness,Size X,Size Y,Size Z,Canvas X,Canvas Y,Canvas Z,Speed X,Direction X,Quantity,Density,Spectrum" ;
	}

  Vec3 pos, canvas, radius, size ;
  int min_host = 5 ;
  int max_host = 1000 ;

  void setup() {
    // here we cannot use the setting pos, because it's too much ling with the item 26 !!!
    setting_start_position(ID_item, 0,0,0) ;
    load_nucleotide_table("preferences/ecosystem/code.csv") ;

    canvas = Vec3(canvas_x_item[ID_item], canvas_y_item[ID_item], canvas_z_item[ID_item]) ;
    size = Vec3(size_x_item[ID_item], size_y_item[ID_item], size_z_item[ID_item]) ;
    pos = Vec3(width/2, height/2, 0) ;
    
    set_host(pos, size, canvas, quantity_item[ID_item]) ;
    init_symbiosis() ;

  }


  boolean rebuilt_host = false ;
	void draw() {
    float speed_rotation_host = speed_x_item[ID_item] *speed_x_item[ID_item];
    int direction_host = 1 ;
    boolean motion_bool_host = true ;

    float radius_x = canvas_x_item[ID_item] *allBeats(ID_item) ;
    canvas.set(radius_x, canvas_y_item[ID_item], canvas_z_item[ID_item]) ;
    radius.set(canvas) ;
    
    size.set(size_x_item[ID_item], size_y_item[ID_item], size_z_item[ID_item]) ;

    if(reverse[ID_item]) direction_host = 1 ; else direction_host = -1 ;
    if(motion[ID_item]) motion_bool_host = true ; else motion_bool_host = false ;
    if(birth[ID_item]) {
      set_host(pos, size, canvas, quantity_item[ID_item]) ;
      init_symbiosis() ;
    	birth[ID_item] = false ;
    }


    if(costume[ID_item] == TEXT_ROPE ) textFont(font[ID_item]) ;

    select_costume(ID_item, RPE_name) ;

    float direction = map(dir_x_item[ID_item],0,360, -PI, PI) ;

    show_host(size, canvas, radius, direction, speed_rotation_host, direction_host, costume[ID_item], fill_item[ID_item], stroke_item[ID_item], thickness_item[ID_item], spectrum_item[ID_item], motion_bool_host, info_agent) ;
		
	}

	boolean info_agent = false ;
	boolean decorum_display = true ;
	boolean agent_display = true ;
	boolean bg_refresh = true ;
	int direction_dna = 1 ;
	float speed_rotation_dna = .01 ;




  void set_host(Vec3 pos, Vec3 size, Vec3 canvas, float ratio_quantity) {
    radius = Vec3(canvas) ;
    int num = num_host(min_host, max_host, ratio_quantity) ;
    create_host(num, density_item[ID_item], pos, size, canvas, radius) ; 
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
void create_host(int num, float density, Vec3 pos, Vec3 size, Vec3 canvas, Vec3 radius) {
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

void create_dna(int num_helix, int num, int by_revolution, Vec3 pos, Vec3 size, int height_dna, int radius_dna) {
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

void show_host(Vec3 size, Vec3 canvas, Vec3 radius, float direction, float speed_rotation_host, int direction_host, int which_costume, int fill, int stroke, float thickness, float spectrum, boolean rotation_bool_host, boolean info) {
	int height_dna = (int)canvas.y ;
	int radius_dna = (int)radius.x ;
  show_dna(size, height_dna, radius_dna, direction, speed_rotation_host, direction_host, which_costume, fill, stroke, thickness, spectrum, rotation_bool_host, info) ;
}



float rotation_dna = 0 ;
void show_dna(Vec3 size, int height_dna, int radius_dna, float direction, float speed_rotation_dna, int direction_dna, int which_costume, int fill, int stroke, float thickness, float spectrum, boolean rotation_bool_dna, boolean info) {
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
      costume_DNA(strand_DNA, i, size, direction, which_costume, fill, stroke, thickness, spectrum, info) ;
    }
  }
}



void costume_DNA(Helix helix, int target, Vec3 size, float direction, int which_costume, int fill_int, int stroke_int, float thickness, float spectrum, boolean info) {
  Vec3 pos_a = helix.get_nuc_pos(0)[target] ;
  Vec3 pos_b = helix.get_nuc_pos(1)[target] ;

  float angle_a = helix.get_nuc_angle(0)[target]  +direction ;
  float angle_b = helix.get_nuc_angle(1)[target]  +direction ;

  int size_link = 1 ;

  float radius = helix.get_radius().x ;
  float alpha_min = .01 ;
  float alpha_max = .8 ;

  aspect_rope(fill_int, stroke_int, thickness) ;
  line(pos_a, pos_b) ;
  

  Vec4 fill = color_HSB_a(fill_int) ;
  Vec4 stroke = color_HSB_a(stroke_int) ;

  // alpha
  float ratio_a = map(pos_a.z , -radius, radius, 0 +alpha_min, alpha_max) ;
  float alpha_a = g.colorModeA * ratio_a  ;
  float fill_alpha_a = alpha_a * map(fill.w, 0,100,0,1) ;
  float stroke_alpha_a = alpha_a * map(stroke.w, 0,100,0,1) ;


  Vec4 fill_strand_a = Vec4(fill.x, fill.y, fill.z, fill_alpha_a) ;
  Vec4 stroke_strand_a = Vec4(stroke.x, stroke.y, stroke.z, stroke_alpha_a) ;

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
  


  Vec4 fill_strand_b = Vec4(hue_fill, fill.y, fill.z, fill_alpha_b) ;
  Vec4 stroke_strand_b = Vec4(hue_stroke, stroke.y, stroke.z, stroke_alpha_b) ;
  
  



  aspect_rope(fill_strand_a, stroke_strand_a, thickness, which_costume) ;

  if(which_costume == TEXT_ROPE) {
    String nuc_a = "" +helix.get_DNA(0).sequence_a.get(target).nac ;
    costume_rotate_y() ;
    costume_text(nuc_a) ;
  }

  costume_rotate_y() ;
  costume_rope(pos_a, size, angle_a ,which_costume) ;

  


  aspect_rope(fill_strand_b, stroke_strand_b, thickness, which_costume) ;
  
  if(which_costume == TEXT_ROPE) {
    String nuc_b = "" +helix.get_DNA(0).sequence_b.get(target).nac ;
    costume_rotate_y() ;
    costume_text(nuc_b) ;
  }

  costume_rotate_y() ;
  costume_rope(pos_b, size, angle_b, which_costume) ;

}





























