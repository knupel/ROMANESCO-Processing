/**
DYNAMIC SUB CLASS 
v 1.0.1

*/
/**
SUB CLASS HERBIVORE 0.2.1

*/
class Herbivore extends Agent_dynamic {

  // Herbivore(int size, int stamina, int life_expectancy, int velocity, int sense_range, String name, Vec2 sex_appeal, int gender) {
  Herbivore(Info_dict carac, Info_Object style, int gender) {

    // super(size, stamina, life_expectancy, velocity, sense_range, name, sex_appeal, gender) ;
    super(carac, style, gender) ;
    // not in the genome
    set_kill_skill(this.mass) ;
  }


  Herbivore(Genome mother, Genome father, Info_Object style) {
    super(mother,father, style) ;
    // not in the genome
    set_kill_skill(this.mass) ;
  }

  void set_kill_skill(int mass) {
    eat_zone = int(mass *1.2) ;
  }



  /**
  info
  */
  void info_visual(Vec4 colour) {
    aspect(Vec4(),colour_info(colour, satiate, pregnant, fertility), 1) ;
    Vec3 pos_temp = Vec3(0) ;
    start_matrix() ;
    translate(pos) ;
    ellipse(pos_temp.x, pos_temp.y, sense_range*2, sense_range*2) ;
    ellipse(pos_temp.x, pos_temp.y, eat_zone *2, eat_zone *2) ;
    ellipse(pos_temp.x, pos_temp.y, mass *2, mass *2) ;
    stop_matrix() ;
  }
  
  // print
  void info_print_herbivore() {
    println("INFO",this.name) ;
    println("No particular info for the moment") ;
  }
}
/**
SUB CLASS HERBIVORE

*/









/**
SUB CLASS OMNIVORE 0.2.1

*/
class Omnivore extends Agent_dynamic {
  /*
  Omnivore(int size, int stamina, int life_expectancy, int velocity, int sense_range, String name, Vec2 sex_appeal, int gender) {
    super(size, stamina, life_expectancy, velocity, sense_range, name, sex_appeal, gender) ;
    */
  Omnivore(Info_dict carac, Info_Object style, int gender) {
    super(carac, style, gender) ;
    // not in the genome
    set_kill_skill(this.mass) ;
  }


  Omnivore(Genome mother, Genome father, Info_Object style) {
    super(mother,father, style) ;
    // not in the genome
    set_kill_skill(this.mass) ;
  }

  void set_kill_skill(int mass) {
  	kill_zone = int(mass *2) +mass ;
  	eat_zone = int(mass *1.2) ;
  }

  /**
  info
  */
  void info_visual(Vec4 colour) {
    aspect(Vec4(),colour_info(colour, satiate, pregnant, fertility), 1) ;
    Vec3 pos_temp = Vec3(0) ;
    start_matrix() ;
    translate(pos) ;
    ellipse(pos_temp.x, pos_temp.y, sense_range*2, sense_range*2) ;
    ellipse(pos_temp.x, pos_temp.y, eat_zone *2, eat_zone *2) ;
    ellipse(pos_temp.x, pos_temp.y, mass *2, mass *2) ;
    stop_matrix() ;
  }
  
  // print
  void info_print_herbivore() {
    println("INFO",this.name) ;
    println("No particular info for the moment") ;
  }
}
/**
SUB CLASS OMNIVORE end

*/










/**
SUB CLASS CARNIVORE 0.2.1

*/
class Carnivore extends Agent_dynamic {
  /*
  Carnivore(int size, int stamina, int life_expectancy, int velocity, int sense_range, String name, Vec2 sex_appeal, int gender) {
  super(size, stamina, life_expectancy, velocity, sense_range, name, sex_appeal, gender) ;
  */
  Carnivore(Info_dict carac, Info_Object style, int gender) {
    super(carac, style, gender) ;
    // not in the genome
    set_kill_skill(this.mass) ;

  }

  Carnivore(Genome mother, Genome father, Info_Object style) {
    super(mother,father, style) ;
    // not in the genome
    set_kill_skill(this.mass) ;
  }


  void set_kill_skill(int mass) {
    kill_zone = int(mass *2) +mass ;
    eat_zone = int(mass *1.2) ;
  }

  /**
  info
  */
  void info_visual(Vec4 colour) {
    Vec3 pos_temp = Vec3(0) ;
    aspect(Vec4(), colour_info(colour, satiate, pregnant, fertility), 1) ;
    start_matrix() ;
    translate(pos) ;
    // info feed
    ellipse(pos_temp.x, pos_temp.y, sense_range*2, sense_range*2) ;
    ellipse(pos_temp.x, pos_temp.y, kill_zone *2, kill_zone *2) ;
    ellipse(pos_temp.x, pos_temp.y, eat_zone *2, eat_zone *2) ;
    ellipse(pos_temp.x, pos_temp.y, mass *2, mass *2) ;
    // info reproduction
    stop_matrix() ;
  }

  // print
  void info_print_carnivore() {
    println("INFO",this.name) ;
    println("time track", int(time_track));
  }
}
/**
END SUB CLASS CARNIVORE

*/
















/**
SUB CLASS BACTERIUM 0.2.0

*/
class Bacterium extends Agent_dynamic {
  float humus_prod_ratio = .25 ;
  float humus_production  ;
   Vec2 sex_appeal = Vec2() ;

