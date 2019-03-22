/**
* POST FX shader collection
*
* 2019-2019
* v 0.2.1
* all filter bellow has been tested.
* @author @stanlepunk
* @see https://github.com/StanLepunK/Shader
*/








/**
* Template by Stan le punk
* this template can be used for texture or direct filtering
v 0.1.3
2018-2019
*/
// setting by class FX
PGraphics fx_template(PImage source, FX fx) {
	return fx_template(source,fx.on_g(),null);
}




// main
PShader fx_template;
PGraphics result_template;
PGraphics fx_template(PImage source, boolean on_g, vec4 level_source) {
	if(!on_g && (result_template == null 
								|| (source.width != result_template.width 
								&& source.height != result_template.height))) {
		result_template = createGraphics(source.width,source.height,get_renderer());
	}

	if(fx_template == null) {
		String path = get_fx_post_path()+"template_fx_post.glsl";
		if(fx_post_rope_path_exists) {
			fx_template = loadShader(path);
			println("load shader: template_fx_post.glsl");
		}
		println("load shader:",path);
	} else {
		if(on_g) set_shader_flip(fx_template,source);
		fx_template.set("texture_source",source);
		fx_template.set("resolution",(float)source.width,(float)source.height);

  
    // fx_template.set("color_mode",3); // mode 0 RGB / mode 3 HSB

    // fx_template.set("hue",cx); // value from 0 to 1
		fx_template.set("level_source",level_source.x,level_source.y,level_source.w,level_source.z); // value from 0 to 1
		// fx_template.set("level_source",1,1,1,1.); // value from 0 to 1

    // rendering
		render_shader(fx_template,result_template,source,on_g);

	}

	// return
	reset_reverse_g(false);
	if(on_g) {
		return null;
	} else {
		return result_template; 
	}
}







































/**
* Blur circular
* v 0.1.4
* 2018-2019
*/
// use fx setting
PGraphics fx_blur_circular(PImage source, FX fx) {
	return fx_blur_circular(source,fx.on_g(),fx.get_strength(),fx.get_num());

}

// test setting
PGraphics fx_blur_circular(PImage source, boolean on_g) {
	float strength = map(mouseX,0,width,0,100);
	int num = 36; // samples: 16 is default / max 256 but in this cas you need a very very robust graphics engine
	return fx_blur_circular(source,on_g,vec3(strength),num);
}


// main 
PShader fx_blur_circular;
PGraphics result_blur_circular;
PGraphics fx_blur_circular(PImage source, boolean on_g, vec3 strength, int num) {
	if(!on_g && (result_blur_circular == null || (source.width != result_blur_circular.width && source.height != result_blur_circular.height))) {
		result_blur_circular = createGraphics(source.width,source.height,get_renderer());
	}
	
	if(fx_blur_circular == null) {
		String path = get_fx_post_path()+"blur_circular.glsl";
		if(fx_post_rope_path_exists) {
			fx_blur_circular = loadShader(path);
			println("load shader:",path);
		}
	} else {
		if(on_g) set_shader_flip(fx_blur_circular,source);
		fx_blur_circular.set("texture_source",source);
		fx_blur_circular.set("resolution_source",source.width,source.height);
		fx_blur_circular.set("resolution",source.width,source.height);
    
    // external variable
		if(strength != null) fx_blur_circular.set("strength",strength.x);
		fx_blur_circular.set("num",num); 

		render_shader(fx_blur_circular,result_blur_circular,source,on_g);
	}
	// end
	reset_reverse_g(false);
	if(on_g) {
		return null;	
	} else {
		return result_blur_circular; 
	}
}








/**
* gaussian blur
* v 0.2.3
* 2018-2019
*/
// setting by class FX
PGraphics fx_blur_gaussian(PImage source, FX fx) {
	ivec2 res = ivec2();
	boolean second_pass = true;
	return fx_blur_gaussian(source,fx.on_g(),second_pass,res,fx.get_strength().x());
}


// test setting
PGraphics fx_blur_gaussian(PImage source, boolean on_g) {
	ivec2 res = ivec2();
	boolean second_pass = true;
	float size = 5; // blur
	return fx_blur_gaussian(source,on_g,second_pass,res,size);
}

// main
PShader fx_blur_gaussian;
PGraphics result_blur_gaussian;
PGraphics fx_blur_gaussian(PImage source, boolean on_g, boolean second_pass, ivec2 resolution, float strength) {
	if(!on_g && (result_blur_gaussian == null || (source.width != result_blur_gaussian.width && source.height != result_blur_gaussian.height))) {
		result_blur_gaussian = createGraphics(source.width,source.height,get_renderer());
	}
  
  if(result_blur_gaussian == null) {
  	// security, because that's return problem consol with too much waring message for PImage source
  	if(resolution != null && !all(equal(ivec2(-1),resolution))) {
  		result_blur_gaussian = fx_image(source,false,null,null,null,null,SCREEN);
  	}
  } else {
  	if(resolution != null && !all(equal(ivec2(result_blur_gaussian),resolution))) {
  		result_blur_gaussian = fx_image(source,false,null,null,null,null,SCREEN);
  	}
  }


	PGraphics pg;
  PGraphics pg_2;

	if(resolution == null) {
  	pg = createGraphics(result_blur_gaussian.width,result_blur_gaussian.height,get_renderer());
  	pg_2 = createGraphics(result_blur_gaussian.width,result_blur_gaussian.height,get_renderer());
  } else {
  	int min_res = 10;
  	if(any(lessThanEqual(resolution,ivec2(min_res)))) {
  		resolution.set(result_blur_gaussian.width,result_blur_gaussian.height);
  	}
  	pg = createGraphics(resolution.x,resolution.y,get_renderer());
  	pg_2 = createGraphics(resolution.x,resolution.y,get_renderer());
  }

	
	if(fx_blur_gaussian == null) {
		String path = get_fx_post_path()+"blur_gaussian.glsl";
		if(fx_post_rope_path_exists) {
			fx_blur_gaussian = loadShader(path);
			println("load shader:",path);
		}
	} else {
		// flip part, for the case it's a texture, PImage or PGraphics
		fx_blur_gaussian.set("texture_source",source);
		if(on_g) {
			fx_blur_gaussian.set("flip_source",true,false);
			if(graphics_is(source).equals("PGraphics") && !reverse_g_source_is()) {
				fx_blur_gaussian.set("flip_source",false,false);
				reverse_g_source(true);
			} 
		}


		if(resolution != null) {
			fx_blur_gaussian.set("resolution",resolution.x,resolution.y);
			fx_blur_gaussian.set("resolution_source",resolution.x,resolution.y);
		}


		// external parameter
		if(strength <= 0.001) strength = 0.001;
		fx_blur_gaussian.set("size",strength); // from 1 to nowhere
		fx_blur_gaussian.set("sigma",.5); // better between 0 and 1
		fx_blur_gaussian.set("horizontal_pass",true);
	  


	  // rendering 
	  if(!on_g) {
	  	pg.beginDraw();            
	    pg.shader(fx_blur_gaussian);
	    pg.image(result_blur_gaussian,0,0); 
	    pg.endDraw();

	    // Applying the blur shader along the horizontal direction   
	    if(second_pass) {
	    	fx_blur_gaussian.set("texture_source",pg);
	    	fx_blur_gaussian.set("horizontal_pass",false); 	
	    	pg_2.beginDraw();            
	    	pg_2.shader(fx_blur_gaussian);  
	    	pg_2.image(pg,0,0);
	    	pg_2.endDraw(); 	
	    }
	  } else if(on_g) {
	  	g.filter(fx_blur_gaussian);
	  	// Applying the blur shader along the horizontal direction   
	  	if(second_pass) {
	  		fx_blur_gaussian.set("texture_source",g);
	    	fx_blur_gaussian.set("horizontal_pass",false);
	    	g.filter(fx_blur_gaussian);
	  	}
	  }  
	}
	
  // end
  reset_reverse_g(false);
	if(on_g) {
		return null;
	} else {
		if(second_pass) {
			return pg_2; 
		} else {
			return pg;
		}
		
	}
}

















