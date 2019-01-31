/**
ROPE SVG
v 1.4.0
* Copyleft (c) 2014-2018
Rope – Romanesco Processing Environment – 
* @author Stan le Punk
* @see https://github.com/StanLepunK/SVG_Vertex-Processing
  2016-2018
*/

class ROPE_svg {
  PApplet p5  ;
  //
  PShape shape_SVG ;
  String path = "" ;
  String folder_brick_name = "brick" ;
  ArrayList<Brick_SVG> list_brick_SVG = new ArrayList<Brick_SVG>() ;
  String name = "" ;
  String header_svg = "" ;
  int ID_brick ;
  private String saved_path_bricks_svg = "" ;

  private boolean position_center = false ;
  
  private boolean bool_scale_translation ; 
  private boolean bool_pos, bool_jitter_svg, bool_scale_svg ;
  private boolean keep_change ;

  private boolean display_fill_original = true ;
  private boolean display_stroke_original = true ;
  private boolean display_thickness_original = true ;

  private boolean display_fill_custom = false ;
  private boolean display_stroke_custom = false ;
  private boolean display_thickness_custom = false ;

  private vec3 pos = vec3() ;
  private vec3 jitter_svg = vec3() ;
  private vec3 scale_svg = vec3() ;

  // Aspect default
  private String [] st ;
  private vec4 fill_custom = vec4(0,0,0,g.colorModeA) ;
  private vec4 stroke_custom = vec4(g.colorModeX,g.colorModeY,g.colorModeZ,g.colorModeA) ;
  private float thickness_custom = 1 ;

  private vec4 fill_factor = vec4(1) ;
  private vec4 stroke_factor = vec4(1) ;






  /**  
  CONSTRUCTOR

  */
  ROPE_svg (PApplet p5, String path, String folder_brick_name) {
    this.p5 = p5 ;
    this.name = file_name(path) ;
    this.folder_brick_name = folder_brick_name ;
    this.path = path ;
    saved_path_bricks_svg = "RPE_SVG/" + folder_brick_name + "/" ;
  }

  ROPE_svg (PApplet p5, String path) {
    this.p5 = p5 ;
    this.name = file_name(path) ;
    this.path = path ;
    saved_path_bricks_svg = "RPE_SVG/" + folder_brick_name + "/" ;
  }



  

  
  








  /**
  PUBLIC METHOD

  */
  public void build(String path_import, String path_brick) {
    list_brick_SVG.clear() ;
    list_ellipse_SVG.clear() ;
    list_rectangle_SVG.clear() ;
    list_vertice_SVG.clear() ;

    shape_SVG = loadShape(path_import) ;

    XML svg_info = loadXML(path_import) ;
    analyze_SVG(svg_info) ;
    save_brick_SVG() ;
    build_SVG(list_brick_SVG, path_brick) ;

  }

  public void build() {
    build(path, saved_path_bricks_svg) ;
  } 






  
  /**
  METHOD to draw all the SVG
  */
  public void draw() {
    reset() ;
    draw_SVG (pos, scale_svg, jitter_svg) ;
    change_boolean_to_false() ;
  }
  
  public void draw(int ID) {
    reset() ;
    draw_SVG (pos, scale_svg, jitter_svg, ID) ;
    change_boolean_to_false() ;
  }


  public void draw(String layer_or_group_name) {
    reset() ;
    vec3 new_pos = pos.copy() ;
    if(bool_scale_translation) {
      start_matrix() ;
      vec3 translation = vec3() ;
      translation = scale_translation(scale_svg, layer_or_group_name); 
      translate(translation) ;
    }
    draw_SVG (pos, scale_svg, jitter_svg, layer_or_group_name) ;

    if(bool_scale_translation) stop_matrix() ;

    change_boolean_to_false() ;
  }


  private vec3 scale_translation(vec3 scale_svg, String layer_name) {
    vec3 translation = vec3() ;

    int num = 0 ;
    vec3 correction = vec3() ;
    for(int i = 0 ; i < list_brick_SVG.size() ; i++) {
      Brick_SVG b = (Brick_SVG) list_brick_SVG.get(i) ;
      if( b.family_name.contains(layer_name)) {
        // catch position before the scaling
        for(int k = 0 ; k < list_svg_vec(b.ID).length ; k++) {
          num++ ;
          // special translate for the shape kind rect, because this one move from the corner
          if(b.kind == "rect") {
             float width_rect = b.xml_brick.getChild(0).getFloat("width") ;
             float height_rect = b.xml_brick.getChild(0).getFloat("height") ;
             correction.set(width_rect *.5, height_rect *.5, 0) ;
           }
        }
      }
    }

    vec3 [] list_raw = new vec3[num] ;
    for(int i = 0 ; i < list_brick_SVG.size() ; i++) {
      Brick_SVG b = (Brick_SVG) list_brick_SVG.get(i) ;
      if( b.family_name.contains(layer_name)) {
        // catch position before the scaling
        for(int k = 0 ; k < list_svg_vec(b.ID).length ; k++) {
          list_raw[k] = list_svg_vec(b.ID)[k].copy()  ;
        }
      }
    }

    // result
    vec3 barycenter = barycenter(list_raw) ;
    if(position_center) {
      vec3 center_pos = vec3(canvas().x,canvas().y, 0) ;
      center_pos.mult(.5) ;
      barycenter.sub(center_pos) ;
    }
    if(!correction.equals(0)) barycenter.add(correction);
    vec3 barycenter_translated = mult(barycenter, scale_svg) ;
    translation = sub(barycenter, barycenter_translated) ;

    return translation ;
  }


  
  /**
  TEMPORARY CHANGE
  This change don't modify the original coord of point
  */

 /**
 POS
 */
  public void pos(float x) {
    bool_pos = true ;
    pos.set(x) ;
  }

  public void pos(float x, float y) {
    bool_pos = true ;
    pos.set(x,y,0) ;
  }

  public void pos(float x, float y, float z) {
    bool_pos = true ;
    pos.set(x,y,z) ;
  }

  public void pos(vec pos_raw) {
    bool_pos = true ;
    if(pos_raw instanceof vec2) {
      vec2 pos_2D = (vec2) pos_raw ;
      pos.set(pos_2D.x, pos_2D.y, 0) ;
    } else if (pos_raw instanceof vec3) {
      vec3 pos_3D = (vec3) pos_raw ;
      pos.set(pos_3D) ;
    }
  }

  /**
  SCALE
  */
  // scale_translation
  private void scaling(float x) {
    scaling(false, vec3(x,x,0)) ;
  }

  private void scaling(float x, float y) {
    scaling(false, vec3(x,y,0)) ;
  }

  private void scaling(float x, float y, float z) {
    scaling(false, vec3(x,y,z)) ;
  }

  private void scaling(vec scale_raw) {
    scaling(false, scale_raw) ;
  }

  private void scaling(boolean translation, float x) {
    scaling(translation, vec3(x,x,0)) ;
  }

  private void scaling(boolean translation, float x, float y) {
    scaling(translation, vec3(x,y,0)) ;
  }

  private void scaling(boolean translation, float x, float y, float z) {
    scaling(translation, vec3(x,y,z)) ;
  }

  private void scaling(boolean translation, vec scale_raw) {
    bool_scale_translation = translation ;
    bool_scale_svg = true ;
    if(scale_raw instanceof vec2) {
      vec2 scale = (vec2) scale_raw ;
      scale_svg.set(scale.x, scale.y, 1) ;
    } else if (scale_raw instanceof vec3) {
      vec3 scale = (vec3) scale_raw ;
      scale_svg.set(scale) ;
    }
  }



  /**
  JITEER 
  */
  public void jitter(float x) {
    bool_jitter_svg = true ;
    jitter_svg.set(x) ;
  }

  public void jitter(int x, int y) {
    bool_jitter_svg = true ;
    jitter_svg.set(x,y,0) ;
  }

  public void jitter(int x, int y, int z) {
    bool_jitter_svg = true ;
    jitter_svg.set(x,y,z) ;
  }

  public void jitter(vec jitter_raw) {
    bool_jitter_svg = true ;
    if(jitter_raw instanceof vec2) {
      vec2 jitter = (vec2) jitter_raw ;
      jitter_svg.set(jitter.x, jitter.y, 0) ;
    } else if (jitter_raw instanceof vec3) {
      vec3 jitter = (vec3) jitter_raw ;
      jitter_svg.set(jitter) ;
    }
  }

  
  
  
  /* 
  method start() & end() use in correlation with reset for the change like jitter, pos, scale...
  when the svg is using in split mode with name or ID param
  */
  public void start() {
    keep_change = true ;
  }
  public void stop() {
    keep_change = false ;
    reset() ;
  }


