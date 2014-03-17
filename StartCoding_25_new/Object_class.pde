Object obj ;
//object three
class ObjectMMM extends SuperRomanesco {
  public ObjectMMM() {
    //from the index_objects.csv
    romanescoName = "M CLASS" ;
    IDobj = 3 ;
    IDgroup = 1 ;
    romanescoAuthor  = "My is Nobody";
    romanescoAuthor  = "My name is Nobody";
    romanescoVersion = "Alpha 2.0";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
  }
  //GLOBAL

  
  
  //SETUP
  void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
    obj = new Object () ;
  }
  
  
  //DRAW
  void display() {
    color c = color(fillObj[IDobj]) ; // you can use too
    PVector pos = new PVector(mouse[IDobj].x , mouse[IDobj].y) ;
    obj.stuffToDisplay(pos, c) ;
    
  }
}
//end object two

class Object {
  
  Object() {}
  
  void stuffToDisplay(PVector pos, color c) {
    fill(c) ;
    ellipse(pos.x, pos.y,30,30) ;
  }
}
