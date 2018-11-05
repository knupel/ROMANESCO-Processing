
/**
Force Field
2017-2018
http://stanlepunk.xyz/
v 1.11.6
Processing 3.4
*/

/**
Force Field
work based on the code traduction of Daniel Shiffman from Reynolds Study algorithm
and Jos Stam work for the Navier-Stokes adaptation
about Daniel Shiffmann
http://natureofcode.com
http://natureofcode.com/book/chapter-6-autonomous-agents/
About Craig Reynolds 
http://www.red3d.com/cwr/
About Jos Stam work
http://www.dgp.toronto.edu/people/stam/reality/Research/pdf/GDC03.pdf 
*/

/**
CONSTANTE used by the class Force_field
int FLUID, CHAOS, PERLIN, GRAVITY, MAGNETIC, IMAGE
*/

/**
At this moment the force field is available only in 2D mode
*/

public class Force_field implements rope.core.RConstants {
  // FIELD
  private Vec4[][] field;
  private Vec4[][] field_save;
  private int type = STATIC; // or STATIC, FLUID, MAGNETIC, CHAOS
  private int super_type = STATIC; // or STATIC, DYNAMIC
  private int pattern = PERLIN; // CHAOS, PERLIN, BLANK, IMAGE
  private float sum_activities;

  // CANVAS
  private iVec2 canvas, canvas_pos;
  private int cols, rows; // Columns and Rows
  private int resolution; // How large is each "cell" of the flow field
  
  // TEXTURE
  private PImage src;
  private PImage texture_velocity;
  private PImage texture_direction;
  
  // SPOT
  private int spot_area_level = 1 ;
  private ArrayList<Vec> spot_fluid_pos_ref;
  private ArrayList<Boolean> reset_ref_spot_pos_list_is;
  private ArrayList<Spot> spot_list;
  private ArrayList<Spot> spot_mag_north_list;
  private ArrayList<Spot> spot_mag_south_list;
  private ArrayList<Spot> spot_mag_neutral_list;
  
  // EQUATION
  Vec2 center_equation_dir, center_equation_len;

  // GRAVITY
  private float mass_field = 1.;
  
  // FLUID
  private Navier_Stokes_2D ns_2D;
  private Navier_Stokes_3D ns_3D;
  private int NX, NY, NZ;
  private float frequence = .01;
  private float viscosity = .0001;
  private float diffusion = .01;
  private float limit_vel = 100.;

  // IMAGE
  private iVec4 sort;
  
  // MISC
  private boolean border_is = false;
  private boolean reverse_is;
  private boolean is;



  




  /**
  CONSTRUCTOR
  v 0.1.1
  */
  // MINIMUM
  public Force_field(int resolution, int type, int pattern) {
    set_resolution(resolution);
    this.type = type ;
    init_super_type(this.type);  
    this.pattern = pattern;
    this.is = true ;
    iVec2 canvas_pos = iVec2();
    iVec2 canvas = iVec2(width,height);
    set_canvas(iVec2(this.resolution/2 +canvas_pos.x, this.resolution/2 +canvas_pos.y), iVec2(canvas.x,canvas.y));

    cols = NX = canvas.x/this.resolution;
    rows = NY = canvas.y/this.resolution +1;

    init_field();
    init_spot();
    init_texture(cols,rows);
    border_is = true ;

    if(type == FLUID) {
      printErr("FLUID have square or cube canvas, the HEIGHT be used for the canvas side");
      int iteration = 20 ;
      border_is = false;
      ns_2D = new Navier_Stokes_2D(iVec2(NX,NY), iteration);
    } 
    set_field();
  }

  // CLASSIC
  public Force_field(int resolution, iVec2 canvas_pos, iVec2 canvas, int type, int pattern) {
    set_resolution(resolution);
    this.type = type ;
    init_super_type(this.type);  
    this.pattern = pattern;
    this.is = true ;

    set_canvas(iVec2(this.resolution/2 +canvas_pos.x, this.resolution/2 +canvas_pos.y), iVec2(canvas.x,canvas.y));

    cols = NX = canvas.x/this.resolution;
    rows = NY = canvas.y/this.resolution +1;

    init_field();
    init_spot();
    init_texture(cols,rows);
    border_is = true ;

    if(type == FLUID) {
      printErr("FLUID have square or cube canvas, the HEIGHT be used for the canvas side");
      int iteration = 20 ;
      border_is = false;
      ns_2D = new Navier_Stokes_2D(iVec2(NX,NY), iteration);
    } 
    set_field();
  }

  //PImage
  public Force_field(int resolution, iVec2 canvas_pos, PImage src, int... component_sorting) {
    set_resolution(resolution);
    this.type = STATIC;
    init_super_type(this.type);
    this.pattern = IMAGE;
    this.is = true;
    sorting_channel(component_sorting);
    
    if(this.src == null) {
      this.src = createImage(src.width,src.height,ARGB);
      src.loadPixels();
      this.src.pixels = src.pixels;
      this.src.updatePixels(); 
    } else {
      this.src.resize(src.width,src.height);
      src.loadPixels();
      this.src.pixels = src.pixels;
      this.src.updatePixels(); 
    }
    // Determine the number of columns and rows based on sketch's width and height
    set_canvas(iVec2(resolution/2 +canvas_pos.x, resolution/2 +canvas_pos.y), iVec2(this.src.width,this.src.height));
    cols = canvas.x/resolution;
    rows = canvas.y/resolution;
    init_field();

    init_texture(cols,rows);

    border_is = true ;
    set_field();
  }



  /**
  initialisation
  v 0.2.0
  */
  private void init_super_type(int type) {
    if(type != STATIC) {
      this.super_type = DYNAMIC;
    } else {
      this.super_type = STATIC;
    }
  }

  private void init_texture(int w, int h) {
    texture_velocity = createImage(w,h,RGB);
    texture_direction = createImage(w,h,RGB);
  }

  private void init_field() {
    sum_activities = 0;
    field = new Vec4[cols][rows];
    field_save = new Vec4[cols][rows];
  }

  private void init_spot() {
    spot_list = new ArrayList<Spot>();
    reset_ref_spot_pos_list_is = new ArrayList<Boolean>();

    if(this.type == MAGNETIC) {
      spot_mag_north_list = new ArrayList<Spot>();
      spot_mag_south_list = new ArrayList<Spot>();
      spot_mag_neutral_list = new ArrayList<Spot>();
    }
  }

  public void add_spot(int num) {
    if(spot_list != null) {
      for(int i = 0 ; i < num ; i++) {
        add_spot();
      }
    } else {
      printErr("method add_spot() class Force_field: ArrayList<> spot_list is null");
    }  
  }

