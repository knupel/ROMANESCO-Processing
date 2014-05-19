class Letter extends SuperRomanesco {
  public Letter() {
    //from the index_objects.csv
    romanescoName = "Letter" ;
    IDobj = 18 ;
    IDgroup = 3 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Alpha 1.1";
    romanescoPack = "Base" ;
    romanescoRender = "P3D" ;
     romanescoMode = "1 Line/2 Point" ;
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
    
    if(allBeats(IDobj) > 10 || nTouch ) axeLetter = int(random (grp.countChildren())) ;
    
    

    
    
    /////////
    //ENGINE
    //float rangeTargetLetter = height / grp.countChildren() ;
    /*
    float rangeTargetLetter = height  ;
    targetLetter = floor((mouse[IDobj].y +width/2) / rangeTargetLetter) ;
    if(targetLetter >= grp.countChildren() )targetLetter = targetLetter -1 ; 
    */
    
    //speed
    float speed ;
    if(motion[IDobj]) speed = map(speedObj[IDobj], 0,100, 0.001, 0.5 ) *tempo[IDobj]  ; else speed = 0.0 ;
    //to stop the move
    if (!action[IDobj]) speed = 0.0 ; 
    if(mousepressed[0]) speed = -speed ;
    
    //DISPLAY
    float thicknessLetter = map(thicknessObj[IDobj], .1, height/3, 0.1, height /10) ; ;
    //color
    color colorIn = fillObj[IDobj] ;
    //jitter
    float jitterX = map(canvasXObj[IDobj],width/10, width, 0, width/5) ;
    float jitterY = map(canvasYObj[IDobj],width/10, width, 0, width/5) ;
    float jitterZ = map(canvasZObj[IDobj],width/10, width, 0, width/5) ;
    PVector jitter = new PVector (jitterX, jitterY, jitterZ) ;
    
    //final position
    // Problem with spaceTouch move
    // translate(mouse[IDobj].x , mouse[IDobj].y , mouse[IDobj].z) ;
    
    fill(colorIn); noStroke() ;

    letters(speed, axeLetter, colorIn, thicknessLetter, jitter) ;
    //END YOUR WORK

  }
  
  
  // ANNEXE
    float rotation ;
  
    void letters(float speed, int axeLetter, color c, float thickness, PVector jttr) {
    //create a PVector arraylist from geomerative analyze
    // float rangeWhichLetter = width / grp.countChildren() ;
    if (sound[IDobj]) whichLetter = (int)allBeats(IDobj) ; else whichLetter = grp.countChildren() / 2 ;
    
    //security against the array out bounds
    if(whichLetter < 0 ) whichLetter = 0 ; else if (whichLetter >= grp.countChildren()) whichLetter = grp.countChildren() - 1 ;
    int num = (int)map(quantityObj[IDobj],1,100, 1,grp.countChildren()) ;
    wheelLetter(num, speed, c, thickness, jttr) ;

    
    if(axeLetter < 0 ) axeLetter = 0 ; else if (axeLetter >= grp.countChildren()) axeLetter = grp.countChildren() - 1 ;
    displayLetter(axeLetter, c, thickness, jttr) ;
  }
  
  int whichOneChangeDirection = 1 ;
  
  void wheelLetter(int num, float speed, color c, float thickness, PVector jttr) {
    // direction rotation for each one
    if(frameCount%160 == 0 || nTouch) whichOneChangeDirection = round(random(1,num)) ;
    //position
    for ( int i = 0 ; i < num ; i++) {
      int targetLetter ;
      targetLetter = whichLetter +i ;
      if (targetLetter < grp.countChildren() ) {
        if(i%whichOneChangeDirection == 0 ) speed = speed *-1 ;
        if(motion[IDobj]) grp.children[targetLetter].rotate(speed, grp.children[axeLetter].getCenter());
        displayLetter(targetLetter, c, thickness, jttr) ;
      }
    }
  }
  
  void displayLetter(int which, color c, float thickness, PVector ampJttr) {
    RPoint[] pnts = grp.children[which].getPoints() ; 
    PVector [] points = geomerativeFontPoints(pnts)  ;
    noFill() ; stroke(c) ; strokeWeight(thickness) ;
    for ( int i = 0; i < points.length; i++ ) {
      points[i].add(jitterPVector(ampJttr)) ;
      float factor = 40.0 ;
      points[i].z = points[i].z +(allBeats(IDobj) *factor) ; 

      if(mode[IDobj] == 0 ) if(i > 0 ) line( points[i-1].x, points[i-1].y, points[i-1].z,   points[i].x, points[i].y, points[i].z );
      if(mode[IDobj] == 1 ) point(points[i].x, points[i].y, points[i].z) ;
    }
  }
  
  //ANNEXE VOID
  void annexe() {}
  //jitter for PVector points
  PVector jitterPVector(PVector range) {
    float factor = 0.0 ;
    if(sound[IDobj]) factor = 2.0 ; else factor = 0.0  ;
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
