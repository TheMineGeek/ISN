 //<>//

class MapB {
  int[][] pattern = new int [][] {
    {1, 1, 1, 1, 1, 1, 1}, 
    {1, 0, 0, 2, 1, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 1}, 
    {1, 1, 1, 1, 1, 1, 1}}; // initialise le tableau de la carte

  MapB() {
  }  // La pseudo fonction pour initialiser la map

  BlockB[] blocks = new BlockB[0]; // Tous les blocs qui peuvent bouger


  void init() { // Fonction pour dessiner la carte
    for (int i = 0; i < this.pattern.length; i++) { // On parcourt la première dimension du tableau
      for (int j = 0; j < this.pattern[i].length; j++) { // On parcourt la seconde dimension du tableau
        BlockB _block;
        if (pattern[i][j] == 1) {
          _block = new BlockB(false); // Si c'est 1 = Block incassable
          this.blocks = (BlockB[])append(this.blocks, _block); // Augmente la taille du tableau
        } else if (pattern[i][j] == 2) {
          _block = new BlockB(true); // Si c'est 2 : Block cassable
          this.blocks = (BlockB[])append(this.blocks, _block); // Augmente la taille du tableau
        }
      }
    }
  }
  
  void tick () {
     for (int i = 0; i<this.blocks.length; i++) {
   this.blocks[i].affiche();
 }
  }
}


class BlockB {

  int x;
  int y;
  int size;
  color couleur;
  boolean cassable;

  // Constructeur 
  BlockB (boolean cassable) {
    this.cassable = cassable;
    size = 50;
    if (cassable) { 
      couleur = #AE00DD;
    } else {
      couleur = #FF00DD;
    }
    x = 300;
    y = 300;
  }

  void affiche () {
    fill (couleur);
    rect (x, y, size, size);
  }
}



class Personnage {
  int x;
  int y;
  int size;
  color couleur;

  // constructeur
  Personnage() {
    size = 50;
    couleur = #000000;
    x = 50;
    y = 50;
  }


  void affiche () {
   image (perso, x, y, 60, 70);
  }

  void move (String direction) {
    if (direction == "left") {
      this.x = x-4;
    } else if (direction == "right") {
      this.x = x+4;
    } else if (direction == "top") {
      this.y = y-4;
    } else if (direction == "bottom") {
      this.y = y+4;
    }
  }
}


class Bombe {
  int x;
  int y;
  int size1;
  int size2;
  color couleur;
  boolean active;
  Timer timer;
  int duree;

  Bombe() {
    this.active = false;
    size1 = 25;
    size2 = 12;
    couleur = color(192, 192, 192);
    timer = new Timer();
  }

  // constructeur
  Bombe(int x, int y) {
    this.active = false;
    size1 = 25;
    size2 = 12;
    this.x = x;
    this.y = y;
    timer = new Timer(); // Inclue le timer dans la bombe
    couleur = color(192, 192, 192);
  }  

  void affiche() {
    image(bombeimg, x, y, 50, 35);
   
  }

  void activate(int x, int y) {
    this.active = true; // la bombe est activée
    this.x = x;
    this.y = y;
    timer.start(); // démare le timer
  }

  void tick() {  
    this.timer.tick();
    if (timer.getTime() >= 7) {
      this.active = false;
      Explosion(this.x-25, this.y-25);
    }
    if (timer.getTime() >= 10) {
      timer.stop();
      timer.reset();
    }
  }

  void Explosion (int x, int y) {
    image(croix, x, y, 100, 100);
  }
}