/**
* CLASS PIX 
* v 0.10.4
* 2016-2018
* Processing 3.5.3
* Rope library 0.8.1.26
* @author @stanlepunk
* @see https://github.com/StanLepunK/Pixel
*/
static final String RANDOM = "RANDOM";
@Deprecated
static final String RANDOM_ZERO = "RANDOM ZERO";
@Deprecated
static final String RANDOM_RANGE = "RANDOM RANGE";
@Deprecated
static final String RANDOM_ROOT = "ROOT_RANDOM";
@Deprecated
static final String RANDOM_QUARTER ="QUARTER_RANDOM";
@Deprecated
static final String RANDOM_2 = "2_RANDOM";
@Deprecated
static final String RANDOM_3 = "3_RANDOM";
@Deprecated
static final String RANDOM_4 = "4_RANDOM";
@Deprecated
static final String RANDOM_X_A = "SPECIAL_A_RANDOM";
@Deprecated
static final String RANDOM_X_B = "SPECIAL_B_RANDOM";

abstract class Pix implements rope.core.R_Constants {
  PApplet p5;

  Pix(PApplet p5) {
    this.p5 = p5;
  }
  // P3D mode
  vec3 pos, new_pos;
  vec3 size;
  
  // in cartesian mode
  vec3 dir = null ;

  vec3 grid_position ;
  int ID, rank ;
  Costume costume; // 0 is for point
  float ratio_costume_size = Float.MAX_VALUE;
  float costume_angle = 0 ;
  vec4 colour, new_colour  ;
  
  // use for the motion
  float field = 1.0 ;


  void init_mother_arg() {
    pos = vec3(width/2, height/2,0) ;
    if(new_pos == null) {
      new_pos = pos.copy();
    } else {
      new_pos.set(pos);
    }
    if(size == null) {
      size = vec3(1) ;
    } else {
      size.set(1);
    }
    if(grid_position == null) {
      grid_position = pos.copy();
    } else {
      grid_position.set(pos);
    }
    // give a WHITE color to the pixel
    if(colour == null) {
      if(g.colorMode == 3 ) {
        colour = vec4(0, 0, g.colorModeZ, g.colorModeA) ; 
      } else {
        colour = vec4(g.colorModeX, g.colorModeY, g.colorModeZ, g.colorModeA) ;
      }
    } else {
      if(g.colorMode == 3 ) {
        colour.set(0, 0, g.colorModeZ, g.colorModeA) ; 
      } else {
        colour.set(g.colorModeX, g.colorModeY, g.colorModeZ, g.colorModeA) ;
      }
    }
   
    if(new_colour == null) {
      new_colour = colour.copy() ;
    } else {
      new_colour.set(colour) ;
    }

    int ID = 0 ;
    int rank = -1 ;
  }
  
  
  // RETURN color in vec4
  // test the color mode to return the good data for each component
  vec4 int_color_to_vec4_color(int c) {
    vec4 color_temp = vec4() ;
    if(g.colorMode == 3 ) color_temp = vec4(hue(c),saturation(c),brightness(c),alpha(c)) ;
    else color_temp = vec4(red(c),green(c),blue(c),alpha(c)) ;
    return vec4(color_temp) ;
  }






  /** 
  SETTING
  */
  // ID
  public void set_ID(int ID) {  
    this.ID = ID ; 
  }

  public void costume_angle(float costume_angle) {
    if(costume.get_type() == POINT_ROPE) {
      printErrTempo(180, "class Pix method costume_angle() cannot be used with costume_ID POINT_ROPE");
    }
    this.costume_angle = costume_angle ;
  }


  // set costume
  public void costume(int type) {
    if(costume == null) {
      costume = new Costume(p5,type);
    } else {
      this.costume.set_type(type);
    }
  }

  public void costume(Costume costume) {
    this.costume = costume;
  }

  public void costume_ratio_size(float ratio_costume_size) {
    this.ratio_costume_size = ratio_costume_size;
  }
  



  // size
  public void size(float x) {
    size(x,x,1) ;
  }
  public void size(float x, float y) {
    size(x,y,1) ;
  }

  public void size(vec size) {
    if(size.z == 0) {
      size(size.x, size.y, 1);
    } else {
      size(size.x,size.y,size.z);
    }
  }

  public void size(ivec size) {
    if(size.z == 0) {
      size(size.x, size.y, 1);
    } else {
      size(size.x,size.y,size.z);
    }
  }

  public void size(float x, float y, float z) {
    if(size == null) {
      size = vec3(x,y,z) ;
    } else {
      size.set(x,y,z);
    }
  }

 
  // normal direction
  @Deprecated
  public void direction(vec3 d) {
    dir(d.x,d.y,d.z);
  }
  @Deprecated
  public void direction(float x, float y, float z) {
    dir(x,y,z);
  }
  
  @Deprecated
  public void direction_x(float x) {
    dir.x = x ;
  }
  
  @Deprecated
  public void direction_y(float y) {
    dir.y = y ;
  }

  @Deprecated
  public void direction_z(float z) {
    dir.z = z ;
  }
  

  public void dir_x(float x) {
    if(this.dir != null) {
      dir.x = x ;
    } else {
      this.dir = vec3(x,0,0);
    }
  }
  
  public void dir_y(float y) {
    if(this.dir != null) {
      dir.y = y ;
    } else {
      this.dir = vec3(0,y,0);
    }
  }

  public void dir_z(float z) {
    if(this.dir != null) {
      dir.z = z;
    } else {
      this.dir = vec3(0,0,z);
    }
  }

