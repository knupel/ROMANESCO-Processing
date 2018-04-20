/**
SLIDER 
2015 - 2018
SLIDER may 2016 1.5.9 
SLIDER june 2016 1.6.0
SLIDER january 2017 1.6.1
SLIDER march 2018 1.7.0
v 1.7.1
*/
boolean molette_already_selected ;


/**
CLASS SLIDER
*/
public class Slider {
  protected Vec2 pos, size;
  protected Vec2 pos_molette, size_molette;
  protected PVector posText;
  protected Vec2 posMin, posMax ;
  // protected Vec2 newPosMol ;
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
  
  //CONSTRUCTOR with title
  public Slider(Vec2 pos, Vec2 size, PVector posText, PFont p) {
    set_pos(pos);
    this.size = size.copy();
    this.posText = posText;
    this.p = p ;
    //which molette for slider horizontal or vertical
    if (size.x >= size.y) {
      size_molette = Vec2(size.y, size.y); 
    } else {
      size_molette = Vec2(size.x, size.x );
    }
    // calculate minimum and maxium position of the molette
    if(size.x > size.y) {
      posMin = Vec2(pos.x, pos.y);
      posMax = Vec2(pos.x +size.x +size.y, pos.y);
    } else {
      posMin = Vec2(pos.x, pos.y);
      float correction = size_molette.y +size_molette.x;
      posMax = Vec2(pos.x, pos.y +size.x +size.y -correction);
    }
  }
  
  //CONSTRUCTOR minimum
  public Slider(Vec2 pos, Vec2 size) {
    set_pos(pos);
    this.size = size.copy() ;

    //which molette for slider horizontal or vertical
    if (size.x >= size.y) {
      size_molette = Vec2(size.y, size.y); 
    } else {
      size_molette = Vec2(size.x, size.x) ;
    }
    // calculate minimum and maxium position of the molette
    if(size.x > size.y) {
      posMin = Vec2(pos.x, pos.y) ;
      posMax = Vec2(pos.x +size.x +size.y,  pos.y) ;
    } else {
      posMin = Vec2(pos.x, pos.y) ;
      float correction = size_molette.y  + size_molette.x ;
      posMax = Vec2(pos.x,  pos.y  +size.x +size.y -correction) ;
    }
  }
  
  //slider with external molette
  public Slider(Vec2 pos, Vec2 size, Vec2 size_molette, String moletteShapeType) {
    set_pos(pos);
    this.size_molette = size_molette.copy() ;
    this.size = size.copy() ;
    this.moletteShapeType = moletteShapeType ;
    // calculate minimum and maxium position of the molette
    if(size.x > size.y) {
      posMin = Vec2(pos.x, pos.y) ;
      posMax = Vec2(pos.x +size.x +size.y,  pos.y) ;
    } else {
      posMin = Vec2(pos.x, pos.y) ;
      float correction = size_molette.y  + size_molette.x ;
      posMax = Vec2(pos.x,  pos.y  +size.x +size.y -correction) ;
    }
  }

  void set_pos(float x, float y) {
    set_pos(Vec2(x,y));
  }

  void set_pos(Vec2 pos) {
    if(this.pos == null || this.pos_molette == null || !this.pos.equals(pos)) {
      if(this.pos == null) {
        this.pos = pos.copy();
      } else {
        this.pos.set(pos);
      }

      if(this.pos_molette == null) {
        this.pos_molette = pos.copy();
      } else {
        this.pos_molette.set(pos);
      }
    }
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
    if(size.x >= size.y) {;
      pos_molette.x = size.x *normPos +posMin.x -(size_molette.y *normPos) ; 
    } else {
      pos_molette.y = size.y *normPos +posMin.y -(size_molette.x *normPos) ;
    }
  }



  
  
  
  void select_molette() {
    lockedMol = select(lockedMol(), lockedMol) ;
  }




 

