//GLOBAL
int sizeTexteInterface = 14 ;

public PFont 
      //controleur font
      police, textInterface,
      EmigreEight, FuturaStencil_20, FuturaStencil_10,

      
      //scène Font
      AmericanTypewriter, AmericanTypewriterBold,
      Banco, 
      ContainerRegular, Cinquenta,
      Diesel, 
      DinRegular, DinBold,
      EastBloc,
      FetteFraktur, FuturaStencil,
      Juanita, JuanitaOutline,
      Komikahuna,
      Mesquite,
      Minion, MinionBold,
      NanumBrush, 
      Rosewood,
      TheHardwayRMX,
      TokyoOne, TokyoOneSolid ;
      
      
//SETUP
void fontSetup() {
  //controleur Font
  String fontPathVLW = sketchPath("")+"preferences/Font/typoVLW/" ;
  EmigreEight = loadFont (fontPathVLW+"EmigreEight-14.vlw") ;
  FuturaStencil_20 = loadFont(fontPathVLW+"FuturaStencilICG-20.vlw");
  FuturaStencil_10 = loadFont(fontPathVLW+"FuturaStencilICG-10.vlw");
  //Scène Font  
  AmericanTypewriter=loadFont       (fontPathVLW+"AmericanTypewriter-96.vlw");
  AmericanTypewriterBold=loadFont   (fontPathVLW+"AmericanTypewriter-Bold-96.vlw");
  Banco=loadFont                    (fontPathVLW+"BancoITCStd-Heavy-96.vlw");
  Cinquenta=loadFont                (fontPathVLW+"CinquentaMilMeticais-96.vlw");
  ContainerRegular=loadFont         (fontPathVLW+"Container-Regular-96.vlw");
  Diesel=loadFont                   (fontPathVLW+"Diesel-96.vlw");
  DinRegular=loadFont               (fontPathVLW+"DIN-Regular-96.vlw");

  DinBold=loadFont                  (fontPathVLW+"DIN-Bold-96.vlw");
  EastBloc=loadFont                 (fontPathVLW+"EastBlocICGClosed-96.vlw");
  FuturaStencil=loadFont            (fontPathVLW+"FuturaStencilICG-96.vlw");
  FetteFraktur=loadFont             (fontPathVLW+"FetteFraktur-96.vlw");
  JuanitaOutline=loadFont           (fontPathVLW+"JuanitaDecoITCStd-96.vlw");
  Komikahuna=loadFont               (fontPathVLW+"Komikahuna-96.vlw");
  Mesquite=loadFont                (fontPathVLW+"MesquiteStd-96.vlw");
  Minion=loadFont                   (fontPathVLW+"MinionPro-Regular-96.vlw");
  MinionBold=loadFont               (fontPathVLW+"MinionPro-Bold-96.vlw");
  NanumBrush=loadFont              (fontPathVLW+"NanumBrush-96.vlw");
  Rosewood=loadFont                (fontPathVLW+"RosewoodStd-Regular-96.vlw");
  TheHardwayRMX=loadFont            (fontPathVLW+"3theHardwayRMX-96.vlw");
  TokyoOne=loadFont                (fontPathVLW+"Tokyo-One-96.vlw");
  
  //Typo for the interface
  textInterface = EmigreEight ;
  


}
