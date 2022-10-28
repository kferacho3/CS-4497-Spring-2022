//************************************************************************
//**** CIRCLES
//************************************************************************
// create 
PNT CircumCenter (PNT A, PNT B, PNT C) // CircumCenter(A,B,C): center of circumscribing circle, where medians meet)
  {
  VCT AB = V(A,B); VCT AC = R(V(A,C)); 
  return P(A,1./2/dot(AB,AC),W(-n2(AC),R(AB),n2(AB),AC)); 
  }
  
float circumRadius (PNT A, PNT B, PNT C)     // radiusCircum(A,B,C): radius of circumcenter 
  {
  float a=d(B,C), b=d(C,A), c=d(A,B), 
  s=(a+b+c)/2, 
  d=sqrt(s*(s-a)*(s-b)*(s-c)); 
  return a*b*c/4/d;
  } 

float [] xs = {0, -0.866, -0.866, 0, 0.866, 0.866};
float [] ys = {1, 0.5, -0.5, -1, -0.5, 0.5};
  
ArrayList<PNT> get_centers(PNT circumCenter, float r) {
   ArrayList<PNT> centers = new ArrayList<PNT>();
  float m = 1./3;
  r = r*m;
  float cirx = circumCenter.x;
  float ciry = circumCenter.y;
  
  for (int i=0; i<6; i++) {
    
    float cen2x = cirx+(2*r*xs[i]);
    float cen2y = ciry+(2*r*ys[i]);
    
    centers.add(P(cen2x, cen2y));
  }
  centers.add(circumCenter); // center for small middle circle
  centers.add(circumCenter); // center for big circle
  
  return centers;
}

ArrayList<PNT> get_kissing(PNT circumCenter, float r) {
  ArrayList<PNT> kissing = new ArrayList<PNT>();
  float m = 1./3;
  r = r*m;
  float cirx = circumCenter.x;
  float ciry = circumCenter.y;
  
  int exclude1 = 1;
  int exclude2 = 3;
  int exclude3 = 5;
  int tester = 2;
  
  for (int i=0; i<6; i++) {
    PNT test = P( (cirx+(3*r*xs[i])) ,(ciry+(3*r*ys[i])));
    kissing.add(test);
  }
  for (int i=0; i<6; i++) {
    PNT test = P( (cirx+(r*xs[i])) ,(ciry+(r*ys[i])));
    kissing.add(test);
  }
  for (int i=0; i<6; i++) {
    float cen2x = cirx+(2*r*xs[i]);
    float cen2y = ciry+(2*r*ys[i]);
    for (int x=0; x<6; x++) {
      if (x == tester){
        PNT test2 = P( (cen2x+(r*xs[x])) ,(cen2y+(r*ys[x])));
        kissing.add(test2);
      }
      
    }
    tester = (tester+1)%6;
    exclude1 = (exclude1+1)%6;
    exclude2 = (exclude2+1)%6;
    exclude3 = (exclude3+1)%6;
  }
  return kissing;
}

void circ(float r) {ellipse(0,0,r*2,r*2);}

void rings(float r, float m, int rec, int red)
{
  stroke(red, 100, 200);
  circ(r);
  push();
  if(rec>0)
  {
    scale(m);
    rings(r, m,rec-1, red+50);
    for(int w=0; w < 6; w++)
    {
      push();
      translate(0,r*2);
      rings(r, m, rec-1, red+50);
      pop();
      rotate(PI/3);
    } 
  }
  pop();
}

// display 
void drawCircleFast(int n) 
  {  
  float x=1, y=0; float a=TWO_PI/n, t=tan(a/2), s=sin(a); 
  beginShape(); 
    for (int i=0; i<n; i++) 
      {
      x-=y*t; y+=x*s; x-=y*t; 
      vertex(x,y);
      } 
  endShape(CLOSE);
  }


void showArcThrough (PNT A, PNT B, PNT C) 
  {
  if (abs(dot(V(A,B),R(V(A,C))))<0.01*d2(A,C)) {edge(A,C); return;}
  PNT O = CircumCenter ( A,  B,  C); 
  float r=d(O,A);
  VCT OA=V(O,A), OB=V(O,B), OC=V(O,C);
  float b = angle(OA,OB), c = angle(OA,OC); 
  if(0<c && c<b || b<0 && 0<c)  c-=TWO_PI; 
  else if(b<c && c<0 || c<0 && 0<b)  c+=TWO_PI; 
  beginShape(); 
    v(A); 
    for (float t=0; t<1; t+=0.01) v(R(A,t*c,O)); 
    v(C); 
    for (float t=0; t<1; t+=0.01) v(R(C,t*c,O)); 
  endShape();
  }



   
PNT pointOnArcThrough (PNT A, PNT B, PNT C, float t, int swapCount, int circleType, boolean update) 
   { 
   //if (abs(dot(V(A,B),R(V(A,C))))<0.001*d2(A,C)) {edge(A,C); return L(A,C,t);}
     PNT O = CircumCenter ( A,  B,  C); 
     float rot_speed;
     if (sync) {
       if (circleType == 0) {
         rot_speed = 0.01* intensity;
       } else {
         rot_speed = 0.03* intensity;
       }
      } else {
        if (circleType == 0) {
         rot_speed = 0.01;
       } else {
         rot_speed = 0.03;
       }
     }
  
     if (update) {rotator = rotator + PI;}
  
     if (swapCount % 2 == 0) {
       rotator = (rotator - rot_speed)%TWO_PI;
     } else {
       rotator = (rotator + rot_speed)%TWO_PI;
     }
     return R(A,rotator,O);
   }
   
   
