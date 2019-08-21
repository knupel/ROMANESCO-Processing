/**
* Photomontage
* v 0.0.1
* 2019-2019
*/
class Photomontage extends Romanesco {
  public Photomontage() {
    //from the index_objects.csv
    item_name = "Photomontage" ;
    item_author  = "Stan le Punk";
    item_references = "";
    item_version = "Version 0.0.1";
    item_pack = "Base 2019-2019" ;
    item_costume = ""; // costume available from get_costume();
    item_mode = "";
    // define slider
    // COL 1
    hue_fill_is = true;
    sat_fill_is = true;
    bright_fill_is = true;
    alpha_fill_is = true;
    // hue_stroke_is = true;
    // sat_stroke_is = true;
    // bright_stroke_is = true;
    // alpha_stroke_is = true;
    // thickness_is = true;
    size_x_is = true;
    // size_y_is = true;
    // size_z_is = true;
    // diameter_is = true;
    // canvas_x_is = true;
    // canvas_y_is = true;
    // canvas_z_is = true;

    // COL 2
    frequence_is = true;
    // speed_x_is = true;
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

    // COL 4
    // grid_is = true;
    // viscosity_is = true;
    // diffusion_is = true;
    // power_is = true;
    // mass_is = true;
    // amplitude_is = true;
    // coord_x_is = true;
    // coord_y_is = true;
    // coord_z_is = true;
  }


  vec2 [] cloud_mask;
  int [] fill_choses;
  R_Chose [] choses;
  PImage buffer;
  PGraphics mask;

  void setup() {
    // give the starting position of your item on the 3D grid
    // set_item_pos(width/2,height/2,0);
    // set_item_dir(HALF_PI,PI);

    ivec2 num_range_shape = ivec2(5,10);
    create_cloud(num_range_shape);

    ivec2 range_branches = ivec2(3,3);
    ivec2 range_radius = ivec2(width/100,width/2);
    ivec2 range_alpha = ivec2(int(g.colorModeX/3),(int)g.colorModeX);


    create_mask(cloud_mask.length,range_branches,range_radius,range_alpha);
  }
  
  //DRAW
  void draw() {

  }

  void draw_2D() {
    // here if you want code in 2D mode
    int mode_mask = 0; // BW: 0 / RGB: 1
    boolean clear_mask_is = true;
    if(mask == null) {
      mask = createGraphics(width,height,get_renderer());
    }
    render_mask(mask, mode_mask, clear_mask_is);

    boolean on_g = false;
    boolean filter_is = true;
    int step_speparation = 10;
    vec2 threshold = vec2(0,1);
    vec4 level_layer = vec4(1);
    int fx_mode_mask = 0;
    //println(mask.width,mask.height,img_mask.width,img_mask.height);
    if(get_bitmap_collection().size() > 0 && mask != null) {
      buffer = get_bitmap_collection().rand().get_image();
      // println("buffer",buffer);
      // println("buffer dimension",buffer.width,buffer.height);
      // println("mask",mask);
      // println("mask dimension",mask.width,mask.height);
      // buffer = fx_mask(buffer,mask,on_g,filter_is,fx_mode_mask,step_speparation,threshold,level_layer);

      set_background(buffer,SCREEN);
      //set_background(mask,SCREEN);
    }
  }


  // method
  void create_cloud(ivec2 num_range_cloud) {
    int num = (int)random(num_range_cloud.min(),num_range_cloud.max());
    cloud_mask = new vec2[num];
    int marge = 50;
    for(int i = 0 ; i < cloud_mask.length ; i++) {
      cloud_mask[i] = vec2().rand(vec2(-marge,width+marge),vec2(-marge,height+marge));
    }
  }

  void create_mask(int num, ivec2 branch, ivec2 radius, ivec2 alpha) {
    choses = new R_Chose[num];
    fill_choses = new int[num];
    for(int i = 0 ; i < num ; i++) {
      choses[i] = new R_Chose(p5,(int)random(branch.min(),branch.max()));
      fill_choses[i] = color(random(alpha.min(),alpha.max()),random(alpha.min(),alpha.max()),random(alpha.min(),alpha.max())); // give a RGB panel
      float [] relief = new float[(int)random(2,choses[i].get_summits())];
      for(int k = 0 ; k < relief.length ; k++) {
        relief[k] = random(radius.min(),radius.max());
      }
      choses[i].radius(relief);
      choses[i].angle_x(random(TAU));
    }
  }

  void render_mask(PGraphics pg_buffer, int mode, boolean clear_is) {
    if(pg_buffer != null) {
      beginDraw(pg_buffer);
      if(pg_buffer != null && clear_is) {
        clear(pg_buffer);
      }
      
      for (int i = 0 ; i < cloud_mask.length ; i++) {
        if (mode == 0) {
          fill(brightness(fill_choses[i]),pg_buffer);
          noStroke(pg_buffer);
          mask_chose(i,pg_buffer);
        } else if(mode == 1) {
          fill(r.WHITE,pg_buffer);
          noStroke(pg_buffer);
          mask_chose(i,pg_buffer);
        } else if(mode == 2) {
          fill(fill_choses[i],pg_buffer);
          noStroke(pg_buffer);
          mask_chose(i,pg_buffer);
        } 
      }
      endDraw(pg_buffer);
    } 
  }

  void mask_chose(int target, PGraphics pg_buffer) {
    beginShape(pg_buffer);
    choses[target].calc();
    for(int k = 0 ; k < choses[target].get_final_points().length ; k++) {
      vec2 temp_pos = vec2(choses[target].get_final_points()[k]).add(cloud_mask[target].xy());
      vertex(temp_pos,pg_buffer);
    } 
    endShape(CLOSE,pg_buffer);
  }
}















