/**
* Rosace
* 2019-2019
* V 0.0.1
*/

class Rosace extends Romanesco {


  public Rosace() {
    //from the index_objects.csv
    item_name = "Rosace" ;
    item_author  = "Stan le Punk";
    item_version = "Version 0.0.1";
    item_pack = "Base 2019-2019";
    item_mode ="Point/Rose/Crown";
    item_costume = "" ;
    item_mode = "" ;


    //item_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Stroke hue,Stroke sat,Stroke bright,Stroke alpha,Thickness,Size X,Size Y,Size Z,Canvas X,Canvas Y,Quantity,Speed X,Influence" ;
    hue_fill_is = true;
    sat_fill_is = true;
    bright_fill_is = true;
    alpha_fill_is = true;
    hue_stroke_is = true;
    sat_stroke_is  = true;
    bright_stroke_is = true;
    alpha_stroke_is = true;
    // thickness_is = true;
    // size_x_is = true;
    // size_y_is = true;
    // size_z_is = true;
    // diameter_is = true;
    canvas_x_is = true;
    // canvas_y_is = true;
    canvas_z_is = true;
    // COL 2
    // frequence_is = true;
    speed_x_is = true;
    // speed_y_is = true;
    // speed_z_is = true;
    // spurt_x_is = true;
    // spurt_y_is = true;
    // spurt_z_is = true;
    //dir_x_is = true;
    // dir_y_is = true;
    // dir_z_is = true;
    // jit_x_is = true;
    // jit_y_is = true;
    // jit_z_is  = true;
    // swing_x_is = true;
    // swing_y_is = true;
    // swing_z_is = true;
    // COL 3
    quantity_is = true;
    // variety_is =true;
    // life_is = true;
    // flow_is = true;
    quality_is = true;
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
    spectrum_is = true;
    // COL 4
    // grid_is = true;
    // viscosity_is = true;
    // diffusion_is = true;
    // power_is = true;
    // mass_is = true;
    // coord_x_is = true;
    // coord_y_is = true;
    // coord_z_is = true;
  }


  boolean sync_crown_is = true;
  boolean group_is = true;
  boolean point_is = false;
  boolean motion_is = true;
  boolean show_stroke_is = true;
  boolean show_alpha_is = true;
  boolean show_fill_is = true;
  boolean background_is = true;
  boolean switch_fill_stroke_is = false;

  
  
  //SETUP
  void setup() {
    setting_start_position(ID_item,0,0,0);
    parameter_rosace();
    int range_hue = 30;
    generator_rosace(r.BLOOD,r.BLACK,range_hue);
  }
  //DRAW
  float rot_x = 0;
  float rot_y = 0;
  void draw() {
    push();
    translate(width/2,height/2);
    if(motion_is) {
      rotateX(rot_x += .01);
      rotateY(rot_y += .005);
    } else {
      rotateX(rot_x);
      rotateY(rot_y);
    }
    rosace();
    pop();

    // param


    // event
    if(birth_is()) {
      generator_rosace(get_fill(),get_stroke(),get_spectrum());
      birth_is(false);
    }
  }










  /**
  * Rosace Param
  * v 0.0.2
  * 2019-2019
  */

  void parameter_rosace() {
    rosace_complexity = 9;
    num_crown_max = 4;
    random_crown_is = false;

    // here we make setting for different groupe of rose
    rosace_setting = new Rosace_Setting[3];
    
    rosace_setting[0] = new Rosace_Setting();
    rosace_setting[0].set_in(0);
    rosace_setting[0].set_out(2);
    rosace_setting[0].set_range_summits(50,140);
    rosace_setting[0].set_range_relief(width *.6,width*.7);
    rosace_setting[0].set_pos(0,0,-50);

    rosace_setting[1] = new Rosace_Setting();
    rosace_setting[1].set_in(3);
    rosace_setting[1].set_out(5);
    rosace_setting[1].set_range_summits(25,75);
    rosace_setting[1].set_range_relief(width*.8,width*.9);
    rosace_setting[1].set_pos(0,0,0);


    rosace_setting[2] = new Rosace_Setting();
    rosace_setting[2].set_in(6);
    rosace_setting[2].set_out(8);
    rosace_setting[2].set_range_summits(100,200);
    rosace_setting[2].set_range_relief(width*.5,width*.6);
    rosace_setting[2].set_pos(0,0,50);

    for(int i = 0 ; i < rosace_setting.length ; i++) {
      rosace_setting[i].set_offset_range_speed_z(0.02,0.01);
      rosace_setting[i].set_offset_range_z(-300,300);

      rosace_setting[i].set_rot(0.2,0.4);
      rosace_setting[i].set_mut(0.6,0.9);
      rosace_setting[i].set_mut_rad_min(0.7,0.8);
      rosace_setting[i].set_mut_rad_max(.9,1);
      rosace_setting[i].set_thickness(0.5,5);
      rosace_setting[i].set_stroke_alpha(g.colorModeA *.2, g.colorModeA *.7);
      rosace_setting[i].set_fill_alpha(g.colorModeA *.2, g.colorModeA *.7);
    }
  }




