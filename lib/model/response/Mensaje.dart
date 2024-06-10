
class Mensaje {
  //declarar variables
  String mensaje;
  String tipo;
  //constructor
  Mensaje({required this.mensaje, required this.tipo});
  //metodo para convertir un json a un objeto de tipo mensaje
  factory Mensaje.fromJson(Map<String, dynamic> json) {
    return Mensaje(
      mensaje: json['mensaje'],
      tipo: json['tipo'],
    );
  }
}