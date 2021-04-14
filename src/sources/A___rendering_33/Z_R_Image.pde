/**
* Rope framework image
* v 0.6.1
* Copyleft (c) 2014-2021
*
* dependencies
* Processing 3.5.3
*
* @author @stanlepunk
* @see https://github.com/StanLepunK/Rope_framework
*/

/**
* entry return the pixel position from x,y coordinate
* v 0.0.2
*/
// with coordinate
int entry(ivec2 pos, boolean constrain_is) {
  return entry(g,pos.x(),pos.y(), constrain_is);
}

int entry(vec2 pos, boolean constrain_is) {
  return entry(g,pos.x(),pos.y(), constrain_is);
}

int entry(float x, float y, boolean constrain_is) {
  return entry(g,x,y,constrain_is);
}

int entry(PGraphics pg, ivec2 pos, boolean constrain_is) {
  return entry(pg,pos.x(),pos.y(),constrain_is);
}

int entry(PGraphics pg, vec2 pos, boolean constrain_is) {
  return entry(pg,pos.x(),pos.y(),constrain_is);
}

int entry(PGraphics pg, float x, float y, boolean constrain_is) {
  //int max = pg.pixels.length;
  // int rank = (int)y * pg.width + (int)x;
  int rank = index_pixel_array((int)x, (int)y, pg.width);
  return entry(pg, rank, constrain_is);
}

// with rank
int entry(int rank, boolean constrain_is) {
  return entry(g,rank,constrain_is);
}

int entry(PGraphics pg, int rank, boolean constrain_is) {
  int max = pg.pixels.length;
  if(constrain_is) {
    if(rank < 0) rank = 0;
    if(rank >= max) rank = max -1;
  } else {
    if(rank < 0) rank = max-rank;
    if(rank >= max) rank = rank-max;
  }
  return rank;
}













/**
* method PATTERN
* v 0.0.2
* 2021-2021
*/
R_Pattern rope_pattern;


void init_pattern() {
  if(rope_pattern == null) {
    rope_pattern = new R_Pattern(this); 
  }
}

// reset
void reset_pattern() {
  rope_pattern = null;
  init_pattern();
}
void set_pattern_no_angle() {
  init_pattern();
  rope_pattern.set_no_angle();
}

void set_pattern_no_increment() {
  init_pattern();
  rope_pattern.set_no_increment();
}

void set_pattern_no_smooth() {
  init_pattern();
  rope_pattern.set_no_smooth();
}

//setting
void set_pattern_turbulence(float turbulence) {
  init_pattern();
  rope_pattern.set_turbulence(turbulence);
}

void set_pattern_size(int w, int h) {
  init_pattern();
  rope_pattern.set_size(w,h);
}

void set_pattern_range(float min, float max) {
  init_pattern();
  rope_pattern.set_range(min,max);
}


void set_pattern_increment(float inc) {
  init_pattern();
  rope_pattern.set_increment(inc);
}

void set_pattern_increment(float x, float y, float z) {
  init_pattern();
  rope_pattern.set_increment(x,y,z);
}

void set_pattern_smooth(float smooth) {
  init_pattern();
  rope_pattern.set_smooth(smooth);
}

void set_pattern_angle(float a_x, float a_y, float a_z) {
  init_pattern();
  rope_pattern.set_angle(a_x, a_y, a_z);
}

void set_pattern_period(float x, float y) {
  init_pattern();
  rope_pattern.set_period(x,y);
}


// build
PGraphics pattern_rand(int w, int h) {
  init_pattern();
  rope_pattern.build_matrix_rand_mono();
  return rope_pattern.map_mono(w, h);
}

PGraphics pattern_rand_xyz(int w, int h) {
  init_pattern();
  rope_pattern.build_matrix_rand_xyz();
  return rope_pattern.map_xyz(w, h);
}

PGraphics pattern_noise(int w, int h) {
  init_pattern();
  rope_pattern.build_matrix_noise_mono();
  return rope_pattern.map_mono(w, h);
}

PGraphics pattern_noise_xyz(int w, int h) {
  init_pattern();
  rope_pattern.build_matrix_noise_xyz();
  return rope_pattern.map_xyz(w, h);
}

PGraphics pattern_img(PImage src, int w, int h) {
  init_pattern();
  rope_pattern.build_matrix(src, r.BRIGHTNESS);
  return rope_pattern.map_mono(w, h);
}

PGraphics pattern_marble_brightness(PImage src, int w, int h) {
  init_pattern();
  rope_pattern.build_matrix(src, r.BRIGHTNESS);
  return rope_pattern.marble_mono(w, h);
}

