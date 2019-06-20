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

  getMenus() async {
    await databaseReference.then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> menuMap = snapshot.value;
      menuMap.forEach((key, value) {
        menus.add(Menu(key, value['principal']));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return (Container(
      child: FutureBuilder(
        future: databaseReference.then(
          (DataSnapshot snapshot) {
            Map<dynamic, dynamic> menuMap = snapshot.value;
            menuMap.forEach((key, value) {
              menus.add(Menu(key, value['principal']));
            });
          },
        ),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
              itemCount: menus.length,
              itemBuilder: (context, index) {
                final items = menus[index];
                return Container(
                  padding: EdgeInsets.all(30),
                  child: Material(
                    color: Colors.white,
                    elevation: 2.0,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    child: Container(
                      child: Text(items.principal,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.w500,
                          )),
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                    ),
                  ),
                );
              });
        },
      ),
    ));
  }
}

class Menu {
  String fecha;
  String principal;

  Menu(this.fecha, this.principal);
}
