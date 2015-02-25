    // init var
Class    PVector
///////////////
Name  set()
//////////////
Examples  

void setup() {
  size(100, 100);
  v = new PVector(0.0, 0.0, 0.0);
  v.set(vvv);
  println(v.x);  // Prints "20.0"
  println(v.y);  // Prints "30.0"
  println(v.z);  // Prints "40.0"
}


//////////////////////////////
Description   Sets the x, y, and z component of the vector using three separate variables, the data from a PVector, or the values from a float array.
/////////////////////////////
Syntax  

.set(x, y, z)
.set(x, y)
.set(v)
.set(source)


///////////////////
Parameters  
x   float: the x component of the vector
y   float: the y component of the vector
z   float: the z component of the vector
x   float: the x component of the vector
y   float: the y component of the vector
v   PVector: any variable of type PVector
source  float[]: array to copy from


////////////////////
Returns void