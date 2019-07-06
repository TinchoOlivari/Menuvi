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