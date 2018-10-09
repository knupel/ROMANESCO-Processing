/**
ROPE PGraphics LAYER METHOD
2018-2018
v 0.0.1
those ghost method is here like a filter between rope and Processing 
in case the coder want use a PGraphics layer before to implement in the Processing rendering
*/
/**
Layer method
*/
PGraphics l;
boolean warning_layer;
void init_layer(int x, int y, String type) {
  l = createGraphics(x,y,type);
  if(!warning_layer) {
    warning_layer = true;
  }
}

void begin_layer() {
  if(l != null) {
    l.beginDraw();
  }
}

void end_layer() {
  if(l != null) {
    l.endDraw();
  }
}

PGraphics get_layer() {
  return l;
}









// Processing ghost method

// position
void translate(int x, int y) {
  if(l != null) {
    l.translate(x,y);
  } else {
    g.translate(x,y);
  }
}

void translate(int x, int y, int z) {
  if(l != null) {
    l.translate(x,y,z);
  } else {
    g.translate(x,y,z);
  }
}


// rotate
// iterative problem
void rotate(float arg) {
  if(l != null) {
    l.rotate(arg);
  } else {
    g.rotate(arg);
  }
}


void rotateX(float arg) {
  if(l != null) {
    l.rotateX(arg);
  } else {
    g.rotateX(arg);
  }
}

void rotateY(float arg) {
  if(l != null) {
    l.rotateY(arg);
  } else {
    g.rotateY(arg);
  }
}

// scale
void scale(float s) {
  if(l != null) {
    l.scale(s);
  } else {
    g.scale(s);
  }
}

void scale(float x, float y) {
  if(l != null) {
    l.scale(x,y);
  } else {
    g.scale(x,y);
  }
}

void scale(float x, float y, float z) {
  if(l != null) {
    l.scale(x,y,z);
  } else {
    g.scale(x,y,z);
  }
}

// shear
void shearX(float angle) {
  if(l != null) {
    l.shearX(angle);
  } else {
    g.shearX(angle);
  }
}

void shearY(float angle) {
  if(l != null) {
    l.shearY(angle);
  } else {
    g.shearY(angle);
  }
}













/**
aspect
*/
// fill
// iterative problem
void noFill() {
  if(l != null) {
    l.noFill();
  } else {
    g.noFill();
  }
} 

void fill(int rgb) {
  if(l != null) {
    l.fill(rgb);
  } else {
    g.fill(rgb);
  }
}


void fill(int rgb, float alpha) {
  if(l != null) {
    l.fill(rgb,alpha);
  } else {
    g.fill(rgb,alpha);
  }
}

void fill(float gray) {
  if(l != null) {
    l.fill(gray);
  } else {
    g.fill(gray);
  }
}


void fill(float gray, float alpha) {
  if(l != null) {
    l.fill(gray,alpha);
  } else {
    g.fill(gray,alpha);
  }
}

void fill(float v1, float v2, float v3) {
  if(l != null) {
    l.fill(v1,v2,v3);
  } else {
    g.fill(v1,v2,v3);
  }
}

void fill(float v1, float v2, float v3, float alpha) {
  if(l != null) {
    l.fill(v1,v2,v3,alpha);
  } else {
    g.fill(v1,v2,v3,alpha);
  }
}

// stroke
// iterative problem
void noStroke() {
  if(l != null) {
    l.noStroke();
  } else {
    g.noStroke();
  }
} 

void stroke(int rgb) {
  if(l != null) {
    l.stroke(rgb);
  } else {
    g.stroke(rgb);
  }
}


void stroke(int rgb, float alpha) {
  if(l != null) {
    l.stroke(rgb,alpha);
  } else {
    g.stroke(rgb,alpha);
  }
}

void stroke(float gray) {
  if(l != null) {
    l.stroke(gray);
  } else {
    g.stroke(gray);
  }
}


void stroke(float gray, float alpha) {
  if(l != null) {
    l.stroke(gray,alpha);
  } else {
    g.stroke(gray,alpha);
  }
}

