/**
* CROPE BAR
* Control ROmanesco Processing Environment
* v 0.2.4
* Copyleft (c) 2019-2019
* Processing 3.5.3
* Rope library 0.5.1
* @author @stanlepunk
* @see https://github.com/StanLepunK/Crope
*/
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;

import javax.swing.JFrame;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.KeyStroke;
import javax.swing.JCheckBoxMenuItem;

import java.lang.reflect.Method;
import java.lang.reflect.InvocationTargetException;

import java.util.Arrays;

public class Crope_Bar {
	PApplet app;
	JSONObject json;
	JFrame frame;
	JMenuBar menu_bar;
  boolean you_can_build = false;
  int id_menu_item = 0;
  final String [] action_name = new String[500];
	public Crope_Bar(PApplet app) {
		this.app = app;

		if(get_renderer().equals("processing.awt.PGraphicsJava2D")) {
			you_can_build = true;
		} else {
      // com.jogamp.newt.opengl.GLWindow glw = (com.jogamp.newt.opengl.GLWindow)app.getSurface().getNative();
			printErr("Use class Crope_Bar with",get_renderer(),"is not possible. change your renderer to JAVA2D");
		}


		if(you_can_build) {
			if(get_os_family().equals("mac")) {
				System.setProperty("apple.laf.useScreenMenuBar","true");
			}
			frame = (JFrame) ((processing.awt.PSurfaceAWT.SmoothCanvas)app.getSurface().getNative()).getFrame();
			menu_bar = new JMenuBar();
			frame.setJMenuBar(menu_bar);
		}
	}

  ArrayList<C_Menu_Item> menu_item_list = new ArrayList<C_Menu_Item>();
	public void set(JSONObject json) {
		this.json = json;
		if(you_can_build) {
			menu_item_list.clear();
			build();
			set_listener();
		}
	}

	private void build() {
		String [] data = split(json.getString("menu bar"),",");
		JMenu [] menu = new JMenu [data.length];
		id_menu_item = 0;
		for(int i = 0 ; i < data.length ; i++) {
			if(json.getJSONObject(data[i]) != null) {
				String[] content = json.getJSONObject(data[i]).getString("menu").split(",");
				menu[i] = new JMenu(data[i]); // prompt
				menu_bar.add(menu[i]);
				set_menu_item(data[i],menu[i],content);
			} else {
				printErr("class Crope_Bar method build() menu item:",data[i],"is not found return",json.getJSONObject(data[i]));
			}
		}
	}

	private void set_menu_item(String title_prompt, JMenu j_menu, String [] content) {
		for(int i = 0 ; i < content.length ; i++) {
			if(content[i].equals("|")) {
				j_menu.addSeparator();
			} else {
				if(content[i].endsWith("+")) {
					String prompt = content[i].substring(0,content[i].length()-1);
					
					JMenu sub_menu_item = new JMenu(prompt); // prompt
					j_menu.add(sub_menu_item);

					String [] sub_content = json.getJSONObject(title_prompt).getString(prompt).split(",");
					add_sub_menu_item(sub_menu_item, sub_content);
				} else {
					add_menu_item(j_menu,content[i]);
				}				
			}
		}
	}


	void add_menu_item(JMenu j_menu, String info) {
		id_menu_item++;
		String content [] = split(info,'>');
		String name_item = content[0];
		if(name_item.endsWith("?")) {
			name_item = name_item.substring(0,name_item.length()-1);
			if(name_item.endsWith("!")) {
				name_item = name_item.substring(0,name_item.length()-1);
			}
			
		}
		JMenuItem menu_item = new JMenuItem(name_item); // prompt
		if(content.length > 1) {
			String [] info_key_event = Arrays.copyOfRange(content, content.length-(content.length-1), content.length);
			set_accelarator(menu_item,info_key_event);
		}
		// create check box item if necessary
		if(content[0].endsWith("?")) {
			menu_item = new JCheckBoxMenuItem(name_item);
			if(content[0].endsWith("!?")) {
				menu_item.setSelected(true);
			}
		}
		
		j_menu.add(menu_item);
		action_name[id_menu_item] = name_item;
		C_Menu_Item cmi = new C_Menu_Item(name_item,id_menu_item,menu_item);
		menu_item_list.add(cmi);
	}




