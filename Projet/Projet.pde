import processing.net.*; //<>// //<>// //<>// //<>// //<>// //<>//
import ddf.minim.*;
//
/* Déclaration des variables globales */
MapB mapb; 
PorteB porte;
Personnage personnage;
Bombe bombe;
Bombe[] tbombe; // Création d'un tableau de bombes

Minim minim;
AudioPlayer sonexplosion;

PImage croix;
PImage bombeimg;
PImage perso;
PImage exit;

static Projet that;


/**
 * Global setup
 */
void setup() {
  /*Il s'agit de l'initialisation du programme 
   et des différentes tâches à réaliser pour lancer le projet */
  background(#FFFFFF); // définir un fond d'écran
  // On attribu aux variables une classe
  personnage = new Personnage();
  tbombe = new Bombe[20];
  for (int i = 0; i < 20; i++) { //on remplit le tableau de bombes
    tbombe[i] = new Bombe();
  }
  mapb = new MapB();
  mapb.init();
  croix = loadImage("./data/img/Croix.png");
  bombeimg = loadImage("./data/img/Bombes.png");
  perso = loadImage("./data/img/Perso.png");
  exit = loadImage("./data/img/Exit.png");
  
  minim = new Minim(this);
  sonexplosion = minim.loadFile("./data/Sonexplosion.mp3");
}

/**
 * Specific setup
 */

void settings() {   // définit la taille de la fenêtre de jeux
  size (750, 750);
}


void draw() {
  /* Cette fonction permet de dessiner les objets.
   Elle revient très régulièrement (tous les dixièmes de seconde par exemple) */
   
  background(#FFFFFF);
  mapb.tick(); // la carte se dessine ainsi que les changements qui apparaissent sur la matrice

  for (int i=0; i<20; i++) {
    // affiche les bombes activées.
    tbombe[i].tick();
    if (tbombe[i].active) {
      tbombe[i].affiche();
    }
  }
}


void keyPressed() { // Ce qu'il se passe quand une touche est pressée
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