void test_set_pix_density() {
  background(0);
  for(int i = 0 ; i < 200000 ; i++) {
    int x = (int)random(width);
    int y = (int)random(height);
    int c = r.WHITE;
    set(x,y,c);
  }
}