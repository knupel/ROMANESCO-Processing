/**
* Force field warp texture
* @author @stanlepunk
* @see https://github.com/StanLepunK/Force_Field
* 2017-2019
v 0.9.3
*/

class Warp_Force {
  private PImage buffer_img;
  private PGraphics pg;
  private boolean shader_warp_filter = false ;
  private int shader_warp_mode = 0 ;

  private ROPImage_Manager img_manager ;

  private boolean reset_img ;

  private PShader rope_warp_shader, rope_warp_blur;

  private boolean on_g = false;
  private boolean filter_is = false;
  

  public Warp_Force() {
    build("shader/");
  }


  private void build(String path) {
    img_manager = new ROPImage_Manager();
    shader(path);
  }
  

  private void shader(String main_folder_path) {
    String path = main_folder_path+"fx_post/warp_tex_a.glsl";
    rope_warp_shader = loadShader(path);
    path = main_folder_path+"fx_post/blur_gaussian.glsl";
    rope_warp_blur = loadShader(path); 
  }


  /**
  * Use this method in Processing setup
  * load PImage from path
  *
  * @webref warp:method
  * @param path array String of path
  * @return void
  * @brief load PImage from path to the image manager
  */
  public void load(String... path) {
    img_manager.load(path);
  }



  
  /**
  * add PImage directly
  *
  * @webref warp:method
  * @param pg is PImage to add at the manager
  * @param name is PImage name to add info at your image
  * @return none
  * @brief add PImage direclt
  */
  public void add(PImage pg) {
    add(pg,"my name is nobody");
  }

  public void add(PImage pg, String name) {
    img_manager.add(pg,name);
  }



  /**
  * set PImage directly
  *
  * @webref warp:method
  * @param pg is PImage to add at the manager
  * @param name is PImage name to add info at your image
  * @return none
  * @brief add PImage direclt
  */

  /*
  public void set(PImage img, String name) {
    img_manager.set(img,name);
  }
  */
  
  






  /**
  * select PImage in the manager list to use with warp
  *
  * @webref warp:method
  * @param index point PImage in the array list manager
  * @param name point PImage in the array list manager
  * @return none
  * @brief add PImage direclt
  */
  public void select(int index) {
    img_manager.select(index);
  }

  public void select(String name) {
    img_manager.select(img_manager.get_rank(name)) ;
  }


  /**
  get
  */
  public String get_name(int target) {
    return img_manager.get_name(target) ;
  }

  public String get_name() {
    return img_manager.get_name() ;
  }

  public int get_width() {
    if(img_manager.get() != null) {
      return img_manager.get().width;
    } else return 0 ;
  }

  public int get_height() {
    if(img_manager.get() != null) {
      return img_manager.get().height;
    } else return 0 ;
  }
  
  public PImage get_image() {
    return img_manager.get();
  }


  

  public int library_size() {
    if(img_manager != null) {
      return img_manager.size();
    } else return -1;
  }

  public ROPImage_Manager library() {
    return img_manager ;
  }

  public void image_library_clear() {
    img_manager.clear();
  }




  public void shader_init() {
    rendering_shader_is(true);
    shader_mode(0); // default mode, regular rendering
    shader_filter(false); // no effect echo shadering
  }

  public void shader_filter(boolean filter_is) {
    shader_warp_filter = filter_is ;
  }

  // int mode = 0; // default mode is rendering
  // mode = 500 ; // velocity mode
  // mode = 501 ; // direction mode
  public void shader_mode(int which_mode) {
    shader_warp_mode = which_mode;
  }







