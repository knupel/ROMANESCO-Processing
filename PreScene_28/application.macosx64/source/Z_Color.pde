// Tab: Z_Color
//COLOR for internal use
color fond ;
color rouge, orange, jaune, vert, bleu, noir, blanc, gris  ;

void colorSetup() {
  rouge = color(10,100,100);
  orange = color(25,100,100);
  jaune = color(50,100,100) ;
  vert = color(150,100,100);
  bleu = color(235,100,100);
  noir = color(10,100,0);
  gris = color(10,50,50);
  blanc = color(0,0,100);
}

//ROLLOVER TEXT ON BACKGROUNG CHANGE
color colorW ;
//
color colorWrite(color colorRef, int threshold, color clear, color deep) {
  if( brightness( colorRef ) < threshold ) {
    colorW = color(clear) ;
  } else {
    colorW = color(deep) ;
  }
  return colorW ;
}







////////////////////
// Void antiBugBlack
void antiBugFillBlack(color c) {
      if (alpha(c) == 0 ) {
    noFill() ; 
    noStroke() ; 
  } else {     
    fill (c) ; 
  }
}


// activate the fill, stroke and set the the strokeWeight
void appearance(color colorFill, color colorStroke, float thickness) {
  //check the color
  if(alpha(colorFill) <=0)  noFill() ; else fill(colorFill) ;
  
  if(alpha(colorStroke) <=0) noStroke() ;
  else {
    stroke(colorStroke) ;
    strokeWeight(thickness) ;
  }
}
  
  
  
  
  
  
  
  
  
////////////////  
// PALETTE COLOR
//GLOBAL
//Range of each component HSB to change the color palette of image
//HUE
int [] hueStart  ;
int [] hueEnd  ;
int [] huePalette, huePaletteRef ;

//SATURATION
int [] satStart  ;
int [] satEnd  ;
int [] satPalette, satPaletteRef ;
//BRIGHTNESS
int [] brightStart  ;
int [] brightEnd  ;
int [] brightPalette, brightPaletteRef ;


//DRAW OR SETUP
//MAKE PALETTE
// random hue Palette
void paletteRandom(PVector n, Vec4 spectrum) {
  huePalette = new int [(int)n.x] ;
  huePaletteRef = new int [(int)n.x] ;
  for (int i = 0 ; i < (int)n.x ; i++) huePalette [i] = huePaletteRef [i] = (int)random(spectrum.x) ;
  huePalette = sort(huePalette) ;
  huePaletteRef = sort(huePaletteRef) ;
  //calcul of the value range of each color on color wheel
  hueSpectrumPalette(huePalette, (int)spectrum.x) ;
  
  //saturation
  satPalette = new int [(int)n.y] ;
  satPaletteRef = new int [(int)n.y] ;
  for (int i = 0 ; i < (int)n.y ; i++) satPalette [i] = satPaletteRef [i] = (int)random(spectrum.y) ;
  satPalette = sort(satPalette) ;
  satPaletteRef = sort(satPaletteRef) ;
  //calcul of the value range of each color on color wheel
  satSpectrumPalette(satPalette, (int)spectrum.y) ;
  
  //brightness
  brightPalette = new int [(int)n.z] ;
  brightPaletteRef = new int [(int)n.z] ;
  for (int i = 0 ; i < (int)n.z ; i++) brightPalette [i] = brightPaletteRef [i] = (int)random(spectrum.z) ;
  brightPalette = sort(brightPalette) ;
  brightPaletteRef = sort(brightPaletteRef) ;
  //calcul of the value range of each color on color wheel
  brightSpectrumPalette(brightPalette, (int)spectrum.z) ;
  
}

