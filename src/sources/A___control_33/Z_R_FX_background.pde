/**
* BACKGROUND FX
* Rope background shader fx collection
* 2019-2019
* v 0.1.8
* all filter bellow has been tested.
* @see http://stanlepunk.xyz
* @see https://github.com/StanLepunK/Shader
*/



/**
* Template fx backgournd by Stan le punk
* this template can be used for texture or direct filtering
* v 0.0.1
* 2019-2019
*/
// setting by class FX
PGraphics fx_bg_template(FX fx) {
	return fx_bg_template(fx.get_canvas(),fx.on_g(),vec3(fx.get_colour()));
}


// test setting
PGraphics fx_bg_template() {
  vec3 colour = abs(vec3().sin_wave(frameCount,.01,.02,.03));
	return fx_bg_template(null,true,colour);
}


// main
PShader fx_bg_template;
PGraphics pg_template_fx_bg;
PGraphics fx_bg_template(ivec2 canvas, boolean on_g, vec3 colour) {
	
	if(!on_g && (pg_template_fx_bg == null
								|| (canvas.x != pg_template_fx_bg.width 
								&& canvas.y != pg_template_fx_bg.height))) {
		pg_template_fx_bg = createGraphics(canvas.x,canvas.y,get_renderer());
	}
  // setting
	if(fx_bg_template == null) {
		String path = get_fx_bg_path()+"template_fx_bg.glsl";
		if(fx_bg_rope_path_exists) {
			fx_bg_template = loadShader(path);
			println("load shader: template_fx_bg.glsl");
		} 
	} else {
		set_shader_resolution(fx_bg_template,canvas,on_g);

		// render
		fx_bg_template.set("rgb",colour.x,colour.y,colour.z); // value from 0 to 1

		if(on_g) {
			filter(fx_bg_template);
		} else {
			pg_template_fx_bg.shader(fx_bg_template);
		}
	}


	if(on_g) {
		return null;
	} else {
		return pg_template_fx_bg; 
	}
}









/**
* Cellular fx backgournd by Stan le punk
* this template can be used for texture or direct filtering
* v 0.0.3
* 2019-2019
*/
// setting by class FX
PGraphics fx_bg_cellular(FX fx) {
	return fx_bg_cellular(fx.get_canvas(),fx.on_g(),fx.get_colour(),fx.get_num(),vec2(fx.get_speed()),fx.get_quality());
}




// main
PShader fx_bg_cellular;
PGraphics pg_cellular_fx_bg;
PGraphics fx_bg_cellular(ivec2 canvas, boolean on_g, vec4 colour, int num, vec2 speed, float quality) {
	if(!on_g && (pg_cellular_fx_bg == null
								|| (canvas.x != pg_cellular_fx_bg.width 
								&& canvas.y != pg_cellular_fx_bg.height))) {
		pg_cellular_fx_bg = createGraphics(canvas.x,canvas.y,get_renderer());
	}
  // setting
	if(fx_bg_cellular == null) {
		String path = get_fx_bg_path()+"cellular.glsl";
		if(fx_bg_rope_path_exists) {
			fx_bg_cellular = loadShader(path);
			println("load shader: cellular.glsl");
		}	
	} else {
		set_shader_resolution(fx_bg_cellular,canvas,on_g);

		fx_bg_cellular.set("time",frameCount *.1); 


    // external paramter
		fx_bg_cellular.set("rgba",colour.x,colour.y,colour.z,colour.w); // value from 0 to 1
		fx_bg_cellular.set("num",num); // value from 0 to 1
		fx_bg_cellular.set("speed",speed.x,speed.y); // value from 0 to 1
		fx_bg_cellular.set("quality",quality); // value from 0 to 1

		if(on_g) {
			filter(fx_bg_cellular);
		} else {
			pg_cellular_fx_bg.shader(fx_bg_cellular);
		}
	}

	if(on_g) {
		return null;
	} else {
		return pg_cellular_fx_bg; 
	}
}








