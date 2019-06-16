import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuvi/widgets/loading.dart';

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

class DailyMenu extends StatefulWidget {
  @override
  _DailyMenuState createState() => _DailyMenuState();
}

class _DailyMenuState extends State<DailyMenu> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 30),
      child: Align(
        alignment: Alignment.center,
        child: menuCreator(),
      ),
    );
  }
}

menuCreator() {
  Future<DataSnapshot> databaseReference =
      FirebaseDatabase.instance.reference().child(fechaHoy).once();
  return Container(
    child: Material(
      color: Colors.white,
      elevation: 2.0,
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Column(
                    children: <Widget>[
                      Text(translateWeekday(),
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.w300)),
                      Text(
                        fechaHoy,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 70.0, right: 70.0),
              child: Divider(
                color: Colors.grey,
                height: 10,
              ),
            ),
            FutureBuilder(
                future: databaseReference.then((DataSnapshot snapshot) {
              principal = snapshot.value['principal'].toString();
            }), builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  child: Text(principal,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.w500,
                      )),
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                );
              } else {
                return Loading();
              }
            }),
            FutureBuilder(
                future: databaseReference.then((DataSnapshot snapshot) {
              opcion = snapshot.value['opcion'].toString();
            }), builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  child: Text(opcion,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey
                      )),
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                );
              } else {
                return Container();
              }
            }),
            Container(
              child: svgIconMagdalena,
              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
            ),
            FutureBuilder(future: databaseReference.then(
              (DataSnapshot snapshot) {
                p_1 = snapshot.value['p_1'].toString();
                p_2 = snapshot.value['p_2'].toString();
                p_3 = snapshot.value['p_3'].toString();
              },
            ), builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  children: <Widget>[
                    Text(
                      p_1,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(1)),
                    Text(
                      p_2,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(1)),
                    Text(
                      p_3,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(1)),
                  ],
                );
              } else {
                return Loading();
              }
            }),
            Container(
              child: svgIconSopa,
              padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
            ),
            FutureBuilder(
                future: databaseReference.then((DataSnapshot snapshot) {
              sopa = snapshot.value['sopa'].toString();
            }), builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    sopa,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                );
              } else {
                return Loading();
              }
            }),
          ],
        ),
      ),
    ),
  );
}

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