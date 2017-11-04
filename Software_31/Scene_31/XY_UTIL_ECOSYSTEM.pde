/**

ECOSYSTEM UTIL 
v 1.0.4

* HOST and SYMBIOSIS
* WORLD
* BIOMASS
* picking, hunting, fooding
* REPRODUCTION
* GENETIC
* SHOW and COSTUME
* INFO
* GROWTH, LIFE and DIE

*/
/**

HOST SYMBIOSIS MANAGEMENT 0.0.5

*/
int [] target_host ;
Vec4 [] symbiosis_area ;
Vec3 pos_host, radius_host, canvas_host, size_host ;

Vec4 [] get_symbiosis_area() {
  if(symbiosis_area != null) return symbiosis_area ; else return null ;
}

int symbiosis_area_size() {
  if(symbiosis_area != null) return symbiosis_area.length ;
  else return -1 ;
}

Vec3 [] get_symbiosis_area_pos() {
  Vec3 [] list = new Vec3[symbiosis_area.length] ;
  for(int i = 0 ; i < list.length ; i++) {
    list[i] = Vec3(symbiosis_area[i].x, symbiosis_area[i].y, symbiosis_area[i].z) ;
  }
  if(list != null) return list ; else return null ;
}

int [] get_symbiosis_area_id() {
  int [] list = new int[symbiosis_area.length] ;
  for(int i = 0 ; i < list.length ; i++) {
      list[i] = int(symbiosis_area[i].w) ;
  }
  return list ;
}


void init_symbiosis_area(int num) {
  symbiosis_area = new Vec4[num];
}

void init_host_target(int num) {
  target_host = new int[num] ;
}

int [] get_host_address() {
  return target_host ;
}

void set_host_address(int target, int value) {
  if(target < target_host.length) {
    target_host[target] = value ;
  }
}

/**
pos host
*/
void pos_host(Vec pos) {
  if(pos_host == null) {
    pos_host = Vec3(pos.x,pos.y,pos.z) ;
  } else {
    pos_host.set(pos.x, pos.y, pos.z) ;
  }
}

void pos_host(float x, float y, float z) {
  if(pos_host == null) {
    pos_host = Vec3(x,y,z) ;
  } else {
    pos_host.set(x,y,z) ;
  }
}

Vec3 get_pos_host() {
  return pos_host ;
}

/**
radius host
*/
void radius_host(Vec radius) {
  if(radius_host == null) {
    radius_host = Vec3(radius.x,radius.y,radius.z) ;
  } else {
    radius_host.set(radius.x, radius.y, radius.z) ;
  }
}

void radius_host(float x, float y, float z) {
  if(radius_host == null) {
    radius_host = Vec3(x,y,z) ;
  } else {
    radius_host.set(x,y,z) ;
  }
}

Vec3 get_radius_host() {
  return radius_host ;
}

/**
size host
*/
void size_host(Vec size) {
  if(size_host == null) {
    size_host = Vec3(size.x,size.y,size.z) ;
  } else {
    size_host.set(size.x, size.y, size.z) ;
  }
}

void size_host(float x, float y, float z) {
  if(size_host == null) {
    size_host = Vec3(x,y,z) ;
  } else {
    size_host.set(x,y,z) ;
  }
}

Vec3 get_size_host() {
  return size_host ;
}


/**
canvas host
*/
void canvas_host(Vec canvas) {
  if(canvas_host == null) {
    canvas_host = Vec3(canvas.x,canvas.y,canvas.z) ;
  } else {
    canvas_host.set(canvas.x, canvas.y, canvas.z) ;
  }
}

void canvas_host(float x, float y, float z) {
  if(canvas_host == null) {
    canvas_host = Vec3(x,y,z) ;
  } else {
    canvas_host.set(x,y,z) ;
  }
}

Vec3 get_canvas_host() {
  return canvas_host ;
}


/**
symbiosis area
*/
void set_symbiosis_area(Vec3 [] target_host_list) {
  for(int i = 0 ; i < symbiosis_area.length ; i++) {
    if(symbiosis_area[i] == null) symbiosis_area[i] = Vec4() ;
    int where = (int)random(target_host_list.length) ;
    set_host_address(i, where) ;
    symbiosis_area[i].set(target_host_list[where].x, target_host_list[where].y, target_host_list[where].z, where) ;
  }
}



void update_symbiosis_area(Vec3 [] target_host_list) {
  if(symbiosis_area != null) {
    for(int i = 0 ; i < symbiosis_area.length ; i++) {
      int where = (int)symbiosis_area[i].w ;
      Vec3 pos = target_host_list[where] ;
      symbiosis_area[i].x = pos.x ;
      symbiosis_area[i].y = pos.y ;
      symbiosis_area[i].z = pos.z ;
    }
  }  
}

