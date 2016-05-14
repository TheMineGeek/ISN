class Screenshot {
  String extension = ".png";
  
  void take(String path) {
    if (fileExists(path + this.extension)) {
      screenshot.take(path, 1);
    } else {
      save(path + this.extension);
    }
  }
  
  void take(String path, int depth) {
    if (fileExists(path + "(" + depth + ")" + this.extension)) {
      screenshot.take(path, depth + 1);
    } else {
      save(path + "(" + depth + ")" + this.extension);
    }
  }
}