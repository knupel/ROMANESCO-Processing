ArrayList<ClassListObject> list ;

//object one
class ObjectInTheArrayList extends SuperRomanesco {
  public ObjectInTheArrayList() {
    //from the index_objects.csv
    romanescoName = "ObjectInTheArrayList" ;
    IDobj = 4 ;
    IDgroup = 1 ;
    romanescoAuthor  = "My is Nobody";
    romanescoVersion = "Alpha 0.1";
    romanescoPack = "startCoding" ;
    romanescoRender = "classic" ;
  }
  //GLOBAL
  
  ClassListObject arrayObj[] ;
  int numObj ;
  //SETUP
  void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
    
    list = new ArrayList<ClassListObject>() ;
    numObj = 50 ;
    for ( int i = 0 ; i < numObj ; i++) {
     ClassListObject obj = new ClassListObject() ;
      list.add(obj) ;
    }
  }
  //DRAW
  void display() {
    PVector pos = new PVector(mouse[IDobj].x, mouse[IDobj].y) ;
    PVector size = new PVector (sizeXObj[IDobj],sizeYObj[IDobj]) ;

    for (int i=0 ; i < list.size() ; i++ ) {
      ClassListObject obj = (ClassListObject) list.get(i) ;
      float gitterX = random(-numObj,numObj) ;
      float gitterY = random(-numObj,numObj) ;
      pos.x += gitterX ;
      pos.y += gitterY ;
      obj.display(pos, size, fillObj[IDobj], strokeObj[IDobj]) ;
    }

    //you can use too this method
    //for ( ClassListObject obj : list ) obj.display(pos, size, fillObj[IDobj], strokeObj[IDobj]) ;
    
    //clear the list, boolean method from Romanesco Manager
    if (emptyList(IDobj)) list.clear() ;
  }
}
//end object one







//////////////
//CLASS TRIANGLE
class ClassListObject {
  ClassListObject(){}
  
  void display(PVector pos, PVector size, color cFill, color cStroke) {
    fill(cFill) ;
    stroke(cStroke) ;
    ellipse(pos.x, pos.y, size.x, size.y) ;
    
  }
}