/**
* Blur radial
v 0.2.4
2018-2019
*/
// setting by class FX
PGraphics fx_blur_radial(PImage source, FX fx) {
	float str = 0;
	if(fx.get_strength() != null) {
		str = fx.get_strength().x();
	}

	float scl = 0;
	if(fx.get_scale() != null) {
		scl = fx.get_scale().x();
	}
	return fx_blur_radial(source,fx.on_g(),vec2(fx.get_pos()),str,scl);
}





// main
PShader fx_blur_radial;
PGraphics result_blur_radial;
PGraphics fx_blur_radial(PImage source, boolean on_g, vec2 pos, float strength, float scale) {
	if(!on_g && (result_blur_radial == null 
								|| (source.width != result_blur_radial.width 
								&& source.height != result_blur_radial.height))) {
		result_blur_radial = createGraphics(source.width,source.height,get_renderer());
	}
	
	if(fx_blur_radial == null) {
		String path = get_fx_post_path()+"blur_radial.glsl";
		if(fx_post_rope_path_exists) {
			fx_blur_radial = loadShader(path);
			println("load shader:",path);
		}
	} else {
		if(on_g) set_shader_flip(fx_blur_radial,source);
		fx_blur_radial.set("texture_source",source);

    // external parameter
		fx_blur_radial.set("scale",scale); // from 0 to beyond but good around .9;
		fx_blur_radial.set("strength",strength);
		if(pos != null) fx_blur_radial.set("position",pos.x,pos.y);
		
		render_shader(fx_blur_radial,result_blur_radial,source,on_g);
	}
	
	// return
	reset_reverse_g(false);
	if(on_g) {
		return null;
	} else {
		return result_blur_radial; 
	}
}












/**
* Colour change A by Stan le punk
v 0.2.2
2018-2019
*/

// setting by class FX
PGraphics fx_colour_change_a(PImage source, FX fx) {
	return fx_colour_change_a(source,fx.on_g(),fx.get_num(),fx.get_matrix());
}

// test
PGraphics fx_colour_change_a(PImage source, boolean on_g) {
	vec3 col_0 = vec3().sin_wave(frameCount,.001,.02,.005).mult(10);
  vec3 col_1 = vec3().cos_wave(frameCount,.001,.02,.005).mult(10);
  vec3 col_2 = vec3().sin_wave(frameCount,.01,.002,.002).mult(10);
		// 	vec3 col_0 = vec3(-1,0,1);
		// vec3 col_1 = vec3(1,0,-1);
		// vec3 col_2 = vec3(-1,0,1);	
	int num = (int)map(mouseX,0,width,1,32);
	return fx_colour_change_a(source,false,num,col_0);
}


// main
PShader fx_colour_change_a;
PGraphics result_colour_change_a;
PGraphics fx_colour_change_a(PImage source, boolean on_g, int num, vec3... mat) {
	if(!on_g && (result_colour_change_a == null 
								|| (source.width != result_colour_change_a.width 
								&& source.height != result_colour_change_a.height))) {
		result_colour_change_a = createGraphics(source.width,source.height,get_renderer());
	}
	
	if(fx_colour_change_a == null) {
		String path = get_fx_post_path()+"colour_change_A.glsl";
		if(fx_post_rope_path_exists) {
			fx_colour_change_a = loadShader(path);
			println("load shader:",path);
		}
	} else {
		if(on_g) set_shader_flip(fx_colour_change_a,source);
		fx_colour_change_a.set("texture_source",source);

		// external param
		if(mat != null && mat.length == 1) {
			if(mat[0] != null) fx_colour_change_a.set("mat_col_0",mat[0].x,mat[0].y,mat[0].z);
		} else if(mat != null && mat.length == 2) {
			if(mat[0] != null) fx_colour_change_a.set("mat_col_0",mat[0].x,mat[0].y,mat[0].z);
			if(mat[1] != null) fx_colour_change_a.set("mat_col_1",mat[1].x,mat[1].y,mat[1].z);
		} else if(mat != null && mat.length > 2) {
			if(mat[0] != null) fx_colour_change_a.set("mat_col_0",mat[0].x,mat[0].y,mat[0].z);
			if(mat[1] != null) fx_colour_change_a.set("mat_col_1",mat[1].x,mat[1].y,mat[1].z);
			if(mat[2] != null) fx_colour_change_a.set("mat_col_2",mat[2].x,mat[2].y,mat[2].z);
		}

		fx_colour_change_a.set("num",num);

		render_shader(fx_colour_change_a,result_colour_change_a,source,on_g);

	}
	
	// return
	reset_reverse_g(false);
	if(on_g) {
		return null;	
	} else {
		return result_colour_change_a; 
	}
}













/**
* colour change B
* v 0.0.4
* 2018-2019
*/

// setting by class FX
PGraphics fx_colour_change_b(PImage source, FX fx) {
	float angle = 0;
	if(fx.get_angle() != null) {
		angle = fx.get_angle().x;
	}

	float strength = 0;
	if(fx.get_strength() != null) {
		strength = fx.get_strength().x;
	}
	return fx_colour_change_b(source,fx.on_g(),angle,strength);
}

// test
PGraphics fx_colour_change_b(PImage source, boolean on_g) {
	float angle = map(mouseX,0,width,0,TAU);
	float strength = map(mouseY,0,height,1,10);
	return fx_colour_change_b(source,on_g,angle,strength);
}