  public void dir(vec d) {
    if(d != null) {
      dir(d.x,d.y,d.z);
    } else {
      printErr("class Pix method dir() cannot set vector because the arg vector pass is null");
    }

    
  }

  public void dir(float x, float y, float z) {
    if(this.dir == null) {
      this.dir = vec3(x,y,z);
    } else {
      this.dir.set(x,y,z);
    }
  }



  // position
  @Deprecated
  public void position(vec pos) {
    this.pos.set(pos);
  }
  
  @Deprecated
  public void position(int x, int y){
    this.pos.set(x,y,0);
  }
  
  @Deprecated
  public void position(int x, int y, int z){
    this.pos.set(x,y,z);
  }
  
  public void pos(ivec pos) {
    if(pos != null) {
      pos(pos.x,pos.y,pos.z);
    } else {
      printErrTempo(60,"class Pix method pos() cannot set vector because the vector arg pass is null");
    }
  }

  public void pos(vec pos) {
    if(pos != null) {
      pos(pos.x,pos.y,pos.z);
    } else {
      printErrTempo(60,"class Pix method pos() cannot set vector because the vector arg pass is null");
    }
  }

  public void pos(float x, float y){
    pos(x,y,0);
  }
  
  public void pos(float x, float y, float z){
    this.pos.set(x,y,z);
  }















  /**
  ASPECT
  v 0.2.0
  */
  /**
  improve methode to check if the stroke must be Stroke or noStroke()
  */
  public void aspect() {
    float thickness = 1 ;
    if(costume == null) costume = new Costume(p5);
    costume.aspect(colour,colour,thickness);
  }

  public void aspect(boolean new_colour_choice) {
    float thickness = 1 ;
    vec4 color_choice = vec4();
    if(new_colour_choice) {
      color_choice.set(new_colour); 
    } else {
      color_choice.set(colour);
    }
    if(costume == null) costume = new Costume(p5);
    costume.aspect(color_choice,color_choice,thickness) ;
  }

  public void aspect(boolean new_colour_choice, float thickness) {
    vec4 color_choice = vec4() ;
    if(new_colour_choice) {
      color_choice.set(new_colour) ; 
    } else {
      color_choice.set(colour);
    }
    if(costume == null) costume = new Costume(p5);
    costume.aspect(color_choice,color_choice,thickness);
  }

  public void aspect(float thickness) {
    if(costume == null) costume = new Costume(p5);
    costume.aspect(colour,colour,thickness);
  }

  public void aspect(int c) {
    float thickness = 1 ;
    vec4 color_pix = int_color_to_vec4_color(c).copy();
    if(costume == null) costume = new Costume(p5);
    costume.aspect(color_pix, color_pix, thickness);
  }

  public void aspect(vec4 color_pix) {
    float thickness = 1 ;
    if(costume == null) costume = new Costume(p5);
    costume.aspect(color_pix, color_pix, thickness) ;
  }

  public void aspect(vec4 color_pix, float thickness) {
    if(costume == null) costume = new Costume(p5);
    costume.aspect(color_pix, color_pix, thickness) ;
  }
  
  public void aspect(vec4 color_fill, vec4 color_stroke, float thickness) {
    if(costume == null) costume = new Costume(p5);
    costume.aspect(color_fill,color_stroke,thickness);
  }
  




  //with effect
  /**
  Methode must be refactoring, very weird
  */
  /*
  void aspect(int diam, PVector effectColor) {
    strokeWeight(diam) ;
    stroke(new_colour.r, effectColor.x *new_colour.g, effectColor.y *new_colour.b, effectColor.z *new_colour.a) ;
  }
  */  
  
  
  
  
  /**
  CHANGE COLOR
  */
  //direct change HSB
  void set_hue(int new_hue, int target_color, boolean use_new_colour) {
    set_hue(new_hue, target_color, target_color +1, use_new_colour) ;
  }
  void set_saturation(int new_sat, int target_color, boolean use_new_colour) {
    set_saturation(new_sat, target_color, target_color +1, use_new_colour) ;
  }
  void set_brightness(int new_bright, int target_color, boolean use_new_colour) {
    set_brightness(new_bright, target_color, target_color +1, use_new_colour) ;
  }
  //direct change RGB
  void set_red(int new_red, int target_color, boolean use_new_colour) {
    set_red(new_red, target_color, target_color +1, use_new_colour) ;
  }
  void set_green(int new_green, int target_color, boolean use_new_colour) {
    set_green(new_green, target_color, target_color +1, use_new_colour) ;
  }
  void set_blue(int new_blue, int target_color, boolean use_new_colour) {
    set_blue(new_blue, target_color, target_color +1, use_new_colour) ;
  }
  //direct change ALPHA
  void set_alpha(int new_alpha, int target_color, boolean use_new_colour) {
    set_alpha(new_alpha, target_color, target_color +1, use_new_colour) ;
  }
  
