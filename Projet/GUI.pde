class GUI {
  GUI() { 
  }
  
  GUIButton[] GUIButtons = new GUIButton[0];

  void addButton(GUIButton button) {
    GUIButtons = (GUIButton[])append(GUIButtons, button);
    button.init();
  }

  void flushButtons() {
    this.GUIButtons = (GUIButton[])subset(this.GUIButtons, 0, 0);
  }

  void buttonHoverInteractions(int x, int y) {
    for (int i = 0; i < GUIButtons.length; i++) {
      if (x <= GUIButtons[i].maxX && x >= GUIButtons[i].x && y <= GUIButtons[i].maxY && y >= GUIButtons[i].y) {
        GUIButtons[i].onHover();
      } else {
        GUIButtons[i].onLeave();
      }
    }
  }

  void buttonClickInteractions(int x, int y) {
    for (int i = 0; i < GUIButtons.length; i++) {
      if (x <= GUIButtons[i].maxX && x >= GUIButtons[i].x && y <= GUIButtons[i].maxY && y >= GUIButtons[i].y) {
        GUIButtons[i].onClick();
      }
    }
  }

  void showMenu() {
    background(#FFFFFF);
    
    this.addButton(new GUIButton(20, 0, 300, 40, "Bienvenue", 25, 0xffFFFFFF, 0xffFFFFFF, 0xffFFFFFF, 0xffFFFFFF, 0xff000000, 0xff000000, new IGUIButton() {
      public void onClick() {
      }
    }
    ));
  
    this.addButton(new GUIButton(20, 50, 300, 40, "Nouvelle partie", 15, color(#000000), 0xff444444, 0xff444444, 0xffAAAAAA, 0xffDDDDDD, 0xffFFFFFF, new IGUIButton() {
      public void onClick() {
        gui.flushButtons();
        gui.showNewGame();
      }
    }
    ));

    this.addButton(new GUIButton(20, 100, 300, 40, "Multijoueur", 15, color(#000000), 0xff444444, 0xff444444, 0xffAAAAAA, 0xffDDDDDD, 0xffFFFFFF, new IGUIButton() {
      public void onClick() {
      }
    }
    ));

    this.addButton(new GUIButton(20, 150, 300, 40, "Classement", 15, color(#000000), 0xff444444, 0xff444444, 0xffAAAAAA, 0xffDDDDDD, 0xffFFFFFF, new IGUIButton() {
      public void onClick() {
      }
    }
    ));
    
    this.addButton(new GUIButton(20, 200, 300, 40, "Quitter", 15, color(#000000), 0xff444444, 0xff444444, 0xffAAAAAA, 0xffDDDDDD, 0xffFFFFFF, new IGUIButton() {
      public void onClick() {
        exit();
      }
    }
    ));
  }
  
  void showNewGame() {
    background(#FFFFFF);
    
    textAlign(CENTER);
    fill(0);
    textSize(25);
    text("Commencer une nouvelle partie", pixelWidth/2, 30);
  }
}

class GUIInput {
  
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
    this.onLeave();
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