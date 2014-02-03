//GLOBAL
RomanescoTwentyThree romanescoTwentyThree ;
////////////////////////////////////////////////////////////////////
// Just in case you use a class must use an ArrayList in your object, 
// if it's not call the class in the class RomanescoTwentyThree just bellow

ArrayList partRectList = new ArrayList() ;


//SETUP
void romanescoTwentyThreeSetup() {
    //MUST CHANGE THE ID
  //Example : If it's RomanestoThirtySetup int ID = 30 ;
  int ID = 23 ; // 0 is Ref you must use a number is the order of apparition in the controleur, start from top left and follow the horizontal line
  
  int IDfamilly = 2 ; // 1 is single object // 2 is trame // 3 is typo    ....... // 0 is global don't use this one it's for specific stuff
  romanescoTwentyThree = new RomanescoTwentyThree (ID, IDfamilly) ;

  romanescoTwentyThree.setting() ;
}

//DRAW
void romanescoTwentyThreeDraw(String [] dataControleur, String [] dataMinim) {
  romanescoTwentyThree.getID() ;
  romanescoTwentyThree.data(dataControleur, dataMinim) ;
  romanescoTwentyThree.display() ;
}

//MOUSEPRESSED
void romanescoTwentyThreeMousepressed() { romanescoTwentyThree.mousepressed() ; }
//MOUSERELEASED
void romanescoTwentyThreeMousereleased() { romanescoTwentyThree.mousereleased() ; }
//MOUSE DRAGGED
void romanescoTwentyThreeMousedragged() { romanescoTwentyThree.mousedragged() ; }
//KEYPRESSED
void romanescoTwentyThreeKeypressed() { romanescoTwentyThree.keypressed() ; }
//KEY RELEASED
void romanescoTwentyThreeKeyreleased() { romanescoTwentyThree.keyreleased() ; }

//Return the ID familly to choice the data must be send to the class // 0 is global // 1 is Object // 2 is trame // 3 is typo
int getFamillyRomanescoTwentyThree() { return romanescoTwentyThree.getIDfamilly() ; }

////////////
//CLASS////
//GLOBAL
//////////////////////////////////////////
class RomanescoTwentyThree extends SuperRomanesco 
{
  //FORBIDEN TO TOUCH
  int IDfamilly ;
  //END OF FORBIDEN ZONE
  
  //CONSTRUCTOR
  RomanescoTwentyThree(int ID, int IDfamilly) {
    super(ID) ;
    this.IDfamilly = IDfamilly ;
    ///////IMPORTANT////////////////////////////////////
    //to call external class or library in class, now we must use "callingClass" like "this"
    /* name = new LibraryOrClass(callingClass); */
  }
  //END CONSTRUCTOR
  
  ////SETUP
  //the setting that's stuff that you'r put usually in the void setup() 
  void setting() {
    //motion
    motion[IDobj] = true ;
  }
  ///////////
  //END SETUP
    
    
  //display
  void display() {
    // starting position
    //if (startingPosition[IDobj]) startPosition(IDobj, 0, 0, 0) ;
    //DON'T TOUCH
    pushMatrix() ;
    //P3D Give the position and the orientation of your object in the 3 dimensionals space
    P3Dmanipulation(IDobj) ;
    
    //END OF DON'T TOUCH
    //speed / vitesse
    float vitesse = 0.01 + (valueObj[IDobj][16] *0.001) ;
    //durée / life
    int vie = 100 + (100 * int(valueObj[IDobj][15])) ;
    //thickness / épaisseur
    int epaisseur = 1 + int((valueObj[IDobj][13] *.5) + abs(mix[IDobj]) *10);
    
    float hauteur = map(valueObj[IDobj][11], 0, 100, 0, height*2) ;
    //Color
    float opacityIn = round(valueObj[IDobj][4] + ((mix[IDobj]) *25 )) ;
    float opacityOut = valueObj[IDobj][8] ;
    color colorIn = color ( map(valueObj[IDobj][1],0,100,0,360), valueObj[IDobj][2], valueObj[IDobj][3],valueObj[IDobj][4] ) ;
    color colorOut = color ( map(valueObj[IDobj][5],0,100,0,360), valueObj[IDobj][6], valueObj[IDobj][7],valueObj[IDobj][8] ) ;
    
   //orientation / degré
   rotation(valueObj[IDobj][18], (mouse[IDobj].x *2) -width/2  , (mouse[IDobj].y *2) -height/2 ) ;
    
    for (int i=0 ; i < partRectList.size(); i++) {
      TrameP P = (TrameP) partRectList.get(i); // GET donne l'ordre d'aller chercher de la particule dans le la Valise Fourre Tout
      if (P.disparition () ) {
        partRectList.remove (i) ;
      } else {
        P.actualisation ();
        P.drawRect(colorIn, colorOut, opacityIn, opacityOut, epaisseur, hauteur) ;
      }
    }
    if (actionButton[IDobj] == 1 && nTouch) {
      partRectList.add( new TrameP(vitesse, vie )) ;
    }

    
    /////////////////////////////
    //CLEAR THE LIST IF NECESSARY 
    if (romanescoEmptyList(IDobj)) {}
    //IT'S THE END FOR YOU
    //////////////////////
    
    //DON'T TOUCH
    popMatrix() ;
    //END OF DON'T TOUCH
  }
  //END DRAW
  //////////
  
  
  
  
  
  
  //KEYPRESSED
  void keypressed() {}
  //KEY RELEASED
  void keyreleased() {}
  //MOUSEPRESSED
  void mousepressed() {}
  //MOUSE RELEASED
  void mousereleased() {}
  //MOUSE DRAGGED
  void mousedragged() {}
  
  
  //ANNEXE VOID
  void annexe() {}
  
  
  
  
  
  /////////////////////////////
  //FORDIDEN TO TOUCH THIS VOID
  /////////////////////////////
  //DATA VOID
  void data( String [] dataControler, String [] dataMinin) {
    super.data(dataControler, dataMinin) ;
  }
  ////////////
  //Return ID
  int getID() {
    return IDobj ;
  }
  int getIDfamilly() {
    return IDfamilly ;
  }
  ///////////////////////////
  //////////////////////////
}
////////////////////
//END ROMANESCO





//////////////
//CLASS TrameP
class TrameP 
{ 
  int chrono, transp, transpb ;
  int vp ;
  float croissance, v, mvt, posX ; 
  TrameP(float vitesse, int vie)  
  {
   v = vitesse ; vp = vie ; 
  }
  
  boolean disparition () 
  {
    if (vp < 0 ) {
      return true ;
    } else {
      return false ;
    }
  }
  void actualisation() {
    
    mvt += v ;
    posX += mvt ;
    if (posX > width ) { 
      posX = width  ;  
      mvt*=-1 ;
      mvt = mvt - v ;
    } else if (posX < 0 ) { 
      posX = 0 ;       
      mvt*=-1 ;
    }
  }

  void drawRect (color cIn, color cOut, float oIn, float oOut, float e, float h) {
    //security for the negative valu
    if( e < 0.1 ) e = 0.1 ;

    if (vp < oIn )   { oIn = vp ;   } else { oIn = oIn ; }
    if (vp < oOut )  { oOut = vp ;  } else { oOut = oOut ; }
    
    //life
    vp = vp + chrono ;
    chrono = -1 ; 
    
    //DISPLAY
    strokeWeight(e) ;
    fill ( cIn, oIn ) ;
    stroke (cOut, oOut ) ;
    rect ( posX ,  -e, posX - (mouseX/3) , h+(2*e) ) ;
  }
}
