/**
Abstract CLASS ROMANESCO
v 1.4.0
2013-2019
*/
public abstract class Romanesco implements rope.core.RConstants {
  protected String item_name;
  protected String item_author;
  protected String item_references;
  protected String item_version;
  protected String item_pack;
  protected String romanesco_renderer;
  protected String item_costume;
  protected String item_mode;
  protected String item_slider;

  protected int ID_item;
  protected int ID_group;

  // value slider
  int fill,stroke;

  Varom fill_hue,fill_sat,fill_bright,fill_alpha;
  Varom stroke_hue,stroke_sat,stroke_bright,stroke_alpha;
  Varom thickness; 
  Varom size_x,size_y,size_z;
  Varom diameter;
  Varom canvas_x,canvas_y,canvas_z;

  Varom frequence;
  Varom speed_x,speed_y,speed_z;
  Varom spurt_x,spurt_y,spurt_z;
  Varom dir_x,dir_y,dir_z;
  Varom jitter_x,jitter_y,jitter_z;
  Varom swing_x,swing_y,swing_z;

  Varom quantity,variety;
  Varom life,flow,quality;

  Varom area,angle,scope,scan;
  Varom alignment,repulsion,attraction,density;
  Varom influence,calm,spectrum;

  Varom grid;
  Varom viscosity,diffusion;

  Varom power;
  Varom mass;
  Varom coord_x,coord_y,coord_z;


  // parameter
  boolean show,sound,action,parameter;

  Mode mode;
  Costume costume;
  int costume_id;

  boolean birth, colour, dimension, horizon, motion, follow, reverse, special, wire;
  boolean fill_is, stroke_is;
  boolean setting, clearList;

  ROFont font_item;


  // state slider is
  // col 1
  protected boolean hue_fill_is;
  protected boolean sat_fill_is;
  protected boolean bright_fill_is;
  protected boolean alpha_fill_is;
  protected boolean hue_stroke_is;
  protected boolean sat_stroke_is;
  protected boolean bright_stroke_is;
  protected boolean alpha_stroke_is;
  protected boolean thickness_is;
  protected boolean size_x_is;
  protected boolean size_y_is;
  protected boolean size_z_is;
  protected boolean diameter_is;
  protected boolean canvas_x_is;
  protected boolean canvas_y_is;
  protected boolean canvas_z_is;
  // col 2
  protected boolean frequence_is;
  protected boolean speed_x_is;
  protected boolean speed_y_is;
  protected boolean speed_z_is;
  protected boolean spurt_x_is;
  protected boolean spurt_y_is;
  protected boolean spurt_z_is;
  protected boolean dir_x_is;
  protected boolean dir_y_is;
  protected boolean dir_z_is;
  protected boolean jit_x_is;
  protected boolean jit_y_is;
  protected boolean jit_z_is;
  protected boolean swing_x_is;
  protected boolean swing_y_is;
  protected boolean swing_z_is;
  // col 3
  protected boolean quantity_is;
  protected boolean variety_is;
  protected boolean life_is;
  protected boolean flow_is;
  protected boolean quality_is;
  protected boolean area_is;
  protected boolean angle_is;
  protected boolean scope_is;
  protected boolean scan_is;
  protected boolean align_is;
  protected boolean repulsion_is;
  protected boolean attraction_is;
  protected boolean density_is;
  protected boolean influence_is;
  protected boolean calm_is;
  protected boolean spectrum_is;
  // col 4
  protected boolean grid_is;
  protected boolean viscosity_is;
  protected boolean diffusion_is;
  protected boolean power_is;
  protected boolean mass_is;
  protected boolean coord_x_is;
  protected boolean coord_y_is;
  protected boolean coord_z_is;

  
  public Romanesco() {
    item_name = "Unknown";
    item_author = "Anonymous";
    item_references = "none";
    item_version = "Alpha";
    item_pack = "Base 2012-2018";
    item_costume = ""; // separate the name by a slash and write the next mode immadialtly after this one.
    item_mode = ""; // separate the name by a slash and write the next mode immadialtly after this one.
    item_slider = "";
    ID_group = 0;
    ID_item = 0;

    hue_fill_is = false;
    sat_fill_is = false;
  }

  //manager return
  public void set_slider(String [][] slider) {
    if(!hue_fill_is) item_slider +="," ; else item_slider += (slider[0][0] +",");
    if(!sat_fill_is) item_slider +="," ; else item_slider += (slider[0][1]+",");
    if(!bright_fill_is) item_slider +="," ; else item_slider += (slider[0][2]+",");
    if(!alpha_fill_is) item_slider +="," ; else item_slider += (slider[0][3]+",");
    if(!hue_stroke_is) item_slider +="," ; else item_slider += (slider[0][4] +",");
    if(!sat_stroke_is) item_slider +="," ; else item_slider += (slider[0][5]+",");
    if(!bright_stroke_is) item_slider +="," ; else item_slider += (slider[0][6]+",");
    if(!alpha_stroke_is) item_slider +="," ; else item_slider += (slider[0][7]+",");
    if(!thickness_is) item_slider +="," ; else item_slider += (slider[0][8]+",");
    if(!size_x_is) item_slider +="," ; else item_slider += (slider[0][9]+",");
    if(!size_y_is) item_slider +="," ; else item_slider += (slider[0][10]+",");
    if(!size_z_is) item_slider +="," ; else item_slider += (slider[0][11]+",");
    if(!diameter_is) item_slider +="," ; else item_slider += (slider[0][12]+",");
    if(!canvas_x_is) item_slider +="," ; else item_slider += (slider[0][13]+",");
    if(!canvas_y_is) item_slider +="," ; else item_slider += (slider[0][14]+",");
    if(!canvas_z_is) item_slider +="," ; else item_slider += (slider[0][15]+",");

    if(!frequence_is) item_slider +="," ; else item_slider += (slider[1][0]+",");
    if(!speed_x_is) item_slider +="," ; else item_slider += (slider[1][1]+",");
    if(!speed_y_is) item_slider +="," ; else item_slider += (slider[1][2]+",");
    if(!speed_z_is) item_slider +="," ; else item_slider += (slider[1][3]+",");
    if(!spurt_x_is) item_slider +="," ; else item_slider += (slider[1][4]+",");
    if(!spurt_y_is) item_slider +="," ; else item_slider += (slider[1][5]+",");
    if(!spurt_z_is) item_slider +="," ; else item_slider += (slider[1][6]+",");
    if(!dir_x_is) item_slider +="," ; else item_slider += (slider[1][7]+",");
    if(!dir_y_is) item_slider +="," ; else item_slider += (slider[1][8]+",");
    if(!dir_z_is) item_slider +="," ; else item_slider += (slider[1][9]+",");
    if(!jit_x_is) item_slider +="," ; else item_slider += (slider[1][10]+",");
    if(!jit_y_is) item_slider +="," ; else item_slider += (slider[1][11]+",");
    if(!jit_z_is) item_slider +="," ; else item_slider += (slider[1][12]+",");
    if(!swing_x_is) item_slider +="," ; else item_slider += (slider[1][13]+",");
    if(!swing_y_is) item_slider +="," ; else item_slider += (slider[1][14]+",");
    if(!swing_z_is) item_slider +="," ; else item_slider += (slider[1][15]+",");

    if(!quantity_is) item_slider +="," ; else item_slider += (slider[2][0]+",");
    if(!variety_is) item_slider +="," ; else item_slider += (slider[2][1]+",");
    if(!life_is) item_slider +="," ; else item_slider += (slider[2][2]+",");
    if(!flow_is) item_slider +="," ; else item_slider += (slider[2][3]+",");
    if(!quality_is) item_slider +="," ; else item_slider += (slider[2][4]+",");
    if(!area_is) item_slider +="," ; else item_slider += (slider[2][5]+",");
    if(!angle_is) item_slider +="," ; else item_slider += (slider[2][6]+",");
    if(!scope_is) item_slider +="," ; else item_slider += (slider[2][7]+",");
    if(!scan_is) item_slider +="," ; else item_slider += (slider[2][8]+",");
    if(!align_is) item_slider +="," ; else item_slider += (slider[2][9]+",");
    if(!repulsion_is) item_slider +="," ; else item_slider += (slider[2][10]+",");
    if(!attraction_is) item_slider +="," ; else item_slider += (slider[2][11]+",");
    if(!density_is) item_slider +="," ; else item_slider += (slider[2][12]+",");
    if(!influence_is) item_slider +="," ; else item_slider += (slider[2][13]+",");
    if(!calm_is) item_slider +="," ; else item_slider += (slider[2][14]+",");
    if(!spectrum_is) item_slider +="," ; else item_slider += (slider[2][15]+",");

    if(!grid_is) item_slider +="," ; else item_slider += (slider[3][0]+",");
    if(!viscosity_is) item_slider +="," ; else item_slider += (slider[3][1]+",");
    if(!diffusion_is) item_slider +="," ; else item_slider += (slider[3][2]+",");
    if(!power_is) item_slider +="," ; else item_slider += (slider[3][3]+",");
    if(!mass_is) item_slider +="," ; else item_slider += (slider[3][4]+",");
    if(!coord_x_is) item_slider +="," ; else item_slider += (slider[3][5]+",");
    if(!coord_y_is) item_slider +="," ; else item_slider += (slider[3][6]+",");
    if(!coord_z_is) item_slider +="," ; else item_slider += (slider[3][7]+",");
  }

  

  // Must be declared in the sub-classes
  abstract void setup();

  abstract void draw();


  protected void draw_2D() {}


  protected void init() {
    costume = new Costume(ELLIPSE_ROPE);
    mode = new Mode();
    fill_is(true);
    stroke_is(true);
    set_thickness_raw(1,0,0);
    wire_is(true);
  }


