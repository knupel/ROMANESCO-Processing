/**
MIDI CONTROL
v 2.1.2
2014-2019
*/
boolean reset_midi_selection;

void init_midi() {
	check_midi_input();
	open_midi_bus();
	select_first_midi_input();
}

void update_midi() {
	midi_select(which_midi_input, num_midi_input);
	use_specific_midi_input(which_midi_input);
}

void reset_midi_control_parametter() {
	reset_midi_selection = false;
}













/**
MAIN METHOD
*/
import themidibus.*; 
MidiBus [] myBus; 
int  num_midi_input;
int which_midi_input = -1;
boolean choice_midi_device, choice_midi_default_device;
String [] name_midi_input;
String [] ID_midi_input;
void check_midi_input() {
	name_midi_input = MidiBus.availableInputs();
	num_midi_input = name_midi_input.length;
	ID_midi_input = new String[num_midi_input];
}


void open_midi_bus() {
	myBus = new MidiBus[num_midi_input] ;
	for(int i = 0 ; i < num_midi_input ; i++) {
		myBus [i] = new MidiBus(this, i, "Java Sound Synthesizer");
		ID_midi_input [i] = myBus [i].getBusName();
	}
}

void select_first_midi_input() {
	if (num_midi_input > 0 && !choice_midi_device && !choice_midi_default_device) which_midi_input = 0 ;
}

void close_midi_input_bus() {
	for(int i = 0 ; i < num_midi_input ; i++) {
		myBus [i].close();
	}
}



// info from controller midi device
int midi_channel, midi_CC, midi_value; 
long long_timestamp;
String midi_bus_name;
// this void is an upper method like draw, setup, setting...
void controllerChange(int channel, int CC, int value, long timestamp, String bus_name) {
	midi_channel = channel;
	midi_CC = CC;
	midi_value = value;
	midi_bus_name = bus_name;
	long_timestamp = timestamp;
}







































// give the midi info to the romanesco variable
void use_specific_midi_input(int ID) {
	if(ID_midi_input != null && ID >= 0 && ID < ID_midi_input.length) {
		if(ID_midi_input[ID].equals(midi_bus_name)) {
			midi_channel_romanesco = midi_channel;
			midi_CC_romanesco = midi_CC;
			midi_value_romanesco = midi_value;
		}
	}
	if(ID >= ID_midi_input.length) {
		printErr("No MIDI devices match with your request");
	}
}


// Give new midi device to Romanesco
void open_input_midi(int which_one, int num) {
	if ((!choice_midi_device || !choice_midi_default_device) &&  which_one != -1 && which_one < num) {
		use_specific_midi_input(which_one);
		choice_midi_default_device = true;
		choice_midi_device = true;
	}
}

// reset 
void reset_input_midi_device() {
	if (which_midi_input >= 0 ) {
		which_midi_input = -1;
		choice_midi_device = false;
	}
}









// DISPLAY INFO MIDI INPUT
void display_midi_device_available(ivec2 pos, int spacing) {
	int num_line = 0;
	if (!choice_midi_device || !choice_midi_default_device) {
		text("Press the ID number to select an input Midi", pos.x, pos.y);

		text(num_midi_input + " device(s) available(s)", pos.x, pos.y +spacing);
		for (int i = 0; i < num_midi_input; i++) {
			num_line = i + 2;
			// to make something clean for the reading
			String ID_input = "" + i;
			if (i > 9) {
				ID_input = nf(i, 2);
			}
			text("input device "+ID_input+": "+name_midi_input [i], pos.x, pos.y +(num_line *spacing));
		}
	}
}



void display_select_midi_device(ivec2 pos, int spacing) {
	if(which_midi_input < num_midi_input ) {
		if (which_midi_input >= 0 && (choice_midi_device || choice_midi_default_device)) {
			text("Current midi device is " + name_midi_input [which_midi_input], pos.x, pos.y);
			text("If you want choice an other input press “N“ ", pos.x, pos.y + spacing);
		}
	} else {
		choice_midi_device = false;
	}
}









// ANNEXE don't need MIDI LIBRARIE CODE
boolean init_midi ;
void midi_select(int which_one, int num) {
	if(select_midi_is || !init_midi) {
		open_input_midi(which_one, num) ;
		init_midi = true ;
	}
}


void select_input_midi_device() {
	if(key == '0') which_midi_input = 0;
	if(key == '1') which_midi_input = 1;
	if(key == '2') which_midi_input = 2;
	if(key == '3') which_midi_input = 3;
	if(key == '4') which_midi_input = 4;
	if(key == '5') which_midi_input = 5;
	if(key == '6') which_midi_input = 6;
	if(key == '7') which_midi_input = 7;
	if(key == '8') which_midi_input = 8;
	if(key == '9') which_midi_input = 9;
}

