class Bouton {
  color couleurBouton, couleurONoffCarre, couleurONoffCercle ;
  int etatBoutonCercle, etatBoutonCarre ;
  PVector pos = new PVector() ; 
  PVector size = new PVector() ;
  
  boolean dedansBoutonCercle = false ;
  boolean JouerBoutonCercle = false ;
  boolean JouerBoutonCarre = false ;  
  boolean dedansBoutonCarre = false ;
  
  //Constructor
  //simple
  Bouton () {}
  //complexe
  Bouton (int posWidth, int posHeight, int widthButton, int heightButton) {
    pos.x = posWidth ;
    pos.y = posHeight ;
    size.x = widthButton ;
    size.y = heightButton ;
    pos.x =  posWidth ; pos.y = posHeight ; size.x = widthButton ; size.y = heightButton ;
  }
  Bouton ( PVector pos, PVector size ) {
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
      return true ; 
    } else { 
      return false ; 
    }
  }
  // with correction for the font position
  boolean detectionCarre(int correction) {
    if (size.y < 10 ) newSize = size.y *1.8 ; 
    else if (size.y >= 10 && size.y < 20  ) newSize = size.y *1.2 ;  
    else if (size.y >= 20 ) newSize = size.y ;
    
    if ( mouseX > pos.x && mouseX < pos.x + size.x && mouseY > pos.y -correction  && mouseY < pos.y +newSize -correction) { 
      return true ; 
    } else { 
      return false ; 
    }
  }
  //ellipse
  boolean detectionCercle() {
    float disX = pos.x -mouseX ; 
    float disY = pos.y -mouseY  ; 
    if (sqrt(sq(disX) + sq(disY)) < size.x/2 ) return true ; else return false ; 
  } 
  
  
  
  //CLIC
  void mousePressedText() {
    //rect
    if (detectionCarre((int)size.y) ) {
      dedansBoutonCarre = true ;
      if ( JouerBoutonCarre ) {
        JouerBoutonCarre = false ;
        etatBoutonCarre = 0 ;
      } else {
        JouerBoutonCarre = true ;
        etatBoutonCarre = 1 ; 
      }
    }
  }
  //
  void mousePressed() {
    //rect
    if (detectionCarre() ) {
      dedansBoutonCarre = true ;
      if ( JouerBoutonCarre ) {
        JouerBoutonCarre = false ;
        etatBoutonCarre = 0 ;
      } else {
        JouerBoutonCarre = true ;
        etatBoutonCarre = 1 ; 
      }
    }
    //ellipse
    if ( detectionCercle() ) {
      dedansBoutonCercle = true ;
      if ( JouerBoutonCercle ) {
        JouerBoutonCercle = false ;
        etatBoutonCercle = 0 ;
      } else {
        JouerBoutonCercle = true ;
        etatBoutonCercle = 1 ;
      }
    }
  }
  /*
  void mouseReleased () {
    //rect
    if (detectionCarre() ) {
      dedansBoutonCarre = true ;
      if ( JouerBoutonCarre ) {
        JouerBoutonCarre = false ;
        etatBoutonCarre = 0 ;
      } else {
        JouerBoutonCarre = true ;
        etatBoutonCarre = 1 ; 
      }
    }
    //ellipse
    if ( detectionCercle() ) {
      dedansBoutonCercle = true ;
      if ( JouerBoutonCercle ) {
        JouerBoutonCercle = false ;
        etatBoutonCercle = 0 ;
      } else {
        JouerBoutonCercle = true ;
        etatBoutonCercle = 1 ;
      }
    }
  } 
  */
}


////////
//BUTTON
class Simple extends Bouton {
  color cBINonBO, cBOUTonBO, cBINoffBO, cBOUToffBO, cBEinBO, cBEoutBO ;
  
  //CONSTRUCTOR
  Simple(int posWidth, int posHeight, int widthButton, int heightButton) {
    super(posWidth, posHeight, widthButton, heightButton) ;
  }
  
  //
  Simple (int posWidth, int posHeight, int widthButton, int heightButton, 
          color BoutonINonBO, color BoutonOUTonBO, color BoutonINoffBO, color BoutonOUToffBO,
           color BoutonEnsembleINBO, color BoutonEnsembleOUTBO)                  
 {
   super(posWidth, posHeight,  widthButton, heightButton) ;
   cBINonBO = BoutonINonBO ; cBOUTonBO = BoutonOUTonBO ; cBINoffBO = BoutonINoffBO ; cBOUToffBO = BoutonOUToffBO ;
   cBEinBO = BoutonEnsembleINBO ; cBEoutBO = BoutonEnsembleOUTBO ;
 }
 
