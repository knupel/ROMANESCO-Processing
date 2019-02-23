/**
* SHADER FX
* @see http://stanlepunk.xyz
* @see https://github.com/StanLepunK/Shader
* v 0.7.1
* 2019-2019
*
*/
int NO_FX = -1;
// CONSTANT FX POST
int FX_TEMPLATE = 0;

int FX_BLUR_GAUSSIAN = 200;
int FX_BLUR_RADIAL = 201;
int FX_BLUR_CIRCULAR = 202;

int FX_COLOUR_CHANGE_A = 300;
int FX_COLOUR_CHANGE_B = 301;

int FX_DITHER = 400;

int FX_GRAIN = 700;
int FX_GRAIN_SCATTER = 701;

int FX_HALFTONE_DOT = 800;
int FX_HALFTONE_LINE = 801;
int FX_HALFTONE_MULTI = 810;

int FX_LEVEL = 12_00;

int FX_MIX = 13_00;

int FX_PIXEL = 16_00;

int FX_REAC_DIFF = 18_00;

int FX_SCALE = 19_00;
int FX_SPLIT_RGB = 19_50;

int FX_TOON = 20_00; // don't work

int FX_WARP_TEX = 23_00;
int FX_WARP_PROC = 23_01;


// CONSTANT FX BACKGROUND
// here we start arbitrarily at 10_000 to no conflict with FX constant arounf 1_000.

int FX_BG_TEMPLATE = 1;

int FX_BG_CELLULAR = 3_0000;

int FX_BG_HEART = 8_0000;

int FX_BG_NECKLACE = 14_0000;

int FX_BG_NEON = 14_0000;

int FX_BG_PSY = 16_0000;

int FX_BG_SNOW = 19_0000;

int FX_BG_VORONOI_HEX = 22_0000;


// get method
FX get_fx(ArrayList<FX> fx_list, int target) {
	if(fx_list != null && target < fx_list.size()) {
		return fx_list.get(target);
	} else {
		return null;
	}
}

FX get_fx(ArrayList<FX> fx_list, String name) {
	FX buffer = null;
	if(fx_list != null && fx_list.size() > 0) {	
		for(FX fx : fx_list) {
			if(fx.get_name().equals(name)){
				buffer = fx;
				break;
			}
		}
	} 
	return buffer;
}



// init method
void init_fx(ArrayList<FX> fx_list, String name, int type) {
	init_fx(fx_list,name,type,-1, null, null, null,-1,null,null);
}


void init_fx(ArrayList<FX> fx_list, String name, int type, int id, String author, String pack, String version, int revision, String [] name_slider, String [] name_button) {
	boolean exist = false;

	if(fx_list != null && fx_list.size() > 0) {
		for(FX fx : fx_list) {
			if(fx.get_name().equals(name)) {
				exist = true;
				break;
			}
		}
		if(!exist) {
			add_fx_to_manager(fx_list,name,type,id,author,pack,version,revision,name_slider,name_button);
		}
	} else {
		add_fx_to_manager(fx_list,name,type,id,author,pack,version,revision,name_slider,name_button);
	}
}


// add FX
void add_fx_to_manager(ArrayList<FX> fx_list, String name, int type, int id, String author, String pack, String version, int revision, String [] name_slider, String [] name_button) {
	FX fx = new FX();
	fx.set_name(name);
	fx.set_type(type);
	fx.set_id(id);
	if(author != null) fx.set_author(author);
	fx.set_pack(pack);
	if(version != null) fx.set_version(version);
	fx.set_revision(revision);
	if(name_slider != null) fx.set_name_slider(name_slider);
	if(name_button != null) fx.set_name_button(name_button);
	fx_list.add(fx);
}






/**
* SELECT FX
*/