  public void add_spot() {
    Spot spot = new Spot();
    // set default area detection for gravity and magnetic mode
    int radius_spot_detection = ceil( sqrt(cols*rows) / abs(spot_area_level) ) +1;
    spot.detection(radius_spot_detection);
    spot_list.add(spot);
    boolean bool = false ;
    reset_ref_spot_pos_list_is.add(bool);
  }



  /**
  set resolution
  v 0.0.1
  */
  private void set_resolution(int resolution) {
    if(resolution <= 0) {
      printErr("Contructor Force_field: resolution =", resolution, "instead the value 20 is used");
      this.resolution = 20 ;
    } else {
      this.resolution = resolution;
    }
  }
  /**
  set field
  v 0.1.1
  */
  private void set_field() {
    set_field(this.pattern) ;
  }

  private void set_field(int pattern) {
    // Reseed noise so we get a new flow field every time
    sum_activities = 0 ;
    if(pattern == IMAGE && src != null) {
      set_field_img_2D();
    } else {
      if(pattern == PERLIN) {
        noiseSeed((int)random(10000));
        set_field_perlin();
      } else if(pattern == CHAOS) {
        set_field_chaos();
      } else if(pattern == EQUATION) {
        set_field_equation();
      } else if(pattern == BLANK) {
        set_field_blank();
      } else {
        set_field_blank();
      }
    }    
  }






  private void eq_swap(Vec2 dir) {
    float x = dir.x;
    float y = dir.y;
    if(eq.x == 2) dir.x = y;
    if(eq.y == 1) dir.y = x;
  }

  private float eq_len_vector(float x, float y, float dx, float dy, float div) {
    float fx = 0;
    float fy = 0;
    fx = x -dx;
    fy = y -fy;
    return sqrt((fx*fx)+(fy*fy))/div;
  }

  // specific op_ration
  private Vec2 eq_pow(iVec4 pow, Vec2 v) {
    Vec2 r = Vec2(v);
    if(pow.x > 1) {
      if(pow.x%2 == 0) {
        r.x = pow(v.x,pow.x);
      } else {
        r.x = -1 * pow(v.x,pow.x) ;
      }  
    }
    if(pow.y > 1) {
      if(pow.y%2 == 0) {
        r.y = pow(v.y,pow.y);
      } else {
        r.y = -1 * pow(v.y,pow.y) ;
      }
    }
    return r;
  }

  private Vec2 eq_mult(Vec4 mult, Vec2 v) {
    Vec2 r = Vec2(v);
    if(mult.x != 1) {
      r.x = v.x *mult.x;
    }
    if(mult.y != 1) {
      r.y = v.y *mult.y;
    }
    return r;
  }

  private Vec2 eq_root(iVec4 root, Vec2 v) {
    Vec2 r = Vec2(v);
    if(root.x == 2) {
      r.x = sqrt(r.x);
    } else if(root.x == 3) {
      r.x = sqrt(sqrt(r.x));
    } else if(root.x == 4) {
      r.x = sqrt(sqrt(sqrt(r.x)));
    }

    if(root.y == 2) {
      r.y = sqrt(r.y);
    } else if(root.y == 3) {
      r.y = sqrt(sqrt(r.y));
    } else if(root.y == 4) {
      r.y = sqrt(sqrt(sqrt(r.y)));
    }  
    return r;
  }

  // compute op-eration
  private void eq_op(Vec2 dir) {
    for(int rank = 0 ; rank < eq.get_op() ; rank++) {
      if(eq.pow != null) {
        for(iVec4 pv : eq.pow) {
          if(pv.w == rank) {
            dir.set(eq_pow(pv,dir));
            break;
          }
        }
      }
      if(eq.mult != null) {
        for(Vec4 mv : eq.mult) {
          if(mv.w == rank) {
            dir.set(eq_mult(mv,dir));
            break;
          }
        }
      }
      if(eq.root != null) {
        for(iVec4 rv : eq.root) {
          if(rv.w == rank) {
            dir.set(eq_root(rv,dir));
            break;
          }
        }
      }
    }
  }



  private void set_field_equation() { 
    if(eq != null ) {
      if(eq.get_center_dir_2D() != null) center_equation_dir = eq.get_center_dir_2D().copy();
      if(eq.get_center_len_2D() != null) center_equation_len = eq.get_center_len_2D().copy();
    }   

    if(center_equation_dir == null) center_equation_dir = Vec2(0);
    if(center_equation_len == null) center_equation_len = Vec2(0);
    set_field_equation(center_equation_dir, center_equation_len);
  }

  private void set_field_equation(Vec2 c_dir,Vec2 c_len) {
    int dir_offset_x = int(cols *(c_dir.x - .5));
    int dir_offset_y = int(rows *(c_dir.y - .5));

    float len_offset_x = cols *c_len.x;
    float len_offset_y = rows *c_len.y;

    for (int x = dir_offset_x ; x < cols +dir_offset_x ; x++) {
      for (int y = dir_offset_y ; y < rows +dir_offset_y ; y++) {
        Vec2 d = Vec2(x,y);
        // dir
        if(eq != null) {
          eq_swap(d);
          eq_op(d);
          // d.set(y,x);
        }

        float tx = map(d.x, 0, cols, -HALF_PI,HALF_PI);
        float ty = map(d.y, 0, rows, 0,PI);
             
        // len
        Vec2 l = Vec2(x,y);
        if(eq != null ) {
          // l.set(eq_root(eq.root,l));
        }
        float div = cols+rows;
        float len = eq_len_vector(l.x,l.y,len_offset_x,len_offset_y,div);
        // if(len > 1) println(len,frameCount,"before");
        if(eq != null ) {
          if(eq.reverse_len) len = 1.3 -len;
          if(len < 0) len = 0;
        }
        // if(len > 1) println(len,frameCount,"after");

        // Polar to cartesian coordinate
        float xx = cos(tx) ;
        float yy = sin(ty) ;
        float zz = 0 ;
        float ww = len ;

        int cx = x -dir_offset_x;
        int cy = y -dir_offset_y;
        field[cx][cy] = Vec4(xx,yy,zz,ww); 
        field_save[cx][cy] = Vec4(xx,yy,zz,ww);
        sum_activities += field[cx][cy].sum() ;     
      }
    }
  }


  private void set_field_blank() {
    for (int x = 0 ; x < cols ; x++) {
      for (int y = 0 ; y < rows ; y++) {
        field[x][y] = Vec4(0); 
        field_save[x][y] = Vec4(0);   
      }
    }
    sum_activities += 0 ;
  }
  
  private void set_field_chaos() {
    for (int x = 0 ; x < cols ; x++) {
      for (int y = 0 ; y < rows ; y++) {
        float theta = random(TWO_PI);
        float dist = random(1);
        // Polar to cartesian coordinate
        float xx = cos(theta) ;
        float yy = sin(theta) ;
        float zz = 0 ;
        float ww = dist ;
        field[x][y] = Vec4(xx,yy,zz,ww); 
        field_save[x][y] = Vec4(xx,yy,zz,ww);
        sum_activities += field[x][y].sum() ;     
      }
    }
  }

