class GUI {  //<>//
  GUI() {
  }

  int cursorType;
  int mapNumber;

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

    this.addButton(new GUIButton(300, 30, 300, 40, "Bienvenue", 50, 0xffFFFFFF, 0xffFFFFFF, 0xffFFFFFF, 0xffFFFFFF, 0xff000000, 0xff000000, new IGUIButton() {
      public void onClick() {
      }
    }
    ));

    this.addButton(new GUIButton(150, 150, 600, 50, "Nouvelle partie", 20, color(#000000), 0xff444444, 0xff444444, 0xffAAAAAA, 0xffDDDDDD, 0xffFFFFFF, new IGUIButton() {
      public void onClick() {
        gui.flushButtons();
        gui.showNewGame();
      }
    }
    ));

    this.addButton(new GUIButton(150, 210, 600, 50, "Multijoueur", 20, color(#000000), 0xff444444, 0xff444444, 0xffAAAAAA, 0xffDDDDDD, 0xffFFFFFF, new IGUIButton() {
      public void onClick() {
        gui.showMultiplayer();
      }
    }
    ));

    this.addButton(new GUIButton(150, 270, 600, 50, "Classement", 20, color(#000000), 0xff444444, 0xff444444, 0xffAAAAAA, 0xffDDDDDD, 0xffFFFFFF, new IGUIButton() {
      public void onClick() {
      }
    }
    ));

