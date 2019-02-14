/**
 * CLASS FX 
 * v 0.1.2
 * 2019-2019
 * class used to create easy setting for shader fx
*/
public class FX {
	private int id;
	private int type;
	private String name;
	private String author;
	private String pack;
	private String version;
	private int revision;
	private boolean on_g = true;
	// paameter
	private int mode; // 0
	private int num; // 1 
	private float quality; // 2

	private vec2 scale; // 10
	private vec2 resolution; // 11

	private vec3 strength; // 20
	private vec3 angle; // 21
	private vec3 threshold; // 22
	private vec3 pos; // 23
	private vec3 size; // 24
	private vec3 offset; // 25

	private vec4 level_source; // 30
	private vec4 level_layer; // 31
	private vec4 colour; // 32


	// modulair
	private vec3 [] matrix; // 40 > 42
	private vec2 [] pair; // 50 > 42
	private boolean [] event; // 10O-102


	public FX(String name, int type) {
	// public FX(int id, String name, int type) {
		// this.id = id;
		this.name = name;
		this.type = type;
	}
  // set
  public void set_on_g(boolean is) {
  	on_g = is;
  }

  public void set_type(int type) {
  	this.type = type;
  }

  public void set_id(int id) {
  	this.id = id;
  }

  public void set_name(String name) {
  	this.name = name;
  }

  public void set_author(String author) {
  	this.author = author;
  }

  public void set_pack(String pack) {
  	this.pack = pack;
  }

  public void set_version(String version) {
  	this.version = version;
  }

  public void set_revision(int revision) {
  	this.revision = revision;
  }

  public void set(int which, Object... arg) {
  	if(which == 0) {
  		set_mode((int)arg[0]);
  	} else if(which == 1) {
  		set_num((int)arg[0]);
  	} else if(which == 2) {
  		set_quality((float)arg[0]);
  	} 

  		else if(which == 10) {
  		set_scale(to_float_array(arg));
  	} else if(which == 11) {
  		set_resolution(to_float_array(arg));
  	}

  		else if(which == 20) {
  		set_strength(to_float_array(arg));
  	} else if(which == 21) {
  		set_angle(to_float_array(arg));
  	} else if(which == 22) {
  		set_threshold(to_float_array(arg));
  	} else if(which == 23) {
  		set_pos(to_float_array(arg));
  	} else if(which == 24) {
  		set_size(to_float_array(arg));
  	} else if(which == 25) {
  		set_offset(to_float_array(arg));
  	}

  		else if(which == 30) {
  		set_level_source(to_float_array(arg));
  	} else if(which == 31) {
  		set_level_layer(to_float_array(arg));
  	} else if(which == 32) {
  		set_colour(to_float_array(arg));
  	}

  		else if(which == 40) {
  		if(matrix == null || matrix.length < 1) matrix = new vec3[1];
  		set_matrix(0,to_float_array(arg));
  	} else if(which == 41) {
  		if(matrix == null || matrix.length < 2) matrix = new vec3[2];
  		set_matrix(1,to_float_array(arg));
  	} else if(which == 42) {
  		if(matrix == null || matrix.length < 3) matrix = new vec3[3];
  		set_matrix(2,to_float_array(arg));
  	}	

  	else if(which == 50) {
  		if(pair == null || pair.length < 1) pair = new vec2[1];
  		set_pair(0,to_float_array(arg));
  	} else if(which == 51) {
  		if(pair == null || pair.length < 2) pair = new vec2[2];
  		set_pair(1,to_float_array(arg));
  	} else if(which == 52) {
  		if(pair == null || pair.length < 3) pair = new vec2[3];
  		set_pair(2,to_float_array(arg));
  	}	

  		else if(which == 100) {
  		if(event == null || event.length < 1) event = new boolean[1];
  		set_event(0,(boolean)arg[0]);
  	} else if(which == 101) {
  		if(event == null || event.length < 2) event = new boolean[2];
  		set_event(1,(boolean)arg[0]);
  	} else if(which == 102) {
  		if(event == null || event.length < 3) event = new boolean[3];
  		set_event(2,(boolean)arg[0]);
  	}
  }

