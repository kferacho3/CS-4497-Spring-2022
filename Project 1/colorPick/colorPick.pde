import java.awt.Toolkit;
import java.awt.datatransfer.*;
void setup() 
  {               
  size(640, 640);            // window size
  colorPicker = new ColorPicker( 20, 80, width-40, height-20, 255 );
  }
void draw() 
  {      
  background(255); // clear screen and paints white background
  background(none); // clear screen and paints white background
  colorPicker.render(); 
  setClipboard(str(pickedColor)); 
  // Using "right shift" as a faster technique than red(), green(), and blue()
  color argb = pickedColor;
  int a = (argb >> 24) & 0xFF;
  int r = (argb >> 16) & 0xFF;  // Faster way of getting red(argb)
  int g = (argb >> 8) & 0xFF;   // Faster way of getting green(argb)
  int b = argb & 0xFF;          // Faster way of getting blue(argb)
  fill(r, g, b, a);
  rect(30, 20, 55, 55);
  }

//************************* Color Picker
color none = color(100,100,100,100);
ColorPicker colorPicker;
Boolean pickingColor=false;
color pickedColor = color(0);

 class ColorPicker {  // from http://www.julapy.com/processing/ColorPicker.pde
  int x, y, w, h, c;
  PImage cpImage;

  ColorPicker ( int x, int y, int w, int h, int c ) {
    this.x = x; this.y = y; this.w = w; this.h = h; this.c = c;    
    cpImage = new PImage( w, h );
    // draw color.  
    int cw = w - 60;
    for( int i=0; i<cw; i++ ) {
      float nColorPercent = i / (float)cw;
      float rad = (-360 * nColorPercent) * (PI / 180);
      int nR = (int)(cos(rad) * 127 + 128) << 16;
      int nG = (int)(cos(rad + 2 * PI / 3) * 127 + 128) << 8;
      int nB = (int)(Math.cos(rad + 4 * PI / 3) * 127 + 128);
      int nColor = nR | nG | nB;
      setGradient( i, 0, 1, h/2, 0xFFFFFF, nColor );
      setGradient( i, (h/2), 1, h/2, nColor, 0x000000 );
      }    
    // draw black/white.
    drawRect( cw, 0,   30, h/2, 0xFFFFFF );
    drawRect( cw, h/2, 30, h/2, 0 );    
    // draw grey scale.
    for( int j=0; j<h; j++ ) {
      int g = 255 - (int)(j/(float)(h-1) * 255 );
      drawRect( w-30, j, 30, 1, color( g, g, g ) );
      }
    }

  void setGradient(int x, int y, float w, float h, int c1, int c2 ) {
    float deltaR = red(c2) - red(c1);
    float deltaG = green(c2) - green(c1);
    float deltaB = blue(c2) - blue(c1);
    for (int j = y; j<(y+h); j++) {
      int c = color( red(c1)+(j-y)*(deltaR/h), green(c1)+(j-y)*(deltaG/h), blue(c1)+(j-y)*(deltaB/h) );
      cpImage.set( x, j, c );
      }
    }
  
  void drawRect( int rx, int ry, int rw, int rh, int rc ) {for(int i=rx; i<rx+rw; i++) for(int j=ry; j<ry+rh; j++)  cpImage.set( i, j, rc ); }
    
  void render () {
    image( cpImage, x, y );
    if( mousePressed &&
        !keyPressed &&
  mouseX >= x && 
  mouseX < x + w &&
  mouseY >= y &&
  mouseY < y + h )  { c = get( mouseX, mouseY ); pickedColor=c;}
    fill( pickedColor ); noStroke();
    rect( width-30, 40, 20, 20 );
    }
 }
 
public static void setClipboard(String str) // loads str into clipboard
   { 
   StringSelection ss = new StringSelection(str);
   Toolkit.getDefaultToolkit().getSystemClipboard().setContents(ss, null);
   }
