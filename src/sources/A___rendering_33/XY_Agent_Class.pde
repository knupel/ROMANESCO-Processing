/**
CLASS AGENT 
v 1.2.1
2016-2019

*/
/**


INTERFACE AGENT 0.1.2


*/
interface Agent {
  float CLOCK = 1.5 ;
  int TIME_TO_BE_CARRION = 600 ;

  /**
  GET
  */
  short get_ID() ;
  int get_life() ;
  int get_stamina() ;
  Genome get_genome() ;
  boolean get_alive() ;
  vec3 get_pos() ;

  vec3 get_size() ;
  int get_mass() ;
  float get_density() ;


  int get_alpha_cursor() ;
  float get_alpha_back() ;
  float get_alpha_front() ;

  /**
  get home
  */
  vec4 get_home() ;
  vec3 get_home_pos() ;
  int get_home_id() ;


  /**
  METHOD
  */
  void growth() ;
  /**
  aspect
  */

  void costume();
  void set_costume(int which);
  void set_costume(Costume costume);
  
  void aspect(vec4 f, vec4 s, float t) ;

  Costume get_costume();
  vec4 get_fill_style();
  vec4 get_stroke_style();
  float get_thickness();

  vec4 get_melanin() ;

  vec4 get_first_colour() ;
  vec4 get_second_colour() ;
  vec4 get_third_colour() ;


  /**
  SET
  */
  /**
  set home
  */
  void set_home(vec4 home) ;
  void set_home(vec3 pos, int id_home) ;
  void set_home_pos(vec3 pos) ;
  void set_home_ID(int id_home) ;

  /**
  set aspect
  */
  void set_aspect(vec4 fill_style, vec4 stroke_style, float thickness) ;
  void set_fill(vec4 fill_style) ;
  void set_stroke(vec4 stroke_style) ;
  void set_thickness(float thickness) ;
  void set_alpha(vec3 alpha_behavior) ;
  /**
  set coor, motion...
  */
  void set_pos(vec pos) ; 
  /**
  set caracterictic
  */
  void set_nutrient_quality(int nutrient_quality) ;

  /**
  INFO
  */
  void info(vec4 colour, int size_text)  ;
}

/**

END INTERFACE AGENT

*/































/**



Agent_model ABSTRACT CLASS 0.2.0

*/
abstract class Agent_model implements Agent {
  String name ;
  short ID = 0 ; 
  int gender = 0 ; // 0 for female, 1 for male, 2 for ermaphrodite
  int generation = 0 ;
  int num_children = 0 ;
  int num_heterozygous = 0 ;
  int num_homozygous = 0 ;
  int num_pregnancy = 0 ;


  /**
  feed
  */
  boolean satiate ;
  float gourmet = 2. ;
  float speed_feeding = .2 ;

  boolean hunger_bool, starving_bool ;


  /**
  life param
  */
  int age = 0 ;
  int dead_since = 0 ;

  boolean alive = true ;
  boolean carrion = false ;

  int life ;
  int life_expectancy = 1  ;

  int stamina, stamina_ref ;
  int nutrient_quality = 1 ;
  // size
  vec3 size, size_ref, size_max ;
  int mass, mass_ref ;
  float density = 1 ;
  /**
  colour use by ADN
  */
  vec4 melanin ;
  vec4 first_colour, second_colour, third_colour ;
  /**
  aspect 
  not use in the ADN, just for display
  */
  vec4 fill_style = vec4(0,0,0,g.colorModeA) ;
  vec4 stroke_style = vec4(0,0,0,g.colorModeA) ;
  float thickness = 1 ;

  Costume costume; // costume 0 is point in Z_costume_rope library

  int alpha_cursor = 0 ;
  float alpha_back = 1. ;
  float alpha_front = 1. ;
  /**
  pos
  */
  vec3 pos = vec3() ;

  /**
  home
  */
  vec4 home ;


 /**
 home
  */
  void set_home(vec4 home) {
    if(this.home != null) {
      this.home.set(home) ;
    } else {
      this.home = home.copy() ;
    }
  }

  void set_home(vec3 pos, int id_home) {
    if(this.home != null) {
      this.home.set(pos.x, pos.y, pos.z, id_home) ;
    } else {
      this.home = vec4(pos.x, pos.y, pos.z, id_home) ;
    }
  }

  void set_home_pos(vec3 pos) {
    if(this.home != null) {
      this.home.set(pos.x, pos.y, pos.z, this.home.w) ;
    } else {
      this.home = vec4(pos.x, pos.y, pos.z, -1) ;
    }
  }

  void set_home_ID(int id_home) {
    if(this.home != null) {
      this.home.set(this.home.x, this.home.y, this.home.z, id_home) ;
    } else {
      this.home = vec4(0, 0, 0, id_home) ;
    }
  }

  /**
  reproduction
  */
  Genome genome ;
  Genome genome_father ;

  int maturity ;
  int fertility_cycle ;
  int fertility_time_ref  ;
  int pregnant_term   ;
  
  int fertility_time ;

  boolean fertility = false ;
  int fertility_rate = 1 ;
  int pregnant_time = 0  ;
  boolean pregnant = false ;
  
  // only use for female
  int reproduction_area ;
  int sex_appeal ;
  // int factor_reproduction_area_female = 2 ;
  // int factor_reproduction_area_male = 20 ;
  /**
  GET
  */
  short get_ID() { 
    return ID ; 
  }
  int get_life() { 
    return life ; 
  }
  Genome get_genome() { 
    return genome ;
  }
  boolean get_alive() { 
    return alive ;
  }
  vec3 get_size() { 
    return size ; 
  }
  int get_stamina() { 
    return stamina ; 
  }

  int get_mass() { 
    return mass ; 
  }

  float get_density() { 
    return density ; 
  }

  vec3 get_pos() { 
    return pos ;
  }

 /**
  get home
  */
  vec4 get_home() { 
    return home ;
  }

  vec3 get_home_pos() { 
    if(home != null) return vec3(home.x, home.y, home.z) ; else return null ;
  }

  int get_home_id() { 
    if(home != null) return (int)home.w ; else return -1 ;
  }

  
  /**
  get style
  */
  Costume get_costume() { 
    return costume; 
  }
  vec4 get_fill_style() { 
    return fill_style ; 
  }
  vec4 get_stroke_style() { 
    return stroke_style ; 
  }
  float get_thickness() { 
    return thickness ; 
  }

  vec4 get_melanin() { 
    return first_colour ; 
  }

  vec4 get_first_colour() { 
    return first_colour ; 
  }
  vec4 get_second_colour() { 
    return second_colour ; 
  }
  vec4 get_third_colour() { 
    return third_colour ; 
  }


  /**
  get alpha
  */
  int get_alpha_cursor() {
    return alpha_cursor ;
  }
  float get_alpha_back() {
    return alpha_back ;
  }
  float get_alpha_front() {
    return alpha_front ;
  }


  /**
  set reproduction
  */
  void set_maturity(int maturity) {
    this.maturity = int(maturity) ;
  }

  void set_fertility_cycle(int fertility_cycle) {
    this.fertility_cycle = int(fertility_cycle) ;
  }

  void set_fertility_time(int fertility_time) {
    this.fertility_time_ref = int(fertility_time) ;
  }

  void set_pregnant_term(int pregnant_term) {
    this.pregnant_term = int(pregnant_term) ;
  }
  
  void set_fertility_rate(int rate) {
    this.fertility_rate = rate ;
  }

  void set_reproduction_area(int reproduction_area) {
    this.reproduction_area = reproduction_area ;
  }