  private float[] to_float_array(Object... arg) {
  	float [] f = new float[arg.length];
  	for(int i = 0 ; i < arg.length ; i++) {
  		if(arg[i] instanceof Float) {
  			f[i] = (float)arg[i];
  		} else {
  			printErr("class FX method set(): arg",arg,"cannot be cast to float");
  			f[i] = 0;
  		}
  	}
  	return f;
  }


  private void set_mode(int mode) {
		this.mode = mode;
	}

	private void set_num(int num) {
		this.num = num;
	}

	private void set_quality(float quality) {
		this.quality = quality;
	}

	private void set_scale(float... arg) {
		if(this.scale == null) {
			this.scale = vec2(build_2(arg));
		} else {
			this.scale.set(build_2(arg));
		}
	}

	private void set_resolution(float... arg) {
		if(this.resolution == null) {
			this.resolution = vec2(build_2(arg));
		} else {
			this.resolution.set(build_2(arg));
		}
	}

	private void set_strength(float... arg) {
		if(this.strength == null) {
			this.strength = vec3(build_3(arg));
		} else {
			this.strength.set(build_3(arg));
		}
	}

	private void set_angle(float... arg) {
		if(this.angle == null) {
			this.angle = vec3(build_3(arg));
		} else {
			this.angle.set(build_3(arg));
		}
	}

	private void set_threshold(float... arg) {
		if(this.threshold == null) {
			this.threshold = vec3(build_3(arg));
		} else {
			this.threshold.set(build_3(arg));
		}
	}

	private void set_pos(float... arg) {
		if(this.pos == null) {
			this.pos = vec3(build_3(arg));
		} else {
			this.pos.set(build_3(arg));
		}
	}

	private void set_size(float... arg) {
		if(this.size == null) {
			this.size = vec3(build_3(arg));
		} else {
			this.size.set(build_3(arg));
		}
	}

	private void set_offset(float... arg) {
		if(this.offset == null) {
			this.offset = vec3(build_3(arg));
		} else {
			this.offset.set(build_3(arg));
		}
	}

	private void set_level_source(float... arg) {
		if(this.level_source == null) {
			this.level_source = vec4(build_4(arg));
		} else {
			this.level_source.set(build_4(arg));
		}
	}

	private void set_level_layer(float... arg) {
		if(this.level_layer == null) {
			this.level_layer = vec4(build_4(arg));
		} else {
			this.level_layer.set(build_4(arg));
		}
	}

	private void set_colour(float... arg) {
		if(this.colour == null) {
			this.colour = vec4(build_4(arg));
		} else {
			this.colour.set(build_4(arg));
		}
	}

	private void set_matrix(int which, float... arg) {
		if(this.matrix[which] == null) {
			this.matrix[which] = vec3(build_3(arg));
		} else {
			this.matrix[which].set(build_3(arg));
		}
	}

	private void set_pair(int which, float... arg) {
		if(this.pair[which] == null) {
			this.pair[which] = vec2(build_2(arg));
		} else {
			this.pair[which].set(build_2(arg));
		}
	}

	private void set_event(int which, boolean is) {
		this.event[which] = is;
	}



	// get
	public boolean on_g() {
		return on_g;
	}

	public String get_name() {
		return name;
	}

	public int get_id() {
		return id;
	}

	public String get_author() {
  	 return author;
  }

  public String get_pack() {
  	return pack;
  }

  public String get_version() {
  	return version;
  }

  public  int get_revision() {
  	return revision;
  }

	public int get_type() {
		return type;
	}

	public int get_mode() {
		return mode;
	}

	public int get_num() {
		return num;
	}

	public float get_quality() {
		return quality;
	}

	public vec2 get_scale() {
		if(scale == null) {
			scale = vec2(1);
			printErr("class FX method get_scale(): arg",null,"instead set arg and return",scale);
		} 
		return scale;	
	}

	public vec2 get_resolution() {
		if(resolution == null) {
			resolution = vec2(width,height);
			printErr("class FX method get_resolution(): arg",null,"instead set arg and return",resolution);
		} 
		return resolution;
	}

	public vec3 get_strength() {
		if(strength == null) {
			strength = vec3(0);
			printErr("class FX method get_strength(): arg",null,"instead set arg and return",strength);
		}
		return strength;
	}

