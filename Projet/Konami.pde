import processing.net.*;

class Konami {
  Client c;

  boolean DA_SECRET_REAVELD = false;

  int count = 0;
  int[] keyCodeList = new int[]{38, 38, 40, 40, 37, 39, 37, 39, 66, 65}; // HAUT HAUT BAS BAS GAUCHE DROITE GAUCHE DROITE B A

  void onKeyboardEvent(int keyPressedCode) {
    if (keyPressedCode == keyCodeList[count]) {
      this.count++;

      if (this.count == keyCodeList.length) {
        this.REVEAL_DA_SECRET();
        this.count = 0;
      }
    } else this.count = 0;
  }

  void REVEAL_DA_SECRET() {
    println("gg");
    this.c = new Client(that2, "towel.blinkenlights.nl", 23);
    c.write("GET / HTTP/1.0\n");
    this.DA_SECRET_REAVELD = true;
    game = "konami";
    surface.setLocation(-3,-20);
    surface.setSize(displayWidth, displayHeight);
  }

  void tick() {
    if (this.DA_SECRET_REAVELD) {
      if (this.c.available() > 0) {    // If there's incoming data from the client...
        String _text = c.readString();
        println(_text);
        background(0);
        
        fill(255);
        textSize(48);
        textAlign(LEFT);
        textFont(Monospaced);
        text(_text, -150, -20);
      }
    }
  }
}