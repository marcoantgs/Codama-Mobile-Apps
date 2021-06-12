import 'package:constructo/models/comodo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DataBaseComodo {
  static String criarTabela =
      "CREATE TABLE comodos(id INTEGER PRIMARY KEY, titulo TEXT, descricao TEXT, valorTotal REAL, tipoComodo TEXT)";
  static String nomeDataBase = "constructo.db";
  static String nomeTabela = "comodos";

//Cria o banco de dados caso não exista e caso exista pega o caminho do mesmo
  Future<Database> _getdatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), nomeDataBase),
      onCreate: (db, version) {
        db.execute(criarTabela);
      },
      version: 1,
    );
  }

//Insere um objeto comodo no banco de dados
  Future inserir(Comodo novoComodo) async {
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

//Obtem os comodos cadastrados no banco de dados e retorna uma lista com os mesmos
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

//Atualiza o objeto comodo e salva no banco de dados
  Future atualizar(Comodo atualizarComodo) async {
    final Database db = await _getdatabase();
    await db.update(nomeTabela, atualizarComodo.toMap(),
        where: "id = ?", whereArgs: [atualizarComodo.id]);
  }

//Deleta um objeto comodo do banco de dados
  Future deletar(Comodo deletarComodo) async {
    final Database db = await _getdatabase();
    await db.delete(nomeTabela, where: "id = ?", whereArgs: [deletarComodo.id]);
  }
}
