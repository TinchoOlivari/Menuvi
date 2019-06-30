import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_indicator/page_indicator.dart';

Future<DataSnapshot> databaseReference =
    FirebaseDatabase.instance.reference().once();

List<Menu> menus = List<Menu>();

PageController controller = PageController();

final DateTime hoy = DateTime.now();
String fLunes;
String fMartes;
String fMiercoles;
String fJueves;
String fViernes;

class MultiMenu extends StatefulWidget {
  @override
  _MultiMenuState createState() => _MultiMenuState();
}

class _MultiMenuState extends State<MultiMenu> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    adjustDate();
    return (Container(
      child: FutureBuilder(future: databaseReference.then(
        (DataSnapshot snapshot) {
          snapshot.value.forEach((key, value) {
            if (key == fLunes ||
                key == fMartes ||
                key == fMiercoles ||
                key == fJueves ||
                key == fViernes) {
              if (value['isNull'] == true) {
                menus.add(Menu.isNull(key, true));
              } else {
                menus.add(Menu(
                    key,
                    value['dia'],
                    value['principal'],
                    value['opcion'],
                    value['p_1'],
                    value['p_2'],
                    value['p_3'],
                    value['sopa']));
              }
            }
          });
          menus.sort((a, b) => a.fecha.compareTo(b.fecha));
        },
      ), builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<Widget> list = List<Widget>();
        if (snapshot.connectionState == ConnectionState.done) {
          for (var i = 0; i < menus.length; i++) {
            if(menus[i].isNull == true){
              list.add(Container(
                padding: EdgeInsets.all(20),
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
                        Container(
                          child: Text(menus[i].fecha,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 25,
                              )),
                        ),
                        Container(
                          child: Text("Hoy no hay menu lince",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 45,
                                fontWeight: FontWeight.w500,
                              )),
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
            } else {
              list.add(Container(
                padding: EdgeInsets.all(20),
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
                        Container(
                          child: Text(menus[i].dia,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 25,
                              )),
                        ),
                        Container(
                          child: Text(menus[i].fecha,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 25,
                              )),
                        ),
                        Container(
                          child: Text(menus[i].principal,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 45,
                                fontWeight: FontWeight.w500,
                              )),
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                        ),
                        Container(
                          child: Text(
                            menus[i].opcion,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey),
                          ),
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        ),
                        Column(
                          children: <Widget>[
                            Padding(padding: EdgeInsets.all(1)),
                            Text(
                              menus[i].p_1,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                            Text(
                              menus[i].p_2,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                            Padding(padding: EdgeInsets.all(1)),
                            Text(
                              menus[i].p_3,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                            Padding(padding: EdgeInsets.all(1)),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Text(
                            "Sopa de " + menus[i].sopa.toLowerCase(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
            }
          }
          //initialPage();
          return Container(
            child: PageIndicatorContainer(
              pageView: PageView(
                  controller: controller,
                  scrollDirection: Axis.horizontal,
                  children: list),
              align: IndicatorAlign.bottom,
              length: list.length,
              indicatorSpace: 20.0,
              padding: const EdgeInsets.all(10),
              indicatorColor: Colors.transparent,
              indicatorSelectorColor: Colors.blue,
              shape: IndicatorShape.circle(size: 12),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
      }),
    ));
  }
}

initialPage() async {
  String hoyFecha = DateFormat('dd-MM').format(DateTime.now());
  var indexado = await menus
      .indexOf(menus.where((menus) => menus.fecha == hoyFecha).first);
  controller.jumpToPage(indexado);
}

adjustDate() async {
  if (hoy.weekday == 1) {
    fLunes = await DateFormat('dd-MM').format(hoy);
    fMartes = await DateFormat('dd-MM').format(hoy.add(Duration(days: 1)));
    fMiercoles = await DateFormat('dd-MM').format(hoy.add(Duration(days: 2)));
    fJueves = await DateFormat('dd-MM').format(hoy.add(Duration(days: 3)));
    fViernes = await DateFormat('dd-MM').format(hoy.add(Duration(days: 4)));
  } else if (hoy.weekday == 2) {
    fLunes = await DateFormat('dd-MM').format(hoy.subtract(Duration(days: 1)));
    fMartes = await DateFormat('dd-MM').format(hoy);
    fMiercoles = await DateFormat('dd-MM').format(hoy.add(Duration(days: 1)));
    fJueves = await DateFormat('dd-MM').format(hoy.add(Duration(days: 2)));
    fViernes = await DateFormat('dd-MM').format(hoy.add(Duration(days: 3)));
  } else if (hoy.weekday == 3) {
    fLunes = await DateFormat('dd-MM').format(hoy.subtract(Duration(days: 2)));
    fMartes = await DateFormat('dd-MM').format(hoy.subtract(Duration(days: 1)));
    fMiercoles = await DateFormat('dd-MM').format(hoy);
    fJueves = await DateFormat('dd-MM').format(hoy.add(Duration(days: 1)));
    fViernes = await DateFormat('dd-MM').format(hoy.add(Duration(days: 2)));
  } else if (hoy.weekday == 4) {
    fLunes = await DateFormat('dd-MM').format(hoy.subtract(Duration(days: 3)));
    fMartes = await DateFormat('dd-MM').format(hoy.subtract(Duration(days: 2)));
    fMiercoles =
        await DateFormat('dd-MM').format(hoy.subtract(Duration(days: 1)));
    fJueves = await DateFormat('dd-MM').format(hoy);
    fViernes = await DateFormat('dd-MM').format(hoy.add(Duration(days: 1)));
  } else if (hoy.weekday == 5) {
    fLunes = await DateFormat('dd-MM').format(hoy.subtract(Duration(days: 4)));
    fMartes = await DateFormat('dd-MM').format(hoy.subtract(Duration(days: 3)));
    fMiercoles =
        await DateFormat('dd-MM').format(hoy.subtract(Duration(days: 2)));
    fJueves = await DateFormat('dd-MM').format(hoy.subtract(Duration(days: 1)));
    fViernes = await DateFormat('dd-MM').format(hoy);
  } else if (hoy.weekday == 6) {
    fLunes = await DateFormat('dd-MM').format(hoy.add(Duration(days: 2)));
    fMartes = await DateFormat('dd-MM').format(hoy.add(Duration(days: 3)));
    fMiercoles = await DateFormat('dd-MM').format(hoy.add(Duration(days: 4)));
    fJueves = await DateFormat('dd-MM').format(hoy.add(Duration(days: 5)));
    fViernes = await DateFormat('dd-MM').format(hoy.add(Duration(days: 6)));
  } else if (hoy.weekday == 7) {
    fLunes = await DateFormat('dd-MM').format(hoy.add(Duration(days: 1)));
    fMartes = await DateFormat('dd-MM').format(hoy.add(Duration(days: 2)));
    fMiercoles = await DateFormat('dd-MM').format(hoy.add(Duration(days: 3)));
    fJueves = await DateFormat('dd-MM').format(hoy.add(Duration(days: 4)));
    fViernes = await DateFormat('dd-MM').format(hoy.add(Duration(days: 5)));
  }
  //En este punto tenes todos las fechas que hay que mostrar
  //Lo que sigue es iterar todos los menus y buscarlos
  //Cuando haya coincidencia, se lo agrega a List menus
}

class Menu {
  String fecha;
  String dia;
  String principal;
  String opcion;
  String p_1;
  String p_2;
  String p_3;
  String sopa;
  bool isNull = false;

  Menu(this.fecha, this.dia, this.principal, this.opcion, this.p_1, this.p_2,
      this.p_3, this.sopa);
  
  Menu.isNull(this.fecha, this.isNull);
}
