/**
NAVIER-STOKES
v 0.3.2.0
by Stan le Punk
http://stanlepunk.xyz
Java implementation of the Navier-Stokes-Solver based on the Jos Tam's work :
http://www.dgp.toronto.edu/people/stam/reality/Research/pdf/GDC03.pdf
*/
/**
Processing implementation for Processing 3.3.6
*/
abstract class Navier_Stokes {
  int N = -1;
  iVec NXYZ;
  int iter;
  boolean three_Dimension_is;
  float[] u,v;
  float[] u_prev,v_prev;

  float[] s,t,p;
  float[] s_prev,t_prev,p_prev;

  int num_cell;

  float[] dst;
  float[] dst_prev;

  
  // implented with N
  Navier_Stokes(int N, boolean three_Dimension_is) {
    build(N, 20, three_Dimension_is);
  }

  Navier_Stokes(int N, int iter, boolean three_Dimension_is) {
    build(N, iter, three_Dimension_is);
  }

  // implemented with NXYZ
  Navier_Stokes(iVec NXYZ, boolean three_Dimension_is) {
    build(NXYZ, 20, three_Dimension_is);
  }

  Navier_Stokes(iVec NXYZ, int iter, boolean three_Dimension_is) {
    build(NXYZ, iter, three_Dimension_is);
  }





  //build
    private void build(int N, int iter, boolean three_Dimension_is) {
    this.N = N ;
    this.NXYZ = iVec3(N);
    this.iter = iter ;
    this.three_Dimension_is = three_Dimension_is ;

    if(!three_Dimension_is) {
      num_cell = (N +2) *(N +2);
      u = new float[num_cell];
      v = new float[num_cell];
      u_prev = new float[num_cell];
      v_prev = new float[num_cell];
    } else {
      num_cell = (N +2) *(N +2) *(N +2);
      s = new float[num_cell];
      t = new float[num_cell];
      p = new float[num_cell];
      s_prev = new float[num_cell];
      t_prev = new float[num_cell];
      p_prev = new float[num_cell];
    }
    
    dst = new float[num_cell];
    dst_prev = new float[num_cell];
  }


  private void build(iVec NXYZ, int iter, boolean three_Dimension_is) {
    this.NXYZ = iVec3(NXYZ.x,NXYZ.y,NXYZ.z);
    this.iter = iter ;
    this.three_Dimension_is = three_Dimension_is ;

    if(!three_Dimension_is) {
      num_cell = (NXYZ.x +2) *(NXYZ.y +2);
      u = new float[num_cell];
      v = new float[num_cell];
      u_prev = new float[num_cell];
      v_prev = new float[num_cell];
    } else {
      num_cell = (NXYZ.x +2) *(NXYZ.y +2) *(NXYZ.z +2);
      s = new float[num_cell];
      t = new float[num_cell];
      p = new float[num_cell];
      s_prev = new float[num_cell];
      t_prev = new float[num_cell];
      p_prev = new float[num_cell];
    }
    
    dst = new float[num_cell];
    dst_prev = new float[num_cell];
  }
   


  protected void add_source(float[] x, float[] s, float dt) {
    for (int i = 0; i < num_cell; i++) {
      x[i] += dt * s[i];
    }
  }

  public int get_N() {
    if(N == -1) {
      printErr("Navier Stokes is implemented with NX,NY and NZ");
    }
    return N;
  }

  public iVec3 get_NXYZ() {
    if(NXYZ == null) {
      printErr("Navier Stokes is implemented with NX,NY and NZ");
    }
    return iVec3(NXYZ.x,NXYZ.y,NXYZ.z);
  }

  public iVec2 get_NXY() {
    if(NXYZ == null) {
      printErr("Navier Stokes is implemented with NX,NY and NZ");
    }
    return iVec2(NXYZ.x,NXYZ.y);
  }

  public int get_NX() {
    if(NXYZ == null) {
      printErr("Navier Stokes is implemented with NX,NY and NZ");
    }
    return NXYZ.x;
  }

  public int get_NY() {
    if(NXYZ == null) {
      printErr("Navier Stokes is implemented with NX,NY and NZ");
    }
    return NXYZ.y;
  }

  public int get_NZ() {
    if(NXYZ == null) {
      printErr("Navier Stokes is implemented with NX,NY and NZ");
    }
    return NXYZ.z;
  }
}
























