//GLOBAL
RomanescoFortyOne romanescoFortyOne ;
//SETUP
void romanescoFortyOneSetup() {
  // YOU MUST CHANGE THE ID
  //Example : If it's RomanestoThirtySetup int ID = 30 ;
  int ID = 41 ; // 0 is Ref you must use a number in the order of apparition in the controleur, start from top left and follow the horizontal line
  
  int IDfamilly = 3 ; // 1 is single object // 2 is trame // 3 is typo    ....... // 0 is global don't use this one it's for specific stuff
  romanescoFortyOne = new RomanescoFortyOne (ID, IDfamilly) ;

  romanescoFortyOne.setting() ;
}

//DRAW
void romanescoFortyOneDraw(String [] dataControleur, String [] dataMinim) {
  romanescoFortyOne.getID() ;
  romanescoFortyOne.data(dataControleur, dataMinim) ;
  romanescoFortyOne.display() ;
}



//Return the ID familly to choice the data must be send to the class // 0 is global // 1 is Object // 2 is trame // 3 is typo
int getFamillyRomanescoFortyOne() { return romanescoFortyOne.getIDfamilly() ; }

////////////
//CLASS////
//GLOBAL
//////////////////////////////////////////
class RomanescoFortyOne extends SuperRomanesco 
{
  //FORBIDEN TO TOUCH
  int IDfamilly ;
  //END OF FORBIDEN ZONE
  
  ////////////////////////////////////////////////////////////////////////////////////////////////
  // YOUR VARIABLE OBJECT and CALL YOUR OWN CLASS HERE if it's not class that use an ArrayList //
  //////////////////////////////////////////////////////////////////////////////////////////////
  RFont f;
  RShape grp;
  boolean newSetting ;
  int sizeRef ;
  String sentenceRef = ("") ; 
  String pathRef = ("") ;
 
  int whichLetter ;
  //spped
  float speed ; 
  //CONSTRUCTOR
  RomanescoFortyOne(int ID, int IDfamilly) {
    super(ID) ;
    this.IDfamilly = IDfamilly ;
    ///////IMPORTANT/////////////////////////////////////////////////////////////////////////////
    //to call external class or library in class, now we must use "callingClass" like "this" ///
    ///////////////////////////////////////////////////////////////////////////////////////////
    /*
    name = new LibraryOrClass(callingClass);
    */
  }
  //END CONSTRUCTOR
  
