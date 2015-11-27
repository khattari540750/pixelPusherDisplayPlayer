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
  
  
  public PixelPusherManager(int groupIDs[]) {
    this.registry = new DeviceRegistry();
    this.observer = new PixelPusherObserver();
    this.registry.addObserver(this.observer);
    
    this.pp = new PixelPusher[groupIDs.length];
    for(int i=0; i<groupIDs.length; i++){
      this.pp[i] = new PixelPusher(groupIDs[i]);
    }
    
    this.stripsNum = new int[groupIDs.length];
    this.stripLength = new int[groupIDs.length];
  }
  
  
  public void update(int x[], int y[], int w[], int h[]) {
    loadPixels();
    if(this.observer.hasStrips) {
      this.registry.startPushing();
      for(int i=0; i<pp.length; i++){
        this.pp[i].scrape(this.registry, x[i], y[i], w[i], h[i]);
        this.stripsNum[i] = this.pp[i].getStripsNum();
        this.stripLength[i] = this.pp[i].getStripsLength();
      }
    }
  }
  
  
  public int[] getStripsNum() {
    return this.stripsNum;
  }
  
  
  public int[] getStripLength() {
    return this.stripLength;
  }
  
};



class PixelPusher
{
  private int groupID;
  private int stripsNum;
  private int stripLength;
  
  
  public PixelPusher(int id) {
    this.groupID = id;
    this.stripsNum = 0;
    this.stripLength = 0;
  }
  
  
  public void scrape(DeviceRegistry registry, int x, int y, int w, int h) {
    List<Strip> strips = registry.getStrips(this.groupID);
    if (strips.size() > 0) {
      // scale calc
      float xscale = float(w) / float(strips.get(0).getLength());
      float yscale = float(h) / float(strips.size());
      
      // get strips infomation
      this.stripsNum = strips.size();
      this.stripLength = strips.get(0).getLength();

      // for each strip (y-direction)
      int stripy = 0;
      for (Strip strip : strips) {
        for (int stripx = 0; stripx < strip.getLength(); stripx++) {
          color c = get(int(x + float(stripx)*xscale), y + int(float(stripy)*yscale));
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