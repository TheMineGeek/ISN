class Simon {
  Simon() {
    this.init();
  }
  
  void init() {
    noStroke();
    fill(#0000FF);
    arc(500, 200, 200, 200, 0, HALF_PI);
    fill(#FFFF00);
    arc(500, 200, 200, 200, HALF_PI, PI);
    fill(#00FF00);
    arc(500, 200, 200, 200, PI, PI+HALF_PI);
    fill(#FF0000);
    arc(500, 200, 200, 200, HALF_PI+PI, 2*PI);
  }
}