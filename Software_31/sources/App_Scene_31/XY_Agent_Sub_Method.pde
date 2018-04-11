/**

DYNAMIC SUB METHOD 
V 0.1

*/
/**
METHOD HERBIVORE 1.0.1

*/
/**
build herbivore method 0.0.5
*/
void build_herbivore(ArrayList<Agent> list,  Info_dict carac, Info_Object style, int num) {
  int gender = 0 ;
  for(int i = 0 ; i < num ; i++) {
    if(gender > 1) gender = 0 ;
    String name = "human" ;
    if(ENVIRONMENT == 2 ) {
      Vec2 pos = Vec2("RANDOM RANGE",(int)LIMIT.a, (int)LIMIT.b, (int)LIMIT.c, (int)LIMIT.d) ;
      add_herbivore(list, pos, carac, gender, style) ;
    } else {
      Vec3 pos = Vec3("RANDOM RANGE",(int)LIMIT.a, (int)LIMIT.b, (int)LIMIT.c, (int)LIMIT.d, (int)LIMIT.e, (int)LIMIT.f) ;
      add_herbivore(list, pos, carac, gender, style) ;
    }
    gender++ ;
  }
}

/**
add method
*/
void add_herbivore(ArrayList<Agent> list, Vec2 pos, Info_dict carac, int gender, Info_Object style) {
   Vec3 final_pos = Vec3(pos) ;
   add_herbivore(list, final_pos, carac, gender, style) ;
}

void add_herbivore(ArrayList<Agent> list, Vec3 pos, Info_dict carac, int gender, Info_Object style) {
  Agent h = new Herbivore(carac, style, gender) ;
  list.add(h) ;
  set_herbivore(h, pos, carac, style) ;
}

/**
set herbivore
*/
// set born
void set_herbivore(Agent a, Vec3 pos, Info_dict carac, Info_Object style) {
  float gourmet = (float) carac.get("gourmet")[0].catch_obj(0) ;
  int nutrient_quality = (int) carac.get("nutrient_quality")[0].catch_obj(0) ;
  int starving = (int) carac.get("starving")[0].catch_obj(0) ;
  float digestion = (float) carac.get("digestion")[0].catch_obj(0) ;

  a.set_costume((int)style.catch_obj(0)) ;
  a.set_fill((Vec4)style.catch_obj(1)) ;
  a.set_stroke((Vec4)style.catch_obj(2)) ;
  a.set_thickness((float)style.catch_obj(3)) ;
  a.set_alpha((Vec3)style.catch_obj(4)) ;
  a.set_pos(pos) ;
  a.set_nutrient_quality(nutrient_quality) ;

  if(a instanceof Agent_dynamic) {
    Agent_dynamic a_d = (Agent_dynamic) a ;
    a_d.set_starving(starving) ;
    a_d.set_gourmet(gourmet) ;
    a_d.set_digestion(digestion) ;
  }
}

// set colour
boolean original_herbivore_aspect = true ;
Vec4 fill_colour_herbivore, stroke_colour_herbivore ;
float thickness_herbivore ; 

void set_aspect_herbivore(Vec4 fill_colour, Vec4 stroke_colour, float thickness) {
  original_herbivore_aspect = false ;
  if(fill_colour_herbivore == null) fill_colour_herbivore = Vec4(fill_colour) ; else fill_colour_herbivore.set(fill_colour) ;
  if(stroke_colour_herbivore == null) stroke_colour_herbivore = Vec4(stroke_colour) ; else stroke_colour_herbivore.set(stroke_colour) ;
  thickness_herbivore = thickness ;
}
/**
Reproduction specific part for each species
*/
/**
Female Reproduction
*/
void reproduction_female_herbivore(ArrayList<Agent> list_female, ArrayList<Agent> list_male, ArrayList<Agent> list_child, Info_dict carac, Info_Object style) {
  //int count_female_fertile = 0 ;
  for (Agent female : list_female) {
    if(female instanceof Agent_dynamic) {
      Agent_dynamic f = (Agent_dynamic) female ;
      f.fertility(frameCount) ;
      if(f.fertility) {
        // count_female_fertile++ ;
        if (check_male_reproducer(female, list_male)) {
          f.reproduction() ;
        }
      } 
      f.pregnant() ;

      if(f.birth()) {
        delivery(f, f.genome, f.genome_father, list_child, carac, style) ;
      }
    }
  }
}
/**
HERBIVORE update 0.1.1
*/
void herbivore_update(ArrayList<Dead> list_dead, ArrayList<Agent>... all_list) {
  for(ArrayList list : all_list) {
    update_die(list_dead, list) ;
    update_growth(list) ;
    update_motion(list) ;
    update_statement(list) ;
    if(LOG_ECOSYSTEM) update_log(list, FRAME_RATE_LOG) ;
  }
}
/**
HERBIVORE METHOD END

*/













