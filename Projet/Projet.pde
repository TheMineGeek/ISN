import processing.net.*;
Client client; // Ca c'est pour le multi, on verra plus tard :D (Mais si tu es quand même pressée, on va sûrement utiliser ça : https://processing.org/reference/libraries/net/index.html)

void setup() {
  size(map.pattern.length, map.pattern[0].length);
  background(#FFFFFF);
  map.init(); // Fonction pour créer la map
  //client = new Client(this, "127.0.0.1", 5204); Bon bah encore le multi
}

Map map = new Map(); // Initialisation de la classe
void draw() {
  
}

void clientEvent(Client _client) {  
  print(_client.readString()); // Encore et toujours le même
}

void keyPressed() { // Ce qu'il se passe quand une touche est pressée
  println(keyCode);
  int x = 0;
  int y = 0;
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