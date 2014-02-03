class RegletteHorizontale
{
  int posX ;
  int longueurRH, hauteurRH;    // width et height de la réglette
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

  RegletteHorizontale (int xp, int yp, int LRH, int HRH, int s, color boutonOUT, color boutonIN, color reglette, int transparence, int pC, int IDmidi) 
  {
    this.IDmidi = IDmidi ;
    int widthtoheight = LRH - HRH;
    
    longueurRH = LRH;   hauteurRH = HRH;              suivit = s;
    xpos = xp;          ypos = yp-hauteurRH/2;
    float h = float(hauteurRH) ;
    float lh = float(longueurRH) ;
    
    //molette position
    spos = xpos + (pC / (100.0 + ( (11.0/lh)*rapportDepart) ) * LRH); 
    newspos = spos;
    
    sposMin = xpos;    sposMax = xpos + longueurRH - hauteurRH;
    bOUT = boutonOUT ;  bIN = boutonIN ; rglt = reglette   ; transp = transparence ;
    
  }
  //DISPLAY
  void display() {
    fill(rglt, transp);
    rect(xpos, ypos, longueurRH, hauteurRH); // affichage de la réglette
    stroke(blanc) ; strokeWeight(1) ;
    if(dedans || locked) {
      fill(bIN);
      chargement = false ;
    } else {
      fill(bOUT);
    }
    //affichage molette   
    rect(spos, ypos-3, hauteurRH-2, hauteurRH+4);
    noStroke() ;   
  }


  

  
  void update(int curseurX, int loadX ) {
    int NLX ;
    float NloadX ;
    float lh = float(longueurRH) ;
    NloadX = xpos + (loadX / (100.0 + ( (11.0/lh)*rapportChargement) ) * longueurRH);
    NLX = round(NloadX) ;
    // Choix entre le chargement des sauvegarde de position ou les coordonnées de la souris
    if(chargement ) {
      posX = NLX ; 
    } else { 
      posX = curseurX ; 
    }
   
   if(dedans()) dedans = true ; else dedans = false ;
   if(mousePressed && dedans) locked = true ;
   if(!mousePressed) locked = false ;
   
   if(locked || chargement) {
      newspos = constrain(posX-hauteurRH/2, sposMin, sposMax);
    }

    if(abs(newspos - spos) > 1) {
      restart() ; // this line is from the main program to make a activityCount to zero
      spos = spos + (newspos-spos)/suivit;
    }
  }

  int constrain(int val, int minv, int maxv) {
    return min(max(val, minv), maxv);
  }
  
  // update position from midi controller
  void updateMidi(int val) {
    //update the Midi position only if the Midi Button move
    if ( newValMidi != val ) { 
      newValMidi = val ; 
      newspos = map(val, 1, 127, sposMin, sposMax ) ;
      posX = newValMidi ; 
    }
    // val = map(val,1,128, 0, width ) ; 

  }
  
  //////
  //VOID
  void load(int loadX) {
    float lh = float(longueurRH) ;
    spos = xpos + (loadX / (100.0 + ( (11.0/lh)*rapportChargement) ) * longueurRH);
    println(loadX + " / " + spos) ;
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
    if(mouseX > spos && mouseX < spos+hauteurRH &&
       mouseY > ypos && mouseY < ypos+hauteurRH) {  
      return true;
    } else {
      return false;
    }
  }
  //return pos
  float getPos() { // nom de variable et () permet de récupérer les données d'un return
    return (((spos-xpos)/longueurRH)-0.004) *111 ;
  }


  
}
