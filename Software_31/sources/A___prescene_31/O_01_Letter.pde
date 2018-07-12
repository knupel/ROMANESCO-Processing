/**
LETTER
2012-2018
v 1.3.2
*/
class Letter extends Romanesco {
  public Letter() {
    item_name = "Letter" ;
    ID_item = 1 ;
    ID_group = 1 ;
    item_author  = "Stan le Punk";
    item_version = "Version 1.3.2";
    item_pack = "Base 2012" ;

    item_costume = "Point/Line/Triangle";
    item_mode = "";
    // define slider
    hue_fill_is = true;
    sat_fill_is = true;
    bright_fill_is = true;
    alpha_fill_is = true;
    hue_stroke_is = true;
    sat_stroke_is = true;
    bright_stroke_is = true;
    alpha_stroke_is = true;
    thickness_is = true;
    // size_x_is = true;
    // size_y_is = true;
    // size_z_is = true;
    // font_size_is = true;
    // canvas_x_is = true;
    // canvas_y_is = true;
    // canvas_z_is = true;

    // reactivity_is = true;
    // speed_x_is = true;
    // speed_y_is = true;
    // speed_z_is = true;
    // spurt_x_is = true;
    // spurt_y_is = true;
    // spurt_z_is = true;
    // dir_x_is = true;
    // dir_y_is = true;
    // dir_z_is = true;
    // jit_x_is = true;
    // jit_y_is = true;
    // jit_z_is = true;
    // swing_x_is = true;
    // swing_y_is = true;
    // swing_z_is = true;

    // num_is = true;
    // variety_is = true;
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
  }
  //GLOBAL
  RFont f;
  RShape grp;
  boolean newSetting ;
  int sizeRef, sizeFont ;
  String sentenceRef = ("") ; 
  String pathRef = ("") ;
 
  int whichLetter ;
  int axeLetter ;
  int startDirection = -1 ;
  int numLetter ;

  
  //SETUP
  void setup() {
    setting_start_position(ID_item, width/2, height/2, 0) ;
  }
  
  
  
  
  //DRAW
  void draw() {
    load_txt(ID_item) ;
    // test the font is a ttf or not
    if(!path_font_item[ID_item].endsWith("ttf")) {
      path_font_item[ID_item] = path_font_default_ttf ;
    }
    //init and re-init Geomerative if few stuff change about this line like text, font and the size of the font
    sizeFont = int(map(font_size_item[ID_item],font_size_min_max.x, font_size_min_max.y, (float)height *.01, (float)height *.7));
    //text
    String sentence = whichSentence(text_import[ID_item], 0, 0) ;
    

    
    //check if something change to update the RG.getText
    if (sizeRef == sizeFont && sentenceRef.equals(sentence) && pathRef.equals(path_font_item[ID_item])) {
      newSetting = true  ; 
    } else {
      newSetting = false ;
    }

    sizeRef = sizeFont ;
    sentenceRef = (sentence) ;
    pathRef = (path_font_item[ID_item]) ;

    if(!newSetting || reset(ID_item)) {
      grp = RG.getText(sentence, path_font_item[ID_item], (int)sizeFont, CENTER); 
      newSetting = true ;
      axeLetter = int(random (grp.countChildren())) ;
    }

    if(reset(ID_item)) {
      int choiceDir = floor(random(2)) ;
      if(choiceDir == 0 ) {
        startDirection = -1 ; 
      } else {
        startDirection = 1 ;
      }
    }
    
    if(all_transient(ID_item) > 10 || key_n ) {
      axeLetter = int(random (grp.countChildren())) ;
    }
    
    

    
    
    /////////
    //ENGINE
    
    //speed
    float speed = 0 ;

    if(!motion[ID_item]) {
      speed = map(speed_x_item[ID_item], 0,1, 0.000, 0.3 ) *tempo[ID_item]  ; 
    } 
    //to stop the move
    //if (!action[ID_item]) speed = 0.0 ; 
    if(reverse[ID_item]) speed = -speed ;
    
    //num letter to display
    numLetter = (int)map(quantity_item[ID_item],0,1, 0,grp.countChildren() +1) ;
    
    //DISPLAY
    // thickness
    float thicknessLetter = map(thickness_item[ID_item], .1, height/3, 0.1, height /10) ; ;

    // color
    if(get_costume() != TRIANGLE_ROPE) {
      noFill() ; 
      stroke(fill_item[ID_item]) ; 
      strokeWeight(thicknessLetter) ;
    } else {
      fill(fill_item[ID_item]) ; 
      stroke(stroke_item[ID_item]) ; 
      strokeWeight(thicknessLetter) ;
    }
    //jitter
    float jitterX = map(jitter_x_item[ID_item],0,1, 0, (float)width *.1) ;
    float jitterY = map(jitter_y_item[ID_item],0,1, 0, (float)width *.1) ;
    float jitterZ = map(jitter_z_item[ID_item],0,1, 0, (float)width *.1) ;
    PVector jitter = new PVector (jitterX *jitterX, jitterY *jitterY, jitterZ *jitterZ) ;

    letters(speed, axeLetter, jitter) ;
    //END YOUR WORK
    

    
    // INFO
    item_info[ID_item] = ("Quantity of letter display " + numLetter + " - Speed " +int(speed*100)) ;

  }
  
  
  // ANNEXE
  float rotation ;
  
