////////////////////////
//SUPER CLASS ROMANESCO
abstract class SuperRomanesco {
  String romanescoName, romanescoAuthor, romanescoVersion ;
  int romanescoID ;
  //object manager return
  ObjectRomanescoManager orm ;
  
  public SuperRomanesco() {
    romanescoName = "Unknown" ;
    romanescoAuthor = "Anonymous";
    romanescoVersion = "Alpha";
    romanescoID = 0 ;
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