void stroke(float v1, float v2, float v3) {
  if(l != null) {
    l.stroke(v1,v2,v3);
  } else {
    g.stroke(v1,v2,v3);
  }
}

void stroke(float v1, float v2, float v3, float alpha) {
  if(l != null) {
    l.stroke(v1,v2,v3,alpha);
  } else {
    g.stroke(v1,v2,v3,alpha);
  }
}


// strokeWeight
// iterative problem
void strokeWeight(float thickness) {
  if(l != null) {
    l.strokeWeight(thickness);
  } else {
    g.strokeWeight(thickness);
  }
}

// strokeJoin
// iterative problem
void strokeJoin(int join) {
  if(l != null) {
    l.strokeJoin(join);
  } else {
    g.strokeJoin(join);
  }
}

// strokeJoin
// iterative problem
void strokeCapstrokeCap(int cap) {
  if(l != null) {
    l.strokeCap(cap);
  } else {
    g.strokeCap(cap);
  }
}












/**
shape
*/
// rect
void rect(int px, int py, int sx, int sy) {
  if(l != null) {
    l.rect(px,py,sx,sy);
  } else {
    g.rect(px,py,sx,sy);
  }
}


void rect(int px, int py, int sx, int sy, float r) {
  if(l != null) {
    l.rect(px,py,sx,sy,r);
  } else {
    g.rect(px,py,sx,sy,r);
  }
}

void rect(int px, int py, int sx, int sy, float tl, float tr, float br, float bl) {
  if(l != null) {
    l.rect(px,py,sx,sy,tl,tr,br,bl);
  } else {
    g.rect(px,py,sx,sy,tl,tr,br,bl);
  }
}


//arc
void arc(float a, float b, float c, float d, float start, float stop) {
  if(l != null) {
    l.arc(a,b,c,d,start,stop);
  } else {
    g.arc(a,b,c,d,start,stop);
  }
}

void arc(float a, float b, float c, float d, float start, float stop, int mode) {
  if(l != null) {
    l.arc(a,b,c,d,start,stop,mode);
  } else {
    g.arc(a,b,c,d,start,stop,mode);
  }
}

// ellipse
void ellipse(int px, int py, int sx, int sy) {
  if(l != null) {
    l.ellipse(px,py,sx,sy);
  } else {
    g.ellipse(px,py,sx,sy);
  }
}




// box
void box(int s) {
  if(l != null) {
    l.box(s,s,s);
  } else {
    g.box(s,s,s);
  }
}

void box(int w, int h, int d) {
  if(l != null) {
    l.box(w,h,d);
  } else {
    g.box(w,h,d);
  }
}


// sphere
void sphere(float r) {
  if(l != null) {
    l.sphere(r);
  } else {
    g.sphere(r);
    // p.sphere(r);
  }
}


// sphere detail
void sphereDetail(int res) {
  if(l != null) {
    l.sphereDetail(res);
  } else {
    g.sphereDetail(res);
  }
}

void sphereDetail(int ures, int vres) {
  if(l != null) {
    l.sphereDetail(ures,vres);
  } else {
    g.sphereDetail(ures,vres);
  }
}




//line
void line(float x1, float y1, float x2, float y2) {
  if(l != null) {
    l.line(x1,y1,x2,y2);
  } else {
    g.line(x1,y1,x2,y2);
  }
}

void line(float x1, float y1, float z1, float x2, float y2, float z2) {
  if(l != null) {
    l.line(x1,y1,z1,x2,y2,z2);
  } else {
    g.line(x1,y1,z1,x2,y2,z2);
  }
}






// point
void point(float x, float y) {
  if(l != null) {
    l.point(x,y);
  } else {
    g.point(x,y);
  }
}

void point(float x, float y, float z) {
  if(l != null) {
    l.point(x,y,z);
  } else {
    g.point(x,y,z);
  }
}

// quad
void quad(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  if(l != null) {
    l.quad(x1,y1,x2,y2,x3,y3,x4,y4);
  } else {
    g.quad(x1,y1,x2,y2,x3,y3,x4,y4);
  }
}

