import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';
import 'package:intl/date_symbol_data_local.dart';
import 'package:menuvi/widgets/loading.dart';

Future<DataSnapshot> databaseReference =
    FirebaseDatabase.instance.reference().once();
final _controller = PageController();
List<Menu> menus = List<Menu>();

String hoyFecha = DateFormat('dd-MM').format(DateTime.now());
String diaHoy = toBeginningOfSentenceCase(DateFormat('EEEE','es_ES').format(DateTime.now()));

final Widget svgIconMagdalena = SvgPicture.asset(
  "lib/assets/Magdalena.svg",
  width: 40,
);
final Widget svgIconSopa = SvgPicture.asset(
  "lib/assets/Sopa.svg",
  width: 40,
);

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
  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting("es_AR", null);
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
                menus.add(Menu.isNull(key, value['dia'], true));
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
            if (menus[i].isNull == true) {
              list.add(Container(
                padding: EdgeInsets.fromLTRB(25, 25, 25, 5),
                child: Material(
                  color: Colors.grey[250],
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
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Column(
                                children: <Widget>[
                                  Text(menus[i].dia,
                                      style: TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.w300)),
                                  Text(
                                    menus[i].fecha,
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin:
                              const EdgeInsets.only(left: 70.0, right: 70.0),
                          child: Divider(
                            color: Colors.grey,
                            height: 10,
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.all(50),
                              child: Text(
                                "Menu no disponible",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 45,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
            } else {
              list.add(Container(
                padding: EdgeInsets.fromLTRB(25, 25, 25, 5),
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
                                  Text(menus[i].dia,
                                      style: TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.w300)),
                                  Text(
                                    menus[i].fecha,
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin:
                              const EdgeInsets.only(left: 70.0, right: 70.0),
                          child: Divider(
                            color: Colors.grey,
                            height: 10,
                          ),
                        ),
                        Container(
                          child: Text(menus[i].principal,
                              maxLines: 3,
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
                        Container(
                          child: svgIconMagdalena,
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
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
                          child: svgIconSopa,
                          padding: EdgeInsets.fromLTRB(0, 15, 0, 5),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 15),
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
          if (list.length == 0){
            list.add(Container(
              padding: EdgeInsets.fromLTRB(25, 25, 25, 5),
              child: Material(
                color: Colors.grey[250],
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
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Column(
                              children: <Widget>[
                                Text(diaHoy,
                                    style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.w300)),
                                Text(
                                  hoyFecha,
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin:
                        const EdgeInsets.only(left: 70.0, right: 70.0),
                        child: Divider(
                          color: Colors.grey,
                          height: 10,
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.all(50),
                            child: Text(
                              "Los menus de esta semana no estan disponibles",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 45,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
          } else {
            initialPage();
          }
          return Column(
            children: <Widget>[
              Expanded(
                child: PageView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: list.length,
                  controller: _controller,
                  itemBuilder: (BuildContext context, int index) {
                    return list[index % list.length];
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Center(
                  child: DotsIndicator(
                    controller: _controller,
                    itemCount: list.length,
                    onPageSelected: (int page) {
                      _controller.animateToPage(
                        page,
                        duration: _kDuration,
                        curve: _kCurve,
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        }
      }),
    ));
  }
}

initialPage() async {
  var indexado = await menus
      .indexOf(menus.where((menus) => menus.fecha == hoyFecha).first);
  await _controller.jumpToPage(indexado);
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

  Menu.isNull(this.fecha, this.dia, this.isNull);
}

class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    this.controller,
    this.itemCount,
    this.onPageSelected,
  }) : super(listenable: controller);
  final PageController controller;
  final int itemCount;
  final ValueChanged<int> onPageSelected;
  final Color color = Colors.white;
  static const double _kDotSize = 8.0;
  static const double _kMaxZoom = 1.7;
  static const double _kDotSpacing = 25.0;

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;
    return Container(
      height: 20,
      width: _kDotSpacing,
      child: Center(
        child: Material(
          color: color,
          type: MaterialType.circle,
          child: Container(
            width: _kDotSize * zoom,
            height: _kDotSize * zoom,
            child: InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(itemCount, _buildDot),
    );
  }
}
