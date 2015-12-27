import com.heroicrobot.dropbit.registry.*;
import com.heroicrobot.dropbit.devices.pixelpusher.Pixel;
import com.heroicrobot.dropbit.devices.pixelpusher.Strip;
import java.util.*;



class PixelPusherManager
{
  private DeviceRegistry registry;
  private PixelPusherObserver observer;
  private PixelPusher pp[];
  private int stripsNum[];
  private int stripLength[];
  private float x[], y[], w[], h[];
  
  
  public PixelPusherManager(int groupIDs[], float noiseR, float noiseG, float noiseB) {
    this.registry = new DeviceRegistry();
    this.observer = new PixelPusherObserver();
    this.registry.addObserver(this.observer);
    
    this.pp = new PixelPusher[groupIDs.length];
    for(int i=0; i<groupIDs.length; i++){
      this.pp[i] = new PixelPusher(groupIDs[i]);
      this.pp[i].setNoiseRGB(noiseR, noiseG, noiseB);
    }
    
    this.x = new float[groupIDs.length];
    this.y = new float[groupIDs.length];
    this.w = new float[groupIDs.length];
    this.h = new float[groupIDs.length];
    this.stripsNum = new int[groupIDs.length];
    this.stripLength = new int[groupIDs.length];
  }
  
  
  public void update() {
    loadPixels();
    if(this.observer.hasStrips) {
      this.registry.startPushing();
      for(int i=0; i<pp.length; i++){
        this.pp[i].scrape(this.registry, this.x[i], this.y[i], this.w[i], this.h[i]);
        this.stripsNum[i] = this.pp[i].getStripsNum();
        this.stripLength[i] = this.pp[i].getStripsLength();
      }
    }
  }
  
  
  public void setArea(int dispNum, float x, float y, float w, float h) {
    this.x[dispNum] = x;
    this.y[dispNum] = y;
    this.w[dispNum] = w;
    this.h[dispNum] = h;
  }
  
  
  public int getStripsNum(int dispNum) {
    return this.stripsNum[dispNum];
  }
  
  
  public int getStripLength(int dispNum) {
    return this.stripLength[dispNum];
  }
  
};



class PixelPusher
{
  private int groupID;
  private int stripsNum;
  private int stripLength;
  private float noiseR, noiseG, noiseB;
  
  
  public PixelPusher(int id) {
    this.groupID = id;
    this.stripsNum = 0;
    this.stripLength = 0;
  }
  
  
  public void scrape(DeviceRegistry registry, float x, float y, float w, float h) {
    List<Strip> strips = registry.getStrips(this.groupID);
    if (strips.size() > 0) {
      // scale calc
      float xscale = w / float(strips.get(0).getLength());
      float yscale = h / float(strips.size());
      
      // get strips infomation
      this.stripsNum = strips.size();
      this.stripLength = strips.get(0).getLength();

      // for each strip (y-direction)
      int stripy = 0;
      for (Strip strip : strips) {
        for (int stripx = 0; stripx < strip.getLength(); stripx++) {
          color c = get(int(x + float(stripx)*xscale), int(y +float(stripy)*yscale));
          c = this.removeNoise(c);
          strip.setPixel(c, stripx);
        }
        stripy++;
      }
    }
  }
  
  
  public int getStripsNum() {
    return this.stripsNum;
  }
  
  
  public int getStripsLength() {
    return this.stripLength;
  }
  
  
  public void setNoiseRGB(float r, float g, float b) {
    this.noiseR = r;
    this.noiseG = g;
    this.noiseB = b;
  }
  
  
  private color removeNoise(color c) {
     //if(red(c) + green(c) + blue(c) < 20.0) {
     //  return 0;
     //}
     if(red(c) < this.noiseR && green(c) < this.noiseG && blue(c) < this.noiseB){
       return 0;
     }
     return c;
  }
  
};



class PixelPusherObserver implements Observer
{
  public boolean hasStrips = false;
  
  
  public void update(Observable registry, Object updatedDevice) {
    println("PixelPusher's Registry changed!");
    if (updatedDevice != null) {
      println("PixelPusher's Device change: " + updatedDevice);
    }
    this.hasStrips = true;
  }

};