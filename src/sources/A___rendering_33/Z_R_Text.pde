/**
* R_Text
* It's classes collection to manage text and sentences
* v 0.0.5
* 2019-2019
*/


/**
* class R_Typewriter
* v 0.0.4
*/
import geomerative.*;

public class R_Typewriter {
  RShape geom_group;
  String sentence;

  String path;
  String path_vector = null;
  String type;
  String [] type_wanted;

  PFont font;
  int size;
  vec3 pos;
  float angle = 0;
  boolean reset_cloud;
  int align = LEFT;

  public R_Typewriter(PApplet pa, String path, int size) {
    geomerative.RG.init(pa); // Geomerative
    build(path,size,"ttf","otf");
  }

  public R_Typewriter(PApplet pa, String path, int size, String... type_wanted) {
    geomerative.RG.init(pa); // Geomerative
    build(path,size,type_wanted);
  }

  private void build(String path, int size, String... type_wanted) {
    if(extension_is(path,type_wanted)) {
      this.type_wanted = type_wanted;
      this.path = path;
      this.size = size;
      this.font = createFont(this.path,this.size);
      this.type = extension(this.path);
      reset_cloud = true;
    } else {
      printErr("class R_Text: font path don't match with any font type:",path);
    }
  }

  // SET
  public void path(String path, boolean show_warning) {
    if(extension_is(path,type_wanted) && !this.path.equals(path)) {
      this.path = path;
      this.font = createFont(this.path,this.size);
    } else if(show_warning) {
      printErr("class R_Text method set(): font path don't match with any font type:",path);
    }
  }

  public void size(int size){
    if(this.size != size){
      this.size = size;
      this.font = createFont(this.path,this.size);
      reset_cloud = true;
    }
  }

  public void align(int align) {
    this.align = align;
  }

  public void angle(float angle){
    this.angle = angle;
  }

  public void content(String sentence) {
    if(this.sentence == null || !this.sentence.equals(sentence)) {
      this.sentence = sentence;
    }
  }

  public void pos(vec pos) {
    pos(pos.x(),pos.y(),pos.z());
  }

  public void pos(float x, float y) {
    pos(x,y,0);
  }

  public void pos(float x, float y, float z){
    if(pos == null) {
      pos = vec3(x,y,z);
    } else {
      pos.set(x,y,z);
    }
  }

  // GET
  public vec3 pos() {
    if(pos == null) {
      pos = vec3();
    }
    return pos;
  }

  public int size() {
    return size;
  }

  public float get_angle(){
    return this.angle;
  }

  public String get_path() {
    return this.path;
  }

  public void reset(){
    reset_cloud = true;
  }

  // GET POINTS
  ArrayList<vec3>points;
  public vec3 [] get_points(){
    if (this.sentence == null) {
      content("NULL");
      return calc_get_points();
    } else {
      return calc_get_points();
    }
  }

  private vec3 [] calc_get_points(){
    if(points == null) {
      points = new ArrayList<vec3>();
    }
    if(extension_is(path,"ttf")){
      path_vector = path;
    }

    if(path_vector != null && (geom_group == null || reset_cloud)) {
      reset_cloud = false;
      try {
        geom_group = geomerative.RG.getText(sentence,path_vector,size,align);
        points.clear();
        for(int i = 0 ; i < geom_group.children.length ; i++) {
          RPoint[] geom_pts = geom_group.children[i].getPoints();
          for(RPoint p : geom_pts) {
            points.add(geom_to_vec(p).add(pos()));
          }
        }
      } catch (Exception e) {
        e.printStackTrace();
        println("path vector",path_vector);
      } 
    }
    return points.toArray(new vec3[points.size()]); 
  }

  private vec3 geom_to_vec(RPoint p){
    return vec3(p.x,p.y,0);
  }

  // SHOW
  public void show(){
    show(0,0);
  }

    public void show(int w, int h){
    show(w,h,CORNER);
  }

