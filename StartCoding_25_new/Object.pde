///////////////////
//OBJECT ROMANESCO

//object one
class ObjectOne extends SuperRomanesco {
  public ObjectOne() {
    //from the index_objects.csv
    romanescoName = "MC OBJ-ONE" ;
    IDobj = 1 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Alpha";
  }
  //DISPLAY
  void display() {
    updateObject(IDobj, IDgroup) ;
    
    fill(fillObj[IDobj]) ;
    stroke(strokeObj[IDobj]) ;
    strokeWeight(thicknessObj[IDobj]) ;
    ellipse(mouse[IDobj].x, mouse[IDobj].y, sizeObj[IDobj].x,sizeObj[IDobj].y) ;
  }
}
//end object one


///////////////////
//OBJECT ROMANESCO

//object two
class ObjectTwo extends SuperRomanesco {
  public ObjectTwo() {
    //from the index_objects.csv
    romanescoName = "DJ NUMBER TWO" ;
    IDobj = 2 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Alpha";
  }
  //DISPLAY
  void display() {
    updateObject(IDobj, IDgroup) ;
    
    fill(fillObj[IDobj]) ;
    stroke(strokeObj[IDobj]) ;
    strokeWeight(thicknessObj[IDobj]) ;
    rect(mouse[IDobj].y, mouse[IDobj].x, 30,30) ;
  }
}
//end object two



//object three
class ObjectThree extends SuperRomanesco {
  public ObjectThree() {
    //from the index_objects.csv
    romanescoName = "Three the CUBE" ;
    IDobj = 3 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Alpha";
  }
  //DISPLAY
  void display() {
    updateObject(IDobj, IDgroup) ;
    
    fill(fillObj[IDobj]) ;
    stroke(strokeObj[IDobj]) ;
    strokeWeight(thicknessObj[IDobj]) ;
    pushMatrix() ;
    translate(mouse[IDobj].x, mouse[IDobj].y,0) ;
    box(sizeObj[IDobj].x,sizeObj[IDobj].y, sizeObj[IDobj].z) ;
    popMatrix() ;
  }
}
//end object two

// END OBJECT ROMANESCO
///////////////////////


