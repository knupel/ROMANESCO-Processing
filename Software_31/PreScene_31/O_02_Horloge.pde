/**
HORLOGE || 2012 || 2.0.4
*/

class Horloge extends Romanesco {
  public Horloge() {
    //from the index_objects.csv
    RPE_name = "Horloge" ;
    ID_item = 2 ;
    ID_group = 1 ;
    RPE_author  = "Stan Le Punk";
    RPE_version = "Version 2.0.4";
    RPE_pack = "Base" ;
    romanescoRender = "classic" ;
    RPE_mode = "Ellipse Clock 12/Ellipse Clock 24/Line Clock 12/Line Clock 24/minutes/secondes" ;// separate the name by a slash and write the next mode immadialtly after this one.
    RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Angle,Speed X,Speed Y,Speed Z,Font size,Area,Canvas X,Canvas Y,Canvas Z" ;
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
    float sizeFont = font_size_item[ID_item] +12 ;
    textFont(font_item[ID_item], sizeFont *allBeats(ID_item));
    
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