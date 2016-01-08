// Tab: Z_background
// Z BACKGROUND 1.1


// GENERIC BACKGROUND METHOD for 2D and 3D
//////////////////////////////////////////
// Background jan 2016 version 0.3

float MAX_RATIO_DEPTH = 6.9 ;


// BACKGROUND 3D
////////////////

// Background normal
////////////////////
void background_norm_P3D(Vec4 bg) {
  background_norm_P3D(bg.x, bg.y, bg.z, bg.a) ;
}

void background_norm_P3D(Vec3 bg) {
  background_norm_P3D(bg.x, bg.y, bg.z, 1) ;
}

void background_norm_P3D(float c, float a) {
  background_norm_P3D(c, c, c, a) ;
}

void background_norm_P3D(float c) {
  background_norm_P3D(c, c, c, 1) ;
}

void background_norm_P3D(float r,float g, float b) {
  background_norm_P3D(r, g, b, 1) ;
}



void background_norm_P3D(float r_c, float g_c, float b_c, float a_c) {
  float x = map(r_c,0,1, 0, g.colorModeX) ;
  float y = map(g_c,0,1, 0, g.colorModeY) ;
  float z = map(b_c,0,1, 0, g.colorModeZ) ;
  float a = map(a_c,0,1, 0, g.colorModeA) ;
  noStroke() ;
  fill(x, y, z, a) ;
  int canvas_x = width *100 ;
  int canvas_y = height *100 ;
  int pos_x = - canvas_x /2 ;
  int pos_y = - canvas_y /2 ;
  // this problem of depth is not clarify, is must refactoring
  int pos_z = int( -height *MAX_RATIO_DEPTH) ;
  pushMatrix() ;
  translate(0,0,pos_z) ;
  rect(pos_x,pos_y,canvas_x, canvas_y) ;
  popMatrix() ;
}



// BACKGROUND 2D
/////////////////

void background_norm(Vec4 bg) {
  background_norm(bg.x,bg.y,bg.z,bg.a) ;
}


void background_norm(Vec3 bg) {
  background_norm(bg.x,bg.y,bg.z,1) ;
}

void background_norm(float c) {
  background_norm(c,c,c,1) ;
}

void background_norm(float c, float a) {
  background_norm(c,c,c,a) ;
}

void background_norm(float r,float g,float b) {
  background_norm(r,g,b,1) ;
}


void background_norm(float r_c,float g_c,float b_c,float a_c) {
  float x = map(r_c,0,1, 0, g.colorModeX) ;
  float y = map(g_c,0,1, 0, g.colorModeY) ;
  float z = map(b_c,0,1, 0, g.colorModeZ) ;
  float a = map(a_c,0,1, 0, g.colorModeA) ;
  noStroke() ;
  fill(x, y, z, a) ;
  rect(0,0,width, height) ;
}
//diffenrent background
/*
void background_classic(Vec4 c) {
  //DISPLAY FINAL
  noStroke() ;
  fill(c.r,c.g, c.b, c.a) ;
  rect (0,0, width, height) ;
}

//P3D
//BACKGROUND
////////////
void background_P3D(Vec4 c) {
  // I don't remember why there is an alpha comparaison with under or upper 90 ?
  if(c.a < 95 ) {
    fill(c.r, c.g, c.b, c.a) ;
    noStroke() ;
    int pos_z = int( -height *MAX_RATIO_DEPTH) ;
    pushMatrix() ;
    translate(-sizeBackgroundP3D.x *.5,-sizeBackgroundP3D.y *.5 , pos_z) ;
    rect(0,0, sizeBackgroundP3D.x, sizeBackgroundP3D.y) ;
    popMatrix() ;
  } else {
    background(c.r, c.g, c.b, c.a) ;
  }
}
*/











// ROMANESCO BACKGROUND
///////////////////////
//////////////////////////////////////////////////////////////////
Vec4  colorBackground, colorBackgroundRef, colorBackgroundPrescene;