/**
symbiosis 0.0.4
*/
void symbiosis(ArrayList<Agent> symbiotic_agent_list, Vec3 [] list_coord_host, int [] address) {
  if(list_coord_host.length > 0 && address.length > 0 && symbiotic_agent_list.size() > 0) {
    int max_loop = address.length ;
    if(max_loop > symbiotic_agent_list.size()) max_loop = symbiotic_agent_list.size() ;
    for(int i = 0 ; i < max_loop ; i++) {
      Agent a = symbiotic_agent_list.get(i) ;
      int where = floor(random(address.length)) ;
      a.set_home(list_coord_host[address[where]], address[where]) ;
      a.set_pos(a.get_home_pos()) ;
    }
  } 
}


void sync_symbiosis(ArrayList<Agent> symbiotic_agent_list, Vec3 pos) {
  for(Agent a : symbiotic_agent_list) {
    if(a.get_home_id() != -1) {
      if(symbiosis_area_size() > a.get_home_id()) {
        a.set_home_pos(get_symbiosis_area_pos()[a.get_home_id()]) ;
      } else {
        symbiotic_agent_list.remove(a) ;
        break ;
      }
      if(pos != null && !pos.equals(Vec3(0))) {
        a.set_pos(a.get_home_pos().add(pos)) ;
      } else {
        a.set_pos(a.get_home_pos()) ;
      }
    } else {
      // System.err.println("ID home is equal to -1, need to init your symbiotic ecosystem before sync it") ;
    }
  }
}


void sync_symbiosis(ArrayList<Agent> symbiotic_agent_list) {
  Vec3 pos = Vec3() ;
  sync_symbiosis(symbiotic_agent_list, pos) ;
}





















/**

WORLD 0.1.1

*/
boolean HORIZON_ALPHA = false ;
int HORIZON = 0 ;
int ENVIRONMENT = 2 ; // 2 is for 2D, 3 for 3D
Vec3 ECO_BOX_SIZE = Vec3(100,100,100) ;
Vec3 ECO_BOX_POS = Vec3() ;
Vec6 LIMIT = Vec6(0, ECO_BOX_SIZE.x, 0, ECO_BOX_SIZE.y, 0, ECO_BOX_SIZE.z) ;

boolean REBOUND ;
int SIZE_TEXT_INFO ;


void set_renderer(String renderer) {
  if(renderer.equals(P3D)) {
    ENVIRONMENT = 3 ; 
  } else {
    ENVIRONMENT = 2 ;
  }
}


void use_horizon(boolean horizon) {
  HORIZON_ALPHA = horizon ;
}

void set_horizon(int value) {
   HORIZON = value ;
}

void use_rebound(boolean rebound) {
  REBOUND = rebound ;
}

Vec3 get_box_pos() {
  return ECO_BOX_POS ;
}

Vec3 get_box_size() {
  return ECO_BOX_SIZE ;
}

void build_box(Vec3 pos, Vec3 size) {
  set_pos_box(pos) ;
  set_size_box(size) ;
}

void set_size_box(Vec3 size) {
  ECO_BOX_SIZE.set(size) ;
}

void set_pos_box(Vec3 pos) {
  ECO_BOX_POS.set(pos) ;
}

void set_limit_box(float left, float right, float top, float bottom, float front, float back) {
  LIMIT.set(left,right, top, bottom, front, back) ;
}
























/**

BIOMASS

*/
class Biomass {
  float humus, humus_max ;
  Biomass() {}

  void humus_update(float var_humus) {
    humus +=var_humus ;
  }

  void set_humus(float humus) {
    this.humus = this.humus_max = humus ;
  }
} 
























/**

AGENT DYNAMIC

*/

void picking_update(ArrayList<Agent> list_picker, ArrayList<Agent> list_target) {
  for(Agent a : list_picker) {
    if(a instanceof Agent_dynamic) {
      Agent_dynamic picker = (Agent_dynamic) a ;
      if(!picker.satiate) {
        search_flora(picker, list_target) ;
      } 
      eat_flora(picker, list_target) ;
    }
  }
}

void hunting_update(ArrayList<Agent> list_hunter, boolean info, ArrayList<Agent>... all_list) {
  for( ArrayList list_target : all_list) {
    for(Agent a : list_hunter) {
      if(a instanceof Agent_dynamic) {
        Agent_dynamic hunter = (Agent_dynamic) a ;
        if(!hunter.satiate && !hunter.eating) hunt(hunter, list_target) ;   
      }
    }
  }
}

void eating_update(ArrayList<Agent> list_hunter, ArrayList<Dead> list_dead) {
  for(Agent a : list_hunter) {
    if(a instanceof Agent_dynamic) {
      Agent_dynamic hunter = (Agent_dynamic) a ;
      // eat
      if(list_dead.size() >= 0 ) {
        eat_meat(hunter, list_dead) ; 
      } else {
        hunter.eating = false ;
      }
    }
  }
}