  // change with range
  // HSB change
  void set_hue(int new_hue, int start, int end, boolean use_new_colour) {
    float hue_temp ; ;
    if(!use_new_colour) hue_temp = set_color_component_from_specific_component("hue", colour.hue(), new_hue, start, end) ; 
    else hue_temp = set_color_component_from_specific_component("hue", new_colour.hue(), new_hue, start, end) ;
    new_colour = vec4(hue_temp, new_colour.y, new_colour.z, new_colour.w)  ;
  }
  void set_saturation(int new_saturation, int start, int end, boolean use_new_colour) {
    float saturation_temp ;
    if(!use_new_colour) saturation_temp = set_color_component_from_specific_component("saturation", colour.sat(), new_saturation, start, end) ;
    else saturation_temp = set_color_component_from_specific_component("saturation", new_colour.sat(), new_saturation, start, end) ;
    new_colour = vec4(new_colour.x, saturation_temp, new_colour.z, new_colour.w)  ;
  }
  void set_brightness(int new_brightness, int start, int end, boolean use_new_colour) {
    float brightness_temp ;
    if(!use_new_colour) brightness_temp = set_color_component_from_specific_component("brightness", colour.bri(), new_brightness, start, end) ;
    else brightness_temp = set_color_component_from_specific_component("brightness", new_colour.bri(), new_brightness, start, end) ;
    new_colour = vec4(new_colour.x, new_colour.y, brightness_temp, new_colour.w)  ;
  }
  // RGB change
  void set_red(int new_red, int start, int end, boolean use_new_colour) {
    float red_temp ;
    if(!use_new_colour) red_temp = set_color_component_from_specific_component("red", colour.red(), new_red, start, end) ;
    else red_temp = set_color_component_from_specific_component("red", new_colour.red(), new_red, start, end) ;
    new_colour = vec4(red_temp, new_colour.y, new_colour.z, new_colour.w)  ;
  }
  void set_green(int new_green, int start, int end, boolean use_new_colour) {
    float green_temp ;
    if(!use_new_colour) green_temp = set_color_component_from_specific_component("green", colour.gre(), new_green, start, end) ;
    else green_temp = set_color_component_from_specific_component("green", new_colour.gre(), new_green, start, end) ;
    new_colour = vec4(new_colour.x, green_temp, new_colour.z, new_colour.w)  ;
  }
  void set_blue(int new_blue, int start, int end, boolean use_new_colour) {
    float blue_temp ;
    if(!use_new_colour) blue_temp = set_color_component_from_specific_component("blue", colour.blu(), new_blue, start, end) ;
    else blue_temp = set_color_component_from_specific_component("blue", new_colour.blu(), new_blue, start, end) ;
    new_colour = vec4(new_colour.x, new_colour.y, blue_temp, new_colour.w)  ;
  }

  // ALPHA change
  void set_alpha(int new_alpha, int start, int end, boolean use_new_colour) {
    float alpha_temp ;
    if(!use_new_colour) alpha_temp = set_color_component_from_specific_component("alpha", colour.alp(), new_alpha, start, end) ;
    else alpha_temp = set_color_component_from_specific_component("alpha", new_colour.alp(), new_alpha, start, end) ;
    new_colour = vec4(new_colour.x, new_colour.y, new_colour.z, alpha_temp)  ;
  }



  // INTERNAL method to change color
  float set_color_component_from_specific_component (String which_component, float original_component, int new_component, int start_range, int end_range) {
    if (start_range < end_range ) {
      if(original_component >= start_range && original_component <= end_range) original_component = new_component ; 
    } else if (start_range > end_range) {
      if( (original_component >= start_range && original_component <= roof(which_component)) || original_component <= end_range) { 
        original_component = new_component ;
      }
    }        
    return original_component ;
  }
  
  //
  float roof(String which_component) {
    float roof = 1 ;
    switch(which_component) {
      case "HUE" : roof = g.colorModeX ; break ; 
      case "SATURATION" : roof = g.colorModeY ; break ; 
      case "BRIGHTNESS" : roof = g.colorModeZ ; break ; 
      case "RED" : roof = g.colorModeX ; break ; 
      case "GREEN" : roof = g.colorModeY ; break ; 
      case "BLUE" :  roof = g.colorModeZ ; break ;
      case "ALPHA" :  roof = g.colorModeA ; break ; 

      case "hue" :  roof = g.colorModeX ; break ; 
      case "saturation" :  roof = g.colorModeY ; break ; 
      case "brightness" :  roof = g.colorModeZ ; break ;  
      case "red" :  roof = g.colorModeX ; break ; 
      case "green" :  roof = g.colorModeY ; break ; 
      case "blue" :  roof = g.colorModeZ ; break ;
      case "alpha" :  roof = g.colorModeA ; break ; 

      case "Hue" :  roof = g.colorModeX ; break ;  
      case "Saturation" :  roof = g.colorModeY ; break ;  
      case "Brightness" :  roof = g.colorModeZ ; break ; 
      case "Red" :  roof = g.colorModeX ; break ; 
      case "Green" :  roof = g.colorModeY ; break ; 
      case "Blue" :  roof = g.colorModeZ ; break ; 
      case "Alpha" :  roof = g.colorModeA ; break ;
    }
    return roof ;
  }
}

















/**
CLOUD
v 0.3.4
*/
class Cloud extends Pix {
  int num ;
  int time_count = Integer.MIN_VALUE;
  float tempo_ref = .001 ;
  float tempo = .001 ;
  String behavior = "RADIUS";
  vec3 [] coord;
  int type = r.CARTESIAN ;
  int distribution;
  String renderer_dimension;
  float radius = 1;
  vec3 orientation;

  float angle_growth;
  float dist_growth ;

  boolean polar_is;
  float dist;
  int spiral_rounds;

  vec2 range;


  public Cloud(PApplet p5,int num, String renderer_dimension) {
    super(p5);
    init_mother_arg();
    this.num = num ;
    coord = new vec3[num];
    choice_renderer_dimension(renderer_dimension);
  }

  protected void init() {
    if(renderer_dimension == P2D) {
      cartesian_pos_2D(dist) ; 
    } else {
      if(polar_is) {
        polar_pos_3D(); 
      } else {
        cartesian_pos_3D(); 
      }
    }
  }

