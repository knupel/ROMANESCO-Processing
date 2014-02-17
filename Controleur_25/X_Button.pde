class Bouton
{
//............................Paramètre superClasse...............................
  color couleurBouton, couleurONoffCarre, couleurONoffCercle ;
  int mGB, mHB, lB, hB , etatBoutonCercle, etatBoutonCarre ;
  
  boolean dedansBoutonCercle = false ;
  boolean JouerBoutonCercle = false ;
  boolean JouerBoutonCarre = false ;  
  boolean dedansBoutonCarre = false ;
  
  //Constructor
  //simple
  Bouton () {}
  //complexe
  Bouton ( int posWidthB, int posHeightB, int longueurB, int hauteurB ) {
    mGB =  posWidthB ; mHB = posHeightB ; lB = longueurB ; hB = hauteurB ;
  }
  

  
  
  
  //ROLLOVER
  //rectangle
  float newhB = 1  ;
  boolean detectionCarre() {
    
    if (hB < 10 ) newhB = hB *1.8 ; 
    else if (hB >= 10 && hB < 20  ) newhB = hB *1.2 ;  
    else if (hB >= 20 ) newhB = hB ;
    
   if ( mouseX > mGB && mouseX < mGB + lB && mouseY > mHB  && mouseY < mHB + newhB ) { 
     return true ; 
   } else { 
     return false ; 
   }
  }
  //ellipse
  boolean detectionCercle() {
    float disX = mGB -mouseX ; 
    float disY = mHB -mouseY  ; 
    if (sqrt(sq(disX) + sq(disY)) < lB/2 ) return true ; else return false ; 
  } 
  
  
  
  //CLIC
  void mousePressed () {
    //rect
    if ( detectionCarre() ) {
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
  
  void mouseReleased () 
  {
    //rect
    if ( detectionCarre() ) {
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
}


////////
//BUTTON
class Simple extends Bouton
{
  color cBINonBO, cBOUTonBO, cBINoffBO, cBOUToffBO, cBEinBO, cBEoutBO ;
  
  //CONSTRUCTOR
  Simple(int mGB,  int mHB, int lB, int hB) {
    super(mGB, mHB, lB, hB) ;
  }
  
  //
  Simple (  int mGB,  int mHB, int lB, int hB, 
            color BoutonINonBO, color BoutonOUTonBO, color BoutonINoffBO, color BoutonOUToffBO,
            color BoutonEnsembleINBO, color BoutonEnsembleOUTBO)                  
 {
   super(mGB, mHB, lB, hB) ;
   cBINonBO = BoutonINonBO ; cBOUTonBO = BoutonOUTonBO ; cBINoffBO = BoutonINoffBO ; cBOUToffBO = BoutonOUToffBO ;
   cBEinBO = BoutonEnsembleINBO ; cBEoutBO = BoutonEnsembleOUTBO ;
 }
 
 
 
 //VOID
 void boutonFond () {
   fill(couleurBouton) ;
   rect(mGB, mHB, lB, hB) ;
 }
 
 
 ////////////////
 //BUTTON CLASSIC
 
 ///Bouton carre
 void boutonCarre () {
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
   rect(mGB, mHB, lB, hB) ;
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
   ellipse(mGB, mHB, lB, lB) ;
   noStroke() ;
 }
 
 /*
 /////////////////////////////////////////
 void boutonJouer ()
 {
   smooth() ;
   pushMatrix() ;
   translate ( -lB/2 , -lB/2 ) ;
   
   if ( JouerBoutonCercle ) {
     if ( detectionCercle() ) {
       dedansBoutonCercle = true ;
       couleurONoffCercle = cBINonBO ;
       image(bouton[6],mGB , mHB ) ;
     } else {
       couleurONoffCercle = cBOUTonBO ;
       image(bouton[7],mGB , mHB ) ;
     }
   } else {
       if ( detectionCercle() ) {
       dedansBoutonCercle = true ;
       couleurONoffCercle = cBINoffBO ;
       image(bouton[4],mGB , mHB ) ;
     } else {
       couleurONoffCercle = cBOUToffBO ;
       image(bouton[5],mGB , mHB ) ;
     }
   }
   fill(couleurONoffCercle, 30) ;
   popMatrix() ;
 }
 */
 ///////////////////////////////////////
 /*
 void boutonRetour ()
 {
   smooth() ;
   pushMatrix() ;
   translate ( -lB/2 , -lB/2 ) ;
   
   if ( JouerBoutonCercle ) {
     if ( detectionCercle() ) {
       dedansBoutonCercle = true ;
       couleurONoffCercle = cBINonBO ;
       image(bouton[8],mGB , mHB ) ;
     } else {
       couleurONoffCercle = cBOUTonBO ;
       image(bouton[8],mGB , mHB ) ;
     }
   } else {
       if ( detectionCercle() ) {
       dedansBoutonCercle = true ;
       couleurONoffCercle = cBINoffBO ;
       image(bouton[9],mGB , mHB ) ;
     } else {
       couleurONoffCercle = cBOUToffBO ;
       image(bouton[9],mGB , mHB ) ;
     }
   }
   fill(couleurONoffCercle, 30) ;
   popMatrix() ;
 }
 */
 
 //////////////
 //IMAGE BUTTON
 
 //VIGNETTE Button
 // vignette_OFF_in_simple, vignette_OFF_out_simple, vignette_ON_in_simple, vignette_ON_out_simple
 void boutonVignette(PImage[] vignette_OFF_in, PImage[] vignette_OFF_out, PImage[] vignette_ON_in, PImage[] vignette_ON_out, int wichVignette) {
   
   if ( JouerBoutonCarre ) {
     if ( detectionCarre() ) {
       dedansBoutonCarre = true ;
       image(vignette_ON_in[wichVignette],mGB , mHB ) ;
     } else {
       image(vignette_ON_out[wichVignette],mGB , mHB ) ;
     }
   } else {
       if ( detectionCarre() ) {
       dedansBoutonCarre = true ;
       image(vignette_OFF_in[wichVignette],mGB , mHB ) ;
     } else {
       image(vignette_OFF_out[wichVignette],mGB , mHB ) ;
     }
   }
 }
 
 
 //SOUND button
 void boutonSonPetit () {
   if ( JouerBoutonCarre ) {
     if ( detectionCarre() ) {
       //ON
       dedansBoutonCarre = true ;
       image(bouton[1],mGB , mHB ) ;
     } else {
       image(bouton[0],mGB , mHB ) ;
     }
   } else {
     //OFF
       if ( detectionCarre() ) {
       dedansBoutonCarre = true ;
       image(bouton[3],mGB , mHB ) ;
     } else {
       image(bouton[2],mGB , mHB ) ;
     }
   }
 }
 
 //ACTION Button
 void boutonAction ()
 {
   if ( JouerBoutonCarre ) {
     if ( detectionCarre() ) {
       dedansBoutonCarre = true ;
       image(bouton[11],mGB , mHB ) ;
     } else {
       image(bouton[10],mGB , mHB ) ;
     }
   } else {
       if ( detectionCarre() ) {
       dedansBoutonCarre = true ;
       image(bouton[13],mGB , mHB ) ;
     } else {
       image(bouton[12],mGB , mHB ) ;
     }
   }
 }
 
 //METEO Button
 void boutonMeteo()
 {
   if ( JouerBoutonCarre ) {
     if ( detectionCarre() ) {
       dedansBoutonCarre = true ;
       image(bouton[15],mGB , mHB ) ;
     } else {
       image(bouton[14],mGB , mHB ) ;
     }
   } else {
       if ( detectionCarre() ) {
       dedansBoutonCarre = true ;
       image(bouton[17],mGB , mHB ) ;
     } else {
       image(bouton[16],mGB , mHB ) ;
     }
   }
 }
 
 ///Bouton Texte
 void boutonTexte(String s, int x, int y)
 {
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
  // rect(x, y, 50, 50) ;
   text(s, x, y) ;
   //noStroke() ;
 }
 
 ////////////////////////////////////
 void boutonCarreEcran (String s, PVector pos)
 {
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
   rect(mGB, mHB, lB, hB) ;
   fill(blanc) ;
   text(s, mGB +pos.x, mHB + pos.y) ;
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
