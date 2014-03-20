//////////////////
//OBJECT ROMANESCO
class RSS extends SuperRomanesco {
  public RSS() {
    //from the index_objects.csv
    romanescoName = "RSS" ;
    IDobj = 19 ;
    IDgroup = 3 ;
    romanescoAuthor  = "Stan Le Punk";
    romanescoVersion = "Alpha 2.0";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
    romanescoMode = "" ; // separate the name by a slash and write the next mode immadialtly after this one.
  }
  //GLOBAL
  FeedReader flux;
  String RSSliberation, RSSlemonde;
  float Rinfo ;
  int info = 0 ; 
  String messageRSS ;
  
  
  //SETUP
  void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
    if(internet) {
      String [] fluxRSS = loadStrings(sketchPath("")+"RSSReference.txt") ;
      String RSS = join(fluxRSS, "") ;
      flux = new FeedReader(RSS);
    }
  }
  
  
  
  
  //DRAW
  void display() {
    float corps ;
    //size text / corps
    corps = map(sizeYObj[IDobj], 0, height, 6, height *0.33) ;
    textFont(font[IDobj], corps + ( corps * mix[IDobj]) );
    // couleur du texte
    float t = alpha(fillObj[IDobj]) * abs(mix[IDobj]) ;
    if ( sound[IDobj] ) { t = alpha(fillObj[IDobj]) ; } 
    color c = color(hue(fillObj[IDobj]), saturation(fillObj[IDobj]), brightness(fillObj[IDobj]), t ) ;
    
    //hauteur largeur, height & width
    float largeur = canvasXObj[IDobj] *3 ;
    float hauteur = canvasYObj[IDobj] *3 ;
    
    fill(c) ;
      
    for( int i=info; i < info + 1; i++) {
      //internet = false ;
      if (internet && presceneOnly) messageRSS =  (i +""+flux.entry[i]) ; else messageRSS = bigBrother ;
      int r ;
      if ( i > 9 ) r =2 ; else if( i > 0 && i < 10 ) r =1 ; else r =0 ; 
      String hune = messageRSS.substring(r);
      //rotation / degré
      rotation(orientationObj[IDobj], mouse[IDobj].x, mouse[IDobj].y) ;
      text(hune, 0, 0, largeur, hauteur );
    }
    
    // BUTTON
    if(action[IDobj] && nTouch ) {
      Rinfo = random (1,24) ;
      info = round(Rinfo) ;
    }

  }
}
//end object one





// CLASS
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