  /**
  SET
  */
  public void set_distribution(int distribution) {
    this.distribution = distribution;
  }
  

  
  float angle_step ;
  protected void set_angle_step(float angle_step) {
    if(distribution == ORDER && !polar_is) {
      this.angle_step = angle_step;
    } else {
      printErrTempo(180, "class Cloud, method angle_step() must be used in Cartesian rendering and with ORDER distribution");
    }
  }







  protected void set_growth(float angle_growth) {
    if(this.type == r.CARTESIAN && this.distribution == r.ORDER && this.renderer_dimension.equals(P2D)) {
      this.angle_growth = angle_growth ;
    } else {
      printErrTempo(180, "class CLOUD method growth() work only int type == r.CARTESIAN & int distribution = r.ORDER & String renderer_dimension P2D");
    }
  }


  protected void cartesian_pos_2D(float dist) {
    float angle = TAU / num ;
    if(angle_step != 0) {
      angle = angle_step / num ;
    }

    if(angle_growth != 0) {
      dist_growth += angle_growth;
      angle += dist_growth;
    }

    float tetha ;
    for(int i = 0 ; i < num ; i++ ) {
      if(distribution == r.ORDER) {
        tetha = dist +(angle *i);
        coord[i] = vec3(cos(tetha),sin(tetha), 0 ) ; 
      } else {
        tetha = dist + random(-PI, PI) ;
        coord[i] = vec3(cos(tetha),sin(tetha), 0 ) ;
      }
    }
  }

  protected void cartesian_pos_3D() {
    if(distribution == ORDER) {
      // step and root maybe must be define somewhere ????
      float step = PI * (3 - sqrt(5.)) ; 
      float root = PI ;
      if(angle_step != 0) {
        step = angle_step * (3 - sqrt(5.)) ;
        root = angle_step;
      }
      coord = list_cartesian_fibonacci_sphere(num, step, root);
    } else {
      for(int i = 0 ; i < coord.length ; i++ ) {
        float tetha  = random(-PI, PI) ;
        float phi  = random(-TAU, TAU) ;
        coord[i] = vec3(cos(tetha) *cos(phi),
                        cos(tetha) *sin(phi), 
                        sin(tetha) ) ; 
      }
    }
  }


  protected void polar_pos_3D() {
    float step = TAU ;
    if(distribution == ORDER) {
      for (int i = 0; i < coord.length ; i++) {      
        coord[i] = vec3() ;
        coord[i].x = distribution_polar_fibonacci_sphere(i, num, step).x ;
        coord[i].y = distribution_polar_fibonacci_sphere(i, num, step).y ;
        coord[i].z = 0  ;
      }
    } else {
      for (int i = 0; i < coord.length ; i++) {
        int which = floor(random(num)) ;
        coord[i] = vec3() ;
        coord[i].x = distribution_polar_fibonacci_sphere(which, num, step).x ;
        coord[i].y = distribution_polar_fibonacci_sphere(which, num, step).y ;
        coord[i].z = 0  ;
      }
    }
  }






  
  protected void rotation(float rotation, boolean static_rot) {
    if(!polar_is && this.renderer_dimension == P2D) {
      if(static_rot) {
        dist = rotation ; 
      } else {
        dist += rotation;
      }
    } else {
      printErrTempo(180, "Class Pix method rotation() is available only in P2D rendering and for sub Class Cloud_2D, for Cloud_3D use rotation_x(), rotation_y() or rotation_z()");
    }
  }








  protected void choice_renderer_dimension(String dimension) {
    if(dimension == P3D) {
      this.renderer_dimension = P3D ;
    } else {
      this.renderer_dimension = P2D ;
    }
  }


  protected void give_points_to_costume_2D() {
    for(int i  = 0 ; i < coord.length ;i++) {
      if(ratio_costume_size != Float.MAX_VALUE) {
        set_ratio_costume_size(ratio_costume_size);
      }
      costume.draw(coord[i],size,vec3(0,0,costume_angle));
    }
  }

  public void set_radius(float radius) {
    this.radius = radius;
  }

  public void set_tempo(int n) {
    this.tempo = tempo_ref *n ;
  }

  public void set_time_count(int count) {
    time_count = count;
  }

  public vec3 [] list() {
    return coord;   
  }



  public void set_behavior(String behavior) {
    this.behavior = behavior ;
  }
  
  public void spiral(int spiral_rounds) {
    this.spiral_rounds = spiral_rounds;
    if(type != r.CARTESIAN) {
      printErrTempo(180, "class Cloud method spiral() is available only for type r.CARTESIAN, not for type r.POLAR");
    }
  }


  /**
  void range();
  Use with the bahavior, it's ratio mult for the radius
  */
  public void range(vec2 range) {
    range(range.x,range.y);
  }
  public void range(float min, float max) {
    if(range == null) {
      range = vec2(min, max);
    } else {
      range.set(min,max);
    }
  }

  // distribution surface polar
  protected void distribution_surface_polar() {
    if(behavior != "RADIUS") {
      radius = abs(distribution_behavior(range,radius)) ;
    }
  }

 // distribution surface cartesian
 protected void distribution_surface_cartesian() {
    float radius_temp = radius;
    
    if(spiral_rounds > 0) {
      int round = 0 ;
      if(range == null) {
        range = vec2(0,1);
      }
      float height_step = ((range.y -range.x) /coord.length) /spiral_rounds;
      float floor = (range.y -range.x) / spiral_rounds;
      for (int i = 0 ; i < coord.length ; i++) {       
        float range_in = range.x + (height_step *i) + (floor *round) ;
        
        if(behavior != "RADIUS") {
          vec2 temp_range = range.copy();
          temp_range.set(range_in,range.y);
          radius_temp = distribution_behavior(temp_range,radius);
        } else {
          radius_temp = radius;
          radius_temp *= range_in ;
        }
        coord[i].mult(radius_temp) ;
        coord[i].add(pos) ;
        round ++ ;
        if(round >= spiral_rounds) round = 0 ;
      }   
    } else {
      for (int i = 0 ; i < coord.length ; i++) {
        if(behavior != "RADIUS") {
          radius_temp = distribution_behavior(range,radius);
        }
        coord[i].mult(radius_temp) ;
        coord[i].add(pos) ;
      }
    }
  }
  
