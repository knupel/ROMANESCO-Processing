/**
* Rope COLOUR
*v 0.11.5
* Copyleft (c) 2016-2021
* Stan le Punk > http://stanlepunk.xyz/
* @author @stanlepunk
* @see https://github.com/StanLepunK/Rope_framework
*
* Pack of method to use colour, palette and method conversion
*
*/
/**
* util colour
*/






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
* COLOUR LIST class
* v 0.4.1
* 2017-2019
*/
public class R_Colour implements rope.core.R_Constants, rope.core.R_Constants_Colour {
	ArrayList<Palette> list;
	PApplet pa;
	public R_Colour(PApplet pa) {
		this.list = new ArrayList<Palette>();
		this.pa = pa;
		Palette p = new Palette();
		list.add(p);
	}

	public R_Colour(PApplet pa, int... list_colour) {
		this.list = new ArrayList<Palette>();
		this.pa = pa;
		Palette p = new Palette(list_colour);
		list.add(p);
	}

	public void add(int group, int [] colour) {
		if(group >= 0) {
			if(group >= size_group()) {
				String s = "class R_Colour method add(int group, int [] colour) the group: " + group + " don't exist yet, add group before use this method";
				System.err.println(s);
			} else {
				list.get(group).add(colour);
			}
		}
	}

	public void add(int group, int colour) {
		if(group >= 0) {
			if(group >= size_group()) {
				String s = "class R_Colour method add(int group, int colour): the group " + group + " don't exist yet, add group before use this method";
				System.err.println(s);
			} else {
				list.get(group).add(colour);
			}   
		}
	}

	public void add(int colour) {
		list.get(0).add(colour);
	}

	public void add_group() {
		Palette p = new Palette();
		list.add(p);
	}

	public void add_group(int num) {
		for(int i = 0 ; i < num ; i++) {
			Palette p = new Palette();
			list.add(p);
		}
	}

	public void set(int index, int colour) {
		set(0, index, colour);
	}

	public void set(int group, int index, int colour) {
		if(group >= 0 && group <= size_group() && index >= 0 && index < list.get(group).size()) {
			list.get(group).set(index,colour);
		}
	}



 
	// clear
	public void clear() {
		for(Palette p : list) {
			p.clear();
		}
	}

	public void clear(int group) {
		if(group >= 0 && group < size_group()) {
			list.get(group).clear();
		} else {
			printErr("class R_Colour method clear(",group,") this group don't match with any group");
		}
	}


	public void remove(int group, int index) {
		if(group >= 0 && group < size_group()) {
			list.get(group).remove(index);
		} else {
			printErr("class R_Colour method remove(",group,") this group don't match with any group");
		}
	}
	

	// GET
	// get size
	public int size_group() {
		return list.size();
	}

	public int size() {
		return size(0);
	}

	public int size(int group) {
		if(group >= 0 && group < size_group()) {
			return list.get(group).size();
		} else {
			String s = "class R_Colour method size(int group) the group: " + group + " don't exist yet, add group before use this method, instead '-1' is return";
			System.err.println(s);
			return -1;
		}
	}
	
	// get content
	public int [] get() {
		return get(0);
	}

	public int [] get(int group) {
		if(group >= 0 && group < size_group()) {
			return list.get(group).array(); 
		} else {
			String s = "class R_Colour method get(int group) the group: " + group + " don't exist yet, add group before use this method";
			System.err.println(s);
			return null;
		}
	}


	// get colour
	int rand() {
		int group = floor(random(size_group()));
		int target = floor(random(list.get(group).array().length));
		return get_colour(group,target);
	}

	int rand(int group) {
		int target = 0;
		if(group < list.size()) {
			target = floor(random(list.get(group).array().length));
		} else {
			group = 0;
			target = floor(random(list.get(group).array().length));
		}
		return get_colour(group,target);
	}