PGraphics pattern_marble_rgb(PImage src, int w, int h) {
  init_pattern();
  rope_pattern.build_matrix(src, RGB);
  return rope_pattern.marble_xyz(w, h);
}

PGraphics pattern_marble_hsb(PImage src, int w, int h) {
  init_pattern();
  rope_pattern.build_matrix(src, HSB);
  return rope_pattern.marble_xyz(w, h);
}

PGraphics pattern_marble(int w, int h) {
  init_pattern();
  rope_pattern.build_matrix_rand_mono();
  return rope_pattern.marble_mono(w, h);
}










/**
* Patttern noise
* inspired by Daniel Shiffman
* https://www.youtube.com/watch?v=8ZEMLCnn8v0
*/
@Deprecated
PGraphics pattern_noise(int w, int h, float... inc) {
  PGraphics pg;
  noiseSeed((int)random(MAX_INT));
  if(w > 0 && h > 0 && inc.length > 0 && inc.length < 5) {
    float [] cm = getColorMode(false);
    colorMode(RGB,255,255,255,255);
    pg = createGraphics(w,h);
    float offset_x [] = new float[inc.length];
    float offset_y [] = new float[inc.length];
    float component [] = new float[inc.length];
    float max [] = new float[inc.length];
    if(inc.length == 1) {
      max[0] = g.colorModeZ;
    } else if (inc.length == 2) {
      max[0] = g.colorModeZ;
      max[1] = g.colorModeA;
    } else if (inc.length == 3) {
      max[0] = g.colorModeX;
      max[1] = g.colorModeY;
      max[2] = g.colorModeZ;
    } else if (inc.length == 4) {
      max[0] = g.colorModeX;
      max[1] = g.colorModeY;
      max[2] = g.colorModeZ;
      max[3] = g.colorModeA;
    }
    colorMode((int)cm[0],cm[1],cm[2],cm[3],cm[4]);

    pg.beginDraw();
    for(int i = 0 ; i < inc.length ; i++) {
      offset_y[i] = 0;
    }
    
    for(int x = 0 ; x < w ; x++) {
      for(int i = 0 ; i < inc.length ; i++) {
        offset_x[i] = 0;
      }
      for(int y = 0 ; y < h ; y++) {
        for(int i = 0 ; i < inc.length ; i++) {
          component[i] = map(noise(offset_x[i],offset_y[i]),0,1,0,max[i]);
        }
        int c = 0;
        if(inc.length == 1) c = color(component[0]);
        else if (inc.length == 2) c = color(component[0],component[1]);
        else if (inc.length == 3) c = color(component[0],component[1],component[2]);
        else if (inc.length == 4) c = color(component[0],component[1],component[2],component[3]);

        pg.set(x,y,c);
        for(int i = 0 ; i < inc.length ; i++) {
          offset_x[i] += inc[i];
        }
      }
      for(int i = 0 ; i < inc.length ; i++) {
        offset_y[i] += inc[i];
      }
    }
    pg.endDraw();
    return pg;
  } else {
    print_err("method pattern_noise(): may be problem with size:",w,h,"\nor with component color num >>>",inc.length,"<<< must be between 1 and 4");
    return null;
  }
}











/**
LAYER
v 0.1.0
2018-2018
*/
PGraphics [] rope_layer;
boolean warning_rope_layer;
int which_rope_layer = 0;

// init
void init_layer() {
  init_layer(width,height,get_renderer(),1);
}

void init_layer(int num) {
  init_layer(width,height,get_renderer(),num);
}

void init_layer(int x, int y) {
  init_layer(x,y, get_renderer(),1);
}

void init_layer(int x, int y, int num) {
  init_layer(x,y, get_renderer(),num);
}

void init_layer(int x, int y, String type, int num) {
  rope_layer = new PGraphics[num];
  for(int i = 0 ; i < num ; i++) {
    rope_layer[i] = createGraphics(x,y,type);
  }
  
  if(!warning_rope_layer) {
    warning_rope_layer = true;
  }
  String warning = ("WARNING LAYER METHOD\nAll classical method used on the main rendering,\nwill return the PGraphics selected PGraphics layer :\nimage(), set(), get(), fill(), stroke(), rect(), ellipse(), pushMatrix(), popMatrix(), box()...\nto use those methods on the main PGraphics write g.image() for example");
  print_err(warning);
}

// begin and end draw
void begin_layer() {
  if(get_layer() != null) {
    get_layer().beginDraw();
  }
}

void end_layer() {
  if(get_layer() != null) {
    get_layer().endDraw();
  }
}



// num
int get_layer_num() {
  if(rope_layer != null) {
    return  rope_layer.length ;
  } else return -1;  
}