/**

SEARCH

*/
/**
search flora
*/
void search_flora(Agent_dynamic grazer, ArrayList<Agent> list_target) {

  if(grazer.tracking && grazer.max_time_track > grazer.time_track) {
    if(grazer.focus_target(list_target)) {
      int which_target = (int)grazer.ID_target.x ;
      int ID_target = (int)grazer.ID_target.y ;
      Agent target = list_target.get(which_target) ;
      grazer.track(grazer.target) ;
    } 
  } else {
    grazer.track_stop() ;
    int entry = floor(random(list_target.size())) ;
    for(int i = 0 ; i < list_target.size() ; i++) {
      int which = i + entry ;
      if(which >= list_target.size()) {
        which -= list_target.size() ;
      }
      Agent a = list_target.get(which) ;
      if(a instanceof Flora) {
        Flora target = (Flora) a ;
        grazer.watch(target, list_target) ;
        if(grazer.tracking) {
          break ;
        }
      }
    }
  }  
}






/**
hunt creature
*/
void hunt(Agent_dynamic hunter, ArrayList<Agent> list_target) {
  // first watch the agent who watch just before without look in the list
  if(hunter.watching) find_target_hunter(hunter, list_target) ;

  if(hunter.tracking && hunter.max_time_track > hunter.time_track) {
    hunt_target(hunter, list_target) ; 
  } else {
    hunter.track_stop() ;
  }
}



// Local method : The hunt is launching !
void hunt_target(Agent_dynamic hunter, ArrayList<Agent> list_target) {
   if (hunter.focus_target(list_target)) {
    hunt_and_kill_target(hunter, hunter.target) ;
   } else {
    hunter.track_stop() ;
  }
}
// super local method
void hunt_and_kill_target(Agent_dynamic hunter, Agent target) {
  if(target instanceof Agent_dynamic) {
    Agent_dynamic target_d = (Agent_dynamic) target ;
    if(hunter.dist_to_target(target_d) < hunter.sense_range) {
      hunter.track(target_d) ; 
      hunter.kill(target_d) ;
    } else hunter.track_stop() ;
  }
}

/**
Find new target, Big Brother is hunting you !
*/
void find_target_hunter(Agent_dynamic hunter, ArrayList<Agent> list_target) {
  // float [] dist_list = new float[0] ;
  ArrayList <Vec3> closest_target = new ArrayList<Vec3>() ;
  // find the closest target 
  for(Agent a : list_target) {
    if(a instanceof Agent_dynamic) {
      Agent_dynamic target_d = (Agent_dynamic) a ;
      if(hunter.dist_to_target(target_d) < hunter.sense_range) {
        float dist = hunter.dist_to_target(target_d) ;
        // catch distance to compare with the last one
        // plus catch index in the list and the ID target
        // and add in the nice target list

        Vec3 new_target = Vec3(dist, list_target.indexOf(target_d), target_d.get_ID()) ;
        closest_target.add(new_target) ;
        // compare the target to see which one is the closest.
        if(closest_target.size() > 1) if (closest_target.get(1).x <= closest_target.get(0).x ) closest_target.remove(0) ; else closest_target.remove(1) ;
      } 
    }
  }

  // Start the hunt party with the selected target
  if(closest_target.size() > 0 ) {
    Agent a = list_target.get((int)closest_target.get(0).y) ;
    if(a instanceof Agent_dynamic) {
      Agent_dynamic target_d = (Agent_dynamic) a ;
      hunter.track(target_d) ;
      hunter.kill(target_d) ;
      if(hunter.tracking) hunter.ID_target.set(list_target.indexOf(target_d),target_d.get_ID()) ;
    }
  }
}




/**

EAT

*/
/**
eating flora
*/
void eat_flora(Agent_dynamic grazer, ArrayList<Agent> list_target) {
  if(grazer.eating) {
    Agent a ;
    if((int)grazer.ID_target.x < list_target.size()) {
      a = list_target.get((int)grazer.ID_target.x) ;
      if(a instanceof Flora) {
        Flora target = (Flora) a ;
        grazer.eat_veg(target) ;
      }
    }
  } else if (!grazer.eating) {
    for(Agent a : list_target) {
      if(a instanceof Flora) {
        Flora target = (Flora) a ;
        grazer.eat_veg(target) ;
        if(grazer.eating) {
          if((int)grazer.ID_target.x < list_target.size()) {
            grazer.ID_target.set(list_target.indexOf(a),target.ID) ;
            break ;
          }
        }
      }
    }
  }
}

