/**
Class RPEsvg 1.1.5
RPE – Romanesco Processing Environment – 
* @author Stan le Punk
* @see other Processing work on https://github.com/StanLepunK
*/

class RPEsvg {
  PShape shape_SVG ;
  String path = "" ;
  String folder_brick_name = "brick" ;
  ArrayList<Brick_SVG> list_brick_SVG = new ArrayList<Brick_SVG>() ;
  String name = "" ;
  String header_svg = "" ;
  int ID_brick ;
  String saved_path_bricks_svg = "" ;

  boolean bool_pos_svg, bool_jitter_svg, bool_scale_svg ;
  boolean keep_change ;

  boolean display_fill_original = true ;
  boolean display_stroke_original = true ;
  boolean display_thickness_original = true ;

  boolean display_fill_custom = false ;
  boolean display_stroke_custom = false ;
  boolean display_thickness_custom = false ;
  // 2D var
  Vec2 pos_svg_2D = Vec2() ;
  Vec2 jitter_svg_2D = Vec2() ;
  Vec2 scale_svg_2D = Vec2() ;
  // 3D var
  Vec3 pos_svg_3D = Vec3() ;
  Vec3 jitter_svg_3D = Vec3() ;
  Vec3 scale_svg_3D = Vec3() ;

  // Aspect default
  Vec4 fill_custom = Vec4(0,0,0,g.colorModeA) ;
  Vec4 stroke_custom = Vec4(g.colorModeX,g.colorModeY,g.colorModeZ,g.colorModeA) ;
  float thickness_custom = 1 ;

  Vec4 fill_factor = Vec4(1) ;
  Vec4 stroke_factor = Vec4(1) ;






  /**  
  CONSTRUCTOR

  */
  RPEsvg(String path, String folder_brick_name) {
    this.name = file_name(path) ;
    this.folder_brick_name = folder_brick_name ;
    this.path = path ;
    saved_path_bricks_svg = "RPE_SVG/" + folder_brick_name + "/" ;
  }

  RPEsvg(String path) {
    this.name = file_name(path) ;
    this.path = path ;
    saved_path_bricks_svg = "RPE_SVG/" + folder_brick_name + "/" ;
  }



  

  
  








  /**
  PUBLIC METHOD

  */
  void build(String path_import, String path_brick) {
    list_brick_SVG.clear() ;
    list_ellipse_SVG.clear() ;
    list_rectangle_SVG.clear() ;
    list_vertice_SVG.clear() ;

    shape_SVG = loadShape(path_import) ;
    // name_SVG = shape_SVG.getName() ;
    // list_vertex(shape_SVG, name_SVG) ;
    XML svg_info = loadXML(path_import) ;
    analyze_SVG(svg_info) ;
    save_brick_SVG() ;
    build_SVG(list_brick_SVG, path_brick) ;

  }

  void build() {
    build(path, saved_path_bricks_svg) ;
  } 






  
  /**
  METHOD to draw all the SVG
  */
  
  // PUBLIC METHOD 2D
  void draw_2D() {
    reset() ;
    draw_SVG (pos_svg_2D, scale_svg_2D, jitter_svg_2D) ;
    change_boolean_to_false() ;
  }
  
  void draw_2D(int ID) {
    reset() ;
    draw_SVG (pos_svg_2D, scale_svg_2D, jitter_svg_2D, ID) ;
    change_boolean_to_false() ;
  }

  void draw_2D(String layer_or_group_name) {
    reset() ;
    draw_SVG (pos_svg_2D, scale_svg_2D, jitter_svg_2D, layer_or_group_name) ;
    change_boolean_to_false() ;
  }
  
  /**
  // PUBLIC METHOD 3D
  */
  void draw_3D() {
    reset() ;
    draw_SVG (pos_svg_3D, scale_svg_3D, jitter_svg_3D) ;
    change_boolean_to_false() ;
  }
  
  void draw_3D(int ID) {
    reset() ;
    draw_SVG (pos_svg_3D, scale_svg_3D, jitter_svg_3D, ID) ;
    change_boolean_to_false() ;  
  }
  

  
  /**
  TEMPORARY CHANGE
  This change don't modify the original coord of point
  */
  // 2D
  void pos(Vec2 pos) {
    bool_pos_svg = true ;
    pos_svg_2D.set(pos) ;
  }
  void pos(float x, float y) {
    bool_pos_svg = true ;
    pos_svg_2D.set(x,y) ;
  }
  void scale(Vec2 scale) {
    bool_scale_svg = true ;
    scale_svg_2D.set(scale) ;
  }
  void scale(float x, float y) {
    bool_scale_svg = true ;
    scale_svg_2D.set(x,y) ;
  }

  void jitter(Vec2 jitter) {
    bool_jitter_svg = true ;
    jitter_svg_2D.set(jitter) ;
  }
  void jitter(int x, int y) {
    bool_jitter_svg = true ;
    jitter_svg_2D.set(x,y) ;
  }
  // 3D
  void pos(Vec3 pos) {
    bool_pos_svg = true ;
    pos_svg_3D.set(pos) ;
  }
  void pos(float x, float y, float z) {
    bool_pos_svg = true ;
    pos_svg_3D.set(x,y,z) ;
  }
  void scale(Vec3 scale) {
    bool_scale_svg = true ;
    scale_svg_3D.set(scale) ;
  }
  void scale(float x, float y, float z) {
    bool_scale_svg = true ;
    scale_svg_3D.set(x,y,z) ;
  }
  void jitter(Vec3 jitter) {
    bool_jitter_svg = true ;
    jitter_svg_3D.set(jitter) ;
  }
  void jitter(int x, int y, int z) {
    bool_jitter_svg = true ;
    jitter_svg_3D.set(x,y,z) ;
  }
  
  
  