	public int get_colour(int group, int target) {
		if(target >= 0 && group >= 0 && group < size_group() && target < list.get(group).array().length) {
			return list.get(group).array()[target];
		} else {
			System.err.println("class R_Colour method get_colour() no target match with your demand, instead '0' is return");
			return 0;
		}
	}


	public float get_hue(int group, int target) {
		if(group >= 0 && group < size_group()) {
			return pa.hue(list.get(group).get(target));
		} else {
			printErr("class R_Color method get_hue(",group,") no group match with your demand, instead '0' is return");
			return 0;
		}
	}


	public float get_saturation(int group, int target) {
		if(group >= 0 && group < size_group()) {
			return pa.saturation(list.get(group).get(target));
		} else {
			printErr("class R_Color method get_saturation(",group,") no group match with your demand, instead '0' is return");
			return 0;
		}
	}
	

	public float get_brightness(int group, int target) {
		if(group >= 0 && group < size_group()) {
			return pa.brightness(list.get(group).get(target));
		} else {
			printErr("class R_Color method get_brightness(",group,") no group match with your demand, instead '0' is return");
			return 0;
		}
	}

	public float get_red(int group, int target) {
		if(group >= 0 && group < size_group()) {
			return pa.red(list.get(group).get(target));
		} else {
			printErr("class R_Color method get_red(",group,") no group match with your demand, instead '0' is return");
			return 0;
		}
	}
	

	public float get_green(int group, int target) {
		if(group >= 0 && group < size_group()) {
			return pa.green(list.get(group).get(target));
		} else {
			printErr("class R_Color method get_green(",group,") no group match with your demand, instead '0' is return");
			return 0;
		}
	}

	public float get_blue(int group, int target) {
		if(group >= 0 && group < size_group()) {
		 return pa.blue(list.get(group).get(target));
		} else {
			printErr("class R_Color method get_blue(",group,") no group match with your demand, instead '0' is return");
			return 0;
		}
	}


	public float get_alpha(int group, int target) {
		if(group >= 0 && group < size_group()) {
			return pa.alpha(list.get(group).get(target));
		} else {
			printErr("class R_Color method get_alpha(",group,") no group match with your demand, instead '0' is return");
			return 0;
		}
	}


	public vec3 get_hsb(int group, int target) {
		if(group >= 0 && group < size_group()) {
			int c = list.get(group).get(target);
			return vec3(pa.hue(c),pa.saturation(c),pa.brightness(c));
		} else {
			printErr("class R_Color method get_hsb(",group,") no group match with your demand, instead 'null' is return");
			return null;
		}
	}


	public vec4 get_hsba(int group, int target) {
		if(group >= 0 && group < size_group()) {
			int c = list.get(group).get(target);
			return vec4(pa.hue(c),pa.saturation(c),pa.brightness(c),pa.alpha(c));
		} else {
			printErr("class R_Color method get_hsba(",group,") no group match with your demand, instead 'null' is return");
			return null;
		}
	}


	public vec3 get_rgb(int group, int target) {
		if(group >= 0 && group < size_group()) {
			int c = list.get(group).get(target);
			return vec3(pa.red(c),pa.green(c),pa.blue(c));
		} else {
			printErr("class R_Color method get_rgb(",group,") no group match with your demand, instead 'null' is return");
			return null;
		}
	}
	

	public vec4 get_rgba(int group, int target) {
		if(group >= 0 && group < size_group()) {
			int c = list.get(group).get(target);
			return vec4(pa.red(c),pa.green(c),pa.blue(c),pa.alpha(c));
		} else {
			printErr("class R_Color method get_rgba(",group,") no group match with your demand, instead 'null' is return");
			return null;
		}
	}
	

	public float [] hue() {
		return hue(0);
	}

