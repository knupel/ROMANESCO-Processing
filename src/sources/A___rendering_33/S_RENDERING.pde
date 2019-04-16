/**
* RENDERING
* 2016-2019
* v 1.2.2
*/
boolean fx_filter_is_done = false;
boolean fx_mix_is_done = false;
void rendering() {
  boolean show_is = true;
  // setting display
  if(curtain_button_is()) {
    show_is = false;
  }
  if(IAM.equals("presecene") && LIVE) {
    show_is = true;
  }

  // display
  if(show_is) {
    fx_filter_is_done = false;
    fx_mix_is_done = false;
    rendering_background(USE_LAYER,0);
    println("FX",frameCount);
    pre_fx();
    rendering_item_3D(USE_LAYER,1);
    rendering_item_2D(USE_LAYER,1);
    pre_fx();

    fx_mix_after();

    rendering_info(USE_LAYER);
  } else {
    rendering_curtain(USE_LAYER);   
  }
}

/**
* This method is used to choice when make a copy of Image to create the temp effect
*/

void pre_fx() {
    // FX MIX
  if(!draw_fx_mix_before_rendering_is() && !fx_mix_is_done) {
    println("MIX",frameCount);
    fx_mix_is_done = true;
    
    fx_mix_before();
  } else if(!fx_mix_is_done) {
    println("MIX",frameCount);
    fx_mix_is_done = true;
    fx_mix_before();
  }

  // FX FILTER
  if(!draw_fx_filter_before_rendering_is() && !fx_filter_is_done) {
    fx_filter_is_done = true;
    println("FILTER",frameCount,draw_fx_filter_before_rendering_is());
    fx_filter();
  } else if(!fx_filter_is_done) {
    fx_filter_is_done = true;
    println("FILTER",frameCount,draw_fx_filter_before_rendering_is());
    fx_filter();
  }

  // FX MIX
  
}








void rendering_item_3D(boolean use_layer_is, int which_layer) {
  if(use_layer_is) {
    get_layer(which_layer);
    begin_layer();
    rendering_item_final_3D();
    end_layer();
  } else {
    rendering_item_final_3D();
  }
}


void rendering_item_final_3D() {
  camera_romanesco_draw();
  // light
  light_position_draw(mouse[0], wheel[0]); // not in the conditional because we need to display in the info box
  light_update_position_direction();
  if(FULL_RENDERING) {
    light_call_shader();
    light_display();
    shader_draw();
  }
  
  //use romanesco object
  rom_manager.show_item_3D(ORDER_ONE,ORDER_TWO,ORDER_THREE);

  grid_romanesco(show_info_camera);
  stop_camera();
}




void rendering_background(boolean use_layer_is, int which_layer) {
  if(use_layer_is) {
    select_layer(which_layer);
    begin_layer();
    background_romanesco();
    end_layer();
  } else {
    background_romanesco();
  }
}



void rendering_item_2D(boolean use_layer_is, int which_layer) {
  if(use_layer_is) {
    get_layer(which_layer);
    begin_layer();
    rom_manager.show_item_2D();
    end_layer();
  } else {
    rom_manager.show_item_2D();
  }
}



void rendering_curtain(boolean use_layer_is) {
  if(use_layer_is) {
    get_layer(get_layer_num() -1);
    begin_layer();
    curtain();
    end_layer();
  } else {
    curtain();
  }
}

void rendering_info(boolean use_layer_is) {
  if(use_layer_is) {
    get_layer(get_layer_num() -1);
    begin_layer();
    info();
    end_layer();
  } else {
    info();
  }
}






























/**
INIT Romanesco
*/
boolean init_romanesco = true ;
void init_romanesco() {
  rectMode(CORNER);
  textAlign(LEFT);
  
  if(init_romanesco) {
    int which_setting = 0 ;
    for(int i = 0 ; i < NUM_ITEM_PLUS_MASTER ; i ++) {
      reset_direction_item (which_setting, i) ;
      update_ref_direction(i) ;
      // check for null before start
      if(dir_item_final[i] == null) dir_item_final[i] = vec3() ;
      if(pos_item_final[i] == null) {
        float x = -(width/2) ;
        float y = -(height/2) ;
        pos_item_final[i] = vec3(x,y,0) ;
      }
    }
    init_romanesco = false ;
  }
}




