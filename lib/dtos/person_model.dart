class Person {
  final String name;
  final String faculty;
  final String email;
  final String password;
    int? edad;
  String? descripcion;
  String? genero;
  String? imagen;

  Person({
    required this.name,
    required this.faculty,
    required this.email,
    required this.password,
    this.edad,
    this.descripcion,
    this.genero,
    this.imagen
  });
}