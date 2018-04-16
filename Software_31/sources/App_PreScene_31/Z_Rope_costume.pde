/**
Rope Costume
* Copyleft (c) 2014-2018
v 1.0.4
* @author Stan le Punk
* @see https://github.com/StanLepunK/Costume_rope
*/
final int POINT_ROPE = 0 ;
final int ELLIPSE_ROPE = 1 ;
final int RECT_ROPE = 2 ;
final int LINE_ROPE = 3 ;

final int TRIANGLE_ROPE = 13 ;
final int SQUARE_ROPE = 14 ;
final int PENTAGON_ROPE = 15 ;
final int HEXAGON_ROPE = 16 ;
final int HEPTAGON_ROPE = 17 ;
final int OCTOGON_ROPE = 18 ;
final int NONAGON_ROPE = 19 ;
final int DECAGON_ROPE = 20 ;
final int HENDECAGON_ROPE = 21 ;
final int DODECAGON_ROPE = 22 ;

final int TEXT_ROPE = 26 ;

final int CROSS_RECT_ROPE = 52;
final int CROSS_BOX_2_ROPE = 53;
final int CROSS_BOX_3_ROPE = 54;

final int SPHERE_LOW_ROPE = 100 ;
final int SPHERE_MEDIUM_ROPE = 101 ;
final int SPHERE_HIGH_ROPE = 102 ;
final int TETRAHEDRON_ROPE = 103 ;
final int BOX_ROPE = 104 ;

final int STAR_4_ROPE = 504 ;
final int STAR_5_ROPE = 505 ;
final int STAR_6_ROPE = 506 ;
final int STAR_7_ROPE = 507 ;
final int STAR_8_ROPE = 508 ;
final int STAR_9_ROPE = 509 ;
final int STAR_10_ROPE = 510 ;
final int STAR_11_ROPE = 511 ;
final int STAR_12_ROPE = 512 ;

final int SUPER_STAR_8_ROPE = 608 ;
final int SUPER_STAR_12_ROPE = 612 ;

final int TETRAHEDRON_LINE_ROPE = 1001 ;
final int CUBE_LINE_ROPE = 1002 ;
final int OCTOHEDRON_LINE_ROPE = 1003 ;
final int RHOMBIC_COSI_DODECAHEDRON_SMALL_LINE_ROPE = 1004 ;
final int ICOSI_DODECAHEDRON_LINE_ROPE = 1005 ;

final int VIRUS_2_2_0_ROPE = 2_002_000 ;
final int VIRUS_2_2_1_ROPE = 2_002_001 ;
final int VIRUS_2_2_2_ROPE = 2_002_002 ;
final int VIRUS_2_2_4_ROPE = 2_002_004 ;
final int VIRUS_2_2_8_ROPE = 2_002_008 ;
final int VIRUS_2_2_16_ROPE = 2002_016 ;
final int VIRUS_2_2_32_ROPE = 2002_032 ;
final int VIRUS_2_2_64_ROPE = 2002_064 ;
final int VIRUS_2_2_128_ROPE = 2002_128 ;
final int VIRUS_2_2_256_ROPE = 2002_256 ;

final int VIRUS_3_2_0_ROPE = 3_002_000 ;
final int VIRUS_3_2_1_ROPE = 3_002_001 ;
final int VIRUS_3_2_2_ROPE = 3_002_002 ;
final int VIRUS_3_2_4_ROPE = 3_002_004 ;
final int VIRUS_3_2_8_ROPE = 3_002_008 ;
final int VIRUS_3_2_16_ROPE = 3_002_016 ;
final int VIRUS_3_2_32_ROPE = 3_002_032 ;
final int VIRUS_3_2_64_ROPE = 3_002_064 ;
final int VIRUS_3_2_128_ROPE = 3_002_128 ;
final int VIRUS_3_2_256_ROPE = 3_002_256 ;

final int VIRUS_3_4_0_ROPE = 3_004_000 ;
final int VIRUS_3_4_1_ROPE = 3_004_001 ;
final int VIRUS_3_4_2_ROPE = 3_004_002 ;
final int VIRUS_3_4_4_ROPE = 3_004_004 ;
final int VIRUS_3_4_8_ROPE = 3_004_008 ;
final int VIRUS_3_4_16_ROPE = 3_004_016 ;
final int VIRUS_3_4_32_ROPE = 3_004_032 ;
final int VIRUS_3_4_64_ROPE = 3_004_064 ;
final int VIRUS_3_4_128_ROPE = 3_004_128 ;
final int VIRUS_3_4_256_ROPE = 3_004_256 ;

final int VIRUS_3_8_0_ROPE = 3_008_000 ;
final int VIRUS_3_8_1_ROPE = 3_008_001 ;
final int VIRUS_3_8_2_ROPE = 3_008_002 ;
final int VIRUS_3_8_4_ROPE = 3_008_004 ;
final int VIRUS_3_8_8_ROPE = 3_008_008 ;
final int VIRUS_3_8_16_ROPE = 3_008_016 ;
final int VIRUS_3_8_32_ROPE = 3_008_032 ;
final int VIRUS_3_8_64_ROPE = 3_008_064 ;
final int VIRUS_3_8_128_ROPE = 3_008_128 ;
final int VIRUS_3_8_256_ROPE = 3_008_256 ;





Info_int_dict costume_dict = new Info_int_dict() ;
boolean list_costume_is_built = false ;
int ref_size_pic = -1 ;

