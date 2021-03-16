/**
* Rosace
* 2019-2021
* V 0.1.4
*/

class Rosace extends Romanesco {


  public Rosace() {
    //from the index_objects.csv
    item_name = "Rosace" ;
    item_author  = "Stan le Punk";
    item_version = "Version 0.1.4";
    item_pack = "Base 2019-2019";
    item_mode ="rosace/rose/crown/pillar";
    item_costume = "surface/line/face/point";


    //item_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Stroke hue,Stroke sat,Stroke bright,Stroke alpha,Thickness,Size X,Size Y,Size Z,Canvas X,Canvas Y,Quantity,Speed X,Influence" ;
    hue_fill_is = true;
    sat_fill_is = true;
    bright_fill_is = true;
    alpha_fill_is = true;
    hue_stroke_is = true;
    sat_stroke_is  = true;
    bright_stroke_is = true;
    alpha_stroke_is = true;
    thickness_is = true;
    // size_x_is = true;
    // size_y_is = true;
    // size_z_is = true;
    diameter_is = true;
    canvas_x_is = true;
    // canvas_y_is = true;
    canvas_z_is = true;
    // COL 2
    // frequence_is = true;
    speed_x_is = true;
    // speed_y_is = true;
    // speed_z_is = true;
    spurt_x_is = true;
    // spurt_y_is = true;
    // spurt_z_is = true;
    dir_x_is = true;
    dir_y_is = true;
    // dir_z_is = true;
    // jit_x_is = true;
    // jit_y_is = true;
    // jit_z_is  = true;
    swing_x_is = true;
    // swing_y_is = true;
    // swing_z_is = true;
    // COL 3
    quantity_is = true;
    variety_is =true;
    // life_is = true;
    // flow_is = true;
    quality_is = true;
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
    spectrum_is = true;
    // COL 4
    // grid_is = true;
    // viscosity_is = true;
    // diffusion_is = true;
    // power_is = true;
    // mass_is = true;
    amplitude_is = true;
    // coord_x_is = true;
    // coord_y_is = true;
    // coord_z_is = true;
  }
  

  boolean pillar_is = false;

  boolean sync_crown_is = true;
  boolean show_crown_is = true;
  boolean crown_mode_is = false;

  boolean group_is = true;
  boolean motion_is = true;


  boolean show_alpha_is = true;
  boolean show_stroke_is = true;
  boolean show_fill_is = true;

  boolean background_is = true;
  boolean switch_fill_stroke_is = false;






  
  
  //SETUP
  void setup() {
    set_item_pos(width/2,height/2,0);
    set_item_dir(0,QUARTER_PI);
    parameter_rosace(crown_mode_is);
    build_palette();
    generator_rosace();
  }


  //DRAW
  vec3 rotation;
  int direction = 1;
  void draw() {
    // update
    if(rotation == null) {
      rotation = vec3();
    }
    float sx = map(get_dir_x().value(),get_dir_x().min(),get_dir_x().max(),0,1);
    float sy = map(get_dir_y().value(),get_dir_y().min(),get_dir_y().max(),0,1);
    vec3 speed = vec3(sx,sy,get_speed_x().value());
    rotation.add(speed.pow(3));
    rotation.mult(direction);

    push();
    if(motion_is) {
      rotation.add(speed);
    }
    rotateXYZ(rotation);
    rosace(pillar_is);
    pop();

    // build
    if(birth_is()) {
      build_palette();
      generator_rosace();
    }



    

    // end of build if necessary
    birth_is(false);

    sync_crown_is = special_is();
    motion_is = motion_is();
    show_alpha_is = alpha_is();
    show_stroke_is = stroke_is();
    show_fill_is = fill_is();
    
    if(get_mode_name().equals("rosace")) {
      show_crown_is = true;
      crown_mode_is = false;
      pillar_is = false;
    } if(get_mode_name().equals("rose")) {
      show_crown_is = false;
      crown_mode_is = false;
      pillar_is = false;
    } else if(get_mode_name().equals("crown")) {
      show_crown_is = true;
      crown_mode_is = true;
      pillar_is = false;
    } else if(get_mode_name().equals("pillar")) {
      show_crown_is = false;
      crown_mode_is = false;
      pillar_is = true;
    } 

    parameter_rosace(crown_mode_is);

    if(reverse_is()) {
      direction = -1;
    } else {
      direction = 1;
    }
  }




