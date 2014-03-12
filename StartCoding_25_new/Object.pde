///////////////////
//OBJECT ROMANESCO

//object one
class ObjectAAA extends SuperRomanesco {
  public ObjectAAA() {
    //from the index_objects.csv
    romanescoName = "A CERCLE" ;
    IDobj = 1 ;
    IDgroup = 1 ;
    romanescoAuthor  = "My is Nobody";
    romanescoVersion = "Alpha 0.1";
    romanescoPack = "startCoding" ;
    romanescoRender = "classic" ;
  }
  //SETUP
  void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
  }
  //DRAW
  void display() {
    fill(fillObj[IDobj]) ; // you can use too
    fill(hue(fillObj[IDobj]), saturation(fillObj[IDobj]), brightness(fillObj[IDobj]), alpha(fillObj[IDobj])) ;
    stroke(strokeObj[IDobj]) ;
    strokeWeight(thicknessObj[IDobj]) ;
    ellipse(mouse[IDobj].x, mouse[IDobj].y, sizeXObj[IDobj],sizeYObj[IDobj]) ;

  }
}
//end object one


///////////////////
//OBJECT ROMANESCO

//object two
class ObjectZZZ extends SuperRomanesco {
  public ObjectZZZ() {
    //from the index_objects.csv
    romanescoName = "Z BOITE" ;
    IDobj = 2 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Alpha";
  }
  //SETUP
  void setting() {
   startPosition(IDobj, width/2, height/2, 0) ;
  }
  //DRAW
  void display() {
    fill(fillObj[IDobj]) ;
    stroke(strokeObj[IDobj]) ;
    strokeWeight(thicknessObj[IDobj] *left[IDobj]) ;
    pushMatrix() ;
    translate(mouse[IDobj].x*.5, mouse[IDobj].y*.5,0) ;
    box(sizeXObj[IDobj],sizeYObj[IDobj], sizeZObj[IDobj]) ;
    popMatrix() ;
  }
}
//end object two





// END OBJECT ROMANESCO
///////////////////////


