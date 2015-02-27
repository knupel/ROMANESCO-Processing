class SuperRomanesco {
    String romanescoName = "" ;
    int IDobj = 0 ; 
    int IDgroup = 1 ;  
    String romanescoAuthor  = "";
    String romanescoVersion = "";
    String romanescoPack = "" ;
    String romanescoMode = "" ; 
    String romanescoSlider = "" ;
  
  SuperRomanesco() {}
}








int IDobj ;
int numObj = 100 ;


int widthOfYourSketch = 400 ;
int heightOfYourSketch = 400 ;
color colorBackground = 0 ;

String objectInfo[] = new String[numObj] ;

void startPosition(int ID, float x,float y, float z) {
}



color  [] fillObj, strokeObj ;
float [] thicknessObj ;
float [] sizeXObj, sizeYObj, sizeZObj ;
float [] canvasXObj, canvasYObj, canvasZObj ;
float [] familyObj, lifeObj, quantityObj ;
float [] speedObj, directionObj, angleObj ;
float [] amplitudeObj, attractionObj, repulsionObj ;
float [] analyzeObj, influenceObj, alignmentObj ;




void romanescoBasicSetting(int x, int y) {
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
  familyObj= new float[numObj] ;
  quantityObj = new float[numObj] ;
  lifeObj = new float[numObj] ;
  
  speedObj = new float[numObj] ; 
  directionObj= new float[numObj] ;
  angleObj = new float[numObj] ;
  amplitudeObj = new float[numObj] ;
  attractionObj = new float[numObj] ;
  repulsionObj = new float[numObj] ;
  influenceObj = new float[numObj] ;
  alignmentObj = new float[numObj] ;
  analyzeObj = new float[numObj] ;
}
