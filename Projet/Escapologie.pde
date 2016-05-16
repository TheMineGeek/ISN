interface onWinInterface {  //<>// //<>// //<>// //<>//
  void toDo();
}  //<>//

class Map {
  int[][] pattern;
  int speedX;
  int speedY;
  int spaceX;
  int spaceY;
  int blocSize;
  boolean win = false;
  boolean keyboardEvents = true; // on peut utiliser le clavier
  boolean firstKeyPressed = false; // le jeu attend pour déclancher le timer
  onWinInterface onWin;
  int mapID;

  Timer timer;

  Map() {
    this.blocSize = 50;
    this.speedX = this.speedY = 10; // vitesse de déplacement du bloc
    timer = new Timer();
  }  // La pseudo fonction pour initialiser la map

  Block[] movableBlocks = new Block[0]; // Tous les blocs qui peuvent bouger
  Gate[] gates = new Gate[0]; // Tous les blocs qui sont les portes de sortie

  void init() { // Fonction pour dessiner la carte et initialiser le jeu
    background(#FFFFFF);
    frameRate(60);
    this.win = false; 
    this.timer.reset();
    this.keyboardEvents = true;
    this.firstKeyPressed = false;
    map.flushBlocks();
    map.flushGates();

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
          Block block; // Sinon c'est un bloc déplaçable dont la couleur change selon le numéro sur la matrice
          if (pattern[i][j] == 2) {
            block = new Block(j * this.blocSize, i * this.blocSize, this.blocSize, 2, color(#FF0000));
          } else if (pattern[i][j] == 3) { 
            block = new Block(j * this.blocSize, i * this.blocSize, this.blocSize, 3, color(#00FF00));
          } else {
            block = new Block(j * this.blocSize, i * this.blocSize, this.blocSize, 4, color(#0000FF));
          }

          movableBlocks = (Block[])append(movableBlocks, block); // on augmente la taille du tableau de bloc qui bougent
        }
      }
    }

    /* Classements */

    if (Multiplayer.canJoinStatServer()) {
      fill(#FFFFFF);
      stroke(0);
      rect(pixelWidth / 2 + this.spaceX + 65, 10, 150, 30);
      noStroke();
      fill(#000000);
      textAlign(LEFT);
      textSize(17);
      text("Meilleurs temps", pixelWidth / 2 + this.spaceX + 75, 30);

      JSONArray times = parseJSONArray(Multiplayer.Escapologie.getStats(this.mapID, 10));


      for (int i = 0; i < times.size(); i++) {
        JSONObject time = times.getJSONObject(i);

        String record = (i + 1) + " " + time.getString("username") + " " + String.format("%.4g%n", time.getFloat("score"));
        noStroke();
        textSize(13);
        textAlign(LEFT);
        text(record, pixelWidth / 2 + this.spaceX + 75, 70 + i * 20); // affichage des scors
      }
    }
  }

  void setPattern(int pattern) {
    this.pattern = null; // nettoie le tableau de map
    this.pattern = escapologiePatterns[pattern].getPattern();
    this.mapID = pattern; // importe la bonne map

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
    // actions au clavier pour le mouvement
    if (!this.firstKeyPressed) {
      // permet de lancer le timer au premier mouvement
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
      // Si le joueur n'a pas gagné ...
      timer.tick();

      fill(#FFFFFF);
      stroke(0);
      rect(this.spaceX / 2 - 40, 10, 80, 30);

      textAlign(CENTER);
      fill(#000000);
      textSize(20);
      text(String.format("%.3g%n", timer.getTime()), this.spaceX / 2, 30);

      for (int i = 0; i < gates.length; i++) {
        gates[i].show(); // la porte est visible
      }

      this.keyboardEvents = true; // il est possible de bouger

      for (int i = 0; i < this.movableBlocks.length; i++) {   
        this.movableBlocks[i].move(this.speedX, this.speedY);
        if (this.movableBlocks[i].mustMove()) this.keyboardEvents = false;
      }   
      this.checkWin();
    }
  }

  void checkWin() { // Regarde si tous les blocs sont dans la sortie qui leurs correspond
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
      escapologiePatterns[mapID].done = true;  // le niveau est sauvegardé
      timer.stop(); // le timer s'arrête 
      this.onWin.toDo(); // Ce qu'il faut afficher lors de la fin de la partie apparait
    }
  }

  void flushGates() {
    this.gates = (Gate[])subset(this.gates, 0, 0); // les portes disparaissent
  }

  void flushBlocks() {
    this.movableBlocks = (Block[])subset(this.movableBlocks, 0, 0); // les blocs mobiles disparaissent
  }
}

class Block {

  // permet la construction des blocs mobiles ou non

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

  Boolean mustMove() { // vérifie si tous les blocs ont fini leur mouvement
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

  boolean hasBlock(int[][] pattern) { // La porte a le bloc sur elle
    if (pattern[this.y/50][this.x/50] == this.id) {
      return true;
    }
    return false;
  }
}