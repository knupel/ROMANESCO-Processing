*MEDIA IMPORT



text
--
String text_import[ID_item] ;
>see chapter 'item_import_text.md'

bitmap
--
PImage bitmap_import[ID_item] ;
>see chapter 'item_import_bitemp.md'

svg
--
RPEsvg svg_import[ID_item] ;
>see chapter 'item_import_svg.md'

movie
--
Movie movie_import[ID_item] ;
>see chapter 'item_import_movie.md'


*IMPORT MOVIE

Method to load and use movie.mov, from the dropdown menu of the controller

You can use only the file.mov or file.MOV

your object Movie is : movie_import[ID_item]

boolean check_for_new_movie(int id) ;
>check if there is a new movie selected from the Controller


classic_movie(int id, int place, boolean full_width, boolean full_height)
>set your movie for a classing displaying


void load_movie(int ID_item) ;
setting_movie(int ID_item) ;
> this method is used to lod and read your .mov in the setting() 


void read_movie(boolean pause, int id_item) ;
>use to read or pause your movie, by default the movie is on pause at beggining.


*IMPORT SVG


Method to load and use svg, from the dropdown menu of the controller

load_svg(ID_item) ;
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


IMPORT TEXT
--
Romanesco call fileText.txt from the folder Karaoke from the preferences folder,
so you can write on it when you use Romanesco split function
"*" to separate the chapter 
"/" to separate the sentence

** When you code take a care to save the karaoke.txt in each folder of dev (Scene, Prescene, Mirroir) **




// OBJECT METHOD or PARAMETER

load_txt(ID_item) use to load and update the text

String text_import[ID_item] raw text selected from the folder preferences/Karaoke

int numChapters(String text_import[ID_item]) give the number of the chapter of your raw text




// GENERAL METHOD or PARAMETER

textPath[which_text] ; text from the dropdown menu

int numMaxSentencesByChapter(String text_import[ID_item]) give the number of sentences of the chapter have the most sentences

String whichSentence(String txt, int whichChapter, int whichSentence) return String