//palette with color from you !!!!
void paletteClassic(int [] hueList, int[] satList, int[] brightList, PVector spectrum) {
  huePalette = new int [hueList.length] ;
  huePaletteRef = new int [hueList.length] ;
  for (int i = 0 ; i < hueList.length ; i++) huePalette [i] = huePaletteRef [i] = hueList[i] ;
  huePalette = sort(huePalette) ;
  huePaletteRef = sort(huePaletteRef) ;
  //calcul of the value range of each color on color wheel
  hueSpectrumPalette(huePalette, (int)spectrum.x) ;
  
  //saturation
  satPalette = new int [satList.length] ;
  satPaletteRef = new int [satList.length] ;
  for (int i = 0 ; i < satList.length ; i++) satPalette [i] = satPaletteRef [i] = satList[i] ;
  satPalette = sort(satPalette) ;
  satPaletteRef = sort(satPaletteRef) ;
  //calcul of the value range of each color on color wheel
  satSpectrumPalette(satPalette, (int)spectrum.y) ;
  
  //brightness
  brightPalette = new int [brightList.length] ;
  brightPaletteRef = new int [brightList.length] ;
  for (int i = 0 ; i < brightList.length ; i++) brightPalette [i] = brightPaletteRef [i] = brightList [i];
  brightPalette = sort(brightPalette) ;
  brightPaletteRef = sort(brightPaletteRef) ;
  //calcul of the value range of each color on color wheel
  brightSpectrumPalette(brightPalette, (int)spectrum.z) ;
  
}





//ANNEXE VOID

//for the live modification
//HSB void
void paletteHSB(PVector hueVar, PVector satVar, PVector brightVar) {
 paletteHue(hueVar ) ;
 paletteSat(satVar ) ;
 paletteBright(brightVar ) ;
}

//hue void
void paletteHue(PVector hueInfo )  {
  float cycle = cycle(hueInfo.y) ;
  float factor = map(cycle, -1,1, hueInfo.z,1) ;
  for ( int i = 0 ; i < huePalette.length ; i++ ) {
     huePalette [i] = int(hueInfo.x + (factor * (huePaletteRef [i] - hueInfo.x))) ;
  }
  hueSpectrumPalette(huePalette, (int)HSBmode.x) ;
}

//saturation void
void paletteSat(PVector satInfo )  {
  float cycle = cycle(satInfo.y) ;
  float factor = map(cycle, -1,1, satInfo.z,1) ;
  for ( int i = 0 ; i < satPalette.length ; i++ ) {
     satPalette [i] = int(satInfo.x + (factor * (satPaletteRef [i] - satInfo.x))) ;
  }
  satSpectrumPalette(satPalette, (int)HSBmode.y) ;
}

//brightness void
void paletteBright(PVector brightInfo )  {
  float cycle = cycle(brightInfo.y) ;
  float factor = map(cycle, -1,1, brightInfo.z,1) ;
  for ( int i = 0 ; i < brightPalette.length ; i++ ) {
     brightPalette [i] = int(brightInfo.x + (factor * (brightPaletteRef [i] - brightInfo.x))) ;
  }
  brightSpectrumPalette(brightPalette, (int)HSBmode.z) ;
}