  /**
  distribution behavior
  */
  // internal method
  private float distribution_behavior(vec2 range, float radius) {
    float normal_distribution = 1 ;
    
    // rules
    float root_1 = 0 ;
    float root_2 = 0 ;
    float root_3 = 0 ;
    float root_4 = 0 ;
     if(behavior.contains(RANDOM)) {
      root_1 = random(1) ;
      if(behavior.contains("2") || behavior.contains("3") || behavior.contains("4")|| behavior.contains("SPECIAL")) {
        root_2 = random(1) ;
        root_3 = random(1) ;
        root_4 = random(1) ;
      }
    }

    float t = 0 ;
    if(behavior.contains(SIN) || behavior.contains(COS)) {
      if(time_count == Integer.MIN_VALUE) {
        t = frameCount *tempo; 
      } else t = time_count *tempo;   
    }

    float factor_1_2 = 1.2;
    float factor_0_5 = .5;
    float factor_12_0 = 12.;
    float factor_10_0 = 10.;
    
    // distribution
    if(behavior == RANDOM) normal_distribution = root_1;
    else if(behavior == RANDOM_ROOT) normal_distribution = sqrt(root_1);
    else if(behavior == RANDOM_QUARTER) normal_distribution = 1 -(.25 *root_1);
    
    else if(behavior == RANDOM_2) normal_distribution = root_1 *root_2;

    else if(behavior == RANDOM_3) normal_distribution = root_1 *root_2 *root_3;

    else if(behavior == RANDOM_4) normal_distribution = root_1 *root_2 *root_3 *root_4;
    else if(behavior == RANDOM_X_A) normal_distribution = .25 *(root_1 +root_2 +root_3 +root_4);
    else if(behavior == RANDOM_X_B) {
      float temp = root_1 -root_2 +root_3 -root_4;
      if(temp < 0) temp += 4 ;
      normal_distribution = .25 *temp;
    }

    else if(behavior == SIN) normal_distribution = sin(t);
    else if(behavior == COS) normal_distribution = cos(t);
    else if(behavior == "SIN_TAN") normal_distribution = sin(tan(t)*factor_0_5);
    else if(behavior == "SIN_TAN_COS") normal_distribution = sin(tan(cos(t) *factor_1_2));
    else if(behavior == "SIN_POW_SIN") normal_distribution = sin(pow(8.,sin(t)));
    else if(behavior == "POW_SIN_PI") normal_distribution = pow(sin((t) *PI), factor_12_0);
    else if(behavior == "SIN_TAN_POW_SIN") normal_distribution = sin(tan(t) *pow(sin(t),factor_10_0));

    // result
    if(range != null) {
      //return radius *(map(normal_distribution,-1,1,range.x,range.y)); // classic

      float max = map(normal_distribution, -1, 1,-range.y,range.y);
      return radius *(map(max,-1,1,range.x,1));

      // return radius *(map(normal_distribution,-range.x,range.x,range.x,range.y)); // interesting
    } else  {
      return radius *normal_distribution;
    }
  }

  /**
  GET
  */
  public float get_growth() {
    return dist_growth;
  }


  public void growth_size(float dist) {
    dist_growth = dist ;
  }

  public float get_rotation() {
    return dist ;
  }

  public int length() {
    return num;
  }
}















/**
CLOUD 2D
*/
class Cloud_2D extends Cloud {
 
  public Cloud_2D(PApplet p5,int num) {
    super(p5,num,P3D);
    // choice_renderer_dimension(renderer_dimension);
    this.distribution = ORDER;
    orientation = vec3(0,PI/2,0); 
    init() ;
  }

  public Cloud_2D(PApplet p5,int num, int distribution) {
    super(p5,num,P2D);
    this.distribution = distribution ;
    init();
  }

  public Cloud_2D(PApplet p5,int num, int distribution, float angle_step) {
    super(p5,num,P2D);
    this.distribution = distribution ;
    set_angle_step(angle_step);
    init();
  }


  
  public void update() {
    cartesian_pos_2D(dist);
    distribution_surface_cartesian();
  }
  


  public void show() {
    give_points_to_costume_2D();
  }
}











/**
CLOUD 3D
*/
class Cloud_3D extends Cloud {

  boolean rotation_x, rotation_y, rotation_z;
  float dist_x, dist_y, dist_z;

  boolean rotation_fx_x, rotation_fx_y, rotation_fx_z;
  float dist_fx_x, dist_fx_y, dist_fx_z;
 
  public Cloud_3D(PApplet p5, int num) {
    super(p5,num,P3D);
    // choice_renderer_dimension(renderer_dimension);
    this.distribution = ORDER;
    this.orientation = vec3(0,PI/2,0); 
    init() ;
  }

  /*
  Use this constructor if you want build a cartesian sphere with a real coord in the 3D space, you must ask a "POINT" costume
  */

  public Cloud_3D(PApplet p5, int num, String renderer_dimension) {
    super(p5, num, renderer_dimension);
    this.distribution = ORDER;
    this.orientation = vec3(0,PI/2,0); 
    init();
  }


