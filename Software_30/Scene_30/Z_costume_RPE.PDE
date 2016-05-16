/**
RPE Costume 0.0.4
*/

void costume(Vec3 pos, int size_int,  int which_costume)  {
	Vec3 dir_null = Vec3() ;
	Vec3 size = Vec3(size_int) ;
	costume(pos, size, dir_null, which_costume) ;
}

void costume(Vec3 pos, Vec3 size,  int which_costume)  {
	Vec3 dir_null = Vec3() ;
	costume(pos, size, dir_null, which_costume) ;
}

/**
Change the method for method with 
case
and 
break
*/
void costume(Vec3 pos, Vec3 size, Vec3 dir, int which_costume) {
	if (which_costume == 0 ) {
		point(pos) ;
	}  else if (which_costume == 1 ) {
		matrix_start() ;
		translate(pos) ;
		ellipse(0,0, size.x, size.y) ;
		matrix_end() ;
	}  else if (which_costume == 2 ) {
		matrix_start() ;
		translate(pos) ;
		rect(0,0, size.x, size.y) ;
		matrix_end() ;
	}  




		else if (which_costume == 13 ) {
		primitive(pos, size.x, 3) ;
	}  else if (which_costume == 14 ) {
		primitive(pos, size.x, 4) ;
	} else if (which_costume == 15 ) {
		primitive(pos, size.x, 5) ;
	} else if (which_costume == 16 ) {
		primitive(pos, size.x, 6) ;
	} else if (which_costume == 17 ) {
		primitive(pos, size.x, 7) ;
	} else if (which_costume == 18 ) {
		primitive(pos, size.x, 8) ;
	} else if (which_costume == 19 ) {
		primitive(pos, size.x, 9) ;
	}




		else if (which_costume == 100) {
		matrix_start() ;
		translate(pos) ;
		sphere(size.x) ;
		matrix_end() ;
	}  else if (which_costume == 103) {
		matrix_start() ;
		translate(pos) ;
		tetrahedron((int)size.x) ;
		matrix_end() ;
	} else if (which_costume == 104) {
		matrix_start() ;
		translate(pos) ;
		box(size) ;
		matrix_end() ;
	} 



		else if (which_costume == 1001 ) {
		matrix_start() ;
		translate(pos) ;
		polyhedron("TETRAHEDRON","LINE", (int)size.x) ;
		matrix_end() ;
	} else if (which_costume == 1002 ) {
		matrix_start() ;
		translate(pos) ;
		polyhedron("CUBE","LINE", (int)size.x) ;
		matrix_end() ;
	} else if (which_costume == 1003 ) {
		matrix_start() ;
		translate(pos) ;
		polyhedron("OCTOHEDRON","LINE", (int)size.x) ;
		matrix_end() ;
	} else if (which_costume == 1004 ) {
		matrix_start() ;
		translate(pos) ;
		polyhedron("RHOMBIC COSI DODECAHEDRON SMALL","LINE", (int)size.x) ;
		matrix_end() ;
	} else if (which_costume == 1005 ) {
		matrix_start() ;
		translate(pos) ;
		polyhedron("ICOSI DODECAHEDRON","LINE", (int)size.x) ;
		matrix_end() ;
	}
}