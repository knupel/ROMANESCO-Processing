/**
COSTUME family class
* Copyleft (c) 2019-2019
* v 0.0.1
* @author Stan le Punk
* @see https://github.com/StanLepunK/Rope_method
* Here you finf the class Costume and all the class shape used.
*/

/**
Class House
2019-2019
v 0.0.4
*/
public class House {
	private int fill_roof = r.BLOOD;
	private int fill_wall = r.GRAY_3;
	private int fill_ground = r.BLACK;
	private int stroke_roof = r.BLACK;
	private int stroke_wall = r.BLACK;
	private int stroke_ground = r.BLACK;
	private float thickness = 1;
	private boolean aspect_is;

	private int level;
	private Vec3 pos;
	private Vec3 size;
	private boolean roof_ar, roof_cr; // to draw or not the small roof side
	private Vec3 offset = Vec3(-.5,0,.5); // to center the house; 

  private Vec3 [] pa;
	private Vec3 [] pc;
	public House() {
		build();
	}
  
  public House(float size) {
  	this.size = Vec3(size);
		build();
	}

	public House(float sx, float sy, float sz) {
		this.size = Vec3(sx,sy,sz);
		build();
	}

	public void set_pos(Vec3 pos) {
		if(this.pos == null) {
			this.pos = pos.copy();
		} else {
			this.pos.set(pos);
		}
	}

	public void set_size(Vec3 size) {
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
		pa = new Vec3[5];
		pc = new Vec3[5];
		
		pa[0] = Vec3(1,-1,-0.5); // roof peak
		pa[1] = Vec3(1,0,-1);
		pa[2] = Vec3(1,1,-1);
		pa[3] = Vec3(1,1,0);
		pa[4] = Vec3(1,0,0);

		pc[0] = Vec3(0,-1,-0.5); // roof peak
		pc[1] = Vec3(0,0,-1);
		pc[2] = Vec3(0,1,-1);
		pc[3] = Vec3(0,1,0);
		pc[4] = Vec3(0,0,0);

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

		// WALL
		if(aspect_is) {
	  	aspect(fill_wall,stroke_wall,thickness);
	  }
		// draw A : WALL > small and special side
		beginShape();
		if(pos == null) {
			if(!roof_ar) {
				vertex(pa[0].copy().mult(Vec3(size.x,smallest_size,size.z))); // special point for the roof peak
			}
			for(int i = 1 ; i < pa.length ; i++) {
				vertex(pa[i].copy().mult(size));
			}
		} else {
			if(!roof_ar) {
				vertex(pa[0].copy().mult(Vec3(size.x,smallest_size,size.z)).add(pos)); // special point for the roof peak
			}
			for(int i = 1 ; i < pa.length ; i++) {
				vertex(pa[i].copy().mult(size).add(pos));
			}
		}
		endShape(CLOSE);


	  // draw B : WALL > main wall
	  beginShape();
		if(pos == null) {
			vertex(pa[2].copy().mult(size));
			vertex(pa[1].copy().mult(size));
			vertex(pc[1].copy().mult(size));
			vertex(pc[2].copy().mult(size));
		} else {
			vertex(pa[2].copy().mult(size).add(pos));
			vertex(pa[1].copy().mult(size).add(pos));
			vertex(pc[1].copy().mult(size).add(pos));
			vertex(pc[2].copy().mult(size).add(pos));
		}
		endShape(CLOSE);

	  // draw C : WALL > small and special side
		beginShape();
		if(pos == null) {
			if(!roof_cr) {
				vertex(pc[0].copy().mult(Vec3(size.x,smallest_size,size.z))); // special point for the roof peak
			}
			for(int i = 1 ; i < pc.length ; i++) {
				vertex(pc[i].copy().mult(size));
			}
		} else {
			if(!roof_cr) {
				vertex(pc[0].copy().mult(Vec3(size.x,smallest_size,size.z)).add(pos)); // special point for the roof peak
			}
			for(int i = 1 ; i < pc.length ; i++) {
				vertex(pc[i].copy().mult(size).add(pos));
			}	
		}
		endShape(CLOSE);

		// draw D : WALL > main wall
		beginShape();
		if(pos == null) {
			vertex(pa[3].copy().mult(size));
			vertex(pa[4].copy().mult(size));
			vertex(pc[4].copy().mult(size));
			vertex(pc[3].copy().mult(size));
		} else {
			vertex(pa[3].copy().mult(size).add(pos));
			vertex(pa[4].copy().mult(size).add(pos));
			vertex(pc[4].copy().mult(size).add(pos));
			vertex(pc[3].copy().mult(size).add(pos));
		}
		endShape(CLOSE);








    // GROUND
    if(aspect_is) {
	  	aspect(fill_ground,stroke_ground,thickness);
	  }
		// draw G : GROUND
		beginShape();
		if(pos == null) {
			vertex(pa[2].copy().mult(size));
			vertex(pc[2].copy().mult(size));
			vertex(pc[3].copy().mult(size));
			vertex(pa[3].copy().mult(size));
		} else {
			vertex(pa[2].copy().mult(size).add(pos));
			vertex(pc[2].copy().mult(size).add(pos));
			vertex(pc[3].copy().mult(size).add(pos));
			vertex(pa[3].copy().mult(size).add(pos));
		}
		endShape(CLOSE);






    // ROOF
    if(aspect_is) {
	  	aspect(fill_roof,stroke_roof,thickness);
	  }
    // draw E : ROOF > main roof
		beginShape();
		if(pos == null) {
			vertex(pa[4].copy().mult(size));
			vertex(pa[0].copy().mult(Vec3(size.x,smallest_size,size.z))); // special point for the roof peak
			vertex(pc[0].copy().mult(Vec3(size.x,smallest_size,size.z))); // special point for the roof peak
			vertex(pc[4].copy().mult(size));
		} else {
			vertex(pa[4].copy().mult(size).add(pos));
			vertex(pa[0].copy().mult(Vec3(size.x,smallest_size,size.z)).add(pos)); // special point for the roof peak
			vertex(pc[0].copy().mult(Vec3(size.x,smallest_size,size.z)).add(pos)); // special point for the roof peak
			vertex(pc[4].copy().mult(size).add(pos));
		}
		endShape(CLOSE);

		// draw F : ROOF > main roof
		beginShape();
		if(pos == null) {
			vertex(pa[0].copy().mult(Vec3(size.x,smallest_size,size.z))); // special point for the roof peak
			vertex(pa[1].copy().mult(size));
			vertex(pc[1].copy().mult(size));
			vertex(pc[0].copy().mult(Vec3(size.x,smallest_size,size.z))); // special point for the roof peak
		} else {
			vertex(pa[0].copy().mult(Vec3(size.x,smallest_size,size.z)).add(pos)); // special point for the roof peak
			vertex(pa[1].copy().mult(size).add(pos));
			vertex(pc[1].copy().mult(size).add(pos));
			vertex(pc[0].copy().mult(Vec3(size.x,smallest_size,size.z)).add(pos)); // special point for the roof peak
		}
		endShape(CLOSE);

		// DRAW AR  > small side roof
		if(roof_ar) {
			beginShape();
			if(pos == null) {
				vertex(pa[0].copy().mult(Vec3(size.x,smallest_size,size.z))); // special point for the roof peak
				vertex(pa[1].copy().mult(size));
				vertex(pa[4].copy().mult(size));
			} else {
				vertex(pa[0].copy().mult(Vec3(size.x,smallest_size,size.z)).add(pos)); // special point for the roof peak
				vertex(pa[1].copy().mult(size).add(pos));
				vertex(pa[4].copy().mult(size).add(pos));
			}
			endShape(CLOSE);
		}

		// DRAW CR > small side roof
		if(roof_cr) {
			beginShape();
			if(pos == null) {
				vertex(pc[0].copy().mult(Vec3(size.x,smallest_size,size.z))); // special point for the roof peak
				vertex(pc[1].copy().mult(size));
				vertex(pc[4].copy().mult(size));
			} else {
				vertex(pc[0].copy().mult(Vec3(size.x,smallest_size,size.z)).add(pos)); // special point for the roof peak
				vertex(pc[1].copy().mult(size).add(pos));
				vertex(pc[4].copy().mult(size).add(pos));
			}
			endShape(CLOSE);
		}
	}
}



















