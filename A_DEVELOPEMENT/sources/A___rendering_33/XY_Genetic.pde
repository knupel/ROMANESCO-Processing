/**
GENETIC 
v 0.6.0
* @author Stan le Punk
* @see https://github.com/StanLepunK/Digital-Life-Processing/tree/master/GENETIC_SYSTEM
*/



/**
GENOTYPE
v 0.1.0
*/
/*
methode to generate a new genome from the mother and father genome
*/
Genome genotype(Genome mother, Genome father) {
  if(mother.num_chromosome() == father.num_chromosome() && mother.num_gene() == father.num_gene()) {
    // may be remove "1" for the gender chromosome ????
    String [] chromosome_name = new String[mother.num_chromosome() -1] ;
    for(int i = 0 ; i < chromosome_name.length ; i++) {
      chromosome_name[i] = mother.get_chromosome_name()[i] ;
    }
    String [] gene_name = new String[mother.num_gene() -1] ;
    Gene [] gene_data_mother = new Gene[mother.num_gene() -1] ;
    Gene [] gene_data_father = new Gene[mother.num_gene() -1] ;
    for(int i = 0 ; i < gene_name.length ; i++) {
      gene_name[i] = mother.get_genotype()[i].gene_name ;
      gene_data_mother[i] = mother.get_genotype()[i] ;
      gene_data_father[i] = father.get_genotype()[i] ;

    }
    return new Genome(chromosome_name, gene_name, gene_data_mother, gene_data_father) ;

  } else {
    return null ;
  }
}



/**
ARCHETYPE
v 0.1.0
*/
/*
method to generate a quick genome from a simple data
The method create two chromosome, one for the data value, one for the String data
int this method the first genome is used for the float data and the second for the String data
*/
Genome archetype(float [] float_data) {
  String [] string_data = new String[0] ;
  String [] data_name = new String[0] ;
  int gender = MAX_INT ;
  return archetype(float_data, string_data, data_name, gender) ;
}

Genome archetype(String [] string_data) {
  float [] float_data = new float[0] ;
  String [] data_name = new String[0] ;
  int gender = MAX_INT ;
  return archetype(float_data, string_data, data_name, gender) ;
}

Genome archetype(float [] float_data, String [] data_name) {
  String [] string_data = new String[0] ;
  int gender = MAX_INT ;
  return archetype(float_data, string_data, data_name, gender) ;
}

Genome archetype(String [] string_data, String [] data_name) {
  float [] float_data = new float[0] ;
  int gender = MAX_INT ;
  return archetype(float_data, string_data, data_name, gender) ;
}

Genome archetype(float [] float_data, String [] string_data, String [] data_name) {
  int gender = MAX_INT ;
  return archetype(float_data, string_data, data_name, gender) ;
}

Genome archetype(float [] float_data, int gender) {
  String [] string_data = new String[0] ;
  String [] data_name = new String[0] ;
  return archetype(float_data, string_data, data_name, gender) ;
}

Genome archetype(String [] string_data, int gender) {
  float [] float_data = new float[0] ;
  String [] data_name = new String[0] ;
  return archetype(float_data, string_data, data_name, gender) ;
}

Genome archetype(float [] float_data, String [] string_data, int gender) {
  String [] data_name = new String[0] ;
  return archetype(float_data, string_data, data_name, gender) ;
}

/*
Main method
*/
Genome archetype(float [] float_data, String [] string_data, String [] data_name, int gender) {
  int num_chromosome = 2 ;
  if(float_data.length < 1 || string_data.length < 1) {
    num_chromosome = 1 ;
  }
  String [] chromosome_name = new String[num_chromosome] ;

  int num_info = float_data.length + string_data.length ;
  Gene [] gene_data_mother = new Gene[num_info] ;
  Gene [] gene_data_father = new Gene[num_info] ;
  String [] gene_name = new String[num_info] ;
  // init var
  for(int i = 0 ; i < gene_name.length ; i++) { 
    gene_name[i] = Integer.toString(i) ;
  }

  int num_naming = 0 ;
  if (gene_name.length <= data_name.length) {
    num_naming = gene_name.length ; 
  } else { 
    num_naming = data_name.length ;
  }
  // loop on the smalest list to don't have out bound
  for(int i = 0 ; i < num_naming ; i++) {
    gene_name [i] = data_name[i] ;
  }


  // make chromosome
  int pointer = 0 ;

  if(float_data.length > 0) {
    chromosome_name[0] = "Float" ;
    for(int i = 0 ; i < float_data.length ; i++) {
      int locus = i ;
      vec2 mother = vec2(float_data[i]) ;
      vec2 father = vec2(float_data[i]) ;
      vec2 mother_dominance = vec2("RANDOM ZERO", 1) ;
      vec2 father_dominance = vec2("RANDOM ZERO", 1) ;
      gene_data_mother [i] = new Gene(chromosome_name[0], gene_name [pointer], locus, mother, mother_dominance) ;
      gene_data_father [i] = new Gene(chromosome_name[0], gene_name [pointer], locus, father, father_dominance) ;
      pointer++ ;
    }
  }
  if(string_data.length > 0) {
    int ID_chromosome = 1 ;
    if(float_data.length < 1) ID_chromosome = 0 ;
    chromosome_name[ID_chromosome] = "String" ;
    for(int i = 0 ; i < string_data.length ; i++) {
      int locus = i ;
      String mother_left = string_data[i] ;
      String mother_right = string_data[i] ;
      String father_left = string_data[i] ;
      String father_right = string_data[i] ;
      vec2 mother_dominance = vec2("RANDOM ZERO", 1) ;
      vec2 father_dominance = vec2("RANDOM ZERO", 1) ;
      gene_data_mother [pointer] = new Gene(chromosome_name[ID_chromosome], gene_name [pointer], locus, mother_left, mother_right, round(mother_dominance.x), round(mother_dominance.y))  ;
      gene_data_father [pointer] = new Gene(chromosome_name[ID_chromosome], gene_name [pointer], locus, father_left, father_right, round(father_dominance.x), round(father_dominance.y))  ;
      pointer++ ;
    }
  }
  

  // finalize
  if(gender == 0 || gender == 1) {
    return new Genome(chromosome_name, gene_name, gene_data_mother, gene_data_father, gender) ;
  } else {
    return new Genome(chromosome_name, gene_name, gene_data_mother, gene_data_father) ;
  }
}
















/**
HELIX 
v 0.2.0.0
*/
class Helix {
  Strand_DNA [] strand ;
  int num_strand ;
  int num_nucleotide ;
  int level ;
  vec2 radius ;
  vec3 final_pos ;
  DNA [] dna_seq ; 

  Helix (int num_strand, int num_nucleotide, int nucleotide_by_revolution) {
    // make a nucleotide chain if it's classic strand '1' or '2'
    if(num_strand == 2) {
      // this case is a real one case of ADN
      dna_seq = new DNA[1] ;
      dna_seq[0] = new DNA(num_nucleotide, true) ;
    } else {
      dna_seq = new DNA[num_strand] ;
      for(int i = 0 ; i < num_strand ; i++) {
        dna_seq[i] = new DNA(num_nucleotide, false) ;
      }
    }

    this.num_nucleotide = num_nucleotide ;
    this.num_strand = num_strand ;
    this.level = (int) num_nucleotide / nucleotide_by_revolution ;
    if(level < 1) level = 1 ;
    strand = new Strand_DNA [num_strand] ;
    float start_angle = 0 ;
    float angle = TAU / num_strand ;
    for(int i = 0 ; i < num_strand ; i++) {
      strand[i] = new Strand_DNA(num_nucleotide, nucleotide_by_revolution, start_angle) ;
      start_angle += angle ;
    }
  }






