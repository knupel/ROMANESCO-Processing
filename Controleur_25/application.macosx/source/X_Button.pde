class Button {
  color couleurBouton, couleurONoffCarre, couleurONoffCercle ;
  PVector pos = new PVector() ; 
  PVector size = new PVector() ;
  
  boolean inside ;
  boolean onOff = false ;  
  //MIDI
  int newValMidi ;
  //int IDbutton ;
  int IDmidi = -2 ;
  
  
  //Constructor
  //simple
  Button () {}
  //complexe
  Button (int posWidth, int posHeight, int widthButton, int heightButton, boolean onOff) {
    this.onOff = onOff ;
    pos.x = posWidth ;
    pos.y = posHeight ;
    size.x = widthButton ;
    size.y = heightButton ;
    pos.x =  posWidth ; pos.y = posHeight ; size.x = widthButton ; size.y = heightButton ;
  }
  Button (PVector pos, PVector size, boolean onOff) {
    this.onOff = onOff ;
    this.pos = pos.get() ;
    this.size = size.get() ;
  }
  

  
  
  
  //ROLLOVER
  //rectangle
  float newSize = 1  ;
  //
  boolean rollover() {
    if (size.y < 10 ) newSize = size.y *1.8 ; 
    else if (size.y >= 10 && size.y < 20  ) newSize = size.y *1.2 ;  
    else if (size.y >= 20 ) newSize = size.y ;
    if ( mouseX > pos.x && mouseX < pos.x + size.x && mouseY > pos.y  && mouseY < pos.y + newSize ) { 
      inside = true ;
      return true ; 
    } else {
      inside = false ;
      return false ; 
    }
  }
  // with correction for the font position
  boolean rollover(int correction) {
    if (size.y < 10 ) newSize = size.y *1.8 ; 
    else if (size.y >= 10 && size.y < 20  ) newSize = size.y *1.2 ;  
    else if (size.y >= 20 ) newSize = size.y ;
    
    if ( mouseX > pos.x && mouseX < pos.x + size.x && mouseY > pos.y -correction  && mouseY < pos.y +newSize -correction) { 
      inside = true ;
      return true ; 
    } else {
      inside = false ;
      return false ; 
    }
  }
  
  
  
  //CLIC
  void mousePressedText() {
    if (rollover((int)size.y) ) if (onOff) onOff = false ; else onOff = true ; 
  }
  //
  void mousePressed() {
    if (rollover()) if (onOff) onOff = false ; else onOff = true ;
  }
  
  // MIDI
  int IDmidi() { return IDmidi ; }
  
  void selectIDmidi(int num) { IDmidi = num ; }
}




////////
//BUTTON
class Simple extends Button {
  color cBINonBO, cBOUTonBO, cBINoffBO, cBOUToffBO, cBEinBO, cBEoutBO ;
  
  //CONSTRUCTOR
  Simple(int posWidth, int posHeight, int widthButton, int heightButton, boolean onOff) {
    super(posWidth, posHeight, widthButton, heightButton, onOff) ;
  }
  
  //
  Simple (int posWidth, int posHeight, int widthButton, int heightButton, 
          color BoutonINonBO, color BoutonOUTonBO, color BoutonINoffBO, color BoutonOUToffBO,
           color BoutonEnsembleINBO, color BoutonEnsembleOUTBO, boolean onOff)                  
 {
   super(posWidth, posHeight,  widthButton, heightButton, onOff) ;
   cBINonBO = BoutonINonBO ; cBOUTonBO = BoutonOUTonBO ; cBINoffBO = BoutonINoffBO ; cBOUToffBO = BoutonOUToffBO ;
   cBEinBO = BoutonEnsembleINBO ; cBEoutBO = BoutonEnsembleOUTBO ;
 }
 
 Simple (PVector pos, PVector size, color BoutonINonBO, color BoutonOUTonBO, color BoutonINoffBO, color BoutonOUToffBO, boolean onOff)  {
   super(pos, size, onOff) ;
   cBINonBO = BoutonINonBO ; cBOUTonBO = BoutonOUTonBO ; cBINoffBO = BoutonINoffBO ; cBOUToffBO = BoutonOUToffBO ;
 }
 
 
 
 //VOID
 void boutonFond () {
   fill(couleurBouton) ;
   rect(pos.x, pos.y, size.x, size.y) ;
 }
 
 
 ////////////////
 //BUTTON CLASSIC
 


 
 