  private void set_field_perlin() {
    float xoff = 0 ;
    for (int x = 0 ; x < cols ; x++) {
      float yoff = 0;
      for (int y = 0 ; y < rows ; y++) {
        float theta = map(noise(xoff,yoff),0,1,0,TWO_PI);
        float dist = noise(xoff,yoff);
        // Polar to cartesian coordinate
        float xx = cos(theta) ;
        float yy = sin(theta) ;
        float zz = 0 ;
        float ww = dist ;
        field[x][y] = Vec4(xx,yy,zz,ww); 
        field_save[x][y] = Vec4(xx,yy,zz,ww);
        sum_activities += field[x][y].sum() ;     
        yoff += .1;
      }
      xoff += .1;
    }
  }

  private void set_field_img_2D() {
    src.loadPixels();
    for(int x = 0 ; x < cols ; x++) {
      for(int y = 0 ; y < rows ; y++) {
        int pix = src.get(x *resolution, y *resolution);

        float theta_x = map_pix(sort.x,pix,0,TAU);
        float theta_y = map_pix(sort.y,pix,0,TAU);
        float vel = map_pix(sort.w,pix,0,1);

        // Polar to cartesian coordinate
        float xx = cos(theta_x) ;
        float yy = sin(theta_y) ;
        float zz = 0 ;
        float ww = vel ;
        field[x][y] = Vec4(xx,yy,zz,ww); 
        field_save[x][y] = Vec4(xx,yy,zz,ww);     

        sum_activities += field[x][y].sum() ;
      }
    }
  }






  private float map_pix(int component_color, int pix, float min, float max) {
    float f = 0;
    if(component_color == RED) {
      f = red(pix);
      return map(f,0, g.colorModeX,min,max);
    } else if(component_color == GREEN) {
      f = green(pix);
      return map(f,0, g.colorModeY,min,max);
    } else if(component_color == BLUE) {
      f = blue(pix);
      return map(f,0, g.colorModeZ,min,max);
    } else if(component_color == HUE) {
      f = hue(pix);
      return map(f,0, g.colorModeX,min,max);
    } else if(component_color == SATURATION) {
      f = saturation(pix);
      return map(f,0, g.colorModeY,min,max);
    } else if(component_color == BRIGHTNESS) {
      f = brightness(pix);
      return map(f,0, g.colorModeZ,min,max);
    } else {
      f = alpha(pix);
      return map(f,0, g.colorModeA,min,max);
    }
  }




  /**
  work directly on the field
  This method is close to reset, but this one load a previous saved field.
  */
  public void refresh() {
    save();
  }

  public void save() {
    if(field != null && field_save != null) {
      for (int x = 0 ; x < cols ; x++) {
        for (int y = 0 ; y < rows ; y++) {
          field[x][y].set(field_save[x][y]);
        }
      }
    }
  }


  /**
  velocity
  */
  /*
  * map velocity
  */
  public void map_velocity(float start1, float stop1, float start2, float stop2) {
    if(field != null && field_save != null) {
      for (int x = 0 ; x < cols ; x++) {
        for (int y = 0 ; y < rows ; y++) {
          map_velocity(x,y,start1,stop1,start2,stop2);
        }
      }
    }
  }

  public void map_velocity(int x, int y, float start1, float stop1, float start2, float stop2) {
    map_velocity(iVec2(x,y), start1, stop1, start2, stop2);
  }
  public void map_velocity(int x, int y, int z, float start1, float stop1, float start2, float stop2) {
    map_velocity(iVec3(x,y,z), start1, stop1, start2, stop2);
  }

  public void map_velocity(iVec coord, float start1, float stop1, float start2, float stop2) {
    if(field != null && field_save != null && coord.x < cols && coord.y < rows) {
      field[coord.x][coord.y].w = map(field[coord.x][coord.y].w,start1,stop1,start2,stop2);
    } else {
      if(coord.x >= cols || coord.y >= rows || coord.x < 0 || coord.y < 0) {
        printErr("method map_velocity() in class Force_field is not possible because your target x or y is not in field dimension");
      } else {
        printErr("method map_velocity() in class Force_field is not possible the field is null");
      }
    }
  }
  /*
  * mult velocity
  */
  public void mult_velocity(float mult) {
    if(field != null && field_save != null) {
      for (int x = 0 ; x < cols ; x++) {
        for (int y = 0 ; y < rows ; y++) {
          mult_velocity(x,y,mult);
        }
      }
    }
  }

  public void mult_velocity(int x, int y, float mult) {
    mult_velocity(iVec2(x,y), mult);
  }
  public void mult_velocity(int x, int y, int z, float mult) {
    mult_velocity(iVec3(x,y,z), mult);
  }

  public void mult_velocity(iVec coord, float mult) {
    if(field != null && field_save != null && coord.x < cols && coord.y < rows) {
      // field[coord.x][coord.y].set(field_original[coord.x][coord.y]);
      field[coord.x][coord.y].w *= mult;
    } else {
      if(coord.x >= cols || coord.y >= rows || coord.x < 0 || coord.y < 0) {
        printErr("method mult_velocity() in class Force_field is not possible because your target x or y is not in field dimension");
      } else {
        printErr("method mult_velocity() in class Force_field is not possible the field is null");
      }
    }
  }





  /**
  public set border
  v 0.0.6
  */
  public void set_border_is(boolean state) {
    border_is = state ;
  }


  /**
  public set spot
  v 0.2.1
  */
  public void set_spot(float pos_x, float pos_y, float size_x, float size_y) {
    for(int i = 0 ; i < spot_list.size() ; i++) {
      set_spot(pos_x,pos_y,size_x,size_y,i);
    }
  }

  public void set_spot(Vec pos, Vec2 size) {
    for(int i = 0 ; i < spot_list.size() ; i++) {
      set_spot(pos,size,i);
    }
  }

  public void set_spot(float pos_x, float pos_y, float size_x, float size_y, int which_one) {
    set_spot(Vec2(pos_x,pos_y), Vec2(size_x,size_y),which_one);
  }

  public void set_spot(Vec pos, Vec2 size, int which_one) {
    set_spot_pos(pos,which_one);
    set_spot_diam(size.x,size.y,which_one);
  }

  /**
  spot detection
  */
  public void set_spot_detection(int spot_area_level) {
    if(spot_area_level <= 0) {
      this.spot_area_level = 1 ;
      printErr("method set_spot_area() class Force_field param level =" + spot_area_level + " level must be upper, instead the value 1 is used");
    } else {
      this.spot_area_level = spot_area_level ;
    }
    int radius_spot_detection = ceil( sqrt(cols*rows) / abs(this.spot_area_level) ) +1;
    for(Spot s : spot_list) {
      s.detection(radius_spot_detection);
    }
  }