  /**
  *  refresh PImage selected after warp effect
  *
  * @webref warp:method
  * @param ratio is Vec component of refresh / the max Vec is 4
  * @param value is the array component / the max element is 4
  * refresh component is must have a normal value 0 > 1
  * @return none
  * @brief refresh the PImage to the begin
  */
  public void refresh(vec ratio) {
    refresh_image_is(true);

    if(ratio instanceof vec2) {
      vec2 r = (vec2) ratio ;
      refresh_image(r.x,r.x,r.x);
    } else if (ratio instanceof vec3) {
      vec3 r = (vec3) ratio ;
      refresh_image(r.x,r.y,r.z);
    } else {
      printErr("method refresh() from class Warp : ratio is not an instance of vec2, vec3 or vec4, instead the value max '.5' is used");
      refresh_image(.5,.5,.5);
    } 
  }

  public void refresh(float... value) {
    vec3 v = array_to_rgb_vec3(value);
    refresh_image_is(true);
    refresh_image(v.x,v.y,v.z);
  }

  private vec3 array_to_rgb_vec3(float... f) {
    vec3 v = vec3(1);
    if(f.length == 1) {
      v.set(f[0],f[0],f[0]);
    } else if(f.length == 2) {
      v.set(f[0],f[0],f[0]);
    } else if(f.length == 3) {
      v.set(f[0],f[1],f[2]);
    } else if(f.length > 3) {
      v.set(f[0],f[1],f[2]);
    }
    return v;
  }







  /**
  misc
  */
  public void reset() {
    reset_img = true ;
  }

  public void image_library_fit(PGraphics pg, boolean full_fit) {
    for(int i = 0 ; i < img_manager.size() ;i++) {
      image_resize(img_manager.get(i),pg, full_fit);
    }
  }

  public void image_library_crop(PGraphics pg) {
    for(int i = 0 ; i < img_manager.size() ;i++) {
      PImage temp = image_copy_window(img_manager.get(i), CENTER).copy();
      img_manager.get(i).resize(temp.width,temp.height);
      temp.loadPixels();
      img_manager.get(i).pixels = temp.pixels;
      img_manager.get(i).updatePixels();
    }
  }






  /**
  SHOW
  */
  /*
  Main and Public method to show result
  */
  public void show(Force_field force_field, float intensity) {
    if(reset_img) {
      draw(img_manager.get());
    }
    reset_img = false;

    if(pg == null && img_manager.get() != null) { 
      set(img_manager.get());
    } else if(img_manager.get() != null) {  
      update(force_field,img_manager.get(),intensity);
    }
  }


  /*
  Follower method
  */
  private void set(PImage target) {
    if(get_renderer(getGraphics()).equals(P3D) || get_renderer(getGraphics()).equals(P2D)) {
      buffer_img = createImage(target.width, target.height, ARGB);
      pg = createGraphics(target.width, target.height, get_renderer(getGraphics()));
      pg.beginDraw();
      pg.image(target,0,0);
      pg.endDraw();
    }
  }
  

  private void update(Force_field force_field, PImage target, float intensity) {
    PImage inc = target.copy(); 
    rendering(pg, buffer_img, inc, force_field, intensity);   

    buffer_img.pixels = buffering(pg).pixels;
    buffer_img.updatePixels();
  }




  private PImage buffering(PImage target) {
    PImage temp = createImage(target.width,target.height, ARGB);
    target.loadPixels();
    temp.pixels = target.pixels;
    temp.updatePixels();
    return temp;
  }

  private void draw(PImage target) {
    if(target != null) set(target);
    buffer_img.pixels = buffering(pg).pixels;
    buffer_img.updatePixels();
  }
  























  /**
  rendering
  */
  private boolean rendering_warp_GPU = false ;
  private void rendering_shader_is(boolean rendering_warp_GPU) { 
    this.rendering_warp_GPU = rendering_warp_GPU ;
  }

  /**
  refresh background image
  */
  private boolean refresh_image_is ;
  private void refresh_image_is(boolean refresh_image_is) {
    this.refresh_image_is = refresh_image_is;
  }
  /**
  refresh component is must have a normal value 0 > 1
  */
  private vec3 warp_img_refresh ;
  private void refresh_image(float x, float y, float z) {
    if(this.warp_img_refresh == null) {
      warp_img_refresh = vec3(x,y,z);
    } else {
      warp_img_refresh.set(x,y,z);
    }
  }