PShader fx_colour_change_b;
PGraphics pg_colour_change_b;
PGraphics fx_colour_change_b(PImage source, boolean on_g, float angle, float strength) {
	if(!on_g && (pg_colour_change_b == null 
								|| (source.width != pg_colour_change_b.width 
								&& source.height != pg_colour_change_b.height))) {
		pg_colour_change_b = createGraphics(source.width,source.height,get_renderer());
	}

	if(fx_colour_change_b == null) {
		String path = get_fx_post_path()+"colour_change_B.glsl";
		if(fx_post_rope_path_exists) {
			fx_colour_change_b = loadShader(path);
			println("load shader:",path);
		}
	} else {
		if(on_g) set_shader_flip(fx_colour_change_b,source);
		fx_colour_change_b.set("texture_source",source);
		fx_colour_change_b.set("resolution_source",source.width,source.height);
		
		// external parameter
    fx_colour_change_b.set("angle",angle); 
    fx_colour_change_b.set("strength",1.);

    // rendering
		render_shader(fx_colour_change_b,pg_colour_change_b,source,on_g);
	}

	// return
	reset_reverse_g(false);
	if(on_g) {
		return null;
	} else {
		return pg_colour_change_b; 
	}
}























/**
* Datamosh inpired by an algorithm of Alexandre Rivaux 
* @see https://github.com/alexr4/datamoshing-GLSL
* v 0.0.2
*2019-2019
*/
// setting by class FX
PGraphics fx_datamosh(PImage source, FX fx) {
	return fx_datamosh(source,fx.on_g(),fx.get_threshold().x(),fx.get_strength().x(),fx.get_pair(0),fx.get_pair(1),fx.get_pair(2));
}

// main
PShader fx_datamosh;
PShader fx_flip_datamosh;
PGraphics pg_datamosh;
PGraphics fx_datamosh(PImage source, boolean on_g, float threshold, float strength, vec2 offset_red, vec2 offset_green, vec2 offset_blue) {
	if(!on_g && (pg_datamosh == null 
								|| (source.width != pg_datamosh.width 
								&& source.height != pg_datamosh.height))) {
		pg_datamosh = createGraphics(source.width,source.height,get_renderer());
	}

	if(fx_datamosh == null) {
		// main glsl
		String path = get_fx_post_path()+"datamosh.glsl";
		if(fx_post_rope_path_exists) {
			fx_datamosh = loadShader(path);
			println("load shader: datamosh.glsl");
		}
		println("load shader:",path);
		// flip glsl
		path = get_fx_post_path()+"flip.glsl";
		if(fx_post_rope_path_exists) {
			fx_flip_datamosh = loadShader(path);
			println("load shader: flip.glsl");
		}
		println("load shader:",path);
	} else {
		if(on_g) set_shader_flip(fx_datamosh,source);

		fx_datamosh.set("resolution",(float)source.width,(float)source.height);
		fx_datamosh.set("resolution_source",(float)source.width,(float)source.height);

    fx_datamosh.set("texture",source);
    
    fx_datamosh.set("strength",strength); // value from -infinite to infinite 
		fx_datamosh.set("threshold",threshold); // value from 0 to 1

		if(offset_red != null) {
			fx_datamosh.set("offset_red",offset_red.x(),offset_red.y());
		}

		if(offset_green != null) {
			fx_datamosh.set("offset_green",offset_green.x(),offset_green.y());
		}
		
		if(offset_blue != null) {
			fx_datamosh.set("offset_blue",offset_blue.x(),offset_blue.y());
		} 

		if(pg_datamosh == null) {
			pg_datamosh = createGraphics(source.width,source.height,get_renderer());
		} else {
			fx_datamosh.set("texture_layer",pg_datamosh);
		}
		if(pg_datamosh.width > 0 && pg_datamosh.height > 0) {
			pg_datamosh.beginDraw();
			pg_datamosh.shader(fx_datamosh);
			pg_datamosh.image(source,0,0);
			pg_datamosh.endDraw();
		}
	}

	// return
	reset_reverse_g(false);
	if(on_g) {
		background(pg_datamosh,CENTER);
		fx_flip_datamosh.set("texture_source",g);
		fx_flip_datamosh.set("resolution_source",width,height);
		fx_flip_datamosh.set("flip_source",1,1);
		filter(fx_flip_datamosh);
		return null;
	} else {
		return pg_datamosh; 
	}
}



























/**
* Dither bayer 8
* v 0.2.0
* 2018-2019
*/
// setting by class FX
PGraphics fx_dither_bayer_8(PImage source, FX fx) {
	return fx_dither_bayer_8(source,fx.on_g(),vec3(fx.get_level_source()),fx.get_mode());	
}

// main
PShader fx_dither_bayer_8;
PGraphics pg_dither_bayer_8;
PGraphics fx_dither_bayer_8(PImage source, boolean on_g, vec3 level, int mode) {
	if(!on_g && (pg_dither_bayer_8 == null 
								|| (source.width != pg_dither_bayer_8.width 
								&& source.height != pg_dither_bayer_8.height))) {
		pg_dither_bayer_8 = createGraphics(source.width,source.height,get_renderer());
	}

	
	if(fx_dither_bayer_8 == null) {
		String path = get_fx_post_path()+"dither_bayer_8.glsl";
		if(fx_post_rope_path_exists) {
			fx_dither_bayer_8 = loadShader(path);
			println("load shader:",path);
		}
	} else {
		if(on_g) set_shader_flip(fx_dither_bayer_8,source);
		fx_dither_bayer_8.set("texture_source",source);
		fx_dither_bayer_8.set("resolution_source",source.width,source.height);


		// external parameter
    fx_dither_bayer_8.set("level_source",level.x,level.y,level.z);
    fx_dither_bayer_8.set("mode",mode); // mode 0 : gray / 1 is rgb

    // rendering
		render_shader(fx_dither_bayer_8,pg_dither_bayer_8,source,on_g);
	}

	// return
	reset_reverse_g(false);
	if(on_g) {
		return null;
	} else {
		return pg_dither_bayer_8; 
	}
}












/**
* Flip
* v 0.0.1
*2019-2019
*/
// setting by class FX
PGraphics fx_flip(PImage source, FX fx) {
	return fx_flip(source,fx.on_g(),fx.get_event(0).xy());
}

// main
PShader fx_flip;
PGraphics pg_flip;
PGraphics fx_flip(PImage source, boolean on_g, bvec2 flip) {
	if(!on_g && (pg_flip == null 
								|| (source.width != pg_flip.width 
								&& source.height != pg_flip.height))) {
		pg_flip = createGraphics(source.width,source.height,get_renderer());
	}

	if(fx_flip == null) {
		// main glsl
		String path = get_fx_post_path()+"flip.glsl";
		if(fx_post_rope_path_exists) {
			fx_flip = loadShader(path);
			println("load shader: flip.glsl");
		}
		println("load shader:",path);
	} else {

		ivec2 iflip = ivec2(0);
		if(flip.x) iflip.x(1);
		if(flip.y) iflip.y(1);
		if(on_g) {
			iflip.y = 1-iflip.y;
		}

		fx_flip.set("resolution",(float)source.width,(float)source.height);
		fx_flip.set("resolution_source",(float)source.width,(float)source.height);
    fx_flip.set("texture_source",source);
		fx_flip.set("flip_source",iflip.x(),iflip.y()); // value: 0 or 1

    // rendering
		render_shader(fx_flip,pg_flip,source,on_g);
	}

	// return
	reset_reverse_g(false);
	if(on_g) {
		return null;
	} else {
		return pg_flip; 
	}
}















