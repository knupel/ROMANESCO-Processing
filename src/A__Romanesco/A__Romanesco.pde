/**
* Romanesco dui
* 2012–2021
* release 34
* Processing 4.0.2b
*/


// DEV MODE
boolean DEV_MODE = true;
boolean LIVE = false;
boolean HOME = false;
boolean MIRROR = false;
boolean FULLSCREEN = false;


// EXPORT
// boolean DEV_MODE = false;
// boolean LIVE = false;
// boolean HOME = false;
// boolean MIRROR = false;
// boolean FULLSCREEN = false;

void settings() {
  size(450,220);
}

void setup() {
  path_setting();
  init_rope();
  version();
  colorMode(HSB,360,100,100);
  display_setup();
  set_structure();
  set_data();
}

void draw() {
  surface.setTitle(nameVersion + " " +prettyVersion+"."+version+ " - Launcher");
  structure_background();
  reset_window_location();
  launcher();
  open_romanesco();
}

void mousePressed() {
  mousePressed_button();
}

void mouseReleased() {
  if(button_full_screen.is()) {
    which_screen_released();
  }
}