  /**
  setting
  */
  void set_radius(int radius) {
    set_radius(radius, radius) ;
  }

  void set_radius(int r_x, int r_y) {
    if(radius == null) {
      radius = vec2(r_x, r_y) ;
    } else {
      radius.set(r_x, r_y) ;
    }

    for(int i = 0 ; i < strand.length ; i++) {
      for(int k = 0 ; k < strand[i].size() ; k++) {
        strand[i].set_radius_x(k, radius.x) ;
        strand[i].set_radius_y(k, radius.y) ;
      }
    }
  }


  void rotation(float angle) {
    float step = TAU / strand.length ;
    for(int i = 0 ; i < strand.length ; i++) {
      strand[i].set_pos(angle +(i*step)) ;
    }
  }

  void set_height(int height_strand) {
    int size_h = height_strand / level ;
    for(int i = 0 ; i < strand.length ; i++) {
      for(int k = 0 ; k < strand[i].size() ; k++) {
        strand[i].set_height(k, size_h) ;
      }
    }
  }

  void set_final_pos(vec3 pos) {
    if(this.final_pos == null) {
      this.final_pos = pos.copy() ;
    } else {
      this.final_pos.set(pos) ;
    }

    for(int i = 0 ; i < strand.length ; i++) {
      for(int k = 0 ; k < strand[i].size() ; k++) {
        strand[i].add(k, final_pos) ;
      }
    }
  }
  
  /**
  GET

   */

     // info
  int size() {
    return strand.length ;
  }

  int num() {
    return strand.length *strand[0].size() ;
  }

  int length(int which_strand) {
    if(which_strand > num_strand) {
      return strand[which_strand].size() ;
    } else return 0 ;
  }

  int length() {
    return strand[0].size() ;
  }

  vec2 get_radius() {
    if(radius == null) radius = vec2(1) ;
    return radius ;
  }

  DNA get_DNA(int which_strand) {
    if(which_strand < num_strand) {
      return dna_seq[which_strand] ;
    } else {
      return null ;
    }
  }







  Strand_DNA [] get() {
    return strand ;
  }

  Strand_DNA get(int which_strand) {
    if(which_strand < num_strand) {
      return strand[which_strand] ;
    } else {
      return null ;
    }
  }


  // get pos
  vec3 get_final_pos() {
    return final_pos ;
  }
  
  // get array angle
  float [] get_nuc_angle() {
    int count = 0 ;
    float [] angle = new float[num_nucleotide *num_strand] ;
    for(int i = 0 ; i < num_strand ; i++) {
      for(int k = 0 ; k < num_nucleotide ; k++) {
        angle [count] = strand[i].get_angle(k) ;
        count ++ ;
      }
    }
    return angle ;
  }

  float [] get_nuc_angle(int which_strand) {
    if(which_strand < num_strand) {
      float [] angle = new float[strand[which_strand].size()] ;
      for(int i = 0 ; i < num_nucleotide ; i++) {
        angle[i] = strand[which_strand].get_angle(i) ;
      }
      return angle ;
    } else {
      float [] angle = new float[1] ;
      angle[0] = 0 ;
       System.err.println("target strand don't match with any strand") ;
      return angle ;
    }
  }



  // get array pos
  vec3 [] get_nuc_pos() {
    int count = 0 ;
    vec3 [] pos = new vec3[num_nucleotide *num_strand] ;
    for(int i = 0 ; i < num_strand ; i++) {
      for(int k = 0 ; k < num_nucleotide ; k++) {
        pos[count] = vec3() ;
        pos[count].set(strand[i].get_pos(k)) ;
        pos[count].add(final_pos) ;
        // center the helix
        pos[count].add(0, -get_height() *.5,0) ;
        count ++ ;
      }
    }
    return pos ;
  }

  vec3 [] get_nuc_pos(int which_strand) {
    if(which_strand < num_strand) {
      vec3 [] pos = new vec3[strand[which_strand].size()] ;
      for(int i = 0 ; i < num_nucleotide ; i++) {
        pos[i] = vec3() ;
        pos[i].set(strand[which_strand].get_pos(i)) ;
        pos[i].add(final_pos) ;
        // center the helix
        pos[i].add(0, -get_height() *.5,0) ;
      }
      return pos ;
    } else {
      return null ;
    }
  }


  float get_height() {
    int last_nuc = strand[0].size() -1;
    return strand[0].get_pos(last_nuc).y ;
  }

  float get_width() {
    return radius.x *2;
  }

  float get_depth() {
    return radius.z *2;
  }




  /**
  private class Strand_DNA 0.2.0
  */
  private class Strand_DNA {
    private vec4 [] coord ;
    int num_nucleotide ; 
    int nucleotide_by_revolution ;

    float spacing ;
    float radius = 1 ;

    Strand_DNA(int num_nucleotide, int nucleotide_by_revolution, float start_angle) {
      this.nucleotide_by_revolution = nucleotide_by_revolution ;
      this.num_nucleotide = num_nucleotide ;
      coord = new vec4[num_nucleotide] ;

      spacing = 1. / (float)nucleotide_by_revolution ;
      coord = nuc_coord(num_nucleotide, nucleotide_by_revolution, spacing, radius, start_angle) ;
    }


    // set
    void set_pos(float new_angle) {
      if(coord != null) {
        vec4 [] temp_pos = new vec4[coord.length] ;
        temp_pos = nuc_coord(num_nucleotide, nucleotide_by_revolution, spacing, radius, new_angle) ;
        for(int i = 0 ; i < temp_pos.length ; i++) {
          if(coord[i] == null ) {
            coord[i] = vec4(temp_pos[i]) ;
          } else {
            coord[i].set(temp_pos[i]) ;
          }
        }
      }
    }

    void set_height(int target, float ratio_height) {
      if(target < coord.length) {
        coord[target].mult(1,ratio_height,1,1) ;
      } 
    }

    void set_radius_x(int target, float ratio_x) {
      if(target < coord.length) {
        coord[target].mult(ratio_x,1,1,1) ;
      } 
    }
    

    // here it's delicate because the "z" is used for the y radius,
    // because for the helix we are not in the classic represation of coor XYZ
    void set_radius_y(int target, float ratio_z) {
      if(target < coord.length) {
        coord[target].mult(1,1,ratio_z,1) ;
      } 
    }

    

    // get
    int size() {
      if(coord != null) {
        return coord.length ;
      } else return 0 ;
    }


    vec3 get_pos(int target) {
      if(target < coord.length) {
        return vec3(coord[target].x, coord[target].y, coord[target].z) ;
      } else return null ;
    }


    float get_angle(int target) {
      if(target < coord.length) {
        return coord[target].a ;
      } else {
        System.err.println("target out of bounds") ;
        return 0 ;
      }
    }


    

    // add
    void add(int target, vec3 v) {
      if(target < coord.length) {
        coord[target].add(v) ;
      } 
    }
    