/**
OMNIVORE METHOD 1.0.0

*/
/**
Build Omnivore 0.0.1

*/
void build_omnivore(ArrayList<Agent> list, Info_dict carac, Info_Object style, int num) {
  int gender = 0 ;
  for(int i = 0 ; i < num ; i++) {
    if(gender > 1) gender = 0 ;
    if(ENVIRONMENT == 2 ) {
      Vec2 pos = Vec2("RANDOM RANGE",(int)LIMIT.a, (int)LIMIT.b, (int)LIMIT.c, (int)LIMIT.d) ;
      // add_omnivore(list_h, pos, carac.get("size"), carac.get("stamina"), carac.get("life"), carac.get("velocity"), carac.get("sense_range"), name, gender, carac.get("nutrient_quality"), colour) ;
      add_omnivore(list, pos, carac, gender, style) ;
    } else {
      Vec3 pos = Vec3("RANDOM RANGE",(int)LIMIT.a, (int)LIMIT.b, (int)LIMIT.c, (int)LIMIT.d, (int)LIMIT.e, (int)LIMIT.f) ;
      add_omnivore(list, pos, carac, gender, style) ;
    }
    gender++ ;
  }
}

void add_omnivore(ArrayList<Agent> list, Vec2 pos, Info_dict carac, int gender, Info_Object style) {
   Vec3 final_pos = Vec3(pos) ;
   add_omnivore(list, final_pos, carac, gender, style) ;
}

void add_omnivore(ArrayList<Agent> list, Vec3 pos, Info_dict carac, int gender, Info_Object style) {
  // send data to constructor
  // Agent o = new Omnivore(size, stamina, life_expectancy, velocity, sense_range, name, sex_appeal, gender) ;
  Agent o = new Omnivore(carac, style, gender) ;

  list.add(o) ;
  set_omnivore(o, pos, carac, style) ;
}

/**
local method
*/
/**
set
*/
void set_omnivore(Agent a, Vec3 pos, Info_dict carac, Info_Object style) {
  int attack = (int) carac.get("attack")[0].catch_obj(0) ;
  float gourmet = (float) carac.get("gourmet")[0].catch_obj(0) ;
  int nutrient_quality = (int) carac.get("nutrient_quality")[0].catch_obj(0) ;
  int starving = (int) carac.get("starving")[0].catch_obj(0) ;
  float digestion = (float) carac.get("digestion")[0].catch_obj(0) ;

  a.set_costume((int)style.catch_obj(0)) ;
  a.set_fill((Vec4)style.catch_obj(1)) ;
  a.set_stroke((Vec4)style.catch_obj(2)) ;
  a.set_thickness((float)style.catch_obj(3)) ;
  a.set_pos(pos) ;
  a.set_nutrient_quality(nutrient_quality) ;

  if(a instanceof Agent_dynamic) {
    Agent_dynamic a_d = (Agent_dynamic) a ;
    a_d.set_attack(attack) ;
    a_d.set_gourmet(gourmet) ;
    a_d.set_starving(starving) ;
    a_d.set_digestion(digestion) ;
    // set_omnivore(n_a, pos, nutrient_quality, colour) ;
  }
}


