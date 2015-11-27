import codeanticode.syphon.*;



class SyphonManager
{
  private Syphon sy[];
  
  
  public SyphonManager(PApplet parent, String appNames[], String serverNames[]) {
    sy = new Syphon[appNames.length];
    for(int i=0; i<appNames.length; i++){
      sy[i] = new Syphon(parent, appNames[i], serverNames[i]);
    }
  }
  
  
  public void update(int x[], int y[], int w[], int h[]) {
    for(int i=0; i<sy.length; i++){
      if(sy[i].newFrame()) {
        image(sy[i].getGraphics(), x[i], y[i], w[i], h[i]);
      }
    }
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