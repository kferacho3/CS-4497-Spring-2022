

boolean mainC = false;
//determines whether to texturize moons with main texture or random textures
boolean self = false;

//Planet ast1;
//PeasyCam cam;


float phase = 0;
float zoff = 0;
float speed;
float angle;
float px, py, an;
int time = 0;
int limit = 30;
//determines random asteroid case
int asteroid = int(random(0, 4));


//random moons
int ranM = int(random(0, 10));
//random perspect
int ranPe = int(random(0,1));
int ranD;
int ranP = int(random(0,100));




int mode;
int kmode;
int threeDm;
float x = random(255);
float y = random(255);
float z = random(255);
boolean texture = false;
boolean texture2 = false;
int circleResolution;
void keyPressed() 
{
  if(key=='!') snapPicture();
  if(key=='@') {scribeText = !scribeText;}
  if(key=='~') filming=!filming;
  if(key=='+') 
  {
    WP.num_i += 1;
    WP.num_j += 1;
  }
  if(key=='-') 
  {
    WP.num_i = max(WP.num_i - 1, 1);
    WP.num_j = max(WP.num_j - 1, 1);
  }
  if(key=='0') 
  {
    WP.wallpaper_id = (WP.wallpaper_id+1)%17;
    WP.resetGeometry();
    WP.resetSymmetries();
    WP.U = Va(a, U_direction);
    WP.V = Va(a, V_direction);
  }
  
  
  
  
  
  
  // *********************************************** TOGGLE THROUGH NORMAL MODES 0-10 ************************************
  if(key=='1') 
  {
    mode = (mode +1)%11;
  }
  
  // *********************************************** TOGGLE THROUGH NESTED KALEIDOSCOPE MODES ************************************
  if(key=='2') 
  {
    kmode = (kmode +1)%6;
  }
  
  // *********************************************** TOGGLE THROUGH NESTED 3D AND SPECIAL MODES ************************************
   if(key=='3') 
  {
    threeDm = (threeDm +1)%9;
  }
  
  // *********************************************** CHANGE DIRECTLY TO KALEDOSCOPE MODE ************************************
   if(key=='4') 
  {
    mode = 2;
  }
  
  // *********************************************** CHANGE DIRECTLY TO 3D AND SPECIAL MODE ************************************
  if(key=='5') 
  {
    mode = 10;
  }
  
  
  
  
  
  
  
  
  
     // *********************************************** Toggle Textures ************************************
  if(key=='t') 
  {
    if (texture2) {
      texture2 = !texture2;
    }
    texture = !texture;
  }
       // *********************************************** Randomize Textures ************************************
  if(key=='6') 
  {
  plans = int(random(100));
    
  }
  // *********************************************** Activates second set of Textures ************************************
  
  if(key=='p') {
    if (texture) {
      texture = !texture;
    }
    texture2 = !texture2;
  }
  
  // *********************************************** Randomize second set of Textures2 ************************************
  if(key=='7') { 
   
   text = int(random(29));
  }
  
  
  
  
  
  
  
  
  
  if(key=='a') {WP.addVertexFromPick(Pick);}  
  if(key=='A') 
  {
  }
  if(key=='c') {WP.resetGeometry();}
  if(key=='f') {showF = !showF;}
  if(key=='g') {show_colored_cells = !show_colored_cells;}
  if(key=='h') {show_symmetry_grid = !show_symmetry_grid;}
  if(key=='G') {show_master_cell = !show_master_cell;}
  if(key=='i') {display_vertices = !display_vertices;}
  if(key=='I') {display_edges = !display_edges;}
  if(key=='k') {show_only_master_geometry = !show_only_master_geometry;}

  if(key=='s') {edge_radius *= 1.1;}
  if(key=='S') {edge_radius /= 1.1;}

  if(key=='>') showFrame=!showFrame;
  if(key=='#') exit();
  change = true;
}

void mouseWheel(MouseEvent event) 
{
  //Zoom in/out
  camera_z -= 5*event.getCount(); 
  change = true;
}

void mouseReleased() 
{ 
  change = true; 
}

void mouseClicked() 
{
  change = true;
}
  
void mouseMoved() 
{
  change = true;
  
  //Rotate the view
  if (keyPressed && key==' ') {
    camera_rx-=PI*(mouseY-pmouseY)/height; 
    camera_ry+=PI*(mouseX-pmouseX)/width;
  }
  
  //Zoom in/out of the view
  if (keyPressed && key=='z') 
  {
    camera_z+=(float)(mouseY-pmouseY); 
    change=true;
  }
}
  
void mouseDragged() 
{
  change = true;
  
  if (keyPressed && key=='u') {
    WP.U = A(WP.U, V((mouseX-pmouseX), (mouseY-pmouseY), 0.));
    WP.setLatticeVectors();
  }
  if (keyPressed && key=='v') {
    WP.V = A(WP.V, V((mouseX-pmouseX), (mouseY-pmouseY), 0.));
    WP.setLatticeVectors();
  }
  if (keyPressed && key=='o') {
    WP.O = P(WP.O, V((mouseX-pmouseX), (mouseY-pmouseY), 0.));
  }
  if (keyPressed && key=='m') {
    translation_vector = A(translation_vector, V((mouseX-pmouseX), (mouseY-pmouseY), 0.));
  }
  if (keyPressed && key=='r') {
    rotation_angle += 0.001*(mouseX-pmouseX);
  }
  if (keyPressed && key=='s') {
    scale_amount += 0.001*(mouseX-pmouseX);
  }
  
}
