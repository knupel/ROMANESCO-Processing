/**
SLIDER 
v 1.7.0
2015 - 2018
SLIDER may 2016 1.5.9 
SLIDER june 2016 1.6.0
SLIDER january 2017 1.6.1
SLIDER march 2018 1.7.0
*/
boolean molette_already_selected ;


/**
CLASS SLIDER

*/
public class Slider {
  protected Vec2 pos, size;
  protected Vec2 posMol, sizeMol;
  protected PVector posText;
  protected Vec2 posMin, posMax ;
  protected Vec2 newPosMol ;
  protected color sliderColor = color(60) ;
  protected color molIn = color(255) ;
  protected color molOut = color(125) ;
  protected color colorText = color(0) ; ;
  protected boolean lockedMol, insideMol ;
  protected PFont p ;
  protected float minNorm = 0 ;
  protected float maxNorm = 1 ;
  // advance slider
  protected int newmidi_value_romanesco ;
  protected int IDmidi = -2 ;
  protected String moletteShapeType = ("") ;
  
  // CLASSIC CONSTRUCTOR
  //CONSTRUCTOR with title
  public Slider(Vec2 pos, Vec2 posMol, Vec2 size, PVector posText, PFont p) {
    this.pos = pos.copy() ;
    this.posMol = Vec2(pos.x + (posMol.x*size.x), pos.y +(posMol.y*size.y)) ;
    this.size = size.copy() ;
    this.posText = posText ;
    this.p = p ;

    //which molette for slider horizontal or vertical
    if (size.x >= size.y) sizeMol = Vec2(size.y, size.y) ; else sizeMol = Vec2(size.x, size.x ) ;
    // calculate minimum and maxium position of the molette
    if(size.x > size.y) {
      posMin = Vec2(pos.x, pos.y) ;
      posMax = Vec2(pos.x +size.x +size.y, pos.y) ;
    } else {
      posMin = Vec2(pos.x, pos.y) ;
      float correction = sizeMol.y +sizeMol.x ;
      posMax = Vec2(pos.x, pos.y +size.x +size.y -correction) ;
    }
  }
  
  //CONSTRUCTOR minimum
  public Slider(Vec2 pos, Vec2 posMol, Vec2 size) {
    this.pos = pos.copy() ;
    this.posMol = Vec2(pos.x + (posMol.x*size.x), pos.y +(posMol.y*size.y)) ;
    this.size = size.copy() ;

    //which molette for slider horizontal or vertical
    if (size.x >= size.y) sizeMol = Vec2(size.y, size.y) ; else sizeMol = Vec2(size.x, size.x) ;
    // calculate minimum and maxium position of the molette
    if(size.x > size.y) {
      posMin = Vec2(pos.x, pos.y) ;
      posMax = Vec2(pos.x +size.x +size.y,  pos.y) ;
    } else {
      posMin = Vec2(pos.x, pos.y) ;
      float correction = sizeMol.y  + sizeMol.x ;
      posMax = Vec2(pos.x,  pos.y  +size.x +size.y -correction) ;
    }
  }
  
  //slider with external molette
  public Slider(Vec2 pos, Vec2 posMol, Vec2 size, Vec2 sizeMol, String moletteShapeType) {
    this.pos = pos.copy();
    this.posMol = Vec2(pos.x +(posMol.x *size.x), pos.y +(posMol.y *size.y)) ;
    this.sizeMol = sizeMol.copy() ;
    this.size = size.copy() ;
    this.moletteShapeType = moletteShapeType ;
    // calculate minimum and maxium position of the molette
    if(size.x > size.y) {
      posMin = Vec2(pos.x, pos.y) ;
      posMax = Vec2(pos.x +size.x +size.y,  pos.y) ;
    } else {
      posMin = Vec2(pos.x, pos.y) ;
      float correction = sizeMol.y  + sizeMol.x ;
      posMax = Vec2(pos.x,  pos.y  +size.x +size.y -correction) ;
    }
  }

  

  
  
  
  
  
  // METHODES
  //SETTING
  
  void setting() {
    /* May be it's possible to remove this method to includ that in the constructor ?
    but now we need that to init the molette */
    this.newPosMol = posMol.copy() ;
  }
  
  

  void setMidi(int IDmidi) {
    this.IDmidi = IDmidi ;
  }
  
  
  // setting the position from a specific value
  void set_molette(float normPos) {
    // security to constrain the value in normalizing range.
    if(normPos > 1.) normPos = 1. ;
    if(normPos < 0) normPos = 0 ;
    // check if it's horizontal or vertical slider
    if(size.x >= size.y) {
      newPosMol.x = size.x *normPos +posMin.x -(sizeMol.y *normPos) ; 
    } else {
      newPosMol.y = size.y *normPos +posMin.y -(sizeMol.x *normPos) ;
    }
  }

  
  
  
  // UPDATE
  void select_molette() {
    lockedMol = select(lockedMol(), lockedMol) ;
  }