  /**
  set feeding
  */
  void set_gourmet(float gourmet) {
    this.gourmet = abs(gourmet) +1.1 ;
  }

  void set_nutrient_quality(int nutrient_quality) {
    this.nutrient_quality = nutrient_quality ;
  }

  void set_speed_feeding(int speed_feeding) {
    this.speed_feeding = 1 ;
  }


  /**
  set aspect
  */
  void set_aspect(vec4 fill_style, vec4 stroke_style, float thickness) {
    this.fill_style.set(fill_style) ;
    this.stroke_style.set(stroke_style) ;
    this.thickness = thickness ;
  }

  void set_fill(vec4 fill_style) {
    this.fill_style.set(fill_style) ;
  }

  void set_stroke(vec4 stroke_style) {
    this.stroke_style.set(stroke_style) ;
  }

  void set_thickness(float thickness) {
    this.thickness = thickness ;
  }


  // void set_alpha(int alpha_cursor, float alpha_back, float alpha_front) {
  void set_alpha(vec3 alpha_behavior) {
    this.alpha_cursor = (int)alpha_behavior.x ;
    this.alpha_back = abs(alpha_behavior.y) ;
    this.alpha_front = alpha_behavior.z ;
  }

  /**
  set caracteristic
  */
  void set_density(float density) {
    this.density = density ;
  }

  void set_size(int size) {
    if(this.size != null) {
      this.size = vec3(size) ;
    } else this.size.set(size) ;
  }

  void set_size(vec3 size) {
    if(this.size != null) {
      this.size = vec3(size) ;
    } else this.size.set(size) ;
  }

  void set_life(int life_expectancy) {
    this.life_expectancy = life_expectancy ;
  }


  /**
  set misc
  */
  void set_ID(short ID) {
    this.ID = ID ;
  }

  void set_alive(boolean alive) {
    this.alive = alive ;
  }





  /**
  METHOD
  */
    /**
  reproduction method

  */
  void fertility(int time) {
    if(time%fertility_cycle == 0 && !pregnant) {
      fertility = fertility?false:true ;
    }
    if(fertility && fertility_time > 0 ) fertility_time-- ;
    if(fertility_time <= 0) {
      fertility_time = fertility_time_ref ;
      fertility = false ;
    }
  }

  void reproduction() {
    pregnant = true ;
    fertility = false ;
    pregnant_time = pregnant_term ;
  }
  
  
  void pregnant() {
    if(pregnant_time > 0 && pregnant) pregnant_time-- ;
  }
  
  boolean birth() {
    if(pregnant_time <= 0 && pregnant) {
      pregnant = false ;
      return true ;
    } else return false ;
  }


  /**
  growth

  */
  void growth() {
    age() ;
    life() ;
    if(life < 0 || stamina <= 0) {
      alive = false ;
    }
    
    if(stamina <= 0) {
      stamina = 0 ;
    }
    if(stamina > stamina_ref) {
      stamina = stamina_ref ;
    }
  }

  
  /**
  life statement
  */
  void life() {
    life-- ;
  }

  void age() {
    age++ ;
  }

  /**
  maturity
  */

  void maturity() {
    if(maturity > 0) maturity-- ;
  }


  /**
  ASPECT
  */
  void aspect(float thickness) {
    if(thickness <= 0) { 
      noStroke() ;
      fill(fill_style) ;
    } else { 
      strokeWeight(thickness) ;
      stroke(stroke_style) ;
      fill(fill_style) ;
    }
  }
  
  void aspect(vec4 c_fill, vec4 c_stroke, float thickness) {
    if(thickness <= 0) { 
      noStroke() ;
      fill(c_fill) ;
    } else { 
      strokeWeight(thickness) ;
      stroke(c_stroke) ;
      fill(c_fill) ;
    }
  }




  /**
  COSTUME
  */
  void costume() {
    this.costume.draw(pos,size,vec3());
  }

  void set_costume(Costume costume) {
    this.costume = costume;
  }

  void set_costume(int which_costume) {
    this.costume.set_type(which_costume);
  }



















  /**
  INFO


  */
  /**
  info print
  */
  void info(vec4 colour, int size_text) {
    if(starving_bool) {
      vec4 colour_starving = vec4() ;
      float ratio_speed_warning = .05 ;
      float alpha = abs(sin(frameCount *ratio_speed_warning)) ;
      colour_starving.set(colour.r, colour.g, colour.b, colour.a *alpha) ;
      info_visual(colour_info(colour_starving, satiate, pregnant, fertility)) ;
      info_text(colour_info(colour_starving, satiate, pregnant, fertility), size_text) ;
    } else {
      info_visual(colour_info(colour, satiate, pregnant, fertility)) ;
      info_text(colour_info(colour, satiate, pregnant, fertility), size_text) ;
    }

  }
  /**
  fake
  */
  void info_visual(vec4 colour) {

  }

  void info_text(vec4 colour, int size) {

  }
  



  void info_print_caracteristic() {
    println("CARACTERISTIC",this.name) ;
    println(this.name, "size", this.size) ;
    println(this.name, "life expectancy", this.life_expectancy) ;
    println(this.name, "stamina max", this.stamina_ref) ;
    println(this.name, "nutrient quality", this.nutrient_quality) ;
    println(this.name, "food exigency", this.gourmet) ;

  }

  vec4 colour_info(vec4 original_colour) {
    return colour_info(original_colour, true, false, false) ;
  }

  vec4 colour_info(vec4 original_colour, boolean satiate, boolean pregnant, boolean fertility) {
    vec4 colour = vec4(original_colour) ;
    if(!satiate) colour.z = g.colorModeZ *.5 ;
    if(pregnant) colour.y = g.colorModeY *.1 ;
    if(fertility) colour.y = g.colorModeY *.45 ;
    return colour ;
  }
}
/** 

END CLASS AGENT METHOD

*/







































/**

CLASS AGENT DYNAMIC 0.2.2
@author Stan le Punk

*/
abstract class Agent_dynamic extends Agent_model {
  /**
  target
  */
  vec2 ID_target = vec2(-1) ;
  vec3 pos_target = vec3(0) ;
  Agent target ;


  /**
  carnivore
  */
  boolean killing   ;
  int attack = 1 ;
  int kill_zone ;
  int time_track ;
  int max_time_track = int(360 *CLOCK) ;

  /**
  sense
  */
  int sense_range ;

  /**
  reproduction
  */
  int sex_appeal ;
  float multiple_pregnancy = 0 ;

  /**
  satisfaction
  */
  // int threshold_migration ;
  int level_satisfaction, level_dissatisfaction ;
  int threshold_satisfation  ;
  int threshold_dissatisfaction  ;

  /**
  Feed
  */
  int step_hunger ;
  int leptin ; // step satiating peptid coded on OB gene chromosome 7
  int hunger  ;
  int starving = 1 ;
  int eat_zone ;
 // int greed  ;
 //  int greed = int(180 *CLOCK) ; // num of frame before stop to eat :)

  float digestion = 2 ;

  //behavior
  int max_watching = 600 ;

  // STATEMENT
  boolean watching = true ;
  boolean eating ;
  boolean tracking ;
  boolean tracking_partner ;

  /**
  motion, pos, coord
  */
  vec3 motion = vec3() ;
  vec3 dir = vec3() ;
  vec3 velocity_xyz = vec3() ;
  float velocity, velocity_ref ;

