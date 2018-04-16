/**
Ecosysteme 
2016-2018
v 0.1.4
*/
class Ecosystem_agent extends Romanesco {
	public Ecosystem_agent() {
		RPE_name = "Eco Agents";
		ID_item = 25;
		ID_group = 1;
		RPE_author  = "Stan le Punk";
		RPE_version = "Version 0.1.4";
		RPE_pack = "Ecosystem";
		RPE_mode = "Virus/Human/Alien/Other"; // separate the differentes mode by "/"
		RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Stroke hue,Stroke sat,Stroke bright,Stroke alpha,Thickness,Size X,Size Y,Size Z,Speed X,Canvas X,Canvas Y,Canvas Z,Speed X,Quantity,Spectrum,Life" ;
	}

  int type_agents = 6 ;
  int colour_groups = type_agents ;
  float range_colour = 0 ;
  int mode_ref = 0 ;
  //boolean host_mode = false ;
  float [] hue_fill = new float[type_agents] ;
  float [] hue_stroke = new float[type_agents] ;
  float hue_fill_ref, hue_stroke_ref ;

  // boolean info_agent = false ;
  // boolean agent_display = true ;
  //boolean bg_refresh = true ;
  float speed_agent = .01 ;
  boolean host_mode_ref ;
  float ratio_canvas = 2 ;