	void set_accelarator(JMenuItem j_menu_item, String [] info) {
    char ke = (char)-1;
    int ae_0 = -1;
    int ae_1 = -1;
    int ae_2 = -1;
		if(info.length == 1) {
			ke = key_translate(info[0]);  
			if(ke != -1) {
				j_menu_item.setAccelerator(KeyStroke.getKeyStroke(ke));
			} else {
				printErr("class Crope_Bar method set_accelerator():");
				if(ke == -1) printErr("keyEvent", info[0]);
			}
		} else if (info.length == 2) {
			ke = key_translate(info[0]);
			ae_0 = action_translate(info[1]);
			if(ke != -1 && ae_0 != -1) {
				j_menu_item.setAccelerator(KeyStroke.getKeyStroke(ke,ae_0));
			} else {
				printErr("class Crope_Bar method set_accelerator():");
				if(ke == -1) printErr("keyEvent problem:", info[0]);
				if(ae_0 == -1) printErr("ActionEvent problem:", info[1]);
			}
		} else if (info.length == 3) {
			ke = key_translate(info[0]);
			ae_0 = action_translate(info[1]);
			ae_1 = action_translate(info[2]);
			if(ke != -1 && ae_0 != -1 && ae_1 != -1) {
				j_menu_item.setAccelerator(KeyStroke.getKeyStroke(ke, ae_0 | ae_1));
			} else {
				printErr("class Crope_Bar method set_accelerator():");
				if(ke == -1) printErr("keyEvent problem:", info[0]);
				if(ae_0 == -1) printErr("ActionEvent problem:", info[1]);
				if(ae_1 == -1) printErr("ActionEvent problem:", info[2]);
			}
		} else if (info.length == 4) {
			ke = key_translate(info[0]);
			ae_0 = action_translate(info[1]);
			ae_1 = action_translate(info[2]);
			ae_2 = action_translate(info[3]);
			if(ke != -1 && ae_0 != -1 && ae_1 != -1 && ae_2 != -1) {
				j_menu_item.setAccelerator(KeyStroke.getKeyStroke(ke, ae_0 | ae_1 | ae_2));
			} else {
				printErr("class Crope_Bar method set_accelerator():");
				if(ke == -1) printErr("keyEvent problem:", info[0]);
				if(ae_0 == -1) printErr("ActionEvent problem:", info[1]);
				if(ae_1 == -1) printErr("ActionEvent problem:", info[2]);
				if(ae_2 == -1) printErr("ActionEvent problem:", info[3]);
			}
		}
				
		// return j_menu_item;
	}

	int action_translate(String s) {
		s = s.toLowerCase();
		if(s.equals("alt")) return ActionEvent.ALT_MASK;
		else if(s.equals("cmd")) return ActionEvent.META_MASK;
		else if(s.equals("meta")) return ActionEvent.META_MASK;
		else if(s.equals("ctrl")) return ActionEvent.CTRL_MASK;
		else if(s.equals("shift")) return ActionEvent.SHIFT_MASK;
		else return -1;
	}



