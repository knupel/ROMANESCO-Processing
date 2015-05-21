/*
Here you find : 
CURSOR, PEN, LEAP MOTION
GRAPHIC CONFIGURATION
MIRROIR

*/


//CURSOR, PEN, LEAP MOTION

void cursorDraw() {
  //mousePressed
  if(ORDER_ONE || ORDER_TWO || ORDER_THREE) ORDER = true ; else ORDER = false ;  
  
  //next previous
  if (nextPrevious) nextPreviousInt = 1 ; else nextPreviousInt = 0 ;
}
///////////////
//END CURSOR, PEN, 













// LIGHT ROMANESCO
//////////////////
void lightSetup() {
  if(modeP3D) {
    shaderSetup() ;
    float min =.001 ;
    float max = 0.3 ;
    speedColorLight = new PVector(random(min,max),random(min,max),random(min,max)) ;
  }
}
// END SETUP
////////////



//DRAW


PVector speedColorLight = new PVector(0,0,0) ;
// ambient
Vec4 colourAmbient = Vec4() ;
Vec4 colourAmbientRef = Vec4() ;
// directional light 1
Vec4 colorLightDir_1 = Vec4(0,100,100,100);
Vec3 dirLightDir_1 = Vec3(0,0,1);
Vec4 colorLightDir_1_ref = Vec4();
Vec3 dirLightDir_1_ref = Vec3();

// directional light 2
Vec4 colorLightDir_2 = Vec4(0,100,100,100);
Vec3 dirLightDir_2 = Vec3(0,0,1);
Vec4 colorLightDir_2_ref = Vec4();
Vec3 dirLightDir_2_ref = Vec3();


/*
boolean lightOneMove, lightTwoMove, lightAmbientMove ;
boolean AmbientOnOff  ;
boolean directionalLightOneOnOff, directionalLightTwoOnOff  ;
*/


void lightDraw() {
  if(modeP3D) {
    callShader() ;
    
    // ambient light
    // if(eLightAmbient == 1 ) AmbientOnOff = true ; else AmbientOnOff = false ;
    if(onOffLightAmbient){ 
      //if(eLightAmbientAction == 1 ) lightAmbientMove = true ; else lightAmbientMove = false ;
      Vec4 newRef = Vec4(map(valueSlider[0][12],0,MAX_VALUE_SLIDER,0,HSBmode.x), map(valueSlider[0][13],0,MAX_VALUE_SLIDER,0,HSBmode.y), map(valueSlider[0][14],0,MAX_VALUE_SLIDER,0,HSBmode.z),HSBmode.w) ;
      if(!equals(newRef, colourAmbientRef)) colourAmbient = newRef.copy() ;
      colourAmbientRef = newRef.copy() ;
      ambientLightPix(colourAmbient) ;
    }
    
    // Directional light one
   // if(eLightOne == 1 ) directionalLightOneOnOff = true ; else directionalLightOneOnOff = false ;
   if(onOffDirLightOne) {
     // direction
      // if(eLightOneAction == 1 ) lightOneMove = true ; else lightOneMove = false ;
      if(onOffDirLightOneAction) {
        Vec3 newRefDir = Vec3(map(lightPos.x,0,width, -1,1),map(lightPos.y,0,height, -1,1),map(lightPos.z,-750,750, -1,1)) ;
        if(!equals(newRefDir, dirLightDir_1_ref)) dirLightDir_1 = newRefDir.copy() ;
        dirLightDir_1_ref = newRefDir.copy() ;
      }
      // color
      Vec4 newRefColor = Vec4(map(valueSlider[0][6], 0, MAX_VALUE_SLIDER, 0, HSBmode.x), map(valueSlider[0][7],0, MAX_VALUE_SLIDER, 0, HSBmode.y), map(valueSlider[0][8], 0, MAX_VALUE_SLIDER, 0, HSBmode.z),HSBmode.w) ;
      if(!equals(newRefColor, colorLightDir_1_ref)) colorLightDir_1 = newRefColor.copy() ;
      colorLightDir_1_ref = newRefColor.copy() ;
      // rendering
      directionalLightPix(colorLightDir_1, dirLightDir_1) ;
    }
    
    // Directional light two
   //  if(eLightTwo == 1 ) directionalLightTwoOnOff = true ; else directionalLightTwoOnOff = false ;
   if(onOffDirLightTwo) {
     // direction
      // if(eLightTwoAction == 1 ) lightTwoMove = true ; else lightTwoMove = false ;
      if(onOffDirLightTwoAction) {
        Vec3 newRefDir = Vec3(map(lightPos.x,0,width, 1,-1),map(lightPos.y,0,height, 1,-1),map(lightPos.z,-750,750, 1,-1)) ;
        if(!equals(newRefDir, dirLightDir_2_ref)) dirLightDir_2 = newRefDir.copy() ;
        dirLightDir_2_ref = newRefDir.copy() ;
      }
      // color
      Vec4 newRefColor = Vec4(map(valueSlider[0][9], 0, MAX_VALUE_SLIDER, 0, HSBmode.x), map(valueSlider[0][10],0, MAX_VALUE_SLIDER, 0, HSBmode.y), map(valueSlider[0][11], 0, MAX_VALUE_SLIDER, 0, HSBmode.z),HSBmode.w) ;
      if(!equals(newRefColor, colorLightDir_2_ref)) colorLightDir_2 = newRefColor.copy() ;
      colorLightDir_2_ref = newRefColor.copy() ;
      //colorLightDir_2 = new Vec4 (map(valueSlider[0][9], 0, MAX_VALUE_SLIDER, 0, HSBmode.x), map(valueSlider[0][10],0, MAX_VALUE_SLIDER, 0, HSBmode.y), map(valueSlider[0][11], 0, MAX_VALUE_SLIDER, 0, HSBmode.z),HSBmode.w) ;
      // rendering
      directionalLightPix(colorLightDir_2, dirLightDir_2) ;
    }
    
  }
}
// END LIGHT ROMANESCO
//////////////////////
