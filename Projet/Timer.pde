class Timer {
  /* Permet de compter le temps qui passe */
  float time;
  boolean activated;

  Timer() {
    this.activated = false;
  }

  void tick() {
    if (this.activated) {
      time += 1/frameRate;
    }
  }

  float getTime() {
    return this.time;
  }

  void start() {
    this.activated = true;
  }

  void stop() {
    this.activated =  false;
  }

  void reset() {
    this.activated =  false;
    this.time = 0;
  }
}
    