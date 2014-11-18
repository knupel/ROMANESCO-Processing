/**
 * Tablet
 * Tablet is a library for using pen tablets from Processing.
 * http://interfaze.info/libraries/tablet/
 *
 * Copyright (c) 2008-13 Andres Colubri http://interfaze.info/
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 * 
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General
 * Public License along with this library; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place, Suite 330,
 * Boston, MA  02111-1307  USA
 * 
 * @author      Andres Colubri http://interfaze.info/
 * @modified    09/02/2013
 * @version     1.0 (1)
 */

package codeanticode.tablet;

import processing.core.*;
import processing.opengl.PGL;
import processing.opengl.PGraphicsOpenGL;

import jpen.event.*;
import jpen.owner.multiAwt.AwtPenToolkit;
import jpen.*;

import java.lang.reflect.*;

/**
 * 
 * This class extends the PenListener class of the JPen library by adding getter
 * methods to retrieve the pen values (position, pressure, tilt, pressed
 * buttons, etc.). It also defines event methods that are called inside the
 * Processing sketch when tablet events such as pressure or position changes
 * occur. These methods are penButtonEventMethod, penKindEventMethod,
 * penLevelEventMethod and penScrollEventMethod, and always pass as parameter
 * the Tablet object generating the event:<br>
 * <br>
 * <quote>void penLevelEventMethod(Tablet tablet) {<br>
 * &nbsp;&nbsp;println(tablet.getPressure());<br>
 * }</quote><br>
 * <br>
 * However, these methods don't need to be implemented.<br>
 * <br>
 * For more details about the JPen library, check the <a
 * href="http://jpen.wiki.sourceforge.net/">JPen website</a>.
 * 
 * @author Andres Colubri
 * 
 */
public class Tablet implements PenListener {
  public final static String VERSION = "1.0";

  /**
   * Constant to identify an unknown pen kind.
   */
  public static final int UNDEFINED = 0;
  /**
   * Constant to identify the mouse.
   */
  public static final int CURSOR = 1;
  /**
   * Constant to identify the drawing tip of the pen.
   */
  public static final int STYLUS = 2;
  /**
   * Constant to identify the erasing tip of the pen.
   */
  public static final int ERASER = 3;
  
  protected PApplet parent;
  protected PenManager pm;
  
  
  protected Method penButtonEventMethod;
  protected Method penKindEventMethod;
  protected Method penLevelEventMethod;
  protected Method penScrollEventMethod;

  protected boolean isMovementEvent;
  
  protected boolean saveState;  
  final protected PenStateCopy savedPen;  
  
  /**
   * The class constructor that takes the parent Processing applet as parameter
   * to initialize the pen manager.
   * 
   * @param parent
   *          PApplet
   */
  public Tablet(PApplet parent) {
    this.parent = parent;

    welcome();
    
    if (parent.g instanceof PGraphicsOpenGL) {
      // Using parent with an OpenGL renderer results in no tablet events being
      // detected.
      AwtPenToolkit.addPenListener(PGL.canvas, this);  
    } else {
      AwtPenToolkit.addPenListener(parent, this);
    }
    pm = AwtPenToolkit.getPenManager();    
    savedPen = new PenStateCopy();

    try {
      penButtonEventMethod = parent.getClass().getMethod("penButtonEvent",
          new Class[] { Tablet.class });
    } catch (Exception e) {
      // no such method, or an error.. which is fine, just ignore
    }

    try {
      penKindEventMethod = parent.getClass().getMethod("penKindEvent",
          new Class[] { Tablet.class });
    } catch (Exception e) {
      // no such method, or an error.. which is fine, just ignore
    }

    try {
      penLevelEventMethod = parent.getClass().getMethod("penLevelEvent",
          new Class[] { Tablet.class });
    } catch (Exception e) {
      // no such method, or an error.. which is fine, just ignore
    }

    try {
      penScrollEventMethod = parent.getClass().getMethod("penScrollEvent",
          new Class[] { Tablet.class });
    } catch (Exception e) {
      // no such method, or an error.. which is fine, just ignore
    }
  }

  /**
   * Returns the current pressure.
   * 
   * @return float
   */
  public float getPressure() {
    return pm.pen.getLevelValue(PLevel.Type.PRESSURE);
  }

  /**
   * Returns the current X position of the pen.
   * 
   * @return float
   */
  public float getPenX() {
    return pm.pen.getLevelValue(PLevel.Type.X);
  }

  /**
   * Returns the current Y position of the pen.
   * 
   * @return float
   */
  public float getPenY() {
    return pm.pen.getLevelValue(PLevel.Type.Y);
  }

