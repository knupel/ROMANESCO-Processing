/**
* SLIDER
* v 1.8.2
* 2013-2019
*/
boolean molette_already_selected ;
public class Slider extends Crope {
	protected Molette [] molette;

	private boolean init_molette_is = false;

	protected vec2 pos_min;
	protected vec2 pos_max;

	protected int fill_molette_in = color(g.colorModeX *.4);
	protected int fill_molette_out = color(g.colorModeX *.2);
	protected int stroke_molette_in = fill_molette_in;
	protected int stroke_molette_out = fill_molette_out;
	protected float thickness_molette = 0;

	protected float min_norm = 0 ;
	protected float max_norm = 1 ;

	protected int molette_type = RECT;


	public Slider() {
		super("Slider");
		this.pos(vec2(-1));
		this.size(vec2(-1));
	}
	
	public Slider(vec2 pos, vec2 size) {
		super("Slider");
		this.pos(pos);
		this.size(size);
	}

	public Slider(String type, vec2 pos, vec2 size) {
		super(type);
		this.pos(pos);
		this.size(size);
	}

	// SET
	public Slider set_value(float... pos_norm) {
		Arrays.sort(pos_norm);
		init_molette(pos_norm.length);

		for(int i = 0 ; i < molette.length ; i++) {
			molette[i].pos = new vec2();
			molette[i].id = i;
			// security to constrain the value in normalizing range.
			if(pos_norm[i] > 1.) pos_norm[i] = 1.;
			if(pos_norm[i] < 0.) pos_norm[i] = 0.;
			// check if it's horizontal or vertical slider      
			if(size.x() >= size.y()) {;
				float x = round(size.x() *pos_norm[i] +pos_min.x() -(molette[i].size.y() *pos_norm[i])); 
				float y = pos.y();
				molette[i].pos.set(x,y);
			} else {
				float x = pos.x();
				float y = round(size.y() *pos_norm[i] +pos_min.y() -(molette[i].size.x() *pos_norm[i]));
				molette[i].pos.set(x,y);
			}
			molette[i].set(pos_norm[i]);
		}
		return this;
	}

	public Slider set_molette_num(int num) {
		init_molette(num);
		float [] pos_norm = new float[num];
		float step = 1. / (num+1) ;
		for(int i = 0 ; i < num ; i++) {
			pos_norm[i] = (i+1)*step;
		}
		set_value(pos_norm);
		return this;
	}

	private Slider set_molette_min_max_pos() {
		for(int i = 0 ; i < molette.length ; i++) {
			if(size.x() > size.y()) {
				pos_min = pos.copy();
				pos_max = new vec2(pos.x() +size.x() -molette[i].size.x(), pos.y()) ;
			} else {
				pos_min = pos.copy();
				pos_max = new vec2(pos.x(), pos.y() +size.y() -molette[i].size.y()) ;
			}
		}  
		return this;
	}

	public Slider set_molette(int type) {
		this.molette_type = type;
		if(molette == null) {
			init_molette(1);
		}
		return this;
	}


	// set size
	private void set_size_molette(int index) {
		if (size.x() >= size.y()) {
			molette[index].size = new vec2(size.y()); 
		} else {
			molette[index].size = new vec2(size.x());
		}
	}

	public Slider set_size_molette(vec2 size) {
		set_size_molette(size.x(), size.y());
		return this;
	}

	public Slider set_size_molette(float x, float y) {
		if(molette == null) {
			init_molette(1);
		}
		for(int i = 0 ; i < molette.length ; i++) {
			molette[i].size.set(x,y);
		}
		set_molette_min_max_pos();
		return this;
	}

	// set pos
	public Slider set_pos_molette() {
		for(int i = 0 ; i < molette.length ; i++) {
			set_pos_molette(i);
		}   
		return this;
	}

	public Slider set_pos_molette(int index) {
		this.molette[index].pos.set(pos);
		return this;
	}

	public Slider set_pos_molette(vec2... pos_mol) {
		init_molette(pos_mol.length);
		for(int i = 0 ; i < molette.length ; i++) {
			if(i < pos_mol.length) {
				set_pos_molette(i,pos_mol[i].x(), pos_mol[i].y());
			} else {
				set_pos_molette(i,pos.x(),pos.y());
			}
		}
		return this;
	}

