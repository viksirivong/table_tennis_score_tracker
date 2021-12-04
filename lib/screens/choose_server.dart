import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:table_tennis_score_tracker/util/game_config.dart';
import 'package:table_tennis_score_tracker/util/game_score_info.dart';
import 'in_game.dart';

class ChooseServer extends StatefulWidget {
  ChooseServer({Key? key, required this.title, required this.gameSetting}) : super(key: key);

  final String title;
  final GameSetting gameSetting;

  @override
  _ChooseServer createState() => _ChooseServer();
}

class _ChooseServer extends State<ChooseServer> {
  final _player1 = true;
  final _player2 = false;

  @override
  void initState(){
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  Future<void> _openServerChosenAlert(String player) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: Text("$player Serves")
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                ScoreInfo scoreBoard = ScoreInfo(
                    widget.gameSetting.firstServer,
                    widget.gameSetting.numberOfGames,
                    widget.gameSetting.maxPoint,
                    widget.gameSetting.numberOfServes
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InGame(
                    title: widget.title,
                    scoreBoard: scoreBoard
                  )),
                );
              },
              child: Text("Begin"),
            ),
          ],
        );
      },
    );
  }

  void updateFirstServer(bool server) {
    widget.gameSetting.setFirstServer(server);
    _openServerChosenAlert((server)? "Player 1" : "Player 2");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/table_tennis_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Container(),
              ),
              Flexible(
                flex: 2,
                child: Center(
                  child: Text(
                    'Choose First Server',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 5,
                child: Container(
                  margin: EdgeInsets.only(left: 300, right: 300),
                  child: Column(
                    children: <Widget>[
                      _CustomButton(
                        server: _player1,
                        buttonTitle: "Player 1",
                        callUpdateFirstServer: updateFirstServer
                      ),
                      _CustomButton(
                          server: _player2,
                          buttonTitle: "Player 2",
                          callUpdateFirstServer: updateFirstServer
                      ),
                      _CustomButton(
                          server: Random().nextBool(),
                          buttonTitle: "Random",
                          callUpdateFirstServer: updateFirstServer
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomButton extends StatelessWidget {
  _CustomButton({required this.server, required this.buttonTitle, required this.callUpdateFirstServer});

  final bool server;
  final String buttonTitle;
  final void Function(bool) callUpdateFirstServer;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Container(
        margin: EdgeInsets.only(top: 6, bottom: 6),
        child: SizedBox.expand(
          child: OutlinedButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black87),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            onPressed: () {
              callUpdateFirstServer(server);
            },
            child: Text(
              buttonTitle,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}