	public float [] hue(int group) {
		if(group >= 0 && group < size_group()) {
			float[] component = new float[list.get(group).size()];
			for(int i = 0 ; i < component.length ; i++) {
				int c = list.get(group).get(i);
				component[i] = pa.hue(c);
			}
			return component;
		} else {
			printErr("class R_Color method hue(",group,") no group match with your demand, instead 'null' is return");
			return null; 
		}
	}


	
	public float [] saturation() {
		return saturation(0);
	}

	public float [] saturation(int group) {
		if(group >= 0 && group < size_group()) {
			float[] component = new float[list.get(group).size()];
			for(int i = 0 ; i < component.length ; i++) {
				int c = list.get(group).get(i);
				component[i] = pa.saturation(c);
			}
			return component;
		} else {
			printErr("class R_Color method saturation(",group,") no group match with your demand, instead 'null' is return");
			return null; 
		}
	}



	public float [] brightness() {
		return brightness(0);
	}
	
	public float [] brightness(int group) {
		if(group >= 0 && group < size_group()) {
			float[] component = new float[list.get(group).size()];
			for(int i = 0 ; i < component.length ; i++) {
				int c = list.get(group).get(i);
				component[i] = pa.brightness(c);
			}
			return component;
		} else {
			printErr("class R_Color method brightness(",group,") no group match with your demand, instead 'null' is return");
			return null; 
		}
	}


	public float [] red() {
		return red(0);
	}

	public float [] red(int group) {
		if(group >= 0 && group < size_group()) {
			float[] component = new float[list.get(group).size()];
			for(int i = 0 ; i < component.length ; i++) {
				int c = list.get(group).get(i);
				component[i] = pa.red(c);
			}
			return component;
		} else {
			printErr("class R_Color method red(",group,") no group match with your demand, instead 'null' is return");
			return null; 
		}
	}

	
	public float [] green() {
		return green(0);
	}

	public float [] green(int group) {
		if(group >= 0 && group < size_group()) {
			float[] component = new float[list.get(group).size()];
			for(int i = 0 ; i < component.length ; i++) {
				int c = list.get(group).get(i);
				component[i] = pa.green(c);
			}
			return component;
		} else {
			printErr("class R_Color method green(",group,") no group match with your demand, instead 'null' is return");
			return null; 
		}
	}


	public float [] blue() {
		return blue(0);
	}
	
	public float [] blue(int group) {
		if(group >= 0 && group < size_group()) {
			float[] component = new float[list.get(group).size()];
			for(int i = 0 ; i < component.length ; i++) {
				int c = list.get(group).get(i);
				component[i] = pa.blue(c);
			}
			return component;
		} else {
			printErr("class R_Color method blue(",group,") no group match with your demand, instead 'null' is return");
			return null;
		}
	}


	public float [] alpha() {
		return alpha(0);
	}

	public float [] alpha(int group) {
		if(group >= 0 && group < size_group()) {
			float[] component = new float[list.get(0).size()];
			for(int i = 0 ; i < component.length ; i++) {
				int c = list.get(group).get(i);
				component[i] = pa.blue(c);
			}
			return component;
		} else {
			printErr("class R_Color method alpha(",group,") no group match with your demand, instead 'null' is return");
			return null;
		}
	}

	

	public vec3 [] hsb() {
		return hsb(0);
	}

	public vec3 [] hsb(int group) {
		if(group >= 0 && group < size_group()) {
			vec3[] component = new vec3[list.get(group).size()];
			for(int i = 0 ; i < component.length ; i++) {
				int c = list.get(group).get(i);
				component[i] = vec3(pa.hue(c),pa.saturation(c),pa.brightness(c));
			}
			return component;
		} else {
			printErr("class R_Color method hsb(",group,") no group match with your demand, instead 'null' is return");
			return null;
		}
	}


	public vec3 [] rgb() {
		return rgb(0);
	}

