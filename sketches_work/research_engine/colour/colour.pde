void setup() {
}
/**
IN PROGRESS
*/
int colour(int x, int y, int z) {
  return colour(x,y,z,255);
}

int colour(int x, int z) {
  return colour(x,x,x,z);
}

int colour(int x) {
  return colour(x,x,x,255);
}


int colour(int x, int y, int z, int w) {
  colorMode(RGB,255);
  return color(x,y,z,w);
}

int colour(iVec4 c) {
  colorMode(RGB,255);
  return color(c.x,c.y,c.z,c.w);
}


iVec4 rgba(int c) {
  colorMode(RGB,255);
  return iVec4((int)red(c),(int)green(c),(int)blue(c),(int)alpha(c));
}

iVec3 rgb(int c) {
  colorMode(RGB,255);
  return iVec3((int)red(c),(int)green(c),(int)blue(c));
}

iVec4 hsba(int c) {
  colorMode(RGB,255);
  return iVec4((int)hue(c),(int)saturation(c),(int)brightness(c),(int)alpha(c));
}

iVec3 hsb(int c) {
  colorMode(RGB,255);
  return iVec3((int)hue(c),(int)saturation(c),(int)brightness(c));
}
