

class Comodo{
  final int id;
  final String titulo;
  final String descricao;
  final double valorTotal;
  final String tipoComodo;

  Comodo({
    this.id,
    this.titulo,
    this.descricao,
    this.valorTotal,
    this.tipoComodo,
  });

  Map <String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'valorTotal': valorTotal,
      'tipoComodo': tipoComodo
    };
  }

}