  void setup() {
    // here we cannot use the setting pos, because it's too much ling with the item 27 !!!
    setting_start_position(ID_item, 0, 0, 0) ;

    load_nucleotide_table(items_path+"ecosystem/code.csv");
    Vec3 pos = Vec3(width/2, height/2, 0) ;
    Vec3 canvas = Vec3(canvas_x_item[ID_item],canvas_y_item[ID_item],canvas_z_item[ID_item]);
    canvas.mult(ratio_canvas) ;


    host_mode_ref = orbit[ID_item] ;
    init_environment(pos, canvas) ;
    use_horizon(true) ;
    use_rebound(false) ;
    // init_ecosystem(size_x_item[ID_item], life_item[ID_item]) ;
    init(true) ;
    if(init_ecosystem) {
      Vec3 ratio_size = Vec3(size_x_item[ID_item],size_y_item[ID_item],size_z_item[ID_item]) ;
      ecosystem_setting(biomass,follower[ID_item],ratio_size,life_item[ID_item],speed_x_item[ID_item]);
      init_ecosystem = false ;
      first_save = true ;
    }
  }



  
	void draw() {
    // Master and Follower item 
    if(orbit[ID_item]) {
      follower[ID_item] = true ;
    } else {
      follower[ID_item] = false ;
    }
    



    if(host_mode_ref != follower[ID_item]) {
      init_ecosystem() ;
      host_mode_ref = follower[ID_item] ;
    }

    if(follower[ID_item]) {
      master_ID[ID_item] = 27 ;
      sync_symbiosis(master_ID[ID_item]) ;
      update_symbiosis() ;
    } else {
       master_ID[ID_item] = 0 ;
    }



    // SETTING
    speed_agent = speed_x_item[ID_item] *speed_x_item[ID_item];

    float thickness_common = thickness_item[ID_item] ;
    
    if(action[ID_item]) {
      if(touch1) {
        colour_groups = 1 ;
      }
      if(touch2) {
        colour_groups = 2 ;
      }
      if(touch3) {
        colour_groups = 3 ;
      }
      if(touch4) {
        colour_groups = 4 ;
      }
      if(touch5) {
        colour_groups = 5 ;
      }
      if(touch6) {
        colour_groups = 6 ;
      }
    } 

    float max = 360 / colour_groups ;
    range_colour = map(spectrum_item[ID_item],0,360,0,max) ;

    
    if(hue_fill_ref != hue(fill_item[ID_item])) {
      Vec4 [] pool_fill = color_pool_HSB(type_agents, colour_groups, hue(fill_item[ID_item]), range_colour) ;
      for(int i = 0 ; i < hue_fill.length ; i++) {
        hue_fill[i] = pool_fill[i].x ;
      }
      hue_fill_ref = hue_fill[0] = hue(fill_item[ID_item]) ;
    }
    if(hue_stroke_ref != hue(stroke_item[ID_item])) {
      Vec4 [] pool_stroke = color_pool_HSB(type_agents, colour_groups, hue(stroke_item[ID_item]), range_colour) ;
      for(int i = 0 ; i < hue_stroke.length ; i++) {
        hue_stroke[i] = pool_stroke[i].x ;
      }
      hue_stroke_ref = hue_stroke[0] = hue(stroke_item[ID_item]) ;
    }
    if(colour[ID_item]) {
      Vec4 [] pool_fill = color_pool_HSB(type_agents, colour_groups, random(g.colorModeX), range_colour) ;
      Vec4 [] pool_stroke = color_pool_HSB(type_agents, colour_groups, random(g.colorModeX), range_colour) ;
      for(int i = 0 ; i < type_agents ; i++) {
        hue_fill[i] = pool_fill[i].x ;
        hue_stroke[i] = pool_stroke[i].x ;
      }
      colour[ID_item] = false ;
    }

    if(horizon[ID_item]) {
      use_horizon(true) ; 
    } else {
      use_horizon(false) ;
    }
    // 1 / FLORA VIRUS
    Vec4 fill_flora = Vec4(hue_fill[0], saturation(fill_item[ID_item]), brightness(fill_item[ID_item]), alpha(fill_item[ID_item])) ;
    Vec4 stroke_flora = Vec4(hue_stroke[0], saturation(stroke_item[ID_item]), brightness(stroke_item[ID_item]), alpha(stroke_item[ID_item])) ;
    // 2 / DEAD
    Vec4 fill_dead = Vec4(hue_fill[1], saturation(fill_item[ID_item]), brightness(fill_item[ID_item]), alpha(fill_item[ID_item])) ;
    Vec4 stroke_dead = Vec4(hue_stroke[1], saturation(stroke_item[ID_item]), brightness(stroke_item[ID_item]), alpha(stroke_item[ID_item])) ;
    // 3 / BACTERIUM
    Vec4 fill_bacterium = Vec4(hue_fill[2], saturation(fill_item[ID_item]), brightness(fill_item[ID_item]), alpha(fill_item[ID_item])) ;
    Vec4 stroke_bacterium = Vec4(hue_stroke[2], saturation(stroke_item[ID_item]), brightness(stroke_item[ID_item]), alpha(stroke_item[ID_item])) ;
    // 4 / HERBIVORE
    Vec4 fill_herbivore = Vec4(hue_fill[3], saturation(fill_item[ID_item]), brightness(fill_item[ID_item]), alpha(fill_item[ID_item])) ;
    Vec4 stroke_herbivore = Vec4(hue_stroke[3], saturation(stroke_item[ID_item]), brightness(stroke_item[ID_item]), alpha(stroke_item[ID_item])) ;
    // 5 / OMNIVORE
    Vec4 fill_omnivore = Vec4(hue_fill[4], saturation(fill_item[ID_item]), brightness(fill_item[ID_item]), alpha(fill_item[ID_item])) ;
    Vec4 stroke_omnivore = Vec4(hue_stroke[4], saturation(stroke_item[ID_item]), brightness(stroke_item[ID_item]), alpha(stroke_item[ID_item])) ;
    // 6 / CARNIVORE
    Vec4 fill_carnivore = Vec4(hue_fill[5], saturation(fill_item[ID_item]), brightness(fill_item[ID_item]), alpha(fill_item[ID_item])) ;
    Vec4 stroke_carnivore = Vec4(hue_stroke[5], saturation(stroke_item[ID_item]), brightness(stroke_item[ID_item]), alpha(stroke_item[ID_item])) ;





    Vec3 alpha_behavior_common = Vec3(0, -1, 1) ;

    int costume_flora = VIRUS_3_2_64_ROPE ;
    int costume_herbivore = TRIANGLE_ROPE ;
    int costume_carnivore = STAR_9_ROPE ;
    int costume_omnivore = STAR_5_ROPE ;
    int costume_bacterium = SQUARE_ROPE ;
    int costume_dead = CROSS_BOX_2_ROPE;
    if(dimension[ID_item]) {
      costume_flora = VIRUS_3_8_64_ROPE ;
      costume_herbivore = TETRAHEDRON_ROPE ;
      costume_carnivore = SPHERE_HIGH_ROPE ;
      costume_omnivore = SPHERE_LOW_ROPE ;
      costume_bacterium = RECT_ROPE ;
      costume_dead = CROSS_BOX_3_ROPE;

    }

    style_flora = update_style(style_flora, "flora", costume_flora, fill_flora, stroke_flora, thickness_common, alpha_behavior_common, fill_is[ID_item], stroke_is[ID_item]) ;

    style_herbivore = update_style(style_herbivore, "herbivore", costume_herbivore, fill_herbivore, stroke_herbivore, thickness_common, alpha_behavior_common, fill_is[ID_item], stroke_is[ID_item]) ;

    style_carnivore = update_style(style_carnivore, "carnivore", costume_carnivore, fill_carnivore, stroke_carnivore, thickness_common, alpha_behavior_common, fill_is[ID_item], stroke_is[ID_item]) ;
    style_omnivore = update_style(style_omnivore, "omnivore", costume_omnivore, fill_omnivore, stroke_omnivore, thickness_common, alpha_behavior_common, fill_is[ID_item], stroke_is[ID_item]) ;

    style_dead = update_style(style_dead, "dead", costume_bacterium, fill_dead, stroke_dead, thickness_common, alpha_behavior_common, fill_is[ID_item], stroke_is[ID_item]) ;
    style_bacterium = update_style(style_bacterium, "bacterium", costume_dead, fill_bacterium, stroke_bacterium, thickness_common, alpha_behavior_common, fill_is[ID_item], stroke_is[ID_item]) ;





    // INIT
    init(birth[ID_item]) ;

		if(init_ecosystem) {
      Vec3 ratio_size = Vec3(size_x_item[ID_item],size_y_item[ID_item],size_z_item[ID_item]) ;
			ecosystem_setting(biomass, follower[ID_item], ratio_size, life_item[ID_item], speed_x_item[ID_item]) ;
			init_ecosystem = false ;
			first_save = true ;
		}
    

    // UPDATE
		update_list() ;
    if(FULL_RENDERING) {
      if(special[ID_item]) {
        info_agent(true) ;
      } else {
        info_agent(false) ;
      } 
    }

    // CANVAS
    Vec3 canvas = Vec3(canvas_x_item[ID_item], canvas_y_item[ID_item], canvas_z_item[ID_item]) ;
    canvas.mult(ratio_canvas) ;
    set_canvas_environment(canvas) ;

    // SHOW
		show_agent() ;

    // INFO
    if (objectInfoDisplay[ID_item]) {
      strokeWeight(1) ;
      stroke(blanc) ;
      noFill() ;
      costume_rope(ECO_BOX_POS, ECO_BOX_SIZE, BOX_ROPE) ;
    }   	
	}
  /**
  METHOD
  */
  void init(boolean new_birth) {
    if(mode[ID_item] != mode_ref || new_birth) {
      mode_ref = mode[ID_item] ;
      birth[ID_item] = false ;
      if(mode[ID_item] == 0) {
        set_pop(true, false, false, false, false) ;
      } else if(mode[ID_item] == 1) {
        set_pop(true, true, false, false, true) ;
      } else if(mode[ID_item] == 2) {
        set_pop(true, true, true, false, true) ;
      } else if(mode[ID_item] == 3) {
        set_pop(true, true, true, true, true) ;
      } 
      init_ecosystem() ;
    }

  }

