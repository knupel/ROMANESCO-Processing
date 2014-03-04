///////////////////
//OBJECT ROMANESCO

//object one
class ObjectOne extends SuperRomanesco {
  
  public ObjectOne() {
    //from the index_objects.csv
    romanescoName = "MC OBJ-ONE" ;
    romanescoID = 1 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Alpha";

  }
  

  //DISPLAY
  void display() {
    //Hide this conditional
    if(parameter[romanescoID]) objectFill[romanescoID] = objectFill[0] ;
    
    fill(objectFill[romanescoID]) ;
    ellipse(mouseX, mouseY, 30,30) ;
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
    romanescoID = 2 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Alpha";
  }
  
  
  //DISPLAY
  void display() {
    //Hide this conditional
    if(parameter[romanescoID]) objectFill[romanescoID] = objectFill[0] ;
    
    fill(objectFill[romanescoID]) ;
    rect(mouseY, mouseX, 30,30) ;
  }
}
//end object two

// END OBJECT ROMANESCO
///////////////////////
