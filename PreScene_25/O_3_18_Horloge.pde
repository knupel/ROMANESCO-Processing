//////////////////
//OBJECT ROMANESCO
class Horloge extends SuperRomanesco {
  public Horloge() {
    //from the index_objects.csv
    romanescoName = "A CERCLE" ;
    IDobj = 18 ;
    IDgroup = 3 ;
    romanescoAuthor  = "Stan Le Punk";
    romanescoVersion = "Alpha 2.0";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
    romanescoMode = "1 Ellipse Clock 12/2 Ellipse Clock 24/3 Line Clock 12/4 Line Clock 24/5 minutes/6 secondes" ;// separate the name by a slash and write the next mode immadialtly after this one.
  }
  //GLOBAL
  
  
  //SETUP
  void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
  }
  
  
  
  
  //DRAW
  void display() {
    textAlign(CENTER);
    // typo
    float corps ;
    //size letter / corps
    corps = map(sizeYObj[IDobj], 0, height, 6, 2 *height) ;
    textFont(font[IDobj], corps + (mix[IDobj] *30));
    
    // couleur du texte
    float t = alpha(fillObj[IDobj]) * abs(mix[IDobj]) ;
    if (sound[IDobj]) { t = alpha(fillObj[IDobj]) ; } 
    color c = color(hue(fillObj[IDobj]), saturation(fillObj[IDobj]), brightness(fillObj[IDobj]), t ) ;
    //rotation / deg
    float angle = map(directionObj[IDobj], 0,360, 0, TAU) ;
    //amplitude
    float amp = map(amplitudeObj[IDobj],1,height, 1, height  / 4) ;
    
    //CHANGE MODE DISPLAY
    /////////////////////
    if (mode[IDobj] == 0 || mode[IDobj] == 255 ) {
      horlogeCercle (mouse[IDobj], angle, amp, c, 12 ) ; // on 12 hours model english clock
    } else if (mode[IDobj] == 1 ) {
      horlogeCercle (mouse[IDobj], angle,  amp, c, 24 ) ; // on 24 hours model international clock
    } else if (mode[IDobj] == 2 ) {
      horlogeLigne  (mouse[IDobj], angle, amp, c, 12 ) ; // on 12 hours model english clock
    } else if (mode[IDobj] == 3 ) {
      horlogeLigne  (mouse[IDobj], angle, amp, c, 24 ) ; // on 24 hours model international clock
    } else if (mode[IDobj] == 4 ) {
      horlogeMinute(mouse[IDobj], angle, c) ;
    } else if (mode[IDobj] == 5 ) {
      horlogeSeconde(mouse[IDobj], angle, c) ;
    }

  }
  
  
  //ANNEXE
  void horlogeCercle(PVector posHorloge, float angle, float  amp, color colorHorloge, int timeMode) {
    //Angles pour sin() et cos() départ à 3h, enlever PI/2 pour un départ à midi
    float s = map (second(), 0, 60, 0,    TWO_PI ) - HALF_PI ;
    float m = map (minute(), 0, 60, 0,    TWO_PI ) - HALF_PI ;
    float h = map (hour() % 12, 0, 12, 0, TWO_PI ) - HALF_PI ;
    
    fill (colorHorloge) ;
    //seconde
    textAlign(CENTER, CENTER) ;
    translate(posHorloge.x, posHorloge.y) ;
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
  void horlogeLigne(PVector posHorloge, float angle, float amp, color colorHorloge, int timeMode) {
    fill (colorHorloge) ;
    //seconde
    textAlign(CENTER, CENTER) ;
    translate(posHorloge.x, posHorloge.y) ;
    rotate(angle) ;
    text( nf(hour()%timeMode,2)   + "." + 
          nf(minute(),2)   + "." + 
          nf(second(),2), 
          0, 0);
    textAlign(LEFT, TOP) ;
  }
  
  ////
  void horlogeMinute(PVector posHorloge, float angle, color colorHorloge ) {
    fill (colorHorloge) ;
    textAlign(CENTER, CENTER) ;
    translate(posHorloge.x, posHorloge.y) ;
    rotate(angle) ;
    text(hour() *60 + minute() + " MINUTES", 0,0) ;
    textAlign(LEFT, TOP) ;
  }
  
  ////
  void horlogeSeconde(PVector posHorloge, float angle, color colorHorloge ) {
    
    fill (colorHorloge) ;
    textAlign(CENTER, CENTER) ;
    translate(posHorloge.x, posHorloge.y) ;
    rotate(angle) ;
    text((hour() *3600) + (minute() *60) + second() + " SECONDES", 0,0) ;
    textAlign(LEFT, TOP) ;
  }
}
//end object one
