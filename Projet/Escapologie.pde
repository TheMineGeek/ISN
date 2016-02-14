class Map {
  int[][] pattern = {{1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
                    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
                    {1, 0, 0, 0, 0, 1, 0, 0, 0, 1}, 
                    {1, 0, 4, 0, 0, 0, 0, 0, 0, 1}, 
                    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
                    {1, 0, 0, 0, 0, 3, 0, 0, 0, 1}, 
                    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
                    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
                    {1, 0, 0, 0, 0, 0, 0, 2, 1, 1}, 
                    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1}}; // La map
  Map() {
  }  // La pseudo fonction pour initialiser la map

  Block[] movableBlocks = new Block[0]; // Tous les blocs qui peuvent bouger

  void init() { // Fonction pour dessiner la carte
    for (int i = 0; i < this.pattern.length; i++) { // On parcourt la première dimension du tableau
      for (int j = 0; j < this.pattern[i].length; j++) { // On parcourt la seconde dimension du tableau
        if (pattern[i][j] == 1) {
          Block bloc = new Block(j*50, i*50, 50, color(222, 184, 135)); // Si c'est un 1 on met un bloc marron
        } else if (pattern[i][j] != 0) {
          Block block; // Sinon on fait autre chose
          if (pattern[i][j] == 2) {
            block = new Block(j*50, i*50, 50, color(#FF0000));
          } else if (pattern[i][j] == 3) {
            block = new Block(j*50, i*50, 50, color(#00FF00));
          } else {
            block = new Block(j*50, i*50, 50, color(#0000FF));
          }

          movableBlocks = (Block[])append(movableBlocks, block); // A chaque fois que ce n'est pas un bloc marron, on l'ajoute à la liste des blocs déplaçables
        }
      }
    }
  }

  boolean allCantMove(boolean[] array) { // Petite fonction pour voir si tous les booleans d'un tableau sont à true. Si oui, on return true, sinon false;
    boolean move = true;
    for (int i = 0; i < array.length; i++) {
      if (!array[i]) { // Le ! signigie "inverse de" donc en l'occurence c'est pareil qu'un if(array[i] == false)
        move = false;
      }
    }
    return move;
  }

  void move(String direction) { // Fonction pour faire bouger tous les blocs qui le peuvent sur la carte
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

    while (!allCantMove(cantMove)) { // Tant que tous les blocs ne sont pas bloqués, on fait ça
      for (int i = 0; i < this.movableBlocks.length; i++) { // On parcourt les blocs déplaçables
        if (this.pattern[this.movableBlocks[i].y/50 + y][this.movableBlocks[i].x/50 + x] != 0) { // Bon la je t'expliquerai à l'oral ou essaye de comprendre seule parce que c'est pas simple par écrit
          cantMove[i] = true;
        } else {
          this.movableBlocks[i].move(direction); 
        }
      }
    }
  }
}

class Block {  
  int size;
  int x;
  int y;
  color blockColor;

  Block() {
  }

  Block(int x, int y, int size, color blockColor) {
    this.x    = x;
    this.y    = y;
    this.size = size;
    this.blockColor = blockColor;
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
    fill(#FFFFFF);
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