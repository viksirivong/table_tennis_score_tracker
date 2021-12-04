import 'package:flutter/material.dart';
import 'choose_server.dart';
import 'package:table_tennis_score_tracker/widgets/quantity_controller.dart';
import 'package:table_tennis_score_tracker/widgets/quantity_label.dart';
import 'package:table_tennis_score_tracker/util/game_config.dart';

class CustomGame extends StatefulWidget {
  CustomGame({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _CustomGame createState() => _CustomGame();
}

class _CustomGame extends State<CustomGame> {
  final GameSetting _gameSetting = GameSetting.setDefault();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.only(left: 50, right: 50),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 30,
                child: Row(
                  //Title
                ),
              ),
              Expanded(
                flex: 40,
                child: Container(
                  margin: EdgeInsets.only(top: 50, bottom: 50),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 60,
                        child: Column(
                          children: <Widget>[
                            QuantityLabel(label: 'Winner at Best of'),
                            QuantityLabel(label: 'Winning Point'),
                            QuantityLabel(label: 'Number of Serves'),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 40,
                        child: Container(
                          margin: EdgeInsets.only(),
                          child: Column(
                            children: <Widget>[
                              QuantityController(callSetFunc: _gameSetting.setNumberOfGames),
                              QuantityController(callSetFunc: _gameSetting.setMaxPoints),
                              QuantityController(callSetFunc: _gameSetting.setNumberOfServes),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 30,
                child: OutlinedButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChooseServer(
                        title: widget.title,
                        gameSetting: _gameSetting,
                      )),
                    );
                  },
                  child: Text('Create Game'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
Flexible(
                                fit: FlexFit.tight,
                                flex: 1,
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: InkWell(
                                              child: Icon(Icons.remove),
                                              onTap: (){
                                                setState(() {
                                                  if (int.parse(_valueController.text) > 1) {
                                                    _numberOfGames--;
                                                    _valueController.text = _numberOfGames.toString();
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                          Flexible(
                                            fit: FlexFit.tight,
                                            flex: 1,
                                            child: TextField(
                                              controller: _valueController,
                                              keyboardType: TextInputType.number,
                                              textAlign: TextAlign.center,
                                              onChanged: (String inputValue){
                                                setState(() {
                                                  _numberOfGames = int.parse(inputValue);
                                                });
                                              },
                                              onSubmitted: (String inputValue){
                                                setState(() {
                                                  _numberOfGames = int.parse(inputValue);
                                                });
                                              },
                                              inputFormatters: [
                                                FilteringTextInputFormatter.allow(RegExp(r'[1-9][0-9]*')),
                                                NumericalRangeFormatter(min: 1, max: 100),
                                              ],
                                            ),
                                          ),
                                          Flexible(child: InkWell(
                                            child: Icon(Icons.add),
                                            onTap: (){
                                              setState(() {
                                                if (int.parse(_valueController.text) < 100) {
                                                  _numberOfGames++;
                                                  _valueController.text = _numberOfGames.toString();
                                                }
                                              });
                                            },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
 */