  /**
  ASPECT
  v 0.2.0
  */
  /**
  opacity
  */
  public void opacity(float a_fill, float a_stroke) {
    display_stroke_original = true ;
    display_stroke_custom = false ;
    display_fill_original = true ;
    display_fill_custom = false ;
    float normalize_alpha_fill = (a_fill / g.colorModeA) ;
    float normalize_alpha_stroke = (a_stroke / g.colorModeA) ;
    this.fill_factor(1, 1, 1, normalize_alpha_fill) ;
    this.stroke_factor(1, 1, 1, normalize_alpha_stroke) ;

  }

  public void opacityStroke(float a) {
    display_stroke_original = true ;
    display_stroke_custom = false ;
    float normalize_alpha = (a / g.colorModeA) ;
    this.stroke_factor(1, 1, 1, normalize_alpha) ;
  }
    public void opacityFill(float a) {
    display_fill_original = true ;
    display_fill_custom = false ;
    float normalize_alpha = (a / g.colorModeA) ;
    this.fill_factor(1, 1, 1, normalize_alpha) ;
  }
  
  /**
  fill
  */

  public void noFill() {
    display_fill_original = false ;
    display_fill_custom = true ;
    fill_custom.set(0) ;
  }
  
  public void fill(int c) {
    display_fill_original = false ;
    display_fill_custom = true;
    if(g.colorMode == 1 ) fill_custom.set(red(c),green(c),blue(c),alpha(c));
    else if(g.colorMode == 3) fill_custom.set(hue(c),saturation(c),brightness(c),alpha(c));
  }

  public void fill(float value) {
    display_fill_original = false ;
    display_fill_custom = true ;
    fill_custom.set(value,value,value, g.colorModeA) ;
  }

  public void fill(float value, float alpha) {
    display_fill_original = false ;
    display_fill_custom = true ;
    fill_custom.set(value,value,value, alpha) ;
  }

  public void fill(float x, float y, float z) {
    display_fill_original = false ;
    display_fill_custom = true ;
    fill_custom.set(x, y, z, g.colorModeA) ;
  }
  
  public void fill(float x, float y, float z, float a) {
    display_fill_original = false ;
    display_fill_custom = true ;
    fill_custom.set(x,y,z,a) ;
  }

  public void fill(vec v) {
    display_fill_original = false ;
    display_fill_custom = true ;
    if(v instanceof vec2) {
      vec2 v2 = (vec2) v ;
      fill_custom.set(v2.x, v2.x, v2.x, v2.y) ;
    } else if(v instanceof vec3) {
      vec3 v3 = (vec3) v ;
      fill_custom.set(v3.x,v3.y,v3.z, g.colorModeA) ;
    } else if(v instanceof vec3 ) {
      vec4 v4 = (vec4) v ;
      fill_custom.set(v4.x, v4.y, v4.z, v4.w) ;
    }
  }
  /**
  stroke
  */
  public void noStroke() {
    display_stroke_original = false ;
    display_stroke_custom = true ;
    thickness_custom = 0 ;
    stroke_custom.set(0) ;
  }
  
  public void stroke(int c) {
    display_stroke_original = false ;
    display_stroke_custom = true;
    if(g.colorMode == 1 ) stroke_custom.set(red(c),green(c),blue(c),alpha(c));
    else if(g.colorMode == 3) stroke_custom.set(hue(c),saturation(c),brightness(c),alpha(c));
  }

  public void stroke(float value) {
    display_stroke_original = false ;
    display_stroke_custom = true ;
    stroke_custom.set(value, value, value, g.colorModeA) ;
  }

  public void stroke(float value, float a) {
    display_stroke_original = false ;
    display_stroke_custom = true ;
    stroke_custom.set(value, value, value, a) ;
  }

  public void stroke(float x, float y, float z) {
    display_stroke_original = false ;
    display_stroke_custom = true ;
    stroke_custom.set(x, y, z, g.colorModeA) ;
  }

  public void stroke(float x, float y, float z, float a) {
    display_stroke_original = false ;
    display_stroke_custom = true ;
    stroke_custom.set(x,y,z,a) ;
  }


  public void stroke(vec v) {
    display_stroke_original = false ;
    display_stroke_custom = true ;
    if(v instanceof vec2) {
      vec2 v2 = (vec2) v ;
      stroke_custom.set(v2.x, v2.x, v2.x, v2.y) ;
    } else if(v instanceof vec3) {
      vec3 v3 = (vec3) v ;
      stroke_custom.set(v3.x,v3.y,v3.z, g.colorModeA) ;
    } else if(v instanceof vec3 ) {
      vec4 v4 = (vec4) v ;
      stroke_custom.set(v4.x, v4.y, v4.z, v4.w) ;
    }
  }
  /**
  strokeWeight
  */
  public void strokeWeight(float x) {
    display_thickness_original = false ;
    display_thickness_custom = true ;
    thickness_custom = x ;
  }


  /**
  original style
  */
  public void original_style(boolean fill, boolean stroke) {
    display_fill_original = fill ;
    display_stroke_original = stroke ;
    display_thickness_original = stroke ;
  }

  public void original_fill(boolean fill) {
    display_fill_original = fill ;
  }

  public void original_stroke(boolean stroke) {
    display_stroke_original = stroke ;
    display_thickness_original = stroke ;
  }
  

  /**
  fill factor
  use value from '0' to '1' is better !
  */
  public void fill_factor(float x, float y, float z, float a) {
    fill_factor.set(x,y,z,a) ;
  }

  public void stroke_factor(float x, float y, float z, float a) {
    stroke_factor.set(x,y,z,a) ;
  }

  public void fill_factor(vec4 f) {
    fill_factor.set(f.x,f.y,f.z,f.a) ;
  }

  public void stroke_factor(vec4 f) {
    stroke_factor.set(f.x,f.y,f.z,f.a) ;
  }

  /**
  PERMANENTE CHANGE
  This change modify the original points
  */
  public void add_def(int target, vec3... value) {
    if(list_brick_SVG.size() > 0) {
      Brick_SVG b = (Brick_SVG) list_brick_SVG.get(target) ;
      if(b.kind == "polygon" || b.kind == "path" || b.kind == "polyline") {
        for(Vertices v : list_vertice_SVG) {
          if(v.ID == b.get_id()) v.add_value(value) ;
        }
      } else if(b.kind == "line") {
        for(Line l : list_line_SVG) {
          if(l.ID == b.get_id()) l.add_value(value) ;
        }
      } else if(b.kind == "circle" || b.kind == "ellipse") {
        for(Ellipse e : list_ellipse_SVG) {
          if(e.ID == b.get_id()) e.add_value(value) ;
        }
      } else if(b.kind == "rect") {
        for(Rectangle r : list_rectangle_SVG) {
          if(r.ID == b.get_id()) r.add_value(value) ;
        }
      } else if(b.kind == "text") {
        for(ROPEText t : list_text_SVG) {
          if(t.get_id() == b.get_id()) t.add_value(value) ;
        }
      } 
    } 
  }
  

  /**
  SVG info
  */

  
  /**
   return quantity of brick 
  */
  public int num_brick() {
    return list_brick_SVG.size() ;
  }
  

  /**
  list
  */
  public vec3 [] list_svg_vec(int target) {
    vec3 [] p = new vec3[1] ;
    p[0] = vec3(2147483647,2147483647,2147483647) ; // it's maximum value of int in 8 bit :)

    if(list_brick_SVG.size() > 0) {
      Brick_SVG b = (Brick_SVG) list_brick_SVG.get(target) ;
      if(b.kind == "polygon" || b.kind == "path" || b.kind == "polyline") {
        for(Vertices v : list_vertice_SVG) {
          if(v.ID == b.ID) return v.vertices() ;
        }
      } else if(b.kind == "line") {
        for(Line l : list_line_SVG) {
          if(l.ID == b.ID) {
            p[0] = l.pos_a ;
            p[1] = l.pos_b ;
            return p ;
          }
        }
      } else if(b.kind == "circle" || b.kind == "ellipse") {
        for(Ellipse e : list_ellipse_SVG) {
          if(e.ID == b.ID) {
            p[0] = e.pos ;
            return p ;
          }
        }
      } else if(b.kind == "rect") {
        for(Rectangle r : list_rectangle_SVG) {
          if(r.ID == b.ID) { 
            p[0] = r.pos ;
            return p ;
          }
        }
      } 
    } else return p ;
    return p ;
  }


  public PVector [] list_svg_PVector(int target) {
    PVector [] p  ;
    vec3 [] temp_list ;
    temp_list = list_svg_vec(target).clone() ;
    int num = temp_list.length ;
    p = new PVector[num] ;
    for(int i = 0 ; i < num ; i++) {
      p[i] = new PVector(temp_list[i].x, temp_list[i].y, temp_list[i].z) ;
    }
    if (p != null) return p ; else return null ;
  }





