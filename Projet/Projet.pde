import processing.net.*; //<>// //<>//
//
/* GLOBAL VARS DECLARATIONS */
Map map; 
Personnage personnage;
Bombe bombe;
int [] tbombe; // Création d'un tableau de bombes

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
  
  int i; 
  tbombe = new int [20];
  for (i=0, i<20, i++) {
    tbombe [i] = 0; // Toutes les bombes sont inactives
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
  bombe.affiche();

  //GUI.buttonHoverInteractions(mouseX, mouseY);
}

void keyPressed() { // Ce qu'il se passe quand une touche est pressée
  println(keyCode);
  if (keyCode == 37) { // Flèche gauche
    personnage.move("left"); // Fonction que tu peux retrouver dans la classe map
  } else if (keyCode == 38) { // Flèche haut
    personnage.move("top");
  } else if (keyCode == 39) { // Flèche droite
    personnage.move("right");
  } else if (keyCode == 40) { // Flechè bas
    personnage.move("bottom");
  } else if (keyCode == 32) { // Barre d'espace pour poser une bombe
    Bombe bombe = new Bombe(personnage.x, personnage.y);
   for (i= 0, i < 20, i++) {
    tbombe[i] = 1;
   }
  }
}

void mousePressed() {
  //GUI.buttonClickInteractions(mouseX, mouseY);
}