/**
* Grain 
v 0.1.4
2018-2019
*/

// setting by class FX
PGraphics fx_grain(PImage source, FX fx) {
	float offset = 0;
	if(fx.get_offset() != null) {
		offset = fx.get_offset().x;
	}

	float scl = 0;
	if(fx.get_scale() != null) {
		scl = fx.get_scale().x;
	}
	return fx_grain(source,fx.on_g(),offset,fx.get_mode());
}

// main
PShader fx_grain;
PGraphics result_grain;
PGraphics fx_grain(PImage source, boolean on_g, float offset, int mode) {
	if(!on_g && (result_grain == null 
								|| (source.width != result_grain.width 
								&& source.height != result_grain.height))) {
		result_grain = createGraphics(source.width,source.height,get_renderer());
	}

	if(fx_grain == null) {
		String path = get_fx_post_path()+"grain.glsl";
		if(fx_post_rope_path_exists) {
			fx_grain = loadShader(path);
			println("load shader:",path);
		}
	} else {
		if(on_g) set_shader_flip(fx_grain,source);
		fx_grain.set("texture_source",source);
		fx_grain.set("resolution_source",source.width,source.height);
		fx_grain.set("resolution",source.width,source.height);

		// external param
    fx_grain.set("offset",offset); // that define the offset
		fx_grain.set("mode",mode); // mode 0 is for black and white, and mode 1 for RVB

		render_shader(fx_grain,result_grain,source,on_g);

	}

	// return
	reset_reverse_g(false);
	if(on_g) {
		return null;	
	} else {
		return result_grain; 
	}
}


















/**
* Grain scatter
v 0.1.4
2018-2019
*/
// setting by class FX
PGraphics fx_grain_scatter(PImage source, FX fx) {
		float str = 0;
	if(fx.get_strength() != null) {
		str = fx.get_strength().x;
	}
	return fx_grain_scatter(source,fx.on_g(),str);
}


// main
PShader fx_grain_scatter;
PGraphics result_grain_scatter;
PGraphics fx_grain_scatter(PImage source, boolean on_g,float strength) {
	if(!on_g && (result_grain_scatter == null 
								|| (source.width != result_grain_scatter.width 
								&& source.height != result_grain_scatter.height))) {
		result_grain_scatter = createGraphics(source.width,source.height,get_renderer());
	}

	if(fx_grain_scatter == null) {
		String path = get_fx_post_path()+"grain_scatter.glsl";
		if(fx_post_rope_path_exists) {
			fx_grain_scatter = loadShader(path);
			println("load shader:",path);
		}
	} else {
		if(on_g) set_shader_flip(fx_grain_scatter,source);
		fx_grain_scatter.set("texture_source",source);
		fx_grain_scatter.set("resolution_source",source.width,source.height);
		fx_grain_scatter.set("resolution",source.width,source.height);

		// external param
		fx_grain_scatter.set("strength",strength);

		// rendering
		render_shader(fx_grain_scatter,result_grain_scatter,source,on_g);

	}
	// return
	reset_reverse_g(false);
	if(on_g) {
		return null;
	} else {
		return result_grain_scatter; 
	}
}



















/**
* halftone dot
* v 0.0.5
* 2018-2019
*/
// setting by class FX
PGraphics fx_halftone_dot(PImage source, FX fx) {
	vec2 pos = vec2(source.width/2,source.height/2);
	if(fx.get_pos() != null) {
		pos = vec2(fx.get_pos().x(),fx.get_pos().y());
	}

	float threshold = .95;
	if(fx.get_threshold() != null) {
		threshold = fx.get_threshold().x();
	}

	float angle = 0;
	if(fx.get_angle() != null) {
		angle = fx.get_angle().x();
	}

	float pixel_size = 5;
	if(fx.get_angle() != null) {
		pixel_size = fx.get_size().x();
	}

	return fx_halftone_dot(source,fx.on_g(),pos,pixel_size,angle,threshold);
}




// test
PGraphics fx_halftone_dot(PImage source, boolean on_g) {
	vec2 pos = vec2(mouseX,mouseY);
	float threshold = .95;
	float size = 30;
	float pixel_size = (abs(sin(frameCount *.01))) *size +1;
	float angle = sin(frameCount *.001) *TAU;

	return fx_halftone_dot(source,on_g,pos,pixel_size,angle,threshold);
}




// main
PShader fx_halftone;
PGraphics result_halftone_dot;
PGraphics fx_halftone_dot(PImage source, boolean on_g, vec2 pos, float size, float angle, float threshold) {
	if(!on_g && (result_halftone_dot == null 
								|| (source.width != result_halftone_dot.width 
								&& source.height != result_halftone_dot.height))) {
		result_halftone_dot = createGraphics(source.width,source.height,get_renderer());
	}

	if(fx_halftone == null) {
		String path = get_fx_post_path()+"halftone_dot.glsl";
		if(fx_post_rope_path_exists) {
			fx_halftone = loadShader(path);
			println("load shader:",path);
		}
	} else {
		if(on_g) set_shader_flip(fx_halftone,source);
		fx_halftone.set("texture_source",source);
		fx_halftone.set("resolution_source",source.width,source.height);

		// external parameter
		fx_halftone.set("angle",angle);
    pos.div(source.width,source.height);
    if(graphics_is(source).equals("PGraphics")) {
    	pos.y(1.0 -pos.y);
    }
    fx_halftone.set("position",pos.x,pos.y);

		
		fx_halftone.set("size",size);
		fx_halftone.set("threshold",threshold);

		render_shader(fx_halftone,result_halftone_dot,source,on_g);

	}

	// return
	reset_reverse_g(false);
	if(on_g) {
		return null;
	} else {
		return result_halftone_dot; 
	}
}










/**
* halftone line
* v 0.0.7
* 2018-2019
*/
// use setting
PGraphics fx_halftone_line(PImage source, FX fx) {
	vec2 pos = vec2(source.width/2,source.height/2);
	if(fx.get_pos() != null) {
		pos = vec2(fx.get_pos().x,fx.get_pos().y);
	}

	vec3 angle = vec3();
	if(fx.get_angle() != null) {
		angle = fx.get_angle().copy();
	}

	int mode = fx.get_mode();
	int num = fx.get_num();
	float quality = fx.get_quality();

  vec3 threshold = vec3(.9);
	if(fx.get_threshold() != null) {
		threshold = fx.get_threshold().copy();
	}
	return fx_halftone_line(source,fx.on_g(),pos,angle,mode,num,quality,threshold);	
}





// local test setting
PGraphics fx_halftone_line(PImage source, boolean on_g) {
	int mode = 0; // from 0 to 6
	int num = 30; // number of line
	float quality = .5; 
	float threshold = .2; // good between 0.05 and 0.3
	float angle = sin(frameCount *.001) * PI; // angle in radians
	float pos_x = map(width/2,0,width,0,1); // normal position
	float pos_y = map(height/2,0,height,0,1); // normal position
	return fx_halftone_line(source,on_g,vec2(pos_x,pos_y),vec3(angle),mode,num,quality,vec3(threshold));
}