    private vec4 [] nuc_coord(int num, int revolution, float spacing, float radius, float start_angle) {
      int level = num / revolution ;
      vec4 [] pos_angle = new vec4[num] ;
      float angle = TAU / revolution ;
      float z = 0 ;
      int count = 0 ;
      if(num > 0) {
        float angle_proj = start_angle ;
        for(int i = 0 ; i <= level ; i++) {
          for(int k = 0 ; k < revolution ; k ++) {
            float angle_dir = k *angle +start_angle ;
            angle_dir *= -1 ;
            angle_proj += angle ;
            vec2 pos_XY = projection(angle_proj, radius) ;

            z += spacing ;
            vec3 pos_XYZ = vec3(pos_XY.x, z, pos_XY.y) ;
            
            if(count < pos_angle.length) {
              pos_angle[count] = vec4(pos_XYZ.x, pos_XYZ.y, pos_XYZ.z, angle_dir) ; ;
              count ++ ;
            } else {
              break ;
            }
            if(count >= num) break ;
          }
        }
        return pos_angle ;
      } else return null ;  
    }
  }
  // end private class Strand_DNA
}




/**
method public nucleotide position
*/
/*
vec3 [] helix(int num, int revolution, float spacing, float radius, float start_angle) {
  return nuc_pos(num, revolution, spacing, radius, start_angle)
}
*/
























/**
GENOME 0.1.0

*/
class Genome {
  ArrayList <Chromosome> list_chromosome = new ArrayList<Chromosome>() ;
  ArrayList <Info> gene_map = new ArrayList<Info>() ;
  String chromosome_gender_name = "Gender" ;
  int num_gene = 0  ;
  /**
  CONSTRUCTOR
  */

  Genome (String [] chromosome_name, String[] gene_name, Gene [] gene_data_mother, Gene [] gene_data_father) {
    // build variable with all data from mother and father
    build_genome(chromosome_name, gene_name, gene_data_mother, gene_data_father) ;
    // choice the gender of creature DNA, if the random is under .5, the gender is female
    gender_chromosome(random(1)) ; 
    // here we add "1" for the gender chromosome
    num_gene = gene_name.length +1 ;
    // genemap
    write_gene_map() ;
  }

  Genome (String [] chromosome_name, String[] gene_name, Gene [] gene_data_mother, Gene [] gene_data_father, int gender) {
    // build variable with all data from mother and father
    build_genome(chromosome_name, gene_name, gene_data_mother, gene_data_father) ;
    // choice the gender of creature DNA, if the random is under .5, the gender is female
    if(gender < 1) gender = 0 ; else gender = 1 ;
    gender_chromosome(gender) ; 
    // here we add "1" for the gender chromosome
    num_gene = gene_name.length +1 ;
        // genemap
    write_gene_map() ;
  }



  /**
  build Chromosome
  */
  void build_genome(String [] chromosome_name, String[] gene_name, Gene [] gene_data_mother, Gene [] gene_data_father) {
    //preparation
    Zygote [] zygote_data = new Zygote[gene_name.length] ;

    int [] num_gene_by_chromosome = new int[chromosome_name.length] ;
    for(int i = 0 ; i < gene_name.length ; i++) {
      for(int j = 0 ; j < chromosome_name.length ; j++) {
        if(gene_data_mother[i].chromosome_name.equals(chromosome_name[j])) {
          num_gene_by_chromosome[j]++ ;
        }
      }
    }

    int [] step_num_gene = new int[chromosome_name.length] ;
    for(int i = 0 ; i < step_num_gene.length ; i++) {
      for( int j = 0 ; j < i ; j++) {
        step_num_gene [i] += num_gene_by_chromosome[j] ;
      }
    }




    for(int i = 0 ; i < zygote_data.length ; i++ ) {
    // check if the allele mother and the allele father have same chromosome
      if(gene_data_mother[i].gene_name.equals(gene_data_father[i].gene_name)) {
        // number locus when there is no locus allocation.
        int locus = 0 ;
        if(gene_data_mother[i].locus >= 0 ) {
          locus = gene_data_mother[i].locus ; 
        } else {
          for(int j = 0 ; j < step_num_gene.length ; j++) {
            if(i < step_num_gene [j] && j > 0) {
              locus = i -step_num_gene [j]  ;
              break ;
            } else {
              locus = i ;
            }
          }
        }
        zygote_data[i] = new Zygote( gene_data_mother[i].chromosome_name, 
                                     gene_data_mother[i].gene_name,
                                     locus,  

                                     gene_data_mother[i].data_left_arm, 
                                     gene_data_mother[i].data_right_arm, 
                                     gene_data_mother[i].dominance_left_arm, 
                                     gene_data_mother[i].dominance_right_arm, 

                                     gene_data_father[i].data_left_arm, 
                                     gene_data_father[i].data_right_arm, 
                                     gene_data_father[i].dominance_left_arm, 
                                     gene_data_father[i].dominance_right_arm ) ;
      }
    }



    // how to choice which allele for which chromosome ?????
    int pointer = 0 ;
    for(int i = 0 ; i < chromosome_name.length ; i++) {
      String [] gene_name_by_chromosome = new String[num_gene_by_chromosome[i]] ;
      // create a raw Zygote without the name
      Zygote [] gene_data_by_chromosome = new Zygote[num_gene_by_chromosome[i]] ;
      int rank = 0 ;
      for(int j = pointer ; j < pointer + num_gene_by_chromosome[i] ; j++) {
        if(zygote_data[j].chromosome_name == chromosome_name[i]) {
          gene_name_by_chromosome[rank] =  gene_name[j] ;
          gene_data_by_chromosome[rank] =  new Zygote(  zygote_data[j].chromosome_name,
                                                        zygote_data[j].name, 
                                                        zygote_data[j].locus,

                                                        zygote_data[j].mother_data_left_arm, 
                                                        zygote_data[j].mother_data_right_arm, 
                                                        zygote_data[j].mother_dominance_left_arm, 
                                                        zygote_data[j].mother_dominance_right_arm, 

                                                        zygote_data[j].father_data_left_arm, 
                                                        zygote_data[j].father_data_right_arm, 
                                                        zygote_data[j].father_dominance_left_arm, 
                                                        zygote_data[j].father_dominance_right_arm) ;
          rank++ ;
        }
      }
      pointer += rank ;
      int rank_chromosome = i ;
      Chromosome c = new Chromosome(chromosome_name[i], rank_chromosome, gene_name_by_chromosome, gene_data_by_chromosome) ;
      list_chromosome.add(c) ;
    }
  }






  /**
  ADD GENE 
  WORK IN PROGRESS
  */
  Chromosome add_gene_to_chromosome(String chromosome, String[] gene_name, Gene [] gene_data_mother, Gene [] gene_data_father) {
    Chromosome c = new Chromosome() ; ;
    return c ;

  }



  /**
  Set Chromosome after buid
  WORK IN PROGRESS
  */
  
  void set_gender_chromosome(String[] gene_name, Gene [] gene_data_mother, Gene [] gene_data_father) {
    for(Chromosome c : list_chromosome ) {
      if(c.chromosome_name == "Gender") {
        add_gene_to_chromosome("Gender", gene_name, gene_data_mother, gene_data_father) ;
      }
    }
  } 
  








  /**
  NUM

  */
  /**
  get num
  */
  // get num of chromosome
  int num_chromosome() {
    return list_chromosome.size() ;
  }