/**
eat meat
*/
void eat_meat(Agent_dynamic hunter, ArrayList<Dead> list_dead) {
  // first eat the agent who eat just before without look in the list
  if(hunter.eating) {
    int pointer = (int)hunter.ID_target.x ;
    int ID_target = (int)hunter.ID_target.y ;
    /* here we point directly in a specific point of the list, 
    if the pointer is superior of the list, 
    because if it's inferior a corpse can be eat by an other Agent */
    if(pointer < list_dead.size() ) {
      Dead target = list_dead.get((int)hunter.ID_target.x) ;
      /* if the entry point of the list return an agent 
      with a same ID than a ID_target corpse eat just before, 
      the Carnivore can continue the lunch */
      if (target instanceof Agent_static && target.get_ID() == ID_target ) {
        Agent_static agent_meat = (Agent_static) target ;
        hunter.eat_flesh(agent_meat) ; 
      }
      else {
        /* If the ID returned is different, a corpse was leave from the list, 
        and it's necessary to check in the full ist to find if any corpse have a seme ID */
        for(Dead target_in_list : list_dead) {
          if (target_in_list instanceof Agent_static && target_in_list.get_ID() == ID_target) {
            Agent_static agent_meat = (Agent_static) target_in_list ;
            hunter.eat_flesh(agent_meat) ; 
          } else {
            hunter.eating = false ;
          }
        }
      }
    }
  /* If the last research don't find the corpse, may be this one is return to dust ! */
  } else {
    for(Agent a : list_dead) {
      if(a instanceof Agent_static) {
        Agent_static target = (Agent_static) a ;
        hunter.eat_flesh(target) ;
        if(hunter.eating) {
          hunter.ID_target.set(list_dead.indexOf(target),target.get_ID()) ;
          break ;
        }
      }
    }
  }
}

/**


END FOOD


*/












































/**

REPRODUCTION AGENT DYNAMIC

*/
boolean check_male_reproducer(Agent female, ArrayList<Agent> list_target) {
  boolean result = false ;
  if(list_target.size() > 0) {
    for (Agent male : list_target) {
      if(male instanceof Agent_dynamic && female instanceof Agent_dynamic) {
        Agent_dynamic m = (Agent_dynamic) male ;
        Agent_dynamic f = (Agent_dynamic) female ;
        if(dist(f.pos, m.pos) < f.reproduction_area) {
          result = true ;
          // must be create method copy but smell very complexe thing to do
          f.genome_father = m.genome ;
          break ; 
        } else result = false ;
      } else result = false ;
    }
  } else result = false ;
  return result ;
}


/**
Male Reproduction
*/
void reproduction_male(ArrayList<Agent> list_f, ArrayList<Agent> list_m) {
  for (Agent f : list_f) {
    if(f instanceof Agent_dynamic) {
      Agent_dynamic f_a_d = (Agent_dynamic) f ;
      if(f_a_d.fertility && check_female_reproducer(f, list_m)) ;
    }
  }
}

boolean check_female_reproducer(Agent female, ArrayList<Agent> list_target_male) {
  boolean result = false ;
  if(list_target_male.size() > 0) {
    for (Agent male : list_target_male) {
      if(male instanceof Agent_dynamic && female instanceof Agent_dynamic) {
        Agent_dynamic m = (Agent_dynamic) male ;
        Agent_dynamic f = (Agent_dynamic) female ;
        if(dist(female.get_pos(), male.get_pos()) < f.sex_appeal) {
          f.pos_target.set(male.get_pos()) ;
          m.tracking_partner = true ;
          // float ratio_acceleration_to_see_female = 1.3 ;
          // m.velocity = m.velocity_ref *ratio_acceleration_to_see_female ;
          m.dir.set(target_direction(f.pos, m.pos)) ;
          result = true ; 
        } else {
          result = false ;
          m.tracking_partner = false ;
        }
      } else {
        result = false ;
      }
    }
  } else result = false ;
  return result ;
}




/**
DELIVERY
*/
int num_by_pregnancy = 1 ;

void delivery(Agent_dynamic deliver, Genome mother, Genome father, ArrayList<Agent> list_child, Info_dict carac, Info_Object style) {
  // check for heterozygote
  num_babies(deliver.multiple_pregnancy) ;
  Agent [] babies = new Agent [num_by_pregnancy] ;
  babies = babies(deliver, num_by_pregnancy, mother, father) ;
  for(int i = 0 ; i < num_by_pregnancy ; i++) {
    set_baby(deliver, babies[i], list_child, carac, style) ;
    if(PRINT_BORN_AGENT_DYNAMIC) print_born_agent_dynamic (babies[i]) ;
  }
  deliver.num_pregnancy ++ ;
  num_by_pregnancy = 1 ;
}

// local
void set_baby(Agent_dynamic deliver, Agent baby, ArrayList<Agent> list_child, Info_dict carac, Info_Object style) {
  if(baby instanceof Agent_dynamic) {
    Agent_dynamic n = (Agent_dynamic) baby ;
    // clean the uterus of mother
    deliver.genome_father = null ;
    // set motion of the baby
    n.set_pos(deliver.pos) ;
    n.dir = Vec3("RANDOM",1) ;
    // here we change velocity to don't have a same from parent, can be change that in the future
    float new_velocity = deliver.velocity +random(-1,1) ;
    if(new_velocity < .1) new_velocity = .1 ;
    n.set_velocity(new_velocity) ;

    // all data from mother
    // Must add this part in the genome for the future,
    if(baby instanceof Carnivore) set_carnivore(n, deliver.pos, carac, style) ;
    if(baby instanceof Herbivore) set_herbivore(n, deliver.pos, carac, style) ;
    if(baby instanceof Omnivore) set_omnivore(n, deliver.pos, carac, style) ; 

    n.set_ID( (short) Math.round(random(Short.MAX_VALUE))) ;
    list_child.add(n) ;
  }
}


