//GLOBAL
RomanescoNine romanescoNine ;






//SETUP
void romanescoNineSetup() {
    //MUST CHANGE THE ID
  //Example : If it's RomanestoThirtySetup int ID = 30 ;
  int ID = 9 ; // 0 is Ref you must use a number is the order of apparition in the controleur, start from top left and follow the horizontal line
  
  int IDfamilly = 1 ; // 1 is single object // 2 is trame // 3 is typo    ....... // 0 is global don't use this one it's for specific stuff
  romanescoNine = new RomanescoNine (ID, IDfamilly) ;
  
  romanescoNine.setting() ;
}


//DRAW
void romanescoNineDraw(String [] dataControleur, String [] dataMinim) {
  romanescoNine.getID() ;
  romanescoNine.data(dataControleur, dataMinim) ;
  romanescoNine.display() ;
}

//MOUSEPRESSED
void romanescoNineMousepressed() { romanescoNine.mousepressed() ; }
//MOUSERELEASED
void romanescoNineMousereleased() { romanescoNine.mousereleased() ; }
//MOUSE DRAGGED
void romanescoNineMousedragged() { romanescoNine.mousedragged() ; }
//KEYPRESSED
void romanescoNineKeypressed() { romanescoNine.keypressed() ; }
//KEY RELEASED
void romanescoNineKeyreleased() { romanescoNine.keyreleased() ; }

//Return the ID familly to choice the data must be send to the class // 0 is global // 1 is Object // 2 is trame // 3 is typo
int getFamillyRomanescoNine() { return romanescoNine.getIDfamilly() ; }

////////////
//CLASS////
//GLOBAL
// here you can put your array list for example

//////////////////////////////////////////
class RomanescoNine extends SuperRomanesco 
{
  //FORBIDEN TO TOUCH
  int IDfamilly ;
  //class 
  ArrayList <Polygon2D> polygons = new ArrayList <Polygon2D> (); // Liste pour les polygones (objet 8 )
  ArrayList <Vec2D> points = new ArrayList <Vec2D> ();
  //.......Variable polygones
  int draggedPolygon = -1;
 // ToxiclibsSupport gfx;
  boolean onPolygon;
  Vec2D mousePolygon;
  
  float anglePoly ;
  //speed
  float speed ;
  PVector finalPos = new PVector(0,0,0) ;
  
  ///////IMPORTANT////////////////////////////////////
  //calling external class or library in class
  ToxiclibsSupport gfx;
  
  //CONSTRUCTOR
  RomanescoNine(int ID, int IDfamilly) {
    super(ID) ;
    this.IDfamilly = IDfamilly ;
    /////////IMPORTANT//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //calling external class or library in class you must use (callingClass) when you initialize this one to call the PApplet in your class
    gfx = new ToxiclibsSupport(callingClass);
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  }
  //END CONSTRUCTOR
  
  ////SETUP
  //the setting that's stuff that you'r put usually in the void setup() 
  void setting() {
    // init
    for(int i = 0 ; i < 4 ; i++) {
      mousePolygon = new Vec2D(random(width),random(height));
      points.add(mousePolygon);
    }
    polygons.add(new Polygon2D(points));
    points.clear();
  }
  ///////////
  //END SETUP
  
  
  