// clear layer
void clear_layer() {
  if(rope_layer != null && rope_layer.length > 0) {
    for(int i = 0 ; i < rope_layer.length ; i++) {
      String type = get_renderer(rope_layer[i]);
      int w = rope_layer[i].width;
      int h = rope_layer[i].height;
      rope_layer[i] = createGraphics(w,h,type);
    }
  } else {
    String warning = ("void clear_layer(): there is no layer can be clear maybe you forget to create one :)");
    print_err(warning);
  }
  
}

void clear_layer(int target) {
  if(target > -1 && target < rope_layer.length) {
    String type = get_renderer(rope_layer[target]);
    int w = rope_layer[target].width;
    int h = rope_layer[target].height;
    rope_layer[target] = createGraphics(w,h,type);
  } else {
    String warning = ("void clear_layer(): target "+target+" is out the range of the layers available,\n no layer can be clear");
    print_err(warning);
  }
}




/**
GET LAYER
* May be the method can be improve by using a PGraphics template for buffering instead usin a calling method ????
*/
// get layer
PGraphics get_layer() {
  return get_layer(which_rope_layer);
}


PGraphics get_layer(int target) {
  if(rope_layer == null) {
    return g;
  } else if(target > -1 && target < rope_layer.length) {
    return rope_layer[target];
  } else {
    String warning = ("PGraphics get_layer(int target): target "+target+" is out the range of the layers available,\n instead target 0 is used");
    print_err(warning);
    return rope_layer[0];
  }
}

// select layer
void select_layer(int target) {
  if(rope_layer != null) {
    if(target > -1 && target < rope_layer.length) {
      which_rope_layer = target;
    } else {
      which_rope_layer = 0;
      String warning = ("void select_layer(int target): target "+target+" is out the range of the layers available,\n instead target 0 is used");
      print_err(warning);
    }
  } else {
    print_err_tempo(180,"void select_layer(): Your layer system has not been init use method init_layer() in first",frameCount);
  } 
}










/**
resize image
v 0.0.3
*/
/**
* resize your picture proportionaly to the window sketch of the a specificic PGraphics
*/
void image_resize(PImage src) {
  image_resize(src,g,true);
}

void image_resize(PImage src, boolean fullfit) {
  image_resize(src,g,fullfit);
}

void image_resize(PImage src, PGraphics pg, boolean fullfit) {
  image_resize(src, pg.width, pg.height, fullfit);
}

void image_resize(PImage src, int target_width, int target_height, boolean fullfit) {
  float ratio_w = target_width / (float)src.width;
  float ratio_h = target_height / (float)src.height;
  if(!fullfit) {
    if(ratio_w > ratio_h) {
      src.resize(ceil(src.width *ratio_w), ceil(src.height *ratio_w));
    } else {
      src.resize(ceil(src.width *ratio_h), ceil(src.height *ratio_h));  
    }
  } else {
    if(ratio_w > ratio_h) {
      src.resize(ceil(src.width *ratio_h), ceil(src.height *ratio_h));
    } else {
      src.resize(ceil(src.width *ratio_w), ceil(src.height *ratio_w));  
    }
  }
}

/**
copy window
v 0.0.1
*/
PImage image_copy_window(PImage src, int where) {
  return image_copy_window(src, g, where);
}

PImage image_copy_window(PImage src, PGraphics pg, int where) {
  int x = 0 ;
  int y = 0 ;
  if(where == CENTER) {
    x = (src.width -pg.width) /2 ;
    y = (src.height -pg.height) /2 ;   
  } else if(where == LEFT) {
    y = (src.height -pg.height) /2 ; 
  } else if(where == RIGHT) { 
    x = src.width -pg.width ;
    y = (src.height -pg.height) /2 ;   
  } else if(where == TOP) {
    x = (src.width -pg.width) /2 ;   
  } else if(where == BOTTOM) { 
    x = (src.width -pg.width) /2 ;
    y = src.height -pg.height;   
  }  
  return src.get(x, y, pg.width, pg.height); 
}

















/**
IMAGE
v 0.2.2
2016-2018
*/
/**
* additionnal method for image
* @see other method in vec mini library
*/
void image(PImage img) {
  if(img != null) image(img, 0, 0);
  else print_err("Object PImage pass to method image() is null");
}

