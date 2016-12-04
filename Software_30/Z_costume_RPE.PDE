/**
RPE Costume 0.0.6
*/
final int POINT_RPE = 0 ;
final int ELLIPSE_RPE = 1 ;
final int RECT_RPE = 2 ;


final int TRIANGLE_RPE = 13 ;
final int SQUARE_RPE = 14 ;
final int PENTAGON_RPE = 15 ;
final int HEXAGON_RPE = 16 ;
final int HEPTAGON_RPE = 17 ;
final int OCTOGON_RPE = 18 ;
final int NONAGON_RPE = 19 ;
final int DECAGON_RPE = 20 ;

final int CROSS_2_RPE = 52 ;
final int CROSS_3_RPE = 53 ;

final int SPHERE_LOW_RPE = 100 ;
final int SPHERE_MEDIUM_RPE = 101 ;
final int SPHERE_HIGH_RPE = 102 ;
final int TETRAHEDRON_RPE = 103 ;
final int BOX_RPE = 104 ;


void costume(Vec3 pos, int size_int,  int which_costume)  {
	Vec3 dir_null = Vec3() ;
	Vec3 size = Vec3(size_int) ;
	costume(pos, size, dir_null, which_costume) ;
}

void costume(Vec3 pos, Vec3 size,  int which_costume)  {
	Vec3 dir_null = Vec3() ;
	costume(pos, size, dir_null, which_costume) ;
}

void costume(Vec2 pos, int size_int,  int which_costume)  {
	Vec3 dir_null = Vec3() ;
	Vec3 size = Vec3(size_int) ;
	costume(Vec3(pos.x,pos.y,0), size, dir_null, which_costume) ;
}

void costume(Vec2 pos, Vec3 size,  int which_costume)  {
	Vec3 dir_null = Vec3() ;
	costume(Vec3(pos.x,pos.y,0), size, dir_null, which_costume) ;
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




		else if (which_costume == 13) {
		primitive(pos, size.x, 3) ;
	}  else if (which_costume == 14) {
		primitive(pos, size.x, 4) ;
	} else if (which_costume == 15) {
		primitive(pos, size.x, 5) ;
	} else if (which_costume == 16) {
		primitive(pos, size.x, 6) ;
	} else if (which_costume == 17) {
		primitive(pos, size.x, 7) ;
	} else if (which_costume == 18) {
		primitive(pos, size.x, 8) ;
	} else if (which_costume == 19) {
		primitive(pos, size.x, 9) ;
	} else if (which_costume == 20) {
		primitive(pos, size.x, 10) ;
	}



		else if (which_costume == 52) {
		matrix_start() ;
		translate(pos) ;
		cross_2(size) ;
		matrix_end() ;
	} else if (which_costume == 53) {
		matrix_start() ;
		translate(pos) ;
		cross_3(size) ;
		matrix_end() ;
	}




		else if (which_costume == 100) {
		matrix_start() ;
		translate(pos) ;
		sphereDetail(5);
		sphere(size.x) ;
		matrix_end() ;
	} else if (which_costume == 101) {
		matrix_start() ;
		translate(pos) ;
		sphereDetail(12);
		sphere(size.x) ;
		matrix_end() ;
	}else if (which_costume == 102) {
		matrix_start() ;
		translate(pos) ;
		sphere(size.x) ;
		matrix_end() ;
	} else if (which_costume == 103) {
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



		else if (which_costume == 1001) {
		matrix_start() ;
		translate(pos) ;
		polyhedron("TETRAHEDRON","LINE", (int)size.x) ;
		matrix_end() ;
	} else if (which_costume == 1002) {
		matrix_start() ;
		translate(pos) ;
		polyhedron("CUBE","LINE", (int)size.x) ;
		matrix_end() ;
	} else if (which_costume == 1003) {
		matrix_start() ;
		translate(pos) ;
		polyhedron("OCTOHEDRON","LINE", (int)size.x) ;
		matrix_end() ;
	} else if (which_costume == 1004) {
		matrix_start() ;
		translate(pos) ;
		polyhedron("RHOMBIC COSI DODECAHEDRON SMALL","LINE", (int)size.x) ;
		matrix_end() ;
	} else if (which_costume == 1005) {
		matrix_start() ;
		translate(pos) ;
		polyhedron("ICOSI DODECAHEDRON","LINE", (int)size.x) ;
		matrix_end() ;
	}
}









// ANNEXE COSTUME
// CROSS
void cross_2(Vec3 size) {
	float ratio_cross = .3 ;
	float scale_cross = (size.x + size.y + size.z) *.3 ;
	float small_part = scale_cross *ratio_cross ;

	box(size.x, small_part, small_part) ;
	box(small_part, size.y, small_part) ;
}


void cross_3(Vec3 size) {
	float ratio_cross = .3 ;
	float scale_cross = (size.x + size.y + size.z) *.3 ;
	float small_part = scale_cross *ratio_cross ;
   
	box(size.x, small_part, small_part) ;
	box(small_part, size.y, small_part) ;
	box(small_part, small_part, size.z) ;
}
