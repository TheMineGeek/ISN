public enum LevelDifficulty {
  EASY ("EASY"), 
    MEDIUM ("MEDIUM"), 
    HARD ("HARD");

  private String name = "";

  LevelDifficulty(String name) {
    this.name = name;
  }

  String toString() {
    return this.name;
  }
}

class Pattern {
  int id;
  boolean done;
  int[][] pattern;
  String game;

  LevelDifficulty levelDifficulty;

  Pattern(int[][] pattern, int id, LevelDifficulty levelDifficulty, String game) {
    this.game = game;
    this.done = false;
    this.levelDifficulty = levelDifficulty;
    this.pattern = pattern;
    this.id = id;
  }

  Pattern(int[][] pattern, int id, LevelDifficulty levelDifficulty, String game, boolean done) {
    this.game = game;
    this.done = done;
    this.levelDifficulty = levelDifficulty;
    this.pattern = pattern;
    this.id = id;
  }

  int[][] getPattern() {
    int[][] _pattern = new int[this.pattern.length][this.pattern[0].length];

    for (int i = 0; i < this.pattern.length; i++) {
      for (int j = 0; j < this.pattern[i].length; j++) {
        _pattern[i][j] = this.pattern[i][j];
      }
    }

    return _pattern;
  }

  String toJson() {
    String _pattern = "";

    _pattern += "[";
    for (int i = 0; i < this.pattern.length; i++) {
      _pattern += "[";
      for (int j = 0; j < this.pattern[i].length; j++) {
        if (j == this.pattern.length) {
          _pattern += str(pattern[i][j]);
        } else {
          _pattern += str(pattern[i][j]) + ",";
        }
      }
      if (i == this.pattern.length - 1) {
        _pattern += "]";
      } else {
        _pattern += "],";
      }
    }
    _pattern += "]";

    String toReturn = String.format("{\n\t\"id\" : %1$s,\n\t\"done\" : %2$s,\n\t\"levelDifficulty\" : %3$s,\n\t\"game\" : %4$s,\n\t\"pattern\" : %5$s\n}", this.id, this.done, this.levelDifficulty.toString(), this.game, _pattern);
    println(toReturn);
    return toReturn;
  }

  void log() {
    for (int i = 0; i < this.pattern.length; i++) {
      for (int j = 0; j < this.pattern[i].length; j++) {
        if (this.pattern[i][j] < 0) {
          print(this.pattern[i][j], "");
        } else {
          print(this.pattern[i][j], " ");
        }
      }
      println();
    }
  }
}

Pattern[] bombermanPatterns() {
  Pattern[] patterns = new Pattern[0];
    
  int[][] _pattern6 =  
    {  
    {1, 1, 1, 1, 1, 1, 1},  
    {1, 2, 0, 2, 0, -1, 1},  
    {1, 0, 1, 0, 2, 0, 1},  
    {1, 2, 2, 2, 1, 0, 1},  
    {1, 0, 0, 1, 1, 2, 1},  
    {1, 0, 2, 2, 0, 2, 1},  
    {1, 3, 0, 2, 0, 0, 1},  
    {1, 1, 1, 1, 1, 1, 1},  
  }; 
  Pattern pattern6 = new Pattern(_pattern6, patterns.length, LevelDifficulty.EASY, "bomberman"); 
  patterns = (Pattern[])append(patterns, pattern6); 
 
  int[][] _pattern7 = 
    {  
    {1, 1, 1, 1, 1, 1, 1},  
    {1, 3, 0, 2, 0, 2, 1},  
    {1, 0, 1, 0, 2, 0, 1},  
    {1, 2, 2, 1, 1, 0, 1},  
    {1, 0, 0, 1, 1, 0, 1},  
    {1, 0, 2, 2, 0, 2, 1},  
    {1, 0, 0, 2, 0, -1, 1},  
    {1, 1, 1, 1, 1, 1, 1},  
  }; 
 
  Pattern pattern7 = new Pattern(_pattern7, patterns.length, LevelDifficulty.MEDIUM, "bomberman"); 
  patterns = (Pattern[])append(patterns, pattern7); 
 
  int[][] _pattern8 = 
 
    { 
    {1, 1, 1, 1, 1, 1, 1},  
    {1, 2, 0, 2, 0, 2, 1},  
    {1, 0, 1, 2, 1, 0, 1},  
    {1, 2, 2, -1, 1, 0, 1},  
    {1, 0, 1, 1, 1, 0, 1},  
    {1, 0, 2, 2, 0, 2, 1},  
    {1, 0, 2, 0, 3, 0, 1},  
    {1, 1, 1, 1, 1, 1, 1},  
  }; 
 
  Pattern pattern8 = new Pattern(_pattern8, patterns.length, LevelDifficulty.EASY, "bomberman"); 
  patterns = (Pattern[])append(patterns, pattern8); 
 
  int[][] _pattern9 =  
    { 
    {  1, 1, 1, 1, 1, 1, 1  },  
    {  1, 3, 0, 2, 0, 2, 1  },  
    {  1, 0, 1, 0, 1, 0, 1  },  
    {  1, 2, 2, 0, 2, 0, 1  },  
    {  1, 0, 1, 0, 1, 0, 1  },  
    {  1, 2, 2, 2, 0, 2, 1  },  
    {  1, 0, 1, 2, 1, -1, 1 },  
    {  1, 1, 1, 1, 1, 1, 1  },  
  }; 
 
  Pattern pattern9 = new Pattern(_pattern9, patterns.length, LevelDifficulty.EASY, "bomberman"); 
  patterns = (Pattern[])append(patterns, pattern9); 
 
  int [][] _pattern10 = 
    { 
    {  1, 1, 1, 1, 1, 1, 1  },  
    {  1, 3, 0, 2, 0, 2, 1  },  
    {  1, 0, 1, 0, 2, 0, 1  },  
    {  1, 2, 2, 1, 1, 0, 1  },  
    {  1, 0, 0, 1, 0, 0, 1  },  
    {  1, 0, 2, 2, 0, 1, 1  },  
    {  1, 1, 0, 2, 0, -1, 1  },  
    {  1, 1, 1, 1, 1, 1, 1  },  
 
 
  }; 
 
  Pattern pattern10 = new Pattern(_pattern10, patterns.length, LevelDifficulty.EASY, "bomberman"); 
  patterns = (Pattern[])append(patterns, pattern10); 

  return patterns;
}

