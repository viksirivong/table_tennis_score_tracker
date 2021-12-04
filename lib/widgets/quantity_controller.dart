import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuantityController extends StatefulWidget {
  QuantityController({Key? key, required this.callSetFunc}) : super(key: key);

  final void Function(int) callSetFunc;

  @override
  _QuantityController createState() => _QuantityController();
}

class _QuantityController extends State<QuantityController> {
  final _valueController = TextEditingController(text: '0');
  int _tempValue = 0;

  @override
  Widget build(BuildContext context) {
    return Flexible(
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
                          _tempValue--;
                          _valueController.text = _tempValue.toString();
                          widget.callSetFunc(_tempValue);
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
                        _tempValue = int.parse(inputValue);
                        widget.callSetFunc(_tempValue);
                      });
                    },
                    onSubmitted: (String inputValue){
                      setState(() {
                        _tempValue = int.parse(inputValue);
                        widget.callSetFunc(_tempValue);
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
                        _tempValue++;
                        _valueController.text = _tempValue.toString();
                        widget.callSetFunc(_tempValue);
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
    );
  }
}

class NumericalRangeFormatter extends TextInputFormatter {
  NumericalRangeFormatter({required this.min, required this.max});

  final int min;
  final int max;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {

    if (newValue.text == '') {
      return newValue;
    } else if (int.parse(newValue.text) < min) {
      return TextEditingValue().copyWith(text: min.toString());
    } else {
      return int.parse(newValue.text) > max ? oldValue : newValue;
    }
  }
}