//hue Spectrum
void hueSpectrumPalette(int [] hueP, int sizeSpectrum) {  
  if( hueP.length > 0 ) {
    int max = hueP.length  ;
    hueStart = new int [max] ;
    hueEnd = new int [max] ;
    int [] zoneLeftHue = new int [max] ;
    int [] zoneRightHue = new int [max] ;
    int [] zoneHue = new int [max] ;
  
    
    // int total = 0 ;
    if(max >1 ) {
      for ( int i = 0 ; i < max ; i++ ) {
        if ( i == 0 ) {
          zoneLeftHue[i] = (hueP[i] + sizeSpectrum - hueP[max -1 ]  ) /2  ;
          zoneRightHue[i] = (hueP[i+1] - hueP[i] ) / 2 ;
          
          if (hueP[i] < zoneLeftHue[i] ) hueStart[i] = sizeSpectrum - ( zoneLeftHue[i] - hueP[i]) ; else hueStart[i] = hueP[i] - zoneLeftHue[i] ;
          hueEnd[i] = hueP[i] + zoneRightHue[i] ;
          
          zoneHue[i] = zoneLeftHue[i] + zoneRightHue[i] ;
          
        } else if ( i > 0 && i < max-1 ) {
          zoneLeftHue[i] = (hueP[i] - hueP[i-1]  ) / 2  ;
          zoneRightHue[i] = (hueP[i+1] - hueP[i] ) / 2 ;
          
          hueStart[i] = hueP[i] - zoneLeftHue[i] ;
          hueEnd[i] = hueP[i] + zoneRightHue[i] ;
          
          zoneHue[i] = zoneLeftHue[i] + zoneRightHue[i] ;
          
        } else if ( i == max -1 ) { 
          zoneLeftHue[i] = (hueP[i] - hueP[i-1]  ) / 2  ;
          zoneRightHue[i] = (sizeSpectrum - hueP[max -1] + hueP[0] ) / 2 ;
          
          hueStart[i] = hueP[i] - zoneLeftHue[i] ;
          if( hueP[i] + zoneRightHue[i] > sizeSpectrum ) hueEnd[i] = (hueP[i] + zoneRightHue[i]) -sizeSpectrum ; else hueEnd[i] = hueP[i] + zoneRightHue[i] ;
          
          zoneHue[i] = zoneLeftHue[i] + zoneRightHue[i] ;
        }
      }
    } else {
      zoneLeftHue[0] = hueP[0]  ;
      zoneRightHue[0] = sizeSpectrum - hueP[0]  ;
      hueStart[0] = 0 ;
      hueEnd[0] = sizeSpectrum ;
    }
  }
}

//saturation Spectrum
void satSpectrumPalette(int [] satP, int sizeSpectrum) {  
  if(satP.length > 0 ) {
    int max = satP.length  ;
    satStart = new int [max] ;
    satEnd = new int [max] ;
    int [] zoneLeftSat = new int [max] ;
    int [] zoneRightSat = new int [max] ;
    int [] zoneSat = new int [max] ;
  
    
    //int total = 0 ;
    if (max > 1 ) {
      for ( int i = 0 ; i < max ; i++ ) {
        if ( i == 0 ) {
          zoneLeftSat[i] = (satP[i] + sizeSpectrum - satP[max -1 ]  ) /2  ;
          zoneRightSat[i] = (satP[i+1] - satP[i] ) / 2 ;
          
          if (satP[i] < zoneLeftSat[i] ) satStart[i] = sizeSpectrum - ( zoneLeftSat[i] - satP[i]) ; else satStart[i] = satP[i] - zoneLeftSat[i] ;
          satEnd[i] = satP[i] + zoneRightSat[i] ;
          
          zoneSat[i] = zoneLeftSat[i] + zoneRightSat[i] ;
          
        } else if ( i > 0 && i < max-1 ) {
          zoneLeftSat[i] = (satP[i] - satP[i-1]  ) / 2  ;
          zoneRightSat[i] = (satP[i+1] - satP[i] ) / 2 ;
          
          satStart[i] = satP[i] - zoneLeftSat[i] ;
          satEnd[i] = satP[i] + zoneRightSat[i] ;
          
          zoneSat[i] = zoneLeftSat[i] + zoneRightSat[i] ;
          
        } else if ( i == max -1 ) { 
          zoneLeftSat[i] = (satP[i] - satP[i-1]  ) / 2  ;
          zoneRightSat[i] = (sizeSpectrum - satP[max -1] + satP[0] ) / 2 ;
          
          satStart[i] = satP[i] - zoneLeftSat[i] ;
          if( satP[i] + zoneRightSat[i] > sizeSpectrum ) satEnd[i] = (satP[i] + zoneRightSat[i]) -sizeSpectrum ; else satEnd[i] = satP[i] + zoneRightSat[i] ;
          
          zoneSat[i] = zoneLeftSat[i] + zoneRightSat[i] ;
        }
      }
    } else {
      zoneLeftSat[0] = satP[0]  ;
      zoneRightSat[0] = sizeSpectrum - satP[0]  ;
      satStart[0] = 0 ;
      satEnd[0] = sizeSpectrum ;
    }
  }
}




