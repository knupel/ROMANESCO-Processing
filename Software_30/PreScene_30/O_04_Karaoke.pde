/**
KARAOKE || 2011 || 2.0.2
*/

class Karaoke extends Romanesco {
  public Karaoke() {
    //from the index_objects.csv
    RPE_name = "Karaoke" ;
    ID_item = 4 ;
    ID_group = 1 ;
    RPE_author  = "Stan LePunk";
    RPE_version = "Version 2.0.2";
    RPE_pack = "Base" ;
    RPE_mode = "" ; // separate the name by a slash and write the next mode immadialtly after this one.
    RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Canvas X,Canvas Y,Direction X,Font size" ;
  }
  //GLOBAL
  int chapter, sentence ;
  
  //SETUP
  void setup() {
    setting_start_position(ID_item, width/8, height/8, 0) ;
  }
  
  
  
  
  //DRAW
  void draw() {
    load_txt(ID_item) ;
    
    float sizeFont = font_size_item[ID_item] ;
    
    textFont(font_item[ID_item], sizeFont *mix[ID_item] *allBeats(ID_item) );
    
    // couleur du texte
    // security against the blavk bug opacity
    if (alpha(fill_item[ID_item]) <= 0 ) {
      noFill() ; 
      noStroke() ; 
    } else {     
      fill (fill_item[ID_item]) ; 
    }


    
    //hauteur largeur, height & width
    float largeur = canvas_x_item[ID_item] *15 ;
    float hauteur = canvas_y_item[ID_item] *15 ;
    
    //tracking chapter
    String karaokeChapters [] = split(text_import[ID_item], "*") ;
    //security button
    if(action[ID_item] && nLongTouch ) {
      
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
      rotation(dir_x_item[ID_item], mouse[ID_item].x, mouse[ID_item].y) ;
      //DISPLAY
      textAlign(CORNER);
      textFont(font_item[ID_item], sizeFont+ (mix[ID_item]) *6 *beat[ID_item]);
      text(karaokeSentences[sentence], 0, 0, largeur, hauteur) ;
    }

  }
}
//end object one