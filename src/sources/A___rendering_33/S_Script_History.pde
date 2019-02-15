/**
* History manage class Script
2018-2018
v 0.0.1
*/
public class History {
  private ArrayList<Script>history;
  private int max = 1;

  public History() {
    history = new ArrayList<Script>();
  }

  public History(int max) {
    this.max = max;
    history = new ArrayList<Script>();
  }

  public void set_max(int max) {
    this.max = max;
  }

  public int size() {
    return history.size();
  }

  public void clear() {
    history.clear();
  }

  public void remove(int target) {
    if(target >= 0 && target < history.size()) {
      history.remove(target);
    }
  }

  public void add(Script script) {
    history.add(script);
    if(history.size() > max) history.remove(0);
  }

  public ArrayList<Script> get() {
    return history;
  }

  public Script get(int target) {
    target = history.size() - target -1;
    if(target < 0) target = 0;
    return history.get(target);
  }
}