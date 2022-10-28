import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

// Course template for 2D projects provided by Prof. Jarek ROSSIGNAC
import processing.pdf.*;    // to save screen shots as PDFs, does not always work: accuracy problems, stops drawing or messes up some curves !!!
import java.awt.Toolkit;
import java.awt.datatransfer.*;

//**************************** global variables ****************************
// CO\ontrol points or Vertices of polyline or polyloop
PNTS ControlPoints = new PNTS(); // class containing array of points, used to standardize GUI

// Animation
boolean animate=true;
float warpedTime=0;  // current and warped time
int currentFrame=0; // frame to advance timing
int framesInAnimation=90; // intermediate frames for the whole animation 

//SOUND VARIABLES
//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
Minim minim;
AudioPlayer song;
AudioPlayer amp;
AudioInput in;
BeatDetect beat;
//Amplitude amp;
FFT fft;
//variables to scaLe the intensity of sound values rescpective to their names
float specLow = 0.015; // 3%
float specMid = 0.125;  // 12.5%
float specHi = 0.8;   // 20%

// various intenity levels to assign to each visual
 boolean sync = true;
 boolean synth = true;
 boolean size = true;
 float intensity;
  float rad;
 float intensityL;
 float intensityM;
 float iSpec;
 float amplitude;
float col = random(255);
float col2 = random(255);
float col3 = random(255);
float col4 = random(255);
float col5 = random(255);
float col6 = random(255);
float x2;
float y2;
color to = color (col, col2, col3);
color from = color (col4, col5, col6);
color aa = lerpColor(int(random(to)), int(random(from)), random(255));
color bb = lerpColor(int(random(to)), int(random(from)), random(255));
int state = int(random(3));
float scoreDecreaseRate = 25;
//for loop for music play
int nbMurs = 2000;
int cMode = int(random(6));
float rand = random(360);
float rand2 = random(200);
//**************************** initialization ****************************
void setup()               // executed once at the begining 
  {
  //fullScreen(P2D, 2);
  //size(1000, 1000);          // window size
  // h= 1440 , w= 2560
  //size(1440, 1440);          // window size
  size(1330, 1330, P2D);          // window size
  frameRate(30);             // render 30 frames per second
  smooth();                  // turn on antialiasing for drawing curves
  PictureOfMyFace = loadImage("data/pic.jpg");  // load image from file pic.jpg in folder data *** replace that file with your pic of your own face
  PictureOfMyFace2 = loadImage("data/pic2.png");  // load image from file pic.jpg in folder data *** replace that file with your pic of your own face
  ControlPoints.declare(); // declares all ControlPoints. MUST BE DONE BEFORE ADDING POINTS 
  ControlPoints.readPNTS("data/pts");  // loads points form file saved with this program
  //P.resetOnCircle(4); // uncomment to create new config with 4 or whatever number of points then save with 'R'
  //P.empty(); // reset pont list P
  initDucklings(); // creates Ducling[] points
   switch (cMode) {
    case 0:
    colorMode(HSB, rand, rand2, rand2);
    break;
    case 1:
    colorMode(HSB, 360, 100, 100);
    break;
    case 2:
    colorMode(HSB, 360, 360, 360);
    break;
    case 3:
    colorMode(RGB, 100);
    break;
    case 4:
    colorMode(HSB, 100);
    break;
    case 5:
    colorMode(HSB, 359, 99, 99, 255);
    break;
    case 6:
    break;
  
  }
  println("h=",height,", w=",width);
  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, 2048, 192000.0);
  //********************************** Place Song in line below followed by ".mp3"
  song = minim.loadFile("data/sati.mp3", 512);
  fft = new FFT(song.bufferSize(), song.sampleRate());
  //y = new float[fft.specSize()];
  //x = new float[fft.specSize()];
  //angle2 = new float[fft.specSize()];
  beat = new BeatDetect();
  beat.setSensitivity(250);
  song.play(0);
  
  } // end of setup

//**************************** display current frame ****************************
void draw()      // executed at each frame
  {
    for(int i = 0; i < nbMurs; i++) {
      //speed
     intensity = song.mix.level();
     intensity *= 50;
     //color
     amplitude = song.mix.level();
     amplitude *=50;
     
     rad = song.mix.level();
     rad *=50;
  }
  
  background(white); // clear screen by painting white background

  // show colors and ramps
  //showMyColors();
  //for(int c=0; c<9; c++) {swf(black,2,ramp.col(c)); show(P(P(50,height-200),V(50*c,0)),20); }

  // advance animation (controlled by 'a')
  if(animate) 
    {
    currentFrame++; 
    if (currentFrame>framesInAnimation) {currentFrame=0;}
    currentTime=(float)currentFrame/framesInAnimation;
    }

  if(recordingPDF) startRecordingPDF(); // starts recording graphics to make a PDF
  
    // crates points with more convenient names 
    PNT A=ControlPoints.G[0], B=ControlPoints.G[1], C=ControlPoints.G[2], D=ControlPoints.G[3];     

    // show polyloop and centroid/axis
    //swfo(black,3,yellow,40); ControlPoints.drawCurve(); 
    ControlPoints.writeIDsInEmptyDisks(); // shows polyloop with vertex labels

    //stroke(red); PNT G=ControlPoints.CentroidOfPolygon(); show(G,10); // shows centroid
    //VCT PD=R(V(100,0),ControlPoints.alignentAngle(G)); PNT S = P(G,PD); PNT E = P(G,-1.,PD); edge(S,E);  // shows principal direction


    // show vector animation
    myProject();
    
    
    scribeFooter(str(currentFrame)+"/"+str(framesInAnimation) ,4); 


  if(recordingPDF) endRecordingPDF();  // end saving a .pdf file with the image of the canvas
  showPointer(); // show mouse pointer and mouse and key pressed
  fill(black); displayHeader(); // displays header
  if(scribeText && !filming) displayFooter(); // shows title, menu, and my face & name 

  if(filmingTIF && (animate || changed)) snapFrameToTIF(); // saves image on canvas as movie frame 
  if(filmingJPG && (animate || changed)) snapFrameToJPG(); // saves image on canvas as movie frame 
  if(snapTIFpicture) snapPictureToTIF();   
  if(snapJPGpicture) snapPictureToJPG();   
  changed=false; // to avoid capturing movie frames when nothing happens
  //saveFrame("frames01/####.png");
  }  // end of draw
  
