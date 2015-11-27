WindowManager wd;
JsonReader jr;
SyphonManager sy;
PixelPusherManager pp;


void settings() {
  size(240,200, P2D);
  PJOGL.profile = 1;
}


void setup() {
  
  // read configration file
  jr = new JsonReader("data/config.json");
  
  // pixel pusher manager initialization
  pp = new PixelPusherManager(jr.getGroupID());
  
  // syphon client manager initialization
  sy = new SyphonManager(this, jr.getDestAppName(), jr.getDestSyphonName());
  
  // window manager initialization
  wd = new WindowManager(jr, pp, sy);
  
}


void draw() {
  wd.update();
}