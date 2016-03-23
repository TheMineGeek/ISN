import processing.net.*; //<>// //<>// //<>// //<>//
//
/* GLOBAL VARS DECLARATIONS */
Map map; 
Personnage personnage;
Bombe bombe;
Bombe[] tbombe; // Création d'un tableau de bombes
BlockB blockb;


static Projet that;

/* SETUP FONCTIONS */

/**
 * Initialize map
 */


/**
 * Initialize multiplayer
 */


/**
 * Global setup
 */
void setup() {
  background(#FFFFFF);
  personnage = new Personnage();
  tbombe = new Bombe[20];
  for(int i = 0; i < 20; i++) {
   tbombe[i] = new Bombe();
  }
  blockb = new BlockB();
}

/**
 * Specific setup
 */

void settings() {  
  size (750, 750);
}


void draw() {
  background(#FFFFFF);
  personnage.affiche();
  for (int i=0; i<20; i++) {
    tbombe[i].tick();
    if (tbombe[i].active) {
      tbombe[i].affiche();
    }
    blockb.affiche();
  }

  //GUI.buttonHoverInteractions(mouseX, mouseY);
}

void keyPressed() { // Ce qu'il se passe quand une touche est pressée
  if (keyCode == 37) { // Flèche gauche
    personnage.move("left"); // Fonction que tu peux retrouver dans la classe map
  } else if (keyCode == 38) { // Flèche haut
    personnage.move("top");
  } else if (keyCode == 39) { // Flèche droite
    personnage.move("right");
  } else if (keyCode == 40) { // Flechè bas
    personnage.move("bottom");
  } else if (keyCode == 32) { // Barre d'espace pour poser une bombe
    int i = 0;
    while(tbombe[i].active) {
      i++;
    }
    tbombe[i].activate(personnage.x, personnage.y);
  }
}