class Timer {
  /* Permet de compter le temps qui passe */
  float time;
  boolean activated;

  Timer() { // constructeur du Timer
    this.activated = false;
    this.time = 0;
  }

  void tick() { 
    // ce qu'il se passe lorsque le Timer est activé
    if (this.activated) {
      time += 1/frameRate; // Calcul du nombre de secondes grâce au frameRate
    }
  }

  float getTime() {
    return this.time;
  }

  void start() {
    this.activated = true; // le timer est activé
  }

  void stop() {
    this.activated =  false; // le timer s'arrête
  }

  void reset() {
    this.activated =  false; // le timer retourne à zéro
    this.time = 0;
  }
}