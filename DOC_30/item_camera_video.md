ROMANESC0 1.2.0.30
ITEM
ROMANESCO PROCESSING ENVIRONMENT
--
CAMERA COMPUTER / WEB CAM / EXTERNAL CAMERA
--
You can call the video capture directly, you don't need to write code about the librairy.
you can use directly the Capture methode of the processing.video.*
the componant is used to that is "cam"

void video_camera_manager() ;
> method must used in the item draw() method, it's necessary to start the broadcast.


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