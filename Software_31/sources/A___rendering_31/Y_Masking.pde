/**
class Mask_mapping
v 0.2.0
2018-2018
*/
public class Masking implements rope.core.RConstants {
  PGraphics pg;
  private iVec3 [] coord;
  private iVec3 [] coord_block_1, coord_block_2, coord_block_3, coord_block_4;
  private boolean init;
  private boolean block_is;
  private int c = BLACK;
  private int range = 10;
  

  // CONSTRUCTOR
  public Masking(iVec2 [] list) {
    coord = new iVec3[list.length];
    for(int i = 0 ; i < coord.length ;i++) {
      coord[i] = iVec3(list[i].x,list[i].y,0);
    }
    init = true;
  }


  public Masking(iVec2 [] list, iVec2 [] list_block_1, iVec2 [] list_block_2, iVec2 [] list_block_3, iVec2 [] list_block_4) {
    if(list.length != 8) {
      printErr("class Mask_mapping need exactly 8 points to create a block, no more no less, there is",list.length,"in the list, no mask can be create");
    } else {
      block_is = true ;
      coord = new iVec3[list.length];
      for(int i = 0 ; i < coord.length ;i++) {
        coord[i] = iVec3(list[i].x,list[i].y,0);
      }
      // block 1
      if(list_block_1 != null && list_block_1.length > 0) {
        coord_block_1 = new iVec3[list_block_1.length];
        for(int i = 0 ; i < coord_block_1.length ;i++) {
          coord_block_1[i] = iVec3(list_block_1[i].x,list_block_1[i].y,0);
        }
      }
      // block 2
      if(list_block_2 != null && list_block_2.length > 0) {
        coord_block_2 = new iVec3[list_block_2.length];
        for(int i = 0 ; i < coord_block_2.length ;i++) {
          coord_block_2[i] = iVec3(list_block_2[i].x,list_block_2[i].y,0);
        }
      }
      // block 3
      if(list_block_3 != null && list_block_3.length > 0) {
        coord_block_3 = new iVec3[list_block_3.length];
        for(int i = 0 ; i < coord_block_3.length ;i++) {
          coord_block_3[i] = iVec3(list_block_3[i].x,list_block_3[i].y,0);
        }
      }
      // block 4
      if(list_block_4 != null && list_block_3.length > 0) {
        coord_block_4 = new iVec3[list_block_4.length];
        for(int i = 0 ; i < coord_block_4.length ;i++) {
          coord_block_4[i] = iVec3(list_block_3[i].x,list_block_4[i].y,0);
        }
      }
    }
    init = true;
  }





  // METHOD
  public iVec2 [] get_coord() {
    return iVec3_coord_to_iVec2_coord(coord) ;
  }

  public iVec2 [] get_coord_block_1() {
    return iVec3_coord_to_iVec2_coord(coord_block_1) ;
  }

  public iVec2 [] get_coord_block_2() {
    return iVec3_coord_to_iVec2_coord(coord_block_2) ;
  }

  public iVec2 [] get_coord_block_3() {
    return iVec3_coord_to_iVec2_coord(coord_block_3) ;
  }

  public iVec2 [] get_coord_block_4() {
    return iVec3_coord_to_iVec2_coord(coord_block_4) ;
  }

  private iVec2 [] iVec3_coord_to_iVec2_coord(iVec3 [] target) {
    if(target != null) {
      iVec2 [] list = new iVec2[target.length];
      for(int i = 0 ; i < list.length ; i++) {
        list[i] = iVec2(target[i].x,target[i].y);
      }
      return list;
    } else return null;
  }

  public void reset() {
    pg = createGraphics(width,height);
  }


  public PGraphics get_mask() {
    return pg;
  }

  

  public void set_fill(int c) {
    this.c = c;
  }



  public void draw(boolean modify_is) {
    if(pg == null) {
      pg = createGraphics(width,height);
    }

    if(pg != null && init) {
      pg.beginDraw();
      if(modify_is) {
        if(pg != null) {      
          pg.fill(RED);
          pg.noStroke();
        }
      } else {
        if(pg != null) {
          pg.fill(c);
          pg.noStroke();    
        }
      }
      pg.endDraw();

      if(block_is) {
        if(pg != null) draw_shape(pg, coord, coord_block_1, coord_block_2, coord_block_3, coord_block_4);
        if(modify_is) {
          show_point(pg,coord);
          move_point(coord);

          if(coord_block_1 != null) {
            show_point(pg,coord_block_1);
            move_point(coord_block_1);
          }
          if(coord_block_2 != null) {
            show_point(pg,coord_block_2);
            move_point(coord_block_2);
          }
          if(coord_block_3 != null) {
            show_point(pg,coord_block_3);
            move_point(coord_block_3);
          }
          if(coord_block_4 != null) {
            show_point(pg,coord_block_4);
            move_point(coord_block_4);
          }
        }
      } else {
        if(pg != null) draw_shape(pg,coord);
        if(modify_is) {
          show_point(pg,coord);
          move_point(coord);
        }
      }
      
    } else {
      println(pg,init);
      printErr("class Masking.draw(): Must be iniatilized with an array list iVec2 [] coord)");
    }
  }

