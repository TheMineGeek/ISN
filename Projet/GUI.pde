class GUI {
  GUI() {
  }

  int cursorType;

  GUIButton[] GUIButtons = new GUIButton[0];
  GUIInput [] GUIInputs = new GUIInput[0];

  /* EVENT FUNCTIONS */

  void hover(int x, int y) {
    cursorType = ARROW;
    this.buttonHoverInteractions(x, y);
    this.inputHoverInteractions(x, y);
    cursor(cursorType);
  }

  void click(int x, int y) {
    this.buttonClickInteractions(x, y);
    this.inputClickInteractions(x, y);
  }

  void keyboard(char _key, int _keyCode) {
    this.inputKeyboardInteractions(_key, _keyCode);
  }

  void tick() {
    this.inputTick();
  }

  /* BUTTONS CODE */

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
        this.cursorType = HAND;
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

  /* INPUTS CODE */

  void addInput(GUIInput input) {
    GUIInputs = (GUIInput[])append(GUIInputs, input);
    input.init();
  }

  void flushInputs() {
    this.GUIInputs = (GUIInput[])subset(this.GUIInputs, 0, 0);
  }

  void inputHoverInteractions(int x, int y) {
    for (int i = 0; i < GUIInputs.length; i++) {
      if (x <= GUIInputs[i].maxX && x >= GUIInputs[i].x && y <= GUIInputs[i].maxY && y >= GUIInputs[i].y) {
        cursorType = TEXT;
      }
    }
  }

  void inputClickInteractions(int x, int y) {
    for (int i = 0; i < GUIInputs.length; i++) {
      if (x <= GUIInputs[i].maxX && x >= GUIInputs[i].x && y <= GUIInputs[i].maxY && y >= GUIInputs[i].y) {
        GUIInputs[i].onClick();
        GUIInputs[i].reading = true;
      } else {    
        GUIInputs[i].unSelect();
        GUIInputs[i].reading = false;
      }
    }
  }

  void inputKeyboardInteractions(char _key, int _keyCode) {
    for (int i = 0; i < GUIInputs.length; i++) {
      if (GUIInputs[i].reading) {
        GUIInputs[i].onKeyPressed(_key, _keyCode);
      }
    }
  }

  void inputTick() {
    for (int i = 0; i < GUIInputs.length; i++) {
      if (GUIInputs[i].reading) {
        GUIInputs[i].textCursor();
      }
    }
  }

  /* MENUS CODE */

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

  void showMultiplayer() {
    background(#FFFFFF);

    surface.setSize(400, 500);

    this.addButton(new GUIButton(20, 250, 300, 40, "Quitter", 15, color(#000000), 0xff444444, 0xff444444, 0xffAAAAAA, 0xffDDDDDD, 0xffFFFFFF, new IGUIButton() {
      public void onClick() {
        exit();
      }
    }
    ));
    this.addInput(new GUIInput(20, 200, 300, 40, 15, color(#000000), 0xff444444, 0xff444444, 0xffAAAAAA, 0xffDDDDDD, 0xffFFFFFF));
  }
}

class GUIInput {
  int x;
  int y;
  int sizeX;
  int sizeY;
  int textSize;
  String text;
  color normalStroke;
  color selectedStroke;
  color normalBackground;
  color selectedBackground;
  color normalText;
  color selectedText;

  int intputWidth;
  int inputHeight;
  int maxX;
  int maxY;

  boolean reading;
  int cling;

  GUIInput() {
  }

  GUIInput (int x, int y, int sizeX, int sizeY, 
    int textSize, color normalStroke, color selectedStroke, color normalBackground, 
    color selectedBackground, color normalText, color selectedText) {
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.text = "";
    this.textSize = textSize;
    this.normalStroke = normalStroke;
    this.selectedStroke = selectedStroke;
    this.normalBackground = normalBackground;
    this.selectedBackground = selectedBackground;
    this.normalText = normalText;
    this.selectedText = selectedText;

    this.maxX = this.x + this.sizeX;
    this.maxY = this.y + this.sizeY;
    this.intputWidth = this.maxX - this.x;
    this.inputHeight = this.maxY - this.y;

    this.cling = 29;

    this.init();
  }

  void init() {
    this.unSelect();
  }

  void onClick() {
    stroke(this.selectedStroke);
    fill(this.selectedBackground);
    //println(this.x + " " + this.y + " " + this.sizeX + " " + this.sizeY);
    rect(x, y, sizeX, sizeY);

    textAlign(LEFT);
    fill(this.selectedText);
    textSize(this.textSize);
    text(this.text, (this.x + 10), (this.inputHeight / 2 + this.y + this.textSize / 2));
  }

  void unSelect() {
    this.unCling();
    
    stroke(this.normalStroke);
    fill(this.normalBackground);
    rect(x, y, sizeX, sizeY);

    textAlign(LEFT);
    fill(this.normalText);
    textSize(this.textSize);
    text(this.text, (this.x + 10), (this.inputHeight / 2 + this.y + this.textSize / 2));
  }

  void textCursor() {
    cling++;
    if (cling == 30) {
      if (this.text.length() != 0) {
        if (this.text.charAt(this.text.length()-1) == '|') {
          this.text = this.text.substring(0, this.text.length()-1);
        }
      }
    } else if (cling == 60) {
      if (this.text.length() == 0) {
        this.text += "|";
      } else {
        if (this.text.charAt(this.text.length()-1) != '|') {
          this.text += "|";
        }
      }
      cling = 0;
    }

    this.onClick();
  }

  void unCling() {
    if (this.text.length() != 0) {
      if (this.text.charAt(this.text.length()-1) == '|') {
        this.text = this.text.substring(0, this.text.length()-1);
      }
    }
    this.cling = 59;
  }

  void onKeyPressed(char _key, int _keyCode) {
    if (_keyCode == ESC) {
      this.reading = false;
      this.unSelect();
    } else if(_key == 8) {
      this.unCling();
      if(this.text.length() > 0) {
        println(this.text.length());
         this.text = this.text.substring(0, this.text.length()-1);
      }
    }
    else if(match(str(_key), "[a-zA-Z0-9_]") != null){
      this.unCling();
      this.text += match(str(_key), "[a-zA-Z0-9_]")[0];
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