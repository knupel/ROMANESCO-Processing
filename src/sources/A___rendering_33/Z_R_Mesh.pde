/**
* R_Mesh
* temp tab before pass to Rope
* v 0.3.1
* 2019-2019
*/


/**
method R_Bloc
*/
R_Bloc create_bloc(vec2 [] points) {
	R_Bloc bloc = new R_Bloc();
	for(vec2 v : points) {
		bloc.build(v.x(),v.y(),true);
	}
	return bloc;
}


/**
* R_Megabloc
* v 0.0.1
* 2019-2019
*/
public class R_Megabloc {
	private ArrayList<R_Bloc> list;
	private int width;
	private int height;

	public R_Megabloc() {
		list = new ArrayList<R_Bloc>();
	}

	public void set(int width, int height) {
		this.width = width;
		this.height = height;
	}

	public void clear() {
		list.clear();
	}

	public int size() {
		return list.size();
	}

	public void add(R_Bloc bloc) {
		list.add(bloc);
	}

	public void add(R_Bloc [] blocs) {
		for(int i = 0 ; i < blocs.length ; i++) {
			list.add(blocs[i]);
		}
	}

	public int get_width() {
		return width;
	}

	public int get_height() {
		return height;
	}

	public ArrayList<R_Bloc> get()  {
		return list;
	}

	public R_Bloc get(int index) {
		if(index >= 0 && index < list.size()) {
			return list.get(index);
		} else {
			return null;
		}
	}

	public void show() {
		for(R_Bloc b : list) {
			b.show();
		}
	}
}


/**
* R_Bloc
* 2019-2019
* 0.1.9
*/
public class R_Bloc implements rope.core.R_Constants_Colour {
	private ArrayList<vec3> list;
	private int id;
	private String name;
	private boolean end;
	private boolean select_is;
	private boolean select_point_is;
	private boolean action_available_is;
	private int index;
	private int magnetism = 1;
	private int colour;
	private int fill;
	private int stroke;
	private float thickness = 2.0;
	private vec2 ref_coord;
	private vec2 coord;

	public R_Bloc() {
		list = new ArrayList<vec3>();
		id = (int)random(Integer.MAX_VALUE);
		coord = new vec2();
		ref_coord = new vec2();
		colour = CYAN;
		fill = BLANC;
		stroke = NOIR;
	}


	// set

	public void set_id(int id) {
		this.id = id;
	}

	public void set_magnetism(int magnetism) {
		this.magnetism = magnetism;
	}

	public void set_fill(int fill) {
		this.fill = fill;
	}

	public void set_colour_build(int colour) {
		this.colour = colour;
	}

	public void set_stroke(int stroke) {
		this.stroke = stroke;
	}

	public void set_thickness(float thickness) {
		this.thickness = thickness;
	}

	public void set_name(String name) {
		this.name = name;
	}




	// get
	public vec3 [] get() {
		return list.toArray(new vec3[list.size()]);
	}

	public String get_name() {
		return this.name;
	}

	public int get_id() {
		return this.id;
	}

	public String get_data() {
		String num = "" + list.size();
		String what = "bloc";
		String field_name = "name:"+name;
		String field_complexity = "complexity:"+num;
		String field_fill = "fill:"+fill;
		String field_stroke = "stroke:"+stroke;
		String field_thickness = "thickness:"+Float.toString(thickness);
		String setting = what + "," + field_name + "," + field_complexity + "," + field_fill + "," + field_stroke + "," + field_thickness;
		for(vec3 v : list) {
			String type = "type:0";
			String ax = "ax:" + Float.toString(v.x());
			String ay = "ay:" + Float.toString(v.y());
			// type 0 is a simple vertex
			// type 1 is for bezier vertex for the future version
			setting += "," + type + "<>" + ax + "<>" + ay;
		}
		setting += ",close:" + end;
		return setting;
	}

	public boolean in_bloc(float x, float y) {
		return in_polygon(get(),vec2(x,y));
	}

	public boolean end_is() {
		return end;
	}

	private boolean intersection(vec2 point) {
		for(int i = 1 ; i < list.size() ; i++) {
			vec2 a = vec2(list.get(i-1));
			vec2 b = vec2(list.get(i));
			if(is_on_line(a,b,point,magnetism)) {
				index = i; 
				return true;
			}
		}
		return false;
	}

	private boolean end(vec2 point) {
		int max = list.size() - 1;
		if(dist(vec2(list.get(0)), point) < magnetism) {
			index = 0;
			end = true;
			return true;
		}
		return false;
	}