/**
Female Reproduction
*/
void reproduction_female_omnivore(ArrayList<Agent> list_female, ArrayList<Agent> list_male, ArrayList<Agent> list_child, Info_dict carac, Info_Object style) {
  // int count_female_fertile = 0 ;
  for (Agent female : list_female) {
    if(female instanceof Agent_dynamic) {
      Agent_dynamic f = (Agent_dynamic) female ;
      f.fertility(frameCount) ;
      if(f.fertility) {
        // count_female_fertile++ ;
        if (check_male_reproducer(female, list_male)) {
          f.reproduction() ;
        }
      } 
      f.pregnant() ;

      if(f.birth()) {
        delivery(f, f.genome, f.genome_father, list_child, carac, style) ;
      }
    }
  }
}

/**
Omnivore update 0.0.1
*/

void omnivore_update(ArrayList<Dead> list_dead, ArrayList<Agent>... all_list) {
  for(ArrayList list : all_list) {
    update_die(list_dead, list) ;
    update_growth(list) ;
    update_motion(list) ;
    update_statement(list) ;
    if(LOG_ECOSYSTEM) update_log(list, FRAME_RATE_LOG) ;
  }
}
/**
OMNIVORE METHOD END

*/












/**
CARNIVORE METHOD 1.0.0

*/
/**
CARNIVORE build 0.1.0
*/
void build_carnivore(ArrayList<Agent> list, Info_dict carac, Info_Object style, int num) {
  int gender = 0 ;
  for(int i = 0 ; i < num ; i++) {
    if(gender > 1) gender = 0 ;
    String name = "ALIEN" ;
    if(ENVIRONMENT == 2 ) {
      Vec2 pos = Vec2("RANDOM RANGE",(int)LIMIT.a, (int)LIMIT.b, (int)LIMIT.c, (int)LIMIT.d) ;
      add_carnivore(list, pos, carac, gender, style) ;
    } else {
      Vec3 pos = Vec3("RANDOM RANGE",(int)LIMIT.a, (int)LIMIT.b, (int)LIMIT.c, (int)LIMIT.d, (int)LIMIT.e, (int)LIMIT.f) ;
      add_carnivore(list, pos, carac, gender, style) ;
    }
    gender++ ;
  }
}

void add_carnivore(ArrayList<Agent> list, Vec2 pos, Info_dict carac, int gender, Info_Object style) {
   Vec3 final_pos = Vec3(pos) ;
   add_carnivore(list, final_pos, carac, gender, style) ;
}
void add_carnivore(ArrayList<Agent> list, Vec3 pos, Info_dict carac, int gender, Info_Object style) {
    // recover data
    /*
  String name = (String) carac.get("name")[0].catch_obj(0) ;
  int size = (int) carac.get("size")[0].catch_obj(0) ;
  int stamina = (int)carac.get("stamina")[0].catch_obj(0) ;
  int velocity = (int)carac.get("velocity")[0].catch_obj(0) ;
  int sense_range = (int) carac.get("sense_range")[0].catch_obj(0) ;
  int life_expectancy =(int) carac.get("life_expectancy")[0].catch_obj(0) ;
  Vec2 sex_appeal = (Vec2)carac.get("sex_appeal")[0].catch_obj(0) ;
  */
  // send data to constructor
  // Agent c = new Carnivore(size, stamina, life_expectancy, velocity, sense_range, name, sex_appeal, gender) ;
  Agent c = new Carnivore(carac, style, gender) ;
  list.add(c) ;
  set_carnivore(c, pos, carac, style) ;

}

void set_carnivore(Agent c, Vec3 pos, Info_dict carac, Info_Object style) {
  int nutrient_quality = (int) carac.get("nutrient_quality")[0].catch_obj(0) ;
  int attack = (int) carac.get("attack")[0].catch_obj(0) ;
  float gourmet = (float) carac.get("gourmet")[0].catch_obj(0) ;
  int starving = (int) carac.get("starving")[0].catch_obj(0) ;
  float digestion = (float) carac.get("digestion")[0].catch_obj(0) ;

  c.set_costume((int)style.catch_obj(0)) ;
  c.set_fill((Vec4)style.catch_obj(1)) ;
  c.set_stroke((Vec4)style.catch_obj(2)) ;
  c.set_thickness((float)style.catch_obj(3)) ;
  c.set_pos(pos) ;
  c.set_nutrient_quality(nutrient_quality) ;

  if(c instanceof Agent_dynamic) {
    Agent_dynamic a_d = (Agent_dynamic) c ;
    a_d.set_attack(attack) ;
    a_d.set_gourmet(gourmet) ;
    a_d.set_starving(starving) ;
    a_d.set_digestion(digestion) ;
  }
}

