


//COLOR
//GLOBAL
color rouge, rougeFonce, rougeTresFonce,   
      orange, 
      jaune, 
      vert, vertClair, vertFonce, vertTresFonce,
      bleu,
      violet,
      noir, noirGris,
      blanc, blancGrisClair, blancGris,  
      gris, grisClair , grisFonce, grisNoir, 
      
      typoCourante, typoTitre,
      //bouton
      boutonOFFin, boutonOFFout, boutonONin, boutonONout,
      //for the dropdown
      colorBoxIn, colorBoxOut, colorBoxText, colorBG ;


//SETUP
void colorSetup() {
   colorMode (HSB, 360,100,100 ) ; 
   blanc = color(0,0,95) ;            blancGrisClair = color( 0,0,85) ;  blancGris = color( 0,0,75) ; 
   grisClair = color(0,0, 65) ;       gris = color(0,0,50) ;             grisFonce = color(0,0,40)  ;     grisNoir = color(0,0,30) ;      
   noirGris = color (0,0,20) ;         noir = color (0,0,5) ;  
   vertClair = color (100,20,100) ;     vert = color(100,35,80) ;           vertFonce = color(100,100,50) ;     vertTresFonce = color(100,100,30) ;
   rougeTresFonce = color(10, 100, 50) ; rougeFonce = color (10, 100, 70) ;  rouge = color(10,100,100) ;           orange = color (35,100,100) ; 
   
   typoCourante = grisNoir ; typoTitre = noirGris ;
   boutonOFFin = orange ; boutonOFFout = rougeFonce ;
   boutonONin = vert ; boutonONout = vertFonce ;
   
   //dropdown
   colorBG = rougeTresFonce ;
   colorBoxIn =orange ; 
   colorBoxOut = rougeFonce ;
   colorBoxText = blancGrisClair ;
}
//END COLOR



//DRAW
//////RETURN////////////
boolean checkClavier(int c) {
  if (clavier.length >= c) {
    return clavier[c];  
  }
  return false;
}
////////VOID/////////////

////MIDI/////////////////
void controllerIn(promidi.Controller controller, int device, int channel){
  numMidi = controller.getNumber();
  valMidi = controller.getValue();
}

////////////////////
void mousePressed () {
  //object
  if(numGroup[1] > 0 ) for( int i = 11 ; i < numGroup[1] *10 + 6 ; i++ ) BOf[i].mousePressed()  ;
  if(numGroup[2] > 0 ) for( int i = 11 ; i < numGroup[2] *10 + 6 ; i++)  BTf[i].mousePressed() ;
  if(numGroup[3] > 0 ) for( int i = 11 ; i < numGroup[3] *10 + 6 ; i++)  BTYf[i].mousePressed() ;

  //son
  Bbeat.mousePressed() ;
  Bkick.mousePressed() ;
  Bsnare.mousePressed() ;
  Bhat.mousePressed() ;
  //midi
  BOmidi.mousePressed() ;
  //curtain
  BOcurtain.mousePressed() ;
  //dropdown
  dropdownMousepressed() ;

}


//KEYPRESSED
void keyPressed() {
  //OpenClose save
  OpenCloseSave() ;
}

//KEYRELEASED
void keyReleased() { 
  clavier[keyCode] = false;
}
