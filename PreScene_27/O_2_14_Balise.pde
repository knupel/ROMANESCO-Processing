Balise balise ;
//object three
class BaliseRomanesco extends Romanesco {
  public BaliseRomanesco() {
    //from the index_objects.csv
    romanescoName = "Balise" ;
    IDobj = 14 ;
    IDgroup = 2 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Version 1.2";
    romanescoPack = "Base" ;
    romanescoRender = "P3D" ;
    romanescoMode = "Disc/Rectangle/Box/Box Snake" ;
    romanescoSlider = "Hue fill,Saturation fill,Brightness fill,Alpha fill,Hue stroke,Saturation stroke,Brightness stroke,Alpha stroke,Thickness,Width,Height,Depth,Quantity,Speed,Amplitude,Repulsion" ;
  }
  //GLOBAL
  float speed ;
  //SETUP
  void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
    balise = new Balise() ;
  }
  //DRAW
  void display() {
    if (motion[IDobj]) speed = (map(speedObj[IDobj], 0,1, 0,20)) *tempo[IDobj] ; else speed = 0.0 ;
    // color and thickness
    aspect(IDobj) ;

    //amplitude
    float amp = map(amplitudeObj[IDobj], 0,1, 0, width *3) ;
    
    //factor size
    float factor = map(repulsionObj[IDobj],0,1,1,100) *(allBeats(IDobj) *.2) ;
    if(factor < 1.0 ) factor = 1.0 ;
    
    
    
    

    // SIZE
    float factorBeat = .5 ;
    // float tempoEffect = 1 + ((beat[IDobj] -1  ) + (kick[IDobj] -1  ) + (snare[IDobj] -1  ) + (hat[IDobj] -1  ) );
    float tempoEffect = 1 + ((beat[IDobj] *factorBeat) + (kick[IDobj] *factorBeat) + (snare[IDobj] *factorBeat) + (hat[IDobj] *factorBeat));
    PVector sizeBalise = new PVector(sizeXObj[IDobj],sizeYObj[IDobj],sizeZObj[IDobj]) ;
    PVector var = new PVector(1,1) ;
    if(sound[IDobj]) {
      sizeBalise  = new PVector (sizeXObj[IDobj] *tempoEffect, sizeYObj[IDobj] *tempoEffect, sizeZObj[IDobj] ) ;
      // variable position
      var = new PVector(left[IDobj] *5,right[IDobj] *5) ;
    }
    
    if(var.x <= 0 ) var.x = .1 ; 
    if(var.y <= 0 ) var.y = .1 ; 
    //quantity
    float radiusBalise = map(quantityObj[IDobj], 0,1, 2, 511); // here the value max is 511 because we work with buffersize with 512 field
    
    balise.actualisation(mouse[IDobj] , speed) ;
    balise.display(amp, var, sizeBalise, factor, int(radiusBalise), sound[IDobj], mode[IDobj]) ;
    
    
    objectInfo[IDobj] = ("Size "+(int)sizeBalise.x + " / " + (int)sizeBalise.y + " / " + (int)sizeBalise.z  + " Radius " + int(radiusBalise) ) ;
  }
}
//end object two







// CLASS BALISE
class Balise extends Rotation {  
  
  Balise () { super () ; }
  
  void display (float amp, PVector var, PVector sizeBalise, float factor, int max, boolean sound, int mode) {
    pushMatrix() ;
    rectMode(CENTER) ;
    
    //PVector inputResult = new PVector(0,0,0) ;
    if ( max > 512 ) max = 512 ;
    for(int i = 0 ; i < max ; i++) {
      PVector v = new PVector(input(i,max,var,sound).x, input(i,max,var,sound).y) ;
      // PVector v = new PVector(input(i,max,var,sound).x, input(i,max,var,sound).y) ;
      PVector posBalise = new PVector ( amp *v.x, amp *v.y ) ;
      v = new PVector (abs(v.x *factor), abs(v.y *factor) ) ;
      PVector newSize = new PVector(sizeBalise.x *v.x, sizeBalise.y *v.y, sizeBalise.z *((v.x +v.y)*.5))   ;
      if (mode == 0 ) ellipse(posBalise.x, posBalise.y, newSize.x, newSize.y) ;
      if (mode == 1 ) rect   (posBalise.x, posBalise.y, newSize.x, newSize.y) ;
      if (mode == 2 ) boxes(posBalise, newSize, true) ;
      if (mode == 3 ) boxes(posBalise, newSize, false) ;
    }
    rectMode(CORNER) ;
    popMatrix() ;
    noStroke() ;
  }
  
  
  void boxes(PVector pos, PVector size, boolean snake) {
    if(snake) pushMatrix() ;
    translate(pos.x, pos.y, pos.z) ;
    box(size.x, size.y, size.z) ;
    if(snake) popMatrix() ;
  }
  
  //calculate and return the position for each brick of the balise
  PVector input( int whichOne, int max, PVector var, boolean b) {
    PVector value = new PVector(0,0,0) ;
    if(b) {
      value = new PVector ( (input.left.get(whichOne)*var.x), (input.right.get(whichOne)*var.y) ) ; 
    } else {
      float n = (float)whichOne ;
      n = n - (max/2) ;
      value = new PVector ( n*var.x *.01, n*var.y *.01 ) ; 
    }
    return value ;
  }
}
