// CLASS PIX 0.1.2
/////////////////////
/**
https://github.com/StanLepunK/Pixel
*/
public interface Pixel_Constants {
  static public final String RANDOM = "RANDOM";

  // BASIC SHAPES 2D
  static public final String POINT = "POINT";
  static public final String LINE = "LINE";
  static public final String TRIANGLE = "TRI";
  static public final String SQUARE = "SQUARE";
  static public final String RECTANGLE = "RECT";
  static public final String PENTAGONE = "PENTA";
  static public final String HEXAGONE = "HEXA";
  // seven side ????
  static public final String OCTOGONE = "OCTO";
  static public final String POLYGONE = "POLY";


  // BASIC SHAPES 3D
  static public final String CUBE = "CUBE";
  static public final String BOX = "BOX";
  
  // SPECIAL SHAPES
  static public final String RING = "RING";
  static public final String DISC = "DISC";
  static public final String SPHERE = "SPHERE";
  static public final String STAR = "STAR";
  static public final String CROSS = "CROSS";

}


// MOTHER CLASS
// No contructor in this Class

class Pix implements Pixel_Constants{
  // P3D mode
  Vec3 pos, new_pos ;
  Vec3 size  ;
  Vec2 angle ;
  Vec3 grid_position ;
  int ID, rank ;
  String costume  ;
  Vec4 original_color, new_color   ;


    void init_mother_arg() {
    pos = Vec3(width/2, height/2,0 ) ;
    new_pos = pos.copy() ;
    size = Vec3(1) ;
    angle = Vec2(0);
    grid_position = pos.copy() ;
    // give a WHITE color to the pixel
    if(g.colorMode == 3 ) original_color = Vec4(0, 0, g.colorModeZ, g.colorModeA) ; else original_color = Vec4(g.colorModeX, g.colorModeY, g.colorModeZ, g.colorModeA) ;
    new_color = original_color.copy() ;

    int ID = 0 ;
    int rank = -1 ;
    String costume = DISC ;
  }
  
  
  // RETURN color in Vec4
  // test the color mode to return the good data for each component
  Vec4 int_color_to_vec4_color(int c) {
    Vec4 color_temp = new Vec4() ;
    /*
    if(g.colorMode == 3 ) color_temp = Vec4(hue(c), saturation(c), brightness(c),g.colorModeA) ;
    else color_temp = Vec4(red(c),green(c), blue(c),g.colorModeA) ;
    */
    if(g.colorMode == 3 ) color_temp = Vec4(hue(c), saturation(c), brightness(c),alpha(c)) ;
    else color_temp = Vec4(red(c),green(c), blue(c),alpha(c)) ;
    return color_temp ;
  }






    // ID
 //change ID after analyze if this one is good
  void changeID(int ID) {  
    this.ID = ID ; 
  }







  // COSTUME
  //////////
  
  
  
  // mother method
  void costume_2D(Vec3 p, Vec3 s, Vec2 ang) {
    if (costume == POINT) point(p.x, p.y) ;
    else if(costume == DISC ) ellipse(p.x, p.y, s.x, s.y) ;
    else if(costume == TRIANGLE ) primitive(p, (int)s.x, 3, ang.x) ;
    else if(costume == SQUARE ) primitive(p, (int)s.x, 4, ang.x) ;
    else if(costume == PENTAGONE ) primitive(p, (int)s.x, 5, ang.x) ;
    else if(costume == HEXAGONE ) primitive(p, (int)s.x, 6, ang.x) ;
    else point(p.x, p.y) ;

  }

  void costume_3D(Vec3 p, Vec3 s, Vec2 ang) {
    if (costume == POINT) point(p.x, p.y, p.z) ;
    else if(costume == DISC ) {
      pushMatrix() ;
      translate(p.x, p.y,p.z) ;
      ellipse(0,0,s.x, s.y) ;
      popMatrix() ;
    } else if(costume == TRIANGLE ) primitive(p, (int)s.x, 3, ang.x) ;
    else if(costume == SQUARE ) primitive(p, (int)s.x, 4, ang.x) ;
    else if(costume == PENTAGONE ) primitive(p, (int)s.x, 5, ang.x) ;
    else if(costume == HEXAGONE ) primitive(p, (int)s.x, 6, ang.x) ;
    else point(p.x, p.y, p.z) ;
  }
  // END COSTUME
  //////////////









