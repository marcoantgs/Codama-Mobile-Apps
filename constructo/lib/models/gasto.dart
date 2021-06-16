class Gasto {
  int id;
  String titulo;
  double valor;
  int comodo;

  Gasto(
    this.id,
    this.titulo,
    this.valor,
    this.comodo,
  );

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'valor': valor,
      'comodo': comodo,
    };
  }

  Gasto.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    titulo = map['titulo'];
    valor = map['valor'];
    comodo = map['comodo'];
  }
}
