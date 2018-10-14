/**
ROPE PGraphics LAYER METHOD
2018-2018
v 0.2.1
those ghost method is here like a filter between rope and Processing 
in case the coder want use a PGraphics layer before to implement in the Processing rendering
*/
/**
Layer method
*/
PGraphics [] rope_layer;
boolean warning_rope_layer;
int which_rope_layer = 0;

// init
void init_layer() {
  init_layer(width,height,get_renderer(),1);
}


void init_layer(int num) {
  init_layer(width,height,get_renderer(),num);
}

void init_layer(int x, int y) {
  init_layer(x,y, get_renderer(),1);
}

void init_layer(int x, int y, int num) {
  init_layer(x,y, get_renderer(),num);
}

void init_layer(int x, int y, String type, int num) {
  rope_layer = new PGraphics[num];
  for(int i = 0 ; i < num ; i++) {
    rope_layer[i] = createGraphics(x,y,type);
  }
  
  if(!warning_rope_layer) {
    warning_rope_layer = true;
  }
  String warning = ("WARNING LAYER METHOD\nAll classical method used on the main rendering,\nwill return the PGraphics selected PGraphics layer :\nimage(), set(), get(), fill(), stroke(), rect(), ellipse(), pushMatrix(), popMatrix(), box()...\nto use those methods on the main PGraphics write g.image() for example");
  printErr(warning);
}

// begin and end draw
void begin_layer() {
  if(get_layer() != null) {
    get_layer().beginDraw();
  }
}

void end_layer() {
  if(get_layer() != null) {
    get_layer().endDraw();
  }
}

// num
int get_layer_num() {
  if(rope_layer != null) {
    return  rope_layer.length ;
  } else return -1;  
}

// clear layer
void clear_layer() {
  if(rope_layer != null && rope_layer.length > 0) {
    for(int i = 0 ; i < rope_layer.length ; i++) {
      String type = get_renderer(rope_layer[i]);
      int w = rope_layer[i].width;
      int h = rope_layer[i].height;
      rope_layer[i] = createGraphics(w,h,type);
    }
  } else {
    String warning = ("void clear_layer(): there is no layer can be clear maybe you forget to create one :)");
    printErr(warning);
  }
  
}


void clear_layer(int target) {
  if(target > -1 && target < rope_layer.length) {
     String type = get_renderer(rope_layer[target]);
    int w = rope_layer[target].width;
    int h = rope_layer[target].height;
    rope_layer[target] = createGraphics(w,h,type);
  } else {
    String warning = ("void clear_layer(int target): target "+target+" is out the range of the layers available,\n no layer can be clear");
    printErr(warning);
  }
}




/**
GET LAYER
* May be the method can be improve by using a PGraphics template for buffering instead usin a calling method ????
*/
// get layer
PGraphics get_layer() {
  return get_layer(which_rope_layer);
}


PGraphics get_layer(int target) {
  if(rope_layer == null) {
//    printErrTempo(180,"void get_layer(): Your layer system has not been init use method init_layer() in first",frameCount);
    return g;
  } else if(target > -1 && target < rope_layer.length) {
    return rope_layer[target];
  } else {
    String warning = ("PGraphics get_layer(int target): target "+target+" is out the range of the layers available,\n instead target 0 is used");
    printErr(warning);
    return rope_layer[0];
  }
}











// select layer
void select_layer(int target) {
  if(rope_layer != null) {
    if(target > -1 && target < rope_layer.length) {
      which_rope_layer = target;
    } else {
      which_rope_layer = 0;
      String warning = ("void select_layer(int target): target "+target+" is out the range of the layers available,\n instead target 0 is used");
      printErr(warning);
    }
  } else {
    printErrTempo(180,"void select_layer(): Your layer system has not been init use method init_layer() in first",frameCount);
  }
  
}




  
// colorMode
void colorMode(int mode) {
  if(get_layer() != null) {
    get_layer().colorMode(mode);
  } else {
    g.colorMode(mode);
  }
}

void colorMode(int mode, float max) {
  if(get_layer() != null) {
    get_layer().colorMode(mode,max);
  } else {
    g.colorMode(mode,max);
  } 
}


