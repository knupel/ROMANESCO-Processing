class Letter extends SuperRomanesco {
  public Letter() {
    //from the index_objects.csv
    romanescoName = "Letter" ;
    IDobj = 17 ;
    IDgroup = 3 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Alpha 1.1";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
  }
  //GLOBAL
  RFont f;
  RShape grp;
  boolean newSetting ;
  int sizeRef ;
  String sentenceRef = ("") ; 
  String pathRef = ("") ;
 
  int whichLetter ;
  //spped
  float speed ;
  
  //SETUP
  void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
  }
  
  
  
  
  //DRAW
  void display() {
    if (parameter[IDobj] || pathFontObjTTF[IDobj] == null ) { 
      font[IDobj] = font[0] ;
      pathFontObjTTF[IDobj] = pathFontObjTTF[0] ;
    }
    //init and re-init Geomerative if few stuff change about this line like text, font and the size of the font
    float sizeFont = fontSizeObj[IDobj] ;
    
    //tracking chapter
    String textChapters [] = split(textRaw, "*") ;
    //we use in this case the tittle of the text
    String sentence = textChapters [0] ;

    
    //check if something change to update the RG.getText
    if (sizeRef == sizeFont && sentenceRef.equals(sentence) && pathRef.equals(pathFontObjTTF[IDobj])) newSetting = true  ; else newSetting = false ;
    sizeRef = (int)sizeFont ;
    sentenceRef = (sentence) ;
    pathRef = (pathFontObjTTF[IDobj]) ;

    if(!newSetting) { 
      grp = RG.getText(sentence, pathFontObjTTF[IDobj], (int)sizeFont, CENTER); 
      newSetting = true ;
    }
    
    
    /////////
    //ENGINE
    float rangeTargetLetter = height / grp.countChildren() ;
    int targetLetter = floor((mouse[IDobj].y +width/2) / rangeTargetLetter) ;
    if(targetLetter >= grp.countChildren() )targetLetter = targetLetter -1 ; 
    //speed
    if(motion[IDobj]) speed = map(speedObj[IDobj], 0,100, 0.001, 0.01 ) * tempo[IDobj]  ; else speed = 0.0 ;
    //to stop the move
    if (action[IDobj]  && spaceTouch ) speed = 0.0 ; 
    if(mousepressed[0]) speed = -speed ;
    
    //DISPLAY
    float thicknessLetter = thicknessObj[IDobj] ;
    //color
    color colorIn = fillObj[IDobj] ;
    // color colorOut = color ( map(valueObj[IDobj][5],0,100,0,360), valueObj[IDobj][6], valueObj[IDobj][7],valueObj[IDobj][8] ) ;
    //jitter
    int jitter = int(map(amplitudeObj[IDobj],0,1,1,15)) ;
    
    //final position
    translate(mouse[IDobj].x, mouse[IDobj].y) ;
    
    fill(colorIn); noStroke() ;
    //grp.children[whichLetter].draw();
    //grp.draw();

    oneLetter(speed, targetLetter, colorIn, thicknessLetter, jitter) ;
    //END YOUR WORK
    
    // MODE DISPLAY with the dropdown menu of controler
    /////////////////////
    if (mode[IDobj] == 0 || mode[IDobj] == 255 ) {
      //// just for information we use 0 to display the mode 1...same for the next mode +1...
    } else if (mode[IDobj] == 1 ) {
    } else if (mode[IDobj] == 2 ) {
    // and same for the next
    }

  }
  
  
  // ANNEXE
    void oneLetter(float s, int target, color cIn, float t, int jttr) {
    //create a PVector arraylist from geomerative analyze
    // float rangeWhichLetter = width / grp.countChildren() ;
    if (action[IDobj] && spaceTouch) whichLetter += (wheel[0] *.1) ;
    //security against the array out bounds
    if(whichLetter < 0 ) whichLetter = 0 ; else if (whichLetter >= grp.countChildren()) whichLetter = grp.countChildren() - 1 ;
    if(target < 0 ) target = 0 ; else if (target >= grp.countChildren()) target = grp.countChildren() - 1 ;
    //position
    if(motion[IDobj]) grp.children[whichLetter].rotate(s, grp.children[target].getCenter());
    
    displayLetter(whichLetter, cIn, t, jttr) ;
    displayLetter(target, cIn, t, jttr) ;
  }
  
  void displayLetter(int which, color c, float alpha, int ampJttr) {
    RPoint[] pnts = grp.children[which].getPoints() ; 
    PVector [] points = geomerativeFontPoints(pnts)  ;
    noFill() ; stroke(c) ; strokeWeight(alpha) ;
    for ( int i = 1; i < points.length; i++ ) {
      //points[i].add(jitterPVector(ampJttr)) ;
      if(points[i].z <= 0) points[i].z = points[i].z *right[IDobj] *20 ; else points[i].z = points[i].z *left[IDobj] *20 ;
      // if(points[i].z <= 0) points[i-1].z *= droite[IDobj] ; else points[i-1].z *= gauche[IDobj] ;
      line( points[i-1].x, points[i-1].y, points[i-1].z,   points[i].x, points[i].y, points[i].z );
    }
  }
  
  //ANNEXE VOID
  void annexe() {}
  //jitter for PVector points
  PVector jitterPVector(int range) {
    PVector jitting = new PVector(0,0,0) ;
    jitting.x = random(-range, range) ;
    jitting.y = random(-range, range) ;
    jitting.z = random(-range, range) ;
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
