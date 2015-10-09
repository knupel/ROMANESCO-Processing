// CONTROLLER 1.0 
// Romanesco frame work

import controlP5.*;

ControlP5 cp5;

public float hue_fill, saturation_fill, brightness_fill, alpha_fill,
             hue_stroke, saturation_stroke, brightness_stroke, alpha_stroke,
             thickness,
             size_X, size_Y, size_Z,
             canvas_X, canvas_Y, canvas_Z,
             family, quantity, life,
             speed,
             direction, angle,
             amplitude, attraction, repulsion, influence, aligmnent,
             analyze ;
             
             
// main setup method
////////////////////
void setController() {
  int x = 10 ;
  int y = 11 ;
  int sizeSliderX = 100 ;
  int sizeSliderY = 8 ;
  cp5 = new ControlP5(this);
  cp5.addSlider("hue_fill")         .setRange(0, 360).setPosition(x, y *1).setSize(sizeSliderX, sizeSliderY) ;
  cp5.addSlider("saturation_fill")  .setRange(0, 100).setPosition(x, y *2).setSize(sizeSliderX, sizeSliderY) ;
  cp5.addSlider("brightness_fill")  .setRange(0, 100).setPosition(x, y *3).setSize(sizeSliderX, sizeSliderY) ;
  cp5.addSlider("alpha_fill")       .setRange(0, 100).setPosition(x, y *4).setSize(sizeSliderX, sizeSliderY) ;
  
  cp5.addSlider("hue_stroke")         .setRange(0, 360).setPosition(x, y *6).setSize(sizeSliderX, sizeSliderY) ;
  cp5.addSlider("saturation_stroke")  .setRange(0, 100).setPosition(x, y *7).setSize(sizeSliderX, sizeSliderY) ;
  cp5.addSlider("brightness_stroke")  .setRange(0, 100).setPosition(x, y *8).setSize(sizeSliderX, sizeSliderY) ;
  cp5.addSlider("alpha_stroke")       .setRange(0, 100).setPosition(x, y *9).setSize(sizeSliderX, sizeSliderY) ;
  
  cp5.addSlider("thickness")       .setRange(.1, height/3).setPosition(x, y *11).setSize(sizeSliderX, sizeSliderY) ;
  
  cp5.addSlider("size_X")  .setRange(.1, width).setPosition(x, y *13).setSize(sizeSliderX, sizeSliderY) ;
  cp5.addSlider("size_Y")  .setRange(.1, width).setPosition(x, y *14).setSize(sizeSliderX, sizeSliderY) ;
  cp5.addSlider("size_Z")  .setRange(.1, width).setPosition(x, y *15).setSize(sizeSliderX, sizeSliderY) ;
  
  cp5.addSlider("canvas_X")  .setRange(width/10, width).setPosition(x, y *17).setSize(sizeSliderX, sizeSliderY) ;
  cp5.addSlider("canvas_Y")  .setRange(width/10, width).setPosition(x, y *18).setSize(sizeSliderX, sizeSliderY) ;
  cp5.addSlider("canvas_Z")  .setRange(width/10, width).setPosition(x, y *19).setSize(sizeSliderX, sizeSliderY) ;
  
  cp5.addSlider("family")    .setRange(0,1).setPosition(x, y *21).setSize(sizeSliderX, sizeSliderY) ;
  cp5.addSlider("quantity")  .setRange(0,1).setPosition(x, y *22).setSize(sizeSliderX, sizeSliderY) ;
  cp5.addSlider("life")      .setRange(0,1).setPosition(x, y *23).setSize(sizeSliderX, sizeSliderY) ;
  
  cp5.addSlider("speed")    .setRange(0,1).setPosition(x, y *25).setSize(sizeSliderX, sizeSliderY) ;
  
  cp5.addSlider("direction")  .setRange(0,360).setPosition(x, y *27).setSize(sizeSliderX, sizeSliderY) ;
  cp5.addSlider("angle")      .setRange(0,360).setPosition(x, y *28).setSize(sizeSliderX, sizeSliderY) ;
  
  cp5.addSlider("amplitude")  .setRange(0,1).setPosition(x, y *30).setSize(sizeSliderX, sizeSliderY) ;
  cp5.addSlider("attraction") .setRange(0,1).setPosition(x, y *31).setSize(sizeSliderX, sizeSliderY) ;
  cp5.addSlider("repulsion")  .setRange(0,1).setPosition(x, y *32).setSize(sizeSliderX, sizeSliderY) ;
  cp5.addSlider("influence")  .setRange(0,1).setPosition(x, y *33).setSize(sizeSliderX, sizeSliderY) ;
  cp5.addSlider("aligmnent")  .setRange(0,1).setPosition(x, y *34).setSize(sizeSliderX, sizeSliderY) ;
  
  cp5.addSlider("analyze")    .setRange(0,1).setPosition(x, y *36).setSize(sizeSliderX, sizeSliderY) ;
  
  // we use this method to disable the peasy cam on the controller
  cp5.setAutoDraw(false);
}


