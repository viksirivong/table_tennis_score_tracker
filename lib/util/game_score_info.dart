import 'package:table_tennis_score_tracker/util/game_config.dart';

class ScoreInfo extends GameSetting{
  int _player1Score = 0;
  int _player2Score = 0;
  int _player1GameWon = 0;
  int _player2GameWon = 0;
  int _gameNumber = 1;
  int _serverCount = 0;
  bool _currentServer = true; // true if it's Player 1, and false if it's Player 2

  ScoreInfo(bool firstServer, int numberOfGames, int maxPoint, int numberOfServes) : super(numberOfGames, maxPoint, numberOfServes) {
    this._currentServer = firstServer;
  }

  int get gameNumber {
    return this._gameNumber;
  }
  bool get isPlayer1Serve {
    return this._currentServer;
  }

  int playerScore(bool isPlayer1) {
    if (isPlayer1)
      return this._player1Score;
    else
      return this._player2Score;
  }
  int playerGameWon(bool isPlayer1) {
    if (isPlayer1)
      return this._player1GameWon;
    else
      return this._player2GameWon;
  }

  // Add point(s) to the Player score.
  // And determine whether Player win the game or reaches the maximum point, if Player 1 win return true, else false.
  bool addPlayerPoint(bool isPlayer1, int value) {
    if (isPlayer1) {
      this._player1Score += value;
      return (this._player1Score == maxPoint) ? true : false;
    }
    else {
      this._player2Score += value;
      return (this._player2Score == maxPoint) ? true : false;
    }
  }

  void addPlayer1GameWon(bool isPlayer1, int value) {
    if (isPlayer1)
      this._player1GameWon += value;
    else
      this._player2GameWon += value;
  }

  void evaluateServer() {
    this._serverCount++;
    if (this._serverCount == numberOfServes) {
      this._currentServer = !this._currentServer;
      this._serverCount = 0;
    }
  }

  // Evaluate the scoreboard when a player wins a game or reaches the maximum point
  int evaluateWinner() {
    if (this._player1Score == maxPoint || this._player2Score == maxPoint) {
      if (this._player1Score == maxPoint)
        this._player1GameWon++;
      else
        this._player2GameWon++;
      
      this._player2Score = 0;
      this._player1Score = 0;
      this._serverCount = 0;
    }
    this._gameNumber++;
    if (this._player1GameWon > (numberOfGames / 2))
      return 1;
    else if (this._player2GameWon > (numberOfGames / 2))
      return 2;
    else
      return 0;
  }
}