  /**
  method to return different definition about the brick
  */

  public String folder_brick_name() {
    return folder_brick_name ;
  }


  public String [] brick_name_list() {
    return name_brick_SVG(list_brick_SVG) ;
  }

  public String brick_name(int target) {
    if(list_brick_SVG.size() > 0 && target < list_brick_SVG.size()) {
      Brick_SVG b = (Brick_SVG) list_brick_SVG.get(target) ;
      return b.brick_name ;

    } else return "No idea for this ID !" ;
  }

  public String [] family_brick() {
    return family_brick_SVG(list_brick_SVG) ;
  }

  public String family_brick(int target) {
    if(list_brick_SVG.size() > 0 && target < list_brick_SVG.size()) {
      Brick_SVG b = (Brick_SVG) list_brick_SVG.get(target) ;
      return b.family_name ;

    } else return "No idea for this ID !" ;
  }

  public String [] kind_brick() {
    return kind_brick_SVG(list_brick_SVG) ;
  }
  public String kind_brick(int target) {
    if(list_brick_SVG.size() > 0 && target < list_brick_SVG.size()) {
      Brick_SVG b = (Brick_SVG) list_brick_SVG.get(target) ;
      return b.kind ;

    } else return "No idea for this ID !" ;
  }





  
  




  /**
  Canvas SVG
  */
  public float width() {
    if(shape_SVG != null) {
      return shape_SVG.width ; 
    } else {
      return 0 ;
    }
  }
  public float height() {
    if(shape_SVG != null) { 
      return shape_SVG.height ; 
    } else {
      return 0 ;
    }
  }
  
  public vec2 canvas() {
    if(shape_SVG != null) {
      return vec2(shape_SVG.width, shape_SVG.height) ; 
    } else { 
      return vec2() ;
    }
  }
  
  
  
  
  
  /**
  Canvas brick SVG
  */
  public float width_brick(int target) {
    if(list_brick_SVG.size() > 0 && target <list_brick_SVG.size()) {
      Brick_SVG b_svg = list_brick_SVG.get(target) ;
      return b_svg.width ; 
    } else return 0 ;
  }

  public float height_brick(int target) {
    if(list_brick_SVG.size() > 0 && target <list_brick_SVG.size()) {
      Brick_SVG b_svg = list_brick_SVG.get(target) ;
      return b_svg.height ; 
    } else return 0 ;
  }
  
  public vec2 canvas_brick(int target) {
    if(list_brick_SVG.size() > 0 && target <list_brick_SVG.size()) {
      Brick_SVG b_svg = list_brick_SVG.get(target) ;
      return vec2(b_svg.width, b_svg.height) ;
    } else return vec2() ;
  }










 /**
  SETTING
  */
  public void mode(int mode) {
    // for info CORNER = 0 / CENTER = 3 > Global variable from Processing
    if(mode == 0 ) position_center = false ;
    else if(mode == 3 ) position_center = true ;
    else position_center = false ;
  }
  /**
  // END PUBLIC METHOD


  */
  







  
  
  
  
  
  






  
  
  
  
  
  
  
  
  /**
  PRIVATE METHOD


  */

  /**
  DRAW

  */
  // reset all change to something flat and borring !
  public void reset() {
    if(!keep_change) {
      if(!bool_pos) {
        pos.set(0) ;
      }
      if(!bool_jitter_svg) {
        jitter_svg.set(0) ;
      }
      if(!bool_scale_svg) {
        scale_svg.set(1) ;
      }
    } else {
      original_style(true, true) ;
      fill_factor(1,1,1,1) ;
      stroke_factor(1,1,1,1) ;
    }
  }
  


  private void change_boolean_to_false() {
    bool_pos = false ;
    bool_scale_svg = false ;
    bool_jitter_svg = false ;
    bool_scale_translation = false ;
  }
  /**
  Draw all shape
  */
  // INTERN METHOD 2D
  private void draw_SVG(vec pos_, vec scale_, vec jitter_) {
    for(int i = 0 ; i < list_brick_SVG.size() ; i++) {
      Brick_SVG b = (Brick_SVG) list_brick_SVG.get(i) ;
      draw_final(pos_, scale_, jitter_, b) ;
    }
  }
 
  
  /**
  Draw shape by ID
  */
  // 2D
  private void draw_SVG (vec pos_, vec scale_, vec jitter_, int ID) {
    if(ID < list_brick_SVG.size()) {
      Brick_SVG b = (Brick_SVG) list_brick_SVG.get(ID) ;
      draw_final(pos_, scale_, jitter_, b) ;
    }
  }
   
  
  /**
  Draw shape by name
  */
  // draw all file from shape or group of layer
  // must be factoring is very ligth method :)
  private void draw_SVG (vec pos_, vec scale_, vec jitter_, String layer_name) {
    for(int i = 0 ; i < list_brick_SVG.size() ; i++) {
      Brick_SVG b = (Brick_SVG) list_brick_SVG.get(i) ;
      if( b.family_name.contains(layer_name)) {
        draw_final(pos_, scale_, jitter_, b) ;
      }
    }
  }

  private void draw_final(vec pos_, vec scale_, vec jitter_, Brick_SVG b) {
    if(b.font != null) textFont(b.font) ;
    if(b.size_font != MAX_INT) textSize(b.size_font) ;

    float average_scale = (scale_.x + scale_.y) *.5 ;
    aspect(b, average_scale) ;
    display_shape(b, pos_, scale_, jitter_) ;

  }
  /**
  END DRAW METHOD

  */






  /**
  ASPECT
  */
  private void aspect(Brick_SVG b, float scale_thickness) {
    aspect_original(b, scale_thickness) ;
    aspect_custom() ;
  }

  // super local
  private  void aspect_original(Brick_SVG b, float scale_thickness) {
    if(display_fill_original) {
      b.aspect_fill(fill_factor) ; 
    } else {
      p5.noFill() ;
    }
    if(display_stroke_original && display_thickness_original) {
      b.aspect_stroke(scale_thickness,stroke_factor) ; 
    } else { 
      p5.noStroke() ;
    }
  }

  private  void aspect_custom() {
    if(fill_custom.a > 0 && display_fill_custom && !display_fill_original) {
      p5.fill(fill_custom.r *fill_factor.x, fill_custom.g *fill_factor.y, fill_custom.b *fill_factor.y, fill_custom.a *fill_factor.w) ; 
    }
    if(display_stroke_custom && !display_stroke_original) {
      if(stroke_custom.a > 0 || thickness_custom > 0 ) {
        p5.stroke(stroke_custom.r *stroke_factor.x, stroke_custom.g *stroke_factor.y, stroke_custom.b *stroke_factor.z, stroke_custom.a *stroke_factor.w) ;
        p5.strokeWeight(thickness_custom) ;
      }
    }
    
    if(!display_fill_original && !display_fill_custom) {
      p5.noFill() ;
    }
    if(!display_stroke_original && !display_stroke_custom) {
      p5.noStroke() ;
    }
  }



  
  


































  /**
  BUILD

  */
  /**
  Main display method

  */
  private void display_shape(Brick_SVG b, vec pos_raw, vec scale_raw, vec jitter_raw) {
    if(pos_raw instanceof vec2 && scale_raw instanceof vec2 && jitter_raw instanceof vec2) {
      vec2 pos_temp = (vec2) pos_raw ;
      vec2 scale_temp = (vec2) scale_raw ;
      vec2 jitter_temp = (vec2) jitter_raw ;

      vec3 pos = vec3(pos_temp) ;
      vec3 scale = vec3(scale_temp) ;
      vec3 jitter = vec3(jitter_temp) ;
      display_shape_3D(b, pos, scale, jitter) ;
    } else if (pos_raw instanceof vec3 && scale_raw instanceof vec3 && jitter_raw instanceof vec3) {
      vec3 pos = (vec3) pos_raw ;
      vec3 scale = (vec3) scale_raw ;
      vec3 jitter = (vec3) jitter_raw ;
      display_shape_3D(b, pos, scale, jitter) ;
    }
  }

  private void display_shape_3D(Brick_SVG b, vec3 pos, vec3 scale, vec3 jitter) {
    if(b.kind == "path" || b.kind == "polygon" || b.kind == "polyline") {
      for(Vertices v : list_vertice_SVG) {
        if(v.ID == b.ID) build_path(pos, scale, jitter, v) ;
      }
    } else if(b.kind == "line") {
      for(Line l : list_line_SVG) {
        if(l.ID == b.ID) {
          build_line(pos, scale, jitter, l) ;
        }
      }
    } else if(b.kind == "ellipse" || b.kind == "circle") {
      for(Ellipse e : list_ellipse_SVG) {
        if(e.ID == b.ID) {
          build_ellipse(pos, scale, jitter, e) ;
        }
      }
    } else if(b.kind == "rect") {
      for(Rectangle r : list_rectangle_SVG) {
        if(r.ID == b.ID) {
          build_rectangle(pos, scale, jitter, r) ;
        }
      }
    } else if(b.kind == "text") {
      for(ROPEText t : list_text_SVG) {
        if(t.ID == b.ID) {
          build_text(pos, scale, jitter, t) ;
        }
      }
    }
  }



