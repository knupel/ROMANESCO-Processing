/////////////
//BACKGROUND
/////////////
int artificialTime ;
//FOND
void backgroundRomanesco() {
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
    backgroundShaderDraw(modeP3D, shaderMode) ;
  }
}


void backgroundRomanescoPrescene() {
  if(eBackground == 1) {
    color bg ;
    bg = color (map(valueSlider[0][0],0,100,0,360), valueSlider[0][1], valueSlider[0][2], 100 ) ;
      //choice the background
    if(displayMode.equals("Classic")) backgroundClassic(bg) ;
    else if(displayMode.equals("P3D")) backgroundP3D(bg) ;
  } else {
    backgroundShaderDraw(modeP3D, shaderMode) ;
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
PVector sizeBG ;
void backgroundP3D(color c) {
  fill(c) ;
  noStroke() ;
  pushMatrix() ;
  sizeBG = new PVector(width *100, height *100, height *7) ;
  translate(-sizeBG.x *.5,-sizeBG.y *.5 , -sizeBG.z) ;
  rect(0,0, sizeBG.x,sizeBG.y) ;
  popMatrix() ;
}





// BACKGROUND SHADER
int shaderMode = 3 ;
PShader bizarre, snow, sinLight, blurOne, blurTwo, hallo, necklace, water, damierEllipse, cellular, psy, psyTwo, psyThree ;

void backgroundShaderSetup(boolean renderP3D) {
  if(renderP3D) {
    String pathShaderBG = preferencesPath +"background_shader/" ;
    

    blurOne = loadShader(pathShaderBG+"blurOneFrag.glsl") ;
    blurTwo = loadShader(pathShaderBG+"blurTwoFrag.glsl") ;
    cellular = loadShader(pathShaderBG+"cellularFrag.glsl") ;
    damierEllipse = loadShader(pathShaderBG+"damierEllipseFrag.glsl") ;
    hallo = loadShader(pathShaderBG+"halloFrag.glsl") ;
    necklace = loadShader(pathShaderBG+"necklaceFrag.glsl") ;
    psy = loadShader(pathShaderBG+"psyFrag.glsl") ;
    sinLight = loadShader(pathShaderBG+"sinLightFrag.glsl") ;
    snow = loadShader(pathShaderBG+"snowFrag.glsl") ;

    
    bizarre = loadShader(pathShaderBG+"bizarreFrag.glsl") ; // work bad
    water = loadShader(pathShaderBG+"waterFrag.glsl") ; // problem
    psyTwo = loadShader(pathShaderBG+"psyTwoFrag.glsl") ; // problem
    psyThree = loadShader(pathShaderBG+"psyThreeFrag.glsl") ; // problem
  }
}



void backgroundShaderDraw(boolean renderP3D, int whichShader) {
  if(renderP3D) {
    PVector posBGshader = new PVector(0,0) ;
    PVector sizeBGshader = new PVector(width,height, height) ; 
    
    if     (whichShader ==0) rectangle(posBGshader, sizeBGshader, blurOne ) ;
    else if(whichShader ==1) rectangle(posBGshader, sizeBGshader, blurTwo ) ;
    else if(whichShader ==2) rectangle(posBGshader, sizeBGshader, cellular) ;
    else if(whichShader ==3) rectangle(posBGshader, sizeBGshader, damierEllipse) ;
    else if(whichShader ==4) rectangle(posBGshader, sizeBGshader, hallo) ;
    else if(whichShader ==5) rectangle(posBGshader, sizeBGshader, necklace) ;
    else if(whichShader ==6) rectangle(posBGshader, sizeBGshader, psy) ;
    else if(whichShader ==7) rectangle(posBGshader, sizeBGshader, snow ) ;
    else if(whichShader ==8) rectangle(posBGshader, sizeBGshader, sinLight ) ;
    
    
    //rectangle(posBGshader, sizeBGshader, bizarre) ;  // work bad
    //rectangle(posBGshader, sizeBGshader, water) ; // problem
    //rectangle(posBGshader, sizeBGshader, psyTwo) ; // problem
    //rectangle(posBGshader, sizeBGshader, psyThree) ; // problem
  }

}

float varShaderBeat ;
void rectangle(PVector pos, PVector size, PShader s) {
  int factorSize = 10 ;
  size.mult(factorSize) ;
  pushMatrix() ;
  translate(-size.x *.5,-size.y *.5 , -size.z*.5) ;
  shader(s) ;
  varShaderBeat = beat[0] / 2.0 ;
  float varTime = millis() / 1000.0 ;
  float x = map(mouse[0].x,0,width,0,1) ;
  float y = map(mouse[0].y,0,height,0,1) ;

  
  s.set("beat", varShaderBeat) ;
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
