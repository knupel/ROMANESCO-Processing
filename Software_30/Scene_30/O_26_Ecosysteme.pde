/**
Ecosysteme || 2016 || 0.0.6
*/

interface RULES_ECOSYSTEME {
  float CLOCK = 1.5 ;
  int TIME_TO_BE_CARRION = 10 ;
}




class Ecosysteme extends Romanesco {
  public Ecosysteme() {
    RPE_name = "Ecosysteme" ;
    ID_item = 26 ;
    ID_group = 1 ;
    RPE_author  = "Stan le Punk";
    RPE_version = "Version 0.0.5";
    RPE_pack = "Base" ;
    RPE_mode = "Tetra/Face/Line/Info" ; // separate the differentes mode by "/"
    RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Stroke hue,Stroke sat,Stroke bright,Stroke alpha,Thickness,Size X,Canvas X,Canvas Y,Canvas Z,Speed X,Quantity,Scope,Life" ;
  }







  void setup() {
    setting_start_position(ID_item, width/2, height/2, 0) ;

    load_nucleotide_table("preferences/ecosystem/code.csv") ;
    set_environment() ;
    set_horizon(true) ;
    create_decorum() ; 
  }



  void draw() {
    if(init_ecosystem) {
      ecosystem_setting(biomass) ;
      init_ecosystem = false ;
      first_save = true ;
    }

    update_list() ;
    info_agent(info_agent) ;

    update_flora_position_from_adn() ;
    show_agent() ;
    show_decorum(speed_rotation_dna, direction_dna, info_agent) ;

  }

  boolean info_agent = false ;
  boolean decorum_display = true ;
  boolean agent_display = true ;
  boolean bg_refresh = true ;
  int direction_dna = 1 ;
  float speed_rotation_dna = .01 ;
}





/**
MANAGE ECO-SYSTEM BUILT 0.2.0
*/

/**
ECOS_SYSTEM setting

*/

// LIST
ArrayList<Agent> FLORA_LIST = new ArrayList<Agent>() ;

ArrayList<Agent> BACTERIUM_LIST = new ArrayList<Agent>() ;

ArrayList<Agent> OMNIVORE_CHILD_LIST = new ArrayList<Agent>() ;
ArrayList<Agent> OMNIVORE_FEMALE_LIST = new ArrayList<Agent>() ;
ArrayList<Agent> OMNIVORE_MALE_LIST = new ArrayList<Agent>() ;

ArrayList<Agent> HERBIVORE_CHILD_LIST = new ArrayList<Agent>() ;
ArrayList<Agent> HERBIVORE_FEMALE_LIST = new ArrayList<Agent>() ;
ArrayList<Agent> HERBIVORE_MALE_LIST = new ArrayList<Agent>() ;

ArrayList<Agent> CARNIVORE_CHILD_LIST = new ArrayList<Agent>() ;
ArrayList<Agent> CARNIVORE_FEMALE_LIST = new ArrayList<Agent>() ;
ArrayList<Agent> CARNIVORE_MALE_LIST = new ArrayList<Agent>() ;

ArrayList<Dead> DEAD_LIST = new ArrayList<Dead>() ;

// QUANTITY
int num_flora = 60 ;
int num_herbivore = 100 ; 
int num_omnivore = 0 ; 
int num_carnivore = 10 ; 
int num_bacterium = 10 ;
int num_dead = 0 ;

// Colour
Info_obj style_carnivore, style_herbivore, style_omnivore ;
Info_obj style_flora ;
Info_obj style_dead ;
Info_obj style_bacterium ;


Info_dict flora_carac = new Info_dict() ;
Info_dict herbivore_carac = new Info_dict() ;
Info_dict omnivore_carac = new Info_dict() ;
Info_dict carnivore_carac = new Info_dict() ;
Info_dict bacterium_carac = new Info_dict() ;
Info_dict dead_carac = new Info_dict() ;





