import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:table_tennis_score_tracker/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Set the App to only show the bottom bar and hide the top status bar.
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MaterialApp(
      title: 'Score Tracker (Table Tennis)',
      theme: ThemeData(primarySwatch: Colors.green),
      home: MyHomePage(title: 'Score Tracker (Table Tennis)'),
      debugShowCheckedModeBanner: false,
    );
  }
}
