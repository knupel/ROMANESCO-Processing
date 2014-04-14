ArrayList<Atom> atomList ;

//object one
class Atome extends SuperRomanesco {
  public Atome() {
    //from the index_objects.csv
    romanescoName = "ATOM" ;
    IDobj = 3 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Alpha 1.1";
    romanescoPack = "Base" ;
    romanescoRender = "P3D" ;
    romanescoMode = "1 Schema/2 Cloud/3 Title/4 Font" ;
  }
  
  //GLOBAL
  int KelvinUnivers  ; // Kelvin degree influent on the mouvement of the Atom, at 0°K there is no move !!! 273K° give 273/Kelvin = 1.0 multi reference when the water became ice ! 
  int t ;
  float pressure = 1.0 ; // Atmospheric pressure. "1" is earth reference
  // wall of screen
  float restitution = 0.5 ;

  float bottom =    restitution ;
  float top =       restitution ;
  float wallRight = restitution ;
  float wallLeft =  restitution ;

  //Molecule.Atom
  boolean cloud = true ; // To swith ON/OFF phycic of the cloud
  // ArrayList<Atom> listA ;
  PVector changeVelocity = new PVector (0.0 , 0.0) ;

  float atomX = 0 ; float atomY = 0 ;
  
  float beatSizeProton = 1 ;
  float beatThicknessCloud = 1 ;
  float beatSizeCloud = 1 ;
  
  //direction of atome
  PVector newDirection ;
  
  
  //SETUP
  void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
    
    atomList = new ArrayList<Atom>();
    
    //add one atom to the start
   PVector pos = new PVector (random(width), random(height), 0) ;
   PVector vel = new PVector ( random(-1, 1 ), random(-1, 1 ), random(-1, 1 ) ) ;
   int Z = int(familyObj[IDobj]) ;
   int ion = round(random(0,0));
   float rebound = 0.5 ;
   int diam = 5 ;
   int Kstart = int(abs( mix[IDobj]) *1000) ; // Temperature of Atom, influence the mouvement behavior
   //motion
   motion[IDobj] = true ;
   
   Atom atm = new Atom( pos, vel, Z, ion, rebound, diam,  Kstart) ; 
   atomList.add(atm) ;
   
   // init font
   font[IDobj] = font[0] ;
  }
  //DRAW
  void display() {
    if (parameter[IDobj]) font[IDobj] = font[0] ;
    
        //OBJECT
    for (Atom atm : atomList) {
      ////////////////UPDATE////////////////////////////////////////
      float velLimit = (tempo[IDobj] ) *5.0 ; // max of speed Atom
      if (velLimit < 1.1 ) velLimit = 1.1 ;
      //the atom temperature give the speed 
      float s = map(speedObj[IDobj],0,100, 0.0,17.0);
      float speed = s*s*s ;
      if(sound[IDobj]) t =  floor(speed  * tempo[IDobj]) ; else t = round(speed) ;
      //ratio evolution for atom temperature...give an idea to change the speed of this one
      //because the temp of atom is linked with velocity of this one.
      float tempAbs = 10.0 ;
      //VELOCITY and DIRECTION of atom
      if(motion[IDobj]) {
        if(spaceTouch && action[IDobj]) {
          newDirection = new PVector (-pen[IDobj].x, -pen[IDobj].y ) ;
        } else { 
          newDirection = normalDir(int(directionObj[IDobj])) ;
        }
      } else {
        newDirection = new PVector (0,0,0 ) ;
      }
      
      PVector newVelocity = new PVector ( sq(tempo[IDobj]) *1000.0 , sq(tempo[IDobj]) *1000.0 );
      //security if the value is null to don't stop the move
      float acceleration ; 
      if(pen[IDobj].z == 0 ) acceleration = 1.0  ; else acceleration = pen[IDobj].z * 1000.0  ;
      changeVelocity = new PVector (newDirection.x * newVelocity.x *right[IDobj] *acceleration  , newDirection.y * newVelocity.y *left[IDobj] *acceleration  ) ;
      
      atm.update (t, velLimit, changeVelocity, tempAbs) ; // obligation to use this void, in the atomic univers
      //COLLISION
      atm.covalentCollision (atomList);
      //DRAG
      float inertia = 1.0 ; // strong of the drag
      atm.drag2D(inertia) ;
    
      
      //DISPLAY
      //PARAMETER FROM ROMANESCO
      //the proton change the with the beat of music
      //diameter
      float fp = map (sizeXObj[IDobj], 0,100, 1, 20) ;
      int factorSizeProton = int(fp) ;
      
      if ( atm.getProton() < 21 ) { 
        beatSizeProton = beat[IDobj] ;
      } else if ( atm.getProton() > 20 && atm.getProton() < 45 ) {
        beatSizeProton = kick[IDobj] ;
      } else if ( atm.getProton() > 44 && atm.getProton() < 65 ) {
        beatSizeProton = snare[IDobj] ;
      } else if ( atm.getProton()  > 64 ) {
        beatSizeProton = hat[IDobj] ;
      }
      /////////////////CLOUD///////////////////////////////////////
      //  int factorSizeProton = int(OC21 / 40.0 + 1 ) ;
      if ( atm.getProton() < 21 ) { 
        beatThicknessCloud = beat[IDobj] ;
      } else if ( atm.getProton() > 20 && atm.getProton() < 45 ) {
        beatThicknessCloud = kick[IDobj] ;
      } else if ( atm.getProton() > 44 && atm.getProton() < 65 ) {
        beatThicknessCloud = snare[IDobj] ;
      } else if ( atm.getProton()  > 64 ) {
        beatThicknessCloud = hat[IDobj] ;
      }
      
      //thickness / épaisseur
      float factorThicknessCloud = thicknessObj[IDobj] *beatThicknessCloud ;
      //diameter
      float factorSizeField = map(sizeXObj[IDobj], 0,100, 1, 10) ; // factor size of the electronic Atom's Cloud
      // float factorSizeField = OC21 / 20.0 ; // factor size of the electronic Atom's Cloud
      
      /////////TEXT///
      
      float corps ;
      //diameter / hauteur
      corps = map(sizeXObj[IDobj], 0, 100, 6, height *0.66) ;
     
      PVector posText = new PVector ( 0.0, 0.0, 0.0 ) ;
      int sizeTextName = int(corps) ;
      int sizeTextInfo = int(corps / 2.0) ;
      //width
      float posTextInfo = sizeYObj[IDobj] + (beat[IDobj] *2.0)  ;
      //Canvas
      PVector marge = new PVector(canvasXObj[IDobj], canvasYObj[IDobj]) ;
      

      //MODE OF DISPLAY
        if (mode[IDobj] == 0 || mode[IDobj] == 255 ) {
          atm.display( fillObj[IDobj], factorSizeProton * beatSizeProton ) ; // wait color
          atm.eCloudEllipse2D(strokeObj[IDobj], factorSizeField, cloud, factorThicknessCloud) ;
        } else if (mode[IDobj] == 1 ) {
          atm.display( fillObj[IDobj], factorSizeProton * beatSizeProton ) ; // wait color
          atm.eCloudPoint2D(strokeObj[IDobj], factorSizeField, cloud) ;
        } else if (mode[IDobj] == 2 ) {
          atm.title2D (fillObj[IDobj], font[IDobj] , sizeTextName, posText ) ; 
        } else {
          atm.titleAtom2D (fillObj[IDobj], strokeObj[IDobj], font[IDobj] , sizeTextName, sizeTextInfo, posTextInfo ) ; // (color name, color Info, PFont, int sizeTextName,int  sizeTextInfo )
        }
  
      
      //UNIVERS
      ////////////////////////////////////////////////////////////////////////////////////////////
      atm.universWall2D( bottom, top, wallRight, wallLeft, false, marge) ; // obligation to use this void
      ////////////////////////////////////////////////////////////////////////////////////////////
      
      ///////////////////////// INTERNAL VOID \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
      //Electronic Info 
      //atm.electronicInfo() ; // give the number of electronic shell and the Valence Shell
      //atm.addElectron() ;    // add electron on the atom at the begin the electron is equal to "Z"proton
    }
    
    
    

    //CLEAR
    if (emptyList(IDobj)) atomList.clear() ;
    //ADD ATOM
    if(action[IDobj] && nLongTouch && frameCount % 2 == 0) atomAdd(giveNametoAtom()) ;

  }
  //END DRAW
  /////////
  
  
  
  //ANNEXE
  
  //give name to the atom from the karaoke.txt in the source repository
  String giveNametoAtom() {
    String s = ("") ;
    int whichChapter = floor(random(sentencesByChapter.length)) ;
    int whichSentence = floor(random(sentencesByChapter[0].length)) ;
    //give a random name, is this one is null in the array, give the tittle name of text
    if(sentencesByChapter[whichChapter][whichSentence] != null ) s = sentencesByChapter[whichChapter][whichSentence] ; else s = sentencesByChapter[0][0] ;
    return s ;
  }
  
  // ADD function
  void atomAdd() {
    //data
    //amplitude
    //give the field of type of atome must be create
    float numP = map(familyObj[IDobj],1,100,1,118) ;
    int Z = int(random (1,numP)) ; // Z is the number of protons give the number of electrons max knew is 118
    int ion = round(random(0,0)); // number of electron(s) less(Anion)   more(Cation)   / give the magnetism & conductivity of the atome cannot be equal or sup to "Z"proton
    
    int Kstart = int(abs( mix[IDobj]) *1000) ; // Temperature of Atom, influence the mouvement behavior

    if (Kstart > 500 ) Kstart = 500 ;
    // physic action & display in the Univers
    float rebound = 0.5 ;
    int diam = 5 ;
    // Atom motion
    float startVel = 1.0 ;
    PVector posA = new PVector ( mouse[IDobj].x, mouse[IDobj].y, 0.0 ) ;
    PVector velA = new PVector ( random(-startVel, startVel ), random(-startVel, startVel ), random(-startVel, startVel ) ) ;
    
    for (Atom atm : atomList) {
      if(atm.insideField()) return;
    }
    Atom atm = new Atom( posA, velA, Z, ion, rebound, diam,  Kstart) ; 
    atomList.add(atm) ;
  }
  
  //Add atom with a specific name
  void atomAdd(String name) {
    //data
    //amplitude
    //give the field of type of atome must be create
    float numP = familyObj[IDobj] ;
    int Z = int(random (1,numP)) ; // Z is the number of protons give the number of electrons max knew is 118
    int ion = round(random(0,0)); // number of electron(s) less(Anion)   more(Cation)   / give the magnetism & conductivity of the atome cannot be equal or sup to "Z"proton
    
    int Kstart = int(abs( mix[IDobj]) *1000) ; // Temperature of Atom, influence the mouvement behavior

    if (Kstart > 500 ) Kstart = 500 ;
    // physic action & display in the Univers
    float rebound = 0.5 ;
    int diam = 5 ;
    // Atom motion
    float startVel = 1.0 ;
    PVector posA = new PVector ( mouse[IDobj].x, mouse[IDobj].y, 0.0 ) ;
    PVector velA = new PVector ( random(-startVel, startVel ), random(-startVel, startVel ), random(-startVel, startVel ) ) ;
    
    for (Atom atm : atomList) {
      if(atm.insideField()) return;
    }
    Atom atm = new Atom(name, posA, velA, Z, ion, rebound, diam,  Kstart) ; 
    atomList.add(atm) ;
  }

}



















