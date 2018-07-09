/**
HORLOGE
2012-2018
v 2.0.6
*/

class Horloge extends Romanesco {
  public Horloge() {
    //from the index_objects.csv
    item_name = "Horloge" ;
    ID_item = 2 ;
    ID_group = 1 ;
    item_author  = "Stan Le Punk";
    item_version = "Version 2.0.6";
    item_pack = "Base 2012" ;
    item_mode = "Ellipse Clock 12/Ellipse Clock 24/Line Clock 12/Line Clock 24/minutes/secondes";// separate the name by a slash and write the next mode immadialtly after this one.
    item_costume = "";

    hue_fill_is = true;
    sat_fill_is = true;
    bright_fill_is = true;
    alpha_fill_is = true;
    hue_stroke_is = false;
    sat_stroke_is = false;
    bright_stroke_is = false;
    alpha_stroke_is = false;
    thickness_is = false;
    size_x_is = false;
    size_y_is = false;
    size_z_is = false;
    font_size_is = true;
    canvas_x_is = true;
    canvas_y_is = true;
    canvas_z_is = true;

    reactivity_is = false;
    speed_x_is = true;
    speed_y_is = true;
    speed_z_is = true;
    spurt_x_is = false;
    spurt_y_is = false;
    spurt_z_is = false;
    dir_x_is = false;
    dir_y_is = false;
    dir_z_is = false;
    jit_x_is = false;
    jit_y_is = false;
    jit_z_is  = false;
    swing_x_is = false;
    swing_y_is = false;
    swing_z_is = false;

    num_is = false;
    variety_is = false;
    life_is = false;
    flow_is = false;
    quality_is = false;
    area_is = true;
    angle_is = true;
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
  Vec3 pos_clock = Vec3() ; 
  int local_frameCount ;
  
  //SETUP
  void setup() {
    setting_start_position(ID_item, width/2, height/2, -width) ;
    pos_clock = Vec3(width/2,height/2,0) ;
  }
  
  
  
  
  //DRAW
  void draw() {
    textAlign(CENTER);
    // typo
    float size_font = (font_size_item[ID_item] +12) *all_transient(ID_item) ;
    if(size_font < 1) size_font = 1 ;
    textFont(font_item[ID_item], size_font);
    
    // couleur du texte
    float t = alpha(fill_item[ID_item]) * abs(mix[ID_item]) ;
    if (sound[ID_item]) t = alpha(fill_item[ID_item]) ;
    color c = color(hue(fill_item[ID_item]), saturation(fill_item[ID_item]), brightness(fill_item[ID_item]), t ) ;
    // security against the blavk bug opacity
    if (alpha(c) == 0 ) {
      noFill() ; 
      noStroke() ; 
    } else {     
      fill (c) ; 
    }
    
    //rotation / deg
    float angle = map(angle_item[ID_item], 0,360, 0, TAU) ;
    //amplitude
    float amp = map(area_item[ID_item], area_min_max.x,area_min_max.y, area_min_max.x *.4, area_min_max.y *.2) ;

    // pos clock
    if(motion[ID_item]) {
      local_frameCount += 1 ;
      int direction = 1 ;
      if(reverse[ID_item]) direction = -1 ;
      float speed_x = speed_x_item[ID_item] *.1 ;
      float speed_y = speed_y_item[ID_item] *.1 ;
      float speed_z = speed_z_item[ID_item] *.1 ;
      float pos_x = sin(local_frameCount *speed_x *direction) *map(canvas_x_item[ID_item],width/10,width *r.PHI,0,width *r.PHI) ;
      float pos_y = cos(local_frameCount *speed_y *direction) *map(canvas_y_item[ID_item],width/10,width *r.PHI,0,width *r.PHI) ;
      float pos_z = sin(local_frameCount *speed_z *direction) *map(canvas_z_item[ID_item],width/10,width *r.PHI,0,width *r.PHI) ;
      pos_clock = Vec3(pos_x,pos_y,pos_z) ;
    }

    
    //CHANGE MODE DISPLAY
    /////////////////////
    if (mode[ID_item] == 0 ) {
      horlogeCercle (pos_clock, angle, amp, 12 ) ; // on 12 hours model english clock
    } else if (mode[ID_item] == 1 ) {
      horlogeCercle (pos_clock, angle,  amp, 24 ) ; // on 24 hours model international clock
    } else if (mode[ID_item] == 2 ) {
      horlogeLigne  (pos_clock, angle, amp, 12 ) ; // on 12 hours model english clock
    } else if (mode[ID_item] == 3 ) {
      horlogeLigne  (pos_clock, angle, amp, 24 ) ; // on 24 hours model international clock
    } else if (mode[ID_item] == 4 ) {
      horlogeMinute(pos_clock, angle) ;
    } else if (mode[ID_item] == 5 ) {
      horlogeSeconde(pos_clock, angle) ;
    }

  }
  
  
  //ANNEXE
  void horlogeCercle(Vec3 posHorloge, float angle, float  amp, int timeMode) {
    //Angles pour sin() et cos() départ à 3h, enlever PI/2 pour un départ à midi
    float s = map (second(), 0, 60, 0,    TWO_PI ) - HALF_PI ;
    float m = map (minute(), 0, 60, 0,    TWO_PI ) - HALF_PI ;
    float h = map (hour() % 12, 0, 12, 0, TWO_PI ) - HALF_PI ;
    
    
    //seconde
    textAlign(CENTER, CENTER) ;
    translate(posHorloge.x, posHorloge.y, posHorloge.z) ;
    rotate(angle) ;
    text (nf(second(),2), cos(s)*amp*8 , sin(s)*amp*8 ) ;
    //minute
    text (nf(minute(),2), cos(m)*amp*6 , sin(m)*amp*6  ) ;
    //heure
    text(nf(hour()%timeMode ,2), cos(h)*amp*4 , sin(h)*amp*4  ) ;
    // text
    if ( timeMode == 12 ) if (hour() < 12 ) text("AM", 0, 0) ; else  text("PM", 0, 0 ) ; else text("TIME", 0, 0) ;
    
    textAlign(LEFT, TOP) ;
  }
  
  
  ////
  void horlogeLigne(Vec3 posHorloge, float angle, float amp, int timeMode) {
    //seconde
    textAlign(CENTER, CENTER) ;
    translate(posHorloge.x, posHorloge.y, posHorloge.z) ;
    rotate(angle) ;
    text( nf(hour()%timeMode,2)   + "." + 
          nf(minute(),2)   + "." + 
          nf(second(),2), 
          0, 0);
    textAlign(LEFT, TOP) ;
  }
  
  ////
  void horlogeMinute(Vec3 posHorloge, float angle) {
    textAlign(CENTER, CENTER) ;
    translate(posHorloge.x, posHorloge.y, posHorloge.z) ;
    rotate(angle) ;
    text(hour() *60 + minute() + " MINUTES", 0,0) ;
    textAlign(LEFT, TOP) ;
  }
  
  ////
  void horlogeSeconde(Vec3 posHorloge, float angle) {
    textAlign(CENTER, CENTER) ;
    translate(posHorloge.x, posHorloge.y, posHorloge.z) ;
    rotate(angle) ;
    text((hour() *3600) + (minute() *60) + second() + " SECONDES", 0,0) ;
    textAlign(LEFT, TOP) ;
  }
}
//end object one