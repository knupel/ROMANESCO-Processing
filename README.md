##ROMANESCO version 26 / Romanesco Unu 1.0.1.26
Romanesco can be your manager to test your sketch in a P3D world.
Those sketches are the progress work for the previous [Romanesco Unu 1.0.0.25](https://github.com/StanLepunK/ROMANESCO_25).
to download the built [app 1.0.0.25](http://romanescoproject.wordpress.com/download/)

##Architecture Sketches
* Romanesco : Sketch to set the Romanesco application.
* Controleur : interface slider to use the objects and the different parameters.
* Prescene : use to move the object in the 3D space.
* Scene : Display the result, we can use this one to send to syphon or not.

##Functions and variables
If you want code in Romanesco there few compulsory variables and functions that you can find in the file "Romanesco functions ##.txt" and others who can help you.

##Code and Export
* Create a new tab with a clean sub class "SuperRomanesco" in Prescene Sketch
* Give number ID to this one, this number must be in the series of the other. No interruption from the first Obj ID to the last ID.
* When your code is done, run the Prescene to create the index of yours objects in the folder : index_romanesco_objects.csv :  "Prescene-#/preferences/objects" paste this one in the to the folder "Controleur-#/preferences/objects".
* Change or add a thumbnail for your object "Controleur_##/data/thumbnail/.../name+IDnumber+png" there is 4 pic for each object. Size 22x22 pixel in png mode. You can use the illustrator file in the main folder.
* Run the sketch Controleur
* If your code work fine, you can past your brick in the folder "Scene-##"

##Built Romanesco on OSX
* Before export your sketches
* Create a main folder, in this one create a folder named "sources".
* In "sources" you create "preferences" folder
* In "preferences" you drop :
 * "background_shader" folder
 * "Font" folder
 * "Images" folder 
 * "Karaoke" folder 
 * "network" folder 
 * "objects" folder 
 * "pixel"  folder
 * sketchProperty.csv file
 * "setting" folder 
 * shaderBackgroundList.csv file 
 * sliderListEN.csv file
 * sliderListFR.csv file
* Export all your Apps, put the "Launcher.app" in the main Folder, in "sources" drop the Scene, Prescene and the Controleur.
* Check your internet connexion and run.

##Built Romanesco on Linux
* ?

##Built Romanesco on Windows
* ?




##LICENCE
ROMANESCO is under the licence CeCILL.
Romanesco is free for the non-commercial use in other case contact-me.
2011-2014.
