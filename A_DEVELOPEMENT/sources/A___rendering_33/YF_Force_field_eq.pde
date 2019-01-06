/**
EQUATION
2018-2018
v 0.1.0
Processing 3.4
* Equation work with field array 2D
*/
public class Equation implements rope.core.RConstants {
  // ArrayList<Integer> rank ;
  Vec3 center_eq_dir, center_eq_len;
  ArrayList<iVec4> pow;
  ArrayList<iVec4> root;
  ArrayList<Vec4> mult;
  boolean reverse_len;
  int num_op = 0 ;
  int x = 1;
  int y = 2;
  int z = 3;

  Equation() {
  }

  private void rank() {
    num_op++;
  }

  private int get_op() {
    return num_op;
  }

  public void swap_xyz(String st_x, String st_y, String st_z) {
    if(st_x.equals("x")) x = 1 ;
    else if(st_x.equals("y")) x = 2 ;
    else if(st_x.equals("z")) x = 3 ;
    else x = 1 ;

    if(st_y.equals("x")) y = 1 ;
    else if(st_y.equals("y")) y = 2 ;
    else if(st_y.equals("z")) y = 3 ;
    else y = 2 ;

    if(st_z.equals("x")) z = 1 ;
    else if(st_z.equals("y")) z = 2 ;
    else if(st_z.equals("z")) z = 3 ;
    else z = 3 ;
  }

  public void swap_xy(String x, String y) {
    swap_xyz(x,y,"z");
  }

  // operation
  public void mult(float mx, float my, float mz) {
    if(mult == null) mult = new ArrayList<Vec4>();
    int rank = get_op() ;
    mult.add(Vec4(mx,my,mz,rank));
    rank();
  }

  public void pow(int px, int py, int pz) {
    if(pow == null) pow = new ArrayList<iVec4>();
    int rank = get_op();
    if(px < 1) px = 1;
    if(py < 1) py = 1;
    if(pz < 1) pz = 1;
    pow.add(iVec4(px,py,pz,rank));
    rank();
  }

  public void root(int rx, int ry, int rz) {
    if(root == null) root = new ArrayList<iVec4>();
    int rank = get_op();
    int min = 1;
    int max = 4;
    if(rx < min) rx = min;
    if(rx > max) rx = max;

    if(ry < min) ry = min;
    if(ry > max) ry = max;

    if(rz < min) rz = min;
    if(rz > max) rz = max;
    root.add(iVec4(rx,ry,rz,rank));
    rank();
  }

  // Center dir
  private void eq_center_dir(float x, float y, float z) {
    center_eq_dir = Vec3(x,y,z);
  }

  Vec2 get_center_dir_2D() {
    if(center_eq_dir != null) return Vec2(center_eq_dir.x,center_eq_dir.y);
    else return null ;
  }

  Vec3 get_center_dir_3D() {
    if(center_eq_dir != null) return Vec3(center_eq_dir.x,center_eq_dir.y,center_eq_dir.z);
    else return null;
  }

  // Center len
  private void eq_center_len(float x, float y, float z) {
    center_eq_len = Vec3(x,y,z);
  }

  Vec2 get_center_len_2D() {
    if(center_eq_len != null) return Vec2(center_eq_len.x,center_eq_len.y);
    else return null;
  }

  Vec3 get_center_len_3D() {
    if(center_eq_len != null) return Vec3(center_eq_len.x,center_eq_dir.y,center_eq_len.z);
    else return null;
  }
}


/**
EQ method
v 0.0.1
*/
Equation eq;
public void init_eq() {
  eq = new Equation();
  // if(eq == null) eq = new Equation();
}
/**
misc
*/
// choice a center to compute the vector direction
public void eq_center_dir(float x, float y) {
  eq.eq_center_dir(x, y, 0);
}

public void eq_center_dir(float x, float y, float z) {
  eq.eq_center_dir(x, y, z);
}

// choice a center to compute the length vector
public void eq_center_len(float x, float y) {
  eq.eq_center_len(x, y, 0);
}

public void eq_center_len(float x, float y, float z) {
  eq.eq_center_len(x, y, z);
}

// reverse len
public void eq_reverse_len(boolean state){
  eq.reverse_len = state;
}

public void eq_swap_xyz(String x, String y, String z) {
  eq.swap_xyz(x,y,z);
}

public void eq_swap_xy(String x, String y) {
  eq_swap_xyz(x,y,"z");
}


/**
eq operation
*/
// pow
public void eq_pow(int px, int py) {
  eq_pow(px, py, 1);
}

public void eq_pow(int px, int py, int pz) {
  eq.pow(px,py,pz);
}

//root squareroot, cuberoot and timeroot for 4th dimension
public void eq_root(int rx, int ry){
  eq_root(rx,ry,1);
}
public void eq_root(int rx, int ry, int rz) {
  eq.root(rx,ry,rz);
}

//root squareroot, cuberoot and timeroot for 4th dimension
public void eq_mult(float mx, float my){
  eq_mult(mx,my,1);
}
public void eq_mult(float mx, float my, float mz) {
  eq.mult(mx,my,mz);
}