  float vel_slow_4 = .1 ;
  float vel_slow_3 = .25 ;
  float vel_slow_2 = .5 ;
  float vel_slow_1 = .75 ;
  float vel_normal = 1. ;
  float vel_fast_1 = 1.25 ;
  float vel_fast_2 = 1.5 ;
  float vel_fast_3 = 2. ;
  float vel_fast_4 = 3. ;

  /**
  misc or out or real caracteristic...
  */
  // watching variable
//  int size_target_flora ;
  int time_watching = 0 ;
  // MISC
Info_Object style ;


  /**
  CONSTRUCTOR 
  Dynamic Agent from caracteristic

  @param vec3 pos, give the x,y,z coord of the agent
  @param int size, give a data to give size to the agent
  @param int life, give the life and and use to give the maximum life of the agent
  @param int stamina, give the stamina and and use to give the maximum stamina of the agent
  @param int velocity, give the maximum of motion speed of your agent.
  @param String name... no comment !
  */
  Agent_dynamic(Info_dict carac, Info_Object style, int gender) {
  // Agent_dynamic(int size, int stamina, int life_expectancy, int velocity, int sense_range, String name, vec2 sex_appeal, int gender) {
    // set aspect
    this.style = style ;
    set_aspect((vec4)style.catch_obj(1), (vec4)style.catch_obj(2), (float)style.catch_obj(3)) ;

    // catch caracteristic
    String temp_name = "Nobody" ;
    vec3 temp_size = vec3(1) ;
    float temp_density = 1 ;

    int temp_stamina = 1 ;
    int temp_velocity = 0 ;
    int temp_sense_range = 1 ;
    int temp_life_expectancy = MAX_INT ;
    int species_life_cycle = MAX_INT ;
    vec2 temp_sex_appeal = vec2(1) ;
    float temp_multiple_pregnancy = 0 ;
    
    vec4 temp_first = vec4(1) ;
    vec4 temp_second = vec4(1) ;
    vec4 temp_third = vec4(1) ;

    vec4 temp_melanin = vec4(0) ;
    //
    float range_norm = .15 ;
    //

    if (carac.get("name") != null) temp_name = (String) carac.get("name")[0].catch_obj(0) ;

    if (carac.get("size") != null && carac.get("size")[0].catch_obj(0) instanceof vec3) {
      temp_size = (vec3)carac.get("size")[0].catch_obj(0) ;
      temp_size.x = random_gaussian(temp_size.x) ;
      temp_size.y = random_gaussian(temp_size.y) ;
      temp_size.z = random_gaussian(temp_size.z) ;
    }
    if (carac.get("density") != null) temp_density = random_gaussian((int)carac.get("density")[0].catch_obj(0), range_norm) ;

    if (carac.get("stamina") != null) temp_stamina = (int) random_gaussian((int)carac.get("stamina")[0].catch_obj(0)) ;
    if (carac.get("velocity") != null) temp_velocity = (int) random_gaussian((int)carac.get("velocity")[0].catch_obj(0)) ;
    if (carac.get("sense_range") != null) temp_sense_range = (int) random_gaussian((int)carac.get("sense_range")[0].catch_obj(0)) ;
    // colour
    
    if (carac.get("first_colour") != null && carac.get("first_colour")[0].catch_obj(0) instanceof vec4) {
      temp_first = (vec4)carac.get("first_colour")[0].catch_obj(0) ;
      temp_first.x = random_gaussian(temp_first.x, range_norm) ;
      temp_first.y = random_gaussian(temp_first.y, range_norm) ;
      temp_first.z = random_gaussian(temp_first.z, range_norm) ;
      temp_first.a = random_gaussian(temp_first.a, range_norm) ;
    }
    if (carac.get("second_colour") != null && carac.get("second_colour")[0].catch_obj(0) instanceof vec4) {
      temp_second = (vec4)carac.get("second_colour")[0].catch_obj(0) ;
      temp_second.x = random_gaussian(temp_second.x, range_norm) ;
      temp_second.y = random_gaussian(temp_second.y, range_norm) ;
      temp_second.z = random_gaussian(temp_second.z, range_norm) ;
      temp_second.a = random_gaussian(temp_second.a, range_norm) ;
    }
    if (carac.get("third_colour") != null && carac.get("third_colour")[0].catch_obj(0) instanceof vec4) {
      temp_third = (vec4)carac.get("third_colour")[0].catch_obj(0) ;
      temp_third.x = random_gaussian(temp_third.x, range_norm) ;
      temp_third.y = random_gaussian(temp_third.y, range_norm) ;
      temp_third.z = random_gaussian(temp_third.z, range_norm) ;
      temp_third.a = random_gaussian(temp_third.a, range_norm) ;
    }
    // melanin
    if (carac.get("melanin") != null && carac.get("melanin")[0].catch_obj(0) instanceof vec4) {
      temp_melanin = (vec4)carac.get("melanin")[0].catch_obj(0) ;
      temp_melanin.x = random_gaussian(temp_melanin.x, range_norm) ;
      temp_melanin.y = random_gaussian(temp_melanin.y, range_norm) ;
      temp_melanin.z = random_gaussian(temp_melanin.z, range_norm) ;
      temp_melanin.a = random_gaussian(temp_melanin.a, range_norm) ;
    }

    // agent
    if (carac.get("life_expectancy") != null) temp_life_expectancy = (int) random_gaussian((int)carac.get("life_expectancy")[0].catch_obj(0)) ;
    // species
    if (carac.get("life_expectancy") != null) species_life_cycle = (int) random_gaussian((int)carac.get("life_expectancy")[0].catch_obj(0)) ;
    if (carac.get("sex_appeal") != null) {
      Object obj = carac.get("sex_appeal")[0].catch_obj(0) ;
      if(obj instanceof vec2) { 
        vec2 temp = (vec2) obj ;
        temp_sex_appeal.x = random_gaussian(temp.x);
        temp_sex_appeal.y = random_gaussian(temp.y);
      }
    }




    if(carac.get("multiple_pregnancy") != null) temp_multiple_pregnancy = random_gaussian((Float)carac.get("multiple_pregnancy")[0].catch_obj(0)) ;

    init_var_life_cycle(temp_life_expectancy, species_life_cycle, temp_size, temp_density) ;

    // genome info
    this.size = this.size_ref = this.size_max = temp_size ;
    this.density = temp_density ;
    this.mass = this.mass_ref = int((size.x +size.y +size.z) *.3 *this.density) ;

    this.stamina_ref = this.stamina = temp_stamina ;
    this.velocity = this.velocity_ref = temp_velocity ;
    this.name = temp_name ;
    this.sense_range = this.mass + temp_sense_range ;
    this.multiple_pregnancy = temp_multiple_pregnancy ;

    this.first_colour = temp_first.copy() ;
    this.second_colour = temp_second.copy() ;
    this.third_colour = temp_third.copy() ;

    this.melanin = temp_melanin.copy() ;

    this.gender = gender ;
    /**




    use 
    StringDict and floatDict





    */


    
    init_ID() ;
    init_dir() ;
    up_generation() ;

    int female_area_ratio = (int)temp_sex_appeal.x ;
    int male_area_ratio = (int)temp_sex_appeal.y ;
    set_reproduction(temp_sex_appeal) ;

    set_hunger_cycle() ;
    
    build_archetype_genome( temp_size, 
                            temp_density,
                            temp_life_expectancy,
                            temp_velocity, 
                            temp_sense_range, 
                            temp_name, 
                            temp_sex_appeal,
                            temp_multiple_pregnancy,
                            species_life_cycle,
                            temp_first,
                            temp_second,
                            temp_third,
                            temp_melanin,
                            generation,  
                            gender) ;

  }




