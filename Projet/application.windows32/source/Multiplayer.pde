import websockets.*;

static class Multiplayer {
  static WebsocketClient wsc;
  
  static void connect(String url) {
     wsc = new WebsocketClient(that, url); 
  }
  
  static void send(String msg) {
     wsc.sendMessage(msg); 
  }
}