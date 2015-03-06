//////////////////
//OBJECT ROMANESCO

import twitter4j.conf.*;
import twitter4j.internal.async.*;
import twitter4j.internal.org.json.*;
import twitter4j.internal.logging.*;
import twitter4j.json.*;
import twitter4j.internal.util.*;
import twitter4j.management.*;
import twitter4j.auth.*;
import twitter4j.api.*;
import twitter4j.util.*;
import twitter4j.internal.http.*;
import twitter4j.*;
import twitter4j.internal.json.*;

import twitter4j.StatusDeletionNotice;
import twitter4j.StatusDeletionNotice;
import twitter4j.StatusListener;
import twitter4j.Status;
import twitter4j.FilterQuery;
import twitter4j.TwitterStreamFactory;
import twitter4j.TwitterStream;
import twitter4j.conf.ConfigurationBuilder;



Twitter twt;
ArrayList<MessageTwitter> listMsg ;
String joinedWordsTwitter = ("") ;

//
class Twitos extends SuperRomanesco {
  public Twitos() {
    //from the index_objects.csv
    romanescoName = "Twitos" ;
    IDobj = 5 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Stan Le Punk";
    romanescoVersion = "version 2.1";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
    romanescoMode = "" ; // separate the name by a slash and write the next mode immadialtly after this one.
  }
  //GLOBAL
  String message ;
  String hashtag ;
  
  
  //SETUP
  void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
    listMsg = new ArrayList<MessageTwitter>() ;
    String [] hshtg = loadStrings(preferencesPath+"network/twitter/ashtagReference.txt")  ;
    hashtag = join(hshtg, "") ;
    
    twt = new Twitter(hashtag, 2, true); // false ou true pour Online ou non
    
    if (internet) twt.setup();
  }
  
  
  
  
  //DRAW
  void display() {
    float sizeFont = fontSizeObj[IDobj] ;
    textFont(font[IDobj], sizeFont +(sizeFont *mix[IDobj]) );
    // couleur du texte
    float t = alpha(fillObj[IDobj]) * abs(mix[IDobj]) ;
    if ( sound[IDobj] ) { t = alpha(fillObj[IDobj]) ; } 
    color c = color(hue(fillObj[IDobj]), saturation(fillObj[IDobj]), brightness(fillObj[IDobj]), t ) ;
    

    
    //hauteur largeur, height & width
    float largeur = canvasXObj[IDobj] *15 ;
    float hauteur = canvasYObj[IDobj] *15 ;
    
    // message reception
    if (internet && fullRendering) message = twt.update() ; else message = bigBrother ;
    // full message
    // split the message to can remove the hashtag
    if (message == null ) { 
      boolean acces = false ;
      if(internet) acces = twt.twitterAcces() ;
       if (acces && joinedWordsTwitter.equals("") ) joinedWordsTwitter = (hashtag) ; 
    } else {
      String[] words = splitTokens(message);
      // to remove the Hashtag
      if (words[0] == words[0] ) words[0] = ("") ; // must clean that if the the first word is not an ashtag, is a problem
      // rebuilt the sentence
      joinedWordsTwitter = join(words, " ") ;
    }
    
    listMsg.add( new MessageTwitter(trim(joinedWordsTwitter))) ;
    if ( listMsg.size()> 1 ) listMsg.remove(0) ; // to change the tweet by the new one
    
    
    //DISPLAY
    textAlign(CORNER);
    textFont(font[IDobj], sizeFont +(mix[IDobj]) *6 *beat[IDobj]);
    for (MessageTwitter msgTwt : listMsg)  {
      rotation(directionObj[IDobj], mouse[IDobj].x, mouse[IDobj].y) ;
      if (soundButton[IDobj] != 1) msgTwt.display( -width/2 , 0, largeur, hauteur, c ) ; else msgTwt.display(-width/2 -(right[IDobj]*20) , -(left[IDobj ]*20) , largeur, hauteur, c ) ;
    }

  }
}
//end object one






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
ArrayList twitter_statuses; 

class Twitter {
  
  String[] statuses_offline = { "Romanesco Unu "+version, "Romanesco Unu "+version, "Romanesco Unu "+version, "Romanesco Unu "+version };
  
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
    String [] codeT = loadStrings(preferencesPath +"network/twitter/twitterCode.txt")  ;
    String codeTwitter = join(codeT, "") ;
    String [] cT = split(codeTwitter, ",") ;
    
    //use this line if don't use the Scène
    if(fullRendering) if (cT[0].equals("true") || cT[0].equals("TRUE") ) { 
      twitterAcces = true ; 
    } else {
      twitterAcces = false ;
      joinedWordsTwitter = ("GIVE ME THE TWITTER CODE") ;
    }
    

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
     //  ts.addListener(new TwitterListener());
      // On démarre la recherche !
     //  ts.filter(filterQuery);
    }
  }
  
  
  boolean twitterAcces() {
    if (twitterAcces) return true ; else return false ;
  }
  /////////////////////////////
  String update() {
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

class TwitterListener{
  // onStatus : nouveau message qui vient d'arriver 
  public void onStatus(Status status) {
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
