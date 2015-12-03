class WindowManager
{  
  JsonReader jr;
  PixelPusherManager pp; 
  SyphonManager sy;
  ButtonManager bt;
  
  ButtonArea btA;
  ImagesArea igA;
 
  
  public WindowManager(JsonReader jr, PixelPusherManager pp, 
                       SyphonManager sy, ButtonManager bt, DisplayImageManager di) {
    surface.setResizable(true);
    this.jr = jr;
    this.pp = pp;
    this.sy = sy;
    this.bt = bt;
    btA = new ButtonArea(bt);
    //igA = new ImagesArea(jr, pp, sy);
    igA = new ImagesArea(jr, pp, sy, di);
    
    btA.setBackgroundColor(color(200,200,200));
    //igA.setArea(0,0,240,155);
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
  private float posX, posY;
  private float sizeW, sizeH;
  private color backgroundColor;
  
  private JsonReader jr;
  private PixelPusherManager pp; 
  private SyphonManager sy;
  private DisplayImageManager di;
  
  
  public ImagesArea(JsonReader jr, PixelPusherManager pp, 
                    SyphonManager sy, DisplayImageManager di) {
    this.jr = jr;
    this.pp = pp;
    this.sy = sy;
    this.di = di;
    //this.textSize = 10;
    //this.stNumSize = 8;
    //this.hLength = (2*this.textSize)+(this.textSize/2)+this.stNumSize;
    this.backgroundColor = color(200,200,200);
    di.arrengePos(0,0,240,150);
    di.setSize(0, 240, 8);
    di.setSize(1, 240, 8);
    di.setSize(2, 240, 8);
    this.sizeUpdateFlag = false;
  }
  
  
  public void update(int status) {
    di.update();
    if(sizeUpdateFlag){
      noStroke();
      fill(this.backgroundColor);
      rect(this.posX, this.posY, this.sizeW, this.sizeH);
      
      di.arrengePos(0,0,240,150);
      sizeUpdateFlag = false;
    }
    this.playImages(status);
  }
  
  
  public void playImages(int status) {
    if(status!=0){
      color c;
      if(status == 1) c = color(255,255,255);
      else c = color(0,0,0);
      for(int i=0; i<this.jr.getGroupID().length; i++){
        this.di.setColor(i,c);
      }
    }
    /*
    for(int i=0; i<this.jr.getGroupID().length; i++){
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
    */
    if(status==0){
      for(int i=0; i<this.jr.getGroupID().length; i++) {
        this.sy.setArea(i, this.di.getPosX(i), this.di.getPosY(i), this.di.getSizeW(i), this.di.getSizeH(i)); 
      }
      this.sy.update();
    }
    for(int i=0; i<this.jr.getGroupID().length; i++) {
      this.pp.setArea(i, this.di.getPosX(i), this.di.getPosY(i), this.di.getSizeW(i), this.di.getSizeH(i));
    }
    this.pp.update();
  }
};


/*
class ImagesArea
{
  private boolean sizeUpdateFlag;
  private float posX, posY;
  private float sizeW, sizeH;
  private float oldPosX, oldPosY;
  private float oldSizeW, oldSizeH;
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
  
  
  public void setArea(float x, float y, float w, float h) {
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
  
  
  
  public float getSizeW() {
    return this.sizeW;
  }
  
  
  public float getSizeH() {
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
    float xs[] = new float[this.jr.getGroupID().length];
    float ys[] = new float[this.jr.getGroupID().length];
    float ws[] = new float[this.jr.getGroupID().length];
    float hs[] = new float[this.jr.getGroupID().length];
    
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
      for(int i=0; i<this.jr.getGroupID().length; i++) {
        this.sy.setArea(i, xs[i], ys[i], ws[i], hs[i]); 
      }
      this.sy.update();
      //this.sy.update(xs, ys, ws, hs);
    }
    //this.pp.update(xs, ys, ws, hs);
    for(int i=0; i<this.jr.getGroupID().length; i++) {
      this.pp.setArea(i, xs[i], ys[i], ws[i], hs[i]);
    }
    this.pp.update();
  }
  
};
*/


class ButtonArea
{
  private ButtonManager bt;
  private boolean sizeUpdateFlag;
  private int posX, posY;
  private int sizeW, sizeH;
  private int newPosX, newPosY;
  private int newSizeW, newSizeH;
  private color backgroundColor;
  private boolean colorUpdateFlag;
  private color newBackgroundColor;
  
  
  public ButtonArea(ButtonManager bt) {
    this.bt = bt;
    this.backgroundColor = color(200,200,200);
    this.sizeUpdateFlag = false;
    this.colorUpdateFlag = false;
  }
  
  
  public void setArea(int x, int y, int w, int h) {
    this.newPosX = x;
    this.newPosY = y;
    this.newSizeW = w;
    this.newSizeH = h;
    this.sizeUpdateFlag = true;
  }
  
  
  public void setBackgroundColor(color c) {
    this.newBackgroundColor = c;
    this.colorUpdateFlag = true;
  }
  
  
  public void update() {
    if(this.sizeUpdateFlag){
      noStroke();
      fill(this.backgroundColor);
      rect(this.posX, this.posY, this.sizeW, this.sizeH);
      this.bt.arrengeButtonsPos(this.newPosX, this.newPosY, this.newSizeW, this.newSizeH);
      this.posX = this.newPosX;
      this.posY = this.newPosY;
      this.sizeW = this.newSizeW;
      this.sizeH = this.newSizeH;
    }
    if(this.colorUpdateFlag){
      noStroke();
      fill(this.newBackgroundColor);
      rect(this.posX, this.posY, this.sizeW, this.sizeH);
      this.backgroundColor = this.newBackgroundColor;
    }
    
    this.bt.update();
    this.sizeUpdateFlag = false;
    this.colorUpdateFlag = false;
  }
  
};