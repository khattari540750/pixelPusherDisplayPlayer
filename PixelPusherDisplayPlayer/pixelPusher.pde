import com.heroicrobot.dropbit.registry.*;
import com.heroicrobot.dropbit.devices.pixelpusher.Pixel;
import com.heroicrobot.dropbit.devices.pixelpusher.Strip;



class PixelPusher {
  private DeviceRegistry registry;
  private PixelPusherObserver observer;
  private int groupNumber;
  
  
  public PixelPusher() {
    this.registry = new DeviceRegistry();
    this.observer = new PixelPusherObserver();
    this.registry.addObserver(this.observer);
    this.groupNumber = -1;
  }
  
  
  public void setGroupNum(int num) {
    this.groupNumber = num;
  }
 
 
  public void scrape() {  
    loadPixels();
    if(this.observer.hasStrips) {
      this.registry.startPushing();
      List<Strip> strips;
      if(this.groupNumber < 0){
        strips = this.registry.getStrips();
      } else {
        strips = this.registry.getStrips(this.groupNumber);
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
