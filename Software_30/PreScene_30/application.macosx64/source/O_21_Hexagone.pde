/**
HONEYCOMB || 2011 || 0.1.1
*/
ArrayList <Hexagon> grid = new ArrayList <Hexagon> (); // the arrayList to store the whole grid of cells

class Honeycomb extends Romanesco {
  public Honeycomb() {
    //from the index_objects.csv
    RPE_name = "Nid d'abeille" ;
    ID_item = 21 ;
    ID_group = 1 ;
    RPE_author  = "Amnon Owed";
    RPE_version = "Version 0.1.1";
    RPE_pack = "Base" ;
    RPE_mode = "" ;
    RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Thickness,Size X,Canvas X,Canvas Y" ;
  }
  //GLOBAL
  boolean newHoneycomb  ;
  float hexagonRadius = 8.8; // the radius of the individual hexagon cell
  float radiusRef = hexagonRadius ;
  float hexagonStroke = 3.0; // stroke weight around hexagons (simulated! much faster than using the stroke() method)
  float strokeRef = hexagonStroke ;
  float neighbourDistance = hexagonRadius*2 ; // the default distance to include up to 6 neighbours
  PVector canvas, canvasRef ;
  
  float sliderCanvasX, sliderCanvasY, sliderCanvasXref, sliderCanvasYref ;
  boolean initRef = true ;

  
  PVector[] v = new PVector[6]; // an array to store the 6 pre-calculated vertex positions of a hexagon

  //SETUP
  void setup() {
    startPosition(ID_item, width/2, height/2, 0) ;
    canvas = new PVector(width, height) ;
    canvasRef = canvas.copy();
    initGrid(canvas); // initialize the CA grid of hexagons (including neighbour search and creation of hexagon vertex positions)
  }
  //DRAW
  void draw() {
    neighbourDistance = hexagonRadius *2;
    hexagonStroke = thickness_item[ID_item] ;
    hexagonRadius = map(size_x_item[ID_item],.1,width, width /40, width/15)  ;

    
    // limitation for the preview
    int minSize = width/80 ;
    if(FULL_RENDERING) {
      sliderCanvasX = map(canvas_x_item[ID_item], width/10, width, minSize, width *4) ;
      sliderCanvasY = map(canvas_y_item[ID_item], width/10, width, minSize, width *4) ;      
    } else {
      sliderCanvasX = map(canvas_x_item[ID_item], width/10, width, minSize, width) ;
      sliderCanvasY = map(canvas_y_item[ID_item], width/10, width, minSize, width) ;
    }
    
    
    canvas = new PVector(sliderCanvasX,sliderCanvasY) ;
      
    // Good idea to lock the value when you come back for a new slider setting, must work around this concept
    if(initRef) {
      sliderCanvasXref = sliderCanvasX ;
      sliderCanvasYref = sliderCanvasY ;
      initRef = false ;
    }

    sliderCanvasXref = sliderCanvasX ;
    sliderCanvasYref = sliderCanvasY ;
    
    // music factor
    float soundSizeFactor ;
    if(getTimeTrack() > 0.2) soundSizeFactor = allBeats(ID_item) ; else soundSizeFactor = 1.0 ;
    

    if(hexagonRadius != radiusRef || hexagonStroke != strokeRef || (canvas.x != canvasRef.x || canvas.y != canvasRef.y) ) {
      initGrid(canvas);
    }
    //update the reference
    canvasRef = canvas.copy() ;
    strokeRef = hexagonStroke ;
    radiusRef = hexagonRadius ;
    
    // DISPLAY
    noStroke() ;
    pushMatrix() ;
    translate(-width/2, -height/2) ;
    for (Hexagon h : grid) { h.calculateNewColor(); }
  
    // change the color of each hexagon cell to the new color and display it
    // this can be done in one loop because all calculations are already finished
    
    for (Hexagon h : grid) {
      h.changeColor();
      h.display(v, fill_item[ID_item],soundSizeFactor);
    }
    popMatrix() ;
    
    // new honeycomb
    //if((action[ID_item] && xTouch) || allBeats(ID_item) >= 3.125 ) newHoneycomb = true ;
    if((action[ID_item] && nTouch)) newHoneycomb = true ;
    
    if(newHoneycomb) {
      float r = random(1000000); // random number that is used by all the hexagon cells...
      for (Hexagon h : grid) { h.resetColor(r); } // ... to generate a new color
      newHoneycomb = false ;
    }
    
    
    // INFO
    objectInfo[ID_item] = (grid.size() + " hexagons") ;
  }
  
  
  