void colorMode(int mode, float max1, float max2, float max3) {
  if(get_layer() != null) {
    get_layer().colorMode(mode,max1,max2,max3);
  } else {
    g.colorMode(mode,max1,max2,max3);
  }
}
void colorMode(int mode, float max1, float max2, float max3, float maxA) {
  if(get_layer() != null) {
    get_layer().colorMode(mode,max1,max2,max3,maxA);
  } else {
    g.colorMode(mode,max1,max2,max3,maxA);
  }
}




// Processing ghost method

// position
void translate(int x, int y) {
  if(get_layer() != null) {
    get_layer().translate(x,y);
  } else {
    g.translate(x,y);
  }
}

void translate(int x, int y, int z) {
  if(get_layer() != null) {
    get_layer().translate(x,y,z);
  } else {
    g.translate(x,y,z);
  }
}


// rotate
void rotate(float arg) {
  if(get_layer() != null) {
    get_layer().rotate(arg);
  } else {
    g.rotate(arg);
  }
}


void rotateX(float arg) {
  if(get_layer() != null) {
    get_layer().rotateX(arg);
  } else {
    g.rotateX(arg);
  }
}

void rotateY(float arg) {
  if(get_layer() != null) {
    get_layer().rotateY(arg);
  } else {
    g.rotateY(arg);
  }
}


void rotateZ(float arg) {
  if(get_layer() != null) {
    get_layer().rotateZ(arg);
  } else {
    g.rotateZ(arg);
  }
}

// scale
void scale(float s) {
  if(get_layer() != null) {
    get_layer().scale(s);
  } else {
    g.scale(s);
  }
}

void scale(float x, float y) {
  if(get_layer() != null) {
    get_layer().scale(x,y);
  } else {
    g.scale(x,y);
  }
}

void scale(float x, float y, float z) {
  if(get_layer() != null) {
    get_layer().scale(x,y,z);
  } else {
    g.scale(x,y,z);
  }
}

// shear
void shearX(float angle) {
  if(get_layer() != null) {
    get_layer().shearX(angle);
  } else {
    g.shearX(angle);
  }
}

void shearY(float angle) {
  if(get_layer() != null) {
    get_layer().shearY(angle);
  } else {
    g.shearY(angle);
  }
}













/**
aspect
*/
// fill
void noFill() {
  if(get_layer() != null) {
    get_layer().noFill();
  } else {
    g.noFill();
  }
} 

void fill(int rgb) {
  if(get_layer() != null) {
    get_layer().fill(rgb);
  } else {
    g.fill(rgb);
  }
}


void fill(int rgb, float alpha) {
  if(get_layer() != null) {
    get_layer().fill(rgb,alpha);
  } else {
    g.fill(rgb,alpha);
  }
}

void fill(float gray) {
  if(get_layer() != null) {
    get_layer().fill(gray);
  } else {
    g.fill(gray);
  }
}


void fill(float gray, float alpha) {
  if(get_layer() != null) {
    get_layer().fill(gray,alpha);
  } else {
    g.fill(gray,alpha);
  }
}

void fill(float v1, float v2, float v3) {
  if(get_layer() != null) {
    get_layer().fill(v1,v2,v3);
  } else {
    g.fill(v1,v2,v3);
  }
}

void fill(float v1, float v2, float v3, float alpha) {
  if(get_layer() != null) {
    get_layer().fill(v1,v2,v3,alpha);
  } else {
    g.fill(v1,v2,v3,alpha);
  }
}

// stroke
void noStroke() {
  if(get_layer() != null) {
    get_layer().noStroke();
  } else {
    g.noStroke();
  }
} 

void stroke(int rgb) {
  if(get_layer() != null) {
    get_layer().stroke(rgb);
  } else {
    g.stroke(rgb);
  }
}


void stroke(int rgb, float alpha) {
  if(get_layer() != null) {
    get_layer().stroke(rgb,alpha);
  } else {
    g.stroke(rgb,alpha);
  }
}

void stroke(float gray) {
  if(get_layer() != null) {
    get_layer().stroke(gray);
  } else {
    g.stroke(gray);
  }
}


void stroke(float gray, float alpha) {
  if(get_layer() != null) {
    get_layer().stroke(gray,alpha);
  } else {
    g.stroke(gray,alpha);
  }
}

