/**
CROPE
v 0.1.1
CONTROL ROMANESCO PROCESSING ENVIRONMENT
* Copyleft (c) 2018-2018
*
* @author Stan le Punk
* @see https://github.com/StanLepunK
* @see http://stanlepunk.xyz/
*/
abstract class Crope {
  protected iVec2 pos, size;
  protected iVec2 pos_ref;

  protected int fill_in = color(g.colorModeX);
  protected int fill_out = color(g.colorModeX /2);
  protected int stroke_in = fill_in;
  protected int stroke_out= fill_out;
  protected float thickness = 0;
  protected int color_label = color(g.colorModeX);

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

  private int rank;

  /**
  set structure
  */
  public void set_pos(int x, int y) {
    set_pos(iVec2(x,y));
  }

  public void set_pos(iVec2 pos) {
    if(this.pos == null || !this.pos.equals(pos)) {
      if(this.pos == null) {
        this.pos = pos.copy();
        this.pos_ref = pos.copy();
      } else {
        this.pos.set(pos);
        this.pos_ref.set(pos);
      }
    }
  }
  
  public void set_size(int x, int y) {
    set_size(iVec2(x,y));
  }

  public void set_size(iVec2 size) {
    if(this.size == null || !this.size.equals(size)) {
      if(this.size == null) {
        this.size = size.copy();
      } else {
        this.size.set(size);
      }
    }
  }
  
  public void set_fill(int c) {
    set_fill(c,c);
  }

  public void set_fill(int c_in, int c_out) {
    this.fill_in = c_in;
    this.fill_out = c_out;
  }
  
  public void set_stroke(int c) {
    set_stroke(c,c);
  }

  public void set_stroke(int c_in, int c_out) {
    this.stroke_in = c_in;
    this.stroke_out = c_out;
  }






  public void set_thickness(float thickness) {
    this.thickness = thickness;
  }


  public void set_rounded(float rounded) {
    this.rounded = rounded;
  }

  // set label
  public void set_name(String name) {
    this.name = name;
  }

  public void set_label(String name) {
    this.name = name;
  }

  public void set_label(String name, iVec2 pos_label) {
    this.name = name;
    if(this.pos_label == null) {
      this.pos_label = iVec2(pos_label);
    } else {
      this.pos_label.set(pos_label);
    } 
  }
  public void set_pos_label(iVec2 pos) {
    set_pos_label(pos.x, pos.y);
  }

  public void set_pos_label(int x, int y) {
    if(this.pos_label == null) {
      this.pos_label = iVec2(x,y);
    } else {
       this.pos_label.set(x,y);
    } 
  }

  public void set_colour_label(int c) {
    this.color_label = c;
  }

  public void set_align_label(int align) {
    this.align = align;  
  }

  /**
  font
  */
  public void set_font(PFont font) {
    this.font = font; 
  }

  public void set_font(String font_name, int size) {
    this.font = createFont(font_name,size);
  }

  public void set_font_size(int font_size) {
    this.font_size = font_size; 
  }
  





  // set midi
  public void set_id_midi(int id_midi) {
    this.id_midi = id_midi;
  }

  public void set_id(int id) {
    this.id = id;
  }

  public void set_rank(int rank) {
    this.rank = rank;
  }







  /**
  get
  */
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

  public int get_rank() {
    return rank;
  }

  public PFont get_font() {
    return font;
  }
}





















/**
CROPE
CONTROL ROMANESCO PROCESSING ENVIRONMENT
*
CLASS BUTTON 1.1.0
*/
public class Button extends Crope {
  int color_bg;
  int color_bg_in, color_bg_out;

  int color_on_off;
  int color_in_ON, color_out_ON, color_in_OFF, color_out_OFF; 

  PImage [] pic;

  boolean inside;
  boolean authorization;
  boolean is = false;  

  protected Button() {}

  //complexe
  public Button(int pos_x, int pos_y, int size_x, int size_y) {
    set_pos(pos_x, pos_y);
    set_size(size_x,size_y);
  }

