/**
VECTORIAL
2015-2019
v 0.0.9
*/
class Vectorial extends Romanesco {
 
  public Vectorial() {
    item_name = "Vectorial" ;
    item_author  = "Stan le Punk";
    item_version = "Version 0.0.9";
    item_pack = "Base 2015-2019" ;
    item_costume = "" ;
    item_mode = "Classic original/Classic custom/Walker original/Walker custom" ; // separate the differentes mode by "/"

    hue_fill_is = true;
    sat_fill_is = true;
    bright_fill_is = true;
    alpha_fill_is = true;
    hue_stroke_is  = true;
    sat_stroke_is = true;
    bright_stroke_is = true;
    alpha_stroke_is = true;
    thickness_is = true;
    // size_x_is = true;
    // size_y_is = true;
    // size_z_is = true;
    // diameter_is = true;
    canvas_x_is = true;
    canvas_y_is = true;
    // canvas_z_is = true;

    // frequence_is = true;
    // speed_x_is = true;
    // speed_y_is = true;
    // speed_z_is = true;
    // spurt_x_is = true;
    // spurt_y_is = true;
    // spurt_z_is = true;
    // dir_x_is = true;
    // dir_y_is = true;
    // dir_z_is = true;
    jit_x_is = true;
    jit_y_is = true;
    jit_z_is = true;
    swing_x_is = true;
    swing_y_is = true;
    swing_z_is = true;

    // quantity_is = true;
    // variety_is = true;
    // life_is = true;
    // flow_is = true;
    // quality_is = true;
    // area_is = true;
    // angle_is = true;
    // scope_is = true;
    // scan_is = true;
    // align_is = true;
    // repulsion_is = true;
    // attraction_is = true;
    // density_is = true;
    // influence_is = true;
    // calm_is = true;
    // spectrum_is = true;
  }

  String ref_name = "" ;
  boolean walker  ;
  float beat_factor = 1 ;
  String svg_bricks_saved = "RPE_SVG/bricks/"  ;

  vec3 jitting = vec3(0) ;
  vec4 normalize_fill = vec4(1) ;
  vec4 normalize_stroke = vec4(1) ;
 
  // setup
  void setup() {
    setting_start_position(ID_item, width/2, height/2 +height/4, -height);
    setting_start_direction(ID_item, 30,-20);

    load_svg(ID_item);
    println("svg_current_path",svg_current_path);
    if(svg_current_path != null) {
      svg_import[ID_item].build(svg_current_path, svg_bricks_saved);
      svg_import[ID_item].mode(CENTER);
      ref_name = svg_import[ID_item].name;
    }
  }


  void draw() {
    if(svg_import[ID_item] != null) {
      if(parameter_is()) {
        load_svg(ID_item);
        println("svg_current_path",svg_current_path);
        ref_name = svg_import[ID_item].name ;  
        if(!svg_import[ID_item].name.equals(ref_name)) {
          ref_name = svg_import[ID_item].name ;
          svg_import[ID_item].build(svg_current_path,svg_bricks_saved) ;
          svg_import[ID_item].mode(CENTER);
        }
      }
      if(svg_current_path != null) {
        rendering();
      }
    } 
  }

  void draw_2D() {
    if(svg_import[ID_item] == null) {
      fill(0,0,100);
      textAlign(CENTER);
      textSize(18);
      text("No vectorial media available\nCheck if there is one in your medias library",width/2,height/2);
    }
  }