  /**
  * warp image Master method
  * v 0.4.0
  * EFFECT PART MUST BE IMPROVE TO BE INTERESTING
  */
  // refresh effect
  private boolean refresh_mix_is; // default effect
  public void refresh_mix(boolean refresh_mix_is) {
    this.refresh_mix_is = refresh_mix_is;
  }

  public void refresh_multiply(boolean refresh_multiply_is) {
    refresh_multiply(refresh_multiply_is, .5, 1);
  }

  private boolean refresh_multiply_is ;
  private vec3 refresh_multiply_value ;
  public void refresh_multiply(boolean refresh_multiply_is, float... value) {
    vec3 v = array_to_rgb_vec3(value);
    if(refresh_multiply_value == null) {
      refresh_multiply_value = vec3(v.x,v.y,v.z);
    } else {
      refresh_multiply_value.set(v.x,v.y,v.z);
    }
    this.refresh_multiply_is = refresh_multiply_is;
  }

  public void refresh_overlay(boolean refresh_overlay_is) {
    refresh_overlay(refresh_overlay_is, .5, 1);
  }

  private boolean refresh_overlay_is ;
  private vec3 refresh_overlay_value ;
  public void refresh_overlay(boolean refresh_overlay_is, float... value) {
    vec3 v = array_to_rgb_vec3(value);
    if(refresh_overlay_value == null) {
      refresh_overlay_value = vec3(v.x,v.y,v.z);
    } else {
      refresh_overlay_value.set(v.x,v.y,v.z);
    }
    this.refresh_overlay_is = refresh_overlay_is;
  }




  // normal effect
  private boolean effect_multiply_is ;
  private vec3 effect_multiply_value ;
  public void effect_multiply(boolean effect_multiply_is, float... value) {
    vec3 v = array_to_rgb_vec3(value);
    if(effect_multiply_value == null) {
      effect_multiply_value = vec3(v.x,v.y,v.z);
    } else {
      effect_multiply_value.set(v.x,v.y,v.z);
    }
    this.effect_multiply_is = effect_multiply_is;
  }

  private boolean effect_overlay_is ;
  private vec3 effect_overlay_value ;
  public void effect_overlay(boolean effect_overlay_is, float... value) {
    vec3 v = array_to_rgb_vec3(value);
    if(effect_overlay_value == null) {
      effect_overlay_value = vec3(v.x,v.y,v.z);
    } else {
      effect_overlay_value.set(v.x,v.y,v.z);
    }
    this.effect_overlay_is = effect_overlay_is;
  }








  /*
  rendering
  */
  private void rendering(PGraphics result, PImage buffer, PImage inc, Force_field ff, float intensity) {    
    if (rendering_warp_GPU) {
      rendering_graphic_processor(result,buffer,inc,ff,intensity);  
    } else {
      rendering_computer_processor(result,buffer,inc,ff,intensity);
    }
  }







  /**
  WARP GPU
  Graphic Processor Unit version of fluid image / GLSL
  v 0.0.5
  */
  private void rendering_graphic_processor(PGraphics result, PImage buffer, PImage inc, Force_field ff, float intensity) {
    refresh_rendering_gpu(result,buffer,inc,ff,intensity);
    finalize_rendering_gpu(result,buffer,inc,ff,intensity);  
  }



