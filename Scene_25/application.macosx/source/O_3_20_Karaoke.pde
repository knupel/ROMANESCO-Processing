//////////////////
//OBJECT ROMANESCO
class Karaoke extends SuperRomanesco {
  public Karaoke() {
    //from the index_objects.csv
    romanescoName = "Karaoke" ;
    IDobj = 20 ;
    IDgroup = 3 ;
    romanescoAuthor  = "Stan LePunk";
    romanescoVersion = "Alpha 2.0";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
    romanescoMode = "" ; // separate the name by a slash and write the next mode immadialtly after this one.
  }
  //GLOBAL
  int chapter, sentence ;
  
  //SETUP
  void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
  }
  
  
  
  
  //DRAW
  void display() {
    float sizeFont = fontSizeObj[IDobj] ;
    
    textFont(font[IDobj], sizeFont + ( sizeFont * mix[IDobj]) );
    // couleur du texte
    float t = alpha(fillObj[IDobj]) * abs(mix[IDobj]) ;
    if ( sound[IDobj] ) { t = alpha(fillObj[IDobj]) ; } 
    color c = color(hue(fillObj[IDobj]), saturation(fillObj[IDobj]), brightness(fillObj[IDobj]), t ) ;
    
    //hauteur largeur, height & width
    float largeur = canvasXObj[IDobj] *15 ;
    float hauteur = canvasYObj[IDobj] *15 ;
    
    //tracking chapter
    String karaokeChapters [] = split(textRaw, "*") ;
    //security button
    if(action[IDobj] && nLongTouch ) {
      
      if (chapter > -1 && chapter < karaokeChapters.length  && nextPrevious && (leftTouch || rightTouch  )) {
        chapter = chapter + tracking(chapter, karaokeChapters.length ) ;
        sentence = 0 ; // reset to start the chapter at the begin, and display the first sentence
        trackerUpdate = 0 ;
      // to choice a texte with the keyboard number 1 to 10 the zero is ten
      } else if (nextPrevious && touch0 && karaokeChapters.length > 9 ) {
        chapter = 0 ;  sentence = 0 ;
      } else if (nextPrevious && touch9 && karaokeChapters.length > 8 ) {
        chapter = 9 ;  sentence = 0 ;
      } else if (nextPrevious && touch8 && karaokeChapters.length > 7 ) {
        chapter = 8 ;  sentence = 0 ;
      } else if (nextPrevious && touch7 && karaokeChapters.length > 6 ) {
        chapter = 7 ;  sentence = 0 ;
      } else if (nextPrevious && touch6 && karaokeChapters.length > 5 ) {
        chapter = 6 ;  sentence = 0 ;
      } else if (nextPrevious && touch5 && karaokeChapters.length > 4 ) {
        chapter = 5 ;  sentence = 0 ;
      } else if (nextPrevious && touch4 && karaokeChapters.length > 3 ) {
        chapter = 4 ;  sentence = 0 ;
      } else if (nextPrevious && touch3  && karaokeChapters.length > 2 ) {
        chapter = 3 ; sentence = 0 ;
      } else if (nextPrevious && touch2 && karaokeChapters.length > 1 ) {
        chapter = 2 ; sentence = 0 ;
      } else if (nextPrevious && touch1 && karaokeChapters.length > 0 ) {
        chapter = 1 ; sentence = 0 ;
      }
    }
    
    //tracking sentence
    if ( chapter < karaokeChapters.length) {
      String karaokeSentences [] = split(karaokeChapters[chapter], "/") ;
      if (sentence > -1 && sentence < karaokeSentences.length  && nextPrevious && (downTouch || upTouch) ) {
        sentence = sentence + tracking(sentence, karaokeSentences.length ) ;
        trackerUpdate = 0 ;
      }
      rotation(directionObj[IDobj], mouse[IDobj].x, mouse[IDobj].y) ;
      //DISPLAY
      textAlign(CORNER);
      textFont(font[IDobj], sizeFont+ (mix[IDobj]) *6 *beat[IDobj]);
      fill(c) ;
      text(karaokeSentences[sentence], 0, 0, largeur, hauteur) ;
    }

  }
}
//end object one
