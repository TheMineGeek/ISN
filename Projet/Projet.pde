import processing.net.*;
int test = 0; //<>//
Map map;
void setup() {
  background(#FFFFFF);
  noLoop();
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

void settings() {
  loadPatterns();
  map = new Map(patterns.get(0)); 
  size(map.pattern[0].length*50,map.pattern.length*50);
}


void draw() { //<>//
}

void clientEvent() {  
}

void keyPressed() { // Ce qu'il se passe quand une touche est pressée
  int x = 0;
  int y = 0;
  if (keyCode == 37) { // Flèche gauche //<>//
    map.move("left"); // Fonction que tu peux retrouver dans la classe map //<>//
  } else if (keyCode == 38) { // Flèche haut
    map.move("top");
  } else if (keyCode == 39) { // Flèche droite
    map.move("right");
  } else if (keyCode == 40) { // Flechè bas
    map.move("bottom");
  }
}