	public Slider set_pos_molette(int index, float x, float y) {
		if(index < molette.length) {
			if(molette[index].pos == null) {
				molette[index].pos = new vec2(x,y);
			} else {
				molette[index].pos.set(x,y);
			}
		} 
		return this;
	}



	// aspect
	public Slider set_fill_molette(int c) {
		set_fill_molette(c,c);
		return this;
	}

	public Slider set_fill_molette(int c_in, int c_out) {
		this.fill_molette_in = c_in;
		this.fill_molette_out = c_out;
		return this;
	}
	
	public Slider set_stroke_molette(int c) {
		set_stroke_molette(c,c);
		return this;
	}

	public Slider set_stroke_molette(int c_in, int c_out) {
		this.stroke_molette_in = c_in;
		this.stroke_molette_out = c_out;
		return this;
	}

	public Slider set_thickness_molette(float thickness) {
		this.thickness_molette = thickness;
		return this;
	}

	@Deprecated
	public Slider set_aspect_molette(int f_c, int s_c, float thickness) {
		set_fill_molette(f_c,f_c);
		set_stroke_molette(s_c,s_c);
		set_thickness_molette(thickness);
		return this;
	}
	
	@Deprecated
	public Slider set_aspect_molette(int f_c_in, int f_c_out, int s_c_in,  int s_c_out, float thickness) {
		set_fill_molette(f_c_in,f_c_out);
		set_stroke_molette(s_c_in,s_c_out);
		set_thickness_molette(thickness);
		return this;
	}






	// GET
	public float [] get() {
		int num = 1;
		if(molette != null) {
			num = molette.length;
		}
		float [] value_array = new float[num];
		for(int i = 0 ; i < value_array.length ; i++) {
			value_array[i] = get(i);
		}
		return value_array;
	}

	public float get(int index) {
		float value = molette[index].get();
		if(molette != null && index < molette.length 
			&& pos_min.x() > 0 && pos_min.y() > 0 
			&& pos_max.x() > 0 && pos_max.y() > 0) {
				if (size.x() >= size.y()) {  
				value = map(value, pos_min.x(),pos_max.x(), min_norm,max_norm); 
			} else {
				value = map(value, pos_min.y(),pos_max.y(), min_norm,max_norm);
			}
		}
		if(value < 0 || value > 1) value = molette[index].get();
		return value;
	}

	private boolean wheel_is() {
		return wheel_is;
	}

	public float get_min_norm() {
		return min_norm ;
	}

	public float get_max_norm() {
		return max_norm ;
	}
	
	public vec2 get_min_pos() {
		return pos_min;
	}

	public vec2 get_max_pos() {
		return pos_max;
	}

	public vec2 [] get_molette_pos() {
		vec2 [] pos = new vec2[molette.length] ;
		for(int i = 0 ; i < molette.length ;i++) {
			pos[i] = molette[i].pos().copy();
		}
		return pos;
	}

	public vec2 get_molette_pos(int index) {
		if(index < molette.length && index >= 0) {
			return molette[index].pos();
		} else {
			printErr("method get_molette_pos(",index,") is out of the range");
			return null;
		}
	}

	public vec2 get_molette_size(int index) {
		return molette[index].size();
	}

	public boolean molette_used_is() {
		boolean state = false;
		for(int i = 0 ; i < molette.length; i++) {
			if(molette_used_is(i)){
				state = true;
				break;
			}
		}
		return state;
	}

	public boolean molette_used_is(int index) {
		boolean inside = false ;
		if(molette_type == ELLIPSE) {
			inside = inside_molette_ellipse(index);
		} else {
			inside = inside_molette_rect(index);
		}
		if (inside && event) {
			return true ; 
		} else {
			return false ;
		}
	}

	public boolean molette_inside_is() {
		boolean is = false; 
		for(int i = 0 ; i < molette.length ; i++) {
			if(molette[i].inside_is()) {
				is = true ;
				break;
			}
		}
		return is;
	}

	public boolean molette_inside_is(int index) {
		boolean is = false; 
		if(index >= 0 && index < molette.length) {
			is = molette[index].inside_is();
		}
		return is;
	}

