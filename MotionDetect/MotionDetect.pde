// ozgend: motion detect

import processing.video.*;
Capture video;
PImage prevFrame;

float threshold = 50;

void setup() {
  size(640,480);
  video = new Capture(this, width, height, 30);
  prevFrame = createImage(video.width,video.height,RGB);
  video.start();
}

void draw() {
  
  if (video.available()) {
    prevFrame.copy(video,0,0,video.width,video.height,0,0,video.width,video.height); 
    prevFrame.updatePixels();
    video.read();
  }
  
  loadPixels();
  video.loadPixels();
  prevFrame.loadPixels();
  
  for (int x = 0; x < video.width; x ++ ) {
    for (int y = 0; y < video.height; y ++ ) {
      
      int loc = x + y*video.width;            
      color current = video.pixels[loc];      
      color previous = prevFrame.pixels[loc]; 
      
      float r1 = red(current); 
      float g1 = green(current); 
      float b1 = blue(current);
      
      float r2 = red(previous); 
      float g2 = green(previous); 
      float b2 = blue(previous);
      
      float diff = dist(r1,g1,b1,r2,g2,b2);
      
      if (diff > threshold) { 
        pixels[loc] = color(0,170,0);
      } 
      else {
        //pixels[loc] = color(r1,g1,b1);
        pixels[loc] = color(0,0,0);
      }
      
    }
  }
  
  updatePixels();
}
