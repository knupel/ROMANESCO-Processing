/**
Rope Costume
* Copyleft (c) 2014-2018
v 1.4.3
* @author Stan le Punk
* @see https://github.com/StanLepunK/Costume_rope
*/
final int POINT_ROPE = 1;
final int ELLIPSE_ROPE = 2;
final int RECT_ROPE = 3;
final int LINE_ROPE = 4;

final int TRIANGLE_ROPE = 13;
final int SQUARE_ROPE = 14;
final int PENTAGON_ROPE = 15;
final int HEXAGON_ROPE = 16;
final int HEPTAGON_ROPE = 17;
final int OCTOGON_ROPE = 18;
final int NONAGON_ROPE = 19;
final int DECAGON_ROPE = 20;
final int HENDECAGON_ROPE = 21;
final int DODECAGON_ROPE = 22;

final int TEXT_ROPE = 26;

final int CROSS_RECT_ROPE = 52;
final int CROSS_BOX_2_ROPE = 53;
final int CROSS_BOX_3_ROPE = 54;

final int SPHERE_LOW_ROPE = 100;
final int SPHERE_MEDIUM_ROPE = 101;
final int SPHERE_HIGH_ROPE = 102;
final int TETRAHEDRON_ROPE = 103;
final int BOX_ROPE = 104;

final int PIXEL_ROPE = 800;

final int STAR_ROPE = 805;
final int STAR_3D_ROPE = 806;

final int TETRAHEDRON_LINE_ROPE = 1001;
final int CUBE_LINE_ROPE = 1002;
final int OCTOHEDRON_LINE_ROPE = 1003;
final int RHOMBIC_COSI_DODECAHEDRON_SMALL_LINE_ROPE = 1004;
final int ICOSI_DODECAHEDRON_LINE_ROPE = 1005;

final int VIRUS_ROPE = 88_888_888;




Info_int_dict costume_dict = new Info_int_dict();
boolean list_costume_is_built = false ;
int ref_size_pic = -1 ;

String costume_text_rope = null;
boolean fill_rope_is = true;
boolean stroke_rope_is = true;

float fill_rope = 0;
float stroke_rope = 0;
float thickness_rope = 1.;

void costume_list() {
	if(!list_costume_is_built) {
		/* 
		* add(name, code, renderer, type)
		* code: int constante to access directly
		* render: 2 = 2D ; 3 = 3D ;
		* type : 0 = shape ; 1 = bitmap ; 2 = svg  ; 3 = shape with just stroke component ; 4 = text
		*/
		costume_dict.add("NULL",r.NULL,0,0);

		costume_dict.add("PIXEL_ROPE",PIXEL_ROPE,2,1);

		costume_dict.add("POINT_ROPE",POINT_ROPE,2,0);
		costume_dict.add("ELLIPSE_ROPE",ELLIPSE_ROPE,2,0);
		costume_dict.add("RECT_ROPE",RECT_ROPE,2,0);
		costume_dict.add("LINE_ROPE",LINE_ROPE,2,0);

		costume_dict.add("TRIANGLE_ROPE",TRIANGLE_ROPE,2,0);
		costume_dict.add("SQUARE_ROPE",SQUARE_ROPE,2,0);
		costume_dict.add("PENTAGON_ROPE",PENTAGON_ROPE,2,0);
		costume_dict.add("HEXAGON_ROPE",HEXAGON_ROPE,2,0);
		costume_dict.add("HEPTAGON_ROPE",HEPTAGON_ROPE,2,0);
		costume_dict.add("OCTOGON_ROPE",OCTOGON_ROPE,2,0);
		costume_dict.add("NONAGON_ROPE",NONAGON_ROPE,2,0);
		costume_dict.add("DECAGON_ROPE",DECAGON_ROPE,2,0);
		costume_dict.add("HENDECAGON_ROPE",HENDECAGON_ROPE,2,0);
		costume_dict.add("DODECAGON_ROPE",DODECAGON_ROPE,2,0);

		costume_dict.add("TEXT_ROPE",TEXT_ROPE,2,4);
    
    costume_dict.add("CROSS_RECT_ROPE",CROSS_RECT_ROPE,2,0);
		costume_dict.add("CROSS_BOX_2_ROPE",CROSS_BOX_2_ROPE,3,0);
		costume_dict.add("CROSS_BOX_3_ROPE",CROSS_BOX_3_ROPE,3,0);

		costume_dict.add("SPHERE_LOW_ROPE",SPHERE_LOW_ROPE,3,0);
		costume_dict.add("SPHERE_MEDIUM_ROPE",SPHERE_MEDIUM_ROPE,3,0);
		costume_dict.add("SPHERE_HIGH_ROPE",SPHERE_HIGH_ROPE,3,0);
		costume_dict.add("TETRAHEDRON_ROPE",TETRAHEDRON_ROPE,3,0);
		costume_dict.add("BOX_ROPE",BOX_ROPE,3,0);

		costume_dict.add("SPHERE_LOW_ROPE",SPHERE_LOW_ROPE,3,0);
		costume_dict.add("SPHERE_MEDIUM_ROPE",SPHERE_MEDIUM_ROPE,3,0);
		costume_dict.add("SPHERE_HIGH_ROPE",SPHERE_HIGH_ROPE,3,0);
		costume_dict.add("TETRAHEDRON_ROPE",TETRAHEDRON_ROPE,3,0);
		costume_dict.add("BOX_ROPE",BOX_ROPE,3,0);

		costume_dict.add("STAR_ROPE",STAR_ROPE,2,3);
		costume_dict.add("STAR_3D_ROPE",STAR_3D_ROPE,2,3);

		costume_dict.add("VIRUS_ROPE",VIRUS_ROPE,3,0);

		list_costume_is_built = true ;
	}

  // add costume from your SVG or PNG
	if(ref_size_pic != costume_pic_list.size()) {
		for(Costume_pic c : costume_pic_list) {
			costume_dict.add(c.name, c.ID, 3, c.type) ;
		}
		ref_size_pic = costume_pic_list.size() ;
	}
}


