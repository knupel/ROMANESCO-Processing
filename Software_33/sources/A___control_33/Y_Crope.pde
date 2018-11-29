/**
CROPE
v 0.9.7
CONTROL ROMANESCO PROCESSING ENVIRONMENT
* Copyleft (c) 2018-2018
*
* @author Stan le Punk
* @see https://github.com/StanLepunK
* @see http://stanlepunk.xyz/
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
Crope info > Cropinfo
v 0.1.1
2018-2018
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
    return this.value;
  }

  public float get_value(int index){
    return this.value[index];
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
    for(int i = 0 ; i < value.length ;i++) {
      info += "value "+i+": "+value[i] + ", ";
    }
    info += "min: "+min+ ", ";
    info += "max: "+max+ ", ";
    info += "dropdown line: "+line+ ", ";
    return info;
  }
}











/**
class Crope
v 0.9.1
2018-2018
*/
public class Crope {
  protected iVec2 pos, size;
  protected iVec2 pos_ref;

  protected iVec2 cursor;

  protected int fill_in = color(g.colorModeX);
  protected int fill_out = color(g.colorModeX /2);
  protected int stroke_in = fill_in;
  protected int stroke_out = fill_out;
  protected float thickness = 0;
  protected int color_label_in = fill_in;
  protected int color_label_out = fill_out;

  protected float rounded = 0;
  // label
  protected int align = LEFT;
  protected String name = null;
  protected iVec2 pos_label;

  protected PFont font;
  protected int font_size = 0;

  protected int new_midi_value;
  protected int id_midi = -2 ;

  protected int id = -1;
  protected int dna = Integer.MIN_VALUE;

  private int rank;
  private int birth;

  private String type = "Crope";

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
  public Crope pos(int x, int y) {
    pos(iVec2(x,y));
    return this;
  }