  void set_pop(boolean use_flora, boolean use_herbivore, boolean use_carnivore, boolean use_omnivore, boolean use_bacterium) {
    int div_pop = 1 ;
    if(!FULL_RENDERING) div_pop= 20 ;
    if(use_flora) {
      set_pop_flora(10 +int(1500 *quantity_item[ID_item])/div_pop) ;
    } else set_pop_flora(0) ;
    if(use_herbivore) {
      set_pop_herbivore(20 +int(300 *quantity_item[ID_item])/div_pop) ;
    } else set_pop_herbivore(0) ;
    if(use_carnivore) {
      set_pop_carnivore(2 +int(20 *quantity_item[ID_item])/div_pop) ;
    } else set_pop_carnivore(0) ;
    if(use_omnivore) {
      set_pop_omnivore(4 +int(40 *quantity_item[ID_item])/div_pop) ;
    } else set_pop_omnivore(0) ;
    if(use_bacterium) {
      set_pop_bacterium(1 +int(10 *quantity_item[ID_item])/div_pop) ;
    } else set_pop_bacterium(0) ;

    set_pop_dead(0/div_pop) ;
  }
}


































/**
MANAGE ECO-SYSTEM BUILT 0.2.1
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
int num_flora = 0 ;
int num_herbivore = 0 ; 
int num_omnivore = 0 ; 
int num_carnivore = 0 ; 
int num_bacterium = 0 ;
int num_dead = 0 ;

// Colour
Info_Object style_carnivore, style_herbivore, style_omnivore ;
Info_Object style_flora ;
Info_Object style_dead ;
Info_Object style_bacterium ;


Info_dict flora_carac = new Info_dict() ;
Info_dict herbivore_carac = new Info_dict() ;
Info_dict omnivore_carac = new Info_dict() ;
Info_dict carnivore_carac = new Info_dict() ;
Info_dict bacterium_carac = new Info_dict() ;
Info_dict dead_carac = new Info_dict() ;





// main method
void ecosystem_setting(Biomass b, boolean host_mode, Vec3 factor_size, float factor_life, float ratio_speed) {
  factor_size.x = map(factor_size.x, size_x_min_max.x, size_x_min_max.y, width/2000, width/100) ;
  factor_size.y = map(factor_size.y, size_y_min_max.x, size_y_min_max.y, width/2000, width/100) ;
  factor_size.z = map(factor_size.z, size_z_min_max.x, size_z_min_max.y, width/2000, width/100) ;
  factor_life = map(factor_life, life_min_max.x, life_min_max.y, .5, 3) ;
  ratio_speed = map(ratio_speed, 0,1, .5, 8) ;
    // b.set_humus(ECO_BOX_SIZE.x *ECO_BOX_SIZE.y *.01) ;

  clear_agent() ;
  // order of quantity for set_num_agents(int... num)"  ;


  set_caracteristic_agent(factor_size, factor_life, ratio_speed) ;

  int costume = 0 ;
  float thickness = 1. ;
  Vec3 alpha_behavior_flora = Vec3(0, -1, 1) ; // it's like 100% all the time
  boolean fill_is = true ;
  boolean stroke_is = true ;

  if(get_pos_host() != null) {

    alpha_behavior_flora = Vec3(get_pos_host().z, -.4, .8) ;
  }
  
  if(style_flora == null ) {
    costume = VIRUS_3_4_64_ROPE ;
    thickness = 1. ;
    Vec4 fill_flora = Vec4(color_flora) ;
    Vec4 stroke_flora = Vec4(color_flora) ;
    style_flora = new Info_Object("Flora Aspect", costume, fill_flora, stroke_flora, thickness, alpha_behavior_flora, fill_is, stroke_is) ;  
  }

  // HERBIVORE
  if(style_herbivore == null ) {
    costume = STAR_5_ROPE ;
    Vec4 fill_herbivore = Vec4(color_herbivore) ;
    Vec4 stroke_herbivore = Vec4(color_herbivore) ;
    Vec3 alpha_behavior_herbivore = Vec3(0, -1, 1) ;
    style_herbivore = new Info_Object("Herbivore Aspect", costume, fill_herbivore, stroke_herbivore, thickness, alpha_behavior_herbivore, fill_is, stroke_is) ;
  }

  
  // OMNIVORE
  if(style_omnivore == null) {
    costume = STAR_12_ROPE ;
    Vec4 fill_omnivore = Vec4(150, 100, 80, 100) ;
    Vec4 stroke_omnivore = Vec4(150, 100, 80, 100) ;
    Vec3 alpha_behavior_omnivore = Vec3(0, -1, 1) ;
    style_omnivore = new Info_Object("Omnivore Aspect", costume, fill_omnivore, stroke_omnivore, thickness, alpha_behavior_omnivore, fill_is, stroke_is) ;
  }


  // CARNIVORE
  if(style_carnivore == null) {
    costume = SUPER_STAR_12_ROPE ;
    Vec4 fill_carnivore = Vec4(0, 100, 100, 100) ;
    Vec4 stroke_carnivore = Vec4(0, 100, 100, 100) ;
    Vec3 alpha_behavior_carnivore = Vec3(0, -1, 1) ;
    style_carnivore = new Info_Object("Carnivore Aspect", costume, fill_carnivore, stroke_carnivore, thickness, alpha_behavior_carnivore, fill_is, stroke_is) ;
  }

  
  // BACTERIUM
  if(style_bacterium == null) {
    costume = TRIANGLE_ROPE ;
    Vec4 fill_bacterium = Vec4(30, 0, 30, 100) ;
    Vec4 stroke_bacterium = Vec4(30, 0, 30, 100) ;
    Vec3 alpha_behavior_bacterium = Vec3(0, -1, 1) ;
    style_bacterium = new Info_Object("Bacterium Aspect", costume, fill_bacterium, stroke_bacterium, thickness, alpha_behavior_bacterium, fill_is, stroke_is) ;
  }  
  

  // DEAD
  if(style_dead == null) {
    costume = CROSS_BOX_2_ROPE;
    Vec4 fill_dead = Vec4(0, 0, 30, 100) ;
    Vec4 stroke_dead = Vec4(0, 0, 30, 100) ;
    Vec3 alpha_behavior_dead = Vec3(0, -1, 1) ;
    style_dead = new Info_Object("Dead Aspect", costume, fill_dead, stroke_dead, thickness, alpha_behavior_dead, fill_is, stroke_is) ;
  }



  if(!host_mode) {
    // classic radom drop zone
    build_flora(FLORA_LIST, flora_carac, style_flora, num_flora) ;
  } else {
    //drop zone from list of point
    build_flora(FLORA_LIST, flora_carac, style_flora, num_flora, get_symbiosis_area_pos()) ;
    symbiosis(FLORA_LIST, get_symbiosis_area_pos(), get_host_address()) ;
  }

  build_herbivore(HERBIVORE_CHILD_LIST, herbivore_carac, style_herbivore, num_herbivore) ;
  build_omnivore(OMNIVORE_CHILD_LIST, omnivore_carac, style_omnivore, num_omnivore) ;
  build_carnivore(CARNIVORE_CHILD_LIST, carnivore_carac, style_carnivore, num_carnivore) ;
  build_bacterium(BACTERIUM_LIST, bacterium_carac, style_bacterium, num_bacterium) ;
  build_dead(DEAD_LIST, dead_carac, style_dead, num_dead) ;
}


Info_Object update_style(Info_Object style, String name, int costume, Vec4 fill, Vec4 stroke, float thickness, Vec3 alpha_behavior, boolean fill_is, boolean stroke_is) {
  // style.clear() ;
 return new Info_Object(name, costume, fill, stroke, thickness, alpha_behavior, fill_is, stroke_is) ;
}


// set num
void set_pop_flora(int num) {
  num_flora = num ;
}

void set_pop_herbivore(int num) {
  num_herbivore = num ;
}

void set_pop_carnivore(int num) {
  num_carnivore = num ;
}

void set_pop_omnivore(int num) {
  num_omnivore = num ;
}

void set_pop_bacterium(int num) {
  num_bacterium = num ;
}

void set_pop_dead(int num) {
  num_dead= num ;
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


void set_caracteristic_agent(Vec3 ratio_size, float ratio_life, float ratio_speed) {
  flora_carac.add("name", "Virus") ;
  flora_carac.add("size", Vec3(30).mult(ratio_size)) ;
  flora_carac.add("life_expectancy", int(100000 *60 *ratio_life)) ;
  flora_carac.add("nutrient_quality", 15) ;
  flora_carac.add("speed_growth", 2) ; // size point per cycle
  flora_carac.add("need", .3) ;
  flora_carac.add("first_colour", Vec4(1)) ;

  herbivore_carac.add("name", "Hippie") ;
  herbivore_carac.add("size", Vec3(40).mult(ratio_size)) ;
  herbivore_carac.add("stamina", 100) ;
  herbivore_carac.add("life_expectancy", int(1000 *60 *ratio_life)) ;
  herbivore_carac.add("velocity", int(6 *ratio_speed)) ;
  herbivore_carac.add("nutrient_quality", 40) ;
  herbivore_carac.add("sense_range", 4000) ;
  herbivore_carac.add("gourmet", 3.5) ;
  herbivore_carac.add("starving", 4) ;
  herbivore_carac.add("digestion", 2.5) ;
  herbivore_carac.add("sex_appeal", Vec2(40, 5)) ;
  herbivore_carac.add("multiple_pregnancy", 50.) ;
  herbivore_carac.add("first_colour", Vec4(1)) ;

  omnivore_carac.add("name", "Punk") ;
  omnivore_carac.add("size", Vec3(40).mult(ratio_size)) ; // in pixel
  omnivore_carac.add("stamina", 200) ; // point of life
  omnivore_carac.add("life_expectancy", int(800 *60 *ratio_life)) ; // frame of live before die
  omnivore_carac.add("velocity", int(8 *ratio_speed)) ; // in pixel
  omnivore_carac.add("nutrient_quality", 20) ; // multi the stamina point to give the calories
  omnivore_carac.add("sense_range", 1000) ; // range in pixel
  omnivore_carac.add("gourmet", 2.5) ; 
  omnivore_carac.add("attack", 5) ; // attack point
  omnivore_carac.add("starving", 3) ; 
  omnivore_carac.add("digestion", 6.5) ; // calorie multiplicator, hight is good.
  omnivore_carac.add("sex_appeal", Vec2(45, 4)) ; // multe the size to give the range in pixel
  omnivore_carac.add("multiple_pregnancy", 10.5) ; // chance to have twin or better in pourcent
  omnivore_carac.add("colour", 1) ;
  omnivore_carac.add("first_colour", Vec4(1)) ;

  carnivore_carac.add("name", "Alien") ;
  carnivore_carac.add("size", Vec3(50).mult(ratio_size)) ;
  carnivore_carac.add("stamina", 400) ;
  carnivore_carac.add("life_expectancy", int(1200 *60 *ratio_life)) ;
  carnivore_carac.add("velocity", int(10 *ratio_speed)) ;
  carnivore_carac.add("nutrient_quality", 20) ;
  carnivore_carac.add("sense_range", 1200) ;
  carnivore_carac.add("gourmet", 2.5) ;
  carnivore_carac.add("attack", 10) ;
  carnivore_carac.add("starving", 4) ;
  carnivore_carac.add("digestion", 4.5) ;
  carnivore_carac.add("sex_appeal", Vec2(30, 10)) ;
  carnivore_carac.add("multiple_pregnancy", 5.5) ;
  carnivore_carac.add("colour", 1) ;
  carnivore_carac.add("first_colour", Vec4(1)) ;

  bacterium_carac.add("name", "Gnak Gnak") ;
  bacterium_carac.add("size", Vec3(10).mult(ratio_size)) ;
  bacterium_carac.add("stamina", 200) ;
  bacterium_carac.add("life_expectancy", int(800 *60 *ratio_life)) ;
  bacterium_carac.add("velocity", int(5 *ratio_speed)) ;
  bacterium_carac.add("nutrient_quality", 1) ;
  bacterium_carac.add("sense_range", 500) ;
  bacterium_carac.add("starving", 2) ;
  bacterium_carac.add("digestion", 12.5) ;
  bacterium_carac.add("colour", 1) ;
  bacterium_carac.add("first_colour", Vec4(1)) ;

  dead_carac.add("name", "UNDEAD") ;
  dead_carac.add("size", Vec3(25).mult(ratio_size)) ;
  dead_carac.add("nutrient_quality", 40) ;
  dead_carac.add("colour", 1) ;
  dead_carac.add("first_colour", Vec4(1)) ;
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
ENVIRONMENT 0.0.4

*/