  //ASPECT
  /////////

  //without effect
  // basic

  /**
  improve methode to check if the stroke must be Stroke or noStroke()
  */
  void aspect() {
    float thickness = 1 ;
    aspect(original_color, original_color, thickness) ;
  }

  void aspect(boolean new_color_choice) {
    float thickness = 1 ;
    Vec4 color_choice = Vec4() ;
    if(new_color_choice) color_choice = new_color.copy() ; else color_choice = original_color.copy() ;
    aspect(color_choice, color_choice, thickness) ;
  }

  void aspect(boolean new_color_choice, float thickness) {
    Vec4 color_choice = Vec4() ;
    if(new_color_choice) color_choice = new_color.copy() ; else color_choice = original_color.copy() ;

    if(thickness <= 0) { 
      noStroke() ;
      fill(color_choice.r,color_choice.g,color_choice.b,color_choice.a) ;

    } else { 
      strokeWeight(thickness) ;
      stroke(color_choice.r,color_choice.g,color_choice.b,color_choice.a) ;
      fill(color_choice.r,color_choice.g,color_choice.b,color_choice.a) ;
    }
  }

  void aspect(float thickness) {
    if(thickness <= 0) { 
      noStroke() ;
      fill(original_color.r,original_color.g,original_color.b,original_color.a) ;

    } else { 
      strokeWeight(thickness) ;
      stroke(original_color.r,original_color.g,original_color.b,original_color.a) ;
      fill(original_color.r,original_color.g,original_color.b,original_color.a) ;
    }
  }

  void aspect(int c) {
    float thickness = 1 ;
    Vec4 color_pix = int_color_to_vec4_color(c).copy() ;
    aspect(color_pix, color_pix, thickness) ;
  }

  void aspect(Vec4 color_pix) {
    float thickness = 1 ;
    aspect(color_pix, color_pix, thickness) ;
  }
  
  
  // main method aspect
  void aspect(Vec4 color_fill, Vec4 color_stroke, float thickness) {
    if(color_fill.a <= 0 && color_stroke.a <= 0) {
      noStroke() ; 
      noFill() ;
    } else {
      if (renderer_P3D()) {
        // stroke part
        if(thickness <= 0 || color_stroke.a <= 0 ) noStroke() ; else {
          if(costume == POINT ) {
            println("Costume is POINT, the Vec size is used for the strokeWeight") ;
            strokeWeight((size.x + size.y + size.z)/3) ; 
          } else strokeWeight(thickness) ;
          stroke(color_stroke.r, color_stroke.g, color_stroke.b, color_stroke.a) ;
        }
        // fill part
        if (color_fill.a <= 0 ) noFill() ; else fill(color_fill.r,color_fill.g, color_fill.b, color_fill.a) ;
      } else {
        // stroke part
        if(thickness <= 0 || color_stroke.a <= 0 ) noStroke() ; 
        else {
          if(costume == POINT ) { 
            strokeWeight((size.x + size.y + size.z)/3) ;
            println("Costume is POINT, the diameter is used for the strokeWeight") ;
          } else strokeWeight(thickness) ;
          stroke(color_stroke.r, color_stroke.g, color_stroke.b, color_stroke.a) ;
        }
        // fill part
        if (color_fill.a <= 0 ) noFill() ; else fill(color_fill.r,color_fill.g, color_fill.b, color_fill.a) ;
      }
    }
  }




  //with effect
  /**
  Methode must be refactoring, very weird
  */
  void aspect(int diam, PVector effectColor) {
    strokeWeight(diam) ;
    stroke(new_color.r, effectColor.x *new_color.g, effectColor.y *new_color.b, effectColor.z *new_color.a) ;
  }
  // END ASPECT
  /////////////
  
  
  
  
  
