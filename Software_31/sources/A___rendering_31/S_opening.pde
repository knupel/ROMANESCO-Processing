/**
OPENING
2018-2018
v 0.0.1
*/
void message_opening() {
  fill(blanc) ;
  stroke(blanc) ;
  textSize(48) ;
  textAlign(CENTER) ;
  start_matrix() ;
  translate(width/2, height/2, abs(sin(frameCount * .005)) *(height/2)) ;
  text("Romanesco Unu release " + prettyVersion+"." + version, 0,0) ;
  stop_matrix() ;
  textAlign(LEFT) ;
}