/**
set colour carnivore
*/
boolean original_carnivore_aspect = true ;
Vec4 fill_colour_carnivore, stroke_colour_carnivore ;
float thickness_carnivore ; 
void set_aspect_carnivore(Vec4 fill_colour, Vec4 stroke_colour, float thickness) {
  original_carnivore_aspect = false ;
  if(fill_colour_carnivore == null) fill_colour_carnivore = Vec4(fill_colour) ; else fill_colour_carnivore.set(fill_colour) ;
  if(stroke_colour_carnivore == null) stroke_colour_carnivore = Vec4(stroke_colour) ; else stroke_colour_carnivore.set(stroke_colour) ;
  thickness_carnivore = thickness ;
}

/**
Female Reproduction
*/
void reproduction_female_carnivore(ArrayList<Agent> list_female, ArrayList<Agent> list_male, ArrayList<Agent> list_child, Info_dict carac, Info_Object style) {
  // int count_female_fertile = 0 ;
  for (Agent female : list_female) {
    if(female instanceof Agent_dynamic) {
      Agent_dynamic f = (Agent_dynamic) female ;
      f.fertility(frameCount) ;
      if(f.fertility) {
        // count_female_fertile++ ;
        if (check_male_reproducer(female, list_male)) {
          f.reproduction() ;
        }
      } 
      f.pregnant() ;

      if(f.birth()) {
        delivery(f, f.genome, f.genome_father, list_child, carac, style) ;
      }
    }
  }
}

/**
CARNIVORE update 0.2.0
*/
void carnivore_update(ArrayList<Dead> list_dead, ArrayList<Agent>... all_list) {
  for(ArrayList list : all_list) {
    update_die(list_dead, list) ;
    update_growth(list) ;
    update_motion(list) ;
    update_statement(list) ;
    if(LOG_ECOSYSTEM) update_log(list, FRAME_RATE_LOG) ;
  }
}
/**
CARNIVORE METHOD END

*/









/**
BACTERIUM METHOD

*/
/**
BUILD BACTERIUM 0.1.0
*/
void build_bacterium(ArrayList<Agent> list, Info_dict carac, Info_Object style, int num) {
  for(int i = 0 ; i < num ; i++) {
    String name = "bacterium" ;
    if(ENVIRONMENT == 2 ) {
      Vec2 pos = Vec2("RANDOM RANGE",(int)LIMIT.a, (int)LIMIT.b, (int)LIMIT.c, (int)LIMIT.d) ;
      add_bacterium(list, pos, carac, style) ;
    } else {
      Vec3 pos = Vec3("RANDOM RANGE",(int)LIMIT.a, (int)LIMIT.b, (int)LIMIT.c, (int)LIMIT.d, (int)LIMIT.e, (int)LIMIT.f) ;
      add_bacterium(list, pos, carac, style) ;
    }
  }
}

void add_bacterium(ArrayList<Agent> list, Vec2 pos, Info_dict carac, Info_Object style) {
  Vec3 final_pos = Vec3(pos) ; // in case 2D world
  add_bacterium(list, final_pos, carac, style) ;
}

void add_bacterium(ArrayList<Agent> list, Vec3 pos, Info_dict carac, Info_Object style) {
  int gender = 0 ;
  Agent b = new Bacterium(carac, style, gender) ;
  list.add(b) ;
  set_bacterium(b, pos, carac, style) ;
}




