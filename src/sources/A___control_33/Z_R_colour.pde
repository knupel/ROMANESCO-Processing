/**
* Rope COLOUR
*v 0.13.1
* Copyleft (c) 2016-2021
* @author @stanlepunk
* @see https://github.com/StanLepunK/Rope_framework
*
* Pack of method to use colour, palette and method conversion
*
*/

import rope.colour.R_Colour;

/**
* palette
* v 0.0.2
*/
R_Colour palette_colour_rope;
void palette(int... list_colour) {
	if(palette_colour_rope == null) {
		palette_colour_rope = new R_Colour(this,list_colour);
	} else {
		palette_colour_rope.clear();
		palette_colour_rope.add(0,list_colour);
	}
}

int [] get_palette() {
	if(palette_colour_rope != null) {
		return palette_colour_rope.get();
	} else return null;
}




/**
GET COLORMODE
v 0.1.1
*/
/**
* getColorMode()
* @return float array of your color environment.
* @param boolean print_info_is retrun a print about the color environment
*/
float [] getColorMode(boolean print_info_is) {
	return getColorMode(g, print_info_is);
}

float [] getColorMode() {
	// see rope.R_Graphic.getColorMode(boolean print_info_is);
	return getColorMode(g, false);
}

float [] getColorMode(PGraphics pg) {
	// see rope.R_Graphic.getColorMode(boolean print_info_is);
	return getColorMode(pg, false);
}

float [] getColorMode(PGraphics pg, boolean print_info_is) {
	// see rope.R_Graphic.getColorMode(boolean print_info_is);
	float colorMode = pg.colorMode ;
	float x = pg.colorModeX;
	float y = pg.colorModeY;
	float z = pg.colorModeZ;
	float a = pg.colorModeA;
	float array[] = {colorMode,x,y,z,a};
	if (print_info_is && pg.colorMode == HSB) {
		println("HSB",x,y,z,a);
	} else if(print_info_is && pg.colorMode == RGB) {
		println("RGB",x,y,z,a);
	}
	return array;
}












/**
camaieu 
v 0.1.2
*/
// return hue or other data in range of specific data float
float camaieu(float max, float reference, float range) {
	float camaieu = 0 ;
	float choice = random(-range,range);
	camaieu = reference + choice;
	if(camaieu < 0 ) camaieu = max +camaieu;
	if(camaieu > max) camaieu = camaieu -max;
	return camaieu;
}






/**
* mixer
* v 0.0.3
* mix color together with the normal threshold variation
*/
int mixer(int src, int dst, float threshold) {
	if(g.colorMode == RGB) {
		float x = gradient_value(red(src),red(dst),threshold);
		float y = gradient_value(green(src),green(dst),threshold);
		float z = gradient_value(blue(src),blue(dst),threshold);
		return color(x,y,z);
	} else {
		float x = gradient_value(hue(src),hue(dst),threshold);
		float y = gradient_value(saturation(src),saturation(dst),threshold);
		float z = gradient_value(brightness(src),brightness(dst),threshold);
		return color(x,y,z);
	}
}

int mixer_xyza(int src, int dst, float threshold) {
	float a = gradient_value(alpha(src),alpha(dst),threshold);
	if(g.colorMode == RGB) {
		float x = gradient_value(red(src),red(dst),threshold);
		float y = gradient_value(green(src),green(dst),threshold);
		float z = gradient_value(blue(src),blue(dst),threshold);
		return color(x,y,z,a);
	} else {
		float x = gradient_value(hue(src),hue(dst),threshold);
		float y = gradient_value(saturation(src),saturation(dst),threshold);
		float z = gradient_value(brightness(src),brightness(dst),threshold);
		return color(x,y,z,a);
	}
}

float gradient_value(float src, float dst, float threshold) {
	float gradient = src;
	float range = src - dst;
	float power = range * threshold;
	return gradient - power;
}








/**
* plot
* v 0.2.0
* set pixel color with alpha and PGraphics management 
*/
boolean use_plot_x2_is = false;
void use_plot_x2(boolean is) {
	use_plot_x2_is = is;
}

void plot(vec2 pos, int colour) {
	plot((int)pos.x(), (int)pos.y(), colour, 1.0, g);
}

