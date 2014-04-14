ArrayList <Polygon2D> polygons = new ArrayList <Polygon2D> (); // Liste pour les polygones (objet 8 )
ArrayList <Vec2D> points = new ArrayList <Vec2D> ();


//object three
class Polygone extends SuperRomanesco {
  public Polygone() {
    //from the index_objects.csv
    romanescoName = "Polygone" ;
    IDobj = 9 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Alpha 2.0";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
  }
  //GLOBAL
  int draggedPolygon = -1;
  boolean onPolygon;
  float anglePoly ;
  float speed ;
  PVector finalPos = new PVector(0,0,0) ;
  float ratioSound = 1 ;
  float raioControler = 1 ;
  float ratioFinal ;
  Vec2D mousePolygon;
  ToxiclibsSupport gfx = new ToxiclibsSupport(callingClass);
  
  //SETUP
  void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
    // init
    for(int i = 0 ; i < 4 ; i++) {
      mousePolygon = new Vec2D(random(width),random(height));
      points.add(mousePolygon);
    }
    polygons.add(new Polygon2D(points));
    points.clear();
  }
  
  
  //DRAW
  void display() {
    
    if (parameter[IDobj]) {
      //Dessin des points
      mousePolygon = new Vec2D(mouse[0].x,mouse[0].y);
      
      // prescene preview points
      color cCross = color (hue(strokeObj[IDobj]), saturation(strokeObj[IDobj]), brightness(strokeObj[IDobj]), 120);
      float eCross = map(thicknessObj[IDobj],0,100, 1,15) ; ;
      int sCross = 5 ;
      for (Vec2D p : points) {
        PVector newPos = new PVector ( p.x, p.y) ;
        crossPoint(newPos, cCross, int(eCross), sCross) ;
      }
     
    }
    
    //display shape
    //PARAMETER
    //thickness
    float e = thicknessObj[IDobj] ;
    if ( e < 0.1 ) e = 0.1 ; // security against the negative value
    //gap and scale effect
    float ratioControler = map(amplitudeObj[IDobj], 0, 100, 0.1,10) ;
    float ratioSound = abs(mix[IDobj]) ;
    if (sound[IDobj] ) ratioFinal =  ratioControler *ratioSound ; else ratioFinal =ratioControler ;


    PVector pos = new PVector (mouse[IDobj].x, mouse[IDobj].y ) ;
    PVector posPoly = new PVector ( width/2  - mouse[IDobj].x,
                                    height/2 - mouse[IDobj].y) ; 

    //color
    color colorIn = fillObj[IDobj] ;
    color colorOut = strokeObj[IDobj] ;
    //speed
    if (motion[IDobj]) speed = (map(speedObj[IDobj], 0,100, 0,20)) *tempo[IDobj] ; else speed = 0.0 ;
    anglePoly += speed ;
    if(anglePoly > 360 ) anglePoly = 0 ;
    float angle = map(anglePoly, 0, 360, 0, TAU) ;
        
    if(motion[IDobj]) finalPos = rotation(pos, posPoly, angle) ;
    //.............
    translate(finalPos.x -posPoly.x, finalPos.y -posPoly.y) ;
    scale(ratioFinal) ;

    
    
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
    if ( parameter[IDobj]) {
     
      // if the mouse is NOT on a polygon
      if (!onPolygon) {
        // add a point at mouseX,mouseY
        if(clickShortLeft[IDobj] && nLongTouch ) {
          points.add(mousePolygon);
        }
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
    if ( action[IDobj]) {
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
    if (emptyList(IDobj))  {
      polygons.clear() ;
      points.clear() ;
    }
    
  }
}
//end object two