// main method
void ecosystem_setting(Biomass b) {
  clear_agent() ;
  set_caracteristic_agent() ;
  b.set_humus(BOX.x *BOX.y *.01) ;
  

  // FLORA
  // int costume = ELLIPSE_ROPE ;
  int costume = VIRUS_3_4_64_ROPE ;
  float thickness = 1. ;

  Vec4 fill_flora = Vec4(color_flora) ;
  Vec4 stroke_flora = Vec4(color_flora) ;

  Vec3 alpha_behavior_flora = Vec3(0, -1, 1) ; // it's like 100% all the time
  if(pos_final_dna != null) {
    alpha_behavior_flora = Vec3(pos_final_dna.z, -.4, .8) ;
  }
  
  style_flora = new Info_obj("Flora Aspect", costume, fill_flora, stroke_flora, thickness, alpha_behavior_flora) ;  

  // HERBIVORE
  costume = POINT_ROPE ;
  Vec4 fill_herbivore = Vec4(color_herbivore) ;
  Vec4 stroke_herbivore = Vec4(color_herbivore) ;
  Vec3 alpha_behavior_herbivore = Vec3(0, -1, 1) ;
  style_herbivore = new Info_obj("Herbivore Aspect", costume, fill_herbivore, stroke_herbivore, thickness, alpha_behavior_herbivore) ;
  
  // OMNIVORE
  costume = PENTAGON_ROPE ;
  Vec4 fill_omnivore = Vec4(150, 100, 80, 100) ;
  Vec4 stroke_omnivore = Vec4(150, 100, 80, 100) ;
  Vec3 alpha_behavior_omnivore = Vec3(0, -1, 1) ;
  style_omnivore = new Info_obj("Omnivore Aspect", costume, fill_omnivore, stroke_omnivore, thickness, alpha_behavior_omnivore) ;

  // CARNIVORE
  costume = HEPTAGON_ROPE ;
  Vec4 fill_carnivore = Vec4(0, 100, 100, 100) ;
  Vec4 stroke_carnivore = Vec4(0, 100, 100, 100) ;
  Vec3 alpha_behavior_carnivore = Vec3(0, -1, 1) ;
  style_carnivore = new Info_obj("Carnivore Aspect", costume, fill_carnivore, stroke_carnivore, thickness, alpha_behavior_carnivore) ;
  
  // BACTERIUM
  costume = ELLIPSE_ROPE ;
  Vec4 fill_bacterium = Vec4(30, 0, 30, 100) ;
  Vec4 stroke_bacterium = Vec4(30, 0, 30, 100) ;
  Vec3 alpha_behavior_bacterium = Vec3(0, -1, 1) ;
  style_bacterium = new Info_obj("Bacterium Aspect", costume, fill_bacterium, stroke_bacterium, thickness, alpha_behavior_bacterium) ;
  

  // DEAD
  costume = CROSS_2_ROPE ;
  Vec4 fill_dead = Vec4(0, 0, 30, 100) ;
  Vec4 stroke_dead = Vec4(0, 0, 30, 100) ;
  Vec3 alpha_behavior_dead = Vec3(0, -1, 1) ;
  style_dead = new Info_obj("Dead Aspect", costume, fill_dead, stroke_dead, thickness, alpha_behavior_dead) ;
  




  // classic radom drop zone
  // build_flora(FLORA_LIST, flora_carac, style_flora, num_flora) ;

  //drop zone from list of point
  build_flora(FLORA_LIST, flora_carac, style_flora, num_flora, drop_zone_flora_list) ;

  build_herbivore(HERBIVORE_CHILD_LIST, herbivore_carac, style_herbivore, num_herbivore) ;
  build_omnivore(OMNIVORE_CHILD_LIST, omnivore_carac, style_omnivore, num_omnivore) ;
  build_carnivore(CARNIVORE_CHILD_LIST, carnivore_carac, style_carnivore, num_carnivore) ;
  build_bacterium(BACTERIUM_LIST, bacterium_carac, style_bacterium, num_bacterium) ;
  build_dead(DEAD_LIST, dead_carac, style_dead, num_dead) ;
}









// control
void control_population_via_frameRate(int level, int num) {
  if(frameRate < level) {
    spawn_carnivore(num) ;
    DEAD_LIST.clear() ;

  } else {
    if (HERBIVORE_CHILD_LIST.size() + HERBIVORE_FEMALE_LIST.size() +HERBIVORE_MALE_LIST.size() < num_herbivore ) {
      CARNIVORE_CHILD_LIST.clear() ;
      CARNIVORE_FEMALE_LIST.clear() ;
      CARNIVORE_MALE_LIST.clear() ;
    }
  }
}