///////////
//CLAS ATOM
class Atom 
{
  String [] nameAtom = { "Atom", "H",                                                                                                                                                                                         "He", 
                                 "Li", "Be",                                                                                                                                                 "B",  "C",   "N",   "O",  "F",   "Ne", 
                                 "Na", "Mg",                                                                                                                                                 "Al", "Si",  "P",   "S",  "Cl",  "Ar",
                                 "K",  "Ca",                                                                                     "Sc", "Ti", "V",  "Cr", "Mn", "Fe", "Co", "Ni", "Cu", "Zn", "Ga", "Ge",  "As",  "Se", "Br",  "Kr",
                                 "Rb", "Sr",                                                                                     "Y",  "Zr", "Nb", "Mo", "Tc", "Ru", "Rh", "Pd", "Ag", "Cd", "In", "Sn",  "Sb",  "Te", "I",   "Xe",
                                 "Cs", "Ba", "La", "Ce", "Pr", "Nd", "Pm", "Sm", "Eu", "Gd", "Tb", "Dy", "Ho", "Er", "Tm", "Yb", "Lu", "Hf", "Ta", "W",  "Re", "Os", "Ir", "Pt", "Au", "Hg", "Tl", "Pb",  "Bi",  "Po", "At",  "Rn",
                                 "Fr", "Ra", "Ac", "Th", "Pa", "U",  "Np", "Pu", "Am", "Cm", "Bk", "Cf", "Es", "Fm", "Md", "No", "Lr", "Rf", "Db", "Sg", "Bh", "Hs", "Mt", "Ds", "Rg", "Cn", "Uut", "Fl", "Uup", "Lv", "Uus", "Uuo"  } ;
  float [] Pauling = { 0.0,      2.20,                                                                                                                                                                                         0.00, 
                                 0.98, 1.57,                                                                                                                                                 2.04, 2.55,  3.04,  3.44,  3.98,  0.00, 
                                 0.93, 1.31,                                                                                                                                                 1.61, 1.90,  2.19,  2.58,  3.16,  0.00,
                                 0.82, 1.00,                                                                                     1.36, 1.54, 1.63, 1.66, 1.55, 1.83, 1.88, 1.91, 1.90, 1.65, 1.81, 2.01,  2.18,  2.55,  2.96,  0.00,
                                 0.82, 0.95,                                                                                     1.22, 1.33, 1.60, 2.16, 2.10, 2.20, 2.28, 2.20, 1.93, 1.69, 1.78, 1.96,  2.05,  2.10,  2.66,  2.60,
                                 0.79, 0.90, 1.10, 1.12, 1.13, 1.14, 1.13, 1.17, 1.20, 1.20, 1.20, 1.22, 1.23, 1.24, 1.25, 1.10, 1.27, 1.30, 1.50, 1.70, 1.90, 2.20, 2.20, 2.20, 2.40, 1.90, 1.80, 1.80,  1.90,  2.00,  2.20,  0.00,
                                 0.70, 0.90, 1.10, 1.30, 1.50, 1.70, 1.30, 1.30, 1.30, 1.30, 1.30, 1.30, 1.30, 1.30, 1.30, 1.30, 1.30, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00,  0.00,  0.00,  0.00,  0.00  } ;
  
