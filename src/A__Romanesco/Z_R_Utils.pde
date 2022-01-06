/**
* Rope UTILS 
* v 1.67.1
* Copyleft (c) 2014-2021
* Rope – Romanesco Processing Environment – 
* @author Knupel / Stanislas Marçais
* @see https://github.com/StanLepunK/Rope_framework
*/

// METHOD MANAGER
import java.lang.reflect.Method;
// FOLDER & FILE MANAGER
import rope.tool.file.*;
// TRANSLATOR 
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
// EXPORT PDF
import processing.pdf.*;



/**
* pixel array
*/
int index_pixel_array(int x, int y, int w) {
	return (x + y * w);
}


/**
* tempo
* v 0.0.1
* 2019-2019
* create tempo partition
*/
float [] tempo = {1};
void tempo(float... tempo) {
	this.tempo = tempo;
}

float sum_tempo() {
	float sum = 0;
	for(int i = 0 ; i < tempo().length ; i++) {
		sum += tempo()[i];
	}
	return sum;
}

float get_tempo(float time) {
	return tempo()[get_tempo_pos(time)];
}

int get_tempo_pos(float time) {
	float rank = time%sum_tempo();
	float progress = 0;
	int pos = 0;
	for(int i = 0 ; i < tempo().length ; i++) {
		progress += tempo()[i];
		if(rank < progress) {
			pos = i;
			break;
		}  
	} 
	return pos;
}

float [] tempo() {
	return tempo;
}















/**
* METHOD MANAGER
* to create method from String name, add in a list and recall from this String name later
* v 0.0.4
* 2019-2019
*/
// main method
void template_method(String name, PApplet pa, Class... classes) {
	if(method_index == null) {
		method_index = new ArrayList<Method_Manager>();
	} 
	init_method(name,pa,classes);
}

boolean method_exist_is = true;
boolean method_is() {
	return method_exist_is;
}

void method(String name, PApplet pa, Object... args) {
	method_exist_is = true;
	Method method = method_exist(name, args);
	if(method != null) {
		invoke_method(method, pa, args);
	} else {
		println("method(): no method exist for this name:",name,"or this order of arguments:");
		method_exist_is = false;
		for(int i = 0 ; i < args.length ; i++) {
			println("[",i,"]",args[i].getClass().getName());
		} 
	}
}

// private method
Method method_exist(String name, Object... args) {
	Method method = null;
	if(method_index != null && method_index.size() > 0) {
		for(Method_Manager mm : method_index) {
			if(mm.get_name().equals(name)) {
				boolean same_is = true;
				if(args.length == mm.get_index().length) {
					for(int i = 0 ; i < args.length; i++) {
						String arg_name = translate_class_to_type_name_if_necessary(args[i]);
						if(!arg_name.equals(mm.get_index()[i])) {
							same_is = false;
							break;
						}
					}
				} else {
					same_is = false;
				}       
				if(same_is) {
					method = mm.get_method();
				}
			}
		}
	}
	return method;
}

String translate_class_to_type_name_if_necessary(Object arg) {
	String name = arg.getClass().getName();
	if(name.equals("java.lang.Byte")) {
		name = "byte";
	} else if(name.equals("java.lang.Short")) {
		name = "short";
	} else if(name.equals("java.lang.Integer")) {
		name = "int";
	} else if(name.equals("java.lang.Long")) {
		name = "long";
	} else if(name.equals("java.lang.Float")) {
		name = "float";
	} else if(name.equals("java.lang.Double")) {
		name = "double";
	} else if(name.equals("java.lang.Boolean")) {
		name = "boolean";
	} else if(name.equals("java.lang.Character")) {
		name = "char";
	}
	return name;
}


ArrayList<Method_Manager> method_index ;
void init_method(String name, PApplet pa, Class... classes) { 
	// check if method already exist
	boolean create_class_is = true; 
	for(Method_Manager mm : method_index) {
		if(mm.get_name().equals(name)) {
			if(mm.get_index().length == classes.length) {
				int count_same_classes = 0;
				for(int i = 0 ; i < classes.length ; i++) {
					if(mm.get_index()[i].equals(classes[i].getCanonicalName())) {
						count_same_classes++;
					}
				}
				if(count_same_classes == classes.length) {
					create_class_is = false;
					break;
				}
			}
		}
	}
	// instantiate if necessary
	if(create_class_is) {
		Method method = get_method(name,pa,classes);
		Method_Manager method_manager = new Method_Manager(method,name,classes);
		method_index.add(method_manager);
	} else {
		println("template_method(): this method",name,"with those classes organisation already exist");
	}
}


/**
* Method manger
*/
class Method_Manager {
	Method method;
	String name;
	String [] index;
	Method_Manager(Method method, String name, Class... classes) {
		index = new String[classes.length];
		for(int i = 0 ; i < index.length ; i++) {
			index[i] = classes[i].getName();
		}
		this.method = method;
		this.name = name;
	}

	String [] get_index() {
		return index;
	}

	String get_name() {
		return name;
	}

	Method get_method() {
		return method;
	}
}


/**
 * refactoring of Method Reflective Invocation (v4.0)
 * Stanlepunk (2019/Apr/03)
 * Mod GoToLoop
 * https://Discourse.Processing.org/t/create-callback/9831/16
 */
static final Method get_method(String name, Object instance, Class... classes) {
	final Class<?> c = instance.getClass();
	try {
		return c.getMethod(name, classes);
	} 
	catch (final NoSuchMethodException e) {
		try {
			final Method m = c.getDeclaredMethod(name, classes);
			m.setAccessible(true);
			return m;
		}   
		catch (final NoSuchMethodException ex) {
			ex.printStackTrace();
			return null;
		}
	}
}

