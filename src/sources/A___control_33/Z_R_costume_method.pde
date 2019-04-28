/**
* Costume method
* Copyleft (c) 2014-2019
* v 1.8.5
* processing 3.5.3.269
* Rope Library 0.7.1.25
* @author @stanlepunk
* @see https://github.com/StanLepunK/Rope_framework
*/

import rope.costume.R_Circle;
import rope.costume.R_Bezier;
import rope.costume.R_Star;
import rope.costume.R_Virus;




/**
SHOW
*/
/**
Costume selection in shape catalogue
*/
void costume(float x, float y, float sx, float sy, Object data) {
	costume(vec2(x,y),vec2(sx,sy),data);
}

void costume(float x, float y, float z, float sx, float sy, Object data) {
	costume(vec3(x,y,z),vec2(sx,sy),data);
}

void costume(float x, float y, float z, float sx, float sy, float sz, Object data) {
	costume(vec3(x,y,z),vec3(sx,sy,sz),data);
}


void costume(vec pos, int size_int, Object data) {
	int which_costume = 0;
	String sentence = null;
	vec3 rotation = vec3();
	vec3 size = vec3(size_int);
	if(data instanceof Costume) {
		costume_impl(pos,size,rotation,(Costume)data);
	} else if(data instanceof Integer) {
		which_costume = (int)data;
		costume_management(pos,size,rotation,which_costume,null);
	} else if(data instanceof String) {
		sentence = (String)data;
		which_costume = MAX_INT;
		costume_management(pos,size,rotation,which_costume,sentence);
	}
}

void costume(vec pos, vec size, Object data) {
	int which_costume = 0;
	String sentence = null;
	vec3 rotation = vec3();
	if(data instanceof Costume) {
		costume_impl(pos,size,rotation,(Costume)data);
	} else if(data instanceof Integer) {
		which_costume = (int)data;
		costume_management(pos,size,rotation,which_costume,null);
	} else if(data instanceof String) {
		sentence = (String)data;
		which_costume = MAX_INT;
		costume_management(pos,size,rotation,which_costume,sentence);
	}
}

void costume(vec pos, vec size, float rot, Object data) {
	int which_costume = 0;
	String sentence = null;
	vec3 rotation = vec3(0,0,rot);
	if(data instanceof Costume) {
		costume_impl(pos,size,rotation,(Costume)data);
	} else if(data instanceof Integer) {
		which_costume = (int)data;
		costume_management(pos,size,rotation,which_costume,null);
	} else if(data instanceof String) {
		sentence = (String)data;
		which_costume = MAX_INT;
		costume_management(pos,size,rotation,which_costume,sentence);
	}

}

void costume(vec pos, vec size, vec rotation, Object data) {
	int which_costume = 0;
	String sentence = null;
	if(data instanceof Costume) {
		costume_impl(pos,size,rotation,(Costume)data);
	} else if(data instanceof Integer) {
		which_costume = (int)data;
		costume_management(pos,size,rotation,which_costume,null);
	} else if(data instanceof String) {
		sentence = (String)data;
		which_costume = MAX_INT;
		costume_management(pos,size,rotation,which_costume,sentence);
	}
}









/**
managing costume rope method
*/
@Deprecated
void costume_management(vec pos, vec size, vec rotation, int which_costume, String sentence) {
  vec3 pos_final = vec3(0) ;
  vec3 size_final = vec3(1) ;
	if((pos instanceof vec2 || pos instanceof vec3) 
			&& (size instanceof vec2 || size instanceof vec3)
			&& (rotation instanceof vec2 || rotation instanceof vec3)) {
		// pos
		if(pos instanceof vec2) {
			vec2 temp_pos = (vec2)pos;
			pos_final.set(temp_pos.x, temp_pos.y, 0);
		} else if(pos instanceof vec3) {
			vec3 temp_pos = (vec3)pos;
			pos_final.set(temp_pos);
		}
		//size
		if(size instanceof vec2) {
			vec2 temp_size = (vec2)size;
			size_final.set(temp_size.x, temp_size.y, 1);
		} else if(size instanceof vec3) {
			vec3 temp_size = (vec3)size;
			size_final.set(temp_size);
		}
		//send
		if(sentence == null ) {
			costume_impl(pos_final,size_final,rotation,which_costume);
		} else {
			costume_impl(pos_final,size_final,rotation,sentence);
		}		
	} else {
		printErrTempo(180,"vec pos or vec size if not an instanceof vec2 or vec3, it's not possible to process costume_rope()");
	}
}






