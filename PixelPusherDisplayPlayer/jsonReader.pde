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
  private int foot;
  private String head;
  

  public JsonReader(String name) {
    deviceDataNum = -1;
    this.setReadFile(name);
    this.readJsonFile();
  }


  public void setReadFile(String name) {
    this.fileName = name;
  }
  
  
  public int getFoot() {
    return this.foot;
  }
  
  
  public String getHead() {
    return this.head;
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
    this.foot = config.getInt("foot");
    this.head = config.getString("head");
    
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
    println( "foot=" + this.foot +", " + 
             "head=" + this.head);

    for (int i = 0; i < this.deviceDataNum; i++) {
      println( "groupID=" + this.groupID[i] +", " + 
               "destAppName=" + this.destAppName[i] + ", " + 
               "destSyphonName=" + this.destSyphonName[i]);
    }
  }
  
};