/**
tab name
| O for Object
| | number of the family - IDgroup -
| | | ID of the Object - IDobj -
| | | | name of your class
O_1_1_Your_Object
*/
class YourObj_3 extends Romanesco {
  public YourObj_3() {
    romanescoName = "Lobject Name" ;
    IDobj = 3 ;
    IDgroup = 1 ;
    romanescoAuthor  = "your name";
    romanescoVersion = "Version 0.0.1";
    romanescoPack = "Workshop" ;
    // separate the differentes mode by "/"
    romanescoMode = "Mode A/Mode B/Mode C" ;
    /** List of the available sliders
    "Hue fill,Saturation fill,Brightness fill,Alpha fill,Hue stroke,Saturation stroke,Brightness stroke,Alpha stroke,Thickness,
    Size X,Size Y,Size Z,Canvas X,Canvas Y,Canvas Z,Quantity,
    Speed,Direction,Angle,Amplitude,Analyze,Family,Life,Force" ; */
    romanescoSlider = "all" ;
  }
  
  // Main method
  // setup
  void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
  }
  
  // draw
  void display() {
    // display
    if(mode[IDobj] == 0 ) costume_1() ;
    if(mode[IDobj] == 1 ) costume_2() ;
  }
    
    // info
    
    /*
    Don't use with peasy cam
    */
    // objectInfo[IDobj] =("Hello, I'm "+IDobj+" and I'm not an integer. Je suis Stéphanie Lebon !!") ;
  
  // annexe void
  void costume_1() {
    stroke(0,0,100) ;
    noFill() ;
    tetrahedron(300) ;
  }
  void costume_2() {
    fill(0,0,100) ;
    text(romanescoAuthor, 0,-40)  ;
  }
}