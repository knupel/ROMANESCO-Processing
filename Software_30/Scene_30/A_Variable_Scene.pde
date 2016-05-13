// Tab: A_Variable_Scene
boolean scene = true ;
boolean prescene = false ;
boolean miroir_on_off = false ;

boolean check_size = false ;


// In the Miroir and Scene sketch presceneOnly must be true for the final work.
Boolean internet = true ;
String bigBrother = ("BIG BROTHER DON'T WATCHING YOU !!") ;

//specific at the Scene
String valueTempPrescene[] = new String [100] ;
//Special var for the Scene and the Miroir




//init var
//GLOBAL
void variables_setup() {
  for (int i = 0 ; i < valueTempPrescene.length ; i++) {
    valueTempPrescene[i] = ("0") ;
  }
  
  for (int i = 0 ; i < numObj ; i++ ) {
    pen[i] = Vec3() ;
    mouse[i] = Vec3() ;
    wheel[i] = 0 ;
  }
  println("variables setup done") ;
}