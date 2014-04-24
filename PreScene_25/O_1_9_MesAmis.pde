


class MesAmis extends SuperRomanesco {
  public MesAmis() {
    //from the index_objects.csv
    romanescoName = "Mes Amis" ;
    IDobj = 9 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Alpha 1.0";
    romanescoPack = "Base" ;
    romanescoRender = "P3D" ;
    romanescoMode = "1 Lines/2 Triangles" ; // separate the name by a slash and write the next mode immadialtly after this one.
  }
  //GLOBAL
  IntList IDpeople = new IntList() ;
  ArrayList<Ami> listPeople = new ArrayList<Ami>() ;
  int numPeople, rangePeople, refNumPeople ;
  PVector target ;
  boolean goBack  ;
  boolean newPeoplePosition, newPopulation ;
  
  
  //SETUP
  void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
    int num = (int)random(15,25)  ;
    rangePeople = width/2 ;
    amiSetting(num, rangePeople) ;
  }
  
  
  

  //DRAW
  void display() {
    PVector center = new PVector(0, 0, 0 ) ;
    float speed = map(speedObj[IDobj],0,100, .00001, .05);
    if(sound[IDobj]) speed *= beat[IDobj] ;
    float radiusMax = map(canvasXObj[IDobj], width/10, width, width/4, width *1.5) ;
    float radiusMin = map(amplitudeObj[IDobj], 0, 1, radiusMax, radiusMax /10) ; ;
    // new population
    numPeople = (int)map(quantityObj[IDobj],0,100, 10,70) ;
    if ( numPeople != refNumPeople ) newPopulation = true ;
    refNumPeople = (int)map(quantityObj[IDobj],0,100, 10,70) ;
    if(newPopulation) {
      listPeople.clear() ;
      amiSetting(numPeople, rangePeople) ;
      newPopulation = false ;
    }
    
    
    strokeWeight(thicknessObj[IDobj]) ;
    stroke(strokeObj[IDobj]) ;
    fill(fillObj[IDobj]) ;
    amiDrawHeartMove(center, speed, radiusMin, radiusMax, mode[IDobj]) ;

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
  void amiDrawHeartMove(PVector posCenter, float speed, float distMin, float distMax, int mode) {
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
      peopleOrigin.pos = heartMove(peopleOrigin.pos, target, distMin, speed) ;
      //draw
      if(mode == 0 ) lineFriends(peopleOrigin) ;
      if(mode == 1 ) triangleFriends(peopleOrigin) ;
    }
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
  void lineFriends(Ami ami) {
    if (ami.friendList.length > 0 ) {
      PVector origin = ami.pos ;
      for ( int f = 0 ; f < ami.friendList.length ; f++) {
        Ami peopleDestination = listPeople.get(ami.friendList[f]) ; 
        PVector destination = peopleDestination.pos ;
        line(origin.x, origin.y, origin.z, destination.x, destination.y, destination.z) ;
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
        PVector posAmiOne = amiOne.pos.get() ;
        PVector posAmiTwo = amiTwo.pos.get() ;
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
