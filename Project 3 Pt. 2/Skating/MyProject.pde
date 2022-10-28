// Class: CS ???? 
// Semester: Fall ??
// Project number: ??
// Project title: ??
// Student(s):

//======================= My global variables
boolean lerp=true, spiral=true; // toggles to display vector interpoations
float startTime=0, currentTime=0.5, endTime=1; // initial knots

// startup bool and points that will be the globals for walking
boolean startup = true;
PNT walkA; // walking control point A
PNT walkB; // walking control point B
PNT walkC; // walking control point C

PNT walkA2; // walking control point A
PNT walkB2; // walking control point B
PNT walkC2; // walking control point C

PNT walkA3; // walking control point A
PNT walkB3; // walking control point B
PNT walkC3; // walking control point C

PNT walkA4; // walking control point A
PNT walkB4; // walking control point B
PNT walkC4; // walking control point C

PNT walkA5; // walking control point A
PNT walkB5; // walking control point B
PNT walkC5; // walking control point C

PNT walkA6; // walking control point A
PNT walkB6; // walking control point B
PNT walkC6; // walking control point C

PNT CNT; // Center of circle were walking for helping rules

int swapCount = 0;

int CEN_VAL;
int CEN_VAL2;
int PREV_CEN;
boolean counterClock = true;
boolean update = false;
float lastSwapTime = 0;
int circleType = 0;


float rotator = 0;
float rotator2 = 0;
float rotator3 = 0;
float rotator4 = 0;
float rotator5 = 0;
float rotator6 = 0;

int numSnakes = 6;

PNT [] nextPTS = new PNT[numSnakes];
PNT [] walkAS = new PNT[numSnakes];
PNT [] walkBS = new PNT[numSnakes];
PNT [] walkCS = new PNT[numSnakes];
PNT [] newPTS = new PNT[numSnakes];

ArrayList<PNT> centers;
ArrayList<PNT> kissing_points;
//**************************** My text  ****************************
String title ="Class: CS 6497, Year: 2022, Assignment No: 3",            name ="Ford Lascari and Kamal Feracho";
String subtitle = "Walking syncronized ducklings through circles synced to music";    
String guide="l/s:LERP/SPIRAL, b/c/d:knots"; // help info
String MyText=""; // string copied from clipboard to be printed on canvas FAST
float stringX=300, stringY=300;

