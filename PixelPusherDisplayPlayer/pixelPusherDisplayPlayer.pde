Syphon sy;
PixelPusher pp;
ConfigReader cr;


void settings() {
  size(240, 16, P2D);
  PJOGL.profile = 1;
}


void setup() {
    
  // read configuration file
  cr = new ConfigReader("config.txt");
  
  // set pixel pusher
  pp = new PixelPusher();
  pp.setGroupID(cr.getGroupID());
  
  // set syphon client
  sy = new Syphon(this, cr.getDestAppName(), cr.getDestSyphonName());
  
  //canvas.beginDraw();
  //canvas.background(0);
  //canvas.endDraw();
  //image(canvas, 0, 0);
  
  // set window size
  surface.setResizable(true);
}


void draw() {
  //if(pp.isChangeStrips()){
  //  println(pp.getStripsNum());
  //}
  
  if(sy.newFrame()) {
    image(sy.getGraphics(), 0, 0, width, height);
  }
  pp.scrape();
  
  
}












/*
Syphon sy;
PixelPusher pp;
ConfigReader cr;


void setup() {
  
  // set window
  size(240, 16, P3D);
  background(0);
  
  // read configuration file
  cr = new ConfigReader("config.txt");
  
  // set pixel pusher
  pp = new PixelPusher();
  pp.setGroupID(cr.getGroupID());
  //pp.setGroupStripNum(16);
  
  // set syphon client
  sy = new Syphon(this, cr.getDestAppName(), cr.getDestSyphonName());
  //sy = new Syphon(this);
}


void draw() {
  if(sy.available()) {
    image(sy.getGraphics(), 0, 0, width, height);
  }
  pp.scrape();
}


void dispose() {
  println("PixelPusherDisplayPlayer exit.");
}
*/