  public Cloud_3D(PApplet p5, int num, String renderer_dimension, int distribution) {
    super(p5, num, renderer_dimension);
    this.distribution = distribution ;
    this.orientation = vec3(0,PI/2,0); 
    init();
  }

  public Cloud_3D(PApplet p5, int num, String renderer_dimension, int distribution, int type) {
    super(p5,num, renderer_dimension);
    this.type = type ;
    if(renderer_dimension == P2D && type == r.POLAR) {
      printErr("class Cloud_3D cannot work good with 2D String renderer_dimension and type int r.POLAR");
    }

    this.distribution = distribution ;
    this.orientation = vec3(0,PI/2,0);
    if(this.type == r.POLAR) {
      polar(true);
    } else {
      polar(false);
    }
    init() ;
  }

  public Cloud_3D(PApplet p5, int num, String renderer_dimension, float step_angle) {
    super(p5,num, renderer_dimension);
    polar(false);
    this.distribution = r.ORDER ;
    this.orientation = vec3(0,PI/2,0);
    set_angle_step(step_angle);
    /*
    if(type == r.POLAR) {
      polar(true);
    } else {
      polar(false);
    }
    */
    init() ;
  }



  // change orientation
  public void orientation(vec3 orientation) {
    orientation(orientation.x, orientation.y, orientation.z);
  }

  public void orientation_x(float orientation_x) {
    orientation(orientation.x, 0,0);
  }

  public void orientation_y(float orientation_y) {
    orientation(0, orientation.y,0);
  }

  public void orientation_z(float orientation_z) {
    orientation(0,0,orientation.z);
  }

  public void orientation(float x, float y, float z) {
     if(!polar_is) {
      printErrTempo(180, "void orientation() class Cloud work only with type r.POLAR");
    }
    this.orientation = vec3(x,y,z) ;
  }


  // rotation
  public void rotation_x(float rot, boolean static_rot) {
    if(!polar_is) {
      printErrTempo(180, "class Cloud_3D method rotation_x() is not available for cartesian_2D distribution, only in polar distribution");
    } else {
      rotation_x = true ;
      if(static_rot) dist_x = rot ; else dist_x += rot ;
    }
  }

  public void rotation_y(float rot, boolean static_rot) {
    if(!polar_is) {
      printErrTempo(180, "class Cloud_3D method rotation_y() is not available for cartesian_2D distribution, only in polar distribution");
    } else {
      rotation_y = true ;
      if(static_rot) dist_y = rot ; else dist_y += rot ;
    }
  }

  public void rotation_z(float rot, boolean static_rot) {
    if(!polar_is) {
      printErrTempo(180, "class Cloud_3D method rotation_z() is not available for cartesian_2D distribution, only in polar distribution");
    } else {
      rotation_z = true ;
      if(static_rot) dist_z = rot ; else dist_z += rot ;
    }
  }

  // rotation FX
  public void rotation_fx_x(float rot, boolean static_rot) {
    if(!polar_is) {
      printErrTempo(180, "class Cloud_3D method rotation_fx_x() is not available for cartesian_2D distribution, only in polar distribution");
    } else {
      rotation_fx_x = true ;
      if(static_rot) dist_fx_x = rot ; else dist_fx_x += rot ;
    }
  }
  


  public void rotation_fx_y(float rot, boolean static_rot) {
    if(!polar_is) {
      printErrTempo(180, "class Cloud_3D method rotation_fx_y() is not available for cartesian_2D distribution, only in polar distribution");
    } else {
      rotation_fx_y = true ;
      if(static_rot) dist_fx_y = rot ; else dist_fx_y += rot ;
    }
  }

  public void rotation_fx_z(float rot, boolean static_rot) {
    if(!polar_is) {
      printErrTempo(180, "class Cloud_3D method rotation_fx_z() is not available for cartesian_2D distribution, only in polar distribution");
    } else {
      rotation_fx_z = true ;
      if(static_rot) dist_fx_z = rot ; else dist_fx_z += rot ;
    }
  }


  public void ring(float rot, boolean static_rot) {
    rotation_fx_y(rot, static_rot);
  }

  public void helmet(float rot, boolean static_rot) {
    rotation_fx_z(rot, static_rot);
  }





  /**
  * distribution_surface
  */

  public void polar(boolean polar_is) {
    this.polar_is = polar_is;
  }

  public void update() {
    if(polar_is) {
      distribution_surface_polar() ; 
    } else {
      cartesian_pos_3D();
      distribution_surface_cartesian() ;
    }
  }
  


  /**
  * Show
  */
  public void show() {
    if (renderer_P3D() && renderer_dimension == P3D && polar_is) {
      give_points_to_costume_3D(); 
    } else {
      give_points_to_costume_2D();
    }
  }

  protected void give_points_to_costume_3D() {
    if(!polar_is) {
      for(int i  = 0 ; i < coord.length ;i++) {
        // method from mother class need pass info arg
        if(ratio_costume_size != Float.MAX_VALUE) {
          set_ratio_costume_size(ratio_costume_size);
        }
        costume.draw(coord[i],size,vec3(0,0,costume_angle));
      }
    } else {
      // method from here don't need to pass info about arg
      costume_3D_polar(dist) ;
    }
  }
  
