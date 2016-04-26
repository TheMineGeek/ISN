 //<>//

class MapB {
  int[][] pattern = new int [][] {
    {1, 1, 1, 1, 1, 1, 1}, 
    {1, 0, 0, 2, 2, 0, 1}, 
    {1, 0, 1, 1, 0, 0, 1}, 
    {1, 2, 2, 0, 0, 2, 1}, 
    {1, 2, 1, 2, 0, 2, 1}, 
    {1, 0, 2, 0, 2, 1, 1}, 
    {1, 2, 2, 0, 3, -1, 1}, 
    {1, 1, 1, 1, 1, 1, 1}}; // initialise le tableau de la carte

  MapB() {
  }  // La pseudo fonction pour initialiser la map

  BlockB[] blocks = new BlockB[0]; // Tous les blocs créés


  void init() { // Fonction pour dessiner la carte
    for (int i = 0; i < this.pattern.length; i++) { // On parcourt la première dimension du tableau (colone)
      for (int j = 0; j < this.pattern[i].length; j++) { // On parcourt la seconde dimension du tableau (ligne)
        BlockB _block; // On nomme la variable _block
        if (pattern[i][j] == 1) {
          _block = new BlockB(j*100, i*100, false); // Si c'est 1 = Block incassable
          this.blocks = (BlockB[])append(this.blocks, _block); // Augmente la taille du tableau
        } else if (pattern[i][j] == 2) {
          _block = new BlockB(j*100, i*100, true); // Si c'est 2 : Block cassable
          this.blocks = (BlockB[])append(this.blocks, _block); // Augmente la taille du tableau
        } else if (pattern[i][j] == 3) {
          personnage.x = j*100+20;
          personnage.y = i*100+20;
        } else if (pattern[i][j] == -1) {
          porte = new PorteB(j*100, i*100);
        }
      }
    }

    println(this.blocks.length);
  }

  void tick () { 
    for (int i = 0; i<this.blocks.length; i++) {
      this.blocks[i].affiche();
    }
    personnage.affiche();
    porte.affiche();
  }
}


class BlockB {

  int x;
  int y;
  int size;
  color couleur;
  boolean cassable;

  // Constructeur 
  BlockB (int x, int y, boolean cassable) {
    this.cassable = cassable;
    size = 100;
    this.x = x;
    this.y = y;
    if (cassable) { 
      couleur = #FEE193;
    } else {
      couleur = #B98700;
    }
  }

  void affiche () {
    fill (couleur);
    rect (x, y, size, size);
  }
}

class PorteB {
  int x;
  int y;
  color couleur;
  int size;

  // constructeur
  PorteB(int x, int y) {
    this.x = x;
    this.y = y;
  }

  void affiche () {
    image(exit, x, y, 100, 100);
  }
}

class Personnage {
  int x;
  int y;
  int size;
  color couleur;

  // constructeur
  Personnage() {
  }


  void affiche () {
    image (perso, x, y, 60, 70);
  }

