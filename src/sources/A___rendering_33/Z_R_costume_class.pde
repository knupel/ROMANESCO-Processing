/**
* COSTUME classes
* Copyleft (c) 2019-2019
* v 0.10.3
* @author @stanlepunk
* @see https://github.com/StanLepunK/Rope_framework
* Here you finf the class Costume and all the class shape used.
* Processing 3.5.3.269
* Rope Library 0.8.3.28
*/












final int POINT = 2; // processing value

final int LINE = 4; // processing value

final int TRIANGLE = 13;
final int SQUARE = 14;
final int PENTAGON = 15;
final int HEXAGON = 16;
final int HEPTAGON = 17;
final int OCTOGON = 18;
final int NONAGON = 19;
final int DECAGON = 20;
final int HENDECAGON = 21;
final int DODECAGON = 22;

final int TEXT_ROPE = 26;

final int RECT = 30; // processing value
final int ELLIPSE = 31; // processing value
final int ARC = 32;  // processing value

final int SPHERE = 40; // processing value
final int BOX = 41; // processing value

final int CROSS_RECT = 52;
final int CROSS_BOX_2 = 53;
final int CROSS_BOX_3 = 54;

final int SPHERE_LOW = 100;
final int SPHERE_MEDIUM = 101;
final int SPHERE_HIGH = 102;
final int TETRAHEDRON = 103;

final int PIXEL = 800;

final int STAR = 805;
final int STAR_3D = 806;

final int FLOWER = 900;

final int TETRAHEDRON_LINE = 1001;
final int CUBE_LINE = 1002;
final int OCTOHEDRON_LINE = 1003;
final int RHOMBIC_COSI_DODECAHEDRON_SMALL_LINE = 1004;
final int ICOSI_DODECAHEDRON_LINE = 1005;

final int HOUSE = 2000;

final int VIRUS = 88_888_888;





















/**
class Costume 
2018-2019
v 0.6.0
*/
import rope.costume.R_Primitive;
public class Costume {
	PGraphics other;

	boolean fill_is;
	boolean stroke_is;
	boolean alpha_is;

	vec3 pos;
	vec3 size;
	vec3 angle;

	int fill;
	int stroke;
	float thickness = 1.;

  String name;
  String costume_text;
	int type;
	int node;
	int summits;
	int num;
	int mutation;
  // float angle;
	float [] ratio;
	float [] strength;
	vec2 [] pair;
	boolean is_3D = false;
	boolean is_vertex = true;
	R_Primitive prim;
	PApplet papplet;

	int align = LEFT;

	public Costume(PApplet pa) {
		this.papplet = pa;
	}

	public Costume(PApplet pa, int type) {
		this.papplet = pa;
		this.type = type;
	}

	public Costume(PApplet pa, String costume_text) {
		this.papplet = pa;
		this.type = TEXT_ROPE;
		this.costume_text = costume_text;
	}


	public void pos(float x, float y, float z) {
		if(pos == null) {
			pos = vec3(x,y,z);
		} else {
			pos.set(x,y,z);
		}
	}




	public void size(float x, float y, float z) {
		if(size == null) {
			size = vec3(x,y,z);
		} else {
			size.set(x,y,z);
		}
	}

	public void angle(float x, float y, float z) {
		if(angle == null) {
			angle = vec3(x,y,z);
		} else {
			angle.set(x,y,z);
		}
	}

	public void pass_graphic(PGraphics other) {
  	if(other != null) {
  		this.other = other;
  	}
  }
  
  // set
  public void set_text(String costume_text) {
		this.costume_text = costume_text;
	}

  public void set_name(String name) {
		this.name = name;
	}

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

	public void set_align(int align) {
		this.align = align;
	} 

/*
	public void set_angle(float angle) {
		this.angle = angle;
	}
	*/

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

	public vec3 pos() {
		return pos;
	}

	public vec3 size() {
		return size;
	}

	public vec3 angle() {
		return angle;
	}


	public int get_fill() {
		return fill;
	}

	public int get_stroke() {
		return stroke;
	}

	public float get_thickness() {
		return thickness;
	}
  
