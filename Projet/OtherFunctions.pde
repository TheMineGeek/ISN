void saveUsername(String username) {
  PrintWriter output;

  output = createWriter("pseudo");
  output.println(username);
  output.flush();
  output.close();

  USERNAME = username;
}

boolean existingUsername() {
  if (fileExists(sketchPath("pseudo"))) {
    BufferedReader reader;
    String username;


    reader = createReader("pseudo");

    try {
      username = reader.readLine();
    } 
    catch (IOException e) {
      e.printStackTrace();
      username = null;
    }
    
    if(username == null) return false;
    
    USERNAME = username;
    return true;
  } else {
    return false;
  }
}

boolean fileExists(String path) {
  File file = new File(path);
  
  boolean exists = file.exists();
  if (exists) return true;
  else return false;
} 