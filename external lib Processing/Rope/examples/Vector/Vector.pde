import rope.vector.Vec2;
import rope.vector.Vec3;
import rope.vector.Vec4;
import rope.vector.Vec5;
import rope.vector.Vec6;

import rope.vector.iVec3;
import rope.vector.iVec4;
import rope.vector.iVec6;

import rope.core.Rope;


void setup() {
  Vec2 v2 = new Vec2(4,5);
  v2.pow(2,3);
  println(v2);
  
  Vec3 v3 = new Vec3(4.5);
  v3.add(3.);
  println(v3);
  
  Vec4 a4 = new Vec4(3);
  Vec4 b4 = new Vec4(3,3,3,3);

  println(a4.equals(b4));
  b4.map(0,1,10,30);
  println(a4.equals(b4));
  
  Vec5 v5 = new Vec5(3,-1,4.5,PI,234);
  println(v5.max_vec(),v5.min_vec());
  
    Vec6 v6 = new Vec6(2);
  v6.set_b(65.45);
  println(v6);
  
  iVec3 iv3 = new iVec3(1,2,3);
  println(iv3.sum());
  
  iVec4 ia4 = new iVec4(1,2,3,4);
  iVec4 ib4 = new iVec4(4,3,2,1);
  println(ia4.add(ib4));
  
  iVec6 iv6 = new iVec6(1,2,3,4,5,6);
  printArray(iv6.get_array());
  
  Rope r = new Rope();
  println(r.version());
  println("Euler",r.EULER);
  
  
  
  
}
