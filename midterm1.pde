// Modified from Daniel Rozin's Artistic Edges Example for Pixel by Pixel

import processing.video.*;
Capture webCam;

void setup() {
  size(1280, 720);
  frameRate(60);
  webCam = new Capture(this, width, height);
  webCam.start();
  background(0);
}


void draw() {
  if (webCam.available()) webCam.read();
  webCam.loadPixels();
  int edgeAmount = 1;
  for (int x = edgeAmount; x < width-edgeAmount; x+=12) {
    for (int y = edgeAmount; y < height-edgeAmount; y+=4) {
      PxPGetPixel(x, y, webCam.pixels, width);
      //float gammaMaster = 2;
      //float newR = 255 * pow((R/255), gammaMaster);
      //float newG = 255 * pow((G/255), gammaMaster);
      //float newB = 255 * pow((B/255), gammaMaster);
      
      //float brightMaster = 24;
      //float newR = R + brightMaster*0.299; //percieved ratio of RGB levelled out for the human eye
      //float newG = G + brightMaster*0.587;
      //float newB = B + brightMaster*0.114;
      
      int newR = R;
      int newG = G;
      int newB = B;
      float colorDifference = 1; //higher number = more accurate
      for (int blurX = x - edgeAmount; blurX <= x + edgeAmount; blurX++) {
        for (int blurY = y - edgeAmount; blurY <=y + edgeAmount; blurY++) {
          PxPGetPixel(blurX, blurY, webCam.pixels, width);
          colorDifference+=dist(R, G, B, newR, newG, newB);
        }
      }
      int threshold = 180; //density of light pillars
      if (colorDifference > threshold) {
        stroke(newR, newG, newB);
        float randX = random(2, 22);
        line(x, y, x+randX, y + 720);
      }
    }
  }
  fill(0, 0, 0, 15);
  rect( 0, 0, width, height);
}

      
  