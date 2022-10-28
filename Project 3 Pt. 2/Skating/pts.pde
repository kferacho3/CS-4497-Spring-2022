//*****************************************************************************
// TITLE:         Point sequence for editing polylines and polyloops  
// AUTHOR:        Prof Jarek Rossignac
// DATE CREATED:  September 2012
// EDITS:         Last revised Sept 10, 2016
//*****************************************************************************
class PNTS 
  {
  int nv=0;                                // number of vertices in the sequence
  int pv = 0;                              // picked vertex 
  int iv = 0;                              // insertion index 
  int maxnv = 100*2*2*2*2*2*2*2*2;         //  max number of vertices
  Boolean loop=true;                       // is a closed loop

  PNT[] G = new PNT [maxnv];                 // geometry table (vertices)

 // CREATE


  PNTS() {}
  
  void declare() {for (int i=0; i<maxnv; i++) G[i]=P(); }               // creates all points, MUST BE DONE AT INITALIZATION

  void empty() {nv=0; pv=0; }                                                 // empties this object
  
  void addPoint(PNT P) { G[nv].setTo(P); pv=nv; nv++;  }                    // appends a point at position P
  
  void addPoint(float x,float y) { G[nv].x=x; G[nv].y=y; pv=nv; nv++; }    // appends a point at position (x,y)
  
  void insertPoint(PNT P)  // inserts new point after point pv
    { 
    for(int v=nv-1; v>pv; v--) G[v+1].setTo(G[v]); 
    pv++; 
    G[pv].setTo(P);
    nv++; 
    }
     
  void insertClosestProjectionOfPoint(PNT M) // inserts point that is the closest to M on the curve
    {
    insertPoint(closestProjectionOfPoint(M));
    }
  
  void resetPointsOnCircle(int k)                                                         // init the points to be on a well framed circle
    {
    empty();
    PNT C = ScreenCenter(); 
    for (int i=0; i<k; i++)
      addPoint(R(P(C,V(0,-width/3)),2.*PI*i/k,C));
    } 
  
  void placeWxWpointsOnGrid (int w) // make a 2D grid of w x w vertices
   {
   empty();
   for (int i=0; i<w; i++) 
     for (int j=0; j<w; j++) 
       addPoint(P(.7*height*j/(w-1)+.1*height,.7*height*i/(w-1)+.1*height));
   }    


  // PICK AND EDIT INDIVIDUAL POINT
  
  void pickPointClosestTo(PNT M) 
    {
    pv=0; 
    for (int i=1; i<nv; i++) 
      if (d(M,G[i])<d(M,G[pv])) pv=i;
    }

  void dragPickedPoint()  // moves selected point (index pv) by the amount by which the mouse moved recently
    { 
    G[pv].moveWithMouse(); 
    }     
  
  void deletePickedPoint() {
    for(int i=pv; i<nv; i++) 
      G[i].setTo(G[i+1]);
    pv=max(0,pv-1);       // reset index of picked point to previous
    nv--;  
    }
  
  void setPointOfGivenIndex(PNT P, int i) 
    { 
    G[i].setTo(P); 
    }
  
  
  // DISPLAY
  
  void writeIDsInEmptyDisks() 
    {
    for (int v=0; v<nv; v++) 
      { 
      fill(white); 
      show(G[v],13); 
      fill(black); 
      if(v<10) label(G[v],str(v));  
      else label(G[v],V(-5,0),str(v)); 
      }
    noFill();
    }
  
  void showPickedPoint() 
    {
    show(G[pv],13); 
    }
  
  void drawAllVerticesInColor(color c) 
    {
    fill(c); 
    drawAllVertices();
    }
  
  void drawAllVertices()
    {
    for (int v=0; v<nv; v++) show(G[v],13); 
    }
   
  void drawCurve() 
    {
    if(loop) drawPolyloop(); 
    else drawPolyline(); 
    }
    
  void drawPolyline() 
    {
    beginShape(); 
      for (int v=0; v<nv; v++) G[v].v(); 
    endShape(); 
    }
    
  void drawPolyloop()   
    {
    beginShape(); 
      for (int v=0; v<nv; v++) G[v].v(); 
    endShape(CLOSE); 
    }

  // EDIT ALL POINTS TRANSALTE, ROTATE, ZOOM, FIT TO CANVAS
  
  void dragAllPoints() // moves all points to mimick mouse motion
    { 
    for (int i=0; i<nv; i++) G[i].moveWithMouse(); 
    }      
  
  void moveAll(VCT V) // moves all points by V
    {
    for (int i=0; i<nv; i++) G[i].translate(V); 
    }   

  void rotateAllPoints(float a, PNT C) // rotates all points around pt G by angle a
    {
    for (int i=0; i<nv; i++) G[i].rotateWrtPNT(a,C); 
    } 
  
  void rotateAllPointsAroundCentroid(float a) // rotates points around their center of mass by angle a
    {
    rotateAllPoints(a,CentroidOfPolygon()); 
    }
    
  void rotateAllPointsAroundCentroid(PNT P, PNT Q) // rotates all points around their center of mass G by angle <GP,GQ>
    {
    PNT C = CentroidOfPolygon();
    rotateAllPoints(angle(V(C,P),V(C,Q)),C); 
    }

  void scaleAllPoints(float s, PNT C) // scales all pts by s wrt C
    {
    for (int i=0; i<nv; i++) G[i].dilateWrtPNT(s,C); 
    }  
  
  void scaleAllPointsAroundCentroid(float s) 
    {
    scaleAllPoints(s,CentroidOfPolygon()); 
    }
  
  void scaleAllPointsAroundCentroid(PNT M, PNT P) // scales all points wrt centroid G using distance change |GP| to |GM|
    {
    PNT C=CentroidOfPolygon(); show(C,60);
    float m=d(C,M),p=d(C,P); 
    scaleAllPoints(m/p,C); 
    }
    
    
  void scaleAndRotateAllPointsAroundCentroid(PNT M, PNT P) // scales all points wrt centroid G using distance change |GP| to |GM|
    {
    PNT C=CentroidOfPolygon(); show(C,60);
    rotateAllPoints(angle(V(C,M),V(C,P)),C); 
    float m=d(C,M),p=d(C,P); 
    scaleAllPoints(m/p,C); 
    }

  PNT CentroidOfPolygon () 
      {
      PNT C=P(); 
      PNT O=P(); 
      float area=0;
      for (int i=nv-1, j=0; j<nv; i=j, j++) 
        {
        float a = triangleArea(O,G[i],G[j]); 
        area+=a; 
        C.add(a,P(O,G[i],G[j])); 
        }
      C.divideBy(area); 
      return C; 
      }
        
  PNT CentroidOfVertices() 
    {
    PNT C=P(); // will collect sum of points before division
    for (int i=0; i<nv; i++) C.add(G[i]); 
    return P(1./nv,C); // returns divided sum
    }
 
  void fitToCanvas()   // translates and scales mesh to fit canvas
     {
     float sx=100000; float sy=10000; float bx=0.0; float by=0.0; 
     for (int i=0; i<nv; i++) {
       if (G[i].x>bx) {bx=G[i].x;}; if (G[i].x<sx) {sx=G[i].x;}; 
       if (G[i].y>by) {by=G[i].y;}; if (G[i].y<sy) {sy=G[i].y;}; 
       }
     for (int i=0; i<nv; i++) {
       G[i].x=0.93*(G[i].x-sx)*(width)/(bx-sx)+23;  
       G[i].y=0.90*(G[i].y-sy)*(height-100)/(by-sy)+100;
       } 
     }   
     
  // MEASURES 
  float lengthOfPerimeter () // length of perimeter
    {
    float L=0; 
    for (int i=nv-1, j=0; j<nv; i=j++) L+=d(G[i],G[j]); 
    return L; 
    }
    
  float areaEnclosedByPolyloop()  // area enclosed
    {
    PNT O=P(); 
    float a=0; 
    for (int i=nv-1, j=0; j<nv; i=j++) a+=det(V(O,G[i]),V(O,G[j])); 
    return a/2;
    }   
    
  PNT closestProjectionOfPoint(PNT M) 
    {
    int c=0; PNT C = P(G[0]); float d=d(M,C);       
    for (int i=1; i<nv; i++) if (d(M,G[i])<d) {c=i; C=P(G[i]); d=d(M,C); }  
    for (int i=nv-1, j=0; j<nv; i=j++) 
      { 
      PNT A = G[i], B = G[j];
      if(projectsBetween(M,A,B) && disToLine(M,A,B)<d) 
        {
        d=disToLine(M,A,B); 
        c=i; 
        C=projectionOnLine(M,A,B);
        }
      } 
     pv=c;    
     return C;    
     }  

  Boolean contains(PNT Q) {
    Boolean in=true;
    // provide code here
    return in;
    }
  

  float alignentAngle(PNT C) { // of the perimeter
    float xx=0, xy=0, yy=0, px=0, py=0, mx=0, my=0;
    for (int i=0; i<nv; i++) {xx+=(G[i].x-C.x)*(G[i].x-C.x); xy+=(G[i].x-C.x)*(G[i].y-C.y); yy+=(G[i].y-C.y)*(G[i].y-C.y);};
    return atan2(2*xy,xx-yy)/2.;
    }


  // FILE I/O   
     
  void writePNTS(String fn) 
    {
    println("Saving: "+nv+" points to "+fn); 
    String [] inppts = new String [nv+1];
    int s=0;
    inppts[s++]=str(nv);
    for (int i=0; i<nv; i++) {inppts[s++]=str(G[i].x)+","+str(G[i].y);}
    saveStrings(fn,inppts);
    };
  

  void readPNTS(String fn) 
    {
    print("Reading points from "+fn); 
    String [] ss = loadStrings(fn);
    String subpts;
    int s=0;   int comma, comma1, comma2;   float x, y;   int a, b, c;
    nv = int(ss[s++]); 
    for(int k=0; k<nv; k++) {
      int i=k+s; 
      comma=ss[i].indexOf(',');   
      x=float(ss[i].substring(0, comma));
      y=float(ss[i].substring(comma+1, ss[i].length()));
      G[k].setTo(x,y);
      };
    pv=0;
    println(" ... Loaded: "+nv+" points."); 
    }; 
  
  }  // end class PNTS