void plot(vec2 pos, int colour, PGraphics pg) {
	plot((int)pos.x(), (int)pos.y(), colour, 1.0, pg);
}

void plot(vec2 pos, int colour, float alpha) {
	plot((int)pos.x(), (int)pos.y(), colour, alpha, g);
}

void plot(vec2 pos, int colour, float alpha, PGraphics pg) {
	plot((int)pos.x(), (int)pos.y(), colour, alpha, pg);
}

void plot(int x, int y, int colour) {
	plot(x, y, colour, 1.0, g);
}

void plot(int x, int y, int colour, PGraphics pg) {
	plot(x, y, colour, 1.0, pg);
}

void plot(int x, int y, int colour, float alpha) {
	plot(x, y, colour, alpha, g);
}

void plot(int x, int y, int colour, float alpha, PGraphics pg) {
	int index = index_pixel_array(x, y, pg.width);
	if(index >= 0 && index < pg.pixels.length && x >= 0 && x < pg.width) {
		int bg = pg.pixels[index];
		int col = colour;
		if(alpha < 1) {
			col = mixer(bg,colour,alpha);
		} 
		pg.pixels[index] = col;
		if(use_plot_x2_is) {
			Integer [] arr = new Integer[calc_plot_neighbourhood(index, x, y, pg.width, pg.height).size()];
			arr = calc_plot_neighbourhood(index, x, y, pg.width, pg.height).toArray(arr);
			for(int which_one : arr) {
				pg.pixels[which_one] = col;
			}
		}
	}
}

ArrayList<Integer> calc_plot_neighbourhood(int index_base, int x, int y, int w, int h) {
	ArrayList<Integer> arr = new ArrayList<Integer>();
	int index, tx, ty = 0;

	if(x < w -1) {
		index = index_base + 1;
		arr.add(index);
	}
	if(x > 0) {
		index = index_base - 1;
		arr.add(index);
	}
	if(y < h -1) {
		index = index_base + w;
		arr.add(index);
	}
	if(y > 0) {
		index = index_base - w;
		arr.add(index);
	}
	return arr;
}














/**
* simple color pool
* v 0.1.2
*/
int [] hue_palette(int master_colour, int num_group, int num_colour, float spectrum) {
	if(num_group > num_colour) num_group = num_colour;
	float div = 1.0 / num_group;
	float hue_range = spectrum*div; 
	float hue_key = hue(master_colour);
	vec2 range_sat = vec2(saturation(master_colour));
	vec2 range_bri = vec2(brightness(master_colour));
	vec2 range_alp = vec2(100.0);
	return color_pool(num_colour, num_group, hue_key,hue_range, range_sat,range_bri,range_alp);
}

/**
color pool 
v 0.5.2
*/
int [] color_pool(int num) {
	float hue_range = -1;
	int num_group = 1;
	float key_hue = -1;
	return color_pool(num,num_group, key_hue, hue_range,null,null,null) ;
}

int [] color_pool(int num, float key_hue, float hue_range) {
	int num_group = 1;
	return color_pool(num,num_group, key_hue, hue_range,null,null,null) ;
}

int [] color_pool(int num, int num_group, float key_hue, float hue_range) {
	return color_pool(num,num_group,  key_hue, hue_range,null,null,null);
}

int [] color_pool(int num, int num_group, float key_hue, float hue_range, vec2 sat_range, vec2 bright_range) {
	return color_pool(num,num_group,  key_hue, hue_range,sat_range,bright_range,null);
}

int [] color_pool(int num, int colour, float hue_range, float sat_range, float bri_range) {
	return color_pool(1, num, colour, hue_range,sat_range,bri_range);
}

