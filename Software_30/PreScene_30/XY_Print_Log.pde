
/**
INFO 
LOG
PRINT

0.1.1
*/
boolean INFO_DISPLAY_AGENT = false ;


int FRAME_RATE_LOG = 300 ;

boolean PRINT_DEATH_AGENT_DYNAMIC = true ;
boolean PRINT_BORN_AGENT_DYNAMIC = true ;
boolean PRINT_POPULATION = true ;


boolean LOG_ECOSYSTEM = false ;
boolean LOG_ALL_AGENTS = false ;

boolean LOG_HERBIVORE = false ;
boolean LOG_OMNIVORE = false ;
boolean LOG_CARNIVORE = false ;
boolean LOG_FLORA = false ;
boolean LOG_BACTERIUM = false ;
boolean LOG_DEAD = false ;


boolean log_is ;
int SEQUENCE_LOG = 0 ;
// int col_num = 10 ;
// log Eco agent
Table [] log_eco_agent ;
TableRow [] tableRow_eco_agent ;
// log Eco resume
Table log_eco_resume ;
TableRow [] tableRow_eco_resume ;

// log Agent
Table log_agents ;
TableRow [] tableRow_agents ;
int col_num_agents = 10 ;


boolean first_save = true  ;
String save_date = "" ;
String save_date() {
  if (first_save) {
    save_date = year()+"_"+month()+"_"+day()+"_"+hour()+"_"+minute() ;
    SEQUENCE_LOG = 0 ;
    first_save = false ;
  }
  return save_date ;
}


/**
LOG 1.0.0

*/
/**
Log ecosystem 0.0.1
*/


/**
set log
*/

void set_frameRate_log(int tempo) {
  FRAME_RATE_LOG = tempo ;
}


void set_log_ecosystem(boolean b) { 
  LOG_ECOSYSTEM = b ;
}
void set_log_agents(boolean b) { 
  LOG_ALL_AGENTS = b ;
}

void set_log_herbivore(boolean b) { 
  LOG_HERBIVORE = b ;
}
void set_log_omnivore(boolean b) { 
  LOG_OMNIVORE = b ;
}
void set_log_carnivore(boolean b) { 
  LOG_CARNIVORE = b ;
}
void set_log_bacterium(boolean b) { 
  LOG_BACTERIUM = b ;
}
void set_log_flora(boolean b) { 
  LOG_FLORA = b ;
}
void set_log_dead(boolean b) { 
  LOG_DEAD = b ;
}




// log
boolean log_is() {
  return log_is ;
}


void init_log() {
  if(log_agents != null) log_agents.clearRows() ;
  if(log_eco_resume != null) log_eco_resume.clearRows() ;
  if(log_eco_agent != null) {
    for(int i = 0 ; i <log_eco_agent.length ; i++) {
      if(log_eco_agent[i] != null) log_eco_agent[i].clearRows() ;
    }
  }
}



// build
void build_log(int num_table_eco) {
  log_is = true ;
  int rank = 0 ;

  // build log eco agent
  log_eco_agent = new Table[num_table_eco] ;
  for(int i = 0 ; i < log_eco_agent.length ; i++) {
    log_eco_agent[i] = new Table() ;
  }
  String [] col_name_eco_agent = new String[9] ;
  col_name_eco_agent[rank++] = "Time" ;
  col_name_eco_agent[rank++] = "Agent" ;
  col_name_eco_agent[rank++] = "Life" ;
  col_name_eco_agent[rank++] = "Stamina" ;
  col_name_eco_agent[rank++] = "Size" ;
  col_name_eco_agent[rank++] = "Child" ;
  col_name_eco_agent[rank++] = "Female" ;
  col_name_eco_agent[rank++] = "Male" ;
  col_name_eco_agent[rank++] = "Population" ;
  for(int i = 0 ; i < log_eco_agent.length ; i++) {
    buildTable(log_eco_agent[i], col_name_eco_agent) ;
  }



  // build log Eco resume
  log_eco_resume = new Table() ;
  String [] col_name_eco_resume = new String[6] ;
  rank = 0 ;
  col_name_eco_resume[rank++] = "Time" ; 
  col_name_eco_resume[rank++] = "Frame rate" ; 
  col_name_eco_resume[rank++] = "Name" ;
  col_name_eco_resume[rank++] = "Units" ;
  col_name_eco_resume[rank++] = "Quantity" ; 
  col_name_eco_resume[rank++] = "Max" ; 
  buildTable(log_eco_resume, col_name_eco_resume) ;
  

  // build log agent global
  log_agents = new Table() ;
  String [] col_name_agents = new String[13] ;
  rank = 0 ;
  col_name_agents[rank++] = "Rank" ; 
  col_name_agents[rank++] = "Agent" ; 
  col_name_agents[rank++] = "Gen" ; 
  col_name_agents[rank++] = "Gender" ;
  col_name_agents[rank++] = "Pregnancy" ;  
  col_name_agents[rank++] = "Children" ; 
  col_name_agents[rank++] = "Heterozygous" ; 
  col_name_agents[rank++] = "Homozygous" ; 
  col_name_agents[rank++] = "Size" ;
  col_name_agents[rank++] = "Life" ;
  col_name_agents[rank++] = "Stamina" ;
  col_name_agents[rank++] = "Hunger" ;
  col_name_agents[rank++] = "Starving" ;
  buildTable(log_agents, col_name_agents) ;
}



