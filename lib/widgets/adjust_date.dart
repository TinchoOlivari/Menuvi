import 'package:intl/intl.dart';

String hoyFecha = DateFormat('dd-MM').format(DateTime.now());
String diaHoy = toBeginningOfSentenceCase(DateFormat('EEEE','es_ES').format(DateTime.now()));

final DateTime hoy = DateTime.now();
String fLunes;
String fMartes;
String fMiercoles;
String fJueves;
String fViernes;

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
}