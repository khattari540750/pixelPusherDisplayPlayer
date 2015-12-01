class WindowManager
{  
  JsonReader jr;
  PixelPusherManager pp; 
  SyphonManager sy;
  ButtonManager bt;
  
  ButtonArea btA;
  ImagesArea igA;
 
  
  public WindowManager(JsonReader jr, PixelPusherManager pp, 
                       SyphonManager sy, ButtonManager bt) {
    surface.setResizable(true);
    this.jr = jr;
    this.pp = pp;
    this.sy = sy;
    this.bt = bt;
    btA = new ButtonArea(bt);
    igA = new ImagesArea(jr, pp, sy);
    
    igA.setArea(0,0,240,155);
    btA.setArea(0,155,240,45);
  }
  
  
  public void update() {
    //igA.setArea(0,0,240,155);
    igA.update(this.bt.getStatus());
    //btA.setArea(0,155,240,45);
    btA.update();
    surface.setSize(240, 200);
  }
  
};



class ImagesArea
{
  private boolean sizeUpdateFlag;
  private int posX, posY;
  private int sizeW, sizeH;
  private int oldPosX, oldPosY;
  private int oldSizeW, oldSizeH;
  private color backgroundColor;
  
  int textSize;
  int stNumSize;
  int hLength;
  
  private JsonReader jr;
  private PixelPusherManager pp; 
  private SyphonManager sy;
  
  
  public ImagesArea(JsonReader jr, PixelPusherManager pp, 
                    SyphonManager sy) {
    this.jr = jr;
    this.pp = pp;
    this.sy = sy;
    this.textSize = 10;
    this.stNumSize = 8;
    this.hLength = (2*this.textSize)+(this.textSize/2)+this.stNumSize;
    this.backgroundColor = color(200,200,200);
    this.sizeUpdateFlag = false;
  }
  
  
  public void setArea(int x, int y, int w, int h) {
    this.oldPosX = this.posX;
    this.oldPosY = this.posY;
    this.oldSizeW = this.sizeW;
    this.oldSizeH = this.sizeH;
    this.posX = x;
    this.posY = y;
    this.sizeW = w;
    this.sizeH = h;
    this.sizeUpdateFlag = true;
  }
  
  
  
  public int getSizeW() {
    return this.sizeW;
  }
  
  
  public int getSizeH() {
    return this.sizeH;
  }
  
  
  public void setBackgroundColor(color c) {
    this.backgroundColor = c;
    this.sizeUpdateFlag = true;
  }
  
  
  public void update(int status) {
    if(this.sizeUpdateFlag){
      noStroke();
      fill(this.backgroundColor);
      rect(this.oldPosX, this.oldPosY, this.oldSizeW, this.oldSizeH);
      this.sizeUpdateFlag = false;
      println("ok");
    }
    this.playImages(status);
  }
  
  
  public void playImages(int status) {
    int xs[] = new int[this.jr.getGroupID().length];
    int ys[] = new int[this.jr.getGroupID().length];
    int ws[] = new int[this.jr.getGroupID().length];
    int hs[] = new int[this.jr.getGroupID().length];
    
    for(int i=0; i<this.jr.getGroupID().length; i++){
      xs[i] = this.posX;
      ys[i] = this.posY + i*this.hLength+this.textSize+(this.textSize/2); 
      ws[i] = 240;
      hs[i] = this.stNumSize;
      
      if(status!=0){
        noStroke();
        if(status == 1){
          fill(255,255,255);
        } else {
          fill(0,0,0);
        }
        rect(xs[i], ys[i], ws[i], hs[i]);
      } 
    }
    if(status==0){
      this.sy.update(xs, ys, ws, hs);
    }
    this.pp.update(xs, ys, ws, hs);
  }
  
};



class ButtonArea
{
  private ButtonManager bt;
  private boolean sizeUpdateFlag;
  private int posX, posY;
  private int sizeW, sizeH;
  private int oldPosX, oldPosY;
  private int oldSizeW, oldSizeH;
  private color backgroundColor;
  
  
  public ButtonArea(ButtonManager bt) {
    this.bt = bt;
    this.backgroundColor = color(200,200,200);
    this.sizeUpdateFlag = false;
  }
  
  
  public void setArea(int x, int y, int w, int h) {
    this.oldPosX = this.posX;
    this.oldPosY = this.posY;
    this.oldSizeW = this.sizeW;
    this.oldSizeH = this.sizeH;
    this.posX = x;
    this.posY = y;
    this.sizeW = w;
    this.sizeH = h;
    this.sizeUpdateFlag = true;
  }
  
  
  public void setBackgroundColor(color c) {
    this.backgroundColor = c;
    this.sizeUpdateFlag = true;
  }
  
  
  public void update() {
    if(this.sizeUpdateFlag){
      noStroke();
      fill(this.backgroundColor);
      rect(this.oldPosX, this.oldPosY, this.oldSizeW, this.oldSizeH);
      this.bt.arrengeButtonsPos(this.posX, this.posY, this.sizeW, this.sizeH);
      this.sizeUpdateFlag = false;
    }
    this.bt.update();
  }
  
};


















/*
class WindowManager
{
  int textSize;
  int stNumSize;
  int hLength;
  
  JsonReader jr;
  PixelPusherManager pp; 
  SyphonManager sy;
  ButtonManager bt;
 
  boolean stringFlag;
  int winh;
  
  public WindowManager(JsonReader jr, PixelPusherManager pp, 
                       SyphonManager sy, ButtonManager bt) {
    surface.setResizable(true);
    textSize = 10;
    stNumSize = 8;
    hLength = (2*textSize)+(textSize/2)+stNumSize;
    this.jr = jr;
    this.pp = pp;
    this.sy = sy;
    this.bt = bt;
    
    this.stringFlag = true;
  }
  
  
  public void update() {
    this.bt.arrengeButtonsPos(0,this.winh,240,45);
    this.bt.update();
    this.playImages(this.bt.getStatus());
    surface.setSize(240,this.winh + 45);
  }
  
  
  public void playImages(int status) {
    int xs[] = new int[this.jr.getGroupID().length];
    int ys[] = new int[this.jr.getGroupID().length];
    int ws[] = new int[this.jr.getGroupID().length];
    int hs[] = new int[this.jr.getGroupID().length];
    
    for(int i=0; i<this.jr.getGroupID().length; i++){
      
      if(stringFlag){
        fill(0);
        textSize(this.textSize);
        text("group:" + jr.getGroupID()[i] + "  name:" + this.jr.getDestSyphonName()[i],
             0, i*this.hLength+this.textSize);
      }
      xs[i] = 0;
      ys[i] = i*this.hLength+this.textSize+(this.textSize/2); 
      ws[i] = 240;
      hs[i] = this.stNumSize;
      
      
      if(status!=0){
        noStroke();
        if(status == 1){
          fill(255,255,255);
        } else {
          fill(0,0,0);
        }
        rect(xs[i], ys[i], ws[i], hs[i]);
      } 
    }
    if(status==0){
      this.sy.update(xs, ys, ws, hs);
    }
    this.pp.update(xs, ys, ws, hs);
    
    stringFlag = false;
    this.winh = ys[this.jr.getGroupID().length-1]+hs[this.jr.getGroupID().length-1];
  }
  
};
*/