    // CHANGE COLOR
  ////////////////
  //direct change HSB
  void change_hue(int new_hue, int target_color, boolean use_new_color) {
    change_hue(new_hue, target_color, target_color +1, use_new_color) ;
  }
  void change_saturation(int new_sat, int target_color, boolean use_new_color) {
    change_saturation(new_sat, target_color, target_color +1, use_new_color) ;
  }
  void change_brightness(int new_bright, int target_color, boolean use_new_color) {
    change_brightness(new_bright, target_color, target_color +1, use_new_color) ;
  }
  //direct change RGB
  void change_red(int new_red, int target_color, boolean use_new_color) {
    change_red(new_red, target_color, target_color +1, use_new_color) ;
  }
  void change_green(int new_green, int target_color, boolean use_new_color) {
    change_green(new_green, target_color, target_color +1, use_new_color) ;
  }
  void change_blue(int new_blue, int target_color, boolean use_new_color) {
    change_blue(new_blue, target_color, target_color +1, use_new_color) ;
  }
  //direct change ALPHA
  void change_alpha(int new_alpha, int target_color, boolean use_new_color) {
    change_alpha(new_alpha, target_color, target_color +1, use_new_color) ;
  }
  
  // change with range
  // HSB change
  void change_hue(int new_hue, int start, int end, boolean use_new_color) {
    float hue_temp ; ;
    if(!use_new_color) hue_temp = change_color_component_from_specific_component("hue", original_color.r, new_hue, start, end) ; 
    else hue_temp = change_color_component_from_specific_component("hue", new_color.r, new_hue, start, end) ;
    new_color = Vec4(hue_temp, new_color.y, new_color.z, new_color.w)  ;
  }
  void change_saturation(int new_saturation, int start, int end, boolean use_new_color) {
    float saturation_temp ;
    if(!use_new_color) saturation_temp = change_color_component_from_specific_component("saturation", original_color.g, new_saturation, start, end) ;
    else saturation_temp = change_color_component_from_specific_component("saturation", new_color.g, new_saturation, start, end) ;
    new_color = Vec4(new_color.x, saturation_temp, new_color.z, new_color.w)  ;
  }
  void change_brightness(int new_brightness, int start, int end, boolean use_new_color) {
    float brightness_temp ;
    if(!use_new_color) brightness_temp = change_color_component_from_specific_component("brightness", original_color.b, new_brightness, start, end) ;
    else brightness_temp = change_color_component_from_specific_component("brightness", new_color.b, new_brightness, start, end) ;
    new_color = Vec4(new_color.x, new_color.y, brightness_temp, new_color.w)  ;
  }
  // RGB change
  void change_red(int new_red, int start, int end, boolean use_new_color) {
    float red_temp ;
    if(!use_new_color) red_temp = change_color_component_from_specific_component("red", original_color.r, new_red, start, end) ;
    else red_temp = change_color_component_from_specific_component("red", new_color.r, new_red, start, end) ;
    new_color = Vec4(red_temp, new_color.y, new_color.z, new_color.w)  ;
  }
  void change_green(int new_green, int start, int end, boolean use_new_color) {
    float green_temp ;
    if(!use_new_color) green_temp = change_color_component_from_specific_component("green", original_color.g, new_green, start, end) ;
    else green_temp = change_color_component_from_specific_component("green", new_color.g, new_green, start, end) ;
    new_color = Vec4(new_color.x, green_temp, new_color.z, new_color.w)  ;
  }
  void change_blue(int new_blue, int start, int end, boolean use_new_color) {
    float blue_temp ;
    if(!use_new_color) blue_temp = change_color_component_from_specific_component("blue", original_color.b, new_blue, start, end) ;
    else blue_temp = change_color_component_from_specific_component("blue", new_color.b, new_blue, start, end) ;
    new_color = Vec4(new_color.x, new_color.y, blue_temp, new_color.w)  ;
  }

  // ALPHA change
  void change_alpha(int new_alpha, int start, int end, boolean use_new_color) {
    float alpha_temp ;
    if(!use_new_color) alpha_temp = change_color_component_from_specific_component("alpha", original_color.a, new_alpha, start, end) ;
    else alpha_temp = change_color_component_from_specific_component("alpha", new_color.a, new_alpha, start, end) ;
    new_color = Vec4(new_color.x, new_color.y, new_color.z, alpha_temp)  ;
  }



