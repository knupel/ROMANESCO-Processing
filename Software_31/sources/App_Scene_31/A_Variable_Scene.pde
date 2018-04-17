/**
Variable_Scene
2014_2018
v 0.1.1
*/
boolean scene = true ;
boolean prescene = false ;
boolean miroir_on_off = false ;

boolean check_size = false ;


// In the Miroir and Scene sketch presceneOnly must be true for the final work.
Boolean internet = true ;
String bigBrother = ("BIG BROTHER DON'T WATCHING YOU !!") ;

//Special var for the Scene and the Miroir




//init var
//GLOBAL
void variables_setup() {
  for (int i = 0 ; i < data_osc_prescene.length ; i++) {
    data_osc_prescene[i] = ("0");
  }
  
  for (int i = 0 ; i < NUM_ITEM ; i++ ) {
    pen[i] = Vec3() ;
    mouse[i] = Vec3() ;
    wheel[i] = 0 ;
  }
  println("variables setup done") ;
}