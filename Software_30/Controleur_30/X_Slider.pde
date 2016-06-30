/**
SLIDER may 2015 version 5g by Stan le Punk
SLIDER may 2016 1.5.9 
SLIDER june 2016 1.6.0
*/
boolean molette_already_selected ;


/**
CLASS SLIDER

*/
public class Slider {
  protected PVector pos, size, posMol, posText, sizeMol, posMin, posMax ;
  protected PVector newPosMol = new PVector() ;
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
  public Slider(PVector pos, PVector posMol , PVector size, PVector posText, PFont p) {
    this.pos = pos.copy() ;
    this.posMol = new PVector(pos.x + (posMol.x*size.x), pos.y +(posMol.y*size.y)) ;
    this.size = size.copy() ;
    this.posText = posText ;
    this.p = p ;

    //which molette for slider horizontal or vertical
    if (size.x >= size.y) sizeMol = new PVector (size.y, size.y) ; else sizeMol = new PVector (size.x, size.x ) ;
    // calculate minimum and maxium position of the molette
    if(size.x > size.y) {
      posMin = new PVector (pos.x, pos.y) ;
      posMax = new PVector (pos.x +size.x +size.y,  pos.y) ;
    } else {
      posMin = new PVector (pos.x, pos.y) ;
      float correction = sizeMol.y  + sizeMol.x ;
      posMax = new PVector (pos.x,  pos.y  +size.x +size.y -correction) ;
    }
  }
  
  //CONSTRUCTOR minimum
  public Slider(PVector pos, PVector posMol, PVector size) {
    this.pos = pos.copy() ;
    this.posMol = new PVector(pos.x + (posMol.x*size.x), pos.y +(posMol.y*size.y)) ;
    this.size = size.copy() ;

    //which molette for slider horizontal or vertical
    if (size.x >= size.y) sizeMol = new PVector (size.y, size.y) ; else sizeMol = new PVector (size.x, size.x) ;
    // calculate minimum and maxium position of the molette
    if(size.x > size.y) {
      posMin = new PVector (pos.x, pos.y) ;
      posMax = new PVector (pos.x +size.x +size.y,  pos.y) ;
    } else {
      posMin = new PVector (pos.x, pos.y) ;
      float correction = sizeMol.y  + sizeMol.x ;
      posMax = new PVector (pos.x,  pos.y  +size.x +size.y -correction) ;
    }
  }
  
  //slider with external molette
  public Slider(PVector pos, PVector posMol , PVector size, PVector sizeMol, String moletteShapeType) {
    this.pos = pos.copy() ;
    this.posMol = new PVector(pos.x +(posMol.x *size.x), pos.y +(posMol.y *size.y)) ;
    this.sizeMol = sizeMol.copy() ;
    this.size = size.copy() ;
    this.moletteShapeType = moletteShapeType ;
    // calculate minimum and maxium position of the molette
    if(size.x > size.y) {
      posMin = new PVector (pos.x, pos.y) ;
      posMax = new PVector (pos.x +size.x +size.y,  pos.y) ;
    } else {
      posMin = new PVector (pos.x, pos.y) ;
      float correction = sizeMol.y  + sizeMol.x ;
      posMax = new PVector (pos.x,  pos.y  +size.x +size.y -correction) ;
    }
  }
  
  // END CONSTRUCTOR
  void update_pos_molette(PVector pos, PVector pos_mol) {
    this.posMol.set(pos.x +(pos_mol.x *size.x), pos.y +(pos_mol.y *size.y)) ;
    this.newPosMol.set(posMol.x, posMol.y) ;
  }
  

  
  
  
  
  
  // METHODES
  //SETTING
  
  void setting() {
    /* May be it's possible to remove this method to includ that in the constructor ?
    but now we need that to init the molette */
    this.newPosMol = posMol.copy() ;
    preference_path = sketchPath("")+"preferences/" ;
    import_path = sketchPath("")+"import/" ;
  }
  
  

  void setMidi(int IDmidi) {
    this.IDmidi = IDmidi ;
  }
  
  
  // setting the position from a specific value
  void setMolette(float normPos) {
    // security to constrain the value in normalizing range.
    if(normPos > 1.) normPos = 1. ;
    if(normPos < 0) normPos = 0 ;
    // check if it's horizontal or vertical slider
    if(size.x >= size.y) newPosMol.x = size.x *normPos +posMin.x -(sizeMol.y *normPos)  ; else newPosMol.y = size.y *normPos +posMin.y -(sizeMol.x *normPos);
  }
  // END SETTING
  
  
  
  // UPDATE
  void select_molette() {
    lockedMol = select(lockedMol(), lockedMol) ;
  }

