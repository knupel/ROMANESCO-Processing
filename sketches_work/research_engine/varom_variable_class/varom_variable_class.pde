/**
ROPE - Romanesco processing environment – 
* Copyleft (c) 2014-2018
* Stan le Punk
* https://github.com/StanLepunK
* http://stanlepunk.xyz/
*/
Varom varom ;
void setup() {
  varom = Varom();
  
  // println("clone num:",varom.get_clone_length());
  varom.range(-2,2);
  varom.gui(3,0,10);
  /*
    varom.min(2);
  varom.max(5);  
  */

  varom.temp();

  // varom.me(10);
  varom.name("WARUM");

  // from gui

  // main arg
  println("varom name:",varom.name,"raw:",varom.raw,"temp:",varom.temp,"min-max:",varom.min,varom.max);

  // clone part
  varom.cloning(6);
  int target = 3;
  varom.set_clone(varom.temp,target);
  float f = (float)varom.get_clone(target);
  println("value clone:",target,f);

  println("clone list");
  printArray(varom.get_clone());

  println("clone list type");
  println("clone:",target,get_type(varom.get_clone(target)));
  println("clone type:",1,varom.get_clone_type(1));
  
  for(int i = 0 ; i < varom.get_clone_length() ; i++) {
    println("clone type:",i,varom.get_clone_type(i));
  }
}






Varom Varom() {
  return new Varom();
}



public class Varom {
  // Object me;
  // Object gui; // here the value storing is from controller

  Object raw;
  Object temp;
/*
  float min = MIN_FLOAT;
  float max = MAX_FLOAT;
  */
  float min = 0;
  float max = 1;

  Clone [] clone;
  String name = null;

  public Varom() {}

  public void cloning(int num) {
    clone = new Clone[num];
    for(int i = 0 ; i < clone.length ; i++) {
      clone[i] = new Clone(null);
    }
  }

  public void set_clone(Object arg, int target) {
    if(target < clone.length) {
      if(clone[target] == null) {
        clone[target] = new Clone(arg);
      } else {
        clone[target].arg = arg;
      }    
    }
  }



  public Object get_clone(int target) {
  	if(clone != null && target >= 0 && target < clone.length) {
  		return clone[target].arg;
  	} else return null;
  }

  public Object [] get_clone() {
    if(clone != null) {
      return clone;
    } else return null;
  }
  

  public String get_clone_type(int target) {
    if(clone != null && target >= 0 && target < clone.length) {
      return get_type(clone[target].arg);
    } else return null;
  }
  
  public String [] get_clone_type() {
    if(clone != null) {
      String [] type = new String[clone.length];
      for(int i = 0 ; i < clone.length ; i++) {
        type[i] = get_clone_type(i);
        
      }
      return type;
      
    } else return null;
  }
  
  


  public int get_clone_length() {
  	if(clone != null) {
  		return clone.length;
  	} else return -1;
  }
  
/*
  private void me(Object me) {
    if(me instanceof Float) {
      this.me = constrain_float((float)me);
    } else if(me instanceof Integer) {
      this.me = constrain_int((int)me);
    } else {
      this.me = me;
    } 
  }
  */




/*
  public void gui(Object gui_value) {
    if(gui_value instanceof Float) {
      // this.gui = constrain_float((float)gui_value);
    } else if(gui_value instanceof Integer) {
      // this.gui = constrain_int((int)gui_value);
    } else if(gui_value instanceof Boolean) {
      // this.gui = constrain_int((int)gui_value);
    } else {
      // this.gui = gui_value;
    }
  }
  */

  public void gui(Object gui_value, float min_gui, float max_gui) {
    gui(gui_value,min_gui,max_gui,0);
  }


  public void gui(Object gui_value, float min_gui, float max_gui, int smooth) {
    if(gui_value instanceof Float || gui_value instanceof Integer) {
      float val = 0;
      if(gui_value instanceof Float) {
        val = (float)gui_value;
      } else {
        val = (int)gui_value;
      }
      if(smooth <= 0) {
        println("gui map:",val,min_gui,max_gui,min,max);
        this.raw = map(val,min_gui,max_gui,min,max);
      } else {
        this.raw = map_smooth_start(val,min_gui,max_gui,min,max,smooth);
      }
    } /*else if(gui_value instanceof Integer) {
      if(smooth <= 0) {
        this.raw = (int)map((int)gui_value,min_gui,max_gui,min,max);
      } else {
        this.raw = (int)map_smooth_start((int)gui_value,min_gui,max_gui,min,max,smooth);
      }
    }*/ else {
      this.raw = gui_value;
    } 
  }
  
/*
  public void raw(Object raw) {
    if(raw instanceof Float) {
      this.raw = constrain_float((float)raw);
    } else if(raw instanceof Integer) {
      this.raw = constrain_int((int)raw);
    } else {
      this.raw = raw;
    }
  }
*/

  public void temp() {
    this.temp = raw;
    
  }

  // min max value
  public void range(float min,float max) {
    this.min = min;
    this.max = max;
  }


  public void min(float min) {
    this.min = min;
  }

  public void max(float max) {
    this.max = max;
  }



  public void name(String name) {
    this.name = name;
  }


  private float constrain_float(float value) {
    if(value < min ) {
      value = min;
    } else if(value > max) {
      value = max;
    }
    return value;
  }

  private int constrain_int(int value) {
    if(value < (int)min ) {
      value = (int)min;
    } else if(value > (int)max) {
      value = (int)max;
    }
    return value;
  }
  
  // Clone
  private class Clone {
    Object arg;
    Clone(Object arg) {
      this.arg = arg;
    }
  }
}