  /**

  Build SVG brick


  */
  private void build_SVG(ArrayList<Brick_SVG> list, String path_brick) {
    PShape [] children = new PShape[list.size()] ;
    for(int i = 0 ; i < list.size() ; i++) {
      PShape mother = loadShape(path_brick + folder_brick_name + "_" + i + ".svg") ;
      children = mother.getChildren() ;
      /**
      Problem here with P3D and P2D mode
      return null pointer exception with type 'text'
      println(children) ;
      */
      
      Brick_SVG b = (Brick_SVG) list.get(i) ;
      if(b.kind == "polygon" || b.kind == "path" || b.kind == "polyline")  vertex_count(children[0], mother.getName(), b.ID) ;
      if(b.kind == "line")  line_count(b.xml_brick, mother.getName(), b.ID) ;
      else if(b.kind == "circle" || b.kind == "ellipse") ellipse_count(b.xml_brick, b.ID) ;
      else if(b.kind == "rect") rectangle_count(b.xml_brick, b.ID) ;
      else if(b.kind == "text") text_count(b.xml_brick,  b.ID) ;
    }
  }
  
  /**
  TEXT
  */
  // list of group SVG
  ArrayList<ROPEText> list_text_SVG = new ArrayList<ROPEText>() ;
      
  //
  private void text_count(XML xml_shape, int ID) {
    vec6 matrix = matrix_vec(xml_shape) ;
    String sentence = xml_shape.getChild("text").getContent() ;

    ROPEText t = new ROPEText(matrix, sentence, ID) ;
    list_text_SVG.add(t) ;
  }



  

  /**
  Main method to draw text
  */
  void build_text(vec3 pos, vec3 scale, vec3 jitter, ROPEText t) {
    vec3 temp_pos = vec3(t.pos.x, t.pos.y,0)   ;
    // the order of operation is very weird, because is not a same for the build_vertex()
    if(position_center) {
      vec3 center_pos = vec3(canvas().x,canvas().y, 0) ;
      center_pos.mult(.5) ; 
      temp_pos.sub(center_pos) ;
    }
    if(!scale.equals(vec3(1))) {
      temp_pos.mult(scale) ; 
    }
    if(!pos.equals(vec3())) {
      temp_pos.add(pos) ;
    }

    
    if(check_matrix(t.matrix)) {
      start_matrix() ;
      matrix(t.matrix, temp_pos) ;
      text(t.sentence, 0,0) ;
      stop_matrix() ;
    } else {
      // if there is no matrix effect
      text(t.sentence, temp_pos) ;
    }
  }
  /**
  END CIRCLE & ELLIPSE
  */













  /**
  Line
  */
  // list of group SVG
  ArrayList<Line> list_line_SVG = new ArrayList<Line>() ;

  private void line_count(XML xml_shape, String geom_name, int ID) {
    float x_a = xml_shape.getChild(0).getFloat("x1") ;
    float y_a = xml_shape.getChild(0).getFloat("y1") ;
    float x_b = xml_shape.getChild(0).getFloat("x2") ;
    float y_b = xml_shape.getChild(0).getFloat("y2") ;
  
    Line l = new Line(x_a, y_a, x_b, y_b, ID) ;
    list_line_SVG.add(l) ;
  }
  

  /**
  Main method to draw ellipse
  */
  void build_line(vec3 pos, vec3 scale, vec3 jitter, Line l) {
    vec3 temp_pos_a = vec3(l.pos_a.x, l.pos_a.y,0)  ;
    vec3 temp_pos_b = vec3(l.pos_b.x, l.pos_b.y,0)  ;

  
    // the order of operation is very weird, because is not a same for the build_vertex()
    if(position_center) {
      vec3 center_pos = vec3(canvas().x,canvas().y, 0) ;
      center_pos.mult(.5) ; 
      temp_pos_a.sub(center_pos) ;
      temp_pos_b.sub(center_pos) ;
    }
    if(!scale.equals(vec3(1))) {
      temp_pos_a.mult(scale) ; 
      temp_pos_b.mult(scale) ; 
    }
    if(!pos.equals(vec3())) {
      temp_pos_a.add(pos) ;
      temp_pos_b.add(pos) ;
    }
  
    line(temp_pos_a.mult(scale), temp_pos_b.mult(scale)) ;
  }
  /**
  END CIRCLE & ELLIPSE
  */







  /**
  ELLIPSE & CIRCLE
  */
  // list of group SVG
  ArrayList<Ellipse> list_ellipse_SVG = new ArrayList<Ellipse>() ;

  private void ellipse_count(XML xml_shape, int ID) {
    vec6 matrix = matrix_vec(xml_shape) ;
    float r = xml_shape.getChild(0).getFloat("r") ;
    float rx = (float)xml_shape.getChild(0).getFloat("rx") ;
    float ry = (float)xml_shape.getChild(0).getFloat("ry") ;
    float cx = xml_shape.getChild(0).getFloat("cx") ;
    float cy = xml_shape.getChild(0).getFloat("cy") ;
    if(r > 0 ) rx = ry = r ;
  
    Ellipse e = new Ellipse(matrix, cx, cy, rx, ry, ID) ;
    list_ellipse_SVG.add(e) ;
  }
  

  /**
  Main method to draw ellipse
  */
  void build_ellipse(vec3 pos, vec3 scale, vec3 jitter, Ellipse e) {
    vec3 temp_pos = vec3(e.pos.x, e.pos.y,0)  ;

  
    // the order of operation is very weird, because is not a same for the build_vertex()
    if(position_center) {
      vec3 center_pos = vec3(canvas().x,canvas().y, 0) ;
      center_pos.mult(.5) ; 
      temp_pos.sub(center_pos) ;
    }
    if(!scale.equals(vec3(1))) temp_pos.mult(scale) ; 
    if(!pos.equals(vec3())) temp_pos.add(pos) ;
  
    vec2 temp_size = e.size.copy() ;

    if(check_matrix(e.matrix)) {
      start_matrix() ;
      matrix(e.matrix, temp_pos) ;
      ellipse(vec2(0), temp_size.mult(scale.x, scale.y)) ;
      stop_matrix() ;
    } else {
      // if there is no matrix effect
      ellipse(temp_pos, temp_size.mult(scale.x, scale.y)) ;
    }

    
  }
  /**
  END CIRCLE & ELLIPSE
  */
  



  /**
  RECTANGLE
  */
  // list of group SVG
  private ArrayList<Rectangle> list_rectangle_SVG = new ArrayList<Rectangle>() ;
  
  private void rectangle_count(XML xml_shape, int ID) {
    vec6 matrix = matrix_vec(xml_shape) ;
    float x = xml_shape.getChild(0).getFloat("x") ;
    float y = xml_shape.getChild(0).getFloat("y") ;
    float width_rect = xml_shape.getChild(0).getFloat("width") ;
    float height_rect = xml_shape.getChild(0).getFloat("height") ;
  
    Rectangle r = new Rectangle(matrix, x, y, width_rect, height_rect, ID) ;
    list_rectangle_SVG.add(r) ;
  }
  
  /**
  Main method to draw ellipse
  */
  
  private void build_rectangle(vec3 pos, vec3 scale, vec3 jitter, Rectangle r) {
    vec3 temp_pos = vec3(r.pos.x, r.pos.y,0)  ;
  
    // the order of operation is very weird, because is not a same for the build_vertex()
    if(position_center) {
      vec3 center_pos = vec3(canvas().x,canvas().y, 0) ;
      center_pos.mult(.5) ; 
      temp_pos.sub(center_pos) ;
    }
    if(!scale.equals(vec3(1))) temp_pos.mult(scale) ; 
    if(!pos.equals(vec3())) temp_pos.add(pos) ;
  
    vec2 temp_size = r.size.copy() ;

    if(check_matrix(r.matrix)) {
      start_matrix() ;
      matrix(r.matrix, temp_pos) ;
      vec2 pos_def = vec2() ;
      // pos_def.x += (temp_size.x *.5) ;
      // pos_def.y += (temp_size.y *.5) ;
      // pos_def.x += mouseX ;
      // pos_def.y += mouseY ;
      printTempo(60, pos_def) ;
      printTempo(60, "void build_rectangle()") ;
      rect(pos_def, temp_size) ;
      stop_matrix() ;
    } else {
      // if there is no matrix effect
      rect(temp_pos, temp_size.mult(scale.x, scale.y)) ;
    }
  }
  /**
  END RECTANGLE
  */
  

  