// print list costume
void print_list_costume() {
	if(!list_costume_is_built) {
		costume_list() ;
	}
  println("Costume have " + costume_dict.size() + " costumes.") ;
	if(list_costume_is_built) {
		for(int i = 0 ; i < costume_dict.size() ; i++) {
			String type = "" ;
			if(costume_dict.get(i).get(2) == 0 ) type = "shape" ;
			else if(costume_dict.get(i).get(2) == 1 ) type = "bitmap" ;
			else if(costume_dict.get(i).get(2) == 2 ) type = "scalable vector graphics" ;
			else if(costume_dict.get(i).get(2) == 3 ) type = "shape with no fill component" ;
			println("[ Rank:", i, "][ ID:",costume_dict.get(i).get(0), "][ Name:", costume_dict.get(i).get_name(), "][ Renderer:", costume_dict.get(i).get(1)+"D ][ Picture:", type, "]") ;
		}
	}
}


// get costume
int get_costume(int target) {
	costume_list() ;
	if(target >= 0 && target < costume_dict.size()) {
		return costume_dict.get(target).get(0) ;
	} else {
		System.err.println("Your target is out from the list") ;
		return 0 ;
	}
}


// return size of the arrayList costume
int costumes_size() {
	costume_list() ;
	return costume_dict.size() ;
}






















/**
ASPECT ROPE 2016-2018
v 0.1.3
*/
void aspect_is(boolean fill_is, boolean stroke_is) {
	fill_rope_is = fill_is ;
	stroke_rope_is = stroke_is ;
}

void init_bool_aspect() {
	fill_rope_is = true ;
  stroke_rope_is = true ;
}

void aspect_rope(int fill, int stroke, float thickness) {
  //checkfill color
  if(alpha(fill) <= 0 || !fill_rope_is)  {
    noFill(); 
  } else {
  	manage_fill(fill);
  } 
  //check stroke color
  if(alpha(stroke) <=0 || thickness <= 0 || !stroke_rope_is) {
    noStroke();
  } else {
  	manage_stroke(stroke);
    manage_thickness(thickness);
  }
  //
  init_bool_aspect();
}

void aspect_rope(int fill, int stroke, float thickness, Costume costume) {
	aspect_rope(fill,stroke,thickness,costume.get_type());
}

void aspect_rope(int fill, int stroke, float thickness, int costume) {
	if(costume == r.NULL) {
    // 
	} else if(costume != r.NULL || costume != POINT_ROPE || costume != POINT) {
    if(alpha(fill) <= 0 || !fill_rope_is) {
    	noFill(); 
    } else {
    	manage_fill(fill);
    }

    if(alpha(stroke) <= 0  || thickness <= 0 || !stroke_rope_is) {
    	noStroke(); 
    } else {
    	manage_stroke(stroke);
      manage_thickness(thickness);
    }   
  } else {
    if(alpha(fill) == 0) {
    	noStroke(); 
    } else {
    	// case where the fill is use like a stroke, for point, pixel...
    	manage_stroke(fill);
    	manage_thickness(thickness);
    }
    noFill();   
  }
  //
  init_bool_aspect();
}



void aspect_rope(Vec fill, Vec stroke, float thickness) {
  //checkfill color
  if(fill.w <=0 || !fill_rope_is)  {
    noFill() ; 
  } else {
    manage_fill(fill);
  } 
  //check stroke color
  if(stroke.w <=0 || thickness <= 0 || !stroke_rope_is) {
    noStroke();
  } else {
    manage_stroke(stroke);
    manage_thickness(thickness);
  }
  //
  init_bool_aspect();
}

void aspect_rope(Vec fill, Vec stroke, float thickness, Costume costume) {
	aspect_rope(fill,stroke,thickness,costume.get_type());
}