int [] color_pool(int num, int num_group, int colour, float hue_range, float sat_range, float bri_range) {
	int ref = g.colorMode;
	float x = g.colorModeX;
	float y = g.colorModeY;
	float z = g.colorModeZ;
	float a = g.colorModeA;
	colorMode(HSB,360,100,100,100);

	float h = hue(colour);
	float s = saturation(colour);
	float s_min = s - sat_range;
	if(s_min < 0) s_min = 0;
	if(s_min > g.colorModeY) s_min = g.colorModeY;
	float s_max = s + sat_range;
	if(s_max < 0) s_max = 0;
	if(s_max > g.colorModeY) s_max = g.colorModeY;

	float b = brightness(colour);
	float b_min = b - bri_range;
	if(b_min < 0) b_min = 0;
	if(b_min > g.colorModeZ) b_min = g.colorModeZ;
	float b_max = b + bri_range;
	if(b_max < 0) b_max = 0;
	if(b_max > g.colorModeZ) b_max = g.colorModeZ;

	colorMode(ref,x,y,z,a);
	return color_pool(num,num_group, h, hue_range,vec2(s_min,s_max),vec2(b_min,b_max),null);
}

// color pool by group
int [] color_pool(int num, int num_group, float key_hue, float hue_range, vec2 sat_range, vec2 bright_range, vec2 alpha_range) {
	int ref = g.colorMode;
	float x = g.colorModeX;
	float y = g.colorModeY;
	float z = g.colorModeZ;
	float a = g.colorModeA;
	float ratio_h = 360.0 / g.colorModeX;
	float ratio_s = 100.0 / g.colorModeY;
	float ratio_b = 100.0 / g.colorModeZ;
	float ratio_a = 100.0 / g.colorModeA;

	// create range if necessary
	if(hue_range < 0) {
		hue_range = g.colorModeX *.5;
	}
	if(sat_range == null) {
		sat_range = vec2(g.colorModeY);
	}
	if(bright_range == null) {
		bright_range = vec2(g.colorModeZ);
	}
	if(alpha_range == null) {
		alpha_range = vec2(g.colorModeA);
	}

	hue_range *= ratio_h;
	sat_range.mult(ratio_s);
	bright_range.mult(ratio_b);
	alpha_range.mult(ratio_a);
	colorMode(HSB,360,100,100,100);
	

	

	// create ref
	float [] color_ref = new float[num_group];
	if(key_hue >= 0 ) {
		color_ref[0] = key_hue;
	} else {
		color_ref[0] = random(g.colorModeX);
	}
	if(num_group > 1) {
		float step = g.colorModeX / num_group;
		for(int i = 1 ; i < num_group ; i++) {
			color_ref[i] = color_ref[i -1] + step;
			if(color_ref[i] > g.colorModeX) {
				color_ref[i] = color_ref[i] - g.colorModeX;
			}      
		}
	}

	int [] list = new int[num];
	int count = 0;
	int step = num / num_group;
	int next_stop = step;
	for(int i = 0 ; i < list.length ; i++) {
		if(i > next_stop) {
			next_stop += step;
		}
		float saturation = random(sat_range);
		float brightness = random(bright_range);
		float alpha = random(alpha_range);
		float hue = camaieu(g.colorModeX, color_ref[count], hue_range);
		list[i] = color(hue, saturation,brightness, alpha);
		count++;
		if(count >= color_ref.length) count = 0;

	}
	// back to original colorMode
	colorMode(ref,x,y,z,a);
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
convert color 0.3.0
*/
vec3 hsb_to_rgb(float hue, float saturation, float brightness) {
	vec4 ref = vec4(g.colorModeX, g.colorModeY, g.colorModeY, g.colorModeA);
	int c = color(hue,saturation,brightness);

	colorMode(RGB,255) ;
	vec3 rgb = vec3(red(c),green(c),blue(c)) ;
	// return to the previous colorMode
	colorMode(HSB,ref.x,ref.y,ref.z,ref.w) ;
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
		c = (c *(1.0 -k) +k);
		m = (m *(1.0 -k) +k);
		y = (y *(1.0 -k) +k);
		//CMY > RGB
		float red = (1.0 -c) *g.colorModeX;
		float green = (1.0 -m) *g.colorModeY;
		float blue = (1.0 -y) *g.colorModeZ;
		rgb = vec3(red,green,blue);

	} else {
		print_err("method cmyk_to_rgb(): the values c,m,y,k must have value from 0 to 1.\n","yours values is cyan",c,"magenta",m,"yellow",y,"black",k);
	}
	return rgb;
}

boolean colour_normal_range_is(float v) {
	if(v >= 0.0 && v <= 1.0) return true; else return false;
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
