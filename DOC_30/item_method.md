ROMANESC0 1.2.0.30
ITEM
ROMANESCO PROCESSING ENVIRONMENT
--
METHOD
--
void setup()
--
void draw()
--
if you use other void you must call this one in one of them




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
You must use a coorect spelling to write:

costume 1
>"point" "POINT" "Point"

costume 2
>"ellipse" "ELLIPSE" "Ellipse" "disc" "DISC" "Disc")

costume 3
>"triangle" "TRIANGLE""Triangle")

costume 4
>"rectangle" "RECTANGLE" "Rectangle" "rect" "RECT" "Rect"

costume 5
>"cross" "CROSS" "Cross"

costume 6
>"star 4" "STAR 4" "Star 4"

costume 7
>"star 5" "STAR 5" "Star 5"

costume 8
>"star 6" "STAR 6" "Star 6"

costume 9
>"star 7" "STAR 7" "Star 7"

costume 10
>"star 8" "STAR 8" "Star 8"

costume 11
>"super star 8" "SUPER STAR 8" "Super Star 8"

costume 12
>"super star 12" "SUPER STAR 12" "Super Star 12"

costume 13
>"ABC" "abc" "Abc"

--
void select_costume(int ID_item, String RPE_name) ;
>method can be used to simply the acces to set the var costume[ID_item], this method set the var with a global variable used by the method costume_rope()
>You can use the return var to have the int ID of the selected costume, if the mode[ID_item] is upper of max_mode the method return a value equal to MAX_INT

>int ID, is the ID of your item

>String RPE_name, to help the algo find the good item :)

>set int costume[ID_item], work with the boolean dimension[ID_item] and the mode[ID_item], it's a default mode setting

>it good to use this method in relation with the method costume_rope()

dimension[ID_item] 
swith costume from 2D to 3D,
POINT > SPHERE_LOW
ELLIPSE > SPHERE_MEDIUM
TRIANGLE > TETRAHEDRON
RECT > BOX
CROSS 2D > CROSS 3D

the other mode don't use a 3D costume in this time, but the future is not write !












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