//======================= called in main() and executed at each frame to redraw the canvas
void myProject() // four points used to define 3 vectors
    {
     // crates point references with more convenient names 
    
    PNT A=ControlPoints.G[0], B=ControlPoints.G[1], C=ControlPoints.G[2], D=ControlPoints.G[3];     
    // show the 3 vectors as arrows
    //swF(red,5); arrow(A,B);              
    //swF(dgreen,5); arrow(A,C);            
    //swF(blue,5); arrow(A,D);              

    float wt=startTime+currentTime*(endTime-startTime); if(easeInOut) wt=easeInOut(startTime,currentTime,endTime,wt);
    float dt = (endTime-startTime)/120; // time increment between  frames shown in pattern

    currentTime = 30. * currentFrame / framesInAnimation;
    //System.out.println(currentTime);
    // show circle-arc
    swF(black,3); showArcThrough(A,B,C);
    
    
    // drawing the grid of circles
    pushMatrix(); // oush new matric for fram of reference
    float r = circumRadius(ControlPoints.G[0],ControlPoints.G[1],ControlPoints.G[2]); // big radius
    float m = 1./3; // multilier down
    PNT circumCenter = CircumCenter(ControlPoints.G[0],ControlPoints.G[1],ControlPoints.G[2]); // center of big circle
    translate(circumCenter.x, circumCenter.y); // set reference point to 
    rings(r, m, 1, 50);
    // get the location of the centers of the sub circles and the kissing points of each
    centers = get_centers(circumCenter, r);
    kissing_points = get_kissing(circumCenter, r);
    popMatrix();
    
    // if starting up, set walking points to global control points 
    // later we will update these walking points but need to instantiate them
    // then change startup to false to not set them back to these
    if (startup) {
      for (int p=0; p<numSnakes; p++) {
        nextPTS[p] = P();
        walkAS[p] = A;
        walkBS[p] = B;
        walkCS[p] = C;
        newPTS[p] = P();
      }
      
      walkA = A;
      walkB = B; 
      walkC = C;
      
      if (numSnakes > 1) {
        walkA2 = A;
        walkB2 = B; 
        walkC2 = C;
        rotator2 = PI;
      }
      if (numSnakes > 2) {
        walkA3 = A;
        walkB3 = B; 
        walkC3 = C;
        rotator2 = 2*PI/3;
        rotator3 = 4*PI/3;
      }
      
      if (numSnakes > 3) {
        walkA4 = A;
        walkB4 = B; 
        walkC4 = C;
        
        walkA5 = A;
        walkB5 = B; 
        walkC5 = C;
        
        walkA6 = A;
        walkB6 = B; 
        walkC6 = C;
        
        rotator2 = PI/3;
        rotator3 = 2*PI/3;
        rotator4 = PI;
        rotator5 = 4*PI/3;
        rotator6 = 5*PI/3;
        
      }
      
      CEN_VAL = 7; // center of big circle
      CEN_VAL2 = 7; // center of big circle
      startup = false;
    }
    
    // figure out what the next point will be
    PNT nextP = pointOnArcThrough(walkA,walkB,walkC,currentTime,swapCount, circleType, update);    
    if (numSnakes > 1) {PNT nextP2 = pointOnArcThrough2(walkA2,walkB2,walkC2,currentTime,swapCount, circleType, update);}
    if (numSnakes > 2) {PNT nextP3 = pointOnArcThrough3(walkA3,walkB3,walkC3,currentTime, swapCount, circleType, update);}
    if (numSnakes > 3) 
      {
        PNT nextP4 = pointOnArcThrough4(walkA4,walkB4,walkC4,currentTime,swapCount, circleType, update); 
        PNT nextP5 = pointOnArcThrough5(walkA5,walkB5,walkC5,currentTime,swapCount, circleType, update); 
        PNT nextP6 = pointOnArcThrough6(walkA6,walkB6,walkC6,currentTime,swapCount, circleType, update); 
      }
    
   /* for (int p=0; p<numSnakes; p++) {
        rotations[p] = getRotation(p, 1, swapCount, circleType, update);
        nextPTS[p] = P();
        nextPTS[p] = rotatePoint (walkAS[p], walkBS[p], walkCS[p], rotations[p]); 
      }*/
      
     //PNT nextP = nextPTS[0];
    /*for (int val = 0; val < centers.size()-1; val++) {
      PNT out = centers.get(val);   
      fill(red); scribe(str(val) ,out.x,out.y); 
    }*/
    
    for (int val = 0; val < kissing_points.size(); val++) {
      
      PNT out = kissing_points.get(val);
      //fill(red); scribe(str(val) ,out.x,out.y);
      System.out.println(currentTime);
      if (abs(currentTime - lastSwapTime) < 1) {continue;}
      // if we are at a kissing point
        if ((abs(nextP.x - out.x)/nextP.x) < 0.01 && (abs(nextP.y - out.y)/nextP.y) < 0.01) {
          
          // Randomly decide to swap to new track
          if(random(1)>0.6) {
            PREV_CEN = CEN_VAL;
            // exitting center circle
            lastSwapTime = currentTime;
            counterClock = !counterClock;
            // If we swap, rules for determining the next walking control points
            if (CEN_VAL == 7) {
              // circling big circle, and will transition to interior circle
              CEN_VAL = val;
              break;
              
            } else {
              if (val <= 5) {
                // transition back to big circle
                CEN_VAL = 7;
                break;
              }
              // circling a small circle
              update = true;
              swapCount++;
              
              if (val > 5 && val < 12) {
                if (CEN_VAL == 6) {
                  CEN_VAL = val - 6;
                } else {
                  // entering center circle
                  CEN_VAL = 6;
                }
              } else {
               // moving on small circles other than center
               if (PREV_CEN % 2 == 0) {
                 if (val % 2 == 0) {
                   CEN_VAL = abs(PREV_CEN+1)%6;
                 } else {
                   if (PREV_CEN == 0) {
                     CEN_VAL = 5;
                   } else {
                     CEN_VAL = abs(PREV_CEN-1)%6;
                   }
                 }
               } else {
                 if (val % 2 == 1) {
                   CEN_VAL = abs(PREV_CEN+1)%6;
                 } else {
                   CEN_VAL = abs(PREV_CEN-1)%6;
                 }
               }
            }
          }
        }
      }
    }
    float [] xs = {0, -0.866, -0.866, 0, 0.866, 0.866};
    float [] ys = {1, 0.5, -0.5, -1, -0.5, 0.5};

    PNT nextCen = centers.get(CEN_VAL);
    PNT nextCen2 = centers.get(CEN_VAL);
    PNT nextCen3 = centers.get(CEN_VAL);
    PNT nextCen4 = centers.get(CEN_VAL);
    PNT nextCen5 = centers.get(CEN_VAL);
    PNT nextCen6 = centers.get(CEN_VAL);
    
    if (CEN_VAL == 7) {
      circleType = 0;
      walkA = A;
      walkB = B;
      walkC = C;
      
      walkA2 = A;
      walkB2 = B; 
      walkC2 = C;
      
      walkA3 = A;
      walkB3 = B; 
      walkC3 = C;
      
      walkA4 = A;
      walkB4 = B; 
      walkC4 = C;
      
      walkA5 = A;
      walkB5 = B; 
      walkC5 = C;
      
      walkA6 = A;
      walkB6 = B; 
      walkC6 = C;
      
      CEN_VAL2 = 7;
    } else {
      circleType = 1;
      walkA = P((nextCen.x+(r*m*xs[3])) ,(nextCen.y+(r*m*ys[3])));
      walkB = P((nextCen.x+(r*m*xs[1])) ,(nextCen.y+(r*m*ys[1])));
      walkC = P((nextCen.x+(r*m*xs[5])) ,(nextCen.y+(r*m*ys[5])));

      if (CEN_VAL < 6) {
        if (numSnakes > 1) {
          nextCen2 = centers.get((CEN_VAL+ 3)%6);
        }
        if (numSnakes > 2) {
          nextCen2 = centers.get((CEN_VAL+ 2)%6);
          nextCen3 = centers.get((CEN_VAL+ 4)%6);
        }
        
        if (numSnakes > 3) {
          nextCen2 = centers.get((CEN_VAL+ 1)%6);
          nextCen3 = centers.get((CEN_VAL+ 2)%6);
          nextCen4 = centers.get((CEN_VAL+ 3)%6);
          nextCen5 = centers.get((CEN_VAL+ 4)%6);
          nextCen6 = centers.get((CEN_VAL+ 5)%6);
        }
        
      }
      
      walkA2 = P((nextCen2.x+(r*m*xs[3])) ,(nextCen2.y+(r*m*ys[3])));
      walkB2 = P((nextCen2.x+(r*m*xs[1])) ,(nextCen2.y+(r*m*ys[1])));
      walkC2 = P((nextCen2.x+(r*m*xs[5])) ,(nextCen2.y+(r*m*ys[5])));
      
      walkA3 = P((nextCen3.x+(r*m*xs[3])) ,(nextCen3.y+(r*m*ys[3])));
      walkB3 = P((nextCen3.x+(r*m*xs[1])) ,(nextCen3.y+(r*m*ys[1])));
      walkC3 = P((nextCen3.x+(r*m*xs[5])) ,(nextCen3.y+(r*m*ys[5])));
      
      walkA4 = P((nextCen4.x+(r*m*xs[3])) ,(nextCen4.y+(r*m*ys[3])));
      walkB4 = P((nextCen4.x+(r*m*xs[1])) ,(nextCen4.y+(r*m*ys[1])));
      walkC4 = P((nextCen4.x+(r*m*xs[5])) ,(nextCen4.y+(r*m*ys[5])));
      
      walkA5 = P((nextCen5.x+(r*m*xs[3])) ,(nextCen5.y+(r*m*ys[3])));
      walkB5 = P((nextCen5.x+(r*m*xs[1])) ,(nextCen5.y+(r*m*ys[1])));
      walkC5 = P((nextCen5.x+(r*m*xs[5])) ,(nextCen5.y+(r*m*ys[5])));
      
      walkA6 = P((nextCen6.x+(r*m*xs[3])) ,(nextCen6.y+(r*m*ys[3])));
      walkB6 = P((nextCen6.x+(r*m*xs[1])) ,(nextCen6.y+(r*m*ys[1])));
      walkC6 = P((nextCen6.x+(r*m*xs[5])) ,(nextCen6.y+(r*m*ys[5])));
    }
    
    
    PNT P = pointOnArcThrough(walkA,walkB,walkC,currentTime, swapCount, circleType, update);
    
    PNT P2 = pointOnArcThrough2(walkA2,walkB2,walkC2,currentTime, swapCount, circleType, update);
    
    PNT P3 = pointOnArcThrough3(walkA3,walkB3,walkC3,currentTime, swapCount, circleType, update);
    
    PNT P4 = pointOnArcThrough4(walkA4,walkB4,walkC4,currentTime,swapCount, circleType, update); 
    
    PNT P5 = pointOnArcThrough5(walkA5,walkB5,walkC5,currentTime,swapCount, circleType, update); 
    
    PNT P6 = pointOnArcThrough6(walkA6,walkB6,walkC6,currentTime,swapCount, circleType, update); 
    
    
      
    
    if (update) { update=false;}
    
    show(P,10);
    advanceDucklings(P); // to follow point P
    showDucklings();
    
    if (numSnakes > 1) {
      show(P2,10); 
      advanceDucklings2(P2); // to follow point P
      showDucklings2();
    }
    if (numSnakes > 2) {
      show(P3,10);
      advanceDucklings3(P3); // to follow point P
      showDucklings3();
    }
    if (numSnakes > 3) {
      show(P4,10);
      advanceDucklings4(P4); // to follow point P
      showDucklings4();
      
      show(P5,10);
      advanceDucklings5(P5); // to follow point P
      showDucklings5();
      
      show(P6,10);
      advanceDucklings6(P6); // to follow point P
      showDucklings6();
    }
    

    
    // show names of conveient points 
    swF(black,2); showId(A,"A"); showId(B,"B"); showId(C,"C"); showId(D,"D");
    
    // WRIRTE ON CANVAS
    fill(black); scribeHeader("TIMING: b="+nf(startTime,0,3)+", c="+nf(currentTime,0,3)+", d="+nf(endTime,0,3)+", t="+nf(currentTime,0,3)+", wt="+nf(wt,0,3),2); 
    if(lerp) {fill(magenta); scribeHeader("LERP (l)",3);}
    if(spiral) {fill(brown);  scribeHeader("SPIRAL (s)",4);} 
    if(easeInOut) {fill(orange);  scribeHeader("Ease in/out (e)",5);}
    
    fill(red); scribe(MyText,stringX,stringY); // write what was in clipboard at mouse location when 'C' was pressed
    
    float h=height-60;
    PNT Tstart = P(50,h), Tend = P(width-50,h); 
    PNT Tcurrent = L(Tstart,Tend,(float)currentFrame / framesInAnimation); 
    swF(grey,4); edge(Tstart,Tend); 
    textAlign(CENTER, BOTTOM);
    swF(dgreen,4); show(Tstart,3);   scribe("0",Tstart.x,Tstart.y-7);
    swF(blue,4);   show(Tcurrent,3); scribe(str(currentFrame),Tcurrent.x,Tcurrent.y-7);
    swF(red,4);    show(Tend,3);     scribe(str(framesInAnimation),Tend.x,Tend.y-7);
    textAlign(LEFT, BOTTOM);
    }
//======================= called when a key is pressed
void myKeyPressed()
  {
  if(key=='l') lerp=!lerp;               // toggles what should be displayed at each fram
  if(key=='s') spiral=!spiral;
  if(key=='C') {MyText=getClipboard(); stringX=mouseX; stringY=mouseY; } // ** Here! **
  }
  
//======================= called when the mouse is dragged
void myMouseDragged()
  {

  if (keyPressed) 
    {
    if (key=='b') startTime+=2.*float(mouseX-pmouseX)/width;  // adjust knot value b    
    if (key=='c') currentTime+=2.*float(mouseX-pmouseX)/width;  // adjust knot value c    
    if (key=='d') endTime+=2.*float(mouseX-pmouseX)/width;  // adjust knot value a 
    }
  }