	public vec3 get_angle() {
		if(angle == null) {
			angle = vec3(0);
			printErr("class FX method get_angle(): arg",null,"instead set arg and return",angle);
		}
		return angle;
	}

	public vec3 get_threshold() {
		if(threshold == null) {
			threshold = vec3(0);
			printErr("class FX method get_threshold(): arg",null,"instead set arg and return",threshold);
		}
		return threshold;
	}

	public vec3 get_pos() {
		if(pos == null) {
			pos = vec3(width/2,height/2,0);
			printErr("class FX method get_pos(): arg",null,"instead set arg and return",pos);
		}
		return pos;
	}

	public vec3 get_size() {
		if(size == null) {
			size = vec3(5);
			printErr("class FX method get_size(): arg",null,"instead set arg and return",size);
		}
		return size;
	}

	public vec3 get_offset() {
		if(offset == null) {
			offset = vec3(0);
			printErr("class FX method get_offset(): arg",null,"instead set arg and return",offset);
		}
		return offset;
	}

	public vec4 get_level_source() {
		if(level_source == null) {
			level_source = vec4(1);
			printErr("class FX method get_level_source(): arg",null,"instead set arg and return",level_source);
		}
		return level_source;
	}

	public vec4 get_level_layer() {
		if(level_layer == null) {
			level_layer = vec4(1);
			printErr("class FX method get_level_layer(): arg",null,"instead set arg and return",level_layer);
		}
		return level_layer;
	}

	public vec4 get_colour() {
		if(colour == null) {
			colour = vec4(1);
			printErr("class FX method get_colour(): arg",null,"instead set arg and return",colour);
		}
		return colour;
	}
  
  // matrix
	public vec3 get_matrix(int which) {
		if(matrix != null  && which < matrix.length && which >= 0) {
			if(matrix[which] == null) {
				matrix[which] = vec3(0);
				printErr("class FX method get_matrix(): arg",null,"instead set arg and return",matrix[which]);
			}
			return matrix[which];
		} else return null;
	}

	public vec3 [] get_matrix() {
		if(matrix != null) {
			return matrix;
		} else return null;
	}
  
  // pair
	public vec2 get_pair(int which) {
		if(pair != null && which < pair.length && which >= 0) {
			if(pair[which] == null) {
				pair[which] = vec2(0);
				printErr("class FX method get_pair(): arg",null,"instead set arg and return",pair[which]);
			}
			return pair[which];
		} else return null;
	}

	public vec2 [] get_pair() {
		if(pair != null) {
			return pair;
		} else return null;
	}
  
  // event
  public boolean get_event(int which) {
		if(event != null && which < event.length  && which >= 0) {
			return event[which];
		} else {
			printErr("class FX method get_event(",which,") is out of the list available");
			return false;
		}
	}

	public boolean [] get_event() {
		if(event != null) {
			return event;
		} else return null;
	}

	// util
	private vec4 build_4(float... arg) {
		if(arg.length == 1 ) {
			return vec4(arg[0],arg[0],arg[0],g.colorModeA);
		} else if(arg.length == 2) {
			return vec4(arg[0],arg[0],arg[0],arg[1]);
		} else if(arg.length == 3) {
			return vec4(arg[0],arg[1],arg[2],g.colorModeA);
		} else if(arg.length == 4) {
			return vec4(arg[0],arg[1],arg[2],arg[3]);
		} else {
			return vec4(g.colorModeX,g.colorModeY,g.colorModeZ,g.colorModeA);
		}
	}

	private vec3 build_3(float... arg) {
		if(arg.length == 1 ) {
			return vec3(arg[0],arg[0],arg[0]);
		} else if(arg.length == 2) {
			return vec3(arg[0],arg[1],0);
		} else if(arg.length == 3) {
			return vec3(arg[0],arg[1],arg[2]);
		} else {
			return vec3(0);
		}
	}

	private vec2 build_2(float... arg) {
		if(arg.length == 1 ) {
			return vec2(arg[0],arg[0]);
		} else if(arg.length == 2) {
			return vec2(arg[0],arg[1]);
		}  else {
			return vec2(0);
		}
	}
}