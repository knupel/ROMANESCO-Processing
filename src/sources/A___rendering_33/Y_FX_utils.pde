/**
* SHADER FX
* @see http://stanlepunk.xyz
* @see https://github.com/StanLepunK/Filter
* v 0.0.4
* 2019-2019
*
*/
int FX_BLUR_GAUSSIAN = 100;
int FX_BLUR_RADIAL = 101;
int FX_BLUR_CIRCULAR = 102;

int FX_COLOUR_CHANGE_A = 150;
int FX_COLOUR_CHANGE_B = 151;

int FX_DITHER = 200;

int FX_GRAIN = 250;
int FX_GRAIN_SCATTER = 251;

int FX_HALFTONE_DOT = 300;
int FX_HALFTONE_LINE = 301;

int FX_MIX = 0;

int FX_LEVEL = 510;

int FX_PIXEL = 600;

int FX_REAC_DIFF = 700;

int FX_SCALE = 500;
int FX_SPLIT_RGB = 400;

int FX_TOON = 800; // don't work

int FX_WARP_TEX = 1000;
int FX_WARP_PROC = 1001;


ArrayList<FX>fx_manager;

FX get_fx(int target) {
	if(fx_manager != null && target < fx_manager.size()) {
		return fx_manager.get(target);
	} else {
		return null;
	}
}

FX get_fx(String name) {
	FX buffer = null;
	if(fx_manager != null && fx_manager.size() > 0) {	
		for(FX fx : fx_manager) {
			if(fx.get_name().equals(name)){
				buffer = fx;
				break;
			}
		}
	} 
	return buffer;
}



void init_fx(String name, int type) {
	boolean exist = false;
	if(fx_manager == null) {
		fx_manager = new ArrayList<FX>();
	}

	if(fx_manager != null && fx_manager.size() > 0) {
		for(FX fx : fx_manager) {
			if(fx.get_name().equals(name)) {
				exist = true;
				break;
			}
		}
		if(!exist) {
			FX new_fx = new FX(name,type);
			fx_manager.add(new_fx);
		}
	} else {

		FX new_fx = new FX(name,type);
		fx_manager.add(new_fx);
	}
}






/**
prepare your setting
v 0.0.2
*/
/**
mode
*/
void fx_set_mode(String name, int mode) {
	fx_set(0,name,mode);
}

void fx_set_num(String name, int num) {
	fx_set(1,name,num);
}

void fx_set_quality(String name, float quality) {
	fx_set(2,name,quality);
}

void fx_set_scale(String name, float... arg) {
	int which = 10;
	if(arg.length == 1) {
		fx_set(which,name,arg[0]);
	} else if(arg.length == 2) {
		fx_set(which,name,arg[0],arg[1]);
	} else if(arg.length > 2) {
		fx_set(which,name,arg[0],arg[1]);
	}
}


void fx_set_resolution(String name, float... arg) {
	int which = 11;
	if(arg.length == 1) {
		fx_set(which,name,arg[0]);
	} else if(arg.length == 2) {
		fx_set(which,name,arg[0],arg[1]);
	} else if(arg.length > 2) {
		fx_set(which,name,arg[0],arg[1]);
	}
}


void fx_set_strength(String name, float... arg) {
	int which = 20;
	if(arg.length == 1) {
		fx_set(which,name,arg[0]);
	} else if(arg.length == 2) {
		fx_set(which,name,arg[0],arg[1]);
	} else if(arg.length == 3) {
		fx_set(which,name,arg[0],arg[1],arg[2]);
	} else if(arg.length > 3) {
		fx_set(which,name,arg[0],arg[1],arg[2]);
	}
}

void fx_set_angle(String name, float... arg) {
	int which = 21;
	if(arg.length == 1) {
		fx_set(which,name,arg[0]);
	} else if(arg.length == 2) {
		fx_set(which,name,arg[0],arg[1]);
	} else if(arg.length == 3) {
		fx_set(which,name,arg[0],arg[1],arg[2]);
	} else if(arg.length > 3) {
		fx_set(which,name,arg[0],arg[1],arg[2]);
	}
}

