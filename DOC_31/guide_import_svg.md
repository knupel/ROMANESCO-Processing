ROMANESC0 1.2.0.30
ITEM
ROMANESCO PROCESSING ENVIRONMENT 
--
IMPORT SVG
--
Method to load and use svg, from the dropdown menu of the controller

load_svg(ID_item) ;
> this method can be used in the setting() or in the display()

the common use is like this, in association with the button parameter of the item selected menu

void setup() {
	if(parameter[ID_item]) {
      load_svg(ID_item) ;
      svg_import[ID_item].build(svg_current_path, svg_bricks_saved) ;
      svg_import[ID_item].svg_mode(CENTER) ;
   }
   .../...
}