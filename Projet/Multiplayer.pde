import websockets.*;
import http.requests.*;

static class Multiplayer {
  static String statServerAddress = "http://81.220.173.13/"; // adresse de connexion au serveur


  static class Escapologie {
    /**
     * Cette class permet de gérer les envois de scores
     * sur le jeu Escape it !
     **/
    static String getStats(int mapID, int number) {
      GetRequest get = new GetRequest(Multiplayer.statServerAddress + "/stats/escapologie/" + mapID + "/" + number);
      get.send();

      return get.getContent();
    }

    static void sendStats(String username, Float score, int mapID) { // envoit les données au serveur
      // println("here");
      PostRequest post = new PostRequest(Multiplayer.statServerAddress + "add");
      post.addData("map", str(mapID)  ); // donne le nom du niveau
      post.addData("username", username); // donne le nom du joueur
      post.addData("score", score.toString()); // donne le score
      post.addData("game", "escapologie"); // donne le nom du jeu
      post.send(); // envoit les données
    }
  }

  static boolean isConnectedToInternet() { // vérifie la connexion internet du client
    GetRequest get = new GetRequest("http://google.fr/");
    get.send();

    if (get.getContent() != null) return true;
    else return false;
  }

  static boolean canJoinStatServer() { // se connecte au serveur pour les scores
    GetRequest get = new GetRequest(Multiplayer.statServerAddress);
    get.send();

    if (get.getContent() != null) return true;
    else return false;
  }

  static void hashMeThisPlease(String toHash) {
    PostRequest post = new PostRequest(Multiplayer.statServerAddress + "hash");
    post.addData("hash", toHash);
    post.send();
  }

  static WebsocketClient wsc;

  static void connect(Projet projet, String url) {
    wsc = new WebsocketClient(projet, url);
  }

  static void send(String msg) {
    wsc.sendMessage(msg);
  }
}