  Rosace_Setting [] rosace_setting;
  Rose [] rose;
  Crown [] crown;

  float [] rosace_angle;
  float [] speed_rot_rosace;

  R_Colour colour_fill;
  R_Colour colour_stroke;

  int num_crown_max;
  boolean random_crown_is;
  int rosace_complexity;

  boolean [] flower_is;

  void generator_rosace(int colour_master_fill, int colour_master_stroke, float spectre) {
    init_crown(rosace_complexity,rosace_setting); 
    build_palette(colour_master_fill,colour_master_stroke,spectre);
    rose = new Rose[rosace_complexity];
    build_rose(rose,rosace_setting);
  }


  void init_crown(int num, Rosace_Setting [] setting) {
    int num_crown = 0;
    flower_is = new boolean [num];
    for(int i = 0 ; i < flower_is.length ; i++) {
      flower_is[i] = true;
    }

    if(num > 1) {
      if(num_crown_max > num /2) {
        num_crown_max = num /2;
      }
      if(random_crown_is) {
        num_crown = round(random(num_crown_max));
      } else {
        num_crown = num_crown_max;
      }
      if(num_crown > 0) {
        ArrayList<Integer> list = new ArrayList<Integer>();
        ArrayList<Integer> result = new ArrayList<Integer>();
        for(int i = 0 ; i < num ; i++) {
          list.add(i);
        }


        for(int i = 0 ; i < num_crown*2 ; i++) {
          int index = floor(random(list.size()));
          int id = list.get(index);
          flower_is[id] = false;
          result.add(id);
          list.remove(index);
        }
        crown = new Crown[num_crown];
        for(int i = 0 ; i < crown.length ; i++) {
          int target = i*2;
          int id_main = result.get(target);
          // check which group
          int id_contour = id_contour(id_main,setting);
          crown[i] = new Crown(id_main,id_contour);
        }
      }
    }
  }

  int id_contour(int id_main, Rosace_Setting [] setting) {
    int id_contour = 0;
    for(int i = 0 ; i < setting.length ; i++) {
      if(id_main >= setting[i].in() && id_main <= setting[i].out()) {
        id_contour = id_main+1;
        if(id_contour > setting[i].out()) {
          id_contour = setting[i].in();
        }
        break;
      }
    }
    return id_contour;
  }






  void build_palette(int master_fill, int master_stroke, float spectre) {
    int num = rosace_complexity;
    int num_group_fill = 2;

    int hue_range = int(spectre*.5); // > 360 / 2
    int hue_key_fill = (int)hue(master_fill);
    vec2 range_sat_fill = vec2(saturation(master_fill));
    vec2 range_bri_fill = vec2(brightness(master_fill));
    vec2 range_alp = vec2(100);
    // fill
    int [] list_temp = color_pool(num,num_group_fill, hue_key_fill,hue_range, range_sat_fill,range_bri_fill,range_alp);
    colour_fill = new R_Colour(p5,list_temp);
    println("method build palette(): colour fill size 0",colour_fill.size(0));
    println("method build palette(): colour fill size 1",colour_fill.size(1));
    
    int num_group_stroke = 1;
    int hue_key_stroke = (int)hue(master_stroke);
    vec2 range_sat_stroke = vec2(saturation(master_stroke));
    vec2 range_bri_stroke = vec2(brightness(master_stroke));
    list_temp = color_pool(num,num_group_stroke, hue_key_stroke,hue_range, range_sat_stroke,range_bri_stroke,range_alp);
    colour_stroke = new R_Colour(p5,list_temp);

  }

