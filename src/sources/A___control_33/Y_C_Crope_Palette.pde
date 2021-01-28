/**
* PALETTE
* color picker
* v 0.0.1
* 2020-2020
*/


/**
*
* 
* DON'T WORK IN PROGRESS
*
*
*/

// public class Palette extends Crope {
// 	private vec2 target_pos;
	
// 	int newColor;
// 	int colorWrite;


	
// 	public Palette(vec2 pos, vec2 size) {
// 		super("Palette");
// 		this.pos(pos); 
// 		this.size(size);
// 		this.target_pos = vec2(size.x() * 0.5 + pos.x(), size.y() * 0.5 + pos.y());
		
// 	}

// 	/**
// 	* show palette and set the picker size
// 	*/
// 	public void show(float hue) {
// 		show(hue,40);
// 	}
	
// 	public void show(float hue, int radius) {
// 		int px = round(this.pos.x());
// 		int py = round(this.pos.y());
// 		int sx = round(this.size.x());
// 		int sy = round(this.size.y());

// 		float step_x = 1.0 / this.size.x();
// 		float step_y = 1.0 / this.size.y();
// 		println(step_x,step_y);
// 		int ref_colorMode = g.colorMode;
// 		vec4 ref_colorMode_xyza = vec4(g.colorModeX,g.colorModeY,g.colorModeZ,g.colorModeA);

// 	 	colorMode(HSB,1);

// 		for (float x = 0 ; x < 1.0 ; x += step_x) {
// 			for (float y = 0 ; y < 1.0 ; y += step_y) {
// 				int c = color(hue, x ,y);
// 				set(int(x * size.x() + px), int(y * size.y() + py), c);
// 			}
// 		}	
// 		colorMode(ref_colorMode,ref_colorMode_xyza);
// 		picker(radius);
// 	}
	
	
// 	// Pipette
// 	private void picker(int radius) {
// 		picker_is(); // look if the pipette are in the area or not
// 		newColor = get_color(); // give the value of new color selected by pipette
		
// 		strokeWeight(1) ;
// 		stroke(color_ring(newColor));
// 		fill(newColor);
// 		ellipseMode(CENTER);
// 		ellipse(target_pos.x(), target_pos.y(), radius, radius);
// 	}
	
// 	private void picker_is() {
// 		if(		mouseX < this.size.x() + this.pos.x() && mouseX > this.pos.x() 
// 			&& 	mouseY < this.size.y() + this.pos.y() && mouseY > this.pos.y() 
// 			&&	mousePressed) {
// 					this.target_pos.x(mouseX);
// 					this.target_pos.y(mouseY);
// 		}
// 	}
	
// 	private int color_ring(int color_arg) {
// 		if(brightness(color_arg) < 170) {
// 			return color(185);
// 		} else {
// 			return color(10);
// 		}
// 	}

// 	public int get_color() {
// 		return get(round(target_pos.x()), round(target_pos.y()));
// 	}

// }



// /**
// * PALETTE SELECTOR
// */
// public class Palette_Selector extends Crope {
// 	boolean inside;
// 	boolean locked;
// 	boolean validate;
// 	int current_color;
	

// 	public Palette_Selector(vec2 pos, vec2 size) {
// 		super("Palette Selector");
// 		this.pos(pos);
// 		this.size(size);
// 		current_color = color(g.colorModeX * 0.5, g.colorModeY * 0.5, g.colorModeZ * 0.5);
// 	}

// 	public void validate() {
// 		if (mouseX < this.size.x() + this.pos.x() && mouseX > this.pos.x()
// 				&& mouseY < this.size.y() + this.pos.y() && mouseY > this.pos.y()) {
// 			this.inside = true;
// 			fill(this.fill_in);
// 			stroke(this.stroke_in);
// 		} else {
// 			this.inside = false;
// 			fill(this.fill_out);
// 			stroke(this.stroke_in);
// 		}
// 		strokeWeight(this.thickness);


// 		if(mousePressed && this.inside) {
// 			this.locked = true ;
// 		}
// 		if(!mousePressed){ 
// 			this.locked = false;
// 		}
		
// 		if(this.locked) {
// 			this.current_color = this.new_color;
// 		}
		
// 		rect(this.pos, this.size);
// 		text(this.name, this.pos.x() +5, this.pos.y() +5 +(this.size.y() /2.0));
// 	}

// 	public void box_current_color() {
// 		strokeWeight(this.thickness);
// 		stroke(this.stroke_in);
// 		fill(this.current_color);
// 		rect(this.pos, this.size);
		
// 		fill(this.current_color) ;
// 		String hex_color = hex(this.current_color);
// 		// println(hex_color);
// 		text(hex_color , pos.x() +5 , pos.y() +5 +(size.y() /2.0));
// 	}

// 	public void box_new_color() {
// 		strokeWeight(this.thickness);
// 		stroke(this.stroke_in);
// 		fill(this.new_color);
// 		rect(this.pos, this.size);
		
// 		fill(this.new_color);
// 		String hex_color = hex(this.new_color);
// 		// println(hex_color) ;
// 		text(hex_color , this.pos.x() +5 , this.pos.y() +5 +(this.size.y() /2.0));
// 	}

// 	public void set_color_picker(int new_color) {
// 		this.new_color = new_color;

// 	}

// }