/**
* Heart fx backgournd by Stan le punk
* this template can be used for texture or direct filtering
* v 0.0.1
* 2019-2019
*/
// setting by class FX
PGraphics fx_bg_heart(FX fx) {
	return fx_bg_heart(fx.get_canvas(),fx.on_g(),vec3(fx.get_colour()),fx.get_num(),fx.get_speed().x,fx.get_quality(),fx.get_strength().x);
}




// main
PShader fx_bg_heart;
PGraphics pg_heart_fx_bg;
PGraphics fx_bg_heart(ivec2 canvas, boolean on_g, vec3 colour, int num, float speed, float quality, float strength) {
	if(!on_g && (pg_heart_fx_bg == null
								|| (canvas.x != pg_heart_fx_bg.width 
								&& canvas.y != pg_heart_fx_bg.height))) {
		pg_heart_fx_bg = createGraphics(canvas.x,canvas.y,get_renderer());
	}
  // setting
	if(fx_bg_heart == null) {
		String path = get_fx_bg_path()+"heart.glsl";
		if(fx_bg_rope_path_exists) {
			fx_bg_heart = loadShader(path);
			println("load shader: heart.glsl");
		}
	} else {
		set_shader_resolution(fx_bg_heart,canvas,on_g);

		fx_bg_heart.set("time",frameCount *.1); 


    // external paramter
		fx_bg_heart.set("rgb",colour.x,colour.y,colour.z); // value from 0 to 1
		fx_bg_heart.set("num",num); // value from 0 to 1
		fx_bg_heart.set("speed",speed); // value from 0 to 1
		fx_bg_heart.set("quality",quality); // value from 0 to 1

		fx_bg_heart.set("strength",strength); // value from 1 to ++
		if(on_g) {
			filter(fx_bg_heart);
		} else {
			pg_heart_fx_bg.shader(fx_bg_heart);
		}
	}

	if(on_g) {
		return null;
	} else {
		return pg_heart_fx_bg; 
	}
}








/**
* Necklace fx backgournd by Stan le punk
* this template can be used for texture or direct filtering
* v 0.0.1
* 2019-2019
*/
// setting by class FX
PGraphics fx_bg_necklace(FX fx) {
	return fx_bg_necklace(fx.get_canvas(),fx.on_g(),vec2(fx.get_pos()),vec2(fx.get_size()),fx.get_colour().x,fx.get_num(),fx.get_speed().x);
}




// main
PShader fx_bg_necklace;
PGraphics pg_necklace_fx_bg;
PGraphics fx_bg_necklace(ivec2 canvas, boolean on_g, vec2 pos, vec2 size, float alpha, int num, float speed) {
	if(!on_g && (pg_necklace_fx_bg == null
								|| (canvas.x != pg_necklace_fx_bg.width 
								&& canvas.y != pg_necklace_fx_bg.height))) {
		pg_necklace_fx_bg = createGraphics(canvas.x,canvas.y,get_renderer());
	}
  // setting
	if(fx_bg_necklace == null) {
		String path = get_fx_bg_path()+"necklace.glsl";
		if(fx_bg_rope_path_exists) {
			fx_bg_necklace = loadShader(path);
			println("load shader: necklace.glsl");
		}
	} else {
		set_shader_resolution(fx_bg_necklace,canvas,on_g);


		fx_bg_necklace.set("time",frameCount); 
    // external paramter
    fx_bg_necklace.set("position",pos.x,pos.y); // value from 0 to 1
    fx_bg_necklace.set("size",size.x,size.y); // value from 0 to 1
		fx_bg_necklace.set("alpha",alpha); // value from 0 to 1
		fx_bg_necklace.set("num",num); // value from 1 to ++
		fx_bg_necklace.set("speed",speed); // value from 0 to 1

		if(on_g) {
			filter(fx_bg_necklace);
		} else {
			pg_necklace_fx_bg.shader(fx_bg_necklace);
		}
	}

	if(on_g) {
		return null;
	} else {
		return pg_necklace_fx_bg; 
	}
}