// main
PShader fx_halftone_line;
PGraphics result_halftone_line;
PGraphics fx_halftone_line(PImage source, boolean on_g, vec2 pos, vec3 angle, int mode, int num, float quality, vec3 threshold) {
	if(!on_g && (result_halftone_line == null 
								|| (source.width != result_halftone_line.width 
								&& source.height != result_halftone_line.height))) {
		result_halftone_line = createGraphics(source.width,source.height,get_renderer());
	}

	if(fx_halftone_line == null) {
		String path = get_fx_post_path()+"halftone_line.glsl";
		if(fx_post_rope_path_exists) {
			fx_halftone_line = loadShader(path);
			println("load shader:",path);
		}
	} else {
		if(on_g) set_shader_flip(fx_halftone_line,source);
		fx_halftone_line.set("texture_source",source);
		fx_halftone_line.set("resolution_source",source.width,source.height);
    
    // external parameter
    fx_halftone_line.set("mode",mode);
    fx_halftone_line.set("num",num);
    fx_halftone_line.set("quality",quality);
    fx_halftone_line.set("threshold",threshold.x); // good between 0.05 and 0.3
		fx_halftone_line.set("angle",angle.x);

		if(graphics_is(source).equals("PGraphics")) {
			pos.y(1.0 -pos.y);
		}
		fx_halftone_line.set("position",pos.x,pos.y); // middle position on window

    // rendering
		render_shader(fx_halftone_line,result_halftone_line,source,on_g);
	}

	// return
	reset_reverse_g(false);
	if(on_g) {
		return null;
	} else {
		return result_halftone_line; 
	}
}



/**
* Halftone Multi
* refactoring from 
* v 0.0.2
* 2019-2019
*/
// use setting
PGraphics fx_halftone_multi(PImage source, FX fx) {
	return fx_halftone_multi(source,fx.on_g(),vec2(fx.get_pos()),fx.get_size().x,fx.get_angle().x,fx.get_quality(),fx.get_threshold().x,fx.get_saturation(),fx.get_mode());
}


// main
PShader fx_halftone_multi;
PGraphics pg_halftone_multi;
PGraphics fx_halftone_multi(PImage source, boolean on_g, vec2 pos, float size, float angle, float quality, float threshold, float saturation, int mode) {
	if(!on_g && (pg_halftone_multi == null 
								|| (source.width != pg_halftone_multi.width 
								&& source.height != pg_halftone_multi.height))) {
		pg_halftone_multi = createGraphics(source.width,source.height,get_renderer());
	}

	if(fx_halftone_multi == null) {
		String path = get_fx_post_path()+"halftone_multi.glsl";
		if(fx_post_rope_path_exists) {
			fx_halftone_multi = loadShader(path);
			println("load shader:",path);
		}
	} else {
    if(on_g) set_shader_flip(fx_halftone_multi,source);
		fx_halftone_multi.set("texture_source",source);
		fx_halftone_multi.set("resolution_source",source.width,source.height);
    
		// external param
		if(graphics_is(source).equals("PGraphics")) {
			pos.y(1.0 -pos.y);
		}
		fx_halftone_multi.set("position",pos.x,pos.y); // -1 to 1
		float sat = map(saturation,0,1,-1,1);
		fx_halftone_multi.set("saturation",sat); // -1 to 1
		fx_halftone_multi.set("angle",angle); // in radian
		fx_halftone_multi.set("scale",size); // from 0 to 2 is good
		fx_halftone_multi.set("divs",quality); // from 1 to 16
		fx_halftone_multi.set("sharpness",threshold); // from 0 to 2 is good
		fx_halftone_multi.set("mode",mode); // from 0 to 3 dot, circle and line

		 // rendering
    render_shader(fx_halftone_multi,pg_halftone_multi,source,on_g);
	}

	// end
	reset_reverse_g(false);
	if(on_g) {
		return null;
	} else {
		return pg_halftone_multi; 
	}
}











/**
* IMAGE MAPPING
* 
*/
// setting by class FX
PGraphics fx_image(PImage source, FX fx) {
	return fx_image(source,fx.on_g(),vec2(fx.get_pos()),vec2(fx.get_size()),vec3(fx.get_colour()),fx.get_cardinal(),fx.get_mode());
}


// main
PShader fx_image;
PGraphics pg_image_rendering;
PGraphics fx_image(PImage source, boolean on_g, vec2 pos, vec2 scale, vec3 colour_background, vec4 pos_curtain, int mode) {
	if(!on_g && (pg_image_rendering == null 
								|| (source.width != pg_image_rendering.width 
								&& source.height != pg_image_rendering.height))) {
		pg_image_rendering = createGraphics(source.width,source.height,get_renderer());
	}

	if(fx_image == null) {
		String path = get_fx_post_path()+"image.glsl";
		if(fx_post_rope_path_exists) {
			fx_image = loadShader(path);
			println("load shader: image.glsl");
		}
		println("load shader:",path);
	} else {
		
		if(on_g) set_shader_flip(fx_image,source);
		// fx_image.set("flip_source",true,false);
		fx_image.set("texture_source",source);
		fx_image.set("resolution",width,height);
		fx_image.set("resolution_source",source.width,source.height); 
		
		// fx_image.set("flip_source",true,false);
		// fx_image.set("texture_source",source);
		// fx_image.set("resolution",width,height);
		// fx_image.set("resolution_source",source.width,source.height); 

    // external parameter
		if(colour_background != null) {
			println("colour",colour_background);
	    fx_image.set("colour",colour_background.x,colour_background.y,colour_background.z); // definr RGB color from 0 to 1
	  }

	  if(pos_curtain != null) {
	  	// printTempo(60,"curtain",pos_curtain);
	    fx_image.set("curtain",pos_curtain.x,pos_curtain.y,pos_curtain.z,pos_curtain.w); // definr RGB color from 0 to 1
	  }

	  if(pos != null) {
	  	if(graphics_is(source).equals("PGraphics")) {
	  		pos.y(1.0 -pos.y);
	  	}
	    fx_image.set("position",pos.x,pos.y); // from 0 to 1
	  }
	  
	  if(scale != null) {
	    fx_image.set("scale",scale.x,scale.y);
	  }
	  
	  int shader_mode = 0;
	  if(mode == CENTER) {
	    shader_mode = 0;
	  } else if(mode == SCREEN) {
	    shader_mode = 1;
	  } else if(mode == r.SCALE) {
	    shader_mode = 2;
	  }
	  // println("mode",shader_mode);
	  fx_image.set("mode",shader_mode);

    // rendering
		render_shader(fx_image,pg_image_rendering,source,on_g);
	}

	// return
	reset_reverse_g(false);
	if(on_g) {
		return null;
	} else {
		return pg_image_rendering; 
	}
}






