  /**
  VERTEX


  */
  /**
  Build
  */
  // list of group SVG
  private ArrayList<Vertices> list_vertice_SVG = new ArrayList<Vertices>() ;
  // here we must build few object for each group, but how ?
  private vec3 [] vert ;
  private int [] vertex_code ;
  private int code_vertex_count ;
  
  private void vertex_count(PShape geom_shape, String geom_name, int ID) {
    int num = geom_shape.getVertexCount() ;
    vertex_code = new int[num] ;
    vert = new vec3[num] ;
    vertex_code = geom_shape.getVertexCodes() ;
    code_vertex_count = geom_shape.getVertexCodeCount() ;
    
    Vertices v = new Vertices(code_vertex_count, num, geom_shape, geom_name, ID) ;
    v.build_vertices_3D(geom_shape) ;
    list_vertice_SVG.add(v) ;
  }
  /**
  END VERTEX
  */
 
  




  /**
  Draw Vertice
  adapted from Processing PShape drawPath for the vertex
  https://github.com/processing/processing/blob/master/core/src/processing/core/PShape.java
  line 1700 and the dust !
  */


  private void build_path(vec3 pos, vec3 scale, vec3 jitter, Vertices v) {
    vec3 center_pos = vec3(canvas().x,canvas().y,0) ;
    center_pos.mult(.5) ; 
    if(!scale.equals(vec3(1))) center_pos.mult(scale) ; 
  
    if (v.vert == null) return;
  
    boolean insideContour = false;
    beginShape();
    // for the simple vertex
    if (v.code_vertex_count == 0) {  
      for (int i = 0; i <  v.vert.length; i++) {
        vec3 temp_pos_a = v.vert[i].copy() ;
        //
        if(!scale.equals(vec3(1))) temp_pos_a.mult(scale) ;
        //
        if(!jitter.equals(vec3())) {
          vec3 jitter_pos = vec3().jitter((int)jitter.x,(int)jitter.y,(int)jitter.z) ;
          temp_pos_a.add(jitter_pos) ;
        }
        //
        if(position_center) temp_pos_a.sub(center_pos) ;
        //
        if(!pos.equals(vec3())) temp_pos_a.add(pos) ;
        //
        vertex(temp_pos_a);
      }
    // for the complex draw vertex, with bezier, curve...
    } else {  
      int index = 0;
      for (int j = 0; j < v.code_vertex_count; j++) {
        vec3 temp_pos_a , temp_pos_b, temp_pos_c ;
  
        switch (v.vertex_code[j]) {
          //----------
          case VERTEX:
          temp_pos_a = v.vert[index].copy() ;
          //
          if(!scale.equals(vec3(1))) temp_pos_a.mult(scale) ;
          //
          if(!jitter.equals(vec3())) {
            vec3 jitter_pos = vec3().jitter((int)jitter.x,(int)jitter.y,(int)jitter.z) ;
            temp_pos_a.add(jitter_pos) ;
          }
          //
          if(position_center) temp_pos_a.sub(center_pos) ;
          //
          if(!pos.equals(vec3())) temp_pos_a.add(pos) ;
          //
          vertex(temp_pos_a);
          index++;
          break;
        // QUADRATIC_VERTEX
          case QUADRATIC_VERTEX:
          temp_pos_a = v.vert[index].copy() ;
          temp_pos_b = v.vert[index +1].copy() ;
          //
          if(!scale.equals(vec3(1))) {
            temp_pos_a.mult(scale) ;
            temp_pos_b.mult(scale) ;
          }
          //
          if(!jitter.equals(vec3())) {
            vec3 jitter_pos = vec3().jitter((int)jitter.x,(int)jitter.y,(int)jitter.z) ;
            temp_pos_a.add(jitter_pos) ;
            jitter_pos = vec3().jitter((int)jitter.x,(int)jitter.y,(int)jitter.z) ;
            temp_pos_b.add(jitter_pos) ;
          }
          //
          if(position_center) {
            temp_pos_a.sub(center_pos) ;
            temp_pos_b.sub(center_pos) ;
          }
          //
          if(!pos.equals(vec3())) {
            temp_pos_a.add(pos) ;
            temp_pos_b.add(pos) ;
          }
          //
          quadraticVertex(temp_pos_a, temp_pos_b);
          index += 2;
          break;
          // BEZIER_VERTEX
          case BEZIER_VERTEX:
          temp_pos_a = v.vert[index].copy() ;
          temp_pos_b = v.vert[index +1].copy() ;
          temp_pos_c = v.vert[index +2].copy() ;
          //
          if(!scale.equals(vec3(1))) {
            temp_pos_a.mult(scale) ;
            temp_pos_b.mult(scale) ;
            temp_pos_c.mult(scale) ;
          }
          //
          if(!jitter.equals(vec3())) {
            vec3 jitter_pos = vec3().jitter((int)jitter.x,(int)jitter.y,(int)jitter.z) ;
            temp_pos_a.add(jitter_pos) ;
            jitter_pos = vec3().jitter((int)jitter.x,(int)jitter.y,(int)jitter.z) ;
            temp_pos_b.add(jitter_pos) ;
            jitter_pos = vec3().jitter((int)jitter.x,(int)jitter.y,(int)jitter.z) ;
            temp_pos_c.add(jitter_pos) ;
          }
          //
          if(position_center) {
            temp_pos_a.sub(center_pos) ;
            temp_pos_b.sub(center_pos) ;
            temp_pos_c.sub(center_pos) ;
          }
          //
          if(!pos.equals(vec3())) {
            temp_pos_a.add(pos) ;
            temp_pos_b.add(pos) ;
            temp_pos_c.add(pos) ;
          }
          //
          bezierVertex(temp_pos_a, temp_pos_b, temp_pos_c);
          index += 3;
          break;
          // CURVE_VERTEX
          case CURVE_VERTEX:
          temp_pos_a = v.vert[index].copy() ;
          //
          if(!scale.equals(vec3(1))) temp_pos_a.mult(scale) ;
          //
          if(!jitter.equals(vec3())) {
            vec3 jitter_pos = vec3().jitter((int)jitter.x,(int)jitter.y,(int)jitter.z) ;
            temp_pos_a.add(jitter_pos) ;
          }
          //
          if(position_center) temp_pos_a.sub(center_pos) ;
          //
          if(!pos.equals(vec3())) temp_pos_a.add(pos) ;
          //
          curveVertex(temp_pos_a);
          index++;
          break;
          // BREAK
          case BREAK:
          if (insideContour) {
            endContour();
          }
          beginContour();
          insideContour = true;
        }
      }
    }
    if (insideContour) {
      endContour();
    }
    // endShape(CLOSE);
    endShape();
  }
  /**
  END BUILD

  */
























  /** 
  MATRIX 
  transformation

  */

  private vec6 matrix_vec(XML xml_shape) {
    if(xml_shape.getChild(0).getString("transform") != null) {
      String matrix = xml_shape.getChild(0).getString("transform") ;
      if(matrix.startsWith("matrix(")) {
        matrix = matrix.substring(6) ;
      }
      if(matrix.endsWith(")")) {
        matrix = matrix.substring(1, matrix.length() -1) ;
      }
      String [] transform = split(matrix," ") ;
      /**
      more about matrix 3x3 > 6
      https://www.w3.org/TR/SVG/coords.html#TransformMatrixDefined
      */

      float a = Float.parseFloat(transform[0] );
      float b = Float.parseFloat(transform[1] );
      float c = Float.parseFloat(transform[2] );
      float d = Float.parseFloat(transform[3] );

      float e = Float.parseFloat(transform[4] );
      float f = Float.parseFloat(transform[5] );
      vec6 m = vec6(a,b,c,d,e,f) ;
      return m ;
    } else return null ;
  }




  private boolean check_matrix(vec6 matrix) {
    if(matrix != null) {
      float a = matrix.a ;
      float b = matrix.b ;
      float c = matrix.c ;
      float d = matrix.d ;
      if(a == 1 && b == 0 && c == 0 && d == 1) {
        return false ; 
      } else return true ;
    } else return false ;
  }