	char key_translate(String s) { 
		s = s.toLowerCase();
		if(s.equals("a")) return KeyEvent.VK_A;
		else if(s.equals("b")) return KeyEvent.VK_B;
		else if(s.equals("c")) return KeyEvent.VK_C;
		else if(s.equals("d")) return KeyEvent.VK_D;
		else if(s.equals("e")) return KeyEvent.VK_E;
		else if(s.equals("f")) return KeyEvent.VK_F;
		else if(s.equals("g")) return KeyEvent.VK_G;
		else if(s.equals("h")) return KeyEvent.VK_H;
		else if(s.equals("i")) return KeyEvent.VK_I;
		else if(s.equals("j")) return KeyEvent.VK_J;
		else if(s.equals("k")) return KeyEvent.VK_K;
		else if(s.equals("l")) return KeyEvent.VK_L;
		else if(s.equals("m")) return KeyEvent.VK_M;
		else if(s.equals("n")) return KeyEvent.VK_N;
		else if(s.equals("o")) return KeyEvent.VK_O;
		else if(s.equals("p")) return KeyEvent.VK_P;
		else if(s.equals("q")) return KeyEvent.VK_Q;
		else if(s.equals("r")) return KeyEvent.VK_R;
		else if(s.equals("s")) return KeyEvent.VK_S;
		else if(s.equals("t")) return KeyEvent.VK_T;
		else if(s.equals("u")) return KeyEvent.VK_U;
		else if(s.equals("v")) return KeyEvent.VK_V;
		else if(s.equals("w")) return KeyEvent.VK_W;
		else if(s.equals("x")) return KeyEvent.VK_X;
		else if(s.equals("y")) return KeyEvent.VK_Y;
		else if(s.equals("z")) return KeyEvent.VK_Z;

		else if(s.equals("0")) return KeyEvent.VK_0;
		else if(s.equals("1")) return KeyEvent.VK_1;
		else if(s.equals("2")) return KeyEvent.VK_2;
		else if(s.equals("3")) return KeyEvent.VK_3;
		else if(s.equals("4")) return KeyEvent.VK_4;
		else if(s.equals("5")) return KeyEvent.VK_5;
		else if(s.equals("6")) return KeyEvent.VK_6;
		else if(s.equals("7")) return KeyEvent.VK_7;
		else if(s.equals("8")) return KeyEvent.VK_8;
		else if(s.equals("9")) return KeyEvent.VK_9;

		else if(s.equals("f1")) return KeyEvent.VK_F1;
		else if(s.equals("f2")) return KeyEvent.VK_F2;
		else if(s.equals("f3")) return KeyEvent.VK_F3;
		else if(s.equals("f4")) return KeyEvent.VK_F4;
		else if(s.equals("f5")) return KeyEvent.VK_F5;
		else if(s.equals("f6")) return KeyEvent.VK_F6;
		else if(s.equals("f7")) return KeyEvent.VK_F7;
		else if(s.equals("f8")) return KeyEvent.VK_F8;
		else if(s.equals("f9")) return KeyEvent.VK_F9;
		else if(s.equals("f10")) return KeyEvent.VK_F10;
		else if(s.equals("f11")) return KeyEvent.VK_F11;
		else if(s.equals("f12")) return KeyEvent.VK_F12;
		else if(s.equals("f13")) return KeyEvent.VK_F13;
		else if(s.equals("f14")) return KeyEvent.VK_F14;
		else if(s.equals("f15")) return KeyEvent.VK_F15;
		else if(s.equals("f16")) return KeyEvent.VK_F16;
		else if(s.equals("f17")) return KeyEvent.VK_F17;
		else if(s.equals("f18")) return KeyEvent.VK_F18;
		else if(s.equals("f19")) return KeyEvent.VK_F19;
		else if(s.equals("f20")) return KeyEvent.VK_F20;
		else if(s.equals("f21")) return KeyEvent.VK_F21;
		else if(s.equals("f22")) return KeyEvent.VK_F22;
		else if(s.equals("f23")) return KeyEvent.VK_F23;
		else if(s.equals("f24")) return KeyEvent.VK_F24;

		else if(s.equals("+")) return KeyEvent.VK_PLUS;
		else if(s.equals("-")) return KeyEvent.VK_MINUS;
		else if(s.equals("/")) return KeyEvent.VK_SLASH;
		else if(s.equals("_")) return KeyEvent.VK_UNDERSCORE;
		else if(s.equals(":")) return KeyEvent.VK_COLON;
		else if(s.equals(";")) return KeyEvent.VK_SEMICOLON;
		else if(s.equals("=")) return KeyEvent.VK_EQUALS;
		else if(s.equals("@")) return KeyEvent.VK_AT;
		else if(s.equals("#")) return KeyEvent.VK_NUMBER_SIGN;
		else if(s.equals(".")) return KeyEvent.VK_PERIOD;

		else return (char)-1;
	}


  private void add_sub_menu_item(JMenu j_sub_menu, String [] content) {
		for(int i = 0 ; i < content.length ; i++) {
			add_menu_item(j_sub_menu,content[i]);
		}
	}


  // SET LISTENER
	private void set_listener() {
		if(menu_item_list.size() > 0) {
			for(C_Menu_Item cmi : menu_item_list) {
        final String which_action = action_name[cmi.get_id()];
				cmi.get_menu_item().addActionListener(new ActionListener() { 
					public void actionPerformed(ActionEvent ae) {
						what_happen_in_menu(which_action, ae);
					}
		    });
			}
		}
	}

	private class C_Menu_Item {
		protected int id = 0;
		protected String name;
		protected JMenuItem j_menu_item;
		C_Menu_Item(String name, int id, JMenuItem j_menu_item) {
			this.name = name;
			this.id = id;
			this.j_menu_item = j_menu_item;
		}

		protected String get_name() {
			return name;
		}

		protected int get_id() {
			return id;
		}

		protected JMenuItem get_menu_item() {
			return j_menu_item;
		}
	}
  
	public void show() {
		if(you_can_build) {
			frame.setVisible(true);
		}
	}
  
	public void help() {
		if(you_can_build) {
			println("\npass all menus in differents String to method set(JSONObject)");
			println("");
			println("MENU must have 'menu bar' for name");
			println("MENU must have a content separate by ','(coma)");
			println("for the separor use '|'(vertical bar) between two ','(coma)\n");
			println("");
			println("MENU ITEM finishing by '?'(interrogation) has a check box added");
			println("MENU ITEM finishing by '!?'(exclamation)(interrogation) the check box is selected");
			println("");
			println("MENU ITEM can be key responding\n to use syntax like that\nname>key>action_event, the word must be separate by '>'\nthe first term after the menu item name is the key, after you pass your action event");
			println("key available:\na,b,c...x,y,z\n0,1,2...\nf1,f2,...f25\n',',';','@','#','/','+','=','_','-'");
			println("action event available:\nshift,cmd,meta,ctrl and alt");
			println("");
			println("ELEMENT of MENU finishing by '+'(plus) can hava a submenu, to set create JSONObject where the name finish by'_'(underscore)");

			
		}
	}

	public JSONObject get_menu() {
		return json;
	}
}

