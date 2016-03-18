class Timer {
  float time;
  
  Timer() {
  }
  
  void tick() {
    time += 1/frameRate;
  }
  
  float getTime() {
    return this.time; 
  }
}