import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

Future<DataSnapshot> databaseReference =
    FirebaseDatabase.instance.reference().once();

class MultiMenu extends StatefulWidget {
  @override
  _MultiMenuState createState() => _MultiMenuState();
}

class _MultiMenuState extends State<MultiMenu> {
  @override
  void initState() {
    super.initState();
  }

  List<Menu> menus = new List<Menu>();

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
          List<Widget> list = new List<Widget>();
          for (var i = 0; i < menus.length; i++) {
            list.add(new Text(menus[i].principal));
          }
          return new Column(children: list);
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
