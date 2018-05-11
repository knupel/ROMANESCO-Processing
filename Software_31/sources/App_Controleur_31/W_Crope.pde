/**
CROPE
CONTROL ROMANESCO PROCESSING ENVIRONMENT
* Copyleft (c) 2018-2018
*
Mini library to create button dropdown and button
2015-2018
* @author Stan le Punk
* @see https://github.com/StanLepunK
* @see http://stanlepunk.xyz/
v 2.0.0
*/
abstract class Crope {
  protected iVec2 pos, size;
  protected iVec2 pos_ref ;
  protected int fill_in = color(g.colorModeX);
  protected int fill_out = color(g.colorModeX /2);
  protected int stroke_in = fill_in;
  protected int stroke_out= fill_out;
  protected float thickness = 0;

  protected float rounded = 0;
  // label
  protected int align = LEFT;
  protected String name = null;
  protected iVec2 pos_label;
  protected int color_label = color(g.colorModeX);
  protected PFont font_label;

  protected int new_midi_value;
  protected int id_midi = -2 ;
  protected int id = -1;

  private int rank;


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

  public void set_label_colour(int c) {
    this.color_label = c;
  }

  public void set_label_font(PFont font) {
    this.font_label = font; 
  }

  public void set_label_align(int align) {
    this.align = align;  
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
}



































/**
CLASS SLIDER
*/
boolean molette_already_selected ;
public class Slider extends Crope {
  
  protected iVec2 pos_molette, size_molette;

  protected iVec2 pos_min, pos_max;

  protected int fill_molette_in = color(g.colorModeX *.8);
  protected int fill_molette_out = color(g.colorModeX *.6);
  protected int stroke_molette_in = fill_molette_in;
  protected int stroke_molette_out =fill_molette_out;
  protected float thickness_molette = 0;

  protected boolean molette_used_is;
  protected boolean inside_molette_is;

  protected float min_norm = 0 ;
  protected float max_norm = 1 ;

  protected String moletteShapeType = ("") ;
  
  //CONSTRUCTOR minimum
  public Slider(iVec2 pos, iVec2 size) {
    set_pos(pos);
    set_size(size);
    //this.size = size.copy() ;

    //which molette for slider horizontal or vertical
    if (size.x >= size.y) {
      size_molette = iVec2(size.y); 
    } else {
      size_molette = iVec2(size.x) ;
    }
    // calculate minimum and maxium position of the molette
    if(size.x > size.y) {
      pos_min = pos.copy();
      pos_max = iVec2(pos.x +size.x +size.y,  pos.y) ;
    } else {
      pos_min = pos.copy();
      int correction = size_molette.y  + size_molette.x ;
      pos_max = iVec2(pos.x,  pos.y  +size.x +size.y -correction) ;
    }
  }
  
  //slider with external molette
  public Slider(iVec2 pos, iVec2 size, iVec2 size_molette, String moletteShapeType) {
    set_pos(pos);
    set_pos_molette();
    this.size_molette = size_molette.copy() ;
    set_size(size);
    //this.size = size.copy() ;
    this.moletteShapeType = moletteShapeType ;
    // calculate minimum and maxium position of the molette
    if(size.x > size.y) {
      pos_min = pos.copy();
      pos_max = iVec2(pos.x +size.x +size.y,  pos.y) ;
    } else {
      pos_min = pos.copy();
      int correction = size_molette.y  + size_molette.x ;
      pos_max = iVec2(pos.x,  pos.y  +size.x +size.y -correction) ;
    }
  }



  public void set_pos_molette() {
    if(this.pos_molette == null) {
      this.pos_molette = pos.copy();
    } else {
      this.pos_molette.set(pos);
    }
  }
  