void stroke(float v1, float v2, float v3) {
  if(get_layer() != null) {
    get_layer().stroke(v1,v2,v3);
  } else {
    g.stroke(v1,v2,v3);
  }
}

void stroke(float v1, float v2, float v3, float alpha) {
  if(get_layer() != null) {
    get_layer().stroke(v1,v2,v3,alpha);
  } else {
    g.stroke(v1,v2,v3,alpha);
  }
}


// strokeWeight
void strokeWeight(float thickness) {
  if(get_layer() != null) {
    get_layer().strokeWeight(thickness);
  } else {
    g.strokeWeight(thickness);
  }
}

// strokeJoin
void strokeJoin(int join) {
  if(get_layer() != null) {
    get_layer().strokeJoin(join);
  } else {
    g.strokeJoin(join);
  }
}

// strokeJoin
void strokeCapstrokeCap(int cap) {
  if(get_layer() != null) {
    get_layer().strokeCap(cap);
  } else {
    g.strokeCap(cap);
  }
}












/**
shape
*/
// rect
void rect(int px, int py, int sx, int sy) {
  if(get_layer() != null) {
    get_layer().rect(px,py,sx,sy);
  } else {
    g.rect(px,py,sx,sy);
  }
}


void rect(int px, int py, int sx, int sy, float r) {
  if(get_layer() != null) {
    get_layer().rect(px,py,sx,sy,r);
  } else {
    g.rect(px,py,sx,sy,r);
  }
}

void rect(int px, int py, int sx, int sy, float tl, float tr, float br, float bl) {
  if(get_layer() != null) {
    get_layer().rect(px,py,sx,sy,tl,tr,br,bl);
  } else {
    g.rect(px,py,sx,sy,tl,tr,br,bl);
  }
}


//arc
void arc(float a, float b, float c, float d, float start, float stop) {
  if(get_layer() != null) {
    get_layer().arc(a,b,c,d,start,stop);
  } else {
    g.arc(a,b,c,d,start,stop);
  }
}

void arc(float a, float b, float c, float d, float start, float stop, int mode) {
  if(get_layer() != null) {
    get_layer().arc(a,b,c,d,start,stop,mode);
  } else {
    g.arc(a,b,c,d,start,stop,mode);
  }
}

// ellipse
void ellipse(int px, int py, int sx, int sy) {
  if(get_layer() != null) {
    get_layer().ellipse(px,py,sx,sy);
  } else {
    g.ellipse(px,py,sx,sy);
  }
}




// box
void box(int s) {
  if(get_layer() != null) {
    get_layer().box(s,s,s);
  } else {
    g.box(s,s,s);
  }
}

void box(int w, int h, int d) {
  if(get_layer() != null) {
    get_layer().box(w,h,d);
  } else {
    g.box(w,h,d);
  }
}


// sphere
void sphere(float r) {
  if(get_layer() != null) {
    get_layer().sphere(r);
  } else {
    g.sphere(r);
    // p.sphere(r);
  }
}


// sphere detail
void sphereDetail(int res) {
  if(get_layer() != null) {
    get_layer().sphereDetail(res);
  } else {
    g.sphereDetail(res);
  }
}

void sphereDetail(int ures, int vres) {
  if(get_layer() != null) {
    get_layer().sphereDetail(ures,vres);
  } else {
    g.sphereDetail(ures,vres);
  }
}




//line
void line(float x1, float y1, float x2, float y2) {
  if(get_layer() != null) {
    get_layer().line(x1,y1,x2,y2);
  } else {
    g.line(x1,y1,x2,y2);
  }
}

void line(float x1, float y1, float z1, float x2, float y2, float z2) {
  if(get_layer() != null) {
    get_layer().line(x1,y1,z1,x2,y2,z2);
  } else {
    g.line(x1,y1,z1,x2,y2,z2);
  }
}






// point
void point(float x, float y) {
  if(get_layer() != null) {
    get_layer().point(x,y);
  } else {
    g.point(x,y);
  }
}

void point(float x, float y, float z) {
  if(get_layer() != null) {
    get_layer().point(x,y,z);
  } else {
    g.point(x,y,z);
  }
}