  protected void info(Object... obj) {
    String mark = " | ";
    item_info[ID_item] = write_message_sep(mark,obj);
  }

  /**
  * set method
  */
  protected void set_id(int id) {
    ID_item = id;
  }

  protected void set_group(int group) {
    ID_group = group;
  }

  protected void set_mode(Mode mode) {
    this.mode = mode;
  }
  
  /**
  * set costume from here is tricky, because there is dependancy from the String item_custume
  */
  protected void set_costume_id(int costume_id) {
    if(costume_id >= 0 && costume_id < split(item_costume,"/").length) {
      this.costume_id = costume_id;
    }
  }


  protected void set_costume(Costume costume, int id) {
    this.costume = costume;
    this.costume_id = costume_id;
  }
  
  // set boolean button controller
  protected void show_is(boolean show) {
    this.show = show;
  }

  protected void sound_is(boolean sound) {
    this.sound = sound;
  }

  protected void action_is(boolean action) {
    this.action = action; 
  } 

  protected void parameter_is(boolean parameter) {
    this.parameter = parameter;
  }






  /**
  * SET CONTROL SLIDER
  * v 0.1.0
  */
  // FILL
  protected void set_fill(float... arg) {
    if(arg.length == 1) {
      set_fill(arg[0],arg[0],arg[0],g.colorModeA);
    } else if(arg.length == 2) {
      set_fill(arg[0],arg[0],arg[0],arg[1]);
    } else if(arg.length == 3) {
      set_fill(arg[0],arg[1],arg[2],g.colorModeA);
    } else if(arg.length == 4) {
      set_fill(arg[0],arg[1],arg[2],arg[3]);
    } else {
      printErrTempo(60,"method set_fill(float... arg) wait for an array length from 1 to 4");
    }
  }

  protected void set_fill(float x, float y, float z, float a) {
    this.fill = color(x,y,z,a);
    set_fill_hue(x);
    set_fill_sat(y);
    set_fill_bright(z);
    set_fill_alpha(a);
  }

  
  // hue
  protected void set_fill_hue(float fill_hue) {
    this.fill_hue.set(fill_hue);
  }

  protected void set_fill_hue_raw(float fill_hue) {
    set_fill_hue_raw(fill_hue,0,0);
  }

  protected void set_fill_hue_raw(float fill_hue, int begin, int end) {
    if(this.fill_hue == null) this.fill_hue = new Varom();
    this.fill_hue.set_raw(fill_hue,begin,end);
  }

