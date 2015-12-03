class DisplayImageManager
{
  private DisplayImageName din[];
  private DisplayImage di[];
  private int num;
  
  
  public DisplayImageManager(String imageNames[]) {
    this.num = imageNames.length;
    this.din = new DisplayImageName[this.num*2];
    this.di = new DisplayImage[this.num];
    for(int i=0; i<this.num; i++){
      this.din[i] = new DisplayImageName(imageNames[i]);
      this.din[i+this.num] = new DisplayImageName("in prefer... ");
      this.di[i] = new DisplayImage();
    }
  }
  
  
  public void update() {
    for(int i=0; i<this.num; i++){
      this.din[i].update();
      this.din[i+this.num].update();
      this.di[i].update();      
    }
  }
  
  
  public boolean arrengePos(int x, int y, int w, int h) {
    int xn = x; 
    int yn = y;
    int hn=0;
    for(int i=0; i<this.num; i++){
      this.din[i].setPos(xn, yn);
      this.din[i+this.num].setPos(xn+w-this.din[i+this.num].getSizeW(), yn);
      yn += this.din[i].getSizeH();
      this.di[i].setPos(xn, yn);
      yn += this.di[i].getSizeH();
      hn = yn;
      yn += 10;
    }
    if( h < hn ) return false;
    return true;
  }
  
  
  public void setColor(int dispNum, color c) {
    this.di[dispNum].setColor(c);
  }
  
  
  public void setStatus(int dispNum, String s) {
    this.din[dispNum+this.num].setName(s);
  }
  
  
  public void setSize(int dispNum, float w, float h) {
    this.di[dispNum].setSize(w, h);
  }
  
  
  public float getPosX(int dispNum) {
    return this.di[dispNum].getPosX();
  }
  
  
  public float getPosY(int dispNum) {
    return this.di[dispNum].getPosY();
  }
  
  
  public float getSizeW(int dispNum) {
    return this.di[dispNum].getSizeW();
  }
  
  
  public float getSizeH(int dispNum) {
    return this.di[dispNum].getSizeH();
  }
  
};



class DisplayImage
{
  private float posX, posY;
  private float sizeW, sizeH;
  private color nowColor;
  private boolean updateFlag;
  
  
  public void DisplayImage() {
    this.nowColor = color(0,0,0);
    this.updateFlag = false;
  }
  
  
  public void update() {
    if(this.updateFlag){
      noStroke();
      fill(this.nowColor);
      rect(this.posX, this.posY, this.sizeW, this.sizeH);
      this.updateFlag = false;
    }
  }
  
  
  public void setColor(color c) {
    this.nowColor = c;
    this.updateFlag = true;
  }
  
  
  public void setArea(float x, float y, float w, float h) {
    this.posX = x;
    this.posY = y;
    this.sizeW = w;
    this.sizeH = h;
    this.updateFlag = true;
  }
  
  
  public void setSize(float w, float h) {
    this.sizeW = w;
    this.sizeH = h;
    this.updateFlag = true;
  }
  
  
  public void setPos(float x, float y) {
    this.posX = x;
    this.posY = y;
    this.updateFlag = true;
  }
  
  
  public float getSizeH() {
    return this.sizeH;
  }
  
  
  public float getSizeW() {
    return this.sizeW;
  }
  
  public float getPosX() {
    return this.posX;
  }
  
  
  public float getPosY() {
    return this.posY;
  }
  
};



class DisplayImageName
{
  private float textSize;
  private color textColor;
  private color backgroundColor;
  private String name;
  private float posX, posY;
  private float sizeW, sizeH;
  private boolean updateFlag;
  
  
  public DisplayImageName(String n) {
    this.textSize = 10;
    textSize(this.textSize);
    this.textColor = color(0, 0, 0);
    this.name = n;
    this.sizeW = textWidth(this.name)+1;
    this.sizeH = 15;
    this.posX = 0;
    this.posY = 0;
    this.backgroundColor = color(200,200,200);
    this.updateFlag = false;
  }
  
  
  public void update() {
    if(this.updateFlag){
      noStroke();
      fill(this.backgroundColor);
      rect(this.posX, this.posY, this.sizeW, this.sizeH);
      fill(this.textColor);
      text(this.name, this.posX, this.posY, this.sizeW, this.sizeH);
      this.updateFlag = false;
    }
  }
  
  
  public void setPos(float x, float y) {
    noStroke();
    fill(this.backgroundColor);
    rect(this.posX, this.posY, this.sizeW, this.sizeH);
    this.posX = x;
    this.posY = y;
    this.updateFlag = true;
  }
  
  
  public void setName(String n) {
    noStroke();
    fill(this.backgroundColor);
    rect(this.posX, this.posY, this.sizeW, this.sizeH);
    this.name = n;
    this.sizeW = textWidth(this.name)+1;
    this.updateFlag = true;
  }
  
  
  public void setTextColor(color c) {
    noStroke();
    fill(this.backgroundColor);
    rect(this.posX, this.posY, this.sizeW, this.sizeH);
    this.textColor = c;
    this.updateFlag = true;
  }
  
  
  public void setBackgroundColor(color c) {
    this.backgroundColor = c;
    this.updateFlag = true;
  }
  
  
  public float getSizeH() {
    return this.sizeH;
  }
  
  
  public float getSizeW() {
    return this.sizeW;
  }
  
};