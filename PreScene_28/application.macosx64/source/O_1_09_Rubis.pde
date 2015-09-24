// Tab: O_1_09_Rubis
class MesAmis extends Romanesco {
  public MesAmis() {
    //from the index_objects.csv
    romanescoName = "Rubis" ;
    IDobj = 9 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "version 1.0.1";
    romanescoPack = "Base" ;
    romanescoRender = "P3D" ;
    //romanescoMode = "1 full/2 lines" but the line is not really interesting
    romanescoMode = "" ; // separate the name by a slash and write the next mode immadialtly after this one.
    romanescoSlider = "Hue fill,Saturation fill,Brightness fill,Alpha fill,Hue stroke,Saturation stroke,Brightness stroke,Alpha stroke,Thickness,Canvas X,Speed,Quantity,Amplitude" ;
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
    
    PVector center = new PVector() ;
    

    
    // speed
    float speed = map(speedObj[IDobj],0,1, .0001, .2);
    speed = speed*speed ;
    if(sound[IDobj]) speed *= allBeats(IDobj) ;



    PVector jitter = new PVector() ;
    if(sound[IDobj] && getTimeTrack() > 0.2 ) {
      float factor = .2 ;
      float valueX = left[IDobj]*factor *(width / 2 ) ;
      float valueY = right[IDobj]*factor *(height / 2 ) ;
      float valueZ = mix[IDobj]*factor *(height / 2 ) ;
      jitter = new PVector(valueX,valueY,valueZ) ;
    }

    // size of the rubis
    float radiusMax = map(canvasXObj[IDobj], width/10, width, width/4, width *1.5) ;
    float radiusMin = map(amplitudeObj[IDobj], 0, 1, radiusMax, radiusMax /10) ;


     // stop motion
    if(!motion[IDobj]) { 
      speed = 0 ; 
      jitter = new PVector(0,0,0) ;
    }

 


    
    // new population
    if(!fullRendering)  quantityObj[IDobj] *= .1 ;
    numPeople = (int)map(quantityObj[IDobj],0, 1, 10, 70) ; 
    if ( numPeople != refNumPeople ) newPopulation = true ;
    refNumPeople = (int)map(quantityObj[IDobj],0, 1, 10, 70) ;
    if(newPopulation) {
      listPeople.clear() ;
      amiSetting(numPeople, rangePeople) ;
      newPopulation = false ;
    }
    
    
    aspect(IDobj) ;
    amiDrawHeartMove(center, speed, radiusMin, radiusMax, jitter, mode[IDobj]) ;

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
  void amiDrawHeartMove(PVector posCenter, float speed, float distMin, float distMax, PVector jitter, int mode) {
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
      //if(mode == 1 ) lineFriends(peopleOrigin) ;

    }
    
    // info
    objectInfo[IDobj] =(numPeople + " summits") ;
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
  /*
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
  */
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