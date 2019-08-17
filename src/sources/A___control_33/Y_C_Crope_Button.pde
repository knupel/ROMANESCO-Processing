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


  public void is(boolean is) {
    this.is = is;
  }


  public void switch_is() {
    this.is = !this.is;
  }
  

  public Button set_colour_in_on(int c) {
    this.color_in_ON = c;
    return this;
  }

  public Button set_colour_out_on(int c) {
    this.color_out_ON = c;
    return this;
  }


  public Button set_colour_in_off(int c) {
    this.color_in_OFF = c;
    return this;
  }


  public Button set_colour_out_off(int c) {
    this.color_out_OFF = c;
    return this;
  }
  
  @Deprecated
  public Button set_aspect_on_off(int color_in_ON, int color_out_ON, int color_in_OFF, int color_out_OFF) {
    set_colour_in_on(color_in_ON);
    set_colour_in_off(color_in_OFF);
    set_colour_out_on(color_out_ON);
    set_colour_out_off(color_out_OFF);
    return this;
  }


  // get
  public boolean is() {
    return is;
  }

  public float get() {
    if(is) return 1;
    else return 0;
  }

  
  // misc
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
  



  // SHOW
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
      textAlign(align_label_name);
      fill(color_on_off);
      text(this.name,add(pos,pos_label));
    }  
  }

  public void show_value(float value) {
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
      float f = truncate(value,2);
      message += f;
      message += " ]";
      text(message,add(pos,pos_value));
    }
  }

  public void show_value() {
    show_value(get());
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
* Knob
* v 0.1.3
* 2019-2019
*/
public class Knob extends Button {
  private Molette molette;
  private boolean init_molette_is = false;

  private boolean open_knob = true;
  private boolean out_is = false;

  private float angle_min = PI -QUARTER_PI;
  private float angle_max = QUARTER_PI;
  private int drag_direction = r.HORIZONTAL;
  private float drag_force = 0.1;
  private vec2 size_limit = vec2(-3,3);

  public Knob(vec2 pos, float size) {
    super("Knob");
    this.pos(pos);
    this.size(size);
    this.molette = new Molette();
    molette_update();
  }


  public Knob set_molette(int molette_type) {
    this.molette.set_shape_type(molette_type);
    return this;
  }


  // set size
    public Knob set_value(float pos_norm) {
    float v = map(pos_norm,0,1,0,TAU);
    v = constrain_value(v);
    molette.angle(v);
    init_molette_is = false;
    return this;
  }

  public Knob set_size_limit(float min, float max) {
    this.size_limit.set(min,max);
    return this;
  }

  
  public Knob set_size_molette(vec2 size) {
    set_size_molette(size.x(),size.y());
    return this;
  }

  public Knob set_size_molette(float s) {
    set_size_molette(s,s);
    return this;
  }

  public Knob set_size_molette(float w, float h) {
    molette.size(w,h);
    return this;
  }


  public Knob set_distance_molette(float dist) {
    molette.set_distance(dist);
    return this;
  }

  public Knob set_drag(int direction) {
    if(direction == r.VERTICAL) {
      drag_direction = r.VERTICAL;
    } else if(direction == r.CIRCULAR) {
      drag_direction = r.CIRCULAR;
    } else {
      drag_direction = r.HORIZONTAL;
    }
    return this;
  }

  public Knob set_drag_force(float force) {
    this.drag_force = force;
    return this;
  }



  public Knob set_fill_molette(int c) {
    set_fill_molette(c,c);
    return this;
  }

  public Knob set_fill_molette(int c_in, int c_out) {
    this.molette.fill_in(c_in);
    this.molette.fill_out(c_out);
    return this;
  }
  
  public Knob set_stroke_molette(int c) {
    set_stroke_molette(c,c);
    return this;
  }

  public Knob set_stroke_molette(int c_in, int c_out) {
    this.molette.stroke_in(c_in);
    this.molette.stroke_out(c_out);
    return this;
  }

  public Knob set_thickness_molette(float thickness) {
    this.molette.thickness(thickness);
    return this;
  }


  public Knob set_range(float min, float max) {
    this.angle_min = min;
    this.angle_max = max;
    return this;
  }

  public Knob limit(boolean open_knob) {
    this.open_knob = !open_knob;
    return this;
  }


  // get
  public float get() {
    return molette.angle();
  }




  
  // show
  public void show_structure() {
    show();
  }

  public void show_limit() {
    boolean on_off_is = true;
    if(!open_knob) {
      strokeWeight(1);
      int c = 0;
      if(on_off_is) {
        if (is) {
          if (inside() && authorization) {
            c = color_out_ON; 
          } else {
            c = color_in_ON;
          }
        } else {
          if (inside() && authorization) {
            c = color_out_OFF; 
          } else {
            c = color_in_OFF;
          }
        }
        stroke(c);
      } else {
        stroke(c);
      }
      vec2 final_pos = pos.copy().add(size.copy().mult(.5));
      float radius = size.x()*0.5;
      vec2 a_min = projection(angle_min,radius+size_limit.min()).add(final_pos);
      vec2 b_min = projection(angle_min,radius+size_limit.max()).add(final_pos);
      line(a_min,b_min);

      vec2 a_max = projection(angle_max,radius+size_limit.min()).add(final_pos);
      vec2 b_max = projection(angle_max,radius+size_limit.max()).add(final_pos);
      line(a_max,b_max);
    }
  }


  public void show_molette() {
    if(!init_molette_is) {
      molette.pos(projection(molette.angle(),molette.get_distance()));
      init_molette_is = true;
    }
    molette.show();
  }



  // misc
  public void update(float x, float y) {
    update(x,y,mousePressed,true);
  }

  public void update(float x, float y, boolean event_1) {
    update(x,y,event_1,true);
  }

  public void update(float x, float y, boolean event_1, boolean event_2) {
    if(!use_event_is) {
      select(event_1,event_2);
    }
    cursor(x,y);
    // molette part
    molette.set_offset(pos.copy().add(size.copy().mult(.5)));
    boolean inside_mol = molette.inside(cursor);
    molette.inside_is(inside_mol);
    if(inside_mol && event) {
      molette.used(true);
    }
    if(!event) {
      molette.used(false);
      previous_angle_ref = molette.angle();
      ref_angle_is = false;
      out_is = false;
    }
    // println(out_is);
    if(molette.used_is()) {
      molette_update();
    }
    use_event_is = false;
  }
  

  // molette
  float previous_angle_ref;
  float next_angle_ref;
  boolean ref_angle_is = false;
  private void molette_update() {
    float angle = 0;
    // calc angle
    angle = calc_angle(angle);
    if(!out_is) render_molette(angle);
  }

  private float calc_angle(float angle) {
    if(drag_direction == r.HORIZONTAL) {
      angle = cursor.x() *drag_force;
    } else if(drag_direction == r.CIRCULAR) {
      vec2 temp = pos.copy().add(size.copy().mult(.5));
      angle = temp.angle(cursor);
      if(angle < 0) {
        angle+= TAU;
      }
    } else if(drag_direction == r.VERTICAL) {
      angle = cursor.y() *drag_force;
    }
    return angle;
  }

  private void render_molette(float angle) {
    if(drag_direction != r.CIRCULAR) {
      if(!ref_angle_is) {
        next_angle_ref = angle;
        ref_angle_is = true;
      }
      float new_angle = previous_angle_ref + (angle -next_angle_ref);
      new_angle = constrain_value(new_angle);
      molette.angle(new_angle);
      molette.pos(projection(new_angle,molette.get_distance()));
    } else if(drag_direction == r.CIRCULAR) {
      angle = constrain_value(angle);
      molette.angle(angle);
      molette.pos(projection(angle,molette.get_distance()));
    }
  }

  private float constrain_value(float angle) {
    if(!open_knob) {
      angle = abs(angle)%TAU;
      if(angle_min > angle_max) {
        if(angle < angle_min && angle > angle_max) {
          out_is = true;
          angle = closer(angle, angle_min, angle_max);
        } else {
          out_is = false;
        }
      } else {
        if(angle < angle_min) {
          out_is = true;
          angle = angle_min;
        } else {
          out_is = false;
        }
        if(angle > angle_max) {
          out_is = true;
          angle = angle_max;
        } else {
          out_is = false;
        }
      }
    }
    return angle;
  }

  private float closer(float val, float a, float b) {
    float diff_a = abs(val-a);
    float diff_b = abs(val-b);
    if(diff_a > diff_b) {
      return b;
    } else {
      return a;
    }
  }
  
  // select
  private void select(boolean event) {
    use_event_is = true;
    this.event = event;
  }
  
  private void select(boolean event_1, boolean event_2) {
    use_event_is = true;
    if(event_1 && event_2) {
      this.event = true;
    } else {
      this.event = false;
    }
  }
}