Agent [] babies(Agent_dynamic deliver, int num, Genome mother, Genome father) {
  Agent [] b = new Agent [num] ;
  // re-init for the pregnancy
  String monster_message = "The mother deliver is a genetic monster, and the 'Nature of Code' kill it because is not a baby from an Authorized Class" ;

  for(int i = 0 ; i < b.length ; i++) {
    // check for homozygous
    if(b.length > 1 && i <  b.length -1 && random(3) < 1) {
      deliver.num_children += 2 ;
      deliver.num_homozygous += 2 ;
      if(deliver instanceof Herbivore ) b[i] = new Herbivore(mother, father, deliver.style) ;
      else if(deliver instanceof Omnivore ) b[i] = new Omnivore(mother, father, deliver.style) ;
      else if(deliver instanceof Carnivore ) b[i] = new Carnivore(mother, father, deliver.style) ;
      else println(monster_message) ;
      i++ ;
      if(deliver instanceof Herbivore ) b[i] = b[i -1] ;
      else if(deliver instanceof Omnivore ) b[i] = b[i -1] ;
      else if(deliver instanceof Carnivore ) b[i] = b[i -1] ;
      else println(monster_message) ;
    } else {
      deliver.num_children++ ;
      if(b.length > 1) deliver.num_heterozygous++ ;
      if(deliver instanceof Herbivore ) b[i] = new Herbivore(mother, father, deliver.style) ;
      else if(deliver instanceof Omnivore ) b[i] = new Omnivore(mother, father, deliver.style) ;
      else if(deliver instanceof Carnivore ) b[i] = new Carnivore(mother, father, deliver.style) ;
      else println(monster_message) ;
    }
  }
  return b ;
}



void num_babies(float ratio_multi) {
  int max = 100 ;    
  float draw = random(max) ;
  // security
  int max_babies = 100 ;

  if(draw < ratio_multi && num_by_pregnancy < max_babies) {
    num_by_pregnancy++ ;
    num_babies(ratio_multi) ;
  }
}






/**
FAMILY
*/
void manage_child(ArrayList<Agent> list_f, ArrayList<Agent> list_m, ArrayList<Agent> list_child) {
  if(list_child.size() > 0) {
    for (Agent child : list_child) {
      if(child instanceof Agent_dynamic) {
        Agent_dynamic c = (Agent_dynamic) child ;
        if(c.maturity <= 0 ) {
          if(c.gender == 0 ) {
            // we don't add 'c' because it's an 'Agent_dynamic' we need to a pure 'Agent'
            list_f.add(child) ;
            break ;
          }
          if(c.gender == 1 ) {
            // we don't add 'c' because it's an 'Agent_dynamic' we need to a pure 'Agent'
            list_m.add(child) ;
            break ;
          }
        }
      }
    }

    // remove child when this one to be added to the adult pool
    for (Agent child : list_child) {
      if(child instanceof Agent_dynamic) {
        Agent_dynamic c = (Agent_dynamic) child ;
        if(c.maturity <= 0 ) {
          list_child.remove(child) ;
          break ;
        }
      }
    }
  }
}

/**

END REPRODUCTION 
AGENT DYNAMIC

*/



































/**

GENETIC

* Start June 2016
* @author Stan le Punk
* @see https://github.com/StanLepunK/Digital-Vivant-Digital-Life/tree/master/GENETIC
*/

/**
Genotype
methode to generate a new genome from the mother and father genome
*/
Genome genotype(Genome mother, Genome father) {
  if(mother.num_chromosome() == father.num_chromosome() && mother.num_gene() == father.num_gene()) {
    // may be remove "1" for the gender chromosome ????
    String [] chromosome_name = new String[mother.num_chromosome() -1] ;
    for(int i = 0 ; i < chromosome_name.length ; i++) {
      chromosome_name[i] = mother.get_chromosome_name()[i] ;
    }
    String [] gene_name = new String[mother.num_gene() -1] ;
    Gene [] gene_data_mother = new Gene[mother.num_gene() -1] ;
    Gene [] gene_data_father = new Gene[mother.num_gene() -1] ;
    for(int i = 0 ; i < gene_name.length ; i++) {
      gene_name[i] = mother.get_genotype()[i].gene_name ;
      gene_data_mother[i] = mother.get_genotype()[i] ;
      gene_data_father[i] = father.get_genotype()[i] ;

    }
    return new Genome(chromosome_name, gene_name, gene_data_mother, gene_data_father) ;

  } else {
    return null ;
  }
}



/**
Archetype
method to generate a quick genome from a simple data
The method create two chromosome, one for the data value, one for the String data
int this method the first genome is used for the float data and the second for the String data
*/
Genome archetype(float [] float_data) {
  String [] string_data = new String[0] ;
  String [] data_name = new String[0] ;
  int gender = MAX_INT ;
  return archetype(float_data, string_data, data_name, gender) ;
}

