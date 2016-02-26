import processing.net.*; //<>// //<>//

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
  //mapSetup();
  background(#FFFFFF);
  GUI.addButton(new GUIButton(20, 20, 300, 40, "Mon premier boutton", 15, color(#000000), color(#444444), color(#444444), color(#AAAAAA), color(#DDDDDD), color(#FFFFFF), new IGUIButton() {
    public void onClick() {
      println("test");
    }
  }
  ));
}

/**
 * Specific setup
 */
void settings() {  
  size(750, 750);
  that = this;
  //multiplayerSetup("ws://localhost:8001/isn");

  /*map = new Map(patternsSetup());
   size(map.pattern[0].length*50, map.pattern.length*50);*/
}


void draw() {
  GUI.buttonHoverInteractions(mouseX, mouseY);
}

void keyPressed() { // Ce qu'il se passe quand une touche est pressée
  if (!map.win) {
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

void mousePressed() {
  GUI.buttonClickInteractions(mouseX, mouseY);
}