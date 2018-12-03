/**
Abstract CLASS ROMANESCO
v 0.4.0
2013-2018
*/
import java.util.Date;
import java.sql.Timestamp;



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
  float thickness; 
  float size_x,size_y,size_z;
  float diameter;
  float canvas_x,canvas_y,canvas_z;

  float frequence;
  float speed_x,speed_y,speed_z;
  float spurt_x,spurt_y,spurt_z;
  float dir_x,dir_y,dir_z;
  float jitter_x,jitter_y,jitter_z;
  float swing_x,swing_y,swing_z;

  float quantity,variety;
  float life,flow,quality;

  float area,angle,scope,scan;
  float alignment,repulsion,attraction,density;
  float influence,calm,spectrum;

  float grid;
  float viscosity,diffusion;

  float power;
  float mass;
  float coord_x,coord_y,coord_z;

  // parameter
  boolean show,sound,action,parameter;

  Mode mode;
  Costume costume;


  boolean birth, colour, dimension, horizon, motion, orbit, reverse, special, wire;
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
    item_name = "Unknown" ;
    item_author = "Anonymous";
    item_references = "none";
    item_version = "Alpha";
    item_pack = "Base";
    item_costume = ""; // separate the name by a slash and write the next mode immadialtly after this one.
    item_mode = ""; // separate the name by a slash and write the next mode immadialtly after this one.
    item_slider = "";
    ID_group = 0;
    ID_item = 0;

    hue_fill_is = false;
    sat_fill_is = false;
  }
  
  //manager return
  public void set_item_romanesco() {
    if(!hue_fill_is) item_slider +="," ; else item_slider += (ROM_HUE_FILL +",");
    if(!sat_fill_is) item_slider +="," ; else item_slider +=(ROM_SAT_FILL+",");
    if(!bright_fill_is) item_slider +="," ; else item_slider +=(ROM_BRIGHT_FILL+",");
    if(!alpha_fill_is) item_slider +="," ; else item_slider +=(ROM_ALPHA_FILL+",");
    if(!hue_stroke_is) item_slider +="," ; else item_slider += (ROM_HUE_STROKE +",");
    if(!sat_stroke_is) item_slider +="," ; else item_slider +=(ROM_SAT_STROKE+",");
    if(!bright_stroke_is) item_slider +="," ; else item_slider +=(ROM_BRIGHT_STROKE+",");
    if(!alpha_stroke_is) item_slider +="," ; else item_slider +=(ROM_ALPHA_STROKE+",");
    if(!thickness_is) item_slider +="," ; else item_slider += (ROM_THICKNESS+",");
    if(!size_x_is) item_slider +="," ; else item_slider += (ROM_SIZE_X+",");
    if(!size_y_is) item_slider +="," ; else item_slider += (ROM_SIZE_Y+",");
    if(!size_z_is) item_slider +="," ; else item_slider += (ROM_SIZE_Z+",");
    if(!diameter_is) item_slider +="," ; else item_slider += (ROM_DIAMETER+",");
    if(!canvas_x_is) item_slider +="," ; else item_slider += (ROM_CANVAS_X+",");
    if(!canvas_y_is) item_slider +="," ; else item_slider += (ROM_CANVAS_Y+",");
    if(!canvas_z_is) item_slider +="," ; else item_slider += (ROM_CANVAS_Z+",");

    if(!frequence_is) item_slider +="," ; else item_slider += (ROM_FREQUENCE+",");
    if(!speed_x_is) item_slider +="," ; else item_slider += (ROM_SPEED_X+",");
    if(!speed_y_is) item_slider +="," ; else item_slider += (ROM_SPEED_Y+",");
    if(!speed_z_is) item_slider +="," ; else item_slider += (ROM_SPEED_Z+",");
    if(!spurt_x_is) item_slider +="," ; else item_slider += (ROM_SPURT_X+",");
    if(!spurt_y_is) item_slider +="," ; else item_slider += (ROM_SPURT_Y+",");
    if(!spurt_z_is) item_slider +="," ; else item_slider += (ROM_SPURT_Z+",");
    if(!dir_x_is) item_slider +="," ; else item_slider += (ROM_DIR_X+",");
    if(!dir_y_is) item_slider +="," ; else item_slider += (ROM_DIR_Y+",");
    if(!dir_z_is) item_slider +="," ; else item_slider += (ROM_DIR_Z+",");
    if(!jit_x_is) item_slider +="," ; else item_slider += (ROM_JIT_X+",");
    if(!jit_y_is) item_slider +="," ; else item_slider += (ROM_JIT_Y+",");
    if(!jit_z_is) item_slider +="," ; else item_slider += (ROM_JIT_Z+",");
    if(!swing_x_is) item_slider +="," ; else item_slider += (ROM_SWIWG_X+",");
    if(!swing_y_is) item_slider +="," ; else item_slider += (ROM_SWIWG_Y+",");
    if(!swing_z_is) item_slider +="," ; else item_slider += (ROM_SWIWG_Z+",");

    if(!quantity_is) item_slider +="," ; else item_slider += (ROM_QUANTITY+",");
    if(!variety_is) item_slider +="," ; else item_slider += (ROM_VARIETY+",");
    if(!life_is) item_slider +="," ; else item_slider += (ROM_LIFE+",");
    if(!flow_is) item_slider +="," ; else item_slider += (ROM_FLOW+",");
    if(!quality_is) item_slider +="," ; else item_slider += (ROM_QUALITY+",");
    if(!area_is) item_slider +="," ; else item_slider += (ROM_AREA+",");
    if(!angle_is) item_slider +="," ; else item_slider += (ROM_ANGLE+",");
    if(!scope_is) item_slider +="," ; else item_slider += (ROM_SCOPE+",");
    if(!scan_is) item_slider +="," ; else item_slider += (ROM_SCAN+",");
    if(!align_is) item_slider +="," ; else item_slider += (ROM_ALIGN+",");
    if(!repulsion_is) item_slider +="," ; else item_slider += (ROM_REPULSION+",");
    if(!attraction_is) item_slider +="," ; else item_slider += (ROM_ATTRACTION+",");
    if(!density_is) item_slider +="," ; else item_slider += (ROM_DENSITY+",");
    if(!influence_is) item_slider +="," ; else item_slider += (ROM_INFLUENCE+",");
    if(!calm_is) item_slider +="," ; else item_slider += (ROM_CALM+",");
    if(!spectrum_is) item_slider +="," ; else item_slider += (ROM_SPECTRUM+",");

    if(!grid_is) item_slider +="," ; else item_slider += (ROM_GRID+",");
    if(!viscosity_is) item_slider +="," ; else item_slider += (ROM_VISCOSITY+",");
    if(!diffusion_is) item_slider +="," ; else item_slider += (ROM_DIFFUSION+",");
    if(!power_is) item_slider +="," ; else item_slider += (ROM_POWER+",");
    if(!mass_is) item_slider +="," ; else item_slider += (ROM_MASS+",");
    if(!coord_x_is) item_slider +="," ; else item_slider += (ROM_COORD_X+",");
    if(!coord_y_is) item_slider +="," ; else item_slider += (ROM_COORD_Y+",");
    if(!coord_z_is) item_slider +="," ; else item_slider += (ROM_COORD_Z+",");
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
    set_thickness(1);
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
  protected void set_costume(Costume costume) {
    this.costume = costume;
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

  // set controller slider
  protected void set_fill(int fill) {
    this.fill = fill;
  }

  protected void set_stroke(int stroke) {
    this.stroke = stroke;
  }

  protected void set_thickness(float thickness) {
    this.thickness = thickness;
  }

  protected void set_size(float size) {
    this.size_x = size;
    this.size_y = size;
    this.size_z = size;
  }

  protected void set_size_x(float size_x) {
    this.size_x = size_x;
  }

  protected void set_size_y(float size_y) {
    this.size_y = size_y;
  }

  protected void set_size_z(float size_z) {
    this.size_z = size_z;
  }

  protected void set_diameter(float diameter) {
    this.diameter = diameter;
  }

  protected void set_canvas(float canvas) {
    this.canvas_x = canvas;
    this.canvas_y = canvas;
    this.canvas_z = canvas;
  }

  protected void set_canvas_x(float canvas_x) {
    this.canvas_x = canvas_x;
  }

  protected void set_canvas_y(float canvas_y) {
    this.canvas_y = canvas_y;
  }

  protected void set_canvas_z(float canvas_z) {
    this.canvas_z = canvas_z;
  }

  protected void set_frequence(float frequence) {
    this.frequence = frequence;
  }

  protected void set_speed(float speed) {
    this.speed_x = speed;
    this.speed_y = speed;
    this.speed_z = speed;
  }

  protected void set_speed_x(float speed_x) {
    this.speed_x = speed_x;
  }

  protected void set_speed_y(float speed_y) {
    this.speed_y = speed_y;
  }

  protected void set_speed_z(float speed_z) {
    this.speed_z = speed_z;
  }

  protected void set_spurt(float spurt) {
    this.spurt_x = spurt;
    this.spurt_y = spurt;
    this.spurt_z = spurt;
  }

  protected void set_spurt_x(float spurt_x) {
    this.spurt_x = spurt_x;
  }

  protected void set_spurt_y(float spurt_y) {
    this.spurt_y = spurt_y;
  }

  protected void set_spurt_z(float spurt_z) {
    this.spurt_z = spurt_z;
  }

  protected void set_dir(float dir) {
    this.dir_x = dir;
    this.dir_y = dir;
    this.dir_z = dir;
  }

  protected void set_dir_x(float dir_x) {
    this.dir_x = dir_x;
  }

  protected void set_dir_y(float dir_y) {
    this.dir_y = dir_y;
  }

  protected void set_dir_z(float dir_z) {
    this.dir_z = dir_z;
  }

  protected void set_jitter(float jitter) {
    this.jitter_x = jitter;
    this.jitter_y = jitter;
    this.jitter_z = jitter;
  }

  protected void set_jitter_x(float jitter_x) {
    this.jitter_x = jitter_x;
  }

  protected void set_jitter_y(float jitter_y) {
    this.jitter_y = jitter_y;
  }

  protected void set_jitter_z(float jitter_z) {
    this.jitter_z = jitter_z;
  }

  protected void set_swing(float swing) {
    this.swing_x = swing;
    this.swing_y = swing;
    this.swing_z = swing;
  }

  protected void set_swing_x(float swing_x) {
    this.swing_x = swing_x;
  }

  protected void set_swing_y(float swing_y) {
    this.swing_y = swing_y;
  }

  protected void set_swing_z(float swing_z) {
    this.swing_z = swing_z;
  }

  protected void set_quantity(float quantity) {
    this.quantity = quantity;
  }

  protected void set_variety(float variety) {
    this.variety = variety;
  }

  protected void set_life(float life) {
    this.life = life;
  }

  protected void set_flow(float flow) {
    this.flow = flow;
  }

  protected void set_quality(float quality) {
    this.quality = quality;
  }

  protected void set_area(float area) {
    this.area = area;
  }

  protected void set_angle(float angle) {
    this.angle = angle;
  }


  protected void set_scope(float scope) {
    this.scope = scope;
  }

  protected void set_scan(float scan) {
    this.scan = scan;
  }

  protected void set_alignment(float alignment) {
    this.alignment = alignment;
  }

  protected void set_repulsion(float repulsion) {
    this.repulsion = repulsion;
  }

  protected void set_attraction(float attraction) {
    this.attraction = attraction;
  }

  protected void set_density(float density) {
    this.density = density;
  }

  protected void set_influence(float influence) {
    this.influence = influence;
  }

  protected void set_calm(float calm) {
    this.calm = calm;
  }

  protected void set_spectrum(float spectrum) {
    this.spectrum = spectrum;
  }

  protected void set_grid(float grid) {
    this.grid = grid;
  }

  protected void set_viscosity(float viscosity) {
    this.viscosity = viscosity;
  }

  protected void set_diffusion(float diffusion) {
    this.diffusion = diffusion;
  }

  protected void set_power(float power) {
    this.power = power;
  }

  protected void set_mass(float mass) {
    this.mass = mass;
  }

  protected void set_coord(float coord) {
    this.coord_x = coord;
    this.coord_y = coord;
    this.coord_z = coord;
  }

  protected void set_coord_x(float coord_x) {
    this.coord_x = coord_x;
  }

  protected void set_coord_y(float coord_y) {
    this.coord_y = coord_y;
  }

  protected void set_coord_z(float coord_z) {
    this.coord_z = coord_z;
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

  protected void orbit_is(boolean orbit) {
    this.orbit = orbit;
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

  protected void setting_is(boolean setting) {
    this.setting = setting;
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

  protected void switch_orbit() {
    this.orbit = !this.orbit;
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

  protected int get_id_group() {
    return ID_group;
  }

  protected String get_name() {
    return item_name;
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







  /*
  * is method from controler
  */
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




  /**
  * is method from prescene
  */
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

  protected boolean orbit_is() {
    return orbit;
  }

  protected boolean reverse_is() {
    return reverse;
  }

  protected boolean special_is() {
    return special;
  }

  protected boolean wire_is() {
    return wire;
  }

  protected boolean fill_is() {
    return fill_is;
  }

  protected boolean stroke_is() {
    return stroke_is;
  }

  protected boolean clear_list_is() {
    return clearList;
  }
  
  // what is method ??????
  protected boolean setting_is() {
    return setting; 
  }

  /**
  * get slider method 
  */
  protected int get_fill() {
    return fill;
  }

  protected int get_stroke() {
    return stroke;
  }

  protected float get_thickness() {
    return thickness;
  }
  

  // size
  protected Vec3 get_size() {
    return Vec3(get_size_x(),get_size_y(),get_size_z());
  }

  protected float get_size_x() {
    return size_x;
  }

  protected float get_size_y() {
    return size_y;
  }

  protected float get_size_z() {
    return size_z;
  }

  protected float get_diameter() {
    return diameter;
  }

  // canvas
  protected Vec3 get_canvas() {
    return Vec3(get_canvas_x(),get_canvas_y(),get_canvas_z());
  }

  protected float get_canvas_x() {
    return canvas_x;
  }

  protected float get_canvas_y() {
    return canvas_y;
  }

  protected float get_canvas_z() {
    return canvas_z;
  }


  // COL 2
  protected float get_frequence() {
    return frequence;
  }
  // speed
  protected Vec3 get_speed() {
    return Vec3(get_speed_x(),get_speed_y(),get_speed_z());
  }

  protected float get_speed_x() {
    return speed_x;
  }

  protected float get_speed_y() {
    return speed_y;
  }

  protected float get_speed_z() {
    return speed_z;
  }

  // jitter
  protected Vec3 get_jitter() {
    return Vec3(get_jitter_x(),get_jitter_y(),get_jitter_z());
  }

  protected float get_jitter_x() {
    return jitter_x;
  }

  protected float get_jitter_y() {
    return jitter_y;
  }

  protected float get_jitter_z() {
    return jitter_z;
  }


  // spurt
  protected Vec3 get_spurt() {
    return Vec3(get_spurt_x(),get_spurt_y(),get_spurt_z());
  }

  protected float get_spurt_x() {
    return spurt_x;
  }

  protected float get_spurt_y() {
    return spurt_y;
  }

  protected float get_spurt_z() {
    return spurt_z;
  }

  // swing
  protected Vec3 get_swing() {
    return Vec3(get_swing_x(),get_swing_y(),get_swing_z());
  }

  protected float get_swing_x() {
    return swing_x;
  }

  protected float get_swing_y() {
    return swing_y;
  }

  protected float get_swing_z() {
    return swing_z;
  }


  // dir
  protected Vec3 get_dir() {
    return Vec3(get_dir_x(),get_dir_y(),get_dir_z());
  }

  protected float get_dir_x() {
    return dir_x;
  }

  protected float get_dir_y() {
    return dir_y;
  }

  protected float get_dir_z() {
    return dir_z;
  }


  // col 3
  protected float get_quantity() {
    return quantity;
  }

  protected float get_variety() {
    return variety;
  }

  protected float get_life() {
    return life;
  }

  protected float get_flow() {
    return flow;
  }

  protected float get_quality() {
    return quality;
  }

  protected float get_area() {
    return area;
  }

  protected float get_angle() {
    return angle;
  }

  protected float get_scope() {
    return scope;
  }

  protected float get_scan() {
    return scan;
  }

  protected float get_alignment() {
    return alignment;
  }

  protected float get_repulsion() {
    return repulsion;
  }

  protected float get_attraction() {
    return attraction;
  }

  protected float get_density() {
    return density;
  }

  protected float get_influence() {
    return influence;
  }

  protected float get_calm() {
    return calm;
  }

  protected float get_spectrum() {
    return spectrum;
  }


  // col 4
  // pos
  protected float get_grid() {
    return grid;
  }

  protected float get_viscosity() {
    return viscosity;
  }

  protected float get_diffusion() {
    return diffusion;
  }

  protected float get_power() {
    return power;
  }

  protected float get_mass() {
    return mass;
  }


  protected Vec3 get_coord() {
    return Vec3(get_coord_x(),get_coord_y(),get_coord_z());
  }

  protected float get_coord_x() {
    return coord_x;
  }

  protected float get_coord_y() {
    return coord_y;
  }

  protected float get_coord_z() {
    return coord_z;
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
      int target = costume_controller_selection[get_id()];
      costume_romanesco = costume_split[target];
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