  int num_gene() {
    int num = 0 ;
    for(int i = 0 ; i < list_chromosome.size() ; i++ ) {
      Chromosome c = list_chromosome.get(i) ;
      int num_allele = num_allele (c) ;
      num += num_allele ;
    }
    return num ;
  }

  /**
  READ

  */
  /**
  get name
  */
  String [] get_chromosome_name() {
    String [] chromosome_name = new String[list_chromosome.size()] ;
    for(int i = 0 ; i < list_chromosome.size() ; i++ ) {
      Chromosome c = list_chromosome.get(i) ;
      chromosome_name [i] = c.chromosome_name ;
    }
    return chromosome_name ;
  }

  /**
  get genotype
  */
  Gene [] get_genotype() {
    Gene [] gene = new Gene[num_gene()] ;
    int pointer = 0 ;
    for(int i = 0 ; i < list_chromosome.size() ; i++) {
      for(int j = 0 ; j < get_chromosome(i).length ; j++) {
        gene[pointer] = get_chromosome(i)[j] ;
        pointer++ ;
      }
    }
    return gene ;
  }

  /**
  get chromosome
  */

  Gene [] get_chromosome(int which_chromosome) {
    // Chromosome c ;
    if(which_chromosome > list_chromosome.size()) {
      Chromosome c = list_chromosome.get(0) ;
      return get_chromosome(c) ;
    } else {
      Chromosome c = list_chromosome.get(which_chromosome) ;
      return get_chromosome(c) ;
    }

  }


  Gene [] get_chromosome(Chromosome c) {
    if(c != null) {
      int num_allele = c.list_allele_left.size() ;
      int size_left = c.list_allele_left.size() ;
      int size_right = c.list_allele_right.size() ;
      // choice the arm
      if(size_left > size_right) num_allele = size_right ; 
      Gene [] gene = new Gene[num_allele] ;
      // attribution data
      for(int i = 0 ; i < num_allele ; i++ ) {
        Allele left = c.list_allele_left.get(i) ;
        Allele right = c.list_allele_right.get(i) ;
        gene [i] = new Gene(c.chromosome_name, left.name, left.locus, left.data, right.data, left.dominance, right.dominance)  ; 
      }
      return gene ;
    } else return null ;
  }




  /**
  get gene
  */
  Gene get_gene(String target) {
    Gene gene = null ;
    boolean match = false  ;
    for(int i = 0 ; i < get_genotype().length ; i++) {
      if(get_genotype()[i].gene_name.equals(target)) {
        gene = get_genotype()[i] ;
        match = true ;
        break ;
      } else {
        match = false ;
        gene = get_genotype()[0] ;
      }
    }
    if(!match) println("Gene get_gene(String target) : your target don't match with any genes of the genotype, instead we use gene '0'") ;
    return gene ;
  }

  Gene get_gene(int target) {
    // Gene gene = null ;
    boolean match = false  ;
    if(target >= num_gene() || target < 0) {
      match = false ;
      target = 0 ;
    } else {
      match = true ;
    }

    if(!match) println("Gene get_gene(int target) : your target don't match with any genes of the genotype, instead we use gene '0'") ;
    return get_genotype()[target] ;
  }

  /**
  get DNA
  */
  char [] get_DNA(String chromosome_name, String gene_name, int arm) {
    char [] sequence_dna = new char[1] ;
    for(int i = 0 ; i < list_chromosome.size() ; i++ ) {
      Chromosome c = list_chromosome.get(i) ;
      if(c.chromosome_name.equals(chromosome_name)) {
        sequence_dna = new char[get_DNA(c, gene_name, arm).length] ;
        for(int j = 0 ; j < sequence_dna.length ; j++) {
          sequence_dna[j] = get_DNA(c, gene_name, arm)[j] ;
        }
        break ;
      }
    }
    return sequence_dna ;
  }


  char [] get_DNA(String chromosome_name, int which_gene, int arm) {
    char [] sequence_dna = new char[1] ;
    for(int i = 0 ; i < list_chromosome.size() ; i++ ) {
      Chromosome c = list_chromosome.get(i) ;
      if(c.chromosome_name.equals(chromosome_name)) {
        sequence_dna = new char[get_DNA(c, which_gene, arm).length] ;
        for(int j = 0 ; j < sequence_dna.length ; j++) {
          sequence_dna[j] = get_DNA(c, which_gene, arm)[j] ;
        }
        break ;
      }
    }
    return sequence_dna ;
  }

  char [] get_DNA(int which_chromosome, int which_gene, int arm) {
    char [] sequence_dna = new char[1] ;
    if(which_chromosome < list_chromosome.size()) {
      Chromosome c = list_chromosome.get(which_chromosome) ;
      sequence_dna = new char[get_DNA(c, which_gene, arm).length] ;
      for(int j = 0 ; j < sequence_dna.length ; j++) {
        sequence_dna[j] = get_DNA(c, which_gene, arm)[j] ;
      }
    }
    return sequence_dna ;
  }




  char [] get_DNA(Chromosome c, int which_gene, int arm) {
    char [] sequence_dna = new char[1] ;

    if (c != null) {
      if( arm == 0 ) {
        sequence_dna = new char[loop_dna(which_gene, c.list_allele_left, sequence_dna).length] ;
        for(int i = 0 ; i < sequence_dna.length ; i++) {
          sequence_dna[i] = loop_dna(which_gene, c.list_allele_left, sequence_dna)[i] ;
        }
      } else if(arm == 1) {
        sequence_dna = new char[loop_dna(which_gene, c.list_allele_right, sequence_dna).length] ;
        for(int i = 0 ; i < sequence_dna.length ; i++) {
          sequence_dna[i] = loop_dna(which_gene, c.list_allele_right, sequence_dna)[i] ;
        }
      } 
    }
    return sequence_dna ;
  }
  


  char [] get_DNA(Chromosome c, String gene_name, int arm) {
    char [] sequence_dna = new char[1] ;

    if (c != null) {
      if( arm == 0 ) {
        int num = c.list_allele_left.size() ;
        sequence_dna = new char[loop_dna(gene_name, num, c.list_allele_left, sequence_dna).length] ;
        for(int i = 0 ; i < sequence_dna.length ; i++) {
          sequence_dna[i] = loop_dna(gene_name, num, c.list_allele_left, sequence_dna)[i] ;
        }
      } else if(arm == 1) {
        int num = c.list_allele_right.size() ;
        sequence_dna = new char[loop_dna(gene_name, num, c.list_allele_right, sequence_dna).length] ;
        for(int i = 0 ; i < sequence_dna.length ; i++) {
          sequence_dna[i] = loop_dna(gene_name, num, c.list_allele_right, sequence_dna)[i] ;
        }
      } 
    }
    return sequence_dna ;
  }
  






  





  /**
  // get gene product
  */

  Info get_gene_product(String target) {
    Info info = new Info_Object(target, "no gene for this name") ;

    int length  = get_gene_product().length ;
    int count  = 0 ;
    for(int i = 0 ; i < length ; i++) {
      if(get_gene_product()[i].get_name().contains(target)) {
        count ++ ;
        if(get_gene_product()[i].catch_obj(0) != null)  {
          info = new Info_Object(get_gene_product()[i].get_name(), get_gene_product()[i].catch_obj(0)) ;
        } else {
          info = new Info_Object(get_gene_product()[i].get_name(), "no data match with the request") ;
        }
      }
    }
    if(count > 1 ) info = new Info_Object("target", "Find " + count + " targets for your target") ;
    return info ;
  }

