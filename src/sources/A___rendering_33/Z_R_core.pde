/**
* ROPE FRAMEWORK - Romanesco processing environment – 
* Copyleft (c) 2014-2021
* @author @stanlepunk
* @see https://github.com/StanLepunK/Rope_framework
* ROPE core
* v 0.2.1.4
*/
import rope.core.*;
import rope.vector.*;
import rope.image.R_Pattern;

import java.util.Arrays;
import java.util.Iterator;
import java.util.Random;

import java.awt.image.BufferedImage;

import java.awt.Color;
import java.awt.Font; 
import java.awt.image.BufferedImage ;
import java.awt.FontMetrics;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;

import javax.imageio.ImageIO;
import javax.imageio.IIOImage;
import javax.imageio.ImageWriter;
import javax.imageio.ImageWriteParam;
import javax.imageio.metadata.IIOMetadata;

import java.lang.reflect.Field;

import java.awt.Graphics;
import java.awt.GraphicsEnvironment;
import java.awt.GraphicsDevice;
import java.awt.Rectangle;








/**
Something weird, now it's not necessary to use the method init_rope()
to use the interface Rope_constants...
that's cool but that's very weird !!!!!
*/
Rope r;

String rope_framework_version = "1.4.3.81";
public void rope_version() {
	r = new Rope();
	println("Romanesco Processing Environment - 2015-2021");
	println("Processing: 3.5.4.270");
	println("Rope library: " +r.VERSION);
  println("Rope framework: " + rope_framework_version);
}






/**
event
v 0.0.2
*/
vec2 scroll_event;
public void scroll(MouseEvent e) {
	float scroll_x = e.getCount();
	float scroll_y = e.getCount();
	if(scroll_event == null) {
		scroll_event = vec2(scroll_x,scroll_y);
	} else {
		scroll_event.set(scroll_x,scroll_y);
	}
}


public vec2 get_scroll() {
	if(scroll_event == null) {
		scroll_event = vec2();
		return scroll_event;
	} else {
		return scroll_event;
	}
}


// add for the future
// https://www.javaexamples.org/java/java.awt.event/mousewheelmoved-in-mousewheellistener.html
// import java.awt.event.MouseWheelEvent;
// import java.awt.event.MouseWheelListener;
// void mouseWheelMoved(MouseWheelEvent e) {
//   println(e.getWheelRotation());
//   println(e.getScrollType());
//   println(MouseWheelEvent.WHEEL_UNIT_SCROLL);
//   println(e.getScrollAmount());
//   println(e.getUnitsToScroll());
// }