  Univers nvrs ;
  //Univers data
  float K_atom  ;
  float pressure = 1.0 ;  
  // Atom data
 ArrayList<Electron> listE; // list of electron for each Atom
  PVector pos ;    // position of the atom
  PVector vel ;    // velocity of the atom
  float d, mass, rebound ; // diameter and answer on the wall
  
  //Atomic property
  int  neutron, proton, electron, ion, valenceElectron, missingElectron, freeElectronicSpace ;
  int n = 1 ; // number of electronic shell
  int electronLayer = 0 ; // number of electronic shell
  float screenEffect = 1.0  ; 
  float electroNegativity = 0.0 ; // Electronegativity of atom 

  float mgt ; // ionic load : give the magnetism atom
  float amp = 1.0 ; // default parameter of the amplitude of electronic field
  float ampInfo = 1.0 ; // default parameter of the amplitude of electronic field
  
  boolean insideA, insideF, lock, collision, cloud ;
  
  // Bond variable for link atom
  int freeBond ;
  int bondLink = 0 ; // number of link between two atoms (1 to 3 is useful )
  boolean bond ;
  boolean [] covalentBond = new boolean [9] ;
  boolean covalentBondLast = true, mole = false ;
 
  
  color inAtom = color (360,100,100) ; // blanc
  
  String c = "" ; // empty field to give the information of bond capacity of atom
  
  // give by default the title of the text import
  String nickName = ("ATOM") ;
 
  /////////////////////CONSTRUCTOR ATOM////////////////////////////////////////////////////////////////
  //simple constructor
  Atom  (PVector pos_, PVector vel_, float rebound_, int d_ ) {
    pos = pos_  ;
    vel = vel_  ;
    rebound = rebound_ ; 
    d = d_ ;
    mass = d_ ;
    // UNIVERS
    nvrs = new Univers() ;
  }
  //Atomic constructor  
  Atom (PVector pos_, PVector vel_, int proton_, int ion_, float rebound_,int d_, int Kelvin_ ) {
    pos = pos_  ;
    vel = vel_  ;
    proton = proton_;
    if (proton < 21 ) neutron = proton_ ;
    if (proton > 20 && proton < 103 ) neutron = round(proton_  * 1.765) -20  ; // behind 20 proton, the quantity of neutron is more important than proton.
    if (proton > 102 && proton < 111 ) neutron = round(proton_ * 0.54)  +102 ;
    if (proton > 110 && proton < 116 ) neutron = round(proton_ * 2.475) -110 ;  
    if (proton > 115  ) neutron = round(proton_ * 0.53) +115 ; 
    
    mass = proton + neutron ; ion = ion_ ;
    electroNegativity = Pauling[proton_] ; // Give the electroNagativity of Atom whith Pauling board
    rebound = rebound_ ; d = d_ ;
    K_atom = Kelvin_ ;
    float Ka = Kelvin_ / 273.0 ;
     
    vel.x = vel.x * Ka ;
    vel.y = vel.y * Ka ;
    vel.z = vel.z * Ka ;
    
    listE = new ArrayList<Electron>();
    // UNIVERS
    nvrs = new Univers() ;
    // initialize the covalent level
    electronicCovalentBond() ;
  }
  
  //Atomic constructor with nickname  
  Atom (String name, PVector pos_, PVector vel_, int proton_, int ion_, float rebound_,int d_, int Kelvin_ ) {
    nickName = name ;
    pos = pos_  ;
    vel = vel_  ;
    proton = proton_;
    if (proton < 21 ) neutron = proton_ ;
    if (proton > 20 && proton < 103 ) neutron = round(proton_  * 1.765) -20  ; // behind 20 proton, the quantity of neutron is more important than proton.
    if (proton > 102 && proton < 111 ) neutron = round(proton_ * 0.54)  +102 ;
    if (proton > 110 && proton < 116 ) neutron = round(proton_ * 2.475) -110 ;  
    if (proton > 115  ) neutron = round(proton_ * 0.53) +115 ; 
    
    mass = proton + neutron ; ion = ion_ ;
    electroNegativity = Pauling[proton_] ; // Give the electroNagativity of Atom whith Pauling board
    rebound = rebound_ ; d = d_ ;
    K_atom = Kelvin_ ;
    float Ka = Kelvin_ / 273.0 ;
     
    vel.x = vel.x * Ka ;
    vel.y = vel.y * Ka ;
    vel.z = vel.z * Ka ;
    
    listE = new ArrayList<Electron>();
    // UNIVERS
    nvrs = new Univers() ;
    // initialize the covalent level
    electronicCovalentBond() ;
  }
  
  
  
  
  //UPDATE
  // classic update
  void update(float velLimit) { 
    vel.limit(velLimit) ;
    // if (!collision || listA.size() < 2 ) pos.add(vel) ;
    if (!collision ) pos.add(vel) ;
  }
  