  Info get_gene_product(String target_chromosome, String target_gene) {
    Info info = new Info_Object(target_gene, "the chromosome or gene don't exist") ;
    for(int i = 0 ; i < list_chromosome.size() ; i++) {
      Chromosome c = list_chromosome.get(i) ;
      if(c.chromosome_name.equals(target_chromosome)) {
        for(int j = 0 ; j < get_gene_product(i).length ; j++ ) {
          if(get_gene_product(i)[j].catch_obj(0) != null)  {
          info = new Info_Object(get_gene_product(i)[j].get_name(), get_gene_product(i)[j].catch_obj(0)) ;
        } else {
          info = new Info_Object(get_gene_product(i)[j].get_name(), "no data match with the request") ;
        }

        }
      }
    }
    return info ;
  }


  Info get_gene_product(int which_chromosome, int locus) {
    Info info = new Info_Object("Chromosome: " + which_chromosome + " locus: " +locus, "don't exist") ;
    if(which_chromosome < list_chromosome.size() &&  locus < list_chromosome.get(which_chromosome).list_allele_left.size() ) {
      if(get_gene_product(which_chromosome)[locus].catch_obj(0) != null)  {
        info = new Info_Object(get_gene_product(which_chromosome)[locus].get_name(), get_gene_product(which_chromosome)[locus].catch_obj(0)) ;
      } else {
        info = new Info_Object(get_gene_product(which_chromosome)[locus].get_name(), "no data match with the request") ;
      }
    }
    return info ;
  }



  
  Info [] get_gene_product() {
    Info [] info_gene = new Info_Object [num_gene] ;
    int pointer = 0 ;
    for(int i = 0 ; i < list_chromosome.size() ; i++ ) {
      Chromosome c = list_chromosome.get(i) ;
      int num_allele = num_allele (c) ;
      for(int j = 0 ; j < num_allele ; j++) {
        info_gene [ pointer +j] = get_gene_product(i)[j] ;
      }
      pointer += num_allele ;
    }
    return info_gene ;
  }


 

  Info [] get_gene_product(int which_chromosome) {
    if(which_chromosome < list_chromosome.size()) {
      Chromosome c = list_chromosome.get(which_chromosome) ;
      int num_allele = num_allele(c) ;

      Info []allele_name = new Info_Object [num_allele] ;
      // attribution data
      for(int i = 0 ; i < num_allele ; i++ ) {
        Allele left = c.list_allele_left.get(i) ;
        Allele right = c.list_allele_right.get(i) ;
        
        // look for the dominance, recessive or codominace operation
        boolean number ;
        float gene_product_float = 0 ;
        String gene_product_string = "" ;
        float temp_left_dominance = Float.valueOf(left.dominance) ;
        float temp_right_dominance = Float.valueOf(right.dominance) ;
        // test if the data is String or float, 
        try {
          float temp_left_data = Float.valueOf(left.data) ;
          float temp_right_data = Float.valueOf(right.data) ;
          number = true ;
          gene_product_float = ((temp_left_data *temp_left_dominance) +(temp_right_data *temp_right_dominance)) / (temp_left_dominance +temp_right_dominance) ;
        } catch (NumberFormatException e) {
          number = false ;
          if(temp_left_dominance > temp_right_dominance) {
            gene_product_string = left.data ;
          } else if(temp_left_dominance < temp_right_dominance){ 
            gene_product_string = right.data ;
          } else {
            if(left.data == right.data ) {
              gene_product_string = left.data ;
            } else {
              gene_product_string = left.data + right.data ;
            }
          }
        }
        if(number) {
         allele_name [i] = new Info_Object(c.chromosome_name + " > " + left.name, gene_product_float)  ; 
        } else {
          allele_name [i] = new Info_Object(c.chromosome_name + " > " + left.name, gene_product_string)  ;
        }
      }
      return allele_name ;
    } else {
      Info [] i = new Info_Object [1] ;
      i[0] = new Info_Object("This chromosome is not found", which_chromosome) ;
      return i ;
    }
  }




  /**
  MUTATION

  */
  /**
  get to specific allele gene to do mutation of data.
  */
  // data mutation
  void mutation_data(String target_gene, String mutation, boolean left, boolean right) {
    boolean match = false  ;
    int which_chromosome = 0 ;
    int locus = 0 ;
    // find the gene who match with the target
    for (Info i : gene_map) {
      if(i.catch_obj(0).equals(target_gene)) {
        which_chromosome = Integer.parseInt((String)i.catch_obj(1));
        locus = Integer.parseInt((String)i.catch_obj(2));
        match = true ;
        break ;
      } else {
        match = false ;
      }
    }
    // mutation
    if(!match) {
      println("Target gene don't match with any genes of the genotype, no mutation can be done") ;
    } else {
      if(left) {
        list_chromosome.get(which_chromosome).list_allele_left.get(locus).data = mutation ;
      }
      if(right) {
        list_chromosome.get(which_chromosome).list_allele_right.get(locus).data = mutation ;
      }
    }
  }
  
  
  void mutation_data(int which_chromosome, int locus, String mutation, boolean left, boolean right) {
    boolean match_left = false  ;
    boolean match_right = false  ;
    int locus_left  = 0 ;
    int locus_right = 0 ;
    
    // left part
    // find the gene who match with the target
    if(left) {
      if(which_chromosome < list_chromosome.size()) {
        if(locus < list_chromosome.get(which_chromosome).list_allele_left.size()) {
          locus_left = locus ;
          match_left = true ;
        }
      } else {
        match_left = false ;
      }
  
      // mutation
      if(!match_left) {
        println("Target Allele - gene - left don't match with any genes of the genotype, no mutation can be done") ;
      } else {
        list_chromosome.get(which_chromosome).list_allele_left.get(locus_left).data = mutation ;
      }
    }
    // right
     if(right) {
      if(which_chromosome < list_chromosome.size()) {
        if(locus < list_chromosome.get(which_chromosome).list_allele_right.size()) {
          locus_right = locus ;
          match_right = true ;
        }
      } else {
        match_right = false ;
      }
  
      // mutation
      if(!match_right) {
        println("Target Allele - gene - right don't match with any genes of the genotype, no mutation can be done") ;
      } else {
        list_chromosome.get(which_chromosome).list_allele_right.get(locus_right).data = mutation ;
      }
    }
  }
  
  // dominance mutation
  void mutation_dominance(String target_gene, float mutation, boolean left, boolean right) {
    boolean match = false  ;
    int which_chromosome = 0 ;
    int locus = 0 ;
    // find the gene who match with the target
    for (Info i : gene_map) {
      if(i.catch_obj(0).equals(target_gene)) {
        which_chromosome = Integer.parseInt((String)i.catch_obj(1));
        locus = Integer.parseInt((String)i.catch_obj(2));
        match = true ;
        break ;
      } else {
        match = false ;
      }
    }
    // mutation
    if(!match) {
      println("Target gene don't match with any genes of the genotype, no mutation can be done") ;
    } else {
      if(left) {
        list_chromosome.get(which_chromosome).list_allele_left.get(locus).dominance = mutation ;
      }
      if(right) {
        list_chromosome.get(which_chromosome).list_allele_right.get(locus).dominance = mutation ;
      }
    }
  }
  