  public String get_name() {
  	return name;
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
  /*
	public float get_angle() {
		return angle;
	}
	*/

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

	public boolean alpha_is() {
		return this.alpha_is;
	}






	// ASPECT
	public void fill_is(boolean fill_is) {
		this.fill_is = fill_is;
	}

	public void stroke_is(boolean stroke_is) {
		this.stroke_is = stroke_is;
	}

	public void alpha_is(boolean alpha_is) {
		this.alpha_is = alpha_is;
	}

	public void aspect_is(boolean fill_is, boolean stroke_is, boolean alpha_is) {
		this.fill_is = fill_is;
		this.stroke_is = stroke_is;
		this.alpha_is = alpha_is;
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
		} else if(costume != r.NULL || costume != POINT) {
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

	public void aspect(vec fill, vec stroke, float thickness, Costume costume) {
		aspect(fill,stroke,thickness,costume.get_type());
	}


	public void aspect(vec fill, vec stroke, float thickness, int costume) {
	  if(costume == r.NULL) {
	    // 
		} else if(costume != r.NULL || costume != POINT) {
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
			if(alpha_is()) {
				this.fill = color(c.x(),c.x(),c.x(),c.y());
			} else { 
				this.fill = color(c.x(),c.x(),c.x(),g.colorModeA);
			}
			fill(this.fill);
		} else if(arg instanceof vec3) {
			vec3 c = (vec3)arg;
			this.fill = color(c.x(),c.y(),c.z(),g.colorModeA);
			fill(this.fill);
		} else if(arg instanceof vec4) {
			vec4 c = (vec4)arg;
			if(alpha_is()) {
				this.fill = color(c.x(),c.y(),c.z(),c.w());
			} else {
				this.fill = color(c.x(),c.y(),c.z(),g.colorModeA);
			}
			fill(this.fill);
		} else if(arg instanceof Integer) {
			int c = (int)arg;
			if(alpha_is()) {
				fill(c);	
			} else {
				if(g.colorMode == 3) {
					this.fill = color(hue(c),saturation(c),brightness(c),g.colorModeA);
				} else {
					this.fill = color(red(c),green(c),blue(c),g.colorModeA);
				}
				fill(this.fill);
			}
			
		}
	}

	private void manage_stroke(Object arg) {
		if(arg instanceof vec2) {
			vec2 c = (vec2)arg;
			if(alpha_is()) {
				this.stroke = color(c.x(),c.x(),c.x(),c.y());
			} else {
				this.stroke = color(c.x(),c.x(),c.x(),g.colorModeA);
			}
			stroke(this.stroke);
		} else if(arg instanceof vec3) {
			vec3 c = (vec3)arg;
			this.stroke = color(c.x(),c.y(),c.z(),g.colorModeA);
			stroke(this.stroke);
		} else if(arg instanceof vec4) {
			vec4 c = (vec4)arg;
			if(alpha_is()) {
				this.stroke = color(c.x(),c.y(),c.z(),c.w());
			} else {
				this.stroke = color(c.x(),c.y(),c.z(),g.colorModeA);
			}			
			stroke(this.stroke);
		} else if(arg instanceof Integer) {
			int c = (int)arg;
			if(alpha_is()) {
				stroke(c);	
			} else {
				if(g.colorMode == 3) {
					this.stroke = color(hue(c),saturation(c),brightness(c),g.colorModeA);
				} else {
					this.stroke = color(red(c),green(c),blue(c),g.colorModeA);
				}
				stroke(this.stroke);
			}
		}
	}


	private void manage_thickness(float thickness) {
		this.thickness = thickness;
		strokeWeight(this.thickness);
	}


	public void show() {
		show(pos,size,angle);
	}

	public void show(vec3 pos, vec3 size, vec rot) {
		if(rot.x() != 0) costume_rotate_x();
		if(rot.y() != 0) costume_rotate_y();
		if(rot.z() != 0) costume_rotate_z();

		if (this.get_type() == PIXEL) {
			set((int)pos.x(),(int)pos.y(),(int)get_fill_rope(),other);
		} else if (this.get_type() == POINT) {
	    strokeWeight(size.x(),other);
			point(pos,other);
		} else if (this.get_type() == ELLIPSE) {
			push(other);
			translate(pos,other);
			costume_rotate(rot,other);
			ellipse(vec2(),vec2(size),other);
			pop(other);

		} else if (this.get_type() == RECT) {
			push(other);
			translate(pos,other);
			costume_rotate(rot,other);
			rect(vec2(-size.x(),-size.y()).div(2),vec2(size.x(),size.y()),other);
			pop(other);

		} else if (this.get_type() == LINE) {
			if(prim == null) prim = new R_Primitive(papplet,2);
			push(other);
			translate(pos,other);
			costume_rotate(rot,other);
			prim.pass_graphic(other);
			prim.size((int)size.x());
			prim.show();
			pop(other);
		}

		else if (this.get_type() == TRIANGLE) {
			if(prim == null) prim = new R_Primitive(papplet,3);
			push(other);
			translate(pos,other);
			costume_rotate(rot,other);
			prim.pass_graphic(other);
			prim.size((int)size.x());
			prim.show();
			pop(other);
		}  else if (this.get_type() == SQUARE) {
			if(prim == null) prim = new R_Primitive(papplet,4);
			push(other);
			translate(pos,other);
			costume_rotate(rot,other);
			prim.pass_graphic(other);
			prim.size((int)size.x());
			prim.show();
			pop(other);
		} else if (this.get_type() == PENTAGON) {
			if(prim == null) prim = new R_Primitive(papplet,5);
			push(other);
			translate(pos,other);
			costume_rotate(rot,other);
			prim.pass_graphic(other);
			prim.size((int)size.x());
			prim.show();
			pop(other);
		} else if (this.get_type() == HEXAGON) {
			if(prim == null) prim = new R_Primitive(papplet,6);
			push(other);
			translate(pos,other);
			costume_rotate(rot,other);
			prim.pass_graphic(other);
			prim.size((int)size.x());
			prim.show();
			pop(other);
		} else if (this.get_type() == HEPTAGON) {
			if(prim == null) prim = new R_Primitive(papplet,7);
			push(other);
			translate(pos,other);
			costume_rotate(rot,other);
			prim.pass_graphic(other);
			prim.size((int)size.x());
			prim.show();
			pop(other);
		} else if (this.get_type() == OCTOGON) {
			if(prim == null) prim = new R_Primitive(papplet,8);
			push(other);
			translate(pos,other);
			costume_rotate(rot,other);
			prim.pass_graphic(other);
			prim.size((int)size.x());
			prim.show();
			pop(other);
		} else if (this.get_type() == NONAGON) {
			if(prim == null) prim = new R_Primitive(papplet,9);
			push(other);
			translate(pos,other);
			costume_rotate(rot,other);
			prim.pass_graphic(other);
			prim.size((int)size.x());
			prim.show();
			pop(other);
		} else if (this.get_type() == DECAGON) {
			if(prim == null) prim = new R_Primitive(papplet,10);
			push(other);
			translate(pos,other);
			costume_rotate(rot,other);
			prim.pass_graphic(other);
			prim.size((int)size.x());
			prim.show();
			pop(other);
		} else if (this.get_type() == HENDECAGON) {
			if(prim == null) prim = new R_Primitive(papplet,11);
			push(other);
			translate(pos,other);
			costume_rotate(rot,other);
			prim.pass_graphic(other);
			prim.size((int)size.x());
			prim.show();
			pop(other);
		} else if (this.get_type() == DODECAGON) {
			if(prim == null) prim = new R_Primitive(papplet,12);
			push(other);
			translate(pos,other);
			costume_rotate(rot,other);
			prim.pass_graphic(other);
			prim.size((int)size.x());
			prim.show();
			pop(other);
		}

		else if (this.get_type() == CROSS_RECT) {
			push(other);
			translate(pos,other);
			costume_rotate(rot,other);
			cross_rect(ivec2(0),(int)size.y(),(int)size.x(),other);
			pop(other) ;
		} else if (this.get_type() == CROSS_BOX_2) {
			push(other);
			translate(pos,other);
			costume_rotate(rot,other);
			cross_box_2(vec2(size.x(), size.y()),other);
			pop(other) ;
		} else if (this.get_type() == CROSS_BOX_3) {
			push(other);
			translate(pos,other);
			costume_rotate(rot,other);
			cross_box_3(size,other);
			pop(other);
		}



	  else if(this.get_type() == TEXT_ROPE) {
	  	push(other);
	  	translate(pos,other);
	  	costume_rotate(rot,other);
	  	textAlign(align,other);
	  	textSize(size.x(),other);
	  	text(costume_text,0,0,other);
	  	pop(other);
	  }

		else if (this.get_type() == SPHERE_LOW) {
			push(other);
			translate(pos,other);
			costume_rotate(rot,other);
			sphereDetail(5,other);
			sphere(size.x(),other);
			pop(other);
		} else if (this.get_type() == SPHERE_MEDIUM) {
			push(other);
			translate(pos,other);
			costume_rotate(rot,other);
			sphereDetail(12,other);
			sphere(size.x(),other);
			pop(other);
		} else if (this.get_type() == SPHERE_HIGH || this.get_type() == SPHERE) {
			push(other);
			translate(pos,other);
			costume_rotate(rot,other);
			sphere(size.x(),other);
			pop(other);
		} else if (this.get_type() == TETRAHEDRON) {
			push(other);
			translate(pos,other);
			costume_rotate(rot,other);
			polyhedron("TETRAHEDRON","VERTEX",(int)size.x,other);
			pop(other);
		} else if (this.get_type() == BOX) {
			push(other);
			translate(pos,other);
			costume_rotate(rot,other);
			box(size,other);
			pop(other);
		}

		else if (this.get_type() == STAR) {
			float [] ratio = {.38};
			push(other);
			translate(pos,other);
			costume_rotate(rot,other);

			star_3D_is(false);
			if(get_summit() == 0 ) set_summit(5);
			star_summits(get_summit());
			star(vec3(),size,other);
			pop(other);
		} else if (this.get_type() == STAR_3D) {
			float [] ratio = {.38};
			push(other);
			translate(pos,other);
			costume_rotate(rot,other);

			star_3D_is(true);
			if(get_summit() == 0 ) set_summit(5);
			star_summits(get_summit());
			star(vec3(),size,other);
			pop(other);
		}


		else if (this.get_type() == FLOWER) {
			push(other);
			translate(pos,other);
			costume_rotate(rot,other);
			if(get_summit() == 0 ) set_summit(5);
			if(get_pair() == null || get_pair().length != get_summit()*2) {
				pair = new vec2[get_summit()*2];
			}
			if(get_strength() == null || get_strength().length != get_summit()*2) {
				strength = new float[get_summit()*2];
			}

			for(int i = 0 ; i < get_summit()*2 ; i++) {
				vec2 value = vec2(.1,.1);
				if(pair[i] == null) {
					pair[i] = vec2(value);
				} else {
					pair[i].set(value);
				}
				strength[i] = 1.;
			}

			for(int i = 0 ; i < get_summit() ; i++) {
				flower_static(pair[i],strength[i],pair[i+get_summit()],strength[i+get_summit()]);
			}
			flower(vec3(),(int)size.x,get_summit(),other);
			pop(other);
		}


		else if (this.get_type() == TETRAHEDRON_LINE) {
			push(other);
			translate(pos,other);
			costume_rotate(rot,other);
			polyhedron("TETRAHEDRON","LINE",(int)size.x(),other);
			pop(other);
		} else if (this.get_type() == CUBE_LINE) {
			push(other);
			translate(pos,other);
			costume_rotate(rot,other);
			polyhedron("CUBE","LINE",(int)size.x(),other);
			pop(other);
		} else if (this.get_type() == OCTOHEDRON_LINE) {
			push(other);
			translate(pos,other);
			costume_rotate(rot,other);
			polyhedron("OCTOHEDRON","LINE",(int)size.x(),other);
			pop(other);
		} else if (this.get_type() == RHOMBIC_COSI_DODECAHEDRON_SMALL_LINE) {
			push(other);
			translate(pos,other);
			costume_rotate(rot,other);
			polyhedron("RHOMBIC COSI DODECAHEDRON SMALL","LINE",(int)size.x(),other);
			pop(other);
		} else if (this.get_type() == ICOSI_DODECAHEDRON_LINE) {
			push(other);
			translate(pos,other);
			costume_rotate(rot,other);
			polyhedron("ICOSI DODECAHEDRON","LINE",(int)size.x(),other);
			pop(other);
		}

		else if(this.get_type() == HOUSE) {
			push(other);
			translate(pos,other);
			costume_rotate(rot,other);
			if(size.z() == 1) {
				house(size.xyy(),other);
			} else {
				house(size.xyz(),other);
			}
			
			pop(other);
		}


	  else if(this.get_type() == VIRUS) {
			push();
			translate(pos);
			costume_rotate(rot);
			virus(vec3(),size,0,-1);
			pop();
		}



		else if(this.get_type() < 0) {
			push() ;
			translate(pos) ;
			costume_rotate(rot) ;
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
			pop() ;
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
v 0.2.1
*/
public class House extends R_Shape  {
	private int fill_roof = r.BLOOD;
	private int fill_wall = r.GRAY[6];
	private int fill_ground = r.BLACK;
	private int stroke_roof = r.BLACK;
	private int stroke_wall = r.BLACK;
	private int stroke_ground = r.BLACK;
	private float thickness = 1;
	private boolean aspect_is;

	private int level;
	// private vec3 pos;
	private boolean roof_ar, roof_cr; // to draw or not the small roof side
	private vec3 offset = vec3(-.5,0,.5); // to center the house; 

  private vec3 [] pa;
	private vec3 [] pc;

	private int type = CENTER;
	
	public House(PApplet pa) {
		super(pa);
		build();
	}
  
  public House(PApplet pa, float size) {
  	super(pa);
  	size(size);
		build();
	}

	public House(PApplet pa, float sx, float sy, float sz) {
		super(pa);
		size(sx,sy,sz);
		build();
	}
	

	public void mode(int type) {
		this.type = type;
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
		beginShape(other);
		if(def_pos == null) {
			if(!roof_ar) {
				vertex(pa[0].copy().mult(vec3(size.x,smallest_size,size.z)),other); // special point for the roof peak
			}
			for(int i = 1 ; i < pa.length ; i++) {
				vertex(pa[i].copy().mult(size),other);
			}
		} else {
			if(!roof_ar) {
				vertex(pa[0].copy().mult(vec3(size.x,smallest_size,size.z)).add(def_pos),other); // special point for the roof peak
			}
			for(int i = 1 ; i < pa.length ; i++) {
				vertex(pa[i].copy().mult(size).add(def_pos),other);
			}
		}
		endShape(CLOSE,other);


	  // draw B : WALL > main wall
	  beginShape(other);
		if(def_pos == null) {
			vertex(pa[2].copy().mult(size),other);
			vertex(pa[1].copy().mult(size),other);
			vertex(pc[1].copy().mult(size),other);
			vertex(pc[2].copy().mult(size),other);
		} else {
			vertex(pa[2].copy().mult(size).add(def_pos),other);
			vertex(pa[1].copy().mult(size).add(def_pos),other);
			vertex(pc[1].copy().mult(size).add(def_pos),other);
			vertex(pc[2].copy().mult(size).add(def_pos),other);
		}
		endShape(CLOSE,other);

	  // draw C : WALL > small and special side
		beginShape(other);
		if(def_pos == null) {
			if(!roof_cr) {
				vertex(pc[0].copy().mult(vec3(size.x,smallest_size,size.z)),other); // special point for the roof peak
			}
			for(int i = 1 ; i < pc.length ; i++) {
				vertex(pc[i].copy().mult(size),other);
			}
		} else {
			if(!roof_cr) {
				vertex(pc[0].copy().mult(vec3(size.x,smallest_size,size.z)).add(def_pos),other); // special point for the roof peak
			}
			for(int i = 1 ; i < pc.length ; i++) {
				vertex(pc[i].copy().mult(size).add(def_pos),other);
			}	
		}
		endShape(CLOSE,other);

		// draw D : WALL > main wall
		beginShape(other);
		if(def_pos == null) {
			vertex(pa[3].copy().mult(size),other);
			vertex(pa[4].copy().mult(size),other);
			vertex(pc[4].copy().mult(size),other);
			vertex(pc[3].copy().mult(size),other);
		} else {
			vertex(pa[3].copy().mult(size).add(def_pos),other);
			vertex(pa[4].copy().mult(size).add(def_pos),other);
			vertex(pc[4].copy().mult(size).add(def_pos),other);
			vertex(pc[3].copy().mult(size).add(def_pos),other);
		}
		endShape(CLOSE,other);





    // GROUND
    if(aspect_is) {
	  	aspect(fill_ground,stroke_ground,thickness);
	  }
		// draw G : GROUND
		beginShape(other);
		if(def_pos == null) {
			vertex(pa[2].copy().mult(size),other);
			vertex(pc[2].copy().mult(size),other);
			vertex(pc[3].copy().mult(size),other);
			vertex(pa[3].copy().mult(size),other);
		} else {
			vertex(pa[2].copy().mult(size).add(def_pos),other);
			vertex(pc[2].copy().mult(size).add(def_pos),other);
			vertex(pc[3].copy().mult(size).add(def_pos),other);
			vertex(pa[3].copy().mult(size).add(def_pos),other);
		}
		endShape(CLOSE,other);



    // ROOF
    if(aspect_is) {
	  	aspect(fill_roof,stroke_roof,thickness);
	  }
    // draw E : ROOF > main roof
		beginShape(other);
		if(def_pos == null) {
			vertex(pa[4].copy().mult(size),other);
			vertex(pa[0].copy().mult(vec3(size.x,smallest_size,size.z)),other); // special point for the roof peak
			vertex(pc[0].copy().mult(vec3(size.x,smallest_size,size.z)),other); // special point for the roof peak
			vertex(pc[4].copy().mult(size),other);			
		} else {
			vertex(pa[4].copy().mult(size).add(def_pos),other);
			vertex(pa[0].copy().mult(vec3(size.x,smallest_size,size.z)).add(def_pos),other); // special point for the roof peak
			vertex(pc[0].copy().mult(vec3(size.x,smallest_size,size.z)).add(def_pos),other); // special point for the roof peak
			vertex(pc[4].copy().mult(size).add(def_pos),other);
		}
		endShape(CLOSE,other);

		// draw F : ROOF > main roof
		beginShape(other);
		if(def_pos == null) {
			vertex(pa[0].copy().mult(vec3(size.x,smallest_size,size.z)),other); // special point for the roof peak
			vertex(pa[1].copy().mult(size),other);
			vertex(pc[1].copy().mult(size),other);
			vertex(pc[0].copy().mult(vec3(size.x,smallest_size,size.z)),other); // special point for the roof peak
		} else {
			vertex(pa[0].copy().mult(vec3(size.x,smallest_size,size.z)).add(def_pos),other); // special point for the roof peak
			vertex(pa[1].copy().mult(size).add(def_pos),other);
			vertex(pc[1].copy().mult(size).add(def_pos),other);
			vertex(pc[0].copy().mult(vec3(size.x,smallest_size,size.z)).add(def_pos),other); // special point for the roof peak
		}
		endShape(CLOSE,other);

		// DRAW AR  > small side roof
		if(roof_ar) {
			beginShape(other);
			if(def_pos == null) {
				vertex(pa[0].copy().mult(vec3(size.x,smallest_size,size.z)),other); // special point for the roof peak
				vertex(pa[1].copy().mult(size),other);
				vertex(pa[4].copy().mult(size),other);
			} else {
				vertex(pa[0].copy().mult(vec3(size.x,smallest_size,size.z)).add(def_pos),other); // special point for the roof peak
				vertex(pa[1].copy().mult(size).add(def_pos),other);
				vertex(pa[4].copy().mult(size).add(def_pos),other);
			}
			endShape(CLOSE,other);
		}

		// DRAW CR > small side roof
		if(roof_cr) {
			beginShape(other);
			if(def_pos == null) {
				vertex(pc[0].copy().mult(vec3(size.x,smallest_size,size.z)),other); // special point for the roof peak
				vertex(pc[1].copy().mult(size),other);
				vertex(pc[4].copy().mult(size),other);
			} else {
				vertex(pc[0].copy().mult(vec3(size.x,smallest_size,size.z)).add(def_pos),other); // special point for the roof peak
				vertex(pc[1].copy().mult(size).add(def_pos),other);
				vertex(pc[4].copy().mult(size).add(def_pos),other);
			}
			endShape(CLOSE,other);
		}
	}
}