//brightness Spectrum
void brightSpectrumPalette(int [] brightP, int sizeSpectrum) {  
  if(brightP.length > 0 ) {
    int max = brightP.length  ;
    brightStart = new int [max] ;
    brightEnd = new int [max] ;
    int [] zoneLeftBright = new int [max] ;
    int [] zoneRightBright = new int [max] ;
    int [] zoneBright = new int [max] ;
  
    
    //int total = 0 ;
    if ( max > 1 ) {
      for ( int i = 0 ; i < max ; i++ ) {
        if ( i == 0 ) {
          zoneLeftBright[i] = (brightP[i] + sizeSpectrum - brightP[max -1 ]  ) /2  ;
          zoneRightBright[i] = (brightP[i+1] - brightP[i] ) / 2 ;
          
          if (brightP[i] < zoneLeftBright[i] ) brightStart[i] = sizeSpectrum - ( zoneLeftBright[i] - brightP[i]) ; else brightStart[i] = brightP[i] - zoneLeftBright[i] ;
          brightEnd[i] = brightP[i] + zoneRightBright[i] ;
          
          zoneBright[i] = zoneLeftBright[i] + zoneRightBright[i] ;
          
        } else if ( i > 0 && i < max-1 ) {
          zoneLeftBright[i] = (brightP[i] - brightP[i-1]  ) / 2  ;
          zoneRightBright[i] = (brightP[i+1] - brightP[i] ) / 2 ;
          
          brightStart[i] = brightP[i] - zoneLeftBright[i] ;
          brightEnd[i] = brightP[i] + zoneRightBright[i] ;
          
          zoneBright[i] = zoneLeftBright[i] + zoneRightBright[i] ;
          
        } else if ( i == max -1 ) { 
          zoneLeftBright[i] = (brightP[i] - brightP[i-1]  ) / 2  ;
          zoneRightBright[i] = (sizeSpectrum - brightP[max -1] + brightP[0] ) / 2 ;
          
          brightStart[i] = brightP[i] - zoneLeftBright[i] ;
          if( brightP[i] + zoneRightBright[i] > sizeSpectrum ) brightEnd[i] = (brightP[i] + zoneRightBright[i]) -sizeSpectrum ; else brightEnd[i] = brightP[i] + zoneRightBright[i] ;
          
          zoneBright[i] = zoneLeftBright[i] + zoneRightBright[i] ;
        }
      } 
    } else {
      zoneLeftBright[0] = brightP[0]  ;
      zoneRightBright[0] = sizeSpectrum - brightP[0]  ;
      brightStart[0] = 0 ;
      brightEnd[0] = sizeSpectrum ;
    }
  }
}




//CHANGE COLOR pixel in the list of Pixel
void changeColorOfPixel(ArrayList listMustBeChange ) {
  for( int i = 0 ; i<listMustBeChange.size() ; i++) {
    Pixel p = (Pixel) listMustBeChange.get(i) ;
    p.changeHue   (HSBmode, huePalette, hueStart, hueEnd) ;
    p.changeSat   (HSBmode, satPalette, satStart, satEnd) ; 
    p.changeBright(HSBmode, brightPalette, brightStart, brightEnd) ;
    
    p.updatePalette() ; 
  }
}



//convert color HSB to RVB
PVector HSBtoRGB(float hue, float saturation, float brightness) {
  PVector PVectorRGB = new PVector() ;
  
  color c = color (hue, saturation, brightness);
  colorMode(RGB,255) ;
  PVectorRGB = new PVector (red(c), green(c), blue(c)) ;
  colorMode(HSB,HSBmode.r,HSBmode.r,HSBmode.b,HSBmode.a) ;
  return PVectorRGB ;
}



// camaieu
// return hue or other date in range of specific data float
int camaieu(int max, float colorRef, int range) {
  float camaieu = 0 ;
  float whichColor = random(-range, range) ;
  camaieu = colorRef +whichColor ;
  if(camaieu < 0 ) camaieu = max +camaieu ;
  if(camaieu > max) camaieu = camaieu -max ;
 
  return (int)camaieu ;
}














  