Genome archetype(String [] string_data) {
  float [] float_data = new float[0] ;
  String [] data_name = new String[0] ;
  int gender = MAX_INT ;
  return archetype(float_data, string_data, data_name, gender) ;
}

Genome archetype(float [] float_data, String [] data_name) {
  String [] string_data = new String[0] ;
  int gender = MAX_INT ;
  return archetype(float_data, string_data, data_name, gender) ;
}

Genome archetype(String [] string_data, String [] data_name) {
  float [] float_data = new float[0] ;
  int gender = MAX_INT ;
  return archetype(float_data, string_data, data_name, gender) ;
}

Genome archetype(float [] float_data, String [] string_data, String [] data_name) {
  int gender = MAX_INT ;
  return archetype(float_data, string_data, data_name, gender) ;
}

Genome archetype(float [] float_data, int gender) {
  String [] string_data = new String[0] ;
  String [] data_name = new String[0] ;
  return archetype(float_data, string_data, data_name, gender) ;
}

Genome archetype(String [] string_data, int gender) {
  float [] float_data = new float[0] ;
  String [] data_name = new String[0] ;
  return archetype(float_data, string_data, data_name, gender) ;
}

Genome archetype(float [] float_data, String [] string_data, int gender) {
  String [] data_name = new String[0] ;
  return archetype(float_data, string_data, data_name, gender) ;
}






Genome archetype(float [] float_data, String [] string_data, String [] data_name, int gender) {
  int num_chromosome = 2 ;
  if(float_data.length < 1 || string_data.length < 1) {
    num_chromosome = 1 ;
  }
  String [] chromosome_name = new String[num_chromosome] ;

  int num_info = float_data.length + string_data.length ;
  Gene [] gene_data_mother = new Gene[num_info] ;
  Gene [] gene_data_father = new Gene[num_info] ;
  String [] gene_name = new String[num_info] ;
  // init var
  for(int i = 0 ; i < gene_name.length ; i++) { 
    gene_name[i] = Integer.toString(i) ;
  }

  int num_naming = 0 ;
  if (gene_name.length <= data_name.length) {
    num_naming = gene_name.length ; 
  } else { 
    num_naming = data_name.length ;
  }
  // loop on the smalest list to don't have out bound
  for(int i = 0 ; i < num_naming ; i++) {
    gene_name [i] = data_name[i] ;
  }


  // make chromosome
  int pointer = 0 ;

  if(float_data.length > 0) {
    chromosome_name[0] = "Float" ;
    for(int i = 0 ; i < float_data.length ; i++) {
      int locus = i ;
      Vec2 mother = Vec2(float_data[i]) ;
      Vec2 father = Vec2(float_data[i]) ;
      Vec2 mother_dominance = Vec2("RANDOM ZERO", 1) ;
      Vec2 father_dominance = Vec2("RANDOM ZERO", 1) ;
      gene_data_mother [i] = new Gene(chromosome_name[0], gene_name [pointer], locus, mother, mother_dominance) ;
      gene_data_father [i] = new Gene(chromosome_name[0], gene_name [pointer], locus, father, father_dominance) ;
      pointer++ ;
    }
  }
  if(string_data.length > 0) {
    int ID_chromosome = 1 ;
    if(float_data.length < 1) ID_chromosome = 0 ;
    chromosome_name[ID_chromosome] = "String" ;
    for(int i = 0 ; i < string_data.length ; i++) {
      int locus = i ;
      String mother_left = string_data[i] ;
      String mother_right = string_data[i] ;
      String father_left = string_data[i] ;
      String father_right = string_data[i] ;
      Vec2 mother_dominance = Vec2("RANDOM ZERO", 1) ;
      Vec2 father_dominance = Vec2("RANDOM ZERO", 1) ;
      gene_data_mother [pointer] = new Gene(chromosome_name[ID_chromosome], gene_name [pointer], locus, mother_left, mother_right, round(mother_dominance.x), round(mother_dominance.y))  ;
      gene_data_father [pointer] = new Gene(chromosome_name[ID_chromosome], gene_name [pointer], locus, father_left, father_right, round(father_dominance.x), round(father_dominance.y))  ;
      pointer++ ;
    }
  }
  

  // finalize
  if(gender == 0 || gender == 1) {
    return new Genome(chromosome_name, gene_name, gene_data_mother, gene_data_father, gender) ;
  } else {
    return new Genome(chromosome_name, gene_name, gene_data_mother, gene_data_father) ;
  }
}
/**

END GENETIC

*/





























/**

SHOW / COSTUME

*/
void set_costume_agent(int which_costume, ArrayList<Agent>... all_list) {
  for(ArrayList<Agent> list : all_list) {
    for(Agent a : list) {
      a.set_costume(which_costume) ; 
    }
  }
}


