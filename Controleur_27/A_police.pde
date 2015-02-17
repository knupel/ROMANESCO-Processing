//GLOBAL


public PFont 
      //controleur font
      textUsual_1, textUsual_2, textUsual_3,
      title_1, title_2,
      FuturaCondLight_10, FuturaCondLight_11,FuturaCondLight_12,
      FuturaStencil_20, FuturaStencil_10 ;
      
//SETUP
void fontSetup() {
  //controleur Font
  String fontPathVLW = sketchPath("")+"preferences/Font/typoVLW/" ;
  FuturaStencil_20 = loadFont(fontPathVLW+"FuturaStencilICG-20.vlw");
  FuturaStencil_10 = loadFont(fontPathVLW+"FuturaStencilICG-10.vlw");
  FuturaCondLight_10 = loadFont(fontPathVLW+"Futura-CondensedLight-10.vlw");
  FuturaCondLight_11 = loadFont(fontPathVLW+"Futura-CondensedLight-11.vlw");
  FuturaCondLight_12 = loadFont(fontPathVLW+"Futura-CondensedLight-12.vlw");
  
  textUsual_1 = FuturaCondLight_10 ;
  textUsual_2 = FuturaCondLight_11 ;
  textUsual_3 = FuturaCondLight_12 ;
  title_1 = FuturaStencil_10 ;
  title_2 = FuturaStencil_20 ;
}
