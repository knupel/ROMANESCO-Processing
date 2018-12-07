/**
Class Romanesco_manager
v 1.6.0
class manager inspired by Andreas Gysin work for The Abyss Project
@see https://github.com/ertdfgcvb/TheAbyss
*/

import java.util.Date;
import java.sql.Timestamp;


class Romanesco_manager {
  private ArrayList<Romanesco>romanesco_item_list;
  private ArrayList<Class>item_list;

  PApplet parent;
  String item_class_name [];
  int num_classes;
  Romanesco_manager(PApplet parent) {
    this.parent = parent;
    romanesco_item_list = new ArrayList<Romanesco>() ;
    //scan the existant classes
    item_list = scan_classes(parent,"Romanesco");
  }

  //ADD CLASSES
  private ArrayList<Class> scan_classes(PApplet parent, String super_Class_name) {
    ArrayList<Class> classes = new ArrayList<Class>();

    Class[] c = parent.getClass().getDeclaredClasses();
    String template = "Template";
    //create the index table
    for (int i=0; i<c.length; i++) {
      if (c[i].getSuperclass() != null && c[i].getSuperclass().getSimpleName().equals(super_Class_name)) {
        
        if(!c[i].getSimpleName().equals(template)) {
          classes.add(c[i]);
          num_classes = classes.size();
        } 
      }
    }
    create_index(num_classes) ;
    
    //init the String info
    item_class_name = new String[num_classes] ;
    for (int i = 0 ; i < item_class_name.length ; i++) {
      item_class_name[i] = ("");
    }
    
    //add class in Romanesco, plus add info in the String for the index
    int num = 0;
    for (int i = 0 ; i < c.length ; i++) {
      if (c[i].getSuperclass() != null && c[i].getSuperclass().getSimpleName().equals(super_Class_name)) {
        if(!c[i].getSimpleName().equals(template)) {
          item_class_name[num] = c[i].getSimpleName();
          num++;
        }
      }
    }
    begin_index() ;
    return classes;  
  }


  //create the index
  void create_index(int num) {
    index_item = new Table() ;
    index_item.addColumn("Library Order");
    index_item.addColumn("Name");
    index_item.addColumn("ID");
    index_item.addColumn("Group");
    index_item.addColumn("Version");
    index_item.addColumn("Author");
    index_item.addColumn("Class name");
    index_item.addColumn("Pack");
    index_item.addColumn("Render");
    index_item.addColumn("Costume");
    index_item.addColumn("Mode");
    
    
    // add row
    row_index_item = new TableRow [num] ;
    for(int i = 0 ; i < row_index_item.length ; i++) {
      row_index_item[i] = index_item.addRow();
    }
    
    // create var for info object, need to be create here
    int num_plus_one = num+1;
    item_ID = new int[num_plus_one];
    item_name = new String[num_plus_one];
    item_author = new String[num_plus_one];
    item_version = new String[num_plus_one];
    item_pack = new String[num_plus_one];
    item_info = new String[num_plus_one];
    // init var
    for ( int i = 0 ; i< num_plus_one ; i++ ) {
      item_name [i] = "My name is Nobody";
      item_info [i] = "Sorry nobody write about me!";
      item_ID [i] = 0;
    }
  }

  // put information in the index
  void begin_index() {
    for(int i = 0 ; i < row_index_item.length ; i++) {
      row_index_item[i].setString("Class name",item_class_name[i]);
      row_index_item[i].setInt("Library Order",i+1);
    }
  }

