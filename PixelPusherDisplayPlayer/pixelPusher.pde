import com.heroicrobot.dropbit.registry.*;
import com.heroicrobot.dropbit.devices.pixelpusher.Pixel;
import com.heroicrobot.dropbit.devices.pixelpusher.Strip;
import java.util.*;



class PixelPusher {
  private DeviceRegistry registry;
  private PixelPusherObserver observer;
  private int groupID;
  private int stripsNum;
  private boolean stripsChangeFlag;
  
  
  public PixelPusher() {
    this.registry = new DeviceRegistry();
    this.observer = new PixelPusherObserver();
    this.registry.addObserver(this.observer);
    this.groupID = -1;
    this.stripsNum = 0;
    this.stripsChangeFlag = false;
  }
  
  
  public boolean isChangeStrips(){    
    if(this.stripsChangeFlag){
      println("aaaa");
      this.stripsChangeFlag = false;
      return true;
    }
    return false;
  }
  
  
  public int getStripsNum(){
    return this.stripsNum;
  }
  
  
  public void setGroupID(int id) {
    this.groupID = id;
  }
  
  
  public void scrape() {  
    loadPixels();
    if(this.observer.hasStrips) {
      this.registry.startPushing();
      List<Strip> strips;
      if(this.groupID < 0){
        strips = this.registry.getStrips();
      } else {
        strips = this.registry.getStrips(this.groupID);
      }

      int nowStripsNum = strips.size();
      if (nowStripsNum > 0) {
      //if (strips.size() > 0) {
        
        // scale calc
        float xscale = float(width) / float(strips.get(0).getLength());
        float yscale = float(height) / float(strips.size());

        // for each strip (y-direction)
        int stripy = 0;
        for (Strip strip : strips) {
          for (int stripx = 0; stripx < strip.getLength(); stripx++) {
            color c = get(int(float(stripx)*xscale), int(float(stripy)*yscale));
            strip.setPixel(c, stripx);
          }
          stripy++;
        }
        
        // change strips size
        if(stripsNum != nowStripsNum){
          stripsChangeFlag = true;
          stripsNum = nowStripsNum;
        }
        
      }
    }
  }
};



class PixelPusherObserver implements Observer {
  public boolean hasStrips = false;
  
  
  public void update(Observable registry, Object updatedDevice) {
    println("PixelPusher's Registry changed!");
    if (updatedDevice != null) {
      println("PixelPusher's Device change: " + updatedDevice);
    }
    this.hasStrips = true;
  }
};

















/*
import com.heroicrobot.dropbit.registry.*;
import com.heroicrobot.dropbit.devices.pixelpusher.Pixel;
import com.heroicrobot.dropbit.devices.pixelpusher.Strip;
import java.util.*;



class PixelPusher {
  private DeviceRegistry registry;
  private PixelPusherObserver observer;
  private int groupID;
  
  
  public PixelPusher() {
    this.registry = new DeviceRegistry();
    this.observer = new PixelPusherObserver();
    this.registry.addObserver(this.observer);
    this.groupID = -1;
  }
  
  
  public void setGroupID(int id) {
    this.groupID = id;
  }
  
  
  public void scrape() {  
    loadPixels();
    if(this.observer.hasStrips) {
      this.registry.startPushing();
      List<Strip> strips;
      if(this.groupID < 0){
        strips = this.registry.getStrips();
      } else {
        strips = this.registry.getStrips(this.groupID);
      }

      if (strips.size() > 0) {
        float xscale = float(width) / float(strips.get(0).getLength());
        float yscale = float(height) / float(strips.size());

        // for each strip (y-direction)
        int stripy = 0;
        for (Strip strip : strips) {
          for (int stripx = 0; stripx < strip.getLength(); stripx++) {
            color c = get(int(float(stripx)*xscale), int(float(stripy)*yscale));
            strip.setPixel(c, stripx);
          }
          stripy++;
        }
      }
    }
  }
};



class PixelPusherObserver implements Observer {
  public boolean hasStrips = false;
  
  
  public void update(Observable registry, Object updatedDevice) {
    println("PixelPusher's Registry changed!");
    if (updatedDevice != null) {
      println("PixelPusher's Device change: " + updatedDevice);
    }
    this.hasStrips = true;
  }
};
*/







/*
import com.heroicrobot.dropbit.registry.*;
import com.heroicrobot.dropbit.devices.pixelpusher.Pixel;
import com.heroicrobot.dropbit.devices.pixelpusher.Strip;
import java.util.*;



class PixelPusher {
  private DeviceRegistry registry;
  private PixelPusherObserver observer;
  private int groupID;
  private int groupStripNum;
  
  
  public PixelPusher() {
    this.registry = new DeviceRegistry();
    this.observer = new PixelPusherObserver();
    this.registry.addObserver(this.observer);
    this.groupID = -1;
  }
  
  
  public void setGroupID(int id) {
    this.groupID = id;
  }
  
  
  public void setGroupStripNum(int num) {
    this.groupStripNum = num;
  }
  
  
  public int getGroupStripNum() {
    int num = -1;
    while(num < 0){
      loadPixels();
      if(this.observer.hasStrips) {
        this.registry.startPushing();
        List<Strip> strips;
        if(this.groupID < 0){
          strips = this.registry.getStrips();
          num = strips.size();
        } else {
          strips = this.registry.getStrips(this.groupID);
          num = strips.size();
        }
      }
    }
    return num;
  }
 

  public void scrape() {  
    loadPixels();
    if(this.observer.hasStrips) {
      this.registry.startPushing();
      List<Strip> strips;
      if(this.groupID < 0){
        strips = this.registry.getStrips();
      } else {
        strips = this.registry.getStrips(this.groupID);
      }

      if (strips.size() > 0) {
        float xscale = float(width) / float(strips.get(0).getLength());
        float yscale = float(height) / float(strips.size());

        // for each strip (y-direction)
        int stripy = 0;
        for (Strip strip : strips) {
          for (int stripx = 0; stripx < strip.getLength(); stripx++) {
            color c = get(int(float(stripx)*xscale), int(float(stripy)*yscale));
            strip.setPixel(c, stripx);
          }
          stripy++;
        }
      }
    }
  } 
};



class PixelPusherObserver implements Observer {
  public boolean hasStrips = false;
  
  public void update(Observable registry, Object updatedDevice) {
    println("PixelPusher's Registry changed!");
    if (updatedDevice != null) {
      println("PixelPusher's Device change: " + updatedDevice);
    }
    this.hasStrips = true;
  }
};
*/