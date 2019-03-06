/**
Rope COLOUR
v 0.7.0
* Copyleft (c) 2016-2019 
* Stan le Punk > http://stanlepunk.xyz/
Rope – Romanesco Processing Environment – 
Processing 3.4
* @author @stanlepunk
* @see https://github.com/StanLepunK/Rope_framework
*
* Pack of method to use colour, palette and method conversion
*
*/







/**
COLOUR LIST class
v 0.0.2
*/
/**
* Idea for the future add a list name for colour

* get the colour by index or name
*/
public class ROPE_colour implements rope.core.RConstants {
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
// color pool vec4 RGB
vec4 [] color_pool_RGB(int num) {
  vec2 sat_range = vec2(g.colorModeY) ;
  vec2 bright_range = vec2(g.colorModeZ) ;
  vec2 alpha_range = vec2(g.colorModeA) ;
  float range = g.colorModeX *.5 ;
  int num_group = 1 ;
  float key_hue = -1 ;
  return color_pool_RGB(num, num_group, key_hue, range, sat_range, bright_range, alpha_range) ;
}

vec4 [] color_pool_RGB(int num, float key_hue) {
  vec2 sat_range = vec2(g.colorModeY) ;
  vec2 bright_range = vec2(g.colorModeZ) ;
  vec2 alpha_range = vec2(g.colorModeA) ;
  float range = g.colorModeX *.5 ;
  int num_group = 1 ;
  return color_pool_RGB(num, num_group, key_hue, range, sat_range, bright_range, alpha_range) ;
}


vec4 [] color_pool_RGB(int num, int num_group, float hue_range) {
  vec2 sat_range = vec2(g.colorModeY) ;
  vec2 bright_range = vec2(g.colorModeZ) ;
  vec2 alpha_range = vec2(g.colorModeA) ;
  float key_hue = -1 ;
  return color_pool_RGB(num, num_group, key_hue, hue_range, sat_range, bright_range, alpha_range) ;
}


vec4 [] color_pool_RGB(int num, int num_group, float key_hue, float hue_range) {
  vec2 sat_range = vec2(g.colorModeY) ;
  vec2 bright_range = vec2(g.colorModeZ) ;
  vec2 alpha_range = vec2(g.colorModeA) ;
  return color_pool_RGB(num, num_group, key_hue, hue_range, sat_range, bright_range, alpha_range) ;
}

vec4 [] color_pool_RGB(int num, int num_group, float hue_range, vec2 sat_range, vec2 bright_range, vec2 alpha_range) {
  float key_hue = -1 ;
  return color_pool_RGB(num, num_group, key_hue, hue_range, sat_range, bright_range, alpha_range) ;
}


vec4 [] color_pool_RGB(int num, int num_group, float key_hue, float hue_range, vec2 sat_range, vec2 bright_range, vec2 alpha_range) {
  vec4 [] list = new vec4[num]  ;
  int [] c = color_pool(num, num_group, key_hue, hue_range, sat_range, bright_range, alpha_range) ;
  for(int i = 0 ; i <list.length ; i++) {
    list[i] = new vec4(red(c[i]),green(c[i]),blue(c[i]),alpha(c[i])) ;
  }
  return list ;
}

// color pool vec4 HSB
vec4 [] color_pool_HSB(int num) {
  vec2 sat_range = vec2(g.colorModeY) ;
  vec2 bright_range = vec2(g.colorModeZ) ;
  vec2 alpha_range = vec2(g.colorModeA) ;
  float range = g.colorModeX *.5 ;
  int num_group = 1 ;
  float key_hue = -1 ;
  return color_pool_HSB(num, num_group, key_hue, range, sat_range, bright_range, alpha_range) ;
}

vec4 [] color_pool_HSB(int num, float key_hue) {
  vec2 sat_range = vec2(g.colorModeY) ;
  vec2 bright_range = vec2(g.colorModeZ) ;
  vec2 alpha_range = vec2(g.colorModeA) ;
  float range = g.colorModeX *.5 ;
  int num_group = 1 ;
  return color_pool_HSB(num, num_group, key_hue, range, sat_range, bright_range, alpha_range) ;
}


vec4 [] color_pool_HSB(int num, int num_group, float hue_range) {
  vec2 sat_range = vec2(g.colorModeY) ;
  vec2 bright_range = vec2(g.colorModeZ) ;
  vec2 alpha_range = vec2(g.colorModeA) ;
  float key_hue = -1 ;
  return color_pool_HSB(num, num_group, key_hue, hue_range, sat_range, bright_range, alpha_range) ;
}


vec4 [] color_pool_HSB(int num, int num_group, float key_hue, float hue_range) {
  vec2 sat_range = vec2(g.colorModeY) ;
  vec2 bright_range = vec2(g.colorModeZ) ;
  vec2 alpha_range = vec2(g.colorModeA) ;
  return color_pool_HSB(num, num_group, key_hue, hue_range, sat_range, bright_range, alpha_range) ;
}

vec4 [] color_pool_HSB(int num, int num_group, float hue_range, vec2 sat_range, vec2 bright_range, vec2 alpha_range) {
  float key_hue = -1 ;
  return color_pool_HSB(num, num_group, key_hue, hue_range, sat_range, bright_range, alpha_range) ;
}


vec4 [] color_pool_HSB(int num, int num_group, float key_hue, float hue_range, vec2 sat_range, vec2 bright_range, vec2 alpha_range) {
  vec4 [] list = new vec4[num]  ;
  int [] c = color_pool(num, num_group, key_hue, hue_range, sat_range, bright_range, alpha_range) ;
  for(int i = 0 ; i <list.length ; i++) {
    list[i] = new vec4(hue(c[i]),saturation(c[i]),brightness(c[i]),alpha(c[i])) ;
  }
  return list ;
}

// color pool int
int [] color_pool(int num) {
  vec2 sat_range = vec2(g.colorModeY) ;
  vec2 bright_range = vec2(g.colorModeZ) ;
  vec2 alpha_range = vec2(g.colorModeA) ;
  float range = g.colorModeX *.5 ;
  int num_group = 1 ;
  float key_hue = -1 ;
  return color_pool(num, num_group, key_hue, range, sat_range, bright_range, alpha_range) ;
}

int [] color_pool(int num, float key_hue) {
  vec2 sat_range = vec2(g.colorModeY) ;
  vec2 bright_range = vec2(g.colorModeZ) ;
  vec2 alpha_range = vec2(g.colorModeA) ;
  float range = g.colorModeX *.5 ;
  int num_group = 1 ;
  return color_pool(num, num_group, key_hue, range, sat_range, bright_range, alpha_range) ;
}

int [] color_pool(int num, int num_group, float hue_range) {
  vec2 sat_range = vec2(g.colorModeY) ;
  vec2 bright_range = vec2(g.colorModeZ) ;
  vec2 alpha_range = vec2(g.colorModeA) ;
  float key_hue = -1 ;
  return color_pool(num, num_group, key_hue, hue_range, sat_range, bright_range, alpha_range) ;
}

int [] color_pool(int num, int num_group, float key_hue, float hue_range) {
  vec2 sat_range = vec2(g.colorModeY) ;
  vec2 bright_range = vec2(g.colorModeZ) ;
  vec2 alpha_range = vec2(g.colorModeA) ;
  return color_pool(num, num_group, key_hue, hue_range, sat_range, bright_range, alpha_range) ;
}

int [] color_pool(int num, int num_group, float hue_range, vec2 sat_range, vec2 bright_range, vec2 alpha_range) {
  float key_hue = -1 ;
  return color_pool(num, num_group, key_hue, hue_range, sat_range, bright_range, alpha_range) ;

}

// color pool by group
int [] color_pool(int num, int num_group, float key_hue, float hue_range, vec2 sat_range, vec2 bright_range, vec2 alpha_range) {
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
convert color 0.2.0
*/
vec3 hsb_to_rgb(float hue, float saturation, float brightness) {
  vec4 ref = vec4(g.colorModeX, g.colorModeY, g.colorModeY, g.colorModeA);
  int c = color(hue,saturation,brightness);

  colorMode(RGB,255) ;
  vec3 rgb = vec3(red(c),green(c),blue(c)) ;
  // return to the previous colorMode
  colorMode(HSB,ref.r, ref.g, ref.b, ref.a) ;
  return rgb;
}

vec4 to_cmyk(int c) {
  return rgb_to_cmyk(red(c),green(c),blue(c));
}


vec3 to_rgb(int c) {
  return vec3(red(c),green(c),blue(c));
}

vec4 to_rgba(int c) {
  return vec4(red(c),green(c),blue(c),alpha(c));
}

vec3 to_hsb(int c) {
  return vec3(hue(c),saturation(c),brightness(c));
}

vec4 to_hsba(int c) {
  return vec4(hue(c),saturation(c),brightness(c),alpha(c));
}





vec4 rgb_to_cmyk(float r, float g, float b) {
  // convert to 0 > 1 value
  r = r/this.g.colorModeX;
  g = g/this.g.colorModeY;
  b = b/this.g.colorModeZ;
  // RGB to CMY
  float c = 1.-r;
  float m = 1.-g;
  float y = 1.-b;
  // CMY to CMYK
  float var_k = 1;
  if (c < var_k) var_k = c;
  if (m < var_k) var_k = m;
  if (y < var_k) var_k = y;
  // black only
  if (var_k == 1) { 
    c = 0;
    m = 0;
    y = 0;
  } else {
    c = (c-var_k)/(1-var_k);
    m = (m-var_k)/(1-var_k);
    y = (y-var_k)/(1-var_k);
  }
  float k = var_k; 
  return vec4(c,m,y,k);
}







vec3 cmyk_to_rgb(float c, float m, float y, float k) {
  vec3 rgb = null;
   // cmyk value must be from 0 to 1
  if(colour_normal_range_is(c) && colour_normal_range_is(m) && colour_normal_range_is(y) && colour_normal_range_is(k)) {
    // CMYK > CMY
    c = (c *(1.-k)+k);
    m = (m *(1.-k)+k);
    y = (y *(1.-k)+k);
    //CMY > RGB
    float red = (1.- c) * g.colorModeX;
    float green = (1.- m) * g.colorModeY;
    float blue = (1.- y) * g.colorModeZ;
    rgb = vec3(red,green,blue);

  } else {
    printErr("method cmyk_to_rgb(): the values c,m,y,k must have value from 0 to 1.\n","yours values is cyan",c,"magenta",m,"yellow",y,"black",k);
  }
  return rgb;
  
}

boolean colour_normal_range_is(float v) {
  if(v >= 0. && v <= 1.) return true; else return false;
}










// color context
/*
* good when the text is on different background
*/
int color_context(int color_ref, int threshold, int clear, int dark) {
  int new_color ;
  if(brightness(color_ref) < threshold ) {
    new_color = clear;
  } else {
    new_color = dark ;
  }
  return new_color ;
}