// triangle
/*
method already use somewhere else
void triangle(float x1, float y1, float x2, float y2, float x3, float y3) {
  if(l != null) {
    l.triangle(x1,y1,x2,y2,x3,y3);
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
  if(l != null) {
    l.beginShape();
  } else {
    g.beginShape();
  }
}

void beginShape(int kind) {
  if(l != null) {
    l.beginShape(kind);
  } else {
    g.beginShape(kind);
  }
}


void endShape() {
  if(l != null) {
    l.endShape();
  } else {
    g.endShape();
  }
}

void endShape(int mode) {
  if(l != null) {
    l.endShape(mode);
  } else {
    g.endShape(mode);
  }
}




// shape
void shape(PShape shape) {
  if(l != null) {
    l.shape(shape);
  } else {
    g.shape(shape);
  }
}

void shape(PShape shape, float x, float y) {
  if(l != null) {
    l.shape(shape,x,y);
  } else {
    g.shape(shape,x,y);
  }
}

void shape(PShape shape, float a, float b, float c, float d) {
  if(l != null) {
    l.shape(shape,a,b,c,d);
  } else {
    g.shape(shape,a,b,c,d);
  }
}








  




//vertex
void vertex(float x, float y) {
  if(l != null) {
    l.vertex(x,y);
  } else {
    g.vertex(x,y);
  }
}

void vertex(float x, float y, float z) {
  if(l != null) {
    l.vertex(x,y,z);
  } else {
    g.vertex(x,y,z);
  }
}

void vertex(float [] v) {
  if(l != null) {
    l.vertex(v);
  } else {
    g.vertex(v);
  }
}

void vertex(float x, float y, float u, float v) {
  if(l != null) {
    l.vertex(x,y,u,v);
  } else {
    g.vertex(x,y,u,v);
  }
} 


void vertex(float x, float y, float z, float u, float v) {
  if(l != null) {
    l.vertex(x,y,z,u,v);
  } else {
    g.vertex(x,y,z,u,v);
  }
}  


// quadratic vertex
void quadraticVertex(float cx, float cy, float x3, float y3) {
  if(l != null) {
    l.quadraticVertex(cx,cy,x3,y3);
  } else {
    g.quadraticVertex(cx,cy,x3,y3);
  }
}

void quadraticVertex(float cx, float cy, float cz, float x3, float y3, float z3) {
  if(l != null) {
    l.quadraticVertex(cx,cy,cz,x3,y3,z3);
  } else {
    g.quadraticVertex(cx,cy,cz,x3,y3,z3);
  }
}

// curve vertex
void curveVertex(float x, float y) {
  if(l != null) {
    l.curveVertex(x,y);
  } else {
    g.curveVertex(x,y);
  }
}

void curveVertex(float x, float y, float z) {
  if(l != null) {
    l.curveVertex(x,y,z);
  } else {
    g.curveVertex(x,y,z);
  }
}


//bezier vertex
void bezierVertex(float x2, float y2, float x3, float y3, float x4, float y4) {
  if(l != null) {
    l.bezierVertex(x2,y2,x3,y3,x4,y4);
  } else {
    g.bezierVertex(x2,y2,x3,y3,x4,y4);
  }
}


void bezierVertex(float x2, float y2, float z2, float x3, float y3, float z3, float x4, float y4, float z4) {
  if(l != null) {
    l.bezierVertex(x2,y2,z2,x3,y3,z3,x4,y4,z4);
  } else {
    g.bezierVertex(x2,y2,z2,x3,y3,z3,x4,y4,z4);
  }
}

// bezier
void bezier(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  if(l != null) {
    l.bezier(x1,y1,x2,y2,x3,y3,x4,y4);
  } else {
    g.bezier(x1,y1,x2,y2,x3,y3,x4,y4);
  }
}

void bezier(float x1, float y1, float z1, float x2, float y2, float z2, float x3, float y3, float z3, float x4, float y4, float z4) {
  if(l != null) {
    l.bezier(x1,y1,z1,x2,y2,z2,x3,y3,z3,x4,y4,z4);
  } else {
    g.bezier(x1,y1,z1,x2,y2,z2,x3,y3,z3,x4,y4,z4);
  }
}

// bezier detail
void bezierDetail(int detail) {
  if(l != null) {
    l.bezierDetail(detail);
  } else {
    g.bezierDetail(detail);
  }
}

// curve
void curve(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  if(l != null) {
    l.curve(x1,y1,x2,y2,x3,y3,x4,y4);
  } else {
    g.curve(x1,y1,x2,y2,x3,y3,x4,y4);
  }
}


void curve(float x1, float y1, float z1, float x2, float y2, float z2, float x3, float y3, float z3, float x4, float y4, float z4) {
  if(l != null) {
    l.curve(x1,y1,z1,x2,y2,z2,x3,y3,z3,x4,y4,z4);
  } else {
    g.curve(x1,y1,z1,x2,y2,z2,x3,y3,z3,x4,y4,z4);
  }
}

// curve detail
void curveDetail(int detail) {
  if(l != null) {
    l.curveDetail(detail);
  } else {
    g.curveDetail(detail);
  }
}











// light
void lights() {
  if(l != null) {
    l.lights();
  } else {
    g.lights();
  }
}

void noLights() {
  if(l != null) {
    l.noLights();
  } else {
    g.noLights();
  }
}

// ambient light
void ambientLight(float v1, float v2, float v3) {
  if(l != null) {
    l.ambientLight(v1,v2,v3);
  } else {
    g.ambientLight(v1,v2,v3);
  }
}


void ambientLight(float v1, float v2, float v3, float x, float y, float z) {
  if(l != null) {
    l.ambientLight(v1,v2,v3,x,y,z);
  } else {
    g.ambientLight(v1,v2,v3,x,y,z);
  }
}


//directionalLight(v1, v2, v3, nx, ny, nz)
void directionalLight(float v1, float v2, float v3, float nx, float ny, float nz) {
  if(l != null) {
    l.directionalLight(v1,v2,v3,nx,ny,nz);
  } else {
    g.directionalLight(v1,v2,v3,nx,ny,nz);
  }
}



// lightFalloff(constant, linear, quadratic)
void lightFalloff(float constant, float linear, float quadratic) {
  if(l != null) {
    l.lightFalloff(constant,linear,quadratic);
  } else {
    g.lightFalloff(constant,linear,quadratic);
  }
}


// lightSpecular(v1, v2, v3) 

void lightSpecular(float v1, float v2, float v3) {
  if(l != null) {
    l.lightSpecular(v1,v2,v3);
  } else {
    g.lightSpecular(v1,v2,v3);
  }
}

// normal(nx, ny, nz)
void normal(float nx, float ny, float nz) {
  if(l != null) {
    l.normal(nx,ny,nz);
  } else {
    g.normal(nx,ny,nz);
  }
}


// pointLight(v1, v2, v3, x, y, z)
void pointLight(float v1, float v2, float v3, float x, float y, float z) {
  if(l != null) {
    l.pointLight(v1,v2,v3,x,y,z);
  } else {
    g.pointLight(v1,v2,v3,x,y,z);
  }
}

// spotLight(v1, v2, v3, x, y, z, nx, ny, nz, angle, concentration)
void spotLight(float v1, float v2, float v3, float x, float y, float z, float nx, float ny, float nz, float angle, float concentration) {
  if(l != null) {
    l.spotLight(v1,v2,v3,x,y,z,nx,ny,nz,angle,concentration);
  } else {
    g.spotLight(v1,v2,v3,x,y,z,nx,ny,nz,angle,concentration);
  }
}


/**
Material properties
*/
void ambient(int rgb) {
  if(l != null) {
    l.ambient(rgb);
  } else {
    g.ambient(rgb);
  }
}

