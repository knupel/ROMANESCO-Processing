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
v 0.10.2
2018-2019
*/
public class Crope {
  protected vec2 pos, size;
  protected vec2 pos_ref;

  protected vec2 cursor = new vec2();

  protected int fill_in = r.GRAY[4];
  protected int fill_out = r.GRAY[10];
  protected int stroke_in = fill_in;
  protected int stroke_out = fill_out;
  protected float thickness = 0;
  protected int color_label_in = fill_in;
  protected int color_label_out = fill_out;

  protected float rounded = 0;
  // label
  protected int align = LEFT;
  protected String name = null;
  protected vec2 pos_label;

  protected PFont font;
  protected int font_size = 0;

  protected int midi_value;
  protected int id_midi = -2 ;

  protected int id = -1;
  protected int dna = Integer.MIN_VALUE;

  private int rank;
  private int birth;

  private String type = "Crope";

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
    set_label(name, pos_label.x, pos_label.y);
    return this;
  }

  public Crope set_pos_label(vec2 pos) {
    set_pos_label(pos.x,pos.y);
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

  public Crope set_fill_label(int c) {
    set_fill_label(c,c);
    return this;
  }

  public Crope set_fill_label(int c_in, int c_out) {
    this.color_label_in = c_in;
    this.color_label_out = c_out;
    return this;
  }

  public Crope set_align_label(int align) {
    this.align = align;
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



  /**
  get
  */
  public int get_dna() {
    return dna;
  }

  public vec2 get_pos() {
    return pos;
  }

  public vec2 get_size() {
    return size;
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


  public void add_crope(Crope crope) {
    if(object_crope == null) {
      object_crope = new ArrayList<Crope>();
    }
    object_crope.add(crope);
  }
}


























































/**
* CLASS BUTTON 
* v 1.6.0
* 2013-2019
*/
public class Button extends Crope {
  
  protected int color_bg = r.GRAY[2];

  protected int color_on_off = r.GRAY[10];

  protected int color_in_ON = r.GRAY[10];
  protected int color_out_ON = r.GRAY[18];

  protected int color_in_OFF = fill_in;
  protected int color_out_OFF = fill_out;

  protected PImage [] pic;

  protected boolean inside;
  protected boolean authorization;
  protected boolean is = false;  

  public vec2 offset;

  protected Button() {
    super("Button");
  }

  private Button(String type) {
    super(type);
  }

  private Button(String type, vec2 pos, vec2 size) {
    super(type);
    this.pos(pos);
    this.size(size); 
  }


  public Button(vec2 pos, vec2 size) {
    super("Button");
    this.pos(pos);
    this.size(size);
  }


  public void set_is(boolean is) {
    this.is = is ;
  }

  public boolean is() {
    return is;
  }

  public void switch_is() {
    this.is = !this.is;
  }
  

  public Crope set_colour_in_on(int c) {
    this.color_in_ON = c;
    return this;
  }

  public Crope set_colour_out_on(int c) {
    this.color_out_ON = c;
    return this;
  }


  public Crope set_colour_in_off(int c) {
    this.color_in_OFF = c;
    return this;
  }


  public Crope set_colour_out_off(int c) {
    this.color_out_OFF = c;
    return this;
  }
  
  @Deprecated
  public Crope set_aspect_on_off(int color_in_ON, int color_out_ON, int color_in_OFF, int color_out_OFF) {
    set_colour_in_on(color_in_ON);
    set_colour_in_off(color_in_OFF);
    set_colour_out_on(color_out_ON);
    set_colour_out_off(color_out_OFF);
    return this;
  }


  public void update(float x, float y) {
    cursor(x,y);
  }


  /**
  * offset
  */
  public void offset(float x, float y) {
    if(offset == null) {
      this.offset = new vec2(x,y);
    } else {
      this.offset.set(x,y);
    }
  }

  public void offset_is(boolean display_button) {
    if(!display_button) {
      pos.set(-100) ; 
    } else {
      pos.set(pos_ref);
      pos.add(offset);
    }
  }




  

  public void rollover(boolean authorization) {
    this.authorization = authorization;
  }
  
  //ROLLOVER
  /**
  this method inside() must be refactoring, 
  it's not acceptable to have a def value inside
  */
  public boolean inside() {
    if(cursor == null) cursor = new vec2();
    float new_size = 1  ;
    if (size.y < 10 ) new_size = size.y() *1.8 ; 
    else if (size.y() >= 10 && size.y() < 20  ) new_size = size.y() *1.2 ;  
    else if (size.y() >= 20 ) new_size = size.y();
    
    if (cursor.x() > pos.x() && cursor.x() < pos.x() + size.x() && cursor.y() > pos.y() && cursor.y() < pos.y() +new_size) { 
      inside = true ;
      return true ; 
    } else {
      inside = false ;
      return false ; 
    }
  }
 



  



  /**
  LABEL
  */
  public void show_label() {
    if(this.name != null) {
      if (is) {
        if (inside() && authorization) {
          color_on_off = color_in_ON; 
        } else {
          color_on_off = color_out_ON;
        }
      } else {
        if (inside() && authorization) {
          color_on_off = color_in_OFF; 
        } else {
          color_on_off = color_out_OFF;
        }
      }
      
      if(pos_label == null) {
        pos_label = new vec2();
      }
      // display text
      if(font != null) textFont(font);
      if(font_size > 0) textSize(font_size);
      textAlign(align);
      fill(color_on_off);
      vec2 pos_def = add(pos,pos_label);
      pos_def.y(pos_def.y() +size.y());
      //pos_def.y() += size.y();
      text(this.name,vec2(pos_def));
    }  
  }

  public void show() {
    show(ELLIPSE,true);
  }

  public void show(int kind, boolean on_off_is) {
    if(kind == RECT) {
      aspect(on_off_is);
      rect(vec2(pos),vec2(size));
    } else if(kind == ELLIPSE) {
      aspect(on_off_is);
      vec2 final_size = vec2(size);
      vec2 final_pos = vec2(pos).add(final_size.copy().mult(.5));
      ellipse(final_pos,final_size);
    }
  }


  public void show(PImage [] pic) {
    int correctionX = -1 ;
    if(pic.length == 4) {
      if (is) {
        if (inside() && authorization) {
          // inside
          image(pic[0],pos.x +correctionX, pos.y); 
        } else {
          // outside
          image(pic[1],pos.x +correctionX, pos.y);
        }
      } else {
        if (inside() && authorization) {
          // inside
          image(pic[2],pos.x +correctionX, pos.y); 
        } else {
          // outside
          image(pic[3],pos.x +correctionX, pos.y);
        }
      }
    }
  }


  private void aspect(boolean on_off_is) {
    noStroke();
    if(on_off_is) {
      if (is) {
        if (inside() && authorization) {
          color_on_off = color_in_ON; 
        } else {
          color_on_off = color_out_ON;
        }
      } else {
        if (inside() && authorization) {
          color_on_off = color_in_OFF; 
        } else {
          color_on_off = color_out_OFF;
        }
      }
      fill(color_on_off);
    } else {
      fill(color_bg);
    }  
  }
}








/**
* Buturn
* v 0.0.1
* 2019-2019
*/
public class Butturn extends Button {
  protected int molette_type = ELLIPSE;
  protected Molette molette;
  public Butturn(vec2 pos, float size) {
    super("Turn button");
    this.pos(pos);
    this.size(size);
    this.molette = new Molette();
  }


  public Butturn set_molette(int type) {
    this.molette_type = type;
    return this;
  }


  // set size
  public Butturn set_size_molette(vec2 size) {
    return this;
  }

  public Butturn set_size_molette(float w, float h) {
    return this;
  }


  public Butturn set_pos_molette(float dist) {
    return this;
  }


  // draw
  public void update(float x, float y) {
    cursor(x,y);
    molette_update();
  }

  private void molette_update() {
    if(molette.select_is()) {


    }
  }




  
  // show
  public void show_molette() {
    float angle = pos.angle(cursor);

  }
}









/**
* Molette
* v 0.1.0
* 2019-2019
*/
public class Molette {
  public vec2 size = new vec2();
  public vec2 pos = new vec2();

  private float value = 0;
  public int id = 0;

  public int id_midi = -2;

  public boolean select_is;
  public boolean used_is;
  public boolean inside_is;

  public Molette() { }
  



  public void set(float value) {
    this.value = value;
  }

  public void set_id_midi(int id_midi) {
    this.id_midi = id_midi;
  }

  public void set_id(int id) {
    this.id = id;
  }

  public void select(boolean state) {
    select_is = state;
  }

  public void used(boolean state) {
    used_is = state;
  }

  public void inside(boolean state) {
    inside_is = state;
  }



  /**
  * get
  */
  public float get() {
    return value;
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
      printErr("class Cropinfo method get_value(): value is null, may be you need to init it");
      return 0;    
    } else {
      printErr("class Cropinfo method get_value(",index,") is out of the range first value is return");
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




