/**
Navier_Stokes_2D
2017-2017
v 0.1.0.1
*/

public class Navier_Stokes_2D extends Navier_Stokes {
  /**
  constructor
  */
  public Navier_Stokes_2D(int N) {
    super(N, 20, false);
  }
  public Navier_Stokes_2D(int N, int iter) {
    super(N, iter, false);
  }


  public Navier_Stokes_2D(iVec2 NXY) {
    super(NXY, 20, false);
  }
  public Navier_Stokes_2D(iVec2 NXY, int iter) {
    super(NXY, iter, false);
  }





  /**
  public method
  */
/**
get
*/
  public float get_dx(int x, int y) {
    return u[IX(x+1, y+1)];
  }

  public float get_dy(int x, int y) {
    return v[IX(x+1, y+1)];
  }

/**
set
*/
  public void set_dx(int x, int y, float value) {
    u[IX(x+1, y+1)] = 0;
  }

  public void set_dy(int x, int y, float value) {
    v[IX(x+1, y+1)] = 0;
  }

  /** 
  apply force
  v 0.0.3
  */
  public void apply_force(int cell_x, int cell_y, float vx, float vy) {
    cell_x += 1;
    cell_y += 1;
    int which_one = IX(cell_x, cell_y);

    if(which_one >= 0) {
      if(which_one < u.length) {
        float dx = u[which_one];
        u[which_one] = (vx != 0) ? 
        lerp(vx,dx,.85f) : 
        dx;
      }

      if(which_one < v.length) {
        float dy = v[which_one];
        v[which_one] = (vy != 0) ? 
        lerp(vy,dy,.85f) : 
        dy;
      }
    } 
  }


  /**
  update
  */
  public void update(float dt, float visc, float diff) {
    vel_step(u, v, u_prev, v_prev, visc, dt, iter, NXYZ.x, NXYZ.y);
    dens_step(dst, dst_prev, u, v, diff, dt, iter, NXYZ.x, NXYZ.y);
  }






  /**
  NAVIER STROKE
  real work
  from here to the end we dont use the type iVec
  */
  private void vel_step(float[] u, float[] v, float[] u0, float[] v0, float visc, float dt, int iter, int NX, int NY) {
    // step 0
    add_source(u,u0,dt);
    add_source(v,v0,dt);
    // step 1
    SWAP(u0, u);
    diffuse(1, u, u0, visc, dt, iter, NX, NY);
    SWAP(v0, v);
    diffuse(2, v, v0, visc, dt, iter, NX, NY);

    project(u, v, u0, v0, iter, NX, NY);

    // step 2
    SWAP(u0, u);
    SWAP(v0, v);
    advect(1, u, u0, u0, v0, dt, NX, NY);
    advect(2, v, v0, u0, v0, dt, NX, NY);
    project(u, v, u0, v0, iter, NX, NY);
  }


  private void dens_step(float[] x, float[] x0, float[] u, float[] v, float diff, float dt, int iter, int NX, int NY) {
    add_source(x, x0, dt);
    SWAP(x0, x);
    diffuse(0, x, x0, diff, dt, iter, NX, NY);
    SWAP(x0, x);
    advect(0, x, x0, u, v, dt, NX, NY);
  }


  



  /**

  NAVIER STROKE start from HERE
  main method
  */

  /**
  diffusion
  */
  private void diffuse(int b, float[] x, float[] x0, float diff, float dt, int iter, int NX, int NY) {
    float a = dt *diff *NX*NY;
    float c = 1 +4 *a ;
    lin_solve(b, x, x0, a, c, iter, NX, NY);
  }



