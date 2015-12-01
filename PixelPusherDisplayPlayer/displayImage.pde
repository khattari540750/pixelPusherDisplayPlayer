class displayImage
{
};


class displayImageName
{
  private int posX, posY;
  private int sizeW, sizeH;
  private String name;
  private color textColor;
  private color backgroundColor;
  private int textSize;
  private boolean textUpdateFlag;
  
  
  public displayImageName(String n, int x, int y) {
    this.name = n;
    this.posX = x;
    this.posY = y;
    this.textUpdateFlag = true;
    this.textSize = 10;
    textSize(this.textSize);
    this.textColor = color(0, 0, 0);
    this.backgroundColor = color(50, 50, 50);
  }
  
  
  public void update() {
    if(this.textUpdateFlag){
      noStroke();
      fill(this.backgroundColor);
      rect(this.posX, this.posY, this.sizeW, this.sizeH);
      
      fill(this.textColor);
      text(this.name, this.posX, this.posY);
      this.textUpdateFlag = false;
    }
  }
  
  
};





/*
class imageDisplayManager
{
  
  
  
  
  public update() {
  
  }
  
};



class ImageDisplay
{
  private int posX, posY;
  private int sizeW, sizeH;
  private String name;
  private color textColor;
  private int textSize;
  private boolean textUpdateFlag;
  
  
  public ImageDisplay(String n, int x, int y, int w, int h) {
    this.name = n;
    this.posX = x;
    this.posY = y;
    this.sizeW = w;
    this.sizeH = h;
    this.textUpdateFlag = true;
    this.textSize = 10;
    textSize(this.textSize);
    this.textColor = color(0, 0, 0);
  }
  
  
  public void setName(String n) {
    this.name = n;
    this.textUpdateFlag = true;
  }
  
  
  public void setNameAndPos(String n, int x, int y, int w, int h) {
    
  }
  
  
  public void update(PImage img) {
     this.witeName();
     image(img, this.posX, this.posY, this.sizeW, this.sizeH);
  }
  
  
  public void update() {
    this.witeName();
  }
  
  
  public void update(color c) {
    this.witeName();
    noStroke();
    fill(c);
    rect(this.posX, this.posY, this.posW, this.posH);
  }
  
  
  private void witeName() {
    if(this.textUpdateFlag){
      fill(this.textColor);
      text(this.name, this.posX, this.posY);
      this.textUpdateFlag = false;
    }
  }
  
};
*/