// quad
void quad(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  if(get_layer() != null) {
    get_layer().quad(x1,y1,x2,y2,x3,y3,x4,y4);
  } else {
    g.quad(x1,y1,x2,y2,x3,y3,x4,y4);
  }
}

// triangle
/*
method already use somewhere else
void triangle(float x1, float y1, float x2, float y2, float x3, float y3) {
  if(get_layer() != null) {
    get_layer().triangle(x1,y1,x2,y2,x3,y3);
  } else {
    g.triangle(x1,y1,x2,y2,x3,y3);
  }
}
*/


/**
vertex
*/
// begin
void beginShape() {
  if(get_layer() != null) {
    get_layer().beginShape();
  } else {
    g.beginShape();
  }
}

void beginShape(int kind) {
  if(get_layer() != null) {
    get_layer().beginShape(kind);
  } else {
    g.beginShape(kind);
  }
}


void endShape() {
  if(get_layer() != null) {
    get_layer().endShape();
  } else {
    g.endShape();
  }
}

void endShape(int mode) {
  if(get_layer() != null) {
    get_layer().endShape(mode);
  } else {
    g.endShape(mode);
  }
}




// shape
void shape(PShape shape) {
  if(get_layer() != null) {
    get_layer().shape(shape);
  } else {
    g.shape(shape);
  }
}

void shape(PShape shape, float x, float y) {
  if(get_layer() != null) {
    get_layer().shape(shape,x,y);
  } else {
    g.shape(shape,x,y);
  }
}

void shape(PShape shape, float a, float b, float c, float d) {
  if(get_layer() != null) {
    get_layer().shape(shape,a,b,c,d);
  } else {
    g.shape(shape,a,b,c,d);
  }
}








  




//vertex
void vertex(float x, float y) {
  if(get_layer() != null) {
    get_layer().vertex(x,y);
  } else {
    g.vertex(x,y);
  }
}

void vertex(float x, float y, float z) {
  if(get_layer() != null) {
    get_layer().vertex(x,y,z);
  } else {
    g.vertex(x,y,z);
  }
}

void vertex(float [] v) {
  if(get_layer() != null) {
    get_layer().vertex(v);
  } else {
    g.vertex(v);
  }
}

void vertex(float x, float y, float u, float v) {
  if(get_layer() != null) {
    get_layer().vertex(x,y,u,v);
  } else {
    g.vertex(x,y,u,v);
  }
} 


void vertex(float x, float y, float z, float u, float v) {
  if(get_layer() != null) {
    get_layer().vertex(x,y,z,u,v);
  } else {
    g.vertex(x,y,z,u,v);
  }
}  


// quadratic vertex
void quadraticVertex(float cx, float cy, float x3, float y3) {
  if(get_layer() != null) {
    get_layer().quadraticVertex(cx,cy,x3,y3);
  } else {
    g.quadraticVertex(cx,cy,x3,y3);
  }
}

void quadraticVertex(float cx, float cy, float cz, float x3, float y3, float z3) {
  if(get_layer() != null) {
    get_layer().quadraticVertex(cx,cy,cz,x3,y3,z3);
  } else {
    g.quadraticVertex(cx,cy,cz,x3,y3,z3);
  }
}

// curve vertex
void curveVertex(float x, float y) {
  if(get_layer() != null) {
    get_layer().curveVertex(x,y);
  } else {
    g.curveVertex(x,y);
  }
}

void curveVertex(float x, float y, float z) {
  if(get_layer() != null) {
    get_layer().curveVertex(x,y,z);
  } else {
    g.curveVertex(x,y,z);
  }
}


//bezier vertex
void bezierVertex(float x2, float y2, float x3, float y3, float x4, float y4) {
  if(get_layer() != null) {
    get_layer().bezierVertex(x2,y2,x3,y3,x4,y4);
  } else {
    g.bezierVertex(x2,y2,x3,y3,x4,y4);
  }
}


void bezierVertex(float x2, float y2, float z2, float x3, float y3, float z3, float x4, float y4, float z4) {
  if(get_layer() != null) {
    get_layer().bezierVertex(x2,y2,z2,x3,y3,z3,x4,y4,z4);
  } else {
    g.bezierVertex(x2,y2,z2,x3,y3,z3,x4,y4,z4);
  }
}

