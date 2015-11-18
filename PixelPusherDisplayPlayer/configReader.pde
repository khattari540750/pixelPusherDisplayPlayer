class ConfigReader {
  private int groupID;
  private String destAppName;
  private String destSyphonName;
  private String fileName;
  
  
  public ConfigReader(String name) {
    setConfigFile(name);
    readConfigration();
  }
  
  
  public void setConfigFile(String name) {
    this.fileName = name;
  }
  
  
  public int getGroupID(){
    return this.groupID;
  }
  
  
  public String getDestAppName(){
    return this.destAppName;
  }
  
  
  public String getDestSyphonName(){
    return this.destSyphonName;
  }
  
  
  public void readConfigration(){
    BufferedReader reader;
    reader = createReader(this.fileName);
    String line;
    boolean z = true;
 
    while(z){
      try{
        line = reader.readLine();
      } catch (IOException e){
        line = null;
      }
      if (line == null){
        z = false;
      }else{
        String point[] = split( line,'=');
        if(point[0].equals("groupID") == true){
          groupID = int(point[1]);
        }else if(point[0].equals("destAppName") == true){
          destAppName = point[1];
        }else if(point[0].equals("destSyphonName") == true){
          destSyphonName = point[1];        
        }
      }   
    }
  }
};
