
/**
COLOUR 
v 0.4.0
Pack of method to use colour, palette...
*/


/**
COLOUR LIST class
v 0.0.2
*/
/**
* Idea for the future add a list name for colour

* get the colour by index or name
*/
public class ROPE_colour implements Rope_Constants {
	int [] c;
	public ROPE_colour(int... c) {
		this.c = new int[c.length];
		for(int i = 0; i < c.length ; i++) {
			this.c[i] = c[i];
		}
	}

	public int[] get_colour() {
		return c;
	}

	float[] get_hue() {
		float[] component = new float[c.length];
		for(int i = 0 ; i < c.length ; i++) {
			component[i] = hue(c[i]);
		}
		return component;
	}

	public float[] get_saturation() {
		float[] component = new float[c.length];
		for(int i = 0 ; i < c.length ; i++) {
			component[i] = saturation(c[i]);
		}
		return component;
	}

	public float[] get_brightness() {
		float[] component = new float[c.length];
		for(int i = 0 ; i < c.length ; i++) {
			component[i] = brightness(c[i]);
		}
		return component;
	}

	public float[] get_red() {
		float[] component = new float[c.length];
		for(int i = 0 ; i < c.length ; i++) {
			component[i] = red(c[i]);
		}
		return component;
	}

	public float[] get_green() {
		float[] component = new float[c.length];
		for(int i = 0 ; i < c.length ; i++) {
			component[i] = green(c[i]);
		}
		return component;
	}

	public float[] get_blue() {
		float[] component = new float[c.length];
		for(int i = 0 ; i < c.length ; i++) {
			component[i] = blue(c[i]);
		}
		return component;
	}

	public float[] get_alpha() {
		float[] component = new float[c.length];
		for(int i = 0 ; i < c.length ; i++) {
			component[i] = blue(c[i]);
		}
		return component;
	}
}




/**
GET COLORMODE
v 0.0.2
*/
/**
* getColorMode()
* @return float array of your color environment.
* @param boolean print_info_is retrun a print about the color environment
*/
float [] getColorMode(boolean print_info_is) {
  float colorMode = g.colorMode ;
  float x = g.colorModeX;
  float y = g.colorModeY;
  float z = g.colorModeZ;
  float a = g.colorModeA;
  float array[] = {colorMode,x,y,z,a};
  if (print_info_is && g.colorMode == HSB) {
    println("HSB",x,y,z,a);
  } else if(print_info_is && g.colorMode == RGB) {
    println("RGB",x,y,z,a);
  }
  return array;
}

float [] getColorMode() {
  return getColorMode(false);
}

/**
camaieu 
v 0.1.1
*/
// return hue or other date in range of specific data float
float camaieu(float max, float color_ref, float range) {
  float camaieu = 0 ;
  float which_color = random(-range, range) ;
  camaieu = color_ref +which_color ;
  if(camaieu < 0 ) camaieu = max +camaieu ;
  if(camaieu > max) camaieu = camaieu -max ;
  return camaieu ;
}







/**
color pool 
v 0.2.0
*/
// color pool Vec4 RGB
Vec4 [] color_pool_RGB(int num) {
  Vec2 sat_range = Vec2(g.colorModeY) ;
  Vec2 bright_range = Vec2(g.colorModeZ) ;
  Vec2 alpha_range = Vec2(g.colorModeA) ;
  float range = g.colorModeX *.5 ;
  int num_group = 1 ;
  float key_hue = -1 ;
  return color_pool_RGB(num, num_group, key_hue, range, sat_range, bright_range, alpha_range) ;
}

Vec4 [] color_pool_RGB(int num, float key_hue) {
  Vec2 sat_range = Vec2(g.colorModeY) ;
  Vec2 bright_range = Vec2(g.colorModeZ) ;
  Vec2 alpha_range = Vec2(g.colorModeA) ;
  float range = g.colorModeX *.5 ;
  int num_group = 1 ;
  return color_pool_RGB(num, num_group, key_hue, range, sat_range, bright_range, alpha_range) ;
}


Vec4 [] color_pool_RGB(int num, int num_group, float hue_range) {
  Vec2 sat_range = Vec2(g.colorModeY) ;
  Vec2 bright_range = Vec2(g.colorModeZ) ;
  Vec2 alpha_range = Vec2(g.colorModeA) ;
  float key_hue = -1 ;
  return color_pool_RGB(num, num_group, key_hue, hue_range, sat_range, bright_range, alpha_range) ;
}


Vec4 [] color_pool_RGB(int num, int num_group, float key_hue, float hue_range) {
  Vec2 sat_range = Vec2(g.colorModeY) ;
  Vec2 bright_range = Vec2(g.colorModeZ) ;
  Vec2 alpha_range = Vec2(g.colorModeA) ;
  return color_pool_RGB(num, num_group, key_hue, hue_range, sat_range, bright_range, alpha_range) ;
}

