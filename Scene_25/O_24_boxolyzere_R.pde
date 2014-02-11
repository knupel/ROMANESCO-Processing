//GLOBAL
RomanescoTwentyFour romanescoTwentyFour ;
//SETUP
void romanescoTwentyFourSetup() {
  // YOU MUST CHANGE THE ID
  //Example : If it's RomanestoThirtySetup int ID = 30 ;
  int ID = 24 ; // 0 is Ref you must use a number in the order of apparition in the controleur, start from top left and follow the horizontal line
  
  int IDfamilly = 2 ; // 1 is single object // 2 is trame // 3 is typo    ....... // 0 is global don't use this one it's for specific stuff
  romanescoTwentyFour = new RomanescoTwentyFour (ID, IDfamilly) ;

  romanescoTwentyFour.setting() ;
}

//DRAW
void romanescoTwentyFourDraw(String [] dataControleurLocal, String [] soundDataLocal) {
  romanescoTwentyFour.getID() ;
  romanescoTwentyFour.data(dataControleurLocal, soundDataLocal) ;
  romanescoTwentyFour.display() ;
}



//Return the ID familly to choice the data must be send to the class // 0 is global // 1 is Object // 2 is trame // 3 is typo
int getFamillyRomanescoTwentyFour() { return romanescoTwentyFour.getIDfamilly() ; }

////////////
//CLASS////
//GLOBAL
//////////////////////////////////////////
class RomanescoTwentyFour extends SuperRomanesco 
{
  int IDfamilly ;

  ArrayList<BOITEaMUSIQUE> boiteList ;
  boolean newDistribution ;
  boolean horizon ; 
  int numBoxRef ;
  
  //CONSTRUCTOR
  RomanescoTwentyFour(int ID, int IDfamilly) {
    super(ID) ;
    this.IDfamilly = IDfamilly ;
  }
  //END CONSTRUCTOR
  
  ////SETUP
  //the setting that's stuff that you'r put usually in the void setup() 
  void setting() {
    //motion is true by default is better the object move when you switch on this one
    motion[IDobj] = true ;
    
    // YOUR SETTING OBJECT :
    ////////////////////////    
    // by default is (0,0,0) if you want a specficic starting position, you can give coordonate here
    mouse[IDobj] = new PVector (30, height *.33, 0) ;
    // Just in case you use a class need to be clear in your object
    boitesSetting() ;
  }
  ///////////
  //END SETUP
  
  
  /////////
  //DISPLAY 
  void display() {
    pushMatrix() ;
    P3Dmanipulation(IDobj) ;

    color colorIn = color ( map(valueObj[IDobj][1],0,100,0,360), valueObj[IDobj][2], valueObj[IDobj][3],valueObj[IDobj][4] ) ;
    color colorOut = color ( map(valueObj[IDobj][5],0,100,0,360), valueObj[IDobj][6], valueObj[IDobj][7],valueObj[IDobj][8] ) ;
    float thickness = map (valueObj[IDobj][13],0,100, .2, height *.1) ;
    //CLASSIC DISPLAY
    int numBox = int(map(valueObj[IDobj][14],0,100,1,16)) ;
    if (numBox != numBoxRef ) newDistribution = true ;
    numBoxRef = numBox ;
    if (hTouch && actionButton[IDobj] == 1 ) if (horizon) horizon = false ; else horizon = true ;
    boitesDraw(horizon, newDistribution, numBox, colorIn, colorOut, thickness) ;
    
    //END YOUR WORK
    
    // MODE DISPLAY with the dropdown menu of controler
    /////////////////////
    if (modeButton[IDobj] == 0 || modeButton[IDobj] == 255 ) {
      //// just for information we use 0 to display the mode 1...same for the next mode +1...
    } else if (modeButton[IDobj] == 1 ) {
    } else if (modeButton[IDobj] == 2 ) {
    // and same for the next
    }

    popMatrix() ;
    //END of MODE DISPLAY
    /////////////////////
    
    
    //ADD OBJECT from keyboard, press "N" for new one
    //to spawn one thing
    if(actionButton[IDobj] == 1 && nTouch) { /* yourList.add( new YourClass ()); */ }
    //to spaw few things, you can add a modulo if you want
    int spawnFrequency = 3 ; 
    if(actionButton[IDobj] == 1 && nLongTouch && frameCount % spawnFrequency == 0 ) { /* yourList.add( new YourClass ()); */ }
    //END ADD OBJECT
    
  }
  //END DRAW
  //////////
  
  //ANNEXE VOID
  void boitesSetting() {
    boiteList = new ArrayList<BOITEaMUSIQUE>();
  }



  void boitesDraw(boolean ground, boolean distribution, int n, color cIn, color cOut, float thicknessLocal) {
     if (distribution) newDistributionBoite(n) ;
     newDistribution = false ;
     displayBoite(ground, cIn, cOut, thicknessLocal) ;
  
  }
    
  void displayBoite(boolean groundPosition, color cIn, color cOut, float thicknessLocal) {
    PVector pos = new PVector(0,height /2 ,0) ;
    float factorSpectrum = 0 ;
    int n = boiteList.size() ;
    for( int i = 0 ; i < n ; i++) {
      pos.x = (i *width/n) + (width/(n*2)) ;
      if(  i < band.length) factorSpectrum = band [IDobj][i] ;
      BOITEaMUSIQUE boiteAmusique = (BOITEaMUSIQUE) boiteList.get(i) ;
      boiteAmusique.showTheBoite(pos, factorSpectrum, groundPosition, cIn, cOut, thicknessLocal) ;
    }
  }
  
  
  void newDistributionBoite(int n) {
    boiteList.clear() ;
    for (int i = 0 ; i < n ; i++ ) addBoite(i) ;
  }
  
  void addBoite(int ID) {
    PVector size = new PVector (20,50,20) ;
    BOITEaMUSIQUE boiteAmusique = new BOITEaMUSIQUE(size, ID) ; 
    boiteList.add(boiteAmusique) ;
  }
  
  
  

  
  
  
  
  
  /////////////////////////////
  //FORDIDEN TO TOUCH THIS VOID
  /////////////////////////////
  //DATA VOID
  void data( String [] dataControlerLocal, String [] dataSoundLocal) {
    super.data(dataControlerLocal, dataSoundLocal) ;
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





///////
//CLASS
class BOITEaMUSIQUE {
  PVector pos = new PVector(0,0,0) ;
  PVector size = new PVector (0,0,0) ;
  int ID ;
  
  BOITEaMUSIQUE(PVector size, int ID) {
    this.ID = ID ;
    this.size = size ;
  }
  
  void showTheBoite(PVector pos, float factor, boolean groundLine, color cIn, color cOut, float thicknessLocal) {
    PVector newSize = new PVector (size.x, size.y *factor,size.z *factor ) ;
    //put the box on the ground !
    float horizon = pos.y - ( newSize.y *.5 ) ;
    fill(cIn ) ;
    stroke(cOut) ;
    strokeWeight(thicknessLocal) ;   
    pushMatrix() ;
    if (!groundLine) translate(pos.x, pos.y, pos.z) ; else translate(pos.x, horizon, pos.z) ;
    box(newSize.x,newSize.y,newSize.z) ;
    popMatrix() ;
  }
}
