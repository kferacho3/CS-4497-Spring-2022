// ******************************** PLANAR ISOMETRIES ************************
// TRANSLATE: this function takes as input a point P, and returns a new point 
// which is the result of translating P by vector V.
// SOLUTION PROVIDED
public pt Translate(pt P, vec V)
{
  return P(P, V);
}

// ROTATE: This function takes as input a point P, rotation center O and rotation amount a
// and returns a new point which is obtained by rotating P about O by the angle a clockwise.
// SOLUTION PROVIDED
public pt Rotate(pt P, pt O, float a)
{
  return R(P, a, V(1,0,0), V(0,1,0), O); 
}

// MIRROR: This function takes as input a point P, and a mirror axis which passes through O and which is along unit vector V
// and returns a new point which is the result of reflecting P about this axis.
// STUDENT CODE BELOW
public pt Mirror(pt P, pt reflection_axis_pt, vec reflection_axis_vec)
{
  
  
  
  //eq: r = d - 2(d • n) * n where (d • n) is the dot roduct and n is normalized
  //vec M(vec U, vec V) {return V(U.x-V.x,U.y-V.y,U.z-V.z);}; 
  //vec U(pt P, pt Q) {return U(V(P,Q));};                                                                 // PQ/||PQ||
  vec n = U(P, reflection_axis_pt);
 // n.normalize();
 // vec Va(float s, vec A) {return new vec(s*A.x,s*A.y,s*A.z); };                                           // sA
  vec s1 = Va(d(reflection_axis_vec, n)* 2, reflection_axis_vec);
  vec s2 = M(reflection_axis_vec, s1);
  float x = s2.x;
  float y = s2.y;
  float z = s2.z;
  P.x -= x;
  P.y -= y;
  P.z -= z;
  
  
  
  
  /*
  //eq.2: p = p - (2(p - q) • U)*U (othogonal vecs UU <---)
  //pt P(float s, pt A) {return new pt(s*A.x,s*A.y,s*A.z); };                                            // sA
  //pt A(pt A, pt B) {return new pt(A.x+B.x,A.y+B.y,A.z+B.z); };                                         // A+B
  //pt P(pt P, float s, vec V) {return new pt(P.x+s*V.x,P.y+s*V.y,P.z+s*V.z);}   // P+sV
  //p = reflection_axis_vec
  //P =p, 
  //vec N(vec U, vec V) {return V( U.y*V.z-U.z*V.y, U.z*V.x-U.x*V.z, U.x*V.y-U.y*V.x); };   // UxV cross product (normal to both)
  vec UU = reflection_axis_vec.normalize();
  vec norms = new vec(1,0,0);
  norms = norms.normalize();
  vec U = N(UU, norms);
 // vec s1 = Va(d(reflection_axis_vec, n)* 2, reflection_axis_vec);
  pt p = P;
  pt O = WP.O;
 // vec M(vec V) {return V(-V.x,-V.y,-V.z);};                                                              // -V
  float a = d(Va(2, reflection_axis_vec), U);
  //vec s1 = Va(d(Va(2, reflection_axis_vec), U)* 2, reflection_axis_vec);
  U = Va(a, U);
  //vec Va(float s, vec A) {return new vec(s*A.x,s*A.y,s*A.z); };                                           // sA
  //vec V(pt P, pt Q) {return new vec(Q.x-P.x,Q.y-P.y,Q.z-P.z);};                                          // PQ
  //pt P(float s, pt A) {return new pt(s*A.x,s*A.y,s*A.z); };                                            // sA
  //pt q = p;

 // vec n = U(P, reflection_axis_pt);
  //n.normalize();
  //pt q = P(reflection_axis_pt, 1/4, reflection_axis_vec);
  //q = P(-2, q);
  */
  
  
  
  /*
  
  vec UU = reflection_axis_vec.normalize();
  vec norms = new vec(0,1,0);
  norms = norms.normalize();
  vec U = N(UU, norms);
  pt p = P;
  pt q = reflection_axis_pt;
//eq.2: p = p - (2(p - q) • U)*U (othogonal vecs UU <---)
 
  vec d = V(P, q);
  float ddd = d(Va(2, d), U);
  //float ddd = reflection_axis_vec.x*U.x + reflection_axis_vec.y*U.y + reflection_axis_vec.z+U.z;
  vec zzz = Va(ddd, U);
  //zzz.normalize();
  P.x -= zzz.x;
  P.y -= zzz.y;
  P.z -= zzz.z;
     */
  return P;
}