/**
* Create enviromnent where the ecosystem will be live
*/
void build_environment(Vec2 pos, Vec2 size) {
  Vec3 pos_3D = Vec3(pos.x, pos.y,0) ;
  Vec3 size_3D = Vec3(size.x, size.y,0) ;
  build_environment(pos_3D, size_3D) ;
  // write here to be sure the Environment have a good info
}

void build_environment(Vec3 pos, Vec3 size) {
  build_box(pos, size) ;

  float front = box_front() ;
  float back = box_back() ;

  set_limit_box(box_left() , box_right(), box_top(),  box_bottom(), front, back) ;
  int dist_to_horizon = int(abs(back) +abs(front)) ;
  set_horizon(dist_to_horizon) ;
  // use_rebound(true) ;
  set_textSize_info(18) ; 
  // b.set_humus(BOX.x *BOX.y *.01) ;
  // b.humus_max = b.humus = BOX.x *BOX.y *.01 ;
}

float box_left() {
  return get_box_pos().x - (get_box_size().x *.5) ;
}

float box_right() {
  return get_box_pos().x + (get_box_size().x *.5) ;
}

float box_top() {
  return get_box_pos().y - (get_box_size().y *.5) ;
}

float box_bottom() {
  return get_box_pos().y + (get_box_size().y *.5) ;
}

