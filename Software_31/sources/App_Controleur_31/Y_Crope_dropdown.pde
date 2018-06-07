/**
DROPDOWN
v 2.2.1
2014-2018
*/
boolean dropdownOpen ; // use to indicate to indicate at the other button, they cannot be used when the user are on the dropdown menu

public class Dropdown extends Crope {
  protected boolean select_is;
  protected boolean selected_type;
  //Slider dropdown
  private Slider slider_dd;
  private iVec2 size_box;
  // font
  private PFont font_box;
  //dropdown
  private int line = 0;
  private String content[];

  private boolean locked;
  private boolean slider, inside_slider_is;
  // color
  private int colour_structure = r.GRAY_2;

  private int colour_box_in = r.GRAY_6;
  private int colour_box_out = r.GRAY_9;

  private int colour_header_in = r.GRAY_6;
  private int colour_header_out = r.GRAY_9; 

  private int colour_header_text_in = r.GRAY_2;
  private int colour_header_text_out = r.GRAY_4;

  private int colour_box_text_in = r.GRAY_2;
  private int colour_box_text_out = r.GRAY_4;


  private iVec2 pos_header_text;
  private iVec2 pos_box_text;

  private int pos_ref_x, pos_ref_y ;
  private iVec2 change_pos;
  // private float factorPos; // use to calculate the margin between the box
  // box
  private int height_box;
  private int num_box;



  private int start = 0 ;
  private int end = 1 ;
  private int offset_slider = 0 ; //for the slider update
  private float missing ;

  private int box_starting_rank_position = 1;

  /**
  CONSTRUCTOR
  */
  public Dropdown(iVec2 pos, iVec2 size, String name, String [] content) {
    int size_header_text = int(size.y *.6);
    this.font = createFont("defaultFont",size_header_text);
    int size_content_text = int(size.y *.6);
    this.font_box = createFont("defaultFont",size_content_text);
    this.name = name; 
    this.pos = pos.copy();
    pos_ref_x = pos.x;
    pos_ref_y = pos.y;
    this.size = size.copy(); // header size

    
    set_box(content.length);
    set_content(content);
    set_box_height(size.y);
    
    int offset_text_x = 2 ;
    int offset_text_header_y = (size.y - size_header_text)/2;
    set_header_text_pos(offset_text_x,size.y -offset_text_header_y);
    int offset_text_content_y = (size_box.y - size_content_text)/2;
    set_box_text_pos(offset_text_x,size_box.y - offset_text_content_y); 
    selected_type = mousePressed;
  }


  public void set_header_text_pos(iVec2 pos) {
    set_header_text_pos(pos.x, pos.y);
  }

  public void set_header_text_pos(int x, int y) {
    if(pos_header_text == null) {
      this.pos_header_text = iVec2(x,y);
    } else {
      this.pos_header_text.set(x,y);
    } 
  }


  public void set_box_text_pos(iVec2 pos) {
    set_box_text_pos(pos.x, pos.y);
  }

  public void set_box_text_pos(int x, int y) {
    if(pos_box_text == null) {
      this.pos_box_text = iVec2(x,y);
    } else {
      this.pos_box_text.set(x,y);
    } 
  }



  public void set_colour(ROPE_colour rc) {
    this.colour_structure = rc.get_colour()[0];

    this.colour_header_in = rc.get_colour()[1];
    this.colour_header_out = rc.get_colour()[2];

    this.colour_header_text_in = rc.get_colour()[3];
    this.colour_header_text_out = rc.get_colour()[4];

    this.colour_box_in = rc.get_colour()[5];
    this.colour_box_out = rc.get_colour()[6]; 

    this.colour_box_text_in = rc.get_colour()[7];
    this.colour_box_text_out = rc.get_colour()[8];
  }




  /**
  method
  */
  public void set_box(int num_box) {
    set_box(num_box, this.box_starting_rank_position);
  }

  public void set_box(int num_box, int rank) {
    this.num_box = num_box;
    this.box_starting_rank_position = rank;
    if(content != null && num_box != content.length) {
      set_num_box_rendering(true);
    }
  }

  public void set_box_height(int h) {
    this.height_box = h;
    if(size_box == null) {
      size_box = iVec2(longest_String_pixel(font_box,this.content), this.height_box);
    } else {
      size_box.set(iVec2(longest_String_pixel(font_box,this.content), this.height_box));
    }
  }

  public void set_box_width(int w) {
    size_box.set(w,size_box.y);
  }



  public void set_box_font(String font_name, int size) {
    this.font_box = createFont(font_name,size);
  }
  
  public void set_box_font(PFont font) {
    this.font_box = font;
  }

  // content
  public void set_content(String [] content) {
    boolean new_slider = false ;
    if(this.content == null || this.content.length != content.length) {
      new_slider = true ;
    }
   
    this.content = content;
    set_num_box_rendering(new_slider);
  }


  private void set_num_box_rendering(boolean new_slider_is) {
    end = num_box;
    if (content != null) {
      if (end > content.length) {
        end = content.length;
      }
      missing = content.length -end;
      if (content.length > end) {
        slider = true; 
      } else {
        slider = false;
      }
    }

    if (slider && (slider_dd == null || new_slider_is)) {
      update_slider();
    }
  }


