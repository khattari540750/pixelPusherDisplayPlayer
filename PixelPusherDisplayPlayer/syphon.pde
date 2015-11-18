import codeanticode.syphon.*;



class Syphon {
  private SyphonClient client;
  
  
  public Syphon(PApplet parent) {
    println("Available Syphon servers:");
    println(SyphonClient.listServers());
    this.client = new SyphonClient(parent);
  }
  
  
  public Syphon(PApplet parent, String appName, String serverName) {
    println("Available Syphon servers:");
    println(SyphonClient.listServers());
    this.client = new SyphonClient(parent, appName, serverName);
  }
    
  
  boolean available(){
    return this.client.available();
  }
  
  
  PGraphics getGraphics(){
    PGraphics canvas;
    canvas = new PGraphics();
    canvas = this.client.getGraphics(canvas);
    return canvas;
  }
};
