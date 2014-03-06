////////////////////////
//SUPER CLASS ROMANESCO
abstract class SuperRomanesco {
  String romanescoName, romanescoAuthor, romanescoVersion ;
  int IDobj, IDgroup ;
  //object manager return
  ObjectRomanescoManager orm ;
  
  public SuperRomanesco() {
    romanescoName = "Unknown" ;
    romanescoAuthor = "Anonymous";
    romanescoVersion = "Alpha";
    IDgroup = 0 ;
    IDobj = 0 ;
  }
  
  //manager return
  void setManagerReference(ObjectRomanescoManager orm) {
    this.orm = orm;
  }
  
  //IMPORTANT
  //declared the void use in the sub-classes here
  abstract void display();
}
// END SUPER ROMANESCO
///////////////////////
