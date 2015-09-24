class Slider
{
  private PVector pos, size, posText, posMol, sizeMol, newPosMol, posMin, posMax ;
  private color slider, boxIn, boxOut, colorText ;
  private boolean molLocked, inside ;
  private PFont p ;
  
  //CONSTRUCTOR with title
  public Slider(PVector pos, PVector posMol , PVector size, PVector posText, color slider, color boxIn, color boxOut, color colorText, PFont p) {
    this.pos = pos ;
    this.posMol = posMol ;
    this.size = size ;
    this.posText = posText ;
    this.slider = slider ;
    this.boxIn = boxIn ;
    this.boxOut = boxOut ;
    this.colorText = colorText ;
    this.p = p ;

    newPosMol = new PVector (0, 0) ;
    //which molette for slider horizontal or vertical
    if ( size.x >= size.y ) sizeMol = new PVector (size.y, size.y ) ; else sizeMol = new PVector (size.x, size.x ) ;
    posMin = new PVector (pos.x, pos.y) ;
    posMax = new PVector (pos.x + size.x - sizeMol.x, pos.y + size.y - sizeMol.y ) ;
  }
  
  //CONSTRUCTOR minimum
  public Slider(PVector pos, PVector posMol , PVector size, color slider, color boxIn, color boxOut ) {
    this.pos = pos ;
    this.posMol = posMol ;
    this.size = size ;
    this.slider = slider ;
    this.boxIn = boxIn ;
    this.boxOut = boxOut ;

    newPosMol = new PVector (0, 0) ;
    //which molette for slider horizontal or vertical
    if ( size.x >= size.y ) sizeMol = new PVector (size.y, size.y ) ; else sizeMol = new PVector (size.x, size.x ) ;
    posMin = new PVector (pos.x, pos.y) ;
    posMax = new PVector (pos.x + size.x - sizeMol.x, pos.y + size.y - sizeMol.y ) ;
  }
  
  //slider with external molette
  public Slider(PVector pos, PVector posMol , PVector size, PVector sizeMol,  color slider, color boxIn, color boxOut ) {
    this.pos = pos ;
    this.posMol = posMol ;
    this.sizeMol = sizeMol ;
    this.size = size ;
    this.slider = slider ;
    this.boxIn = boxIn ;
    this.boxOut = boxOut ;

    newPosMol = new PVector (0, 0) ;
    posMin = new PVector (pos.x, pos.y) ;
    posMax = new PVector (pos.x + size.x - sizeMol.x, pos.y + size.y - sizeMol.y ) ;
  }
  
  //SETTING
  
  void sliderSetting() {
    noStroke() ;
    
    //SLIDER
    fill(slider) ;
    rect(pos.x, pos.y, size.x, size.y ) ;
    
    //MOLETTE
    fill(boxOut) ;
    newPosMol = new PVector (posMol.x, posMol.y  ) ;
    rect(posMol.x, posMol.y, sizeMol.x, sizeMol.y ) ;
    
  }
  
  //Slider update with title
  void sliderUpdate(String s, boolean t) {
    //SLIDER
    fill(slider) ;
    rect(pos.x, pos.y, size.x, size.y ) ;
    if (t) {
      fill(colorText) ;
      textFont (p ) ;
      textSize (posText.z) ;
      text(s, posText.x, posText.y ) ;
    }
    //MOLETTE
    if (insideRect()) fill(boxIn); else fill(boxOut ) ;
    moletteUpdate() ;
    rect(newPosMol.x, newPosMol.y, sizeMol.x , sizeMol.y ) ;
  }
  //Slider update simple
  void sliderUpdate() {
    //SLIDER
    fill(slider) ;
    rect(pos.x, pos.y, size.x, size.y ) ;
    /*
    if (t) {
      fill(colorText) ;
      textFont (p ) ;
      textSize (posText.z) ;
      text(s, posText.x, posText.y ) ;
    }
    */
    //MOLETTE
    if (insideRect()) fill(boxIn); else fill(boxOut ) ;
    moletteUpdate() ;
    rect(newPosMol.x, newPosMol.y, sizeMol.x , sizeMol.y ) ;
  }
  
  
  void moletteUpdate() {
    if (locked ()  ) molLocked = true ;
    if (!mousePressed)  molLocked = false ; 
      
    if ( molLocked ) {  
      if ( size.x >= size.y ) newPosMol.x = constrain(mouseX -(sizeMol.x / 2.0 ), posMin.x, posMax.x)  ; else newPosMol.y = constrain(mouseY -(sizeMol.y / 2.0 ), posMin.y, posMax.y) ;
    }
  }
  
  //RETURN
  float getValue() {
    float value ;
    if ( size.x >= size.y ) value = map (newPosMol.x, posMin.x, posMax.x, 0,1) ; else value = map (newPosMol.y, posMin.y, posMax.y, 0,1) ;
    return value ;
  }
  
  
  //COMMON VOID
  //ANNEXE VOID
  //rect
  boolean insideRect() { 
    if ( mouseX > pos.x && mouseX < pos.x + size.x && mouseY > pos.y  && mouseY < pos.y + size.y ) {
      inside = true ;
      return true ; 
    } else {
      inside = false ;
      return false ; 
    }
  }

  //ellipse
  boolean insideEllipse() {
    float disX = pos.x -mouseX ; 
    float disY = pos.y -mouseY  ; 
    if (sqrt(sq(disX) + sq(disY)) < size.x/2 ) {
     inside = true ;
      return true ; 
    } else {
      inside = false ;
      return false ; 
    }
  }
  
  //locked
  boolean locked () {
    if ( inside  && mousePressed ) return true ; else return false ;
  }
}