// bezier
void bezier(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  if(get_layer() != null) {
    get_layer().bezier(x1,y1,x2,y2,x3,y3,x4,y4);
  } else {
    g.bezier(x1,y1,x2,y2,x3,y3,x4,y4);
  }
}

void bezier(float x1, float y1, float z1, float x2, float y2, float z2, float x3, float y3, float z3, float x4, float y4, float z4) {
  if(get_layer() != null) {
    get_layer().bezier(x1,y1,z1,x2,y2,z2,x3,y3,z3,x4,y4,z4);
  } else {
    g.bezier(x1,y1,z1,x2,y2,z2,x3,y3,z3,x4,y4,z4);
  }
}

// bezier detail
void bezierDetail(int detail) {
  if(get_layer() != null) {
    get_layer().bezierDetail(detail);
  } else {
    g.bezierDetail(detail);
  }
}

// curve
void curve(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  if(get_layer() != null) {
    get_layer().curve(x1,y1,x2,y2,x3,y3,x4,y4);
  } else {
    g.curve(x1,y1,x2,y2,x3,y3,x4,y4);
  }
}


void curve(float x1, float y1, float z1, float x2, float y2, float z2, float x3, float y3, float z3, float x4, float y4, float z4) {
  if(get_layer() != null) {
    get_layer().curve(x1,y1,z1,x2,y2,z2,x3,y3,z3,x4,y4,z4);
  } else {
    g.curve(x1,y1,z1,x2,y2,z2,x3,y3,z3,x4,y4,z4);
  }
}

// curve detail
void curveDetail(int detail) {
  if(get_layer() != null) {
    get_layer().curveDetail(detail);
  } else {
    g.curveDetail(detail);
  }
}











// light
void lights() {
  if(get_layer() != null) {
    get_layer().lights();
  } else {
    g.lights();
  }
}

void noLights() {
  if(get_layer() != null) {
    get_layer().noLights();
  } else {
    g.noLights();
  }
}

// ambient light
void ambientLight(float v1, float v2, float v3) {
  if(get_layer() != null) {
    get_layer().ambientLight(v1,v2,v3);
  } else {
    g.ambientLight(v1,v2,v3);
  }
}


void ambientLight(float v1, float v2, float v3, float x, float y, float z) {
  if(get_layer() != null) {
    get_layer().ambientLight(v1,v2,v3,x,y,z);
  } else {
    g.ambientLight(v1,v2,v3,x,y,z);
  }
}


//directionalLight(v1, v2, v3, nx, ny, nz)
void directionalLight(float v1, float v2, float v3, float nx, float ny, float nz) {
  if(get_layer() != null) {
    get_layer().directionalLight(v1,v2,v3,nx,ny,nz);
  } else {
    g.directionalLight(v1,v2,v3,nx,ny,nz);
  }
}



// lightFalloff(constant, linear, quadratic)
void lightFalloff(float constant, float linear, float quadratic) {
  if(get_layer() != null) {
    get_layer().lightFalloff(constant,linear,quadratic);
  } else {
    g.lightFalloff(constant,linear,quadratic);
  }
}


// lightSpecular(v1, v2, v3) 

void lightSpecular(float v1, float v2, float v3) {
  if(get_layer() != null) {
    get_layer().lightSpecular(v1,v2,v3);
  } else {
    g.lightSpecular(v1,v2,v3);
  }
}

// normal(nx, ny, nz)
void normal(float nx, float ny, float nz) {
  if(get_layer() != null) {
    get_layer().normal(nx,ny,nz);
  } else {
    g.normal(nx,ny,nz);
  }
}


// pointLight(v1, v2, v3, x, y, z)
void pointLight(float v1, float v2, float v3, float x, float y, float z) {
  if(get_layer() != null) {
    get_layer().pointLight(v1,v2,v3,x,y,z);
  } else {
    g.pointLight(v1,v2,v3,x,y,z);
  }
}

