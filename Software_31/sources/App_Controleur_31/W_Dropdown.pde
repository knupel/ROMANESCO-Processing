/**
CROPE
CONTROL ROMANESCO PROCESSING ENVIRONMENT
*
DROPDOWN
v 1.3.0
2014-2018
*/
boolean dropdownOpen ; // use to indicate to indicate at the other button, they cannot be used when the user are on the dropdown menu
/**
CLASS
*/
public class Dropdown {
  //Slider dropdown
  private Slider slider_dd;
  private iVec2 size_box;
  // font
  private PFont font_header,font_box;
  //dropdown
  private int line = 0;
  private String content[];
  private String name;

  private boolean locked, slider ;
  // color
  private int color_header_in, color_header_out, color_main;
  private int color_box_text ; 
  private int color_box_in, color_box_out;

  private iVec2 pos; 
  private iVec2 size;
  private iVec2 pos_text;
  private int pos_ref_x, pos_ref_y ;
  private iVec2 change_pos;
  private float factorPos; // use to calculate the margin between the box
  // box
  private int height_box;
  private int num_box;

  private int start = 0 ;
  private int end = 1 ;
  private int offset = 0 ; //for the slider update
  private float missing ;

  /**
  CONSTRUCTOR
  */
  public Dropdown(String name, String [] content, iVec2 pos, iVec2 size, iVec2 pos_text, ROPE_color rc, int num_box, int height_box) {
    this.font_header = createFont("defaultFont",10);
    this.font_box = createFont("defaultFont",10);
    this.name = name; 
    this.pos = pos.copy();
    pos_ref_x = pos.x;
    pos_ref_y = pos.y;
    
    this.pos_text = pos_text.copy();

    this.size = size.copy(); // header size
    
    this.color_main = rc.get_color()[0];
    this.color_box_in = rc.get_color()[1];
    this.color_box_out = rc.get_color()[2];
    this.color_header_in = rc.get_color()[3];
    this.color_header_out = rc.get_color()[4];  
    this.color_box_text = rc.get_color()[5];
    
    set_box(num_box, height_box);
    set_content(content);
  }




  /**
  method
  */
  public void set_box(int num_box, int height_box) {
    this.height_box = height_box;
    this.num_box = num_box;
    size_box = iVec2(longest_String_pixel(font_box,this.content), height_box);
  }

  public void set_box_width(int w) {
    size_box.set(w,size_box.y);

  }

  public void set_font_header(String font_name, int size) {
    this.font_header = createFont(font_name,size);
  }

  public void set_font_box(String font_name, int size) {
    this.font_box = createFont(font_name,size);
  }

  public void set_font_header(PFont font) {
    this.font_header = font;
  }

  public void set_font_box(PFont font) {
    this.font_box = font;
  }

  // content
  public void set_content(String [] content) {
    boolean new_slider = false ;
    if(this.content == null || this.content.length != content.length) new_slider = true ;
    this.content = content;
    end = num_box;
    if (content != null) {
      if (end > content.length) {
        end = content.length;
      }
      missing = content.length -end;
    }

    //condition to display the slider
    if (content.length > end) {
      slider = true; 
    } else {
      slider = false;
    }
    
    if (slider && (slider_dd == null || new_slider)) {
      update_slider();
    }

  }

  private void update_slider() {
    iVec2 size_slider = iVec2(round(height_box *.5), round((end *height_box) -pos.z));
    int x = pos.x -size_slider.x;
    int y = pos.y +height_box;
    iVec2 pos_slider = iVec2(x,y);
  
    float ratio = float(content.length) / float(end -1);
    
    iVec2 size_molette =  iVec2(size_slider.x, round(size_slider.y /ratio));

    slider_dd = new Slider(pos_slider, size_slider, size_molette, "RECT");
    slider_dd.set_molette_fill(this.color_box_in,this.color_box_out);
  }



  public void change_pos(int x, int y) {
    pos.set(pos_ref_x, pos_ref_y);
    iVec2 temp = iVec2(x,y);
    pos.add(temp);
  }