static final Object invoke_method(Method funct, Object instance, Object... args) {
	try {
		return funct.invoke(instance, args);
	} 
	catch (final ReflectiveOperationException e) {
		throw new RuntimeException(e);
	}
}























/**
CHECK SIZE WINDOW
return true if the window size has changed
*/
ivec2 rope_window_size;
boolean window_change_is() {
	if(rope_window_size == null || !all(equal(ivec2(width,height),rope_window_size))) {
		check_window_size();
		return true;
	} else {
		return false;
	}
}

void check_window_size() {
	if(rope_window_size == null) {
		rope_window_size = ivec2(width,height);
	} else {
		rope_window_size.set(width,height);
	}
}







/**
print Constants
v 0.1.1
*/
Constant_list rope_constants_colour_list;
public void print_constants_colour_rope() {
	if(rope_constants_colour_list == null) {
		rope_constants_colour_list = new Constant_list(rope.core.R_Constants_Colour.class);
	}
	println("ROPE CONSTANTS COLOUR");
	for(String s: rope_constants_colour_list.list()){
		println(s);
	}
}

Constant_list rope_constants_list;
public void print_constants_rope() {
	if(rope_constants_list == null) {
		rope_constants_list = new Constant_list(rope.core.R_Constants.class);
	}
	println("ROPE CONSTANTS");
	for(String s: rope_constants_list.list()){
		println(s);
	}
}

Constant_list processing_constants_list;
public void print_constants_processing() {
	if(processing_constants_list == null) {
		processing_constants_list = new Constant_list(PConstants.class);
	}
	println("PROCESSING CONSTANTS");
	for(String s: processing_constants_list.list()) {
		println(s);
	}
} 

public void print_constants() {
	print_constants_rope();
	println(" ");
	print_constants_colour_rope();
	println(" ");
	print_constants_processing();
} 

/*
* class to list the interface stuff
*/
class Constant_list {
	Field[] classFields; 
	Constant_list(Class c){
		classFields = c.getFields();
	}
	ArrayList<String> list() {
		ArrayList<String> slist = new ArrayList();
		// for each constant
		for (Field f : classFields) {
			String s = "";
			// object type
			s = s + "(" + f.getType() + ")";
			// field name
			s = s + " " + f.getName();
			// value
			try {
				s = s + ": " + f.get(null);
			} 
			catch (IllegalAccessException e) {
			}
			// Optional special handling for field types:
			if (f.getType().equals(int.class)) {
				// ...
			}
			if (f.getType().equals(float.class)) {
				// ...
			}
			slist.add(s);
		}
		return(slist);
	}
}



















/**
* FOLDER & FILE MANAGER
* v 0.8.1
*/
String warning_input_file_folder_message = "Window was closed or the user hit cancel.";
String warning_input_file_not_accepted = "\u001B[31mThis file don't match with any extension accepted:\u001B[37m";


// String [] input_type = {  "default",
// 													"image","media","movie","shape","sound","text",
// 													"load",
// 													"preference","setting"
// 												};



// // filter
// String[] ext_default;
// String[] ext_image = { "png", "jpeg", "jpg", "tif", "tga", "gif"};
// String[] ext_load;
// String[] ext_media;
// String[] ext_movie = { "mov", "avi", "mp4", "mpg", "mkv"};
// String[] ext_preference;
// String[] ext_setting = { "csv", "txt", "json"};
// String[] ext_shape = { "svg", "obj"};
// String[] ext_sound = { "mp3", "wav"};
// String[] ext_text = { "txt", "md"};







void print_extension_filter() {
	print_extension_filter("all");
}


void print_extension_filter(String type) {
	if(get_inputs() != null && get_inputs().length > 0) {
		if(type.equals("all")) {
			for(int i = 0 ; i < get_inputs().length ; i++) {
				println(get_input(i).get_type());
				printArray(get_input(i).get_filter());
			}
		} else {
			int count = 0;
			for(int i = 0 ; i < rope_input.get_input_type().length ; i++) {
				count++;
				if(rope_input.get_input_type()[i].equals(type)) {
					println(get_input(type).get_type());
					printArray(get_input(type).get_filter());
					break;
				}
				if(count == rope_input.get_input_type().length) {
					print_err(r.ANSI_RED+"method print_extension_filter(): no input available for this type:"+r.ANSI_WHITE,type);
				}
			}
		}
	} else {
		print_err("method print_extension_filter(): no input available");
	}
}




/*
* INPUT PART
* v 1.0.1
* 2017-2021
*/
R_Input rope_input;

void select_input() {
	select_input("default");
}

void select_input(String type) {
	if(rope_input == null) {
		rope_input = new R_Input(this);
	}
	rope_input.select_input(type);
}

R_Data_Input get_input(String type) {
	if(rope_input == null)
		rope_input = new R_Input(this);
	return rope_input.get_input(type);
}

R_Data_Input [] get_inputs() {
	if(rope_input == null)
		rope_input = new R_Input(this);
	return rope_input.get_inputs();
}

R_Data_Input get_input(int target) {
	if(rope_input == null)
		rope_input = new R_Input(this);
	return rope_input.get_input(target);
}

boolean input_use_is() {
	return input_use_is("default");
}

boolean input_use_is(String type) {
	if(rope_input == null)
		rope_input = new R_Input(this);
	return rope_input.input_use_is(type);
}

void input_use(boolean is) {
	input_use("default" ,is);
}

void input_use(String type, boolean is) {
	if(rope_input == null)
		rope_input = new R_Input(this);
	rope_input.input_use(type, is);
}

