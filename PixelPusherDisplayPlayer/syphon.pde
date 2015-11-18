import codeanticode.syphon.*;



class Syphon {
  public SyphonClient client;
  //public PGraphics canvas;
  
  
  void setting(PApplet parent, String appName, String serverName){
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
