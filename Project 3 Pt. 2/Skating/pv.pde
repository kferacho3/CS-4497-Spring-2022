//*****************************************************************************
// TITLE:         GEOMETRY UTILITIES IN 2D  
// DESCRIPTION:   Classes and functions for manipulating points, vectors, edges, triangles, quads, frames, and circular arcs  
// AUTHOR:        Prof Jarek Rossignac
// DATE CREATED:  September 2009
// EDITS:         Revised July 2017
//*****************************************************************************
//************************************************************************
//**** POINT CLASS
//************************************************************************
class PNT 
  { 
  float x=0,y=0; 
  
  // CREATE
  PNT () {}
  PNT (float px, float py) {x = px; y = py;};

  // MODIFY
  PNT setTo(float px, float py) {x = px; y = py; return this;};  
  PNT setTo(PNT P) {x = P.x; y = P.y; return this;}; 
  PNT translate(VCT V) {x += V.x; y += V.y; return this;}                              // P.add(V): P+=V
  PNT translate(float s, VCT V) {x += s*V.x; y += s*V.y; return this;}                 // P.add(s,V): P+=sV
  PNT translateTowardsPNT(float d, PNT F) {x+=d*(F.x-x);  y+=d*(F.y-y);  return this;};  // transalte by ratio s towards P
  PNT dilateWrtPNT(float s, PNT F) {x=F.x+s*(x-F.x); y=F.y+s*(y-F.y); return this;}    // P.scale(s,C): scales wrt C: P=L(C,P,s);
  PNT rotateWrtPNT(float a, PNT F) {float dx=x-F.x, dy=y-F.y, c=cos(a), s=sin(a); x=F.x+c*dx+s*dy; y=F.y-s*dx+c*dy; return this;};   // P.rotate(a,G): rotate P around G by angle a in radians
  PNT moveWithMouse() { x += mouseX-pmouseX; y += mouseY-pmouseY;  return this;}; 

  // for computing centroid of vertices or of polygons
  PNT add(PNT P) {x += P.x; y += P.y; return this;};                              // incorrect notation, but useful for computing weighted averages
  PNT add(float s, PNT P)   {x += s*P.x; y += s*P.y; return this;};               // adds s*P
  PNT divideBy(float s) {x/=s; y/=s; return this;}                                  // P.scale(s): P*=s
     
  // DRAW 
  PNT v() {vertex(x,y); return this;};  // used for drawing polygons between beginShape(); and endShape();
  PNT show(float r) {ellipse(x, y, 2*r, 2*r); return this;}; // shows point as disk of radius r
  PNT show() {show(3); return this;}; // shows point as small dot
  PNT label(String s, VCT V) {fill(black); text(s, x+V.x, y+V.y); noFill(); return this; };
  PNT label(String s) {label(s,5,4); return this; };
  PNT label(String s, float u, float v) {fill(black); text(s, x+u, y+v); noFill(); return this; };

  // for debugging
  PNT write() {print("("+x+","+y+")"); return this;};  // writes point coordinates in text window
  
  
  } // end of pt class