  // update Atom
  void update(int Kelvin_univers, float velLimit, PVector changeVel, float tempAbs) { 
    vel.x = changeVel.x ;
    vel.y = changeVel.y;
    
    //update atom temperature
    if (K_atom < Kelvin_univers ) K_atom += tempAbs ;
    if (K_atom > Kelvin_univers ) K_atom -= tempAbs ; 
    
    float Kfactor =  K_atom / 273.0 ;
    float pressureFactor = 1.0 / pressure ;
    vel.limit(velLimit *Kfactor *pressureFactor) ; // limit of velocity, the K° is very important factor.
    
    // check if collision's void is true or not, if it's false the position is caculate here
    if (!collision ) pos.add(vel) ;
    
    // update electron 
    int eBond = 0 ;
    if (bond) eBond = 1 ;

    electron = proton + ion + eBond ;
    if (electron < 0 ) electron = 0 ; // keep the number of electron equal to zero or positive
    mgt = ion ;
   // update display capacity
   if ( covalentBond[1]  )  c = "height places";
   if (!covalentBond[1]  )  c = "seven places" ;
   if (!covalentBond[2]  )  c = "six places";
   if (!covalentBond[3]  )  c = "five places" ;
   if (!covalentBond[4]  )  c = "four places"  ;
   if (!covalentBond[5]  )  c = "three places" ;
   if (!covalentBond[6]  )  c = "two places" ;
   if (!covalentBond[7]  )  c = "one place" ;
   if (!covalentBondLast )  c = "full";   
  }
  
//:::::::Optional void atom ( position, detection...)
  void drag2D() {
    //strokeWeight(d) ;
    insideA = radiusCursor2D() ;
    insideF = radiusElectronicFieldCursor2D() ;
    if(mousePressed && insideA) lock = true;
    if(!mousePressed)           lock = false;
    if (lock) { 
      pos.x = mouseX; 
      pos.y = mouseY;
    }
  }
  //:::::::drag Atom
  void drag2D(float inertia) {
    //strokeWeight(d) ;
    insideA = radiusCursor2D() ;
    insideF = radiusElectronicFieldCursor2D() ;
    if( mousePressed && insideA) lock = true ;
    if(!mousePressed)            lock = false ;
    if (lock) { 
      pos.x = mouseX; 
      pos.y = mouseY;
      vel.x = (mouseX -pmouseX) * inertia; 
      vel.y = (mouseY -pmouseY) * inertia;
      if (vel.x == 0 && vel.y == 0 ) 
      {
        vel.x = random(-1,1) ;
        vel.x = random(-1,1) ;
      }   
    }
  }
////////////////////////////////////COLLISION/////////////////////////////////////////////////////////adapted from Ira Greenberg///////////////
//////////////////////////COLLISION SIMPLE//////////////////////////////////////////////////////////
  void collision(ArrayList<Atom> listA ) {
    collision = true ; // this boolean give the hand at this collison() void for update the velocity
    for (Atom target : listA) {
      if (target != this) {
        /////////////////////////\\\\\\\\\\\\\\\\\\\
        //:::::::::Code for angle collision::::::::::
        // get distances between the "atoms" components
        PVector atomVect = new PVector();
        atomVect.x = target.pos.x - pos.x;
        atomVect.y = target.pos.y - pos.y;
        ////////////////////////////////////////////
        if (collide(target, target.radius(), radius() ) ) {
          contact(target, atomVect) ; 
        } else {
          noContact(target) ;
        }
      } 
    }
  }
  //::::::::::::::::::::::::Resolve Collision::::::::::::::::::::::::::::
  void contact(Atom target , PVector atomVect)  {
    resolveCollision(target, atomVect) ;
  }
  //::::::::::::
  void noContact (Atom target)  {
    // global code for collsion
    collision = false ; // this boolean give the control of the velocity to the update() void
  }
  
  
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////COVALENT COLLISION//////////////////////////////////////////////////
  void covalentCollision(ArrayList<Atom> listA ) {
    for (Atom target : listA) {
      if (target != this) {    // don't collide with ourselves. that would be weird.
        /////////////////////////\\\\\\\\\\\\\\\\\\\
        //:::::::::Code for angle collision::::::::::
        // get distances between the "atoms" components
        PVector atomVect = new PVector();
        atomVect.x = target.pos.x - pos.x;
        atomVect.y = target.pos.y - pos.y;
        ////////////////////////////////////////////
        /*
        if (fieldCollide( target, 
                          target.radiusElectronicFieldCovalent(), radiusElectronicFieldCovalent(), 
                          target.radiusElectronicField(),         radiusElectronicField()          )) {
        */
        if (collide( target, target.radiusElectronicField(), radiusElectronicField() ) ) {
          contactCovalentEN(target, atomVect) ;
          if (collide( target, target.radiusElectronicFieldCovalent(), radiusElectronicFieldCovalent() ) ) {
            contactCovalent(target, atomVect) ;
            statementCovalent(target) ;
          } else {
            noContactCovalent () ;
          }     
        } else {
          noContactCovalent () ;
        }     
      }
    }
  }
  //::::::::::::::::::::::::Resolve Collision::::::::::::::::::::::::::::
  //COVALENT COLLISION ////// the result depend of the covalent number ///////////////////
  void contactCovalentEN(Atom target, PVector atomVect)  {
    if (target.electroNegativity == 0 || electroNegativity == 0) {
      resolveCollision(target , atomVect) ;
    }
  }
   
   
  void contactCovalent(Atom target, PVector atomVect)  {
    //  float linking = abs(target.electroNegativity - electroNegativity) * 25.0 ;
    //  float linkingLuck = random(100);
    // if (!target.covalentBondLast || !covalentBondLast ) {
       if (!target.covalentBondLast || !covalentBondLast ) {
           resolveCollision(target , atomVect) ;
           //   if ( linkingLuck < linking ) {
        resolveCollision(target , atomVect) ;
      }  else {
        // new motion of atom when is lock together//
   //     mole = true ; // say the atom is now a molecule
        float factorAddMotion = 2.0 ; // 2.0 is average motion factor
        PVector newVel = new PVector ( (vel.x + target.vel.x) /factorAddMotion , (vel.y + target.vel.y) /factorAddMotion ) ;
        target.vel = newVel ;
        vel  = newVel ;
      }
  //   }
   }
   
   
   
  //::::::::::::
  void statementCovalent(Atom target) {
    if(target.covalentBond[1] && covalentBondLast) freeBond = 0 ;
    if(!target.covalentBond[1])  freeBond = 1 ;
    if(!target.covalentBond[2])  freeBond = 2 ;
    if(!target.covalentBond[3])  freeBond = 3 ;
    if(!target.covalentBond[4])  freeBond = 4 ;
    if(!target.covalentBond[5])  freeBond = 5 ;
    if(!target.covalentBond[6])  freeBond = 6 ;
    if(!target.covalentBond[7])  freeBond = 7 ;
    if(!target.covalentBondLast) freeBond = 8 ;
    
    switch(freeBond) {
      case 0 : target.covalentBond[1]  = false ;
      break ;
      case 1 : target.covalentBond[2]  = false ;
      break ;
      case 2 : target.covalentBond[3]  = false ;
      break ;
      case 3 : target.covalentBond[4]  = false ;
      break ;
      case 4 : target.covalentBond[5]  = false ;
      break ;
      case 5 : target.covalentBond[6]  = false ;
      break ;
      case 6 : target.covalentBond[7]  = false ;
      break ;
      case 7 : target.covalentBondLast = false ;
      break ;
      
      case 8 : break ;
    }
  }
  //::::::::::::::::::::::
  
  void noContactCovalent() { // internal
    collision = false ; // this boolean give the control of the velocity to the update() void
    //for the covalent collision
    electronicCovalentBond() ;
  }
  
