class JsonReader
{
  // file
  private String fileName;
  private int deviceDataNum;
  
  // pixel pusher device setting
  private int groupID[];
  private String destAppName[];
  private String destSyphonName[];
  
  // configure setting
  private int defaultMode;
  private int defaultStatus;
  private float noiseR;
  private float noiseG;
  private float noiseB;
  
  

  public JsonReader(String name) {
    deviceDataNum = -1;
    this.setReadFile(name);
    this.readJsonFile();
  }


  public void setReadFile(String name) {
    this.fileName = name;
  }
  
  
  public int getDefaultMode() {
    return this.defaultMode;
  }
  
  
  public int getDefaultStatus() {
    return this.defaultStatus;
  }
  
  
  public float getNoiseR() {
    return this.noiseR;
  }
  
  
  public float getNoiseG() {
    return this.noiseG;
  }
  
  
  public float getNoiseB() {
    return this.noiseB;
  }
  
  
  public int getDeviceDataNum() {
    return this.deviceDataNum;
  }
  
  public int[] getGroupID() {
    return this.groupID;
  }
  
  
  public String[] getDestAppName() {
    return this.destAppName;
  }
  
  
  public String[] getDestSyphonName() {
    return this.destSyphonName;
  }
  

  public void readJsonFile() {
    JSONObject json = loadJSONObject(this.fileName);
    
    JSONObject config = json.getJSONObject("configureSettig");
    this.defaultMode = config.getInt("defaultMode");
    this.defaultStatus = config.getInt("defaultStatus");
    this.noiseR = config.getFloat("noiseR");
    this.noiseG = config.getFloat("noiseG");
    this.noiseB = config.getFloat("noiseB");
    //this.kaba = config.getString("head");
    
    JSONArray values = json.getJSONArray("pixelPusherDeviceSetting");
    this.deviceDataNum = values.size();
    this.groupID = new int[this.deviceDataNum];
    this.destAppName = new String[this.deviceDataNum];
    this.destSyphonName = new String[this.deviceDataNum];
    for (int i = 0; i < this.deviceDataNum; i++) {
      JSONObject deviceSet = values.getJSONObject(i);
      this.groupID[i] = deviceSet.getInt("groupID");
      this.destAppName[i] = deviceSet.getString("destAppName");
      this.destSyphonName[i] = deviceSet.getString("destSyphonName");
    }
  }
  
  
  public void printData() {
    println( "defaultMode=" + this.defaultMode +", " + 
             "defaultStatus" + this.defaultStatus);
    for (int i = 0; i < this.deviceDataNum; i++) {
      println( "groupID=" + this.groupID[i] +", " + 
               "destAppName=" + this.destAppName[i] + ", " + 
               "destSyphonName=" + this.destSyphonName[i]);
    }
  }
  
};