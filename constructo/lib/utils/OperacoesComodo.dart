import 'package:constructo/models/comodo.dart';
import 'package:constructo/utils/DatabaseConstructo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class OperacoesComodo {
  final dbProvider = DataBaseConstructo.instance;

  static String nomeTabelaComodos = "comodos";

//Insere um objeto comodo no banco de dados
  Future inserir(Comodo novoComodo) async {
    try {
      final Database db = await dbProvider.getdatabase();
      await db.insert(
        nomeTabelaComodos,
        novoComodo.toMap(),
      );
    } catch (ex) {
      print(ex);
      return;
    }
  }

//Obtem os comodos cadastrados no banco de dados e retorna uma lista com os mesmos
  Future<List<Comodo>> getComodos() async {
    try {
      final Database db = await dbProvider.getdatabase();
      final List<Map<String, dynamic>> maps = await db.query(nomeTabelaComodos);

      return List.generate(
        maps.length,
        (i) {
          return Comodo.fromMap(maps[i]);
        },
      );
    } catch (ex) {
      print(ex);
      return new List<Comodo>();
    }
  }

//Atualiza o objeto comodo e salva no banco de dados
  Future atualizar(Comodo atualizarComodo) async {
    final Database db = await dbProvider.getdatabase();
    await db.update(nomeTabelaComodos, atualizarComodo.toMap(),
        where: "id = ?", whereArgs: [atualizarComodo.id]);
  }

//Deleta um objeto comodo do banco de dados
  Future deletar(Comodo deletarComodo) async {
    final Database db = await dbProvider.getdatabase();
    await db.delete(nomeTabelaComodos,
        where: "id = ?", whereArgs: [deletarComodo.id]);
  }
}