    this.addButton(new GUIButton(150, 330, 600, 50, "Quitter", 20, color(#000000), 0xff444444, 0xff444444, 0xffAAAAAA, 0xffDDDDDD, 0xffFFFFFF, new IGUIButton() {
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

    this.addButton(new GUIButton(200, 10, 500, 40, "Commencer une nouvelle partie", 30, 0xffFFFFFF, 0xffFFFFFF, 0xffFFFFFF, 0xffFFFFFF, 0xff000000, 0xff000000, new IGUIButton() {
      public void onClick() {
      }
    }
    ));

    this.addButton(new GUIButton(50, 100, 100, 40, "Escape it !", 20, 0xffFFFFFF, 0xffFFFFFF, 0xffFFFFFF, 0xffFFFFFF, 0xff000000, 0xff000000, new IGUIButton() {
      public void onClick() {
      }
    }
    ));

    this.addButton(new GUIButton(50, 20, 20, 20, "←", 30, 0xffFFFFFF, 0xffFFFFFF, 0xffFFFFFF, 0xffFFFFFF, 0xff000000, 0xff000000, new IGUIButton() {
      public void onClick() {
        gui.showMenu();
      }
    }
    ));

    for (int i = 0; i < patterns.length / 2; i++) {
      for (int j = 0; j < 10; j++) {
        if (i * 10 + j < patterns.length) {
          this.mapNumber = i * 10 + j;
          int normalStrokeColor;
          if (patterns[mapNumber].levelDifficulty == LevelDifficulty.EASY) {
            normalStrokeColor = 0xff00FF00;
          } else if (patterns[mapNumber].levelDifficulty == LevelDifficulty.MEDIUM ) {
            normalStrokeColor = 0xffFFA500;
          } else {
            normalStrokeColor = 0xffFF0000;
          }

          this.addButton(new GUIButton(50 * (j+1), 150 * (i + 1), 40, 40, str(mapNumber + 1), 20, normalStrokeColor, 0xff000000, 0xff444444, 0xffAAAAAA, 0xffDDDDDD, 0xffFFFFFF, new IGUIButton() {
            public void onClick() {
            }
          }
          ));

          GUIButtons[GUIButtons.length-1].mapID = mapNumber;
        }
      }
    }
  }

  /**
   * Show multiplayer menu
   */
  void showMultiplayer() {
    this.flushButtons();
    this.flushInputs();
    background(#FFFFFF);    

    this.addButton(new GUIButton(50, 20, 20, 20, "←", 30, 0xffFFFFFF, 0xffFFFFFF, 0xffFFFFFF, 0xffFFFFFF, 0xff000000, 0xff000000, new IGUIButton() {
      public void onClick() {
        gui.showMenu();
      }
    }
    ));

    this.addButton(new GUIButton(200, 10, 500, 40, "Rejoindre un serveur multijoueur", 30, 0xffFFFFFF, 0xffFFFFFF, 0xffFFFFFF, 0xffFFFFFF, 0xff000000, 0xff000000, new IGUIButton() {
      public void onClick() {
      }
    }
    ));

    this.addButton(new GUIButton(350, 100, 200, 40, "Pseudo :", 25, 0xffFFFFFF, 0xffFFFFFF, 0xffFFFFFF, 0xffFFFFFF, 0xff000000, 0xff000000, new IGUIButton() {
      public void onClick() {
      }
    }
    ));

    this.addInput(new GUIInput(250, 150, 400, 40, 15, color(#000000), 0xff444444, 0xff444444, 0xffAAAAAA, 0xffDDDDDD, 0xffFFFFFF));

    this.addButton(new GUIButton(325, 225, 300, 40, "Adresse IP du serveur : ", 25, 0xffFFFFFF, 0xffFFFFFF, 0xffFFFFFF, 0xffFFFFFF, 0xff000000, 0xff000000, new IGUIButton() {
      public void onClick() {
      }
    }
    ));

    this.addInput(new GUIInput(250, 275, 400, 40, 15, color(#000000), 0xff444444, 0xff444444, 0xffAAAAAA, 0xffDDDDDD, 0xffFFFFFF));

    this.addButton(new GUIButton(250, 325, 400, 40, "Rejoindre", 20, color(#000000), 0xff444444, 0xff444444, 0xffAAAAAA, 0xffDDDDDD, 0xffFFFFFF, new IGUIButton() {
      public void onClick() {
      }
    }
    ));
  }

  void askForUsernameMenu() {
    background(255);
    this.addButton(new GUIButton(50, 0, 800, 140, "Bienvenue, aucun nom d'utilisateur n'a été détécté. \nMerci d'en saisir un puis de cliquer sur continuer", 30, 0xffFFFFFF, 0xffFFFFFF, 0xffFFFFFF, 0xffFFFFFF, 0xff000000, 0xff000000, new IGUIButton() {
      public void onClick() {
      }
    }
    ));

    this.addButton(new GUIButton(350, 200, 200, 40, "Pseudo :", 25, 0xffFFFFFF, 0xffFFFFFF, 0xffFFFFFF, 0xffFFFFFF, 0xff000000, 0xff000000, new IGUIButton() {
      public void onClick() {
      }
    }
    ));

    this.addInput(new GUIInput(250, 250, 400, 40, 15, color(#000000), 0xff444444, 0xff444444, 0xffAAAAAA, 0xffDDDDDD, 0xffFFFFFF));

    this.addButton(new GUIButton(250, 375, 400, 40, "Continuer", 20, color(#000000), 0xff444444, 0xff444444, 0xffAAAAAA, 0xffDDDDDD, 0xffFFFFFF, new IGUIButton() {
      public void onClick() {
        saveUsername(gui.GUIInputs[0].getValue());
        gui.showMenu();
      }
    }
    ));
  }
}


class GUIInput {
  private int x;
  private int y;
  private int sizeX;
  private int sizeY;
  private int textSize;
  private String text;
  private color normalStroke;
  private color selectedStroke;
  private color normalBackground;
  private color selectedBackground;
  private color normalText;
  private color selectedText;

  private int intputWidth;
  private int inputHeight;
  private int maxX;
  private int maxY;

  private boolean reading;
  private int cling;

  GUIInput() {
  }

  GUIInput (int x, int y, int sizeX, int sizeY, 
    int textSize, color normalStroke, color selectedStroke, color normalBackground, //<>//
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
  private void init() {
    this.unSelect();
  }

  /**
   * Function called when there is a click event in the box
   */
  private void onClick() {
    stroke(this.selectedStroke);
    fill(this.selectedBackground);
    rect(x, y, sizeX, sizeY);

    textAlign(LEFT);
    fill(this.selectedText);
    textSize(this.textSize);
    text(this.text, (this.x + 10), (this.inputHeight / 2 + this.y + this.textSize / 2));
  }

  /**
   * Function called when there is a click event out of the box or when ESC is pressed
   */
  private void unSelect() {
    this.unCling();

    stroke(this.normalStroke);
    fill(this.normalBackground);
    rect(this.x, this.y, this.sizeX, this.sizeY);

    textAlign(LEFT);
    fill(this.normalText);
    textSize(this.textSize);
    text(this.text, (this.x + 10), (this.inputHeight / 2 + this.y + this.textSize / 2));
  }

  /**
   * Function used for the cursor blinking in input
   */
  private void textCursor() {
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
  private void unCling() {
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
  private void onKeyPressed(char _key, int _keyCode) {
    if (_keyCode == ESC) {
      this.reading = false;
      this.unSelect();
    } else if (_key == 8) {
      this.unCling();
      if (this.text.length() > 0) {
        this.text = this.text.substring(0, this.text.length()-1);
      }
    } else if (match(str(_key), "[a-zA-Z0-9_.]") != null) {
      this.unCling();
      this.text += match(str(_key), "[a-zA-Z0-9_.]")[0];
    }
  }

  String getValue() {
    this.unCling();
    return this.text;
  }
}

interface IGUIButton {
  int id = 0;
  void onClick();
}

class GUIButton {
  private int x;
  private int y;
  private int sizeX;
  private int sizeY;
  private int textSize;
  private String text;
  private color normalStroke;
  private color hoverStroke;
  private color normalBackground;
  private color hoverBackground;
  private color normalText;
  private color hoverText;


  private int buttonWidth;
  private int buttonHeight;
  private int maxX;
  private int maxY;

  int mapID; // Only use by interface

  public IGUIButton IButton;

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

    this.mapID = -1; // Only used for GUI Buttons on new Game menu

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
    if (this.mapID != -1) {
      mapSetup(this.mapID);
    } else {
      try {
        this.IButton.onClick();
      }
      catch(Error e) {
        println(e);
      }
    }
  }
}