void image(PImage img, int what) {
  if(img != null) {
    float x = 0 ;
    float y = 0 ;
    int w = img.width;
    int h = img.height;
    int where = CENTER;
    if(what == r.FIT || what == LANDSCAPE || what == PORTRAIT || what == SCREEN) {
      float ratio = 1.;
      int diff_w = width-w;
      int diff_h = height-h;


      if(what == r.FIT) {
        if(diff_w > diff_h) {
          ratio = (float)height / (float)h;
        } else {
          ratio = (float)width / (float)w;
        }
      } else if(what == SCREEN) {
        float ratio_w = (float)width / (float)w;
        float ratio_h = (float)height / (float)h;
        if(ratio_w > ratio_h) {
          ratio = ratio_w;
        } else {
          ratio = ratio_h;
        }
        /*
        if(diff_w > diff_h) {
          ratio = (float)width / (float)w;
        } else {
          ratio = (float)height/ (float)h;
        }
        */
      } else if(what == PORTRAIT) {
        ratio = (float)height / (float)h;
      } else if(what == LANDSCAPE) {
        ratio = (float)width / (float)w;
      }
      w *= ratio;
      h *= ratio;
    } else {
      where = what;
    }

    if(where == CENTER) {
      x = (width /2.) -(w /2.);
      y = (height /2.) -(h /2.);   
    } else if(where == LEFT) {
      x = 0;
      y = (height /2.) -(h /2.);
    } else if(where == RIGHT) {
      x = width -w;
      y = (height /2.) -(h /2.);
    } else if(where == TOP) {
      x = (width /2.) -(w /2.);
      y = 0;
    } else if(where == BOTTOM) {
      x = (width /2.) -(w /2.);
      y = height -h; 
    }
    image(img,x,y,w,h);
  } else {
    print_err_tempo(60,"image(); no PImage has pass to the method, img is null");
  } 
}

void image(PImage img, float coor) {
  if(img != null) image(img, coor, coor);
  else print_err("Object PImage pass to method image() is null");
}

void image(PImage img, ivec pos) {
  if(pos instanceof ivec2) {
    image(img, vec2(pos.x, pos.y));
  } else if(pos instanceof ivec3) {
    image(img, vec3(pos.x, pos.y, pos.z));
  }
}

void image(PImage img, ivec pos, ivec2 size) {
  if(pos instanceof ivec2) {
    image(img, vec2(pos.x, pos.y), vec2(size.x, size.y));
  } else if(pos instanceof ivec3) {
    image(img, vec3(pos.x, pos.y, pos.z), vec2(size.x, size.y));
  } 
}

void image(PImage img, vec pos) {
  if(pos instanceof vec2) {
    vec2 p = (vec2) pos ;
    image(img, p.x, p.y) ;
  } else if(pos instanceof vec3) {
    vec3 p = (vec3) pos ;
    push() ;
    translate(p) ;
    image(img, 0,0) ;
    pop() ;
  }
}

void image(PImage img, vec pos, vec2 size) {
  if(pos instanceof vec2) {
    vec2 p = (vec2) pos ;
    image(img, p.x, p.y, size.x, size.y) ;
  } else if(pos instanceof vec3) {
    vec3 p = (vec3) pos ;
    push() ;
    translate(p) ;
    image(img, 0,0, size.x, size.y) ;
    pop() ;
  }
}









/**
* For the future need to use shader to do that...but in the future !
*/
@Deprecated
PImage reverse(PImage img) {
  PImage final_img;
  final_img = createImage(img.width, img.height, RGB) ;
  for(int i = 0 ; i < img.pixels.length ; i++) {
    final_img.pixels[i] = img.pixels[img.pixels.length -i -1];
  }
  return final_img ;
}

/**
* For the future need to use shader to do that...but in the future !
*/
@Deprecated
PImage mirror(PImage img) {
  PImage final_img ;
  final_img = createImage(img.width, img.height, RGB) ;

  int read_head = 0 ;
  for(int i = 0 ; i < img.pixels.length ; i++) {
    if(read_head >= img.width) {
      read_head = 0 ;
    }
    int reverse_line = img.width -(read_head*2) -1 ;
    int target = i +reverse_line  ;

    final_img.pixels[i] = img.pixels[target] ;

    read_head++ ;
  }
  return final_img ;
}

@Deprecated
PImage paste(PImage img, int entry, int [] array_pix, boolean vertical_is) {
  if(!vertical_is) {
    return paste_vertical(img, entry, array_pix);
  } else {
    return paste_horizontal(img, entry, array_pix);
  }
}

