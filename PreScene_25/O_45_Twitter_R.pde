//GLOBAL
RomanescoFortyFive romanescoFortyFive ;
////////////////////////////////////////////////////////////////////

Twitter twt;
ArrayList<MessageTwitter> listMsg ;



//SETUP
void romanescoFortyFiveSetup() {
  // YOU MUST CHANGE THE ID
  //Example : If it's RomanestoThirtySetup int ID = 30 ;
  int ID = 45 ; // 0 is Ref you must use a number in the order of apparition in the controleur, start from top left and follow the horizontal line
  
  int IDfamilly = 3 ; // 1 is single object // 2 is trame // 3 is typo    ....... // 0 is global don't use this one it's for specific stuff
  romanescoFortyFive = new RomanescoFortyFive (ID, IDfamilly) ;

  romanescoFortyFive.setting() ;
}

//DRAW
void romanescoFortyFiveDraw(String [] dataControleur, String [] dataMinim) {
  romanescoFortyFive.getID() ;
  romanescoFortyFive.data(dataControleur, dataMinim) ;
  romanescoFortyFive.display() ;
}

//MOUSEPRESSED
void romanescoFortyFiveMousepressed() { romanescoFortyFive.mousepressed() ; }
//MOUSERELEASED
void romanescoFortyFiveMousereleased() { romanescoFortyFive.mousereleased() ; }
//MOUSE DRAGGED
void romanescoFortyFiveMousedragged() { romanescoFortyFive.mousedragged() ; }
//KEYPRESSED
void romanescoFortyFiveKeypressed() { romanescoFortyFive.keypressed() ; }
//KEY RELEASED
void romanescoFortyFiveKeyreleased() { romanescoFortyFive.keyreleased() ; }

//Return the ID familly to choice the data must be send to the class // 0 is global // 1 is Object // 2 is trame // 3 is typo
int getFamillyRomanescoFortyFive() { return romanescoFortyFive.getIDfamilly() ; }

////////////
//CLASS////
//GLOBAL
//////////////////////////////////////////
class RomanescoFortyFive extends SuperRomanesco 
{
  //FORBIDEN TO TOUCH
  int IDfamilly ;
  //END OF FORBIDEN ZONE
  String message ;
  
  //CONSTRUCTOR
  RomanescoFortyFive(int ID, int IDfamilly) {
    super(ID) ;
    this.IDfamilly = IDfamilly ;
  }
  //END CONSTRUCTOR
  
  ////SETUP
  //the setting that's stuff that you'r put usually in the void setup() 
  void setting() {
    listMsg = new ArrayList<MessageTwitter>() ;
    String [] hshtg = loadStrings ("ashtagReference.txt")  ;
    String hashtag = join(hshtg, "") ;
    
    twt = new Twitter(hashtag, 2, true); // false ou true pour Online ou non
    
    if (internet ) twt.setup();

    //If you use font
    font[IDobj] = font[0] ;
  }
  ///////////
  //END SETUP
  
  
  
