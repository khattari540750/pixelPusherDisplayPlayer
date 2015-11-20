import codeanticode.syphon.*;



class Syphon {
  private SyphonClient client;
  private PGraphics canvas;
  
  
  public Syphon(PApplet parent, String appName, String serverName) {
    this.client = new SyphonClient(parent, appName, serverName);
    this.canvas = new PGraphics();
    //this.canvas = createGraphics(240, 160, P3D);
    //this.canvas = createGraphics(240, 160, P2D);
  }
  
  
  public boolean newFrame(){
    return this.client.newFrame();
  }
  
  
  public PGraphics getGraphics(){
    this.canvas = this.client.getGraphics(this.canvas);
    return this.canvas;
  }
};
















/*
import codeanticode.syphon.*;



class Syphon {
  private SyphonClient client;
  private PGraphics canvas;
  
  
  public Syphon(PApplet parent) {
    println("Available Syphon servers:");
    println(SyphonClient.listServers());
    this.client = new SyphonClient(parent);
    canvas = new PGraphics();
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
    canvas = this.client.getGraphics(canvas);
    return canvas;
  }
};
*/