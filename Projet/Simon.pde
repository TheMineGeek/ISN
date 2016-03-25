import ddf.minim.*;

/* General var for Simon */
public enum Colors {
  GREEN ("green"), 
    RED ("red"), 
    BLUE ("blue"), 
    YELLOW ("yellow");

  private String name = "";

  Colors(String name) {
    this.name = name;
  }

  String toString() {
    return this.name;
  }

  static Colors getRandom() {
    return values()[(int) (Math.random() * values().length)];
  }
}

class Simon {
  int x;
  int y;
  int diametre;
  Colors[] colors; // 0 pour vert, 1 pour rouge, 2 pour bleu, 3 pour jaune
  AudioPlayer audioPlayer;
  Timer timer;
  int I;

  boolean mustPlay; // True pour au tour du joueur, false pour diffusion de la séquence

  Simon(int x, int y, int diametre) {
    this.x = x;
    this.y = y;
    this.diametre = diametre;
    this.init();
    this.timer = new Timer();
    this.colors = new Colors[0];
    this.mustPlay = true;
  }

  void init() {
    desactivateAll();
  }

  void mouseHoverInteractions(int x, int y) {
    if (mustPlay) {
      this.desactivateAll();
      if (sq(x-this.x)+sq(y-this.y) < sq(this.diametre/2)) {
        if (x < this.x) {
          if (y < this.y) {
            fill(#03C03C);
            arc(this.x, this.y, this.diametre, this.diametre, PI, PI+HALF_PI, PIE);
          } else {
            fill(#FFF44F);
            arc(this.x, this.y, this.diametre, this.diametre, HALF_PI, PI, PIE);
          }
        } else {
          if (y < this.y) {
            fill(#C23B22);
            arc(this.x, this.y, this.diametre, this.diametre, HALF_PI+PI, 2*PI, PIE);
          } else {
            fill(#779ECB);
            arc(this.x, this.y, this.diametre, this.diametre, 0, HALF_PI, PIE);
          }
        }
      }
    }
  }
  
  void mouseClickInteraction() {
    
  }
  
  void keyboardInteractions() {
    
  }

  void desactivateAll() {
    fill(#AEC6CF);
    arc(this.x, this.y, this.diametre, this.diametre, 0, HALF_PI, PIE);
    fill(#FDFD96);
    arc(this.x, this.y, this.diametre, this.diametre, HALF_PI, PI, PIE);
    fill(#77DD77);
    arc(this.x, this.y, this.diametre, this.diametre, PI, PI+HALF_PI, PIE);
    fill(#FF6961);
    arc(this.x, this.y, this.diametre, this.diametre, HALF_PI+PI, 2*PI, PIE);
  }

  void light(String wantedColor) {
    println(wantedColor);
    if (wantedColor == "blue") {
      fill(#779ECB);
      arc(this.x, this.y, this.diametre, this.diametre, 0, HALF_PI, PIE);
    } else if (wantedColor == "yellow") {
      fill(#FFF44F);
      arc(this.x, this.y, this.diametre, this.diametre, HALF_PI, PI, PIE);
    } else if (wantedColor == "green") {
      fill(#03C03C);
      arc(this.x, this.y, this.diametre, this.diametre, PI, PI+HALF_PI, PIE);
    } else if (wantedColor == "red") {
      fill(#C23B22);
      arc(this.x, this.y, this.diametre, this.diametre, HALF_PI+PI, 2*PI, PIE);
    }
  }

  void addColor() {
    this.colors = (Colors[])append(this.colors, Colors.getRandom());
  }

  void playSequence() {
    switch(this.colors[I]) {
    case GREEN:
      this.audioPlayer = minim.loadFile("./data/sounds/do.wav");
      this.light(Colors.GREEN.toString());
      break;
    case RED:
      this.audioPlayer = minim.loadFile("./data/sounds/re.wav");
      this.light(Colors.RED.toString());
      break;
    case BLUE:
      this.audioPlayer = minim.loadFile("./data/sounds/mi.wav");
      this.light(Colors.BLUE.toString());
      break;
    case YELLOW:
      this.audioPlayer = minim.loadFile("./data/sounds/fa.wav");
      this.light(Colors.YELLOW.toString());
      break;
    }

    this.audioPlayer.play();
  }

  void tick() {
    this.timer.tick();
    if (!mustPlay) {
      if (timer.getTime() == 0) {
        timer.start();
      } else if (timer.getTime() >= 1) {
        timer.reset();
        this.desactivateAll();
        this.playSequence();
        I++;
        if (I == colors.length) {
          mustPlay = true;
          I = 0;
        }
      }
    } else {
      if (timer.getTime() == 0) {
        timer.start();
      } else if (timer.getTime() >= 5) {
        println("perdu");
      }
    }
  }
}