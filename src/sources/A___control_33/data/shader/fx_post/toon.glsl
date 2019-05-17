/**
* TOON from https://www.geeks3d.com
* @see @stanlepunkLepunK/Shader
v 0.0.4
2018-2019
*/

/**
DONT WORK
*/

#ifdef GL_ES
precision highp float;
#endif
// Processing implementation
#define PROCESSING_TEXTURE_SHADER
// uniform vec2 texOffset; // from Processing core don't to pass in sketch vector (1/width, 1/height)
varying vec4 vertColor;
varying vec4 vertTexCoord;

// #version 150

uniform sampler2D texture_source;
uniform vec2 resolution_source;
uniform ivec2 flip_source;
uniform vec2 offset; // 0.5
// in vec4 Vertex_UV;


uniform float edge_thres; // 0.2;
uniform float edge_thres2; // 5.0;

#define HueLevCount 6
#define SatLevCount 7
#define ValLevCount 4



// UTIL TEMPLATE
vec2 set_uv(int flip_vertical, int flip_horizontal, vec2 res) {
  vec2 uv;
  if(all(equal(vec2(0),res))) {
    uv = vertTexCoord.st;
  } else if(all(greaterThan(res,vertTexCoord.st))) {
    uv = vertTexCoord.st;
  } else {
    uv = res;
  }
  // flip 
  float condition_y = step(0.1, flip_vertical);
  uv.y = 1.0 -(uv.y *condition_y +(1.0 -uv.y) *(1.0 -condition_y));

  float condition_x = step(0.1, flip_horizontal);
  uv.x = 1.0 -(uv.x *condition_x +(1.0 -uv.x) *(1.0 -condition_x));

  return uv;
}

vec2 set_uv(ivec2 flip, vec2 res) {
  return set_uv(flip.x,flip.y,res);
}

vec2 set_uv() {
  return set_uv(0,0,vec2(0));
}





float[HueLevCount] HueLevels = float[] (0.0,140.0,160.0,240.0,240.0,360.0);
float[SatLevCount] SatLevels = float[] (0.0,0.15,0.3,0.45,0.6,0.8,1.0);
float[ValLevCount] ValLevels = float[] (0.0,0.3,0.6,1.0);

vec3 RGBtoHSV( float r, float g, float b) {
   float minv, maxv, delta;
   vec3 res;

   minv = min(min(r, g), b);
   maxv = max(max(r, g), b);
   res.z = maxv;            // v
   
   delta = maxv - minv;

   if( maxv != 0.0 )
      res.y = delta / maxv;      // s
   else {
      // r = g = b = 0      // s = 0, v is undefined
      res.y = 0.0;
      res.x = -1.0;
      return res;
   }

   if( r == maxv)
      res.x = (g-b)/delta;      // between yellow & magenta
   else if( g == maxv )
      res.x = 2.0 + (b-r)/delta;   // between cyan & yellow
   else
      res.x = 4.0 + (r-g)/delta;   // between magenta & cyan

   res.x = res.x * 60.;            // degrees
   if( res.x < 0.0 )
      res.x = res.x + 360.;
      
   return res;
}

vec3 HSVtoRGB(float h, float s, float v) {
   int i;
   float f,p,q,t;
   vec3 res;

   if( s == 0.0) {
      // achromatic (grey)
      res.x = v;
      res.y = v;
      res.z = v;
      return res;
   }

   h /= 60.0;         // sector 0 to 5
   i = int(floor( h ));
   f = h - float(i);         // factorial part of h
   p = v * ( 1.0 - s);
   q = v * ( 1.0 - s * f);
   t = v * ( 1.0 - s * (1.0 - f));

   switch(i) {
      case 0:
         res.x = v;
         res.y = t;
         res.z = p;
         break;
      case 1:
         res.x = q;
         res.y = v;
         res.z = p;
         break;
      case 2:
         res.x = p;
         res.y = v;
         res.z = t;
         break;
      case 3:
         res.x = p;
         res.y = q;
         res.z = v;
         break;
      case 4:
         res.x = t;
         res.y = p;
         res.z = v;
         break;
      default:      // case 5:
         res.x = v;
         res.y = p;
         res.z = q;
         break;
   }
   return res;
}

float nearestLevel(float col, int mode) {
   int levCount;
   if (mode==0) levCount = HueLevCount;
   if (mode==1) levCount = SatLevCount;
   if (mode==2) levCount = ValLevCount;
   
   for (int i =0; i<levCount-1; i++ ) {
     if (mode==0) {
        if (col >= HueLevels[i] && col <= HueLevels[i+1]) {
          return HueLevels[i+1];
        }
     }
     if (mode==1) {
        if (col >= SatLevels[i] && col <= SatLevels[i+1]) {
          return SatLevels[i+1];
        }
     }
     if (mode==2) {
        if (col >= ValLevels[i] && col <= ValLevels[i+1]) {
          return ValLevels[i+1];
        }
     }
   }
}

// averaged pixel intensity from 3 color channels
float avg_intensity(vec4 pix) {
 return (pix.r + pix.g + pix.b)/3.;
}

vec4 get_pixel(vec2 coords, float dx, float dy) {
 return texture(texture_source,coords + vec2(dx,dy));
}

// returns pixel color
float IsEdge(in vec2 coords) {
  float dxtex = 1.0 /float(textureSize(texture_source,0)) ;
  float dytex = 1.0 /float(textureSize(texture_source,0));
  float pix[9];
  int k = -1;
  float delta;

  // read neighboring pixel intensities
  for (int i=-1; i<2; i++) {
   for(int j=-1; j<2; j++) {
    k++;
    pix[k] = avg_intensity(get_pixel(coords,float(i)*dxtex,
                                          float(j)*dytex));
   }
  }

  // average color differences around neighboring pixels
  delta = (abs(pix[1]-pix[7])+
          abs(pix[5]-pix[3]) +
          abs(pix[0]-pix[8])+
          abs(pix[2]-pix[6])
           )/4.;

  //return clamp(5.5*delta,0.0,1.0);
  return clamp(edge_thres2*delta,0.0,1.0);
}

void main() {
  vec2 uv = set_uv(flip_source,resolution_source);
  vec4 tc = vec4(1.0, 0.0, 0.0, 1.0);
  if (uv.x > (offset.x+0.002)) {
    vec3 colorOrg = texture(texture_source, uv).rgb;
    vec3 vHSV =  RGBtoHSV(colorOrg.r,colorOrg.g,colorOrg.b);
    vHSV.x = nearestLevel(vHSV.x, 0);
    vHSV.y = nearestLevel(vHSV.y, 1);
    vHSV.z = nearestLevel(vHSV.z, 2);
    float edg = IsEdge(uv);
    vec3 vRGB = (edg >= edge_thres)? vec3(0.0,0.0,0.0):HSVtoRGB(vHSV.x,vHSV.y,vHSV.z);
    tc = vec4(vRGB.x,vRGB.y,vRGB.z, 1);  
  } else if (uv.x < (offset.x-0.002)) {
    tc = texture(texture_source,uv);
  }
  gl_FragColor = tc;
}