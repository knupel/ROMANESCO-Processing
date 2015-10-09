class Test extends Romanesco {
  public Test() {
    romanescoName = "Test" ;
    IDobj = 6 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Stan le Punk";
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
    test() ;
    
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
    box(100,100,100) ;
  }
  void costume_2() {
    fill(0,0,100) ;
    text(romanescoAuthor, 0,0)  ;
  }
  
  
  
   void test() {
      println("mouse: ", mouse[IDobj].x,mouse[IDobj].y) ;
      println("wheel: ", wheel[IDobj]) ;
      if(clickLongLeft[IDobj]) println("long left") ;
      if(clickLongRight[IDobj]) println("long right") ;
      if(clickShortLeft[IDobj]) println("short left") ;
      if(clickShortRight[IDobj]) println("short right") ;
      
      // common key event
      if(nTouch) println("make something new and shave your face") ;
      if(rTouch) println("reverse your head janus") ;
      if(xTouch) println("make somthing special") ;
      if(hTouch) println("look the the horizon if you see a boat") ;
      
      if(aTouch) println("aaaaaaa") ;
      if(bTouch) println("bbbbbbb") ;
      // if(cTouch) println("aaaaaaa") ;
      if(dTouch) println("ddddddd") ;
      if(eTouch) println("eeeeeee") ;
      if(fTouch) println("ffffffff") ;
      // if(gTouch) println("aaaaaaa") ;
      if(jTouch) println("jjjjjjjj") ;
      if(kTouch) println("kkkkkkkk") ;
      if(lTouch) println("lllllllll") ;
      if(oTouch) println("ooooooooo") ;
      if(pTouch) println("ppppppppp") ;
      if(qTouch) println("qqqqqqqq") ;
      if(sTouch) println("ssssssss") ;
      if(tTouch) println("tttttttt") ;
      if(uTouch) println("uuuuuuuu") ;
      if(wTouch) println("wwwwwwww") ;
      if(yTouch) println("yyyyyyyy") ;
      if(zTouch) println("zzzzzzzz") ;
    }
}