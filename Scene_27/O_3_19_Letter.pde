class Letter extends SuperRomanesco {
  public Letter() {
    //from the index_objects.csv
    romanescoName = "Letter" ;
    IDobj = 20 ;
    IDgroup = 3 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Version 1.2";
    romanescoPack = "Base" ;
    romanescoRender = "P3D" ;
    romanescoMode = "Point/Line/Triangle" ;
    romanescoSlider = "Hue fill,Saturation fill,Brightness fill,Alpha fill,Hue stroke,Saturation stroke,Brightness stroke,Alpha stroke,Thickness,Width,Canvas X,Canvas Y,Canvas Z,Quantity,Speed" ;
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
    startPosition(IDobj, width/2, height/2, 0) ;
  }
  
  
  
  
  //DRAW
  void display() {
    loadText(IDobj) ;
    
    if (parameter[IDobj] || pathFontObjTTF[IDobj] == null ) { 
      font[IDobj] = font[0] ;
      pathFontObjTTF[IDobj] = pathFontObjTTF[0] ;
    }
    //init and re-init Geomerative if few stuff change about this line like text, font and the size of the font
    sizeFont = int(fontSizeObj[IDobj]) ;
    //text
    String sentence = whichSentence(textImport[IDobj], 0, 0) ;
    

    
    //check if something change to update the RG.getText
    if ( sizeRef == sizeFont && sentenceRef.equals(sentence) && pathRef.equals(pathFontObjTTF[IDobj])) newSetting = true  ; else newSetting = false ;
    sizeRef = sizeFont ;
    sentenceRef = (sentence) ;
    pathRef = (pathFontObjTTF[IDobj]) ;
    if(!newSetting || resetParameter(IDobj)) {
     
      grp = RG.getText(sentence, pathFontObjTTF[IDobj], (int)sizeFont, CENTER); 
      newSetting = true ;
      axeLetter = int(random (grp.countChildren())) ;
    }
    if(resetParameter(IDobj)) {
      int choiceDir = floor(random(2)) ;
      if(choiceDir == 0 ) startDirection = -1 ; else startDirection = 1 ;
    }
    
    if(allBeats(IDobj) > 10 || nTouch ) axeLetter = int(random (grp.countChildren())) ;
    
    

    
    
    /////////
    //ENGINE
    
    //speed
    float speed ;
    if(motion[IDobj]) speed = map(speedObj[IDobj], 0,1, 0.000, 0.3 ) *tempo[IDobj]  ; else speed = 0.0 ;
    //to stop the move
    if (!action[IDobj]) speed = 0.0 ; 
    if(clickLongLeft[IDobj] || spaceTouch) speed = -speed ;
    
    //num letter to display
    numLetter = (int)map(quantityObj[IDobj],0,1, 0,grp.countChildren() +1) ;
    
    //DISPLAY
    // thickness
    float thicknessLetter = map(thicknessObj[IDobj], .1, height/3, 0.1, height /10) ; ;

    // color
    if(mode[IDobj] <= 1) {
      noFill() ; stroke(fillObj[IDobj]) ; strokeWeight(thicknessLetter) ;
    } else {
      fill(fillObj[IDobj]) ; stroke(strokeObj[IDobj]) ; strokeWeight(thicknessLetter) ;
    }
    //jitter
    float jitterX = map(canvasXObj[IDobj],width/10, width, 0, width/40) ;
    float jitterY = map(canvasYObj[IDobj],width/10, width, 0, width/40) ;
    float jitterZ = map(canvasZObj[IDobj],width/10, width, 0, width/40) ;
    PVector jitter = new PVector (jitterX *jitterX, jitterY *jitterY, jitterZ *jitterZ) ;
    


    letters(speed, axeLetter, jitter) ;
    //END YOUR WORK
    

    
    // INFO
    objectInfo[IDobj] = ("Quantity of letter display " + numLetter + " - Speed " +int(speed*100)) ;

  }
  
  
  // ANNEXE
  float rotation ;
  
  void letters(float speed, int axeLetter, PVector jttr) {
    //create a PVector arraylist from geomerative analyze
    // float rangeWhichLetter = width / grp.countChildren() ;
    if (sound[IDobj]) whichLetter = (int)allBeats(IDobj) ; else whichLetter = 0 ;
    
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
        if(motion[IDobj]) grp.children[targetLetter].rotate(speed, grp.children[axeLetter].getCenter());
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
      points[i].z = points[i].z +(allBeats(IDobj) *factor) ; 

      if(mode[IDobj] == 0 ) point(points[i].x, points[i].y, points[i].z) ;
      if(mode[IDobj] == 1 ) if(i > 0 ) line( points[i-1].x, points[i-1].y, points[i-1].z,   points[i].x, points[i].y, points[i].z );
      if(mode[IDobj] == 2 ) if(i > 1 ) triangle(points[i-2].x, points[i-2].y, points[i-2].z,   points[i-1].x, points[i-1].y, points[i-1].z,   points[i].x, points[i].y, points[i].z );
      
    }
  }
  
  //ANNEXE VOID
  //jitter for PVector points
  PVector jitterPVector(PVector range) {
    float factor = 0.0 ;
    if(sound[IDobj]) factor = 2.0 ; else factor = 0.1  ;
    int rangeX = int(range.x *left[IDobj] *factor) ;
    int rangeY = int(range.y *right[IDobj] *factor) ;
    int rangeZ = int(range.z *mix[IDobj] *factor) ;
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
