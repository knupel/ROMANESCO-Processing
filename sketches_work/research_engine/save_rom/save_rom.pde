void setup() {
  String file_name = "truc";
  save_rom(sketchPath(),file_name,script);
  read_file_rom(sketchPath()+"/"+file_name+".rom");
}

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileInputStream;
import org.apache.commons.io.IOUtils;
void save_rom(String path_folder, String name, Script script) {
  File dir = new File(path_folder);
  dir.mkdir();
  String path_file = path_folder+"/"+name+".rom";
  try {
    OutputStream os = new FileOutputStream(new File(path_file));
    save_file_rom(os,script) ;
  }  catch (FileNotFoundException e) {
    //
  }
}

void save_file_rom(OutputStream os, Script script) {
  try {
    // byte[] content = script.getBytes();
    // String case to know the length before write, to read easily after
    String s = "machin";
    int length = s.length();
    os.write(to_byte(length));
    byte[] content = s.getBytes();
    os.write(content);



    float f = 12.5;

    os.write(to_byte(f));
    os.flush();
    os.close();
  } catch(IOException e) {
    //
  }
}


void read_file_rom(String path) {
  File file = new File(path);
  println(file.getName());
  println(file.canRead());
  int start = 0;
  try {
    InputStream is = new FileInputStream(file);
    println("byte array available",is.available());
    byte [] array = org.apache.commons.io.IOUtils.toByteArray(is);
    printArray(array.length);
    println(array);
    // step 1 ; read the length
    for(int i = start ; i < start+4 ; i++) {

    }

    is.close();
  } 
  catch (FileNotFoundException e){

  }

  catch (IOException e){

  }
}