void set_bacterium(Agent b, Vec3 pos, Info_dict carac, Info_Object style) {
  float digestion = (float) carac.get("digestion")[0].catch_obj(0) ;
  int starving = (int) carac.get("starving")[0].catch_obj(0) ;
  int nutrient_quality = (int) carac.get("nutrient_quality")[0].catch_obj(0) ;
  
  b.set_costume((int)style.catch_obj(0)) ;
  b.set_fill((Vec4)style.catch_obj(1)) ;
  b.set_stroke((Vec4)style.catch_obj(2)) ;
  b.set_thickness((float)style.catch_obj(3)) ;
  b.set_pos(pos) ;
  b.set_nutrient_quality(nutrient_quality) ;

  if(b instanceof Agent_dynamic) {
    Agent_dynamic a_d = (Agent_dynamic) b ;
    a_d.set_digestion(digestion) ;
    a_d.set_starving(starving) ;
  }
}



/**
set colour bacterium
*/
boolean original_bacterium_aspect = true ;
Vec4 fill_colour_bacterium, stroke_colour_bacterium ;
float thickness_bacterium ; 
void set_aspect_bacterium(Vec4 fill_colour, Vec4 stroke_colour, float thickness) {
  original_bacterium_aspect = false ;
  if(fill_colour_bacterium == null) fill_colour_bacterium = Vec4(fill_colour) ; else fill_colour_bacterium.set(fill_colour) ;
  if(stroke_colour_bacterium == null) stroke_colour_bacterium = Vec4(stroke_colour) ; else stroke_colour_bacterium.set(stroke_colour) ;
  thickness_bacterium = thickness ;
}

/**
Bacterium update 0.1.1
*/
void bacterium_update(ArrayList<Dead> list_dead, ArrayList<Agent> list,  Biomass biomass, boolean info) {
  update_die(list_dead, list) ;
  update_motion(list) ;
  update_statement(list) ;
  bacterium_update_feed(list_dead, list, biomass, info) ;
  if(LOG_ECOSYSTEM) update_log(list, FRAME_RATE_LOG) ;
}

/**
show bacterium specific method
*/
void show_bacterium(Biomass biomass, Info_Object style, ArrayList<Agent>... all_list) {
  for(ArrayList list : all_list) {
    if(INFO_DISPLAY_AGENT) {
      info_agent(list) ;
      info_agent_track_line(list) ;
    } else {
      update_aspect(style, list) ;
    }
  }
}

/**
Bacterium update
*/
void bacterium_update_feed(ArrayList<Dead> list_dead_body, ArrayList<Agent> list_b, Biomass biomass, boolean info) {
  for(Agent a : list_b) {
    if(a instanceof Bacterium) {
      Bacterium b = (Bacterium) a ;
      if(!b.satiate && list_dead_body.size() >= 0) {
        hunt_dead_agent(b, list_dead_body, info) ;
      }
      if(list_dead_body.size() >= 0 ) {
        eat_corpse(b, list_dead_body, biomass, info) ; 
      } else { 
        b.eating = false ;
      }
      b.hunger() ;
    }
  }
}


/**
local method
*/
void eat_corpse(Bacterium b, ArrayList<Dead> list_target, Biomass biomass, boolean info) {
// first eat the agent who eat just before without look in the list
  if(b.eating) {
    int pointer = (int)b.ID_target.x ;
    int ID_target = (int)b.ID_target.y ;
    /* here we point directly in a specific point of the list, 
    if the pointer is superior of the list, 
    because if it's inferior a corpse can be eat by an other Agent */
    if(pointer < list_target.size() ) {
      Agent target = list_target.get((int)b.ID_target.x) ;
      /* if the entry point of the list return an agent 
      with a same ID than a ID_target corpse eat just before, 
      the Carnivore can continue the lunch */
      if (target instanceof Agent_static && target.get_ID() == ID_target) {
        Agent_static target_meat = (Agent_static) target ;
        b.eat(target_meat, info) ;
        biomass.humus_update(b.get_humus_production()) ;
        //biomass.humus += b.get_humus_production() ;
      } else {
        /* If the ID returned is different, a corpse was leave from the list, 
        and it's necessary to check in the full ist to find if any corpse have a seme ID */
        for(Agent target_in_list : list_target) {
          if (target_in_list instanceof Agent_static && target_in_list.get_ID() == ID_target ) {
            Agent_static target_meat = (Agent_static) target_in_list ;
            b.eat(target_meat, info) ; 
          } else b.eating = false ;
        }
      }
    }
  /* If the last research don't find the corpse, may be this one is return to dust ! */
  } else {
    for(Agent target : list_target) {
      if(target instanceof Agent_static) {
        Agent_static target_meat = (Agent_static) target ;
        b.eat(target_meat, info) ;
      }

      if(b.eating) {
        b.ID_target.set(list_target.indexOf(target),target.get_ID()) ;
        break ;
      }
    }
  }
}


