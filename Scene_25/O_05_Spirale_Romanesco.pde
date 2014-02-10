//GLOBAL
RomanescoFive romanescoFive ;

//SETUP
void romanescoFiveSetup() {
    //MUST CHANGE THE ID
  //Example : If it's RomanestoThirtySetup int ID = 30 ;
  int ID = 5 ; // 0 is Ref you must use a number is the order of apparition in the controleur, start from top left and follow the horizontal line
  
  int IDfamilly = 1 ; // 0 is global // 1 is single object // 2 is trame // 3 is typo
  romanescoFive = new RomanescoFive (ID, IDfamilly) ;

  romanescoFive.setting() ;
}

//DRAW
void romanescoFiveDraw(String [] dataControleur, String [] dataMinim) {
  romanescoFive.getID() ;
  romanescoFive.data(dataControleur, dataMinim) ;
  romanescoFive.display() ;
}

//Return the ID familly to choice the data must be send to the class // 0 is global // 1 is Object // 2 is trame // 3 is typo
int getFamillyRomanescoFive() { return romanescoFive.getIDfamilly() ; }

////////////
//CLASS////
//GLOBAL
// here you can put your array list for example

//////////////////////////////////////////
class RomanescoFive extends SuperRomanesco 
{
  //FORBIDEN TO TOUCH
  int IDfamilly ;
  // class
  Spirale spirale ;
  //speed
  float speed ;
  //CONSTRUCTOR
  RomanescoFive(int ID, int IDfamilly) {
    super(ID) ;
    this.IDfamilly = IDfamilly ;
  }
  //END CONSTRUCTOR
  
  ////SETUP
  /////////
  void setting() {
    spirale = new Spirale() ;
  }
  ///////////
  //END SETUP
  
  
  
  //////DRAW
  //display
  void display() {
    // starting position
    if (startingPosition[IDobj]) startPosition(IDobj, width/2, height/2, 0) ;
    //DON'T TOUCH
    pushMatrix() ;
    //P3D Give the position and the orientation of your object in the 3 dimensionals space
    P3Dmanipulation(IDobj) ;
    //END OF DON'T TOUCH
    
    //////////////////////
    //HERE IT'S FOR YOU
    //quantity
    int n ;
    int nMax = 20 + ( int(valueObj[IDobj][14]) * 3 ) ;
    n = nMax ;
    //amplitude
    float ratioScreen = height - 400 ;
    if (ratioScreen < 1 ) ratioScreen = 1 ;
    float ratio = 1.25 + (ratioScreen *.0005) ;  
    float z = map(valueObj[IDobj][17], 0,100,1.01, ratio)  ;
    //vitesse
    if(motion[IDobj]) speed = valueObj[IDobj][16] *tempo[IDobj] ; else speed = 0.0 ;
    //sound volume
    float volumeG = map (gauche[IDobj], 0,1, 0.5, 1.5 ) ;
    float volumeD = map (droite[IDobj], 0,1, 0.5, 1.5 ) ;
    
    float hauteur = width  *valueObj[IDobj][11]  *volumeG *0.0005 *kick[IDobj] ;
    float largeur = height *valueObj[IDobj][12]  *volumeD *0.0005 *hat[IDobj] ;
    //thickness
    float e = map(valueObj[IDobj][13],0,100,0.1, height*.2 ) ;
    //color
    color colorIn = color ( map(valueObj[IDobj][1],0,100,0,360), valueObj[IDobj][2], valueObj[IDobj][3],valueObj[IDobj][4] ) ;
    color colorOut = color ( map(valueObj[IDobj][5],0,100,0,360), valueObj[IDobj][6], valueObj[IDobj][7],valueObj[IDobj][8] ) ;
    //mode
    //display mode
    int mode = modeButton[IDobj] ;
    
    spirale.actualisation (mouse[IDobj].x , mouse[IDobj].y, speed) ;
    spirale.affichage (n, nMax, hauteur, largeur, z, colorIn, colorOut, e, mode) ;
    
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