// local
void clear_agent() {
  flora_carac.clear() ;
  herbivore_carac.clear() ;
  carnivore_carac.clear() ;
  omnivore_carac.clear() ;
  bacterium_carac.clear() ;
  dead_carac.clear() ;

  FLORA_LIST.clear() ;

  BACTERIUM_LIST.clear() ;

  HERBIVORE_CHILD_LIST.clear() ;
  HERBIVORE_FEMALE_LIST.clear() ;
  HERBIVORE_MALE_LIST.clear() ;

  OMNIVORE_CHILD_LIST.clear() ;
  OMNIVORE_FEMALE_LIST.clear() ;
  OMNIVORE_MALE_LIST.clear() ;

  CARNIVORE_CHILD_LIST.clear() ;
  CARNIVORE_FEMALE_LIST.clear() ;
  CARNIVORE_MALE_LIST.clear() ;

  DEAD_LIST.clear() ;
}


void set_caracteristic_agent() {
  flora_carac.add("name", "Salad") ;
  flora_carac.add("size", 50) ;
  flora_carac.add("life_expectancy", 1000000 *60) ;
  flora_carac.add("nutrient_quality", 15) ;
  flora_carac.add("speed_growth", 2) ; // size point per cycle
  flora_carac.add("need", .3) ;

  herbivore_carac.add("name", "Sheep") ;
  herbivore_carac.add("size", 20) ;
  herbivore_carac.add("stamina", 100) ;
  herbivore_carac.add("life_expectancy", 1000 *60) ;
  herbivore_carac.add("velocity", 6) ;
  herbivore_carac.add("nutrient_quality", 40) ;
  herbivore_carac.add("sense_range", 4000) ;
  herbivore_carac.add("gourmet", 3.5) ;
  herbivore_carac.add("starving", 4) ;
  herbivore_carac.add("digestion", 2.5) ;
  herbivore_carac.add("sex_appeal", Vec2(40, 5)) ;
  herbivore_carac.add("multiple_pregnancy", 50.) ;

  omnivore_carac.add("name", "Human") ;
  omnivore_carac.add("size", 25) ; // in pixel
  omnivore_carac.add("stamina", 200) ; // point of life
  omnivore_carac.add("life_expectancy", 800 *60) ; // frame of live before die
  omnivore_carac.add("velocity", 8) ; // in pixel
  omnivore_carac.add("nutrient_quality", 20) ; // multi the stamina point to give the calories
  omnivore_carac.add("sense_range", 1000) ; // range in pixel
  omnivore_carac.add("gourmet", 2.5) ; 
  omnivore_carac.add("attack", 5) ; // attack point
  omnivore_carac.add("starving", 3) ; 
  omnivore_carac.add("digestion", 6.5) ; // calorie multiplicator, hight is good.
  omnivore_carac.add("sex_appeal", Vec2(45, 4)) ; // multe the size to give the range in pixel
  omnivore_carac.add("multiple_pregnancy", 10.5) ; // chance to have twin or better in pourcent

  carnivore_carac.add("name", "Alien") ;
  carnivore_carac.add("size", 40) ;
  carnivore_carac.add("stamina", 400) ;
  carnivore_carac.add("life_expectancy", 1200 *60) ;
  carnivore_carac.add("velocity", 10) ;
  carnivore_carac.add("nutrient_quality", 20) ;
  carnivore_carac.add("sense_range", 1200) ;
  carnivore_carac.add("gourmet", 2.5) ;
  carnivore_carac.add("attack", 10) ;
  carnivore_carac.add("starving", 4) ;
  carnivore_carac.add("digestion", 4.5) ;
  carnivore_carac.add("sex_appeal", Vec2(30, 10)) ;
  carnivore_carac.add("multiple_pregnancy", 5.5) ;


  bacterium_carac.add("name", "Gnak Gnak") ;
  bacterium_carac.add("size", 2) ;
  bacterium_carac.add("stamina", 200) ;
  bacterium_carac.add("life_expectancy", 800 *60) ;
  bacterium_carac.add("velocity", 5) ;
  bacterium_carac.add("nutrient_quality", 1) ;
  bacterium_carac.add("sense_range", 500) ;
  bacterium_carac.add("starving", 2) ;
  bacterium_carac.add("digestion", 12.5) ;


  dead_carac.add("name", "UNDEAD") ;
  dead_carac.add("size", 25) ;
  dead_carac.add("nutrient_quality", 40) ;
}