/**
MAIN METHOD 
String COSTUME
v 0.2.0
Change the method for method with 
case and which_costume
and 
break
*/
void costume_impl(vec3 pos, vec3 size, vec rot, String sentence) {
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
Costume costume_rope_buffer;
void costume_impl(vec3 pos, vec3 size, vec rot, int which_costume) {
	if(costume_rope_buffer == null) {
		costume_rope_buffer = new Costume(this,which_costume);
	} else {
		costume_rope_buffer.set_type(which_costume);
	}
	costume_rope_buffer.draw(pos,size,rot);
}

void costume_impl(vec pos, vec size, vec rot, Costume costume) {
	costume.draw(vec3(pos),vec3(size),rot);
}





















































/**
ASPECT ROPE 2016-2018
v 0.1.3
*/
void aspect_is(boolean fill_is, boolean stroke_is, boolean alpha_is) {
	if(aspect_rope == null) aspect_rope = new Costume(this);
	aspect_rope.aspect_is(fill_is,stroke_is,alpha_is);
	fill_rope_is = aspect_rope.fill_is();
	stroke_rope_is = aspect_rope.stroke_is();
	alpha_rope_is = aspect_rope.alpha_is();
}

void init_bool_aspect() {
	if(aspect_rope == null) aspect_rope = new Costume(this);
	aspect_rope.aspect_is(true,true,true);
}

void aspect(int fill, int stroke, float thickness) {
	if(aspect_rope == null) aspect_rope = new Costume(this);
	aspect_is(aspect_rope.fill_is(),aspect_rope.stroke_is(),aspect_rope.alpha_is());
	aspect_rope.aspect(fill,stroke,thickness);
}

void aspect(int fill, int stroke, float thickness, Costume costume) {
	if(aspect_rope == null) aspect_rope = new Costume(this);
	aspect_is(aspect_rope.fill_is(),aspect_rope.stroke_is(),aspect_rope.alpha_is());
	aspect_rope.aspect(fill,stroke,thickness,costume.get_type());
}

void aspect(int fill, int stroke, float thickness, int costume) {
	if(aspect_rope == null) aspect_rope = new Costume(this);
	aspect_is(aspect_rope.fill_is(),aspect_rope.stroke_is(),aspect_rope.alpha_is());
	aspect_rope.aspect(fill,stroke,thickness,costume);
}

void aspect(vec fill, vec stroke, float thickness) {
	if(aspect_rope == null) aspect_rope = new Costume(this);
	aspect_is(aspect_rope.fill_is(),aspect_rope.stroke_is(),aspect_rope.alpha_is());
	aspect_rope.aspect(fill,stroke,thickness);
}

void aspect(vec fill, vec stroke, float thickness, Costume costume) {
	if(aspect_rope == null) aspect_rope = new Costume(this);
	aspect_is(aspect_rope.fill_is(),aspect_rope.stroke_is(),aspect_rope.alpha_is());
	aspect_rope.aspect(fill,stroke,thickness,costume.get_type());
}


void aspect(vec fill, vec stroke, float thickness, int costume) {
	if(aspect_rope == null) aspect_rope = new Costume(this);
	aspect_is(aspect_rope.fill_is(),aspect_rope.stroke_is(),aspect_rope.alpha_is());
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

void rotate_behavior(vec rotate) {
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
void house(vec3 size) {
	if(house_costume_rope != null) {
		house_costume_rope.set_size(size);
		house_costume_rope.show();
	} else {
		house_costume_rope = new House();
	}
}





/**
* flower method
* 2019-2019
* v 0.0.3
*/
R_Circle flower_costume_rope;
void flower(vec pos, int diam, int petals_num) {
	if(flower_costume_rope == null || flower_costume_rope.get_summits() != petals_num) {
		flower_costume_rope = new R_Circle(this,petals_num);
	} else {
		flower_costume_rope.pos(pos);
		flower_costume_rope.size(diam);
		flower_costume_rope.show();
		// if(petals_num < 3) petals_num = 3;
		
	}
}

void flower_wind(vec2 petal_left, float strength_left, vec2 petal_right, float strength_right) {
	if(flower_costume_rope != null) {
		for(R_Bezier b : flower_costume_rope.get_bezier()) {
	    vec2 trouble = vec2().sin_wave(frameCount,petal_left.x(),petal_left.y()).mult(strength_left);
	    b.set_a(trouble);
	    trouble = vec2().cos_wave(frameCount,petal_right.x(),petal_right.y()).mult(strength_right);
	    b.set_b(trouble);
	  }
	}
}


void flower_static(vec2 petal_left, float strength_left, vec2 petal_right, float strength_right) {
	if(flower_costume_rope != null) {
		for(R_Bezier b : flower_costume_rope.get_bezier()) {
	    vec2 petal_show = vec2(petal_left.x(),petal_left.y()).mult(strength_left);
	    b.set_a(petal_show);
	    petal_show = vec2(petal_right.x(),petal_right.y()).mult(strength_right);
	    b.set_b(petal_show);
	  }
	}
}

/*
void flower_petals(int petals_num) {
	flower_costume_rope = new R_Circle(this,petals_num);
}
*/








































/**
ANNEXE COSTUME
SHAPE CATALOGUE
*/
/**
STAR
*/

R_Star star_costume_rope;
void star_3D_is(boolean is_3D) {
	if(star_costume_rope != null) {
		star_costume_rope.is_3D(is_3D);
	} else {
		star_costume_rope = new R_Star(this);
	}
}


void star_summits(int summits) {
	if(star_costume_rope != null) {
		star_costume_rope.set_summits(summits);
	} else {
		star_costume_rope = new R_Star(this);
	}
}

void star_angle(float angle) {
	if(star_costume_rope != null) {
		star_costume_rope.angle(angle);
	} else {
		star_costume_rope = new R_Star(this);
	}
}

void star_ratio(float... ratio) {
	if(star_costume_rope != null) {
		star_costume_rope.set_ratio(ratio);
	} else {
		star_costume_rope = new R_Star(this);
	}
}


void star(vec position, vec size) {
	if(star_costume_rope != null) {
		star_costume_rope.pos(position);
		star_costume_rope.size(size);
		star_costume_rope.show();
	} else {
		star_costume_rope = new R_Star(this);
	}
}






 






















/**
CROSS
*/
void cross_rect(ivec2 pos, int thickness, int radius) {
	float h = radius;
	float w = thickness/3;

  // verticale one
	vec2 size = vec2(w,h);
	vec2 pos_temp = vec2(pos.x, pos.y -floor(size.y/2) +(w/2));
	pos_temp.sub(w/2);
	rect(pos_temp,size);
	
	// horizontal one
	size.set(h,w);
	pos_temp.set(pos.x-floor(size.x/2) +(w/2),pos.y);
	pos_temp.sub(w/2);
	rect(pos_temp,size);
}

void cross_box_2(vec2 size) {
	float scale_cross = size.sum() *.5;
	float small_part = scale_cross *ratio_costume_size *.3;

	box(size.x,small_part,small_part);
	box(small_part,size.y,small_part);
}

void cross_box_3(vec3 size) {
	float scale_cross = size.sum() *.3;
	float small_part = scale_cross *ratio_costume_size *.3;
   
	box(size.x,small_part,small_part);
	box(small_part,size.y,small_part);
	box(small_part,small_part,size.z);
}
















/**
VIRUS
2015-2018
v 0.2.2
*/
void virus(vec pos, vec size) {
	int close = -1 ;
	float angle = 0 ;
	virus(pos,size,angle,close) ;
}

void virus(vec pos, vec size, float angle) {
	int close = -1;
	virus(pos,size,angle,close);
}


// main method
R_Virus virus_costume_rope;
boolean make_virus = true ;
void virus(vec pos, vec size, float angle, int close) {
	if(make_virus) {
		virus_costume_rope = new R_Virus(this);
		make_virus = false ;
	}

	if(virus_costume_rope.get_mutation() > 0 && frameCount%virus_costume_rope.get_mutation() == 0) {
		virus_costume_rope.reset() ;
	}
  virus_costume_rope.angle(angle) ;
	virus_costume_rope.pos(pos) ;
	virus_costume_rope.size(size) ;
	virus_costume_rope.show() ;	
}

void virus_mutation(int mutation) {
	if(virus_costume_rope != null && mutation != 0 && mutation != virus_costume_rope.get_mutation()) {
		virus_costume_rope.set_mutation(abs(mutation));
	}
}

void virus_num(int num) {
	if(virus_costume_rope != null && num != 0 && num != virus_costume_rope.get_summits()) {
		virus_costume_rope.set_summits(abs(num));
	}
}

void virus_node(int node) {
	if(virus_costume_rope != null && node != 0 && node != virus_costume_rope.get_node()) {
		virus_costume_rope.set_node(abs(node));
	}
}




























/**
* COSTUME INFO
* 2016-2019
* v 0.2.0
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
boolean alpha_rope_is = true;
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

		costume_dict.add("FLOWER_ROPE",FLOWER_ROPE,2,3);

		costume_dict.add("HOUSE_ROPE",HOUSE_ROPE,3,0);

		costume_dict.add("VIRUS_ROPE",VIRUS_ROPE,3,0);

		list_costume_is_built = true ;
	}

  // add costume from your SVG or PNG
	if(ref_size_pic != costume_pic_list.size()) {
		for(Costume_pic c : costume_pic_list) {
			costume_dict.add(c.name, c.get_id(), 3, c.type) ;
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
























