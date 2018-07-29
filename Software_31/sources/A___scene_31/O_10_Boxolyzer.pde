/**
BOXOLYZER
2012-2018
v 1.1.1
*/
ArrayList<BOITEaMUSIQUE> boiteList ;
  
class Boxolyzer extends Romanesco {
  public Boxolyzer() {
    //from the index_objects.csv
    item_name = "Boxolyzer" ;
    ID_item = 10 ;
    ID_group = 1 ;
    item_author  = "Stan le Punk";
    item_version = "Version 1.1.1";
    item_pack = "Base 2012" ;

    item_costume = "";
    item_mode = "Line/Circle";

    hue_fill_is = true;
    sat_fill_is = true;
    bright_fill_is = true;
    alpha_fill_is = true;
    hue_stroke_is = true;
    sat_stroke_is = true;
    bright_stroke_is  = true;
    alpha_stroke_is = true;
    thickness_is = true;
    size_x_is = true;
    size_y_is = true;
    size_z_is = true;
    diameter_is = false;
    canvas_x_is = true;
    canvas_y_is = false;
    canvas_z_is = false;

    // frequence_is = true;
    speed_x_is = false;
    speed_y_is = false;
    speed_z_is = false;
    spurt_x_is = false;
    spurt_y_is = false;
    spurt_z_is = false;
    dir_x_is = true;
    dir_y_is = false;
    dir_z_is = false;
    jit_x_is = false;
    jit_y_is = false;
    jit_z_is  = false;
    swing_x_is = false;
    swing_y_is = false;
    swing_z_is = false;

    quantity_is = true;
    variety_is = false;
    life_is = false;
    flow_is = false;
    quality_is = false;
    area_is = false;
    angle_is = false;
    scope_is = false;
    scan_is = false;
    align_is = false;
    repulsion_is = false;
    attraction_is = false;
    density_is = false;
    influence_is = false;
    calm_is = false;
    spectrum_is = false;
  }
  //GLOBAL
  boolean newDistribution ;
  int numBoxRef ;

  //SETUP
  void setup() {
    setting_start_position(ID_item, width/2, height/2, 0) ;
    boitesSetting() ;
  }
  
  //DRAW
  void draw() {
    //CLASSIC DISPLAY
    int numBox = int(map(quantity_item[ID_item],0, 1, 1, NUM_BANDS)) ;
    if (numBox != numBoxRef ) newDistribution = true ;
    numBoxRef = numBox ;
    Vec3 size = Vec3(size_x_item[ID_item],size_y_item[ID_item],size_z_item[ID_item]) ;

    // color and thickness
    aspect_rope(fill_item[ID_item], stroke_item[ID_item], thickness_item[ID_item]) ; 
    //
    distribution(numBox, newDistribution) ;
    
    // MODE DISPLAY with the dropdown menu of controler
    if  (mode[ID_item] ==0) {
      boxolyzer_line(size, horizon[ID_item], dir_x_item[ID_item]);
    } else if (mode[ID_item] ==1) {
      boxolyzer_circle(size, (int)canvas_x_item[ID_item], horizon[ID_item], dir_x_item[ID_item]);
    }



    // INFO
    item_info[ID_item] = ("There is " +numBox + " bands analyzed");
    
  }
  
  //ANNEXE VOID
  void distribution(int n, boolean newOne) {
     if (newOne) newDistributionBoite(n) ;
     newDistribution = false ;
   }
  
  boolean orientation ;
  // BOXLIZER CIRCLE
  void boxolyzer_circle(Vec3 size, int diam, boolean groundPosition, float dir) {
    if( action[ID_item] && key_r ) orientation = !orientation ;
    int surface = diam*diam ; // surface is equale of square surface where is the cirlcke...make sens ?
    int radius = ceil(radius_from_circle_surface(surface)) ;
    
    int n = boiteList.size() ;
    float factorSpectrum = 0 ;
    Vec3 pos = Vec3() ;
   // println("circle",n,band.length);
    for(int i=0; i < n; i++) {

      if(i < band_length()) {
        factorSpectrum = band [ID_item][i] ;
      }
      float stepAngle = map(i, 0, n, 0, 2*PI) ; 
      float angle =  2*PI - stepAngle;
      if(orientation) pos.set(projection(angle, radius).x +pos.x, projection(angle, radius).y +pos.y, pos.z) ;
      else  pos.set(projection(angle, radius).x +pos.x, 0, projection(angle, radius).y +pos.z) ;

      BOITEaMUSIQUE boiteAmusique = (BOITEaMUSIQUE) boiteList.get(i) ;
      boiteAmusique.showTheBoite(pos, size, factorSpectrum, groundPosition, dir) ;
    }
  }



  // EQUALIZER CLASSIC
  void boxolyzer_line(Vec3 size, boolean groundPosition, float dir) {
    Vec3 pos = Vec3(0,height *.5,0);
    float factorSpectrum = 0;
    int num = boiteList.size();
   // println(num,band[ID_item].length);
    // int canvasFinal = width ;
    int canvasFinal = (int)map(canvas_x_item[ID_item], width/10, width, width/2,width*3)  ;
    int displacement_symetric = int(width *.5 -canvasFinal *.5) ;
    Vec3 temp_pos = Vec3() ;
    Vec3 displacement = Vec3(width/2, height/2, 0) ;
    for( int i = 0 ; i < num ; i++) {
      pos.x = (i *canvasFinal /num) + (canvasFinal /(num *2)) +displacement_symetric ;
      if(i < band_length()) {
        factorSpectrum = band[ID_item][i];
      }
      BOITEaMUSIQUE boiteAmusique = (BOITEaMUSIQUE) boiteList.get(i) ;
      if(!FULL_RENDERING) {
        factorSpectrum = .5 ;
      }
      temp_pos.set(sub(pos, displacement)) ;
      boiteAmusique.showTheBoite(temp_pos, size, factorSpectrum, groundPosition, dir) ;
    }
  }
  // END EQUALIZER
  
  
  
  
  
  
  // GLOBAL VOID
  void boitesSetting() {
    boiteList = new ArrayList<BOITEaMUSIQUE>();
  }
  //
  void newDistributionBoite(int n) {
    boiteList.clear() ;
    for (int i = 0 ; i < n ; i++ ) addBoite(i) ;
  }
  //
  void addBoite(int ID) {
    Vec3 size = Vec3(1) ;
    BOITEaMUSIQUE boiteAmusique = new BOITEaMUSIQUE(size, ID) ; 
    boiteList.add(boiteAmusique) ;
  }
  // END GLOBAL VOID
}
//END







///////
//CLASS
class BOITEaMUSIQUE {
  //PVector pos = new PVector(0,0,0) ;
  Vec3 size ;
  int ID ;
  
  BOITEaMUSIQUE(Vec3 size, int ID) {
    this.ID = ID ;
    this.size = size ;
  }
  
  
  
  void showTheBoite(Vec3 pos, Vec3 size, float factor, boolean groundLine, float dir) {
    Vec3 newSize = Vec3(size.x, size.y *factor, size.z *factor) ;
    //put the box on the ground !

    pushMatrix() ;
    if (!groundLine) {
      translate(pos) ; 
    } else {
      float horizon = pos.y -(newSize.z *.5) ;  
      translate(pos.x, horizon, pos.z) ;
    }
    rotateX(radians(dir)) ;
    box(newSize.x,newSize.y,newSize.z) ;
    popMatrix() ;
  }
}