    void mutation_dominance(int which_chromosome, int locus, float mutation, boolean left, boolean right) {
    boolean match_left = false  ;
    boolean match_right = false  ;
    int locus_left  = 0 ;
    int locus_right = 0 ;
    
    // left part
    // find the gene who match with the target
    if(left) {
      if(which_chromosome < list_chromosome.size()) {
        if(locus < list_chromosome.get(which_chromosome).list_allele_left.size()) {
          locus_left = locus ;
          match_left = true ;
        }
      } else {
        match_left = false ;
      }
  
      // mutation
      if(!match_left) {
        println("Target Allele - gene - left don't match with any genes of the genotype, no mutation can be done") ;
      } else {
        list_chromosome.get(which_chromosome).list_allele_left.get(locus_left).dominance = mutation ;
      }
    }
    // right
     if(right) {
      if(which_chromosome < list_chromosome.size()) {
        if(locus < list_chromosome.get(which_chromosome).list_allele_right.size()) {
          locus_right = locus ;
          match_right = true ;
        }
      } else {
        match_right = false ;
      }
  
      // mutation
      if(!match_right) {
        println("Target Allele - gene - right don't match with any genes of the genotype, no mutation can be done") ;
      } else {
        list_chromosome.get(which_chromosome).list_allele_right.get(locus_right).dominance = mutation ;
      }
    }
  }

  

  

  /**
  LOCAL METHOD

  */


    /**
  write gene map info
  */
  void write_gene_map() {
    gene_map.clear() ;
    for(int i = 0 ; i < get_genotype().length ; i++) {
      String chromosome_name_temp = get_genotype()[i].chromosome_name ;
      String chromosome_rank_temp = "-" ;
      for(int j = 0 ; j < get_chromosome_name().length ; j++) {
        if(get_chromosome_name()[j].equals(get_genotype()[i].chromosome_name)) chromosome_rank_temp = int_to_String(j) ;
      }
      String gene_name_temp = get_genotype()[i].gene_name ;
      String gene_locus_temp = int_to_String(get_genotype()[i].locus) ;
      Info temp = new Info_String(chromosome_name_temp, gene_name_temp, chromosome_rank_temp, gene_locus_temp) ;
      gene_map.add(temp) ;

    }
  }


  /**
  special chromosome for the gender ;
  */
  void gender_chromosome(float gender) {
    String [] allele_name = new String [1] ;
    // no specific data
    Zygote [] allele_data = new Zygote[1] ;
    allele_data [0] = new Zygote() ;
    allele_name [0] = ("Unknow") ;
    int rank_chromosome = list_chromosome.size() ;
    // build
    Chromosome chromosome_gender = new Chromosome(chromosome_gender_name, rank_chromosome, allele_name, allele_data, gender) ;
    list_chromosome.add(chromosome_gender) ;
  }


  int num_allele (Chromosome c) {
    int num = 0 ;
    num = c.list_allele_left.size() ;
    int size_left = c.list_allele_left.size() ;
    int size_right = c.list_allele_right.size() ;
    // choice the arm
    if(size_left > size_right) { 
      num = size_right ; 
    }
    return num ;
  }

  /**
  DNA writing
  */
  char [] loop_dna(int which_gene, ArrayList<Allele> list_allele, char[] seq) {
    if(which_gene < list_allele.size()) {
      Allele a = list_allele.get(which_gene) ;
      seq = new char[allele_dna(a).length] ;
      for(int j = 0 ; j < seq.length ; j++) {
        seq[j] = allele_dna(a)[j] ;
      } 
    }
    return seq ;
  }



  char [] loop_dna(String gene_name, int num, ArrayList<Allele> list_allele, char[] seq) {
    for(int i = 0 ; i < num ; i++ ) {
      Allele a = list_allele.get(i) ;
      if(a.name.equals(gene_name)) {
        seq = new char[allele_dna(a).length] ;
        for(int j = 0 ; j < seq.length ; j++) {
          seq[j] = allele_dna(a)[j] ;
        }
        break ;
      } 
    }
    return seq ;
  }
 
  //
  char [] allele_dna(Allele a) {

    char [] info = new char[1] ;
    int length_locus = a.dna_locus.get_sequence().length ;
    int length_ancester = a.dna_ancester.get_sequence().length ;
    int length_name = a.dna_name.get_sequence().length ;
    int length_data = a.dna_data.get_sequence().length ;
    int length_dominance = a.dna_dominance.get_sequence().length ;

    int total_length = length_locus +length_ancester +length_name +length_data +length_dominance ;
    info = new char[total_length] ;

    int pointer = 0 ;
    for(int i = 0 ; i < a.dna_locus.get_sequence().length ; i++ ) {
      info[pointer] = a.dna_locus.get_sequence()[i] ;
      pointer++ ;
    }
    for(int i = 0 ; i < a.dna_ancester.get_sequence().length ; i++ ) {
      info[pointer] = a.dna_ancester.get_sequence()[i] ;
      pointer++ ;
    }
    for(int i = 0 ; i < a.dna_name.get_sequence().length ; i++ ) {
      info[pointer] = a.dna_name.get_sequence()[i] ;
      pointer++ ;
    }
    for(int i = 0 ; i < a.dna_data.get_sequence().length ; i++ ) {
      info[pointer] = a.dna_data.get_sequence()[i] ;
      pointer++ ;
    }
    for(int i = 0 ; i < a.dna_dominance.get_sequence().length ; i++ ) {
      info[pointer] = a.dna_dominance.get_sequence()[i] ;
      pointer++ ;
    }
    return info ;
  }
  /**
  END LOCAL METHOD
  */
}
/**


END GENOME


*/




  




































/**


CHROMOSOME


*/

class Chromosome {
  // int [] telomere ;
  String chromosome_name ;
  int rank ;

  ArrayList <Allele> list_allele_left = new ArrayList<Allele>() ;
  ArrayList <Allele> list_allele_right = new ArrayList<Allele>() ;
  
  Chromosome() {} ;
  // CONSTRUCTOR for symetric arms chromosome
  Chromosome(String chromosome_name, int rank, String [] gene_name, Zygote [] data) {
    this.chromosome_name = chromosome_name ;
    this.rank = rank ;
    arm_left(gene_name, rank, data) ;
    arm_right(gene_name, rank, data) ;
  }

  // CONSTRUCTOR for gender arms chromosome, no symetric chromosome
  Chromosome(String chromosome_name, int rank, String [] gene_name, Zygote [] data, float gender) {
    this.rank = rank ;
    this.chromosome_name = chromosome_name ;
    int locus = 0 ;
    if(gender < .5 ) {
      gene_name [0] = "XX" ;
      data[0] = new Zygote(chromosome_name, "XX", locus, "X","X",0,0, "X","X",0,0) ;
      arm_left(gene_name, rank, data) ;
      arm_right(gene_name, rank, data) ;
    } else {
      // here we give no choice to the random for the allele distribution.
      gene_name [0] = "XY" ;
      data[0] = new Zygote(chromosome_name, "XY", locus, "X","X",0,0, "X","X",0,0) ;
      arm_left(gene_name, rank, data) ;
      data[0] = new Zygote(chromosome_name, "XY", locus, "Y","Y",1,1, "Y","Y",1,1) ;
      arm_right(gene_name, rank, data) ;
    }
  }

  
  