  /*
  Bacterium(int size, int stamina, int life_expectancy, int velocity, int sense_range, String name, int gender) {
    super(size, stamina, life_expectancy, velocity, sense_range, name, Vec2(), gender) ;
    */
  Bacterium(Info_dict carac, Info_Object style, int gender) {
    super(carac, style, gender) ;
    set_kill_skill(this.mass) ;
  }
  
  // intern
  void set_kill_skill(int mass) {
    eat_zone = int(mass *2) ;
  }
  
  // extern
  void set_humus_prod(float prod) {
    this.humus_prod_ratio = prod ;
  }



  void watch(Agent_static a, boolean info) {
    if(dist(a.pos,pos) < sense_range && !a.alive ) {
      pos_target.set(a.pos) ;
      watching = false ; 
    } else {
      watching = true ;
    }
  }




   // Method
  void eat(Agent_static target, boolean info) {
    humus_production = 0 ;
    if(dist(target.pos,pos) < eat_zone ) {
      pos_target.set(target.pos) ;
      float calories = speed_feeding *humus_prod_ratio ;

      target.mass -= speed_feeding ;
      target.size.sub(speed_feeding *.33) ;
      hunger += (calories *digestion) ;
      humus_production = calories *humus_prod_ratio ;
      stamina += (calories *.75) ;
      eating = true ;
    } else {
      eating = false ;
    }
  }

  float get_humus_production() {
    return humus_production ;
  }


  void pick(Agent_static a) {
    if (!watching) dir.set(target_direction(a.pos,pos)) ; 
  }

  boolean picking() {
    if (watching) return false ; else return true ;
  }
  

  /**
  info
  */
  void info_visual(Vec4 colour) {
    aspect(Vec4(), colour_info(colour, satiate, pregnant, fertility), 1) ;
    Vec3 pos_temp = Vec3 (0) ;
    start_matrix() ;
    translate(pos) ;
    ellipse(pos_temp.x, pos_temp.y, sense_range*2, sense_range*2) ;
    ellipse(pos_temp.x, pos_temp.y, eat_zone *2, eat_zone *2) ;
    ellipse(pos_temp.x, pos_temp.y, mass *2, mass *2) ;
    stop_matrix() ;
  }


  // print
  void info_print_bacterium() {
    println("INFO",this.name) ;
    println("No particular info for the moment") ;
  }
}
/**
END SUB CLASS BACTERIUM

*/
/**

DYNAMIC SUB CLASS END

*/

























/**

STATIC SUB CLASS 1.0.0

*/
/**
SUB CLASS FLORA 0.2.0

*/
class Flora extends Agent_static {

   Flora(Vec3 pos, Vec3 size, int life_expectancy,  String name) {
      super(pos, size, life_expectancy, name) ;
      this.mass = int((size.x + size.y + size.z) *.33) ;
      this.stamina = this.stamina_ref = this.mass ;
   }
   /**
   Set Flora
   */
   void set_growth(int speed) {
   	this.speed_growth = speed ;
   }

   void set_need(float need) {
   	this.need = need ;
   }

   // Statement
   void statement() {
     // if(size > size_max) size = size_max ;
     if(!size.equals(size_ref)) {
      size_ref.set(size) ;
      mass = int(size.average()) ;
     }
     if(stamina > stamina_ref) stamina = stamina_ref ;
   }

   void feeding(Biomass biomass) {
      if(biomass.humus > 0) {
         if(frameCount%(180 *CLOCK) == 0 ) {
            this.mass += speed_growth ;
            this.size.add(speed_growth *.33) ;
            this.stamina += speed_growth ;
            biomass.humus_update(-need) ;
         }
      }
   }
   /**
   // info
   */
   void info_visual(Vec4 colour) {
      Vec3 pos_temp = Vec3(0) ;
      aspect(Vec4(), colour_info(colour), 1) ;
      start_matrix() ;
      translate(pos) ;
      // info feed
      strokeWeight(2) ;
      point(pos_temp) ;
      // info reproduction
      stop_matrix() ;
   }
   
   void info_print_flora() {
   	println("INFO",this.name) ;
      println("No particular info for the moment") ;
   }
}
/**
END SUB CLASS FLORA

*/











/**
SUB CLASS DEAD 0.1.0

*/
class Dead extends Agent_static {
   /**
   MUST BE IMPROVE
   */
	Dead(Vec3 pos, Vec3 size, Vec3 size_ref, int nutrient_quality, String name) {
    // int life = 0 ;
    super(pos, size, 0, name + " dead") ;

		this.nutrient_quality = nutrient_quality ;
		this.size_ref = size_ref ;
    this.mass = (int)size.average() ;
		this.alive = false ;
		Vec4 colour_of_death = Vec4(0,0,30,g.colorModeA);
		fill_style.set(colour_of_death) ;
		stroke_style.set(colour_of_death) ;

	}

   Dead(Info_dict carac, Info_Object style, int gender) {
      super(carac, style, gender) ;
      this.alive = false ;
   }

	/**
   // info
   */
   void info_visual(Vec4 colour) {
      Vec3 pos_temp = Vec3(0) ;
      aspect(Vec4(), colour_info(colour), 1) ;
      start_matrix() ;
      translate(pos) ;

      strokeWeight(2) ;
      point(pos_temp) ;
 
      stop_matrix() ;
   }
   
   
   void info_print_dead() {
   	println("INFO",this.name) ;
      println("No particular info for the moment") ;
   }
}
/**
SUB CLASS DEAD END

*/