  // update molette position
    void update_pos_molette(Vec2 pos, Vec2 pos_mol) {
    this.posMol.set(pos.x +(pos_mol.x *size.x), pos.y +(pos_mol.y *size.y)) ;
    // this.newPosMol.set(posMol.x, posMol.y) ;
  }

  void update_pos_molette() {
    // move the molette is this one is locked
    // security
    if(size.x >= size.y) {
      // for the horizontal slider
      if (newPosMol.x < posMin.x ) {
        newPosMol.x = posMin.x ;
      }
      if (newPosMol.x > posMax.x ) {
        newPosMol.x = posMax.x ;
      }
    } else {
      // for the vertical slider
      if (newPosMol.y < posMin.y ) {
        newPosMol.y = posMin.y ;
      }
      if (newPosMol.y > posMax.y ) {
        newPosMol.y = posMax.y ;
      }
    }

    if (lockedMol) {
      if (size.x >= size.y) { 
        newPosMol.x = constrain(mouseX -(sizeMol.x *.5), posMin.x, posMax.x) ; 
      } else { 
        newPosMol.y = constrain(mouseY -(sizeMol.y *.5), posMin.y, posMax.y) ;
      }
    }
  }

  // privat method
  boolean select(boolean locked_method, boolean result) {
    // boolean result = original ;
    if(!molette_already_selected) {
      if (locked_method) {
        molette_already_selected = true ;
        result = true ;
      }
    } else {
      if (locked_method && shift_key) {
        result = true ;
      }
    }

    if (!mousePressed) { 
      result = false ; 
      molette_already_selected = false ;
    }
    return result ;
  }



  

  
  
  
  
  
  /**
  DISPLAY SLIDER
  v 1.0.1
  */
  //Slider display classic
  void sliderDisplay() {
    fill(sliderColor) ;
    rect(pos.x, pos.y, size.x, size.y ) ;
  }
  
  // slider display advanced
  void sliderDisplay(color sliderColor, color sliderStrokeColor, float thickness) {
    this.sliderColor = sliderColor ;
    fill(sliderColor) ;
    stroke(sliderStrokeColor) ;
    strokeWeight(thickness) ;
    rect(pos.x, pos.y, size.x, size.y ) ;
    noStroke() ;
  }
  //Slider update with title
  void sliderDisplayText(String s, boolean t) {
    //SLIDER
    fill(sliderColor) ;
    rect(pos.x, pos.y, size.x, size.y ) ;
    if (t) {
      fill(colorText) ;
      textFont (p) ;
      textSize (posText.z) ;
      text(s, posText.x, posText.y ) ;
    }
  }
  
  
  // DISPLAY MOLETTE
  //display molette
  void displayMolette() {
    if(lockedMol || insideMol) { 
      fill(molIn); 
    } else { 
      fill(molOut ) ;
    }
    shapeMolette() ;
    noStroke() ;
  }
  
  // display molette advanced
  void displayMolette(color molIn, color molOut, color strokeIn, color strokeOut, float thickness) {
    this.molIn = molIn ;
    this.molOut = molOut ;

    strokeWeight(thickness) ;
    if(lockedMol || insideMol) {
      fill(molIn);
      stroke(strokeIn) ;
    } else {
      fill(molOut ) ;
      stroke(strokeOut) ;
    }
    shapeMolette() ;
    noStroke() ;
  }
  
  
 


  

  
  
  
  
  
  

  //ANNEXE VOID
  // display the molette
  void shapeMolette() {
    if(moletteShapeType.equals("ELLIPSE") ) {
      ellipse(sizeMol.x *.5 +newPosMol.x, size.y *.5 +newPosMol.y, sizeMol.x , sizeMol.y) ;
    } else if(moletteShapeType.equals("RECT")) {
      rect(newPosMol.x, newPosMol.y, sizeMol.x , sizeMol.y ) ;
    } else rect(newPosMol.x, newPosMol.y, sizeMol.x , sizeMol.y ) ;
  }
  
  
  /* return the position of the molette, the minium and the maximum between 0 and 1
  @ return float
  */
  float getValue() {
    float value ;
    if (size.x >= size.y) {
      value = map (newPosMol.x, posMin.x, posMax.x, minNorm, maxNorm) ; 
    } else {
      value = map (newPosMol.y, posMin.y, posMax.y, minNorm, maxNorm) ;
    }
    return value ;
  }
  