  /**
  CONSTRUCTOR 
  Dynamic Agent from mother and father Genome
  */
  Agent_dynamic(Genome mother, Genome father, Info_Object style) {
    // aspect
    this.style = style ;
    set_aspect((vec4)style.catch_obj(1), (vec4)style.catch_obj(2), (float)style.catch_obj(3)) ;

    init_ID() ;
    init_dir() ;
    // update gene generation from mother line
    this.generation = (int)(Float.parseFloat(mother.get_gene("1").data_left_arm)) ;



    // create child genome
    genome = genotype(mother, father) ;
    // write mutation info in the genome

    

   
    
    // setting
    // chromosome String
    this.name = (String) genome.get_gene_product(1,0).catch_obj(0) ;


    // chromosome Float
    this.size = vec3((Float)genome.get_gene_product(0,0).catch_obj(0), (Float)genome.get_gene_product(0,1).catch_obj(0), (Float)genome.get_gene_product(0,2).catch_obj(0)) ;


    // generation is genome.get_gene_product(0,3).catch_obj(0)
    this.stamina_ref = this.stamina = int((Float)genome.get_gene_product(0,4).catch_obj(0));
    int life_expectancy_temp = int((Float)genome.get_gene_product(0,5).catch_obj(0)) ;

    this.velocity = this.velocity_ref = int((Float)genome.get_gene_product(0,6).catch_obj(0)) ;

    /*
    * this var is updated in the method init_var_life_cycle()
    */
    this.sense_range = int( (Float)genome.get_gene_product(0,7).catch_obj(0)) ;
    // sex appeal
    vec2 sex_appeal = vec2((Float)genome.get_gene_product(0,8).catch_obj(0), (Float)genome.get_gene_product(0,9).catch_obj(0)) ;
    // multi_pregnancy
    this.multiple_pregnancy = (Float)genome.get_gene_product(0,10).catch_obj(0) ;

    // cycle life
    int species_life_cycle = int((Float)genome.get_gene_product(0,11).catch_obj(0)) ;

    this.first_colour = vec4((Float)genome.get_gene_product(0,12).catch_obj(0), (Float)genome.get_gene_product(0,13).catch_obj(0),(Float)genome.get_gene_product(0,14).catch_obj(0), (Float)genome.get_gene_product(0,15).catch_obj(0)) ;
    this.second_colour = vec4((Float)genome.get_gene_product(0,16).catch_obj(0), (Float)genome.get_gene_product(0,17).catch_obj(0),(Float)genome.get_gene_product(0,18).catch_obj(0), (Float)genome.get_gene_product(0,19).catch_obj(0)) ;
    this.third_colour = vec4((Float)genome.get_gene_product(0,20).catch_obj(0), (Float)genome.get_gene_product(0,21).catch_obj(0),(Float)genome.get_gene_product(0,22).catch_obj(0), (Float)genome.get_gene_product(0,23).catch_obj(0)) ;

    this.melanin = vec4((Float)genome.get_gene_product(0,24).catch_obj(0), (Float)genome.get_gene_product(0,25).catch_obj(0),(Float)genome.get_gene_product(0,26).catch_obj(0), (Float)genome.get_gene_product(0,27).catch_obj(0)) ;
    
    this.density = (Float)genome.get_gene_product(0,28).catch_obj(0) ;
    
    up_generation() ;
    genome.mutation_data(0, 1, String.valueOf(generation), true, true);


    init_var_life_cycle(life_expectancy_temp, species_life_cycle, this.size, this.density) ;
    set_reproduction(sex_appeal) ;

    set_hunger_cycle() ;

    if((String) genome.get_gene_product("XX").catch_obj(0) == "X") {
      this.gender = 0  ; 
    } else { 
      this.gender = 1 ;
    }
  }




  /**
  GENOME
  */
  void build_archetype_genome(vec3 size, float density, int life_expectancy, int velocity, int sense_range, String name, vec2 sex_appeal, float multiple_pregnancy, int species_life_cycle, 
                              vec4 first_colour, vec4 second_colour, vec4 third_colour, vec4 melanin, 
                              int generation, int gender) {
    float [] data_float = new float[42] ;
    data_float[0] = size.x ;
    data_float[1] = size.y ;
    data_float[2] = size.z ;

    data_float[3] = generation ;
    data_float[4] = stamina ;
    data_float[5] = life_expectancy ;
    data_float[6] = velocity ;

    data_float[7] = sense_range ;

    data_float[8] = sex_appeal.x ;
    data_float[9] = sex_appeal.y ;

    data_float[10] = multiple_pregnancy ;
    data_float[11] = species_life_cycle ;

    data_float[12] = first_colour.x ;
    data_float[13] = first_colour.y ;
    data_float[14] = first_colour.z ;
    data_float[15] = first_colour.a ;

    data_float[16] = second_colour.x ;
    data_float[17] = second_colour.y ;
    data_float[18] = second_colour.z ;
    data_float[19] = second_colour.a ;

    data_float[20] = third_colour.x ;
    data_float[21] = third_colour.y ;
    data_float[22] = third_colour.z ;
    data_float[23] = third_colour.a ;

    data_float[24] = melanin.x ;
    data_float[25] = melanin.y ;
    data_float[26] = melanin.z ;
    data_float[27] = melanin.a ;

    data_float[28] = density ;

    String [] data_string = new String[1] ;
    data_string[0] = name ;
    genome = archetype(data_float, data_string, gender) ;
  }
















  /**
  INIT
  */
  /**
  internal setting for constructor
  based on arbitrary life cycle model
  */
  void init_var_life_cycle(int life_expectancy, int species_life_expectancy, vec3 size, float density) {

    this.life_expectancy = life_expectancy ;
    this.life = life_expectancy ;
    maturity = this.life_expectancy / 15 ;
    // we use species life expectancy to don't hava variation between the agent of same species
    fertility_cycle = species_life_expectancy / 45 ;
    fertility_time_ref = fertility_cycle / 5 ;
    pregnant_term = fertility_cycle *10  ;

    this.threshold_satisfation = this.life_expectancy /10 ;
    this.threshold_dissatisfaction = this.life_expectancy /10  ;

    this.mass = this.mass_ref = int((size.x +size.y +size.z) *.3 *density) ;

    this.sense_range = this.mass +this.sense_range ;

  }
  void init_ID() {
    this.ID = (short) Math.round(random(Short.MAX_VALUE)) ;
  }

  void up_generation() {
    this.generation++ ;
  }

  void init_dir() {
    this.dir = vec3().rand(-1,1);
  }















  /**
  SET 1.0.1
   
  */
  /**
  internal set
  */
  void set_hunger_cycle() {
    set_step_hunger(this.mass +this.stamina)  ;
    set_leptin(2.5) ;
    set_hunger(this.step_hunger *2.) ;
    if(hunger > step_hunger) satiate = true ;
  }


  void set_reproduction(vec2 sex_appeal_ratio) {
    if(this.gender == 0) {
      this.reproduction_area = this.mass *2 ; 
      this.sex_appeal = int(this.mass *sex_appeal_ratio.x) ; 
    } else if (this.gender == 1) { 
      this.reproduction_area = this.mass *2 ; 
      this.sex_appeal = int(this.mass *sex_appeal_ratio.y) ; 
    }
  }
 

  /**
  set food
 */

  void set_starving(int starving) {
    if(starving <= 0) starving = abs(starving) ;
    this.starving = starving ;
  }

  void set_step_hunger(float step_hunger) {
    if(step_hunger <= 0) step_hunger = abs(step_hunger) ;
    this.step_hunger = (int)step_hunger ;
  }