  // Update the bond of each atom
  void electronicCovalentBond() { // internal
    if (proton < 3 ) { 
      covalentBond[0] = true ;
      if (valenceElectron == 0 ) { covalentBond[1] = false ; covalentBondLast = false ;  }
      if (valenceElectron == 1 ) { covalentBond[1] = false ; covalentBondLast = true ; }
      if (valenceElectron == 2 ) { covalentBond[1] = false ; covalentBondLast = false ; }
    }
    if (proton > 2 ) {      
      covalentBond[0] = true ;
      //if (valenceElectron == 0 ) { covalentBond[1] = true ; covalentBond[2] = true ; covalentBond[3] = true ; covalentBond[4] = true ; covalentBond[5] = true ; covalentBond[6] = true ; covalentBond[7] = true ;  covalentBondLast = true ; }// height place, but is full
      if (valenceElectron == 0 ) { covalentBond[1] = false ; covalentBond[2] = false ; covalentBond[3] = false ; covalentBond[4] = false ; covalentBond[5] = false ; covalentBond[6] = false ; covalentBond[7] = false ;  covalentBondLast = false ; }// height place, but is full
      if (valenceElectron == 1 ) { covalentBond[1] = false ; covalentBond[2] = true  ; covalentBond[3] = true  ; covalentBond[4] = true  ; covalentBond[5] = true  ; covalentBond[6] = true  ; covalentBond[7] = true  ; covalentBondLast = true   ; }     // seven places
      if (valenceElectron == 2 ) { covalentBond[1] = false ; covalentBond[2] = false ; covalentBond[3] = true  ; covalentBond[4] = true  ; covalentBond[5] = true  ; covalentBond[6] = true  ; covalentBond[7] = true  ; covalentBondLast = true   ; }    // six places
      if (valenceElectron == 3 ) { covalentBond[1] = false ; covalentBond[2] = false ; covalentBond[3] = false ; covalentBond[4] = true  ; covalentBond[5] = true  ; covalentBond[6] = true  ; covalentBond[7] = true  ; covalentBondLast = true   ; }      // five places
      if (valenceElectron == 4 ) { covalentBond[1] = false ; covalentBond[2] = false ; covalentBond[3] = false ; covalentBond[4] = false ; covalentBond[5] = true  ; covalentBond[6] = true  ; covalentBond[7] = true  ; covalentBondLast = true   ; }     // four places
      if (valenceElectron == 5 ) { covalentBond[1] = false ; covalentBond[2] = false ; covalentBond[3] = false ; covalentBond[4] = false ; covalentBond[5] = false ; covalentBond[6] = true  ; covalentBond[7] = true  ; covalentBondLast = true   ; }    // three places
      if (valenceElectron == 6 ) { covalentBond[1] = false ; covalentBond[2] = false ; covalentBond[3] = false ; covalentBond[4] = false ; covalentBond[5] = false ; covalentBond[6] = false ; covalentBond[7] = true  ; covalentBondLast = true   ; }     // two places
      if (valenceElectron == 7 ) { covalentBond[1] = false ; covalentBond[2] = false ; covalentBond[3] = false ; covalentBond[4] = false ; covalentBond[5] = false ; covalentBond[6] = false ; covalentBond[7] = false ; covalentBondLast = true   ; } // else {  covalentBondLast = false ; }   // one place
      if (valenceElectron == 8 ) { covalentBond[1] = false ; covalentBond[2] = false ; covalentBond[3] = false ; covalentBond[4] = false ; covalentBond[5] = false ; covalentBond[6] = false ; covalentBond[7] = false ; covalentBondLast = false  ; } // no place
    }
  }
  
 
///////////////////////////////////////////////////////////////////////////////
////////////////////////IONIC COLLISION////////////////////////////////////////
//:::::::::::::::::::::::the result depend of the positiv or negativ atom load.
  void electronicCollision(ArrayList<Atom> listA, boolean ionicEffect ) {
    for (Atom target : listA) {
      if(ionicEffect) {
        if ( target.ion != 0 && ion !=0 ) {
          if (target != this) {    // don't collide with ourselves. that would be weird.
            /////////////////////////\\\\\\\\\\\\\\\\\\\
            //:::::::::Code for angle collision::::::::::
            // get distances between the "atoms" components
            PVector atomVect = new PVector();
            atomVect.x = target.pos.x - pos.x;
            atomVect.y = target.pos.y - pos.y;
            ////////////////////////////////////////////
            if (fieldCollide( target, 
                              target.radius(),                 radius(), 
                              target.radiusElectronicField(),  radiusElectronicField() )) {
              contactElectronic(target) ; // when a collision is found, add it to a list for later use.
            }
          }
        }
      } else if (target != this ) {
                /////////////////////////\\\\\\\\\\\\\\\\\\\
        //:::::::::Code for angle collision::::::::::
        // get distances between the "atoms" components
        PVector atomVect = new PVector();
        atomVect.x = target.pos.x - pos.x;
        atomVect.y = target.pos.y - pos.y;
        ////////////////////////////////////////////
        if (collide(target, target.radiusElectronicField(),  radiusElectronicField())) {
          contact(target, atomVect) ;
        }
      }
    }
  }
  //////////IONIC CONTACT///with anion or cation, negative or positive atom load////////
  void contactElectronic(Atom target)  {
    // listA_electronicCollision.add(target); // when a collision is found, add it to a list for later use.
    // float forceMgt = abs(ion) + abs(target.ion) ;
    
    if (target.ion < 0) target.ion = -1 ;
    if (target.ion > 0) target.ion =  1 ;
    if (ion < 0) ion = -1 ;
    if (ion > 0) ion =  1 ;
    
    int mgt = ion + target.ion ;
    
    if ( mgt != 0 ) {
      target.vel.x = -target.vel.x ;
      target.vel.y = -target.vel.y ;
    } else {
      PVector newVel = new PVector(target.pos.x - pos.x, target.pos.y - pos.y , target.pos.z - pos.z);
      target.vel.x = -newVel.x;
      target.vel.y = -newVel.y;
      vel.x = newVel.x ;
      vel.y = newVel.y ;
    }
  }
//////////////////////COLLISION GLOBALE VOID//////////////////////////////////
//////////////////////RESOLVE COLLISION/////////////////////////////////
  void resolveCollision(Atom target , PVector atomVect) {
    if (target.vel.x == 0 ) target.vel.x = vel.x ; 
    if (target.vel.y == 0 ) target.vel.y = vel.y ;
    
    /////////////////////////\\\\\\\\\\\\\\\\\\\\\\
    //:::::::::Code for angle collision::::::::::::
    // calculate magnitude of the vector separating the atoms
    float theta  = atan2(atomVect.y, atomVect.x);
    // precalculate trig values
    float sinus = sin(theta);
    float cosinus = cos(theta);
  /* atomTemp will hold rotated ball positions. You 
    just need to worry about atomTemp[1] position*/
    Ref[] atomTemp = {  new Ref(), new Ref() } ;
       /* "target.atom's" position is relative to "atom's"
    so you can use the vector between them (atomVect) as the 
    reference point in the rotation expressions.
    atomTemp[0].x and atomTemp[0].y will initialize
    automatically to 0.0, which is what you want
    since "target.atom" will rotate around "atom" */
    atomTemp[1].x  = cosinus * atomVect.x + sinus * atomVect.y;
    atomTemp[1].y  = cosinus * atomVect.y - sinus * atomVect.x;
    
    // rotate Temporary velocities
    PVector[] velTemp = {  new PVector(), new PVector() };
    velTemp[0].x  = cosinus * vel.x + sinus * vel.y;
    velTemp[0].y  = cosinus * vel.y - sinus * vel.x;
    velTemp[1].x  = cosinus * target.vel.x + sinus * target.vel.y;
    velTemp[1].y  = cosinus * target.vel.y - sinus * target.vel.x;
    
    /* Now that velocities are rotated, you can use 1D
    conservation of momentum equations to calculate 
    the final velocity along the x-axis. */
    PVector[] velFinal = {  new PVector(), new PVector() };
    // final rotated velocity for b[0]
    velFinal[0].x = ((mass - target.mass) * velTemp[0].x + 2 * target.mass * velTemp[1].x) / (mass + target.mass);
    velFinal[0].y = velTemp[0].y;
    // final rotated velocity for b[1]
    velFinal[1].x = ((target.mass - mass) * velTemp[1].x + 2 * mass * velTemp[0].x) / (mass + target.mass);
    velFinal[1].y = velTemp[1].y;
    
    // hack to avoid clumping
    atomTemp[0].x += velFinal[0].x;
    atomTemp[1].x += velFinal[1].x;
    
    /* Rotate ball positions and velocities back
    Reverse signs in trig expressions to rotate 
    in the opposite direction */
    // rotate Atom
    Ref[] atomFinal = { new Ref(), new Ref() };
    atomFinal[0].x = cosinus * atomTemp[0].x - sinus * atomTemp[0].y;
    atomFinal[0].y = cosinus * atomTemp[0].y + sinus * atomTemp[0].x;
    atomFinal[1].x = cosinus * atomTemp[1].x - sinus * atomTemp[1].y;
    atomFinal[1].y = cosinus * atomTemp[1].y + sinus * atomTemp[1].x;
    
    // update atom to screen position
    target.pos.x = pos.x + atomFinal[1].x;
    target.pos.y = pos.y + atomFinal[1].y;
    pos.x += atomFinal[0].x;
    pos.y += atomFinal[0].y;
    // update velocities
    vel.x = cosinus * velFinal[0].x - sinus * velFinal[0].y;
    vel.y = cosinus * velFinal[0].y + sinus * velFinal[0].x;
    target.vel.x = cosinus * velFinal[1].x - sinus * velFinal[1].y;
    target.vel.y = cosinus * velFinal[1].y + sinus * velFinal[1].x;
  }
  //////////
  
 
  //ELECTRON
  // number of missing electron
 