void fx_set_threshold(String name, float... arg) {
	int which = 22;
	if(arg.length == 1) {
		fx_set(which,name,arg[0]);
	} else if(arg.length == 2) {
		fx_set(which,name,arg[0],arg[1]);
	} else if(arg.length == 3) {
		fx_set(which,name,arg[0],arg[1],arg[2]);
	} else if(arg.length > 3) {
		fx_set(which,name,arg[0],arg[1],arg[2]);
	}
}

void fx_set_pos(String name, float... arg) {
	int which = 23;
	if(arg.length == 1) {
		fx_set(which,name,arg[0]);
	} else if(arg.length == 2) {
		fx_set(which,name,arg[0],arg[1]);
	} else if(arg.length == 3) {
		fx_set(which,name,arg[0],arg[1],arg[2]);
	} else if(arg.length > 3) {
		fx_set(which,name,arg[0],arg[1],arg[2]);
	}
}

void fx_set_size(String name, float... arg) {
	int which = 24;
	if(arg.length == 1) {
		fx_set(which,name,arg[0]);
	} else if(arg.length == 2) {
		fx_set(which,name,arg[0],arg[1]);
	} else if(arg.length == 3) {
		fx_set(which,name,arg[0],arg[1],arg[2]);
	} else if(arg.length > 3) {
		fx_set(which,name,arg[0],arg[1],arg[2]);
	}
}

void fx_set_offset(String name, float... arg) {
	int which = 25;
	if(arg.length == 1) {
		fx_set(which,name,arg[0]);
	} else if(arg.length == 2) {
		fx_set(which,name,arg[0],arg[1]);
	} else if(arg.length == 3) {
		fx_set(which,name,arg[0],arg[1],arg[2]);
	} else if(arg.length > 3) {
		fx_set(which,name,arg[0],arg[1],arg[2]);
	}
}

void fx_set_level_source(String name, float... arg) {
	int which = 30;
	if(arg.length == 1) {
		fx_set(which,name,arg[0]);
	} else if(arg.length == 2) {
		fx_set(which,name,arg[0],arg[1]);
	} else if(arg.length == 3) {
		fx_set(which,name,arg[0],arg[1],arg[2]);
	} else if(arg.length == 4) {
		fx_set(which,name,arg[0],arg[1],arg[2],arg[3]);
	} else if(arg.length > 4) {
		fx_set(which,name,arg[0],arg[1],arg[2],arg[3]);
	}
}

void fx_set_level_layer(String name, float... arg) {
	int which = 31;
	if(arg.length == 1) {
		fx_set(which,name,arg[0]);
	} else if(arg.length == 2) {
		fx_set(which,name,arg[0],arg[1]);
	} else if(arg.length == 3) {
		fx_set(which,name,arg[0],arg[1],arg[2]);
	} else if(arg.length == 4) {
		fx_set(which,name,arg[0],arg[1],arg[2],arg[3]);
	} else if(arg.length > 4) {
		fx_set(which,name,arg[0],arg[1],arg[2],arg[3]);
	}
}

void fx_set_colour(String name, float... arg) {
	int which = 32;
	if(arg.length == 1) {
		fx_set(which,name,arg[0]);
	} else if(arg.length == 2) {
		fx_set(which,name,arg[0],arg[1]);
	} else if(arg.length == 3) {
		fx_set(which,name,arg[0],arg[1],arg[2]);
	} else if(arg.length == 4) {
		fx_set(which,name,arg[0],arg[1],arg[2],arg[3]);
	} else if(arg.length > 4) {
		fx_set(which,name,arg[0],arg[1],arg[2],arg[3]);
	}
}


