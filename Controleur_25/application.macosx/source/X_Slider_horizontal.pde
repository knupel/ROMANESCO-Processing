class SliderHorizontal {
  int posX ;
  int longueurSlider, hauteurSlider;    // width et height de la réglette
  int xpos, ypos;         // x and y position de la réglette
  float spos, newspos;    // x position de la molette
  int sposMin, sposMax;   // valeurs maximales et mininmales de la réglette
  int suivit, posCur;              // how loose/heavy
  int transp ;
  boolean dedans, locked ;           
  color bOUT, bIN, rglt ;
  float rapportDepart = 80.0 ;
  float rapportChargement = 1.0 ;
  //MIDI
  int newValMidi ;
  int IDmidi = -2 ;

  SliderHorizontal (int xp, int yp, int LSlider, int HSlider, int s, color boutonOUT, color boutonIN, color reglette, int transparence, float pC, int IDmidi) {
    this.IDmidi = IDmidi ;
    longueurSlider = LSlider;   
    hauteurSlider = HSlider;              
    suivit = s;
    xpos = xp;          
    ypos = yp-hauteurSlider/2;
    float lh = float(longueurSlider) ;
    
    //molette position
    spos = xpos + (pC / (100.0 + ((11.0/lh)*rapportDepart)) *LSlider); 
    newspos = spos;
    
    sposMin = xpos;    sposMax = xpos + longueurSlider - hauteurSlider;
    bOUT = boutonOUT ;  bIN = boutonIN ; rglt = reglette   ; transp = transparence ;
    
  }
  
  //DISPLAY MOLETTE
  void displayMolette(color cIn, color cOut, color colorOutline, PVector size, PVector correctionPos) {
    
    if( xpos != 0 && ypos != 0) {
      fill(rglt, transp);
      stroke(colorOutline) ; 
      strokeWeight(size.z) ;
      //noStroke() ;
      if(dedans || locked) fill(cIn); else fill(cOut);
      //display  
      float factorSize = 1.0 ;
      ellipse(spos +(size.y *.5) +correctionPos.x, ypos-3 +(size.y *.5) +correctionPos.y, size.y *factorSize, size.y *factorSize);
      noStroke() ;
    }   
  }


  

  
  void update(int currentX, int saveX, boolean save) {
    int NLX ;
    float NloadX ;
    float lh = float(longueurSlider) ;
    NloadX = xpos + (saveX / (100.0 + ( (11.0/lh)*rapportChargement) ) *longueurSlider);
    NLX = round(NloadX) ;
    // Choix entre le chargement des sauvegarde de position ou les coordonnées de la souris
    if(save) posX = NLX ; else posX = currentX ;
   
   if(dedans()) dedans = true ; else dedans = false ;
   if(mousePressed && dedans) locked = true ;
   if(!mousePressed) locked = false ;
   
   if(locked || save)newspos = constrain(posX-hauteurSlider/2, sposMin, sposMax);

    if(abs(newspos - spos) > 1) {
      spos = spos +(newspos-spos)/suivit;
    }
  }

  int constrain(int val, int minv, int maxv) {
    return min(max(val, minv), maxv);
  }
  
  // update position from midi controller
  void updateMidi(int val) {
    //update the Midi position only if the Midi Button move
    if (newValMidi != val) { 
      newValMidi = val ; 
      newspos = map(val, 1, 127, sposMin, sposMax ) ;
      posX = newValMidi ; 
    }
  }
  
  //////
  //VOID
  void load(int loadX) {
    float lh = float(longueurSlider) ;
    spos = xpos + (loadX / (100.0 + ( (11.0/lh)*rapportChargement) ) * longueurSlider);
  }
  // give the ID from the controller Midi
  void selectIDmidi(int num) { IDmidi = num ; }
  
  ////////
  //RETURN
  //give the IDmidi 
  int IDmidi() { return IDmidi ; }
  //return the state
  boolean lock() { return locked ; }
  //rollover
  boolean dedans() {
    if(mouseX > spos && mouseX < spos+hauteurSlider &&
       mouseY > ypos && mouseY < ypos+hauteurSlider) {  
      return true;
    } else return false;
  }
  //return pos
  float getPos() { // nom de variable et () permet de récupérer les données d'un return
    return (((spos-xpos)/longueurSlider)-0.004) *111 ;
  }
}
