

class Personnage {
  int x;
  int y;
  int size;
  color couleur;

  // constructeur
  Personnage() {
    size = 50;
    couleur = #000000;
    x = 50;
    y = 50;
  }


  void affiche () {
    fill (couleur);
    rect (x, y, size, size);
  }

  void move (String direction) {
    if (direction == "left") {
      this.x = x-4;
    } else if (direction == "right") {
      this.x = x+4;
    } else if (direction == "top") {
      this.y = y-4;
    } else if (direction == "bottom") {
      this.y = y+4;
    }
  }
}

  class Bombe {
    int x;
    int y;
    int size;
    color couleur;

    // constructeur
    Bombe() {
    }
  }