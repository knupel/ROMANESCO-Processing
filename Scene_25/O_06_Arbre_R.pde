//GLOBAL
RomanescoSix romanescoSix ;
//Just in case you use a class in your object



//SETUP
void romanescoSixSetup() {
    //MUST CHANGE THE ID
  //Example : If it's RomanestoThirtySetup int ID = 30 ;
  int ID = 6 ; // 0 is Ref you must use a number is the order of apparition in the controleur, start from top left and follow the horizontal line
  
  int IDfamilly = 1 ; // 1 is single object // 2 is trame // 3 is typo    ....... // 0 is global don't use this one it's for specific stuff
  romanescoSix = new RomanescoSix (ID, IDfamilly) ;

  romanescoSix.setting() ;
}

//DRAW
void romanescoSixDraw(String [] dataControleur, String [] dataMinim) {
  romanescoSix.getID() ;
  romanescoSix.data(dataControleur, dataMinim) ;
  romanescoSix.display() ;
}

//MOUSEPRESSED
void romanescoSixMousepressed() { romanescoSix.mousepressed() ; }
//MOUSERELEASED
void romanescoSixMousereleased() { romanescoSix.mousereleased() ; }
//MOUSE DRAGGED
void romanescoSixMousedragged() { romanescoSix.mousedragged() ; }
//KEYPRESSED
void romanescoSixKeypressed() { romanescoSix.keypressed() ; }
//KEY RELEASED
void romanescoSixKeyreleased() { romanescoSix.keyreleased() ; }

//Return the ID familly to choice the data must be send to the class // 0 is global // 1 is Object // 2 is trame // 3 is typo
int getFamillyRomanescoSix() { return romanescoSix.getIDfamilly() ; }

////////////
//CLASS////
//GLOBAL
// here you can put your array list for example

//////////////////////////////////////////
class RomanescoSix extends SuperRomanesco 
{
  int IDfamilly ;
  //class
  Arbre arbre ;
  PVector posArbre = new PVector (random(width), random(height) ) ;
  //CONSTRUCTOR
  RomanescoSix(int ID, int IDfamilly) {
    super(ID) ;
    this.IDfamilly = IDfamilly ;
  }
  //END CONSTRUCTOR
  
  ////SETUP
  /////////
  void setting() {
    //class
    arbre = new Arbre () ;
  }
  ///////////
  //END SETUP
  
  
  
