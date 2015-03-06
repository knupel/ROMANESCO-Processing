//////////////////
//OBJECT ROMANESCO
class Horloge extends SuperRomanesco {
  public Horloge() {
    //from the index_objects.csv
    romanescoName = "Horloge" ;
    IDobj = 2 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Stan Le Punk";
    romanescoVersion = "Version 2.0";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
    romanescoMode = "Ellipse Clock 12/Ellipse Clock 24/Line Clock 12/Line Clock 24/minutes/secondes" ;// separate the name by a slash and write the next mode immadialtly after this one.
    romanescoSlider = "Hue fill,Saturation fill,Brightness fill,Alpha fill,Width,Direction,Amplitude" ;
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
    float sizeFont = fontSizeObj[IDobj] +12 ;
    textFont(font[IDobj], sizeFont *allBeats(IDobj));
    
    // couleur du texte
    float t = alpha(fillObj[IDobj]) * abs(mix[IDobj]) ;
    if (sound[IDobj]) t = alpha(fillObj[IDobj]) ;
    color c = color(hue(fillObj[IDobj]), saturation(fillObj[IDobj]), brightness(fillObj[IDobj]), t ) ;
    // security against the blavk bug opacity
    if (alpha(c) == 0 ) {
      noFill() ; 
      noStroke() ; 
    } else {     
      fill (c) ; 
    }
    
    //rotation / deg
    float angle = map(directionObj[IDobj], 0,360, 0, TAU) ;
    //amplitude
    float amp = map(amplitudeObj[IDobj],0,1, 1, height  / 4) ;
    
    //CHANGE MODE DISPLAY
    /////////////////////
    if (mode[IDobj] == 0 ) {
      horlogeCercle (mouse[IDobj], angle, amp, 12 ) ; // on 12 hours model english clock
    } else if (mode[IDobj] == 1 ) {
      horlogeCercle (mouse[IDobj], angle,  amp, 24 ) ; // on 24 hours model international clock
    } else if (mode[IDobj] == 2 ) {
      horlogeLigne  (mouse[IDobj], angle, amp, 12 ) ; // on 12 hours model english clock
    } else if (mode[IDobj] == 3 ) {
      horlogeLigne  (mouse[IDobj], angle, amp, 24 ) ; // on 24 hours model international clock
    } else if (mode[IDobj] == 4 ) {
      horlogeMinute(mouse[IDobj], angle) ;
    } else if (mode[IDobj] == 5 ) {
      horlogeSeconde(mouse[IDobj], angle) ;
    }

  }
  
  
  //ANNEXE
  void horlogeCercle(PVector posHorloge, float angle, float  amp, int timeMode) {
    //Angles pour sin() et cos() départ à 3h, enlever PI/2 pour un départ à midi
    float s = map (second(), 0, 60, 0,    TWO_PI ) - HALF_PI ;
    float m = map (minute(), 0, 60, 0,    TWO_PI ) - HALF_PI ;
    float h = map (hour() % 12, 0, 12, 0, TWO_PI ) - HALF_PI ;
    
    
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
  void horlogeLigne(PVector posHorloge, float angle, float amp, int timeMode) {
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
  void horlogeMinute(PVector posHorloge, float angle) {
    textAlign(CENTER, CENTER) ;
    translate(posHorloge.x, posHorloge.y) ;
    rotate(angle) ;
    text(hour() *60 + minute() + " MINUTES", 0,0) ;
    textAlign(LEFT, TOP) ;
  }
  
  ////
  void horlogeSeconde(PVector posHorloge, float angle) {
    textAlign(CENTER, CENTER) ;
    translate(posHorloge.x, posHorloge.y) ;
    rotate(angle) ;
    text((hour() *3600) + (minute() *60) + second() + " SECONDES", 0,0) ;
    textAlign(LEFT, TOP) ;
  }
}
//end object one
