/**
BOXOLYZER || 2012|| 1.0.3
*/
ArrayList<BOITEaMUSIQUE> boiteList ;
  
class Boxolyzer extends Romanesco {
  public Boxolyzer() {
    //from the index_objects.csv
    RPE_name = "Boxolyzer" ;
    ID_item = 11 ;
    ID_group = 1 ;
    RPE_author  = "Stan le Punk";
    RPE_version = "Version 1.0.4";
    RPE_pack = "Base" ;
    RPE_mode ="Classic/Circle" ;
    RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Stroke hue,Stroke sat,Stroke bright,Stroke alpha,Thickness,Size X,Size Y,Size Z,Canvas X,Quantity,Direction X" ;
  }
  //GLOBAL
  boolean newDistribution ;
  int numBoxRef ;

  //SETUP
  void setup() {
    startPosition(ID_item, 0, 0, 0) ;
    
    boitesSetting() ;
  }
  //DRAW
  void draw() {
    //CLASSIC DISPLAY
    int numBox = int(map(quantity_item[ID_item],0, 1, 1, 16)) ;
    if (numBox != numBoxRef ) newDistribution = true ;
    numBoxRef = numBox ;
    Vec3 size = Vec3(size_x_item[ID_item],size_y_item[ID_item],size_z_item[ID_item]) ;
    size.mult(2) ;

    // color and thickness
    aspect_rpe(ID_item) ; 
    //
    distribution(numBox, newDistribution) ;
    
    // MODE DISPLAY with the dropdown menu of controler
    /////////////////////
    if  (mode[ID_item] ==0) boxolyzerClassic(size, horizon[ID_item] , dir_x_item[ID_item]) ;
    else if (mode[ID_item] ==1) boxolyzerCircle(size, (int)canvas_x_item[ID_item], horizon[ID_item], dir_x_item[ID_item]) ;



    // INFO
    objectInfo[ID_item] = ("There is " +numBox + " bands analyzed");
    
  }
  
  //ANNEXE VOID
  void distribution(int n, boolean newOne) {
     if (newOne) newDistributionBoite(n) ;
     newDistribution = false ;
   }
  
  boolean orientation ;
  // BOXLIZER CIRCLE
  void boxolyzerCircle(Vec3 size, int diam, boolean groundPosition, float dir) {
    if( action[ID_item] && rTouch ) orientation = !orientation ;
    int surface = diam*diam ; // surface is equale of square surface where is the cirlcke...make sens ?
    int radius = ceil(radius_from_circle_surface(surface)) ;
    
    int n = boiteList.size() ;
    float factorSpectrum = 0 ;
    Vec3 pos = Vec3() ;
    
    for(int i=0; i < n; i++) {
      if(  i < band.length) factorSpectrum = band [ID_item][i] ;
      float stepAngle = map(i, 0, n, 0, 2*PI) ; 
      float angle =  2*PI - stepAngle;
      if(orientation) pos.set(projection(angle, radius).x +pos.x, projection(angle, radius).y +pos.y, pos.z) ;
      else  pos.set(projection(angle, radius).x +pos.x, 0, projection(angle, radius).y +pos.z) ;

      BOITEaMUSIQUE boiteAmusique = (BOITEaMUSIQUE) boiteList.get(i) ;
      boiteAmusique.showTheBoite(pos, size, factorSpectrum, groundPosition, dir) ;
    }
  }



  // EQUALIZER CLASSIC
  void boxolyzerClassic(Vec3 size, boolean groundPosition, float dir) {
    Vec3 pos = Vec3(0,height *.5 ,0) ;
    float factorSpectrum = 0 ;
    int n = boiteList.size() ;
    // int canvasFinal = width ;
    int canvasFinal = (int)map(canvas_x_item[ID_item], width/10, width, width/2,width*3)  ;
    int displacement_symetric = int(width *.5 -canvasFinal *.5) ;
    for( int i = 0 ; i < n ; i++) {
      pos.x = (i *canvasFinal/n) + (canvasFinal /(n *2)) +displacement_symetric ;
      if( i < band.length) factorSpectrum = band [ID_item][i] ;
      BOITEaMUSIQUE boiteAmusique = (BOITEaMUSIQUE) boiteList.get(i) ;
      if(!FULL_RENDERING) factorSpectrum = .5 ;
      boiteAmusique.showTheBoite(pos, size, factorSpectrum, groundPosition, dir) ;
    }
  }
  // END EQUALIZER
  
  
  
  
  
  
  // GLOBAL VOID
  void boitesSetting() {
    boiteList = new ArrayList<BOITEaMUSIQUE>();
  }
  //
  void newDistributionBoite(int n) {
    boiteList.clear() ;
    for (int i = 0 ; i < n ; i++ ) addBoite(i) ;
  }
  //
  void addBoite(int ID) {
    Vec3 size = Vec3(1) ;
    BOITEaMUSIQUE boiteAmusique = new BOITEaMUSIQUE(size, ID) ; 
    boiteList.add(boiteAmusique) ;
  }
  // END GLOBAL VOID
}
//END







///////
//CLASS
class BOITEaMUSIQUE {
  //PVector pos = new PVector(0,0,0) ;
  Vec3 size ;
  int ID ;
  
  BOITEaMUSIQUE(Vec3 size, int ID) {
    this.ID = ID ;
    this.size = size ;
  }
  
  
  
  void showTheBoite(Vec3 pos, Vec3 size, float factor, boolean groundLine, float dir) {
    Vec3 newSize = Vec3(size.x, size.y *factor, size.z *factor) ;
    //put the box on the ground !

    pushMatrix() ;
    if (!groundLine) {
      translate(pos) ; 
    } else {
      float horizon = pos.y -(newSize.z *.5) ;  
      translate(pos.x, horizon, pos.z) ;
    }
    rotateX(radians(dir)) ;
    box(newSize.x,newSize.y,newSize.z) ;
    popMatrix() ;
  }
}
