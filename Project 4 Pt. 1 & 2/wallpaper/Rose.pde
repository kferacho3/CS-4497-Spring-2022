int state = int(random(8));
//roseCurve class
class Rose {
  float d, n, k;
  int shiftX, shiftY, shiftZ;
  //constructor
  Rose(float d, float n, float k, int shiftX, int shiftY, int shiftZ) {

    this.d = d; 
    this.n = n;
    this.k = k; 
    this.shiftX = shiftX;
    this.shiftY = shiftY;
    this.shiftZ = shiftZ;

}
  void drawR(float intensity) {
    //k = n / d;
    float xx = 0;
    float yy = 0;
    beginShape();
    float col = random(255);
    
    //stroke(255);
    switch (state) {
      
              case 0:
              stroke(col, int(random(255)), random(255));
              break;
              case 1:
              stroke(int(random(255)), col, random(255));
              break;
              case 2:
              stroke(int(random(255)), int(random(255)), random(255));
              break;
              case 3:
              stroke(col, col, col);
              break;
              case 4:
              stroke(random(255), col, col);
              break;
              case 5:
              stroke(col, random(255), col);
              break;
              case 6:
              stroke(col, col, random(255));
              break;
              case 7:
              stroke(random(255), random(255), col);
              break;
            }
    noFill();
    
    strokeWeight(1);
    for (float a = 0; a < TWO_PI * d; a += 0.02) {
      float r = (25 * cos(k * a)) * (intensity);
      float x = r * cos(a);
      xx = x;
      float y = r * cos(a) * sin(a);
      yy = y;
      float z = r * sin(a) * sin(a);
      //float z = r * tan(a);
      vertex((x + shiftX) * intensity, (y + shiftY) * intensity, (z + shiftZ) * intensity);
      //line(x, y, x, y);
  }
    //strokeWeight(10);
    stroke(0, 128, 0);
    //line(xx, yy, 100, 300);
  endShape(CLOSE);
  }
}
