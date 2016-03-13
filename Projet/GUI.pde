class GUI {
  GUI() {
  }

  int cursorType;

  GUIButton[] GUIButtons = new GUIButton[0];
  GUIInput [] GUIInputs = new GUIInput[0];

  /* EVENT FUNCTIONS */

  /**
   * Handle hover event
   */
  void hover(int x, int y) {
    cursorType = ARROW;
    this.buttonHoverInteractions(x, y);
    this.inputHoverInteractions(x, y);
    cursor(cursorType);
  }

  /**
   * Handle click event
   */
  void click(int x, int y) {
    this.buttonClickInteractions(x, y);
    this.inputClickInteractions(x, y);
  }

  /**
   * Handle keyboard event
   */
  void keyboard(char _key, int _keyCode) {
    this.inputKeyboardInteractions(_key, _keyCode);
  }

  /**
   * Call functions inside each tick
   */
  void tick() {
    this.inputTick();
  }

  /* BUTTONS CODE */
  /**
   * Add a new button to GUI
   */
  void addButton(GUIButton button) {
    GUIButtons = (GUIButton[])append(GUIButtons, button);
  }

  /**
   * Remove all buttons of GUI's buttons list
   */
  void flushButtons() {
    this.GUIButtons = (GUIButton[])subset(this.GUIButtons, 0, 0);
  }

  /**
   * Handle hover event for buttons
   */
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

  /**
   * Handle click event for buttons
   */
  void buttonClickInteractions(int x, int y) {
    for (int i = 0; i < GUIButtons.length; i++) {
      if (x <= GUIButtons[i].maxX && x >= GUIButtons[i].x && y <= GUIButtons[i].maxY && y >= GUIButtons[i].y) {
        GUIButtons[i].onClick();
      }
    }
  }

  /* INPUTS CODE */

  /**
   * Add input to GUI inputs list
   */
  void addInput(GUIInput input) {
    GUIInputs = (GUIInput[])append(GUIInputs, input);
  }

  /**
   * Remove all inputs of GUI's inputs
   */
  void flushInputs() {
    this.GUIInputs = (GUIInput[])subset(this.GUIInputs, 0, 0);
  }

  /**
   * Handle hover event for input
   */
  void inputHoverInteractions(int x, int y) {
    for (int i = 0; i < GUIInputs.length; i++) {
      if (x <= GUIInputs[i].maxX && x >= GUIInputs[i].x && y <= GUIInputs[i].maxY && y >= GUIInputs[i].y) {
        cursorType = TEXT;
      }
    }
  }

  /**
   * Handle click event for input
   */
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

  /**
   * Handle keyboard event for input
   */
  void inputKeyboardInteractions(char _key, int _keyCode) {
    for (int i = 0; i < GUIInputs.length; i++) {
      if (GUIInputs[i].reading) {
        GUIInputs[i].onKeyPressed(_key, _keyCode);
      }
    }
  }

  /**
   * Handle tick event for input
   */
  void inputTick() {
    for (int i = 0; i < GUIInputs.length; i++) {
      if (GUIInputs[i].reading) {
        GUIInputs[i].textCursor();
      }
    }
  }

  /* MENUS CODE */

  /**
   * Show main menu
   */
  void showMenu() {
    this.flushButtons();
    this.flushInputs();
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
        gui.showMultiplayer();
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

  /**
   * Show "New Game" menu
   */
  void showNewGame() {
    this.flushButtons();
    this.flushInputs();
    background(#FFFFFF);

    textAlign(CENTER);
    fill(0);
    textSize(25);
    text("Commencer une nouvelle partie", pixelWidth/2, 30);
  }

  /**
   * Show multiplayer menu
   */
  void showMultiplayer() {
    this.flushButtons();
    this.flushInputs();
    background(#FFFFFF);
    println("showMultiplayer()");
    background(#FFFFFF);

    this.addInput(new GUIInput(20, 200, 300, 40, 15, color(#000000), 0xff444444, 0xff444444, 0xffAAAAAA, 0xffDDDDDD, 0xffFFFFFF));

    this.addButton(new GUIButton(20, 250, 300, 40, "Retour", 15, color(#000000), 0xff444444, 0xff444444, 0xffAAAAAA, 0xffDDDDDD, 0xffFFFFFF, new IGUIButton() {
      public void onClick() {
        gui.showMenu();
      }
    }
    ));

    this.addButton(new GUIButton(20, 300, 300, 40, "Quitter", 15, color(#000000), 0xff444444, 0xff444444, 0xffAAAAAA, 0xffDDDDDD, 0xffFFFFFF, new IGUIButton() {
      public void onClick() {
        exit();
      }
    }
    ));
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

  /**
   * Function used to create the button when all parameters are registered
   */
  void init() {
    println("init()");
    this.unSelect();
  }

  /**
   * Function called when there is a click event in the box
   */
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

  /**
   * Function called when there is a click event out of the box or when ESC is pressed
   */
  void unSelect() { //<>//
    this.unCling();

    stroke(this.normalStroke);
    fill(this.normalBackground);
    println(this.x + " " + this.y + " " + this.sizeX + " " + this.sizeY);
    rect(this.x, this.y, this.sizeX, this.sizeY);

    textAlign(LEFT);
    fill(this.normalText);
    textSize(this.textSize);
    text(this.text, (this.x + 10), (this.inputHeight / 2 + this.y + this.textSize / 2));
  }

  /**
   * Function used for the cursor blinking in input
   */
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

  /**
   * Function remove the cursor of the text
   */
  void unCling() {
    if (this.text.length() != 0) {
      if (this.text.charAt(this.text.length()-1) == '|') {
        this.text = this.text.substring(0, this.text.length()-1);
      }
    }
    this.cling = 59;
  }

  /**
   * Function called when there is a keyboard event
   */
  void onKeyPressed(char _key, int _keyCode) {
    if (_keyCode == ESC) {
      this.reading = false;
      this.unSelect();
    } else if (_key == 8) {
      this.unCling();
      if (this.text.length() > 0) {
        this.text = this.text.substring(0, this.text.length()-1);
      }
    } else if (match(str(_key), "[a-zA-Z0-9_]") != null) {
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

  /**
   * Function called to create button when all parameters are registered
   */
  void init() {
    this.onLeave();
  }

  /**
   * Function called when cursor leaves box
   */
  void onLeave() {
    stroke(this.normalStroke);
    fill(this.normalBackground);
    rect(this.x, this.y, this.sizeX, this.sizeY);

    textAlign(CENTER);
    fill(this.normalText);
    textSize(this.textSize);
    text(this.text, (this.buttonWidth / 2 + this.x), (this.buttonHeight / 2 + this.y + this.textSize / 2));
  }

  /**
   * Function called when cursor is hovering the box
   */
  void onHover() {
    stroke(this.hoverStroke);
    fill(this.hoverBackground);
    rect(this.x, this.y, this.sizeX, this.sizeY);

    textAlign(CENTER);
    fill(this.hoverText);
    textSize(this.textSize);
    text(this.text, (this.buttonWidth / 2 + this.x), (this.buttonHeight / 2 + this.y + this.textSize / 2));
  }

  /**
   * Function called when there is a click on the box
   */
  void onClick() {
    try {
      this.IButton.onClick();
    }
    catch(Error e) {
      println(e);
    }
  }
}