import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menuvi/widgets/multimenu.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
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
            child: Container(
              padding: EdgeInsets.only(top: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  AppBar(
                    title: Text(
                      'Menuvi',
                      style: TextStyle(fontSize: 29),
                    ),
                    centerTitle: true,
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                  ),
                  Expanded(
                    child: Container(
                      child: MultiMenu(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