void hunt_dead_agent(Bacterium b, ArrayList<Dead> list_target, boolean info) {
  for(Agent target : list_target) {
    if(target instanceof Agent_static) {
      Agent_static target_dead = (Agent_static) target ;
      b.watch(target_dead, info) ;
      b.pick(target_dead) ;
      if(b.picking()) break ;
    }
  }
}
/**
BACTERIUM METHOD END

*/
/**

DYNAMIC METHOD END

*/








































/**

STATIC SUB METHOD 

*/
/**
METHOD FLORA 1.1.0

*/
/**
build 0.2.0
*/
// main method
void build_flora(ArrayList<Agent> list_f, Info_dict carac, Info_Object style, int num) {
  for(int i = 0 ; i < num ; i++) {
    if(ENVIRONMENT == 2 ) {
      Vec2 pos = Vec2("RANDOM RANGE",(int)LIMIT.a, (int)LIMIT.b, (int)LIMIT.c, (int)LIMIT.d) ;
      add_flora(list_f, pos, carac, style) ;
    } else if (ENVIRONMENT == 3 ) {
      Vec3 pos = Vec3("RANDOM RANGE",(int)LIMIT.a, (int)LIMIT.b, (int)LIMIT.c, (int)LIMIT.d, (int)LIMIT.e, (int)LIMIT.f) ;
      add_flora(list_f, pos, carac, style) ;
    }
  }
}

void build_flora(ArrayList<Agent> list_f, Info_dict carac, Info_Object style, int num, Vec... area) {
  println("num", num, "area length", area.length) ;
  for(int i = 0 ; i < num ; i++) {
    // it's not possible to give home to everybody, sorry
    if(i < area.length) {
      if(ENVIRONMENT == 2) {
        if(area[i] instanceof Vec2) {
          Vec2 spawn_pos = (Vec2) area[i] ;
          add_flora(list_f, spawn_pos, carac, style) ;
        }
        if(area[i] instanceof Vec3) {
          Vec3 spawn_pos = (Vec3) area[i] ;
          add_flora(list_f, Vec2(spawn_pos.x, spawn_pos.y), carac, style) ;
        } else {
          System.err.println("Arg area in not an instance of Vec2 or Vec3, no agent can be add") ;
        }  
      } else if (ENVIRONMENT == 3) {
        if(area[i] instanceof Vec2) {
          Vec2 spawn_pos = (Vec2) area[i] ;
          add_flora(list_f, Vec3(spawn_pos.x, spawn_pos.y, 0), carac, style) ;
        }
        if(area[i] instanceof Vec3) {
          Vec3 spawn_pos = (Vec3) area[i] ;
          add_flora(list_f, spawn_pos, carac, style) ;
        } else {
          System.err.println("Arg area in not an instance of Vec2 or Vec3, no agent can be add") ;
        } 
      }
    // it's not possible to give home to everybody, sorry
    } else {
      System.err.println("the population is above the home place") ;
    }
  }
}