// GLIDE: Recall that a glide can be thought of as a composition of a mirror followed by a translation along mirror axis.
// This function takes as input a point P, the mirror axis and translation distance (dist).
// The output should be a new point obtained as a result of glide reflection of P along given axis by the distance. 
// STUDENT CODE BELOW
public pt Glide(pt P, pt glide_axis_pt, vec glide_axis_vec, float dist)
{
  //pt P(pt P, float s, vec V) {return new pt(P.x+s*V.x,P.y+s*V.y,P.z+s*V.z);}                           // P+sV
  pt g = Mirror(P, glide_axis_pt, V(0,1,0));
  //P = P(g, dist, glide_axis_vec);'
  vec norms = glide_axis_vec.normalize();
  vec trans = Va(dist, norms);

  pt glide = Translate(g, trans);
 // P.z+= dist;
 // P.y+= dist;
  //P.x+= dist;
  //pt q = P(glide_axis_pt, 1/4, glide_axis_vec);
  //P = P(g, glide_axis_vec);
//  P.x += (g.x - dist);
  //  P.y += (g.y - dist);
    //  P.z += (g.z - dist);
  
  return glide;
}

// *********************************************** WALLPAPER SYMMETRIES ************************************
// The code below sets the generating symmetries for each wallpaper group.
// You are expected to define the generating symmetries for each wallpaper group here.
// An example for one wallpaper group is provided to illustrate this.
// Refer to the slides for more information on generating symmetries.

// Some information on the data structure being used:
// The symmetry class stores our set of symmetries.
// We first define the symmetry type by a string: either "TRANSLATE", "ROTATE", "MIRROR", "GLIDE" or "IDENTITY" (default).
// In addition to this, depending on the type of symmetries, we need further parameters.
// Translation symmetry needs a translation vector (vec)
// Rotation symmetry needs the origin (pnt) and a rotation amount (float).
// Mirror symmetry needs an axis, defined by a point that the axis passes through (pnt) and a vector along the axis (vec)
// Glide symmetry needs an axis, defined by (pnt) and (vec) as above; plus a translation amount (float) along the axis vector.

// Some examples of each symmetry are shown below (note: these are intentionally different from the symmetries in the wallpaper groups). 
// Translation symmetry w.r.t vector (100,0) : T = new symmetry("TRANSLATE", V(100, 0));
// 5-fold rotation symmetry about origin : R = new symmetry("ROTATE", P(0,0), PI/5);
// Mirror symmetry about Y-axis: M = new symmetry("MIRROR", P(0,0,0), V(0,1,0));
// Glide reflection symmetry about X-axis with translation of 50:  G = new symmetry("GLIDE", P(0,0), V(1,0), 50));


