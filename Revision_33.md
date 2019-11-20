*Romanesco dui

*revision 33

*MAJOR

>add: POST-FX shader glsl : blur, grain, pixelate...
>the window position is keeping from previous session
>add: dynamic method to manage font
>try to detect the system font, to load from this one. If that's don't work use the font folder from Romanesco.
>remove: direct access to item variables.
>add: setting method for item variables.
>add: get_method in class Romanesco to catch the arg : min, max, raw from slider value.
>add: methode set_background() to pass PImage from item to the main background.
>change: commande to actived the main camera, now don't to keep 'c' pressed, one hit to able or enable.
>add: top bar for the controler
>add: mix mode to use multiply, overlay... and other incrustation effect
>pass allmethod to get slider value from the old style to the new class Varom > Varom for VAriable ROManesco.
>fix: freezing bug when the display is smallest than controller or rendering window.
>change totaly the mask system

*MINOR

>change: min-max variable for angle, direction and scope from 0 to 360 for 0 to TAU and update the item linked with that.
>add: class Mode to mange the name and the id item mode
>remove: method boolean get_orbit() statement from keyboard prescene command
>add: method boolean get_follow() statement from keyboard prescene command
>refactoring: button general
>update: costume method
>remove: save scene option
>add: method to select the first movie meet from the item like the global movie > must be improve properly in the future
>remove: MIDI icone setting, now the acces is on the menu bar.
>add: event syphon to apple bar
>remove: keyevent syphon from rendering sketch
>add: slider amplitude
>change: name for item.show(), item.parameter(), item.sound() and item.action() for item.show_is(), item.parameter_is(), item.sound_is() and item.action_is()
>add: event alpha_is()
>bug: fix the bug who cause problem of choice problem in fullscreen selection window.
>add command to clear media list
>when the camera item is use the global camera is locked.
>fix: midi bug controller with the last input selected.
>fix: selection media, when the length of media change.
>change: remove key space to reset item, now it's only backspace and delete when parameter or move option is on.
>add: button to reset the window location from the launcher.
>change the shortcut to stop motion, before it's key 'm' now it's key space.

*SHADER

>add: background fx voronoi
>add: post fx dither bayer 8
>add: post fx threshold
>remove: shader neon
>total refactoring the FX BACKGROUND shader system to have a same manager fx system than FX POST

*ITEM

>update: KINO, add method to swith off the sound
>update: KINO, change the direction for padding image up and down
>update: KINO pass image to background.
>update: BOXOLYZER add costume to change shape easily and other improvement.
>add: AUTOMATA 
>add: GRILLO about 3D grid and coin flip !
>add: TARTAN
>add: SIMPLE
>add: MER
>add: LYRICS
>update: SOLEIL improvement the revolution part
>remove: Galaxie
>remove: Letter
>add: Rosace

*BUG FIX

>preview "prescene" don't pass data to scene







*Romanesco dui

*revision 32 | December 2018

*MAJOR

>Serial the item ranking, no need to give id and group in the code.
>Fix MIDI saving slider bug
>add method in class Romanesco to catch the item parameter easily

*MINOR

>add method to change media from pad : LEFT,RIGHT,UP,DOWN
>add slider position

*ITEM

>Force Field : add costume to  item
>Force Field : put limit for the size shape, particulary necessary for the magnetic and gravity mode
>Force Field fix bug with Magnetic and Gravity but for the case where the ite mPuppet Master is off.
>remove Text
>remove Damier
>improve Vectorial : display warning when there is no vectorial media in the library.
>improve Kino, add slider to control the movie position


*BUG FIX

>fix -partial- bug of button alert when there is item with a lot loop with thousand or more object
>fix bug of bad position of camera when the app starting
>fix importing media bug.
>fix out bound exception when new media is uploaded
>fix bug aspect color, when the saturation or brightness arg is equal to zero to keep the value storage for hue.








*Romanesco dui

*revision 31 | November 2018



*MAJOR

>improve dropdown and sliders method
>remove menu web-cam from controller
>add menu filter to controller
>refactoring the code to use slider in Romanesco sub-classes item
>change slider controller system management to create a group by theme, easyer to code for the future.
>create group data item, light, filter, sound, camera, background
>rebuild the gui system, not visible for the user, just for the coder !
>rebuild the sound system, now the the beat threshold is setable, set the band and the level alart
>total rewriting Gui Control
>add button to switch between setting camera and sound
>add system to set tempo and beat threshold
>add slider background shader
>add new dropdown item menu to select costume
>add multi slider to set the transient detection
>add method do select folder and input media from the controller
>remove method by dropping media in external folder
>fusion of the sketches prescene and scene, the result became rendering
>romanesco unu became romanesco dui, too much change to keep the same name !
>add mask option
>add button camera reset
>add button item reset
>add button three dimension
>add button birth
>add camera setting rotation, translate and deceleration


*MINOR