void costume_list() {
	if(!list_costume_is_built) {
		/* 
		* add(name, code, renderer, type)
		* code: int constante to access directly
		* render: 2 = 2D ; 3 = 3D ;
		* type : 0 = shape ; 1 = bitmap ; 2 = svg  ; 3 = shape with just stroke component ; 4 = text
		*/
		costume_dict.add("POINT_ROPE", POINT_ROPE, 2, 0) ;
		costume_dict.add("ELLIPSE_ROPE", ELLIPSE_ROPE, 2, 0) ;
		costume_dict.add("RECT_ROPE", RECT_ROPE, 2, 0) ;
		costume_dict.add("LINE_ROPE", LINE_ROPE, 2, 0) ;

		costume_dict.add("TRIANGLE_ROPE", TRIANGLE_ROPE, 2, 0) ;
		costume_dict.add("SQUARE_ROPE", SQUARE_ROPE, 2, 0) ;
		costume_dict.add("PENTAGON_ROPE", PENTAGON_ROPE, 2, 0) ;
		costume_dict.add("HEXAGON_ROPE", HEXAGON_ROPE, 2, 0) ;
		costume_dict.add("HEPTAGON_ROPE", HEPTAGON_ROPE, 2, 0) ;
		costume_dict.add("OCTOGON_ROPE", OCTOGON_ROPE, 2, 0) ;
		costume_dict.add("NONAGON_ROPE", NONAGON_ROPE, 2, 0) ;
		costume_dict.add("DECAGON_ROPE", DECAGON_ROPE, 2, 0) ;
		costume_dict.add("HENDECAGON_ROPE", HENDECAGON_ROPE, 2, 0) ;
		costume_dict.add("DODECAGON_ROPE", DODECAGON_ROPE, 2, 0) ;

		costume_dict.add("TEXT_ROPE", TEXT_ROPE, 2, 4) ;
    
    costume_dict.add("CROSS_RECT_ROPE", CROSS_RECT_ROPE, 2, 0) ;
		costume_dict.add("CROSS_BOX_2_ROPE", CROSS_BOX_2_ROPE, 3, 0) ;
		costume_dict.add("CROSS_BOX_3_ROPE", CROSS_BOX_3_ROPE, 3, 0) ;

		costume_dict.add("SPHERE_LOW_ROPE", SPHERE_LOW_ROPE, 3, 0) ;
		costume_dict.add("SPHERE_MEDIUM_ROPE", SPHERE_MEDIUM_ROPE, 3, 0) ;
		costume_dict.add("SPHERE_HIGH_ROPE", SPHERE_HIGH_ROPE, 3, 0) ;
		costume_dict.add("TETRAHEDRON_ROPE", TETRAHEDRON_ROPE, 3, 0) ;
		costume_dict.add("BOX_ROPE", BOX_ROPE, 3, 0) ;


		costume_dict.add("SPHERE_LOW_ROPE", SPHERE_LOW_ROPE, 3, 0) ;
		costume_dict.add("SPHERE_MEDIUM_ROPE", SPHERE_MEDIUM_ROPE, 3, 0) ;
		costume_dict.add("SPHERE_HIGH_ROPE", SPHERE_HIGH_ROPE, 3, 0) ;
		costume_dict.add("TETRAHEDRON_ROPE", TETRAHEDRON_ROPE, 3, 0) ;
		costume_dict.add("BOX_ROPE", BOX_ROPE, 3, 0) ;

		costume_dict.add("STAR_4_ROPE", STAR_4_ROPE, 2, 3) ;
		costume_dict.add("STAR_5_ROPE", STAR_5_ROPE, 2, 3) ;
		costume_dict.add("STAR_6_ROPE", STAR_6_ROPE, 2, 3) ;
		costume_dict.add("STAR_7_ROPE", STAR_7_ROPE, 2, 3) ;
		costume_dict.add("STAR_8_ROPE", STAR_8_ROPE, 2, 3) ;
		costume_dict.add("STAR_9_ROPE", STAR_9_ROPE, 2, 3) ;
		costume_dict.add("STAR_10_ROPE", STAR_10_ROPE, 2, 3) ;
		costume_dict.add("STAR_11_ROPE", STAR_11_ROPE, 2, 3) ;
		costume_dict.add("STAR_12_ROPE", STAR_12_ROPE, 2, 3) ;

		costume_dict.add("SUPER_STAR_8_ROPE", SUPER_STAR_8_ROPE, 2, 3) ;
		costume_dict.add("SUPER_STAR_12_ROPE", SUPER_STAR_12_ROPE, 2, 3) ;


    costume_dict.add("VIRUS_2_2_0_ROPE", VIRUS_2_2_0_ROPE, 3, 0) ;
		costume_dict.add("VIRUS_2_2_1_ROPE", VIRUS_2_2_1_ROPE, 3, 0) ;
		costume_dict.add("VIRUS_2_2_2_ROPE", VIRUS_2_2_2_ROPE, 3, 0) ;
		costume_dict.add("VIRUS_2_2_4_ROPE", VIRUS_2_2_4_ROPE, 3, 0) ;
		costume_dict.add("VIRUS_2_2_8_ROPE", VIRUS_2_2_8_ROPE, 3, 0) ;
		costume_dict.add("VIRUS_2_2_16_ROPE", VIRUS_2_2_16_ROPE, 3, 0) ;
		costume_dict.add("VIRUS_2_2_32_ROPE", VIRUS_2_2_32_ROPE, 3, 0) ;
		costume_dict.add("VIRUS_2_2_64_ROPE", VIRUS_2_2_64_ROPE, 3, 0) ;
		costume_dict.add("VIRUS_2_2_128_ROPE", VIRUS_2_2_128_ROPE, 3, 0) ;
		costume_dict.add("VIRUS_2_2_256_ROPE", VIRUS_2_2_256_ROPE, 3, 0) ;

		costume_dict.add("VIRUS_3_2_0_ROPE", VIRUS_3_2_0_ROPE, 3, 0) ;
		costume_dict.add("VIRUS_3_2_1_ROPE", VIRUS_3_2_1_ROPE, 3, 0) ;
		costume_dict.add("VIRUS_3_2_2_ROPE", VIRUS_3_2_2_ROPE, 3, 0) ;
		costume_dict.add("VIRUS_3_2_4_ROPE", VIRUS_3_2_4_ROPE, 3, 0) ;
		costume_dict.add("VIRUS_3_2_8_ROPE", VIRUS_3_2_8_ROPE, 3, 0) ;
		costume_dict.add("VIRUS_3_2_16_ROPE", VIRUS_3_2_16_ROPE, 3, 0) ;
		costume_dict.add("VIRUS_3_2_32_ROPE", VIRUS_3_2_32_ROPE, 3, 0) ;
		costume_dict.add("VIRUS_3_2_64_ROPE", VIRUS_3_2_64_ROPE, 3, 0) ;
		costume_dict.add("VIRUS_3_2_128_ROPE", VIRUS_3_2_128_ROPE, 3, 0) ;
		costume_dict.add("VIRUS_3_2_256_ROPE", VIRUS_3_2_256_ROPE, 3, 0) ;

    costume_dict.add("VIRUS_3_4_0_ROPE", VIRUS_3_4_0_ROPE, 3, 0) ;
		costume_dict.add("VIRUS_3_4_1_ROPE", VIRUS_3_4_1_ROPE, 3, 0) ;
		costume_dict.add("VIRUS_3_4_2_ROPE", VIRUS_3_4_2_ROPE, 3, 0) ;
		costume_dict.add("VIRUS_3_4_4_ROPE", VIRUS_3_4_4_ROPE, 3, 0) ;
		costume_dict.add("VIRUS_3_4_8_ROPE", VIRUS_3_4_8_ROPE, 3, 0) ;
		costume_dict.add("VIRUS_3_4_16_ROPE", VIRUS_3_4_16_ROPE, 3, 0) ;
		costume_dict.add("VIRUS_3_4_32_ROPE", VIRUS_3_4_32_ROPE, 3, 0) ;
		costume_dict.add("VIRUS_3_4_64_ROPE", VIRUS_3_4_64_ROPE, 3, 0) ;
		costume_dict.add("VIRUS_3_4_128_ROPE", VIRUS_3_4_128_ROPE, 3, 0) ;
		costume_dict.add("VIRUS_3_4_256_ROPE", VIRUS_3_4_256_ROPE, 3, 0) ;

    costume_dict.add("VIRUS_3_8_0_ROPE", VIRUS_3_8_0_ROPE, 3, 0) ;
		costume_dict.add("VIRUS_3_8_1_ROPE", VIRUS_3_8_1_ROPE, 3, 0) ;
		costume_dict.add("VIRUS_3_8_2_ROPE", VIRUS_3_8_2_ROPE, 3, 0) ;
		costume_dict.add("VIRUS_3_8_4_ROPE", VIRUS_3_8_4_ROPE, 3, 0) ;
		costume_dict.add("VIRUS_3_8_8_ROPE", VIRUS_3_8_8_ROPE, 3, 0) ;
		costume_dict.add("VIRUS_3_8_16_ROPE", VIRUS_3_8_16_ROPE, 3, 0) ;
		costume_dict.add("VIRUS_3_8_32_ROPE", VIRUS_3_8_32_ROPE, 3, 0) ;
		costume_dict.add("VIRUS_3_8_64_ROPE", VIRUS_3_8_64_ROPE, 3, 0) ;
		costume_dict.add("VIRUS_3_8_128_ROPE", VIRUS_3_8_128_ROPE, 3, 0) ;
		costume_dict.add("VIRUS_3_8_256_ROPE", VIRUS_3_8_256_ROPE, 3, 0) ;






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
int get_costume(int rank) {
	costume_list() ;
	if(rank >= 0 && rank < costume_dict.size()) {
		return costume_dict.get(rank).get(0) ;
	} else {
		System.err.println("Your rank is out from the list") ;
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
v 0.1.2
*/
boolean fill_rope_is = true ;
boolean stroke_rope_is = true ;
void aspect_is(boolean fill_is, boolean stroke_is) {
	fill_rope_is = fill_is ;
	stroke_rope_is = stroke_is ;
}

void init_bool_aspect() {
	fill_rope_is = true ;
  stroke_rope_is = true ;
}

void aspect_rope(int fill, int stroke, float strokeWeight) {
  //checkfill color
  if(alpha(fill) <= 0 || !fill_rope_is)  {
    noFill() ; 
  } else {
    fill(fill) ;
  } 
  //check stroke color
  if(alpha(stroke) <=0 || strokeWeight <= 0 || !stroke_rope_is) {
    noStroke() ;
  } else {
    stroke(stroke) ;
    strokeWeight(strokeWeight) ;
  }
  //
  init_bool_aspect() ;
}

void aspect_rope(int fill, int stroke, float strokeWeight, int costume) {
  if(costume != POINT_ROPE || costume != POINT) {
    if(alpha(fill) <= 0 || !fill_rope_is) {
    	noFill() ; 
    } else {
    	fill(fill) ;
    }

    if(alpha(stroke) <= 0  || strokeWeight <= 0 || !stroke_rope_is) {
    	noStroke() ; 
    } else {
    	stroke(stroke) ;
      strokeWeight(strokeWeight) ;
    }   
  } else  {
    if(alpha(fill) == 0) {
    	noStroke() ; 
    } else {
    	stroke(fill) ;
    	strokeWeight(strokeWeight) ;
    }
    noFill() ;   
  }
  //
  init_bool_aspect() ;
}



void aspect_rope(Vec fill, Vec stroke, float strokeWeight) {
  //checkfill color
  if(fill.w <=0 || !fill_rope_is)  {
    noFill() ; 
  } else {
    manage_fill(fill) ;
  } 
  //check stroke color
  if(stroke.w <=0 || strokeWeight <= 0 || !stroke_rope_is) {
    noStroke() ;
  } else {
    manage_stroke(stroke) ;
    strokeWeight(strokeWeight) ;
  }
  //
  init_bool_aspect() ;
}

void aspect_rope(Vec fill, Vec stroke, float strokeWeight, int costume) {
	//println("aspect_rope()", fill_rope_is, stroke_rope_is) ;
  if(costume != POINT_ROPE || costume != POINT) {
    if(fill.w <= 0 || !fill_rope_is) {
    	noFill() ; 
    } else {
    	manage_fill(fill) ;
    } 
    if(stroke.w <= 0  || strokeWeight <= 0 || !stroke_rope_is) {
    	noStroke() ; 
    } else {
    	manage_stroke(stroke) ;
    	strokeWeight(strokeWeight) ;
    }   
  } else {
    if(fill.w <= 0 || !fill_rope_is) {
    	noStroke() ; 
    } else {
    	manage_stroke(fill) ;
    	strokeWeight(strokeWeight) ;
    }
    noFill() ;   
  }
  //
  init_bool_aspect() ;
}


// manage componenent color Vec
void manage_fill(Vec f) {
	if(f instanceof Vec2) {
		Vec2 fill = (Vec2) f ;
		fill(fill) ;
	} else if(f instanceof Vec3) {
		Vec3 fill = (Vec3) f ;
		fill(fill) ;
	} else if(f instanceof Vec4) {
		Vec4 fill = (Vec4) f ;
		fill(fill) ;
	}
}

void manage_stroke(Vec s) {
	if(s instanceof Vec2) {
		Vec2 stroke = (Vec2) s ;
		stroke(stroke) ;
	} else if(s instanceof Vec3) {
		Vec3 stroke = (Vec3) s ;
		stroke(stroke) ;
	} else if(s instanceof Vec4) {
		Vec4 stroke = (Vec4) s ;
		stroke(stroke) ;
	}
}

















/**
simple text 
v 0.0.1
*/
String costume_text_rope = null ;

void costume_text(String s) {
	costume_text_rope = s ;
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
void costume_rope(Vec pos, int size_int, int which_costume)  {
	String s = null ;
	Vec3 dir_null = Vec3() ;
	Vec3 size = Vec3(size_int) ;
	float angle = 0 ;
	costume_rope(pos, size, angle, dir_null, which_costume, s) ;
}

void costume_rope(Vec pos, Vec size, int which_costume)  {
	String s = null ;
	Vec3 dir_null = Vec3() ;
	float angle = 0 ;
	costume_rope(pos, size, angle, dir_null, which_costume, s) ;
}

void costume_rope(Vec pos, Vec size, float angle, int which_costume)  {
	String s = null ;
	Vec3 dir_null = Vec3() ;
	costume_rope(pos, size, angle, dir_null, which_costume, s) ;
}

void costume_rope(Vec pos, Vec size, Vec dir, int which_costume)  {
	String s = null ;
	float angle = 0 ;
	costume_rope(pos, size, angle, dir, which_costume, s) ;
}


/**
Costume selection with String
*/
void costume_rope(Vec pos, int size_int, String s)  {
	int which_costume = MAX_INT ;
	Vec3 dir_null = Vec3() ;
	Vec3 size = Vec3(size_int) ;
	float angle = 0 ;
	costume_rope(pos, size, angle, dir_null, which_costume, s) ;
}

void costume_rope(Vec pos, Vec size, String s)  {
	int which_costume = MAX_INT ;
	Vec3 dir_null = Vec3() ;
	float angle = 0 ;
	costume_rope(pos, size, angle, dir_null, which_costume, s) ;
}

void costume_rope(Vec pos, Vec size, float angle, String s)  {
	int which_costume = MAX_INT ;
	Vec3 dir_null = Vec3() ;
	costume_rope(pos, size, angle, dir_null, which_costume, s) ;
}

void costume_rope(Vec pos, Vec size, Vec dir, String s)  {
	int which_costume = MAX_INT ;
	float angle = 0 ;
	costume_rope(pos, size, angle, dir, which_costume, s) ;
}


















/**
managing costume rope method
*/
void costume_rope(Vec pos, Vec size, float angle, Vec dir, int which_costume, String sentence) {
  Vec3 pos_final = Vec3(0) ;
  Vec3 size_final = Vec3(1) ;
	if((pos instanceof Vec2 || pos instanceof Vec3) 
			&& (size instanceof Vec2 || size instanceof Vec3)
			&& (dir instanceof Vec2 || dir instanceof Vec3)) {
		// pos
		if(pos instanceof Vec2) {
			Vec2 temp_pos = (Vec2) pos ;
			pos_final.set(temp_pos.x, temp_pos.y, 0) ;
		} else if(pos instanceof Vec3) {
			Vec3 temp_pos = (Vec3) pos ;
			pos_final.set(temp_pos) ;
		}
		//size
		if(size instanceof Vec2) {
			Vec2 temp_size = (Vec2) size ;
			size_final.set(temp_size.x, temp_size.y, 1) ;
		} else if(size instanceof Vec3) {
			Vec3 temp_size = (Vec3) size ;
			size_final.set(temp_size) ;
		}
		//send
		if(sentence == null ) {
			costume_rope(pos_final, size_final, angle, dir, which_costume) ;
		} else {
			costume_rope(pos_final, size_final, angle, dir, sentence) ;
		}
	} else {
		printErrTempo(180,"Vec pos or Vec size if not an instanceof Vec2 or Vec3, it's not possible to process costume_rope()");
	}
}
















/**
MAIN METHOD 
String COSTUME

Change the method for method with 
case and which_costume
and 
break
*/
void costume_rope(Vec3 pos, Vec3 size, float angle, Vec dir, String sentence) {
	if(dir instanceof Vec2) {
    // direction polar
	} else if (dir instanceof Vec3) {
    // direction cartesian
	} else {
    printErrTempo(180,"Vec dir if not an instanceof Vec2 or Vec3, it's not possible to process costume_rope()") ;
	}

	start_matrix() ;
  if(angle != .0) rotate(angle) ;
  translate(pos) ;
  text(sentence, 0,0) ;
	stop_matrix() ;


}



/**
MAIN METHOD 
V.0.1.0
Which costume ?

Change the method for method with 
case and which_costume
and 
break
*/

/**
rotate behavior
v 0.1.0
*/
boolean costume_rot_x = false ;
boolean costume_rot_y = false ;
boolean costume_rot_z = false ;

void costume_rotate_x() {
	costume_rot_x = true ;
}

void costume_rotate_y() {
	costume_rot_y = true ;
}

void costume_rotate_z() {
	costume_rot_z = true ;
}

void rotate_behavior(Vec3 angle) {
	if(angle.x != 0 && !costume_rot_x && !costume_rot_y && !costume_rot_z) {
		rotate(angle.x) ;
	}
	if(costume_rot_x && angle.x != 0) {
		rotateX(angle.x) ;
		costume_rot_x = false ;
	}
	if(costume_rot_y && angle.y != 0) {
		rotateY(angle.y) ;
		costume_rot_y = false ;
	}
	if(costume_rot_z && angle.z != 0) {
		rotateZ(angle.z) ;
		costume_rot_z = false ;
	}
}


/**
costume rope
v 1.0.0
*/
void costume_rope(Vec3 pos, Vec3 size, float angle, Vec dir, int which_costume) {

	if(dir instanceof Vec2) {
    // direction polar
	} else if (dir instanceof Vec3) {
    // direction cartesian
	} else {
    printErrTempo(180,"Vec dir if not an instanceof Vec2 or Vec3, it's not possible to process costume_rope()") ;
	}

	if (which_costume == POINT_ROPE) {
    strokeWeight(size.x) ;
		point(pos) ;
	} else if (which_costume == ELLIPSE_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		ellipse(0,0, size.x, size.y) ;
		stop_matrix() ;

	} else if (which_costume == RECT_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		rect(0,0, size.x, size.y) ;
		stop_matrix() ;

	} else if (which_costume == LINE_ROPE) {
		primitive(pos, size.x, 2, angle) ;
	}



		else if (which_costume == TRIANGLE_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		primitive(Vec3(0), size.x, 3) ;
		stop_matrix() ;
	}  else if (which_costume == SQUARE_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		primitive(Vec3(0), size.x, 4) ;
		stop_matrix() ;
	} else if (which_costume == PENTAGON_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		primitive(Vec3(0), size.x, 5) ;
		stop_matrix() ;
	} else if (which_costume == HEXAGON_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		primitive(Vec3(0), size.x, 6) ;
		stop_matrix() ;
	} else if (which_costume == HEPTAGON_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		primitive(Vec3(0), size.x, 7) ;
		stop_matrix() ;
	} else if (which_costume == OCTOGON_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		primitive(Vec3(0), size.x, 8) ;
		stop_matrix() ;
	} else if (which_costume == NONAGON_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		primitive(Vec3(0), size.x, 9) ;
		stop_matrix() ;
	} else if (which_costume == DECAGON_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		primitive(Vec3(0), size.x, 10) ;
		stop_matrix() ;
	} else if (which_costume == HENDECAGON_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		primitive(Vec3(0), size.x, 11) ;
		stop_matrix() ;
	} else if (which_costume == DODECAGON_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		primitive(Vec3(0), size.x, 12) ;
		stop_matrix() ;
	}

	else if (which_costume == CROSS_RECT_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		cross_rect(iVec2(0), (int)size.y, (int)size.x) ;
		stop_matrix() ;
	} else if (which_costume == CROSS_BOX_2_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		cross_box_2(Vec2(size.x, size.y)) ;
		stop_matrix() ;
	} else if (which_costume == CROSS_BOX_3_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		cross_box_3(size) ;
		stop_matrix() ;
	}



	  else if(which_costume == TEXT_ROPE) {
	  	start_matrix() ;
	  	translate(pos) ;
	  	rotate_behavior(Vec3(angle)) ;
	  	textSize(size.x) ;
	  	if(costume_text_rope != null) {
	  		text(costume_text_rope, 0, 0) ;
	  	} else {
	  		costume_text_rope = "ROPE" ;
	  		text(costume_text_rope, 0, 0) ;
	  	}
	  	stop_matrix() ;
	  }




		else if (which_costume == SPHERE_LOW_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		sphereDetail(5);
		sphere(size.x) ;
		stop_matrix() ;
	} else if (which_costume == SPHERE_MEDIUM_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		sphereDetail(12);
		sphere(size.x) ;
		stop_matrix() ;
	}else if (which_costume == SPHERE_HIGH_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		sphere(size.x) ;
		stop_matrix() ;
	} else if (which_costume == TETRAHEDRON_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		tetrahedron((int)size.x) ;
		stop_matrix() ;
	} else if (which_costume == BOX_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		box(size) ;
		stop_matrix() ;
	} 

	else if (which_costume == STAR_4_ROPE) {
		float [] ratio = {.38} ;
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		float angle_null = 0 ;
		star(Vec3(0), size, 4, angle_null, ratio) ;
		stop_matrix() ;
	}  else if (which_costume == STAR_5_ROPE) {
		float [] ratio = {.38} ;
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		float angle_null = 0 ;
		star(Vec3(0), size, 5, angle_null, ratio) ;
		stop_matrix() ;
	} else if (which_costume == STAR_6_ROPE) {
		float [] ratio = {.38} ;
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		float angle_null = 0 ;
		star(Vec3(0), size, 6, angle_null, ratio) ;
		stop_matrix() ;
	} else if (which_costume == STAR_7_ROPE) {
		float [] ratio = {.38} ;
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		float angle_null = 0 ;
		star(Vec3(0), size, 7, angle_null, ratio) ;
		stop_matrix() ;
	} else if (which_costume == STAR_8_ROPE) {
		float [] ratio = {.38} ;
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		float angle_null = 0 ;
		star(Vec3(0), size, 8, angle_null, ratio) ;
		stop_matrix() ;
	} else if (which_costume == STAR_9_ROPE) {
		float [] ratio = {.38} ;
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		float angle_null = 0 ;
		star(Vec3(0), size, 9, angle_null, ratio) ;
		stop_matrix() ;
	} else if (which_costume == STAR_10_ROPE) {
		float [] ratio = {.38} ;
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		float angle_null = 0 ;
		star(Vec3(0), size, 10, angle_null, ratio) ;
		stop_matrix() ;
	} else if (which_costume == STAR_11_ROPE) {
		float [] ratio = {.38} ;
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		float angle_null = 0 ;
		star(Vec3(0), size, 11, angle_null, ratio) ;
		stop_matrix() ;
	} else if (which_costume == STAR_12_ROPE) {
		float [] ratio = {.38} ;
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		float angle_null = 0 ;
		star(Vec3(0), size, 12, angle_null, ratio) ;
		stop_matrix() ;
	} 



	else if (which_costume == SUPER_STAR_8_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		float angle_null = 0 ;
		star(Vec3(0), size, 8, angle_null, 2., .5, 1., .5) ;
		stop_matrix() ;
	} else if (which_costume == SUPER_STAR_12_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		float angle_null = 0 ;
		star(Vec3(0), size, 12, angle_null, 2., .5, 1., .5, 1., .5) ;
		stop_matrix() ;
	}



	else if (which_costume == TETRAHEDRON_LINE_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		polyhedron("TETRAHEDRON","LINE", (int)size.x) ;
		stop_matrix() ;
	} else if (which_costume == CUBE_LINE_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		polyhedron("CUBE","LINE", (int)size.x) ;
		stop_matrix() ;
	} else if (which_costume == OCTOHEDRON_LINE_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		polyhedron("OCTOHEDRON","LINE", (int)size.x) ;
		stop_matrix() ;
	} else if (which_costume == RHOMBIC_COSI_DODECAHEDRON_SMALL_LINE_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		polyhedron("RHOMBIC COSI DODECAHEDRON SMALL","LINE", (int)size.x) ;
		stop_matrix() ;
	} else if (which_costume == ICOSI_DODECAHEDRON_LINE_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		polyhedron("ICOSI DODECAHEDRON","LINE", (int)size.x) ;
		stop_matrix() ;
	}





	else if(which_costume == VIRUS_2_2_0_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		virus(Vec3(), size, 2, 2, 0, 0, -1) ;
		stop_matrix() ;
	} else if(which_costume == VIRUS_2_2_1_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		virus(Vec3(), size, 2, 2, 1, 0, -1) ;
		stop_matrix() ;
	} else if(which_costume == VIRUS_2_2_2_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		virus(Vec3(), size, 2, 2, 2, 0, -1) ;
		stop_matrix() ;
	} else if(which_costume == VIRUS_2_2_4_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		virus(Vec3(), size, 2, 2, 4, 0, -1) ;
		stop_matrix() ;
	} else if(which_costume == VIRUS_2_2_8_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		virus(Vec3(), size, 2, 2, 8, 0, -1) ;
		stop_matrix() ;
	} else if(which_costume == VIRUS_2_2_16_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		virus(Vec3(), size, 2, 2, 16, 0, -1) ;
		stop_matrix() ;
	} else if(which_costume == VIRUS_2_2_32_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		virus(Vec3(), size, 2, 2, 32, 0, -1) ;
		stop_matrix() ;
	} else if(which_costume == VIRUS_2_2_64_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		virus(Vec3(), size, 2, 2, 64, 0, -1) ;
		stop_matrix() ;
	} else if(which_costume == VIRUS_2_2_128_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		virus(Vec3(), size, 2, 2, 128, 0, -1) ;
		stop_matrix() ;
	} else if(which_costume == VIRUS_2_2_256_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		virus(Vec3(), size, 2, 2, 256, 0, -1) ;
		stop_matrix() ;
	}

	else if(which_costume == VIRUS_3_2_0_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		virus(Vec3(), size, 3, 2, 0, 0, -1) ;
		stop_matrix() ;
	} else if(which_costume == VIRUS_3_2_1_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		virus(Vec3(), size, 3, 2, 1, 0, -1) ;
		stop_matrix() ;
	} else if(which_costume == VIRUS_3_2_2_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		virus(Vec3(), size, 3, 2, 2, 0, -1) ;
		stop_matrix() ;
	} else if(which_costume == VIRUS_3_2_4_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		virus(Vec3(), size, 3, 2, 4, 0, -1) ;
		stop_matrix() ;
	} else if(which_costume == VIRUS_3_2_8_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		virus(Vec3(), size, 3, 2, 8, 0, -1) ;
		stop_matrix() ;
	} else if(which_costume == VIRUS_3_2_16_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		virus(Vec3(), size, 3, 2, 16, 0, -1) ;
		stop_matrix() ;
	} else if(which_costume == VIRUS_3_2_32_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		virus(Vec3(), size, 3, 2, 32, 0, -1) ;
		stop_matrix() ;
	} else if(which_costume == VIRUS_3_2_64_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		virus(Vec3(), size, 3, 2, 64, 0, -1) ;
		stop_matrix() ;
	} else if(which_costume == VIRUS_3_2_128_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		virus(Vec3(), size, 3, 2, 128, 0, -1) ;
		stop_matrix() ;
	} else if(which_costume == VIRUS_3_2_256_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		virus(Vec3(), size, 3, 2, 256, 0, -1) ;
		stop_matrix() ;
	}

	else if(which_costume == VIRUS_3_4_0_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		virus(Vec3(), size, 3, 4, 0, 0, -1) ;
		stop_matrix() ;
	} else if(which_costume == VIRUS_3_4_1_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		virus(Vec3(), size, 3, 4, 1, 0, -1) ;
		stop_matrix() ;
	} else if(which_costume == VIRUS_3_4_2_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		virus(Vec3(), size, 3, 4, 2, 0, -1) ;
		stop_matrix() ;
	} else if(which_costume == VIRUS_3_4_4_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		virus(Vec3(), size, 3, 4, 4, 0, -1) ;
		stop_matrix() ;
	} else if(which_costume == VIRUS_3_4_8_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		virus(Vec3(), size, 3, 4, 8, 0, -1) ;
		stop_matrix() ;
	} else if(which_costume == VIRUS_3_4_16_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		virus(Vec3(), size, 3, 4, 16, 0, -1) ;
		stop_matrix() ;
	} else if(which_costume == VIRUS_3_4_32_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		virus(Vec3(), size, 3, 4, 32, 0, -1) ;
		stop_matrix() ;
	} else if(which_costume == VIRUS_3_4_64_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		virus(Vec3(), size, 3, 4, 64, 0, -1) ;
		stop_matrix() ;
	} else if(which_costume == VIRUS_3_4_128_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		virus(Vec3(), size, 3, 4, 128, 0, -1) ;
		stop_matrix() ;
	} else if(which_costume == VIRUS_3_4_256_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		virus(Vec3(), size, 3, 4, 256, 0, -1) ;
		stop_matrix() ;
	}

	else if(which_costume == VIRUS_3_8_0_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		virus(Vec3(), size, 3, 8, 0, 0, -1) ;
		stop_matrix() ;
	} else if(which_costume == VIRUS_3_8_1_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		virus(Vec3(), size, 3, 8, 1, 0, -1) ;
		stop_matrix() ;
	} else if(which_costume == VIRUS_3_8_2_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		virus(Vec3(), size, 3, 8, 2, 0, -1) ;
		stop_matrix() ;
	} else if(which_costume == VIRUS_3_8_4_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		virus(Vec3(), size, 3, 8, 4, 0, -1) ;
		stop_matrix() ;
	} else if(which_costume == VIRUS_3_8_8_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		virus(Vec3(), size, 3, 8, 8, 0, -1) ;
		stop_matrix() ;
	} else if(which_costume == VIRUS_3_8_16_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		virus(Vec3(), size, 3, 8, 16, 0, -1) ;
		stop_matrix() ;
	} else if(which_costume == VIRUS_3_8_32_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		virus(Vec3(), size, 3, 8, 32, 0, -1) ;
		stop_matrix() ;
	} else if(which_costume == VIRUS_3_8_64_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		virus(Vec3(), size, 3, 8, 64, 0, -1) ;
		stop_matrix() ;
	} else if(which_costume == VIRUS_3_8_128_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		virus(Vec3(), size, 3, 8, 128, 0, -1) ;
		stop_matrix() ;
	} else if(which_costume == VIRUS_3_8_256_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		virus(Vec3(), size, 3, 8, 256, 0, -1) ;
		stop_matrix() ;
	}







	else if(which_costume < 0) {
		start_matrix() ;
		translate(pos) ;
		rotate_behavior(Vec3(angle)) ;
		for(int i = 0 ; i < costume_pic_list.size() ; i++) {
			Costume_pic p = costume_pic_list.get(i) ;
			if(p.ID == which_costume) {
				if(p.type == 1) {
					PImage img_temp = p.img.copy() ;
					if(size.x == size.y ) {
						img_temp.resize((int)size.x, 0) ;
					} else if (size.x != size.y) {
						img_temp.resize((int)size.x, (int)size.y) ;
					}
					image(img_temp, 0, 0) ;
					break ;
				} else if(p.type == 2) {
					Vec2 scale = Vec2(1) ;
					if(size.x == size.y) {
            scale = Vec2(size.x / p.svg.width(), size.x / p.svg.width()) ;
					} else {
						scale = Vec2(size.x / p.svg.width(), size.y / p.svg.height()) ;
					}
					
					p.svg.scaling(scale) ;
					p.svg.draw() ;
					break ;
				}
				
			}
		}
		stop_matrix() ;
	}
}









/**


ANNEXE COSTUME

SHAPE CATALOGUE


*/
/**
STAR
*/

void star(Vec position, int size_XY, int summits) {
	float [] ratio = new float[1]; 
	ratio[0] = .38 ;
	float angle = 0 ;
	Vec2 size = Vec2(size_XY, size_XY) ;
	star(position, size, summits, angle, ratio) ;
}

void star(Vec position, int size_XY, int summits, float... data) {
	float angle = data[0] ;
	float [] ratio = new float[data.length -1] ;
	ratio[0] = .38 ;
	if(data.length > 1) {
		for( int i = 0 ; i < ratio.length ; i++) {
			ratio[i] = data[i+1] ;
		}
	}
	Vec2 size = Vec2(size_XY, size_XY) ;
	star(position, size, summits, angle, ratio) ;
}



void star(Vec position, Vec size, int summits) {
		float [] ratio = new float[1];
	ratio[0] = .38 ;
	float angle = 0 ;
	star(position, size, summits, angle, ratio) ;
}


void star(Vec position, Vec size, int summits, float... data) {
	float angle = data[0] ;
	float [] ratio = new float[data.length -1] ;
	ratio[0] = .38 ;
	if(data.length > 1) {
		for( int i = 0 ; i < ratio.length ; i++) {
			ratio[i] = data[i+1] ;
		}
	}
	star(position, size, summits, angle, ratio) ;
}


void star(Vec position, Vec size_raw, int summits, float angle, float[] ratio) {
	Vec3 pos = Vec3(0) ;
	Vec3 size = Vec3(1) ;
	if(position instanceof Vec2) {
		Vec2 p = (Vec2) position ;
		pos.set(p.x, p.y, 0) ;
	} else if(position instanceof Vec3) {
		Vec3 p = (Vec3) position ;
		pos.set(p) ;
	}

	if(size_raw instanceof Vec2) {
		Vec2 s = (Vec2) size_raw ;
		size.set(s.x, s.y, 1) ;
	} else if(size_raw instanceof Vec3) {
		Vec3 s = (Vec3) size_raw ;
		size.set(s.x, s.y, 1) ;
	}



	if(pos.z != 0) {
		start_matrix() ;
		translate(0,0,pos.z) ;
	}

	Vec3 [] p = polygon_2D(summits *2, angle) ;
	int count_ratio = 0 ;
	
	for(int i = 0 ; i < p.length ; i++) {
		// make a star, change the interior radius
		if(ratio.length <= 1 ) {
			if(i%2 != 0) p[i].mult(ratio[0]) ;
		} else {
			if(i%(ratio.length) == 0) {
				count_ratio = 0 ;

			}
			p[i].mult(ratio[count_ratio]) ;
			count_ratio ++ ;
		}
		p[i].mult(size) ;
		p[i].add(pos) ;
	}
	// draww star
	beginShape() ;
	for(int i = 0 ; i < p.length ; i++) {
		vertex(p[i]) ;
	}
	endShape(CLOSE) ;

	if(pos.z != 0) {
		stop_matrix() ;
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
	rect(pos_temp, size);
	  // horizontal one
	size.set(radius *2, thickness);
	pos_temp.set(pos.x -floor(size.x/2) +(thickness /2),pos.y);
	pos_temp.sub(thickness/2);
	rect(pos_temp, size);


	//rect(pos, size);
	//rect(small_part, size.y, small_part);
}

void cross_box_2(Vec2 size) {
	float ratio_cross = .3 ;
	float scale_cross = size.sum() *.5;
	float small_part = scale_cross *ratio_cross ;

	box(size.x, small_part, small_part) ;
	box(small_part, size.y, small_part) ;
}


void cross_box_3(Vec3 size) {
	float ratio_cross = .3 ;
	float scale_cross = size.sum() *.3 ;
	float small_part = scale_cross *ratio_cross ;
   
	box(size.x, small_part, small_part) ;
	box(small_part, size.y, small_part) ;
	box(small_part, small_part, size.z) ;
}




/**
VIRUS
*/
class Virus {
	Vec3 [][] branch ;
	Vec3 size  ;
	Vec3 pos  ;
	int node, num ;
	float angle = 0 ;
	Virus(int node, int num) {
		this.node = node ;
		this.num = num ;
		size = Vec3(1) ;
		pos = Vec3(0) ;
		branch = new Vec3 [node][num] ;
		for(int i = 0 ; i < node ; i++) {
			for(int k = 0 ; k < num ; k++) {
				Vec3 dir = new Vec3("RANDOM", 1) ;
				branch[i][k] = projection(dir) ;
			}
		}
	}

	void reset() {
		for(int i = 0 ; i < node ; i++) {
			for(int k = 0 ; k < num ; k++) {
				Vec3 dir = new Vec3("RANDOM", 1) ;
				branch[i][k].set(projection(dir)) ;
			}
		}
	}
  
  // set
  void set_size(Vec s) {
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

	void set_pos(Vec p) {
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
  

  void rotation(float angle) {
  	this.angle = angle ;
  	// System.err.println("Virus rotation() don't work must be coded for the future") ;
  }

	Vec2 angle(float angle) {
		return to_cartesian_2D(angle) ;
	}
  

  // show
  void show() {
  	show(-1) ;
  }
	


	void show(int close) {
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
	Vec3 [][] get() {
		return branch ;
	}
}




void virus(Vec pos, Vec size, int node, int num) {
	int close = -1 ;
	int speed = 0 ;
	float angle = 0 ;
	virus(pos, size, node, num, speed, angle, close) ;
}

void virus(Vec pos, Vec size, int node, int num, float angle) {
	int close = -1 ;
	int speed = 0 ;
	virus(pos, size, node, num, speed, angle, close) ;
}

void virus(Vec pos, Vec size, int node, int num, int speed) {
	int close = -1 ;
	float angle = 0 ;
	virus(pos, size, node, num, speed, angle, close) ;
}

void virus(Vec pos, Vec size, int node, int num, int speed, float angle) {
	int close = -1 ;
	virus(pos, size, node, num, speed, angle, close) ;
}



// main method
Virus virus_method  ;
boolean make_virus = true ;


void virus(Vec pos, Vec size, int node, int num, int speed_mutation, float angle, int close) {

	if(make_virus) {
		virus_method = new Virus(node, num) ;
		make_virus = false ;
	}

	if(speed_mutation > 0 && frameCount%speed_mutation == 0) {
		virus_method.reset() ;
	}
  virus_method.rotation(angle) ;
	virus_method.set_pos(pos) ;
	virus_method.set_size(size) ;
	virus_method.show(close) ;	
}