  Tab s_camera line 500 
  change nothing
  ratio_speed_camera_inertia_rotate = map(value_slider_camera[7],0,360,0,30);
  ratio_speed_camera_inertia_translate = map(value_slider_camera[8],0,360,0,30);
  println("inertia",ratio_speed_camera_inertia_rotate,ratio_speed_camera_inertia_translate);