  float getValueMin() {
    return minNorm ;
  }
  float getValueMax() {
    return maxNorm ;
  }
  
  
  // check if the mouse is inside the molette or not
  //rect
  boolean insideSlider() { 
    if(inside(pos, size,Vec2(mouseX,mouseY),RECT)) {
      insideMol = true ; 
    } else {
      insideMol = false ;
    }
    return insideMol ;
  }
  
  
  boolean insideMol_Rect() {
    if(inside(newPosMol,sizeMol,Vec2(mouseX,mouseY),RECT)) {
      insideMol = true ; 
    } else {
      insideMol = false ;
    }
    return insideMol ;
  }
  

  //ellipse
  boolean insideMol_Ellipse() {
    float radius = sizeMol.x ;
    int posX = int(radius *.5 +newPosMol.x ) ; 
    int posY = int(size.y *.5 +newPosMol.y) ;
    if(pow((posX -mouseX),2) + pow((posY -mouseY),2) < pow(radius,sqrt(3))) {
      insideMol = true ; 
    } else {
      insideMol = false ;
    }
    return insideMol ;
  }
  
  
  
  //locked
  boolean lockedMol() {
    if (insideMol && mousePressed) {
      return true ; 
    } else {
      return false ;
    }
  }
  
  // END CLASSIC METHOD
  /////////////////////
  
 
 
 
 

 ///////////////////
 // ADVANCED METHOD
 // update position from midi controller
  void updateMidi(int val) {
    //update the Midi position only if the Midi Button move
    if (newmidi_value_romanesco != val) { 
      newmidi_value_romanesco = val ; 
      newPosMol.x = map(val, 1, 127, posMin.x, posMax.x) ;
    }
  }

  
  //////
  //VOID
  void load(int load) {
    newPosMol.x = load ;
  }
  
  // give the ID from the controller Midi
  void selectIDmidi(int num) { 
    IDmidi = num ; 
  }
  
  //give the IDmidi 
  int IDmidi() { 
    return IDmidi ; 
  }
}
/**
END SLIDER
*/




















/**
SLIDER ADJUSTABLE : extends class of class Slider

*/
public class SliderAdjustable extends Slider {
  // size
  protected Vec2 sizeMinMax;
  protected Vec2 sizeMolMinMax;
  int widthMinMax = 10 ;
  // pos  
  protected Vec2 posMinMax;
  protected Vec2 newPosMin;
  protected Vec2 newPosMax;
  // color
  protected color adjIn = color(255) ;
  protected color adjOut = color(125) ; ;

  boolean lockedMin, lockedMax;
  
  // CLASSIC CONSTRUCTOR
  SliderAdjustable(Vec2 pos, Vec2 posMol, Vec2 size, PVector posText, PFont p) {
    super(pos,posMol,size,posText,p);
    this.newPosMax = Vec2();
    this.posMinMax = pos.copy();
    this.newPosMin = posMinMax.copy();
    this.sizeMinMax = size.copy();
    this.sizeMolMinMax = Vec2(widthMinMax, size.y);
  }
  
  SliderAdjustable(Vec2 pos, Vec2 posMol, Vec2 size) {
    super(pos, posMol, size);
    this.newPosMax = Vec2();
    this.posMinMax = pos.copy();
    this.newPosMin = posMinMax.copy();
    this.sizeMinMax = size.copy();
    this.sizeMolMinMax = Vec2(widthMinMax, size.y);
  }
  
  //slider with external molette
  SliderAdjustable(Vec2 pos, Vec2 posMol, Vec2 size, Vec2 sizeMol, String moletteShapeType) {
    super(pos, posMol, size, sizeMol, moletteShapeType);
    this.newPosMax = Vec2();
    this.newPosMin = Vec2();
    this.posMinMax = pos.copy();
    this.sizeMinMax = size.copy();
    this.sizeMolMinMax = Vec2(widthMinMax, size.y);
  }
  // END CLASSIC CONSTRUCTOR
  /////////////////////////

  
  
  
  /////////
  // METHOD
  
  void update_min_max() {
    float newNormSize = maxNorm -minNorm ;
    
    if (size.x >= size.y) sizeMinMax = Vec2(size.x *newNormSize, size.y) ; else sizeMinMax = Vec2(size.y *newNormSize, size.x) ;
    
    posMin = Vec2(pos.x +(size.x *minNorm), pos.y) ;
    // in this case the detection is translate on to and left of the size of molette
    posMax = Vec2(pos.x -sizeMol.x +(size.x *maxNorm), pos.y) ;
  }
  
  // update Min and Max value
  // update min value