  private void refresh_rendering_gpu(PGraphics result, PImage buffer, PImage inc, Force_field ff, float intensity) {
    if(refresh_image_is) {
      refresh_mix(true);
      refresh_multiply(false); // add value is possible refresh_multiply(boolean b, float... val)
      refresh_overlay(false); // add value is possible refresh_overlay(boolean b, float... val)

      result.beginDraw();
      if(refresh_mix_is) {
        int mix_mode_mix = 17;
        result = fx_mix(buffer,inc,on_g,filter_is,mix_mode_mix,warp_img_refresh,vec3(1));
      }
      if(refresh_multiply_is) {  
        int mix_mode_multiply = 1;
        result = fx_mix(buffer,inc,on_g,filter_is,mix_mode_multiply,vec3(1),refresh_multiply_value);
      }
      if(refresh_overlay_is) {
         int mix_mode_overlay = 4;
         result = fx_mix(buffer,inc,on_g,filter_is,mix_mode_overlay,vec3(1),refresh_overlay_value);
      }
      if(result.pixels == null) {
        result.loadPixels();
      }
      result.endDraw();
    }
    image(result);
  }


  private void finalize_rendering_gpu(PGraphics result, PImage buffer, PImage inc, Force_field ff, float intensity) {
    result.beginDraw(); 
    warp_image_graphic_processor(result,inc,ff,intensity);

    if(effect_multiply_is) {
      int mix_mode_multiply = 1;
      println("multiply",refresh_multiply_value);
      result = fx_mix(buffer,inc,on_g,filter_is,mix_mode_multiply,vec3(1),refresh_multiply_value);
    }
    if(effect_overlay_is) {
      println("overlay",refresh_overlay_value);
      int mix_mode_overlay = 4;
      result = fx_mix(buffer,inc,on_g,filter_is,mix_mode_overlay,vec3(1),refresh_overlay_value);
    }
    result.endDraw();
  }




  // main method
  private void warp_image_graphic_processor(PGraphics result, PImage tex, Force_field ff, float intensity) {
    float grid_w = ff.get_tex_velocity().width;
    float grid_h = ff.get_tex_velocity().height;
    PImage tex_dir_blur = ff.get_tex_direction().copy();
    smooth_texture(int(grid_w), int(grid_h), tex_dir_blur);
   
    rope_warp_shader.set("mode",shader_warp_mode);
    rope_warp_shader.set("strength",intensity);

    rope_warp_shader.set("texture_source",tex);
    rope_warp_shader.set("texture_velocity",ff.get_tex_velocity());
    rope_warp_shader.set("texture_direction",pass2);
    
    // shader filter
    if(shader_warp_filter) { 
      try {
        // rope_warp_shader.set("flip_source",true,false);
        result.filter(rope_warp_shader);
      } catch(java.lang.RuntimeException e) { 
        printErrTempo(60,"class Warp void warp_image_graphic_processor: Too many calls to pushMatrix()",frameCount);
      }
    } else {  
      result.shader(rope_warp_shader);
      result.image(tex,0,0); // don't update the image
    }
  }


  /**
  Smooth texture
  method to blur the texture, before passing this one to the main picture must be warp.
  This step remove the stair effect.
  */
  private PGraphics pass1, pass2;

  private void smooth_texture(int w, int h, PImage tex) {
      // blur direction texture
    if(pass1 == null) pass1 = createGraphics(w,h,P2D);
    if(pass2 == null) pass2 = createGraphics(w,h,P2D);
    rope_warp_blur.set("radius",7);
    rope_warp_blur.set("sigma",3f); 
    // Applying the blur shader along the vertical direction   
    rope_warp_blur.set("horizontal_pass",true);
    pass1.beginDraw();            
    pass1.shader(rope_warp_blur);
    pass1.image(tex,0,0); 
    pass1.endDraw();

   
    // Applying the blur shader along the horizontal direction        
    rope_warp_blur.set("horizontal_pass",false);
    pass2.beginDraw();            
    pass2.shader(rope_warp_blur);  
    pass2.image(pass1,0,0);
    pass2.endDraw(); 
  }



















  /**
  WARP CPU
  Computer Processor Unit 
  v 0.2.0
  * based on by Felix Woitzel code
  * but the code don't work perfectly, on the top and right direction
  */

