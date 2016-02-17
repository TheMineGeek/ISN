import processing.net.*; //<>// //<>// //<>// //<>//

/* GLOBAL VARS DECLARATIONS */
Map map;
static Projet that;

/* SETUP FONCTIONS */

/**
 * Initialize map
 */
void mapSetup() {  
  map.init();
  map.onWin = new onWinInterface() {
    @Override
      public void toDo() {
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
  mapSetup();
}

/**
 * Specific setup
 */
void settings() {  
  that = this;
  multiplayerSetup("ws://localhost:8001/isn");
  
  map = new Map(patternsSetup());
  size(map.pattern[0].length*50,map.pattern.length*50);
}


void draw() {
}

void keyPressed() { // Ce qu'il se passe quand une touche est pressée
  int x = 0;
  int y = 0;
  if (keyCode == 37) { // Flèche gauche
    map.move("left"); // Fonction que tu peux retrouver dans la classe map //<>//
  } else if (keyCode == 38) { // Flèche haut
    map.move("top");
  } else if (keyCode == 39) { // Flèche droite
    map.move("right");
  } else if (keyCode == 40) { // Flechè bas
    map.move("bottom");
  }
}