  void arm_left(String [] gene_name, int rank_chromosome, Zygote [] data) {
    build_allele(gene_name, rank_chromosome, data, list_allele_left) ;
  }
  
  void arm_right(String [] gene_name, int rank_chromosome, Zygote [] data) {
    build_allele(gene_name, rank_chromosome, data, list_allele_right) ;
  }


  void build_allele(String [] gene_name, int rank_chromosome, Zygote [] data, ArrayList<Allele> list_allele) {
    int ref_selected_gene = -1 ;
    for(int i = 0 ; i < gene_name.length ; i++) {
      try {
        // crossing-over
        String final_data = "" ;
        float final_dominance = 0 ;
        String allele_ancester = "" ;
        // choice the allele is replicate from mother or father and which arm, total 4 choices
        int which_allele_data = crossing_over(ref_selected_gene) ;
        ref_selected_gene = which_allele_data ;
        // replicate allele on the selected arm
        if(which_allele_data == 0) {
          allele_ancester = "mother" ;
          final_data = data[i].mother_data_left_arm ; 
          final_dominance = data[i].mother_dominance_left_arm ; 
        } else if (which_allele_data == 1) {
          allele_ancester = "mother" ;
          final_data = data[i].mother_data_right_arm ;
          final_dominance = data[i].mother_dominance_right_arm ; 
        } else if (which_allele_data == 2) {
          allele_ancester = "father" ;
          final_data = data[i].father_data_left_arm ;
          final_dominance = data[i].father_dominance_left_arm ; 
        } else {
          allele_ancester = "father" ;
          final_data = data[i].father_data_right_arm  ;
          final_dominance = data[i].father_dominance_right_arm ; 
        }
        // locus is the position of the allele in the chromosome arm,
        int locus = data[i].locus ;
        // build
        Allele allele = new Allele(rank_chromosome, locus, allele_ancester, gene_name[i], final_data, final_dominance) ;
        list_allele.add(allele) ;
      }
      catch(ArrayIndexOutOfBoundsException e) {
        e.printStackTrace();
      }
    }
  }





  int crossing_over(int ref) {
    int setected_gene = floor(random(4)) ;
    if(setected_gene == 4) setected_gene = 3 ;
    if(setected_gene == ref) crossing_over(ref) ;
    return setected_gene ;
  }
}
/**

END CLASS GENOME

*/


















/**

Zygote 
is a container for the mother and father gene


*/
class Zygote {
  String chromosome_name ;
  String name ; 
  int locus ;
  String mother_data_left_arm, mother_data_right_arm ;
  float mother_dominance_left_arm, mother_dominance_right_arm ;
  String father_data_left_arm, father_data_right_arm ;
  float father_dominance_left_arm, father_dominance_right_arm ;

  Zygote() {}

  Zygote (String chromosome_name, String name, 
          int locus,

          String mother_data_left_arm, String mother_data_right_arm, 
          float mother_dominance_left_arm, float mother_dominance_right_arm, 

          String father_data_left_arm, String father_data_right_arm, 
          float father_dominance_left_arm, float father_dominance_right_arm) {

    this.chromosome_name = chromosome_name ;
    this.name = name ; 
    this.locus = locus ;
    this.mother_data_left_arm = mother_data_left_arm ;
    this.mother_data_right_arm = mother_data_right_arm ;
    this.mother_dominance_left_arm = mother_dominance_left_arm ;
    this.mother_dominance_right_arm = mother_dominance_right_arm ;
    this.father_data_left_arm = father_data_left_arm ;
    this.father_data_right_arm = father_data_right_arm ;
    this.father_dominance_left_arm = father_dominance_left_arm ;
    this.father_dominance_right_arm = father_dominance_right_arm ;
  }
}
/**

END CLASS ZYGOTE

*/


















/**

ALLELE 0.1.1

*/
class Allele {
  int type = 0 ;
  /*
  allele type
  0 = lethal ;
  1 = null ;
  2 = co-dominance ;
  */
  /**
  dominance and recessive is a complexe question, must be resolve in the future
  */
  int rank_chromosome ;
  int locus ;
  String ancester ;
  String name ;
  String data ;
  float dominance ;
  DNA dna_locus, dna_ancester, dna_name, dna_data, dna_dominance ;
  Allele(int rank_chromosome, int locus, String ancester, String name, String data, float dominance) {
    this.rank_chromosome = rank_chromosome ;
    this.locus = locus ;
    this.ancester = ancester ;
    this.name = name ;
    this.data = data ;
    this.dominance = dominance ;
    dna_locus = new DNA(int_to_String(locus), true) ;
    dna_ancester = new DNA(ancester, true) ;
    dna_name = new DNA(name, true) ;
    dna_data = new DNA(data, true) ;
    dna_dominance = new DNA(float_to_String_4(dominance), true) ;
  }
}


















/**

GENE 
This class is used when we need it, but it's the Allele the real information container.

*/
class Gene {
  String chromosome_name ;
  String gene_name ;
  int locus = -1 ;
  String data_left_arm, data_right_arm ;
  float dominance_left_arm, dominance_right_arm ;


  /**
  with locus
  */
  Gene(String chromosome_name, String gene_name, int locus, String data_left_arm, String data_right_arm, float dominance_left_arm, float dominance_right_arm) {
    this.chromosome_name = chromosome_name ;
    this.gene_name = gene_name ;
    this.locus = locus ;
    this.data_left_arm = data_left_arm ;
    this.data_right_arm = data_right_arm ;
    this.dominance_left_arm = dominance_left_arm ;
    this.dominance_right_arm = dominance_right_arm ;
  }

  Gene(String chromosome_name, String gene_name, int locus, float data_left_arm, float data_right_arm, float dominance_left_arm, float dominance_right_arm) {
    this.chromosome_name = chromosome_name ;
    this.gene_name = gene_name ;
    this.locus = locus ;
    this.data_left_arm = float_to_String_3(data_left_arm) ;
    this.data_right_arm = float_to_String_3(data_right_arm) ;
    this.dominance_left_arm = dominance_left_arm ;
    this.dominance_right_arm = dominance_right_arm ;
  }


  Gene(String chromosome_name, String gene_name, int locus, vec2 data, vec2 dominance) {
    this.chromosome_name = chromosome_name ;
    this.gene_name = gene_name ;
    this.locus = locus ;
    this.data_left_arm = float_to_String_3(data.x) ;
    this.data_right_arm = float_to_String_3(data.y) ;
    this.dominance_left_arm = dominance.x ;
    this.dominance_right_arm = dominance.y ;
  }

  Gene(String chromosome_name, String gene_name, int locus, String data_left_arm, String data_right_arm, vec2 dominance) {
    this.chromosome_name = chromosome_name ;
    this.gene_name = gene_name ;
    this.locus = locus ;
    this.data_left_arm = data_left_arm ;
    this.data_right_arm = data_right_arm ;
    this.dominance_left_arm = dominance.x ;
    this.dominance_right_arm = dominance.y ;
  }

    /**
  without locus
  */
  Gene(String chromosome_name, String gene_name, String data_left_arm, String data_right_arm, float dominance_left_arm, float dominance_right_arm) {
    this.chromosome_name = chromosome_name ;
    this.gene_name = gene_name ;
    this.data_left_arm = data_left_arm ;
    this.data_right_arm = data_right_arm ;
    this.dominance_left_arm = dominance_left_arm ;
    this.dominance_right_arm = dominance_right_arm ;
  }

