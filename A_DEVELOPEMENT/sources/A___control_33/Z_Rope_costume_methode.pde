/**
Costume method
* Copyleft (c) 2014-2019
v 1.5.0
* @author Stan le Punk
* @see https://github.com/StanLepunK/Rope_method
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

final int HOUSE_ROPE = 2000;

final int VIRUS_ROPE = 88_888_888;



/**
SHOW
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
		costume(pos,size,rotation,which_costume,null);
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
			costume(pos_final,size_final,rotation,which_costume);
		} else {
			costume(pos_final,size_final,rotation,sentence);
		}		
	} else {
		printErrTempo(180,"Vec pos or Vec size if not an instanceof Vec2 or Vec3, it's not possible to process costume_rope()");
	}
}

/**
MAIN METHOD 
String COSTUME
v 0.1.1
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
	costume.draw(pos,size,rot);
}





















































/**
ASPECT ROPE 2016-2018
v 0.1.3
*/
void aspect_is(boolean fill_is, boolean stroke_is) {
	if(aspect_rope == null) aspect_rope = new Costume();
	aspect_rope.aspect_is(fill_is,stroke_is);
	fill_rope_is = aspect_rope.fill_is();
	stroke_rope_is = aspect_rope.stroke_is();
}

void init_bool_aspect() {
	if(aspect_rope == null) aspect_rope = new Costume();
	aspect_rope.aspect_is(true,true);
}

void aspect(int fill, int stroke, float thickness) {
	if(aspect_rope == null) aspect_rope = new Costume();
	aspect_is(aspect_rope.fill_is(),aspect_rope.stroke_is());
	aspect_rope.aspect(fill,stroke,thickness);
}

void aspect(int fill, int stroke, float thickness, Costume costume) {
	if(aspect_rope == null) aspect_rope = new Costume();
	aspect_is(aspect_rope.fill_is(),aspect_rope.stroke_is());
	aspect_rope.aspect(fill,stroke,thickness,costume.get_type());
}

void aspect(int fill, int stroke, float thickness, int costume) {
	if(aspect_rope == null) aspect_rope = new Costume();
	aspect_is(aspect_rope.fill_is(),aspect_rope.stroke_is());
	aspect_rope.aspect(fill,stroke,thickness,costume);
}

void aspect(Vec fill, Vec stroke, float thickness) {
	if(aspect_rope == null) aspect_rope = new Costume();
	aspect_is(aspect_rope.fill_is(),aspect_rope.stroke_is());
	aspect_rope.aspect(fill,stroke,thickness);
}

void aspect(Vec fill, Vec stroke, float thickness, Costume costume) {
	if(aspect_rope == null) aspect_rope = new Costume();
	aspect_is(aspect_rope.fill_is(),aspect_rope.stroke_is());
	aspect_rope.aspect(fill,stroke,thickness,costume.get_type());
}


void aspect(Vec fill, Vec stroke, float thickness, int costume) {
	if(aspect_rope == null) aspect_rope = new Costume();
	aspect_is(aspect_rope.fill_is(),aspect_rope.stroke_is());
	aspect_rope.aspect(fill,stroke,thickness,costume);
}







int get_fill_rope() {
	if(aspect_rope != null) {
		return aspect_rope.get_fill();
	} else {
		return color(g.colorModeX);
	}
}

int get_stroke_rope() {
	if(aspect_rope != null) {
		return aspect_rope.get_stroke();
	} else {
		return color(0);
	}
}

float get_thickness_rope() {
	if(aspect_rope != null) {
		return aspect_rope.get_thickness();
	} else {
		return 1.;
	}
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














































/**
house method
*/
House house_costume_rope;
void house(Vec3 size) {
	if(house_costume_rope != null) {
		house_costume_rope.set_size(size);
		house_costume_rope.show();
	} else {
		house_costume_rope = new House();
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
COSTUME INFO
*/
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




Info_int_dict costume_dict = new Info_int_dict();
boolean list_costume_is_built = false ;
int ref_size_pic = -1 ;
Costume aspect_rope;
String costume_text_rope = null;
boolean fill_rope_is = true;
boolean stroke_rope_is = true;
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

		costume_dict.add("HOUSE_ROPE",HOUSE_ROPE,3,0);

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
























