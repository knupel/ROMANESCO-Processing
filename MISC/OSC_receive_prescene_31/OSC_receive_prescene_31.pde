void setup() {
  size(400,400);
  OSC_setup();

}


void draw() {
}




import oscP5.*;
import netP5.*;
OscP5 osc_receive_controller;
void OSC_setup() {
	osc_receive_controller = new OscP5(this, 10000);
}



void oscEvent(OscMessage receive) {
  if(receive.addrPattern().equals("Controller")) {
    println(receive.arguments().length, frameCount);
    for(int i = 0 ; i < receive.arguments().length ; i++) {
      println(i, get_type(receive.arguments()[i]));
      // println(i, get_type(receive.get(i)));
    }
    
    // thread_data_controller(receive) ;
    /*
    data_controller_button();
    data_controller_slider();
    data_controller_save();
    */
  }
}