void log_eco_agent(int which, String name, ArrayList... pop_list) {
  add_log_eco_agent(log_eco_agent[which], name, pop_list) ;
}

void log_eco_resume(float humus, float humus_max, ArrayList... pop_list) {
  add_log_eco_resume(log_eco_resume, humus, humus_max, pop_list) ;
}

void log_agent_global(String name, ArrayList... pop_list) {
  add_log_agent_global(log_agents, name, pop_list) ;
}



void log_save() {
  SEQUENCE_LOG++ ;

  // save
  for(int i = 0 ; i < log_eco_agent.length ; i++) {
    if(log_eco_agent[i].getRowCount() > 0) {
      TableRow row = log_eco_agent[i].getRow(0) ;
      String name_file = row.getString("Agent") ;
      saveTable(log_eco_agent[i], "log/Log_"+save_date()+"/ecosystem/eco_"+name_file+"_"+save_date()+".csv") ;
    }
  }
  saveTable(log_agents, "log/Log_"+save_date()+"/agent/agent_global/agent_global_"+SEQUENCE_LOG+".csv") ;
  log_agents.clearRows() ;

  saveTable(log_eco_resume, "log/Log_"+save_date()+"/ecosystem/resume/resume_"+SEQUENCE_LOG+".csv") ;
  log_eco_resume.clearRows() ;
}







// local
void add_log_eco_resume(Table table, float humus, float humus_max, ArrayList... pop_list) {
  int num_group = 0 ;
  // humus
  TableRow new_row = table.addRow() ;
  new_row.setInt("Time", SEQUENCE_LOG) ;
  new_row.setInt("Frame rate", (int)frameRate) ;
  new_row.setString("Name", "Humus") ;
  new_row.setInt("Units", 1)  ;
  new_row.setFloat("Quantity", humus)  ;
  new_row.setFloat("Max", humus_max)  ;

  // agent
  for(ArrayList list : pop_list) {
    int units = 0 ;
    int max = 0 ;
    int quantity = 0 ;
    String name = "nobody" ;
    for(Object obj : list) {
      if(obj instanceof Agent) {
        Agent_model a = (Agent_model) obj ;
        units = list.size() ;
        max += a.stamina_ref ;
        quantity += a.stamina ;
      }
      if(obj instanceof Carnivore) name = "Carnivore" ;
      if(obj instanceof Herbivore) name = "Herbivore" ;
      if(obj instanceof Omnivore) name = "Omnivore" ;
      if(obj instanceof Bacterium) name = "Bacterium" ;
      if(obj instanceof Flora) name = "Flora" ;
      if(obj instanceof Dead) name = "Dead" ;
    }
    if(units > 0) {
      new_row = table.addRow() ;
      new_row.setInt("Time", SEQUENCE_LOG) ;
      new_row.setString("Name", name) ;
      new_row.setInt("Units", units)  ;
      new_row.setInt("Quantity", quantity)  ;
      new_row.setInt("Max", max)  ;
    }
  }
}



// agent global
void add_log_agent_global(Table table, String name, ArrayList... pop_list) {
  int pop_total = 0 ;
  int rank = 0 ;
  for(int i = 0 ; i < pop_list.length ; i++) {
    pop_total += pop_list[i].size() ;
  }
  // size
  if(pop_total > 0 ) {
    for(ArrayList list : pop_list) {
      for(Object obj : list) {
        if(obj instanceof Agent_dynamic) {
          Agent_dynamic a = (Agent_dynamic) obj ;
          TableRow new_row = table.addRow() ;
          new_row.setInt("Rank", rank++) ;
          new_row.setString("Agent", a.name) ;
          new_row.setInt("Gen", a.generation) ;
          if(a.gender == 0 ) new_row.setString("Gender", "Female") ; else new_row.setString("Gender", "Male") ;
          new_row.setInt("Pregnancy", a.num_pregnancy) ;
          new_row.setInt("Children", a.num_children) ;
          new_row.setInt("Heterozygous", a.num_heterozygous) ;
          new_row.setInt("Homozygous", a.num_homozygous) ;
          new_row.setInt("Life", a.get_life()) ;
          new_row.setInt("Stamina", a.get_stamina()) ;
          new_row.setInt("Size", a.get_size()) ;
          new_row.setInt("Hunger", a.hunger) ;
          new_row.setString("Starving", String.valueOf(a.starving_bool)) ;
        }
      }
    }
  }
}
// log eco agent
void add_log_eco_agent(Table table, String name, ArrayList... pop_list) {
  // pop
  int pop_total = 0 ;
  int stamina_total = 0 ;
  int life_total = 0 ;
  int size_total = 0 ;
  // find data
  for(int i = 0 ; i < pop_list.length ; i++) {
    pop_total += pop_list[i].size() ;
  }
  // size
  if(pop_total > 0 ) {
    for(ArrayList list : pop_list) {
      for(Object obj : list) {
        if(obj instanceof Agent) {
          Agent a = (Agent) obj ;
          stamina_total += a.get_stamina() ;
          life_total += a.get_life() ;
          size_total += a.get_size() ;
        }
      }
    }
  }
  // write in table
  if(pop_list.length > 0 && pop_total > 0) {
    TableRow new_row = table.addRow() ;
    new_row.setString("Agent", name) ;
    new_row.setInt("Time", SEQUENCE_LOG) ;
    new_row.setInt("Stamina", stamina_total) ;
    if(life_total >= 0 ) new_row.setInt("Life", life_total) ;
    new_row.setInt("Size", size_total) ;
    // witout male or female
    if(pop_list.length == 1) {
      new_row.setInt("Population", pop_total) ;
    }
    // with male, female and child
    if(pop_list.length == 3) {
      new_row.setInt("Child", pop_list[0].size()) ;
      new_row.setInt("Female", pop_list[1].size()) ;
      new_row.setInt("Male", pop_list[2].size()) ;
      new_row.setInt("Population", pop_total) ;
    }      
  }
}











