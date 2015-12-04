import codeanticode.syphon.*;



class SyphonManager
{
  private Syphon sy[];
  private float x[];
  private float y[];
  private float w[];
  private float h[];
  
  
  public SyphonManager(PApplet parent, String appNames[], String serverNames[]) {
    sy = new Syphon[appNames.length];
    for(int i=0; i<appNames.length; i++){
      sy[i] = new Syphon(parent, appNames[i], serverNames[i]);
    }
    x = new float[appNames.length];
    y = new float[appNames.length];
    w = new float[appNames.length];
    h = new float[appNames.length];
  }
  
  
  public void update() {
    for(int i=0; i<sy.length; i++){
      if(sy[i].newFrame()) {
        image(sy[i].getGraphics(), x[i], y[i], w[i], h[i]);
      }
    }
  }
  
  
  public void setArea(int dispNum, float x, float y, float w, float h) {
    this.x[dispNum] = x;
    this.y[dispNum] = y;
    this.w[dispNum] = w;
    this.h[dispNum] = h;
  }

};



class Syphon
{
  private SyphonClient client;
  private PGraphics canvas;
  
  
  public Syphon(PApplet parent, String appName, String serverName) {
    this.client = new SyphonClient(parent, appName, serverName);
    this.canvas = new PGraphics();
  }
  
  
  public boolean newFrame() {
    return this.client.newFrame();
  }
  
  
  public PGraphics getGraphics() {
    this.canvas = this.client.getGraphics(this.canvas);
    return this.canvas;
  }
  
};