>improve OSC architecture
>improve OSC dialogue between controller > prescene > scene > miroir
>common external file to name and use slider item
>change colour background interface
>remove separation between sound gui and general top gui
>increase the bands spectrum available from 16 to 128
>improve management color for design interface
>improve few shader background
>check if dropdown is active or not stop the other GUI update
>move dropdown slider with mouse wheel
>introduce new param to store and read data from slider, class Cropinfo
>add shortcut to clear the midi selection
>improve method costume to display pixel from force field
>fix reset bug on the main camera
>increase visibility when the curtain is ON or OFF


*ITEM

>add Pulsar
>add BoumBoum
>add Force Field
>add Spot
>add flux

>improve kino
>improve Lignes
>improve Kofosphere
>improve spirale
>improve arbre

>remove Spray
>remove movie


*BUG FIX

>size for item atoms
>setting size window for prescene and scene
>fix item inventory on_off state changing when the window size change
>fix bug for the display slider item selected
>fix bug when the window gui change sige all setting are lost and the scene turn to black
>fix wink midi button bug
>fix bug controller display item thumbnail














*Romanesco unu

*revision 30

*GLOBAL

> Improve Mirror system, now you can right a list of address IP, to send imformation to few computer in local network.


*PRESCENE & SCENE

*MAJOR

> add item Vectorial
> add item Movisco
> add item ecosysteme agent
> add item ecosyteme host
> add item Lorenz attractor
> add method to make screenshot by press 'p' touch keyboard
> add library costume_rope and improve few items with it.
> add library Motion_rope
> add iniertia method for the main camera
> add master and follower system to link item between them from core code, not from the controller GUI
> fix bug OSC bug for the shortcut keyboard action between prescene and scene. Except in case where there is a lot of shape in the rendering, like boids or a lot of interacting particles.


*MINOR

> remove item Anillos
> add method to load svg file.svg
> add method to load movie file.mov
> fix bug orientation camera when you reset position of the camera or of the items
> improve the growth curve for the size, canvas and area sliders
> add mode to rubis item
> add jitter slider for rubis item
> add slider font size for Atome item
> method to set direction item
> fix bug reset direction and position item
> update item letter, change slider and shortcut
> add boolean orbit[ID_item] from keyboard "O"
> update item soleil : add spurt jitter, adjust float ration for speed, swing, jitting and beams num
> item boxolyzer, fix bug rotation on line box
> add method to select costume
> add var item costume[ID_item]
> add boolean colour[ID_item] from keyboard "X"
> add boolean special[ID_item] from keyboard "K"
> add boolean horizon[ID_item] from keyboard "H"
> add boolean dimension[ID_item] from keyboard "D"
> fix a main part of bug for the camera reset
> add boolean fill_is[ID_item] from keyboard "F"
> add boolean stroke_is[ID_item] from keyboard "L"
> improve the video part


CONTROLLER
--
MAJOR
--
> add menu to selected item
> add dropdown to selected SVG file
> add dropdown to selected movie

MINOR
--
> add new item slider : font size, jitter, swing, spurt, variety, quality, direction y, direction z, speed y, speed z, fertility, area, scope, scan, charge, calm and need
> remove slider analyze, amplitude
> remove the second group of item
> fix display bug
> slider charge became density
> slider need became spectrum
> fixe displaying bug for the last slider
> fixe bug for vertical molette of the slider dropdown

LAUNCHER
--
MAJOR
--
> add mode "HOME", now you can work directly on Préscène
> change mode "CLASSIC" to "LIVE"
> change mode "MIROIR" to "MIRROR"
> disable the full possibility to set the size of your window, the reason is a bug in the Processing language in the P3D resize window.












*Romanesco unu

*revision 29

> new build for the last OSX 10.11.3
> fix Scene position and display, when there is only one screen connected – thx VKING for the report – 
> remove fullscreen when there is only one screen detected








*Romanesco unu

*revision 28

CORE
--
> remove graphic enviroment 
> remove Maverick detection
> remove native full screen method
> add fullscreen() method from Processing
> add librairie processing.video at the root of Romanesco, now you just need to call the fonction with cam.methode()
> improve a little bit the object webCam
> add dropdown menu to Controller to choice your camera device
> Change the system to call the Scene in window or in full screen
> Miroir : you can choice between full screen or window displaying
> Fix the memory leak
> update library Vec
> update library Math
> update background method













*Romanesco unu

*revision 27

CORE
--
ADD

* SLIDER

* slider attraction
* slider repulsion
* slider alignement
* slider influence
* option to change the minimum and maximum value for the slider

* MIDI

* add option to change midi device

* CAMERA

* Global view of your Prescene. Now when you don't use the camera to move or rotate you've a global view of the world.
* Add slider to set your camera.

* LIGHT

* add an ambient light

** CLASS

* class canvas
* class Vec2, Vec3, Vec4, Vec5
	    this class is close of PVector :
	    you can add, mult, div, mag, dist, map like in PVector.
	    
	    you can also 
	    > compare two Vec with equals method
	    > find the middle of two Vec, with the middle method.

	    > Vec is compatible with PVector.
	    you can copy your PVector to Vec, create Vec directly from your PVector.