  void set_leptin(float level) {
    if(level <= 0) level = abs(level) ;
    this.leptin = int(this.step_hunger *level) ;
  }

  void set_hunger(float hunger) {
    if(hunger <= 0) hunger = abs(hunger) ;
    this.hunger = (int)hunger ;
  }



  void set_digestion(float digestion) {
    if(digestion <= 0) {
      println("Negative value, we use the absolute value.") ;
      this.digestion = abs(digestion) ;
    } else {
      this.digestion = digestion ;
    }
  }

  /**
  set motion
  */
  void set_dir(vec3 dir) {
    this.dir.set(dir) ;
  }

  void set_velocity(float velocity) {
    this.velocity = velocity ;
  }

  void set_pos(vec pos) {
    if(pos instanceof vec3) {
      vec3 temp_pos = (vec3) pos ;
      this.pos.set(temp_pos) ;
      this.motion.set(temp_pos) ;
    }
    if(pos instanceof vec2) {
      vec2 temp_pos = (vec2) pos ;
      this.pos.set(temp_pos.x, temp_pos.y,0) ;
      this.motion.set(this.pos) ;
    }
  }



  /**
  set hunting and picking
  */
  void set_watching(int  max_watching) {
    this.max_watching = max_watching ;
  }

  /**
  set carnivore
  */
  void set_kill_zone(int radius) {
    this.kill_zone = radius ;
  }

  void set_attack(int attack) {
    this.attack = attack ;
  }

  void set_max_time_track(int max) {
    this.max_time_track = int(max *CLOCK) ;
  }
  /**

  */



















  /**
  GET pos
  */
  vec3 get_pos_target() {
    return pos_target ;
  }
  vec3 get_pos() {
    return pos ;
  }
  /**

  */















/**
FOODING

COMMON HUNT & SEARCH

*/
  // follow
  void follow(Agent target) {
    if(target instanceof Agent_dynamic) {
      Agent_dynamic a = (Agent_dynamic) target ;
      pos_target.set(a.pos) ;
      dir.set(target_direction(a.pos, pos)) ;
    } else if (target instanceof Agent_static) {
      Agent_static a = (Agent_static) target ;
      pos_target.set(a.pos) ;
      dir.set(target_direction(a.pos, pos)) ;
    }
  }

  // distance to target
  float dist_to_target(Agent target) {
    float dist = MAX_INT ;
    if(target instanceof Agent_dynamic) {
      Agent_dynamic a = (Agent_dynamic) target ;
      dist = dist(a.pos, pos) ;
      if(dist < sense_range) {
        pos_target.set(a.pos) ;
      } 
    } else if(target instanceof Agent_static) {
      Agent_static a = (Agent_static) target ;
      dist = dist(a.pos, pos) ;
      if(dist < sense_range) {
        pos_target.set(a.pos) ;
      } 
    }
    return dist ;
  }
  

  // track
  void track(Agent target) {
    boolean target_alive = false ;
    if(target instanceof Agent_dynamic) {
      Agent_dynamic a = (Agent_dynamic) target ;
      target_alive = a.alive ; 
    } else {
      Agent_static a = (Agent_static) target ;
      target_alive = a.alive ; 
    }

    if(target_alive) {
      track_in_progress() ;
      follow(target) ;
    } else {
      track_stop() ;
    } 
  }

  void track_in_progress() {
    time_track += 1 ;
    tracking = true ; 
    watching = false ;
  }

  void track_stop() {
    time_track = 0 ;
    tracking = false ; 
    watching = true ;
  }

  // focus on target
  boolean focus_target(ArrayList<Agent> list_target) {
    boolean check = false ;
    int pointer = (int)ID_target.x ;
    int ID = (int)ID_target.y ;
    if(pointer >= 0 && pointer < list_target.size()) {
      target = list_target.get((int)ID_target.x) ;
      if(target.get_ID() == ID) { 
        check = true ; 
      } else {
        for(Agent target_in_list : list_target) {
          if (target_in_list.get_ID() == ID ) {
            target = target_in_list ;
            check = true ;
            break ;
          } else check = false ;
        }
      }
    } else check = false ;
    return check ;
  }









  /**
  PICKING METHOD – for the herbivore by the way :)

  */
  // dist_ref_watch_flora value is used to compare the distace with the other flora in the range sens and avoid to change target if the target is before in the list
  float dist_ref_watch_flora = MAX_INT ;
  float ratio_food_ref = 0 ;

  void watch(Flora f, ArrayList<Agent> list_target) {
    // if(time_watching < max_watching && !starving_bool) {
    if(time_watching < max_watching && !eating) {
      // change target
      if(starving_bool && focus_target(list_target)) {
        // check the previous target if there is one
        Agent target = list_target.get((int)ID_target.x) ;
        if(target instanceof Flora) {
          Flora target_flora = (Flora) target ;
          targeting(target_flora, list_target, true) ;
        }
      } else if (!starving_bool) {
        // search for target
        boolean ratio_food = false ;
        if(ratio_food_ref < ratio_food (f.mass, f.mass_ref, f.nutrient_quality, gourmet)) {
          ratio_food = true ;
        }
        targeting(f, list_target, ratio_food) ;
      } else {
        time_watching = 0 ;
      }
    }
  }


  // local method
  void targeting(Flora target, ArrayList<Agent> list_target, boolean ratio_food) {
    float dist = dist(target.pos,pos) ;
    boolean threshold_quantity = threshold_food_quantity(target.mass, target.mass_ref, gourmet) ;
    /*
    if(!watching && !eating && !satiate && !tracking) {
      int tempo = 30 ;
      printTempo(tempo, "ID:",ID, "pos x:", (int)pos.x, "y:",(int)pos.y, "z:",(int)pos.z) ;
      printTempo(tempo, "ID:",ID, "target:", target.ID) ;
      printTempo(tempo, "ID:",ID, "target pos:", (int)target.pos.x, "y:",(int)target.pos.y, "z:",(int)target.pos.z) ;
      printTempo(tempo, "ID:",ID, "target size:", (int)target.size) ;
      printTempo(tempo, "ID:",ID, "dist:",  dist) ;
      printTempo(tempo, "ID:",ID, "range:", sense_range) ;
      printTempo(tempo, "ID:",ID, "dist ref flora:", dist_ref_watch_flora) ;
      printTempo(tempo, "ID:",ID, "threshold quality:", threshold_quantity, "ratio food:", ratio_food) ;
      printTempo(tempo, "--") ;
    }
    */
    if(dist < sense_range && dist < dist_ref_watch_flora && threshold_quantity && ratio_food) {
      ID_target.set(list_target.indexOf(target), target.ID) ;
      set_target(target) ;
      tracking = true ;
    } else {
      watching = true ;
    }
  }

  void reset_watching_var() {
    dist_ref_watch_flora = MAX_INT ;
    ratio_food_ref = 0 ;
  }

  // set target
  void set_target(Flora f) {
    // make ref of the best target / pray
    ratio_food_ref = ratio_food(f.mass, f.mass_ref, f.nutrient_quality, gourmet) ;
    dist_ref_watch_flora = dist(f.pos,pos) ;
    // 
    pos_target.set(f.pos) ;
    time_watching ++ ;
    watching = false ; 
  }

















  /**
  HUNTING METHOD – for the carnivore by the way

  */
  void kill(Agent_dynamic target) {
    if(dist(target.pos,pos) < kill_zone && target.alive ) {
      pos_target.set(target.pos) ;
      target.stamina -= 1 *attack ;
    } else {
      //
    }
  }





