void background_setup() {
  colorBackgroundRef = Vec4() ;
  colorBackground = Vec4() ;
  colorBackgroundPrescene = Vec4(0,0,20,g.colorModeA) ;
}


void background_romanesco() {
  // in preview mode the background is always on, to remove the trace effect
  if(!fullRendering) { 
    onOffBackground = false ;
    colorBackground = colorBackgroundPrescene.copy() ;
    background_norm_P3D(colorBackground.normalize(Vec4(g.colorModeX,g.colorModeY,g.colorModeZ,g.colorModeA ))) ;
  } else {
    if(onOffBackground) {
      if(whichShader == 0) {
        // check if the color model is changed after the shader used
        if(g.colorModeX != 360 || g.colorModeY != 100 || g.colorModeZ !=100 || g.colorModeA !=100) colorMode(HSB,360,100,100,100) ;
        // choice the rendering color palette for the classic background
        if(fullRendering) {
          // check if the slider background are move, if it's true update the color background
          if(!compare(colorBackgroundRef,update_background())) colorBackground = update_background().copy() ;
          else colorBackgroundRef = update_background().copy() ;
          background_norm_P3D(colorBackground.normalize(Vec4(g.colorModeX,g.colorModeY,g.colorModeZ,g.colorModeA ))) ;
        } 
        background_norm_P3D(colorBackground.normalize(Vec4(g.colorModeX,g.colorModeY,g.colorModeZ,g.colorModeA ))) ;
      } else {
        background_shader_draw(modeP3D, whichShader) ;
      }
    }
  }
}






// ANNEXE VOID BACKGROUND
/////////////////////////
Vec4 update_background() {
  //to smooth the curve of transparency background
  // HSB
  float hue_bg =         map(valueSlider[0][0],0,MAX_VALUE_SLIDER,0,HSBmode.r) ;
  float saturation_bg =  map(valueSlider[0][1],0,MAX_VALUE_SLIDER,0,HSBmode.g) ;
  float brigthness_bg =  map(valueSlider[0][2],0,MAX_VALUE_SLIDER,0,HSBmode.b) ;
  // ALPHA
  float factorSmooth = 2.5 ;
  float nx = norm(valueSlider[0][3], 0.0 , MAX_VALUE_SLIDER) ;
  float alpha = pow (nx, factorSmooth);
  alpha = map(alpha, 0, 1, 0.8, HSBmode.a) ;
  return Vec4(hue_bg,saturation_bg,brigthness_bg,alpha) ;
}







// BACKGROUND SHADER
PShader blurOne, blurTwo, cellular, damierEllipse, heart, necklace,  psy, sinLight, snow ;
//PShader bizarre, water, psyTwo, psyThree ;

void background_shader_setup(boolean renderP3D) {
  if(renderP3D) {
    String pathShaderBG = preferencesPath +"shader/shader_bg/" ;
    

    blurOne = loadShader(pathShaderBG+"blurOneFrag.glsl") ;
    blurTwo = loadShader(pathShaderBG+"blurTwoFrag.glsl") ;
    cellular = loadShader(pathShaderBG+"cellularFrag.glsl") ;
    damierEllipse = loadShader(pathShaderBG+"damierEllipseFrag.glsl") ;
    heart = loadShader(pathShaderBG+"heartFrag.glsl") ;
    necklace = loadShader(pathShaderBG+"necklaceFrag.glsl") ;
    psy = loadShader(pathShaderBG+"psyFrag.glsl") ;
    sinLight = loadShader(pathShaderBG+"sinLightFrag.glsl") ;
    snow = loadShader(pathShaderBG+"snowFrag.glsl") ;

    /*
    bizarre = loadShader(pathShaderBG+"bizarreFrag.glsl") ; // work bad
    water = loadShader(pathShaderBG+"waterFrag.glsl") ; // problem
    psyTwo = loadShader(pathShaderBG+"psyTwoFrag.glsl") ; // problem
    psyThree = loadShader(pathShaderBG+"psyThreeFrag.glsl") ; // problem
    */
  }
}



