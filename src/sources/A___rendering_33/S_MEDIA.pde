/*
* MANAGE MEDIA
* v 1.2.3
* 2016-2021
*/
import rope.image.R_Image_Manager;


void media_init_collection() {
	update_movie_collection();
	update_svg_collection();
	update_text_collection();
	update_bitmap_collection();
}
void media_update(int frequence) {
	if(frameCount%frequence == 0) {
		update_movie_collection();
		update_svg_collection();
		update_text_collection();
		update_bitmap_collection();
		clear_all_medias();
		thread("load_autosave");
	}
}


void change_media(int which [], int id, String [] path){
	which[id] = pad_inc(which[id],UP);
	which[id] = pad_inc(which[id],DOWN);
	which[id] = pad_inc(which[id],RIGHT);
	which[id] = pad_inc(which[id],LEFT);

	if(which[id] < 0) {
		which[id] = path.length -1;
	} else if (which_movie[id] >= path.length) {
		which[id] = 0;
	}
}





/**
svg
*/
R_SVG[] svg_import;
String svg_current_path;
String [] svg_path;
boolean load_svg_id(int id) {
	// which_bitmap is the int return from the dropdown menu
	if(which_shape[id] > svg_path.length ) {
		which_shape[id] = 0;
		return true;
	}

	if(svg_path != null && svg_path.length > 0 && which_shape[id] < svg_path.length && svg_path[which_shape[id]] != null) {
		svg_current_path = svg_path[which_shape[id]];
		if(!svg_current_path.equals(svg_path_ref[id])) {
			svg_import[id] = new R_SVG(this, svg_current_path, "bricks");
		}
		svg_path_ref[id] = svg_current_path;
		return true;
	} else {
		return false;
	}
}

void update_svg_collection() {
	svg_path = new String[svg_files.size()];
	for (int i = 0; i < svg_files.size(); i++) {
		File f = (File) svg_files.get(i);
		if(f.exists()) {
			svg_path[i] = f.getAbsolutePath();
		}   
	}
}

void change_svg_from_pad(int id) {
	change_media(which_shape, id, svg_path);
}





/**
text
*/
String [][] text_import;
String [] text_path;
boolean load_text_id(int id) {
	// which_text is the int return from the dropdown menu
	if(text_path != null && text_path.length > 0 && which_text[id] < text_path.length && text_path[which_text[id]] != null) {
		if(which_text[id] > text_path.length ) which_text[id] = 0;
		text_import[id] = import_text(text_path[which_text[id]]);
		return true;
	} else {
		return false;
	}    
}


void update_text_collection() {
	text_path = new String[text_files.size()];
	for (int i = 0; i < text_files.size(); i++) {
		File f = (File) text_files.get(i);
		if(f.exists()) {
			text_path[i] = f.getAbsolutePath();
		}   
	}
}

void change_text_from_pad(int id) {
	change_media(which_text, id, text_path);
}

String [] import_text(String path) {
	return  loadStrings(path) ;
}










/**
* bitmap
*/


R_Image_Manager r_img_collection;
PImage[] bitmap;
String [] bitmap_path ;
boolean load_bitmap_id(int id) {
	if(which_bitmap[id] > bitmap_path.length) {
		which_bitmap[id] = 0;
		return true;
	}
	if(bitmap_path != null && bitmap_path.length > 0 && which_bitmap[id] < bitmap_path.length && bitmap_path[which_bitmap[id]] != null) {
		String bitmap_current_path = bitmap_path[which_bitmap[id]];
		if(!bitmap_current_path.equals(bitmap_path_ref[id])) {
			bitmap[id] = loadImage(bitmap_current_path);
		}
		bitmap_path_ref[id] = bitmap_current_path;
		return true;
	} else {
		return false;
	}
}

void update_bitmap_collection() {
	// manage img path
	bitmap_path = new String[bitmap_files.size()];
	int count_existing_file = 0;
	for (int i = 0; i < bitmap_files.size(); i++) {
		File f = (File) bitmap_files.get(i);
		if(f.exists()) {
			bitmap_path[i] = f.getAbsolutePath();
			count_existing_file++;
		}   
	}
	// update collection
	if(r_img_collection == null) {
		r_img_collection = new R_Image_Manager(this);
	}

	if(r_img_collection.size() != count_existing_file) {
		r_img_collection.clear();
		for(int i = 0 ; i < bitmap_path.length; i++) {
			if(bitmap_path[i] != null && extension_is(bitmap_path[i],extension_bitmap)) {
				r_img_collection.load(bitmap_path[i]);
			}
		}
	}
}

R_Image_Manager get_bitmap_collection() {
	return r_img_collection;
}


void change_bitmap_from_pad(int id) {
	change_media(which_bitmap, id, bitmap_path);
}






/**
movie 
*/
boolean load_movie_id(boolean change_movie_is, int id) {
	boolean new_movie_is = check_for_new_movie();
	if(movie_path.length > 0 && which_movie[id] < movie_path.length && (new_movie_is || change_movie_is)) {
		setting_movie(id,movie_path[which_movie[id]]);
		return true;
	} else {
		return false;
	}
}


void change_movie_from_pad(int id) {
	change_media(which_movie, id, movie_path);
}









float [] movie_time;
String [] movie_path;
String [] movie_path_ref;
boolean check_for_new_movie() {
	boolean new_movie_is = false;
	if(movie_path_ref == null || movie_path_ref.length != movie_path.length) {
		new_movie_is = true;
		movie_path_ref = new String[movie_path.length];
		movie_time = new float[movie_path.length];
	}
	
	// in case there a same quantity of ref we must check if the path ref is the same
	if(!new_movie_is)
	for(int i = 0 ; i < movie_files.size() ; i++) {
		try {
			new_movie_is = !movie_path_ref[i].equals(movie_path[i]);
		}
		catch (ArrayIndexOutOfBoundsException e) {
			printErrTempo(60,"boolean check_for_new_movie() catch: ArrayIndexOutOfBoundsException");

		}
		catch(Exception e){
				printErrTempo(60,"boolean check_for_new_movie() catch: Some Other exception");
		 }
		
		if(new_movie_is) {
			break;
		}
	}

	// in case there is a new movie make a new ref path
	if(new_movie_is) {
		for(int i = 0 ; i < movie_path_ref.length && i < movie_files.size() ; i++) {
			movie_path_ref[i] = movie_path[i];
		}
	}
	return new_movie_is;
}


void update_movie_collection() {
	if(movie_path == null || movie_path.length != movie_files.size()) {
		movie_path = new String[movie_files.size()] ;
	}
	for (int i = 0; i < movie_files.size(); i++) {
		File f = (File) movie_files.get(i);
		if(f.exists()) {
			movie_path[i] = f.getAbsolutePath();
		}   
	}
}


// Movie Manager
void setting_movie(int id, String path) {
	if(movie[id] != null) {
		movie[id].stop();
	}
	if(extension_is(path,extension_movie)){
	// if(ext(path,"mov") || ext(path,"MOV") || ext(path,"avi") || ext(path,"AVI") || ext(path,"mp4") || ext(path,"MP4") || ext(path,"mkv") || ext(path,"MKV")) {
		println(path);
		movie[id] = new Movie(this,path);
		movie[id].loop();
		movie[id].pause();
	} else {
		printErrTempo(240,"ROMANESCO don't find the movie:",id,path);
	}
}

void movieEvent(Movie m) {
	m.read(); 
}




















