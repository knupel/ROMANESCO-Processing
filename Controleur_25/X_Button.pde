class Button {
  color couleurBouton, couleurONoffCarre, couleurONoffCercle ;
  PVector pos = new PVector() ; 
  PVector size = new PVector() ;
  
  boolean inside ;
  // boolean dedansBoutonCercle = false ;
  // boolean dedansBoutonCarre = false ;
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
  boolean detectionCarre() {
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
  boolean detectionCarre(int correction) {
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
  //ellipse
  boolean detectionCercle() {
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
  
  
  
  //CLIC
  void mousePressedText() {
    if (detectionCarre((int)size.y) ) if (onOff) onOff = false ; else onOff = true ; 
  }
  //
  void mousePressed() {
    if (detectionCarre() ) if (onOff) onOff = false ; else onOff = true ;
    //
    if (detectionCercle()) if (onOff) onOff = false ; else onOff = true ;
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
 
 ///Bouton carre
 void boutonCarre () {
   strokeWeight (1) ;
   if (onOff) {
     stroke(vertTresFonce) ;
     if (detectionCarre() && !dropdownActivity) { 
       //
       couleurONoffCarre = cBINonBO ;
     } else {
       couleurONoffCarre = cBOUTonBO ;
     }
   } else {
     stroke(rougeTresFonce) ; 
     if (detectionCarre() && !dropdownActivity) {
       // dedansBoutonCarre = true ;
       couleurONoffCarre = cBINoffBO ;
     } else {
       couleurONoffCarre = cBOUToffBO ;
     }
   }
   fill(couleurONoffCarre) ;
   rect(pos.x, pos.y, size.x, size.y) ;
   noStroke() ;
 }
 ////////////////////////////////////
 void boutonCercle () {
   strokeWeight (1) ;
   if (onOff) {
     stroke(vertTresFonce) ;
     if (detectionCercle() && !dropdownActivity) {
       // dedansBoutonCercle = true ;
       couleurONoffCercle = cBINonBO ;
     } else {
       couleurONoffCercle = cBOUTonBO ;
     }
   } else {
     stroke(rougeTresFonce) ;
     if (detectionCercle() && !dropdownActivity) {
       //dedansBoutonCercle = true ;
       couleurONoffCercle = cBINoffBO ;
     } else {
       couleurONoffCercle = cBOUToffBO ;
     }
   }
   fill(couleurONoffCercle) ;
   ellipse(pos.x, pos.y, size.x, size.x) ;
   noStroke() ;
 }
 


 
 
 //////////////
 //IMAGE BUTTON
 
 //VIGNETTE Button
 // vignette_OFF_in_simple, vignette_OFF_out_simple, vignette_ON_in_simple, vignette_ON_out_simple
 void boutonVignette(PImage[] vignette_OFF_in, PImage[] vignette_OFF_out, PImage[] vignette_ON_in, PImage[] vignette_ON_out, int wichVignette) {
   
   if (onOff ) {
     if (detectionCarre() && !dropdownActivity) {
       //dedansBoutonCarre = true ;
       image(vignette_ON_in[wichVignette],pos.x, pos.y) ;
     } else {
       image(vignette_ON_out[wichVignette],pos.x, pos.y) ;
     }
   } else {
       if (detectionCarre() && !dropdownActivity) {
       //dedansBoutonCarre = true ;
       image(vignette_OFF_in[wichVignette],pos.x, pos.y) ;
     } else {
       image(vignette_OFF_out[wichVignette],pos.x, pos.y) ;
     }
   }
 }
 
 
 //SOUND button
 void boutonSonPetit () {
   if ( onOff ) {
     if (detectionCarre() && !dropdownActivity) {
       //ON
       // dedansBoutonCarre = true ;
       image(bouton[1],pos.x, pos.y ) ;
     } else {
       image(bouton[0],pos.x, pos.y ) ;
     }
   } else {
     //OFF
       if (detectionCarre() && !dropdownActivity) {
       //dedansBoutonCarre = true ;
       image(bouton[3],pos.x, pos.y ) ;
     } else {
       image(bouton[2],pos.x, pos.y) ;
     }
   }
 }
 
 //ACTION Button
 void boutonAction () {
   if ( onOff ) {
     if (detectionCarre() && !dropdownActivity) {
       // dedansBoutonCarre = true ;
       image(bouton[11],pos.x, pos.y) ;
     } else {
       image(bouton[10],pos.x, pos.y) ;
     }
   } else {
       if (detectionCarre() && !dropdownActivity) {
       // dedansBoutonCarre = true ;
       image(bouton[13],pos.x, pos.y) ;
     } else {
       image(bouton[12],pos.x, pos.y) ;
     }
   }
 }
 
 ///BUTTON Texte
 void boutonTexte(String s, int x, int y) {
   if (onOff) {
     stroke(vertTresFonce) ;
     if ( detectionCarre() && !dropdownActivity) { 
       // dedansBoutonCarre = true ;
       couleurONoffCarre = cBINonBO ;
     } else {
       couleurONoffCarre = cBOUTonBO ;
     }
   } else {
      stroke(rougeTresFonce) ; 
     if ( detectionCarre() && !dropdownActivity) {
       // dedansBoutonCarre = true ;
       couleurONoffCarre = cBINoffBO ;
     } else {
       couleurONoffCarre = cBOUToffBO ;
     }
   }

   fill(couleurONoffCarre) ;
   text(s, x, y) ;
 }
 
 void boutonTexte(String s, PVector pos, PFont font, int sizeFont) {
   if (onOff) {
     if (detectionCarre(sizeFont) && !dropdownActivity) {
       // dedansBoutonCarre = true ;
       couleurONoffCarre = cBINonBO ;
     } else {
       couleurONoffCarre = cBOUTonBO ;
     }
   } else {
     if (detectionCarre(sizeFont) && !dropdownActivity) {
       // dedansBoutonCarre = true ;
       couleurONoffCarre = cBINoffBO ;
     } else {
       couleurONoffCarre = cBOUToffBO ;
     }
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
     if (detectionCarre() && !dropdownActivity) { 
       // dedansBoutonCarre = true ;
       couleurONoffCarre = cBINonBO ;
     } else {
       couleurONoffCarre = cBOUTonBO ;
     }
   } else {
     stroke(rougeTresFonce) ; 
     if (detectionCarre() && !dropdownActivity) {
       // dedansBoutonCarre = true ;
       couleurONoffCarre = cBINoffBO ;
     } else {
       couleurONoffCarre = cBOUToffBO ;
     }
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
  // 
  //void selectIDmidi(int num) { IDmidi = num ; }
}
