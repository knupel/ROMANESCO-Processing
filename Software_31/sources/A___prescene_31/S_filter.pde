
/**
FILTER
2018-2018
v 0.0.1
*/
int ref_cell_size =20;
int type_field;
int pattern_field;
Force_field force_romanesco;
Warp warp_romanesco;
void init_filter() {
  type_field = r.FLUID;
  pattern_field = r.BLANK;
  if(FULL_RENDERING) {
    init_force();
    init_warp();
    println("init filter is done");
  }
}


void filter() {
  int cell_size = (int)map(value_slider_fx[0],0,360,2,height/10);
  if(ref_cell_size != cell_size) {

    ref_cell_size = cell_size;
    println("cell ref",ref_cell_size);
    init_force();
  }

  if(FULL_RENDERING && fx_romanesco_is(0)) {
    update_force();
    warp();
  }
  show_force_field();

}



/**
WARP
2018-2018
v 0.0.1
this chapter is the place where the pixel is filtering
*/
void init_warp() {
  warp_romanesco = new Warp(preference_path+"/shader/");
  warp_romanesco.add(g);
  // warp_romanesco.select(0);
  // warp_romanesco.add_image(g, "surface_g");
}


void warp() {
  float intensity_warp = map(value_slider_fx[2],0,360,0,1);
  intensity_warp *=intensity_warp;
  
  // cycling
  float cycling = 1;
  float ratio = map(value_slider_fx[3],0,360,0,.8);
  if(ratio > 0) {
    ratio = (ratio*ratio*ratio);
    cycling = abs(sin(frameCount *ratio));
  }

  float cx = map(value_slider_fx[4],0,360,0,1);
  float cy = map(value_slider_fx[5],0,360,0,1);
  float cz = map(value_slider_fx[6],0,360,0,1);
  float ca = 1; // change nothing at this time
  Vec4 refresh_warp = Vec4(cx,cy,cz,ca);
  if(ratio > 0) {
    refresh_warp.mult(cycling);
  }


  warp_romanesco.refresh(refresh_warp);
  warp_romanesco.shader_init();
  warp_romanesco.show(force_romanesco,intensity_warp);
}









/**
FILTER FORCE
2018-2018
v 0.0.2
*/
void init_force() {
  force_romanesco = new Force_field(ref_cell_size,r.FLUID,r.BLANK);
  force_romanesco.add_spot();
}



void update_force() {
  if(force_romanesco.get_type() == r.FLUID) update_force_fluid();
  // update spot position
  force_romanesco.set_spot_pos(mouse[0].x,mouse[0].y);

  force_romanesco.update();
  


}




// fluid force filter
void update_force_fluid() {
  float freq_ff = 2/frameRate;
  float visc_ff = .001;;
  float diff_ff = 1.;  
  force_romanesco.set_frequence(freq_ff);
  force_romanesco.set_viscosity(visc_ff); // back to normal
  force_romanesco.set_diffusion(diff_ff);
}


/**
SHOW FIELD
*/
void show_force_field() {
  float scale = 5 ;
  Vec2 range_colour = Vec2(0,g.colorModeX);
  int c = r.WHITE;
  show_field(force_romanesco,scale,range_colour,c);
}


void show_field(Force_field ff, float scale, Vec2 range_colour,int colour) {
  if(ff != null) {
    Vec2 offset = Vec2(ff.get_resolution());
    offset.sub(ff.get_resolution()/2);
    //
    for (int x = 0; x < ff.cols; x++) {
      for (int y = 0; y < ff.rows; y++) {
        Vec2 pos = Vec2(x *ff.get_resolution(), y *ff.get_resolution());
        Vec2 dir = Vec2(ff.field[x][y].x,ff.field[x][y].y);
        if(ff.get_super_type() == r.STATIC) {
          float mag = ff.field[x][y].w;
          pattern_field(dir, mag, pos, ff.resolution *scale,range_colour,colour);
        } else {
          pos.add(offset);
          float mag = (float)Math.sqrt(dir.x*dir.x + dir.y*dir.y + dir.z*dir.z); ;
          pattern_field(dir, mag, pos, ff.resolution *scale,range_colour,colour);
        }
      }
    }
  }  
}

// Renders a vector object 'v' as an arrow and a position 'x,y'
void pattern_field(Vec2 dir, float mag, Vec2 pos, float scale, Vec2 range_colour, int c) {
  Vec5 colorMode = Vec5(getColorMode());
  colorMode(HSB,1);

  pushMatrix();
  // Translate to position to render vector
  translate(pos);
  // Call vector heading function to get direction (note that pointing to the right is a heading of 0) and rotate
  rotate(dir.angle());
  // Calculate length of vector & scale it to be dir_vector or smaller if dir_vector
  float len = mag *scale;
  float min = range_colour.x;
  float max = range_colour.y;

  float value = map(abs(len), 0, scale,max,min);
  /*
  if(reverse_value_colour_vff) {
    value = 1-value ;
  }
  */

  
  
  strokeWeight(1);
  noFill();
  float alpha = alpha(c);

  if(c == r.HUE) {
    stroke(value,1,1,alpha);
  } else if(c == r.WHITE) {
    stroke(0,0,value,alpha);
  } else if(c == r.BLACK) {
    stroke(0,value,0,alpha);
  } else {
    float hue_val = hue(c);
    stroke(hue_val,1,value,alpha);
  }

  if(len > scale) len = scale ;
  line(0,0,len,0);

  popMatrix();

  colorMode(colorMode);
}



