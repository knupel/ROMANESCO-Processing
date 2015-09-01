// Tab: A_police


public PFont 
      //controleur font
      textUsual_1, textUsual_2, textUsual_3,
      titleMedium, titleBig,
      
      titleButtonMedium,
      title_dropdown_medium,
      
      FuturaExtraBold_9, FuturaExtraBold_10,
      FuturaCondLight_10, FuturaCondLight_11,FuturaCondLight_12,
      FuturaStencil_20 ;
      
//SETUP
void fontSetup() {
  //controleur Font
  String fontPathVLW = sketchPath("")+"preferences/Font/typoVLW/" ;
  FuturaStencil_20 = loadFont(fontPathVLW+"FuturaStencilICG-20.vlw");
  FuturaExtraBold_9 = loadFont(fontPathVLW+"Futura-ExtraBold-9.vlw");
  FuturaExtraBold_10 = loadFont(fontPathVLW+"Futura-ExtraBold-10.vlw");
  FuturaCondLight_10 = loadFont(fontPathVLW+"Futura-CondensedLight-10.vlw");
  FuturaCondLight_11 = loadFont(fontPathVLW+"Futura-CondensedLight-11.vlw");
  FuturaCondLight_12 = loadFont(fontPathVLW+"Futura-CondensedLight-12.vlw");
  
  textUsual_1 = FuturaCondLight_10 ;
  textUsual_2 = FuturaCondLight_11 ;
  textUsual_3 = FuturaCondLight_12 ;

  
  titleMedium = FuturaExtraBold_10 ;
  titleBig = FuturaStencil_20 ;
  
  titleButtonMedium = titleMedium ;
  title_dropdown_medium = titleMedium ;
}
