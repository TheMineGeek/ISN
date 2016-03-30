import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.net.*; 
import websockets.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Projet extends PApplet {

 //<>// //<>//
//<>// //<>//
/* GLOBAL VARS DECLARATIONS */
Map map;
Screenshot screenshot;
static Projet that;
GUI gui;
String game = "";
/* SETUP FONCTIONS */

/**
 * Initialize map
 */
public void mapSetup(int mapNumber) {  
  game = "escape";
  map.flushBlocks();
  map.flushGates();
  map.setPattern(mapNumber);
  map.init();
  map.onWin = new onWinInterface() {
    @Override
      public void toDo() { // Ce qu'il faut faire quand on gagne la partie
      map.win = true;
      textAlign(CENTER);
      fill(0);
      textSize(30);
      text("Bravo ! Vous avez gagn\u00e9", pixelWidth/2, pixelHeight/2);
    }
  };
}

/**
 * Global setup
 */
public void setup() {
  background(0xffFFFFFF);
  frameRate(60);
  gui.showMenu();
}

/**
 * Specific setup
 */
public void settings() { 
  size(900, 500);  
  gui = new GUI();
  map = new Map();
}


public void draw() {
  if(game == "") {
  gui.hover(mouseX, mouseY);
  gui.tick();
  } else if(game == "escape") {
   map.tick(); 
  }
}

public void mousePressed() {
  gui.click(mouseX, mouseY);
}

public void keyPressed() { // Ce qu'il se passe quand une touche est press\u00e9e
  if (key == 27) { // Empeche le programme de se fermer lorsque l'on appuie sur ECHAP
    key = 0;
    gui.keyboard('!', ESC);
  } else {
    gui.keyboard(key, keyCode);
  }

  if (!map.win && map.keyboardEvents) {
    if (keyCode == 37) { // Fl\u00e8che gauche
      map.move("left"); // Fonction que tu peux retrouver dans la classe map
    } else if (keyCode == 38) { // Fl\u00e8che haut
      map.move("top");
    } else if (keyCode == 39) { // Fl\u00e8che droite
      map.move("right");
    } else if (keyCode == 40) { // Flech\u00e8 bas
      map.move("bottom");
    }
  }
}
interface onWinInterface {  //<>// //<>//
  public void toDo();
}

/**
 * Return all patterns
 */
public ArrayList<int[][]> patternsSetup() {  
  ArrayList<int[][]> patterns = new ArrayList<int[][]>();

  int[][] blank = {{1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1}}; 

  int[][] pattern ={{1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
    {1, 1, 0, 0, 0, 2, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 1, 0, 1}, 
    {1, 0, 1, 1, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 1, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 1, 1}, 
    {1, 1, 0, 0, -2, 0, 0, 0, 0, 1}, 
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1}}; 

  patterns.add(pattern);

  int[][] pattern2 = {{1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
    {1, 2, 0, 0, 0, 0, 0, 0, 3, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, -2, 0, 0, 0, 0, 0, 0, -3, 1}, 
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1}};

  patterns.add(pattern2);

  return patterns;
}

class Map { //<>// //<>// //<>// //<>// //<>//
  int[][] pattern;
  int speedX;
  int speedY;
  int spaceX;
  int spaceY;
  int blocSize;
  boolean win = false;
  boolean keyboardEvents = true;
  boolean firstKeyPressed = false;
  onWinInterface onWin;
  ArrayList<int[][]> patterns;

  Timer timer;

  Map() {
    this.blocSize = 50;
    this.speedX = this.speedY = 10;
    timer = new Timer();
  }  // La pseudo fonction pour initialiser la map

  Block[] movableBlocks = new Block[0]; // Tous les blocs qui peuvent bouger
  Gate[] gates = new Gate[0]; // Tous les blocs qui sont les portes de sortie

  public void init() { // Fonction pour dessiner la carte
    background(0xffFFFFFF);
    frameRate(60);
    for (int i = 0; i < this.pattern.length; i++) { // On parcourt la premi\u00e8re dimension du tableau
      for (int j = 0; j < this.pattern[i].length; j++) { // On parcourt la seconde dimension du tableau
        if (pattern[i][j] == 1) {
          new Block(j * this.blocSize, i *this.blocSize, this.blocSize, 1, color(222, 184, 135)); // Si c'est un 1 on met un bloc marron
        } else if (pattern[i][j] < 0) {
          Gate _gate; // Si c'est un n\u00e9gatif c'est une porte de sortie
          if (pattern[i][j] == -2) {
            _gate = new Gate(j * this.blocSize, i * this.blocSize, this.blocSize, (int)sqrt(sq(pattern[i][j])), color(0xffFF0000)); // Porte rouge
          } else {
            _gate = new Gate(j * this.blocSize, i * this.blocSize, this.blocSize, (int)sqrt(sq(pattern[i][j])), color(0xff00FF00)); // Porte verte
          }
          pattern[i][j] = 0;
          gates = (Gate[])append(gates, _gate); // Augmente la taille du tableau
        } else if (pattern[i][j] != 0) {
          Block block; // Sinon c'est un bloc d\u00e9pla\u00e7able
          if (pattern[i][j] == 2) {
            block = new Block(j * this.blocSize, i * this.blocSize, this.blocSize, 2, color(0xffFF0000));
          } else if (pattern[i][j] == 3) { 
            block = new Block(j * this.blocSize, i * this.blocSize, this.blocSize, 3, color(0xff00FF00));
          } else {
            block = new Block(j * this.blocSize, i * this.blocSize, this.blocSize, 4, color(0xff0000FF));
          }

          movableBlocks = (Block[])append(movableBlocks, block);
        }
      }
    }
  }

  public void setPattern(int pattern) {
    this.patterns = patternsSetup();
    this.pattern = this.patterns.get(pattern);

    this.spaceX = (pixelWidth - this.pattern[0].length * this.blocSize) / 2;
    this.spaceY = (pixelHeight - this.pattern.length * this.blocSize) / 2;
    /*this.spaceX = 0;
     this.spaceY = 0;*/
  }

  public boolean allCantMove(boolean[] array) { // Si plus aucun ne peut bouger, retourne true
    boolean move = true;
    for (int i = 0; i < array.length; i++) {
      if (!array[i]) { 
        move = false;
      }
    }
    return move;
  }

  public void move(String direction) { 
    if (!this.firstKeyPressed) {
      firstKeyPressed = true;
      timer.start();
    }
    int x = 0; //<>//
    int y = 0;
    if (direction == "left") {
      x = -1;
    } else if (direction == "right") { //<>//
      x = 1;
    } else if (direction == "top") {
      y = -1;
    } else if (direction == "bottom") { //<>//
      y = 1;
    }
    //<>//
    boolean[] cantMove = new boolean[this.movableBlocks.length]; // Tableau. Voir usage en dessous //<>//

    while (!allCantMove(cantMove)) { 
      for (int i = 0; i < this.movableBlocks.length; i++) {
        int indexX = this.movableBlocks[i].toMoveX/this.blocSize + this.movableBlocks[i].x/this.blocSize + x;
        int indexY = this.movableBlocks[i].toMoveY/this.blocSize + this.movableBlocks[i].y/this.blocSize + y;

        if (this.pattern[indexY][indexX] != 0) { //<>//
          cantMove[i] = true;
        } else {
          this.pattern[indexY-y][indexX-x] = 0;
          this.movableBlocks[i].toMove(x*this.blocSize, y*this.blocSize);
          this.pattern[indexY][indexX] = this.movableBlocks[i].id;
        }
      }
    }
  }

  public void tick() {
    timer.tick();
    fill(0xffFFFFFF);
    rect(0,0, this.spaceX, pixelHeight);
    
    textAlign(CENTER);
    fill(0xff000000);
    textSize(20);
    text(String.format("%.3g%n", timer.getTime()), this.spaceX / 2, 30);

    boolean _keyboardEvents = true;

    for (int i = 0; i < gates.length; i++) {
      gates[i].show();
    }

    for (int i = 0; i < this.movableBlocks.length; i++) {   
      this.movableBlocks[i].move(this.speedX, this.speedY);
      _keyboardEvents = !this.movableBlocks[i].mustMove();
    }   
    this.checkWin();
    this.keyboardEvents = _keyboardEvents;
  }

  public void checkWin() { // Regarde si tous les blocs sont dans la sortie que leurs correspond
    boolean win = true;
    for (int i = 0; i < this.movableBlocks.length; i++) {
      for (int j = 0; j < this.gates.length; j++) {
        if (this.movableBlocks[i].id == this.gates[j].id || this.movableBlocks[i].mustMove()) {
          if (!(this.movableBlocks[i].x == this.gates[j].x && this.movableBlocks[i].y == this.gates[j].y)) {
            win = false;
          }
        }
      }
    }

    if (win) {
      timer.stop();
      this.onWin.toDo();
    }
  }

  public void flushGates() {
    this.gates = (Gate[])subset(this.gates, 0, 0);
  }

  public void flushBlocks() {
    this.movableBlocks = (Block[])subset(this.movableBlocks, 0, 0);
  }

  public void screenshotAll(String path) {
    for (int i = 0; i < this.patterns.size(); i++) {
      this.flushBlocks();
      this.flushGates();
      this.pattern = this.patterns.get(i);
      this.init();
      screenshot.take(path + "\\escapologie-" + i + ".png");
    }
  }
}

class Block {  
  int size;
  int x;
  int y;
  int toMoveX;
  int toMoveY;
  int id;
  int blockColor;

  Block() {
  }

  Block(int x, int y, int size, int id, int blockColor) {
    this.x    = x;
    this.y    = y;
    this.size = size;
    this.blockColor = blockColor;
    this.id = id;
    this.show();
  }

  public void show() { // Affiche le bloc
    fill(this.blockColor);
    noStroke();
    rect(this.x + map.spaceX, this.y + map.spaceY, this.size, this.size);
  }

  public void move(int vx, int vy) { 
    fill(0xffFFFFFF);
    noStroke();
    rect(this.x + map.spaceX, this.y + map.spaceY, this.size, this.size); // Efface l'ancien cube

    if (this.toMoveX < 0) {
      this.toMoveX += vx;
      this.x -= vx;
    } else if (this.toMoveX > 0) {
      this.toMoveX -= vx;
      this.x += vx;
    }

    if (this.toMoveY < 0) {
      this.toMoveY += vy;
      this.y -= vy;
    } else if (this.toMoveY > 0) {
      this.toMoveY -= vy;
      this.y += vy;
    }

    this.show();
  }

  public void toMove(int x, int y) {
    this.toMoveX += x;
    this.toMoveY += y;
  }

  public Boolean mustMove() {
    if (this.toMoveX == 0 && this.toMoveY == 0) {
      return false;
    } else {
      return true;
    }
  }
}

class Gate { // Class pour les portes de sortie
  int x;
  int y;
  int id;
  int gateColor;
  int size;

  Gate() {
  }

  Gate(int x, int y, int size, int id, int gateColor) {
    this.x = x;
    this.y = y;
    this.size = size;
    this.id = id;
    this.gateColor = gateColor;
    this.show();
  }

  public void show() { // Affiche la porte
    stroke(this.gateColor);
    fill(0xffFFFFFF);
    rect(this.x + map.spaceX, this.y + map.spaceY, this.size, this.size);
  }

  public boolean hasBlock(int[][] pattern) { // La porte \u00e0 le bloc sur elle
    if (pattern[this.y/50][this.x/50] == this.id) {
      return true;
    }
    return false;
  }
}

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
  public void hover(int x, int y) {
    cursorType = ARROW;
    this.buttonHoverInteractions(x, y);
    this.inputHoverInteractions(x, y);
    cursor(cursorType);
  }

  /**
   * Handle click event
   */
  public void click(int x, int y) {
    this.buttonClickInteractions(x, y);
    this.inputClickInteractions(x, y);
  }

  /**
   * Handle keyboard event
   */
  public void keyboard(char _key, int _keyCode) {
    this.inputKeyboardInteractions(_key, _keyCode);
  }

  /**
   * Call functions inside each tick
   */
  public void tick() {
    this.inputTick();
  }

  /* BUTTONS CODE */
  /**
   * Add a new button to GUI
   */
  public void addButton(GUIButton button) {
    GUIButtons = (GUIButton[])append(GUIButtons, button);
  }

  /**
   * Remove all buttons of GUI's buttons list
   */
  public void flushButtons() {
    this.GUIButtons = (GUIButton[])subset(this.GUIButtons, 0, 0);
  }

  /**
   * Handle hover event for buttons
   */
  public void buttonHoverInteractions(int x, int y) {
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
  public void buttonClickInteractions(int x, int y) {
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
  public void addInput(GUIInput input) {
    GUIInputs = (GUIInput[])append(GUIInputs, input);
  }

  /**
   * Remove all inputs of GUI's inputs
   */
  public void flushInputs() {
    this.GUIInputs = (GUIInput[])subset(this.GUIInputs, 0, 0);
  }

  /**
   * Handle hover event for input
   */
  public void inputHoverInteractions(int x, int y) {
    for (int i = 0; i < GUIInputs.length; i++) {
      if (x <= GUIInputs[i].maxX && x >= GUIInputs[i].x && y <= GUIInputs[i].maxY && y >= GUIInputs[i].y) {
        cursorType = TEXT;
      }
    }
  }

  /**
   * Handle click event for input
   */
  public void inputClickInteractions(int x, int y) {
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
  public void inputKeyboardInteractions(char _key, int _keyCode) {
    for (int i = 0; i < GUIInputs.length; i++) {
      if (GUIInputs[i].reading) {
        GUIInputs[i].onKeyPressed(_key, _keyCode);
      }
    }
  }

  /**
   * Handle tick event for input
   */
  public void inputTick() {
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
  public void showMenu() {
    this.flushButtons();
    this.flushInputs();
    background(0xffFFFFFF);

    this.addButton(new GUIButton(300, 30, 300, 40, "Bienvenue", 50, 0xffFFFFFF, 0xffFFFFFF, 0xffFFFFFF, 0xffFFFFFF, 0xff000000, 0xff000000, new IGUIButton() {
      public void onClick() {
      }
    }
    ));

    this.addButton(new GUIButton(150, 150, 600, 50, "Nouvelle partie", 20, color(0xff000000), 0xff444444, 0xff444444, 0xffAAAAAA, 0xffDDDDDD, 0xffFFFFFF, new IGUIButton() {
      public void onClick() {
        gui.flushButtons();
        gui.showNewGame();
      }
    }
    ));

    this.addButton(new GUIButton(150, 210, 600, 50, "Multijoueur", 20, color(0xff000000), 0xff444444, 0xff444444, 0xffAAAAAA, 0xffDDDDDD, 0xffFFFFFF, new IGUIButton() {
      public void onClick() {
        gui.showMultiplayer();
      }
    }
    ));

    this.addButton(new GUIButton(150, 270, 600, 50, "Classement", 20, color(0xff000000), 0xff444444, 0xff444444, 0xffAAAAAA, 0xffDDDDDD, 0xffFFFFFF, new IGUIButton() {
      public void onClick() {
      }
    }
    ));

    this.addButton(new GUIButton(150, 330, 600, 50, "Quitter", 20, color(0xff000000), 0xff444444, 0xff444444, 0xffAAAAAA, 0xffDDDDDD, 0xffFFFFFF, new IGUIButton() {
      public void onClick() {
        exit();
      }
    }
    ));
  }

  /**
   * Show "New Game" menu
   */
  public void showNewGame() {
    this.flushButtons();
    this.flushInputs();
    background(0xffFFFFFF);

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
    
    this.addButton(new GUIButton(50, 20, 20, 20, "\u2190", 30, 0xffFFFFFF, 0xffFFFFFF, 0xffFFFFFF, 0xffFFFFFF, 0xff000000, 0xff000000, new IGUIButton() {
      public void onClick() {
        gui.showMenu();
      }
    }
    ));
    
    this.addButton(new GUIButton(50, 150, 40, 40, "1", 20, color(0xff000000), 0xff444444, 0xff444444, 0xffAAAAAA, 0xffDDDDDD, 0xffFFFFFF, new IGUIButton() {
      public void onClick() {
        mapSetup(0);
      }
    }
    ));
    
    this.addButton(new GUIButton(100, 150, 40, 40, "2", 20, color(0xff000000), 0xff444444, 0xff444444, 0xffAAAAAA, 0xffDDDDDD, 0xffFFFFFF, new IGUIButton() {
      public void onClick() {
        mapSetup(1);
      }
    }
    ));
  }

  /**
   * Show multiplayer menu
   */
  public void showMultiplayer() {
    this.flushButtons();
    this.flushInputs();
    background(0xffFFFFFF);

    this.addInput(new GUIInput(20, 200, 300, 40, 15, color(0xff000000), 0xff444444, 0xff444444, 0xffAAAAAA, 0xffDDDDDD, 0xffFFFFFF));

    this.addButton(new GUIButton(20, 250, 300, 40, "Retour", 15, color(0xff000000), 0xff444444, 0xff444444, 0xffAAAAAA, 0xffDDDDDD, 0xffFFFFFF, new IGUIButton() {
      public void onClick() {
        gui.showMenu();
      }
    }
    ));

    this.addButton(new GUIButton(20, 300, 300, 40, "Quitter", 15, color(0xff000000), 0xff444444, 0xff444444, 0xffAAAAAA, 0xffDDDDDD, 0xffFFFFFF, new IGUIButton() {
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
  int normalStroke;
  int selectedStroke;
  int normalBackground;
  int selectedBackground;
  int normalText;
  int selectedText;

  int intputWidth;
  int inputHeight;
  int maxX;
  int maxY;

  boolean reading;
  int cling;

  GUIInput() {
  }

  GUIInput (int x, int y, int sizeX, int sizeY, 
    int textSize, int normalStroke, int selectedStroke, int normalBackground, 
    int selectedBackground, int normalText, int selectedText) {
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
   */ //<>//
  public void init() {
    this.unSelect();
  }

  /**
   * Function called when there is a click event in the box
   */
  public void onClick() {
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
  public void unSelect() { //<>//
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
  public void textCursor() {
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
  public void unCling() {
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
  public void onKeyPressed(char _key, int _keyCode) {
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
  public void onClick();
}

class GUIButton {
  int x;
  int y;
  int sizeX;
  int sizeY;
  int textSize;
  String text;
  int normalStroke;
  int hoverStroke;
  int normalBackground;
  int hoverBackground;
  int normalText;
  int hoverText;


  int buttonWidth;
  int buttonHeight;
  int maxX;
  int maxY;

  IGUIButton IButton;

  GUIButton() {
  }

  GUIButton (int x, int y, int sizeX, int sizeY, String text, 
    int textSize, int normalStroke, int hoverStroke, int normalBackground, 
    int hoverBackground, int normalText, int hoverText, IGUIButton IButton) {
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
  public void init() {
    this.onLeave();
  }

  /**
   * Function called when cursor leaves box
   */
  public void onLeave() {
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
  public void onHover() {
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
  public void onClick() {
    try {
      this.IButton.onClick();
    }
    catch(Error e) {
      println(e);
    }
  }
}


static class Multiplayer {
  static WebsocketClient wsc;
  
  public static void connect(String url) {
     wsc = new WebsocketClient(that, url); 
  }
  
  public static void send(String msg) {
     wsc.sendMessage(msg); 
  }
}
class Screenshot {
   public void take(String path) {
     save(path);
   }
}
class Timer {
  float time;
  boolean activated;

  Timer() {
    this.activated = false;
    this.time = 0;
  }

  public void tick() {
    if (this.activated) {
      time += 1/frameRate;
    }
  }

  public float getTime() {
    return this.time;
  }

  public void start() {
    this.activated = true;
  }

  public void stop() {
    this.activated =  false;
  }

  public void reset() {
    this.activated =  false;
    this.time = 0;
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Projet" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