  //////DRAW
  //display
  void display() {
    // starting position
    if (startingPosition[IDobj]) startPosition(IDobj, width/2, height/2, 0) ;
    
    pushMatrix() ;
    //P3D Give the position and the orientation of your object in the 3 dimensionals space
    P3Dmanipulation(IDobj) ;
    //thickness
    int epaisseur = 1 + int( valueObj[IDobj][13] *.33 ) ;
    float g = map(gauche[IDobj], -1, 1, 0, 5) ;
    float d = map(droite[IDobj], -1, 1, 2, 7) ;
    int ng = round(g);
    int nd = round( d );
    int propA = ng ;
    int propB =  nd ;
    
    //diameter of the first shape
    int diam = 1 + (int(valueObj[IDobj][11])* (ng + nd ) ) ;
    int fourcheA = nd  ; 
    int fourcheB = ng ;
    //orientation
    float direction = valueObj[IDobj][18] * 3.6 ;
    //amplitude
    float ampSon ;
    if(soundButton[IDobj] == 1 ) ampSon = map (abs(mix[IDobj]), 0, 1, .1 ,4) ; else ampSon = 1.0 ;
    float amplitude = map(valueObj[IDobj][17], 0,100, 0,height *.2) *ampSon ;
    int n = (ng+nd) ;
    //quantity
    float quantityNode = map(valueObj[IDobj][14],0,100,2,32) ;
    int maxNode = int(quantityNode) ;
    if ( n>maxNode ) { n = maxNode ; } ;
    
    color colorIn = color ( map(valueObj[IDobj][1],0,100,0,360), valueObj[IDobj][2], valueObj[IDobj][3],valueObj[IDobj][4] ) ;
    color colorOut = color ( map(valueObj[IDobj][5],0,100,0,360), valueObj[IDobj][6], valueObj[IDobj][7],valueObj[IDobj][8] ) ;
    //display mode
    int mode = modeButton[IDobj] ;
    // angle
    float angle = map(valueObj[IDobj][28],0,100,0,90);
    
    arbre.affichage (direction) ;
    //if (!spaceTouch ) arbre.actualisation(mouse[IDobj], colorIn, colorOut, epaisseur, diam, propA, propB, fourcheA, fourcheB, amplitude, n, mode, int(angle)) ;
    posArbre = new PVector (mouse[IDobj].x, mouse[IDobj].y) ;
    arbre.actualisation(posArbre, colorIn, colorOut, epaisseur, diam, propA, propB, fourcheA, fourcheB, amplitude, n, mode, int(angle)) ;
    
    
    //IT'S THE END FOR YOU
    //////////////////////
    
    //DON'T TOUCH
    popMatrix() ;
    //END OF DON'T TOUCH
  }
  //END DRAW
  
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









//////////////////
//CLAS ARBRE
class Arbre
{
  Arbre()
  {
  }
  int vR = 1 ;  ;
  float theta, angleDirection ;
  int rotation = 90  ;
  float direction   ;
 
//::::::::::::::::::::  
  void affichage (float d)
  {
  direction = d ;
  }
//::::::::::::::::::::::::::::  
  void actualisation (PVector posArbre, color cIn, color cOut, int e, int nombre, int propA, int propB, int fourcheA, int fourcheB, float amplitude, int n, int mode, float angle) {
    rotation += vR ;
    // float newAngle = 180 - angle ;
    if ( rotation > angle + 90  ) vR*=-1 ; else if ( rotation < angle ) vR*=-1 ; 
    angle = rotation ; // de 0 à 180
    // Convert it to radians
    theta = radians(angle);
  
    angleDirection = radians (direction) ;
    pushMatrix () ;
    translate(posArbre.x,posArbre.y);
    // Start the recursive branching
    rotate (angleDirection) ;
    branch(cIn, cOut, e, nombre, propA, propB, fourcheA, fourcheB, amplitude, n, mode);
    popMatrix () ;
    
  }
//::::::::::::::::::::::::::::  
  void branch(color colorIn, color colorOut, float e, float proportion, int propA, int propB, int fourcheA, int fourcheB, float amplitude, int n, int mode) {
    proportion *= random (propA, propB ) / 10 ;
    float fourche = random (0,10) ;
    stroke ( colorOut ) ;
    fill ( colorIn ) ;
    
    //En cours pour vérifier la fin de la boucle qui bug qd celle-ci est trop grande.
    if ( e < 0.1 ) e = 0.1 ;
    if( proportion < 1 ) proportion = 1 ;
    
    
    n = n-1 ;
    // Toutes fonctions répétitives doit posséder une sortie, ici une taille inférieure à 2
    if (n > 0) {
      if (fourche < fourcheA  ) displayBranch(colorIn, colorOut, e, proportion, propA, propB, fourcheA, fourcheB, amplitude, n, -theta, mode) ; 
                           else displayBranch(colorIn, colorOut,e, proportion, propA, propB, fourcheA, fourcheB, amplitude, n, theta, mode) ;
    }
  }
  
  //annexe branch
  void displayBranch(color colorIn, color colorOut,float e, float proportion, int propA, int propB, int fourcheA, int fourcheB, float amplitude, int n, float t, int mode)
  {
    pushMatrix();    // Save the current state of transformation (i.e. where are we now)
    rotate(t);   // Rotate by theta

    strokeWeight (e ) ;
     if (mode == 0  ) line(0, 0, 0, -amplitude);  // Draw the branch
    if (mode == 1 ) ellipse(0,0, proportion  , proportion  ) ;
    if (mode == 2  ) {  ellipse(0,0, proportion  , proportion  ) ; line(0, 0, 0, -amplitude); }
    if (mode == 3 ) rect(0,0, proportion  , proportion  ) ;
    if (mode == 4  ) {  rect(0,0, proportion  , proportion  ) ; line(0, 0, 0, -amplitude); }
    translate(0, -amplitude); // Move to the end of the branch
    branch(colorIn, colorOut, e, proportion, propA, propB, fourcheA, fourcheB, amplitude, n, mode);       // Ok, now call myself to draw two new branches!!
    popMatrix();     // Whenever we get back here, we "pop" in order to restore the previous matrix state
  }
}
