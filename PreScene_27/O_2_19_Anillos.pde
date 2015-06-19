class Anillos extends Romanesco {
 
  public Anillos() {
    romanescoName = "Anillos" ;
    IDobj = 19 ;
    IDgroup = 2 ;
    romanescoAuthor  = "David Robayo";
    romanescoVersion = "Version 0.0.2";
    romanescoPack = "Workshop june 2015" ;
    romanescoMode = "" ; // separate the differentes mode by "/"
    romanescoSlider = "Hue fill,Saturation fill,Brightness fill,Alpha fill,Hue stroke,Saturation stroke,Brightness stroke,Alpha stroke,Thickness,Size X,Quantity,Angle,Amplitude,Analyze" ;
  }
    // declare VAR
  //////////////
  float radius = .1;
  float S = 10;
  float T = 10;
  
 // int N = 25;
  
  float ringX[] ;
  float ringY[] ;
  float ringK[] ;
 
  // Main method
  int NUM_ANNILOS_MAX = 30;
  int num_anillos;
 
  // setup
  void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
    anillos_setting(num_anillos) ;
   
   }

   int num_ref_anillos ;
   // draw
   void display() {
    aspect() ;

    float z = allBeats(IDobj) *10 ;
    float x = mouse[IDobj].x *2 ;
    float y = mouse[IDobj].y *2 ;
    Vec3 mouse_pos = Vec3(x, y, z) ;
   
    inter(mouse_pos, num_anillos) ;
    // display
   

 
    num_anillos = int( NUM_ANNILOS_MAX * quantityObj[IDobj] ) ;
   
    if( num_anillos != num_ref_anillos) {
        anillos_setting(num_anillos) ;
        num_ref_anillos = num_anillos ;
    }
  }
   
   
   
    
   
    // info
   
    /*
    Don't use with peasy cam
    */
    // objectInfo[IDobj] =("Hello, I'm "+IDobj+" and I'm not an integer. Je suis Stéphanie Lebon !!") ;
 
  // annexe void
  void aspect()   {
    stroke(
        hue(strokeObj[IDobj]),
        saturation(strokeObj[IDobj]),
        brightness(strokeObj[IDobj]),
        map(alpha(strokeObj[IDobj]),0.0, 100.0, 0, 30.0)
        );
    strokeWeight(map(thicknessObj[IDobj], 0.1 , height/3, 0, width/12));
  }

  void inter(Vec3 pos, int N)  {
    //println("je suis là", frameCount) ;
    // calcul pos y
    for (int i = 0; i < N; i++) {
      ringY[i] += 0.2 * (N - i) * (pos.x - ringY[i]) / N;
    }
    for (int i = 0; i < N; i++) {
      ringY[i] -= 0.2 * (N - i) * (pos.y - ringY[i]) / N;
    }
   

    // diam
    float diam = radius *sizeXObj[IDobj] *allBeats(IDobj) ;
    float orientation = S *map(angleObj[IDobj],0,360,0,1);
    float effevtiveT = T *analyzeObj[IDobj];
   
    // render
    for (int i = N - 1; i >= 0; i--) {
      fill(hue(0+fillObj[IDobj]), saturation(fillObj[IDobj]), brightness(fillObj[IDobj]), alpha(fillObj[IDobj]));
      float x = ringX[i] -(ringX[i] /2) ;
      float y = ringY[i] -(ringY[i] / 2) ;
      Vec3 new_pos = Vec3(x ,  y, pos.z) ;
      drawCurl(new_pos, diam *ringK[i], -orientation *ringK[i], effevtiveT);
    }
   
     for (int i = 0; i < N; i++) {
      fill(hue(360-fillObj[IDobj]), saturation(fillObj[IDobj]), brightness(fillObj[IDobj]), alpha(fillObj[IDobj]));
      float x = ringX[i] -(ringX[i] /2) ;
      float y = ringY[i] -(ringY[i] / 2) ;
      Vec3 new_pos = Vec3(x ,  y, pos.z) ;
      drawCurl(new_pos, diam *ringK[i], +orientation *ringK[i], effevtiveT);
    }
   
   
  }
 
 
  // set your anillos
  void anillos_setting(int N) {
      ringX = new float[N];
      ringY = new float[N];
      ringK = new float[N];
     for (int i = 0; i < N; i++) {
        ringX[i] = 0.5 * width/2;
        ringY[i] = 0.5 * height/2;
        ringK[i] = i + 1;
     }
   }



  void drawCurl(Vec3 pos, float r, float s, float t) {
      pushMatrix();
      translate(pos.x, pos.y, pos.z);
      beginShape();
      vertex(-r, -t);
      bezierVertex(-r, s - t, +r, s - t, +r, -t);
      vertex(+r, +t);
      bezierVertex(+r, s + t, -r, s + t, -r, +t);
      endShape(CLOSE);
      popMatrix();
  }
}