  void electronicInfo() {

    // give the period of the atom, the period is call "n"
    if (proton < 3 )                  { n = 1 ; }
    if (proton > 2 && proton < 11 )   { n = 2 ; }
    if (proton > 10 && proton < 19 )  { n = 3 ; }
    if (proton > 18 && proton < 37 )  { n = 4 ; }
    if (proton > 36 && proton < 55 )  { n = 5 ; }
    if (proton > 54 && proton < 87 )  { n = 6 ; }
    if (proton > 86 && proton < 119 ) { n = 7 ; }
    
    // maxE is max of electron by layer "n". 32 is limit of electron by layer, this law is strange because is different of the periodic layer max ?????
    int e = electron  -electronLayer ;
    int maxE = 0 ;
    int mE = 0 ;
    int newN = 1 ;
    // may be it's better to don't use a loop and give the maxE with the number "n" to liberate the computer of this calcul.
    for ( int i = 0 ; i < n ; i++ ) {
      mE = constrain(round( 2*sq(newN)), 0, 32) ;
      maxE += mE ;
      newN += 1 ;
    }
    missingElectron = maxE -e  ; 
    
    //Valence shell, give the number of free place to connect atoms together
    if (n == 1 ) valenceElectron = 2 - missingElectron ;
    if (n == 2 ) valenceElectron = 8 - missingElectron ;
    if (n == 3 ) valenceElectron = 8 - (missingElectron -10) ;
    if (n == 4 ) valenceElectron = 8 - (missingElectron -24) ;
    if (n == 5 ) valenceElectron = 8 - (missingElectron -6) ; 
    if (n == 6 ) valenceElectron = 8 - (missingElectron -6) ;
    if (n == 7 ) valenceElectron = 8 - (missingElectron -6) ;
    //exception with rule
    if (proton > 20 && proton < 28 ) valenceElectron = proton%9 ; 
    if (proton > 38 && proton < 46 ) valenceElectron = proton%9 ;
    
    if (proton > 27 && proton < 31 ) valenceElectron = (proton%9) -1 ; 
    if (proton > 45 && proton < 49 ) valenceElectron = (proton%9) -1 ;
    if (proton > 48 && proton < 55 ) valenceElectron = valenceElectron +32 ;  
    
    if (proton > 56 && proton < 72 )   valenceElectron = 3 ; // lanthanides
    if (proton > 71 && proton < 77 )   valenceElectron = valenceElectron +42 ;
    if (proton > 76 && proton < 87 )   valenceElectron = valenceElectron +32 ;  
    if (proton > 88 && proton < 104 )  valenceElectron = 3 ; // actinides
    if (proton > 103 && proton < 109 ) valenceElectron = valenceElectron +42 ;
    if (proton > 108 && proton < 119 ) valenceElectron = valenceElectron +32 ;  
    
    //exception without rule
    //if (proton == 2  ) valenceElectron = 8 ;
    if (proton == 77 || proton == 109 ) valenceElectron = 8 ;
    if (proton == 19 || proton == 37 || proton == 55 || proton == 87 ) valenceElectron = 1 ;
    if (proton == 20 || proton == 38 || proton == 56 || proton == 88 ) valenceElectron = 2 ;
    
     if ( valenceElectron == 0 ) valenceElectron = 8 ; 
    
    //::::::::
    // To give the energy of atom
    if (proton < 3 ) freeElectronicSpace = 2 - valenceElectron ;
    if (proton > 2 ) freeElectronicSpace = 8 - valenceElectron ; 
  
     // ScreenEffect = 13.6 / (sq(n)) *freeElectronicSpace ; 
     screenEffect = 13.6 / (sq(n)) ; 
   }


  //add electron
  // create a list, to show the electronic cloud
  void addElectron() {
    int i ;
    Electron lctrn = new Electron();
    for ( i = 0 ; i < electron ; i++) {
      if (listE.size() < electron ) {
        listE.add(lctrn) ;
      }
    }
  }
  
  
  
  
  
  ////////////////////
  //DISPLAY
  
