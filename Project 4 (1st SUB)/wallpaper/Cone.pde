
class Cone {
  //properties
  int sides;
  int shiftX, shiftY, shiftZ;
  float ang, d, h;
  PImage p, p2;
  //constructor
  Cone(int sides, float h, float d, int shiftX, int shiftY, int shiftZ, float ang, PImage p, PImage p2){

    this.sides = sides; 
    this.h = h;
    this.d = d; 
    this.shiftX = shiftX;
    this.shiftY = shiftY;
    this.shiftZ = shiftZ;
    this.ang = ang;
    this.p = p;
    this.p2 = p2;

}

/*main cube drawing method: It's just a bunch of rectangles drawn for each cube face using an equation */

  //int r1 = int(random(0, curr.width));
  //int r2 = int(random(0, curr.height));
  //int col = curr.get(r1, r2);
  
  //noFill();
  
  //rotate(30);
void drawC(float t) {
    
    PVector[] basePts = new PVector[sides];
    for (int i = 0; i < sides; ++i ) {
        float ang = TWO_PI * i / sides;
        basePts[i] = new PVector(cos(ang) * d/2, sin(ang) * d/2, -h/2);
    }
PShape cone = createShape();
if (texture) {
          cone.setTexture(p);
        } 
        if (texture2) {
          cone.setTexture(p2);
        }
    cone.beginShape(TRIANGLES);
    for (int i = 0; i < sides; ++i ) {
        //float hu = map(i, 0, total, 0, 255*6);
        //fill((hu + offset) % 255, 255, 255);
        //fill(col * intensityA);
        int i2 = (i+1) % sides;
        //strokeWeight(3);
        //stroke(col);
        if (texture) {
          cone.texture(p);
        } 
        if (texture2) {
          cone.texture(p2);
        }
        cone.vertex(basePts[i].x + shiftX, basePts[i].y + shiftY, basePts[i].z + shiftZ);
        cone.vertex(basePts[i2].x + shiftX, basePts[i2].y+shiftY, basePts[i2].z + shiftZ);
        cone.vertex(0 + shiftX, 0 + shiftY, h/2 + shiftZ);
    }
    cone.endShape();
    shape(cone);

    cone.beginShape();
    for (int i = 0; i < sides; ++i ) {
       if (texture) {
          cone.texture(p);
        } 
        if (texture2) {
          cone.texture(p2);
        }
        cone.vertex(basePts[i].x + shiftX, basePts[i].y + shiftY, basePts[i].z + shiftZ);
    }
    cone.endShape(CLOSE); 
    fill(255);
    shape(cone);
  }
}