  /**
  EXTERNAL  VOID
  */
  void finish_index() {
  // catch the different parameter from object class Romanesco
    for (int i=0 ; i < romanesco_item_list.size() ; i++ ) {
      Romanesco item = (Romanesco) romanesco_item_list.get(i);
      row_index_item[i].setString("Name",item.item_name);
      row_index_item[i].setInt("ID",item.ID_item);
      row_index_item[i].setInt("Group",item.ID_group);
      row_index_item[i].setString("Author",item.item_author);
      row_index_item[i].setString("References",item.item_references);
      row_index_item[i].setString("Version",item.item_version);
      row_index_item[i].setString("Pack",item.item_pack);
      row_index_item[i].setString("Costume",item.item_costume);
      row_index_item[i].setString("Mode",item.item_mode);
      row_index_item[i].setString("Slider",item.item_slider);
    }
    saveTable(index_item, preference_path+"index_romanesco_items.csv"); 
  }
  // ADD info for the user
  void write_info_user() {
    // catch the different parameter from object class Romanesco
    for (int i=0 ; i < romanesco_item_list.size() ; i++) {
      Romanesco item = (Romanesco) romanesco_item_list.get(i);
      item_ID[item.ID_item] = item.ID_item;
      item_name[item.ID_item] = item.item_name;
      item_author[item.ID_item] = item.item_author;
      item_version[item.ID_item] = item.item_version;
      item_pack[item.ID_item] = item.item_pack;
    }
  }

  int id_item_from_library(int index) {
    int id = -1 ;
    if(index < romanesco_item_list.size()) {
      Romanesco item = (Romanesco) romanesco_item_list.get(index);
      id = item.ID_item;
    }  
    return id;
  }

  public Romanesco get(int index) {
    if(index < romanesco_item_list.size()) {
      return romanesco_item_list.get(index);
    } else {
      return null;
    }  
  }
  
  
  public int size() {
    return item_list.size();
  }
  
  
  // add itemfrom the sub-classes
  public void add_item() {
    for(int i = 0 ; i < item_list.size() ; i++) {
      add_item(i);
    }
  }

  //
  private Romanesco add_item(int i) {
    if (i < 0 || i >= item_list.size()) {
      return null;
    }
    
    Romanesco item = null;
    try {
      Class c = item_list.get(i);
      Constructor[] constructors = c.getConstructors();
      item = (Romanesco)constructors[0].newInstance(parent);
      item.set_id(i+1);
      item.set_group(1);
    }
    catch (InvocationTargetException e) {
      System.out.println(e);
    } 
    catch (InstantiationException e) {
      System.out.println(e);
    } 
    catch (IllegalAccessException e) {
      System.out.println(e);
    } 
    //add item
    if (item != null) {
      romanesco_item_list.add(item);
    }
    return item;
  }
  


  public void set_item(String path) {
    Table slider_item_data = loadTable(path,"header");
    String [][] slider_name = new String[4][16];
    for(int i = 0 ; i < slider_item_data.getRowCount() ;i++) {
      TableRow row = slider_item_data.getRow(i);
      for(int line = 0 ; line < 4 ; line++) {
        String name = "";
        if(line == 0) {
          name = "slider item a";
        } else if(line == 1) {
          name = "slider item b";
        } else if(line == 2) {
          name = "slider item c";
        } else if(line == 3) {
          name = "slider item d";
        }
        if(row.getString("name").equals(name)) {
          for(int k = 0 ; k < slider_item_data.getColumnCount()-1 ; k++) {
            if(k < slider_name[line].length) {
              slider_name[line][k] = row.getString("col "+Integer.toString(k)) ;
            }
          }
        }
      }
    }
    for(Romanesco item : romanesco_item_list) {
      item.set_slider(slider_name);
    }
  }
  
  
  

  // SETUP
  public boolean init_items() {
    int num = 0 ;
    for (Romanesco item : romanesco_item_list) {
      item.motion_is(true);
      init_value_mouse[item.get_id()] = true;
      item.mode.set_name(item.item_mode.split("/"));

      num++;
      item.setup();
      println("setup of", item.item_name, item.get_id(), "is done");
      if(pos_item_ref[item.get_id()] == null) {
        pos_item_ref[item.get_id()] = Vec3();
      }
      pos_item_ref[item.get_id()].set(item_setting_position[0][item.get_id()]);
    }

    if(num == romanesco_item_list.size()) {
      return true ;
    } else {
      return false;
    }
  }







  /**
  * HISTORIC
  * v 0.0.2
  * use to write and read the history
  */
  History historic = new History(20);

