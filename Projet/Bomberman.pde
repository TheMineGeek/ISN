class MapB { //<>// //<>//
  /**
   * Cette class sert à créer la carte de jeux. 
   * Elle affiche les blocs en fonction de ce qui est renseigné dans le tableau de la carte 
   **/

  int[][] pattern = new int [][] {
    {1, 1, 1, 1, 1, 1, 1}, 
    {1, 1, 0, 2, 2, 0, 1}, 
    {1, 0, 1, 1, 0, 0, 1}, 
    {1, 2, 2, 0, 0, 2, 1}, 
    {1, 2, 1, 2, 0, 2, 1}, 
    {1, 0, 2, 0, 2, 1, 1}, 
    {1, 2, 2, 0, 0, -1, 1}, 
    {1, 1, 1, 1, 1, 1, 1}};  // Initialise le tableau de la carte
  //Il s'agit ici d'un tableau de test

  MapB() {
    timer = new Timer(); // création d'un nouveau timer
  }  // Constructeur de la class

  String win = ""; // condition pour gagner ou perdre
  int mapID = -1; // donne le nom du niveau
  Timer timer;

  BlockB[] blocks = new BlockB[0]; // Tous les blocs créés


  void init() { // Fonction pour dessiner la carte
    for (int i = 0; i < this.pattern.length; i++) { // On parcourt la première dimension du tableau (colone)
      for (int j = 0; j < this.pattern[i].length; j++) { // On parcourt la seconde dimension du tableau (ligne)
        BlockB _block; // On nomme la variable _block
        if (pattern[i][j] == 1) {
          _block = new BlockB(j*100, i*100, false); // Si c'est 1 : Block incassable
          this.blocks = (BlockB[])append(this.blocks, _block); // Augmente la taille du tableau
        } else if (pattern[i][j] == 2) {
          _block = new BlockB(j*100, i*100, true); // Si c'est 2 : Block cassable
          this.blocks = (BlockB[])append(this.blocks, _block); // Augmente la taille du tableau
        } else if (pattern[i][j] == 3) {
          personnage.x = j*100+20; // donne les coordonnées du personnage
          personnage.y = i*100+20; // on convertit les x et y en cases de la matrice
        } else if (pattern[i][j] == -1) {
          porte = new PorteB(j*100, i*100); // création de la porte
        }
      }
    }
  }

  void tick () { 
    // fonction qui permet le bon déroulement des actions dans Bomberman
    if (this.win == "") { 
      // lorsque le jeu vient d'être lancé
      background(#FFFFFF);
      for (int i = 0; i<this.blocks.length; i++) {
        this.blocks[i].affiche();
      }

      for (int i=0; i<20; i++) {
        // affiche les bombes activées.
        tbombe[i].tick();
        if (tbombe[i].active) {
          tbombe[i].affiche();
        }
      }

      personnage.affiche();
      porte.affiche();
      sonAmbiance.play();
    } else { 
      // lorsque l'on a gagné ou perdu
      timer.tick();
      if (!timer.activated) {
        // lorsque le timer n'est plus activé ...
        sonAmbiance.close();
        minim.stop();

        if (this.win == "win") { 
          // ce qu'il se passe lorsque l'on gagne
          // affichage du texte
          background(#FFFFFF);
          fill(#000000);
          textAlign(CENTER);
          textSize(52);
          text("Bravo, vous avez gagné !", 350, 250);

          //sauvegarde
          bombermanPatterns[this.mapID].done = true; // la map jouée est sauvegardée en tant que niveau terminé
          saveEscapologie(encrypt(patternsToJson())); // cryptage de la sauvegarde pour éviter la triche
        } else if (this.win == "lose") {
          // ce qu'il se passe lorsque l'on perd : affichage du texte
          background(#000000);
          fill(#FFFFFF);
          textAlign(CENTER);
          textSize(52);
          text("Dommage, vous avez perdu :(", 250, 250);
        }

        for (int i = 0; i < 20; i++) {
          // pour faire disparaitre les bombes activées lors de la fin du jeu
          tbombe[i].active = false;
          tbombe[i].exploding = false;
        }

        timer.start();
        this.win = "";
      } else if (timer.getTime() > 2) {
        surface.setSize(900, 500); // redimensionne la fenêtre
        timer.reset(); // le timer se remet à Zéro
        game = ""; // on sort de Bomberman
        gui.showNewGame(); // renvoie au menu
      }
    }
  }
}


class BlockB {
  /** 
   * Renseigne le mode de construction des blocs.
   * Permet leur affichage 
   **/

  int x;
  int y;
  int size;
  color couleur;
  boolean cassable; // pour savoir quel type de bloc créer

  // Constructeur 
  BlockB (int x, int y, boolean cassable) {
    this.cassable = cassable;
    size = 100;
    this.x = x;
    this.y = y;

    // la couleur du bloc est donnée selon son statut : cassable ou non
    if (cassable) { 
      couleur = #FEE193;
    } else {
      couleur = #B98700;
    }
  }

  void affiche () { 
    // permet l'affichage du bloc
    fill (couleur);
    rect (x, y, size, size);
  }
}


class PorteB {
  /**
   * Renseigne la construction des portes de sorties des niveaux
   * (à rejoindre pour gagner)
   * Permet leur affichage 
   **/

  int x;
  int y;
  color couleur;
  int size;

  // Constructeur
  PorteB(int x, int y) {
    this.x = x;
    this.y = y;
  }

  void affiche () {
    image(exit, x, y, 100, 100);
  }
}


class Personnage {
  /**
   * Permet la construction et l'affichage du personnage.
   * Cette classe permet également de gérer les mouvements et les collisions. 
   **/
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
    /**
     * Cette fonction permet le déplacement du personnage.
     * Elle permet également de gérer les collisions
     **/
    int j = (this.x-20)/100; // Traduit les x en coordonnés i de la carte
    int i = (this.y-20)/100; // Traduit les y en coordonnées j de la carte


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
        //println ("win");
        mapb.win = "win"; // renvoie "gagné"
      }
      if (mapb.pattern[i][j-1] == 6) {
        //println ("Lose");
        mapb.win = "lose"; // renvoie "perdu"
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
        // println ("win");
        mapb.win = "win";
      }
      if (mapb.pattern[i][j+1] == 6) {
        // println ("Lose");
        mapb.win = "lose";
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
        // println ("win");
        mapb.win = "win";
      }
      if (mapb.pattern[i-1][j] == 6) {
        //  println ("lose");
        mapb.win = "lose";
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
        // println ("win");
        mapb.win = "win";
      }
      if (mapb.pattern[i+1][j] == 6) {
        //println ("lose");
        mapb.win = "lose";
      }
    }

    /** 
     * Permet l'affichage de la matrice dans la console
     * pour un bon contrôle du déplacement des objets dans celle-ci
     **/
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
  /**
   * Cette classe permet la création et l'affichage des Bombes.
   * Elle contient un Tick qui permet de compter le nombre de 
   * secondes où la bombe a été activée grâce au Timer et ainsi
   * définit l'enchaînement des actions (pose, explosions ...)
   * Permet également la destruction des blocs.
   **/
  int x;
  int y;
  int size1;
  int size2;
  color couleur;
  boolean active;
  Timer timer;
  boolean exploding;

  Bombe() { // Constructeur
    this.active = false;
    timer = new Timer();
  }

  Bombe(int x, int y) { // Constructeur
    this.active = false;
    this.x = x;
    this.y = y;
    timer = new Timer(); // Inclue le timer dans la bombe
    this.exploding = false;
  }  

  void affiche() {
    image(bombeimg, x-10, y-10, 85, 85);
  }

  void activate(int x, int y) {
    // ce qu'il se passe lors de l'activation de la bombe
    int i = (y-20)/100;
    int j = (x-20)/100;
    this.active = true; // La bombe est activée
    this.x = x;
    this.y = y;
    mapb.pattern[i][j] = 4; // la case la matrice prend la valeur 4 (personnage + bombe)
    timer.start(); // Démarre le timer
  }

  void tick() { 
    /**
     * Cette fonction permet de gérer le décompte du temps.
     * Elle effectue un test lors de l'explosion de la bombe pour savoir si la partie s'arrête où non
     * Elle permet ensuite la disparition des blocs qui ont explosés.
     **/
    this.timer.tick();
    int i = (y-20)/100;
    int j = (x-20)/100;
    if (timer.getTime() >= 3) {

      sonExplosion.play();
      this.active = false;

      Explosion(this.x-25, this.y-25);
      this.exploding = true;

      if (mapb.pattern [i][j] == 3 ||mapb.pattern[i+1][j] == 3 || mapb.pattern[i-1][j] ==3 || mapb.pattern[i][j+1] == 3 || mapb.pattern[i][j-1] ==3) {
        // println ("Lose");
        mapb.win = "lose";
      }
      mapb.pattern[i][j] = 6; // la case de la matrice prend la valeur 6 (en cours d'explosion)

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
    if (timer.getTime() >= 8) {
      this.exploding = false;

      sonExplosion.close();
      sonExplosion.rewind();

      for (int k=0; k < mapb.pattern.length; k++) {
        for (int l=0; l < mapb.pattern [k].length; l++) {
          if (mapb.pattern[k][l] == 6) {
            mapb.pattern[k][l] = 0;

            for (int m = 0; m < mapb.blocks.length; m++) {
              /*println(m);
               println(mapb.blocks.length);*/
              if (mapb.blocks[m].y/100 == k && mapb.blocks[m].x/100 == l) { // transforme les coordonnées du bloc en k et l 
                mapb.blocks = (BlockB[])concat((BlockB[])subset(mapb.blocks, 0, m), subset(mapb.blocks, m+1)); // permet de mettre à jour la liste de bloc dans l'intervalle [0;m[ Union [m+1, max]

                //println(mapb.blocks.length);
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
    image(croix, x-40, y-40, 200, 200);
  }
}