  /**
  spot position
  */
  public void set_spot_pos(float x, float y) {
    for(int i = 0 ; i < spot_list.size() ; i++) {
      set_spot_pos(x,y,i);
    } 
  }

  public void set_spot_pos(Vec pos) {
    for(int i = 0 ; i < spot_list.size() ; i++) {
      set_spot_pos(pos, i);  
    }
  }

  public void set_spot_pos(float x, float y, int which_one) {
    set_spot_pos(Vec3(x,y,0),which_one);  
  }

  // main method set pos
  public void set_spot_pos(Vec pos, int which_one) {
    /**
    emergency fix, not enought but stop the bleeding
    */
    if(canvas.x < canvas.y) {
      if(pos.y > canvas.x -resolution) {
        if(pos.x < 0) {
          pos.x = 0 ;
          pos.y = 0 ;
        }
        if(pos.x > canvas.x -resolution) {
          pos.x = canvas.x -resolution;
          pos.y = canvas.x -resolution;
        }
      }
    }

    // Vec2 spot_pos = pos.copy();
    Vec2 temp_pos = Vec2(pos.x,pos.y);
    // Vec2 spot_raw_pos = pos.copy();

    temp_pos.sub(Vec2(canvas_pos));
    if(which_one < spot_list.size()) {
      Spot spot = spot_list.get(which_one);
   //   spot.set_raw_pos(spot_raw_pos);
      Vec3 final_spot = Vec3(temp_pos.x,temp_pos.y,pos.z);
      spot.set_pos(final_spot);
    } else {
      System.err.println("void set_spot_pos(): No Spot match with your target, you must add new spot in the list before set it");
    }
  }

  /*
  * spot size
  */
  public void set_spot_diam(float x, float y) {
    for(int i = 0 ; i < spot_list.size() ; i++) {
      set_spot_diam(x,y,i);  
    }
  }

  public void set_spot_diam(Vec2 size) {
    for(int i = 0 ; i <spot_list.size() ; i++) {
      set_spot_diam(size.x,size.y,i);
    }
  }

  public void set_spot_diam(float x, float y, int which_one) {
    set_spot_diam(Vec2(x,y),which_one);  
  }
  /*
  * main method set size
  */
  public void set_spot_diam(Vec2 size, int which_one) {
    Vec2 final_size = size.copy();
    if(which_one < spot_list.size()) {
      Spot spot = spot_list.get(which_one);
      spot.set_size(final_size);
    } else {
      System.err.println("void set_spot_diam(): No Spot match with your target, you must add new spot in the list before set it");
    }  
  }

  /*
  * spot mass
  */
  public void set_spot_mass(int mass) {
    for(int i = 0 ; i < spot_list.size() ; i++) {
       set_spot_mass(mass,i);
    }  
  }

  public void set_spot_mass(int mass, int which_one) {
    if(which_one < spot_list.size()) {
      Spot spot = spot_list.get(which_one);
      spot.set_mass(mass);
    } else {
      System.err.println("void set_spot_mass():No Spot match with your target, you must add new spot in the list before set it");
    }  
  }

  /*
  * spot tesla
  */
  public void set_spot_tesla(int tesla) {
    for(int i = 0 ; i <spot_list.size() ; i++) {
      set_spot_tesla(tesla,i);
    }
  }

  public void set_spot_tesla(int tesla, int which_one) {
    if(which_one < spot_list.size()) {
      Spot spot = spot_list.get(which_one);
      spot.set_tesla(tesla);
    } else {
      System.err.println("void set_spot_tesla(): No Spot match with your target, you must add new spot in the list before set it");
    }
  }


  /*
  * get
  */
  public int get_spot_area_level() {
    return spot_area_level ;
  }

  public int get_spot_num() {
    if(spot_list != null) return spot_list.size();
    else return -1;
  }

  public int get_spot_south_num() {
    if(spot_mag_south_list != null) return spot_mag_south_list.size();
    else return -1;
  }

  public int get_spot_north_num() {
    if(spot_mag_north_list != null) return spot_mag_north_list.size();
    else return -1;
  }

  public Vec3 [] get_spot_pos() {
    Vec3 [] pos = new Vec3[spot_list.size()] ;
    for(int i = 0 ; i < spot_list.size() ; i++) {
      Spot s = spot_list.get(i);

      pos[i] = Vec3(s.get_pos()).copy();
      pos[i].add(canvas_pos.x,canvas_pos.y,0);
    }
    return pos;  
  }

  public Vec3 get_spot_pos(int which_one) {
    if(spot_list != null && spot_list.size() > which_one) {
      Spot spot = spot_list.get(which_one);
      return Vec3(spot.get_pos()).add(canvas_pos.x,canvas_pos.y,0);
    } else return null ;
  }


  /**
  * get spot size
  */
  public Vec2 [] get_spot_size() {
    Vec2 [] size = new Vec2[spot_list.size()] ;
    for(int i = 0 ; i < spot_list.size() ; i++) {
      Spot s = spot_list.get(i) ;
      size[i] = Vec2(s.get_size()).copy() ;
    }
    return size;
  }

  public Vec2 get_spot_size(int which_one) {
    if(spot_list != null && spot_list.size() > which_one) {
      Spot spot = spot_list.get(which_one);
      return Vec2(spot.get_size());
    } else return null ;
  }

  public int [] get_spot_tesla() {
    int [] tesla = new int[spot_list.size()] ;
    for(int i = 0 ; i < spot_list.size() ; i++) {
      Spot s = spot_list.get(i) ;
      tesla[i] = s.get_tesla() ;
    }
    return tesla;
  }

  public int get_spot_tesla(int which_one) {
    if(spot_list != null && spot_list.size() > which_one) {
      Spot spot = spot_list.get(which_one);
      return spot.get_tesla();
    } else {
      System.err.println("No Spot match with your target, try another one! charge '0' is used");
      return 0 ;
    }
  }

  public float [] get_spot_mass() {
    float [] mass = new float[spot_list.size()] ;
    for(int i = 0 ; i < spot_list.size() ; i++) {
      Spot s = spot_list.get(i) ;
      mass[i] = s.get_mass() ;
    }
    return mass;
  }

  public float get_spot_mass(int which_one) {
    if(spot_list != null && spot_list.size() > which_one) {
      Spot spot = spot_list.get(which_one);
      return spot.get_mass();
    } else {
      System.err.println("No Spot match with your target, try another one! mass '1' is used");
      return 1 ;
    }
  }
  
