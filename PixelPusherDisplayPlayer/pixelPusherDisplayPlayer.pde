import processing.core.*;
import java.util.*;



Syphon sy;
PixelPusher pp;



public void setup() {
  // set window
  size(240, 16, P3D);
  background(0);
  
  // set pixel pusher
  pp = new PixelPusher();
  pp.setting();
  
  // set syphon client
  sy = new Syphon();
  sy.setting(this);
}



public void draw() {    
  if(sy.available()) {
    image(sy.getGraphics(), 0, 0, width, height);
  }
  pp.scrape();
}



public void dispose() {
  println("exit.");
}