	private boolean near_of(vec2 point) {
		for(int i = 1 ; i < list.size() ; i++) {
			if(dist(vec2(list.get(i)), point) < magnetism) {
				index = i;
				return true;
			}

		}
		return false;
	}


	public boolean select_point_is() {
		return select_point_is;
	}

	public boolean select_is() {
		return select_is;
	}





	// update
	public void update(float x, float y) {
		coord.set(x,y);
	}

	public void build(float x, float y, boolean event_is) {
		update(x,y);
		if(event_is) {
			vec2 point = vec2(x,y);
			if(list.size() > 1) {
				if(list.size() > 2 && end(point)) {
					add(vec2(list.get(index)));
				} else if(near_of(point)) {
					list.remove(index);
				} else if(intersection(point)) {
					add(index, point);
				} else {
					add(point);
				}
			} else {
				if(list.size() == 1 && near_of(point)) {
					//
				} else {
					add(point);
				}
			}
		}
	}

	private void add(vec2 point) {
		list.add(vec3(point));
	}

	private void add(int index, vec2 point) {
		list.add(index, vec3(point));
	}


	public void move(float x, float y, boolean event_is) {
		if(event_is) {
			vec3 offset = vec3(sub(ref_coord,coord));
			for(vec3 p : list) {
				p.sub(offset);
			}
			ref_coord.set(coord);
		} else {
			ref_coord.set(coord);
		}
	}

	public void move_point(float x, float y, boolean event_is) {
		if(event_is) {
			// select point to move
			if(!select_point_is() && !select_is()) {
				select_point(x,y);
			} else {
				// case where the bloc is close / ended to move the first and the last point
				if(end && (list.get(0).z() == 1 || list.get(list.size() -1).z() == 1)) {
					list.get(0).x(x);
					list.get(0).y(y);
					list.get(list.size() -1).x(x);
					list.get(list.size() -1).y(y);
				} else {
					for(vec3 v : list) {
						if(v.z() == 1) {
							v.x(x);
							v.y(y);
						}
					}
				}
			}
		} else {
			select_point_is = false;
			for(vec3 v : list) {
				v.z(0);
			}
		}
	}

	private void select_point(float x, float y) {
		for(vec3 v : list) {
			if(dist(vec2(v), vec2(x,y)) < magnetism) {
				select_point_is = true;
				v.z(1);
				break;
			}
		}
	}

	private void select(float x, float y) {
		if(in_bloc(x,y)) {
			select_is(true);
		}
	}

	public void select_is(boolean is) {
		this.select_is = is;
	}

	public void clear() {
		list.clear();
	}

	private void next() {
		if(list.size() > 0) {
			line(list.get(list.size()-1),coord);
		}
	}
	
	// show
	public boolean show_available_point(float x, float y) {
		update(x,y);
		fill(BLANC);
		float size = 5;
		if(list.size() > 0) {
			for(int index = 0 ; index < list.size() ; index++) {
				if(dist(coord,vec2(list.get(index))) < magnetism) {
					vec2 pos = sub(vec2(list.get(index)),vec2(size).mult(.5));
					square(pos,size);
					line(pos.copy().add(0,size/2),pos.copy().add(size,size/2));
					action_available_is = true;
					return true;
				}
				if(list.size() > 1 && index > 0) {
					vec2 a = vec2(list.get(index-1));
					vec2 b = vec2(list.get(index));
					if(is_on_line(a,b,coord,magnetism)) {
						vec2 pos = sub(coord,vec2(size).mult(.5));
						square(pos,size);
						line(pos.copy().add(0,size/2),pos.copy().add(size,size/2));
						line(pos.copy().add(size/2,0),pos.copy().add(size/2,size));
						action_available_is = true;
						return true;
					}
				}
			}
		}
		return false;
	}

	private void show_anchor_point() {
		float size = 5;
		// past selection
		fill(BLANC);
		strokeWeight(1);
		int max = list.size() - 1;
		for(int index = 0 ; index < max; index++) {
			if(index == 0 && !end) {
				square(sub(vec2(list.get(index)),vec2(size).mult(.5)),size * 1.5);
			} else {
				square(sub(vec2(list.get(index)),vec2(size).mult(.5)),size);
			}
		}

		// current selection
		fill(colour);
		if(max >= 0) {
			square(sub(vec2(list.get(max)),vec2(size).mult(.5)),size);
		}
	}

	private void show_struct() {
		strokeWeight(1);
		noFill();
		stroke(colour);
		beginShape();
		for(int index = 0 ; index < list.size() ; index++) {
			vertex(vec2(list.get(index)));
		}
		endShape();
		if(!end) {
			next();
		}
	}