@Deprecated
PImage paste_horizontal(PImage img, int entry, int [] array_pix) { 
  PImage final_img ;
  final_img = img.copy() ;
  // reduce the array_pix in this one is bigger than img.pixels.length
  if(array_pix.length > final_img.pixels.length) {
     array_pix = Arrays.copyOf(array_pix,final_img.pixels.length) ;
  }

  int count = 0 ;
  int target = 0 ;
  for(int i = entry ; i < entry+array_pix.length ; i++) {
    if(i < final_img.pixels.length) {
      final_img.pixels[i] = array_pix[count];
    } else {
      target = i -final_img.pixels.length ;
      // security length outbound index
      // change the size can happen ArrayIndexOutBound,
      if(target >= final_img.pixels.length) {
        target = final_img.pixels.length -1;
      }

      final_img.pixels[target] = array_pix[count];
    }
    count++ ;
  }
  return final_img ;
}

@Deprecated
PImage paste_vertical(PImage img, int entry, int [] array_pix) { 
  PImage final_img;
  final_img = img.copy();
  // reduce the array_pix in this one is bigger than img.pixels.length
  if(array_pix.length > final_img.pixels.length) {
     array_pix = Arrays.copyOf(array_pix,final_img.pixels.length) ;
  }

  int count = 0;
  int target = 0;
  int w = final_img.width;
  int line = 0;

  for(int i = entry ; i < entry+array_pix.length ; i++) {
    int mod = i%w ;
    // the master piece algorithm to change the direction :)
    int where =  entry +(w *(w -(w -mod))) +line;
    if(mod >= w -1) {
      line++;
    }
    if(where < final_img.pixels.length) {
      final_img.pixels[where] = array_pix[count];
    } else {
      target = where -final_img.pixels.length ;
      // security length outbound index
      // change the size can happen ArrayIndexOutBound,
      if(target >= final_img.pixels.length) {
        target = final_img.pixels.length -1;
      }
      final_img.pixels[target] = array_pix[count];
    }
    count++ ;
  }
  return final_img ;
}





















/**
CANVAS
v 0.2.0
*/
PImage [] rope_canvas;
int current_canvas_rope;

// build canvas
void new_canvas(int num) {
  rope_canvas = new PImage[num];
}

void create_canvas(int w, int h, int type) {
  rope_canvas = new PImage[1];
  rope_canvas[0] = createImage(w, h, type);
}

void create_canvas(int w, int h, int type, int which_one) {
  rope_canvas[which_one] = createImage(w, h, type);
}

// clean
void clean_canvas(int which_canvas) {
  int c = color(0,0) ;
  clean_canvas(which_canvas, c) ;
}

void clean_canvas(int which_canvas, int c) {
  if(which_canvas < rope_canvas.length) {
    select_canvas(which_canvas) ;
    for(int i = 0 ; i < get_canvas().pixels.length ; i++) {
      get_canvas().pixels[i] = c ;
    }
  } else {
    String message = ("The target: " + which_canvas + " don't match with an existing canvas");
    print_err(message);
  }
}



// misc
int canvas_size() {
  return rope_canvas.length;
}

// select the canvas must be used for your next work
void select_canvas(int which_one) {
  if(which_one < rope_canvas.length && which_one >= 0) {
    current_canvas_rope = which_one;
  } else {
    String message = ("void select_canvas(): Your selection " + which_one + " is not available, canvas '0' be use");
    print_err(message);
    current_canvas_rope = 0;
  }
}

// get
PImage get_canvas(int which) {
  if(which < rope_canvas.length) {
    return rope_canvas[which];
  } else return null; 
}

PImage get_canvas() {
  return rope_canvas[current_canvas_rope];
}

int get_canvas_id() {
  return current_canvas_rope;
}

// update
void update_canvas(PImage img) {
  update_canvas(img,current_canvas_rope);
}

void update_canvas(PImage img, int which_one) {
  if(which_one < rope_canvas.length && which_one >= 0) {
    rope_canvas[which_one] = img;
  } else {
    print_err("void update_canvas() : Your selection" ,which_one, "is not available, canvas '0' be use");
    rope_canvas[0] = img;
  }  
}


/**
canvas event
v 0.0.1
*/
void alpha_canvas(int target, float change) { 
  for(int i = 0 ; i < get_canvas(target).pixels.length ; i++) {
    int c = get_canvas(target).pixels[i];
    float rr = red(c);
    float gg = green(c);
    float bb = blue(c);
    float aa = alpha(c);
    aa += change ;
    if(aa < 0 ) {
      aa = 0 ;
    }
    get_canvas(target).pixels[i] = color(rr,gg,bb,aa) ;
  }
  get_canvas(target).updatePixels() ;
}




