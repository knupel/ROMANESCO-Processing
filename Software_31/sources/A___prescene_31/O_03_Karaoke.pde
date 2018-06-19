/**
KARAOKE
2011-2018
v 2.0.3
*/

class Karaoke extends Romanesco {
  public Karaoke() {
    //from the index_objects.csv
    item_name = "Karaoke" ;
    ID_item = 3 ;
    ID_group = 1 ;
    item_author  = "Stan LePunk";
    item_version = "Version 2.0.3";
    item_pack = "Base 2011" ;
    item_costume = "" ; // separate the name by a slash and write the next mode immadialtly after this one.
    item_mode = "" ; // separate the name by a slash and write the next mode immadialtly after this one.
    
    hue_fill_is = true;
    sat_fill_is = true;
    bright_fill_is = true;
    alpha_fill_is = true;
    hue_stroke_is = false;
    sat_stroke_is = false;
    bright_stroke_is = false;
    alpha_stroke_is = false;
    thickness_is = false;
    size_x_is = false;
    size_y_is = false;
    size_z_is = false;
    font_size_is = true;
    canvas_x_is = true;
    canvas_y_is = true;
    canvas_z_is = false;

    reactivity_is = false;
    speed_x_is = false;
    speed_y_is = false;
    speed_z_is = false;
    spurt_x_is = false;
    spurt_y_is = false;
    spurt_z_is = false;
    dir_x_is = false;
    dir_y_is = false;
    dir_z_is = false;
    jit_x_is = false;
    jit_y_is = false;
    jit_z_is  = false;
    swing_x_is = false;
    swing_y_is = false;
    swing_z_is = false;

    num_is = false;
    variety_is = false;
    life_is = false;
    flow_is = false;
    quality_is = false;
    area_is = false;
    angle_is = false;
    scope_is = false;
    scan_is = false;
    align_is = false;
    repulsion_is = false;
    attraction_is = false;
    density_is = false;
    influence_is = false;
    calm_is = false;
    spectrum_is = false;
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
    
    float size_font = font_size_item[ID_item] *mix[ID_item] *allBeats(ID_item);
    if(size_font < 1) size_font = 1;
    
    textFont(font_item[ID_item],size_font);
    
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
    if(action[ID_item] && key_n_long ) {
      
      if (chapter > -1 && chapter < karaokeChapters.length  && nextPrevious && (key_left || key_right  )) {
        chapter = chapter + tracking(chapter, karaokeChapters.length ) ;
        sentence = 0 ; // reset to start the chapter at the begin, and display the first sentence
        trackerUpdate = 0 ;
      // to choice a texte with the keyboard number 1 to 10 the zero is ten
      } else if (nextPrevious && key_0 && karaokeChapters.length > 9 ) {
        chapter = 0 ;  sentence = 0 ;
      } else if (nextPrevious && key_9 && karaokeChapters.length > 8 ) {
        chapter = 9 ;  sentence = 0 ;
      } else if (nextPrevious && key_8 && karaokeChapters.length > 7 ) {
        chapter = 8 ;  sentence = 0 ;
      } else if (nextPrevious && key_7 && karaokeChapters.length > 6 ) {
        chapter = 7 ;  sentence = 0 ;
      } else if (nextPrevious && key_6 && karaokeChapters.length > 5 ) {
        chapter = 6 ;  sentence = 0 ;
      } else if (nextPrevious && key_5 && karaokeChapters.length > 4 ) {
        chapter = 5 ;  sentence = 0 ;
      } else if (nextPrevious && key_4 && karaokeChapters.length > 3 ) {
        chapter = 4 ;  sentence = 0 ;
      } else if (nextPrevious && key_3  && karaokeChapters.length > 2 ) {
        chapter = 3 ; sentence = 0 ;
      } else if (nextPrevious && key_2 && karaokeChapters.length > 1 ) {
        chapter = 2 ; sentence = 0 ;
      } else if (nextPrevious && key_1 && karaokeChapters.length > 0 ) {
        chapter = 1 ; sentence = 0 ;
      }
    }
    
    //tracking sentence
    if ( chapter < karaokeChapters.length) {
      String karaokeSentences [] = split(karaokeChapters[chapter], "/") ;
      if (sentence > -1 && sentence < karaokeSentences.length  && nextPrevious && (key_down || key_up) ) {
        sentence = sentence + tracking(sentence, karaokeSentences.length ) ;
        trackerUpdate = 0 ;
      }
      rotation(dir_x_item[ID_item], mouse[ID_item].x, mouse[ID_item].y) ;
      //DISPLAY
      textAlign(CORNER);
      size_font = size_font+ (mix[ID_item]) *6 *beat[ID_item];
      if(size_font < 1) size_font = 1;
      textFont(font_item[ID_item],size_font);
      text(karaokeSentences[sentence], 0, 0, largeur, hauteur) ;
    }
  }
}
//end object one