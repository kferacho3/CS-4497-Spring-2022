int duckCount = 666;
COLOR_RAMP ramp = new COLOR_RAMP(duckCount);
COLOR_RAMP ramp2 = new COLOR_RAMP(duckCount);
PNT [] Duckling = new PNT[duckCount];
PNT [] Duckling2 = new PNT[duckCount];
PNT [] Duckling3 = new PNT[duckCount];
PNT [] Duckling4 = new PNT[duckCount];
PNT [] Duckling5 = new PNT[duckCount];
PNT [] Duckling6 = new PNT[duckCount];


void initDucklings()
  {
  for(int d=0; d<duckCount; d++) Duckling[d]=P();
  for(int d=0; d<duckCount; d++) Duckling2[d]=P();
  for(int d=0; d<duckCount; d++) Duckling3[d]=P();
  for(int d=0; d<duckCount; d++) Duckling4[d]=P();
  for(int d=0; d<duckCount; d++) Duckling5[d]=P();
  for(int d=0; d<duckCount; d++) Duckling6[d]=P();
  }
  

void advanceDucklings(PNT M)
  {
  Duckling[0].setTo(M);
  for(int d=1; d<duckCount; d++) Duckling[d].dilateWrtPNT(0.5,Duckling[d-1]); 
  }
  
void showDucklings()
  {
  for(int d=0; d<duckCount; d++) 
    {
    swf(black,1,ramp.col(d));
    if (synth) {
    coloring(state);
    }
    if (d == duckCount - 1) {
      float circleResolution = (int)map(intensity, 0.33, 0.5, 3, 5);
      float radius = intensity/2;
      float angle = TWO_PI/circleResolution;
      for (int i=0; i<=circleResolution; i++) {
          float xShape = 0 + cos(angle*Duckling[d].x) * radius;
          float yShape = 0 + sin(angle*Duckling[d].y) * radius;
          vertex(xShape, yShape);
        }
      } else {
    show(Duckling[d],10);
      }
    }
  }
  
void advanceDucklings2(PNT M)
  {
  Duckling2[0].setTo(M);
  for(int d=1; d<duckCount; d++) Duckling2[d].dilateWrtPNT(0.5,Duckling2[d-1]); 
  }
  
void showDucklings2()
  {
  for(int d=0; d<duckCount; d++) 
    {
    swf(black,1,ramp.col(d));
    if (synth) {
    coloring(state);
    }
    show(Duckling2[d],10);
    }
  }
  
  
void advanceDucklings3(PNT M)
  {
  Duckling3[0].setTo(M);
  for(int d=1; d<duckCount; d++) Duckling3[d].dilateWrtPNT(0.5,Duckling3[d-1]); 
  }
  
void showDucklings3()
  {
  for(int d=0; d<duckCount; d++) 
    {
    swf(black,1,ramp.col(d));
    if (synth) {
    coloring(state);
    }
    show(Duckling3[d],10);
    }
  }
  
void advanceDucklings4(PNT M)
  {
  Duckling4[0].setTo(M);
  for(int d=1; d<duckCount; d++) Duckling4[d].dilateWrtPNT(0.5,Duckling4[d-1]); 
  }
  
void showDucklings4()
  {
  for(int d=0; d<duckCount; d++) 
    {
    swf(black,1,ramp.col(d));
    if (synth) {
    coloring(state);
    }
    show(Duckling4[d],10);
    }
  }
  
  void advanceDucklings5(PNT M)
  {
  Duckling5[0].setTo(M);
  for(int d=1; d<duckCount; d++) Duckling5[d].dilateWrtPNT(0.5,Duckling5[d-1]); 
  }
  
void showDucklings5()
  {
  for(int d=0; d<duckCount; d++) 
    {
    swf(black,1,ramp.col(d));
    if (synth) {
    coloring(state);
    }
    show(Duckling5[d],10);
    }
  }
  
  void advanceDucklings6(PNT M)
  {
  Duckling6[0].setTo(M);
  for(int d=1; d<duckCount; d++) Duckling6[d].dilateWrtPNT(0.5,Duckling6[d-1]); 
  }
  
void showDucklings6()
  {
  for(int d=0; d<duckCount; d++) 
    {
    swf(black,1,ramp.col(d));
    if (synth) {
    coloring(state);
    }
    show(Duckling6[d],10);
    }
  }
  