void aspect_rope(Vec fill, Vec stroke, float thickness, int costume) {
  if(costume == r.NULL) {
    // 
	} else if(costume != r.NULL || costume != POINT_ROPE || costume != POINT) {
    if(fill.w <= 0 || !fill_rope_is) {
    	noFill() ; 
    } else {
    	manage_fill(fill);
    } 
    if(stroke.w <= 0  || thickness <= 0 || !stroke_rope_is) {
    	noStroke(); 
    } else {
    	manage_stroke(stroke);
    	manage_thickness(thickness);
    }   
  } else {
    if(fill.w <= 0 || !fill_rope_is) {
    	noStroke(); 
    } else {
    	// case where the fill is use like a stroke, for point, pixel...
    	manage_stroke(fill); 
    	manage_thickness(thickness);
    }
    noFill();   
  }
  //
  init_bool_aspect();
}


/**
v 0.0.1
* component manger
*/
void manage_fill(Object arg) {
	if(arg instanceof Vec2) {
		Vec2 c = (Vec2)arg;
		fill_rope = color(c.x,c.x,c.x,c.y);
		fill(c) ;
	} else if(arg instanceof Vec3) {
		Vec3 c = (Vec3)arg;
		fill_rope = color(c.x,c.y,c.z,g.colorModeA);
		fill(c) ;
	} else if(arg instanceof Vec4) {
		Vec4 c = (Vec4)arg;
		fill_rope = color(c.x,c.y,c.z,c.w);
		fill(c);
	} else if(arg instanceof Integer) {
		int c = (int)arg;
		fill_rope = c;
		fill(c);
	}
}

void manage_stroke(Object arg) {
	if(arg instanceof Vec2) {
		Vec2 c = (Vec2)arg;
		stroke_rope = color(c.x,c.x,c.x,c.y);
		stroke(c);
	} else if(arg instanceof Vec3) {
		Vec3 c = (Vec3)arg;
		stroke_rope = color(c.x,c.y,c.z,g.colorModeA);
		stroke(c);
	} else if(arg instanceof Vec4) {
		Vec4 c = (Vec4)arg;
		stroke_rope = color(c.x,c.y,c.z,c.w);
		stroke(c);
	} else if(arg instanceof Integer) {
		int c = (int)arg;
		stroke_rope = c;
		stroke(c);
	}
}


void manage_thickness(float thickness) {
	thickness_rope = thickness;
	strokeWeight(thickness);

}


float get_fill_rope() {
	return fill_rope;
}

float get_stroke_rope() {
	return stroke_rope;
}

float get_thickness_rope() {
	return thickness_rope;
}













































/**
COSTUME
v 0.0.1
*/


/**
simple text 
v 0.0.1
*/
void costume_text(String s) {
	costume_text_rope = s ;
}


/**
rotate behavior
v 0.1.0
*/
boolean costume_rot_x;
boolean costume_rot_y;
boolean costume_rot_z;

void costume_rotate_x() {
	costume_rot_x = true;
}

void costume_rotate_y() {
	costume_rot_y = true;
}

void costume_rotate_z() {
	costume_rot_z = true;
}

void rotate_behavior(Vec rotate) {
	if(costume_rot_x && rotate.x != 0) {
		rotateX(rotate.x);
		costume_rot_x = false;
	}
	if(costume_rot_y && rotate.y != 0) {
		rotateY(rotate.y);
		costume_rot_y = false;
	}
	if(costume_rot_z && rotate.z != 0) {
		rotateZ(rotate.z);
		costume_rot_z = false;
	}
}


/**
ratio size costume
*/
float ratio_costume_size = 1;
void set_ratio_costume_size(float ratio) {
	ratio_costume_size = ratio;
}




























/**
add pic 
v 0.0.1
*/
ArrayList <Costume_pic> costume_pic_list = new ArrayList<Costume_pic>() ;

void load_costume_pic(String path) {
	if(path.endsWith("png") || path.endsWith("PNG") || path.endsWith("svg") || path.endsWith("SVG")) {
		int new_ID = costume_pic_list.size() * (-1) ;
		new_ID -= 1 ;
		Costume_pic c = new Costume_pic(this, path, new_ID) ;
		costume_pic_list.add(c) ; ;
		println("ID pic:", new_ID) ;
	}
}



class Costume_pic {
	PImage img ;
	ROPE_svg svg ;
	int type = -1 ; 

	String name ;
	int ID ;
	Costume_pic(PApplet p5, String path, int ID) {
		// add png
		if(path.endsWith("png") || path.endsWith("PNG")) {
			img = loadImage(path) ;
			type = 1 ;
		}

		// add svg
		if(path.endsWith("svg") || path.endsWith("SVG")) {
			svg = new ROPE_svg(p5, path) ;
						svg.mode(CENTER) ;
			svg.build() ;
			type = 2 ;
		}
		
		String [] split = path.split("/") ;
		name = split[split.length -1] ;
		name = name.substring(0, name.lastIndexOf(".")) ;
		this.ID = ID ;
	}
}