void ambient(float gray) {
  if(l != null) {
    l.ambient(gray);
  } else {
    g.ambient(gray);
  }
}


void ambient(float v1, float v2, float v3) {
  if(l != null) {
    l.ambient(v1,v2,v3);
  } else {
    g.ambient(v1,v2,v3);
  }
}


// emissive
void emissive(int rgb) {
  if(l != null) {
    l.emissive(rgb);
  } else {
    g.emissive(rgb);
  }
}

void emissive(float gray) {
  if(l != null) {
    l.emissive(gray);
  } else {
    g.emissive(gray);
  }
}


void emissive(float v1, float v2, float v3) {
  if(l != null) {
    l.emissive(v1,v2,v3);
  } else {
    g.emissive(v1,v2,v3);
  }
}


// specular
void specular(int rgb) {
  if(l != null) {
    l.specular(rgb);
  } else {
    g.specular(rgb);
  }
}

void specular(float gray) {
  if(l != null) {
    l.specular(gray);
  } else {
    g.specular(gray);
  }
}


void specular(float v1, float v2, float v3) {
  if(l != null) {
    l.specular(v1,v2,v3);
  } else {
    g.specular(v1,v2,v3);
  }
}


// shininess(shine)
void shininess(float shine) {
  if(l != null) {
    l.shininess(shine);
  } else {
    g.shininess(shine);
  }
}











