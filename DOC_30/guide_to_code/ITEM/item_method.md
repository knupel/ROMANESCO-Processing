ROMANESC0 1.2.0.30
ITEM
ROMANESCO PROCESSING ENVIRONMENT
--
METHODS
--





IMPORTANT
--
there is TWO MAINS VOID in class ROMANESCO like PROCESSING
--
void setup()
--
void draw()
--
if you use other void you must call this one in one of them








---



SETTING
--
void setting_start_direction(int ID_item, Vec2 dir) ;

void setting_start_direction(int ID_item, int dir_x, int dir_y) ;

void setting_start_position(int ID_item, Vec3 pos) ;

void setting_start_position(int ID_item, int pos_x, int pos_y, int pos_z) ;

boolean setting[int ID_item]
> to block the setting at the beggining and when you come back to the button setting to don't go immediatly on the value slider...not finish in progress




GET
--
Vec3 get_pos_item(int id_item) ;

Vec3 get_dir_item(int id_item) ;



MODE ASPECT COSTUME
--
Basic RPE_mode = "Point/Ellipse/Triangle/Rectangle/Cross/Simple Star/Star/Super Star" ;
--
int select_costume_via_mode(int ID, int max_mode) ;
>method can be used to simply the acces to set the var costume[ID_item], this method set the var with a global variable used by the method costume_rope()
>You can use the return var to have the int ID of the selected costume, if the mode[ID_item] is upper of max_mode the method return a value equal to MAX_INT

>int ID, is the ID of your item

>int max_mode, if mode[ID_item] is upper of this value the method return MAX_INT value

>set int costume[ID_item], work with the boolean dimension[ID_item] and the mode[ID_item], it's a default mode setting

>it good to use this method in relation with the method costume_rope()

dimension[ID_item] == true and mode[Id_item] = 0, 1, 2...
>costume[ID_item] == POINT_ROPE, ELLIPSE_ROPE, TRIANGLE_ROPE, RECT_ROPE, CROSS_2_ROPE, STAR_4, STAR_5, STAR_8

dimension[ID_item] == false and mode[Id_item] = 0, 1, 2...
>costume[ID_item] == SPHERE_LOW_ROPE, SPHERE_MEDIUM_ROPE, TETRAHEDRON_ROPE, BOX_ROPE, CROSS_3_ROPE, SUPER_STAR_8_ROPE, SUPER_STAR_12_ROPE, SUPER_STAR_12_ROPE ;


Aspect
--
void aspect_romanesco(int ID_item) 
> change the fill, stroke and strokeWeight og your item, the reason why you need send the ID arg


void aspect_romanesco(int ID, int which_costume) ;
>it's good to use this method in case the costume is a POINT or a LINE














COMMAND  / BOOLEAN method
------------------------------------------
reset(ID_item) 
> from keyboard "BACKSPACE" and "DELETE"
> CONDITION 1 : if the button "BACKSPACE" is pressed and "ACTION" or "PARAMETER" and is ON
> CONDITION 2 : if the button "DELETE" is pressed






SETTING
--










RESET OBJECT : empty the object list
––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
To empty the list or reset object activate by backspace and delete
boolean resetAction(ID_item) when the Action button is On

boolean resetParameter(int ID_item) 
> when the Parameter button is On, Suggestion use Action Button for the particle and the list and Parameter for the other reset. But it's just a suggestion









DISPLAY INFO on SCENE
–––––––––––––––––––––––––––––––––––––––––––––––––––––––––
boolean objectInfoDisplay[ID_item] use to display info or what you want show on Prescene or Scene from your object, activate by "i" key - boolean iTouch

String objectName[ID_item] return the name of your object

String objectInfo[ID_item]  can be use to add info who can be display in the info option when you push "i" on the prescene

int objectID[ID_item] return the ID of the object









CAMERA RPE / P3D / INTERNAL CAMERA
––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
travelling(PVector targetPos) ; // the camera go to a specific point in the scene










CAMERA COMPUTER / WEB CAM / EXTERNAL CAMERA
----------------------------------------------
You can call the video capture directly, you don't need to write code about the librairy.
you can use directly the Capture methode of the processing.video.*

In the description of the object write 
romanescoVideo = "YES" ;

PVector CAM_SIZE ; @return the width and the height of the current video capture
boolean CAMERA_AVAILABLE ; #return the statement of the device camera

String[] cam_name ; @return the name of all the camera available
PVector[] cam_size ; @return the size of all the camera available
int[] cam_fps ; @return the fps of all the camera available
int which_cam ; @return the ID of the current camera

