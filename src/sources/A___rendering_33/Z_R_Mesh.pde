/**
* R_Mesh
* temp tab before pass to Rope
* v 0.0.4
* 2019-2019
*/
/**
method
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
* 0.0.2
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

	public R_Node [] get_nodes() {
		if(nodes != null) {
			return nodes.toArray(new R_Node[nodes.size()]);
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
			// println("in plane",any,frameCount);
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
* v 0.1.0
* 2019-2019
*/
public class R_Segment {
	private vec3 start;
	private vec3 end;
	private int capacity;
	private boolean direction;
	private float angle;
	private float length;
	public R_Segment(vec start, vec end) {
		this.start = vec3(start.x,start.y,start.z);
		this.end = vec3(end.x,end.y,end.z);
		this.angle = angle(vec2(this.start),vec2(this.end));
		this.length = dist(this.start,this.end);
		// println("class Segment: new Segment build");
	}

	public vec3 get_start() {
		return start;
	}

	public vec3 get_end() {
		return end;
	}

	public float get_angle() {
		return angle;
	}

	public float get_length() {
		return length;
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