  // update molette position
  void update_pos_molette() {
    // move the molette is this one is locked
    // security
    if(size.x >= size.y) {
      // for the horizontal slider
      if (newPosMol.x < posMin.x ) newPosMol.x = posMin.x ;
      if (newPosMol.x > posMax.x ) newPosMol.x = posMax.x ;
    } else {
      // for the vertical slider
      if (newPosMol.y < posMin.y ) newPosMol.y = posMin.y ;
      if (newPosMol.y > posMax.y ) newPosMol.y = posMax.y ;
    }

    if (lockedMol) {  
      if (size.x >= size.y) newPosMol.x = constrain(mouseX -(sizeMol.x *.5), posMin.x, posMax.x) ; else newPosMol.y = constrain(mouseY -(sizeMol.y *.5), posMin.y, posMax.y) ;
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



  

  
  
  
  
  
  
  // DISPLAY SLIDER
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
    if(lockedMol || insideMol) fill(molIn); else fill(molOut ) ;
     shapeMolette() ;
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
    if (size.x >= size.y) value = map (newPosMol.x, posMin.x, posMax.x, minNorm, maxNorm) ; 
                          else value = map (newPosMol.y, posMin.y, posMax.y, minNorm, maxNorm) ;
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
    if(insideRect(pos, size)) insideMol = true ; else insideMol = false ;
    return insideMol ;
  }
  
  
  boolean insideMol_Rect() {
    if(insideRect(newPosMol, sizeMol)) insideMol = true ; else insideMol = false ;
    return insideMol ;
  }
  

  //ellipse
  boolean insideMol_Ellipse() {
    float radius = sizeMol.x ;
    int posX = int(radius *.5 +newPosMol.x ) ; 
    int posY = int(size.y *.5 +newPosMol.y) ;
    if(pow((posX -mouseX),2) + pow((posY -mouseY),2) < pow(radius,sqrt(3))) insideMol = true ; else insideMol = false ;
   return insideMol ;
  }
  
  
  
  //locked
  boolean lockedMol() {
    if (insideMol && mousePressed) return true ; else return false ;
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
  void selectIDmidi(int num) { IDmidi = num ; }
  
  //give the IDmidi 
  int IDmidi() { return IDmidi ; }
}
/**
END SLIDER
*/




















/**
SLIDER ADJUSTABLE : extends class of class Slider

*/
public class SliderAdjustable extends Slider {
  // size
  protected PVector sizeMinMax = new PVector() ;
  protected PVector sizeMolMinMax = new PVector() ;
  int widthMinMax = 10 ;
  // pos  
  protected PVector posMinMax = new PVector() ;
  protected PVector newPosMin = new PVector() ;
  protected PVector newPosMax = new PVector() ;
  // color
  protected color adjIn = color(255) ;
  protected color adjOut = color(125) ; ;

  boolean lockedMin, lockedMax ;
  
  // CLASSIC CONSTRUCTOR
  SliderAdjustable (PVector pos, PVector posMol , PVector size, PVector posText, PFont p) {
    super(pos, posMol, size, posText, p) ;
    this.posMinMax = pos.copy() ;
    this.newPosMin = posMinMax.copy() ;
    this.sizeMinMax = size.copy() ;
    this.sizeMolMinMax = new PVector(widthMinMax, size.y) ;
  }
  
  SliderAdjustable(PVector pos, PVector posMol , PVector size) {
    super(pos, posMol, size) ;
    this.posMinMax = pos.copy() ;
    this.newPosMin = posMinMax.copy() ;
    this.sizeMinMax = size.copy() ;
    this.sizeMolMinMax = new PVector(widthMinMax, size.y) ;
  }
  
  //slider with external molette
  SliderAdjustable(PVector pos, PVector posMol , PVector size, PVector sizeMol, String moletteShapeType) {
    super(pos, posMol, size, sizeMol, moletteShapeType) ;
    this.posMinMax = pos.copy() ;
   // this.newPosMin = posMinMax.copy() ;
    this.sizeMinMax = size.copy() ;
    this.sizeMolMinMax = new PVector(widthMinMax, size.y) ;
  }
  // END CLASSIC CONSTRUCTOR
  /////////////////////////

  
  
  
  /////////
  // METHOD
  
  void update_min_max() {
    float newNormSize = maxNorm -minNorm ;
    
    if (size.x >= size.y) sizeMinMax = new PVector (size.x *newNormSize, size.y) ; else sizeMinMax = new PVector (size.y *newNormSize, size.x) ;
    
    posMin = new PVector (pos.x +(size.x *minNorm), pos.y) ;
    // in this case the detection is translate on to and left of the size of molette
    posMax = new PVector (pos.x -sizeMol.x +(size.x *maxNorm), pos.y) ;
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
        posMax = new PVector (pos.x -sizeMol.x +(size.x *maxNorm), pos.y) ;
        // we use a temporary position for a good display of the max slider 
        PVector tempPosMax = new PVector(pos.x -(size.y *.5) +(size.x *maxNorm), posMax.y) ;
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
    if(insideRect(posMin, sizeMolMinMax)) return true ; else return false ;
  }
  
  boolean insideMax() {
    PVector tempPosMax = new PVector(pos.x -(size.y *.5) +(size.x *maxNorm), posMax.y) ;
    if(insideRect(tempPosMax, sizeMolMinMax)) return true ; else return false ;
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
