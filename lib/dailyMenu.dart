import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:menuvi/widgets/loading.dart';

String principal = '';
String opcion = '';
String p_1 = '';
String p_2 = '';
String p_3 = '';
String sopa = '';

String fechaHoy = new DateFormat('dd-MM').format(DateTime.now());
String diaHoy = new DateFormat('EEEE').format(DateTime.now());
Future<DataSnapshot> databaseReference =
    FirebaseDatabase.instance.reference().child(fechaHoy).once();

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
    if (DateTime.now().weekday == 6 || DateTime.now().weekday == 2) {
      return Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 30),
        child: Align(
          alignment: Alignment.center,
          child: NoMenu(),
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 30),
        child: Align(
          alignment: Alignment.center,
          child: MenuCreator(),
        ),
      );
    }
  }
}

class MenuCreator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  if (principal == 'null') {
                    return Container(
                      child: Text('Plato principal no disponible',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 45,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.italic)),
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                    );
                  } else {
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
                  }
                } else {
                  return Loading();
                }
              }),
              FutureBuilder(
                  future: databaseReference.then((DataSnapshot snapshot) {
                opcion = snapshot.value['opcion'].toString();
              }), builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (opcion == 'null') {
                    return Container(
                      child: Text('Plato opcional no disponible',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey)),
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                    );
                  } else {
                    return Container(
                      child: Text(
                        opcion,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      ),
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    );
                  }
                } else {
                  return Container();
                }
              }),
              Container(
                child: svgIconMagdalena,
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
              ),
              FutureBuilder(
                future: databaseReference.then(
                  (DataSnapshot snapshot) {
                    p_1 = snapshot.value['p_1'].toString();
                    p_2 = snapshot.value['p_2'].toString();
                    p_3 = snapshot.value['p_3'].toString();
                  },
                ),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (p_1 == 'null') {
                      return Container(
                        child: Text('Postres \nno disponibles',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 25, fontStyle: FontStyle.italic)),
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                      );
                    } else {
                      return Column(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.all(1)),
                          Text(
                            p_1,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
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
                    }
                  } else {
                    return Loading();
                  }
                },
              ),
              Container(
                child: svgIconSopa,
                padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
              ),
              FutureBuilder(
                  future: databaseReference.then((DataSnapshot snapshot) {
                sopa = snapshot.value['sopa'].toString();
              }), builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (opcion == 'null') {
                    return Container(
                      child: Text('Sopa no disponible',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30, fontStyle: FontStyle.italic)),
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                    );
                  } else {
                    return Container(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text(
                        "Sopa de " + sopa.toLowerCase(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    );
                  }
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
}

class NoMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: Colors.white,
        elevation: 2.0,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
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
              Container(
                height: 350,
                alignment: Alignment.center,
                child: Text(
                  "No hay menu disponible",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
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