  /**
  * return arraylist spot$
  * @return ArrayList
  */
  public ArrayList<Spot> get_list() {
    if(spot_list != null) return spot_list ; else return null;
  }

  public ArrayList<Spot> get_list_south() {
    if(spot_mag_south_list != null) return spot_mag_south_list; else return null;
  }

  public ArrayList<Spot> get_list_north() {
    if(spot_mag_north_list != null) return spot_mag_north_list; else return null;
  }

  public ArrayList<Spot> get_list_neutral() {
     if(spot_mag_neutral_list != null) return spot_mag_neutral_list; else return null;
  }




















  



  /**
  CANVAS
  v 0.0.3
  */
  /**
  *set canvas
  */
  public void set_canvas(iVec2 pos, iVec2 size) {
    set_canvas_pos(pos);
    set_canvas_size(size);
  }

  public void set_canvas_pos(iVec2 canvas_pos) {
    if(this.canvas_pos != null) {
      this.canvas_pos.set(canvas_pos);
    } else {
      this.canvas_pos = iVec2(canvas_pos);
    }
  }

  public void set_canvas_size(iVec2 canvas) {
    if(this.canvas != null) {
      this.canvas.set(canvas);
    } else {
      this.canvas = iVec2(canvas);
    }
  }

  /*
  * get canvas
  */
  public iVec2 get_canvas() {
    return canvas;
  }

  public iVec2 get_canvas_pos() {
    if(canvas_pos == null) return iVec2(); else return canvas_pos;
  }

  public int get_resolution() {
    return resolution;
  }



















  /**
  * set specific arg for specificic field
  */

  /**
  * fluid field
  */
  public void set_frequence(float frequence) {
    this.frequence = frequence ;
  } 
  public void set_viscosity(float viscosity) {
    this.viscosity = viscosity ;
  }
  public void set_diffusion(float diffusion) {
    this.diffusion = diffusion ;
  }


  /**
  set mass field
  */
  public void set_mass_field(float mass_field) {
    this.mass_field = mass_field ;
  }


  /*
  misc
  */
  public void reverse_flow(boolean reverse_is) {
    this.reverse_is = reverse_is ;
  }









































  /**
  reset
  v 0.2.0
  */
  public void clear_spot() {
    if(reset_ref_spot_pos_list_is != null) reset_ref_spot_pos_list_is.clear();
    if(spot_list != null) spot_list.clear();
    if(spot_mag_north_list != null) spot_mag_north_list.clear();
    if(spot_mag_south_list != null) spot_mag_south_list.clear();
    if(spot_mag_neutral_list != null) spot_mag_neutral_list.clear();
  }

  public void ref_spot(int which_one) {
    reset_ref_spot_pos_list_is.set(which_one,true);
  }

  public void ref_spot() {
    reset_ref_spot_pos_list_is.set(0,true);
  }

  /**
  * reset force field and the Navier_strokr stable fuild if this one is active
  */
  public void reset() {
    reset_force_field();
  }

  private void reset_force_field() {
    sum_activities = 0;
    for (int x = 0; x < cols ; x++) {
      for (int y = 0; y < rows ; y++) {
        field[x][y] = Vec4(0);
        if(type == FLUID) {
          ns_2D.set_dx(x,y,0);
          ns_2D.set_dy(x,y,0);
        }
      }
    }
  }

  public void reset_spot_area() {
    reset_force_field_spot_area();
  }
  
  private void reset_force_field_spot_area() {
    // reset part where the spot area is active
    if(spot_list != null && spot_list.size() > 0) {
      for(Spot s : spot_list) {
        if(s.get_pos() != null && s.get_detection() != null && s.get_detection().size() > 0) {
          for(iVec2 coord : s.get_detection()) {
            Vec2 pos_cell = mult(coord, resolution);
            pos_cell.add(s.get_pos());
            Vec2 d = Vec2(s.get_pos().x,s.get_pos().y);
            d.div(resolution);
            int x = coord.x +(int)d.x;
            int y = coord.y +(int)d.y;
            if(x >= 0 && y >= 0 && x < field.length && y < field[0].length) {
              field[x][y].set(0);
            }  
          }
        }
      }
    } 
  }

  /**
  refresh
  v 0.0.2
  */
  public void refresh_sorting_channel(int... sorting_channel) {
    sorting_channel(sorting_channel);
    set_field_img_2D();
  }
  









  /**
  activity
  v 0.0.5
  */
  /**
  * activity, return true if the Force field is not equal to 0
  * @return boolean
  * @param float threshold is tolerance to start if there is an activity who can interest the rest of the world !
  */
  public boolean activity_is(float threshold) {
    if(sum_activities < threshold && sum_activities > -threshold) {
      return false ; 
    } else {
      return true ;
    }
  }
  /**
  * activity, return true if the field is sum field is different than previous.
  * @return boolean
  * 
  */
  float ref_activities = 0 ;
  public boolean activity_is() {
    boolean spot_activity_is = false ;
    if(spot_list != null && spot_list.size() > 0) {
      for(Spot s : spot_list) {
        if(s.get_pos() != null) {
          spot_activity_is = s.activity_is();
          if(spot_activity_is) {
            break ;
          }      
        }
      }
    }

    if(ref_activities != sum_activities || ref_activities == 0 || spot_activity_is) {
      ref_activities = sum_activities;
      sum_activities = 0;
      return true;
    } else if(ref_activities == sum_activities) {
      return false;
    } else {
      return false;
    }
  }

  /**
  * get_activity(), return true if the Force field is not equal to 0
  * @return float
  */
  public float get_activity() {
    return sum_activities;
  }













  /**
  update
  v 0.1.0.2
  */
  public void update() { 
    if(type == FLUID) {
      update_spot_fluid();
      ns_2D.update(frequence, viscosity, diffusion) ;
      update_fluid_field(ns_2D);
    } else if(type == GRAVITY) {
      update_grav_mag_field();
    } else if(type == MAGNETIC) {
      count_spot_mag();
      update_grav_mag_field();
    } else if(super_type == STATIC) {
      // println("STATIC field convert to texture", frameCount);
      convert_field_to_texture();
    }
  }
  


  // update stable fluid field
  private void update_fluid_field(Navier_Stokes n) {
    if(n instanceof Navier_Stokes_2D) {
      Navier_Stokes_2D ns = (Navier_Stokes_2D)n ;
      for(int x = 0 ; x < ns.get_NX() ; x++) {
        for(int y = 0 ; y < ns.get_NY() ; y++) {
          float dx = ns.get_dx(x,y);
          float dy = ns.get_dy(x,y);
          // dz and dw serve to nothing in this case
          float dz = 0 ;
          float dw = 0 ;
          field[x][y] = Vec4(dx,dy,dz,dw);
          field_to_texture(x,y,dx,dy);
          sum_activities += field[x][y].sum() ;
        }
      }
    }
  }
  

