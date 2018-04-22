/**
CROPE
CONTROL ROMANESCO PROCESSING ENVIRONMENT
*
CLASS BUTTON 1.1.0
*/
class Button {
  color color_bg, color_on_off ;
  color color_in_ON, color_out_ON, color_in_OFF, color_out_OFF ; 
  color color_bg_in, color_bg_out ;



  int  pos_ref_x, pos_ref_y ;
  Vec2 pos, size ;
  String name = "" ;
  
  boolean inside ;
  boolean on_off = false ;  
  //MIDI
  int newmidi_value_romanesco ;
  // IDbutton ;
  int IDmidi = -2 ;
  int ID, rank ;
  
  
  //Constructor
  //simple
  Button () {}
  //complexe
  Button (int pos_x, int pos_y, int widthButton, int heightButton) {
    //this.on_off = on_off ;
    this.pos = Vec2(pos_x, pos_y) ;
    pos_ref_x = pos_x ;
    pos_ref_y = pos_y ;
    size.x = widthButton ;
    size.y = heightButton ;

  }
  Button (Vec2 pos, Vec2 size) {
    //this.on_off = on_off ;
    this.pos = pos ;
    pos_ref_x = (int)pos.x ;
    pos_ref_y = (int)pos.y ;
    this.size = size ;
  }

  /**
  Setting
  */
  void set_on_off(boolean on_off) {
    this.on_off = on_off ;
  }

  void set_name(String name) {
    this.name = name ;
  }

  void set_size(Vec2 size) {
    this.size = size ;
  }
  void set_pos(Vec2 pos) {
    this.pos = pos ;
    pos_ref_x = (int)pos.x ;
    pos_ref_y = (int)pos.y ;
  }


  void set_color_on_off(color color_in_ON, color color_out_ON, color color_in_OFF, color color_out_OFF) {
    this.color_in_ON = color_in_ON ; 
    this.color_out_ON = color_out_ON ; 
    this.color_in_OFF = color_in_OFF ; 
    this.color_out_OFF = color_out_OFF ;
  }
  void set_color_bg(color color_bg_in, color color_bg_out) {
    this.color_bg_in = color_bg_in ; 
    this.color_bg_out = color_bg_out ;
  }

  void set_rank(int rank) {
    this.rank = rank;
  }

  void set_ID(int ID) {
    this.ID = ID ;
  }


  /**
  MISC
  */
  void background_button() {
    fill(color_bg) ;
    rect(pos.x, pos.y, size.x, size.y) ;
  }






  
  
  //ROLLOVER
  //rectangle
  float newSize = 1  ;
  //
  boolean rollover() {
    if (size.y < 10 ) newSize = size.y *1.8 ; 
    else if (size.y >= 10 && size.y < 20  ) newSize = size.y *1.2 ;  
    else if (size.y >= 20 ) newSize = size.y ;
    if ( mouseX > pos.x && mouseX < pos.x + size.x && mouseY > pos.y  && mouseY < pos.y + newSize ) {
      inside = true ;
      return true ; 
    } else {
      inside = false ;
      return false ; 
    }
  }
  // with correction for the font position
  boolean rollover(int correction) {
    if (size.y < 10 ) newSize = size.y *1.8 ; 
    else if (size.y >= 10 && size.y < 20  ) newSize = size.y *1.2 ;  
    else if (size.y >= 20 ) newSize = size.y ;
    
    if ( mouseX > pos.x && mouseX < pos.x + size.x && mouseY > pos.y -correction  && mouseY < pos.y +newSize -correction) { 
      inside = true ;
      return true ; 
    } else {
      inside = false ;
      return false ; 
    }
  }
  
  
  
  //MousePressed
    void mousePressed() {
    if (rollover()) {
      on_off = !on_off ? true : false ;
    }
  }

  void mousePressedText() {
    if (rollover((int)size.y)) on_off = !on_off ? true : false ;
  }


  
  // MIDI
  int IDmidi() { 
    return IDmidi ; 
  }
  
  void selectIDmidi(int num) { 
    IDmidi = num ; 
  }