  //////DRAW
  //float rapport = 1 ;
  float ratioSound = 1 ;
  float raioControler = 1 ;
  float ratioFinal ;
  //display
  void display() {
    // starting position
    if (startingPosition[IDobj]) startPosition(IDobj, width/2, height/2, 0) ;
    
    pushMatrix() ;
    //P3D Give the position and the orientation of your object in the 3 dimensionals space
    P3Dmanipulation(IDobj) ;
    //END OF DON'T TOUCH
    
    //////////////////////
    //HERE IT'S FOR YOU

    //draw points befare making shape
    if (parameterButton[IDobj] > 0 ) {
      //Dessin des points
      mousePolygon = new Vec2D(mouse[0].x,mouse[0].y);
      
      // prescene preview points
      color cCross = color (map(valueObj[IDobj][2],0,100,0,360), valueObj[IDobj][4], valueObj[IDobj][6] , 120);
      float eCross = map(valueObj[IDobj][13],0,100, 1,15) ; ;
      int sCross = 5 ;
      for (Vec2D p : points) {
        PVector newPos = new PVector ( p.x, p.y) ;
        crossPoint(newPos, cCross, int(eCross), sCross) ;
      }
     
    }
    
    //display shape
    //PARAMETER
    //thickness
    float e = valueObj[IDobj][13] ;
    if ( e < 0.1 ) e = 0.1 ; // security against the negative value
    //gap and scale effect
    float ratioControler = map(valueObj[IDobj][17], 0, 100, 0.1,10) ;
    float ratioSound = abs(mix[IDobj]) ;
    if (soundButton[IDobj] != 0 ) ratioFinal =  ratioControler *ratioSound ; else ratioFinal =ratioControler ;


    PVector pos = new PVector (mouse[IDobj].x, mouse[IDobj].y ) ;
    PVector posPoly = new PVector ( width/2  - mouse[IDobj].x,
                                    height/2 - mouse[IDobj].y) ; 

    //color
    color colorIn = color ( map(valueObj[IDobj][1],0,100,0,360), valueObj[IDobj][2], valueObj[IDobj][3],valueObj[IDobj][4] ) ;
    color colorOut = color ( map(valueObj[IDobj][5],0,100,0,360), valueObj[IDobj][6], valueObj[IDobj][7],valueObj[IDobj][8] ) ;
   
    //speed
    if (motion[IDobj]) speed = (map(valueObj[IDobj][16], 0,100, 0,20)) *tempo[IDobj] ; else speed = 0.0 ;
    anglePoly += speed ;
    if(anglePoly > 360 ) anglePoly = 0 ;
    float angle = map(anglePoly, 0, 360, 0, TAU) ;
        
    if(motion[IDobj]) finalPos = rotation (pos, posPoly, angle) ;

    //.............
   // if (actionButton[IDobj] == 1 ) {
      translate(finalPos.x -posPoly.x, finalPos.y -posPoly.y) ;
      scale(ratioFinal) ;
    //} 
    
    
    // (re)set onPolygon to false
    onPolygon = false;
    // draw all the polygons
    for (Polygon2D p : polygons) {
      //check the opacity of color
      int alphaIn = (colorIn >> 24) & 0xFF; 
      int alphaOut = (colorOut >> 24) & 0xFF; 
      // to display or not
      if ( alphaIn == 0 ) noFill() ; else fill (colorIn) ;
      if ( alphaOut == 0) {
        noStroke() ;
      } else {
        stroke ( colorOut ) ; 
        if( e < 0.1 ) e = 0.1 ; //security for the negative value
        strokeWeight (e) ;
      }
      gfx.polygon2D(p);
    }
    
    
    
    
    //create the shape and close the shape
    if (  parameterButton[IDobj] == 1 ) {
      // if the mouse is NOT on a polygon
      if (!onPolygon) {
        // add a point at mouseX,mouseY
        if(clickShortLeft[IDobj] && nLongTouch ) points.add(mousePolygon);
        // if the right mouse button is pressed
        // and there are more than 2 points
        if (clickLongRight[IDobj] && points.size() > 2) {
          // create a polygon from the points
          polygons.add(new Polygon2D(points));
          // clear the points
          points.clear();
        }
      }
    }
    
    
    //remove specific shape
    if ( actionButton[IDobj] == 1  ) {
      // delete the polygon under the mouse
      if (dTouch && !clickLongLeft[IDobj] && !clickLongRight[IDobj] && !clickShortLeft[IDobj] && !clickShortRight[IDobj]) {
        for (int i=polygons.size()-1; i>=0; i--) {
          if (polygons.get(i).containsPoint(mousePolygon)) {
            polygons.remove(i);
          }
        }
      }
      // remove the last point (if points > 0)
      if (xTouch) {
        if (points.size() > 0) {
          points.remove(points.size()-1);
        }
      }
    }
    
    
    //move polygone probleme
    // if (actionButton[IDobj] == 1 ) draggedPolygon = -1 ; 
    
    
    /////////////////////////////
    //CLEAR THE LIST IF NECESSARY 
    if (romanescoEmptyList(IDobj))  {
      polygons.clear() ;
      points.clear() ;
    }
    //IT'S THE END FOR YOU
    //////////////////////
    
    //DON'T TOUCH
    popMatrix() ;
    //END OF DON'T TOUCH
  }
  //END DRAW
  
  //KEYPRESSED
  void keypressed() {}
  //KEY RELEASED
  void keyreleased() {}
  //MOUSEPRESSED
  void mousepressed() {}
  //MOUSE RELEASED
  void mousereleased() {}
  //MOUSE DRAGGED
  void mousedragged() {}
  
  
  //ANNEXE VOID
  void annexe() {}
  
  
  
  
  
  /////////////////////////////
  //FORDIDEN TO TOUCH THIS VOID
  /////////////////////////////
  //DATA VOID
  void data( String [] dataControler, String [] dataMinin) {
    super.data(dataControler, dataMinin) ;
  }
  ////////////
  //Return ID
  int getID() {
    return IDobj ;
  }
  int getIDfamilly() {
    return IDfamilly ;
  }
  ///////////////////////////
  //////////////////////////
}
