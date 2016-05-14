/**
RPE Costume 0.0.2
*/
void costume(Vec3 pos, int size,  int which_costume)  {
	Vec3 dir_null = Vec3() ;
	costume(pos, size, dir_null, which_costume) ;
}

void costume(Vec3 pos, int size, Vec3 dir, int which_costume) {
	if (which_costume == 0 ) {
		point(pos) ;
	} else if (which_costume == 1 ) {
		matrix_start() ;
		translate(pos) ;
		polyhedron("TETRAHEDRON","LINE", size) ;
		matrix_end() ;
	} else if (which_costume == 2 ) {
		matrix_start() ;
		translate(pos) ;
		polyhedron("CUBE","LINE", size) ;
		matrix_end() ;
	} else if (which_costume == 3 ) {
		matrix_start() ;
		translate(pos) ;
		polyhedron("OCTOHEDRON","LINE", size) ;
		matrix_end() ;
	} else if (which_costume == 4 ) {
		matrix_start() ;
		translate(pos) ;
		polyhedron("RHOMBIC COSI DODECAHEDRON SMALL","LINE", size) ;
		matrix_end() ;
	} else if (which_costume == 5 ) {
		matrix_start() ;
		translate(pos) ;
		polyhedron("ICOSI DODECAHEDRON","LINE", size) ;
		matrix_end() ;
	}
}