/**
SPAWN carnivore
*/
// annecdotic method
void spawn_carnivore(int num_carnivore) {
    if(CARNIVORE_CHILD_LIST.size() < num_carnivore) {
    int population_target = HERBIVORE_CHILD_LIST.size() + HERBIVORE_FEMALE_LIST.size() +  HERBIVORE_MALE_LIST.size() ;
    if(population_target > num_herbivore && frameCount%(5 *(int)frameRate) == 0 ) {
      int num = ceil(random(num_carnivore)) ;
      build_carnivore(CARNIVORE_CHILD_LIST, carnivore_carac, style_carnivore, num) ;
    }
  }
}










/**
ENVIRONMENT 0.0.3

*/

/**
* Create enviromnent where the ecosystem will be live
*/
void build_environment(Vec2 pos, Vec2 size) {
  Vec3 pos_3D = Vec3(pos.x, pos.y,0) ;
  Vec3 size_3D = Vec3(size.x, size.y,0) ;
  build_environment(pos_3D, size_3D) ;
  // write here to be sure the Environment have a good info
  set_environment(P3D) ;
}

void build_environment(Vec3 pos, Vec3 size) {
  build_box(pos, size) ;

  float left = get_box_pos().x - (get_box_size().x *.5) ;
  float right = get_box_pos().x + (get_box_size().x *.5) ;
  float top = get_box_pos().y - (get_box_size().y *.5) ;
  float bottom = get_box_pos().y + (get_box_size().y *.5) ;
  float front = get_box_pos().z - (get_box_size().z *.5) ;
  float back = get_box_pos().z + (get_box_size().z *.5) ;

  set_box(left, right, top,  bottom, front, back) ;
  set_horizon_depth(int(abs(back) +abs(front))) ;
  set_rebound(false) ;
  set_textSize_info(18) ; 
  // b.set_humus(BOX.x *BOX.y *.01) ;
  // b.humus_max = b.humus = BOX.x *BOX.y *.01 ;
}





/**
SET ENVIRONMENT
*/
Biomass biomass ;
boolean init_ecosystem = true ;

void set_environment() {
  ENVIRONMENT = 3 ;
  biomass = new Biomass() ;
  
  if (ENVIRONMENT == 3) {
    Vec3 pos_box = Vec3(width/2,height/2,0) ;
    int scale_box = 2 ;
    Vec3 size_box = Vec3(width *scale_box,height *scale_box,width *scale_box) ;
    build_environment(pos_box, size_box) ;
  } else {
    Vec2 pos_box = Vec2(width/2,height/2) ;
    Vec2 size_box = Vec2(width,height) ;
    build_environment(pos_box, size_box) ;
  }
}



/**
BIOTOPE 
*/
Vec4 biotope_colour(Biomass b) {
  float normal_humus_level = 1 - b.humus / b.humus_max ;
  float var_colour_ground = 90 *normal_humus_level ;
  return Vec4(40,90, 5 +var_colour_ground,100) ;
}