  /**
   * Returns the current X tilt of the pen.
   * 
   * @return float
   */
  public float getTiltX() {
    return pm.pen.getLevelValue(PLevel.Type.TILT_X);
  }

  /**
   * Returns the current Y tilt of the pen.
   * 
   * @return float
   */
  public float getTiltY() {
    return pm.pen.getLevelValue(PLevel.Type.TILT_Y);
  }

  /**
   * Barrel button or wheel. Range: 0 to 1 towards the pen tip.
   * 
   * @return float
   */
  public float getSidePressure() {
    return pm.pen.getLevelValue(PLevel.Type.SIDE_PRESSURE);
  }  

  /**
   * Returns pen rotation. Range: 0 to 2 * PI clockwise.
   * 
   * @return float
   */  
  public float getRotation() {
    return pm.pen.getLevelValue(PLevel.Type.ROTATION);
  }    
  
  /**
   * Returns the current x azimuth of the pen.
   * 
   * @return float
   */
  public float getAzimuth() {
    double tiltX = getTiltX();
    double tiltY = getTiltY();

    double[] out = new double[2];
    PLevel.Type.evalAzimuthXAndAltitude(out, tiltX, tiltY);
    return (float) out[0];
  }

  /**
   * Returns the current altitude of the pen.
   * 
   * @return float
   */
  public float getAltitude() {
    double tiltX = getTiltX();
    double tiltY = getTiltY();

    double[] out = new double[2];
    PLevel.Type.evalAzimuthXAndAltitude(out, tiltX, tiltY);
    return (float) out[1];
  }

  /**
   * Calculates the current x azimuth and altitude values and return them in the
   * azimuthXAndAltitude array.
   * 
   * @param azimuthXAndAltitude
   *          float[]
   */
  public void getAzimuthXAndAltitude(float[] azimuthXAndAltitude) {
    if ((azimuthXAndAltitude == null) || azimuthXAndAltitude.length != 2)
      return;
    double tiltX = getTiltX();
    double tiltY = getTiltY();

    double[] out = new double[2];
    PLevel.Type.evalAzimuthXAndAltitude(out, tiltX, tiltY);
    azimuthXAndAltitude[0] = (float) out[0];
    azimuthXAndAltitude[1] = (float) out[1];
  }

  /**
   * Returns true if a level event has occurred, meaning that a change in
   * pressure, position or tilt has been detected.
   * 
   * @return boolean
   */
  public boolean isMovement() {
    return isMovementEvent;
  }

  /**
   * Returns the current pen kind: CURSOR is the mouse, STYLUS is the drawing
   * tip of the pen and ERASER is the eraser tip of the pen.
   * 
   * @return int
   */
  public int getPenKind() {
    if (pm.pen.getKind() == PKind.valueOf(PKind.Type.CURSOR))
      return CURSOR;
    else if (pm.pen.getKind() == PKind.valueOf(PKind.Type.STYLUS))
      return STYLUS;
    else if (pm.pen.getKind() == PKind.valueOf(PKind.Type.ERASER))
      return ERASER;
    else
      return UNDEFINED;
  }

  /**
   * Returns true if there is any button being currently pressed.
   * 
   * @return boolean
   */
  public boolean isDown() {
    return pm.pen.hasPressedButtons();
  }

  /**
   * Returns true if there is the center button is currently pressed.
   * 
   * @return boolean
   */
  public boolean isCenterDown() {
    return pm.pen.getButtonValue(PButton.Type.CENTER);
  }

  /**
   * Returns true if there is the left button is currently pressed.
   * 
   * @return boolean
   */
  public boolean isLeftDown() {
    return pm.pen.getButtonValue(PButton.Type.LEFT);
  }

  /**
   * Returns true if there is the right button is currently pressed. When using
   * the stylus, pressing it agains the tablet surface is considered as a right
   * button click.
   * 
   * @return boolean
   */
  public boolean isRightDown() {
    return pm.pen.getButtonValue(PButton.Type.RIGHT);
  }

  /**
   * Saves the current state of the pen.
   */
  public void saveState() {
    savedPen.setValues(pm.pen);
  }

  /**
   * Returns the saved pressure.
   * 
   * @return float
   */
  public float getSavedPressure() {
    return savedPen.getLevelValue(PLevel.Type.PRESSURE);
  }

  /**
   * Returns the saved X position of the pen.
   * 
   * @return float
   */
  public float getSavedPenX() {
    return savedPen.getLevelValue(PLevel.Type.X);
  }

  /**
   * Returns the saved Y position of the pen.
   * 
   * @return float
   */
  public float getSavedPenY() {
    return savedPen.getLevelValue(PLevel.Type.Y);
  }

