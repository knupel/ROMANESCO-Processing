


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
void colorSetup()
{
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
boolean checkClavier(int c)
{
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
void mousePressed ()
{
  //object
  for( int i = 11 ; i < 96 ; i++ ) BOf[i].mousePressed()  ;
  //texture
  for ( int i = 11 ; i < 76 ; i++)  BTf[i].mousePressed() ;
  //typo
  for ( int i = 11 ; i < 56 ; i++)  BTYf[i].mousePressed() ;

  //
  buttonMeteo.mousePressed() ;
  //son
  Bbeat.mousePressed() ;
  Bkick.mousePressed() ;
  Bsnare.mousePressed() ;
  Bhat.mousePressed() ;
  //midi
  BOmidi.mousePressed() ;
  //rideau
  BOrideau.mousePressed() ;
  //dropdown
  dropdownMousepressed() ;

}


//KEYPRESSED
void keyPressed() {
  //boxKeypressed() ;
  //OpenClose save
  OpenCloseSave() ;
}

//KEYRELEASED
void keyReleased() { 
  clavier[keyCode] = false;
}



//BOX WRITING
/*
void Texte (int posX, int posY, color couleur)
{
  //............boite
  boite (posX -3, posY -2, 70, width/3, 175 ) ; //x, y, hauteur boite, largeur boite, longueur bloc titre)
  fill (orange) ;
  textFont(DinBold,13);
  text("ZONE D'ÉCRITURE ", posX+59, posY+11);
  //...........Bouton 'envoi
  //BE1.boutonCarre () ;
  fill (blancGris) ;
  textFont(DinBold,11);
  text("Envoyer ", posX+7, posY+10); 
  //...........champs texte............................

  textFont(DinRegular,12);
  if((millis() % 1000) < 500) {  // Clignotement du curseur texte
    fill (couleur) ;
  }
  else {
    noFill();
  }

  float curseurPos;
  // Store the cursor rectangle's position
  curseurPos = textWidth(texte) + posX+2 ;
  // line( curseurPos+1 , posY -12 , curseurPos+1, posY);
  rect( curseurPos+1 , posY+18 , 1, 12);

  fill(0) ;
  pushMatrix() ;
  translate (curseurPos, posY+28 ) ;
  char t ;
  for(int i = 0 ; i < texte.length(); i++) {
    t = texte.charAt(i);
    //translate(textWidth(t),0);
    translate(-textWidth(t), 0) ;
    text(t,0,0);
  }
  popMatrix() ;

}
//box
void boite (int px, int py, int hb, int lb, int lt)
{
  pushMatrix() ;
  translate (px, py ) ;
  fill (rougeFonce ) ;  rect (0,0, lt, 17 ) ;      // place titre
                        rect (0,15, lb, hb ) ;     // place info
  fill (orange ) ;      rect (2,17, lb-4, hb-4 ) ;
  popMatrix() ;
}

//box keypressed
void boxKeypressed()
{
    //.........Fonction pour l'écriture du texte
  char k ;
  k = (char)key ;
  switch(k) 
  {
    case 8: //la touche delete
    if(texte.length() > 0)
    {
      texte = texte.substring(1);
    }
    break ;
      case 13:  // Avoid special keys
      case 10:
      case 65535:
      case 127:
      case 27:
    break;
    default :
    texte = k + texte ;
    break ;
  }
  
}
*/
//END BOX WRITING





//CHECK ACTIVITY
//GLOBAL
// Activity processor setting
boolean activity ;
int activityCount = 0 ;
int activityMidi = 0 ;
//DRAW
void activity()
{
  // activityCount = valMidi ;
  if (activityCount > 1000  ) activity = false ; else activity = true ;
  if (activity == false ) {
    noLoop() ;
  }
  //restart the activity of the controler
  if (mousePressed ) {
    loop() ; 
    activityCount = 0 ;
    activity = true ;
  //  chargement = false ;
  }
  activityCount ++ ;
}

//restart the activity after stop
void restart()
{
  loop() ; 
  activityCount = 0 ;
  activity = true ;
}