	public boolean select_is() {
		boolean is = false; 
		for(int i = 0 ; i < molette.length ; i++) {
			if(molette[i].select_is()) {
				is = true ;
				break;
			}
		}
		return is;
	}

	public boolean select_is(int index) {
		boolean is = false; 
		if(index >= 0 && index < molette.length) {
			is = molette[index].select_is();
		}
		return is;
	}

	public boolean used_is() {
		boolean is = false; 
		for(int i = 0 ; i < molette.length ; i++) {
			if(molette[i].used_is()) {
				is = true ;
				break;
			}
		}
		return is;
	}

	public boolean used_is(int index) {
		boolean is = false; 
		if(index >= 0 && index < molette.length) {
			is = molette[index].used_is();
		}
		return is;
	}


















	// SHOW
	public void show_structure() {
		if(thickness > 0 && alpha(stroke_in) > 0 && alpha(stroke_out) > 0) {
			strokeWeight(thickness);
			if(inside(RECT)) {
				fill(fill_in);
				stroke(stroke_in);
			} else {
				fill(fill_out);
				stroke(stroke_out);
			}    
		} else {
			noStroke();
			if(inside(RECT)) {
				fill(fill_in);
			} else {
				fill(fill_out);
			}
		}

		if(rounded > 0) {
			rect(pos.x,pos.y,size.x,size.y,rounded);
		} else {
			rect(vec2(pos),vec2(size));
		}
	}


	public void show_molette() {
		for(int i = 0 ; i < molette.length ; i++) {
			if(molette[i].inside_is()) {
				aspect(fill_molette_in,stroke_molette_in,thickness_molette);
				molette_shape(i);
			} else {
				aspect(fill_molette_out,stroke_molette_out,thickness_molette);
				molette_shape(i);
			}   
		}
	}
	
	public void show_label() {
		if(this.name != null) {
			textAlign(align_label_name);
			if(font != null) textFont(font);
			if(font_size > 0) textSize(font_size);
			if(inside(RECT)) {
				fill(color_label_in);
			} else {
				fill(color_label_out);
			}
			//println(this.name,pos,pos_label);
			text(this.name,add(pos,pos_label));
		}  
	}

	public void show_value() {
		show_value(get());
	}

	public void show_value(float... value) {
		if(this.name != null) {
			 textAlign(align_label_value);
			 if(font != null) textFont(font);
			 if(font_size > 0) textSize(font_size);
			 if(inside(RECT)) {
				fill(color_label_in);
			} else {
				fill(color_label_out);
			}

			String message = "[ ";
			for(int i = 0 ; i < value.length ; i++) {
				float f = truncate(value[i],2);
				message += f;
				if(i < value.length -1) message += ",";
			}
			message += " ]";
			text(message,add(pos,pos_value));
		}
	}











	// MISC
	public void update(float x, float y) {
		if(!crope_build_is) {
			molette_builder(1);
		}
		cursor(x,y);
		molette_update();
	}
	
	private boolean wheel_is;
	public void wheel(boolean wheel_is) {
		if(molette == null) {
			init_molette(1);
		}
		if(molette.length == 1) {
			this.wheel_is = wheel_is; 
		} else {
			printErrTempo(60, "method wheel(boolean wheel_is): Work only on mode single slider");
			this.wheel_is = false;
		} 
	}


	private void init_molette(int len) {
		if(molette == null || len != molette.length) {
			molette_builder(len);
		}
	}

	private void molette_builder(int num) {
		molette = new Molette[num]; // create list of molette
		for(int i = 0 ; i < num ; i++) {
			molette[i] = new Molette();
			this.set_pos_molette(i);
			set_size_molette(i);
			molette[i].id = 0;
			molette[i].used_is = false;
			molette[i].inside_is = false;
			init_molette_is = true;
		}
		set_molette_min_max_pos();
		crope_build_is = true;
	} 

	private void molette_shape(int index) {
		if(molette_type == ELLIPSE) {
			vec2 temp = vec2(round(mult(molette[index].size,.5)));
			vec2 pos = add(vec2(molette[index].pos),temp);
			ellipse(pos,vec2(molette[index].size));
		} else if(molette_type == RECT) {
			molette_rect(index);
		} else {
			molette_rect(index);
		}
	}
	
