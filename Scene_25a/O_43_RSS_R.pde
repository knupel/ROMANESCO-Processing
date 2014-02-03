//GLOBAL
RomanescoFortyThree romanescoFortyThree ;
////////////////////////////////////////////////////////////////////
// Just in case you use a class must use an ArrayList in your object, 
// if it's not call the class in the class RomanescoFortyThree just bellow
/*
ArrayList<YourClass> yourList ;
*/



//SETUP
void romanescoFortyThreeSetup() {
  // YOU MUST CHANGE THE ID
  //Example : If it's RomanestoThirtySetup int ID = 30 ;
  int ID = 43 ; // 0 is Ref you must use a number in the order of apparition in the controleur, start from top left and follow the horizontal line
  
  int IDfamilly = 3 ; // 1 is single object // 2 is trame // 3 is typo    ....... // 0 is global don't use this one it's for specific stuff
  romanescoFortyThree = new RomanescoFortyThree (ID, IDfamilly) ;

  romanescoFortyThree.setting() ;
}

//DRAW
void romanescoFortyThreeDraw(String [] dataControleur, String [] dataMinim) {
  romanescoFortyThree.getID() ;
  romanescoFortyThree.data(dataControleur, dataMinim) ;
  romanescoFortyThree.display() ;
}

//MOUSEPRESSED
void romanescoFortyThreeMousepressed() { romanescoFortyThree.mousepressed() ; }
//MOUSERELEASED
void romanescoFortyThreeMousereleased() { romanescoFortyThree.mousereleased() ; }
//MOUSE DRAGGED
void romanescoFortyThreeMousedragged() { romanescoFortyThree.mousedragged() ; }
//KEYPRESSED
void romanescoFortyThreeKeypressed() { romanescoFortyThree.keypressed() ; }
//KEY RELEASED
void romanescoFortyThreeKeyreleased() { romanescoFortyThree.keyreleased() ; }

//Return the ID familly to choice the data must be send to the class // 0 is global // 1 is Object // 2 is trame // 3 is typo
int getFamillyRomanescoFortyThree() { return romanescoFortyThree.getIDfamilly() ; }

////////////
//CLASS////
//GLOBAL
//////////////////////////////////////////
class RomanescoFortyThree extends SuperRomanesco 
{
  //FORBIDEN TO TOUCH
  int IDfamilly ;
  //END OF FORBIDEN ZONE
  
  ////////////////////////////////////////////////
  // YOUR VARIABLE OBJECT 
  // and CALL YOUR OWN CLASS HERE 
  // if it's not class that use an ArrayList
  /*
  int var ; float var ; // etc
  YourClass yourClass ;
  */
  FeedReader flux;
  String RSSliberation, RSSlemonde;
  float Rinfo ;
  int info = 0 ; 
  String messageRSS ; // messahe venant du flux RSS si internet il y a  !!!!
  //CONSTRUCTOR
  RomanescoFortyThree(int ID, int IDfamilly) {
    super(ID) ;
    this.IDfamilly = IDfamilly ;
    ///////IMPORTANT////////////////////////////////////
    //to call external class or library in class, 
    //now we must use "callingClass" like "this"
    /*
    name = new LibraryOrClass(callingClass);
    */
  }
  //END CONSTRUCTOR
  
