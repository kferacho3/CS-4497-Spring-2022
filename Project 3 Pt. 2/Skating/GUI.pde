//**************************** user actions ****************************
void keyPressed()  // executed each time a key is pressed: sets the Boolean "keyPressed" till it is released   
                    // sets  char "key" state variables till another key is pressed or released
    {
    myKeyPressed(); // defined in TAB MyProject
  
    //if(key=='~') ;
    //if(key=='!') ; 
    if(key=='@') recordingPDF=true; // to snap an image of the canvas and save as zoomable a PDF, compact, great quality, no background, but does not work for textures or 3D;
    if(key=='#') snapJPGpicture=true; // make a .PDF picture of the canvas, compact, poor quality;
    if(key=='$') snapTIFpicture=true; // make a .TIF picture of the canvas, better quality, but large file 
    //if(key=='%') ; 
    //if(key=='^') ;
    //if(key=='&') ;
    //if(key=='*') ;    
    //if(key=='(') ;
    //if(key==')') ;  
    //if(key=='_') ;
    //if(key=='+') ;
 
    //if(key=='`') ;  
    //if(key=='1') ; 
    //if(key=='2') ; 
    //if(key=='3') ; 
    //if(key=='4') ;
    //if(key=='5') ;
    //if(key=='6') ;
    //if(key=='7') ;
    //if(key=='8') ;
    //if(key=='9') ;
    //if(key=='0') ; 
    if(key=='-') filmingJPG=!filmingJPG; // filming on/off into IMAGES/MOVIE_FRAMES_JPG/ small size images, use https://gifmaker.me/ to make gif , view in browser
    if(key=='=') filmingTIF=!filmingTIF; // filming on/off into IMAGES/MOVIE_FRAMES_TIF/

    if(key=='a') {animate=!animate; }
    //if(key=='b') ; // used in myKeyPressed() to adjust knot value
    //if(key=='c') ; // used in myKeyPressed() to adjust knot value
    //if(key=='d') ; // used in myKeyPressed() to adjust knot value
    if(key=='e') easeInOut=!easeInOut;
    //if(key=='f') ;
    //if(key=='g') ; 
    //if(key=='h') ;
    if(key=='i') ; // used in mousePressed and mouseDragged to insert and move a vertex
    //if(key=='j') ;
    //if(key=='k') ; 
    if(key=='j') ;
    //if(key=='l') ; // used in myKeyPressed() to toggle showing linear interpolation
    
    if(key=='j') decel(); //decelerates music sync intensity
    if(key=='k') accel(); //accelerates music sync intensity
    if(key=='z') shrink(); //decreases music sync intensity with size of ducklings
    if(key=='x') swell(); //increases music sync intensity with size of ducklings
    if(key=='b') size=!size; // toggle duckling size sync
    if(key=='m') sync=!sync; // toggle speed sync
    if(key=='n') synth=!synth; // toggle color sync
    if(key=='p') shuff(); //shuffles color toggle
    
    
    if(key=='o') ControlPoints.resetPointsOnCircle(ControlPoints.nv);
    //if(key=='q') ; f
    if(key=='r') ; // used in mouseDrag to rotate the control points 
    if(key=='s') ; // used in myKeyPressed() to toggle showing spiral interpolation
    if(key=='t') ; // used in mouseDrag to translate the control points 
    //if(key=='u') ;
    //if(key=='v') ; 
    //if(key=='w') ;  
    if(key=='x') ; // used in keyPressed() to delete closest vertex
    //if(key=='y') ;
    if(key=='z') ; // used in mouseDrag to scale the control points

    //if(key=='A') ;
    //if(key=='B') ; 
    if(key=='C') ; // used in myKeyPressed() {MyText=getClipboard(); }
    //if(key=='D') ;  
    //if(key=='E') ;
    //if(key=='F') ;
    //if(key=='G') ; 
    //if(key=='H') ; 
    //if(key=='I') ; 
    //if(key=='J') ;
    //if(key=='K') ;
    //if(key=='L') ;    
    if(key=='M') 
      {
      song.close();
      song = minim.loadFile("sati.mp3", 512); 
      song.play();
      fft = new FFT(song.bufferSize(), song.sampleRate());
      int millis = song.length();
      int sec=millis/1000, min = sec/60; sec-=60*min; 
      framesInAnimation=millis*30/1000;     
      println("Playing: ","sati.mp3",", length = ",min,":",sec," = ",framesInAnimation," frames");
      }
     
    //if(key=='N') ;
    //if(key=='O') ;
    //if(key=='P') ; 
    if(key=='Q') exit();  // quit application
    if(key=='R') ControlPoints.readPNTS("data/pts"); // read current positions of control points from file
    //if(key=='S') ;    
    //if(key=='T') ;
    //if(key=='U') ;
    //if(key=='V') ;
    if(key=='W') ControlPoints.writePNTS("data/pts");  // write current positions of points to file
    //if(key=='X') ;  
    //if(key=='Y') ;
    //if(key=='Z') ;  

    if(key=='{') ;
    if(key=='}') ;
    if(key=='|') ; 
    
    if(key=='[') ; 
    if(key==']') ControlPoints.fitToCanvas();  
    if(key=='\\') ;
    
    if(key==':') ; 
    if(key=='"') ; 
    
    if(key==';') ; 
    if(key=='\''); 
    
    if(key=='<') ;
    if(key=='>') ;
    if(key=='?') scribeText=!scribeText; // toggle display of help text and authors picture
   
    if(key==',') ;
    if(key=='.') ;  // used in mousePressed to tweak current frame f
    if(key=='/') ;
  
    if(key==' ') ;
  
    //if (key == CODED) 
    //   {
    //   String pressed = "Pressed coded key ";
    //   if (keyCode == UP) {pressed="UP";   }
    //   if (keyCode == DOWN) {pressed="DOWN";   };
    //   if (keyCode == LEFT) {pressed="LEFT";   };
    //   if (keyCode == RIGHT) {pressed="RIGHT";   };
    //   if (keyCode == ALT) {pressed="ALT";   };
    //   if (keyCode == CONTROL) {pressed="CONTROL";   };
    //   if (keyCode == SHIFT) {pressed="SHIFT";   };
    //   println("Pressed coded key = "+pressed); 
    //   } 
  
    changed=true; // to make sure that we save a movie frame each time something changes
    println("key pressed = "+key);

    }

