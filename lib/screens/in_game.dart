import 'package:flutter/material.dart';
import 'package:table_tennis_score_tracker/screens/choose_server.dart';
import 'package:table_tennis_score_tracker/screens/home.dart';
import 'package:table_tennis_score_tracker/util/game_config.dart';
import 'package:table_tennis_score_tracker/util/game_score_info.dart';

class InGame extends StatefulWidget {
  InGame({Key? key, required this.title, required this.scoreBoard}) : super(key: key);

  final String title;
  final ScoreInfo scoreBoard;

  @override
  _InGame createState() => _InGame();
}

class _InGame extends State<InGame> {

  final double _borderThickness = 4;
  final Color _borderColor = Colors.black;

  Future<void> _openGameWinnerAlert(String player) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text("$player Takes Game ${widget.scoreBoard.gameNumber}")
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                var checkGameWinner;
                setState(() {
                  checkGameWinner = widget.scoreBoard.evaluateWinner();
                });
                Navigator.of(context).pop();
                if (checkGameWinner != 0) {
                  _openMatchWinnerAlert(player);
                }
              },
              child: Text("Continue"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _openMatchWinnerAlert(String player) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: Text("Congratulation $player WON!!!")
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                GameSetting gameSetting = GameSetting(
                    widget.scoreBoard.numberOfGames,
                    widget.scoreBoard.maxPoint,
                    widget.scoreBoard.numberOfServes
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChooseServer(
                    title: widget.title,
                    gameSetting: gameSetting
                  )),
                );
              },
              child: Text("Rematch"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage(title: widget.title)),
                );
              },
              child: Text("Return Home"),
            ),
          ],
        );
      },
    );
  }

  void updateScore(bool isPlayer1, String name) {
    setState(() {
      if (widget.scoreBoard.addPlayerPoint(isPlayer1, 1))
        _openGameWinnerAlert(name);
      widget.scoreBoard.evaluateServer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: _borderColor,
            width: _borderThickness,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 90,
              child: Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 22,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    flex: 78,
                                    child: _PlayerNameDisplay(name: "Player 1"),
                                ),
                                Expanded(
                                    flex: 22,
                                    child: _GameScoreDisplay(
                                      isLeftSide: true,
                                      isPlayer1: true,
                                      scoreBoard: widget.scoreBoard,
                                      borderColor: _borderColor,
                                      borderThickness: _borderThickness,
                                    ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              flex: 78,
                              child: _PointButton(
                                isPlayer1: true,
                                name: "Player 1",
                                scoreBoard: widget.scoreBoard,
                                callUpdateScore: updateScore,
                              ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      widthFactor: 0,
                      child: VerticalDivider(
                        thickness: _borderThickness,
                        color: _borderColor,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 22,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 22,
                                  child: _GameScoreDisplay(
                                    isLeftSide: false,
                                    isPlayer1: false,
                                    scoreBoard: widget.scoreBoard,
                                    borderColor: _borderColor,
                                    borderThickness: _borderThickness,
                                  ),
                                ),
                                Expanded(
                                  flex: 78,
                                  child: _PlayerNameDisplay(name: "Player 2"),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 78,
                            child: _PointButton(
                              isPlayer1: false,
                              name: "Player 2",
                              scoreBoard: widget.scoreBoard,
                              callUpdateScore: updateScore,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 10,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      color: (widget.scoreBoard.isPlayer1Serve)? Colors.green : Colors.grey,
                    ),
                  ),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: _borderColor,
                            width: _borderThickness,
                          ),
                          left: BorderSide(
                            color: _borderColor,
                            width: _borderThickness,
                          ),
                          right: BorderSide(
                            color: _borderColor,
                            width: _borderThickness,
                          ),
                        ),
                      ),
                      child: OutlinedButton(
                        child: Icon(Icons.home), //TODO: Add the setting button while in game
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyHomePage(title: widget.title)),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        color: (!widget.scoreBoard.isPlayer1Serve)? Colors.green : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PointButton extends StatelessWidget {
  _PointButton({required this.isPlayer1, required this.name, required this.scoreBoard, required this.callUpdateScore});

  final bool isPlayer1;
  final String name;
  final ScoreInfo scoreBoard;
  final void Function(bool, String) callUpdateScore;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: TextButton(
        onPressed: () {
          callUpdateScore(isPlayer1, name);
        },
        child: Text(
          scoreBoard.playerScore(isPlayer1).toString(),
          style: TextStyle(
            color: Colors.red,
            fontSize: 150,
          ),
        ),
      ),
    );
  }
}

class _GameScoreDisplay extends StatelessWidget {
  _GameScoreDisplay({
    required this.isLeftSide,
    required this.isPlayer1,
    required this.scoreBoard,
    required this.borderColor,
    required this.borderThickness,
  });

  final bool isLeftSide;  //To determine the side (left/right) of the score board
  final bool isPlayer1;
  final ScoreInfo scoreBoard;
  final Color borderColor;
  final double borderThickness;

  @override
  Widget build(BuildContext context) {
    Border border = (isLeftSide)?
    Border(
      left: BorderSide(
        color: borderColor,
        width: borderThickness,
      ),
      bottom: BorderSide(
        color: borderColor,
        width: borderThickness,
      ))
        :
    Border(
      right: BorderSide(
        color: borderColor,
        width: borderThickness,
      ),
      bottom: BorderSide(
        color: borderColor,
        width: borderThickness,
      )
    );
    return SizedBox.expand(
      child: Container(
        decoration: BoxDecoration(
          border: border
        ),
        child: Center(
          child: Text(
            scoreBoard.playerGameWon(isPlayer1).toString(),
            style: TextStyle(
              fontSize: 40,
            ),
          ),
        ),
      ),
    );
  }
}

class _PlayerNameDisplay extends StatelessWidget {
  _PlayerNameDisplay({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        name,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
