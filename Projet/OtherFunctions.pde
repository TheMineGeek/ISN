import java.util.*;

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

    if (username == null) return false;

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

String patternsToJson() {
  String _patterns = "";

  _patterns += "[";
  for (int i = 0; i < patterns.length; i++) {    
    _patterns += patterns[i].toJson();
    if (i != patterns.length - 1) _patterns += ",\n";
  }
  _patterns += "]";

  return _patterns;
}

String encrypt(String data) {
   Base64.Encoder encoder = Base64.getEncoder();
   byte[] base64str = encoder.encode(data.getBytes());
   
   String string = new String(base64str);
   
   return string;
}

String decrypt(String data) {
   Base64.Decoder decoder = Base64.getDecoder();
   byte[] base64str = decoder.decode(data.getBytes());
   
   String string = new String(base64str);
   
   return string;
}

void saveEscapologie() {
  
}

void loadEscapologie() {
  
}