/**
DISPLAY
*/

/**
Costume selection in shape catalogue
*/
void costume(Vec pos, int size_int, Object data) {
	int which_costume = 0;
	String sentence = null;
	if(data instanceof Costume) {
		which_costume = ((Costume)data).get_type();
	} else if(data instanceof Integer) {
		which_costume = (int)data;
	} else if(data instanceof String) {
		sentence = (String)data;
		which_costume = MAX_INT;
	}

	// int which_costume = cast_data(costume_obj);
	Vec3 rotation = Vec3();
	Vec3 size = Vec3(size_int);
	if(sentence == null) {
		costume(pos, size, rotation, which_costume,null);
	} else {
		costume(pos,size,rotation,which_costume,sentence);
	}
}

void costume(Vec pos, Vec size, Object data) {
	int which_costume = 0;
	String sentence = null;
	if(data instanceof Costume) {
		which_costume = ((Costume)data).get_type();
	} else if(data instanceof Integer) {
		which_costume = (int)data;
	} else if(data instanceof String) {
		sentence = (String)data;
		which_costume = MAX_INT;
	}

	Vec3 rotation = Vec3() ;
	if(sentence == null) {
		costume(pos,size,rotation,which_costume,null);
	} else {
		costume(pos,size,rotation,which_costume,sentence);
	}
	// costume(pos, size, rotation, which_costume,null);
}

void costume(Vec pos, Vec size, float rotation, Object data) {
	int which_costume = 0;
	String sentence = null;
	if(data instanceof Costume) {
		which_costume = ((Costume)data).get_type();
	} else if(data instanceof Integer) {
		which_costume = (int)data;
	} else if(data instanceof String) {
		sentence = (String)data;
		which_costume = MAX_INT;
	}

	if(sentence == null) {
		costume(pos, size, Vec3(0,0,rotation),which_costume,null);
	} else {
		costume(pos,size,Vec3(0,0,rotation),which_costume,sentence);
	}
}


void costume(Vec pos, Vec size, Vec rotation, Object data) {
	int which_costume = 0;
	String sentence = null;
	if(data instanceof Costume) {
		which_costume = ((Costume)data).get_type();
	} else if(data instanceof Integer) {
		which_costume = (int)data;
	} else if(data instanceof String) {
		sentence = (String)data;
		which_costume = MAX_INT;
	}

	if(sentence == null) {
		costume(pos,size,rotation,which_costume);
	} else {
		costume(pos,size,rotation,which_costume,sentence);
	}
}





















/**
managing costume rope method
*/
void costume(Vec pos, Vec size, Vec rotation, int which_costume, String sentence) {
  Vec3 pos_final = Vec3(0) ;
  Vec3 size_final = Vec3(1) ;
	if((pos instanceof Vec2 || pos instanceof Vec3) 
			&& (size instanceof Vec2 || size instanceof Vec3)
			&& (rotation instanceof Vec2 || rotation instanceof Vec3)) {
		// pos
		if(pos instanceof Vec2) {
			Vec2 temp_pos = (Vec2)pos;
			pos_final.set(temp_pos.x, temp_pos.y, 0);
		} else if(pos instanceof Vec3) {
			Vec3 temp_pos = (Vec3)pos;
			pos_final.set(temp_pos);
		}
		//size
		if(size instanceof Vec2) {
			Vec2 temp_size = (Vec2)size;
			size_final.set(temp_size.x, temp_size.y, 1);
		} else if(size instanceof Vec3) {
			Vec3 temp_size = (Vec3)size;
			size_final.set(temp_size);
		}
		//send
		if(sentence == null ) {
			costume(pos_final, size_final, rotation, which_costume);
		} else {
			costume(pos_final, size_final, rotation, sentence);
		}		
	} else {
		printErrTempo(180,"Vec pos or Vec size if not an instanceof Vec2 or Vec3, it's not possible to process costume_rope()");
	}
}
















/**
MAIN METHOD 
String COSTUME
v 0.1.0
Change the method for method with 
case and which_costume
and 
break
*/
void costume(Vec3 pos, Vec3 size, Vec rot, String sentence) {
	if(rot.x != 0) costume_rotate_x();
	if(rot.y != 0) costume_rotate_y();
	if(rot.z != 0) costume_rotate_z();

	start_matrix();
	translate(pos);
	rotate_behavior(rot);
  text(sentence,0,0);
	stop_matrix();
}






/**
method to pass costume to class costume
*/
void costume(Vec3 pos, Vec3 size, Vec rot, int which_costume) {
	Costume costume = new Costume(which_costume);
	costume.draw(pos,size,rot);
}

void costume(Vec3 pos, Vec3 size, Vec rot, Costume costume) {
	//Costume costume = new Costume(which_costume);
	costume.draw(pos,size,rot);
}



