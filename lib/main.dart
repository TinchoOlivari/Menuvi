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
      home: ScrollConfiguration(behavior: MyBehavior(), child: MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController rotationController;

  @override
  void initState() {
    rotationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          body: Container(
            child: CustomPaint(
              painter: ShapesPainter(),
              child: Container(
                padding: EdgeInsets.only(top: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    AppBar(
                      title: Text(
                        'Menuvi',
                        style: TextStyle(fontSize: 29),
                      ),
                      actions: <Widget>[
                        Container(
                          child: RotationTransition(
                            turns: Tween(begin: 0.0, end: 1.0)
                                .animate(rotationController),
                            alignment: Alignment.center,
                            child: IconButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              icon: Icon(Icons.refresh),
                              iconSize: 29,
                              color: Colors.white,
                              alignment: Alignment.center,
                              onPressed: () {
                                setState(() {
                                  rotationController.forward(from: 0.0);
                                  MultiMenu();
                                });
                              },
                            ),
                          ),
                          padding: EdgeInsets.only(right: 25),
                        ),
                      ],
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
        ),
      ],
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class ShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Color.fromARGB(255, 57, 153, 142);
    var rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(rect, paint);

    paint.color = Color.fromARGB(255, 42, 107, 109);
    var path = Path();
    path.lineTo(0, 400);
    path.lineTo(size.width, 280);
    path.lineTo(size.width, 0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