  void select_min() {
    lockedMin = select(lockedMin(), lockedMin) ;
  }
  void update_min() {
    float range = sizeMol.x *1.5 ;
    //
    /*
    if (lockedMin()) lockedMin = true ;
    if (!mousePressed) lockedMin = false ; 
    */
    
    if (lockedMin) {  
      if (size.x >= size.y) {
        // security
        if (newPosMin.x < posMin.x ) newPosMin.x = posMin.x ;
        else if (newPosMin.x > posMax.x -range) newPosMin.x = posMax.x -range ;
        
        newPosMin.x = constrain(mouseX, pos.x, pos.x+size.x -range) ; 
        // norm the value to return to method minMaxSliderUpdate
        minNorm = map(newPosMin.x, posMin.x, posMax.x, minNorm,maxNorm) ;
      } else newPosMin.y = constrain(mouseY -sizeMinMax.y, posMin.y, posMax.y) ; // this line is not reworking for the vertical slider
    }
  }
  
  void select_max() {
    lockedMax = select(lockedMax(), lockedMax) ;
  }
  // update maxvalue
  void update_max() {
    float range = sizeMol.x *1.5 ;
    /*
    if (lockedMax()) lockedMax = true ;
    if (!mousePressed) lockedMax = false ; 
    */
    
    if (lockedMax) {  // this line is not reworking for the vertical slider
      if (size.x >= size.y) {
        // security
        if (newPosMax.x < posMin.x +range)  newPosMax.x = posMin.x +range ;
        else if (newPosMax.x > posMax.x ) newPosMax.x = posMax.x ;
         newPosMax.x = constrain(mouseX -(size.y *.5) , pos.x +range, pos.x +size.x -(size.y *.5)) ; 
         // norm the value to return to method minMaxSliderUpdate
        posMax = Vec2(pos.x -sizeMol.x +(size.x *maxNorm), pos.y) ;
        // we use a temporary position for a good display of the max slider 
        Vec2 tempPosMax = Vec2(pos.x -(size.y *.5) +(size.x *maxNorm), posMax.y) ;
        maxNorm = map(newPosMax.x, posMin.x, tempPosMax.x, minNorm, maxNorm) ;
      } else newPosMax.y = constrain(mouseY -sizeMinMax.y, posMin.y, posMax.y) ; // this line is not reworking for the vertical slider
    }
    
  }
  
  // set min and max position
  void setMinMax(float newNormMin, float newNormMax) {
    minNorm = newNormMin ;
    maxNorm = newNormMax ;
  }
  
  
  
  
  
  
  
  
  
  // Display classic
  void displayMinMax() {
    if(lockedMin || lockedMax || insideMax() || insideMin()) fill(adjIn) ; else fill(adjOut) ;
    noStroke() ;
    rect(posMin.x, posMin.y +sizeMinMax.y *.4, sizeMinMax.x, sizeMinMax.y *.3) ;
    //  rect(newPosMin.x, newPosMin.y +sizeMinMax.y *.4, sizeMinMax.x, sizeMinMax.y *.3) ;
  }
  
  // Display advanced
 void displayMinMax(float normPos, float normSize, color adjIn, color adjOut, color strokeIn, color strokeOut, float thickness) {
    this.adjIn = adjIn ;
    this.adjOut = adjOut ;
    strokeWeight(thickness) ;
    if(lockedMin || lockedMax || insideMax() || insideMin()) {
      fill(adjIn) ;
      stroke(strokeIn) ;
    } else {
      fill(adjOut) ;
      stroke(strokeOut) ;
    }
    rect(posMin.x, posMin.y +sizeMinMax.y *normPos, sizeMinMax.x, sizeMinMax.y *normSize) ;
    // rect(newPosMin.x, newPosMin.y +sizeMinMax.y *normPos, sizeMinMax.x, sizeMinMax.y *normSize) ;
    noStroke() ;
  }
  
  
  
  
  
  
  // ANNEXE
  // INSIDE
  boolean insideMin() {
    if(inside(posMin, sizeMolMinMax,Vec2(mouseX,mouseY),RECT)) return true ; else return false ;
  }
  
  boolean insideMax() {
    Vec2 tempPosMax = Vec2(pos.x -(size.y *.5) +(size.x *maxNorm), posMax.y) ;
    if(inside(tempPosMax, sizeMolMinMax,Vec2(mouseX,mouseY),RECT)) return true ; else return false ;
  }
  
  //LOCKED
  boolean lockedMin () {
    if (insideMin() && mousePressed) return true ; else return false ;
  }
  
  boolean lockedMax () {
    if (insideMax() && mousePressed) return true ; else return false ;
  }
}
// END Extends class SLIDER
///////////////////////////
