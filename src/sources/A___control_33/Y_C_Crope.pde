/**
* CROPE
* Control ROmanesco Processing Environment
* v 0.11.2
* Copyleft (c) 2018-2019

* dependencies
* Processing 3.5.3
* Rope library 0.8.5.30
* @author @stanlepunk
* @see https://github.com/StanLepunK/Crope
*/
import java.util.Arrays;
import rope.vector.*;
import rope.core.R_Image;

/**
Crope Manager
v 0.0.1
2018-2018
*/
int birth_crope = 0;
ArrayList<Crope> object_crope ;

ArrayList<Crope> get_crope() {
  return object_crope;
}





/**
class Crope
v 0.11.4
2018-2019
*/
public class Crope {
  protected vec2 pos, size;
  protected vec2 pos_ref;

  protected vec2 cursor = new vec2();
  protected boolean event = mousePressed;
  protected boolean use_event_is = false;

  protected int fill_in = r.GRAY[4];
  protected int fill_out = r.GRAY[10];
  protected int stroke_in = fill_in;
  protected int stroke_out = fill_out;
  protected float thickness = 0;
  protected int color_label_in = fill_in;
  protected int color_label_out = fill_out;

  protected float rounded = 0;
  // label
  protected int align_label_name = LEFT;
  protected int align_label_value = RIGHT;
  protected String name = null;
  protected vec2 pos_label = new vec2(0,-2);
  protected vec2 pos_value = new vec2(0,-2);

  protected PFont font;
  protected int font_size = 0;

  protected int midi_value;
  protected int id_midi = -2 ;

  protected int id = -1;
  protected int dna = Integer.MIN_VALUE;

  private int rank;
  private int birth;

  private String type = "Crope";
  private int rollover_type = RECT;

  protected boolean crope_build_is = false;

  public Crope(String type) {
    this.birth = birth_crope++;
    this.type = type;
    add_crope(this);
    dna = floor(random(Integer.MIN_VALUE,Integer.MAX_VALUE));
    if(dna == 0) dna = 1;
  }







  /**
  set structure
  */
  public Crope pos(float x, float y) {
    pos(new vec2(x,y));
    return this;
  }

  public Crope pos(vec2 pos) {
    if(this.pos == null || !this.pos.equals(pos)) {
      if(this.pos == null) {
        this.pos = pos.copy();
        this.pos_ref = pos.copy();
      } else {
        this.pos.set(pos);
        this.pos_ref.set(pos);
      }
    }
    return this;
  }

  public Crope size(float size) {
    size(new vec2(size));
    return this;
  }
  
  public Crope size(float w, float h) {
    size(new vec2(w,h));
    return this;
  }

  public Crope size(vec2 size) {
    if(this.size == null || !this.size.equals(size)) {
      if(this.size == null) {
        this.size = size.copy();
      } else {
        this.size.set(size);
      }
    }
    return this;
  }


  /**
  private
  */
  protected void cursor(vec2 cursor) {
    cursor(cursor.x(),cursor.y());
  }

  protected void cursor(float x, float y) {
    if(cursor == null) {
      cursor = new vec2(x,y);
    } else {
      cursor.set(x,y);
    }
  }

  
  /**
  set colour
  */
  public Crope set_fill(int c) {
    set_fill(c,c);
    return this;
  }

  public Crope set_fill(int c_in, int c_out) {
    this.fill_in = c_in;
    this.fill_out = c_out;
    return this;
  }
  
  public Crope set_stroke(int c) {
    set_stroke(c,c);
    return this;
  }

  public Crope set_stroke(int c_in, int c_out) {
    this.stroke_in = c_in;
    this.stroke_out = c_out;
    return this;
  }

  public Crope set_thickness(float thickness) {
    this.thickness = thickness;
    return this;
  }


  public Crope set_aspect(int f_c, int s_c, float thickness) {
    set_fill(f_c,f_c);
    set_stroke(s_c,s_c);
    set_thickness(thickness);
    return this;
  }

  public Crope set_aspect(int f_c_in, int f_c_out, int s_c_in,  int s_c_out, float thickness) {
    set_fill(f_c_in,f_c_out);
    set_stroke(s_c_in,s_c_out);
    set_thickness(thickness);
    return this;
  }







  public Crope set_rounded(float rounded) {
    this.rounded = rounded;
    return this;
  }

