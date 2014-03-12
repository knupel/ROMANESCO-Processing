//GLOBAL
int sizeTexteInterface = 14 ;

public PFont 
      //controleur font
      police, texteInterface,
      EmigreEight, FuturaStencil_20,

      
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
  EmigreEight = loadFont ("preferences/typo/EmigreEight-14.vlw") ;
  FuturaStencil_20 = loadFont("preferences/typo/FuturaStencilICG-20.vlw");
  //Scène Font  
  AmericanTypewriter=loadFont       ("preferences/typo/AmericanTypewriter-96.vlw");
  AmericanTypewriterBold=loadFont   ("preferences/typo/AmericanTypewriter-Bold-96.vlw");
  Banco=loadFont                    ("preferences/typo/BancoITCStd-Heavy-96.vlw");
  Cinquenta=loadFont                ("preferences/typo/CinquentaMilMeticais-96.vlw");
  ContainerRegular=loadFont         ("preferences/typo/Container-Regular-96.vlw");
  Diesel=loadFont                   ("preferences/typo/Diesel-96.vlw");
  DinRegular=loadFont               ("preferences/typo/DIN-Regular-96.vlw");

  DinBold=loadFont                  ("preferences/typo/DIN-Bold-96.vlw");
  EastBloc=loadFont                 ("preferences/typo/EastBlocICGClosed-96.vlw");
  FuturaStencil=loadFont            ("preferences/typo/FuturaStencilICG-96.vlw");
  FetteFraktur=loadFont             ("preferences/typo/FetteFraktur-96.vlw");
  JuanitaOutline=loadFont           ("preferences/typo/JuanitaDecoITCStd-96.vlw");
  Komikahuna=loadFont               ("preferences/typo/Komikahuna-96.vlw");
  Mesquite=loadFont                ("preferences/typo/MesquiteStd-96.vlw");
  Minion=loadFont                   ("preferences/typo/MinionPro-Regular-96.vlw");
  MinionBold=loadFont               ("preferences/typo/MinionPro-Bold-96.vlw");
  NanumBrush=loadFont              ("preferences/typo/NanumBrush-96.vlw");
  Rosewood=loadFont                ("preferences/typo/RosewoodStd-Regular-96.vlw");
  TheHardwayRMX=loadFont            ("preferences/typo/3theHardwayRMX-96.vlw");
  TokyoOne=loadFont                ("preferences/typo/Tokyo-One-96.vlw");
  
  //Typo for the interface
  texteInterface = EmigreEight ;
  


}
