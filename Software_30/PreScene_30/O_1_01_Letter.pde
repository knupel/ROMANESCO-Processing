/**
LETTER || 2012 || 1.2.0
*/
class Letter extends Romanesco {
  public Letter() {
    //from the index_objects.csv
    RPE_name = "Letter" ;
    ID_item = 1 ;
    ID_group = 1 ;
    RPE_author  = "Stan le Punk";
    RPE_version = "Version 1.2";
    RPE_pack = "Base" ;
    romanescoRender = "P3D" ;
    RPE_mode = "Point/Line/Triangle" ;
    RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Stroke hue,Stroke sat,Stroke bright,Stroke alpha,Thickness,Size X,Canvas X,Canvas Y,Canvas Z,Quantity,Speed X" ;
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
  void setting() {
    startPosition(ID_item, width/2, height/2, 0) ;
  }
  
  
  
  
  //DRAW
  void display() {
    load_txt(ID_item) ;
    
    if (parameter[ID_item] || pathFontObjTTF[ID_item] == null ) { 
      font[ID_item] = font[0] ;
      pathFontObjTTF[ID_item] = pathFontObjTTF[0] ;
    }
    //init and re-init Geomerative if few stuff change about this line like text, font and the size of the font
    sizeFont = int(font_size_item[ID_item]) ;
    //text
    String sentence = whichSentence(text_import[ID_item], 0, 0) ;
    

    
    //check if something change to update the RG.getText
    if ( sizeRef == sizeFont && sentenceRef.equals(sentence) && pathRef.equals(pathFontObjTTF[ID_item])) newSetting = true  ; else newSetting = false ;
    sizeRef = sizeFont ;
    sentenceRef = (sentence) ;
    pathRef = (pathFontObjTTF[ID_item]) ;
    if(!newSetting || resetParameter(ID_item)) {
     
      grp = RG.getText(sentence, pathFontObjTTF[ID_item], (int)sizeFont, CENTER); 
      newSetting = true ;
      axeLetter = int(random (grp.countChildren())) ;
    }
    if(resetParameter(ID_item)) {
      int choiceDir = floor(random(2)) ;
      if(choiceDir == 0 ) startDirection = -1 ; else startDirection = 1 ;
    }
    
    if(allBeats(ID_item) > 10 || nTouch ) axeLetter = int(random (grp.countChildren())) ;
    
    

    
    
    /////////
    //ENGINE
    
    //speed
    float speed ;
    if(motion[ID_item]) speed = map(speed_x_item[ID_item], 0,1, 0.000, 0.3 ) *tempo[ID_item]  ; else speed = 0.0 ;
    //to stop the move
    if (!action[ID_item]) speed = 0.0 ; 
    if(clickLongLeft[ID_item] || spaceTouch) speed = -speed ;
    
    //num letter to display
    numLetter = (int)map(quantity_item[ID_item],0,1, 0,grp.countChildren() +1) ;
    
    //DISPLAY
    // thickness
    float thicknessLetter = map(thickness_item[ID_item], .1, height/3, 0.1, height /10) ; ;

    // color
    if(mode[ID_item] <= 1) {
      noFill() ; stroke(fill_item[ID_item]) ; strokeWeight(thicknessLetter) ;
    } else {
      fill(fill_item[ID_item]) ; stroke(stroke_item[ID_item]) ; strokeWeight(thicknessLetter) ;
    }
    //jitter
    float jitterX = map(canvas_x_item[ID_item],width/10, width, 0, width/40) ;
    float jitterY = map(canvas_y_item[ID_item],width/10, width, 0, width/40) ;
    float jitterZ = map(canvas_z_item[ID_item],width/10, width, 0, width/40) ;
    PVector jitter = new PVector (jitterX *jitterX, jitterY *jitterY, jitterZ *jitterZ) ;
    


    letters(speed, axeLetter, jitter) ;
    //END YOUR WORK
    

    
    // INFO
    objectInfo[ID_item] = ("Quantity of letter display " + numLetter + " - Speed " +int(speed*100)) ;

  }
  
  
  // ANNEXE
  float rotation ;
  
  void letters(float speed, int axeLetter, PVector jttr) {
    //create a PVector arraylist from geomerative analyze
    // float rangeWhichLetter = width / grp.countChildren() ;
    if (sound[ID_item]) whichLetter = (int)allBeats(ID_item) ; else whichLetter = 0 ;
    
    //security against the array out bounds
    if(whichLetter < 0 ) whichLetter = 0 ; else if (whichLetter >= grp.countChildren()) whichLetter = grp.countChildren() -1  ;
    wheelLetter(numLetter, speed, jttr) ;

    
    if(axeLetter < 0 ) axeLetter = 0 ; else if (axeLetter >= grp.countChildren()) axeLetter = grp.countChildren() - 1 ;
    displayLetter(axeLetter, jttr) ;
  }
  
  int whichOneChangeDirection = 1 ;
  
  void wheelLetter(int num, float speed, PVector jttr) {
    // direction rotation for each one
    if(frameCount%160 == 0 || nTouch) whichOneChangeDirection = round(random(1,num)) ;
    //position
    for ( int i = 0 ; i < num ; i++) {
      int targetLetter ;
      targetLetter = whichLetter +i ;
      if (targetLetter < grp.countChildren() ) {
        if(i%whichOneChangeDirection == 0 ) speed  = speed *-1  ;
        speed = speed *startDirection ;
        if(motion[ID_item]) grp.children[targetLetter].rotate(speed, grp.children[axeLetter].getCenter());
        displayLetter(targetLetter, jttr) ;
      }
    }
  }
  
  void displayLetter(int which, PVector ampJttr) {
    RPoint[] pnts = grp.children[which].getPoints() ; 
    PVector [] points = geomerativeFontPoints(pnts)  ;
    /*
    noFill() ; stroke(c) ; strokeWeight(thickness) ;
    // security against the black brightness bug opacity
    if (alpha(c) == 0 ) {
      noFill() ; 
      noStroke() ; 
    } else {     
      fill (c) ; 
    }
    */
    for ( int i = 0; i < points.length; i++ ) {
      points[i].add(jitterPVector(ampJttr)) ;
      float factor = 40.0 ;
      points[i].z = points[i].z +(allBeats(ID_item) *factor) ; 

      if(mode[ID_item] == 0 ) point(points[i].x, points[i].y, points[i].z) ;
      if(mode[ID_item] == 1 ) if(i > 0 ) line( points[i-1].x, points[i-1].y, points[i-1].z,   points[i].x, points[i].y, points[i].z );
      if(mode[ID_item] == 2 ) if(i > 1 ) triangle(points[i-2].x, points[i-2].y, points[i-2].z,   points[i-1].x, points[i-1].y, points[i-1].z,   points[i].x, points[i].y, points[i].z );
      
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