	private void molette_rect(int index) {
		if(size.x > size.y) {
			vec2 pos = vec2(molette[index].pos);
			pos.y = pos.y -((molette[index].size.y -size.y)/2);
			rect(pos,vec2(molette[index].size));
		} else {
			vec2 pos = vec2(molette[index].pos);
			pos.x = pos.x -((molette[index].size.x -size.x)/2);
			rect(pos,vec2(molette[index].size));
		}
	}


	protected void molette_update() {
		inside(ELLIPSE);
		if(molette == null) {
			init_molette(1);
		}
		for(int i = 0 ; i < molette.length ; i++) {
			if(!molette[i].select_is()) {
				event = mousePressed;
				boolean is = select(i,molette_used_is(i),molette[i].used_is(),true);
				molette[i].used(is);
				if(molette[i].used_is()) {
					mol_update_pos(i,temp_min(i),temp_max(i));
					mol_update_used_by_cursor(i,temp_min(i),temp_max(i));
					break;
				}   
			}
		}

		if(wheel_is()) {
			if(get_scroll() == null) {
				printErrTempo(60, "class Slider method molette_update(): the wheelEvent is innacessible\nmay be you must use method scroll(MouseEvent e) in void mouseWheel(MouseEvent e)");
			} else {
				float val = 0;
				if (size.x() >= size.y()) {
					float temp = molette[0].pos.x();
					temp += get_scroll().x();
					molette[0].pos.x(temp);
					val = molette[0].pos.x();
				} else {
					float temp = molette[0].pos.y();
					temp += get_scroll().y();
					molette[0].pos.y(temp);
					val = molette[0].pos.y();
				}
				mol_update_pos(0,temp_min(0),temp_max(0));
				if (size.x() >= size.y()) {
					val = round(constrain(val, temp_min(0).x(), temp_max(0).x()));
				} else { 
					val = round(constrain(val, temp_min(0).y(), temp_max(0).y()));
				}
				molette[0].set(val);
			}   
		}
	}
	
	
	private void mol_update_used_by_cursor(int index, vec2 min, vec2 max) {
		if (molette[index].used_is) {
			float val = 0;
			if (size.x() >= size.y()) {
				val = round(constrain(cursor.x() -(molette[index].size.x() *.5), min.x(), max.x()));
				molette[index].pos.x(val);
			} else { 
				val = round(constrain(cursor.y() -(molette[index].size.y() *.5), min.y(), max.y()));
				molette[index].pos.y(val);
			}
			molette[index].set(val);
		}
	}
	

	private void mol_update_pos(int index, vec2 min, vec2 max) {
		// check for horizontal or vertical slider
		if(size.x() >= size.y()) {
			if (molette[index].pos.x() < min.x()) {
				molette[index].pos.x(min.x());
			}
			if (molette[index].pos.x() > max.x()) {
				molette[index].pos.x(max.x());
			}
		} else {
			if (molette[index].pos.y() < min.y()) {
				molette[index].pos.y(min.y());
			}
			if (molette[index].pos.y() > max.y()) {
				molette[index].pos.y(max.y());
			}
		}
	}


	private vec2 temp_min(int index) {
		vec2 min = pos_min.copy();
		// def min
		if(molette.length > 1 && index > 0) {
			min.set(molette[index-1].pos);
			if(molette_type == ELLIPSE) {
			 if(size.x() >= size.y()) {
					min.add_x(size.y() /2);
				} else {
					min.add_y(size.x()/2);
				}
			} else {
				if(size.x() >= size.y()) {
					min.add_x(size.y());
				} else {
					min.add_y(size.x());
				}  
			}
		}
		return min;
	}

	private vec2 temp_max(int index) {
		vec2 max = pos_max.copy();
		 if(molette.length > 1 && index < molette.length -1) {
			max.set(molette[index+1].pos) ;
			if(molette_type == ELLIPSE) {
			 if(size.x() >= size.y()) {
					max.sub_x(size.y());
				} else {
					max.sub_y(size.x());
				}
			} else {
				if(size.x() >= size.y()) {
					max.sub_x(size.y());
				} else {
					max.sub_y(size.x());
				}  
			}
		}
		return max;
	}


	


	public boolean inside_molette_is(int index) {
		return molette[index].inside_is();
	}

