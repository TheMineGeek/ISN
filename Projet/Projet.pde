import processing.net.*;  //<>// //<>// //<>//
import ddf.minim.*;

/* GLOBAL VARS DECLARATIONS */
String game = "";
GUI gui;
String USERNAME;

/* ESCAPOLOGIE */
Map map;
Pattern[] escapologiePatterns;

/* BOMBERMAN */
MapB mapb; 
PorteB porte;
Personnage personnage;
Bombe bombe;
Bombe[] tbombe; // Création d'un tableau de bombes

Minim minim;
AudioPlayer sonExplosion;
AudioPlayer sonAmbiance;

PImage croix;
PImage bombeimg;
PImage perso;
PImage exit;

Pattern[] bombermanPatterns;

/* SCREENSHOT */
Screenshot screenshot;

/* SETUP FONCTIONS */

/**
 * Initialize map
 */
void mapSetup(int mapNumber) {
  game = "escapologie";
  map.setPattern(mapNumber);
  map.init();
  map.onWin = new onWinInterface() {
    public void toDo() { // Ce qu'il faut faire quand on gagne la partie
      game = "";
      Multiplayer.Escapologie.sendStats(USERNAME, map.timer.getTime(), map.mapID);

      textAlign(CENTER);
      fill(0);
      textSize(30);
      text("Bravo ! Vous avez gagné", pixelWidth/2, pixelHeight/2);

      saveEscapologie(encrypt(patternsToJson()));

      gui.showNewGame();
    }
  };
}

void bombermanSetup() { 
  /*Il s'agit de l'initialisation du programme 
   et des différentes tâches à réaliser pour lancer le projet */
  // On attribu aux variables une classe
  for (int i = 0; i < 20; i++) { //on remplit le tableau de bombes
    tbombe[i] = new Bombe();
  }
  croix = loadImage("./data/img/Croix.png");
  bombeimg = loadImage("./data/img/Bombes.png");
  perso = loadImage("./data/img/Perso.png");
  exit = loadImage("./data/img/Exit.png");

  
  sonExplosion = minim.loadFile("./data/Sonexplosion.mp3");
  sonAmbiance = minim.loadFile("./data/acidjazz.mp3");
}


/**
 * Global setup
 */
void setup() {
  background(#FFFFFF);
  frameRate(60);
  if (!existingUsername()) {
    gui.askForUsernameMenu();
  } else {
    gui.showMenu();
  }
  
  /*game = "bomberman";
  surface.setSize(701,801);
  mapb.init();*/
}


/**
 * Specific setup
 */
void settings() { 
  size(900, 500);  
  gui = new GUI();
  map = new Map();  
  personnage = new Personnage();
  mapb = new MapB();
  minim = new Minim(this);
  screenshot = new Screenshot();
  tbombe = new Bombe[20];
  
  
  loadEscapologie();
  bombermanSetup();  
}


void draw() {
  if (game == "") {
    gui.hover(mouseX, mouseY);
    gui.tick();
  } else if (game == "escapologie") {
    map.tick();
  } else if (game == "bomberman") {
    /* Cette fonction permet de dessiner les objets.
     Elle revient très régulièrement (tous les dixièmes de seconde par exemple) */
    mapb.tick(); /* La carte se dessine ainsi que les changements qui apparaissent sur la matrice */
  }
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

  if (game == "escapologie") {
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

  if (game == "bomberman") {
    if (keyCode == 37) { // Flèche gauche
      personnage.move("left"); // Fonction que l'on retrouve dans la classe map
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
  
  if(keyCode == 120) {
    String path = sketchPath() + "\\screenshots\\" + (day() < 10 ? "0" + day() : day()) + "_" + (month() < 10 ? "0" + month() : month()) + "_" + year() + "_" + hour() + "_" + minute();
    screenshot.take(path);
  }
}