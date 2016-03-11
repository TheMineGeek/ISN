import processing.net.*; //<>// //<>//
//
/* GLOBAL VARS DECLARATIONS */
Map map; 
Personnage personnage;
static Projet that;

/* SETUP FONCTIONS */

/**
 * Initialize map
 */


/**
 * Initialize multiplayer
 */
void multiplayerSetup(String url) {
  Multiplayer.connect(url);
  Multiplayer.send("test 2");
}

/**
 * Global setup
 */
void setup() {
  background(#FFFFFF);
  personnage = new Personnage();
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

  }
}

void mousePressed() {
  //GUI.buttonClickInteractions(mouseX, mouseY);
}