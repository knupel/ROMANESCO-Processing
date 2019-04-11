/**
* COSTUME class
* Copyleft (c) 2019-2019
* v 0.8.2
* @author @stanlepunk
* @see https://github.com/StanLepunK/Rope_framework
* Here you finf the class Costume and all the class shape used.
* Processing 3.5.3
* Rope Library 0.5.1
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

final int FLOWER_ROPE = 900;

final int TETRAHEDRON_LINE_ROPE = 1001;
final int CUBE_LINE_ROPE = 1002;
final int OCTOHEDRON_LINE_ROPE = 1003;
final int RHOMBIC_COSI_DODECAHEDRON_SMALL_LINE_ROPE = 1004;
final int ICOSI_DODECAHEDRON_LINE_ROPE = 1005;

final int HOUSE_ROPE = 2000;

final int VIRUS_ROPE = 88_888_888;





















/**
class Costume 
2018-2019
v 0.3.1
*/
import rope.costume.R_Primitive;
public class Costume {
	boolean fill_is;
	boolean stroke_is;
	int fill;
	int stroke;
	float thickness = 1.;

	int type;
	int node;
	int summits;
	int num;
	int mutation;
  float angle;
	float [] ratio;
	float [] strength;
	vec2 [] pair;
	boolean is_3D = false;
	boolean is_vertex = true;
	R_Primitive prim;
	PApplet papplet;

	public Costume(PApplet pa) {
		this.papplet = pa;
	}