  // set label
  public Crope set_name(String name) {
    this.name = name;
    return this;
  }

  public Crope set_label(String name) {
    this.name = name;
    return this;
  }

  public Crope set_label(String name, float x, float y) {
    this.name = name;
    if(this.pos_label == null) {
      this.pos_label = new vec2(x,y);
    } else {
      this.pos_label.set(x,y);
    }
    return this;
  }
  
  public Crope set_label(String name, vec2 pos_label) {
    set_label(name, pos_label.x(), pos_label.y());
    return this;
  }

  public Crope set_pos_label(vec2 pos) {
    set_pos_label(pos.x(),pos.y());
    return this;
  }

  public Crope set_pos_label(float x, float y) {
    if(this.pos_label == null) {
      this.pos_label = new vec2(x,y);
    } else {
       this.pos_label.set(x,y);
    }
    return this;
  }

  public Crope set_pos_value(vec2 pos) {
    set_pos_label(pos.x(),pos.y());
    return this;
  }

  public Crope set_pos_value(float x, float y) {
    if(this.pos_value == null) {
      this.pos_value = new vec2(x,y);
    } else {
       this.pos_value.set(x,y);
    }
    return this;
  }



  public Crope set_fill_label(int c) {
    set_fill_label(c,c);
    return this;
  }

  public Crope set_fill_label(int c_in, int c_out) {
    this.color_label_in = c_in;
    this.color_label_out = c_out;
    return this;
  }

  public Crope set_align_label_name(int align) {
    this.align_label_name = align;
    return this;
  }

  public Crope set_align_label_value(int align) {
    this.align_label_value = align;
    return this;
  }

  /**
  font
  */
  public Crope set_font(PFont font) {
    this.font = font;
    return this;
  }

  public Crope set_font(String font_name, int size) {
    this.font = createFont(font_name,size);
    return this;
  }

  public Crope set_font_size(int font_size) {
    this.font_size = font_size;
    return this; 
  }
  





  // set midi
  public Crope set_id_midi(int id_midi) {
    this.id_midi = id_midi;
    return this;
  }

  public Crope set_id(int id) {
    this.id = id;
    return this;
  }

  public Crope set_rank(int rank) {
    this.rank = rank;
    return this;
  }


  // set misc
  public Crope set_rollover_type(int rollover_type) {
    this.rollover_type = rollover_type;
    return this;
  }



  /**
  get
  */
  public vec2 pos() {
    return pos;
  }

  public vec2 size() {
    return size;
  }

  public int get_rollover_type() {
    return this.rollover_type;
  }

  public int get_dna() {
    return dna;
  }

  public String get_name() {
    return name;
  }

  public String get_label() {
    return get_name();
  }

  //give the IDmidi 
  public int get_id_midi() { 
    return this.id_midi ; 
  }

  public int get_id() {
    return this.id;
  }


  public PFont get_font() {
    return font;
  }

  public int get_rank() {
    return rank;
  }

  public int get_birth() {
    return birth;
  }

  public String get_type() {
    return type;
  }



  // add crop
  public void add_crope(Crope crope) {
    if(object_crope == null) {
      object_crope = new ArrayList<Crope>();
    }
    object_crope.add(crope);
  }

  

  // inside crope
  protected boolean inside() {
    return inside(pos, size, rollover_type);
  }

  protected boolean inside(int shape_type) {
    return inside(pos,size,shape_type);
  }

  protected boolean inside(vec2 pos, vec2 size, int shape_type) {
    if(shape_type == ELLIPSE) {
      // this part can be improve to check the 'x' and the 'y'
      vec2 offset = pos.copy().add(size().copy().mult(.5));
      if (offset.dist(cursor) < size.x() *.5) return true ; 
      // if (dist(offset,cursor) < size.x() *.5) return true ; 
      else return false ;
    } else {
      if(cursor.x() > pos.x && cursor.x() < pos.x() +size.x() && 
         cursor.y() > pos.y && cursor.y() < pos.y() +size.y()) return true; 
        else return false ;
    }
  }
}




































































/**
* Molette
* v 0.1.1
* 2019-2019
*/
public class Molette {
  public vec2 size = new vec2();
  public vec2 pos = new vec2();
  private vec2 offset;

  private float angle = 0;
  private float dist = 0;

  private float value = 0;
  public int id = 0;

