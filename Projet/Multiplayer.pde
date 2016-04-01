import websockets.*;
import http.requests.*;

static class Multiplayer {

  static class Escapologie {
    static String getStats(int mapID, int number) {
      GetRequest get = new GetRequest("http://localhost/stats/escapologie/" + mapID + "/" + number);
      get.send();

      return get.getContent();
    }

    static void sendStats(String username, Float score, int mapID) {
      PostRequest post = new PostRequest("http://localhost/add");
      post.addData("map", str(mapID)  );
      post.addData("username", username);
      post.addData("score", score.toString());
      post.addData("game", "escapologie");
      post.send();
    }
  }

  static WebsocketClient wsc;

  static void connect(String url) {
    wsc = new WebsocketClient(that, url);
  }

  static void send(String msg) {
    wsc.sendMessage(msg);
  }
}