// POST FX from FX class
void select_fx_post(PImage main, PImage layer_a, PImage layer_b, FX... fx) {
	for(int i = 0 ; i < fx.length ;i++) {
		if(fx[i] != null) {
			if(fx[i].get_type() == FX_MIX) {
				fx_mix(main,layer_a,fx[i]);
			} else if(fx[i].get_type() == FX_BLUR_GAUSSIAN) {
				fx_blur_gaussian(main,fx[i]); 
			} else if(fx[i].get_type() == FX_BLUR_CIRCULAR) {
				fx_blur_circular(main,fx[i]);
			} else if(fx[i].get_type() == FX_BLUR_RADIAL) {
				fx_blur_radial(main,fx[i]);
			} else if(fx[i].get_type() == FX_COLOUR_CHANGE_A) {
				fx_colour_change_a(main,fx[i]);
			} else if(fx[i].get_type() == FX_COLOUR_CHANGE_B) {
				fx_colour_change_b(main,fx[i]);
			} else if(fx[i].get_type() == FX_DITHER) {
				fx_dither(main,layer_a,fx[i]);
			} else if(fx[i].get_type() == FX_GRAIN) {
				 fx_grain(main,fx[i]);
			} else if(fx[i].get_type() == FX_GRAIN_SCATTER) {
				fx_grain_scatter(main,fx[i]);
			} else if(fx[i].get_type() == FX_HALFTONE_DOT) {
				fx_halftone_dot(main,fx[i]);
			} else if(fx[i].get_type() == FX_HALFTONE_LINE) {
				fx_halftone_line(main,fx[i]); 
			} else if(fx[i].get_type() == FX_HALFTONE_LINE) {
				fx_halftone_line(main,fx[i]); 
			} else if(fx[i].get_type() == FX_HALFTONE_MULTI) {
				fx_halftone_multi(main,fx[i]); 
			} else if(fx[i].get_type() == FX_PIXEL) {
				fx_pixel(main,fx[i]);
			} else if(fx[i].get_type() == FX_REAC_DIFF) {
				fx_reaction_diffusion(main,fx[i]);
			} else if(fx[i].get_type() == FX_SPLIT_RGB) {
				fx_split_rgb(main,fx[i]); 
			} else if(fx[i].get_type() == FX_SCALE) {
				fx_scale(main,fx[i]);
			} else if(fx[i].get_type() == FX_WARP_PROC) {
				fx_warp_proc(main,fx[i]); 
			} else if(fx[i].get_type() == FX_WARP_TEX) {
				fx_warp_tex(main,layer_a,layer_b,fx[i]); 
			} else {
				printErrTempo(60,"method select_fx_post(): fx",fx[i].get_name(),fx[i].get_type(),"don't match with any fx available");
			}
		} else {
			printErrTempo(60,"method select_fx_post(): fx",i,"is",fx[i],"maybe fx need to be init or instantiate");
		}
		   
	}
}


// BACKGROUND FX from FX class
void select_fx_background(FX fx) {
	if(fx != null) {
		if(fx.get_type() == FX_BG_TEMPLATE) {
			fx_bg_template(fx);
		} else if(fx.get_type() == FX_BG_CELLULAR) {
			fx_bg_cellular(fx);
		} else if(fx.get_type() == FX_BG_HEART) {
			fx_bg_heart(fx);
		} else if(fx.get_type() == FX_BG_NECKLACE) {
			fx_bg_necklace(fx);
		} else if(fx.get_type() == FX_BG_NEON) {
			fx_bg_neon(fx);
		} else if(fx.get_type() == FX_BG_PSY) {
			fx_bg_psy(fx);
		} else if(fx.get_type() == FX_BG_SNOW) {
			fx_bg_snow(fx);
		} else if(fx.get_type() == FX_BG_VORONOI_HEX) {
			fx_bg_voronoi_hex(fx);
		} else {
			fx_bg_template(fx);
		}
	} else {
		printErrTempo(60,"method select_fx_background(): fx is",fx,"maybe fx need to be init or instantiate");
	}
	    
}
















/**
prepare your setting
v 0.1.0
*/
void fx_set_mode(ArrayList<FX> fx_list, String name, int mode) {
	fx_set(fx_list,0,name,mode);
}

