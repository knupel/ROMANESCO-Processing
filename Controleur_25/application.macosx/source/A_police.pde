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
  EmigreEight = loadFont ("typo/EmigreEight-14.vlw") ;
  FuturaStencil_20 = loadFont("typo/FuturaStencilICG-20.vlw");
  //Scène Font  
  AmericanTypewriter=loadFont       ("typo/AmericanTypewriter-96.vlw");
  AmericanTypewriterBold=loadFont   ("typo/AmericanTypewriter-Bold-96.vlw");
  Banco=loadFont                    ("typo/BancoITCStd-Heavy-96.vlw");
  Cinquenta=loadFont                ("typo/CinquentaMilMeticais-96.vlw");
  ContainerRegular=loadFont         ("typo/Container-Regular-96.vlw");
  Diesel=loadFont                   ("typo/Diesel-96.vlw");
  DinRegular=loadFont               ("typo/DIN-Regular-96.vlw");

  DinBold=loadFont                  ("typo/DIN-Bold-96.vlw");
  EastBloc=loadFont                 ("typo/EastBlocICGClosed-96.vlw");
  FuturaStencil=loadFont            ("typo/FuturaStencilICG-96.vlw");
  FetteFraktur=loadFont             ("typo/FetteFraktur-96.vlw");
  JuanitaOutline=loadFont           ("typo/JuanitaDecoITCStd-96.vlw");
  Komikahuna=loadFont               ("typo/Komikahuna-96.vlw");
  Mesquite=loadFont                ("typo/MesquiteStd-96.vlw");
  Minion=loadFont                   ("typo/MinionPro-Regular-96.vlw");
  MinionBold=loadFont               ("typo/MinionPro-Bold-96.vlw");
  NanumBrush=loadFont              ("typo/NanumBrush-96.vlw");
  Rosewood=loadFont                ("typo/RosewoodStd-Regular-96.vlw");
  TheHardwayRMX=loadFont            ("typo/3theHardwayRMX-96.vlw");
  TokyoOne=loadFont                ("typo/Tokyo-One-96.vlw");
  
  //Typo for the interface
  texteInterface = EmigreEight ;
  


}
