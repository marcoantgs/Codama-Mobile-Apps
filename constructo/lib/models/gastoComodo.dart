class GastoComodo {
  int id;
  String titulo;
  double valor;
 

  GastoComodo(
    this.id,
    this.titulo,
    this.valor,

  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'valor': valor,

    };
  }

  GastoComodo.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    titulo = map['titulo'];
    valor = map['valor'];

  }
}