/**
STAR
2016-2018
v 0.1.0
*/
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






















































/**
COSTUME CLASS
*/
public class Costume_pic {
	PImage img ;
	ROPE_svg svg ;
	int type = -1 ; 

	String name ;
	int ID ;
	public Costume_pic(PApplet p5, String path, int ID) {
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
class Costume 
2018-2018
v 0.1.1
*/
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
	boolean is_3D = false;
	boolean is_vertex = true;

	public Costume() {}

	public Costume(int type) {
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



	public void aspect(Vec fill, Vec stroke, float thickness) {
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

	void aspect(Vec fill, Vec stroke, float thickness, Costume costume) {
		aspect(fill,stroke,thickness,costume.get_type());
	}


	void aspect(Vec fill, Vec stroke, float thickness, int costume) {
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
		if(arg instanceof Vec2) {
			Vec2 c = (Vec2)arg;
			this.fill = color(c.x,c.x,c.x,c.y);
			fill(c) ;
		} else if(arg instanceof Vec3) {
			Vec3 c = (Vec3)arg;
			this.fill = color(c.x,c.y,c.z,g.colorModeA);
			fill(c) ;
		} else if(arg instanceof Vec4) {
			Vec4 c = (Vec4)arg;
			this.fill = color(c.x,c.y,c.z,c.w);
			fill(c);
		} else if(arg instanceof Integer) {
			int c = (int)arg;
			this.fill = c;
			fill(c);
		}
	}

	private void manage_stroke(Object arg) {
		if(arg instanceof Vec2) {
			Vec2 c = (Vec2)arg;
			this.stroke = color(c.x,c.x,c.x,c.y);
			stroke(c);
		} else if(arg instanceof Vec3) {
			Vec3 c = (Vec3)arg;
			this.stroke = color(c.x,c.y,c.z,g.colorModeA);
			stroke(c);
		} else if(arg instanceof Vec4) {
			Vec4 c = (Vec4)arg;
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






	public void draw(Vec3 pos, Vec3 size, Vec rot) {
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
