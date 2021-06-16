import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DataBaseConstructo {
  DataBaseConstructo.privateConstructor();

  static final DataBaseConstructo instance =
      DataBaseConstructo.privateConstructor();

  static String criarTabelaComodos =
      "CREATE TABLE comodos(id INTEGER PRIMARY KEY, titulo TEXT NOT NULL, descricao TEXT, valorTotal REAL, tipoComodo TEXT NOT NULL)";
  static String criarTabelaGastos =
      "CREATE TABLE gastos(id INTEGER PRIMARY KEY AUTOINCREMENT, titulo TEXT NOT NULL, valor REAL NOT NULL, comodo INTEGER NOT NULL, FOREIGN KEY(comodo) REFERENCES comodos(id))";
  static String nomeDataBase = "constructo.db";

  //Cria o banco de dados caso não exista e caso exista pega o caminho do mesmo
  Future<Database> getdatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), nomeDataBase),
      //Cria as tabelas do banco de dados
      onCreate: (db, version) {
        db.execute(criarTabelaComodos);
        db.execute(criarTabelaGastos);
      },
      version: 1,
    );
  }
}
