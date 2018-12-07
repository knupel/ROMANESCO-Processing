



void draw() {

}



void keyPressed() {
  add_history();
  println(history.size());
}


History history = new History(5);
void add_history() {
  Script script = new Script();
  String name_data = "bonjour";
  script.add(name_data,Vec3(4));
  history.add(script);
  println("show last script",history.get(0).get_timestamp());
  println("show data",history.get(0).get(name_data));
  if(history.get(0).get(name_data) instanceof Vec3) {
    println("BRAVO");
  }
}








