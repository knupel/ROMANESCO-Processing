float rotate_x,rotate_y,rotate_z;
void debug_shape() {
	rotate_x += .01;
	rotate_y += .02;
  println("shape debug",frameCount);
  
  fill(0,100,100);
  stroke(0,100,0);
  strokeWeight(2);
  pushMatrix();
  
  translate(width/2,height/2,height/3);
  rotateX(rotate_x);
  rotateZ(rotate_y);

  box(100);
  popMatrix();
}


void debug_background() {
	println("background debug",frameCount);
	background_rope(0,100,0);
}


void test_set_pix_density() {
  background(0);
  for(int i = 0 ; i < 200000 ; i++) {
    int x = (int)random(width);
    int y = (int)random(height);
    int c = r.WHITE;
    set(x,y,c);
  }
}




