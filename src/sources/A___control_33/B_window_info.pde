/**
* WINDOW INFO
* 2019-2019
* v 0.0.1
*/

void show_window_info() {
  
	int spacing = 16;
	pos_window_info.y(height -size_window_info.y -12);
  // window part
	if(select_midi_is) {
		fill(struc_colour_window_info);
		window_midi_info(pos_window_info, size_window_info);
	}
	
  // text part
  ivec2 pos = pos_window_info.copy();
  pos.add(10,20);
  // textFont(FuturaStencil_20,16);
  textFont(textUsual_3);
  textAlign(LEFT);
  fill(text_colour_window_info);
	if(select_midi_is) {
		
		display_select_midi_device(pos, spacing);
    display_midi_device_available(pos, spacing);		
	}
}


void window_midi_info(ivec2 pos, ivec2 size) {
	/*
  int pos_x = pos.x -(spacing/2) ;
  int pos_y = pos.y -spacing ;
  int size_y = 0 ;
  if (!choice_midi_device || !choice_midi_default_device) {
    size_y = int(spacing *2.5 +(spacing *(num_midi_input *1.2))) ;
  } else {
    size_y = int(spacing *2.5) ;
  }
  */
  rect(vec2(pos),vec2(size));
}