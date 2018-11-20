/**
ATOME 
2012-2018
v 1.3.7
*/
ArrayList<Atom> atomList ;
//object one
class Atome extends Romanesco {
  public Atome() {
    //from the index_objects.csv
    item_name = "Atome" ;
    item_author  = "Stan le Punk";
    item_version = "version 1.3.7";
    item_pack = "Base 2012-2018" ;
    item_costume = "";
    item_mode = "Chemical Name/File text/Electronic cloud/Ellipse circle/Ellipse triangle/Ellipse cloud/Triangle circle/Triangle triangle/Triangle cloud/Rectangle rectangle/Rectangle cloud" ;

    hue_fill_is = true;
    sat_fill_is = true;
    bright_fill_is = true;
    alpha_fill_is = true;
    hue_stroke_is = true;
    sat_stroke_is = true;
    bright_stroke_is = true;
    alpha_stroke_is = true;
    thickness_is = true;
    size_x_is = true;
    size_y_is = true;
    size_z_is = true;
    diameter_is = true;
    canvas_x_is = true;
    canvas_y_is = true;
    canvas_z_is = false;

    // frequence_is = true;
    speed_x_is = true;
    speed_y_is = false;
    speed_z_is = false;
    spurt_x_is = false;
    spurt_y_is = false;
    spurt_z_is = false;
    dir_x_is = true;
    dir_y_is = false;
    dir_z_is = false;
    jit_x_is = false;
    jit_y_is = false;
    jit_z_is  = false;
    swing_x_is = false;
    swing_y_is = false;
    swing_z_is = false;

    quantity_is = true;
    variety_is = true;
    life_is = false;
    flow_is = false;
    quality_is = false;
    area_is = true;
    angle_is = true;
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
  int KelvinUnivers  ; // Kelvin degree influent on the mouvement of the Atom, at 0°K there is no move !!! 273K° give 273/Kelvin = 1.0 multi reference when the water became ice ! 
  int atomTemperature ;
  float pressure = 1.0 ; // Atmospheric pressure. "1" is earth reference
  // wall of screen
  float restitution = 0.5 ;

  float bottom =    restitution ;
  float top =       restitution ;
  float wallRight = restitution ;
  float wallLeft =  restitution ;

  //Molecule.Atom
  boolean cloud = true ; // To swith ON/OFF phycic of the cloud

  float atomX = 0 ; float atomY = 0 ;
  
  //beat var
  float beatSizeProton = 1 ;
  float beatThicknessCloud = 1 ;
  float beatSizeCloud = 1 ;
  // var for the beat range reactivity
  int rangeA = 0 , rangeB = 0, rangeC  =0  ;
  
  //direction of atome
  PVector newDirection ;
  
  // 3D mode for the objects
  boolean threeDimension ;
  

  
  
  //SETUP
  void setup() {
    setting_start_position(ID_item, width/2, height/2, 0) ; 
    atomList = new ArrayList<Atom>();

    //add one atom to the start
    PVector pos = new PVector (random(width), random(height), 0) ;
    PVector vel = new PVector (random(-1, 1), random(-1, 1), random(-1, 1) ) ;
    int Z = 1 ; // 1 is the hydrogen ID, you can choice between 1 to 118 the last atom knew
    int ion = round(random(0,0));
    float rebound = 0.5 ;
    int diam = 5 ;
    int Kstart = int(abs( mix[ID_item]) *1000) ; // Temperature of Atom, influence the mouvement behavior
    //motion
    Atom atm = new Atom( pos, vel, Z, ion, rebound, diam,  Kstart) ; 
    atomList.add(atm) ;
  }

  //DRAW
  void draw() {
    // SETTING PARAMETER
    load_txt(ID_item) ;
    // 3D or 2D
    if(parameter[ID_item] & key_d) threeDimension = !threeDimension ;
    
    //speed
    float speed = (speed_x_item[ID_item] *100) *(speed_x_item[ID_item] *100) ;
    float velLimit = tempo[ID_item] *5.0 ; // max of speed Atom
    if (velLimit < 1.1 ) velLimit = 1.1 ;
    //the atom temperature give the speed 
    if(sound[ID_item]) atomTemperature =  floor(speed *tempo[ID_item]) ; else atomTemperature = round(speed) ;
    //ratio evolution for atom temperature...give an idea to change the speed of this one
    //because the temp of atom is linked with velocity of this one.
    float tempAbs = 10.0 ;
    
    //VELOCITY and DIRECTION of atom
    if(motion[ID_item]) {
      if(key_space_long && action[ID_item]) {
        newDirection = new PVector (-pen[ID_item].x, -pen[ID_item].y ) ;
      } else { 
        newDirection = normal_direction(int(get_dir_x())) ;
      }
    } else {
      newDirection = new PVector () ;
    }
    
    PVector newVelocity = new PVector (sq(tempo[ID_item]) *1000., sq(tempo[ID_item]) *1000.);
    //security if the value is null to don't stop the move
    float acceleration ; 
    if(pen[ID_item].z == 0 ) acceleration = 1. ; else acceleration = pen[ID_item].z *1000. ;
    
    
    PVector soundDirection = new PVector() ;
    if(sound[ID_item]) soundDirection = new PVector(right[ID_item], left[ID_item]) ; else soundDirection = new PVector(0, 0) ;

    float velocityX = newDirection.x *newVelocity.x *acceleration ;
    float velocityY = newDirection.y *newVelocity.y *acceleration ;
    PVector changeVelocity = new PVector (velocityX, velocityY) ;
    
    // FACTOR SOUND REACTIVITY
    float maxBeat = map(swing_x_item[ID_item],0,1,1,15) ;
    transient_value[1][ID_item] = map(transient_value[1][ID_item],1,10, 1,maxBeat) ;
    transient_value[2][ID_item] = map(transient_value[2][ID_item],1,10, 1,maxBeat) ;
    transient_value[3][ID_item] = map(transient_value[3][ID_item],1,10, 1,maxBeat) ;
    transient_value[4][ID_item] = map(transient_value[4][ID_item],1,10, 1,maxBeat) ;
    
    // thickness
    float thickness = map(thickness_item[ID_item],0, width/3, 0, width/20) ;
    
    // TEXT

    PVector posText = new PVector (0,0,0) ;

    //Canvas
    PVector marge = new PVector(map(canvas_x_item[ID_item], width/10, width, width/20, width *3) , map(canvas_y_item[ID_item], height/10, height, height/20, height *3) ) ;
    
    // SIZE
    float sizeFont = size_x_item[ID_item] ;
    int sizeTextName = int(sizeFont) ;
    int sizeTextInfo = int(sizeFont *.5) ;

    float sizeAtomeRawX = map (size_x_item[ID_item], .1, width, .2, width *.05) ;
    float sizeAtomeRawY = map (size_y_item[ID_item], .1, width, .2, width *.05) ;
    float sizeAtomeRawZ = map (size_z_item[ID_item], .1, width, .2, width *.05) ;
    float sizeAtomeX = sizeAtomeRawX *beatSizeProton ;
    float sizeAtomeY = sizeAtomeRawY *beatSizeProton ;
    float sizeAtomeZ = sizeAtomeRawZ *beatSizeProton ;
    
    //diameter
    float factorSizeField = sizeAtomeX *1.2 ; // factor size of the electronic Atom's Cloud
     //width
    float posTextInfo = map(size_y_item[ID_item], .1, width,sizeAtomeRawX*.2, width*.2) + (transient_value[1][ID_item] *2.0)  ; 
      
      
    
    // DISPLAY and UPDATE ATOM
    for (Atom atm : atomList) {
      // main method
      atm.update (atomTemperature, velLimit, changeVelocity, tempAbs, soundDirection) ; // obligation to use this void, in the atomic univers
      atm.covalentCollision (atomList);
      PVector sizeAtomeXYZ = new PVector(sizeAtomeX,sizeAtomeY,sizeAtomeZ) ;

      //DISPLAY
      //PARAMETER FROM ROMANESCO
      //the proton change the with the beat of music
      int max = 118 ;
      if( (key_n && action[ID_item]) || rangeA == 0 ) {
        rangeA = round(random(0,max-80)) ;
        rangeB = round(random(rangeA,max-40)) ;
        rangeC = round(random(rangeB,max)) ;
      }
      

      if ( atm.getProton() < rangeA ) { 
        beatSizeProton = transient_value[1][ID_item] ;
      } else if ( atm.getProton() > rangeA && atm.getProton() < rangeB ) {
        beatSizeProton = transient_value[2][ID_item] ;
      } else if ( atm.getProton() > rangeB && atm.getProton() < rangeC ) {
        beatSizeProton = transient_value[3][ID_item] ;
      } else if ( atm.getProton()  > rangeC ) {
        beatSizeProton = transient_value[4][ID_item] ;
      }
      /////////////////CLOUD///////////////////////////////////////
      if ( atm.getProton() < 41 ) { 
        beatThicknessCloud = transient_value[1][ID_item] ;
      } else if ( atm.getProton() > 40 && atm.getProton() < 66 ) {
        beatThicknessCloud = transient_value[2][ID_item] ;
      } else if ( atm.getProton() > 65 && atm.getProton() < 91 ) {
        beatThicknessCloud = transient_value[3][ID_item] ;
      } else if ( atm.getProton()  > 90 ) {
        beatThicknessCloud = transient_value[4][ID_item] ;
      }

      

      //MODE OF DISPLAY
      //item_mode = "Chemical Name/File text/Electronic cloud/Ellipse schema/Ellipse cloud/Triangle schema/Triangle cloud/Rectangle schema/Rectangle cloud/Box schema/Box cloud/Sphere schema/Sphere cloud" ;
      if (mode[ID_item] == 0 || mode[ID_item] == 255 ) {
        atm.titleAtom2D (fill_item[ID_item], stroke_item[ID_item], font_item[ID_item], sizeTextName, sizeTextInfo, posTextInfo, angle_item[ID_item]) ; // (color name, color Info, PFont, int sizeTextName,int  sizeTextInfo )
      } else if (mode[ID_item] == 1 ) { 
        atm.title2D(fill_item[ID_item], font_item[ID_item], sizeTextName, posText, angle_item[ID_item]) ;
      } else if (mode[ID_item] == 2 ) {
        atm.display("", "POINT", sizeAtomeXYZ, fill_item[ID_item], stroke_item[ID_item], thickness, angle_item[ID_item]) ;
      } else if (mode[ID_item] == 3 ) {
        if(threeDimension) atm.display("SPHERE", "ELLIPSE", sizeAtomeXYZ, fill_item[ID_item], stroke_item[ID_item], thickness, angle_item[ID_item]) ;
        else atm.display("ELLIPSE", "ELLIPSE", sizeAtomeXYZ, fill_item[ID_item], stroke_item[ID_item], thickness, angle_item[ID_item]) ;
      } else if (mode[ID_item] == 4 ) {
        if(threeDimension) atm.display("SPHERE", "TRIANGLE", sizeAtomeXYZ, fill_item[ID_item], stroke_item[ID_item], thickness, angle_item[ID_item]) ;
        else atm.display("ELLIPSE", "TRIANGLE", sizeAtomeXYZ, fill_item[ID_item], stroke_item[ID_item], thickness, angle_item[ID_item]) ;
      } else if (mode[ID_item] == 5 ) {
        if(threeDimension) atm.display("SPHERE", "POINT", sizeAtomeXYZ, fill_item[ID_item], stroke_item[ID_item], thickness, angle_item[ID_item]) ;
        else atm.display("ELLIPSE", "POINT", sizeAtomeXYZ, fill_item[ID_item], stroke_item[ID_item], thickness, angle_item[ID_item]) ;
      } else if (mode[ID_item] == 6 ) {
        if(threeDimension) atm.display("TETRA", "ELLIPSE", sizeAtomeXYZ, fill_item[ID_item], stroke_item[ID_item], thickness, angle_item[ID_item]) ;
        else atm.display("TRIANGLE", "ELLIPSE", sizeAtomeXYZ, fill_item[ID_item], stroke_item[ID_item], thickness, angle_item[ID_item]) ;
      } else if (mode[ID_item] == 7 ) {
        if(threeDimension) atm.display("TETRA", "TRIANGLE", sizeAtomeXYZ, fill_item[ID_item], stroke_item[ID_item], thickness, angle_item[ID_item]) ;
        else atm.display("TRIANGLE", "TRIANGLE", sizeAtomeXYZ, fill_item[ID_item], stroke_item[ID_item], thickness, angle_item[ID_item]) ;
      } else if (mode[ID_item] == 8 ) {
        if(threeDimension) atm.display("TETRA", "POINT", sizeAtomeXYZ, fill_item[ID_item], stroke_item[ID_item], thickness, angle_item[ID_item]) ;
        else atm.display("TRIANGLE", "POINT", sizeAtomeXYZ, fill_item[ID_item], stroke_item[ID_item], thickness, angle_item[ID_item]) ;
      } else if (mode[ID_item] == 9 ) {
        if(threeDimension) atm.display("BOX", "RECTANGLE", sizeAtomeXYZ, fill_item[ID_item], stroke_item[ID_item], thickness, angle_item[ID_item]) ;
        else atm.display("RECTANGLE", "RECTANGLE", sizeAtomeXYZ, fill_item[ID_item], stroke_item[ID_item], thickness, angle_item[ID_item]) ;
      } else if (mode[ID_item] == 10 ) {
        if(threeDimension) atm.display("BOX", "POINT", sizeAtomeXYZ, fill_item[ID_item], stroke_item[ID_item], thickness, angle_item[ID_item]) ;
        else atm.display("RECTANGLE", "POINT", sizeAtomeXYZ, fill_item[ID_item], stroke_item[ID_item], thickness, angle_item[ID_item]) ;
      }
 

      
      //UNIVERS
      ////////////////////////////////////////////////////////////////////////////////////////////
      atm.universWall2D( bottom, top, wallRight, wallLeft, false, marge) ; // obligation to use this void
      ////////////////////////////////////////////////////////////////////////////////////////////
    }
    
    // info display
    item_info[ID_item] = ("Atoms "+atomList.size()) ;
    

    //CLEAR
    if (reset(ID_item)) atomList.clear() ;
    //ADD ATOM
    int maxValueReproduction = 25 ;
    if(FULL_RENDERING) maxValueReproduction = 1 ; else maxValueReproduction = 25 ;
    int speedReproduction = round(map(quantity_item[ID_item],0, 1, 30, maxValueReproduction));
    if(action[ID_item] && key_n_long && clickLongLeft[ID_item] && frameCount % speedReproduction == 0) atomAdd(giveNametoAtom(), item_setting_position[0][ID_item]) ;
    
    if(atomList.size()<1) {
      int num = int(random(1,9)) ;
      for(int i = 0 ; i < num ; i++ ) {
        atomAdd(giveNametoAtom(), item_setting_position[0][ID_item]) ;
      }
    }

  }
  //END DRAW
  /////////
  
  
  
  
  
  //ANNEXE
  
  //give name to the atom from the file.txt in the source repository
  String giveNametoAtom() {
    String s = ("") ;
    int whichChapter = floor(random(numChapters(text_import[ID_item]))) ;
    int whichSentence = floor(random(numMaxSentencesByChapter(text_import[ID_item]))) ;
    //give a random name, is this one is null in the array, give the tittle name of text
    if(whichSentence(text_import[ID_item], whichChapter, whichSentence) != null ) s = whichSentence(text_import[ID_item], whichChapter, whichSentence) ; else s = whichSentence(text_import[ID_item], 0, 0) ;
    return s ;
  }
  

  //Add atom with a specific name
  void atomAdd(String name, Vec3 newPos) {
    //data
    //amplitude
    //give the field of type of atome must be create
    float numP = map(variety_item[ID_item], 0,1,1,118) ; //
    int Z = int(random (1,numP)) ; // Z is the number of protons give the number of electrons max knew is 118
    int ion = round(random(0,0)); // number of electron(s) less(Anion)   more(Cation)   / give the magnetism & conductivity of the atome cannot be equal or sup to "Z"proton
    
    int Kstart = int(abs( mix[ID_item]) *1000) ; // Temperature of Atom, influence the mouvement behavior

    if (Kstart > 500 ) Kstart = 500 ;
    // physic action & display in the Univers
    float rebound = 0.5 ;
    int diam = 5 ;
    // Atom motion
    float startVel = 1.0 ;
    PVector posA = new PVector (mouse[0].x -newPos.x, mouse[0].y -newPos.y, 0.0) ;
    PVector velA = new PVector (random(-startVel, startVel ), random(-startVel, startVel ), random(-startVel, startVel ) ) ;
    
    for (Atom atm : atomList) {
      if(atm.insideField()) return;
    }
    Atom atm = new Atom(name, posA, velA, Z, ion, rebound, diam,  Kstart) ; 
    atomList.add(atm) ;
  }

}



















///////////
//CLASS ATOM
class Atom {
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
  float diamAtom ;
  float mass, rebound ; // diameter and answer on the wall
  
