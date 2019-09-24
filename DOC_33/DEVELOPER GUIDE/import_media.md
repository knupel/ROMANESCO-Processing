*
* DEVOLOPER MEDIA IMPORT
* Romanesco dui 
* 2013-2019
* v 2.1.0.33
* Processing 3.5.3
* Rope Library 0.5.1
* 


*text

--
String text_import[ID_item] ;
>see chapter 'item_import_text.md'

boolean load_text();
> return true if any media is available

*bitmap

PImage bitmap_import[ID_item] ;
>see chapter 'item_import_bitemp.md'

boolean load_bipnap();
>update bitmap and return true if any media is available.

*SVG


RPEsvg svg_import[ID_item] ;
>see chapter 'item_import_svg.md'

movie
--
Movie movie_import[ID_item] ;
>see chapter 'item_import_movie.md'

boolean load_svg();
> update svg / shape and return true if any media is available


*IMPORT MOVIE

Method to load and use movie.mov, from the dropdown menu of the controller

You can use only the file.mov or file.MOV

your object Movie is : movie_import[ID_item]

boolean check_for_new_movie(int id) ;
>check if there is a new movie selected from the Controller

classic_movie(int id, int place, boolean full_width, boolean full_height)
>set your movie for a classing displaying

boolean load_movie();
> update movie and return true if any media is available

setting_movie(int ID_item) ;
> this method is used to load and read your .mov in the setting() 


void read_movie(boolean pause, int id_item) ;
>use to read or pause your movie, by default the movie is on pause at beggining.


*IMPORT SVG

Method to load and use svg, from the dropdown menu of the controller

load_svg() ;
> this method can be used in the setting() or in the display()

the common use is like this, in association with the button parameter of the item selected menu

void setup() {
	if(parameter[ID_item]) {
      load_svg(ID_item) ;
      svg_import[ID_item].build(svg_current_path, svg_bricks_saved) ;
      svg_import[ID_item].svg_mode(CENTER) ;
   }
   .../...
}




*IMPORT TEXT

boolean load_text();
> update text file and return true if any text array file is available

String [] get_text();
> return the String array who match with item.