VOID

* void camaieu

SAVE

* Now you can save you Scene setting, not only you Controler setting. And it's very big step.
save
> CTRL + S 			> save on the current save Scene setting
> CTRL + SHIFT + S 	>  save on the new save Scene setting
> CTRL + E 			> save on the current save Controller setting
> CTRL + SHIFT + E 	> save on the new save Controller setting
load
> CTRL + O 			> load Scene setting
> CTRL + SHIFT + O 	> load Controller setting


REMOVE
--
* slider force
* remove the old class slider
* curtain on Prescene
* aspect in the prescene, now all the object are white, with stroke of one without alpha.
* remove pmouse

IMPROVE
--
* normalize slider family 
* normalize slider quantity
* grid camera
* change the system name of pic object thumbnail from "number" to "class name", easier to add pic thumbnail when there is new object is library.
* Best rending for the light, is not optimum but is better.


BUG FIXE
--
* remove the bug on the boolean objectInfoDisplay[ID], now the boolean is independant between the scène and the préscène
* rotation and move jump camera with the mouse
* fixe the loading bug
* fixe bug camera special move, like return to the origin


ITEM
--
ADD
--
* Anillos
* Boids
* Orbital
* Surface


REMOVE OBJ
--
* Rideau
* Curtain


CHANGE OBJ
--
* Balise: add reverse
* Balise: add stop motion function
* Arbre: adjustement of the amplitude and size proportion
* Rubis: add motion stop, with "m" touch
* Soleil: add reverse function
* Soleil: change the special move
* Spirale: improve beat detection
* Spirale: add slider for the alignment
* spiral: add shortcut horizon to switch the alignment.
* Balise: remove the move on the space touch
* Lignes: add modes to display few grid lignes
* Lignes: add slider angle and alignment
* Stars Spray: Add star when the list is empty
* Damier: change the range of quantity for the pattern
* Horloge: add speed slider
* Horloge: add motion function
* Horloge: add reverse function
* Nid d'abeilles : change shortcut "x" to "n"
* Webcam: add beat reactivity
* Image: change shortcup to anchor point

BUG FIXE OBJ
* Arbre : fix bug size when there is no sound

/// END OBJECT ///

















*Romanesco unu

*revision 26

ADD
--
* void primitive(int x, int y, int radius, int summits) to create regulare polygone with "n" summits
* void appearance(color colorFill, color colorStroke, float thickness) to check the color fill and stroke to disable the fill() or the stroke() and display
* void polyhedron(String whichPolyhedron, String whichStyleToDraw, int size) to create different kind of polyhedron > read "CODE GLOBAL.txt" Primitive 3D part

REMOVE
--
* the option to drop image on the Scene
* save PDF and PNG

IMPROVE
--
BUG FIXE
--
* Midi save and load slider
* Leapmotion camera and objects position and direction
* remove the method to remove the menu bar in fullscreen, because it's a crash reason for the Scene.


OBJECT
--
ADD OBJ
--
* Kofosphere object 3D
* template to code object

CHANGE OBJ
--
* Atom : add new mode
* Atom : optimize the code to growth the speed rate
* Letters : add mode triangle face
* Atom modes : box, sphere, triangle, terahedron, rectangle...
* Atom : key "d" on the Prescene to change the displaying of the atom to 2D to 3D > 3D to 2D
* Atom : slider amplitude for the sound reactivity
* Atom : slider depth for the size box
* Atom : left, right sound to add jitter direction for each atom

BUG FIXE OBJ
--
* HEXAGONE : fixe canvas bug when this one displayed too much shapes
* Balise : display shape with acceptable size when the sound is off
* RSS : fixe the outbound index in case where there is no info.
* Escargot : Rotation image by the center, not by the corner.


ADD
--
LAUNCHER
--
* launch MIROIR from the launcher
* preset to choice the size for the Scene

CONTROLLER
--
* Dropdown menu picture
* Dropdown menu text
* Dropdown menu shader Background
* Menu Light one and two

SCENE
-- 
* Math : Few Polyhedrons
* Math : Tetrahedron
* Math : Triangle vertex P3D mode
* Manager class for Romanesco object
* Manager images file.jpg from folder
* Manager text file.txt from folder

* key shortcut to return the camera to the origin
* key shortcut to return the object to the origin
* key shortcut to control the Light

* Spectrum analyze with 16 bands

* Info object String

LIBRARY
--
* "MES AMIS"
* "SOLEIL"
* "HONNEY COMB"
* "LES VIEUX" special place for the objects remove from their place but not from Romanesco

REMOVE 
--
CONTROLEUR
--
* remove the weather button

SCENE
--
* Weather API function
* Object Twittos
* space touch to move the Object

IMPROVE
--
CONTROLEUR
--
* growth the size of the slider
* Change the organization of the sliders 

SCENE
--
* leapmotion control
* start to corect the color bug with the color value (0,0,0,0)