	public Costume(PApplet pa,int type) {
		this.papplet = pa;
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

	public void set_strength(float... strength) {
		this.strength = strength;
	}

	public void set_pair(vec2... pair) {
		this.pair = pair;
	}

	public void is_3D(boolean is_3D) {
		this.is_3D = is_3D;
	}

	public void is_vertex(boolean is_vertex) {
		this.is_vertex = is_vertex;
	}



	// get
	public int get_fill() {
		return fill;
	}

	public int get_stroke() {
		return stroke;
	}

	public float get_thickness() {
		return thickness;
	}

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

	public float[] get_strength() {
		return strength;
	}

	public vec2[] get_pair() {
		return pair;
	}

	public boolean is_3D() {
		return is_3D;
	}

	public boolean is_vertex() {
		return is_vertex;
	}

	public boolean fill_is() {
		return this.fill_is;
	}

	public boolean stroke_is() {
		return this.stroke_is;
	}






	// ASPECT
	public void aspect_is(boolean fill_is, boolean stroke_is) {
		this.fill_is = fill_is;
		this.stroke_is = stroke_is;
	}

	public void init_bool_aspect() {
		this.fill_is = true ;
	  this.stroke_is = true ;
	}

	public void aspect(int fill, int stroke, float thickness) {
	  //checkfill color
	  if(alpha(fill) <= 0 || !this.fill_is)  {
	    noFill(); 
	  } else {
	  	manage_fill(fill);
	  } 
	  //check stroke color
	  if(alpha(stroke) <=0 || thickness <= 0 || !this.stroke_is) {
	    noStroke();
	  } else {
	  	manage_stroke(stroke);
	    manage_thickness(thickness);
	  }
	  //
	  init_bool_aspect();
	}

	public void aspect(int fill, int stroke, float thickness, Costume costume) {
		aspect(fill,stroke,thickness,costume.get_type());
	}

	public void aspect(int fill, int stroke, float thickness, int costume) {
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



	public void aspect(vec fill, vec stroke, float thickness) {
	  //checkfill color
	  if(fill.w <=0 || !this.fill_is)  {
	    noFill() ; 
	  } else {
	    manage_fill(fill);
	  } 
	  //check stroke color
	  if(stroke.w <=0 || thickness <= 0 || !this.stroke_is) {
	    noStroke();
	  } else {
	    manage_stroke(stroke);
	    manage_thickness(thickness);
	  }
	  //
	  init_bool_aspect();
	}

	void aspect(vec fill, vec stroke, float thickness, Costume costume) {
		aspect(fill,stroke,thickness,costume.get_type());
	}


	void aspect(vec fill, vec stroke, float thickness, int costume) {
	  if(costume == r.NULL) {
	    // 
		} else if(costume != r.NULL || costume != POINT_ROPE || costume != POINT) {
	    if(fill.w <= 0 || !this.fill_is) {
	    	noFill() ; 
	    } else {
	    	manage_fill(fill);
	    } 
	    if(stroke.w <= 0  || thickness <= 0 || !this.stroke_is) {
	    	noStroke(); 
	    } else {
	    	manage_stroke(stroke);
	    	manage_thickness(thickness);
	    }   
	  } else {
	    if(fill.w <= 0 || !this.fill_is) {
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


	private void manage_fill(Object arg) {
		if(arg instanceof vec2) {
			vec2 c = (vec2)arg;
			this.fill = color(c.x,c.x,c.x,c.y);
			fill(c) ;
		} else if(arg instanceof vec3) {
			vec3 c = (vec3)arg;
			this.fill = color(c.x,c.y,c.z,g.colorModeA);
			fill(c) ;
		} else if(arg instanceof vec4) {
			vec4 c = (vec4)arg;
			this.fill = color(c.x,c.y,c.z,c.w);
			fill(c);
		} else if(arg instanceof Integer) {
			int c = (int)arg;
			this.fill = c;
			fill(c);
		}
	}

	private void manage_stroke(Object arg) {
		if(arg instanceof vec2) {
			vec2 c = (vec2)arg;
			this.stroke = color(c.x,c.x,c.x,c.y);
			stroke(c);
		} else if(arg instanceof vec3) {
			vec3 c = (vec3)arg;
			this.stroke = color(c.x,c.y,c.z,g.colorModeA);
			stroke(c);
		} else if(arg instanceof vec4) {
			vec4 c = (vec4)arg;
			this.stroke = color(c.x,c.y,c.z,c.w);
			stroke(c);
		} else if(arg instanceof Integer) {
			int c = (int)arg;
			this.stroke = c;
			stroke(c);
		}
	}


	private void manage_thickness(float thickness) {
		this.thickness = thickness;
		strokeWeight(this.thickness);
	}






	public void draw(vec3 pos, vec3 size, vec rot) {
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
			ellipse(vec2(),size);
			stop_matrix();

		} else if (this.get_type() == RECT_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			rect(vec2(-size.x,-size.y).div(2),vec2(size.x,size.y));
			stop_matrix();

		} else if (this.get_type() == LINE_ROPE) {
			if(prim == null) prim = new R_Primitive(papplet,2);
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			prim.size((int)size.x);
			prim.show();
			stop_matrix();
		}

		else if (this.get_type() == TRIANGLE_ROPE) {
			if(prim == null) prim = new R_Primitive(papplet,3);
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			prim.size((int)size.x);
			prim.show();
			stop_matrix();
		}  else if (this.get_type() == SQUARE_ROPE) {
			if(prim == null) prim = new R_Primitive(papplet,4);
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			prim.size((int)size.x);
			prim.show();
			stop_matrix();
		} else if (this.get_type() == PENTAGON_ROPE) {
			if(prim == null) prim = new R_Primitive(papplet,5);
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			prim.size((int)size.x);
			prim.show();
			stop_matrix();
		} else if (this.get_type() == HEXAGON_ROPE) {
			if(prim == null) prim = new R_Primitive(papplet,6);
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			prim.size((int)size.x);
			prim.show();
			stop_matrix() ;
		} else if (this.get_type() == HEPTAGON_ROPE) {
			if(prim == null) prim = new R_Primitive(papplet,7);
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			prim.size((int)size.x);
			prim.show();
			stop_matrix();
		} else if (this.get_type() == OCTOGON_ROPE) {
			if(prim == null) prim = new R_Primitive(papplet,8);
			start_matrix();
			translate(pos);
			rotate_behavior(rot) ;
			prim.size((int)size.x);
			prim.show();
			stop_matrix();
		} else if (this.get_type() == NONAGON_ROPE) {
			if(prim == null) prim = new R_Primitive(papplet,9);
			start_matrix();
			translate(pos);
			rotate_behavior(rot) ;
			prim.size((int)size.x);
			prim.show();
			stop_matrix();
		} else if (this.get_type() == DECAGON_ROPE) {
			if(prim == null) prim = new R_Primitive(papplet,10);
			start_matrix();
			translate(pos);
			rotate_behavior(rot) ;
			prim.size((int)size.x);
			prim.show();
			stop_matrix();
		} else if (this.get_type() == HENDECAGON_ROPE) {
			if(prim == null) prim = new R_Primitive(papplet,11);
			start_matrix();
			translate(pos);
			rotate_behavior(rot) ;
			prim.size((int)size.x);
			prim.show();
			stop_matrix();
		} else if (this.get_type() == DODECAGON_ROPE) {
			if(prim == null) prim = new R_Primitive(papplet,12);
			start_matrix();
			translate(pos);
			rotate_behavior(rot) ;
			prim.size((int)size.x);
			prim.show();
			stop_matrix();
		}

		else if (this.get_type() == CROSS_RECT_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			cross_rect(ivec2(0),(int)size.y,(int)size.x);
			stop_matrix() ;
		} else if (this.get_type() == CROSS_BOX_2_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			//cross_box_2(vec2(size.x, size.y),ratio_size);
			cross_box_2(vec2(size.x, size.y));
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
			polyhedron("TETRAHEDRON","VERTEX",(int)size.x);
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
			if(get_summit() == 0 ) set_summit(5);
			star_summits(get_summit());
			star(vec3(),size);
			stop_matrix();
		} else if (this.get_type() == STAR_3D_ROPE) {
			float [] ratio = {.38};
			start_matrix();
			translate(pos);
			rotate_behavior(rot);

			star_3D_is(true);
			if(get_summit() == 0 ) set_summit(5);
			star_summits(get_summit());
			star(vec3(),size);
			stop_matrix();
		}


		else if (this.get_type() == FLOWER_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			// int num_petals = 3;
			// println(get_summit(),frameCount);
			if(get_summit() == 0 ) set_summit(5);
			if(get_pair() == null || get_pair().length != get_summit()*2) {
				pair = new vec2[get_summit()*2];
			}
			if(get_strength() == null || get_strength().length != get_summit()*2) {
				strength = new float[get_summit()*2];
			}

			for(int i = 0 ; i < get_summit()*2 ; i++) {
				vec2 value = vec2(.1,.1);
				// if(i >= get_summit()) value.set(value.yx());
				if(pair[i] == null) {
					pair[i] = vec2(value);
				} else {
					pair[i].set(value);
				}
				strength[i] = 1.;
			}

			for(int i = 0 ; i < get_summit() ; i++) {
				flower_static(pair[i],strength[i],pair[i+get_summit()],strength[i+get_summit()]);
				//flower_wind(pair[i],strength[i],pair[i+get_summit()],strength[i+get_summit()]);
			}
			flower(vec3(),(int)size.x,get_summit());
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

		else if(this.get_type() == HOUSE_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			house(size);
			stop_matrix();
		}


	  else if(this.get_type() == VIRUS_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			virus(vec3(),size,0,-1);
			stop_matrix();
		}



		else if(this.get_type() < 0) {
			start_matrix() ;
			translate(pos) ;
			rotate_behavior(rot) ;
			for(int i = 0 ; i < costume_pic_list.size() ; i++) {
				Costume_pic p = costume_pic_list.get(i);
				if(p.get_id() == this.get_type()) {
					if(p.get_type() == 1) {
						PImage img_temp = p.get_img().copy();
						if(size.x == size.y ) {
							img_temp.resize((int)size.x, 0);
						} else if (size.x != size.y) {
							img_temp.resize((int)size.x, (int)size.y);
						}
						image(img_temp,0,0);
						break ;
					} else if(p.get_type() == 2) {
						vec2 scale = vec2(1) ;
						if(size.x == size.y) {
	            scale = vec2(size.x / p.get_svg().width(), size.x / p.get_svg().width());
						} else {
							scale = vec2(size.x / p.get_svg().width(), size.y / p.get_svg().height());
						}
						
						p.get_svg().scaling(scale) ;
						p.get_svg().draw() ;
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
* COSTUME PIC CLASS
* v 0.0.2
* 2014-2019
*/
public class Costume_pic {
	PImage img ;
	ROPE_svg svg ;
	int type = -1 ; 
	String name ;
	int id;
	public Costume_pic(PApplet p5, String path, int id) {
		// add png
		if(path.endsWith("png") || path.endsWith("PNG")) {
			img = loadImage(path) ;
			type = 1;
		}

		// add svg
		if(path.endsWith("svg") || path.endsWith("SVG")) {
			svg = new ROPE_svg(p5,path);
			svg.mode(CENTER) ;
			svg.build() ;
			type = 2 ;
		}
		
		String [] split = path.split("/") ;
		name = split[split.length -1] ;
		name = name.substring(0,name.lastIndexOf(".")) ;
		this.id = id;
	}
  
  // get
	int get_id() {
		return id;
	}

	int get_type() {
		return type;
	}

	ROPE_svg get_svg() {
		return svg;
	}

	PImage get_img() {
		return img;
	}

	String get_name() {
		return name;
	}
}

























/**
Class House
2019-2019
v 0.0.7
*/
public class House {
	private int fill_roof = r.BLOOD;
	private int fill_wall = r.GRAY[6];
	private int fill_ground = r.BLACK;
	private int stroke_roof = r.BLACK;
	private int stroke_wall = r.BLACK;
	private int stroke_ground = r.BLACK;
	private float thickness = 1;
	private boolean aspect_is;

	private int level;
	private vec3 pos;
	private vec3 size;
	private boolean roof_ar, roof_cr; // to draw or not the small roof side
	private vec3 offset = vec3(-.5,0,.5); // to center the house; 

  private vec3 [] pa;
	private vec3 [] pc;

	private int type = CENTER;
	public House() {
		build();
	}
  
  public House(float size) {
  	this.size = vec3(size);
		build();
	}

	public House(float sx, float sy, float sz) {
		this.size = vec3(sx,sy,sz);
		build();
	}

	public void mode(int type) {
		this.type = type;
	}

	public void set_pos(vec3 pos) {
		if(this.pos == null) {
			this.pos = pos.copy();
		} else {
			this.pos.set(pos);
		}
	}

	public void set_size(vec3 size) {
		if(this.size == null) {
			this.size = size.copy();
		} else {
			this.size.set(size);
		}
	}

	private void set_peak(float ra, float rc) {
		// check if this peak configuration is permitted
		if(ra + rc > 1.) {
			if(ra>rc) {
				ra = 1.-rc; 
			} else {
				rc = 1.-ra;
			}
		}

		if(ra > 0.) {
			roof_ar = true;
			if(pa != null && pa[0] != null) {
				pa[0].x = 1.-ra+offset.x;
			}
		}

		if(rc > 0.) {
			roof_cr = true;
			if(pc != null && pc[0] != null) {
				pc[0].x = rc+offset.x;
			}
		}
	}
  // aspect
  // fill
  public void set_fill(int c) {
  	aspect_is = true;
  	fill_roof = fill_wall = fill_ground = c;
  }

  public void set_fill_roof(int c) {
		aspect_is = true;
		fill_roof = c;
	}

	public void set_fill_wall(int c) {
		aspect_is = true;
		fill_wall = c;
	}

	public void set_fill_ground(int c) {
		aspect_is = true;
		fill_ground = c;
	}

	public void set_fill(float x, float y, float z, float a) {
		set_fill(color(x,y,z,a));
	}

	public void set_fill_roof(float x, float y, float z, float a) {
		set_fill_roof(color(x,y,z,a));
	}

	public void set_fill_wall(float x, float y, float z, float a) {
		set_fill_wall(color(x,y,z,a));
	}

	public void set_fill_ground(float x, float y, float z, float a) {
		set_fill_ground(color(x,y,z,a));
	}

  // stroke
	public void set_stroke(int c) {
  	aspect_is = true;
  	stroke_roof = stroke_wall = stroke_ground = c;
  }

  public void set_stroke_roof(int c) {
		aspect_is = true;
		stroke_roof = c;
	}

	public void set_stroke_wall(int c) {
		aspect_is = true;
		stroke_wall = c;
	}

	public void set_stroke_ground(int c) {
		aspect_is = true;
		stroke_ground = c;
	}

	public void set_stroke(float x, float y, float z, float a) {
		set_stroke(color(x,y,z,a));
	}

	public void set_stroke_roof(float x, float y, float z, float a) {
		set_stroke_roof(color(x,y,z,a));
	}

	public void set_stroke_wall(float x, float y, float z, float a) {
		set_stroke_wall(color(x,y,z,a));
	}

	public void set_stroke_ground(float x, float y, float z, float a) {
		set_stroke_ground(color(x,y,z,a));
	}

	public void set_thickness(float thickness) {
		aspect_is = true;
		this.thickness = thickness;
	}

	public void aspect_is(boolean is) {
		this.aspect_is = is;
	}

  
  // build
	private void build() {
		pa = new vec3[5];
		pc = new vec3[5];
		
		pa[0] = vec3(1,-1,-0.5); // roof peak
		pa[1] = vec3(1,0,-1);
		pa[2] = vec3(1,1,-1);
		pa[3] = vec3(1,1,0);
		pa[4] = vec3(1,0,0);

		pc[0] = vec3(0,-1,-0.5); // roof peak
		pc[1] = vec3(0,0,-1);
		pc[2] = vec3(0,1,-1);
		pc[3] = vec3(0,1,0);
		pc[4] = vec3(0,0,0);

		for(int i = 0 ; i < pa.length ; i++) {
			pa[i].add(offset);
			pc[i].add(offset);
		}
	}
  

	public void show() {
		float smallest_size = 0;
		for(int i = 0 ; i < 3 ; i++) {
			if(smallest_size == 0 || smallest_size > size.array()[i]) {
				smallest_size = size.array()[i];
			}
		}

    // DEFINE FINAL OFFSET
    vec3 def_pos = null;
	  if(this.type == TOP) {
	  	if(pos == null) {
	  		def_pos = vec3();
	  		def_pos.add(vec3(0,size.y*.5,0));
	  	} else {
	  		def_pos = pos.copy();
	  		def_pos.add(vec3(0,size.y*.5,0));		
	  	}
	  } else if(this.type == BOTTOM) {
	  	if(pos == null) {
	  		def_pos = vec3();
	  		def_pos.add(vec3(0,-size.y,0));
	  	} else {
	  		def_pos = pos.copy();
	  		def_pos.add(vec3(0,-size.y,0));		
	  	}
	  }



	  // WALL
	  if(aspect_is) {
	  	aspect(fill_wall,stroke_wall,thickness);
	  }
		// draw A : WALL > small and special side
		beginShape();
		if(def_pos == null) {
			if(!roof_ar) {
				vertex(pa[0].copy().mult(vec3(size.x,smallest_size,size.z))); // special point for the roof peak
			}
			for(int i = 1 ; i < pa.length ; i++) {
				vertex(pa[i].copy().mult(size));
			}
		} else {
			if(!roof_ar) {
				vertex(pa[0].copy().mult(vec3(size.x,smallest_size,size.z)).add(def_pos)); // special point for the roof peak
			}
			for(int i = 1 ; i < pa.length ; i++) {
				vertex(pa[i].copy().mult(size).add(def_pos));
			}
		}
		endShape(CLOSE);


	  // draw B : WALL > main wall
	  beginShape();
		if(def_pos == null) {
			vertex(pa[2].copy().mult(size));
			vertex(pa[1].copy().mult(size));
			vertex(pc[1].copy().mult(size));
			vertex(pc[2].copy().mult(size));
		} else {
			vertex(pa[2].copy().mult(size).add(def_pos));
			vertex(pa[1].copy().mult(size).add(def_pos));
			vertex(pc[1].copy().mult(size).add(def_pos));
			vertex(pc[2].copy().mult(size).add(def_pos));
		}
		endShape(CLOSE);

	  // draw C : WALL > small and special side
		beginShape();
		if(def_pos == null) {
			if(!roof_cr) {
				vertex(pc[0].copy().mult(vec3(size.x,smallest_size,size.z))); // special point for the roof peak
			}
			for(int i = 1 ; i < pc.length ; i++) {
				vertex(pc[i].copy().mult(size));
			}
		} else {
			if(!roof_cr) {
				vertex(pc[0].copy().mult(vec3(size.x,smallest_size,size.z)).add(def_pos)); // special point for the roof peak
			}
			for(int i = 1 ; i < pc.length ; i++) {
				vertex(pc[i].copy().mult(size).add(def_pos));
			}	
		}
		endShape(CLOSE);

		// draw D : WALL > main wall
		beginShape();
		if(def_pos == null) {
			vertex(pa[3].copy().mult(size));
			vertex(pa[4].copy().mult(size));
			vertex(pc[4].copy().mult(size));
			vertex(pc[3].copy().mult(size));
		} else {
			vertex(pa[3].copy().mult(size).add(def_pos));
			vertex(pa[4].copy().mult(size).add(def_pos));
			vertex(pc[4].copy().mult(size).add(def_pos));
			vertex(pc[3].copy().mult(size).add(def_pos));
		}
		endShape(CLOSE);





    // GROUND
    if(aspect_is) {
	  	aspect(fill_ground,stroke_ground,thickness);
	  }
		// draw G : GROUND
		beginShape();
		if(def_pos == null) {
			vertex(pa[2].copy().mult(size));
			vertex(pc[2].copy().mult(size));
			vertex(pc[3].copy().mult(size));
			vertex(pa[3].copy().mult(size));
		} else {
			vertex(pa[2].copy().mult(size).add(def_pos));
			vertex(pc[2].copy().mult(size).add(def_pos));
			vertex(pc[3].copy().mult(size).add(def_pos));
			vertex(pa[3].copy().mult(size).add(def_pos));
		}
		endShape(CLOSE);



    // ROOF
    if(aspect_is) {
	  	aspect(fill_roof,stroke_roof,thickness);
	  }
    // draw E : ROOF > main roof
		beginShape();
		if(def_pos == null) {
			vertex(pa[4].copy().mult(size));
			vertex(pa[0].copy().mult(vec3(size.x,smallest_size,size.z))); // special point for the roof peak
			vertex(pc[0].copy().mult(vec3(size.x,smallest_size,size.z))); // special point for the roof peak
			vertex(pc[4].copy().mult(size));			
		} else {
			vertex(pa[4].copy().mult(size).add(def_pos));
			vertex(pa[0].copy().mult(vec3(size.x,smallest_size,size.z)).add(def_pos)); // special point for the roof peak
			vertex(pc[0].copy().mult(vec3(size.x,smallest_size,size.z)).add(def_pos)); // special point for the roof peak
			vertex(pc[4].copy().mult(size).add(def_pos));
		}
		endShape(CLOSE);

		// draw F : ROOF > main roof
		beginShape();
		if(def_pos == null) {
			vertex(pa[0].copy().mult(vec3(size.x,smallest_size,size.z))); // special point for the roof peak
			vertex(pa[1].copy().mult(size));
			vertex(pc[1].copy().mult(size));
			vertex(pc[0].copy().mult(vec3(size.x,smallest_size,size.z))); // special point for the roof peak
		} else {
			vertex(pa[0].copy().mult(vec3(size.x,smallest_size,size.z)).add(def_pos)); // special point for the roof peak
			vertex(pa[1].copy().mult(size).add(def_pos));
			vertex(pc[1].copy().mult(size).add(def_pos));
			vertex(pc[0].copy().mult(vec3(size.x,smallest_size,size.z)).add(def_pos)); // special point for the roof peak
		}
		endShape(CLOSE);

		// DRAW AR  > small side roof
		if(roof_ar) {
			beginShape();
			if(def_pos == null) {
				vertex(pa[0].copy().mult(vec3(size.x,smallest_size,size.z))); // special point for the roof peak
				vertex(pa[1].copy().mult(size));
				vertex(pa[4].copy().mult(size));
			} else {
				vertex(pa[0].copy().mult(vec3(size.x,smallest_size,size.z)).add(def_pos)); // special point for the roof peak
				vertex(pa[1].copy().mult(size).add(def_pos));
				vertex(pa[4].copy().mult(size).add(def_pos));
			}
			endShape(CLOSE);
		}

		// DRAW CR > small side roof
		if(roof_cr) {
			beginShape();
			if(def_pos == null) {
				vertex(pc[0].copy().mult(vec3(size.x,smallest_size,size.z))); // special point for the roof peak
				vertex(pc[1].copy().mult(size));
				vertex(pc[4].copy().mult(size));
			} else {
				vertex(pc[0].copy().mult(vec3(size.x,smallest_size,size.z)).add(def_pos)); // special point for the roof peak
				vertex(pc[1].copy().mult(size).add(def_pos));
				vertex(pc[4].copy().mult(size).add(def_pos));
			}
			endShape(CLOSE);
		}
	}
}






































/**
CLASS VIRUS
2015-2018
v 0.2.0
*/
/*
public class Virus {
	vec3 [][] branch;
	vec3 size;
	vec3 pos ;
	int node = 4;
	int num = 4;
	int mutation = 4;

	float angle = 0 ;
	public Virus() {
		size = vec3(1);
		pos = vec3(0);
		set_branch();
	}

  // set
	private void set_branch() {
		branch = new vec3 [node][num] ;
		for(int i = 0 ; i < node ; i++) {
			for(int k = 0 ; k < num ; k++) {
				vec3 dir = vec3().rand(-1,1);
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
				vec3 dir = vec3().rand(-1,1);
				branch[i][k].set(projection(dir)) ;
			}
		}
	}
  
  // set
  public void set_size(vec s) {
  	vec3 final_size = vec3(1) ;
		if(s instanceof vec2) {
			vec2 size_temp = (vec2) s ;
			final_size.set(size_temp.x, size_temp.y, 1) ;
		} else if (s instanceof vec3) {
			vec3 size_temp = (vec3) s ;
			final_size.set(size_temp) ;
		}
		size.set(final_size) ;
	}

	public void set_pos(vec p) {
  	vec3 final_pos = vec3() ;
		if(p instanceof vec2) {
			vec2 pos_temp = (vec2) p ;
			final_pos.set(pos_temp.x, pos_temp.y, 1) ;
		} else if (p instanceof vec3) {
			vec3 pos_temp = (vec3) p ;
			final_pos.set(pos_temp) ;
		}
		pos.set(final_pos) ;
	}
  

  public void rotation(float angle) {
  	this.angle = angle ;
  	// System.err.println("Virus rotation() don't work must be coded for the future") ;
  }

	public vec2 angle(float angle) {
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
				vec3 final_pos_a = branch[0][k].copy() ;
				final_pos_a.add(angle(angle)) ;
				final_pos_a.mult(size) ;
				if(angle == 0) final_pos_a.add(pos) ;

				vec3 final_pos_b = branch[1][k].copy() ;
				final_pos_b.mult(size) ;
				if(angle == 0) final_pos_b.add(pos) ;
				line(final_pos_a, final_pos_b) ;
			} else if( node > 2) {
				beginShape() ;
				for(int m = 0 ; m < node ; m++) {
					vec3 final_pos = branch[m][k].copy() ;
					final_pos.mult(size) ;
					if(angle == 0) final_pos.add(pos) ;
					vertex(final_pos) ;
				}
				if(close == CLOSE) endShape(CLOSE) ; else endShape() ;
			} else {
				vec3 final_pos = branch[0][k].copy() ;
				//final_pos.add(angle(angle)) ;
				final_pos.mult(size) ;
				if(angle == 0) final_pos.add(pos) ;
				point(final_pos) ;
			}
		}
		if(angle != 0) stop_matrix() ;
	}
  
  // get
	public vec3 [][] get() {
		return branch ;
	}
}

*/





















