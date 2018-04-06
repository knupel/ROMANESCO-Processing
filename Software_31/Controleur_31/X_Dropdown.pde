/**
DROPDOWN 
v 1.1.0
ROMANESCO PROCESSIN ENVIRONMENT
*/
boolean dropdownOpen ; // use to indicate to indicate at the other button, they cannot be used when the user are on the dropdown menu
// CLASS
public class Dropdown {
  //Slider dropdown
  Slider sliderDropdown ;
  // private PFont fontDropdown ;
  private Vec2 posSliderDropdown, sizeSliderDropdown;
  private Vec2 sizeMoletteDropdown;
  private Vec2 sizeBoxDropdownMenu; 
  private Vec2 posMoletteDropdown; 
  //dropdown
  private int line = 0;
  private String listItem[] , title ;
  private boolean locked, slider ;
  private final color colorTitleIn, colorTitleOut, colorBG, colorTextBox ; 
  private final color boxIn, boxOut ;
  private Vec3 pos, size;
  private PVector posText;
  int pos_ref_x, pos_ref_y ;
  private Vec2 change_pos = Vec2() ;
  private float factorPos  ; // use to calculate the margin between the box
  int sizeBox ;
  private int startingDropdown = 0 ;
  private int endingDropdown = 1 ;
  private int updateDropdown = 0 ; //for the slider update
  private float missing ;

  //CONSTRUCTOR
  public Dropdown(String title, String [] listItem, Vec3 pos, Vec3 size, PVector posText, color colorBG, color colorTitleIn, color colorTitleOut, color boxIn, color boxOut, color colorTextBox, int sizeBox ) {
    //dropdown
    this.title = title ;
    this.listItem = listItem;
    this.pos = pos;
    pos_ref_x = (int)pos.x ;
    pos_ref_y = (int)pos.y ;
    
    this.posText = posText ;

    this.size = size; // header size
    this.sizeBox = sizeBox ;
    this.colorTitleIn = colorTitleIn ;
    this.colorTitleOut = colorTitleOut ;
    this.colorTextBox = colorTextBox ;
    this.colorBG = colorBG ;
    this.boxIn = boxIn ;
    this.boxOut = boxOut ;
    endingDropdown = int(size.z + 1) ;
    // security if the size of dropdown is superior of the item list
    if (endingDropdown > listItem.length ) endingDropdown = listItem.length ;
    // difference between the total list item and what is possible to display
    missing = listItem.length - endingDropdown  ;
   
    //size of the dropdow, for the item part
    float ratio = .95 ;
    int size_text = 10 ;
    sizeBoxDropdownMenu = Vec2(longest_word_in_pixel(listItem, size_text) *ratio, sizeBox) ;
     
    //slider dropdown
    //condition to display the slider
    if (listItem.length > endingDropdown) slider = true ; else slider = false ;
    
    if (slider) {
      sizeSliderDropdown = Vec2(sizeBox *.5, ((endingDropdown ) *sizeBox ) -pos.z);
      posSliderDropdown = Vec2(pos.x -sizeSliderDropdown.x -(pos.z *2.0), pos.y +sizeBox +(1.8 *pos.z));
      

      float factorSizeMolette = float(listItem.length) / float(endingDropdown -1 ) ;
      
      sizeMoletteDropdown =  Vec2(sizeSliderDropdown.x, sizeSliderDropdown.y /factorSizeMolette) ;
      
      posMoletteDropdown = Vec2();
      sliderDropdown = new Slider(posSliderDropdown, posMoletteDropdown, sizeSliderDropdown, sizeMoletteDropdown, "RECT") ;
      sliderDropdown.setting() ;
    }
  }


  
  //DRAW
  void change_pos(int x, int y) {
    pos.set(pos_ref_x, pos_ref_y,0);
    Vec3 temp = Vec3(x,y,0);
    pos.add(temp);
  }


  void dropdownUpdate(PFont titleFont, PFont dropdown_font) {
    //to be sure of the position
    rectMode(CORNER);
    //Dropdown
    if (locked) {
      dropdownOpen = true ;
      title_without_box(title, 1, size, titleFont);
      //give the position of dropdown
      int step = 2 ;
      //give the position in list of Item with the position from the slider's molette
      if (slider) updateDropdown = round(map (sliderDropdown.getValue(), 0,1, 0, missing)) ;
      //loop to display the item list
      for ( int i = startingDropdown +updateDropdown ; i < endingDropdown +updateDropdown ; i++) {
        //bottom rendering

        render_box(listItem[i], step++, sizeBoxDropdownMenu, dropdown_font, colorTextBox);
        //Slider dropdown
        if (slider) {
          sliderDropdown.pos.set(pos.x -sizeSliderDropdown.x -(pos.z *2.0), pos.y +sizeBox +(1.8 *pos.z)) ;
          sliderDropdown.update_pos_molette(sliderDropdown.pos, posMoletteDropdown) ;
          sliderDropdown.insideMol_Rect() ;
          sliderDropdown.select_molette() ;
          sliderDropdown.update_pos_molette() ;
          sliderDropdown.sliderDisplay(colorBG,colorBG,0) ;
          sliderDropdown.displayMolette(jaune, orange, jaune, orange, 0) ;
        }
      }
    } else {
      //header rendering
      dropdownOpen = false ;
      title_without_box(title, 1, size, titleFont);
    }
  }





  //DISPLAY
  public void title_without_box(String title, int step, Vec3 size, PFont font) {
    //update
    factorPos = step + pos.z -1 ;
    float yLevel = step == 1 ? pos.y  : (pos.y + (size.y *(factorPos )));
    Vec2 newPosDropdown = Vec2(pos.x, yLevel) ;
    if (inside(newPosDropdown, size,Vec2(mouseX,mouseY),RECT)) fill(colorTitleIn); else fill(colorTitleOut) ;
    textFont(font);
    text(title, pos.x +posText.x, yLevel +posText.y);
  }
  
  public void render_box(String label, int step, Vec2 size_box, PFont font, color textColor) {
    //update
    factorPos = step + pos.z -1 ;
    float yLevel = step == 1 ? pos.y  : (pos.y + (size_box.y *(factorPos)));
    Vec2 newPosDropdown = Vec2(pos.x, yLevel) ;
    if (inside(newPosDropdown, size_box, Vec2(mouseX,mouseY),RECT)) fill(boxIn); else fill(boxOut) ;
    //display
    noStroke() ;
    if (inside(newPosDropdown, size,Vec2(mouseX,mouseY),RECT)) fill(boxIn); else fill(boxOut) ;
    int sizeWidthMin = 60 ;
    int sizeWidthMax = 300 ;
    if (size_box.x < sizeWidthMin ) size_box.x = sizeWidthMin ; else if(size_box.x > sizeWidthMax ) size_box.x = sizeWidthMax ;
    rect(pos.x, yLevel, size_box.x, size_box.y);
    fill(textColor);
    textFont(font);
    text(label, pos.x +posText.x, yLevel +sizeBox -(ceil(sizeBox*.2)));
  }
  
  

  
  //RETURN
  //Check the dropdown when this one is open
  public int selectDropdownLine(float newWidth) {
    if(mouseX >= pos.x && mouseX <= pos.x +newWidth && mouseY >= pos.y && mouseY <= ((listItem.length+1) *size.y) +pos.y) {
      //choice the line
      int line = floor( (mouseY - (pos.y +size.y)) / size.y ) +updateDropdown;
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
  public int getSelection() {
    return line ;
  }
}
