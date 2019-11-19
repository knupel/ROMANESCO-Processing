/**
* ROMANESCO MASKING
* v 2.0.0
* 2018-2019
*/

// IN PROGRESS
void mask_move_point_key(R_Megabloc mb) {
	boolean up_is = false;
	boolean down_is = false;
	boolean right_is = false;
	boolean left_is = false;
	if(keyPressed && key == CODED) {
		if(keyCode == UP) up_is = true;
		if(keyCode == DOWN) down_is = true;
		if(keyCode == LEFT) left_is = true;
		if(keyCode == RIGHT) right_is = true;
  }

  if(up_is || down_is || right_is || left_is) {
  	for(R_Bloc b : mb.get()) {
  		if(b.select_point_is()) {
  			println(b.get_id(), frameCount);
  		}
		}
  }
}






R_Megabloc mask;
PGraphics mask_layer;
boolean mask_build_is = false;
boolean mask_move_point_is = false;
boolean mask_move_bloc_is = false;
boolean show_mask_is = false;

void mask() {
	if(mask_layer == null && show_mask_is()) {
		init_mask();
	} else if(show_mask_is()) {
		mask_set_color(mask);
		mask_clear(mask_layer);
  	mask_show(mask_layer);
		check_for_new_bloc(mask);
		if(mask_build_is) {
			if(bloc_show_available_point(mask, mouseX, mouseY,mask_layer)) {
				bloc_draw(mask,mouseX,mouseY,mousePressed,true,mask_layer);
				add_new_bloc_is = false;
			} else {
				bloc_draw(mask,mouseX,mouseY,mousePressed,true,mask_layer);
			}		
		}
		mask_manage(mask,mask_layer);
		g.image(mask_layer,0,0);
	} else if (!show_mask_is()) {
		mask_move_point_is = false;
		mask_move_bloc_is = false;
		mask_build_is = false;
	}
}

/**
* Annexe method
*/
void init_mask() {
	mask = new R_Megabloc(this);
	mask.set_magnetism(2);
	mask_layer = createGraphics(width,height,P2D);
	String [] data = load_megabloc(sketchPath(1) + mask_path);
	mask = read_megabloc(data);
	println("mask ready to use");
}

void mask_show(PGraphics pg) {
	if(mask != null) {
		mask.show(pg);
	}
}

void mask_manage(R_Megabloc mb, PGraphics other) {
	if(mask_move_point_is) {
		bloc_select_single_point(mb, mouseX, mouseY, mousePressed);
		// bloc_select_all_point(megabloc, mouseX, mouseY, mousePressed);
		bloc_move_point(mb, mouseX, mouseY, mousePressed);
	}
	if(mask_move_bloc_is) {
		bloc_select(mb, mouseX, mouseY, mousePressed);
		bloc_move(mb, mouseX, mouseY, mousePressed);
	}
}

void mask_set_color(R_Megabloc mb) {
	if(mask_move_point_is || mask_move_bloc_is || mask_build_is) {
		mb.set_fill(r.ROUGE);
		mb.set_stroke(r.ROUGE);
		mb.set_thickness(0);
	} else {
		mb.set_fill(r.NOIR);
		mb.set_stroke(r.NOIR);
		mb.set_thickness(0);
	}
}

void mask_clear(PGraphics other) {
	if(mask_move_point_is || mask_move_bloc_is) {
		other.beginDraw();
		other.clear();
		other.endDraw();
	}
}

/**
* event mask
*/
boolean set_mask_is() {
	if(mask_move_point_is || mask_move_bloc_is || mask_build_is) {
		return true;
	} else {
		return false;
	}
}

void set_mask_move_point_switch() {
	mask_move_point_is = !!((mask_move_point_is == false));
	if(mask_move_point_is) {
		mask_move_bloc_is = false;
		mask_build_is = false;
	}
}

void set_mask_move_bloc_switch() {
	mask_move_bloc_is = !!((mask_move_bloc_is == false));
	if(mask_move_bloc_is) {
		mask_move_point_is = false;
		mask_build_is = false;
	}
}

void set_mask_build_switch() {
	mask_build_is = !!((mask_build_is == false));
	if(mask_build_is) {
		mask_move_bloc_is = false;
		mask_move_point_is = false;
	}
}

boolean show_mask_is() {
	return show_mask_is;
}

void show_mask_is(boolean is) {
	this.show_mask_is = is;
}

void show_mask_switch() {
	show_mask_is = !!((show_mask_is == false));
}

/**
* GUI
*/
void mousePressed_event_mask() {
	if(show_mask_is() && mask != null) {
		if(mask_build_is && add_new_bloc_is) {
			new_bloc(mask);
			add_new_bloc_is = false;
		}
		if(!bloc_move_event_is()) {
			for(R_Bloc b : mask.get()) {
				b.select_is(false);
			}
		}
	}
}

void mouseReleased_event_mask() {
	if(show_mask_is() && mask != null) {
		if(mask_build_is) {
			add_point_to_bloc_is(true);
		}
		bloc_move_event_is(false);
	}
}

void keyPressed_mask_set(char c_point_move, char c_bloc_move, char c_bloc_build) {
	if(show_mask_is() && (key == c_point_move || key == c_bloc_move || key == c_bloc_build)) {
		if(key == c_point_move) {
			set_mask_move_point_switch();
		}
		if(key == c_bloc_move) {
			set_mask_move_bloc_switch();
		}
		if(key == c_bloc_build) {
			set_mask_build_switch();
		}
	}
}

void keyPressed_mask_hide(char c) {
	if(key == c) {
		show_mask_switch();
		if(mask != null) {
			init_mask();
		}
	}
}

void keyPressed_mask_save(char c) {
	if(show_mask_is() && mask != null) {
		if(key == c) {
			save_mask();
		}
	}
}

void keyPressed_mask_load(char c) {
	if(key == c) {
		selectInput("Select a file to load mask:", "load_mask");
		show_mask_is(true);
	}
}

/**
SAVE / LOAD
v 0.0.5
*/
void save_mask_default() {
	String [] str = mask_path.split("/");
	String path = "/";
	for(int i = 0 ; i < str.length -2 ; i++) {
		path += str[i]+"/";
	}
	String [] name = str[str.length -1].split(".");
	save_megabloc(mask, sketchPath(1) + path, name[0]);
}

void save_mask() {
	selectOutput("Select a file to write to:", "selected_file_to_save"); 
}

void load_mask(File selection) {
	String [] data = load_megabloc(selection.getAbsolutePath());
	mask = read_megabloc(data);
}

void selected_file_to_save(File selection) {
	if (selection == null) {
		println("Window was closed or the user hit cancel.");
	} else {
		println("User selected",selection.getAbsolutePath(),"for save force file");
		String path = selection.getParent()+"/";
		String name = selection.getName();
		save_megabloc(mask, path, name);
	}
}


