import 'package:constructo/models/comodo.dart';
import 'package:constructo/models/gasto.dart';
import 'package:constructo/utils/DatabaseConstructo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class OperacoesGasto {
  final dbProvider = DataBaseConstructo.instance;
  static String nomeTabela = "gastos";

//Insere um objeto gasto no banco de dados
  Future inserir(Gasto novoGasto) async {
    try {
      final Database db = await dbProvider.getdatabase();
      await db.insert(
        nomeTabela,
        novoGasto.toMap(),
      );
    } catch (ex) {
      print(ex);
      return;
    }
  }

//Obtem os gastos cadastrados no banco de dados com a respectiva foreign key e retorna uma lista com os mesmos
  Future<List<Gasto>> getGastos(Comodo comodo) async {
    try {
      final Database db = await dbProvider.getdatabase();
      final List<Map<String, dynamic>> maps = await db.rawQuery(
          "SELECT * FROM " + nomeTabela + " WHERE comodo = ${comodo.id}");

      return List.generate(
        maps.length,
        (i) {
          return Gasto.fromMap(maps[i]);
        },
      );
    } catch (ex) {
      print(ex);
      return new List<Gasto>();
    }
  }

//Atualiza o objeto gasto e salva no banco de dados
  Future atualizar(Gasto atualizarGasto) async {
    final Database db = await dbProvider.getdatabase();
    await db.update(nomeTabela, atualizarGasto.toMap(),
        where: "id = ?", whereArgs: [atualizarGasto.id]);
  }

//Deleta um objeto gasto do banco de dados
  Future deletar(Gasto deletarGasto) async {
    final Database db = await dbProvider.getdatabase();
    await db.delete(nomeTabela, where: "id = ?", whereArgs: [deletarGasto.id]);
  }
}