void fx_set_num(ArrayList<FX> fx_list, String name, int num) {
	fx_set(fx_list,1,name,num);
}

void fx_set_quality(ArrayList<FX> fx_list, String name, float quality) {
	fx_set(fx_list,2,name,quality);
}

void fx_set_scale(ArrayList<FX> fx_list, String name, float... arg) {
	int which = 10;
	if(arg.length == 1) {
		fx_set(fx_list,which,name,arg[0]);
	} else if(arg.length == 2) {
		fx_set(fx_list,which,name,arg[0],arg[1]);
	} else if(arg.length > 2) {
		fx_set(fx_list,which,name,arg[0],arg[1]);
	}
}

void fx_set_resolution(ArrayList<FX> fx_list, String name, float... arg) {
	int which = 11;
	if(arg.length == 1) {
		fx_set(fx_list,which,name,arg[0]);
	} else if(arg.length == 2) {
		fx_set(fx_list,which,name,arg[0],arg[1]);
	} else if(arg.length > 2) {
		fx_set(fx_list,which,name,arg[0],arg[1]);
	}
}

void fx_set_strength(ArrayList<FX> fx_list, String name, float... arg) {
	int which = 20;
	if(arg.length == 1) {
		fx_set(fx_list,which,name,arg[0]);
	} else if(arg.length == 2) {
		fx_set(fx_list,which,name,arg[0],arg[1]);
	} else if(arg.length == 3) {
		fx_set(fx_list,which,name,arg[0],arg[1],arg[2]);
	} else if(arg.length > 3) {
		fx_set(fx_list,which,name,arg[0],arg[1],arg[2]);
	}
}

void fx_set_angle(ArrayList<FX> fx_list, String name, float... arg) {
	int which = 21;
	if(arg.length == 1) {
		fx_set(fx_list,which,name,arg[0]);
	} else if(arg.length == 2) {
		fx_set(fx_list,which,name,arg[0],arg[1]);
	} else if(arg.length == 3) {
		fx_set(fx_list,which,name,arg[0],arg[1],arg[2]);
	} else if(arg.length > 3) {
		fx_set(fx_list,which,name,arg[0],arg[1],arg[2]);
	}
}

void fx_set_threshold(ArrayList<FX> fx_list, String name, float... arg) {
	int which = 22;
	if(arg.length == 1) {
		fx_set(fx_list,which,name,arg[0]);
	} else if(arg.length == 2) {
		fx_set(fx_list,which,name,arg[0],arg[1]);
	} else if(arg.length == 3) {
		fx_set(fx_list,which,name,arg[0],arg[1],arg[2]);
	} else if(arg.length > 3) {
		fx_set(fx_list,which,name,arg[0],arg[1],arg[2]);
	}
}

void fx_set_pos(ArrayList<FX> fx_list, String name, float... arg) {
	int which = 23;
	if(arg.length == 1) {
		fx_set(fx_list,which,name,arg[0]);
	} else if(arg.length == 2) {
		fx_set(fx_list,which,name,arg[0],arg[1]);
	} else if(arg.length == 3) {
		fx_set(fx_list,which,name,arg[0],arg[1],arg[2]);
	} else if(arg.length > 3) {
		fx_set(fx_list,which,name,arg[0],arg[1],arg[2]);
	}
}

void fx_set_size(ArrayList<FX> fx_list, String name, float... arg) {
	int which = 24;
	if(arg.length == 1) {
		fx_set(fx_list,which,name,arg[0]);
	} else if(arg.length == 2) {
		fx_set(fx_list,which,name,arg[0],arg[1]);
	} else if(arg.length == 3) {
		fx_set(fx_list,which,name,arg[0],arg[1],arg[2]);
	} else if(arg.length > 3) {
		fx_set(fx_list,which,name,arg[0],arg[1],arg[2]);
	}
}