// annexe methode
// add
void add_flora(ArrayList<Agent> list_f, Vec2 pos, Info_dict carac, Info_Object style) {
   Vec3 final_pos =  Vec3(pos.x,pos.y,0) ;
   add_flora(list_f, final_pos, carac, style) ;
}
void add_flora(ArrayList<Agent> list_f, Vec3 pos, Info_dict carac, Info_Object style) {
    // recover data
  String name = (String) carac.get("name")[0].catch_obj(0) ;
  Vec3 size_template = (Vec3) carac.get("size")[0].catch_obj(0) ;
  int life_expectancy = (int) carac.get("life_expectancy")[0].catch_obj(0) ;

  float s_x = random(ceil(size_template.x *.5), ceil(size_template.x *3)) ;
  float s_y = random(ceil(size_template.y *.5), ceil(size_template.y *3)) ;
  float s_z = random(ceil(size_template.z *.5), ceil(size_template.z *3)) ;
  Vec3 size = Vec3(s_x, s_y, s_z) ;

  int nutrient_quality = (int) carac.get("nutrient_quality")[0].catch_obj(0) ;
  int speed_growth = (int) carac.get("speed_growth")[0].catch_obj(0) ;
  float need = (Float) carac.get("need")[0].catch_obj(0) ;

  Flora f = new Flora(pos, size, life_expectancy, name) ;
   list_f.add(f) ;
   // aspect
   f.set_costume((int)style.catch_obj(0)) ;
   f.set_fill((Vec4)style.catch_obj(1)) ;
   f.set_stroke((Vec4)style.catch_obj(2)) ;
   f.set_thickness((float)style.catch_obj(3)) ;
   f.set_alpha((Vec3)style.catch_obj(4)) ;
   // plant
   f.set_nutrient_quality(nutrient_quality) ;
   f.set_growth(speed_growth) ;
   f.set_need(need) ;
   //f.set_pos(pos) ;
}

/**
 set aspect flora
 */
boolean original_flora_aspect = true ;
Vec4 fill_colour_flora, stroke_colour_flora ;
float thickness_flora ; 
void set_aspect_flora(Vec4 fill_colour, Vec4 stroke_colour, float thickness) {
  original_flora_aspect = false ;
  if(fill_colour_flora == null) fill_colour_flora = Vec4(fill_colour) ; else fill_colour_flora.set(fill_colour) ;
  if(stroke_colour_flora == null) stroke_colour_flora = Vec4(stroke_colour) ; else stroke_colour_flora.set(stroke_colour) ;
  thickness_flora = thickness ;
}


/**
Flora update 0.0.3
*/
void flora_update(ArrayList<Agent> list_f, Biomass b) {
  /**
  may be this part can be improve, not sure is necessary to read the list for each update ??????
  */
  flora_update_kill(list_f) ;
  flora_update_growth(list_f) ;
  flora_update_feed(list_f, b) ;
  flora_update_statement(list_f) ;
  flora_update_opacity(list_f) ;
}

void flora_show(Info_Object style, ArrayList<Agent> list_f) {
  if(!INFO_DISPLAY_AGENT) {
    update_aspect(style, list_f) ;
    // flora_update_aspect(list_f) ;
  } else {
    info_agent(list_f) ;
  }
}
/**
Flora update()
*/

void flora_update_kill(ArrayList<Agent> list_f) {
  for(Agent a : list_f) {
    if(a instanceof Flora) {
      Flora f = (Flora) a ;
      if(f.stamina < 0 ) {
        list_f.remove(f) ;
        break ;
      }
    }
  }
}

void flora_update_feed(ArrayList<Agent> list_f, Biomass b) {
  for(Agent a : list_f) {
    if(a instanceof Flora) {
      Flora f = (Flora) a ;
      f.feeding(b) ;
    }
  }
}

void flora_update_growth(ArrayList<Agent> list_f) {
  for(Agent a : list_f) {
    if(a instanceof Flora) {
      Flora f = (Flora) a ;
      f.growth() ;
    }
  }
}

void flora_update_statement(ArrayList<Agent> list_f) {
  for(Agent a : list_f) {
    if(a instanceof Flora) {
      Flora f = (Flora) a ;
      f.statement() ;
    }
  }
}

void flora_update_opacity(ArrayList<Agent> list_f) {
  for(Agent a : list_f) {
    if(a instanceof Flora) {
      Flora f = (Flora) a ;
      float ratio = float(f.mass) / float(f.mass_ref) ;
      float alpha = g.colorModeA *ratio ;
      if(alpha <= 0) alpha = .001 ;
      f.fill_style.set(f.fill_style.r, f.fill_style.g, f.fill_style.b, alpha) ;
      f.stroke_style.set(f.stroke_style.r, f.stroke_style.g, f.stroke_style.b, alpha) ;
    }
  }
}