  /**
   FOODING, EATING, STARVING & Co 0.5.0

  */
  /**
  add stamina
  */
  void eat_flesh(Agent_static a) {
    if(dist(a.pos,pos) < eat_zone && !a.alive && threshold_food_quantity(a.mass, a.mass_ref, gourmet)) {
      pos_target.set(a.pos) ;
      float calories = a.nutrient_quality *speed_feeding *digestion ;
      a.mass -= speed_feeding ;
      a.size.sub(speed_feeding *.33) ;
      hunger += calories ;
      stamina += calories ;
      eating = true ;
    } else {
      eating = false ;
    }
  }

  void eat_veg(Flora f) {
    if(dist(f.pos,pos) < eat_zone && threshold_food_quantity(f.mass, f.mass_ref, gourmet) ) {
      pos_target.set(f.pos) ;
      float calories = f.nutrient_quality *speed_feeding *digestion ;
      f.stamina -= (speed_feeding *.01);
      f.mass -= (speed_feeding *.01) ;
      f.size.sub(speed_feeding *.0033) ;
      hunger += calories ;
      stamina += calories ;
      eating = true ;
      // re init var comparator
      reset_watching_var() ;
      dir.set(0) ;
    } else {
      eating = false ;
    }
  }

  /**
  remove stamina
  */
  // Fint starving_count ;
  void hunger() {
    // hunger state
    if(hunger < step_hunger) {
      hunger_bool = true ; 
    } else {
      hunger_bool = false ;
    }
    // starving state
    if(hunger < (step_hunger /2)) {
      starving_bool = true ;
    } else {
      starving_bool = false ;
    }

    // hunger evolution
    if(frameCount%(1 +int(frameRate *CLOCK)) == 0) {
      if (hunger <= 0) {
        stamina -= starving ;
      } else {
        hunger -= starving ;
      }
    }
  }


//  int start_eating ;
  void time_to_eat() {
    if(hunger_bool) {
      satiate = false ;
    } else {
      if (hunger > leptin) {
        satiate = true ; 
      }
    }
  }



  boolean threshold_food_quantity(float size, float size_ref, float gourmet) {
    if(size > (size_ref / gourmet) ) return true ; else return false ;
  }

  float ratio_food (float size, float size_ref, float nutrient_quality, float step) {
    return (size -(size_ref / step )) *nutrient_quality ;
  }
  /**

  */













  
  /**
  MOTION 1.0.1

  */
  void motion() {
    velocity_update() ;
    velocity_xyz.set(velocity) ;
    velocity_xyz.mult(dir) ;
    motion.add(velocity_xyz) ;
    if(ENVIRONMENT == 2 ) pos.set(motion.x, motion.y, 0) ; else if(ENVIRONMENT == 3 ) pos.set(motion.x, motion.y, motion.z) ;
  }


  void change_direction() {
    dir.set(vec3().rand(-1,1)) ;
  }


  void velocity_update() {
    float ratio = vel_normal ;
    if(starving_bool) {
     // printTempo(90, "Starving") ;
      // starving
      if(tracking) {
        ratio = vel_fast_2 *vel_slow_1 ;
      //  printTempo(90, "tracking", ratio) ;
      }
      if(watching) {
        ratio = vel_normal *vel_slow_1  ;
     //   printTempo(90, "watching", ratio) ;
      }
      if(tracking_partner) {
        ratio = vel_fast_1 *vel_slow_1  ;
     //   printTempo(90, "tracking_partner", ratio) ;
      }
      if(satiate) {
        ratio = vel_normal *vel_slow_1 ;
     //   printTempo(90, "satiate", ratio) ;
      }
    } else {
      // normal
      if(tracking) ratio = vel_fast_2 ;
      if(watching) ratio = vel_normal ;
      if(tracking_partner) ratio = vel_fast_1 ;
      if(satiate) ratio = vel_normal ;
    }
    this.velocity = this.velocity_ref *ratio ;
  }
  void rebound(vec6 limit, boolean rebound_on_limit) {
    if(ENVIRONMENT == 2 ) {
      rebound(limit.a, limit.b, limit.c, limit.d, 0, 0, rebound_on_limit) ;
    } else if(ENVIRONMENT == 3) {
      rebound(limit.a, limit.b, limit.c, limit.d, limit.e, limit.f, rebound_on_limit) ;
    }
  }
  
  void rebound(float left, float right, float top, float bottom, float front, float back, boolean rebound_on_limit) {
    vec3 pos_temp = vec3(pos.x, pos.y, pos.z);
    vec3 dir_temp = vec3(dir.x, dir.y, dir.z);
    
    if(rebound_on_limit) {
      dir_temp.set(rebound(left, right, top, bottom, front, back, pos_temp, dir_temp)) ;
      dir.set(dir_temp) ;
    } else {
      vec3 motion_temp = vec3(motion.x, motion.y,motion.z) ;
      motion_temp.set(jump(left, right, top, bottom, front, back, motion_temp)) ;
      motion.set(motion_temp) ;
    }
  }


  // rebound
  vec3 rebound(float left, float right, float top, float bottom, float front, float back, vec3 pos, vec3 dir) {
    // here we use size to have a physical rebound
    float effect = this.mass ;

    left -=effect ;
    right +=effect ;
    top -=effect ;
    bottom +=effect ;
    front -=effect;
    back +=effect;
    

    // detection x
    if(pos.x > right) {
      dir.x *= -1 ;
      pos.x = right ;
    } else if (pos.x < left) {
      dir.x *= -1 ;
      pos.x = left ;
    } 
    // detection y
    if(pos.y > bottom) {
      dir.y *= -1 ;
      pos.y = bottom ;
    } else if (pos.y < top) {
      dir.y *= -1 ;
      pos.y = top ;
    } 
    // detection z
    if(pos.z > back) {
      dir.z *= -1 ;
      pos.z = front ;
    } else if (pos.z < front) {
      dir.z *= -1 ;
      pos.z = back ;
    } 
    return vec3(dir) ;
  }

  // jump
  vec3 jump(float left, float right, float top, float bottom, float front, float back, vec3 motion) {
    // here we use sense_range to find a good jump
    int effect = this.mass ;
    // effect = 0 ;
    left -=effect ;
    right +=effect ;
    top -=effect ;
    bottom +=effect ;
    front -=effect;
    back +=effect;

    if(pos.x > right) {
      motion.x = left ;
    } else if (pos.x < left) {
      motion.x = right ;
    }
    // detection y
    if(pos.y > bottom) {
      motion.y = top ;
    } else if (pos.y < top) {
      motion.y = bottom  ;
    }
    // detection z
    if(pos.z > back) {
      motion.z = front ;
    } else if (pos.z < front) {
      motion.z = back ;
    }
    return vec3(motion) ;
  }
  /**

  */

















  /**
  STATEMENT

  */


  boolean just_after_satiate ;

  void statement() {
    int change_activity_every_frame = 300 ;

    maturity() ;
    time_to_eat() ;
    welfare() ;

    // migration
    if(starving_bool) {
      migration(change_activity_every_frame) ;
    }
    
    // chill attitude > walk time
    if(satiate) {
      float new_ratio_velocity_normalize = .5 ;
      if(just_after_satiate) { 
        chill(1, new_ratio_velocity_normalize) ;
        just_after_satiate = false ;
      }
      chill(change_activity_every_frame, new_ratio_velocity_normalize)  ;
    } else {
      velocity = velocity_ref ;
      just_after_satiate = true ;
    }

    if(!alive) dir.set(vec3(0)) ;
  }

