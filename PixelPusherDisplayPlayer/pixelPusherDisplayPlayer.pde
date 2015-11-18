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
  pp.setGroupNum(-1);
  
  // set syphon client
  sy = new Syphon(this, "SendFrames" ,"Processing Syphon");
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



/*
public void keyPressed(){
  if(key == 'a'){
    pp.setGroupNum(2);
  }
  if(key == 'b'){
    pp.setGroupNum(-1);
  }
}
*/
