class ButtonManager
{
  private Button play, turnOff, turnOn;
  private int status;
  
  
  public ButtonManager(int defaultStatus) {
    this.play = new Button("PLAY");
    this.turnOff = new Button("TURN OFF");
    this.turnOn = new Button("TURN ON");
    this.status = defaultStatus;
  }
  
  
  public void update() {
    switch(this.status){
      case -1:
        play.setSelected(false);
        turnOff.setSelected(true);
        turnOn.setSelected(false);
        break;
      case 0:
        play.setSelected(true);
        turnOff.setSelected(false);
        turnOn.setSelected(false);
        break;
      case 1:
        play.setSelected(false);
        turnOff.setSelected(false);
        turnOn.setSelected(true);
        break;
    }
    play.update();
    turnOff.update();
    turnOn.update();
  }
  
  
  public void arrengeButtonsPos(float x, float y, float w, float h) {
    play.setPos(x+w/16, y+h/6, w/4, h*2/3);
    turnOff.setPos(x+2*w/16+w/4, y+h/6, w/4, h*2/3);
    turnOn.setPos(x+3*w/16+2*w/4, y+h/6, w/4, h*2/3);
  }
  
  
  public int getStatus() {
    return this.status;
  }
  
  
  public void setMousePressedIvents() {
    play.setMousePressedIvent(new Play());
    turnOff.setMousePressedIvent(new Off());
    turnOn.setMousePressedIvent(new On());
  }
  
  
  public class Play implements ButtonIvent
  {
    @Override
    public void action() {
      status = 0;
      println("play:" + status);
    }
  };


  public class Off implements ButtonIvent
  {
    @Override
    public void action() {
      status = -1;
      println("turn off:" + status);
    }
  };


  public class On implements ButtonIvent
  {
    @Override
    public void action() {
      status = 1;
      println("turn on" + status);
    }
  };

};



class Button
{
  private float posX, posY;
  private float sizeW, sizeH;
  private String name;
  private color normalColor, selectedColor;
  private color borderColor, textColor;
  private boolean mouseOver;
  private float textSize;
  private boolean selected;
  
  
  public Button(String n) {
    this.name = n;
    this.mouseOver = false;
    this.selected = false;
    this.normalColor = color(0,0,80);
    this.selectedColor = color(150,0,0);
    this.borderColor = color(250, 250, 250);
    this.textColor = color(240, 240, 240);
    ellipseMode(CENTER);  
  }
  
  
  public Button(float x, float y, float w, float h, String n) {
    this.posX = x;
    this.posY = y;
    this.sizeW = w;
    this.sizeH = h;
    this.name = n;
    this.textSize = h/3;
    this.mouseOver = false;
    this.selected = false;
    this.normalColor = color(0,0,80);
    this.selectedColor = color(150,0,0);
    this.borderColor = color(250, 250, 250);
    this.textColor = color(240, 240, 240);
    ellipseMode(CENTER);  
  }
  
  
  public void setColor(color c) {
    this.normalColor = c;
  }
  
  
  public void setName(String n) {
    this.name = n;
  }
  
  public void setPos(float x, float y, float w, float h) {
    this.posX = x;
    this.posY = y;
    this.sizeW = w;
    this.sizeH = h;
    this.textSize = h/3;
  }
  
  
  public void setSelected(boolean set) {
    this.selected = set;
  }
  
  
  public boolean getSelected() {
    return this.selected;
  }
  
  
  public void update() {
    color nowColor = this.normalColor;
    if(selected) nowColor = this.selectedColor;
    
    if (this.mouseOver(this.posX, this.posY, this.sizeW, this.sizeH)) { 
      this.mouseOver = true;
    } else {
      this.mouseOver = false;
    }
    
    if (this.mouseOver) {
      fill(this.getHighlight(nowColor));
    } else {
      fill(nowColor);
    }
    
    stroke(this.borderColor);
    rect(this.posX, this.posY, this.sizeW, this.sizeH);
    
    fill(this.textColor);
    textAlign(CENTER, CENTER);
    textSize(this.textSize);
    text(name, this.posX, this.posY, this.sizeW, this.sizeH);
  }
  
  
  public void setMousePressedIvent(ButtonIvent buttonAction) {
    if (this.mouseOver) {
      this.selected = true;
      buttonAction.action();
    }
  }

  
  private boolean mouseOver(float x, float y, float width, float height) {
    if (mouseX >= x && mouseX <= x+width && 
        mouseY >= y && mouseY <= y+height) {
      return true;
    } else {
      return false;
    }
  }
  
  
  private color getHighlight(color c) {
    return(c+color(50));
  }
  
};



public interface ButtonIvent
{
  public void action();
};