void mousePressed()   // executed when the mouse is pressed
  {
  ControlPoints.pickPointClosestTo(Mouse()); // pick vertex closest to mouse: sets pv ("picked vertex") in pts
  if (keyPressed) 
     {
     if (key=='m')  ControlPoints.addPoint(Mouse()); // appends vertex after the last one
     if (key=='i')  ControlPoints.insertClosestProjectionOfPoint(Mouse()); // inserts vertex at closest projection of mouse
     if (key=='x')  ControlPoints.deletePickedPoint(); // deletes vertex closeset to mouse
     }  
  changed=true;
  }

void mouseDragged() // executed when the mouse is dragged (while mouse buttom pressed)
  {
  myMouseDragged();
  if (!keyPressed || (key=='m')|| (key=='i')) ControlPoints.dragPickedPoint();   // drag selected point with mouse
  if (keyPressed) {
      if (key=='.') currentTime+=2.*float(mouseX-pmouseX)/width;  // adjust current time   
      if (key=='r') ControlPoints.rotateAllPointsAroundCentroid(Mouse(),Pmouse()); // turn all vertices around their center of mass
      if (key=='s') ControlPoints.scaleAllPointsAroundCentroid(Mouse(),Pmouse()); // scale all vertices with respect to their center of mass
      if (key=='t') ControlPoints.dragAllPoints(); // move all vertices
      if (key=='z') ControlPoints.scaleAndRotateAllPointsAroundCentroid(Mouse(),Pmouse()); // scale all vertices with respect to their center of mass
      }
  changed=true;
  }  

void mouseWheel(MouseEvent event) { // reads mouse wheel and uses to zoom
  float s = event.getCount();
  ControlPoints.scaleAllPointsAroundCentroid(1.-s/100);
  changed=true;
  }

//**************************** menu  ****************************
String menu="?:help, @/#/$:pdf/jpg/tif, -/=:JPG/TIF gif, R/W:read/write, a/./e:anim/time/ease, m/i/x:more/ins/del, r/t/s/z/o:rot/tran/scale/sim/circ";
      