/**
* Neon fx backgournd by Stan le punk
* this template can be used for texture or direct filtering
* v 0.0.1
* 2019-2019
*/
// setting by class FX
PGraphics fx_bg_neon(FX fx) {
	return fx_bg_neon(fx.get_canvas(),fx.on_g(),vec2(fx.get_pos()),fx.get_speed().x);
}




// main
PShader fx_bg_neon;
PGraphics pg_neon_fx_bg;
PGraphics fx_bg_neon(ivec2 canvas, boolean on_g, vec2 pos, float speed) {
	if(!on_g && (pg_neon_fx_bg == null
								|| (canvas.x != pg_neon_fx_bg.width 
								&& canvas.y != pg_neon_fx_bg.height))) {
		pg_neon_fx_bg = createGraphics(canvas.x,canvas.y,get_renderer());
	}
  // setting
	if(fx_bg_neon == null) {
		String path = get_fx_bg_path()+"neon.glsl";
		if(fx_bg_rope_path_exists) {
			fx_bg_neon = loadShader(path);
			println("load shader: neon.glsl");
		}
	} else {
		set_shader_resolution(fx_bg_neon,canvas,on_g);


		fx_bg_neon.set("time",frameCount *speed); 
    // external paramter
    fx_bg_neon.set("position",pos.x,pos.y); // value from 0 to 1

		if(on_g) {
			filter(fx_bg_neon);
		} else {
			pg_neon_fx_bg.shader(fx_bg_neon);
		}
	}

	if(on_g) {
		return null;
	} else {
		return pg_neon_fx_bg; 
	}
}












/**
* PSY fx backgournd by Stan le punk
* this template can be used for texture or direct filtering
* v 0.0.1
* 2019-2019
*/
// setting by class FX
PGraphics fx_bg_psy(FX fx) {
	return fx_bg_psy(fx.get_canvas(),fx.on_g(),fx.get_num(),fx.get_speed().x);
}



// main
PShader fx_bg_psy;
PGraphics pg_psy_fx_bg;
PGraphics fx_bg_psy(ivec2 canvas, boolean on_g, int num, float speed) {
	if(!on_g && (pg_psy_fx_bg == null
								|| (canvas.x != pg_psy_fx_bg.width 
								&& canvas.y != pg_psy_fx_bg.height))) {
		pg_psy_fx_bg = createGraphics(canvas.x,canvas.y,get_renderer());
	}
  // setting
	if(fx_bg_psy == null) {
		String path = get_fx_bg_path()+"psy.glsl";
		if(fx_bg_rope_path_exists) {
			fx_bg_psy = loadShader(path);
			println("load shader: psy.glsl");
		}
	} else {
		set_shader_resolution(fx_bg_psy,canvas,on_g);


		fx_bg_psy.set("time",frameCount *speed); // speed value must be low from 0.0001 to 0.05 and it's very fast
    // external paramter
    fx_bg_psy.set("num",num); // 2 or 3

		if(on_g) {
			filter(fx_bg_psy);
		} else {
			pg_psy_fx_bg.shader(fx_bg_psy);
		}
	}

	if(on_g) {
		return null;
	} else {
		return pg_psy_fx_bg; 
	}
}






/**
* SNOW fx backgournd by Stan le punk
* this template can be used for texture or direct filtering
* v 0.0.1
* 2019-2019
*/
// setting by class FX
PGraphics fx_bg_snow(FX fx) {
	return fx_bg_snow(fx.get_canvas(),fx.on_g(),vec2(fx.get_pos()),vec3(fx.get_colour()),fx.get_speed().x,fx.get_quality());
}



