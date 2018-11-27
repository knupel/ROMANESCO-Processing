/**
RUBIS
2013-2018
v 1.0.7
*/

class Rubis extends Romanesco {
  public Rubis() {
    //from the index_objects.csv
    item_name = "Rubis" ;
    item_author  = "Stan le Punk";
    item_version = "version 1.0.7";
    item_pack = "Base 2013-2018" ;
    item_costume = "";
    item_mode = "Vertex/Point";

    hue_fill_is = true;
    sat_fill_is = true;
    bright_fill_is = true;
    alpha_fill_is = true;
    hue_stroke_is = true;
    sat_stroke_is = true;
    bright_stroke_is = true;
    alpha_stroke_is = true;
    thickness_is = true;
    size_x_is = false;
    size_y_is = false;
    size_z_is = false;
    diameter_is = false;
    canvas_x_is = true;
    canvas_y_is = false;
    canvas_z_is = false;

    // frequence_is = true;
    speed_x_is = true;
    speed_y_is = false;
    speed_z_is = false;
    spurt_x_is = false;
    spurt_y_is = false;
    spurt_z_is = false;
    dir_x_is = false;
    dir_y_is = false;
    dir_z_is = false;
    jit_x_is = true;
    jit_y_is = true;
    jit_z_is = true;
    swing_x_is = true;
    swing_y_is = false;
    swing_z_is = false;

    quantity_is = true;
    variety_is = false;
    life_is = false;
    flow_is = false;
    quality_is = false;
    area_is = false;
    angle_is = false;
    scope_is = false;
    scan_is = false;
    align_is = false;
    repulsion_is = false;
    attraction_is = false;
    density_is = false;
    influence_is = false;
    calm_is = false;
    spectrum_is = false;
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
    float speed = map(speed_x_item[ID_item],0,1,.0001,.2);
    speed = speed*speed ;
    if(sound[ID_item] && sound_is()) {
      speed *= all_transient(ID_item);
    }



    Vec3 jitter = Vec3() ;
    if(sound[ID_item] && sound_is()) {
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
    
    
    if(mode[ID_item] == 1) {
      aspect(fill_item[ID_item], stroke_item[ID_item], thickness_item[ID_item], POINT_ROPE) ;
    } else {
      aspect(fill_item[ID_item], stroke_item[ID_item], thickness_item[ID_item]) ;
    }

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
    item_info[ID_item] =(numPeople + " summits") ;
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