  public Crope pos(iVec2 pos) {
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
  
  public Crope size(int x, int y) {
    size(iVec2(x,y));
    return this;
  }

  public Crope size(iVec2 size) {
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
  protected void cursor(iVec2 cursor) {
    cursor(cursor.x,cursor.y);
  }

  protected void cursor(int x, int y) {
    if(cursor == null) {
      cursor = iVec2(x,y);
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

  public Crope set_label(String name, iVec2 pos_label) {
    this.name = name;
    if(this.pos_label == null) {
      this.pos_label = iVec2(pos_label);
    } else {
      this.pos_label.set(pos_label);
    }
    return this;
  }
  public Crope set_pos_label(iVec2 pos) {
    set_pos_label(pos.x, pos.y);
    return this;
  }

  public Crope set_pos_label(int x, int y) {
    if(this.pos_label == null) {
      this.pos_label = iVec2(x,y);
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

  public iVec2 get_pos() {
    return pos;
  }

  public iVec2 get_size() {
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
CLASS BUTTON 
v 1.2.3
2013-2018
*/
public class Button extends Crope {
  int color_bg;

  int color_on_off;
  int color_in_ON, color_out_ON, color_in_OFF, color_out_OFF; 

  PImage [] pic;

  boolean inside;
  boolean authorization;
  boolean is = false;  

  protected Button() {
    super("Button");
  }

  //complexe
  /*
  public Button(int pos_x, int pos_y, int size_x, int size_y) {
    this.pos(pos_x, pos_y);
    this.size(size_x,size_y);
    super("Button");
  }
  */

  public Button(iVec2 pos, iVec2 size) {
    super("Button");
    this.pos(pos);
    this.size(size);
  }


  private Button(String type) {
    super(type);
  }

  //complexe
  /*
  private Button(String type, int pos_x, int pos_y, int size_x, int size_y) {
    this.pos(pos_x, pos_y);
    this.size(size_x,size_y);
    super(type);
  }
  */

  private Button(String type, iVec2 pos, iVec2 size) {
    super(type);
    this.pos(pos);
    this.size(size); 
  }

  /**
  Setting
  */
  public void set_is(boolean is) {
    this.is = is ;
  }

  public boolean is() {
    return is;
  }

  public void switch_is() {
    this.is = !this.is;
  }
  
  /**
  set
  */
  public Crope set_aspect_on_off(int color_in_ON, int color_out_ON, int color_in_OFF, int color_out_OFF) {
    this.color_in_ON = color_in_ON ; 
    this.color_out_ON = color_out_ON ; 
    this.color_in_OFF = color_in_OFF ; 
    this.color_out_OFF = color_out_OFF ;
    return this;
  }




  


  /**
  MISC
  */
  public void update(iVec2 cursor) {
    update(cursor.x, cursor.y);
  }

  public void update(int x, int y) {
    cursor(x,y);
    update(x,y,true);
  }

  public void update(int x, int y, boolean authorization) {
    cursor(x,y);
    this.authorization = authorization;
  }
  
  //ROLLOVER
  /**
  this method inside() must be refactoring, 
  it's not acceptable to have a def value inside
  */
  public boolean inside() {
    if(cursor == null) cursor = iVec2();
    float newSize = 1  ;
    if (size.y < 10 ) newSize = size.y *1.8 ; 
    else if (size.y >= 10 && size.y < 20  ) newSize = size.y *1.2 ;  
    else if (size.y >= 20 ) newSize = size.y ;
    
    if (cursor.x > pos.x && cursor.x < pos.x + size.x && cursor.y > pos.y  && cursor.y < pos.y +newSize) { 
      inside = true ;
      return true ; 
    } else {
      inside = false ;
      return false ; 
    }
  }
 






  /**
  SHOW BUTTON
  */
  /**
  PICTO
  */
  public void show_picto(PImage [] pic) {
    int correctionX = -1 ;
    if(pic[0] != null && pic[1] != null && pic[2] != null && pic[3] != null ) {
      if (is) {
        if (inside() && !authorization) {
          // inside
          image(pic[0],pos.x +correctionX, pos.y); 
        } else {
          // outside
          image(pic[1],pos.x +correctionX, pos.y);
        }
      } else {
        if (inside() && !authorization) {
          // inside
          image(pic[2],pos.x +correctionX, pos.y); 
        } else {
          // outside
          image(pic[3],pos.x +correctionX, pos.y);
        }
      }
    }
  }



  /**
  LABEL
  */
  public void show_label() {
    if(this.name != null) {
      if (is) {
        if (inside() && !authorization) {
          color_on_off = color_in_ON; 
        } else {
          color_on_off = color_out_ON;
        }
      } else {
        if (inside() && !authorization) {
          color_on_off = color_in_OFF; 
        } else {
          color_on_off = color_out_OFF;
        }
      }
      
      if(pos_label == null) {
        pos_label = iVec2();
      }

      if(font != null) textFont(font);
      if(font_size > 0) textSize(font_size);
      textAlign(align);
      fill(color_on_off);
      iVec2 pos_def = iadd(pos,pos_label);
      pos_def.y += size.y ;
      text(this.name,pos_def);
    }  
  }


  /**
  CLASSIC RECT BUTTON
  */
  public void button_rect(boolean on_off_is) {
    noStroke();
    if(on_off_is) {
      if (is) {
        if (inside() && !authorization) {
          color_on_off = color_in_ON; 
        } else {
          color_on_off = color_out_ON;
        }
      } else {
        if (inside() && !authorization) {
          color_on_off = color_in_OFF; 
        } else {
          color_on_off = color_out_OFF;
        }
      }
      fill(color_on_off);
    } else {
      fill(color_bg);
    }  
    rect(pos, size);
  }
}






/**
BUTTON DYNAMIC
*/
public class Button_dynamic extends Button {
  public iVec2 change_pos = iVec2() ;
  public Button_dynamic() {
    super("Button dynamic") ;
  }

  public Button_dynamic(iVec2 pos, iVec2 size) {
    super("Button dynamic",pos, size);
  }
  
  public void change_pos(int x, int y) {
    this.change_pos.set(x,y) ;
  }

  public void update_pos(boolean display_button) {
    if(!display_button) {
      pos.set(-100) ; 
    } else {
      pos.set(pos_ref) ;
      pos.add(change_pos) ;
    }
  }
}
























































/**
SLIDER
v 1.5.2
2013-2018
*/
boolean molette_already_selected ;
public class Slider extends Crope {
  protected boolean selected_type;
  
  protected Molette [] molette;

  private boolean init_molette_is = false ;

  protected iVec2 pos_min, pos_max;

  protected int fill_molette_in = color(g.colorModeX *.4);
  protected int fill_molette_out = color(g.colorModeX *.2);
  protected int stroke_molette_in = fill_molette_in;
  protected int stroke_molette_out = fill_molette_out;
  protected float thickness_molette = 0;

  protected float min_norm = 0 ;
  protected float max_norm = 1 ;

  protected int molette_type = RECT;

  boolean notch_is;
  int notches_num;
  int notch;
  
  public Slider(iVec2 pos, iVec2 size) {
    super("Slider");
    constructor(pos,size);
  }

  public Slider(String type, iVec2 pos, iVec2 size) {
    super(type);
    constructor(pos,size);
  }

  private void constructor(iVec2 pos, iVec2 size) {
    this.pos(pos);
    this.size(size);
    molette = new Molette[1];
    molette[0] = new Molette();
    this.set_pos_molette();
    size_molette(0);

    for(int i = 0 ; i < 1 ; i++) {
      molette[i].id = 0;
      molette[i].used_is = false;
      molette[i].inside_is = false;
      init_molette_is = true;
    }
    set_molette_min_max_pos();
  }
  


  private Slider set_molette_min_max_pos() {
    for(int i = 0 ; i < molette.length ; i++) {
      if(size.x > size.y) {
        pos_min = pos.copy();
        pos_max = iVec2(pos.x +size.x -molette[i].size.x, pos.y) ;
      } else {
        pos_min = pos.copy();
        pos_max = iVec2(pos.x, pos.y +size.y -molette[i].size.y) ;
      }
    }  
    return this;
  }



  /**
  MAIN METHOD
  */
  public void update(iVec2 cursor) {
    update(cursor.x, cursor.y);
  }

  public void update(int x, int y) {
    cursor(x,y);
    molette_update();
  }
  
  private boolean wheel_is;
  public void wheel(boolean wheel_is) {
    if(molette.length == 1) {
      this.wheel_is = wheel_is; 
    } else {
      printErrTempo(60, "method wheel(boolean wheel_is): Work only on mode single slider");
      this.wheel_is = false;
    } 
  }

  public boolean wheel_is() {
    return wheel_is;
  }

  




  /**
  UPDATE MOLETTE
  */
  protected void molette_update() {
    inside_slider();
    for(int i = 0 ; i < molette.length ; i++) {
      if(!molette[i].select_is) {
        selected_type = mousePressed;
        molette[i].used_is = select(i,molette_used_is(i),molette[i].used_is,true);
        if(molette[i].used_is) {
          mol_update_pos(i,temp_min(i),temp_max(i));
          mol_update_used(i,temp_min(i),temp_max(i));
          break;
        }   
      }
    }

    if(wheel_is()) {
      if(get_scroll() == null) {
        printErrTempo(60, "class Slider method molette_update(): the wheelEvent is innacessible \nmay be you must use method scroll(MouseEvent e) in void mouseWheel(MouseEvent e)");
      } else {
        if (size.x >= size.y) { 
          molette[0].pos.x -= get_scroll().x;
        } else { 
          molette[0].pos.y -= get_scroll().y;
        }
        mol_update_pos(0,temp_min(0),temp_max(0));
      }   
    }
  }
  

  private void mol_update_used(int index, iVec2 min, iVec2 max) {
    if (molette[index].used_is) {
      if (size.x >= size.y) { 
        molette[index].pos.x = round(constrain(cursor.x -(molette[index].size.x *.5), min.x, max.x));
      } else { 
        molette[index].pos.y = round(constrain(cursor.y -(molette[index].size.y *.5), min.y, max.y));
      }
    }
  }


  private void mol_update_pos(int index, iVec2 min, iVec2 max) {
    if(size.x >= size.y) {
      // for the horizontal slider
      if (molette[index].pos.x < min.x) {
        molette[index].pos.x = min.x;
      }
      if (molette[index].pos.x > max.x) {
        molette[index].pos.x = max.x;
      }
    } else {
      // for the vertical slider
      if (molette[index].pos.y < min.y) {
        molette[index].pos.y = min.y;
      }
      if (molette[index].pos.y > max.y) {
        molette[index].pos.y = max.y;
      }
    }
  }

  private iVec2 temp_min(int index) {
    iVec2 min = pos_min.copy();
    // def min
    if(molette.length > 1 && index > 0) {
      min.set(molette[index-1].pos);
      if(molette_type == ELLIPSE) {
       if(size.x >= size.y) {
          min.x += (size.y /2);
        } else {
          min.y += (size.x/2);
        }
      } else {
        if(size.x >= size.y) {
          min.x += size.y;
        } else {
          min.y += size.x;
        }  
      }
    }
    return min;
  }

  private iVec2 temp_max(int index) {
    iVec2 max = pos_max.copy();
     if(molette.length > 1 && index < molette.length -1) {
      max.set(molette[index+1].pos) ;
      if(molette_type == ELLIPSE) {
       if(size.x >= size.y) {
          max.x -= size.y;
        } else {
          max.y -= size.x;
        }
      } else {
        if(size.x >= size.y) {
          max.x -= size.y;
        } else {
          max.y -= size.x;
        }  
      }
    }
    return max;
  }
 





  





  // state information
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
    if (inside && selected_type) {
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
    selected_type = mousePressed;
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
    selected_type = authorization_1;
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

      if (!selected_type) { 
        result = false ; 
        molette_already_selected = false;
      }
      return result;
    } else return false;   
  }









  /**
  setting
  */
  public Slider set_molette(int type) {
    this.molette_type = type;
    return this;
  }

  private void init_molette(int len) {
    if(len != molette.length) {
      init_molette_is = false;
      molette = new Molette[len];
    }
    for(int i = 0 ; !init_molette_is && i < len ; i++) {
      molette[i] = new Molette();
      size_molette(i);
      molette[i].used_is = false;
      molette[i].inside_is = false;
      if(i == len-1) init_molette_is = true;
    }
  }

  
  // set size
  private void size_molette(int index) {
    if (size.x >= size.y) {
      molette[index].size = iVec2(size.y); 
    } else {
      molette[index].size = iVec2(size.x);
    }
  }

  public Slider size_molette(iVec2 size) {
    size_molette(size.x, size.y);
    return this;
  }

  public Slider size_molette(int x, int y) {
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

  public Slider set_pos_molette(iVec2... pos_mol) {
    init_molette(pos_mol.length);
    for(int i = 0 ; i < molette.length ; i++) {
      if(i < pos_mol.length) {
        set_pos_molette(i,pos_mol[i].x, pos_mol[i].y);
      } else {
        set_pos_molette(i,pos.x,pos.y);
      }
    }
    return this;
  }

  public Slider set_pos_molette(int index, int x, int y) {
    if(index < molette.length) {
      if(molette[index].pos == null) {
        molette[index].pos = iVec2(x,y);
      } else {
        molette[index].pos.set(x,y);
      }
    } 
    return this;
  }

  
  // set_molette
  public Slider set_molette_num(int num) {
    float [] pos_norm = new float[num];
    float step = 1. / (num+1) ;
    for(int i = 0 ; i < num ; i++) {
      pos_norm[i] = (i+1)*step;
    }
    set_molette_pos_norm(pos_norm);
    return this;
  }

  // Give a normal position between 0 and 1
  public Slider set_molette_pos_norm(float... pos_norm) {
    Arrays.sort(pos_norm);
    init_molette(pos_norm.length);
    for(int i = 0 ; i < molette.length ; i++) {
      molette[i].pos = iVec2();
      molette[i].id = i;
      // security to constrain the value in normalizing range.
      if(pos_norm[i] > 1.) pos_norm[i] = 1. ;
      if(pos_norm[i] < 0) pos_norm[i] = 0 ;
      // check if it's horizontal or vertical slider
      
      if(size.x >= size.y) {;
        int x = round(size.x *pos_norm[i] +pos_min.x -(molette[i].size.y *pos_norm[i])); 
        int y = pos.y;
        molette[i].pos.set(x,y);
      } else {
        int x = pos.x;
        int y = round(size.y *pos_norm[i] +pos_min.y -(molette[i].size.x *pos_norm[i]));
        molette[i].pos.set(x,y);
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


  public Slider set_aspect_molette(int f_c, int s_c, float thickness) {
    set_fill_molette(f_c,f_c);
    set_stroke_molette(s_c,s_c);
    set_thickness_molette(thickness);
    return this;
  }

  public Slider set_aspect_molette(int f_c_in, int f_c_out, int s_c_in,  int s_c_out, float thickness) {
    set_fill_molette(f_c_in,f_c_out);
    set_stroke_molette(s_c_in,s_c_out);
    set_thickness_molette(thickness);
    return this;
  }







  // display slider
  public void show_structure() {
    if(thickness > 0 && alpha(stroke_in) > 0 && alpha(stroke_out) > 0) {
      strokeWeight(thickness);
      if(inside_slider()) {
        fill(fill_in);
        stroke(stroke_in);
      } else {
        fill(fill_out);
        stroke(stroke_out);
      }    
    } else {
      noStroke();
      if(inside_slider()) {
        fill(fill_in);
      } else {
        fill(fill_out);
      }
    }

    if(rounded > 0) {
      rect(pos.x,pos.y,size.x,size.y,rounded);
    } else {
      rect(pos,size);
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
       textAlign(align);
       textFont(font);
       if(inside_slider()) {
        fill(color_label_in);
      } else {
        fill(color_label_out);
      }   
      text(name,add(pos,pos_label));
    }  
  }

  
  private void molette_shape(int index) {
    if(molette_type == ELLIPSE) {
      iVec2 temp = round(mult(molette[index].size,.5));
      iVec2 pos = iadd(molette[index].pos,temp);
      ellipse(pos,molette[index].size);
    } else if(molette_type == RECT) {
      molette_rect(index);
    } else {
      molette_rect(index);
    }
  }
  

  private void molette_rect(int index) {
    if(size.x > size.y) {
      iVec2 pos = molette[index].pos.copy();
      pos.y = pos.y -((molette[index].size.y -size.y)/2);
      rect(pos,molette[index].size);
    } else {
      iVec2 pos = molette[index].pos;
      pos.x = pos.x -((molette[index].size.x -size.x)/2);
      rect(pos,molette[index].size);
    }
  }
  





  
  // inside slider
  public boolean inside_slider() {
    if(inside(pos,size,cursor,RECT)) {
      return true ; 
    } else {
      return false ;
    }
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
    if(inside(molette[index].pos,molette[index].size,cursor,RECT)) {
      molette[index].inside_is = true ; 
    } else {
      molette[index].inside_is = false ;
    }
    return molette[index].inside_is;
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
    if(cursor == null) cursor = iVec2();
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
  //update the Midi position only if the Midi Button move
  public void update_midi(int... val) {
    if(val.length > molette.length) {
      printErr("method_midi(): there is too much midi value for the quantity of molette available.\nmethod apply only when is possible");
    }
    for(int i = 0 ; i < molette.length ; i++) {
      if(i < val.length) {
        update_midi(i, val[i]);
      } 
    }
  }

  public void update_midi(int index, int val) {
    //update the Midi position only if the Midi Button move
    if (new_midi_value != val) { 
      molette[index].new_midi_value = val ; 
      if(size.x >= size.y) {
        molette[index].pos.x = round(map(val, 1, 127, pos_min.x, pos_max.x));
      } else {
        molette[index].pos.y = round(map(val, 1, 127, pos_min.y, pos_max.y));
      }
    }
  }




  public float [] get_value() {
    float [] value = new float[molette.length];
    for(int i = 0 ; i < value.length ; i++) {
      if (size.x >= size.y) {
        value[i] = map (molette[i].pos.x, pos_min.x, pos_max.x, min_norm, max_norm); 
      } else {
        value[i] = map (molette[i].pos.y, pos_min.y, pos_max.y, min_norm, max_norm);
      }
    }
    return value ;
  }

  public float get_value(int index) {
    float value = Float.NaN ;
    if(index < molette.length) {
      if (size.x >= size.y) {
        value = map (molette[index].pos.x, pos_min.x, pos_max.x, min_norm, max_norm); 
      } else {
        value = map (molette[index].pos.y, pos_min.y, pos_max.y, min_norm, max_norm);
      }
    }
    return value ;
  }
  
  public float get_min_norm() {
    return min_norm ;
  }

  public float get_max_norm() {
    return max_norm ;
  }
  
  public iVec2 get_pos_min() {
    return pos_min;
  }

  public iVec2 get_pos_max() {
    return pos_max;
  }

  


  
  public iVec2 [] get_molette_pos() {
    iVec2 [] pos = new iVec2[molette.length] ;
    for(int i = 0 ; i < molette.length ;i++) {
      pos[i] = molette[i].pos.copy();
    }
    return pos;
  }

  public iVec2 get_molette_pos(int index) {
    if(index < molette.length && index >= 0) {
      return molette[index].pos;
    } else {
      printErr("method get_molette_pos(",index,") is out of the range");
      return null;
    }
  }

  public iVec2 get_molette_size(int index) {
    return molette[index].size;
  }


  public boolean inside_molette_is(int index) {
    return molette[index].inside_is;
  }
  

  // class Molette
  private class Molette {
    protected iVec2 size = iVec2();
    protected iVec2 pos = iVec2();
    protected int id =0;


    protected int new_midi_value;
    protected int id_midi = -2 ;

    protected boolean select_is;
    protected boolean used_is;
    protected boolean inside_is;

    Molette() {
    }


    private boolean select_is() {
      return select_is;
    }

    private boolean used_is() {
      return used_is;
    }

    private boolean inside_is() {
      return inside_is;
    }



    private void select(boolean state) {
      select_is = state;
    }

    private void used(boolean state) {
      used_is = state;
    }

    private void inside(boolean state) {
      inside_is = state;
    }
  }
}






















/**
SLOTCH > notch's slider
v 0.1.0
2018-2018
*/
public class Slotch extends Slider {
  float [] notches_pos ;
  int colour_notch = int(g.colorModeX);
  float thickness_notch = 1.;
  Slotch(iVec2 pos, iVec2 size) {
    super("Slotch",pos, size);   
  }




  public void update(int x, int y) {
    cursor(x,y);
    molette_update();
    if (size.x >= size.y) { 
      if(notch_is) {
        for(int i = 0 ; i < molette.length ; i++) {
          molette[i].pos.x = (int)pos_notch(size.x, molette[i].pos.x);
        }
        
      }
    } else { 
      if(notch_is) {
        for(int i = 0 ; i < molette.length ; i++) {
          molette[i].pos.y = (int)pos_notch(size.y, molette[i].pos.y);
        }
      }
    }
  }



  public Slotch set_notch(int num) {
    notch_is = true ;
    this.notches_num = num;
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

  private float pos_notch(int size, int pos_molette) {
    /**
    something must be improve when there is 3 notches
    */
    float pos = pos_molette;
    float step = size / get_notches_num();
    for(int i = 0 ; i < notches_pos.length ; i++) {
      float min = notches_pos[i] - (step *.5);
      float max = notches_pos[i] + (step *.5);
      if(pos > min && pos < max) {
        pos = notches_pos[i];
        break;
      }
    }
    return pos;
  }




  public float [] notches_position() {
    notches_pos = new float[get_notches_num()];
    float step = size.x / get_notches_num();
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



  public int get_notch() {
    return notch;
  }

  public int get_notches_num() {
    return notches_num;
  }
} 
























/**
SLADJ > SLIDER ADJUSTABLE
v 1.3.0
2016-2018
*/
public class Sladj extends Slider {
  // size
  protected iVec2 size_min_max;
  protected iVec2 size_molette_min_max;
  // pos  
  protected iVec2 new_pos_min;
  protected iVec2 new_pos_max;


  private Vec2 pos_norm_adj = Vec2(1,.5);
  private Vec2 size_norm_adj = Vec2(1.,.2);

  protected int fill_adj_in = color(g.colorModeX/2);
  protected int fill_adj_out = color(g.colorModeX /4);
  protected int stroke_adj_in = color(g.colorModeX/2);
  protected int stroke_adj_out = color(g.colorModeX /4);
  protected float thickness_adj = 0;

  private boolean locked_min, locked_max;
    
  Sladj(iVec2 pos, iVec2 size) {
    super("Sladj",pos, size);
    this.new_pos_max = iVec2();
    this.new_pos_min = pos.copy();
    this.size_min_max = size.copy();

    if (size.x >= size.y) {
      this.size_molette_min_max = iVec2(size.y); 
    } else {
      this.size_molette_min_max = iVec2(size.x) ;
    }
  }
  /*
  //slider with external molette
  public Sladj(iVec2 pos, iVec2 size, iVec2 size_molette, int moletteShapeType) {
    super(pos,size);
    size_molette(size_molette);
    set_molette(moletteShapeType);
    this.new_pos_max = iVec2();
    this.new_pos_min = iVec2();
    this.size_min_max = size.copy();
    this.size_molette_min_max = iVec2(size_molette);
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
    float newNormSize = max_norm -min_norm ;
    
    if (size.x >= size.y) size_min_max = iVec2(round(size.x *newNormSize), size.y) ; else size_min_max = iVec2(round(size.y *newNormSize), size.x) ;
    
    pos_min = iVec2(round(pos.x +(size.x *min_norm)), pos.y) ;
    // in this case the detection is translate on to and left of the size of molette
    // we use the molette[0] to set the max. there is at least one molette by slider :)
    pos_max = iVec2(round(pos.x -molette[0].size.x +(size.x *max_norm)), pos.y); 
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
        pos_max = iVec2(round(pos.x -molette[0].size.x +(size.x *max_norm)), pos.y) ;
        // we use a temporary position for a good display of the max slider 
        Vec2 tempPosMax = Vec2(pos.x -(size.y *.5) +(size.x *max_norm), pos_max.y) ;
        max_norm = map(new_pos_max.x, pos_min.x, tempPosMax.x, min_norm, max_norm) ;
      } else {
        new_pos_max.y = round(constrain(cursor.y -size_min_max.y, pos_min.y, pos_max.y)); // this line is not reworking for the vertical slider
      }
    }
    
  }
  
  // set min and max position
  public Sladj set_min_max(float min_norm, float max_norm) {
    min_norm = min_norm;
    max_norm = max_norm;
    return this;
  }

  public Sladj set_min(float min_norm) {
    min_norm = min_norm;
    return this;
  }

  public Sladj set_max(float max_norm) {
    max_norm = max_norm;
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

    Vec2 pos = Vec2(pos_min.x, pos_min.y +size_min_max.y *pos_norm_adj.y);
    Vec2 size = Vec2(size_min_max.x, size_min_max.y *size_norm_adj.y);
    rect(pos,size);
  }
  
  

  // INSIDE
  private boolean inside_min() {
    int x = round(pos_min.x);
    int y = round(pos_min.y +size_min_max.y *pos_norm_adj.y) ;
    iVec2 temp_pos_min = iVec2(x,y);
    if(inside(temp_pos_min,size_molette_min_max,cursor,RECT)) return true ; else return false ;
  }
  
  private boolean inside_max() {
    int x = round(pos_max.x);
    int y = round(pos_max.y +size_min_max.y *pos_norm_adj.y) ;
    iVec2 temp_pos_max =  iVec2(x,y);
    if(inside(temp_pos_max, size_molette_min_max,cursor,RECT)) return true ; else return false ;
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






