/**
class Costume 
2018-2018
v 0.0.3
*/
class Costume {
	int type;
	int node;
	int summits;
	int num;
	int mutation;
  float angle;
	float [] ratio;
	boolean is_3D = false;
	boolean is_vertex = true;
	Costume() {
	}

	Costume(int type) {
		this.type = type;
	}
  
  // set
  public void set_type(int type) {
		this.type = type;
	}

	public void set_node(int node) {
		this.node = node;
	}

	public void set_mutation(int mutation) {
		this.mutation = mutation;
	}

	public void set_summit(int summits) {
		this.summits = summits;
	}

	public void set_num(int num) {
		this.num = num;
	}

	public void set_angle(float angle) {
		this.angle = angle;
	}

	public void set_ratio(float... ratio) {
		this.ratio = ratio;
	}

	public void is_3D(boolean is_3D) {
		this.is_3D = is_3D;
	}

	public void is_vertex(boolean is_vertex) {
		this.is_vertex = is_vertex;
	}



	// get
	public int get_type() {
		return type;
	}

	public int get_node() {
		return node;
	}

	public int get_mutation() {
		return mutation;
	}

	public int get_summit() {
		return summits;
	}

	public int get_num() {
		return num;
	}

	public float get_angle() {
		return angle;
	}

	public float[] get_ratio() {
		return ratio;
	}

	public boolean is_3D() {
		return is_3D;
	}

	public boolean is_vertex() {
		return is_vertex;
	}

	void draw(Vec3 pos, Vec3 size, Vec rot) {
		if(rot.x != 0) costume_rotate_x();
		if(rot.y != 0) costume_rotate_y();
		if(rot.z != 0) costume_rotate_z();

		if (this.get_type() == PIXEL_ROPE) {
			set((int)pos.x,(int)pos.y,(int)get_fill_rope());
		} else if (this.get_type() == POINT_ROPE) {
	    strokeWeight(size.x);
			point(pos);
		} else if (this.get_type() == ELLIPSE_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			ellipse(Vec2(),size);
			stop_matrix();

		} else if (this.get_type() == RECT_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			rect(Vec2(-size.x,-size.y).div(2),Vec2(size.x,size.y));
			stop_matrix();

		} else if (this.get_type() == LINE_ROPE) {
			primitive(pos,size.x,2,rot.x);
		}



			else if (this.get_type() == TRIANGLE_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			primitive(Vec3(0),size.x,3);
			stop_matrix();
		}  else if (this.get_type() == SQUARE_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			primitive(Vec3(0),size.x,4);
			stop_matrix();
		} else if (this.get_type() == PENTAGON_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			primitive(Vec3(0),size.x,5);
			stop_matrix();
		} else if (this.get_type() == HEXAGON_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			primitive(Vec3(0),size.x,6);
			stop_matrix() ;
		} else if (this.get_type() == HEPTAGON_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			primitive(Vec3(0),size.x,7);
			stop_matrix();
		} else if (this.get_type() == OCTOGON_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot) ;
			primitive(Vec3(0),size.x,8);
			stop_matrix();
		} else if (this.get_type() == NONAGON_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot) ;
			primitive(Vec3(0),size.x,9);
			stop_matrix();
		} else if (this.get_type() == DECAGON_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot) ;
			primitive(Vec3(0),size.x,10);
			stop_matrix();
		} else if (this.get_type() == HENDECAGON_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot) ;
			primitive(Vec3(0),size.x,11);
			stop_matrix();
		} else if (this.get_type() == DODECAGON_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot) ;
			primitive(Vec3(0),size.x,12);
			stop_matrix();
		}

		else if (this.get_type() == CROSS_RECT_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			cross_rect(iVec2(0),(int)size.y,(int)size.x);
			stop_matrix() ;
		} else if (this.get_type() == CROSS_BOX_2_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			//cross_box_2(Vec2(size.x, size.y),ratio_size);
			cross_box_2(Vec2(size.x, size.y));
			stop_matrix() ;
		} else if (this.get_type() == CROSS_BOX_3_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			//cross_box_3(size,ratio_size);
			cross_box_3(size);
			stop_matrix();
		}



	  else if(this.get_type() == TEXT_ROPE) {
	  	start_matrix();
	  	translate(pos);
	  	rotate_behavior(rot);
	  	textSize(size.x);
	  	if(costume_text_rope != null) {
	  		text(costume_text_rope,0,0);
	  	} else {
	  		costume_text_rope = "ROPE";
	  		text(costume_text_rope,0,0);
	  	}
	  	stop_matrix();
	  }

		else if (this.get_type() == SPHERE_LOW_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			sphereDetail(5);
			sphere(size.x);
			stop_matrix();
		} else if (this.get_type() == SPHERE_MEDIUM_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			sphereDetail(12);
			sphere(size.x);
			stop_matrix();
		} else if (this.get_type() == SPHERE_HIGH_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			sphere(size.x);
			stop_matrix();
		} else if (this.get_type() == TETRAHEDRON_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			tetrahedron((int)size.x);
			stop_matrix();
		} else if (this.get_type() == BOX_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			box(size);
			stop_matrix();
		}


		else if (this.get_type() == STAR_ROPE) {
			float [] ratio = {.38};
			start_matrix();
			translate(pos);
			rotate_behavior(rot);

			star_3D_is(false);
			star(Vec3(),size);
			stop_matrix();
		} else if (this.get_type() == STAR_3D_ROPE) {
			float [] ratio = {.38};
			start_matrix();
			translate(pos);
			rotate_behavior(rot);

			star_3D_is(true);
			star(Vec3(),size);
			stop_matrix();
		} 


		else if (this.get_type() == TETRAHEDRON_LINE_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			polyhedron("TETRAHEDRON","LINE",(int)size.x);
			stop_matrix();
		} else if (this.get_type() == CUBE_LINE_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			polyhedron("CUBE","LINE",(int)size.x);
			stop_matrix();
		} else if (this.get_type() == OCTOHEDRON_LINE_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			polyhedron("OCTOHEDRON","LINE",(int)size.x);
			stop_matrix();
		} else if (this.get_type() == RHOMBIC_COSI_DODECAHEDRON_SMALL_LINE_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			polyhedron("RHOMBIC COSI DODECAHEDRON SMALL","LINE",(int)size.x);
			stop_matrix();
		} else if (this.get_type() == ICOSI_DODECAHEDRON_LINE_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			polyhedron("ICOSI DODECAHEDRON","LINE",(int)size.x);
			stop_matrix();
		}


	  else if(this.get_type() == VIRUS_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			virus(Vec3(),size,0,-1);
			stop_matrix();
		}



		else if(this.get_type() < 0) {
			start_matrix() ;
			translate(pos) ;
			rotate_behavior(rot) ;
			for(int i = 0 ; i < costume_pic_list.size() ; i++) {
				Costume_pic p = costume_pic_list.get(i);
				if(p.ID == this.get_type()) {
					if(p.type == 1) {
						PImage img_temp = p.img.copy();
						if(size.x == size.y ) {
							img_temp.resize((int)size.x, 0);
						} else if (size.x != size.y) {
							img_temp.resize((int)size.x, (int)size.y);
						}
						image(img_temp,0,0);
						break ;
					} else if(p.type == 2) {
						Vec2 scale = Vec2(1) ;
						if(size.x == size.y) {
	            scale = Vec2(size.x / p.svg.width(), size.x / p.svg.width());
						} else {
							scale = Vec2(size.x / p.svg.width(), size.y / p.svg.height());
						}
						
						p.svg.scaling(scale) ;
						p.svg.draw() ;
						break ;
					}		
				}
			}
			stop_matrix() ;
		}

	  // reset variable can be change the other costume, if the effect is don't use.
		ratio_costume_size = 1;
	}
}