// spotLight(v1, v2, v3, x, y, z, nx, ny, nz, angle, concentration)
void spotLight(float v1, float v2, float v3, float x, float y, float z, float nx, float ny, float nz, float angle, float concentration) {
  if(get_layer() != null) {
    get_layer().spotLight(v1,v2,v3,x,y,z,nx,ny,nz,angle,concentration);
  } else {
    g.spotLight(v1,v2,v3,x,y,z,nx,ny,nz,angle,concentration);
  }
}


/**
Material properties
*/
void ambient(int rgb) {
  if(get_layer() != null) {
    get_layer().ambient(rgb);
  } else {
    g.ambient(rgb);
  }
}

void ambient(float gray) {
  if(get_layer() != null) {
    get_layer().ambient(gray);
  } else {
    g.ambient(gray);
  }
}


void ambient(float v1, float v2, float v3) {
  if(get_layer() != null) {
    get_layer().ambient(v1,v2,v3);
  } else {
    g.ambient(v1,v2,v3);
  }
}


// emissive
void emissive(int rgb) {
  if(get_layer() != null) {
    get_layer().emissive(rgb);
  } else {
    g.emissive(rgb);
  }
}

void emissive(float gray) {
  if(get_layer() != null) {
    get_layer().emissive(gray);
  } else {
    g.emissive(gray);
  }
}


void emissive(float v1, float v2, float v3) {
  if(get_layer() != null) {
    get_layer().emissive(v1,v2,v3);
  } else {
    g.emissive(v1,v2,v3);
  }
}


// specular
void specular(int rgb) {
  if(get_layer() != null) {
    get_layer().specular(rgb);
  } else {
    g.specular(rgb);
  }
}

void specular(float gray) {
  if(get_layer() != null) {
    get_layer().specular(gray);
  } else {
    g.specular(gray);
  }
}


void specular(float v1, float v2, float v3) {
  if(get_layer() != null) {
    get_layer().specular(v1,v2,v3);
  } else {
    g.specular(v1,v2,v3);
  }
}


// shininess(shine)
void shininess(float shine) {
  if(get_layer() != null) {
    get_layer().shininess(shine);
  } else {
    g.shininess(shine);
  }
}











/**
camera ghost
*/
// camera
void camera() {
  if(get_layer() != null) {
    get_layer().camera();
  } else {
    g.camera();
  }
}

void camera(float eyeX, float eyeY, float eyeZ, float centerX, float centerY, float centerZ, float upX, float upY, float upZ) {
  if(get_layer() != null) {
    get_layer().camera(eyeX,eyeY,eyeZ,centerX,centerY,centerZ,upX,upY,upZ);
  } else {
    g.camera(eyeX,eyeY,eyeZ,centerX,centerY,centerZ,upX,upY,upZ);
  }
}


// frustum(left, right, bottom, top, near, far)
void frustum(float left, float right, float bottom, float top, float near, float far) {
  if(get_layer() != null) {
    get_layer().frustum(left,right,bottom,top,near,far);
  } else {
    g.frustum(left,right,bottom,top,near,far);
  }
}


// ortho
void ortho() {
  if(get_layer() != null) {
    get_layer().ortho();
  } else {
    g.ortho();
  }
}

void ortho(float left, float right, float bottom, float top) {
  if(get_layer() != null) {
    get_layer().ortho(left,right,bottom,top);
  } else {
    g.ortho(left,right,bottom,top);
  }
}


void ortho(float left, float right, float bottom, float top, float near, float far) {
  if(get_layer() != null) {
    get_layer().ortho(left,right,bottom,top,near,far);
  } else {
    g.ortho(left,right,bottom,top,near,far);
  }
}


  
// perspective
void perspective() {
  if(get_layer() != null) {
    get_layer().perspective();
  } else {
    g.perspective();
  }
}


void perspective(float fovy, float aspect, float zNear, float zFar) {
  if(get_layer() != null) {
    get_layer().perspective(fovy,aspect,zNear,zFar);
  } else {
    g.perspective(fovy,aspect,zNear,zFar);
  }
}








/**
matrix
*/

void pushMatrix() {
  if(get_layer() != null) {
    get_layer().pushMatrix();
  } else {
    g.pushMatrix();
  }
}


void popMatrix() {
  if(get_layer() != null) {
    get_layer().popMatrix();
  } else {
    g.popMatrix();
  }
}