  // set_molette
  public void set_pos_molette(float pos_norm) {
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


  
  public void select_molette() {
    molette_used_is = select(molette_used_is(), molette_used_is) ;
  }


  public void update_molette() {
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

    if (molette_used_is) {
      if (size.x >= size.y) { 
        pos_molette.x = round(constrain(mouseX -(size_molette.x *.5), pos_min.x, pos_max.x)); 
      } else { 
        pos_molette.y = round(constrain(mouseY -(size_molette.y *.5), pos_min.y, pos_max.y));
      }
    }
  }

  // privat method
  protected boolean select(boolean locked_method, boolean result) {
    if(!molette_already_selected) {
      if (locked_method) {
        molette_already_selected = true ;
        result = true ;
      }
    } else {
      if (locked_method && shift_key) {
        result = true ;
      }
    }

    if (!mousePressed) { 
      result = false ; 
      molette_already_selected = false ;
    }
    return result ;
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
    shape_molette() ;
  }
  
  public void show_label() {
    textAlign(align);
    textFont(font_label);
    fill(color_label);
    text(name,add(pos,pos_label));
  }

  
  private void shape_molette() {
    if(moletteShapeType.equals("ELLIPSE") ) {
      ellipse(size_molette.x *.5 +pos_molette.x, size.y *.5 +pos_molette.y, size_molette.x , size_molette.y) ;
    } else if(moletteShapeType.equals("RECT")) {
      rect(pos_molette.x, pos_molette.y, size_molette.x , size_molette.y ) ;
    } else rect(pos_molette.x, pos_molette.y, size_molette.x , size_molette.y ) ;
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
    if (inside_molette_is && mousePressed) {
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



  public iVec2 get_pos_molette() {
    return pos_molette;
  }

  public iVec2 get_size_molette() {
    return size_molette;
  }

  public boolean inside_molette_is() {
    return inside_molette_is;
  }
}












/**
SLIDER ADJUSTABLE
v 1.0.0
*/
public class Slider_adjustable extends Slider {
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
    
  Slider_adjustable(iVec2 pos, iVec2 size) {
    super(pos, size);
    this.newPosMax = iVec2();
    this.newPosMin = pos.copy();
    this.sizeMinMax = size.copy();
    this.sizeMolMinMax = iVec2(size_molette);
  }
  
  //slider with external molette
  public Slider_adjustable(iVec2 pos, iVec2 size, iVec2 size_molette, String moletteShapeType) {
    super(pos, size, size_molette, moletteShapeType);
    this.newPosMax = iVec2();
    this.newPosMin = iVec2();
    this.sizeMinMax = size.copy();
    this.sizeMolMinMax = iVec2(size_molette);
  }



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
  public void select_min() {
    locked_min = select(locked_min(), locked_min) ;
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
  public void select_max() {
    locked_max = select(locked_max(), locked_max) ;
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







































/**
CROPE
CONTROL ROMANESCO PROCESSING ENVIRONMENT
*
CLASS BUTTON 2.0.0
*/
public class Button extends Crope {
  color color_bg, color_on_off ;
  color color_in_ON, color_out_ON, color_in_OFF, color_out_OFF ; 
  color color_bg_in, color_bg_out ;
  
  boolean inside ;
  boolean on_off = false ;  
  //MIDI
  int newmidi_value_romanesco ;

  
  protected Button() {
  }

  //complexe
  public Button (int pos_x, int pos_y, int size_x, int size_y) {
    set_pos(pos_x, pos_y);
    set_size(size_x,size_y);
  }

  public Button (iVec2 pos, iVec2 size) {
    set_pos(pos);
    set_size(size);
  }

  /**
  Setting
  */
  public void set_on_off(boolean on_off) {
    this.on_off = on_off ;
  }
  

  public void set_color_on_off(color color_in_ON, color color_out_ON, color color_in_OFF, color color_out_OFF) {
    this.color_in_ON = color_in_ON ; 
    this.color_out_ON = color_out_ON ; 
    this.color_in_OFF = color_in_OFF ; 
    this.color_out_OFF = color_out_OFF ;
  }

  public void set_color_bg(color color_bg_in, color color_bg_out) {
    this.color_bg_in = color_bg_in ; 
    this.color_bg_out = color_bg_out ;
  }


  /**
  MISC
  */
  public void background_button() {
    fill(color_bg) ;
    rect(pos.x, pos.y, size.x, size.y) ;
  }






  
  
  //ROLLOVER
  //rectangle
  private float newSize = 1  ;
  private boolean rollover() {
    if (size.y < 10 ) newSize = size.y *1.8 ; 
    else if (size.y >= 10 && size.y < 20  ) newSize = size.y *1.2 ;  
    else if (size.y >= 20 ) newSize = size.y ;
    if ( mouseX > pos.x && mouseX < pos.x + size.x && mouseY > pos.y  && mouseY < pos.y + newSize ) {
      inside = true ;
      return true ; 
    } else {
      inside = false ;
      return false ; 
    }
  }
  // with correction for the font position
  private boolean rollover(int correction) {
    if (size.y < 10 ) newSize = size.y *1.8 ; 
    else if (size.y >= 10 && size.y < 20  ) newSize = size.y *1.2 ;  
    else if (size.y >= 20 ) newSize = size.y ;
    
    if ( mouseX > pos.x && mouseX < pos.x + size.x && mouseY > pos.y -correction  && mouseY < pos.y +newSize -correction) { 
      inside = true ;
      return true ; 
    } else {
      inside = false ;
      return false ; 
    }
  }
  
  
  
  //MousePressed
  public void mousePressed() {
    if (rollover()) {
      on_off = !on_off ? true : false ;
    }
  }

  public void mousePressedText() {
    if (rollover((int)size.y)) on_off = !on_off ? true : false ;
  }



  /**
  IMAGE BUTTON
  */
  public void button_pic_serie(PImage[] OFF_in, PImage[] OFF_out, PImage[] ON_in, PImage[] ON_out, int whichOne) {
    /* use the boolean dropdownActivity directly is very bad */
    int correctionX = -1 ;
    if(ON_in[whichOne] != null && ON_out[whichOne] != null && OFF_in[whichOne] != null && OFF_out[whichOne] != null ) {
      if (on_off) {
        if (rollover() && !dropdownActivity) image(ON_in[whichOne],pos.x +correctionX, pos.y) ; else image(ON_out[whichOne],pos.x +correctionX, pos.y) ;
      } else {
        if (rollover() && !dropdownActivity) image(OFF_in[whichOne],pos.x +correctionX, pos.y) ; else image(OFF_out[whichOne],pos.x +correctionX, pos.y) ;
      }
    }
  }

  public void button_pic(PImage [] pic) {
    /* use the boolean dropdownActivity directly is very bad */
    int correctionX = -1 ;
    if(pic[0] != null && pic[1] != null && pic[2] != null && pic[3] != null ) {
      if (on_off) {
        if (rollover() && !dropdownActivity) image(pic[1],pos.x +correctionX, pos.y) ; else image(pic[0],pos.x +correctionX, pos.y) ;
      } else {
        if (rollover() && !dropdownActivity) image(pic[3],pos.x +correctionX, pos.y) ; else image(pic[2],pos.x +correctionX, pos.y) ;
      }
    }
  }
  public void button_pic_text(PImage [] pic, String text) {
    /* use the boolean dropdownActivity directly is very bad */
    fill(jaune) ;
    textFont(FuturaStencil_20) ;
    int correctionX = -1 ;
    if ( on_off ) {
      if (rollover() && !dropdownActivity) {
        image(pic[1],pos.x +correctionX, pos.y) ;
        text(text,   mouseX -20, mouseY -20 ) ;
      } else image(pic[0],pos.x +correctionX, pos.y) ;
    } else {
      if (rollover() && !dropdownActivity) { 
        image(pic[3],pos.x +correctionX, pos.y) ; 
        text(text,   mouseX -20, mouseY -20 ) ;
      } else image(pic[2],pos.x +correctionX, pos.y) ;
    }
  }

  /**
  TEXT BUTTON
  */
  public void button_text(int x, int y)  {
    button_text(name, x, y) ;
  }
  
  public void button_text(String s, int x, int y) {
    /* use the boolean dropdownActivity directly is very bad */
    if (on_off) {
      stroke(vertTresFonce) ;
      if (rollover() && !dropdownActivity) color_on_off = color_in_ON ; else color_on_off = color_out_ON ;
    } else {
      stroke(rougeTresFonce) ; 
      if (rollover() && !dropdownActivity) color_on_off = color_in_OFF ; else color_on_off = color_out_OFF ;
    }

    fill(color_on_off) ;
    text(s, x, y) ;
  }
 
  public void button_text(String s, iVec2 pos, PFont font, int sizeFont) {
    /* use the boolean dropdownActivity directly is very bad */
    if (on_off) {
      if (rollover(sizeFont) && !dropdownActivity) color_on_off = color_in_ON ; else color_on_off = color_out_ON ;
    } else {
      if (rollover(sizeFont) && !dropdownActivity) color_on_off = color_in_OFF ; else color_on_off = color_out_OFF ;
    }
    fill(color_on_off) ;
    textFont(font) ;
    textSize(sizeFont) ;
    text(s, pos) ;
  }
 
  public void button_rect(String s) {
    /* use the boolean dropdownActivity directly is very bad */
    strokeWeight (1) ;
    if (on_off) {
      stroke(vertTresFonce) ;
      if (rollover() && !dropdownActivity)color_on_off = color_in_ON ; else color_on_off = color_out_ON ;
    } else {
      stroke(rougeTresFonce) ; 
      if (rollover() && !dropdownActivity) color_on_off = color_in_OFF ; else color_on_off = color_out_OFF ;
    }

    fill(color_on_off) ;
    rect(pos, size) ;
    fill(blanc) ;
    text(s, pos) ;
    noStroke() ;
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
DROPDOWN
v 2.0.0
2014-2018
*/
boolean dropdownOpen ; // use to indicate to indicate at the other button, they cannot be used when the user are on the dropdown menu
/**
CLASS
*/
public class Dropdown extends Crope {
  //Slider dropdown
  private Slider slider_dd;
  private iVec2 size_box;
  // font
  private PFont font_header,font_box;
  //dropdown
  private int line = 0;
  private String content[];
  private String name;

  private boolean locked, slider ;
  // color
  private int color_header_in, color_header_out, color_main;
  private int color_box_text ; 
  private int color_box_in, color_box_out;


  private iVec2 pos_text;
  private int pos_ref_x, pos_ref_y ;
  private iVec2 change_pos;
  private float factorPos; // use to calculate the margin between the box
  // box
  private int height_box;
  private int num_box;

  private int start = 0 ;
  private int end = 1 ;
  private int offset = 0 ; //for the slider update
  private float missing ;

  /**
  CONSTRUCTOR
  */
  public Dropdown(String name, String [] content, iVec2 pos, iVec2 size, iVec2 pos_text, ROPE_color rc, int num_box, int height_box) {
    this.font_header = createFont("defaultFont",10);
    this.font_box = createFont("defaultFont",10);
    this.name = name; 
    this.pos = pos.copy();
    pos_ref_x = pos.x;
    pos_ref_y = pos.y;
    
    this.pos_text = pos_text.copy();

    this.size = size.copy(); // header size
    
    this.color_main = rc.get_color()[0];
    this.color_box_in = rc.get_color()[1];
    this.color_box_out = rc.get_color()[2];
    this.color_header_in = rc.get_color()[3];
    this.color_header_out = rc.get_color()[4];  
    this.color_box_text = rc.get_color()[5];
    
    set_box(num_box, height_box);
    set_content(content);
  }




  /**
  method
  */
  public void set_box(int num_box, int height_box) {
    this.height_box = height_box;
    this.num_box = num_box;
    size_box = iVec2(longest_String_pixel(font_box,this.content), height_box);
  }

  public void set_box_width(int w) {
    size_box.set(w,size_box.y);

  }

  public void set_font_header(String font_name, int size) {
    this.font_header = createFont(font_name,size);
  }

  public void set_font_box(String font_name, int size) {
    this.font_box = createFont(font_name,size);
  }

  public void set_font_header(PFont font) {
    this.font_header = font;
  }

  public void set_font_box(PFont font) {
    this.font_box = font;
  }

  // content
  public void set_content(String [] content) {
    boolean new_slider = false ;
    if(this.content == null || this.content.length != content.length) new_slider = true ;
    this.content = content;
    end = num_box;
    if (content != null) {
      if (end > content.length) {
        end = content.length;
      }
      missing = content.length -end;
    }

    //condition to display the slider
    if (content.length > end) {
      slider = true; 
    } else {
      slider = false;
    }
    
    if (slider && (slider_dd == null || new_slider)) {
      update_slider();
    }

  }

  private void update_slider() {
    iVec2 size_slider = iVec2(round(height_box *.5), round((end *height_box) -pos.z));
    int x = pos.x -size_slider.x;
    int y = pos.y +height_box;
    iVec2 pos_slider = iVec2(x,y);
  
    float ratio = float(content.length) / float(end -1);
    
    iVec2 size_molette =  iVec2(size_slider.x, round(size_slider.y /ratio));

    slider_dd = new Slider(pos_slider, size_slider, size_molette, "RECT");
    slider_dd.set_molette_fill(this.color_box_in,this.color_box_out);
  }



  public void change_pos(int x, int y) {
    pos.set(pos_ref_x, pos_ref_y);
    iVec2 temp = iVec2(x,y);
    pos.add(temp);
  }


  public void update() {
    rectMode(CORNER);
    if (locked) {
      dropdownOpen = true ;
      //give the position of dropdown
      int step = 2 ;
      //give the position in list of Item with the position from the slider's molette
      if (slider) offset = round(map(slider_dd.get_value(),0,1,0,missing));
      set_box_width(longest_String_pixel(font_box,this.content));

      for (int i = start +offset ; i < end +offset ; i++) {
        render_box(content[i], step++, size_box, color_box_text);
        if (slider) {
          int x = pos.x -slider_dd.get_size().x;
          int y = pos.y +height_box;
          slider_dd.set_pos(x,y);
          slider_dd.inside_molette_rect();
          slider_dd.select_molette();
          slider_dd.update_molette();
          slider_dd.show_structure();
          //slider_dd.show(color_main,color_main,0);
          /**
          the color must be set in other place, that's not pertinent to set color in this method
          */
          slider_dd.show_molette();
          // slider_dd.show_molette(jaune, orange, jaune, orange, 0) ;
        }
      }
    } else {
      //header rendering
      dropdownOpen = false ;
    }
    title_without_box(name, 1, size, font_header);
  }





  //DISPLAY
  private void title_without_box(String name, int step, iVec2 size, PFont font) {
    //update
    factorPos = step + pos.z -1 ;
    float yLevel = step == 1 ? pos.y  : (pos.y + (size.y *(factorPos )));
    iVec2 newPosDropdown = iVec2(pos.x, round(yLevel));
    if (inside(newPosDropdown,size,iVec2(mouseX,mouseY),RECT)) {
      fill(color_header_in); 
    } else {
      fill(color_header_out);
    }
    textFont(font);
    text(name, pos.x +pos_text.x, yLevel +pos_text.y);
  }
  
  private void render_box(String label, int step, iVec2 size_box, int textColor) {
    //update
    factorPos = step + pos.z -1 ;
    float yLevel = step == 1 ? pos.y  : (pos.y + (size_box.y *(factorPos)));
    iVec2 newPosDropdown = iVec2(pos.x, round(yLevel));
    if (inside(newPosDropdown,size_box,iVec2(mouseX,mouseY),RECT)) {
      fill(color_box_in); 
    } else {
      fill(color_box_out);
    }
    //display
    noStroke() ;
    if (inside(newPosDropdown,size,iVec2(mouseX,mouseY),RECT)) {
      fill(color_box_in); 
    } else {
      fill(color_box_out);
    }
    int sizeWidthMin = 60 ;
    int sizeWidthMax = 300 ;
    if (size_box.x < sizeWidthMin ) {
      size_box.x = sizeWidthMin ; 
    } else if(size_box.x > sizeWidthMax ) {
      size_box.x = sizeWidthMax ;
    }
    rect(pos.x, yLevel, size_box.x, size_box.y);
    fill(textColor);
    textFont(font_box);
    text(label, pos.x +pos_text.x, yLevel +height_box -(ceil(height_box*.2)));
  }
  
  

  //Check the dropdown when this one is open
  public int selectDropdownLine(float newWidth) {
    if(mouseX >= pos.x && mouseX <= pos.x +newWidth && mouseY >= pos.y && mouseY <= ((content.length+1) *size.y) +pos.y) {
      //choice the line
      int line = floor( (mouseY - (pos.y +size.y)) / size.y ) +offset;
      return line;
    } else {
      return -1; 
    }
  }
  //return which line is selected
  public void whichDropdownLine(int l ) {
    line = l ;
  }
  //return which line of dropdown is selected
  public int get_content_line() {
    return line ;
  }

  public String [] get_content() {
    return content;
  }


  public int get_num_box() {
    return num_box;
  }

  PFont get_font_header() {
    return font_header;
  }

  PFont get_font_box() {
    return font_box;
  }
}