  private void update_slider() {
    iVec2 size_slider = iVec2(round(height_box *.5), round((end *height_box) -pos.z));
    int x = pos.x -size_slider.x;
    int y = pos.y +(height_box *box_starting_rank_position);
    iVec2 pos_slider = iVec2(x,y);
  
    float ratio = float(content.length) / float(end -1);
    
    iVec2 size_molette =  iVec2(size_slider.x, round(size_slider.y /ratio));
    
    boolean keep_pos_mol_is = false;
    int pos_mol_y = 0;
    if(slider_dd != null) {
      pos_mol_y = slider_dd.get_molette_pos().y;
      keep_pos_mol_is = true ;
    }

    slider_dd = new Slider(pos_slider, size_slider);
    slider_dd.set_molette_size(size_molette);
    if(keep_pos_mol_is) {
      int pos_mol_x = slider_dd.get_molette_pos().x;
      slider_dd.set_molette_pos(pos_mol_x,pos_mol_y);
    }
    slider_dd.set_molette(RECT);
    slider_dd.set_fill(colour_structure);
    slider_dd.set_molette_fill(colour_box_in,colour_box_out);
  }

  public void offset(int x, int y) {
    pos.set(pos_ref_x, pos_ref_y);
    iVec2 temp = iVec2(x,y);
    pos.add(temp);
    update_slider();
  }

  public void offset(iVec2 offset) {
    offset(offset.x, offset.y);
  }

  public void update() {
    if(!select_is) {
      selected_type = mousePressed;
    }
    open_dropdown(); 

    if(!locked) {
      dropdownOpen = false ;
    }
  }





  public void select(boolean authorization) {
    select_is = true;
    selected_type = mousePressed;
  }

  public void select(boolean authorization_1, boolean authorization_2) {
    select_is = true;
    selected_type = authorization_1;
  }


  private void open_dropdown() {
    boolean inside = inside(get_pos(), get_size(),iVec2(mouseX,mouseY),RECT);
    if (inside) {
      if(selected_type) {
        locked = true;
      }
    } else if(!inside && selected_type && !inside_slider_is) {
      locked = false;
    }  

    if(locked) {
      int line = get_select_line();
      if (line > -1 ) {
        which_line(line);   
      } 
    }
  }

  private void which_line(int l) {
    line = l ;
  }




  /**
  SHOW
  */
  public void show() {
    show_header();
    show_header_text();
    show_box();
    // show_box_text();
  }

  private void show_selection(int x,int y) {
    textFont(font);
    text(get_content()[get_selected()], x, y) ;
  }
  
   private void show_header() {
    noStroke();
    if (inside(pos,size,iVec2(mouseX,mouseY),RECT)) {
      fill(colour_header_in); 
    } else {
      fill(colour_header_out);
    }
    rect(get_pos(),get_size());
   }


  private void show_header_text() {
    if (inside(pos,size,iVec2(mouseX,mouseY),RECT)) {
      fill(colour_header_text_in); 
    } else {
      fill(colour_header_text_out);
    }
    textFont(font);
    text(name, pos.x +pos_header_text.x, pos.y +pos_header_text.y);
  }

  
  private void show_box() {
    if(locked) {
      dropdownOpen = true ;
      int step = box_starting_rank_position;
      //give the position in list of Item with the position from the slider's molette
      if (slider) {
        offset_slider = round(map(slider_dd.get_value(),0,1,0,missing));
      }
      set_box_width(longest_String_pixel(font_box,this.content));
      for (int i = start +offset_slider ; i < end +offset_slider ; i++) {
        render_box(content[i], step++);
        if (slider) {
          int x = pos.x -slider_dd.get_size().x;
          int y = pos.y +(height_box *box_starting_rank_position);
          slider_dd.set_pos(x,y);
          inside_slider_is = slider_dd.inside_molette_rect();
          slider_dd.select(true);
          slider_dd.update();
          slider_dd.show_structure();
          slider_dd.show_molette();
        }
      }
    }
  }


  private void render_box(String content, int step) {
    float pos_temp_y = pos.y + (size_box.y *step);
    iVec2 temp_pos = iVec2(pos.x, (int)pos_temp_y);
    //display
    // box part
    noStroke() ;
    if (inside(temp_pos,size_box,iVec2(mouseX,mouseY),RECT)) {
      fill(colour_box_in); 
    } else {
      fill(colour_box_out);
    }
    int min = 60 ;
    int max = 300 ;
    if (size_box.x < min ) {
      size_box.x = min; 
    } else if(size_box.x > max ) {
      size_box.x = max;
    }
    rect(temp_pos, size_box);
    
    // text part
    if (inside(temp_pos,size_box,iVec2(mouseX,mouseY),RECT)) {
      fill(colour_box_text_in); 
    } else {
      fill(colour_box_text_out);
    }
    textFont(font_box);
    int x = temp_pos.x +pos_box_text.x;
    int y = temp_pos.y +height_box -(ceil(height_box*.2));
    text(content,x,y);
  }





  
  
  /**
  GET
  */
  //Check the dropdown when this one is open
  public int get_select_line() {
    if(mouseX >= pos.x && mouseX <= pos.x +size_box.x && mouseY >= pos.y && mouseY <= ((content.length+1) *size.y) +pos.y) {
      //choice the line
      int line = floor((mouseY - (pos.y +size.y)) / size.y ) +offset_slider;
      line -= (box_starting_rank_position -1);
      return line;
    } else {
      return -1; 
    }
  }


  //return which line of dropdown is highlighted
  public int get_highlighted() {
    return line ;
  }

  //return which line of dropdown is selected
  int current_line ;
  public int get_selected() {
    if(!locked) {
      if(line >= 0 && line < content.length) {
        current_line = line ;
      } else {
        printErr("class Dropdown - method get_selected()\nthe line", line, "don't match with any content, the method keep the last content");
      }
    }
    return current_line;
  }

  public String [] get_content() {
    return content;
  }

  public int get_num_box() {
    return num_box;
  }

  PFont get_font_box() {
    return font_box;
  }

  iVec2 get_header_text_pos() {
    return pos_header_text;
  }

  iVec2 get_content_text_pos() {
    return pos_box_text;
  }
}

