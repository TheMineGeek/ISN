import processing.net.*; 

/* GLOBAL VARS DECLARATIONS */
Map map;
Screenshot screenshot;
static Projet that;
Projet that2;
GUI gui;
String game = "";
Konami konami;
PFont Monospaced;

/* SETUP FONCTIONS */

/**
 * Initialize map
 */
void mapSetup(int mapNumber) {  
  game = "escapologie";
  map.flushBlocks();
  map.flushGates();
  map.setPattern(mapNumber);
  map.init();
  map.onWin = new onWinInterface() {
    @Override
      public void toDo() { // Ce qu'il faut faire quand on gagne la partie
      map.win = true;
      Multiplayer.Escapologie.sendStats("Theo", map.timer.getTime(), map.mapID);
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
  that2 = this;
  Monospaced = loadFont("./data/fonts/Monospaced.plain-48.vlw");
  konami = new Konami();
}


/**
 * Specific setup
 */
void settings() { 
  size(900, 500);  
  gui = new GUI();
  map = new Map();
}


void draw() {
  //if(c.available() > 0) println(c.readString());
  if (game == "") {
    gui.hover(mouseX, mouseY);
    gui.tick();
  } else if (game == "escapologie") {
    map.tick();
  } else if (game == "konami") {   
    konami.tick();
  }
}

void mousePressed() {
  gui.click(mouseX, mouseY);
}

void keyPressed() { // Ce qu'il se passe quand une touche est pressée
  if(game == "") konami.onKeyboardEvent(keyCode);
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