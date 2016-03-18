class Simon {
  int x;
  int y;
  int diametre;

  Simon(int x, int y, int diametre) {
    this.x = x;
    this.y = y;
    this.diametre = diametre;
    this.init();
  }

  void init() {
    fill(#0000FF);
    arc(this.x, this.y, this.diametre, this.diametre, 0, HALF_PI, PIE);
    fill(#FFFF00);
    arc(this.x, this.y, this.diametre, this.diametre, HALF_PI, PI, PIE);
    fill(#00FF00);
    arc(this.x, this.y, this.diametre, this.diametre, PI, PI+HALF_PI, PIE);
    fill(#FF0000);
    arc(this.x, this.y, this.diametre, this.diametre, HALF_PI+PI, 2*PI, PIE);
  }

  void mouseHoverInteractions(int x, int y) {
    if (sq(x-this.x)+sq(y-this.y) < sq(this.diametre/2)) {
      if (x < this.x) {
        if (y < this.y) {
          fill(#00DD00);
          arc(this.x, this.y, this.diametre, this.diametre, PI, PI+HALF_PI, PIE);
          fill(#FFFF00);
          arc(this.x, this.y, this.diametre, this.diametre, HALF_PI, PI, PIE);
        } else {
          fill(#DDDD00);
          arc(this.x, this.y, this.diametre, this.diametre, HALF_PI, PI, PIE);
          fill(#00FF00);
          arc(this.x, this.y, this.diametre, this.diametre, PI, PI+HALF_PI, PIE);
        }
        fill(#0000FF);
        arc(this.x, this.y, this.diametre, this.diametre, 0, HALF_PI, PIE);
        fill(#FF0000);
        arc(this.x, this.y, this.diametre, this.diametre, HALF_PI+PI, 2*PI, PIE);
      } else {
        if (y < this.y) {
          fill(#0000FF);
          arc(this.x, this.y, this.diametre, this.diametre, 0, HALF_PI, PIE);
          fill(#DD0000);
          arc(this.x, this.y, this.diametre, this.diametre, HALF_PI+PI, 2*PI, PIE);
        } else {
          fill(#0000DD);
          arc(this.x, this.y, this.diametre, this.diametre, 0, HALF_PI, PIE);
          fill(#FF0000);
          arc(this.x, this.y, this.diametre, this.diametre, HALF_PI+PI, 2*PI, PIE);
        }
        fill(#FFFF00);
        arc(this.x, this.y, this.diametre, this.diametre, HALF_PI, PI, PIE);
        fill(#00FF00);
        arc(this.x, this.y, this.diametre, this.diametre, PI, PI+HALF_PI, PIE);
      }
    }
  }
}