  void build_rose(Rose [] list, Rosace_Setting [] setting) {
    int num = list.length;
    speed_rot_rosace = new float[num];
    rosace_angle = new float[num];

    for(int i = 0 ; i < setting.length ; i++) { 
      for(int k = setting[i].in() ; k <= setting[i].out() ; k++) {
        // structure
        int summits = (int)random(setting[i].get_range_summits().xy()); 
        int num_relief = (int)random(summits/4,summits/2);
        int min_relief = setting[i].get_range_relief().x();
        int max_relief = setting[i].get_range_relief().y();
        list[k] = new Rose(p5,summits, num_relief, min_relief, max_relief);

        // offset
        float speed_offset_x = random(setting[i].get_offset_range_speed_x());
        float range_min_x = random(setting[i].get_offset_range_x().min());
        float range_max_x = random(setting[i].get_offset_range_x().max());
        list[k].set_offset_x(speed_offset_x,range_min_x,range_max_x);

        float speed_offset_y = random(setting[i].get_offset_range_speed_y());
        float range_min_y = random(setting[i].get_offset_range_y().min());
        float range_max_y = random(setting[i].get_offset_range_y().max());
        list[k].set_offset_y(speed_offset_y,range_min_y,range_max_y);

        float speed_offset_z = random(setting[i].get_offset_range_speed_z());
        float range_min_z = random(setting[i].get_offset_range_z().min());
        float range_max_z = random(setting[i].get_offset_range_z().max());
        list[k].set_offset_z(speed_offset_z,range_min_z,range_max_z);

        // position
        list[k].pos(setting[i].get_pos().xyz());

        // aspect
        list[k].thickness(random(setting[i].get_thickness().xy()));
        int target_fill_group = floor(random(colour_fill.size_group()));
        int target_fill = floor(random(colour_fill.size(target_fill_group)));
        int c_fill = colour_fill.get_colour(target_fill,target_fill_group);
        println("k",k,"size",colour_fill.size(target_fill_group),"target",target_fill,"fill",c_fill);
        list[k].fill(c_fill,random(setting[i].get_fill_alpha().xy()));

        int target_stroke_group = floor(random(colour_stroke.size_group()));        
        int target_stroke = floor(random(colour_stroke.size(target_stroke_group)));
        int c_stroke = colour_stroke.get_colour(target_stroke,target_stroke_group);
        list[k].stroke(c_stroke,random(setting[i].get_stroke_alpha().xy()));

        //rotation
        rosace_angle[k] = 0;
        float direction = random(-1,1);
        if(direction > 0) direction = 1 ; else direction = -1;
        speed_rot_rosace[k] = random(setting[i].get_rot().xy().mult(.03).mult(direction));

        // mutation
        float speed_mutation = random(setting[i].get_mut().xy().mult(.1));
        float min_mutation = random(setting[i].get_mut_rad_min().xy());
        float max_mutation = random(setting[i].get_mut_rad_max().xy());
        list[k].set_mutation(speed_mutation,min_mutation,max_mutation);

      }
    }
  }




  ArrayList<vec3> rosace_pts;
  ArrayList<vec3> get_points_rosaces() {
    if(rosace_pts == null) {
      rosace_pts = new ArrayList<vec3>();
    } else {
      rosace_pts.clear();
    }
    for(int i = 0 ; i < rose.length ; i++) {
      vec3 [] list = get_points_rosace(i);
      for(int k = 0 ; k < list.length ; k++) {
        rosace_pts.add(list[k]);
      }
    }
    return rosace_pts;
  }

  vec3 [] get_points_rosace(int target) {
    if(target >= 0 && target < rosace_complexity) {
      rose[target].angle(rosace_angle[target] += speed_rot_rosace[target]);
      return rose[target].get_final_points();
    } else {
      return null;
    }
  }




  // render
  void rosace() {
    if(point_is) {
      show_points(group_is,show_alpha_is);
    } else {
      rosace_classic(show_fill_is,show_stroke_is,switch_fill_stroke_is,group_is,show_alpha_is,sync_crown_is);
    }
  }



