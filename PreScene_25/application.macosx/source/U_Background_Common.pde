/////////////
//BACKGROUND
/////////////
int artificialTime ;
//FOND
void backgroundRomanesco(boolean useShader) {
  if(eBackground == 1) {
    color bg ;
    
    //to smooth the curve of transparency background
    float facteur = 2.5 ;
    // float homothety = 100.0 ;
    float nx = norm(valueSlider[0][3], 0.0 , 100.0) ;
    float ny = pow (nx ,facteur );
    ny = map(ny, 0, 1 , 0.8, 100 ) ;
    
    bg = color (map(valueSlider[0][0],0,100,0,360), valueSlider[0][1], valueSlider[0][2], ny ) ; 
    //choice the background
    if(displayMode.equals("Classic")) backgroundClassic(bg) ;
    else if(displayMode.equals("P3D")) backgroundP3D(bg) ;
  } else {
    backgroundShaderDraw(modeP3D, useShader, whichShader) ;
  }
}


void backgroundRomanescoPrescene(boolean useShader) {
  if(eBackground == 1) {
    color bg ;
    bg = color (map(valueSlider[0][0],0,100,0,360), valueSlider[0][1], valueSlider[0][2], 100 ) ;
      //choice the background
    if(displayMode.equals("Classic")) backgroundClassic(bg) ;
    else if(modeP3D) backgroundP3D(bg) ;
  } else {
    backgroundShaderDraw(modeP3D, useShader, whichShader) ;
  }
}


//diffenrent background
void backgroundClassic(color c) {
  //DISPLAY FINAL
  noStroke() ;
  fill(c) ;
  rect (0,0, width, height) ;
}

//P3D
//BACKGROUND
////////////
void backgroundP3D(color c) {
  if(alpha(c) < 90 ) {
    fill(c) ;
    noStroke() ;
    pushMatrix() ;
    translate(-sizeBackgroundP3D.x *.5,-sizeBackgroundP3D.y *.5 , -sizeBackgroundP3D.z) ;
    rect(0,0, sizeBackgroundP3D.x, sizeBackgroundP3D.y) ;
    popMatrix() ;
  } else {
    background(c) ;
  }
  
}





// BACKGROUND SHADER
PShader blurOne, blurTwo, cellular, damierEllipse, heart, necklace,  psy, sinLight, snow ;
//PShader bizarre, water, psyTwo, psyThree ;

void backgroundShaderSetup(boolean renderP3D) {
  if(renderP3D) {
    String pathShaderBG = preferencesPath +"background_shader/" ;
    

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



void backgroundShaderDraw(boolean renderP3D, boolean useShaderOrNot, int whichOne) {
  if(renderP3D && useShaderOrNot) {
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
  }  else if (whichOne != 0) {
    int sizeText = 14 ;
    textSize(sizeText) ;
    fill(orange, 10) ; noStroke() ;
    text("Shader is active", sizeText, sizeText*1.5) ;
  } 

}

float addTempo ;
void rectangle(PVector pos, PVector size, PShader s) {
  int factorSize = 10 ;
  size.mult(factorSize) ;
  pushMatrix() ;
  translate(-size.x *.5,-size.y *.5 , -size.z*.5) ;
  shader(s) ;
  
  float varBeat = beat[0] / 2.0 ;
  float varTempo = tempo[0] ;
  float varMix = mix[0] ;
  addTempo += tempo[0] ;
  PVector RGBbackground  = new PVector () ;
  RGBbackground = HSBtoRGB(map(valueSlider[0][0],0,100,0,360), valueSlider[0][1], valueSlider[0][2] ) ;
  float hueNorm = map(RGBbackground.x,0,255,0,1) ;
  float saturationNorm = map(RGBbackground.y,0,255,0,1) ;
  float brightnessNorm = map(RGBbackground.z,0,255,0,1) ;
  float alphaNorm = map(valueSlider[0][2],0,100,0,1) ;
  

  
  
  float varTime = millis() / 1000.0 ;
  float x = map(mouse[0].x,0,width,0,1) ;
  float y = map(mouse[0].y,0,height,0,1) ;
  s.set("colorBG",hueNorm, saturationNorm, brightnessNorm, alphaNorm) ; 
  s.set("mixSound", varMix) ;
  s.set("addTempo", addTempo) ;
  s.set("tempo", varTempo) ;
  s.set("beat", varBeat) ;
  s.set("mouse",x, y) ;
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