  // internal
  protected void costume_3D_polar(float dist) {
   push() ;
   translate(pos) ;
    for(int i = 0 ; i < num ;i++) {
      push() ;
      /**
      super effect
      float rot = (map(mouseX,0,width,-PI,PI)) ;
      dir_pol[i].y += rot ;
      */
      if(rotation_x) rotateX(dist_x); 
      if(rotation_y) rotateY(dist_y); 
      if(rotation_z) rotateZ(dist_z); 
      // vec2 coord_temp = vec2(coord[i].x,coord[i].y).add(dist);
      vec2 coord_temp = vec2(coord[i].x,coord[i].y);
      rotateYZ(coord_temp) ;
      
      if(rotation_fx_x) rotateX(dist_fx_x); // interesting
      if(rotation_fx_y) rotateY(dist_fx_y); // interesting
      if(rotation_fx_z) rotateZ(dist_fx_z); // interesting

      vec3 pos_primitive = vec3(radius,0,0) ;
      translate(pos_primitive) ;

      push();
      rotateXYZ(orientation) ;
      vec3 pos_local_primitive = vec3();

      if(ratio_costume_size != Float.MAX_VALUE) {
        set_ratio_costume_size(ratio_costume_size);
      }
      costume.draw(pos_local_primitive, size,vec3(0,0,costume_angle));
      pop() ;
      pop() ;
    }
    pop() ;
  }
}



















/**
Class pixel Basic
v 0.0.3
*/
class Pixel extends Pix  {
  // CONSTRUCTOR
  
  // PIXEL 2D
  public Pixel(PApplet p5, vec2 pos_2D) {
    super(p5);
    init_mother_arg() ;
    this.pos = new vec3(pos_2D.x,pos_2D.y, 0)  ;
  }

  public Pixel(PApplet p5, vec2 pos_2D, vec2 size_2D) {
    super(p5);
    init_mother_arg() ;
    this.pos = new vec3(pos_2D.x,pos_2D.y, 0)  ;
    this.size = new vec3(size_2D.x,size_2D.y,0) ; ;
  }
  
  // Constructor plus color components
  public Pixel(PApplet p5, vec2 pos_2D, vec4 color_vec) {
    super(p5);
    init_mother_arg() ;
    this.pos = new vec3(pos_2D.x,pos_2D.y, 0)  ;
    colour = vec4(color_vec) ;
    new_colour = vec4(colour) ;
    
  }

  public Pixel(PApplet p5, vec2 pos_2D, vec2 size_2D, vec4 color_vec) {
    super(p5);
    init_mother_arg() ;
    this.pos = new vec3(pos_2D.x,pos_2D.y, 0)  ;
    this.size = new vec3(size_2D.x,size_2D.y,0) ;
    colour = vec4(color_vec) ;
    new_colour = vec4(colour) ;
  }


 

  //PIXEL 3D
  public Pixel(PApplet p5, vec3 pos_3D) {
    super(p5);
    init_mother_arg() ;
    this.pos = pos_3D  ;
  }

  public Pixel(PApplet p5, vec3 pos_3D, vec3 size_3D) {
    super(p5);
    init_mother_arg() ;
    this.pos = pos_3D ;
    this.size = size_3D ;
  }
  // constructor plus color component
  public Pixel(PApplet p5, vec3 pos_3D,  vec4 color_vec) {
    super(p5);
    init_mother_arg() ;
    this.pos = pos_3D ;
    colour = color_vec.copy() ;
    new_colour = colour.copy() ;
  }
  
  public Pixel(PApplet p5, vec3 pos_3D, vec3 size_3D, vec4 color_vec) {
    super(p5);
    init_mother_arg() ;
    this.pos = pos_3D ;
    this.size = size_3D ;
    colour = color_vec.copy() ;
    new_colour = colour.copy() ;
  }


  
  //RANK PIXEL CONSTRUCTOR
  public Pixel(PApplet p5, int rank) {
    super(p5);
    init_mother_arg() ;
    this.rank = rank ;
  }
  
  public Pixel(PApplet p5, int rank, vec2 grid_position_2D) {
    super(p5);
    init_mother_arg() ;
    this.rank = rank ;
    this.grid_position = new vec3(grid_position_2D.x,grid_position_2D.y,0) ;
  }
  public Pixel(PApplet p5, int rank, vec3 grid_position) {
    super(p5);
    init_mother_arg() ;
    this.rank = rank ;
    this.grid_position = grid_position ;
  }
  
  // METHOD

  // set summit
  private void set_summits(int summits) {
    if(summits == 1) this.costume.set_type(POINT_ROPE);
    else if(summits == 2) this.costume.set_type(LINE_ROPE);
    else if(summits == 3) this.costume.set_type(TRIANGLE_ROPE);
    else if(summits == 4) this.costume.set_type(SQUARE_ROPE);
    else if(summits == 5) this.costume.set_type(PENTAGON_ROPE);
    else if(summits == 6) this.costume.set_type(HEXAGON_ROPE);
    else if(summits == 7) this.costume.set_type(HEPTAGON_ROPE);
    else if(summits == 8) this.costume.set_type(OCTOGON_ROPE);
    else if(summits == 9) this.costume.set_type(NONAGON_ROPE);
    else if(summits == 10) this.costume.set_type(DECAGON_ROPE);
    else if(summits == 11) this.costume.set_type(HENDECAGON_ROPE);
    else if(summits == 12) this.costume.set_type(DODECAGON_ROPE);
    else if(summits > 12) this.costume.set_type(ELLIPSE_ROPE);
  }



  // show
  public void show() {
    if(ratio_costume_size != Float.MAX_VALUE) {
      set_ratio_costume_size(ratio_costume_size);
    }
    if (renderer_P3D()) {
      this.costume.draw(pos,size,dir);
    } else {
      this.costume.draw(pos,size,vec3(0,0,costume_angle));
    }
  }
}




