/**
DISPLAY SETUP
2015-2019
v 1.3.1
*/
String displayMode = ("");
// int depth_scene;
void display_setup(int frame_rate, int num_layer) {
  if(IAM.equals("scene")) {
    background_rope(0);
    noCursor();
  }
  frameRate(frame_rate);
  colorMode(HSB,HSBmode);
  //colorMode(HSB,HSBmode.hue(),HSBmode.sat(),HSBmode.bri(),HSBmode.alp());

  set_screen();
  render_canvas = ivec6(0,width,0,height,-height,height);
  // depth_scene = height;

  // resize layer
  if(USE_LAYER) {
    init_layer(width,height,num_layer);
    for(int i = 0 ; i < get_layer_num() ; i++) {
      select_layer(i);
      begin_layer();
      colorMode(HSB,HSBmode);
      // colorMode(HSB,HSBmode.hue(),HSBmode.sat(),HSBmode.bri(),HSBmode.alp());
      end_layer();
    }
  } 
}


void set_screen() {
  Table configurationScene = loadTable(preference_path +"sceneProperty.csv","header");
  TableRow row = configurationScene.getRow(0);
  ivec2 window = ivec2(width,height);
  int target_screen = row.getInt("whichScreen");

  if(FULL_RENDERING) {
    if(!DEV_MODE) {
      window.x = row.getInt("width"); 
      window.y = row.getInt("height");
    }
 
    if(!FULL_SCREEN) {
      if(!DEV_MODE) window.set(resize_screen(window,target_screen));
      load_window_location(window);
      surface.setSize(window.x,window.y);
    } else {
      println("The",IAM,"is on the screen",target_screen,"on",get_display_num(),"screen available");    
      int ox = get_screen_location(target_screen).x;
      int oy = get_screen_location(target_screen).y;
      surface.setLocation(ox,oy);
      int sx = get_screen_size(target_screen).x;
      int sy = get_screen_size(target_screen).y;
      surface.setSize(sx,sy);
      for(int i = 0 ; i < get_display_num() ; i++) {
        println("screen",i,"location",get_screen_location(i));
        println("screen",i,"size",get_screen_size(i));
      }
      println("target screen",target_screen,"location:",ox,oy);
      println("target screen",target_screen,"size:",sx,sy);
      window.set(sx,sy);
    }   
  } else {
    window.set(row.getInt("preview_width"),row.getInt("preview_height"));
    load_window_location(window);
    surface.setSize(window.x,window.y);
  }
  scene_width = window.x;
  scene_height = window.y;
  println(IAM,"screen size:",window); 
}

// resize_screen_if_parameter_is_too_big
ivec2 resize_screen(ivec2 window, int target) {
  if(window.x >= get_screen_size(target).x) {
    window.x = get_screen_size(target).x -100;
  }
  if(window.y >= get_screen_size(target).y) {
    window.y = get_screen_size(target).y -100;
  }
  return window;
}
























/**
OPENING
2018-2018
*/
void opening_display_message() {
  if(IAM.equals("scene")) {
  // if(IAM.equals("scene") || !LIVE) {
    background_rope(0);
    message_opening();
  } else if(IAM.equals("prescene") && FULL_RENDERING) {
    background_rope(0);
    message_opening();
  }
}


void message_opening() {
  fill(blanc);
  stroke(blanc);
  textSize(48);
  textAlign(CENTER);
  start_matrix();
  translate(width/2, height/2, abs(sin(frameCount * .005)) *(height/2)) ;
  text(nameVersion.toUpperCase(),0,-12);
  textSize(24);
  text(prettyVersion+"." + version,0,16);
  text("rendering " +IAM,0,36);
  stop_matrix() ;
  textAlign(LEFT) ;
}
































































































/**
MIROIR
v 0.1.0
*/
boolean syphon_on_off  ;
SyphonServer server ;
void syphon_settings() {
  PJOGL.profile=1;
}

void syphon_setup() {
  String name_syphon = (nameVersion + " " + prettyVersion +"."+version) ;
  server = new SyphonServer(this, name_syphon);
  println("Syphon setup done") ;
}

void syphon_draw() {
  if(key_y) syphon_on_off = !syphon_on_off ;
  if(syphon_on_off) server.sendScreen();
}






















/**
DISPLAY INFO
v 0.3.0
*/
boolean displayInfo, show_info_camera ;
int posInfo = 2 ;
void info() {
  sounda.info(displayInfo);
  int color_text = color(0,0,100);
  int color_bg = color(0,100,100,50);

  if (displayInfo) {
    //perspective() ;
    show_info_rendering(color_bg,color_text) ;
    show_info_item(color_bg,color_text) ;
  }
  if (show_info_camera) {
    show_info_camera(color_text);
  }
}