/**
UPDATE LIST
*/
void update_list() {

  // flora update
  flora_update(FLORA_LIST, biomass) ;
  // bacterium update
  bacterium_update(DEAD_LIST, BACTERIUM_LIST, biomass, INFO_DISPLAY_AGENT) ;
  // dead corpse update
  
  dead_update(DEAD_LIST) ;
 
  // dynamic agent update
  herbivore_update(DEAD_LIST, HERBIVORE_CHILD_LIST, HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST) ;
  omnivore_update(DEAD_LIST, OMNIVORE_CHILD_LIST, OMNIVORE_FEMALE_LIST, OMNIVORE_MALE_LIST) ;
  carnivore_update(DEAD_LIST, CARNIVORE_CHILD_LIST, CARNIVORE_FEMALE_LIST, CARNIVORE_MALE_LIST) ;






  // Eating
  // carnivore eating
  eating_update(CARNIVORE_CHILD_LIST, DEAD_LIST) ;
  eating_update(CARNIVORE_FEMALE_LIST, DEAD_LIST) ;
  eating_update(CARNIVORE_MALE_LIST, DEAD_LIST) ;
  // omnivore eating
  eating_update(OMNIVORE_CHILD_LIST, DEAD_LIST) ;
  eating_update(OMNIVORE_FEMALE_LIST, DEAD_LIST) ;
  eating_update(OMNIVORE_MALE_LIST, DEAD_LIST) ;





  // hunting
  // carnivore hunt herbivorr and omnivore
  hunting_update(CARNIVORE_CHILD_LIST, INFO_DISPLAY_AGENT, HERBIVORE_CHILD_LIST, HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST) ;
  hunting_update(CARNIVORE_FEMALE_LIST, INFO_DISPLAY_AGENT, HERBIVORE_CHILD_LIST, HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST) ;
  hunting_update(CARNIVORE_MALE_LIST, INFO_DISPLAY_AGENT, HERBIVORE_CHILD_LIST, HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST) ;

  hunting_update(CARNIVORE_CHILD_LIST, INFO_DISPLAY_AGENT, OMNIVORE_CHILD_LIST, OMNIVORE_FEMALE_LIST, OMNIVORE_MALE_LIST) ;
  hunting_update(CARNIVORE_FEMALE_LIST, INFO_DISPLAY_AGENT, OMNIVORE_CHILD_LIST, OMNIVORE_FEMALE_LIST, OMNIVORE_MALE_LIST) ;
  hunting_update(CARNIVORE_MALE_LIST, INFO_DISPLAY_AGENT, OMNIVORE_CHILD_LIST, OMNIVORE_FEMALE_LIST, OMNIVORE_MALE_LIST) ;

  // Omnivore hunt carnivore and herbivore
  hunting_update(OMNIVORE_CHILD_LIST, INFO_DISPLAY_AGENT, HERBIVORE_CHILD_LIST, HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST) ;
  hunting_update(OMNIVORE_FEMALE_LIST, INFO_DISPLAY_AGENT, HERBIVORE_CHILD_LIST, HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST) ;
  hunting_update(OMNIVORE_MALE_LIST, INFO_DISPLAY_AGENT, HERBIVORE_CHILD_LIST, HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST) ;

  hunting_update(OMNIVORE_CHILD_LIST, INFO_DISPLAY_AGENT, CARNIVORE_CHILD_LIST, CARNIVORE_FEMALE_LIST, CARNIVORE_MALE_LIST) ;
  hunting_update(OMNIVORE_FEMALE_LIST, INFO_DISPLAY_AGENT, CARNIVORE_CHILD_LIST, CARNIVORE_FEMALE_LIST, CARNIVORE_MALE_LIST) ;
  hunting_update(OMNIVORE_MALE_LIST, INFO_DISPLAY_AGENT, CARNIVORE_CHILD_LIST, CARNIVORE_FEMALE_LIST, CARNIVORE_MALE_LIST) ;


  // picking
  picking_update(HERBIVORE_CHILD_LIST, FLORA_LIST) ;
  picking_update(HERBIVORE_FEMALE_LIST, FLORA_LIST) ;
  picking_update(HERBIVORE_MALE_LIST, FLORA_LIST) ;

  picking_update(OMNIVORE_CHILD_LIST, FLORA_LIST) ;
  picking_update(OMNIVORE_FEMALE_LIST, FLORA_LIST) ;
  picking_update(OMNIVORE_MALE_LIST, FLORA_LIST) ;


  // manage Child
  manage_child(HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST, HERBIVORE_CHILD_LIST) ;
  manage_child(OMNIVORE_FEMALE_LIST, OMNIVORE_MALE_LIST, OMNIVORE_CHILD_LIST) ;
  manage_child(CARNIVORE_FEMALE_LIST, CARNIVORE_MALE_LIST, CARNIVORE_CHILD_LIST) ;
  

  // reproduction
  reproduction_female_herbivore(HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST, HERBIVORE_CHILD_LIST, herbivore_carac, style_herbivore) ;
  reproduction_male(HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST) ;

  reproduction_female_omnivore(OMNIVORE_FEMALE_LIST, OMNIVORE_MALE_LIST, OMNIVORE_CHILD_LIST, omnivore_carac, style_omnivore) ;
  reproduction_male(OMNIVORE_FEMALE_LIST, OMNIVORE_MALE_LIST) ;

  reproduction_female_carnivore(CARNIVORE_FEMALE_LIST, CARNIVORE_MALE_LIST, CARNIVORE_CHILD_LIST, carnivore_carac, style_carnivore) ;
  reproduction_male(CARNIVORE_FEMALE_LIST, CARNIVORE_MALE_LIST) ;
}