String input_path() {
	return input_path("default");
}

String input_path(String type) {
	if(rope_input == null)
		rope_input = new R_Input(this);
	return rope_input.input_path(type);
}

void reset_input() {
	reset_input("default");
}

void reset_input(String type) {
	if(rope_input == null)
		rope_input = new R_Input(this);
	rope_input.reset_input(type);
}

File input_file() {
	return input_file("default");
}

File input_file(String type) {
	if(rope_input == null)
		rope_input = new R_Input(this);
	return rope_input.input_file(type);
}

void set_filter_input(String type, String... extension) {
	if(rope_input == null)
		rope_input = new R_Input(this);
	rope_input.set_filter_input(type, extension);
}


/**
* this method is called by method selectInput() in class R_Input
* and the method name must be the same as named
*/
void select_single_file(File selection) {
	if (selection == null) {
		println("Window was closed or the user hit cancel.");
	} else {
		String default_input = "default";
		for(int i = 0 ; i < get_inputs().length ; i++) {
			if (default_input.toLowerCase().equals(get_input(i).get_type())) { 
				get_input(i).set_file(selection);
				if(get_input(i).get_file() != null) {
					println("method select_single_file(",get_input(i).get_type(),"):",get_input(i).get_file().getPath());
				}
				break;
			}
		}  
	}
}









/*
* FOLDER PART
* v 1.1.0
* 2017-2021
*/
R_Folder rope_folder;
void explore_folder(String path, String... extension) {
	explore_folder(path, false, extension);
}

void explore_folder(String path, boolean check_sub_folder, String... extension) {
	if(rope_folder == null)
		rope_folder = new R_Folder(this);
	rope_folder.explore_folder(path, check_sub_folder, extension);
}

String folder() {
	if(rope_folder == null)
		rope_folder = new R_Folder(this);
	return rope_folder.get_folder_path();
}

ArrayList<File> get_files() {
	return rope_folder.get_files();
}

void clear_files() {
	if(rope_folder != null) {
		rope_folder.clear();
	}
}

void select_folder() {
	select_folder("");
}

void select_folder(String message) {
	if(rope_folder == null)
		rope_folder = new R_Folder(this);
	rope_folder.select_folder(message);
}

boolean folder_input_default_is() {
	if(rope_folder == null)
		rope_folder = new R_Folder(this);
	return rope_folder.folder_input_default_is();
}

/**
* this function rope_select_folder() is called by method select_folder() in class R_Folder from library Rope
* and the method name must be the same as named
*/
void rope_select_folder(File selection) {
	if (selection == null) {
		println(warning_input_file_folder_message);
	} else {
		println("Folder path is:" +selection.getAbsolutePath());
		rope_folder.set_folder_path(selection.getAbsolutePath());
		rope_folder.folder_is(true);
	}
}

void reset_folder() {
	rope_folder.reset_folder();
}

boolean folder_is() {
	return rope_folder.folder_is();
}

String [] get_files_sort() {
	return rope_folder.get_files_sort();
}















/**
* SAVE LOAD  FRAME Rope
* v 0.4.1
* 2016-2019
*/
/**
* Save Frame
*/
void save_frame(String where, String filename, PImage img) {
	float compression = 1.;
	save_frame(where, filename, compression, img);
}

void save_frame(String where, String filename) {
	float compression = 1. ;
	PImage img = g;
	save_frame(where, filename, compression, img);
}

void save_frame(String where, String filename, float compression) {
	PImage img = g;
	save_frame(where, filename, compression, img);
}

void save_frame(String where, String filename, float compression, PImage img) {
	// check if the directory or folder exist, if it's not create the path
	File dir = new File(where);
	dir.mkdir() ;
	// final path with file name adding
	String path = where+"/"+filename ;
	try {
		OutputStream os = new FileOutputStream(new File(path));
		loadPixels(); 
		BufferedImage buff_img;
		if(img == null) {
			print_err("method save_frame(): the PImage is null, no save can be done");
		} else {
			buff_img = new BufferedImage(img.width, img.height, BufferedImage.TYPE_INT_RGB);
			buff_img.setRGB(0, 0, img.width, img.height, img.pixels, 0, img.width);

			if(extension_is(path, "bmp")) {
				save_BMP(os, buff_img);
			} else if(extension_is(path, "jpg", "jpeg")) {
				save_JPG(os, compression, buff_img);
			// } else if(extension_is(path, "png")) {
			//   event_PNG();
			//   filename = filename.substring(0,filename.length()-4);
			//   save_PNG(path,filename);
			} else {
				print_err("method save_frame(): no save match with this path "+path);
			}
		} 
	} catch (FileNotFoundException e) {
		//
	}
}






/**
* SAVE PNG
*/
boolean record_PNG;
void save_PNG() {
	save_PNG("data", "shot_"+ranking_shot);
}

void save_PNG(String path, String name_file) {
	if(record_PNG) {
		saveFrame(path + "/" + name_file + ".png");
		record_PNG = false;
	}
}

void event_PNG() {
	record_PNG = true;
}







/**
SAVE JPG
v 0.0.1
*/
// classic one
boolean save_JPG(OutputStream output, float compression,  BufferedImage buff_img) {
	compression = truncate(compression, 1);
	if(compression < 0) compression = 0.0f;
	else if(compression > 1) compression = 1.0f;

	try {
		ImageWriter writer = null;
		ImageWriteParam param = null;
		IIOMetadata metadata = null;

		if ((writer = image_io_writer("jpeg")) != null) {
			param = writer.getDefaultWriteParam();
			param.setCompressionMode(ImageWriteParam.MODE_EXPLICIT);
			param.setCompressionQuality(compression);

			writer.setOutput(ImageIO.createImageOutputStream(output));
			writer.write(metadata, new IIOImage(buff_img, null, metadata), param);
			writer.dispose();
			output.flush();
			javax.imageio.ImageIO.write(buff_img, "jpg", output);
		}
		return true;
	}
	catch(IOException e) {
		e.printStackTrace();
	}
	return false;
}

