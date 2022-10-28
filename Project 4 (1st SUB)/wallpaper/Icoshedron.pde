
class Icosahedron extends Shape3D{

  // icosahedron
  PVector topPoint;
  PVector[] topPent = new PVector[5];
  PVector bottomPoint;
  PVector[] bottomPent = new PVector[5];
  float angle = 0, radius = 150;
  float triDist;
  float triHt;
  float a, b, c;
  int shiftX, shiftY, shiftZ;
  PImage p, p2;
  // constructor
  Icosahedron(float radius, int shiftX, int shiftY, int shiftZ, PImage p, PImage p2){
    this.radius = radius;
    this.shiftX = shiftX;
    this.shiftY = shiftY;
    this.shiftZ = shiftZ;
    this.p = p;
    this.p2 = p2;
    init();
  }

  Icosahedron(PVector v, float radius){
    super(v);
    this.radius = radius;
    init();
  }

  // calculate geometry
  void init(){
    c = dist(cos(0)*radius, sin(0)*radius, cos(radians(72))*radius,  sin(radians(72))*radius);
    b = radius;
    a = (float)(Math.sqrt(((c*c)-(b*b))));

    triHt = (float)(Math.sqrt((c*c)-((c/2)*(c/2))));

    for (int i=0; i<topPent.length; i++){
      topPent[i] = new PVector(cos(angle)*radius, sin(angle)*radius, triHt/2.0f);
      angle+=radians(72);
    }
    topPoint = new PVector(0, 0, triHt/2.0f+a);
    angle = 72.0f/2.0f;
    for (int i=0; i<topPent.length; i++){
      bottomPent[i] = new PVector(cos(angle)*radius, sin(angle)*radius, -triHt/2.0f);
      angle+=radians(72);
    }
    bottomPoint = new PVector(0, 0, -(triHt/2.0f+a));
  }