void setWallpaperSymmetries()
{
  // Translation vectors
  vec U = WP.U;
  vec V = WP.V;
  
  // Origin
  pt O = WP.O;
  
  //STUDENT CODE BELOW.
  //Add cases for each of the 17 wallpaper groups i.e. wallpaper_id goes from 0 to 16
  // by adding their appropriate generating symmetries.
  // An example is shown below for the case wallpaper_id = 1 (two translations and a 2-fold rotation).
  switch(WP.wallpaper_id) {
    case 0:
      //Add stuff here and make new cases
      WP.addSymmetry(new symmetry("TRANSLATE", U));
       WP.addSymmetry(new symmetry("ROTATE", O, 60 * (PI/180)));
      
      symmetry G0 = new symmetry("GLIDE", O, V(1, 0, 0), n(U)/2);
      WP.addSymmetry(G0);
      
      break;
    case 1:
      WP.addSymmetry(new symmetry("TRANSLATE", U));
      WP.addSymmetry(new symmetry("TRANSLATE", V));
      WP.addSymmetry(new symmetry("ROTATE", O, PI));
      
      break;
     // add the corresponding symmetries for remaining cases...
     case 2:
      WP.addSymmetry(new symmetry("TRANSLATE", U));
      WP.addSymmetry(new symmetry("TRANSLATE", V));
      WP.addSymmetry(new symmetry("MIRROR", O, V));
      break;
     case 3:
     
      WP.addSymmetry(new symmetry("TRANSLATE", U));
      WP.addSymmetry(new symmetry("TRANSLATE", V));
      WP.addSymmetry(new symmetry("GLIDE", O, V(1, 0, 0), n(U)/2));
      break;
      //Diag
      case 4:
      WP.addSymmetry(new symmetry("TRANSLATE", U));
      WP.addSymmetry(new symmetry("TRANSLATE", V));
      WP.addSymmetry(new symmetry("MIRROR", O, V));
      break;
      case 5:
      WP.addSymmetry(new symmetry("TRANSLATE", U));
      WP.addSymmetry(new symmetry("TRANSLATE", V));
      WP.addSymmetry(new symmetry("ROTATE", O, PI));
      WP.addSymmetry(new symmetry("MIRROR", O, U(1,0,0)));
      break;
      case 6:
      WP.addSymmetry(new symmetry("TRANSLATE", U));
      WP.addSymmetry(new symmetry("TRANSLATE", V));
      WP.addSymmetry(new symmetry("ROTATE", O, PI));
      symmetry G6 = new symmetry("GLIDE", O, V(1, 0, 0), n(U)/2);
      WP.addSymmetry(G6);
      break;
      //OFF
      case 7:
      WP.addSymmetry(new symmetry("TRANSLATE", U));
      WP.addSymmetry(new symmetry("TRANSLATE", V));
      WP.addSymmetry(new symmetry("ROTATE", O, PI));
      symmetry G7 = new symmetry("GLIDE", P(O, Va(0.25, V)), U(1,0,0), n(U)/2);
      WP.addSymmetry(G7);
      break;
      
      
      //DIAG
      case 8:
      WP.addSymmetry(new symmetry("TRANSLATE", U));
      WP.addSymmetry(new symmetry("TRANSLATE", V));
      WP.addSymmetry(new symmetry("ROTATE", O, PI));
      WP.addSymmetry(new symmetry("MIRROR", O, M(U(0,1,0),V(1,0,0))));
      break;
      
      case 9:
      WP.addSymmetry(new symmetry("TRANSLATE", U));
      WP.addSymmetry(new symmetry("TRANSLATE", V));
      WP.addSymmetry(new symmetry("ROTATE", O, 90 * (PI/180)));
      break;
      case 10:
      WP.addSymmetry(new symmetry("TRANSLATE", U));
      WP.addSymmetry(new symmetry("TRANSLATE", V));
      WP.addSymmetry(new symmetry("ROTATE", O, 90 * (PI/180)));
      WP.addSymmetry(new symmetry("MIRROR", O, U));
      break;
      
      
      //OFF
      case 11:
      WP.addSymmetry(new symmetry("TRANSLATE", U));
      WP.addSymmetry(new symmetry("TRANSLATE", V));
      WP.addSymmetry(new symmetry("ROTATE", O, 90 * (PI/180)));
      symmetry G11 = new symmetry("GLIDE", P(O, Va(0.25, V)), U(1,0,0), n(U)/2);
      WP.addSymmetry(G11);
      break;
      
      
      
      
      case 12:
      WP.addSymmetry(new symmetry("TRANSLATE", U));
      WP.addSymmetry(new symmetry("TRANSLATE", V));
      WP.addSymmetry(new symmetry("ROTATE", O, 120 * (PI/180)));
      break;
      case 13:
      WP.addSymmetry(new symmetry("TRANSLATE", U));
      WP.addSymmetry(new symmetry("TRANSLATE", V));
      WP.addSymmetry(new symmetry("ROTATE", O, 120 * (PI/180)));
      WP.addSymmetry(new symmetry("MIRROR", O, U(0,1,0)));
      break;
      
      //DIAG
      case 14:
      WP.addSymmetry(new symmetry("TRANSLATE", U));
      WP.addSymmetry(new symmetry("TRANSLATE", V));
      WP.addSymmetry(new symmetry("ROTATE", O, 120 * (PI/180)));
      WP.addSymmetry(new symmetry("MIRROR", O, M(U,V(1,0,0))));
      break;
      case 15:
      WP.addSymmetry(new symmetry("TRANSLATE", U));
      WP.addSymmetry(new symmetry("TRANSLATE", V));
      WP.addSymmetry(new symmetry("ROTATE", O, 60 * (PI/180)));
      break;
      case 16:
      WP.addSymmetry(new symmetry("TRANSLATE", U));
      WP.addSymmetry(new symmetry("TRANSLATE", V));
      WP.addSymmetry(new symmetry("ROTATE", O, 60 * (PI/180)));
      WP.addSymmetry(new symmetry("MIRROR", O, U));
      break;
    default:
      break;
  }
}

// ******************************** CUSTOM GEOMETRY ************************

// This function creates the geometry for letter "F" inside the wallpaper pattern.
// You can use this as a reference to generate more creative geometry, and animate it with time.
// You can use the variable frameCount to help with animation.
// Feel free to replace the contents of this function to draw your thing instead, or create a new function.