	// inside molette
	public boolean inside_molette_rect() {
		boolean state = false;
		for(int i = 0 ; i < molette.length; i++) {
			if(inside_molette_rect(i)) {
				state = true;
				break;
			}
		}
		return state;
	}

	public boolean inside_molette_rect(int index) {
		if(inside(molette[index].pos,molette[index].size,RECT)) {
			molette[index].inside_is(true); 
		} else {
			molette[index].inside_is(false);
		}
		return molette[index].inside_is();
	}
	
	public boolean inside_molette_ellipse() {
		boolean state = false;
		for(int i = 0 ; i < molette.length; i++) {
			if(inside_molette_ellipse(i));
			state = true;
			break;
		}
		return state;
	}

	public boolean inside_molette_ellipse(int index) {
		if(cursor == null) cursor = new vec2();
		float radius = molette[index].size.x ;
		int posX = int(radius *.5 +molette[index].pos.x ); 
		int posY = int(size.y *.5 +molette[index].pos.y);
		if(pow((posX -cursor.x),2) + pow((posY -cursor.y),2) < pow(radius,sqrt(3))) {
			molette[index].inside_is = true ; 
		} else {
			molette[index].inside_is = false ;
		}
		return molette[index].inside_is;
	}





	// update position from midi controller
	public void update_midi(int... value) {
		if(value.length > molette.length) {
			printErr("method_midi(): there is too much midi value for the quantity of molette available.\nmethod apply only when is possible");
		}
		for(int i = 0 ; i < molette.length ; i++) {
			if(i < value.length) {
				update_midi(i, value[i]);
			} 
		}
	}

	public void update_midi(int index, int value) {
		//update the Midi position only if the Midi Button move
		if (midi_value != value) { 
			if(size.x >= size.y) {
				float temp = map(value, 1, 127, pos_min.x(), pos_max.x());
				molette[index].pos.x(temp);
				molette[index].set(temp); 
				
			} else {
				float temp = map(value, 1, 127, pos_min.y(), pos_max.y());
				molette[index].pos.y(temp);
				molette[index].set(temp);

			}
		}
	}


	boolean keep_selection = true;
	public void keep_selection(boolean state) {
		if(state) {
			this.keep_selection = false;
		 } else {
			this.keep_selection = true;
		}
	}

	// select
	public void select(boolean authorization) {
		for(int i = 0 ; i < molette.length ; i++) {
			select(i,authorization);
		}
	}

	private void select(int index, boolean authorization) {
		molette[index].select(keep_selection);
		event = mousePressed;
		molette[index].used_is = select(index, molette_used_is(index),molette[index].used_is,authorization);
	}
	
	//
	public  void select(boolean authorization_1, boolean authorization_2) {
		for(int i = 0 ; i < molette.length ; i++) {
			select(i,authorization_1,authorization_2);
		}
	}

	private void select(int index, boolean authorization_1, boolean authorization_2) {
		molette[index].select(keep_selection);
		event = authorization_1;
		molette[index].used_is = select(index,molette_used_is(index),molette[index].used_is,authorization_2);
	}
	

	// this method is used to switch false all select_is molette
	protected boolean select(boolean locked_method, boolean result, boolean authorization) {
		return select(-1, locked_method,result,authorization);
	}


	// privat method
	protected boolean select(int index, boolean locked_method, boolean result, boolean authorization) {
		if(authorization) {
			if(!molette_already_selected) {
				if (locked_method) {
					molette_already_selected = true;
					result = true;
				}
			} else if(locked_method) {
				if(index == -1) {
					for(int i = 0 ; i < molette.length ;i++) {
						molette[i].select(false);
					}
				} else if(index >= 0 && index < molette.length) {
					molette[index].select(false);
				}
				
				result = true ;
			}

			if (!event) { 
				result = false ; 
				molette_already_selected = false;
			}
			return result;
		} else return false;   
	}
}
























/**
SLOTCH > notch's slider
v 0.3.0
2018-2021
*/
public class Slotch extends Slider {
	protected float [] notches_pos ;
	protected int colour_notch = int(g.colorModeX);
	protected float thickness_notch = 1.;

	protected boolean notch_is;
	protected int notches_num;
	protected int notch;