/**
ANNEXE COSTUME
SHAPE CATALOGUE
*/
/**
STAR
*/
Star star_costume_rope;
void star_3D_is(boolean is_3D) {
	if(star_costume_rope != null) {
		star_costume_rope.is_3D(is_3D);
	} else {
		star_costume_rope = new Star();
	}
}


void set_costume_star_summits(int summits) {
	if(star_costume_rope != null) {
		star_costume_rope.set_summits(summits);
	} else {
		star_costume_rope = new Star();
	}
}

void set_costume_star_angle(float angle) {
	if(star_costume_rope != null) {
		star_costume_rope.set_angle(angle);
	} else {
		star_costume_rope = new Star();
	}
}

void set_costume_star_ratio(float... ratio) {
	if(star_costume_rope != null) {
		star_costume_rope.set_ratio(ratio);
	} else {
		star_costume_rope = new Star();
	}
}


void star(Vec position, Vec size) {
	if(star_costume_rope != null) {
		star_costume_rope.show(position,size);
	} else {
		star_costume_rope = new Star();
	}
}



public class Star {
	boolean is_3D = false;
	Vec3 pos;
	Vec3 size;
	int summits;
	float angle;
	float [] ratio;

	public Star() {
		pos = Vec3();
		size = Vec3(1);
		summits = 5;
		ratio = new float[1]; 
		ratio[0] = .38;
		angle = 0;
	}

	public void is_3D(boolean is_3D) {
		this.is_3D = is_3D;
	}

	public void set_summits(int summits) {
		if(summits > 3) this.summits = summits;
	}

	public void set_angle(float angle) {
		this.angle = angle;
	}

	public void set_ratio(float... ratio) {
		this.ratio = ratio;
	}