 //////////////
 //IMAGE BUTTON
 
 //VIGNETTE Button
 // vignette_OFF_in_simple, vignette_OFF_out_simple, vignette_ON_in_simple, vignette_ON_out_simple
 void buttonPicSerie(PImage[] OFF_in, PImage[] OFF_out, PImage[] ON_in, PImage[] ON_out, int whichOne) {
   int correctionX = -1 ;
   if (onOff ) {
     if (rollover() && !dropdownActivity) image(ON_in[whichOne],pos.x +correctionX, pos.y) ; else image(ON_out[whichOne],pos.x +correctionX, pos.y) ;
   } else {
     if (rollover() && !dropdownActivity) image(OFF_in[whichOne],pos.x +correctionX, pos.y) ; else image(OFF_out[whichOne],pos.x +correctionX, pos.y) ;
   }
 }
 void buttonPic(PImage [] pic) {
   int correctionX = -1 ;
   if ( onOff ) {
     if (rollover() && !dropdownActivity) image(pic[1],pos.x +correctionX, pos.y ) ; else image(pic[0],pos.x +correctionX, pos.y ) ;
   } else {
     if (rollover() && !dropdownActivity) image(pic[3],pos.x +correctionX, pos.y ) ; else image(pic[2],pos.x +correctionX, pos.y) ;
   }
 }
 void buttonPicText(PImage [] pic, String text) {
   fill(jaune) ;
   textFont(FuturaStencil_20) ;
   int correctionX = -1 ;
   if ( onOff ) {
     if (rollover() && !dropdownActivity) {
       image(pic[1],pos.x +correctionX, pos.y ) ;
       text(text,   mouseX -20, mouseY -20 ) ;
     } else image(pic[0],pos.x +correctionX, pos.y ) ;
   } else {
     if (rollover() && !dropdownActivity) { 
       image(pic[3],pos.x +correctionX, pos.y ) ; 
       text(text,   mouseX -20, mouseY -20 ) ;
     } else image(pic[2],pos.x +correctionX, pos.y) ;
   }
 }

 ///BUTTON Texte
 void boutonTexte(String s, int x, int y) {
   if (onOff) {
     stroke(vertTresFonce) ;
     if (rollover() && !dropdownActivity) couleurONoffCarre = cBINonBO ; else couleurONoffCarre = cBOUTonBO ;
   } else {
      stroke(rougeTresFonce) ; 
     if (rollover() && !dropdownActivity) couleurONoffCarre = cBINoffBO ; else couleurONoffCarre = cBOUToffBO ;
   }

   fill(couleurONoffCarre) ;
   text(s, x, y) ;
 }
 
 void boutonTexte(String s, PVector pos, PFont font, int sizeFont) {
   if (onOff) {
     if (rollover(sizeFont) && !dropdownActivity) couleurONoffCarre = cBINonBO ; else couleurONoffCarre = cBOUTonBO ;
   } else {
     if (rollover(sizeFont) && !dropdownActivity) couleurONoffCarre = cBINoffBO ; else couleurONoffCarre = cBOUToffBO ;
   }
   fill(couleurONoffCarre) ;
   textFont(font) ;
   textSize(sizeFont) ;
   text(s, pos.x, pos.y) ;
 }
 
 ////////////////////////////////////
 void boutonCarreEcran (String s, PVector localpos) {
   strokeWeight (1) ;
   if (onOff) {
     stroke(vertTresFonce) ;
     if (rollover() && !dropdownActivity)couleurONoffCarre = cBINonBO ; else couleurONoffCarre = cBOUTonBO ;
   } else {
     stroke(rougeTresFonce) ; 
     if (rollover() && !dropdownActivity) couleurONoffCarre = cBINoffBO ; else couleurONoffCarre = cBOUToffBO ;
   }

   fill(couleurONoffCarre) ;
   rect(pos.x, pos.y, size.x, size.y) ;
   fill(blanc) ;
   text(s, pos.x +localpos.x, pos.y + localpos.y) ;
   noStroke() ;
 }


  // return the statement of the button is this one is ON or OFF
  int getOnOff() { 
    if (!onOff) return 0 ; else return 1 ;
  }
  
  //MIDI
  int IDmidi() { return IDmidi ; }
}