	public Slotch() {
		super("Slotch",vec2(-1), vec2(-1));
		set_notch(2);
	}

	// 	public Slotch(vec2 pos, vec2 size, int num) {
	// 	super("Slotch",pos, size);
	// 	set_notch(num);
	// }

	public Slotch(vec2 pos, vec2 size, int num) {
		super("Slotch",pos, size);
		set_notch(num);
	}

	public Slotch(String type, vec2 pos, vec2 size, int num) {
		super(type,pos, size);
		set_notch(num);
	}

	/*
		public Slider() {
		super("Slider");
		this.pos(vec2(-1));
		this.size(vec2(-1));
	}
	
	public Slider(vec2 pos, vec2 size) {
		super("Slider");
		this.pos(pos);
		this.size(size);
	}

	public Slider(String type, vec2 pos, vec2 size) {
		super(type);
		this.pos(pos);
		this.size(size);
	}
	*/

	// SET
	public Slotch set_notch(int num) {
		notch_is = true;
		this.notches_num = num +1;
		notches_position();
		return this;
	}

	public Slotch set_aspect_notch(int c, float thickness) {
		this.colour_notch = c ;
		this.thickness_notch = thickness;
		return this;
	}

	public Slotch set_aspect_notch(int c) {
		this.colour_notch = c ;
		return this;
	}


	// GET
	public int get_notch() {
		return notch;
	}

	public int get_notches_num() {
		return notches_num;
	}

	public float get(int index) {
		float value = 0;
		if(molette != null && index < molette.length 
			&& pos_min.x > 0 && pos_min.y > 0 
			&& pos_max.x > 0 && pos_max.y > 0) {
			if (size.x >= size.y) {  
				value = map(molette[index].get(),
										pos_min.x,pos_max.x,
										min_norm,max_norm); 
			} else {
				value = map(molette[index].get(),
										pos_min.y,pos_max.y,
										min_norm,max_norm);
			}
		}

		value = round(value*(float)notches_num) -1;
		return value;
	}

	public float [] get() {
		int num = 1;
		if(molette != null) {
			num = molette.length;
		}
		float [] value = new float[num];
		for(int i = 0 ; i < value.length ; i++) {
			value[i] = get(i);
		}
		return value;
	}



	// MISC
	public void update(float x, float y) {
		cursor(x,y);
		molette_update();
		if (size.x() >= size.y()) { 
			if(notch_is) {
				for(int i = 0 ; i < molette.length ; i++) {
					molette[i].pos.x = floor(pos_notch(size.x, molette[i].pos.x));
					molette[i].set(molette[i].pos.x());
				}    
			}
		} else { 
			if(notch_is) {
				for(int i = 0 ; i < molette.length ; i++) {
					molette[i].pos.y = (int)pos_notch(size.y, molette[i].pos.y);
					molette[i].set(molette[i].pos.y());
				}
			}
		}
	}



	private float pos_notch(float size, float pos_molette) {

		float step = size / (float)get_notches_num();
		float offset_slider_pos_x = pos().x() -step;
		float abs_pos = pos_molette -offset_slider_pos_x;
		
		for(int i = 1 ; i < notches_pos.length ; i++) {
			float min = notches_pos[i] - (step *.5);
			float max = notches_pos[i] + (step *.5);
			if(abs_pos > min && abs_pos < max) {
				abs_pos = notches_pos[i];
				break;
			} else if(abs_pos <= min ) {
				abs_pos = notches_pos[i];
				break;
			} else if(abs_pos >= notches_pos[notches_pos.length-1] + (step *.5) ) {
				abs_pos = notches_pos[notches_pos.length-1];
				break;
			}
		}
		
		// here it's buggy, need to find a good ratio for the diffente size of slotch
		// actully that's work well only when the step is equal to the mollete size in x and in y
		float offset = 0;
		float size_mol = molette[0].size.x();
		float ratio = (size_mol / step) *0.5;
		offset = step *.5 -(size_mol *ratio);
		return abs_pos - offset +offset_slider_pos_x;
	}




	public float [] notches_position() {
		notches_pos = new float[get_notches_num()];
		float step = (float)size.x / get_notches_num();
		for(int i = 0 ; i < get_notches_num(); i++) {
			notches_pos[i] = (i+1) *step -(step*.5);
		}
		return notches_pos;
	}
	
