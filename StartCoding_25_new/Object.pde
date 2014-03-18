//////////////////
//OBJECT ROMANESCO
class ObjectAAA extends SuperRomanesco {
  public ObjectAAA() {
    //from the index_objects.csv
    romanescoName = "A CERCLE" ;
    IDobj = 1 ;
    IDgroup = 1 ;
    romanescoAuthor  = "My name is Nobody";
    romanescoVersion = "Alpha 2.0";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
    romanescoMode = "alpha/.../.../omega" // separate the name by a slash and write the next mode immadialtly after this one.
  }
  //GLOBAL
  
  
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


