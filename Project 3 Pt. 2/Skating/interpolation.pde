
//************************************************************************
//**** INTERPOLATING PAREMETRIC MOTION
//************************************************************************
// Linear
PNT L(PNT A, PNT B, float t) {return P(A.x+t*(B.x-A.x),A.y+t*(B.y-A.y));}
PNT L(float a, PNT A, float b, PNT B, float t) {return L(A,B,(t-a)/(b-a));}
PNT L(float a, PNT A, float b, PNT B, float c, PNT C, float t) {return L(a,L(a,A,b,B,t),c,L(b,B,c,C,t),t);}


// Linear interpolation of vectors
VCT L(VCT A, VCT B, float t) {return V(A.x+t*(B.x-A.x),A.y+t*(B.y-A.y));}
VCT L(float a, VCT A, float b, VCT B, float t) {return L(A,B,(t-a)/(b-a));}
VCT L(float a, VCT A, float b, VCT B, float c, VCT C, float t) {return L(a,L(a,A,b,B,t),c,L(b,B,c,C,t),t);}

// Log-spiral Interpolation 
VCT S(VCT U, VCT V, float s) // steady interpolation from U to V
  {
  float a = angle(U,V); 
  VCT W = R(U,s*a); 
  float u = n(U), v=n(V); 
  return W(pow(v/u,s),W); 
  } 
VCT S(float a, VCT A, float b, VCT B, float t) {return S(A,B,(t-a)/(b-a));}
VCT S(float a, VCT A, float b, VCT B, float c, VCT C, float t) {return S(a,S(a,A,b,B,t),c,S(b,B,c,C,t),t);}
