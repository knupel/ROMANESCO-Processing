/**
La Voie du Code : Color palette
@see https://github.com/StanLepunK/La-Voie-du-Code
2013-2018
*/
Slider slider ;
PVector pos_slider ;
PVector size_slider ;
float value_slider ;
//palette
Palette palette ;
PVector pospalette, size_palette ;
//setup color
color rouge, orange, blanc, noir ;

//setup slider
int thickness_slider ;
int follow_slider ; 
color color_slider, color_border_slider ; 

void setup() {
  size(275,400); colorMode (HSB, 255 ) ; smooth() ;
  rouge = color(0,200,200) ; orange = color (40,250,250) ; blanc = color(0,0,255) ; noir = color (0,0,0) ;
  //Setup slider
  follow_slider = 15 ;
  //setup color and draw slider
  color_slider = blanc ;  color_border_slider = noir ;
  thickness_slider = 1 ;

  //slider activation
  pos_slider = new PVector  (10, 10, 0 ) ;
  size_slider = new PVector (255, 10, 0 ) ;
  slider = new Slider(pos_slider, size_slider, follow_slider, color_slider,  color_border_slider, thickness_slider);
  
  //palette activation
  pospalette = new PVector ( 10, 30, 0 ) ;
  size_palette = new PVector (255, 255, 0 ) ;
  palette = new Palette(pospalette, size_palette);
}


void draw() {
  background( 0 );

  //return of the value from slider
  value_slider = slider.getPos() ;
  /////////////update slider
  slider.update();
  
  ////////////display slider
  //slider.slider(); // classic
  slider.sliderColor(); // special
  
  ////////////////display molette
  PVector ratio = new PVector (0.5, 2.0 ) ; // give the size of the molette ratio X different of "zero", ratio "y" must be bigger than "one"
  // color of molette for the rollover
  color moletteIN = blanc ; 
  color moletteOUT = noir ;
  color moletteBorderIN = blanc ; 
  color moletteBorderOUT = noir ;
  int moletteThickness = 1 ;
  int typeOfMolette = 1 ; // 1 = rect ; 2 = ellipse ; you can create others shapes if you want in the class Slider.
  
  slider.molette(ratio, moletteIN, moletteOUT, moletteBorderIN, moletteBorderOUT, moletteThickness, typeOfMolette) ;
  
  /////////////////////////////PALETTE//////////////////
  float valueSlider = value_slider ; // this float give the value from the slider or other parameter, value between 0 to 255
  palette.display(valueSlider) ; 
  
  // color witness
  //new color
  PVector posNC = new PVector  ( 10.0 , 300.0 ) ;
  PVector sizeNC = new PVector ( size_palette.x , 20.0 ) ;
  palette.newColor(posNC, sizeNC) ;
  //currentColor
  PVector posCC = new PVector  ( 10.0 , 320.0 ) ;
  PVector sizeCC = new PVector ( size_palette.x , 20.0 ) ;
  palette.currentColor(posCC, sizeCC) ;
  
  //buton
  PVector posB = new PVector ( 10.0, 350.0 ) ;
  PVector sizeB = new PVector ( 75.0 , 20.0 ) ;
  color buttonIN = blanc ; 
  color buttonOUT = noir ;
  color buttonBorderIN = blanc ; 
  color buttonBorderOUT = noir ;
  color colorTitle = rouge ;
  int   buttonThickness = 1 ;
  int   typeOfButton = 1 ; // 1 = rect ; 2 = ellipse ; you can create others shapes if you want in the class Slider.
  String title = "VALIDATE" ;
  palette.buttonValidate (posB, sizeB, buttonIN, buttonOUT, buttonBorderIN, buttonBorderOUT, buttonThickness, typeOfButton, title, colorTitle ) ;

}