  private void matrix(vec6 matrix, vec3 pos) {
    float a = matrix.a ;
    float b = matrix.b ;
    float c = matrix.c ;
    float d = matrix.d ;
    // about matrix 
    // http://stackoverflow.com/questions/4361242/extract-rotation-scale-values-from-2d-transformation-matrix
    boolean matrix_bool = false ;
    boolean rotate_bool = false ;
    boolean scale_bool = false ;
    boolean skew_bool = false ;


    if(a == 1 && b == 0 && c == 0 && d == 1) {
      matrix_bool = false ;
      rotate_bool = false ;
      scale_bool = false ;
      skew_bool = false ;
    } else {
      // run matrix
      matrix_bool = true ;

      boolean rotate_case = false ;
      boolean scale_case = false ;
      boolean skew_case = false ;
      if(abs(a) == abs(d) && abs(c) == abs(b)) rotate_case = true ;
      if(a != 1 && b == 0 && c == 0 &&  abs(a) != abs(d)) scale_case = true ;
      if(a < 1 && b > -1 && c < 1 && d < 1) skew_case = true ;

      // rotate case
      if(rotate_case) {
        rotate_bool = true ;
        scale_bool = false ;
        skew_bool = false ;
      // scale case
      } else if(scale_case) {
        rotate_bool = false ;
        scale_bool = true ;
        skew_bool = false ;
      } else if ((a < -1 || a > 1) && (b < -1 || b > 1)) {
        scale_bool = true ;
        rotate_bool = true ;
        skew_bool = false ;
      }
      // skew case
      if(skew_case && !rotate_case && (a != 1 && b != 0 && c != 0 && d != 1) ) {
        skew_bool = true ;
      }
    }

    /**
    matrix case
    */
    if(matrix_bool) {
      float angle = atan(-matrix.b / matrix.a) ; 

      // rotate
      if(rotate_bool && !scale_bool && !skew_bool) {
        translate(pos) ;
        if(d <= 0 ) {
          angle = angle + PI ;
        }
        rotate(-angle) ;
      }

      // scale
      if(scale_bool && !rotate_bool && !skew_bool) {
        float sx = sqrt((a * a) + (c * c)) ;
        if(a < 0 || c < 0) {
          sx *= -1 ;
        }
        float sy = sqrt((b * b) + (d * d)) ;
        if(b < 0 || d < 0) {
          sy *= -1 ;
        }

        translate(pos.x, pos.y) ;
        scale(sx, sy) ;
      }

      // scale and rotate
      if(scale_bool && rotate_bool && !skew_bool) {
        // rotation
        if(d <= 0 ) {
          angle += PI ;
        }
        // scale
        float sx_1 = a / cos(angle) ;
        float sx_2 = -c / sin(angle) ;
        float sy_1 = b / sin(angle) ;
        float sy_2 = d / cos(angle) ;
        
        translate(pos) ;
        rotate(-angle) ;
        scale(sx_1, sy_2) ;
      }
      
      // SKEW
      // skew / shear is rotate/scale and skew in same time 
      // skew take the lead on every thing, I believe but not sure
      
      // this alpgorithm is not really good, very approximative :(
      
      if(skew_bool && !rotate_bool && !scale_bool) {
        // calcule the angle for skew-scaling
        // scale
        float sx_1 = a / cos(angle) ;
        float sx_2 = -c / sin(angle) ;
        float sy_1 = b / sin(angle) ;
        float sy_2 = d / cos(angle) ;

        translate(pos) ;

        shearX(c) ;
        shearY(b) ;
        scale(sx_1, sy_2) ;
        
      }
    }
  }

  /**

  END MATRIX

  */
























  /**
  EXTRACT POINT
  
  */
  
  private void extract(Vertices v) {
    if (v.vert == null) return;
    if (v.code_vertex_count == 0) {  
      for (int i = 0; i <  v.vert.length; i++) {
        vec3 temp_pos_a = v.vert[i].copy() ;
        vertex(temp_pos_a);
      }
    // for the complex draw vertex, with bezier, curve...
    } else {  
      int index = 0;
      for (int j = 0; j < v.code_vertex_count; j++) {
        vec3 temp_pos_a , temp_pos_b, temp_pos_c ;
        switch (v.vertex_code[j]) {
          case VERTEX:
          temp_pos_a = v.vert[index].copy() ;
          vertex(temp_pos_a);
          index++;
          break;
          // QUADRATIC_VERTEX
          case QUADRATIC_VERTEX:
          temp_pos_a = v.vert[index].copy() ;
          temp_pos_b = v.vert[index +1].copy() ;
          //
          quadraticVertex(temp_pos_a, temp_pos_b);
          index += 2;
          break;
          // BEZIER_VERTEX
          case BEZIER_VERTEX:
          temp_pos_a = v.vert[index].copy() ;
          temp_pos_b = v.vert[index +1].copy() ;
          temp_pos_c = v.vert[index +2].copy() ;
          //
          bezierVertex(temp_pos_a, temp_pos_b, temp_pos_c);
          index += 3;
          break;
          // CURVE_VERTEX
          case CURVE_VERTEX:
          temp_pos_a = v.vert[index].copy() ;
          curveVertex(temp_pos_a);
          index++;
          break;
          // BREAK
          case BREAK:
        }
      }
    }
  }






  /**
  INFO

  */
  public String [] name_brick_SVG (ArrayList<Brick_SVG> list_brick) {
    String [] list ;
    if(list_brick.size() > 0 ) {
      list = new String[list_brick.size()] ;
      for (int i = 0 ; i < list.length ; i++) {
        Brick_SVG b_svg = list_brick.get(i) ;
        list[i] = b_svg.brick_name ;
      }
      return list ;
    } else {
      list = new String[1] ;
      list[0] = "no item in the list" ;
      return list ;
    }
  }
  
  public String [] kind_brick_SVG (ArrayList<Brick_SVG> list_brick) {
    String [] list ;
    if(list_brick.size() > 0 ) {
      list = new String[list_brick.size()] ;
      for (int i = 0 ; i < list.length ; i++) {
        Brick_SVG b_svg = list_brick.get(i) ;
        list[i] = b_svg.kind ;
      }
      return list ;
    } else {
      list = new String[1] ;
      list[0] = "no item in the list" ;
      return list ;
    }
  }
  
  public String [] family_brick_SVG (ArrayList<Brick_SVG> list_brick) {
    String [] list ;
    if(list_brick.size() > 0 ) {
      list = new String[list_brick.size()] ;
      for (int i = 0 ; i < list.length ; i++) {
        Brick_SVG b_svg = list_brick.get(i) ;
        list[i] = b_svg.family_name ;
      }
      return list ;
    } else {
      list = new String[1] ;
      list[0] = "no item in the list" ;
      return list ;
    }
  }
  /**
  END INFO

  */
  

  


















  
  
  /**
  ANALYZE

  */
  private void analyze_SVG(XML target) {
    // catch the header to rebuild a SVG as small as possible to use Processing build PShapeSVG of Processing engine
    header_svg = catch_header_SVG(target) ;


    ID_brick = 0 ;
    String primal_name =("") ;
    String primal_opacity = ("none") ;

    /**
    work in progress for ordering shape




    */
    
    /**



    */
    // style for SVG version 2
    XML [] svg_style = target.getChildren("style") ;

    if(svg_style.length > 0) {
      // new SVG 1.1 version 2
      build_array_style(svg_style[0]) ;
      deep_analyze_SVG(header_svg, true, target, primal_name, primal_opacity) ;

    } else {
      // old SVG
      XML no_style = new XML ("no_style") ;
      deep_analyze_SVG(header_svg, false, target, primal_name, primal_opacity) ;
    }
  }




  private void build_array_style(XML style) {
    String string_style = style.toString() ;
    String [] st_temp = split(string_style,".st") ;
    // remove the first element of the array and the first occurence of each element
    st = new String[st_temp.length -1] ;
    for(int i = 0 ; i < st.length ;i++) {
      st[i] = "st"+ st_temp[i+1] ;
      if(st[i].contains("st"+i)) {
        st[i] = st[i].replaceAll("st"+i, "") ;
      }
    }
    // remove the word style from the last array String
    if(st[st.length -1].contains("</style>")) {
      st[st.length -1] = st[st.length -1].replaceAll("</style>","") ;
    }
  }
  
