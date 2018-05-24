Todolist Romanesco
--
2018
--
*get_tempo(beat_target)

Tab s_core_render > line 1614
tempoKick[0] = get_tempo(0);
tempoSnare[0] = get_tempo(1);
tempoHat[0] = get_tempo(2);


*bug controller

Quand la taille du controleur est changée le rendu passe au noir

*version

créer un fichier externe de version

*window

Save the window position, to keep the position used when the app is re-open

*Controller

Remove the concept of group for the slider and button, too complex.

*2D

Bouton pour bloquer les rotations de caméra, comme cela on pourra faire de la 2D dans un monde 3D

*camera video

Remove this camera from the core, that's became an object? And don't start when the app is launch