  void rosace_classic(boolean fill_is, boolean stroke_is, boolean switch_is, boolean group_is, boolean alpha_is, boolean sync_crown_altitude_is) { 
    for(int i = 0 ; i < rose.length ; i++) {
      // update angle / rotation
      rose[i].angle(rosace_angle[i] += speed_rot_rosace[i]);
      // display
      if(crown != null && crown.length > 0 && group_is) {
        if(flower_is[i]) {
          aspect_rosace(i,fill_is,stroke_is,switch_is,alpha_is);
          show_flower(i);
        } else {
          // check id of the main element in the crown list
          for(Crown cr : crown) {
            if(cr.get_id().x() == i) {
              aspect_rosace(i,fill_is,stroke_is,switch_is,alpha_is);
              show_crown(cr.get_id().x(),cr.get_id().y(),sync_crown_altitude_is);
            }
          }
        }    
      } else if(crown == null || !group_is) {
        aspect_rosace(i,fill_is,stroke_is,switch_is,alpha_is);
        show_flower(i);
      } 
    }
  }

  void aspect_rosace(int target, boolean fill_is, boolean stroke_is, boolean switch_is, boolean alpha_is) {
    int c_fill = rose[target].fill();
    int c_stroke = rose[target].stroke();
    if(alpha_is) {
      c_fill = color(hue(c_fill),saturation(c_fill),brightness(c_fill));
      c_stroke = color(hue(c_stroke),saturation(c_stroke),brightness(c_stroke));
    }

    if(fill_is) {
      if(!switch_is) {
        fill(c_fill);
      } else {
        fill(c_stroke);
      }
    } else {
      noFill();
    }
    if(stroke_is) {
      if(!switch_is) {
        stroke(c_stroke);
      } else {
        stroke(c_fill);
      }
      strokeWeight(rose[target].thickness());
    } else {
      noStroke();
    }
  }













  /**
  * SHOW
  */
  void show_points(boolean group_is, boolean alpha_is) {
    if(group_is) {
      for(int i = 0 ; i < rosace_complexity; i++) {
        strokeWeight(rose[i].thickness());
        if(alpha_is) {
          stroke(to_hsba(rose[i].fill()));
        } else {
          stroke(to_hsb(rose[i].fill()));
        }
        noFill();
        for(vec3 p : get_points_rosace(i)) {
          point(p);
        }
      }
    } else {
      strokeWeight(rose[0].thickness());
      if(alpha_is) {
        stroke(to_hsba(rose[0].fill()));
      } else {
        stroke(to_hsb(rose[0].fill()));
      }
      noFill();
      for (vec3 p : get_points_rosaces()) {
        point(p);
      }
    }
  }


  void show_flower(int target) {
    rose[target].show();
  }


  void show_crown(int main_rosace, int contour_rosace, boolean sync_altitude_is) {
    vec3 [] main = rose[main_rosace].get_final_points();
    vec3 [] contour = rose[contour_rosace].get_final_points();


    beginShape();
    for(int i = main.length -1 ; i >= 0 ; i--) {
      if(sync_altitude_is ) {
        vertex(main[i].x(),main[i].y(),main[0].z());
      } else {
        vertex(main[i]);
      }
    }

    beginContour();
    for(int i = 0 ; i < contour.length ; i++) {
      if(sync_altitude_is ) {
        vertex(contour[i].x(),contour[i].y(),main[0].z());
      } else {
        vertex(contour[i]);
      }
    }
    endContour();

    endShape(CLOSE);
  }
}















/**
* Rosace
* v 0.0.1
*/
class Rosace_Setting {
  int in = 0;
  int out = 1;
  ivec2 relief = ivec2(10,20);
  ivec2 summits = ivec2(5,12);

  vec3 pos = vec3();

  vec2 offset_range_speed_x = vec2();
  vec2 offset_range_speed_y = vec2();
  vec2 offset_range_speed_z = vec2();
  vec2 offset_range_x = vec2();
  vec2 offset_range_y = vec2();
  vec2 offset_range_z = vec2();

  vec2 rot_speed = vec2(0,1);

  vec2 mut_speed = vec2(0,1);
  vec2 mut_rad_min = vec2(0,0.5);
  vec2 mut_rad_max = vec2(0.5,1);

  vec2 thickness = vec2(1);
  vec2 stroke_alpha = vec2(g.colorModeA);
  vec2 fill_alpha = vec2(g.colorModeA);

  Rosace_Setting () { }

  void set_in(int in) {
    this.in = in;
  }

  void set_out(int out) {
    this.out = out;
  }


