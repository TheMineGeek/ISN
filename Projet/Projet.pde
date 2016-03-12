import processing.net.*; //<>// //<>// //<>//

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
  frameRate(60);
  gui.showMultiplayer();
}

/**
 * Specific setup
 */
void settings() {  
  size(340, 250);  
  gui = new GUI();
}


void draw() {
  gui.hover(mouseX, mouseY);
  gui.tick();
}

void keyPressed() { // Ce qu'il se passe quand une touche est pressée
  if (key == 27) { // Empeche le programme de se fermer lorsque l'on appuie sur ECHAP
    key = 0;
    gui.keyboard('!', ESC);
  } else {
    gui.keyboard(key, keyCode);
  }
}

void mousePressed() {
  gui.click(mouseX, mouseY);
}