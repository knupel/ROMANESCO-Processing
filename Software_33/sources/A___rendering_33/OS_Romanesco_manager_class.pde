/**
Class Romanesco_manager
v 1.2.2
inspired by Andreas Gysin work for The Abyss Project
@see https://github.com/ertdfgcvb/TheAbyss
*/
class Romanesco_manager {
  private ArrayList<Romanesco>RomanescoList;
  private ArrayList<Class>item_list;

  PApplet parent;
  String item_class_name [];
  int num_classes;
  Romanesco_manager(PApplet parent) {
    this.parent = parent;
    RomanescoList = new ArrayList<Romanesco>() ;
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


  //create the canvas index
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
    for (int i=0 ; i < RomanescoList.size() ; i++ ) {
      Romanesco item = (Romanesco) RomanescoList.get(i);
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
    for (int i=0 ; i < RomanescoList.size() ; i++) {
      Romanesco item = (Romanesco) RomanescoList.get(i);
      item_ID[item.ID_item] = item.ID_item;
      item_name[item.ID_item] = item.item_name;
      item_author[item.ID_item] = item.item_author;
      item_version[item.ID_item] = item.item_version;
      item_pack[item.ID_item] = item.item_pack;
    }
  }

  int id_item_from_library(int index) {
    int id = -1 ;
    if(index < RomanescoList.size()) {
      Romanesco item = (Romanesco) RomanescoList.get(index);
      id = item.ID_item;
    }  
    return id;
  }

  public Romanesco get(int index) {
    if(index < RomanescoList.size()) {
      return RomanescoList.get(index);
    } else {
      return null;
    }  
  }
  
  
  public int size() {
    return item_list.size();
  }
  
  
  //ADD OBJECT from the sub-classes
  public void add_item_romanesco() {
    int n = item_list.size();
    for( int i = 0 ; i < n ; i++) {
      add_item(i);
    }
  }

  //
  public Romanesco add_item(int i) {
    if (i < 0 || i >= item_list.size()) {
      return null;
    }
    
    Romanesco class_romanesco_item = null;
    try {
      Class c = item_list.get(i);
      Constructor[] constructors = c.getConstructors();
      class_romanesco_item = (Romanesco)constructors[0].newInstance(parent);
      class_romanesco_item.set_id(i+1);
      class_romanesco_item.set_group(1);
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
    //add object 
    if (class_romanesco_item != null) {
      add_romaneco_item(class_romanesco_item);
    }
    return class_romanesco_item;
  }
  
  // finalization of adding object
  private void add_romaneco_item(Romanesco item) {
    item.set_item_romanesco(this);
    RomanescoList.add(item);
  }
  
  
  

  // SETUP
  public boolean init_items() {
    int num = 0 ;
    for (Romanesco item : RomanescoList) {
      motion[item.get_id()] = true;
      init_value_mouse[item.get_id()] = true;
      num++;
      item.setup();
      println("setup of", item.item_name, item.get_id(), "is done");
      if(pos_item_ref[item.get_id()] == null) {
        pos_item_ref[item.get_id()] = Vec3();
      }
      pos_item_ref[item.get_id()].set(item_setting_position[0][item.get_id()]);
      // update_var_items(item.get_id());
    }

    if(num == RomanescoList.size()) {
      return true ;
    } else {
      return false;
    }
  }

  

  // DRAW
  public void show_item_3D(boolean movePos, boolean moveDir, boolean movePosAndDir) {
    // when you use the third order Romanesco understand the the first and the second are true
    if(movePosAndDir) {
      moveDir = true;
      movePos = true;
    }
    
    //the method
    if (show_item != null) {
      for (Romanesco item : RomanescoList) {
        if (show_item[item.get_id()]) {
          update_var_items(item.get_id());
          pushMatrix();
          add_ref_item(item.get_id());
          item_follower(item.get_id());
          if((key_v_long || reset_item_on_button_alert_is()) && action[item.get_id()]) {
            item_move(movePos, moveDir, item.get_id());
          }
          final_pos_item(item.get_id());
          item.draw();
          popMatrix();
        } else {
          if(movie[item.get_id()] != null) movie[item.get_id()].pause();
        }
      }
    }
  }


  public void show_item_2D() {
    for (Romanesco item : RomanescoList) {
      if (show_item[item.get_id()]) {
        item.draw_2D();
      } else {
        if(movie[item.get_id()] != null) movie[item.get_id()].pause();
      }
    }
  }
}