/**
* Level
v 0.0.3
2019-2019
*/
// direct filtering
PGraphics fx_level(PImage source, FX fx) {
	vec3 level = vec3(1);
	if(fx.get_level_source() != null) {
		level.set(fx.get_level_source());
	}
	return fx_level(source,fx.on_g(),fx.get_mode(),level.array());
}

// PGraphics filtering
PGraphics fx_level(PImage source, boolean on_g) {
	int mode = 0;
	vec3 level = abs(vec3().sin_wave(frameCount,.01,.02,.04));
	return fx_level(source,on_g,mode,level.array());
}

// main method
PShader fx_level;
PGraphics result_level;
PGraphics fx_level(PImage source, boolean on_g, int mode, float... level) {
	if(!on_g && (result_level == null 
								|| (source.width != result_level.width 
								&& source.height != result_level.height))) {
		result_level = createGraphics(source.width,source.height,get_renderer());
	}

	if(fx_level == null) {
		String path = get_fx_post_path()+"level.glsl";
		if(fx_post_rope_path_exists) {
			fx_level = loadShader(path);
			println("load shader:",path);
		}
	} else {
		if(on_g) set_shader_flip(fx_level,source);
		fx_level.set("texture_source",source);
		fx_level.set("resolution_source",source.width,source.height);
		if(level.length == 1) {
			fx_level.set("level_source",level[0],level[0],level[0],1);
		} else if(level.length == 2) {
			fx_level.set("level_source",level[0],level[0],level[0],level[1]);
		} else if(level.length == 3) {
			fx_level.set("level_source",level[0],level[1],level[2],1);
		} else if(level.length == 4) {
			fx_level.set("level_source",level[0],level[1],level[2],level[3]);
		} else {
			fx_level.set("level_source",1,1,1,1);
		}
		
		if(mode >= 0 && mode < 2) {
			fx_level.set("mode",mode); // 0 black / 1 white
		} 


    // rendering
		render_shader(fx_level,result_level,source,on_g);

	}

	// return
	reset_reverse_g(false);
	if(on_g) {
		return null;
	} else {
		return result_level; 
	}
}














/**
* mix
* v 0.0.6
* 2019-2019
*
* -2 main
* -1 layer 
* 0 ?
* 1 multiply
* 2 screen
* 3 exclusion
* 4 overlay
* 5 hard_light
* 6 soft_light
* 7 color_dodge
* 8 color_burn
* 9 linear_dodge
* 10 linear_burn
* 11 vivid_light
* 12 linear_light
* 13 pin_light
* 14 hard_mix
*  15 subtract
* 16 divide
* 17 addition
* 18 difference
* 19 darken
* 20 lighten
* 21 invert
* 22 invert_rgb
* 23 main
* 24 layer
*/

// test
PGraphics fx_mix(PImage source, PImage layer, FX fx) {
	vec3 level_source = vec3(.5);
	if(fx.get_level_source() != null) {
		level_source = vec3(fx.get_level_source());
	}
	vec3 level_layer = vec3(.5);
	if(fx.get_level_layer() != null) {
		level_layer = vec3(fx.get_level_layer());
	}
  return fx_mix(source,layer,true,fx.get_mode(),level_source,level_layer);
	
}

// test
PGraphics fx_mix(PImage source, PImage layer, boolean on_g) {
	int mode = 1; // multiply
	vec3 level_source = abs(vec3().sin_wave(frameCount,.01,.025,.05));
	vec3 level_layer = abs(vec3().cos_wave(frameCount,.01,.025,.05));
	return fx_mix(source,layer,on_g,mode,level_source,level_layer);
}


// main
PShader fx_mix;
PGraphics result_mix;
PGraphics fx_mix(PImage source, PImage layer, boolean on_g, int mode, vec3 level_source, vec3 level_layer) {
	if(!on_g && (result_mix == null 
								|| (source.width != result_mix.width 
								&& source.height != result_mix.height))) {
		result_mix = createGraphics(source.width,source.height,get_renderer());
	}

	if(fx_mix == null) {
		String path = get_fx_post_path()+"mix.glsl";
		if(fx_post_rope_path_exists) {
			fx_mix = loadShader(path);
			println("load shader:",path);
		}
	} else {
		if(on_g) set_shader_flip(fx_mix,source);

		fx_mix.set("texture_source",source);
		fx_mix.set("resolution_source",source.width,source.height);
		fx_mix.set("texture_layer",layer);
		
		if(graphics_is(layer).equals("PGraphics")) {
			fx_mix.set("flip_layer",0,0);
		} else {
			if(on_g) {
				fx_mix.set("flip_layer",1,0);
			}
		}
		

    // external paramer
    fx_mix.set("level_source",level_source.x,level_source.y,level_source.z);
		fx_mix.set("level_layer",level_layer.x,level_layer.y,level_layer.z);

		fx_mix.set("mode",mode); 
    
    // rendering
    render_shader(fx_mix,result_mix,source,on_g);
 
	}

	// end
	reset_reverse_g(false);
	if(on_g) {
		return null;
	} else {
		return result_mix; 
	}
}



















/**
* Pixel 
* v 0.0.5
* 2018-2019
*/
// setting by class FX
PGraphics fx_pixel(PImage source, FX fx) {
	ivec2 size = ivec2(5);
	if(fx.get_size() != null) {
		size.set(fx.get_size());
	}
	vec3 level_source = vec3(0,.5,.5);
	if(fx.get_level_source() != null) {
		level_source.set(fx.get_level_source());
	}
	return fx_pixel(source,fx.on_g(),size,fx.get_num(),level_source,fx.get_event(0).x());
}


// test
PGraphics fx_pixel(PImage source, boolean on_g) {
	ivec2 size = ivec2(5);
	int num = 8;
	vec3 level_source = vec3(1);
  boolean effect_is = true;
	return fx_pixel(source,on_g,size,num,level_source,effect_is);
}


// main
PShader fx_pixel;
PGraphics result_pixel;
PGraphics fx_pixel(PImage source, boolean on_g, ivec2 size, int num, vec3 level_source, boolean effect_is) {
	if(!on_g && (result_pixel == null 
								|| (source.width != result_pixel.width 
								&& source.height != result_pixel.height))) {
		result_pixel = createGraphics(source.width,source.height,get_renderer());
	}

	if(fx_pixel == null) {
		String path = get_fx_post_path()+"pixel.glsl";
		if(fx_post_rope_path_exists) {
			fx_pixel = loadShader(path);
			println("load shader:",path);
		}
	} else {
		if(on_g) set_shader_flip(fx_pixel,source);
		fx_pixel.set("texture_source",source);
		fx_pixel.set("resolution",source.width,source.height);
		fx_pixel.set("resolution_source",source.width,source.height);
    
		// external param
		fx_pixel.set("use_fx_color",effect_is);
		fx_pixel.set("level_source",level_source.x,level_source.y,level_source.z,1); // from 0 to 1 where
		fx_pixel.set("num",num); // from 2 to 16
    fx_pixel.set("size",size.x,size.y); // define the width and height of pixel

    // rendering
		render_shader(fx_pixel,result_pixel,source,on_g);

	}

	// return
	reset_reverse_g(false);
	if(on_g) {
		return null;
	} else {
		return result_pixel; 
	}
}
















