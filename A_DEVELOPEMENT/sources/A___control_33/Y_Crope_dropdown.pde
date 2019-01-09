/**
DROPDOWN 
v 0.1.4
2018-2019
*/
/**
method to know is dropdown is active or not
Add dropdown must use when the dropdown is build.
*/

boolean dropdown_is() {
  boolean locked = false ;
  for(Crope crope : get_crope()) {
    if(crope != null) {
      if(crope instanceof Dropdown) {
        Dropdown dd = (Dropdown) crope;
        if(dd.locked_is()) {
          locked = true;
          break;
        }
      }
    }   
  } 
  return locked;
}


/**
DROPDOWN class
v 2.6.0
2014-2018
*/
public class Dropdown extends Crope {
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
  private boolean slider;
  // private boolean inside_box;
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

  private boolean wheel_is = false;

  /**
  CONSTRUCTOR
  */
  public Dropdown(iVec2 pos, iVec2 size, String name, String [] content) {
    super("Dropdown");
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


  public Dropdown set_header_text_pos(iVec2 pos) {
    set_header_text_pos(pos.x, pos.y);
    return this;
  }

  public Dropdown set_header_text_pos(int x, int y) {
    if(pos_header_text == null) {
      this.pos_header_text = iVec2(x,y);
    } else {
      this.pos_header_text.set(x,y);
    }
    return this;
  }


  public Dropdown set_box_text_pos(iVec2 pos) {
    set_box_text_pos(pos.x, pos.y);
    return this;
  }

  public Dropdown set_box_text_pos(int x, int y) {
    if(pos_box_text == null) {
      this.pos_box_text = iVec2(x,y);
    } else {
      this.pos_box_text.set(x,y);
    }
    return this;
  }



  public Dropdown set_colour(ROPE_colour rc) {
    this.colour_structure = rc.get_colour()[0];

    this.colour_header_in = rc.get_colour()[1];
    this.colour_header_out = rc.get_colour()[2];

    this.colour_header_text_in = rc.get_colour()[3];
    this.colour_header_text_out = rc.get_colour()[4];

    this.colour_box_in = rc.get_colour()[5];
    this.colour_box_out = rc.get_colour()[6]; 

    this.colour_box_text_in = rc.get_colour()[7];
    this.colour_box_text_out = rc.get_colour()[8];
    return this;
  }




  /**
  method
  */
  public void wheel(boolean wheel_is) {
    this.wheel_is = wheel_is;
  }

  public Dropdown set_box(int num_box) {
    set_box(num_box, this.box_starting_rank_position);
    return this;
  }

  public Dropdown set_box(int num_box, int rank) {
    this.num_box = num_box;
    this.box_starting_rank_position = rank;
    if(content != null && num_box != content.length) {
      set_num_box_rendering(true);
    }
    return this;
  }

  public Dropdown set_box_rank(int rank) {
    this.box_starting_rank_position = rank;
    return this;
  }

  public Dropdown set_box_height(int h) {
    this.height_box = h;
    if(size_box == null) {
      size_box = iVec2(longest_String_pixel(font_box,this.content), this.height_box);
    } else {
      size_box.set(iVec2(longest_String_pixel(font_box,this.content), this.height_box));
    }
    return this;
  }

  public Dropdown set_box_width(int w) {
    size_box.set(w,size_box.y);
    return this;
  }



  public Dropdown set_box_font(String font_name, int size) {
    this.font_box = createFont(font_name,size);
    return this;
  }
  
  public Dropdown set_box_font(PFont font) {
    this.font_box = font;
    return this;
  }

  // content
  public Dropdown set_content(String [] content) {
    boolean new_slider = false ;
    if(this.content == null || this.content.length != content.length) {
      new_slider = true ;
    }
   
    this.content = content;
    set_num_box_rendering(new_slider);
    return this;
  }


  public Dropdown set_name(String name) {
    this.name = name;
    return this;
  }


  private Dropdown set_num_box_rendering(boolean new_slider_is) {
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
    return this;
  }


  private void update_slider() {
    iVec2 size_slider = iVec2(round(height_box *.5), round((end *height_box) -pos.z));
    int x = pos.x -size_slider.x;
    int y = pos.y +(height_box *box_starting_rank_position);
    iVec2 pos_slider = iVec2(x,y);
  
    float ratio = float(content.length) / float(end -1);
    
    iVec2 size_molette =  iVec2(size_slider.x, round(size_slider.y /ratio));
    
    boolean keep_pos_mol_is = false;
    int index = 0 ; // so catch the first molette of the index ;
    int pos_mol_y = 0;
    if(slider_dd != null) {
      pos_mol_y = slider_dd.get_molette_pos(index).y;
      keep_pos_mol_is = true ;
    }

    if(slider_dd == null) {
      slider_dd = new Slider("Slider Dropdown",pos_slider, size_slider);
    } else {
      slider_dd.pos(pos_slider);
      slider_dd.size(size_slider);
      slider_dd.set_pos_molette();
    }
    slider_dd.size_molette(size_molette);
    if(keep_pos_mol_is) {
      int pos_mol_x = slider_dd.get_molette_pos(index).x;
      slider_dd.set_pos_molette(index,pos_mol_x,pos_mol_y);
    }
    slider_dd.set_molette(RECT);
    slider_dd.set_fill(colour_structure);
    slider_dd.set_fill_molette(colour_box_in,colour_box_out);
    slider_dd.wheel(wheel_is);
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

  public void update(int x,int y) {
    cursor(x,y);
    selected_type = mousePressed;
    open_dropdown(); 
  }



  private void open_dropdown() {
    boolean inside = inside(get_pos(), get_size(),cursor,RECT);
    if (inside) {
      if(selected_type) {
        locked = true;
      }
    } else if(!inside && selected_type && slider_dd == null) {
      locked = false;
    } else if(!inside && selected_type && slider_dd != null && !slider_dd.inside_slider()) {
      locked = false;
    }
    if(locked) {
      int result_line = get_select_line();
      if (result_line > -1) {
        line = result_line; 
      }
    }
  }


  private int get_select_line() {
    int content_size_y = ((content.length+1) *size.y) +pos.y;
    // very quick bug fix, for the case there is only two item in thelist
    if(content.length == 2) {
      content_size_y = ((content.length+2) *size.y) +pos.y;
    }
    if(cursor.x >= pos.x 
      && cursor.x <= pos.x +size_box.x 
      && cursor.y >= pos.y && cursor.y <= content_size_y) {
      //choice the line
      int line = floor((cursor.y - (pos.y +size.y)) / size.y ) +offset_slider;
      line -= (box_starting_rank_position -1);
      return line;
    } else {
      return -1; 
    }
  }




  /**
  SHOW
  */
  public void show() {
    show_header();
    show_header_text();
    show_box();
  }

  private void show_selection(int x,int y) {
    if (inside(pos,size,cursor,RECT)) {
      fill(colour_header_text_in); 
    } else {
      fill(colour_header_text_out);
    }
    textFont(font);
    if(get_content().length > 0) {
      text(get_content()[get_selection()], x, y);
    } else {
      text("empty",x,y);
    }
    
  }
  
  public void show_header() {
    noStroke();
    if (inside(pos,size,cursor,RECT)) {
      fill(colour_header_in); 
    } else {
      fill(colour_header_out);
    }
    rect(get_pos(),get_size());
  }

  public void show_header_text(String name) {
    if (inside(pos,size,cursor,RECT)) {
      fill(colour_header_text_in); 
    } else {
      fill(colour_header_text_out);
    }
    textFont(font);
    text(name, pos.x +pos_header_text.x, pos.y +pos_header_text.y);
  }

  public void show_header_text() {
    show_header_text(this.name);
  }


  public void show_box() {
    if(locked) {
      int step = box_starting_rank_position;
      int index = 0; // first pos molette from the array pos molette
      //give the position in list of Item with the position from the slider's molette
      if (slider) {
        offset_slider = round(map(slider_dd.get(index),0,1,0,missing));
      }
      set_box_width(longest_String_pixel(font_box,this.content));
      for (int i = start +offset_slider ; i < end +offset_slider ; i++) {
        
        if(i < 0) {
          i = 0 ;
        }

        if(i >= content.length) {
          i = content.length -1;
        }
        
        float pos_temp_y = pos.y + (size_box.y *step);
        iVec2 temp_pos = iVec2(pos.x, (int)pos_temp_y);
        boolean inside = inside(temp_pos,size_box,cursor,RECT);
        render_box(temp_pos,content[i],step,inside);
        step++;


        if (slider) {
          int x = pos.x -slider_dd.get_size().x;
          int y = pos.y +(height_box *box_starting_rank_position);
          slider_dd.pos(x,y);
          //slider_dd.select(false);
          slider_dd.update(cursor);
          slider_dd.show_structure();
          slider_dd.show_molette();
        }
      }
    }
  }

  private void render_box(iVec2 pos, String content, int step, boolean inside) {
    // box part
    noStroke() ;  
    if (inside) {
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
    rect(pos,size_box); 
    // text part
    if (inside(pos,size_box,cursor,RECT)) {
      fill(colour_box_text_in); 
    } else {
      fill(colour_box_text_out);
    }
    textFont(font_box);
    int x = pos.x +pos_box_text.x;
    int y = pos.y +height_box -(ceil(height_box*.2));
    text(content,x,y);
  }





  
  
  /**
  GET
  */
  //return which line of dropdown is selected
  int current_line ;
  public int get_selection() {
    float size_temp_y = size_box.y *num_box;
    iVec2 temp_size = iVec2(size_box.x, (int)size_temp_y);
    iVec2 temp_pos = pos.copy();
    temp_pos.y += (box_starting_rank_position *height_box);
    boolean inside_open_box = inside(temp_pos,temp_size,cursor,RECT);
    if(!inside_open_box) {
      line = current_line;
    }
    if(!locked && inside_open_box) {
      if(line >= 0 && line < content.length) {
        current_line = line ;     
      } else {
        printErr("class Dropdown - method get_selected()\nthe line", line, "don't match with any content, the method keep the last content");
      }
    } 
    return current_line;
  }


  //return which line of dropdown is highlighted
  public int get_highlight() {
    return line ;
  }

  public String get_name() {
    return this.name;
  }


  public String [] get_content() {
    return content;
  }

  public int get_num_box() {
    return num_box;
  }

  public PFont get_font_box() {
    return font_box;
  }

  public iVec2 get_header_text_pos() {
    return pos_header_text;
  }

  public iVec2 get_content_text_pos() {
    return pos_box_text;
  }

  public boolean locked_is() {
    return locked;
  }
}

