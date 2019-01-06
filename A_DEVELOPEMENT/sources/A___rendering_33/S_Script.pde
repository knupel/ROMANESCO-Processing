/**
Script
v 0.0.3
2018-2018
*/
import java.util.Date;
import java.sql.Timestamp;

public class Script {
  ArrayList <ArrayList> data_list;

  ArrayList <Data_boolean> data_boolean;
  ArrayList <Data_int> data_int;
  ArrayList <Data_float> data_float;
  ArrayList <Data_long> data_long;
  ArrayList <Data_String> data_String;
  ArrayList <Data_iVec> data_iVec;
  ArrayList <Data_Vec> data_Vec;


  long time_millis;
  Timestamp timestamp;
  public Script(){
    time_millis = new Date().getTime();
    timestamp = new Timestamp(time_millis);
    data_list = new ArrayList<ArrayList>();

    data_boolean = new ArrayList<Data_boolean>();
    data_int = new ArrayList<Data_int>();
    data_float = new ArrayList<Data_float>();
    data_long = new ArrayList<Data_long>();
    data_String = new ArrayList<Data_String>();
    data_iVec = new ArrayList<Data_iVec>();
    data_Vec = new ArrayList<Data_Vec>();

    data_list.add(data_boolean);
    data_list.add(data_int);
    data_list.add(data_float);
    data_list.add(data_long);
    data_list.add(data_String);
    data_list.add(data_iVec);
    data_list.add(data_Vec);


  }



  /**
  get data
  */
    /**
  get
  */
  public String get_timestamp() {
    String s = ""+timestamp;
    return s;
  }

  public long get_time() {
    return time_millis;
  }

  public Object get(String name, String family) {
    
    Object result = null ;
    for(ArrayList list : data_list) {
      if(list != null) {
        for(Object obj : list) {
          boolean is = false;
          if(obj instanceof Data) {
            Data d = (Data)obj;
            if(d.get_name().equals(name) && d.get_family().equals(family)) {
              is = true;
            }
          }

          //
          if(obj instanceof Data_boolean) {
            Data_boolean d = (Data_boolean)obj;
            if(is) {
              result = d.get();
              break;
            }
          } else if(obj instanceof Data_int) {
            Data_int d = (Data_int)obj;
            if(is) {
              result = d.get();
              break;
            }
          } else if(obj instanceof Data_float) {
            Data_float d = (Data_float)obj;
            if(is) {
              result = d.get();
              break;
            }
          } else if(obj instanceof Data_long) {
            Data_long d = (Data_long)obj;
            if(is) {
              result = d.get();
              break;
            }
          } else if(obj instanceof Data_String) {
            Data_String d = (Data_String)obj;
            if(is) {
              result = d.get();
              break;
            }
          } else if(obj instanceof Data_iVec) {
            Data_iVec d = (Data_iVec)obj;
            if(is) {
              result = d.get();
              break;
            }
          } else if(obj instanceof Data_Vec) {
            Data_Vec d = (Data_Vec)obj;
            if(is) {
              result = d.get();
              break;
            }
          } else {
            break;
          }
        }
      }
    }
    return result;
  }


  

  /**
  add part
  */
  public void add(Object arg) {
    add("nobody","unknow",arg);
  }

  public void add(String name, Object arg) {
    add(name,"unknow",arg);
  }

  public void add(String name, String family, Object arg) {
    if(arg instanceof Boolean) add_boolean(name,family,(boolean)arg);
    else if(arg instanceof Float) add_float(name,family,(float)arg);
    else if(arg instanceof Integer) add_int(name,family,(int)arg);
    else if(arg instanceof Long) add_long(name,family,(long)arg);
    else if(arg instanceof String) add_String(name,family,(String)arg);
    else if(arg instanceof iVec) add_iVec(name,family,(iVec)arg);
    else if(arg instanceof Vec) add_Vec(name,family,(Vec)arg);
  }
  
  public void add(Object... f) {
    for(int i = 0 ; i < f.length ; i++) {
      add("nobody",f[i]);
    }
  }

