/**
Movisco || 2016 || 0.0.2
*/

class Movisco extends Romanesco {
	public Movisco() {
		RPE_name = "Movisco" ;
		ID_item = 25 ;
		ID_group = 1 ;
		RPE_author  = "Stan le Punk";
		RPE_version = "Version 0.0.2";
		RPE_pack = "Base" ;
		RPE_mode = "" ; // separate the differentes mode by "/"
		RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Stroke hue,Stroke sat,Stroke bright,Stroke alpha,Thickness,Influence,Canvas X,Canvas Y,Quality,Canvas X,Speed X,Size X" ;
	}

	int rows, cols ;
	int num_pixel ;
	int step_grid = 10;
	int step_grid_analyze = 10 ;
	int correction_pos_y = 0 ;
	// create variable to carch in HSB or RGB mode
	Vec3 color_pixel_HSB[];
	Vec3 color_pixel_RGB[];

	int pix_step ;

	// setup
	void setup() {
    setting_start_position(ID_item, 0, 0, 0) ;
    load_movie(ID_item) ;

		pix_step = 50 ;
		if(movieImport[ID_item] != null) {
			set_grid_movie(pix_step, ID_item) ;
			full_window_movie(ID_item) ;
			center_movie_in_the_height(ID_item) ;
		}

	}

	// draw
	void draw() {
		if(!FULL_RENDERING) {
			canvas_movisco(movieImport[ID_item].width -pix_step , movieImport[ID_item].height -(pix_step/2)) ;
		} else {
			if(movieImport[ID_item] != null) {
				analyze_movie_pixel(ID_item) ;
				int size_cloud_pix = int(pix_step *2) ;
				float comp_1 = 1 ; // red or hue
				float comp_2 = 1 ; // green or saturation
				float comp_3 = 1 ;  // blue or brightnes
				float comp_4 = .9 ; // alpha
				float comp_5 = .9 ; // pixel density in case or the pixel are particle system
				Vec5 density = Vec5(comp_1,comp_2,comp_3,comp_4,comp_5) ; // Vec5(red,green,blue,alpha, pixel density) value factor between 0 and 1

				float size_pix = 1 ;
				String pattern = "4_RANDOM" ;
				float depth = 0 ;
				display_movie_cloud(size_pix, size_cloud_pix, pattern, density, depth) ;
			}
		}
	}
   

   void canvas_movisco(int x, int y) {
   	strokeWeight(1) ;
   	stroke(0) ;
   	fill(0, g.colorModeA *.1) ;
		rect(0, 0, x, y) ;
	}
	// Annexe method
	void set_grid_movie(int pix_step, int ID_item) {
		step_grid = pix_step ;
		step_grid_analyze = pix_step ;
		rows = movieImport[ID_item].width / step_grid;
		cols = movieImport[ID_item].height / step_grid;
		num_pixel = rows *cols ;
		if(g.colorMode == 3 )  color_pixel_HSB = new Vec3[num_pixel]; 
		else color_pixel_RGB = new Vec3[num_pixel];
		for(int i = 0 ; i < num_pixel ; i++) {
			if(g.colorMode == 3 ) color_pixel_HSB[i] = Vec3(0) ; else color_pixel_RGB[i] = Vec3(0) ;
		}
	}








	// DRAW
	//////////////////
	void analyze_movie_pixel(int ID_item) {
	  if (movieImport[ID_item].available()) {
	  movieImport[ID_item].read();
	    movieImport[ID_item].loadPixels();
	    int count = 0;
	    for (int i = 0; i < cols; i++) {
	      for (int j = 0; j < rows; j++) {
	        int color_temp = movieImport[ID_item].get(j *step_grid_analyze, i *step_grid_analyze) ;
	        if(g.colorMode == 3 ) color_pixel_HSB[count] = Vec3 (hue(color_temp), saturation(color_temp), brightness(color_temp)) ;
	        else color_pixel_RGB[count] = Vec3 (red(color_temp), green(color_temp), blue(color_temp)) ;
	        count++;
	      }
	    }
	  }
	}









	/**
	display the pixel
	*/
	void display_movie_cloud(float size_pix, int size_pix_cloud, String pattern, Vec5 density_cloud, float ratio_depth) {
	  // setting color because the color pix can be diffenrent for the RGB or the HSB
	  /* catch the value of the alpha, because this one is not a component of the video, but from the colorMode.
	  And we don't know this one in advance */
	  float value_alpha_max = g.colorModeA ;
	  Vec3 [] color_temp = new Vec3[num_pixel] ;
	        
	  if(g.colorMode == 1 ) for (int i = 0 ; i < color_pixel_RGB.length ;i++) color_temp[i] = color_pixel_RGB[i].copy() ;
	  else for (int i = 0 ; i < color_pixel_HSB.length ;i++) color_temp[i] = color_pixel_HSB[i].copy() ;
	  
	  for (int i = 0; i < cols; i++) {
	    for (int j = 0; j < rows; j++) {
	      int which_point = i *rows +j ;
	      float r = color_temp[which_point].r *density_cloud.a ;
	      float gr = color_temp[which_point].g *density_cloud.b;
	      float b = color_temp[which_point].b *density_cloud.c;
	      float a =  value_alpha_max *density_cloud.d ;


	      // note the order of i and j is different between camera and movie
	      int x = j *step_grid ;
	      int y = i *step_grid +correction_pos_y ;
	      float bright = 0 ;
	      if(g.colorMode == 3 ) bright = color_pixel_HSB[which_point].b ; 
	      else bright = brightness(color(color_pixel_RGB[which_point].r,color_pixel_RGB[which_point].g,color_pixel_RGB[which_point].b)) ;
	      float z = map(bright,0, g.colorModeA ,0,1) ;
	      Vec3 pos = Vec3(x,y,z) ;

	      z *= ratio_depth ;
	      int num = (int)(color_temp[i *rows + j].b *density_cloud.e) ;

	      //display
	      fill(r, gr, b, a);
	      stroke(r, gr, b, a);
	      strokeWeight(size_pix) ;
	      pixel_cloud(pos, num, size_pix_cloud, pattern);
	    }
	  }
	}




	// local method

	// Pixel shape
	void pixel_cloud(Vec3 pos, int num, int radius, String pattern) {
	  Pixel_cloud p = new Pixel_cloud(num, "3D", "ORDER") ;
	  p.beat(20) ;
	  p.pattern(pattern) ;
	  p.distribution(Vec3(pos.x +(step_grid /2),pos.y,pos.z), radius) ;
	  p.costume() ;
	}


	void pixel_classic(Vec3 pos, int size_int, Vec4 colour, String costume) {
	  Vec3 size = Vec3(size_int) ;
	  Pixel p = new Pixel(pos, size, colour, costume) ;
	  p.angle(p.colour.z) ;
	  p.costume() ;
	}




	/**
	Put the movie to the right and nice place
	*/
	void full_window_movie(int ID_item) {
	  // use this method only one time, in the setting for example
	  if(movieImport[ID_item].width != width || movieImport[ID_item].height != height) {
	    float ratio = float(width) / float(movieImport[ID_item].width) ;
	    step_grid *= ratio ;
	  }
	}


	void center_movie_in_the_height(int ID_item) {
	  if(movieImport[ID_item].height != height) {
	    float ratio = float(width) / float(movieImport[ID_item].width) ;
	    correction_pos_y = int((height -(movieImport[ID_item].height *ratio))  *.5 );
	  } 
	}
}