/**
* Romanesco dui
* 2012–2019
* release 33
* Processing 3.5.3
*/

boolean DEV = false;
boolean LIVE = false;
boolean HOME = false;
boolean MIRROR = false;
boolean FULLSCREEN = false;

void settings() {
  size(450,220);
}

void setup() {
  path_setting();
  rope_version();
  version();
  colorMode(HSB,360,100,100);
  display_setup();
  set_structure();
  set_data();
}

void draw() {
  surface.setTitle(nameVersion + " " +prettyVersion+"."+version+ " - Launcher");
  reset_window_location();
  launcher_background();
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