/**
* Reaction diffusion
* v 0.0.4
* 2018-2019
*/
/**
WARNING
the g part is not not not not optimized...too slow :((((((
*/

PGraphics fx_reaction_diffusion(PImage source, FX fx) {
	return fx_reaction_diffusion(source,fx.on_g(),fx.get_pair(0),fx.get_pair(1),vec2(fx.get_scale()),vec3(fx.get_colour()),fx.get_num(),fx.get_event(0).x());
}



// test
PGraphics fx_reaction_diffusion(PImage source) {
	float u = 0.25f;
  float v = 0.04f;
  vec2 conc_uv = vec2(u,v);
  
  float k = 0.047f;
  float f = 0.1f;
  vec2 kf = vec2(k,f);
  
  vec2 scale = vec2(.6);

  float r = 0;
  float g = 0;
  float b = 0;
  vec3 rgb = vec3(r,g,b);

  int iteration = 20;
  boolean event = mousePressed;
	return fx_reaction_diffusion(source,true,conc_uv,kf,scale,rgb,iteration,event);
}




// main
PShader fx_reac_diff;
PGraphics result_reac_diff;
boolean start;
PImage buffer_reac_diff;
PGraphics fx_reaction_diffusion(PImage source, boolean on_g, vec2 conc_uv, vec2 kf, vec2 scale, vec3 rgb, int num, boolean event) {
	if(result_reac_diff == null 
								|| (source.width != result_reac_diff.width 
								&& source.height != result_reac_diff.height)) {
		result_reac_diff = createGraphics(source.width,source.height,get_renderer());
	}

	// init
	if(source != null) {
		if(fx_reac_diff == null) {
			String path = get_fx_post_path()+"reaction_diffusion.glsl";
			if(fx_post_rope_path_exists) {
				fx_reac_diff = loadShader(path);
				println("load shader:",path);
			}
		}
		if(result_reac_diff == null) {
			result_reac_diff = createGraphics(source.width,source.height,get_renderer());
			println("create feedback");
		}
	}

	// if(!texture_is) set_shader_flip(fx_reac_diff,source);
	// create buffer for g case
  	if(on_g) {
		if(buffer_reac_diff == null) {
			buffer_reac_diff = source.copy();
		} else {
			buffer_reac_diff.loadPixels();
			source.loadPixels();
			buffer_reac_diff.pixels = source.pixels;
			buffer_reac_diff.updatePixels();
		}
	}


	// reset part
	if(!start || event) {
		result_reac_diff.beginDraw();
		if(!on_g) {
			result_reac_diff.image(source,0,0,source.width,source.height);
		} else {
			result_reac_diff.image(buffer_reac_diff,0,0,source.width,source.height);
		}
		result_reac_diff.endDraw();
		start = true;
	}
  /*
	float ru = 0.25f;
	float rv = 0.04f;
	float f = 0.1f;
	float k = 0.047f;
	float red = 0;
	float green = 0;
	float blue = 0;
	 vec2 scale = vec2(.6);
	 int rd_iteration = 20;
	*/

	// effect part
	textureWrap(REPEAT);
	int rd_iteration = 20;
	if(num > 0 && num < 100) {
		rd_iteration = num;
	}
	for(int i = 0 ; i < num ; i++) {
		if(!on_g) {
			fx_reac_diff.set("texture_source",source);
		} else {
			fx_reac_diff.set("texture_source",buffer_reac_diff);
		}
		fx_reac_diff.set("texture_layer",result_reac_diff);

		fx_reac_diff.set("resolution",source.width,source.height);
		fx_reac_diff.set("resolution_source",source.width,source.height);
		fx_reac_diff.set("resolution_layer",result_reac_diff.width,result_reac_diff.height);

		// eternal param
		if(conc_uv != null) {
			fx_reac_diff.set("ru",conc_uv.u);
			fx_reac_diff.set("rv",conc_uv.v);
		} else {
			fx_reac_diff.set("ru",.25f);
			fx_reac_diff.set("rv",.04f);
		}

		// eternal param
		if(kf != null) {
			fx_reac_diff.set("k",kf.x);
			fx_reac_diff.set("f",kf.y);
		} else {
			fx_reac_diff.set("k",0.1f);
			fx_reac_diff.set("f",0.047f);
		}


		// in progress
		/*
		if(rgb != null) {
			fx_reac_diff.set("red",rgb.r);
			fx_reac_diff.set("green",rgb.g);
			fx_reac_diff.set("blue",rgb.b);
		} else {
			fx_reac_diff.set("red",0);
			fx_reac_diff.set("green",0);
			fx_reac_diff.set("blue",0);
		}
		*/


		fx_reac_diff.set("scale",scale.x,scale.y);

    // rendering
		if(result_reac_diff != null && !on_g) {
			// texture case
	  	result_reac_diff.beginDraw();
	  	result_reac_diff.shader(fx_reac_diff);
	  	result_reac_diff.image(source,0,0,source.width,source.height);
	  	result_reac_diff.resetShader();
	  	result_reac_diff.endDraw();
	  } else {
      // g case
	  	result_reac_diff.beginDraw();
	  	result_reac_diff.shader(fx_reac_diff);
	  	result_reac_diff.image(buffer_reac_diff,0,0,source.width,source.height);
	  	result_reac_diff.resetShader();
	  	result_reac_diff.endDraw();
	  	image(result_reac_diff);
	  }
	}

	// render
	if(on_g) {
		return null;
	} else {
		return result_reac_diff; 
	}
}






























/**
* split rgb
* v 0.0.6
* 2019-2019
*/
// use setting
PGraphics fx_split_rgb(PImage source, FX fx) {
	return fx_split_rgb(source,fx.on_g(),fx.get_pair(0),fx.get_pair(1),fx.get_pair(2));
}




// main
PShader fx_split_rgb;
PGraphics result_split_rgb;
PGraphics fx_split_rgb(PImage source, boolean on_g, vec2 offset_red, vec2 offset_green, vec2 offset_blue) {
	if(!on_g && (result_split_rgb == null 
								|| (source.width != result_split_rgb.width 
								&& source.height != result_split_rgb.height))) {
		result_split_rgb = createGraphics(source.width,source.height,get_renderer());
	}

	if(fx_split_rgb == null) {
		String path = get_fx_post_path()+"split_rgb_simple.glsl";
		if(fx_post_rope_path_exists) {
			fx_split_rgb = loadShader(path);
			println("load shader:",path);
		}
	} else {
    if(on_g) set_shader_flip(fx_split_rgb,source);
		fx_split_rgb.set("texture_source",source);
		fx_split_rgb.set("resolution_source",source.width,source.height);

		// external param
		// fx_split.set("offset",offset.x,offset.y);
		if(offset_red != null) {
			fx_split_rgb.set("offset_red",offset_red.x,offset_red.y);
		}

		if(offset_green != null) {
			fx_split_rgb.set("offset_green",offset_green.x,offset_green.y);
		}
		
		if(offset_blue != null) {
			fx_split_rgb.set("offset_blue",offset_blue.x,offset_blue.y);
		} 
		

		 // rendering
    render_shader(fx_split_rgb,result_split_rgb,source,on_g);
	}

	// end
	reset_reverse_g(false);
	if(on_g) {
		return null;
	} else {
		return result_split_rgb; 
	}
}







