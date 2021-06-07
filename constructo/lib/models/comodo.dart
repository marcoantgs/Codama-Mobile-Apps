class Comodo {
  int id;
  String titulo;
  String descricao;
  double valorTotal;
  String tipoComodo;

  Comodo(
    this.id,
    this.titulo,
    this.descricao,
    this.valorTotal,
    this.tipoComodo,
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'valorTotal': valorTotal,
      'tipoComodo': tipoComodo
    };
  }

  Comodo.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    titulo = map['titulo'];
    descricao = map['descricao'];
    valorTotal = map['valorTotal'];
    tipoComodo = map['tipoComodo'];
  }
}
