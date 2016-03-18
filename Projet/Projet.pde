import processing.net.*; //<>// //<>//

/* GLOBAL VARS DECLARATIONS */
Map map;
Screenshot screenshot;
static Projet that;
GUI gui;
Simon simon;
/* SETUP FONCTIONS */

/**
 * Initialize map
 */
void mapSetup() {  
  map.flushBlocks();
  map.flushGates();
  map.setPattern(1);
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
  simon = new Simon();
}

/**
 * Specific setup
 */
void settings() { 
  size(800, 500);
}


void draw() {
}

void mousePressed() {
}

void keyPressed() { // Ce qu'il se passe quand une touche est pressée
  
}