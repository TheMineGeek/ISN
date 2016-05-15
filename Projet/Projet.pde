import processing.net.*;  //<>// //<>// //<>// //<>//
import ddf.minim.*; // on importe la bibliothèque minim pour le son

/* GLOBAL VARS DECLARATIONS */
String game = ""; // nom du jeu
GUI gui; // Graphical user interface
String USERNAME; // demande le nom d'utilisateur

/* ESCAPOLOGIE */
Map map; // initialisation des map 
Pattern[] escapologiePatterns; // initialisation du tableau de map

/* BOMBERMAN */
// on initialise les variables utiles au jeu
MapB mapb; 
PorteB porte;
Personnage personnage;
Bombe bombe;
Bombe[] tbombe; // Création d'un tableau de bombes

// initialisation des sons
Minim minim;
AudioPlayer sonExplosion;
AudioPlayer sonAmbiance;

//initialisation des images
PImage croix; // explosion
PImage bombeimg; // image de la bombe
PImage perso; // le personnage
PImage exit; // la sortie

Pattern[] bombermanPatterns; // les cartes de bomberman

/* SCREENSHOT */
Screenshot screenshot;

/* SETUP FONCTIONS */

/**
 * Initialise Escapologie
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

      saveEscapologie(encrypt(patternsToJson())); // permet la sauvegarde des données

      gui.showNewGame(); // renvois au menu
    }
  };
}

void bombermanSetup() { 
  /*Il s'agit de l'initialisation du programme 
   et des différentes tâches à réaliser pour lancer le projet */

  for (int i = 0; i < 20; i++) { //on remplit le tableau de bombes
    tbombe[i] = new Bombe();
  }

  // Les images sont chargées à partir du dossier indiqué
  croix = loadImage("./data/img/Croix.png");
  bombeimg = loadImage("./data/img/Bombes.png");
  perso = loadImage("./data/img/Perso.png");
  exit = loadImage("./data/img/Exit.png");

  // les sons sont chargés
  sonExplosion = minim.loadFile("./data/Sonexplosion.mp3");
  sonAmbiance = minim.loadFile("./data/acidjazz.mp3");
}


/**
 * Global setup
 */
void setup() {

  background(#FFFFFF);
  frameRate(60);

  /* cette boucle vérifie la présence d'un nom d'utilisateur
   S'il est inexistant, il faudra en entrer un
   -- Prévision pour le multijoueur */

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
  // crée les nouvelles variables nécessaires aux mini-jeux
  size(900, 500);  // taille de la fenêtre
  gui = new GUI();
  map = new Map();  
  personnage = new Personnage();
  mapb = new MapB();
  minim = new Minim(this);
  screenshot = new Screenshot();
  tbombe = new Bombe[20];

  // chargement des mini-jeux
  loadEscapologie();
  bombermanSetup();
}


void draw() {
  /* Cette fonction permet de dessiner les objets.
   Elle revient très régulièrement (tous les dixièmes de seconde par exemple) */

  if (game == "") { // actions si l'on navigue dans les menus
    gui.hover(mouseX, mouseY);
    gui.tick();
  } else if (game == "escapologie") {
    map.tick(); // action si l'on est dans Escapologie
  } else if (game == "bomberman") { // action si l'on est dans Bomberman
    mapb.tick(); /* La carte se dessine ainsi que les changements qui apparaissent sur la matrice */
  }
}

void mousePressed() { // action lors d'un clique de souris, se reporter au GUI
  gui.click(mouseX, mouseY);
}

void keyPressed() { // Ce qu'il se passe quand une touche est pressée
  // gui.Keyboard envoit les touches du clavier pressées au gui
  if (key == 27) { // Empèche le programme de se fermer lorsque l'on appuie sur ECHAP
    key = 0;
    gui.keyboard('!', ESC);
  } else {
    gui.keyboard(key, keyCode);
  }

  // les actions engendrées par le clavier dans Escapologie
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
  // les actions engendrées par le clavier dans Bomberman
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
      // la bombe activée prends les coordonées du personnage
    }
  }

  if (keyCode == 120) { // F9 pour prendre une capture d'écran. 
    String path = sketchPath() + "\\screenshots\\" + (day() < 10 ? "0" + day() : day()) + "_" + (month() < 10 ? "0" + month() : month()) + "_" + year() + "_" + hour() + "_" + minute();
    screenshot.take(path);
    // la capture d'écran sera stockée dans le dossier Screenshots
  }
}