  /**
  BEHAVIOR GLOBAL

  */
  /**
  welfare
  */
  void welfare() {
    // modify by satiating
    level_satisfaction(satiate) ;
   // if(frameCount%300 == 0 )println(ID, level_satisfaction, level_dissatisfaction) ;
  }

  void level_satisfaction(boolean satisfaction) {
    if(!satiate) {
      if(level_dissatisfaction < threshold_dissatisfaction) level_dissatisfaction++ ;
      if(level_satisfaction > 0) level_satisfaction-- ;
    } else {
      if(level_satisfaction < threshold_satisfation) level_satisfaction++ ;
      if(level_dissatisfaction > 0) level_dissatisfaction-- ;
    }
  }



  /**
  chill
  */
  void chill(int step, float ratio_speed_motion) {
    if(frameCount%step == 0) {
      // velocity = velocity_ref *ratio_speed_motion ;
      //dir.set(vec3("RANDOM", 1)) ;
      change_direction() ;
    }
  }


  /**
  migration

  */
  void migration(int step) {
    if(frameCount%step == 0) {
      change_direction() ;
    }
  }






  /**
  INFO

  */
  void info_visual(vec4 colour) {
    vec3 pos_temp = vec3(0) ;
    aspect(vec4(0), colour_info(colour, satiate, pregnant, fertility), 1) ;
    start_matrix() ;
    translate(pos) ;
    ellipse(pos_temp.x, pos_temp.y, size.x *2, size.y *2) ;
    stop_matrix() ;
  }

  void info_text(vec4 colour, int size_text) {
    aspect(colour_info(colour, satiate, pregnant, fertility), colour_info(colour, satiate, pregnant, fertility), 1) ;
    vec2 pos_text = vec2(0) ;
    start_matrix() ;
    translate(pos) ;
    textSize(size_text) ;
    textAlign(CENTER) ;
    float [] space = {0, 1.2, 2.4, 3.6 } ;
    text(name , pos_text.x, pos_text.y +(size_text *space[0])) ;
    text("Generation " + generation + " Gender " + gender, pos_text.x, pos_text.y +(size_text *space[1])) ;
    text(stamina + " " + size + " " + size_ref, pos_text.x, pos_text.y +(size_text *space[2])) ;
    if(alive) {
      if (eating) {
        text("I'm eating", pos_text.x, pos_text.y +(size_text *space[3])) ;
      } else {
        if(satiate) {
          text("I'm satiating", pos_text.x, pos_text.y +(size_text *space[3])) ;
        } else {
          text("I'm hungry", pos_text.x, pos_text.y +(size_text *space[3])) ;
        }
      }
    } else {
      if(!carrion) {
        text("I'm dead", pos_text.x, pos_text.y +(size_text *space[3])) ; 
      } else {
        text("I'm carrion", pos_text.x, pos_text.y +(size_text *space[3])) ; 
      }
    }
    stop_matrix() ;
  }

  /**
  Print

  */

  void info_print() {
    // basic Agent info
    println(this.name + " " +this.getClass().getSimpleName()) ;
    info_print_caracteristic() ;
    info_print_motion() ;
    info_print_life() ;
    info_print_feeding() ;
    info_print_hunting_picking() ;
  }


  void info_print_motion() {
    println("MOTION",this.name) ;
    println(this.ID, "velocity", this.velocity_ref) ;
    println(this.ID, "current velocity", this.velocity) ;
    println(this.ID, "position", this.pos) ;
    println(this.ID, "direction", this.dir) ;
    println(this.ID, "motion", this.motion) ;
  }


  void info_print_life() {
    println("LIFE",this.name) ;
    println(this.ID, "life", this.life) ;
    println(this.ID, "stamina", this.stamina) ;
    println(this.ID, "alive", this.alive) ;
    println(this.ID, "carrion", this.carrion) ;
  }

  void info_print_feeding() {
    println("FEED",this.name) ;
    println(this.ID, "satiate", this.satiate) ;
    println(this.ID, "eating", this.eating) ;
    println(this.ID, "hunger level", this.hunger) ;
    println(this.ID, "hunger", this.hunger_bool) ;
    println(this.ID, "starving", this.starving_bool) ;
  }

  void info_print_hunting_picking() {
    println("HUNT / PICK",this.name) ;
    println(this.ID, "watching", this.watching) ;
    println(this.ID, "tracking", this.tracking) ;
  }








  /**
  LOG 0.1.1

  */
  Table log_a_d ;
  TableRow [] tableRow_a_d ;
  Info_Object [] info_a_d  ;
  int col_num = 4 ;
  int row_num = 30 ;
  boolean log_is ;

  boolean log_is() {
    return log_is ;
  }

  // build
  void build_log() {
    log_is = true ;
    log_a_d = new Table();
    tableRow_a_d = new TableRow[row_num] ;
    info_a_d = new Info_Object [row_num] ;
    for (int i = 0 ; i < row_num ; i++) {
      tableRow_a_d[i] = log_a_d.addRow();
    }
    

    // Col
    String [] col_name = new String[col_num] ;
    col_name[0] = "Agent" ;
    col_name[1] = "value x" ;
    col_name[2] = "value y" ;
    col_name[3] = "value z" ;
    // row
    String [] row_name = new String[row_num] ;
    int rank = 0 ;
    row_name[rank++] = "Name" ;
    // row_name[rank++] = "Species" ;
    // row_name[rank++] = "ID" ;
    row_name[rank++] = "Gender" ;
    row_name[rank++] = "Generation" ;
    row_name[rank++] = "Sex appeal" ;
    row_name[rank++] = "Multiple pregnancy" ;
    row_name[rank++] = "Pregnancy" ;
    row_name[rank++] = "Children" ;
    row_name[rank++] = "Homozygous" ;
    row_name[rank++] = "Heterozygous" ;

    row_name[rank++] = "Life" ;

    row_name[rank++] = "Size" ;

    row_name[rank++] = "Stamina" ;

    row_name[rank++] = "Sense range" ;
    
    row_name[rank++] = "Velocity" ;
    row_name[rank++] = "Position" ;

    row_name[rank++] = "Satiate" ;
    row_name[rank++] = "Starving" ;
    row_name[rank++] = "Hunger" ;
    row_name[rank++] = "Leptin" ;
    row_name[rank++] = "Eating" ;

    row_name[rank++] = "Watching" ;
    row_name[rank++] = "Tracking" ;

    row_name[rank++] = "Alive" ;
    row_name[rank++] = "Carrion" ;

    row_name[rank++] = "Log sequence" ;
    buildTable(log_a_d, tableRow_a_d, col_name, row_name) ;
  } 
  