//************************************************************************
//**** VECTOR CLASS
//************************************************************************
class VCT 
  { 
  float x=0,y=0; 
  
 // CREATE
  VCT () {};
  VCT (float px, float py) {x = px; y = py;};
 
 // MODIFY
  VCT setTo(float px, float py) {x = px; y = py; return this;}; 
  VCT setTo(VCT V) {x = V.x; y = V.y; return this;}; 
  VCT zero() {x=0; y=0; return this;}
  VCT scaleBy(float u, float v) {x*=u; y*=v; return this;};
  VCT scaleBy(float f) {x*=f; y*=f; return this;};
  VCT reverse() {x=-x; y=-y; return this;};
  VCT divideBy(float f) {x/=f; y/=f; return this;};
  VCT normalize() {float n=sqrt(sq(x)+sq(y)); if (n>0.000001) {x/=n; y/=n;}; return this;};
  VCT add(float u, float v) {x += u; y += v; return this;};
  VCT add(VCT V) {x += V.x; y += V.y; return this;};   
  VCT add(float s, VCT V) {x += s*V.x; y += s*V.y; return this;};   
  VCT rotateBy(float a) {float xx=x, yy=y; x=xx*cos(a)-yy*sin(a); y=xx*sin(a)+yy*cos(a); return this;};
  VCT left() {float m=x; x=-y; y=m; return this;};
 
  // OUTPUT VEC
  VCT clone() {return(new VCT(x,y));}; 

  // OUTPUT TEST MEASURE
  float norm() {return(sqrt(sq(x)+sq(y)));}
  boolean isNull() {return((abs(x)+abs(y)<0.000001));}
  float angle() {return(atan2(y,x)); }

  // DRAW, PRINT
  void write() {println("<"+x+","+y+">");};
  void showAt (PNT P) {line(P.x,P.y,P.x+x,P.y+y); }; 
  void showArrowFrom (PNT P) 
      {
      line(P.x,P.y,P.x+x,P.y+y); 
      float n=min(this.norm()/10.,height/50.); 
      PNT Q=P(P,this); 
      VCT U = S(-n,U(this));
      VCT W = S(.3,R(U)); 
      beginShape(); Q.translate(U).translate(W).v(); Q.v(); Q.translate(U).translate(M(W)).v(); endShape(CLOSE); 
      }
      
  void label(String s, PNT P) {P(P).translate(0.5,this).translate(3,R(U(this))).label(s); };

  } // end VCT class


//************************************************************************
//**** POINTS FUNCTIONS
//************************************************************************
// create 
PNT P() {return P(0,0); };                                                                            // make point (0,0)
PNT P(float x, float y) {return new PNT(x,y); };                                                       // make point (x,y)
PNT P(PNT P) {return P(P.x,P.y); };                                                                    // make copy of point A

// measure 
float d(PNT P, PNT Q) {return sqrt(d2(P,Q));  };                                                       // ||AB|| (Distance)
float d2(PNT P, PNT Q) {return sq(Q.x-P.x)+sq(Q.y-P.y); };                                             // AB*AB (Distance squared)
boolean isSame(PNT A, PNT B) {return (A.x==B.x)&&(A.y==B.y) ;}                                         // A==B
boolean isSame(PNT A, PNT B, float e) {return d2(A,B)<sq(e);}                                          // |AB|<e

// transform 
PNT R(PNT Q, float a) {float dx=Q.x, dy=Q.y, c=cos(a), s=sin(a); return new PNT(c*dx+s*dy,-s*dx+c*dy); };  // Q rotated by angle a around the origin
PNT R(PNT Q, float a, PNT C) {float dx=Q.x-C.x, dy=Q.y-C.y, c=cos(a), s=sin(a); return P(C.x+c*dx-s*dy, C.y+s*dx+c*dy); };  // Q rotated by angle a around point C
PNT P(PNT P, VCT V) {return P(P.x + V.x, P.y + V.y); }                                                 //  P+V (P transalted by vector V)
PNT P(PNT P, float s, VCT V) {return P(P,W(s,V)); }                                                    //  P+sV (P transalted by sV)
PNT MoveByDistanceTowards(PNT P, float d, PNT Q) { return P(P,d,U(V(P,Q))); };                          //  P+dU(PQ) (transLAted P by *distance* s towards Q)!!!

// average 
PNT P(PNT A, PNT B) {return P((A.x+B.x)/2.0,(A.y+B.y)/2.0); };                                          // (A+B)/2 (average)
PNT P(PNT A, PNT B, PNT C) {return P((A.x+B.x+C.x)/3.0,(A.y+B.y+C.y)/3.0); };                            // (A+B+C)/3 (average)
PNT P(PNT A, PNT B, PNT C, PNT D) {return P(P(A,B),P(C,D)); };                                            // (A+B+C+D)/4 (average)