/*
void flora_update_aspect(ArrayList<Agent> list_f) {
  for(Agent a : list_f) {
    if(a instanceof Flora) {
      Flora f = (Flora) a ;
      if(original_flora_aspect) {
        f.aspect(f.fill_style, f.stroke_style, 1) ; 
      } else {
        f.aspect(fill_colour_flora, stroke_colour_flora, thickness_flora) ;
      }
      f.costume() ; 
    }
  }
}
*/
/**
METHOD FLORA End

*/



































/**
METHOD DEAD 1.0.0

*/
/**
set colour dead
*/
boolean original_corpse_aspect = true ;
Vec4 fill_colour_corpse, stroke_colour_corpse ;
float thickness_corpse ; 
void set_aspect_corpse(Vec4 fill_colour, Vec4 stroke_colour, float thickness) {
  original_corpse_aspect = false ;
  if(fill_colour_corpse == null) fill_colour_corpse = Vec4(fill_colour) ; else fill_colour_corpse.set(fill_colour) ;
  if(stroke_colour_corpse == null) stroke_colour_corpse = Vec4(stroke_colour) ; else stroke_colour_corpse.set(stroke_colour) ;
  thickness_corpse = thickness ;
}

void build_dead(ArrayList<Dead> list, Info_dict carac, Info_Object style, int num) {
  for(int i = 0 ; i < num ; i++) {
    if(ENVIRONMENT == 2 ) {
      Vec2 pos = Vec2("RANDOM RANGE",(int)LIMIT.a, (int)LIMIT.b, (int)LIMIT.c, (int)LIMIT.d) ;
      add_dead(list, pos, carac, style) ;
    } else {
      Vec3 pos = Vec3("RANDOM RANGE",(int)LIMIT.a, (int)LIMIT.b, (int)LIMIT.c, (int)LIMIT.d, (int)LIMIT.e, (int)LIMIT.f) ;
      add_dead(list, pos, carac, style) ;
    }
  }
}



void add_dead(ArrayList<Dead> list, Vec pos, Info_dict carac, Info_Object style) {
  int gender = (int)round(random(1));
  Dead dead = new Dead(carac, style, gender) ;
  set_dead(dead, pos, carac, style) ;
  list.add(dead) ;

}


void set_dead(Agent d, Vec pos, Info_dict carac, Info_Object style) {

  int nutrient_quality = (int) carac.get("nutrient_quality")[0].catch_obj(0) ;

  d.set_costume((int)style.catch_obj(0)) ;
  d.set_fill((Vec4)style.catch_obj(1)) ;
  d.set_stroke((Vec4)style.catch_obj(2)) ;
  d.set_thickness((float)style.catch_obj(3)) ;
  d.set_pos(pos) ;
  d.set_nutrient_quality(nutrient_quality) ;
   /*
  if(a instanceof Agent_static) {
    Agent_static a_s = (Agent_static) a ;
    a_s.set_pos(pos) ;
    a_s.set_nutrient_quality(nutrient_quality) ;
    a_s.set_fill(colour) ;
    a_s.set_stroke(colour) ;
  }
  */
}



/**
CORPSE || DEAD BODY update 0.1.0
*/
void dead_update(ArrayList<Dead> list) {
  dead_remove(list) ;
  carrion_update(list) ;
  /*
  rework log for dead list
  */
  // if(LOG_ECOSYSTEM) update_log(list, FRAME_RATE_LOG) ;
}

void show_dead(Info_Object style, ArrayList<Dead> list_dead) {
  if(INFO_DISPLAY_AGENT) {
    info_agent(list_dead) ;
  } else {
    // dead_aspect(list_dead) ;
    update_aspect(style, list_dead) ;
  }
}



/**
update dead body / corpse
*/
void dead_remove(ArrayList<Dead> list) {
  for(Dead dead : list) {
    if(dead.get_mass() <= 0) {
      list.remove(dead) ;
      break ;
    }
  }
}



void carrion_update(ArrayList<Dead> list) {
  for(Dead dead : list) {
    if(dead instanceof Agent_static) {
      Agent_static corpse = (Agent_static) dead ;
      corpse.carrion() ;
    }
  }
}

/**
DEAD METHOD END

*/