  // update
  void log(int tempo) {
    if(frameCount%tempo == 0) {
      int rank = 0 ;
      info_a_d[rank++] = new Info_Object ("Name", name, this.getClass().getSimpleName(), ID) ;
      if(gender ==0 ) info_a_d[rank++] = new Info_Object ("Gender", "Female") ; else info_a_d[rank++] = new Info_Object ("Gender", "Male") ;
      info_a_d[rank++] = new Info_Object ("Generation", generation) ;
      info_a_d[rank++] = new Info_Object ("Sex appeal", sex_appeal) ;
      info_a_d[rank++] = new Info_Object ("Multiple pregnancy", multiple_pregnancy) ;
      info_a_d[rank++] = new Info_Object ("Pregnancy", num_pregnancy) ;
      info_a_d[rank++] = new Info_Object ("Children", num_children) ;
      info_a_d[rank++] = new Info_Object ("Heterozygous", num_heterozygous) ;
      info_a_d[rank++] = new Info_Object ("Homozygous", num_homozygous) ;

      info_a_d[rank++] = new Info_Object ("Life", life, life_expectancy) ;

      info_a_d[rank++] = new Info_Object ("Size", size, size_ref) ;

      info_a_d[rank++] = new Info_Object ("Stamina", stamina, stamina_ref) ;

      info_a_d[rank++] = new Info_Object ("Sense range", sense_range) ;
      
      info_a_d[rank++] = new Info_Object ("Velocity", velocity) ;
      info_a_d[rank++] = new Info_Object ("Position", (int)pos.x, (int)pos.y, (int)pos.z) ;
      // info
      info_a_d[rank++] = new Info_Object ("Satiate", satiate) ;
      info_a_d[rank++] = new Info_Object ("Starving", starving_bool) ;
      info_a_d[rank++] = new Info_Object ("Hunger", hunger) ;
      info_a_d[rank++] = new Info_Object ("Leptin", leptin) ;
      info_a_d[rank++] = new Info_Object ("Eating", eating) ;

      info_a_d[rank++] = new Info_Object ("Watching", watching) ;
      info_a_d[rank++] = new Info_Object ("Tracking", tracking) ;

      info_a_d[rank++] = new Info_Object ("Alive", alive) ;
      info_a_d[rank++] = new Info_Object ("Carrion", carrion) ;
      
      info_a_d[rank++] = new Info_Object ("Log sequence", SEQUENCE_LOG) ;
      //
      setTable(log_a_d, tableRow_a_d, info_a_d) ;
 
      //
      saveTable(log_a_d, "log/Log_"+save_date()+"/agent/agent_specific_"+name+"/Seq_"+SEQUENCE_LOG+"_Time_"+hour()+"'"+minute()+"''"+second()+"'''/log_"+name+"_"+SEQUENCE_LOG+"_"+ID+".csv");
    }
  }
}

/**

END AGENT DYNAMIC CLASS

*/








































/**


Agent Static 0.2.1


*/
abstract class Agent_static extends Agent_model {
  /**
  specific
  */ 
  int speed_growth = 1 ;
  float need = 1. ;


  /**
  Constructor

  */
  Agent_static(vec3 pos, vec3 size, int life_expectancy, String name) {
    this.pos.set(pos) ;
    this.life_expectancy = life_expectancy ;
    this.life = life_expectancy ;
    this.name = name ;
    this.ID = (short) Math.round(random(Short.MAX_VALUE)) ;
    this.size = this.size_ref = this.size_max  = size ;
    density = 1 ;
    this.mass = this.mass_ref = int((size.x +size.y +size.z) *.3 *this.density) ;
  }

  Agent_static(Info_dict carac, Info_Object style, int gender) {
    String temp_name = "Nobody" ;
    vec3 temp_size = vec3(1) ;
    float temp_density = 1 ;

    vec4 temp_first = vec4(1) ;
    vec4 temp_second = vec4(1) ;
    vec4 temp_third = vec4(1) ;
    vec4 temp_melanin = vec4(1) ;
    // 
    float range_norm = .15 ;
    // 

    this.ID = (short) Math.round(random(Short.MAX_VALUE)) ;
    if (carac.get("name") != null) temp_name = (String) carac.get("name")[0].catch_obj(0) ;

    if (carac.get("size") != null && carac.get("size")[0].catch_obj(0) instanceof vec3) {
      temp_size = (vec3)carac.get("size")[0].catch_obj(0) ;
      temp_size.x = random_gaussian(temp_size.x) ;
      temp_size.y = random_gaussian(temp_size.y) ;
      temp_size.z = random_gaussian(temp_size.z) ;
    }
    if (carac.get("density") != null) temp_density = random_gaussian((int)carac.get("density")[0].catch_obj(0), range_norm) ;

    
    if (carac.get("first_colour") != null) {
      temp_first = (vec4)carac.get("first_colour")[0].catch_obj(0) ;
      temp_first.x = random_gaussian(temp_first.x, range_norm) ;
      temp_first.y = random_gaussian(temp_first.y, range_norm) ;
      temp_first.z = random_gaussian(temp_first.z, range_norm) ;
      temp_first.a = random_gaussian(temp_first.a, range_norm) ;
    }
    if (carac.get("second_colour") != null) {
      temp_second = (vec4)carac.get("second_colour")[0].catch_obj(0) ;
      temp_second.x = random_gaussian(temp_second.x, range_norm) ;
      temp_second.y = random_gaussian(temp_second.y, range_norm) ;
      temp_second.z = random_gaussian(temp_second.z, range_norm) ;
      temp_second.a = random_gaussian(temp_second.a, range_norm) ;
    }
    if (carac.get("third_colour") != null) {
      temp_third = (vec4)carac.get("second_colour")[0].catch_obj(0) ;
      temp_third.x = random_gaussian(temp_third.x, range_norm) ;
      temp_third.y = random_gaussian(temp_third.y, range_norm) ;
      temp_third.z = random_gaussian(temp_third.z, range_norm) ;
      temp_third.a = random_gaussian(temp_third.a, range_norm) ;
    }

     // melanin
    if (carac.get("melanin") != null && carac.get("melanin")[0].catch_obj(0) instanceof vec4) {
      temp_melanin = (vec4)carac.get("melanin")[0].catch_obj(0) ;
      temp_melanin.x = random_gaussian(temp_melanin.x, range_norm) ;
      temp_melanin.y = random_gaussian(temp_melanin.y, range_norm) ;
      temp_melanin.z = random_gaussian(temp_melanin.z, range_norm) ;
      temp_melanin.a = random_gaussian(temp_melanin.a, range_norm) ;
    }

    this.name = temp_name ;
    this.size = this.size_ref = this.size_max = temp_size ;
    this.density = temp_density ;
    this.mass = this.mass_ref = int((size.x +size.y +size.z) *.3 *this.density) ;

    this.first_colour = temp_first.copy() ;
    this.second_colour = temp_second.copy() ;
    this.third_colour = temp_third.copy() ;

    this.gender = gender ;
  }
  
  /**
  set position
  * set_pos(arg) is not in the abstract class because for the dynamic agent the method is specific.
  */
  void set_pos(vec pos) {
    if(pos instanceof vec3) {
      vec3 temp_pos = (vec3) pos ;
      this.pos.set(temp_pos) ;
    }
    if(pos instanceof vec2) {
      vec2 temp_pos = (vec2) pos ;
      this.pos.set(temp_pos.x, temp_pos.y,0) ;
    }
  }

  /**
  carrion
  */

  void carrion() {
    int threshold = 2 ;
    if(!alive) {
      dead_since += int(1. *CLOCK) ;
      if(this.mass < this.mass_ref / threshold || dead_since > TIME_TO_BE_CARRION) carrion = true ; 
      else carrion = false ;
    } 
  }

  /**
  info
  */
  void info_text(vec4 colour, int size_text) {
    aspect(colour, colour, 1) ;
    vec2 pos_text = vec2(0) ;
    start_matrix() ;
    translate(pos) ;
    textSize(size_text) ;
    textAlign(CENTER) ;
    text(name, pos_text.x, pos_text.y) ;
    text(stamina + " " + mass + " " + mass_ref, pos_text.x, pos_text.y +(size_text *1.2) ) ;
    textSize(16) ;
    if(alive) {
      text("I'm alive", pos_text.x, pos_text.y +(size_text *2.4) ) ;
    } else {
      text("I'm dead", pos_text.x, pos_text.y +(size_text *2.4) ) ;
    }
    stop_matrix() ;
  }
}
/**
END Agent Static
*/