// main draw method
////////////////////
void controller_draw() {
   if (displaySlider)  {
     cp5.hide() ; 
   } else {
     cp5.show() ;
     // we use this method to disable or enable the peasy cam on the controller
     cam.beginHUD();
     cp5.draw();
     cam.endHUD();
   }
}



// annexe method
/////////////////////////
void setValueController() {
    hue_fill = 30 ;
  saturation_fill = 0 ;
  brightness_fill = 100 ;
  alpha_fill = 100 ;
  
  hue_stroke = 30 ;
  saturation_stroke = 0 ;
  brightness_stroke = 0 ;
  alpha_stroke = 100 ;
  
  thickness = 1 ;
  
  size_X = width/3 ;
  size_Y = width/3 ;
  size_Z = width/3 ;
  
  canvas_X = width/3 ;
  canvas_Y = width/3 ;
  canvas_Z = width/3 ;
  
  family = .5 ;
  quantity = .5 ;
  life = .5 ;
  
  speed = .5 ;
  
  direction = 0 ;
  angle = 0 ;
  
  amplitude = .5 ;
  attraction = .5 ;
  repulsion = .5 ;
  influence = .5 ;
  aligmnent = .5 ;
  analyze = .5 ;
}

void apply_value_slider_CP5_on_value_Romanesco(int IDobj) {
    
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
  fillObj[IDobj] = color(hue_fill,saturation_fill,brightness_fill,alpha_fill) ; // 360/100,100,100
  strokeObj[IDobj] = color(hue_stroke,saturation_stroke,brightness_stroke,alpha_stroke) ; // 360/100,100,100

  thicknessObj[IDobj] = thickness ; // 0.1 > height/3
  
  // COL TWO
  sizeXObj[IDobj] = size_X ; // 0.1 > width
  sizeYObj[IDobj] = size_Y ;  // 0.1 > width
  sizeZObj[IDobj]  = size_Z ; // 0.1 > width

  canvasXObj[IDobj] = canvas_X ; // width/10  > width
  canvasYObj[IDobj] = canvas_Y ; // width/10  > width
  canvasZObj[IDobj] = canvas_Z ; // width/10  > width
  
  familyObj[IDobj] = family ;  // 0 to 1
  quantityObj[IDobj] = quantity ; // 0 to 1
  lifeObj[IDobj] = life ; // 0 to 1
  
  // COL THREE
  speedObj[IDobj] = speed ; // 0 to 1

  directionObj[IDobj] = direction ; // 0 >360
  angleObj[IDobj] = angle ; // 0 >360

  amplitudeObj[IDobj] = amplitude ; // 0 to 1
  attractionObj[IDobj] = attraction ; // 0 to 1
  repulsionObj[IDobj] = repulsion ; // 0 to 1
  influenceObj[IDobj] = influence ; // 0 to 1
  alignmentObj[IDobj] = aligmnent ; // 0 to 1
  
  analyzeObj[IDobj] = analyze ; // 0 to 1
}




boolean displaySlider ;