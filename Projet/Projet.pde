import processing.net.*; //<>// //<>// //<>// //<>// //<>// //<>//
//
/* GLOBAL VARS DECLARATIONS */
MapB mapb; 
PorteB porte;
Personnage personnage;
Bombe bombe;
Bombe[] tbombe; // Création d'un tableau de bombes


PImage croix;
PImage bombeimg;
PImage perso;
PImage exit;

static Projet that;


/**
 * Global setup
 */
void setup() {
  background(#FFFFFF);
  personnage = new Personnage();
  tbombe = new Bombe[20];
  for (int i = 0; i < 20; i++) {
    tbombe[i] = new Bombe();
  }
  mapb = new MapB();
  mapb.init();
  croix = loadImage("./data/img/Croix.png");
  bombeimg = loadImage("./data/img/Bombes.png");
  perso = loadImage("./data/img/Perso.png");
  exit = loadImage("./data/img/Exit.png");
}

/**
 * Specific setup
 */

void settings() {  
  size (750, 750);
}


void draw() {
  background(#FFFFFF);
  
      mapb.tick(); // la carte se dessine jusqu'a ce que l'on gagne ou perde
    
  for (int i=0; i<20; i++) {
    tbombe[i].tick();
    if (tbombe[i].active) {
      tbombe[i].affiche();
    }
  }
}


void keyPressed() { // Ce qu'il se passe quand une touche est pressée
  if (keyCode == 37) { // Flèche gauche
    personnage.move("left"); // Fonction que tu peux retrouver dans la classe map
  } else if (keyCode == 38) { // Flèche haut
    personnage.move("top");
  } else if (keyCode == 39) { // Flèche droite
    personnage.move("right");
  } else if (keyCode == 40) { // Flèche bas
    personnage.move("bottom");
  } else if (keyCode == 32) { // Barre d'espace pour poser une bombe
    int i = 0;
    while ((tbombe[i].active || tbombe[i].exploding) && i < 19) {
      i++;
    }
    tbombe[i].activate(personnage.x, personnage.y);
  }
}