/**
* Threshold
* v 0.2.0
* 2018-2019
*/
// setting by class FX
PGraphics fx_threshold(PImage source, FX fx) {
	return fx_threshold(source,fx.on_g(),vec3(fx.get_level_source()),fx.get_mode());	
}


// main
PShader fx_threshold;
PGraphics pg_threshold;
PGraphics fx_threshold(PImage source, boolean on_g, vec3 level, int mode) {
	if(!on_g && (pg_threshold == null 
								|| (source.width != pg_threshold.width 
								&& source.height != pg_threshold.height))) {
		pg_threshold = createGraphics(source.width,source.height,get_renderer());
	}

	
	if(fx_threshold == null) {
		String path = get_fx_post_path()+"threshold.glsl";
		if(fx_post_rope_path_exists) {
			fx_threshold = loadShader(path);
			println("load shader:",path);
		}
	} else {
		if(on_g) set_shader_flip(fx_threshold,source);
		fx_threshold.set("texture_source",source);
		fx_threshold.set("resolution_source",source.width,source.height);

		// external parameter
		level = map(level,0,1,.05,1.50);
    fx_threshold.set("level_source",level.x,level.y,level.z);
    fx_threshold.set("mode",mode); // mode 0 : gray / 1 is rgb

    // rendering
		render_shader(fx_threshold,pg_threshold,source,on_g);
	}

	// return
	reset_reverse_g(false);
	if(on_g) {
		return null;
	} else {
		return pg_threshold; 
	}
}



















/**
* warp procedural line by Stan le punk
* @see http://stanlepunk.xyz
* @see https://github.com/StanLepunK/Filter
* v 0.0.5
* 2018-2019
*/
PGraphics fx_warp_proc(PImage source, FX fx) {
	return fx_warp_proc(source,fx.on_g(),fx.get_strength().x);
}

PShader fx_warp_proc;
PGraphics result_warp_proc;
PGraphics fx_warp_proc(PImage source, boolean on_g, float strength) {
	if(!on_g && (result_warp_proc == null 
								|| (source.width != result_warp_proc.width 
								&& source.height != result_warp_proc.height))) {
		result_warp_proc = createGraphics(source.width,source.height,get_renderer());
	}

	if(fx_warp_proc == null) {
		String path = get_fx_post_path()+"warp_proc.glsl";
		if(fx_post_rope_path_exists) {
			fx_warp_proc = loadShader(path);
			println("load shader:",path);
		}
	} else {
		if(on_g) set_shader_flip(fx_warp_proc,source);

		fx_warp_proc.set("texture_source",source);
		fx_warp_proc.set("resolution_source",source.width,source.height);
    
    // external parameter
		fx_warp_proc.set("strength",strength);

		// rendering
		render_shader(fx_warp_proc,result_warp_proc,source,on_g);
	}

	// return
	reset_reverse_g(false);
	if(on_g) {
		return null;
	} else {
		return result_warp_proc; 
	}
}












/**
* warp texture type A
* v 0.2.1
* 2018-2019
*/
// use setting
PGraphics fx_warp_tex_a(PImage source, PImage velocity, PImage direction, FX fx) {
	return fx_warp_tex_a(source,velocity,direction,fx.on_g(),fx.get_mode(),fx.get_strength().x);
}



// main
PShader fx_warp_tex_a;
PGraphics pg_warp_tex_a;
PGraphics fx_warp_tex_a(PImage source, PImage velocity, PImage direction, boolean on_g, int mode, float strength) {
	if(!on_g && (result_warp_proc == null 
								|| (source.width != result_warp_proc.width 
								&& source.height != result_warp_proc.height))) {
		result_warp_proc = createGraphics(source.width,source.height,get_renderer());
	}
  

	if(fx_warp_tex_a == null) {
		String path = get_fx_post_path()+"warp_tex_a.glsl";
		if(fx_post_rope_path_exists) {
			fx_warp_tex_a = loadShader(path);
			println("load shader:",path);
		}
	} else {
		if(on_g) set_shader_flip(fx_warp_tex_a,source);
		fx_warp_tex_a.set("texture_source",source);
		fx_warp_tex_a.set("resolution_source",source.width,source.height);

		
		// external parameter
		// warp sources
		if(direction != null) {
			fx_warp_tex_a.set("texture_direction",direction);
		}
		if(velocity != null) {
			fx_warp_tex_a.set("texture_velocity",velocity);
		}
		//setting external param
		fx_warp_tex_a.set("strength",strength); // good for normal value 0 > 1
		fx_warp_tex_a.set("mode",mode); // mode 0 > show warp / mode 500 show texture velocity / mode 501 show texture direction

		// rendering
		render_shader(fx_warp_tex_a,pg_warp_tex_a,source,on_g);
	}

	// return
	reset_reverse_g(false);
	if(on_g) {
		return null;
	} else {
		return pg_warp_tex_a; 
	}
}








/**
* warp texture type B
* v 0.0.1
* 2019-2019
*/
// use setting
PGraphics fx_warp_tex_b(PImage source, PImage layer, FX fx) {
	return fx_warp_tex_b(source,layer,fx.on_g(),fx.get_strength().x);
}




// main
PShader fx_warp_tex_b;
PGraphics pg_warp_tex_b;
PGraphics fx_warp_tex_b(PImage source, PImage layer, boolean on_g,float strength) {
	if(!on_g && (pg_warp_tex_b == null 
								|| (source.width != pg_warp_tex_b.width 
								&& source.height != pg_warp_tex_b.height))) {
		pg_warp_tex_b = createGraphics(source.width,source.height,get_renderer());
	}

	if(fx_warp_tex_b == null) {
		String path = get_fx_post_path()+"warp_tex_b.glsl";
		if(fx_post_rope_path_exists) {
			fx_warp_tex_b = loadShader(path);
			println("load shader:",path);
		}
	} else {
    if(on_g) set_shader_flip(fx_warp_tex_b,source,layer);
		fx_warp_tex_b.set("texture_source",source);
		fx_warp_tex_b.set("resolution_source",source.width,source.height);
		fx_warp_tex_b.set("texture_layer",layer);
		fx_warp_tex_b.set("resolution_layer",layer.width,layer.height);

		// external param
		fx_warp_tex_b.set("strength",strength);

		 // rendering
    render_shader(fx_warp_tex_b,pg_warp_tex_b,source,on_g);
	}

	// end
	reset_reverse_g(false);
	if(on_g) {
		return null;
	} else {
		return pg_warp_tex_b; 
	}
}