ImageWriter image_io_writer(String extension) {
	// code from Processing PImage.java
	Iterator<ImageWriter> iter = ImageIO.getImageWritersByFormatName(extension);
	if (iter.hasNext()) {
		return iter.next();
	}
	return null;
}


/**
SAVE BMP
v 0.3.0.1
*/
// SAVE
boolean save_BMP(OutputStream output, BufferedImage buff_img) {
	try {
		Graphics g = buff_img.getGraphics();
		g.dispose();
		output.flush();
		
		ImageIO.write(buff_img, "bmp", output);
		return true;
	}
	catch(IOException e) {
		e.printStackTrace();
	}
	return false;
}

// LOAD
PImage load_image_BMP(String fileName) {
	PImage img = null;

	try {
		InputStream is = createInput(fileName);
		BufferedImage buff_img = ImageIO.read(is);
		int[] pix = buff_img.getRGB(0, 0, buff_img.getWidth(), buff_img.getHeight(), null, 0, buff_img.getWidth());
		img = createImage(buff_img.getWidth(),buff_img.getHeight(), RGB);
		// println("Componenent", buff_img.getColorModel().getNumComponents()) ;
		img.pixels = pix;   

		// in case the picture is in grey value...to set the grey because this one is very very bad
		// I don't find any solution to solve it...
		// any idea ?
		if(buff_img.getColorModel().getNumComponents() == 1) {
			float ratio_brightness = .95;
			for(int i = 0 ; i < img.pixels.length ; i++) {     
				colorMode(HSB);
				float b = brightness(img.pixels[i]) *ratio_brightness ;
				img.pixels[i] = color(0,0,b);
				colorMode(RGB);
			}
		}
	}
	catch(IOException e) {
	}

	if(img != null) {
		return img;
	} else {
		return null ;
	}
}


/**
* SAVE PDF
*/
String ranking_shot = "_######" ;
// PDF
boolean record_PDF;
void start_PDF() {
	start_PDF(null,null) ;
}

void start_PDF(String name_file) {
	start_PDF(null, name_file) ;
}

void start_PDF(String path_folder, String name_file) {
	if(path_folder == null) path_folder = "pdf_folder";
	if(name_file == null) name_file = "pdf_file_"+ranking_shot;

	if (record_PDF && !record_PNG) {
		if(renderer_P3D()) {
			beginRaw(PDF, path_folder+"/"+name_file+".pdf"); 
		} else {
			beginRecord(PDF, path_folder+"/"+name_file+".pdf");
		}
	}
}

void save_PDF() {
	if (record_PDF && !record_PNG) {
		if(renderer_P3D()) {
			endRaw(); 
		} else {
			endRecord() ;
		}
		println("PDF");
		record_PDF = false;
	}
}

void event_PDF() {
	record_PDF = true;
}



































/**
TRANSLATOR 
v 0.4.0
*/
ivec2 calc_atoi(int index, String str) {
  int result = 0;
    int check_is = 1;
  while (index < str.length()) {
    if (str.charAt(index) >= '0' && str.charAt(index) <= '9') {
      int next = index +1;
      if (next < str.length() && str.charAt(next) >= '0' && str.charAt(next) <= '9') {
          result *= 10;
          result += (str.charAt(index) - '0');
      }
      else {
        result *= 10;
        result += (str.charAt(index) - '0');
        check_is = 0;
      }
    }
    else if (!(str.charAt(index) >= '0' && str.charAt(index) <= '9') && check_is == 0) {
      break ;
    }
    index++;
  }
  return new ivec2(result,index);
}
/**
* atoi
* v 0.0.3
* 2019-2019
*/
int atoi(String str) {
	int index = 0;
	// sign
	int sign = 1;
	while (index < str.length()) {
		if (str.charAt(index) == '-')
			sign *= -1;
		else if (str.charAt(index) >= '0' && str.charAt(index) <= '9')
			break ;
		index++;
	}
	// clean
	int result = 0;
	ivec2 step = calc_atoi(index, str);
  result = step.x();
	// result
	return (sign * result);
}


/**
* atof
* v 0.0.1
* 2019-2019
*/
float atof(String str) {
	int index = 0;
	float result = 0;
	// sign
	int sign = 1;
	while (index < str.length()) {
		if (str.charAt(index) == '-')
			sign *= -1;
		else if (str.charAt(index) >= '0' && str.charAt(index) <= '9')
			break ;
		index++;
	}
	// clean for int part
  ivec2 step = calc_atoi(index, str);
  result = step.x();
  index = step.y();
  // clean for floating part
  if(str.charAt(index) == '.') {
    step = calc_atoi(index, str);
    float floating = step.x();
    while(floating > 1) {
      floating *= 0.1;
    }
    result += floating;
  }
	return (sign * result);
}





/**
primitive to byte, byte to primitive
v 0.1.0
*/
int int_from_byte(Byte b) {
	int result = b.intValue();
	return result;
}

public Boolean boolean_from_bytes(byte... array_byte) {
	if(array_byte.length == 1) {
		if(array_byte[0] == 0) return false ; return true;
	} else {
		Boolean null_data = null;
		return null_data;
	}
}

