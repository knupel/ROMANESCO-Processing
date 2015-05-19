//LIGHT and SHADER
//////////////////


// SHADER PIX LIGHT
///////////////////
PShader pixShader;

void shaderSetup() {
  String path = (preferencesPath +"shader/") ;
  pixShader = loadShader(path+"pixFrag.glsl", path+"pixVert.glsl");
}

void callShader() {
  /* in the draw */
  shader(pixShader);
}







/// AMBIENT LIGHT
/////////////////
void ambientLightPix(Vec4 rgba) {
      float alphaNormal = map(rgba.a,0,g.colorModeA,0,1) ;
  /**
   check the color mode of your skecth, if this one is on RGB, you must apply the alpha on RGB component, else in HSB you must apply only on SB components 
   */
  if(g.colorMode == 1 ) {
    rgba.r *= alphaNormal ;
    rgba.g *= alphaNormal ;
    rgba.b *= alphaNormal; 
  } else {
    rgba.g *= alphaNormal ; 
    rgba.b *= alphaNormal  ;
  }
  ambientLight(rgba.r, rgba.g, rgba.b);
}
void ambientLightPix(Vec4 rgba, Vec3 pos) {
      float alphaNormal = map(rgba.a,0,g.colorModeA,0,1) ;
  /** 
  check the color mode of your skecth, if this one is on RGB, you must apply the alpha on RGB component, else in HSB you must apply only on SB components 
  */
  if(g.colorMode == 1 ) {
    rgba.r *= alphaNormal ;
    rgba.g *= alphaNormal ;
    rgba.b *= alphaNormal; 
  } else {
    rgba.g *= alphaNormal ; 
    rgba.b *= alphaNormal  ;
  }
  ambientLight(rgba.r, rgba.g, rgba.b, pos.x, pos.y, pos.z);
}
// END AMBIENT LIGHT
////////////////////


//DIRECTIONAL LIGHT
///////////////////
/**
open a list of lights with a max of height lights
@param Vec4 [] colour RGBa float component value 0-255
@param Vec4 [] dir xyz float component value -1 to 1
*/
// specific void
///////////////
void directionalLightPix(Vec4 rgba, Vec3 dir) {
    float alphaNormal = map(rgba.a,0,g.colorModeA,0,1) ;
  /**
  check the color mode of your skecth, if this one is on RGB, you must apply the alpha on RGB component, else in HSB you must apply only on SB components 
   */
  if(g.colorMode == 1 ) {
    rgba.r *= alphaNormal ;
    rgba.g *= alphaNormal ;
    rgba.b *= alphaNormal; 
  } else {
    rgba.g *= alphaNormal ; 
    rgba.b *= alphaNormal  ;
  }
  directionalLight(rgba.r, rgba.g, rgba.b, dir.x, dir.y, dir.z);
  
}
// END DIRECTIONAL LIGHT
////////////////////////





// POINT LIGTH
//////////////
void pointLightList() {
  float r = 255 *abs(cos(frameCount *.01)) ;
  float g = 255 *abs(cos(frameCount *.002)) ;
  float b = 255 *abs(cos(frameCount *.003)) ;
  float a = 255 ;
  Vec4 colorLightOne = new Vec4(r, g, b, a) ;
  Vec4 colorLightTwo = new Vec4(g, b,  r, a) ;
    float x = mouseX ;
  float y = mouseY ;
  float z = 200 ;
  Vec3 posLightOne = new Vec3(x, y, z) ;
  x = width -mouseX ;
  y = height -mouseY ;
  Vec3 posLightTwo = new Vec3(x, y, z) ;
  pointLightPix(colorLightOne, posLightOne);
  pointLightPix(colorLightTwo, posLightTwo);
}


void pointLightPix(Vec4 colourPlusAlpha, Vec3 pos) {
   float alpha = map(colourPlusAlpha.a,0,255,0,1) ;
   pointLight(colourPlusAlpha.r *alpha, colourPlusAlpha.g *alpha, colourPlusAlpha.b *alpha, pos.x, pos.y, pos.z) ;
}








//SPOT LIGHT
/////////////
void spotLightPixList() {
  float r = 255 *abs(cos(frameCount *.002)) ;
  float g = 255 *abs(cos(frameCount *.01)) ;
  float b = 255 *abs(cos(frameCount *.004)) ;
  float a = 255 ;
  Vec4 colorLightOne = new Vec4(r, g, b, a) ;
  Vec4 colorLightTwo = new Vec4(g, b,  r, a) ;
  Vec4 colorLightThree = new Vec4(b, r,  g, a) ;
  
  float x = mouseX ;
  float y = mouseY ;
  float z = 200 ;
  Vec3 posLightOne = new Vec3(x, y, z) ;
  x = width -mouseX ;
  y = height -mouseY ;
  Vec3 posLightTwo = new Vec3(x, y, z) ;
  x = width *sin(frameCount *.002) ;
  y = height *sin(frameCount *.01) ;
  Vec3 posLightThree = new Vec3(x, y, z) ;
  
  float dirX = 0 ;
  float dirY = 0 ;
  float dirZ = -1 ;
  Vec3 dirLight = new Vec3(dirX, dirY, dirZ) ;
  
  /*
  float ratio = 1.2 +(5 *abs(sin(frameCount *.003))) ;
  float angle = TAU/ratio ; // good from PI/2 to
  float concentration = 1+ 100 *abs(sin(frameCount *.004)); // try 1 > 1000
  */
   float angle = TAU /2 ;
  float concentration = 100 ;

  
  spotLightPix(colorLightOne, posLightOne, dirLight, angle, concentration) ;
  spotLightPix(colorLightTwo, posLightTwo, dirLight, angle, concentration) ;
  spotLightPix(colorLightThree, posLightThree, dirLight, angle, concentration) ;
}

void spotLightPix(Vec4 rgba, Vec3 pos, Vec3 dir, float angle, float concentration) {
   float alpha = map(rgba.a,0,255,0,1) ;
   spotLight(rgba.r *alpha, rgba.g *alpha, rgba.b *alpha, pos.x, pos.y, pos.z, dir.x, dir.y, dir.z, angle, concentration) ;
}
// END SHADER PIX LIGTH
//////////////////////

// END LIGHT
////////////







// GLOBAL SHADER
////////////////
void  shaderDraw() {
  // Color value fro the global vertex
  ////////////////////////////////////
  Vec4 RGBa = new Vec4(1, 1, 1, .5) ; // it's OPENGL data between 0 to 1 
    // the range is between -1 to 1, you can go beyond but take care at your life !
  PVector RGB = new PVector(RGBa.r, RGBa.g, RGBa.b);

  pixShader.set("colorVertex", RGB);
  pixShader.set("alphaVertex", RGBa.a);
  // pixlightShader.set("contrast", 1.);
  
  
  // vertex position
  //////////////////
  // float canvasZ = cos(frameCount *.01) ;
  PVector canvasXYZ = new PVector (1,1,1) ;
  
  pixShader.set("canvas", canvasXYZ);
  pixShader.set("zoom", 1.);
}

// GLOBAL SHADER
////////////////