// main
PShader fx_bg_snow;
PGraphics pg_snow_fx_bg;
PGraphics fx_bg_snow(ivec2 canvas, boolean on_g, vec2 pos, vec3 colour, float speed, float quality) {
	if(!on_g && (pg_snow_fx_bg == null
								|| (canvas.x != pg_snow_fx_bg.width 
								&& canvas.y != pg_snow_fx_bg.height))) {
		pg_snow_fx_bg = createGraphics(canvas.x,canvas.y,get_renderer());
	}
  // setting
	if(fx_bg_snow == null) {
		String path = get_fx_bg_path()+"snow.glsl";
		if(fx_bg_rope_path_exists) {
			fx_bg_snow = loadShader(path);
			println("load shader: snow.glsl");
		}
	} else {
		set_shader_resolution(fx_bg_snow,canvas,on_g);

    fx_bg_snow.set("rgb",colour.x,colour.y,colour.z); // speed value must be low from 0.0001 to 0.05 and it's very fast
		fx_bg_snow.set("time",frameCount *speed); // speed value must be low from 0.0001 to 0.05 and it's very fast

		fx_bg_snow.set("position",pos.x,pos.y); // speed value must be low from 0.0001 to 0.05 and it's very fast

		fx_bg_snow.set("quality",quality); // speed value must be low from 0.0001 to 0.05 and it's very fast
    // external paramter


		if(on_g) {
			filter(fx_bg_snow);
		} else {
			pg_snow_fx_bg.shader(fx_bg_snow);
		}
	}

	if(on_g) {
		return null;
	} else {
		return pg_snow_fx_bg; 
	}
}















/**
* VORONOI HEX
* refactoring
* oroginal shader see glsl file for the link
* v 0.0.1
* 2019-2019
*/
// setting by class FX
PGraphics fx_bg_voronoi_hex(FX fx) {
	return fx_bg_voronoi_hex(fx.get_canvas(),fx.on_g(),fx.get_size().x,vec3(fx.get_colour()),fx.get_speed().x,fx.get_speed().y,fx.get_strength().x,fx.get_threshold().x,fx.get_mode());
}


// main
PShader fx_bg_voronoi_hex;
PGraphics pg_voronoi_hex_fx_bg;
PGraphics fx_bg_voronoi_hex(ivec2 canvas, boolean on_g, float size, vec3 colour, float speed_mutation,float speed_colour, float strength, float threshold, int mode) {
	if(!on_g && (pg_voronoi_hex_fx_bg == null
								|| (canvas.x != pg_voronoi_hex_fx_bg.width 
								&& canvas.y != pg_voronoi_hex_fx_bg.height))) {
		pg_voronoi_hex_fx_bg = createGraphics(canvas.x,canvas.y,get_renderer());
	}
  // setting
	if(fx_bg_voronoi_hex == null) {
		String path = get_fx_bg_path()+"voronoi_hex.glsl";
		if(fx_bg_rope_path_exists) {
			fx_bg_voronoi_hex = loadShader(path);
			println("load shader: voronoi_hex.glsl");
		}
	} else {
		set_shader_resolution(fx_bg_voronoi_hex,canvas,on_g);
		// processing parameter
		fx_bg_voronoi_hex.set("time",float(frameCount)); 
    
    // external parameter
    fx_bg_voronoi_hex.set("rgb",colour.x,colour.y,colour.z); // from 0 to 1
    fx_bg_voronoi_hex.set("size",size); // from 1 to 10++
    fx_bg_voronoi_hex.set("speed_mutation",speed_mutation); // from 0 to 1
    fx_bg_voronoi_hex.set("speed_colour",speed_colour); // from 0 to 1
		fx_bg_voronoi_hex.set("strength",strength); // from -0.05 to 0.05
		fx_bg_voronoi_hex.set("threshold",threshold); // from 0.1 to 0.3
		fx_bg_voronoi_hex.set("mode",mode); // from 0 to 1

		if(on_g) {
			filter(fx_bg_voronoi_hex);
		} else {
			pg_voronoi_hex_fx_bg.shader(fx_bg_voronoi_hex);
		}
	}

	if(on_g) {
		return null;
	} else {
		return pg_voronoi_hex_fx_bg; 
	}
}