  public int id_midi = -2;

  private int shape_type = ELLIPSE;

  public boolean select_is;
  public boolean used_is;
  public boolean inside_is;

  protected int fill_in = color(g.colorModeX *.4);
  protected int fill_out = color(g.colorModeX *.2);
  protected int stroke_in = fill_in;
  protected int stroke_out = fill_out;

  protected int fill_in_ON = color(g.colorModeX *.4);
  protected int fill_out_ON = color(g.colorModeX *.2);
  protected int stroke_in_ON = fill_in;
  protected int stroke_out_ON = fill_out;

  protected float thickness = 0;

  public Molette() { }
  

  public Molette set(float value) {
    this.value = value;
    return this;
  }

  public Molette size(float w, float h) {
    this.size.set(w,h);
    return this;
  }

  public Molette pos(float x, float y) {
    this.pos.set(x,y);
    return this;
  }

  public Molette pos(vec2 pos) {
    this.pos.set(pos);
    return this;
  }

  public Molette angle(float angle) {
    this.angle = angle;
    return this;
  }

  public Molette set_distance(float dist) {
    this.dist = dist;
    return this;
  }

  public Molette set_offset(vec2 offset) {
    if(this.offset == null) {
      this.offset = new vec2(offset);
    } else {
      this.offset.set(offset);
    }
    return this;
  }

  public Molette set_shape_type(int shape_type) {
    this.shape_type = shape_type;
    return this;
  }

  public Molette set_id_midi(int id_midi) {
    this.id_midi = id_midi;
    return this;
  }

  public Molette set_id(int id) {
    this.id = id;
    return this;
  }

  public Molette fill_in(int c) {
    this.fill_in = c;
    return this;
  }

  public Molette fill_out(int c) {
    this.fill_out = c;
    return this;   
  }

  public Molette stroke_in(int c) {
    this.stroke_in = c;
    return this;   
  }

  public Molette stroke_out(int c) {
    this.stroke_out = c;
    return this; 
  }

  public Molette fill_in_OFF(int c) {
    fill_in(c);
    return this;
  }

  public Molette fill_out_OFF(int c) {
    fill_out(c);
    return this;   
  }

  public Molette stroke_in_OFF(int c) {
    stroke_in(c);
    return this;   
  }

  public Molette stroke_out_OFF(int c) {
    stroke_out(c);
    return this; 
  }

  public Molette fill_in_ON(int c) {
    this.fill_in = c;
    return this;
  }

  public Molette fill_out_ON(int c) {
    this.fill_out_ON = c;
    return this;   
  }

  public Molette stroke_in_ON(int c) {
    this.stroke_in_ON = c;
    return this;   
  }

  public Molette stroke_out_ON(int c) {
    this.stroke_out_ON = c;
    return this; 
  }

  public Molette thickness(float thickness){
    this.thickness = thickness;
    return this;
  }



  public void select(boolean state) {
    select_is = state;
  }

  public void used(boolean state) {
    used_is = state;
  }

  



  /**
  * get
  */
  public float get() {
    return value;
  }

  public vec2 pos() {
    return this.pos;
  }

  public vec2 size() {
    return this.size;
  }

  public float angle() {
    return this.angle;
  }

  public float get_distance() {
    return dist;
  }

  public int get_shape_type() {
    return this.shape_type;
  }

  public int get_id() {
    return id;
  }

  public int get_midi() {
    return id_midi;
  }

  public boolean select_is() {
    return select_is;
  }

  public boolean used_is() {
    return used_is;
  }

  public boolean inside_is() {
    return inside_is;
  }


  //show
  public void show() {
    aspect(true);
    push();
    if(offset != null ) {
      translate(add(offset,pos));
    } else {
      translate(pos);
    }
    if(shape_type == ELLIPSE) {
      ellipse(vec2(),size);
    } else if(shape_type == RECT) {
      vec2 temp_pos = pos.copy().sub(size.copy().mult(.5));
      rotate(angle);
      rect(size.copy().mult(.5).mult(-1),size);
    } else {
      ellipse(vec2(),size);
    }
    pop();
  }

