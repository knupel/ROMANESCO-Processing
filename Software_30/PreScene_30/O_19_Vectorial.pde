/**
VECTORIAL || 2015 || 0.0.2
*/

class Vectorial extends Romanesco {
 
  public Vectorial() {
    RPE_name = "Vectorial" ;
    ID_item = 19 ;
    ID_group = 1 ;
    RPE_author  = "Stan le Punk";
    RPE_version = "Version 0.0.2";
    RPE_pack = "Base 2016" ;
    RPE_mode = "Classic original/Classic custom/Walker original/Walker custom" ; // separate the differentes mode by "/"
    RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Stroke hue,Stroke sat,Stroke bright,Stroke alpha,Thickness,Jitter X,Jitter Y,Jitter Z,Canvas X,Canvas Y,Swing X,Swing Y,Swing Z" ;
  }



  String ref_name = "" ;
  boolean walker  ;
  float beat_factor = 1 ;
  String svg_bricks_saved = "RPE_SVG/bricks/"  ;

  Vec3 jitting = Vec3(0) ;
  Vec4 normalize_fill = Vec4(1) ;
  Vec4 normalize_stroke = Vec4(1) ;
 
  // setup
  void setup() {
    setting_start_position(ID_item, width/2, height/2 +height/4, -height) ;
    setting_start_direction(ID_item, 30,-20) ;

    load_svg(ID_item) ;
    svg_import[ID_item].build(svg_current_path, svg_bricks_saved) ;
    svg_import[ID_item].svg_mode(CENTER) ;
    ref_name = svg_import[ID_item].name ;
  }


  void draw() {
    if(parameter[ID_item]) {
      ref_name = svg_import[ID_item].name ;
      load_svg(ID_item) ;
      if(!svg_import[ID_item].name.equals(ref_name)) {
        ref_name = svg_import[ID_item].name ;
        svg_import[ID_item].build(svg_current_path, svg_bricks_saved) ;
        svg_import[ID_item].svg_mode(CENTER) ;
      }
    } 
    

    // color
    float normalize_hue_fill = map(hue(fill_item[ID_item]), 0,360,0,1) ;
    float normalize_sat_fill = map(saturation(fill_item[ID_item]), 0,100,0,1) ;
    float normalize_bright_fill = map(brightness(fill_item[ID_item]), 0,100,0,1) ;
    float normalize_alpha_fill = map(alpha(fill_item[ID_item]), 0,100,0,1) ;

    float normalize_hue_stroke = map(hue(stroke_item[ID_item]), 0,360,0,1) ;
    float normalize_sat_stroke = map(saturation(stroke_item[ID_item]), 0,100,0,1) ;
    float normalize_bright_stroke = map(brightness(stroke_item[ID_item]), 0,100,0,1) ;
    float normalize_alpha_stroke = map(alpha(stroke_item[ID_item]), 0,100,0,1) ;


    // scale
    float scale_x = map(canvas_x_item[ID_item], canvas_x_min_max.x, canvas_x_min_max.y, .1, 8);
    float scale_y = map(canvas_y_item[ID_item], canvas_y_min_max.x, canvas_y_min_max.y, .1, 8);
    Vec3 scale_3D = Vec3(scale_x, scale_y,1) ;

    // beat factor
    if(sound[ID_item]) beat_factor = allBeats(ID_item) ; else beat_factor = 1. ;


    
    // jitter
    

    if(FULL_RENDERING) {
      jitting.set(jitter_x_item[ID_item],jitter_y_item[ID_item],jitter_z_item[ID_item]);
      jitting.mult((int)height/2 *beat_factor) ;
    } else {
      jitting.set(0) ;
    }

    // pos
    Vec3 pos_3D = Vec3 (mouse[ID_item].x,mouse[ID_item].y, mouse[ID_item].z); 
    
    // display and mode
    // classic
    if(mode[ID_item] == 0 ) {
      if(walker) {
        svg_import[ID_item].build() ;
        walker = false ;
      }
      normalize_fill.set(1, normalize_sat_fill,normalize_bright_fill, normalize_alpha_fill) ;
      normalize_stroke.set(1,normalize_sat_stroke,normalize_bright_stroke, normalize_alpha_stroke) ;
      full_svg_3D(pos_3D, scale_3D, jitting, svg_import[ID_item], normalize_fill, normalize_stroke, true) ;
    // classic colour  
    } else if(mode[ID_item] == 1 ) {
      if(walker) {
        svg_import[ID_item].build() ;
        walker = false ;
      }
      normalize_fill.set(normalize_hue_fill, normalize_sat_fill,normalize_bright_fill, normalize_alpha_fill) ;
      normalize_stroke.set(normalize_hue_stroke,normalize_sat_stroke,normalize_bright_stroke, normalize_alpha_stroke) ;
      full_svg_3D(pos_3D, scale_3D, jitting, svg_import[ID_item], normalize_fill, normalize_stroke, thickness_item[ID_item], false) ;
    // walker  
    } else if(mode[ID_item] == 2 && FULL_RENDERING) {
      walker = true ;
      normalize_fill.set(1, normalize_sat_fill,normalize_bright_fill, normalize_alpha_fill) ;
      normalize_stroke.set(1,normalize_sat_stroke,normalize_bright_stroke, normalize_alpha_stroke) ;
      walker_svg_3D(pos_3D, scale_3D, svg_import[ID_item], normalize_fill, normalize_stroke, true) ;
      if(nTouch ) svg_import[ID_item].build() ;
      if(beat_factor > 5 && FULL_RENDERING) svg_import[ID_item].build() ;
    // walker colour
    } else if(mode[ID_item] == 3 && FULL_RENDERING) {
      walker = true ;
      normalize_fill.set(normalize_hue_fill, normalize_sat_fill,normalize_bright_fill, normalize_alpha_fill) ;
      normalize_stroke.set(normalize_hue_stroke,normalize_sat_stroke,normalize_bright_stroke, normalize_alpha_stroke) ;
      walker_svg_3D(pos_3D, scale_3D, svg_import[ID_item], normalize_fill, normalize_stroke, thickness_item[ID_item], false) ;
      if(nTouch ) svg_import[ID_item].build() ;
      if(beat_factor > 5 && FULL_RENDERING) svg_import[ID_item].build() ;
    } else {
      if(walker) {
        svg_import[ID_item].build() ;
        walker = false ;
      }
      normalize_fill.set(1, normalize_sat_fill,normalize_bright_fill, normalize_alpha_fill) ;
      normalize_stroke.set(1,normalize_sat_stroke,normalize_bright_stroke, normalize_alpha_stroke) ;
      full_svg_3D(pos_3D, scale_3D, jitting, svg_import[ID_item], normalize_fill, normalize_stroke, true) ;
    }
  }