//REPLACE this function with your animated GIF
void makeGeometry()
{
  //Translation and rotation using mouse drag
  translate(translation_vector.x, translation_vector.y, translation_vector.z);
  rotateZ(rotation_angle);
  scale(scale_amount);
  
  //Draw F using three simple ellipses
  
  int max_frames = 90; if(frame>max_frames) frame = 0; float t = sq(cos(TWO_PI*frame/max_frames));
// ******************************************************************************************************* PART TWO IMPLEMENTATION ************************************
  switch(mode) {
    // *********************************************** "F" Mode ************************************
    case 0:
    stroke(red); strokeWeight(1); fill(blue);
      ellipse(2.*a/5, -a/24, t*a/4, a/30);
      ellipse(a/3.6, -a/8, a/30, a/7);
      ellipse(2.*a/5, -a/8, a/30, a/10);
    break;
    
    // *********************************************** Broken Heart Mode ************************************
    case 1:
    beginShape();
    stroke(red); strokeWeight(5); fill(blue);
    for (float rad = 0; rad < TWO_PI * .0001; rad += 0.02) {
        float r = random(-1, 1);
        float i = (7 * ((round(asin(4.86*r))))/ 2 + 10* pow(atan(r), 2));
        float j = (7 * pow(acos(r/4.86), 2));
       
        point(i, j);
        flove(i, j, t);
        vertex(j, i);
        }
      endShape(CLOSE);
    break;
    
    // *********************************************** Kaleidoscope Mode ************************************
    case 2:
      float mx = mouseX-width/2;
      float my = mouseY-height/2;
      float pmx = pmouseX-width/2;
      float pmy = pmouseY-height/2;
      float symmetry = int(random(20));
      
      if(mousePressed){
        float angle = 360 / symmetry;
        float d = dist(mx,my,pmx,pmy);
        float sw = map(d,0,8,8,1);
        float offset = t;
        
    
        strokeWeight(random(1,5));
        //stroke(255);
        float z = random(255);
            float y = random(255);
            float x = random(255);
        for(float i = 0; i < TWO_PI * .0001; i += 0.02){
          float hu = map(i, 0, i, 0, 255*6);
          switch (kmode) {
            case 0:
            
          stroke(z, y, x);
            rotate(angle);
            pushMatrix();
            line(mx*t,my*t,pmx*t,pmy*t);
            popMatrix();
            pushMatrix();
            scale(-1,1);
            line(mx*t,my,pmx,pmy*t);
            // ellipse(mx,my,1);
            popMatrix();
            break;
            //ellipse mode
            case 1:
            stroke(x, y, z);
            rotate(angle);
            pushMatrix();
            ellipse(mx*t,my*t,pmx*t,pmy*t);
            popMatrix();
            pushMatrix();
            scale(-1,1);
            ellipse(mx*t,my,pmx,pmy*t);
            // ellipse(mx,my,1);
            popMatrix();
            break;
            //box mode
            case 2:
            stroke(random(100), x, random(50, 250));
            rotate(angle);
            pushMatrix();
            box(mx*t,my*t,pmx*t);
            popMatrix();
            pushMatrix();
            scale(-1,1);
            box(mx*t,my,pmx);
            // ellipse(mx,my,1);
            popMatrix();
            break;
            case 3:
            stroke(y, x, random(255));
            rotate(angle);
            pushMatrix();
            point(mx*t, my*t);
            popMatrix();
            pushMatrix();
            scale(-1,1);
            point(mx*t, my*t);
            // ellipse(mx,my,1);
            popMatrix();
            break;
            case 4:
            lerp(int(x), int(y), z);
            stroke(lerp(int(x), int(y), z), lerp(int(z), int(x), y), random(255));
            rotate(angle);
            pushMatrix();
            if (i % 2048 == 0) {
            sphere(mx*t);
            }
            popMatrix();
            pushMatrix();
            scale(-1,1);
            if (i % 2048 == 0) {
            sphere(my*t);
            };
            // ellipse(mx,my,1);
            popMatrix();
            break;
            case 5:
            stroke(random(100), lerp(int(x), int(y), z), random(100));
            rotate(angle);
            pushMatrix();
            bezier(mx*t,my*t,pmx*t,pmy*t, pmy*t, pmx*t, my*t, mx*t);
            popMatrix();
            pushMatrix();
            scale(-1,1);
            bezier(mx*t,my*t,pmx*t,pmy*t, pmy*t, pmx*t, my*t, mx*t);
            // ellipse(mx,my,1);
            popMatrix();
            break;
          }
    }
  }
    break;
    
    
    // *********************************************** Sun Mode ************************************
    case 3:
       sun(random(3) / 10 * t, random(3) / 10 * t, t * random(1));
    break;
    
    // *********************************************** Moon Mode ************************************
    case 4:
       moon(random(3) / 10 * t, random(3) / 10 * t, t * random(1));
    break;
    
    // *********************************************** Rainbow mode ************************************
    case 5:
    rainbow(random(3) / 10 * t, random(3) / 10 * t,   t);
    break;
    
    // *********************************************** random face mode ************************************
    case 6:
    float x = random(200);
    float y = random(200);
    float z = random(200);
    
    head(100, 100, t);
    break;
    
    // *********************************************** "diamond" mode ************************************
    case 7:
    diamond(500, 500, t*5);
    break;
    
    // *********************************************** recursive tree mode ************************************
    case 8:
     int xx = int(random(50));
    float yy = random(50);
    branch((int) xx,(int) yy, random(30),t* 20);
    break;
    // *********************************************** recursive pattern of ellipses mode ************************************
    case 9:
    float xxx = random(400);
    float yyy = random(400);
    pattern( xxx, yyy,  t* 20);
    break;
    
    // *********************************************** 3D mode + bonus curve and rainbow mode ************************************
    case 10:
    
    pushMatrix();
        circleResolution = (int)map(t*5, 0, 0.3, 3, 100);
        radius = random(200)/2;
        float angle = TWO_PI/circleResolution;
        beginShape();
    
        for (int i=0; i<=circleResolution; i++) {
          float xShape = 0 + cos(angle*i) * radius;
          float yShape = 0 + sin(angle*i) * radius;
         
          //vertex(xShape, yShape);
          translate(xShape, yShape);
          switch (threeDm) {
            
           case 0:
                if (i % 8 == 0) {
                  stroke(red); strokeWeight(1); fill(blue);
               box(xShape);
             }
             break;
             
             // *********************************************** SPHERES ************************************
             case 1:
             if (i % 32 == 0) {
               stroke(red); strokeWeight(1); fill(blue);
               sphere(xShape);
             }
             break;
             
             // *********************************************** ICOSAHEDRONS ************************************
             case 2:
               if (i % 256 == 0) {
                Icosahedron ico1 = new Icosahedron(75 * t, (int)xShape, (int)yShape, 0, planets[plans], textures[text]);
                ico1.create();
               }
             break;
             
             // *********************************************** CONES ************************************
             case 3:
             if (i % 256 == 0) {
               
               Cone c = new Cone(int(random(25, 35)), random(25, 50), random(25, 50), (int)xShape, (int) yShape, int(random(100)), int(random(100)), planets[plans], textures[text]);
               c.drawC(t);
                
             }
             break;
             
             // *********************************************** ROSES ************************************
             case 4:
             if (i % 64 == 0) {
               Rose rose = new Rose(random(5, 15), random(5, 15), xShape, (int) yShape, 0, 0);
              rose.drawR(t);
             }
             break;
             
             // *********************************************** BEZIER CURVES ************************************
             case 5:
             if (i % 4096 == 0) {
               curve(xShape*30, yShape*30, xShape*30, yShape*30, xShape*30, xShape*30, yShape*30, yShape*30);
             }
             break;
             
             // *********************************************** RAINBOWS ************************************
             case 6:
             if (i % 32 == 0) {
               rainbow(xShape, yShape, t);
             }
             break;
             case 7:
             if (i % 2048 ==0) {
               
                Cube c = new Cube(random(25, 50), random(25, 50), random(25, 50), xShape, yShape, yShape, planets[plans], textures[text]);
                c.drawCube(t);
                Cube c2 = new Cube(random(5, 10), random(5, 10), random(5, 10), xShape, yShape, yShape, planets[plans], textures[text]);
                c2.drawCube(t);
             }
             
             break;
             
             case 8:
             if (i % 1024 ==0) {
               
             Planets(xShape *t / 10, yShape*t, random(100), planets[plans], textures[text]);
             }
             break;
             
             
             
  
             
            }
        }
        endShape();
        popMatrix();
    break;
  }
  
  }
  //
  