 Simple (PVector pos, PVector size, color BoutonINonBO, color BoutonOUTonBO, color BoutonINoffBO, color BoutonOUToffBO )  {
   super(pos, size) ;
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
   if (JouerBoutonCarre ) {
     stroke(vertTresFonce) ;
     if ( detectionCarre() ) { 
       dedansBoutonCarre = true ;
       couleurONoffCarre = cBINonBO ;
     } else {
       couleurONoffCarre = cBOUTonBO ;
     }
   } else {
     stroke(rougeTresFonce) ; 
     if ( detectionCarre() ) {
       dedansBoutonCarre = true ;
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
   if ( JouerBoutonCercle ) {
     stroke(vertTresFonce) ;
     if ( detectionCercle() ) {
       dedansBoutonCercle = true ;
       couleurONoffCercle = cBINonBO ;
     } else {
       couleurONoffCercle = cBOUTonBO ;
     }
   } else {
     stroke(rougeTresFonce) ;
     if ( detectionCercle() ) {
       dedansBoutonCercle = true ;
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
   
   if ( JouerBoutonCarre ) {
     if ( detectionCarre() ) {
       dedansBoutonCarre = true ;
       image(vignette_ON_in[wichVignette],pos.x, pos.y) ;
     } else {
       image(vignette_ON_out[wichVignette],pos.x, pos.y) ;
     }
   } else {
       if ( detectionCarre() ) {
       dedansBoutonCarre = true ;
       image(vignette_OFF_in[wichVignette],pos.x, pos.y) ;
     } else {
       image(vignette_OFF_out[wichVignette],pos.x, pos.y) ;
     }
   }
 }
 
 
 //SOUND button
 void boutonSonPetit () {
   if ( JouerBoutonCarre ) {
     if ( detectionCarre() ) {
       //ON
       dedansBoutonCarre = true ;
       image(bouton[1],pos.x, pos.y ) ;
     } else {
       image(bouton[0],pos.x, pos.y ) ;
     }
   } else {
     //OFF
       if ( detectionCarre() ) {
       dedansBoutonCarre = true ;
       image(bouton[3],pos.x, pos.y ) ;
     } else {
       image(bouton[2],pos.x, pos.y) ;
     }
   }
 }
 
 //ACTION Button
 void boutonAction ()
 {
   if ( JouerBoutonCarre ) {
     if ( detectionCarre() ) {
       dedansBoutonCarre = true ;
       image(bouton[11],pos.x, pos.y) ;
     } else {
       image(bouton[10],pos.x, pos.y) ;
     }
   } else {
       if ( detectionCarre() ) {
       dedansBoutonCarre = true ;
       image(bouton[13],pos.x, pos.y) ;
     } else {
       image(bouton[12],pos.x, pos.y) ;
     }
   }
 }
 
 ///BUTTON Texte
 void boutonTexte(String s, int x, int y) {
   if ( JouerBoutonCarre ) {
     stroke(vertTresFonce) ;
     if ( detectionCarre() ) { 
       dedansBoutonCarre = true ;
       couleurONoffCarre = cBINonBO ;
     } else {
       couleurONoffCarre = cBOUTonBO ;
     }
   } else {
      stroke(rougeTresFonce) ; 
     if ( detectionCarre() ) {
       dedansBoutonCarre = true ;
       couleurONoffCarre = cBINoffBO ;
     } else {
       couleurONoffCarre = cBOUToffBO ;
     }
   }

   fill(couleurONoffCarre) ;
   text(s, x, y) ;
 }
 
 void boutonTexte(String s, PVector pos, PFont font, int sizeFont) {
   if (JouerBoutonCarre) {
     if (detectionCarre(sizeFont) ) { 
       dedansBoutonCarre = true ;
       couleurONoffCarre = cBINonBO ;
     } else {
       couleurONoffCarre = cBOUTonBO ;
     }
   } else {
     if (detectionCarre(sizeFont) ) {
       dedansBoutonCarre = true ;
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
   if ( JouerBoutonCarre ) {
     stroke(vertTresFonce) ;
     if ( detectionCarre() ) { 
       dedansBoutonCarre = true ;
       couleurONoffCarre = cBINonBO ;
     } else {
       couleurONoffCarre = cBOUTonBO ;
     }
   } else {
     stroke(rougeTresFonce) ; 
     if ( detectionCarre() ) {
       dedansBoutonCarre = true ;
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


//.........................................................................................
  int getEtatBoutonCercle() { // nom de variable et () permet de récupérer les données d'un return
    return etatBoutonCercle ;
  }
  int getEtatBoutonCarre() { // nom de variable et () permet de récupérer les données d'un return
    return etatBoutonCarre ;
  }
}