  ////SETUP
  //the setting that's stuff that you'r put usually in the void setup() 
  void setting() {
    // If you use font
    font[IDobj] = font[0] ;
  }
  ///////////
  //END SETUP
  
  
  /////////
  //DISPLAY 
  void display() {
    // starting position
    if (startingPosition[IDobj]) startPosition(IDobj, width/2, height/2, 0) ;
    // if you use font in your object
    if (parameterButton[IDobj] == 1 ) { 
      font[IDobj] = font[0] ;
      pathFontObjTTF[IDobj] = pathFontObjTTF[0] ;
    }
    //init and re-init Geomerative if few stuff change about this line like text, font and the size of the font
    int sizeFont = int(map(valueObj[IDobj][28],0,100,height/50, height *2)) ;
    
     //data

    
    //tracking chapter
    String textChapters [] = split(textRaw, "*") ;
    //we use in this case the tittle of the text
    String sentence = textChapters [0] ;

    
    //check if something change to update the RG.getText
    if (sizeRef == sizeFont && sentenceRef.equals(sentence) && pathRef.equals(pathFontObjTTF[IDobj])) newSetting = true  ; else newSetting = false ;
    sizeRef = sizeFont ;
    sentenceRef = (sentence) ;
    pathRef = (pathFontObjTTF[IDobj]) ;
    
    if(!newSetting) { 
      grp = RG.getText(sentence, pathFontObjTTF[IDobj], sizeFont, CENTER); 
      newSetting = true ;
    }
    
    // HERE IT'S FOR YOU
    /////////
    //ENGINE
    float rangeTargetLetter = height / grp.countChildren() ;
    int targetLetter = floor((mouse[IDobj].y +width/2) / rangeTargetLetter) ;
    if(targetLetter >= grp.countChildren() )targetLetter = targetLetter -1 ; 
    //speed
    if(motion[IDobj]) speed = map(valueObj[IDobj][16], 0,100, 0.001, 0.01 ) * tempo[IDobj]  ; else speed = 0.0 ;
    //to stop the move
    if (actionButton[IDobj] == 1  && spaceTouch ) speed = 0.0 ; 
    if(mousepressed[0]) speed = -speed ; 
    

    
    //END ENGINE
    ////////////
    
    //DISPLAY OBJECT
    //DON'T TOUCH
    pushMatrix() ;
    //P3D Give the position and the orientation of your object in the 3 dimensionals space
    P3Dmanipulation(IDobj) ;
    //END OF DON'T TOUCH
    //CLASSIC DISPLAY
    // you can use a direct display or mode display to switch what you want display with a same engine object
    // DISPLAY GEOMERATIVE ANALYZE
    //thickness
    float thicknessLetter =    map(valueObj[IDobj][13],0,100, .1, height *.1) ;
    //color
    color colorIn = color ( map(valueObj[IDobj][1],0,100,0,360), valueObj[IDobj][2], valueObj[IDobj][3],valueObj[IDobj][4] ) ;
    // color colorOut = color ( map(valueObj[IDobj][5],0,100,0,360), valueObj[IDobj][6], valueObj[IDobj][7],valueObj[IDobj][8] ) ;
    //jitter
    int jitter = int(map(valueObj[IDobj][17],0,100,1,15)) ;
    
    //final position
    translate(mouse[IDobj].x, mouse[IDobj].y) ;
    
    fill(colorIn); noStroke() ;
    //grp.children[whichLetter].draw();
    //grp.draw();

    oneLetter(speed, targetLetter, colorIn, thicknessLetter, jitter) ;
    //END YOUR WORK
    
    // MODE DISPLAY with the dropdown menu of controler
    /////////////////////
    if (modeButton[IDobj] == 0 || modeButton[IDobj] == 255 ) {
      //// just for information we use 0 to display the mode 1...same for the next mode +1...
    } else if (modeButton[IDobj] == 1 ) {
    } else if (modeButton[IDobj] == 2 ) {
    // and same for the next
    }
    
    //DON'T TOUCH
    // translate(P3Dposition[IDobj].x, P3Dposition[IDobj].y, P3Dposition[IDobj].z) ;

    popMatrix() ;
    //END OF DON'T TOUCH
    //END of MODE DISPLAY
    /////////////////////

    
  }
  //END DRAW
  //////////
  
  void oneLetter(float s, int target, color cIn, float t, int jttr) {
    //create a PVector arraylist from geomerative analyze
    // float rangeWhichLetter = width / grp.countChildren() ;
    if (actionButton[IDobj] == 1 && spaceTouch) whichLetter += (wheel[0] *.1) ;
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
      points[i].add(jitterPVector(ampJttr)) ;
      if(points[i].z <= 0) points[i].z = points[i].z *droite[IDobj] *20 ; else points[i].z = points[i].z *gauche[IDobj] *20 ;
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
      //println("PVector " + pts[i] + " " +pts.length + " points" ) ;
    }
    return pts ;
  }
  //END EXAMPLE

  
  /////////////////////////////
  //FORDIDEN TO TOUCH THIS VOID
  /////////////////////////////
  //DATA VOID
  void data( String [] dataControler, String [] dataMinin) {
    super.data(dataControler, dataMinin) ;
  }
  ////////////
  //Return ID
  int getID() {
    return IDobj ;
  }
  int getIDfamilly() {
    return IDfamilly ;
  }
  ///////////////////////////
  //////////////////////////
}