  // update gravity and magnetic field
  private void update_grav_mag_field() {
    compute_with_area_detection();
    // old style, very slow
    //compute_without_area()
  }
  

  private void compute_with_area_detection() {
    for(Spot s : spot_list) {
      if(s.get_pos() != null && s.get_detection() != null && s.get_detection().size() > 0) {
        s.reverse_emitter(reverse_is);
        for(iVec2 coord : s.get_detection()) {
          Vec2 pos_cell = mult(coord, resolution);
          pos_cell.add(s.get_pos());
          float theta = theta_2D(pos_cell,Vec2(s.get_pos().x,s.get_pos().y));
          Vec2 vector = Vec2(cos(theta),sin(theta));  
          
          float force = 0;
          /**
          not sure the secuty max_force work, there is a problem
          with the center of spot [0][0] the force is to hight so when the vector is add, it's very too much :(
          and a big red line is create in MAGNETIC type
          */
          float max_force = .999;
          if(type == GRAVITY) {
            force = spot_gravity_force(s,pos_cell);
          } else if(type == MAGNETIC) {
            force = spot_magnetic_force(s,pos_cell);
          }
          if(force >= max_force) {
            force = max_force ;
          }
          vector.mult(force);
          
          Vec2 d = Vec2(s.get_pos().x,s.get_pos().y);
          d.div(resolution);

          int x = coord.x +(int)d.x;
          int y = coord.y +(int)d.y;
    
          if(x >= 0 && y >= 0 && x < field.length && y < field[0].length) {
            if(force >= max_force) {
              field[x][y].set(vector.x,vector.y,0,0);
            } else {
              field[x][y].add(vector.x,vector.y,0,0);
            }
          }        
        }       
      }
    }

    // update texture field
    for (int x = 0; x < cols ; x++) {
      for (int y = 0; y < rows ; y++) {
        sum_activities += field[x][y].sum();
        field_to_texture(x,y,field[x][y].x,field[x][y].y);
      }
    }
  }

  @Deprecated
  private void compute_without_area_detection() {
    // very very slow, because there is 3 loop, two for coordonate and one for the spot list
    // so when the spot list is big... the frameRate decrease fast
    for (int x = 0; x < cols ; x++) {
      for (int y = 0; y < rows ; y++) {
        Vec2 flow = flow(Vec2(x,y), spot_list);
        field[x][y] = Vec4(flow.x,flow.y,0,0);
        field_to_texture(x,y,field[x][y].x,field[x][y].y);
        sum_activities += field[x][y].sum() ;
      }
    }
  }

  @Deprecated
  private Vec2 flow(Vec2 coord, ArrayList<Spot> list) {
    Vec2 pos_cell = mult(coord, resolution);
    Vec2 field_dir = Vec2();
    float force = 0;
    // each case of field, must now the spot influencer to get it the data force
    for(Spot s : list) {
      s.reverse_emitter(reverse_is);
      float theta = theta_2D(pos_cell,Vec2(s.get_pos()));
      Vec2 temp_field = Vec2(cos(theta),sin(theta));   
      if(type == GRAVITY) {
        force = spot_gravity_force(s,pos_cell);
      } else if(type == MAGNETIC) {
        force = spot_magnetic_force(s,pos_cell);
      }
      temp_field.mult(force);
      field_dir.add(temp_field);
    }
    return field_dir ;
  }
  
  /**
  magnetic force
  v 0.0.2
  */
  /**
  * spot_magnetic_force
  * @return float magnetic force
  */
  private float spot_magnetic_force(Spot s, Vec2 pos_cell) {
    Vec2 spot_pos = Vec2(s.get_pos());
    float dist = dist(spot_pos, pos_cell);
    int tesla_charge = s.get_tesla();
    return intensity(dist, tesla_charge);
  }
  
  /*
  * intensity
  * very simple formula, not real one :(
  */
  private float intensity(float dist, int tesla) {
    float l = sqrt((get_canvas().x *get_canvas().x) + (get_canvas().y * get_canvas().y));
    float d = constrain(dist, 1, 2 *l) ;
    float speed = .05;
    float distance = 1 /d *speed;
    return distance *tesla *l *.02;
  }

  /**
  gravity force
  v 0.0.1
  */
  /** 
  * spot_gravity_force
  * @return float gravity force
  */
  private float spot_gravity_force(Spot s, Vec2 pos_cell) {
    Vec2 spot_pos = Vec2(s.get_pos());
    float m_2 = s.get_mass();
    float m_1 = mass_field;
    float dist = dist(spot_pos, pos_cell);
    double gravity = 1. / (g_force(dist, m_1, m_2) *1000000000L);
    return (float)gravity;
  }

  /**
  CONVERT TO TEX VELOCITY & TEXTURE
  local method to convert vector to texture
  */
  private void convert_field_to_texture() {
    for (int x = 0; x < cols ; x++) {
      for (int y = 0; y < rows ; y++) {
        // here we convert the vector field Vec4 to Vec2 to have a real vector
        /*
        Vec2 flow = Vec2(field[x][y].x,field[x][y].y).mult(field[x][y].w);
        field_to_texture(x,y,flow.x,flow.y);
        */
        Vec2 flow_dir = Vec2(field[x][y].x,field[x][y].y);
        field_to_tex_dir(x,y,flow_dir.x,flow_dir.y);
        //Vec2 flow_vel = Vec2(field[x][y].x,field[x][y].y));
        field_to_tex_vel(x,y,field[x][y].w);
        sum_activities += field[x][y].sum() ;
      }
    }
  }

  private void field_to_tex_dir(int x, int y, float vx, float vy) {
    float dir_rad = atan2(vx,vy) ;
    float direction = map(dir_rad, -PI, PI, 0, g.colorModeX);
    int colour_dir = color(direction);
    texture_direction.set(x,y,colour_dir);
  }

  private void field_to_tex_vel(int x, int y, float vel) {
    vel = map(vel,0,1,0,g.colorModeX);
    int colour_vel = color(vel);
    texture_velocity.set(x,y,colour_vel);
  }
  
  private void field_to_texture(int x, int y, float vx, float vy) {
    // direction
    float dir_rad = atan2(vx,vy) ;
    float direction = map(dir_rad, -PI, PI, 0, g.colorModeX);
    int colour_dir = color(direction);
    texture_direction.set(x,y,colour_dir);

    // velocity
    float velocity = (float)Math.sqrt(vx*vx + vy*vy);
    velocity = map(velocity, 0, 1, 0,g.colorModeX);
    int colour_vel = color(velocity);
    texture_velocity.set(x,y,colour_vel);
  }







