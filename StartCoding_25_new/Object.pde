///////////////////
//OBJECT ROMANESCO

//object one
class ObjectAAA extends SuperRomanesco {
  public ObjectAAA() {
    //from the index_objects.csv
    romanescoName = "A CERCLE" ;
    IDobj = 1 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Alpha";
  }
  //DISPLAY
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
    romanescoName = "Z RECTANGLE" ;
    IDobj = 2 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Alpha";
  }
  //DISPLAY
  void display() {
    fill(fillObj[IDobj]) ;
    stroke(strokeObj[IDobj]) ;
    strokeWeight(thicknessObj[IDobj]) ;
    rect(mouse[IDobj].y, mouse[IDobj].x, sizeXObj[IDobj] *band[IDobj][0],sizeYObj[IDobj] *band[IDobj][1]) ;
  }
}
//end object two



//object three
class ObjectMMM extends SuperRomanesco {
  public ObjectMMM() {
    //from the index_objects.csv
    romanescoName = "M BOITE" ;
    IDobj = 3 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Alpha";
  }
  //DISPLAY
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