	public void show(Vec position, Vec size_raw) {
		if(position instanceof Vec2) {
			Vec2 p = (Vec2) position;
			pos.set(p.x,p.y,0);
		} else if(position instanceof Vec3) {
			Vec3 p = (Vec3)position;
			pos.set(p);
		}

		if(size_raw instanceof Vec2) {
			Vec2 s = (Vec2)size_raw;
			size.set(s.x,s.y,1);
		} else if(size_raw instanceof Vec3) {
			Vec3 s = (Vec3)size_raw;
			size.set(s.x,s.y,s.z);
		}

		if(pos.z != 0) {
			start_matrix();
			translate(0,0,pos.z);
		}

		Vec3 [] p = polygon_2D(summits*2,angle);
    
    if(is_3D) {
    	star_3D(pos,size,p,ratio);
    } else {
    	star_2D(pos,size,p,ratio);
    }
		


		if(pos.z != 0) {
			stop_matrix();
		}
	}

	private void star_3D(Vec3 pos, Vec3 size, Vec3 [] p, float[] ratio) {
		int count_ratio = 0;
		for(int i = 0 ; i < p.length ; i++) {
			// make a star, change the interior radius
			if(ratio.length <= 1 ) {
				if(i%2 != 0) p[i].mult(ratio[0]);
			} else {
				if(i%(ratio.length) == 0) {
					count_ratio = 0;

				}
				p[i].mult(ratio[count_ratio]) ;
				count_ratio++;
			}
			p[i].mult(size);
			p[i].add(pos);
		}
	  
	  float top = size.z;
	  float bottom = -size.z;
	  Vec3 center = barycenter(p);
	  Vec3 center_top = Vec3(center.x,center.y,top);
	  Vec3 center_bottom = Vec3(center.x,center.y,bottom);

		for(int i = 0 ; i < p.length ; i++) {
			// face top
			beginShape() ;
			vertex(p[i]);
	    vertex(center_top);
			if(i+1 < p.length)  {
				vertex(p[i+1]);
			} else {
				vertex(p[0]);
			}
			endShape(CLOSE);
			// face bottom
			beginShape() ;
			vertex(p[i]);
	    vertex(center_bottom);
			if(i+1 < p.length)  {
				vertex(p[i+1]);
			} else {
				vertex(p[0]);
			}
			endShape(CLOSE);
		}
	}



	private void star_2D(Vec3 pos, Vec3 size, Vec3 [] p, float[] ratio) {
		int count_ratio = 0;
		for(int i = 0 ; i < p.length ; i++) {
			// make a star, change the interior radius
			if(ratio.length <= 1 ) {
				if(i%2 != 0) p[i].mult(ratio[0]);
			} else {
				if(i%(ratio.length) == 0) {
					count_ratio = 0;

				}
				p[i].mult(ratio[count_ratio]) ;
				count_ratio++;
			}
			p[i].mult(size);
			p[i].add(pos);
		}
		// draww star
		beginShape() ;
		for(int i = 0 ; i < p.length ; i++) {
			vertex(p[i]);
		}
		endShape(CLOSE);
	}
}


 















/**
CROSS
*/
void cross_rect(iVec2 pos, int thickness, int radius) {
  // verticale one
	Vec2 size = Vec2(thickness, radius *2);
	Vec2 pos_temp = Vec2(pos.x, pos.y -floor(size.y/2) +(thickness /2));
	pos_temp.sub(thickness/2);
	rect(pos_temp,size);
	  // horizontal one
	size.set(radius *2, thickness);
	pos_temp.set(pos.x -floor(size.x/2) +(thickness /2),pos.y);
	pos_temp.sub(thickness/2);
	rect(pos_temp,size);


	//rect(pos, size);
	//rect(small_part, size.y, small_part);
}


void cross_box_2(Vec2 size) {
	// float ratio = map(ratio_costume_size,0,1,.3,.9);
//void cross_box_2(Vec2 size, float ratio) {
	float scale_cross = size.sum() *.5;
	float small_part = scale_cross *ratio_costume_size;

	box(size.x,small_part,small_part);
	box(small_part,size.y,small_part);
}

void cross_box_3(Vec3 size) {
	// float ratio = .3;
// void cross_box_3(Vec3 size, float ratio) {
	float scale_cross = size.sum() *.3;
	float small_part = scale_cross *ratio_costume_size;
   
	box(size.x,small_part,small_part);
	box(small_part,size.y,small_part);
	box(small_part,small_part,size.z);
}











/**
VIRUS
2015-2018
v 0.2.0
*/
void virus(Vec pos, Vec size) {
	int close = -1 ;
	float angle = 0 ;
	virus(pos,size,angle,close) ;
}

void virus(Vec pos, Vec size, float angle) {
	int close = -1;
	virus(pos,size,angle,close);
}



// main method
Virus virus_costume_rope;
boolean make_virus = true ;

void virus(Vec pos, Vec size, float angle, int close) {

	if(make_virus) {
		virus_costume_rope = new Virus() ;
		make_virus = false ;
	}

	if(virus_costume_rope.get_mutation() > 0 && frameCount%virus_costume_rope.get_mutation() == 0) {
		virus_costume_rope.reset() ;
	}
  virus_costume_rope.rotation(angle) ;
	virus_costume_rope.set_pos(pos) ;
	virus_costume_rope.set_size(size) ;
	virus_costume_rope.show(close) ;	
}


