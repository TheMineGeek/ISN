interface onWinInterface { //<>// //<>// //<>// //<>// //<>//
  void toDo();
}

/**
 * Return all patterns
 */
Pattern[] Patterns() {  
  Pattern[] patterns = new Pattern[0];

  int[][] blank = {
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1}}; 

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
  Pattern pattern = new Pattern(_pattern, LevelDifficulty.EASY);
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

  Pattern pattern2 = new Pattern(_pattern2, LevelDifficulty.MEDIUM);
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

  Pattern pattern3 = new Pattern(_pattern3, LevelDifficulty.HARD);
  patterns = (Pattern[])append(patterns, pattern3);

  return patterns;
}

class Map {
  int[][] pattern;
  int speedX;
  int speedY;
  int spaceX;
  int spaceY;
  int blocSize;
  boolean win = false;
  boolean keyboardEvents = true;
  boolean firstKeyPressed = false;
  onWinInterface onWin;
  int mapID;

  Timer timer;

  Map() {
    this.blocSize = 50;
    this.speedX = this.speedY = 10;
    timer = new Timer();
  }  // La pseudo fonction pour initialiser la map

  Block[] movableBlocks = new Block[0]; // Tous les blocs qui peuvent bouger
  Gate[] gates = new Gate[0]; // Tous les blocs qui sont les portes de sortie

