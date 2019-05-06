/**
Lorenz attractor
2016-2019
v 0.1.5
Inspirated by Nature of Code of Daniel Shiffman
*/
/*
* @see https://www.youtube.com/watch?v=f0lkz2gSsIk&list=PLRqwX-V7Uu6ZiZxtDDRCi6uhfTH4FilpH&index=15
* @see https://en.wikipedia.org/wiki/Lorenz_system
*/
class Lorenz extends Romanesco {
	public Lorenz() {
		item_name = "Lorenz attractor";
		item_author  = "Stan le Punk";
		item_version = "Version 0.1.5";
		item_pack = "Nature of Code 2016-2019";
    item_costume = "point/ellipse/triangle/rect/cross/pentagon/flower/Star 5";
    item_mode = "Costume/Surface";

	  hue_fill_is = true;
    sat_fill_is = true;
    bright_fill_is = true;
    alpha_fill_is = true;
    hue_stroke_is = true;
    sat_stroke_is = true;
    bright_stroke_is = true;
    alpha_stroke_is = true;
    thickness_is = true;
    size_x_is = true;
    size_y_is = true;
    size_z_is = true;
    // diameter_is = true;
    canvas_x_is = true;
    // canvas_y_is = true;
    // canvas_z_is = true;

    // frequence_is = true;
    // speed_x_is = true;
    // speed_y_is = true;
    // speed_z_is = true;
    // spurt_x_is = true;
    // spurt_y_is = true;
    // spurt_z_is = true;
    dir_x_is = true;
    dir_y_is = true;
    dir_z_is = true;
    jit_x_is = true;
    jit_y_is = true;
    jit_z_is = true;
    // swing_x_is = true;
    // swing_y_is = true;
    // swing_z_is = true;

    // quantity_is = true;
    // variety_is = true;
    life_is = true;
    // flow_is = true;
    // quality_is = true;
    area_is = true;
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

  float a = 10;
  float b = 28;
  float c = 8. / 3.;
  vec3 pos;
  ArrayList<vec3> list_points;



  void setup() {
    set_item_pos(width/2,height/2,0);
  }



	void draw() {
    if(list_points == null) {
      pos = vec3(.01, 0, 0) ;
      list_points = new ArrayList<vec3>() ;
    } else {
      build_lorenz_attractor(list_points) ;
      if(alpha(get_fill()) > 0 || get_thickness() > 0) {
        float canvas = get_canvas_x() *.01 ;
        vec3 jitter = get_jitter().copy();
        jitter.mult(height/10) ;
        vec3 size = get_size().copy();
        vec3 dir = get_dir().copy();
        fill(get_fill());
        stroke(get_stroke());
        strokeWeight(get_thickness());
        set_ratio_costume_size(map(get_area(),width*.1, width*TAU,0,1));
        show_lorenz_attractor(size,dir,canvas,jitter,list_points,get_mode_id(),get_costume());
      }


      // keep the size of list reasonable :)
      int max = 5000 ;
      if(!FULL_RENDERING) max /= 50 ;
      int threshold = 2 + int(get_life() *max);
      if(list_points.size() > threshold) {
        int remove_size = list_points.size() - threshold;
        for(int i = 0 ; i < remove_size ; i++) {
          if(i < list_points.size()) list_points.remove(i);
        }  
      }
    }    
  }



  private void build_lorenz_attractor(ArrayList<vec3> list) {
    float dt = .01 ;
    vec3 d = vec3() ;
    d.x = (a * (pos.y -pos.x)) *dt ;
    d.y = (pos.x * (b -pos.z) - pos.y) *dt ;
    d.z = (pos.x * pos.y -c *pos.z) *dt ;
    
    pos.add(d) ;
    vec3 final_pos = pos.copy() ;
    list.add(final_pos) ;
  }


  private void show_lorenz_attractor(vec3 size, vec3 dir, float canvas, vec3 jitter, ArrayList<vec3> list, int mode, Costume costume) {

    if(mode == 1 ) beginShape() ;
    for(vec3 p : list) {
      vec3 pos = p.copy() ;
      pos.mult(canvas,canvas,1);
      vec3 offset = pos.copy().div(2);
      pos.sub(offset.x,offset.y,0);
      pos.jitter(jitter);
      if(mode == 1) {
        vertex(pos) ;
      } else {
        costume(pos,size,dir,costume);
      }
    }
    if(mode == 1) endShape() ;
  }
}