// apply matrix
void applyMatrix(PMatrix source) {
  if(get_layer() != null) {
    get_layer().applyMatrix(source);
  } else {
    g.applyMatrix(source);
  }
}

void applyMatrix(float n00, float n01, float n02, float n10, float n11, float n12) {
  if(get_layer() != null) {
    get_layer().applyMatrix(n00,n01,n02,n10,n11,n12);
  } else {
    g.applyMatrix(n00,n01,n02,n10,n11,n12);
  }
}

void applyMatrix(float n00, float n01, float n02, float n03, float n10, float n11, float n12, float n13, float n20, float n21, float n22, float n23, float n30, float n31, float n32, float n33) {
  if(get_layer() != null) {
    get_layer().applyMatrix(n00,n01,n02,n03,n10,n11,n12,n13,n20,n21,n22,n23,n30,n31,n32,n33);
  } else {
    g.applyMatrix(n00,n01,n02,n03,n10,n11,n12,n13,n20,n21,n22,n23,n30,n31,n32,n33);
  }
}



void resetMatrix() {
  if(get_layer() != null) {
    get_layer().resetMatrix();
  } else {
    g.resetMatrix();
  }
}


  












/**
image
*/

void image(PImage img, float x, float y) {
  if(get_layer() != null) {
    get_layer().image(img,x,y);
  } else {
    g.image(img,x,y);
  }
}

void image(PImage img, float a, float b, float c, float d) {
  if(get_layer() != null) {
    get_layer().image(img,a,b,c,d);
  } else {
    g.image(img,a,b,c,d);
  }
}


/**
get
*/
int get(int x, int y) {
  if(get_layer() != null) {
    return get_layer().get(x,y);
  } else {
    return g.get(x,y);
  }
} 


PImage get(int x, int y, int w, int h) {
  if(get_layer() != null) {
    return get_layer().get(x,y,w,h);
  } else {
    return g.get(x,y,w,h);
  }
}


PImage get() {
  if(get_layer() != null) {
    return get_layer().get();
  } else {
    return g.get();
  }
}



/**
loadPixels()
*/
void loadPixels() {
  if(get_layer() != null) {
    get_layer().loadPixels();
  } else {
    g.loadPixels();
  }
}



/**
updatePixels()
*/
void updatePixels() {
  if(get_layer() != null) {
    get_layer().updatePixels();
  } else {
    g.updatePixels();
  }
}




/**
tint
*/
void tint(int rgb) {
  if(get_layer() != null) {
    get_layer().tint(rgb);
  } else {
    g.tint(rgb);
  }
}

void tint(int rgb, float alpha) {
  if(get_layer() != null) {
    get_layer().tint(rgb,alpha);
  } else {
    g.tint(rgb,alpha);
  }
}

void tint(float gray) {
  if(get_layer() != null) {
    get_layer().tint(gray);
  } else {
    g.tint(gray);
  }
}

void tint(float gray, float alpha) {
  if(get_layer() != null) {
    get_layer().tint(gray,alpha);
  } else {
    g.tint(gray,alpha);
  }
}

void tint(float v1, float v2, float v3) {
  if(get_layer() != null) {
    get_layer().tint(v1,v2,v3);
  } else {
    g.tint(v1,v2,v3);
  }
}

void tint(float v1, float v2, float v3, float alpha) {
  if(get_layer() != null) {
    get_layer().tint(v1,v2,v3,alpha);
  } else {
    g.tint(v1,v2,v3,alpha);
  }
}



/**
blend
*/
void blend(int sx, int sy, int sw, int sh, int dx, int dy, int dw, int dh, int mode) {
  if(get_layer() != null) {
    get_layer().blend(sx,sy,sw,sh,dx,dy,dw,dh,mode);
  } else {
    g.blend(sx,sy,sw,sh,dx,dy,dw,dh,mode);
  }
}


void blend(PImage src, int sx, int sy, int sw, int sh, int dx, int dy, int dw, int dh, int mode) {
  if(get_layer() != null) {
    get_layer().blend(src,sx,sy,sw,sh,dx,dy,dw,dh,mode);
  } else {
    g.blend(src,sx,sy,sw,sh,dx,dy,dw,dh,mode);
  }
}


