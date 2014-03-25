ArrayList rideauList = new ArrayList() ;

//object one
class Rideau extends SuperRomanesco {
  public Rideau() {
    //from the index_objects.csv
    romanescoName = "Rideau" ;
    IDobj = 12 ;
    IDgroup = 2 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Alpha 2.0";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
    romanescoMode ="1 Rectangle/2 Box" ;
  }
  //GLOBAL
  

  //SETUP
  void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
  }
  //DRAW
  void display() {
    //END OF DON'T TOUCH
    //speed / vitesse
    float vitesse = 0.01 + (speedObj[IDobj] *0.001) ;
    //durée / life
    int vie = 100 + (100 * int(lifeObj[IDobj])) ;
    //thickness / épaisseur
    // int epaisseur = 1 + int((valueObj[IDobj][13] *.5) + abs(mix[IDobj]) *10);
    float thickness = thicknessObj[IDobj] + abs(mix[IDobj]) *10 ;
    
    PVector size = new PVector(sizeXObj[IDobj],sizeYObj[IDobj],sizeYObj[IDobj]) ;
    //Color
    float opacityIn = round(alpha(fillObj[IDobj]) + ((mix[IDobj]) *25 )) ;
    float opacityOut = alpha(strokeObj[IDobj]) ;
    color colorIn = fillObj[IDobj] ;
    color colorOut = strokeObj[IDobj] ;
    
   //orientation / degré
   rotation(directionObj[IDobj], (mouse[IDobj].x *2) -width/2  , (mouse[IDobj].y *2) -height/2 ) ;
    
    for (int i=0 ; i < rideauList.size(); i++) {
      Curtain c = (Curtain) rideauList.get(i); // GET donne l'ordre d'aller chercher de la particule dans le la Valise Fourre Tout
      if (c.disparition () ) {
        rideauList.remove (i) ;
      } else {
        c.actualisation ();
        if(mode[IDobj] == 0 || mode[IDobj] == 255) c.drawRect(colorIn, colorOut, opacityIn, opacityOut, thickness, size.x)  ;
        else if (mode[IDobj] == 1) c.drawBox(colorIn, colorOut, opacityIn, opacityOut, thickness, size)  ;
        
      }
    }
    if (action[IDobj] && nTouch) {
      rideauList.add( new Curtain(vitesse, vie )) ;
    }
    
  }
}
//end object one







//////////////
//CLASS CURTAIN
class Curtain { 
  int chrono, transp, transpb ;
  int vp ;
  float croissance, v, mvt, posX ; 
  Curtain(float vitesse, int vie)  {
   v = vitesse ; vp = vie ; 
  }
  
  boolean disparition () {
    if (vp < 0 ) {
      return true ;
    } else {
      return false ;
    }
  }
  
  
  void actualisation() {
    
    mvt += v ;
    posX += mvt ;
    if (posX > width ) { 
      posX = width  ;  
      mvt*=-1 ;
      mvt = mvt - v ;
    } else if (posX < 0 ) { 
      posX = 0 ;       
      mvt*=-1 ;
    }
  }
  
  
  //SHAPE
  void drawRect (color cIn, color cOut, float oIn, float oOut, float e, float h) {
    //security for the negative valu
    if( e < 0.1 ) e = 0.1 ;

    if (vp < oIn )   { oIn = vp ;   } else { oIn = oIn ; }
    if (vp < oOut )  { oOut = vp ;  } else { oOut = oOut ; }
    
    //life
    vp = vp + chrono ;
    chrono = -1 ; 
    
    //DISPLAY
    strokeWeight(e) ;
    fill ( cIn, oIn ) ;
    stroke (cOut, oOut ) ;
    rect ( posX ,  -e, posX - (mouse[0].x/3) , h+(2*e) ) ;
  }
  
  
  void drawBox (color cIn, color cOut, float oIn, float oOut, float e, PVector size) {
    //security for the negative valu
    if( e < 0.1 ) e = 0.1 ;

    if (vp < oIn )   { oIn = vp ;   } else { oIn = oIn ; }
    if (vp < oOut )  { oOut = vp ;  } else { oOut = oOut ; }
    
    //life
    vp = vp + chrono ;
    chrono = -1 ; 
    
    //DISPLAY
    strokeWeight(e) ;
    fill ( cIn, oIn ) ;
    stroke (cOut, oOut ) ;
    translate(posX ,  -e) ;
    box(size.x+(2*e), posX - (mouse[0].x/3), size.z+(2*e)) ;
    //rect ( posX ,  -e, posX - (mouseX/3) , size.x+(2*e) ) ;
  }
}