  void update_molette() {
    // move the molette is this one is locked
    // security
    if(size.x >= size.y) {
      // for the horizontal slider
      if (pos_molette.x < posMin.x ) {
        pos_molette.x = posMin.x ;
      }
      if (pos_molette.x > posMax.x ) {
        pos_molette.x = posMax.x ;
      }
    } else {
      // for the vertical slider
      if (pos_molette.y < posMin.y ) {
        pos_molette.y = posMin.y ;
      }
      if (pos_molette.y > posMax.y ) {
        pos_molette.y = posMax.y ;
      }
    }

    if (lockedMol) {
      if (size.x >= size.y) { 
        pos_molette.x = constrain(mouseX -(size_molette.x *.5), posMin.x, posMax.x) ; 
      } else { 
        pos_molette.y = constrain(mouseY -(size_molette.y *.5), posMin.y, posMax.y) ;
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
  void show_slider() {
    fill(sliderColor) ;
    rect(pos.x, pos.y, size.x, size.y ) ;
  }
  
  // slider display advanced
  void show_slider(color sliderColor, color sliderStrokeColor, float thickness) {
    this.sliderColor = sliderColor ;
    fill(sliderColor) ;
    stroke(sliderStrokeColor) ;
    strokeWeight(thickness) ;
    rect(pos.x, pos.y, size.x, size.y ) ;
    noStroke() ;
  }
  //Slider update with title
  void show_sliderText(String s, boolean t) {
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
  void show_molette() {
    if(lockedMol || insideMol) { 
      fill(molIn); 
    } else { 
      fill(molOut ) ;
    }
    shapeMolette() ;
    noStroke() ;
  }
  
  // display molette advanced
  void show_molette(color molIn, color molOut, color strokeIn, color strokeOut, float thickness) {
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
      ellipse(size_molette.x *.5 +pos_molette.x, size.y *.5 +pos_molette.y, size_molette.x , size_molette.y) ;
    } else if(moletteShapeType.equals("RECT")) {
      rect(pos_molette.x, pos_molette.y, size_molette.x , size_molette.y ) ;
    } else rect(pos_molette.x, pos_molette.y, size_molette.x , size_molette.y ) ;
  }
  
  
  /* return the position of the molette, the minium and the maximum between 0 and 1
  @ return float
  */
  float getValue() {
    float value ;
    if (size.x >= size.y) {
      value = map (pos_molette.x, posMin.x, posMax.x, minNorm, maxNorm) ; 
    } else {
      value = map (pos_molette.y, posMin.y, posMax.y, minNorm, maxNorm) ;
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
  
  
  boolean inside_molette_rect() {
    if(inside(pos_molette,size_molette,Vec2(mouseX,mouseY),RECT)) {
      insideMol = true ; 
    } else {
      insideMol = false ;
    }
    return insideMol ;
  }
  

  //ellipse
  boolean insideMol_Ellipse() {
    float radius = size_molette.x ;
    int posX = int(radius *.5 +pos_molette.x ) ; 
    int posY = int(size.y *.5 +pos_molette.y) ;
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
      pos_molette.x = map(val, 1, 127, posMin.x, posMax.x) ;
    }
  }

  
  //////
  //VOID
  void load(int load) {
    pos_molette.x = load ;
  }
  
  // give the ID from the controller Midi
  void selectIDmidi(int num) { 
    IDmidi = num ; 
  }
  
  //give the IDmidi 
  int IDmidi() { 
    return IDmidi ; 
  }

  public Vec2 get_pos() {
    return pos;
  }

  public Vec2 get_size() {
    return size;
  }

  public Vec2 get_pos_molette() {
    return pos_molette;
  }

  public Vec2 get_size_molette() {
    return size_molette;
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
  
  /**
  CONSTRUCTOR
  */
  SliderAdjustable(Vec2 pos, Vec2 size, PVector posText, PFont p) {
    super(pos,size,posText,p);
    this.newPosMax = Vec2();
    this.posMinMax = pos.copy();
    this.newPosMin = posMinMax.copy();
    this.sizeMinMax = size.copy();
    this.sizeMolMinMax = Vec2(widthMinMax, size.y);
  }
  
  SliderAdjustable(Vec2 pos, Vec2 size) {
    super(pos, size);
    this.newPosMax = Vec2();
    this.posMinMax = pos.copy();
    this.newPosMin = posMinMax.copy();
    this.sizeMinMax = size.copy();
    this.sizeMolMinMax = Vec2(widthMinMax, size.y);
  }
  
  //slider with external molette
  SliderAdjustable(Vec2 pos, Vec2 size, Vec2 size_molette, String moletteShapeType) {
    super(pos, size, size_molette, moletteShapeType);
    this.newPosMax = Vec2();
    this.newPosMin = Vec2();
    this.posMinMax = pos.copy();
    this.sizeMinMax = size.copy();
    this.sizeMolMinMax = Vec2(widthMinMax, size.y);
  }


  
  
  
  /**
  METHOD
  */
  void update_min_max() {
    float newNormSize = maxNorm -minNorm ;
    
    if (size.x >= size.y) sizeMinMax = Vec2(size.x *newNormSize, size.y) ; else sizeMinMax = Vec2(size.y *newNormSize, size.x) ;
    
    posMin = Vec2(pos.x +(size.x *minNorm), pos.y) ;
    // in this case the detection is translate on to and left of the size of molette
    posMax = Vec2(pos.x -size_molette.x +(size.x *maxNorm), pos.y) ;
  }
  
  // update Min and Max value
  // update min value

  void select_min() {
    lockedMin = select(lockedMin(), lockedMin) ;
  }
  void update_min() {
    float range = size_molette.x *1.5 ;
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
    float range = size_molette.x *1.5 ;
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
        posMax = Vec2(pos.x -size_molette.x +(size.x *maxNorm), pos.y) ;
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