/**
  SHOW
*/
void show_agent() {
    // flora show
  flora_show(style_flora, FLORA_LIST) ;
  
  // dead / corpse show 
  show_dead(style_dead, DEAD_LIST) ;
  
  // dynamic agent show
  show_agent_dynamic(style_herbivore, HERBIVORE_CHILD_LIST, HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST) ;
  show_agent_dynamic(style_carnivore, CARNIVORE_CHILD_LIST, CARNIVORE_FEMALE_LIST, CARNIVORE_MALE_LIST) ;
  show_agent_dynamic(style_omnivore, OMNIVORE_CHILD_LIST, OMNIVORE_FEMALE_LIST, OMNIVORE_MALE_LIST) ;

  show_bacterium(biomass, style_bacterium, BACTERIUM_LIST) ;

}















/**
DECORUM

*/
Vec4 color_flora = Vec4(0, 100, 80, 100) ;
Vec4 color_herbivore = Vec4(110, 100, 70, 100) ;

Vec3 color_strand_a = Vec3(30, 10, 80) ;
Vec3 color_strand_b = Vec3(0, 10, 20) ;


boolean new_costume_virus = false ;
void set_virus_costume() {
  Vec4 fill_flora = Vec4(color_flora) ;
  Vec4 stroke_flora = Vec4(color_flora) ;
  float change_hue = random(50) ;
  float change_alpha = random(100) ;
  fill_flora.x += change_hue ;
  stroke_flora.x += change_hue ;
  fill_flora.a -= change_alpha ;
  stroke_flora.a -= change_alpha ;


  int costume = VIRUS_3_4_64_ROPE ;
  int new_costume = floor(random(8)) ;
  if(new_costume == 0 ) {
    costume = VIRUS_3_4_32_ROPE ;
  } else if(new_costume == 1 ) {
    costume = VIRUS_3_4_64_ROPE ;
  } else if(new_costume == 2 ) {
    costume = VIRUS_3_4_128_ROPE ;
  } else if(new_costume == 3 ) {
    costume = VIRUS_2_2_16_ROPE ;
  } else if(new_costume == 4 ) {
    costume = VIRUS_3_8_16_ROPE ;
  } else if(new_costume == 5 ) {
    costume = VIRUS_2_2_32_ROPE ;
  } else if(new_costume == 6 ) {
    costume = VIRUS_3_8_64_ROPE ;
  } else if(new_costume == 7 ) {
    costume = VIRUS_3_8_16_ROPE ;
  }




  float thickness = 1. ;


  Vec3 alpha_behavior_flora = Vec3(pos_final_dna.z, -.4, .8) ;
  style_flora = new Info_obj("Flora Aspect", costume, fill_flora, stroke_flora, thickness, alpha_behavior_flora) ;  
}






/**
ADN

*/

Vec3 [] drop_zone_flora_list ;
Helix_DNA strand_DNA ;
Vec3 pos_final_dna ;
int radius_dna ;
int size_dna ;
int [] target_nucleotide ;

void create_decorum() {
  //flora
  int revolution = 60 ;
  int nucleotide = num_flora *2 ;
  size_dna = int(height *1.5) ;
  radius_dna = abs(HORIZON) / 8 ;
  int num_strand = 2 ;

  pos_final_dna = Vec3(width / 2, -size_dna/3, -radius_dna) ;

  strand_DNA = new Helix_DNA(num_strand, nucleotide, revolution) ;
  strand_DNA.set_radius(radius_dna) ;
  strand_DNA.set_height(size_dna) ;
  strand_DNA.set_pos(pos_final_dna) ;

  drop_zone_flora_list = new Vec3[num_flora] ;
  target_nucleotide = new int[num_flora] ;

  for(int i = 0 ; i < drop_zone_flora_list.length ; i++) {
    drop_zone_flora_list[i] = Vec3() ;
    int where = (int)random(strand_DNA.get_pos().length) ;
    target_nucleotide[i] = where ;
    drop_zone_flora_list[i].set(strand_DNA.get_pos()[where]) ;
  }

}



void update_flora_position_from_adn() {
  for(int i = 0 ; i < FLORA_LIST.size() ; i++) {
    Agent flora = FLORA_LIST.get(i) ;
    flora.set_pos(strand_DNA.get_pos()[target_nucleotide[i]]) ;
  }
}


float rotation_dna = 0 ;
boolean rotation_bool_dna = false ;

