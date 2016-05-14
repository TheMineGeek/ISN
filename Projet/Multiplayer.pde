import websockets.*;
import http.requests.*;

static class Multiplayer {
  static String statServerAddress = "http://81.220.173.13";
  
  
  static class Escapologie {
    static String getStats(int mapID, int number) {
      GetRequest get = new GetRequest(Multiplayer.statServerAddress + "/stats/escapologie/" + mapID + "/" + number);
      get.send();

      return get.getContent();
    }

    static void sendStats(String username, Float score, int mapID) {
      PostRequest post = new PostRequest(Multiplayer.statServerAddress + "add");
      post.addData("map", str(mapID)  );
      post.addData("username", username);
      post.addData("score", score.toString());
      post.addData("game", "escapologie");
      post.send();
    }
  }

  static boolean isConnectedToInternet() {
    GetRequest get = new GetRequest("http://google.fr/");
    get.send();
    
    if(get.getContent() != null) return true;
    else return false;
  }
  
  static boolean canJoinStatServer() {
    GetRequest get = new GetRequest(Multiplayer.statServerAddress);
    get.send();
    
    if(get.getContent() != null) return true;
    else return false;
  }
  
  static void hashMeThisPlease(String toHash) {
    PostRequest post = new PostRequest(Multiplayer.statServerAddress + "hash");
      post.addData("hash", toHash);
      post.send();
  }

  static WebsocketClient wsc;

  static void connect(String url) {
    wsc = new WebsocketClient(that, url);
  }

  static void send(String msg) {
    wsc.sendMessage(msg);
  }
}