  Gene(String chromosome_name, String gene_name, float data_left_arm, float data_right_arm, float dominance_left_arm, float dominance_right_arm) {
    this.chromosome_name = chromosome_name ;
    this.gene_name = gene_name ;
    this.data_left_arm = float_to_String_3(data_left_arm) ;
    this.data_right_arm = float_to_String_3(data_right_arm) ;
    this.dominance_left_arm = dominance_left_arm ;
    this.dominance_right_arm = dominance_right_arm ;
  }


  Gene(String chromosome_name, String gene_name, vec2 data, vec2 dominance) {
    this.chromosome_name = chromosome_name ;
    this.gene_name = gene_name ;
    this.data_left_arm = float_to_String_3(data.x) ;
    this.data_right_arm = float_to_String_3(data.y) ;
    this.dominance_left_arm = dominance.x ;
    this.dominance_right_arm = dominance.y ;
  }

  Gene(String chromosome_name, String gene_name, String data_left_arm, String data_right_arm, vec2 dominance) {
    this.chromosome_name = chromosome_name ;
    this.gene_name = gene_name ;
    this.data_left_arm = data_left_arm ;
    this.data_right_arm = data_right_arm ;
    this.dominance_left_arm = dominance.x ;
    this.dominance_right_arm = dominance.y ;
  }



  String get_chromosome_name() {
    return chromosome_name ;
  }

  String get_gene_name() {
    return gene_name ;
  }

  int get_locus() {
    return locus ;
  }


  @ Override String toString() {
    return "[ < Chromosome " + chromosome_name + " > < Gene " + gene_name + " > < Locus " + locus + " >< data: " + data_left_arm + " / " + data_right_arm + " > < dominance: " + dominance_left_arm + " / " +dominance_right_arm + " > ]";
  }
}
/**

END GENETIC

*/



















/**

DNA 0.1.2

*/

Table CODE_DNA_REF  ;
char [] nucleotide_char ;
void load_nucleotide_table(String path) {
  CODE_DNA_REF = loadTable(path, "header") ;
  nucleotide_char = new char[CODE_DNA_REF.getRowCount()] ;
  for(int i = 0 ; i < nucleotide_char.length ; i++) {
    TableRow row = CODE_DNA_REF.getRow(i) ;
    String char_ref = row.getString("char") ;
    nucleotide_char[i] = char_ref.charAt(0) ;
  }
}



class DNA {
  ArrayList<Nucleotide> sequence_a  ;
  ArrayList<Nucleotide> sequence_b  ;
  // constructor
  DNA(String data, boolean pairing_dna) {
    sequence_a = new ArrayList<Nucleotide>() ;

    char [] array_char = data.toCharArray() ;
    for(int i = 0 ; i < array_char.length ; i++) {
      build_sequence(array_char[i]) ;
    }
    
    // pairing
    if(pairing_dna) {
      sequence_b = new ArrayList<Nucleotide>(pairing(sequence_a)) ;
    }
  }

  DNA(int size, boolean pairing_dna) {
    sequence_a = new ArrayList<Nucleotide>() ;
    int classic = 4 ;
    // with 4, it's classic ADN with GTAC
    for(int i = 0 ; i < size ; i++) {
      int nuc = floor(random(classic)) ;
      sequence_a.add(code(nuc)) ;
    }
    
    // pairing
    if(pairing_dna) {
      sequence_b = new ArrayList<Nucleotide>(pairing(sequence_a)) ;
    }
  }






  // methode
  Nucleotide nucleotide ;
  private void build_sequence(char c) {
    Nucleotide [] nucleotide  = new Nucleotide [4] ;
    for(int i = 0 ; i < nucleotide.length ; i++) {
      nucleotide [i] = translate(nucleotide, c)[i] ;
      sequence_a.add(nucleotide[i]) ;
    }
  }
  
  
  private char [] get_sequence() {
    char [] seq = new char[sequence_a.size()] ;
    for (int i = 0 ; i < sequence_a.size() ; i++) {
      Nucleotide n = (Nucleotide) sequence_a.get(i) ;
      seq[i] = n.nac ;
    }
    return seq ;
  }



  // mirror chain
  private ArrayList<Nucleotide> pairing(ArrayList<Nucleotide> strand) {
    ArrayList<Nucleotide> seq = new ArrayList<Nucleotide>() ;
    for(int i = 0 ; i < strand.size() ; i++) {
      Nucleotide nuc = strand.get(i) ;
      Nucleotide partner ;
      if(nuc.nac == 'c' || nuc.nac == 'C') partner = new Guanine() ;
      else if(nuc.nac == 'g' || nuc.nac == 'G') partner = new Cytosine() ;
      else if(nuc.nac == 't' || nuc.nac == 'T') partner = new Adenine() ;
      else if(nuc.nac == 'a'|| nuc.nac == 'A') partner = new Thymine() ;
      else partner = new Masked() ;
      seq.add(partner) ;
    }
    return seq ;
  }
}




/**
Translate char to Nucleotide
*/
private Nucleotide [] translate(Nucleotide [] n, char c) {
  for(int i = 0 ; i < nucleotide_char.length ; i++) {
    if(c == nucleotide_char[i]) {
      write_sequence(n, i) ;
      break ;
    } else {
      for(int j = 0 ; j < n.length ; j++) {
        n [j] = code('X') ;
      }
    }
  }
  return n ;
}

private void write_sequence(Nucleotide [] n, int row_id) {
  TableRow row = CODE_DNA_REF.getRow(row_id) ;
  String ref_sequence = row.getString("code") ;
  String [] sequence_a = ref_sequence.split("") ;
  for(int i = 0 ; i < sequence_a.length ; i++) {
    n[i] = code(sequence_a[i].charAt(0)) ;
  }
}


// Nucleotide from char
private Nucleotide code(char nac) {
  // nac : nucleic acid code from IUPAC
  if(nac == 'A' || nac == 'a') return new Adenine() ;
  else if(nac == 'C' || nac == 'c') return new Cytosine() ;
  else if(nac == 'G' || nac == 'g') return new Guanine() ;
  else if(nac == 'T' || nac == 't') return new Thymine() ;
  else return new Masked() ;
}

// Nucleotide from int
private Nucleotide code(int nac) {
  // nac : nucleic acid code from IUPAC
  if(nac == 0) return new Adenine() ;
  else if(nac == 1) return new Cytosine() ;
  else if(nac == 2) return new Guanine() ;
  else if(nac == 3) return new Thymine() ;
  else return new Masked() ;
}




/**
NUCLEOTIDE
*/
class Nucleotide {
  // nac : nucleic acid code from IUPAC
  char nac  ; 
}


class Guanine extends Nucleotide {
  Guanine () {
    this.nac = 'G' ;
  }
}

class Cytosine extends Nucleotide {
  Cytosine () {
    this.nac = 'C' ;
  }
}

class Adenine extends Nucleotide {
  Adenine () {
    this.nac = 'A' ;
  }
}

class Thymine extends Nucleotide {
  Thymine () {
    this.nac = 'T' ;
  }
}


class Masked extends Nucleotide {
  Masked() {
    this.nac = 'X' ;
  }
}








