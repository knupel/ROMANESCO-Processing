/**
RUBIS || 2013 || 1.0.3
*/

class MesAmis extends Romanesco {
  public MesAmis() {
    //from the index_objects.csv
    RPE_name = "Rubis" ;
    ID_item = 9 ;
    ID_group = 1 ;
    RPE_author  = "Stan le Punk";
    RPE_version = "version 1.0.2";
    RPE_pack = "Base" ;
    //RPE_mode = "1 full/2 lines" but the line is not really interesting
    RPE_mode = "Vertex/Point" ; // separate the name by a slash and write the next mode immadialtly after this one.
    RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Stroke hue,Stroke sat,Stroke bright,Stroke alpha,Thickness,Canvas X,Speed X,Jitter X,Jitter Y,Jitter Z,Quantity,Swing X" ;
  }
  //GLOBAL
  IntList IDpeople = new IntList() ;
  ArrayList<Ami> listPeople = new ArrayList<Ami>() ;
  int numPeople, rangePeople, refNumPeople ;
  PVector target ;
  boolean goBack  ;
  boolean newPeoplePosition, newPopulation ;
  
  
  //SETUP
  void setup() {
    setting_start_position(ID_item, width/2, height/2, 0) ;
    int num = (int)random(15,25)  ;
    rangePeople = width/2 ;
    amiSetting(num, rangePeople) ;
  }
  
  
  

  //DRAW
  void draw() {
    
    Vec3 center = Vec3() ;

    // speed
    float speed = map(speed_x_item[ID_item],0,1, .0001, .2);
    speed = speed*speed ;
    if(sound[ID_item]) speed *= allBeats(ID_item) ;



    Vec3 jitter = Vec3() ;
    if(sound[ID_item] && getTimeTrack() > 0.2 ) {
      float valueX = left[ID_item] *jitter_x_item[ID_item] *width ;
      float valueY = right[ID_item] *jitter_y_item[ID_item] *width ;
      float valueZ = mix[ID_item] *jitter_z_item[ID_item] *width ;
      jitter.set(valueX,valueY,valueZ) ;
    }

    // size of the rubis
    float radiusMax = canvas_x_item[ID_item] *.7 ;
    float radiusMin = map(swing_x_item[ID_item], 0, 1, radiusMax, radiusMax /10) ;


     // stop motion
    if(!motion[ID_item]) { 
      speed = 0 ; 
      jitter.set(0) ;
    }

 


    
    // new population
    int max_people = 150 ;
    if(!FULL_RENDERING)  quantity_item[ID_item] *= .1 ;
    numPeople = (int)map(quantity_item[ID_item],0, 1, 10, max_people) ; 
    if ( numPeople != refNumPeople ) newPopulation = true ;
    refNumPeople = (int)map(quantity_item[ID_item],0, 1, 10, max_people) ;
    if(newPopulation) {
      listPeople.clear() ;
      amiSetting(numPeople, rangePeople) ;
      newPopulation = false ;
    }
    
    
    aspect_rpe(ID_item) ;
    ami_heart_move(center, speed, radiusMin, radiusMax, jitter, mode[ID_item]) ;

  }
  
  ////////////////
  // VOID
  //setting
  void amiSetting(int num, int size) {
    for ( int i = 0 ; i < num ; i++ ) {
      int ID = i ;
      //position of people
      PVector p  = new PVector (random(-size, size), random(-size, size), random(-size, size)) ;
      //friend of this people
      for ( int f = 0 ; f < num ; f++) IDpeople.append(f) ;
      int numFriend = (int)random(num / 2 ) ;
      int [] IDfriend = new int [numFriend] ;
      for ( int j = 0 ; j < numFriend ; j++) {
        int whichPeople = (int)random(IDpeople.size() ) ;
        int IDofFriend = IDpeople.get(whichPeople) ;
        IDfriend[j] = IDofFriend ;
        if(IDpeople.size() > 0 ) IDpeople.remove(whichPeople) ; 
      }
      //add information to the arraylist
      Ami people = new Ami(p, ID, IDfriend ) ;
      listPeople.add(people) ;
      //clear the list for a new start friend round
      IDpeople.clear() ;
    }
  }
  //draw
  //different points
  void ami_heart_move(Vec3 posCenter, float speed, float distMin, float distMax, Vec3 jitter, int mode) {
    // new distribution
    if(newPeoplePosition) {
      for(int i = 0 ; i < listPeople.size() ; i++) {
        int r = (int)distMax ;
        Ami peopleOrigin = listPeople.get(i) ;
        peopleOrigin.originalPos = new PVector(random(-r,r),random(-r,r),random(-r,r)) ; 
      }
      newPeoplePosition = false ;
    }
    
    // ACTION
    countAmiArrivedToTarget = 0 ;
    for(int i = 0 ; i < listPeople.size() ; i++) {
      Ami peopleOrigin = listPeople.get(i) ;
      //update
      if (!goBack) target = new PVector(posCenter.x, posCenter.y, posCenter.z) ; else  target = new PVector(peopleOrigin.originalPos.x, peopleOrigin.originalPos.y, peopleOrigin.originalPos.z) ;
      PVector jitting = new PVector(random(-jitter.x, jitter.x), random(-jitter.y, jitter.y), random(-jitter.y, jitter.y)) ;
      target.add(jitting) ;
      peopleOrigin.pos = heartMove(peopleOrigin.pos, target, distMin, speed) ;
      //draw
      if(mode == 0 ) triangleFriends(peopleOrigin) ;
      if(mode == 1 ) pointFriends() ;

    }
    
    // info
    objectInfo[ID_item] =(numPeople + " summits") ;
  }
  
  
  
