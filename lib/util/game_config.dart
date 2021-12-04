class GameSetting {
  int _numberOfGames;
  int _maxPoint;
  int _numberOfServes;
  bool _firstServer = false;

  GameSetting.setDefault(): _numberOfGames = 0, _maxPoint = 0, _numberOfServes = 0;
  GameSetting(this._numberOfGames, this._maxPoint, this._numberOfServes);

  int get numberOfGames {
    return this._numberOfGames;
  }
  int get maxPoint {
    return this._maxPoint;
  }
  int get numberOfServes {
    return this._numberOfServes;
  }
  bool get firstServer {
    return this._firstServer;
  }

  void setNumberOfGames(int value) {
    this._numberOfGames = value;
  }
  void setMaxPoints(int value) {
    this._maxPoint = value;
  }
  void setNumberOfServes(int value) {
    this._numberOfServes = value;
  }
  void setFirstServer(bool server) {
    this._firstServer = server;
  }

  @override
  String toString() {
    return "{_numberOfGames = $_numberOfGames, _maxPoint = $_maxPoint, _numberOfServes = $_numberOfServes, _firstServer = $_firstServer}";
  }
}