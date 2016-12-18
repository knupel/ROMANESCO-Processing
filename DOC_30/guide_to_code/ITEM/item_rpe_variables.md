ROMANESC0 1.2.0.30
ITEM
ROMANESCO PROCESSING ENVIRONMENT 
--
VARIABLES
--


BUTTON
––––––
mode[ID_item] 
@return int the number of the displaying mode start from '0'

action[ID_item] 
@return boolean / we use this one for the mouse move + vTouch in Romanesco application

sound[ID_item] 
@return boolean 

parameter[ID_item] 
@return boolean 



BOOLEAN
--
birth[ID_item] > from keyboard "N"

horizon[ID_item] > from keyboard "H"

motion[ID_item] > from keyboard "M"

orbit[ID_item] > from keyboard "O"

reverse[ID_item] > from keyboard "R"

special[ID_item] > from keyboard "K"




VARIABLE NAME
--
RPE_slider = "all" 

or choice in the list bellow, the case is very important, no "space" after or before the word. The word must be separate by a comma

"Fill hue,Fill sat,Fill bright,Fill alpha,
Stroke hue,Stroke sat,Stroke bright,Stroke alpha,
Thickness,
Size X,Size Y,Size Z,
Font size,
Canvas X,Canvas Y,Canvas Z,
Reactivity,
Speed X,Speed Y,Speed Z,
Spurt X,Spurt Y,Spurt Z,
Direction X,Direction Y,Direction Z,
Jitter X,Jitter Y,Jitter Z,
Swing X,Swing Y,Swing Z,
Quantity,Variety,
Life,Flow,Quality,
Area,Angle,Scope,Scan,
Alignment,Repulsion,Attraction,Charge – +,
Influence,Calm,Need"






ITEM SLIDER VALUE
-----------------

float value from silder controller, use with the ID of your item
––––––––––––––––––––––-------------------------------------------
PHI value aroud (1 + sqrt(5))/2 = 1.618034

hue(fill_item[ID_item]) ; @return float value 0, 360.0

saturation(fill_item[ID_item]) ; @return float value 0, 100.0

brightness(fill_item[ID_item]) ;  @return float value 0, 100.0

alpha(fill_item[ID_item])  ; @return float value 0, 100.0

> fill_item[ID_item] = @return int arg color

hue(stroke_item[ID_item]) ; @return float value 0, 360.0

saturation(stroke_item[ID_item]) ; @return float value 0, 100.0

brightness(stroke_item[ID_item]) ; @return float value 0, 100.0

alpha(stroke_item[ID_item]) ; @return float value 0,100.0

> stroke_item[ID_item] = @return int arg color

thickness_item[ID_item] @return float value 0.1, height/3

size_x_item[ID_item] ; @return float value (float)width *.05, width

size_y_item[ID_item] ;  @return float value (float)width *.05, width

size_z_item[ID_item]  ; @return float value (float)width *.05, width

font_size_item[ID_item]  ; @return float value (float)height *.025,height;

canvas_x_item[ID_item]  ; @return float value (float)width *.1, (float)width *PHI

canvas_y_item[ID_item]  ; @return float value (float)width *.1, (float)width *PHI

canvas_z_item[ID_item]  ; @return float value (float)width *.1, (float)width *PHI