  // annexe
  void walker_svg_3D(Vec3 pos_3D, Vec3 scale_3D, RPEsvg svg, Vec4 factor_fill, Vec4 factor_stroke, boolean original_colour) {
    float thickness = 1 ;
    walker_svg_3D(pos_3D, scale_3D, svg, factor_fill, factor_stroke, thickness, original_colour) ;

  }
  void walker_svg_3D(Vec3 pos_3D, Vec3 scale_3D, RPEsvg svg, Vec4 factor_fill, Vec4 factor_stroke, float thickness, boolean original_colour) {
    Vec3 swing = Vec3(swing_x_item[ID_item],swing_y_item[ID_item],swing_z_item[ID_item]) ;
    swing.mult(height /5 *beat_factor) ;
    for(int ID = 0 ; ID < svg.num_brick() ; ID++ ) {
      int length = svg.list_points_of_interest(ID).length ;
      Vec3 [] value = new Vec3[length] ;
      for(int i = 0 ; i < value.length ; i++) {
        value[i] = new Vec3("RANDOM", (int)swing.x, (int)swing.y,(int)swing.z) ;
        value[i].mult(.1) ;
      }
      svg.add_def(ID, value) ;
      svg.pos(pos_3D) ;
      svg.scale(scale_3D) ;
      if(original_colour) {
        svg.original_style(true, true) ;
        svg.fill_factor(factor_fill) ; 
        svg.stroke_factor(factor_stroke) ; 
      } else {
        svg.original_style(false, false) ;
        svg.fill_custom(factor_fill) ; 
        svg.stroke_custom(factor_stroke) ; 
        svg.thickness_custom(thickness) ; 
      }
      svg.draw_3D(ID) ;
    }
  }

  // 
  void full_svg_3D(Vec3 pos_3D, Vec3 scale_3D, Vec3 jitter_3D, RPEsvg svg, Vec4 factor_fill, Vec4 factor_stroke, boolean original_colour) {
    float thickness = 1 ;
    full_svg_3D(pos_3D, scale_3D, jitter_3D, svg, factor_fill, factor_stroke, thickness, original_colour) ;
  }
  void full_svg_3D(Vec3 pos_3D, Vec3 scale_3D, Vec3 jitter_3D, RPEsvg svg, Vec4 factor_fill, Vec4 factor_stroke, float thickness, boolean original_colour) {
    svg.pos(pos_3D) ;
    svg.scale(scale_3D) ;
    svg.jitter(jitter_3D) ;
    if(original_colour) {
      svg.original_style(true, true) ;
      svg.fill_factor(factor_fill) ; 
      svg.stroke_factor(factor_stroke) ; 
    } else {
      svg.original_style(false, false) ;
      svg.fill_custom(factor_fill) ; 
      svg.stroke_custom(factor_stroke) ; 
      svg.thickness_custom(thickness) ; 
    }
    svg.draw_3D() ;
  }
}