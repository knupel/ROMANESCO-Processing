// BASIC PARAMETERS of ROMANESCO


color  [] fillObj, strokeObj ;
float [] thicknessObj ;
float [] sizeXObj, sizeYObj, sizeZObj ;
float [] canvasXObj, canvasYObj, canvasZObj ;
float [] quantity, speedObj, directionObj, angleObj, amplitudeObj, analyzeObj, familyObj, lifeObj, forceObj ;


int IDobj = 0 ;
int numObj = 1 ;

void romanescoSetting_size_and_color_mode_and_basicParameters(int x, int y) {
  size(x,y, P3D) ;
  colorMode(HSB,360,100,100,100) ;
  
  fillObj = new color[numObj] ;
  strokeObj = new color[numObj] ;
  thicknessObj = new float[numObj] ;
  
  sizeXObj = new float[numObj] ;
  sizeYObj = new float[numObj] ;
  sizeZObj = new float[numObj] ;
  
  canvasXObj = new float[numObj] ;
  canvasYObj = new float[numObj] ;
  canvasZObj = new float[numObj] ;
  
  quantity = new float[numObj] ;
  speedObj = new float[numObj] ; 
  directionObj= new float[numObj] ;
  angleObj = new float[numObj] ;
  amplitudeObj = new float[numObj] ;
  analyzeObj = new float[numObj] ;
  familyObj= new float[numObj] ;
  lifeObj = new float[numObj] ;
  forceObj = new float[numObj] ;
  
}


void setup() {
  romanescoSetting_size_and_color_mode_and_basicParameters(widthOfYourSketch, heightOfYourSketch) ;
  setting() ;
 
}


void draw() {
  background(colorBackground) ;
  display() ;
}