	public void show() {
		aspect(fill, stroke, thickness);
		if(list.size() == 2) {
			line(vec2(list.get(0)),vec2(list.get(1)));
		} else if(list.size() > 2) {
			beginShape();
			for(int index = 0 ; index < list.size() ; index++) {
				vertex(vec2(list.get(index)));
			}
			endShape();
		}
	}
}



























/**
method R_Plane
*/
boolean in_plane(vec3 a, vec3 b, vec3 c, vec3 any, float range) {
	vec3 n = get_plane_normal(a, b, c);
	// Calculate nearest distance between the plane represented by the vectors
	// a,b and c, and the point any
	float d = n.x()*any.x() + n.y()*any.y() + n.z()*any.z() - n.x()*a.x() - n.y()*a.y() - n.z()*a.z();
	// A perfect result would be d == 0 but this will not hapen with realistic
	// float data so the smaller d the closer the point. 
	// Here I have decided the point is on the plane if the distance is less than 
	// range unit.
	return abs(d) < range; 
}


vec3 get_plane_normal(vec3 a, vec3 b, vec3 c) {
	return new R_Plane().get_plane_normal(a,b,c);
}

/**
* R_Plane
* 2019-2019
* 0.1.0
*/
class R_Plane {
	vec3 plane;
	vec3 a;
	float range = 1;
	boolean debug = false;
	ArrayList<R_Node> nodes;

	public R_Plane() {}

	public R_Plane(vec3 a, vec3 b, vec3 c) {
		this.a = a;
		this.plane = get_plane_normal(a,b,c);
	}

	public void set(vec3 a, vec3 b, vec3 c) {
		this.a = a;
		this.plane = get_plane_normal(a,b,c);
	}

	public void set_range(float range) {
		this.range = range;
	}

	public vec3 get_plane_normal(vec3 a, vec3 b, vec3 c) {
		return (sub(a,c).cross(sub(b,c))).normalize();
	}

	public float get_range() {
		return range;
	}

	public ArrayList<R_Node> get_nodes() {
		if(nodes != null) {
			return nodes;
			// return nodes.toArray(new R_Node[nodes.size()]);
		} else {
			return null;
		}
	}

	private boolean in_plane(vec3 any, float range) {
		// Calculate nearest distance between the plane represented by the vectors
		// a,b and c, and the point any
		float d = plane.x()*any.x() + plane.y()*any.y() + plane.z()*any.z() - plane.x()*a.x() - plane.y()*a.y() - plane.z()*a.z();
		// A perfect result would be d == 0 but this will not hapen with realistic
		// float data so the smaller d the closer the point. 
		// Here I have decided the point is on the plane if the distance is less than 
		// range unit.
		return abs(d) < range; 
	}


	public void debug(boolean bebug) {
		this.debug = debug;
	}

	public void clear() {
		if(nodes != null) {
			nodes.clear();
		}
	}

	public int size() {
		if(nodes != null) {
			return nodes.size();
		} else {
			return -1;
		}
	}

	public void add(R_Node any) {
		if(in_plane(any.pos(),range)) {
			if(nodes == null) {
				nodes = new ArrayList<R_Node>();
			} 
			nodes.add(any);
		} else if(debug) {
			println("class R_Plane method add():",any,"not in the plane",plane);
		}
	}
}





/**
* R_Face
* v 0.0.4
*/
public class R_Face {
	vec3 a,b,c;
	int fill;
	int stroke;
	public R_Face() {}

	public R_Face(vec3 a, vec3 b, vec3 c) {
		this.a = a;
		this.b = b;
		this.c = c;
	}

	public void set(vec3 a, vec3 b, vec3 c) {
		this.a = a;
		this.b = b;
		this.c = c;
	}


	public vec3 [] get() {
		vec3 [] summits = new vec3[3];
		summits[0] = a;
		summits[1] = b;
		summits[2] = c;
		return summits;
	}

	void set_fill(int fill) {
		this.fill = fill;
	}

	void set_stroke(int stroke) {
		this.stroke = stroke;
	}

	int get_fill() {
		return this.fill;
	}

	int get_stroke() {
		return this.stroke;
	}

	public void show() {
		beginShape();
		vertex(a);
		vertex(b);
		vertex(c);
		vertex(a); // close
		endShape();
	}
}


/**
* R_Node
* v 0.2.0
* 2019-2019
*/
public class R_Node {
	private vec3 pos;
	private ArrayList<vec3> dest_list;
	private int branch = 4;
	private int id;

	public R_Node() {}


