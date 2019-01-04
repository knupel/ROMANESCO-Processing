/**
ROPE - Romanesco processing environment – 
* Copyleft (c) 2014-2018
* Stan le Punk
* https://github.com/StanLepunK
* http://stanlepunk.xyz/
*/
PImage img;
void setup() {
	colorMode(HSB,360,100,100,100);
	size(300,300);
	img = loadImage("jpg file/small_dame_hermine.jpg");
	surface.setSize(img.width,img.height);
	background(0);
	

}



void draw() {
	hermine();
}

void mousePressed() {
	background(random(g.colorModeX),g.colorModeY,g.colorModeZ);
	max_pix = (int)random(50,1000);
}

int max_pix = 100;
void hermine() {
	for(int i = 0 ; i < max_pix ; i++) {
		int x = round(random(width));
		int y = round(random(height));
		int c = img.get(x,y);
	
		pushMatrix();
		translate(x,y);
		pixel_cmyk(to_cmyk(c),10);
		popMatrix();
	}
}





void pixel_cmyk(Vec4 c, float size) {
	float step_angle = TAU * 0.25;
	int color_arg[] = { r.CYAN,r.MAGENTA,r.YELLOW,r.BLACK };
	float angle =0;
	for(int i = 0 ; i < 4 ; i++) {
		angle += step_angle;
		float x = cos(angle);
		float y = sin(angle);
		strokeWeight(c.get_array()[i]*(size*.25));
		stroke(color_arg[i]);
		point(x,y);
		
	}
}














