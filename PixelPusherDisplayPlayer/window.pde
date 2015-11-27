int keyX = 1;



class WindowManager
{
  int textSize;
  int stNumSize;
  int hLength;
  
  JsonReader jr;
  PixelPusherManager pp; 
  SyphonManager sy;
 
  
  public WindowManager(JsonReader jr, PixelPusherManager pp, SyphonManager sy) {
    surface.setResizable(true);
    textSize = 10;
    stNumSize = 8;
    hLength = (2*textSize)+(textSize/2)+stNumSize;
    textSize(textSize);
    this.jr = jr;
    this.pp = pp;
    this.sy = sy;
  }
  
  public void update() {
    this.playImages(keyX);
  }
  
  
  public void playImages(int status) {
    int xs[] = new int[this.jr.getGroupID().length];
    int ys[] = new int[this.jr.getGroupID().length];
    int ws[] = new int[this.jr.getGroupID().length];
    int hs[] = new int[this.jr.getGroupID().length];
    
    for(int i=0; i<this.jr.getGroupID().length; i++){     
      fill(0);
      text("group:" + jr.getGroupID()[i] + "  name:" + this.jr.getDestSyphonName()[i], 0, i*this.hLength+this.textSize);
      xs[i] = 0;
      ys[i] = i*this.hLength+this.textSize+(this.textSize/2); 
      ws[i] = 240;
      hs[i] = this.stNumSize;
      
      if(status<0){
        noStroke();
        fill(0,0,0);
        rect(xs[i], ys[i], ws[i], hs[i]);
      } 
    }
    if(status>=0){
      this.sy.update(xs, ys, ws, hs);
    }
    this.pp.update(xs, ys, ws, hs);
  }
  
};


void keyPressed() {
  if (keyX == 1) {
    keyX = -1;
  } else {
    keyX = 1;
  }
}