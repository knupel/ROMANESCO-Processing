ArrayList rideauList = new ArrayList() ;

//object one
class Rideau extends Romanesco {
  public Rideau() {
    //from the index_objects.csv
    romanescoName = "Rideau" ;
    IDobj = 19 ;
    IDgroup = 2 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Version 2.0.1";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
    romanescoMode ="Rectangle/Box" ;
    romanescoSlider = "Hue fill,Saturation fill,Brightness fill,Alpha fill,Hue stroke,Saturation stroke,Brightness stroke,Alpha stroke,Thickness,Width,Height,Depth,Canvas X,Direction,Life" ;
  }
  //GLOBAL
  

  //SETUP
  void setting() {
    startPosition(IDobj, 0, height, 0) ;
  }
  //DRAW
  void display() {
    //END OF DON'T TOUCH
    //speed / vitesse
    float vitesse = 0.01 + (speedObj[IDobj] *0.1) ;
    //durée / life
    int vie = int(map(lifeObj[IDobj],0,1,100,20000)) ;
    //thickness / épaisseur
    float thickness = 0 ;
    if(sound[IDobj]) {
      if(thicknessObj[IDobj] != 0 ) thickness = thicknessObj[IDobj] + abs(mix[IDobj]) *10 ; 
    } else thickness = thicknessObj[IDobj] ;
    
    float heightShape = sizeYObj[IDobj] *allBeats(IDobj) ;
    PVector size = new PVector(sizeXObj[IDobj], heightShape ,sizeZObj[IDobj]) ;
    
    //Color
    float opacityIn = round(alpha(fillObj[IDobj]) + ((mix[IDobj]) *25 )) ;
    float opacityOut = alpha(strokeObj[IDobj]) ;
    color colorIn = fillObj[IDobj] ;
    color colorOut = strokeObj[IDobj] ;
    
    strokeWeight(thickness) ;
    stroke(colorOut, opacityOut) ;
    fill(colorIn, opacityIn) ;
    
   //orientation / degré
   rotation(directionObj[IDobj], (mouse[IDobj].x *2) -width/2, (mouse[IDobj].y *2) -height/2 ) ;
   
   //amplitude
   float amp = map(canvasXObj[IDobj], width/10, width, width, width *5) ;
    
    for (int i=0 ; i < rideauList.size(); i++) {
      Curtain c = (Curtain) rideauList.get(i); // GET donne l'ordre d'aller chercher de la particule dans le la Valise Fourre Tout
      if (c.disparition () ) {
        rideauList.remove (i) ;
      } else {
        c.actualisation (amp);
        if(mode[IDobj] == 0) c.drawRect(size, IDobj)  ;
        if(mode[IDobj] == 1) c.drawBox(size, IDobj)  ;
      }
    }
    if ((action[IDobj] && nTouch) || rideauList.size() < 1 )  {
      rideauList.add( new Curtain(startingPosition[IDobj].x, vitesse, vie)) ;
    }
    
    // info
    objectInfo[IDobj] = ("Quantity " + rideauList.size()) ;
    
  }
}
//end object one







//////////////
//CLASS CURTAIN
class Curtain { 
  int chrono, transp, transpb ;
  int vp ;
  float croissance, v, mvt, posX ; 
  Curtain(float posX, float vitesse, int vie)  {
   v = vitesse ; 
   vp = vie ; 
   this.posX = posX ;
  }
  
  boolean disparition () {
    if (vp < 0 ) {
      return true ;
    } else {
      return false ;
    }
  }
  
  
  void actualisation(float amplitude) {
    
    mvt += v ;
    posX += mvt ;
    if (posX > amplitude / 2 ) { 
      posX = amplitude /2  ;  
      mvt*=-1 ;
      mvt = mvt - v ;
    } else if (posX < -amplitude/2 ) { 
      posX = -amplitude/2 ;       
      mvt*=-1 ;
    }
  }
  
  
  //SHAPE
  void drawRect (PVector size, int ID) {
    //life
    vp = vp + chrono ;
    chrono = -1 ;
    PVector newSize = new PVector(size.x, size.y) ;
    if(horizon[ID]) rect (posX, 0, newSize.x, newSize.y) ; else rect ( posX, -newSize.y/2, newSize.x, newSize.y ) ;
  }
  
  
  void drawBox (PVector size, int ID) {
    //life
    vp = vp + chrono ;
    chrono = -1 ; 
    
    
    PVector newSize = new PVector(size.x, size.y, size.z) ;
    if(horizon[ID]) translate(posX, 0) ; else translate(posX, -newSize.y/2) ;
    box(newSize.x, newSize.y, newSize.z) ;
  }
}