/**
PIXEL MOTION 0.0.2
*/
class Pixel_motion extends Pix  {
    /**
    Not sure I must keep the arg field and life
  */
  float field = 1.0 ;
  float life = 1.0 ;

  // CONSTRUCTOR 2D
  Pixel_motion(PApplet p5, vec2 pos_2D, float field, int colour_int) {
    super(p5);
    init_mother_arg() ;
    this.pos = vec3(pos_2D) ;
    this.field = field ;
    colour = int_color_to_vec4_color(colour_int) ;
    new_colour = vec4(colour) ;
  }

  Pixel_motion(PApplet p5, vec2 pos_2D, float field, vec4 colour_vec) {
    super(p5);
    init_mother_arg() ;
    this.pos = vec3(pos_2D) ;
    this.field = field ;
    colour = vec4(colour_vec) ;
    new_colour = vec4(colour) ;
  }

  Pixel_motion(PApplet p5, vec2 pos_2D, float field) {
    super(p5);
    init_mother_arg() ;
    this.pos = vec3(pos_2D) ;
    this.field = field ;
  }
  
  // CONSTRUCTOR 3D
  Pixel_motion(PApplet p5, vec3 pos, float field, int colour_int) {
    super(p5);
    init_mother_arg() ;
    this.pos = vec3(pos) ;
    this.field = field ;
    colour = int_color_to_vec4_color(colour_int) ;
    new_colour = vec4(colour) ;
  }

  Pixel_motion(PApplet p5, vec3 pos, float field, vec4 colour_vec) {
    super(p5);
    init_mother_arg() ;
    this.pos = vec3(pos) ;
    this.field = field ;
    colour = vec4(colour_vec) ;
    new_colour = vec4(colour) ;
  }

  Pixel_motion(PApplet p5, vec3 pos, float field) {
    super(p5);
    init_mother_arg() ;
    this.pos = vec3(pos) ;
    this.field = field ;
  }


  


  /**
  Motion ink
  */
  void motion_ink_2D() {
    int size_field = 1 ;
    float speed_dry = 0 ;
    motion_ink_2D(size_field, speed_dry) ;
  }

  void motion_ink_2D(float speed_dry) {
    int size_field = 1 ;
    motion_ink_2D(size_field, speed_dry) ;
  }

  void motion_ink_2D(int size_field) {
    float speed_dry = 0 ;
    motion_ink_2D(size_field, speed_dry) ;
  }


  // with external var
  void motion_ink_2D(int size_field, float speed_dry) {
    if (field > 0 ) { 
      if(speed_dry != 0 ) field -= abs(speed_dry) ;
      float rad;
      float angle;
      rad = random(-1,1) *field *size_field;
      angle = random(-1,1) *TAU;
      pos.x += rad * cos(angle);
      pos.y += rad * sin(angle);
    }
  }



  // 3D
  void motion_ink_3D() {
    int size_field = 1 ;
    float speed_dry = 0 ;
    motion_ink_3D(size_field, speed_dry) ;
  }

  void motion_ink_3D(float speed_dry) {
    int size_field = 1 ;
    motion_ink_3D(size_field, speed_dry) ;
  }

  void motion_ink_3D(int size_field) {
    float speed_dry = 0 ;
    motion_ink_3D(size_field, speed_dry) ;
  }

  // with external var
  void motion_ink_3D(int size_field, float speed_dry) {
    if (field > 0 ) { 
      if(speed_dry != 0 ) field -= abs(speed_dry) ;
      float rad;
      float angle;
      rad = random(-1,1) *field *size_field;
      angle = random(-1,1) *TAU;
      pos.x += rad * cos(angle);
      pos.y += rad * sin(angle);
      pos.z += rad * cos(angle);
    }
  }




  


  
  
  
  /**
  This part must be refactoring, is really a confusing way to code
  For example why we use PImage ????
  Why do we use 'wind', can't we use 'motion' instead ????
  
  //UPDATE POSITION with the wind
  void update_position_2D(PVector effectPosition, PImage pic) {
    vec2 dir_2D = norm_dir("DEG",effectPosition.x) ;
    
    velocity_2D = vec2 (  1.0 *dir_2D.x *effectPosition.y  + random(-effectPosition.z) ,
                      1.0 *dir_2D.y *effectPosition.y  + random(-effectPosition.z))   ;
    pos_2D.add(wind_2D) ;
    //keep the pixel in the scene
    if (pos_2D.x< 0)          pos_2D.x= pic.width;
    if (pos_2D.x> pic.width)  pos_2D.x=0;
    if (pos_2D.y< 0)          pos_2D.y= pic.height;
    if (pos_2D.y> pic.height) pos_2D.y=0;
  }
  
  
  
  //return position with display size
  vec2 position_2D(PVector effectPosition, PImage pic) {
    vec2 dir_2D = norm_dir("DEG",effectPosition.x) ;

    new_pos_2D = pos_2D.copy() ;
    
    direction_2D = vec2 (  1.0 *dir_2D.x *effectPosition.y  + random(-effectPosition.z, effectPosition.z) ,
                      1.0 *dir_2D.y *effectPosition.y  + random(-effectPosition.z, effectPosition.z))   ;
                  
    new_pos_2D.add(wind_2D) ;
    //keep the pixel in the scene
    if (new_pos_2D.x< 0)          new_pos_2D.x= pic.width;
    if (new_pos_2D.x> pic.width)  new_pos_2D.x=0;
    if (new_pos_2D.y< 0)          new_pos_2D.y= pic.height;
    if (new_pos_2D.y> pic.height) new_pos_2D.y=0;
    
    return new_pos_2D ;
  }
  */
  /**
  End of method who must be refactoring
  */
}