  //Display classic
  void display ( color c, float fs ) {
    if(alpha(c) != 0 ) {
      float thickness = d*fs ;
      if ( thickness < 0.1 ) thickness = 0.1 ;
      strokeWeight(thickness) ;
      if(insideA) { 
        fill(inAtom) ; stroke(inAtom) ;
      } else {
        fill(c) ; stroke(c) ;
        insideA = false ;
      }
      point (pos.x, pos.y) ;
    }
  }
  
  
  //////////////display the electronic Cloud/////////////////////////////
  //Possible to creat a void with 3D or with ellipse
  void eCloudPoint2D(color eColor, float amp, boolean cloud_) {
    addElectron() ;
    electronicInfo() ;
    
    cloud = cloud_ ;  // send the information to class Univers for the wall
    float Ex ;
    float Ey ;
    
    float ElectronicCloud = radiusElectronicField() *2;
    int Ed = round(d / 10) ;
    if (Ed < 1 ) Ed = 1 ;
    if ( alpha(eColor) != 0 ) {
      for (Electron lctrn : listE) {
        float randomEx = random( -ElectronicCloud, ElectronicCloud ) ;
        float randomEy = random( -ElectronicCloud, ElectronicCloud ) ;
        
        if ( sqrt(sq(randomEx) + sq(randomEy)) > (ElectronicCloud/2 ) ) // to keep the electron in the radius of atom
        {
          Ex = -ElectronicCloud ;
          Ey = -ElectronicCloud ;
        } else {
          Ex = pos.x + randomEx ;
          Ey = pos.y + randomEy ;  
          lctrn.displayPoint2D(Ex, Ey, Ed, eColor) ; 
        }
      }
    }
  }
  // display the ellipse of Valence bond
  void eCloudEllipse2D(color eColor, float amp, boolean cloud_, float thickness) {
    electronicInfo() ;
    // boolean cloud = cloud_ ;  // send the information to class Univers for the wall

    noFill() ; 
    if ( thickness < 0.1 ) thickness = 0.1 ;
    if ( alpha(eColor) != 0 ) {
      strokeWeight(thickness) ;
      stroke( eColor) ;
      ellipse (pos.x, pos.y, radiusElectronicFieldCovalent() *amp, radiusElectronicFieldCovalent() *amp ) ;
      ellipse (pos.x, pos.y, radiusElectronicField() *amp,     radiusElectronicField() *amp ) ;  
    }  
    
  }
////////////////DISPLAY///////////////////////////////////////////////////////////////////
//////////////Display text & Misc
  // text from main program
  void title2D(String title, color cName, PFont p, int sizeText, PVector posText ) {
    if ( alpha(cName) != 0 ) {
      fill(cName); textFont(p, sizeText);
      textAlign(CENTER);
      text(title , pos.x +posText.x , pos.y +posText.y );
    }
  }
  void title2D(color cName, PFont p, int sizeText, PVector posText ) {
    if ( alpha(cName) != 0 ) {
      fill(cName); textFont(p, sizeText);
      textAlign(CENTER) ;
      text(nickName , pos.x +posText.x , pos.y +posText.y );
    }
  }
///////////////////////DISPLAY PROPERTY of ATOM////////////////////////////////////////////
  void titleAtom2D (color cName, color cInfo, PFont p, int sizeTextName, int sizeTextInfo, float amp_ ) {
    // name
     
    ampInfo = amp_ ;
    float posXtext = (n *d *ampInfo) *0.35 ;
    float posYtext = sizeTextName *0.25 *(ampInfo/10.0) ;
    
    if ( alpha(cName) != 0 ) {
      fill(cName); textFont(p, sizeTextName);
      textAlign(CENTER);

      text(nameAtom[proton] , pos.x , pos.y + posYtext );
    }
    //Info
    if ( alpha(cInfo) != 0 ) {
      fill(cInfo); textFont(p, sizeTextInfo);
      textAlign (LEFT) ; 
      text(ion,              pos.x +posXtext , pos.y -posYtext );
      text(valenceElectron,  pos.x +posXtext , pos.y +( 2.3 *posYtext));
      //text(valenceElectron,  pos.x +posXtext , pos.y +sizeTextInfo);
      textAlign (RIGHT) ; 
     // text(proton,           pos.x -posXtext , pos.y +sizeTextInfo); 
      text(proton,           pos.x -posXtext , pos.y +( 2.3 *posYtext));
      text(round(mass),      pos.x -posXtext , pos.y -posYtext); 
      
      // capacity of atom for the Covalent Bond
      /*
      String capacity = c ;
      textFont(p, 10); textAlign(CENTER);
      text(capacity , pos.x , pos.y -15 ); 
      //Energy of atom
      String sE = nf(screenEffect, 1, 2 ) ;
      text("SE " + sE + " / EN " + electroNegativity , pos.x , pos.y +20 );
      */
    }
   
   //size of electronicCloud
   //text(radiusElectronicField() , pos.x , pos.y +20 ); 
    
  } 
  

///////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////EXTERNAL INFLUENCE///////////////////////////////////////////////////
  //Wall border
  void universWall2D(float restitutionBottom_, float restitutionTop_, float restitutionRight_, float restitutionLeft_, boolean wallOnOff_, PVector marge) {
    nvrs.physicWall2D(restitutionBottom_, restitutionTop_, restitutionRight_, restitutionLeft_, wallOnOff_) ;
    nvrs.wall2D(pos, vel, radius(), radiusElectronicField(), rebound, cloud, marge ) ;
  }  
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

   
////////////////////////////////////////////////////////////////////////////////////////////////  
//////////////////////////////////////RETURN///////////////////////////////////////////////////

  //////DETECT COLLISION\\\\\\\\\\\\\\\\\\\\\\\\\\\\
  // Detection the cursor is on the atom
  boolean radiusCursor2D() {
    return dist(pos.x, pos.y, mouseX, mouseY) < radius();
  }
    // Detection the cursor is on the atom
  boolean radiusElectronicFieldCursor2D() {
    return dist(pos.x, pos.y, mouseX, mouseY) < radiusElectronicField();
  }
  
  //:::::::::detect a collision with the other proton
  boolean collide(Atom target, float targetRadius, float radius) {
    float distance = target.pos.dist(pos); // distance between our center and the other ball center
    float thresh = targetRadius + radius; // thresh is our radius plus their radius
    if (distance < thresh) { // if the distance is less than the threshold, we are colliding!
      return true;
    } else {
      return false;
    }
  }
  //:::::::::detect a collision in field around
  boolean fieldCollide(Atom target, float targetRadiusMin, float radiusMin, float targetRadiusMax, float radiusMax) {  
    float distance = target.pos.dist(pos); // distance between our center and the other ball center
    float minThresh = targetRadiusMin + radiusMin; // thresh is our radius plus their radius
    float maxThresh = targetRadiusMax + radiusMax;
    if (distance > minThresh && distance < maxThresh) { // if the distance is in the field there is effect  
      return true;
    } else {
      return false;
    }
  }
  //////RETURN MISC\\\\\\\\\\\\\\\\\\\\\
  //:::::::::::::::return detection cursor
  boolean inside() {
    if (insideA) return true ; else return false ;
  }
  //
  boolean insideField() {
    if (insideF) return true ; else return false ;
  }
  //::::::::::::::::: Calculate the surface of Atom
  float surface() {
    return  PI*sq(d/2) ;   
  }
  //:::::::::::::::RADIUS:::::::::::::::::::
  //:::::::::::::::Return the radius of atom
  float radius() { 
    return d / 2;
  }
  //:::::::::::::::Return the radius of the atom's electronic field
  float radiusElectronicField() { 
    float REF ;
    float base = 1.0 ;
    float ratioPeriodic = 1.0 ;
    float ratioSizeAtom = 1.0 ;
    int maxPos = 0 ; // max position of the atom in the line line of periodic border
    int posAtom = 0 ; // position of the atom in the periodic border
    if (n == 1 ) { base = 1.0 ;  ratioPeriodic = 1.7  ; maxPos = 2  ; posAtom = abs( proton -2)   ;  }
    if (n == 2 ) { base = 1.22 ; ratioPeriodic = 4.41 ; maxPos = 8  ; posAtom = abs( proton -10)  ;  }
    if (n == 3 ) { base = 2.29 ; ratioPeriodic = 2.67 ; maxPos = 8  ; posAtom = abs( proton -18)  ;  }
    if (n == 4 ) { base = 2.83 ; ratioPeriodic = 2.76 ; maxPos = 18 ; posAtom = abs( proton -36)  ;  }
    if (n == 5 ) { base = 3.48 ; ratioPeriodic = 2.45 ; maxPos = 18 ; posAtom = abs( proton -54)  ;  }
    if (n == 6 ) { base = 3.87 ; ratioPeriodic = 2.48 ; maxPos = 32 ; posAtom = abs( proton -86)  ;  }
    if (n == 7 ) { base = 4.55 ; ratioPeriodic = 2.50 ; maxPos = 32 ; posAtom = abs( proton -118) ;  }
    
    float newPosAtom = norm( posAtom, 0.0, maxPos -1 ) ;
    if (newPosAtom == 0 ) { ratioSizeAtom = newPosAtom ; } else { ratioSizeAtom = newPosAtom / ((3.0 - pow(newPosAtom, 5)  ) -newPosAtom) ; }
    
    ratioSizeAtom = 1 + ( ratioSizeAtom *ratioPeriodic *base ) ;
    
    REF =( d *amp *ratioSizeAtom ) ;
    return REF ;
  }
  //:::::::::::::::Return the radius of the atom's electronic valence bond field 
  float radiusElectronicFieldCovalent() {
    float REFC ;
    float base = 1.0 ;
    float ratioPeriodic = 1.0 ;
    float ratioSizeAtom = 1.0 ;
    int maxPos = 0 ; // max position of the atom in the line line of periodic border
    int posAtom = 0 ; // position of the atom in the periodic border
    if (n == 1 ) { base = 1.0 ;  ratioPeriodic = 1.7  ; maxPos = 2  ; posAtom = abs( proton -2)   ;  }
    if (n == 2 ) { base = 1.22 ; ratioPeriodic = 4.41 ; maxPos = 8  ; posAtom = abs( proton -10)  ;  }
    if (n == 3 ) { base = 2.29 ; ratioPeriodic = 2.67 ; maxPos = 8  ; posAtom = abs( proton -18)  ;  }
    if (n == 4 ) { base = 2.83 ; ratioPeriodic = 2.76 ; maxPos = 18 ; posAtom = abs( proton -36)  ;  }
    if (n == 5 ) { base = 3.48 ; ratioPeriodic = 2.45 ; maxPos = 18 ; posAtom = abs( proton -54)  ;  }
    if (n == 6 ) { base = 3.87 ; ratioPeriodic = 2.48 ; maxPos = 32 ; posAtom = abs( proton -86)  ;  }
    if (n == 7 ) { base = 4.55 ; ratioPeriodic = 2.50 ; maxPos = 32 ; posAtom = abs( proton -118) ;  }
    
    float newPosAtom = norm( posAtom, 0.0, maxPos -1 ) ;
    if (newPosAtom == 0 ) { ratioSizeAtom = newPosAtom ; } else { ratioSizeAtom = newPosAtom / ((3.0 - pow(newPosAtom, 5)  ) -newPosAtom) ; }
    
    ratioSizeAtom = 1 + ( ratioSizeAtom *ratioPeriodic *base ) ;
    
    REFC =( d *amp *ratioSizeAtom *0.8 ) ;
    return REFC ;
  }