  private void rendering_computer_processor(PGraphics result, PImage buffer, PImage inc, Force_field ff, float intensity) {
    result.beginDraw();
    if(refresh_image_is) {
      int mix_mode_mix = 17;
      result = fx_mix(buffer,inc,on_g,filter_is,mix_mode_mix,warp_img_refresh,vec3(1));
      // mix(result,buffer,inc,warp_img_refresh);
    }
    warp_image_computer_processor(result,buffer,inc,ff,intensity);
    result.endDraw();
    image(result);  
  }

  private void warp_image_computer_processor(PGraphics result, PImage tex, PImage inc, Force_field ff, float intensity) {

    result.loadPixels();
    int [] c_array = result.pixels ;

    ivec2 canvas = ivec2(ff.get_canvas());
    ivec2 img_canvas = ivec2(result.width, result.height);
    
    vec2 ratio_canvas = vec2(1).div(canvas);

    int start_x = 0 ;
    int start_y = 0 ;
    int end_x = img_canvas.x;
    int end_y = img_canvas.y;  

    // this part must be send to shader GLSL  
    for (int x = start_x ; x < end_x ; x++) {
      for (int y = start_y ; y < end_y ; y++) {
        vec2 uv = ratio_canvas.copy().mult(x,y);
        vec2 warp = ff.field_warp(uv,intensity);
        if(warp != null) {
          warp.mult(canvas);
          int c = apply_warp(warp,c_array,result,inc);
          result.set(x,y,c);

        } else {
          printErr("error in fluid_image() caught vec2 warp is null for " + uv);
          int c = color(r.BLACK);
          result.set(x,y,c);
        }
      }
    }
  }

  /**
  * problem the pixel have a tendances to go on the the right :(
  */
  public int apply_warp(vec2 warp, int [] pix, PImage src, PImage img_fluid) {
    // security out bound
    if (warp.x < 0) warp.x = 0;
    if (warp.y < 0 ) warp.y = 0;
    if (warp.x > src.width) warp.x = src.width -1;
    if (warp.y > src.height) warp.y = src.height -1;
    

    int x = floor(warp.x);
    int y = floor(warp.y);

    /**
    * interesting bug
    * float u = warp.x +x;
    * float v = warp.y +y; 
    */

    float u = warp.x -x;
    float v = warp.y -y;
    
    int indexTopLeft = x +y *img_fluid.width;
    int indexTopRight = x +1 +y *img_fluid.width;
    int indexBottomLeft = x +(y+1) *img_fluid.width;  
    int indexBottomRight = x +1 +(y+1) *img_fluid.width;
   
    
    /**
    * Keep for the future
    */
    /*
    if(indexTopLeft >= pix.length) indexTopLeft -= pix.length;
    if(indexTopRight >= pix.length) indexTopRight -= pix.length;
    if(indexBottomLeft >= pix.length) indexBottomLeft -= pix.length;
    if(indexBottomRight >= pix.length) indexBottomRight -= pix.length;
    */
    
    // border true
    if(indexTopLeft >= pix.length) indexTopLeft = pix.length -1;
    if(indexTopRight >= pix.length) indexTopRight = pix.length -1;
    if(indexBottomLeft >= pix.length) indexBottomLeft = pix.length -1;
    if(indexBottomRight >= pix.length) indexBottomRight = pix.length -1;

    if(indexTopLeft < 0) indexTopLeft = 0;
    if(indexTopRight < 0) indexTopRight = 0;
    if(indexBottomLeft < 0) indexBottomLeft = 0;
    if(indexBottomRight < 0) indexBottomRight = 0;


    try {
      int top_left = pix[indexTopLeft];
      int top_right = pix[indexTopRight];
      int bottom_left = pix[indexBottomLeft];
      int bottom_right = pix[indexBottomRight];

      int from = lerpColor(top_left,top_right,u);
      int to = lerpColor(bottom_left,bottom_right,u);
      float ratio = v;

      int c = lerpColor(from,to,ratio);

      return c;
    } catch (Exception e) {
      printErr("error in apply_warp() caught trying to get color for pixel position " + x + ", " + y);
      return r.BLACK;
    }
  }

}