void show_info_rendering(int bg_txt, int txt) {
  noStroke() ;
  fill(bg_txt) ;
  rectMode(CORNER) ;
  textAlign(LEFT) ;
  rect(0,-5,width, 15*posInfo) ;
  posInfo = 2 ;
  fill(txt) ;
  textFont(system_font,10);
  //INFO SIZE and RENDERER
  String displayModeInfo ;
  if (displayMode.equals("Classic") ) displayModeInfo = ("classic") ; else displayModeInfo = displayMode ;
  String infoRendering =("");
  if(FULL_RENDERING) infoRendering = ("Full rendering") ; else infoRendering = ("Preview rendering") ;
  text("Size " + width + "x" + height + " / "  + infoRendering + " / Render mode " + displayModeInfo + " / FrameRate " + (int)frameRate, 15,15) ;
  // INFO SYPHON
  text("Syphon " +syphon_on_off + " / press “y“ to on/off the Syphon",15, 15 *posInfo ) ;
  posInfo += 1 ;
  //INFO MOUSE and PEN
  text("Mouse " + mouseX + " / " + mouseY + " molette " + wheel[0] + " pen orientation " + (int)deg360(vec2(pen[0].x,pen[0].y)) +"°   stylet pressur " + int(pen[0].z *10),15, 15 *posInfo ) ;  
  posInfo += 1 ;
  // LIGHT INFO
  text("Directional light ONE || pos " + int(pos_light[1].x)+ " / " + int(pos_light[1].y) + " / "+ int(pos_light[1].z) + " || dir " + decimale(dir_light[1].x,2) + " / " + decimale(dir_light[1].y,2) + " / "+ decimale(dir_light[1].z,2),15, 15 *posInfo  ) ;
  posInfo += 1 ;
  text("Directional light TWO || pos " + int(pos_light[2].x)+ " / " + int(pos_light[2].y) + " / "+ int(pos_light[2].z) + " || dir " + decimale(dir_light[2].x,2) + " / " + decimale(dir_light[2].y,2) + " / "+ decimale(dir_light[2].z,2),15, 15 *posInfo  ) ;
  posInfo += 1 ;
  //INFO SOUND
  if (get_time_track() > 1 ) text("the track play until " +get_time_track() + " – tempo " + get_tempo_name() + " " + get_tempo() , 15,15 *(posInfo)) ; else text("no track detected ", 15, 15 *(posInfo)) ;
  posInfo += 1 ;
  text("right " + get_right(100), 15, 15 *(posInfo)) ;  
  text("left "  + get_left(100),  50, 15 *(posInfo)) ;
  posInfo += 1 ;
}


int posInfoObj = 1 ;
void show_info_item(int color_bg, int color_text) {
  noStroke() ;
  fill(color_bg) ;
  rectMode(CORNER) ;
  textAlign(LEFT) ;
  float heightBox = 15*posInfoObj ;
  rect(0, height -heightBox,width, heightBox) ;
  fill(color_text) ;
  textFont(system_font,10);
  
  posInfoObj = 1 ;
  for(int i = 0 ; i < NUM_ITEM_PLUS_MASTER ; i++) {
    Romanesco item = rom_manager.get(i);
    if(item != null) {
      if(item.show_is()) {
        posInfoObj += 1 ;
        String position = ("x:" +(int)pos_item[i].x + " y:" + (int)pos_item[i].y+ " z:" + (int)pos_item[i].z) ;
        text(item_name[i] + " - Coord " + position + " - " + item_info[item_ID[i]], 10, height -(15 *(posInfoObj -1))) ;
      }
    }   
  }
}











//INFO 3D
void show_info_camera(color txt) {
  String posCam = ( int(-1 *scene_camera.x ) + " / " + int(scene_camera.y) + " / " +  int(scene_camera.z -height/2));
  String eyeDirectionCam = (int(eye_camera.x) + " / " + int(eye_camera.y));
  fill(txt); 
  textFont(system_font,10);
  textAlign(RIGHT);
  text("Position " +posCam, width/2 -30 , height/2 -30);
  text("Direction " +eyeDirectionCam, width/2 -30 , height/2 -15);
}


//REPERE 3D
void repere(int size, PVector pos, String name) {
  pushMatrix() ;
  translate(pos.x +20 , pos.y -20, pos.z) ;
  fill(blanc) ;
  text(name, 0,0) ;
  popMatrix() ;
  line(-size +pos.x,pos.y, pos.z,size +pos.x, pos.y, pos.z) ;
  line(pos.x,-size +pos.y, pos.z, pos.x,size +pos.y, pos.z) ;
  line(pos.x, pos.y,-size +pos.z, pos.x, pos.y,size +pos.z) ;
}

//repere cross
void repere(int size) {
  line(-size,0,0,size,0,0) ;
  line(0,-size,0,0,size,0) ;
  line(0,0,-size,0,0,size) ;
}












