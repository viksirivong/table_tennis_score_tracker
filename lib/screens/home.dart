import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:table_tennis_score_tracker/util/game_config.dart';
import 'choose_server.dart';
//import 'custom_game.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState(){
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
      appBar: AppBar(
        //TODO: Add appbar
      ),
      */
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
              Expanded(
                flex: 20,
                child: Container(),
              ),
              Expanded(
                flex: 20,
                child: Container(
                  child: Center(
                    child: Text(
                      "Choose Game Mode",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 40,
                child: Container(
                  margin: EdgeInsets.only(left: 80, right: 80, bottom: 80),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      _CustomButton(
                        nextScreen: ChooseServer(
                          title: widget.title,
                          gameSetting: GameSetting(5, 11, 2),
                        ),
                        buttonTitle: "11-Points Game",
                      ),
                      _CustomButton(
                        nextScreen: ChooseServer(
                          title: widget.title,
                          gameSetting: GameSetting(3, 21, 5),
                        ),
                        buttonTitle: "21-Points Game",
                      ),
                      /*
                      _CustomButton(
                        nextScreen: CustomGame(title: widget.title),
                        buttonTitle: "Custom Game",
                      ),
                      */
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 20,
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
  _CustomButton({required this.nextScreen, required this.buttonTitle});

  final dynamic nextScreen;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Container(
        margin: EdgeInsets.only(top: 15, bottom: 15),
        child: SizedBox.expand(
          child: OutlinedButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black87),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              //shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => nextScreen)
              );
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