import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';

String principal = '';
String opcion = '';
String p_1 = '';
String p_2 = '';
String p_3 = '';
String sopa = '';

String fechaHoy = new DateFormat('dd-MM').format(DateTime.now());
String diaHoy = new DateFormat('EEEE').format(DateTime.now());

final Widget svgIconMagdalena = SvgPicture.asset(
  "lib/assets/Magdalena.svg",
  width: 40,
);

final Widget svgIconSopa = SvgPicture.asset(
  "lib/assets/Sopa.svg",
  width: 40,
);

translateWeekday() {
  if (DateTime.now().weekday == 1) {
    diaHoy = 'Lunes';
  }
  if (DateTime.now().weekday == 2) {
    diaHoy = 'Martes';
  }
  if (DateTime.now().weekday == 3) {
    diaHoy = 'Miercoles';
  }
  if (DateTime.now().weekday == 4) {
    diaHoy = 'Jueves';
  }
  if (DateTime.now().weekday == 5) {
    diaHoy = 'Viernes';
  }
  if (DateTime.now().weekday == 6) {
    diaHoy = 'Sabado';
  }
  if (DateTime.now().weekday == 7) {
    diaHoy = 'Domingo';
  }
  return diaHoy;
}

class DailyMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(DateTime.now());
    return Container(
      padding: EdgeInsets.fromLTRB(20, 100, 20, 30),
      child: Center(
        child: menuCreator(),
      ),
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
    );
  }
}

menuCreator() {
  return FutureBuilder(
    future: FirebaseDatabase.instance
        .reference()
        .child('diaHoy')
        .once()
        .then((DataSnapshot snapshot) {
      principal = snapshot.value['principal'].toString();
      opcion = snapshot.value['opcion'].toString();
      sopa = snapshot.value['sopa'].toString();
      p_1 = snapshot.value['p_1'].toString();
      p_2 = snapshot.value['p_2'].toString();
      p_3 = snapshot.value['p_3'].toString();
    }),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        return Container(
          child: Material(
            color: Colors.white,
            elevation: 2.0,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 25, 0, 5),
                      child: Column(
                        children: <Widget>[
                          Text(translateWeekday(),
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w300)),
                          Text(fechaHoy,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                  fontStyle: FontStyle.italic)),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 70.0, right: 70.0),
                  child: Divider(
                    color: Colors.black,
                    height: 10,
                  ),
                ),
                Container(
                  child: Text(principal,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      )),
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                ),
                Container(
                  child: Text(opcion,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w400,
                      )),
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                ),
                Container(
                  child: svgIconMagdalena,
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                ),
                Column(
                  children: <Widget>[
                    Text(
                      p_1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 19,
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(1)),
                    Text(
                      p_2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 19,
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(1)),
                    Text(
                      p_3,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 19,
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(1)),
                  ],
                ),
                Container(
                  child: svgIconSopa,
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    sopa,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 19,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return new CircularProgressIndicator();
      }
    },
  );
}