float box_front() {
  return get_box_pos().z - (get_box_size().z *.5) ;
}

float box_back() {
  return get_box_pos().z + (get_box_size().z *.5) ;
}




/**
SET ENVIRONMENT
*/
Biomass biomass ;
boolean init_ecosystem = true ;

void init_ecosystem() {
  init_ecosystem = true ;
}



// set
void set_environment(Vec pos, Vec canvas) {
  if(pos instanceof Vec3 && canvas instanceof Vec3 && renderer_P3D()) {
    Vec3 p = (Vec3) pos ;
    Vec3 c = (Vec3) canvas ;
    build_environment(p, c) ;
    set_renderer(P3D) ;
  } else if(pos instanceof Vec2 && canvas instanceof Vec2 && renderer_P3D()) {
    Vec2 p = (Vec2) pos ;
    Vec2 c = (Vec2) canvas ;
    build_environment(p, c) ;
  } else if(pos instanceof Vec2 && canvas instanceof Vec2 && !renderer_P3D()) {
    Vec2 p = (Vec2) pos ;
    Vec2 c = (Vec2) canvas ;
    build_environment(p, c) ;
  } else {
    System.err.println("Something wrong in your universe, the both Vec must be Vec2 or Vec3, plus the Vec3 pos and canvas work only in P3D renderer") ;
  }
}