	public void show_notch() {
		show_notch(0,0);
	}

	public void show_notch(int start, int stop) {
		stroke(colour_notch);
		noFill();
		strokeWeight(thickness_notch);
		if (size.x >= size.y) {
			start += pos.y ;
			stop += size.y;
			for(int i = 0 ; i < notches_pos.length ; i++) {
				float abs_pos = notches_pos[i];
				line(pos.x +abs_pos,start,pos.x +abs_pos,start +stop);
			}
		} else {
			start += pos.x ;
			stop += size.x;
			for(int i = 0 ; i < notches_pos.length ; i++) {
				float abs_pos = notches_pos[i];
				line(start,pos.y +abs_pos,start+stop,pos.y +abs_pos);
			}
		} 
	}
} 
























/**
SLADJ > SLIDER ADJUSTABLE
v 1.3.0
2016-2018
*/
public class Sladj extends Slider {
	// size
	protected vec2 size_min_max;
	protected vec2 size_molette_min_max;
	// pos  
	protected vec2 new_pos_min;
	protected vec2 new_pos_max;


	private vec2 pos_norm_adj = new vec2(1,.5);
	private vec2 size_norm_adj = new vec2(1.,.2);

	protected int fill_adj_in = color(g.colorModeX/2);
	protected int fill_adj_out = color(g.colorModeX /4);
	protected int stroke_adj_in = color(g.colorModeX/2);
	protected int stroke_adj_out = color(g.colorModeX /4);
	protected float thickness_adj = 0;

	private boolean locked_min, locked_max;
		
	Sladj(vec2 pos, vec2 size) {
		super("Sladj",pos, size);
		this.new_pos_max = new vec2();
		this.new_pos_min = pos.copy();
		this.size_min_max = size.copy();

		if (size.x >= size.y) {
			this.size_molette_min_max = new vec2(size.y); 
		} else {
			this.size_molette_min_max = new vec2(size.x);
		}
	}
	/*
	//slider with external molette
	public Sladj(ivec2 pos, ivec2 size, ivec2 size_molette, int moletteShapeType) {
		super(pos,size);
		size_molette(size_molette);
		set_molette(moletteShapeType);
		this.new_pos_max = ivec2();
		this.new_pos_min = ivec2();
		this.size_min_max = size.copy();
		this.size_molette_min_max = ivec2(size_molette);
	}
	*/



	public Sladj set_fill_adj(int c) {
		set_fill_adj(c,c);
		return this;
	}

	public Sladj set_fill_adj(int c_in, int c_out) {
		this.fill_adj_in = c_in;
		this.fill_adj_out = c_out;
		return this;
	}
	
	public Sladj set_stroke_adj(int c) {
		set_stroke_adj(c,c);
		return this;
	}

	public Sladj set_stroke_adj(int c_in, int c_out) {
		this.stroke_adj_in = c_in;
		this.stroke_adj_out = c_out;
		return this;
	}

	public Sladj set_thickness_adj(float thickness) {
		this.thickness_adj = thickness;
		return this;
	}


	
	
	
	/**
	METHOD
	*/
	public void update_min_max() {
		float new_norm_size = max_norm -min_norm ;
		
		if (size.x >= size.y) {
			size_min_max = new vec2(round(size.x *new_norm_size), size.y); 
		} else {
			size_min_max = new vec2(round(size.y *new_norm_size), size.x);
		}
		
		pos_min = new vec2(round(pos.x +(size.x *min_norm)), pos.y) ;
		// in this case the detection is translate on to and left of the size of molette
		// we use the molette[0] to set the max. there is at least one molette by slider :)
		pos_max = new vec2(round(pos.x -molette[0].size.x +(size.x *max_norm)), pos.y); 
	}
	


	public boolean locked_min_is() {
		return locked_min;
	}

	public boolean locked_max_is() {
		return locked_max;
	}
	
