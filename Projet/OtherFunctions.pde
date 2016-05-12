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
  for (int i = 0; i < escapologiePatterns.length; i++) {    
    _patterns += escapologiePatterns[i].toJson();
    if (i != escapologiePatterns.length - 1) _patterns += ",\n";
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

void saveEscapologie(String data) {
  PrintWriter output;

  output = createWriter("save");
  output.println(data);
  output.flush();
  output.close();
}

void loadEscapologie() {
  if (fileExists(sketchPath("save"))) {
    BufferedReader reader;
    String save;

    reader = createReader("save");

    try {
      save = reader.readLine();
    } 
    catch (IOException e) {
      e.printStackTrace();
      save = null;
    }
    
    if (save != null) {
      JSONArray values = JSONArray.parse(decrypt(save));
      println(values.size());
      escapologiePatterns = new Pattern[values.size()];

      for (int i = 0; i < values.size(); i++) {
        values.getJSONObject(i);
        JSONObject object = values.getJSONObject(i);
        int id = object.getInt("id");
        boolean done = object.getBoolean("done");
        LevelDifficulty levelDifficulty;

        switch(object.getString("levelDifficulty")) {
        case "EASY":
          levelDifficulty = LevelDifficulty.EASY;
          break;
        case "MEDIUM":
          levelDifficulty = LevelDifficulty.MEDIUM;
          break;
        case "HARD":
          levelDifficulty = LevelDifficulty.HARD;
          break;
        default: 
          levelDifficulty = LevelDifficulty.EASY;
          break;
        }

        int[][] pattern = new int[object.getJSONArray("pattern").size()][object.getJSONArray("pattern").getJSONArray(0).size()];
        
        if(i == 4) {
          println(object.getJSONArray("pattern").size(), object.getJSONArray("pattern").getJSONArray(0).size());
        }
        
        for (int j = 0; j < object.getJSONArray("pattern").size(); j++) {
          for (int k = 0; k <  object.getJSONArray("pattern").getJSONArray(0).size(); k++) {
            pattern[j][k] = object.getJSONArray("pattern").getJSONArray(j).getInt(k);
          }
        }

        escapologiePatterns[i] = new Pattern(pattern, id, levelDifficulty, "escapologie", done);
        escapologiePatterns[i].log();
        println();
      }
    }
  } else {
    escapologiePatterns = escapologiePatterns();
    bombermanPatterns = bombermanPatterns();
  }
}