void show_decorum(float speed_rotation_dna, int direction_dna, boolean info) {

  // show DNA
  if(size_dna > 0 ) {
    if(rotation_bool_dna) {
      rotation_dna += abs(speed_rotation_dna) *direction_dna ;
      // rotation_dna = abs(rotation_dna) *direction_dna ;
      strand_DNA.rotation(rotation_dna) ;
      strand_DNA.set_radius(radius_dna) ;
      strand_DNA.set_height(size_dna) ;
      strand_DNA.set_pos(pos_final_dna) ;
    }  

    for(int i = 0 ; i < strand_DNA.length() ; i++) {
      costume_DNA(strand_DNA, i, pos_final_dna, info) ;
    }
  }
}

void costume_DNA(Helix_DNA helix, int target, Vec3 pos_final, boolean info) {
  Vec3 pos_a = helix.get_pos(0)[target] ;
  Vec3 pos_b = helix.get_pos(1)[target] ;

  int size = 36 ;
  int size_link = 1 ;

  float radius = helix.get_radius().x ;
  float alpha_min = .01 ;
  float alpha_max = .8 ;

  stroke(80, 8) ;
  strokeWeight(size_link) ;
  line(pos_a, pos_b) ;

  float ratio_a = map(pos_a.z -pos_final_dna.z , -radius, radius, 0 +alpha_min, alpha_max) ;
  float alpha_a = g.colorModeA * ratio_a ;
  
  


  float ratio_b = map(pos_b.z -pos_final_dna.z, -radius, radius, 0 +alpha_min, alpha_max) ;
  float alpha_b = g.colorModeA *ratio_b ;


  if(info) {
    fill(color_strand_a, alpha_a) ;
    String nuc_a = "" +helix.get_DNA(0).sequence_a.get(target).nac ;
    costume_rope(pos_a, size, nuc_a) ;
    fill(color_strand_b, alpha_b) ;
    String nuc_b = "" +helix.get_DNA(0).sequence_a.get(target).nac ;
    costume_rope(pos_b, size, nuc_b) ;
  } else {
    noFill() ;
    stroke(color_strand_a, alpha_a) ;
    costume_rope(pos_a, size, POINT_ROPE) ;
    noFill() ;
    stroke(color_strand_b, alpha_b) ;
    costume_rope(pos_b, size, POINT_ROPE) ;
  }
  
}






























/**

INFO & LOG 0.1.0

*/

void info_agent(boolean info) {
  INFO_DISPLAY_AGENT = info ;
}
/**
INFO
*/
void info_ecosystem(int tempo) {
    if(frameCount%tempo == 0) {
    if (PRINT_POPULATION) {
      print_population() ;
    }
    // print_info_environment(biomass) ;
    //print_list() ;
    // print_info_carnivore(CARNIVORE_CHILD_LIST) ;
    print_info_herbivore("Child", HERBIVORE_CHILD_LIST) ;
    print_info_herbivore("Female", HERBIVORE_FEMALE_LIST) ;
    print_info_herbivore("Male", HERBIVORE_MALE_LIST) ;
    // print_info_bacterium(BACTERIUM_LIST) ;
  }
}

void print_population() {
  println(frameCount) ;
  print_pop_agent_dynamic("Population Herbivore", HERBIVORE_CHILD_LIST, HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST) ;
  print_pop_agent_dynamic("Population Carnivore", CARNIVORE_CHILD_LIST, CARNIVORE_FEMALE_LIST, CARNIVORE_MALE_LIST) ;
  print_pop_agent_dynamic("Population Omnivore", OMNIVORE_CHILD_LIST, OMNIVORE_FEMALE_LIST, OMNIVORE_MALE_LIST) ;
  print_pop_agent_dynamic("Population Bacterium", BACTERIUM_LIST) ;
  print_pop_agent_dynamic("Population Dead Bodies", DEAD_LIST) ;
}


void print_list() {
  println("Flora", FLORA_LIST.size()) ;

  println("Bacterium",BACTERIUM_LIST.size()) ;

  println("Herbivore child",HERBIVORE_CHILD_LIST.size()) ;
  println("Herbivore female",HERBIVORE_FEMALE_LIST.size()) ;
  println("Herbivore male",HERBIVORE_MALE_LIST.size()) ;

  println("Carnivore",CARNIVORE_CHILD_LIST.size()) ;
  
  println("Corpse",DEAD_LIST.size()) ;
}
/**
LOG
*/