  // relief
  void set_range_relief(float min, float max) {
    this.relief.set((int)min,(int)max);
  }
  
  // summit
  void set_range_summits(int min, int max) {
    this.summits.set(min,max);
  }

  // aspect
  void set_thickness(float min, float max) {
    this.thickness.set(min,max);
  }

  void set_stroke_alpha(float min, float max) {
    this.stroke_alpha.set(min,max);
  }

  void set_fill_alpha(float min, float max) {
    this.fill_alpha.set(min,max);
  }


  // behavior
  void set_pos(float x, float y) {
    this.pos.set(x,y,0);
  }

  void set_pos(float x, float y, float z) {
    this.pos.set(x,y,z);
  }

  void set_offset_range_speed_x(float min, float max) {
    this.offset_range_speed_x.set(min,max);;
  }

  void set_offset_range_speed_y(float min, float max) {
    this.offset_range_speed_y.set(min,max);;
  }

  void set_offset_range_speed_z(float min, float max) {
    this.offset_range_speed_z.set(min,max);;
  }

  void set_offset_range_x(float min, float max) {
    this.offset_range_x.set(min,max);
  }

  void set_offset_range_y(float min, float max) {
    this.offset_range_y.set(min,max);
  }

  void set_offset_range_z(float min, float max) {
    this.offset_range_z.set(min,max);
  }


  void set_rot(float min, float max) {
    this.rot_speed.set(min,max);
  }
  
  //mut
  void set_mut(float min, float max) {
    this.mut_speed.set(min,max);
  }
  
  void set_mut_rad_min(float min, float max) {
    this.mut_rad_min.set(min,max);
  }
  
  void set_mut_rad_max(float min, float max) {
    this.mut_rad_max.set(min,max);
  }
  
  
  // get
  vec2 get_thickness() {
    return thickness;
  }

  vec2 get_stroke_alpha() {
    return stroke_alpha;
  }

  vec2 get_fill_alpha() {
    return fill_alpha;
  }


  ivec2 get_range_relief() {
    return relief;
  }

  ivec2 get_range_summits() {
    return summits;
  }

  int in() {
    return in;
  }

  int out() {
    return out;
  }
  
  vec3 get_pos() {
    return pos;
  }
  
  // offset
  vec2 get_offset_range_speed_x() {
    return offset_range_speed_x;
  }

  vec2 get_offset_range_speed_y() {
    return offset_range_speed_y;
  }

  vec2 get_offset_range_speed_z() {
    return offset_range_speed_z;
  }

  vec2 get_offset_range_x() {
    return offset_range_x;
  }

  vec2 get_offset_range_y() {
    return offset_range_y;
  }

  vec2 get_offset_range_z() {
    return offset_range_z;
  }



  vec2 get_rot() {
    return rot_speed;
  }

  vec2 get_mut() {
    return mut_speed;
  }
  
  vec2 get_mut_rad_min() {
    return mut_rad_min;
  }
  
  vec2 get_mut_rad_max() {
    return mut_rad_max;
  }
}





/**
* Crown
* v 0.0.1
* 2019-2019
*/
public class Crown {
  private ivec2 id;
  public Crown(int main_id, int contour_id) {
    this.id = ivec2(main_id,contour_id);
  }

  public ivec2 get_id() {
    return id;
  }
}






/**
* Rosace
* v 0.0.3
* 2019-2019
* Objet fait en mémoire de l'incendie de Notre-Dame de Paris, le 15 avril 2019
* et de ses rosaces qui furent en péril
*/
import rope.costume.R_Chose;
class Rose {
  R_Chose chose;
  float [] relief;
  float angle = 0;

  float speed_offset_x;
  vec2 offset_range_x = vec2();
  float speed_offset_y;
  vec2 offset_range_y = vec2();
  float speed_offset_z;
  vec2 offset_range_z = vec2();


  float speed_mutation = 0;
  float min_mutation = 0;
  float max_mutation = 1;

  int fill = r.WHITE;
  int stroke = r.BLACK;
  float thickness = 1;
  float fill_alpha = g.colorModeA;
  float stroke_alpha = g.colorModeA;

  Rose(PApplet pa, int summits, int num_relief, int min, int max) {
    chose = new R_Chose(pa,summits);
    chose.is_pair();
    relief = new float[num_relief];
    for(int i = 0 ; i < relief.length ; i++) {
      relief[i] = random(min,max);
    }
    chose.pos(width/2,height/2);
    chose.symmetric_is(true);
  }