  /////////
  // ANNEXE
  
  // HEART MOVE
  int countAmiArrivedToTarget ;
  
  PVector heartMove(PVector pos, PVector target, float distMin, float speed) {
    pos = gotoTarget(pos, target, speed) ; 
    float distance = 0 ;
    distance = PVector.dist(pos, target) ;
    if( distance < distMin  ) countAmiArrivedToTarget += 1 ;
    if(countAmiArrivedToTarget == listPeople.size() ) {
      goBack = !goBack ;
      newPeoplePosition = true ;
    }
    return pos ;
  }
  // END ANNEXE HEART MOVE
  
  
  
  // CONNECT YOUR FRIEND with line
  void pointFriends() {
    if (listPeople.size() > 1 ) {
      //PVector me = ami.pos ;
      // f += 2
     for (Ami ami : listPeople) {
        //Ami amiOne = listPeople.get(ami.friendList[f]) ;
        // Ami amiTwo ;
        //if (ami.friendList[f] +1 >= listPeople.size() )  amiTwo = listPeople.get(ami.friendList[0]) ; else amiTwo = listPeople.get(ami.friendList[f] +1) ; 
        //PVector posAmiOne = amiOne.pos.copy() ;
        //PVector posAmiTwo = amiTwo.pos.copy() ;
        //display
        point(ami.pos.x, ami.pos.y, ami.pos.z) ;
        //point(posAmiOne.x, posAmiOne.y, posAmiOne.z) ;
        // point(posAmiTwo.x, posAmiTwo.y, posAmiTwo.z) ;
      }
    }
  }
  // END CONNECT YOUR FRIEND with line
  
  // CONNECT YOUR FRIEND with triangle
  void triangleFriends(Ami ami) {
    if (ami.friendList.length > 1 ) {
      PVector me = ami.pos ;
      // f += 2
      for ( int f = 0 ; f < ami.friendList.length -1 ; f++) {
        Ami amiOne = listPeople.get(ami.friendList[f]) ;
        Ami amiTwo ;
        if (ami.friendList[f] +1 >= listPeople.size() )  amiTwo = listPeople.get(ami.friendList[0]) ; else amiTwo = listPeople.get(ami.friendList[f] +1) ; 
        PVector posAmiOne = amiOne.pos.copy() ;
        PVector posAmiTwo = amiTwo.pos.copy() ;
        //display
        beginShape() ;
        vertex(me.x, me.y, me.z) ;
        vertex(posAmiOne.x, posAmiOne.y, posAmiOne.z) ;
        vertex(posAmiTwo.x, posAmiTwo.y, posAmiTwo.z) ;
        endShape(CLOSE) ;
      }
    }
  }
  // END CONNECT YOUR FRIEND with triangle
  
  // END ANNEXE
  /////////////
}









////////////
// CLASS
class Ami {
  PVector pos = new PVector() ;
  PVector originalPos = new PVector() ;
  PVector size ;
  int ID ;
  int [] friendList ;
  
  Ami (PVector pos, int ID, int [] IDfriend ) {
    this.originalPos = pos ;
    this.pos = pos ;
    this.ID = ID ;
    friendList = new int [IDfriend.length] ;
    for ( int i = 0 ; i < IDfriend.length ; i ++ ) {
      friendList[i] = IDfriend[i] ;
    }
  }
  
  
  Ami ( PVector pos) {
    this.pos = pos ;
  }
}
