class WindowManager
{  
  JsonReader jr;
  PixelPusherManager pp; 
  SyphonManager sy;
  ButtonManager bt;
  
  ButtonArea btA;
  ImagesArea igA;
  
  float buttonSizeH;
 
  
  public WindowManager(JsonReader jr, PixelPusherManager pp, 
                       SyphonManager sy, ButtonManager bt, DisplayImageManager di) {
    surface.setResizable(true);
    this.jr = jr;
    this.pp = pp;
    this.sy = sy;
    this.bt = bt;
    this.btA = new ButtonArea(bt);
    this.igA = new ImagesArea(jr, pp, sy, di);
    
    this.btA.setBackgroundColor(color(200, 200, 200));
    this.igA.setBackgroundColor(color(200, 200, 200));
    
    this.buttonSizeH = 45;
    this.igA.setImageSize(0, 240, 8);
    this.igA.setImageSize(1, 240, 8);
    this.igA.setImageSize(2, 240, 8);
    this.igA.setImageSize(3, 240, 8);
    this.igA.setAreaSize(0, 0, 240, 200);
    
    this.btA.setArea(0,200-this.buttonSizeH,240,this.buttonSizeH);
    
  }
  
  
  public void update() {    
    btA.update();
    igA.update(this.bt.getStatus());
  }
};



class ImagesArea
{
  private boolean updateFlag;
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
    
    this.backgroundColor = color(200,200,200);
    this.di.arrengePos(this.posX, this.posY, this.sizeW, this.sizeH);
    this.updateFlag = false;
  }
  
  
  public void update(int status) {
    if(this.updateFlag){
      noStroke();
      fill(this.backgroundColor);
      rect(this.posX, this.posY, this.sizeW, this.sizeH);
      this.di.arrengePos(this.posX, this.posY, this.sizeW, this.sizeH);
      this.updateFlag = false;
    }
    this.di.update();
    this.playImages(status);
  }
  
  
  public void setBackgroundColor(color c) {
    this.backgroundColor = c;
    this.updateFlag = true;
  }
  
  
  public void setImageSize(int dispNum, float w, float h) {
    this.di.setSize(dispNum, w, h);
    this.updateFlag = true;
  }
  
  
  public void setAreaSize(float x, float y, float w, float h) {
    this.posX = x;
    this.posY = y;
    this.sizeW = w;
    this.sizeH = h;
  }
  
  
  private void playImages(int status) {
    if(status!=0){
      color c;
      if(status == 1) c = color(255,255,255);
      else c = color(0,0,0);
      for(int i=0; i<this.jr.getGroupID().length; i++){
        this.di.setColor(i,c);
      }
    } 
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



class ButtonArea
{
  private ButtonManager bt;
  private boolean updateFlag;
  private float posX, posY;
  private float sizeW, sizeH;
  private color backgroundColor;
  
  
  public ButtonArea(ButtonManager bt) {
    this.bt = bt;
    this.backgroundColor = color(200,200,200);
    this.updateFlag = false;
  }
  
  
  public void update() {
    if(this.updateFlag){
      noStroke();
      fill(this.backgroundColor);
      rect(this.posX, this.posY, this.sizeW, this.sizeH);
      this.bt.arrengeButtonsPos(this.posX, this.posY, this.sizeW, this.sizeH);
      this.updateFlag = false;
    }
    this.bt.update();
  }
  
  
  public void setArea(float x, float y, float w, float h) {
    noStroke();
    fill(this.backgroundColor);
    rect(this.posX, this.posY, this.sizeW, this.sizeH);
    this.posX = x;
    this.posY = y;
    this.sizeW = w;
    this.sizeH = h;
    this.updateFlag = true;
  }
  
  
  public void setBackgroundColor(color c) {
    this.backgroundColor = c;
    this.updateFlag = true;
  }
  
};