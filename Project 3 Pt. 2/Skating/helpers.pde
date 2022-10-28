float [] speeds = {0.005, 0.01, 0.03, 0.0666, 0.12};

//float [] rotations = {0,0,0,0,0,0};
float [] rotations = {0,PI/3,2*PI/3,PI,4*PI/3,5*PI/3};

float getRotation (int rotVal, int S, int swapCount, int circleType, boolean update) 
   { 
     float rotate;
     rotate = rotations[rotVal];
     float rot_speed;
     
     rot_speed = speeds[S] * (circleType+1);
  
     if (update) {rotator = rotator + PI;}
  
     if (swapCount % 2 == 0) {
       rotator = (rotator - rot_speed)%TWO_PI;
     } else {
       rotator = (rotator + rot_speed)%TWO_PI;
     }
     return rotate;
   }
   
 PNT rotatePoint (PNT A, PNT B, PNT C, float rot) 
 { 
   PNT O = CircumCenter (A,B,C); 
   return R(A,rot,O);
 }
   
   