  private void save_brick_SVG() {
    /* here in the future :
    Save name of SVG, width, height and other global properties
    */
    for(int i = 0 ; i < list_brick_SVG.size() ; i++) {
      Brick_SVG shape = (Brick_SVG) list_brick_SVG.get(i) ;
      saveXML(shape.xml_brick,  saved_path_bricks_svg + folder_brick_name + "_" + i + ".svg") ;
    }
  }

  
  
  
  // Local method
  int rank_analyze = 0 ;
  private void deep_analyze_SVG(String header, boolean style, XML target, String ancestral_name, String opacity_group) {
    rank_analyze ++ ;
    String ID_xml =("") ;
    ID_xml = get_kind_SVG(target) ;

    String [] children_str = target.listChildren() ;
    XML [] children_xml = target.getChildren() ;
    // split XML children



    // build brick XML
    for(int i = 0 ; i < children_xml.length ; i++) {
      if( children_str[i].equals("rect") 
          || children_str[i].equals("line") 
          || children_str[i].equals("polyline") 
          || children_str[i].equals("circle") 
          || children_str[i].equals("ellipse") 
          || children_str[i].equals("polygon") 
          || children_str[i].equals("path")
          || children_str[i].equals("text")
          ) {
        if(check_kind_SVG(children_xml[i])) {
          add_brick_SVG(header_svg, style, children_xml[i], ancestral_name, opacity_group) ;
        }
      } else if(children_str[i].equals("g") ) {
        String new_name = ancestral_name + children_xml[i].getString("id") ;
        if(!style) if(opacity_group == null || opacity_group == "none")  opacity_group = children_xml[i].getString("opacity") ;
        deep_analyze_SVG(header, style, children_xml[i], new_name, opacity_group) ;
      } 
    }
  }
  
  
  
  private void add_brick_SVG(String header, boolean style, XML target_brick, String ancestral_name, String opacity_group) {
    String name = target_brick.getName() ;
    if( name != null && ( name.equals("rect")
                         || name.equals("line")
                         || name.equals("polyline")
                         || name.equals("circle")
                         || name.equals("ellipse")
                         || name.equals("polygon")
                         || name.equals("path"))
                         || name.equals("text")
      ) {
      catch_brick_shape(header, style, target_brick, ancestral_name, opacity_group) ;
    }
  }
    




  /**
  CATCH INFO 
  */
  private String catch_header_SVG(XML target) {
    String s = "" ;
    String string_to_split = target.toString() ;
    String [] part = string_to_split.split("<") ;
    s = "<"+part[1] ;
    return s ;
  }
  
  
  private void catch_brick_shape(String header, boolean style, XML target, String ancestral_name, String opacity_group) {
    Brick_SVG new_brick = new Brick_SVG(header, style, target, ID_brick, ancestral_name, opacity_group) ;
    list_brick_SVG.add(new_brick) ;
    ID_brick++ ;
  }
  /**
  CHECK INFO
  */  
  private boolean check_kind_SVG(XML target_brick) {
    String kind_name = target_brick.getName() ;
    if(kind_name.equals("path")
       || kind_name.equals("rect") 
       || kind_name.equals("line") 
       || kind_name.equals("polyline") 
       || kind_name.equals("polygon")
       || kind_name.equals("circle")
       || kind_name.equals("ellipse")
       || kind_name.equals("text")
       ) {
      return true ;
    } else {
      return false ;
    }
  }

  private boolean check_g_shape(XML target) {
    boolean result = false ;
    if(target.getChild("g")!= null ) result = true ;
    else result = false ;
    return result ;

  }
  /**
  GET
  */
  private String get_kind_SVG(XML target) {
    String kind = "" ;
    if(target.getChild("path") != null ) kind = "path" ;
    else if(target.getChild("line")!= null ) kind = "line" ;
    else if(target.getChild("polyline")!= null ) kind = "polyline" ;
    else if(target.getChild("polygon")!= null ) kind = "polygon" ;
    else if(target.getChild("circle")!= null )kind = "circle" ;
    else if(target.getChild("ellipse")!= null ) kind = "ellipse" ;
    else if(target.getChild("rect")!= null ) kind = "rect" ;
    else if(target.getChild("text")!= null ) kind = "text" ;
    else if(target.getChild("g")!= null ) kind = "g" ;
    else kind = "no kind detected" ;
    return kind ;
  }
  /**
  END ANALYZE

  */
  
  






























  
  /**
  PRIVATE CLASS
  
  */
  /**
  class brick
  */
  private class Brick_SVG {
    private String file_name ;
    private String brick_name = "no name" ;
    private String family_name = "no name" ;
    private String kind = "" ;
    private int ID ;


    // attribut font
    /**
    may be not here but in the class Text with the build method ???
    */
    private PFont font = null  ;
    private float size_font = MAX_INT;
    private int alignment = MAX_INT ;
    // private String sentence = null ;

    private String font_str = null ;
    private String font_size_str = null ;
    private String alignment_str = null ;
    private String font_unit_str = null ;
    /**
    may be not here but in the class Text with the build method ???
    */



    // attribut colour
    private int fill, stroke ;
    private float strokeMitterlimit ;
    private float strokeWeight ;
    private float opacity, opacity_group ;
    private boolean noStroke, noFill ;

    // str
    private String fill_str = null;        
    private String stroke_str = null ;
    private String stroke_mitterlimit_str = null ;
    private String strokeWeight_str = null ;
    private String opacity_str = null ;


    private String clip_rule_str = null ;
    private String fill_rule_str = null ;



    private int width, height ;
    private XML xml_brick ;
    private boolean style ;
    private String built_svg_file = "" ;
   
    Brick_SVG(String header, boolean style, XML brick, int ID, String ancestral_name, String str_opacity_group) {
      this.style = style ;
      this.ID = ID ;
      built_svg_file = header + brick.toString() + "</svg>" ;
      xml_brick = parseXML(built_svg_file) ;
  
      brick_name = get_name(brick) ;
      family_name = ancestral_name + "_" + get_name(xml_brick) ;
      this.kind = get_kind_SVG(xml_brick) ;
      if(str_opacity_group != "none" && str_opacity_group != null) opacity_group = Float.valueOf(str_opacity_group.trim()).floatValue(); else opacity_group = 1. ;
      set_aspect(brick) ;
    }
  
    String get_name(XML target) {
      String name = "no name" ;
      if(target.getString("id") != null) name = target.getString("id") ;
      return name ;
    }

    int get_id() {
      return ID;
    }

    /**
    aspect original
    */
    private void set_aspect(XML target) {
      // catch attribut
      if(style) {
        // style tag from last Illustrator CC
        catch_attribut_by_style(target) ;
      } else {
        // old data from illustrator CS
        catch_attribut(target) ;
      }
      


      // give attribut
      // font size
      if(font_size_str != null) {
        size_font = Float.parseFloat(font_size_str) ;
      }
      // font
      if(font_str != null) {
        String [] fontList = PFont.list() ;
        for(int i = 0 ; i < fontList.length ; i++) {
          if(font_str.equals(fontList[i])) {
            int size = 60 ;
            if(size_font != MAX_INT && size_font > size ) size = (int)size_font ;
            font = createFont(fontList[i], size) ;
          }
        }
      }

      // fill
      if(fill_str == null) {
        fill = #000000 ; 
      } else if(fill_str.contains("none")) {
        noFill = true ;
      } else {
        String fill_temp = "" ;
        fill_temp = fill_str.substring(1) ;
        fill = unhex(fill_temp) ;
      }
      // stroke
      if(stroke_str == null) {
        stroke = MAX_INT ; 
      } else if(stroke_str.contains("none")) {
        noStroke = true ;
      } else {
        String stroke_temp = "" ;
        stroke_temp = stroke_str.substring(1) ;
        stroke = unhex(stroke_temp) ;
      }
      // strokeWeight
      if(strokeWeight_str == null  || strokeWeight_str.contains("none")) strokeWeight = 1. ; 
      else strokeWeight = Float.valueOf(strokeWeight_str.trim()).floatValue();
      // stroke mitter
      if(stroke_mitterlimit_str == null  || stroke_mitterlimit_str.contains("none")) strokeMitterlimit = 10 ; 
      else strokeMitterlimit = Float.valueOf(stroke_mitterlimit_str.trim()).floatValue();
      // opacity
      if(opacity_str == null || opacity_str.contains("none")) opacity = 1. ; 
      else opacity = Float.valueOf(opacity_str.trim()).floatValue();
      if(opacity == 1. && opacity_group != 1.) opacity = opacity_group ;
    }



    // super local method
    //
    // catch attribut classic SVG version 1
    private void catch_attribut(XML target) {
      fill_str =  target.getString("fill") ;        
      stroke_str =  target.getString("stroke") ;
      stroke_mitterlimit_str =  target.getString("stroke-mitterimit") ;
      strokeWeight_str =  target.getString("stroke-width") ;
      opacity_str =  target.getString("opacity") ;

      font_str = target.getString("font-family") ;
      font_size_str = target.getString("font-size") ;

      clip_rule_str = target.getString("clip-rule") ;
      fill_rule_str = target.getString("fill-rule") ;
    }

