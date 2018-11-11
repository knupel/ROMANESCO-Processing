/**
Abstract CLASS ROMANESCO
v 0.0.5
2013-2018
*/



public abstract class Romanesco implements rope.core.RConstants {
  protected String item_name, item_author, item_version, item_pack, romanesco_renderer, item_costume, item_mode, item_slider;
  protected int ID_item, ID_group;
  //object manager return
  Romanesco_manager item_romanesco;

  // slider
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
  // }

  
  public Romanesco() {
    item_name = "Unknown" ;
    item_author = "Anonymous";
    item_version = "Alpha";
    item_pack = "Base" ;
    romanesco_renderer = "classic" ;
    item_costume = "" ; // separate the name by a slash and write the next mode immadialtly after this one.
    item_mode = "" ; // separate the name by a slash and write the next mode immadialtly after this one.
    item_slider = "" ;
    ID_group = 0 ;
    ID_item = 0 ;

    hue_fill_is = false;
    sat_fill_is = false;
  }
  
  //manager return
  void set_item_romanesco(Romanesco_manager item_romanesco) {
    this.item_romanesco = item_romanesco;
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
  }
  

  // Must be declared in the sub-classes
  abstract void setup();

  abstract void draw();


  public void draw_2D() {}


  public void info(Object... obj) {
    String mark = " | ";
    item_info[ID_item] = write_message_sep(mark,obj);
  }


  public void set_id(int id) {
    ID_item = id;
  }

  public void set_group(int group) {
    ID_group = group;
  }


  public int get_id() {
    return ID_item;
  }

  public int get_id_group() {
    return ID_group;
  }

  public String get_name() {
    return item_name;
  }

  public int get_mode() {
    return mode[ID_item];
  }
  