  public void update() {
    rectMode(CORNER);
    if (locked) {
      dropdownOpen = true ;
      //give the position of dropdown
      int step = 2 ;
      //give the position in list of Item with the position from the slider's molette
      if (slider) offset = round(map(slider_dd.get_value(),0,1,0,missing));
      set_box_width(longest_String_pixel(font_box,this.content));

      for (int i = start +offset ; i < end +offset ; i++) {
        render_box(content[i], step++, size_box, color_box_text);
        if (slider) {
          int x = pos.x -slider_dd.get_size().x;
          int y = pos.y +height_box;
          slider_dd.set_pos(x,y);
          slider_dd.inside_molette_rect();
          slider_dd.select_molette();
          slider_dd.update_molette();
          slider_dd.show();
          //slider_dd.show(color_main,color_main,0);
          /**
          the color must be set in other place, that's not pertinent to set color in this method
          */
          slider_dd.show_molette();
          // slider_dd.show_molette(jaune, orange, jaune, orange, 0) ;
        }
      }
    } else {
      //header rendering
      dropdownOpen = false ;
    }
    title_without_box(name, 1, size, font_header);
  }





  //DISPLAY
  private void title_without_box(String name, int step, iVec2 size, PFont font) {
    //update
    factorPos = step + pos.z -1 ;
    float yLevel = step == 1 ? pos.y  : (pos.y + (size.y *(factorPos )));
    iVec2 newPosDropdown = iVec2(pos.x, round(yLevel));
    if (inside(newPosDropdown,size,iVec2(mouseX,mouseY),RECT)) {
      fill(color_header_in); 
    } else {
      fill(color_header_out);
    }
    textFont(font);
    text(name, pos.x +pos_text.x, yLevel +pos_text.y);
  }
  
  private void render_box(String label, int step, iVec2 size_box, int textColor) {
    //update
    factorPos = step + pos.z -1 ;
    float yLevel = step == 1 ? pos.y  : (pos.y + (size_box.y *(factorPos)));
    iVec2 newPosDropdown = iVec2(pos.x, round(yLevel));
    if (inside(newPosDropdown,size_box,iVec2(mouseX,mouseY),RECT)) {
      fill(color_box_in); 
    } else {
      fill(color_box_out);
    }
    //display
    noStroke() ;
    if (inside(newPosDropdown,size,iVec2(mouseX,mouseY),RECT)) {
      fill(color_box_in); 
    } else {
      fill(color_box_out);
    }
    int sizeWidthMin = 60 ;
    int sizeWidthMax = 300 ;
    if (size_box.x < sizeWidthMin ) {
      size_box.x = sizeWidthMin ; 
    } else if(size_box.x > sizeWidthMax ) {
      size_box.x = sizeWidthMax ;
    }
    rect(pos.x, yLevel, size_box.x, size_box.y);
    fill(textColor);
    textFont(font_box);
    text(label, pos.x +pos_text.x, yLevel +height_box -(ceil(height_box*.2)));
  }
  
  

  //Check the dropdown when this one is open
  public int selectDropdownLine(float newWidth) {
    if(mouseX >= pos.x && mouseX <= pos.x +newWidth && mouseY >= pos.y && mouseY <= ((content.length+1) *size.y) +pos.y) {
      //choice the line
      int line = floor( (mouseY - (pos.y +size.y)) / size.y ) +offset;
      return line;
    } else {
      return -1; 
    }
  }
  //return which line is selected
  public void whichDropdownLine(int l ) {
    line = l ;
  }
  //return which line of dropdown is selected
  public int get_content_line() {
    return line ;
  }

  public String [] get_content() {
    return content;
  }

  public iVec2 get_pos() {
    return pos;
  }

  public iVec2 get_size() {
    return size;
  }

  public int get_num_box() {
    return num_box;
  }

  public String get_name() {
    return name;
  }

  PFont get_font_header() {
    return font_header;
  }

  PFont get_font_box() {
    return font_box;
  }
}