    /**
  IMAGE BUTTON
  */
  void button_pic_serie(PImage[] OFF_in, PImage[] OFF_out, PImage[] ON_in, PImage[] ON_out, int whichOne) {
    /* use the boolean dropdownActivity directly is very bad */
    int correctionX = -1 ;
    if(ON_in[whichOne] != null && ON_out[whichOne] != null && OFF_in[whichOne] != null && OFF_out[whichOne] != null ) {
      if (on_off) {
        if (rollover() && !dropdownActivity) image(ON_in[whichOne],pos.x +correctionX, pos.y) ; else image(ON_out[whichOne],pos.x +correctionX, pos.y) ;
      } else {
        if (rollover() && !dropdownActivity) image(OFF_in[whichOne],pos.x +correctionX, pos.y) ; else image(OFF_out[whichOne],pos.x +correctionX, pos.y) ;
      }
    }
  }

  void button_pic(PImage [] pic) {
    /* use the boolean dropdownActivity directly is very bad */
    int correctionX = -1 ;
    if(pic[0] != null && pic[1] != null && pic[2] != null && pic[3] != null ) {
      if (on_off) {
        if (rollover() && !dropdownActivity) image(pic[1],pos.x +correctionX, pos.y) ; else image(pic[0],pos.x +correctionX, pos.y) ;
      } else {
        if (rollover() && !dropdownActivity) image(pic[3],pos.x +correctionX, pos.y) ; else image(pic[2],pos.x +correctionX, pos.y) ;
      }
    }
  }
  void button_pic_text(PImage [] pic, String text) {
    /* use the boolean dropdownActivity directly is very bad */
    fill(jaune) ;
    textFont(FuturaStencil_20) ;
    int correctionX = -1 ;
    if ( on_off ) {
      if (rollover() && !dropdownActivity) {
        image(pic[1],pos.x +correctionX, pos.y) ;
        text(text,   mouseX -20, mouseY -20 ) ;
      } else image(pic[0],pos.x +correctionX, pos.y) ;
    } else {
      if (rollover() && !dropdownActivity) { 
        image(pic[3],pos.x +correctionX, pos.y) ; 
        text(text,   mouseX -20, mouseY -20 ) ;
      } else image(pic[2],pos.x +correctionX, pos.y) ;
    }
  }

  /**
  TEXT BUTTON
  */
  void button_text(int x, int y)  {
    button_text(name, x, y) ;
  }
  
  void button_text(String s, int x, int y) {
    /* use the boolean dropdownActivity directly is very bad */
    if (on_off) {
      stroke(vertTresFonce) ;
      if (rollover() && !dropdownActivity) color_on_off = color_in_ON ; else color_on_off = color_out_ON ;
    } else {
      stroke(rougeTresFonce) ; 
      if (rollover() && !dropdownActivity) color_on_off = color_in_OFF ; else color_on_off = color_out_OFF ;
    }

    fill(color_on_off) ;
    text(s, x, y) ;
  }
 
  void button_text(String s, Vec2 pos, PFont font, int sizeFont) {
    /* use the boolean dropdownActivity directly is very bad */
    if (on_off) {
      if (rollover(sizeFont) && !dropdownActivity) color_on_off = color_in_ON ; else color_on_off = color_out_ON ;
    } else {
      if (rollover(sizeFont) && !dropdownActivity) color_on_off = color_in_OFF ; else color_on_off = color_out_OFF ;
    }
    fill(color_on_off) ;
    textFont(font) ;
    textSize(sizeFont) ;
    text(s, pos.x, pos.y) ;
  }
 
  void button_rect(String s) {
    /* use the boolean dropdownActivity directly is very bad */
    strokeWeight (1) ;
    if (on_off) {
      stroke(vertTresFonce) ;
      if (rollover() && !dropdownActivity)color_on_off = color_in_ON ; else color_on_off = color_out_ON ;
    } else {
      stroke(rougeTresFonce) ; 
      if (rollover() && !dropdownActivity) color_on_off = color_in_OFF ; else color_on_off = color_out_OFF ;
    }

    fill(color_on_off) ;
    rect(pos.x, pos.y, size.x, size.y) ;
    fill(blanc) ;
    text(s, pos.x, pos.y) ;
    noStroke() ;
  }
}










/**
BUTTON DYNAMIC
*/

class Button_dynamic extends Button {
  Vec2 change_pos = Vec2() ;
  Button_dynamic() {
    super() ;
  }

  Button_dynamic(Vec2 pos, Vec2 size) {
    super(pos, size) ;
  }
  


  void change_pos(int x, int y) {
    this.change_pos. set(x,y) ;
  }


  void update_pos(boolean display_button) {
    if(!display_button) {
      pos.set(-100) ; 
    } else {
      pos.set(pos_ref_x, pos_ref_y) ;
      pos.add(change_pos) ;
    }
  }
}