  protected void set_fill_hue_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.fill_hue == null) this.fill_hue = new Varom();
    this.fill_hue.set_min_raw(min_raw);
    this.fill_hue.set_max_raw(max_raw);
    this.fill_hue.set_min(min);
    this.fill_hue.set_max(max);
  }
  
  // sat
  protected void set_fill_sat(float fill_sat) {
     this.fill_sat.set(fill_sat);
  }

  protected void set_fill_sat_raw(float fill_sat) {
     set_fill_sat_raw(fill_sat,0,0);
  }

  protected void set_fill_sat_raw(float fill_sat, int begin, int end) {
    if(this.fill_sat == null) this.fill_sat = new Varom();
    this.fill_sat.set_raw(fill_sat,begin,end);
  }

  protected void set_fill_sat_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.fill_sat == null) this.fill_sat = new Varom();
    this.fill_sat.set_min_raw(min_raw);
    this.fill_sat.set_max_raw(max_raw);
    this.fill_sat.set_min(min);
    this.fill_sat.set_max(max);
  }
  
  // bright
  protected void set_fill_bright(float fill_bright) {
     this.fill_bright.set(fill_bright);
  }

  protected void set_fill_bright_raw(float fill_bright) {
     set_fill_bright_raw(fill_bright,0,0);
  }

  protected void set_fill_bright_raw(float fill_bright, int begin, int end) {
    if(this.fill_bright == null) this.fill_bright = new Varom();
    this.fill_bright.set_raw(fill_bright,begin,end);
  }

  protected void set_fill_bright_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.fill_bright == null) this.fill_bright = new Varom();
    this.fill_bright.set_min_raw(min_raw);
    this.fill_bright.set_max_raw(max_raw);
    this.fill_bright.set_min(min);
    this.fill_bright.set_max(max);
  }
  
  // alpha
  protected void set_fill_alpha(float fill_alpha) {
     this.fill_alpha.set(fill_alpha);
  }

  protected void set_fill_alpha_raw(float fill_alpha) {
     set_fill_alpha_raw(fill_alpha,0,0);
  }

  protected void set_fill_alpha_raw(float fill_alpha, int begin, int end) {
    if(this.fill_alpha == null) this.fill_alpha = new Varom();
    this.fill_alpha.set_raw(fill_alpha,begin,end);
  }

  protected void set_fill_alpha_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.fill_alpha == null) this.fill_alpha = new Varom();
    this.fill_alpha.set_min_raw(min_raw);
    this.fill_alpha.set_max_raw(max_raw);
    this.fill_alpha.set_min(min);
    this.fill_alpha.set_max(max);
  }


  // STROKE
  protected void set_stroke(float... arg) {
    if(arg.length == 1) {
      set_stroke(arg[0],arg[0],arg[0],g.colorModeA);
    } else if(arg.length == 2) {
      set_stroke(arg[0],arg[0],arg[0],arg[1]);
    } else if(arg.length == 3) {
      set_stroke(arg[0],arg[1],arg[2],g.colorModeA);
    } else if(arg.length == 4) {
      set_stroke(arg[0],arg[1],arg[2],arg[3]);
    } else {
      printErrTempo(60,"method set_stroke(float... arg) wait for an array length from 1 to 4");
    }
  }

  protected void set_stroke(float x, float y, float z, float a) {
    this.stroke = color(x,y,z,a);
    set_stroke_hue(x);
    set_stroke_sat(y);
    set_stroke_bright(z);
    set_stroke_alpha(a);
  }

  
  // stroke hue
  protected void set_stroke_hue(float stroke_hue) {
     this.stroke_hue.set(stroke_hue);
  }

  protected void set_stroke_hue_raw(float stroke_hue) {
     set_stroke_hue_raw(stroke_hue,0,0);
  }

  protected void set_stroke_hue_raw(float stroke_hue, int begin, int end) {
    if(this.stroke_hue == null) this.stroke_hue = new Varom();
    this.stroke_hue.set_raw(stroke_hue,begin,end);
  }

  protected void set_stroke_hue_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.stroke_hue == null) this.stroke_hue = new Varom();
    this.stroke_hue.set_min_raw(min_raw);
    this.stroke_hue.set_max_raw(max_raw);
    this.stroke_hue.set_min(min);
    this.stroke_hue.set_max(max);
  }
  
  // stroke sat
  protected void set_stroke_sat(float stroke_sat) {
     this.stroke_sat.set(stroke_sat);
  }

  protected void set_stroke_sat_raw(float stroke_sat) {
     set_stroke_sat_raw(stroke_sat,0,0);
  }

  protected void set_stroke_sat_raw(float stroke_sat, int begin, int end) {
    if(this.stroke_sat == null) this.stroke_sat = new Varom();
    this.stroke_sat.set_raw(stroke_sat,begin,end);
  }

  protected void set_stroke_sat_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.stroke_sat == null) this.stroke_sat = new Varom();
    this.stroke_sat.set_min_raw(min_raw);
    this.stroke_sat.set_max_raw(max_raw);
    this.stroke_sat.set_min(min);
    this.stroke_sat.set_max(max);
  }
  
  // stroke bright
  protected void set_stroke_bright(float stroke_bright) {
     this.stroke_bright.set(stroke_bright);
  }

  protected void set_stroke_bright_raw(float stroke_bright) {
     set_stroke_bright_raw(stroke_bright,0,0);
  }

  protected void set_stroke_bright_raw(float stroke_bright, int begin, int end) {
    if(this.stroke_bright == null) this.stroke_bright = new Varom();
    this.stroke_bright.set_raw(stroke_bright,begin,end);
  }

  protected void set_stroke_bright_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.stroke_bright == null) this.stroke_bright = new Varom();
    this.stroke_bright.set_min_raw(min_raw);
    this.stroke_bright.set_max_raw(max_raw);
    this.stroke_bright.set_min(min);
    this.stroke_bright.set_max(max);
  }

  // stroke alpha
  protected void set_stroke_alpha(float stroke_alpha) {
     this.stroke_alpha.set(stroke_alpha);
  }

  protected void set_stroke_alpha_raw(float stroke_alpha) {
     set_stroke_alpha_raw(stroke_alpha,0,0);
  }

  protected void set_stroke_alpha_raw(float stroke_alpha, int begin, int end) {
    if(this.stroke_alpha == null) this.stroke_alpha = new Varom();
    this.stroke_alpha.set_raw(stroke_alpha,begin,end);
  }

  protected void set_stroke_alpha_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.stroke_alpha == null) this.stroke_alpha = new Varom();
    this.stroke_alpha.set_min_raw(min_raw);
    this.stroke_alpha.set_max_raw(max_raw);
    this.stroke_alpha.set_min(min);
    this.stroke_alpha.set_max(max);
  }
  

  // thickness
  protected void set_thickness_raw(float thickness) {
    set_thickness_raw(thickness,0,0);
  }

  protected void set_thickness_raw(float thickness, int begin, int end) {
    if(this.thickness == null) this.thickness = new Varom();
    this.thickness.set_raw(thickness,begin,end);
  }

  protected void set_thickness_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.thickness == null) this.thickness = new Varom();
    this.thickness.set_min_raw(min_raw);
    this.thickness.set_max_raw(max_raw);
    this.thickness.set_min(min);
    this.thickness.set_max(max);
  }

  // SIZE
  protected void set_size_raw(float size) {
    set_size_raw(size,0,0);
  }

  protected void set_size_raw(float size, int begin, int end) {
    set_size_x_raw(size,begin,end);
    set_size_y_raw(size,begin,end);
    set_size_z_raw(size,begin,end);
  }
  
  // size x
  protected void set_size_x_raw(float size_x) {
    set_size_x_raw(size_x,0,0);
  }

  protected void set_size_x_raw(float size_x, int begin, int end) {
    if(this.size_x == null) this.size_x = new Varom();
    this.size_x.set_raw(size_x,begin,end);
  }

  protected void set_size_x_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.size_x == null) this.size_x = new Varom();
    this.size_x.set_min_raw(min_raw);
    this.size_x.set_max_raw(max_raw);
    this.size_x.set_min(min);
    this.size_x.set_max(max);
  }
  
  // size y
  protected void set_size_y_raw(float size_y) {
    set_size_y_raw(size_y,0,0);
  }

  protected void set_size_y_raw(float size_y, int begin, int end) {
    if(this.size_y == null) this.size_y = new Varom();
    this.size_y.set_raw(size_y,begin,end);
  }

  protected void set_size_y_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.size_y == null) this.size_y = new Varom();
    this.size_y.set_min_raw(min_raw);
    this.size_y.set_max_raw(max_raw);
    this.size_y.set_min(min);
    this.size_y.set_max(max);
  }

  // size z
  protected void set_size_z_raw(float size_z) {
    set_size_z_raw(size_z,0,0);
  }

  protected void set_size_z_raw(float size_z, int begin, int end) {
    if(this.size_z == null) this.size_z = new Varom();
    this.size_z.set_raw(size_z,begin,end);
  }

  protected void set_size_z_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.size_z == null) this.size_z = new Varom();
    this.size_z.set_min_raw(min_raw);
    this.size_z.set_max_raw(max_raw);
    this.size_z.set_min(min);
    this.size_z.set_max(max);
  }
  
  // diameter
  protected void set_diameter_raw(float diameter) {
     set_diameter_raw(diameter,0,0);
  }

  protected void set_diameter_raw(float diameter, int begin, int end) {
    if(this.diameter == null) this.diameter = new Varom();
    this.diameter.set_raw(diameter,begin,end);
  }

  protected void set_diameter_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.diameter == null) this.diameter = new Varom();
    this.diameter.set_min_raw(min_raw);
    this.diameter.set_max_raw(max_raw);
    this.diameter.set_min(min);
    this.diameter.set_max(max);
  }
  
  // CANVAS
  protected void set_canvas_raw(float canvas) {
     set_canvas_raw(canvas,0,0);
  }

  protected void set_canvas_raw(float canvas, int begin, int end) {
    set_canvas_x_raw(canvas,begin,end);
    set_canvas_y_raw(canvas,begin,end);
    set_canvas_z_raw(canvas,begin,end);
  }

  // canvas x
  protected void set_canvas_x_raw(float canvas_x) {
     set_canvas_x_raw(canvas_x,0,0);
  }

  protected void set_canvas_x_raw(float canvas_x, int begin, int end) {
    if(this.canvas_x == null) this.canvas_x = new Varom();
    this.canvas_x.set_raw(canvas_x,begin,end);
  }

  protected void set_canvas_x_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.canvas_x == null) this.canvas_x = new Varom();
    this.canvas_x.set_min_raw(min_raw);
    this.canvas_x.set_max_raw(max_raw);
    this.canvas_x.set_min(min);
    this.canvas_x.set_max(max);
  }

  // canvas y
  protected void set_canvas_y_raw(float canvas_y) {
     set_canvas_y_raw(canvas_y,0,0);
  }

  protected void set_canvas_y_raw(float canvas_y, int begin, int end) {
    if(this.canvas_y == null) this.canvas_y = new Varom();
    this.canvas_y.set_raw(canvas_y,begin,end);
  }

  protected void set_canvas_y_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.canvas_y == null) this.canvas_y = new Varom();
    this.canvas_y.set_min_raw(min_raw);
    this.canvas_y.set_max_raw(max_raw);
    this.canvas_y.set_min(min);
    this.canvas_y.set_max(max);
  }

  // canvas z
  protected void set_canvas_z_raw(float canvas_z) {
     set_canvas_z_raw(canvas_z,0,0);
  }

  protected void set_canvas_z_raw(float canvas_z, int begin, int end) {
    if(this.canvas_z == null) this.canvas_z = new Varom();
    this.canvas_z.set_raw(canvas_z,begin,end);
  }

  protected void set_canvas_z_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.canvas_z == null) this.canvas_z = new Varom();
    this.canvas_z.set_min_raw(min_raw);
    this.canvas_z.set_max_raw(max_raw);
    this.canvas_z.set_min(min);
    this.canvas_z.set_max(max);
  }
  
  // COL 2
  // frequence
  protected void set_frequence_raw(float frequence) {
    set_frequence_raw(frequence,0,0);
  }

  protected void set_frequence_raw(float frequence, int begin, int end) {
    if(this.frequence == null) this.frequence = new Varom();
    this.frequence.set_raw(frequence,begin,end);
  }

  protected void set_frequence_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.frequence == null) this.frequence = new Varom();
    this.frequence.set_min_raw(min_raw);
    this.frequence.set_max_raw(max_raw);
    this.frequence.set_min(min);
    this.frequence.set_max(max);
  }
  
  // SPEED
  protected void set_speed_raw(float speed) {
     set_speed_raw(speed,0,0);
  }

  protected void set_speed_raw(float speed, int begin, int end) {
    set_speed_x_raw(speed,begin,end);
    set_speed_y_raw(speed,begin,end);
    set_speed_z_raw(speed,begin,end);
  }
  
  // speed x
  protected void set_speed_x_raw(float speed_x) {
     set_speed_x_raw(speed_x,0,0);
  }

  protected void set_speed_x_raw(float speed_x, int begin, int end) {
    if(this.speed_x == null) this.speed_x = new Varom();
    this.speed_x.set_raw(speed_x,begin,end);
  }

  protected void set_speed_x_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.speed_x == null) this.speed_x = new Varom();
    this.speed_x.set_min_raw(min_raw);
    this.speed_x.set_max_raw(max_raw);
    this.speed_x.set_min(min);
    this.speed_x.set_max(max);
  }
  
  // speed y
  protected void set_speed_y_raw(float speed_y) {
     set_speed_y_raw(speed_y,0,0);
  }

  protected void set_speed_y_raw(float speed_y, int begin, int end) {
    if(this.speed_y == null) this.speed_y = new Varom();
    this.speed_y.set_raw(speed_y,begin,end);
  }

  protected void set_speed_y_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.speed_y == null) this.speed_y = new Varom();
    this.speed_y.set_min_raw(min_raw);
    this.speed_y.set_max_raw(max_raw);
    this.speed_y.set_min(min);
    this.speed_y.set_max(max);
  }
  
  // speed z
  protected void set_speed_z_raw(float speed_z) {
    set_speed_z_raw(speed_z,0,0);
  }

  protected void set_speed_z_raw(float speed_z, int begin, int end) {
    if(this.speed_z == null) this.speed_z = new Varom();
    this.speed_z.set_raw(speed_z,begin,end);
  }

  protected void set_speed_z_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.speed_z == null) this.speed_z = new Varom();
    this.speed_z.set_min_raw(min_raw);
    this.speed_z.set_max_raw(max_raw);
    this.speed_z.set_min(min);
    this.speed_z.set_max(max);
  }
  
  // SPURT
  protected void set_spurt_raw(float spurt) {
    set_spurt_raw(spurt,0,0);
  }

  protected void set_spurt_raw(float spurt, int begin, int end) {
    set_spurt_x_raw(spurt,begin,end);
    set_spurt_y_raw(spurt,begin,end);
    set_spurt_z_raw(spurt,begin,end);
  }
  
  // spurt x
  protected void set_spurt_x_raw(float spurt_x) {
     set_spurt_x_raw(spurt_x,0,0);
  }

  protected void set_spurt_x_raw(float spurt_x, int begin, int end) {
    if(this.spurt_x == null) this.spurt_x = new Varom();
    this.spurt_x.set_raw(spurt_x,begin,end);
  }

  protected void set_spurt_x_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.spurt_x == null) this.spurt_x = new Varom();
    this.spurt_x.set_min_raw(min_raw);
    this.spurt_x.set_max_raw(max_raw);
    this.spurt_x.set_min(min);
    this.spurt_x.set_max(max);
  }

  // spurt y
  protected void set_spurt_y_raw(float spurt_y) {
     set_spurt_y_raw(spurt_y,0,0);
  }

  protected void set_spurt_y_raw(float spurt_y, int begin, int end) {
    if(this.spurt_y == null) this.spurt_y = new Varom();
    this.spurt_y.set_raw(spurt_y,begin,end);
  }

  protected void set_spurt_y_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.spurt_y == null) this.spurt_y = new Varom();
    this.spurt_y.set_min_raw(min_raw);
    this.spurt_y.set_max_raw(max_raw);
    this.spurt_y.set_min(min);
    this.spurt_y.set_max(max);
  }

  // spurt z
  protected void set_spurt_z_raw(float spurt_z) {
     set_spurt_z_raw(spurt_z,0,0);
  }

  protected void set_spurt_z_raw(float spurt_z, int begin, int end) {
    if(this.spurt_z == null) this.spurt_z = new Varom();
    this.spurt_z.set_raw(spurt_z,begin,end);
  }

  protected void set_spurt_z_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.spurt_z == null) this.spurt_z = new Varom();
    this.spurt_z.set_min_raw(min_raw);
    this.spurt_z.set_max_raw(max_raw);
    this.spurt_z.set_min(min);
    this.spurt_z.set_max(max);
  }
  
  // DIR
  protected void set_dir_raw(float dir) {
     set_dir_raw(dir,0,0);
  }

  protected void set_dir_raw(float dir, int begin, int end) {
    set_dir_x_raw(dir,begin,end);
    set_dir_y_raw(dir,begin,end);
    set_dir_z_raw(dir,begin,end);
  }
  
  // dir x
  protected void set_dir_x_raw(float dir_x) {
     set_dir_x_raw(dir_x,0,0);
  }

  protected void set_dir_x_raw(float dir_x, int begin, int end) {
    if(this.dir_x == null) this.dir_x = new Varom();
    this.dir_x.set_raw(dir_x,begin,end);
  }

  protected void set_dir_x_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.dir_x == null) this.dir_x = new Varom();
    this.dir_x.set_min_raw(min_raw);
    this.dir_x.set_max_raw(max_raw);
    this.dir_x.set_min(min);
    this.dir_x.set_max(max);
  }

  // dir y
  protected void set_dir_y_raw(float dir_y) {
     set_dir_y_raw(dir_y,0,0);
  }

  protected void set_dir_y_raw(float dir_y, int begin, int end) {
    if(this.dir_y == null) this.dir_y = new Varom();
    this.dir_y.set_raw(dir_y,begin,end);
  }

  protected void set_dir_y_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.dir_y == null) this.dir_y = new Varom();
    this.dir_y.set_min_raw(min_raw);
    this.dir_y.set_max_raw(max_raw);
    this.dir_y.set_min(min);
    this.dir_y.set_max(max);
  }

  // dir z
  protected void set_dir_z_raw(float dir_z) {
     set_dir_z_raw(dir_z,0,0);
  }

  protected void set_dir_z_raw(float dir_z, int begin, int end) {
    if(this.dir_z == null) this.dir_z = new Varom();
    this.dir_z.set_raw(dir_z,begin,end);
  }

  protected void set_dir_z_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.dir_z == null) this.dir_z = new Varom();
    this.dir_z.set_min_raw(min_raw);
    this.dir_z.set_max_raw(max_raw);
    this.dir_z.set_min(min);
    this.dir_z.set_max(max);
  }
  
  // JITTER
  protected void set_jitter_raw(float jitter) {
     set_jitter_raw(jitter,0,0);
  }

  protected void set_jitter_raw(float jitter, int begin, int end) {
    set_jitter_x_raw(jitter,begin,end);
    set_jitter_y_raw(jitter,begin,end);
    set_jitter_z_raw(jitter,begin,end);
  }

  // jitter x
  protected void set_jitter_x_raw(float jitter_x) {
     set_jitter_x_raw(jitter_x,0,0);
  }

  protected void set_jitter_x_raw(float jitter_x, int begin, int end) {
    if(this.jitter_x == null) this.jitter_x = new Varom();
    this.jitter_x.set_raw(jitter_x,begin,end);
  }

  protected void set_jitter_x_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.jitter_x == null) this.jitter_x = new Varom();
    this.jitter_x.set_min_raw(min_raw);
    this.jitter_x.set_max_raw(max_raw);
    this.jitter_x.set_min(min);
    this.jitter_x.set_max(max);
  }

  // jitter y
  protected void set_jitter_y_raw(float jitter_y) {
     set_jitter_y_raw(jitter_y,0,0);
  }

  protected void set_jitter_y_raw(float jitter_y, int begin, int end) {
    if(this.jitter_y == null) this.jitter_y = new Varom();
    this.jitter_y.set_raw(jitter_y,begin,end);
  }

  protected void set_jitter_y_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.jitter_y == null) this.jitter_y = new Varom();
    this.jitter_y.set_min_raw(min_raw);
    this.jitter_y.set_max_raw(max_raw);
    this.jitter_y.set_min(min);
    this.jitter_y.set_max(max);
  }

  // jitter z
  protected void set_jitter_z_raw(float jitter_z) {
     set_jitter_z_raw(jitter_z,0,0);
  }

  protected void set_jitter_z_raw(float jitter_z, int begin, int end) {
    if(this.jitter_z == null) this.jitter_z = new Varom();
    this.jitter_z.set_raw(jitter_z,begin,end);
  }

  protected void set_jitter_z_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.jitter_z == null) this.jitter_z = new Varom();
    this.jitter_z.set_min_raw(min_raw);
    this.jitter_z.set_max_raw(max_raw);
    this.jitter_z.set_min(min);
    this.jitter_z.set_max(max);
  }
  
  // SWING
  protected void set_swing_raw(float swing) {
     set_swing_raw(swing,0,0);
  }

  protected void set_swing_raw(float swing, int begin, int end) {
    set_swing_x_raw(swing,begin,end);
    set_swing_y_raw(swing,begin,end);
    set_swing_z_raw(swing,begin,end);
  }
  
  // swing x
  protected void set_swing_x_raw(float swing_x) {
     set_swing_x_raw(swing_x,0,0);
  }

  protected void set_swing_x_raw(float swing_x, int begin, int end) {
    if(this.swing_x == null) this.swing_x = new Varom();
    this.swing_x.set_raw(swing_x,begin,end);
  }

  protected void set_swing_x_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.swing_x == null) this.swing_x = new Varom();
    this.swing_x.set_min_raw(min_raw);
    this.swing_x.set_max_raw(max_raw);
    this.swing_x.set_min(min);
    this.swing_x.set_max(max);
  }
  
  // swing y
  protected void set_swing_y_raw(float swing_y) {
     set_swing_y_raw(swing_y,0,0);
  }

  protected void set_swing_y_raw(float swing_y, int begin, int end) {
    if(this.swing_y == null) this.swing_y = new Varom();
    this.swing_y.set_raw(swing_y,begin,end);
  }

  protected void set_swing_y_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.swing_y == null) this.swing_y = new Varom();
    this.swing_y.set_min_raw(min_raw);
    this.swing_y.set_max_raw(max_raw);
    this.swing_y.set_min(min);
    this.swing_y.set_max(max);
  }
  
  // swing z
  protected void set_swing_z_raw(float swing_z) {
     set_swing_z_raw(swing_z,0,0);
  }

  protected void set_swing_z_raw(float swing_z, int begin, int end) {
    if(this.swing_z == null) this.swing_z = new Varom();
    this.swing_z.set_raw(swing_z,begin,end);
  }

  protected void set_swing_z_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.swing_z == null) this.swing_z = new Varom();
    this.swing_z.set_min_raw(min_raw);
    this.swing_z.set_max_raw(max_raw);
    this.swing_z.set_min(min);
    this.swing_z.set_max(max);
  }


  // COL 3
  //quantity
  protected void set_quantity_raw(float quantity) {
     set_quantity_raw(quantity,0,0);
  }

  protected void set_quantity_raw(float quantity, int begin, int end) {
    if(this.quantity == null) this.quantity = new Varom();
    this.quantity.set_raw(quantity,begin,end);
  }

  protected void set_quantity_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.quantity == null) this.quantity = new Varom();
    this.quantity.set_min_raw(min_raw);
    this.quantity.set_max_raw(max_raw);
    this.quantity.set_min(min);
    this.quantity.set_max(max);
  }
  
  // variety
  protected void set_variety_raw(float variety) {
     set_variety_raw(variety,0,0);
  }

  protected void set_variety_raw(float variety, int begin, int end) {
    if(this.variety == null) this.variety = new Varom();
    this.variety.set_raw(variety,begin,end);
  }

  protected void set_variety_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.variety == null) this.variety = new Varom();
    this.variety.set_min_raw(min_raw);
    this.variety.set_max_raw(max_raw);
    this.variety.set_min(min);
    this.variety.set_max(max);
  }

  // life
  protected void set_life_raw(float life) {
     set_life_raw(life,0,0);
  }

  protected void set_life_raw(float life, int begin, int end) {
    if(this.life == null) this.life = new Varom();
    this.life.set_raw(life,begin,end);
  }

  protected void set_life_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.life == null) this.life = new Varom();
    this.life.set_min_raw(min_raw);
    this.life.set_max_raw(max_raw);
    this.life.set_min(min);
    this.life.set_max(max);
  }

  // flow
  protected void set_flow_raw(float flow) {
     set_flow_raw(flow,0,0);
  }

  protected void set_flow_raw(float flow, int begin, int end) {
    if(this.flow == null) this.flow = new Varom();
    this.flow.set_raw(flow,begin,end);
  }

  protected void set_flow_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.flow == null) this.flow = new Varom();
    this.flow.set_min_raw(min_raw);
    this.flow.set_max_raw(max_raw);
    this.flow.set_min(min);
    this.flow.set_max(max);
  }

  // quality
  protected void set_quality_raw(float quality) {
     set_quality_raw(quality,0,0);
  }

  protected void set_quality_raw(float quality, int begin, int end) {
    if(this.quality == null) this.quality = new Varom();
    this.quality.set_raw(quality,begin,end);
  }

  protected void set_quality_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.quality == null) this.quality = new Varom();
    this.quality.set_min_raw(min_raw);
    this.quality.set_max_raw(max_raw);
    this.quality.set_min(min);
    this.quality.set_max(max);
  }

  // area
  protected void set_area_raw(float area) {
    set_area_raw(area,0,0);
  }

  protected void set_area_raw(float area, int begin, int end) {
    if(this.area == null) this.area = new Varom();
    this.area.set_raw(area,begin,end);
  }

  protected void set_area_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.area == null) this.area = new Varom();
    this.area.set_min_raw(min_raw);
    this.area.set_max_raw(max_raw);
    this.area.set_min(min);
    this.area.set_max(max);
  }

  // angle
  protected void set_angle_raw(float angle) {
    set_angle_raw(angle,0,0);
  }

  protected void set_angle_raw(float angle, int begin, int end) {
    if(this.angle == null) this.angle = new Varom();
    this.angle.set_raw(angle,begin,end);
  }

  protected void set_angle_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.angle == null) this.angle = new Varom();
    this.angle.set_min_raw(min_raw);
    this.angle.set_max_raw(max_raw);
    this.angle.set_min(min);
    this.angle.set_max(max);
  }

  // scope
  protected void set_scope_raw(float scope) {
    set_scope_raw(scope,0,0);
  }

  protected void set_scope_raw(float scope, int begin, int end) {
    if(this.scope == null) this.scope = new Varom();
    this.scope.set_raw(scope,begin,end);
  }

  protected void set_scope_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.scope == null) this.scope = new Varom();
    this.scope.set_min_raw(min_raw);
    this.scope.set_max_raw(max_raw);
    this.scope.set_min(min);
    this.scope.set_max(max);
  }

  // scan
  protected void set_scan_raw(float scan) {
    set_scan_raw(scan,0,0);
  }

  protected void set_scan_raw(float scan, int begin, int end) {
    if(this.scan == null) this.scan = new Varom();
    this.scan.set_raw(scan,begin,end);
  }

  protected void set_scan_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.scan == null) this.scan = new Varom();
    this.scan.set_min_raw(min_raw);
    this.scan.set_max_raw(max_raw);
    this.scan.set_min(min);
    this.scan.set_max(max);
  }

  // alignment
  protected void set_alignment_raw(float alignment) {
    set_alignment_raw(alignment,0,0);
  }

  protected void set_alignment_raw(float alignment, int begin, int end) {
    if(this.alignment == null) this.alignment = new Varom();
    this.alignment.set_raw(alignment,begin,end);
  }

  protected void set_alignment_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.alignment == null) this.alignment = new Varom();
    this.alignment.set_min_raw(min_raw);
    this.alignment.set_max_raw(max_raw);
    this.alignment.set_min(min);
    this.alignment.set_max(max);
  }
  
  // repulsion
  protected void set_repulsion_raw(float repulsion) {
    set_repulsion_raw(repulsion,0,0);
  }

  protected void set_repulsion_raw(float repulsion, int begin, int end) {
    if(this.repulsion == null) this.repulsion = new Varom();
    this.repulsion.set_raw(repulsion,begin,end);
  }

  protected void set_repulsion_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.repulsion == null) this.repulsion = new Varom();
    this.repulsion.set_min_raw(min_raw);
    this.repulsion.set_max_raw(max_raw);
    this.repulsion.set_min(min);
    this.repulsion.set_max(max);
  }
  
  // attraction
  protected void set_attraction_raw(float attraction) {
    set_attraction_raw(attraction,0,0);
  }

  protected void set_attraction_raw(float attraction, int begin, int end) {
    if(this.attraction == null) this.attraction = new Varom();
    this.attraction.set_raw(attraction,begin,end);
  }

  protected void set_attraction_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.attraction == null) this.attraction = new Varom();
    this.attraction.set_min_raw(min_raw);
    this.attraction.set_max_raw(max_raw);
    this.attraction.set_min(min);
    this.attraction.set_max(max);
  }
  
  // density
  protected void set_density_raw(float density) {
    set_density_raw(density,0,0);
  }

  protected void set_density_raw(float density, int begin, int end) {
    if(this.density == null) this.density = new Varom();
    this.density.set_raw(density,begin,end);
  }

  protected void set_density_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.density == null) this.density = new Varom();
    this.density.set_min_raw(min_raw);
    this.density.set_max_raw(max_raw);
    this.density.set_min(min);
    this.density.set_max(max);
  }
  
  // influence
  protected void set_influence_raw(float influence) {
    set_influence_raw(influence,0,0);
  }

  protected void set_influence_raw(float influence, int begin, int end) {
    if(this.influence == null) this.influence = new Varom();
    this.influence.set_raw(influence,begin,end);
  }

  protected void set_influence_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.influence == null) this.influence = new Varom();
    this.influence.set_min_raw(min_raw);
    this.influence.set_max_raw(max_raw);
    this.influence.set_min(min);
    this.influence.set_max(max);
  }
  
  // calm
  protected void set_calm_raw(float calm) {
    set_calm_raw(calm,0,0);
  }

  protected void set_calm_raw(float calm, int begin, int end) {
    if(this.calm == null) this.calm = new Varom();
    this.calm.set_raw(calm,begin,end);
  }

  protected void set_calm_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.calm == null) this.calm = new Varom();
    this.calm.set_min_raw(min_raw);
    this.calm.set_max_raw(max_raw);
    this.calm.set_min(min);
    this.calm.set_max(max);
  }

  // spectrum
  protected void set_spectrum_raw(float spectrum) {
    set_spectrum_raw(spectrum,0,0);
  }

  protected void set_spectrum_raw(float spectrum, int begin, int end) {
    if(this.spectrum == null) this.spectrum = new Varom();
    this.spectrum.set_raw(spectrum,begin,end);
  }

  protected void set_spectrum_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.spectrum == null) this.spectrum = new Varom();
    this.spectrum.set_min_raw(min_raw);
    this.spectrum.set_max_raw(max_raw);
    this.spectrum.set_min(min);
    this.spectrum.set_max(max);
  }
  
  // COL 4
  // grid
  protected void set_grid_raw(float grid) {
    set_grid_raw(grid,0,0);
  }

  protected void set_grid_raw(float grid, int begin, int end) {
    if(this.grid == null) this.grid = new Varom();
    this.grid.set_raw(grid,begin,end);
  }

  protected void set_grid_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.grid == null) this.grid = new Varom();
    this.grid.set_min_raw(min_raw);
    this.grid.set_max_raw(max_raw);
    this.grid.set_min(min);
    this.grid.set_max(max);
  }
  
  // viscosity
  protected void set_viscosity_raw(float viscosity) {
    set_viscosity_raw(viscosity,0,0);
  }

  protected void set_viscosity_raw(float viscosity, int begin, int end) {
    if(this.viscosity == null) this.viscosity = new Varom();
    this.viscosity.set_raw(viscosity,begin,end);
  }

  protected void set_viscosity_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.viscosity == null) this.viscosity = new Varom();
    this.viscosity.set_min_raw(min_raw);
    this.viscosity.set_max_raw(max_raw);
    this.viscosity.set_min(min);
    this.viscosity.set_max(max);
  }
  
  // diffusion
  protected void set_diffusion_raw(float diffusion) {
    set_diffusion_raw(diffusion,0,0);
  }

  protected void set_diffusion_raw(float diffusion, int begin, int end) {
    if(this.diffusion == null) this.diffusion = new Varom();
    this.diffusion.set_raw(diffusion,begin,end);
  }

  protected void set_diffusion_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.diffusion == null) this.diffusion = new Varom();
    this.diffusion.set_min_raw(min_raw);
    this.diffusion.set_max_raw(max_raw);
    this.diffusion.set_min(min);
    this.diffusion.set_max(max);
  }
  
  // power
  protected void set_power_raw(float power) {
    set_power_raw(power,0,0);
  }

  protected void set_power_raw(float power, int begin, int end) {
    if(this.power == null) this.power = new Varom();
    this.power.set_raw(power,begin,end);
  }

  protected void set_power_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.power == null) this.power = new Varom();
    this.power.set_min_raw(min_raw);
    this.power.set_max_raw(max_raw);
    this.power.set_min(min);
    this.power.set_max(max);
  }
  
  // mass
  protected void set_mass_raw(float mass) {
    set_mass_raw(mass,0,0);
  }

  protected void set_mass_raw(float mass, int begin, int end) {
    if(this.mass == null) this.mass = new Varom();
    this.mass.set_raw(mass,begin,end);
  }

  protected void set_mass_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.mass == null) this.mass = new Varom();
    this.mass.set_min_raw(min_raw);
    this.mass.set_max_raw(max_raw);
    this.mass.set_min(min);
    this.mass.set_max(max);
  }
  
  // COORD
  protected void set_coord_raw(float coord) {
    set_coord_raw(coord,0,0);
  }

  protected void set_coord_raw(float coord, int begin, int end) {
    set_coord_x_raw(coord,begin,end);
    set_coord_y_raw(coord,begin,end);
    set_coord_z_raw(coord,begin,end);
  }

  // coord x
  protected void set_coord_x_raw(float coord_x) {
    set_coord_x_raw(coord_x,0,0);
  }

  protected void set_coord_x_raw(float coord_x, int begin, int end) {
    if(this.coord_x == null) this.coord_x = new Varom();
    this.coord_x.set_raw(coord_x,begin,end);
  }

  protected void set_coord_x_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.coord_x == null) this.coord_x = new Varom();
    this.coord_x.set_min_raw(min_raw);
    this.coord_x.set_max_raw(max_raw);
    this.coord_x.set_min(min);
    this.coord_x.set_max(max);
  }

  // coord y
  protected void set_coord_y_raw(float coord_y) {
    set_coord_y_raw(coord_y,0,0);
  }

  protected void set_coord_y_raw(float coord_y, int begin, int end) {
    if(this.coord_y == null) this.coord_y = new Varom();
    this.coord_y.set_raw(coord_y,begin,end);
  }

  protected void set_coord_y_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.coord_y == null) this.coord_y = new Varom();
    this.coord_y.set_min_raw(min_raw);
    this.coord_y.set_max_raw(max_raw);
    this.coord_y.set_min(min);
    this.coord_y.set_max(max);
  }

  // coord z
  protected void set_coord_z_raw(float coord_z) {
    set_coord_z_raw(coord_z,0,0);
  }

  protected void set_coord_z_raw(float coord_z, int begin, int end) {
    if(this.coord_z == null) this.coord_z = new Varom();
    this.coord_z.set_raw(coord_z,begin,end);
  }

  protected void set_coord_z_min_max(float min_raw, float max_raw, float min, float max) {
    if(this.coord_z == null) this.coord_z = new Varom();
    this.coord_z.set_min_raw(min_raw);
    this.coord_z.set_max_raw(max_raw);
    this.coord_z.set_min(min);
    this.coord_z.set_max(max);
  }










  // set boolean
  protected void set_show(boolean show) {
    this.show = show;
  }

  protected void set_sound(boolean sound) {
    this.sound = sound;
  }

  protected void set_action(boolean action) {
    this.action = action;
  }

  protected void set_parameter(boolean parameter) {
    this.parameter = parameter;
  }

  protected void birth_is(boolean birth) {
    this.birth = birth;
  }

  protected void colour_is(boolean colour) {
    this.colour = colour;
  }

  protected void dimension_is(boolean dimension) {
    this.dimension = dimension;
  }

  protected void horizon_is(boolean horizon) {
    this.horizon = horizon;
  }

  protected void motion_is(boolean motion) {
    this.motion = motion;
  }

  protected void follow_is(boolean follow) {
    this.follow = follow;
  }

  protected void reverse_is(boolean reverse) {
    this.reverse = reverse;
  }

  protected void special_is(boolean special) {
    this.special = special;
  }

  protected void wire_is(boolean wire) {
    this.wire = wire;
  }

  protected void fill_is(boolean fill_is) {
    this.fill_is = fill_is;
  }

  protected void stroke_is(boolean stroke_is) {
    this.stroke_is = stroke_is;
  }

  protected void switch_birth() {
    this.birth = !this.birth;
  }

  protected void switch_colour() {
    this.colour = !this.colour;
  }

  protected void switch_dimension() {
    this.dimension = !this.dimension;
  }

  protected void switch_horizon() {
    this.horizon = !this.horizon;
  }

  protected void switch_motion() {
    this.motion = !this.motion;
  }

  protected void switch_follow() {
    this.follow = !this.follow;
  }

  protected void switch_reverse() {
    this.reverse = !this.reverse;
  }

  protected void switch_special() {
    this.special = !this.special;
  }

  protected void switch_wire() {
    this.wire = !this.wire;
  }

  protected void switch_fill() {
    this.fill_is = !this.fill_is;
  }

  protected void switch_stroke() {
    this.stroke_is = !this.stroke_is;
  }

  protected void switch_setting() {
    this.setting = !this.setting;
  }

  protected void clearList_is(boolean clearList) {
    this.clearList = clearList;
  }

  protected void set_font(ROFont font) {
    this.font_item = font;
  }

  protected void select_font_type(String type) {
    for(int i = 0 ; i < font.length ;i++) {
      if(font[i].get_type().equals(type)) {
        font_item = font[i];
        break;
      }
    }
  }














  
  /**
  ALL GET METHOD
  */
  protected int get_id() {
    return ID_item;
  }

  protected int get_group() {
    return ID_group;
  }

  protected String get_name() {
    return item_name;
  }

  protected boolean show_is() {
    return show;
  }

  protected boolean sound_is() {
    return sound;
  }

  protected boolean action_is() {
    return action; 
  } 

  protected boolean parameter_is() {
    return parameter;
  }

  protected Mode get_mode() {
    return mode;
  }

  protected int get_mode_id() {
    return mode.get_id();
  }

  protected String [] get_mode_all_names() {
    return mode.get_name();
  }

  protected String get_mode_name() {
    return mode.get_name(mode.get_id());
  }

  protected Costume get_costume() {
    return get_costume_private();
  }

  protected int get_costume_id() {
    return costume_id;
  }




  /**
  state method use in Prescene generally
  */
  protected boolean fill_is() {
    return fill_is;
  }

  protected boolean stroke_is() {
    return stroke_is;
  }

  protected boolean birth_is() {
    return birth;
  }
  
  protected boolean colour_is() {
    return colour;

  }
  protected boolean dimension_is() {
    return dimension;
  }
  
  protected boolean horizon_is() {
    return horizon;
  }

  protected boolean motion_is() {
    return motion;
  }

  protected boolean follow_is() {
    return follow;
  }

  protected boolean reverse_is() {
    return reverse;
  }

  protected boolean wire_is() {
    return wire;
  }

  protected boolean special_is() {
    return special;
  }


  protected boolean clear_list_is() {
    return clearList;
  }
  


  /**
  * get slider method 
  */
  // FILL
  protected int get_fill() {
    return fill;
  }
  
  // fill_hue
  protected float get_fill_hue() {
    return fill_hue.get();
  }

  protected float get_fill_hue_raw() {
    return fill_hue.raw();
  }

  protected float get_fill_hue_max() {
    return fill_hue.max();
  }

  protected float get_fill_hue_min() {
    return fill_hue.min();
  }
  
  // fill_sat
  protected float get_fill_sat() {
    return fill_sat.get();
  }

  protected float get_fill_sat_raw() {
    return fill_sat.raw();
  }

  protected float get_fill_sat_max() {
    return fill_sat.max();
  }

  protected float get_fill_sat_min() {
    return fill_sat.min();
  }
  
  // fill_bright
  protected float get_fill_bright() {
    return fill_bright.get();
  }

  protected float get_fill_bright_raw() {
    return fill_bright.raw();
  }

  protected float get_fill_bright_max() {
    return fill_bright.max();
  }

  protected float get_fill_bright_min() {
    return fill_bright.min();
  }
  
  // fill_alpha
  protected float get_fill_alpha() {
    return fill_alpha.get();
  }

  protected float get_fill_alpha_raw() {
    return fill_alpha.raw();
  }

  protected float get_fill_alpha_max() {
    return fill_alpha.max();
  }

  protected float get_fill_alpha_min() {
    return fill_alpha.min();
  }
  
  // STROKE
  protected int get_stroke() {
    return stroke;
  }
  // stroke_hue
  protected float get_stroke_hue() {
    return stroke_hue.get();
  }

  protected float get_stroke_hue_raw() {
    return stroke_hue.raw();
  }

  protected float get_stroke_hue_max() {
    return stroke_hue.max();
  }

  protected float get_stroke_hue_min() {
    return stroke_hue.min();
  }
  
  // stroke_sat
  protected float get_stroke_sat() {
    return stroke_sat.get();
  }

  protected float get_stroke_sat_raw() {
    return stroke_sat.raw();
  }

  protected float get_stroke_sat_max() {
    return stroke_sat.max();
  }

  protected float get_stroke_sat_min() {
    return stroke_sat.min();
  }
  
  // stroke_bright
  protected float get_stroke_bright() {
    return stroke_bright.get();
  }

  protected float get_stroke_bright_raw() {
    return stroke_bright.raw();
  }

  protected float get_stroke_bright_max() {
    return stroke_bright.max();
  }

  protected float get_stroke_bright_min() {
    return stroke_bright.min();
  }
  
  // stroke_alpha
  protected float get_stroke_alpha() {
    return stroke_alpha.get();
  }

  protected float get_stroke_alpha_raw() {
    return stroke_alpha.raw();
  }

  protected float get_stroke_alpha_max() {
    return stroke_alpha.max();
  }

  protected float get_stroke_alpha_min() {
    return stroke_alpha.min();
  }

  // thickness
  protected float get_thickness() {
    return thickness.get();
  }

  protected float get_thickness_raw() {
    return thickness.raw();
  }

  protected float get_thickness_max() {
    return thickness.max();
  }

  protected float get_thickness_min() {
    return thickness.min();
  }
  

  // size
  protected vec3 get_size() {
    return vec3(get_size_x(),get_size_y(),get_size_z());
  }
  
  // size x
  protected float get_size_x() {
    return size_x.get();
  }

  protected float get_size_x_raw() {
    return size_x.raw();
  }

  protected float get_size_x_max() {
    return size_x.max();
  }

  protected float get_size_x_min() {
    return size_x.min();
  }

  // size y
  protected float get_size_y() {
    return size_y.get();
  }

  protected float get_size_y_raw() {
    return size_y.raw();
  }

  protected float get_size_y_max() {
    return size_y.max();
  }

  protected float get_size_y_min() {
    return size_y.min();
  }

  // size z
  protected float get_size_z() {
    return size_z.get();
  }

  protected float get_size_z_raw() {
    return size_z.raw();
  }

  protected float get_size_z_max() {
    return size_z.max();
  }

  protected float get_size_z_min() {
    return size_z.min();
  }
  
  // diameter
  protected float get_diameter() {
    return diameter.get();
  }

  protected float get_diameter_raw() {
    return diameter.raw();
  }

  protected float get_diameter_max() {
    return diameter.max();
  }

  protected float get_diameter_min() {
    return diameter.min();
  }

  // canvas
  protected vec3 get_canvas() {
    return vec3(get_canvas_x(),get_canvas_y(),get_canvas_z());
  }

  // canvas x
  protected float get_canvas_x() {
    return canvas_x.get();
  }

  protected float get_canvas_x_raw() {
    return canvas_x.raw();
  }

  protected float get_canvas_x_max() {
    return canvas_x.max();
  }

  protected float get_canvas_x_min() {
    return canvas_x.min();
  }

  // size y
  protected float get_canvas_y() {
    return canvas_y.get();
  }

  protected float get_canvas_y_raw() {
    return canvas_y.raw();
  }

  protected float get_canvas_y_max() {
    return canvas_y.max();
  }

  protected float get_canvas_y_min() {
    return canvas_y.min();
  }

  // size z
  protected float get_canvas_z() {
    return canvas_z.get();
  }

  protected float get_canvas_z_raw() {
    return canvas_z.raw();
  }

  protected float get_canvas_z_max() {
    return canvas_z.max();
  }

  protected float get_canvas_z_min() {
    return canvas_z.min();
  }


  // COL 2
  // frequence
  protected float get_frequence() {
    return frequence.get();
  }

  protected float get_frequence_raw() {
    return frequence.raw();
  }

  protected float get_frequence_max() {
    return frequence.max();
  }

  protected float get_frequence_min() {
    return frequence.min();
  }


  // speed
  protected vec3 get_speed() {
    return vec3(get_speed_x(),get_speed_y(),get_speed_z());
  }

  // speed x
  protected float get_speed_x() {
    return speed_x.get();
  }

  protected float get_speed_x_raw() {
    return speed_x.raw();
  }

  protected float get_speed_x_max() {
    return speed_x.max();
  }

  protected float get_speed_x_min() {
    return speed_x.min();
  }

  // speed y
  protected float get_speed_y() {
    return speed_y.get();
  }

  protected float get_speed_y_raw() {
    return speed_y.raw();
  }

  protected float get_speed_y_max() {
    return speed_y.max();
  }

  protected float get_speed_y_min() {
    return speed_y.min();
  }

  // speed z
  protected float get_speed_z() {
    return speed_z.get();
  }

  protected float get_speed_z_raw() {
    return speed_z.raw();
  }

  protected float get_speed_z_max() {
    return speed_z.max();
  }

  protected float get_speed_z_min() {
    return speed_z.min();
  }

  // spurt
  protected vec3 get_spurt() {
    return vec3(get_spurt_x(),get_spurt_y(),get_spurt_z());
  }

  // spurt x
  protected float get_spurt_x() {
    return spurt_x.get();
  }

  protected float get_spurt_x_raw() {
    return spurt_x.raw();
  }

  protected float get_spurt_x_max() {
    return spurt_x.max();
  }

  protected float get_spurt_x_min() {
    return spurt_x.min();
  }

  // spurt y
  protected float get_spurt_y() {
    return spurt_y.get();
  }

  protected float get_spurt_y_raw() {
    return spurt_y.raw();
  }

  protected float get_spurt_y_max() {
    return spurt_y.max();
  }

  protected float get_spurt_y_min() {
    return spurt_y.min();
  }

  // spurt z
  protected float get_spurt_z() {
    return spurt_z.get();
  }

  protected float get_spurt_z_raw() {
    return spurt_z.raw();
  }

  protected float get_spurt_z_max() {
    return spurt_z.max();
  }

  protected float get_spurt_z_min() {
    return spurt_z.min();
  }

  // DIR
  protected vec3 get_dir() {
    return vec3(get_dir_x(),get_dir_y(),get_dir_z());
  }

  // dir x
  protected float get_dir_x() {
    return dir_x.get();
  }

  protected float get_dir_x_raw() {
    return dir_x.raw();
  }

  protected float get_dir_x_max() {
    return dir_x.max();
  }

  protected float get_dir_x_min() {
    return dir_x.min();
  }

  // dir y
  protected float get_dir_y() {
    return dir_y.get();
  }

  protected float get_dir_y_raw() {
    return dir_y.raw();
  }

  protected float get_dir_y_max() {
    return dir_y.max();
  }

  protected float get_dir_y_min() {
    return dir_y.min();
  }

  // dir z
  protected float get_dir_z() {
    return dir_z.get();
  }

  protected float get_dir_z_raw() {
    return dir_z.raw();
  }

  protected float get_dir_z_max() {
    return dir_z.max();
  }

  protected float get_dir_z_min() {
    return dir_z.min();
  }

  // JITTER
  protected vec3 get_jitter() {
    return vec3(get_jitter_x(),get_jitter_y(),get_jitter_z());
  }

  // jitter x
  protected float get_jitter_x() {
    return jitter_x.get();
  }

  protected float get_jitter_x_raw() {
    return jitter_x.raw();
  }

  protected float get_jitter_x_max() {
    return jitter_x.max();
  }

  protected float get_jitter_x_min() {
    return jitter_x.min();
  }

  // jitter y
  protected float get_jitter_y() {
    return jitter_y.get();
  }

  protected float get_jitter_y_raw() {
    return jitter_y.raw();
  }

  protected float get_jitter_y_max() {
    return jitter_y.max();
  }

  protected float get_jitter_y_min() {
    return jitter_y.min();
  }

  // jitter z
  protected float get_jitter_z() {
    return jitter_z.get();
  }

  protected float get_jitter_z_raw() {
    return jitter_z.raw();
  }

  protected float get_jitter_z_max() {
    return jitter_z.max();
  }

  protected float get_jitter_z_min() {
    return jitter_z.min();
  }


  // SWING
  protected vec3 get_swing() {
    return vec3(get_swing_x(),get_swing_y(),get_swing_z());
  }

  // swing x
  protected float get_swing_x() {
    return swing_x.get();
  }

  protected float get_swing_x_raw() {
    return swing_x.raw();
  }

  protected float get_swing_x_max() {
    return swing_x.max();
  }

  protected float get_swing_x_min() {
    return swing_x.min();
  }

  // swing y
  protected float get_swing_y() {
    return swing_y.get();
  }

  protected float get_swing_y_raw() {
    return swing_y.raw();
  }

  protected float get_swing_y_max() {
    return swing_y.max();
  }

  protected float get_swing_y_min() {
    return swing_y.min();
  }

  // swing z
  protected float get_swing_z() {
    return swing_z.get();
  }

  protected float get_swing_z_raw() {
    return swing_z.raw();
  }

  protected float get_swing_z_max() {
    return swing_z.max();
  }

  protected float get_swing_z_min() {
    return swing_z.min();
  }


  // COL3
  // quantity
  protected float get_quantity() {
    return quantity.get();
  }

  protected float get_quantity_raw() {
    return quantity.raw();
  }

  protected float get_quantity_max() {
    return quantity.max();
  }

  protected float get_quantity_min() {
    return quantity.min();
  }
  
  // variety
  protected float get_variety() {
    return variety.get();
  }

  protected float get_variety_raw() {
    return variety.raw();
  }

  protected float get_variety_max() {
    return variety.max();
  }

  protected float get_variety_min() {
    return variety.min();
  }
  
  // life
  protected float get_life() {
    return life.get();
  }

  protected float get_life_raw() {
    return life.raw();
  }

  protected float get_life_max() {
    return life.max();
  }

  protected float get_life_min() {
    return life.min();
  }
  
  // flow
  protected float get_flow() {
    return flow.get();
  }

  protected float get_flow_raw() {
    return flow.raw();
  }

  protected float get_flow_max() {
    return flow.max();
  }

  protected float get_flow_min() {
    return flow.min();
  }
  
  // quality
  protected float get_quality() {
    return quality.get();
  }

  protected float get_quality_raw() {
    return quality.raw();
  }

  protected float get_quality_max() {
    return quality.max();
  }

  protected float get_quality_min() {
    return quality.min();
  }
  
  // area
  protected float get_area() {
    return area.get();
  }

  protected float get_area_raw() {
    return area.raw();
  }

  protected float get_area_max() {
    return area.max();
  }

  protected float get_area_min() {
    return area.min();
  }
  
  // angle
  protected float get_angle() {
    return angle.get();
  }

  protected float get_angle_raw() {
    return angle.raw();
  }

  protected float get_angle_max() {
    return angle.max();
  }

  protected float get_angle_min() {
    return angle.min();
  }
  
  // scope
  protected float get_scope() {
    return scope.get();
  }

  protected float get_scope_raw() {
    return scope.raw();
  }

  protected float get_scope_max() {
    return scope.max();
  }

  protected float get_scope_min() {
    return scope.min();
  }
  
  // scan
  protected float get_scan() {
    return scan.get();
  }

  protected float get_scan_raw() {
    return scan.raw();
  }

  protected float get_scan_max() {
    return scan.max();
  }

  protected float get_scan_min() {
    return scan.min();
  }
  
  // alignment
  protected float get_alignment() {
    return alignment.get();
  }

  protected float get_alignment_raw() {
    return alignment.raw();
  }

  protected float get_alignment_max() {
    return alignment.max();
  }

  protected float get_alignment_min() {
    return alignment.min();
  }
  
  // repulsion
  protected float get_repulsion() {
    return repulsion.get();
  }

  protected float get_repulsion_raw() {
    return repulsion.raw();
  }

  protected float get_repulsion_max() {
    return repulsion.max();
  }

  protected float get_repulsion_min() {
    return repulsion.min();
  }
  
  // attraction
  protected float get_attraction() {
    return attraction.get();
  }

  protected float get_attraction_raw() {
    return attraction.raw();
  }

  protected float get_attraction_max() {
    return attraction.max();
  }

  protected float get_attraction_min() {
    return attraction.min();
  }
  
  // density
  protected float get_density() {
    return density.get();
  }

  protected float get_density_raw() {
    return density.raw();
  }

  protected float get_density_max() {
    return density.max();
  }

  protected float get_density_min() {
    return density.min();
  }
  
  // influence
  protected float get_influence() {
    return influence.get();
  }

  protected float get_influence_raw() {
    return influence.raw();
  }

  protected float get_influence_max() {
    return influence.max();
  }

  protected float get_influence_min() {
    return influence.min();
  }
  
  // calm
  protected float get_calm() {
    return calm.get();
  }

  protected float get_calm_raw() {
    return calm.raw();
  }

  protected float get_calm_max() {
    return calm.max();
  }

  protected float get_calm_min() {
    return calm.min();
  }
  
  // spectrum
  protected float get_spectrum() {
    return spectrum.get();
  }

  protected float get_spectrum_raw() {
    return spectrum.raw();
  }

  protected float get_spectrum_max() {
    return spectrum.max();
  }

  protected float get_spectrum_min() {
    return spectrum.min();
  }


  // COL 4
  // grid
  protected float get_grid() {
    return grid.get();
  }

  protected float get_grid_raw() {
    return grid.raw();
  }

  protected float get_grid_max() {
    return grid.max();
  }

  protected float get_grid_min() {
    return grid.min();
  }
  
  // viscosity
  protected float get_viscosity() {
    return viscosity.get();
  }

  protected float get_viscosity_raw() {
    return viscosity.raw();
  }

  protected float get_viscosity_max() {
    return viscosity.max();
  }

  protected float get_viscosity_min() {
    return viscosity.min();
  }
  
  // diffusion
  protected float get_diffusion() {
    return diffusion.get();
  }

  protected float get_diffusion_raw() {
    return diffusion.raw();
  }

  protected float get_diffusion_max() {
    return diffusion.max();
  }

  protected float get_diffusion_min() {
    return diffusion.min();
  }
  
  // power
  protected float get_power() {
    return power.get();
  }

  protected float get_power_raw() {
    return power.raw();
  }

  protected float get_power_max() {
    return power.max();
  }

  protected float get_power_min() {
    return power.min();
  }

  // mass
  protected float get_mass() {
    return mass.get();
  }

  protected float get_mass_raw() {
    return mass.raw();
  }

  protected float get_mass_max() {
    return mass.max();
  }

  protected float get_mass_min() {
    return mass.min();
  }

  // COORD
  protected vec3 get_coord() {
    return vec3(get_coord_x(),get_coord_y(),get_coord_z());
  }
  
  // coord x
  protected float get_coord_x() {
    return coord_x.get();
  }

  protected float get_coord_x_raw() {
    return coord_x.raw();
  }

  protected float get_coord_x_max() {
    return coord_x.max();
  }

  protected float get_coord_x_min() {
    return coord_x.min();
  }

  // swing y
  protected float get_coord_y() {
    return coord_y.get();
  }

  protected float get_coordg_y_raw() {
    return coord_y.raw();
  }

  protected float get_coord_y_max() {
    return coord_y.max();
  }

  protected float get_coord_y_min() {
    return coord_y.min();
  }

  // swing z
  protected float get_coord_z() {
    return coord_z.get();
  }

  protected float get_coord_z_raw() {
    return coord_z.raw();
  }

  protected float get_coord_z_max() {
    return coord_z.max();
  }

  protected float get_coord_z_min() {
    return coord_z.min();
  }








  /**
  font
  */
  protected String get_font_path() {
    return font_item.get_path();
  }

  protected String get_font_name() {
    return font_item.get_name();
  }

  protected PFont get_font() {
    return font_item.get_font();
  }

  protected String get_font_type() {
    return font_item.get_type();
  }



  /**
  sound
  */
  protected float get_band(int target) {
    if(target >= 0 && target < band[ID_item].length) {
      return band[ID_item][target];
    } else {
      printErrTempo(180,"get_band(): target",target, "is out of the band range, value '0' is return");
      return 0;
    }
  }
  
  /**
  movie
  */
  protected int which_movie() {
    return which_movie[ID_item];
  }

  protected Movie get_movie() {
    if(movie[ID_item] != null) {
      return movie[ID_item];
    } else return null;
  }

  protected PImage get_bitmap() {
    if(bitmap[ID_item] != null) {
      return bitmap[ID_item];
    } else return null;
  }
  
  protected String get_text() {
    if(text_import[ID_item] != null) {
      return text_import[ID_item];
    } else return null;
  }

  protected ROPE_svg get_svg() {
    if(svg_import[ID_item] != null) {
      return svg_import[ID_item];
    } else return null;
  }














  
  /**
  deep method
  */
  private Costume get_costume_private() {
    if(costume == null) {
      costume = new Costume();
    }
    String [] costume_split = new String[1];
    costume_split = split(item_costume,"/");

    String costume_romanesco = "unknow" ;
    if(costume_split[0] != null) {
      costume_romanesco = costume_split[get_costume_id()];
    } 

    if(costume_romanesco.equals("pixel") || costume_romanesco.equals("PIXEL") || costume_romanesco.equals("Pixel")) {
      if(!dimension) {
        costume.set_type(PIXEL_ROPE); 
      } else {
        costume.set_type(PIXEL_ROPE);
      }
    } else if(costume_romanesco.equals("point") || costume_romanesco.equals("POINT") || costume_romanesco.equals("Point")) {
      if(!dimension) {
        costume.set_type(POINT_ROPE); 
      } else {
        costume.set_type(SPHERE_LOW_ROPE);
      }
    } else if(costume_romanesco.equals("line") || costume_romanesco.equals("LINE") || costume_romanesco.equals("Line")) {
      if(!dimension) {
        costume.set_type(LINE_ROPE); 
      } else {
        costume.set_type(LINE_ROPE);
      }
    } else if(costume_romanesco.equals("ellipse") || costume_romanesco.equals("ELLIPSE") || costume_romanesco.equals("Ellipse") || costume_romanesco.equals("disc") || costume_romanesco.equals("DISC") || costume_romanesco.equals("Disc")) {
      if(!dimension) {
        costume.set_type(ELLIPSE_ROPE); 
      } else {
        costume.set_type(SPHERE_MEDIUM_ROPE);
      }
    } else if(costume_romanesco.equals("triangle") || costume_romanesco.equals("TRIANGLE") || costume_romanesco.equals("Triangle")) {
      if(!dimension) {
        costume.set_type(TRIANGLE_ROPE); 
      } else {
        costume.set_type(TETRAHEDRON_ROPE);
      }
    } else if(costume_romanesco.equals("rectangle") || costume_romanesco.equals("RECTANGLE") || costume_romanesco.equals("Rectangle") || costume_romanesco.equals("rect") || costume_romanesco.equals("RECT") || costume_romanesco.equals("Rect")) {
      if(!dimension) {
        costume.set_type(RECT_ROPE); 
      } else {
        costume.set_type(BOX_ROPE);
      }
    } else if(costume_romanesco.equals("pentagon") || costume_romanesco.equals("PENTAGON") || costume_romanesco.equals("Pentagon")) {
      if(!dimension) {
        costume.set_type(PENTAGON_ROPE); 
      } else {
        costume.set_type(PENTAGON_ROPE);
      }
    } else if(costume_romanesco.equals("cross") || costume_romanesco.equals("CROSS") || costume_romanesco.equals("Cross")) {
      if(!dimension) {
        costume.set_type(CROSS_BOX_2_ROPE); 
      } else {
        costume.set_type(CROSS_BOX_3_ROPE);
      }
    } else if(costume_romanesco.equals("star 4") || costume_romanesco.equals("STAR 4") || costume_romanesco.equals("Star 4")) {
      if(!dimension) {
        costume.set_type(STAR_ROPE);
        costume.set_summit(4);
      } else {
        costume.set_type(STAR_3D_ROPE);
        costume.set_summit(4);
      }
    } else if(costume_romanesco.equals("star 5") || costume_romanesco.equals("STAR 5") || costume_romanesco.equals("Star 5")) {
      if(!dimension) {
        costume.set_type(STAR_ROPE);
        costume.set_summit(5);
      } else {
        costume.set_type(STAR_3D_ROPE);
        costume.set_summit(5);
      }
    } else if(costume_romanesco.equals("star 6") || costume_romanesco.equals("STAR 6") || costume_romanesco.equals("Star 6")) {
      if(!dimension) {
        costume.set_type(STAR_ROPE);
        costume.set_summit(6);
      } else {
        costume.set_type(STAR_3D_ROPE);
        costume.set_summit(6);
      }
    } else if(costume_romanesco.equals("star 7") || costume_romanesco.equals("STAR 7") || costume_romanesco.equals("Star 7")) {
      if(!dimension) {
        costume.set_type(STAR_ROPE);
        costume.set_summit(7);
      } else {
        costume.set_type(STAR_3D_ROPE);
        costume.set_summit(7);
      }
    }
    else if(costume_romanesco.equals("star 8") || costume_romanesco.equals("STAR 8") || costume_romanesco.equals("Star 8")) {
      if(!dimension) {
        costume.set_type(STAR_ROPE);
        costume.set_summit(8);
      } else {
        costume.set_type(STAR_3D_ROPE);
        costume.set_summit(8);
      }
    } else if(costume_romanesco.equals("super star 8") || costume_romanesco.equals("SUPER STAR 8") || costume_romanesco.equals("Super Star 8")) {
      if(!dimension) {
        costume.set_type(STAR_ROPE);
        costume.set_summit(8);
        costume.set_ratio(2.,.5,1.,.5);
      } else {
        costume.set_type(STAR_3D_ROPE);
        costume.set_summit(8);
        costume.set_ratio(2.,.5,1.,.5);
      }
    } else if(costume_romanesco.equals("super star 12") || costume_romanesco.equals("SUPER STAR 12") || costume_romanesco.equals("Super Star 12")) {
      if(!dimension) {
        costume.set_type(STAR_ROPE);
        costume.set_summit(12);
        costume.set_ratio(2.,.5,1.,.5,1.,.5);
      } else {
        costume.set_type(STAR_3D_ROPE);
        costume.set_summit(12);
        costume.set_ratio(2.,.5,1.,.5,1.,.5);
      }
    } else if(costume_romanesco.equals("abc") || costume_romanesco.equals("ABC") || costume_romanesco.equals("Abc")) {
      if(!dimension) {
        costume.set_type(TEXT_ROPE); 
      } else {
        costume.set_type(TEXT_ROPE);
      }
    } else if(costume_romanesco.equals("none") || costume_romanesco.equals("NONE") || costume_romanesco.equals("None") ||
              costume_romanesco.equals("nothing") || costume_romanesco.equals("NOTHING") || costume_romanesco.equals("Nothing") || 
              costume_romanesco.equals("null") || costume_romanesco.equals("NULL") || costume_romanesco.equals("Null")) {
      if(!dimension) {
        costume.set_type(NULL); 
      } else {
        costume.set_type(NULL);
      }
    } else {
      costume.set_type(NULL);
    }

    return costume;
  }
}