//Various Classes for geometries (hearts, kaleidoscope, 3D shapes) and actual things such as faces, trees, etc.


// ****************************** Recursive Pattern for ellipses Code ************************************

void pattern (float x, float y, float s) {
  float r = map(s, 200, 5, 50, 10);
  float z = 250 * noise (r / 5);
fill (random(z) + random(s), random(220), lerp(random(255), x, y));
  stroke (random(z) + random(s) + random(50),lerp(random(134), y, y), random(150));
  //coloring(state);
  circle (x, y, s);
  if (s > 5) {
    pattern (x, y, s / 2);
    pattern (x - s / 2, y, s / 2);
    pattern (x + s / 2, y, s / 2);
    pattern (x, y + s / 0.5, s / 2);
  }
}

// ****************************** Diamond Creation Code  ************************************
void diamond(float xx, float yy, float amplitude) {
 //creates diamond shape 
  stroke(#A3D2FF); //darker blue 

  strokeWeight(amplitude/5.5);
  
  beginShape(); 
  triangle(random(10) * amplitude,  random(20) * amplitude, random(15)  * amplitude, random(10)  * amplitude, random(20) * amplitude,  random(20)* amplitude);
  triangle(random(20) * amplitude,  random(10)  * amplitude, random(25) * amplitude,  random(20)  * amplitude, random(30) * amplitude, random(10)* amplitude); //2
  triangle(random(30) * amplitude,  random(20)  * amplitude, random(35) * amplitude,  random(10)  * amplitude, random(40) * amplitude,  random(20)* amplitude); //3
  triangle(random(40) * amplitude,  random(10)  * amplitude, random(45) * amplitude,  random(20)  * amplitude, random(50) * amplitude,  random(10)* amplitude); //4
  triangle(random(50) * amplitude,  random(20)  * amplitude, random(55) * amplitude,  random(10)  * amplitude, random(60) * amplitude,  random(20)* amplitude); //5      
  triangle(random(10) * amplitude,  random(25)  * amplitude, random(25) * amplitude,  random(25)  * amplitude, random(30) * amplitude,  random(60)* amplitude); //bottom row of triangles
  triangle(random(30) * amplitude,  random(25)  * amplitude, random(40) * amplitude,  random(25)  * amplitude, random(35) * amplitude,  random(63)* amplitude);
  triangle(random(45) * amplitude,  random(25)  * amplitude, random(60) * amplitude,  random(25)  * amplitude, random(40) * amplitude,  random(60)* amplitude);
  endShape();
}

// ****************************** Broken Hearts Code ************************************
void flove(float x, float y, float s) {
  translate(x, y);
    circle(175*s, 150*s, 79*s);
    circle(250*s, 150*s, 81*s);
    triangle(215*s, 295*s, 292*s, 155*s, 133*s, 150*s);
    fill(82, 7, 62);
    rect(0, 0, 20*s, 36*s);
    fill(20*s, 20*s, 41*s);
    rect(0, 36*s, 20*s, 36*s);
    fill(238, 255, 0);
    rect(0, 72*s, 20*s, 36*s);
    fill(142, 186, 191);
    rect(0, 108*s, 20*s, 36*s);
    stroke(0,0,0);
    line(212*s, 138*s, 190*s, 159*s);
    line(190*s, 159*s, 230*s, 180*s);
    line(230*s, 180*s, 200*s, 200*s);
    line(200*s, 200*s, 239*s, 217*s);
    line(239*s, 217*s, 205*s, 237*s);
    line(205*s, 237*s, 230*s, 245*s);
    line(230*s, 245*s, 205*s, 260*s);
    line(205*s, 260*s, 215*s, 290*s);
}
 float rads;
 float distance;
 float angs;
 float orbitspeed;
 PVector v;
 PShape texturee;
 boolean spin = true;

void Planets(float r, float d, float o, PImage img, PImage img2) {
    v = PVector.random3D();
    rads = r;
    distance = d;
    v.mult(distance);
    angs = random(TWO_PI);
    orbitspeed = o;
    
    
    texturee = createShape(SPHERE, radius);
    fill(255);
    if (texture) {
    texturee.setTexture(img);
    } 
    if (texture2) {
      texturee.setTexture(img2);
    }
    shape(texturee);
  }

// ****************************** Recursive code for trees  ************************************
void branch(float len, float sw, float c, float t)
{
  //stroke(col, random(255), random(255), t);
  //stroke(random(255), col, random(255), t);
  //stroke(random(255),  random(255),col, t);
  //coloring3(state1);
  strokeWeight(3);
  stroke(120, lerp(z, x, y), random(199), 67);
  line(0, 0, 0, -len);
  translate(0, -len);
  len*=0.8;
  sw *= 0.8;
  c += 2;
  t *= 0.9;
  
  if(len > random(1, 25))
  {
    int n = int(random(1, 4));
    for(int i = 0; i < n; i++)
    {
      float theta = random(-PI/4, PI/4);
      pushMatrix();
      rotate(theta);
      branch(len,sw, c, t);
      popMatrix();
    }
  }

}


//function that draws a "sun" failed attempt
void sun(float x, float y, float s) {
  translate(x-35, y);
  fill(#FEF4D9);
  ellipse(650*s, 325*s, 170*s, 147*s);
  fill(#B62121);
  ellipse(650*s, 325*s, 165*s, 142*s);
  fill(#FEECBC);
  ellipse(650*s, 325*s, 150*s, 128*s);
  fill(#B62121);
  ellipse(650*s, 325*s, 140*s, 118*s);
  fill(#FFE9AF);
  ellipse(650*s, 325*s, 130*s, 108*s);
  fill(#FAD97F);
  ellipse(650*s, 325*s, 120*s, 98*s);
  fill(#FFD564);
  triangle(480*s, 280*s, 670*s, 315*s, 630*s, 335*s);
  fill(#FFD564);
  triangle(820*s, 280*s, 670*s, 335*s, 630*s, 315*s);
  fill(#FFD564);
  triangle(560*s, 175*s, 670*s, 325*s, 630*s, 325*s);
  fill(#FFD564);
  triangle(740*s, 175*s, 670*s, 325*s, 630*s, 325*s);
  fill(#E6A810);
  ellipse(650*s, 325*s, 100*s, 78*s);
  fill(#FFD564);
  triangle(900*s, 325*s, 670*s, 315*s, 630*s, 335*s);
  fill(#FFD564);
  triangle(400*s, 325*s, 670*s, 315*s, 630*s, 335*s);
  fill(#FFD564);
  triangle(450*s, 200*s, 670*s, 325*s, 630*s, 325*s);
  fill(#FFD564);
  triangle(850*s, 200*s, 670*s, 325*s, 630*s, 325*s);
  fill(#FFD564);
  triangle(650*s, 100*s, 664*s, 325*s, 636*s, 325*s);
  fill(#E6A810);
  ellipse(650*s, 325*s, 90*s, 68*s);
  fill(#E6C210);
  ellipse(650*s, 325*s, 75*s, 54*s);
  fill(#F9F502);
  ellipse(650*s, 325*s, 60*s, 40*s);
  fill(#B92466);
}



// ****************************** function that makes rainbows ************************************
void rainbow(float x, float y, float s) {
  pushMatrix();
  translate(x + 30, y);
  rotate(135);
  stroke(255, 0, 0);
 noFill();
  bezier(0,100 *s,100*s,10*s,100*s,400*s,400*s,0);
    stroke(255, 140, 0);
  bezier(0,110*s,100*s,20*s,100*s,410*s,400*s,15*s);
    stroke(255, 255, 0);
  bezier(0,120*s,100*s,30*s,100*s,420*s,400*s,30*s);
   stroke(0, 255, 0);
  bezier(0,130*s,100*s,40*s,100*s,430*s,400*s,45*s);
    stroke(0, 0, 255);
  bezier(0,140*s,100*s,50*s,100*s,440*s,400*s,60*s);
  fill(67, 186, 249);
  //bezier(0,150*s,100*s,60*s,100*s,450*s,400*s,75*s);
  stroke(255, 140, 0);
  //bezier(0,160*s,100*s,70*s,100*s,460*s,400*s,90*s);
  stroke(255, 255, 0);
  //bezier(0,170*s,100*s,80*s,100*s,470*s,400*s,105*s);
  stroke(0, 255, 0);
  //bezier(0,180*s,100*s,90*s,100*s,480*s,400*s,120*s);
  stroke(0, 0, 255);
  //bezier(0,190*s,100*s,100*s,100*s,490*s,400*s,135*s);
  popMatrix();
}

// ****************************** function that creates moons ************************************
void moon(float x, float y, float s) {
  translate(x-35, y);
  //moon
  noStroke();
  
  fill(220, 223, 226);
  circle(500*s, 300*s, 200*s);
  
  fill(122, 123, 124);
  circle(600*s,400*s,30*s);
  circle(400*s,300*s,100*s);
  circle(500*s,150*s,50*s);
  

  
  fill(171, 174, 178);
  circle(420*s,305*s,80*s);
  circle(590*s,392*s,20*s);
  circle(490*s,150*s,30*s);
  
  fill (229, 230, 232);
  circle(488*s,149*s,20*s);
  
  
  //stars 
  fill(255, 251, 206);
  ellipse(0, 0, 5*s, 5*s);
}

// ****************************** function that creates faces ************************************
void head(float x, float y, float s) {
    translate(x-25, y);
    //ears
    int rface = int(random(5));
    int[] head = {#8D5524, #C68642, #E0AC69, #F1C27D, #FFDBAC};
  noStroke();
  fill(255, 225, 190);
  ellipse(150*s, 300*s, 50*s, 50*s);
  ellipse(450*s, 300*s, 50*s, 50*s);
  fill(255, 170, 150);
  ellipse(150*s, 300*s, 30*s, 30*s);
  ellipse(450*s, 300*s, 30*s, 30*s);
  
  //face
  noStroke();
  //fill(255, 225, 190);
  fill(head[rface]);
  ellipse(300*s, 300*s, 290*s, 290*s);
  strokeWeight(11*s);
  stroke(255*s, 225*s, 190*s); 
  
  //mouth
  strokeWeight(10*s);
  stroke(205, 115, 115);
  line(260*s, 400*s, 280*s, 400*s);
  
  // tooth 
  strokeWeight(10*s);
  stroke(205, 115, 115);
  line(260*s, 400*s, 280*s, 400*s);
  
  //smile
  strokeWeight(11*s);
      stroke(255, 225, 190);
      line(260*s, 400*s, 280*s, 400*s);
      strokeWeight(10*s);
      stroke(205, 115, 115);
      bezier(200*s, 350*s, 220*s, 420*s, 350*s, 400*s, 350*s, 400*s);
      
      
      //eye
  noStroke();
  fill(255);
  ellipse(240*s, 260*s, random(100)*s, random(100)*s);
  ellipse(360*s, 260*s, random(100)*s, random(100)*s);
  //fill(r, 170, 130);
  ellipse(240*s, 260*s, 40*s, 40*s);
  ellipse(360*s, 260*s, 40*s, 40*s);
  noStroke();
  fill(0);
  ellipse(240*s, 260*s, 20*s, 20*s);
  ellipse(360*s, 260*s, 20*s, 20*s);
      
  }
  
  void coin(float x, float y, float s) {
  pushMatrix();
  //translate(x, y);
  fill(255, 255, 0);
  stroke(255, 165, 0);
  strokeWeight(3);
  ellipse(x, y, 80 * s, 80* s);
  rectMode(0);
  fill(255, 165, 0);
  //noStroke(0);
  rect(x+10* s, y+10* s, 5* s, 15* s);
  rect(x-10* s, y-10* s, 5* s, 15* s);
  rect(x, y, 20* s, 5* s);
  rect(x+1* s, y-18* s, 20* s, 5* s);
  rect(x, y+18* s, 21* s, 5* s);
  rect(x, y, 5* s, 52* s);
    popMatrix();
}









// ****************************************************************************** END OF PART TWO IMPLEMENTATION ************************************

//Students DO NOT need to edit this function, unless they want to go back to the 
//older version of the base code by uncommenting the second line. If so, read comment.
void drawSampleGeometry()
{
  //This function displays the geometry you construct using the makeGeometry() function
  WP.displayGeometry();
  
  //OLD VERSION. Students don't need to use or edit this; but you can uncomment the below function call
  //if you want to display the stuff passed to the WP object using the function setSampleGeometry()
  //This function displays the geometry that's added to the wallpaper object WP. By default, this is letter "F".
  //Edit the code in setSampleGeometry() to pass other stuff to WP instead of "F" and display that instead.

  //WP.displayGeometryOld();
}

//OLD VERSION. Students DO NOT need to use or edit this; but you CAN if you want to go back to the old version 
//of the base code or are interested in using the WP class.
//This function shows an example of adding a shape to the WP class.
//We first construct each vertex of the letter "F" as a point object. 
//Each vertex is then added to the WP class and then edges between the
//appropriate vertices are defined.
void setSampleGeometry()
{
  // Clear any existing geometry in the wallpaper pattern
  WP.resetGeometry();
  
  // Variables used for orienting "F" correctly
  pts P = WP.getMasterTile();
  pt B = P(P.G[0], P.G[1]);
  vec X = Va(2*a, U(V(P.G[1], P.G[0])));
  vec Y = M(R(X));
  
  //Construct vertices corresponding to endpoints for drawing the letter "F"
  pt F1 = P(B, V(0.02, Y, -0.03, X));
  pt F2 = P(F1, 0.05, X);
  pt F3 = P(F1, 0.03, Y);
  pt F4 = P(F2, 0.06, Y);
  pt F5 = P(F1, -0.08, X);
  
  //Add these five vertices to the vertex list of the wallpaper pattern
  int v1 = WP.addPt(F1);
  int v2 = WP.addPt(F2);
  int v3 = WP.addPt(F3);
  int v4 = WP.addPt(F4);
  int v5 = WP.addPt(F5);
  
  //Add edges between the appropriate vertices to the wallpaper pattern
  WP.addEdge(v1, v2);
  WP.addEdge(v1, v3);
  WP.addEdge(v1, v5);
  WP.addEdge(v2, v4);
}

// ******************************** WARP USING COTS MAP ************************

//You may use extra helper functions, or modify code inside of any of the other files as needed. 
//Below are two possible approaches, you may do it any way you like using one or both or neither of these.

//Approach 1: Pressing the "~" button turns on "filming" which saves every frame drawn on the canvas as as an image.
//This is saved in the folder ./FRAMES as a .tif file.
//You can then sequentially import these images in the COTS base code provided and then apply the COTS mapping to them to show an animation

//OR

//Approach 2: Implement the math for the COTS mapping here, from the other base code.
//You can then write a function which takes in the four corners of the COTS map (A,B,C,D) and two parameters (u,v) and otuput the new location corresponding to (u,v)
//The parameters (u,v) correspond to the points of interest of your shape. There may be artifacts when doing this for circles, unless you approximate a circle as a polygon.
//If using my WP class, you can also figure out (u,v) coordinates of every point in WP, then pass those in, and display the output points.
//For a reference on how to display vertices and edges, see the function WP.displayGeometry().

//Use if needed (for Approach 2)
pt cots(pt A, pt B, pt C, pt D, float u, float v)
{
  //WP.getPt(i) returns the coordinates of the i-th point in the WP class
  //WP.getPt(i, u, v, s, t) returns the location of the i-th point after ...
  //...applying the first symmetry u times, second symmetry v times, third symmetry s times and fourth symmetry t times
  //WP.num_v is the number of vertices
 
 return P(u,v,0.0);
}
