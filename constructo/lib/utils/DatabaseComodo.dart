import 'package:constructo/models/comodo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DataBaseComodo {
  static String createDataBase =
      "CREATE TABLE comodos(id INTEGER PRIMARY KEY, titulo TEXT, descricao TEXT, valorTotal REAL, tipoComodo TEXT)";
  static String insertDataBase =
      "INSERT INTO Test(id, titulo, descricao, valor, tipoComodo) VALUES(?, ?, ?, ?, ?)";
  static String nomeDataBase = "comodos.db";
  static String nomeTabela = "comodos";

  Future<Database> _getdatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), nomeDataBase),
      onCreate: (db, version) {
        db.execute(createDataBase);
      },
      version: 1,
    );
  }

  Future criar(Comodo novoComodo) async {
    try {
      final Database db = await _getdatabase();
      await db.insert(
        nomeTabela,
        novoComodo.toMap(),
      );
    } catch (ex) {
      print(ex);
      return;
    }
  }

  Future<List<Comodo>> getComodo() async {
    try {
      final Database db = await _getdatabase();
      final List<Map<String, dynamic>> maps = await db.query(nomeTabela);

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

  Future atualizar(Comodo atualizarComodo) async {
    final Database db = await _getdatabase();
    await db.update(nomeTabela, atualizarComodo.toMap(),
        where: "id = ?", whereArgs: [atualizarComodo.id]);
  }

  Future deletar(Comodo deletarComodo) async {
    final Database db = await _getdatabase();
    await db.delete(nomeTabela, where: "id = ?", whereArgs: [deletarComodo.id]);
  }
}