/**
Info_Object info
* boolean info = (boolean)info.catch_obj(0) ;
* boolean original = (boolean)info.catch_obj(1) ;
* int costume_ID = (int)info.catch_obj(2) ;
* Vec4 fill = (Vec4)info.catch_obj(3) ;
* Vec4 stroke = (Vec4)info.catch_obj(4) ; 
* float thickness = (float)info.catch_obj(5) ;
*/ 
void show_agent_dynamic(Info_Object style, ArrayList<Agent>... all_list) {
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
Aspect 1.0.3
*/
boolean use_style = true ;
void use_style(boolean style) {
  use_style = style ;
}
/**
update aspect
*/
void update_aspect(Info_Object style, ArrayList list) {
  int costume_ID = 0 ;
  Vec4 fill_vec =  Vec4(0, 0 , g.colorModeZ, g.colorModeA) ; 
  Vec4 stroke_vec = Vec4(g.colorModeX, g.colorModeY, g.colorModeZ, g.colorModeA) ; 
  float thickness = 1 ;
  // float alpha_behavior = (float)style.catch_obj(4) ;
  boolean fill_is = true ;
  boolean stroke_is = true ;

  if(style.catch_obj(0) != null) costume_ID = (int)style.catch_obj(0) ;
  if(style.catch_obj(1) != null) fill_vec = (Vec4)style.catch_obj(1) ;
  if(style.catch_obj(2) != null) stroke_vec = (Vec4)style.catch_obj(2) ; 
  if(style.catch_obj(3) != null) thickness = (float)style.catch_obj(3) ;
  // if(style.catch_obj(4) != null) alpha_behavior = (float)style.catch_obj(4) ;
  if(style.catch_obj(5) != null) fill_is = (boolean)style.catch_obj(5) ;
  if(style.catch_obj(6) != null) stroke_is = (boolean)style.catch_obj(6) ;




  for(Object o : list) {
    if(o instanceof Agent) {
      Agent a = (Agent) o ;
      boolean original_aspect = true ;
      Vec4 fill_def ;
      Vec4 stroke_def ;
      float thickness_def ;

      if(fill_vec != a.get_fill_style() || stroke_vec != a.get_stroke_style() || thickness != a.get_thickness()) {
        original_aspect = false ;
      }

      if(original_aspect) {
        fill_def = a.get_fill_style().copy() ;
        stroke_def = a.get_stroke_style().copy() ;
        thickness_def = a.get_thickness() ;
      } else {
        fill_def = fill_vec.copy() ;
        stroke_def = stroke_vec.copy() ;
        thickness_def = thickness ;
      }


      if(use_style) {
        if(a.get_melanin() != null) {
          Vec4 map = mapVec(a.get_melanin(), -1, 1, 0, 2) ;
          fill_def.mult(map) ;
          stroke_def.mult(map) ;
        }
        if(g.colorMode == 3) {
          if(fill_def.x > g.colorModeX) fill_def.x = fill_def.x - g.colorModeX ;
          if(stroke_def.x > g.colorModeX) stroke_def.x = stroke_def.x - g.colorModeX ;
        }
      }

      if(HORIZON_ALPHA) {
        if(fill_def != null) fill_def.set(fill_def.x, fill_def.y, fill_def.z, alpha(a)) ;
        if(stroke_def != null) stroke_def.set(stroke_def.x, stroke_def.y, stroke_def.z, alpha(a)) ;
      }

      // display

      if(!fill_is) {
        fill_def.a = 0 ;
      }
      if(!stroke_is) {
        thickness_def = 0 ;
      }
      a.aspect(fill_def, stroke_def, thickness_def) ;
      if(costume_ID != a.get_costume()) {
        a.costume(costume_ID) ; 
      } else {
        a.costume() ;
      }
    }
    /*
    if(o instanceof Dead) {
      Dead d = (Dead) o ;
      boolean original_aspect = true ;

      if(costume_ID != d.get_costume() || fill_vec != d.get_fill_style() || stroke_vec != d.get_stroke_style() || thickness != d.get_thickness()) {
        original_aspect = false ;
      }
      if(original_aspect) {
        if(HORIZON_ALPHA) {
          Vec4 new_fill = Vec4(d.get_fill_style().x, d.get_fill_style().y, d.get_fill_style().z, alpha(d)) ;
          Vec4 new_stroke = Vec4(d.get_stroke_style().x, d.get_stroke_style().y, d.get_stroke_style().z, alpha(d)) ;
          d.aspect(new_fill, new_stroke, thickness) ;
        } else {
          d.aspect(d.get_fill_style(), d.get_stroke_style(), d.get_thickness()) ;
        }
        d.costume() ;

      } else {
        if(HORIZON_ALPHA) {
          Vec4 new_fill = Vec4(fill_vec.x, fill_vec.y, fill_vec.z, alpha(d)) ;
          Vec4 new_stroke = Vec4(stroke_vec.x, stroke_vec.y, stroke_vec.z, alpha(d)) ;
          d.aspect(new_fill, new_stroke, thickness) ;
        } else {
          d.aspect(fill_vec, stroke_vec, thickness) ;
        }

        if(costume_ID != d.get_costume()) {
          d.costume(costume_ID) ; 
        } else {
          d.costume() ;
        }
      }
    } 
    */  
  }
}


float alpha(Agent a) {
  Vec3 temp_pos = a.get_pos() ;
  int horizon_back = int(HORIZON * a.get_alpha_back()) ;
  int horizon_front = int(HORIZON * a.get_alpha_front()) ;
  horizon_back += a.get_alpha_cursor() ;
  horizon_front += a.get_alpha_cursor() ;
  float alpha = map(temp_pos.z, -horizon_back, horizon_front, 0 ,1) ;
  if(alpha <= 0 ) alpha = 0 ;
  alpha = alpha * g.colorModeA ;
  return alpha ;
}
/**
END SHOW

*/





















/**

INFO

*/
/*
void info_agent(ArrayList<Agent> list) {
  for(Agent a : list) {
    a.info(a.get_fill_style(), SIZE_TEXT_INFO) ;
  }
}
*/

void set_textSize_info(int size) {
  SIZE_TEXT_INFO = size ;
}





void info_agent(ArrayList list) {
  for(Object o : list) {
    if(o instanceof Agent) {
      Agent a = (Agent) o ;
      a.info(a.get_fill_style(), SIZE_TEXT_INFO) ;
    } else if(o instanceof Dead) {
      Dead d = (Dead) o ;
      d.info(d.get_fill_style(), SIZE_TEXT_INFO) ;

    }
   
  }
}

void info_agent_track_line(ArrayList<Agent> list) {
  for(Agent a : list) {
    if(a instanceof Carnivore) {
      Carnivore c = (Carnivore) a ;
      track_line(c.pos, c.pos_target, c.colour_info(c.get_stroke_style())) ;
      c.pos_target.set(MAX_INT) ;
    } else if (a instanceof Herbivore) {
      Herbivore h = (Herbivore) a ;
      track_line(h.pos, h.pos_target, h.colour_info(h.get_stroke_style())) ;
      h.pos_target.set(MAX_INT) ;
    } else if (a instanceof Omnivore) {
      Omnivore o = (Omnivore) a ;
      track_line(o.pos, o.pos_target, o.colour_info(o.get_stroke_style())) ;
      o.pos_target.set(MAX_INT) ;
    } else if (a instanceof Bacterium) {
      Bacterium b = (Bacterium) a ;
      track_line(b.pos, b.pos_target, b.colour_info(b.get_stroke_style())) ;
      b.pos_target.set(MAX_INT) ;
    }
  }
}

void track_line(Vec3 pos, Vec3 pos_target, Vec4 colour) {
  if(!pos_target.compare(Vec3(MAX_INT))) {
    stroke(colour) ;
    strokeWeight(1) ;
    line(pos, pos_target) ;
  }
}
/**

END INFO

*/























/**

GROWTH
LIFE
DIE

*/
void update_growth(ArrayList<Agent> list) {
  for (Agent a : list) {
    a.growth() ;
  }
}


void update_die(ArrayList<Dead> list_dead, ArrayList<Agent> list) {
  // dead, possible to add to the dead list
  for(Agent a : list) {
    if(!a.get_alive()) {
      if(a instanceof Agent_dynamic) {
        Agent_dynamic a_d = (Agent_dynamic) a ;
        if(PRINT_DEATH_AGENT_DYNAMIC) {
          print_death_agent(a_d) ;
        }
        Dead dead = new Dead(a_d.pos, a_d.size, a_d.size_ref, a_d.nutrient_quality, a_d.name) ;
        list_dead.add(dead) ;
        list.remove(a) ;
        break ;
      }
    }
  }

  //disapear, retrun to the oblivion no return as possible !
  for(Agent a : list) {
    if(a.get_mass() < 0) {
      if(PRINT_DEATH_AGENT_DYNAMIC) {
        println("GO TO OBLIVION") ;
      }
      list.remove(a) ;
      break ;
    }
  }
}




  /**
Motion
*/
void update_motion(ArrayList<Agent> list) {
  for(Agent a : list) {
    if(a instanceof Agent_dynamic) {
      Agent_dynamic a_d = (Agent_dynamic) a ;
      a_d.rebound(LIMIT, REBOUND) ;
      a_d.motion() ;
    }
  }
}


/**
Statement

*/
void update_statement(ArrayList<Agent> list) {
  for(Agent a : list) {
    if(a instanceof Agent_dynamic) {
      Agent_dynamic a_d = (Agent_dynamic) a ;
      a_d.statement() ;
      a_d.hunger() ;
    }
  }
}


void update_log(ArrayList<Agent> list, int tempo) {
  for(Agent a : list) {
    if(a instanceof Agent_dynamic) {
      Agent_dynamic a_d = (Agent_dynamic) a ;
      if(!a_d.log_is()) a_d.build_log() ;
      a_d.log(tempo) ;
    }
  }
}









