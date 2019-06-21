import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

Future<DataSnapshot> databaseReference =
FirebaseDatabase.instance.reference().once();

List<Menu> menus = List<Menu>();

class MultiMenu extends StatefulWidget {
  @override
  _MultiMenuState createState() => _MultiMenuState();
}

class _MultiMenuState extends State<MultiMenu> {
  @override
  void initState() {
    super.initState();
  }
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return (Container(
      child: FutureBuilder(
        future: databaseReference.then(
              (DataSnapshot snapshot) {
            snapshot.value.forEach((key, value) {
              menus.add(Menu(key, value['principal'], value['opcion'],
                  value['p_1'], value['p_2'], value['p_3'], value['sopa']));
            });
            menus.sort((a, b) => a.fecha.compareTo(b.fecha));
          },
        ),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          List<Widget> list = List<Widget>();
          for (var i = 0; i < menus.length; i++) {
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
          return Container(
            child: PageView(
                controller: controller,
                scrollDirection: Axis.horizontal,
                children: list),
          );
        },
      ),
    ));
  }
}

class Menu {
  String fecha;
  String principal;
  String opcion;
  String p_1;
  String p_2;
  String p_3;
  String sopa;

  Menu(this.fecha, this.principal, this.opcion, this.p_1, this.p_2, this.p_3,
      this.sopa);
}