  /**
  advect
  */
  private void advect(int b, float[] d, float[] d0, float[] u, float[] v, float dt, int NX, int NY) {
    int i, j;
    int  i0, j0;
    int i1, j1;
    float x, y ;
    float s0, t0;
    float s1, t1;
    // float dt0 = dt *N;
    float dtx = dt *(NX -2);
    float dty = dt *(NY -2);
/*
        float dtx = dt *(N -2);
    float dty = dt *(N -2);
    float dtz = dt *(N -2);
    */

    for (i = 1; i <= NX; i++) {
      for (j = 1; j <= NY; j++) {
        x = i - dtx * u[IX(i,j)];
        y = j - dty * v[IX(i,j)];
        /*
        x = i - dt0 * u[IX(i,j)];
        y = j - dt0 * v[IX(i,j)];
        */
        //
        if (x < 0.5) x = 0.5;
        if (x > NX +.5) x = NX +.5;
        if (y < .5) y = .5;
        if (y > NY +.5) y = NY +.5;

        i0 = (int) x;
        i1 = i0 +1;
        j0 = (int) y;
        j1 = j0 +1;

        s1 = x -i0;
        s0 = 1 -s1;
        t1 = y -j0;
        t0 = 1 -t1;
        
        float arg_0 = t0 *d0[IX(i0, j0)] +t1 *d0[IX(i0, j1)];
        float arg_1 = t0 *d0[IX(i1, j0)] +t1 *d0[IX(i1, j1)];

        d[IX(i, j)] = s0 *(arg_0) +s1 *(arg_1);
      }
    }
    set_bnd(b, d, NX, NY);
  }
  /**
  boundary
  v 0.0.2
  */
  private void set_bnd(int b, float[] x, int NX, int NY) {
    for (int i = 1; i <= NX ; i++) {
      if(i <= NY) {
        x[IX(0, i)] = b == 1 ? -x[IX(1, i)] : x[IX(1, i)];
        x[IX(NX + 1, i)] = b == 1 ? -x[IX(NX, i)] : x[IX(NX, i)];
      }


      x[IX(i, 0)] = b == 2 ? -x[IX(i, 1)] : x[IX(i, 1)];
      x[IX(i, NY + 1)] = b == 2 ? -x[IX(i, NY)] : x[IX(i, NY)];
    }

    x[IX(0, 0)] = 0.5 * (x[IX(1, 0)] + x[IX(0, 1)]);
    x[IX(0, NY +1)] = 0.5 * (x[IX(1, NY +1)] + x[IX(0, NY)]);

    x[IX(NX +1, 0)] = 0.5 * (x[IX(NX, 0)] +x[IX(NX +1, 1)]);
    x[IX(NX +1, NY +1)] = 0.5 * (x[IX(NX, NY +1)] + x[IX(NX +1, NY)]);
  }


  

  /**
  project
  v 0.0.2
  */
  private void project(float[] u, float[] v, float[] u0, float[] v0, int iter, int NX, int NY) {
    float hx = 1. / NX;
    float hy = 1. / NY;
    
    for (int i = 1; i <= NX; i++) {
      for (int j = 1; j <= NY; j++) {
        float step_1 = u[IX(i+1,j)] -u[IX(i-1,j)] 
                      +v[IX(i,j+1)] -v[IX(i,j-1)];
        v0[IX(i, j)] = -.5f *hx *step_1;
        u0[IX(i, j)] = 0;
      }
    }
    set_bnd(0, v0, NX, NY);
    set_bnd(0, u0, NX, NY);

    lin_solve(0, u0, v0, 1, 4, iter, NX, NY) ;

    for (int i = 1; i <= NX; i++) {
      for (int j = 1; j <= NY; j++) {
        u[IX(i,j)] -= .5 *(u0[IX(i+1,j)] -u0[IX(i-1,j)]) /hx;
        v[IX(i,j)] -= .5 *(u0[IX(i,j+1)] -u0[IX(i,j-1)]) /hy;
      }
    }
    set_bnd(1, u, NX, NY);
    set_bnd(2, v, NX, NY);
  }






  /**
  util
  v 0.0.2
  */
  private void lin_solve(int b, float[] x, float[] x0, float a, float c, int iter, int NX, int NY) {
    for (int inc = 0; inc < iter; inc++) {
      for (int i = 1; i <= NX; i++) {
        for (int j = 1; j <= NY; j++) {
          float step_1 = x[IX(i-1,j)] +x[IX(i+1,j)] 
                        +x[IX(i,j-1)] +x[IX(i,j+1)];
          float step_2 = a *step_1 +x0[IX(i,j)];
          x[IX(i, j)] = step_2 /c;
        }
      }
      set_bnd(b, x, NX, NY);
    }
  }

  // method used to be 'static' since this class is not a top level type
  private int IX(int x, int y) {
    return x +(NXYZ.x+2) *y;
    // return x +(NXYZ.x+2) *y +(NXYZ.y+2);
  }