Vec4 [] color_pool_RGB(int num, int num_group, float hue_range, Vec2 sat_range, Vec2 bright_range, Vec2 alpha_range) {
  float key_hue = -1 ;
  return color_pool_RGB(num, num_group, key_hue, hue_range, sat_range, bright_range, alpha_range) ;
}


Vec4 [] color_pool_RGB(int num, int num_group, float key_hue, float hue_range, Vec2 sat_range, Vec2 bright_range, Vec2 alpha_range) {
  Vec4 [] list = new Vec4[num]  ;
  int [] c = color_pool(num, num_group, key_hue, hue_range, sat_range, bright_range, alpha_range) ;
  for(int i = 0 ; i <list.length ; i++) {
    list[i] = new Vec4(red(c[i]),green(c[i]),blue(c[i]),alpha(c[i])) ;
  }
  return list ;
}

// color pool Vec4 HSB
Vec4 [] color_pool_HSB(int num) {
  Vec2 sat_range = Vec2(g.colorModeY) ;
  Vec2 bright_range = Vec2(g.colorModeZ) ;
  Vec2 alpha_range = Vec2(g.colorModeA) ;
  float range = g.colorModeX *.5 ;
  int num_group = 1 ;
  float key_hue = -1 ;
  return color_pool_HSB(num, num_group, key_hue, range, sat_range, bright_range, alpha_range) ;
}

Vec4 [] color_pool_HSB(int num, float key_hue) {
  Vec2 sat_range = Vec2(g.colorModeY) ;
  Vec2 bright_range = Vec2(g.colorModeZ) ;
  Vec2 alpha_range = Vec2(g.colorModeA) ;
  float range = g.colorModeX *.5 ;
  int num_group = 1 ;
  return color_pool_HSB(num, num_group, key_hue, range, sat_range, bright_range, alpha_range) ;
}


Vec4 [] color_pool_HSB(int num, int num_group, float hue_range) {
  Vec2 sat_range = Vec2(g.colorModeY) ;
  Vec2 bright_range = Vec2(g.colorModeZ) ;
  Vec2 alpha_range = Vec2(g.colorModeA) ;
  float key_hue = -1 ;
  return color_pool_HSB(num, num_group, key_hue, hue_range, sat_range, bright_range, alpha_range) ;
}


Vec4 [] color_pool_HSB(int num, int num_group, float key_hue, float hue_range) {
  Vec2 sat_range = Vec2(g.colorModeY) ;
  Vec2 bright_range = Vec2(g.colorModeZ) ;
  Vec2 alpha_range = Vec2(g.colorModeA) ;
  return color_pool_HSB(num, num_group, key_hue, hue_range, sat_range, bright_range, alpha_range) ;
}

Vec4 [] color_pool_HSB(int num, int num_group, float hue_range, Vec2 sat_range, Vec2 bright_range, Vec2 alpha_range) {
  float key_hue = -1 ;
  return color_pool_HSB(num, num_group, key_hue, hue_range, sat_range, bright_range, alpha_range) ;
}


Vec4 [] color_pool_HSB(int num, int num_group, float key_hue, float hue_range, Vec2 sat_range, Vec2 bright_range, Vec2 alpha_range) {
  Vec4 [] list = new Vec4[num]  ;
  int [] c = color_pool(num, num_group, key_hue, hue_range, sat_range, bright_range, alpha_range) ;
  for(int i = 0 ; i <list.length ; i++) {
    list[i] = new Vec4(hue(c[i]),saturation(c[i]),brightness(c[i]),alpha(c[i])) ;
  }
  return list ;
}

// color pool int
int [] color_pool(int num) {
  Vec2 sat_range = Vec2(g.colorModeY) ;
  Vec2 bright_range = Vec2(g.colorModeZ) ;
  Vec2 alpha_range = Vec2(g.colorModeA) ;
  float range = g.colorModeX *.5 ;
  int num_group = 1 ;
  float key_hue = -1 ;
  return color_pool(num, num_group, key_hue, range, sat_range, bright_range, alpha_range) ;
}

int [] color_pool(int num, float key_hue) {
  Vec2 sat_range = Vec2(g.colorModeY) ;
  Vec2 bright_range = Vec2(g.colorModeZ) ;
  Vec2 alpha_range = Vec2(g.colorModeA) ;
  float range = g.colorModeX *.5 ;
  int num_group = 1 ;
  return color_pool(num, num_group, key_hue, range, sat_range, bright_range, alpha_range) ;
}

int [] color_pool(int num, int num_group, float hue_range) {
  Vec2 sat_range = Vec2(g.colorModeY) ;
  Vec2 bright_range = Vec2(g.colorModeZ) ;
  Vec2 alpha_range = Vec2(g.colorModeA) ;
  float key_hue = -1 ;
  return color_pool(num, num_group, key_hue, hue_range, sat_range, bright_range, alpha_range) ;
}

