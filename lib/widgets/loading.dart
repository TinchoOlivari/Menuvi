import 'package:menuvi/widgets/color_loader_5.dart';
import 'package:menuvi/widgets/dot_type.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 40, 0, 40),
      child: ColorLoader5(
        dotOneColor: Colors.grey,
        dotTwoColor: Colors.grey,
        dotThreeColor: Colors.grey,
        dotType: DotType.circle,
        dotIcon: Icon(Icons.adjust),
        duration: Duration(milliseconds: 700),
      ),
    );
  }
}