  // same applies to the swap operation ^^ 
  private void SWAP(float[] x0, float[] x) {
    float[] tmp = new float[num_cell];
    arraycopy(x0, 0, tmp, 0, num_cell);
    arraycopy(x, 0, x0, 0, num_cell);
    arraycopy(tmp, 0, x, 0, num_cell);
  }
}























/**
Navier_Stokes_3D 
2017-2017
v 0.1.1
by Stan le Punk
http://stanlepunk.xyz

Refactoring C code from Mike Ash
https://www.mikeash.com/pyblog/fluid-simulation-for-dummies.html
*/

public class Navier_Stokes_3D extends Navier_Stokes {
  /**
  constructor
  */
  public Navier_Stokes_3D(int N) {
    super(N, 20, true);
  }
  public Navier_Stokes_3D(int N, int iter) {
    super(N, iter, true);
  }

  public Navier_Stokes_3D(iVec3 NXYZ) {
    super(NXYZ, 20, false);
  }
  public Navier_Stokes_3D(iVec3 NXYZ, int iter) {
    super(NXYZ, iter, false);
  }







  /**
  public method
  */
  /**
  get
  */
  public float get_dx(int x, int y, int z) {
    return s[IX(x+1, y+1, z+1)];
  }

  public float get_dy(int x, int y, int z) {
    return t[IX(x+1, y+1, z+1)];
  }

  public float get_dz(int x, int y, int z) {
    return p[IX(x+1, y+1, z+1)];
  }


  /**
  set
  */
  public void set_dx(int x, int y, int z, float value) {
    s[IX(x+1, y+1, z+1)] = value;
  }

  public void set_dy(int x, int y, int z, float value) {
    t[IX(x+1, y+1, z+1)] = value;
  }

  public void set_dz(int x, int y, int z, float value) {
    p[IX(x+1, y+1, z+1)] = value;
  }






/** 
apply force
v 0.0.2
*/
  public void apply_force(int cell_x, int cell_y, int cell_z, float vx, float vy, float vz) {
    cell_x += 1;
    cell_y += 1;
    cell_z += 1;
    int which_one = IX(cell_x, cell_y, cell_z) ;
    if(which_one >= 0) {
      if(which_one < s.length) {
        float dx = s[which_one];
        s[which_one] = (vx != 0) ? 
        lerp(vx, dx, 0.85f) : 
        dx;
      }

      if(which_one < t.length) {
        float dy = t[which_one];
        t[which_one] = (vy != 0) ? 
        lerp(vy,dy, .85f) : 
        dy;
      }

      if(which_one < p.length) {
        float dz = p[which_one];
        p[which_one] = (vz != 0) ? 
        lerp(vz, dz, .85f) : 
        dz;
      }
    }      
  }







/**
update
*/
  public void update(float dt, float visc, float diff) {
    vel_step(s, t, p, s_prev, t_prev, p_prev, visc, dt);
    dens_step(dst, dst_prev, s, t, p, diff, dt);
  }
  
  private void vel_step(float[] s, float[] t, float[] p, float[] s0, float[] t0, float[] p0, float visc, float dt) {
    // step 0
    add_source(s, s0, dt); // x
    add_source(t, t0, dt); // y
    add_source(p, p0, dt); // z
    // step 1
    SWAP(s0, s); // s
    diffuse(1, s, s0, visc, dt, iter, N); // s
    SWAP(t0, t); // t
    diffuse(2, t, t0, visc, dt, iter, N); // t
    SWAP(p0, p); // p
    diffuse(3, p, p0, visc, dt, iter, N); // p

    project(s, t, p, s0, t0, iter, N);

    // step 2
    SWAP(s0, s); // x
    SWAP(t0, t); // y
    SWAP(p0, p); // z
    advect(1, s, s0, s0, t0, p0, dt, N); // x
    advect(2, t, t0, s0, t0, p0, dt, N); // y
    advect(3, p, p0, s0, t0, p0, dt, N); // z
    project(s, t, p, s0, t0, iter, N);
  }


  private void dens_step(float[] x, float[] x0, float[] s, float[] t, float[] p, float diff, float dt) {
    add_source(x, x0, dt);
    SWAP(x0, x);
    diffuse(0, x, x0, diff, dt, iter, N);
    SWAP(x0, x);
    advect(0, x, x0, s, t, p, dt, N);
  }




  /**
  main method
  */