  //::::::::::::::ELECTRONIC INFO:::::::::::::::::::::::::::::
  //::::::::::::::Return the number Valence
  int valenceE() {
    electronicInfo() ;
    return valenceElectron ;
  }
  //:::::::::Return the quantity of free place in the last electronic valence shell
  int freeE() {
    electronicInfo() ;
    return freeElectronicSpace ;
  }
  //return the proton
  int getProton() {
    return proton ;
  }
}



//////////////////////////
//SUPER CLASS ELECTRON
class Electron {
  float thick = 1.0 ;
  Electron() {}
  //::::::::::::::::::::::::::::::::::::::::::::::::::
  void displayPoint2D(float x_ , float y_ ,int d_ , color eColor) {
    if (alpha(eColor) != 0 ) { 
      strokeWeight(d_) ;
      stroke(eColor) ;
      point(x_, y_) ;
    } 
      
    
  //  set(int(x_), int(y_), eColor ) ;
  }
  
  //::::::::::::::::::::::::::::::::::::::::::::::::::
  void displayPoint3D(float x_ , float y_ , float z_ ,int d_ , color eColor) {
    if (alpha(eColor) != 0 ) {
      strokeWeight(d_) ;
      stroke(eColor) ;
      point(x_, y_, z_) ;
    }
  }
  
  //:::::::::::::::::::::::::::::::::::::::::::::::::::
  void displayEllipse(float x_ , float y_ ,int d_ , color eColorFill, color eColorStroke, float eThick ) {
    thick = eThick ;
    if (alpha(eColorFill) != 0 && alpha( eColorStroke) != 0  ) {
      strokeWeight(thick) ;
      fill(eColorFill) ;
      stroke(eColorStroke) ;
      ellipse(x_, y_, d_, d_) ;
    } else if (alpha(eColorFill) == 0 ) {
      strokeWeight(thick) ;
      noFill() ;
      stroke(eColorStroke) ;
      ellipse(x_, y_, d_, d_) ;
    } else if (alpha(eColorStroke) == 0 ) {
      noStroke() ;
      fill(eColorFill) ;
      ellipse(x_, y_, d_, d_) ;
    }
  }
}
///////////////////////////////////////////////////
//Special class creat like reference for the rotate
class Ref {
  float x, y;
  Ref() { }
}
/////////////






/////////
//UNIVERS
/////////
class Univers {
  PVector newPos ;
  PVector newVel ;
  // PVector mvt ;
  
 // float nx, ny ;
 // float mvtx, mvty ; 
  
  float r, restitutionBottom, restitutionTop , restitutionRight ,  restitutionLeft  ;
  boolean wallOnOff ;
  
  Univers() {
    newVel = new PVector (1 , 1, 1 ) ; 
  }
  /*
  Univers(float mvtx, float mvty)
  {
    mvtx_ = mvtx ; mvty_ = mvty ; 
  }
  */
  void physicWall2D(float restitutionBottom_, float restitutionTop_, float restitutionRight_, float restitutionLeft_, boolean wallOnOff_ ) {
    restitutionTop    = restitutionTop_ ;  
    restitutionBottom = restitutionBottom_ ; 
    restitutionRight  = restitutionRight_ ;  
    restitutionLeft   = restitutionLeft_ ;
    wallOnOff = wallOnOff_ ;
  }
  
  //void wall(float x_, float y_, float z_, float w_, float h_, float mvtx_, float mvty_)
  void wall2D(PVector pos, PVector vel,  float radiusProton, float radiusElectronicCloud, float rebond_, boolean cloud_, PVector marge ) {
    newPos = pos ;
    newVel = vel ;
    boolean cloud = cloud_ ;  
    if (!cloud ) {
      r = radiusProton ;
    } else {
      r = radiusElectronicCloud ;
    }
    
    //float renderTop = restitutionTop + rebond_ ;
    float renderBottom = restitutionBottom + rebond_ ;
    float renderRight = restitutionRight + rebond_ ;
    //float renderLeft = restitutionLeft + rebond_ ;
    //::::::WALL ON
    if ( wallOnOff ) {
      //wall right
      if (pos.x > width -r +marge.x || pos.x < r -marge.x ) {
      newVel.x = -newVel.x *renderRight ;        
      } else if (pos.y > height -r + marge.y ||pos.y < r -marge.y ) {
        newVel.y = -newVel.y *renderBottom ;    
      }
    }
    
    //::::::WALL OFF
    //wall right
    if ( !wallOnOff ) {
      if (pos.x > width +r + marge.x ) {
        newPos.x = -r -marge.x;
        newVel.x *=+1 ;
        //wall left
      } else if (pos.x < -r -marge.x  ) {
        newPos.x = width +r + marge.x;
        newVel.x *=+1 ;
        //ground  
      } else if (pos.y > height +r + marge.y ) {
        newPos.y = -r -marge.y;
        newVel.x *=+1 ;
        //roof  
      } else if (pos.y < -r -marge.y ) {
        newPos.y =  height +r +marge.y;
        newVel.x *=+1 ;
      }
    }
  }
}
//END UNIVERS
/////////////