  // draws icosahedron 
  void create(){
    for (int i=0; i<topPent.length; i++){
   
      // icosahedron top
      //float hu = map(i, 0, total, 0, 255*6);
      //fill((hu + offset) % 255, 255, 255);
      
      PShape ico = createShape();
      if (texture) {
          ico.setTexture(p);
        } 
        if (texture2) {
          ico.setTexture(p2);
        }
      ico.beginShape();
      if (i<topPent.length-1){
        if (texture) {
          ico.texture(p);
        } 
        if (texture2) {
          ico.texture(p2);
        }
        ico.vertex(x+topPent[i].x + shiftX, y+topPent[i].y + shiftY, z+topPent[i].z + shiftZ);
        ico.vertex(x+topPoint.x + shiftX, y+topPoint.y + shiftY, z+topPoint.z + shiftZ);
        ico.vertex(x+topPent[i+1].x + shiftX, y+topPent[i+1].y + shiftY, z+topPent[i+1].z + shiftZ);
      } 
      else {
        if (texture) {
          ico.texture(p);
        } 
        if (texture2) {
          ico.texture(p2);
        }
       ico.vertex(x+topPent[i].x + shiftX, y+topPent[i].y + shiftY, z+topPent[i].z + shiftZ);
        ico.vertex(x+topPoint.x + shiftX, y+topPoint.y + shiftY, z+topPoint.z + shiftZ);
        ico.vertex(x+topPent[0].x + shiftX, y+topPent[0].y + shiftY, z+topPent[0].z + shiftZ);
      }
      ico.endShape(CLOSE);

      // icosahedron bottom
      ico.beginShape();
      if (i<bottomPent.length-1){
        if (texture) {
          ico.texture(p);
        } 
        if (texture2) {
          ico.texture(p2);
        }
        ico.vertex(x+bottomPent[i].x + shiftX, y+bottomPent[i].y + shiftY, z+bottomPent[i].z + shiftZ);
        ico.vertex(x+bottomPoint.x + shiftX, y+bottomPoint.y + shiftY, z+bottomPoint.z + shiftZ);
        ico.vertex(x+bottomPent[i+1].x + shiftX, y+bottomPent[i+1].y + shiftY, z+bottomPent[i+1].z + shiftZ);
      } 
      else {
        if (texture) {
          ico.texture(p);
        } 
        if (texture2) {
          ico.texture(p2);
        }
        ico.vertex(x+bottomPent[i].x + shiftX, y+bottomPent[i].y + shiftY, z+bottomPent[i].z + shiftZ);
        ico.vertex(x+bottomPoint.x + shiftX, y+bottomPoint.y + shiftY, z+bottomPoint.z + shiftZ);
        ico.vertex(x+bottomPent[0].x + shiftX, y+bottomPent[0].y + shiftY, z+bottomPent[0].z + shiftZ);
      }
      ico.endShape(CLOSE);
      fill(255);
      shape(ico);
    }

    // icosahedron body
    for (int i=0; i<topPent.length; i++){
      //float hu = map(i, 0, total, 0, 255*6);
      //fill((hu + offset) % 255, 255, 255);
PShape ico = createShape();
if (texture) {
          ico.setTexture(p);
        } 
        if (texture2) {
          ico.setTexture(p2);
        }
      //rotate(radians(frameCount));
      if (i<topPent.length-2){
        ico.beginShape();
        if (texture) {
          ico.texture(p);
        } 
        if (texture2) {
          ico.texture(p2);
        }
        ico.vertex(x+topPent[i].x + shiftX, y+topPent[i].y + shiftY, z+topPent[i].z + shiftZ);
        ico.vertex(x+bottomPent[i+1].x + shiftX, y+bottomPent[i+1].y + shiftY, z+bottomPent[i+1].z + shiftZ);
        ico.vertex(x+bottomPent[i+2].x + shiftX, y+bottomPent[i+2].y + shiftY, z+bottomPent[i+2].z + shiftZ);
        ico.endShape(CLOSE);

        ico.beginShape();
        if (texture) {
          ico.texture(p);
        } 
        if (texture2) {
          ico.texture(p2);
        }
        ico.vertex(x+bottomPent[i+2].x + shiftX, y+bottomPent[i+2].y + shiftY, z+bottomPent[i+2].z + shiftZ);
        ico.vertex(x+topPent[i].x + shiftX, y+topPent[i].y + shiftY, z+topPent[i].z + shiftZ);
        ico.vertex(x+topPent[i+1].x + shiftX, y+topPent[i+1].y + shiftY, z+topPent[i+1].z + shiftZ);
        endShape(CLOSE);
      } 
      else if (i==topPent.length-2){
      
        ico.beginShape();
        if (texture) {
          ico.texture(p);
        } 
        if (texture2) {
          ico.texture(p2);
        }
        ico.vertex(x+topPent[i].x + shiftX, y+topPent[i].y + shiftY, z+topPent[i].z + shiftZ);
        ico.vertex(x+bottomPent[i+1].x + shiftX, y+bottomPent[i+1].y + shiftY, z+bottomPent[i+1].z + shiftZ);
        ico.vertex(x+bottomPent[0].x + shiftX, y+bottomPent[0].y + shiftY, z+bottomPent[0].z + shiftZ);
        ico.endShape(CLOSE);

        ico.beginShape();
        if (texture) {
          ico.texture(p);
        } 
        if (texture2) {
          ico.texture(p2);
        }
        ico.vertex(x+bottomPent[0].x + shiftX, y+bottomPent[0].y + shiftY, z+bottomPent[0].z + shiftZ);
        ico.vertex(x+topPent[i].x + shiftX, y+topPent[i].y + shiftY, z+topPent[i].z + shiftZ);
        ico.vertex(x+topPent[i+1].x + shiftX, y+topPent[i+1].y + shiftY, z+topPent[i+1].z + shiftZ);
        ico.endShape(CLOSE);
      }
      else if (i==topPent.length-1){
        ico.beginShape();
        if (texture) {
          ico.texture(p);
        } 
        if (texture2) {
          ico.texture(p2);
        }
        ico.vertex(x+topPent[i].x + shiftX, y+topPent[i].y + shiftY, z+topPent[i].z + shiftZ);
        ico.vertex(x+bottomPent[0].x + shiftX, y+bottomPent[0].y + shiftY, z+bottomPent[0].z + shiftZ);
        ico.vertex(x+bottomPent[1].x + shiftX, y+bottomPent[1].y + shiftY, z+bottomPent[1].z + shiftZ);
        ico.endShape(CLOSE);

        ico.beginShape();
        if (texture) {
          ico.texture(p);
        } 
        if (texture2) {
          ico.texture(p2);
        }
        ico.vertex(x+bottomPent[1].x + shiftX, y+bottomPent[1].y + shiftY, z+bottomPent[1].z + shiftZ);
        ico.vertex(x+topPent[i].x + shiftX, y+topPent[i].y + shiftY, z+topPent[i].z + shiftZ);
        ico.vertex(x+topPent[0].x + shiftX, y+topPent[0].y + shiftY, z+topPent[0].z + shiftZ);
        ico.endShape(CLOSE);
      }
      fill(255);
      shape(ico);
    }
  }

  // overrided methods fom Shape3D
  void rotZ(float theta){
    float tx=0, ty=0, tz=0;
    // top point
    tx = cos(theta)*topPoint.x+sin(theta)*topPoint.y;
    ty = sin(theta)*topPoint.x-cos(theta)*topPoint.y;
    topPoint.x = tx;
    topPoint.y = ty;

    // bottom point
    tx = cos(theta)*bottomPoint.x+sin(theta)*bottomPoint.y;
    ty = sin(theta)*bottomPoint.x-cos(theta)*bottomPoint.y;
    bottomPoint.x = tx;
    bottomPoint.y = ty;

    // top and bottom pentagons
    for (int i=0; i<topPent.length; i++){
      tx = cos(theta)*topPent[i].x+sin(theta)*topPent[i].y;
      ty = sin(theta)*topPent[i].x-cos(theta)*topPent[i].y;
      topPent[i].x = tx;
      topPent[i].y = ty;

      tx = cos(theta)*bottomPent[i].x+sin(theta)*bottomPent[i].y;
      ty = sin(theta)*bottomPent[i].x-cos(theta)*bottomPent[i].y;
      bottomPent[i].x = tx;
      bottomPent[i].y = ty;
    }
  }

  void rotX(float theta){
  }

  void rotY(float theta){
  }


}
