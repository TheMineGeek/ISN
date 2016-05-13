class Timer {
  /* Permet de compter le temps qui passe */
  float time;
<<<<<<< 431bbc972e620c92ec513a70a7a0038367df99cd
  boolean activated;

  Timer() {
    this.activated = false;
    this.time = 0;
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
=======
  
  Timer() {
  }
  
  void tick() {
    time += 1/frameRate;
  }
  
  float getTime() {
    return this.time; 
>>>>>>> Time done
  }
}