public Character char_from_bytes(byte [] array_byte) {
	if(array_byte.length == 2) {
		ByteBuffer buffer = ByteBuffer.wrap(array_byte);
		char result = buffer.getChar();
		return result;
	} else {
		Character null_data = null;
		return null_data;
	}
}

public Short short_from_bytes(byte [] array_byte) {
	if(array_byte.length == 2) {
		ByteBuffer buffer = ByteBuffer.wrap(array_byte);
		short result = buffer.getShort();
		return result;
	} else {
		Short null_data = null;
		return null_data;
	}
}

public Integer int_from_bytes(byte [] array_byte) {
	if(array_byte.length == 4) {
		ByteBuffer buffer = ByteBuffer.wrap(array_byte) ;
		int result = buffer.getInt();
		return result;
	} else {
		Integer null_data = null;
		return null_data;
	}
}

public Long long_from_bytes(byte [] array_byte) {
	if(array_byte.length == 8) {
		ByteBuffer buffer = ByteBuffer.wrap(array_byte) ;
		long result = buffer.getLong();
		return result;
	} else {
		Long null_data = null;
		return null_data;
	}
}

public Float float_from_bytes(byte [] array_byte) {
	if(array_byte.length == 4) {
		ByteBuffer buffer = ByteBuffer.wrap(array_byte) ;
		float result = buffer.getFloat();
		return result;
	} else {
		Float null_data = null;
		return null_data;
	}
}

public Double double_from_bytes(byte [] array_byte) {
	if(array_byte.length == 8) {
		ByteBuffer buffer = ByteBuffer.wrap(array_byte) ;
		double result = buffer.getDouble();
		return result;
	} else {
		Double null_data = null;
		return null_data;
	}
}



// @Deprecated // this method return a short because it's reordering by LITTLE_ENDIAN to used by getShort()
Integer int_from_4_bytes(byte [] array_byte, boolean little_endian) {
	if(array_byte.length == 4) {
		ByteBuffer buffer = ByteBuffer.wrap(array_byte);
		if(little_endian)buffer.order(ByteOrder.LITTLE_ENDIAN);
		int result = buffer.getShort();
		return result;
	} else {
		Integer null_data = null;
		return null_data;
	}
}



// return byte
byte[] to_byte(Object obj) {
	if(obj instanceof Boolean) {
		boolean value = (boolean)obj;
		byte [] array = new byte[1];
		array[0] = (byte)(value?1:0);
		return array;
	} else if(obj instanceof Character) {
		char value = (char)obj;
		return ByteBuffer.allocate(2).putChar(value).array();
	} else if(obj instanceof Short) {
		short value = (short)obj;
		return ByteBuffer.allocate(2).putShort(value).array();
	} else if(obj instanceof Integer) {
		int value = (int)obj;
		return ByteBuffer.allocate(4).putInt(value).array();
	} else if(obj instanceof Long) {
		long value = (long)obj;
		return ByteBuffer.allocate(8).putLong(value).array();
	} else if(obj instanceof Float) {
		float value = (float)obj;
		return ByteBuffer.allocate(4).putFloat(value).array();
	} else if(obj instanceof Double) {
		double value = (double)obj;
		return ByteBuffer.allocate(8).putDouble(value).array();
	} else return null;
}



/**
* from ivec, vec to PVector
*/
PVector to_PVector(Object obj) {
	if(obj instanceof vec || obj instanceof ivec) {
		if(obj instanceof vec) {
			vec v = (vec)obj;
			return new PVector(v.x,v.y,v.z);
		} else {
			ivec iv = (ivec)obj;
			return new PVector(iv.x,iv.y,iv.z);
		}
	} else {
		print_err("method to_Pvectro(): wait for Object of type vec or ivec");
		return null;
	}
}


/**
truncate a float argument
v 0.0.2
*/
float truncate(float x) {
		return round(x *100.0f) /100.0f;
}

float truncate(float x, int num) {
	float result = 0.0 ;
	switch(num) {
		case 0:
			result = round(x *1.0f) /1.0f;
			break;
		case 1:
			result = round(x *10.0f) /10.0f;
			break;
		case 2:
			result = round(x *100.0f) /100.0f;
			break;
		case 3:
			result = round(x *1000.0f) /1000.0f;
			break;
		case 4:
			result = round(x *10000.0f) /10000.0f;
			break;
		case 5:
			result = round(x *100000.0f) /100000.0f;
			break;
		default:
			result = x;
			break;
	}
	return result;
}

/**
Int to String
Float to String
v 0.0.3
*/
/*
@ return String
*/
String join_int_to_String(int []data) {
	String intString ;
	String [] dataString = new String [data.length] ;
	for ( int i = 0 ; i < data.length ; i++) dataString[i] = Integer.toString(data[i]) ;
	intString = join(dataString,"/") ;
	
	return intString ;
}

//float to String with array list
String join_float_to_String(float []data) {
	String floatString ;
	String [] dataString = new String [data.length] ;
	//for ( int i = 0 ; i < data.length ; i++) dataString[i] = Float.toString(data[i]) ;
	//we must use just one decimal after coma, to dodge the outBoundIndex blablabla
	for ( int i = 0 ; i < data.length ; i++) dataString[i] = String.format("%.1f" ,data[i]) ;
	floatString = join(dataString,"/") ;
	
	return floatString ;
}

//Translater to String
// float to String
String float_to_String_1(float data) {
	String float_string_value ;
	float_string_value = String.format("%.1f", data ) ;
	return float_String(float_string_value) ;
}
//
String float_to_String_2(float data) {
	String float_string_value ;
	float_string_value = String.format("%.2f", data ) ;
	return float_String(float_string_value) ;
}
//
String float_to_String_3(float data) {
	String float_string_value ;
	float_string_value = String.format("%.3f", data ) ;
	return float_String(float_string_value) ;
}

