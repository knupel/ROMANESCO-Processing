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
  //speed
  float speed ;
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
    
    //size
    float x = map(valueObj[IDobj][21],0,100, 1, height ) * (ng + nd ) ;
    float y = map(valueObj[IDobj][22],0,100, 1, height ) * (ng + nd ) ;
    float z = map(valueObj[IDobj][23],0,100, 1, height ) * (ng + nd ) ;
    PVector size  = new PVector(x,y,z  ) ;
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
    // speed
    if(motion[IDobj]) {
      float s = map(valueObj[IDobj][16],0,100,0,2) ;
      s *= s ;
      speed = s *tempo[IDobj] ; 
    } else { 
      speed = 0.0 ;
    }
    
    arbre.affichage (direction) ;
    posArbre = new PVector (mouse[IDobj].x, mouse[IDobj].y) ;
    arbre.actualisation(posArbre, colorIn, colorOut, epaisseur, size, propA, propB, fourcheA, fourcheB, amplitude, n, mode, int(angle), speed) ;
    
    
    //IT'S THE END FOR YOU
    //////////////////////
    
    //DON'T TOUCH
    popMatrix() ;
    //END OF DON'T TOUCH
  }
  //END DRAW

  
  
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
//CLASS ARBRE
class Arbre
{
  Arbre() {}
  // int vR = 1 ;  ;
  float theta, angleDirection ;
  float rotation = 90.0  ;
  float direction   ;
 
//::::::::::::::::::::  
  void affichage (float d) {
    direction = d ;
  }
//::::::::::::::::::::::::::::  
  void actualisation (PVector posArbre, color cIn, color cOut, int e, PVector size, int propA, int propB, int fourcheA, int fourcheB, float amplitude, int n, int mode, float angle, float speed) {
    rotation += speed ;
    // float newAngle = 180 - angle ;
    if ( rotation > angle + 90  ) speed*=-1 ; else if ( rotation < angle ) speed*=-1 ; 
    angle = rotation ; // de 0 à 180
    // Convert it to radians
    theta = radians(angle);
  
    angleDirection = radians (direction) ;
    pushMatrix () ;
    translate(posArbre.x,posArbre.y);
    // Start the recursive branching
    rotate (angleDirection) ;
    branch(cIn, cOut, e, size, propA, propB, fourcheA, fourcheB, amplitude, n, mode);
    popMatrix () ;
    
  }
//::::::::::::::::::::::::::::  
  void branch(color colorIn, color colorOut, float e, PVector proportion, int propA, int propB, int fourcheA, int fourcheB, float amplitude, int n, int mode) {
    proportion.x *= random (propA, propB ) / 10 ;
    float fourche = random (0,10) ;
    stroke ( colorOut ) ;
    fill ( colorIn ) ;
    
    //En cours pour vérifier la fin de la boucle qui bug qd celle-ci est trop grande.
    if ( e < 0.1 ) e = 0.1 ;
    if( proportion.x < 1 ) proportion.x = 1 ;
    
    
    n = n-1 ;
    // Toutes fonctions répétitives doit posséder une sortie, ici une taille inférieure à 2
    if (n > 0) {
      if (fourche < fourcheA  ) displayBranch(colorIn, colorOut, e, proportion, propA, propB, fourcheA, fourcheB, amplitude, n, -theta, mode) ; 
                           else displayBranch(colorIn, colorOut,e, proportion, propA, propB, fourcheA, fourcheB, amplitude, n, theta, mode) ;
    }
  }
  
  //annexe branch
  void displayBranch(color colorIn, color colorOut,float e, PVector proportion, int propA, int propB, int fourcheA, int fourcheB, float amplitude, int n, float t, int mode) {
    pushMatrix();    // Save the current state of transformation (i.e. where are we now)
    rotate(t);   // Rotate by theta

    strokeWeight (e ) ;
     if (mode == 0  ) line(0, 0, 0, -amplitude);  // Draw the branch
    if (mode == 1 ) ellipse(0,0, proportion.x  , proportion.x  ) ;
    if (mode == 2  ) {  ellipse(0,0, proportion.x  , proportion.x  ) ; line(0, 0, 0, -amplitude); }
    if (mode == 3 ) rect(0,0, proportion.x  , proportion.x  ) ;
    if (mode == 4  ) {  rect(0,0, proportion.x  , proportion.x  ) ; line(0, 0, 0, -amplitude); }
    if (mode == 5  ) box(proportion.x  , proportion.x  , proportion.x  ) ;
    translate(0, -amplitude); // Move to the end of the branch
    branch(colorIn, colorOut, e, proportion, propA, propB, fourcheA, fourcheB, amplitude, n, mode);       // Ok, now call myself to draw two new branches!!
    popMatrix();     // Whenever we get back here, we "pop" in order to restore the previous matrix state
  }
}