	// update min
	public void select_min(boolean authorization) {
		locked_min = select(locked_min(), locked_min, authorization) ;
	}
	public void update_min() {
		// we use the molette[0] to set the max. there is at least one molette by slider :)
		float arbitrary_value = 1.5;
		float range = molette[0].size.x * arbitrary_value;
		
		if (locked_min) {
			if (size.x >= size.y) {
				// security
				if (new_pos_min.x < pos_min.x ) new_pos_min.x = pos_min.x ;
				else if (new_pos_min.x > pos_max.x -range) new_pos_min.x = round(pos_max.x -range);
				
				new_pos_min.x = round(constrain(cursor.x, pos.x, pos.x+size.x -range)); 
				// norm the value to return to method minMaxSliderUpdate
				min_norm = map(new_pos_min.x, pos_min.x, pos_max.x, min_norm,max_norm) ;
			} else new_pos_min.y = round(constrain(cursor.y -size_min_max.y, pos_min.y, pos_max.y)); // this line is not reworking for the vertical slider
		}
	}
	
	// update max
	public void select_max(boolean authorization) {
		locked_max = select(-1,locked_max(), locked_max, authorization) ;
	}
	// update maxvalue
	public void update_max() {
		float arbitrary_value = 1.5;
		float range = molette[0].size.x * arbitrary_value;
		
		if (locked_max) {  // this line is not reworking for the vertical slider
			if (size.x >= size.y) {
				// security
				if (new_pos_max.x < pos_min.x +range)  {
					new_pos_max.x = round(pos_min.x +range);
				} else if (new_pos_max.x > pos_max.x ) {
					new_pos_max.x = pos_max.x;
				}
				new_pos_max.x = round(constrain(cursor.x -(size.y *.5) , pos.x +range, pos.x +size.x -(size.y *.5))); 
				 // norm the value to return to method minMaxSliderUpdate
				pos_max = new vec2(round(pos.x -molette[0].size.x +(size.x *max_norm)), pos.y) ;
				// we use a temporary position for a good display of the max slider 
				vec2 temp_pos_max = new vec2(pos.x -(size.y *.5) +(size.x *max_norm), pos_max.y) ;
				max_norm = map(new_pos_max.x, pos_min.x, temp_pos_max.x, min_norm, max_norm) ;
			} else {
				new_pos_max.y = round(constrain(cursor.y -size_min_max.y, pos_min.y, pos_max.y)); // this line is not reworking for the vertical slider
			}
		}
		
	}
	
	// set min and max position
	public Sladj set_range(float min, float max) {
		this.min_norm = min;
		this.max_norm = max;
		return this;

	}

	@Deprecated
	public Sladj set_min_max(float min, float max) {
		this.min_norm = min;
		this.max_norm = max;
		return this;
	}

	public Sladj set_min(float min) {
		this.min_norm = min;
		return this;
	}

	public Sladj set_max(float max) {
		this.max_norm = max;
		return this;
	}
	
	
	
	
	
	
	
	
	
	// Display classic
	public void show_adj() {
		strokeWeight(thickness_adj) ;
		if(locked_min || locked_max || inside_max() || inside_min()) {
			aspect(fill_adj_in,stroke_adj_in,thickness_adj);
		} else {
			aspect(fill_adj_out,stroke_adj_out,thickness_adj);
		}

		vec2 pos = vec2(pos_min.x, pos_min.y +size_min_max.y *pos_norm_adj.y);
		vec2 size = vec2(size_min_max.x, size_min_max.y *size_norm_adj.y);
		rect(pos,size);
	}
	
	

	// INSIDE
	private boolean inside_min() {
		int x = round(pos_min.x);
		int y = round(pos_min.y +size_min_max.y *pos_norm_adj.y) ;
		vec2 temp_pos_min = new vec2(x,y);
		if(inside(temp_pos_min,size_molette_min_max,RECT)) {
			return true; 
		} else {
			return false;
		}
	}
	
	private boolean inside_max() {
		int x = round(pos_max.x);
		int y = round(pos_max.y +size_min_max.y *pos_norm_adj.y) ;
		vec2 temp_pos_max =  new vec2(x,y);
		if(inside(temp_pos_max, size_molette_min_max,RECT)) {
			return true; 
		} else {
			return false;
		}
	}
	
	//LOCKED
	private boolean locked_min() {
		if (inside_min() && mousePressed) {
			return true; 
		} else {
			return false;
		}
	}
	
	private boolean locked_max() {
		if (inside_max() && mousePressed) {
			return true; 
		} else {
			return false;
		}
	}
}




