/**
 * Return all escapologie patterns
 */
Pattern[] escapologiePatterns() {  
  Pattern[] patterns = new Pattern[0];

  int[][] _pattern = {
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
    {1, 1, 0, 0, 0, 2, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 1, 0, 1}, 
    {1, 0, 1, 1, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 1, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 1, 1}, 
    {1, 1, 0, 0, -2, 0, 0, 0, 0, 1}, 
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1}}; 
  Pattern pattern = new Pattern(_pattern, patterns.length, LevelDifficulty.EASY, "escapologie");
  patterns = (Pattern[])append(patterns, pattern);


  int[][] _pattern2 = {
    {1, 1, 1, 1, 1, 1, 1, 1, 1}, 
    {1, 0, 0, 0, 1, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 2, 1}, 
    {1, 0, 0, 1, 0, 0, 0, 0, 1}, 
    {1, 0, 1, 0, 0, 0, 1, 0, 1}, 
    {1, 0, 0, 0, 1, 0, -2, 1, 1}, 
    {1, 1, 0, 0, 0, 0, 0, 1, 1}, 
    {1, 0, 0, 1, 0, 0, 1, 1, 1}, 
    {1, 1, 1, 1, 1, 1, 1, 1, 1}};

  Pattern pattern2 = new Pattern(_pattern2, patterns.length, LevelDifficulty.EASY, "escapologie");
  patterns = (Pattern[])append(patterns, pattern2);

  int[][] _pattern3 = {
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
    {1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, -2, 1}, 
    {1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1}, 
    {1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1}, 
    {1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1}, 
    {1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 2, 0, 1}, 
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}}; 

  Pattern pattern3 = new Pattern(_pattern3, patterns.length, LevelDifficulty.HARD, "escapologie");
  patterns = (Pattern[])append(patterns, pattern3);

  int[][] _pattern4 = {
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
    {1, 1, 1, 0, 0, 0, 1, -2, 0, 1, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1}, 
    {1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1}, 
    {1, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1}, 
    {1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 1, 0, 0, 1, 1, 0, 1}, 
    {1, 0, 1, 0, 0, 0, 0, 0, 2, 0, 1}, 
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}}; 

  Pattern pattern4 = new Pattern(_pattern4, patterns.length, LevelDifficulty.EASY, "escapologie");
  patterns = (Pattern[])append(patterns, pattern4);

  int[][] _pattern5 = {
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
    {1, 1, 2, 0, 0, 0, 0, 0, 1, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 1, 0, 0, 0, 0, 1, 0, 0, 1}, 
    {1, 0, 1, 1, 0, 0, 0, 0, 3, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 1, 0, 1}, 
    {1, 1, 0, 0, 0, 1, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 1, 1}, 
    {1, 0, 1, 0, 1, 0, 0, 0, 0, 1}, 
    {1, 0, 0, -2, 1, 0, 1, 0, -3, 1}, 
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1}}; 

  Pattern pattern5 = new Pattern(_pattern5, patterns.length, LevelDifficulty.MEDIUM, "escapologie");
  patterns = (Pattern[])append(patterns, pattern5);

  return patterns;
}