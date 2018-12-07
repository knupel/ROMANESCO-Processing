ROMANESC0 1.2.1.31
2015_2018
ROMANESCO PROCESSING ENVIRONMENT

*CAMERA COMPUTER / WEB CAM / EXTERNAL CAMERA

You can call the video capture directly, you don't need to write code about the librairy.
you can use directly the Capture methode of the processing.video.*
the componant is used to that is "cam"


*INIT

void video_camera_manager();
>this method must use in priority before other method
>method must used in the item draw() method, it's necessary to start the broadcast.


void select_camera(int target)
>select web cam in the list of camera connected to your system



Capture get_cam();
>return available camera

iVec2 [] get_cam_size()
>return the array_list iVec2 size: width and height of available web cam

String [] get_cam_name()
>return the list name of available web cam on your system



int [] get_cam_fps()
>return the fps of each web cam available on your system


boolean BROADCAST
>used to check if there is any recording at this time

boolean CAMERA_AVAILABLE ;
>return the statement of the device camera

cam.available() ;
> like boolean BROADCAST

int cam.width ;
>return width of your recording

int cam.height ;
>return height of your recording

int cam.pixels.length
>return pixel quantity of your recording

int cam.pixels[int which_pixel] 
>retunr the int color of a specific pixel if this one exist

String[] cam_name ;
>return the name of all the camera available

PVector[] cam_size ; 
>return the size of all the camera available

int[] cam_fps ; 
>return the fps of all the camera available

int which_cam ; 
>return the ID of the current camera