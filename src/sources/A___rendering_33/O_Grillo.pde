/**
* Grillo
* the tab is the template that you can duplicate to add the item you want in your Romanesco.
* You must change the class name and this one must be unique.
v 0.0.6
*/
class Grillo extends Romanesco {
  public Grillo() {
    //from the index_objects.csv
    item_name = "Grillo" ;
    item_author  = "Stan le Punk";
    item_references = "";
    item_version = "Version 0.0.6";
    item_pack = "Base 2018-2019";
    item_costume = "point/ellipse/triangle/rect/cross/pentagon/flower/Star 5/Star 7/Super Star 8/Super Star 12"; // costume available from get_costume();
    item_mode = "Random/Automata/Full";
    // define slider
    // COL 1
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
    canvas_y_is = true;
    canvas_z_is = true;
    // COL 2
    // frequence_is = true;
    speed_x_is = true;
    speed_y_is = true;
    speed_z_is = true;
    // spurt_x_is = true;
    // spurt_y_is = true;
    // spurt_z_is = true;
    dir_x_is = true;
    dir_y_is = true;
    dir_z_is = true;
    jit_x_is = true;
    jit_y_is = true;
    jit_z_is  = true;
    swing_x_is = true;
    swing_y_is = true;
    swing_z_is = true;
    // COL 3
    // quantity_is = true;
    // variety_is =true;
    // life_is = true;
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
    // COL 4
    grid_is = true;
    // viscosity_is = true;
    // diffusion_is = true;
    // power_is = true;
    // mass_is = true;

  }

  void setup() {
    // give the starting position of your item on the 3D grid
    setting_start_position(ID_item,width/2,height/2,0);
  }
  
  //DRAW
  vec3 offset [][][];
  vec3 dir [][][];
  boolean grillo_is[][][];
  int ref_num;
  String ref_mode;
  void draw() {
    ivec3 canvas = ivec3(round(map(get_canvas(),get_canvas_x_min(),get_canvas_x_max(),1,19)));
    if(ref_num != canvas.x*canvas.y*canvas.z || !get_mode_name().equals(ref_mode)) {
      reset(canvas);
      if(get_mode_name().equals("Random")) {
        pile_ou_face(canvas,true);
      } else if(get_mode_name().equals("Full")) {
        pile_ou_face(canvas,false);
      }
      ref_mode = get_mode_name();
    }

    direction(canvas);
    offset(canvas);

    if(birth_is()) {
      if(get_mode_name().equals("Random")) {
        pile_ou_face(canvas,true);
      } else {
        pile_ou_face(canvas,false);
      }
      birth_is(false);
    }


    aspect(get_fill(),get_stroke(),get_thickness());
    int cell = (int)map(get_grid(),get_grid_min(),get_grid_max(),5,height);
    for(int x = 0 ; x < canvas.x ; x++) {
      for(int y = 0 ; y < canvas.y ; y++) {
        for(int z = 0 ; z < canvas.z ; z++) {

          if(grillo_is[x][y][z]) {
            float pos_x = -((canvas.x*cell)/2)+(cell/2)+(cell*x);
            float pos_y = -((canvas.y*cell)/2)+(cell/2)+(cell*y);
            float pos_z = -((canvas.z*cell)/2)+(cell/2)+(cell*z);
            vec3 pos = (vec3(pos_x,pos_y,pos_z)).add(offset[x][y][z]);
            manage_costume(pos,dir[x][y][z]);
          }
        }
      }
    }

    // here if you want code in 3D mode
    info("items: "+(canvas.x*canvas.y*canvas.z),"Mode: "+get_mode_name());
  }

  void manage_costume(vec3 pos, vec3 dir) {
    vec3 size = get_size().copy();
    if(get_costume().get_type() == STAR_3D_ROPE) {
      size.div(1,1,10);
    } else if(get_costume().get_type() == CROSS_BOX_3_ROPE || get_costume().get_type() == CROSS_BOX_2_ROPE) {
      set_ratio_costume_size(map(get_area(),get_area_min(),get_area_max(),0,1));
    }
    costume(pos,size,dir,get_costume());
  }

  void direction(ivec3 canvas) {
    if(!get_dir().equals(0) || motion_is()) {
      for(int x = 0 ; x < canvas.x ; x++) {
        for(int y = 0 ; y < canvas.y ; y++) {
          for(int z = 0 ; z < canvas.z ; z++) {
            dir[x][y][z].set(get_dir());
          }
        }
      }
    }
  }


  void offset(ivec3 canvas) {
    if(!get_speed().equals(0) || !get_jitter().equals(0) || motion_is()) {
      vec3 swing = map(get_swing().mult(get_swing()),0,1,0,width/2);
      vec3 s = map(get_speed(),get_speed_x_min(),get_speed_x_max(),0,.01);
      s.x = cos(s.x *frameCount);
      s.y = cos(s.y *frameCount);
      s.z = cos(s.z *frameCount);

      vec3 range = map(get_jitter().mult(get_jitter()),0,1,0,height/2);

      for(int x = 0 ; x < canvas.x ; x++) {
        for(int y = 0 ; y < canvas.y ; y++) {
          for(int z = 0 ; z < canvas.z ; z++) {
            vec3 temp = mult(swing,s);
            // offset[x][y][z].set(temp);
            vec3 jit = vec3().jitter(range);
            offset[x][y][z].set(temp.add(jit));
          }
        }
      }
    }
  }

  void pile_ou_face(ivec3 canvas, boolean coin_toss) {
    for(int x = 0 ; x < canvas.x ; x++) {
      for(int y = 0 ; y < canvas.y ; y++) {
        for(int z = 0 ; z < canvas.z ; z++) {
          if(coin_toss) {
            float pile_ou_face = random(1);
             if(pile_ou_face < .5) {
              grillo_is[x][y][z] = true;
            } else {
              grillo_is[x][y][z] = false;
            }
          } else {
            grillo_is[x][y][z] = true;
          }
        }
      }
    }
  }


  void reset(ivec3 canvas) {
    offset = new vec3[canvas.x][canvas.y][canvas.z];
    dir = new vec3[canvas.x][canvas.y][canvas.z];
    grillo_is = new boolean[canvas.x][canvas.y][canvas.z];
    ref_num = canvas.x*canvas.y*canvas.z;
    for(int x = 0 ; x < canvas.x ; x++) {
      for(int y = 0 ; y < canvas.y ; y++) {
        for(int z = 0 ; z < canvas.z ; z++) {
          offset[x][y][z] = vec3();
          dir[x][y][z] = vec3();
        }
      }
    }
  }
}















