/**
Cellular Automata
2018-2018
v 0.0.1
*/
class Cellular_automata extends Romanesco {
	public Cellular_automata() {
		item_name = "Automata";
		item_author  = "Stan le Punk";
    item_references = "Item based on Daniel Shiffman code\nand behavior from Stephen Wolfram\nhttps://natureofcode.com/";
		item_version = "Version 0.0.1";
		item_pack = "Nature of Code 2018-2018";
    item_costume = "point/ellipse/triangle/rect/cross/pentagon/Star 5/Star 7/Super Star 8/Super Star 12";
    item_mode = "rules 30/rules 110/rules 190/rules 222";

	  hue_fill_is = true;
    sat_fill_is = true;
    bright_fill_is = true;
    alpha_fill_is = true;
    hue_stroke_is = true;
    sat_stroke_is = true;
    bright_stroke_is = true;
    alpha_stroke_is = true;
    thickness_is = true;
    size_x_is = true;
    size_y_is = true;
    size_z_is = true;
    // diameter_is = true;
    canvas_x_is = true;
    canvas_y_is = true;
    // canvas_z_is = true;

    // frequence_is = true;
    speed_x_is = true;
    // speed_y_is = true;
    // speed_z_is = true;
    // spurt_x_is = true;
    // spurt_y_is = true;
    // spurt_z_is = true;
    // dir_x_is = true;
    // dir_y_is = true;
    // dir_z_is = true;
    // jit_x_is = true;
    // jit_y_is = true;
    // jit_z_is = true;
    // swing_x_is = true;
    // swing_y_is = true;
    // swing_z_is = true;

    // quantity_is = true;
    // variety_is = true;
    // life_is = true;
    // flow_is = true;
    // quality_is = true;
    area_is = true;
    // angle_is = true;
    // scope_is = true;
    // scan_is = true;
    // align_is = true;
    // repulsion_is = true;
    // attraction_is = true;
    // density_is = true;
    // influence_is = true;
    // calm_is = true;
    // spectrum_is = true;

    grid_is = true;
    // viscosity_is = true;
    // diffusion_is = true;
    // power_is = true;
    // mass_is = true;
  }
  


  CA ca;
  int delay = 0;




  void setup() {
    setting_start_position(ID_item,0,0,0);
    
  }
  
  int cell_size_ref = 5;
  iVec2 canvas_ref;
  int ref_mode;
  void draw() {
    int cell_size = (int)map(get_grid(),grid_min_max.x,grid_min_max.y,height/10,1);
    iVec2 canvas = iVec2((int)get_canvas_x(),(int)get_canvas_y());

    if(ca == null || cell_size != cell_size_ref || !canvas_ref.equals(canvas) || ref_mode != get_mode()) {
      int[] ruleset = {0,1,1,1,1,0,0,0}; // rule 30
      int[] ruleset_30 = {0,1,1,1,1,0,0,0}; 
      int[] ruleset_110 = {0,1,1,1,0,1,1,0}; 
      int[] ruleset_190 = {0,1,1,1,1,1,0,1};   
      int[] ruleset_222 = {0,1,1,1,1,0,1,1}; 

      if(get_mode() == 0) {
        ruleset = ruleset_30;
      } else if(get_mode() == 1) {
         ruleset = ruleset_110;
      } else if(get_mode() == 2) {
         ruleset = ruleset_190;
      } else if(get_mode() == 3) {
         ruleset = ruleset_222;
      }
      // ref part
      ref_mode = get_mode();
      cell_size_ref = cell_size;
      if(canvas_ref == null) {
        canvas_ref = canvas.copy();
      } else {
        canvas_ref.set(canvas);
      }
      ca = new CA(ruleset,canvas,cell_size_ref);
    }

    aspect_is(fill_is(),stroke_is());
    aspect_rope(get_fill(),get_stroke(),get_thickness());

    Vec3 size = map(get_size(),size_x_min_max.x,size_x_min_max.y,0.01,cell_size*4);
    float area = get_area();

    ca.show(get_costume(),size,area);
    int mod = (int)map(get_speed_x(),0,1,60,1);
    if(motion_is() && frameCount%mod == 0) {
      ca.generate();
    }
  }


  private class CA {
    int generation;  // How many generations?
    int[] ruleset;   // An array to store the ruleset, for example {0,1,1,0,1,1,0,1}
    int cell_size = 5;
    int[][] matrix;  // Store a history of generations in 2D array, not just one
    iVec2 canvas;

    int cols;
    int rows;


    CA(int[] r, iVec2 canvas,int cell_size) {
      this.canvas = canvas.copy();
      this.cell_size = cell_size;
      ruleset = r;
      cols = canvas.x/cell_size;
      rows = canvas.y/cell_size;
      matrix = new int[cols][rows];
      restart();
    }

    // Make a random ruleset
    void randomize() {
      for (int i = 0; i < 8; i++) {
        ruleset[i] = int(random(2));
      }
    }

    // Reset to generation 0
    void restart() {
      for (int i = 0; i < cols; i++) {
        for (int j = 0; j < rows; j++) {
          matrix[i][j] = 0;
        }
      }
      matrix[cols/2][0] = 1;    // We arbitrarily start with just the middle cell having a state of "1"
      generation = 0;
    }


    // The process of creating the new generation
    void generate() {
      // For every spot, determine new state by examing current state, and neighbor states
      // Ignore edges that only have one neighor
      for (int i = 0; i < cols; i++) {
        int left  = matrix[(i+cols-1)%cols][generation%rows];   // Left neighbor state
        int me    = matrix[i][generation%rows];       // Current state
        int right = matrix[(i+1)%cols][generation%rows];  // Right neighbor state
        matrix[i][(generation+1)%rows] = rules(left,me,right); // Compute next generation state based on ruleset
      }
      generation++;
    }

    void show(int costume, Vec3 size, float area) {
      int offset = generation%rows;
      int displacement_x = (canvas.x-width)/2;
      int displacement_y = (canvas.y-height)/2;;
      for (int i = 0; i < cols; i++) {
        for (int j = 0; j < rows; j++) {
          int y = j - offset;
          if (y <= 0) y = rows + y;
          if (matrix[i][j] == 1) {
            Vec3 temp_size = Vec3(cell_size).mult(size);
            float temp_x = (i*cell_size) -displacement_x;
            float temp_y = ((y-1)*cell_size) -displacement_y;
            Vec3 pos = Vec3(temp_x,temp_y,0);
            set_ratio_costume_size(map(area,area_min_max.x,area_min_max.y,0,1));
            costume_rope(pos,temp_size,costume);
          } 
        }
      }
    }

    // Implementing the Wolfram rules
    int rules (int a, int b, int c) {
      if (a == 1 && b == 1 && c == 1) return ruleset[7];
      if (a == 1 && b == 1 && c == 0) return ruleset[6];
      if (a == 1 && b == 0 && c == 1) return ruleset[5];
      if (a == 1 && b == 0 && c == 0) return ruleset[4];
      if (a == 0 && b == 1 && c == 1) return ruleset[3];
      if (a == 0 && b == 1 && c == 0) return ruleset[2];
      if (a == 0 && b == 0 && c == 1) return ruleset[1];
      if (a == 0 && b == 0 && c == 0) return ruleset[0];
      return 0;
    }

    // The CA is done if it reaches the bottom of the screen
    boolean finished() {
      if (generation > canvas.y/cell_size) {
        return true;
      } 
      else {
        return false;
      }
    }
  }
}



