  public void show(int w, int h, int window_position){
    if (this.sentence == null) {
      content("NULL");
      calc_show(w,h,window_position);
    } else {
      calc_show(w,h,window_position);
    }
  }

  private void calc_show(int w, int h, int window_position) {
    if(pos == null) {
      pos = vec3();
    }
    if(this.angle != 0){
      push();
      translate(pos);
      rotate(angle);
    }
    textFont(font);
    textAlign(align);
    if(this.angle != 0){
      if(w > 0 && h > 0){
        if(window_position != CENTER) {
          text(this.sentence,0,0,w,h);
        } else {
          text(this.sentence,-w/2,-h/2,w,h);
        } 
      } else {
        text(this.sentence,0,0);
      }
      pop();
    } else {
      if(w > 0 && h > 0){
        if(window_position != CENTER) {
          text(this.sentence,pos.x(),pos.y(),w,h);
        } else {
          text(this.sentence,-w/2 + pos.x(),-h/2 + pos.y(),w,h);
        }
        // text(this.sentence,pos.x(),pos.y(),w,h);
      } else {
        text(this.sentence,pos);
      }
    }
  }
}















/**
* Poem
* v 0.0.3
*/
public class Poem {
  String name;
  ArrayList<Vers[]> couplet = new ArrayList<Vers[]>();
  ArrayList<Vers> all;
  int vers;

  public Poem(String path) {
    String [] input = loadStrings(path);
    if(input[0] != null){
      build(input);
    } else {
      System.err.print("class Poem: Abort the input String arg[0] passing to constructor is null\n");
    }
  }

  public Poem(String [] input) {
    if(input[0] != null){
      build(input);
    } else {
      System.err.print("class Poem: Abort the input String arg[0] passing to constructor is null\n");
    }
  }

  private void build(String [] input) {
    int index_vers = 0;
    int index_local = 0;
    int index_couplet = 0;
    ArrayList<Vers> temp = new ArrayList<Vers>();
    for(int i = 0 ; i < input.length ; i++) {   
      if(input[i].equals("")) {
        if(temp.size() > 0) {
          Vers [] array = temp.toArray(new Vers[temp.size()]);
          index_couplet++;
          index_local = 0;
          couplet.add(array);
        }
        temp.clear();
      } else {
        Vers vers = new Vers(index_vers,index_local, index_couplet,input[i]);
        temp.add(vers);
        if(i == input.length -1) {
          Vers [] array = temp.toArray(new Vers[temp.size()]);
          couplet.add(array);
        }
        index_local++;
        index_vers++;
      }
    }
  }

  public int size() {
    write_all();
    return all.size();
  }

  public int num_couplets() {
    return couplet.size();
  }

  // get couplet
  public ArrayList<Vers[]> get_couplets() {
    return couplet;
  }

  public Vers [] couplet(int target) {
    if(target < couplet.size()) {
      return couplet.get(target);
    } else {
      Vers [] empty = new Vers[1];
      empty[0] = new Vers(0,0,0,"");
      return empty;
    }
  }

  // get vers
  public ArrayList<Vers> get_vers() {
    write_all();
    return all;
  }

  public Vers get_vers(int target) {
    write_all();
    if(target >= 0 && target < all.size()) {
      return all.get(target);
    } else {
      return null;
    }
  }

  private void write_all() {
    if(all == null) {
      all = new ArrayList<Vers>();
      for(Vers[] couplet : get_couplets()) {
        for(Vers v : couplet) {
          all.add(v);
        }   
      }
    }   
  }
}












public class Vers {
  int id;
  int id_local;
  int couplet;
  String sentence;
  Vers(int id, int id_local, int couplet, String sentence) {
    this.id = id;
    this.id_local = id_local;
    this.couplet = couplet;
    this.sentence = sentence;
  }

  int id() {
    return id;
  }

  int id_local() {
    return id_local;
  }

  int id_couplet() {
    return couplet;
  }

  String toString() {
    return sentence;
  }

  Vers read() {
    return this;
  }
}