  public int get_costume() {

    String [] costume_split = new String[1];
    costume_split = split(item_costume,"/");

    String costume_romanesco = "unknow" ;
    if(costume_split[0] != null) {
      int target = costume_controller_selection[get_id()];
      costume_romanesco = costume_split[target];
    } 

    if(costume_romanesco.equals("pixel") || costume_romanesco.equals("PIXEL") || costume_romanesco.equals("Pixel")) {
      if(!dimension[get_id()]) {
        costume[get_id()] = PIXEL_ROPE; 
      } else {
        costume[get_id()] = PIXEL_ROPE;
      }
    } else if(costume_romanesco.equals("point") || costume_romanesco.equals("POINT") || costume_romanesco.equals("Point")) {
      if(!dimension[get_id()]) {
        costume[get_id()] = POINT_ROPE; 
      } else {
        costume[get_id()] = SPHERE_LOW_ROPE;
      }
    } else if(costume_romanesco.equals("line") || costume_romanesco.equals("LINE") || costume_romanesco.equals("Line")) {
      if(!dimension[get_id()]) {
        costume[get_id()] = LINE_ROPE; 
      } else {
        costume[get_id()] = LINE_ROPE;
      }
    } else if(costume_romanesco.equals("ellipse") || costume_romanesco.equals("ELLIPSE") || costume_romanesco.equals("Ellipse") || costume_romanesco.equals("disc") || costume_romanesco.equals("DISC") || costume_romanesco.equals("Disc")) {
      if(!dimension[get_id()]) {
        costume[get_id()] = ELLIPSE_ROPE; 
      } else {
        costume[get_id()] = SPHERE_MEDIUM_ROPE;
      }
    } else if(costume_romanesco.equals("triangle") || costume_romanesco.equals("TRIANGLE") || costume_romanesco.equals("Triangle")) {
      if(!dimension[get_id()]) {
        costume[get_id()] = TRIANGLE_ROPE; 
      } else {
        costume[get_id()] = TETRAHEDRON_ROPE;
      }
    } else if(costume_romanesco.equals("rectangle") || costume_romanesco.equals("RECTANGLE") || costume_romanesco.equals("Rectangle") || costume_romanesco.equals("rect") || costume_romanesco.equals("RECT") || costume_romanesco.equals("Rect")) {
      if(!dimension[get_id()]) {
        costume[get_id()] = RECT_ROPE; 
      } else {
        costume[get_id()] = BOX_ROPE;
      }
    } else if(costume_romanesco.equals("pentagon") || costume_romanesco.equals("PENTAGON") || costume_romanesco.equals("Pentagon")) {
      if(!dimension[get_id()]) {
        costume[get_id()] = PENTAGON_ROPE; 
      } else {
        printErrTempo(60,"method select_costume(): No shape match in P3D with Pentagon");
        costume[get_id()] = PENTAGON_ROPE;
      }
    } else if(costume_romanesco.equals("cross") || costume_romanesco.equals("CROSS") || costume_romanesco.equals("Cross")) {
      if(!dimension[get_id()]) {
        costume[get_id()] = CROSS_BOX_2_ROPE; 
      } else {
        costume[get_id()] = CROSS_BOX_3_ROPE;
      }
    } else if(costume_romanesco.equals("star 4") || costume_romanesco.equals("STAR 4") || costume_romanesco.equals("Star 4")) {
      if(!dimension[get_id()]) {
        costume[get_id()] = STAR_4_ROPE; 
      } else {
        costume[get_id()] = STAR_4_ROPE;
      }
    } else if(costume_romanesco.equals("star 5") || costume_romanesco.equals("STAR 5") || costume_romanesco.equals("Star 5")) {
      if(!dimension[get_id()]) {
        costume[get_id()] = STAR_5_ROPE; 
      } else {
        costume[get_id()] = STAR_5_ROPE;
      }
    } else if(costume_romanesco.equals("star 6") || costume_romanesco.equals("STAR 6") || costume_romanesco.equals("Star 6")) {
      if(!dimension[get_id()]) {
        costume[get_id()] = STAR_6_ROPE; 
      } else {
        costume[get_id()] = STAR_6_ROPE;
      }
    } else if(costume_romanesco.equals("star 7") || costume_romanesco.equals("STAR 7") || costume_romanesco.equals("Star 7")) {
      if(!dimension[get_id()]) {
        costume[get_id()] = STAR_7_ROPE; 
      } else {
        costume[get_id()] = STAR_7_ROPE;
      }
    }
    else if(costume_romanesco.equals("star 8") || costume_romanesco.equals("STAR 8") || costume_romanesco.equals("Star 8")) {
      if(!dimension[get_id()]) {
        costume[get_id()] = STAR_8_ROPE; 
      } else {
        costume[get_id()] = STAR_8_ROPE;
      }
    } else if(costume_romanesco.equals("super star 8") || costume_romanesco.equals("SUPER STAR 8") || costume_romanesco.equals("Super Star 8")) {
      if(!dimension[get_id()]) {
        costume[get_id()] = SUPER_STAR_8_ROPE; 
      } else {
        costume[get_id()] = SUPER_STAR_8_ROPE;
      }
    } else if(costume_romanesco.equals("super star 12") || costume_romanesco.equals("SUPER STAR 12") || costume_romanesco.equals("Super Star 12")) {
      if(!dimension[get_id()]) {
        costume[get_id()] = SUPER_STAR_12_ROPE; 
      } else {
        costume[get_id()] = SUPER_STAR_12_ROPE;
      }
    } else if(costume_romanesco.equals("abc") || costume_romanesco.equals("ABC") || costume_romanesco.equals("Abc")) {
      if(!dimension[get_id()]) {
        costume[get_id()] = TEXT_ROPE; 
      } else {
        costume[get_id()] = TEXT_ROPE;
      }
    } else if(costume_romanesco.equals("none") || costume_romanesco.equals("NONE") || costume_romanesco.equals("None") ||
              costume_romanesco.equals("nothing") || costume_romanesco.equals("NOTHING") || costume_romanesco.equals("Nothing") || 
              costume_romanesco.equals("null") || costume_romanesco.equals("NULL") || costume_romanesco.equals("Null")) {
      if(!dimension[get_id()]) {
        costume[get_id()] = NULL; 
      } else {
        costume[get_id()] = NULL;
      }
    } else {
      costume[get_id()] = NULL;
    }

    return costume[get_id()];
  }
  
}