  /**
  * COLOUR PALETTE
  */
  R_Colour colour_fill;
  R_Colour colour_stroke;
  void build_palette() {
    int num_colour_fill =10;
    int num_group_colour_fill =2;
    colour_fill = new R_Colour(p5, hue_palette(get_fill(),num_group_colour_fill,num_colour_fill,get_spectrum().value()));
    int num_colour_stroke =10;
    int num_group_colour_stroke =2;
    colour_stroke = new R_Colour(p5, hue_palette(get_stroke(),num_group_colour_stroke,num_colour_stroke,get_spectrum().value()));
  }


  /**
  * Rosace Param
  * v 0.0.3
  * 2019-2019
  */
  void generator_rosace() {
    init_crown(rosace_complexity,rosace_setting); 
    rose = new Rose[rosace_complexity];
    build_rose(rose,rosace_setting,colour_fill,colour_stroke);
    pillar_build(true,colour_fill,colour_stroke); 
  }


  Rosace_Setting [] rosace_setting;
  int num_crown_max;
  int rosace_complexity;
  void parameter_rosace(boolean crown_mode) {
    // catch slider param
    float quantity = get_quantity().normal() *get_quantity().normal();
    float variety = get_variety().value();
    float quality = get_quality().value();
    float canvas_normal = map(get_canvas_x().value(),get_canvas_x().min(),get_canvas_x().max(),0,1);
    canvas_normal *= canvas_normal;
    float canvas = get_canvas_x().value() *canvas_normal;

    float diam_normal = map(get_diameter().value(),get_diameter().min(),get_diameter().max(),0,1);
    diam_normal *= diam_normal;
    float diam = get_diameter().value() *diam_normal;

    vec2 range_speed_z = vec2(1).add(-get_spurt_x().value(),get_spurt_x().value()).mult(.01);
  
    float ratio_alt = get_canvas_z().normal();
    float altitude = get_canvas_z().value() *ratio_alt;


    vec2 mut = vec2(1).add(-get_swing_x().value(),get_swing_x().value());
    float norm_area = map(get_area().value(),get_area().min(),get_area().max(),0,1);
    vec2 mut_rad_min = vec2(1).sub(norm_area).add(-get_amplitude().value(),get_amplitude().value());
    vec2 mut_rad_max = vec2(1).add(norm_area).add(-get_amplitude().value(),get_amplitude().value());

    int ratio_summit = (int)map(quality,0,1,3,100);

    float range_relief_min = diam;
    float range_relief_max = canvas;

    rosace_complexity = (int)map(quantity,0,1,3,111);
    // make rose complexity is pair to have only crown and no rose
    if(crown_mode && rosace_complexity%2 != 0) {
      rosace_complexity += 1;
    } 
    if(!crown_mode) {
      num_crown_max = (int)map(variety,0,1,0,rosace_complexity/2);
    } else {
      num_crown_max = rosace_complexity/2;
    }

    // here we make setting for different groupe of rose
    int num_group = 3;
    rosace_setting = new Rosace_Setting[num_group];
    int[] alt = new int[num_group];
    alt[0] = int(- 1 * altitude);
    alt[1] = 0;
    alt[2] = (int)altitude;

    int [] in = new int[num_group];
    int [] out = new int[num_group];
    in[0] = 0;
    out[0] = floor(random(in[0],rosace_complexity-2));
    in[1] = out[0]+1;
    out[1] = floor(random(in[1],rosace_complexity-3));
    in[2] = out[1]+1;
    out[2] = rosace_complexity -1;

    

    for(int i = 0 ; i < rosace_setting.length ; i++) {
      rosace_setting[i] = new Rosace_Setting();
      rosace_setting[i].set_range_summits(3*ratio_summit,9*ratio_summit);
      rosace_setting[i].set_range_relief(range_relief_min,range_relief_max);
      rosace_setting[i].set_pos(0,0,alt[i]);
      rosace_setting[i].set_in(in[i]);
      rosace_setting[i].set_out(out[i]);
      rosace_setting[i].set_offset_range_speed_z(range_speed_z.min(),range_speed_z.max());
      rosace_setting[i].set_offset_range_z(-altitude,altitude);

      rosace_setting[i].set_rot(0.2,0.4);
      rosace_setting[i].set_mut(mut.min(),mut.max());
      
      rosace_setting[i].set_mut_rad_min(mut_rad_min.min(),mut_rad_min.max());
      rosace_setting[i].set_mut_rad_max(mut_rad_max.min(),mut_rad_max.max());

      rosace_setting[i].set_thickness(0,height *.1);
      rosace_setting[i].set_stroke_alpha(g.colorModeA *.2, g.colorModeA *.8);
      rosace_setting[i].set_fill_alpha(g.colorModeA *.2, g.colorModeA *.8);
    }
  }