  void move (String direction) {
    int j = (this.x-20)/100; // traduit les x en coordonnés i de la carte
    int i = (this.y-20)/100; // traduit les y en coordonnées j de la carte



    if (direction == "left") {
      if (mapb.pattern[i][j-1] != 1 && mapb.pattern[i][j-1] != 2 && mapb.pattern[i][j-1] != 5 && mapb.pattern[i][j-1] != -1 && mapb.pattern[i][j-1] != 6) {
        this.x = this.x-100;
        if (mapb.pattern[i][j] == 4) {
          mapb.pattern[i][j] = 5;
        } else {
          mapb.pattern[i][j] = 0;
        } 
        mapb.pattern[i][j-1] = 3;
      }
      if (mapb.pattern[i][j-1] == -1) {
        if (mapb.pattern[i][j] == 4) {
          mapb.pattern[i][j] = 5;
        } else {
          mapb.pattern[i][j] = 0;
        } 
        mapb.pattern[i][j-1] = 7;
        println ("win");
      }
      if (mapb.pattern[i][j-1] == 6) {
        if (mapb.pattern[i][j] == 4) {
          mapb.pattern[i][j] = 5;
        } else {
          mapb.pattern[i][j] = 0;
        } 
        mapb.pattern[i][j-1] = 8 ;
        println ("lost");
      }
    } else if (direction == "right") {
      if (mapb.pattern[i][j+1] != 1 && mapb.pattern[i][j+1] != 2 && mapb.pattern[i][j+1] != 5 && mapb.pattern[i][j+1] != -1 && mapb.pattern[i][j+1] != 6) {
        this.x = this.x+100;
        if (mapb.pattern[i][j] == 4) {
          mapb.pattern[i][j] = 5;
        } else {
          mapb.pattern[i][j] = 0;
        } 
        mapb.pattern[i][j+1] = 3;
      }
      if (mapb.pattern[i][j+1] == -1) {
        if (mapb.pattern[i][j] == 4) {
          mapb.pattern[i][j] = 5;
        } else {
          mapb.pattern[i][j] = 0;
        } 
        mapb.pattern[i][j+1] = 7;
        println ("win");
      }
      if (mapb.pattern[i][j+1] == 6) {
        if (mapb.pattern[i][j] == 4) {
          mapb.pattern[i][j] = 5;
        } else {
          mapb.pattern[i][j] = 0;
        } 
        mapb.pattern[i][j+1] = 8 ;
        println ("lost");
      }
    } else if (direction == "top") {
      if (mapb.pattern[i-1][j] != 1 && mapb.pattern[i-1][j] != 2 && mapb.pattern[i-1][j] != 5 && mapb.pattern[i-1][j] != -1 && mapb.pattern[i-1][j] != 6) {
        this.y = this.y-100;
        if (mapb.pattern[i][j] == 4) {
          mapb.pattern[i][j] = 5;
        } else {
          mapb.pattern[i][j] = 0;
        } 
        mapb.pattern[i-1][j] = 3;
      }
      if (mapb.pattern[i-1][j] == -1) {
        if (mapb.pattern[i][j] == 4) {
          mapb.pattern[i][j] = 5;
        } else {
          mapb.pattern[i][j] = 0;
        } 
        mapb.pattern[i-1][j] = 7;
        println ("win");
      }
      if (mapb.pattern[i-1][j] == 6) {
        if (mapb.pattern[i][j] == 4) {
          mapb.pattern[i][j] = 5;
        } else {
          mapb.pattern[i][j] = 0;
        } 
        mapb.pattern[i-1][j] = 8 ;
        println ("lost");
      }
    } else if (direction == "bottom") {
      if (mapb.pattern[i+1][j] != 1 && mapb.pattern[i+1][j] != 2 && mapb.pattern[i+1][j] != 5 && mapb.pattern[i+1][j] != -1 && mapb.pattern[i+1][j] != 6) {
        if (mapb.pattern[i][j] == 4) {
          mapb.pattern[i][j] = 5;
        } else {
          mapb.pattern[i][j] = 0;
        } 
        mapb.pattern[i+1][j] = 3;
        this.y = this.y+100;
      }
      if (mapb.pattern[i+1][j] == -1) {
        if (mapb.pattern[i][j] == 4) {
          mapb.pattern[i][j] = 5;
        } else {
          mapb.pattern[i][j] = 0;
        } 
        mapb.pattern[i+1][j] = 7;
        println ("win");
      }
      if (mapb.pattern[i+1][j] == 6) {
        if (mapb.pattern[i][j] == 4) {
          mapb.pattern[i][j] = 5;
        } else {
          mapb.pattern[i][j] = 0;
        } 
        mapb.pattern[i+1][j] = 8 ;
        println ("lost");
      }
    }

    for (int k=0; k < mapb.pattern.length; k++) {
      for (int l=0; l < mapb.pattern [k].length; l++) {
        print (mapb.pattern[k][l]);
      }
      println ();
    }
    println();
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
  boolean exploding;

  Bombe() {
    this.active = false;
    timer = new Timer();
  }

  // constructeur
  Bombe(int x, int y) {
    this.active = false;
    this.x = x;
    this.y = y;
    timer = new Timer(); // Inclue le timer dans la bombe
    this.exploding = false;
  }  

  void affiche() {
    image(bombeimg, x, y, 75, 75);
  }

  void activate(int x, int y) {
    int i = (y-20)/100;
    int j = (x-20)/100;
    this.active = true; // la bombe est activée
    this.x = x;
    this.y = y;
    mapb.pattern[i][j] = 4;
    timer.start(); // démare le timer
  }


  void tick() {  
    this.timer.tick();
    int i = (y-20)/100;
    int j = (x-20)/100;
    if (timer.getTime() >= 7) {
      this.active = false;
      Explosion(this.x-25, this.y-25);
      this.exploding = true;
      if (mapb.pattern [i][j] == 3 ||mapb.pattern[i+1][j] == 3 || mapb.pattern[i-1][j] ==3 || mapb.pattern[i][j+1] == 3 || mapb.pattern[i][j-1] ==3) {
        println ("LOST");
      }
      mapb.pattern[i][j] = 6;

      if (mapb.pattern[i+1][j] == 2 || mapb.pattern[i+1][j] == 0) {
        mapb.pattern[i+1][j] = 6;
      }
      if (mapb.pattern[i-1][j] == 2 || mapb.pattern[i-1][j] == 0) {
        mapb.pattern[i-1][j] = 6;
      }
      if (mapb.pattern[i][j+1] == 2 || mapb.pattern[i][j+1] == 0) {
        mapb.pattern[i][j+1] = 6;
      }
      if (mapb.pattern[i][j-1] == 2 || mapb.pattern[i][j-1] == 0) {
        mapb.pattern[i][j-1] = 6;
      }
    }
    if (timer.getTime() >= 10) {
      this.exploding = false;
      for (int k=0; k < mapb.pattern.length; k++) {
        for (int l=0; l < mapb.pattern [k].length; l++) {
          if (mapb.pattern[k][l] == 6) {
            mapb.pattern[k][l] = 0;

            for (int m = 0; m < mapb.blocks.length; m++) {
              if (mapb.blocks[m].y/100 == k && mapb.blocks[m].x/100 == l) { // transforme les coordonnées du bloc en k et l 
                println(m);
                println(mapb.blocks.length);
                mapb.blocks = (BlockB[])concat((BlockB[])subset(mapb.blocks, 0, m), subset(mapb.blocks, m+1)); // permet de mettre à jour la liste de bloc dans l'intervalle [0;m[ Union [m+1, max]

                println(mapb.blocks.length);
              }
            }
          }
        }
      }
      timer.stop();
      timer.reset();
    }
  }

  void Explosion (int x, int y) {    
    image(croix, x, y, 100, 100);
  }
}