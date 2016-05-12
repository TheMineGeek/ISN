import processing.net.*; //<>//
import ddf.minim.*;

/* GLOBAL VARS DECLARATIONS */

/* ESCAPOLOGIE */
Map map;
static Projet that;
GUI gui;
String game = "";
String USERNAME;
Pattern[] escapologiePatterns;
Pattern[] bombermanPatterns;

/* BOMBERMAN */
MapB mapb; 
PorteB porte;
Personnage personnage;
Bombe bombe;
Bombe[] tbombe; // Création d'un tableau de bombes

Minim minim;
AudioPlayer sonExplosion;

PImage croix;
PImage bombeimg;
PImage perso;
PImage exit;

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
  tbombe = new Bombe[20];
  
  
  loadEscapologie();
  bombermanSetup();  
  /* METTRE EN PLACE LE CHANGEMENT DE TAILLE DE FENETRE LORS DU CHANGEMENT VERS BOMBERMAN (750 * 750) */
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
    background(#FFFFFF);
    mapb.tick(); /* La carte se dessine ainsi que les changements qui apparaissent sur la matrice */

    for (int i=0; i<20; i++) {
      // affiche les bombes activées.
      tbombe[i].tick();
      if (tbombe[i].active) {
        tbombe[i].affiche();
      }
    }
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
}