  /* 
  method start() & end() use in correlation with reset for the change like jitter, pos, scale...
  when the svg is using in split mode with name or ID param
  */
  void start() {
    keep_change = true ;
  }
  void end() {
    keep_change = false ;
    reset() ;
  }


  /**
  ASPECT
  */

  void original_style(boolean fill, boolean stroke) {
    display_fill_custom = false ;
    display_stroke_custom = false ;
    display_fill_original = fill ;
    display_stroke_original = stroke ;
    display_thickness_original = stroke ;
  }

  void original_fill(boolean fill) {
    display_fill_custom = false ;
    display_fill_original = fill ;
  }

  void original_stroke(boolean stroke) {
    display_stroke_custom = false ;
    display_stroke_original = stroke ;
    display_thickness_original = stroke ;
  }



  // aspect custom
  void fill_custom(float x, float y, float z, float a) {
    display_fill_original = false ;
    display_fill_custom = true ;
    fill_custom.set(g.colorModeX *x, g.colorModeY *y, g.colorModeZ *z, g.colorModeA *a) ;
  }

  void fill_custom(Vec4 c) {
    display_fill_original = false ;
    display_fill_custom = true ;
    fill_custom.set(g.colorModeX *c.x, g.colorModeY *c.y, g.colorModeZ *c.z, g.colorModeA *c.a) ;
  }

  void stroke_custom(float x, float y, float z, float a) {
    display_stroke_original = false ;
    display_stroke_custom = true ;
    stroke_custom.set(g.colorModeX *x, g.colorModeY *y, g.colorModeZ *z, g.colorModeA *a) ;
  }

  void stroke_custom(Vec4 c) {
    display_stroke_original = false ;
    display_stroke_custom = true ;
    stroke_custom.set(g.colorModeX *c.x, g.colorModeY *c.y, g.colorModeZ *c.z, g.colorModeA *c.a) ;
  }

  void thickness_custom(float x) {
    display_thickness_original = false ;
    display_thickness_custom = true ;
    thickness_custom = x ;
  }
  


  // aspect factor
  void fill_factor(float x, float y, float z, float a) {
    fill_factor.set(x,y,z,a) ;
  }

  void stroke_factor(float x, float y, float z, float a) {
    stroke_factor.set(x,y,z,a) ;
  }

  void fill_factor(Vec4 f) {
    fill_factor.set(f.x,f.y,f.z,f.a) ;
  }

  void stroke_factor(Vec4 f) {
    stroke_factor.set(f.x,f.y,f.z,f.a) ;
  }

  /**
  PERMANENTE CHANGE
  This change modify the original points
  */
  void add_def(int target, Vec3... value) {
    if(list_brick_SVG.size() > 0) {
      Brick_SVG b = (Brick_SVG) list_brick_SVG.get(target) ;
      if(b.kind == "polygon" || b.kind == "path") {
        for(Vertices v : list_vertice_SVG) {
          if(v.ID == b.ID) v.add_value(value) ;
        }
      } 
      else if(b.kind == "circle" || b.kind == "ellipse") {
        for(Ellipse e : list_ellipse_SVG) {
          if(e.ID == b.ID) e.add_value(value) ;
        }
      } 
      else if(b.kind == "rect") {
        for(Rectangle r : list_rectangle_SVG) {
          if(r.ID == b.ID) r.add_value(value) ;
        }
      } 
    } 
  }
  

  /**
  SVG info
  */

  
  /* return quantity of brick */
  int num_brick() {
    return list_brick_SVG.size() ;
  }
  

