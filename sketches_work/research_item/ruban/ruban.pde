/**
ROPE - Romanesco processing environment – 
* Copyleft (c) 2014-2018
* Stan le Punk
* https://github.com/StanLepunK
* http://stanlepunk.xyz/
*/

Ruban ruban;
void setup() {
  size(500,500,P3D);
  Vec2 pos = Vec2(width/2,height/2);
  Vec2 size = Vec2(100,20);
  ruban = new Ruban(pos,size,10);
}



void draw() {
  background(0);
  ruban.wave(10,.1);
  ruban.show();

}


public class Ruban {
  private Vec3 pos;
  private Vec3 size;
  private int segment = 2;
  private Vec3 [] pts;
  private Vec3 [] wave;
  private int mode = CENTER;

  public Ruban(Vec pos, Vec2 size) {
    this.pos = Vec3(pos.x,pos.y,pos.y);
    this.size = Vec3(size.x,size.y,0);;
    build(segment*2);
  }

  public Ruban(Vec pos, Vec2 size, int segment) {
    this.pos = Vec3(pos.x,pos.y,pos.y);
    this.size = Vec3(size.x,size.y,0);
    this.segment = segment;
    build(this.segment*2);
  }

  private void build(int num) {
    pts = new Vec3 [num];
    int pair = -1;
    float part = 1./((pts.length-2) / 2);
    for(int i = 0 ; i < pts.length ; i++) {
      float x = 0;
      float y = 0;
      float z = 0;
      if(i%2 == 0) {
        pair++;
        y = 0;
        z = 0;
      } else {
        y = 1;
        z = 0;
      }
      x = pair *part;
      if(mode == CENTER) {
        Vec3 center = Vec3(.5,.5,0);
        pts[i] = Vec3(x,y,z).sub(center).mult(size).add(pos);
      } else if(mode == CORNER) {
        pts[i] = Vec3(x,y,z).mult(size).add(pos);
      }
    }
  }


  public void show() {
    beginShape();
    for(int i= 0; i < pts.length -1 ; i +=2) {
      vertex_ruban(i);
    }
    vertex_ruban(pts.length-2);
    vertex_ruban(pts.length-1);
    for(int i= pts.length-1; i >= 0 ; i -=2) {
      vertex_ruban(i);
    }
    endShape(CLOSE);
  }

  private void vertex_ruban(int target) {
    Vec3 temp = pts[target].copy();
    if(wave != null && wave[target] != null) {
      temp.add(wave[target]);
    }
    vertex(temp);
  }
  

  public void wave(float height_w, float frequence) {
    if(wave == null) wave = new Vec3[pts.length];
    int pair = -1;
    for(int i = 0 ; i < pts.length ; i++) {
      if(wave[i] == null) wave[i] = Vec3();
      if(i%2 == 0) {
        pair++;
      }

      if(pair%2 ==0) {
        wave[i].y = cos(frameCount *frequence)*height_w;
      } else {
        wave[i].y = sin(frameCount *frequence)*height_w;
      }
    }
      
  }
}