  void letters(float speed, int axeLetter, PVector jttr) {
    if (sound[ID_item]) {
      whichLetter = (int)all_transient(ID_item) ; 
    } else {
      whichLetter = 0 ;
    }
    
    //security against the array out bounds
    if(whichLetter < 0 ) {
      whichLetter = 0 ; 
    } else if (whichLetter >= grp.countChildren()) {
      whichLetter = grp.countChildren() -1  ;
    }

    wheelLetter(numLetter, speed, jttr) ;

    
    if(axeLetter < 0 ) {
      axeLetter = 0 ; 
    } else if (axeLetter >= grp.countChildren()) {
      axeLetter = grp.countChildren() - 1 ;
    }
    displayLetter(axeLetter, jttr) ;
  }





  
  int whichOneChangeDirection = 1 ;
  
  void wheelLetter(int num, float speed, PVector jttr) {
    // direction rotation for each one
    if(frameCount%160 == 0 || key_n) whichOneChangeDirection = round(random(1,num)) ;
    //position
    for ( int i = 0 ; i < num ; i++) {
      int targetLetter ;
      targetLetter = whichLetter +i ;
      if (targetLetter < grp.countChildren() ) {
        if(i%whichOneChangeDirection == 0 ) {
          speed  = speed *-1  ;
        }
        speed = speed *startDirection ;
        if(speed != 0) {
          grp.children[targetLetter].rotate(speed, grp.children[axeLetter].getCenter());
        }
        displayLetter(targetLetter, jttr) ;
      }
    }
  }
  
  void displayLetter(int which, PVector ampJttr) {
    RPoint[] pnts = grp.children[which].getPoints() ; 
    PVector [] points = geomerativeFontPoints(pnts)  ;

    for ( int i = 0; i < points.length; i++ ) {
      points[i].add(jitterPVector(ampJttr)) ;
      float factor = 40.0 ;
      points[i].z = points[i].z +(all_transient(ID_item) *factor) ; 
      if(get_costume() == POINT_ROPE ) point(points[i].x, points[i].y, points[i].z) ;
      if(get_costume() == LINE_ROPE ) if(i > 0 ) line( points[i-1].x, points[i-1].y, points[i-1].z,   points[i].x, points[i].y, points[i].z );
      if(get_costume() == TRIANGLE_ROPE ) if(i > 1 ) triangle(points[i-2].x, points[i-2].y, points[i-2].z,   points[i-1].x, points[i-1].y, points[i-1].z,   points[i].x, points[i].y, points[i].z );
      
    }
  }
  
  //ANNEXE VOID
  //jitter for PVector points
  PVector jitterPVector(PVector range) {
    float factor = 0.0 ;
    if(sound[ID_item]) factor = 2.0 ; else factor = 0.1  ;
    int rangeX = int(range.x *left[ID_item] *factor) ;
    int rangeY = int(range.y *right[ID_item] *factor) ;
    int rangeZ = int(range.z *mix[ID_item] *factor) ;
    PVector jitting = new PVector(0,0,0) ;
    jitting.x = random(-rangeX, rangeX) ;
    jitting.y = random(-rangeY, rangeY) ;
    jitting.z = random(-rangeZ, rangeZ) ;
    return jitting ;
  }
  
  //void work with geomerative
  PVector [] geomerativeFontPoints(RPoint[] p) {
    PVector [] pts = new PVector [p.length] ;
    for(int i = 0 ; i <pts.length ; i++) {
      pts[i] = new PVector(0,0,0) ;
      pts[i].x = p[i].x ; 
      pts[i].y = p[i].y ;  
    }
    return pts ;
  }
  
}