// weighted average 
PNT P(float a, PNT A) {return P(a*A.x,a*A.y);}                                                         // aA (used to collect weighted average) 
PNT P(float a, PNT A, float b, PNT B) {return P(a*A.x+b*B.x,a*A.y+b*B.y);}                              // aA+bB, (assumes a+b=1) 
PNT P(float a, PNT A, float b, PNT B, float c, PNT C) {return P(a*A.x+b*B.x+c*C.x,a*A.y+b*B.y+c*C.y);}   // aA+bB+cC, (assumes a+b+c=1) 
PNT P(float a, PNT A, float b, PNT B, float c, PNT C, float d, PNT D){return P(a*A.x+b*B.x+c*C.x+d*D.x,a*A.y+b*B.y+c*C.y+d*D.y);} // aA+bB+cC+dD (assumes a+b+c+d=1)
     
// display 
void show(PNT P, float r) {
  if (size) {
  ellipse(P.x, P.y, 2*r * rad, 2*r * rad);
  } else {
    ellipse(P.x, P.y, 2*r, 2*r);
  }
};                                              // draws circle of center r around P
void show(PNT P) {ellipse(P.x, P.y, 6,6);};                                                           // draws small circle around point
void label(PNT P, String S) {text(S, P.x-4,P.y+6.5); }                                                 // writes string S next to P on the screen ( for example label(P[i],str(i));)
void label(PNT P, VCT V, String S) {text(S, P.x-3.5+V.x,P.y+7+V.y); }                                  // writes string S at P+V
void showId(PNT P, String S) {fill(white); show(P,13); fill(black); label(P,S);}                       // sows disk with S written inside
void edge(PNT P, PNT Q) {line(P.x,P.y,Q.x,Q.y); };                                                      // draws edge (P,Q)
void v(PNT P) {vertex(P.x,P.y);};                                                                      // vertex for drawing polygons between beginShape() and endShape()
void arrow(PNT P, PNT Q) {arrow(P,V(P,Q)); }                                                            // draws arrow from P to Q
void show(PNT A, PNT B, PNT C)  {beginShape();  A.v(); B.v(); C.v(); endShape(CLOSE);}                   // render triangle A, B, C
void show(PNT A, PNT B, PNT C, PNT D)  {beginShape();  A.v(); B.v(); C.v(); D.v(); endShape(CLOSE);}      // render quad A, B, C, D




//************************************************************************
//**** VECTOR FUNCTIONS
//************************************************************************

// create 
VCT V(VCT V) {return new VCT(V.x,V.y); };                                                             // make copy of vector V
VCT V(PNT P) {return new VCT(P.x,P.y); };                                                              // make vector from origin to P
VCT V(float x, float y) {return new VCT(x,y); };                                                      // make vector (x,y)
VCT V(PNT P, PNT Q) {return new VCT(Q.x-P.x,Q.y-P.y);};                                                 // PQ (make vector Q-P from P to Q
VCT U(VCT V) {float n = n(V); if (n==0) return new VCT(0,0); else return new VCT(V.x/n,V.y/n);};      // V/||V|| (Unit vector : normalized version of V)
VCT U(PNT P, PNT Q) {return U(V(P,Q));};                                                                // PQ/||PQ| (Unit vector : from P towards Q)

// measure 
float dot(VCT U, VCT V) {return U.x*V.x+U.y*V.y; }                                                     // dot(U,V): U*V (dot product U*V)
float det(VCT U, VCT V) {return dot(R(U),V); }                                                         // det | U V | = scalar cross UxV 
float n(VCT V) {return sqrt(dot(V,V));};                                                               // n(V): ||V|| (norm: length of V)
float n2(VCT V) {return sq(V.x)+sq(V.y);};                                                             // n2(V): V*V (norm squared)
boolean parallel (VCT U, VCT V) {return dot(U,R(V))==0; }; 
float angle (VCT U, VCT V) {return atan2(det(U,V),dot(U,V)); };                                   // angle <U,V> (between -PI and PI)
float angle(VCT V) {return(atan2(V.y,V.x)); };                                                       // angle between <1,0> and V (between -PI and PI)
float angle(PNT A, PNT B, PNT C) {return  angle(V(B,A),V(B,C)); }                                       // angle <BA,BC>
float turnAngle(PNT A, PNT B, PNT C) {return  angle(V(A,B),V(B,C)); }                                   // angle <AB,BC> (positive when right turn as seen on screen)
int toDeg(float a) {return int(a*180/PI);}                                                           // convert radians to degrees
float toRad(float a) {return(a*PI/180);}                                                             // convert degrees to radians 
float positive(float a) { if(a<0) return a+TWO_PI; else return a;}                                   // adds 2PI to make angle positive

