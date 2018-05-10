/**
CROPE
CONTROL ROMANESCO PROCESSING ENVIRONMENT
*
SLIDER 
2015 - 2018
v 1.8.0
*/
boolean molette_already_selected ;
/**
CLASS SLIDER
*/
public class Slider {
  protected iVec2 pos, size;
  protected iVec2 pos_molette, size_molette;

  protected iVec2 pos_min, pos_max;

  protected int fill_in = color(g.colorModeX);
  protected int fill_out = color(g.colorModeX /2);
  protected int stroke_in;
  protected int stroke_out;
  protected float thickness = 0;

  protected float rounded = 0;

  protected int fill_molette_in = color(g.colorModeX);
  protected int fill_molette_out = color(g.colorModeX /2);
  protected int stroke_molette_in;
  protected int stroke_molette_out;
  protected float thickness_molette = 0;

  // label
  protected int align = LEFT;
  protected String name = null;
  protected iVec2 pos_label;
  protected int color_label = color(g.colorModeX);
  protected PFont font_label;

  protected boolean molette_used_is;
  protected boolean inside_molette_is;

  protected float min_norm = 0 ;
  protected float max_norm = 1 ;
  // advance slider
  protected int new_midi_value;
  protected int id_midi = -2 ;
  protected int id = -1;
  protected String moletteShapeType = ("") ;
  
  //CONSTRUCTOR minimum
  public Slider(iVec2 pos, iVec2 size) {
    set_pos(pos);
    this.size = size.copy() ;

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
    this.size_molette = size_molette.copy() ;
    this.size = size.copy() ;
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

  public void set_pos(int x, int y) {
    set_pos(iVec2(x,y));
  }

  public void set_pos(iVec2 pos) {
    if(this.pos == null || this.pos_molette == null || !this.pos.equals(pos)) {
      if(this.pos == null) {
        this.pos = pos.copy();
      } else {
        this.pos.set(pos);
      }

      if(this.pos_molette == null) {
        this.pos_molette = pos.copy();
      } else {
        this.pos_molette.set(pos);
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



  // set_molette
  public void set_pos_molette(float normPos) {
    // security to constrain the value in normalizing range.
    if(normPos > 1.) normPos = 1. ;
    if(normPos < 0) normPos = 0 ;
    // check if it's horizontal or vertical slider
    if(size.x >= size.y) {;
      pos_molette.x = round(size.x *normPos +pos_min.x -(size_molette.y *normPos)); 
    } else {
      pos_molette.y = round(size.y *normPos +pos_min.y -(size_molette.x *normPos));
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
  public void show() {
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

  //give the IDmidi 
  public int get_id_midi() { 
    return this.id_midi ; 
  }

  public int get_id() {
    return this.id;
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

  public iVec2 get_pos() {
    return pos;
  }

  public iVec2 get_size() {
    return size;
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