PNT pointOnArcThrough2 (PNT A, PNT B, PNT C, float t, int swapCount, int circleType, boolean update) 
   { 
   //if (abs(dot(V(A,B),R(V(A,C))))<0.001*d2(A,C)) {edge(A,C); return L(A,C,t);}
     PNT O = CircumCenter ( A,  B,  C); 
     float rot_speed;
     if (sync) {
       if (circleType == 0) {
         rot_speed = 0.01* intensity;
       } else {
         rot_speed = 0.03* intensity;
       }
      } else {
        if (circleType == 0) {
         rot_speed = 0.01;
       } else {
         rot_speed = 0.03;
       }
     }
  
     if (update) {rotator2 = rotator2 + PI;}
  
     if (swapCount % 2 == 0) {
       rotator2 = (rotator2 - rot_speed)%TWO_PI;
     } else {
       rotator2 = (rotator2 + rot_speed)%TWO_PI;
     }
     return R(A,rotator2,O);
   }
   
PNT pointOnArcThrough3 (PNT A, PNT B, PNT C, float t, int swapCount, int circleType, boolean update) 
   { 
   //if (abs(dot(V(A,B),R(V(A,C))))<0.001*d2(A,C)) {edge(A,C); return L(A,C,t);}
     PNT O = CircumCenter ( A,  B,  C); 
     float rot_speed;
     if (sync) {
       if (circleType == 0) {
         rot_speed = 0.01* intensity;
       } else {
         rot_speed = 0.03* intensity;
       }
      } else {
        if (circleType == 0) {
         rot_speed = 0.01;
       } else {
         rot_speed = 0.03;
       }
     }
  
     if (update) {rotator3 = rotator3 + PI;}
  
     if (swapCount % 2 == 0) {
       rotator3 = (rotator3 - rot_speed)%TWO_PI;
     } else {
       rotator3 = (rotator3 + rot_speed)%TWO_PI;
     }
     return R(A,rotator3,O);
   }

PNT pointOnArcThrough4 (PNT A, PNT B, PNT C, float t, int swapCount, int circleType, boolean update) 
   { 
   //if (abs(dot(V(A,B),R(V(A,C))))<0.001*d2(A,C)) {edge(A,C); return L(A,C,t);}
     PNT O = CircumCenter ( A,  B,  C); 
     float rot_speed;
     if (sync) {
       if (circleType == 0) {
         rot_speed = 0.01* intensity;
       } else {
         rot_speed = 0.03* intensity;
       }
      } else {
        if (circleType == 0) {
         rot_speed = 0.01;
       } else {
         rot_speed = 0.03;
       }
     }
  
     if (update) {rotator4 = rotator4 + PI;}
  
     if (swapCount % 2 == 0) {
       rotator4 = (rotator4 - rot_speed)%TWO_PI;
     } else {
       rotator4 = (rotator4 + rot_speed)%TWO_PI;
     }
     return R(A,rotator4,O);
   }
   
 PNT pointOnArcThrough5 (PNT A, PNT B, PNT C, float t, int swapCount, int circleType, boolean update) 
   { 
   //if (abs(dot(V(A,B),R(V(A,C))))<0.001*d2(A,C)) {edge(A,C); return L(A,C,t);}
     PNT O = CircumCenter ( A,  B,  C); 
     float rot_speed;
      if (sync) {
       if (circleType == 0) {
         rot_speed = 0.01* intensity;
       } else {
         rot_speed = 0.03* intensity;
       }
      } else {
        if (circleType == 0) {
         rot_speed = 0.01;
       } else {
         rot_speed = 0.03;
       }
     }
  
     if (update) {rotator5 = rotator5 + PI;}
  
     if (swapCount % 2 == 0) {
       rotator5 = (rotator5 - rot_speed)%TWO_PI;
     } else {
       rotator5 = (rotator5 + rot_speed)%TWO_PI;
     }
     return R(A,rotator5,O);
   }
   
 PNT pointOnArcThrough6 (PNT A, PNT B, PNT C, float t, int swapCount, int circleType, boolean update) 
   { 
   //if (abs(dot(V(A,B),R(V(A,C))))<0.001*d2(A,C)) {edge(A,C); return L(A,C,t);}
     PNT O = CircumCenter ( A,  B,  C); 
     float rot_speed;
     if (sync) {
       if (circleType == 0) {
         rot_speed = 0.01* intensity;
       } else {
         rot_speed = 0.03* intensity;
       }
      } else {
        if (circleType == 0) {
         rot_speed = 0.01;
       } else {
         rot_speed = 0.03;
       }
     }
     if (update) {rotator6 = rotator6 + PI;}
  
     if (swapCount % 2 == 0) {
       rotator6 = (rotator6 - rot_speed)%TWO_PI;
     } else {
       rotator6 = (rotator6 + rot_speed)%TWO_PI;
     }
     return R(A,rotator6,O);
   }
   
   
   
