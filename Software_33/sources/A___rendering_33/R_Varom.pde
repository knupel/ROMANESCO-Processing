/**
Varom
V 0.0.5
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
    set(raw);
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
  public void set(float raw) {
    set(raw,0,0);
  }

  public void set(float raw, int begin, int end) {
    this.raw = raw;
    if(begin == 0 && end == 0) {
      result = map(this.raw,min_raw,max_raw,min,max);
    } else {
       result = map(this.raw,min_raw,max_raw,min,max,begin,end);
    }
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