interface onWinInterface {  //<>//
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
    {1, 1, 0, 0, 0, 2, 0, 0, 0, 1}, 
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
    {1, 2, 0, 0, 0, 0, 0, 0, 3, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, -2, 0, 0, 0, 0, 0, 0, -3, 1}, 
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1}};

  patterns.add(pattern2);

  return patterns;
}

class Map { //<>// //<>// //<>// //<>//
  int[][] pattern;
  int speedX;
  int speedY;
  boolean win = false;
  boolean keyboardEvents = true;
  onWinInterface onWin;
  ArrayList<int[][]> patterns;

  Map(ArrayList<int[][]> patterns) {
    this.pattern = patterns.get(0);
    this.speedX = this.speedY = 10;
  }  // La pseudo fonction pour initialiser la map

  Block[] movableBlocks = new Block[0]; // Tous les blocs qui peuvent bouger
  Gate[] gates = new Gate[0]; // Tous les blocs qui sont les portes de sortie

  void init() { // Fonction pour dessiner la carte
    frameRate(60);
    for (int i = 0; i < this.pattern.length; i++) { // On parcourt la première dimension du tableau
      for (int j = 0; j < this.pattern[i].length; j++) { // On parcourt la seconde dimension du tableau
        if (pattern[i][j] == 1) {
          new Block(j*50, i*50, 50, 1, color(222, 184, 135)); // Si c'est un 1 on met un bloc marron
        } else if (pattern[i][j] < 0) {
          println("here");
          Gate _gate; // Si c'est un négatif c'est une porte de sortie
          if (pattern[i][j] == -2) {
            _gate = new Gate(j * 50, i * 50, 50, (int)sqrt(sq(pattern[i][j])), color(#FF0000)); // Porte rouge
          } else {
            _gate = new Gate(j * 50, i * 50, 50, (int)sqrt(sq(pattern[i][j])), color(#00FF00)); // Porte verte
          }
          pattern[i][j] = 0;
          gates = (Gate[])append(gates, _gate); // Augmente la taille du tableau
        } else if (pattern[i][j] != 0) {
          Block block; // Sinon c'est un bloc déplaçable
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

    println(this.gates.length);
    println(this.movableBlocks.length);
    println();
  }

  void setPattern(int pattern) {
    this.patterns = patternsSetup();
    this.pattern = this.patterns.get(pattern);
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
    int x = 0;
    int y = 0;
    if (direction == "left") {
      x = -1;
    } else if (direction == "right") {
      x = 1;
    } else if (direction == "top") {
      y = -1;
    } else if (direction == "bottom") { //<>//
      y = 1;
    }

    boolean[] cantMove = new boolean[this.movableBlocks.length]; // Tableau. Voir usage en dessous //<>//

    while (!allCantMove(cantMove)) { 
      for (int i = 0; i < this.movableBlocks.length; i++) {
        int indexX = this.movableBlocks[i].toMoveX/50 + this.movableBlocks[i].x/50 + x;
        int indexY = this.movableBlocks[i].toMoveY/50 + this.movableBlocks[i].y/50 + y;

        if (this.pattern[indexY][indexX] != 0) { //<>//
          cantMove[i] = true;
        } else {
          this.pattern[indexY-y][indexX-x] = 0;
          this.movableBlocks[i].toMove(x*50, y*50);
          this.pattern[indexY][indexX] = this.movableBlocks[i].id;
        }
      }
    }
  }

  void tick() {
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

  void checkWin() { // Regarde si tous les blocs sont dans la sortie que leurs correspond
    boolean win = true;
    for (int i = 0; i < this.movableBlocks.length; i++) {
      for (int j = 0; j < this.gates.length; j++) {
        if (this.movableBlocks[i].id == this.gates[j].id || this.movableBlocks[i].mustMove()) {
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

  void flushGates() {
    this.gates = (Gate[])subset(this.gates, 0, 0);
  }

  void flushBlocks() {
    this.movableBlocks = (Block[])subset(this.movableBlocks, 0, 0);
  }

  void screenshotAll(String path) {
    for (int i = 0; i < this.patterns.size(); i++) {
      this.flushBlocks();
      this.flushGates();
      this.pattern = this.patterns.get(i);
      this.init();
      screenshot.take(path + "\\escapologie-" + i + ".png");
    }
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
    rect(this.x, this.y, this.size, this.size);
  }

  void move(int vx, int vy) { 
    fill(#FFFFFF);
    noStroke();
    rect(this.x, this.y, this.size, this.size); // Efface l'ancien cube

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

  /*void move(String direction) { // Idem que celle du dessus mais elle prend pas les mêmes paramètres. c'est pour ça qu'elles peuvent avoir le même nom
   fill(#FFFFFF); // Rempli en blanc l'ancienne place du carré
   noStroke();
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
   }*/

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
    rect(this.x, this.y, this.size, this.size);
  }

  boolean hasBlock(int[][] pattern) { // La porte à le bloc sur elle
    if (pattern[this.y/50][this.x/50] == this.id) {
      return true;
    }
    return false;
  }
}