  //Atomic property
  int  neutron, proton, electron, ion, valenceElectron, missingElectron, freeElectronicSpace ;
  int n = 1 ; // number of electronic shell
  int electronLayer = 0 ; // number of electronic shell
  float screenEffect = 1.0  ; 
  float electroNegativity = 0.0 ; // Electronegativity of atom 

  float mgt ; // ionic load : give the magnetism atom
  float amplitudeElectrocField = 1.0 ; // default parameter of the amplitude of electronic field
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
  Atom (PVector pos_, PVector vel_, float rebound_, int d_ ) {
    pos = pos_  ;
    vel = vel_  ;
    rebound = rebound_ ; 
    diamAtom = d_ ;
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
    rebound = rebound_ ; 
    diamAtom = d_ ;
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
    rebound = rebound_ ; 
    diamAtom = d_ ;
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
  void update(int Kelvin_univers, float velLimit, PVector changeVel, float tempAbs, PVector jitterDirection) { 
    float jitterX = map(random(jitterDirection.x), 0, 1, -1, 1) ;
    float jitterY = map(random(jitterDirection.y), 0, 1, -1, 1) ;
    vel.x = changeVel.x *jitterX ;
    vel.y = changeVel.y *jitterY;
    
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
        if (collide(target, target.radius(), radius()) ) {
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
    if (!target.covalentBondLast || !covalentBondLast ) {
      resolveCollision(target , atomVect) ;
      resolveCollision(target , atomVect) ;
    }  else {
      // new motion of atom when is lock together//
      float factorAddMotion = 2.0 ; // 2.0 is average motion factor
      PVector newVel = new PVector ( (vel.x + target.vel.x) /factorAddMotion , (vel.y + target.vel.y) /factorAddMotion ) ;
      target.vel = newVel ;
      vel  = newVel ;
    }
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
  void display(String core, String cloud, PVector size, color colorFill, color colorStroke, float thickness, float orientation) {
    aspect_rope(colorFill, colorStroke, thickness) ;
    //check size
    PVector temp_size = size.copy();
    temp_size.mult(diamAtom);
    size.set(temp_size);
    
    
    pushMatrix() ;
    translate(pos.x, pos.y) ;
    rotateX(radians(orientation)) ;
    // CORE
    if(core.equals("ELLIPSE")) coreEllipse(size) ;
    if(core.equals("RECTANGLE")) coreRect(size) ;
    if(core.equals("TRIANGLE")) coreTriangle(size) ;
    if(core.equals("SPHERE")) coreSphere(size) ;
    if(core.equals("BOX")) coreBox(size) ;
    if(core.equals("TETRA")) coreTetra(size) ;
    
    //CLOUD
    if(cloud.equals("ELLIPSE")) cloudEllipse(size.x *.2) ;
    if(cloud.equals("RECTANGLE")) cloudRectangle(size.x *.2) ;
    if(cloud.equals("TRIANGLE")) cloudTriangle(size.x *.2) ;
    if(cloud.equals("POINT")) {
      // special appearance for the point because Processing use the stroke for the point
      stroke(colorFill) ;
      strokeWeight(thickness *2.) ;
      cloudPoint(size.x *.2) ;
      aspect_rope(colorFill, colorStroke,thickness) ;
    }
    
    popMatrix() ;   
  }
  
  

  // DISPLAY TEXT and MISC
  ////////////////////////
  // text from main program
  /*
  void title2D(String title, color cName, PFont p, int sizeText, PVector posText, float orientation) {
    if (alpha(cName) != 0 ) {
      fill(cName); textFont(p, sizeText);
      textAlign(CENTER);
      text(title , pos.x +posText.x , pos.y +posText.y );
    }
  }
  */
  void title2D(color colorText, PFont p, int sizeText, PVector posText, float orientation) {
    if ( alpha(colorText) != 0 ) {
      fill(colorText); textFont(p, sizeText);
      textAlign(CENTER) ;
      
      pushMatrix() ;
      translate(pos.x, pos.y) ;
      rotateX(radians(orientation)) ;
      text(nickName ,posText.x,posText.y);
      popMatrix() ;
    }
  }
  /////////////////////DISPLAY PROPERTY of ATOM////////////////////////////////////////////
  void titleAtom2D (color colorText, color colorInfo, PFont p, int sizeTextName, int sizeTextInfo, float amp_, float orientation) {
    ampInfo = amp_ ;
    float posXtext = (n *diamAtom *ampInfo) *0.35 ;
    float posYtext = sizeTextName *0.25 *(ampInfo/10.0) ;
    pushMatrix() ;
    translate(pos.x, pos.y) ;
    rotateX(radians(orientation)) ;
      
    if ( alpha(colorText) != 0 ) {
      fill(colorText); textFont(p, sizeTextName);
      textAlign(CENTER);

      text(nameAtom[proton] ,0 , posYtext );
    }
    //Info
    if ( alpha(colorInfo) != 0 ) {
      fill(colorInfo); textFont(p, sizeTextInfo);
      textAlign (LEFT) ; 
      text(ion,              posXtext , -posYtext );
      text(valenceElectron,  posXtext ,  2.3 *posYtext);
      textAlign (RIGHT) ; 
      text(proton,           -posXtext , 2.3 *posYtext);
      text(round(mass),      -posXtext , -posYtext); 

    }
    popMatrix() ;
  } 
  
  
  
  
  
  // ANNEXE DISPLAY
  // CORE 2D
  void coreTriangle(PVector size) {
    primitive(Vec2(),size.x,3) ;
  }
  void coreEllipse(PVector size) {
    ellipse(0,0,size.x, size.y) ;
  }
  
  void coreRect(PVector size) {
    rectMode(CENTER) ;
    rect(0,0,size.x, size.y) ;
    rectMode(CORNER) ;
  }
  
  // CORE 3D
  void coreSphere(PVector size) {
    int minFace = 10 ;
    int maxFace = 25 ;
    sphere(size.x *.4) ;
    int face ;
    face = int(size.x * .2) ;
    if(face < minFace ) face = minFace; else if(face > maxFace ) face = maxFace ;
    sphereDetail(face) ;
  }
  
  void coreBox(PVector size) {
    box(size.x, size.y, size.z) ;
  }
  
  void  coreTetra(PVector size) {
    int diam = (int)size.x ;
    polyhedron("TETRAHEDRON", "VERTEX", diam) ;
  }
  
  
  
  
  //CLOUD 
  
  
  void cloudEllipse(float newAmplitudeElectrocField) {
    electronicInfo() ;
    noFill() ;
    ellipse (0, 0, radiusElectronicFieldCovalent() *newAmplitudeElectrocField, radiusElectronicFieldCovalent() *newAmplitudeElectrocField ) ;
    ellipse (0, 0, radiusElectronicField() *newAmplitudeElectrocField,     radiusElectronicField() *newAmplitudeElectrocField ) ;
  }
  
  void cloudRectangle(float newAmplitudeElectrocField) {
    electronicInfo() ;
    noFill() ;
    rect(0, 0, radiusElectronicFieldCovalent() *newAmplitudeElectrocField, radiusElectronicFieldCovalent() *newAmplitudeElectrocField ) ;
    rect(0, 0, radiusElectronicField() *newAmplitudeElectrocField,     radiusElectronicField() *newAmplitudeElectrocField ) ;
  }
  
  void cloudTriangle(float newAmplitudeElectrocField) {
    electronicInfo() ;
    noFill() ; 
    float radius = radiusElectronicFieldCovalent() *newAmplitudeElectrocField ;
    primitive(Vec2(),radius,3) ;
    primitive(Vec2(),radius,3) ;
  }
  
  // CLOUD POINT
  void cloudPoint(float newAmplitudeElectrocField) {
    addElectron() ;
    electronicInfo() ;
    cloud = true ;
    PVector posElectron = new PVector() ; 
    float ElectronicCloud = radiusElectronicField() *.5 *newAmplitudeElectrocField;
    
    //
    for (Electron electron : listE) {
      float randomEx = random( -ElectronicCloud, ElectronicCloud ) ;
      float randomEy = random( -ElectronicCloud, ElectronicCloud ) ;
      
      // check if the electron are in the diameter
      
      if (sqrt(sq(randomEx) + sq(randomEy)) > ElectronicCloud) {
        posElectron.x = -ElectronicCloud ;
        posElectron.y = -ElectronicCloud ;
      } else {
        
        posElectron.x = randomEx ;
        posElectron.y = randomEy ;
        point(posElectron.x,posElectron.y) ;
        // electron.displayPoint2D(posElectron, thickness, colorFill) ; 
      }
    }
  }
  // END DISPLAY
  //////////////
  

  /////////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////EXTERNAL INFLUENCE///////////////////////////////////////////////////
  // Wall border
  void universWall2D(float restitutionBottom_, float restitutionTop_, float restitutionRight_, float restitutionLeft_, boolean wallOnOff_, PVector marge) {
    nvrs.physicWall2D(restitutionBottom_, restitutionTop_, restitutionRight_, restitutionLeft_, wallOnOff_) ;
    nvrs.wall2D(pos, vel, radius(), radiusElectronicField(), rebound, cloud, marge ) ;
  }  
  //

   
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
    return  PI*sq(diamAtom/2) ;   
  }
  //:::::::::::::::RADIUS:::::::::::::::::::
  //:::::::::::::::Return the radius of atom
  float radius() { 
    return diamAtom / 2;
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
    
    REF = diamAtom *amplitudeElectrocField *ratioSizeAtom  ;
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
    if (newPosAtom == 0 ) ratioSizeAtom = newPosAtom ; else ratioSizeAtom = newPosAtom / ((3.0 - pow(newPosAtom, 5)  ) -newPosAtom) ; 
    
    ratioSizeAtom = 1 + ( ratioSizeAtom *ratioPeriodic *base ) ;
    
    REFC = diamAtom *amplitudeElectrocField *ratioSizeAtom *0.8 ;
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
  
  
  
  
  
  
  
  // ANNEXE
  //Optional void atom

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
  // END ANNEXE
  
}

// END CLASS ATOM
/////////////////









//////////////////////////
//SUPER CLASS ELECTRON to create a list of electron
class Electron {
  Electron() {}
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
      if (pos.x > -r +marge.x || pos.x < r -marge.x ) {
      newVel.x = -newVel.x *renderRight ;        
      } else if (pos.y > -r +marge.y ||pos.y < r -marge.y ) {
        newVel.y = -newVel.y *renderBottom ;    
      }
    }
    
    //::::::WALL OFF
    //wall right
    if ( !wallOnOff ) {
      if (pos.x > +r + marge.x ) {
        newPos.x = -r -marge.x;
        newVel.x *=+1 ;
        //wall left
      } else if (pos.x < -r -marge.x  ) {
        newPos.x = +r + marge.x;
        newVel.x *=+1 ;
        //ground  
      } else if (pos.y > +r + marge.y ) {
        newPos.y = -r -marge.y;
        newVel.x *=+1 ;
        //roof  
      } else if (pos.y < -r -marge.y ) {
        newPos.y =  +r +marge.y;
        newVel.x *=+1 ;
      }
    }
  }
}
//END UNIVERS
/////////////