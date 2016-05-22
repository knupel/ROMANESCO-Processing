/**
TRAME || 2012 || 1.1.1
*/

Trame trame ;
//object three
class Damier extends Romanesco {
  public Damier() {
    //from the index_objects.csv
    RPE_name = "Damier" ;
    ID_item = 18 ;
    ID_group = 1 ;
    RPE_author  = "Stan le Punk";
    RPE_version = "Version 1.1.1";
    RPE_pack = "Base" ;
    RPE_mode = "Rectangle/Ellipse/Box" ;
    RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Stroke hue,Stroke sat,Stroke bright,Stroke alpha,Thickness,Size X,Size Y,Size Z,Quantity,Speed X,Canvas X" ;
  }
  //GLOBAL
  float d, g, m ;
  PVector size = new PVector(0,0,0) ;
  float angleTrame = 0 ;
  float angle = 0 ;
  float speed = 0 ;

  //SETUP
  void setup() {
    startPosition(ID_item, width/2, height/2, -width) ;
    trame = new Trame() ;

  }
  //DRAW
  void draw() {
    // color and thickness
    aspect_rpe(ID_item) ;
    
    if ( sound[ID_item]) {
      g = map(left[ID_item],0,1,1,5) ; 
      d = map(right[ID_item],0,1,1,5) ; 
      m = map(mix[ID_item],0,1,1,5) ;
    } else {  
      g = 1.0 ;
      d = 1.0 ;
      m = 1.0 ;
    }
    float penPressure = map(pen[ID_item].z,0,1,1,width/100) ;
    float sizeXtemp = map(size_x_item[ID_item],.1,width,.1,width/33) ;
    float sizeYtemp = map(size_y_item[ID_item],.1,width,.1,width/33) ;
    float sizeZtemp = map(size_z_item[ID_item],.1,width,.1,width/33) ;
    size.x = ((sizeXtemp *sizeXtemp) *penPressure *allBeats(ID_item) ) *g ;
    size.y = ((sizeYtemp *sizeYtemp) *penPressure *allBeats(ID_item)) *d ;
    size.z = ((sizeZtemp *sizeZtemp) *penPressure *allBeats(ID_item)) *m  ;
    //size

    //orientation / deg
    //speed
    speed = map(speed_x_item[ID_item], 0,1,0, 0.5 );
    if(reverse[ID_item]) speed = speed *1 ; else speed = speed * -1 ;
    if (speed != 0 && motion[ID_item]) angleTrame += speed *tempo[ID_item] ;
    
    
    //rotation of the single shape
    if (action[ID_item]) angle = map(angle_item[ID_item], 0,100, 0, TAU) ; 
    
    //quantity
    int q = int(map(quantity_item[ID_item], 0, 1, 2, 9)) ;
    if(FULL_RENDERING) q *= q ;

    //amp
    float amp = map(swing_x_item[ID_item],0,1, .3, width *.007) ;
    amp *= amp ;
    
    //MODE DISPLAY
    if(mode[ID_item] == 0 || mode[ID_item] == 255) trame.drawTrameRect(mouse[ID_item], angleTrame, angle, size , q, g, d, amp) ;
    else if (mode[ID_item] == 1) trame.drawTrameDisc(mouse[ID_item], angleTrame, angle, size , q, g, d, amp) ;
    else if (mode[ID_item] == 2) trame.drawTrameBox(mouse[ID_item], angleTrame, angle, size , q, g, d, amp) ;
    
    //INFO
    objectInfo[ID_item] =("Quantity " + q + " shapes / Angle " + (int)angle + " Speed " + int(speed *100) + " Amplitude " + int(amp *100)) ;
    
  }
  
}
//end object two





/////////////
//CLASS TRAME
class Trame {
  Trame(){}
  
  float nbrlgn ; 
  int vitesse ;
  
  //TRAME RECTANGLEe multiple
  void drawTrameRect (Vec3 axe, float angleTrame, float angle_item, PVector size, int nbrlgn, float gauche, float droite, float amp ) {
    pushMatrix() ;
    translate(axe.x, axe.y) ;
    // calcul the position of each object
    for (int i=1 ; i < nbrlgn ; i++) {
      for (int j=1 ; j < nbrlgn ; j++) { 
        Vec2 pos = Vec2 ((i *width *amp) / nbrlgn, (j *height *amp ) / nbrlgn )  ;
        Vec2 newPosAfterRotation = rotation(pos, Vec2(axe.x,axe.y), angleTrame) ;        
        rectangleTrame (newPosAfterRotation, size.x, size.y, gauche, droite, angle_item ) ;      
      }
    }
    popMatrix() ;  
  }
  
  
  
  
  //TRAME DISC multiple
  void drawTrameDisc (Vec3 axe, float angleTrame, float angle_item, PVector size, int nbrlgn, float gauche, float droite, float amp   ) {
    pushMatrix() ;
    translate(axe.x, axe.y) ;
    // calcul the position of each object
    for (int i=1 ; i < nbrlgn ; i++) {
      for (int j=1 ; j < nbrlgn ; j++) {
        Vec2 pos = Vec2 (  (i *width *amp ) / nbrlgn, (j * height *amp ) / nbrlgn )  ;
        Vec2 newPosAfterRotation = rotation(pos, Vec2(axe.x,axe.y), angleTrame) ;        
        disqueTrame (newPosAfterRotation, size.x, size.y, gauche, droite, angle_item ) ;      
      }
    }
    popMatrix() ;  
  }
  
  
  //TRAME BOX
  void drawTrameBox (Vec3 axe, float angleTrame, float angle_item, PVector size, int nbrlgn, float gauche, float droite, float amp   ) {
    pushMatrix() ;
    translate(axe.x, axe.y) ;
    //calcul the position of each object
    for (int i=1 ; i < nbrlgn ; i++) {
      for (int j=1 ; j < nbrlgn ; j++) {
        Vec2 pos = Vec2 (  (i *width *amp ) / nbrlgn, (j * height *amp ) / nbrlgn )  ;
        Vec2 newPosAfterRotation = rotation(pos, Vec2(axe.x,axe.y), angleTrame) ;        
        boxTrame (newPosAfterRotation, size, gauche, droite, angle_item ) ;      
      }
    }
    popMatrix() ;  
  }
  
  void rectangleTrame(Vec2 pos, float h, float l, float gauche, float droite, float aObj) {
    pushMatrix() ;
    rectMode(CENTER) ;
    translate(pos.x, pos.y) ;
    rotate(aObj) ;
    rect (0, 0, pow(l,1.4), pow(h,1.4)) ;
    rectMode(CORNER) ;
    popMatrix() ;
  }
  
  void disqueTrame(Vec2 pos, float h, float l, float gauche, float droite, float aObj) {
    pushMatrix() ;
    ellipseMode(CENTER) ;
    translate(pos.x, pos.y) ;
    rotate(aObj) ;
    ellipse (0, 0, pow(l,1.4), pow(h,1.4)) ;
    ellipseMode(CORNER) ;
    popMatrix() ;
  }
  
  void boxTrame(Vec2 pos, PVector size, float gauche, float droite, float aObj) {
    pushMatrix() ;
    translate(pos.x, pos.y) ;
    rotate(aObj) ;
    box (pow(size.x,1.4), pow(size.y,1.4), pow(size.z,1.4)) ;
    popMatrix() ;
  }
}