  /**
  update spot
  v 0.2.3
  */
  // spot mag
  private void count_spot_mag() {
    int total_sub_list = spot_mag_north_list.size() + spot_mag_south_list.size() + spot_mag_neutral_list.size() ;
    if(total_sub_list < spot_list.size()) {
      for(Spot s : spot_list) {
        if(s.get_tesla() > 0 && total_sub_list < spot_list.size()) {
          spot_mag_north_list.add(s) ;
          total_sub_list++ ;
        }
        if(s.get_tesla() < 0 && total_sub_list < spot_list.size()) {
          spot_mag_south_list.add(s) ;
          total_sub_list++ ;
        }
      }
    }  
  }



 // spot fluid
  private void update_spot_fluid() {
    int which_one = 0 ;
    for(Spot s : spot_list) {
      update_spot_fluid(ns_2D, s.get_pos(), which_one);
      update_spot_fluid_ref(ns_2D, s.get_pos(), which_one);
      which_one++;
    }
  }

  private void update_spot_fluid_ref(Navier_Stokes n, Vec pos_ref, int which_one) {
    // init
    if(spot_fluid_pos_ref == null) {
      spot_fluid_pos_ref = new ArrayList<Vec>();
    }
    // rebuilt ref list if necessary, in case the spot num change
    if(spot_fluid_pos_ref.size() != spot_list.size()) {
      spot_fluid_pos_ref.clear();
      for(Spot s : spot_list) {
        Vec pos = Vec2(s.get_pos());
        spot_fluid_pos_ref.add(pos);
      }
    }

    if(n instanceof Navier_Stokes_2D) {
      spot_fluid_pos_ref.set(which_one, Vec2(pos_ref));
    } else if(n instanceof Navier_Stokes_3D) {
      spot_fluid_pos_ref.set(which_one, Vec3(pos_ref));
    }   
  }

  private Vec get_spot_fluid_ref(int which_one) {
    if(spot_fluid_pos_ref != null) {
      return spot_fluid_pos_ref.get(which_one);
    } else return null;
  }

  private void update_spot_fluid(Navier_Stokes n, Vec spot_pos, int which_one) {
    if(n instanceof Navier_Stokes_2D) {
      Navier_Stokes_2D ns = (Navier_Stokes_2D)n;
      Vec2 c = Vec2(canvas);
      Vec2 c_pos = Vec2(canvas_pos);
      Vec2 target = Vec2(spot_pos);
      update_spot_fluid_2D(ns, target, c, c_pos, which_one);
    } else if(n instanceof Navier_Stokes_3D) {
      Navier_Stokes_3D ns = (Navier_Stokes_3D)n;
      Vec3 target = Vec3(spot_pos);
      Vec3 c = Vec3(canvas);
      Vec3 c_pos = Vec3(canvas_pos);
      update_spot_fluid_3D(ns, target, c, c_pos, which_one);     
    }
  }
  
  private void update_spot_fluid_2D(Navier_Stokes_2D ns, Vec2 target, Vec2 canvas, Vec2 canvas_pos, int which_one) {
    Vec2 pos_ref_2D = Vec2();
    if(spot_fluid_pos_ref != null || reset_ref_spot_pos_list_is.get(which_one)) {
      pos_ref_2D = Vec2(get_spot_fluid_ref(which_one));
      reset_ref_spot_pos_list_is.set(which_one,false);
    } 
    
    Vec2 vel = sub(target, pos_ref_2D);

    Vec2 cell = canvas.div(ns.get_NX(),ns.get_NY());
    iVec2 target_cell = floor(div(target,cell));

    vel.x = (abs(vel.x) > limit_vel)? 
    Math.signum(vel.x) *limit_vel : 
    vel.x;
    vel.y = (abs(vel.y) > limit_vel)? 
    Math.signum(vel.y) *limit_vel : 
    vel.y;
    ns.apply_force(target_cell.x, target_cell.y, vel.x, vel.y);
  }
  
  private void update_spot_fluid_3D(Navier_Stokes_3D ns, Vec3 target, Vec3 canvas, Vec3 canvas_pos, int which_one) {
    Vec3 pos_ref_3D = Vec3();
    /*
    if(pos_ref_3D == null || reset_ref_spot_pos_list_is.get(which_one)) {
      pos_fluid_spot_ref(target);
      reset_ref_spot_pos_list_is.set(which_one,false);
    } 
    */

    Vec3 cell = canvas.div(ns.get_N());
    Vec3 vel = sub(target, pos_ref_3D);
    iVec3 target_cell = floor(div(target,cell));

    vel.x = (abs(vel.x) > limit_vel)? 
    Math.signum(vel.x) *limit_vel : 
    vel.x;
    vel.y = (abs(vel.y) > limit_vel)? 
    Math.signum(vel.y) *limit_vel : 
    vel.y;
    vel.z = (abs(vel.z) > limit_vel)? 
    Math.signum(vel.z) *limit_vel : 
    vel.z;

    ns.apply_force(target_cell.x, target_cell.y, target_cell.z, vel.x, vel.y, vel.z);

    pos_ref_3D.set(target);
  }





























  /**
  get velocity and direction texture
  get texture can be used externaly
  */
  public PImage get_tex_velocity() {
    return texture_velocity;
  }

  public PImage get_tex_direction() {
    return texture_direction;
  }



  /**
  * get fluid info
  */
  public float get_frequence() {
    return frequence ;
  } 
  public float get_viscosity() {
    return viscosity ;
  }
  public float get_diffusion() {
    return diffusion ;
  }


  /**
  get mass field
  */
  public float get_mass_field() {
    return mass_field ;
  }








  /**
  get grid
  v 0.1.0
  */
  public Vec4 [][] get_field() {
    if(field != null) return field ;
    else return null;
  }
  public int get_NX() {
    return NX;
  }

  public int get_NY() {
    return NY;
  }

  public int get_NZ() {
    return NZ;
  }

  public int get_cols() {
    return cols;
  }
  public int get_rows() {
    return rows ;
  }






  /**
  get type and pattern 
  */
  /**
  * return type force field is used
  * @return int
  */
  public int get_type() {
    return type;
  }

  /**
  * return patttern force field is used
  * @return int
  */
  public int get_pattern() {
    return pattern;
  }
  /**
  * return super type force field is used
  * @return int
  */
  public int get_super_type() {
    return super_type;
  }


  /**
  is 
  */
    /**
  * return is the force field are build or not
  * @return boolean
  */
  public boolean is() {
    return is;
  }


  /**
  get border
  */
  /**
  * return true if the border is active, false if it's not
  * @return boolean
  */
  public boolean border_is() {
    return border_is ;
  }




  


  

  /**
  direction from grid
  v 0.1.0
  */

