/**
 * Basic Drawing
 * by Andres Colubri. 
 * 
 * This program shows how to use the tilt values from the pen.
 */
 
import codeanticode.tablet.*;

Tablet tablet;

void setup() {
  size(640, 480, P2D); // Using OpenGL renderer
 
  tablet = new Tablet(this); 
  
  background(0);
  stroke(200, 150);
  strokeWeight(2);  
}

void draw() {
  if (0 < tablet.getPressure()) {
    float x = tablet.getTiltX();
    float y = tablet.getTiltY();
    line(mouseX, mouseY, mouseX + 20 * x, mouseY + 20 * y);      
  }
}