void fx_set_offset(ArrayList<FX> fx_list, String name, float... arg) {
	int which = 25;
	if(arg.length == 1) {
		fx_set(fx_list,which,name,arg[0]);
	} else if(arg.length == 2) {
		fx_set(fx_list,which,name,arg[0],arg[1]);
	} else if(arg.length == 3) {
		fx_set(fx_list,which,name,arg[0],arg[1],arg[2]);
	} else if(arg.length > 3) {
		fx_set(fx_list,which,name,arg[0],arg[1],arg[2]);
	}
}

void fx_set_speed(ArrayList<FX> fx_list, String name, float... arg) {
	int which = 26;
	if(arg.length == 1) {
		fx_set(fx_list,which,name,arg[0]);
	} else if(arg.length == 2) {
		fx_set(fx_list,which,name,arg[0],arg[1]);
	} else if(arg.length == 3) {
		fx_set(fx_list,which,name,arg[0],arg[1],arg[2]);
	} else if(arg.length > 3) {
		fx_set(fx_list,which,name,arg[0],arg[1],arg[2]);
	}
}

void fx_set_level_source(ArrayList<FX> fx_list, String name, float... arg) {
	int which = 30;
	if(arg.length == 1) {
		fx_set(fx_list,which,name,arg[0]);
	} else if(arg.length == 2) {
		fx_set(fx_list,which,name,arg[0],arg[1]);
	} else if(arg.length == 3) {
		fx_set(fx_list,which,name,arg[0],arg[1],arg[2]);
	} else if(arg.length == 4) {
		fx_set(fx_list,which,name,arg[0],arg[1],arg[2],arg[3]);
	} else if(arg.length > 4) {
		fx_set(fx_list,which,name,arg[0],arg[1],arg[2],arg[3]);
	}
}

void fx_set_level_layer(ArrayList<FX> fx_list, String name, float... arg) {
	int which = 31;
	if(arg.length == 1) {
		fx_set(fx_list,which,name,arg[0]);
	} else if(arg.length == 2) {
		fx_set(fx_list,which,name,arg[0],arg[1]);
	} else if(arg.length == 3) {
		fx_set(fx_list,which,name,arg[0],arg[1],arg[2]);
	} else if(arg.length == 4) {
		fx_set(fx_list,which,name,arg[0],arg[1],arg[2],arg[3]);
	} else if(arg.length > 4) {
		fx_set(fx_list,which,name,arg[0],arg[1],arg[2],arg[3]);
	}
}

void fx_set_colour(ArrayList<FX> fx_list, String name, float... arg) {
	int which = 32;
	if(arg.length == 1) {
		fx_set(fx_list,which,name,arg[0]);
	} else if(arg.length == 2) {
		fx_set(fx_list,which,name,arg[0],arg[1]);
	} else if(arg.length == 3) {
		fx_set(fx_list,which,name,arg[0],arg[1],arg[2]);
	} else if(arg.length == 4) {
		fx_set(fx_list,which,name,arg[0],arg[1],arg[2],arg[3]);
	} else if(arg.length > 4) {
		fx_set(fx_list,which,name,arg[0],arg[1],arg[2],arg[3]);
	}
}

void fx_set_hue(ArrayList<FX> fx_list, String name, float hue) {
	fx_set(fx_list,200,name,hue);
}

void fx_set_saturation(ArrayList<FX> fx_list, String name, float saturation) {
	fx_set(fx_list,201,name,saturation);
}

void fx_set_brightness(ArrayList<FX> fx_list, String name, float brightness) {
	fx_set(fx_list,202,name,brightness);
}

void fx_set_red(ArrayList<FX> fx_list, String name, float red) {
	fx_set(fx_list,300,name,red);
}

void fx_set_green(ArrayList<FX> fx_list, String name, float green) {
	fx_set(fx_list,301,name,green);
}

void fx_set_blue(ArrayList<FX> fx_list, String name, float blue) {
	fx_set(fx_list,302,name,blue);
}

void fx_set_alpha(ArrayList<FX> fx_list, String name, float alpha) {
	fx_set(fx_list,400,name,alpha);
}