/**
show canvas
v 0.0.4
*/
boolean fullscreen_canvas_is = false ;
ivec2 show_pos ;
/**
Add to set the center of the canvas in relation with the window
*/
int offset_canvas_x = 0 ;
int offset_canvas_y = 0 ;
void set_show() {
  if(!fullscreen_canvas_is) {
    surface.setSize(get_canvas().width, get_canvas().height);
  } else {
    offset_canvas_x = width/2 - (get_canvas().width/2);
    offset_canvas_y = height/2 - (get_canvas().height/2);
    show_pos = ivec2(offset_canvas_x,offset_canvas_y) ;
  }
}

ivec2 get_offset_canvas() {
  return ivec2(offset_canvas_x, offset_canvas_y);
}

int get_offset_canvas_x() {
  return offset_canvas_x;
}

int get_offset_canvas_y() {
  return offset_canvas_y;
}

void show_canvas(int num) {
  if(fullscreen_canvas_is) {
    image(get_canvas(num), show_pos);
  } else {
    image(get_canvas(num));
  }  
}

























/**
* BACKGROUND
* v 0.2.5
* 2015-2019
*/
/**
Background classic processing
*/
// vec
void background(vec4 c) {
  background(c.x,c.y,c.z,c.w) ;
}

void background(vec3 c) {
  background(c.x,c.y,c.z) ;
}

void background(vec2 c) {
  background(c.x,c.y) ;
}
// ivec
void background(ivec4 c) {
  background(c.x,c.y,c.z,c.w) ;
}

void background(ivec3 c) {
  background(c.x,c.y,c.z) ;
}

void background(ivec2 c) {
  background(c.x,c.y) ;
}





/**
background image
*/
void background(PImage src, int mode) {
  background_calc(src,null,null,null,null,mode);
}

void background(PImage src, int mode, float red, float green, float blue) {
  vec3 colour_curtain = abs(vec3(red,green,blue).div(vec3(g.colorModeX,g.colorModeY,g.colorModeZ)));
  background_calc(src,null,null,colour_curtain,null,mode);
}

void background(PImage src, float px, float py, float red, float green, float blue) {
  vec3 colour_curtain = abs(vec3(red,green,blue).div(vec3(g.colorModeX,g.colorModeY,g.colorModeZ)));
  vec2 pos = vec2(px /width, py /height);
  background_calc(src,pos,null,colour_curtain,null,r.SCALE);
}

void background(PImage src, float px, float py, float scale_x, float red, float green, float blue) {
  vec3 colour_curtain = abs(vec3(red,green,blue).div(vec3(g.colorModeX,g.colorModeY,g.colorModeZ)));
  vec2 pos = vec2(px /width, py /height);
  vec2 scale = vec2(scale_x);
  background_calc(src,pos,scale,colour_curtain,null,r.SCALE);
}

void background(PImage src, float px, float py, float scale_x, float red, float green, float blue, float curtain_position) {
  vec3 colour_curtain = abs(vec3(red,green,blue).div(vec3(g.colorModeX,g.colorModeY,g.colorModeZ)));
  vec2 pos = vec2(px /width, py /height);
  vec2 scale = vec2(scale_x);
  vec4 curtain_pos = vec4(curtain_position,0,curtain_position,0);
  background_calc(src,pos,scale,colour_curtain,curtain_pos,r.SCALE);
}

void background(PImage src, vec2 pos, vec2 scale, vec3 colour_background, vec4 pos_curtain, int mode) {
  background_calc(src,pos,scale,colour_background,pos_curtain,mode);
}



PShader img_shader_calc_rope;
void background_calc(PImage src, vec2 pos, vec2 scale, vec3 colour_background, vec4 pos_curtain, int mode) {
  boolean context_ok = false ;
  if(get_renderer().equals(P2D) || get_renderer().equals(P3D)) {
    context_ok = true;
  } else {
    print_err_tempo(180,"method background(PImage img) need context in P3D or P2D to work");
  }
  if(context_ok && src != null && src.width > 0 && src.height > 0) {
    if(img_shader_calc_rope == null) {
      img_shader_calc_rope = loadShader("shader/fx_post/image.glsl");
    }
    if(graphics_is(src).equals("PGraphics")) {
      img_shader_calc_rope.set("flip_source",false,false);
    } else {
      img_shader_calc_rope.set("flip_source",true,false);
    }
    
    img_shader_calc_rope.set("texture_source",src);
    img_shader_calc_rope.set("resolution",width,height);
    img_shader_calc_rope.set("resolution_source",src.width,src.height); 
    
    if(colour_background != null) {
      img_shader_calc_rope.set("colour",colour_background.x,colour_background.y,colour_background.z); // definr RGB color from 0 to 1
    }

    if(pos_curtain != null) {
      img_shader_calc_rope.set("curtain",pos_curtain.x,pos_curtain.y,pos_curtain.z,pos_curtain.w); // definr RGB color from 0 to 1
    }

    if(pos != null) {
      img_shader_calc_rope.set("position",pos.x,pos.y); // from 0 to 1
    }
    
    if(scale != null) {
      img_shader_calc_rope.set("scale",scale.x,scale.y);
    }
    
    int shader_mode = 0;
    if(mode == r.FIT) {
      shader_mode = 0;
    } else if(mode == SCREEN) {
      shader_mode = 1;
    } else if(mode == r.SCALE) {
      shader_mode = 2;
    }
    img_shader_calc_rope.set("mode",shader_mode);

    filter(img_shader_calc_rope);
  }
}












