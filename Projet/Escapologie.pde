interface onWinInterface { //<>//
  void toDo();
}

/**
 * Return all patterns
 */
ArrayList<int[][]> patternsSetup() {  
  ArrayList<int[][]> patterns = new ArrayList<int[][]>();
  
  int[][] blank = {{1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1}}; 

  int[][] pattern ={{1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
    {1, 1, 0, 0, 0, 0, 0, 0, 2, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 1, 0, 1}, 
    {1, 0, 1, 1, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 1, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 1, 1}, 
    {1, 1, 0, 0, -2, 0, 0, 0, 0, 1}, 
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1}}; 

  patterns.add(pattern);

  int[][] pattern2 = {{1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1}};

  patterns.add(pattern2);
  
  return patterns;
}

class Map { //<>// //<>//
  int[][] pattern;

  onWinInterface onWin;

  Map(ArrayList<int[][]> patterns) {
    this.pattern = patterns.get(0);
  }  // La pseudo fonction pour initialiser la map

  Block[] movableBlocks = new Block[0]; // Tous les blocs qui peuvent bouger
  Gate[] gates = new Gate[0];

  void init() { // Fonction pour dessiner la carte
    for (int i = 0; i < this.pattern.length; i++) { // On parcourt la première dimension du tableau
      for (int j = 0; j < this.pattern[i].length; j++) { // On parcourt la seconde dimension du tableau
        if (pattern[i][j] == 1) {
          new Block(j*50, i*50, 50, 1, color(222, 184, 135)); // Si c'est un 1 on met un bloc marron
        } else if (pattern[i][j] < 0) {
          Gate _gate;
          if (pattern[i][j] == -2) {
            _gate = new Gate(j * 50, i * 50, 50, (int)sqrt(sq(pattern[i][j])), color(#FF0000));
          } else {
            _gate = new Gate(j * 50, i * 50, 50, (int)sqrt(sq(pattern[i][j])), color(#00FF00));
          }
          pattern[i][j] = 0;
          gates = (Gate[])append(gates, _gate);
        } else if (pattern[i][j] != 0) {
          Block block; // Sinon on fait autre chose
          if (pattern[i][j] == 2) {
            block = new Block(j*50, i*50, 50, 2, color(#FF0000));
          } else if (pattern[i][j] == 3) {
            block = new Block(j*50, i*50, 50, 3, color(#00FF00));
          } else {
            block = new Block(j*50, i*50, 50, 4, color(#0000FF));
          }

          movableBlocks = (Block[])append(movableBlocks, block);
        }
      }
    }
  }

  boolean allCantMove(boolean[] array) {
    boolean move = true;
    for (int i = 0; i < array.length; i++) {
      if (!array[i]) { 
        move = false;
      }
    }
    return move;
  }

  void move(String direction) { 
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
        if (this.pattern[this.movableBlocks[i].y/50 + y][this.movableBlocks[i].x/50 + x] != 0) { 
          cantMove[i] = true;
        } else {
          this.pattern[this.movableBlocks[i].y/50][this.movableBlocks[i].x/50] = 0;
          this.movableBlocks[i].move(direction); 
          this.pattern[this.movableBlocks[i].y/50][this.movableBlocks[i].x/50] = this.movableBlocks[i].id;
        }
      }
    } //<>//
    this.checkWin();
  }

  void checkWin() {
    boolean win = true;
    for (int i = 0; i < this.movableBlocks.length; i++) {
      for (int j = 0; j < this.gates.length; j++) {
        if (this.movableBlocks[i].id == this.gates[j].id) {
          if (!(this.movableBlocks[i].x == this.gates[j].x && this.movableBlocks[i].y == this.gates[j].y)) {
            win = false;
          }
        }
      }
    }

    if (win) {
      this.onWin.toDo();
    }
  }
}

class Block {  
  int size;
  int x;
  int y;
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

  void show() {
    fill(this.blockColor);
    noStroke();
    rect(this.x, this.y, this.size, this.size);
  }

  void move(int toX, int toY) { // C'est pas la final. C'est juste pour commencer. Il y aura les animations à faire
    fill(#FFFFFF);
    rect(this.x, this.y, this.size, this.size);
    this.x += toX;
    this.y += toY;
    this.show();
  }

  void move(String direction) { // Idem que celle du dessus mais elle prend pas les mêmes paramètres. c'est pour ça qu'elles peuvent avoir le même nom
    fill(#FFFFFF); // Rempli en blanc l'ancienne place du carré
    rect(this.x, this.y, this.size, this.size);
    
    if (direction == "left") {
      this.x -= 50;
    } else if (direction == "right") {
      this.x += 50;
    } else if (direction == "top") {
      this.y -= 50;
    } else if (direction == "bottom") {
      this.y += 50;
    }
    this.show();
  }
}

class Gate {
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

  void show() {
    stroke(this.gateColor);
    fill(#FFFFFF);
    rect(this.x, this.y, this.size, this.size);
  }

  boolean hasBlock(int[][] pattern) {
    if (pattern[this.y/50][this.x/50] == this.id) {
      return true;
    }
    return false;
  }
}