// weighted sum 
VCT W(float s,VCT V) {return V(s*V.x,s*V.y);}                                                      // sV
VCT W(VCT U, VCT V) {return V(U.x+V.x,U.y+V.y);}                                                   // U+V 
VCT W(VCT U,float s,VCT V) {return W(U,S(s,V));}                                                   // U+sV
VCT W(float u, VCT U, float v, VCT V) {return W(S(u,U),S(v,V));}                                   // uU+vV ( Linear combination)

// transformed 
VCT S(float s,VCT V) {return new VCT(s*V.x,s*V.y);};                                                  // sV
VCT M(VCT V) { return V(-V.x,-V.y); }                                                                 // -V
VCT R(VCT V) {return new VCT(-V.y,V.x);};                                                             // V turned right 90 degrees (as seen on screen)
VCT R(VCT V, float a) { return W(cos(a),V,sin(a),R(V)); }                                           // V rotated by angle a in radians
VCT Reflection(VCT V, VCT N) { return W(V,-2.*dot(V,N),N);};                                          // reflection OF V wrt unit normal vector N


// display 
void show(PNT P, VCT V) {line(P.x,P.y,P.x+V.x,P.y+V.y); }                                              // show V as line-segment from P 
void show(PNT P, float s, VCT V) {show(P,S(s,V));}                                                     // show sV as line-segment from P 
void arrow(PNT P, float s, VCT V) {arrow(P,S(s,V));}                                                   // show sV as arrow from P 
void arrow(PNT P, VCT V, String S) {arrow(P,V); P(P(P,0.70,V),15,R(U(V))).label(S,V(-5,4));}       // show V as arrow from P and print string S on its side
void arrow(PNT P, VCT V) 
  {
  show(P,V);  
  float n=n(V); 
  if(n<0.01) return;  // too short a vector
  // otherwise continue
     float s=max(min(0.2,20./n),6./n);       // show V as arrow from P 
     PNT Q=P(P,V); 
     VCT U = S(-s,V); 
     VCT W = R(S(.3,U)); 
     beginShape(); 
       v(P(P(Q,U),W)); 
       v(Q); 
       v(P(P(Q,U),-1,W)); 
     endShape(CLOSE);
  } 


// projection of point onto a line throgh two points
boolean projectsBetween(PNT P, PNT A, PNT B) {return dot(V(A,P),V(A,B))>0 && dot(V(B,P),V(B,A))>0 ; };
float disToLine(PNT P, PNT A, PNT B) {return abs(det(U(A,B),V(A,P))); };
PNT projectionOnLine(PNT P, PNT A, PNT B) {return P(A,dot(V(A,B),V(A,P))/dot(V(A,B),V(A,B)),V(A,B));}


//************************************************************************
//**** MOUSE AND SCREEN
//************************************************************************
PNT ScreenCenter() {return P(width/2,height/2);}                                                        //  point in center of  canvas
PNT Mouse() {return P(mouseX,mouseY);};                                                                 // returns point at current mouse location
PNT Pmouse() {return P(pmouseX,pmouseY);};                                                              // returns point at previous mouse location
VCT MouseDrag() {return new VCT(mouseX-pmouseX,mouseY-pmouseY);};                                      // vector representing recent mouse displacement

void showPointer() // shows pointer to current mouse location, which key is pressed, and whether mouse is pressed
  {
  PNT End = P(Mouse(),1,V(-2,3)), Start = P(End,20,V(-2,3)); // show semi-opaque grey arrow pointing to mouse location (useful for demos and videos)
  strokeWeight(4);  noFill(); stroke(grey,70); arrow(Start,End);
  if (mousePressed) {fill(white); show(Start,10);}
  if (keyPressed) 
    {
    fill(white); noStroke(); show(Start,8);    
    fill(black); 
    textAlign(CENTER, CENTER);
    scribe(str(key),Start.x,Start.y);
    textAlign(LEFT, BOTTOM);
    }
  }