/**
Normalize background
*/
void background_norm(vec4 bg) {
  background_norm(bg.x,bg.y,bg.z,bg.w) ;
}

void background_norm(vec3 bg) {
  background_norm(bg.x,bg.y,bg.z,1) ;
}

void background_norm(vec2 bg) {
  background_norm(bg.x,bg.x,bg.x,bg.y) ;
}

void background_norm(float c, float a) {
  background_norm(c,c,c,a) ;
}

void background_norm(float c) {
  background_norm(c,c,c,1) ;
}

void background_norm(float r,float g, float b) {
  background_norm(r,g,b,1) ;
}

// Main method
float MAX_RATIO_DEPTH = 6.9 ;
void background_norm(float r_c, float g_c, float b_c, float a_c) {
  rectMode(CORNER) ;
  float x = map(r_c,0,1, 0, g.colorModeX) ;
  float y = map(g_c,0,1, 0, g.colorModeY) ;
  float z = map(b_c,0,1, 0, g.colorModeZ) ;
  float a = map(a_c,0,1, 0, g.colorModeA) ;
  noStroke() ;
  fill(x, y, z, a) ;
  int canvas_x = width ;
  int canvas_y = height ;
  if(renderer_P3D()) {
    canvas_x = width *100 ;
    canvas_y = height *100 ;
    int pos_x = - canvas_x /2 ;
    int pos_y = - canvas_y /2 ;
    // this problem of depth is not clarify, is must refactoring
    int pos_z = int( -height *MAX_RATIO_DEPTH) ;
    pushMatrix() ;
    translate(0,0,pos_z) ;
    rect(pos_x,pos_y,canvas_x, canvas_y) ;
    popMatrix() ;
  } else {
    rect(0,0,canvas_x, canvas_y) ;
  }
  // HSB mode
  if(g.colorMode == 3) {
    fill(0, 0, g.colorModeZ) ;
    stroke(0) ;
  // RGB MODE
  } else if (g.colorMode == 1) {
    fill(g.colorModeX, g.colorModeY, g.colorModeZ) ;
    stroke(0) ;

  }
  strokeWeight(1) ; 
}



/**
background rope
*/
void background_rope(int c) {
  if(g.colorMode == 3) {
    background_rope(hue(c),saturation(c),brightness(c));
  } else {
    background_rope(red(c),green(c),blue(c));
  }
}

void background_rope(int c, float w) {
  if(g.colorMode == 3) {
    background_rope(hue(c),saturation(c),brightness(c),w);
  } else {
    background_rope(red(c),green(c),blue(c),w );
  }
}

void background_rope(float c) {
  background_rope(c,c,c);
}

void background_rope(float c, float w) {
  background_rope(c,c,c,w);
}

void background_rope(vec4 c) {
  background_rope(c.x,c.y,c.z,c.w);
}

void background_rope(vec3 c) {
  background_rope(c.x,c.y,c.z);
}

void background_rope(vec2 c) {
  background_rope(c.x,c.x,c.x,c.y);
}

// master method
void background_rope(float x, float y, float z, float w) {
  background_norm(x/g.colorModeX, y/g.colorModeY, z/g.colorModeZ, w /g.colorModeA) ;
}

void background_rope(float x, float y, float z) {
  background_norm(x/g.colorModeX, y/g.colorModeY, z/g.colorModeZ) ;
}























/**
* GRAPHICS METHOD
* v 0.4.3
*/
/**
SCREEN
*/
void set_window(int px, int py, int sx, int sy) {
  set_window(ivec2(px,py), ivec2(sx,sy), get_screen_location(0));
}

void set_window(int px, int py, int sx, int sy, int target) {
  set_window(ivec2(px,py), ivec2(sx,sy), get_screen_location(target));
}

void set_window(ivec2 pos, ivec2 size) {
  set_window(pos, size, get_screen_location(0));
}

void set_window(ivec2 pos, ivec2 size, int target) {
  set_window(pos, size, get_screen_location(target));
}