// modulair param
void fx_set_matrix(ArrayList<FX> fx_list, String name, int target, float... arg) {
	int which = 40+target;
	if(arg.length == 1) {
		fx_set(fx_list,which,name,arg[0]);
	} else if(arg.length == 2) {
		fx_set(fx_list,which,name,arg[0],arg[1]);
	} else if(arg.length == 3) {
		fx_set(fx_list,which,name,arg[0],arg[1],arg[2]);
	} else if(arg.length > 3) {
		fx_set(fx_list,which,name,arg[0],arg[1],arg[2]);
	}
}


void fx_set_pair(ArrayList<FX> fx_list, String name, int target, float... arg) {
	int which = 50+target;
	if(arg.length == 1) {
		fx_set(fx_list,which,name,arg[0]);
	} else if(arg.length == 2) {
		fx_set(fx_list,which,name,arg[0],arg[1]);
	} else if(arg.length > 3) {
		fx_set(fx_list,which,name,arg[0],arg[1]);
	}
}

void fx_set_event(ArrayList<FX> fx_list, String name, int target, boolean arg) {
	int which = 100+target;
	fx_set(fx_list,which,name,arg);
}


/**
* main setting methode
*/
void fx_set(ArrayList<FX> fx_list, int which_setting, String name, Object... arg) {
	if(fx_list != null) {
		if(fx_list.size() > 0) {
			for(FX fx : fx_list) {
				if(fx.get_name().equals(name)) {
					fx.set(which_setting,arg);
				}
			}	
		} 
	}
}




































/**
* path shader
* v 0.3.0
*/
// post fx path
String fx_post_rope_path = null;
boolean fx_post_rope_path_exists = false;

boolean fx_post_path_exist() {
	return fx_post_rope_path_exists;
}

String get_fx_post_path() {
	if(fx_post_rope_path == null) {
		fx_post_rope_path = sketchPath()+"/shader/fx_post/";
		File f = new File(fx_post_rope_path);
		if(!f.exists()) {
			printErrTempo(60,"get_fx_post_path()",fx_post_rope_path,"no folder found");
		} else {
			fx_post_rope_path_exists = true;
		}
	} else {
		File f = new File(fx_post_rope_path);
		if(!f.exists()) {
			printErrTempo(60,"get_fx_post_path()",fx_post_rope_path,"no folder found");
		} else {
			fx_post_rope_path_exists = true;
		}

	}
	return fx_post_rope_path;
}

void set_fx_post_path(String path) {
	fx_post_rope_path = path;
}




// background fx path
String fx_bg_rope_path = null;
boolean fx_bg_rope_path_exists = false;

boolean fx_bg_path_exist() {
	return fx_bg_rope_path_exists;
}

String get_fx_bg_path() {
	if(fx_bg_rope_path == null) {
		fx_bg_rope_path = sketchPath()+"/shader/fx_bg/";
		File f = new File(fx_bg_rope_path);
		if(!f.exists()) {
			printErrTempo(60,"get_fx_bg_path()",fx_bg_rope_path,"no folder found");
		} else {
			fx_bg_rope_path_exists = true;
		}
	} else {
		File f = new File(fx_bg_rope_path);
		if(!f.exists()) {
			printErrTempo(60,"get_fx_bg_path()",fx_bg_rope_path,"no folder found");
		} else {
			fx_bg_rope_path_exists = true;
		}

	}
	return fx_bg_rope_path;
}

void set_fx_bg_path(String path) {
	fx_bg_rope_path = path;
}
















/**
* send information to shader.glsl to flip the source in case this one is a PGraphics or PImage
* v 0.0.1
*/
void set_shader_flip(PShader ps, PImage... img) {
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




void set_shader_resolution(PShader ps, ivec2 canvas, boolean on_g) {
	if(!on_g && canvas != null) {
		ps.set("resolution",canvas.x,canvas.y);
	} else {
		ps.set("resolution",width,height);
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