  private void add_boolean(String name, String family, boolean arg) {
    Data_boolean data = new Data_boolean(arg);
    data.set_name(name);
    data.set_family(family);
    data_list.get(0).add(data);
  }
  private void add_int(String name, String family, int arg) {
    Data_int data = new Data_int(arg);
    data.set_name(name);
    data.set_family(family);
    data_list.get(1).add(data);
  }

  private void add_float(String name, String family, float arg) {
    Data_float data = new Data_float(arg);
    data.set_name(name);
    data.set_family(family);
    data_list.get(2).add(data);
  }

  private void add_long(String name, String family, long arg) {
    Data_long data = new Data_long(arg);
    data.set_name(name);
    data.set_family(family);
    data_list.get(3).add(data);
  }

  private void add_String(String name, String family, String arg) {
    Data_String data = new Data_String(arg);
    data.set_name(name);
    data.set_family(family);
    data_list.get(4).add(data);
  }

  private void add_iVec(String name, String family, iVec arg) {
    Data_iVec data = new Data_iVec(arg);
    data.set_name(name);
    data.set_family(family);
    data_list.get(5).add(data);
  }
  
  private void add_Vec(String name, String family, Vec arg) {
    Data_Vec data = new Data_Vec(arg);
    data.set_name(name);
    data.set_family(family);
    data_list.get(6).add(data);
  }

  /**
  class DATA
  */
  private abstract class Data {
    private String name;
    private String family;



    public void set_name(String name) {
      this.name = name;
    }

    public void set_family(String family) {
      this.family = family;
    }

    public String get_name() {
      return name;
    }

    public String get_family() {
      return family;
    }
  }
  
  private class Data_boolean extends Data {
    private boolean arg;
    private Data_boolean(boolean arg) {
      super();
      this.arg = arg;
    }
    protected boolean get() {
      return arg;
    }
  }

  private class Data_int extends Data {
    private int arg;
    private Data_int(int arg) {
      super();
      this.arg = arg;
    }
    protected int get() {
      return arg;
    }
  }

  private class Data_float extends Data {
    private float arg;
    private Data_float(float arg) {
      super();
      this.arg = arg;
    }

    protected float get() {
      return arg;
    }
  }

  private class Data_long extends Data {
    private long arg;
    private Data_long(long arg) {
      super();
      this.arg = arg;
    }

    protected long get() {
      return arg;
    }
  }

  private class Data_String extends Data {
    private String arg;
    private Data_String(String arg) {
      super();
      this.arg = arg;
    }

    protected String get() {
      return arg;
    }
  }

  private class Data_iVec extends Data {
    private iVec arg;
    private Data_iVec( iVec arg) {
      super();
      if(arg instanceof iVec2) {
        this.arg = ((iVec2)arg).copy();
      } else if(arg instanceof iVec3) {
        this.arg = ((iVec3)arg).copy();
      } else if(arg instanceof iVec4) {
        this.arg = ((iVec4)arg).copy();
      } else if(arg instanceof iVec5) {
        this.arg = ((iVec5)arg).copy();      
      } else if(arg instanceof iVec6) {
        this.arg = ((iVec6)arg).copy();
      }
    }

    protected iVec get() {
      return arg;
    }
  }


  private class Data_Vec extends Data {
    private Vec arg;
    private Data_Vec(Vec arg) {
      super();
      //this.arg = Vec(arg);
      if(arg instanceof Vec2) {
        this.arg = ((Vec2)arg).copy();
      } else if(arg instanceof Vec3) {
        this.arg = ((Vec3)arg).copy();
      } else if(arg instanceof Vec4) {
        this.arg = ((Vec4)arg).copy();
      } else if(arg instanceof Vec5) {
        this.arg = ((Vec5)arg).copy();        
      } else if(arg instanceof Vec6) {
        this.arg = ((Vec6)arg).copy();
      }
    }

    protected Vec get() {
      return arg;
    }
  }
}