void set_window(ivec2 pos, ivec2 size, ivec2 pos_screen) { 
  int offset_x = pos.x;
  int offset_y = pos.y;
  int dx = pos_screen.x;
  int dy = pos_screen.y;
  surface.setSize(size.x,size.y);
  surface.setLocation(offset_x +dx, offset_y +dy);
}

/**
check screen
*/
/**
screen size
*/
ivec2 get_screen_size() {
  if(get_screen_num() > 1) {
    return get_display_size(sketchDisplay() -1);
  } else {
    return get_display_size(0);
  }
}

ivec2 get_screen_size(int target) {
  if(target >= get_display_num()) {
    return null;
  }
  return get_display_size(target);
}

@Deprecated
ivec2 get_display_size() {
  return get_display_size(sketchDisplay() -1);
}


ivec2 get_display_size(int target) {
  if(target >= get_display_num()) {
    return null;
  }  
  Rectangle display = get_screen(target);
  return ivec2((int)display.getWidth(), (int)display.getHeight()); 
}

/**
screen location
*/

ivec2 get_screen_location(int target) {
  Rectangle display = get_screen(target);
  return ivec2((int)display.getX(), (int)display.getY());
}

/**
screen num
*/
int get_screen_num() {
  return get_display_num();
}

int get_display_num() {
  GraphicsEnvironment environment = GraphicsEnvironment.getLocalGraphicsEnvironment();
  return environment.getScreenDevices().length;
}


/**
screen
*/
Rectangle get_screen(int target_screen) {
  GraphicsEnvironment environment = GraphicsEnvironment.getLocalGraphicsEnvironment();
  GraphicsDevice[] awtDevices = environment.getScreenDevices();
  int target = 0 ;
  if(target_screen < awtDevices.length) {
    target = target_screen;
    GraphicsDevice awtDisplayDevice = awtDevices[target];
    Rectangle display = awtDisplayDevice.getDefaultConfiguration().getBounds();
    return display; 
  } else {
    return null;
  }
}



/**
sketch location 
0.0.2
*/
ivec2 get_sketch_location() {
  return ivec2(get_sketch_location_x(),get_sketch_location_y());
}

int get_sketch_location_x() {
  if(get_renderer() != P3D && get_renderer() != P2D) {
    return getJFrame(surface).getX();
  } else {
    return get_rectangle(surface).getX();

  }
  
}

int get_sketch_location_y() {
  if(get_renderer() != P3D && get_renderer() != P2D) {
    return getJFrame(surface).getY();
  } else {
    return get_rectangle(surface).getY();
  }
}


com.jogamp.nativewindow.util.Rectangle get_rectangle(PSurface surface) {
  com.jogamp.newt.opengl.GLWindow window = (com.jogamp.newt.opengl.GLWindow) surface.getNative();
  com.jogamp.nativewindow.util.Rectangle rectangle = window.getBounds();
  return rectangle;
}


static final javax.swing.JFrame getJFrame(final PSurface surface) {
  return (javax.swing.JFrame)
  (
    (processing.awt.PSurfaceAWT.SmoothCanvas) surface.getNative()
  ).getFrame();
}








/**
* Check renderer
*/
boolean renderer_dimension_tested_is ;
boolean three_dim_is = false;
boolean renderer_P3D() {
  if(!renderer_dimension_tested_is) {
    if(get_renderer(getGraphics()).equals("processing.opengl.PGraphics3D")) {
      three_dim_is = true ; 
    } else {
      three_dim_is = false ;
    }
    renderer_dimension_tested_is =true;
  }
  return three_dim_is;
}


String get_renderer() {
  return get_renderer(g);
}

String get_renderer(final PGraphics graph) {
  try {
    if (Class.forName(JAVA2D).isInstance(graph)) return JAVA2D;
    if (Class.forName(FX2D).isInstance(graph)) return FX2D;
    if (Class.forName(P2D).isInstance(graph)) return P2D;
    if (Class.forName(P3D).isInstance(graph)) return P3D;
    if (Class.forName(PDF).isInstance(graph)) return PDF;
    if (Class.forName(DXF).isInstance(graph)) return DXF;
  }

  catch (ClassNotFoundException ex) {
  }
  return "Unknown";
}






String graphics_is(Object obj) {
  if(obj instanceof PGraphics) {
    return "PGraphics";
  } else if(obj instanceof PGraphics2D) {
    return "PGraphics";
  } else if(obj instanceof PGraphics3D) {
    return "PGraphics";
  } else if(obj instanceof processing.javafx.PGraphicsFX2D) {
    return "PGraphics";
  } else if(obj instanceof PImage) {
    return "PImage";
  } else return null;
}
