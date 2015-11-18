Syphon sy;
PixelPusher pp;
ConfigReader cr;



public void setup() {
  
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



public void draw() {
  if(sy.available()) {
    image(sy.getGraphics(), 0, 0, width, height);
  }
  pp.scrape();
}



public void dispose() {
  println("PixelPusherDisplayPlayer exit.");
}