/**
print 0.0.2
*/
void print_info_environment(Biomass biomass) {
  println("ENVIRONMENT") ;
  println("Humus", biomass.humus) ;
}


void print_born_agent_dynamic(Agent a) {
  if(a instanceof Agent_dynamic) {
    Agent_dynamic baby = (Agent_dynamic) a ;
    println("BORN") ;
    println("name", baby.name, baby.ID) ;
    /*
    println("generation", baby.generation) ;
    println("life", baby.life) ;
    println("expectancy", baby.life_expectancy) ;
    println("size", baby.size) ;
    println("stamina", baby.stamina) ;
    println("satiate", baby.satiate) ;
    println("hunger", baby.hunger) ;
    */
  }
}


void print_death_agent(Agent_dynamic dead) {
  println("DEATH") ;
  println("name", dead.name, dead.ID) ;
  //println("generation", dead.generation) ;
  //println("life", dead.life) ;
  //println("expectancy", dead.life_expectancy) ;
  println("size", dead.size) ;
  println("stamina", dead.stamina) ;
  println("satiate", dead.satiate) ;
  println("hunger", dead.hunger) ;
  // println("velocity", dead.velocity) ;
}





void print_pop_agent_dynamic(String name, ArrayList... pop_list) {
  int pop_total = 0 ;
  for(int i = 0 ; i < pop_list.length ; i++) {
    pop_total += pop_list[i].size() ;
  }
  if(pop_list.length > 0 && pop_total > 0) {
      if(pop_list.length == 1) println(name, pop_list[0].size(), ">", pop_total) ;
      if(pop_list.length == 2) println(name, pop_list[0].size(), pop_list[1].size(), ">", pop_total) ;
      if(pop_list.length == 3) println(name, pop_list[0].size(), pop_list[1].size(),  pop_list[2].size(), ">", pop_total) ;
  }
}


/**
print by category
*/

void print_info_herbivore(String title, ArrayList<Agent> list) {
 // println(title + " POPULATION ", list.size()) ;
  for(Agent a : list) {
    if(a instanceof Herbivore) {
      Herbivore h = (Herbivore) a ;
      //  println(title + " POPULATION ", list.size()) ;
     // h.info_print() ;
     // h.info_print_motion() ;
     // h.info_print_structure() ;
     // h.info_print_life() ;
     //h.info_print_feeding() ;
     // h.info_print_hunting_picking() ;
     // h.info_print_herbivore() ;

    }

  }
}

void print_info_omnivore(String title, ArrayList<Agent> list) {
  println(title + " POPULATION ", list.size()) ;
  for(Agent a : list) {
    if(a instanceof Omnivore) {
      Omnivore o = (Omnivore) a ;
  //  println(title + " POPULATION ", list.size()) ;
        // o.info_print_agent_() ;
   // o.info_print_motion() ;
  // o.info_print_caracteristic() ;
   // o.info_print_life() ;
   // o.info_print_feeding() ;
   // o.info_print_hunting_picking() ;
   // o.info_print_herbivore() ;
    }
  }
}



void print_info_carnivore(String title, ArrayList<Agent> list) {
  println(title + " population", list.size()) ;
  for(Agent a : list) {
    if(a instanceof Carnivore) {
      Carnivore c = (Carnivore) a ;
    // a_d.info_print() ;
    // a_d.info_print_motion() ;
      c.info_print_caracteristic() ;
      c.info_print_life() ;
      c.info_print_carnivore() ;
    }
  }
}






void print_info_bacterium(String title, ArrayList<Agent> list) {
  println(title + " population ", list.size()) ;
  for(Agent a : list) {
    if(a instanceof Bacterium) {
      Bacterium b = (Bacterium) a ;
      // b.info_print() ;
      // b.info_print_motion() ;
      b.info_print_caracteristic() ;
      b.info_print_life() ;
      b.info_print_feeding() ;
      b.info_print_hunting_picking() ;
      b.info_print_life() ;
      b.info_print_bacterium() ;
    }
  }
}





/**
END INFO
*/