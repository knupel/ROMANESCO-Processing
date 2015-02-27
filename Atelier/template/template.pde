Object obj = new Object() ;


void setup() {
  romanescoBasicSetting(800, 600) ;
  yourBasicSetting(obj.IDobj) ;
  obj.setting() ;
 
}


void draw() {
  background(colorBackground) ;
  obj.display() ;
}




void yourBasicSetting(int IDobj) {
  /*
  You can use this var for the fill color fillObj[IDobj] ; you can separate with 
  hue(fillObj[IDobj]) ;
  saturation(fillObj[IDobj]) ;
  brightness(fillObj[IDobj]) ; 
  alpha(fillObj[IDobj])  ;
  // also for the stroke you can use this var for the stroke color strokeObj[IDobj] ; you can separate with 
  hue(strokeObj[IDobj]) ;
  saturation(strokeObj[IDobj]) ;
  brightness(strokeObj[IDobj]) ;
  alpha(strokeObj[IDobj]) ;
  */
  fillObj[IDobj] = color(80,100,100,100) ;
  strokeObj[IDobj] = color(250,0,100,100) ;
  // value from 0.1 to height/3
  thicknessObj[IDobj] = 1 ;
  // value returning is from 0.1 to width
  sizeXObj[IDobj] = 1 ;
  sizeYObj[IDobj] = 1 ; 
  sizeZObj[IDobj]  = 1 ; 
  // value returning is  from width/10  to width
  canvasXObj[IDobj] = width *5 ; 
  canvasYObj[IDobj] = height *5 ; 
  canvasZObj[IDobj] = height *5 ;
  // value retruning is from 0 to 1 
  familyObj[IDobj] = .5 ; 
  quantityObj[IDobj] = .5 ; 
  lifeObj[IDobj] =.5 ; 
  
  // COL THREE
  speedObj[IDobj] =.5 ;
  // value returning is from 0 to 360°
  directionObj[IDobj] = 360 ;
  angleObj[IDobj] = 360 ;
  amplitudeObj[IDobj] = .5 ;
  attractionObj[IDobj] =.5 ;
  repulsionObj[IDobj] = .5 ;
  influenceObj[IDobj] = .5 ;
  alignmentObj[IDobj] = .5 ;
  analyzeObj[IDobj] = .5 ;
}