  ////SETUP
  //the setting that's stuff that you'r put usually in the void setup() 
  void setting() {
    font[IDobj] = font[0] ;
    
    String [] fluxRSS = loadStrings(sketchPath("")+"RSSReference.txt") ;
    String RSS = join(fluxRSS, "") ;
    flux = new FeedReader(RSS);
  }
  ///////////
  //END SETUP
  

  
  //////DRAW
  //display
  void display() {
    // starting position
    if (startingPosition[IDobj]) startPosition(IDobj, width/2, height/2, 0) ;
    // if you use font in your object
    if (parameterButton[IDobj] == 1 ) font[IDobj] = font[0] ;
    //////////////////////
    //HERE IT'S FOR YOU
    
    //ENGINE OF VOID
    float corps ;
    //size text / corps
    corps = map(valueObj[IDobj][28], 0, 100, 6, height *0.33) ;
    textFont(font[IDobj], corps + ( corps * mix[IDobj]) );
    // couleur du texte
    float t = valueObj[IDobj][4] * abs(mix[IDobj]) ;
    if ( soundButton[IDobj] != 1 ) { t = valueObj[IDobj][4] ; } 
    //color
    color colorIn = color (map(valueObj[IDobj][1],0,100,0,360), valueObj[IDobj][2], valueObj[IDobj][3], t ) ;
    
    //hauteur largeur, height & width
    float hauteur = map (valueObj[IDobj][11], 0, 100, 0, height *3 ) ;
    float largeur = map (valueObj[IDobj][12], 0, 100, 0, width *3 ) ;
    
    //ADD new object
    if (actionButton[IDobj] == 1 && nTouch ) {}
    
    
    //DISPLAY OBJECT
    ///////////////
    //DON'T TOUCH
    pushMatrix() ;
    //P3D Give the position and the orientation of your object in the 3 dimensionals space
    P3Dmanipulation(IDobj) ;
    //END OF DON'T TOUCH
    
    // you can use a direct display or mode display to switch what you want display with a same engine object
    //CLASSIC DISPLAY
    ////////////////
    //rotation / degré
    
    fill(colorIn) ;
      
    for( int i=info; i < info + 1; i++) {
      //internet = false ;
      if (internet && presceneOnly) messageRSS =  (i +""+flux.entry[i]) ; else messageRSS = bigBrother ;
      int r ;
      if ( i > 9 ) r =2 ; else if( i > 0 && i < 10 ) r =1 ; else r =0 ; 
      String hune = messageRSS.substring(r);
      //rotation / degré
      rotation(valueObj[IDobj][18], mouse[IDobj].x, mouse[IDobj].y) ;
      text(hune, 0, 0, largeur, hauteur );
    }

   
    
    //CHANGE MODE DISPLAY
    /////////////////////
    if (modeButton[IDobj] == 0 || modeButton[IDobj] == 255 ) {
      //
    } else if (modeButton[IDobj] == 1 ) {
      //
    } else if (modeButton[IDobj] == 2 ) {
      //
    }
    
    //DON'T TOUCH
    popMatrix() ;
    //END OF DON'T TOUCH
    //END of MODE DISPLAY
    /////////////////////
    
    ////////////////////////////////////////////////
    //add object from keyboard, press "N" for new one
    if(actionButton[IDobj] == 1 && nTouch ) {
      Rinfo = random (1,24) ;
      info = round(Rinfo) ;
    }
    /////////////////////////////
    //CLEAR THE LIST IF NECESSARY 
    if (romanescoEmptyList(IDobj)) {}
    
    
    
    
    //IT'S THE END FOR YOU
    //////////////////////
  }
  //END DRAW
  ////////
    
    
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





////////////
//class RSS
class FeedReader {  
  SyndFeed feed;  
  String url,description,title;  
  int numEntries;  
  FeedEntry entry[];  
  
  public FeedReader(String _url) {  
    url=_url;  
    try {  
      feed=new SyndFeedInput().build(new XmlReader(new URL(url)));  
      description=feed.getDescription();  
      title=feed.getTitle();  
  
      java.util.List entrl=feed.getEntries();  
      Object [] o=entrl.toArray();  
      numEntries=o.length;  
  
      entry=new FeedEntry[numEntries];  
      for(int i=0; i< numEntries; i++) {  
        entry[i]=new FeedEntry((SyndEntryImpl)o[i]);  
      }  
    }  
    catch(Exception e) {  
      println("Exception in Feedreader: "+e.toString());  
      e.printStackTrace();  
    }  
  }  
  
}  
  
class FeedEntry {  
  Date pubdate;  
  SyndEntryImpl entry;  
  String author, contents, description, url, title;  
  public String newline = System.getProperty("line.separator");  
  
  public FeedEntry(SyndEntryImpl _entry) {  
    try {  
      entry=_entry;  
      author=entry.getAuthor();  
      Object [] o=entry.getContents().toArray();  
      if(o.length>0) contents=((SyndContentImpl)o[0]).getValue();  
      else contents="[No content.]";  
  
      description=entry.getDescription().getValue();  
      if(description.charAt(0)==  
        System.getProperty("line.separator").charAt(0))  
          description=description.substring(1);  
  
      url=entry.getLink();  
      title=entry.getTitle();  
      pubdate=entry.getPublishedDate();  
    }  
    catch(Exception e) {  
      println("Exception in FeedEntry: "+e.toString());  
      e.printStackTrace();  
    }  
  
  }  
  
  //to catch or translate the message
  public String toString() {  
    String s;
    s = title  ; 
    return s;  
  }
} 
