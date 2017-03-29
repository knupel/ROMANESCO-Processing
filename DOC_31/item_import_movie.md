ROMANESC0 1.2.0.30
ITEM
ROMANESCO PROCESSING ENVIRONMENT 
--
IMPORT MOVIE
--
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