void background_shader_draw(boolean renderP3D, int whichOne) {
  if( (renderP3D && testRomanesco) ||  (renderP3D && fullRendering) ) {
    PVector posBGshader = new PVector(0,0) ;
    PVector sizeBGshader = new PVector(width,height, height) ; 
    fill(0) ; noStroke() ;

    if     (whichOne ==1) rectangle(posBGshader, sizeBGshader, blurOne ) ;
    else if(whichOne ==2) rectangle(posBGshader, sizeBGshader, blurTwo ) ;
    else if(whichOne ==3) rectangle(posBGshader, sizeBGshader, cellular) ;
    else if(whichOne ==4) rectangle(posBGshader, sizeBGshader, damierEllipse) ;
    else if(whichOne ==5) rectangle(posBGshader, sizeBGshader, heart) ;
    else if(whichOne ==6) rectangle(posBGshader, sizeBGshader, necklace) ;
    else if(whichOne ==7) rectangle(posBGshader, sizeBGshader, psy) ;
    else if(whichOne ==8) rectangle(posBGshader, sizeBGshader, snow ) ;
    else if(whichOne ==9) rectangle(posBGshader, sizeBGshader, sinLight ) ;
    
    
    //rectangle(posBGshader, sizeBGshader, bizarre) ;  // work bad
    //rectangle(posBGshader, sizeBGshader, water) ; // problem
    //rectangle(posBGshader, sizeBGshader, psyTwo) ; // problem
    //rectangle(posBGshader, sizeBGshader, psyThree) ; // problem
  }  else if (whichOne != 0  ) {
    background_norm_P3D(Vec4(1)) ;
    int sizeText = 14 ;
    textSize(sizeText) ;
    fill(orange) ; noStroke() ;
    text("Shader is ON", sizeText, height/3) ;
  } 

}

float shaderMouseX, shaderMouseY ;
void rectangle(PVector pos, PVector size, PShader s) {
  int factorSize = 10 ;
  size.mult(factorSize) ;
  pushMatrix() ;
  translate(-size.x *.5,-size.y *.5 , -size.z*.5) ;
  shader(s) ;
  
  

  Vec4 RGBbackground = HSBa_to_RGBa( map(valueSlider[0][0],0,MAX_VALUE_SLIDER,0,g.colorModeX), 
                                map(valueSlider[0][1],0,MAX_VALUE_SLIDER,0,g.colorModeY), 
                                map(valueSlider[0][2],0,MAX_VALUE_SLIDER,0,g.colorModeZ),
                                map(valueSlider[0][3],0,MAX_VALUE_SLIDER,0,g.colorModeA)  ) ;
  float redNorm = map(RGBbackground.x,0,255,0,1) ;
  float greenNorm = map(RGBbackground.y,0,255,0,1) ;
  float blueNorm = map(RGBbackground.z,0,255,0,1) ;
  float alphaNorm = map(RGBbackground.w,0,255,0,1) ;
  float varTime = (float)millis() *.001 ;
  if(spaceTouch) {
    shaderMouseX = map(mouse[0].x,0,width,0,1) ;
    shaderMouseY = map(mouse[0].y,0,height,0,1) ;
  }
  
  s.set("colorBG",redNorm, greenNorm, blueNorm, alphaNorm) ; 
  s.set("mixSound", mix[0]) ;
  s.set("timeTrack", getTimeTrack()) ;
  s.set("tempo", tempo[0]) ;
  s.set("beat", allBeats(0)) ;
  s.set("mouse",shaderMouseX, shaderMouseY) ;
  s.set("resolution",size.x/factorSize, size.y/factorSize) ;
  s.set("time", varTime);
  
  beginShape(QUADS) ;
  vertex(pos.x,pos.y) ;
  vertex(pos.x +size.x,pos.y) ;
  vertex(pos.x +size.x,pos.y +size.y) ;
  vertex(pos.x,pos.y +size.y) ;
  endShape() ;
  resetShader() ;
  popMatrix() ;
}

//
//END BACKGROUND
