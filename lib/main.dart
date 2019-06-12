import 'package:flutter/material.dart';
import 'package:menuvi/dailyMenu.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menuvi',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.pink[400],
                  Colors.yellow[300],
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,              
              children: <Widget>[
                AppBar(
                  title: Text(
                    'Menuvi',
                    style: TextStyle(fontSize: 24),
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                ),
                DailyMenu()
              ],
            ),
          ),
        ),
      ],
    );
  }
}