  void init() { // Fonction pour dessiner la carte
    background(#FFFFFF);
    frameRate(60);
    for (int i = 0; i < this.pattern.length; i++) { // On parcourt la première dimension du tableau
      for (int j = 0; j < this.pattern[i].length; j++) { // On parcourt la seconde dimension du tableau
        if (pattern[i][j] == 1) {
          new Block(j * this.blocSize, i *this.blocSize, this.blocSize, 1, color(222, 184, 135)); // Si c'est un 1 on met un bloc marron
        } else if (pattern[i][j] < 0) {
          Gate _gate; // Si c'est un négatif c'est une porte de sortie
          if (pattern[i][j] == -2) {
            _gate = new Gate(j * this.blocSize, i * this.blocSize, this.blocSize, (int)sqrt(sq(pattern[i][j])), color(#FF0000)); // Porte rouge
          } else {
            _gate = new Gate(j * this.blocSize, i * this.blocSize, this.blocSize, (int)sqrt(sq(pattern[i][j])), color(#00FF00)); // Porte verte
          }
          pattern[i][j] = 0;
          gates = (Gate[])append(gates, _gate); // Augmente la taille du tableau
        } else if (pattern[i][j] != 0) {
          Block block; // Sinon c'est un bloc déplaçable
          if (pattern[i][j] == 2) {
            block = new Block(j * this.blocSize, i * this.blocSize, this.blocSize, 2, color(#FF0000));
          } else if (pattern[i][j] == 3) { 
            block = new Block(j * this.blocSize, i * this.blocSize, this.blocSize, 3, color(#00FF00));
          } else {
            block = new Block(j * this.blocSize, i * this.blocSize, this.blocSize, 4, color(#0000FF));
          }

          movableBlocks = (Block[])append(movableBlocks, block);
        }
      }
    }

    /* Classements */

    if (Multiplayer.canJoinStatServer()) {
      fill(#000000);
      textAlign(CENTER);
      text("Meilleurs temps", pixelWidth / 2 + this.spaceX + 150, 30);

      JSONArray times = parseJSONArray(Multiplayer.Escapologie.getStats(this.mapID, 10));


      for (int i = 0; i < times.size(); i++) {
        JSONObject time = times.getJSONObject(i);

        String record = (i + 1) + " " + time.getString("username") + " " + String.format("%.4g%n", time.getFloat("score"));
        text(record, pixelWidth / 2 + this.spaceX + 150, 70 + i * 20);
      }
    }
  }
  //<>//
  void setPattern(int pattern) {
    this.pattern = patterns[pattern].getPattern();
    this.mapID = pattern;

    this.spaceX = (pixelWidth - this.pattern[0].length * this.blocSize) / 2;
    this.spaceY = (pixelHeight - this.pattern.length * this.blocSize) / 2;
  }

  boolean allCantMove(boolean[] array) { // Si plus aucun ne peut bouger, retourne true
    boolean move = true;
    for (int i = 0; i < array.length; i++) {
      if (!array[i]) { 
        move = false;
      }
    }
    return move;
  }

  void move(String direction) { 
    if (!this.firstKeyPressed) {
      firstKeyPressed = true;
      timer.start();
    }
    int x = 0;
    int y = 0;
    if (direction == "left") {
      x = -1;
    } else if (direction == "right") {
      x = 1;
    } else if (direction == "top") {
      y = -1;
    } else if (direction == "bottom") {
      y = 1;
    }

    boolean[] cantMove = new boolean[this.movableBlocks.length]; // Tableau. Voir usage en dessous

    while (!allCantMove(cantMove)) { 
      for (int i = 0; i < this.movableBlocks.length; i++) {
        int indexX = this.movableBlocks[i].toMoveX/this.blocSize + this.movableBlocks[i].x/this.blocSize + x;
        int indexY = this.movableBlocks[i].toMoveY/this.blocSize + this.movableBlocks[i].y/this.blocSize + y;

        if (this.pattern[indexY][indexX] != 0) {
          cantMove[i] = true;
        } else {
          this.pattern[indexY-y][indexX-x] = 0;
          this.movableBlocks[i].toMove(x*this.blocSize, y*this.blocSize);
          this.pattern[indexY][indexX] = this.movableBlocks[i].id;
        }
      }
    }
  }

  void tick() {
    if (!this.win) {
      timer.tick();
      fill(#FFFFFF);
      rect(0, 0, this.spaceX, pixelHeight);

      textAlign(CENTER);
      fill(#000000);
      textSize(20);
      text(String.format("%.3g%n", timer.getTime()), this.spaceX / 2, 30);

      boolean _keyboardEvents = true;

      for (int i = 0; i < gates.length; i++) {
        gates[i].show();
      }

      for (int i = 0; i < this.movableBlocks.length; i++) {   
        this.movableBlocks[i].move(this.speedX, this.speedY);
        _keyboardEvents = !this.movableBlocks[i].mustMove();
      }   
      this.checkWin();
      this.keyboardEvents = _keyboardEvents;
    }
  }

  void checkWin() { // Regarde si tous les blocs sont dans la sortie que leurs correspond
    boolean win = true;
    for (int i = 0; i < this.movableBlocks.length; i++) {
      if (this.movableBlocks[i].toMoveX != 0 || this.movableBlocks[i].toMoveY != 0) {
        win = false;
      }
      for (int j = 0; j < this.gates.length; j++) {
        if (this.movableBlocks[i].id == this.gates[j].id || this.movableBlocks[i].mustMove()) {
          if (!(this.movableBlocks[i].x == this.gates[j].x && this.movableBlocks[i].y == this.gates[j].y)) {
            win = false;
          }
        }
      }
    }

    if (win) {
      timer.stop();
      this.onWin.toDo();
    }
  }

  void flushGates() {
    this.gates = (Gate[])subset(this.gates, 0, 0);
  }

  void flushBlocks() {
    this.movableBlocks = (Block[])subset(this.movableBlocks, 0, 0);
  }
}

class Block {  
  int size;
  int x;
  int y;
  int toMoveX;
  int toMoveY;
  int id;
  color blockColor;

  Block() {
  }

  Block(int x, int y, int size, int id, color blockColor) {
    this.x    = x;
    this.y    = y;
    this.size = size;
    this.blockColor = blockColor;
    this.id = id;
    this.show();
  }

  void show() { // Affiche le bloc
    fill(this.blockColor);
    noStroke();
    rect(this.x + map.spaceX, this.y + map.spaceY, this.size, this.size);
  }

  void move(int vx, int vy) { 
    fill(#FFFFFF);
    noStroke();
    rect(this.x + map.spaceX, this.y + map.spaceY, this.size, this.size); // Efface l'ancien cube

    if (this.toMoveX < 0) {
      this.toMoveX += vx;
      this.x -= vx;
    } else if (this.toMoveX > 0) {
      this.toMoveX -= vx;
      this.x += vx;
    }

    if (this.toMoveY < 0) {
      this.toMoveY += vy;
      this.y -= vy;
    } else if (this.toMoveY > 0) {
      this.toMoveY -= vy;
      this.y += vy;
    }

    this.show();
  }

  void toMove(int x, int y) {
    this.toMoveX += x;
    this.toMoveY += y;
  }

  Boolean mustMove() {
    if (this.toMoveX == 0 && this.toMoveY == 0) {
      return false;
    } else {
      return true;
    }
  }
}

class Gate { // Class pour les portes de sortie
  int x;
  int y;
  int id;
  color gateColor;
  int size;

  Gate() {
  }

  Gate(int x, int y, int size, int id, color gateColor) {
    this.x = x;
    this.y = y;
    this.size = size;
    this.id = id;
    this.gateColor = gateColor;
    this.show();
  }

  void show() { // Affiche la porte
    stroke(this.gateColor);
    fill(#FFFFFF);
    rect(this.x + map.spaceX, this.y + map.spaceY, this.size, this.size);
  }

  boolean hasBlock(int[][] pattern) { // La porte à le bloc sur elle
    if (pattern[this.y/50][this.x/50] == this.id) {
      return true;
    }
    return false;
  }
}

public enum LevelDifficulty {
  EASY, 
    MEDIUM, 
    HARD
}

  class Pattern {
  boolean done;
  int[][] pattern;

  LevelDifficulty levelDifficulty;

  Pattern(int[][] pattern, LevelDifficulty levelDifficulty) {
    this.done = false;
    this.levelDifficulty = levelDifficulty;
    this.pattern = pattern;
  }

  int[][] getPattern() {
    return this.pattern;
  }
}