  // ANNEXE VOID
  // do everything needed to start up the grid ONCE
  void initGrid(PVector canvas) {
    grid.clear(); // clear the grid
    
    // calculate horizontal grid size based on sketch width, hexagonRadius and a 'safety margin'
    int hX = int(canvas.x/hexagonRadius/3)+2;
    // calculate vertical grid size based on sketch height, hexagonRadius and a 'safety margin'
    int hY = int(canvas.y/hexagonRadius/0.866)+3;
    
    // create the grid of hexagons
    for (int i=0; i<hX; i++) {
      for (int j=0; j<hY; j++) {
        // each hexagon contains it's xy position within the grid (also see the Hexagon class)
        grid.add(new Hexagon(i, j,hexagonRadius) );
      }
    }
    
    // let each hexagon in the grid find it's neighbours
    for (Hexagon h : grid) {
      h.getNeighbours(neighbourDistance);
    }
    
    // create the vertex positions for the hexagon
    for (int i=0; i<6; i++) {
      float r = hexagonRadius - hexagonStroke * 0.5; // adapt radius to facilitate the 'simulated stroke'
      float theta = i*PI/3;
      v[i] = new PVector(r*cos(theta), r*sin(theta));
    }
  }
}
//end object two







/*

 Hexagon class to store a single cell inside a grid that can do the following things:
 - calculate it's own actual xy position based on it's ij coordinates within the grid
 - find it's neighbours within the grid based on a distance function
 - set it's color based on my own experimental color formula ;-)
 - calculate the average color of it's neighbours
 - calculate it's new color based on a set of rules
 - change it's current color by it's new color
 - display itself as a colored hexagon
 
*/

class Hexagon {
  float x, y; // actual xy position
  ArrayList <Hexagon> neighbours = new ArrayList <Hexagon> (); // arrayList to store the neighbours
  float currentColor, newColor; // store the current and new colors (actually just the hue)

  Hexagon(int i, int j, float radius) {
    x = 3*radius*(i+((j%2==0)?0:0.5)); // calculate the actual x position within the sketch window
    y = 0.866*radius*j; // calculate the actual y position within the sketch window
    resetColor(0); // set the initial color
  }

  void resetColor(float r) {
    currentColor = (r+sin(x+r*0.01)*30+y/6)%360; // could be anything, but this makes the grid look good! :D
  }

  // given a distance parameter, this will add all the neighbours within range to the list
  void getNeighbours(float distance) {
    // neighbours.clear(); // in this sketch not required because neighbours are only searched once
    for (Hexagon h : grid) { // for all the cells in the grid
      if (h!=this) { // if it's not the cell itself
        if (dist(x,y, h.x,h.y) < distance) { // if it's within distance
          neighbours.add( h ); // then add it to the list: "Welcome neighbour!"
        }
      }
    }
  }
  
  // calculate the new color based on a completely arbitrary set of 'rules'
  // this could be anything, right now it's this, which makes the CA pretty dynamic
  // if you tweak this in the wrong way you quickly end up with boring static states
  void calculateNewColor() {
    float avgColor = averageColor(); // get the average of the neighbours (see other method)
    float tmpColor = currentColor;
    if (avgColor < 0) {
      tmpColor = 50; // if the average color is below 0, set the color to 50
    } else if (avgColor < 150) {
      tmpColor += 5; // if the average color is between 0 and 150, add 5 to the color
    } else if (avgColor > 210) {
      tmpColor -= 5; // if the average color is above 210, subtract 5 from the color
    }
    // in all other cases (aka the average color is between 150 and 210) the color remains unchanged
    newColor = tmpColor;
  }
  
  // returns the average color (aka hue) of the neighbours
  float averageColor() {
    float avgColor = 0; // start with 0
    for (Hexagon h : neighbours) {
      avgColor += h.currentColor; // add the color from each neighbour
    }
    avgColor /= neighbours.size(); // divide by the number of neighbours
    return avgColor; // done!
  }
  
  void changeColor() {
    currentColor = newColor; // set the current color to the new(ly calculated) color
  }

  // display the hexagon at position xy with the current color
  // use the vertex positions that have been pre-calculated ONCE (instead of re-calculating these for each cell on each draw)
  void display(PVector[] v, color in, float factor) {
    pushMatrix();
    translate(x, y);
    fill(currentColor, saturation(in), brightness(in), alpha(in));
    beginShape();
    for (int i=0; i<6; i++) { vertex(v[i].x *factor, v[i].y *factor); }
    endShape();
    popMatrix();
  }
}