	public R_Node(vec3 pos) {
		this.id = (int)random(MAX_INT);
		this.pos = pos;
	}

	public R_Node(vec3 pos, vec3 from) {
		this.id = (int)random(MAX_INT);
		this.pos = pos;
		dest_list = new ArrayList<vec3>();
		dest_list.add(from);
	}

	
	public R_Node copy() {
		R_Node node = new R_Node();
		if(dest_list != null) {
			node.dest_list = new ArrayList<vec3>(dest_list);
		}
		node.pos(this.pos);
		node.set_branch(branch);
		node.set_id(id);
		return node;
	}




	public boolean add_destination(vec3 dst) {
		if(dest_list.size() < branch && !all(equal(pos(),vec3(dst)))) {
			boolean equal_is = false;
			vec3 [] list = get_destination();
			for(int i = 0 ; i < list.length ; i++) {
				if(all(equal(list[i],vec3(dst)))) {
					equal_is = true;
				}
			}
			if(!equal_is) {
				dest_list.add(vec3(dst));
			}
			return !equal_is;
		} else {
			return false;
		}
	}
	
	// set
	public void set_destination(vec3 pos) {
		if(dest_list.size() < branch) {
			dest_list.add(pos);
		} 
	}

	public void set_id(int id) {
		this.id = id;
	}
	
	public void set_branch(int branch) {
		this.branch = branch;
	}

	public void pos(vec3 pos) {
		if(pos == null) {
			this.pos = new vec3();
		}	else {
			this.pos = pos;
		}
	}

	public void x(float x) {
		if(this.pos != null) {
			this.pos.x(x);
		} else {
			this.pos = new vec3(x,0,0);
		}
	}

	public void y(float y) {
		if(this.pos != null) {
			this.pos.y(y);
		} else {
			this.pos = new vec3(0,y,0);
		}
	}

	public void z(float z) {
		if(this.pos != null) {
			this.pos.z(z);
		} else {
			this.pos = new vec3(0,0,z);
		}
	}

	

	// get
	public int get_id() {
		return id;
	}

	public int get_branch() {
		return branch;
	}

	public int get_branch_available() {
		return branch - dest_list.size();
	}

	public vec3 [] get_destination() {
		return dest_list.toArray(new vec3[dest_list.size()]);
	}

	public vec3 pos() {
		return pos.xyz();
	}

	public vec3 pointer() {
		return pos;
	}

	public float x() {
		return pos.x();
	}

	public float y() {
		return pos.y();
	}

	public float z() {
		return pos.z();
	}
}










/**
* SEGMENT
* v 0.1.1
* 2019-2019
*/
public class R_Segment {
	private vec3 start;
	private vec3 end;
	private int capacity;
	private boolean direction;
	public R_Segment(vec start, vec end) {
		this.start = vec3(start.x,start.y,start.z);
		this.end = vec3(end.x,end.y,end.z);
	}

	public vec3 get_start() {
		return start;
	}

	public vec3 get_end() {
		return end;
	}

	public float get_angle() {
		return vec2(start).angle(vec2(end));
	}

	public float get_length() {
		return start.dist(end);
	}

	public void set_capacity(int capacity) {
		this.capacity = capacity;
	}

	public void set_direction(boolean direction) {
		this.direction = direction;
	}



	private vec2 line_intersection(R_Segment one, R_Segment two) {
		float x1 = one.get_start().x;
		float y1 = one.get_start().y;
		float x2 = one.get_end().x;
		float y2 = one.get_end().y;
		
		float x3 = two.get_start().x;
		float y3 = two.get_start().y;
		float x4 = two.get_end().x;
		float y4 = two.get_end().y;
		
		float bx = x2 - x1;
		float by = y2 - y1;
		float dx = x4 - x3;
		float dy = y4 - y3;
	 
		float b_dot_d_perp = bx * dy - by * dx;
	 
		if(b_dot_d_perp == 0) {
			return null;
		}
	 
		float cx = x3 - x1;
		float cy = y3 - y1;
	 
		float t = (cx * dy - cy * dx) / b_dot_d_perp;
		if(t < 0 || t > 1) return null;
	 
		float u = (cx * by - cy * bx) / b_dot_d_perp;
		if(u < 0 || u > 1) return null;
	 
		return vec2(x1+t*bx, y1+t*by);
	}
	
	public vec2 meet_at(R_Segment target) {
		return line_intersection(this,target);
	}

	public boolean meet_is(R_Segment target) {
		if(meet_at(target) == null) {
			return false;
		} else {
			return true;
		}
	}
}
