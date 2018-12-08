/**
ROPE - Romanesco processing environment – 
* Copyleft (c) 2014-2018
* Stan le Punk
* https://github.com/StanLepunK
* http://stanlepunk.xyz/
*/
Varom varom_1, varom_2 = new Varom();
void setup() {
  println(varom_1.max());
  /*
  varom = new Varom(0.5,0,1,10,20);
  println("raw",varom.raw());
  println("result",varom.get());
  println("min",varom.min());
  println("max",varom.max());
  */
  
  // println("clone num:",varom.get_clone_length());

}

/**
Varom
V 0.0.3
2018-2018
*/
public class Varom {
  private float raw = 0;
  private float min = 0;
  private float max = 1;
  private float min_raw = 0;
  private float max_raw = 0;
  private float result;

  public Varom() {}


  public Varom(float raw, float min_raw, float max_raw, float min, float max) {
    set_min(min);
    set_max(max);
    set_min_raw(min_raw);
    set_max_raw(max_raw);
    set_raw(raw);
  }




  /**
  get
  */
  public float raw() {
    return raw;
  }

  public float get() {
    return result;
  }

  public float min() {
    return min;
  }

  public float max() {
    return max;
  }

  public float min_raw() {
    return min_raw;
  }

  public float max_raw() {
    return max_raw;
  }
  
  /**
  set
  */
  public void set_raw(float raw) {
    this.raw = raw;
    result = map(this.raw,min_raw,max_raw,min,max);
  }

  public void set_min(float min) {
    this.min = min;
  }

  public void set_max(float max) {
    this.max = max;
  }

  public void set_min_raw(float min_raw) {
    this.min_raw = min_raw;
  }

  public void set_max_raw(float max_raw) {
    this.max_raw = max_raw;
  }
}













