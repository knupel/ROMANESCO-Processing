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







RPE METHODE for item
-----------------------------

ASPECT
--
void aspect_rpe(int ID_item) 
> change the fill, stroke and strokeWeight og your item, the reason why you need send the ID arg


SETTING 
--
void setting_start_direction(int ID_item, Vec2 dir) ;
void setting_start_direction(int ID_item, int dir_x, int dir_y)

void setting_start_position(int ID_item, Vec3 pos)
void setting_start_position(int ID_item, int pos_x, int pos_y, int pos_z)








COMMAND  / BOOLEAN method
------------------------------------------
reset(ID_item) 
> from keyboard "BACKSPACE" and "DELETE"
> CONDITION 1 : if the button "BACKSPACE" is pressed and "ACTION" or "PARAMETER" and is ON
> CONDITION 2 : if the button "DELETE" is pressed






--
MOTION
––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
boolean motion[int ID_item] boolean use for the move activate or desactivate by the "m" key - booleann mTouch - 


ALIGNEMENT
––––––––––––––––––––––––––––––––––––––––––––––––––––––––
boolean horizon[int ID_item] boolean use for the move activate or desactivate by the "h" key - booleann hTouch -


REVERSE DIRECTION
–––––––––––––––––––––––––––––––––––––––––––––––––––––––––
boolean reverse[int ID_item] use to reverse direction or what you want, activa by "r" key - boolean rTouch -


SETTING
--
boolean setting[int ID_item] to block the setting at the beggining and when you come back to the button setting to don't go immediatly on the value slider...not finish in progress









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