    // catch attribut style SVG version 2
    private void catch_attribut_by_style(XML target) {
      String style_id = target.getString("class") ;
      // catch the style in the style list
      String [] id = split(style_id, "st") ;
      // clean white space in the String array, because for the class text there is few style, and there is white space between each one.
      if(id.length > 1) {
        for(int i = 0 ; i < id.length ;i++) {
          if(id[i].contains(" ")) id[i] = id[i].replaceAll(" ", "") ;
          if(i != 0) { 
            int which_style = Integer.parseInt(id[i]) ;
            String my_style = st[which_style] ;
            if(my_style.contains("}") ) {
              my_style = my_style.replaceAll("}","") ;
            }
            if(my_style.contains("{")) {
              my_style = my_style.substring(1) ;
            }

            String [] attribut = split(my_style,";") ;
            // loop to check all component of style
            for(int k = 0 ; k < attribut.length ; k++) {
              if(attribut[k].contains("fill:")) {
                String [] final_data = attribut[k].split(":") ;
                fill_str = final_data[1] ;
              }
              if(attribut[k].contains("stroke:")) {
                String [] final_data = attribut[k].split(":") ;
                stroke_str = final_data[1] ;
              }
              if(attribut[k].contains("stroke-mitterlimit:")) {
                String [] final_data = attribut[k].split(":") ;
                stroke_mitterlimit_str = final_data[1] ;
              }
              if(attribut[k].contains("stroke-width:")) {
                String [] final_data = attribut[k].split(":") ;
                strokeWeight_str = final_data[1] ;
              }
              if(attribut[k].contains("opacity:")) {
                String [] final_data = attribut[k].split(":") ;
                opacity_str = final_data[1] ;
              }
              if(attribut[k].contains("font-family:")) {
                String [] final_data = attribut[k].split(":") ;
                font_str = final_data[1] ;
              }
              if(attribut[k].contains("font-size:")) {
                String [] final_data = attribut[k].split(":") ;
                font_size_str = final_data[1] ;
              }
              if(attribut[k].contains("clip-rule:")) {
                String [] final_data = attribut[k].split(":") ;
                clip_rule_str = final_data[1] ;
              }
              if(attribut[k].contains("fill-rule:")) {
                String [] final_data = attribut[k].split(":") ;
                fill_rule_str = final_data[1] ;
              }
            }
          }
        }
      }
      // clear
      if(font_str != null) {
        if(font_str.contains("'")) {
          font_str = font_str.replaceAll("'","") ;
        }
      } 
      
      // split size and unit type for font
      if(font_size_str != null) {
        if(font_size_str.endsWith("pt")) {
          font_unit_str = "pt" ;
          font_size_str = font_size_str.replaceAll("pt","") ; // * 1.25f;
        } else if (font_size_str.endsWith("pc")) {
          font_unit_str = "pc" ;
          font_size_str = font_size_str.replaceAll("pc","") ; // * 15;
        } else if (font_size_str.endsWith("mm")) {
          font_unit_str = "mm" ;
          font_size_str = font_size_str.replaceAll("mm","") ; // * 3.543307f;
        } else if (font_size_str.endsWith("cm")) {
          font_unit_str = "cm" ;
          font_size_str = font_size_str.replaceAll("cm","") ; // * 35.43307f;
        } else if (font_size_str.endsWith("in")) {
          font_unit_str = "in" ;
          font_size_str = font_size_str.replaceAll("in","") ; // * 90;
        } else if (font_size_str.endsWith("px")) {
          font_unit_str = "px" ;
          font_size_str = font_size_str.replaceAll("px","") ;
        } else if (font_size_str.endsWith("%")) {
          font_unit_str = "%" ;
          font_size_str = font_size_str.replaceAll("%","") ;
        }
      }
    }

    
    
    
    private void aspect_fill(vec4 factor) {
      // HSB mmode
      if(noFill) {
        p5.noFill() ;
      } else {
        if(g.colorMode == 3) {
          p5.fill(hue(fill) *factor.x, saturation(fill) *factor.y, brightness(fill) *factor.z, opacity *g.colorModeA *factor.w) ;
        // RGB mmode
        } else if( g.colorMode == 1 ) {
          float red_col = red(fill) *factor.x ;
          float alpha_col = opacity *g.colorModeA *factor.w ;
          alpha_col = opacity *g.colorModeA *factor.w  ;
          p5.fill(red_col, green(fill) *factor.y, blue(fill) *factor.z, alpha_col) ;
        }
      }
    }

    private void aspect_stroke(float scale, vec4 factor) {
      if(noStroke) {
        p5.noStroke() ;
      } else {
        float thickness = strokeWeight ;
        if(scale != 1 ) thickness *= scale ;
        // HSB mmode
        if(g.colorMode == 3) {
          if(strokeWeight <= 0 || stroke == MAX_INT )  {
            p5.noStroke() ;
          } else {
            p5.strokeWeight(thickness) ;
            p5.stroke(hue(stroke) *factor.x, saturation(stroke) *factor.y, brightness(stroke) *factor.z, opacity *g.colorModeA *factor.w) ; 
          }
        // RGB mmode
        } else if( g.colorMode == 1 ) {
          if(strokeWeight <= 0 || stroke == MAX_INT)  {
            p5.noStroke() ;
          } else {
            p5.strokeWeight(thickness) ;
            p5.stroke(red(stroke) *factor.x, green(stroke) *factor.y, blue(stroke) *factor.z, opacity *g.colorModeA *factor.w) ; 
          }
        }
      }
    }
  }
  

















  /**
  Class Text
  */

  private class ROPEText {
    String shape_name ;
    vec3 pos ;
    vec6 matrix ;
    int ID ;
    String sentence = null ;
  
    ROPEText (vec6 matrix, String sentence, int ID) {
      this.ID = ID ;
      this.pos = vec3(matrix.e, matrix.f,0) ;
      this.matrix = matrix ;

      this.sentence = sentence ;
    }
    
    void add_value(vec3... value) {
      pos.add(value[0]) ;
    }

    int get_id() {
      return ID;
    }
  }

  /**
  Class Line
  */
  private class Line {
    String shape_name ;
    vec3 pos_a, pos_b ;
    int ID ;
  
    Line(float x_a, float y_a,  float x_b, float y_b, int ID) {
      this.ID = ID ;
      this.pos_a = vec3(x_a, y_a,0) ;
      this.pos_b = vec3(x_b, y_b,0) ;
    }
    
    void add_value(vec3... value) {
      pos_a.add(value[0]) ;
      pos_b.add(value[0]) ;
    }
  }



    
  
  /**
  class to build all specific group
  */
  private class Vertices {
    String shape_name = "my name is noboby" ;
    vec2 size ;
    vec3 [] vert ;
    int [] vertex_code ;
    int code_vertex_count ;
    int num ;
    int ID ;
    
    Vertices(int code_vertex_count, int num, PShape p, String mother_name, int ID) {
      this.ID = ID ;
      this.num = num ;
      // not sur we need this shape_name !
      this.shape_name = mother_name + "<>" +p.getName() ;
  
      this.code_vertex_count = code_vertex_count ;
      
      vert = new vec3[num] ;
      vertex_code = new int[num] ;
      vertex_code = p.getVertexCodes() ;
      size = vec2(p.width, p.height);
    }
    
    void build_vertices_3D(PShape path) {
      for(int i = 0 ; i < num ; i++) {
        vert[i] = vec3(path.getVertex(i)) ;
      }
    }
    
    vec3 [] vertices() {
      return vert ;
    }

    void add_value(vec3... value) {
      if(value.length <= vert.length) {
        for(int i = 0 ; i < value.length ; i++) {
          vert[i].add(value[i]) ;
        }
      } else {
        for(int i = 0 ; i < vert.length ; i++) {
          vert[i].add(value[i]) ;
        }
      }
    }
  }


  /**
  Class Ellipse
  */

  private class Ellipse {
    String shape_name ;
    vec3 pos ;
    vec2 size ;
    vec6 matrix ;
    int ID ;
  
    Ellipse(vec6 matrix, float cx, float cy,  float rx, float ry, int ID) {
      this.matrix = matrix ;
      this.ID = ID ;
      this.pos = vec3(cx, cy,0) ;
      this.size = vec2(rx, ry).mult(2) ;
    }
    
    void add_value(vec3... value) {
      pos.add(value[0]) ;
    }
  }

  /**
  Class Rectangle
  */
  private class Rectangle {
    String shape_name ;
    vec3 pos ;
    vec2 size ;
    vec6 matrix ;
    int ID ;
  
    Rectangle(vec6 matrix, float x, float y,  float width_rect, float height_rect, int ID) {
      this.matrix = matrix ;
      this.ID = ID ;
      this.pos = vec3(x, y,0) ;
      this.size = vec2(width_rect, height_rect) ;
    }
    
    void add_value(vec3... value) {
      pos.add(value[0]) ;
    }
  }
  /**
  END OF PRIVATE CLASS

  */
}
/**
END OF MAIN CLASS

*/