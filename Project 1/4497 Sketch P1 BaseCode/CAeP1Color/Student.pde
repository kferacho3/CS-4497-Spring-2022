//  STUDENT: IF POSSIBLE, PLEASE PUT ALL YOUR CODE IN THIS TAB
// places wher you need to add or change something are marked with ????

 
// //////////////////// student's contributions
// Title and help
/* ???? remove 4497 or 6497  */   
String title ="Class: CS4497/6497, Year: 2022, Project 01";   //      
String subtitle = "Accent, Ramp, Loop, Samples of palette defined by 3 colors";    

  /* ???? replace string below by your name (eg "Jarek ROSSIGNAC") */  
String name ="Kamal Feracho";

  /* ???? replace file \data\pic.jpg by a small (150x225 or so pixels) picture of your face  */  

// INTERPOLATION OF 3 POINTS OR 3 colors
// function for one of the blending weights (as discussed in the lecture) 
float u(float a, float b, float c, float t) 
  {
   /* ???? replace code below by your code of weight function ???? */  
  return ((((t-b)/(a-b)) * ((t-c)/(a-c)))) ;
  //return 0.5;
  }
float v(float a, float b, float c, float t) 
  {
  /* ???? replace code below by your code of weight function ???? */  
  return ((((t-a)/(b-a)) * ((t-c)/(b-c)))) ;
  //return 0.5;
  }
// Makes point at parameter s along pareabola through points A, B, C (uses u() defined above)
PNT Interpolate(float a, PNT A, float b, PNT B, float c, PNT C, float t)
  {
  /* ???? replace code below by your code ???? */  
  float u = u(a,b,c,t);
  float v = v(a,b,c,t);
  float w = 1 - u - v;
  return P(u, A,v, B,w,C);
  }

PNT Approximate(PNT A, PNT B, PNT C, float t)
  {
  /* ???? replace code below by your code ???? */  
   return P(P(A,t,B), t, P(B, t, C));
  }
  
// Makes color at parameter s along pareabola through CLRs A, B, C in the SCS (uses u() defined above)
CPNT Kinterpolation(float a, CPNT A, float b, CPNT B, float c, CPNT C, float t)
  {
  /* ???? replace code below by your code ???? */  
    float u = u(a,b,c,t);
    float v =((t-a)/(b-a))*((t-c)/(b-c));
    float w = 1 - u - v;
  
  return K(u*A.x+v*B.x+w*C.x,u*A.y+v*B.y+w*C.y,u*A.z+v*B.z+w*C.z);
  }

// Makes color at parameter s along pareabola through CLRs A, B, C in the SCS (uses u() defined above)
CPNT Kapproximation(float a, CPNT A, float b, CPNT B, float c, CPNT C, float t)
  {
  /* ???? replace code below by your code ???? */  
  return A(P((1-t),P((1-t),A,t,B)),P((t),P((1-t),B,t,C)));
  //return B;
  
  }

 
// LOOP: provide both interpolating and approximating variants for colored closed-loop
void showLoop()
  {
  if(interpolating)
  
    {
  /* ???? replace code below by your code ???? */ 
    PNT P4 = P(P1,P2,P3); // center of triangle
    PNT P5 = P(1,P1,1,P2,-1,P4); // top point
    PNT P6 = P(1,P2,1,P3,-1,P4); // right point
    PNT P7 = P(1,P3,1,P1,-1,P4); // bottom point

    CPNT C4 = P(0.5,C1,0.5,C2);
    CPNT C5 = P(0.5,C2,0.5,C3);
    CPNT C6 = P(0.5,C3,0.5,C1);

    ramp(P1,P5,P2,C1,C4,C2,interpolating);
    ramp(P2,P6,P3,C2,C5,C3,interpolating);
    ramp(P3,P7,P1,C3,C6,C1,interpolating);
     }
  else
    {
    CPNT AC1 = Kapproximation(0.5,C2,0.5,C3,0.5,C1,0.94);
CPNT AC2 = Kapproximation(0.5,C3,0.5,C1,0.5,C2,0.94);
CPNT AC3 = Kapproximation(0.5,C1,0.5,C2,0.5,C3,0.94);

CPNT AC12 = P(0.5,AC1,0.5,AC2);
CPNT AC23 = P(0.5,AC2,0.5,AC3);
CPNT AC31 = P(0.5,AC3,0.5,AC1);

// using ramp function with the interpolation mode as it make the curve look more pleasing
// note we used the approximation functions to get the starting colors so this I believe is valid since it goes through the approximated colors
ramp(A1,A12,A2,AC1,AC12,AC2,true);
ramp(A2,A23,A3,AC2,AC23,AC3,true);
ramp(A3,A31,A1,AC3,AC31,AC1,true);

  /* ???? replace code below by your code ???? */  
    }
  }
  
  
// TRIANGLE: Fill triangle
void showFilledTriangle()
  {
  noFill(); strokeWeight(2); if(mousePressed) disk(P,r+4,color(0)); 
  noStroke(); // do not draw border circle around the disks
  showTri(P1,P2,P3,C1,C2,C3,min(n-3,5)); // shows small disks inside triangle of points with selected colors
  
}
  
void showTri(PNT A, PNT B, PNT C, CPNT a, CPNT b, CPNT c, int rec) 
  {
  /* ???? you need not use a recursive call, as I did below ???? */ 
  
  showTri(A,B,C,a,b,c,150./(pow(2,rec)),rec);
  }

// Show colored disks inside triangle of points (A,B,C) with assigned colors (a,b,c) blended in the SCS 
void showTri(PNT A, PNT B, PNT C, CPNT a, CPNT b, CPNT c, float r, int rec) // recursive call
  {
   /* ???? if you use recursion, replace code below by your code ???? */
   disk(P(A,B,C),r,c(OKinSCS(a,b,c)));
  }
  

// ACCENT: Improve the computation of the accent color and jusify/discuss 
CPNT AccentColorInSCS(CPNT A, CPNT B, CPNT C)
  {
  /* ???? explain my code, provide your improvement, and compare ???? */  
  CPNT Ac = RGBcomplement(A), Bc = RGBcomplement(B), Cc = RGBcomplement(C);
  if(SCSname==_XYZ) {Ac = XYZfromRGB(Ac); Bc = XYZfromRGB(Bc); Cc = XYZfromRGB(Cc); };
  if(SCSname==_LAB) {Ac = LABfromRGB(Ac); Bc = LABfromRGB(Bc); Cc = LABfromRGB(Cc); };
  if(SCSname==_LCH) {Ac = LCHfromRGB(Ac); Bc = LCHfromRGB(Bc); Cc = LCHfromRGB(Cc); };
  CPNT R =  WAK(1./3,Ac,1./3,Bc,1./3,Cc);
  if(SCSname==_XYZ) R = RGBfromXYZ(R); 
  if(SCSname==_LAB) R = RGBfromLAB(R); 
  if(SCSname==_LCH) R = RGBfromLCH(R); 
  //return R;
  return R;
  }