void log_ecosystem(int tempo) {

  /**
  log population
  */
  if(frameCount%tempo == 0 && LOG_ECOSYSTEM) {
    // log eco agent
    int num_log_eco_agent = 6 ;
    if(!log_is()) {
      build_log(num_log_eco_agent) ;
    }

    log_eco_agent() ;
    log_eocsystem_resume() ;
    log_agent_global() ;

    log_save() ;
  }
}


// local log method
void log_eocsystem_resume() {
      log_eco_resume(   biomass.humus, biomass.humus_max, 
                      HERBIVORE_CHILD_LIST, HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST,
                      OMNIVORE_CHILD_LIST, OMNIVORE_FEMALE_LIST, OMNIVORE_MALE_LIST,
                      CARNIVORE_CHILD_LIST, CARNIVORE_FEMALE_LIST, CARNIVORE_MALE_LIST,
                      BACTERIUM_LIST,
                      FLORA_LIST,
                      DEAD_LIST) ;

}

void log_eco_agent() {
  if(LOG_ALL_AGENTS) {
      log_eco_agent(0, "Herbivore", HERBIVORE_CHILD_LIST, HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST) ;
      log_eco_agent(1, "Omnivore", OMNIVORE_CHILD_LIST, OMNIVORE_FEMALE_LIST, OMNIVORE_MALE_LIST) ;
      log_eco_agent(2, "Carnivore", CARNIVORE_CHILD_LIST, CARNIVORE_FEMALE_LIST, CARNIVORE_MALE_LIST) ;
      log_eco_agent(3, "Bacterium", BACTERIUM_LIST) ;
      log_eco_agent(4,  "Flora", FLORA_LIST) ;
      log_eco_agent(5,  "Dead", DEAD_LIST) ;
    } else {
      if(LOG_HERBIVORE) log_eco_agent(0, "Herbivore", HERBIVORE_CHILD_LIST, HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST) ;
      if(LOG_OMNIVORE)  log_eco_agent(1, "Omnivore", OMNIVORE_CHILD_LIST, OMNIVORE_FEMALE_LIST, OMNIVORE_MALE_LIST) ;
      if(LOG_CARNIVORE)  log_eco_agent(2, "Carnivore", CARNIVORE_CHILD_LIST, CARNIVORE_FEMALE_LIST, CARNIVORE_MALE_LIST) ;
      if(LOG_BACTERIUM) log_eco_agent(3, "Bacterium", BACTERIUM_LIST) ;
      if(LOG_FLORA) log_eco_agent(4,  "Flora", FLORA_LIST) ;
      if(LOG_DEAD) log_eco_agent(5,  "Dead", DEAD_LIST) ;
    }

}

void log_agent_global() {
  if(LOG_ALL_AGENTS) {
    log_agent_global("Herbivore", HERBIVORE_CHILD_LIST, HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST) ;
    log_agent_global("Omnivore", OMNIVORE_CHILD_LIST, OMNIVORE_FEMALE_LIST, OMNIVORE_MALE_LIST) ;
    log_agent_global("Carnivore", CARNIVORE_CHILD_LIST, CARNIVORE_FEMALE_LIST, CARNIVORE_MALE_LIST) ;
    log_agent_global("Bacterium", BACTERIUM_LIST) ;
    log_agent_global("Flora", FLORA_LIST) ;
    log_agent_global("Dead", DEAD_LIST) ;
  } else {
    if(LOG_HERBIVORE) log_agent_global("Herbivore", HERBIVORE_CHILD_LIST, HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST) ;
    if(LOG_OMNIVORE) log_agent_global("Omnivore", OMNIVORE_CHILD_LIST, OMNIVORE_FEMALE_LIST, OMNIVORE_MALE_LIST) ;
    if(LOG_CARNIVORE) log_agent_global("Carnivore", CARNIVORE_CHILD_LIST, CARNIVORE_FEMALE_LIST, CARNIVORE_MALE_LIST) ;
    if(LOG_BACTERIUM) log_agent_global("Bacterium", BACTERIUM_LIST) ;
    if(LOG_BACTERIUM) log_agent_global("Flora", FLORA_LIST) ;
    if(LOG_DEAD) log_agent_global("Dead", DEAD_LIST) ;
  }
}
/**
END LOG & PRINT
*/