//
String float_to_String_4(float data) {
	String float_string_value ;
	float_string_value = String.format("%.4f", data ) ;
	return float_String(float_string_value) ;
}
// local
String float_String(String value) {
	if(value.contains(".")) {
		return value ;
	} else {
		String [] temp = split(value, ",") ;
		value = temp[0] +"." + temp[1] ;
		return value ;
	}
}


// int to String
String int_to_String(int data) {
	String float_string_value ;
	float_string_value = Integer.toString(data ) ;
	return float_string_value ;
}



/**
array float to vec
*/
vec4 array_to_vec4_rgba(float... f) {
	vec4 v = vec4(1);
	if(f.length == 1) {
		v.set(f[0],f[0],f[0],1.);
	} else if(f.length == 2) {
		v.set(f[0],f[0],f[0],f[1]);
	} else if(f.length == 3) {
		v.set(f[0],f[1],f[2],1);
	} else if(f.length > 3) {
		v.set(f[0],f[1],f[2],f[3]);
	}
	return v;
}





































/**
print
v 0.4.0
*/

/**
* System.out.println(r.ANSI_GREEN_BACKGROUND + "This text has a green background but default text!" + r.ANSI_RESET);
* System.out.println(r.ANSI_RED + "This text has red text but a default background!" + r.ANSI_RESET);
* System.out.println(r.ANSI_GREEN_BACKGROUND + r.ANSI_RED + "This text has a green background and red text!" + r.ANSI_RESET);
*/
void print_err(Object... obj) {
	System.err.println(write_message(obj));
	System.err.flush();
}

// print tempo
void print_err_tempo(int tempo, Object... obj) {
	if(System.currentTimeMillis()%tempo == 0) {
		String message = write_message(obj);
		System.err.println(message);
		System.err.flush();
	}
}

void print_tempo(int tempo, Object... obj) {
	if(System.currentTimeMillis()%tempo == 0) {
		String message = write_message(obj);
		println(message);
	}
}


void print_array_tempo(int tempo, Object[] obj) {
	if(System.currentTimeMillis()%tempo == 0) {
		printArray(obj);
	}
}

void print_array_tempo(int tempo, float[] arg) {
	if(System.currentTimeMillis()%tempo == 0) {
		printArray(arg);
	}
}

void print_array_tempo(int tempo, int[] arg) {
	if(System.currentTimeMillis()%tempo == 0) {
		printArray(arg);
	}
}

void print_array_tempo(int tempo, String[] arg) {
	if(System.currentTimeMillis()%tempo == 0) {
		printArray(arg);
	}
}



@Deprecated
void printErr(Object... obj) {
	System.err.println(write_message(obj));
}

// print tempo
@Deprecated
void printErrTempo(int tempo, Object... obj) {
	if(frameCount%tempo == 0 || frameCount <= 1) {
		String message = write_message(obj);
		System.err.println(message);
	}
}

@Deprecated
void printTempo(int tempo, Object... obj) {
	if(frameCount%tempo == 0 || frameCount <= 1) {
		String message = write_message(obj);
		println(message);
	}
}

@Deprecated
void printArrayTempo(int tempo, Object[] obj) {
	if(frameCount%tempo == 0 || frameCount <= 1) {
		printArray(obj);
	}
}

@Deprecated
void printArrayTempo(int tempo, float[] arg) {
	if(frameCount%tempo == 0 || frameCount <= 10) {
		printArray(arg);
	}
}

@Deprecated
void printArrayTempo(int tempo, int[] arg) {
	if(frameCount%tempo == 0 || frameCount <= 10) {
		printArray(arg);
	}
}

@Deprecated
void printArrayTempo(int tempo, String[] arg) {
	if(frameCount%tempo == 0 || frameCount <= 10) {
		printArray(arg);
	}
}











/**
MAP
map the value between the min and the max
@ return float
*/
float map_cycle(float value, float min, float max) {
	max += .000001 ;
	float newValue ;
	if(min < 0 && max >= 0 ) {
		float tempMax = max +abs(min) ;
		value += abs(min) ;
		float tempMin = 0 ;
		newValue =  tempMin +abs(value)%(tempMax - tempMin)  ;
		newValue -= abs(min) ;
		return newValue ;
	} else if ( min < 0 && max < 0) {
		newValue = abs(value)%(abs(max)+min) -max ;
		return newValue ;
	} else {
		newValue = min + abs(value)%(max - min) ;
		return newValue ;
	}
}




/*
map the value between the min and the max, but this value is lock between the min and the max
@ return float
*/
float map_locked(float value, float sourceMin, float sourceMax, float targetMin, float targetMax) {
	if(sourceMax >= targetMax ) sourceMax = targetMax ;
	if (value < sourceMin ) value = sourceMin ;
	if (value > sourceMax ) value = sourceMax ;
	float newMax = sourceMax - sourceMin ;
	float deltaTarget = targetMax - targetMin ;
	float ratio = ((value - sourceMin) / newMax ) ;
	float result = targetMin +deltaTarget *ratio;
	return result; 
}


// to map not linear, start the curve hardly to start slowly
float map_begin(float value, float sourceMin, float sourceMax, float targetMin, float targetMax, int level) {
	if (value < sourceMin ) value = sourceMin ;
	if (value > sourceMax ) value = sourceMax ;
	float newMax = sourceMax - sourceMin ;
	float deltaTarget = targetMax - targetMin ;
	float ratio = ((value - sourceMin) / newMax ) ;
	ratio = pow(ratio, level) ;
	float result = targetMin +deltaTarget *ratio;
	return result;
}