void set_costume_virus_mutation(int mutation) {
	if(virus_costume_rope != null && mutation != 0 && mutation != virus_costume_rope.get_mutation()) {
		virus_costume_rope.set_mutation(abs(mutation));
	}
}

void set_costume_virus_num(int num) {
	if(virus_costume_rope != null && num != 0 && num != virus_costume_rope.get_num()) {
		virus_costume_rope.set_num(abs(num));
	}
}


void set_costume_virus_node(int node) {
	if(virus_costume_rope != null && node != 0 && node != virus_costume_rope.get_node()) {
		virus_costume_rope.set_node(abs(node));
	}
}








/**
CLASS VIRUS
2015-2018
v 0.2.0
*/
public class Virus {
	Vec3 [][] branch;
	Vec3 size;
	Vec3 pos ;
	int node = 4;
	int num = 4;
	int mutation = 4;

	float angle = 0 ;
	public Virus() {
		size = Vec3(1);
		pos = Vec3(0);
		set_branch();
		/*
		branch = new Vec3 [node][num] ;
		for(int i = 0 ; i < node ; i++) {
			for(int k = 0 ; k < num ; k++) {
				Vec3 dir = new Vec3("RANDOM", 1) ;
				branch[i][k] = projection(dir) ;
			}
		}
		*/
	}

  // set
	private void set_branch() {
		branch = new Vec3 [node][num] ;
		for(int i = 0 ; i < node ; i++) {
			for(int k = 0 ; k < num ; k++) {
				Vec3 dir = new Vec3("RANDOM", 1) ;
				branch[i][k] = projection(dir) ;
			}
		}
	}


	public void set_node(int node) {
		this.node = node;
		set_branch();
	}

	public void set_num(int num) {
		this.num = num;
		set_branch();
	}

	public void set_mutation(int mutation) {
		this.mutation = mutation;
	}
  

  // get
	public int get_mutation() {
		return this.mutation;
	}

	public int get_node() {
		return this.node;
	}

	public int get_num() {
		return this.num;
	}



  

  // method
	public void reset() {
		for(int i = 0 ; i < node ; i++) {
			for(int k = 0 ; k < num ; k++) {
				Vec3 dir = new Vec3("RANDOM", 1) ;
				branch[i][k].set(projection(dir)) ;
			}
		}
	}
  
  // set
  public void set_size(Vec s) {
  	Vec3 final_size = Vec3(1) ;
		if(s instanceof Vec2) {
			Vec2 size_temp = (Vec2) s ;
			final_size.set(size_temp.x, size_temp.y, 1) ;
		} else if (s instanceof Vec3) {
			Vec3 size_temp = (Vec3) s ;
			final_size.set(size_temp) ;
		}
		size.set(final_size) ;
	}

	public void set_pos(Vec p) {
  	Vec3 final_pos = Vec3() ;
		if(p instanceof Vec2) {
			Vec2 pos_temp = (Vec2) p ;
			final_pos.set(pos_temp.x, pos_temp.y, 1) ;
		} else if (p instanceof Vec3) {
			Vec3 pos_temp = (Vec3) p ;
			final_pos.set(pos_temp) ;
		}
		pos.set(final_pos) ;
	}
  

  public void rotation(float angle) {
  	this.angle = angle ;
  	// System.err.println("Virus rotation() don't work must be coded for the future") ;
  }

	public Vec2 angle(float angle) {
		return to_cartesian_2D(angle) ;
	}
  

  // show
  public void show() {
  	show(-1) ;
  }
	


	public void show(int close) {
		if(angle != 0) {
			start_matrix() ;
			translate(pos) ;
			rotate(angle) ;
		}
		for(int k = 0 ; k < num ; k++) {
			if(node == 2) {
				Vec3 final_pos_a = branch[0][k].copy() ;
				final_pos_a.add(angle(angle)) ;
				final_pos_a.mult(size) ;
				if(angle == 0) final_pos_a.add(pos) ;

				Vec3 final_pos_b = branch[1][k].copy() ;
				final_pos_b.mult(size) ;
				if(angle == 0) final_pos_b.add(pos) ;
				line(final_pos_a, final_pos_b) ;
			} else if( node > 2) {
				beginShape() ;
				for(int m = 0 ; m < node ; m++) {
					Vec3 final_pos = branch[m][k].copy() ;
					final_pos.mult(size) ;
					if(angle == 0) final_pos.add(pos) ;
					vertex(final_pos) ;
				}
				if(close == CLOSE) endShape(CLOSE) ; else endShape() ;
			} else {
				Vec3 final_pos = branch[0][k].copy() ;
				//final_pos.add(angle(angle)) ;
				final_pos.mult(size) ;
				if(angle == 0) final_pos.add(pos) ;
				point(final_pos) ;
			}
		}
		if(angle != 0) stop_matrix() ;
	}
  
  // get
	public Vec3 [][] get() {
		return branch ;
	}
}