int [] color_pool(int num, int num_group, float key_hue, float hue_range) {
  Vec2 sat_range = Vec2(g.colorModeY) ;
  Vec2 bright_range = Vec2(g.colorModeZ) ;
  Vec2 alpha_range = Vec2(g.colorModeA) ;
  return color_pool(num, num_group, key_hue, hue_range, sat_range, bright_range, alpha_range) ;
}

int [] color_pool(int num, int num_group, float hue_range, Vec2 sat_range, Vec2 bright_range, Vec2 alpha_range) {
  float key_hue = -1 ;
  return color_pool(num, num_group, key_hue, hue_range, sat_range, bright_range, alpha_range) ;

}

// color pool by group
int [] color_pool(int num, int num_group, float key_hue, float hue_range, Vec2 sat_range, Vec2 bright_range, Vec2 alpha_range) {
  int ref = g.colorMode ;
  float x = g.colorModeX ;
  float y = g.colorModeY ;
  float z = g.colorModeZ ;
  float a = g.colorModeA ;
  colorMode(HSB,360,100,100,100) ;

  float [] color_ref = new float[num_group] ;
  if(key_hue >= 0 ) {
    color_ref[0] = key_hue ;
  } else {
    color_ref[0] = random(g.colorModeX) ;
  }
  if(num_group > 1) {
    float step = g.colorModeX / num_group ;
    for(int i = 1 ; i < num_group ; i++) {
      color_ref[i] = color_ref[i -1] + step ;
      if(color_ref[i] > g.colorModeX) {
        color_ref[i] = color_ref[i] - g.colorModeX ;
      }      
    }
  }

  int [] list = new int[num] ;
  int count = 0 ;
  int step = num / num_group ;
  int next_stop = step ; ;
  for(int i = 0 ; i < list.length ; i++) {
    if(i > next_stop) {
      next_stop += step ;
    }
    float saturation = random(sat_range) ;
    float brightness = random(bright_range) ;
    float alpha = random(alpha_range) ;
    float hue = camaieu(g.colorModeX, color_ref[count], hue_range) ;
    list[i] = color(hue, saturation,brightness, alpha) ;
    count++ ;
    if(count >= color_ref.length) count = 0 ;

  }
  colorMode(ref,x,y,z,a) ;
  return list ;
}





/**
component range
*/
boolean alpha_range(float min, float max, int colour) {
  float alpha = alpha(colour) ;
  return in_range(min, max, alpha) ;
}

boolean red_range(float min, float max, int colour) {
  float  r = red(colour) ;
  return in_range(min, max, r) ;
}

boolean green_range(float min, float max, int colour) {
  float  g = green(colour) ;
  return in_range(min, max, g) ;
}

boolean blue_range(float min, float max, int colour) {
  float  b = blue(colour) ;
  return in_range(min, max, b) ;
}

boolean saturation_range(float min, float max, int colour) {
  float  s = saturation(colour) ;
  return in_range(min, max, s) ;
}

boolean brightness_range(float min, float max, int colour) {
  float  b = brightness(colour) ;
  return in_range(min, max, b) ;
}


boolean hue_range(float min, float max, int colour) {
  int c_m = g.colorMode ;
  float c_x = g.colorModeX ;
  float c_y = g.colorModeY ;
  float c_z = g.colorModeZ ;
  float c_a = g.colorModeA ;
  colorMode(HSB, c_x, c_y, c_z, c_a) ;
  float  h = hue(colour) ;

  boolean result = false ;
  // test for the wheel value, hue is one of them ;
  result = in_range_wheel(min, max, c_x, h) ;
  // return to the current colorMode
  colorMode(c_m, c_x, c_y, c_z, c_a) ;
  return result ;
}












/**
convert color 0.0.1
*/
//convert color HSB to RVB
Vec3 HSB_to_RGB(float hue, float saturation, float brightness) {
  Vec4 vecRGB = HSB_to_RGB(hue, saturation, brightness, g.colorModeA).copy() ;
  return Vec3(vecRGB.x,vecRGB.y,vecRGB.z) ;
}

Vec4 HSB_to_RGB(float hue, float saturation, float brightness, float alpha) {
  Vec4 ref = Vec4(g.colorModeX, g.colorModeY, g.colorModeY, g.colorModeA) ;
  color c = color (hue, saturation, brightness, alpha);

  colorMode(RGB,255) ;
  Vec4 vecRGBa = Vec4 (red(c), green(c), blue(c), alpha(c)) ;
  // return to the previous colorMode
  colorMode(HSB,ref.r, ref.g, ref.b, ref.a) ;
  return vecRGBa ;
}



// color context
/*
* good when the text is on different background
*/
int color_context(int colorRef, int threshold, int clear, int dark) {
  int new_color ;
  if( brightness( colorRef ) < threshold ) {
    new_color = clear;
  } else {
    new_color = dark ;
  }
  return new_color ;
}