  protected void historic() {
    Script script = new Script();
    script.add("translate","world",finalSceneCamera);
    script.add("rotate:","world",finalEyeCamera);

    for (int i = 0 ; i < romanesco_item_list.size() ; i++ ) {
      Romanesco item = (Romanesco) romanesco_item_list.get(i);
      String family = item.get_name();
      script.add("show",family,item.show_is());
      script.add("id",family,item.get_id());
      script.add("group",family,item.get_group());
      script.add("parameter",family,item.parameter_is());
      script.add("sound",family,item.sound_is());
      script.add("action",family,item.action_is());
      script.add("costume",family,item.get_costume_id());
      script.add("mode",family,item.get_mode_id());

      // disposition
      script.add("translate",family,pos_item_final[item.get_id()]);
      script.add("rotate",family,dir_item_final[item.get_id()]);
      // STATE
      script.add("fill is",family,item.fill_is());
      script.add("stroke is",family,item.stroke_is());

      script.add("birth",family,item.birth_is());
      script.add("colour",family,item.colour_is());
      script.add("dimension",family,item.dimension_is());
      script.add("horizon",family,item.horizon_is());
      script.add("motion",family,item.motion_is());
      script.add("follow",family,item.follow_is());
      script.add("reverse",family,item.reverse_is());
      script.add("wire",family,item.wire_is());
      script.add("special",family,item.special_is());
      // SLIDER
      script.add("fill",family,item.get_fill());
      script.add("stroke",family,item.get_stroke());
      script.add("size",family,item.get_size());
      script.add("diameter",family,item.get_diameter());
      script.add("canvas",family,item.get_canvas());

      script.add("frequence",family,item.get_frequence());
      script.add("speed",family,item.get_speed());
      script.add("spurt",family,item.get_spurt());
      script.add("dir",family,item.get_dir());
      script.add("jitter",family,item.get_jitter());
      script.add("swing",family,item.get_swing());

      script.add("quantity",family,item.get_quantity());
      script.add("variety",family,item.get_variety());
      script.add("life",family,item.get_life());
      script.add("flow",family,item.get_flow());
      script.add("quality",family,item.get_quality());
      script.add("area",family,item.get_area());
      script.add("angle",family,item.get_angle());
      script.add("scope",family,item.get_scope());
      script.add("scan",family,item.get_scan());
      script.add("alignment",family,item.get_alignment());
      script.add("repulsion",family,item.get_repulsion());
      script.add("attraction",family,item.get_attraction());
      script.add("density",family,item.get_density());
      script.add("influence",family,item.get_influence());
      script.add("calm",family,item.get_calm());
      script.add("spectrum",family,item.get_spectrum());

      script.add("grid",family,item.get_grid());
      script.add("viscosity",family,item.get_viscosity());
      script.add("diffusion",family,item.get_diffusion());
      script.add("power",family,item.get_power());
      script.add("mass",family,item.get_mass());
      script.add("coord",family,item.get_coord());

    }
    historic.add(script);
  }

  protected int historic_size() {
    if(historic != null) {
      return historic.size();
    } else return 0;
  }

  protected void print_historic() {
    println(historic.get(0).get("grid","Grillo"));

  }

  /*
  protected Script get_script(int target) {
    if(historic == null) {
      return null;
    } else {
      if(target < historic.size()) {
        return historic.get(target);
      } else {
        return historic.get(historic.size()-1);
      }
    }
  }
  */


  


















  // DRAW
  public void show_item_3D(boolean movePos, boolean moveDir, boolean movePosAndDir) {
    // when you use the third order Romanesco understand the the first and the second are true
    if(movePosAndDir) {
      moveDir = true;
      movePos = true;
    }
    
    //the method
    for (Romanesco item : romanesco_item_list) {
      if (item.show_is()) {
        update_var_items(item);
        pushMatrix();
        add_ref_item(item.get_id());
        item_follower(item);
        if((key_v_long || reset_item_on_button_alert_is()) && item.action_is()) {
          item_move(movePos, moveDir, item.get_id());
        }
        final_pos_item(item);
        item.draw();
        popMatrix();
      } else {
        if(movie[item.get_id()] != null) movie[item.get_id()].pause();
      }
    }
  }


  public void show_item_2D() {
    for (Romanesco item : romanesco_item_list) {
      if (item.show_is()) {
        item.draw_2D();
      } else {
        if(movie[item.get_id()] != null) movie[item.get_id()].pause();
      }
    }
  }
}

