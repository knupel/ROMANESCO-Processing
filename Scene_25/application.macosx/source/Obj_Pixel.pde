/////////////
//CLASS PIXEL
/////////////
class Pixel
{
  color c, newColor ;
  PVector newC = new PVector (0,0,0) ; ;
  PVector pos ;
  PVector newPos = new PVector(0,0,0) ; // absolute pos in the display size : horizontal sytem of pixel system
  PVector gridPos ; // position with cols and rows system : vertical system of ArrayList
  PVector size = new PVector (1,1) ;
  PVector vent ; // the wind force who can change the position of the pixel
  int rank = -1 ;
  int ID = 0 ;
  
  //DIFFERENT CONSTRUCTOR
  
  //classic pixel
  Pixel(PVector pos, color c)
  {
    this.pos = pos ;
    this.c = c ;
  }
  
  //pixel with size
   Pixel(PVector pos, color c, PVector size)
  {
    this.pos = pos ;
    this.c = c ;
    this.size = size ;
  }
  
  //rank pixel in the array
  Pixel(int rank, PVector gridPos)
  {
    this.rank = rank ;
    this.gridPos = gridPos ;
  }
  
  //rank
  Pixel(int rank)
  {
    this.rank = rank ;
  }
  
  
  
  
  //DISPLAY
  //with effect
  void displayPixel(int diam, PVector effectColor)
  {
    strokeWeight(diam) ;
    
    stroke(hue(newColor), effectColor.x *saturation(newColor), effectColor.y *brightness(newColor), effectColor.z) ;
    if (newPos.x == 0 && newPos.y == 0 && newPos.z == 0) newPos = pos ; else newPos = newPos ;
    point(newPos.x, newPos.y) ;
  }
  
  //withou effect
  void displayPixel(int diam)
  {
    strokeWeight(diam) ;
    stroke(c) ;
    if (newPos.x == 0 && newPos.y == 0 && newPos.z == 0) newPos = pos ; else newPos = newPos ;
    //test display with ID
    if (ID == 1 ) point(newPos.x, newPos.y) ;
  }
  
  //Identité de la pixel
  //change ID after analyze if this one is good
  void changeID(int newID) {  ID = newID ; }
  
  
  
  
  
  //CHANGE COLOR 
  // hue from Range
  void changeHue(int[] newHue,  int[] start, int[] end)
  {
    float h = hue(c) ;
    
    for( int i = 0 ; i < newHue.length ; i++) {
      if (start[i] < end[i] ) {
        if( h >= start[i] && h <= end[i] ) h = newHue[i] ; 
      } else if ( start[i] > end[i] ) {
        if( (h >= start[i] && h <= HSBmode.x) || h <= end[i] ) { 
          if( h >= newHue[newHue.length -1] ) h = newHue[newHue.length -1] ; 
          else h = newHue[i] ; 
        }
      }        
    }
    newC.x = h ;
  }
  
  // saturation from Range
  void changeSat(int[] newSat,  int[] start, int[] end)
  {
    float s = saturation(c) ;
    
    for( int i = 0 ; i < newSat.length ; i++) {
      if (start[i] < end[i] ) {
        if( s >= start[i] && s <= end[i] ) s = newSat[i] ; 
      } else if ( start[i] > end[i] ) {
        if( (s >= start[i] && s <= HSBmode.y) || s <= end[i] ) { 
          if( s >= newSat[newSat.length -1] ) s = newSat[newSat.length -1] ; 
          else s = newSat[i] ;
        }
      }        
    }
    newC.y = s ;
  }
  
  // saturation from Range
  void changeBright(int[] newBright,  int[] start, int[] end)
  {
    float b = brightness(c) ;

    
    for( int i = 0 ; i < newBright.length ; i++) {
      if (start[i] < end[i] ) {
        if( b >= start[i] && b <= end[i] ) b = newBright[i] ; 
      } else if ( start[i] > end[i] ) {
        if( (b >= start[i] && b <= HSBmode.z) || b <= end[i] ) { 
          if( b >= newBright[newBright.length -1] ) b = newBright[newBright.length -1] ; 
          else b = newBright[i] ;
        }
      }        
    }
    newC.z = b ;
  }
  
  
  
  //change color of pixel for single color
  void changeColor(color nc) { color c = nc ; }
  
  void updatePalette() { 
    int h = (int)newC.x ;
    int s = (int)newC.y ;
    int b = (int)newC.z ;

    newColor = color(h, s, b) ;
  }
  
  
  //UPDATE POSITION with the wind
  void updatePosPixel(PVector effectPosition, PImage pic)
  {
    PVector dir = normalDir((int)effectPosition.x) ;
    
    vent = new PVector (1.0 *dir.x *effectPosition.y  + random(-effectPosition.z, effectPosition.z) ,   1.0 *dir.y *effectPosition.y  + random(-effectPosition.z, effectPosition.z))   ;
    pos.add(vent) ;
    //keep the pixel in the scene
    if (pos.x< 0)          pos.x= pic.width;
    if (pos.x> pic.width)  pos.x=0;
    if (pos.y< 0)          pos.y= pic.height;
    if (pos.y> pic.height) pos.y=0;
  }
  
  
  
  //return position with display size
  PVector posPixel(PVector effectPosition, PImage pic)
  {
    PVector dir = normalDir((int)effectPosition.x) ;

    newPos = pos ;
    
    vent = new PVector (1.0 *dir.x *effectPosition.y  + random(-effectPosition.z, effectPosition.z) ,   1.0 *dir.y *effectPosition.y  + random(-effectPosition.z, effectPosition.z))   ;
    newPos.add(vent) ;
    //keep the pixel in the scene
    if (newPos.x< 0)          newPos.x= pic.width;
    if (newPos.x> pic.width)  newPos.x=0;
    if (newPos.y< 0)          newPos.y= pic.height;
    if (newPos.y> pic.height) newPos.y=0;
    
    return new PVector (newPos.x, newPos.y) ;
  }
}