  //////DRAW
  String joinedWords = ("") ;
  //display
  void display() {
    // starting position
    if (startingPosition[IDobj]) startPosition(IDobj, width/2, height/2, 0) ;
    // if you use font in your object
    if (parameterButton[IDobj] == 1 ) font[IDobj] = font[0] ;
    
    //ENGINE OF VOID
    float corps , fsc ;
    //size text / corps
    corps = map(valueObj[IDobj][28], 0, 100, 6, height *0.33) ;
    if (soundButton[IDobj] != 1)  fsc = 2 ; else fsc = mix[IDobj] ;
    // couleur du texte
    float t = constrain(valueObj[IDobj][4] * abs(fsc), 0, 100)  ;
    if ( soundButton[IDobj] != 1 ) { t = valueObj[IDobj][4] ; } 
    color ctwt ;
    ctwt = color(map(valueObj[IDobj][1],0,100,0,360), valueObj[IDobj][2], valueObj[IDobj][3], t) ;
    //hauteur largeur height and width
    float h = map (valueObj[IDobj][11], 0, 100, 0, height *3 ) ;
    float l = map (valueObj[IDobj][12], 0, 100, 0, width *3 ) ;

    // message reception
    if (internet) message = twt.update() ; else message = bigBrother ;
    // full message
    // split the message to can remove the hashtag
    if (message == null ) { 
      boolean acces = false ;
      if(internet) acces = twt.twitterAcces() ;
      if ( joinedWords.equals("") && acces) joinedWords = ("#ROMANESCO") ; else joinedWords = ("GIVE ME THE TWIITER CODE") ;
    } else {
      String[] words = splitTokens(message);
      // to remove the Hashtag
      if (words[0] == words[0] ) words[0] = ("") ; // must clean that if the the first word is not an ashtag, is a problem
      // rebuilt the sentence
      joinedWords = join(words, " ") ;
    }
    
    listMsg.add( new MessageTwitter(trim(joinedWords))) ;
    if ( listMsg.size()> 1 ) listMsg.remove(0) ; // to change the tweet by the new one
    
    
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
    
     //INTERNET ACCES
    ////////////////
    // If you use Internet, you must use this security, just in case you don't have :)
    // and put your function need internet inside this boolean- conditional

    //DISPLAY
    textAlign(CORNER);
    textFont(font[IDobj], corps + ( corps * fsc) );
    for (MessageTwitter msgTwt : listMsg)  {
      // rotation / deg
      rotation(valueObj[IDobj][18], mouse[IDobj].x, mouse[IDobj].y) ;
      if (soundButton[IDobj] != 1) msgTwt.display( 0 , 0, l, h, ctwt ) ; else msgTwt.display(-(droite[IDobj]*20) , -(gauche[IDobj ]*20) , l, h, ctwt ) ;
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
/////////////////////
//END CLASS ROMANESCO








////////////////////////
//CLASS MESSAGE TWITTER
class MessageTwitter {
  String mt ;
  
  MessageTwitter(String mt ) {
    this.mt = mt ;
  }
  //constructor test
  MessageTwitter() {}
  
  void display(float d, float g , float l, float h, color c) {
    fill(c) ;
    text(mt, d, g, l, h) ;
  }
}
//////////////////
////////////////





//////////////////
//CLASS TWITER
import twitter4j.StatusDeletionNotice;
import twitter4j.StatusDeletionNotice;
import twitter4j.StatusListener;
import twitter4j.Status;
import twitter4j.FilterQuery;
import twitter4j.TwitterStreamFactory;
import twitter4j.TwitterStream;
import twitter4j.conf.ConfigurationBuilder;

ArrayList twitter_statuses; 

class Twitter
{
  
  String[] statuses_offline = { "Romanesco Alpha 21", "Romanesco Alpha 22", "Romanesco Alpha 23", "Romanesco Alpha 24" };
  
  String keyword;

  float periodNextStatus;
  float period = 0.0;
  float time=0.0;

  boolean isOnline = false;
  // boolean isOnline = true;
  int offlineIndex = 0;

  Twitter(String k, float period, boolean online) {
    periodNextStatus = period;
    keyword = k;
    twitter_statuses = new ArrayList();
    isOnline = online;
  }
  ///////////////////
  boolean twitterAcces ;
  void setup() {
    // load the file.txt to read your twitter code
    String [] codeT = loadStrings(sketchPath("")+"twitterCode.txt") ;  ;
    String codeTwitter = join(codeT, "") ;
    String [] cT = split(codeTwitter, ",") ;
    
    //use this line if don't use the Scène
    if(presceneOnly ) if (cT[0].equals("true") || cT[0].equals("TRUE") ) twitterAcces = true ; else twitterAcces = false ;
    

    //acces twitter
    if (isOnline && twitterAcces) {
      // Configuration builder est simplement un objet qui stocke 
      // l'information d'application / authentification d'une application Twitter
      // Passé en paramètre à l'instance de Twitter Stream
      ConfigurationBuilder cb = new ConfigurationBuilder();
      cb.setDebugEnabled(false)
        .setOAuthConsumerKey(cT[2])
        .setOAuthConsumerSecret(cT[4])
        .setOAuthAccessToken(cT[6])
        .setOAuthAccessTokenSecret(cT[8]);  

      // Objet qui permet de récupérer les tweets
      TwitterStream ts = new TwitterStreamFactory(cb.build()).getInstance();
  
      // Filter Query est un objet qui permet de faire une requête sur la base de données de Twitter
      // en fonction de paramètres (par exemple des mots clés)
      FilterQuery filterQuery = new FilterQuery() ; 
      filterQuery.track(new String[] { keyword } ); 
  
      // On fait le lien entre le TwitterStream (qui récupère les messages) et notre écouteur  
      ts.addListener(new TwitterListener());
      // On démarre la recherche !
      ts.filter(filterQuery);
    }
  }
  
  
  boolean twitterAcces() {
    println(twitterAcces) ;
    if (twitterAcces) return true ; else return false ;
  }
  /////////////////////////////
  String update()
  {
    period += millis() - time;
    time = millis();

    // Plus grand que notre période ? 
    if (period/1000 >= periodNextStatus) {
      // Ré-initialise
      period = 0.0;
      // On prend le premier message dans la liste (= le plus ancien)
      // Puis on l'affiche
      if (isOnline) {
        if (twitter_statuses.size() > 0) {
          Status currentStatus = (Status)twitter_statuses.remove(0);
          return currentStatus.getText();
        }
      } else {
        //String s =  statuses_offline[1];
        String s =  statuses_offline[offlineIndex];
        offlineIndex = (offlineIndex+1)%statuses_offline.length;
        return s;
      }
    }
    return null;
  }
};


// ------------------------------------------------------------
// class TwitterListener
//
// Classe qui permet "d'écouter" les messages entrants
// récupérés par notre instance TwitterStream
// ------------------------------------------------------------
class TwitterListener implements StatusListener
{
  // onStatus : nouveau message qui vient d'arriver 
  public void onStatus(Status status) {
    println(status.getUser().getName() + " : " + status.getText());
    twitter_statuses.add(status);
  }  

  // onDeletionNotice
  public void onDeletionNotice(StatusDeletionNotice statusDeletionNotice) {
  }

  // onTrackLimitationNotice
  public void onTrackLimitationNotice(int numberOfLimitedStatuses) {
  }  

  // onScrubGeo : récupération d'infos géographiques
  public void onScrubGeo(long userId, long upToStatusId) {
   System.out.println("Got scrub_geo event userId:" + userId + " upToStatusId:" + upToStatusId);
  }

  // onException : une erreur est survenue (déconnexion d'internet, etc...)
  public void onException(Exception ex) {
    ex.printStackTrace();
  }
}