  private void aspect(boolean on_off) { 
    if(on_off) {
      if(inside_is()) {
        if(select_is()) {
          fill(fill_in_ON);
        } else {
          fill(fill_in);
        }
      } else {
        if(select_is()) {
          fill(fill_out_ON);
        } else {
          fill(fill_out);
        }
      }
    } else {
      fill(fill_in);
      stroke(stroke_in);
      strokeWeight(thickness);
    }
  }


  public void inside_is(boolean state) {
    inside_is = state;
  }

  public boolean inside(vec2 cursor) {
    vec2 temp_pos = pos;
    // if offset is use to catch the crope position
    if(offset != null) {
      temp_pos = pos.copy().add(offset);
    }

    if(shape_type == ELLIPSE) {
      if(temp_pos.dist(cursor) < size.x() *.5) return true; 
      else return false ;
    } else {
      temp_pos.sub(size.copy().mult(.5));
      if(cursor.x() > temp_pos.x && cursor.x() < temp_pos.x() +size.x() && 
         cursor.y() > temp_pos.y && cursor.y() < temp_pos.y() +size.y()) return true; 
        else return false ;
    }
  }
}




























































/**
* Crope info > Cropinfo
* v 0.1.2
* 2018-2019
*/
public class Cropinfo {
  private int rank = -1;
  private int id = -1;
  private int dna = Integer.MIN_VALUE;
  private int id_midi = -1;
  private String name = null;
  private String type = null;
  private boolean is; // button
  private float[] value; // slider
  private float min = 0; // slider
  private float max = 1; // slider
  private int line = -1; // dropdown
  
  public Cropinfo() {
    //
  }
  
  // set
  public Cropinfo set_rank(int rank){
    this.rank = rank;
    return this;
  }

  public Cropinfo set_id(int id){
    this.id = id;
    return this;
  }

  public Cropinfo set_dna(int dna){
    this.dna = dna;
    return this;
  }

  public Cropinfo set_id_midi(int id_midi){
    this.id_midi = id_midi;
    return this;
  }

  public Cropinfo set_name(String name){
    this.name = name;
    return this;
  }

  public Cropinfo set_type(String type){
    this.type = type;
    return this;
  }
  
  // set button info
  public Cropinfo set_is(boolean is){
    this.is = is;
    return this;
  }

  // set slider info
  public Cropinfo set_value(float... value){
    this.value = new float[value.length];
    for(int i = 0 ; i < this.value.length ; i++) {
      this.value[i] = value[i];
    }
    return this;
  }

  public Cropinfo set_min(float min){
    this.min = min;
    return this;
  }
  
  public Cropinfo set_max(float max){
    this.max = max;
    return this;
  }
  
  // set dropdown 
  public Cropinfo set_line(int line){
    this.line = line;
    return this;
  }

  // get crope info
  public int get_rank(){
    return this.rank;
  }

  public int get_id(){
    return this.id;
  }

  public int get_dna(){
    return this.dna;
  }

  public int get_id_midi(){
    return this.id_midi;
  }

  public String get_name(){
    return this.name;
  }

  public String get_type(){
    return this.type;
  }
  
  // get button info
  public boolean get_is(){
    return this.is;
  }
  
  // get slider info
  public float [] get_value(){
    if(this.value == null) {
      return null;
    }
    return this.value;
  }

  public float get_value(int index){
    if(this.value != null && index < this.value.length && index >= 0) {
      return this.value[index];
    } else if(this.value == null) {
      System.err.println("class Cropinfo method get_value(): value is null, may be you need to init it");
      return 0;    
    } else {
      System.err.println("class Cropinfo method get_value( " + index + " ) is out of the range first value is return");
      return this.value[0];  
    }    
  }

  public float get_min(){
    return this.min;
  }
  
  public float get_max(){
    return this.max;
  }
  
  // get dropdown info
  public int get_line(){
    return this.line;
  }

  @Override String toString() {
    String info = "";
    info += "type: "+type + ", ";
    info += "rank: "+rank + ", ";
    info += "name: "+name + ", ";
    info += "id: "+id + ", ";
    info += "midi: "+id_midi + ", ";
    info += "is: "+is + ", ";
    if(value == null) {
      value = new float[1];
      value[0] = 0;
    }
    for(int i = 0 ; i < value.length ;i++) {
      info += "value "+i+": "+value[i] + ", ";
    }
    info += "min: "+min+ ", ";
    info += "max: "+max+ ", ";
    info += "dropdown line: "+line+ ", ";
    return info;
  }
}




























