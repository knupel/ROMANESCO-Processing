   ////////////////////////////////////////////////////////////////////////
  // Romanesco Contrôleur Alpha 0.25 work with Processing 211  ///////////
 ////////////////////////////////////////////////////////////////////////
String release = ("25") ;
boolean test = false ;

void setup() {
  setting() ;
  loadSetup() ;
  interfaceSetup() ;
  sendOSCsetup() ;
}

void draw() {
  structureDraw() ;
  interfaceDraw() ;
  sendOSCdraw() ;
}
