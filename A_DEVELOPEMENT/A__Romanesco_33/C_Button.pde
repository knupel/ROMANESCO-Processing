/**
BUTTON 2.0.0
*/
class Button
{
  boolean inside, OnOff ;
  vec2 pos, size ;
  color On_In, On_Out, Off_In, Off_Out ;
  String textOn, textOff ;
  
  //CONSTRUCTOR
  
  //basic Button
  Button(vec2 pos, vec2 size) {
    Off_In = color (27,100,100) ; //orange
    Off_Out = color (9,100,70) ; //rouge
    On_In = color (88,85,71) ; // vert clair
    On_Out = color (90,93,46) ; // vert foncé
    this.pos = pos ;
    this.size = size ;
  }
  //with specific color
  Button(vec2 pos, vec2 size, color Off_In, color Off_Out, color On_In, color On_Out) {
    this.Off_In = Off_In ;
    this.Off_Out = Off_Out ;
    this.On_In = On_In ; 
    this.On_Out = On_Out ;
    this.pos = pos ;
    this.size = size ;
  }
  
  //text Button with two text
  Button(vec2 pos, vec2 size, String textOn, String textOff) {
    Off_In = color (27,100,100) ; //orange
    Off_Out = color (9,100,70) ; //rouge
    On_In = color (88,85,71) ; // vert clair
    On_Out = color (90,93,46) ; // vert foncé
    this.textOn = textOn ;
    this.textOff = textOff ;
    this.pos = pos ;
    this.size = size ;
  }
  //text button with specific color with two text
  Button(vec2 pos, vec2 size, color Off_In, color Off_Out, color On_In, color On_Out, String textOn, String textOff) {
    this.Off_In = Off_In ;
    this.Off_Out = Off_Out ;
    this.On_In = On_In ; 
    this.On_Out = On_Out ;
    this.textOn = textOn ;
    this.textOff = textOff ;
    this.pos = pos ;
    this.size = size ;
  }
    //text button with specific color with one text
  Button(vec2 pos, vec2 size, color Off_In, color Off_Out, color On_In, color On_Out, String textOn) {
    this.Off_In = Off_In ;
    this.Off_Out = Off_Out ;
    this.On_In = On_In ; 
    this.On_Out = On_Out ;
    this.textOn = textOn ;
    this.textOff = textOn ;
    this.pos = pos ;
    this.size = size ;
  }
  
  
  void displayButton() {
    String textResult ;
    if(OnOff) {
      textResult = textOn ;
      if(insideRect()) fill(On_In) ; else fill (On_Out ) ;
    } else {
      textResult = textOff ;
      if(insideRect()) fill(Off_In) ; else fill (Off_Out ) ;
    }
      
    if (textOff != null || textOn != null ) {
      textSize(size.y) ;
      text(textResult, pos.x, pos.y + size.y ) ; 
    } else {
      rect(pos, size) ;
    }
  }
  
  //indicate if this one is on or off
  void displayButton(boolean off) {
    String textResult ;
    if(OnOff || off) {
      textResult = textOn ;
      if(insideRect()) fill(On_In) ; else fill (On_Out ) ;
    } else {
      textResult = textOff ;
      if(insideRect()) fill(Off_In) ; else fill (Off_Out ) ;
    }
      
    if (textOff != null || textOn != null ) {
      textSize(size.y) ;
      text(textResult, pos.x, pos.y + size.y ) ; 
    } else {
      rect(pos, size) ;
    }
  }
  
  
  
  
  
  //COMMON VOID
  //ANNEXE VOID
  //detection cursor on area
  //rect
  boolean insideRect() { 
    if ( mouseX > pos.x && mouseX < pos.x + size.x && mouseY > pos.y  && mouseY < pos.y + size.y ) inside = true ; else inside = false ;
    return inside ;
  }

  //ellipse
  boolean insideEllipse() {
    float disX = pos.x -mouseX ; 
    float disY = pos.y -mouseY  ; 
    if (sqrt(sq(disX) + sq(disY)) < size.x/2 ) inside = true ; else inside = false ;
    return inside ;
  }
 
  //MOUSEPRESSED
  void mouseClic() {
    if (insideRect()) if (!OnOff)  OnOff = !OnOff ;
  } 
  
}