/**
camera ghost
*/

// camera
void camera() {
  if(l != null) {
    l.camera();
  } else {
    g.camera();
  }
}

void camera(float eyeX, float eyeY, float eyeZ, float centerX, float centerY, float centerZ, float upX, float upY, float upZ) {
  if(l != null) {
    l.camera(eyeX,eyeY,eyeZ,centerX,centerY,centerZ,upX,upY,upZ);
  } else {
    g.camera(eyeX,eyeY,eyeZ,centerX,centerY,centerZ,upX,upY,upZ);
  }
}


// frustum(left, right, bottom, top, near, far)
void frustum(float left, float right, float bottom, float top, float near, float far) {
  if(l != null) {
    l.frustum(left,right,bottom,top,near,far);
  } else {
    g.frustum(left,right,bottom,top,near,far);
  }
}


// ortho
void ortho() {
  if(l != null) {
    l.ortho();
  } else {
    g.ortho();
  }
}

void ortho(float left, float right, float bottom, float top) {
  if(l != null) {
    l.ortho(left,right,bottom,top);
  } else {
    g.ortho(left,right,bottom,top);
  }
}


void ortho(float left, float right, float bottom, float top, float near, float far) {
  if(l != null) {
    l.ortho(left,right,bottom,top,near,far);
  } else {
    g.ortho(left,right,bottom,top,near,far);
  }
}


  
// perspective
void perspective() {
  if(l != null) {
    l.perspective();
  } else {
    g.perspective();
  }
}


void perspective(float fovy, float aspect, float zNear, float zFar) {
  if(l != null) {
    l.perspective(fovy,aspect,zNear,zFar);
  } else {
    g.perspective(fovy,aspect,zNear,zFar);
  }
}








/**
matrix
*/
void pushMatrix() {
  if(l != null) {
    l.pushMatrix();
  } else {
    g.pushMatrix();
  }
}


void popMatrix() {
  if(l != null) {
    l.popMatrix();
  } else {
    g.popMatrix();
  }
}

// apply matrix
void applyMatrix(PMatrix source) {
  if(l != null) {
    l.applyMatrix(source);
  } else {
    g.applyMatrix(source);
  }
}

void applyMatrix(float n00, float n01, float n02, float n10, float n11, float n12) {
  if(l != null) {
    l.applyMatrix(n00,n01,n02,n10,n11,n12);
  } else {
    g.applyMatrix(n00,n01,n02,n10,n11,n12);
  }
}

void applyMatrix(float n00, float n01, float n02, float n03, float n10, float n11, float n12, float n13, float n20, float n21, float n22, float n23, float n30, float n31, float n32, float n33) {
  if(l != null) {
    l.applyMatrix(n00,n01,n02,n03,n10,n11,n12,n13,n20,n21,n22,n23,n30,n31,n32,n33);
  } else {
    g.applyMatrix(n00,n01,n02,n03,n10,n11,n12,n13,n20,n21,n22,n23,n30,n31,n32,n33);
  }
}



void resetMatrix() {
  if(l != null) {
    l.resetMatrix();
  } else {
    g.resetMatrix();
  }
}


  




















  








  
  




  







 





