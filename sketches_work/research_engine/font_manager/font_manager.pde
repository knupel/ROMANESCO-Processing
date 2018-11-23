import geomerative.*;

// Declare the objects we are going to use, so that they are accesible from setup() and from draw()


void setup(){
  // Initilaize the sketch
  size(600,400);
  geom_setup("FreeSans.ttf");
  create_font();

  for(int i = 0 ; i < font.length ; i++) {
    println(font[i].get_name());
  }
}


int which_font = 0;
void draw() {
  background(255);
  

  // geom_draw();
  
}


ROFont [] font;
void create_font() {
  int size_font = 200;
  String path = sketchPath(0)+"/data";
  File [] file = list_files(path);
  // check if the file is a font or not
  int num = 0 ;
  for(int i = 0 ; i < file.length ; i++) {
    if(extension_font(file[i].getAbsolutePath())) {
      num++;
      // println("num",num);
    }
  }
  font = new ROFont[num];
   
  int target= 0;
  for(int i = 0 ; i < file.length ; i++) {
    if(extension_font(file[i].getAbsolutePath())) {
      font[target] = new ROFont(file[i].getAbsolutePath(),size_font);
      target++;
    } else {
      printErr("method create_font(), problem at",i,file[i].getAbsolutePath());
    }
    
  }
}



File [] list_files(String path) {
  File file = new File(path);
  if (file.isDirectory()) {
    File[] files = file.listFiles();
    return files;
  } else {
    // If it's not a directory
    return null;
  }
}

boolean extension_font(String path) {
  if(extension(path).equals("ttf") || extension(path).equals("TTF") || extension(path).equals("otf") || extension(path).equals("OTF")) {
    return true;
  } else return false;
}

class ROFont {
  PFont font;
  String path;
  String type;
  int size;

  ROFont(String path, int size) {
    if(extension_font(path)) {
      this.font = createFont(path,size);
      this.path = path;
      this.size = size;
      this.type = extension(path);
      //println(path,type);
    } else {
      printErr("class ROFont: path don't match with any font type >",path);
    }
  }

  PFont get_font() {
    return font;
  }

  String get_path() {
    return path;
  }

  String get_type() {
    return type;
  }

  int get_size() {
    return size;
  }

  String get_name() {
    return font.getName();
  }
}









RShape grp;
void geom_setup(String path) {
  // VERY IMPORTANT: Allways initialize the library in the setup
  RG.init(this);

  // Choice of colors
  background(255);
  fill(255, 102, 0);
  stroke(0);
  
  //  Load the font file we want to use (the file must be in the data folder in the sketch floder), with the size 60 and the alignment CENTER
  grp = RG.getText("Hello world!",path, 72, CENTER);

}


void geom_draw() {
  if(frameCount%10 == 0) {
    if(which_font >= font.length) which_font = 0;
    if(font[which_font].get_type().equals("ttf")) {
      try {
        geom_setup(font[which_font].get_path());
      }
      catch(Exception e){
        printErr("Geomerative cannot catch font",font[which_font].get_name());
      }
    }
    which_font++;
  }
  // Set the origin to draw in the middle of the sketch
  translate(width/2, height/2); 
  // Draw the string "Hola mundo!" on the PGraphics canvas g (which is the default canvas of the sketch)  
  grp.draw();

}
