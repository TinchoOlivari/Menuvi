import 'package:menuvi/widgets/color_loader_5.dart';
import 'package:menuvi/widgets/dot_type.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: ColorLoader5(
        dotOneColor: Colors.white,
        dotTwoColor: Colors.white,
        dotThreeColor: Colors.white,
        dotType: DotType.circle,
        duration: Duration(milliseconds: 1000),
      ),
    );
  }
}