void keypressed_midi() {
	if (!choice_midi_device) {
		select_input_midi_device();
	}
	if (key =='n' && choice_midi_device) {
		reset_input_midi_device();
	}
	if(keyCode == BACKSPACE || keyCode == DELETE) {
		if(select_midi_is) {
			reset_midi_selection = true;
		}   
	} 
}









/**
MIDI MANAGER
*/
void midi_manager(boolean saveButton) {
	int rank = 0 ;
	midi_button(button_bg,rank,saveButton,"Button background");
	rank++;
	midi_button(button_curtain,rank,saveButton,"Button curtain");
	rank++;
	midi_button(button_reset_camera,rank,saveButton,"Button reset camera");
	rank++;
	midi_button(button_reset_item_on,rank,saveButton,"Button reset ative item position");
	rank++;
	midi_button(button_birth,rank,saveButton,"Button birth");
	rank++;
	midi_button(button_3D,rank,saveButton,"Button 3D");
	rank++;

	for(int i = 0 ; i < NUM_BUTTON_FX_FILTER ; i++) {
		midi_button(button_fx_filter[i],rank,saveButton,"Button fx filter");
		rank++;
	}

	for(int i = 0 ; i < NUM_BUTTON_FX_MIX ; i++) {
		midi_button(button_fx_mix[i],rank,saveButton,"Button fx mix");
		rank++;
	}

	midi_button(button_light_ambient,rank,saveButton,"Button light ambient");
	rank++;
	midi_button(button_light_ambient_action,rank,saveButton,"Button light ambient");
	rank++;
	midi_button(button_light_1,rank,saveButton,"Button light 1");
	rank++;
	midi_button(button_light_1_action,rank,saveButton,"Button light 1");
	rank++;
	midi_button(button_light_2,rank,saveButton,"Button light 2");
	rank++;
	midi_button(button_light_2_action,rank,saveButton,"Button light 2");
	rank++; 
	for(int i = 0 ; i < NUM_BUTTON_TRANSIENT ; i++) {
		midi_button(button_transient[i],rank,saveButton,"Button transient");
		rank++;
	}

	
	for(int i = 0 ; i <= NUM_ITEM ; i++) {
		if(i == 0) {
			// the first fourth button is unused for the this time
		} else {
			rank = 0;
			midi_button(button_item[posRankButton(i,rank)], posRankButton(i,rank), saveButton,"Button item"); 
			rank++;
			midi_button(button_item[posRankButton(i,rank)], posRankButton(i,rank), saveButton,"Button item"); 
			rank++;
			midi_button(button_item[posRankButton(i,rank)], posRankButton(i,rank), saveButton,"Button item"); 
			rank++;
			midi_button(button_item[posRankButton(i,rank)], posRankButton(i,rank), saveButton,"Button item");
		}
	}
}


int posRankButton(int pos, int rank) {
	return pos* BUTTON_ITEM_CONSOLE + rank;
}



/**
Here it's real midi stuff
*/
void midi_button(Button b, int id, boolean saveButton, String type) {
	setting_midi_button(b);
	update_midi_button(b);
	if(saveButton) {
		set_data_button(id, b.get_id_midi(),b.is(),type);
	}
}

void setting_midi_button(Button b) {
	if(select_midi_is) {
		if(reset_midi_selection) {
			b.set_id_midi(-2);
		} else if (b.inside && mousePressed) {
			b.set_id_midi(midi_CC_romanesco);  
		}  
	}
}


boolean midi_update_button = true;
void update_midi_button(Button b) {
	if(midi_value_romanesco == 127 && midi_CC_romanesco == b.get_id_midi() && midi_update_button) {
		b.switch_is();
		midi_update_button = false;
	}

	if(midi_value_romanesco == 0) {
		midi_update_button = true;
	} 
}














//give which button is active and check is this button have a same ID midi that Item
int ref_value_midi = 0;
void update_midi_slider(Slider slider, Cropinfo[] cropinfo) {
	if (midi_CC_romanesco == slider.get_id_midi() && ref_value_midi != midi_value_romanesco) {
		ref_value_midi = midi_value_romanesco;
		slider.update_midi(midi_value_romanesco);
	}

	if(select_midi_is) {
		if(reset_midi_selection) {
			for(int i = 0 ; i < cropinfo.length ; i++) {
				if(slider.get_id() == cropinfo[slider.get_id()].get_id()) {
					cropinfo[i].set_id_midi(-2);
				}
			}
			slider.set_id_midi(-2);
		} else if(slider.molette_used_is()) {
			cropinfo[slider.get_id()].set_id_midi(midi_CC_romanesco);
			slider.set_id_midi(midi_CC_romanesco);
		}
	}
	//ID midi from save
	if(LOAD_SETTING) {
		int index = slider.get_id();
		slider.set_id_midi(cropinfo[index].get_id_midi());
	}
}



