   ////////////////////////////////////////////////////////////////////////
  // Romanesco Contrôleur Alpha 0.24 work with Processing 203  /////
 ////////////////////////////////////////////////////////////////////////

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
