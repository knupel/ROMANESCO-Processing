16-05-15
--
item_setting_direction[0][ID_item]

remplacer
  posObjX[ID] = x -(width/2) ;
  posObjY[ID] = y -(height/2) ;
  posObjZ[ID] = z ;
par
Vec3 pos_item ;

remplacer
  dirObjX[ID]  ;
  dirObjY[ID]  ;

par
Vec2 dir_item ;





16-05-14
--
Le mauvais reset de la position est du au fait que 

C'est la methode qui est appelé dans le setting() de l'item

void startPosition(int ID, int x, int y, int z) {
  startingPosition[ID] = Vec3(x,y,z) ;
  posObjX[ID] = x -(width/2) ;
  posObjY[ID] = y -(height/2) ;
  posObjZ[ID] = z ;
  
  posObjSetting [0][ID] = new PVector(posObjX[ID], posObjY[ID], posObjZ[ID] ) ;
  dirObjSetting [0][ID] = new PVector(dirObjX[ID], dirObjY[ID]) ;
  mouse[ID] = Vec3(x,y,z) ;
}

et quand on utilise la fonction pour reset en cours de route
x, y et z prennent posObjSetting [0][ID] comme valeur qui est la même pour tous


void objectMove(boolean movePos, boolean moveDir, int ID) {
  //UPDATE
  //position
  if (!movePos)  newObjRefPos = true ;
  PVector newPos = updatePosObj(posObj[ID], ID, movePos) ;
  posObjX[ID] = newPos.x ;
  posObjY[ID] = newPos.y ;
  posObjZ[ID] = newPos.z ;
  //rotation
  if (!moveDir) newObjRefDir = true ;
    //speed rotation
  float speed = 100.0 ; // 150 is medium speed rotation
  speedDirectionOfObject = new PVector(speed /(float)width, speed /(float)height) ; 
  dirObjX[ID] = updateDirObj(speedDirectionOfObject, ID, moveDir).x ; 
  dirObjY[ID] = updateDirObj(speedDirectionOfObject, ID, moveDir).y ;
  
  //RESET
  if(touch0) {
    posObjX[ID] = posObjSetting [0][ID].x ;
    posObjY[ID] = posObjSetting [0][ID].y ;
    posObjZ[ID] = posObjSetting [0][ID].z ;

    dirObjX[ID] = dirObjSetting [0][ID].x ;
    dirObjY[ID] = dirObjSetting [0][ID].y ;

    P3DdirectionMouseRef.set(0,0,0) ;
    tempObjDir.set(0,0,0) ;
  }
  addRefObj(ID) ;
}