  /**
   * Returns the saved X tilt of the pen.
   * 
   * @return float
   */
  public float getSavedTiltX() {
    return savedPen.getLevelValue(PLevel.Type.TILT_X);
  }

  /**
   * Returns the saved side pressure.
   * 
   * @return float
   */
  public float getSavedSidePressure() {
    return pm.pen.getLevelValue(PLevel.Type.SIDE_PRESSURE);
  }  

  /**
   * Returns the saved rotation.
   * 
   * @return float
   */  
  public float getSavedRotation() {
    return pm.pen.getLevelValue(PLevel.Type.ROTATION);
  }      
    
  /**
   * Returns the saved Y tilt of the pen.
   * 
   * @return float
   */
  public float getSavedTiltY() {
    return savedPen.getLevelValue(PLevel.Type.TILT_Y);
  }

  /**
   * Returns the saved x azimuth of the pen.
   * 
   * @return float
   */
  public float getSavedAzimuth() {
    double tiltX = getSavedTiltX();
    double tiltY = getSavedTiltY();

    double[] out = new double[2];
    PLevel.Type.evalAzimuthXAndAltitude(out, tiltX, tiltY);
    return (float) out[0];
  }

  /**
   * Returns the saved altitude of the pen.
   * 
   * @return float
   */
  public float getSavedAltitude() {
    double tiltX = getSavedTiltX();
    double tiltY = getSavedTiltY();

    double[] out = new double[2];
    PLevel.Type.evalAzimuthXAndAltitude(out, tiltX, tiltY);
    return (float) out[1];
  }

  /**
   * Calculates the x azimuth and altitude values using the saved tablet state
   * and return them in the azimuthXAndAltitude array.
   * 
   * @param azimuthXAndAltitude
   *          float[]
   */
  public void getSavedAzimuthXAndAltitude(float[] azimuthXAndAltitude) {
    if ((azimuthXAndAltitude == null) || azimuthXAndAltitude.length != 2)
      return;
    double tiltX = getSavedTiltX();
    double tiltY = getSavedTiltY();

    double[] out = new double[2];
    PLevel.Type.evalAzimuthXAndAltitude(out, tiltX, tiltY);
    azimuthXAndAltitude[0] = (float) out[0];
    azimuthXAndAltitude[1] = (float) out[1];
  }

  /**
   * Invokes penButtonEventMethod in the Processing applet (if exists) when a
   * button event occurs.
   * 
   * @param ev
   *          PButtonEvent
   */
  public void penButtonEvent(PButtonEvent ev) {
    if (penButtonEventMethod != null) {
      try {
        penButtonEventMethod.invoke(parent, new Object[] { this });
      } catch (Exception e) {
        System.err.println("error, disabling penButtonEvent()");
        e.printStackTrace();
        penButtonEventMethod = null;
      }
    }
  }

  /**
   * Invokes penKindEventMethod in the Processing applet (if exists) when a kind
   * event occurs.
   * 
   * @param ev
   *          PKindEvent
   */
  public void penKindEvent(PKindEvent ev) {
    if (penKindEventMethod != null) {
      try {
        penKindEventMethod.invoke(parent, new Object[] { this });
      } catch (Exception e) {
        System.err.println("error, disabling penKindEvent()");
        e.printStackTrace();
        penKindEventMethod = null;
      }
    }
  }

  /**
   * Invokes penLevelEventMethod in the Processing applet (if exists) when a
   * level event occurs.
   * 
   * @param ev
   *          PLevelEvent
   */
  public void penLevelEvent(PLevelEvent ev) {
    isMovementEvent = ev.isMovement();

    if (penLevelEventMethod != null) {
      try {
        penLevelEventMethod.invoke(parent, new Object[] { this });
      } catch (Exception e) {
        System.err.println("error, disabling penLevelEvent()");
        e.printStackTrace();
        penLevelEventMethod = null;
      }
    }
  }

  /**
   * Invokes penScrollEventMethod in the Processing applet (if exists) when a
   * scroll event occurs.
   * 
   * @param ev
   *          PScrollEvent
   */
  public void penScrollEvent(PScrollEvent ev) {
    if (penScrollEventMethod != null) {
      try {
        penScrollEventMethod.invoke(parent, new Object[] { this });
      } catch (Exception e) {
        System.err.println("error, disabling penScrollEvent()");
        e.printStackTrace();
        penScrollEventMethod = null;
      }
    }
  }

  public void penTock(long availableMillis) {
  }
  
  private void welcome() {
    System.out.println("Tablet 1.0 by Andres Colubri http://interfaze.info/");
  }
}
