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
		RPE_version = "Version 0.0.4";
		RPE_pack = "Base" ;
		RPE_mode = "Tetra/Face/Line/Info" ; // separate the differentes mode by "/"
		RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Stroke hue,Stroke sat,Stroke bright,Stroke alpha,Thickness,Size X,Canvas X,Canvas Y,Canvas Z,Speed X,Quantity,Scope,Life" ;
	}






	/**
	setting
	*/
	void setup() {
		startPosition(ID_item, width/2, height/2, 0) ;
		DISPLAY_INFO = false ; ;
		ENVIRONMENT = 3 ;
		if (ENVIRONMENT == 3 ) {
	    Vec3 pos_box = Vec3(width/2,height/2,0) ;
	    int scale_box = 4 ;
	    // Vec3 size_box = Vec3(canvas_x_item[ID_item] *scale_box, canvas_y_item[ID_item] *scale_box, canvas_z_item[ID_item] *scale_box) ;
	    Vec3 size_box = Vec3(width *scale_box, width *scale_box, width *scale_box) ;
	    build_environment(pos_box, size_box) ;
	  } else {
	    Vec2 pos_box = Vec2(width/2,height/2) ;
	    Vec2 size_box = Vec2(width,height) ;
	    build_environment(pos_box, size_box) ;
	  }
	  
	  float quantity = .2 ;
	  float life = .5 ;
	  float size = width/5 ; // it's like a first third part of the slider I think ????
	  float speed = .3 ;
	  float scope = .3 ;
	  ecosystem_setting(quantity, life, size, speed, scope) ;
	}











	/**
	draw / display
	*/
	boolean tetra_face, poly_face, poly_line  ;
	int flora_costume, corpse_costume, carnivore_costume, herbivore_costume, bacterium_costume  ;
	
	void draw() {
		// info
		// print_info_carnivore(CARNIVORE_LIST) ;
		// costume
		if(tetra_face) {
			flora_costume = corpse_costume = carnivore_costume = herbivore_costume = bacterium_costume = TETRAHEDRON_RPE ;
		} else if (poly_face) {
			flora_costume = SPHERE_LOW_RPE ;
			herbivore_costume = TETRAHEDRON_RPE ;
			carnivore_costume = CROSS_3_RPE ;
			bacterium_costume = CROSS_2_RPE ;
			corpse_costume = BOX_RPE ;
		} else if (poly_line) {
			flora_costume = 1002 ;
			herbivore_costume = 1002 ;
			carnivore_costume = 1005 ;
			bacterium_costume = 1003 ;
			corpse_costume = 1001 ;
		}

		// set colour
		Vec4 fill_flora = Vec4(hue(fill_item[ID_item]), saturation(fill_item[ID_item]), brightness(fill_item[ID_item]),alpha(fill_item[ID_item])) ;
		Vec4 stroke_flora = Vec4(hue(stroke_item[ID_item]), saturation(stroke_item[ID_item]), brightness(stroke_item[ID_item]),alpha(stroke_item[ID_item])) ;
		Vec4 fill_herbivore = Vec4(fill_flora) ;
		Vec4 stroke_herbivore = Vec4(stroke_flora) ;
		Vec4 fill_carnivore = Vec4(fill_flora) ;
		Vec4 stroke_carnivore = Vec4(stroke_flora) ;
		Vec4 fill_bacterium = Vec4(fill_flora) ;
		Vec4 stroke_bacterium = Vec4(stroke_flora) ;
		Vec4 fill_corpse = Vec4(fill_flora) ;
		Vec4 stroke_corpse = Vec4(stroke_flora) ;

		// calcul the reflect color
		float target_colour_herbivore = -60 ;
		float target_colour_carnivore = -95 ;
		float target_colour_bacterium = 120 ;
		float target_colour_corpse = 120 ;
		fill_herbivore.x = map_cycle(target_colour_herbivore +fill_flora.x, 0,360) ;
		fill_carnivore.x = map_cycle(target_colour_carnivore +fill_flora.x, 0,360) ;
		fill_bacterium.x = map_cycle(target_colour_bacterium +fill_flora.x, 0,360) ;
		fill_corpse.x = map_cycle(target_colour_corpse +fill_flora.x, 0,360) ;
		
		stroke_herbivore.x = map_cycle(target_colour_herbivore +stroke_flora.x, 0,360) ;
		stroke_carnivore.x = map_cycle(target_colour_carnivore +stroke_flora.x, 0,360) ;
		stroke_bacterium.x = map_cycle(target_colour_bacterium +stroke_flora.x, 0,360) ;
		stroke_corpse.x = map_cycle(target_colour_corpse +stroke_flora.x, 0,360) ;

      float temp_fill_corps_y = fill_corpse.y ;
      float temp_stroke_corps_y = stroke_corpse.y ;
      fill_corpse.y *= .1 ;
		stroke_corpse.y *= .1 ;
		float temp_fill_corps_z = fill_corpse.z ;
      float temp_stroke_corps_z = stroke_corpse.z ;
      fill_corpse.z *= .3 ;
		stroke_corpse.z *= .3 ;


		set_colour_flora(fill_flora, stroke_flora, thickness_item[ID_item]) ;
		set_colour_herbivore(fill_herbivore, stroke_herbivore, thickness_item[ID_item]) ;
		set_colour_carnivore(fill_carnivore, stroke_carnivore, thickness_item[ID_item]) ;
		set_colour_bacterium(fill_bacterium, stroke_bacterium, thickness_item[ID_item]) ;
		set_colour_corpse(fill_corpse, stroke_corpse, thickness_item[ID_item]) ;

		fill_corpse.y = temp_fill_corps_y ;
		stroke_corpse.y = temp_stroke_corps_y ;
		fill_corpse.z = temp_fill_corps_z ;
		stroke_corpse.z = temp_stroke_corps_z ;

		flora(FLORA_LIST, DISPLAY_INFO, flora_costume) ;
		herbivore(HERBIVORE_LIST, FLORA_LIST, DISPLAY_INFO, herbivore_costume) ;
		carnivore(CARNIVORE_LIST, HERBIVORE_LIST, CORPSE_LIST, DISPLAY_INFO, carnivore_costume) ;
		bacterium(BACTERIUM_LIST, CORPSE_LIST, DISPLAY_INFO, bacterium_costume) ;
		corpse(CORPSE_LIST, DISPLAY_INFO, corpse_costume) ;


		// mode
		/*
			"Tetra/Face/Line/Info"
	boolean tetra_face, poly_face, poly_line  ;
	*/
		if(mode[ID_item] == 0 ) {
			tetra_face = true ;
			poly_face = false ;
			poly_line = false ;
			DISPLAY_INFO = false ;
		} else if(mode[ID_item] == 1 ) {
			tetra_face = false ;
			poly_face = true ;
			poly_line = false ;
			DISPLAY_INFO = false ;
		} else if(mode[ID_item] == 2 ) {
			tetra_face = false ;
			poly_face = false ;
			poly_line = true ;
			DISPLAY_INFO = false ;
		} else if(mode[ID_item] == 3 ) {
			tetra_face = false ;
			poly_face = false ;
			poly_line = false ;
			DISPLAY_INFO = true ;
		}



      // add flora
		if(action[ID_item]  && nTouch) {
			ecosystem_setting(quantity_item[ID_item], life_item[ID_item], size_x_item[ID_item], speed_x_item[ID_item], scope_item[ID_item]) ;
		}
	}


	void ecosystem_setting(float quantity, float life, float size, float speed, float scope) {
		clear_ecosystem() ;
		// QUANTITY
		float factor_num = 1 ;
		if(!FULL_RENDERING) factor_num = .1 ;
		int num_flora = ceil(800 *quantity *factor_num) ;
		int num_herbivore = ceil(400 *quantity *factor_num) ; 
		int num_carnivore = ceil(4 *quantity *factor_num) ; 
		int num_bacterium = ceil(8 *quantity *factor_num) ;

		// Colour
		Vec4 colour_flora = Vec4(100,100,80,100) ;
		Vec4 colour_herbivore = Vec4(50,100,100,100) ;
		Vec4 colour_carnivore = Vec4(0,100,100,100)  ; 
		Vec4 colour_bacterium = Vec4(30,0,30,100) ;

		// Size
		int size_flora = ceil(.01 *size) ;
		int size_herbivore = ceil(.15 *size) ;
		int size_carnivore = ceil(.45 *size);
		int size_bacterium = ceil(.01 *size) ;

		// Life
		int life_herbivore = ceil(500 *life) ;
		int life_carnivore = ceil(1000  *life) ;
		int life_bacterium = ceil(10000  *life) ;

		// Velocity
		int velocity_herbivore = ceil(6 *speed) ;
		int velocity_carnivore = ceil(12 *speed) ;
		int velocity_bacterium = ceil(2 *speed) ;

		//Radar
		float radar_herbivore = .01 *scope;
		float radar_carnivore = .04 *scope ;
		float radar_bacterium = .24 *scope ;
		if(ENVIRONMENT == 3) {
			// in 3D it's necessary to give very very bigger range for the radar.
			int ratio_range_radar = 5 ;
			radar_herbivore *= ratio_range_radar ;
			radar_carnivore *= ratio_range_radar ;
			radar_bacterium *= ratio_range_radar ;
		}
		// BUILD
		build_flora(size_flora, colour_flora, num_flora) ;
		build_herbivore(size_herbivore, life_herbivore, velocity_herbivore, radar_herbivore, colour_herbivore, num_herbivore) ;
		build_carnivore(size_carnivore, life_carnivore, velocity_carnivore, radar_carnivore, colour_carnivore, num_carnivore) ;
		build_bacterium(size_bacterium, life_bacterium, velocity_bacterium, radar_bacterium, colour_bacterium, num_bacterium) ;
	}
	














	/**
	ANNEXE METHODE
	*/
	/**
	UPDATE ECOSYSTEME 0.0.3
	*/

	/**
	BIOTOPE
	*/
	Vec4 biotope_colour() {
	  float normal_humus_level = 1 - HUMUS / HUMUS_MAX ;
	  float var_colour_ground = 90 *normal_humus_level ;
	  return Vec4(40,90, 5 +var_colour_ground,100) ;
	}
	/**
	End biotope
	*/













	/**
	Flora update 0.0.2
	*/
	void flora(ArrayList<Flora> list_f, boolean info, int which_costume) {

	  // remove
	  for(Flora f : list_f) {
	    if(f.life < 0 ) {
	      list_f.remove(f) ;
	      break ;
	    }
	  }

	  // life of the agent
	  for(Flora f : list_f) {
	    // info
	    float ratio = float(f.size) / float(f.size_ref) ;
	    float alpha = g.colorModeA *ratio ;
	    if(alpha <= 0) alpha = .001 ;
	    f.colour.set(f.colour.r, f.colour.g, f.colour.b, alpha) ;
	    // update
	    f.growth() ;
	    f.statement() ;

	    // display
	    if(original_flora_aspect) f.aspect(f.colour, f.colour, 1) ; else f.aspect(fill_colour_flora, stroke_colour_flora, thickness_flora) ;
	    if(!info) f.costume_agent(which_costume) ; 
	    else f.info_visual_text(f.colour, SIZE_TEXT_INFO) ; 
	  }
	}
	 /**
	 set colour
	 */
	boolean original_flora_aspect = true ;
	Vec4 fill_colour_flora, stroke_colour_flora ;
	float thickness_flora ; 
	void set_colour_flora(Vec4 fill_colour, Vec4 stroke_colour, float thickness) {
	  original_flora_aspect = false ;
	  if(fill_colour_flora == null) fill_colour_flora = Vec4(fill_colour) ; else fill_colour_flora.set(fill_colour) ;
	  if(stroke_colour_flora == null) stroke_colour_flora = Vec4(stroke_colour) ; else stroke_colour_flora.set(stroke_colour) ;
	  thickness_flora = thickness ;
	}
	/**
	End flora
	*/






















	/**
	HERBIVORE update 0.0.2
	*/
	void herbivore(ArrayList<Herbivore> list_h, ArrayList<Flora> list_f, boolean info, int which_costume) {

	  // remove and add in the corpse list of dead body
	  for(Herbivore h : list_h) {
	    if(!h.alive) {
	      CORPSE_LIST.add(h) ;
	      list_h.remove(h) ;
	      break ;
	    }
	  }

	  // life of the agent
	  for(Herbivore h : list_h) {
	    int radius = h.size ;
	    // motion
	    h.rebound(LIMIT, REBOUND) ;
	    h.motion() ;
	    h.set_position() ;
	    h.set_starving(4) ;

	    // pick
	    if(!h.calm) pick_static_agent(h, list_f, info) ;

	    // time to eat
	    eat_flora(h, list_f, info) ;

	    // statement
	    h.statement() ;
	    h.hunger() ;

	    // display
	    if(original_herbivore_aspect) h.aspect(h.colour, h.colour, 1)  ; else h.aspect(fill_colour_herbivore, stroke_colour_herbivore, thickness_herbivore) ;
	    if(!info) h.costume_agent(which_costume) ; 
	    else h.info(h.colour, SIZE_TEXT_INFO) ;
	  }
	}
	 /**
	 set colour
	 */
	boolean original_herbivore_aspect = true ;
	Vec4 fill_colour_herbivore, stroke_colour_herbivore ;
	float thickness_herbivore ; 
	void set_colour_herbivore(Vec4 fill_colour, Vec4 stroke_colour, float thickness) {
	  original_herbivore_aspect = false ;
	  if(fill_colour_herbivore == null) fill_colour_herbivore = Vec4(fill_colour) ; else fill_colour_herbivore.set(fill_colour) ;
	  if(stroke_colour_herbivore == null) stroke_colour_herbivore = Vec4(stroke_colour) ; else stroke_colour_herbivore.set(stroke_colour) ;
	  thickness_herbivore = thickness ;
	}
	 /**
	local method
	*/
	void eat_flora(Herbivore h, ArrayList<Flora> list_flora_target, boolean info) {
	  if(h.eating) {
	    Flora target ;
	    target = list_flora_target.get((int)h.ID_target.x) ;
	    h.eat(target, info) ;
	  } else {
	    for(Flora target : list_flora_target) {
	      h.eat(target, info) ;
	      if(h.eating) {
	        h.ID_target.set(list_flora_target.indexOf(target),target.ID) ;
	        break ;
	      }
	    }
	  }
	}


	void pick_static_agent(Herbivore h, ArrayList<Flora> list_flora_target, boolean info) {
	  for(Flora target : list_flora_target) {
	    h.watch(target, info) ;
	    h.pick(target) ;
	    if(h.picking()) break ;
	  }
	}
	/**
	End herbivore update
	*/



























	/**
	CARNIVORE update 0.0.2
	*/
	void carnivore(ArrayList<Carnivore> list_carnivore, ArrayList<Herbivore> list_herbivore, ArrayList<Agent> list_dead_body, boolean info, int which_costume) {

	  /// remove and add in the corpse list of dead body
	  for(Carnivore c : list_carnivore) {
	    if(!c.alive) {
	      CORPSE_LIST.add(c) ;
	      list_carnivore.remove(c) ;
	      break ;
	    }
	  }

	  // life of the agent
	  for(Carnivore c : list_carnivore) {
	    // motion
	    c.motion() ;
	    int radius = c.size ;
	    c.rebound(LIMIT, REBOUND) ;
	    c.set_position() ;
	    c.set_starving(8) ;

	    

	    // hunt
	    if(!c.calm) hunt_dynamic_agent(c, list_herbivore, info) ;    
	    // eat after hunt, if this order is not respect the carnivore prefere hunt to eat and finish to die :)
	    if(list_dead_body.size() >= 0 ) eat_meat(c, list_dead_body, info) ; else c.eating = false ;


	    c.statement() ;
	    c.hunger() ;


	    // display
	    if(original_carnivore_aspect) c.aspect(c.colour, c.colour, 1) ; else c.aspect(fill_colour_carnivore, stroke_colour_carnivore, thickness_carnivore) ;
	    if(!info) c.costume_agent(which_costume) ; 
	    else c.info(c.colour, SIZE_TEXT_INFO) ;
	  }
	}
	 /**
	 set colour
	 */
	boolean original_carnivore_aspect = true ;
	 Vec4 fill_colour_carnivore, stroke_colour_carnivore ;
	 float thickness_carnivore ; 
	void set_colour_carnivore(Vec4 fill_colour, Vec4 stroke_colour, float thickness) {
	  original_carnivore_aspect = false ;
	  if(fill_colour_carnivore == null) fill_colour_carnivore = Vec4(fill_colour) ; else fill_colour_carnivore.set(fill_colour) ;
	  if(stroke_colour_carnivore == null) stroke_colour_carnivore = Vec4(stroke_colour) ; else stroke_colour_carnivore.set(stroke_colour) ;
	  thickness_carnivore = thickness ;
	}

	/**
	local method eat
	*/
	void eat_meat(Carnivore c, ArrayList<Agent> list_agent_target, boolean info) {
	  // first eat the agent who eat just before without look in the list
	  if(c.eating) {
	    int pointer = (int)c.ID_target.x ;
	    int ID_target = (int)c.ID_target.y ;
	    /* here we point directly in a specific point of the list, 
	    if the pointer is superior of the list, 
	    because if it's inferior a corpse can be eat by an other Agent */
	    if(pointer < list_agent_target.size() ) {
	      Agent target = list_agent_target.get((int)c.ID_target.x) ;
	      /* if the entry point of the list return an agent 
	      with a same ID than a ID_target corpse eat just before, 
	      the Carnivore can continue the lunch */
	      if (target.ID == ID_target ) c.eat(target, info) ; 
	      else {
	        /* If the ID returned is different, a corpse was leave from the list, 
	        and it's necessary to check in the full ist to find if any corpse have a seme ID */
	        for(Agent target_in_list : list_agent_target) {
	          if (target_in_list.ID == ID_target ) c.eat(target_in_list, info) ; else c.eating = false ;
	        }
	      }
	    }
	  /* If the last research don't find the corpse, may be this one is return to dust ! */
	  } else {
	    for(Agent target : list_agent_target) {
	      c.eat(target, info) ;
	      if(c.eating) {
	        c.ID_target.set(list_agent_target.indexOf(target),target.ID) ;
	        break ;
	      }
	    }
	  }
	}




	/**
	local method hunt
	*/

	void hunt_dynamic_agent(Carnivore c, ArrayList<Herbivore> list_herbivore_target, boolean info) {
	  // first watch the agent who watch just before without look in the list
	  if(c.watching) find_target(c, list_herbivore_target, info) ;
	  if(c.tracking && c.max_time_track > c.time_track) focus_on_target(c, list_herbivore_target, info) ; else c.hunt_stop() ;
	}



	// Local method : The hunt is launching !
	void focus_on_target(Carnivore c, ArrayList<Herbivore> list_herbivore_target, boolean info) {
	  int pointer = (int)c.ID_target.x ;
	  int ID_target = (int)c.ID_target.y ;
	  /* here we point directly in a specific point of the list, 
	  if the pointer is superior of the list, 
	  because if it's inferior a corpse can be watch by an other Agent */
	  if(pointer < list_herbivore_target.size() ) {
	    Herbivore target = list_herbivore_target.get((int)c.ID_target.x) ;
	    /* if the entry point of the list return an agent 
	    with a same ID than a ID_target agent watch just before, 
	    the Carnivore can continue the track */
	    if (target.ID == ID_target ) {
	      hunt_and_kill(c, target, info) ; 
	    } else {
	      /* If the ID returned is different, a target was leave from the list, 
	      and it's necessary to check in the full ist to find if any agent have a same ID */
	      for(Herbivore target_in_list : list_herbivore_target) {
	        if (target_in_list.ID == ID_target ) {
	          hunt_and_kill(c, target_in_list, info) ;
	        } else {
	          c.hunt_stop() ;
	        } 
	      }
	    }
	  } else c.hunt_stop() ;
	}
	// super local method
	void hunt_and_kill(Carnivore c, Agent target, boolean info) {
	  if(c.dist_to_target(target, info) < c.radar) {
	    c.hunt(target, info) ; 
	    c.kill(target, info) ;
	  } else c.hunt_stop() ;
	}




	// Local method : Find target is the Big Carnivore Brother is watching you !
	void find_target(Carnivore c, ArrayList<Herbivore> list_herbivore_target, boolean info) {
	  // float [] dist_list = new float[0] ;
	  ArrayList <Vec3> closest_target = new ArrayList<Vec3>() ;
	  // find the closest target 
	  for(Herbivore target : list_herbivore_target) {
	    if(c.dist_to_target(target, info) < c.radar) {
	      float dist = c.dist_to_target(target, info) ;
	      /*catch distance to compare with the last one
	      plus catch index in the list and the ID target
	      and add in the nice target list
	      */
	      Vec3 new_target = Vec3(dist, list_herbivore_target.indexOf(target), target.ID) ;
	      closest_target.add(new_target) ;
	      // compare the target to see which one is the closest.
	      if(closest_target.size() > 1) if (closest_target.get(1).x <= closest_target.get(0).x ) closest_target.remove(0) ; else closest_target.remove(1) ;
	    } 
	  }
	  // Start the hunt party with the selected target
	  if(closest_target.size() > 0 ) {
	    Herbivore target = list_herbivore_target.get((int)closest_target.get(0).y) ;
	    c.hunt(target, info) ;
	    c.kill(target, info) ;
	    if(c.tracking) c.ID_target.set(list_herbivore_target.indexOf(target),target.ID) ;
	  }
	}

	/**
	End carnivore update
	*/

























	/**
	Bacterium update 0.0.2
	*/
	void bacterium(ArrayList<Bacterium> list_bacterium, ArrayList<Agent> list_dead_body, boolean info, int which_costume) {
	  // remove bacterium
	  for(Bacterium b : list_bacterium) {
	    if(b.size < 0 ) {
	      list_bacterium.remove(b) ;
	      break ;
	    }
	  }


	  // life of the agent
	  for(Bacterium b : list_bacterium) {
	    int radius = b.size ;
	    // motion
	    b.rebound(LIMIT, REBOUND) ;
	    b.motion() ;
	    b.set_position() ;
	    b.set_starving(2) ;

	    // hunt
	    if(!b.calm) hunt_static_agent(b, list_dead_body, info) ;
	    // eat
	    if(list_dead_body.size() >= 0 ) eat_corpse(b, list_dead_body, info) ; else b.eating = false ;
	    
	    // statement
	    b.statement() ;
	    b.hunger() ;

	    // display
	    if(original_bacterium_aspect) b.aspect(b.colour, b.colour, 1) ; else b.aspect(fill_colour_bacterium, stroke_colour_bacterium, thickness_bacterium) ;
	    if(!info) b.costume_agent(which_costume) ; 
	    else b.info(b.colour, SIZE_TEXT_INFO) ;
	  }
	}

	 /**
	set colour
	*/
	boolean original_bacterium_aspect = true ;
	 Vec4 fill_colour_bacterium, stroke_colour_bacterium ;
	 float thickness_bacterium ; 
	void set_colour_bacterium(Vec4 fill_colour, Vec4 stroke_colour, float thickness) {
	  original_bacterium_aspect = false ;
	  if(fill_colour_bacterium == null) fill_colour_bacterium = Vec4(fill_colour) ; else fill_colour_bacterium.set(fill_colour) ;
	  if(stroke_colour_bacterium == null) stroke_colour_bacterium = Vec4(stroke_colour) ; else stroke_colour_bacterium.set(stroke_colour) ;
	  thickness_bacterium = thickness ;
	}


	// local method
	void eat_corpse(Bacterium b, ArrayList<Agent> list_corpse_target, boolean info) {
	// first eat the agent who eat just before without look in the list
	  if(b.eating) {
	    int pointer = (int)b.ID_target.x ;
	    int ID_target = (int)b.ID_target.y ;
	    /* here we point directly in a specific point of the list, 
	    if the pointer is superior of the list, 
	    because if it's inferior a corpse can be eat by an other Agent */
	    if(pointer < list_corpse_target.size() ) {
	      Agent target = list_corpse_target.get((int)b.ID_target.x) ;
	      /* if the entry point of the list return an agent 
	      with a same ID than a ID_target corpse eat just before, 
	      the Carnivore can continue the lunch */
	      if (target.ID == ID_target ) b.eat(target, info) ; 
	      else {
	        /* If the ID returned is different, a corpse was leave from the list, 
	        and it's necessary to check in the full ist to find if any corpse have a seme ID */
	        for(Agent target_in_list : list_corpse_target) {
	          if (target_in_list.ID == ID_target ) b.eat(target_in_list, info) ; else b.eating = false ;
	        }
	      }
	    }
	  /* If the last research don't find the corpse, may be this one is return to dust ! */
	  } else {
	    for(Agent target : list_corpse_target) {
	      b.eat(target, info) ;
	      if(b.eating) {
	        b.ID_target.set(list_corpse_target.indexOf(target),target.ID) ;
	        break ;
	      }
	    }
	  }
	}


	void hunt_static_agent(Bacterium b, ArrayList<Agent> list_target, boolean info) {
	  for(Agent target : list_target) {
	    b.watch(target, info) ;
	    b.pick(target) ;
	    if(b.picking()) break ;
	  }
	}
	/**
	End bacterium
	*/













	/**
	CORPSE || DEAD BODY update 0.0.2
	*/
	void corpse(ArrayList<Agent> list_dead_body, boolean info, int which_costume) {
	  // the dead body is burried !
	  for(Agent corpse : list_dead_body) {
	    if(corpse.size < 0) {
	      list_dead_body.remove(corpse) ;
	      break ;
	    }
	  }
	  // Dead bobies is undead
	  for(Agent corpse : list_dead_body) {
	    Vec4 colour_of_death = Vec4(0,0,30,g.colorModeA); 

	    corpse.set_colour(colour_of_death) ;
	    corpse.carrion() ;

	    // display
	    if(original_corpse_aspect) corpse.aspect(corpse.colour, corpse.colour, 1) ; else corpse.aspect(fill_colour_corpse, stroke_colour_corpse, thickness_corpse) ;
	    if(!info) corpse.costume_agent(which_costume) ; 
	    else {
	      corpse.info_visual(corpse.colour) ;
	      corpse.info_text(corpse.colour, SIZE_TEXT_INFO) ;
	    }
	  }
	}
	 /**
	set colour
	*/
	boolean original_corpse_aspect = true ;
	 Vec4 fill_colour_corpse, stroke_colour_corpse ;
	 float thickness_corpse ; 
	void set_colour_corpse(Vec4 fill_colour, Vec4 stroke_colour, float thickness) {
	  original_corpse_aspect = false ;
	  if(fill_colour_corpse == null) fill_colour_corpse = Vec4(fill_colour) ; else fill_colour_corpse.set(fill_colour) ;
	  if(stroke_colour_corpse == null) stroke_colour_corpse = Vec4(stroke_colour) ; else stroke_colour_corpse.set(stroke_colour) ;
	  thickness_corpse = thickness ;
	}
	/**
	END CORPSE || DEAD BODY update 0.0.2
	*/
	/**
	END UPDATE ECOSYSTEME 0.0.3
	*/







































	/**
	MANAGE ECOSYSTEM BUILT 0.0.5
	*/
	/**
	LIST
	*/
	ArrayList<Flora> FLORA_LIST = new ArrayList<Flora>() ;
	ArrayList<Bacterium> BACTERIUM_LIST = new ArrayList<Bacterium>() ;
	ArrayList<Herbivore> HERBIVORE_LIST = new ArrayList<Herbivore>() ;
	ArrayList<Carnivore> CARNIVORE_LIST = new ArrayList<Carnivore>() ;
	ArrayList<Agent> CORPSE_LIST = new ArrayList<Agent>() ;


	/**
	Clear ecosysteme
	*/
	void clear_ecosystem() {
	  FLORA_LIST.clear() ;
	  BACTERIUM_LIST.clear() ;
	  HERBIVORE_LIST.clear() ;
	  CARNIVORE_LIST.clear() ;
	  CORPSE_LIST.clear() ;
	}


	/**
	ENVIRONMENT
	*/
	Vec3 BOX = Vec3(100,100,100) ;
	Vec3 BOX_POS = Vec3() ;
	Vec6 LIMIT = Vec6(0,BOX.x,0,BOX.y,0,BOX.z) ;
	boolean REBOUND ;
	int SIZE_TEXT_INFO ;
	float HUMUS, HUMUS_MAX ;
	int ENVIRONMENT = 3 ; // 2 is for 2D, 3 for 3D
	boolean DISPLAY_INFO = false ;
	/**
	* Create enviromnent where the ecosystem will be live
	*/
	void build_environment(Vec2 pos, Vec2 size) {
	  Vec3 pos_3D = Vec3(pos.x, pos.y,0) ;
	  Vec3 size_3D = Vec3(size.x, size.y,0) ;
	  build_environment(pos_3D, size_3D) ;
	  // write here to be sure the Environment have a good info
	  ENVIRONMENT = 2 ; 
	}

	void build_environment(Vec3 pos, Vec3 size) {
	  BOX_POS.set(pos) ;
	  BOX.set(size) ;

	  float left = BOX_POS.x - (BOX.x *.5) ;
	  float right = BOX_POS.x + (BOX.x *.5) ;
	  float top = BOX_POS.y - (BOX.y *.5) ;
	  float bottom = BOX_POS.y + (BOX.y *.5) ;
	  float front = BOX_POS.z - (BOX.z *.5) ;
	  float back = BOX_POS.z + (BOX.z *.5) ;
	  LIMIT.set(left,right, top, bottom, front, back) ;

	  REBOUND = false ;
	  SIZE_TEXT_INFO = 18 ;
	  HUMUS_MAX = HUMUS = BOX.x *BOX.y *.01 ;
	}








	/**
	FLORA
	*/
	/**
	* build the plant of the ecosystem
	*/
	void build_flora(int size_template, Vec4 colour, int num) {
	  for(int i = 0 ; i < num ; i++) {
	    int size = int(random(ceil(size_template *.5), ceil(size_template*3))) ;
	    String name = "salad" ;
	    if(ENVIRONMENT == 2 ) {
	      Vec2 pos = Vec2("RANDOM RANGE",(int)LIMIT.a, (int)LIMIT.b, (int)LIMIT.c, (int)LIMIT.d) ;
	      add_flora(pos, size, name, colour) ;
	    } else if (ENVIRONMENT == 3 ) {
	      Vec3 pos = Vec3("RANDOM RANGE",(int)LIMIT.a, (int)LIMIT.b, (int)LIMIT.c, (int)LIMIT.d, (int)LIMIT.e, (int)LIMIT.f) ;
	      add_flora(pos, size, name, colour) ;
	    }
	  }
	}

	void add_flora(Vec2 pos, int size, String name, Vec4 colour) {
	   Vec3 final_pos =  Vec3(pos.x,pos.y,0) ;
	   add_flora(final_pos, size, name, colour) ;
	}
	void add_flora(Vec3 pos, int size, String name, Vec4 colour) {
	   Flora f = new Flora(pos, size, name) ;
	   FLORA_LIST.add(f) ;
	   f.set_colour(colour) ;
	   f.set_growth(2) ;
	   f.set_need(.5) ;
	}


	/**
	// AGENT
	*/
	/**
	// BACTERIUM
	*/
	void build_bacterium(int size, int life, int velocity, float radar, Vec4 colour, int num) {
		for(int i = 0 ; i < num ; i++) {
			String name = "bacterium" ;
			if(ENVIRONMENT == 2 ) {
				Vec2 pos = Vec2("RANDOM RANGE",(int)LIMIT.a, (int)LIMIT.b, (int)LIMIT.c, (int)LIMIT.d) ;
				add_bacterium(pos, size, life, velocity, radar, name, colour) ;
			} else {
				Vec3 pos = Vec3("RANDOM RANGE",(int)LIMIT.a, (int)LIMIT.b, (int)LIMIT.c, (int)LIMIT.d, (int)LIMIT.e, (int)LIMIT.f) ;
				add_bacterium(pos, size, life, velocity, radar, name, colour) ;

			}
		}
	}

	void add_bacterium(Vec2 pos, int size, int life, int velocity, float radar, String name, Vec4 colour) {
		Vec3 final_pos = Vec3(pos) ;
		add_bacterium(final_pos, size, life, velocity, radar, name, colour) ;
	}

	void add_bacterium(Vec3 pos, int size, int life, int velocity, float radar, String name, Vec4 colour) {
	  Bacterium b = new Bacterium(pos, size, life, velocity, radar, name) ;
	  BACTERIUM_LIST.add(b) ;
	  b.set_colour(colour) ;
	}




	/**
	// HERBIVORE
	*/

	void build_herbivore(int size, int life, int velocity, float radar, Vec4 colour, int num) {
		for(int i = 0 ; i < num ; i++) {
			String name = "human" ;
			if(ENVIRONMENT == 2 ) {
				Vec2 pos = Vec2("RANDOM RANGE",(int)LIMIT.a, (int)LIMIT.b, (int)LIMIT.c, (int)LIMIT.d) ;
				add_herbivore(pos, size, life, velocity, radar, name, colour) ;
			} else {
				Vec3 pos = Vec3("RANDOM RANGE",(int)LIMIT.a, (int)LIMIT.b, (int)LIMIT.c, (int)LIMIT.d, (int)LIMIT.e, (int)LIMIT.f) ;
				add_herbivore(pos, size, life, velocity, radar, name, colour) ;
			}
		}
	}

	void add_herbivore(Vec2 pos, int size, int life, int velocity, float radar, String name, Vec4 colour) {
	   Vec3 final_pos = Vec3(pos) ;
	   add_herbivore(final_pos, size, life, velocity, radar, name, colour) ;
	}

	void add_herbivore(Vec3 pos, int size, int life, int velocity, float radar, String name, Vec4 colour) {
	   Herbivore h = new Herbivore(pos, size, life, velocity, radar, name) ;
	   HERBIVORE_LIST.add(h) ;
	   h.set_meat_quality(4) ;
	   h.set_colour(colour) ;
	   h.set_gourmet(3.5) ;
	}



	/**
	// CARNIVORE
	*/

	void build_carnivore(int size, int life, int velocity, float radar, Vec4 colour, int num) {
		for(int i = 0 ; i < num ; i++) {
			String name = "ALIEN" ;
			if(ENVIRONMENT == 2 ) {
				Vec2 pos = Vec2("RANDOM RANGE",(int)LIMIT.a, (int)LIMIT.b, (int)LIMIT.c, (int)LIMIT.d) ;
				add_carnivore(pos, size, life, velocity, radar, name, colour) ;
			} else {
				Vec3 pos = Vec3("RANDOM RANGE",(int)LIMIT.a, (int)LIMIT.b, (int)LIMIT.c, (int)LIMIT.d, (int)LIMIT.e, (int)LIMIT.f) ;
				add_carnivore(pos, size, life, velocity, radar, name, colour) ;
			}
		}
	}

	void add_carnivore(Vec2 pos, int size, int life, int velocity, float radar, String name, Vec4 colour) {
	   Vec3 final_pos = Vec3(pos) ;
	   add_carnivore(final_pos, size, life, velocity, radar, name, colour) ;
	}
	void add_carnivore(Vec3 pos, int size, int life, int velocity, float radar, String name, Vec4 colour) {
	   Carnivore c = new Carnivore(pos, size, life, velocity, radar, name) ;
	   CARNIVORE_LIST.add(c) ;
	   c.set_colour(colour) ;
	   c.set_gourmet(2.5) ;
	}
	/**
	END BUILT
	*/



































	/**
	CLASS AGENT

	*/
  /**
  CLASS AGENT 0.0.5
  */
  class Agent implements RULES_ECOSYSTEME {
    String name ;
    int ID = 0 ;
    Vec2 ID_target = Vec2(-1) ;

    boolean watching = true   ;
    boolean alive = true ;
    boolean carrion ;
    boolean calm ;
    boolean eating ;
    boolean tracking ;


    int age = 0 ;
    int life_expectancy = 1 ;
    int dead_since = 0 ;
    int life, life_max ;

    Vec3 pos, motion, direction ;
    Vec3 velocity_xyz ;
    Vec4 colour = Vec4(0,0,0,g.colorModeA) ;
    int velocity, velocity_ref ;

    int size, size_ref ;

    int meat_quality ;

    int radar ;
    int speed_eating = 1 ;
    int eat_zone ;
    int greed = int(180 *CLOCK) ; // num of frame before stop to eat :)
    float gourmet = 2. ;
    int digestion = 2 ;
    
    // watching variable
    int size_target ;
    int time_watching = 0 ;
    int max_watching = 600 ;


    int step_hunger ;
    int hunger  ;
    int starving = 1 ;

    Agent(Vec3 pos, int size, int life, int velocity, String name) {
      this.name = name ;
      this.ID = int(random(1000000)) ;
      this.colour.set(colour) ;

      this.size = this.size_ref = size ;
      this.life_max = this.life = life ;

      this.pos = pos ;
      this.velocity = this.velocity_ref = velocity ;
      motion = Vec3(pos) ; ;
      direction = Vec3("RANDOM",1) ;
      velocity_xyz = Vec3() ;

      // statement
      step_hunger = (size + life)/2 *((life_expectancy -age)/life_expectancy) ;
      hunger = 0 ;
      meat_quality = 1 ;
    }



    /**
    //SET AGENT
    */
    void set_agent(int step_hunger, int hunger, int meat_quality, int speed_eating) {
      set_meat_quality(meat_quality) ;
      set_step_hunger(step_hunger) ;
      set_hunger(hunger) ;
      set_speed_eating(speed_eating) ;
    }
    

    void set_greed(int greed) {
      this.greed = int(greed *CLOCK) ;
    }

    void set_starving(int starving) {
      this.starving = starving ;
    }

    void set_gourmet(float gourmet) {
      this.gourmet = abs(gourmet) +1.1 ;
    }

    void set_meat_quality(int meat_quality) {
      this.meat_quality = meat_quality ;
    }

    void set_step_hunger(float step_hunger) {
      this.step_hunger = int(size *step_hunger) ;
    }

    void set_hunger(int hunger) {
      this.hunger = hunger ;
    }

    void set_speed_eating(int speed_eating) {
      this.speed_eating = 1 ;
    }

    void set_colour(Vec4 colour) {
      this.colour.set(colour) ;
    }

    void set_alive(boolean alive) {
      this.alive = alive ;
    }

    void set_watching(int  max_watching) {
      this.max_watching = max_watching ;
    }

    void set_digestion(int digestion) {
      if(digestion <= 0) {
        println("Please use a positive value !") ;
        this.digestion = 1 ;
      } else {
        this.digestion = digestion ;
      }
    }




    
    /**
    // MOTION
    */
    void rebound(Vec6 l, boolean rebound_on_limit) {
      if(ENVIRONMENT == 2 ) rebound(l.a, l.b, l.c, l.d, 0, 0, rebound_on_limit) ;
      else if(ENVIRONMENT == 3) rebound(l.a, l.b, l.c, l.d, l.e, l.f,  rebound_on_limit) ;
    }
    
    void rebound(float left, float right, float top, float bottom, float front, float back, boolean rebound_on_limit) {
      Vec3 pos_temp = Vec3(pos.x, pos.y,pos.z);
      Vec3 dir_temp = Vec3(direction.x, direction.y,direction.z);
      
      if(rebound_on_limit) {
        dir_temp.set(rebound(left, right, top, bottom, front, back, pos_temp, dir_temp)) ;
        direction.set(dir_temp) ;
      } else {
        Vec3 motion_temp = Vec3(motion.x, motion.y,motion.z) ;
        motion_temp.set(jump(left, right, top, bottom, front, back, motion_temp)) ;
        motion.set(motion_temp) ;
      }
    }


    // local method
    Vec3 rebound(float left, float right, float top, float bottom, float front, float back, Vec3 pos, Vec3 dir) {
      // here we use size to have a physical rebound
      int effect = size ;
      left -=effect ;
      right +=effect ;
      top -=effect ;
      bottom +=effect ;
      front -=effect;
      back +=effect;

      // detection x
      if(pos.x > right ) dir.x *= -1 ;
      else if (pos.x < left ) dir.x *= -1 ;
      // detection y
      if(pos.y > bottom) dir.y *= -1 ;
      else if (pos.y < top ) dir.y *= -1 ;
      // detection z
      if(pos.z > front) dir.z *= -1 ;
      else if (pos.z < back ) dir.z *= -1 ;
      return Vec3(dir) ;
    }


    Vec3 jump(float left, float right, float top, float bottom, float front, float back, Vec3 motion) {
      // here we use radar to find a good jump
      int effect = radar ;
      left -=effect ;
      right +=effect ;
      top -=effect ;
      bottom +=effect ;
      front -=effect;
      back +=effect;

      if(motion.x > right ) motion.x = left ;
      else if (motion.x < left ) motion.x = right ;
      // detection y
      if(motion.y > bottom) motion.y = top ;
      else if (motion.y < top ) motion.y = bottom  ;
      // detection z
      if(motion.z > back) motion.z = front ;
      else if (motion.z < front ) motion.z = back ;
      return Vec3(motion) ;
    }



    void motion() {
      velocity_xyz.set(velocity) ;
      velocity_xyz.mult(direction) ;
      motion.add(velocity_xyz) ;
    }
    
    void set_position() {
      if(ENVIRONMENT == 2 ) pos.set(motion.x, motion.y, 0) ; else if(ENVIRONMENT == 3 ) pos.set(motion.x, motion.y, motion.z) ;
    }








    /**
    // STATEMENT
    */
    void statement() {
      time_to_eat() ;
      if(calm) velocity = 0 ; else velocity = velocity_ref ;

      // corpse
      if(life <= 0) {
        alive = false ;
        life = 0 ;
      }
      if(!alive) direction.set(Vec3(0)) ;

      // health
      if(life > life_max) {
        life = life_max ;
      }

      
    }

    // local method
    int start_eating ;
    void time_to_eat() {
      if(hunger < step_hunger) {
        calm = false ;
        start_eating = frameCount ; 
      } else {
        int time_to_stop_eating = start_eating +greed ;
        if (time_to_stop_eating > frameCount) calm = true ; 
      }

    }
    

    void carrion() {
      int threshold = 2 ;
      if(!alive) {
        dead_since += int(1. *CLOCK) ;
        if(size < size_ref / threshold || dead_since > (TIME_TO_BE_CARRION *frameRate)) carrion = true ; 
        else carrion = false ;
      } 
    }



    void hunger() {
      if(frameCount%(1 +int(frameRate *CLOCK)) == 0) {
        hunger -= starving ;
        if(hunger <= 0) life -= starving ;
      }
    }














    /**
    // ASPECT
    */
    void aspect(float thickness) {
      if(thickness <= 0) { 
        noStroke() ;
        fill(colour.r,colour.g,colour.b,colour.a) ;
      } else { 
        strokeWeight(thickness) ;
        stroke(colour) ;
        fill(colour) ;
      }
    }
    void aspect(Vec4 c_fill, Vec4 c_stroke, float thickness) {
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
    // costume
    */
    void costume_agent(int ID_costume) {
      costume(pos, size, ID_costume) ;
    }
    
    



    /**
    // void info
    */
    void info_visual(Vec4 colour) {
      Vec3 pos_temp = Vec3(0) ;
      aspect(Vec4(0), colour, 1) ;
      matrix_start() ;
      translate(pos) ;
      ellipse(pos_temp.x, pos_temp.y, size *2, size *2) ;
      matrix_end() ;
    }

    void info_text(Vec4 colour, int size_text) {
      aspect(colour, colour, 1) ;
      Vec2 pos_text = Vec2(0) ;
      matrix_start() ;
      translate(pos) ;
      textSize(size_text) ;
      textAlign(CENTER) ;
      text(name, pos_text.x, pos_text.y) ;
      text(life + " " + size + " " + size_ref, pos_text.x, pos_text.y +(size_text *1.2) ) ;
      textSize(16) ;
      if(alive) {
        if (eating) {
          text("I'm eating", pos_text.x, pos_text.y +(size_text *2.4) ) ;
        } else {
          if(calm) text("I'm cool", pos_text.x, pos_text.y +(size_text *2.4) ) ; 
          if(!calm) text("I'm hungry", pos_text.x, pos_text.y +(size_text *2.4) ) ;
        }
      } else {
        if(!carrion) text("I'm dead", pos_text.x, pos_text.y +(size_text *2.4) ) ; else text("I'm carrion", pos_text.x, pos_text.y +(size_text *2.4) ) ;
      }
      matrix_end() ;
    }

    void info_print_agent() {
      // basic Agent info
      println(this.name + " " +this.getClass().getSimpleName()) ;
      info_print_agent_structure() ;
      info_print_agent_motion() ;
      info_print_agent_statement() ;
    }
    void info_print_agent_structure() {
      println("CARACTERISTIC",this.name) ;
      println(this.name, "size", this.size) ;
      println(this.name, "life", this.life) ;
      println(this.name, "meat quality", this.meat_quality) ;
      println(this.name, "Food exigency", this.gourmet) ;

    }

    void info_print_agent_motion() {
      println("MOTION",this.name) ;
      println(this.name, "velocity", this.velocity_ref) ;
      println(this.name, "current velocity", this.velocity) ;
      println(this.name, "position", this.pos) ;
      println(this.name, "direction", this.direction) ;
      println(this.name, "motion", this.motion) ;
    }


    void info_print_agent_statement() {
      println("STATEMENT",this.name) ;
      println(this.name, "alive", this.alive) ;
      println(this.name, "carrion", this.carrion) ;
      println(this.name, "calm", this.calm) ;
      println(this.name, "eating", this.eating) ;
      println(this.name, "hunger", this.hunger) ;
      println(this.name, "watching", this.watching) ;
      println(this.name, "tracking", this.tracking) ;

    }
  }
  /**
  END AGENT
  */
























	/**
	CLASS CHILDREN AGENT

	*/
	/**
	SUB CLASS BACTERIUM 0.0.2
	*/
	class Bacterium extends Agent {
	  float humus_prod = .25 ;
	  // boolean eating   ;
	  Bacterium(Vec3 pos, int size, int life, int velocity, float radar, String name) {
	    super(pos, size, life, velocity, name) ;
	    this.radar = int(size *radar) ;
	    eat_zone = int(size *2) + size ;
	  }

	  void set_humus_prod(float prod) {
	    this.humus_prod = prod ;
	  }



	  void watch(Agent a, boolean info) {
	    // Vec3 pos_target = a.pos.copy() ;
	    if(dist(a.pos,pos) < radar && !a.alive ) {
	      if(info) {
	        stroke(colour) ;
	        strokeWeight(1) ;
	        line(a.pos, pos) ;
	      }
	      watching = false ; 
	    } else watching = true ;
	  }




	   // Method
	  void eat(Agent a, boolean info) {
	    if(dist(a.pos,pos) < eat_zone ) {
	      if(info) line(a.pos, pos) ;
	      float calories = speed_eating *humus_prod ;
	      a.size -= speed_eating ;
	      hunger += (calories *digestion) ;
	      HUMUS += (calories *humus_prod) ;
	      life += (calories *.75) ;
	      eating = true ;
	    } else eating = false ;
	  }


	  void pick(Agent a) {
	    if (!watching) direction.set(target_direction(a.pos,pos)) ; 
	  }

	  boolean picking() {
	    if (watching) return false ; else return true ;
	  }

	  // info
	  void info(Vec4 colour, int size_text) {
	    info_visual_bacterium(colour) ;
	    info_text(colour, size_text) ;
	  }

	  void info_visual_bacterium(Vec4 colour) {
	    aspect(Vec4(), colour, 1) ;
	    Vec3 pos_temp = Vec3 (0) ;
	    matrix_start() ;
	    translate(pos) ;
	    ellipse(pos_temp.x, pos_temp.y, radar*2, radar*2) ;
	    ellipse(pos_temp.x, pos_temp.y, eat_zone *2, eat_zone *2) ;
	    ellipse(pos_temp.x, pos_temp.y, size *2, size *2) ;
	    matrix_end() ;
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
  SUB CLASS CARNIVORE 0.0.2
  */
  class Carnivore extends Agent {
    boolean killing   ;
    int attack = 1 ;
    int kill_zone ;
    int time_track ;
    int max_time_track = int(360 *CLOCK) ;

    Carnivore(Vec3 pos, int size, int life, int velocity, float radar, String name) {
      super(pos, size, life, velocity, name) ;
      this.radar = int(size *radar) ;
      kill_zone = int(size *2) +size ;
      eat_zone = int(size *1.2) ;
    }


    void set_kill_zone(int radius) {
      this.kill_zone = radius ;
    }

    void set_attack(int attack) {
      this.attack = attack ;
    }

    void set_max_time_track(int max) {
      this.max_time_track = int(max *frameRate *CLOCK) ;
    }






    // hunt
    void hunt(Agent a, boolean info) {
      if(a.alive) {
        hunt_in_progress() ;
        follow(a, info) ;
      } else {
        hunt_stop() ;
      } 
    }

    void kill(Agent a, boolean info) {
      if(dist(a.pos,pos) < kill_zone && a.alive ) {
        if(info) {
          stroke(colour) ;
          strokeWeight(1) ;
          line(a.pos, pos) ;
        }
        a.life -= 1 *attack ;
        // a.size -= 1 ;
      }
    }

    void follow(Agent a, boolean info) {
      if(info) {
        stroke(colour) ;
        strokeWeight(1) ;
        line(a.pos, pos) ;
      }
      direction.set(target_direction(a.pos, pos)) ;
    }

    float dist_to_target(Agent a, boolean info) {
      float dist = dist(a.pos,pos) ;
      if(dist < radar) {
        if(info) {
          stroke(colour) ;
          strokeWeight(1) ;
          line(a.pos, pos) ;
        }
      }
      return dist ;
    }

    void hunt_in_progress() {
      time_track += 1 ;
      tracking = true ; 
      watching = false ;
    }

    void hunt_stop() {
      time_track = 0 ;
      tracking = false ; 
      watching = true ;
    }







    // heat
    void eat(Agent a, boolean info) {
      if(dist(a.pos,pos) < eat_zone && !a.alive && threshold_quality_meat(a, gourmet)) {
        if(info) {
          stroke(colour) ;
          strokeWeight(1) ;
          line(a.pos, pos) ;
        }
        float calories = a.meat_quality *speed_eating ;
        a.size -= speed_eating ;
        hunger += (calories *digestion) ;
        life += calories ;
        eating = true ;
      } else eating = false ;
    }



    boolean threshold_quality_meat(Agent a, float step) {
      if(a.size > a.size_ref / step ) return true ; else return false ;
    }

    

    


    
    // info
    void info(Vec4 colour, int text_size) {
      info_visual_carnivore(colour) ;
      info_text(colour, SIZE_TEXT_INFO) ;
    }

    void info_visual_carnivore(Vec4 colour) {
      Vec3 pos_temp = Vec3(0) ;
      aspect(Vec4(), colour, 1) ;
      matrix_start() ;
      translate(pos) ;
      ellipse(pos_temp.x, pos_temp.y, radar*2, radar*2) ;
      ellipse(pos_temp.x, pos_temp.y, kill_zone *2, kill_zone *2) ;
      ellipse(pos_temp.x, pos_temp.y, eat_zone *2, eat_zone *2) ;
      ellipse(pos_temp.x, pos_temp.y, size *2, size *2) ;
      matrix_end() ;
    }

    // print
    void info_print_carnivore() {
      println("INFO",this.name) ;
      println("time track", int((float)time_track / frameRate));
    }
  }
  /**
  END SUB CLASS CARNIVORE 0.0.2
*/























  /**
  SUB CLASS HERBIVORE 0.0.2
  */
  class Herbivore extends Agent {
    // boolean eating   ;
    Herbivore(Vec3 pos, int size, int life, int velocity, float radar, String name) {
      super(pos, size, life, velocity, name) ;
      this.radar = int(size *radar) ;
      eat_zone = int(size *1.2) ;
    }


    // watch
    void watch(Flora f, boolean info) {
      if(time_watching < max_watching) {
        if(dist(f.pos,pos) < radar && threshold_quality_food(f, gourmet) && f.size >= size_target) {
          if(info) {
            stroke(colour) ;
            strokeWeight(1) ;
            line(f.pos, pos) ;
          }
          size_target = f.size ;
          time_watching ++ ;
          watching = false ; 
        } else {
          watching = true ;
        } 
      } else {
        time_watching = 0 ;
        size_target = 0 ;
      }
    }


    // eat
    void eat(Flora f, boolean info) {
      if(dist(f.pos,pos) < eat_zone && threshold_quality_food(f, gourmet) ) {
        if(info) line(f.pos, pos) ;
        float calories = f.nutrient_quality *speed_eating ;
        f.life -= speed_eating ;
        f.size -= speed_eating ;
        hunger += (calories *digestion) ;
        life += calories ;
        eating = true ;
        //calm = true ;
        size_target = 0 ;
      } else {
        eating = false ;
      }
    }
    // local method
    boolean threshold_quality_food(Flora f, float step) {
      if(f.size > f.size_ref / step ) return true ; else return false ;
    }


    // pick
    void pick(Flora f) {
      if (!watching) {
        Vec3 pos_target = f.pos.copy() ;
        direction.set(target_direction(pos_target, pos)) ; 
      }
    }

    boolean picking() {
      if (watching) return false ; else return true ;
    }


    // info
    void info(Vec4 colour, int size_text) {
      info_visual_herbivore(colour) ;
      info_text(colour, size_text) ;
    }

    void info_visual_herbivore(Vec4 colour) {
      aspect(Vec4(),colour, 1) ;
      Vec3 pos_temp = Vec3(0) ;
      matrix_start() ;
      translate(pos) ;
      ellipse(pos_temp.x, pos_temp.y, radar*2, radar*2) ;
      ellipse(pos_temp.x, pos_temp.y, eat_zone *2, eat_zone *2) ;
      ellipse(pos_temp.x, pos_temp.y, size *2, size *2) ;
      matrix_end() ;
    }
    
    // print
    void info_print_herbivore() {
      println("INFO",this.name) ;
      println("No particular info for the moment") ;
    }
  }
  /**
  SUB CLASS HERBIVORE 0.0.2
  */



















  /**
  Flora 0.0.4
  */
  class Flora implements RULES_ECOSYSTEME {
    String name ;
    int ID = 0 ;

    Vec3 pos ;
    int size, size_ref, size_max ;
    int speed_growth = 1 ;
    int life, life_max ;

    Vec4 colour = new Vec4(0,0,0,g.colorModeA) ;

    int nutrient_quality ;
    float need = 1. ;
    /**
    Constructor
    */
    Flora(Vec3 pos, int size, String name) {
      this.name = name ;
      this.ID = int(random(1000000)) ;

      this.size = this.size_ref = this.size_max  = size ;
      this.life = this.life_max = size ;
      this.colour.set(colour);

      this.pos = pos ;

      this.nutrient_quality = 1 ;
    }
    /**
    Set Flora
    */
    void set_Flora_quality(int nutrient_quality) {
       this.nutrient_quality =  nutrient_quality ;
    }
    void set_colour(Vec4 colour) {
      this.colour.set(colour) ;
    }

    void set_growth(int speed) {
      this.speed_growth = speed ;
    }

    void set_need(float need) {
      this.need = need ;
    }



   void statement() {
     if(size > size_max) size = size_max ;
     if(life > life_max) life = life_max ;
   }
    

    void growth() {
      if(frameCount%(180 *CLOCK) == 0 ) {
        this.size += speed_growth ;
        this.life += speed_growth ;
        HUMUS -= need ;
      } 
    }


    /**
    Aspect
    */
    void aspect(float thickness) {
      if(thickness <= 0) { 
        noStroke() ;
        fill(colour.r,colour.g,colour.b,colour.a) ;
      } else { 
        strokeWeight(thickness) ;
        stroke(colour) ;
        fill(colour) ;
      }
    }
    
    void aspect(Vec4 c_fill, Vec4 c_stroke, float thickness) {
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
    // costume
    */
    void costume_agent(int ID_costume) {
      costume(pos, size, ID_costume) ;
    }
    
    /**
    // info
    */
    void info_visual_text(Vec4 colour, int size_text) {
      aspect(colour,colour, 1) ;
      textSize(size_text) ;
      textAlign(CENTER) ;
      
      Vec2 pos_text = Vec2(0) ;

      matrix_start() ;
      translate(pos) ;
      text(name, pos_text.x, pos_text.y) ;
      text(life, pos_text.x, pos_text.y +(size_text *1.2) ) ;
      matrix_end() ;
    }

      // print
    void info_print_flora() {
      println("INFO",this.name) ;
      println("No particular info for the moment") ;
    }
  }
  /**
  END Flora 0.0.4
  */

















  /**
  INFO 0.0.2
  */

  void print_info_environment() {
    println("ENVIRONMENT") ;
    println("Humus", HUMUS) ;
  }


  void print_info_herbivore(ArrayList<Herbivore> list_h) {
    for(Herbivore h : list_h) {
          // h.info_print_agent_() ;
      // h.info_print_agent_motion() ;
      //h.info_print_agent_structure() ;
      h.info_print_agent_statement() ;
      h.info_print_herbivore() ;
    }
  }

  void print_info_bacterium(ArrayList<Bacterium> list_b) {
    for(Bacterium b : list_b) {
          // b.info_print_agent_() ;
      // b.info_print_agent_motion() ;
      b.info_print_agent_structure() ;
      b.info_print_agent_statement() ;
      b.info_print_bacterium() ;
    }
  }

  void print_info_carnivore(ArrayList<Carnivore> list_c) {
    for(Carnivore c : list_c) {
      // c.info_print_agent() ;
      // c.info_print_agent_motion() ;
      c.info_print_agent_structure() ;
      c.info_print_agent_statement() ;
      c.info_print_carnivore() ;
    }
  }


  void print_list(){
    println("Flora", FLORA_LIST.size()) ;
    println("Bacterium",BACTERIUM_LIST.size()) ;
    println("Herbivore",HERBIVORE_LIST.size()) ;
    println("Carnivore",CARNIVORE_LIST.size()) ;
    println("Corpse",CORPSE_LIST.size()) ;
  }
  /**
	END INFO
  */
}

























