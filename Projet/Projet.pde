import processing.net.*;  //<>// //<>//
 //<>//
/* GLOBAL VARS DECLARATIONS */
Map map;
static Projet that;
GUI gui;
/* SETUP FONCTIONS */

/**
 * Initialize map
 */
void mapSetup() {  
  map.init();
  map.onWin = new onWinInterface() {
    @Override
      public void toDo() { // Ce qu'il faut faire quand on gagne la partie
      map.win = true;
      textAlign(CENTER);
      fill(0);
      textSize(30);
      text("Bravo ! Vous avez gagné", pixelWidth/2, pixelHeight/2);
    }
  };
}

/**
 * Global setup
 */
void setup() {
  background(#FFFFFF);
  frameRate(60);
  gui.showMenu();
}

/**
 * Specific setup
 */
void settings() {  
  size(400, 600);  
  gui = new GUI();
}


void draw() {
    gui.hover(mouseX, mouseY);
  gui.tick();
    map.tick();
}

void mousePressed() {
  gui.click(mouseX, mouseY);
}

void keyPressed() { // Ce qu'il se passe quand une touche est pressée
  if (key == 27) { // Empeche le programme de se fermer lorsque l'on appuie sur ECHAP
    key = 0;
    gui.keyboard('!', ESC);
  } else {
    gui.keyboard(key, keyCode);
  }
  
  if (!map.win && map.keyboardEvents) {
    if (keyCode == 37) { // Flèche gauche
      map.move("left"); // Fonction que tu peux retrouver dans la classe map
    } else if (keyCode == 38) { // Flèche haut
      map.move("top");
    } else if (keyCode == 39) { // Flèche droite
      map.move("right");
    } else if (keyCode == 40) { // Flechè bas
      map.move("bottom");
    }
  }
}