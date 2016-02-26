static class GUI {
  static GUIButton[] GUIButtons = new GUIButton[0];

  static void addButton(GUIButton button) {
    GUIButtons = (GUIButton[])append(GUIButtons, button);
    button.init();
  }

  static void buttonHoverInteractions(int x, int y) {
    for (int i = 0; i < GUIButtons.length; i++) {
      if (x <= GUIButtons[i].maxX && x >= GUIButtons[i].x && y <= GUIButtons[i].maxY && y >= GUIButtons[i].y) {
        GUIButtons[i].onHover();
      } else {
        GUIButtons[i].onLeave();
      }
    }
  }

  static void buttonClickInteractions(int x, int y) {
    for (int i = 0; i < GUIButtons.length; i++) {
      if (x <= GUIButtons[i].maxX && x >= GUIButtons[i].x && y <= GUIButtons[i].maxY && y >= GUIButtons[i].y) {
        GUIButtons[i].onClick();
      }
    }
  }
}

interface IGUIButton {
  void onClick();
}

class GUIButton {
  int x;
  int y;
  int sizeX;
  int sizeY;
  int textSize;
  String text;
  color normalStroke;
  color hoverStroke;
  color normalBackground;
  color hoverBackground;
  color normalText;
  color hoverText;


  int buttonWidth;
  int buttonHeight;
  int maxX;
  int maxY;

  IGUIButton IButton;

  GUIButton() {
  }

  GUIButton (int x, int y, int sizeX, int sizeY, String text, 
  int textSize, color normalStroke, color hoverStroke, color normalBackground, 
  color hoverBackground, color normalText, color hoverText, IGUIButton IButton) {
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.text = text;
    this.textSize = textSize;
    this.normalStroke = normalStroke;
    this.hoverStroke = hoverStroke;
    this.normalBackground = normalBackground;
    this.hoverBackground = hoverBackground;
    this.normalText = normalText;
    this.hoverText = hoverText;
    this.IButton = IButton;

    this.maxX = this.x + this.sizeX;
    this.maxY = this.y + this.sizeY;
    this.buttonWidth = this.maxX - this.x;
    this.buttonHeight = this.maxY - this.y;

    this.init();
  }

  void init() {
    onLeave();
  }

  void onLeave() {
    stroke(this.normalStroke);
    fill(this.normalBackground);
    rect(x, y, sizeX, sizeY);

    textAlign(CENTER);
    fill(this.normalText);
    textSize(this.textSize);
    text(this.text, (this.buttonWidth / 2 + this.x), (this.buttonHeight / 2 + this.y + this.textSize / 2));
  }

  void onHover() {
    stroke(this.hoverStroke);
    fill(this.hoverBackground);
    rect(x, y, sizeX, sizeY);

    textAlign(CENTER);
    fill(this.hoverText);
    textSize(this.textSize);
    text(this.text, (this.buttonWidth / 2 + this.x), (this.buttonHeight / 2 + this.y + this.textSize / 2));
  }

  void onClick() {
    try {
      this.IButton.onClick();
    }
    catch(Error e) {
      println(e);
    }
  }
}