// to map not linear, start the curve hardly to finish slowly
float map_end(float value, float sourceMin, float sourceMax, float targetMin, float targetMax, int level) {
	if (value < sourceMin ) value = sourceMin ;
	if (value > sourceMax ) value = sourceMax ;
	float newMax = sourceMax - sourceMin ;
	float deltaTarget = targetMax - targetMin ;
	float ratio = ((value - sourceMin) / newMax ) ;
	ratio = pow(ratio, 1.0/level) ;
	float result = targetMin +deltaTarget *ratio;
	return result;
}

float map(float value, float start_1, float stop_1, float start_2, float stop_2, int begin, int end) {
	begin = abs(begin);
	end = abs(end);
	if(begin != 0 && end != 0) {
		if (value < start_1 ) value = start_1;
		if (value > stop_2 ) value = stop_2;

		float new_max = stop_2 - start_1;
		float delta = stop_2 - start_2;
		float ratio = (value - start_1) / new_max;

		ratio = map(ratio,0,1,-1,1);
		if (ratio < 0) {
			if(begin < 2) ratio = pow(ratio,begin) ;
			else ratio = pow(ratio,begin) *(-1);
			if(ratio > 0) ratio *= -1;
		} else {
			ratio = pow(ratio,end);
		}
		
		ratio = map(ratio,-1,1,0,1);
		float result = start_2 +delta *ratio;
		return result;
	} else if(begin == 0 && end != 0) {
		return map_end(value,start_1,stop_1,start_2,stop_2,end);
	} else if(end == 0 && begin != 0) {
		return map_begin(value,start_1,stop_1,start_2,stop_2,begin);
	} else {
		return map(value,start_1,stop_1,start_2,stop_2,1,1);
	}

}











/**
MISC
v 0.0.6
*/
/**
stop trhead draw by using loop and noLoop()
*/
boolean freeze_is ;
void freeze() {
	freeze_is = (freeze_is)? false:true ;
	if (freeze_is)  {
		noLoop();
	} else {
		loop();
	}
}








/**
PIXEL UTILS
v 0.0.3
*/
int [][] loadPixels_array_2D() {
	int [][] array_pix;
	loadPixels();
	array_pix = new int[height][width] ;
	int which_pix = 0;
	if(pixels != null) {
		for(int y = 0 ; y < height ; y++) {
			for(int x = 0 ; x < width ; x++) {
				which_pix = y *width +x ;
				array_pix[y][x] = pixels[which_pix] ;
			}
		}
	}
	if(array_pix != null) {
		return array_pix ;
	} else {
		return null ;
	}
}

































/**
CHECK
v 0.2.4
*/
/**
Check Type
v 0.0.4
*/
String get_type(Object obj) {
	if(obj instanceof Integer) {
		return "Integer";
	} else if(obj instanceof Float) {
		return "Float";
	} else if(obj instanceof String) {
		return "String";
	} else if(obj instanceof Double) {
		return "Double";
	} else if(obj instanceof Long) {
		return "Long";
	} else if(obj instanceof Short) {
		return "Short";
	} else if(obj instanceof Boolean) {
		return "Boolean";
	} else if(obj instanceof Byte) {
		return "Byte";
	} else if(obj instanceof Character) {
		return "Character";
	} else if(obj instanceof PVector) {
		return "PVector";
	} else if(obj instanceof vec) {
		return "vec";
	} else if(obj instanceof ivec) {
		return "ivec";
	} else if(obj instanceof bvec) {
		return "bvec";
	} else if(obj == null) {
		return "null";
	} else return "Unknow" ;
}







/**
* Check OS
* v 0.0.2
*/
String get_os() {
	return System.getProperty("os.name").toLowerCase();
}

String get_os_family() {
	String os = System.getProperty("os.name").toLowerCase();
	String family = "";
	if(os.indexOf("win") >= 0) {
		family = "win";
	} else if(os.indexOf("mac") >= 0) {
		family = "mac";
	} else if(os.indexOf("nix") >= 0 || os.indexOf("nux") >= 0 || os.indexOf("aix") >= 0) {
		family = "unix";
	} else if(os.indexOf("solaris") >= 0) {
		family = "solaris";
	}
	return family;
}



























/**
check value in range
*/
boolean in_range(float min, float max, float value) {
	if(value <= max && value >= min) {
		return true ; 
	} else {
		return false ;
	}
}

boolean in_range_wheel(float min, float max, float roof_max, float value) {
	if(value <= max && value >= min) {
		return true ;
	} else {
		// wheel value
		if(max > roof_max ) {
			// test hight value
			if(value <= (max - roof_max)) {
				return true ;
			} 
		} 
		if (min < 0) {
			// here it's + min 
			if(value >= (roof_max + min)) {
				return true ;
			} 
		} 
		return false ;
	}
}














































/**
STRING UTILS
v 0.3.3
*/
String write_message(Object... obj) {
	String mark = " ";
	return write_message_sep(mark,obj);
}
String write_message_sep(String mark, Object... obj) {
	String m = "";
	for(int i = 0 ; i < obj.length ; i++) {
		m += write_message(obj[i], obj.length,i,mark);
	}
	return m;
}

// local method
String write_message(Object obj, int length, int i, String mark) {
	String message = "";
	String add = "";
	if(i == length -1) { 
		if(obj == null) {
			add = "null";
		} else {
			add = obj.toString();
		}
		return message += add;
	} else {
		if(obj == null) {
			add = "null";
		} else {
			add = obj.toString();
		}
		return message += add + mark;
	}
}