  /**
  diffusion
  */
  private void diffuse(int b, float[] x, float[] x0, float diff, float dt, int iter, int N) {
    float a = dt * diff * (N - 2) * (N - 2);
    lin_solve(b, x, x0, a, 1 + 6 * a, iter, N);
  }





  /**
  advect
  */
  private void advect(int b, float[] d, float[] d0, float[] vel_x, float[] vel_y, float[] vel_z, float dt, int N) {
    float i0, i1, j0, j1, k0, k1;
    
    float dtx = dt *(N -2);
    float dty = dt *(N -2);
    float dtz = dt *(N -2);
    
    float s0, s1, t0, t1, u0, u1;
    float tmp1, tmp2, tmp3, x, y, z;

    for(int k = 1 ; k < N -1 ; k++) {
      for(int j = 1 ; j < N -1; j++) { 
        for(int i = 1 ; i < N -1; i++) {
          tmp1 = dtx *vel_x[IX(i,j,k)];
          tmp2 = dty *vel_y[IX(i,j,k)];
          tmp3 = dtz *vel_z[IX(i,j,k)];
          x = i -tmp1; 
          y = j -tmp2;
          z = k -tmp3;
          
          if(x < .5f) x = .5f; 
          if(x > N +.5f) x = N +.5f;
          i0 = floor(x); 
          i1 = i0 + 1.f;

          if(y < .5f) y = .5f; 
          if(y > N +.5f) y = N +.5f; 
          j0 = floor(y);
          j1 = j0 + 1.f; 

          if(z < .5f) z = .5f;
          if(z > N +.5f) z = N +.5f;
          k0 = floor(z);
          k1 = k0 + 1.f;
          
          s1 = x -i0; 
          s0 = 1.f -s1; 
          t1 = y -j0; 
          t0 = 1.f -t1;
          u1 = z -k0;
          u0 = 1.f -u1;
          
          int i0i = (int)i0;
          int i1i = (int)i1;
          int j0i = (int)j0;
          int j1i = (int)j1;
          int k0i = (int)k0;
          int k1i = (int)k1;
          
          d[IX(i, j, k)] = s0 *(t0 *(u0 *d0[IX(i0i, j0i, k0i)] 
                                    +u1 *d0[IX(i0i, j0i, k1i)]) 
                              +(t1 *(u0 *d0[IX(i0i, j1i, k0i)] 
                                    +u1 *d0[IX(i0i, j1i, k1i)]))) 
                          +s1 *(t0 *(u0 *d0[IX(i1i, j0i, k0i)] 
                                    +u1 *d0[IX(i1i, j0i, k1i)]) 
                              +(t1 *(u0 *d0[IX(i1i, j1i, k0i)] 
                                    +u1 *d0[IX(i1i, j1i, k1i)])));
        }
      }
    }
    set_bnd(b, d, N);
  }
  /**
  boundary
  */
  private void set_bnd(int flag, float[] x, int N) {

    for(int j = 1 ; j < N -1 ; j++) {
        for(int i = 1 ; i < N -1; i++) {
            x[IX(i,j,0)] = flag == 3 ? 
            -x[IX(i,j,1)] : 
            x[IX(i,j,1)];
            x[IX(i,j,N-1)] = flag == 3 ? 
            -x[IX(i,j,N-2)] : 
            x[IX(i,j,N-2)];
        }
    }
    for(int k = 1; k < N -1 ; k++) {
        for(int i = 1 ; i < N -1 ; i++) {
            x[IX(i,0 ,k)] = flag == 2 ?
             -x[IX(i,1,k)] : 
             x[IX(i,1,k)];
            x[IX(i,N-1,k)] = flag == 2 ? 
            -x[IX(i,N-2,k)] : 
            x[IX(i,N-2,k)];
        }
    }
    for(int k = 1; k < N -1; k++) {
        for(int j = 1; j < N -1; j++) {
            x[IX(0,j,k)] = flag == 1 ? 
            -x[IX(1,j,k)] : 
            x[IX(1,j,k)];
            x[IX(N-1,j,k)] = flag == 1 ? 
            -x[IX(N-2,j,k)] : 
            x[IX(N-2,j,k)];
        }
    }
    float ratio = .33f;
    x[IX(0,0,0)]       = ratio *(x[IX(1,0,0)] +x[IX(0,1,0)] +x[IX(0,0,1)]);
    x[IX(0,N-1,0)]     = ratio *(x[IX(1,N-1,0)] +x[IX(0,N-2,0)] +x[IX(0,N-1,1)]);

    x[IX(0,0,N-1)]     = ratio *(x[IX(1,0,N-1)] +x[IX(0,1,N-1)] +x[IX(0,0,N)]);
    x[IX(0,N-1,N-1)]   = ratio *(x[IX(1,N-1,N-1)] +x[IX(0,N-2,N-1)] +x[IX(0,N-1,N-2)]);

    x[IX(N-1,0,0)]     = ratio *(x[IX(N-2,0,0)] +x[IX(N-1,1,0)] +x[IX(N-1,0,1)]);
    x[IX(N-1,N-1,0)]   = ratio *(x[IX(N-2,N-1,0)] +x[IX(N-1,N-2,0)] +x[IX(N-1,N-1,1)]);
    
    x[IX(N-1,0,N-1)]   = ratio *(x[IX(N-2,0,N-1)] +x[IX(N-1,1,N-1)] +x[IX(N-1,0,N-2)]);
    x[IX(N-1,N-1,N-1)] = ratio *(x[IX(N-2,N-1,N-1)] +x[IX(N-1,N-2, N-1)] +x[IX(N-1,N-1,N-2)]);
  }



  

