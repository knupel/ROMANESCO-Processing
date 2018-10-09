/**
ROPE - Romanesco processing environment – 
* Copyleft (c) 2014-2018
* Stan le Punk > http://stanlepunk.xyz/
ROPE core
v 0.0.5.0
2017-2018
* @author Stan le Punk
* @see https://github.com/StanLepunK/Rope
*/
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





ROPE r ;
/**
Something weird, now it's not necessary to use the method init_rope()
to use the interface Rope_constants...
that's cool but that's very weird !!!!!
*/
public void init_rope() {
	r = new ROPE() ;
	println("Init ROPE: Romanesco Processing Environment - 2015-2018");
}

public class ROPE implements Rope_Constants {
	//need to give an access to the Rope_Constants
}








/**
COLOR LIST class
v 0.0.1
*/
public class ROPE_color implements Rope_Constants {
	int [] c ;
	public ROPE_color(int... c) {
		this.c = new int[c.length];
		for(int i = 0; i < c.length ; i++) {
			this.c[i] = c[i];
		}
	}

	public int[] get_color() {
		return c;
	}

	float[] get_hue() {
		float[] component = new float[c.length];
		for(int i = 0 ; i < c.length ; i++) {
			component[i] = hue(c[i]);
		}
		return component;
	}

	public float[] get_saturation() {
		float[] component = new float[c.length];
		for(int i = 0 ; i < c.length ; i++) {
			component[i] = saturation(c[i]);
		}
		return component;
	}

	public float[] get_brightness() {
		float[] component = new float[c.length];
		for(int i = 0 ; i < c.length ; i++) {
			component[i] = brightness(c[i]);
		}
		return component;
	}

	public float[] get_red() {
		float[] component = new float[c.length];
		for(int i = 0 ; i < c.length ; i++) {
			component[i] = red(c[i]);
		}
		return component;
	}

	public float[] get_green() {
		float[] component = new float[c.length];
		for(int i = 0 ; i < c.length ; i++) {
			component[i] = green(c[i]);
		}
		return component;
	}

	public float[] get_blue() {
		float[] component = new float[c.length];
		for(int i = 0 ; i < c.length ; i++) {
			component[i] = blue(c[i]);
		}
		return component;
	}

	public float[] get_alpha() {
		float[] component = new float[c.length];
		for(int i = 0 ; i < c.length ; i++) {
			component[i] = blue(c[i]);
		}
		return component;
	}
}