  // INTERNAL method to change color
  float change_color_component_from_specific_component (String which_component, float original_component, int new_component, int start_range, int end_range) {
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
// END MOTHER CLASS
//////////////////////



















// CHILD CLASS
////////////////



// PIXEL CLOUD
/////////////////////
class Pixel_cloud extends Pix implements Pixel_Constants {
  int num ;
  float beat_ref = .001 ;
  float beat = .001 ;
  Vec3 [] point, point_normal ;
  String cloud_2D_or_3D, order_or_Chaos ;
  Pixel_cloud(int num, String cloud_2D_or_3D, String order_or_Chaos) {
    init_mother_arg() ;
    this.num = num ;
    this.cloud_2D_or_3D = cloud_2D_or_3D ;
    this.order_or_Chaos = order_or_Chaos ;
    point = new Vec3[num] ;
    point_normal = new Vec3[num] ;
    init(cloud_2D_or_3D, order_or_Chaos) ;
  }

  // BUILD
  //////////

    // internal method
  void init(String cloud_2D_or_3D, String order_or_Chaos) {
    if(cloud_2D_or_3D == "2D") normal_pos_2D(order_or_Chaos) ; else normal_pos_3D(order_or_Chaos) ;
    /*
    switch(type_of_cloud) {
      case RING : create_list_coord_points_circle() ; break ; // circle
      case LINE : create_list_coord_points_line() ; break ; // line
      case DISC : create_list_coord_points_disc() ; break ; // disc
      case SPHERE : create_list_coord_points_cloud() ; break ; // cloud
      default : create_list_coord_points_disc() ; break ; // disc
    }
    */
  }


    void normal_pos_2D(String order_or_Chaos) {
    float angle = TAU / num ;
    float tetha  = angle ;
    for(int i = 0 ; i < num ; i++ ) {
      if(order_or_Chaos == "ORDER") point_normal[i] = Vec3(cos(tetha),sin(tetha), 0 ) ; else {
        tetha  = random(-PI, PI) ;
        point_normal[i] = Vec3(cos(tetha),sin(tetha), 0 ) ;
      }
      tetha += angle ;
    }
  }

  void normal_pos_3D(String order_or_Chaos) {
    if(order_or_Chaos == "ORDER") {
      float step = PI * (3 - sqrt(5.)) ; 
      float root = PI ;
      point_normal = distribution_cartesian_fibonacci_sphere (num, step, root) ;
    } else {
      for(int i = 0 ; i < point.length ; i++ ) {
        float tetha  = random(-PI, PI) ;
        float phi  = random(-TAU, TAU) ;
        point_normal[i] = Vec3(cos(tetha) *cos(phi),
                        cos(tetha) *sin(phi), 
                        sin(tetha) ) ; 
      }
    }
  }
 /*
  void create_list_coord_points_circle() {
    float angle = TAU / num ;
    float tetha  = angle ;
    point = new Vec3 [num] ;
    for(int i = 0 ; i < num ; i++ ) {
      point[i] = Vec3(cos(tetha),sin(tetha), 0 ) ;
      tetha += angle ;
    }
  }
  
  // DISC
  void create_list_coord_points_disc() {
    point = new Vec3 [num] ;
    for(int i = 0 ; i < num ; i++ ) {
      float tetha  = random(-PI, PI) ;
      point[i] = Vec3(cos(tetha),sin(tetha), 0 ) ;
    }
  }
  
  
  // LINE
  void create_list_coord_points_line() {
    float tetha  = random(-PI, PI) ;
    point = new Vec3 [num] ;
    for(int i = 0 ; i < num ; i++ ) {
      point[i] = Vec3(cos(tetha),sin(tetha), 0 ) ;
    }
  }
  
  
  // DISC
  void create_list_coord_points_cloud() {
    point = new Vec3 [num] ;
    for(int i = 0 ; i < num ; i++ ) {
      point[i] = new Vec3(RANDOM, 1) ;
    }
  }
  */

  // END BUILD
  /////////////
  
  












  // DISPLAY
  //////////////
  
  // external method
  void beat(int n) {
    this.beat = beat_ref *n ;
  }


  void distribution_in(Vec3 pos, int radius, String pattern_distribution) {
    float new_radius = radius  ;
    for (int i = 0 ; i < point.length ; i++) {
      point[i] = point_normal[i].copy() ;
      new_radius = distribution_pattern(radius, pattern_distribution) ;
      point[i].mult(new_radius) ;
      point[i].add(pos) ;
    }
  }
  void distribution_out(Vec3 pos, int radius) {
    float new_radius = radius  ;
    for (int i = 0 ; i < point.length ; i++) {
      point[i] = point_normal[i].copy() ;
      point[i].mult(new_radius) ;
      point[i].add(pos) ;
    }
  }
  // internal method
  float distribution_pattern(float range, String pattern_distribution) {
    float pos = 1 ;
    float normal_distribution = 1 ;
    
    float root_1 =0 ;
    float root_2 = 0 ;
    float root_3 = 0 ;
    float root_4 = 0 ;
     if(pattern_distribution.contains("RANDOM")) {
      root_1 = random(1) ;
      if(pattern_distribution.contains("2") || pattern_distribution.contains("3") || pattern_distribution.contains("4")|| pattern_distribution.contains("SPECIAL")) {
        root_2 = random(1) ;
        root_3 = random(1) ;
        root_4 = random(1) ;
      }
    }

    float t = 0 ;
    if(pattern_distribution.contains("SIN") || pattern_distribution.contains("COS")) t = frameCount *beat ;
    float factor_1_2 = 1.2 ;
    float factor_0_5 = .5 ;
    float factor_12_0 = 12. ;
    float factor_10_0 = 10. ;
    
    if(pattern_distribution == "RANDOM") normal_distribution = root_1 ;
    else if(pattern_distribution == "ROOT_RANDOM") normal_distribution = sqrt(root_1) ;
    else if(pattern_distribution == "QUARTER_RANDOM") normal_distribution = 1 -(.25 *root_1) ;
    
    else if(pattern_distribution == "2_RANDOM") normal_distribution = root_1 *root_2 ;

    else if(pattern_distribution == "3_RANDOM") normal_distribution = root_1 *root_2 *root_3 ;

    else if(pattern_distribution == "4_RANDOM") normal_distribution = root_1 *root_2 *root_3 *root_4 ;
    else if(pattern_distribution == "SPECIAL_A_RANDOM") normal_distribution = .25 *( root_1 +root_2 +root_3 +root_4) ;
    else if(pattern_distribution == "SPECIAL_B_RANDOM") {
      float temp = root_1 -root_2 +root_3 -root_4 ;
      if(temp < 0) temp += 4 ;
      normal_distribution = .25 *temp ;
    }

    else if(pattern_distribution == "SIN") normal_distribution = sin(t) ;
    else if(pattern_distribution == "COS") normal_distribution = cos(t) ;
    else if(pattern_distribution == "SIN_TAN_COS") normal_distribution = sin(tan(cos(t) *factor_1_2)) ;
    else if(pattern_distribution == "SIN_TAN") normal_distribution = sin(tan(t)*factor_0_5) ;
    else if(pattern_distribution == "SIN_POW_SIN") normal_distribution = sin(pow(8.,sin(t))) ;
    else if(pattern_distribution == "POW_SIN_PI") normal_distribution = pow(sin((t) *PI), factor_12_0) ;
    else if(pattern_distribution == "SIN_TAN_POW_SIN") normal_distribution = sin(tan(t) *pow(sin(t),factor_10_0)) ;



    pos = range *normal_distribution ;
    return pos ;
  }
  
  
  
  
  
  
  


 



  // return list of point
  Vec3 [] list() {
    return point ;
  }
  
  
  
  
  // COSTUME
  // child method
  void costume() {
    if (renderer_P3D()) if (renderer_P3D()) give_points_to_costume_3D() ; else  give_points_to_costume_2D() ;
  }

  void costume(float angle_x) {
    this.angle = Vec2(angle_x,0) ;
    if (renderer_P3D()) if (renderer_P3D()) give_points_to_costume_3D() ; else  give_points_to_costume_2D() ;
  }

  void costume(String costume) {
    this.costume = costume ;
    if (renderer_P3D()) if (renderer_P3D()) give_points_to_costume_3D() ; else  give_points_to_costume_2D() ;
  }


  void costume(String costume, float angle_x) {
    this.costume = costume ;
    this.angle = Vec2(angle_x,0) ;
    if (renderer_P3D()) give_points_to_costume_3D() ; else  give_points_to_costume_2D() ;
  }
  
  // local method
  void give_points_to_costume_2D() {
    for(int i  = 0 ; i < point.length ;i++) costume_2D(point[i], size, angle) ;
  }
  void give_points_to_costume_3D() {
    for(int i  = 0 ; i < point.length ;i++) costume_3D(point[i], size, angle) ;
  }
  // END COSTUME
  //////////////
}


















class Pixel extends Pix implements Pixel_Constants {
  // CONSTRUCTOR
  
  // PIXEL 2D
  Pixel(Vec2 pos_2D) {
    init_mother_arg() ;
    this.pos = new Vec3(pos_2D.x,pos_2D.y, 0)  ;
  }

  Pixel(Vec2 pos_2D, Vec2 size_2D) {
    init_mother_arg() ;
    this.pos = new Vec3(pos_2D.x,pos_2D.y, 0)  ;
    this.size = new Vec3(size_2D.x,size_2D.y,0) ; ;
  }
  
  // Constructor plus color components
  Pixel(Vec2 pos_2D, Vec4 color_vec) {
    init_mother_arg() ;
    this.pos = new Vec3(pos_2D.x,pos_2D.y, 0)  ;
    original_color = color_vec.copy() ;
    new_color = original_color.copy() ;
    
  }

  Pixel(Vec2 pos_2D, Vec2 size_2D, Vec4 color_vec) {
    init_mother_arg() ;
    this.pos = new Vec3(pos_2D.x,pos_2D.y, 0)  ;
    this.size = new Vec3(size_2D.x,size_2D.y,0) ;
    original_color = color_vec.copy() ;
    new_color = original_color.copy() ;
  }

  // Constructor with costume indication
  Pixel(Vec2 pos_2D, Vec2 size_2D, String costume) {
    init_mother_arg() ;
    this.costume = costume ;
    this.pos = new Vec3(pos_2D.x,pos_2D.y, 0)  ;
    this.size = new Vec3(size_2D.x,size_2D.y,0) ; ;
  }
  
  // Constructor plus color components
  Pixel(Vec2 pos_2D, Vec4 color_vec, String costume) {
    init_mother_arg() ;
    this.costume = costume ;
    this.pos = new Vec3(pos_2D.x,pos_2D.y, 0)  ;
    original_color = color_vec.copy() ;
    new_color = original_color.copy() ;
    
  }

  Pixel(Vec2 pos_2D, Vec2 size_2D, Vec4 color_vec, String costume) {
    init_mother_arg() ;
    this.costume = costume ;
    this.pos = new Vec3(pos_2D.x,pos_2D.y, 0)  ;
    this.size = new Vec3(size_2D.x,size_2D.y,0) ;
    original_color = color_vec.copy() ;
    new_color = original_color.copy() ;
  }


  //PIXEL 3D
  Pixel(Vec3 pos_3D) {
    init_mother_arg() ;
    this.pos = pos_3D  ;
  }

  Pixel(Vec3 pos_3D, Vec3 size_3D) {
    init_mother_arg() ;
    this.pos = pos_3D ;
    this.size = size_3D ;
  }
  // constructor plus color component
  Pixel(Vec3 pos_3D,  Vec4 color_vec) {
    init_mother_arg() ;
    this.pos = pos_3D ;
    original_color = color_vec.copy() ;
    new_color = original_color.copy() ;
  }
  
  Pixel(Vec3 pos_3D, Vec3 size_3D, Vec4 color_vec) {
    init_mother_arg() ;
    this.pos = pos_3D ;
    this.size = size_3D ;
    original_color = color_vec.copy() ;
    new_color = original_color.copy() ;
  }

  // with costume indication
  Pixel(Vec3 pos_3D, Vec3 size_3D, String costume) {
    init_mother_arg() ;
    this.costume = costume ;
    this.pos = pos_3D ;
    this.size = size_3D ;
  }
  // constructor plus color component
  Pixel(Vec3 pos_3D,  Vec4 color_vec, String costume) {
    init_mother_arg() ;
    this.costume = costume ;
    this.pos = pos_3D ;
    original_color = color_vec.copy() ;
    new_color = original_color.copy() ;
  }
  
  Pixel(Vec3 pos_3D, Vec3 size_3D, Vec4 color_vec, String costume) {
    init_mother_arg() ;
    this.costume = costume ;
    this.pos = pos_3D ;
    this.size = size_3D ;
    original_color = color_vec.copy() ;
    new_color = original_color.copy() ;
  }
  



  
  //RANK PIXEL CONSTRUCTOR
  Pixel(int rank) {
    init_mother_arg() ;
    this.rank = rank ;
  }
  
  Pixel(int rank, Vec2 grid_position_2D) {
    init_mother_arg() ;
    this.rank = rank ;
    this.grid_position = new Vec3(grid_position_2D.x,grid_position_2D.y,0) ;
  }
  Pixel(int rank, Vec3 grid_position) {
    init_mother_arg() ;
    this.rank = rank ;
    this.grid_position = grid_position ;
  }
  

  





  // METHOD
  ///////////////

  // COSTUME
  // child method
  void costume() {
    if (renderer_P3D()) {
      costume_3D(pos, size, angle) ;
    } else {
      costume_2D(pos, size, angle) ;
    }
  }

  void costume(float angle_x) {
    this.angle = Vec2(angle_x,0) ;

    if (renderer_P3D()) {
      costume_3D(pos, size, angle) ;
    } else {
      costume_2D(pos, size, angle) ;
    }
  }

  void costume(String costume) {
    this.costume = costume ;
    if (renderer_P3D()) {
      costume_3D(pos, size, angle) ;
    } else {
      costume_2D(pos, size, angle) ;
    }
  }


  void costume(String costume, float angle_x) {
    this.costume = costume ;
    this.angle = Vec2(angle_x,0) ;

    if (renderer_P3D()) {
      costume_3D(pos, size, angle) ;
    } else {
      costume_2D(pos, size, angle) ;
    }
  }
}
// END CLASS PIXEL
/////////////////
























// PIXEL MOTION
///////////////
class Pixel_motion extends Pix implements Pixel_Constants {
    /**
    Not sure I must keep the arg field and life
  */
  float field = 1.0 ;
  float life = 1.0 ;


    //INK CONSTRUCTOR
  /**
  Pixel(Vec2 pos_2D, float field, int color_pixel_in_int) {
    init_mother_arg() ;
    this.pos_2D = pos_2D ;
    this.field = field ;
    this.color_pixel_in_int = color_pixel_in_int ;
    original_color = int_color_to_vec4_color(color_pixel_in_int).copy() ;
  }
  Pixel(Vec2 pos_2D, float field) {
    init_mother_arg() ;
    this.pos_2D = pos_2D ;
    this.field = field ;
  }
  */




  
  // DRYING
  //drying is like jitter but with time effect, it's very subtil so we use a float timer.
    // classic
  void stop_motion_2D(float timePast) {
  }
  
  
  
  /**
  This part must be refactoring, is really a confusing way to code
  For example why we use PImage ????
  Why do we use 'wind', can't we use 'motion' instead ????
  
  //UPDATE POSITION with the wind
  void update_position_2D(PVector effectPosition, PImage pic) {
    Vec2 dir_2D = norm_dir("DEG",effectPosition.x) ;
    
    velocity_2D = Vec2 (  1.0 *dir_2D.x *effectPosition.y  + random(-effectPosition.z) ,
                      1.0 *dir_2D.y *effectPosition.y  + random(-effectPosition.z))   ;
    pos_2D.add(wind_2D) ;
    //keep the pixel in the scene
    if (pos_2D.x< 0)          pos_2D.x= pic.width;
    if (pos_2D.x> pic.width)  pos_2D.x=0;
    if (pos_2D.y< 0)          pos_2D.y= pic.height;
    if (pos_2D.y> pic.height) pos_2D.y=0;
  }
  
  
  
  //return position with display size
  Vec2 position_2D(PVector effectPosition, PImage pic) {
    Vec2 dir_2D = norm_dir("DEG",effectPosition.x) ;

    new_pos_2D = pos_2D.copy() ;
    
    direction_2D = Vec2 (  1.0 *dir_2D.x *effectPosition.y  + random(-effectPosition.z, effectPosition.z) ,
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