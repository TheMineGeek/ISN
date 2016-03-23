
class BlockB {
  
 int x;
 int y;
 int size;
 color couleur;
 
 // Constructeur 
 BlockB () {
   size = 50;
   couleur = #AE00DD;
   x = 300;
   y = 300;
 }
 
 void affiche () {
   fill (couleur);
   rect (x, y, size, size);
 }




}



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
  int size1;
  int size2;
  color couleur;
  boolean active;
  Timer timer;

  Bombe() {
    this.active = false;
    size1 = 25;
    size2 = 12;
    couleur = color(192, 192, 192);
    timer = new Timer();
  }

  // constructeur
  Bombe(int x, int y) {
    this.active = false;
    size1 = 25;
    size2 = 12;
    this.x = x;
    this.y = y;
    timer = new Timer(); // Inclue le timer dans la bombe
    couleur = color(192, 192, 192);
  }  

  void tick() {  
    this.timer.tick();
   if (timer.getTime() >= 7) {
      this.active = false;
      timer.stop();
      timer.reset();
    }
  }

  void affiche() {
    fill (this.couleur);
    rect (this.x, this.y, this.size1, this.size2);
  }

  void activate(int x, int y) {
    this.active = true; // la bombe est activée
    this.x = x;
    this.y = y;
    timer.start(); // démare le timer
  }
}

class Explosion {


}