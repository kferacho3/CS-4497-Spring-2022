//simple Cube class, based on Quads
class Cube {
  //properties
  float w, h, d;
  float shiftX, shiftY, shiftZ;
  PImage p, p2;
  //constructor
  Cube(float w, float h, float d, float shiftX, float shiftY, float shiftZ, PImage p, PImage p2){

    this.w = w; 
    this.h = h;
    this.d = d; 
    this.shiftX = shiftX;
    this.shiftY = shiftY;
    this.shiftZ = shiftZ;
    this.p = p;
    this.p2 = p2;

}

/*main cube drawing method: It's just a bunch of rectangles drawn for each cube face using an equation */
void drawCube(float t){
 
 fill(255);
  PShape cube = createShape();
  if (texture) {
          cube.setTexture(p);
        } 
        if (texture2) {
          cube.setTexture(p2);
        }
  cube.beginShape(QUADS);
//front face
if (texture) {
          cube.texture(p);
        } 
        if (texture2) {
          cube.texture(p2);
        }
  cube.vertex(-w/2 + shiftX, -h/2 + shiftY, -d/2 + shiftZ); 
  cube.vertex(w + shiftX, -h/2 + shiftY, -d/2 + shiftZ); 
  cube.vertex(w + shiftX, h + shiftY, -d/2 + shiftZ); 
  cube.vertex(-w/2 + shiftX, h + shiftY, -d/2 + shiftZ);

//back face
if (texture) {
          cube.texture(p);
        } 
        if (texture2) {
          cube.texture(p2);
        }
  cube.vertex(-w/2 + shiftX, -h/2 + shiftY, d + shiftZ); 
  cube.vertex(w + shiftX, -h/2 + shiftY, d + shiftZ);
  cube.vertex(w + shiftX, h + shiftY, d + shiftZ);
  cube.vertex(-w/2 + shiftX, h + shiftY, d + shiftZ);

//left face 
if (texture) {
          cube.texture(p);
        } 
        if (texture2) {
          cube.texture(p2);
        }
  cube.vertex(-w/2 + shiftX, -h/2 + shiftY, -d/2 + shiftZ);
  cube.vertex(-w/2 + shiftX, -h/2 + shiftY, d + shiftZ);
  cube.vertex(-w/2 + shiftX, h + shiftY, d + shiftZ);
  cube.vertex(-w/2 + shiftX, h + shiftY, -d/2 + shiftZ);

 
//right face
if (texture) {
          cube.texture(p);
        } 
        if (texture2) {
          cube.texture(p2);
        }
  cube.vertex(w + shiftX, -h/2 + shiftY, -d/2 + shiftZ); 
  cube.vertex(w + shiftX, -h/2 + shiftY, d + shiftZ); 
  cube.vertex(w + shiftX, h + shiftY, d + shiftZ); 
  cube.vertex(w + shiftX, h + shiftY, -d/2 + shiftZ);

//top face
if (texture) {
          cube.texture(p);
        } 
        if (texture2) {
          cube.texture(p2);
        }
  cube.vertex(-w/2 *t+ shiftX, -h/2*t + shiftY, -d/2*t + shiftZ); 
  cube.vertex(w *t+ shiftX, -h/2*t + shiftY, -d/2*t + shiftZ); 
  cube.vertex(w *t+ shiftX, -h/2*t + shiftY, d *t+ shiftZ); 
  cube.vertex(-w/2 *t+ shiftX, -h/2*t + shiftY, d*t + shiftZ);


//bottom face
if (texture) {
          cube.texture(p);
        } 
        if (texture2) {
          cube.texture(p2);
        }

  cube.vertex(-w/2*t + shiftX, h*t + shiftY, -d/2 *t+ shiftZ); 
  cube.vertex(w*t + shiftX, h*t + shiftY, -d/2*t + shiftZ); 
  cube.vertex(w *t+ shiftX, h *t+ shiftY, d *t+ shiftZ); 
  cube.vertex(-w/2 *t+ shiftX, h*t + shiftY, d *t+ shiftZ);
cube.endShape();
fill(255);
shape(cube);
//add some rotation to each box for pizazz. 
//rotateY(radians(1));
//rotateX(radians(1));
//rotateZ(radians(1));
}
}
