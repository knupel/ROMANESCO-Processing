/**
Pulsar
2018-2018
v 0.0.1
*/

//object one
class Pulsar extends Romanesco {
  Cloud_3D pulsar;

  public Pulsar() {
    item_name = "Pulsar" ;
    ID_item = 16 ;
    ID_group = 1 ;
    item_author  = "Stan le Punk";
    item_version = "version 0.0.1";
    item_pack = "Base 2018";
    item_costume = "point/ellipse/triangle/rect/pentagon/star";
    item_mode = "nothing/cyclus/heart/ring cyclus/ring heart/helmet cyclus/helmet heart" ;
    // item_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Thickness,Size X,Size Y,Canvas X,Canvas Y,Quantity,Reactivity,Angle,Life,Spurt X,Flow,Direction X,Direction Y" ;
    hue_fill_is = true;
    sat_fill_is = true;
    bright_fill_is = true;
    alpha_fill_is = true;
    hue_stroke_is = true;
    sat_stroke_is = true;
    bright_stroke_is = true;
    alpha_stroke_is = true;
    thickness_is = true;
    size_x_is = true;
    size_y_is = false;
    size_z_is = false;
    font_size_is = false;
    canvas_x_is = true;
    canvas_y_is = false;
    canvas_z_is = false;

    reactivity_is = false;
    speed_x_is = true;
    speed_y_is = true;
    speed_z_is = true;
    spurt_x_is = false;
    spurt_y_is = false;
    spurt_z_is = false;
    dir_x_is = true;
    dir_y_is = true;
    dir_z_is = true;
    jit_x_is = false;
    jit_y_is = false;
    jit_z_is  = false;
    swing_x_is = false;
    swing_y_is = false;
    swing_z_is = false;

    num_is = true;
    variety_is = false;
    life_is = false;
    flow_is = false;
    quality_is = true;
    area_is = false;
    angle_is = false;
    scope_is = false;
    scan_is = false;
    align_is = false;
    repulsion_is = false;
    attraction_is = false;
    density_is = false;
    influence_is = false;
    calm_is = false;
    spectrum_is = false;
  }

  
  //SETUP
  void setup() {
    setting_start_position(ID_item,width/2, height/2,0);
  }
  //DRAW
  void draw() {
    float ratio_quality = quality_item[ID_item];
    ratio_quality = ratio_quality *ratio_quality *ratio_quality;
    int quality = int(5 + (10000 *ratio_quality));
    if(pulsar == null) {
      pulsar = new Cloud_3D(quality,P3D,r.ORDER,r.POLAR);
    } else {
      pulsar();
    }
  }


  void pulsar() {
    int radius = (int)canvas_x_item[ID_item];
    int size = (int)size_x_item[ID_item];


    Vec3 speed = Vec3(speed_x_item[ID_item],speed_y_item[ID_item],speed_z_item[ID_item]);
    speed.pow(3).div(2);

    Vec3 orientation = Vec3(dir_x_item[ID_item],dir_y_item[ID_item],dir_z_item[ID_item]);
    orientation.map_vec(0,360,0,TAU);
    // cloud_3D.ring(.01, false);
    // cloud_3D.helmet(.005, false);
    pulsar.size(size);
    // cloud_3D.size((height/4) *abs(sin(frameCount *.01)));
    // cloud_3D.orientation_y(map(mouseY,0,height,-PI,PI));
    // cloud_3D.angle(frameCount *.01);
    aspect_rope(fill_item[ID_item], stroke_item[ID_item], thickness_item[ID_item]);
    



    // rendering


    if(motion[ID_item]) {
      pulsar.rotation_x(speed.x,false);
      pulsar.rotation_y(speed.y,false);
      pulsar.rotation_z(speed.z,false);
      pulsar.orientation(orientation);

      mode();
      if(!sound[ID_item]) {
        pulsar.set_tempo(80);   
      } else {
        pulsar.set_tempo((int)tempo[ID_item]); 
        // mode();
        radius *= (transient_value[0][ID_item] *.2);
      }

    } else {
      pulsar.set_behavior("RADIUS"); // nothing
    }
    

    pulsar.set_radius(radius);

    
    // Vec3 pos = Vec3(width/2, height/2,-(height/2));
    Vec3 pos = Vec3();
    
    pulsar.pos(pos);
    pulsar.update();
    /*
    printTempo(30,"costume brute",costume_controller_selection[ID_item]);
    printTempo(30,"costume:",costume[ID_item]);
    */
    // select_costume(ID_item, item_name);
    //select_costume();
    pulsar.costume(get_costume());
    pulsar.show();
  }



  void mode() {
    if(mode[ID_item] == 0) {
      pulsar.set_behavior("RADIUS"); // nothing
    } else if(mode[ID_item] == 1) {
      pulsar.set_behavior("SIN"); // cyclus
    } else if(mode[ID_item] == 2) {
      pulsar.set_behavior("SIN_POW_SIN"); // heart
    } else if(mode[ID_item] == 3) {
      pulsar.set_behavior("SIN"); // cyclus ring
      pulsar.ring(.01, false);
    } else if(mode[ID_item] == 4) {
      pulsar.set_behavior("SIN_POW_SIN"); // heart ring
      pulsar.ring(.01, false);
    } else if(mode[ID_item] == 5) {
      pulsar.set_behavior("SIN"); // cyclus helmet
      pulsar.helmet(.01, false);
    } else if(mode[ID_item] == 6) {
      pulsar.set_behavior("SIN_POW_SIN"); // hear helmet
      pulsar.helmet(.01, false);
    }
  }
}





  