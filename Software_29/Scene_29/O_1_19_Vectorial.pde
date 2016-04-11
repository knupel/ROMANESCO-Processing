/**
VECTORIAL || 2015 || 0.0.1
*/

class Vectorial extends Romanesco {
 
  public Vectorial() {
    RPE_name = "Vectorial" ;
    ID_item = 19 ;
    ID_group = 1 ;
    RPE_author  = "Stan le Punk";
    RPE_version = "Version 0.0.1";
    RPE_pack = "Base 2016" ;
    RPE_mode = "" ; // separate the differentes mode by "/"
    RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Stroke hue,Stroke sat,Stroke bright,Stroke alpha,Thickness,Jitter X,Jitter Y,Jitter Z,Canvas X,Canvas Y" ;
  }

 
  // setup
  void setting() {
    startPosition(ID_item, 0, 0, -height) ;
     load_svg(ID_item) ;
    svg_import[ID_item].svg_mode(CENTER) ;
  }


  void display() {
    if(parameter[ID_item]) load_bitmap(ID_item) ;

    // scale
    float scale_x = map(canvas_x_item[ID_item], canvas_x_min_max.x, canvas_x_min_max.y, .1, 8);
    float scale_y = map(canvas_y_item[ID_item], canvas_y_min_max.x, canvas_y_min_max.y, .1, 8);
    Vec3 scale_3D = Vec3(scale_x, scale_y,0) ;

    
    // jitter
    Vec3 jitting = Vec3(jitter_x_item[ID_item],jitter_y_item[ID_item],jitter_z_item[ID_item]);
    jitting.mult((int)height/2) ;

    // pos
    Vec3 pos_3D = Vec3 (mouse[ID_item].x,mouse[ID_item].y, mouse[ID_item].z); 
    
    // display
    full_svg_3D(pos_3D, scale_3D, jitting, svg_import[ID_item]) ;

   }

   void full_svg_3D(Vec3 pos_3D, Vec3 scale_3D, Vec3 jitter_3D, RPEsvg svg) {
    svg.pos(pos_3D) ;
    svg.scale(scale_3D) ;
    svg.jitter(jitter_3D) ;
    svg.original_style(true, true) ;
    svg.draw_3D() ;
  }
}