void set_canvas_environment(Vec size) {
  if(size instanceof Vec3) {
    Vec3 s = (Vec3) size ;
    set_size_box(s) ;
    set_limit_box(box_left() , box_right(), box_top(),  box_bottom(), box_front(), box_back()) ;
  } else if (size instanceof Vec2) {
    Vec2 s = (Vec2) size ;
    Vec3 def_size = Vec3(s.x,s.y,0) ;
    set_size_box(def_size) ;
    set_limit_box(box_left() , box_right(), box_top(),  box_bottom(), box_front(), box_back()) ;
  }  
}





// build
void init_environment(Vec pos, Vec canvas) {
  biomass = new Biomass() ;
  set_environment(pos, canvas) ;  
}


/**
BIOTOPE 
*/
/*
Vec4 biotope_colour(Biomass b) {
  float normal_humus_level = 1 - b.humus / b.humus_max ;
  float var_colour_ground = 90 *normal_humus_level ;
  return Vec4(40,90, 5 +var_colour_ground,100) ;
}
*/






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
VIRUS

*/
Vec4 color_flora = Vec4(0, 100, 80, 100) ;
Vec4 color_herbivore = Vec4(110, 100, 70, 100) ;


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


  Vec3 alpha_behavior_flora = Vec3(get_pos_host().z, -.4, .8) ;
  style_flora = new Info_Object("Flora Aspect", costume, fill_flora, stroke_flora, thickness, alpha_behavior_flora) ;  
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