  void pos(vec pos) {
    pos(pos.x(),pos.y(),pos.z());
  }

  void pos(float x, float y, float z) {
    chose.pos(x,y,z);
  }

  void pos(float x, float y) {
    chose.pos(x,y,0);
  }




  void set_offset_x(float speed_x, float min_x, float max_x) {
    this.speed_offset_x = speed_x;
    offset_range_x.set(min_x,max_x);
  }

  void set_offset_y(float speed_y, float min_y, float max_y) {
    this.speed_offset_y = speed_y;
    offset_range_y.set(min_y,max_y);
  }

  void set_offset_z(float speed_z, float min_z, float max_z) {
    this.speed_offset_z = speed_z;
    offset_range_z.set(min_z,max_z);
  }

  void angle(float angle) {
    this.angle = angle;
  }

  void set_mutation(float speed, float min, float max) {
    this.speed_mutation = speed;
    this.min_mutation = min;
    this.max_mutation = max;
  }

  boolean symmetric_is() {
    return chose.symmetric_is();
  }

  void symmetric_is(boolean is) {
    chose.symmetric_is(is);
  }

  void fill(int fill) {
    this.fill = fill;
  }

  void fill(int fill, float alpha) {
    if(g.colorMode == 3) {
      this.fill = color(hue(fill),saturation(fill),brightness(fill),alpha);
    } else {
      this.fill = color(red(fill),green(fill),blue(fill),alpha);
    }
    this.fill_alpha = alpha;
  }



  void stroke(int stroke) {
    this.stroke = stroke;
  }

  void stroke(int stroke, float alpha) {
    if(g.colorMode == 3) {
      this.stroke = color(hue(stroke),saturation(stroke),brightness(stroke),alpha);
    } else {
      this.stroke = color(red(stroke),green(stroke),blue(stroke),alpha);
    }
    this.stroke_alpha = alpha;
    
  }

  void thickness(float thickness) {
    this.thickness = thickness;
  }

  int fill() {
    return fill;
  }

  int stroke() {
    return stroke;
  }

  float fill_alpha() {
    return fill_alpha;
  }

  float stroke_alpha() {
    return stroke_alpha;
  }

  float thickness() {
    return  thickness;
  }

  vec3 [] get_final_points() {
    chose.angle(angle);
    chose.radius(mutation(speed_mutation,min_mutation,max_mutation,relief));
    chose.calc();
    chose.get_final_points();
    vec3 offset = offset();
    if(!offset.equals(vec3(0))) {
      vec3 [] temp =  chose.get_final_points();
      vec3 of = offset();
      for(int i = 0 ; i < temp.length ; i++) {
        temp[i].add(of);
      }
      return temp;

    } else {
      return chose.get_final_points();
    }
  }

  void show() {
    chose.angle(angle);
    chose.radius(mutation(speed_mutation,min_mutation,max_mutation,relief));
    chose.calc();
    vec3 offset = offset();
    beginShape();
    for(int i = 0 ; i < chose.get_summits() ; i++) {
      vertex(chose.get_final_point(i).add(offset));
    }
    vertex(chose.get_final_point(0)); // close
    endShape();
  }


  vec3 offset() {
    float ox = map(sin(frameCount *speed_offset_x),-1,1,offset_range_x.min(),offset_range_x.max());
    float oy = map(sin(frameCount *speed_offset_y),-1,1,offset_range_y.min(),offset_range_y.max());
    float oz = map(sin(frameCount *speed_offset_z),-1,1,offset_range_z.min(),offset_range_z.max());
    return vec3(ox,oy,oz);
  }

  float [] pow_mut;
  float [] mutation(float speed,float min, float max,float [] list) {
    if(pow_mut == null || pow_mut.length != list.length) {
      pow_mut = new float[list.length];
      for(int i = 0 ; i < pow_mut.length ; i++) {
        pow_mut[i] = random(1)*speed;
      }
    }
    
    float [] mut = new float[list.length];
    for(int i = 0 ; i < list.length ; i++) {
      float result = map(sin(frameCount *pow_mut[i]),-1,1,min,max);
      mut[i] = result*list[i];

    }
    return mut;
  }
}