/**
filter
*/
void filter(PShader shader) {
  if(get_layer() != null) {
    get_layer().filter(shader);
  } else {
    g.filter(shader);
  }
}

void filter(int kind) {
  if(get_layer() != null) {
    get_layer().filter(kind);
  } else {
    g.filter(kind);
  }
}

void filter(int kind, float param) {
  if(get_layer() != null) {
    get_layer().filter(kind,param);
  } else {
    g.filter(kind,param);
  }
}




/**
set
*/
void set(int x, int y, int c) {
  if(get_layer() != null) {
    get_layer().set(x,y,c);
  } else {
    /*
    x *= displayDensity();
    y *= displayDensity();
    */
    g.set(x,y,c);
  }
}

void set(int x, int y, PImage img) {
  if(get_layer() != null) {
    get_layer().set(x,y,img);
  } else {
    /*
    x *= displayDensity();
    y *= displayDensity();
    */
    g.set(x,y,img);
  }
}





/**
text
*/
void text(char c, float x, float y) {
  if(get_layer() != null) {
    get_layer().text(c,x,y);
  } else {
    g.text(c,x,y);
  }
}


void text(char c, float x, float y, float z) {
  if(get_layer() != null) {
    get_layer().text(c,x,y,z);
  } else {
    g.text(c,x,y,z);
  }
}

void text(char [] chars, int start, int stop, float x, float y) {
  if(get_layer() != null) {
    get_layer().text(chars,start,stop,x,y);
  } else {
    g.text(chars,start,stop,x,y);
  }
}


void text(char [] chars, int start, int stop, float x, float y, float z) {
  if(get_layer() != null) {
    get_layer().text(chars,start,stop,x,y,z);
  } else {
    g.text(chars,start,stop,x,y,z);
  }
}



void text(String str, float x, float y) {
  if(get_layer() != null) {
    get_layer().text(str,x,y);
  } else {
    g.text(str,x,y);
  }
}


void text(String str, float x, float y, float z) {
  if(get_layer() != null) {
    get_layer().text(str,x,y,z);
  } else {
    g.text(str,x,y,z);
  }
}


void text(String str, float x1, float y1, float x2, float y2) {
  if(get_layer() != null) {
    get_layer().text(str,x1,y1,x2,y2);
  } else {
    g.text(str,x1,y1,x2,y2);
  }
}

void text(float num, float x, float y) {
  if(get_layer() != null) {
    get_layer().text(num,x,y);
  } else {
    g.text(num,x,y);
  }
}


void text(float num, float x, float y, float z) {
  if(get_layer() != null) {
    get_layer().text(num,x,y,z);
  } else {
    g.text(num,x,y,z);
  }
}


void text(int num, float x, float y) {
  if(get_layer() != null) {
    get_layer().text(num,x,y);
  } else {
    g.text(num,x,y);
  }
}


void text(int num, float x, float y, float z) {
  if(get_layer() != null) {
    get_layer().text(num,x,y,z);
  } else {
    g.text(num,x,y,z);
  }
}


// text Align
void textAlign(int alignX) {
  if(get_layer() != null) {
    get_layer().textAlign(alignX);
  } else {
    g.textAlign(alignX);
  }
}


void textAlign(int alignX, int alignY) {
  if(get_layer() != null) {
    get_layer().textAlign(alignX,alignY);
  } else {
    g.textAlign(alignX,alignY);
  }
}

// textLeading(leading)
void textLeading(float leading) {
if(get_layer() != null) {
    get_layer().textLeading(leading);
  } else {
    g.textLeading(leading);
  }
}


// textMode(mode)
void textMode(int mode) {
  if(get_layer() != null) {
    get_layer().textMode(mode);
  } else {
    g.textMode(mode);
  }
}

// text Size
void textSize(float size) {
  if(get_layer() != null) {
    get_layer().textSize(size);
  } else {
    g.textSize(size);
  }
}


// textFont
void textFont(PFont which) {
  if(get_layer() != null) {
    get_layer().textFont(which);
  } else {
    g.textFont(which);
  }
}

void textFont(PFont which, float size) {
  if(get_layer() != null) {
    get_layer().textFont(which,size);
  } else {
    g.textFont(which,size);
  }
}






  

















  








  
  




  







 