// modulair param
void fx_set_matrix(String name, int target, float... arg) {
	int which = 40+target;
	if(arg.length == 1) {
		fx_set(which,name,arg[0]);
	} else if(arg.length == 2) {
		fx_set(which,name,arg[0],arg[1]);
	} else if(arg.length == 3) {
		fx_set(which,name,arg[0],arg[1],arg[2]);
	} else if(arg.length > 3) {
		fx_set(which,name,arg[0],arg[1],arg[2]);
	}
}


void fx_set_pair(String name, int target, float... arg) {
	int which = 50+target;
	if(arg.length == 1) {
		fx_set(which,name,arg[0]);
	} else if(arg.length == 2) {
		fx_set(which,name,arg[0],arg[1]);
	} else if(arg.length > 3) {
		fx_set(which,name,arg[0],arg[1]);
	}
}

void fx_set_event(String name, int target, boolean arg) {
	int which = 100+target;
	fx_set(which,name,arg);
}


/**
main setting methode
*/
void fx_set(int which_setting, String name, Object... arg) {
	if(fx_manager == null) {
		fx_manager = new ArrayList<FX>();
	} else {
		if(fx_manager.size() > 0) {
			for(FX fx : fx_manager) {
				if(fx.get_name().equals(name)) {
					fx.set(which_setting,arg);
				}
			}	
		} 
	}	
}




































/**
* path shader
* v 0.0.2
*/
String fx_rope_path = null;
boolean fx_rope_path_exists = false;
String get_fx_path() {
	if(fx_rope_path == null) {
		fx_rope_path = sketchPath()+"/shader/fx/";
		File f = new File(fx_rope_path);
		if(!f.exists()) {
			printErrTempo(60,"get_fx_path()",fx_rope_path,"no folder found");
		} else {
			fx_rope_path_exists = true;
		}
	} else {
		File f = new File(fx_rope_path);
		if(!f.exists()) {
			printErrTempo(60,"get_fx_path()",fx_rope_path,"no folder found");
		} else {
			fx_rope_path_exists = true;
		}

	}
	return fx_rope_path;
}

void set_fx_path(String path) {
	fx_rope_path = path;
}



/**
* send information to shader.glsl to flip the source in case this one is a PGraphics or PImage
* v 0.0.1
*/
void set_flip_shader(PShader ps, PImage... img) {
	int num = img.length;
	ps.set("flip_source",true,false);
	
	if(graphics_is(img[0]).equals("PGraphics") && !reverse_g_source_is()) {
		ps.set("flip_source",false,false);
		reverse_g_source(true);
	}

	if(num == 2) {
		ps.set("flip_layer",true,false);
		if(graphics_is(img[1]).equals("PGraphics") && !reverse_g_layer_is()) {
			ps.set("flip_layer",false,false);
			reverse_g_layer(true);
		}
	}
}

/**
reverse graphics for the case is not a texture but a direct shader
*/
boolean filter_reverse_g_source;
boolean filter_reverse_g_layer;
boolean reverse_g_source_is() {
	return filter_reverse_g_source;
}

boolean reverse_g_layer_is() {
	return filter_reverse_g_layer;
}

void reverse_g_source(boolean state){
	filter_reverse_g_source = state;
}

void reverse_g_layer(boolean state){
	filter_reverse_g_layer = state;
}

void reset_reverse_g(boolean state){
	filter_reverse_g_source = state;
	filter_reverse_g_layer = state;
}








/**
* render shader
* this method test if the shader must be display on the main Processing render or return a PGraphics
* v 0.0.3
*/
void render_shader(PShader ps, PGraphics pg, PImage src, boolean on_g) {
	if(pg != null && !on_g) {
  	pg.beginDraw();
  	pg.shader(ps);
  	pg.image(src,0,0,src.width,src.height);
  	pg.resetShader();
  	pg.endDraw();
  } else {
  	g.filter(ps);
  }
}








