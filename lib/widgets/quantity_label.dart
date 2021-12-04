import 'package:flutter/material.dart';

class QuantityLabel extends StatefulWidget {
  QuantityLabel({Key? key, required this.label}) : super(key: key);

  final String label;

  @override
  _QuantityLabel createState() => _QuantityLabel();
}

class _QuantityLabel extends State<QuantityLabel> {

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.label,
          ),
        ],
      ),
    );
  }
}