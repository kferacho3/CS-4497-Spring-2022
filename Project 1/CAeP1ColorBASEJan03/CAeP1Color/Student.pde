//  STUDENT: IF POSSIBLE, PLEASE PUT ALL YOUR CODE IN THIS TAB
// places wher you need to add or change something are marked with ????

 
// //////////////////// student's contributions
// Title and help
/* ???? remove 4497 or 6497  */   
String title ="Class: CS4497/6497, Year: 2022, Project 01";   //      
String subtitle = "Accent, Ramp, Loop, Samples of palette defined by 3 colors";    

  /* ???? replace string below by your name (eg "Jarek ROSSIGNAC") */  
String name ="Kamal Feracho";
String guide="rgb:G xyz:X Lab:P Lch:H col:C123#rgblchs,.<> dsk:Ddm crv:RiL tri:T pix:f!"; // help info

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
  return P(P(A,t,C), t, P(B, t, C));
  }
  
// Makes color at parameter s along pareabola through CLRs A, B, C in the SCS (uses u() defined above)
CLR Kinterpolation(float a, CLR A, float b, CLR B, float c, CLR C, float t)
  {
    float u = u(a,b,c,t);
    float v =((t-a)/(b-a))*((t-c)/(b-c));
    float w = 1 - u - v;
  
  return K(u*A.x+v*B.x+w*C.x,u*A.y+v*B.y+w*C.y,u*A.z+v*B.z+w*C.z);
  /* ???? replace code below by your code ???? */  
 
  }

// Makes color at parameter s along pareabola through CLRs A, B, C in the SCS (uses u() defined above)
CLR Kapproximation(float a, CLR A, float b, CLR B, float c, CLR C, float t)
  {
  /* ???? replace code below by your code ???? */  
    float u = u(a,b,c,t);
    float v =((t-a)/(b-a))*((t-c)/(b-c));
    float w = 1 - u - v;
    Approximate(P(A.x, A.y), P(B.x, B.y), P(C.x, C.y), t);
    return K(u*A.x+v*B.x+w*C.x,u*A.y+v*B.y+w*C.y,u*A.z+v*B.z+w*C.z);
  
  }


  
 
// LOOP: provide both interpolating and approximating variants for colored closed-loop
void showLoop()
  {
  if(interpolating)
    {
  /* ???? replace code below by your code ???? */  
     }
  else
    {
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
  
void showTri(PNT A, PNT B, PNT C, CLR a, CLR b, CLR c, int rec) 
  {
  /* ???? you need not use a recursive call, as I did below ???? */  
  showTri(A,B,C,a,b,c,150./(pow(2,rec)),rec);
  }

// Show colored disks inside triangle of points (A,B,C) with assigned colors (a,b,c) blended in the SCS 
void showTri(PNT A, PNT B, PNT C, CLR a, CLR b, CLR c, float r, int rec) // recursive call
  {
   /* ???? if you use recursion, replace code below by your code ???? */
   disk(P(A,B,C),r,c(OKinSCS(a,b,c)));
  }
  

// ACCENT: Improve the computation of the accent color and jusify/discuss 
CLR AccentColorInSCS(CLR A, CLR B, CLR C)
  {
  /* ???? explain my code, provide your improvement, and compare ???? */  
  CLR Ac = RGBcomplement(A), Bc = RGBcomplement(B), Cc = RGBcomplement(C);
  if(SCSname==_XYZ) {Ac = XYZfromRGB(Ac); Bc = XYZfromRGB(Bc); Cc = XYZfromRGB(Cc); };
  if(SCSname==_LAB) {Ac = LABfromRGB(Ac); Bc = LABfromRGB(Bc); Cc = LABfromRGB(Cc); };
  if(SCSname==_LCH) {Ac = LCHfromRGB(Ac); Bc = LCHfromRGB(Bc); Cc = LCHfromRGB(Cc); };
  CLR R =  WAK(1./3,Ac,1./3,Bc,1./3,Cc);
  if(SCSname==_XYZ) R = RGBfromXYZ(R); 
  if(SCSname==_LAB) R = RGBfromLAB(R); 
  if(SCSname==_LCH) R = RGBfromLCH(R); 
  //return R;
  return R;
  }