  private void show_point(PGraphics pg,iVec3 [] list) {
    for(iVec3 iv : list) {
      pg.beginDraw();
      pg.stroke(WHITE);
      pg.strokeWeight(range);
      pg.point(iv.x,iv.y);
      pg.endDraw();
    }
  }

  private boolean drag_is = false ;
  private void move_point(iVec3 [] list) {
    if(!drag_is) {
      for(iVec3 iv : list) {
        iVec2 drag = iVec2(mouseX,mouseY);
        iVec2 area = iVec2(range);
        if(inside(drag,area,iVec2(iv.x,iv.y)) && iv.z == 0) {
          if(mousePressed) {
            iv.set(iv.x,iv.y,1);
            drag_is = true ;
          } else {
            // border magnetism
            if(iv.x < 0 + range) iv.x = 0 ;
            if(iv.x > width -range) iv.x = width;
            if(iv.y < 0 + range) iv.y = 0 ;
            if(iv.y > height -range) iv.y = height;
          }
        }
      }
    }
    
    for(iVec3 iv : list) {
      if(iv.z == 1) iv.set(mouseX,mouseY,1);
    }

    if(!mousePressed) {
      drag_is = false;
      for(iVec3 iv : list) {
        iv.set(iv.x,iv.y,0);
      }
    }
  }

  private void draw_shape(PGraphics pg, iVec3 [] list) {
    pg.beginDraw();
    //
    pg.beginShape();
    for(int i = 0 ; i < list.length ; i++) {
      pg.vertex(list[i].x,list[i].y);
    }
    pg.endShape(CLOSE);
    //
    pg.endDraw();
  }

  private void draw_shape(PGraphics pg, iVec3 [] list, iVec3 [] list_b_1, iVec3 [] list_b_2, iVec3 [] list_b_3, iVec3 [] list_b_4) {
    pg.beginDraw();
    // block 1
    pg.beginShape();
    pg.vertex(list[0].x,list[0].y);
    pg.vertex(list[1].x,list[1].y);
    pg.vertex(list[5].x,list[5].y);
    if(list_b_1 != null) {
      for(int i = 0 ; i < list_b_1.length ; i++) {
        pg.vertex(list_b_1[i].x,list_b_1[i].y);
      }
    }
    pg.vertex(list[4].x,list[4].y);
    pg.endShape(CLOSE);

    // block 2
    pg.beginShape();
    pg.vertex(list[1].x,list[1].y);
    pg.vertex(list[2].x,list[2].y);
    pg.vertex(list[6].x,list[6].y);
    if(list_b_2 != null) {
      for(int i = 0 ; i < list_b_2.length ; i++) {
        pg.vertex(list_b_2[i].x,list_b_2[i].y);
      }
    }
    pg.vertex(list[5].x,list[5].y);
    pg.endShape(CLOSE);

    // block 3
    pg.beginShape();
    pg.vertex(list[2].x,list[2].y);
    pg.vertex(list[3].x,list[3].y);
    pg.vertex(list[7].x,list[7].y);
    if(list_b_3 != null) {
      for(int i = 0 ; i < list_b_3.length ; i++) {
        pg.vertex(list_b_3[i].x,list_b_3[i].y);
      }
    }
    pg.vertex(list[6].x,list[6].y);
    pg.endShape(CLOSE);

    // block 4
    pg.beginShape();
    pg.vertex(list[3].x,list[3].y);
    pg.vertex(list[0].x,list[0].y);
    pg.vertex(list[4].x,list[4].y);
    if(list_b_4 != null) {
      for(int i = 0 ; i < list_b_4.length ; i++) {
        pg.vertex(list_b_4[i].x,list_b_4[i].y);
      }
    }
    pg.vertex(list[7].x,list[7].y);
    pg.endShape(CLOSE);
    //
    pg.endDraw();
  }
}







