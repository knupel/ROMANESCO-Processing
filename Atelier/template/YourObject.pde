class Object extends SuperRomanesco {
  public Object() {
    //Send to the index_objects.csv. This file is used by the controller
    romanescoName = "Object Name" ;
    IDobj = 19 ; // depend where your want your object in Romanesco controller
    IDgroup = 2 ;  // choice a Romanesco Group 1 to 3
    romanescoAuthor  = "Author Name";
    romanescoVersion = "Version 1.0";
    romanescoPack = "Base" ;
    romanescoMode = "modeName/modenam" ; // separate each name by "/"
    
    /* Choice which slider can influence your object, see the file in the FOLDER "...HELP/Romanesco Code/GLOBAL CODE OBJECT.txt"
    below an example.
    Becareful you must seprate the name slider by a coma without space*/
    romanescoSlider = "Hue stroke,Thickness,Speed" ;
    /*
    Hue fill,Saturation fill,Brightness fill,Alpha fill,
           Hue stroke,Saturation stroke,Brightness stroke, Alpha stroke,
           Thickness,
           Width,Height,Depth,
           Canvas X,Canvas Y,Canvas Z,
           Family,Quantity,Life,
           Speed,Direction,Angle,
           Amplitude,Attraction, Repulsion,
           Analyze,Family,Life," ;

    */
  }
  
  
  
  //SETUP
  void setting() {
   startPosition(IDobj, width/2, height/2, 0) ;
 }
 
 //DRAW
  void display() {
    // INFO
    objectInfo[IDobj] = ("") ;
  }
}
