import 'dart:convert';

Comodo userFromJson(String str) => Comodo.fromJson(json.decode(str));
String userToJson(Comodo data) =>json.encode(data.toJson());

class Comodo{
  final String id;
  final String titulo;
  final String descricao;
  final double valorTotal;

  Comodo({
    this.id,
    this.titulo,
    this.descricao,
    this.valorTotal
  });

  factory Comodo.fromJson(Map<String, dynamic> json) => Comodo(
    id: json["id"],
    titulo: json["titulo"],
    descricao: json["descricao"]
  );

  Map<String, dynamic> toJson() =>{
    "id": id,
    "titulo": titulo,
    "descricao": descricao
  };
  
}