  /**
  dir_in_grid
  v 0.2.1
  */
  /**
  * it's most important method, this one give the direction of the vehicle in according force field.
  * @return Vec2
  Here must improve the algorithm, when there is a spot in the cell, because in this case the precision direction need be very exact.
  */
  public Vec2 dir_in_grid(Vec2 vehicle_pos) {
    Vec2 dir = Vec2(0) ;
    int max_col = cols-1;
    int max_row = rows-1;

    int x = int(constrain(vehicle_pos.x /resolution, 0, max_col));
    int y = int(constrain(vehicle_pos.y /resolution, 0, max_row));

    if(field != null) {
      if(Double.isNaN(field[x][y].x) || Double.isNaN(field[x][y].y)) {
        dir = Vec2(1).copy() ;
      } else {
        // Need to check the position vehicle, in the case this one is in the last cell, where the spot is. 
        // If the the spot and the vehicle are in the same cell, it's necessary to return a direction very focus on spot.
        dir = dir_check_rank(x,y,vehicle_pos); 
      }
    }
    // reverse 
    // the type MAGNETIC is not include because the way depend of the tesla
    if(type != MAGNETIC && dir != null && reverse_is) {
      dir.mult(-1);
    }
    return dir ;
  }

  Vec2 dir_check_rank(int x, int y,Vec2 pos_v) {
    Vec2 dir = Vec2() ;
    if((type == MAGNETIC || type == GRAVITY)) {
      int rank = match_spot(pos_v);
      if(rank != -1) {
        Spot s = spot_list.get(rank);
        if(s.emitter_is()) {
          dir = null ;
        } else {
          Vec2 pos_cell = mult(Vec2(x,y),resolution);
          float theta = 0;
          pos_v.sub(resolution *.5);
          theta = theta_2D(pos_v,Vec2(s.get_pos()));

          float force = 1 ;
          if(type == MAGNETIC) { 
            force = spot_magnetic_force(s,pos_cell); 
          }
          if(type == GRAVITY) { 
            force = spot_gravity_force(s,pos_cell); 
          }

          Vec2 temp_field = Vec2(cos(theta),sin(theta));
          temp_field.mult(force);
          dir.set(0);
          dir.add(temp_field);
        } 
      } else {
        dir = Vec2(field[x][y].x,field[x][y].y);
      }     
    } else {
      dir = Vec2(field[x][y].x,field[x][y].y);
    }
    return dir;
  }

  private int match_spot(Vec2 vehicle_pos) {
    int spot_match = -1;
    if(spot_list != null) {
      for(int i = 0 ; i < spot_list.size() ; i++) {
        // check if the vehicle is in the range of the spot
        Spot s = spot_list.get(i);
        if(s.get_pos() != null && s.get_size() != null) {
          Vec2 spot_pos = Vec2(s.get_pos().x,s.get_pos().y);
          Vec2 spot_size = Vec2(s.get_size().x, s.get_size().y);
          if(compare(vehicle_pos,spot_pos, spot_size.mult(2))) {
            spot_match = i ;
            break;
          } 
        }
      }
    }
    return spot_match ;
  }



 

  











  private Spot get_spot(Vec2 vehicle_pos) {
    Spot spot = new Spot();
    if(spot_list != null) {
      for(Spot s : spot_list) {
        // check if the vehicle is in the range of the spot
        if(compare(vehicle_pos, (Vec2)s.get_pos(), Vec2(s.get_size().x, s.get_size().y).mult(2) ) ) {
          spot = s ;
          break;
        } 
      }
      return spot ;
    } else return spot;
  }


  /**
  field warp
  v 0.3.1
  Warp position
  */
  
  public Vec2 field_warp(Vec2 uv, float scale) {

    int cell_x = (int) Math.floor(uv.x*NX);
    int cell_y = (int) Math.floor(uv.y*NY);

    float cell_u = (uv.x *NX -(cell_x)) *(1./NX);
    float cell_v = (uv.y *NY -(cell_y)) *(1./NY);

    // security ArrayIndexOutOfBoundsException
    // CX
    int cx = cell_x;
    int cx_sub = cell_x-1;
    int cx_add = cell_x+1;
    if(cx >= get_cols()) cx -= get_cols();
    if(cx_sub < 0) cx_sub = get_cols()+cx_sub;
    if(cx_add >= get_cols()) cx_add -= get_cols();
    
    // CY
    int cy = cell_y;
    int cy_sub = cell_y-1;
    int cy_add = cell_y+1;
    if(cy >= get_rows()) cy -= get_rows();
    if(cy_sub < 0) cy_sub = get_rows()+cy_sub;
    if(cy_add >= get_rows()) cy_add -= get_rows();

    // compute
    Vec2 result = Vec2();

    result.x = (cell_u > .5)? 
    lerp(field[cx][cy].x, field[cx_add][cy].x, cell_u-.5) : 
    lerp(field[cx_sub][cy].x, field[cx][cy].x, .5-cell_u);

    result.y = (cell_v > .5)? 
    lerp(field[cx][cy].y, field[cx][cy_add].y, cell_u) : 
    lerp(field[cx][cy].y, field[cx][cy_sub].y, .5-cell_v);

    result.mult(-scale).add(uv);

    return result;
  }
  

















  /**
  end Navier-stokes method
  */





  /**
  util v 0.0.3.1
  library private methods
  */
  /**
  * compute angle to vectorial direction
  */
  private float theta_2D(Vec2 current_coord, Vec2 target) {
    Vec2 current_cell_pos = current_coord.copy() ;
    current_cell_pos.add(resolution *.5);
    Vec2 dir = look_at(current_cell_pos, target);
    // why multiply by '-1' it's a mistery
    return -1 *dir.angle();
  }




  /**
  * Sorting channel
  * Here the sorting component must use the int Constants ROPE: r.RED, r.GREEN, r.BLUE, r.ALPHA, r.HUE, r.SATURATION, r.BRIGHTNESS
  */
  private void sorting_channel(int... sorting) {
    if(sorting.length == 1) {
      this.sort = iVec4(sorting[0],sorting[0],sorting[0],sorting[0]);
    } else if(sorting.length == 2) {
      this.sort = iVec4(sorting[0],sorting[0],sorting[0],sorting[1]);
    } else if(sorting.length == 3) {
      this.sort = iVec4(sorting[0],sorting[1],-1,sorting[2]);
    } else if(sorting.length == 4){
      this.sort = iVec4(sorting[0],sorting[1],sorting[2],sorting[3]);
    } else if(sorting.length > 4){
      this.sort = iVec4(sorting[0],sorting[1],sorting[2],sorting[3]);
      printErr("void sorting_channel(): Too much channel to sort, the first 4 is used");
    } else {
      this.sort = iVec4(1) ;
      printErr("void sorting_channel(): No channel available to sort, the value 1 is used for all component");
    }
  }
}

/**
END class Force_field
*/