reactivity_item[[ID_item]  ; @return float value 0, 1

speed_x_item[ID_item] ; @return float value 0, 1

speed_y_item[ID_item] ; @return float value 0, 1

speed_z_item[ID_item] ; @return float value 0, 1

spurt_x_item[ID_item] ; @return float value 0, 1

spurt_y_item[ID_item] ; @return float value 0, 1

spurt_z_item[ID_item] ; @return float value 0, 1

dir_x_item[ID_item] ; @return float value 0, 1

dir_y_item[ID_item] ; @return float value 0, 1

dir_z_item[ID_item] ; @return float value 0, 1

jitter_x_item[ID_item] ; @return float value 0, 1

jitter_y_item[ID_item] ; @return float value 0, 1

jitter_z_item[ID_item] ; @return float value 0, 1

swing_x_item[ID_item] ; @return float value 0, 1

swing_y_item[ID_item] ; @return float value 0, 1

swing_z_item[ID_item] ; @return float value 0, 1

quantity_item[ID_item]  ; @return float value 0, 1

variety_item[ID_item]  ; @return float value 0, 1

life_item[ID_item]  ; @return float value 0, 1

flow_item[ID_item]  ; @return float value 0, 1

quality_item[ID_item] ; @return float value 0, 1

area_item[ID_item]  ; @return loat value (float)width *.1, (float)width *PHI

angle_item[ID_item]  ; @return float value 0, 360.0

scope_item[ID_item]  ; @return loat value (float)width *.1, (float)width *PHI

scan_item[ID_item]  ; @return float value 0, 360.0 

alignment_item[ID_item] ; @return float value 0, 1

repulsion_item[ID_item] ; @return float value 0, 1

attraction_item[ID_item] ; @return float value 0, 1

charge_item[ID_item] ; @return float value 0, 1

influence_item[ID_item] ; @return float value 0, 1

calm_item[ID_item] ; @return float value 0, 1

need_item[ID_item] ; @return float value 0, 1



Min max value of the slider in Vec2
--------------------------------------
fill_hue_min_max >>> 0,360

fill_sat_min_max, fill_bright_min_max, fill_alpha_min_max >>> 0, color max of your environment

stroke_hue_min_max >>> 0,360

stroke_sat_min_max, stroke_bright_min_max, stroke_alpha_min_max >>> 0, color max of your environment

thickness_min_max >>> 0.1, height*.33

size_x_min_max, size_y_min_max, size_z_min_max >>> width *min_size, width

font_size_min_max >>> eight *.005, height *.05

canvas_x_min_max, canvas_y_min_max, canvas_z_min_max >>> width *min_size, width

reactivity_min_max >>> 0,1

speed_x_min_max, speed_y_min_max, speed_z_min_max >>> 0,1

spurt_x_min_max,spurt_y_min_max, spurt_z_min_max  >>> 0,1

dir_x_min_max, dir_y_min_max, dir_z_min_max >>> 0,360

jitter_x_min_max, jitter_y_min_max, jitter_z_min_max >>> 0,1

swing_x_min_max, swing_y_min_max, swing_z_min_max >>> 0,1

quantity_min_max >>> 0,1

variety_min_max >>> 0,1

life_min_max >>> 0,1

flow_min_max >>> 0,1 

quality_min_max >>> 0,1

area_min_max >>> width *min_size, width

angle_min_max >>> 0,360

scope_min_max >>> width *min_size, width

scan_min_max >>> 0,360

alignment_min_max >>> 0,1 

repulsion_min_max >>> 0,1 

attraction_min_max >>> 0,1

charge_min_max >>> 0,1

influence_min_max >>> 0,1 

calm_min_max >>> 0,1 

need_min_max >>> 0,1







sound
-----------

VOLUME
--
left[ID_item]  @return float value 0 > 1 / 1 when it's the sound is off

right[ID_item] @return float value 0 > 1 / 1 when it's the sound is off

mix[ID_item]   @return float value 0 > 1 / 1 when it's the sound is off

BEAT
--
beat[ID_item] @return float value 1 > 3 / last value when the sound is off

kick[ID_item] @return float value 1 > 3 / last value when the sound is off

snare[ID_item] @return float value 1 > 3 / last value when the sound is off

hat[ID_item]   @return float value 1 > 3 / last value when the sound is off

allBeats(ID_item) @return float value 1 > 12 / last value when the sound is off
??????????????????????????
????? it's weird because normally the value return must be between 1 to 10 for single value and 1 to 40 for the sum 

TEMPO
--
tempo[ID_item] @return float value 0 > 1 / 1 when it's the sound is off

tempoBeat[ID_item]  @return float value 0 > 1 / 1 when it's the sound is off

tempoKick[ID_item]  @return float value 0 > 1 / 1 when it's the sound is off

tempoSnare[ID_item] @return float value 0 > 1 / 1 when it's the sound is off

tempoHat[ID_item]   @return float value 0 > 1 / 1 when it's the sound is off

TRACK
--
boolean SOUND_PLAY ; return if there is sound play

float getTimeTrack()  if the track is ON return the time elapse from the beginning play to now, if the track is OFF return value < 0.2

BAND / SPECTRUM
--
float band [ID_item][whichBand] // whichBand give the information of the band where catch the info
usualy there is 16 bands, to know the number :
bandSpectrum.length ;









COORD ITEM 
-----------
Vec3 pos_item_final[ID_item]

Vec2 dir_item_final[ID_item]

COORD ITEM REF
--
Vec3 item_setting_position[0][ID_item] @ return original position

Vec2 item_setting_direction[0][ID_item] @ return original orientation









COMMON EXTERNAL DEVICE
––––––––––––––––––––––––––––––––––––––
VAR from the mouse, pen and leapmotion







POINTER XYZ
––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
Vec3 mouse[ID_item] refresh with space touch
mouse[0].x // mouse[0].y // absolute position of the mouse
mouse[0].z // return info from the z axis when the leapmotion is active
mouse[ID_item].x // mouse[ID_item].y // mouse[ID_item].z // same info than mouse[0] but this one is refresh when you press the space






MOUSE WHEEL
––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
int wheel[ID_item]
wheel[0] and wheel[ID_item]
or use the void zoom() and take the float value getCountZoom...this value is more reactive !









PMOUSE disable
––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
PVector pmouse[ID_item]
pmouse[0] and pmouse[ID_item]









PEN disable
––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
Vec3 pen[ID_item] or pen[0] refresh with space touch

information from the tablet tilt : orientation of the pen 
pen[ID_item].x > return float around -1, 1
pen[ID_item].y > return float around -1, 1

information from tablet : pressure pen 
pen[ID_item].z - value to 0 to 1 - 

  ////////////////////////////////
 // BE CAREFULL PEN is disable //
////////////////////////////////
instead we use vlue by default
pen[Ø].x = 0 ; tilt x
pen[Ø].y = 0 ; tilt y
pen[Ø].z = .02 ; pressure











MOUSE CLICK BOOLEAN
–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
Short click just for one shot
	boolean clickShortLeft[ID_item] ;
	boolean clickShortRight[ID_item] ;
Active after one mousePressed, be inactive after the mouse Released
	boolean clickLongLeft[ID_item] ;
	boolean clickLongLeft[ID_item] ;











Dropdown media import
-----------------------
text
--
String text_import[ID_item]

bitmap
--
PImage bitmap_import[ID_item]

svg
--
RPEsvg svg_import[ID_item]

movie
--
Movie movie_import[ID_item]










