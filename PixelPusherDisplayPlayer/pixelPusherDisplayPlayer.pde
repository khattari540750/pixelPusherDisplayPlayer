JsonReader jr;
PixelPusherManager pp;
SyphonManager sy;
ButtonManager bt;
DisplayImageManager di;
WindowManager wd;


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
  
  // button manager initialization
  bt = new ButtonManager(jr.getDefaultStatus());
  
  // displayImage manager initialization
  di = new DisplayImageManager(jr.getDestSyphonName());
  
  // window manager initialization
  wd = new WindowManager(jr, pp, sy, bt, di);
  
}


void draw() {
  wd.update();
}


void mousePressed() {
  bt.setMousePressedIvents();
}