	public vec3 [] rgb(int group) {
		if(group >= 0 && group < size_group()) {
			vec3[] component = new vec3[list.get(group).size()];
			for(int i = 0 ; i < component.length ; i++) {
				int c = list.get(group).get(i);
				component[i] = vec3(pa.red(c),pa.green(c),pa.blue(c));
			}
			return component;
		} else {
			printErr("class R_Color method rgb(",group,") no group match with your demand, instead 'null' is return");
			return null;
		}
	}


	public vec4 [] hsba() {
		return hsba(0);
	}

	public vec4 [] hsba(int group) {
		if(group >= 0 && group < size_group()) {
			vec4[] component = new vec4[list.get(0).size()];
			for(int i = 0 ; i < component.length ; i++) {
				int c = list.get(0).get(i);
				component[i] = vec4(pa.hue(c),pa.saturation(c),pa.brightness(c),pa.alpha(c));
			}
			return component;
		} else {
			printErr("class R_Color method hsba(",group,") no group match with your demand, instead 'null' is return");
			return null;
		}
	}


	public vec4 [] rgba() {
		return rgba(0);
	}

	public vec4 [] rgba(int group) {
		if(group >= 0 && group < size_group()) {
			vec4[] component = new vec4[list.get(group).size()];
			for(int i = 0 ; i < component.length ; i++) {
				int c = list.get(group).get(i);
				component[i] = vec4(pa.red(c),pa.green(c),pa.blue(c),pa.alpha(c));
			}
			return component;
		} else {
			printErr("class R_Color method rgba(",group,") no group match with your demand, instead 'null' is return");
			return null;
		}
	}


	


	/**
	* Palette
	* v 0.2.1
	* 2019-2019
	*/
	private class Palette {
		private ArrayList<Integer> list;
		private Palette() {
			list = new ArrayList<Integer>();
		}

		private Palette(int... colour) {
			list = new ArrayList<Integer>();
			add(colour);
		}

		private void add(int... colour) {
			for(int i = 0 ; i < colour.length ; i++) {
				list.add(colour[i]);
			}
		}

		private void set(int index, int colour) {
			if(index >= 0 && index < list.size()) {
				list.set(index,colour);
			}
		}

		private void clear() {
			list.clear();
		}

		private void remove(int target) {
			if(target >=0 && target < list.size()) {
				list.remove(target);
			}
		}

		private int size() {
			return list.size();
		}

		private int get(int target) {
			if(target >= 0 && target < list.size()) {
				return list.get(target);
			} else {
				printErr("class R_Colour > private class Palette > method get(",target,") don't match with any element of list instead '0 is return");
				return 0;
			}

		}

		private int [] array() {
			// May be in the next Processing version when Lambda expression can be use
			// int[] array = list.stream().mapToInt(i->i).toArray(); 
			int[] array = new int[list.size()];
			for(int i = 0 ; i < array.length ; i++) {
				array[i] = list.get(i);
			}
			return array;
		}
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
	// see rope.R_Graphic.getColorMode(boolean print_info_is);
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
	// see rope.R_Graphic.getColorMode(boolean print_info_is);
	return getColorMode(false);
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
* v 0.0.1
* mix color together with the normal threshold variation
*/
int mixer(int o, int d, float threshold) {
	if(g.colorMode == 1) {
		float x = gradient_value(red(o),red(d),threshold);
		float y = gradient_value(green(o),green(d),threshold);
		float z = gradient_value(blue(o),blue(d),threshold);
		return color(x,y,z);
	} else {
		float x = gradient_value(hue(o),hue(d),threshold);
		float y = gradient_value(saturation(o),saturation(d),threshold);
		float z = gradient_value(brightness(o),brightness(d),threshold);
		return color(x,y,z);
	}
}

float gradient_value(float origin, float destination, float threshold) {
	float gradient = origin;
	float range = origin - destination;
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
		printErr("method cmyk_to_rgb(): the values c,m,y,k must have value from 0 to 1.\n","yours values is cyan",c,"magenta",m,"yellow",y,"black",k);
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
