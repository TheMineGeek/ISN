import processing.net.*; //<>// //<>//
import ddf.minim.*;

/* GLOBAL VARS DECLARATIONS */
Map map;
Screenshot screenshot;
static Projet that;
GUI gui;
Simon simon;
Minim minim;
AudioPlayer audioDo;
/* SETUP FONCTIONS */

/**
 * Global setup
 */
void setup() {
  background(#FFFFFF);
  frameRate(60);
  simon = new Simon(width/2, height/2-50, 300);

  minim = new Minim(this); 
}

/**
 * Specific setup
 */
void settings() { 
  size(800, 500);
}


void draw() {
  simon.mouseHoverInteractions(mouseX, mouseY);
  simon.tick();
}

void mousePressed() {
}

void keyPressed() { // Ce qu'il se passe quand une touche est pressée
}