  void rendering() {
    // color
    float normalize_hue_fill = map(hue(get_fill()),0,360,0,1) ;
    float normalize_sat_fill = map(saturation(get_fill()),0,100,0,1) ;
    float normalize_bright_fill = map(brightness(get_fill()),0,100,0,1) ;
    float normalize_alpha_fill = map(alpha(get_fill()),0,100,0,1) ;

    float normalize_hue_stroke = map(hue(get_stroke()),0,360,0,1) ;
    float normalize_sat_stroke = map(saturation(get_stroke()),0,100,0,1) ;
    float normalize_bright_stroke = map(brightness(get_stroke()),0,100,0,1) ;
    float normalize_alpha_stroke = map(alpha(get_stroke()),0,100,0,1) ;


    // scale
    float scale_x = map(get_canvas_x(), get_canvas_x_min(), get_canvas_x_max(), .1, 8);
    float scale_y = map(get_canvas_y(), get_canvas_y_min(), get_canvas_y_max(), .1, 8);
    vec3 scale_3D = vec3(scale_x, scale_y,1) ;

    // beat factor
    if(sound_is()) beat_factor = all_transient(ID_item) ; else beat_factor = 1. ;


    
    // jitter
    

    if(FULL_RENDERING) {
      jitting.set(get_jitter_x(),get_jitter_y(),get_jitter_z());
      jitting.mult((int)height/2 *beat_factor) ;
    } else {
      jitting.set(0) ;
    }

    // pos
    vec3 pos_3D = vec3 (mouse[ID_item].x,mouse[ID_item].y, mouse[ID_item].z); 

    if(get_mode_id() == 0 ) {
      if(walker) {
        svg_import[ID_item].build() ;
        walker = false ;
      }
      normalize_fill.set(1, normalize_sat_fill,normalize_bright_fill, normalize_alpha_fill) ;
      normalize_stroke.set(1,normalize_sat_stroke,normalize_bright_stroke, normalize_alpha_stroke) ;
      full_svg_3D(pos_3D, scale_3D, jitting, svg_import[ID_item], normalize_fill, normalize_stroke, true) ;
    // classic colour  
    } else if(get_mode_id() == 1 ) {
      if(walker) {
        svg_import[ID_item].build() ;
        walker = false ;
      }
      normalize_fill.set(normalize_hue_fill, normalize_sat_fill,normalize_bright_fill, normalize_alpha_fill) ;
      normalize_stroke.set(normalize_hue_stroke,normalize_sat_stroke,normalize_bright_stroke, normalize_alpha_stroke) ;
      full_svg_3D(pos_3D, scale_3D, jitting, svg_import[ID_item], normalize_fill, normalize_stroke, get_thickness(), false) ;
    // walker  
    } else if(get_mode_id() == 2 && FULL_RENDERING) {
      walker = true ;
      normalize_fill.set(1, normalize_sat_fill,normalize_bright_fill, normalize_alpha_fill) ;
      normalize_stroke.set(1,normalize_sat_stroke,normalize_bright_stroke, normalize_alpha_stroke) ;
      walker_svg_3D(pos_3D, scale_3D, svg_import[ID_item], normalize_fill, normalize_stroke, true) ;
      if(key_n ) svg_import[ID_item].build() ;
      if(beat_factor > 5 && FULL_RENDERING) svg_import[ID_item].build() ;
    // walker colour
    } else if(get_mode_id() == 3 && FULL_RENDERING) {
      walker = true ;
      normalize_fill.set(normalize_hue_fill, normalize_sat_fill,normalize_bright_fill, normalize_alpha_fill) ;
      normalize_stroke.set(normalize_hue_stroke,normalize_sat_stroke,normalize_bright_stroke, normalize_alpha_stroke) ;
      walker_svg_3D(pos_3D, scale_3D, svg_import[ID_item], normalize_fill, normalize_stroke, get_thickness(), false) ;
      if(key_n ) svg_import[ID_item].build() ;
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
  void walker_svg_3D(vec3 pos_3D, vec3 scale_3D, ROPE_svg svg, vec4 factor_fill, vec4 factor_stroke, boolean original_colour) {
    float thickness = 1 ;
    walker_svg_3D(pos_3D, scale_3D, svg, factor_fill, factor_stroke, thickness, original_colour) ;

  }
  void walker_svg_3D(vec3 pos_3D, vec3 scale_3D, ROPE_svg svg, vec4 factor_fill, vec4 factor_stroke, float thickness, boolean original_colour) {
    vec3 swing = vec3(get_swing_x(),get_swing_y(),get_swing_z()) ;
    swing.mult(height /5 *beat_factor) ;
    for(int ID = 0 ; ID < svg.num_brick() ; ID++ ) {
      int length = svg.list_svg_vec(ID).length ;
      vec3 [] value = new vec3[length] ;
      for(int i = 0 ; i < value.length ; i++) {
        value[i] = vec3().rand(vec2(-swing.x,swing.x),vec2(-swing.y,swing.y),vec2(-swing.z,swing.z));
        value[i].mult(.1) ;
      }
      svg.add_def(ID, value) ;
      svg.pos(pos_3D) ;
      svg.scaling(scale_3D) ;
      if(original_colour) {
        svg.original_style(true, true) ;
        svg.fill_factor(factor_fill) ; 
        svg.stroke_factor(factor_stroke) ; 
      } else {
        svg.original_style(false, false) ;
        svg.fill(factor_fill) ; 
        svg.stroke(factor_stroke) ; 
        svg.strokeWeight(thickness) ; 
      }
      svg.draw(ID) ;
    }
  }

  // 
  void full_svg_3D(vec3 pos_3D, vec3 scale_3D, vec3 jitter_3D, ROPE_svg svg, vec4 factor_fill, vec4 factor_stroke, boolean original_colour) {
    float thickness = 1 ;
    full_svg_3D(pos_3D, scale_3D, jitter_3D, svg, factor_fill, factor_stroke, thickness, original_colour) ;
  }
  void full_svg_3D(vec3 pos_3D, vec3 scale_3D, vec3 jitter_3D, ROPE_svg svg, vec4 factor_fill, vec4 factor_stroke, float thickness, boolean original_colour) {
    svg.pos(pos_3D) ;
    svg.scaling(scale_3D) ;
    svg.jitter(jitter_3D) ;
    if(original_colour) {
      svg.original_style(true, true) ;
      svg.fill_factor(factor_fill) ; 
      svg.stroke_factor(factor_stroke) ; 
    } else {
      svg.original_style(false, false) ;
      svg.fill(factor_fill) ; 
      svg.stroke(factor_stroke) ; 
      svg.strokeWeight(thickness) ; 
    }
    svg.draw() ;
  }
}