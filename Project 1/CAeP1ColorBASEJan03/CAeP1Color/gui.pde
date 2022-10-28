void keyPressed() 
  {
  if(key=='!') {snapJPG=true; println("saved pix to: MyImages/"+PicturesFileName+"/P"+SCSname+nf(pictureCounterJPG,3)+".jpg");}// make a .PDF picture of the canvas, compact, poor quality
  if(key==',') {n=max(3,n-1);  } 
  if(key=='.') {n++; }
  if(key=='<') {n=int((n+1)/2);  if(n<3) n=3; } 
  if(key=='>') {n=2*n-1; }
  if(key=='G') {SCSname=_RGB; SCS = "RGB"; makeColors();}
  if(key=='X') {SCSname=_XYZ; SCS = "XYZ"; makeColors();}
  if(key=='P') {SCSname=_LAB; SCS = "LAB"; makeColors();} 
  if(key=='H') {SCSname=_LCH; SCS = "LCH"; makeColors();}
  if(key=='C') showing=_cover;
  if(key=='D') showing=_disks;
  if(key=='R') showing=_ramp;
  if(key=='L') showing=_loop;
  if(key=='T') showing=_area;
  if(key=='i') interpolating=!interpolating;
  if(key=='s') setClipboard("CLR C1=K"+Si(C1)+", C2=K"+Si(C2)+", C3=K"+Si(C3)+";");
  if(key=='f') {PicturesFileName=getClipboard(); println("PicturesFileName = "+PicturesFileName+" .");}
  if(key=='m') makeColors();
  if(key=='d') makeDisks(); 
  if(key=='#') 
    {
    if(selectedColor==1) C1 = CLRfromClipboard(); 
    if(selectedColor==2) C2 = CLRfromClipboard(); 
    if(selectedColor==3) C3 = CLRfromClipboard();
    setSpaceColorsFromSelectedColor();
    //SCSname=_RGB; updateColors();
    }
  if(key=='1') {selectedColor=1; setSpaceColorsFromSelectedColor();}
  if(key=='2') {selectedColor=2; setSpaceColorsFromSelectedColor();}
  if(key=='3') {selectedColor=3; setSpaceColorsFromSelectedColor();}
  if(key=='K') {showColor = !showColor; }
  }
void mousePressed() 
  {
  P=P1;
  PNT M = Mouse();
  if(d(P2,M)<d(P,M)) P=P2;
  if(d(P3,M)<d(P,M)) P=P3;
  }
void mouseDragged() 
  {
  if(!keyPressed) P.setTo(O(Pmouse(),Mouse(),P));
  else
    {
    if(key=='r') {K_RGB.x+=100.*float(mouseX-pmouseX)/width; SCSname=_RGB;}
    if(key=='g') {K_RGB.y+=100.*float(mouseX-pmouseX)/width; SCSname=_RGB;}
    if(key=='b') {K_RGB.z+=100.*float(mouseX-pmouseX)/width; SCSname=_RGB;}
    if(key=='l') {K_LCH.x+=100.*float(mouseX-pmouseX)/width; SCSname=_LCH;}
    if(key=='c') {K_LCH.y+=100.*float(mouseX-pmouseX)/width; SCSname=_LCH;}
    if(key=='h') {K_LCH.z+=360.*float(mouseX-pmouseX)/width/4; SCSname=_LCH;}
    if(key=='x') {K_XYZ.x+=256.*float(mouseX-pmouseX)/width; SCSname=_XYZ;}
    if(key=='y') {K_XYZ.y+=256.*float(mouseX-pmouseX)/width; SCSname=_XYZ;}
    if(key=='z') {K_XYZ.z+=256.*float(mouseX-pmouseX)/width; SCSname=_XYZ;}
    updateColors();    
    }
  }
  