  /*
  list
  */
  Vec3 [] list_points_of_interest(int target) {
    Vec3 [] p = new Vec3[1] ;
    p[0] = Vec3(2147483647,2147483647,2147483647) ; // it's maximum value of int in 8 bit :)

    if(list_brick_SVG.size() > 0) {
      Brick_SVG b = (Brick_SVG) list_brick_SVG.get(target) ;
      if(b.kind == "polygon" || b.kind == "path") {
        for(Vertices v : list_vertice_SVG) {
          if(v.ID == b.ID) return v.vertices() ;
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





  /*
  method to return different definition about the brick
  */

  String folder_brick_name() {
    return folder_brick_name ;
  }


  String [] brick_name_list() {
    return name_brick_SVG(list_brick_SVG) ;
  }

  String brick_name(int target) {
    if(list_brick_SVG.size() > 0 && target < list_brick_SVG.size()) {
      Brick_SVG b = (Brick_SVG) list_brick_SVG.get(target) ;
      return b.brick_name ;

    } else return "No idea for this ID !" ;
  }

  String [] family_brick() {
    return family_brick_SVG(list_brick_SVG) ;
  }
  String family_brick(int target) {
    if(list_brick_SVG.size() > 0 && target < list_brick_SVG.size()) {
      Brick_SVG b = (Brick_SVG) list_brick_SVG.get(target) ;
      return b.family_name ;

    } else return "No idea for this ID !" ;
  }

  String [] kind_brick() {
    return kind_brick_SVG(list_brick_SVG) ;
  }
  String kind_brick(int target) {
    if(list_brick_SVG.size() > 0 && target < list_brick_SVG.size()) {
      Brick_SVG b = (Brick_SVG) list_brick_SVG.get(target) ;
      return b.kind ;

    } else return "No idea for this ID !" ;
  }





  
  




  /**
  Canvas SVG
  */
  float width() {
    if(shape_SVG != null) return shape_SVG.width ; else return 0;
  }
  float height() {
    if(shape_SVG != null) return shape_SVG.height ; else return 0;
  }
  
  Vec2 canvas() {
    if(shape_SVG != null) return Vec2(shape_SVG.width, shape_SVG.height) ; else return Vec2();
  }
  
  
  
  
  
  /**
  Canvas brick SVG
  */
  float width_brick(int target) {
    if(list_brick_SVG.size() > 0 && target <list_brick_SVG.size()) {
      Brick_SVG b_svg = list_brick_SVG.get(target) ;
      return b_svg.width ; 
    } else return 0 ;
  }

  float height_brick(int target) {
    if(list_brick_SVG.size() > 0 && target <list_brick_SVG.size()) {
      Brick_SVG b_svg = list_brick_SVG.get(target) ;
      return b_svg.height ; 
    } else return 0 ;
  }
  
  Vec2 canvas_brick(int target) {
    if(list_brick_SVG.size() > 0 && target <list_brick_SVG.size()) {
      Brick_SVG b_svg = list_brick_SVG.get(target) ;
      return Vec2(b_svg.width, b_svg.height) ;
    } else return Vec2() ;
  }




 /**
  SETTING
  */
  

  
  
  
  boolean position_center = false ;
  void svg_mode(int mode) {
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
  void reset() {
    if(!keep_change) {
      if(!bool_pos_svg) {
        pos_svg_2D.set(0) ;
        pos_svg_3D.set(0) ;
      }
      if(!bool_jitter_svg) {
        jitter_svg_2D.set(0) ;
        jitter_svg_3D.set(0) ;
      }
      if(!bool_scale_svg) {
        scale_svg_2D.set(1) ;
        scale_svg_3D.set(1) ;
      }
    }
  }
  
  void change_boolean_to_false() {
    bool_pos_svg = false ;
    bool_scale_svg = false ;
    bool_jitter_svg = false ;
  }
  /**
  Draw all shape
  */
  // INTERN METHOD 2D
  void draw_SVG(Vec2 pos, Vec2 scale, Vec2 jitter) {
    for(int i = 0 ; i < list_brick_SVG.size() ; i++) {
      Brick_SVG b = (Brick_SVG) list_brick_SVG.get(i) ;
      float average_scale = (scale.x + scale.y) *.5 ;
      aspect(b, average_scale) ;
      display_shape_2D(b, pos, scale, jitter) ;
    }
  }
  
  // INTERN METHOD 3D
  void draw_SVG (Vec3 pos, Vec3 scale, Vec3 jitter) {
    for(int i = 0 ; i < list_brick_SVG.size() ; i++) {
      Brick_SVG b = (Brick_SVG) list_brick_SVG.get(i) ;
      float average_scale = (scale.x + scale.y + scale.z) *.333 ;
      aspect(b, average_scale) ;
      display_shape_3D(b, pos, scale, jitter) ;
    }
  }
 
  
  /**
  Draw shape by ID
  */
  // 2D
  void draw_SVG (Vec2 pos, Vec2 scale, Vec2 jitter, int ID) {
    if(ID < list_brick_SVG.size()) {
      Brick_SVG b = (Brick_SVG) list_brick_SVG.get(ID) ;
      float average_scale = (scale.x + scale.y) *.5 ;
      aspect(b, average_scale) ;
      display_shape_2D(b, pos, scale, jitter) ;
    }
  }
  // 3D
  void draw_SVG (Vec3 pos, Vec3 scale, Vec3 jitter, int ID) {
    if(ID < list_brick_SVG.size()) {
      Brick_SVG b = (Brick_SVG) list_brick_SVG.get(ID) ;
      float average_scale = (scale.x + scale.y + scale.z) *.333 ;
      aspect(b, average_scale) ;
      display_shape_3D(b, pos, scale, jitter) ;
    }
  }
  
  
  
  /**
  Draw shape by name
  */
  // draw all file from shape or group of layer
  // must be factoring is very ligth method :)
  void draw_SVG (Vec2 pos, Vec2 scale, Vec2 jitter, String layer_name) {
    for(int i = 0 ; i < list_brick_SVG.size() ; i++) {
      Brick_SVG b = (Brick_SVG) list_brick_SVG.get(i) ;
      if( b.family_name.contains(layer_name)) {
        // build_path(pos, scale, jitter, v) ;
        float average_scale = (scale.x + scale.y) *.5 ;
        aspect(b, average_scale) ;
        display_shape_2D(b, pos, scale, jitter) ;
      }
    }
  }
  // 3D
  void draw_SVG (Vec3 pos, Vec3 scale, Vec3 jitter, String layer_name) {
    for(int i = 0 ; i < list_brick_SVG.size() ; i++) {
      Brick_SVG b = (Brick_SVG) list_brick_SVG.get(i) ;
      if( b.family_name.contains(layer_name)) {
        // build_path(pos, scale, jitter, v) ;
        float average_scale = (scale.x + scale.y) *.5 ;
        aspect(b, average_scale) ;
        display_shape_3D(b, pos, scale, jitter) ;
      }
    }
  }
  /**
  END DRAW METHOD

  */


  /**
  ASPECT
  */
  void aspect(Brick_SVG b, float scale_thickness) {
    if(!display_fill_custom && !display_fill_original) {
      noFill() ;
    } else {
      if(display_fill_original && !display_fill_custom) {
        fill_original(b) ;
      } else if(!display_fill_original && display_fill_custom) {
        fill_custom() ;
      } 
    }
    if(!display_stroke_custom && !display_stroke_original) {
      noStroke() ;
    } else {
      if(display_stroke_original && !display_stroke_custom) {
        stroke_original(b, scale_thickness) ;
      } else if(!display_stroke_original && display_stroke_custom) {
        stroke_custom() ;
      } 
    }
  }




  // original aspect
  void fill_original(Brick_SVG b) {
    if(b.opacity > 0 ) {
      b.aspect_fill(fill_factor) ; 
    } else noFill() ;
  }

  void stroke_original(Brick_SVG b, float scale_thickness) {
    if(b.opacity > 0 && b.strokeWeight > 0) {
      b.aspect_stroke(scale_thickness,stroke_factor) ; 
    } else {
      noStroke() ;
    }
  }


  // custom aspect
  void fill_custom() {
    if(fill_custom.a > 0 ) {
      fill(fill_custom.r *fill_factor.x, fill_custom.g *fill_factor.y, fill_custom.b *fill_factor.y, fill_custom.a *fill_factor.w) ; 
    } else {
      noFill() ;
    }
  }

  void stroke_custom() {
    if(stroke_custom.a > 0 && thickness_custom > 0 ) {
      stroke(stroke_custom.r *stroke_factor.x, stroke_custom.g *stroke_factor.y, stroke_custom.b *stroke_factor.z, stroke_custom.a *stroke_factor.w) ;
      strokeWeight(thickness_custom) ;
    } else {
      noStroke() ;
    }
  }






  
  


































  /**
BUILD

  */
  /**
  Display method
  */
  void display_shape_2D(Brick_SVG b, Vec2 pos, Vec2 scale, Vec2 jitter) {
    if(b.kind == "path" || b.kind == "polygon") {
      for(Vertices v : list_vertice_SVG) {
        if(v.ID == b.ID) build_path(pos, scale, jitter, v) ;
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
    }
  }

  void display_shape_3D(Brick_SVG b, Vec3 pos, Vec3 scale, Vec3 jitter) {
    if(b.kind == "path" || b.kind == "polygon") {
      for(Vertices v : list_vertice_SVG) {
        if(v.ID == b.ID) build_path(pos, scale, jitter, v) ;
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
    }
  }


  /**
  Build list point of SVG
  */
  void build_SVG(ArrayList<Brick_SVG> list, String path_brick) {
    PShape [] children = new PShape[list.size()] ;
    for(int i = 0 ; i < list.size() ; i++) {
      PShape mother = loadShape(path_brick + folder_brick_name + "_" + i + ".svg") ;
      children = mother.getChildren() ;
      Brick_SVG b = (Brick_SVG) list.get(i) ;
      if( b.kind == "polygon" || b.kind == "path")  vertex_count(children[0], mother.getName(), b.ID) ;
      else if(b.kind == "circle" || b.kind == "ellipse") ellipse_count(b.full_xml_SVG, mother.getName(), b.ID) ;
      else if(b.kind == "rect") rectangle_count(b.full_xml_SVG, mother.getName(), b.ID) ;
    }
  }
  



  /**
  ELLIPSE & CIRCLE
  */
  /**
  build
  */
  // list of group SVG
  ArrayList<Ellipse> list_ellipse_SVG = new ArrayList<Ellipse>() ;
  
  void ellipse_count(XML xml_shape, String geom_name, int ID) {
    float r = xml_shape.getChild(0).getFloat("r") ;
    float rx = (float)xml_shape.getChild(0).getFloat("rx") ;
    float ry = (float)xml_shape.getChild(0).getFloat("ry") ;
    float cx = xml_shape.getChild(0).getFloat("cx") ;
    float cy = xml_shape.getChild(0).getFloat("cy") ;
    if(r > 0 ) rx = ry = r ;
  
    Ellipse e = new Ellipse(cx, cy, rx, ry, ID) ;
    list_ellipse_SVG.add(e) ;
  }
  

  /**
  Main method to draw ellipse
  */
  void build_ellipse(Vec2 pos, Vec2 scale, Vec2 jitter, Ellipse e) {
    Vec2 temp_pos = Vec2(e.pos.x, e.pos.y)  ;
    Vec2 center_pos = canvas().copy() ;
    center_pos.mult(.5) ; 
  
    // the order of operation is very weird, because is not a same for the build_vertex()
    if(position_center) temp_pos.sub(center_pos) ;
    if(!scale.compare(Vec2(1))) temp_pos.mult(scale) ; 
    if(!pos.compare(Vec2())) temp_pos.add(pos) ;
  
    Vec2 temp_size = e.size.copy() ;
    ellipse(temp_pos, temp_size.mult(scale)) ;
  }
  
  void build_ellipse(Vec3 pos, Vec3 scale, Vec3 jitter, Ellipse e) {
    Vec3 temp_pos = Vec3(e.pos.x, e.pos.y,0)  ;
    Vec3 center_pos = Vec3(canvas().x,canvas().y, 0) ;
    center_pos.mult(.5) ; 
  
    // the order of operation is very weird, because is not a same for the build_vertex()
    if(position_center) temp_pos.sub(center_pos) ;
    if(!scale.compare(Vec3(1))) temp_pos.mult(scale) ; 
    if(!pos.compare(Vec3())) temp_pos.add(pos) ;
  
    Vec2 temp_size = e.size.copy() ;
    ellipse(temp_pos, temp_size.mult(scale.x, scale.y)) ;
  }
  /**
  END CIRCLE & ELLIPSE
  */
  



  /**
  RECTANGLE
  */
  /**
  build
  */
  // list of group SVG
  ArrayList<Rectangle> list_rectangle_SVG = new ArrayList<Rectangle>() ;
  
  void rectangle_count(XML xml_shape, String geom_name, int ID) {
    float x = xml_shape.getChild(0).getFloat("x") ;
    float y = xml_shape.getChild(0).getFloat("y") ;
    float width_rect = xml_shape.getChild(0).getFloat("width") ;
    float height_rect = xml_shape.getChild(0).getFloat("height") ;
  
    Rectangle r = new Rectangle(x, y, width_rect, height_rect, ID) ;
    list_rectangle_SVG.add(r) ;
  }
  
  /**
  Main method to draw ellipse
  */
  void build_rectangle(Vec2 pos, Vec2 scale, Vec2 jitter, Rectangle r) {
    Vec2 temp_pos = Vec2(r.pos.x, r.pos.y)  ;
    Vec2 center_pos = canvas().copy() ;
    center_pos.mult(.5) ; 
  
    // the order of operation is very weird, because is not a same for the build_vertex()
    if(position_center) temp_pos.sub(center_pos) ;
    if(!scale.compare(Vec2(1))) temp_pos.mult(scale) ; 
    if(!pos.compare(Vec2())) temp_pos.add(pos) ;
  
    Vec2 temp_size = r.size.copy() ;
    rect(temp_pos, temp_size.mult(scale)) ;
  }
  
  void build_rectangle(Vec3 pos, Vec3 scale, Vec3 jitter, Rectangle r) {
    Vec3 temp_pos = Vec3(r.pos.x, r.pos.y,0)  ;
    Vec3 center_pos = Vec3(canvas().x,canvas().y, 0) ;
    center_pos.mult(.5) ; 
  
    // the order of operation is very weird, because is not a same for the build_vertex()
    if(position_center) temp_pos.sub(center_pos) ;
    if(!scale.compare(Vec3(1))) temp_pos.mult(scale) ; 
    if(!pos.compare(Vec3())) temp_pos.add(pos) ;
  
    Vec2 temp_size = r.size.copy() ;
    rect(temp_pos, temp_size.mult(scale.x, scale.y)) ;
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
  ArrayList<Vertices> list_vertice_SVG = new ArrayList<Vertices>() ;
  // here we must build few object for each group, but how ?
  Vec3 [] vert ;
  int [] vertex_code ;
  int code_vertex_count ;
  
  void vertex_count(PShape geom_shape, String geom_name, int ID) {
    int num = geom_shape.getVertexCount() ;
    vertex_code = new int[num] ;
    vert = new Vec3[num] ;
    vertex_code = geom_shape.getVertexCodes() ;
    code_vertex_count = geom_shape.getVertexCodeCount() ;
    
    // Vertices v = new Group_vert(code_vertex_count, num, vertex_code, geom_shape.getName()) ;
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
  /**
  for the 2D vertex
  */
  
  void build_path(Vec2 pos, Vec2 scale, Vec2 jitter, Vertices v) {
    Vec2 center_pos = Vec2(canvas().x,canvas().y) ;
    center_pos.mult(.5) ; 
    if(!scale.compare(Vec2(1))) center_pos.mult(scale) ; 
  
    if (v.vert == null) return;
  
    boolean insideContour = false;
    beginShape();
    // for the simple vertex
    if (v.code_vertex_count == 0) {  
      for (int i = 0; i <  v.vert.length; i++) {
        Vec2 temp_pos_a = Vec2(v.vert[i].x,v.vert[i].y) ;
        //
        if(!scale.compare(Vec2(1))) temp_pos_a.mult(scale) ;
        //
        if(!jitter.compare(Vec2())) {
          Vec2 jitter_pos = Vec2().jitter((int)jitter.x,(int)jitter.y) ;
          temp_pos_a.add(jitter_pos) ;
        }
        //
        if(position_center) temp_pos_a.sub(center_pos) ;
        //
        if(!pos.compare(Vec2())) temp_pos_a.add(pos) ;
  
        vertex(temp_pos_a);
      }
    // for the complex draw vertex, with bezier, curve...
    } else {  
      int index = 0;
      for (int j = 0; j < v.code_vertex_count; j++) {
        Vec2 temp_pos_a , temp_pos_b, temp_pos_c ;
  
        switch (v.vertex_code[j]) {
          //---------
          case VERTEX:
          temp_pos_a = Vec2(v.vert[index].x,v.vert[index].y) ;
          //
          if(!scale.compare(Vec2(1))) temp_pos_a.mult(scale) ;
          //
          if(!jitter.compare(Vec2())) {
            Vec2 jitter_pos = Vec2().jitter((int)jitter.x,(int)jitter.y) ;
            temp_pos_a.add(jitter_pos) ;
          }
          //
          if(position_center) temp_pos_a.sub(center_pos) ;
          //
          if(!pos.compare(Vec2())) temp_pos_a.add(pos) ;
          //
          vertex(temp_pos_a);
          index++;
          break;
          // QUADRATIC_VERTEX
          case QUADRATIC_VERTEX:
          temp_pos_a = Vec2(v.vert[index].x,v.vert[index].y) ;
          temp_pos_b = Vec2(v.vert[index +1].x,v.vert[index +1].y) ;
          //
          if(!scale.compare(Vec2(1))) {
            temp_pos_a.mult(scale) ;
            temp_pos_b.mult(scale) ;
          }
          //
          if(!jitter.compare(Vec2())) {
            Vec2 jitter_pos = Vec2().jitter((int)jitter.x,(int)jitter.y) ;
            temp_pos_a.add(jitter_pos) ;
            jitter_pos = Vec2().jitter((int)jitter.x,(int)jitter.y) ;
            temp_pos_b.add(jitter_pos) ;
          }
          //
          if(position_center) {
            temp_pos_a.sub(center_pos) ;
            temp_pos_b.sub(center_pos) ;
          }
          //
          if(!pos.compare(Vec2())) {
            temp_pos_a.add(pos) ;
            temp_pos_b.add(pos) ;
          }
          //
          quadraticVertex(temp_pos_a, temp_pos_b);
          index += 2;
          break;
          // BEZIER_VERTEX     
          case BEZIER_VERTEX:
          temp_pos_a = Vec2(v.vert[index].x,v.vert[index].y) ;
          temp_pos_b = Vec2(v.vert[index +1].x,v.vert[index +1].y) ;
          temp_pos_c = Vec2(v.vert[index +2].x,v.vert[index +2].y) ;
          //
          if(!scale.compare(Vec2(1))) {
            temp_pos_a.mult(scale) ;
            temp_pos_b.mult(scale) ;
            temp_pos_c.mult(scale) ;
          }
          //
          if(!jitter.compare(Vec2())) {
            Vec2 jitter_pos = Vec2().jitter((int)jitter.x,(int)jitter.y) ;
            temp_pos_a.add(jitter_pos) ;
            jitter_pos = Vec2().jitter((int)jitter.x,(int)jitter.y) ;
            temp_pos_b.add(jitter_pos) ;
            jitter_pos = Vec2().jitter((int)jitter.x,(int)jitter.y) ;
            temp_pos_c.add(jitter_pos) ;
          }
          //
          if(position_center) {
            temp_pos_a.sub(center_pos) ;
            temp_pos_b.sub(center_pos) ;
            temp_pos_c.sub(center_pos) ;
          }
          //
          if(!pos.compare(Vec2())) {
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
          temp_pos_a = Vec2(v.vert[index].x,v.vert[index].y) ;
          //
          if(!scale.compare(Vec2(1))) temp_pos_a.mult(scale) ;
          //
          if(!jitter.compare(Vec2())) {
            Vec2 jitter_pos = Vec2().jitter((int)jitter.x,(int)jitter.y) ;
            temp_pos_a.add(jitter_pos) ;
          }
          //
          if(position_center) temp_pos_a.sub(center_pos) ;
          //
          if(!pos.compare(Vec2())) temp_pos_a.add(pos) ;
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
    endShape(CLOSE);
  }
  /**
  for the 3D vertex
  */
  void build_path(Vec3 pos, Vec3 scale, Vec3 jitter, Vertices v) {
    Vec3 center_pos = Vec3(canvas().x,canvas().y,0) ;
    center_pos.mult(.5) ; 
    if(!scale.compare(Vec3(1))) center_pos.mult(scale) ; 
  
    if (v.vert == null) return;
  
    boolean insideContour = false;
    beginShape();
    // for the simple vertex
    if (v.code_vertex_count == 0) {  
      for (int i = 0; i <  v.vert.length; i++) {
        Vec3 temp_pos_a = v.vert[i].copy() ;
        //
        if(!scale.compare(Vec3(1))) temp_pos_a.mult(scale) ;
        //
        if(!jitter.compare(Vec3())) {
          Vec3 jitter_pos = Vec3().jitter((int)jitter.x,(int)jitter.y,(int)jitter.z) ;
          temp_pos_a.add(jitter_pos) ;
        }
        //
        if(position_center) temp_pos_a.sub(center_pos) ;
        //
        if(!pos.compare(Vec3())) temp_pos_a.add(pos) ;
        //
        vertex(temp_pos_a);
      }
    // for the complex draw vertex, with bezier, curve...
    } else {  
      int index = 0;
      for (int j = 0; j < v.code_vertex_count; j++) {
        Vec3 temp_pos_a , temp_pos_b, temp_pos_c ;
  
        switch (v.vertex_code[j]) {
          //----------
          case VERTEX:
          temp_pos_a = v.vert[index].copy() ;
          //
          if(!scale.compare(Vec3(1))) temp_pos_a.mult(scale) ;
          //
          if(!jitter.compare(Vec3())) {
            Vec3 jitter_pos = Vec3().jitter((int)jitter.x,(int)jitter.y,(int)jitter.z) ;
            temp_pos_a.add(jitter_pos) ;
          }
          //
          if(position_center) temp_pos_a.sub(center_pos) ;
          //
          if(!pos.compare(Vec3())) temp_pos_a.add(pos) ;
          //
          vertex(temp_pos_a);
          index++;
          break;
        // QUADRATIC_VERTEX
          case QUADRATIC_VERTEX:
          temp_pos_a = v.vert[index].copy() ;
          temp_pos_b = v.vert[index +1].copy() ;
          //
          if(!scale.compare(Vec3(1))) {
            temp_pos_a.mult(scale) ;
            temp_pos_b.mult(scale) ;
          }
          //
          if(!jitter.compare(Vec3())) {
            Vec3 jitter_pos = Vec3().jitter((int)jitter.x,(int)jitter.y,(int)jitter.z) ;
            temp_pos_a.add(jitter_pos) ;
            jitter_pos = Vec3().jitter((int)jitter.x,(int)jitter.y,(int)jitter.z) ;
            temp_pos_b.add(jitter_pos) ;
          }
          //
          if(position_center) {
            temp_pos_a.sub(center_pos) ;
            temp_pos_b.sub(center_pos) ;
          }
          //
          if(!pos.compare(Vec3())) {
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
          if(!scale.compare(Vec3(1))) {
            temp_pos_a.mult(scale) ;
            temp_pos_b.mult(scale) ;
            temp_pos_c.mult(scale) ;
          }
          //
          if(!jitter.compare(Vec3())) {
            Vec3 jitter_pos = Vec3().jitter((int)jitter.x,(int)jitter.y,(int)jitter.z) ;
            temp_pos_a.add(jitter_pos) ;
            jitter_pos = Vec3().jitter((int)jitter.x,(int)jitter.y,(int)jitter.z) ;
            temp_pos_b.add(jitter_pos) ;
            jitter_pos = Vec3().jitter((int)jitter.x,(int)jitter.y,(int)jitter.z) ;
            temp_pos_c.add(jitter_pos) ;
          }
          //
          if(position_center) {
            temp_pos_a.sub(center_pos) ;
            temp_pos_b.sub(center_pos) ;
            temp_pos_c.sub(center_pos) ;
          }
          //
          if(!pos.compare(Vec3())) {
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
          if(!scale.compare(Vec3(1))) temp_pos_a.mult(scale) ;
          //
          if(!jitter.compare(Vec3())) {
            Vec3 jitter_pos = Vec3().jitter((int)jitter.x,(int)jitter.y,(int)jitter.z) ;
            temp_pos_a.add(jitter_pos) ;
          }
          //
          if(position_center) temp_pos_a.sub(center_pos) ;
          //
          if(!pos.compare(Vec3())) temp_pos_a.add(pos) ;
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
    endShape(CLOSE);
  }
  /**
  END BUILD

  */



  /**
  EXTRACT POINT
  
  */
  
  void extract(Vertices v) {
    if (v.vert == null) return;
    if (v.code_vertex_count == 0) {  
      for (int i = 0; i <  v.vert.length; i++) {
        Vec3 temp_pos_a = v.vert[i].copy() ;
        vertex(temp_pos_a);
      }
    // for the complex draw vertex, with bezier, curve...
    } else {  
      int index = 0;
      for (int j = 0; j < v.code_vertex_count; j++) {
        Vec3 temp_pos_a , temp_pos_b, temp_pos_c ;
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
  String [] name_brick_SVG (ArrayList<Brick_SVG> list_brick) {
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
  
  String [] kind_brick_SVG (ArrayList<Brick_SVG> list_brick) {
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
  
  String [] family_brick_SVG (ArrayList<Brick_SVG> list_brick) {
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
  void analyze_SVG(XML target) {
    // catch the header to rebuild a SVG as small as possible to use Processing build PShapeSVG of Processing engine
    header_svg = catch_header_SVG(target) ;

    ID_brick = 0 ;
    String primal_name =("") ;
    String primal_opacity = ("none") ;
    deep_analyze_SVG(header_svg, target, primal_name, primal_opacity) ;
  }
  
  void save_brick_SVG() {
    /* here in the future :
    Save name of SVG, width, height and other global properties
    */
    for(int i = 0 ; i < list_brick_SVG.size() ; i++) {
      Brick_SVG shape = (Brick_SVG) list_brick_SVG.get(i) ;
      saveXML(shape.full_xml_SVG,  saved_path_bricks_svg + folder_brick_name + "_" + i + ".svg") ;
    }
  }
  
  
  
  // Local method
  void deep_analyze_SVG(String header, XML target, String ancestral_name, String opacity_group) {
    String ID_xml =("") ;
    ID_xml = get_kind_SVG(target) ;
    // check for group or layer shape
    if(check_group_SVG(target)) {
      XML [] g_group = target.getChildren("g") ;
      if(g_group.length > 0) {
        for(int i = 0 ; i < g_group.length ; i++) {
          String new_name = ancestral_name + g_group[i].getString("id") ;
          // check if there is opacity for the group or not
          if(opacity_group == null || opacity_group == "none")  opacity_group = g_group[i].getString("opacity") ;
          deep_analyze_SVG(header, g_group[i], new_name, opacity_group) ;
        }
      }
    }
    // catch the shape
    // add the opacity here for the brick ????
    if(check_kind_SVG(target)) add_brick_SVG(header_svg, target, ancestral_name, opacity_group) ;
  }
  
  
  
  void add_brick_SVG(String header, XML target, String ancestral_name, String opacity_group) {
    XML [] g_rect = target.getChildren("rect") ;
    if(g_rect.length > 0) {
      for(int i = 0 ; i < g_rect.length ; i++) {
        catch_brick_shape(header, g_rect[i], ancestral_name, opacity_group) ;
      }
    }
    XML [] g_circle = target.getChildren("circle") ;
    if(g_circle.length > 0) {
      for(int i = 0 ; i < g_circle.length ; i++) {
        catch_brick_shape(header, g_circle[i], ancestral_name, opacity_group) ;
      }
    }
    XML [] g_ellipse = target.getChildren("ellipse") ;
    if(g_ellipse.length > 0) {
      for(int i = 0 ; i < g_ellipse.length ; i++) {
        catch_brick_shape(header, g_ellipse[i], ancestral_name, opacity_group) ;
      }
    }
    XML [] g_polygon = target.getChildren("polygon") ;
    if(g_polygon.length > 0) {
      for(int i = 0 ; i < g_polygon.length ; i++) {
        catch_brick_shape(header, g_polygon[i], ancestral_name, opacity_group) ;
      }
    }
    XML [] g_path = target.getChildren("path") ;
    if(g_path.length > 0) {
      for(int i = 0 ; i < g_path.length ; i++) {
        catch_brick_shape(header, g_path[i], ancestral_name, opacity_group) ;
      }
    }
  }
    




  /**
  CATCH INFO 
  */
  String catch_header_SVG(XML target) {
    String s = "" ;
    String string_to_split = target.toString() ;
    String [] part = string_to_split.split("<") ;
    s = "<"+part[1] ;
    return s ;
  }
  
  
  void catch_brick_shape(String header, XML target, String ancestral_name, String opacity_group) {
    Brick_SVG new_brick = new Brick_SVG(header, target, ID_brick, ancestral_name, opacity_group) ;
    list_brick_SVG.add(new_brick) ;
    ID_brick++ ;
  }
  /**
  CHECK INFO
  */  
  boolean check_kind_SVG(XML target) {
    boolean result = false ;
    if(target.getChild("path") != null ) result = true ;
    else if(target.getChild("rect")!= null ) result = true ;
    else if(target.getChild("polygon")!= null ) result = true ;
    else if(target.getChild("circle")!= null ) result = true ;
    else if(target.getChild("ellipse")!= null ) result = true ;
    else if(target.getChild("g")!= null ) result = false ;
    else result = false ;
    return result ;
  }

  boolean check_group_SVG(XML target) {
    boolean result = false ;
    if(target.getChild("g")!= null ) result = true ;
    else result = false ;
    return result ;
  }
  /**
  GET
  */
  String get_kind_SVG(XML target) {
    String kind = "" ;
    if(target.getChild("path") != null ) kind = "path" ;
    else if(target.getChild("polygon")!= null ) kind = "polygon" ;
    else if(target.getChild("circle")!= null )kind = "circle" ;
    else if(target.getChild("ellipse")!= null ) kind = "ellipse" ;
    else if(target.getChild("rect")!= null ) kind = "rect" ;
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
    String file_name ;
    String brick_name = "no name" ;
    String family_name = "no name" ;
    String kind = "" ;
    int ID ;
    int fill, stroke ;
    float strokeWeight ;
    float opacity, opacity_group ;
    int width, height ;
    XML full_xml_SVG ;
    String built_svg_file = "" ;
   
    Brick_SVG(String header, XML brick_xml, int ID, String ancestral_name, String str_opacity_group) {
  
      this.ID = ID ;
      built_svg_file = header + brick_xml.toString() + "</svg>" ;
      full_xml_SVG = parseXML(built_svg_file) ;
  
      brick_name = get_name(brick_xml) ;
      family_name = ancestral_name + "_" + get_name(full_xml_SVG) ;
      this.kind = get_kind_SVG(full_xml_SVG) ;
      if(str_opacity_group != "none" && str_opacity_group != null) opacity_group = Float.valueOf(str_opacity_group.trim()).floatValue(); else opacity_group = 1. ;
      set_aspect(brick_xml) ;
    }
  
    String get_name(XML target) {
      String name = "no name" ;
      if(target.getString("id") != null) name = target.getString("id") ;
      return name ;
    }
    /**
    aspect
    */
    void set_aspect(XML target) {
      String fill_str =  target.getString("fill") ;        
      String stroke_str =  target.getString("stroke") ;
      String strokeWeight_str =  target.getString("stroke-width") ;
      String opacity_str =  target.getString("opacity") ; 
      // fill
      if(fill_str == null || fill_str.contains("none")) fill = #FFFFFF ; 
      else {
        String fill_temp = "" ;
        fill_temp = fill_str.substring(1) ;
        fill = unhex(fill_temp) ;
      }
      // stroke
      if(stroke_str == null  || stroke_str.contains("none")) stroke = #000000 ; 
      else {
        String stroke_temp = "" ;
        stroke_temp = stroke_str.substring(1) ;
        stroke = unhex(stroke_temp) ;
      }
      // strokeWeight
      if(strokeWeight_str == null  || strokeWeight_str.contains("none")) strokeWeight = 1. ; 
      else strokeWeight = Float.valueOf(strokeWeight_str.trim()).floatValue();
      // opacity
      if(opacity_str == null || opacity_str.contains("none")) opacity = 1. ; 
      else opacity = Float.valueOf(opacity_str.trim()).floatValue();
      if(opacity == 1. && opacity_group != 1.) opacity = opacity_group ;
    }
    
    
    
    void aspect_fill(Vec4 factor) {
      // HSB mmode
      if(g.colorMode == 3) {
        fill(hue(fill) *factor.x, saturation(fill) *factor.y, brightness(fill) *factor.z, opacity *g.colorModeA *factor.w) ;
      // RGB mmode
      } else if( g.colorMode == 1 ) {
        float red_col = red(fill) *factor.x ;
        float alpha_col = opacity *g.colorModeA *factor.w ;
        alpha_col = opacity *g.colorModeA *factor.w  ;
        fill(red_col, green(fill) *factor.y, blue(fill) *factor.z, alpha_col) ;
      }
    }

    void aspect_stroke(float scale, Vec4 factor) {
      float thickness = strokeWeight ;
      if(scale != 1 ) thickness *= scale ;
      // HSB mmode
      if(g.colorMode == 3) {
        if(thickness <= 0)  {
          noStroke() ;
        } else {
          strokeWeight(thickness) ;
          stroke(hue(stroke) *factor.x, saturation(stroke) *factor.y, brightness(stroke) *factor.z, opacity *g.colorModeA *factor.w) ; 
        }
      // RGB mmode
      } else if( g.colorMode == 1 ) {
        if(thickness <= 0)  {
          noStroke() ;
        } else {
          strokeWeight(thickness) ;
          stroke(red(stroke) *factor.x, green(stroke) *factor.y, blue(stroke) *factor.z, opacity *g.colorModeA *factor.w) ; 
        }
      }
    }
  }
  


















    
  
  /**
  class to build all specific group
  */
  private class Vertices {
    String shape_name = "my name is noboby" ;
    Vec2 size ;
    Vec3 [] vert ;
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
      
      vert = new Vec3[num] ;
      vertex_code = new int[num] ;
      vertex_code = p.getVertexCodes() ;
      size = Vec2(p.width, p.height);
    }
    
    void build_vertices_3D(PShape path) {
      for(int i = 0 ; i < num ; i++) {
        vert[i] = Vec3(path.getVertex(i)) ;
      }
    }
    
    Vec3 [] vertices() {
      return vert ;
    }

    void add_value(Vec3... value) {
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

  class Ellipse {
    String shape_name ;
    Vec3 pos ;
    Vec2 size ;
    int ID ;
  
    Ellipse(float cx, float cy,  float rx, float ry, int ID) {
      this.ID = ID ;
      this.pos = Vec3(cx, cy,0) ;
      this.size = Vec2(rx, ry).mult(2) ;
    }
    
    void add_value(Vec3... value) {
      pos.add(value[0]) ;
    }
    
  }

  /**
  Class Rectangle
  */
  class Rectangle {
    String shape_name ;
    Vec3 pos ;
    Vec2 size ;
    int ID ;
  
    Rectangle(float x, float y,  float width_rect, float height_rect, int ID) {
      this.ID = ID ;
      this.pos = Vec3(x, y,0) ;
      this.size = Vec2(width_rect, height_rect) ;
    }
    
    void add_value(Vec3... value) {
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