  /**
  project
  */
  private void project(float[] vel_x, float[] vel_y, float[] vel_z, float[] p, float[] div,  int iter, int N) {
    for (int k = 1 ; k < N-1 ; k++) {
      for (int j = 1 ; j < N-1 ; j++) {
        for (int i = 1 ; i < N-1 ; i++) {
          div[IX(i,j,k)] = -.5f *(vel_x[IX(i+1,j,k)] 
                                 -vel_x[IX(i-1,j,k)] 
                                 +vel_y[IX(i,j+1,k)] 
                                 -vel_y[IX(i,j-1,k)] 
                                 +vel_z[IX(i,j,k+1)] 
                                 -vel_z[IX(i,j,k-1)] ) /N;
          p[IX(i, j, k)] = 0;
        }
      }
    }
    set_bnd(0, div, N); 
    set_bnd(0, p, N);
    lin_solve(0, p, div, 1, 6, iter, N);
    for (int k = 1 ; k < N -1 ; k++) {
      for (int j = 1 ; j < N -1 ; j++) {
        for (int i = 1 ; i < N -1 ; i++) {
          vel_x[IX(i,j,k)] -=.5f *(p[IX(i+1,j,k)] -p[IX(i-1,j,k)]) *N;
          vel_y[IX(i,j,k)] -=.5f *(p[IX(i,j+1,k)] -p[IX(i,j-1,k)]) *N;
          vel_z[IX(i,j,k)] -=.5f *(p[IX(i,j,k+1)] -p[IX(i,j,k-1)]) *N;
        }
      }
    }
    set_bnd(1, vel_x, N);
    set_bnd(2, vel_y, N);
    set_bnd(3, vel_z, N);
  }

  /**
  util
  */
  private void lin_solve(int b, float[] x, float[] x0, float a, float c, int iter, int N) {
    float c_recip = 1. /c;
    for (int k = 0 ; k < iter ; k++) {
      for (int m = 1 ; m < N -1 ; m++) {
        for (int j = 1 ; j < N -1 ; j++) {
          for (int i = 1 ; i < N -1 ; i++) {
            x[IX(i,j,m)] = (x0[IX(i,j,m)] +a *(x[IX(i+1,j,m)] 
                                              +x[IX(i-1,j,m)] 
                                              +x[IX(i,j+1,m)] 
                                              +x[IX(i,j-1,m)] 
                                              +x[IX(i,j,m+1)] 
                                              +x[IX(i,j,m-1)])) *c_recip;
          }
        }
      }
      set_bnd(b, x, N);
    }
  }

  // method used to be 'static' since this class is not a top level type
  private int IX(int x, int y, int z) {
    // my solution
    return x +(N+2) *y +(N+2) *(N+2) *z;
    // solution from 
    // return x +y *N +z * N *N;
  }

        // same applies to the swap operation ^^ 
  private void SWAP(float[] x0, float[] x) {
    float[] tmp = new float[num_cell];
    arraycopy(x0, 0, tmp, 0, num_cell);
    arraycopy(x, 0, x0, 0, num_cell);
    arraycopy(tmp, 0, x, 0, num_cell);
  }
}