//STRING SPLIT
String [] split_text(String str, String separator) {
	String [] text = str.split(separator) ;
	return text  ;
}


//STRING COMPARE LIST SORT
//raw compare
int longest_String(String[] string_list) {
	int finish = 0;
	if(string_list != null) finish = string_list.length;
	return longest_String(string_list, 0, finish);
}

//with starting and end keypoint in the String must be sort
int longest_String(String[] string_list, int start, int finish) {
	int length = 0;
	if(string_list != null) {
		for ( int i = start ; i < finish ; i++) {
			if (string_list[i].length() > length ) length = string_list[i].length() ;
		}
	}
	return length;
}

/**
Longuest String with PFont
*/
int longest_String_pixel(PFont font, String[] string_list) {
	int [] size_font = new int[1];
	size_font[0] = font.getSize();
	int finish = 0;
	if(string_list != null) finish = string_list.length;
	return longest_String_pixel(font.getName(), string_list, size_font, 0, finish);
}

int longest_String_pixel(PFont font, String[] string_list, int... size_font) {
	int finish = 0;
	if(string_list != null) finish = string_list.length;
	return longest_String_pixel(font.getName(), string_list, size_font, 0, finish);
}

int longest_String_pixel(PFont font, String[] string_list, int [] size_font, int start, int finish) {
	return longest_String_pixel(font.getName(), string_list, size_font, start, finish);
}

/**
Longuest String with String name Font
*/
int longest_String_pixel(String font_name, String[] string_list, int... size_font) {
	int finish = 0;
	if(string_list != null) finish = string_list.length;
	return longest_String_pixel(font_name, string_list, size_font, 0, finish);
}

// diferrent size by line
int longest_String_pixel(String font_name, String[] string_list, int size_font, int start, int finish) {
	int [] s_font = new int[1];
	s_font[0] = size_font;
	return longest_String_pixel(font_name, string_list, s_font, start, finish);
}

int longest_String_pixel(String font_name, String[] string_list, int [] size_font, int start, int finish) {
	int width_pix = 0 ;
	if(string_list != null) {
		int target_size_font = 0;
		for (int i = start ; i < finish && i < string_list.length; i++) {
			if(i >= size_font.length) target_size_font = 0 ;
			if (width_String(font_name, string_list[i], size_font[target_size_font]) > width_pix) {
				width_pix = width_String(string_list[i],size_font[target_size_font]);
			}
			target_size_font++;
		}
	}
	return width_pix;
}




/**
width String
*/
int width_String(String target, int size) {
	return width_String("defaultFont", target, size) ;
}

int width_String(PFont pfont, String target, int size) {
	return width_String(pfont.getName(), target, size);
}

int width_String(String font_name, String target, int size) {
	Font font = new Font(font_name, Font.BOLD, size) ;
	BufferedImage img = new BufferedImage(1, 1, BufferedImage.TYPE_INT_ARGB);
	FontMetrics fm = img.getGraphics().getFontMetrics(font);
	if(target == null) {
		target = "";
	}
	return fm.stringWidth(target);
}




int width_char(char target, int size) {
	return width_char("defaultFont", target, size) ;
}

int width_char(PFont pfont, char target, int size) {
	return width_char(pfont.getName(), target, size);
}
int width_char(String font_name, char target, int size) {
	Font font = new Font(font_name, Font.BOLD, size) ;
	BufferedImage img = new BufferedImage(1, 1, BufferedImage.TYPE_INT_ARGB);
	FontMetrics fm = img.getGraphics().getFontMetrics(font);
	return fm.charWidth(target);
}




// Research a specific word in String
boolean research_in_String(String research, String target) {
	boolean result = false ;
	for(int i = 0 ; i < target.length() - research.length() +1; i++) {
		result = target.regionMatches(i,research,0,research.length()) ;
		if (result) break ;
	}
	return result ;
}





/**
String file utils
2014-2021
v 0.2.4
*/
/**
* remove element of the sketch path
*/
String sketchPath(int minus) {
	minus = abs(minus);
	String [] element = split(sketchPath(),"/");
	String new_path ="" ;
	if(minus < element.length ) {
		for(int i = 0 ; i < element.length -minus ; i++) {
			new_path +="/";
			new_path +=element[i];
		}
		return new_path; 
	} else {
		print_err("The number of path elements is lower that elements must be remove, instead a data folder is used");
		return sketchPath()+"/data";
	}  
}



// remove the path of your file
String file_name(String file_path) {
	String file_name = "" ;
	String [] split_path = file_path.split("/") ;
	file_name = split_path[split_path.length -1] ;
	return file_name ;
}

/**
* work around extension
*/
String extension(String filename) {
	if(filename != null) {
		filename = filename.toLowerCase();
		if(filename.contains(".")) {
			return filename.substring(filename.lastIndexOf(".") + 1, filename.length());
		} else {
			return null;
		} 
	} else {
		return null;
	}
}

boolean extension_is(String path, String... data) {
	boolean is = false;
	if(data.length >= 1) {
		String extension_to_compare = extension(path.toLowerCase());
		if(extension_to_compare != null) {
			for(int i = 0 ; i < data.length ; i++) {
				if(extension_to_compare.equals(data[i].toLowerCase())) {
					is = true;
					break;
				} else {
					is = false;
				}
			}
		} else {
			print_err("method extension_is(): [",path.toLowerCase(),"] this path don't have any extension");
		}
	} else {
		print_err("method extension_is() need almost two components, the first is the path and the next is extension");
	}
	return is;
}
