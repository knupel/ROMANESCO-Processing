*Interactivity


POINTER XYZ
--
Vec3 mouse[ID_item] refresh with space touch
mouse[0].x // mouse[0].y // absolute position of the mouse
mouse[0].z // return info from the z axis when the leapmotion is active
mouse[ID_item].x // mouse[ID_item].y // mouse[ID_item].z // same info than mouse[0] but this one is refresh when you press the space



MOUSE WHEEL
--
int wheel[ID_item]
wheel[0] and wheel[ID_item]
or use the void zoom() and take the float value getCountZoom...this value is more reactive !




PEN 
--
>Pen is disable for this time the value default is used
--
Vec3 pen[ID_item] or pen[0] refresh with space touch

pen[ID_item].x 
>return float around -1, 1 / information from the tablet tilt : orientation of the pen 

pen[ID_item].y 
>return float around -1, 1 / information from the tablet tilt : orientation of the pen 

pen[ID_item].z 
> value to 0 to 1 / information from tablet : pressure pen 

defaults value
--
pen[Ø].x = 0 ; 
>tilt x

pen[Ø].y = 0 ; 
>tilt y

pen[Ø].z = .02 ; 
>pressure






MOUSE CLICK BOOLEAN
--
Short click just for one shot
--
boolean clickShortLeft[ID_item] ;

boolean clickShortRight[ID_item] ;


Active after one mousePressed, be inactive after the mouse Released
--
boolean clickLongLeft[ID_item] ;

boolean clickLongLeft[ID_item] ;