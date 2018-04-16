/**
ROPE - Romanesco processing environment – 
* Copyleft (c) 2014-2017 
* Stan le Punk > http://stanlepunk.xyz/
ROPE core
v 0.0.4.1
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