  public Button(iVec2 pos, iVec2 size) {
    set_pos(pos);
    set_size(size);
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
  public void set_colour_on_off(int color_in_ON, int color_out_ON, int color_in_OFF, int color_out_OFF) {
    this.color_in_ON = color_in_ON ; 
    this.color_out_ON = color_out_ON ; 
    this.color_in_OFF = color_in_OFF ; 
    this.color_out_OFF = color_out_OFF ;
  }

  public void set_colour_structure(int color_bg_in, int color_bg_out) {
    this.color_bg_in = color_bg_in ; 
    this.color_bg_out = color_bg_out ;
  }



  



  /**
  MISC
  */
  public void update() {
    update(true);
  }

  public void update(boolean authorization) {
    this.authorization =  authorization;
    if (rollover()) {
      is = !is ? true : false ;
    }
  }
  
  //ROLLOVER
  /**
  this method rollover() must be refactoring, 
  it's not acceptable to have a def value inside
  */
  private boolean rollover() {
    float newSize = 1  ;
    if (size.y < 10 ) newSize = size.y *1.8 ; 
    else if (size.y >= 10 && size.y < 20  ) newSize = size.y *1.2 ;  
    else if (size.y >= 20 ) newSize = size.y ;
    
    if ( mouseX > pos.x && mouseX < pos.x + size.x && mouseY > pos.y  && mouseY < pos.y +newSize) { 
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
        if (rollover() && !authorization) {
          // inside
          image(pic[0],pos.x +correctionX, pos.y); 
        } else {
          // outside
          image(pic[1],pos.x +correctionX, pos.y);
        }
      } else {
        if (rollover() && !authorization) {
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
    if (is) {
      if (rollover() && !authorization) {
        color_on_off = color_in_ON; 
      } else {
        color_on_off = color_out_ON;
      }
    } else {
      if (rollover() && !authorization) {
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


  /**
  CLASSIC RECT BUTTON
  */
  public void button_rect(boolean on_off_is) {
    noStroke();
    if(on_off_is) {
      if (is) {
        if (rollover() && !authorization) {
          color_on_off = color_in_ON; 
        } else {
          color_on_off = color_out_ON;
        }
      } else {
        if (rollover() && !authorization) {
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
    super() ;
  }

  public Button_dynamic(iVec2 pos, iVec2 size) {
    super(pos, size);
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
v 1.1.0
*/
boolean molette_already_selected ;
public class Slider extends Crope {
  protected boolean select_is;
  protected boolean selected_type;
  protected iVec2 pos_molette, size_molette;

  protected iVec2 pos_min, pos_max;

  protected int fill_molette_in = color(g.colorModeX *.4);
  protected int fill_molette_out = color(g.colorModeX *.2);
  protected int stroke_molette_in = fill_molette_in;
  protected int stroke_molette_out =fill_molette_out;
  protected float thickness_molette = 0;

  protected boolean molette_used_is = true;
  protected boolean inside_molette_is;

  protected float min_norm = 0 ;
  protected float max_norm = 1 ;

  protected int molette_type = RECT;

  boolean notch_is;
  int notches_num;
  int notch;
  
  //CONSTRUCTOR minimum
  public Slider(iVec2 pos, iVec2 size) {
    set_pos(pos);
    set_molette_pos();
    set_size(size);

    //which molette for slider horizontal or vertical
    if (size.x >= size.y) {
      size_molette = iVec2(size.y); 
    } else {
      size_molette = iVec2(size.x) ;
    }
    set_molette_min_max_pos();
  }
  


  private void set_molette_min_max_pos() {
    if(size.x > size.y) {
      pos_min = pos.copy();
      pos_max = iVec2(pos.x +size.x -size_molette.x, pos.y) ;
    } else {
      pos_min = pos.copy();
      pos_max = iVec2(pos.x, pos.y +size.y -size_molette.y) ;
    }
  }



  /**
  MAIN METHOD
  */
  public void update() {
    molette_update();
  }

  protected void molette_update() {
    if(!select_is) {
      selected_type = mousePressed;
      molette_used_is = select(molette_used_is(),molette_used_is,true);
    }
    // move the molette is this one is locked
    // security
    if(size.x >= size.y) {
      // for the horizontal slider
      if (pos_molette.x < pos_min.x ) {
        pos_molette.x = pos_min.x ;
      }
      if (pos_molette.x > pos_max.x ) {
        pos_molette.x = pos_max.x ;
      }
    } else {
      // for the vertical slider
      if (pos_molette.y < pos_min.y ) {
        pos_molette.y = pos_min.y ;
      }
      if (pos_molette.y > pos_max.y ) {
        pos_molette.y = pos_max.y ;
      }
    }

    inside_slider();
    if (molette_used_is) {
      if (size.x >= size.y) { 
        pos_molette.x = round(constrain(mouseX -(size_molette.x *.5), pos_min.x, pos_max.x));
      } else { 
        pos_molette.y = round(constrain(mouseY -(size_molette.y *.5), pos_min.y, pos_max.y));
      }
    }
  }





  
  public void select(boolean authorization) {
    select_is = true;
    selected_type = mousePressed;
    molette_used_is = select(molette_used_is(),molette_used_is,authorization);
  }

  public void select(boolean authorization_1, boolean authorization_2) {
    select_is = true;
    selected_type = authorization_1;
    molette_used_is = select(molette_used_is(),molette_used_is,authorization_2);
  }


  // privat method
  protected boolean select(boolean locked_method, boolean result, boolean authorization) {
    if(authorization) {
      if(!molette_already_selected) {
        if (locked_method) {
          molette_already_selected = true ;
          result = true ;
        }
      } else if (locked_method) {
        result = true ;
      }

      if (!selected_type) { 
        result = false ; 
        molette_already_selected = false ;
      }
      return result ;

    } else return false ;   
  }









  /**
  setting
  */
  public void set_molette(int type) {
    this.molette_type = type;
  }

  public void set_molette_size(iVec2 size) {
    set_molette_size(size.x, size.y);
  }

  public void set_molette_size(int x, int y) {
    this.size_molette.set(x,y);
    set_molette_min_max_pos();
  }

  public void set_molette_pos() {
    if(this.pos_molette == null) {
      this.pos_molette = pos.copy();
    } else {
      this.pos_molette.set(pos);
    }
  }

  public void set_molette_pos(iVec2 p) {
    set_molette_pos(p.x,p.y);
  }

  public void set_molette_pos(int x, int y) {
    if(this.pos_molette == null) {
      this.pos_molette = iVec2(x,y);
    } else {
      this.pos_molette.set(x,y);
    }
  }
  
  // set_molette
  public void set_molette_pos_norm(float pos_norm) {
    // security to constrain the value in normalizing range.
    if(pos_norm > 1.) pos_norm = 1. ;
    if(pos_norm < 0) pos_norm = 0 ;
    // check if it's horizontal or vertical slider
    if(size.x >= size.y) {;
      pos_molette.x = round(size.x *pos_norm +pos_min.x -(size_molette.y *pos_norm)); 
    } else {
      pos_molette.y = round(size.y *pos_norm +pos_min.y -(size_molette.x *pos_norm));
    }
  }
  
  public void set_molette_fill(int c) {
    set_molette_fill(c,c);
  }

  public void set_molette_fill(int c_in, int c_out) {
    this.fill_molette_in = c_in;
    this.fill_molette_out = c_out;
  }
  
  public void set_molette_stroke(int c) {
    set_molette_stroke(c,c);
  }

  public void set_molette_stroke(int c_in, int c_out) {
    this.stroke_molette_in = c_in;
    this.stroke_molette_out = c_out;
  }

  public void set_molette_thickness(float thickness) {
    this.thickness_molette = thickness;
  }






  /**
  DISPLAY SLIDER
  v 2.0.0
  */
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
    if(inside_molette_is) {
      aspect_rope(fill_molette_in,stroke_molette_in,thickness_molette);
    } else {
      aspect_rope(fill_molette_out,stroke_molette_out,thickness_molette);
    }
    molette_shape() ;
  }
  
  public void show_label() {
    textAlign(align);
    textFont(font);
    fill(color_label);
    text(name,add(pos,pos_label));
  }

  
  private void molette_shape() {
    if(molette_type == ELLIPSE) {
      ellipse(size_molette.x *.5 +pos_molette.x, size.y *.5 +pos_molette.y, size_molette.x, size_molette.y) ;
    } else if(molette_type == RECT) {
      rect(pos_molette.x, pos_molette.y, size_molette.x, size_molette.y) ;
    } else {
      rect(pos_molette.x, pos_molette.y, size_molette.x, size_molette.y) ;
    }
  }
  
  


  
  
  // check if the mouse is inside the molette or not
  public boolean inside_slider() { 
    if(inside(pos,size,iVec2(mouseX,mouseY),RECT)) {
      inside_molette_is = true ; 
    } else {
      inside_molette_is = false ;
    }
    return inside_molette_is ;
  }
   
  public boolean inside_molette_rect() {
    if(inside(pos_molette,size_molette,iVec2(mouseX,mouseY),RECT)) {
      inside_molette_is = true ; 
    } else {
      inside_molette_is = false ;
    }
    return inside_molette_is ;
  }
  

  //ellipse
  public boolean inside_molette_ellipse() {
    float radius = size_molette.x ;
    int posX = int(radius *.5 +pos_molette.x ) ; 
    int posY = int(size.y *.5 +pos_molette.y) ;
    if(pow((posX -mouseX),2) + pow((posY -mouseY),2) < pow(radius,sqrt(3))) {
      inside_molette_is = true ; 
    } else {
      inside_molette_is = false ;
    }
    return inside_molette_is ;
  }
  
  
  public boolean molette_used_is() {
    if (inside_molette_is && selected_type) {
      return true ; 
    } else {
      return false ;
    }
  }



  // update position from midi controller
  public void update_midi(int val) {
    //update the Midi position only if the Midi Button move
    if (new_midi_value != val) { 
      new_midi_value = val ; 
      pos_molette.x = round(map(val, 1, 127, pos_min.x, pos_max.x));
    }
  }




  public float get_value() {
    float value ;
    if (size.x >= size.y) {
      value = map (pos_molette.x, pos_min.x, pos_max.x, min_norm, max_norm) ; 
    } else {
      value = map (pos_molette.y, pos_min.y, pos_max.y, min_norm, max_norm) ;
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

  



  public iVec2 get_molette_pos() {
    return pos_molette;
  }

  public iVec2 get_molette_size() {
    return size_molette;
  }

  public boolean inside_molette_is() {
    return inside_molette_is;
  }
}






















/**
SLOTCH > notch's slider
v 0.0.2
*/

public class Slotch extends Slider {
  float [] notches_pos ;
  int colour_notch = int(g.colorModeX);
  float thickness_notch = 1.;
  Slotch(iVec2 pos, iVec2 size) {
    super(pos, size);   
  }




  public void update() {
    molette_update();
    if (size.x >= size.y) { 
      if(notch_is) {
        //pos_molette.x = pos_notch(pos.x, size.x, pos_molette.x, size_molette.x);
        pos_molette.x = (int)pos_notch(size.x, pos_molette.x);
      }
    } else { 
      if(notch_is) {
        // pos_molette.y = pos_notch(pos.y, size.y, pos_molette.y, size_molette.y);
        pos_molette.y = (int)pos_notch(size.y, pos_molette.y);
      }
    }
  }



  public void set_notch(int num) {
    notch_is = true ;
    this.notches_num = num;
    notches_position();
  }

  public void set_aspect_notch(int c, float thickness) {
    this.colour_notch = c ;
    this.thickness_notch = thickness;
  }

  public void set_colour_notch(int c) {
    this.colour_notch = c ;
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
  
  void show_notch() {
    show_notch(0,0);
  }
  void show_notch(int start, int stop) {
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
v 1.1.0
*/
public class Sladj extends Slider {
  // size
  protected iVec2 sizeMinMax;
  protected iVec2 sizeMolMinMax;
  // pos  
  protected iVec2 newPosMin;
  protected iVec2 newPosMax;


  private Vec2 pos_norm_adj = Vec2(1,.5);
  private Vec2 size_norm_adj = Vec2(1.,.2);

  protected int fill_adj_in = color(g.colorModeX/2);
  protected int fill_adj_out = color(g.colorModeX /4);
  protected int stroke_adj_in = color(g.colorModeX/2);
  protected int stroke_adj_out = color(g.colorModeX /4);
  protected float thickness_adj = 0;

  private boolean locked_min, locked_max;
    
  Sladj(iVec2 pos, iVec2 size) {
    super(pos, size);
    this.newPosMax = iVec2();
    this.newPosMin = pos.copy();
    this.sizeMinMax = size.copy();

    if (size.x >= size.y) {
      this.sizeMolMinMax = iVec2(size.y); 
    } else {
      this.sizeMolMinMax = iVec2(size.x) ;
    }
  }
  /*
  //slider with external molette
  public Sladj(iVec2 pos, iVec2 size, iVec2 size_molette, int moletteShapeType) {
    super(pos,size);
    set_molette_size(size_molette);
    set_molette(moletteShapeType);
    this.newPosMax = iVec2();
    this.newPosMin = iVec2();
    this.sizeMinMax = size.copy();
    this.sizeMolMinMax = iVec2(size_molette);
  }
  */



  public void set_adj_fill(int c) {
    set_adj_fill(c,c);
  }

  public void set_adj_fill(int c_in, int c_out) {
    this.fill_adj_in = c_in;
    this.fill_adj_out = c_out;
  }
  
  public void set_adj_stroke(int c) {
    set_adj_stroke(c,c);
  }

  public void set_adj_stroke(int c_in, int c_out) {
    this.stroke_adj_in = c_in;
    this.stroke_adj_out = c_out;
  }

  public void set_adj_thickness(float thickness) {
    this.thickness_adj = thickness;
  }


  
  
  
  /**
  METHOD
  */
  public void update_min_max() {
    float newNormSize = max_norm -min_norm ;
    
    if (size.x >= size.y) sizeMinMax = iVec2(round(size.x *newNormSize), size.y) ; else sizeMinMax = iVec2(round(size.y *newNormSize), size.x) ;
    
    pos_min = iVec2(round(pos.x +(size.x *min_norm)), pos.y) ;
    // in this case the detection is translate on to and left of the size of molette
    pos_max = iVec2(round(pos.x -size_molette.x +(size.x *max_norm)), pos.y) ;
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
    float range = size_molette.x *1.5 ;
    
    if (locked_min) {
      if (size.x >= size.y) {
        // security
        if (newPosMin.x < pos_min.x ) newPosMin.x = pos_min.x ;
        else if (newPosMin.x > pos_max.x -range) newPosMin.x = round(pos_max.x -range);
        
        newPosMin.x = round(constrain(mouseX, pos.x, pos.x+size.x -range)); 
        // norm the value to return to method minMaxSliderUpdate
        min_norm = map(newPosMin.x, pos_min.x, pos_max.x, min_norm,max_norm) ;
      } else newPosMin.y = round(constrain(mouseY -sizeMinMax.y, pos_min.y, pos_max.y)); // this line is not reworking for the vertical slider
    }
  }
  
  // update max
  public void select_max(boolean authorization) {
    locked_max = select(locked_max(), locked_max, authorization) ;
  }
  // update maxvalue
  public void update_max() {
    float range = size_molette.x *1.5 ;
    
    if (locked_max) {  // this line is not reworking for the vertical slider
      if (size.x >= size.y) {
        // security
        if (newPosMax.x < pos_min.x +range)  newPosMax.x = round(pos_min.x +range);
        else if (newPosMax.x > pos_max.x ) newPosMax.x = pos_max.x ;
         newPosMax.x = round(constrain(mouseX -(size.y *.5) , pos.x +range, pos.x +size.x -(size.y *.5))); 
         // norm the value to return to method minMaxSliderUpdate
        pos_max = iVec2(round(pos.x -size_molette.x +(size.x *max_norm)), pos.y) ;
        // we use a temporary position for a good display of the max slider 
        Vec2 tempPosMax = Vec2(pos.x -(size.y *.5) +(size.x *max_norm), pos_max.y) ;
        max_norm = map(newPosMax.x, pos_min.x, tempPosMax.x, min_norm, max_norm) ;
      } else newPosMax.y = round(constrain(mouseY -sizeMinMax.y, pos_min.y, pos_max.y)); // this line is not reworking for the vertical slider
    }
    
  }
  
  // set min and max position
  public void set_min_max(float min_norm, float max_norm) {
    min_norm = min_norm;
    max_norm = max_norm;
  }

  public void set_min(float min_norm) {
    min_norm = min_norm;
  }

  public void set_max(float max_norm) {
    max_norm = max_norm;
  }
  
  
  
  
  
  
  
  
  
  // Display classic
  public void show_adj() {
    strokeWeight(thickness_adj) ;
    if(locked_min || locked_max || inside_max() || inside_min()) {
      aspect_rope(fill_adj_in,stroke_adj_in,thickness_adj);
    } else {
      aspect_rope(fill_adj_out,stroke_adj_out,thickness_adj);
    }

    Vec2 pos = Vec2(pos_min.x, pos_min.y +sizeMinMax.y *pos_norm_adj.y);
    Vec2 size = Vec2(sizeMinMax.x, sizeMinMax.y *size_norm_adj.y);
    rect(pos,size);
  }
  
  

  // INSIDE
  private boolean inside_min() {
    int x = round(pos_min.x);
    int y = round(pos_min.y +sizeMinMax.y *pos_norm_adj.y) ;
    iVec2 temp_pos_min = iVec2(x,y);
    if(inside(temp_pos_min,sizeMolMinMax,iVec2(mouseX,mouseY),RECT)) return true ; else return false ;
  }
  
  private boolean inside_max() {
    int x = round(pos_max.x);
    int y = round(pos_max.y +sizeMinMax.y *pos_norm_adj.y) ;
    iVec2 temp_pos_max =  iVec2(x,y);
    if(inside(temp_pos_max, sizeMolMinMax,iVec2(mouseX,mouseY),RECT)) return true ; else return false ;
  }
  
  //LOCKED
  private boolean locked_min() {
    if (inside_min() && mousePressed) return true ; else return false ;
  }
  
  private boolean locked_max() {
    if (inside_max() && mousePressed) return true ; else return false ;
  }
}










































