  /**
  * build part
  */
  Rose [] rose;
  Crown [] crown;
  float [] rosace_angle;
  float [] speed_rot_rosace;
  boolean [] flower_is;

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
      num_crown = num_crown_max;

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

  void build_rose(Rose [] list, Rosace_Setting [] setting, R_Colour r_fill, R_Colour r_stroke) {
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
        int target_fill_group = floor(random(r_fill.size_group()));
        int target_fill = floor(random(r_fill.size(target_fill_group)));
        int c_fill = r_fill.get_colour(target_fill_group,target_fill);
        list[k].fill(c_fill,random(setting[i].get_fill_alp().xy()));

        int target_stroke_group = floor(random(r_stroke.size_group()));        
        int target_stroke = floor(random(r_stroke.size(target_stroke_group)));
        int c_stroke = r_stroke.get_colour(target_stroke_group,target_stroke);
        list[k].stroke(c_stroke,random(setting[i].get_stroke_alp().xy()));

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



  // render
  void rosace(boolean pillar_is) {
    // from slider
    float alpha_fill = map(get_fill_alp().value(),get_fill_alp().min(),get_fill_alp().max(),0,1);
    float alpha_stroke = map(get_stroke_alp().value(),get_stroke_alp().min(),get_stroke_alp().max(),0,1);
    float thickness = map(get_thickness().value(),get_thickness().min(),get_thickness().max(),0,1);
    
    update_rosace();
    // render
    if(!pillar_is) {
      rosace_surface(show_fill_is,show_stroke_is,switch_fill_stroke_is,group_is,show_alpha_is,sync_crown_is,show_crown_is,alpha_fill,alpha_stroke,thickness);
    } else {   
      pillar_show();
    }
  }


  void update_rosace() {
    for(int i = 0 ; i < rose.length ; i++) {
      rose[i].angle(rosace_angle[i] += speed_rot_rosace[i]);
      rose[i].update();
    }
  }






















  /**
  * SHOW 
  * CLASIC ROSACE
  */
  void rosace_surface(boolean fill_is, boolean stroke_is, boolean switch_is, boolean group_is, boolean alpha_is, boolean sync_crown_altitude_is, boolean show_crown_is, float fill_alp, float stroke_alp, float thickness) { 
    for(int i = 0 ; i < rose.length ; i++) {
      // update angle / rotation
      // rose[i].angle(rosace_angle[i] += speed_rot_rosace[i]);
      // display
      if(show_crown_is && crown != null && crown.length > 0 && group_is) {
        if(flower_is[i]) {
          aspect_rosace(i,fill_is,stroke_is,switch_is,alpha_is, fill_alp, stroke_alp, thickness);
          show_flower(i);
        } else {
          // check id of the main element in the crown list
          for(Crown cr : crown) {
            if(cr.get_id().x() == i) {
              aspect_rosace(i,fill_is,stroke_is,switch_is,alpha_is, fill_alp, stroke_alp, thickness);
              show_crown(cr.get_id().x(),cr.get_id().y(),sync_crown_altitude_is);
            }
          }
        }    
      } else if(!show_crown_is || crown == null || !group_is) {
        aspect_rosace(i,fill_is,stroke_is,switch_is,alpha_is, fill_alp, stroke_alp, thickness);
        show_flower(i);
      } 
    }
  }

  void aspect_rosace(int target, boolean fill_is, boolean stroke_is, boolean switch_is, boolean alpha_is, float fill_alp, float stroke_alp, float thickness) {
    int c_fill = rose[target].fill();
    int c_stroke = rose[target].stroke();
    if(!alpha_is) {
      c_fill = color(hue(c_fill),saturation(c_fill),brightness(c_fill),g.colorModeA);
      c_stroke = color(hue(c_stroke),saturation(c_stroke),brightness(c_stroke),g.colorModeA);
    } else {
      c_fill = color(hue(c_fill),saturation(c_fill),brightness(c_fill),alpha(c_fill) *fill_alp);
      c_stroke = color(hue(c_stroke),saturation(c_stroke),brightness(c_stroke),alpha(c_stroke) *stroke_alp);
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
      strokeWeight(rose[target].thickness() *thickness);
    } else {
      noStroke();
    }
  }

  /**
  * SHOW 
  * RAW NODE
  */
  void show_node() {
    for(R_Node node : node_list) {
      stroke(get_fill());
      strokeWeight(get_thickness().value());
      noFill();
      point(node.pointer());
    }
  }























  /**
  * SHOW PILLAR MODE
  */
  R_Plane [] plane ;
  ArrayList<R_Node> node_list;
  ArrayList<R_Face> face_list;
  R_Colour pillar_palette_fill;
  R_Colour pillar_palette_stroke;

  void pillar_build(boolean build_is, R_Colour palette_fill, R_Colour palette_stroke) {
    // setting
    int num_plane = 5;
    float range_pillar_plane = 20;
    plane = new R_Plane[num_plane];
    int dist_min = 20;
    int dist_max = 100;
    int max_pass = 100;
    int max_faces = 100 / plane.length;
    int mode_selection = r.RAND;
    // int mode_selection = NORMAL;
    // int mode_selection = LINE;


    // BUILD PALETTE
    pillar_palette_fill = new R_Colour(p5);
    for(int i = 0 ; i < num_plane ; i++) {
      int target_group = floor(random(palette_fill.size_group()));
      int target_colour = floor(random(palette_fill.size(target_group)));
      pillar_palette_fill.add(palette_fill.get_colour(target_group,target_colour));
    }

    pillar_palette_stroke = new R_Colour(p5);
    for(int i = 0 ; i < num_plane ; i++) {
      int target_group = floor(random(palette_stroke.size_group()));
      int target_colour = floor(random(palette_stroke.size(target_group)));
      pillar_palette_stroke.add(palette_fill.get_colour(target_group,target_colour));
    }


    // BUILD SETTING
    if(node_list == null) {
      node_list = new ArrayList<R_Node>();
    } else {
      node_list.clear();
    }

    // UPDATE ROSE POSITION
    for(int i = 0 ; i < rose.length ; i++) {
      rose[i].angle(rosace_angle[i] += speed_rot_rosace[i]);
      rose[i].update();
      int length = rose[i].get_final_points().length;
      for(int k = 0 ; k < length ; k++) {
        R_Node node = new R_Node(rose[i].get_final_points()[k]);
        node_list.add(node);
        // node.set_branch(20); by default is 4     
      }
    }

   
    // BUILD PLANE
    for(int i = 0 ; i < plane.length ; i++) {
      float step_first = (float)rose[0].get_final_points().length / num_plane;
      vec3 a = rose[0].get_final_points()[floor(i*step_first)];
      // BUILD NODE
      float step_last = (float)rose[rose.length-1].get_final_points().length / num_plane;
      vec3 b = rose[rose.length-1].get_final_points()[floor(i*step_last)];
      vec3 c = rose[rose.length-1].get_final_points()[floor(i*step_last)+1];
      plane[i] = new R_Plane(a,b,c);

      plane[i].set_range(range_pillar_plane);
      for(R_Node node : node_list) {
        plane[i].add(node);
      }
      
      // BUILD FACE
      float step = get_spectrum().value() / plane.length;
      if(plane[i].get_nodes() != null && (face_list == null || birth_is())) {
        if(face_list == null) {
          face_list = new ArrayList<R_Face>();
        }
        if(i == 0) face_list.clear();
        generate_faces(face_list, plane[i].get_nodes(), max_pass, mode_selection,ivec2(dist_min,dist_max),max_faces,palette_fill.get_colour(0,i));
        max_faces += max_faces;        
      }
    }
  }


  void pillar_show() {
    
    if(get_costume().get_name().toLowerCase().equals("point")) {
      pillar_show_point(pillar_palette_fill);
    }
    if(get_costume().get_name().toLowerCase().equals("surface")) {
      pillar_show_surface(pillar_palette_fill);
    }

    if(get_costume().get_name().toLowerCase().equals("line")) {
      pillar_show_line(pillar_palette_fill);
    }

    if(get_costume().get_name().toLowerCase().equals("face")) {
      pillar_show_faces(pillar_palette_fill);    
    }
  }


  


  void pillar_show_line(R_Colour palette) {

  }

  void pillar_show_faces(R_Colour palette) {
    noStroke();
    if(face_list != null) {
      for(R_Face f : face_list) {
        fill(f.get_fill());
        f.show();
      }
    }
  }

  void pillar_show_surface(R_Colour palette) {
    // surface
    for(int i = 0 ; i < plane.length ; i++) {
      fill(palette.get_colour(0,i));
      noStroke();
      if(plane[i].get_nodes() != null) {
        beginShape();
        for(R_Node node : plane[i].get_nodes()) {
          vertex(node.pointer());
        }
        endShape(CLOSE);
      }
    }
  }

  void pillar_show_point(R_Colour palette) {
    for(int i = 0 ; i < plane.length ; i++) {
      stroke(palette.get_colour(0,i));
      strokeWeight(get_thickness().value());
      noFill();

      if(plane[i].get_nodes() != null) {
        for(R_Node node : plane[i].get_nodes()) {
          point(node.pointer());
        }
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
      if(sync_altitude_is) {
        vertex(contour[i].x(),contour[i].y(),main[0].z());
      } else {
        vertex(contour[i]);
      }
    }
    endContour();

    endShape(CLOSE);
  }








  //faces part
  void generate_faces(ArrayList<R_Face> face_list, ArrayList<R_Node> original, int max_pass, int mode_selection, ivec2 dist, int max_faces, int colour) {
    ArrayList<R_Node> temp = new ArrayList<R_Node>();
    temp = original;
    int count = 0 ;
    while(temp.size() > 2 && count < max_pass && face_list.size() < max_faces) {
      tirage_faces(face_list,temp,mode_selection,dist,max_faces,colour);
      clean_list_faces(temp);
      count++;
    }
  }

  void clean_list_faces(ArrayList<R_Node> list) {
    for(int i = list.size()-1 ; i >= 0 ; i--) {
      R_Node node = list.get(i);
      if(node.get_branch() < 1) list.remove(i);
    }
  }

  boolean tirage_faces(ArrayList<R_Face> face_list, ArrayList<R_Node> list, int sorting_mode, ivec2 dist, int max_faces, int colour) {
    int max = list.size()-2;
    boolean match_is = false;
    R_Node [] p = new R_Node[3];
    for(int i = 0 ; list.size() >= 3  && i < max  && face_list.size() < max_faces ; i++) {
      ivec3 target = selection_faces(list,sorting_mode,i);

      p[0] = list.get(target.x());
      p[1] = list.get(target.y());
      p[2] = list.get(target.z());

      if(target.x() != target.y() && target.x() != target.z() && target.y() != target.z()) {
        vec3 a = vec3(p[0].pointer());
        vec3 b = vec3(p[1].pointer());
        vec3 c = vec3(p[2].pointer());
        vec3 barycenter = barycenter(a,b,c);
        if(dist_to_barycenter_faces(barycenter,dist,a,b,c)) {
          R_Face f = new R_Face(p5,
                                list.get(target.x()).pointer(),
                                list.get(target.y()).pointer(),
                                list.get(target.z()).pointer());
          f.fill(colour);
          f.stroke(colour);
          face_list.add(f);
          match_is = true;
          p[0].set_branch(p[0].get_branch()-1);
          p[1].set_branch(p[1].get_branch()-1);
          p[2].set_branch(p[2].get_branch()-1);
        } 
      }
    }
    return match_is;
  }

  ivec3 selection_faces(ArrayList<R_Node> list, int mode, int first_target) {
    ivec3 target = ivec3();
    // RANDOM
    if(mode == r.RAND) {
      target.x(floor(random(list.size())));
      // next summits
      target.y(floor(random(list.size())));
      target.z(floor(random(list.size())));
    
    // SEMI_RANDOM  
    } else if(mode == NORMAL) {
      target.x(floor(random(list.size())));
      // next summits
      if(target.x()+1 >= list.size()) {
        target.y(target.x()+1-list.size());
      } else {
        target.y(target.x()+1);
      }
      if(target.x()+2 >= list.size()) {
        target.y(target.x()+2-list.size());
      } else {
        target.y(target.x()+2);
      }

    // LINE
    } else if(mode == LINE) {
      if(first_target >= list.size()) {
        target.x(first_target-list.size());
      } else {
        target.x(first_target);
      }
      // next summits
      if(first_target+1 >= list.size()) {
        target.y(first_target+1-list.size());
      } else {
        target.y(first_target+1);
      }
      if(first_target+2 >= list.size()) {
        target.y(first_target+2-list.size());
      } else {
        target.y(first_target+2);
      }
    // END
    }
    return target;
  }



  boolean dist_to_barycenter_faces(vec3 barycenter, ivec2 dist, vec3... list) {
    boolean in_is = true;
    for(int i = 0 ; i < list.length ; i++) {
      float distance = dist(barycenter,list[i]);
      if(distance > dist.min() && distance < dist.max()) {
        in_is = true;
      } else {
        in_is = false;
        break;
      }
    }
    return in_is;
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

  vec2 get_stroke_alp() {
    return stroke_alpha;
  }

  vec2 get_fill_alp() {
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
* v 0.1.0
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


  void update() {
    chose.angle_x(angle);
    chose.radius(mutation(speed_mutation,min_mutation,max_mutation,relief));
    chose.calc();
    chose.get_final_points();
    vec3 offset = offset();
    if(!offset.equals(vec3(0))) {
      vec3 [] temp = chose.get_final_points();
      vec3 of = offset();
      for(int i = 0 ; i < temp.length ; i++) {
        temp[i].add(of);
      }
    } 
  }

  vec3 [] get_final_points() {
    return chose.get_final_points();
  }

  void show() {
    chose.angle_x(angle);
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









